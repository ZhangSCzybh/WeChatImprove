#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>

@interface NSValue (UIProbeGeometry)
+ (instancetype)valueWithCGPoint:(CGPoint)value;
+ (instancetype)valueWithCGSize:(CGSize)value;
@end
@implementation NSValue (UIProbeGeometry)
+ (instancetype)valueWithCGPoint:(CGPoint)value { return [self valueWithBytes:&value objCType:@encode(CGPoint)]; }
+ (instancetype)valueWithCGSize:(CGSize)value { return [self valueWithBytes:&value objCType:@encode(CGSize)]; }
@end

static NSUInteger Writes, Measurements, Invalidations, SynchronousLayouts, Checks, Failures;
static BOOL AnimationEnabled=YES, ReducedMotion=NO;
static void ResetCounters(void) { Writes=Measurements=Invalidations=SynchronousLayouts=0; }
static void Check(BOOL condition, NSString *name) {
    Checks++;
    if (!condition) { Failures++; fprintf(stderr,"FAIL: %s\n",name.UTF8String); }
}

@interface UIProbeLayer : CALayer @end
@implementation UIProbeLayer
- (void)setFrame:(CGRect)v { Writes++; [super setFrame:v]; }
- (void)setBounds:(CGRect)v { Writes++; [super setBounds:v]; }
- (void)setPosition:(CGPoint)v { Writes++; [super setPosition:v]; }
- (void)setOpacity:(float)v { Writes++; [super setOpacity:v]; }
- (void)setTransform:(CATransform3D)v { Writes++; [super setTransform:v]; }
- (void)setCornerRadius:(CGFloat)v { Writes++; [super setCornerRadius:v]; }
- (void)setBackgroundColor:(CGColorRef)v { Writes++; [super setBackgroundColor:v]; }
- (void)addAnimation:(CAAnimation *)v forKey:(NSString *)key { Writes++; [super addAnimation:v forKey:key]; }
- (void)removeAnimationForKey:(NSString *)key { Writes++; [super removeAnimationForKey:key]; }
@end
#define CALayer UIProbeLayer

@interface UITraitCollection : NSObject
@property CGFloat fontScale;
@end
@implementation UITraitCollection
- (instancetype)init { if ((self=[super init])) _fontScale=1; return self; }
@end

@interface UIFont : NSObject
@property CGFloat pointSize;
@property BOOL bold;
@property(readonly) CGFloat lineHeight;
+ (instancetype)systemFontOfSize:(CGFloat)size;
+ (instancetype)boldSystemFontOfSize:(CGFloat)size;
@end
@implementation UIFont
+ (instancetype)systemFontOfSize:(CGFloat)size { UIFont *f=[self new]; f.pointSize=size; return f; }
+ (instancetype)boldSystemFontOfSize:(CGFloat)size { UIFont *f=[self systemFontOfSize:size]; f.bold=YES; return f; }
- (CGFloat)lineHeight { return ceil(self.pointSize*1.2); }
- (BOOL)isEqual:(id)o { return [o isKindOfClass:UIFont.class] && self.pointSize==[o pointSize] && self.bold==[o bold]; }
@end
static NSString *const UIFontTextStyleSubheadline=@"subheadline";
static NSString *const UIFontTextStyleCaption2=@"caption";
static NSString *const NSFontAttributeName=@"font";
@interface UIFontMetrics : NSObject
+ (instancetype)metricsForTextStyle:(NSString *)style;
- (UIFont *)scaledFontForFont:(UIFont *)font compatibleWithTraitCollection:(UITraitCollection *)trait;
@end
@implementation UIFontMetrics
+ (instancetype)metricsForTextStyle:(NSString *)style { return [self new]; }
- (UIFont *)scaledFontForFont:(UIFont *)font compatibleWithTraitCollection:(UITraitCollection *)trait {
    UIFont *result=[UIFont systemFontOfSize:font.pointSize*(trait ? trait.fontScale : 1)]; result.bold=font.bold; return result;
}
@end
@interface NSString (UIProbeMeasurement)
- (CGSize)sizeWithAttributes:(NSDictionary *)attributes;
@end
@implementation NSString (UIProbeMeasurement)
- (CGSize)sizeWithAttributes:(NSDictionary *)attributes {
    Measurements++;
    UIFont *font=attributes[NSFontAttributeName];
    return CGSizeMake(self.length*font.pointSize*.6,font.lineHeight);
}
@end

@interface UIColor : NSObject
@property(nonatomic,readonly) CGColorRef CGColor;
+ (instancetype)fixtureColor:(CGFloat)component;
@end
@implementation UIColor {
    CGColorRef _fixtureColor;
}
+ (instancetype)fixtureColor:(CGFloat)c { UIColor *v=[self new]; v->_fixtureColor=CGColorCreateGenericRGB(c,c,c,1); return v; }
- (CGColorRef)CGColor { return _fixtureColor; }
- (void)dealloc { if (_fixtureColor) CGColorRelease(_fixtureColor); }
- (BOOL)isEqual:(id)o { return [o isKindOfClass:UIColor.class] && CGColorEqualToColor(self.CGColor,[o CGColor]); }
@end

typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static UIEdgeInsets UIEdgeInsetsMake(CGFloat t,CGFloat l,CGFloat b,CGFloat r) { return (UIEdgeInsets){t,l,b,r}; }
static CGRect UIEdgeInsetsInsetRect(CGRect r,UIEdgeInsets i) { return CGRectMake(r.origin.x+i.left,r.origin.y+i.top,r.size.width-i.left-i.right,r.size.height-i.top-i.bottom); }
typedef NSUInteger UIAccessibilityTraits;
static UIAccessibilityTraits UIAccessibilityTraitButton=1, UIAccessibilityTraitSelected=2;
static NSInteger NSTextAlignmentCenter=1;
static NSUInteger UIViewAnimationOptionCurveEaseInOut=1, UIViewAnimationOptionBeginFromCurrentState=2, UIViewAnimationOptionAllowUserInteraction=4;
static NSUInteger UIControlStateNormal=0,UIControlEventTouchUpInside=1;

@interface UIView : NSObject
@property(nonatomic) CGRect frame;
@property(nonatomic) CGRect bounds;
@property(nonatomic) BOOL hidden;
@property(nonatomic,strong) CALayer *layer;
@property(nonatomic,strong) UIView *window;
@property(nonatomic,strong) UITraitCollection *traitCollection;
@property(nonatomic) UIEdgeInsets safeAreaInsets;
@property(nonatomic) BOOL isAccessibilityElement, userInteractionEnabled;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
- (void)layoutSubviews;
- (void)traitCollectionDidChange:(UITraitCollection *)previous;
- (void)invalidateIntrinsicContentSize;
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)other;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options animations:(void(^)(void))animations completion:(void(^)(BOOL))completion;
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) { _layer=[CALayer layer]; _traitCollection=[UITraitCollection new]; } return self; }
- (void)setFrame:(CGRect)v { Writes++; _frame=v; _bounds.size=v.size; self.layer.frame=v; }
- (void)setHidden:(BOOL)v { Writes++; _hidden=v; }
- (void)setNeedsLayout { Invalidations++; }
- (void)layoutIfNeeded { SynchronousLayouts++; }
- (void)layoutSubviews {}
- (void)traitCollectionDidChange:(UITraitCollection *)previous {}
- (void)invalidateIntrinsicContentSize {}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)other {}
- (void)addSubview:(UIView *)view {}
- (void)removeFromSuperview {}
+ (void)animateWithDuration:(NSTimeInterval)d delay:(NSTimeInterval)delay options:(NSUInteger)o animations:(void(^)(void))a completion:(void(^)(BOOL))c { if (a) a(); if (c) c(YES); }
@end

@interface UILabel : UIView
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic) NSInteger textAlignment;
@end
@implementation UILabel
- (void)setText:(NSString *)v { Writes++; _text=[v copy]; }
- (void)setFont:(UIFont *)v { Writes++; _font=v; }
- (void)setTextColor:(UIColor *)v { Writes++; _textColor=v; }
@end

@interface UIButton : UIView
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,copy) NSString *currentTitle;
@property(nonatomic,copy) NSString *accessibilityValue;
@property(nonatomic,copy) NSString *accessibilityLabel;
@property(nonatomic) BOOL selected;
@property(nonatomic) UIAccessibilityTraits accessibilityTraits;
- (void)setTitle:(NSString *)title forState:(NSUInteger)state;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(NSUInteger)events;
@end
@implementation UIButton
- (instancetype)init { if ((self=[super init])) self.titleLabel=[UILabel new]; return self; }
- (void)setSelected:(BOOL)v { Writes++; _selected=v; }
- (void)setAccessibilityTraits:(UIAccessibilityTraits)v { Writes++; _accessibilityTraits=v; }
- (void)setTitle:(NSString *)v forState:(NSUInteger)state { Writes++; self.currentTitle=v; }
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(NSUInteger)events {}
@end

@interface UIScrollView : UIView
@property(nonatomic) CGSize contentSize;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) BOOL dragging, decelerating;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
@end
@implementation UIScrollView
- (void)setContentSize:(CGSize)v { Writes++; _contentSize=v; }
- (void)setContentOffset:(CGPoint)v animated:(BOOL)animated { Writes++; _contentOffset=v; }
@end

typedef NS_ENUM(NSInteger,CSGroupIndicatorStyle) { CSGroupIndicatorStyleUnderline, CSGroupIndicatorStyleCapsule };
static CGFloat CSGroupDefaultTabFontSize=15, CSGroupMinTabFontSize=10, CSGroupMaxTabFontSize=30;
static BOOL CSGroupIndicatorAnimationEnabled(NSUserDefaults *defaults) { return AnimationEnabled; }
static BOOL UIAccessibilityIsReduceMotionEnabled(void) { return ReducedMotion; }

typedef NS_ENUM(NSInteger,WETabType) { WETabTypeAll, WETabTypeCustom };
@interface WESessionTabItem : NSObject
@property(nonatomic,copy) NSString *tabId,*displayName;
@property(nonatomic) WETabType type;
@end
@implementation WESessionTabItem @end
