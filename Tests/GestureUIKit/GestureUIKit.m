#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@implementation UIPanGestureRecognizer
- (CGPoint)translationInView:(UIView *)view { return self.testTranslation; }
- (CGPoint)velocityInView:(UIView *)view { return self.testVelocity; }
@end
@implementation UILongPressGestureRecognizer @end
@implementation UIScrollView @end
@implementation UINavigationController @end
static char navKey;
@implementation UIViewController (GestureUI)
- (UINavigationController *)navigationController { return objc_getAssociatedObject(self,&navKey); }
- (void)setNavigationController:(UINavigationController *)nav { objc_setAssociatedObject(self,&navKey,nav,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end
@implementation UIView (GestureUI)
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options animations:(void(^)(void))animations completion:(void(^)(BOOL))completion { animations(); if (completion) completion(YES); }
@end
NSUInteger CSGestureHaptics;
BOOL CSGestureReducedMotion;
BOOL UIAccessibilityIsReduceMotionEnabled(void) { return CSGestureReducedMotion; }
@implementation UIImpactFeedbackGenerator
- (instancetype)initWithStyle:(NSInteger)style { return [super init]; }
- (void)prepare {}
- (void)impactOccurred { CSGestureHaptics++; }
@end

NSUInteger CSGestureActiveRebounds, CSGestureStoppedRebounds;
@implementation UIViewPropertyAnimator {
    void(^_animations)(void);
    UIViewAnimatingState _state;
}
- (instancetype)initWithDuration:(NSTimeInterval)duration curve:(NSInteger)curve animations:(void(^)(void))animations {
    if ((self=[super init])) _animations=[animations copy]; return self;
}
- (UIViewAnimatingState)state { return _state; }
- (void)startAnimation { _state=UIViewAnimatingStateActive;CSGestureActiveRebounds++;_animations();_animations=nil; }
- (void)stopAnimation:(BOOL)withoutFinishing { if (_state==UIViewAnimatingStateActive) { CSGestureActiveRebounds--;CSGestureStoppedRebounds++; }_state=UIViewAnimatingStateStopped; }
@end
