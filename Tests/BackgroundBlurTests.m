#import "CSBackgroundBlurManager.h"
#import <assert.h>

static NSUInteger checks;
#define CHECK(condition) do { checks++; assert(condition); } while (0)
static void Post(NSString *name, id object) { [NSNotificationCenter.defaultCenter postNotificationName:name object:object]; }
static UIWindow *Window(UIWindowScene *scene) {
    UIWindow *window = [UIWindow new];
    window.frame = CGRectMake(0, 0, 390, 844);
    window.windowScene = scene;
    window.rootViewController = [UIViewController new];
    [window addSubview:[UIView new]];
    return window;
}
static UIVisualEffectView *Blur(UIWindow *window) {
    UIVisualEffectView *result = nil;
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:UIVisualEffectView.class]) { CHECK(result == nil); result = (id)view; }
    }
    return result;
}

int main(void) { @autoreleasepool {
    NSString *suite = [@"com.wechatimprove.test.backgroundblur." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:suite];
    @try {
        UIApplication *app = UIApplication.sharedApplication;
        app.applicationState = UIApplicationStateActive;
        UIWindowScene *scene = [UIWindowScene new], *other = [UIWindowScene new];
        scene.activationState = other.activationState = UISceneActivationStateForegroundActive;
        UIWindow *window = Window(scene), *second = Window(other), *legacy = Window(nil);
        scene.windows = @[window]; other.windows = @[second];
        app.connectedScenes = [NSSet setWithObjects:scene, other, nil];
        app.windows = @[legacy];
        CSBackgroundBlurManager *manager = [[CSBackgroundBlurManager alloc] initWithDefaults:defaults];
        [manager start]; [manager start];
        CHECK(!Blur(window) && !Blur(legacy));

        // Disabled is a true no-op even on deactivation.
        Post(UISceneWillDeactivateNotification, scene);
        CHECK(!Blur(window));
        Post(UISceneDidActivateNotification, scene);
        [defaults setBool:YES forKey:CSBackgroundBlurEnabledKey];
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(!Blur(window) && !Blur(second));

        // Will-deactivate must cover synchronously while UIKit still reports active.
        Post(UISceneWillDeactivateNotification, scene);
        UIVisualEffectView *overlay = Blur(window);
        CHECK(overlay != nil && !Blur(second));
        CHECK(CGRectEqualToRect(overlay.frame, window.bounds));
        CHECK(!overlay.userInteractionEnabled && overlay.accessibilityElementsHidden);
        CHECK(overlay.autoresizingMask == (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight));
        CHECK(window.subviews.lastObject == overlay && window.subviews.count == 2);
        Post(UISceneWillDeactivateNotification, scene);
        Post(UISceneDidEnterBackgroundNotification, scene);
        CHECK(Blur(window) == overlay);

        // App notifications must not uncover a scene which is still inactive.
        Post(UIApplicationDidBecomeActiveNotification, app);
        CHECK(Blur(window) == overlay && !Blur(second));
        Post(UISceneWillDeactivateNotification, other);
        Post(UISceneDidActivateNotification, scene);
        CHECK(!Blur(window) && Blur(second));
        Post(UISceneDidActivateNotification, other);
        CHECK(!Blur(second));

        // Cancelled gestures and rapid repeated app-switching leave no extra views.
        for (NSUInteger i = 0; i < 30; i++) {
            Post(UISceneWillDeactivateNotification, scene);
            CHECK(Blur(window) != nil && window.subviews.count == 2);
            Post(UISceneDidActivateNotification, scene);
            CHECK(!Blur(window) && window.subviews.count == 1);
        }

        // New windows in an inactive scene, resize, and content added above the cover.
        Post(UISceneWillDeactivateNotification, scene);
        UIWindow *modal = Window(scene);
        scene.windows = @[window, modal];
        Post(UIWindowDidBecomeVisibleNotification, modal);
        CHECK(Blur(modal) && Blur(window));
        overlay = Blur(window);
        window.frame = CGRectMake(0, 0, 844, 390);
        [window addSubview:[UIView new]];
        Post(UISceneDidEnterBackgroundNotification, scene);
        CHECK(Blur(window) == overlay && window.subviews.lastObject == overlay);
        CHECK(CGRectEqualToRect(overlay.frame, window.bounds));
        modal.hidden = YES;
        Post(UIWindowDidBecomeHiddenNotification, modal);
        CHECK(!Blur(modal));
        modal.hidden = NO;
        Post(UIWindowDidBecomeVisibleNotification, modal);
        CHECK(Blur(modal));

        // Reset/import notifications apply immediately, including while inactive.
        [defaults removeObjectForKey:CSBackgroundBlurEnabledKey];
        Post(@"com.wechat.tweak.settings_changed", nil);
        CHECK(!Blur(window) && !Blur(modal));
        [defaults setBool:YES forKey:CSBackgroundBlurEnabledKey];
        Post(@"com.wechat.tweak.local_settings_changed", nil);
        CHECK(Blur(window) && Blur(modal));

        // Disconnect cleanup survives connectedScenes lagging behind the notification.
        Post(UISceneDidDisconnectNotification, scene);
        CHECK(!Blur(window) && !Blur(modal));
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(!Blur(window) && !Blur(modal));
        Post(UISceneDidActivateNotification, scene);
        CHECK(!Blur(window));
        Post(UISceneWillDeactivateNotification, scene);
        CHECK(Blur(window));

        // Legacy application lifecycle is synchronous, idempotent, and cleans up.
        Post(UIApplicationWillResignActiveNotification, app);
        CHECK(Blur(legacy));
        UIVisualEffectView *legacyOverlay = Blur(legacy);
        Post(UIApplicationDidEnterBackgroundNotification, app);
        CHECK(Blur(legacy) == legacyOverlay);
        Post(UIApplicationDidBecomeActiveNotification, app);
        CHECK(!Blur(legacy) && Blur(window));

        // Windows with no content, zero size, or zero opacity are not covered.
        modal.rootViewController = nil;
        window.alpha = 0;
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(!Blur(window) && !Blur(modal));
        window.alpha = 1; window.frame = CGRectZero;
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(!Blur(window));
        window.frame = CGRectMake(0, 0, 390, 844);
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(Blur(window));

        // Removing a window from both inventories removes its retained overlay.
        scene.windows = @[];
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(!Blur(window));
        scene.windows = @[window];
        Post(UISceneWillDeactivateNotification, scene);
        CHECK(Blur(window));
        manager = nil;
        CHECK(!Blur(window));

        // Start while already in background and before scene notifications arrive.
        scene.activationState = UISceneActivationStateBackground;
        app.applicationState = UIApplicationStateBackground;
        manager = [[CSBackgroundBlurManager alloc] initWithDefaults:defaults];
        [manager start];
        CHECK(Blur(window) && Blur(legacy));
        Post(UISceneDidActivateNotification, scene);
        CHECK(!Blur(window) && Blur(legacy));
        [defaults setBool:NO forKey:CSBackgroundBlurEnabledKey];
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(!Blur(window) && !Blur(legacy));
        manager = nil;
        // Drive unfinished animations explicitly: the host does not simulate pixels.
        CSTestCompleteAnimationsImmediately = NO;
        app.applicationState = UIApplicationStateActive;
        scene.activationState = other.activationState = UISceneActivationStateForegroundActive;
        [defaults setBool:YES forKey:CSBackgroundBlurEnabledKey];
        manager = [[CSBackgroundBlurManager alloc] initWithDefaults:defaults];
        [manager start];
        CHECK(!Blur(window) && !Blur(legacy));
        Post(UISceneWillDeactivateNotification, scene);
        overlay = Blur(window);
        UIViewPropertyAnimator *enter = CSTestRunningAnimators().firstObject;
        CHECK(enter && fabs(enter.duration - 0.22) < 0.001);
        CHECK(overlay.alpha == 1 && overlay.effect && !overlay.userInteractionEnabled);
        NSUInteger started = CSTestAnimationStartCount;
        Post(UISceneWillDeactivateNotification, scene);
        CHECK(Blur(window) == overlay && CSTestAnimationStartCount == started);
        enter.fractionComplete = 0.45;
        Post(UISceneDidActivateNotification, scene);
        CHECK(Blur(window) == overlay && enter.reversed && enter.fractionComplete == 0.45);
        CHECK(CSTestAnimationStartCount == started);
        NSUInteger effectWrites = overlay.effectAssignmentCount;
        CSTestFinishAnimations();
        CHECK(!Blur(window));
        CHECK(overlay.effect == nil && overlay.effectAssignmentCount == effectWrites);

        // Fade out after a completed entry; re-entry reverses without recreating views.
        Post(UISceneWillDeactivateNotification, scene);
        overlay = Blur(window);
        effectWrites = overlay.effectAssignmentCount;
        CSTestFinishAnimations();
        overlay = Blur(window);
        CHECK(overlay.effect && CSTestRunningAnimators().count == 0);
        CHECK(overlay.effectAssignmentCount == effectWrites);
        Post(UISceneDidActivateNotification, scene);
        UIViewPropertyAnimator *leave = CSTestRunningAnimators().firstObject;
        CHECK(Blur(window) == overlay && fabs(leave.duration - 0.22) < 0.001);
        UIView *returnSnapshot = window.subviews.lastObject;
        CHECK(returnSnapshot != overlay && overlay.hidden && overlay.effect);
        CHECK(returnSnapshot.alpha == 0 && !returnSnapshot.userInteractionEnabled && returnSnapshot.accessibilityElementsHidden);
        CHECK(CGRectEqualToRect(returnSnapshot.frame, window.bounds));
        CHECK(overlay.effectAssignmentCount == effectWrites);
        NSUInteger captures = CSTestSnapshotCount;
        started = CSTestAnimationStartCount;
        Post(UISceneDidActivateNotification, scene);
        CHECK(CSTestAnimationStartCount == started);
        CHECK(CSTestSnapshotCount == captures && window.subviews.lastObject == returnSnapshot);
        Post(UISceneWillDeactivateNotification, scene);
        CHECK(leave.reversed && Blur(window) == overlay && CSTestAnimationStartCount == started);
        effectWrites = overlay.effectAssignmentCount;
        CSTestFinishAnimations();
        CHECK(Blur(window) == overlay && overlay.effect);
        CHECK(overlay.effectAssignmentCount == effectWrites);
        CHECK(!overlay.hidden && returnSnapshot.superview == nil);

        // Returning stays animated through duplicate app/scene/config notifications.
        Post(UISceneDidActivateNotification, scene);
        leave = CSTestRunningAnimators().firstObject;
        returnSnapshot = window.subviews.lastObject;
        started = CSTestAnimationStartCount;
        effectWrites = overlay.effectAssignmentCount;
        Post(UIApplicationDidBecomeActiveNotification, app);
        Post(@"com.wechat.tweak.settings_changed", nil);
        Post(@"com.wechat.tweak.local_settings_changed", nil);
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        Post(UISceneDidActivateNotification, scene);
        CHECK(Blur(window) == overlay && CSTestRunningAnimators().firstObject == leave);
        CHECK(CSTestAnimationStartCount == started && overlay.effectAssignmentCount == effectWrites);
        CHECK(!leave.reversed && fabs(leave.duration - 0.22) < 0.001);
        CSTestFinishAnimations();
        CHECK(!Blur(window) && overlay.effect != nil);
        CHECK(overlay.effectAssignmentCount == effectWrites);
        CHECK(returnSnapshot.superview == nil && overlay.superview == nil);
        Post(UISceneWillDeactivateNotification, scene);
        CSTestFinishAnimations();
        overlay = Blur(window);

        // Background seals a half-finished fade; an old completion cannot uncover it.
        Post(UISceneDidActivateNotification, scene);
        leave = CSTestRunningAnimators().firstObject;
        returnSnapshot = window.subviews.lastObject;
        CHECK(leave && Blur(window) == overlay);
        Post(UISceneDidEnterBackgroundNotification, scene);
        CHECK(Blur(window) == overlay && overlay.effect && CSTestRunningAnimators().count == 0);
        CHECK(!overlay.hidden && returnSnapshot.superview == nil);
        [leave testCompleteAtPosition:UIViewAnimatingPositionEnd];
        CHECK(Blur(window) == overlay && overlay.effect);
        Post(UISceneDidActivateNotification, scene);
        CSTestFinishAnimations();
        CHECK(!Blur(window));

        // A failed snapshot keeps the animated fallback and does not hide live blur.
        Post(UISceneWillDeactivateNotification, scene);
        CSTestFinishAnimations();
        overlay = Blur(window);
        CSTestSnapshotFails = YES;
        Post(UISceneDidActivateNotification, scene);
        CHECK(!overlay.hidden && window.subviews.lastObject == overlay);
        CHECK(CSTestRunningAnimators().count == 1 && overlay.effect == nil);
        CSTestFinishAnimations();
        CHECK(!Blur(window));
        CSTestSnapshotFails = NO;

        // Disable during the snapshot fade removes both views and invalidates callbacks.
        Post(UISceneWillDeactivateNotification, scene);
        CSTestFinishAnimations();
        overlay = Blur(window);
        Post(UISceneDidActivateNotification, scene);
        returnSnapshot = window.subviews.lastObject;
        leave = CSTestRunningAnimators().firstObject;
        [defaults setBool:NO forKey:CSBackgroundBlurEnabledKey];
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(!Blur(window) && returnSnapshot.superview == nil && CSTestRunningAnimators().count == 0);
        [leave testCompleteAtPosition:UIViewAnimatingPositionEnd];
        CHECK(!Blur(window) && returnSnapshot.superview == nil);
        [defaults setBool:YES forKey:CSBackgroundBlurEnabledKey];
        Post(CSBackgroundBlurSettingsChangedNotification, nil);

        // App-level background also seals an unfinished entry before scene delivery.
        Post(UISceneWillDeactivateNotification, scene);
        overlay = Blur(window);
        Post(UIApplicationDidEnterBackgroundNotification, app);
        CHECK(Blur(window) == overlay && overlay.effect && CSTestRunningAnimators().count == 0);
        Post(UIApplicationDidBecomeActiveNotification, app);
        Post(UISceneDidActivateNotification, scene);
        CSTestFinishAnimations();
        CHECK(!Blur(window) && !Blur(legacy));

        // Disabling/re-enabling during animation invalidates callbacks for old views.
        Post(UISceneWillDeactivateNotification, scene);
        enter = CSTestRunningAnimators().firstObject;
        overlay = Blur(window);
        [defaults setBool:NO forKey:CSBackgroundBlurEnabledKey];
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(!Blur(window) && CSTestRunningAnimators().count == 0);
        [defaults setBool:YES forKey:CSBackgroundBlurEnabledKey];
        Post(CSBackgroundBlurSettingsChangedNotification, nil);
        CHECK(Blur(window) && Blur(window) != overlay);
        [enter testCompleteAtPosition:UIViewAnimatingPositionEnd];
        CHECK(Blur(window) && Blur(window).effect);

        // Reduce Motion can settle an animation in flight and suppress future ones.
        Post(UISceneDidActivateNotification, scene);
        CHECK(CSTestRunningAnimators().count == 1);
        CSTestReduceMotionEnabled = YES;
        Post(UIAccessibilityReduceMotionStatusDidChangeNotification, nil);
        CHECK(!Blur(window) && CSTestRunningAnimators().count == 0);
        started = CSTestAnimationStartCount;
        Post(UISceneWillDeactivateNotification, scene);
        CHECK(Blur(window).effect && CSTestAnimationStartCount == started);
        Post(UISceneDidActivateNotification, scene);
        CHECK(!Blur(window) && CSTestAnimationStartCount == started);
        CSTestReduceMotionEnabled = NO;

        // Independent scenes can animate in opposite directions without restarting.
        Post(UISceneWillDeactivateNotification, scene);
        Post(UISceneWillDeactivateNotification, other);
        CHECK(CSTestRunningAnimators().count == 2);
        Post(UISceneDidActivateNotification, scene);
        CSTestFinishAnimations();
        CHECK(!Blur(window) && Blur(second).effect);
        Post(UISceneDidActivateNotification, other);
        CHECK(CSTestRunningAnimators().count == 1);
        Post(UISceneDidDisconnectNotification, other);
        CHECK(!Blur(second) && CSTestRunningAnimators().count == 0);
        Post(UISceneWillDeactivateNotification, scene);
        manager = nil;
        CHECK(!Blur(window) && CSTestRunningAnimators().count == 0);
        printf("Background blur: %lu behavioral checks passed (UIKit rendering requires device validation).\n", (unsigned long)checks);
    } @finally {
        [defaults removePersistentDomainForName:suite];
    }
    return 0;
} }
