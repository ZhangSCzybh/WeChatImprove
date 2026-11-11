#import "CSGroupChatManager.h"
#import "CSGroupChatStore.h"
#import "CSGroupChatTemplate.h"
#import "CSGroupChatEventPolicy.h"
#import "CSGroupChatNativeAdapter.h"
#import "CSGroupChatLocalNotice.h"
#import "CSGroupChatRuntime.h"
#import "CSGroupNativeBridge.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSAuthorizationManager.h"
#import "CSBackgroundRunManager.h"
#import <UIKit/UIKit.h>
NSNotificationName const CSGroupChatConfigurationDidChange=@"CSGroupChatConfigurationDidChange";
@interface CSGroupChatManager ()
@property(nonatomic,copy,readwrite) NSString *accountID;
@property(nonatomic,readwrite) NSUInteger accountEpoch,configurationGeneration;
@property(nonatomic,copy,readwrite) NSDictionary *configuration;
@property(nonatomic,readwrite) BOOL ready;
@property(nonatomic,copy,readwrite) NSString *statusText;
@property(nonatomic) BOOL started,loading,saving,enteredBackground,leavingBackground,ingressEnabled;
@property(nonatomic) CSBackgroundRunManager *backgroundRunManager;
@property(nonatomic,copy) void (^backgroundDemand)(BOOL);
@property(nonatomic) dispatch_source_t backgroundRetryTimer;
@property(nonatomic) dispatch_queue_t io;
@property(nonatomic) NSURL *configurationURL;
@property(nonatomic) NSMutableDictionary<NSString *,NSDictionary *> *baselines,*pendingWelcomes;
@property(nonatomic) NSMutableDictionary<NSString *,NSDictionary *> *resumeBaselines,*resumeWelcomes;
@property(nonatomic) NSMutableDictionary<NSString *,NSMutableArray<NSMutableDictionary *> *> *pendingDepartures;
@property(nonatomic) NSMutableDictionary<NSString *,NSMutableDictionary<NSString *,NSDate *> *> *confirmedRemovals;
@property(nonatomic) NSMutableDictionary<NSString *,NSDate *> *requests,*backgroundRefreshResponses;
@property(nonatomic) NSMutableDictionary<NSString *,NSString *> *deferredRequests;
@property(nonatomic) NSMutableSet<NSString *> *autoSaveHandled,*forcedRefreshRooms,*retriedRefreshRooms;
@property(nonatomic) NSDate *sessionStarted,*autoSaveStarted;
@property(nonatomic) CSMessageNativeEnvironment *environment;
@property(nonatomic) CSMessageSendAdapter *sender;
@end
static NSError *ManagerError(NSString *text){return [NSError errorWithDomain:@"CSGroupChatManager" code:1 userInfo:@{NSLocalizedDescriptionKey:text}];}
static char GroupChatBackgroundEnabledContext;
static NSString *const GroupChatLegacyBackgroundKey=@"backgroundRealtimeEnabled";
@implementation CSGroupChatManager
+ (instancetype)sharedManager {static CSGroupChatManager *manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (instancetype)init {
    if((self=[super init])){_accountID=@"";_configuration=CSGroupChatDefaultConfiguration();_statusText=@"正在读取群聊设置…";
        _io=dispatch_queue_create("com.wechat.improve.groupchat.storage",DISPATCH_QUEUE_SERIAL);_baselines=[NSMutableDictionary dictionary];_pendingWelcomes=[NSMutableDictionary dictionary];
        _resumeBaselines=[NSMutableDictionary dictionary];_resumeWelcomes=[NSMutableDictionary dictionary];_confirmedRemovals=[NSMutableDictionary dictionary];_pendingDepartures=[NSMutableDictionary dictionary];
        _requests=[NSMutableDictionary dictionary];_backgroundRefreshResponses=[NSMutableDictionary dictionary];_deferredRequests=[NSMutableDictionary dictionary];_autoSaveHandled=[NSMutableSet set];_forcedRefreshRooms=[NSMutableSet set];_retriedRefreshRooms=[NSMutableSet set];_sessionStarted=NSDate.date;_autoSaveStarted=_sessionStarted;
        _environment=[CSMessageNativeEnvironment new];_sender=[[CSMessageSendAdapter alloc]initWithEnvironment:_environment];}
    return self;
}
- (BOOL)isForeground {
    return !self.enteredBackground && UIApplication.sharedApplication.applicationState==UIApplicationStateActive;
}
- (BOOL)hasBackgroundOpportunity {
    // Executing on the main queue is the opportunity. A suspended process
    // cannot run this code; the plugin's keepalive setting only buys time.
    return self.enteredBackground && self.ready && !self.saving && [self configuredRooms].count;
}
- (BOOL)canRunInRoom:(NSString *)room {
    return [[self configuredRooms] containsObject:room] ||
        (!self.enteredBackground && [self.configuration[@"autoSaveEnabled"] boolValue]);
}
- (void)setIngress:(BOOL)enabled {
    if(self.ingressEnabled==enabled)return;
    self.ingressEnabled=enabled;CSGroupChatSetRuntimeEnabled(enabled);
}
- (void)updateIngress {
    BOOL wanted=self.enteredBackground?[self hasBackgroundOpportunity]:
        ([self configuredRooms].count || ([self isForeground] && [self.configuration[@"autoSaveEnabled"] boolValue]));
    BOOL enabled=wanted && self.ready && !self.saving && [self validAccount:self.accountID epoch:self.accountEpoch];
    [self setIngress:enabled];
}
- (void)configureBackgroundDemand:(void (^)(BOOL))demand {
    self.backgroundDemand=demand;[self updateBackgroundDemand];
}
- (void)updateBackgroundDemand {
    if(self.backgroundDemand)self.backgroundDemand(self.backgroundRunManager.enabled && self.ready && !self.saving &&
        [self configuredRooms].count &&
        [self validAccount:self.accountID epoch:self.accountEpoch] && CSAuthorizationManager.sharedManager.isAuthorized);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(context!=&GroupChatBackgroundEnabledContext){[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];return;}
    if([change[NSKeyValueChangeOldKey] isEqual:change[NSKeyValueChangeNewKey]])return;
    // Withdraw on the main thread even if no capability notification fires.
    if(!self.backgroundRunManager.enabled){[self updateBackgroundDemand];return;}
    // Let the global manager open its cycle before joining, so both consumers
    // share the same attempt even if the system grants no task budget.
    dispatch_async(dispatch_get_main_queue(),^{[self updateBackgroundDemand];});
}
- (void)dealloc {
    if(_backgroundRetryTimer)dispatch_source_cancel(_backgroundRetryTimer);
    [_backgroundRunManager removeObserver:self forKeyPath:@"enabled" context:&GroupChatBackgroundEnabledContext];
}
- (void)stopBackgroundRetry {
    if(self.backgroundRetryTimer){dispatch_source_cancel(self.backgroundRetryTimer);self.backgroundRetryTimer=nil;}
}
- (void)updateBackgroundRetry {
    BOOL pending=self.pendingWelcomes.count || self.pendingDepartures.count || self.deferredRequests.count || self.backgroundRefreshResponses.count;
    if(!pending || self.leavingBackground || ![self hasBackgroundOpportunity] || ![self validAccount:self.accountID epoch:self.accountEpoch] ||
       !CSAuthorizationManager.sharedManager.isAuthorized){[self stopBackgroundRetry];return;}
    if(self.backgroundRetryTimer)return;
    // Match the existing member refresh cooldown. The source has no work
    // while queues are empty and does not request any extra system runtime.
    self.backgroundRetryTimer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
    uint64_t interval=5*NSEC_PER_SEC;
    dispatch_source_set_timer(self.backgroundRetryTimer,dispatch_time(DISPATCH_TIME_NOW,interval),interval,NSEC_PER_SEC/2);
    __weak typeof(self) weakSelf=self;
    dispatch_source_set_event_handler(self.backgroundRetryTimer,^{[weakSelf retryBackgroundWork];});
    dispatch_resume(self.backgroundRetryTimer);
}
- (void)retryBackgroundWork {
    [self updateBackgroundRetry];if(!self.backgroundRetryTimer)return;
    NSString *account=self.accountID;NSUInteger epoch=self.accountEpoch,generation=self.configurationGeneration;NSDate *session=self.sessionStarted;
    for(NSString *room in self.deferredRequests.allKeys){
        if(![self actionValid:account epoch:epoch generation:generation session:session room:room] || self.leavingBackground)return;
        NSDate *last=self.requests[room];
        if(last && [NSDate.date timeIntervalSinceDate:last]<5)continue;
        [self finishDeferredRequestForRoom:room account:account epoch:epoch generation:generation session:session];
    }
    for(NSString *room in self.backgroundRefreshResponses.allKeys){
        if(![self actionValid:account epoch:epoch generation:generation session:session room:room] || self.leavingBackground)return;
        NSDate *requested=self.backgroundRefreshResponses[room];
        if(!requested || [NSDate.date timeIntervalSinceDate:requested]<5)continue;
        [self.backgroundRefreshResponses removeObjectForKey:room];
        [self.retriedRefreshRooms addObject:room];[self.forcedRefreshRooms addObject:room];
        [self requestBaselineForRoom:room];
    }
    for(NSString *room in self.pendingDepartures.allKeys){
        if(self.leavingBackground || self.sessionStarted!=session)return;
        [self deliverDeparturesInRoom:room account:account epoch:epoch generation:generation session:session];
    }
    for(NSString *key in self.pendingWelcomes.allKeys){
        if(self.leavingBackground || self.sessionStarted!=session)return;
        [self performPendingWelcome:key];
    }
    [self updateBackgroundRetry];
}
- (void)notify {[NSNotificationCenter.defaultCenter postNotificationName:CSGroupChatConfigurationDidChange object:self];}
- (void)start {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self start];});return;}if(_started)return;_started=YES;
    // The foreground manager can also run without the plugin's background service.
    self.backgroundRunManager=[NSClassFromString(@"CSBackgroundRunManager") sharedManager];
    [self.backgroundRunManager addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:&GroupChatBackgroundEnabledContext];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(accountChanged:) name:@"CSBackupAccountChanged" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(foreground:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(willEnterForeground:) name:@"UIApplicationWillEnterForegroundNotification" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(background:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    self.enteredBackground=UIApplication.sharedApplication.applicationState==UIApplicationStateBackground;
    [self refresh];
}
- (void)accountChanged:(NSNotification *)note {(void)note;dispatch_async(dispatch_get_main_queue(),^{[self refresh];});}
- (void)willEnterForeground:(NSNotification *)note {
    (void)note;self.leavingBackground=YES;[self stopBackgroundRetry];
}
- (void)foreground:(NSNotification *)note {
    (void)note;
    // Notification Center / Face ID can cause DidBecomeActive without the app
    // entering background. Preserve the continuously observed membership cycle.
    if(self.enteredBackground){
        [self setIngress:NO];
        [self checkpointBackgroundContinuity:YES];
        [self.baselines removeAllObjects];[self.pendingWelcomes removeAllObjects];[self.requests removeAllObjects];[self.backgroundRefreshResponses removeAllObjects];[self.deferredRequests removeAllObjects];[self.forcedRefreshRooms removeAllObjects];[self.retriedRefreshRooms removeAllObjects];[self.autoSaveHandled removeAllObjects];
        [self.forcedRefreshRooms addObjectsFromArray:self.resumeBaselines.allKeys];
        self.sessionStarted=NSDate.date;self.autoSaveStarted=self.sessionStarted;
    }
    self.enteredBackground=NO;self.leavingBackground=NO;[self stopBackgroundRetry];[self refresh];[self updateBackgroundDemand];[self updateIngress];[self requestConfiguredBaselines];
    for(NSString *identifier in self.pendingWelcomes.allKeys)[self performPendingWelcome:identifier];
}
- (void)background:(NSNotification *)note {
    (void)note;if(self.enteredBackground)return;
    self.enteredBackground=YES;self.leavingBackground=NO;
    [self checkpointBackgroundContinuity:NO];
    [self updateBackgroundDemand];[self updateIngress];
    [self.forcedRefreshRooms addObjectsFromArray:[self configuredRooms].allObjects];
    [self requestConfiguredBaselines];[self updateBackgroundRetry];
}
- (void)checkpointBackgroundContinuity:(BOOL)pauseWelcomes {
    // A processed background version supersedes the pre-background baseline.
    for(NSString *room in [self configuredRooms]){
        NSDictionary *latest=self.baselines[room],*saved=self.resumeBaselines[room];
        if(latest && (!saved || [latest[@"version"] unsignedLongLongValue]>[saved[@"version"] unsignedLongLongValue]))self.resumeBaselines[room]=latest;
    }
    if(!pauseWelcomes)return;
    for(NSString *key in self.resumeWelcomes.allKeys)if([NSDate.date compare:self.resumeWelcomes[key][@"deadline"]]==NSOrderedDescending)[self.resumeWelcomes removeObjectForKey:key];
    [self.resumeWelcomes addEntriesFromDictionary:self.pendingWelcomes];
    [self.pendingWelcomes removeAllObjects];
}
- (void)discardContinuity {
    [self.resumeBaselines removeAllObjects];[self.resumeWelcomes removeAllObjects];[self.confirmedRemovals removeAllObjects];[self.pendingDepartures removeAllObjects];
}
- (BOOL)validAccount:(NSString *)account epoch:(NSUInteger)epoch {
    if(!account.length || !self.ready || !CSBackupIsReady() || CSBackupAccountIsSuspended() || CSBackupAccountEpoch()!=epoch || self.accountEpoch!=epoch || ![self.accountID isEqual:account])return NO;
    NSString *actual=CSGroupCurrentAccountID();
    return [actual isEqual:account] && self.ready && CSBackupIsReady() && !CSBackupAccountIsSuspended() && CSBackupAccountEpoch()==epoch && self.accountEpoch==epoch && [self.accountID isEqual:account];
}
- (BOOL)tokenValid:(NSString *)account epoch:(NSUInteger)epoch generation:(NSUInteger)generation {
    return [self validAccount:account epoch:epoch] && !self.saving && self.configurationGeneration==generation;
}
- (BOOL)actionValid:(NSString *)account epoch:(NSUInteger)epoch generation:(NSUInteger)generation session:(NSDate *)session room:(NSString *)room {
    return [self tokenValid:account epoch:epoch generation:generation] && self.sessionStarted==session && [self canRunInRoom:room];
}
- (void)refresh {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self refresh];});return;}
    NSString *account=CSBackupIsReady() && !CSBackupAccountIsSuspended()?CSGroupCurrentAccountID():@"";NSUInteger epoch=CSBackupAccountEpoch();
    if(![self.accountID isEqual:account] || self.accountEpoch!=epoch){
        [self setIngress:NO];[self stopBackgroundRetry];self.ready=NO;self.loading=NO;self.saving=NO;self.accountID=account?:@"";self.accountEpoch=epoch;self.configurationGeneration++;
        [self updateBackgroundDemand];
        self.configuration=CSGroupChatDefaultConfiguration();[self.baselines removeAllObjects];[self.pendingWelcomes removeAllObjects];[self.requests removeAllObjects];[self.backgroundRefreshResponses removeAllObjects];[self.deferredRequests removeAllObjects];[self.forcedRefreshRooms removeAllObjects];[self.retriedRefreshRooms removeAllObjects];[self.autoSaveHandled removeAllObjects];
        [self discardContinuity];
        self.sessionStarted=NSDate.date;self.autoSaveStarted=self.sessionStarted;
        NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
        self.configurationURL=account.length?CSGroupChatFileURL([library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES],account):nil;
    }
    if(!account.length){self.statusText=@"请登录微信后设置群聊功能。";[self notify];return;}
    if(self.ready || self.loading)return;self.loading=YES;self.statusText=@"正在读取群聊设置…";
    NSURL *url=self.configurationURL;NSUInteger generation=self.configurationGeneration;
    dispatch_async(self.io,^{NSError *error=nil;NSDictionary *state=CSGroupChatReadState(url,account,&error);
        dispatch_async(dispatch_get_main_queue(),^{
            if(self.accountEpoch!=epoch || self.configurationGeneration!=generation || ![self.accountID isEqual:account])return;
            NSMutableDictionary *configuration=[CSGroupChatDefaultConfiguration() mutableCopy];
            if(state[@"configuration"])[configuration addEntriesFromDictionary:state[@"configuration"]];
            [configuration removeObjectForKey:GroupChatLegacyBackgroundKey];
            self.loading=NO;self.ready=error==nil;self.configuration=[configuration copy];
            self.statusText=error.localizedDescription?:@"";[self updateBackgroundDemand];[self updateIngress];[self notify];[self requestConfiguredBaselines];
        });
    });
}
- (void)updateConfiguration:(NSDictionary *)changes completion:(void (^)(BOOL,NSError *))completion {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self updateConfiguration:changes completion:completion];});return;}
    if(self.saving || ![self validAccount:self.accountID epoch:self.accountEpoch]){if(completion)completion(NO,ManagerError(@"账号或设置状态已变化，请返回后重试。"));return;}
    NSMutableDictionary *next=[self.configuration mutableCopy];if([changes isKindOfClass:NSDictionary.class])[next addEntriesFromDictionary:changes];
    [next removeObjectForKey:GroupChatLegacyBackgroundKey];
    if(![changes isKindOfClass:NSDictionary.class] || !CSGroupChatValidateConfiguration(next)){if(completion)completion(NO,ManagerError(@"请检查群聊名单、文案和发送延迟。"));return;}
    NSString *account=self.accountID;NSUInteger epoch=self.accountEpoch,generation=++self.configurationGeneration;NSURL *url=self.configurationURL;
    NSDictionary *state=@{@"schema":@1,@"account":account,@"configuration":[next copy]};self.saving=YES;[self setIngress:NO];[self stopBackgroundRetry];[self updateBackgroundDemand];[self.pendingWelcomes removeAllObjects];[self.baselines removeAllObjects];[self.requests removeAllObjects];[self.backgroundRefreshResponses removeAllObjects];[self.deferredRequests removeAllObjects];[self.forcedRefreshRooms removeAllObjects];[self.retriedRefreshRooms removeAllObjects];self.sessionStarted=NSDate.date;
    [self discardContinuity];
    dispatch_async(self.io,^{NSError *error=nil;BOOL success=CSBackupAccountEpoch()==epoch && !CSBackupAccountIsSuspended() && CSGroupChatWriteState(state,url,account,&error);
        dispatch_async(dispatch_get_main_queue(),^{
            if(self.configurationGeneration!=generation || self.accountEpoch!=epoch || ![self.accountID isEqual:account]){if(completion)completion(NO,ManagerError(@"账号已切换，本次编辑已结束。"));return;}
            self.saving=NO;
            if(success){BOOL justEnabled=![self.configuration[@"autoSaveEnabled"] boolValue] && [next[@"autoSaveEnabled"] boolValue];
                self.configuration=[next copy];[self.baselines removeAllObjects];[self.requests removeAllObjects];[self.deferredRequests removeAllObjects];[self.forcedRefreshRooms removeAllObjects];[self.retriedRefreshRooms removeAllObjects];
                if(justEnabled){self.autoSaveStarted=NSDate.date;[self.autoSaveHandled removeAllObjects];}self.statusText=@"";}
            else {
                // A replacement may have reached disk before a directory sync
                // failed. Suspend automation and reload the actual state.
                self.ready=NO;self.loading=NO;self.autoSaveStarted=NSDate.date;
                self.statusText=error.localizedDescription?:@"设置未保存，请稍后重试。";
            }
            [self updateBackgroundDemand];[self updateIngress];if(success)[self requestConfiguredBaselines];[self notify];if(completion)completion(success,error?:(!success?ManagerError(self.statusText):nil));
            if(!success)[self refresh];
        });
    });
}
- (NSSet *)configuredRooms {
    NSMutableSet *rooms=[NSMutableSet set];if([self.configuration[@"welcomeEnabled"] boolValue])[rooms addObjectsFromArray:self.configuration[@"welcomeRooms"]];
    if([self.configuration[@"monitorEnabled"] boolValue])[rooms addObjectsFromArray:self.configuration[@"monitorRooms"]];return rooms;
}
- (void)requestConfiguredBaselines {if(!self.ready || self.saving || !CSAuthorizationManager.sharedManager.isAuthorized)return;for(NSString *room in [self configuredRooms])[self requestBaselineForRoom:room];}
- (BOOL)baselineMatchesNativeRoom:(NSString *)roomID {
    NSDictionary *baseline=self.baselines[roomID];if(!baseline)return NO;
    NSSet *native=CSGroupChatMemberIDs(roomID);id data=CSMessageActionNativeObject(CSGroupChatRoomContact(roomID),@"m_ChatRoomData");
    return native && [native isEqual:[NSSet setWithArray:baseline[@"members"]]] && CSMessageNativeUnsigned(data,@"chatRoomVersion")==[baseline[@"version"] unsignedLongLongValue];
}
- (void)finishDeferredRequestForRoom:(NSString *)room account:(NSString *)account epoch:(NSUInteger)epoch generation:(NSUInteger)generation session:(NSDate *)session {
    [self.deferredRequests removeObjectForKey:room];
    if([self actionValid:account epoch:epoch generation:generation session:session room:room] &&
       [[self configuredRooms] containsObject:room] && CSAuthorizationManager.sharedManager.isAuthorized){
        BOOL current=![self.forcedRefreshRooms containsObject:room] && [self baselineMatchesNativeRoom:room];
        if(!current && [self actionValid:account epoch:epoch generation:generation session:session room:room])[self requestBaselineForRoom:room];
    }
    [self updateBackgroundRetry];
}
- (void)requestBaselineForRoom:(NSString *)roomID {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self requestBaselineForRoom:roomID];});return;}
    if(![roomID hasSuffix:@"@chatroom"] || self.saving || ![self canRunInRoom:roomID] || ![self validAccount:self.accountID epoch:self.accountEpoch] || !CSAuthorizationManager.sharedManager.isAuthorized || ![[self configuredRooms] containsObject:roomID])return;
    NSDate *last=self.requests[roomID];NSTimeInterval elapsed=last?[NSDate.date timeIntervalSinceDate:last]:5;
    if(last && elapsed<5){
        // Coalesce changes during the cooldown instead of losing the only
        // member-change event. One trailing request belongs to this session.
        if(!self.deferredRequests[roomID]){
            NSString *ticket=NSUUID.UUID.UUIDString,*account=self.accountID;NSUInteger epoch=self.accountEpoch,generation=self.configurationGeneration;NSDate *session=self.sessionStarted;
            self.deferredRequests[roomID]=ticket;
            if(!self.enteredBackground)dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(MAX(0.05,5-elapsed)*NSEC_PER_SEC)),dispatch_get_main_queue(),^{
                if(!self.enteredBackground && [self.deferredRequests[roomID] isEqual:ticket])
                    [self finishDeferredRequestForRoom:roomID account:account epoch:epoch generation:generation session:session];
            });
        }
        [self updateBackgroundRetry];
        return;
    }
    [self.deferredRequests removeObjectForKey:roomID];
    [self.backgroundRefreshResponses removeObjectForKey:roomID];
    if(CSGroupChatRoomUnavailable(roomID) || !CSGroupChatIsMember(roomID,self.accountID)){[self.forcedRefreshRooms removeObject:roomID];[self.retriedRefreshRooms removeObject:roomID];[self updateBackgroundRetry];return;}
    NSDate *requested=NSDate.date;self.requests[roomID]=requested;
    if(!self.baselines[roomID]){self.statusText=@"正在取得群成员名单，首次名单就绪后开始欢迎新成员。";[self notify];}
    if(![self canRunInRoom:roomID])return;
    NSDictionary *baseline=self.baselines[roomID];
    BOOL accepted=CSGroupChatRequestMembers(roomID);
    if(self.requests[roomID]!=requested)return;
    if(accepted){
        // An accepted native request can still lose its response. Allow one
        // trailing full query while running in background.
        if(self.enteredBackground && self.baselines[roomID]==baseline && ![self.retriedRefreshRooms containsObject:roomID])
            self.backgroundRefreshResponses[roomID]=requested;
        [self.forcedRefreshRooms removeObject:roomID];[self.retriedRefreshRooms removeObject:roomID];
    }else if((self.enteredBackground || [self.forcedRefreshRooms containsObject:roomID]) && ![self.retriedRefreshRooms containsObject:roomID]){
        // Native GetEntireChatRoomMemberDetail can reject a duplicate in-flight
        // query. Retain the hint for one bounded retry through the same gate.
        [self.forcedRefreshRooms addObject:roomID];[self.retriedRefreshRooms addObject:roomID];[self requestBaselineForRoom:roomID];
        self.statusText=@"微信暂未接受名单刷新，将稍后补查一次。";[self notify];
    }else{
        [self.requests removeObjectForKey:roomID];[self.forcedRefreshRooms removeObject:roomID];[self.retriedRefreshRooms removeObject:roomID];
        self.statusText=@"微信暂未接受群成员名单请求，请重新进入群聊后检查。";[self notify];
    }
    [self updateBackgroundRetry];
}
- (void)considerAutoSave:(NSString *)roomID epoch:(NSUInteger)epoch newlyJoined:(BOOL)newlyJoined {
    if(![self isForeground] || ![self.configuration[@"autoSaveEnabled"] boolValue] || [self.autoSaveHandled containsObject:roomID] || [CSGroupChatQuitCoordinator.sharedCoordinator isQuittingRoom:roomID])return;
    NSString *account=self.accountID;NSUInteger generation=self.configurationGeneration;NSDate *session=self.sessionStarted;
    id data=CSMessageActionNativeObject(CSGroupChatRoomContact(roomID),@"m_ChatRoomData");unsigned long long joined=0;
    if(CSMessageNativeSupports(data,@"hasJoinInfoForUsername:",@"B",@[@"@"]) && [CSMessageNativeInvoke(data,@"hasJoinInfoForUsername:",@[account]) boolValue] && CSMessageNativeSupports(data,@"getJoinTimeForUsername:",@"I",@[@"@"]))joined=[CSMessageNativeInvoke(data,@"getJoinTimeForUsername:",@[account]) unsignedLongLongValue];
    NSTimeInterval age=NSDate.date.timeIntervalSince1970-(NSTimeInterval)joined;
    BOOL fresh=joined && age>=-5 && age<=120 && joined>=self.autoSaveStarted.timeIntervalSince1970-2;
    if(!newlyJoined && !fresh)return;
    CSBackupPerformAtAccountEpoch(epoch,^{
        if(![self isForeground] || ![self actionValid:account epoch:epoch generation:generation session:session room:roomID] || !CSAuthorizationManager.sharedManager.isAuthorized || !CSGroupChatIsMember(roomID,account) || CSGroupChatRoomUnavailable(roomID) || ![self isForeground] || ![self actionValid:account epoch:epoch generation:generation session:session room:roomID])return;
        [self.autoSaveHandled addObject:roomID];NSError *error=nil;
        if(!CSGroupChatSaveToContacts(roomID,account,&error) && error && [self isForeground] && [self actionValid:account epoch:epoch generation:generation session:session room:roomID]){self.statusText=error.localizedDescription;[self notify];}
    });
}
- (void)nativeContactChanged:(NSString *)roomID epoch:(NSUInteger)epoch {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self nativeContactChanged:roomID epoch:epoch];});return;}
    if(![roomID hasSuffix:@"@chatroom"] || ![self validAccount:self.accountID epoch:epoch] || self.saving || ![self canRunInRoom:roomID])return;
    if(![self configuredRooms].count && ![self.configuration[@"autoSaveEnabled"] boolValue])return;
    // Cache absence is not proof of having left a group. Only complete responses
    // establish membership transitions; contact hooks may arrive mid-update.
    if(!CSGroupChatIsMember(roomID,self.accountID) || CSGroupChatRoomUnavailable(roomID)){[self cancelWelcomesForRoom:roomID];return;}
    [self considerAutoSave:roomID epoch:epoch newlyJoined:NO];
    if(![[self configuredRooms] containsObject:roomID])return;
    NSDictionary *baseline=self.baselines[roomID];NSSet *native=CSGroupChatMemberIDs(roomID);
    id data=CSMessageActionNativeObject(CSGroupChatRoomContact(roomID),@"m_ChatRoomData");
    BOOL changed=!baseline || ![native isEqual:[NSSet setWithArray:baseline[@"members"]]] || CSMessageNativeUnsigned(data,@"chatRoomVersion")>[baseline[@"version"] unsignedLongLongValue];
    if(changed)[self requestBaselineForRoom:roomID];
}
- (void)nativeSystemMessageInRoom:(NSString *)roomID epoch:(NSUInteger)epoch {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self nativeSystemMessageInRoom:roomID epoch:epoch];});return;}
    if(self.saving || ![self validAccount:self.accountID epoch:epoch] || ![self canRunInRoom:roomID] || ![[self configuredRooms] containsObject:roomID])return;
    // The cached member list can still match the old baseline when a system
    // message arrives. Consume this hint with a full query, not a cache check.
    [self.forcedRefreshRooms addObject:roomID];[self requestBaselineForRoom:roomID];
}
- (void)nativeMemberRemovals:(NSArray<NSString *> *)members inRoom:(NSString *)room epoch:(NSUInteger)epoch {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self nativeMemberRemovals:members inRoom:room epoch:epoch];});return;}
    if(self.saving || ![self canRunInRoom:room] || ![self validAccount:self.accountID epoch:epoch] ||
       !CSAuthorizationManager.sharedManager.isAuthorized || ![self.configuration[@"monitorEnabled"] boolValue] || ![self.configuration[@"monitorRooms"] containsObject:room])return;
    NSDictionary *known=self.baselines[room]?:self.resumeBaselines[room];NSSet *previous=[NSSet setWithArray:known[@"members"]?:@[]];
    NSMutableDictionary *evidence=self.confirmedRemovals[room]?:[NSMutableDictionary dictionary];
    NSDate *now=NSDate.date;
    for(NSString *key in evidence.allKeys)if([now timeIntervalSinceDate:evidence[key]]>120)[evidence removeObjectForKey:key];
    for(NSString *member in members)if(CSGroupChatValidMemberID(member) && [previous containsObject:member])evidence[member]=now;
    if(evidence.count)self.confirmedRemovals[room]=evidence;
    [self nativeSystemMessageInRoom:room epoch:epoch];
}
- (void)cancelWelcomesForRoom:(NSString *)roomID {
    for(NSMutableDictionary *queue in @[self.pendingWelcomes,self.resumeWelcomes])
        for(NSString *key in queue.allKeys)if([queue[key][@"roomID"] isEqual:roomID])[queue removeObjectForKey:key];
    [self updateBackgroundRetry];
}
- (void)cancelWelcomesForMembers:(NSArray *)members room:(NSString *)room {
    if(!members.count)return;NSSet *departed=[NSSet setWithArray:members];
    for(NSString *key in self.pendingWelcomes.allKeys){
        NSDictionary *pending=self.pendingWelcomes[key];if(![pending[@"roomID"] isEqual:room])continue;
        NSMutableArray *remaining=[NSMutableArray array];for(NSString *member in pending[@"members"])if(![departed containsObject:member])[remaining addObject:member];
        if(remaining.count){NSMutableDictionary *updated=[pending mutableCopy];updated[@"members"]=[remaining copy];self.pendingWelcomes[key]=[updated copy];}else [self.pendingWelcomes removeObjectForKey:key];
    }
    [self updateBackgroundRetry];
}
- (void)receiveMemberSnapshot:(NSDictionary *)snapshot epoch:(NSUInteger)epoch {
    if(!NSThread.isMainThread){NSDictionary *copy=[snapshot copy];dispatch_async(dispatch_get_main_queue(),^{[self receiveMemberSnapshot:copy epoch:epoch];});return;}
    NSString *room=snapshot[@"roomID"];
    if(![room isKindOfClass:NSString.class] || ![self canRunInRoom:room] || ![self validAccount:self.accountID epoch:epoch] || self.saving)return;
    NSDate *observed=snapshot[@"observedAt"];if(![observed isKindOfClass:NSDate.class] || [observed compare:self.sessionStarted]==NSOrderedAscending || ![snapshot[@"active"] boolValue])return;
    NSString *account=self.accountID;NSUInteger generation=self.configurationGeneration;NSDate *session=self.sessionStarted;
    BOOL configured=[[self configuredRooms] containsObject:room];if(!configured && ![self.configuration[@"autoSaveEnabled"] boolValue])return;
    NSDictionary *resume=configured?self.resumeBaselines[room]:nil,*old=self.baselines[room]?:resume;
    NSDictionary *delta=CSGroupChatMemberDelta(old,snapshot,self.accountID);if(!delta)return;
    BOOL quitting=[CSGroupChatQuitCoordinator.sharedCoordinator isQuittingRoom:room];
    if(![self actionValid:account epoch:epoch generation:generation session:session room:room] || (self.enteredBackground && !CSAuthorizationManager.sharedManager.isAuthorized))return;
    [self.backgroundRefreshResponses removeObjectForKey:room];
    if([delta[@"invalidate"] boolValue] || quitting){
        // Retain the validated version even when self is absent, preventing a
        // late older response from reintroducing a departed group.
        self.baselines[room]=snapshot;[self.resumeBaselines removeObjectForKey:room];[self.confirmedRemovals removeObjectForKey:room];[self.pendingDepartures removeObjectForKey:room];[self.autoSaveHandled removeObject:room];[self cancelWelcomesForRoom:room];return;
    }
    if(resume && [snapshot[@"version"] unsignedLongLongValue]>[resume[@"version"] unsignedLongLongValue])[self.resumeBaselines removeObjectForKey:room];
    self.baselines[room]=snapshot;[self cancelWelcomesForMembers:delta[@"left"] room:room];
    BOOL selfJoined=old && ![old[@"members"] containsObject:self.accountID] && [snapshot[@"members"] containsObject:self.accountID] && [observed timeIntervalSinceDate:old[@"observedAt"]]<=120;
    [self considerAutoSave:room epoch:epoch newlyJoined:selfJoined];
    if(!configured || self.baselines[room]!=snapshot || ![self tokenValid:account epoch:epoch generation:generation])return;
    // Foreground retains the 2.4-4 diagnostics. The active list stays in
    // memory in background; do not write member files while the phone is locked.
    if([self isForeground])[self persistBaselines];
    if([delta[@"baseline"] boolValue]){self.statusText=@"群成员名单已就绪，等待新成员加入。";[self notify];return;}
    if([self.configuration[@"monitorEnabled"] boolValue] && [self.configuration[@"monitorRooms"] containsObject:room]){
        BOOL background=self.enteredBackground;
        for(NSString *member in delta[@"left"]){
            if(!background && (![self actionValid:account epoch:epoch generation:generation session:session room:room] || !CSAuthorizationManager.sharedManager.isAuthorized))break;
            NSDate *removal=self.confirmedRemovals[room][member];
            BOOL confirmed=removal && [NSDate.date timeIntervalSinceDate:removal]<=120;
            [self.confirmedRemovals[room] removeObjectForKey:member];
            NSString *reason=confirmed?@"被移出":@"离群（原因未确认）";
            NSString *event=[NSString stringWithFormat:@"%@.%@.%@",snapshot[@"version"],member,NSUUID.UUID.UUIDString];
            NSString *roomName=CSGroupChatNameValue(snapshot[@"roomName"]);if(!roomName.length)roomName=CSGroupChatRoomName(room);
            NSDictionary *values=CSGroupChatDepartureValues(member,old[@"names"][member],old[@"remarks"][member],roomName.length?roomName:room,[snapshot[@"members"] count],observed,reason);
            NSMutableArray *pending=self.pendingDepartures[room];
            if(!pending){pending=[NSMutableArray array];self.pendingDepartures[room]=pending;}
            [pending addObject:[@{@"member":member,@"date":observed,@"event":event,@"values":values,@"local":@YES,
                @"remote":@([self.configuration[@"departureSendToRoom"] boolValue])} mutableCopy]];
        }
        [self deliverDeparturesInRoom:room account:account epoch:epoch generation:generation session:session];
    }
    if([self.configuration[@"welcomeEnabled"] boolValue] && [self.configuration[@"welcomeRooms"] containsObject:room]){
        if([self actionValid:account epoch:epoch generation:generation session:session room:room])[self restoreWelcomesForSnapshot:snapshot];
        NSMutableArray *members=[NSMutableArray array];for(NSString *member in delta[@"joined"])if(![member isEqual:account] && CSGroupChatMayWelcomeAfterGap(resume?:old,snapshot,member,NSDate.date,resume!=nil))[members addObject:member];
        if(members.count && [self actionValid:account epoch:epoch generation:generation session:session room:room])[self scheduleWelcome:members snapshot:snapshot];
    }
}
- (void)deliverDeparturesInRoom:(NSString *)room account:(NSString *)account epoch:(NSUInteger)epoch generation:(NSUInteger)generation session:(NSDate *)session {
    NSMutableArray *pending=self.pendingDepartures[room];
    BOOL (^authorized)(void)=^BOOL{return [self actionValid:account epoch:epoch generation:generation session:session room:room] && CSAuthorizationManager.sharedManager.isAuthorized;};
    for(NSMutableDictionary *notice in [pending copy]){
        if([NSDate.date timeIntervalSinceDate:notice[@"date"]]>120){[pending removeObjectIdenticalTo:notice];continue;}
        CSBackupPerformAtAccountEpoch(epoch,^{
            if(!authorized())return;
            if([notice[@"local"] boolValue]){
                // A failed native insertion can be ambiguous. Never replay a
                // local insertion call, even if the window closes during it.
                notice[@"local"]=@NO;
                BOOL posted=CSGroupChatPostDepartureNotice(account,room,notice[@"member"],notice[@"date"],notice[@"event"],self.configuration[@"departureTemplate"],notice[@"values"],authorized);
                if(!posted && authorized()){self.statusText=@"一条退群本地提示未能插入，请检查群状态和微信版本。";[self notify];}
            }
            if([notice[@"remote"] boolValue] && authorized()){
                notice[@"remote"]=@NO;
                if(![self sendDepartureToRoom:room account:account values:notice[@"values"] authorized:authorized])notice[@"remote"]=@YES;
            }
        });
        if(![notice[@"local"] boolValue] && ![notice[@"remote"] boolValue])[pending removeObjectIdenticalTo:notice];
        if(!authorized())break;
    }
    if(!pending.count && self.pendingDepartures[room]==pending)[self.pendingDepartures removeObjectForKey:room];
    [self updateBackgroundRetry];
}
- (BOOL)sendDepartureToRoom:(NSString *)room account:(NSString *)account values:(NSDictionary *)values authorized:(BOOL (^)(void))authorized {
    BOOL (^canSend)(void)=^BOOL{
        return authorized() && ![CSGroupChatQuitCoordinator.sharedCoordinator isQuittingRoom:room] &&
            CSGroupChatIsMember(room,account) && !CSGroupChatRoomUnavailable(room) && authorized();
    };
    BOOL background=self.enteredBackground;
    if(!canSend())return !background || authorized();
    NSString *text=CSGroupChatRenderTemplate(self.configuration[@"departureRoomTemplate"]?:CSGroupChatDefaultRoomDeparture(),values);
    if(![text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length || text.length>4000){
        self.statusText=@"本群文案展开后为空或超过 4000 字，本次未发送。";[self notify];return YES;
    }
    CSMessagePreparedSend *route=[self.sender prepareGroupText:text mentions:@[] targetID:room accountID:account];
    if(!canSend())return !background || authorized();
    route.submissionStillAuthorized=canSend;
    CSMessageActionSubmissionState result=route?[route submit]:CSMessageActionSubmissionStateFailedBeforeAcceptance;
    // Retry only when WeChat was never called. Unknown may already be sent.
    if(background && !route.nativeHandoffReturned && result==CSMessageActionSubmissionStateFailedBeforeAcceptance)return NO;
    if(authorized() && !route.nativeHandoffReturned){self.statusText=@"本群退群通知未确认交给微信，请检查群聊。";[self notify];}
    return YES;
}
- (void)restoreWelcomesForSnapshot:(NSDictionary *)snapshot {
    for(NSString *key in self.resumeWelcomes.allKeys){
        NSDictionary *pending=self.resumeWelcomes[key];
        if(![pending[@"roomID"] isEqual:snapshot[@"roomID"]])continue;
        [self.resumeWelcomes removeObjectForKey:key];
        if([NSDate.date compare:pending[@"deadline"]]==NSOrderedDescending)continue;
        NSSet *current=[NSSet setWithArray:snapshot[@"members"]];NSMutableArray *members=[NSMutableArray array];
        for(NSString *member in pending[@"members"]){
            NSNumber *join=snapshot[@"joinTimes"][member];NSDate *first=pending[@"snapshot"][@"observedAt"];
            if([current containsObject:member] && (!join || join.doubleValue<=first.timeIntervalSince1970+5))[members addObject:member];
        }
        if(!members.count)continue;
        NSMutableDictionary *resumed=[pending mutableCopy];resumed[@"members"]=[members copy];resumed[@"session"]=self.sessionStarted;resumed[@"snapshot"]=snapshot;
        self.pendingWelcomes[key]=[resumed copy];[self armWelcome:key dueAt:resumed[@"dueAt"]];
    }
}
- (void)scheduleWelcome:(NSArray *)members snapshot:(NSDictionary *)snapshot {
    NSString *identifier=NSUUID.UUID.UUIDString,*account=self.accountID,*room=snapshot[@"roomID"];NSUInteger epoch=self.accountEpoch,generation=self.configurationGeneration;
    NSDate *session=self.sessionStarted;NSTimeInterval delay=[self.configuration[@"welcomeDelay"] doubleValue];NSDate *deadline=[NSDate.date dateByAddingTimeInterval:delay+120];
    self.pendingWelcomes[identifier]=@{@"roomID":room,@"members":[members copy],@"account":account,@"epoch":@(epoch),@"generation":@(generation),@"session":session,@"deadline":deadline,@"dueAt":[NSDate.date dateByAddingTimeInterval:delay],@"snapshot":snapshot};
    self.statusText=[NSString stringWithFormat:@"已检测到 %lu 位新成员，将在 %.0f 秒后发送欢迎。",(unsigned long)members.count,delay];[self notify];
    [self armWelcome:identifier dueAt:self.pendingWelcomes[identifier][@"dueAt"]];
}
- (void)armWelcome:(NSString *)identifier dueAt:(NSDate *)dueAt {
    if(!dueAt)return;
    [self updateBackgroundRetry];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(MAX(0,dueAt.timeIntervalSinceNow)*NSEC_PER_SEC)),dispatch_get_main_queue(),^{
        [self performPendingWelcome:identifier];
    });
}
- (void)performPendingWelcome:(NSString *)identifier {
    [self attemptPendingWelcome:identifier];
    [self updateBackgroundRetry];
}
- (void)attemptPendingWelcome:(NSString *)identifier {
        NSDictionary *pending=self.pendingWelcomes[identifier];if(!pending)return;
        NSString *account=pending[@"account"],*room=pending[@"roomID"];NSUInteger epoch=[pending[@"epoch"] unsignedIntegerValue],generation=[pending[@"generation"] unsignedIntegerValue];
        NSDate *session=pending[@"session"],*deadline=pending[@"deadline"];
        if(![self tokenValid:account epoch:epoch generation:generation] || self.sessionStarted!=session || [NSDate.date compare:deadline]==NSOrderedDescending || !CSAuthorizationManager.sharedManager.isAuthorized || ![self.configuration[@"welcomeEnabled"] boolValue] || ![self.configuration[@"welcomeRooms"] containsObject:room]){[self.pendingWelcomes removeObjectForKey:identifier];return;}
        if([NSDate.date compare:pending[@"dueAt"]]==NSOrderedAscending)return;
        [self.pendingWelcomes removeObjectForKey:identifier];
        BOOL background=self.enteredBackground;
        void (^retry)(void)=^{
            if(!background || ![self tokenValid:account epoch:epoch generation:generation] ||
               !CSAuthorizationManager.sharedManager.isAuthorized || [NSDate.date compare:deadline]==NSOrderedDescending)return;
            if(self.sessionStarted==session && self.enteredBackground)self.pendingWelcomes[identifier]=pending;
            else self.resumeWelcomes[identifier]=pending;
        };
        if(![self actionValid:account epoch:epoch generation:generation session:session room:room]){retry();return;}
        if([CSGroupChatQuitCoordinator.sharedCoordinator isQuittingRoom:room])return;
        if(!CSGroupChatIsMember(room,account) || CSGroupChatRoomUnavailable(room)){retry();return;}
        NSSet *current=CSGroupChatMemberIDs(room);if(!current){retry();return;}
        NSMutableArray *remaining=[NSMutableArray array];for(NSString *member in pending[@"members"])if([current containsObject:member])[remaining addObject:member];if(!remaining.count)return;
        NSDictionary *latest=self.baselines[room]?:pending[@"snapshot"];NSDictionary *rendered=CSGroupChatWelcomeTextWithRemarks(self.configuration[@"welcomeTemplate"],remaining,latest[@"names"]?:@{},latest[@"remarks"]?:@{},CSGroupChatRoomName(room),current.count,NSDate.date);
        NSString *text=rendered[@"text"];if(!text.length || text.length>4000){self.statusText=@"欢迎文案展开后超过 4000 字，本次未发送。";[self notify];return;}
        CSMessagePreparedSend *route=[self.sender prepareGroupText:text mentions:rendered[@"mentions"] targetID:room accountID:account];if(!route){retry();self.statusText=@"当前无法发送群欢迎消息，请检查微信版本和群状态。";[self notify];return;}
        route.submissionStillAuthorized=^BOOL{
            if(![self actionValid:account epoch:epoch generation:generation session:session room:room] || ![self.configuration[@"welcomeEnabled"] boolValue] || ![self.configuration[@"welcomeRooms"] containsObject:room] || !CSAuthorizationManager.sharedManager.isAuthorized || [NSDate.date compare:deadline]==NSOrderedDescending || [CSGroupChatQuitCoordinator.sharedCoordinator isQuittingRoom:room] || !CSGroupChatIsMember(room,account) || CSGroupChatRoomUnavailable(room))return NO;
            NSSet *live=CSGroupChatMemberIDs(room);for(NSString *member in remaining)if(![live containsObject:member])return NO;
            return [self actionValid:account epoch:epoch generation:generation session:session room:room];
        };
        CSBackupPerformAtAccountEpoch(epoch,^{
            if(![self actionValid:account epoch:epoch generation:generation session:session room:room]){retry();return;}
            CSMessageActionSubmissionState result=[route submit];
            if(!route.nativeHandoffReturned && result==CSMessageActionSubmissionStateFailedBeforeAcceptance)retry();
            if(![self actionValid:account epoch:epoch generation:generation session:session room:room])return;
            if(route.nativeHandoffReturned)self.statusText=@"欢迎消息已交给微信发送，请在群聊查看发送状态。";
            else if(result==CSMessageActionSubmissionStateFailedBeforeAcceptance || result==CSMessageActionSubmissionStateCancelled)self.statusText=@"欢迎消息未提交：群成员或发送条件已变化。";
            else self.statusText=@"欢迎消息未能确认提交给微信，不会自动重发，请检查群聊。";
            [self notify];
        });
}
- (void)persistBaselines {
    NSDictionary *snapshot=[self.baselines copy];NSURL *url=[self.configurationURL URLByAppendingPathExtension:@"members"];NSUInteger epoch=self.accountEpoch;
    // This diagnostic baseline is deliberately never loaded as executable state.
    // A fresh process rebuilds coverage before allowing any automated action.
    dispatch_async(self.io,^{if(CSBackupAccountEpoch()!=epoch || CSBackupAccountIsSuspended())return;
        NSData *data=[NSPropertyListSerialization dataWithPropertyList:snapshot format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];
        if(data.length<=8*1024*1024 && [NSFileManager.defaultManager fileExistsAtPath:url.URLByDeletingLastPathComponent.path])[data writeToURL:url options:NSDataWritingAtomic error:NULL];
    });
}
@end
