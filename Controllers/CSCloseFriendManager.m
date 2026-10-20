#import "CSCloseFriendManager.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendSettingsViewController.h"
#import "CSCloseFriendCrypto.h"
#import "CSCloseFriendAccount.h"
#import "CSBackupBootstrap.h"
#import <Security/Security.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <CommonCrypto/CommonCrypto.h>
#import <objc/message.h>
#import <sys/stat.h>
static NSString *CSAccountDigest(NSString *account) {
    NSData *data=[account dataUsingEncoding:NSUTF8StringEncoding]; uint8_t bytes[CC_SHA256_DIGEST_LENGTH]; CC_SHA256(data.bytes,(CC_LONG)data.length,bytes);
    NSMutableString *result=[NSMutableString new]; for(NSUInteger i=0;i<sizeof(bytes);i++)[result appendFormat:@"%02x",bytes[i]]; return result;
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
@interface CSCloseFriendManager ()
@property(nonatomic,strong,readwrite) CSCloseFriendRuntime *runtime;
@property(nonatomic,strong) NSMutableDictionary *capabilityMap;
@property(nonatomic,strong) NSMutableArray<UIView *> *covers;
@property(nonatomic,strong) LAContext *authenticationContext;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic) BOOL started, lastRevealed, authenticating, backgroundCoverRequired;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager { static CSCloseFriendManager *instance; static dispatch_once_t once; dispatch_once(&once,^{ instance=[self new]; }); return instance; }
- (instancetype)init {
    if((self=[super init])) {
        _capabilityMap=[NSMutableDictionary new]; _covers=[NSMutableArray new];
        NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
        NSURL *root=[library URLByAppendingPathComponent:@"Application Support/WeChatImprove/CloseFriends" isDirectory:YES];
        CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(NSString *account,NSError **error){
            NSData *key=CSKeychainRead(account,@"policy",error); if(key || (error && *error))return key;
            NSURL *existing=[root URLByAppendingPathComponent:[NSString stringWithFormat:@"state-%@.bin",CSAccountDigest(account)]];
            struct stat st; if(lstat(existing.path.fileSystemRepresentation,&st)==0 || errno!=ENOENT) { CSKeychainError(error,errSecItemNotFound); return nil; }
            key=CSCloseFriendRandomBytes(64,error); if(!key || !CSKeychainWrite(account,@"policy",key,NO,error))return nil; return key;
        }];
        _runtime=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{ return NSDate.date.timeIntervalSince1970; } elapsedClock:^NSTimeInterval{ return NSProcessInfo.processInfo.systemUptime; } credentialReader:^NSDictionary *(NSString *account,NSError **error){
            NSData *data=CSKeychainRead(account,@"auth",error); if(!data)return nil;
            id value=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
            if(![value isKindOfClass:NSDictionary.class]) { CSKeychainError(error,errSecDecode); return nil; } return value;
        } credentialWriter:^BOOL(NSString *account,NSDictionary *credential,NSError **error){
            NSData *data=[NSPropertyListSerialization dataWithPropertyList:credential format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
            return data && CSKeychainWrite(account,@"auth",data,YES,error);
        }];
        __weak typeof(self) weakSelf=self;
        _runtime.didChange=^{
            // Defer observers outside the runtime lock; no username or profile in notification payload.
            dispatch_async(dispatch_get_main_queue(),^{
                typeof(self) self=weakSelf; if(!self)return;
                [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];
            });
        };
    } return self;
}
- (NSArray<UIWindow *> *)windows {
    NSMutableArray *windows=[NSMutableArray new];
    for(UIScene *scene in UIApplication.sharedApplication.connectedScenes)if([scene isKindOfClass:UIWindowScene.class])[windows addObjectsFromArray:((UIWindowScene *)scene).windows];
    return windows;
}
- (void)cover {
    for(UIWindow *window in [self windows]) { if(window.hidden)continue;
        UIView *cover=[[UIView alloc] initWithFrame:window.bounds]; cover.backgroundColor=UIColor.systemBackgroundColor; cover.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        cover.accessibilityViewIsModal=YES; [window addSubview:cover]; [self.covers addObject:cover];
    }
}
- (void)uncover { for(UIView *view in self.covers)[view removeFromSuperview]; [self.covers removeAllObjects]; }
- (void)returnSafe:(UIViewController *)controller {
    if(controller.presentedViewController)[controller dismissViewControllerAnimated:NO completion:nil];
    if([controller isKindOfClass:UINavigationController.class])[(UINavigationController *)controller popToRootViewControllerAnimated:NO];
    if([controller isKindOfClass:UITabBarController.class])[(UITabBarController *)controller setSelectedIndex:0];
    for(UIViewController *child in controller.childViewControllers)[self returnSafe:child];
}
- (void)lockAndReturnToSafePage {
    NSAssert(NSThread.isMainThread,@"UI on main");
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    BOOL sensitive=snapshot.enabled || self.runtime.isAuthorized || self.lastRevealed || self.authenticating;
    if(sensitive)[self cover];
    [self.authenticationContext invalidate]; self.authenticationContext=nil; self.authenticating=NO;
    [self.runtime lock]; self.lastRevealed=NO;
    if(sensitive)for(UIWindow *window in [self windows])[self returnSafe:window.rootViewController];
    if(!self.backgroundCoverRequired && UIApplication.sharedApplication.applicationState==UIApplicationStateActive)[self uncover];
}
- (void)start {
    NSAssert(NSThread.isMainThread,@"UI on main"); if(self.started)return; self.started=YES;
    NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(resign:) name:UIApplicationWillResignActiveNotification object:nil];
    [center addObserver:self selector:@selector(active:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [center addObserver:self selector:@selector(accountChanged:) name:@"CSBackupAccountChanged" object:nil];
    [center addObserver:self selector:@selector(resign:) name:UIApplicationProtectedDataWillBecomeUnavailable object:nil];
    [self.runtime setActive:UIApplication.sharedApplication.applicationState==UIApplicationStateActive];
    [self refreshAccount];
    __weak typeof(self) weakSelf=self;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(__unused NSTimer *timer){
        typeof(self) self=weakSelf; if(!self)return;
        CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
        if(self.lastRevealed && !snapshot.revealed)[self lockAndReturnToSafePage];
        self.lastRevealed=snapshot.revealed;
    }];
}
- (void)resign:(NSNotification *)note { self.backgroundCoverRequired=YES; [self lockAndReturnToSafePage]; [self.runtime setActive:NO]; }
- (void)active:(NSNotification *)note { [self.runtime setActive:YES]; [self refreshAccount]; self.backgroundCoverRequired=NO; [self uncover]; }
- (void)accountChanged:(NSNotification *)note { [self lockAndReturnToSafePage]; [self refreshAccount]; }
- (void)refreshAccount {
    NSAssert(NSThread.isMainThread,@"Account service on main");
    NSUInteger epoch=CSBackupAccountEpoch(); BOOL suspended=CSBackupAccountIsSuspended(); NSString *account=@"";
    if(!suspended) {
        account=CSCloseFriendResolveAccount(^Class(NSString *name){ return NSClassFromString(name); })?:@"";
        [self recordCapability:@"当前账号读取" available:account.length>0];
    }
    if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended()) { suspended=YES; account=@""; }
    [self.runtime synchronizeAccount:account epoch:epoch suspended:suspended];
}
- (void)message:(NSString *)text presenter:(UIViewController *)presenter {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"密友" message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]]; [presenter presentViewController:alert animated:YES completion:nil];
}
- (BOOL)validateToken:(NSDictionary *)token {
    [self refreshAccount]; return !CSBackupAccountIsSuspended() && [token[@"epoch"] unsignedIntegerValue]==CSBackupAccountEpoch() && [self.runtime isTokenCurrent:token];
}
- (void)passwordPrompt:(UIViewController *)presenter token:(NSDictionary *)token setup:(BOOL)setup completion:(void (^)(BOOL))completion {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:setup?@"设置密友密码":@"验证密友密码" message:setup?@"设置至少 6 位数字或 8 个字符的密码后才可启用（最长 128 个字符）。请妥善保存；无法通过普通备份恢复凭据。":@"验证后临时显示密友。后台、锁定或账号切换会立即失效。" preferredStyle:UIAlertControllerStyleAlert];
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
- (void)authenticateFrom:(UIViewController *)presenter completion:(void (^)(BOOL))completion {
    [self start]; [self refreshAccount];
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
        NSError *error=nil; BOOL available=[context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        [self recordCapability:@"生物识别" available:available];
        if(available) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证后临时显示密友" reply:^(BOOL success,__unused NSError *error){
                dispatch_async(dispatch_get_main_queue(),^{
                    if(self.authenticationContext!=context) { if(completion)completion(NO); return; }
                    self.authenticationContext=nil;
                    if(![self validateToken:token]) { self.authenticating=NO; if(completion)completion(NO); return; }
                    __block BOOL accepted=NO;
                    if(success)CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{ if(!CSBackupAccountIsSuspended())accepted=[self.runtime completeBiometricWithToken:token]; });
                    if(accepted) { self.authenticating=NO; self.lastRevealed=YES; if(completion)completion(YES); }
                    else [self passwordPrompt:presenter token:token setup:NO completion:completion];
                });
            }]; return;
        }
    }
    [self passwordPrompt:presenter token:token setup:setup completion:completion];
}
- (void)presentSettingsFrom:(UIViewController *)presenter {
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
- (NSDictionary *)capabilities { @synchronized(self.capabilityMap) { return [self.capabilityMap copy]; } }
- (void)recordCapability:(NSString *)name available:(BOOL)available { if(!name.length)return; @synchronized(self.capabilityMap) { self.capabilityMap[name]=@(available); } }
- (void)recovery:(UILongPressGestureRecognizer *)gesture {
    if(gesture.state!=UIGestureRecognizerStateBegan)return;
    UIResponder *responder=gesture.view; while(responder && ![responder isKindOfClass:UIViewController.class])responder=responder.nextResponder;
    UIViewController *controller=(UIViewController *)responder;
    if([controller isKindOfClass:UINavigationController.class])controller=((UINavigationController *)controller).topViewController;
    if(controller)[self presentSettingsFrom:controller];
}
- (void)attachRecoveryGestureTo:(UIViewController *)controller {
    UINavigationBar *bar=controller.navigationController.navigationBar; if(!bar)return;
    static char recoveryKey;
    if(objc_getAssociatedObject(bar,&recoveryKey))return;
    UILongPressGestureRecognizer *gesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(recovery:)]; gesture.minimumPressDuration=1.2;
    [bar addGestureRecognizer:gesture]; objc_setAssociatedObject(bar,&recoveryKey,gesture,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
