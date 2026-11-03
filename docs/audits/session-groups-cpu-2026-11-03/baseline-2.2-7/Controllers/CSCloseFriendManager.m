#import "CSCloseFriendManager.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendSettingsViewController.h"
#import "CSCloseFriendCrypto.h"
#import "CSCloseFriendAccount.h"
#import "CSCloseFriendEntryState.h"
#import "CSCloseFriendReset.h"
#import "CSCloseFriendShakeMonitor.h"
#import "CSCloseFriendNavigation.h"
#import "CSBackupBootstrap.h"
#import "CSPluginStorage.h"
#import "CSBackgroundBlurManager.h"
#import <Security/Security.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <CommonCrypto/CommonCrypto.h>
#import <objc/message.h>
#import <sys/stat.h>
static NSString *CSAccountDigest(NSString *account) {
    NSData *data=[account dataUsingEncoding:NSUTF8StringEncoding]; uint8_t bytes[CC_SHA256_DIGEST_LENGTH]; CC_SHA256(data.bytes,(CC_LONG)data.length,bytes);
    NSMutableString *result=[NSMutableString new]; for(NSUInteger i=0;i<sizeof(bytes);i++)[result appendFormat:@"%02x",bytes[i]]; return result;
}
static BOOL CSCanCreatePolicyKey(CSPluginDirectoryMigration *migration, NSString *account) {
    NSString *name=[NSString stringWithFormat:@"state-%@.bin",CSAccountDigest(account)];
    // Missing/unavailable old state cannot authorize replacing its encryption key during a retry.
    for(NSURL *root in @[migration.legacyRoot,migration.destinationRoot]) {
        struct stat st;
        if(lstat([root URLByAppendingPathComponent:name].path.fileSystemRepresentation,&st)==0 || errno!=ENOENT)return NO;
    }
    return YES;
}
static NSMutableDictionary *CSKeychainQuery(NSString *account, NSString *kind) {
    return [@{(__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,(__bridge id)kSecAttrService:@"com.wechatimprove.closefriends.v1",(__bridge id)kSecAttrAccount:[NSString stringWithFormat:@"%@.%@",kind,CSAccountDigest(account)],(__bridge id)kSecAttrSynchronizable:@NO} mutableCopy];
}
static void CSKeychainError(NSError **error, OSStatus status) { if(error)*error=[NSError errorWithDomain:NSOSStatusErrorDomain code:status userInfo:@{NSLocalizedDescriptionKey:@"密友安全凭据不可用；现有数据已保留。"}]; }
static NSData *CSKeychainRead(NSString *account, NSString *kind, NSError **error) {
    NSMutableDictionary *query=CSKeychainQuery(account,kind); query[(__bridge id)kSecReturnData]=@YES; query[(__bridge id)kSecMatchLimit]=(__bridge id)kSecMatchLimitOne;
    CFTypeRef output=NULL; OSStatus status=SecItemCopyMatching((__bridge CFDictionaryRef)query,&output);
    if(status==errSecItemNotFound)return nil;
    if(status!=errSecSuccess) { CSKeychainError(error,status); return nil; }
    id result=CFBridgingRelease(output); if(![result isKindOfClass:NSData.class]) { CSKeychainError(error,errSecDecode); return nil; } return result;
}
static BOOL CSKeychainWrite(NSString *account, NSString *kind, NSData *data, BOOL replace, NSError **error) {
    NSMutableDictionary *query=CSKeychainQuery(account,kind);
    NSDictionary *attributes=@{(__bridge id)kSecValueData:data,(__bridge id)kSecAttrAccessible:(__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly};
    OSStatus status=replace?SecItemUpdate((__bridge CFDictionaryRef)query,(__bridge CFDictionaryRef)attributes):errSecItemNotFound;
    if(status==errSecItemNotFound) { [query addEntriesFromDictionary:attributes]; status=SecItemAdd((__bridge CFDictionaryRef)query,NULL); }
    if(status!=errSecSuccess)CSKeychainError(error,status); return status==errSecSuccess;
}
static BOOL CSKeychainRemove(NSString *account, NSString *kind, NSError **error) {
    OSStatus status=SecItemDelete((__bridge CFDictionaryRef)CSKeychainQuery(account,kind));
    if(status==errSecSuccess || status==errSecItemNotFound)return YES;
    CSKeychainError(error,status); return NO;
}
@interface CSCloseFriendManager ()
@property(nonatomic,strong,readwrite) CSCloseFriendRuntime *runtime;
@property(nonatomic,strong) CSCloseFriendEntryState *entryState;
@property(nonatomic,strong) NSMutableDictionary *capabilityMap;
@property(nonatomic,strong) NSMutableArray<UIView *> *covers;
@property(nonatomic,strong) LAContext *authenticationContext;
@property(nonatomic,copy) void (^biometricCompletion)(BOOL);
@property(nonatomic,copy) void (^pendingBiometricReply)(void);
@property(nonatomic,copy) NSString *passwordFallbackReason;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) CSCloseFriendShakeMonitor *shakeMonitor;
@property(nonatomic,weak) UIViewController *recoveryPage;
@property(nonatomic,weak) UILongPressGestureRecognizer *recoveryGesture;
@property(nonatomic) NSUInteger recoveryEpoch;
@property(nonatomic) BOOL started, lastRevealed, authenticating, backgroundCoverRequired, routingProtectedChat, policyRefreshScheduled;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager { static CSCloseFriendManager *instance; static dispatch_once_t once; dispatch_once(&once,^{ instance=[self new]; }); return instance; }
- (instancetype)init {
    if((self=[super init])) {
        _capabilityMap=[NSMutableDictionary new]; _covers=[NSMutableArray new];
        _entryState=[[CSCloseFriendEntryState alloc] initWithDefaults:[[NSUserDefaults alloc] initWithSuiteName:@"com.wechatimprove.closefriends.entry-discovery"]];
        CSPluginDirectoryMigration *migration=CSPluginStorageMigration(@"CloseFriends");
        CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithMigration:migration keyProvider:^NSData *(NSString *account,NSError **error){
            NSData *key=CSKeychainRead(account,@"policy",error); if(key || (error && *error))return key;
            if(!CSCanCreatePolicyKey(migration,account)) { CSKeychainError(error,errSecItemNotFound); return nil; }
            key=CSCloseFriendRandomBytes(64,error); if(!key || !CSKeychainWrite(account,@"policy",key,NO,error))return nil; return key;
        }];
        store.readKeyProvider=^NSData *(NSString *account,NSError **error){
            NSData *key=CSKeychainRead(account,@"policy",error);
            if(!key && (!error || !*error))CSKeychainError(error,errSecItemNotFound);
            return key;
        };
        _runtime=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{ return NSDate.date.timeIntervalSince1970; } elapsedClock:^NSTimeInterval{ return NSProcessInfo.processInfo.systemUptime; } credentialReader:^NSDictionary *(NSString *account,NSError **error){
            NSData *data=CSKeychainRead(account,@"auth",error); if(!data)return nil;
            id value=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
            if(![value isKindOfClass:NSDictionary.class]) { CSKeychainError(error,errSecDecode); return nil; } return value;
        } credentialWriter:^BOOL(NSString *account,NSDictionary *credential,NSError **error){
            NSData *data=[NSPropertyListSerialization dataWithPropertyList:credential format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
            return data && CSKeychainWrite(account,@"auth",data,YES,error);
        }];
        CSCloseFriendReset *reset=[[CSCloseFriendReset alloc] initWithStore:store entryState:_entryState
            reader:^NSData *(NSString *account,NSString *kind,NSError **error){ return CSKeychainRead(account,kind,error); }
            writer:^BOOL(NSString *account,NSString *kind,NSData *data,NSError **error){ return CSKeychainWrite(account,kind,data,NO,error); }
            remover:^BOOL(NSString *account,NSString *kind,NSError **error){ return CSKeychainRemove(account,kind,error); }];
        _runtime.resetStorage=^BOOL(NSString *account,BOOL begin,NSError **error){
            return begin ? [reset beginResetForAccountID:account error:error] : [reset resumeResetForAccountID:account error:error];
        };
        __weak typeof(self) weakSelf=self;
        _runtime.didChange=^{ [weakSelf schedulePolicyRefresh]; };
    } return self;
}
- (void)schedulePolicyRefresh {
    @synchronized(self) { if(self.policyRefreshScheduled)return; self.policyRefreshScheduled=YES; }
    dispatch_async(dispatch_get_main_queue(),^{ [self flushPolicyRefresh]; });
}
- (void)flushPolicyRefresh {
    NSAssert(NSThread.isMainThread,@"Policy publication on main");
    @synchronized(self) { if(!self.policyRefreshScheduled)return; self.policyRefreshScheduled=NO; }
    [self refreshShakeMonitoring]; [self refreshRecoveryGesture]; [self startExpiryTimer];
    [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];
}
- (NSArray<UIWindow *> *)windows {
    NSMutableArray *windows=[NSMutableArray new];
    for(UIScene *scene in UIApplication.sharedApplication.connectedScenes)if([scene isKindOfClass:UIWindowScene.class])[windows addObjectsFromArray:((UIWindowScene *)scene).windows];
    return windows;
}
- (void)cover {
    // The background appearance switch governs every plugin-wide cover. Keep
    // foreground relock protection and authentication/token invalidation separate.
    BOOL inactive=self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive;
    if(inactive && ![CSBackgroundBlurManager.sharedManager isEnabled]) { [self uncover]; return; }
    for(UIWindow *window in [self windows]) { if(window.hidden)continue;
        UIView *cover=[[UIView alloc] initWithFrame:window.bounds]; cover.backgroundColor=UIColor.systemBackgroundColor; cover.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        cover.accessibilityViewIsModal=YES; [window addSubview:cover]; [self.covers addObject:cover];
    }
}
- (void)uncover { for(UIView *view in self.covers)[view removeFromSuperview]; [self.covers removeAllObjects]; }
- (void)backgroundPrivacySettingsChanged:(NSNotification *)note {
    if(!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self backgroundPrivacySettingsChanged:note]; }); return; }
    BOOL inactive=self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive;
    if(inactive && ![CSBackgroundBlurManager.sharedManager isEnabled]) [self uncover];
}
- (void)returnToChatListIfNeeded {
    if(self.routingProtectedChat) return;
    self.routingProtectedChat=YES;
    @try {
        for(UIWindow *window in [self windows])
            if(!window.hidden) CSCFReturnProtectedChatToList(window.rootViewController,self.recoveryPage);
    } @finally { self.routingProtectedChat=NO; }
}
- (void)lockAndReturnToSafePage {
    NSAssert(NSThread.isMainThread,@"UI on main");
    [self.shakeMonitor stop]; [self.timer invalidate]; self.timer=nil;
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    BOOL sensitive=snapshot.enabled || self.runtime.isAuthorized || self.lastRevealed || self.authenticating;
    [UIView performWithoutAnimation:^{
        if(sensitive)[self cover];
        [self.runtime lock]; self.lastRevealed=NO;
        [self cancelBiometricAuthentication]; self.authenticating=NO; self.passwordFallbackReason=nil;
        if(sensitive) [self returnToChatListIfNeeded];
        // Complete policy publication in this lifecycle callback rather than
        // deferring past snapshot preparation. The queued coalescer becomes a no-op.
        [self flushPolicyRefresh];
        for(UIWindow *window in [self windows]) if(!window.hidden) [window layoutIfNeeded];
        if(!self.backgroundCoverRequired && UIApplication.sharedApplication.applicationState==UIApplicationStateActive) [self uncover];
    }];
}
- (void)start {
    NSAssert(NSThread.isMainThread,@"UI on main"); if(self.started)return; self.started=YES;
    NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(resign:) name:UIApplicationWillResignActiveNotification object:nil];
    [center addObserver:self selector:@selector(suspend:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [center addObserver:self selector:@selector(active:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [center addObserver:self selector:@selector(accountChanged:) name:@"CSBackupAccountChanged" object:nil];
    [center addObserver:self selector:@selector(suspend:) name:UIApplicationProtectedDataWillBecomeUnavailable object:nil];
    for(NSString *name in @[CSBackgroundBlurSettingsChangedNotification,@"com.wechat.tweak.settings_changed",@"com.wechat.tweak.local_settings_changed"])
        [center addObserver:self selector:@selector(backgroundPrivacySettingsChanged:) name:name object:nil];
    [self.runtime setActive:UIApplication.sharedApplication.applicationState==UIApplicationStateActive];
    [self refreshAccount];
    [self refreshShakeMonitoring];
    [self startExpiryTimer];
}
- (BOOL)canLockForShake {
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    return self.started && !self.backgroundCoverRequired && UIApplication.sharedApplication.applicationState==UIApplicationStateActive &&
        !snapshot.blocked && snapshot.enabled && snapshot.revealed && [snapshot.options[@"shakeToLock"] boolValue];
}
- (void)refreshShakeMonitoring {
    NSAssert(NSThread.isMainThread,@"Shake lifecycle on main");
    if(![self canLockForShake]) { [self.shakeMonitor stop]; return; }
    if(!self.shakeMonitor) self.shakeMonitor=[CSCloseFriendShakeMonitor new];
    __weak typeof(self) weakSelf=self;
    [self.shakeMonitor startForAccountEpoch:CSCloseFriendAccountEpoch() onShake:^(NSUInteger epoch){
        // The motion callback may have been queued just before logout/relock.
        if(epoch==CSCloseFriendAccountEpoch()) [weakSelf handleShake];
    }];
}
- (void)handleShake {
    NSAssert(NSThread.isMainThread,@"Shake action on main");
    if([self canLockForShake]) [self lockAndReturnToSafePage];
}
- (void)startExpiryTimer {
    NSAssert(NSThread.isMainThread,@"Expiry scheduling on main");
    [self.timer invalidate]; self.timer=nil;
    NSTimeInterval remaining=self.runtime.revealTimeRemaining;
    if(remaining<=0) {
        // A policy read may observe expiry before the timer callback is delivered.
        if(self.lastRevealed)[self lockAndReturnToSafePage];
        return;
    }
    self.lastRevealed=YES;
    __weak typeof(self) weakSelf=self;
    self.timer=[NSTimer timerWithTimeInterval:remaining repeats:NO block:^(__unused NSTimer *timer){
        typeof(self) self=weakSelf; if(!self)return;
        self.timer=nil;
        if(self.runtime.revealTimeRemaining>0) [self startExpiryTimer];
        else [self lockAndReturnToSafePage];
    }];
    // One deadline wakeup, including while a scroll view tracks a finger.
    [NSRunLoop.mainRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)resign:(NSNotification *)note {
    // LocalAuthentication can temporarily deactivate the app. Keep only this locked
    // challenge alive; a real background/lock-screen notification still cancels it.
    if(self.authenticationContext) { self.backgroundCoverRequired=YES; [self cover]; return; }
    [self suspend:note];
}
- (void)suspend:(NSNotification *)note {
    self.backgroundCoverRequired=YES;
    // setActive:NO also invalidates policy; include it before the synchronous flush.
    [self.runtime setActive:NO]; [self lockAndReturnToSafePage];
}
- (void)active:(NSNotification *)note {
    [self.runtime setActive:YES]; [self refreshAccount]; self.backgroundCoverRequired=NO;
    void (^reply)(void)=self.pendingBiometricReply; self.pendingBiometricReply=nil;
    if(reply)reply();
    [self flushPolicyRefresh];
    [self uncover];
}
- (void)accountChanged:(NSNotification *)note { [self lockAndReturnToSafePage]; [self refreshAccount]; }
- (void)refreshAccount {
    NSAssert(NSThread.isMainThread,@"Account service on main");
    NSUInteger epoch=CSBackupAccountEpoch(); BOOL suspended=CSBackupAccountIsSuspended(); NSString *account=@"";
    if(!suspended) {
        account=CSCloseFriendResolveAccount(^Class(NSString *name){ return NSClassFromString(name); })?:@"";
        [self recordCapability:@"当前账号读取" available:account.length>0];
    }
    if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended()) { suspended=YES; account=@""; }
    // Recovery can finish a confirmed reset, so loading shares the account mutation lock.
    BOOL ran=CSBackupPerformAtAccountEpoch(epoch,^{
        BOOL unavailable=suspended || CSBackupAccountIsSuspended();
        [self.runtime synchronizeAccount:unavailable?@"":account epoch:epoch suspended:unavailable];
    });
    if(!ran)[self.runtime synchronizeAccount:@"" epoch:CSBackupAccountEpoch() suspended:YES];
}
- (void)message:(NSString *)text presenter:(UIViewController *)presenter {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"密友" message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]]; [presenter presentViewController:alert animated:YES completion:nil];
}
- (BOOL)validateToken:(NSDictionary *)token {
    [self refreshAccount]; return !CSBackupAccountIsSuspended() && [token[@"epoch"] unsignedIntegerValue]==CSBackupAccountEpoch() && [self.runtime isTokenCurrent:token];
}
- (void)passwordPrompt:(UIViewController *)presenter token:(NSDictionary *)token setup:(BOOL)setup completion:(void (^)(BOOL))completion {
    NSString *reason=self.passwordFallbackReason; self.passwordFallbackReason=nil;
    NSString *message=setup?@"设置至少 6 位数字或 8 个字符的密码后才可启用（最长 128 个字符）。请妥善保存；无法通过普通备份恢复凭据。":@"验证后临时显示密友。后台、锁定或账号切换会立即失效。";
    if(reason.length && !setup)message=[NSString stringWithFormat:@"%@\n%@",reason,message];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:setup?@"设置密友密码":@"验证密友密码" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.secureTextEntry=YES; field.placeholder=@"密码"; field.textContentType=setup?UITextContentTypeNewPassword:UITextContentTypePassword; }];
    if(setup)[alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.secureTextEntry=YES; field.placeholder=@"再次输入密码"; }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action){ self.authenticating=NO; if(completion)completion(NO); }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        self.authenticating=NO; __block NSError *error=nil; __block BOOL ok=NO;
        if([self validateToken:token]) {
            NSString *password=alert.textFields.firstObject.text?:@"";
            if(setup && ![password isEqual:alert.textFields.lastObject.text])error=[NSError errorWithDomain:@"CSCloseFriend" code:1 userInfo:@{NSLocalizedDescriptionKey:@"两次输入的密码不一致。"}];
            if(!error)CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
                if(CSBackupAccountIsSuspended())return;
                ok=setup?[self.runtime setPassword:password token:token error:&error]:[self.runtime authenticatePassword:password token:token error:&error];
            });
        }
        self.lastRevealed=CSCloseFriendCurrentSnapshot().revealed;
        if(completion)completion(ok);
        if(!ok)[self message:error.localizedDescription?:@"验证已失效，请重试。" presenter:presenter];
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}
- (void)cancelBiometricAuthentication {
    LAContext *context=self.authenticationContext;
    void (^completion)(BOOL)=self.biometricCompletion;
    self.authenticationContext=nil; self.biometricCompletion=nil; self.pendingBiometricReply=nil;
    [context invalidate];
    if(completion)completion(NO);
}
- (NSString *)biometricFailureReason:(NSError *)error {
    if(![error.domain isEqual:LAErrorDomain])return @"生物识别暂不可用，请输入密友密码。";
    switch(error.code) {
        case LAErrorBiometryNotEnrolled: return @"设备尚未录入面容或指纹，请输入密友密码。";
        case LAErrorBiometryNotAvailable: return @"设备不支持生物识别或未授权，请输入密友密码。";
        case LAErrorPasscodeNotSet: return @"设备未设置锁屏密码，请输入密友密码。";
        case LAErrorBiometryLockout: return @"系统生物识别已锁定，请输入密友密码。";
        case LAErrorUserCancel: case LAErrorSystemCancel: case LAErrorAppCancel:
            return @"生物识别已取消，请输入密友密码。";
        case LAErrorUserFallback: return @"请输入密友密码。";
        default: return @"生物识别未通过，请输入密友密码。";
    }
}
- (void)biometricPasswordFallbackFrom:(UIViewController *)presenter token:(NSDictionary *)token reason:(NSString *)reason domainState:(NSData *)domain completion:(void (^)(BOOL))completion {
    self.passwordFallbackReason=reason;
    [self passwordPrompt:presenter token:token setup:NO completion:^(BOOL accepted){
        // Enrollment changes are trusted only after the independent friend password.
        if(accepted && domain.length)CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
            if(!CSBackupAccountIsSuspended() && self.runtime.isAuthorized &&
               [self.runtime.authenticationToken[@"account"] isEqual:token[@"account"]])
                CSKeychainWrite(token[@"account"],@"biometric-domain",domain,YES,NULL);
        });
        if(completion)completion(accepted);
    }];
}
- (void)finishBiometricContext:(LAContext *)context token:(NSDictionary *)token presenter:(UIViewController *)presenter success:(BOOL)success error:(NSError *)error {
    NSAssert(NSThread.isMainThread,@"Biometric completion on main");
    if(self.authenticationContext!=context)return; // Cancelled/older callbacks cannot finish a newer challenge.
    if(self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) {
        __weak typeof(self) weakSelf=self;
        self.pendingBiometricReply=^{ [weakSelf finishBiometricContext:context token:token presenter:presenter success:success error:error]; };
        return;
    }
    void (^completion)(BOOL)=self.biometricCompletion;
    self.authenticationContext=nil; self.biometricCompletion=nil; self.pendingBiometricReply=nil;
    NSData *domain=[context.evaluatedPolicyDomainState copy]; [context invalidate];
    if(![self validateToken:token] || !presenter.view.window) { self.authenticating=NO; if(completion)completion(NO); return; }
    NSString *reason=[self biometricFailureReason:error];
    __block BOOL accepted=NO;
    if(success) {
        NSError *storageError=nil;
        NSData *previous=CSKeychainRead(token[@"account"],@"biometric-domain",&storageError);
        BOOL domainMatches=domain.length && !storageError && (!previous || [previous isEqual:domain]);
        // First use establishes a device/account baseline without changing the password schema.
        if(domainMatches && !previous)domainMatches=CSKeychainWrite(token[@"account"],@"biometric-domain",domain,YES,&storageError);
        if(domainMatches)CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{ if(!CSBackupAccountIsSuspended())accepted=[self.runtime completeBiometricWithToken:token]; });
        reason=storageError || !domain.length ? @"生物识别安全记录不可用，请输入密友密码。" :
            !domainMatches ? @"面容或指纹信息已变更，请先输入密友密码。" : @"当前验证未获授权，可能处于密码错误冷却期，请输入密友密码或稍后重试。";
    }
    if(accepted) { self.authenticating=NO; self.lastRevealed=YES; if(completion)completion(YES); }
    else [self biometricPasswordFallbackFrom:presenter token:token reason:reason domainState:success?domain:nil completion:completion];
}
- (void)authenticateFrom:(UIViewController *)presenter completion:(void (^)(BOOL))completion {
    if(!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self authenticateFrom:presenter completion:completion]; }); return; }
    [self start]; [self refreshAccount];
    if(self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) { if(completion)completion(NO); return; }
    if([self.runtime isAuthorized]) { if(completion)completion(YES); return; }
    NSDictionary *token=self.runtime.authenticationToken;
    if(!token || self.authenticating || !presenter.view.window) {
        if(completion)completion(NO);
        if(!token && presenter.view.window)[self message:@"当前账号或密友安全数据不可用。现有数据已保留，请在解锁设备并进入微信首页后重试。" presenter:presenter];
        return;
    }
    self.authenticating=YES;
    BOOL setup=![self.runtime hasCredential];
    if(!setup && [self.runtime.currentProfile[@"options"][@"biometric"] boolValue]) {
        LAContext *context=[LAContext new]; self.authenticationContext=context;
        context.touchIDAuthenticationAllowableReuseDuration=0;
        context.localizedFallbackTitle=@"使用密友密码";
        NSError *error=nil; BOOL available=[context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        [self recordCapability:@"生物识别" available:available];
        if(available) {
            self.biometricCompletion=completion;
            __weak typeof(self) weakSelf=self;
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证后临时显示密友" reply:^(BOOL success,NSError *error){
                dispatch_async(dispatch_get_main_queue(),^{
                    [weakSelf finishBiometricContext:context token:token presenter:presenter success:success error:error];
                });
            }]; return;
        }
        self.authenticationContext=nil; [context invalidate];
        [self biometricPasswordFallbackFrom:presenter token:token reason:[self biometricFailureReason:error] domainState:nil completion:completion];
        return;
    }
    [self passwordPrompt:presenter token:token setup:setup completion:completion];
}
- (BOOL)settingsEntryVisible {
    [self start]; [self refreshAccount];
    return [self.entryState isEntryVisibleForSnapshot:CSCloseFriendCurrentSnapshot() hasCredential:self.runtime.hasCredential];
}
- (NSDictionary *)settingsEntryDiscoveryToken {
    [self start]; [self refreshAccount];
    if(self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive ||
       [self.entryState hasDiscoveredEntryForSnapshot:CSCloseFriendCurrentSnapshot() hasCredential:self.runtime.hasCredential])return nil;
    return self.runtime.authenticationToken;
}
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token {
    if(!NSThread.isMainThread || !token || self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive)return NO;
    __block BOOL discovered=NO;
    CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
        if(![self validateToken:token])return;
        discovered=[self.entryState discoverEntryForSnapshot:CSCloseFriendCurrentSnapshot() hasCredential:self.runtime.hasCredential];
    });
    return discovered;
}
- (void)presentSettingsFrom:(UIViewController *)presenter {
    if(![self settingsEntryVisible])return;
    [self authenticateFrom:presenter completion:^(BOOL success){
        if(!success)return;
        CSCloseFriendSettingsViewController *settings=[[CSCloseFriendSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
        if(presenter.navigationController)[presenter.navigationController pushViewController:settings animated:YES];
        else [presenter presentViewController:[[UINavigationController alloc] initWithRootViewController:settings] animated:YES completion:nil];
    }];
}
- (void)changePasswordFrom:(UIViewController *)presenter {
    [self refreshAccount];
    if(!self.runtime.isAuthorized)return;
    [self passwordPrompt:presenter token:self.runtime.authenticationToken setup:YES completion:nil];
}
- (BOOL)canResetFrom:(UIViewController *)presenter token:(NSDictionary *)token {
    return !self.backgroundCoverRequired && UIApplication.sharedApplication.applicationState==UIApplicationStateActive &&
        presenter.view.window && [self validateToken:token] && self.runtime.isAuthorized &&
        (!presenter.navigationController || presenter.navigationController.topViewController==presenter);
}
- (void)finishResetAlert:(UIAlertController *)alert presenter:(UIViewController *)presenter completion:(void (^)(void))completion {
    // UIAlertAction may already be dismissing its alert. Never dismiss the settings
    // navigation controller or a newer modal when a stale action finishes.
    id<UIViewControllerTransitionCoordinator> transition=alert.transitionCoordinator;
    if(alert.isBeingDismissed && transition && [transition animateAlongsideTransition:nil completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context){ completion(); }])return;
    if(alert && presenter.presentedViewController==alert)[alert dismissViewControllerAnimated:YES completion:completion];
    else completion();
}
- (void)confirmResetFrom:(UIViewController *)presenter token:(NSDictionary *)token completion:(void (^)(BOOL))completion {
    if(![self canResetFrom:presenter token:token]) { [self.runtime cancelResetWithToken:token]; if(completion)completion(NO); return; }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"重置当前账号的密友？"
        message:@"将清空密友和密群名单、全部保护选项、密友密码、生物识别记录及入口发现记录。保护将关闭，“捉迷藏呀”重新隐藏。\n微信好友、聊天记录、免打扰设置和其他账号不受影响。此操作无法撤销。"
        preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlert=alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action){
        [self.runtime cancelResetWithToken:token]; if(completion)completion(NO);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"重置密友" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action){
        __block BOOL ok=NO; __block NSError *error=nil;
        if([self canResetFrom:presenter token:token])CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
            if(!CSBackupAccountIsSuspended() && [self.runtime isTokenCurrent:token])ok=[self.runtime resetWithToken:token error:&error];
        });
        [self.runtime cancelResetWithToken:token];
        self.lastRevealed=self.runtime.isAuthorized;
        [self flushPolicyRefresh];
        [self finishResetAlert:weakAlert presenter:presenter completion:^{
            if(completion)completion(ok);
            if(!ok && presenter.view.window)[self message:error.localizedDescription?:@"重置已取消，当前验证或页面已失效。请重新进入密友设置。" presenter:presenter];
        }];
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}
- (void)resetFrom:(UIViewController *)presenter completion:(void (^)(BOOL))completion {
    NSAssert(NSThread.isMainThread,@"Reset UI on main");
    [self refreshAccount]; NSDictionary *token=self.runtime.authenticationToken;
    if(![self canResetFrom:presenter token:token] || presenter.presentedViewController || self.authenticating) { if(completion)completion(NO); return; }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"验证密友密码" message:@"重置前需输入当前密友密码。验证后仍需确认才会清空。" preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlert=alert;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.secureTextEntry=YES; field.textContentType=UITextContentTypePassword; field.placeholder=@"当前密友密码"; }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action){ if(completion)completion(NO); }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"验证" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        __block NSDictionary *proof=nil; __block NSError *error=nil;
        if([self canResetFrom:presenter token:token])CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
            if(!CSBackupAccountIsSuspended())proof=[self.runtime prepareResetWithPassword:weakAlert.textFields.firstObject.text?:@"" token:token error:&error];
        });
        weakAlert.textFields.firstObject.text=@"";
        [self finishResetAlert:weakAlert presenter:presenter completion:^{
            if(proof)[self confirmResetFrom:presenter token:proof completion:completion];
            else { if(completion)completion(NO); if(presenter.view.window)[self message:error.localizedDescription?:@"验证已失效，请重试。" presenter:presenter]; }
        }];
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}
- (NSDictionary *)capabilities { @synchronized(self.capabilityMap) { return [self.capabilityMap copy]; } }
- (void)recordCapability:(NSString *)name available:(BOOL)available { if(!name.length)return; @synchronized(self.capabilityMap) { self.capabilityMap[name]=@(available); } }
- (void)checkHomepageSearchPassword:(NSString *)query isCurrent:(BOOL (^)(void))isCurrent completion:(void (^)(BOOL))completion {
    if(!NSThread.isMainThread || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) {completion(YES);return;}
    [self refreshAccount];
    [self.runtime checkSearchPassword:query token:self.runtime.authenticationToken isCurrent:^BOOL{return UIApplication.sharedApplication.applicationState==UIApplicationStateActive && isCurrent();} completion:^(BOOL consumed){
        if(consumed)self.lastRevealed=self.runtime.isAuthorized;
        completion(consumed);
    }];
}
- (void)recovery:(UILongPressGestureRecognizer *)gesture {
    if(gesture!=self.recoveryGesture || !gesture.enabled || gesture.state!=UIGestureRecognizerStateBegan || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) return;
    UIViewController *page=self.recoveryPage;
    if(!page || page.navigationController.topViewController!=page || page.presentedViewController || gesture.view!=page.navigationController.navigationBar) return;
    NSUInteger epoch=self.recoveryEpoch;
    [self refreshAccount];
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(epoch!=CSCloseFriendAccountEpoch() || snapshot.blocked || !snapshot.enabled || ![snapshot.options[@"longPressUnlockEnabled"] boolValue] || gesture.minimumPressDuration!=[snapshot.options[@"longPressUnlockDuration"] doubleValue]) return;
    if([snapshot.options[@"biometric"] boolValue]) {
        [self authenticateFrom:page completion:^(BOOL accepted){
            if(accepted)[[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] impactOccurred];
        }];
        return;
    }
    if([self.runtime revealWithShortcutToken:self.runtime.authenticationToken]) {
        self.lastRevealed=YES;
        [[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] impactOccurred];
    }
}
- (void)refreshRecoveryGesture {
    UILongPressGestureRecognizer *gesture=self.recoveryGesture;
    if(!gesture) return;
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    NSTimeInterval duration=[snapshot.options[@"longPressUnlockDuration"] doubleValue];
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    // Cancel an in-flight touch when its account or threshold changes.
    if(self.recoveryEpoch!=epoch || gesture.minimumPressDuration!=duration) gesture.enabled=NO;
    self.recoveryEpoch=epoch;
    gesture.minimumPressDuration=duration;
    gesture.enabled=!snapshot.blocked && snapshot.enabled && [snapshot.options[@"longPressUnlockEnabled"] boolValue];
}
- (void)attachRecoveryGestureTo:(UIViewController *)controller {
    // Some WeChat builds expose an NSObject main-frame owner with curViewController.
    id page=[controller isKindOfClass:UIViewController.class] ? controller : CSCloseFriendRead(controller,@"curViewController");
    if(![page isKindOfClass:UIViewController.class]) return;
    self.recoveryPage=page;
    UINavigationBar *bar=self.recoveryPage.navigationController.navigationBar; if(!bar)return;
    static char recoveryKey;
    UILongPressGestureRecognizer *gesture=objc_getAssociatedObject(bar,&recoveryKey);
    if(!gesture) {
        gesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(recovery:)];
        gesture.cancelsTouchesInView=NO;
        [bar addGestureRecognizer:gesture]; objc_setAssociatedObject(bar,&recoveryKey,gesture,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if(self.recoveryGesture!=gesture) self.recoveryGesture.enabled=NO;
    self.recoveryGesture=gesture;
    [self refreshRecoveryGesture];
}

@end
