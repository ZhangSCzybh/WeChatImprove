// Lifecycle/view doubles only; no claim to reproduce UIKit blur or switcher rendering.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <dispatch/dispatch.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, UIApplicationState) { UIApplicationStateActive, UIApplicationStateInactive, UIApplicationStateBackground };
typedef NS_ENUM(NSInteger, UISceneActivationState) { UISceneActivationStateUnattached = -1, UISceneActivationStateForegroundActive, UISceneActivationStateForegroundInactive, UISceneActivationStateBackground };
typedef NS_ENUM(NSInteger, UIBlurEffectStyle) { UIBlurEffectStyleRegular };
typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) { UIViewAutoresizingFlexibleWidth = 2, UIViewAutoresizingFlexibleHeight = 16 };
typedef NS_ENUM(NSInteger, UIViewAnimationCurve) { UIViewAnimationCurveEaseInOut };
typedef NS_ENUM(NSInteger, UIViewAnimatingState) { UIViewAnimatingStateInactive, UIViewAnimatingStateActive, UIViewAnimatingStateStopped };
typedef NS_ENUM(NSInteger, UIViewAnimatingPosition) { UIViewAnimatingPositionEnd, UIViewAnimatingPositionStart, UIViewAnimatingPositionCurrent };

extern NSString * const UIApplicationWillResignActiveNotification;
extern NSString * const UIApplicationDidEnterBackgroundNotification;
extern NSString * const UIApplicationDidBecomeActiveNotification;
extern NSString * const UIApplicationProtectedDataWillBecomeUnavailable;
extern NSString * const UISceneWillDeactivateNotification;
extern NSString * const UISceneDidEnterBackgroundNotification;
extern NSString * const UISceneDidActivateNotification;
extern NSString * const UISceneDidDisconnectNotification;
extern NSString * const UIWindowDidBecomeVisibleNotification;
extern NSString * const UIWindowDidBecomeHiddenNotification;
extern NSString * const UIAccessibilityReduceMotionStatusDidChangeNotification;
extern BOOL CSTestReduceMotionEnabled;
extern BOOL CSTestCompleteAnimationsImmediately;
extern NSUInteger CSTestAnimationStartCount;
extern BOOL CSTestSnapshotFails;
extern NSUInteger CSTestSnapshotCount;
extern NSUInteger CSTestAnimationSuppressionDepth;
BOOL UIAccessibilityIsReduceMotionEnabled(void);

@interface UIViewPropertyAnimator : NSObject
@property(nonatomic) BOOL reversed;
@property(nonatomic) CGFloat fractionComplete;
@property(nonatomic) UIViewAnimatingState state;
@property(nonatomic, readonly) NSTimeInterval duration;
- (instancetype)initWithDuration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve animations:(void (^)(void))animations;
- (void)addCompletion:(void (^)(UIViewAnimatingPosition))completion;
- (void)startAnimation;
- (void)stopAnimation:(BOOL)withoutFinishing;
// Test-only: explicitly deliver completions, including a cancelled stale callback.
- (void)testCompleteAtPosition:(UIViewAnimatingPosition)position;
@end
NSArray<UIViewPropertyAnimator *> *CSTestRunningAnimators(void);
void CSTestFinishAnimations(void);

@interface UIView : NSObject
@property(nonatomic) CGRect frame, bounds;
@property(nonatomic) BOOL hidden, userInteractionEnabled, accessibilityElementsHidden;
@property(nonatomic) BOOL accessibilityViewIsModal;
@property(nonatomic) BOOL isAccessibilityElement;
@property(nonatomic,strong) id accessibilityElements;
@property(nonatomic,readonly) CALayer *layer;
@property(nonatomic,readonly) UIView *window;
@property(nonatomic,strong) id backgroundColor;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) UIViewAutoresizing autoresizingMask;
@property(nonatomic, weak) UIView *superview;
@property(nonatomic, strong) NSMutableArray<UIView *> *subviews;
+ (void)performWithoutAnimation:(void (^)(void))actions;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)bringSubviewToFront:(UIView *)view;
- (void)removeFromSuperview;
- (void)layoutIfNeeded;
- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;
- (void)testApplyAnimatedAlpha:(CGFloat)alpha;
@end
@interface UIColor : NSObject
+ (instancetype)systemBackgroundColor;
+ (instancetype)secondaryLabelColor;
@end
typedef NS_ENUM(NSInteger, NSTextAlignment) { NSTextAlignmentCenter = 1 };
#define UIFontTextStyleBody @"body"
@interface UIFont : NSObject
+ (instancetype)preferredFontForTextStyle:(NSString *)style;
@end
@interface UILabel : UIView
@property(nonatomic,copy) NSString *text;
@property(nonatomic) NSTextAlignment textAlignment;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong) UIFont *font;
@end
@interface UITableViewCell : UIView @end
@interface UITableView : UIView
@property(nonatomic) CGSize contentSize;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) double decelerationRate;
@property(nonatomic,strong) id tableHeaderView;
@property(nonatomic,copy) NSArray<UITableViewCell *> *visibleCells;
@property(nonatomic) NSUInteger reloads;
- (void)setEditing:(BOOL)value animated:(BOOL)animated;
- (void)reloadData;
@end
@interface UIViewController : NSObject @end
@class UIWindowScene;
@interface UIWindow : UIView
@property(nonatomic, weak) UIWindowScene *windowScene;
@property(nonatomic, strong) UIViewController *rootViewController;
@end
@interface UIScene : NSObject
@property(nonatomic) UISceneActivationState activationState;
@end
@interface UIWindowScene : UIScene
@property(nonatomic, copy) NSArray<UIWindow *> *windows;
@end
@interface UIApplication : NSObject
+ (instancetype)sharedApplication;
@property(nonatomic) UIApplicationState applicationState;
@property(nonatomic, copy) NSSet<UIScene *> *connectedScenes;
@property(nonatomic, copy) NSArray<UIWindow *> *windows;
@end
@interface UIBlurEffect : NSObject
+ (instancetype)effectWithStyle:(UIBlurEffectStyle)style;
@end
@interface UIVisualEffectView : UIView
@property(nonatomic, strong) UIBlurEffect *effect;
@property(nonatomic, readonly) NSUInteger effectAssignmentCount;
- (void)testApplyAnimatedEffect:(UIBlurEffect *)effect;
- (instancetype)initWithEffect:(UIBlurEffect *)effect;
@end
