#import <UIKit/UIKit.h>
#define NOTIFICATION(name) NSString * const name = @#name
NOTIFICATION(UIApplicationWillResignActiveNotification);
NOTIFICATION(UIApplicationDidEnterBackgroundNotification);
NOTIFICATION(UIApplicationDidBecomeActiveNotification);
NOTIFICATION(UISceneWillDeactivateNotification);
NOTIFICATION(UISceneDidEnterBackgroundNotification);
NOTIFICATION(UISceneDidActivateNotification);
NOTIFICATION(UISceneDidDisconnectNotification);
NOTIFICATION(UIWindowDidBecomeVisibleNotification);
NOTIFICATION(UIWindowDidBecomeHiddenNotification);
NOTIFICATION(UIAccessibilityReduceMotionStatusDidChangeNotification);

BOOL CSTestReduceMotionEnabled = NO;
BOOL CSTestCompleteAnimationsImmediately = YES;
NSUInteger CSTestAnimationStartCount;
BOOL CSTestSnapshotFails;
NSUInteger CSTestSnapshotCount;
static NSMutableArray<UIViewPropertyAnimator *> *running;
static UIViewPropertyAnimator *recordingAnimator;
@interface UIViewPropertyAnimator ()
- (void)recordEffectForView:(UIVisualEffectView *)view from:(UIBlurEffect *)from to:(UIBlurEffect *)to;
- (void)recordAlphaForView:(UIView *)view from:(CGFloat)from to:(CGFloat)to;
@end
BOOL UIAccessibilityIsReduceMotionEnabled(void) { return CSTestReduceMotionEnabled; }
NSArray<UIViewPropertyAnimator *> *CSTestRunningAnimators(void) { return running.copy ?: @[]; }
void CSTestFinishAnimations(void) {
    for (UIViewPropertyAnimator *animator in CSTestRunningAnimators()) {
        [animator testCompleteAtPosition:animator.reversed ? UIViewAnimatingPositionStart : UIViewAnimatingPositionEnd];
    }
}
@implementation UIViewPropertyAnimator {
    void (^_animations)(void);
    NSMutableArray *_completions;
    NSMutableArray *_effectChanges;
    NSMutableArray *_alphaChanges;
}
- (instancetype)initWithDuration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve animations:(void (^)(void))animations {
    if ((self = [super init])) {
        _duration = duration; _animations = [animations copy]; _completions = [NSMutableArray array];
        _effectChanges = [NSMutableArray array];
        _alphaChanges = [NSMutableArray array];
    }
    return self;
}
- (void)addCompletion:(void (^)(UIViewAnimatingPosition))completion { [_completions addObject:[completion copy]]; }
- (void)startAnimation {
    if (!running) running = [NSMutableArray array];
    [running addObject:self]; self.state = UIViewAnimatingStateActive; CSTestAnimationStartCount++;
    recordingAnimator = self;
    _animations(); _animations = nil;
    recordingAnimator = nil;
    if (CSTestCompleteAnimationsImmediately) [self testCompleteAtPosition:UIViewAnimatingPositionEnd];
}
- (void)stopAnimation:(BOOL)withoutFinishing {
    self.state = UIViewAnimatingStateInactive; _animations = nil; [running removeObjectIdenticalTo:self];
    [_effectChanges removeAllObjects];
    [_alphaChanges removeAllObjects];
    // Keep completions for the test that injects a callback after cancellation.
}
- (void)testCompleteAtPosition:(UIViewAnimatingPosition)position {
    self.state = UIViewAnimatingStateInactive; [running removeObjectIdenticalTo:self];
    // UIKit restores the initial value when a reversed animator completes at start.
    // Model that endpoint separately from application calls to the effect setter.
    if (position != UIViewAnimatingPositionCurrent) {
        for (NSArray *change in _effectChanges) {
            id effect = change[position == UIViewAnimatingPositionStart ? 1 : 2];
            [change[0] testApplyAnimatedEffect:effect == NSNull.null ? nil : effect];
        }
        for (NSArray *change in _alphaChanges) {
            [change[0] testApplyAnimatedAlpha:[change[position == UIViewAnimatingPositionStart ? 1 : 2] doubleValue]];
        }
    }
    [_effectChanges removeAllObjects];
    [_alphaChanges removeAllObjects];
    NSArray *completions = _completions.copy; [_completions removeAllObjects];
    for (void (^completion)(UIViewAnimatingPosition) in completions) completion(position);
}
- (void)recordEffectForView:(UIVisualEffectView *)view from:(UIBlurEffect *)from to:(UIBlurEffect *)to {
    [_effectChanges addObject:@[view, from ?: NSNull.null, to ?: NSNull.null]];
}
- (void)recordAlphaForView:(UIView *)view from:(CGFloat)from to:(CGFloat)to {
    [_alphaChanges addObject:@[view, @(from), @(to)]];
}
@end

@implementation UIView
- (instancetype)init {
    if ((self = [super init])) { _alpha = 1; _userInteractionEnabled = YES; _subviews = [NSMutableArray array]; }
    return self;
}
+ (void)performWithoutAnimation:(void (^)(void))actions { actions(); }
- (void)setFrame:(CGRect)frame { _frame = frame; _bounds.size = frame.size; }
- (void)addSubview:(UIView *)view { [view removeFromSuperview]; view.superview = self; [self.subviews addObject:view]; }
- (void)bringSubviewToFront:(UIView *)view {
    if (view.superview == self) { [self.subviews removeObjectIdenticalTo:view]; [self.subviews addObject:view]; }
}
- (void)removeFromSuperview { [self.superview.subviews removeObjectIdenticalTo:self]; self.superview = nil; }
- (void)layoutIfNeeded {}
- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates {
    CSTestSnapshotCount++;
    if (CSTestSnapshotFails) return nil;
    UIView *snapshot = [UIView new]; snapshot.frame = self.bounds; return snapshot;
}
- (void)setAlpha:(CGFloat)alpha {
    [recordingAnimator recordAlphaForView:self from:_alpha to:alpha]; _alpha = alpha;
}
- (void)testApplyAnimatedAlpha:(CGFloat)alpha { _alpha = alpha; }
@end
@implementation UIViewController @end
@implementation UIWindow @end
@implementation UIScene @end
@implementation UIWindowScene @end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; if (!app) app = [self new]; return app; }
@end
@implementation UIBlurEffect
+ (instancetype)effectWithStyle:(UIBlurEffectStyle)style { return [self new]; }
@end
@implementation UIVisualEffectView
- (instancetype)initWithEffect:(UIBlurEffect *)effect { if ((self = [super init])) _effect = effect; return self; }
- (void)setEffect:(UIBlurEffect *)effect {
    [recordingAnimator recordEffectForView:self from:_effect to:effect];
    _effect = effect; _effectAssignmentCount++;
}
- (void)testApplyAnimatedEffect:(UIBlurEffect *)effect { _effect = effect; }
@end
