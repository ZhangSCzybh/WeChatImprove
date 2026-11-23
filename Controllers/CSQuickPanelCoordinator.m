#import "CSQuickPanelCoordinator.h"
#import "CSQuickPanelContentView.h"
#import "CSQuickPanelPreferences.h"
#import "CSQuickPanelActionRouter.h"
#import "CSQuickPanelGesturePolicy.h"
#import "CSQuickPanelBackgroundView.h"
#import "CSBackupBootstrap.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <objc/runtime.h>

static char CSQuickPanelHomeBindingKey, CSQuickPanelChatBindingKey;

static id CSQPObjectGetter(id object, NSString *name) {
    SEL selector=NSSelectorFromString(name);
    NSMethodSignature *signature=[object methodSignatureForSelector:selector];
    if (!signature || signature.numberOfArguments!=2 || signature.methodReturnType[0]!='@') return nil;
    @try { return ((id (*)(id,SEL))[object methodForSelector:selector])(object,selector); }
    @catch (__unused NSException *exception) { return nil; }
}
static BOOL CSQPViewVisible(UIView *view) {
    if (![view isKindOfClass:UIView.class] || !view.window || !view.userInteractionEnabled) return NO;
    for (UIView *part=view;part;part=part.superview) if (part.hidden || part.alpha<.01) return NO;
    return !CGRectIsEmpty(view.bounds);
}
static BOOL CSQPWindowActive(UIWindow *window) {
    if (!window || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive ||
        !CSBackupIsReady() || CSBackupAccountIsSuspended()) return NO;
    return !window.windowScene || window.windowScene.activationState==UISceneActivationStateForegroundActive;
}
static UIViewController *CSQPViewOwner(UIView *view) {
    for (UIResponder *part=view.nextResponder;part;part=part.nextResponder)
        if ([part isKindOfClass:UIViewController.class]) return (id)part;
    return nil;
}
static UIViewController *CSQPVisibleController(UIViewController *controller) {
    for (NSUInteger depth=0;controller && depth<24;depth++) {
        UIViewController *next=nil;
        if (controller.presentedViewController && !controller.presentedViewController.isBeingDismissed)
            next=controller.presentedViewController;
        else if ([controller isKindOfClass:UINavigationController.class]) next=((UINavigationController *)controller).visibleViewController;
        else if ([controller isKindOfClass:UITabBarController.class]) next=((UITabBarController *)controller).selectedViewController;
        else {
            id selected=CSQPObjectGetter(controller,@"selectedViewController");
            if ([selected isKindOfClass:UIViewController.class]) next=selected;
        }
        if (!next || next==controller) break;
        controller=next;
    }
    return controller;
}
static BOOL CSQPActiveSource(UIViewController *source) {
    UIWindow *window=source.viewIfLoaded.window;
    if (!CSQPWindowActive(window) || source.isBeingDismissed || source.isBeingPresented ||
        source.presentedViewController || source.transitionCoordinator || source.navigationController.transitionCoordinator) return NO;
    UIViewController *visible=CSQPVisibleController(window.rootViewController);
    if (visible!=source) {
        // Some native tab roots expose their content through a child container.
        BOOL ancestor=NO;
        for (UIViewController *parent=visible.parentViewController;parent;parent=parent.parentViewController)
            if (parent==source) { ancestor=YES;break; }
        if (!ancestor) return NO;
    }
    return CSQPViewVisible(source.view);
}

@interface CSQuickPanelSwipeRecognizer : UIGestureRecognizer
@property(nonatomic) CGPoint origin;
@property(nonatomic, weak) UITouch *trackedTouch;
@end
@implementation CSQuickPanelSwipeRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if ((self=[super initWithTarget:target action:action])) {
        self.cancelsTouchesInView=YES;
        self.delaysTouchesBegan=NO;
        self.delaysTouchesEnded=NO;
        self.allowedTouchTypes=@[@(UITouchTypeDirect)];
        self.name=@"WeChatImprove.QuickPanel.SwipeUp";
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.trackedTouch || touches.count!=1 || event.allTouches.count!=1) {self.state=UIGestureRecognizerStateFailed;return;}
    self.trackedTouch=touches.anyObject;
    self.origin=[self.trackedTouch locationInView:self.view];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.state!=UIGestureRecognizerStatePossible) return;
    if (!self.trackedTouch || event.allTouches.count!=1) {self.state=UIGestureRecognizerStateFailed;return;}
    CGPoint point=[self.trackedTouch locationInView:self.view];
    CSQuickPanelSwipeDecision result=CSQuickPanelDecideSwipe(point.x-self.origin.x,point.y-self.origin.y);
    if (result==CSQuickPanelSwipeRejected) self.state=UIGestureRecognizerStateFailed;
    else if (result==CSQuickPanelSwipeRecognized) self.state=UIGestureRecognizerStateRecognized;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {if(self.state==UIGestureRecognizerStatePossible)self.state=UIGestureRecognizerStateFailed;}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {if(self.state==UIGestureRecognizerStatePossible)self.state=UIGestureRecognizerStateFailed;}
- (void)reset {[super reset];self.trackedTouch=nil;self.origin=CGPointZero;}
@end

@class CSQuickPanelGestureBinding;
@interface CSQuickPanelOverlayViewController : UIViewController <UIGestureRecognizerDelegate>
@property(nonatomic, strong) UIView *backdrop, *card, *handle;
@property(nonatomic, strong) UIControl *dragRegion;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) CSQuickPanelContentView *contentView;
@property(nonatomic, strong) CSQuickPanelBackgroundView *backgroundView;
@property(nonatomic, weak) UIViewController *sourceController;
@property(nonatomic) NSUInteger accountEpoch;
@property(nonatomic) BOOL preview, closing, entering, interrupted, removed;
@property(nonatomic, copy) void (^didClose)(void);
@property(nonatomic, copy) void (^dismissCompletion)(void);
- (void)dismissAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;
@end

@interface CSQuickPanelCoordinator ()
@property(nonatomic, strong) NSMapTable<UIWindow *,CSQuickPanelOverlayViewController *> *overlays;
@property(nonatomic, strong) NSHashTable<UIView *> *homeBars;
@property(nonatomic, strong) NSHashTable<UIViewController *> *chatControllers;
@property(nonatomic) BOOL enabled, refreshPending;
@property(nonatomic) CSQuickPanelTriggerLocations locations;
+ (CSQuickPanelCoordinator *)shared;
- (CSQuickPanelOverlayViewController *)overlayForWindow:(UIWindow *)window;
- (void)refreshBindings;
- (void)showFromController:(UIViewController *)source preview:(BOOL)preview;
@end

@interface CSQuickPanelGestureBinding : NSObject <UIGestureRecognizerDelegate>
@property(nonatomic, weak) UIView *targetView;
@property(nonatomic, weak) UIViewController *chatController;
@property(nonatomic, strong) CSQuickPanelSwipeRecognizer *recognizer;
@property(nonatomic) BOOL chat;
- (instancetype)initWithView:(UIView *)view chatController:(UIViewController * _Nullable)controller;
@end

@implementation CSQuickPanelGestureBinding
- (instancetype)initWithView:(UIView *)view chatController:(UIViewController *)controller {
    if ((self=[super init])) {
        self.targetView=view;self.chatController=controller;self.chat=controller!=nil;
        self.recognizer=[[CSQuickPanelSwipeRecognizer alloc] initWithTarget:self action:@selector(open:)];
        self.recognizer.delegate=self;
        [view addGestureRecognizer:self.recognizer];
    }
    return self;
}
- (UIViewController *)sourceController {
    if (self.chat) return self.chatController;
    if (!CSQPViewVisible(self.targetView)) return nil;
    UIWindow *window=self.targetView.window;
    if (window.rootViewController.presentedViewController) return nil;
    UIViewController *tabOwner=CSQPViewOwner(self.targetView);
    Class legacy=NSClassFromString(@"MMTabBarController"), modern=NSClassFromString(@"WCTabBarController");
    while (tabOwner && !((legacy && [tabOwner isKindOfClass:legacy]) || (modern && [tabOwner isKindOfClass:modern]))) tabOwner=tabOwner.parentViewController;
    if (!tabOwner) return nil;
    UIViewController *source=CSQPVisibleController(window.rootViewController) ?: CSQPViewOwner(self.targetView);
    Class chatClass=NSClassFromString(@"BaseMsgContentViewController");
    if (chatClass && [source isKindOfClass:chatClass]) return nil;
    UINavigationController *navigation=source.navigationController;
    if (navigation && navigation.viewControllers.firstObject!=source && navigation.visibleViewController==source) return nil;
    return source;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    CSQuickPanelCoordinator *coordinator=CSQuickPanelCoordinator.shared;
    CSQuickPanelTriggerLocations location=self.chat ? CSQuickPanelTriggerChat : CSQuickPanelTriggerHome;
    UIViewController *source=[self sourceController];
    if (!coordinator.enabled || !(coordinator.locations&location) || [coordinator overlayForWindow:source.viewIfLoaded.window] || !CSQPActiveSource(source)) return NO;
    if (!self.chat) return CSQPViewVisible(self.targetView) && CGRectContainsPoint(self.targetView.bounds,[touch locationInView:self.targetView]);
    // Resolve the current native text field each time, including rebuilt inputs.
    id tool=CSQPObjectGetter(source,@"toolView");
    id text=CSQPObjectGetter(tool,@"textView");
    if (![text isKindOfClass:UIView.class] || !CSQPViewVisible(text) || ![(UIView *)text isDescendantOfView:source.view]) return NO;
    return CGRectContainsPoint([(UIView *)text bounds],[touch locationInView:text]);
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture {
    UIViewController *source=[self sourceController];
    return ![CSQuickPanelCoordinator.shared overlayForWindow:source.viewIfLoaded.window] && CSQPActiveSource(source);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other {
    // Only native pans in this same trigger area wait for the directional decision.
    // Long presses (selection / close-friend title) retain their existing priority.
    if (![other isKindOfClass:UIPanGestureRecognizer.class] || [other isKindOfClass:UIScreenEdgePanGestureRecognizer.class]) return NO;
    if (!self.chat) return [other.view isDescendantOfView:self.targetView];
    id text=CSQPObjectGetter(CSQPObjectGetter(self.chatController,@"toolView"),@"textView");
    return [text isKindOfClass:UIView.class] && (other.view==text || [other.view isDescendantOfView:text]);
}
- (void)open:(CSQuickPanelSwipeRecognizer *)gesture {
    if (gesture.state==UIGestureRecognizerStateRecognized)
        [CSQuickPanelCoordinator.shared showFromController:[self sourceController] preview:NO];
}
@end

@implementation CSQuickPanelOverlayViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.clearColor;
    self.view.accessibilityViewIsModal=YES;
    self.backdrop=[UIView new];
    self.backdrop.backgroundColor=[UIColor colorWithWhite:0 alpha:.22];
    [self.backdrop addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePanel)]];
    [self.view addSubview:self.backdrop];
    self.card=[UIView new];
    self.card.backgroundColor=UIColor.clearColor;
    self.card.layer.cornerRadius=28;
    self.card.layer.cornerCurve=kCACornerCurveContinuous;
    self.card.clipsToBounds=YES;
    [self.view addSubview:self.card];
    self.backgroundView=[[CSQuickPanelBackgroundView alloc] initWithFrame:CGRectZero];
    [self.card addSubview:self.backgroundView];
    self.dragRegion=[UIControl new];
    self.dragRegion.accessibilityLabel=@"关闭快捷面板";
    self.dragRegion.accessibilityTraits=UIAccessibilityTraitButton;
    [self.dragRegion addTarget:self action:@selector(closePanel) forControlEvents:UIControlEventTouchUpInside];
    self.handle=[UIView new];self.handle.backgroundColor=UIColor.tertiaryLabelColor;self.handle.layer.cornerRadius=2;
    self.handle.userInteractionEnabled=NO;
    [self.dragRegion addSubview:self.handle];
    self.scrollView=[UIScrollView new];
    self.scrollView.alwaysBounceVertical=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    [self.card addSubview:self.scrollView];
    self.contentView=[[CSQuickPanelContentView alloc] initWithFrame:CGRectZero];
    __weak typeof(self) weakSelf=self;
    self.backgroundView.appearanceChanged=^(BOOL lightContent) {
        weakSelf.contentView.backgroundUsesLightContent=lightContent;
        weakSelf.handle.backgroundColor=[(lightContent ? UIColor.whiteColor : UIColor.blackColor) colorWithAlphaComponent:.28];
    };
    [self.backgroundView reloadAppearance];
    self.contentView.actionHandler=^(NSString *identifier) {
        CSQuickPanelOverlayViewController *strongSelf=weakSelf;
        if (!strongSelf || strongSelf.closing || strongSelf.entering) return;
        if (strongSelf.preview) {
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,@"面板预览，入口不会打开微信页面");
            return;
        }
        UIViewController *source=strongSelf.sourceController;
        NSUInteger epoch=strongSelf.accountEpoch;
        [strongSelf dismissAnimated:YES completion:^{
            if (epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended() || !CSQPActiveSource(source)) return;
            [CSQuickPanelActionRouter performActionWithIdentifier:identifier fromViewController:source];
        }];
    };
    [self.scrollView addSubview:self.contentView];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCard:)];
    pan.delegate=self;[self.dragRegion addGestureRecognizer:pan];
    [self.card addSubview:self.dragRegion];
    [self.contentView reloadContent];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.backdrop.frame=self.view.bounds;
    CGRect bounds=self.view.bounds;
    UIEdgeInsets safe=self.view.safeAreaInsets;
    CGFloat width=MIN(480,MAX(1,CGRectGetWidth(bounds)-24-safe.left-safe.right));
    CGFloat wanted=[self.contentView preferredHeightForWidth:width];
    CGFloat maximum=MAX(100,CGRectGetHeight(bounds)-safe.top-safe.bottom-36);
    CGFloat height=MIN(maximum,wanted+28);
    self.card.bounds=CGRectMake(0,0,width,height);
    self.card.center=CGPointMake(CGRectGetMidX(bounds),CGRectGetHeight(bounds)-safe.bottom-8-height/2);
    self.backgroundView.frame=self.card.bounds;
    self.handle.frame=CGRectMake((width-34)/2,10,34,4);
    self.dragRegion.frame=CGRectMake(0,0,width,44);
    self.scrollView.frame=CGRectMake(0,27,width,MAX(1,height-27));
    self.contentView.frame=CGRectMake(0,0,width,wanted);
    self.scrollView.contentSize=CGSizeMake(width,wanted);
    self.scrollView.scrollEnabled=wanted>CGRectGetHeight(self.scrollView.bounds)+1;
}
- (BOOL)accessibilityPerformEscape {[self closePanel];return YES;}
- (void)closePanel {[self dismissAnimated:YES completion:nil];}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture {
    UIPanGestureRecognizer *pan=(id)gesture;
    CGPoint velocity=[pan velocityInView:self.card];
    return !self.entering && !self.closing && velocity.y>fabs(velocity.x)*1.25;
}
- (void)panCard:(UIPanGestureRecognizer *)pan {
    CGFloat movement=MAX(0,[pan translationInView:self.view].y);
    if (pan.state==UIGestureRecognizerStateChanged) {
        self.card.transform=CGAffineTransformMakeTranslation(0,movement);
        self.backdrop.alpha=MAX(.35,1-movement/400);
    } else if (pan.state==UIGestureRecognizerStateEnded || pan.state==UIGestureRecognizerStateCancelled) {
        if (pan.state==UIGestureRecognizerStateEnded && (movement>72 || [pan velocityInView:self.view].y>650)) [self closePanel];
        else [UIView animateWithDuration:UIAccessibilityIsReduceMotionEnabled()?0:.2 animations:^{self.card.transform=CGAffineTransformIdentity;self.backdrop.alpha=1;}];
    }
}
- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion {
    if (self.removed || (self.closing && animated)) return;
    if (self.closing) self.dismissCompletion=nil;
    else self.dismissCompletion=completion;
    self.closing=YES;self.view.userInteractionEnabled=NO;
    void (^finish)(void)=^{
        if (self.removed) return;self.removed=YES;
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        if (self.didClose) self.didClose();
        self.didClose=nil;
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,self.sourceController.viewIfLoaded);
        void (^callback)(void)=self.dismissCompletion;self.dismissCompletion=nil;
        if (!self.interrupted && callback) callback();
    };
    [self.card.layer removeAllAnimations];[self.backdrop.layer removeAllAnimations];
    if (!animated || UIAccessibilityIsReduceMotionEnabled()) {finish();return;}
    [UIView animateWithDuration:.2 animations:^{self.card.transform=CGAffineTransformMakeTranslation(0,CGRectGetHeight(self.card.bounds)+self.view.safeAreaInsets.bottom+20);self.backdrop.alpha=0;} completion:^(BOOL finished){finish();}];
}
@end

@implementation CSQuickPanelCoordinator
+ (CSQuickPanelCoordinator *)shared {
    static CSQuickPanelCoordinator *value;
    static dispatch_once_t once;
    dispatch_once(&once,^{value=[self new];value.homeBars=[NSHashTable weakObjectsHashTable];value.chatControllers=[NSHashTable weakObjectsHashTable];value.overlays=[NSMapTable weakToWeakObjectsMapTable];});
    return value;
}
- (CSQuickPanelOverlayViewController *)overlayForWindow:(UIWindow *)window {return window ? [self.overlays objectForKey:window] : nil;}
+ (void)install {
    if (!NSThread.isMainThread) {dispatch_async(dispatch_get_main_queue(),^{[self install];});return;}
    static BOOL installed=NO;if(installed)return;installed=YES;
    CSQuickPanelCoordinator *coordinator=self.shared;
    NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
    for (NSString *name in @[CSQuickPanelPreferencesDidChangeNotification,NSUserDefaultsDidChangeNotification,@"CSPreferencesDidRestoreNotification",UIContentSizeCategoryDidChangeNotification])
        [center addObserver:coordinator selector:@selector(scheduleRefresh:) name:name object:nil];
    for (NSString *name in @[UIApplicationWillResignActiveNotification,UIApplicationDidEnterBackgroundNotification,@"CSBackupAccountChanged"])
        [center addObserver:coordinator selector:@selector(interrupt:) name:name object:nil];
    for (NSString *name in @[UISceneWillDeactivateNotification,UISceneDidEnterBackgroundNotification,UISceneDidDisconnectNotification])
        [center addObserver:coordinator selector:@selector(interrupt:) name:name object:nil];
    [center addObserver:coordinator selector:@selector(scheduleRefresh:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [center addObserver:coordinator selector:@selector(scheduleRefresh:) name:UISceneDidActivateNotification object:nil];
    [coordinator refreshBindings];
}
- (void)scheduleRefresh:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(),^{
        if (self.refreshPending) return;self.refreshPending=YES;
        dispatch_async(dispatch_get_main_queue(),^{self.refreshPending=NO;[self refreshBindings];});
    });
}
- (void)interrupt:(NSNotification *)note {
    if (!NSThread.isMainThread) {dispatch_async(dispatch_get_main_queue(),^{[self interrupt:note];});return;}
    UIScene *scene=[note.object isKindOfClass:UIScene.class] ? note.object : nil;
    for (CSQuickPanelOverlayViewController *overlay in self.overlays.objectEnumerator.allObjects) {
        if (scene && overlay.viewIfLoaded.window.windowScene!=scene) continue;
        overlay.interrupted=YES;[overlay dismissAnimated:NO completion:nil];
    }
    for (UIView *bar in self.homeBars) {
        if (scene && bar.window.windowScene!=scene) continue;
        CSQuickPanelGestureBinding *binding=objc_getAssociatedObject(bar,&CSQuickPanelHomeBindingKey);
        binding.recognizer.enabled=NO;
    }
    for (UIViewController *controller in self.chatControllers) {
        if (scene && controller.viewIfLoaded.window.windowScene!=scene) continue;
        CSQuickPanelGestureBinding *binding=objc_getAssociatedObject(controller,&CSQuickPanelChatBindingKey);
        binding.recognizer.enabled=NO;
    }
    if ([note.name isEqual:@"CSBackupAccountChanged"]) [self refreshBindings];
}
- (void)refreshBindings {
    self.enabled=CSQuickPanelPreferences.enabled;
    self.locations=CSQuickPanelPreferences.triggerLocations;
    for (CSQuickPanelOverlayViewController *overlay in self.overlays.objectEnumerator.allObjects) {
        if (!self.enabled && !overlay.preview) {overlay.interrupted=YES;[overlay dismissAnimated:NO completion:nil];}
        else {[overlay.contentView reloadContent];[overlay.view setNeedsLayout];}
    }
    for (UIView *bar in self.homeBars.allObjects) [CSQuickPanelCoordinator attachToHomeBar:bar];
    for (UIViewController *controller in self.chatControllers.allObjects) [CSQuickPanelCoordinator attachToChatController:controller];
}
+ (void)attachToHomeBar:(UIView *)bar {
    if (!NSThread.isMainThread || ![bar isKindOfClass:UIView.class]) return;
    CSQuickPanelCoordinator *coordinator=self.shared;
    [coordinator.homeBars addObject:bar];
    CSQuickPanelGestureBinding *binding=objc_getAssociatedObject(bar,&CSQuickPanelHomeBindingKey);
    BOOL enabled=coordinator.enabled && (coordinator.locations&CSQuickPanelTriggerHome) && CSQPWindowActive(bar.window) && CSQPViewVisible(bar);
    if (!binding && enabled) {binding=[[CSQuickPanelGestureBinding alloc] initWithView:bar chatController:nil];objc_setAssociatedObject(bar,&CSQuickPanelHomeBindingKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
    binding.recognizer.enabled=enabled;
}
+ (void)attachToChatController:(UIViewController *)controller {
    if (!NSThread.isMainThread || ![controller isKindOfClass:UIViewController.class]) return;
    CSQuickPanelCoordinator *coordinator=self.shared;
    [coordinator.chatControllers addObject:controller];
    CSQuickPanelGestureBinding *binding=objc_getAssociatedObject(controller,&CSQuickPanelChatBindingKey);
    BOOL enabled=coordinator.enabled && (coordinator.locations&CSQuickPanelTriggerChat) && CSQPWindowActive(controller.viewIfLoaded.window);
    if (!binding && enabled) {binding=[[CSQuickPanelGestureBinding alloc] initWithView:controller.view chatController:controller];objc_setAssociatedObject(controller,&CSQuickPanelChatBindingKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
    binding.recognizer.enabled=enabled;
}
+ (void)chatControllerDidDisappear:(UIViewController *)controller {
    CSQuickPanelGestureBinding *binding=objc_getAssociatedObject(controller,&CSQuickPanelChatBindingKey);binding.recognizer.enabled=NO;
    CSQuickPanelOverlayViewController *overlay=[self.shared overlayForWindow:controller.viewIfLoaded.window];
    if (overlay.sourceController==controller) {overlay.interrupted=YES;[overlay dismissAnimated:NO completion:nil];}
}
+ (void)presentPreviewFromViewController:(UIViewController *)controller {[self.shared showFromController:controller preview:YES];}
- (void)showFromController:(UIViewController *)source preview:(BOOL)preview {
    if (!NSThread.isMainThread || [self overlayForWindow:source.viewIfLoaded.window] || !CSQPActiveSource(source) || (!preview && !self.enabled)) return;
    UIWindow *window=source.view.window;
    UIViewController *host=window.rootViewController;
    while (host.presentedViewController && !host.presentedViewController.isBeingDismissed) host=host.presentedViewController;
    if (!host || host.view.window!=window || [host isKindOfClass:UIAlertController.class]) return;
    [source.view endEditing:YES];
    CSQuickPanelOverlayViewController *overlay=[CSQuickPanelOverlayViewController new];
    overlay.sourceController=source;overlay.preview=preview;overlay.accountEpoch=CSBackupAccountEpoch();overlay.entering=YES;
    [self.overlays setObject:overlay forKey:window];
    __weak typeof(self) weakSelf=self;
    __weak UIWindow *weakWindow=window;
    overlay.didClose=^{if(weakWindow)[weakSelf.overlays removeObjectForKey:weakWindow];};
    [host addChildViewController:overlay];
    overlay.view.frame=host.view.bounds;overlay.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [host.view addSubview:overlay.view];[overlay didMoveToParentViewController:host];[overlay.view layoutIfNeeded];
    BOOL reduce=UIAccessibilityIsReduceMotionEnabled();
    overlay.backdrop.alpha=0;overlay.card.transform=reduce?CGAffineTransformIdentity:CGAffineTransformMakeTranslation(0,CGRectGetHeight(overlay.card.bounds)+window.safeAreaInsets.bottom+20);
    [UIView animateWithDuration:reduce?.12:.28 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{overlay.backdrop.alpha=1;overlay.card.transform=CGAffineTransformIdentity;} completion:^(BOOL finished){
        overlay.entering=NO;
        if (overlay.accountEpoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended()) {[overlay dismissAnimated:NO completion:nil];return;}
        if (!overlay.closing) UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,overlay.contentView);
    }];
    if (!preview) {UIImpactFeedbackGenerator *feedback=[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];[feedback impactOccurred];}
}
@end
