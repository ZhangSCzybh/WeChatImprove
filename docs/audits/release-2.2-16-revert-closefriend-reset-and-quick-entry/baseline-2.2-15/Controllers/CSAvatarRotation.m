#import "CSAvatarRotation.h"
#import "CSPreferenceRefresh.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <math.h>

static NSString *const CSRotationKey = @"cs.avatar.rotation";
static char CSRotationTrackedKey, CSRotationPageHiddenKey;
static NSHashTable<UIView *> *CSRotationViews;
static NSHashTable *CSRotationInactiveScenes;
static NSUserDefaults *CSRotationDefaults;
static BOOL CSRotationEnabled, CSRotationInactive;
static NSTimeInterval CSRotationDuration = 7;
static atomic_bool CSRotationRefreshPending;

static BOOL CSRotationCanRun(UIView *view) {
    UIWindow *window = view.window;
    if (!CSRotationEnabled || view.tag != 101 || CSRotationInactive || !window ||
        UIApplication.sharedApplication.applicationState != UIApplicationStateActive ||
        UIAccessibilityIsReduceMotionEnabled() ||
        NSProcessInfo.processInfo.thermalState >= NSProcessInfoThermalStateSerious) return NO;
    if (window.windowScene && ([CSRotationInactiveScenes containsObject:window.windowScene] ||
        window.windowScene.activationState != UISceneActivationStateForegroundActive)) return NO;
    CGRect visible = [view convertRect:view.bounds toView:window];
    if (CGRectIsEmpty(visible) || CGRectIsNull(visible)) return NO;
    for (UIView *ancestor = view; ancestor; ancestor = ancestor.superview) {
        if (ancestor.hidden || ancestor.alpha < .01 ||
            [objc_getAssociatedObject(ancestor, &CSRotationPageHiddenKey) boolValue]) return NO;
        if (ancestor.clipsToBounds || ancestor == window) {
            visible = CGRectIntersection(visible, [ancestor convertRect:ancestor.bounds toView:window]);
            if (CGRectIsEmpty(visible) || CGRectIsNull(visible)) return NO;
        }
    }
    return YES;
}

void CSAvatarRotationUpdate(UIView *view) {
    if (!view || !NSThread.isMainThread) return;
    BOOL tracked = [objc_getAssociatedObject(view, &CSRotationTrackedKey) boolValue];
    if (view.tag != 101 && !tracked) return;
    if (!tracked) {
        if (!CSRotationViews) CSRotationViews = [NSHashTable weakObjectsHashTable];
        [CSRotationViews addObject:view];
        objc_setAssociatedObject(view, &CSRotationTrackedKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    CAAnimation *existing = [view.layer animationForKey:CSRotationKey];
    if (!CSRotationCanRun(view)) {
        if (existing) [view.layer removeAnimationForKey:CSRotationKey];
        return;
    }
    // Inspect CA itself: suspension can remove an animation while a cached flag stays set.
    if (existing && fabs(existing.duration - CSRotationDuration) < .0001) return;
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = @(M_PI * 2);
    rotation.duration = CSRotationDuration;
    rotation.cumulative = YES;
    rotation.repeatCount = HUGE_VALF;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:rotation forKey:CSRotationKey];
}

void CSAvatarRotationRefreshViews(void) {
    if (!NSThread.isMainThread) return;
    for (UIView *view in CSRotationViews.allObjects) CSAvatarRotationUpdate(view);
}

void CSAvatarRotationPageVisibility(UIViewController *controller, BOOL visible) {
    if (!NSThread.isMainThread) return;
    UIView *root = controller.viewIfLoaded;
    if (!root) return;
    objc_setAssociatedObject(root, &CSRotationPageHiddenKey, @(!visible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSAvatarRotationRefreshViews();
}

static BOOL CSRotationLoadPreferences(void) {
    BOOL enabled = [CSRotationDefaults boolForKey:@"rotateAvatar"];
    double speed = [CSRotationDefaults doubleForKey:@"rotateSpeed"];
    if (!isfinite(speed) || speed == 0) speed = 5;
    NSTimeInterval duration = 12 - MIN(10, MAX(1, speed));
    BOOL changed = enabled != CSRotationEnabled || duration != CSRotationDuration;
    CSRotationEnabled = enabled;
    CSRotationDuration = duration;
    return changed;
}

void CSAvatarRotationPreferencesChanged(void) {
    CSRequestMainRefresh(&CSRotationRefreshPending, ^{
        if (CSRotationLoadPreferences()) CSAvatarRotationRefreshViews();
    });
}

static void CSRotationDarwinChanged(CFNotificationCenterRef center, void *observer, CFStringRef name,
                                    const void *object, CFDictionaryRef info) {
    CSAvatarRotationPreferencesChanged();
}

void CSAvatarRotationInstall(NSUserDefaults *defaults) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSRotationDefaults = defaults;
        CSRotationInactiveScenes = [NSHashTable weakObjectsHashTable];
        CSRotationLoadPreferences();
        NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
        for (NSString *name in @[NSUserDefaultsDidChangeNotification, @"com.wechat.tweak.local_settings_changed"]) {
            [center addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification *note) {
                CSAvatarRotationPreferencesChanged();
            }];
        }
        for (NSString *name in @[UIApplicationWillResignActiveNotification, UIApplicationDidBecomeActiveNotification,
             UISceneWillDeactivateNotification, UISceneDidActivateNotification,
             NSProcessInfoThermalStateDidChangeNotification, UIAccessibilityReduceMotionStatusDidChangeNotification]) {
            [center addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification *note) {
                void (^update)(void) = ^{
                    if ([note.name isEqual:UIApplicationWillResignActiveNotification]) CSRotationInactive = YES;
                    if ([note.name isEqual:UIApplicationDidBecomeActiveNotification]) {
                        CSRotationInactive = NO;
                        CSAvatarRotationPreferencesChanged();
                    }
                    if (note.object && [note.name isEqual:UISceneWillDeactivateNotification]) [CSRotationInactiveScenes addObject:note.object];
                    if (note.object && [note.name isEqual:UISceneDidActivateNotification]) [CSRotationInactiveScenes removeObject:note.object];
                    CSAvatarRotationRefreshViews();
                };
                if (NSThread.isMainThread) update(); else dispatch_async(dispatch_get_main_queue(), update);
            }];
        }
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, CSRotationDarwinChanged,
            CFSTR("com.wechat.enhance.settings_changed"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    });
}
