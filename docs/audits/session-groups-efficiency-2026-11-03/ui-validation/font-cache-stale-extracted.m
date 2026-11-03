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


static CGFloat const kTabContainerHeight = 52.0;
static CGFloat const kTabMinWidth = 60.0;
static CGFloat const kIndicatorHeight = 2.0;
static CGFloat const kTabPadding = 16.0;
static CGFloat const kTabMinGap = 8.0;
static CGFloat const kTabBadgeGap = 3.0;
static CGFloat const kActionButtonWidth = 44.0;
static NSTimeInterval const kIndicatorDuration = 0.20;
static NSString *const kIndicatorAnimationKey = @"CSGroupIndicator.selection";
static NSTimeInterval const kCapsuleDuration = 0.28;
static NSString *const kCapsuleAnimationKey = @"CSGroupIndicator.capsule";

static CGRect CSGroupCapsuleFrame(CGRect title, CGRect bounds) {
    if (CGRectIsEmpty(title) || CGRectIsEmpty(bounds)) return CGRectZero;
    CGRect frame = CGRectInset(title, -10, -7);
    CGRect clipped = CGRectIntersection(frame, CGRectInset(bounds, 3, 3));
    return CGRectIsNull(clipped) || CGRectIsEmpty(clipped) ? CGRectZero : clipped;
}

// Explicit, finite Core Animation transitions. Unchanged targets preserve their
// in-flight animation; interactive updates only write model layers, with no timer.
static void CSGroupSetCapsuleLayer(CALayer *layer, CGFloat opacity, BOOL scales, BOOL animated) {
    if (!layer) return;
    CATransform3D transform = scales ? CATransform3DMakeScale(0.42 + 0.58 * opacity, 0.84 + 0.16 * opacity, 1) : CATransform3DIdentity;
    BOOL unchanged = fabs(layer.opacity - opacity) < 0.0001 && (!scales || CATransform3DEqualToTransform(layer.transform, transform));
    if (unchanged) {
        if (!animated && [layer animationForKey:kCapsuleAnimationKey]) [layer removeAnimationForKey:kCapsuleAnimationKey];
        return;
    }
    CALayer *visible = layer.presentationLayer ?: layer;
    CGFloat startOpacity = visible.opacity;
    CATransform3D startTransform = visible.transform;
    [layer removeAnimationForKey:kCapsuleAnimationKey];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    layer.opacity = opacity;
    if (scales) layer.transform = transform;
    [CATransaction commit];
    if (!animated || (fabs(startOpacity - opacity) < 0.0001 && (!scales || CATransform3DEqualToTransform(startTransform, transform)))) return;
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = @(startOpacity); fade.toValue = @(opacity);
    fade.duration = kCapsuleDuration;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    if (scales) {
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
        scale.fromValue = [NSValue valueWithCATransform3D:startTransform];
        scale.toValue = [NSValue valueWithCATransform3D:transform];
        scale.duration = kCapsuleDuration;
        group.animations = @[fade, scale];
    } else group.animations = @[fade];
    group.duration = kCapsuleDuration;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [layer addAnimation:group forKey:kCapsuleAnimationKey];
}



@interface WETabButton : UIButton
@property (nonatomic) NSInteger tabIndex;
@property (nonatomic, copy) NSString *tabID;
@property (nonatomic) NSInteger unreadCount;
@property (nonatomic) BOOL hasRedDot;
@property (nonatomic) CGFloat baseFontSize;
@property (nonatomic, strong) UILabel *unreadBadge;
@property (nonatomic, strong) CALayer *capsuleLayer;
@property (nonatomic, strong) UILabel *capsuleTitleLabel;
@property (nonatomic) BOOL capsuleEnabled;
@property (nonatomic) CGFloat capsuleProgress;
@property (nonatomic, copy) NSString *measuredTitle;
@property (nonatomic, strong) UIFont *measuredTitleFont;
@property (nonatomic) CGSize measuredTitleSize;
@property (nonatomic, copy) NSString *measuredBadgeText;
@property (nonatomic, strong) UIFont *measuredBadgeFont;
@property (nonatomic) CGFloat measuredBadgeWidth;
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot;
- (void)updateFonts;
- (CGFloat)badgeWidth;
- (CGSize)tabTitleSize;
- (CGRect)tabTitleFrame;
- (void)configureCapsuleEnabled:(BOOL)enabled color:(UIColor *)color textColor:(UIColor *)textColor;
- (void)setCapsuleProgress:(CGFloat)progress animated:(BOOL)animated;
@end



@interface WESessionTabContainerView : UIView
@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic,copy) void (^onTabSelected)(NSInteger);
@property(nonatomic,copy) void (^onSearchButtonTapped)(void);

@property (nonatomic, copy) NSArray *renderedTabRecords;
@property (nonatomic, strong, readwrite) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<WETabButton *> *tabButtons;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic) CGFloat baseFontSize;
@property (nonatomic) BOOL revealSelectionAfterLayout;
@property (nonatomic) CGSize indicatorLayoutSize;
@property (nonatomic) BOOL interactiveTransition, settlingInteractiveTransition;
@property (nonatomic) NSInteger interactiveTarget;
@property (nonatomic) CGFloat interactiveProgress;
@property (nonatomic) CSGroupIndicatorStyle indicatorStyle;
@property (nonatomic) BOOL tabLayoutValid;
@property (nonatomic) CGSize tabLayoutSize;
@end



@implementation WETabButton

- (instancetype)init { if ((self=[super init])) { self.unreadBadge=[UILabel new]; self.unreadBadge.hidden=YES; self.baseFontSize=15; [self updateFonts]; } return self; }

- (void)updateFonts {
    UIFont *titleFont = [[UIFontMetrics metricsForTextStyle:UIFontTextStyleSubheadline]
        scaledFontForFont:[UIFont systemFontOfSize:self.baseFontSize] compatibleWithTraitCollection:self.traitCollection];
    UIFont *badgeFont = [[UIFontMetrics metricsForTextStyle:UIFontTextStyleCaption2]
        scaledFontForFont:[UIFont boldSystemFontOfSize:10] compatibleWithTraitCollection:self.traitCollection];
    if ([self.titleLabel.font isEqual:titleFont] && [self.unreadBadge.font isEqual:badgeFont]) return;
    if (![self.titleLabel.font isEqual:titleFont]) self.titleLabel.font = titleFont;
    if (![self.unreadBadge.font isEqual:badgeFont]) self.unreadBadge.font = badgeFont;
    [self setNeedsLayout];
}

- (CGSize)tabTitleSize {
    NSString *title = self.currentTitle ?: @"";
    UIFont *font = self.titleLabel.font;
    if (![self.measuredTitle isEqualToString:title]) {
        self.measuredTitle = title;
        self.measuredTitleFont = font;
        self.measuredTitleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    return self.measuredTitleSize;
}

- (CGFloat)badgeWidth {
    if (self.unreadBadge.hidden) return 0;
    if (self.unreadCount == 0) return 7;
    NSString *text = self.unreadBadge.text ?: @"";
    UIFont *font = self.unreadBadge.font;
    if ([self.measuredBadgeText isEqualToString:text] && [self.measuredBadgeFont isEqual:font]) return self.measuredBadgeWidth;
    CGFloat height = MAX(14, ceil(self.unreadBadge.font.lineHeight) + 2);
    self.measuredBadgeText = text;
    self.measuredBadgeFont = font;
    self.measuredBadgeWidth = MAX(height, ceil([text sizeWithAttributes:@{NSFontAttributeName:font}].width) + 6);
    return self.measuredBadgeWidth;
}

- (CGRect)tabTitleFrame {
    CGFloat trailing = self.unreadBadge.hidden ? 0 : [self badgeWidth] + kTabBadgeGap;
    CGRect available = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, kTabPadding / 2, 0, kTabPadding / 2 + trailing));
    CGSize size = [self tabTitleSize];
    CGFloat width = MIN(MAX(0, CGRectGetWidth(available)), ceil(size.width));
    CGFloat height = ceil(self.titleLabel.font.lineHeight);
    return CGRectMake(CGRectGetMidX(available) - width / 2, CGRectGetMidY(available) - height / 2, width, height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect titleFrame = [self tabTitleFrame];
    if (!CGRectEqualToRect(self.titleLabel.frame,titleFrame)) self.titleLabel.frame = titleFrame;
    CGFloat width = [self badgeWidth];
    CGFloat height = self.unreadCount > 0 ? MAX(14, ceil(self.unreadBadge.font.lineHeight) + 2) : 7;
    // Anchor to the actual title rather than the padded button's trailing edge.
    CGFloat x = MIN(CGRectGetMaxX(titleFrame) + kTabBadgeGap, CGRectGetWidth(self.bounds) - width);
    CGFloat y = MAX(2, CGRectGetMinY(titleFrame) - height * 0.35);
    CGRect badgeFrame = CGRectMake(MAX(0, x), y, width, height);
    if (!CGRectEqualToRect(self.unreadBadge.frame,badgeFrame)) self.unreadBadge.frame = badgeFrame;
    if (self.unreadBadge.layer.cornerRadius != height / 2) self.unreadBadge.layer.cornerRadius = height / 2;
    if (self.capsuleEnabled) {
        CGRect capsuleFrame = CSGroupCapsuleFrame(titleFrame, self.bounds);
        CGRect capsuleBounds = (CGRect){CGPointZero, capsuleFrame.size};
        CGPoint capsulePosition = CGPointMake(CGRectGetMidX(capsuleFrame), CGRectGetMidY(capsuleFrame));
        BOOL geometryChanged = !CGRectEqualToRect(self.capsuleLayer.bounds,capsuleBounds) ||
            !CGPointEqualToPoint(self.capsuleLayer.position,capsulePosition) || self.capsuleLayer.cornerRadius != capsuleFrame.size.height / 2;
        BOOL titleChanged = self.capsuleTitleLabel.text != self.currentTitle && ![self.capsuleTitleLabel.text isEqualToString:self.currentTitle];
        BOOL labelChanged = !CGRectEqualToRect(self.capsuleTitleLabel.frame,titleFrame) ||
            titleChanged || ![self.capsuleTitleLabel.font isEqual:self.titleLabel.font];
        if (!geometryChanged && !labelChanged) return;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        // Set bounds/position separately: frame is undefined while scaled.
        if (!CGRectEqualToRect(self.capsuleLayer.bounds,capsuleBounds)) self.capsuleLayer.bounds = capsuleBounds;
        if (!CGPointEqualToPoint(self.capsuleLayer.position,capsulePosition)) self.capsuleLayer.position = capsulePosition;
        if (self.capsuleLayer.cornerRadius != capsuleFrame.size.height / 2) self.capsuleLayer.cornerRadius = capsuleFrame.size.height / 2;
        if (!CGRectEqualToRect(self.capsuleTitleLabel.frame,titleFrame)) self.capsuleTitleLabel.frame = titleFrame;
        if (titleChanged) self.capsuleTitleLabel.text = self.currentTitle;
        if (![self.capsuleTitleLabel.font isEqual:self.titleLabel.font]) self.capsuleTitleLabel.font = self.titleLabel.font;
        [CATransaction commit];
    }
}

- (void)configureCapsuleEnabled:(BOOL)enabled color:(UIColor *)color textColor:(UIColor *)textColor {
    BOOL changed = self.capsuleEnabled != enabled;
    self.capsuleEnabled = enabled;
    if (!enabled) {
        if (!changed) return;
        [self setCapsuleProgress:0 animated:NO];
        [self.capsuleLayer removeFromSuperlayer]; self.capsuleLayer = nil;
        [self.capsuleTitleLabel removeFromSuperview]; self.capsuleTitleLabel = nil;
        return;
    }
    if (!self.capsuleLayer) {
        changed = YES;
        self.capsuleLayer = [CALayer layer];
        self.capsuleLayer.opacity = 0;
        [self.layer insertSublayer:self.capsuleLayer atIndex:0];
        self.capsuleTitleLabel = [[UILabel alloc] init];
        self.capsuleTitleLabel.isAccessibilityElement = NO;
        self.capsuleTitleLabel.userInteractionEnabled = NO;
        self.capsuleTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.capsuleTitleLabel.layer.opacity = 0;
        [self insertSubview:self.capsuleTitleLabel belowSubview:self.unreadBadge];
    }
    BOOL backgroundChanged = !CGColorEqualToColor(self.capsuleLayer.backgroundColor,color.CGColor);
    BOOL textChanged = ![self.capsuleTitleLabel.textColor isEqual:textColor];
    if (backgroundChanged || textChanged) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (backgroundChanged) self.capsuleLayer.backgroundColor = color.CGColor;
        if (textChanged) self.capsuleTitleLabel.textColor = textColor;
        [CATransaction commit];
    }
    if (changed) [self setNeedsLayout];
}

- (void)setCapsuleProgress:(CGFloat)progress animated:(BOOL)animated {
    if (!self.capsuleLayer) return;
    self.capsuleProgress = MAX(0, MIN(1, progress));
    CSGroupSetCapsuleLayer(self.capsuleLayer, self.capsuleProgress, YES, animated);
    CSGroupSetCapsuleLayer(self.capsuleTitleLabel.layer, self.capsuleProgress, NO, animated);
    CSGroupSetCapsuleLayer(self.titleLabel.layer, 1 - self.capsuleProgress, NO, animated);
}

- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot {
    count = MAX(0, count);
    if (self.unreadCount == count && self.hasRedDot == hasRedDot) return;
    self.unreadCount = count;
    self.hasRedDot = hasRedDot;
    BOOL hidden = self.unreadCount == 0 && !hasRedDot;
    NSString *text = self.unreadCount > 99 ? @"99+" :
        (self.unreadCount > 0 ? [NSString stringWithFormat:@"%ld", (long)self.unreadCount] : nil);
    BOOL textChanged = self.unreadBadge.text != text && ![self.unreadBadge.text isEqualToString:text];
    BOOL hiddenChanged = self.unreadBadge.hidden != hidden;
    if (hiddenChanged) self.unreadBadge.hidden = hidden;
    if (textChanged) self.unreadBadge.text = text;
    NSString *value = self.unreadCount > 0 ? [NSString stringWithFormat:@"%ld 条未读消息", (long)self.unreadCount] :
        (hasRedDot ? @"有未读消息" : nil);
    if (self.accessibilityValue != value && ![self.accessibilityValue isEqualToString:value]) self.accessibilityValue = value;
    if (hiddenChanged || textChanged) [self setNeedsLayout];
}

@end

@implementation WESessionTabContainerView

- (void)refreshAppearance {}

- (void)triggerHapticFeedback {}

- (void)applyAppearanceWithFontSize:(CGFloat)fontSize showsSearchButton:(BOOL)showsSearchButton {
    if (!isfinite(fontSize) || fontSize < CSGroupMinTabFontSize || fontSize > CSGroupMaxTabFontSize)
        fontSize = CSGroupDefaultTabFontSize;
    BOOL fontChanged = self.baseFontSize != fontSize;
    BOOL visibilityChanged = self.searchButton.hidden == showsSearchButton;
    if (!fontChanged && !visibilityChanged) return;
    self.baseFontSize = fontSize;
    self.searchButton.hidden = !showsSearchButton;
    self.revealSelectionAfterLayout = YES;
    if (fontChanged) {
        self.tabLayoutValid = NO;
        for (WETabButton *button in self.tabButtons) {
            button.baseFontSize = fontSize;
            [button updateFonts];
        }
        [self invalidateIntrinsicContentSize];
    }
    [self setNeedsLayout];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self refreshAppearance];
    for (WETabButton *button in self.tabButtons) [button updateFonts];
    self.tabLayoutValid = NO;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = MAX(0, CGRectGetWidth(self.bounds) - self.safeAreaInsets.left - self.safeAreaInsets.right);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat actionWidth = self.searchButton.hidden ? 0 : MIN(kActionButtonWidth, width);
    CGFloat scrollWidth = MAX(0, width - actionWidth);
    CGFloat left = self.safeAreaInsets.left;
    CGRect scrollFrame = CGRectMake(left, 0, scrollWidth, height);
    CGRect searchFrame = CGRectMake(left + scrollWidth, 0, actionWidth, height);
    if (!CGRectEqualToRect(self.scrollView.frame,scrollFrame)) self.scrollView.frame = scrollFrame;
    if (!CGRectEqualToRect(self.searchButton.frame,searchFrame)) self.searchButton.frame = searchFrame;
    if (!CGSizeEqualToSize(self.indicatorLayoutSize,self.bounds.size)) {
        [self.indicatorView.layer removeAnimationForKey:kIndicatorAnimationKey];
        self.indicatorLayoutSize=self.bounds.size;
    }
    [self layoutTabButtons];
    if (self.revealSelectionAfterLayout) {
        self.revealSelectionAfterLayout = NO;
        [self scrollToSelectedTab];
    }
}

- (CGFloat)widthForTabButton:(WETabButton *)button {
    CGFloat titleWidth = ceil([button tabTitleSize].width);
    CGFloat badgeSpace = button.unreadBadge.hidden ? 0 : [button badgeWidth] + kTabBadgeGap;
    // Long names remain readable by scrolling; VoiceOver also receives the complete title.
    return MAX(kTabMinWidth, titleWidth + 2 * kTabPadding + badgeSpace);
}

- (void)layoutTabButtons {
    CGSize viewportSize = self.scrollView.bounds.size;
    if (self.tabLayoutValid && CGSizeEqualToSize(self.tabLayoutSize,viewportSize)) {
        [self updateIndicatorPosition];
        return;
    }
    self.tabLayoutValid = YES;
    self.tabLayoutSize = viewportSize;
    CGFloat totalWidth = 0;
    NSMutableArray<NSNumber *> *widths = [NSMutableArray arrayWithCapacity:self.tabButtons.count];
    for (WETabButton *button in self.tabButtons) {
        CGFloat width = [self widthForTabButton:button];
        [widths addObject:@(width)]; totalWidth += width;
    }
    CGFloat viewport = CGRectGetWidth(self.scrollView.bounds);
    CGFloat spacing = MAX(kTabMinGap, (viewport - totalWidth) / (self.tabButtons.count + 1));
    CGFloat x = spacing; NSUInteger widthIndex = 0;
    for (WETabButton *button in self.tabButtons) {
        CGFloat width = widths[widthIndex++].doubleValue;
        CGRect frame = CGRectMake(x, 0, width, CGRectGetHeight(self.scrollView.bounds));
        if (!CGRectEqualToRect(button.frame,frame)) button.frame = frame;
        x += width + spacing;
    }
    CGSize contentSize = CGSizeMake(MAX(viewport, self.tabButtons.count ? x : 0), CGRectGetHeight(self.scrollView.bounds));
    if (!CGSizeEqualToSize(self.scrollView.contentSize,contentSize)) self.scrollView.contentSize = contentSize;
    // A smaller font or hidden search button can remove horizontal overflow.
    CGFloat maxOffset = MAX(0, self.scrollView.contentSize.width - viewport);
    if (!self.scrollView.dragging && !self.scrollView.decelerating && self.scrollView.contentOffset.x > maxOffset)
        [self.scrollView setContentOffset:CGPointMake(maxOffset, 0) animated:NO];
    [self updateIndicatorPosition];
}

- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot forTabIndex:(NSInteger)index {
    if (index < 0 || index >= (NSInteger)self.tabButtons.count) return;
    WETabButton *button = self.tabButtons[index];
    if (button.unreadCount == MAX(0, count) && button.hasRedDot == hasRedDot) return;
    CGFloat previousBadgeWidth = [button badgeWidth];
    CGFloat previousWidth = [self widthForTabButton:button];
    [button updateUnreadCount:count hasRedDot:hasRedDot];
    // A new count with the same rendered width only changes the badge label.
    // The title/indicator geometry still changes when badge space changes even
    // if the button remains clamped to the minimum width.
    if ([button badgeWidth] != previousBadgeWidth) {
        if ([self widthForTabButton:button] != previousWidth) self.tabLayoutValid = NO;
        [self setNeedsLayout];
    }
}

- (void)updateTabs:(NSArray<WESessionTabItem *> *)tabs {
    NSMutableArray *records=[NSMutableArray arrayWithCapacity:tabs.count];
    for (WESessionTabItem *tab in tabs) [records addObject:@[tab.tabId ?: @"",tab.displayName ?: @"",@(tab.type)]];
    if ([self.renderedTabRecords isEqual:records]) return;
    self.interactiveTransition=NO;
    for (WETabButton *button in self.tabButtons) [button setCapsuleProgress:0 animated:NO];
    self.renderedTabRecords=[records copy];
    self.tabLayoutValid = NO;
    NSString *previousID = [self.selectedTabID copy];
    NSArray<WETabButton *> *previousButtons = [self.tabButtons copy];
    NSInteger previousIndex = self.selectedIndex;
    NSMutableDictionary<NSString *, WETabButton *> *oldButtons = [NSMutableDictionary dictionary];
    for (WETabButton *button in previousButtons) if (button.tabID.length) oldButtons[button.tabID] = button;
    NSMutableArray<WETabButton *> *buttons = [NSMutableArray arrayWithCapacity:tabs.count];
    NSMutableSet<NSString *> *reusedIDs = [NSMutableSet set];
    NSInteger defaultIndex = NSNotFound;
    for (WESessionTabItem *item in tabs) {
        WETabButton *button = nil;
        if (item.tabId.length && ![reusedIDs containsObject:item.tabId]) {
            button = oldButtons[item.tabId];
            [reusedIDs addObject:item.tabId];
        }
        if (!button) {
            button = [[WETabButton alloc] init];
            [button addTarget:self action:@selector(tabButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
        button.tabID = item.tabId;
        button.tabIndex = buttons.count;
        if (button.baseFontSize != self.baseFontSize) {
            button.baseFontSize = self.baseFontSize; [button updateFonts];
        }
        if (![button.currentTitle isEqual:item.displayName]) {
            [button setTitle:item.displayName forState:UIControlStateNormal];
            button.accessibilityLabel = item.displayName;
        }
        [self.scrollView addSubview:button];
        if (item.type == WETabTypeAll && defaultIndex == NSNotFound) defaultIndex = button.tabIndex;
        [buttons addObject:button];
    }
    for (WETabButton *old in previousButtons) if (![buttons containsObject:old]) [old removeFromSuperview];
    self.tabButtons = buttons;
    [self refreshAppearance];

    NSInteger nextIndex = [self indexForTabID:previousID];
    // On removal, prefer the next surviving tab in the prior visible order.
    if (nextIndex == NSNotFound && previousIndex >= 0 && previousIndex < (NSInteger)previousButtons.count) {
        for (NSInteger i = previousIndex + 1; i < (NSInteger)previousButtons.count; i++) {
            nextIndex = [self indexForTabID:previousButtons[i].tabID];
            if (nextIndex != NSNotFound) break;
        }
    }
    if (nextIndex == NSNotFound) nextIndex = defaultIndex != NSNotFound ? defaultIndex : (buttons.count ? 0 : NSNotFound);
    _selectedIndex = nextIndex;
    _selectedTabID = nextIndex == NSNotFound ? nil : [buttons[nextIndex].tabID copy];
    [self updateSelectedButtons];
    if (self.indicatorStyle == CSGroupIndicatorStyleCapsule) [self updateIndicatorPositionAnimated:NO];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self scrollToSelectedTab];
}

- (NSInteger)indexForTabID:(NSString *)tabID {
    if (!tabID.length) return NSNotFound;
    for (WETabButton *button in self.tabButtons) if ([button.tabID isEqualToString:tabID]) return button.tabIndex;
    return NSNotFound;
}

- (void)updateSelectedButtons {
    for (WETabButton *button in self.tabButtons) {
        BOOL selected = button.tabIndex == self.selectedIndex;
        if (button.selected != selected) button.selected = selected;
        UIAccessibilityTraits traits = UIAccessibilityTraitButton | (selected ? UIAccessibilityTraitSelected : 0);
        if (button.accessibilityTraits != traits) button.accessibilityTraits = traits;
    }
}

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (index < 0 || index >= (NSInteger)self.tabButtons.count) return;
    // Publishing a projection reassigns the same stable selection several times.
    // That acknowledgement must not cancel an in-flight user transition.
    if (index == _selectedIndex) {
        // A settings refresh must still stop movement when the switch is disabled.
        if (!CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults))
            [self updateIndicatorPositionAnimated:NO];
        return;
    }
    // Keep the finger's current geometry when committing; a layout must not
    // snap the indicator back to its old selection before the settle animation.
    BOOL interactive=self.interactiveTransition;
    if (!interactive) [self layoutIfNeeded];
    self.interactiveTransition=NO;
    _selectedIndex = index;
    _selectedTabID = [self.tabButtons[index].tabID copy];
    [self updateSelectedButtons];
    [self triggerHapticFeedback];
    BOOL animate = animated && CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults) && self.window && !UIAccessibilityIsReduceMotionEnabled();
    self.settlingInteractiveTransition=interactive;
    [self updateIndicatorPositionAnimated:animate];
    self.settlingInteractiveTransition=NO;
    if (animate) {
        [UIView animateWithDuration:kIndicatorDuration delay:0
            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
            animations:^{ [self scrollToSelectedTab]; } completion:nil];
    } else [self scrollToSelectedTab];
}

- (void)updateIndicatorPosition {
    // An unread badge or data refresh can relayout the same target while moving.
    // Preserve that animation; retarget only if its final geometry has changed.
    if (self.interactiveTransition) {
        [self updateInteractiveTransitionToIndex:self.interactiveTarget progress:self.interactiveProgress];
        return;
    }
    if (self.indicatorStyle == CSGroupIndicatorStyleCapsule) {
        BOOL animate = CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults) && self.window && !UIAccessibilityIsReduceMotionEnabled();
        [self updateCapsuleSelectionAnimated:animate];
        return;
    }
    BOOL moving = [self.indicatorView.layer animationForKey:kIndicatorAnimationKey] != nil;
    [self updateIndicatorPositionAnimated:moving];
}

- (void)updateIndicatorPositionAnimated:(BOOL)animated {
    self.interactiveTransition=NO;
    if (self.indicatorStyle == CSGroupIndicatorStyleCapsule) {
        [self updateCapsuleSelectionAnimated:animated && CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults) && self.window && !UIAccessibilityIsReduceMotionEnabled()];
        return;
    }
    BOOL valid = self.selectedIndex >= 0 && self.selectedIndex < (NSInteger)self.tabButtons.count;
    BOOL wasHidden = self.indicatorView.hidden;
    if (self.indicatorView.hidden != !valid) self.indicatorView.hidden = !valid;
    if (!valid) {
        if ([self.indicatorView.layer animationForKey:kIndicatorAnimationKey]) [self.indicatorView.layer removeAnimationForKey:kIndicatorAnimationKey];
        return;
    }
    CGRect target=[self indicatorFrameForIndex:self.selectedIndex];
    BOOL animate = animated && CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults) && !wasHidden && self.window && !UIAccessibilityIsReduceMotionEnabled();
    [self moveIndicatorToFrame:target animated:animate];
}

- (void)updateCapsuleSelectionAnimated:(BOOL)animated {
    if (!self.indicatorView.hidden) self.indicatorView.hidden = YES;
    if ([self.indicatorView.layer animationForKey:kIndicatorAnimationKey]) [self.indicatorView.layer removeAnimationForKey:kIndicatorAnimationKey];
    for (WETabButton *button in self.tabButtons)
        [button setCapsuleProgress:button.tabIndex == self.selectedIndex ? 1 : 0 animated:animated];
}

- (CGRect)indicatorFrameForIndex:(NSInteger)index {
    WETabButton *button = self.tabButtons[index];
    CGRect title = [button tabTitleFrame];
    CGFloat width = MAX(0, MIN(CGRectGetWidth(button.bounds) - 8, CGRectGetWidth(title) + 12));
    return CGRectMake(CGRectGetMinX(button.frame) + CGRectGetMidX(title) - width / 2,
        MAX(0, CGRectGetHeight(self.scrollView.bounds) - kIndicatorHeight - 5), width, kIndicatorHeight);
}

- (void)updateInteractiveTransitionToIndex:(NSInteger)index progress:(CGFloat)progress {
    if (!CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults) || !self.window || UIAccessibilityIsReduceMotionEnabled() ||
        self.selectedIndex<0 || self.selectedIndex>=(NSInteger)self.tabButtons.count || index<0 || index>=(NSInteger)self.tabButtons.count || index==self.selectedIndex || !isfinite(progress)) {
        if (self.interactiveTransition) { self.interactiveTransition=NO; [self updateIndicatorPositionAnimated:NO]; }
        return;
    }
    self.interactiveTransition=YES; self.interactiveTarget=index;
    CGFloat t=MAX(0,MIN(1,progress)); self.interactiveProgress=t;
    CGRect from=[self indicatorFrameForIndex:self.selectedIndex], to=[self indicatorFrameForIndex:index];
    CGFloat center=CGRectGetMidX(from)+(CGRectGetMidX(to)-CGRectGetMidX(from))*t;
    if (self.indicatorStyle == CSGroupIndicatorStyleCapsule) {
        self.indicatorView.hidden = YES;
        for (WETabButton *button in self.tabButtons) {
            CGFloat progress = button.tabIndex == self.selectedIndex ? 1 - t : (button.tabIndex == index ? t : 0);
            [button setCapsuleProgress:progress animated:NO];
        }
    } else {
        CGFloat width=(from.size.width+(to.size.width-from.size.width)*t)*(1-0.70*sin(M_PI*t));
        CGRect frame=CGRectMake(center-width/2,to.origin.y,width,to.size.height);
        self.indicatorView.hidden=NO;
        [self moveIndicatorToFrame:frame animated:NO];
    }
    CGFloat viewport=CGRectGetWidth(self.scrollView.bounds);
    CGFloat maxOffset=MAX(0,self.scrollView.contentSize.width-viewport);
    CGFloat offset=MAX(0,MIN(center-viewport/2,maxOffset));
    if (fabs(self.scrollView.contentOffset.x-offset)>0.5) [self.scrollView setContentOffset:CGPointMake(offset,0) animated:NO];
}

- (void)cancelInteractiveTransition {
    if (!self.interactiveTransition) return;
    self.interactiveTransition=NO;
    self.settlingInteractiveTransition=YES;
    [self updateIndicatorPositionAnimated:YES];
    self.settlingInteractiveTransition=NO;
    [self scrollToSelectedTab];
}

- (void)moveIndicatorToFrame:(CGRect)target animated:(BOOL)animated {
    CALayer *layer = self.indicatorView.layer;
    if (CGRectEqualToRect(layer.frame,target)) {
        if (!animated && [layer animationForKey:kIndicatorAnimationKey]) [layer removeAnimationForKey:kIndicatorAnimationKey];
        return;
    }
    // Capture the visible position before replacing the previous animation so
    // rapid taps reverse smoothly instead of jumping to its previous destination.
    CALayer *presentation = layer.presentationLayer;
    CGRect start = presentation ? presentation.frame : layer.frame;
    [layer removeAnimationForKey:kIndicatorAnimationKey];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    layer.frame = target;
    [CATransaction commit];
    if (!animated || CGRectIsEmpty(start) || CGRectEqualToRect(start,target)) return;

    CGFloat distance = fabs(CGRectGetMidX(target)-CGRectGetMidX(start));
    CGFloat stretch = MIN(48.0,distance * 0.45);
    CGPoint from = CGPointMake(CGRectGetMidX(start),CGRectGetMidY(start));
    CGPoint to = CGPointMake(CGRectGetMidX(target),CGRectGetMidY(target));
    CAKeyframeAnimation *position = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    position.values = @[[NSValue valueWithCGPoint:from],[NSValue valueWithCGPoint:to]];
    position.keyTimes = @[@0,@1];
    position.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    CAKeyframeAnimation *size = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    size.values = @[[NSValue valueWithCGSize:start.size],
        [NSValue valueWithCGSize:CGSizeMake(MAX(start.size.width,target.size.width)+stretch,target.size.height)],
        [NSValue valueWithCGSize:target.size]];
    size.keyTimes = @[@0,@0.45,@1];
    size.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    // A drag has already contracted the indicator. Settle directly to its final
    // width instead of replaying the tap animation's additional stretch peak.
    if (self.settlingInteractiveTransition) {
        size.values=@[[NSValue valueWithCGSize:start.size],[NSValue valueWithCGSize:target.size]];
        size.keyTimes=@[@0,@1];
        size.timingFunctions=@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    }
    // Position has one continuous easing curve.
    position.duration = kIndicatorDuration;
    size.duration = kIndicatorDuration;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[position,size];
    group.duration = kIndicatorDuration;
    [layer addAnimation:group forKey:kIndicatorAnimationKey];
}

- (void)scrollToSelectedTab {
    if (self.selectedIndex < 0 || self.selectedIndex >= (NSInteger)self.tabButtons.count) return;
    CGRect frame = self.tabButtons[self.selectedIndex].frame;
    CGFloat viewport = CGRectGetWidth(self.scrollView.bounds);
    CGFloat maxOffset = MAX(0, self.scrollView.contentSize.width - viewport);
    CGFloat offset = MAX(0, MIN(CGRectGetMidX(frame) - viewport / 2, maxOffset));
    if (fabs(self.scrollView.contentOffset.x-offset)>0.5)
        [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:NO];
}

@end

static WESessionTabContainerView *MakeContainer(void) {
    WESessionTabContainerView *v=[WESessionTabContainerView new];
    v.frame=CGRectMake(0,0,375,52);
    v.baseFontSize=15;
    v.window=[UIView new];
    v.scrollView=[UIScrollView new];
    v.searchButton=[UIButton new]; v.searchButton.hidden=YES;
    v.indicatorView=[UIView new];
    v.tabButtons=[NSMutableArray new];
    for (NSString *title in @[@"全部",@"群聊",@"自定义较长标题",@"私聊"]) {
        WETabButton *b=[WETabButton new]; b.currentTitle=title;
        b.tabID=[NSString stringWithFormat:@"tab%lu",(unsigned long)v.tabButtons.count]; b.tabIndex=v.tabButtons.count;
        [v.tabButtons addObject:b];
    }
    v.selectedIndex=0;
    v.selectedTabID=@"tab0";
    [v updateSelectedButtons];
    return v;
}
static void Layout(WESessionTabContainerView *v) {
    [v layoutSubviews];
    for (WETabButton *b in v.tabButtons) [b layoutSubviews];
}
static CGFloat ExpectedBadgeWidth(WETabButton *b) {
    if (b.unreadBadge.hidden) return 0;
    if (!b.unreadCount) return 7;
    return MAX(MAX(14,ceil(b.unreadBadge.font.pointSize*1.2)+2),ceil(b.unreadBadge.text.length*b.unreadBadge.font.pointSize*.6)+6);
}
static void CheckGeometry(WESessionTabContainerView *v,NSString *context) {
    CGFloat viewport=v.scrollView.bounds.size.width;
    CGFloat total=0;
    for (WETabButton *b in v.tabButtons) total+=MAX(60,ceil(b.currentTitle.length*b.titleLabel.font.pointSize*.6)+32+(b.unreadBadge.hidden ? 0 : ExpectedBadgeWidth(b)+3));
    CGFloat spacing=MAX(8,(viewport-total)/(v.tabButtons.count+1));
    CGFloat x=spacing;
    for (WETabButton *b in v.tabButtons) {
        CGFloat width=MAX(60,ceil(b.currentTitle.length*b.titleLabel.font.pointSize*.6)+32+(b.unreadBadge.hidden ? 0 : ExpectedBadgeWidth(b)+3));
        Check(CGRectEqualToRect(b.frame,CGRectMake(x,0,width,v.scrollView.bounds.size.height)),[context stringByAppendingString:@" button frame"]);
        CGFloat trailing=b.unreadBadge.hidden ? 0 : ExpectedBadgeWidth(b)+3;
        CGFloat available=width-16-trailing;
        CGFloat tw=MIN(MAX(0,available),ceil(b.currentTitle.length*b.titleLabel.font.pointSize*.6));
        CGFloat th=ceil(b.titleLabel.font.pointSize*1.2);
        CGRect expected=CGRectMake(8+available/2-tw/2,v.scrollView.bounds.size.height/2-th/2,tw,th);
        Check(CGRectEqualToRect(b.titleLabel.frame,expected),[context stringByAppendingString:@" title frame"]);
        x+=width+spacing;
    }
    Check(CGSizeEqualToSize(v.scrollView.contentSize,CGSizeMake(MAX(viewport,x),v.scrollView.bounds.size.height)),[context stringByAppendingString:@" content size"]);
}

int main(void) {
    @autoreleasepool {
        WESessionTabContainerView *v=MakeContainer();
        Layout(v); Layout(v);
        CheckGeometry(v,@"initial");
        ResetCounters();
        for (NSUInteger i=0;i<1000;i++) { Layout(v); [v selectTabAtIndex:0 animated:NO]; [v updateSelectedButtons]; }
        Check(Writes==0,@"1000 stable layouts/selection acknowledgements produce no visual/layer writes");
        Check(Measurements==0,@"1000 stable layouts reuse title measurements");
        Check(SynchronousLayouts==0,@"1000 stable selection acknowledgements do not force synchronous layout");
        NSUInteger stableWrites=Writes,stableMeasures=Measurements,stableSync=SynchronousLayouts;

        v.frame=CGRectMake(0,0,280,64); ResetCounters(); Layout(v);
        CheckGeometry(v,@"viewport resize");
        Check(Writes>0 && Measurements==0,@"resize changes geometry and reuses text metrics");
        v.safeAreaInsets=UIEdgeInsetsMake(0,20,0,10); Layout(v);
        Check(CGRectEqualToRect(v.scrollView.frame,CGRectMake(20,0,250,64)),@"safe area changes scroll origin and width");
        CheckGeometry(v,@"safe area");
        [v applyAppearanceWithFontSize:20 showsSearchButton:YES]; Layout(v);
        Check(CGRectEqualToRect(v.scrollView.frame,CGRectMake(20,0,206,64)),@"search button width updates viewport");
        CheckGeometry(v,@"font and search change");
        ResetCounters(); [v applyAppearanceWithFontSize:20 showsSearchButton:YES];
        Check(Writes==0 && Invalidations==0,@"identical appearance does not invalidate layout");

        v.traitCollection.fontScale=1.5;
        for (WETabButton *b in v.tabButtons) b.traitCollection.fontScale=1.5;
        [v traitCollectionDidChange:nil]; ResetCounters(); Layout(v);
        Check(Measurements>0,@"trait-dependent font change invalidates text metric cache");
        Check(v.tabButtons[0].titleLabel.font.pointSize==30,@"dynamic type scaled font applied");
        CheckGeometry(v,@"dynamic type");
        ResetCounters(); for (WETabButton *b in v.tabButtons) [b updateFonts];
        Check(Writes==0 && Invalidations==0,@"equal font objects do not invalidate button layout");

        v=MakeContainer(); Layout(v);
        [v updateUnreadCount:1 hasRedDot:NO forTabIndex:0]; Layout(v);
        CheckGeometry(v,@"badge reveal");
        [v updateUnreadCount:100 hasRedDot:NO forTabIndex:0]; Layout(v); Layout(v);
        CGRect badge100=v.tabButtons[0].unreadBadge.frame;
        ResetCounters(); [v updateUnreadCount:101 hasRedDot:NO forTabIndex:0];
        Check(Invalidations==0,@"99+ to 99+ changes accessibility only and does not invalidate geometry");
        Check([v.tabButtons[0].accessibilityValue isEqualToString:@"101 条未读消息"],@"capped badge retains full accessibility count");
        ResetCounters(); Layout(v);
        Check(Writes==0 && Measurements==0,@"same-width capped badge does not remeasure or write geometry");
        Check(CGRectEqualToRect(v.tabButtons[0].unreadBadge.frame,badge100),@"capped badge frame retained");
        [v updateUnreadCount:0 hasRedDot:YES forTabIndex:0]; Layout(v);
        CheckGeometry(v,@"red dot");
        Check(v.tabButtons[0].unreadBadge.frame.size.width==7,@"red dot width is seven points");
        [v updateUnreadCount:0 hasRedDot:NO forTabIndex:0]; Layout(v);
        CheckGeometry(v,@"badge hide");

        NSMutableArray *items=[NSMutableArray new];
        for (WETabButton *b in v.tabButtons) {
            WESessionTabItem *item=[WESessionTabItem new]; item.tabId=b.tabID; item.displayName=b.currentTitle;
            item.type=b.tabIndex==0 ? WETabTypeAll : WETabTypeCustom; [items addObject:item];
        }
        [v updateTabs:items]; Layout(v);
        ResetCounters(); [v updateTabs:items]; Layout(v);
        Check(Writes==0 && Measurements==0,@"unchanged tab records preserve layout and measurements");
        WETabButton *original=v.tabButtons[0];
        ((WESessionTabItem *)items[0]).displayName=@"重新命名后的更长分组名称";
        ResetCounters(); [v updateTabs:items]; Layout(v);
        Check(Measurements>0,@"rename invalidates text metrics");
        CheckGeometry(v,@"rename");
        [items exchangeObjectAtIndex:0 withObjectAtIndex:3];
        [v updateTabs:items]; Layout(v);
        Check(v.tabButtons[3]==original && v.selectedIndex==3 && [v.selectedTabID isEqualToString:original.tabID],@"reorder reuses buttons and preserves stable selection");
        CheckGeometry(v,@"reorder");
        [items removeObjectAtIndex:3]; [v updateTabs:items]; Layout(v);
        Check(v.selectedIndex==0,@"removing selected tab falls back to first surviving tab");
        CheckGeometry(v,@"remove selected");

        // Restore an ordinary first button for capsule lifecycle assertions.
        v=MakeContainer(); Layout(v);

        WETabButton *button=v.tabButtons[0];
        UIColor *background=[UIColor fixtureColor:.4],*foreground=[UIColor fixtureColor:.8];
        [button configureCapsuleEnabled:YES color:background textColor:foreground];
        [button setCapsuleProgress:1 animated:NO]; [button layoutSubviews];
        ResetCounters();
        for (NSUInteger i=0;i<1000;i++) {
            [button configureCapsuleEnabled:YES color:[UIColor fixtureColor:.4] textColor:[UIColor fixtureColor:.8]];
            [button setCapsuleProgress:1 animated:NO]; [button layoutSubviews];
        }
        Check(Writes==0 && Measurements==0 && Invalidations==0,@"1000 equal capsule configurations/layouts write nothing");
        [button configureCapsuleEnabled:YES color:[UIColor fixtureColor:.2] textColor:foreground];
        Check(CGColorEqualToColor(button.capsuleLayer.backgroundColor,[UIColor fixtureColor:.2].CGColor),@"capsule color changes are applied");
        Check(Invalidations==0,@"capsule color change does not invalidate geometry");
        [button configureCapsuleEnabled:NO color:background textColor:foreground];
        Check(!button.capsuleLayer && !button.capsuleTitleLabel && button.titleLabel.layer.opacity==1,@"capsule removal restores normal title opacity");
        button.currentTitle=nil;
        [button configureCapsuleEnabled:YES color:background textColor:foreground]; [button layoutSubviews];
        ResetCounters(); [button layoutSubviews];
        Check(Writes==0 && Measurements==0,@"nil title remains stable under capsule layout");

        [v updateTabs:@[]]; Layout(v);
        Check(v.selectedIndex==NSNotFound && !v.selectedTabID && v.tabButtons.count==0 && v.indicatorView.hidden,@"empty tabs hide selection and indicator");
        ResetCounters(); [v updateTabs:@[]]; Layout(v);
        Check(Writes==0 && Measurements==0,@"empty tab layout remains stable");

        v=MakeContainer(); Layout(v);
        CGRect indicator=v.indicatorView.layer.frame;
        ResetCounters(); [v moveIndicatorToFrame:indicator animated:NO];
        Check(Writes==0,@"stable nonanimated indicator target does not mutate its layer");
        CAAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.duration=10;
        [v.indicatorView.layer addAnimation:animation forKey:kIndicatorAnimationKey];
        ResetCounters(); [v moveIndicatorToFrame:indicator animated:YES];
        Check(Writes==0 && [v.indicatorView.layer animationForKey:kIndicatorAnimationKey]!=nil,@"same animated target retains in-flight animation");
        ResetCounters(); [v moveIndicatorToFrame:indicator animated:NO];
        Check(Writes==1 && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"same target nonanimated update cancels in-flight animation without geometry writes");
        [v.indicatorView.layer addAnimation:animation forKey:kIndicatorAnimationKey];
        AnimationEnabled=NO; ResetCounters(); [v selectTabAtIndex:v.selectedIndex animated:NO];
        Check(SynchronousLayouts==0 && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"animation-disable acknowledgement cancels transition without forcing layout");
        AnimationEnabled=YES;
        ResetCounters(); [v selectTabAtIndex:1 animated:YES];
        Check(v.selectedIndex==1 && [v.selectedTabID isEqualToString:@"tab1"] && v.tabButtons[1].selected && !v.tabButtons[0].selected,@"actual selection changes identity and selected buttons");
        Check(SynchronousLayouts==1,@"actual selection still synchronizes geometry before animating");
        Check([v.indicatorView.layer animationForKey:kIndicatorAnimationKey]!=nil,@"actual selection still animates indicator");
        [v updateInteractiveTransitionToIndex:2 progress:.5];
        Check(v.interactiveTransition && v.selectedIndex==1,@"interactive preview keeps committed selection");
        [v selectTabAtIndex:2 animated:YES];
        Check(!v.interactiveTransition && v.selectedIndex==2,@"interactive settle commits next selection");
        Check(SynchronousLayouts==1,@"interactive settle preserves finger geometry without forced layout");

        CALayer *capsule=[CALayer layer];
        CSGroupSetCapsuleLayer(capsule,1,YES,NO);
        [capsule addAnimation:animation forKey:kCapsuleAnimationKey];
        ResetCounters(); CSGroupSetCapsuleLayer(capsule,1,YES,YES);
        Check(Writes==0 && [capsule animationForKey:kCapsuleAnimationKey]!=nil,@"same capsule animation preserves phase");
        ResetCounters(); CSGroupSetCapsuleLayer(capsule,1,YES,NO);
        Check(Writes==1 && ![capsule animationForKey:kCapsuleAnimationKey],@"same capsule target cancels animation without writing model properties");

        printf("{\"checks\":%lu,\"failures\":%lu,\"stable_iterations\":1000,\"stable_visual_writes\":%lu,\"stable_text_measurements\":%lu,\"stable_synchronous_layouts\":%lu}\n",(unsigned long)Checks,(unsigned long)Failures,(unsigned long)stableWrites,(unsigned long)stableMeasures,(unsigned long)stableSync);
    }
    return Failures ? 1 : 0;
}
