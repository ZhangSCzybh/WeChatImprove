// Host-side behavioral doubles. They do not simulate UIKit rendering or WeChat transitions.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <dispatch/dispatch.h>
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
typedef NS_ENUM(NSInteger, UIViewContentMode) { UIViewContentModeScaleToFill, UIViewContentModeScaleAspectFit };
typedef NS_ENUM(NSInteger, UIUserInterfaceLayoutDirection) { UIUserInterfaceLayoutDirectionLeftToRight, UIUserInterfaceLayoutDirectionRightToLeft };
typedef NS_ENUM(NSInteger, UIUserInterfaceStyle) { UIUserInterfaceStyleUnspecified,UIUserInterfaceStyleLight,UIUserInterfaceStyleDark };
typedef NS_ENUM(NSInteger, UIImpactFeedbackStyle) { UIImpactFeedbackStyleLight,UIImpactFeedbackStyleMedium,UIImpactFeedbackStyleHeavy,UIImpactFeedbackStyleSoft };
typedef NS_OPTIONS(NSUInteger, UIControlEvents) {
    UIControlEventTouchDown=1<<0,
    UIControlEventTouchDragInside=1<<2,
    UIControlEventTouchDragOutside=1<<3,
    UIControlEventTouchUpInside=1<<6,
    UIControlEventTouchUpOutside=1<<7,
    UIControlEventTouchCancel=1<<8,
    UIControlEventAllEvents=0xFFFFFFFFU,
};
typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
    UIViewAnimationOptionAllowUserInteraction=1<<1,
    UIViewAnimationOptionBeginFromCurrentState=1<<2,
    UIViewAnimationOptionCurveEaseInOut=0<<16,
    UIViewAnimationOptionCurveEaseIn=1<<16,
    UIViewAnimationOptionCurveEaseOut=2<<16,
    UIViewAnimationOptionCurveLinear=3<<16,
};
@interface CSTestViewAnimation : NSObject
@property(nonatomic) NSTimeInterval duration,delay;
@property(nonatomic) CGFloat damping,velocity;
@property(nonatomic) UIViewAnimationOptions options;
@property(nonatomic) BOOL spring;
@end
extern NSMutableArray<CSTestViewAnimation *> *CSTestViewAnimations;
// 0=direct write, 1=ordinary animation, 2=spring animation for the visible indicator.
extern NSMutableArray<NSNumber *> *CSTestIndicatorFrameWrites;
typedef NS_ENUM(NSInteger, UIBlurEffectStyle) { UIBlurEffectStyleSystemMaterial };
extern NSString *const UIAccessibilityReduceMotionStatusDidChangeNotification;
extern NSString *const UIApplicationDidBecomeActiveNotification;
extern NSString *const UISceneDidActivateNotification;
extern BOOL CSTestReduceMotionEnabled;
extern NSUInteger CSTestHapticCount;
extern NSString *const UIApplicationWillResignActiveNotification;
extern NSString *const UISceneWillDeactivateNotification;
typedef NS_ENUM(NSInteger, UIApplicationState) { UIApplicationStateActive, UIApplicationStateInactive, UIApplicationStateBackground };
typedef NS_ENUM(NSInteger, UISceneActivationState) { UISceneActivationStateForegroundActive, UISceneActivationStateForegroundInactive, UISceneActivationStateBackground };
@interface UIApplication : NSObject
@property(nonatomic) UIApplicationState applicationState;
+ (instancetype)sharedApplication;
@end
@interface UIWindowScene : NSObject
@property(nonatomic) UISceneActivationState activationState;
@end
BOOL UIAccessibilityIsReduceMotionEnabled(void);
@class UIWindow, UIColor, UIViewController;
@interface UITraitCollection : NSObject
@property(nonatomic) UIUserInterfaceStyle userInterfaceStyle;
@end
@interface UIColor : NSObject
@property(nonatomic,readonly) CGColorRef CGColor;
@property(nonatomic) CGFloat red,green,blue,alpha;
+ (instancetype)clearColor;
+ (instancetype)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)trait;
@end
@interface UIView : NSObject
+ (void)performWithoutAnimation:(void (^)(void))actions;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGPoint center;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) BOOL hidden,clipsToBounds,userInteractionEnabled,isAccessibilityElement;
@property(nonatomic) UIViewContentMode contentMode;
@property(nonatomic) UIUserInterfaceLayoutDirection effectiveUserInterfaceLayoutDirection;
@property(nonatomic,strong) CALayer *layer;
@property(nonatomic,strong) UIColor *backgroundColor;
@property(nonatomic,strong) UITraitCollection *traitCollection;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,readonly) UIWindow *window;
@property(nonatomic,strong) NSMutableArray<UIView *> *subviews;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)removeFromSuperview;
- (BOOL)isDescendantOfView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
- (UIView *)hitTest:(CGPoint)point withEvent:(id)event;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
@end
@interface UIWindow : UIView
@property(nonatomic,strong) UIWindowScene *windowScene;
@property(nonatomic) UIEdgeInsets safeAreaInsets;
@end
@interface UITouch : NSObject
@property(nonatomic) CGPoint testLocation;
@property(nonatomic,weak) UIView *testView;
- (CGPoint)locationInView:(UIView *)view;
@end
@interface UIEvent : NSObject
@property(nonatomic,copy) NSSet<UITouch *> *allTouches;
- (NSSet<UITouch *> *)touchesForView:(UIView *)view;
@end
@interface UIImage : NSObject
@property(nonatomic,copy) NSString *path;
@property(nonatomic,strong) UIImage *sourceImage;
@property(nonatomic,strong) UIColor *appliedTint;
@property(nonatomic) CGSize renderedSize;
+ (instancetype)imageWithContentsOfFile:(NSString *)path;
- (UIImage *)imageWithTintColor:(UIColor *)color renderingMode:(NSInteger)mode;
@end
typedef NS_ENUM(NSInteger, UIImageRenderingMode) { UIImageRenderingModeAutomatic,UIImageRenderingModeAlwaysOriginal,UIImageRenderingModeAlwaysTemplate };
@interface UIGraphicsImageRendererContext : NSObject
@property(nonatomic,readonly) CGContextRef CGContext;
@end
@interface UIGraphicsImageRenderer : NSObject
- (instancetype)initWithSize:(CGSize)size;
- (UIImage *)imageWithActions:(void (^)(UIGraphicsImageRendererContext *context))actions;
@end
@interface UIImageView : UIView
@property(nonatomic,strong) UIImage *image;
@end
@interface UIFont : NSObject
@property(nonatomic) CGFloat lineHeight;
@end
@interface UILabel : UIView
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,copy) NSString *text;
@end
@interface UIControl : UIView
@property(nonatomic,strong) NSMutableArray *actions;
@property(nonatomic) BOOL enabled;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events;
- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events;
- (void)sendActionsForControlEvents:(UIControlEvents)events;
- (void)sendActionsForControlEvents:(UIControlEvents)events withEvent:(UIEvent *)event;
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
- (void)cancelTrackingWithEvent:(UIEvent *)event;
@end
@interface UITabBarItem : NSObject @end
@interface UITabBar : UIView
@property(nonatomic,copy) NSArray *items;
@end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,readonly) UIView *viewIfLoaded;
@end
@interface UITabBarController : UIViewController
@property(nonatomic,strong) UIViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;
@property(nonatomic,strong) UITabBar *tabBar;
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) NSArray *viewControllers;
@property(nonatomic,strong) UIViewController *topViewController;
@end
@interface UIScrollView : UIView
@property(nonatomic) UIEdgeInsets contentInset,verticalScrollIndicatorInsets;
@property(nonatomic) CGFloat systemBottom;
@property(nonatomic,readonly) UIEdgeInsets adjustedContentInset;
@end
@interface UITableView : UIScrollView @end
@interface UIBlurEffect : NSObject
+ (instancetype)effectWithStyle:(UIBlurEffectStyle)style;
@end
@interface UIVisualEffectView : UIView
- (instancetype)initWithEffect:(UIBlurEffect *)effect;
@end
@interface UIBezierPath : NSObject
@property(nonatomic,readonly) CGPathRef CGPath;
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius;
- (BOOL)containsPoint:(CGPoint)point;
@end
@interface UIImpactFeedbackGenerator : NSObject
- (instancetype)initWithStyle:(UIImpactFeedbackStyle)style;
- (void)impactOccurred;
@end
