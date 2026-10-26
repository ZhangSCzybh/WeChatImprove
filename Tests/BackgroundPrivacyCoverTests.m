#import "CSBackgroundBlurManager.h"
#import "CSCloseFriendPolicy.h"

// Combined window test: real blur manager and verbatim CloseFriend lifecycle/cover
// methods. Runtime authorization and navigation are boundary fixtures only.
static NSUInteger checks,failures;
static void Check(BOOL ok,const char *label) {checks++;if(!ok){failures++;fprintf(stderr,"FAIL: %s\n",label);}}
static NSString *const CSCloseFriendPolicyDidChangeNotification=@"fixture-privacy-policy-change";
static CSCloseFriendSnapshot *snapshot;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return snapshot;}
static CSBackgroundBlurManager *blurUnderTest;
@interface PrivacyBlurAccess : NSObject
+ (CSBackgroundBlurManager *)sharedManager;
@end
@implementation PrivacyBlurAccess
+ (CSBackgroundBlurManager *)sharedManager {return blurUnderTest;}
@end
@interface PrivacyRuntime : NSObject
@property(nonatomic) BOOL isAuthorized,active;
@property(nonatomic) NSUInteger generation;
@property(nonatomic,copy) void (^didChange)(void);
- (void)lock;
@end
@implementation PrivacyRuntime
- (void)lock {self.isAuthorized=NO;self.generation++;if(self.didChange)self.didChange();}
- (void)setActive:(BOOL)value {_active=value;if(!value)[self lock];}
@end
@interface PrivacyMotion : NSObject
- (void)stop;
@end
@implementation PrivacyMotion
- (void)stop {}
@end
@interface PrivacyContext : NSObject
@property(nonatomic) BOOL invalidated;
- (void)invalidate;
@end
@implementation PrivacyContext
- (void)invalidate {self.invalidated=YES;}
@end
#define LAContext PrivacyContext
@interface PrivacyManager : NSObject
@property(nonatomic,strong) PrivacyRuntime *runtime;
@property(nonatomic,strong) NSMutableArray<UIView *> *covers;
@property(nonatomic,strong) PrivacyMotion *shakeMonitor;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) PrivacyContext *authenticationContext;
@property(nonatomic,copy) void (^biometricCompletion)(BOOL);
@property(nonatomic,copy) void (^pendingBiometricReply)(void);
@property(nonatomic,copy) NSString *passwordFallbackReason;
@property(nonatomic) BOOL started,lastRevealed,authenticating,backgroundCoverRequired,policyRefreshScheduled;
@property(nonatomic) NSUInteger safeRoutes;
- (void)refreshAccount;
- (void)returnToChatListIfNeeded;
@end
@implementation PrivacyManager
- (void)refreshAccount {}
- (void)refreshShakeMonitoring {}
- (void)refreshRecoveryGesture {}
- (void)startExpiryTimer {}
- (void)returnToChatListIfNeeded {self.safeRoutes++;}
#define CSBackgroundBlurManager PrivacyBlurAccess
#import "BackgroundPrivacyUnderTest.h"
#undef CSBackgroundBlurManager
@end
static void SetPolicy(BOOL enabled) {
    snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"privacy-fixture" profile:@{@"enabled":@(enabled),@"friends":@[@"private"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:NO revision:1 blocked:NO];
}
static void Post(NSString *name,id object) {[NSNotificationCenter.defaultCenter postNotificationName:name object:object];}
@interface PrivacyWindow : UIWindow
@property(nonatomic) NSUInteger layouts;
@end
@implementation PrivacyWindow
- (void)layoutIfNeeded {self.layouts++;[super layoutIfNeeded];}
@end
int main(void) {@autoreleasepool {
    NSString *suite=[@"com.wechatimprove.test.backgroundprivacy." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    @try {
        UIApplication *app=UIApplication.sharedApplication;app.applicationState=UIApplicationStateActive;
        UIWindowScene *scene=[UIWindowScene new];scene.activationState=UISceneActivationStateForegroundActive;
        PrivacyWindow *window=[PrivacyWindow new];window.frame=CGRectMake(0,0,390,844);window.windowScene=scene;window.rootViewController=[UIViewController new];
        UIView *content=[UIView new];[window addSubview:content];scene.windows=@[window];app.connectedScenes=[NSSet setWithObject:scene];app.windows=@[];
        CSBackgroundBlurManager *blur=[[CSBackgroundBlurManager alloc] initWithDefaults:defaults];blurUnderTest=blur;
        [defaults setBool:NO forKey:CSBackgroundBlurEnabledKey];[blur start];
        PrivacyManager *privacy=[PrivacyManager new];privacy.runtime=[PrivacyRuntime new];privacy.runtime.active=YES;privacy.covers=[NSMutableArray new];
        __weak PrivacyManager *weakPrivacy=privacy;
        privacy.runtime.didChange=^{[weakPrivacy schedulePolicyRefresh];};
        __block NSUInteger publishedGeneration=0,publications=0;
        __block NSUInteger coversWhenPublished=0;
        __block BOOL publicationWithoutAnimation=NO;
        id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note){
            publishedGeneration=privacy.runtime.generation;publications++;
            coversWhenPublished=privacy.covers.count;publicationWithoutAnimation=CSTestAnimationSuppressionDepth>0;
        }];
        SetPolicy(YES);privacy.runtime.isAuthorized=YES;privacy.lastRevealed=YES;
        [privacy start];[privacy start];
        app.applicationState=UIApplicationStateInactive;
        Post(UIApplicationWillResignActiveNotification,app);
        Check(publishedGeneration==privacy.runtime.generation && publications>0,"switcher callback must publish locked policy before returning, without a runloop gap");
        Check(publicationWithoutAnimation && window.layouts>0,"switcher policy and layout settle synchronously inside animation suppression");
        Check(coversWhenPublished==0,"blur OFF switcher publication does not depend on any full-window cover");
        NSUInteger settledPublications=publications;
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]];
        Check(publications==settledPublications,"queued policy task must not republish after synchronous switcher settlement");
        Check(!privacy.runtime.isAuthorized,"switcher still revokes friend authorization when blur is off");
        Check(window.subviews.count==1 && window.subviews.firstObject==content && privacy.covers.count==0,"blur OFF + switcher must not leave any full-window blur or privacy cover");
        app.applicationState=UIApplicationStateBackground;
        Post(UIApplicationDidEnterBackgroundNotification,app);
        Check(publishedGeneration==privacy.runtime.generation,"background setActive invalidation must be included in the same synchronous policy publication");
        Check(window.subviews.count==1 && privacy.covers.count==0,"blur OFF + actual background must not recreate a cover");
        Check(!privacy.runtime.active && privacy.safeRoutes>0,"background still locks runtime and routes sensitive pages");
        for(NSString *name in @[UISceneWillDeactivateNotification,UISceneDidEnterBackgroundNotification,UIWindowDidBecomeVisibleNotification]) {
            Post(name,[name isEqual:UIWindowDidBecomeVisibleNotification] ? window : scene);
            Check(window.subviews.count==1 && privacy.covers.count==0,"scene/window events cannot recreate covers while disabled");
        }
        app.applicationState=UIApplicationStateActive;Post(UISceneDidActivateNotification,scene);Post(UIApplicationDidBecomeActiveNotification,app);
        Check(window.subviews.count==1 && !privacy.runtime.isAuthorized,"foreground is clear but does not restore revoked authority");

        // Enabled path still covers. OFF must immediately remove both owners' views,
        // including notification variants used by import and reset.
        for(NSString *settingsEvent in @[CSBackgroundBlurSettingsChangedNotification,@"com.wechat.tweak.settings_changed",@"com.wechat.tweak.local_settings_changed"]) {
            NSUserDefaults *writer=[[NSUserDefaults alloc] initWithSuiteName:suite];
            [writer setBool:YES forKey:CSBackgroundBlurEnabledKey];Post(settingsEvent,nil);
            app.applicationState=UIApplicationStateInactive;Post(UIApplicationWillResignActiveNotification,app);Post(UISceneWillDeactivateNotification,scene);
            Check(window.subviews.count>1 && privacy.covers.count>0,"enabled background protection still attaches its views");
            NSArray *oldCovers=privacy.covers.copy;
            [writer setBool:NO forKey:CSBackgroundBlurEnabledKey];Post(settingsEvent,nil);
            Check(window.subviews.count==1 && privacy.covers.count==0,"switch/reset/import OFF removes both blur and existing privacy covers immediately");
            for(UIView *old in oldCovers)Check(old.superview==nil,"old privacy cover is detached, not just hidden");
            app.applicationState=UIApplicationStateBackground;Post(UIApplicationDidEnterBackgroundNotification,app);Post(UISceneDidEnterBackgroundNotification,scene);
            Check(window.subviews.count==1 && privacy.covers.count==0,"later lifecycle events cannot reattach disabled views");
            app.applicationState=UIApplicationStateActive;Post(UISceneDidActivateNotification,scene);Post(UIApplicationDidBecomeActiveNotification,app);
        }
        // Configuration changes posted off-main still clean on the main queue.
        [defaults setBool:YES forKey:CSBackgroundBlurEnabledKey];Post(CSBackgroundBlurSettingsChangedNotification,nil);
        app.applicationState=UIApplicationStateInactive;Post(UIApplicationWillResignActiveNotification,app);Post(UISceneWillDeactivateNotification,scene);
        Check(privacy.covers.count>0,"cross-thread fixture starts with a real privacy cover");
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
            [defaults setBool:NO forKey:CSBackgroundBlurEnabledKey];Post(CSBackgroundBlurSettingsChangedNotification,nil);
        });
        NSDate *limit=[NSDate dateWithTimeIntervalSinceNow:2];
        while(window.subviews.count>1 && limit.timeIntervalSinceNow>0)[NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.005]];
        Check(window.subviews.count==1 && privacy.covers.count==0,"off-main OFF notification removes both owners' covers");
        app.applicationState=UIApplicationStateActive;Post(UISceneDidActivateNotification,scene);Post(UIApplicationDidBecomeActiveNotification,app);

        // This switch does not skip relocking, suppress foreground transition safety,
        // or weaken the 2.0-6 biometric token rules.
        snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"privacy-fixture" profile:@{@"enabled":@YES,@"friends":@[@"private"],@"groups":@[],@"options":@{@"shakeToLock":@YES}} revealed:YES revision:2 blocked:NO];
        [privacy handleShake];
        Check(publishedGeneration==privacy.runtime.generation && !privacy.policyRefreshScheduled,"shake lock publishes the final policy in its current call");
        Check(privacy.covers.count==0 && window.subviews.count==1,"foreground shake lock leaves no visible cover awaiting a later runloop");
        Check(publicationWithoutAnimation && coversWhenPublished>0,"shake lock covers before publication and removes cover only after synchronous update");
        SetPolicy(YES);
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]];
        Check(window.subviews.count==1 && privacy.covers.count==0,"foreground transient cover is removed after refresh turn");
        PrivacyContext *context=[PrivacyContext new];privacy.authenticationContext=context;privacy.authenticating=YES;
        __block NSUInteger completions=0;privacy.biometricCompletion=^(BOOL ok){Check(!ok,"background cancels pending biometric with failure");completions++;};
        NSUInteger generation=privacy.runtime.generation;
        app.applicationState=UIApplicationStateInactive;Post(UIApplicationWillResignActiveNotification,app);
        Check(window.subviews.count==1 && privacy.covers.count==0,"system authentication inactive interval obeys disabled cover setting");
        Check(privacy.authenticationContext==context && !context.invalidated && privacy.runtime.generation==generation,"temporary inactive interval still preserves locked biometric challenge");
        app.applicationState=UIApplicationStateBackground;Post(UIApplicationDidEnterBackgroundNotification,app);
        Check(window.subviews.count==1 && context.invalidated && !privacy.authenticationContext && completions==1,"real background cancels challenge without adding a cover");
        Post(UIApplicationProtectedDataWillBecomeUnavailable,app);
        Check(window.subviews.count==1 && !privacy.runtime.active && completions==1,"lock-screen notification cannot restore covers or complete twice");
        app.applicationState=UIApplicationStateActive;Post(UISceneDidActivateNotification,scene);Post(UIApplicationDidBecomeActiveNotification,app);
        SetPolicy(NO);Post(UIApplicationWillResignActiveNotification,app);
        Check(window.subviews.count==1,"both protection features disabled produce no overlay");
        SetPolicy(YES);privacy.backgroundCoverRequired=NO;
        app.applicationState=UIApplicationStateBackground;
        [privacy accountChanged:nil];
        Check(window.subviews.count==1 && privacy.covers.count==0,"late-start manager without a resign notification still respects OFF during account relock");
        // A cover from an earlier foreground transition must be removable even if
        // the app changed state before the manager observed its lifecycle event.
        app.applicationState=UIApplicationStateActive;[privacy cover];Check(privacy.covers.count>0,"late-notification fixture retains foreground transient cover");
        app.applicationState=UIApplicationStateInactive;Post(CSBackgroundBlurSettingsChangedNotification,nil);
        Check(window.subviews.count==1 && privacy.covers.count==0,"OFF cleanup checks actual app state when lifecycle flags lag");
        [NSNotificationCenter.defaultCenter removeObserver:privacy];
        [NSNotificationCenter.defaultCenter removeObserver:observer];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]];
        blurUnderTest=nil;
        printf("BackgroundPrivacyCoverTests: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    } @finally {[defaults removePersistentDomainForName:suite];}
}return failures ? 1 : 0;}
