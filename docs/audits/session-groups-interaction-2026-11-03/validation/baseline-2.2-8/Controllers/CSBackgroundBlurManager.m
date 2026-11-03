#import "CSBackgroundBlurManager.h"

NSString * const CSBackgroundBlurDefaultsSuite = @"com.cyansmoke.wechattweak";
NSString * const CSBackgroundBlurEnabledKey = @"com.wechat.tweak.background.blur.enabled";
NSString * const CSBackgroundBlurSettingsChangedNotification = @"com.wechat.tweak.background.blur.changed";
static NSTimeInterval const CSBackgroundBlurTransitionDuration = 0.22;

@interface CSBackgroundBlurOverlay : UIVisualEffectView
@property(nonatomic, strong) UIViewPropertyAnimator *animator;
@property(nonatomic) BOOL targetProtected;
@property(nonatomic) BOOL animatorShowsBlur;
@property(nonatomic, strong) UIView *returnSnapshot;
- (void)cancelAnimation;
- (void)removeReturnSnapshot;
- (void)discard;
@end
@implementation CSBackgroundBlurOverlay
- (void)cancelAnimation {
    UIViewPropertyAnimator *animator = self.animator;
    self.animator = nil;
    if (animator.state == UIViewAnimatingStateActive) [animator stopAnimation:YES];
}

- (void)removeReturnSnapshot {
    [self.returnSnapshot removeFromSuperview];
    self.returnSnapshot = nil;
}

- (void)discard {
    [self cancelAnimation];
    [self removeReturnSnapshot];
    [self removeFromSuperview];
}
@end

@interface CSBackgroundBlurManager ()
@property(nonatomic, strong) NSUserDefaults *defaults;
@property(nonatomic, strong) NSMapTable<UIWindow *, CSBackgroundBlurOverlay *> *overlays;
@property(nonatomic, strong) NSHashTable<UIWindowScene *> *knownScenes;
@property(nonatomic, strong) NSHashTable<UIWindowScene *> *inactiveScenes;
@property(nonatomic, strong) NSHashTable<UIWindowScene *> *backgroundScenes;
@property(nonatomic, strong) NSHashTable<UIWindowScene *> *disconnectedScenes;
@property(nonatomic) BOOL applicationInactive;
@property(nonatomic) BOOL applicationInBackground;
@property(nonatomic) BOOL started;
@property(nonatomic) BOOL enabled;
@end

@implementation CSBackgroundBlurManager

+ (instancetype)sharedManager {
    static CSBackgroundBlurManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithDefaults:[[NSUserDefaults alloc] initWithSuiteName:CSBackgroundBlurDefaultsSuite]];
    });
    return manager;
}

- (instancetype)initWithDefaults:(NSUserDefaults *)defaults {
    if ((self = [super init])) {
        _defaults = defaults;
        _overlays = [NSMapTable weakToStrongObjectsMapTable];
        _knownScenes = [NSHashTable weakObjectsHashTable];
        _inactiveScenes = [NSHashTable weakObjectsHashTable];
        _backgroundScenes = [NSHashTable weakObjectsHashTable];
        _disconnectedScenes = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)start {
    if (self.started) return;
    self.started = YES;
    self.applicationInactive = UIApplication.sharedApplication.applicationState != UIApplicationStateActive;
    self.applicationInBackground = UIApplication.sharedApplication.applicationState == UIApplicationStateBackground;
    // Attach synchronously on resign-active, then settle the effect on background.
    for (NSString *name in @[
        UIApplicationWillResignActiveNotification, UIApplicationDidEnterBackgroundNotification,
        UIApplicationDidBecomeActiveNotification,
        UISceneWillDeactivateNotification, UISceneDidEnterBackgroundNotification,
        UISceneDidActivateNotification, UISceneDidDisconnectNotification,
        UIWindowDidBecomeVisibleNotification, UIWindowDidBecomeHiddenNotification,
        UIAccessibilityReduceMotionStatusDidChangeNotification,
        CSBackgroundBlurSettingsChangedNotification,
        @"com.wechat.tweak.settings_changed", @"com.wechat.tweak.local_settings_changed"
    ]) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleNotification:) name:name object:nil];
    }
    [self refreshOverlaysAnimated:NO];
}

- (BOOL)isEnabled { return [self.defaults boolForKey:CSBackgroundBlurEnabledKey]; }

- (void)handleNotification:(NSNotification *)notification {
    // UIKit lifecycle events arrive on main. Configuration importers may notify off-main.
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ [self handleNotification:notification]; });
        return;
    }
    NSString *name = notification.name;
    if ([name isEqualToString:UIApplicationWillResignActiveNotification] ||
        [name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        self.applicationInactive = YES;
        if ([name isEqualToString:UIApplicationDidEnterBackgroundNotification]) self.applicationInBackground = YES;
    } else if ([name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        self.applicationInactive = NO;
        self.applicationInBackground = NO;
    } else if ([notification.object isKindOfClass:UIWindowScene.class]) {
        UIWindowScene *scene = notification.object;
        if ([name isEqualToString:UISceneDidDisconnectNotification]) {
            for (UIWindow *window in self.overlays.keyEnumerator.allObjects) {
                if (window.windowScene == scene) [self removeOverlayForWindow:window];
            }
            [self.knownScenes removeObject:scene];
            [self.inactiveScenes removeObject:scene];
            [self.backgroundScenes removeObject:scene];
            [self.disconnectedScenes addObject:scene];
            // A disconnect notification may precede connectedScenes being updated.
            return;
        }
        if ([name isEqualToString:UISceneWillDeactivateNotification] ||
            [name isEqualToString:UISceneDidEnterBackgroundNotification]) {
            [self.disconnectedScenes removeObject:scene];
            [self.knownScenes addObject:scene];
            [self.inactiveScenes addObject:scene];
            if ([name isEqualToString:UISceneDidEnterBackgroundNotification]) [self.backgroundScenes addObject:scene];
        } else if ([name isEqualToString:UISceneDidActivateNotification]) {
            [self.disconnectedScenes removeObject:scene];
            [self.knownScenes addObject:scene];
            [self.inactiveScenes removeObject:scene];
            [self.backgroundScenes removeObject:scene];
        }
    }
    BOOL settingsChanged = [name isEqualToString:CSBackgroundBlurSettingsChangedNotification] ||
        [name isEqualToString:@"com.wechat.tweak.settings_changed"] ||
        [name isEqualToString:@"com.wechat.tweak.local_settings_changed"];
    BOOL enabledChanged = settingsChanged && self.enabled != [self isEnabled];
    [self refreshOverlaysAnimated:!enabledChanged];
}

- (BOOL)isContentWindow:(UIWindow *)window {
    if (window.hidden || window.alpha <= 0 || !window.rootViewController || CGRectIsEmpty(window.bounds)) return NO;
    UIWindowScene *scene = window.windowScene;
    return !scene || (![self.disconnectedScenes containsObject:scene] && scene.activationState != UISceneActivationStateUnattached);
}

- (BOOL)shouldProtectWindow:(UIWindow *)window {
    if (![self isContentWindow:window]) return NO;
    UIWindowScene *scene = window.windowScene;
    if (scene) {
        // Explicit events take precedence: activationState may still hold its old
        // value during will-deactivate, and the app may have another active scene.
        if ([self.knownScenes containsObject:scene]) return [self.inactiveScenes containsObject:scene];
        return self.applicationInactive || scene.activationState != UISceneActivationStateForegroundActive;
    }
    return self.applicationInactive;
}

- (BOOL)isWindowInBackground:(UIWindow *)window {
    UIWindowScene *scene = window.windowScene;
    if (scene && [self.knownScenes containsObject:scene]) {
        return [self.backgroundScenes containsObject:scene] ||
            (self.applicationInBackground && [self.inactiveScenes containsObject:scene]);
    }
    return self.applicationInBackground || (scene && scene.activationState == UISceneActivationStateBackground);
}

- (void)removeOverlayForWindow:(UIWindow *)window {
    [[self.overlays objectForKey:window] discard];
    [self.overlays removeObjectForKey:window];
}

- (void)transitionOverlay:(CSBackgroundBlurOverlay *)overlay
                inWindow:(UIWindow *)window
               protected:(BOOL)protected
                animated:(BOOL)animated {
    if (!animated || UIAccessibilityIsReduceMotionEnabled()) {
        [overlay cancelAnimation];
        overlay.targetProtected = protected;
        [UIView performWithoutAnimation:^{
            overlay.effect = protected ? [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular] : nil;
            overlay.hidden = NO;
            [overlay removeReturnSnapshot];
        }];
        if (!protected) [self removeOverlayForWindow:window];
        return;
    }
    if (overlay.targetProtected == protected) return;
    overlay.targetProtected = protected;
    if (overlay.animator) {
        // Reverse whichever transition is in flight without rebuilding its renderer.
        overlay.animator.reversed = protected != overlay.animatorShowsBlur;
        return;
    }
    UIBlurEffect *effect = protected ? [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular] : nil;
    overlay.animatorShowsBlur = protected;
    if (!protected) {
        // Capture the whole window: snapshotting only UIVisualEffectView can omit
        // the backdrop it samples. Keep the material intact while a plain snapshot
        // fades, avoiding the light-material -> nil transition seen as a flash.
        UIView *snapshot = [window snapshotViewAfterScreenUpdates:NO];
        if (snapshot) {
            snapshot.frame = window.bounds;
            snapshot.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            snapshot.userInteractionEnabled = NO;
            snapshot.accessibilityElementsHidden = YES;
            overlay.returnSnapshot = snapshot;
            [UIView performWithoutAnimation:^{
                [window addSubview:snapshot];
                overlay.hidden = YES;
            }];
        }
        // If UIKit cannot supply a snapshot, retain the existing effect transition.
    }
    UIView *returnSnapshot = overlay.returnSnapshot;
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc]
        initWithDuration:CSBackgroundBlurTransitionDuration
        curve:UIViewAnimationCurveEaseInOut
        animations:^{
            if (returnSnapshot) returnSnapshot.alpha = 0;
            else overlay.effect = effect;
        }];
    overlay.animator = animator;
    __weak CSBackgroundBlurManager *weakSelf = self;
    __weak UIWindow *weakWindow = window;
    __weak CSBackgroundBlurOverlay *weakOverlay = overlay;
    __weak UIViewPropertyAnimator *weakAnimator = animator;
    [animator addCompletion:^(UIViewAnimatingPosition position) {
        CSBackgroundBlurManager *manager = weakSelf;
        CSBackgroundBlurOverlay *current = weakOverlay;
        UIWindow *targetWindow = weakWindow;
        if (!current || current.animator != weakAnimator) return;
        current.animator = nil;
        if (!manager || !targetWindow || [manager.overlays objectForKey:targetWindow] != current) {
            [current discard];
            return;
        }
        if (current.returnSnapshot) {
            [UIView performWithoutAnimation:^{
                // A reversed return restores the live full blur beneath the image
                // before removing the snapshot. Normal return removes both views.
                if (current.targetProtected) current.hidden = NO;
                [current removeReturnSnapshot];
                if (!current.targetProtected) [manager removeOverlayForWindow:targetWindow];
            }];
            return;
        }
        // UIKit has already applied the endpoint (including a reversed start).
        // Reassigning effect here can rebuild the backdrop on the final frame.
        // Only repair an interrupted/inconsistent endpoint, never normal completion.
        BOOL finishedProtected = position == UIViewAnimatingPositionEnd ? current.animatorShowsBlur : !current.animatorShowsBlur;
        if (position == UIViewAnimatingPositionCurrent || finishedProtected != current.targetProtected) {
            [UIView performWithoutAnimation:^{
                current.effect = current.targetProtected ? [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular] : nil;
            }];
        }
        if (!current.targetProtected) [manager removeOverlayForWindow:targetWindow];
    }];
    [animator startAnimation];
}

- (void)refreshOverlaysAnimated:(BOOL)animated {
    BOOL enabled = [self isEnabled];
    self.enabled = enabled;
    if (!enabled && self.overlays.count == 0) return;
    NSMutableSet<UIWindow *> *windows = [NSMutableSet set];
    if (enabled) {
        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if ([scene isKindOfClass:UIWindowScene.class] && scene.activationState != UISceneActivationStateUnattached) {
                [windows addObjectsFromArray:((UIWindowScene *)scene).windows];
            }
        }
        // Legacy app-delegate windows still need protection on iOS 15+.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [windows addObjectsFromArray:UIApplication.sharedApplication.windows];
#pragma clang diagnostic pop
    }
    for (UIWindow *window in self.overlays.keyEnumerator.allObjects) {
        if (![windows containsObject:window] || ![self isContentWindow:window]) {
            [self removeOverlayForWindow:window];
        } else if (![self shouldProtectWindow:window]) {
            [self transitionOverlay:[self.overlays objectForKey:window] inWindow:window protected:NO animated:animated];
        }
    }
    for (UIWindow *window in windows) {
        if (![self shouldProtectWindow:window]) continue;
        CSBackgroundBlurOverlay *overlay = [self.overlays objectForKey:window];
        if (!overlay) {
            overlay = [[CSBackgroundBlurOverlay alloc] initWithEffect:nil];
            overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            overlay.userInteractionEnabled = NO;
            overlay.accessibilityElementsHidden = YES;
            [self.overlays setObject:overlay forKey:window];
        }
        [UIView performWithoutAnimation:^{
            overlay.frame = window.bounds;
            if (overlay.superview != window) [window addSubview:overlay];
            [window bringSubviewToFront:overlay];
            if (overlay.returnSnapshot) {
                overlay.returnSnapshot.frame = window.bounds;
                [window bringSubviewToFront:overlay.returnSnapshot];
            }
            [overlay layoutIfNeeded];
        }];
        // A suspended animation must never leave a partially blurred background card.
        [self transitionOverlay:overlay inWindow:window protected:YES animated:animated && ![self isWindowInBackground:window]];
    }
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    for (CSBackgroundBlurOverlay *overlay in self.overlays.objectEnumerator) {
        [overlay discard];
    }
}

@end
