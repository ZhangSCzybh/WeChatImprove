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
static NSTimeInterval const kIndicatorDuration = 0.26;
static NSString *const kIndicatorAnimationKey = @"CSGroupIndicator.selection";

@interface WETabButton : UIButton
@property (nonatomic) NSInteger tabIndex;
@property (nonatomic, copy) NSString *tabID;
@property (nonatomic) NSInteger unreadCount;
@property (nonatomic) BOOL hasRedDot;
@property (nonatomic) CGFloat baseFontSize;
@property (nonatomic, strong) UILabel *unreadBadge;
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot;
- (void)updateFonts;
- (CGFloat)badgeWidth;
- (CGRect)tabTitleFrame;
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
    self.titleLabel.font = [[UIFontMetrics metricsForTextStyle:UIFontTextStyleSubheadline]
        scaledFontForFont:[UIFont systemFontOfSize:self.baseFontSize] compatibleWithTraitCollection:self.traitCollection];
    self.unreadBadge.font = [[UIFontMetrics metricsForTextStyle:UIFontTextStyleCaption2]
        scaledFontForFont:[UIFont boldSystemFontOfSize:10] compatibleWithTraitCollection:self.traitCollection];
    [self setNeedsLayout];
}

- (CGFloat)badgeWidth {
    if (self.unreadBadge.hidden) return 0;
    if (self.unreadCount == 0) return 7;
    CGFloat height = MAX(14, ceil(self.unreadBadge.font.lineHeight) + 2);
    return MAX(height, ceil([self.unreadBadge.text sizeWithAttributes:@{NSFontAttributeName:self.unreadBadge.font}].width) + 6);
}

- (CGRect)tabTitleFrame {
    CGFloat trailing = self.unreadBadge.hidden ? 0 : [self badgeWidth] + kTabBadgeGap;
    CGRect available = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, kTabPadding / 2, 0, kTabPadding / 2 + trailing));
    CGSize size = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGFloat width = MIN(MAX(0, CGRectGetWidth(available)), ceil(size.width));
    CGFloat height = ceil(self.titleLabel.font.lineHeight);
    return CGRectMake(CGRectGetMidX(available) - width / 2, CGRectGetMidY(available) - height / 2, width, height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect titleFrame = [self tabTitleFrame];
    self.titleLabel.frame = titleFrame;
    CGFloat width = [self badgeWidth];
    CGFloat height = self.unreadCount > 0 ? MAX(14, ceil(self.unreadBadge.font.lineHeight) + 2) : 7;
    // Anchor to the actual title rather than the padded button's trailing edge.
    CGFloat x = MIN(CGRectGetMaxX(titleFrame) + kTabBadgeGap, CGRectGetWidth(self.bounds) - width);
    CGFloat y = MAX(2, CGRectGetMinY(titleFrame) - height * 0.35);
    self.unreadBadge.frame = CGRectMake(MAX(0, x), y, width, height);
    self.unreadBadge.layer.cornerRadius = height / 2;
}

- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot {
    count = MAX(0, count);
    if (self.unreadCount == count && self.hasRedDot == hasRedDot) return;
    self.unreadCount = count;
    self.hasRedDot = hasRedDot;
    self.unreadBadge.hidden = self.unreadCount == 0 && !hasRedDot;
    self.unreadBadge.text = self.unreadCount > 99 ? @"99+" :
        (self.unreadCount > 0 ? [NSString stringWithFormat:@"%ld", (long)self.unreadCount] : nil);
    self.accessibilityValue = self.unreadCount > 0 ? [NSString stringWithFormat:@"%ld 条未读消息", (long)self.unreadCount] :
        (hasRedDot ? @"有未读消息" : nil);
    [self setNeedsLayout];
}

@end

@interface WESessionTabContainerView ()
@property (nonatomic, strong, readwrite) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<WETabButton *> *tabButtons;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic) CGFloat baseFontSize;
@property (nonatomic) BOOL revealSelectionAfterLayout;
@property (nonatomic) CGSize indicatorLayoutSize;
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
    _searchButton = [self actionButtonWithSymbol:@"magnifyingglass" label:@"搜索聊天" action:@selector(searchButtonTapped)];
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

- (UIButton *)actionButtonWithSymbol:(NSString *)symbol label:(NSString *)label action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:17 weight:UIImageSymbolWeightRegular];
    [button setImage:[UIImage systemImageNamed:symbol withConfiguration:configuration] forState:UIControlStateNormal];
    button.accessibilityLabel = label;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
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
    self.indicatorView.backgroundColor = [self storedColorForKey:[@"com.wechat.enhance.chat_group.indicator_color" stringByAppendingString:suffix] fallback:green];
    self.backgroundColor = dark ? [UIColor.secondarySystemBackgroundColor resolvedColorWithTraitCollection:self.traitCollection] :
        [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1];
    UIColor *normal = [UIColor.secondaryLabelColor resolvedColorWithTraitCollection:self.traitCollection];
    for (WETabButton *button in self.tabButtons) {
        [button setTitleColor:normal forState:UIControlStateNormal];
        [button setTitleColor:selected forState:UIControlStateSelected];
    }
    self.searchButton.tintColor = [UIColor.labelColor resolvedColorWithTraitCollection:self.traitCollection];
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
    self.scrollView.frame = CGRectMake(left, 0, scrollWidth, height);
    self.searchButton.frame = CGRectMake(left + scrollWidth, 0, actionWidth, height);
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
    CGFloat titleWidth = ceil([button.currentTitle sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width);
    CGFloat badgeSpace = button.unreadBadge.hidden ? 0 : [button badgeWidth] + kTabBadgeGap;
    // Long names remain readable by scrolling; VoiceOver also receives the complete title.
    return MAX(kTabMinWidth, titleWidth + 2 * kTabPadding + badgeSpace);
}

- (void)layoutTabButtons {
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
        button.frame = CGRectMake(x, 0, width, CGRectGetHeight(self.scrollView.bounds));
        x += width + spacing;
    }
    self.scrollView.contentSize = CGSizeMake(MAX(viewport, self.tabButtons.count ? x : 0), CGRectGetHeight(self.scrollView.bounds));
    // A smaller font or hidden search button can remove horizontal overflow.
    CGFloat maxOffset = MAX(0, self.scrollView.contentSize.width - viewport);
    if (!self.scrollView.dragging && !self.scrollView.decelerating && self.scrollView.contentOffset.x > maxOffset)
        [self.scrollView setContentOffset:CGPointMake(maxOffset, 0) animated:NO];
    [self updateIndicatorPosition];
}

- (void)updateTabs:(NSArray<WESessionTabItem *> *)tabs {
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
    [button updateUnreadCount:count hasRedDot:hasRedDot];
    [self setNeedsLayout];
}

- (void)updateSelectedButtons {
    for (WETabButton *button in self.tabButtons) {
        button.selected = button.tabIndex == self.selectedIndex;
        button.accessibilityTraits = UIAccessibilityTraitButton | (button.selected ? UIAccessibilityTraitSelected : 0);
    }
}

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (index < 0 || index >= (NSInteger)self.tabButtons.count) return;
    [self layoutIfNeeded];
    // Publishing a projection reassigns the same stable selection several times.
    // That acknowledgement must not cancel an in-flight user transition.
    if (index == _selectedIndex) {
        // A settings refresh must still stop movement when the switch is disabled.
        if (!CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults))
            [self updateIndicatorPositionAnimated:NO];
        return;
    }
    _selectedIndex = index;
    _selectedTabID = [self.tabButtons[index].tabID copy];
    [self updateSelectedButtons];
    [self triggerHapticFeedback];
    BOOL animate = animated && CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults) && self.window && !UIAccessibilityIsReduceMotionEnabled();
    [self updateIndicatorPositionAnimated:animate];
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
    BOOL moving = [self.indicatorView.layer animationForKey:kIndicatorAnimationKey] != nil;
    [self updateIndicatorPositionAnimated:moving];
}

- (void)updateIndicatorPositionAnimated:(BOOL)animated {
    BOOL valid = self.selectedIndex >= 0 && self.selectedIndex < (NSInteger)self.tabButtons.count;
    BOOL wasHidden = self.indicatorView.hidden;
    self.indicatorView.hidden = !valid;
    if (!valid) {
        [self.indicatorView.layer removeAnimationForKey:kIndicatorAnimationKey];
        return;
    }
    WETabButton *button = self.tabButtons[self.selectedIndex];
    CGRect title = [button tabTitleFrame];
    CGFloat width = MAX(0, MIN(CGRectGetWidth(button.bounds) - 8, CGRectGetWidth(title) + 12));
    CGRect target = CGRectMake(CGRectGetMinX(button.frame) + CGRectGetMidX(title) - width / 2,
        MAX(0, CGRectGetHeight(self.scrollView.bounds) - kIndicatorHeight - 5), width, kIndicatorHeight);
    BOOL animate = animated && CSGroupIndicatorAnimationEnabled(NSUserDefaults.standardUserDefaults) && !wasHidden && self.window && !UIAccessibilityIsReduceMotionEnabled();
    [self moveIndicatorToFrame:target animated:animate];
}

- (void)moveIndicatorToFrame:(CGRect)target animated:(BOOL)animated {
    CALayer *layer = self.indicatorView.layer;
    if (animated && CGRectEqualToRect(layer.frame,target)) return;
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
    CGFloat stretch = MIN(14.0,distance * 0.12);
    CGPoint from = CGPointMake(CGRectGetMidX(start),CGRectGetMidY(start));
    CGPoint to = CGPointMake(CGRectGetMidX(target),CGRectGetMidY(target));
    CAKeyframeAnimation *position = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    position.values = @[[NSValue valueWithCGPoint:from],[NSValue valueWithCGPoint:to]];
    position.keyTimes = @[@0,@1];
    position.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    CAKeyframeAnimation *size = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    size.values = @[[NSValue valueWithCGSize:start.size],
        [NSValue valueWithCGSize:CGSizeMake(MAX(start.size.width,target.size.width)+stretch,target.size.height)],
        [NSValue valueWithCGSize:target.size]];
    size.keyTimes = @[@0,@0.45,@1];
    size.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    // Position has one continuous easing curve; only width turns at the stretch peak.
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
