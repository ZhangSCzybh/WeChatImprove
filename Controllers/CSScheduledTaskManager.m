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
@property NSUInteger epoch;
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
- (void)refresh {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self refresh]; }); return; }
    if (_refreshing) return; _refreshing=YES; [self stopTimer];
    NSString *account=CSBackupIsReady() && !CSBackupAccountIsSuspended()?[_environment currentAccountID]:nil;
    if (!account.length) { _store=nil; _refreshing=NO; [self notify]; return; }
    NSUInteger epoch=CSBackupAccountEpoch();
    if (![_store.account isEqual:account] || _epoch!=epoch) {
        _store=nil; _epoch=epoch;
        NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
        NSURL *url=CSScheduledTaskFileURL([library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES],account);
        _store=[[CSScheduledTaskStore alloc] initWithURL:url account:account]; [_store load];
    }
    if (!_store.ready) [_store load]; // Retry transient protection/storage failures on a later lifecycle event.
    NSDate *now=NSDate.date;
    if (_store.ready && _store.enabled) {
        NSDictionary *first=nil;
        for (NSDictionary *task in _store.tasks) if ([task[@"enabled"] boolValue] && task[@"nextRun"] && (!first || [task[@"nextRun"] compare:first[@"nextRun"]]==NSOrderedAscending)) first=task;
        if (first && [first[@"nextRun"] compare:now]!=NSOrderedDescending) [self run:first now:now];
        NSDate *next=nil;
        for (NSDictionary *task in _store.tasks) if ([task[@"enabled"] boolValue] && task[@"nextRun"] && (!next || [task[@"nextRun"] compare:next]==NSOrderedAscending)) next=task[@"nextRun"];
        if (next && _store.ready) {
            // Single one-shot wall-clock timer; bounded spacing when several tasks are due.
            NSTimeInterval delay=MAX(1,[next timeIntervalSinceNow]); _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL,(int64_t)(MIN(delay,86400*30)*NSEC_PER_SEC)),DISPATCH_TIME_FOREVER,250*NSEC_PER_MSEC);
            __weak typeof(self) weakSelf=self; dispatch_source_set_event_handler(_timer,^{ [weakSelf refresh]; }); dispatch_resume(_timer);
        }
    }
    _refreshing=NO; [self notify];
}
- (BOOL)accountValid:(NSString *)account epoch:(NSUInteger)epoch {
    return CSBackupIsReady() && !CSBackupAccountIsSuspended() && CSBackupAccountEpoch()==epoch && [[_environment currentAccountID] isEqual:account];
}
- (BOOL)targetAllowed:(NSString *)target {
    if ([target isEqual:@"filehelper"]) return YES;
    if (CSCloseFriendCurrentSnapshot().blocked || CSCloseFriendShouldHideUserName(target,CSCloseFriendSurfaceSession)) return NO;
    id manager=[_environment serviceNamed:@"CContactMgr"];
    id contact=nil;
    for (NSString *selector in @[@"getContactByName:",@"getContactByNameFromDB:"]) if (CSMessageNativeSupports(manager,selector,@"@",@[@"@"])) { contact=CSMessageNativeInvoke(manager,selector,@[target]); if (contact) break; }
    if (![CSGroupReadObject(contact,@"m_nsUsrName") isEqual:target]) return NO;
    CSGroupRowCategory category=CSGroupCategoryForContact(contact); return category==CSGroupRowCategoryPrivate || category==CSGroupRowCategoryGroup;
}
- (void)run:(NSDictionary *)task now:(NSDate *)now {
    CSScheduledTaskStore *store=_store; NSUInteger epoch=_epoch;
    NSDictionary *claim=[store claimTask:task[@"id"] now:now]; if (!claim) return;
    NSString *result=@"failed", *detail=@"账号或会话状态已改变，本次未发送。";
    @try {
        if (![self accountValid:store.account epoch:epoch]) detail=@"账号状态已改变，本次未发送。";
        else if (!CSAuthorizationManager.sharedManager.isAuthorized) detail=@"插件授权尚未就绪，本次未发送；请在插件设置中检查授权。";
        else if (![self targetAllowed:task[@"target"]]) detail=@"会话不可用或正受密友保护，本次未发送。";
        else {
            CSMessagePreparedSend *route=[_sender prepareScheduledText:task[@"text"] targetID:task[@"target"] accountID:store.account];
            if (route) {
                __weak typeof(self) weakSelf=self;
                route.submissionStillAuthorized=^BOOL { return [weakSelf accountValid:store.account epoch:epoch] && store.enabled && CSAuthorizationManager.sharedManager.isAuthorized && [weakSelf targetAllowed:task[@"target"]]; };
                __block CSMessageActionSubmissionState state=CSMessageActionSubmissionStateFailedBeforeAcceptance;
                CSBackupPerformAtAccountEpoch(epoch,^{ state=[route submit]; });
                if (route.nativeHandoffReturned) { result=@"submitted"; detail=@"已提交微信发送；不代表对方已收到。"; }
                else if (state==CSMessageActionSubmissionStateUnknown) { result=@"unknown"; detail=@"微信发送结果未确认；不会自动重发。"; }
            } else detail=@"当前微信发送接口不可用，本次未发送。";
        }
    } @catch (__unused NSException *e) { result=@"unknown"; detail=@"发送过程异常，结果未确认；不会自动重发。"; }
    [store finishClaim:claim[@"id"] result:result detail:detail];
}
- (void)notify { [NSNotificationCenter.defaultCenter postNotificationName:CSScheduledTasksDidChange object:self]; }
- (NSString *)statusText { if (!_store) return @"请登录微信后设置"; if (!_store.ready) return _store.error.localizedDescription?:@"任务存储不可用"; return _store.enabled?@"已开启 · 按最近一次到期时间调度":@"已关闭 · 保留任务，不补发关闭期间的消息"; }
- (BOOL)checkEditorAccount:(NSString *)account error:(NSError **)error {
    if (!_store.ready || ![_store.account isEqual:account] || ![self accountValid:account epoch:_epoch]) { if (error) *error=_store.error?:[NSError errorWithDomain:CSScheduledTaskErrorDomain code:2 userInfo:@{NSLocalizedDescriptionKey:@"账号已改变或任务存储不可用，请重新打开定时任务。"}]; return NO; } return YES;
}
- (BOOL)setEnabled:(BOOL)enabled account:(NSString *)account error:(NSError **)error { if (![self checkEditorAccount:account error:error]) return NO; BOOL ok=[_store setEnabled:enabled now:NSDate.date]; if (!ok && error) *error=_store.error; [self refresh]; return ok; }
- (BOOL)saveTask:(NSDictionary *)task account:(NSString *)account error:(NSError **)error { if (![self checkEditorAccount:account error:error]) return NO; BOOL ok=[_store saveTask:task now:NSDate.date]; if (!ok && error) *error=_store.error; [self refresh]; return ok; }
- (BOOL)removeTask:(NSString *)identifier account:(NSString *)account error:(NSError **)error { if (![self checkEditorAccount:account error:error]) return NO; BOOL ok=[_store removeTask:identifier]; if (!ok && error) *error=_store.error; [self refresh]; return ok; }
- (NSString *)displayNameForTarget:(NSString *)target {
    if ([target isEqual:@"filehelper"]) return @"文件传输助手";
    if (CSCloseFriendShouldHideUserName(target,CSCloseFriendSurfaceSession)) return @"受保护的会话";
    id contact=nil; id manager=[_environment serviceNamed:@"CContactMgr"];
    @try { if (CSMessageNativeSupports(manager,@"getContactByName:",@"@",@[@"@"])) contact=CSMessageNativeInvoke(manager,@"getContactByName:",@[target]); } @catch (__unused NSException *e) {}
    for (NSString *key in @[@"m_nsRemark",@"m_nsNickName"]) { id value=CSGroupReadObject(contact,key); if ([value isKindOfClass:NSString.class] && [value length]) return value; } return target;
}
@end
