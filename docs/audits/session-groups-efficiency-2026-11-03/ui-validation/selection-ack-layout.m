#import "WESessionTabContainerView.h"
#import "CSGroupAppearance.h"
#import <QuartzCore/QuartzCore.h>

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

// Match the native outlined magnifier proportions without relying on private
// asset names that change across WeChat versions. Render once at screen scale;
// template tint keeps the existing light/dark and custom colour behaviour.
static UIImage *CSGroupSearchIcon(void) {
    static UIImage *image; static dispatch_once_t once;
    dispatch_once(&once, ^{
        UIGraphicsImageRenderer *renderer=[[UIGraphicsImageRenderer alloc] initWithSize:CGSizeMake(24,24)];
        image=[[renderer imageWithActions:^(UIGraphicsImageRendererContext *context) {
            CGContextRef c=context.CGContext;
            CGContextSetStrokeColorWithColor(c,UIColor.blackColor.CGColor);
            CGContextSetLineWidth(c,1.5);
            CGContextSetLineCap(c,kCGLineCapButt);
            CGContextStrokeEllipseInRect(c,CGRectMake(1.75,1.75,17,17));
            CGContextMoveToPoint(c,16.26,16.26);
            CGContextAddLineToPoint(c,23,23);
            CGContextStrokePath(c);
        }] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    });
    return image;
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

@implementation WETabButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _baseFontSize = CSGroupDefaultTabFontSize;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.unreadBadge = [[UILabel alloc] init];
        self.unreadBadge.textColor = UIColor.whiteColor;
        self.unreadBadge.textAlignment = NSTextAlignmentCenter;
        self.unreadBadge.backgroundColor = [UIColor colorWithRed:0.980 green:0.318 blue:0.318 alpha:1];
        self.unreadBadge.layer.masksToBounds = YES;
        self.unreadBadge.isAccessibilityElement = NO;
        self.unreadBadge.hidden = YES;
        [self addSubview:self.unreadBadge];
        [self updateFonts];
    }
    return self;
}

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
    if (![self.measuredTitle isEqualToString:title] || ![self.measuredTitleFont isEqual:font]) {
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

@interface WESessionTabContainerView ()
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

@implementation WESessionTabContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self setupUI];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) [self setupUI];
    return self;
}

- (void)setupUI {
    _selectedIndex = NSNotFound;
    _baseFontSize = CSGroupTabFontSize(NSUserDefaults.standardUserDefaults);
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self addSubview:_scrollView];
    _tabButtons = [NSMutableArray array];
    _indicatorView = [[UIView alloc] init];
    _indicatorView.layer.cornerRadius = kIndicatorHeight / 2;
    _indicatorView.isAccessibilityElement = NO;
    _indicatorView.hidden = YES;
    [_scrollView addSubview:_indicatorView];
    _searchButton = [self searchActionButton];
    _searchButton.hidden = !CSGroupSearchButtonVisible(NSUserDefaults.standardUserDefaults);
    [self addSubview:_searchButton];
    [self refreshAppearance];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reduceMotionChanged:)
        name:UIAccessibilityReduceMotionStatusDidChangeNotification object:nil];
}

- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }

- (void)reduceMotionChanged:(NSNotification *)notification {
    (void)notification;
    if (UIAccessibilityIsReduceMotionEnabled()) [self updateIndicatorPositionAnimated:NO];
}

- (UIButton *)searchActionButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:CSGroupSearchIcon() forState:UIControlStateNormal];
    button.accessibilityLabel = @"搜索聊天";
    [button addTarget:self action:@selector(searchButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIColor *)storedColorForKey:(NSString *)key fallback:(UIColor *)fallback {
    id data = [NSUserDefaults.standardUserDefaults objectForKey:key];
    UIColor *color = nil;
    if ([data isKindOfClass:NSData.class]) {
        @try {
            id decoded = [NSKeyedUnarchiver unarchivedObjectOfClass:UIColor.class fromData:data error:nil];
            if ([decoded isKindOfClass:UIColor.class]) color = decoded;
        } @catch (__unused NSException *exception) {
            // Retain invalid legacy data; a bad appearance archive must not prevent opening the list.
        }
    }
    return [(color ?: fallback) resolvedColorWithTraitCollection:self.traitCollection];
}

- (void)refreshAppearance {
    BOOL dark = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    NSString *suffix = dark ? @"_dark" : @"";
    UIColor *green = [UIColor colorWithRed:0.102 green:0.678 blue:0.098 alpha:1];
    UIColor *selected = [self storedColorForKey:[@"com.wechat.enhance.chat_group.selected_text_color" stringByAppendingString:suffix] fallback:green];
    UIColor *indicator = [self storedColorForKey:[@"com.wechat.enhance.chat_group.indicator_color" stringByAppendingString:suffix] fallback:green];
    self.indicatorView.backgroundColor = indicator;
    CSGroupIndicatorStyle style = CSGroupCurrentIndicatorStyle(NSUserDefaults.standardUserDefaults);
    BOOL styleChanged = self.indicatorStyle != style;
    self.indicatorStyle = style;
    BOOL capsule = style == CSGroupIndicatorStyleCapsule;
    self.backgroundColor = dark ? [UIColor.secondarySystemBackgroundColor resolvedColorWithTraitCollection:self.traitCollection] :
        [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1];
    UIColor *normal = [UIColor.secondaryLabelColor resolvedColorWithTraitCollection:self.traitCollection];
    for (WETabButton *button in self.tabButtons) {
        [button setTitleColor:normal forState:UIControlStateNormal];
        [button setTitleColor:capsule ? normal : selected forState:UIControlStateSelected];
        [button configureCapsuleEnabled:capsule color:indicator textColor:selected];
    }
    self.searchButton.tintColor = [UIColor.labelColor resolvedColorWithTraitCollection:self.traitCollection];
    if (styleChanged) [self updateIndicatorPositionAnimated:NO];
}

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

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (!self.window) [self updateIndicatorPositionAnimated:NO];
    [self refreshAppearance];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self refreshAppearance];
    for (WETabButton *button in self.tabButtons) [button updateFonts];
    self.tabLayoutValid = NO;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (CGSize)intrinsicContentSize {
    UIFont *font = [[UIFontMetrics metricsForTextStyle:UIFontTextStyleSubheadline]
        scaledFontForFont:[UIFont systemFontOfSize:self.baseFontSize] compatibleWithTraitCollection:self.traitCollection];
    return CGSizeMake(UIViewNoIntrinsicMetric, MAX(kTabContainerHeight, ceil(font.lineHeight) + 24));
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

- (void)setSelectedTabID:(NSString *)selectedTabID {
    NSInteger index = [self indexForTabID:selectedTabID];
    if (index != NSNotFound) [self selectTabAtIndex:index animated:NO];
    else if (self.tabButtons.count == 0) _selectedTabID = [selectedTabID copy];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [self selectTabAtIndex:selectedIndex animated:NO];
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
    if (index == _selectedIndex) { [self layoutIfNeeded];
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

- (void)triggerHapticFeedback {
    NSInteger value = [NSUserDefaults.standardUserDefaults integerForKey:@"com.wechat.enhance.chat_group.haptic_feedback"];
    UIImpactFeedbackStyle style;
    switch (value) {
        case 1: style = UIImpactFeedbackStyleSoft; break;
        case 2: style = UIImpactFeedbackStyleLight; break;
        case 3: style = UIImpactFeedbackStyleMedium; break;
        case 4: style = UIImpactFeedbackStyleHeavy; break;
        default: return;
    }
    [[[UIImpactFeedbackGenerator alloc] initWithStyle:style] impactOccurred];
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

- (void)tabButtonTapped:(WETabButton *)sender {
    if (sender.tabIndex == self.selectedIndex) return;
    [self selectTabAtIndex:sender.tabIndex animated:YES];
    if (self.onTabSelected) self.onTabSelected(sender.tabIndex);
}

- (void)searchButtonTapped {
    if (self.onSearchButtonTapped) self.onSearchButtonTapped();
}

@end
