#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSCloseFriendSignatures.h"

// This fixture compiles the unchanged production resolver/factory helpers. It
// verifies ownership and native ABI boundaries without launching WeChat/UIKit.
@class UINavigationController;
@class UIViewController;
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
@property(nonatomic,strong) UIViewController *presentedViewController;
@property(nonatomic,strong) UIView *view;
@property(nonatomic,copy) NSArray *childViewControllers;
@property(nonatomic) BOOL isViewLoaded;
@property(nonatomic) BOOL isBeingDismissed;
@property(nonatomic) BOOL isMovingFromParentViewController;
@property(nonatomic) BOOL hidesBottomBarWhenPushed;
@property(nonatomic,strong) id<UIViewControllerTransitionCoordinator> transitionCoordinator;
@end
@implementation UIViewController
- (instancetype)init {
    if ((self=[super init])) { _view=[UIView new]; _isViewLoaded=YES; _childViewControllers=@[]; }
    return self;
}
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) UIViewController *topViewController;
@property(nonatomic,copy) NSArray *viewControllers;
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;
@end
@implementation UINavigationController
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    controller.navigationController=self; controller.parentViewController=self;
    controller.view.window=self.topViewController.view.window;
    self.topViewController=controller;
    self.viewControllers=[(self.viewControllers ?: @[]) arrayByAddingObject:controller];
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
- (id)wrongABI;
@end
@implementation NewMainFrameViewController
- (void)onCreateNewMessage { self.createCalls++; }
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
@interface NativeWallet : UIViewController @end
@implementation NativeWallet @end
@interface InvalidControllerFactory : UIViewController @end
@implementation InvalidControllerFactory
- (instancetype)init { self=[super init]; return self ? (id)[NSObject new] : nil; }
@end
@interface LAContext : NSObject
@property(nonatomic) NSUInteger invalidations;
@property(nonatomic,copy) void (^invalidation)(void);
- (void)invalidate;
@end
@implementation LAContext
- (void)invalidate {
    self.invalidations++;
    if (self.invalidation) self.invalidation();
}
@end

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
static id quickAppManager;
@interface CAppViewControllerManager : NSObject
@property(nonatomic,weak) UIWindow *mainWindow;
@property(nonatomic,weak) UIViewController *entrySource;
@property(nonatomic) NSUInteger paymentCalls;
@property(nonatomic,strong) id mainFrame;
+ (id)getAppViewControllerManager;
- (id)getNewMainFrameViewController;
- (id)getMainWindow;
- (void)jumpToOfflinePayWithEntryVC:(id)source;
@end
@implementation CAppViewControllerManager
+ (id)getAppViewControllerManager { return quickAppManager; }
- (id)getMainWindow { return self.mainWindow; }
- (id)getNewMainFrameViewController { return self.mainFrame; }
- (void)jumpToOfflinePayWithEntryVC:(id)source { self.paymentCalls++; self.entrySource=source; }
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

static char CSQuickRouteRequestKey;
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

static BOOL CSQuickFailure(UIViewController *source, NSString *message);
#import "QuickPanelRouterProduction.h"

static NSString *quickPublicStub;
static NSString *quickFailureMessage;
static BOOL CSQuickFailure(UIViewController *source, NSString *message) { quickFailureMessage=message; return NO; }
static BOOL CSQuickOpenPlugin(CSQuickRouteRequest *request, BOOL settings) {
    quickPublicStub=settings ? @"panel_settings" : @"plugin_home"; [request finish]; return YES;
}
static BOOL CSQuickOpenFavorites(CSQuickRouteRequest *request) {
    quickPublicStub=@"favorites"; [request finish]; return YES;
}
@interface CSQuickPanelActionRouter : NSObject
+ (BOOL)performActionWithIdentifier:(NSString *)identifier fromViewController:(UIViewController *)source;
@end
#import "QuickPanelRouterPublicProduction.h"
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
    BOOL (*routes[])(CSQuickRouteRequest *)={CSQuickOpenQRCode,CSQuickOpenPaymentCode,CSQuickOpenChannels,CSQuickOpenFileTransfer,CSQuickOpenChatBackground};
    for (NSUInteger index=0; index<sizeof(routes)/sizeof(routes[0]); index++)
        Check(!routes[index](request),"a finished request cannot invoke a QR, payment, channels file-transfer or chat-background native route");
    request=CSQuickBeginRequest(source); window.windowScene=[UIWindowScene new];
    for (NSUInteger index=0; index<sizeof(routes)/sizeof(routes[0]); index++)
        Check(!routes[index](request),"a request from a replaced scene cannot invoke any of the five routes");
    [request finish];
    legacyQRCodeContact=nil; finderParams=nil; quickAppManager=nil; quickContext=nil;
}
static void VerifyPublicDispatch(void) {
    NSDictionary *pages=@{@"scan":@"CameraScanViewController",@"wallet":@"WCPayMainViewControllerV2",@"moments":@"WCTimeLineViewController",
        @"my_qrcode":@"CameraQRCodeListViewController",@"profile":@"SettingMyProfileViewController",@"add_friend":@"AddFriendEntryViewController",@"emoji_store":@"MMEmotionStoreViewController",@"chat_background":@"ChatBackgroundEntranceViewController"};
    for (NSString *name in pages.allValues) if (!NSClassFromString(name)) {
        Class cls=objc_allocateClassPair(UIViewController.class,name.UTF8String,0); objc_registerClassPair(cls);
    }
    NSSet *expected=[NSSet setWithArray:@[@"scan",@"wallet",@"moments",@"my_qrcode",@"favorites",@"plugin_home",@"profile",@"create_group",@"add_friend",@"emoji_store",@"panel_settings",@"payment_code",@"channels",@"file_transfer",@"chat_background"]];
    Check(QuickPreferenceIDs().count==15 && [[NSSet setWithArray:QuickPreferenceIDs()] isEqual:expected],"all 15 production preference identifiers agree with the router dispatch contract");
    UIWindow *window=[UIWindow new]; window.windowScene=[UIWindowScene new];
    CContactMgr *contacts=[CContactMgr new]; contacts.fileContact=Contact(@"filehelper");
    MMMsgLogicManager *messages=[MMMsgLogicManager new]; QuickServiceCenter *center=[QuickServiceCenter new];
    center.services=@{@"CContactMgr":contacts,@"MMMsgLogicManager":messages}; quickContext=center;
    CAppViewControllerManager *manager=[CAppViewControllerManager new]; manager.mainWindow=window; quickAppManager=manager;
    for (NSString *identifier in QuickPreferenceIDs()) {
        UIViewController *source=RouteSource(window); quickPublicStub=nil; quickFailureMessage=nil;
        NewMainFrameViewController *home=[NewMainFrameViewController new]; home.curViewController=source;
        manager.mainFrame=home;
        if ([identifier isEqual:@"create_group"]) source.navigationController.childViewControllers=@[home];
        NSUInteger oldFinderPushes=finderPushes, oldPaymentCalls=manager.paymentCalls, oldMessages=home.messageCalls;
        Check([CSQuickPanelActionRouter performActionWithIdentifier:identifier fromViewController:source],[[NSString stringWithFormat:@"the actual public performAction accepts configured identifier %@",identifier] UTF8String]);
        BOOL routed=NO;
        if (pages[identifier]) routed=[source.navigationController.topViewController isKindOfClass:NSClassFromString(pages[identifier])];
        else if ([identifier isEqual:@"create_group"]) routed=home.createCalls==1;
        else if ([identifier isEqual:@"payment_code"]) routed=manager.paymentCalls==oldPaymentCalls+1 && manager.entrySource==source;
        else if ([identifier isEqual:@"channels"]) routed=finderPushes==oldFinderPushes+1 && finderParams.fromVC==source && finderParams.byPush;
        else if ([identifier isEqual:@"file_transfer"]) routed=home.messageCalls==oldMessages+1 && home.lastContact==contacts.fileContact && home.lastMessageWrap==nil && CSQuickChatIsFileHelper(source.navigationController.topViewController) && messages.pushes==0;
        else routed=[quickPublicStub isEqual:identifier];
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
    VerifyChatBackgroundRoutes();
    VerifyPublicDispatch();
    printf("Quick panel router: %lu checks passed.\n",(unsigned long)checks);
} return 0; }
