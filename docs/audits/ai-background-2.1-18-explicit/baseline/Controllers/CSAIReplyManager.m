#import "CSAIReplyManager.h"
#import "CSAIReplyCoordinator.h"
#import "CSAIBackgroundSync.h"
#import "CSAINativeSyncObserver.h"
#import "CSBackgroundRunManager.h"
#import "CSAIMessageAdapter.h"
#import "CSAICredentialStore.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSBackupMutation.h"
#import "CSCloseFriendBridge.h"
#import "CSAuthorizationManager.h"
#import "CSGroupNativeBridge.h"
#import <UIKit/UIKit.h>
#import <stdatomic.h>
#import <os/lock.h>

NSNotificationName const CSAIReplyDidChange=@"CSAIReplyDidChange";
static atomic_bool CSAIMessageIngressEnabled;
static os_unfair_lock CSAIMessageIngressLock=OS_UNFAIR_LOCK_INIT;
static NSSet<NSString *> *CSAIMessageIngressSessions;
static NSUInteger CSAIMessageIngressEpoch;
BOOL CSAIReplyMessageIngressEnabled(void) {return atomic_load_explicit(&CSAIMessageIngressEnabled,memory_order_acquire);}
BOOL CSAIReplyMessageIngressAllowsSession(id session,NSUInteger epoch) {
    if(!CSAIReplyMessageIngressEnabled())return NO;
    // Retain Foundation values under the lock, then release it before inspecting
    // the caller's session. Never touch the Store or a native message off main.
    os_unfair_lock_lock(&CSAIMessageIngressLock);
    NSSet<NSString *> *sessions=CSAIMessageIngressSessions;
    NSUInteger publishedEpoch=CSAIMessageIngressEpoch;
    os_unfair_lock_unlock(&CSAIMessageIngressLock);
    if(!sessions || epoch!=publishedEpoch || epoch!=CSBackupAccountEpoch())return NO;
    return ![session isKindOfClass:NSString.class] || ![session length] || [sessions containsObject:session];
}
@interface CSAIEmptyCancellation : NSObject <CSAICancellable>
@end
@implementation CSAIEmptyCancellation
- (void)cancel {}
@end
// One owner spans credential I/O and the subsequent request. All state belongs
// to main, including cancellation and the shared 60-second deadline.
@interface CSAIConnectionTestOperation : NSObject <CSAICancellable>
@property(nonatomic) BOOL finished;
@property(nonatomic) NSUInteger phase;
@property(nonatomic) NSTimeInterval deadline;
@property(nonatomic,strong) id<CSAICancellable> child;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,copy) CSAICompletion completion;
- (void)attach:(id<CSAICancellable>)child phase:(NSUInteger)phase;
- (void)finishText:(NSString *)text error:(NSError *)error;
- (void)timedOut;
@end
@implementation CSAIConnectionTestOperation
- (void)attach:(id<CSAICancellable>)child phase:(NSUInteger)phase {
    if(self.finished || self.phase!=phase)[child cancel];else self.child=child;
}
- (void)finishText:(NSString *)text error:(NSError *)error {
    if(self.finished)return;self.finished=YES;self.phase++;
    self.child=nil;[self.timer invalidate];self.timer=nil;
    CSAICompletion completion=self.completion;self.completion=nil;if(completion)completion(text,error);
}
- (void)cancel {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self cancel];});return;}
    id<CSAICancellable> child=self.child;
    [self finishText:nil error:CSAIError(NSURLErrorCancelled,@"已取消连接测试。")];[child cancel];
}
- (void)timedOut {
    id<CSAICancellable> child=self.child;
    [self finishText:nil error:CSAIError(NSURLErrorTimedOut,@"AI 请求超时")];[child cancel];
}
- (void)dealloc {[_timer invalidate];[_child cancel];}
@end
@interface CSAIBackgroundSyncContext : NSObject
@property(nonatomic,weak) CSAIReplyManager *owner;
@property(nonatomic,weak) CSAIReplyStore *store;
@property(nonatomic,strong) NSDictionary *configuration;
@property(nonatomic,copy) NSString *account;
@property(nonatomic) NSUInteger epoch,generation;
@property(nonatomic) BOOL consumed;
@end
@implementation CSAIBackgroundSyncContext @end
@interface CSAIReplyManager () <CSAIReplyCoordinatorDelegate>
@property(nonatomic,strong,readwrite) CSAIReplyStore *store;
@property(nonatomic,readwrite) NSUInteger epoch;
@property CSMessageNativeEnvironment *environment;
@property CSMessageSendAdapter *sender;
@property CSAIClient *client;
@property CSAIReplyCoordinator *coordinator;
@property id<CSAICancellable> connectionTest;
@property NSUInteger testGeneration;
@property(nonatomic,copy,readwrite) NSString *connectionStatus;
@property BOOL started;
@property(nonatomic,strong) CSAIBackgroundSync *backgroundSync;
@property BOOL enteringForeground;
@property BOOL loadingStore;
@property NSUInteger savingConfiguration;
@property(nonatomic,strong) NSDictionary *ingressConfiguration;
@property(nonatomic,copy) NSSet<NSString *> *ingressSessions;
@property(nonatomic) NSUInteger backgroundSyncContextGeneration;
@property(nonatomic) BOOL backgroundSyncSnapshotCaptured;
@property(nonatomic,weak) CSAIReplyStore *backgroundSyncObservedStore;
@property(nonatomic,strong) NSDictionary *backgroundSyncObservedConfiguration;
@property(nonatomic,copy) NSString *backgroundSyncObservedAccount;
@property(nonatomic) NSUInteger backgroundSyncObservedEpoch,backgroundSyncObservedBackupEpoch;
@property(nonatomic,strong) CSAIBackgroundSyncContext *verifyingBackgroundSyncContext;
@end
@implementation CSAIReplyManager
+ (instancetype)sharedManager {static id manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (instancetype)init {
    if((self=[super init])){
        _environment=[CSMessageNativeEnvironment new];_sender=[[CSMessageSendAdapter alloc]initWithEnvironment:_environment];_client=[CSAIClient new];
        __weak typeof(self) weakSelf=self;
        _backgroundSync=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return [weakSelf backgroundSyncSchedulerEligible];} synchronize:^{[weakSelf requestBackgroundSync];}];
    }
    return self;
}
- (void)start {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self start];});return;}
    if(self.started)return;self.started=YES;
    for(NSString *name in @[@"CSBackupAccountChanged",CSAIReplyConfigurationDidChange,CSCloseFriendPolicyDidChangeNotification,UIApplicationDidBecomeActiveNotification,UIApplicationDidEnterBackgroundNotification,UIApplicationProtectedDataDidBecomeAvailable,CSBackgroundRunStateChangedNotification])
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self refresh];
}
- (void)changed:(NSNotification *)note {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self changed:note];});return;}
    if([note.name isEqual:UIApplicationDidEnterBackgroundNotification]){self.enteringForeground=NO;[self.store flushHistoryWithCompletion:nil];}
    dispatch_async(dispatch_get_main_queue(),^{
        // Close-friend visibility changes refresh settings without cancelling
        // enabled replies or their context. refresh still handles account changes.
        [self refresh];
    });
}
- (void)willEnterForeground:(NSNotification *)note {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self willEnterForeground:note];});return;}
    // UIApplication can still report Background during this notification.
    self.enteringForeground=YES;[self.backgroundSync stop];
}
- (void)notify {
    [self reconcileBackgroundSyncContext];
    NSDictionary *configuration=self.store.configuration;
    BOOL enabled=CSBackupIsReady() && !CSBackupAccountIsSuspended() && self.epoch==CSBackupAccountEpoch() && self.store.ready && self.coordinator && [configuration[@"enabled"] boolValue];
    // Store configurations are frozen property lists. Reuse this projection for
    // status/history notifications; build it only when configuration changes.
    if(enabled && configuration!=self.ingressConfiguration){
        NSMutableSet *sessions=[NSMutableSet set];
        NSDictionary *conversations=configuration[@"conversations"];
        for(NSString *session in conversations)if([conversations[session][@"enabled"] boolValue])[sessions addObject:session];
        self.ingressSessions=[sessions copy];self.ingressConfiguration=configuration;
    }else if(!enabled){self.ingressSessions=nil;self.ingressConfiguration=nil;}
    os_unfair_lock_lock(&CSAIMessageIngressLock);
    CSAIMessageIngressSessions=enabled?self.ingressSessions:nil;CSAIMessageIngressEpoch=self.epoch;
    os_unfair_lock_unlock(&CSAIMessageIngressLock);
    atomic_store_explicit(&CSAIMessageIngressEnabled,enabled,memory_order_release);
    [NSNotificationCenter.defaultCenter postNotificationName:CSAIReplyDidChange object:self];
}
- (void)invalidateConnectionTest {
    // Revoke ownership before cancellation, which may invoke a completion inline.
    id<CSAICancellable> task=self.connectionTest;self.connectionTest=nil;self.testGeneration++;self.connectionStatus=nil;[task cancel];
}
- (void)refresh {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self refresh];});return;}
    NSString *account=CSBackupIsReady() && !CSBackupAccountIsSuspended()?[self.environment currentAccountID]:nil;
    NSUInteger epoch=CSBackupAccountEpoch();
    if(!account.length || ![self.store.account isEqual:account] || self.epoch!=epoch){
        atomic_store_explicit(&CSAIMessageIngressEnabled,false,memory_order_release);
        [self.backgroundSync stop];
        [self.coordinator cancelAll];self.coordinator=nil;[self invalidateConnectionTest];
        [self.store invalidate];self.store=nil;self.epoch=epoch;self.loadingStore=NO;self.savingConfiguration=0;
        if(account.length){
            NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
            NSURL *root=[library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES];
            self.store=[[CSAIReplyStore alloc]initWithURL:CSAIReplyFileURL(root,account) account:account];
        }
    }
    if(self.store && !self.store.ready && !self.loadingStore){
        self.loadingStore=YES;CSAIReplyStore *store=self.store;NSUInteger loadEpoch=self.epoch;
        [store loadWithCompletion:^(BOOL success,NSError *error){
            (void)error;if(self.store!=store || self.epoch!=loadEpoch)return;
            self.loadingStore=NO;
            if(success)[self refresh];else {[self.coordinator cancelAll];self.coordinator=nil;[self.backgroundSync stop];[self notify];}
        }];
    }
    if(self.store.ready && !self.coordinator){self.coordinator=[[CSAIReplyCoordinator alloc]initWithStore:self.store client:self.client];self.coordinator.delegate=self;self.coordinator.imagePreparer=[CSAIImagePreparer new];}
    [self reconcileBackgroundSyncContext];[self.backgroundSync refresh];[self notify];
}
- (void)invalidateBackgroundSyncContext {
    self.backgroundSyncContextGeneration++;
    [self.backgroundSync invalidateVerifiedSync];
}
- (void)reconcileBackgroundSyncContext {
    if(!NSThread.isMainThread)return;
    CSAIReplyStore *store=self.store;NSDictionary *configuration=store.configuration;NSString *account=store.account;
    NSUInteger epoch=self.epoch,backupEpoch=CSBackupAccountEpoch();
    if(self.backgroundSyncSnapshotCaptured && self.backgroundSyncObservedStore==store &&
       self.backgroundSyncObservedConfiguration==configuration &&
       (self.backgroundSyncObservedAccount==account || [self.backgroundSyncObservedAccount isEqual:account]) &&
       self.backgroundSyncObservedEpoch==epoch && self.backgroundSyncObservedBackupEpoch==backupEpoch)return;
    // Publish the new snapshot before invalidation, whose eligibility callback
    // can itself reenter the manager. Identity revokes even equal replacements.
    self.backgroundSyncSnapshotCaptured=YES;self.backgroundSyncObservedStore=store;
    self.backgroundSyncObservedConfiguration=configuration;self.backgroundSyncObservedAccount=account;
    self.backgroundSyncObservedEpoch=epoch;self.backgroundSyncObservedBackupEpoch=backupEpoch;
    [self invalidateBackgroundSyncContext];
}
- (BOOL)matchesBackgroundSyncContext:(CSAIBackgroundSyncContext *)context {
    return context.owner==self && context.store && context.store==self.store &&
        context.configuration==self.store.configuration && [context.account isEqual:self.store.account] &&
        context.epoch==self.epoch && context.epoch==CSBackupAccountEpoch() &&
        context.generation==self.backgroundSyncContextGeneration && self.backgroundSync.active;
}
- (BOOL)backgroundSyncSchedulerEligible {
    BOOL eligible=[self allowsBackgroundSync];
    CSAIBackgroundSyncContext *context=self.verifyingBackgroundSyncContext;
    if(!context)return eligible;
    // verifiedFullSyncCompleted queries eligibility once more. Fence mutations
    // in that last native getter before the scheduler can record coverage.
    [self reconcileBackgroundSyncContext];
    return eligible && [self matchesBackgroundSyncContext:context];
}
- (id)captureBackgroundSyncContextForEpoch:(NSUInteger)epoch {
    if(!NSThread.isMainThread)return nil;
    [self reconcileBackgroundSyncContext];
    if(epoch!=self.epoch || epoch!=CSBackupAccountEpoch() || !self.backgroundSync.active)return nil;
    CSAIBackgroundSyncContext *context=[CSAIBackgroundSyncContext new];context.owner=self;context.store=self.store;
    context.configuration=self.store.configuration;context.account=self.store.account;context.epoch=epoch;
    context.generation=self.backgroundSyncContextGeneration;
    BOOL eligible=[self allowsBackgroundSync] && [self isCurrentAccount:context.account epoch:epoch];
    [self reconcileBackgroundSyncContext];
    if(!eligible){
        // A failed observer preflight must not submit the old wrapper. Never
        // stop a replacement account/configuration that a getter installed.
        if([self matchesBackgroundSyncContext:context])[self.backgroundSync stop];
        return nil;
    }
    return [self matchesBackgroundSyncContext:context]?context:nil;
}
- (void)nativeFullSyncCompletedWithContext:(id)value {
    if(!NSThread.isMainThread || ![value isKindOfClass:CSAIBackgroundSyncContext.class])return;
    CSAIBackgroundSyncContext *context=value;
    if(context.owner!=self || context.consumed)return;
    context.consumed=YES;
    [self reconcileBackgroundSyncContext];
    if(![self matchesBackgroundSyncContext:context])return;
    BOOL eligible=[self allowsBackgroundSync] && [self isCurrentAccount:context.account epoch:context.epoch];
    [self reconcileBackgroundSyncContext];
    if(!eligible || ![self matchesBackgroundSyncContext:context])return;
    CSAIBackgroundSyncContext *previous=self.verifyingBackgroundSyncContext;
    self.verifyingBackgroundSyncContext=context;
    @try {[self.backgroundSync verifiedFullSyncCompleted];}
    @finally {self.verifyingBackgroundSyncContext=previous;}
}
- (BOOL)isCurrentAccount:(NSString *)account epoch:(NSUInteger)epoch {
    return NSThread.isMainThread && account.length && self.store.ready && [account isEqual:self.store.account] && epoch==self.epoch && epoch==CSBackupAccountEpoch() && CSBackupIsReady() && !CSBackupAccountIsSuspended() && [[self.environment currentAccountID] isEqual:account];
}
#if !TARGET_OS_IPHONE
- (BOOL)saveConfiguration:(NSDictionary *)configuration account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    if(![self isCurrentAccount:account epoch:epoch]){if(error)*error=CSAIError(20,@"账号或配置状态已改变，请重新打开 AI 设置。");return NO;}
    if(!CSAIReplyValidateConfiguration(configuration,error))return NO;
    BOOL connectionChanged=![CSAIConnectionIdentifier(configuration) isEqual:CSAIConnectionIdentifier(self.store.configuration)];
    if(connectionChanged){NSMutableDictionary *updated=[configuration mutableCopy];updated[@"verifiedConnection"]=@"";[updated removeObjectForKey:@"verifiedAt"];configuration=updated;}
    self.savingConfiguration++;[self invalidateBackgroundSyncContext];
    __block BOOL saved=NO;__block NSError *failure=nil;
    CSBackupResourceMutationScope();
    CSBackupPerformAtAccountEpoch(epoch,^{if([self isCurrentAccount:account epoch:epoch])saved=[self.store saveConfiguration:configuration error:&failure];});
    if(self.savingConfiguration)self.savingConfiguration--;
    if(!saved){[self reconcileBackgroundSyncContext];[self.backgroundSync refresh];[self notify];if(error)*error=failure?:CSAIError(20,@"账号状态已改变，本次未保存。");return NO;}
    if(connectionChanged)[self invalidateConnectionTest];
    [self.coordinator configurationDidChange];[self reconcileBackgroundSyncContext];[self.backgroundSync refresh];[self notify];return YES;
}
#endif
- (void)saveConfiguration:(NSDictionary *)configuration account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion {
    if(self.savingConfiguration){completion(NO,CSAIError(20,@"配置正在保存，请完成后再修改。"));return;}
    if(![self isCurrentAccount:account epoch:epoch]){completion(NO,CSAIError(20,@"账号或配置状态已改变，请重新打开 AI 设置。"));return;}
    NSError *error=nil;if(!CSAIReplyValidateConfiguration(configuration,&error)){completion(NO,error);return;}
    CSAIReplyStore *store=self.store;NSDictionary *expected=store.configuration;
    BOOL connectionChanged=![CSAIConnectionIdentifier(configuration) isEqual:CSAIConnectionIdentifier(expected)];
    if(connectionChanged){NSMutableDictionary *updated=[configuration mutableCopy];updated[@"verifiedConnection"]=@"";[updated removeObjectForKey:@"verifiedAt"];configuration=updated;}
    self.savingConfiguration++;[self invalidateBackgroundSyncContext];[self.coordinator cancelAll];[self.backgroundSync stop];
    if(connectionChanged)[self invalidateConnectionTest];
    [store saveConfiguration:configuration expectedConfiguration:expected completion:^(BOOL success,NSError *failure){
        if(self.store!=store || self.epoch!=epoch || epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended() || !CSBackupIsReady() || ![[self.environment currentAccountID] isEqual:account]){
            NSMutableDictionary *info=[@{NSLocalizedDescriptionKey:@"账号状态已改变，本次保存结果请在原账号检查。"} mutableCopy];
            if(success || [failure.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue])info[CSAIReplyStoreCommitUncertainKey]=@YES;
            if(self.store==store && self.savingConfiguration)self.savingConfiguration--;
            completion(NO,[NSError errorWithDomain:@"com.wechatimprove.ai-reply" code:20 userInfo:info]);return;
        }
        if(self.savingConfiguration)self.savingConfiguration--;
        if(success)[self.coordinator configurationDidChange];else [self.coordinator cancelAll];
        [self reconcileBackgroundSyncContext];[self.backgroundSync refresh];[self notify];completion(success,failure);
    }];
}
- (void)saveConnection:(NSString *)endpoint model:(NSString *)model key:(NSString *)key account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion {
    if(self.savingConfiguration){completion(NO,CSAIError(20,@"配置正在保存，请完成后再修改。"));return;}
    if(![self isCurrentAccount:account epoch:epoch]){completion(NO,CSAIError(20,@"账号已改变，请重新打开设置。"));return;}
    endpoint=[endpoint stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];model=[model stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSError *error=nil;if(endpoint.length && !CSAIValidateEndpoint(endpoint,&error)){completion(NO,error);return;}
    CSAIReplyStore *store=self.store;NSDictionary *expected=store.configuration;BOOL keyChanged=key!=nil;
    NSString *secret=[key stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSString *revision=keyChanged?(secret.length?NSUUID.UUID.UUIDString:@""):(expected[@"credentialRevision"]?:@"");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY,0),^{
        NSError *failure=nil;BOOL wrote=!keyChanged || !secret.length || CSAIWriteCredential(account,revision,secret,&failure);
        dispatch_async(dispatch_get_main_queue(),^{
            if(!wrote){completion(NO,failure);return;}
            if(self.store!=store || ![self isCurrentAccount:account epoch:epoch] || ![expected isEqual:store.configuration]){
                if(keyChanged && revision.length)CSAIRemoveCredential(account,revision);
                completion(NO,CSAIError(20,@"账号或配置已改变，请返回后重新保存。"));return;
            }
            NSMutableDictionary *configuration=[expected mutableCopy];configuration[@"endpoint"]=endpoint?:@"";configuration[@"model"]=model?:@"";configuration[@"credentialRevision"]=revision;
            [self saveConfiguration:configuration account:account epoch:epoch completion:^(BOOL saved,NSError *saveError){
                // An uncertain replacement may already reference the immutable credential slot.
                if(!saved && keyChanged && revision.length && ![saveError.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue])CSAIRemoveCredential(account,revision);
                completion(saved,saveError);
            }];
        });
    });
}
- (void)setConversation:(NSString *)conversation enabled:(BOOL)enabled presetID:(NSString *)presetID account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion {
    if(![self isCurrentAccount:account epoch:epoch] || ![self allowsConversation:conversation]){completion(NO,CSAIError(23,@"当前会话不可用或正受保护，未修改配置。"));return;}
    NSMutableDictionary *configuration=[self.store.configuration mutableCopy],*items=[configuration[@"conversations"] mutableCopy];
    NSMutableDictionary *item=[items[conversation] mutableCopy]?:[NSMutableDictionary dictionary];item[@"enabled"]=@(enabled);item[@"presetID"]=presetID?:@"";items[conversation]=item;configuration[@"conversations"]=items;
    [self saveConfiguration:configuration account:account epoch:epoch completion:completion];
}
- (void)setConversation:(NSString *)conversation allowUnmentioned:(BOOL)allowUnmentioned account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion {
    if(![conversation hasSuffix:@"@chatroom"] || ![self isCurrentAccount:account epoch:epoch] || ![self allowsConversation:conversation]){completion(NO,CSAIError(23,@"当前群聊不可用或正受保护，未修改配置。"));return;}
    NSMutableDictionary *configuration=[self.store.configuration mutableCopy],*items=[configuration[@"conversations"] mutableCopy];
    NSMutableDictionary *item=[items[conversation] mutableCopy]?:[@{@"enabled":@NO,@"presetID":@""} mutableCopy];item[@"allowUnmentioned"]=@(allowUnmentioned);items[conversation]=item;configuration[@"conversations"]=items;
    [self saveConfiguration:configuration account:account epoch:epoch completion:completion];
}
- (BOOL)allowsBackgroundSync {
    if(self.savingConfiguration || !NSThread.isMainThread || self.enteringForeground || UIApplication.sharedApplication.applicationState!=UIApplicationStateBackground ||
       !CSBackgroundRunManager.sharedManager.backgroundAudioActive)return NO;
    NSDictionary *config=self.store.configuration;
    if(![config[@"enabled"] boolValue] || ![config[@"endpoint"] length] || ![config[@"model"] length] || ![config[@"credentialRevision"] length] ||
       ![config[@"verifiedConnection"] length] || ![config[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(config)])return NO;
    NSMutableArray<NSString *> *candidates=[NSMutableArray array];
    for(NSString *conversation in config[@"conversations"]){
        NSDictionary *item=config[@"conversations"][conversation];
        if([conversation hasSuffix:@"@chatroom"] && [item[@"enabled"] boolValue] && [item[@"allowUnmentioned"] boolValue])[candidates addObject:conversation];
    }
    // Reject disabled configurations before asking native account/contact services.
    if(!candidates.count || ![self isCurrentAccount:self.store.account epoch:self.epoch] || !CSAuthorizationManager.sharedManager.isAuthorized)return NO;
    BOOL eligible=NO;
    for(NSString *conversation in candidates){
        // Concealing a conversation in the UI does not disable its configured replies.
        if([self supportsReplyConversation:conversation]){eligible=YES;break;}
    }
    return eligible && [config isEqual:self.store.configuration] && [self isCurrentAccount:self.store.account epoch:self.epoch] &&
        !self.savingConfiguration && CSAuthorizationManager.sharedManager.isAuthorized && !self.enteringForeground &&
        UIApplication.sharedApplication.applicationState==UIApplicationStateBackground && CSBackgroundRunManager.sharedManager.backgroundAudioActive;
}
- (void)requestBackgroundSync {
    if(![self allowsBackgroundSync])return;
    CSAIReplyStore *store=self.store;NSDictionary *configuration=store.configuration;NSString *account=store.account;NSUInteger epoch=self.epoch;
    NSUInteger generation=self.backgroundSyncContextGeneration;
    @try {
        // Keep the account-bound service wrapper and its native pause/busy guards.
        id service=[self.environment serviceNamed:@"NewSyncService"];
        if(!CSMessageNativeSupports(service,@"isGettingData",@"B",@[]) || !CSMessageNativeSupports(service,@"BackGroundFetchToSync",@"B",@[]))return;
        if([CSMessageNativeInvoke(service,@"isGettingData",@[]) boolValue])return;
        if(![self allowsBackgroundSync] || ![self isCurrentAccount:account epoch:epoch])return;
        // YES means accepted by the native service, not that messages arrived.
        CSAIObserveBackgroundSyncRequest(epoch,^{
            // The observer has finished its guarded eligibility capture. Its
            // request frame can now be claimed: use only local snapshots here,
            // then invoke this wrapper directly without more native getters.
            if(self.store!=store || self.store.configuration!=configuration || !store.ready || ![store.account isEqual:account] ||
               self.epoch!=epoch || epoch!=CSBackupAccountEpoch() || generation!=self.backgroundSyncContextGeneration ||
               self.savingConfiguration || !self.backgroundSync.active || !CSBackupIsReady() || CSBackupAccountIsSuspended() ||
               self.enteringForeground || UIApplication.sharedApplication.applicationState!=UIApplicationStateBackground)return;
            CSMessageNativeInvoke(service,@"BackGroundFetchToSync",@[]);
        });
    } @catch(__unused NSException *exception) {
        // Unsupported or temporarily unavailable native services wait for the next interval.
    }
}
#if !TARGET_OS_IPHONE
- (BOOL)saveConnection:(NSString *)endpoint model:(NSString *)model key:(NSString *)key account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    if(![self isCurrentAccount:account epoch:epoch]){if(error)*error=CSAIError(20,@"账号已改变，请重新打开设置。");return NO;}
    endpoint=[endpoint stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    model=[model stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if(endpoint.length && !CSAIValidateEndpoint(endpoint,error))return NO;
    NSMutableDictionary *config=[self.store.configuration mutableCopy];NSString *old=config[@"credentialRevision"]?:@"",*revision=old;
    BOOL keyChanged=key!=nil;
    if(keyChanged){
        key=[key stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        revision=key.length?NSUUID.UUID.UUIDString:@"";
        if(key.length && !CSAIWriteCredential(account,revision,key,error))return NO;
    }
    config[@"endpoint"]=endpoint?:@"";config[@"model"]=model?:@"";config[@"credentialRevision"]=revision;
    BOOL changed=![CSAIConnectionIdentifier(config) isEqual:CSAIConnectionIdentifier(self.store.configuration)];
    if(changed){config[@"verifiedConnection"]=@"";[config removeObjectForKey:@"verifiedAt"];}
    NSError *saveError=nil;
    if(![self saveConfiguration:config account:account epoch:epoch error:&saveError]){
        // A successful rename followed by failed directory fsync may already expose
        // this revision. Keep both immutable credentials so reopening either the
        // old or new complete configuration remains coherent after recovery.
        if(keyChanged && revision.length && ![saveError.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue])CSAIRemoveCredential(account,revision);
        if(error)*error=saveError;
        return NO;
    }
    // Keep prior immutable slots for the existing backup transaction's exact rollback.
    // They are never exported and cannot become active without an explicit local configuration reference.
    return YES;
}
#endif
- (id<CSAICancellable>)testConnectionForAccount:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAICompletion)completion {
    NSError *error=nil;NSDictionary *config=self.store.configuration;
    if(![self isCurrentAccount:account epoch:epoch] || ![config[@"endpoint"] length] || ![config[@"model"] length])error=CSAIError(21,@"请先保存 API 地址、API Key 和模型名称。");
    if(error){dispatch_async(dispatch_get_main_queue(),^{completion(nil,error);});return [CSAIEmptyCancellation new];}
    [self invalidateConnectionTest];NSUInteger generation=self.testGeneration;
    NSString *identifier=CSAIConnectionIdentifier(config);NSDate *started=NSDate.date;
    CSAIReplyStore *store=self.store;
    CSAIConnectionTestOperation *operation=[CSAIConnectionTestOperation new];
    operation.deadline=NSProcessInfo.processInfo.systemUptime+60;
    __weak typeof(self) weakSelf=self;__weak CSAIConnectionTestOperation *weakOperation=operation;
    __block BOOL networkStarted=NO;
    BOOL (^current)(void)=^BOOL{
        typeof(self) self=weakSelf;CSAIConnectionTestOperation *live=weakOperation;
        return self && live && self.connectionTest==live && self.testGeneration==generation && self.store==store &&
            [self isCurrentAccount:account epoch:epoch] && [config isEqual:self.store.configuration];
    };
    operation.completion=^(NSString *text,NSError *failure){
        typeof(self) self=weakSelf;
        if(!current()){
            if(self.connectionTest==weakOperation){self.connectionTest=nil;self.connectionStatus=nil;[self notify];}
            completion(nil,CSAIError(22,@"配置或账号已改变，请重新测试。"));return;
        }
        self.connectionTest=nil;
        if(!failure && !text.length)failure=CSAIError(23,@"连接测试未返回有效内容。");
        void (^finish)(NSError *)=^(NSError *resultError){
            if(self.testGeneration!=generation || ![self isCurrentAccount:account epoch:epoch] || ![identifier isEqual:CSAIConnectionIdentifier(self.store.configuration)]){completion(nil,CSAIError(22,@"配置或账号已改变，请重新测试。"));return;}
            self.connectionStatus=resultError?resultError.localizedDescription:[NSString stringWithFormat:@"连接成功 · %.1f 秒",-[started timeIntervalSinceNow]];
            [self notify];completion(resultError?nil:text,resultError);
        };
        if(networkStarted && (!failure || failure.code!=NSURLErrorCancelled)){
            NSMutableDictionary *updated=[self.store.configuration mutableCopy];updated[@"verifiedConnection"]=failure?@"":identifier;
            if(failure)[updated removeObjectForKey:@"verifiedAt"];else updated[@"verifiedAt"]=NSDate.date;
            NSError *requestError=failure;
            [self saveConfiguration:updated account:account epoch:epoch completion:^(BOOL saved,NSError *saveError){finish(saved?requestError:saveError);}];
        }else finish(failure);
    };
    self.connectionTest=operation;
    operation.timer=[NSTimer timerWithTimeInterval:60 repeats:NO block:^(__unused NSTimer *timer){[weakOperation timedOut];}];
    [NSRunLoop.mainRunLoop addTimer:operation.timer forMode:NSRunLoopCommonModes];
    self.connectionStatus=@"正在测试连接";[self notify];
    if(operation.finished)return operation;
    if(!current()){[operation finishText:nil error:CSAIError(22,@"配置或账号已改变，请重新测试。")];return operation;}
    NSUInteger phase=++operation.phase;
    id<CSAICancellable> credentialTask=CSAIReadCredentialAsync(account,config[@"credentialRevision"]?:@"",^(NSString *key,NSError *failure){
        CSAIConnectionTestOperation *live=weakOperation;typeof(self) self=weakSelf;
        if(!live || live.finished || live.phase!=phase)return;
        live.child=nil;
        if(!current()){[live finishText:nil error:CSAIError(22,@"配置或账号已改变，请重新测试。")];return;}
        if(NSProcessInfo.processInfo.systemUptime>=live.deadline){[live timedOut];return;}
        if(failure || !key.length){[live finishText:nil error:failure?:CSAIError(21,@"请先设置 API Key。")];return;}
        id content=@"请只回复：连接正常。";
        if([config[@"imageEnabled"] boolValue]){
            // A fixed 32x32 blue PNG tests the image request without touching chat media.
            NSString *image=@"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAAJ0lEQVR4nO3NsQkAAAgDsJ7u5/YKByGQPcnsLYFAIBAIBAKBQPAlKPAr/Ez/cO8XAAAAAElFTkSuQmCC";
            content=@[@{@"type":@"image_url",@"image_url":@{@"url":image}},@{@"type":@"text",@"text":@"这张图片主要是什么颜色？请简短回答。"}];
        }
        networkStarted=YES;NSUInteger networkPhase=++live.phase;
        id<CSAICancellable> request=[self.client generateWithConfiguration:config apiKey:key messages:@[@{@"role":@"user",@"content":content}] completion:^(NSString *text,NSError *requestError){
            void (^complete)(void)=^{
                CSAIConnectionTestOperation *owner=weakOperation;
                if(!owner || owner.finished || owner.phase!=networkPhase)return;
                if(NSProcessInfo.processInfo.systemUptime>=owner.deadline)[owner timedOut];
                else [owner finishText:text error:requestError];
            };
            if(NSThread.isMainThread)complete();else dispatch_async(dispatch_get_main_queue(),complete);
        }];
        [live attach:request phase:networkPhase];
    });
    [operation attach:credentialTask phase:phase];return operation;
}

#if !TARGET_OS_IPHONE
- (BOOL)setConversation:(NSString *)conversation enabled:(BOOL)enabled presetID:(NSString *)presetID account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    if(![self isCurrentAccount:account epoch:epoch] || ![self allowsConversation:conversation]){if(error)*error=CSAIError(23,@"当前会话不可用或正受保护，未修改配置。");return NO;}
    NSMutableDictionary *config=[self.store.configuration mutableCopy],*conversations=[config[@"conversations"] mutableCopy];
    NSMutableDictionary *item=[conversations[conversation] mutableCopy]?:[NSMutableDictionary dictionary];
    item[@"enabled"]=@(enabled);item[@"presetID"]=presetID?:@"";conversations[conversation]=item;config[@"conversations"]=conversations;
    return [self saveConfiguration:config account:account epoch:epoch error:error];
}
#endif
#if !TARGET_OS_IPHONE
- (BOOL)setConversation:(NSString *)conversation allowUnmentioned:(BOOL)allowUnmentioned account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    if(![conversation hasSuffix:@"@chatroom"] || ![self isCurrentAccount:account epoch:epoch] || ![self allowsConversation:conversation]){if(error)*error=CSAIError(23,@"当前群聊不可用或正受保护，未修改配置。");return NO;}
    NSMutableDictionary *config=[self.store.configuration mutableCopy],*conversations=[config[@"conversations"] mutableCopy];
    NSMutableDictionary *item=[conversations[conversation] mutableCopy]?:[@{@"enabled":@NO,@"presetID":@""} mutableCopy];
    item[@"allowUnmentioned"]=@(allowUnmentioned);conversations[conversation]=item;config[@"conversations"]=conversations;
    return [self saveConfiguration:config account:account epoch:epoch error:error];
}
#endif
- (BOOL)allowsConversation:(NSString *)conversation {
    if(!conversation.length || CSCloseFriendCurrentSnapshot().blocked || CSCloseFriendShouldHideUserName(conversation,CSCloseFriendSurfaceSession))return NO;
    return [self supportsReplyConversation:conversation];
}
- (BOOL)supportsReplyConversation:(NSString *)conversation {
    // UI concealment is independent of reply eligibility. The coordinator checks
    // account, authorization, both AI switches and connection validity separately.
    if(!conversation.length)return NO;
    id manager=[self.environment serviceNamed:@"CContactMgr"],contact=nil;
    @try{for(NSString *selector in @[@"getContactByName:",@"getContactByNameFromDB:"]){if(CSMessageNativeSupports(manager,selector,@"@",@[@"@"]))contact=CSMessageNativeInvoke(manager,selector,@[conversation]);if(contact)break;}}@catch(__unused NSException *e){return NO;}
    if(![CSGroupReadObject(contact,@"m_nsUsrName") isEqual:conversation])return NO;
    CSGroupRowCategory category=CSGroupCategoryForContact(contact);return category==CSGroupRowCategoryPrivate || category==CSGroupRowCategoryGroup;
}
- (NSString *)displayNameForConversation:(NSString *)conversation {
    if(CSCloseFriendCurrentSnapshot().blocked || CSCloseFriendShouldHideUserName(conversation,CSCloseFriendSurfaceSession))return @"受保护的会话";
    id manager=[self.environment serviceNamed:@"CContactMgr"],contact=nil;
    @try{if(CSMessageNativeSupports(manager,@"getContactByName:",@"@",@[@"@"]))contact=CSMessageNativeInvoke(manager,@"getContactByName:",@[conversation]);}@catch(__unused NSException *e){}
    for(NSString *field in @[@"m_nsRemark",@"m_nsNickName"]){id value=CSGroupReadObject(contact,field);if([value isKindOfClass:NSString.class] && [value length])return value;}return conversation;
}
- (NSString *)presetNameForConversation:(NSString *)conversation {
    NSDictionary *config=self.store.configuration;NSString *identifier=conversation?config[@"conversations"][conversation][@"presetID"]:nil;
    BOOL inherited=conversation && !identifier.length;if(!identifier.length)identifier=config[@"defaultPreset"];
    for(NSDictionary *preset in config[@"presets"])if([preset[@"id"] isEqual:identifier])return inherited?[@"跟随默认 · " stringByAppendingString:preset[@"name"]]:preset[@"name"];
    return @"未选择预设";
}
- (NSString *)statusForConversation:(NSString *)conversation {
    if(!self.store)return @"请登录微信后设置";
    if(!self.store.ready)return self.loadingStore?@"正在读取配置…":self.store.error.localizedDescription?:@"配置存储不可用";
    if(self.savingConfiguration)return @"正在保存配置…";
    NSDictionary *config=self.store.configuration;
    if(conversation && ![config[@"conversations"][conversation][@"enabled"] boolValue])return @"此会话未启用";
    if(![config[@"enabled"] boolValue])return @"总开关已关闭";
    if(![config[@"verifiedConnection"] length] || ![config[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(config)])return @"连接待验证 · 自动回复已暂停";
    if(conversation && ![self supportsReplyConversation:conversation])return @"会话不可用";
    if(!CSAuthorizationManager.sharedManager.isAuthorized)return @"插件授权未就绪";
    if(conversation && [conversation hasSuffix:@"@chatroom"])return [config[@"conversations"][conversation][@"allowUnmentioned"] boolValue]?@"已启用 · 无需 @ 即可回复":@"已启用 · 仅被 @ 时回复";
    return @"已启用 · 等待符合规则的新消息";
}
- (BOOL)coordinator:(CSAIReplyCoordinator *)coordinator allowsConversation:(NSString *)conversation {
    return !self.savingConfiguration && coordinator==self.coordinator && [self isCurrentAccount:coordinator.store.account epoch:self.epoch] && CSAuthorizationManager.sharedManager.isAuthorized && [self supportsReplyConversation:conversation];
}
- (id<CSAICancellable>)credentialForCoordinator:(CSAIReplyCoordinator *)coordinator completion:(CSAICompletion)completion {
    CSAIReplyStore *store=coordinator.store;NSString *account=store.account;NSUInteger epoch=self.epoch;
    NSDictionary *configuration=store.configuration;
    if(coordinator!=self.coordinator || ![self isCurrentAccount:account epoch:epoch]){
        completion(nil,CSAIError(20,@"账号状态已改变。"));return [CSAIEmptyCancellation new];
    }
    __weak typeof(self) weakSelf=self;
    return CSAIReadCredentialAsync(account,configuration[@"credentialRevision"]?:@"",^(NSString *key,NSError *error){
        typeof(self) self=weakSelf;
        if(!self || self.coordinator!=coordinator || self.store!=store || ![self isCurrentAccount:account epoch:epoch] || ![configuration isEqual:store.configuration]){
            completion(nil,CSAIError(20,@"账号或配置状态已改变。"));return;
        }
        completion(key,error);
    });
}
- (NSString *)coordinator:(CSAIReplyCoordinator *)coordinator submitText:(NSString *)text conversation:(NSString *)conversation valid:(BOOL (^)(void))valid {
    if(![self coordinator:coordinator allowsConversation:conversation] || !valid())return @"failed";
    CSMessagePreparedSend *route=[self.sender prepareScheduledText:text targetID:conversation accountID:coordinator.store.account];if(!route)return @"failed";
    CSAIMarkOwnedSend(route.outputWrap);NSUInteger epoch=self.epoch;
    __weak typeof(self) weakSelf=self;route.submissionStillAuthorized=^BOOL{return valid() && [weakSelf coordinator:coordinator allowsConversation:conversation];};
    __block CSMessageActionSubmissionState result=CSMessageActionSubmissionStateFailedBeforeAcceptance;
    CSBackupPerformAtAccountEpoch(epoch,^{if(valid() && [self coordinator:coordinator allowsConversation:conversation])result=[route submit];});
    if(route.nativeHandoffReturned)return @"submitted";
    return result==CSMessageActionSubmissionStateUnknown?@"unknown":@"failed";
}
- (void)receiveNativeSession:(id)session wrap:(id)wrap epoch:(NSUInteger)epoch {
    if(!NSThread.isMainThread){if(CSAIReplyMessageIngressAllowsSession(session,epoch))dispatch_async(dispatch_get_main_queue(),^{[self receiveNativeSession:session wrap:wrap epoch:epoch];});return;}
    if(epoch!=CSBackupAccountEpoch() || epoch!=self.epoch)return;
    NSDictionary *configuration=self.store.configuration;
    if(!self.store.ready || !self.coordinator || ![configuration[@"enabled"] boolValue])return;
    // A nonempty native session must match the eventual event's conversation.
    // Avoid parsing content, mention XML and identities for disabled sessions.
    if([session isKindOfClass:NSString.class] && [session length] && ![configuration[@"conversations"][session][@"enabled"] boolValue])return;
    NSDictionary *event=CSAIEventFromWrapWithConfiguration(wrap,self.store.account,[session isKindOfClass:NSString.class]?session:@"",configuration);
    if(event){NSMutableDictionary *snapshot=[event mutableCopy];snapshot[@"epoch"]=@(epoch);[self.coordinator receiveEvent:snapshot];}
}
@end
