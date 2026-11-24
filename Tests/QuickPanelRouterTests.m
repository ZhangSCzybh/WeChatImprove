#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSCloseFriendSignatures.h"

// This fixture compiles the unchanged production resolver/factory helpers. It
// verifies ownership and native ABI boundaries without launching WeChat/UIKit.
@class UINavigationController;
@class UIViewController;
static char CSQuickRouteRequestKey;
static void (^navigationPushMutation)(UINavigationController *, UIViewController *);
enum { UIModalPresentationFormSheet=2, UITableViewStyleInsetGrouped=2 };
typedef NS_ENUM(NSInteger, UISceneActivationState) {
    UISceneActivationStateUnattached=-1,
    UISceneActivationStateForegroundActive,
    UISceneActivationStateForegroundInactive
};
static NSString * const UIApplicationDidEnterBackgroundNotification=@"UIApplicationDidEnterBackgroundNotification";
static NSString * const UISceneDidEnterBackgroundNotification=@"UISceneDidEnterBackgroundNotification";
static NSString * const UISceneDidDisconnectNotification=@"UISceneDidDisconnectNotification";
typedef NS_ENUM(NSInteger, UIApplicationState) { UIApplicationStateActive, UIApplicationStateInactive, UIApplicationStateBackground };
@interface UIApplication : NSObject
@property(nonatomic) UIApplicationState applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; if (!app) app=[self new]; return app; }
@end
@interface UIWindowScene : NSObject
@property(nonatomic) UISceneActivationState activationState;
@end
@implementation UIWindowScene @end
@interface UIWindow : NSObject
@property(nonatomic,strong) UIWindowScene *windowScene;
@property(nonatomic,strong) UIViewController *rootViewController;
@end
@implementation UIWindow @end
@interface UIView : NSObject
@property(nonatomic,weak) UIWindow *window;
@end
@implementation UIView @end
@protocol UIViewControllerTransitionCoordinatorContext <NSObject> @end
@protocol UIViewControllerTransitionCoordinator <NSObject>
- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))animation
    completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))completion;
@end
@interface QuickTransition : NSObject <UIViewControllerTransitionCoordinator>
@property(nonatomic,copy) void (^completion)(id<UIViewControllerTransitionCoordinatorContext>);
- (void)complete;
@end
@implementation QuickTransition
- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))completion {
    self.completion=completion; return YES;
}
- (void)complete { if (self.completion) self.completion(nil); self.completion=nil; }
@end
@interface UIViewController : NSObject
@property(nonatomic,weak) UINavigationController *navigationController;
@property(nonatomic,weak) UIViewController *parentViewController;
@property(nonatomic,weak) UIViewController *presentingViewController;
@property(nonatomic,strong) UIViewController *presentedViewController;
@property(nonatomic,strong) UIView *view;
@property(nonatomic,readonly) UIView *viewIfLoaded;
@property(nonatomic,copy) NSArray *childViewControllers;
@property(nonatomic) BOOL isViewLoaded;
@property(nonatomic) BOOL isBeingDismissed;
@property(nonatomic) BOOL isMovingFromParentViewController;
@property(nonatomic) BOOL hidesBottomBarWhenPushed;
@property(nonatomic) NSInteger modalPresentationStyle;
@property(nonatomic) NSUInteger presentationCalls;
@property(nonatomic) BOOL lastPresentationAnimated;
@property(nonatomic,strong) id<UIViewControllerTransitionCoordinator> transitionCoordinator;
- (void)loadViewIfNeeded;
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;
@end
@implementation UIViewController
- (instancetype)init {
    if ((self=[super init])) { _view=[UIView new]; _isViewLoaded=YES; _childViewControllers=@[]; }
    return self;
}
- (UIView *)viewIfLoaded { return self.isViewLoaded ? self.view : nil; }
- (void)loadViewIfNeeded { self.isViewLoaded=YES; }
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion {
    self.presentationCalls++; self.lastPresentationAnimated=animated;
    self.presentedViewController=controller; controller.presentingViewController=self;
    controller.view.window=self.view.window;
    for (UIViewController *child in controller.childViewControllers) child.view.window=self.view.window;
    if (completion) completion();
}
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) UIViewController *topViewController;
@property(nonatomic,copy) NSArray *viewControllers;
@property(nonatomic) NSUInteger pushCalls;
@property(nonatomic) BOOL lastPushAnimated;
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;
- (instancetype)initWithRootViewController:(UIViewController *)controller;
@end
@implementation UINavigationController
- (instancetype)initWithRootViewController:(UIViewController *)controller {
    if ((self=[super init])) {
        controller.navigationController=self; controller.parentViewController=self;
        self.topViewController=controller; self.viewControllers=@[controller]; self.childViewControllers=@[controller];
    }
    return self;
}
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    self.pushCalls++; self.lastPushAnimated=animated;
    controller.navigationController=self; controller.parentViewController=self;
    controller.view.window=self.topViewController.view.window;
    self.topViewController=controller;
    self.viewControllers=[(self.viewControllers ?: @[]) arrayByAddingObject:controller];
    if (navigationPushMutation) navigationPushMutation(self,controller);
}
@end
static void (^tabSelectionMutation)(void);
@interface UITabBarController : UIViewController
@property(nonatomic,strong) UIViewController *selectedViewController;
@property(nonatomic,copy) NSArray *viewControllers;
@property(nonatomic) NSUInteger selectedIndex;
@end
@implementation UITabBarController
- (void)setSelectedViewController:(UIViewController *)selected {
    if ([_selectedViewController isKindOfClass:UINavigationController.class]) {
        for (UIViewController *page in [(UINavigationController *)_selectedViewController viewControllers]) page.view.window=nil;
    }
    _selectedViewController=selected;
    if ([selected isKindOfClass:UINavigationController.class]) {
        for (UIViewController *page in [(UINavigationController *)selected viewControllers]) page.view.window=self.view.window;
    }
    if (tabSelectionMutation) tabSelectionMutation();
}
- (NSUInteger)selectedIndex { return [self.viewControllers indexOfObjectIdenticalTo:self.selectedViewController]; }
- (void)setSelectedIndex:(NSUInteger)index { if (index<self.viewControllers.count) self.selectedViewController=self.viewControllers[index]; }
@end
@interface BaseMsgContentLogicController : NSObject
@property(nonatomic,strong) id contact;
@property(nonatomic,weak) UIViewController *page;
- (id)GetContact;
- (id)getViewController;
@end
@implementation BaseMsgContentLogicController
- (id)GetContact { return self.contact; }
- (id)getViewController { return self.page; }
@end
@interface BaseMsgContentViewController : UIViewController
@property(nonatomic,strong) id contact;
@property(nonatomic,strong) id m_delegate;
@property(nonatomic) BOOL contactThrows;
- (id)GetCContact;
@end
@implementation BaseMsgContentViewController
- (id)GetCContact { if (self.contactThrows) [NSException raise:NSInternalInconsistencyException format:@"native contact getter unavailable"]; return self.contact; }
@end
@interface WCTabBarController : UIViewController
@property(nonatomic,strong) UIViewController *selectedViewController;
@end
@implementation WCTabBarController @end
@interface NewMainFrameViewController : NSObject
@property(nonatomic,weak) UIViewController *curViewController;
@property(nonatomic) NSUInteger createCalls;
@property(nonatomic) NSUInteger receiveCalls;
@property(nonatomic) NSUInteger myMomentsCalls;
@property(nonatomic) NSUInteger searchCalls;
@property(nonatomic) NSUInteger messageCalls;
@property(nonatomic,strong) id lastContact;
@property(nonatomic,strong) id lastMessageWrap;
@property(nonatomic,strong) id wrongContact;
@property(nonatomic) BOOL noOp;
@property(nonatomic) BOOL messageDeferred;
@property(nonatomic) BOOL chatContactThrows;
@property(nonatomic) BOOL logicOnly;
@property(nonatomic) BOOL staleLogic;
@property(nonatomic,copy) void (^messageMutation)(void);
- (void)newMessageByContact:(id)contact msgWrapToAdd:(id)wrap;
- (void)onCreateNewMessage;
- (void)openFace2FaceReceiveMoney;
- (void)showMyWCView;
- (void)onSearchButtonTapped;
- (id)wrongABI;
@end
@implementation NewMainFrameViewController
- (void)onCreateNewMessage { self.createCalls++; }
- (void)openFace2FaceReceiveMoney { self.receiveCalls++; }
- (void)showMyWCView { self.myMomentsCalls++; }
- (void)onSearchButtonTapped { self.searchCalls++; }
- (void)newMessageByContact:(id)contact msgWrapToAdd:(id)wrap {
    self.messageCalls++; self.lastContact=contact; self.lastMessageWrap=wrap;
    if (self.messageMutation) self.messageMutation();
    if (self.noOp) return;
    void (^push)(void)=^{
        BaseMsgContentViewController *page=[BaseMsgContentViewController new]; page.contactThrows=self.chatContactThrows;
        if (self.logicOnly) {
            BaseMsgContentLogicController *logic=[BaseMsgContentLogicController new];
            logic.contact=self.wrongContact ?: contact; logic.page=self.staleLogic ? self.curViewController : page; page.m_delegate=logic;
        } else page.contact=self.wrongContact ?: contact;
        [self.curViewController.navigationController pushViewController:page animated:YES];
    };
    if (self.messageDeferred) dispatch_async(dispatch_get_main_queue(),push); else push();
}
- (id)wrongABI { return nil; }
@end
// Older WeChat exposes the Me page as a UIKit owner; modern builds use the
// existing NSObject main owner above for the checked fallback.
@interface MoreViewController : UIViewController
@property(nonatomic) NSUInteger myMomentsCalls;
- (void)showMyWCView;
@end
@implementation MoreViewController
- (void)showMyWCView { self.myMomentsCalls++; }
@end
static NSUInteger publicTimelineConstructions;
@interface WCTimeLineViewController : UIViewController @end
@implementation WCTimeLineViewController
- (instancetype)init {
    if ((self=[super init])) publicTimelineConstructions++;
    return self;
}
@end
@interface NativeWallet : UIViewController @end
@implementation NativeWallet @end
@interface InvalidControllerFactory : UIViewController @end
@implementation InvalidControllerFactory
- (instancetype)init { self=[super init]; return self ? (id)[NSObject new] : nil; }
@end
typedef NS_ENUM(NSInteger, LAPolicy) { LAPolicyDeviceOwnerAuthenticationWithBiometrics=1 };
typedef NS_ENUM(NSInteger, LAError) {
    LAErrorAuthenticationFailed=-1, LAErrorUserCancel=-2, LAErrorSystemCancel=-4, LAErrorAppCancel=-9
};
static BOOL quickBiometricsAvailable=YES;
static NSUInteger quickBiometricEvaluations;
static NSUInteger quickBiometricConstructions;
static void (^quickBiometricPreflightMutation)(void);
@class LAContext;
static LAContext *quickLastAuthentication;
@interface LAContext : NSObject
@property(nonatomic) NSUInteger invalidations;
@property(nonatomic,copy) void (^invalidation)(void);
@property(nonatomic) LAPolicy preflightPolicy;
@property(nonatomic) LAPolicy evaluationPolicy;
@property(nonatomic,copy) NSString *reason;
@property(nonatomic,copy) void (^reply)(BOOL,NSError *);
- (BOOL)canEvaluatePolicy:(LAPolicy)policy error:(NSError **)error;
- (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)reason reply:(void (^)(BOOL,NSError *))reply;
- (void)completeWithSuccess:(BOOL)success error:(NSError *)error;
- (void)invalidate;
@end
@implementation LAContext
- (instancetype)init {
    if ((self=[super init])) { quickBiometricConstructions++; quickLastAuthentication=self; }
    return self;
}
- (BOOL)canEvaluatePolicy:(LAPolicy)policy error:(NSError **)error {
    self.preflightPolicy=policy;
    if (quickBiometricPreflightMutation) quickBiometricPreflightMutation();
    if (error) *error=quickBiometricsAvailable ? nil : [NSError errorWithDomain:@"fixture.biometric" code:-6 userInfo:nil];
    return quickBiometricsAvailable;
}
- (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)reason reply:(void (^)(BOOL,NSError *))reply {
    quickBiometricEvaluations++; self.evaluationPolicy=policy; self.reason=reason; self.reply=reply;
}
- (void)completeWithSuccess:(BOOL)success error:(NSError *)error {
    void (^reply)(BOOL,NSError *)=self.reply; self.reply=nil;
    if (reply) reply(success,error);
}
- (void)invalidate {
    self.invalidations++;
    if (self.invalidation) self.invalidation();
}
@end

// The extracted production guard reads this in-memory defaults fixture. No
// real suite, preference file or device authentication API is touched.
static BOOL quickFavoritesProtected;
static NSMutableArray<NSString *> *quickFavoriteSuites;
static NSMutableArray<NSString *> *quickFavoriteKeys;
@interface QuickFavoriteDefaults : NSObject
@property(nonatomic,copy) NSString *suite;
- (instancetype)initWithSuiteName:(NSString *)suite;
- (BOOL)boolForKey:(NSString *)key;
@end
@implementation QuickFavoriteDefaults
- (instancetype)initWithSuiteName:(NSString *)suite {
    if ((self=[super init])) { _suite=suite.copy; [quickFavoriteSuites addObject:suite]; }
    return self;
}
- (BOOL)boolForKey:(NSString *)key { [quickFavoriteKeys addObject:key]; return quickFavoritesProtected; }
@end

static NSUInteger quickFavoritesConstructions;
@interface MyFavoritesViewController : UIViewController @end
@implementation MyFavoritesViewController
- (instancetype)init {
    if ((self=[super init])) quickFavoritesConstructions++;
    return self;
}
@end

static BOOL quickSettingInitUnavailable;
static id quickSettingInitReplacement;
static void (^quickSettingInitMutation)(void);
static void (^quickSettingShowMutation)(void);
static void (^quickSettingGotoMutation)(void);
static NSUInteger quickSettingInitCalls;
static NSUInteger quickSettingShowCalls;
static NSUInteger quickSettingGotoCalls;
static NSUInteger quickSettingForbiddenCalls;
static UIViewController *quickSettingLastReceiver;
static UIViewController *quickSettingRequestSource;
static id quickSettingLastLogic;
static BOOL quickSettingNativeNoOp;
static BOOL quickSettingTargetDeferred;
static BOOL quickSettingNeedsTip;
static BOOL quickSettingTipDeferred;
static UIWindow *quickSettingTipWindow;
@class NewSettingViewController;
@class MMTipsViewController;
static Class quickSettingTipClass;
static void (^quickSettingTipMutation)(MMTipsViewController *);
static BOOL quickSettingHoldDestination;
static dispatch_block_t quickSettingPendingDestination;
@interface WCAccountLoginUsersViewController : UIViewController @end
@implementation WCAccountLoginUsersViewController @end
@interface MMTipsViewController : UIViewController
@property(nonatomic,weak) NewSettingViewController *m_delegate;
@property(nonatomic) BOOL objShowing;
- (BOOL)isObjShowing;
- (void)confirm;
- (void)cancel;
@end
@interface NewSettingViewController : UIViewController {
@public
    MMTipsViewController *m_introView;
}
@property(nonatomic,strong) id nativeSwitchLogic;
@property(nonatomic) NSUInteger showCalls;
@property(nonatomic) NSUInteger gotoCalls;
- (void)showLoginInfo;
- (void)gotoSwitchAccount;
- (void)logout;
- (void)login;
- (void)selectAccount:(id)account;
@end
@implementation NewSettingViewController
- (instancetype)init {
    quickSettingInitCalls++;
    self=[super init];
    if (quickSettingInitMutation) quickSettingInitMutation();
    return quickSettingInitReplacement ?: (quickSettingInitUnavailable ? nil : self);
}
- (void)showLoginInfo {
    self.showCalls++; quickSettingShowCalls++; quickSettingLastReceiver=self;
    id request=objc_getAssociatedObject(self.view.window,&CSQuickRouteRequestKey);
    quickSettingRequestSource=[request valueForKey:@"source"];
    if (quickSettingShowMutation) quickSettingShowMutation();
    if (quickSettingNativeNoOp || !self.isViewLoaded || !self.view.window || self.transitionCoordinator || self.navigationController.transitionCoordinator) return;
    if (quickSettingNeedsTip) {
        void (^showTip)(void)=^{
            self->m_introView=[(quickSettingTipClass ?: MMTipsViewController.class) new];
            self->m_introView.m_delegate=self; self->m_introView.objShowing=YES;
            self->m_introView.view.window=quickSettingTipWindow ?: self.view.window;
            if (quickSettingTipWindow) quickSettingTipWindow.rootViewController=self->m_introView;
            if (quickSettingTipMutation) quickSettingTipMutation(self->m_introView);
        };
        if (quickSettingTipDeferred) dispatch_async(dispatch_get_main_queue(),showTip); else showTip();
    } else [self gotoSwitchAccount];
}
- (void)gotoSwitchAccount {
    self.gotoCalls++; quickSettingGotoCalls++; quickSettingLastReceiver=self;
    self.nativeSwitchLogic=[NSObject new];
    quickSettingLastLogic=self.nativeSwitchLogic;
    id request=objc_getAssociatedObject(self.view.window,&CSQuickRouteRequestKey);
    quickSettingRequestSource=[request valueForKey:@"source"];
    if (quickSettingGotoMutation) quickSettingGotoMutation();
    if (quickSettingNativeNoOp) return;
    void (^openAccounts)(void)=^{ [self.navigationController pushViewController:[WCAccountLoginUsersViewController new] animated:YES]; };
    if (quickSettingHoldDestination) quickSettingPendingDestination=openAccounts;
    else if (quickSettingTargetDeferred) dispatch_async(dispatch_get_main_queue(),openAccounts);
    else openAccounts();
}
- (void)logout { quickSettingForbiddenCalls++; }
- (void)login { quickSettingForbiddenCalls++; }
- (void)selectAccount:(id)account { quickSettingForbiddenCalls++; }
@end
@implementation MMTipsViewController
- (BOOL)isObjShowing { return self.objShowing; }
- (void)confirm { self.objShowing=NO; [self.m_delegate gotoSwitchAccount]; }
- (void)cancel { self.objShowing=NO; }
@end

static BOOL quickSettingClassOverridden;
static Class quickSettingClassOverride;
static BOOL quickDarkConfigClassOverridden;
static Class quickDarkConfigClassOverride;
static Class QuickNativeClass(NSString *name) {
    if (quickSettingClassOverridden && [name isEqual:@"NewSettingViewController"]) return quickSettingClassOverride;
    if (quickDarkConfigClassOverridden && [name isEqual:@"MMDarkModeConfigUtil"]) return quickDarkConfigClassOverride;
    return NSClassFromString(name);
}

static BOOL cameraQRCodeUnavailable;
static void (^cameraInitMutation)(void);
static BOOL legacyQRCodeInvalidResult;
static id legacyQRCodeContact;
@interface CameraQRCodeListViewController : UIViewController @end
@implementation CameraQRCodeListViewController
- (instancetype)init {
    if (cameraInitMutation) cameraInitMutation();
    return cameraQRCodeUnavailable ? nil : [super init];
}
@end
@interface NewPersonalQRCodeViewController : UIViewController
- (instancetype)initWithContact:(id)contact;
@end
@implementation NewPersonalQRCodeViewController
- (instancetype)initWithContact:(id)contact {
    legacyQRCodeContact=contact;
    self=[super init]; return legacyQRCodeInvalidResult ? (id)[NSObject new] : self;
}
@end
@interface QuickContact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName;
@end
@implementation QuickContact @end
@interface CContact : QuickContact @end
@implementation CContact @end
@interface CContactMgr : NSObject
@property(nonatomic,strong) QuickContact *selfContact;
@property(nonatomic,strong) QuickContact *fileContact;
@property(nonatomic,strong) QuickContact *dbContact;
@property(nonatomic) NSUInteger dbReads;
@property(nonatomic,copy) NSString *requestedName;
- (id)getSelfContact;
- (id)getContactByName:(id)name;
- (id)getContactByNameFromDB:(id)name;
@end
@implementation CContactMgr
- (id)getSelfContact { return self.selfContact; }
- (id)getContactByName:(id)name { self.requestedName=name; return self.fileContact; }
- (id)getContactByNameFromDB:(id)name { self.requestedName=name; self.dbReads++; return self.dbContact; }
@end
@interface MMMsgLogicManager : NSObject
@property(nonatomic) NSUInteger pushes;
@property(nonatomic,strong) id contact;
@property(nonatomic,weak) UINavigationController *navigation;
@property(nonatomic) BOOL animated;
- (void)PushOtherBaseMsgControllerByContact:(id)contact navigationController:(id)navigation animated:(_Bool)animated;
@end
@implementation MMMsgLogicManager
- (void)PushOtherBaseMsgControllerByContact:(id)contact navigationController:(id)navigation animated:(_Bool)animated {
    self.pushes++; self.contact=contact; self.navigation=navigation; self.animated=animated;
}
@end
@interface QuickServiceCenter : NSObject
@property(nonatomic,strong) NSDictionary *services;
@property(nonatomic,copy) void (^serviceRead)(void);
- (id)getService:(Class)cls;
@end
@implementation QuickServiceCenter
- (id)getService:(Class)cls {
    if (self.serviceRead) self.serviceRead();
    return self.services[NSStringFromClass(cls)];
}
@end
@interface QuickObjectServiceCenter : NSObject
@property(nonatomic,strong) NSDictionary *services;
- (id)getService:(id)cls;
@end
@implementation QuickObjectServiceCenter
- (id)getService:(id)cls { return self.services[NSStringFromClass(cls)]; }
@end
@interface MMServiceWrapper : NSProxy
@property(nonatomic,strong) id target;
@property(nonatomic) NSUInteger forwards;
- (instancetype)initWithTarget:(id)target;
@end
@implementation MMServiceWrapper
- (instancetype)initWithTarget:(id)target { _target=target; return self; }
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector { return [self.target methodSignatureForSelector:selector]; }
- (void)forwardInvocation:(NSInvocation *)invocation { self.forwards++; [invocation invokeWithTarget:self.target]; }
@end
static id quickContext;
@interface MMContext : NSObject
+ (id)currentContext;
@property(nonatomic,strong) QuickServiceCenter *serviceCenter;
@end
@implementation MMContext
+ (id)currentContext { return quickContext; }
@end
static BOOL quickEffectiveDarkMode;
static long long quickDarkConfiguration;
static NSUInteger quickDarkDirectChanges;
static void (^quickDarkReadMutation)(void);
@interface MMDarkModeConfigUtil : NSObject
+ (_Bool)isDarkMode;
+ (_Bool)changeDarkModeConfigType:(long long)type;
@end
@implementation MMDarkModeConfigUtil
+ (_Bool)isDarkMode { if (quickDarkReadMutation) quickDarkReadMutation(); return quickEffectiveDarkMode; }
+ (_Bool)changeDarkModeConfigType:(long long)type { quickDarkDirectChanges++; return YES; }
@end
@interface WrongDarkModeConfigUtil : NSObject
+ (id)isDarkMode;
@end
@implementation WrongDarkModeConfigUtil
+ (id)isDarkMode { return @YES; }
@end
@interface DarkModeManager : NSObject
@property(nonatomic) NSUInteger changes;
@property(nonatomic) long long selectedType;
- (void)changeDarkModeConfigType:(long long)type;
@end
@implementation DarkModeManager
- (void)changeDarkModeConfigType:(long long)type {
    self.changes++; self.selectedType=type;
    quickDarkConfiguration=type; quickEffectiveDarkMode=type==1;
}
@end
static id quickAppManager;
@interface CAppViewControllerManager : NSObject
@property(nonatomic,weak) UIWindow *mainWindow;
@property(nonatomic,weak) UIViewController *entrySource;
@property(nonatomic) NSUInteger paymentCalls;
@property(nonatomic) NSUInteger noteCalls;
@property(nonatomic,strong) id topOverride;
@property(nonatomic,copy) void (^topReadMutation)(void);
@property(nonatomic,copy) void (^noteMutation)(void);
@property(nonatomic,strong) id mainFrame;
+ (id)getAppViewControllerManager;
- (id)getNewMainFrameViewController;
- (id)getMainWindow;
- (id)getTopViewController;
- (void)jumpToOfflinePayWithEntryVC:(id)source;
- (void)jumpToWriteNote;
@end
@implementation CAppViewControllerManager
+ (id)getAppViewControllerManager { return quickAppManager; }
- (id)getMainWindow { return self.mainWindow; }
- (id)getNewMainFrameViewController { return self.mainFrame; }
- (id)getTopViewController {
    if (self.topReadMutation) self.topReadMutation();
    return self.topOverride ?: self.mainWindow.rootViewController;
}
- (void)jumpToOfflinePayWithEntryVC:(id)source { self.paymentCalls++; self.entrySource=source; }
- (void)jumpToWriteNote { self.noteCalls++; if (self.noteMutation) self.noteMutation(); }
@end
static BOOL finderInvalidInitializer;
static id finderConstructorReplacement;
static void (^finderInitMutation)(void);
@interface WCFinderOpenTimelineParams : NSObject
@property(nonatomic,weak) UIViewController *fromVC;
@property(nonatomic) _Bool byPush;
@property(nonatomic) NSUInteger nativeScene;
- (instancetype)initFromFindPageClick;
@end
@implementation WCFinderOpenTimelineParams
- (instancetype)initFromFindPageClick {
    if ((self=[super init])) self.nativeScene=987;
    if (finderInitMutation) finderInitMutation();
    return finderConstructorReplacement ?: (finderInvalidInitializer ? (id)[NSObject new] : self);
}
@end
static NSUInteger finderPushes;
static WCFinderOpenTimelineParams *finderParams;
@interface WCFinderRouterHelper : NSObject
+ (void)jumpToFinderTimelineByPushWithParams:(id)params;
@end
@implementation WCFinderRouterHelper
+ (void)jumpToFinderTimelineByPushWithParams:(id)params { finderPushes++; finderParams=params; }
@end
@interface WrongPaymentManager : NSObject
@property(nonatomic,weak) UIWindow *mainWindow;
- (id)getMainWindow;
- (id)jumpToOfflinePayWithEntryVC:(id)source;
@end
@implementation WrongPaymentManager
- (id)getMainWindow { return self.mainWindow; }
- (id)jumpToOfflinePayWithEntryVC:(id)source { return nil; }
@end
@interface WrongMessageManager : NSObject
- (id)PushOtherBaseMsgControllerByContact:(id)contact navigationController:(id)navigation animated:(_Bool)animated;
@end
@implementation WrongMessageManager
- (id)PushOtherBaseMsgControllerByContact:(id)contact navigationController:(id)navigation animated:(_Bool)animated { return nil; }
@end

static NSString *backgroundInitializerUsername;
static void (^backgroundInitMutation)(void);
@interface ChatBackgroundEntranceViewController : UIViewController
@property(nonatomic,copy) NSString *m_username;
@end
@implementation ChatBackgroundEntranceViewController
- (instancetype)init {
    if ((self=[super init])) self.m_username=backgroundInitializerUsername;
    if (backgroundInitMutation) backgroundInitMutation();
    return self;
}
@end
@interface SettingGeneralViewController : NSObject
@property(nonatomic,weak) UIViewController *curViewController;
@property(nonatomic) NSUInteger backgroundCalls;
- (void)showChatBackgroundConfig;
@end
@implementation SettingGeneralViewController
- (void)showChatBackgroundConfig {
    self.backgroundCalls++;
    [self.curViewController.navigationController pushViewController:[ChatBackgroundEntranceViewController new] animated:YES];
}
@end
@interface ChatRoomInfoViewController : NSObject
@property(nonatomic,weak) UIViewController *curViewController;
@property(nonatomic) NSUInteger backgroundCalls;
- (void)showChatBackgroundConfig;
@end
@implementation ChatRoomInfoViewController
- (void)showChatBackgroundConfig { self.backgroundCalls++; }
@end

static NSString *quickAccount=@"first-account";
static NSUInteger quickEpoch=1;
static BOOL quickSuspended;
static NSString *CSGroupCurrentAccountID(void) { return quickAccount; }
static NSUInteger CSBackupAccountEpoch(void) { return quickEpoch; }
static BOOL CSBackupAccountIsSuspended(void) { return quickSuspended; }
static BOOL CSQuickCanNavigate(UIViewController *source) {
    return source && source.isViewLoaded && source.view.window && !source.presentedViewController &&
        !source.isBeingDismissed && !source.isMovingFromParentViewController && !source.transitionCoordinator && !source.navigationController.transitionCoordinator &&
        !quickSuspended && UIApplication.sharedApplication.applicationState==UIApplicationStateActive &&
        (!source.navigationController || source.navigationController.topViewController==source) &&
        (!source.view.window.windowScene || source.view.window.windowScene.activationState==UISceneActivationStateForegroundActive);
}

// Keep the plugin destination and its asynchronous gates narrow while executing
// the production route itself, including its choice of navigation container.
static void (^quickPluginInitMutation)(void);
@interface QuickNativeSettingsHost : UIViewController @end
@implementation QuickNativeSettingsHost
- (instancetype)init { if ((self=[super init]) && quickPluginInitMutation) quickPluginInitMutation(); return self; }
@end
static Class CSNativeSettingsControllerClass(void) { return QuickNativeSettingsHost.class; }
@interface CSQuickPanelSettingsViewController : UIViewController
@property(nonatomic) NSUInteger style;
- (instancetype)initWithStyle:(NSUInteger)style;
@end
@implementation CSQuickPanelSettingsViewController
- (instancetype)initWithStyle:(NSUInteger)style { if ((self=[super init])) self.style=style; return self; }
@end
@interface UIAlertController : UIViewController
@property(nonatomic,copy) NSString *title;
@end
@implementation UIAlertController @end
static BOOL quickPluginHidden;
static void (^quickPrivacyReply)(BOOL);
static void (^quickPrivacyDismissCompletion)(void);
static NSUInteger quickPrivacyDismissals;
static BOOL CSCloseFriendPluginEntryHidden(void) { return quickPluginHidden; }
static void CSCloseFriendAuthenticate(UIViewController *source,void (^completion)(BOOL)) { quickPrivacyReply=completion; }
static void CSSettingsAfterDismissingSheet(UIAlertController *sheet,void (^completion)(void)) {
    quickPrivacyDismissals++; quickPrivacyDismissCompletion=completion;
}
@interface CSAuthorizationManager : NSObject
@property(nonatomic) BOOL isAuthorized;
@property(nonatomic) NSUInteger requests;
@property(nonatomic,copy) void (^completion)(BOOL,NSString *);
+ (instancetype)sharedManager;
- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)source completion:(void (^)(BOOL,NSString *))completion;
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager {
    static CSAuthorizationManager *manager;
    if (!manager) { manager=[self new]; manager.isAuthorized=YES; }
    return manager;
}
- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)source completion:(void (^)(BOOL,NSString *))completion {
    self.requests++; self.completion=completion;
}
@end

static BOOL CSQuickFailure(UIViewController *source, NSString *message);
// Production main-queue turns stay real. Only delayed observation is held in
// memory so lifecycle and timeout boundaries can advance without wall-clock waits.
static NSMutableArray<dispatch_block_t> *quickDelayedBlocks;
static NSUInteger quickDelayedSchedules;
static BOOL quickDelayedUsesMainQueue=YES;
static void QuickDispatchAfter(dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block) {
    quickDelayedSchedules++;
    quickDelayedUsesMainQueue=quickDelayedUsesMainQueue && queue==dispatch_get_main_queue();
    [quickDelayedBlocks addObject:[block copy]];
}
#define NSUserDefaults QuickFavoriteDefaults
#define NSClassFromString QuickNativeClass
#define dispatch_after QuickDispatchAfter
#import "QuickPanelRouterProduction.h"
#undef dispatch_after
#undef NSClassFromString
#undef NSUserDefaults

static NSString *quickFailureMessage;
static __weak UIViewController *quickFailureSource;
static BOOL CSQuickFailure(UIViewController *source, NSString *message) { quickFailureSource=source; quickFailureMessage=message; return NO; }
@interface CSQuickPanelActionRouter : NSObject
+ (BOOL)performActionWithIdentifier:(NSString *)identifier fromViewController:(UIViewController *)source;
@end
#define NSClassFromString QuickNativeClass
#import "QuickPanelRouterPublicProduction.h"
#undef NSClassFromString
#import "QuickPanelPreferenceIDs.h"

static NSUInteger checks;
static void Check(BOOL value, const char *message) {
    checks++;
    if (!value) { fprintf(stderr,"FAIL: %s\n",message); exit(1); }
}
static UIViewController *RouteSource(UIWindow *window) {
    UIViewController *source=[UIViewController new];
    UINavigationController *navigation=[UINavigationController new];
    source.navigationController=navigation; source.parentViewController=navigation;
    source.view.window=window; navigation.view.window=window; navigation.topViewController=source; navigation.viewControllers=@[source];
    window.rootViewController=navigation;
    return source;
}
static QuickContact *Contact(NSString *name) {
    QuickContact *contact=[CContact new]; contact.m_nsUsrName=name; return contact;
}
static void IgnoreObjectSetter(id object, SEL selector, id value) {}
static void DrainMainQueue(void) {
    __block BOOL completed=NO;
    dispatch_async(dispatch_get_main_queue(), ^{ completed=YES; });
    while (!completed) [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
static void RunDelayedTurn(void) {
    NSArray<dispatch_block_t> *ready=quickDelayedBlocks.copy;
    [quickDelayedBlocks removeAllObjects];
    for (dispatch_block_t block in ready) block();
    DrainMainQueue();
}
static void SettleDelayedNavigation(void) {
    DrainMainQueue();
    for (NSUInteger turn=0; quickDelayedBlocks.count && turn<250; turn++) RunDelayedTurn();
    Check(!quickDelayedBlocks.count,"bounded native navigation observation stops scheduling after its completion or cancellation");
}
static UIViewController *FileSource(UIWindow *window, NewMainFrameViewController *main) {
    UIViewController *source=RouteSource(window); main.curViewController=source; return source;
}
static UIViewController *CrossTabSource(UIWindow *window, NewMainFrameViewController *main, UITabBarController **outTab) {
    UIViewController *home=FileSource(window,main);
    UINavigationController *homeNavigation=home.navigationController;
    UIViewController *source=RouteSource(window);
    UITabBarController *tab=[UITabBarController new]; tab.view.window=window;
    tab.viewControllers=@[homeNavigation,source.navigationController];
    homeNavigation.parentViewController=tab; source.navigationController.parentViewController=tab;
    tab.selectedViewController=source.navigationController;
    // Existing hidden tabs are not attached to a window until selected.
    home.view.window=nil; window.rootViewController=tab;
    if (outTab) *outTab=tab;
    return source;
}
static id WrongMainAction(id receiver, SEL selector, id contact, id wrap) { return nil; }
static id WrongReceiveAction(id receiver, SEL selector) { return nil; }
static id WrongDarkModeAction(id receiver, SEL selector, long long type) { return nil; }
static void VerifyAppearanceAndSearchRoutes(void) {
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    UIViewController *source=RouteSource(window);
    DarkModeManager *dark=[DarkModeManager new];
    QuickServiceCenter *center=[QuickServiceCenter new]; center.services=@{@"DarkModeManager":dark}; quickContext=center;
    quickDarkConfiguration=0; quickEffectiveDarkMode=NO;
    CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    Check(CSQuickToggleDarkMode(request) && dark.changes==1 && dark.selectedType==1 && quickDarkConfiguration==1 &&
        source.navigationController.topViewController==source && !source.navigationController.pushCalls,
        "follow-system light appearance toggles through the current-account manager to native dark without navigation");
    [request finish]; quickDarkConfiguration=0; quickEffectiveDarkMode=YES; request=CSQuickBeginRequest(source);
    Check(CSQuickToggleDarkMode(request) && dark.changes==2 && dark.selectedType==2 && quickDarkConfiguration==2 && !quickDarkDirectChanges,
        "follow-system dark appearance toggles to native light without calling the configuration-only setter");
    [request finish];
    MMServiceWrapper *wrapper=[[MMServiceWrapper alloc] initWithTarget:dark]; center.services=@{@"DarkModeManager":wrapper};
    request=CSQuickBeginRequest(source);
    Check(CSQuickToggleDarkMode(request) && dark.changes==3 && wrapper.forwards==1,
        "the checked account-service wrapper remains the receiver for its dark-mode change");
    [request finish]; center.services=@{@"DarkModeManager":dark};
    NSUInteger changes=dark.changes;
    quickDarkConfigClassOverridden=YES; quickDarkConfigClassOverride=WrongDarkModeConfigUtil.class; request=CSQuickBeginRequest(source);
    Check(!CSQuickToggleDarkMode(request) && dark.changes==changes,"an object-returning dark-state getter cannot be treated as the native boolean ABI");
    [request finish]; quickDarkConfigClassOverride=Nil; request=CSQuickBeginRequest(source);
    Check(!CSQuickToggleDarkMode(request) && dark.changes==changes,"missing native dark-mode support does not change the account service");
    [request finish]; quickDarkConfigClassOverridden=NO;
    Class wrongClass=objc_allocateClassPair(DarkModeManager.class,"WrongDarkModeManagerABI",0);
    class_addMethod(wrongClass,NSSelectorFromString(@"changeDarkModeConfigType:"),(IMP)WrongDarkModeAction,"@@:q");
    objc_registerClassPair(wrongClass); DarkModeManager *wrong=[wrongClass new];
    center.services=@{@"DarkModeManager":wrong}; request=CSQuickBeginRequest(source);
    Check(!CSQuickToggleDarkMode(request) && !wrong.changes,"an incompatible native manager change signature is rejected");
    [request finish]; center.services=@{}; request=CSQuickBeginRequest(source);
    Check(!CSQuickToggleDarkMode(request) && dark.changes==changes,"an unavailable account dark-mode service has no global fallback");
    [request finish]; center.services=@{@"DarkModeManager":dark};
    center.serviceRead=^{ quickEpoch++; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickToggleDarkMode(request) && dark.changes==changes,"an account epoch change while resolving the dark-mode service cancels the change");
    [request finish]; center.serviceRead=nil;
    quickDarkReadMutation=^{ quickEpoch++; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickToggleDarkMode(request) && dark.changes==changes,"an account epoch change while reading appearance cancels before native mutation");
    [request finish]; quickDarkReadMutation=nil; quickContext=nil; request=CSQuickBeginRequest(source);
    Check(!CSQuickToggleDarkMode(request) && dark.changes==changes,"a logged-out context cannot switch an unrelated account's appearance");
    [request finish]; quickFailureMessage=nil;
    Check(![CSQuickPanelActionRouter performActionWithIdentifier:@"dark_mode" fromViewController:source] &&
        quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "an unsupported public dark-mode shortcut fails visibly and releases its request lock");

    NewMainFrameViewController *main=[NewMainFrameViewController new];
    CAppViewControllerManager *manager=[CAppViewControllerManager new];
    manager.mainWindow=window; manager.mainFrame=main; quickAppManager=manager;
    source=FileSource(window,main); request=CSQuickBeginRequest(source);
    Check(CSQuickOpenGlobalSearch(request) && main.searchCalls==1 && source.navigationController.topViewController==source,
        "global search invokes the native home search button to retain its FTS presenter and cancellation lifecycle");
    [request finish]; UIViewController *home=source; UIViewController *chat=[UIViewController new];
    [home.navigationController pushViewController:chat animated:NO]; request=CSQuickBeginRequest(chat);
    Check(CSQuickOpenGlobalSearch(request) && main.searchCalls==2 && home.navigationController.topViewController==chat,
        "a chat page can use the existing native home owner on its current navigation stack");
    [request finish]; UITabBarController *tab=nil; source=CrossTabSource(window,main,&tab);
    UINavigationController *homeNavigation=main.curViewController.navigationController; request=CSQuickBeginRequest(source);
    Check(CSQuickOpenGlobalSearch(request) && main.searchCalls==3 && tab.selectedViewController==homeNavigation,
        "global search from another main tab hands off once to the same window's existing home stack");
    [request finish]; NSUInteger searches=main.searchCalls;
    source=CrossTabSource(window,main,&tab); tabSelectionMutation=^{ quickEpoch++; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenGlobalSearch(request) && main.searchCalls==searches,
        "an account change during the search tab handoff cancels native search submission");
    [request finish]; tabSelectionMutation=nil;
    UIWindow *otherWindow=[UIWindow new];
    source=FileSource(window,main); manager.mainWindow=otherWindow; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenGlobalSearch(request) && main.searchCalls==searches,"global search rejects an app manager belonging to another window");
    [request finish]; manager.mainWindow=window;
    wrongClass=objc_allocateClassPair(NewMainFrameViewController.class,"WrongGlobalSearchOwnerABI",0);
    class_addMethod(wrongClass,NSSelectorFromString(@"onSearchButtonTapped"),(IMP)WrongReceiveAction,"@@:");
    objc_registerClassPair(wrongClass); NewMainFrameViewController *wrongHome=[wrongClass new];
    wrongHome.curViewController=source; manager.mainFrame=wrongHome; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenGlobalSearch(request) && !wrongHome.searchCalls,"global search rejects an incompatible native action ABI");
    [request finish]; manager.mainFrame=nil; quickFailureMessage=nil;
    Check(![CSQuickPanelActionRouter performActionWithIdentifier:@"global_search" fromViewController:source] &&
        quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "an unavailable global search owner fails visibly without constructing a context-free search page");
    quickAppManager=nil; quickContext=nil; quickFailureMessage=nil;
}
static void VerifyMyMomentsRoutes(void) {
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    NewMainFrameViewController *main=[NewMainFrameViewController new];
    CAppViewControllerManager *manager=[CAppViewControllerManager new];
    manager.mainWindow=window; manager.mainFrame=main; quickAppManager=manager;
    NSUInteger timelineBefore=publicTimelineConstructions;
    UIViewController *source=FileSource(window,main);
    CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    Check(CSQuickOpenMyMoments(request) && main.myMomentsCalls==1 && !main.receiveCalls &&
        !manager.paymentCalls && publicTimelineConstructions==timelineBefore,
        "my moments submits the native self-album action without constructing the public friends timeline");
    [request finish];
    UIViewController *home=source;
    UIViewController *chat=[UIViewController new];
    [home.navigationController pushViewController:chat animated:NO]; request=CSQuickBeginRequest(chat);
    Check(CSQuickOpenMyMoments(request) && main.myMomentsCalls==2,
        "my moments can use the existing main owner earlier in the current chat stack");
    [request finish];

    source=FileSource(window,main);
    MoreViewController *more=[MoreViewController new];
    [source.navigationController pushViewController:more animated:NO];
    quickFailureMessage=nil;
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"my_moments" fromViewController:more] &&
        more.myMomentsCalls==1 && main.myMomentsCalls==2 && !quickFailureMessage && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "the public my-moments action prefers the current Me-page owner and releases its request lock");
    chat=[UIViewController new];
    [more.navigationController pushViewController:chat animated:NO]; more.navigationController.childViewControllers=@[more];
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"my_moments" fromViewController:chat] &&
        more.myMomentsCalls==2 && main.myMomentsCalls==2,
        "an existing Me-page owner earlier in the same navigation stack remains the preferred album entry");

    UITabBarController *tab=nil; source=CrossTabSource(window,main,&tab);
    UINavigationController *homeNavigation=main.curViewController.navigationController;
    quickFailureMessage=nil;
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"my_moments" fromViewController:source] &&
        main.myMomentsCalls==3 && tab.selectedViewController==homeNavigation && !quickFailureMessage &&
        !objc_getAssociatedObject(window,&CSQuickRouteRequestKey) && publicTimelineConstructions==timelineBefore,
        "my moments uses the existing first home tab for a checked public handoff without falling back to friends' moments");

    source=CrossTabSource(window,main,&tab); request=CSQuickBeginRequest(source);
    tabSelectionMutation=^{ quickEpoch++; };
    Check(!CSQuickOpenMyMoments(request) && main.myMomentsCalls==3,
        "an account change during tab handoff prevents the old my-moments request from invoking native");
    tabSelectionMutation=nil; [request finish];
    source=FileSource(window,main); UIWindow *otherWindow=[UIWindow new]; manager.mainWindow=otherWindow;
    request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenMyMoments(request) && main.myMomentsCalls==3,
        "my moments cannot use a main owner returned by another window's app manager");
    [request finish]; manager.mainWindow=window;

    Class wrongClass=objc_allocateClassPair(NewMainFrameViewController.class,"WrongMyMomentsOwnerABI",0);
    class_addMethod(wrongClass,NSSelectorFromString(@"showMyWCView"),(IMP)WrongReceiveAction,"@@:");
    objc_registerClassPair(wrongClass);
    NewMainFrameViewController *wrong=[wrongClass new]; wrong.curViewController=source; manager.mainFrame=wrong;
    quickFailureMessage=nil;
    Check(![CSQuickPanelActionRouter performActionWithIdentifier:@"my_moments" fromViewController:source] &&
        !wrong.myMomentsCalls && quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey) &&
        publicTimelineConstructions==timelineBefore,
        "an incompatible my-album native ABI fails visibly without opening the public timeline or leaking the request");
    manager.mainFrame=nil; quickFailureMessage=nil;
    Check(![CSQuickPanelActionRouter performActionWithIdentifier:@"my_moments" fromViewController:source] &&
        quickFailureMessage.length && publicTimelineConstructions==timelineBefore && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "an unavailable personal-album capability never substitutes the friends timeline");

    manager.mainFrame=main; source=FileSource(window,main);
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"moments" fromViewController:source] &&
        [source.navigationController.topViewController isKindOfClass:WCTimeLineViewController.class] &&
        publicTimelineConstructions==timelineBefore+1 && main.myMomentsCalls==3,
        "the original moments identifier continues to open the public friends timeline independently");
    quickAppManager=nil;
}
static void VerifyReceiveCodeRoutes(void) {
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    NewMainFrameViewController *main=[NewMainFrameViewController new];
    CAppViewControllerManager *manager=[CAppViewControllerManager new];
    manager.mainWindow=window; manager.mainFrame=main; quickAppManager=manager;
    UIViewController *source=FileSource(window,main);
    CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    Check(CSQuickOpenReceiveCode(request) && main.receiveCalls==1 && !manager.paymentCalls,
        "receive code submits the native facing-receive action without opening the offline payment-code route");
    [request finish];

    UIViewController *home=source;
    UIViewController *chat=[UIViewController new];
    [home.navigationController pushViewController:chat animated:NO];
    request=CSQuickBeginRequest(chat);
    Check(CSQuickOpenReceiveCode(request) && main.receiveCalls==2 && home.navigationController.topViewController==chat,
        "receive code accepts the existing main owner earlier in the current chat navigation stack");
    [request finish]; source=FileSource(window,main);
    NSUInteger calls=main.receiveCalls;
    UIWindow *otherWindow=[UIWindow new];
    manager.mainWindow=otherWindow; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls,
        "receive code rejects a main owner supplied by another window's native manager");
    [request finish]; manager.mainWindow=window;
    UIViewController *stale=[UIViewController new]; stale.navigationController=source.navigationController;
    main.curViewController=stale; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls,
        "receive code rejects a stale main page outside the navigation stack");
    [request finish]; main.curViewController=source;

    Class wrongClass=objc_allocateClassPair(NewMainFrameViewController.class,"WrongReceiveCodeOwnerABI",0);
    class_addMethod(wrongClass,NSSelectorFromString(@"openFace2FaceReceiveMoney"),(IMP)WrongReceiveAction,"@@:");
    objc_registerClassPair(wrongClass);
    NewMainFrameViewController *wrong=[wrongClass new]; wrong.curViewController=source; manager.mainFrame=wrong;
    request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenReceiveCode(request) && wrong.receiveCalls==0,
        "receive code rejects an incompatible object-returning native action");
    [request finish]; manager.mainFrame=nil; quickFailureMessage=nil;
    Check(![CSQuickPanelActionRouter performActionWithIdentifier:@"receive_code" fromViewController:source] &&
        quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "an unavailable receive-code capability fails visibly and releases the public request lock");
    manager.mainFrame=main;

    UITabBarController *tab=nil; source=CrossTabSource(window,main,&tab);
    UINavigationController *homeNavigation=main.curViewController.navigationController;
    request=CSQuickBeginRequest(source);
    Check(CSQuickOpenReceiveCode(request) && main.receiveCalls==calls+1 && tab.selectedViewController==homeNavigation && !manager.paymentCalls,
        "a different main tab hands off once to its own first WeChat tab before invoking receive money");
    [request finish]; calls=main.receiveCalls;

    source=CrossTabSource(window,main,&tab); homeNavigation=main.curViewController.navigationController;
    tab.viewControllers=@[source.navigationController,homeNavigation]; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && tab.selectedViewController==source.navigationController,
        "receive code cannot switch to a non-first navigation tab posing as home");
    [request finish];
    source=CrossTabSource(window,main,&tab); tab.view.window=otherWindow; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && tab.selectedViewController==source.navigationController,
        "receive code cannot switch a tab container attached to another window");
    [request finish];

    source=CrossTabSource(window,main,&tab); homeNavigation=main.curViewController.navigationController;
    request=CSQuickBeginRequest(source); tabSelectionMutation=^{ quickEpoch++; };
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && tab.selectedViewController==homeNavigation,
        "an account change during tab handoff cancels receive navigation without restoring a tab in the new account");
    tabSelectionMutation=nil; [request finish];

    source=CrossTabSource(window,main,&tab);
    UIViewController *nativeHome=main.curViewController;
    request=CSQuickBeginRequest(source); tabSelectionMutation=^{ nativeHome.presentedViewController=[UIViewController new]; };
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && tab.selectedViewController==nativeHome.navigationController,
        "a modal opened by native tab selection blocks receive navigation and retains its native tab");
    tabSelectionMutation=nil; nativeHome.presentedViewController=nil; [request finish];

    source=CrossTabSource(window,main,&tab); nativeHome=main.curViewController;
    request=CSQuickBeginRequest(source);
    tabSelectionMutation=^{ [nativeHome.navigationController pushViewController:[UIViewController new] animated:YES]; };
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && tab.selectedViewController==nativeHome.navigationController &&
        nativeHome.navigationController.topViewController!=nativeHome,
        "a new native top opened during tab selection blocks receive submission and is never hidden by rollback");
    tabSelectionMutation=nil; [request finish];

    source=CrossTabSource(window,main,&tab); nativeHome=main.curViewController;
    request=CSQuickBeginRequest(source);
    tabSelectionMutation=^{ nativeHome.navigationController.transitionCoordinator=[QuickTransition new]; };
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && tab.selectedViewController==nativeHome.navigationController,
        "a native transition started by tab selection cannot be interrupted by receive navigation or rollback");
    tabSelectionMutation=nil; nativeHome.navigationController.transitionCoordinator=nil; [request finish];

    source=CrossTabSource(window,main,&tab); nativeHome=main.curViewController;
    UINavigationController *originalNavigation=source.navigationController;
    request=CSQuickBeginRequest(source);
    tabSelectionMutation=^{ [originalNavigation pushViewController:[UIViewController new] animated:NO]; };
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && originalNavigation.topViewController!=source &&
        tab.selectedViewController==nativeHome.navigationController,
        "a replaced source navigation top invalidates the old receive request without rolling back newer navigation");
    tabSelectionMutation=nil; [request finish];

    source=CrossTabSource(window,main,&tab); nativeHome=main.curViewController;
    nativeHome.presentedViewController=[UIViewController new]; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && tab.selectedViewController==source.navigationController,
        "a home tab already presenting a modal is rejected before selecting it");
    nativeHome.presentedViewController=nil; [request finish];

    source=CrossTabSource(window,main,&tab); request=CSQuickBeginRequest(source);
    UIViewController *replacement=[UIViewController new];
    tabSelectionMutation=^{ main.curViewController=replacement; };
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls && tab.selectedViewController==source.navigationController,
        "a native owner rebound during handoff cannot submit receive navigation");
    tabSelectionMutation=nil; [request finish];

    source=FileSource(window,main); request=CSQuickBeginRequest(source); [request finish];
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls,"a finished receive-code request cannot invoke native");
    request=CSQuickBeginRequest(source); UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    Check(!CSQuickOpenReceiveCode(request) && main.receiveCalls==calls,"receive code cannot invoke native while the app is backgrounded");
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive; [request finish];
    quickAppManager=nil;
}
static void VerifyFileTransferRoutes(void) {
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    NewMainFrameViewController *main=[NewMainFrameViewController new];
    CAppViewControllerManager *manager=[CAppViewControllerManager new]; manager.mainWindow=window; manager.mainFrame=main; quickAppManager=manager;
    CContactMgr *contacts=[CContactMgr new]; contacts.fileContact=Contact(@"filehelper");
    MMServiceWrapper *wrapper=[[MMServiceWrapper alloc] initWithTarget:contacts];
    Check(!CSQuickMatches(wrapper,@"getContactByName:","@@:@"),"an unregistered service proxy cannot invent a trusted native ABI");
    QuickServiceCenter *center=[QuickServiceCenter new]; center.services=@{@"CContactMgr":wrapper}; quickContext=center;
    UIViewController *source=FileSource(window,main);
    CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    Check(CSQuickOpenFileTransfer(request) && main.messageCalls==1 && main.lastContact==contacts.fileContact && main.lastMessageWrap==nil &&
        CSQuickChatIsFileHelper(source.navigationController.topViewController) && wrapper.forwards==1,
        "file transfer preserves account-wrapper forwarding and uses Neo's exact main-owner (contact,nil) route to a real chat top");
    Check(![request identityIsCurrent] && [request windowIdentityIsCurrent],"successful chat navigation changes the source top while preserving the captured account/window identity");
    [request finish];
    Check(!source.navigationController.childViewControllers.count,"main owner resolution succeeds through the window-bound app manager without a fake UIKit child");

    source=FileSource(window,main); main.noOp=YES; request=CSQuickBeginRequest(source);
    quickFailureMessage=nil;
    Check(CSQuickOpenFileTransfer(request) && request.awaitingNavigation && source.navigationController.topViewController==source,
        "an accepted void route without a destination is observed on the next main turn");
    DrainMainQueue();
    Check(request.cancelled && quickFailureMessage.length && source.navigationController.topViewController==source,"a settled native no-op produces visible failure and releases its request");
    [request finish]; main.noOp=NO; main.wrongContact=Contact(@"someone-else"); request=CSQuickBeginRequest(source); quickFailureMessage=nil;
    Check(CSQuickOpenFileTransfer(request) && request.awaitingNavigation && !CSQuickChatIsFileHelper(source.navigationController.topViewController),"an unverified different chat remains pending rather than being called filehelper success");
    DrainMainQueue();
    Check(request.cancelled && quickFailureMessage.length,"a settled different conversation fails destination verification");
    [request finish]; main.wrongContact=nil; source=FileSource(window,main);
    contacts.fileContact=Contact(@"someone-else"); NSUInteger calls=main.messageCalls; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls && !contacts.dbReads,"a wrong cached contact cannot trigger navigation or a different-contact database fallback");
    [request finish]; contacts.fileContact=nil; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls && contacts.dbReads==1,"a missing filehelper fails after a read-only database lookup");
    [request finish]; contacts.dbContact=Contact(@"filehelper"); request=CSQuickBeginRequest(source);
    Check(CSQuickOpenFileTransfer(request) && main.lastContact==contacts.dbContact && contacts.dbReads==2,"an uncached filehelper can be read from this account's database without creating a contact");
    [request finish]; contacts.dbContact=nil; source=FileSource(window,main);
    QuickContact *impostor=[QuickContact new]; impostor.m_nsUsrName=@"filehelper"; contacts.fileContact=impostor;
    calls=main.messageCalls; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls,"an unrelated object with the same username is not accepted as CContact");
    [request finish]; contacts.fileContact=Contact(@"filehelper");

    QuickObjectServiceCenter *objectCenter=[QuickObjectServiceCenter new]; objectCenter.services=center.services; quickContext=objectCenter;
    request=CSQuickBeginRequest(source);
    Check(CSQuickOpenFileTransfer(request),"getService: with an id argument ABI supports the real forwarded contact lookup");
    [request finish]; source=FileSource(window,main);
    MMContext *context=[MMContext new]; context.serviceCenter=center; quickContext=context; request=CSQuickBeginRequest(source);
    Check(CSQuickOpenFileTransfer(request),"a current context's serviceCenter remains a supported account-bound service source");
    [request finish]; source=FileSource(window,main); quickContext=nil; calls=main.messageCalls; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls,"a nil authoritative context cannot use a global or previous account's contact service");
    [request finish]; quickContext=center;
    center.services=@{@"CContactMgr":[NSObject new]}; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request),"raw services must descend from the requested concrete service class");
    [request finish]; center.services=@{@"CContactMgr":wrapper,@"MMMsgLogicManager":wrapper}; request=CSQuickBeginRequest(source);
    Check(!CSQuickCurrentService(request,@"MMMsgLogicManager"),"one proxy cannot be registered under conflicting service classes");
    [request finish]; center.services=@{@"CContactMgr":wrapper};

    center.serviceRead=^{ quickEpoch++; }; request=CSQuickBeginRequest(source); calls=main.messageCalls;
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls,"an account epoch change during service lookup cancels native navigation");
    [request finish]; center.serviceRead=nil;
    UIWindow *otherWindow=[UIWindow new]; manager.mainWindow=otherWindow; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls,"a main owner from a different native main window cannot be used");
    [request finish]; manager.mainWindow=window;
    UIViewController *stale=[UIViewController new]; stale.navigationController=source.navigationController; main.curViewController=stale;
    request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls,"a main owner whose page is absent from its navigation stack is rejected");
    [request finish]; main.curViewController=source;
    Class badClass=objc_allocateClassPair(NewMainFrameViewController.class,"WrongFileTransferOwnerABI",0);
    class_addMethod(badClass,NSSelectorFromString(@"newMessageByContact:msgWrapToAdd:"),(IMP)WrongMainAction,"@@:@@"); objc_registerClassPair(badClass);
    NewMainFrameViewController *bad=[badClass new]; bad.curViewController=source; manager.mainFrame=bad; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && bad.messageCalls==0,"a main owner with an incompatible message-navigation return ABI is rejected");
    [request finish]; manager.mainFrame=main;

    main.logicOnly=YES; request=CSQuickBeginRequest(source);
    Check(CSQuickOpenFileTransfer(request),"a modern chat delegate proves filehelper only when its getViewController is the actual visible chat");
    [request finish]; source=FileSource(window,main); main.staleLogic=YES; request=CSQuickBeginRequest(source);
    quickFailureMessage=nil;
    Check(CSQuickOpenFileTransfer(request) && request.awaitingNavigation,"an unverified cached logic does not create synchronous success");
    DrainMainQueue();
    Check(request.cancelled && quickFailureMessage.length,"a cached logic pointing at another controller cannot prove filehelper opened");
    [request finish]; main.logicOnly=NO; main.staleLogic=NO; source=FileSource(window,main);
    main.messageMutation=^{ quickEpoch++; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request),"a native dispatch that crosses an account boundary cannot claim navigation success");
    [request finish]; main.messageMutation=nil; source=FileSource(window,main);
    main.messageMutation=^{ window.windowScene=[UIWindowScene new]; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request),"a native dispatch that replaces the scene cannot claim navigation success");
    [request finish]; main.messageMutation=nil; source=FileSource(window,main);
    main.messageMutation=^{ window.windowScene.activationState=UISceneActivationStateForegroundInactive; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request),"a native dispatch that deactivates its scene cannot claim filehelper success");
    [request finish]; main.messageMutation=nil; window.windowScene.activationState=UISceneActivationStateForegroundActive; source=FileSource(window,main);
    main.messageMutation=^{ UIApplication.sharedApplication.applicationState=UIApplicationStateBackground; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request),"a native dispatch that backgrounds the app cannot claim filehelper success even before its notification arrives");
    [request finish]; main.messageMutation=nil; UIApplication.sharedApplication.applicationState=UIApplicationStateActive;

    UITabBarController *tab=nil; source=CrossTabSource(window,main,&tab); request=CSQuickBeginRequest(source);
    Check(CSQuickOpenFileTransfer(request) && tab.selectedIndex==0 && !source.view.window && CSQuickChatIsFileHelper([(UINavigationController *)tab.selectedViewController topViewController]),
        "filehelper from another tab performs Neo's explicit home-tab handoff and verifies the real destination conversation");
    [request finish]; source=CrossTabSource(window,main,&tab); main.noOp=YES; request=CSQuickBeginRequest(source);
    quickFailureMessage=nil;
    Check(CSQuickOpenFileTransfer(request) && request.awaitingNavigation && tab.selectedIndex==0,
        "a submitted cross-tab native route remains on its intended stack while awaiting destination verification");
    DrainMainQueue();
    Check(request.cancelled && quickFailureMessage.length && tab.selectedIndex==0,
        "a settled no-op reports failure without undoing a native handoff that might still enqueue navigation");
    [request finish]; main.noOp=NO; main.messageDeferred=YES; source=CrossTabSource(window,main,&tab); request=CSQuickBeginRequest(source); quickFailureMessage=nil;
    Check(CSQuickOpenFileTransfer(request) && request.awaitingNavigation && !CSQuickChatIsFileHelper([(UINavigationController *)tab.selectedViewController topViewController]),
        "an asynchronously enqueued native push is accepted without prematurely restoring the original tab");
    DrainMainQueue();
    Check(request.cancelled && !quickFailureMessage && tab.selectedIndex==0 && CSQuickChatIsFileHelper([(UINavigationController *)tab.selectedViewController topViewController]),
        "the next main turn verifies an actual asynchronously opened filehelper conversation");
    main.messageDeferred=NO; source=FileSource(window,main); main.noOp=YES;
    QuickTransition *transition=[QuickTransition new]; main.messageMutation=^{ source.navigationController.transitionCoordinator=transition; };
    request=CSQuickBeginRequest(source); quickFailureMessage=nil;
    Check(CSQuickOpenFileTransfer(request) && request.awaitingNavigation,"a native transition can keep filehelper destination verification pending");
    DrainMainQueue();
    Check(!request.cancelled && transition.completion && !quickFailureMessage,"verification waits for the active native transition completion");
    BaseMsgContentViewController *transitionPage=[BaseMsgContentViewController new]; transitionPage.contact=contacts.fileContact;
    [source.navigationController pushViewController:transitionPage animated:YES]; [transition complete];
    Check(request.cancelled && !quickFailureMessage && CSQuickChatIsFileHelper(source.navigationController.topViewController),"transition completion verifies the actual chat and releases the request exactly once");
    main.messageMutation=nil; main.noOp=NO; main.messageDeferred=YES; source=FileSource(window,main); quickFailureMessage=nil;
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"file_transfer" fromViewController:source] && objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "the public router retains a pending native navigation request instead of finishing it immediately");
    DrainMainQueue();
    Check(!objc_getAssociatedObject(window,&CSQuickRouteRequestKey) && !quickFailureMessage && CSQuickChatIsFileHelper(source.navigationController.topViewController),
        "the public pending request releases only after the real asynchronously opened destination is checked");
    main.chatContactThrows=YES; source=FileSource(window,main); request=CSQuickBeginRequest(source);
    Check(CSQuickOpenFileTransfer(request) && request.awaitingNavigation,"an asynchronously opening chat remains accepted until its native contact is observed");
    DrainMainQueue();
    Check(request.cancelled && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),"an exception from asynchronous native contact observation releases the request without escaping the main queue");
    main.chatContactThrows=NO; main.messageDeferred=NO; source=CrossTabSource(window,main,&tab); calls=main.messageCalls;
    tabSelectionMutation=^{ quickEpoch++; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls,"an account change caused by tab selection cancels before invoking the native main owner");
    [request finish]; tabSelectionMutation=nil;
    source=CrossTabSource(window,main,&tab); calls=main.messageCalls;
    tabSelectionMutation=^{ if (tab.selectedIndex==0) main.curViewController.isBeingDismissed=YES; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls && tab.selectedViewController==source.navigationController && source.view.window==window,
        "a failed preflight restores the original tab only when no native navigation has been submitted");
    [request finish]; tabSelectionMutation=nil;
    source=CrossTabSource(window,main,&tab); tab.view.window=otherWindow; calls=main.messageCalls; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenFileTransfer(request) && main.messageCalls==calls && tab.selectedIndex==1,"a tab host from another window cannot be selected for filehelper");
    [request finish]; quickAppManager=nil; quickContext=nil;
}
static void VerifyChatBackgroundRoutes(void) {
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    UIViewController *source=RouteSource(window); CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    Check(CSQuickOpenChatBackground(request) && [source.navigationController.topViewController isKindOfClass:ChatBackgroundEntranceViewController.class] &&
        ![(ChatBackgroundEntranceViewController *)source.navigationController.topViewController m_username],
        "chat background opens the full native default entrance on the current stack");
    [request finish]; source=RouteSource(window); backgroundInitializerUsername=@""; request=CSQuickBeginRequest(source);
    Check(CSQuickOpenChatBackground(request),"an empty native username is accepted as the global default background context");
    [request finish]; source=RouteSource(window); backgroundInitializerUsername=(id)@42; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenChatBackground(request) && source.navigationController.topViewController==source,"a non-string native username is rejected before presenting a background entrance");
    [request finish]; backgroundInitializerUsername=@"some-chat"; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenChatBackground(request) && source.navigationController.topViewController==source,"a conversation-bound background initializer cannot substitute for global Chat Background");
    [request finish]; backgroundInitializerUsername=nil; backgroundInitMutation=^{ quickEpoch++; }; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenChatBackground(request) && source.navigationController.topViewController==source,"chat background revalidates account identity after native initialization");
    [request finish]; backgroundInitMutation=nil;
    SettingGeneralViewController *general=[SettingGeneralViewController new]; general.curViewController=source; source.navigationController.childViewControllers=@[general];
    quickFailureMessage=nil;
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"chat_background" fromViewController:source] && general.backgroundCalls==1 &&
        [source.navigationController.topViewController isKindOfClass:ChatBackgroundEntranceViewController.class] && !quickFailureMessage,
        "the existing same-stack global Settings owner takes priority over the constructor fallback");
    source=RouteSource(window); ChatRoomInfoViewController *chat=[ChatRoomInfoViewController new]; chat.curViewController=source; source.navigationController.childViewControllers=@[chat];
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"chat_background" fromViewController:source] && chat.backgroundCalls==0 &&
        [source.navigationController.topViewController isKindOfClass:ChatBackgroundEntranceViewController.class],
        "a conversation settings owner with the same selector is never used for global chat background");
}
static void VerifyNewNativeRoutes(void) {
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    UIViewController *source=RouteSource(window);
    CContactMgr *contacts=[CContactMgr new];
    contacts.selfContact=Contact(quickAccount); contacts.fileContact=Contact(@"filehelper");
    MMMsgLogicManager *messages=[MMMsgLogicManager new];
    QuickServiceCenter *center=[QuickServiceCenter new];
    center.services=@{@"CContactMgr":contacts,@"MMMsgLogicManager":messages}; quickContext=center;

    CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    Check(CSQuickOpenQRCode(request) && [source.navigationController.topViewController isKindOfClass:CameraQRCodeListViewController.class] && !legacyQRCodeContact,
        "my QR code prefers Neo's proven CameraQRCodeListViewController without requiring a contact service");
    [request finish]; source=RouteSource(window); cameraQRCodeUnavailable=YES;
    request=CSQuickBeginRequest(source);
    Check(CSQuickOpenQRCode(request) && [source.navigationController.topViewController isKindOfClass:NewPersonalQRCodeViewController.class] && legacyQRCodeContact==contacts.selfContact,
        "an unavailable modern QR page falls back to the checked current-account contact initializer");
    [request finish]; source=RouteSource(window);
    contacts.selfContact=Contact(@"different-account"); request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenQRCode(request) && source.navigationController.topViewController==source,"legacy QR rejects a self contact from another account");
    [request finish]; contacts.selfContact=Contact(quickAccount); legacyQRCodeInvalidResult=YES;
    request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenQRCode(request),"legacy QR rejects an initializer returning an unrelated object");
    [request finish]; legacyQRCodeInvalidResult=NO; quickContext=nil;
    request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenQRCode(request),"legacy QR cannot use an old global service when current context is logged out");
    [request finish]; quickContext=center; cameraQRCodeUnavailable=NO;
    request=CSQuickBeginRequest(source); cameraInitMutation=^{ quickEpoch++; };
    Check(!CSQuickOpenQRCode(request) && source.navigationController.topViewController==source,"QR rechecks the account epoch after native page construction");
    [request finish]; cameraInitMutation=nil;

    CAppViewControllerManager *manager=[CAppViewControllerManager new]; manager.mainWindow=window; quickAppManager=manager;
    request=CSQuickBeginRequest(source);
    Check(CSQuickOpenPaymentCode(request) && manager.paymentCalls==1 && manager.entrySource==source,
        "payment code invokes only native offline-payment navigation with this exact source page");
    [request finish]; UIWindow *differentWindow=[UIWindow new]; manager.mainWindow=differentWindow;
    request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenPaymentCode(request) && manager.paymentCalls==1,"payment code rejects a native manager belonging to another window");
    [request finish]; WrongPaymentManager *wrongManager=[WrongPaymentManager new]; wrongManager.mainWindow=window; quickAppManager=wrongManager;
    request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenPaymentCode(request),"payment code rejects a native action with an object-returning incompatible ABI");
    [request finish]; quickAppManager=manager; manager.mainWindow=window;

    request=CSQuickBeginRequest(source);
    Check(CSQuickOpenChannels(request) && finderPushes==1 && finderParams.fromVC==source && finderParams.byPush && finderParams.nativeScene==987,
        "channels uses native Find-page initialization defaults and explicitly pushes from the current source");
    [request finish]; finderInvalidInitializer=YES; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenChannels(request) && finderPushes==1,"channels rejects an initializer that substitutes an unrelated parameter object");
    [request finish]; finderInvalidInitializer=NO;
    Class badParams=objc_allocateClassPair(WCFinderOpenTimelineParams.class,"WrongFinderBooleanABI",0);
    class_addMethod(badParams,NSSelectorFromString(@"setByPush:"),(IMP)IgnoreObjectSetter,"v@:@"); objc_registerClassPair(badParams);
    finderConstructorReplacement=[badParams new]; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenChannels(request) && finderPushes==1,"channels rejects a byPush setter with an incompatible object ABI");
    [request finish]; finderConstructorReplacement=nil;
    request=CSQuickBeginRequest(source); finderInitMutation=^{ quickEpoch++; };
    Check(!CSQuickOpenChannels(request) && finderPushes==1,"channels revalidates account identity after the native parameter initializer");
    [request finish]; finderInitMutation=nil;

    request=CSQuickBeginRequest(source); [request finish];
    BOOL (*routes[])(CSQuickRouteRequest *)={CSQuickOpenQRCode,CSQuickOpenPaymentCode,CSQuickOpenReceiveCode,CSQuickOpenMyMoments,CSQuickOpenChannels,CSQuickOpenFileTransfer,CSQuickOpenChatBackground,CSQuickOpenCreateNote,CSQuickOpenSwitchAccount};
    for (NSUInteger index=0; index<sizeof(routes)/sizeof(routes[0]); index++)
        Check(!routes[index](request),"a finished request cannot invoke any contextual native shortcut route");
    request=CSQuickBeginRequest(source); window.windowScene=[UIWindowScene new];
    for (NSUInteger index=0; index<sizeof(routes)/sizeof(routes[0]); index++)
        Check(!routes[index](request),"a request from a replaced scene cannot invoke any contextual native shortcut route");
    [request finish];
    legacyQRCodeContact=nil; finderParams=nil; quickAppManager=nil; quickContext=nil;
}
static NSError *QuickBiometricError(NSInteger code) {
    return [NSError errorWithDomain:@"fixture.biometric" code:code userInfo:nil];
}
static BOOL OpenFavoriteContent(BOOL createNote, UIViewController *source) {
    return [CSQuickPanelActionRouter performActionWithIdentifier:createNote ? @"create_note" : @"favorites" fromViewController:source];
}
static void VerifyCreateNoteAndFavorites(void) {
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    CAppViewControllerManager *manager=[CAppViewControllerManager new]; manager.mainWindow=window; quickAppManager=manager;
    UIViewController *source=RouteSource(window);
    CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    Check(CSQuickOpenCreateNote(request) && manager.noteCalls==1 && !manager.paymentCalls,
        "raw note navigation invokes only the exact native write-note entry after resolving its window's real top");
    [request finish];
    UIWindow *otherWindow=[UIWindow new]; manager.mainWindow=otherWindow; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenCreateNote(request) && manager.noteCalls==1,"note navigation rejects a manager attached to another window");
    [request finish]; manager.mainWindow=window;
    manager.topOverride=[UIViewController new]; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenCreateNote(request) && manager.noteCalls==1,"note navigation rejects another native top even in the same manager");
    [request finish]; manager.topOverride=[NSObject new]; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenCreateNote(request) && manager.noteCalls==1,"note navigation rejects a non-controller native top");
    [request finish]; manager.topOverride=source.navigationController; request=CSQuickBeginRequest(source);
    Check(CSQuickOpenCreateNote(request) && manager.noteCalls==2,"note navigation normalizes a native navigation-container top to this exact source");
    [request finish]; manager.topOverride=nil;
    request=CSQuickBeginRequest(source); manager.topReadMutation=^{ quickEpoch++; };
    Check(!CSQuickOpenCreateNote(request) && manager.noteCalls==2,"note navigation rechecks account identity after the native top getter");
    [request finish]; manager.topReadMutation=nil;
    request=CSQuickBeginRequest(source); manager.topReadMutation=^{ window.windowScene.activationState=UISceneActivationStateForegroundInactive; };
    Check(!CSQuickOpenCreateNote(request) && manager.noteCalls==2,"note navigation rechecks scene activity immediately before its parameterless native action");
    [request finish]; manager.topReadMutation=nil; window.windowScene.activationState=UISceneActivationStateForegroundActive;
    Class wrongNoteClass=objc_allocateClassPair(CAppViewControllerManager.class,"WrongWriteNoteManagerABI",0);
    class_addMethod(wrongNoteClass,NSSelectorFromString(@"jumpToWriteNote"),(IMP)WrongReceiveAction,"@@:"); objc_registerClassPair(wrongNoteClass);
    CAppViewControllerManager *wrongManager=[wrongNoteClass new]; wrongManager.mainWindow=window; quickAppManager=wrongManager;
    request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenCreateNote(request) && !wrongManager.noteCalls,"note navigation rejects the native action with an incompatible object return ABI");
    [request finish]; quickAppManager=nil; request=CSQuickBeginRequest(source);
    Check(!CSQuickOpenCreateNote(request),"note navigation rejects an unavailable native manager without opening a different page");
    [request finish]; quickAppManager=manager;

    quickFavoritesProtected=NO; quickBiometricsAvailable=YES;
    for (NSUInteger destination=0; destination<2; destination++) {
        BOOL createNote=destination==1;
        source=RouteSource(window); quickFailureMessage=nil;
        NSUInteger noteBefore=manager.noteCalls, favoritesBefore=quickFavoritesConstructions, contextsBefore=quickBiometricConstructions;
        Check(OpenFavoriteContent(createNote,source),"an unprotected favorite-content shortcut accepts its native destination");
        Check(manager.noteCalls==noteBefore+(createNote ? 1 : 0) && quickFavoritesConstructions==favoritesBefore+(createNote ? 0 : 1) &&
            quickBiometricConstructions==contextsBefore && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
            "disabled favorites protection routes directly without constructing authentication or retaining a request lock");
        if (!createNote) Check([source.navigationController.topViewController isKindOfClass:MyFavoritesViewController.class],
            "the actual unprotected favorites helper opens the native favorites page instead of a route stub");

        quickFavoritesProtected=YES; source=RouteSource(window); quickFailureMessage=nil;
        noteBefore=manager.noteCalls; favoritesBefore=quickFavoritesConstructions;
        Check(OpenFavoriteContent(createNote,source),"a protected favorite-content shortcut starts asynchronous authentication");
        LAContext *context=quickLastAuthentication;
        request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
        Check(context && request && request.authentication==context && context.preflightPolicy==LAPolicyDeviceOwnerAuthenticationWithBiometrics &&
            context.evaluationPolicy==LAPolicyDeviceOwnerAuthenticationWithBiometrics && [context.reason isEqual:@"请验证您的身份以查看收藏内容"] &&
            manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore,
            "both protected destinations use the real favorites biometric policy and defer native navigation until its callback");
        Check([quickFavoriteSuites.lastObject isEqual:CSQuickFavoriteSuite] && [quickFavoriteKeys.lastObject isEqual:CSQuickFavoriteAuthKey],
            "the real guard reads its production favorites suite and key through the isolated in-memory defaults boundary");
        Check(!OpenFavoriteContent(createNote,source) && objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==request,
            "a repeated protected shortcut preserves the pending biometric request and cannot open a second destination");
        quickFailureMessage=nil; [context completeWithSuccess:YES error:nil];
        Check(manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore,
            "a biometric completion enqueues its destination on the main queue");
        DrainMainQueue();
        Check(manager.noteCalls==noteBefore+(createNote ? 1 : 0) && quickFavoritesConstructions==favoritesBefore+(createNote ? 0 : 1) &&
            request.cancelled && context.invalidations==1 && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey) && !quickFailureMessage,
            "successful authentication opens exactly the requested native destination and releases the live context and window lock");

        source=RouteSource(window); quickBiometricsAvailable=NO; quickFailureMessage=nil;
        NSUInteger evaluationsBefore=quickBiometricEvaluations;
        Check(!OpenFavoriteContent(createNote,source) && quickLastAuthentication.invalidations==1 &&
            quickBiometricEvaluations==evaluationsBefore && quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
            "unavailable biometrics refuse protected note and favorites entry without evaluating or retaining a request");
        quickBiometricsAvailable=YES;
        source=RouteSource(window); quickFailureMessage=nil; noteBefore=manager.noteCalls; favoritesBefore=quickFavoritesConstructions;
        Check(OpenFavoriteContent(createNote,source),"a failed-authentication fixture begins with a real pending request");
        context=quickLastAuthentication; [context completeWithSuccess:NO error:QuickBiometricError(LAErrorAuthenticationFailed)]; DrainMainQueue();
        Check(manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore && quickFailureMessage.length &&
            context.invalidations==1 && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
            "an actual biometric failure opens no content, reports failure and releases its request");
        for (NSNumber *code in @[@(LAErrorUserCancel),@(LAErrorSystemCancel),@(LAErrorAppCancel)]) {
            source=RouteSource(window); quickFailureMessage=nil;
            Check(OpenFavoriteContent(createNote,source),"a canceled-authentication fixture starts a protected request");
            context=quickLastAuthentication; [context completeWithSuccess:NO error:QuickBiometricError(code.integerValue)]; DrainMainQueue();
            Check(manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore && !quickFailureMessage &&
                context.invalidations==1 && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
                "user, system and app biometric cancellations open no content and cleanly release without an error alert");
        }

        source=RouteSource(window); quickFailureMessage=nil;
        Check(OpenFavoriteContent(createNote,source),"an account-boundary fixture starts pending authentication");
        context=quickLastAuthentication; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
        quickAccount=[quickAccount stringByAppendingString:@"-changed"]; quickEpoch++;
        [NSNotificationCenter.defaultCenter postNotificationName:@"CSBackupAccountChanged" object:nil];
        CSQuickRouteRequest *replacement=CSQuickBeginRequest(source);
        [context completeWithSuccess:YES error:nil]; DrainMainQueue();
        Check(request.cancelled && context.invalidations==1 && replacement && objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==replacement &&
            manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore && !quickFailureMessage,
            "a late successful biometric callback from an old account neither opens content nor clears the new account's request");
        [replacement finish];
        source=RouteSource(window); quickFailureMessage=nil;
        Check(OpenFavoriteContent(createNote,source),"a replaced-scene fixture starts pending authentication");
        context=quickLastAuthentication; window.windowScene=[UIWindowScene new];
        [context completeWithSuccess:YES error:nil]; DrainMainQueue();
        Check(manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore && context.invalidations==1 &&
            !objc_getAssociatedObject(window,&CSQuickRouteRequestKey) && !quickFailureMessage,
            "a biometric success from the window's previous scene cannot open favorite content");
        source=RouteSource(window); quickFailureMessage=nil;
        Check(OpenFavoriteContent(createNote,source),"a scene-background fixture starts pending authentication");
        context=quickLastAuthentication;
        [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidEnterBackgroundNotification object:window.windowScene];
        [context completeWithSuccess:YES error:nil]; DrainMainQueue();
        Check(manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore && context.invalidations==1 &&
            !objc_getAssociatedObject(window,&CSQuickRouteRequestKey) && !quickFailureMessage,
            "an owning scene background event cancels protected content even if authentication later succeeds");
        source=RouteSource(window); quickFailureMessage=nil;
        Check(OpenFavoriteContent(createNote,source),"a protection-change fixture starts under enabled favorites protection");
        context=quickLastAuthentication; quickFavoritesProtected=NO;
        [context completeWithSuccess:YES error:nil]; DrainMainQueue();
        Check(manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore && context.invalidations==1 &&
            !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
            "turning favorites protection off invalidates the old protected continuation instead of opening stale content");
        quickFavoritesProtected=YES;
        source=RouteSource(window); quickFailureMessage=nil;
        Check(OpenFavoriteContent(createNote,source),"a covered-source fixture starts protected authentication");
        context=quickLastAuthentication; source.presentedViewController=[UIViewController new];
        [context completeWithSuccess:YES error:nil]; DrainMainQueue();
        Check(manager.noteCalls==noteBefore && quickFavoritesConstructions==favoritesBefore && context.invalidations==1 &&
            !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
            "a modal covering the original source prevents a successful biometric reply from pushing content behind it");
        source.presentedViewController=nil;
        quickFavoritesProtected=NO;
    }
    quickFavoritesProtected=YES; source=RouteSource(window); quickFailureMessage=nil;
    NSUInteger before=manager.noteCalls;
    Check(OpenFavoriteContent(YES,source),"a native-top-change fixture starts protected note creation");
    LAContext *context=quickLastAuthentication; manager.topOverride=[UIViewController new];
    [context completeWithSuccess:YES error:nil]; DrainMainQueue();
    Check(manager.noteCalls==before && quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "successful note authentication revalidates the manager's real top before calling its parameterless editor entry");
    manager.topOverride=nil; source=RouteSource(window); quickFailureMessage=nil;
    Check(OpenFavoriteContent(YES,source),"a native-exception fixture starts protected note creation");
    context=quickLastAuthentication; manager.noteMutation=^{ [NSException raise:NSInternalInconsistencyException format:@"fixture note native failure"]; };
    [context completeWithSuccess:YES error:nil]; DrainMainQueue();
    Check(manager.noteCalls==before+1 && quickFailureMessage.length && context.invalidations==1 && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "an exception from the authenticated native note action is caught and releases authentication and its window lock");
    manager.noteMutation=nil; quickFavoritesProtected=NO; quickLastAuthentication=nil; quickAppManager=nil;
}
static void WrongSettingInitializer(id receiver, SEL selector) {}
static void ResetSwitchFixture(void) {
    quickSettingInitUnavailable=NO; quickSettingInitReplacement=nil; quickSettingInitMutation=nil;
    quickSettingShowMutation=nil; quickSettingGotoMutation=nil; navigationPushMutation=nil;
    quickSettingNativeNoOp=NO; quickSettingTargetDeferred=NO; quickSettingNeedsTip=NO; quickSettingTipDeferred=NO;
    quickSettingTipWindow=nil; quickSettingTipClass=Nil; quickSettingTipMutation=nil;
    quickSettingHoldDestination=NO; quickSettingPendingDestination=nil;
    quickSettingClassOverridden=NO; quickSettingClassOverride=Nil;
    quickFailureMessage=nil; quickFailureSource=nil; quickSuspended=NO;
}
static BOOL OpenSwitchAccount(UIViewController *source) {
    return [CSQuickPanelActionRouter performActionWithIdentifier:@"switch_account" fromViewController:source];
}
static void VerifySwitchAccountRoutes(void) {
    ResetSwitchFixture();
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    UIWindow *otherWindow=[UIWindow new]; otherWindow.windowScene=[UIWindowScene new];
    UIViewController *source=RouteSource(window);
    NSUInteger constructionsBefore=quickSettingInitCalls, showBefore=quickSettingShowCalls, actionsBefore=quickSettingGotoCalls;
    Check(OpenSwitchAccount(source),"switch-account accepts a checked native settings owner as a pending route");
    NewSettingViewController *page=(id)source.navigationController.topViewController;
    CSQuickRouteRequest *request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
    Check([page isKindOfClass:NewSettingViewController.class] && quickSettingInitCalls==constructionsBefore+1 &&
        quickSettingShowCalls==showBefore && quickSettingGotoCalls==actionsBefore && request.awaitingNavigation && request.source==page &&
        source.navigationController.pushCalls==1 && !source.navigationController.lastPushAnimated && page.hidesBottomBarWhenPushed,
        "fallback pushes and rebinds settings while deferring its native action until a later main turn");
    SettleDelayedNavigation();
    Check([source.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class] &&
        quickSettingShowCalls==showBefore+1 && quickSettingGotoCalls==actionsBefore+1 && page.showCalls==1 && page.gotoCalls==1 &&
        quickSettingLastReceiver==page && quickSettingRequestSource==page && quickSettingLastLogic==page.nativeSwitchLogic &&
        quickSettingLastLogic && request.cancelled && !quickFailureMessage && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "success requires an actual visible native account-selection page after showLoginInfo owns its native continuation");

    ResetSwitchFixture(); source=RouteSource(window); page=[NewSettingViewController new];
    [source.navigationController pushViewController:page animated:NO];
    constructionsBefore=quickSettingInitCalls; showBefore=quickSettingShowCalls;
    NSUInteger pushes=page.navigationController.pushCalls;
    Check(OpenSwitchAccount(page),"an already visible native settings page accepts the same deferred entry");
    SettleDelayedNavigation();
    Check(quickSettingInitCalls==constructionsBefore && page.showCalls==1 && quickSettingShowCalls==showBefore+1 &&
        page.navigationController.pushCalls==pushes+1 && [page.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class],
        "only the visible settings owner is reused without constructing or pushing a second settings page");

    ResetSwitchFixture(); source=RouteSource(window); NewSettingViewController *older=[NewSettingViewController new];
    [source.navigationController pushViewController:older animated:NO];
    UIViewController *detail=[UIViewController new]; [source.navigationController pushViewController:detail animated:NO];
    source.navigationController.childViewControllers=@[older]; constructionsBefore=quickSettingInitCalls;
    Check(OpenSwitchAccount(detail),"a detail above an older settings page starts a fresh visible owner");
    page=(id)detail.navigationController.topViewController;
    SettleDelayedNavigation();
    Check(page!=older && quickSettingInitCalls==constructionsBefore+1 && !older.showCalls && !older.gotoCalls && page.showCalls==1 &&
        [detail.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class],
        "hidden settings owners earlier in the same stack cannot supply a competing native presentation");

    Class wrongAction=objc_allocateClassPair(NewSettingViewController.class,"WrongSwitchLoginInfoABI",0);
    class_addMethod(wrongAction,NSSelectorFromString(@"showLoginInfo"),(IMP)WrongReceiveAction,"@@:"); objc_registerClassPair(wrongAction);
    Class wrongInit=objc_allocateClassPair(NewSettingViewController.class,"WrongSwitchAccountInitializerABI",0);
    class_addMethod(wrongInit,@selector(init),(IMP)WrongSettingInitializer,"v@:"); objc_registerClassPair(wrongInit);
    quickSettingClassOverridden=YES;
    for (id value in @[NSNull.null,NSObject.class,wrongAction,wrongInit]) {
        quickSettingClassOverride=value==NSNull.null ? Nil : value;
        source=RouteSource(window); quickFailureMessage=nil;
        constructionsBefore=quickSettingInitCalls; showBefore=quickSettingShowCalls;
        Check(!OpenSwitchAccount(source) && quickSettingInitCalls==constructionsBefore && quickSettingShowCalls==showBefore &&
            !source.navigationController.pushCalls && quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
            "missing settings, non-UIKit classes and incompatible initializer or showLoginInfo ABIs fail before constructing a native owner");
    }
    ResetSwitchFixture(); source=RouteSource(window); quickSettingInitUnavailable=YES; showBefore=quickSettingShowCalls;
    Check(!OpenSwitchAccount(source) && quickSettingShowCalls==showBefore && !source.navigationController.pushCalls &&
        !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),"a nil settings initializer cannot begin a deferred native account route");
    ResetSwitchFixture(); source=RouteSource(window); quickSettingInitReplacement=[NSObject new];
    Check(!OpenSwitchAccount(source) && quickSettingShowCalls==showBefore && !source.navigationController.pushCalls &&
        !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),"an unrelated initializer result cannot become an account route owner");
    ResetSwitchFixture(); quickSettingInitReplacement=[wrongAction new]; source=RouteSource(window);
    Check(!OpenSwitchAccount(source) && quickSettingShowCalls==showBefore && !source.navigationController.pushCalls &&
        !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),"the initialized instance must still expose the native entry with its exact ABI");
    ResetSwitchFixture(); source=RouteSource(window); quickSettingInitMutation=^{ quickEpoch++; };
    Check(!OpenSwitchAccount(source) && quickSettingShowCalls==showBefore && !source.navigationController.pushCalls &&
        !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),"an account change during initialization prevents the settings push");
    ResetSwitchFixture(); source=RouteSource(window); UIViewController *originalSource=source;
    quickSettingInitMutation=^{ [originalSource.navigationController pushViewController:[UIViewController new] animated:NO]; };
    Check(!OpenSwitchAccount(source) && quickSettingShowCalls==showBefore && source.navigationController.pushCalls==1 &&
        ![source.navigationController.topViewController isKindOfClass:NewSettingViewController.class] &&
        !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),"user navigation during native initialization is preserved without a stale account route");

    ResetSwitchFixture(); source=RouteSource(window); showBefore=quickSettingShowCalls;
    navigationPushMutation=^(UINavigationController *navigation, UIViewController *pushed) {
        if ([pushed isKindOfClass:NewSettingViewController.class]) pushed.view.window=nil;
    };
    Check(OpenSwitchAccount(source),"settings can enter pending observation before its native view attaches to the window");
    page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
    DrainMainQueue();
    Check(request && !request.cancelled && request.source==page && request.awaitingNavigation && quickSettingShowCalls==showBefore &&
        !quickFailureMessage && quickDelayedBlocks.count,"a detached newly pushed settings view waits without calling its native entry");
    UIViewController *contender=[UIViewController new]; contender.view.window=window;
    CSQuickRouteRequest *duplicate=CSQuickBeginRequest(contender);
    Check(!duplicate && objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==request && !request.cancelled,
        "pending navigation keeps the window lock even while its newly rebound settings source is temporarily detached");
    navigationPushMutation=nil; page.view.window=window;
    SettleDelayedNavigation();
    Check(page.showCalls==1 && [page.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class] &&
        request.cancelled && !quickFailureMessage,"window attachment resumes the native action once and verifies its actual account page");

    ResetSwitchFixture(); source=RouteSource(window); QuickTransition *appearance=[QuickTransition new];
    navigationPushMutation=^(UINavigationController *navigation, UIViewController *pushed) {
        if ([pushed isKindOfClass:NewSettingViewController.class]) pushed.transitionCoordinator=appearance;
    };
    Check(OpenSwitchAccount(source),"a settings appearance transition starts a pending native route");
    page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
    DrainMainQueue();
    Check(!page.showCalls && !request.cancelled && quickDelayedBlocks.count,"the native switch entry waits for the pushed settings appearance to settle");
    navigationPushMutation=nil; page.transitionCoordinator=nil; [appearance complete]; SettleDelayedNavigation();
    Check(page.showCalls==1 && [page.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class] &&
        !quickFailureMessage,"completing native appearance submits the entry once without overlapping settings pushes");

    ResetSwitchFixture(); source=RouteSource(window); quickSettingHoldDestination=YES;
    Check(OpenSwitchAccount(source),"a native action can accept its route before enqueuing the account-selection destination");
    page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
    DrainMainQueue();
    Check(page.showCalls==1 && page.gotoCalls==1 && quickSettingPendingDestination && !request.cancelled &&
        request.awaitingNavigation && page.navigationController.topViewController==page && !quickFailureMessage,
        "invocation counts and a settings top cannot falsely complete a native account shortcut");
    Check(!OpenSwitchAccount(page) && !quickFailureMessage && page.showCalls==1 &&
        objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==request,
        "a repeated tap while observing native account checks neither reenters nor presents a competing alert");
    RunDelayedTurn(); RunDelayedTurn();
    Check(page.showCalls==1 && page.gotoCalls==1 && !request.cancelled,
        "repeated observation never resubmits showLoginInfo or the native goto continuation");
    dispatch_block_t destination=quickSettingPendingDestination; quickSettingPendingDestination=nil;
    dispatch_async(dispatch_get_main_queue(),destination); SettleDelayedNavigation();
    Check([page.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class] &&
        request.cancelled && !quickFailureMessage && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "the pending request completes only after the asynchronously opened account-selection page becomes visible");

    ResetSwitchFixture(); source=RouteSource(window); quickSettingTargetDeferred=YES;
    Check(OpenSwitchAccount(source),"a native main-queue account push starts pending observation");
    SettleDelayedNavigation();
    Check([source.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class] &&
        !quickFailureMessage && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "a real next-main-turn native account push is observed before releasing the window lock");

    ResetSwitchFixture(); source=RouteSource(window); quickSettingNativeNoOp=YES;
    NSUInteger scheduledBefore=quickDelayedSchedules;
    Check(OpenSwitchAccount(source),"a native void no-op is accepted only as an unverified pending handoff");
    page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
    DrainMainQueue();
    Check(page.showCalls==1 && !page.gotoCalls && !request.cancelled && !quickFailureMessage,
        "returning from the native entry without a tip or account page keeps verification pending");
    SettleDelayedNavigation();
    Check(request.cancelled && page.navigationController.topViewController==page && page.showCalls==1 && !page.gotoCalls &&
        quickFailureMessage.length && quickFailureSource==page && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey) &&
        quickDelayedSchedules>scheduledBefore && quickDelayedSchedules-scheduledBefore<=240,
        "a settled native no-op has a bounded timeout, reports failure on visible settings and never repeats its native action");

    for (NSUInteger boundary=0; boundary<8; boundary++) {
        ResetSwitchFixture(); source=RouteSource(window); quickSettingNativeNoOp=YES;
        Check(OpenSwitchAccount(source),"a cancellation fixture starts with native work still pending");
        page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
        DrainMainQueue();
        UIViewController *userPage=nil;
        switch (boundary) {
            case 0: quickEpoch++; break;
            case 1: quickAccount=[quickAccount stringByAppendingString:@"-switch-boundary"]; quickEpoch++; break;
            case 2: window.windowScene=[UIWindowScene new]; break;
            case 3: [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidEnterBackgroundNotification object:window.windowScene]; break;
            case 4: userPage=[UIViewController new]; [page.navigationController pushViewController:userPage animated:YES]; break;
            case 5: page.presentedViewController=[UIViewController new]; break;
            case 6: quickSuspended=YES; break;
            case 7: window.rootViewController=[UIViewController new]; break;
        }
        SettleDelayedNavigation();
        Check(request.cancelled && page.showCalls==1 && !page.gotoCalls && !quickFailureMessage &&
            !objc_getAssociatedObject(window,&CSQuickRouteRequestKey) && (!userPage || page.navigationController.topViewController==userPage),
            "account, scene, background, suspension and user-navigation boundaries cancel pending work without repeating or replacing native UI");
        page.presentedViewController=nil;
    }

    ResetSwitchFixture(); source=RouteSource(window); quickSettingNativeNoOp=YES;
    Check(OpenSwitchAccount(source),"a replacement-lock fixture begins pending account observation");
    page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey); DrainMainQueue();
    quickEpoch++; [NSNotificationCenter.defaultCenter postNotificationName:@"CSBackupAccountChanged" object:nil];
    CSQuickRouteRequest *replacementRequest=CSQuickBeginRequest(page);
    SettleDelayedNavigation();
    Check(request.cancelled && replacementRequest && [replacementRequest isCurrent] &&
        objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==replacementRequest && page.showCalls==1 && !quickFailureMessage,
        "late observation from an old account cannot invoke native work or release the new account's request");
    [replacementRequest finish];

    for (NSUInteger choice=0; choice<2; choice++) {
        ResetSwitchFixture(); source=RouteSource(window); quickSettingNeedsTip=YES; quickSettingTipDeferred=choice==1;
        UIWindow *tipWindow=[UIWindow new]; tipWindow.windowScene=window.windowScene; quickSettingTipWindow=tipWindow;
        Check(OpenSwitchAccount(source),"first-use native guidance starts through the real showLoginInfo gate");
        page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
        SettleDelayedNavigation();
        MMTipsViewController *tip=page->m_introView;
        Check(tip && tip.m_delegate==page && tip.isObjShowing && tip.view.window==tipWindow && page.showCalls==1 && !page.gotoCalls &&
            !page.nativeSwitchLogic && page.navigationController.topViewController==page && request.cancelled && !quickFailureMessage &&
            !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
            "the exact showing native tip in this scene is a valid handoff without bypassing first-use confirmation");
        if (!choice) {
            [tip confirm]; SettleDelayedNavigation();
            Check(page.showCalls==1 && page.gotoCalls==1 && [page.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class],
                "native tip confirmation alone continues goto exactly once after the router has handed off ownership");
        } else {
            [tip cancel]; SettleDelayedNavigation();
            Check(page.showCalls==1 && !page.gotoCalls && page.navigationController.topViewController==page && !tip.isObjShowing,
                "canceling first-use guidance never invokes a router fallback or forces the account-selection page");
        }
    }

    Class wrongTip=objc_allocateClassPair(MMTipsViewController.class,"WrongSwitchTipShowingABI",0);
    class_addMethod(wrongTip,NSSelectorFromString(@"isObjShowing"),(IMP)WrongReceiveAction,"@@:"); objc_registerClassPair(wrongTip);
    for (NSUInteger invalidTip=0; invalidTip<6; invalidTip++) {
        ResetSwitchFixture(); source=RouteSource(window); quickSettingNeedsTip=YES;
        if (invalidTip==5) quickSettingTipClass=wrongTip;
        quickSettingTipMutation=^(MMTipsViewController *tip) {
            switch (invalidTip) {
                case 0: tip.m_delegate=nil; break;
                case 1: tip.objShowing=NO; break;
                case 2: tip.isViewLoaded=NO; break;
                case 3: tip.view.window=nil; break;
                case 4: tip.view.window=otherWindow; break;
            }
        };
        Check(OpenSwitchAccount(source),"an invalid native-tip fixture begins as an unverified handoff");
        page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
        SettleDelayedNavigation();
        Check(request.cancelled && page.showCalls==1 && !page.gotoCalls && page.navigationController.topViewController==page &&
            quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
            "a tip with wrong delegate, hidden or unloaded UI, missing window, wrong scene or incompatible showing ABI cannot prove success");
    }

    ResetSwitchFixture(); source=RouteSource(window);
    quickSettingShowMutation=^{ [NSException raise:NSInternalInconsistencyException format:@"fixture native showLoginInfo failure"]; };
    Check(OpenSwitchAccount(source),"a native exception fixture starts through deferred public dispatch");
    page=(id)source.navigationController.topViewController; request=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
    SettleDelayedNavigation();
    Check(request.cancelled && page.showCalls==1 && !page.gotoCalls && quickFailureMessage.length && quickFailureSource==page &&
        !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),"an asynchronous native-entry exception reports against the visible settings owner and releases its lock");
    Check(!quickSettingForbiddenCalls && quickDelayedUsesMainQueue,"account observation uses the main queue without logout, login or automatic account-selection APIs");
    ResetSwitchFixture(); quickSettingLastReceiver=nil; quickSettingRequestSource=nil; quickSettingLastLogic=nil;
}
static BOOL PluginHomePresented(UIViewController *source) {
    UINavigationController *navigation=(id)source.presentedViewController;
    return [navigation isKindOfClass:UINavigationController.class] && navigation!=source.navigationController &&
        navigation.modalPresentationStyle==UIModalPresentationFormSheet && navigation.viewControllers.count==1 &&
        [navigation.topViewController isKindOfClass:QuickNativeSettingsHost.class] && navigation.topViewController.navigationController==navigation;
}
static void VerifyPluginRoutes(void) {
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    UIViewController *source=RouteSource(window);
    UINavigationController *original=source.navigationController;
    NSArray *stack=original.viewControllers;
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"plugin_home" fromViewController:source] && PluginHomePresented(source),
        "the real public plugin-home route presents its native host in a distinct form-sheet navigation controller");
    Check(original.topViewController==source && [original.viewControllers isEqual:stack] && !original.pushCalls &&
        source.presentationCalls==1 && source.lastPresentationAnimated && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "plugin home leaves the source navigation stack intact and releases its request after one animated presentation");
    Check(![CSQuickPanelActionRouter performActionWithIdentifier:@"plugin_home" fromViewController:source] && source.presentationCalls==1,
        "a second plugin-home tap cannot stack another sheet over the existing presentation");

    source=RouteSource(window); original=source.navigationController;
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"panel_settings" fromViewController:source] &&
        [original.topViewController isKindOfClass:CSQuickPanelSettingsViewController.class] && original.pushCalls==1 && !source.presentationCalls,
        "the real panel-settings branch retains its push route rather than inheriting the plugin-home modal container");
    Check([(CSQuickPanelSettingsViewController *)original.topViewController style]==UITableViewStyleInsetGrouped &&
        original.topViewController.hidesBottomBarWhenPushed && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "panel settings retains its grouped initialization, hidden bottom bar and completed request");

    source=RouteSource(window);
    quickPluginInitMutation=^{ quickEpoch++; };
    Check(![CSQuickPanelActionRouter performActionWithIdentifier:@"plugin_home" fromViewController:source] &&
        !source.presentationCalls && !source.navigationController.pushCalls && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "an account epoch change inside the native-host initializer rejects the stale modal before presenting it");
    quickPluginInitMutation=nil;

    CSAuthorizationManager *authorization=CSAuthorizationManager.sharedManager;
    authorization.isAuthorized=NO; source=RouteSource(window);
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"plugin_home" fromViewController:source] &&
        !source.presentationCalls && authorization.completion && objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "the real plugin route defers modal presentation and retains its request until authorization completes");
    authorization.completion(NO,@"cancel"); authorization.completion=nil;
    Check(!source.presentationCalls && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "denied authorization leaves navigation untouched and releases the plugin request");
    source=RouteSource(window);
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"plugin_home" fromViewController:source],"a fresh plugin request can retry after denied authorization");
    authorization.isAuthorized=YES; authorization.completion(YES,@"ok"); authorization.completion=nil;
    Check(PluginHomePresented(source) && source.presentationCalls==1 && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "successful authorization resumes the real route with exactly one form-sheet presentation");

    quickPluginHidden=YES; source=RouteSource(window);
    Check([CSQuickPanelActionRouter performActionWithIdentifier:@"plugin_home" fromViewController:source] && quickPrivacyReply && !source.presentationCalls,
        "a hidden plugin entry invokes privacy authentication before constructing its visible destination");
    UIAlertController *password=[UIAlertController new]; password.title=@"验证密友密码"; source.presentedViewController=password;
    quickPluginHidden=NO; NSUInteger dismissals=quickPrivacyDismissals;
    quickPrivacyReply(YES); quickPrivacyReply=nil;
    Check(source.presentedViewController==password && !source.presentationCalls && quickPrivacyDismissals==dismissals+1 &&
        quickPrivacyDismissCompletion && objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "the production privacy continuation waits for that exact password alert to dismiss before showing the home sheet");
    source.presentedViewController=nil;
    quickPrivacyDismissCompletion(); quickPrivacyDismissCompletion=nil;
    Check(PluginHomePresented(source) && source.presentationCalls==1 && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "finishing privacy-sheet dismissal resumes a single real home presentation and releases its request");
    quickFailureMessage=nil;
}
static void VerifyPublicDispatch(void) {
    NSDictionary *pages=@{@"scan":@"CameraScanViewController",@"wallet":@"WCPayMainViewControllerV2",@"moments":@"WCTimeLineViewController",
        @"my_qrcode":@"CameraQRCodeListViewController",@"favorites":@"MyFavoritesViewController",@"profile":@"SettingMyProfileViewController",@"add_friend":@"AddFriendEntryViewController",@"emoji_store":@"MMEmotionStoreViewController",@"chat_background":@"ChatBackgroundEntranceViewController"};
    for (NSString *name in pages.allValues) if (!NSClassFromString(name)) {
        Class cls=objc_allocateClassPair(UIViewController.class,name.UTF8String,0); objc_registerClassPair(cls);
    }
    NSSet *expected=[NSSet setWithArray:@[@"scan",@"wallet",@"moments",@"my_qrcode",@"favorites",@"plugin_home",@"profile",@"create_group",@"add_friend",@"emoji_store",@"panel_settings",@"payment_code",@"channels",@"file_transfer",@"chat_background",@"receive_code",@"my_moments",@"create_note",@"switch_account",@"dark_mode",@"global_search"]];
    Check(QuickPreferenceIDs().count==21 && [[NSSet setWithArray:QuickPreferenceIDs()] isEqual:expected],"all 21 production preference identifiers agree with the router dispatch contract");
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    CContactMgr *contacts=[CContactMgr new]; contacts.fileContact=Contact(@"filehelper");
    MMMsgLogicManager *messages=[MMMsgLogicManager new]; QuickServiceCenter *center=[QuickServiceCenter new];
    DarkModeManager *dark=[DarkModeManager new];
    center.services=@{@"CContactMgr":contacts,@"MMMsgLogicManager":messages,@"DarkModeManager":dark}; quickContext=center;
    CAppViewControllerManager *manager=[CAppViewControllerManager new]; manager.mainWindow=window; quickAppManager=manager;
    quickFavoritesProtected=NO;
    for (NSString *identifier in QuickPreferenceIDs()) {
        UIViewController *source=RouteSource(window); quickFailureMessage=nil;
        NewMainFrameViewController *home=[NewMainFrameViewController new]; home.curViewController=source;
        manager.mainFrame=home;
        if ([identifier isEqual:@"create_group"]) source.navigationController.childViewControllers=@[home];
        NSUInteger oldFinderPushes=finderPushes, oldPaymentCalls=manager.paymentCalls, oldMessages=home.messageCalls, oldReceiveCalls=home.receiveCalls, oldMyMomentsCalls=home.myMomentsCalls;
        NSUInteger oldNoteCalls=manager.noteCalls, oldSettingGotoCalls=quickSettingGotoCalls, oldSettingShowCalls=quickSettingShowCalls;
        NSUInteger oldDarkChanges=dark.changes; BOOL wasDark=quickEffectiveDarkMode;
        Check([CSQuickPanelActionRouter performActionWithIdentifier:identifier fromViewController:source],[[NSString stringWithFormat:@"the actual public performAction accepts configured identifier %@",identifier] UTF8String]);
        if ([identifier isEqual:@"switch_account"]) SettleDelayedNavigation();
        BOOL routed=NO;
        if (pages[identifier]) routed=[source.navigationController.topViewController isKindOfClass:NSClassFromString(pages[identifier])];
        else if ([identifier isEqual:@"create_group"]) routed=home.createCalls==1;
        else if ([identifier isEqual:@"payment_code"]) routed=manager.paymentCalls==oldPaymentCalls+1 && manager.entrySource==source;
        else if ([identifier isEqual:@"receive_code"]) routed=home.receiveCalls==oldReceiveCalls+1 && manager.paymentCalls==oldPaymentCalls;
        else if ([identifier isEqual:@"my_moments"]) routed=home.myMomentsCalls==oldMyMomentsCalls+1;
        else if ([identifier isEqual:@"dark_mode"]) routed=dark.changes==oldDarkChanges+1 && dark.selectedType==(wasDark ? 2 : 1) && quickEffectiveDarkMode!=wasDark;
        else if ([identifier isEqual:@"global_search"]) routed=home.searchCalls==1;
        else if ([identifier isEqual:@"channels"]) routed=finderPushes==oldFinderPushes+1 && finderParams.fromVC==source && finderParams.byPush;
        else if ([identifier isEqual:@"file_transfer"]) routed=home.messageCalls==oldMessages+1 && home.lastContact==contacts.fileContact && home.lastMessageWrap==nil && CSQuickChatIsFileHelper(source.navigationController.topViewController) && messages.pushes==0;
        else if ([identifier isEqual:@"create_note"]) routed=manager.noteCalls==oldNoteCalls+1;
        else if ([identifier isEqual:@"switch_account"]) routed=quickSettingShowCalls==oldSettingShowCalls+1 && quickSettingGotoCalls==oldSettingGotoCalls+1 && [source.navigationController.topViewController isKindOfClass:WCAccountLoginUsersViewController.class];
        else if ([identifier isEqual:@"plugin_home"]) routed=PluginHomePresented(source);
        else if ([identifier isEqual:@"panel_settings"]) routed=[source.navigationController.topViewController isKindOfClass:CSQuickPanelSettingsViewController.class];
        Check(routed && !quickFailureMessage && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),[[NSString stringWithFormat:@"public identifier %@ reaches its intended route and releases the request lock",identifier] UTF8String]);
    }
    UIViewController *source=RouteSource(window);
    Check(![CSQuickPanelActionRouter performActionWithIdentifier:@"unknown_action" fromViewController:source] && quickFailureMessage.length && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),"unknown public identifiers fail visibly and release the request lock");
    quickContext=nil; quickAppManager=nil; finderParams=nil;
}
static void VerifyRequestLifecycle(void) {
    UIWindow *window=[UIWindow new];
    UIWindowScene *scene=[UIWindowScene new]; window.windowScene=scene;
    UIViewController *source=RouteSource(window);
    CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    LAContext *authentication=[LAContext new]; request.authentication=authentication;
    Check(request && [request isCurrent],"begin a live request bound to source, window, scene and account");
    Check(!CSQuickBeginRequest(source) && authentication.invalidations==0,"preserve the lock and LAContext of genuine in-flight authentication");
    source.presentedViewController=[UIViewController new];
    Check([request identityIsCurrent] && ![request isCurrent],"preserve identity during an authentication modal while withholding navigation");
    source.presentedViewController=nil;
    scene.activationState=UISceneActivationStateForegroundInactive;
    Check([request identityIsCurrent],"temporary biometric scene deactivation preserves request identity");
    scene.activationState=UISceneActivationStateForegroundActive;
    quickAccount=@"second-account"; quickEpoch++;
    [NSNotificationCenter.defaultCenter postNotificationName:@"CSBackupAccountChanged" object:nil];
    Check(request.cancelled && authentication.invalidations==1 && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "account boundary cancels authentication and immediately releases the window lock");
    CSQuickRouteRequest *replacement=CSQuickBeginRequest(source);
    Check(replacement && [replacement isCurrent],"the new account can start without waiting for an old authentication callback");
    [request finish];
    Check(objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==replacement && ![request identityIsCurrent],
        "late completion of an old account request cannot release the new account lock");
    [replacement finish];

    request=CSQuickBeginRequest(source); authentication=[LAContext new]; request.authentication=authentication;
    [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidDisconnectNotification object:[UIWindowScene new]];
    Check([request isCurrent] && !authentication.invalidations,"an unrelated scene disconnect cannot cancel this window request");
    [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidDisconnectNotification object:scene];
    Check(request.cancelled && authentication.invalidations==1 && !objc_getAssociatedObject(window,&CSQuickRouteRequestKey),
        "the owning scene disconnect releases its request and invalidates authentication");

    request=CSQuickBeginRequest(source); authentication=[LAContext new]; request.authentication=authentication;
    quickAccount=@"third-account"; quickEpoch++;
    replacement=CSQuickBeginRequest(source);
    Check(replacement && replacement!=request && request.cancelled && authentication.invalidations==1,
        "begin evicts an old account request even when the account notification has not arrived");
    [replacement finish];
    request=CSQuickBeginRequest(source); quickEpoch++;
    replacement=CSQuickBeginRequest(source);
    Check(replacement && request.cancelled,"an epoch boundary evicts an old request even for the same account identifier");
    [replacement finish];

    request=CSQuickBeginRequest(source);
    UIViewController *next=[UIViewController new]; next.view.window=window;
    UINavigationController *navigation=source.navigationController;
    next.navigationController=navigation; next.parentViewController=navigation;
    navigation.topViewController=next; navigation.viewControllers=@[source,next];
    replacement=CSQuickBeginRequest(next);
    Check(replacement && request.cancelled,"a new navigation top can evict the former source request in the same window");
    [request finish];
    Check(objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==replacement,"a popped or covered source cannot clear the replacement lock");
    [replacement finish]; source=next; next=nil; navigation=nil;

    request=CSQuickBeginRequest(source); source.view.window=nil;
    source=RouteSource(window); replacement=CSQuickBeginRequest(source);
    Check(replacement && request.cancelled,"a detached source cannot retain a stale request lock");
    [replacement finish];
    UIWindow *orphanWindow=[UIWindow new]; orphanWindow.windowScene=scene;
    CSQuickRouteRequest *orphan;
    @autoreleasepool {
        UIViewController *temporary=RouteSource(orphanWindow); orphan=CSQuickBeginRequest(temporary);
        orphanWindow.rootViewController=nil;
    }
    Check(!orphan.source && ![orphan identityIsCurrent],"a deallocated weak source is not a current request");
    UIViewController *fresh=RouteSource(orphanWindow); replacement=CSQuickBeginRequest(fresh);
    Check(replacement && orphan.cancelled,"a deallocated source does not prevent later requests in the same window");
    [replacement finish];

    request=CSQuickBeginRequest(source); window.windowScene=[UIWindowScene new];
    replacement=CSQuickBeginRequest(source);
    Check(replacement && request.cancelled,"moving the window to another scene evicts the captured scene request");
    [replacement finish];
    request=CSQuickBeginRequest(source); window.windowScene=nil;
    Check(!request.scene && ![request identityIsCurrent],"losing the captured weak scene invalidates a scene-bound request");
    replacement=CSQuickBeginRequest(source);
    Check(replacement && request.cancelled,"losing a scene cannot permanently lock a window");
    [replacement finish];
    request=CSQuickBeginRequest(source); window.windowScene=scene;
    replacement=CSQuickBeginRequest(source);
    Check(replacement && request.cancelled,"attaching a scene invalidates a request originally created without one");
    [replacement finish];

    request=CSQuickBeginRequest(source); authentication=[LAContext new]; request.authentication=authentication;
    __block CSQuickRouteRequest *reentrant=nil;
    authentication.invalidation=^{ reentrant=CSQuickBeginRequest(source); };
    [request finish];
    Check(reentrant && objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==reentrant,
        "finish releases the old lock before LAContext invalidation can reenter the router");
    [request finish];
    Check(authentication.invalidations==1 && [reentrant isCurrent],"idempotent old finish neither invalidates twice nor clears a reentrant replacement");
    [reentrant finish]; authentication.invalidation=nil; reentrant=nil;

    request=CSQuickBeginRequest(source); authentication=[LAContext new]; request.authentication=authentication;
    [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidEnterBackgroundNotification object:scene];
    Check(request.cancelled && authentication.invalidations==1,"the owning scene entering background cancels its authentication request");
    request=CSQuickBeginRequest(source); authentication=[LAContext new]; request.authentication=authentication;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];
    Check(request.cancelled && authentication.invalidations==1,"the application entering background cancels and releases authentication");

    request=CSQuickBeginRequest(source); scene.activationState=UISceneActivationStateUnattached;
    Check(![request identityIsCurrent],"an unattached scene invalidates request identity without a notification");
    scene.activationState=UISceneActivationStateForegroundActive;
    source.isMovingFromParentViewController=YES;
    Check(![request identityIsCurrent],"a source leaving its parent cannot complete authentication navigation");
    source.isMovingFromParentViewController=NO; source.parentViewController.isBeingDismissed=YES;
    Check(![request identityIsCurrent],"a source in a dismissing navigation owner cannot complete authentication navigation");
    source.parentViewController.isBeingDismissed=NO;
    [request finish];
}
int main(void) { @autoreleasepool {
    quickFavoriteSuites=[NSMutableArray new]; quickFavoriteKeys=[NSMutableArray new];
    quickDelayedBlocks=[NSMutableArray new];
    UIViewController *source=[UIViewController new], *home=[UIViewController new];
    UINavigationController *navigation=[UINavigationController new];
    navigation.topViewController=source; navigation.viewControllers=@[home,source];
    source.navigationController=navigation; home.navigationController=navigation;
    NewMainFrameViewController *owner=[NewMainFrameViewController new]; owner.curViewController=home;
    Check(CSQuickMatches(owner,@"onCreateNewMessage","v@:"),"accept the native void action ABI");
    Check(!CSQuickMatches(owner,@"wrongABI","v@:"),"reject an object-returning action ABI");
    Check(!CSQuickMatches(owner,@"missingAction","v@:"),"reject a missing selector");
    Check(CSQuickNativePage(owner)==home,"resolve NSObject native owner through curViewController");
    Check(CSQuickOwnerForAction(@[owner],@"NewMainFrameViewController",@"onCreateNewMessage",source)==owner,
        "allow a native owner earlier in the same source stack");
    Check(!CSQuickOwnerForAction(@[owner],@"NewMainFrameViewController",@"wrongABI",source),"reject an owner with incompatible action ABI");
    UINavigationController *other=[UINavigationController new]; other.viewControllers=@[home]; home.navigationController=other;
    Check(!CSQuickOwnerForAction(@[owner],@"NewMainFrameViewController",@"onCreateNewMessage",source),
        "never invoke an owner belonging to a different tab navigation stack");
    home.navigationController=navigation; navigation.viewControllers=@[source];
    Check(!CSQuickOwnerForAction(@[owner],@"NewMainFrameViewController",@"onCreateNewMessage",source),
        "reject a stale native owner no longer in the navigation stack");
    navigation.viewControllers=@[home,source];
    Check(CSQuickSourcePage(navigation)==source,"resolve the actual navigation top");
    UITabBarController *legacy=[UITabBarController new]; legacy.selectedViewController=navigation;
    Check(CSQuickSourcePage(legacy)==source,"resolve the legacy selected tab without selecting another tab");
    WCTabBarController *modern=[WCTabBarController new]; modern.selectedViewController=navigation;
    Check(CSQuickSourcePage(modern)==source,"resolve the modern UIViewController tab host");
    UIViewController *content=[UIViewController new]; content.parentViewController=source; content.navigationController=navigation;
    Check(CSQuickSourcePage(content)==source,"resolve contained settings content to the native navigation host");
    Check([CSQuickCreatePage(@"NativeWallet") isKindOfClass:NativeWallet.class],"allow inherited init after checking the actual native UIKit class");
    Check(!CSQuickCreatePage(@"NewMainFrameViewController"),"never treat an NSObject owner as a UIKit page");
    Check(!CSQuickCreatePage(@"MissingNativeClass"),"reject a class missing in this WeChat version");
    Check(!CSQuickCreatePage(@"InvalidControllerFactory"),"reject an initializer returning an incompatible object");
    VerifyRequestLifecycle();
    VerifyNewNativeRoutes();
    VerifyFileTransferRoutes();
    VerifyReceiveCodeRoutes();
    VerifyMyMomentsRoutes();
    VerifyChatBackgroundRoutes();
    VerifyAppearanceAndSearchRoutes();
    VerifyCreateNoteAndFavorites();
    VerifySwitchAccountRoutes();
    VerifyPluginRoutes();
    VerifyPublicDispatch();
    printf("Quick panel router: %lu checks passed.\n",(unsigned long)checks);
} return 0; }
