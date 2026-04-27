#import "WESessionTabContainerView.h"
#import <UIKit/UIKit.h>

static CGFloat const kTabContainerHeight = 52.0;    // Tab 容器高度
static CGFloat const kTabMinWidth = 60.0;           // Tab 按钮最小宽度
static CGFloat const kTabMaxWidth = 100.0;          // Tab 按钮最大宽度
static CGFloat const kTabFontSize = 15.0;           // Tab 标题字体大小
static CGFloat const kIndicatorHeight = 2.0;        // 指示器高度
static CGFloat const kUnreadBadgeSize = 14.0;       // 未读角标大小
static CGFloat const kUnreadBadgeFontSize = 10.0;   // 未读角标字体大小
static CGFloat const kTabPadding = 16.0;            // Tab 按钮内边距
static CGFloat const kSearchButtonWidth = 44.0;     // 搜索按钮宽度
static CGFloat const kSearchIconSize = 16.0;        // 搜索图标大小

static UIColor *kWeChatGreenColor = nil;
static UIColor *kWeChatRedColor = nil;
static UIColor *kTextGrayColor = nil;
static UIColor *kBackgroundColor = nil;

@interface WETabButton : UIButton
@property (nonatomic, assign) NSInteger tabIndex;
@property (nonatomic, assign) NSInteger unreadCount;
@property (nonatomic, strong) UILabel *unreadBadge;
- (void)updateUnreadCount:(NSInteger)count;
@end

@implementation WETabButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:kTabFontSize];
        self.unreadCount = 0;
    }
    return self;
}

- (void)updateUnreadCount:(NSInteger)count {
    self.unreadCount = count;
    
    if (count > 0) {
        if (!self.unreadBadge) {
            self.unreadBadge = [[UILabel alloc] init];
            self.unreadBadge.font = [UIFont boldSystemFontOfSize:kUnreadBadgeFontSize];
            self.unreadBadge.textColor = [UIColor whiteColor];
            self.unreadBadge.textAlignment = NSTextAlignmentCenter;
            self.unreadBadge.layer.cornerRadius = kUnreadBadgeSize / 2.0;
            self.unreadBadge.layer.masksToBounds = YES;
            self.unreadBadge.backgroundColor = kWeChatRedColor;
            [self addSubview:self.unreadBadge];
        }
        
        NSString *text = count > 99 ? @"99+" : [NSString stringWithFormat:@"%ld", (long)count];
        self.unreadBadge.text = text;
        self.unreadBadge.hidden = NO;
        
        CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName: self.unreadBadge.font}];
        CGFloat badgeWidth = MAX(kUnreadBadgeSize, textSize.width + 4);
        CGFloat badgeX = self.bounds.size.width - badgeWidth - 4;
        self.unreadBadge.frame = CGRectMake(badgeX, 9, badgeWidth, kUnreadBadgeSize);
    } else {
        self.unreadBadge.hidden = YES;
    }
}

@end

@interface WESessionTabContainerView ()

@property (nonatomic, strong, readwrite) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<WETabButton *> *tabButtons;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) WETabButton *addButton;
@property (nonatomic, strong) NSArray<WESessionTabItem *> *tabs;
@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation WESessionTabContainerView

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kWeChatGreenColor = [UIColor colorWithRed:0.102 green:0.678 blue:0.098 alpha:1.0];
        kWeChatRedColor = [UIColor colorWithRed:0.980 green:0.318 blue:0.318 alpha:1.0];
        kTextGrayColor = [UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1.0];
        kBackgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
    });
}

+ (UIColor *)customIndicatorColor {
    NSString *colorKey = [self isDarkMode] ? 
        @"com.wechat.enhance.chat_group.indicator_color_dark" : 
        @"com.wechat.enhance.chat_group.indicator_color";
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:colorKey];
    if (data) {
        UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (color) return color;
    }
    return kWeChatGreenColor;
}

+ (UIColor *)customSelectedTextColor {
    NSString *colorKey = [self isDarkMode] ? 
        @"com.wechat.enhance.chat_group.selected_text_color_dark" : 
        @"com.wechat.enhance.chat_group.selected_text_color";
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:colorKey];
    if (data) {
        UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (color) return color;
    }
    return kWeChatGreenColor;
}

+ (BOOL)isDarkMode {
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.anyObject;
        return windowScene.windows.firstObject.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    return NO;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = kBackgroundColor;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    [self addSubview:_scrollView];
    
    _tabButtons = [NSMutableArray array];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = [WESessionTabContainerView customIndicatorColor];
    _indicatorView.layer.cornerRadius = kIndicatorHeight / 2.0;
    [_scrollView addSubview:_indicatorView];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (@available(iOS 13.0, *)) {
        _searchButton.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    } else {
        _searchButton.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    }
    [_searchButton setImage:[self searchIconImage] forState:UIControlStateNormal];
    [_searchButton addTarget:self action:@selector(searchButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_searchButton];
}

- (UIImage *)searchIconImage {
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:kSearchIconSize weight:UIImageSymbolWeightRegular];
    UIImage *image = [UIImage systemImageNamed:@"magnifyingglass" withConfiguration:config];
    if (image) {
        return image;
    }
    
    UIColor *iconColor;
    if (@available(iOS 13.0, *)) {
        iconColor = [UIColor blackColor];
    } else {
        iconColor = [UIColor blackColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kSearchIconSize, kSearchIconSize), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, iconColor.CGColor);
    CGContextSetLineWidth(context, 0.6);
    
    CGFloat circleRadius = 7.0;
    CGFloat circleCenter = 8.0;
    CGContextAddArc(context, circleCenter, circleCenter, circleRadius, 0, M_PI * 2, NO);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, circleCenter + circleRadius * 0.707, circleCenter + circleRadius * 0.707);
    CGContextAddLineToPoint(context, kSearchIconSize - 2, kSearchIconSize - 2);
    CGContextStrokePath(context);
    
    UIImage *customImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [customImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat containerWidth = self.bounds.size.width;
    CGFloat scrollViewWidth = containerWidth - kSearchButtonWidth;
    
    self.scrollView.frame = CGRectMake(0, 0, scrollViewWidth, kTabContainerHeight);
    self.searchButton.frame = CGRectMake(scrollViewWidth, 0, kSearchButtonWidth, kTabContainerHeight);
    
    [self layoutTabButtons];
}

- (void)layoutTabButtons {
    if (self.tabButtons.count == 0) {
        return;
    }
    
    CGFloat totalButtonWidth = 0;
    
    for (WETabButton *button in self.tabButtons) {
        CGSize titleSize = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
        CGFloat buttonWidth = MAX(kTabMinWidth, MIN(kTabMaxWidth, titleSize.width + kTabPadding * 2));
        totalButtonWidth += buttonWidth;
    }
    
    CGFloat containerWidth = self.scrollView.bounds.size.width;
    CGFloat totalSpacing = containerWidth - totalButtonWidth;
    CGFloat spacingBetweenButtons = totalSpacing / (self.tabButtons.count + 1);
    
    NSLog(@"[WESessionTabContainerView] layoutTabButtons - 容器宽度: %.2f, 按钮总宽度: %.2f, 按钮间距: %.2f", containerWidth, totalButtonWidth, spacingBetweenButtons);
    
    CGFloat xOffset = spacingBetweenButtons;
    
    for (WETabButton *button in self.tabButtons) {
        CGSize titleSize = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
        CGFloat buttonWidth = MAX(kTabMinWidth, MIN(kTabMaxWidth, titleSize.width + kTabPadding * 2));
        
        button.frame = CGRectMake(xOffset, 0, buttonWidth, kTabContainerHeight);
        xOffset += buttonWidth + spacingBetweenButtons;
        
        NSLog(@"[WESessionTabContainerView] layoutTabButtons - 按钮: %@, frame: %@", button.currentTitle, NSStringFromCGRect(button.frame));
    }
    
    self.scrollView.contentSize = CGSizeMake(MAX(containerWidth, totalButtonWidth + spacingBetweenButtons * (self.tabButtons.count + 1)), kTabContainerHeight);
    
    [self updateIndicatorPosition];
}

- (void)updateTabs:(NSArray<WESessionTabItem *> *)tabs {
    self.tabs = tabs;
    
    for (WETabButton *button in self.tabButtons) {
        [button removeFromSuperview];
    }
    [self.tabButtons removeAllObjects];
    
    UIColor *selectedTextColor = [WESessionTabContainerView customSelectedTextColor];
    
    for (NSInteger i = 0; i < tabs.count; i++) {
        WESessionTabItem *item = tabs[i];
        WETabButton *button = [[WETabButton alloc] init];
        button.tabIndex = i;
        [button setTitle:item.displayName forState:UIControlStateNormal];
        [button setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [button setTitleColor:selectedTextColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tabButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        [self.tabButtons addObject:button];
    }
    
    [self setNeedsLayout];
    
    if (self.tabButtons.count > 0) {
        [self selectTabAtIndex:0 animated:NO];
    }
}

- (void)updateUnreadCount:(NSInteger)count forTabIndex:(NSInteger)index {
    if (index >= 0 && index < self.tabButtons.count) {
        [self.tabButtons[index] updateUnreadCount:count];
    }
}

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (index < 0 || index >= self.tabButtons.count) {
        return;
    }
    
    BOOL shouldTriggerHaptic = (index != _selectedIndex);
    _selectedIndex = index;
    
    for (WETabButton *button in self.tabButtons) {
        button.selected = (button.tabIndex == index);
    }
    
    if (shouldTriggerHaptic) {
        [self triggerHapticFeedback];
    }
    
    if (animated) {
        [UIView animateWithDuration:0.18 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self updateIndicatorPosition];
            [self scrollToSelectedTab];
        } completion:nil];
    } else {
        [self updateIndicatorPosition];
        [self scrollToSelectedTab];
    }
}

- (void)triggerHapticFeedback {
    NSInteger hapticValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"com.wechat.enhance.chat_group.haptic_feedback"];
    
    if (hapticValue == 0) {
        return;
    }
    
    UIImpactFeedbackGenerator *generator = nil;
    
    switch (hapticValue) {
        case 1:
            generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft];
            break;
        case 2:
            generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
            break;
        case 3:
            generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
            break;
        case 4:
            generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
            break;
        default:
            return;
    }
    
    [generator impactOccurred];
}

- (void)updateIndicatorPosition {
    if (self.selectedIndex < 0 || self.selectedIndex >= self.tabButtons.count) {
        return;
    }
    
    WETabButton *selectedButton = self.tabButtons[self.selectedIndex];
    CGRect frame = selectedButton.frame;
    
    CGSize titleSize = [selectedButton.currentTitle sizeWithAttributes:@{NSFontAttributeName: selectedButton.titleLabel.font}];
    CGFloat indicatorWidth = titleSize.width + 12.0; //指示器宽度
    CGFloat indicatorX = frame.origin.x + (frame.size.width - indicatorWidth) / 2.0;
    
    self.indicatorView.frame = CGRectMake(indicatorX, kTabContainerHeight - kIndicatorHeight - 5, indicatorWidth, kIndicatorHeight);
}

- (void)scrollToSelectedTab {
    if (self.selectedIndex < 0 || self.selectedIndex >= self.tabButtons.count) {
        return;
    }
    
    WETabButton *selectedButton = self.tabButtons[self.selectedIndex];
    CGRect frame = selectedButton.frame;
    
    CGFloat offsetX = frame.origin.x - (self.scrollView.bounds.size.width - frame.size.width) / 2.0;
    offsetX = MAX(0, MIN(offsetX, self.scrollView.contentSize.width - self.scrollView.bounds.size.width));
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}

- (void)tabButtonTapped:(WETabButton *)sender {
    if (sender.tabIndex != self.selectedIndex) {
        [self selectTabAtIndex:sender.tabIndex animated:YES];
        
        if (self.onTabSelected) {
            self.onTabSelected(sender.tabIndex);
        }
    }
}

- (void)addButtonTapped {
    if (self.onAddButtonTapped) {
        self.onAddButtonTapped();
    }
}

- (void)searchButtonTapped {
    if (self.onSearchButtonTapped) {
        self.onSearchButtonTapped();
    }
}

@end
