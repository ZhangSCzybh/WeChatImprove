#import "CSAutomationManager.h"
#import "CSAutomationStore.h"
#import "CSAutomationTiming.h"
#import "CSAutomationEventAdapter.h"
#import "CSAutomationNativeAdapter.h"
#import "CSBackgroundSyncBudget.h"
#import "CSAINativeSyncObserver.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSAuthorizationManager.h"
#import "CSGroupNativeBridge.h"
#import "CSGroupChatNativeAdapter.h"
#import <UIKit/UIKit.h>
#import <math.h>
#import <limits.h>
#import <mach/mach_time.h>

NSNotificationName const CSAutomationConfigurationDidChange=@"CSAutomationConfigurationDidChange";
static const NSUInteger CSAutomationMaximumPending=1000;
static const NSTimeInterval CSAutomationCapabilityRetry=5;

@interface CSAutomationAdmission : NSObject
@property(nonatomic,copy) NSDictionary *event,*decision;
@property(nonatomic,copy) NSString *action;
@property(nonatomic) NSUInteger epoch,generation,revision;
@property(nonatomic) NSTimeInterval acceptedAt,wakeAt,deadline;
@property(nonatomic) BOOL ownsClaim,claimed,suppressed,persisting;
@property(nonatomic,strong) NSMutableOrderedSet<NSString *> *identifiers;
@property(nonatomic,strong) NSMutableArray *completions;
@end
@implementation CSAutomationAdmission @end

@interface CSAutomationTask : NSObject
@property(nonatomic,copy) NSString *identifier,*account,*text;
@property(nonatomic,copy) NSDictionary *event,*decision;
@property(nonatomic) NSUInteger epoch,generation;
@property(nonatomic) NSTimeInterval due,deadline,wakeAt,revokeDelay;
@property(nonatomic,strong) id sendPat;
@property(nonatomic) BOOL observing,revoking,resultConsumed;
@end
@implementation CSAutomationTask @end

@interface CSAutomationManager ()
@property(nonatomic,copy,readwrite) NSString *accountID,*statusText;
@property(nonatomic,copy,readwrite) NSDictionary *configuration;
@property(nonatomic,readwrite) NSUInteger accountEpoch,configurationGeneration;
@property(nonatomic,readwrite) BOOL ready;
@property(nonatomic) BOOL started,loading,saving,processing;
@property(nonatomic) NSTimeInterval admissionBoundary,nextLoadAttempt;
@property(nonatomic) BOOL hasExplicitAdmissionBoundary;
@property(nonatomic,strong) NSURL *configurationURL;
@property(nonatomic,strong) dispatch_queue_t io;
@property(nonatomic,strong) CSAutomationLedger *ledger;
@property(nonatomic,strong) CSMessageNativeEnvironment *environment;
@property(nonatomic,strong) CSMessageSendAdapter *sender;
@property(nonatomic,strong) CSAutomationNativeAdapter *native;
@property(nonatomic,strong) NSMutableDictionary<NSString *,CSAutomationTask *> *tasks;
@property(nonatomic,strong) NSMutableDictionary<NSString *,CSAutomationAdmission *> *admissions;
@property(nonatomic,strong) NSMutableArray<NSDictionary *> *waitingIngress;
@property(nonatomic,strong) dispatch_source_t timer;
@property(nonatomic,strong) dispatch_source_t backgroundSyncTimer;
@property(nonatomic) BOOL enteringForeground,refreshingBackgroundSync;
@property(nonatomic) NSUInteger backgroundSyncGeneration;
@end

static NSError *AutomationError(NSString *message) {
    return [NSError errorWithDomain:@"CSAutomationManager" code:1 userInfo:@{NSLocalizedDescriptionKey:message}];
}
static NSString *AdmissionKey(NSString *action,NSString *identifier) {return [NSString stringWithFormat:@"%@|%@",action,identifier];}

@implementation CSAutomationManager
+ (instancetype)sharedManager {static id manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (instancetype)init {
    if((self=[super init])){
        _accountID=@"";_statusText=@"正在读取自动功能设置…";_configuration=CSAutomationDefaultConfiguration();
        _io=dispatch_queue_create("com.wechat.improve.automation.storage",DISPATCH_QUEUE_SERIAL);
        _environment=[CSMessageNativeEnvironment new];_sender=[[CSMessageSendAdapter alloc]initWithEnvironment:_environment];
        _native=[[CSAutomationNativeAdapter alloc]initWithEnvironment:_environment];_tasks=[NSMutableDictionary dictionary];_admissions=[NSMutableDictionary dictionary];_waitingIngress=[NSMutableArray array];
        _admissionBoundary=[self currentDate].timeIntervalSince1970;
    }return self;
}
- (void)dealloc {[NSNotificationCenter.defaultCenter removeObserver:self];if(_timer)dispatch_source_cancel(_timer);if(_backgroundSyncTimer)dispatch_source_cancel(_backgroundSyncTimer);for(CSAutomationTask *task in _tasks.allValues)if(task.observing)CSAutomationCancelPatObservation(task.sendPat);}
// Explicit clock/path seams also let host tests leave the user's sandbox alone.
- (NSDate *)currentDate {return NSDate.date;}
- (NSTimeInterval)elapsedTime {
    // Continuous time includes device sleep: waking from a long lock-screen
    // suspension must not restart an apparently unexpired reply/revoke delay.
    static mach_timebase_info_data_t scale;static dispatch_once_t once;dispatch_once(&once,^{mach_timebase_info(&scale);});
    return scale.denom?(NSTimeInterval)mach_continuous_time()*scale.numer/scale.denom/1e9:NAN;
}
- (NSURL *)resourceRoot {
    NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
    return [library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES];
}
- (void)notify {[NSNotificationCenter.defaultCenter postNotificationName:CSAutomationConfigurationDidChange object:self];[self refreshBackgroundSync];}
- (BOOL)accountValid:(NSString *)account epoch:(NSUInteger)epoch {
    @try {return account.length && CSBackupIsReady() && !CSBackupAccountIsSuspended() && epoch==CSBackupAccountEpoch() &&
        epoch==self.accountEpoch && [self.accountID isEqual:account] && [[self.environment currentAccountID] isEqual:account] &&
        epoch==CSBackupAccountEpoch() && !CSBackupAccountIsSuspended();} @catch(__unused NSException *exception){return NO;}
}
- (NSString *)availabilityReason {
    @try {
    if(!CSBackupIsReady() || CSBackupAccountIsSuspended())return @"账号配置暂未就绪";
    if(!self.ready)return @"自动功能配置暂未就绪";
    if(![self accountValid:self.accountID epoch:self.accountEpoch])return @"微信账号资料暂不可用";
    if(!CSAuthorizationManager.sharedManager.isAuthorized)return @"授权查询暂未通过";
    return nil;
    } @catch(__unused NSException *exception){return @"微信账号或授权查询暂不可用";}
}
- (void)cancelAdmissions:(NSString *)reason {
    NSArray *owners=[NSSet setWithArray:self.admissions.allValues].allObjects;[self.admissions removeAllObjects];
    for(CSAutomationAdmission *admission in owners){admission.suppressed=YES;NSArray *waiters=[admission.completions copy];[admission.completions removeAllObjects];for(void (^waiter)(BOOL) in waiters)waiter(admission.claimed);}
    if(owners.count){self.statusText=reason;[self notify];}
}
- (void)cancelWaitingIngress:(NSString *)reason {
    NSArray *waiting=[self.waitingIngress copy];[self.waitingIngress removeAllObjects];
    for(NSDictionary *entry in waiting){void (^completion)(BOOL)=entry[@"completion"];completion(NO);}
    if(waiting.count){self.statusText=reason;[self notify];}
}
- (void)start {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self start];});return;}
    if(self.started)return;self.started=YES;
    for(NSString *name in @[@"CSBackupAccountChanged",@"CSAutomationRestoreDidComplete",UIApplicationDidBecomeActiveNotification,UIApplicationProtectedDataDidBecomeAvailable,@"UIApplicationDidEnterBackgroundNotification",@"UIApplicationWillEnterForegroundNotification"])
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [self refresh];
}
- (void)changed:(NSNotification *)note {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self changed:note];});return;}
    if([note.name isEqual:@"UIApplicationWillEnterForegroundNotification"]){self.enteringForeground=YES;[self stopBackgroundSync];return;}
    if([note.name isEqual:@"UIApplicationDidEnterBackgroundNotification"] || [note.name isEqual:UIApplicationDidBecomeActiveNotification])self.enteringForeground=NO;
    if([note.name isEqual:@"CSAutomationRestoreDidComplete"]){
        self.configurationGeneration++;self.ready=NO;self.loading=NO;self.saving=NO;self.admissionBoundary=self.currentDate.timeIntervalSince1970;self.hasExplicitAdmissionBoundary=YES;
        [self cancelWaitingIngress:@"配置已恢复，旧入站事件已取消。"];
        [self cancelTasksIncludingCleanup:YES];[self cancelAdmissions:@"账号或配置已变化，旧认领等待已取消。"];
    }
    self.nextLoadAttempt=0;[self refresh];
    for(CSAutomationTask *task in self.tasks.allValues)if(!task.observing)task.wakeAt=MAX(task.due,MIN(task.wakeAt,self.elapsedTime));
    for(CSAutomationAdmission *admission in [NSSet setWithArray:self.admissions.allValues])if(!admission.persisting)admission.wakeAt=self.elapsedTime;
    [self drainWaitingIngress];[self processPending];[self refreshBackgroundSync];
}

- (BOOL)backgroundSyncDemand {
    @try {
    if(!NSThread.isMainThread || self.enteringForeground || UIApplication.sharedApplication.applicationState!=UIApplicationStateBackground || !self.ready || self.loading || self.saving)return NO;
    NSDictionary *configuration=self.configuration;
    for(NSString *module in @[@"patBack",@"patReply"]){
        NSDictionary *item=configuration[module];
        if([item[@"enabled"] boolValue] && ([item[@"groups"] count] || [item[@"friends"] count]) && (![module isEqual:@"patReply"] || [item[@"contents"] count]))return YES;
    }
    return NO;
    } @catch(__unused NSException *exception) {return NO;}
}
- (BOOL)backgroundSyncEligible {
    @try {
    if(![self backgroundSyncDemand])return NO;
    NSDictionary *configuration=self.configuration;
    // Message retrieval must not depend on contacts which themselves need sync.
    // Existing reply admission/submission still performs all conversation checks.
    if(![self accountValid:self.accountID epoch:self.accountEpoch] || !CSAuthorizationManager.sharedManager.isAuthorized)return NO;
    return configuration==self.configuration && [self backgroundSyncDemand];
    } @catch(__unused NSException *exception) {return NO;}
}
- (void)stopBackgroundSync {
    self.backgroundSyncGeneration++;if(self.backgroundSyncTimer){dispatch_source_cancel(self.backgroundSyncTimer);self.backgroundSyncTimer=nil;}
}
- (void)armBackgroundSyncAfter:(NSTimeInterval)delay {
    [self stopBackgroundSync];NSUInteger generation=self.backgroundSyncGeneration;
    self.backgroundSyncTimer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
    dispatch_source_set_timer(self.backgroundSyncTimer,dispatch_time(DISPATCH_TIME_NOW,(int64_t)(MAX(0.01,delay)*NSEC_PER_SEC)),DISPATCH_TIME_FOREVER,NSEC_PER_SEC);
    __weak typeof(self) weakSelf=self;
    dispatch_source_set_event_handler(self.backgroundSyncTimer,^{typeof(self) manager=weakSelf;if(!manager || generation!=manager.backgroundSyncGeneration)return;[manager backgroundSyncTick];});
    dispatch_resume(self.backgroundSyncTimer);
}
- (void)refreshBackgroundSync {
    if(!NSThread.isMainThread || self.refreshingBackgroundSync)return;self.refreshingBackgroundSync=YES;
    @try {
        if(![self backgroundSyncDemand]){[self stopBackgroundSync];return;}
        if(!self.backgroundSyncTimer)[self armBackgroundSyncAfter:[CSBackgroundSyncBudget.sharedBudget nextDelayForEpoch:self.accountEpoch]];
    } @catch(__unused NSException *exception) {[self stopBackgroundSync];}
    @finally {self.refreshingBackgroundSync=NO;}
}
- (void)backgroundSyncTick {
    if(![self backgroundSyncDemand]){[self stopBackgroundSync];return;}
    NSTimeInterval delay=[CSBackgroundSyncBudget.sharedBudget nextDelayForEpoch:self.accountEpoch];
    // Reserve a future wake before native getters can synchronously reenter.
    [self armBackgroundSyncAfter:delay>0?delay:45];if(delay>0)return;
    // Temporary account/native availability must not disable future retrieval.
    if(![self backgroundSyncEligible])return;
    NSDictionary *configuration=self.configuration;NSString *account=self.accountID;NSUInteger epoch=self.accountEpoch,generation=self.configurationGeneration;
    @try {
        id service=[self.environment serviceNamed:@"NewSyncService"];
        if(!CSMessageNativeSupports(service,@"isGettingData",@"B",@[]) || !CSMessageNativeSupports(service,@"BackGroundFetchToSync",@"B",@[]))return;
        if([CSMessageNativeInvoke(service,@"isGettingData",@[]) boolValue])return;
        if(![self backgroundSyncEligible] || configuration!=self.configuration || generation!=self.configurationGeneration || ![self.accountID isEqual:account] || epoch!=self.accountEpoch)return;
        [CSBackgroundSyncBudget.sharedBudget performForEpoch:epoch request:^{
            CSAIObserveBackgroundSyncRequest(epoch,^{
                if(configuration!=self.configuration || generation!=self.configurationGeneration || !self.ready || self.loading || self.saving || ![self.accountID isEqual:account] || self.accountEpoch!=epoch || self.enteringForeground || UIApplication.sharedApplication.applicationState!=UIApplicationStateBackground)return;
                CSBackupPerformAtAccountEpoch(epoch,^{
                    // Do not unwind through the account handoff's lock boundary.
                    @try {[CSMessageNativeInvoke(service,@"BackGroundFetchToSync",@[]) boolValue];}
                    @catch(__unused NSException *exception) {return;}
                });
            });
        }];
    } @catch(__unused NSException *exception) {}
}

- (void)cancelTasksIncludingCleanup:(BOOL)cleanup {
    for(NSString *key in self.tasks.allKeys){CSAutomationTask *task=self.tasks[key];
        if(!cleanup && (task.observing || task.revoking))continue;
        if(task.observing)CSAutomationCancelPatObservation(task.sendPat);[self.tasks removeObjectForKey:key];
    }[self scheduleWakeup];
}
- (void)drainWaitingIngress {
    if(!self.ready || ![self accountValid:self.accountID epoch:self.accountEpoch])return;
    NSArray *pending=[self.waitingIngress copy];[self.waitingIngress removeAllObjects];
    for(NSDictionary *entry in pending){void (^completion)(BOOL)=entry[@"completion"];
        if([entry[@"epoch"] unsignedIntegerValue]!=self.accountEpoch || self.elapsedTime>[entry[@"expires"] doubleValue]){self.statusText=@"入站事件已超过等待窗口或账号已切换，本次不补发。";[self notify];completion(NO);continue;}
        BOOL pat=[entry[@"pat"] boolValue];NSString *session=[entry[@"session"] isKindOfClass:NSString.class]?entry[@"session"]:@"";
        NSDictionary *event=pat?CSAutomationEventFromPat(entry[@"wrap"],self.accountID,session):CSAutomationEventFromWrap(entry[@"wrap"],self.accountID,session);
        NSMutableDictionary *snapshot=[event mutableCopy];snapshot[@"arrivalElapsed"]=entry[@"arrivalElapsed"];snapshot[@"arrivalWall"]=entry[@"arrivalWall"];
        [self receiveEvent:snapshot pat:pat completion:completion];
    }[self scheduleWakeup];
}

- (void)refresh {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self refresh];});return;}
    NSUInteger epoch=CSBackupAccountEpoch();
    NSString *actual=@"";@try {if(CSBackupIsReady() && !CSBackupAccountIsSuspended())actual=[self.environment currentAccountID]?:@"";} @catch(__unused NSException *exception) {}
    BOOL initial=self.accountID.length==0;
    BOOL changed=self.accountEpoch!=epoch || (!initial && actual.length && ![actual isEqual:self.accountID]);
    if(changed){
        self.nextLoadAttempt=0;self.configurationGeneration++;self.ready=NO;self.loading=NO;self.saving=NO;
        if(!initial){[self cancelWaitingIngress:@"账号已切换，旧入站事件已取消。"];self.admissionBoundary=self.currentDate.timeIntervalSince1970;self.hasExplicitAdmissionBoundary=YES;}
        else for(NSDictionary *entry in [self.waitingIngress copy])if([entry[@"epoch"] unsignedIntegerValue]!=epoch){[self.waitingIngress removeObjectIdenticalTo:entry];void (^completion)(BOOL)=entry[@"completion"];completion(NO);self.statusText=@"账号代次已变化，旧入站事件已取消。";[self notify];}
        self.accountID=actual;self.accountEpoch=epoch;self.configuration=CSAutomationDefaultConfiguration();self.ledger=nil;
        [self cancelTasksIncludingCleanup:YES];[self cancelAdmissions:@"账号或配置已变化，旧认领等待已取消。"];
        self.statusText=@"账号已切换，旧自动任务已取消。";
    }else if(initial && actual.length){self.accountID=actual;self.accountEpoch=epoch;}
    if(!actual.length || !CSBackupIsReady() || CSBackupAccountIsSuspended()){
        self.statusText=@"微信账号暂不可用，保留窗口内任务等待恢复。";[self notify];[self scheduleWakeup];return;
    }
    NSString *account=self.accountID;
    if(!account.length){self.statusText=@"请登录微信后设置自动功能。";[self notify];return;}
    if(self.ready || self.loading || self.elapsedTime<self.nextLoadAttempt)return;
    self.nextLoadAttempt=self.elapsedTime+CSAutomationCapabilityRetry;
    self.configurationURL=CSAutomationFileURL(self.resourceRoot,account);self.loading=YES;self.statusText=@"正在读取自动功能设置…";
    NSURL *url=self.configurationURL;NSUInteger generation=self.configurationGeneration;
    dispatch_async(self.io,^{
        NSError *error=nil;NSDictionary *state=CSAutomationReadState(url,account,&error);
        NSURL *runtime=[[url URLByDeletingPathExtension] URLByAppendingPathExtension:@"runtime.plist"];
        CSAutomationLedger *ledger=error?nil:[[CSAutomationLedger alloc]initWithURL:runtime account:account error:&error];
        dispatch_async(dispatch_get_main_queue(),^{
            if(generation!=self.configurationGeneration || epoch!=self.accountEpoch || ![account isEqual:self.accountID])return;
            self.loading=NO;self.ready=error==nil && ledger!=nil;self.ledger=ledger;
            if(self.ready){
                self.configuration=state[@"configuration"]?:CSAutomationDefaultConfiguration();
                for(CSAutomationTask *task in self.tasks.allValues)if(!task.observing)task.wakeAt=MAX(task.due,MIN(task.wakeAt,self.elapsedTime));
                for(CSAutomationAdmission *admission in [NSSet setWithArray:self.admissions.allValues])if(!admission.persisting)admission.wakeAt=self.elapsedTime;
            }
            self.statusText=error.localizedDescription?:@"已就绪 · 等待符合规则的新事件";[self notify];[self drainWaitingIngress];[self processPending];
        });
    });
}

- (void)updateConfiguration:(NSDictionary *)changes completion:(void (^)(BOOL,NSError *))completion {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self updateConfiguration:changes completion:completion];});return;}
    if(!self.ready || self.saving || ![self accountValid:self.accountID epoch:self.accountEpoch]){if(completion)completion(NO,AutomationError(@"账号或设置状态已变化，请返回后重试。"));return;}
    NSMutableDictionary *next=[self.configuration mutableCopy];if([changes isKindOfClass:NSDictionary.class])[next addEntriesFromDictionary:changes];
    NSDictionary *normalized=CSAutomationNormalizeConfiguration(next);
    if(![changes isKindOfClass:NSDictionary.class] || !normalized){if(completion)completion(NO,AutomationError(@"请检查自动功能名单、回复内容、关键词及延迟。"));return;}
    // A plist round trip freezes nested mutable editor dictionaries as well.
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:normalized format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];
    NSDictionary *frozen=data?[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL]:nil;
    if(!frozen){if(completion)completion(NO,AutomationError(@"设置内容无效，本次未保存。"));return;}
    NSString *account=self.accountID;NSUInteger epoch=self.accountEpoch,generation=++self.configurationGeneration;NSURL *url=self.configurationURL;
    self.saving=YES;self.admissionBoundary=self.currentDate.timeIntervalSince1970;self.hasExplicitAdmissionBoundary=YES;[self cancelWaitingIngress:@"设置已变化，旧入站事件已取消。"];[self cancelAdmissions:@"设置已变化，旧认领等待已取消。"];
    BOOL keepCleanup=[frozen[@"patBack"][@"enabled"] boolValue] && [frozen[@"patBack"][@"revoke"] boolValue];
    [self cancelTasksIncludingCleanup:!keepCleanup];[self notify];
    NSDictionary *state=@{@"schema":@1,@"account":account,@"configuration":frozen};
    dispatch_async(self.io,^{
        NSError *error=nil;BOOL success=CSBackupIsReady() && !CSBackupAccountIsSuspended() && CSBackupAccountEpoch()==epoch && CSAutomationWriteState(state,url,account,&error);
        dispatch_async(dispatch_get_main_queue(),^{
            if(generation!=self.configurationGeneration || epoch!=self.accountEpoch || ![account isEqual:self.accountID]){if(completion)completion(NO,AutomationError(@"账号或设置已变化，本次编辑已结束。"));return;}
            self.saving=NO;
            if(success){self.configuration=frozen;self.statusText=@"设置已保存 · 等待新事件";}
            else {self.ready=NO;self.statusText=error.localizedDescription?:@"设置未保存，自动动作已暂停。";[self cancelTasksIncludingCleanup:YES];}
            [self notify];if(completion)completion(success,error?:(!success?AutomationError(self.statusText):nil));[self drainWaitingIngress];[self processPending];
        });
    });
}
- (BOOL)supportsConversation:(NSString *)conversation {
    @try {
        if([conversation hasSuffix:@"@chatroom"]){
            if(CSGroupChatRoomUnavailable(conversation)){return NO;}
            if(!CSGroupChatIsMember(conversation,self.accountID)){return NO;}
            if([CSGroupChatQuitCoordinator.sharedCoordinator isQuittingRoom:conversation]){return NO;}
            return YES;
        }
        id contacts=[self.environment serviceNamed:@"CContactMgr"],contact=nil;
        for(NSString *selector in @[@"getContactByName:",@"getContactByNameFromDB:"]){if(CSMessageNativeSupports(contacts,selector,@"@",@[@"@"]))contact=CSMessageNativeInvoke(contacts,selector,@[conversation]);if(contact)break;}
        return [CSMessageActionNativeObject(contact,@"m_nsUsrName") isEqual:conversation] && CSGroupCategoryForContact(contact)==CSGroupRowCategoryPrivate;
    }@catch(__unused NSException *exception){return NO;}
}
- (NSString *)permanentReasonForTask:(CSAutomationTask *)task cleanup:(BOOL)cleanup {
    if(task.epoch!=self.accountEpoch || task.epoch!=CSBackupAccountEpoch() || (self.accountID.length && ![self.accountID isEqual:task.account]))return @"账号已切换，自动任务已取消。";
    if(cleanup)return [self.configuration[@"patBack"][@"enabled"] boolValue] && [self.configuration[@"patBack"][@"revoke"] boolValue]?nil:@"自动回拍或撤回已关闭，本次撤回已取消。";
    if(task.generation!=self.configurationGeneration)return @"设置已变化，旧自动任务已取消。";
    NSDictionary *module=self.configuration[task.decision[@"module"]];
    if(![module[@"enabled"] boolValue] || ![module[[task.event[@"group"] boolValue]?@"groups":@"friends"] containsObject:task.event[@"conversation"]])return @"功能已关闭或会话已移出名单，自动任务已取消。";
    return nil;
}
- (BOOL)taskValid:(CSAutomationTask *)task cleanup:(BOOL)cleanup {
    return ![self permanentReasonForTask:task cleanup:cleanup] && !self.saving && ![self availabilityReason];
}
- (void)pauseTask:(CSAutomationTask *)task reason:(NSString *)reason {
    task.wakeAt=MAX(task.due,MIN(task.deadline+0.01,self.elapsedTime+CSAutomationCapabilityRetry));
    self.statusText=[reason stringByAppendingString:@"；保留至延迟到期后 5 分钟，恢复时重试。"];
    [self notify];
}

- (BOOL)canSubmitTask:(CSAutomationTask *)task cleanup:(BOOL)cleanup {
    if(![self taskValid:task cleanup:cleanup] || ![self supportsConversation:task.event[@"conversation"]])return NO;
    // Native getters above may synchronously reenter account/configuration changes.
    return [self taskValid:task cleanup:cleanup];
}
- (void)receiveNativeSession:(id)session wrap:(id)wrap epoch:(NSUInteger)epoch {[self receiveNativeSession:session wrap:wrap epoch:epoch completion:^(__unused BOOL claimed){}];}
- (void)enqueueSession:(id)session wrap:(id)wrap epoch:(NSUInteger)epoch pat:(BOOL)pat completion:(void (^)(BOOL))completion {
    if(!wrap || self.waitingIngress.count>=CSAutomationMaximumPending){self.statusText=@"入站等待队列已满或消息无效，本次未接收。";[self notify];if(completion)completion(NO);return;}
    [self.waitingIngress addObject:@{@"session":session?:@"",@"wrap":wrap,@"epoch":@(epoch),@"pat":@(pat),@"arrivalElapsed":@(self.elapsedTime),@"arrivalWall":@(self.currentDate.timeIntervalSince1970),@"expires":@(self.elapsedTime+300+CSAutomationLateAllowance),@"completion":[completion?:^(__unused BOOL claimed){} copy]}];
    self.statusText=@"账号或配置暂未就绪，事件已排队等待。";[self notify];[self scheduleWakeup];
}
- (void)receiveNativeSession:(id)session wrap:(id)wrap epoch:(NSUInteger)epoch completion:(void (^)(BOOL))completion {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self receiveNativeSession:session wrap:wrap epoch:epoch completion:completion];});return;}
    if(!self.started)[self start];else if(!self.ready || !self.accountID.length)[self refresh];
    if(epoch!=CSBackupAccountEpoch() || epoch!=self.accountEpoch){self.statusText=@"入站事件所属账号已切换，本次未接收。";[self notify];if(completion)completion(NO);return;}
    if(!self.ready || self.loading || self.saving || ![self accountValid:self.accountID epoch:epoch]){[self enqueueSession:session wrap:wrap epoch:epoch pat:NO completion:completion];return;}
    NSMutableDictionary *event=[CSAutomationEventFromWrap(wrap,self.accountID,[session isKindOfClass:NSString.class]?session:@"") mutableCopy];
    event[@"arrivalElapsed"]=@(self.elapsedTime);event[@"arrivalWall"]=@(self.currentDate.timeIntervalSince1970);
    [self receiveEvent:event pat:NO completion:completion];
}

- (void)receivePat:(id)pat conversation:(NSString *)conversation epoch:(NSUInteger)epoch {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self receivePat:pat conversation:conversation epoch:epoch];});return;}
    if(!self.started)[self start];else if(!self.ready || !self.accountID.length)[self refresh];
    if(epoch!=CSBackupAccountEpoch() || epoch!=self.accountEpoch){self.statusText=@"拍动事件所属账号已切换，本次未接收。";[self notify];return;}
    if(!self.ready || self.loading || self.saving || ![self accountValid:self.accountID epoch:epoch]){[self enqueueSession:conversation wrap:pat epoch:epoch pat:YES completion:nil];return;}
    NSMutableDictionary *event=[CSAutomationEventFromPat(pat,self.accountID,conversation) mutableCopy];
    event[@"arrivalElapsed"]=@(self.elapsedTime);event[@"arrivalWall"]=@(self.currentDate.timeIntervalSince1970);
    [self receiveEvent:event pat:YES completion:nil];
}

- (void)receiveEvent:(NSDictionary *)event pat:(BOOL)pat completion:(void (^)(BOOL))completion {
    NSTimeInterval now=event[@"arrivalWall"]?[event[@"arrivalWall"] doubleValue]:self.currentDate.timeIntervalSince1970,created=[event[@"created"] doubleValue];
    if(!event || !self.ready || ![event[@"account"] isEqual:self.accountID] || ![event[@"identifiers"] isKindOfClass:NSArray.class] || ![event[@"identifiers"] count]){if(completion)completion(NO);return;}
    BOOL own=[event[@"own"] boolValue];NSTimeInterval boundary=own?ceil(self.admissionBoundary):floor(self.admissionBoundary);
    // Native push/sync can instantiate the manager seconds after the incoming
    // message was created. Startup accepts that existing freshness window;
    // edits/restores/account changes still impose a new strict boundary. Own
    // callbacks always keep the startup boundary to avoid replaying our sends.
    if(!isfinite(created) || !isfinite(now) || ((own || self.hasExplicitAdmissionBoundary) && created<boundary) || created<now-120 || created>now+30){
        // An old event cannot create work, but a claim made before editing or
        // restoring must still keep AI from taking over its duplicate callback.
        if(!pat && completion)[self checkExistingTextClaim:event completion:completion];else if(completion)completion(NO);return;
    }
    NSArray *decisions=self.saving?@[]:CSAutomationDecisions(self.configuration,event,pat);
    if(!decisions.count){if(!pat && completion)[self checkExistingTextClaim:event completion:completion];else if(completion)completion(NO);return;}
    // Pure decisions currently return at most one text action, or the two
    // independent pat actions. AI waits only on the text admission completion.
    for(NSDictionary *decision in decisions)[self admitEvent:event decision:decision completion:pat?nil:completion];
}
- (void)checkExistingTextClaim:(NSDictionary *)event completion:(void (^)(BOOL))completion {
    CSAutomationLedger *ledger=self.ledger;NSArray *identifiers=event[@"identifiers"];NSDate *now=self.currentDate;
    dispatch_async(self.io,^{
        BOOL claimed=ledger && [ledger hasIdentifiers:identifiers action:@"text"];
        if(claimed){NSError *error=nil;[ledger claimIdentifiers:identifiers action:@"text" now:now error:&error];}
        dispatch_async(dispatch_get_main_queue(),^{completion(claimed);});
    });
}
- (void)admitEvent:(NSDictionary *)event decision:(NSDictionary *)decision completion:(void (^)(BOOL))completion {
    NSString *action=decision[@"action"];NSArray *identifiers=event[@"identifiers"];
    NSMutableSet *owners=[NSMutableSet set];NSMutableArray *relatedTasks=[NSMutableArray array];
    for(NSString *identifier in identifiers){CSAutomationAdmission *candidate=self.admissions[AdmissionKey(action,identifier)];if(candidate)[owners addObject:candidate];}
    NSSet *incoming=[NSSet setWithArray:identifiers];
    for(CSAutomationTask *task in self.tasks.allValues)if(!task.observing && !task.revoking && [task.decision[@"action"] isEqual:action] && [incoming intersectsSet:[NSSet setWithArray:task.event[@"identifiers"]]])[relatedTasks addObject:task];
    // A late callback can reveal that separately admitted local-only and
    // server-only observations are the same event. Cancel both old owners;
    // merging the durable aliases alone cannot retract their queued sends.
    if(owners.count+relatedTasks.count>1){
        for(CSAutomationAdmission *owner in owners)owner.suppressed=YES;
        for(CSAutomationTask *task in relatedTasks)[self.tasks removeObjectForKey:task.identifier];
    }
    CSAutomationAdmission *admission=owners.anyObject;
    if(admission){
        if(completion)[admission.completions addObject:[completion copy]];
        NSUInteger before=admission.identifiers.count;[admission.identifiers addObjectsFromArray:identifiers];if(before!=admission.identifiers.count)admission.revision++;
        for(NSString *identifier in identifiers)self.admissions[AdmissionKey(action,identifier)]=admission;return;
    }
    if(self.tasks.count+[NSSet setWithArray:self.admissions.allValues].count>=CSAutomationMaximumPending){self.statusText=@"自动任务较多，本次未接收。";[self notify];if(completion)completion(NO);return;}
    admission=[CSAutomationAdmission new];admission.event=event;admission.decision=decision;admission.action=action;admission.epoch=self.accountEpoch;
    admission.generation=self.configurationGeneration;admission.acceptedAt=event[@"arrivalElapsed"]?[event[@"arrivalElapsed"] doubleValue]:self.elapsedTime;admission.wakeAt=self.elapsedTime;admission.deadline=admission.acceptedAt+[decision[@"delay"] doubleValue]+CSAutomationLateAllowance;admission.identifiers=[NSMutableOrderedSet orderedSetWithArray:identifiers];admission.completions=[NSMutableArray array];
    if(completion)[admission.completions addObject:[completion copy]];
    for(NSString *identifier in identifiers)self.admissions[AdmissionKey(action,identifier)]=admission;
    [self persistAdmission:admission];
}
- (void)persistAdmission:(CSAutomationAdmission *)admission {
    if(admission.persisting || admission.suppressed)return;
    // Storage capability is established by the configuration/ledger reads and
    // the durable claim itself. The application's protected-data flag can be
    // NO while these files remain usable after the device's first unlock.
    if(!self.ready || !self.ledger){admission.wakeAt=self.elapsedTime+CSAutomationCapabilityRetry;[self scheduleWakeup];return;}
    admission.persisting=YES;
    CSAutomationLedger *ledger=self.ledger;NSArray *identifiers=admission.identifiers.array;NSUInteger revision=admission.revision;NSDate *now=self.currentDate;
    dispatch_async(self.io,^{
        NSError *error=nil;BOOL fresh=NO,claimed=NO;
        if(ledger && CSBackupIsReady() && !CSBackupAccountIsSuspended() && CSBackupAccountEpoch()==admission.epoch){
            fresh=[ledger claimIdentifiers:identifiers action:admission.action now:now error:&error];
            claimed=fresh || (!error && [ledger hasIdentifiers:identifiers action:admission.action]);
        }
        dispatch_async(dispatch_get_main_queue(),^{
            admission.persisting=NO;
            admission.ownsClaim|=fresh;admission.claimed|=claimed;
            BOOL sameToken=admission.epoch==self.accountEpoch && admission.epoch==CSBackupAccountEpoch() && admission.generation==self.configurationGeneration && [admission.event[@"account"] isEqual:self.accountID] && !admission.suppressed;
            BOOL storageBlocked=CSAutomationStorageErrorIsRetryable(error);
            BOOL temporarilyBlocked=!CSBackupIsReady() || CSBackupAccountIsSuspended() || ![self accountValid:self.accountID epoch:self.accountEpoch];
            if(!claimed && sameToken && (storageBlocked || (!error && temporarilyBlocked)) && self.elapsedTime<=admission.deadline){
                if(storageBlocked){self.ready=NO;self.ledger=nil;self.nextLoadAttempt=self.elapsedTime+CSAutomationCapabilityRetry;}
                admission.wakeAt=self.elapsedTime+CSAutomationCapabilityRetry;self.statusText=storageBlocked?@"自动功能运行记录暂不可写，保留事件等待恢复。":@"持久认领前账号暂不可用，保留事件等待恢复。";[self notify];[self scheduleWakeup];return;
            }
            if(claimed && revision!=admission.revision){[self persistAdmission:admission];return;}
            for(NSString *identifier in admission.identifiers)if(self.admissions[AdmissionKey(admission.action,identifier)]==admission)[self.admissions removeObjectForKey:AdmissionKey(admission.action,identifier)];
            BOOL current=admission.epoch==self.accountEpoch && admission.generation==self.configurationGeneration && [admission.event[@"account"] isEqual:self.accountID] && !self.saving;
            // Even a duplicate durable claim suppresses a later AI attempt.
            // A partial/uncertain alias write never starts new outbound work.
            if(claimed && admission.ownsClaim && current && !admission.suppressed){
                CSAutomationTask *task=[CSAutomationTask new];task.identifier=NSUUID.UUID.UUIDString;task.account=admission.event[@"account"];task.epoch=admission.epoch;task.generation=admission.generation;
                task.event=admission.event;task.decision=admission.decision;task.due=admission.acceptedAt+[admission.decision[@"delay"] doubleValue];task.wakeAt=task.due;task.deadline=task.due+CSAutomationLateAllowance;
                NSArray *contents=admission.decision[@"contents"];if(contents.count)task.text=contents[arc4random_uniform((uint32_t)contents.count)];
                task.revokeDelay=[self.configuration[@"patBack"][@"revokeDelay"] doubleValue];
                self.tasks[task.identifier]=task;
            }else if(error && current){self.ready=NO;self.ledger=nil;self.nextLoadAttempt=self.elapsedTime+CSAutomationCapabilityRetry;self.statusText=error.localizedDescription?:@"自动动作认领失败，已认领任务保留等待配置恢复。";[self notify];}
            NSArray *waiters=[admission.completions copy];[admission.completions removeAllObjects];
            for(void (^waiter)(BOOL) in waiters)waiter(admission.claimed);
            [self processPending];
        });
    });
    [self scheduleWakeup];
}
- (NSString *)mentionNameForTask:(CSAutomationTask *)task {
    NSString *sender=task.event[@"sender"],*conversation=task.event[@"conversation"];
    NSString *name=CSGroupChatMemberName(conversation,sender);
    return name.length?name:sender;
}
- (id)quoteSourceForTask:(CSAutomationTask *)task {
    id source=task.event[@"source"];
    if(CSMessageNativeUnsigned(source,@"m_n64MesSvrID"))return source;
    unsigned long long local=CSMessageNativeUnsigned(source,@"m_uiMesLocalID");if(!local || local>UINT_MAX)return source;
    id manager=[self.environment serviceNamed:@"CMessageMgr"];
    if(CSMessageNativeSupports(manager,@"GetMsg:LocalID:",@"@",@[@"@",@"I"])){
        id updated=CSMessageNativeInvoke(manager,@"GetMsg:LocalID:",@[task.event[@"conversation"],@(local)]);
        NSArray *aliases=CSAutomationMessageIdentifiers(updated,task.account,task.event[@"conversation"]);
        for(NSString *identifier in aliases)if([task.event[@"identifiers"] containsObject:identifier])return updated;
    }return source;
}
- (void)submitTextTask:(CSAutomationTask *)task {
    if(!task.text.length){[self.tasks removeObjectForKey:task.identifier];self.statusText=@"回复文案为空，本次自动任务已取消。";[self notify];return;}
    if(![self canSubmitTask:task cleanup:NO]){[self pauseTask:task reason:[self availabilityReason]?:@"会话资料暂不可用"];return;}
    BOOL mention=[task.event[@"group"] boolValue] && [task.decision[@"mention"] boolValue];
    NSString *text=mention?[NSString stringWithFormat:@"@%@\u2005%@",[self mentionNameForTask:task],task.text]:task.text;
    CSMessagePreparedSend *route=nil;
    if([task.decision[@"quote"] boolValue]){
        id source=[self quoteSourceForTask:task];
        if(!CSMessageNativeUnsigned(source,@"m_n64MesSvrID")){task.wakeAt=MIN(task.deadline+0.01,self.elapsedTime+0.5);self.statusText=@"原消息尚无服务器编号，等待后引用回复。";[self notify];return;}
        route=[self.sender prepareAutomationQuote:text source:source targetID:task.event[@"conversation"] accountID:task.account];
    }else if(mention)route=[self.sender prepareGroupText:text mentions:@[task.event[@"sender"]] targetID:task.event[@"conversation"] accountID:task.account];
    else route=[self.sender prepareScheduledText:text targetID:task.event[@"conversation"] accountID:task.account];
    if(!route){[self pauseTask:task reason:@"原生发送接口或引用条件暂不可用"];return;}
    CSAutomationMarkOwnedSend(route.outputWrap);CSAutomationRememberOwnedSend(route.outputWrap,task.account,task.event[@"conversation"]);
    __weak typeof(self) weakSelf=self;route.submissionStillAuthorized=^BOOL{return [weakSelf canSubmitTask:task cleanup:NO] && weakSelf.elapsedTime<=task.deadline;};
    __block CSMessageActionSubmissionState result=CSMessageActionSubmissionStateFailedBeforeAcceptance;
    CSBackupPerformAtAccountEpoch(task.epoch,^{if(route.submissionStillAuthorized())result=[route submit];});
    CSAutomationRememberOwnedSend(route.outputWrap,task.account,task.event[@"conversation"]);
    if(!route.nativeHandoffReturned && result==CSMessageActionSubmissionStateFailedBeforeAcceptance && ![self permanentReasonForTask:task cleanup:NO]){[self pauseTask:task reason:[self availabilityReason]?:@"微信发送条件暂不可用"];return;}
    [self.tasks removeObjectForKey:task.identifier];
    self.statusText=route.nativeHandoffReturned?@"自动回复已提交微信，不代表对方已收到。":result==CSMessageActionSubmissionStateUnknown?@"发送结果不明，不会自动重发。":@"账号或设置已变化，本次自动任务已取消。";[self notify];
}

- (void)patResult:(BOOL)success task:(CSAutomationTask *)task {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self patResult:success task:task];});return;}
    if(self.tasks[task.identifier]!=task || !task.observing || task.resultConsumed)return;
    task.resultConsumed=YES;CSAutomationCancelPatObservation(task.sendPat);task.observing=NO;
    NSString *invalid=[self permanentReasonForTask:task cleanup:YES];
    if(!success || self.elapsedTime>task.deadline || invalid){[self.tasks removeObjectForKey:task.identifier];self.statusText=invalid?:success?@"原生回拍成功确认超时，本次不安排撤回。":@"原生回拍未成功，本次不安排撤回。";}
    else{task.revoking=YES;task.due=self.elapsedTime+task.revokeDelay;task.wakeAt=task.due;task.deadline=task.due+CSAutomationLateAllowance;self.statusText=@"回拍已获原生成功确认，等待精确撤回；暂不可用时保留至恢复。";}
    [self notify];[self scheduleWakeup];
}

- (void)submitPatTask:(CSAutomationTask *)task {
    if(![self canSubmitTask:task cleanup:NO]){[self pauseTask:task reason:[self availabilityReason]?:@"会话资料暂不可用"];return;}
    __weak typeof(self) weakSelf=self;__block BOOL denied=NO;BOOL (^valid)(void)=^BOOL{BOOL allowed=[weakSelf canSubmitTask:task cleanup:NO] && weakSelf.elapsedTime<=task.deadline;if(!allowed)denied=YES;return allowed;};
    __block id sendPat=nil;__block BOOL deferred=NO;
    CSBackupPerformAtAccountEpoch(task.epoch,^{if(valid())sendPat=[self.native sendPatTo:task.event[@"sender"] conversation:task.event[@"conversation"] account:task.account valid:valid deferred:&deferred];});
    if(!sendPat && (denied || deferred) && ![self permanentReasonForTask:task cleanup:NO]){[self pauseTask:task reason:[self availabilityReason]?:@"回拍提交前条件暂不可用"];return;}
    [self.tasks removeObjectForKey:task.identifier];
    if(!sendPat){self.statusText=@"微信未确认接受本次回拍（原生限频、接口或结果不明），不会盲目重发。";[self notify];return;}
    self.statusText=@"回拍已提交微信，等待原生结果。";
    if([self.configuration[@"patBack"][@"revoke"] boolValue] && ![self permanentReasonForTask:task cleanup:YES]){
        task.sendPat=sendPat;task.observing=YES;task.deadline=self.elapsedTime+CSAutomationObservationAllowance;task.wakeAt=task.deadline;self.tasks[task.identifier]=task;
        __weak CSAutomationTask *weakTask=task;CSAutomationObservePatResult(sendPat,^(BOOL success){CSAutomationTask *live=weakTask;if(live)[weakSelf patResult:success task:live];});
    }[self notify];
}

- (void)processPending {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self processPending];});return;}
    if(self.processing)return;self.processing=YES;NSTimeInterval now=self.elapsedTime;
    if(!isfinite(now)){[self cancelTasksIncludingCleanup:YES];self.statusText=@"无法读取单调时钟，自动任务已取消。";[self notify];self.processing=NO;return;}
    if((self.waitingIngress.count || self.tasks.count || self.admissions.count) && !self.loading && !self.ready)[self refresh];
    for(NSDictionary *entry in [self.waitingIngress copy])if(now>[entry[@"expires"] doubleValue]){[self.waitingIngress removeObjectIdenticalTo:entry];void (^completion)(BOOL)=entry[@"completion"];completion(NO);self.statusText=@"入站事件等待配置超过最大 10 分钟，本次不补发。";[self notify];}
    [self drainWaitingIngress];
    for(CSAutomationAdmission *admission in [NSSet setWithArray:self.admissions.allValues]){
        if(now>admission.deadline){
            admission.suppressed=YES;for(NSString *identifier in admission.identifiers)if(self.admissions[AdmissionKey(admission.action,identifier)]==admission)[self.admissions removeObjectForKey:AdmissionKey(admission.action,identifier)];
            NSArray *waiters=[admission.completions copy];[admission.completions removeAllObjects];for(void (^waiter)(BOOL) in waiters)waiter(admission.claimed);
            self.statusText=@"持久认领等待已超过延迟到期后 5 分钟，本次未发送。";[self notify];
        }else if(!admission.persisting && now>=admission.wakeAt)[self persistAdmission:admission];
    }
    for(CSAutomationTask *task in self.tasks.allValues){
        if(self.tasks[task.identifier]!=task)continue;BOOL cleanup=task.observing || task.revoking;NSString *invalid=[self permanentReasonForTask:task cleanup:cleanup];
        if(now>task.deadline || invalid){
            if(task.observing)CSAutomationCancelPatObservation(task.sendPat);[self.tasks removeObjectForKey:task.identifier];
            self.statusText=invalid?:task.observing?@"30 秒内未确认回拍结果，本次不安排撤回。":@"自动任务超过延迟到期后 5 分钟，未补发（账号、授权或微信发送条件未恢复）。";[self notify];continue;
        }
        if(task.observing){if(now>=task.deadline){CSAutomationCancelPatObservation(task.sendPat);[self.tasks removeObjectForKey:task.identifier];self.statusText=@"30 秒内未确认回拍结果，本次不安排撤回。";[self notify];}continue;}
        NSString *unavailable=[self availabilityReason];if(unavailable){[self pauseTask:task reason:unavailable];continue;}
        if(now<task.wakeAt)continue;
        @try {
            if(task.revoking){
                __weak typeof(self) weakSelf=self;__block BOOL denied=NO;
                BOOL (^valid)(void)=^BOOL{BOOL allowed=[weakSelf canSubmitTask:task cleanup:YES] && weakSelf.elapsedTime<=task.deadline;if(!allowed)denied=YES;return allowed;};
                __block BOOL revoked=NO,deferred=NO;CSBackupPerformAtAccountEpoch(task.epoch,^{if(valid())revoked=[self.native revokePat:task.sendPat conversation:task.event[@"conversation"] account:task.account valid:valid deferred:&deferred];});
                if(!revoked && (denied || deferred) && ![self permanentReasonForTask:task cleanup:YES]){[self pauseTask:task reason:[self availabilityReason]?:@"撤回提交前条件暂不可用"];continue;}
                [self.tasks removeObjectForKey:task.identifier];self.statusText=revoked?@"本次回拍的撤回已交给微信处理。":@"本次回拍已不符合原生撤回条件或结果不明，未撤回其他拍动且不会盲目重试。";[self notify];
            }else if([task.decision[@"action"] isEqual:@"patBack"])[self submitPatTask:task];else [self submitTextTask:task];
        }@catch(__unused NSException *exception){if(task.observing)CSAutomationCancelPatObservation(task.sendPat);[self.tasks removeObjectForKey:task.identifier];self.statusText=@"原生操作结果不明，不会自动重试。";[self notify];}
    }
    self.processing=NO;[self scheduleWakeup];
}

- (void)scheduleWakeup {
    if(self.timer){dispatch_source_cancel(self.timer);self.timer=nil;}
    NSTimeInterval next=INFINITY,now=self.elapsedTime;
    for(CSAutomationTask *task in self.tasks.allValues)next=MIN(next,MIN(task.wakeAt,task.deadline+0.01));
    for(NSDictionary *entry in self.waitingIngress)next=MIN(next,MIN([entry[@"expires"] doubleValue]+0.01,now+CSAutomationCapabilityRetry));
    for(CSAutomationAdmission *admission in [NSSet setWithArray:self.admissions.allValues])next=MIN(next,admission.persisting?admission.deadline+0.01:MIN(admission.deadline+0.01,admission.wakeAt));
    if(!isfinite(now) || !isfinite(next))return;
    self.timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer,dispatch_time(DISPATCH_TIME_NOW,(int64_t)(MAX(0.01,next-now)*NSEC_PER_SEC)),DISPATCH_TIME_FOREVER,10*NSEC_PER_MSEC);
    __weak typeof(self) weakSelf=self;dispatch_source_set_event_handler(self.timer,^{[weakSelf processPending];});dispatch_resume(self.timer);
}

@end
