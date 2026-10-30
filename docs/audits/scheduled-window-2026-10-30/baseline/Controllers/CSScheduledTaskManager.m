#import "CSScheduledTaskManager.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSCloseFriendBridge.h"
#import "CSAuthorizationManager.h"
#import "CSGroupNativeBridge.h"
#import <UIKit/UIKit.h>
NSNotificationName const CSScheduledTasksDidChange=@"CSScheduledTasksDidChange";
@interface CSScheduledTaskManager ()
@property CSScheduledTaskStore *store;
@property CSMessageNativeEnvironment *environment;
@property CSMessageSendAdapter *sender;
@property dispatch_source_t timer;
@property BOOL started;
@property BOOL refreshing;
@property NSUInteger epoch,operationGeneration;
@property BOOL loadingStore;
@property(nonatomic,readwrite) BOOL savingConfiguration;
@property CSScheduledTaskStore *runningStore;
@property NSTimeInterval runCooldownUntil,runDeadline;
@end
@implementation CSScheduledTaskManager
+ (instancetype)sharedManager { static id manager; static dispatch_once_t once; dispatch_once(&once,^{ manager=[self new]; }); return manager; }
- (instancetype)init { if ((self=[super init])) { _environment=[CSMessageNativeEnvironment new]; _sender=[[CSMessageSendAdapter alloc] initWithEnvironment:_environment]; } return self; }
- (void)start {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self start]; }); return; }
    if (_started) return; _started=YES;
    for (NSString *name in @[UIApplicationDidBecomeActiveNotification,UIApplicationSignificantTimeChangeNotification,NSSystemTimeZoneDidChangeNotification,@"CSBackupAccountChanged",CSCloseFriendPolicyDidChangeNotification])
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [self refresh];
}
- (void)changed:(NSNotification *)note { (void)note; dispatch_async(dispatch_get_main_queue(),^{ [self refresh]; }); }
- (void)stopTimer { if (_timer) { dispatch_source_cancel(_timer); _timer=nil; } }
- (NSTimeInterval)elapsedTime {return NSProcessInfo.processInfo.systemUptime;}
- (NSURL *)fileURLForAccount:(NSString *)account {
    NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
    return CSScheduledTaskFileURL([library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES],account);
}
- (void)loadCurrentStore {
    if(self.loadingStore)return;CSScheduledTaskStore *store=self.store;NSUInteger epoch=self.epoch;self.loadingStore=YES;
    [store loadWithCompletion:^(BOOL success,NSError *error){
        (void)error;if(self.store!=store || self.epoch!=epoch)return;self.loadingStore=NO;
        if(success || ![self accountValid:store.account epoch:epoch])[self refresh];else [self notify];
    }];
}
- (void)refresh {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self refresh];});return;}
    if(self.refreshing)return;self.refreshing=YES;[self stopTimer];
    NSString *account=CSBackupIsReady() && !CSBackupAccountIsSuspended()?[self.environment currentAccountID]:nil;
    NSUInteger epoch=CSBackupAccountEpoch();
    if(!account.length || ![self.store.account isEqual:account] || self.epoch!=epoch){
        [self.store invalidate];self.store=nil;self.epoch=epoch;self.operationGeneration++;self.loadingStore=NO;self.savingConfiguration=NO;self.runningStore=nil;
        if(account.length){
            self.store=[[CSScheduledTaskStore alloc]initWithURL:[self fileURLForAccount:account] account:account];
        }
    }
    if(self.store && !self.store.ready){[self loadCurrentStore];self.refreshing=NO;[self notify];return;}
    if(self.store.ready && self.store.enabled && !self.loadingStore && !self.savingConfiguration && !self.runningStore){
        NSDate *now=NSDate.date;NSDictionary *first=nil;
        for(NSDictionary *task in self.store.tasks)if([task[@"enabled"] boolValue] && task[@"nextRun"] && (!first || [task[@"nextRun"] compare:first[@"nextRun"]]==NSOrderedAscending))first=task;
        if(first && [first[@"nextRun"] compare:now]!=NSOrderedDescending && self.elapsedTime>=self.runCooldownUntil)[self run:first now:now];
        NSDate *next=nil;
        for(NSDictionary *task in self.store.tasks)if([task[@"enabled"] boolValue] && task[@"nextRun"] && (!next || [task[@"nextRun"] compare:next]==NSOrderedAscending))next=task[@"nextRun"];
        if(next && self.store.ready && !self.runningStore){
            NSTimeInterval delay=MAX(1,[next timeIntervalSinceNow]);self.timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
            dispatch_source_set_timer(self.timer,dispatch_walltime(NULL,(int64_t)(MIN(delay,86400*30)*NSEC_PER_SEC)),DISPATCH_TIME_FOREVER,250*NSEC_PER_MSEC);
            __weak typeof(self) weakSelf=self;dispatch_source_set_event_handler(self.timer,^{[weakSelf refresh];});dispatch_resume(self.timer);
        }
    }
    self.refreshing=NO;[self notify];
}
- (BOOL)accountValid:(NSString *)account epoch:(NSUInteger)epoch {
    return CSBackupIsReady() && !CSBackupAccountIsSuspended() && CSBackupAccountEpoch()==epoch && [[_environment currentAccountID] isEqual:account];
}
- (BOOL)targetAllowed:(NSString *)target {
    if ([target isEqual:@"filehelper"]) return YES;
    // Close-friend concealment only changes presentation. Scheduled delivery
    // continues to validate the account, authorization and actual recipient.
    id manager=[_environment serviceNamed:@"CContactMgr"];
    id contact=nil;
    for (NSString *selector in @[@"getContactByName:",@"getContactByNameFromDB:"]) if (CSMessageNativeSupports(manager,selector,@"@",@[@"@"])) { contact=CSMessageNativeInvoke(manager,selector,@[target]); if (contact) break; }
    if (![CSGroupReadObject(contact,@"m_nsUsrName") isEqual:target]) return NO;
    CSGroupRowCategory category=CSGroupCategoryForContact(contact); return category==CSGroupRowCategoryPrivate || category==CSGroupRowCategoryGroup;
}
- (BOOL)runSnapshotCurrent:(CSScheduledTaskStore *)store epoch:(NSUInteger)epoch generation:(NSUInteger)generation claim:(NSDictionary *)claim {
    if(self.store!=store || self.runningStore!=store || self.epoch!=epoch || self.operationGeneration!=generation || self.elapsedTime>self.runDeadline || self.savingConfiguration || !store.ready || !store.enabled || !CSBackupIsReady() || CSBackupAccountIsSuspended() || CSBackupAccountEpoch()!=epoch)return NO;
    // A single-use task may turn itself off while advancing its durable claim.
    // Match the exact post-claim task so edits/deletion cannot revive its old text.
    NSString *identifier=claim[@"task"][@"id"];NSDictionary *current=nil;
    for(NSDictionary *task in store.tasks)if([task[@"id"] isEqual:identifier]){current=task;break;}
    return [current isEqual:claim[@"taskAfterClaim"]];
}
- (BOOL)runCurrent:(CSScheduledTaskStore *)store epoch:(NSUInteger)epoch generation:(NSUInteger)generation claim:(NSDictionary *)claim {
    if(![self runSnapshotCurrent:store epoch:epoch generation:generation claim:claim] || ![self accountValid:store.account epoch:epoch] || !CSAuthorizationManager.sharedManager.isAuthorized || ![self targetAllowed:claim[@"task"][@"target"]])return NO;
    // Native account/contact queries can synchronously reenter editing or an
    // account switch. Finish with immutable state only, before native handoff.
    return [self runSnapshotCurrent:store epoch:epoch generation:generation claim:claim];
}
- (void)finishedRunForStore:(CSScheduledTaskStore *)store {
    if(self.runningStore!=store)return;self.runningStore=nil;self.runCooldownUntil=self.elapsedTime+1;
    if(self.store==store && self.started && store.ready)[self refresh];else [self notify];
}
- (void)run:(NSDictionary *)task now:(NSDate *)now {
    NSAssert(NSThread.isMainThread,@"Scheduled sends run on main");
    if(self.runningStore || self.savingConfiguration || !self.store.ready)return;
    CSScheduledTaskStore *store=self.store;NSUInteger epoch=self.epoch,generation=++self.operationGeneration;NSTimeInterval started=self.elapsedTime;self.runningStore=store;[self stopTimer];
    [store claimTask:task[@"id"] now:now completion:^(NSDictionary *claim,NSError *error){
        (void)error;if(!claim){[self finishedRunForStore:store];return;}
        if(self.runningStore==store && self.operationGeneration==generation){NSTimeInterval limit=[claim[@"task"][@"catchUp"] boolValue]?600:30;self.runDeadline=started+MAX(0,limit-[now timeIntervalSinceDate:claim[@"occurrence"]]);}
        NSString *result=@"failed",*detail=@"账号或任务状态已改变，本次未发送。";
        @try {
            if([self runCurrent:store epoch:epoch generation:generation claim:claim]){
                NSDictionary *claimedTask=claim[@"task"];
                CSMessagePreparedSend *route=[self.sender prepareScheduledText:claimedTask[@"text"] targetID:claimedTask[@"target"] accountID:store.account];
                if(route){
                    __weak typeof(self) weakSelf=self;
                    route.submissionStillAuthorized=^BOOL{return [weakSelf runCurrent:store epoch:epoch generation:generation claim:claim];};
                    __block CSMessageActionSubmissionState state=CSMessageActionSubmissionStateFailedBeforeAcceptance;
                    CSBackupPerformAtAccountEpoch(epoch,^{if([self runCurrent:store epoch:epoch generation:generation claim:claim])state=[route submit];});
                    if(route.nativeHandoffReturned){result=@"submitted";detail=@"已提交微信发送；不代表对方已收到。";}
                    else if(state==CSMessageActionSubmissionStateUnknown){result=@"unknown";detail=@"微信发送结果未确认；不会自动重发。";}
                }else detail=@"当前微信发送接口不可用，本次未发送。";
            }
        }@catch(__unused NSException *e){result=@"unknown";detail=@"发送过程异常，结果未确认；不会自动重发。";}
        [store finishClaim:claim[@"id"] result:result detail:detail completion:^(BOOL success,NSError *failure){(void)success;(void)failure;[self finishedRunForStore:store];}];
    }];
}
- (void)notify {[NSNotificationCenter.defaultCenter postNotificationName:CSScheduledTasksDidChange object:self];}
- (NSString *)statusText {
    if(!self.store)return @"请登录微信后设置";
    if(self.loadingStore)return @"正在读取任务…";
    if(self.savingConfiguration)return @"正在保存任务…";
    if(!self.store.ready)return self.store.error.localizedDescription?:@"任务存储不可用";
    return self.store.enabled?@"已开启 · 按最近一次到期时间调度":@"已关闭 · 保留任务，不补发关闭期间的消息";
}
- (BOOL)checkEditorAccount:(NSString *)account error:(NSError **)error {
    if(!self.store.ready || ![self.store.account isEqual:account] || ![self accountValid:account epoch:self.epoch]){if(error)*error=self.store.error?:[NSError errorWithDomain:CSScheduledTaskErrorDomain code:2 userInfo:@{NSLocalizedDescriptionKey:@"账号已改变或任务存储不可用，请重新打开定时任务。"}];return NO;}return YES;
}
- (void)editAccount:(NSString *)account work:(void(^)(CSScheduledTaskStore *,CSScheduledTaskStoreCompletion))work completion:(CSScheduledTaskStoreCompletion)completion {
    NSAssert(NSThread.isMainThread,@"Task editing runs on main");NSError *error=nil;
    if(![self checkEditorAccount:account error:&error] || self.savingConfiguration){NSError *failure=error?:[NSError errorWithDomain:CSScheduledTaskErrorDomain code:2 userInfo:@{NSLocalizedDescriptionKey:@"正在保存任务，请稍后重试。"}];dispatch_async(dispatch_get_main_queue(),^{completion(NO,failure);});return;}
    CSScheduledTaskStore *store=self.store;NSUInteger epoch=self.epoch,generation=++self.operationGeneration;self.savingConfiguration=YES;[self stopTimer];[self notify];
    work(store,^(BOOL success,NSError *failure){
        if(self.store!=store || self.epoch!=epoch || self.operationGeneration!=generation || ![self accountValid:account epoch:epoch]){completion(NO,[NSError errorWithDomain:CSScheduledTaskErrorDomain code:2 userInfo:@{NSLocalizedDescriptionKey:@"账号或任务状态已改变，本次操作已结束。"}]);return;}
        self.savingConfiguration=NO;if(success)[self refresh];else [self notify];completion(success,failure);
    });
}
- (void)setEnabled:(BOOL)enabled account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion {
    [self editAccount:account work:^(CSScheduledTaskStore *store,CSScheduledTaskStoreCompletion done){[store setEnabled:enabled now:NSDate.date completion:done];} completion:completion];
}
- (void)saveTask:(NSDictionary *)task account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion {
    [self editAccount:account work:^(CSScheduledTaskStore *store,CSScheduledTaskStoreCompletion done){[store saveTask:task now:NSDate.date completion:done];} completion:completion];
}
- (void)removeTask:(NSString *)identifier account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion {
    [self editAccount:account work:^(CSScheduledTaskStore *store,CSScheduledTaskStoreCompletion done){[store removeTask:identifier completion:done];} completion:completion];
}
- (NSString *)displayNameForTarget:(NSString *)target {
    if ([target isEqual:@"filehelper"]) return @"文件传输助手";
    if (CSCloseFriendShouldHideUserName(target,CSCloseFriendSurfaceSession)) return @"受保护的会话";
    id contact=nil; id manager=[_environment serviceNamed:@"CContactMgr"];
    @try { if (CSMessageNativeSupports(manager,@"getContactByName:",@"@",@[@"@"])) contact=CSMessageNativeInvoke(manager,@"getContactByName:",@[target]); } @catch (__unused NSException *e) {}
    for (NSString *key in @[@"m_nsRemark",@"m_nsNickName"]) { id value=CSGroupReadObject(contact,key); if ([value isKindOfClass:NSString.class] && [value length]) return value; } return target;
}
@end
