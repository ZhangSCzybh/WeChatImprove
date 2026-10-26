#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "CSCloseFriendRuntime.h"

// Execute production Manager authentication/lifecycle methods with the real runtime.
// Only UIKit, LocalAuthentication, account service and Keychain are host fixtures.
static NSUInteger checks, epoch=1, canCalls, evaluateCalls;
static BOOL suspended, available=YES, keychainFailure;
static NSError *availabilityError;
static NSData *domain;
static NSMutableDictionary *domains;
static CSCloseFriendRuntime *runtimeUnderTest;
static void Check(BOOL ok,const char *message) {checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message);exit(1);}}
static NSUInteger CSBackupAccountEpoch(void) {return epoch;}
static BOOL CSBackupAccountIsSuspended(void) {return suspended;}
static BOOL CSBackupPerformAtAccountEpoch(NSUInteger expected,void (^block)(void)) {if(expected!=epoch)return NO;block();return YES;}
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return [runtimeUnderTest snapshotForEpoch:epoch suspended:suspended];}
static NSData *CSKeychainRead(NSString *account,__unused NSString *kind,NSError **error) {
    if(keychainFailure) {if(error)*error=[NSError errorWithDomain:NSOSStatusErrorDomain code:-1 userInfo:nil];return nil;}
    return domains[account];
}
static BOOL CSKeychainWrite(NSString *account,__unused NSString *kind,NSData *value,__unused BOOL replace,NSError **error) {
    if(keychainFailure) {if(error)*error=[NSError errorWithDomain:NSOSStatusErrorDomain code:-1 userInfo:nil];return NO;}
    domains[account]=value;return YES;
}
@interface UIView:NSObject
@property(nonatomic,strong) id window;
+ (void)performWithoutAnimation:(void (^)(void))actions;
@end
@implementation UIView
+ (void)performWithoutAnimation:(void (^)(void))actions {actions();}
@end
@interface UIWindow:NSObject
@property(nonatomic) BOOL hidden;
- (void)layoutIfNeeded;
@end
@implementation UIWindow
- (void)layoutIfNeeded {}
@end
@interface UIViewController:NSObject
@property(nonatomic,strong) UIView *view;
@end
@implementation UIViewController @end
enum {UIApplicationStateActive,UIApplicationStateInactive,UIApplicationStateBackground};
static NSString *const UIApplicationWillResignActiveNotification=@"fixture-will-resign";
static NSString *const UIApplicationDidEnterBackgroundNotification=@"fixture-background";
static NSString *const UIApplicationDidBecomeActiveNotification=@"fixture-active";
static NSString *const UIApplicationProtectedDataWillBecomeUnavailable=@"fixture-locked";
static NSString *const CSBackgroundBlurSettingsChangedNotification=@"fixture-background-blur-setting";
static NSString *const CSCloseFriendPolicyDidChangeNotification=@"fixture-policy-change";
@interface UIApplication:NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication {static UIApplication *app;if(!app)app=[self new];return app;}
@end
@interface CSFakeLAContext:NSObject
@property(nonatomic) NSTimeInterval touchIDAuthenticationAllowableReuseDuration;
@property(nonatomic,copy) NSString *localizedFallbackTitle;
@property(nonatomic,copy) NSData *evaluatedPolicyDomainState;
@property(nonatomic,copy) void (^reply)(BOOL,NSError *);
@property(nonatomic) BOOL invalidated;
- (BOOL)canEvaluatePolicy:(LAPolicy)policy error:(NSError **)error;
- (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)reason reply:(void (^)(BOOL,NSError *))reply;
- (void)invalidate;
@end
@implementation CSFakeLAContext
- (instancetype)init {if((self=[super init])) {_touchIDAuthenticationAllowableReuseDuration=99;_evaluatedPolicyDomainState=domain;}return self;}
- (BOOL)canEvaluatePolicy:(LAPolicy)policy error:(NSError **)error {
    Check(NSThread.isMainThread && policy==LAPolicyDeviceOwnerAuthenticationWithBiometrics,"availability checked on main for biometrics-only policy");
    canCalls++;if(!available && error)*error=availabilityError;return available;
}
- (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)reason reply:(void (^)(BOOL,NSError *))reply {
    Check(NSThread.isMainThread && policy==LAPolicyDeviceOwnerAuthenticationWithBiometrics && reason.length,"real system evaluation requested on main with a reason");
    evaluateCalls++;self.reply=reply;
}
- (void)invalidate {self.invalidated=YES;}
@end
#define LAContext CSFakeLAContext
@interface BiometricManager:NSObject
@property(nonatomic,strong) CSCloseFriendRuntime *runtime;
@property(nonatomic,strong) LAContext *authenticationContext;
@property(nonatomic,copy) void (^biometricCompletion)(BOOL);
@property(nonatomic,copy) void (^pendingBiometricReply)(void);
@property(nonatomic,copy) NSString *passwordFallbackReason;
@property(nonatomic,copy) NSString *observedReason;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) NSTimer *shakeMonitor; // stop is a fixture category below.
@property(nonatomic) BOOL started,lastRevealed,authenticating,backgroundCoverRequired,passwordAccepted,policyRefreshScheduled;
@property(nonatomic) NSUInteger passwordPrompts,covers,lockCount;
- (void)start;
- (void)refreshAccount;
- (void)cover;
- (void)uncover;
- (void)returnToChatListIfNeeded;
- (void)message:(NSString *)text presenter:(UIViewController *)presenter;
- (void)recordCapability:(NSString *)name available:(BOOL)value;
- (void)passwordPrompt:(UIViewController *)presenter token:(NSDictionary *)token setup:(BOOL)setup completion:(void (^)(BOOL))completion;
- (void)authenticateFrom:(UIViewController *)presenter completion:(void (^)(BOOL))completion;
- (void)cancelBiometricAuthentication;
@end
@interface NSTimer (FixtureStop)
- (void)stop;
@end
@implementation NSTimer (FixtureStop)
- (void)stop {}
@end
@implementation BiometricManager
- (void)refreshShakeMonitoring {}
- (void)refreshRecoveryGesture {}
- (NSArray<UIWindow *> *)windows {return @[];}
- (void)startExpiryTimer {}
- (void)backgroundPrivacySettingsChanged:(__unused NSNotification *)note {}
- (void)refreshAccount {[self.runtime synchronizeAccount:@"biometric-fixture" epoch:epoch suspended:suspended];}
- (void)cover {self.covers++;}
- (void)uncover {self.covers=0;}
- (void)returnToChatListIfNeeded {self.lockCount++;}
- (void)message:(NSString *)text presenter:(__unused UIViewController *)presenter {self.observedReason=text;}
- (void)recordCapability:(__unused NSString *)name available:(__unused BOOL)value {}
- (void)passwordPrompt:(__unused UIViewController *)presenter token:(NSDictionary *)token setup:(__unused BOOL)setup completion:(void (^)(BOOL))completion {
    self.passwordPrompts++;self.observedReason=self.passwordFallbackReason;self.passwordFallbackReason=nil;
    BOOL accepted=self.passwordAccepted && [self.runtime authenticatePassword:@"123456" token:token error:NULL];
    self.authenticating=NO;if(completion)completion(accepted);
}
#import "ManagerBiometricUnderTest.h"
@end
static void Drain(void) {[NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]];}
static NSError *FixtureLAError(NSInteger code) {return [NSError errorWithDomain:LAErrorDomain code:code userInfo:nil];}
static void Reply(LAContext *context,BOOL success,NSError *error) {
    void (^reply)(BOOL,NSError *)=context.reply;context.reply=nil;Check(reply!=nil,"fixture has a real production evaluate reply");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{reply(success,error);});Drain();
}
int main(void) {@autoreleasepool {
    domains=[NSMutableDictionary new];domain=[@"enrollment-v1" dataUsingEncoding:NSUTF8StringEncoding];
    __block NSDictionary *credential;
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(__unused NSString *account,__unused NSError **error){return [NSMutableData dataWithLength:64];}];
    runtimeUnderTest=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{return 10000;} elapsedClock:^NSTimeInterval{return 1000;} credentialReader:^NSDictionary *(__unused NSString *account,__unused NSError **error){return credential;} credentialWriter:^BOOL(__unused NSString *account,NSDictionary *value,__unused NSError **error){credential=value;return YES;}];
    [runtimeUnderTest synchronizeAccount:@"biometric-fixture" epoch:epoch suspended:NO];
    Check([runtimeUnderTest setPassword:@"123456" token:runtimeUnderTest.authenticationToken error:NULL],"fixture creates real password credential");
    NSMutableDictionary *profile=[runtimeUnderTest.currentProfile mutableCopy],*options=[profile[@"options"] mutableCopy];
    profile[@"enabled"]=@YES;options[@"biometric"]=@YES;profile[@"options"]=options;
    Check([runtimeUnderTest updateProfile:profile error:NULL],"fixture persists biometric option through real account store");
    [runtimeUnderTest lock];
    BiometricManager *manager=[BiometricManager new];manager.runtime=runtimeUnderTest;
    __weak BiometricManager *weakManager=manager;
    runtimeUnderTest.didChange=^{[weakManager schedulePolicyRefresh];};
    UIViewController *presenter=[UIViewController new];presenter.view=[UIView new];presenter.view.window=[NSObject new];
    __block NSUInteger completions=0;__block BOOL result=NO;
    void (^completion)(BOOL)=^(BOOL value){completions++;result=value;};
    [manager authenticateFrom:presenter completion:completion];
    LAContext *first=manager.authenticationContext;
    Check(canCalls==1 && evaluateCalls==1 && !runtimeUnderTest.isAuthorized && completions==0,"enabled+available must evaluate, never grant before reply");
    Check(first.touchIDAuthenticationAllowableReuseDuration==0,"challenge explicitly forbids biometric reuse");
    [manager authenticateFrom:presenter completion:nil];Check(evaluateCalls==1,"duplicate entry cannot create competing challenges");
    Reply(first,YES,nil);
    Check(completions==1 && result && runtimeUnderTest.isAuthorized && first.invalidated,"successful system reply authorizes exactly once and invalidates context");
    Check([domains[@"biometric-fixture"] isEqual:domain],"first successful verification records account/device enrollment baseline");
    [manager authenticateFrom:presenter completion:nil];Check(evaluateCalls==1,"already authorized session does not reprompt");
    [runtimeUnderTest lock];[manager authenticateFrom:presenter completion:completion];
    LAContext *second=manager.authenticationContext;
    Check(second!=first && evaluateCalls==2,"next locked challenge creates a fresh LAContext");
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;[manager resign:nil];
    Check(!second.invalidated && manager.authenticationContext==second && !runtimeUnderTest.isAuthorized && manager.covers>0,"system inactive interval covers UI without cancelling locked challenge");
    Reply(second,YES,nil);
    Check(completions==1 && !runtimeUnderTest.isAuthorized && manager.pendingBiometricReply!=nil,"successful reply while inactive cannot reveal and waits for foreground");
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;[manager active:nil];
    Check(completions==2 && result && runtimeUnderTest.isAuthorized && !manager.pendingBiometricReply && manager.covers==0,"foreground drains pending reply once after fresh account validation");
    [runtimeUnderTest lock];[manager authenticateFrom:presenter completion:completion];LAContext *background=manager.authenticationContext;
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;[manager resign:nil];
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];
    Check(background.invalidated && completions==3 && !result && !runtimeUnderTest.authenticationToken,"real background cancels challenge and token immediately");
    Reply(background,YES,nil);
    Check(completions==3 && !runtimeUnderTest.isAuthorized,"late background success cannot unlock or complete twice");
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;[manager active:nil];
    [manager authenticateFrom:presenter completion:completion];LAContext *pending=manager.authenticationContext;
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;[manager resign:nil];Reply(pending,YES,nil);
    [manager suspend:nil];Check(!manager.pendingBiometricReply && completions==4 && !result,"background also cancels an already queued successful reply");
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;[manager active:nil];Check(!runtimeUnderTest.isAuthorized,"returning after cancellation does not replay stale success");
    [manager authenticateFrom:presenter completion:completion];LAContext *lockscreen=manager.authenticationContext;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationProtectedDataWillBecomeUnavailable object:nil];Reply(lockscreen,YES,nil);Check(completions==5 && !result && !runtimeUnderTest.isAuthorized,"protected data unavailable path rejects late success");[manager active:nil];
    [manager authenticateFrom:presenter completion:completion];LAContext *oldAccount=manager.authenticationContext;
    epoch++;[NSNotificationCenter.defaultCenter postNotificationName:@"CSBackupAccountChanged" object:nil];Reply(oldAccount,YES,nil);
    Check(completions==6 && !result && !runtimeUnderTest.isAuthorized,"account epoch transition cancels old challenge");
    Check([runtimeUnderTest.currentProfile[@"options"][@"biometric"] boolValue],"biometric option survives epoch reload from encrypted account storage");
    NSUInteger beforeCan=canCalls,beforeEvaluate=evaluateCalls,beforePrompts=manager.passwordPrompts;
    available=NO;
    for(NSNumber *code in @[@(LAErrorBiometryNotEnrolled),@(LAErrorBiometryNotAvailable),@(LAErrorPasscodeNotSet),@(LAErrorBiometryLockout)]) {
        availabilityError=FixtureLAError(code.integerValue);[manager authenticateFrom:presenter completion:completion];
        Check(!result && !runtimeUnderTest.isAuthorized && manager.authenticationContext==nil && manager.observedReason.length,"unavailable biometrics explains password fallback without granting");
    }
    Check(canCalls==beforeCan+4 && evaluateCalls==beforeEvaluate && manager.passwordPrompts==beforePrompts+4,"unavailable policies always fall back to password, never evaluate or bypass");
    available=YES;
    for(NSNumber *code in @[@(LAErrorUserCancel),@(LAErrorAuthenticationFailed),@(LAErrorUserFallback)]) {
        [manager authenticateFrom:presenter completion:completion];Reply(manager.authenticationContext,NO,FixtureLAError(code.integerValue));
        Check(!result && !runtimeUnderTest.isAuthorized && manager.observedReason.length,"cancel/failure/fallback requires independent password");
    }
    domain=[@"enrollment-v2" dataUsingEncoding:NSUTF8StringEncoding];
    [manager authenticateFrom:presenter completion:completion];Reply(manager.authenticationContext,YES,nil);
    Check(!result && !runtimeUnderTest.isAuthorized && [manager.observedReason containsString:@"已变更"],"changed enrollment cannot unlock without friend password");
    Check(![domains[@"biometric-fixture"] isEqual:domain],"failed password cannot bless changed enrollment");
    manager.passwordAccepted=YES;[manager authenticateFrom:presenter completion:completion];Reply(manager.authenticationContext,YES,nil);
    Check(result && runtimeUnderTest.isAuthorized && [domains[@"biometric-fixture"] isEqual:domain],"correct independent password permits and records changed enrollment");
    manager.passwordAccepted=NO;[runtimeUnderTest lock];keychainFailure=YES;
    [manager authenticateFrom:presenter completion:completion];Reply(manager.authenticationContext,YES,nil);
    Check(!result && !runtimeUnderTest.isAuthorized && [manager.observedReason containsString:@"安全记录"],"unreadable enrollment record fails closed to password");keychainFailure=NO;
    domain=nil;[manager authenticateFrom:presenter completion:completion];Reply(manager.authenticationContext,YES,nil);
    Check(!result && !runtimeUnderTest.isAuthorized,"missing domain state fails closed to password");domain=domains[@"biometric-fixture"];
    // Exercise the alternate ordering: app becomes active before LA reply arrives.
    [manager authenticateFrom:presenter completion:completion];LAContext *late=manager.authenticationContext;
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;[manager resign:nil];
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;[manager active:nil];Reply(late,YES,nil);
    Check(result && runtimeUnderTest.isAuthorized,"foreground-before-reply ordering still authorizes");
    [runtimeUnderTest lock];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{[manager authenticateFrom:presenter completion:completion];});Drain();
    Check(manager.authenticationContext!=nil,"background caller is dispatched to main before can/evaluate");
    [manager lockAndReturnToSafePage];Check(!runtimeUnderTest.isAuthorized && !manager.authenticationContext,"manual relock cancels biometric challenge");
    [manager authenticateFrom:presenter completion:nil];LAContext *cancelled=manager.authenticationContext;
    [manager lockAndReturnToSafePage];[manager authenticateFrom:presenter completion:completion];LAContext *current=manager.authenticationContext;
    Reply(cancelled,YES,nil);Check(manager.authenticationContext==current && !runtimeUnderTest.isAuthorized,"old callback cannot finish or cancel newer challenge");
    Reply(current,YES,nil);Check(result && runtimeUnderTest.isAuthorized,"new challenge still succeeds after stale reply");
    profile=[runtimeUnderTest.currentProfile mutableCopy];options=[profile[@"options"] mutableCopy];
    options[@"biometric"]=@NO;profile[@"options"]=options;Check([runtimeUnderTest updateProfile:profile error:NULL],"disable biometric through actual account store");
    [runtimeUnderTest lock];beforeEvaluate=evaluateCalls;beforeCan=canCalls;
    [manager authenticateFrom:presenter completion:completion];
    Check(evaluateCalls==beforeEvaluate && canCalls==beforeCan && !result && !runtimeUnderTest.isAuthorized,"disabled option uses password without touching LAContext");
    Check([runtimeUnderTest authenticatePassword:@"123456" token:runtimeUnderTest.authenticationToken error:NULL],"password path still authorizes independently");
    options[@"biometric"]=@YES;profile[@"options"]=options;Check([runtimeUnderTest updateProfile:profile error:NULL],"restore biometric option for cooldown check");[runtimeUnderTest lock];
    for(NSUInteger n=0;n<5;n++)[runtimeUnderTest authenticatePassword:@"wrongpass" token:runtimeUnderTest.authenticationToken error:NULL];
    [manager authenticateFrom:presenter completion:completion];Reply(manager.authenticationContext,YES,nil);
    Check(!result && !runtimeUnderTest.isAuthorized && [manager.observedReason containsString:@"冷却"],"successful system authentication cannot bypass password cooldown");
    [NSNotificationCenter.defaultCenter removeObserver:manager];
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    printf("CloseFriendBiometricTests: %lu checks passed\n",(unsigned long)checks);
}return 0;}
