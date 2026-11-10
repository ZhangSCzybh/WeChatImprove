// Host-only UIKit boundary for progress-overlay behavior tests. No native layout claim.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <dispatch/dispatch.h>

typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static const UIEdgeInsets UIEdgeInsetsZero={0,0,0,0};
static inline CGRect UIEdgeInsetsInsetRect(CGRect rect,UIEdgeInsets insets) {
    return CGRectMake(rect.origin.x+insets.left,rect.origin.y+insets.top,
                      rect.size.width-insets.left-insets.right,rect.size.height-insets.top-insets.bottom);
}
typedef NS_ENUM(NSInteger,UIGestureRecognizerState) {
    UIGestureRecognizerStatePossible,UIGestureRecognizerStateBegan,UIGestureRecognizerStateChanged,
    UIGestureRecognizerStateEnded,UIGestureRecognizerStateCancelled,UIGestureRecognizerStateFailed
};
typedef NS_ENUM(NSInteger,NSTextAlignment) { NSTextAlignmentCenter };
typedef NS_ENUM(NSInteger,UIUserInterfaceStyle) { UIUserInterfaceStyleUnspecified,UIUserInterfaceStyleLight,UIUserInterfaceStyleDark };
typedef NS_ENUM(NSInteger,UIRectCorner) { UIRectCornerAllCorners=15 };
typedef NS_ENUM(NSUInteger,UIRectEdge) { UIRectEdgeNone=0,UIRectEdgeTop=1,UIRectEdgeLeft=2,UIRectEdgeBottom=4,UIRectEdgeRight=8,UIRectEdgeAll=15 };
typedef uint64_t UIAccessibilityTraits;
enum { UIAccessibilityTraitAdjustable=1<<12,UIAccessibilityTraitStaticText=1<<6 };
typedef CGFloat UIFontWeight;
static const UIFontWeight UIFontWeightMedium=.23;

@class UIView,UIWindow,UIEvent,UIColor,UIFont,UIGestureRecognizer,UITouch,UIBezierPath;
@protocol UIGestureRecognizerDelegate <NSObject>
@optional
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)other;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other;
@end

@interface CSVoiceTestLayer : NSObject
@property(nonatomic) CGFloat cornerRadius;
@property(nonatomic) BOOL masksToBounds;
@property(nonatomic) CGRect frame;
@property(nonatomic,strong) CSVoiceTestLayer *mask;
@end
@interface CSVoiceTestShapeLayer : CSVoiceTestLayer
@property(nonatomic) CGPathRef path;
+ (instancetype)layer;
@end
@interface UIBezierPath : NSObject
@property(nonatomic,readonly) CGPathRef CGPath;
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius;
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)radii;
@end
@interface UIColor : NSObject
@property(nonatomic) CGFloat testRed,testGreen,testBlue,testAlpha;
+ (instancetype)clearColor;
+ (instancetype)systemBlueColor;
+ (instancetype)labelColor;
+ (instancetype)secondarySystemBackgroundColor;
+ (instancetype)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (instancetype)colorWithAlphaComponent:(CGFloat)alpha;
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
- (BOOL)getWhite:(CGFloat *)white alpha:(CGFloat *)alpha;
@end
@interface UIFont : NSObject
+ (instancetype)systemFontOfSize:(CGFloat)size;
+ (instancetype)monospacedDigitSystemFontOfSize:(CGFloat)size weight:(UIFontWeight)weight;
@end
@interface UITraitCollection : NSObject
@property(nonatomic) UIUserInterfaceStyle userInterfaceStyle;
@end
@interface UIResponder : NSObject
@property(nonatomic,weak) UIResponder *nextResponder;
@end
@interface UIView : UIResponder
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGPoint center;
@property(nonatomic) BOOL hidden,userInteractionEnabled,clipsToBounds,isAccessibilityElement;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic,strong) UIColor *backgroundColor,*tintColor;
@property(nonatomic,strong) UITraitCollection *traitCollection;
@property(nonatomic,weak) UIWindow *window;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,copy) NSArray<UIView *> *subviews;
@property(nonatomic,readonly) NSArray<UIGestureRecognizer *> *gestureRecognizers;
@property(nonatomic,strong,readonly) CSVoiceTestLayer *layer;
@property(nonatomic) UIEdgeInsets safeAreaInsets;
@property(nonatomic,copy) NSString *accessibilityLabel,*accessibilityValue;
@property(nonatomic) UIAccessibilityTraits accessibilityTraits;
@property(nonatomic) NSUInteger layoutRequests;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)sibling;
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)sibling;
- (void)bringSubviewToFront:(UIView *)view;
- (void)removeFromSuperview;
- (BOOL)isDescendantOfView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
- (void)layoutSubviews;
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture;
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gesture;
@end
@interface UIWindow : UIView @end
@interface UIImage : NSObject @end
@interface UIImageView : UIView @end
@interface UILabel : UIView
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,copy) NSString *text;
@property(nonatomic) NSTextAlignment textAlignment;
@property(nonatomic) NSInteger numberOfLines;
- (CGSize)sizeThatFits:(CGSize)size;
@end
@interface UIControl : UIView @end
@interface UIEvent : NSObject @end
@interface UIGestureRecognizer : NSObject
@property(nonatomic,weak) id<UIGestureRecognizerDelegate> delegate;
@property(nonatomic,weak) UIView *view;
@property(nonatomic) UIGestureRecognizerState state;
@property(nonatomic) BOOL enabled,delaysTouchesBegan,delaysTouchesEnded,cancelsTouchesInView;
@property(nonatomic) CGPoint testLocation;
@property(nonatomic,readonly) NSArray<UIGestureRecognizer *> *testFailureRequirements;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (CGPoint)locationInView:(UIView *)view;
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)other;
@end
@interface UIPanGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSUInteger minimumNumberOfTouches,maximumNumberOfTouches;
@property(nonatomic) CGPoint testTranslation,testVelocity;
- (CGPoint)translationInView:(UIView *)view;
- (CGPoint)velocityInView:(UIView *)view;
@end
@interface UITapGestureRecognizer : UIGestureRecognizer @end
@interface UILongPressGestureRecognizer : UIGestureRecognizer @end
@interface UIScreenEdgePanGestureRecognizer : UIPanGestureRecognizer
@property(nonatomic) UIRectEdge edges;
@end
@interface UITouch : NSObject
@property(nonatomic,weak) UIView *view;
@property(nonatomic) CGPoint testLocation;
- (CGPoint)locationInView:(UIView *)view;
@end
@interface UIScrollView : UIView
@property(nonatomic,strong) UIPanGestureRecognizer *panGestureRecognizer;
@end
@class UINavigationController;
@interface UIViewController : UIResponder
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) UINavigationController *navigationController;
@end
@interface UINavigationController : UIViewController
@property(nonatomic,strong) UIGestureRecognizer *interactivePopGestureRecognizer;
@end
