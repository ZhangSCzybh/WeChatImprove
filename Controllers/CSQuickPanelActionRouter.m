#import "CSQuickPanelActionRouter.h"
#import "CSAuthorizationManager.h"
#import "CSBackupBootstrap.h"
#import "CSCloseFriendBridge.h"
#import "CSGroupNativeBridge.h"
#import "CSNativeSettingsHost.h"
#import "CSQuickPanelSettingsViewController.h"
#import "CSSettingsPresentation.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <objc/message.h>
#import <objc/runtime.h>

static char CSQuickRouteRequestKey;
static NSString * const CSQuickFavoriteSuite = @"com.cyansmoke.wechattweak";
static NSString * const CSQuickFavoriteAuthKey = @"com.wechat.tweak.biometric.auth.favorite";

@protocol CSQuickQRCodeConstructor <NSObject>
- (instancetype)initWithContact:(id)contact;
@end
@protocol CSQuickFinderParamsConstructor <NSObject>
- (instancetype)initFromFindPageClick;
@end

// The account service center can return MMServiceWrapper:NSProxy. Its forwarding
// installs the service account context, so retain the wrapper as the receiver.
// Only a wrapper returned by our checked service lookup can borrow its requested
// concrete class's ABI; arbitrary proxy signatures are not evidence.
static char CSQuickServiceClassKey;
static BOOL CSQuickClassDescendsFrom(Class cls, Class ancestor) {
    if (!ancestor) return NO;
    for (; cls; cls=class_getSuperclass(cls)) if (cls==ancestor) return YES;
    return NO;
}
static BOOL CSQuickIsServiceWrapper(id object) {
    Class wrapper=NSClassFromString(@"MMServiceWrapper");
    return CSQuickClassDescendsFrom(object_getClass(object),wrapper) && CSQuickClassDescendsFrom(wrapper,NSProxy.class);
}
static BOOL CSQuickMatches(id object, NSString *name, const char *types) {
    if (!object) return NO;
    Class cls=CSQuickIsServiceWrapper(object) ? objc_getAssociatedObject(object,&CSQuickServiceClassKey) : object_getClass(object);
    return cls && CSCloseFriendMethodMatches(class_getInstanceMethod(cls,NSSelectorFromString(name)),types);
}
static id CSQuickRead(id object, NSString *name) {
    if (!CSQuickMatches(object,name,"@@:")) return nil;
    return ((id (*)(id,SEL))objc_msgSend)(object,NSSelectorFromString(name));
}
static BOOL CSQuickIsClass(id object, NSString *name) {
    Class cls=NSClassFromString(name);
    return cls && [object isKindOfClass:cls];
}
static UIViewController *CSQuickNativePage(id object) {
    if ([object isKindOfClass:UIViewController.class]) return object;
    id page=CSQuickRead(object,@"curViewController") ?: CSQuickRead(object,@"associateViewController");
    return [page isKindOfClass:UIViewController.class] ? page : nil;
}
static UIViewController *CSQuickSourcePage(UIViewController *source) {
    for (NSUInteger depth=0; source && depth<20; depth++) {
        UIViewController *child=nil;
        if ([source isKindOfClass:UINavigationController.class]) child=[(UINavigationController *)source topViewController];
        else if ([source isKindOfClass:UITabBarController.class]) child=[(UITabBarController *)source selectedViewController];
        else if (CSQuickIsClass(source,@"WCTabBarController")) {
            id selected=CSQuickRead(source,@"selectedViewController");
            if ([selected isKindOfClass:UIViewController.class]) child=selected;
        }
        if (!child || child==source) break;
        source=child;
    }
    // A settings content controller can be contained by a native MMUIViewController.
    UIViewController *top=source.navigationController.topViewController;
    for (UIViewController *owner=source; owner; owner=owner.parentViewController)
        if (owner==top) return top;
    return source;
}
static BOOL CSQuickCanNavigate(UIViewController *source) {
    if (!CSSettingsCanPresentFrom(source) || !CSBackupIsReady() || CSBackupAccountIsSuspended() ||
        UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) return NO;
    if (source.transitionCoordinator || source.navigationController.transitionCoordinator) return NO;
    UIWindowScene *scene=source.view.window.windowScene;
    return !scene || scene.activationState==UISceneActivationStateForegroundActive;
}
static BOOL CSQuickFailure(UIViewController *source, NSString *message) {
    if (CSSettingsCanPresentFrom(source) && !source.transitionCoordinator && !source.navigationController.transitionCoordinator) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"暂时无法打开" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [source presentViewController:alert animated:YES completion:nil];
    }
    return NO;
}
static UIViewController *CSQuickCreatePage(NSString *name) {
    Class cls=NSClassFromString(name);
    if (![cls isSubclassOfClass:UIViewController.class] ||
        !CSCloseFriendMethodMatches(class_getInstanceMethod(cls,@selector(init)),"@@:")) return nil;
    // Check the real UIKit superclass and initializer ABI in this build.
    // Each contextual destination also validates its required native defaults.
    id page=[[cls alloc] init];
    return [page isKindOfClass:cls] ? page : nil;
}
static BOOL CSQuickPush(UIViewController *page, UIViewController *source) {
    UINavigationController *navigation=source.navigationController;
    if (!page || !navigation || !CSQuickCanNavigate(source)) return NO;
    page.hidesBottomBarWhenPushed=YES;
    [navigation pushViewController:page animated:YES];
    return navigation.topViewController==page;
}

// Inspect only the supplied window's existing owners. The modern main-frame
// owner can live outside UIKit children; bind the app manager to this exact
// window before accepting its owner. This lookup never selects a tab.
static NSArray<id> *CSQuickOwners(UIViewController *source) {
    NSMutableArray *owners=[NSMutableArray array], *queue=[NSMutableArray array];
    NSHashTable *visited=[NSHashTable hashTableWithOptions:NSPointerFunctionsObjectPointerPersonality];
    if (source) [queue addObject:source];
    if (source.view.window.rootViewController) [queue addObject:source.view.window.rootViewController];
    id manager=CSQuickRead(NSClassFromString(@"CAppViewControllerManager"),@"getAppViewControllerManager");
    if (source.view.window && CSQuickRead(manager,@"getMainWindow")==source.view.window) [queue addObject:manager];
    for (NSUInteger index=0; index<queue.count && index<128; index++) {
        id object=queue[index];
        if ([visited containsObject:object]) continue;
        [visited addObject:object]; [owners addObject:object];
        if ([object isKindOfClass:UIViewController.class]) {
            UIViewController *controller=object;
            if (controller.parentViewController) [queue addObject:controller.parentViewController];
            [queue addObjectsFromArray:controller.childViewControllers];
        }
        id main=CSQuickRead(object,@"getNewMainFrameViewController");
        if (CSQuickIsClass(main,@"NewMainFrameViewController")) [queue addObject:main];
    }
    return owners;
}
static id CSQuickOwnerForAction(NSArray *owners, NSString *className, NSString *selector, UIViewController *source) {
    for (id owner in owners) {
        if (!CSQuickIsClass(owner,className) || !CSQuickMatches(owner,selector,"v@:")) continue;
        UIViewController *page=CSQuickNativePage(owner);
        // A native owner may be earlier in the same navigation stack. A method
        // on a different tab would push into that tab and is deliberately excluded.
        if (page && page.navigationController==source.navigationController && source.navigationController &&
            [source.navigationController.viewControllers containsObject:page]) return owner;
    }
    return nil;
}
static BOOL CSQuickInvokeAction(id owner, NSString *name) {
    if (!CSQuickMatches(owner,name,"v@:")) return NO;
    ((void (*)(id,SEL))objc_msgSend)(owner,NSSelectorFromString(name));
    return YES;
}

@interface CSQuickRouteRequest : NSObject
@property(nonatomic,weak) UIViewController *source;
@property(nonatomic,weak) UIWindow *window;
@property(nonatomic,weak) UIWindowScene *scene;
@property(nonatomic) BOOL sceneBound;
@property(nonatomic,copy) NSString *account;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) BOOL cancelled;
@property(nonatomic) BOOL awaitingNavigation;
@property(nonatomic,strong) LAContext *authentication;
- (BOOL)isCurrent;
- (BOOL)identityIsCurrent;
- (BOOL)windowIdentityIsCurrent;
- (void)finish;
@end
@implementation CSQuickRouteRequest
- (BOOL)isCurrent {
    return [self identityIsCurrent] && CSQuickCanNavigate(self.source);
}
- (BOOL)windowIdentityIsCurrent {
    UIWindow *window=self.window;
    UIWindowScene *scene=self.scene;
    return !self.cancelled && window && window.windowScene==scene &&
        (!self.sceneBound || (scene && scene.activationState!=UISceneActivationStateUnattached)) &&
        !CSBackupAccountIsSuspended() && self.epoch==CSBackupAccountEpoch() &&
        [self.account isEqual:CSGroupCurrentAccountID()] && objc_getAssociatedObject(window,&CSQuickRouteRequestKey)==self;
}
- (BOOL)identityIsCurrent {
    UIViewController *source=self.source;
    UIWindow *window=self.window;
    UIWindowScene *scene=self.scene;
    if (self.cancelled || !source || !window || !source.isViewLoaded || source.view.window!=window ||
        window.windowScene!=scene || (self.sceneBound && (!scene || scene.activationState==UISceneActivationStateUnattached)) ||
        (source.navigationController && source.navigationController.topViewController!=source)) return NO;
    for (UIViewController *owner=source; owner; owner=owner.parentViewController)
        if (owner.isBeingDismissed || owner.isMovingFromParentViewController) return NO;
    // A password alert or biometric prompt may still be active. Identity checks
    // preserve that live request; isCurrent also requires navigable UI at handoff.
    return [self windowIdentityIsCurrent];
}
- (void)invalidated:(NSNotification *)notification {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self finish]; }); return; }
    [self finish];
}
- (void)finish {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self finish]; }); return; }
    LAContext *authentication=self.authentication;
    self.cancelled=YES;
    [NSNotificationCenter.defaultCenter removeObserver:self];
    if (objc_getAssociatedObject(self.window,&CSQuickRouteRequestKey)==self)
        objc_setAssociatedObject(self.window,&CSQuickRouteRequestKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.authentication=nil;
    // Release the lock before invalidating: cancellation can deliver the old
    // authentication callback while a replacement request is already starting.
    [authentication invalidate];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; [_authentication invalidate]; }
@end

static CSQuickRouteRequest *CSQuickBeginRequest(UIViewController *source) {
    if (!CSQuickCanNavigate(source) || !CSGroupCurrentAccountID().length) return nil;
    UIWindow *window=source.view.window;
    CSQuickRouteRequest *previous=objc_getAssociatedObject(window,&CSQuickRouteRequestKey);
    if (previous) {
        if ([previous identityIsCurrent] || (previous.awaitingNavigation && [previous windowIdentityIsCurrent])) return nil;
        [previous finish];
    }
    CSQuickRouteRequest *request=[CSQuickRouteRequest new];
    request.source=source; request.window=window;
    request.scene=window.windowScene; request.sceneBound=window.windowScene!=nil;
    request.account=CSGroupCurrentAccountID(); request.epoch=CSBackupAccountEpoch();
    objc_setAssociatedObject(window,&CSQuickRouteRequestKey,request,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // Biometric prompts can temporarily deactivate a scene. Background, scene
    // disconnection and account boundaries cancel; deactivation alone does not.
    [NSNotificationCenter.defaultCenter addObserver:request selector:@selector(invalidated:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:request selector:@selector(invalidated:) name:@"CSBackupAccountChanged" object:nil];
    if (request.scene) {
        [NSNotificationCenter.defaultCenter addObserver:request selector:@selector(invalidated:) name:UISceneDidEnterBackgroundNotification object:request.scene];
        [NSNotificationCenter.defaultCenter addObserver:request selector:@selector(invalidated:) name:UISceneDidDisconnectNotification object:request.scene];
    }
    return request;
}
static BOOL CSQuickOpenClass(NSString *name, UIViewController *source) {
    UIViewController *page=CSQuickCreatePage(name);
    return CSQuickPush(page,source);
}
static void CSQuickAfterPrivacyAuthentication(CSQuickRouteRequest *request, void (^completion)(void)) {
    if (![request identityIsCurrent]) { [request finish]; return; }
    UIViewController *modal=request.source.presentedViewController;
    // CSCloseFriendManager.passwordPrompt calls its continuation from the
    // UIAlertAction before UIKit has finished dismissing that exact alert.
    if ([modal isKindOfClass:UIAlertController.class] &&
        ([((UIAlertController *)modal).title isEqual:@"验证密友密码"] || [((UIAlertController *)modal).title isEqual:@"设置密友密码"])) {
        CSSettingsAfterDismissingSheet((UIAlertController *)modal, ^{
            if ([request isCurrent]) completion(); else [request finish];
        });
    } else if ([request isCurrent]) completion();
    else [request finish];
}
static BOOL CSQuickOpenCreateNote(CSQuickRouteRequest *request) {
    if (![request isCurrent]) return NO;
    id manager=CSQuickRead(NSClassFromString(@"CAppViewControllerManager"),@"getAppViewControllerManager");
    // This native entry has no fromVC parameter. Bind both the manager's window
    // and its current top to this request before letting WeChat build the editor.
    if (CSQuickRead(manager,@"getMainWindow")!=request.window ||
        !CSQuickMatches(manager,@"jumpToWriteNote","v@:")) return NO;
    id top=CSQuickRead(manager,@"getTopViewController");
    if (![top isKindOfClass:UIViewController.class] || CSQuickSourcePage(top)!=request.source) return NO;
    return [request isCurrent] && CSQuickInvokeAction(manager,@"jumpToWriteNote");
}
static BOOL CSQuickOpenFavoriteContent(CSQuickRouteRequest *request, BOOL createNote) {
    UIViewController *source=request.source;
    if (![request isCurrent]) { [request finish]; return NO; }
    NSString *destination=createNote ? @"新建笔记" : @"收藏";
    NSString *nativePath=createNote ? @"我 → 收藏 → ＋" : @"我 → 收藏";
    BOOL protected=[[[NSUserDefaults alloc] initWithSuiteName:CSQuickFavoriteSuite] boolForKey:CSQuickFavoriteAuthKey];
    if (!protected) {
        BOOL opened=createNote ? CSQuickOpenCreateNote(request) : CSQuickOpenClass(@"MyFavoritesViewController",source);
        [request finish];
        return opened || CSQuickFailure(source,[NSString stringWithFormat:@"当前微信的%@页面未通过兼容检查，请从“%@”打开。",destination,nativePath]);
    }
    // Match FavoriteHooks.xm's suite, key and exact authentication policy. A
    // new-note shortcut also stays behind the user's existing favorites guard.
    LAContext *context=[LAContext new]; request.authentication=context;
    NSError *error=nil;
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [request finish];
        return CSQuickFailure(source,@"收藏已开启生物识别保护，请先在系统中设置可用的面容 ID 或触控 ID。");
    }
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证您的身份以查看收藏内容" reply:^(BOOL success,NSError *failure) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL current=[request isCurrent];
            BOOL stillProtected=[[[NSUserDefaults alloc] initWithSuiteName:CSQuickFavoriteSuite] boolForKey:CSQuickFavoriteAuthKey];
            if (success && current && stillProtected) {
                @try {
                    BOOL opened=createNote ? CSQuickOpenCreateNote(request) : CSQuickOpenClass(@"MyFavoritesViewController",source);
                    if (!opened)
                        CSQuickFailure(source,[NSString stringWithFormat:@"验证已完成，但当前微信未能打开%@。请从“%@”重试。",destination,nativePath]);
                } @catch (__unused NSException *exception) {
                    CSQuickFailure(source,[NSString stringWithFormat:@"微信%@页面未完成打开，请返回后从原生入口重试。",destination]);
                }
            } else if (!success && current && failure.code!=LAErrorUserCancel && failure.code!=LAErrorSystemCancel && failure.code!=LAErrorAppCancel) {
                CSQuickFailure(source,@"未通过收藏的生物识别验证，请重试或使用原生收藏入口。");
            }
            [request finish];
        });
    }];
    return YES;
}
static BOOL CSQuickOpenPlugin(CSQuickRouteRequest *request, BOOL settings) {
    UIViewController *source=request.source;
    if (![request isCurrent]) { [request finish]; return NO; }
    if (CSCloseFriendPluginEntryHidden()) {
        CSCloseFriendAuthenticate(source,^(BOOL accepted) {
            if (!accepted) { [request finish]; return; }
            CSQuickAfterPrivacyAuthentication(request, ^{
                if (CSCloseFriendPluginEntryHidden()) { [request finish]; return; }
                @try { CSQuickOpenPlugin(request,settings); }
                @catch (__unused NSException *exception) { [request finish]; CSQuickFailure(source,@"插件页面未完成打开，请从原有插件入口重试。"); }
            });
        });
        return YES;
    }
    CSAuthorizationManager *authorization=CSAuthorizationManager.sharedManager;
    if (!authorization.isAuthorized) {
        [authorization requestAuthorizationWithPresentingViewController:source completion:^(BOOL accepted,NSString *message) {
            if (accepted && [request isCurrent] && authorization.isAuthorized) {
                @try { CSQuickOpenPlugin(request,settings); }
                @catch (__unused NSException *exception) { [request finish]; CSQuickFailure(source,@"插件页面未完成打开，请从原有插件入口重试。"); }
            } else [request finish];
        }];
        return YES;
    }
    UIViewController *page=settings ? [[CSQuickPanelSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped] : [[CSNativeSettingsControllerClass() alloc] init];
    if (![request isCurrent]) { [request finish]; return NO; }
    BOOL opened=NO;
    if (settings) {
        opened=CSQuickPush(page,source);
    } else if (page) {
        // Match the established plugin entries: a native settings host owns
        // its own navigation container, rather than inheriting WeChat's push
        // transition and its changing navigation/safe-area geometry.
        UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:page];
        navigation.modalPresentationStyle=UIModalPresentationFormSheet;
        if (![request isCurrent]) { [request finish]; return NO; }
        [source presentViewController:navigation animated:YES completion:nil];
        opened=source.presentedViewController==navigation || navigation.presentingViewController!=nil;
    }
    [request finish];
    return opened || CSQuickFailure(source,@"当前页面无法打开插件设置，请返回微信首页后重试。");
}
static id CSQuickCurrentService(CSQuickRouteRequest *request, NSString *name) {
    if (![request isCurrent]) return nil;
    // An authoritative nil current context means logged out. Never fall back
    // to defaultCenter, which may retain a different account's service.
    id context=CSQuickRead(NSClassFromString(@"MMContext"),@"currentContext");
    if (!context) return nil;
    id center=context;
    if (!CSQuickMatches(center,@"getService:","@@:#") && !CSQuickMatches(center,@"getService:","@@:@"))
        center=CSQuickRead(context,@"serviceCenter");
    Class serviceClass=NSClassFromString(name);
    if (!serviceClass || (!CSQuickMatches(center,@"getService:","@@:#") && !CSQuickMatches(center,@"getService:","@@:@"))) return nil;
    id service=((id (*)(id,SEL,Class))objc_msgSend)(center,NSSelectorFromString(@"getService:"),serviceClass);
    if (![request isCurrent]) return nil;
    if (CSQuickIsServiceWrapper(service)) {
        Class registered=objc_getAssociatedObject(service,&CSQuickServiceClassKey);
        if (registered && registered!=serviceClass) return nil;
        objc_setAssociatedObject(service,&CSQuickServiceClassKey,serviceClass,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return service;
    }
    return CSQuickClassDescendsFrom(object_getClass(service),serviceClass) ? service : nil;
}
static BOOL CSQuickToggleDarkMode(CSQuickRouteRequest *request) {
    if (![request isCurrent]) return NO;
    Class config=NSClassFromString(@"MMDarkModeConfigUtil");
    if (!CSQuickMatches(config,@"isDarkMode","B@:")) return NO;
    id manager=CSQuickCurrentService(request,@"DarkModeManager");
    if (!CSQuickMatches(manager,@"changeDarkModeConfigType:","v@:q") || ![request isCurrent]) return NO;
    BOOL dark=((_Bool (*)(id,SEL))objc_msgSend)(config,NSSelectorFromString(@"isDarkMode"));
    if (![request isCurrent]) return NO;
    // WeChat 8.0.80's native selections use 1=dark and 2=light. Read the
    // effective appearance so a follow-system configuration toggles correctly.
    // The account service persists this explicit choice and updates its
    // windows just like the native settings page.
    ((void (*)(id,SEL,long long))objc_msgSend)(manager,NSSelectorFromString(@"changeDarkModeConfigType:"),dark ? 2 : 1);
    return YES;
}
static BOOL CSQuickOpenQRCode(CSQuickRouteRequest *request) {
    if (![request isCurrent]) return NO;
    // Neo's shipped my_qrcode route uses this page with init. Some WeChat
    // builds retain the older contact initializer, so keep it as a checked fallback.
    UIViewController *page=CSQuickCreatePage(@"CameraQRCodeListViewController");
    if (page) return [request isCurrent] && CSQuickPush(page,request.source);
    Class cls=NSClassFromString(@"NewPersonalQRCodeViewController");
    if (![cls isSubclassOfClass:UIViewController.class] ||
        !CSCloseFriendMethodMatches(class_getInstanceMethod(cls,NSSelectorFromString(@"initWithContact:")),"@@:@")) return NO;
    id manager=CSQuickCurrentService(request,@"CContactMgr");
    id contact=CSQuickRead(manager,@"getSelfContact");
    if (![CSQuickRead(contact,@"m_nsUsrName") isEqual:request.account] || ![request isCurrent]) return NO;
    // Keep ARC's init-family ownership contract, including a native initializer
    // that substitutes a different object. The signature was checked above.
    id legacyPage=[(id<CSQuickQRCodeConstructor>)[cls alloc] initWithContact:contact];
    return [legacyPage isKindOfClass:cls] && [request isCurrent] && CSQuickPush(legacyPage,request.source);
}
static BOOL CSQuickOpenPaymentCode(CSQuickRouteRequest *request) {
    if (![request isCurrent]) return NO;
    id manager=CSQuickRead(NSClassFromString(@"CAppViewControllerManager"),@"getAppViewControllerManager");
    // The dedicated native entry retains wallet-lock and regional payment
    // routing. A plain wallet page is not the user's payment-code destination.
    if (CSQuickRead(manager,@"getMainWindow")!=request.window ||
        !CSQuickMatches(manager,@"jumpToOfflinePayWithEntryVC:","v@:@") || ![request isCurrent]) return NO;
    ((void (*)(id,SEL,id))objc_msgSend)(manager,NSSelectorFromString(@"jumpToOfflinePayWithEntryVC:"),request.source);
    return YES;
}
static BOOL CSQuickOpenChannels(CSQuickRouteRequest *request) {
    if (![request isCurrent] || !request.source.navigationController) return NO;
    Class paramsClass=NSClassFromString(@"WCFinderOpenTimelineParams");
    Class routerClass=NSClassFromString(@"WCFinderRouterHelper");
    if (!paramsClass || !CSCloseFriendMethodMatches(class_getInstanceMethod(paramsClass,NSSelectorFromString(@"initFromFindPageClick")),"@@:") ||
        !CSQuickMatches(routerClass,@"jumpToFinderTimelineByPushWithParams:","v@:@")) return NO;
    id params=[(id<CSQuickFinderParamsConstructor>)[paramsClass alloc] initFromFindPageClick];
    if (![params isKindOfClass:paramsClass] || !CSQuickMatches(params,@"setFromVC:","v@:@") ||
        !CSQuickMatches(params,@"setByPush:","v@:B")) return NO;
    ((void (*)(id,SEL,id))objc_msgSend)(params,NSSelectorFromString(@"setFromVC:"),request.source);
    ((void (*)(id,SEL,_Bool))objc_msgSend)(params,NSSelectorFromString(@"setByPush:"),YES);
    // Use native Find-page defaults for scene/tab policy, then explicitly push
    // from this source. Never construct a timeline with an invented tab number.
    if (![request isCurrent]) return NO;
    ((void (*)(id,SEL,id))objc_msgSend)(routerClass,NSSelectorFromString(@"jumpToFinderTimelineByPushWithParams:"),params);
    return YES;
}
static BOOL CSQuickRouteWindowIsActive(CSQuickRouteRequest *request) {
    return [request windowIdentityIsCurrent] && UIApplication.sharedApplication.applicationState==UIApplicationStateActive &&
        (!request.scene || request.scene.activationState==UISceneActivationStateForegroundActive);
}
static BOOL CSQuickOpenMainFrameAction(CSQuickRouteRequest *request, NSString *selector) {
    if (![request isCurrent] || !request.source.navigationController) return NO;
    NSArray *owners=CSQuickOwners(request.source);
    id main=CSQuickOwnerForAction(owners,@"NewMainFrameViewController",selector,request.source);
    // Keep native destination initialization and delegates on the existing
    // account-bound main owner. Callers supply fixed, checked native actions.
    if (main) return [request isCurrent] && CSQuickInvokeAction(main,selector);

    // As with filehelper, another main tab may own the gesture. Only hand off
    // to the first WeChat tab inside this exact window's existing tab container.
    for (id candidate in owners) {
        if (!CSQuickIsClass(candidate,@"NewMainFrameViewController") || !CSQuickMatches(candidate,selector,"v@:")) continue;
        UIViewController *page=CSQuickNativePage(candidate);
        UINavigationController *navigation=page.navigationController;
        if (!navigation || navigation==request.source.navigationController || ![navigation.viewControllers containsObject:page]) continue;
        UITabBarController *tab=nil;
        for (id owner in owners) {
            if (![owner isKindOfClass:UITabBarController.class]) continue;
            UITabBarController *container=owner;
            if (container.isViewLoaded && container.view.window==request.window &&
                container.selectedViewController==request.source.navigationController &&
                container.viewControllers.firstObject==navigation &&
                [container.viewControllers containsObject:request.source.navigationController]) { tab=container; break; }
        }
        if (!tab || ![request isCurrent]) continue;
        UIViewController *before=navigation.topViewController;
        if (!before || before.presentedViewController || before.transitionCoordinator || navigation.transitionCoordinator ||
            before.isBeingDismissed || before.isMovingFromParentViewController) continue;
        UIViewController *previousTab=tab.selectedViewController;
        tab.selectedIndex=0;
        UIViewController *visible=navigation.topViewController;
        BOOL ready=CSQuickRouteWindowIsActive(request) && tab.selectedViewController==navigation &&
            request.source.navigationController.topViewController==request.source &&
            CSQuickNativePage(candidate)==page && page.navigationController==navigation &&
            [navigation.viewControllers containsObject:page] && visible==before &&
            visible.view.window==request.window && CSQuickCanNavigate(visible);
        if (ready) return CSQuickInvokeAction(candidate,selector);
        // Restore only a rejected preflight. Once native navigation is called,
        // its asynchronous work or verification page owns the handoff.
        if (CSQuickRouteWindowIsActive(request) && tab.selectedViewController==navigation &&
            navigation.topViewController==before && !before.presentedViewController &&
            !before.transitionCoordinator && !navigation.transitionCoordinator &&
            !before.isBeingDismissed && !before.isMovingFromParentViewController &&
            previousTab==request.source.navigationController && request.source.navigationController.topViewController==request.source)
            tab.selectedViewController=previousTab;
        return NO;
    }
    return NO;
}
static BOOL CSQuickOpenReceiveCode(CSQuickRouteRequest *request) {
    return CSQuickOpenMainFrameAction(request,@"openFace2FaceReceiveMoney");
}
static BOOL CSQuickOpenGlobalSearch(CSQuickRouteRequest *request) {
    // The native button prepares the full FTS context and search presenter.
    // A bare search controller would miss that lifecycle and its cancel route.
    return CSQuickOpenMainFrameAction(request,@"onSearchButtonTapped");
}
static BOOL CSQuickOpenMyMoments(CSQuickRouteRequest *request) {
    // Native "My WC" owns the current-account album setup. A fresh public
    // WCTimeLineViewController would instead open the friends' timeline.
    return CSQuickOpenMainFrameAction(request,@"showMyWCView");
}
static BOOL CSQuickChatIsFileHelper(UIViewController *page) {
    if (!CSQuickIsClass(page,@"BaseMsgContentViewController")) return NO;
    for (NSString *selector in @[@"GetCContact",@"GetContact",@"getChatContact"]) {
        id contact=CSQuickRead(page,selector);
        if (contact) return CSQuickIsClass(contact,@"CContact") && [CSQuickRead(contact,@"m_nsUsrName") isEqual:@"filehelper"];
    }
    // On modern WeChat the chat page delegates to BaseMsgContentLogicController.
    // A cached logic for another page must not prove that the visible chat opened.
    id logic=CSQuickRead(page,@"m_delegate") ?: CSQuickRead(page,@"m_logicController") ?: CSQuickRead(page,@"logicController");
    if (!CSQuickIsClass(logic,@"BaseMsgContentLogicController") || CSQuickRead(logic,@"getViewController")!=page) return NO;
    id contact=CSQuickRead(logic,@"GetContact");
    return CSQuickIsClass(contact,@"CContact") && [CSQuickRead(contact,@"m_nsUsrName") isEqual:@"filehelper"];
}
static BOOL CSQuickFileTransferOpened(CSQuickRouteRequest *request, UINavigationController *navigation, UITabBarController *tab) {
    UIViewController *page=navigation.topViewController;
    return CSQuickRouteWindowIsActive(request) && (!tab || tab.selectedViewController==navigation) &&
        page.isViewLoaded && page.view.window==request.window && CSQuickChatIsFileHelper(page);
}
static void CSQuickCompleteFileTransfer(CSQuickRouteRequest *request, UINavigationController *navigation, UITabBarController *tab) {
    @try {
        if (!CSQuickRouteWindowIsActive(request)) { [request finish]; return; }
        BOOL opened=CSQuickFileTransferOpened(request,navigation,tab);
        BOOL stillSelected=!tab || tab.selectedViewController==navigation;
        UIViewController *visible=CSQuickSourcePage(request.window.rootViewController);
        [request finish];
        if (!opened && stillSelected) CSQuickFailure(visible,@"文件传输助手尚未完成打开，请从微信首页搜索“文件传输助手”进入。");
    } @catch (__unused NSException *exception) { [request finish]; }
}
static void CSQuickAwaitFileTransfer(CSQuickRouteRequest *request, UINavigationController *navigation, UITabBarController *tab) {
    request.awaitingNavigation=YES;
    // Native may enqueue its push on the main queue. Observe that handoff before
    // evaluating the destination, then let an active native transition finish.
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            if (!CSQuickRouteWindowIsActive(request)) { [request finish]; return; }
            if (CSQuickFileTransferOpened(request,navigation,tab)) { [request finish]; return; }
            id<UIViewControllerTransitionCoordinator> transition=navigation.transitionCoordinator ?: navigation.topViewController.transitionCoordinator;
            if (transition && [transition animateAlongsideTransition:nil completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
                CSQuickCompleteFileTransfer(request,navigation,tab);
            }]) return;
            CSQuickCompleteFileTransfer(request,navigation,tab);
        } @catch (__unused NSException *exception) { [request finish]; }
    });
}
static BOOL CSQuickOpenFileTransfer(CSQuickRouteRequest *request) {
    if (![request isCurrent] || !request.source.navigationController) return NO;
    id contacts=CSQuickCurrentService(request,@"CContactMgr");
    id contact=nil;
    for (NSString *lookup in @[@"getContactByName:",@"getContactByNameFromDB:"]) {
        if (![request isCurrent]) return NO;
        if (!CSQuickMatches(contacts,lookup,"@@:@")) continue;
        contact=((id (*)(id,SEL,id))objc_msgSend)(contacts,NSSelectorFromString(lookup),@"filehelper");
        if (contact) break;
    }
    if (!CSQuickIsClass(contact,@"CContact") || ![CSQuickRead(contact,@"m_nsUsrName") isEqual:@"filehelper"] || ![request isCurrent]) return NO;
    id main=nil;
    UIViewController *mainPage=nil;
    UINavigationController *navigation=nil;
    NSArray *owners=CSQuickOwners(request.source);
    for (id candidate in owners) {
        if (!CSQuickIsClass(candidate,@"NewMainFrameViewController") || !CSQuickMatches(candidate,@"newMessageByContact:msgWrapToAdd:","v@:@@")) continue;
        UIViewController *page=CSQuickNativePage(candidate);
        if (page && page.navigationController && [page.navigationController.viewControllers containsObject:page]) {
            main=candidate; mainPage=page; navigation=page.navigationController; break;
        }
    }
    if (!main || ![request isCurrent]) return NO;
    UITabBarController *tab=nil;
    UIViewController *previousTab=nil;
    if (navigation!=request.source.navigationController) {
        // Neo explicitly selects the first (WeChat) tab before invoking this
        // owner. Permit that handoff only inside the request's exact tab/window.
        for (id candidate in owners) {
            if (![candidate isKindOfClass:UITabBarController.class]) continue;
            UITabBarController *container=candidate;
            if (container.isViewLoaded && container.view.window==request.window &&
                container.selectedViewController==request.source.navigationController &&
                container.viewControllers.firstObject==navigation &&
                [container.viewControllers containsObject:request.source.navigationController]) { tab=container; break; }
        }
        if (!tab || ![request isCurrent]) return NO;
        previousTab=tab.selectedViewController;
        tab.selectedIndex=0;
    }
    UIViewController *before=navigation.topViewController;
    BOOL ready=CSQuickRouteWindowIsActive(request) && (!tab || tab.selectedViewController==navigation) &&
        CSQuickNativePage(main)==mainPage && mainPage.navigationController==navigation &&
        [navigation.viewControllers containsObject:mainPage] && before.view.window==request.window && CSQuickCanNavigate(before);
    if (ready) {
        // Shipped Neo ABI: (existing CContact *, nil), through the native main
        // owner. No message wrapper, contact creation, or send API is involved.
        ((void (*)(id,SEL,id,id))objc_msgSend)(main,NSSelectorFromString(@"newMessageByContact:msgWrapToAdd:"),contact,nil);
        if (!CSQuickRouteWindowIsActive(request)) return NO;
        if (CSQuickFileTransferOpened(request,navigation,tab)) return YES;
        CSQuickAwaitFileTransfer(request,navigation,tab);
        return YES; // Accepted for observation; actual chat success is checked above/at completion.
    }
    // Only restore a tab when preflight rejected the handoff before native was
    // called. A submitted native route may still enqueue its own navigation.
    if (tab && CSQuickRouteWindowIsActive(request) && tab.selectedViewController==navigation && navigation.topViewController==before &&
        previousTab==request.source.navigationController && request.source.navigationController.topViewController==request.source)
        tab.selectedViewController=previousTab;
    return NO;
}
static BOOL CSQuickOpenChatBackground(CSQuickRouteRequest *request) {
    if (![request isCurrent]) return NO;
    UIViewController *page=CSQuickCreatePage(@"ChatBackgroundEntranceViewController");
    // A fresh native full entrance keeps its global default. Reject a build
    // whose initializer supplies a conversation username; never borrow a chat
    // settings owner or change the quick panel's own background preference.
    if (!page || !CSQuickMatches(page,@"m_username","@@:")) return NO;
    id username=CSQuickRead(page,@"m_username");
    if (username && (![username isKindOfClass:NSString.class] || [username length])) return NO;
    return [request isCurrent] && CSQuickPush(page,request.source);
}
// Follow only the visible UIKit path, including modals on a navigation/tab
// container. Hidden children and cached native login controllers are not proof.
static UIViewController *CSQuickSwitchVisiblePage(UIWindow *window) {
    UIViewController *page=window.rootViewController;
    for (NSUInteger depth=0; page && depth<32; depth++) {
        if (page.isBeingDismissed || page.isMovingFromParentViewController) return nil;
        UIViewController *next=page.presentedViewController;
        if (!next && [page isKindOfClass:UINavigationController.class]) next=[(UINavigationController *)page topViewController];
        else if (!next && [page isKindOfClass:UITabBarController.class]) next=[(UITabBarController *)page selectedViewController];
        else if (!next && CSQuickIsClass(page,@"WCTabBarController")) {
            id selected=CSQuickRead(page,@"selectedViewController");
            if ([selected isKindOfClass:UIViewController.class]) next=selected;
        }
        if (!next || next==page) return page;
        page=next;
    }
    return nil;
}
static BOOL CSQuickSwitchAccountUIOpened(CSQuickRouteRequest *request, UIViewController *settings) {
    UIViewController *visible=CSQuickSwitchVisiblePage(request.window);
    if (CSQuickIsClass(visible,@"WCAccountLoginUsersViewController") && visible.isViewLoaded &&
        visible.view.window==request.window && !visible.transitionCoordinator &&
        !visible.navigationController.transitionCoordinator) return YES;
    // 8.0.80 showLoginInfo owns a first-use MMTipsViewController in m_introView.
    // MMWindowViewController can use a separate window, so bind that exact tip
    // to its native delegate and scene rather than accepting any visible alert.
    if (visible!=settings) return NO;
    Ivar ivar=class_getInstanceVariable(object_getClass(settings),"m_introView");
    const char *type=ivar ? ivar_getTypeEncoding(ivar) : NULL;
    id tip=type && type[0]=='@' ? object_getIvar(settings,ivar) : nil;
    if (![tip isKindOfClass:UIViewController.class] || !CSQuickIsClass(tip,@"MMTipsViewController") ||
        CSQuickRead(tip,@"m_delegate")!=settings || !CSQuickMatches(tip,@"isObjShowing","B@:")) return NO;
    UIViewController *page=tip;
    return page.isViewLoaded && page.view.window && page.view.window.windowScene==request.scene &&
        (request.scene || page.view.window==request.window) &&
        !page.isBeingDismissed && !page.isMovingFromParentViewController &&
        ((BOOL (*)(id,SEL))objc_msgSend)(tip,NSSelectorFromString(@"isObjShowing"));
}
static void CSQuickContinueSwitchAccount(CSQuickRouteRequest *request, UINavigationController *navigation,
    UIViewController *settings, BOOL submitted, NSUInteger remaining) {
    @try {
        if (!CSQuickRouteWindowIsActive(request)) { [request finish]; return; }
        if (submitted && CSQuickSwitchAccountUIOpened(request,settings)) { [request finish]; return; }
        UIViewController *visible=CSQuickSwitchVisiblePage(request.window);
        BOOL arriving=submitted && CSQuickIsClass(visible,@"WCAccountLoginUsersViewController") &&
            (!visible.isViewLoaded || !visible.view.window || visible.view.window==request.window);
        // User navigation, a different tab/root, or competing UI cancels this
        // shortcut. Never chase it with another push or another native action.
        if (!arriving && (settings.navigationController!=navigation || navigation.topViewController!=settings ||
            ![navigation.viewControllers containsObject:settings] ||
            visible!=settings ||
            (settings.isViewLoaded && settings.view.window && settings.view.window!=request.window))) {
            [request finish]; return;
        }
        if (!submitted && [request isCurrent]) {
            // The real 8.0.80 settings row binds showLoginInfo, not the internal
            // gotoSwitchAccount continuation. Let native tips/checks/delegates
            // continue the flow, including cancellation and account selection.
            if (!CSQuickInvokeAction(settings,@"showLoginInfo")) { [request finish]; return; }
            CSQuickContinueSwitchAccount(request,navigation,settings,YES,200);
            return;
        }
        if (!remaining) {
            BOOL canReport=[request isCurrent];
            [request finish];
            if (canReport) CSQuickFailure(settings,@"微信尚未打开切换账号页面，请从微信“设置 → 切换账号”进入。");
            return;
        }
        // Nonanimated push can return before the view enters its window. Native
        // work can also enqueue a later push; both stages have a bounded wait.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            CSQuickContinueSwitchAccount(request,navigation,settings,submitted,remaining-1);
        });
    } @catch (__unused NSException *exception) {
        BOOL canReport=[request isCurrent];
        [request finish];
        if (canReport) CSQuickFailure(settings,@"微信未完成切换账号页面打开，请使用原生设置入口重试。");
    }
}
static BOOL CSQuickOpenSwitchAccount(CSQuickRouteRequest *request) {
    if (![request isCurrent] || !request.source.navigationController) return NO;
    UIViewController *source=request.source;
    UINavigationController *navigation=source.navigationController;
    // Keep the visible settings owner alive for all native delegates. An older
    // settings page behind the source is not a valid presentation owner.
    Class settingsClass=NSClassFromString(@"NewSettingViewController");
    if (![settingsClass isSubclassOfClass:UIViewController.class] ||
        !CSCloseFriendMethodMatches(class_getInstanceMethod(settingsClass,NSSelectorFromString(@"showLoginInfo")),"v@:")) return NO;
    UIViewController *page=CSQuickIsClass(source,@"NewSettingViewController") ? source : CSQuickCreatePage(@"NewSettingViewController");
    if (!page || !CSQuickMatches(page,@"showLoginInfo","v@:") || ![request isCurrent]) return NO;
    if (page!=source) {
        page.hidesBottomBarWhenPushed=YES;
        [navigation pushViewController:page animated:NO];
    }
    if (![request windowIdentityIsCurrent] || source.navigationController!=navigation ||
        ![navigation.viewControllers containsObject:source] || navigation.topViewController!=page ||
        page.navigationController!=navigation) return NO;
    request.source=page;
    request.awaitingNavigation=YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        CSQuickContinueSwitchAccount(request,navigation,page,NO,40);
    });
    return YES; // Pending, not evidence that the account page has already opened.
}
@implementation CSQuickPanelActionRouter
+ (BOOL)performActionWithIdentifier:(NSString *)identifier fromViewController:(UIViewController *)source {
    if (!NSThread.isMainThread || ![source isKindOfClass:UIViewController.class]) return NO;
    source=CSQuickSourcePage(source);
    CSQuickRouteRequest *pending=objc_getAssociatedObject(source.view.window,&CSQuickRouteRequestKey);
    // A second tap must not place a competing failure alert over the native
    // page that an accepted shortcut is still preparing or observing.
    if (pending.awaitingNavigation && [pending windowIdentityIsCurrent]) return NO;
    CSQuickRouteRequest *request=CSQuickBeginRequest(source);
    if (!request) return CSQuickFailure(source,@"当前页面正在切换、验证或恢复数据，请稍后再打开快捷入口。");
    @try {
        if ([identifier isEqual:@"plugin_home"]) return CSQuickOpenPlugin(request,NO);
        if ([identifier isEqual:@"panel_settings"]) return CSQuickOpenPlugin(request,YES);
        if ([identifier isEqual:@"create_note"]) return CSQuickOpenFavoriteContent(request,YES);
        if (![identifier isKindOfClass:NSString.class] || !identifier.length) {
            [request finish];
            return CSQuickFailure(source,@"这个快捷入口暂不可用，请重新打开快捷面板。");
        }
        NSArray *owners=CSQuickOwners(source);
        NSDictionary *nativeActions=@{
            @"scan":@[@"NewMainFrameViewController",@"onCreateScanCamera"],
            @"wallet":@[@"MoreViewController",@"showWCPayView"],
            @"my_qrcode":@[@"MoreViewController",@"showMyQRCodeInProfileView"],
            @"my_moments":@[@"MoreViewController",@"showMyWCView"],
            @"favorites":@[@"MoreViewController",@"showFavoriteView"],
            @"profile":@[@"MoreViewController",@"showProfileView"],
            @"channels":@[@"FindFriendEntryViewController",@"onClickFindPageFinderCell"],
            @"create_group":@[@"NewMainFrameViewController",@"onCreateNewMessage"],
            @"add_friend":@[@"NewMainFrameViewController",@"onAddContact"],
            @"emoji_store":@[@"MoreViewController",@"showEmoticonStoreView"],
            @"chat_background":@[@"SettingGeneralViewController",@"showChatBackgroundConfig"]
        };
        NSArray *action=nativeActions[identifier];
        id owner=action ? CSQuickOwnerForAction(owners,action[0],action[1],source) : nil;
        if (owner) {
            if (![request isCurrent]) { [request finish]; return NO; }
            BOOL accepted=CSQuickInvokeAction(owner,action[1]);
            [request finish];
            return accepted;
        }
        if ([identifier isEqual:@"favorites"]) return CSQuickOpenFavoriteContent(request,NO);
        BOOL opened=NO;
        if ([identifier isEqual:@"dark_mode"]) opened=CSQuickToggleDarkMode(request);
        else if ([identifier isEqual:@"global_search"]) opened=CSQuickOpenGlobalSearch(request);
        else if ([identifier isEqual:@"my_qrcode"]) opened=CSQuickOpenQRCode(request);
        else if ([identifier isEqual:@"payment_code"]) opened=CSQuickOpenPaymentCode(request);
        else if ([identifier isEqual:@"receive_code"]) opened=CSQuickOpenReceiveCode(request);
        else if ([identifier isEqual:@"my_moments"]) opened=CSQuickOpenMyMoments(request);
        else if ([identifier isEqual:@"channels"]) opened=CSQuickOpenChannels(request);
        else if ([identifier isEqual:@"file_transfer"]) opened=CSQuickOpenFileTransfer(request);
        else if ([identifier isEqual:@"chat_background"]) opened=CSQuickOpenChatBackground(request);
        else if ([identifier isEqual:@"switch_account"]) opened=CSQuickOpenSwitchAccount(request);
        else if ([identifier isEqual:@"create_group"]) {
            // Retain the native CreateChatLogic owner and delegate. Constructing
            // a bare picker would lose its Done/cancel and chat-return contract.
            [request finish];
            return CSQuickFailure(source,@"请返回“微信”首页或其聊天页面，再使用“发起群聊”。你可以在原生选人页中选择好友并确认。");
        }
        else {
            NSDictionary *classes=@{@"scan":@"CameraScanViewController",@"wallet":@"WCPayMainViewControllerV2",
                @"moments":@"WCTimeLineViewController",@"profile":@"SettingMyProfileViewController",
                @"add_friend":@"AddFriendEntryViewController",@"emoji_store":@"MMEmotionStoreViewController"};
            NSString *name=classes[identifier];
            if (name && [request isCurrent]) opened=CSQuickOpenClass(name,source);
        }
        if (opened && request.awaitingNavigation) return YES;
        UIViewController *failureSource=request.source ?: source;
        [request finish];
        return opened || CSQuickFailure(failureSource,@"当前微信未能打开这个快捷页面，请使用微信原生入口。");
    } @catch (__unused NSException *exception) {
        UIViewController *failureSource=request.source ?: source;
        [request finish];
        return CSQuickFailure(failureSource,@"微信未完成页面打开，请返回后使用原生入口重试。");
    }
}
@end
