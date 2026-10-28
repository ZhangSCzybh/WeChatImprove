#import "CSAIReplyManager.h"
#import "CSAIReplyCoordinator.h"
#import "CSAIBackgroundSync.h"
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

NSNotificationName const CSAIReplyDidChange=@"CSAIReplyDidChange";
@interface CSAIEmptyCancellation : NSObject <CSAICancellable>
@end
@implementation CSAIEmptyCancellation
- (void)cancel {}
@end
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
@end
@implementation CSAIReplyManager
+ (instancetype)sharedManager {static id manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (instancetype)init {
    if((self=[super init])){
        _environment=[CSMessageNativeEnvironment new];_sender=[[CSMessageSendAdapter alloc]initWithEnvironment:_environment];_client=[CSAIClient new];
        __weak typeof(self) weakSelf=self;
        _backgroundSync=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return [weakSelf allowsBackgroundSync];} synchronize:^{[weakSelf requestBackgroundSync];}];
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
    if([note.name isEqual:UIApplicationDidEnterBackgroundNotification])self.enteringForeground=NO;
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
- (void)notify {[NSNotificationCenter.defaultCenter postNotificationName:CSAIReplyDidChange object:self];}
- (void)refresh {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self refresh];});return;}
    NSString *account=CSBackupIsReady() && !CSBackupAccountIsSuspended()?[self.environment currentAccountID]:nil;
    NSUInteger epoch=CSBackupAccountEpoch();
    if(!account.length || ![self.store.account isEqual:account] || self.epoch!=epoch){
        [self.backgroundSync stop];
        [self.coordinator cancelAll];self.coordinator=nil;[self.connectionTest cancel];self.connectionTest=nil;self.testGeneration++;self.connectionStatus=nil;
        self.store=nil;self.epoch=epoch;
        if(account.length){
            NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
            NSURL *root=[library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES];
            self.store=[[CSAIReplyStore alloc]initWithURL:CSAIReplyFileURL(root,account) account:account];[self.store load];
        }
    }
    if(self.store && !self.store.ready)[self.store load];
    if(self.store.ready && !self.coordinator){self.coordinator=[[CSAIReplyCoordinator alloc]initWithStore:self.store client:self.client];self.coordinator.delegate=self;}
    [self.backgroundSync refresh];[self notify];
}
- (BOOL)isCurrentAccount:(NSString *)account epoch:(NSUInteger)epoch {
    return NSThread.isMainThread && account.length && self.store.ready && [account isEqual:self.store.account] && epoch==self.epoch && epoch==CSBackupAccountEpoch() && CSBackupIsReady() && !CSBackupAccountIsSuspended() && [[self.environment currentAccountID] isEqual:account];
}
- (BOOL)saveConfiguration:(NSDictionary *)configuration account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    if(![self isCurrentAccount:account epoch:epoch]){if(error)*error=CSAIError(20,@"账号或配置状态已改变，请重新打开 AI 设置。");return NO;}
    if(!CSAIReplyValidateConfiguration(configuration,error))return NO;
    __block BOOL saved=NO;__block NSError *failure=nil;
    CSBackupResourceMutationScope();
    CSBackupPerformAtAccountEpoch(epoch,^{if([self isCurrentAccount:account epoch:epoch])saved=[self.store saveConfiguration:configuration error:&failure];});
    if(!saved){if(error)*error=failure?:CSAIError(20,@"账号状态已改变，本次未保存。");return NO;}
    [self.coordinator configurationDidChange];[self.backgroundSync refresh];[self notify];return YES;
}
- (BOOL)allowsBackgroundSync {
    if(!NSThread.isMainThread || self.enteringForeground || UIApplication.sharedApplication.applicationState!=UIApplicationStateBackground ||
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
        !self.enteringForeground && UIApplication.sharedApplication.applicationState==UIApplicationStateBackground && CSBackgroundRunManager.sharedManager.backgroundAudioActive;
}
- (void)requestBackgroundSync {
    if(![self allowsBackgroundSync])return;
    NSString *account=self.store.account;NSUInteger epoch=self.epoch;
    @try {
        // Keep the account-bound service wrapper and its native pause/busy guards.
        id service=[self.environment serviceNamed:@"NewSyncService"];
        if(!CSMessageNativeSupports(service,@"isGettingData",@"B",@[]) || !CSMessageNativeSupports(service,@"BackGroundFetchToSync",@"B",@[]))return;
        if([CSMessageNativeInvoke(service,@"isGettingData",@[]) boolValue])return;
        if(![self allowsBackgroundSync] || ![self isCurrentAccount:account epoch:epoch])return;
        // YES means accepted by the native service, not that messages arrived.
        CSMessageNativeInvoke(service,@"BackGroundFetchToSync",@[]);
    } @catch(__unused NSException *exception) {
        // Unsupported or temporarily unavailable native services wait for the next interval.
    }
}
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
    if(changed){[self.connectionTest cancel];self.connectionTest=nil;self.testGeneration++;self.connectionStatus=nil;}
    return YES;
}
- (id<CSAICancellable>)testConnectionForAccount:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAICompletion)completion {
    NSError *error=nil;NSDictionary *config=self.store.configuration;
    if(![self isCurrentAccount:account epoch:epoch] || ![config[@"endpoint"] length] || ![config[@"model"] length])error=CSAIError(21,@"请先保存 API 地址、API Key 和模型名称。");
    NSString *key=error?nil:CSAIReadCredential(account,config[@"credentialRevision"]?:@"",&error);
    if(!error && !key.length)error=CSAIError(21,@"请先设置 API Key。");
    if(error){dispatch_async(dispatch_get_main_queue(),^{completion(nil,error);});return [CSAIEmptyCancellation new];}
    [self.connectionTest cancel];NSUInteger generation=++self.testGeneration;
    NSString *identifier=CSAIConnectionIdentifier(config);NSDate *started=NSDate.date;self.connectionStatus=@"正在测试连接";[self notify];
    __weak typeof(self) weakSelf=self;
    id<CSAICancellable> task=[self.client generateWithConfiguration:config apiKey:key messages:@[@{@"role":@"user",@"content":@"请只回复：连接正常。"}] completion:^(NSString *text,NSError *failure){
        typeof(self) self=weakSelf;
        if(!self || self.testGeneration!=generation || ![self isCurrentAccount:account epoch:epoch] || ![identifier isEqual:CSAIConnectionIdentifier(self.store.configuration)]){completion(nil,CSAIError(22,@"配置或账号已改变，请重新测试。"));return;}
        self.connectionTest=nil;
        if(!failure && !text.length)failure=CSAIError(23,@"连接测试未返回有效内容。");
        if(!failure || failure.code!=NSURLErrorCancelled){
            NSMutableDictionary *updated=[self.store.configuration mutableCopy];
            updated[@"verifiedConnection"]=failure?@"":identifier;
            if(failure)[updated removeObjectForKey:@"verifiedAt"];else updated[@"verifiedAt"]=NSDate.date;
            NSError *saveError=nil;if(![self saveConfiguration:updated account:account epoch:epoch error:&saveError])failure=saveError;
        }
        if(failure)self.connectionStatus=failure.localizedDescription;
        else self.connectionStatus=[NSString stringWithFormat:@"连接成功 · %.1f 秒",-[started timeIntervalSinceNow]];
        [self notify];completion(failure?nil:text,failure);
    }];self.connectionTest=task;return task;
}
- (BOOL)setConversation:(NSString *)conversation enabled:(BOOL)enabled presetID:(NSString *)presetID account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    if(![self isCurrentAccount:account epoch:epoch] || ![self allowsConversation:conversation]){if(error)*error=CSAIError(23,@"当前会话不可用或正受保护，未修改配置。");return NO;}
    NSMutableDictionary *config=[self.store.configuration mutableCopy],*conversations=[config[@"conversations"] mutableCopy];
    NSMutableDictionary *item=[conversations[conversation] mutableCopy]?:[NSMutableDictionary dictionary];
    item[@"enabled"]=@(enabled);item[@"presetID"]=presetID?:@"";conversations[conversation]=item;config[@"conversations"]=conversations;
    return [self saveConfiguration:config account:account epoch:epoch error:error];
}
- (BOOL)setConversation:(NSString *)conversation allowUnmentioned:(BOOL)allowUnmentioned account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    if(![conversation hasSuffix:@"@chatroom"] || ![self isCurrentAccount:account epoch:epoch] || ![self allowsConversation:conversation]){if(error)*error=CSAIError(23,@"当前群聊不可用或正受保护，未修改配置。");return NO;}
    NSMutableDictionary *config=[self.store.configuration mutableCopy],*conversations=[config[@"conversations"] mutableCopy];
    NSMutableDictionary *item=[conversations[conversation] mutableCopy]?:[@{@"enabled":@NO,@"presetID":@""} mutableCopy];
    item[@"allowUnmentioned"]=@(allowUnmentioned);conversations[conversation]=item;config[@"conversations"]=conversations;
    return [self saveConfiguration:config account:account epoch:epoch error:error];
}
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
    if(!self.store.ready)return self.store.error.localizedDescription?:@"配置存储不可用";
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
    return coordinator==self.coordinator && [self isCurrentAccount:coordinator.store.account epoch:self.epoch] && CSAuthorizationManager.sharedManager.isAuthorized && [self supportsReplyConversation:conversation];
}
- (NSString *)credentialForCoordinator:(CSAIReplyCoordinator *)coordinator error:(NSError **)error {
    if(coordinator!=self.coordinator || ![self isCurrentAccount:coordinator.store.account epoch:self.epoch]){if(error)*error=CSAIError(20,@"账号状态已改变。");return nil;}
    return CSAIReadCredential(coordinator.store.account,coordinator.store.configuration[@"credentialRevision"]?:@"",error);
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
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{[self receiveNativeSession:session wrap:wrap epoch:epoch];});return;}
    if(epoch!=CSBackupAccountEpoch() || epoch!=self.epoch)return;
    NSDictionary *configuration=self.store.configuration;
    if(![configuration[@"enabled"] boolValue])return;
    // A nonempty native session must match the eventual event's conversation.
    // Avoid parsing content, mention XML and identities for disabled sessions.
    if([session isKindOfClass:NSString.class] && [session length] && ![configuration[@"conversations"][session][@"enabled"] boolValue])return;
    NSDictionary *event=CSAIEventFromWrap(wrap,self.store.account,[session isKindOfClass:NSString.class]?session:@"");
    if(event)[self.coordinator receiveEvent:event];
}
@end
