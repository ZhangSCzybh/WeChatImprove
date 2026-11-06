#import "../../TimeUIKit/UIKit/UIKit.h"
typedef NS_ENUM(NSInteger, UIGestureRecognizerState) {
 UIGestureRecognizerStatePossible, UIGestureRecognizerStateBegan, UIGestureRecognizerStateChanged,
 UIGestureRecognizerStateEnded, UIGestureRecognizerStateCancelled, UIGestureRecognizerStateFailed
};
@interface UIPanGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSUInteger minimumNumberOfTouches, maximumNumberOfTouches;
@property(nonatomic) CGPoint testTranslation, testVelocity;
- (CGPoint)translationInView:(UIView *)view;
- (CGPoint)velocityInView:(UIView *)view;
@end
@interface UILongPressGestureRecognizer : UIGestureRecognizer @end
@interface UIScrollView : UIView
@property(nonatomic) CGSize contentSize;
@property(nonatomic) BOOL scrollEnabled;
@property(nonatomic,strong) UIPanGestureRecognizer *panGestureRecognizer;
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) UIGestureRecognizer *interactivePopGestureRecognizer;
@end
@interface UIViewController (GestureUI)
@property(nonatomic,strong) UINavigationController *navigationController;
@end
@interface UIView (GestureUI)
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options animations:(void(^)(void))animations completion:(void(^)(BOOL))completion;
@end
enum { UIViewAnimationOptionBeginFromCurrentState=1, UIViewAnimationOptionAllowUserInteraction=2, UIImpactFeedbackStyleMedium=1 };
@interface UIImpactFeedbackGenerator : NSObject
- (instancetype)initWithStyle:(NSInteger)style;
- (void)prepare;
- (void)impactOccurred;
@end
extern NSUInteger CSGestureHaptics;
extern BOOL CSGestureReducedMotion;
BOOL UIAccessibilityIsReduceMotionEnabled(void);

typedef NS_ENUM(NSInteger, UIViewAnimatingState) { UIViewAnimatingStateInactive,UIViewAnimatingStateActive,UIViewAnimatingStateStopped };
enum { UIViewAnimationCurveEaseOut=1 };
@interface UIViewPropertyAnimator : NSObject
@property(nonatomic,readonly) UIViewAnimatingState state;
- (instancetype)initWithDuration:(NSTimeInterval)duration curve:(NSInteger)curve animations:(void(^)(void))animations;
- (void)startAnimation;
- (void)stopAnimation:(BOOL)withoutFinishing;
@end
extern NSUInteger CSGestureActiveRebounds, CSGestureStoppedRebounds;
