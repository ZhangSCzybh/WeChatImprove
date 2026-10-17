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
typedef NS_OPTIONS(NSUInteger, UIControlEvents) { UIControlEventTouchDown=1,UIControlEventTouchUpInside=2 };
typedef NS_ENUM(NSInteger, UIBlurEffectStyle) { UIBlurEffectStyleSystemMaterial };
extern NSString *const UIAccessibilityReduceMotionStatusDidChangeNotification;
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
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) BOOL hidden,clipsToBounds,userInteractionEnabled;
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
- (UIView *)hitTest:(CGPoint)point withEvent:(id)event;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
@end
@interface UIWindow : UIView
@property(nonatomic) UIEdgeInsets safeAreaInsets;
@end
@interface UIEvent : NSObject @end
@interface UIImage : NSObject
@property(nonatomic,copy) NSString *path;
+ (instancetype)imageWithContentsOfFile:(NSString *)path;
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
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events;
- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events;
- (void)sendActionsForControlEvents:(UIControlEvents)events;
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
