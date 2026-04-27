// 底栏样式自定义
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 微信 TabBar 相关类声明
@interface MMTabbarItem : UITabBarItem
@property(nonatomic) long long index;
@property(retain, nonatomic) UIImage *normalImage;
@property(retain, nonatomic) UIImage *highlightImage;
@property(retain, nonatomic) NSString *normalTitle;
@end

@interface MMBadgeView : UIImageView
@end

@interface MMTabBarItemView : UIView
@property(retain, nonatomic) MMBadgeView *badgeView;
@property(retain, nonatomic) NSString *badgeString;
@property(nonatomic) long long unreadCount;
@property(retain, nonatomic) MMTabbarItem *item;
@property(retain, nonatomic) UILabel *textLabel;
@property(retain, nonatomic) UIImageView *imageView;
@property(nonatomic) BOOL isSelected;
- (void)setTitle:(NSString *)title;
@end

// 定义Associated Object的key
static const void *kOriginalTitleKey = &kOriginalTitleKey;
static const void *kCustomTabBarKey = &kCustomTabBarKey;

// 定义NSUserDefaults的键
static NSString * const kTabBarStyleEnabledKey = @"com.wechat.enhance.tabbar_style.enabled";
static NSString * const kTabBarHideTextKey = @"com.wechat.enhance.tabbar_style.hide_text";

static NSString * const kTabBarIconChatKey = @"com.wechat.enhance.tabbar_style.icon.chat";
static NSString * const kTabBarIconContactsKey = @"com.wechat.enhance.tabbar_style.icon.contacts";
static NSString * const kTabBarIconDiscoverKey = @"com.wechat.enhance.tabbar_style.icon.discover";
static NSString * const kTabBarIconMeKey = @"com.wechat.enhance.tabbar_style.icon.me";

static NSString * const kTabBarIconSelectedChatKey = @"com.wechat.enhance.tabbar_style.icon.selected.chat";
static NSString * const kTabBarIconSelectedContactsKey = @"com.wechat.enhance.tabbar_style.icon.selected.contacts";
static NSString * const kTabBarIconSelectedDiscoverKey = @"com.wechat.enhance.tabbar_style.icon.selected.discover";
static NSString * const kTabBarIconSelectedMeKey = @"com.wechat.enhance.tabbar_style.icon.selected.me";

// 新增样式设置键
static NSString * const kTabBarCornerRadiusKey = @"com.wechat.enhance.tabbar_style.corner_radius";
static NSString * const kTabBarPositionOffsetKey = @"com.wechat.enhance.tabbar_style.position_offset";
static NSString * const kTabBarScaleKey = @"com.wechat.enhance.tabbar_style.scale";
static NSString * const kTabBarBorderStyleKey = @"com.wechat.enhance.tabbar_style.border_style";
static NSString * const kTabBarHapticFeedbackKey = @"com.wechat.enhance.tabbar_style.haptic_feedback";
static NSString * const kTabBarBorderAnimationKey = @"com.wechat.enhance.tabbar_style.border_animation";

static NSString * const kTabBarBgColorRedKey = @"com.wechat.enhance.tabbar_style.bg_color.red";
static NSString * const kTabBarBgColorGreenKey = @"com.wechat.enhance.tabbar_style.bg_color.green";
static NSString * const kTabBarBgColorBlueKey = @"com.wechat.enhance.tabbar_style.bg_color.blue";
static NSString * const kTabBarBgColorAlphaKey = @"com.wechat.enhance.tabbar_style.bg_color.alpha";

static NSString * const kTabBarBorderColorRedKey = @"com.wechat.enhance.tabbar_style.border_color.red";
static NSString * const kTabBarBorderColorGreenKey = @"com.wechat.enhance.tabbar_style.border_color.green";
static NSString * const kTabBarBorderColorBlueKey = @"com.wechat.enhance.tabbar_style.border_color.blue";
static NSString * const kTabBarBorderColorAlphaKey = @"com.wechat.enhance.tabbar_style.border_color.alpha";

// 文本自定义键
static NSString * const kTabBarTextChatKey = @"com.wechat.enhance.tabbar_style.text.chat";
static NSString * const kTabBarTextContactsKey = @"com.wechat.enhance.tabbar_style.text.contacts";
static NSString * const kTabBarTextDiscoverKey = @"com.wechat.enhance.tabbar_style.text.discover";
static NSString * const kTabBarTextMeKey = @"com.wechat.enhance.tabbar_style.text.me";

// 缓存设置状态
static BOOL gTabBarStyleEnabled = NO;
static BOOL gTabBarHideText = NO;

// 缓存图标数据
static UIImage *gChatIcon = nil;
static UIImage *gContactsIcon = nil;
static UIImage *gDiscoverIcon = nil;
static UIImage *gMeIcon = nil;

static UIImage *gSelectedChatIcon = nil;
static UIImage *gSelectedContactsIcon = nil;
static UIImage *gSelectedDiscoverIcon = nil;
static UIImage *gSelectedMeIcon = nil;

// 缓存样式设置
static CGFloat gCornerRadius = 0.0;
static UIColor *gBgColor = nil;
static CGFloat gPositionOffset = 0.0;
static CGFloat gScale = 0.9;
static NSInteger gBorderStyle = 1; // 默认圆角
static NSInteger gHapticFeedback = 0; // 默认无
static NSInteger gBorderAnimation = 0; // 默认无动画
static UIColor *gBorderColor = nil;

// 缓存文本自定义
static NSString *gChatText = nil;
static NSString *gContactsText = nil;
static NSString *gDiscoverText = nil;
static NSString *gMeText = nil;

// 标志位，避免递归
static BOOL gIsApplyingOffset = NO;

// 从NSUserDefaults读取设置
static void loadSettings() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    gTabBarStyleEnabled = [defaults boolForKey:kTabBarStyleEnabledKey];
    gTabBarHideText = [defaults boolForKey:kTabBarHideTextKey];
    
    // 加载自定义图标（从文件路径加载）
    NSString *chatIconPath = [defaults stringForKey:kTabBarIconChatKey];
    NSString *contactsIconPath = [defaults stringForKey:kTabBarIconContactsKey];
    NSString *discoverIconPath = [defaults stringForKey:kTabBarIconDiscoverKey];
    NSString *meIconPath = [defaults stringForKey:kTabBarIconMeKey];
    
    NSString *selectedChatIconPath = [defaults stringForKey:kTabBarIconSelectedChatKey];
    NSString *selectedContactsIconPath = [defaults stringForKey:kTabBarIconSelectedContactsKey];
    NSString *selectedDiscoverIconPath = [defaults stringForKey:kTabBarIconSelectedDiscoverKey];
    NSString *selectedMeIconPath = [defaults stringForKey:kTabBarIconSelectedMeKey];
    
    // 从文件路径加载图片
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (chatIconPath && [fileManager fileExistsAtPath:chatIconPath]) {
        gChatIcon = [UIImage imageWithContentsOfFile:chatIconPath];
    } else {
        gChatIcon = nil;
    }
    
    if (contactsIconPath && [fileManager fileExistsAtPath:contactsIconPath]) {
        gContactsIcon = [UIImage imageWithContentsOfFile:contactsIconPath];
    } else {
        gContactsIcon = nil;
    }
    
    if (discoverIconPath && [fileManager fileExistsAtPath:discoverIconPath]) {
        gDiscoverIcon = [UIImage imageWithContentsOfFile:discoverIconPath];
    } else {
        gDiscoverIcon = nil;
    }
    
    if (meIconPath && [fileManager fileExistsAtPath:meIconPath]) {
        gMeIcon = [UIImage imageWithContentsOfFile:meIconPath];
    } else {
        gMeIcon = nil;
    }
    
    if (selectedChatIconPath && [fileManager fileExistsAtPath:selectedChatIconPath]) {
        gSelectedChatIcon = [UIImage imageWithContentsOfFile:selectedChatIconPath];
    } else {
        gSelectedChatIcon = nil;
    }
    
    if (selectedContactsIconPath && [fileManager fileExistsAtPath:selectedContactsIconPath]) {
        gSelectedContactsIcon = [UIImage imageWithContentsOfFile:selectedContactsIconPath];
    } else {
        gSelectedContactsIcon = nil;
    }
    
    if (selectedDiscoverIconPath && [fileManager fileExistsAtPath:selectedDiscoverIconPath]) {
        gSelectedDiscoverIcon = [UIImage imageWithContentsOfFile:selectedDiscoverIconPath];
    } else {
        gSelectedDiscoverIcon = nil;
    }
    
    if (selectedMeIconPath && [fileManager fileExistsAtPath:selectedMeIconPath]) {
        gSelectedMeIcon = [UIImage imageWithContentsOfFile:selectedMeIconPath];
    } else {
        gSelectedMeIcon = nil;
    }
    
    // 加载新的样式设置
    gCornerRadius = [defaults floatForKey:kTabBarCornerRadiusKey];
    gPositionOffset = [defaults floatForKey:kTabBarPositionOffsetKey];
    gScale = [defaults floatForKey:kTabBarScaleKey];
    if (gScale == 0) {
        gScale = 0.9; // 默认标准比例
    }
    
    gBorderStyle = [defaults integerForKey:kTabBarBorderStyleKey];
    if (gBorderStyle == 0 && ![defaults objectForKey:kTabBarBorderStyleKey]) {
        gBorderStyle = 1; // 默认圆角
    }
    
    gHapticFeedback = [defaults integerForKey:kTabBarHapticFeedbackKey];
    if (gHapticFeedback == 0 && ![defaults objectForKey:kTabBarHapticFeedbackKey]) {
        gHapticFeedback = 0; // 默认无
    }
    
    gBorderAnimation = [defaults integerForKey:kTabBarBorderAnimationKey];
    if (gBorderAnimation == 0 && ![defaults objectForKey:kTabBarBorderAnimationKey]) {
        gBorderAnimation = 0; // 默认无动画
    }
    
    NSLog(@"[TabBarStyle] loadSettings - gTabBarStyleEnabled: %d, gPositionOffset: %.1f, gScale: %.1f, gBorderStyle: %ld, gHapticFeedback: %ld, gBorderAnimation: %ld", gTabBarStyleEnabled, gPositionOffset, gScale, (long)gBorderStyle, (long)gHapticFeedback, (long)gBorderAnimation);
    
    // 加载背景颜色
    CGFloat red = [defaults floatForKey:kTabBarBgColorRedKey];
    CGFloat green = [defaults floatForKey:kTabBarBgColorGreenKey];
    CGFloat blue = [defaults floatForKey:kTabBarBgColorBlueKey];
    CGFloat alpha = [defaults floatForKey:kTabBarBgColorAlphaKey];
    
    if (red > 0 || green > 0 || blue > 0 || alpha > 0) {
        gBgColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    } else {
        gBgColor = nil;
    }
    
    // 加载描边颜色
    CGFloat borderRed = [defaults floatForKey:kTabBarBorderColorRedKey];
    CGFloat borderGreen = [defaults floatForKey:kTabBarBorderColorGreenKey];
    CGFloat borderBlue = [defaults floatForKey:kTabBarBorderColorBlueKey];
    CGFloat borderAlpha = [defaults floatForKey:kTabBarBorderColorAlphaKey];
    
    if (borderRed > 0 || borderGreen > 0 || borderBlue > 0 || borderAlpha > 0) {
        gBorderColor = [UIColor colorWithRed:borderRed green:borderGreen blue:borderBlue alpha:borderAlpha];
    } else {
        gBorderColor = nil;
    }
    
    // 加载文本自定义
    gChatText = [defaults stringForKey:kTabBarTextChatKey];
    gContactsText = [defaults stringForKey:kTabBarTextContactsKey];
    gDiscoverText = [defaults stringForKey:kTabBarTextDiscoverKey];
    gMeText = [defaults stringForKey:kTabBarTextMeKey];
}

// 根据索引获取对应的图标
static UIImage *getIconForIndex(NSInteger index, BOOL isSelected) {
    if (!gTabBarStyleEnabled) return nil;
    
    if (isSelected) {
        switch (index) {
            case 0:
                return gSelectedChatIcon;
            case 1:
                return gSelectedContactsIcon;
            case 2:
                return gSelectedDiscoverIcon;
            case 3:
                return gSelectedMeIcon;
            default:
                return nil;
        }
    } else {
        switch (index) {
            case 0:
                return gChatIcon;
            case 1:
                return gContactsIcon;
            case 2:
                return gDiscoverIcon;
            case 3:
                return gMeIcon;
            default:
                return nil;
        }
    }
}

// 根据标题获取对应的图标索引
static NSInteger getIndexForTitle(NSString *title) {
    if (!title) return -1;
    
    if ([title isEqualToString:@"微信"]) {
        return 0;
    } else if ([title isEqualToString:@"通讯录"]) {
        return 1;
    } else if ([title isEqualToString:@"发现"]) {
        return 2;
    } else if ([title isEqualToString:@"我"]) {
        return 3;
    }
    
    return -1;
}

// 根据标题获取对应的图标
static UIImage *getIconForTitle(NSString *title, BOOL isSelected) {
    NSInteger index = getIndexForTitle(title);
    if (index < 0) return nil;
    return getIconForIndex(index, isSelected);
}

// 获取圆角
static CGFloat getCornerRadius() {
    return gCornerRadius;
}

// 获取位置偏移
static CGFloat getPositionOffset() {
    return gPositionOffset;
}

// 获取底栏大小比例
static CGFloat getScale() {
    return gScale;
}

// 获取边框样式
static NSInteger getBorderStyle() {
    return gBorderStyle;
}

// 获取背景颜色
static UIColor *getBgColor() {
    return gBgColor;
}

// 检查当前视图控制器是否应该显示TabBar
static BOOL shouldShowTabBarForViewController(UIViewController *viewController) {
    if (!viewController) return NO;
    
    // 获取当前视图控制器的类名
    NSString *className = NSStringFromClass([viewController class]);
    
    NSLog(@"[TabBarStyle] Checking view controller: %@", className);
    
    // 只在这四个页面显示TabBar
    NSArray *allowedClasses = @[
        @"MoreViewController",           // 我的页面
        @"NewMainFrameViewController",   // 微信聊天列表页面
        @"FindFriendEntryViewController", // 发现页面
        @"ContactsViewController"        // 通讯录页面
    ];
    
    for (NSString *allowedClass in allowedClasses) {
        if ([className containsString:allowedClass]) {
            NSLog(@"[TabBarStyle] Matched allowed class: %@", allowedClass);
            return YES;
        }
    }
    
    // 如果是导航控制器，检查其顶层视图控制器
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)viewController;
        UIViewController *topVC = navController.topViewController;
        if (topVC) {
            NSString *topClassName = NSStringFromClass([topVC class]);
            NSLog(@"[TabBarStyle] Checking navigation top view controller: %@", topClassName);
            
            for (NSString *allowedClass in allowedClasses) {
                if ([topClassName containsString:allowedClass]) {
                    NSLog(@"[TabBarStyle] Matched allowed class in navigation: %@", allowedClass);
                    return YES;
                }
            }
        }
    }
    
    NSLog(@"[TabBarStyle] Not allowed, hiding TabBar");
    return NO;
}

// 获取自定义文本
static NSString *getCustomText(NSInteger index) {
    if (!gTabBarStyleEnabled) return nil;
    
    switch (index) {
        case 0:
            return gChatText;
        case 1:
            return gContactsText;
        case 2:
            return gDiscoverText;
        case 3:
            return gMeText;
        default:
            return nil;
    }
}

// 根据标题获取自定义文本
static NSString *getCustomTextForTitle(NSString *title) {
    NSInteger index = getIndexForTitle(title);
    if (index < 0) return nil;
    return getCustomText(index);
}

// Hook MMTabbarItem以设置自定义图标
%hook MMTabbarItem

// Hook初始化方法以设置index
- (id)initWithTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    // 保存原始标题用于图标匹配
    NSString *originalTitle = [title copy];
    
    // 应用自定义文本
    NSString *customText = getCustomTextForTitle(title);
    NSString *finalTitle = customText ? customText : title;
    
    id result = %orig(finalTitle, normalImage, selectedImage);
    
    // 根据原始标题设置index
    NSInteger index = getIndexForTitle(originalTitle);
    if (index >= 0) {
        self.index = index;
        // 保存原始标题
        objc_setAssociatedObject(self, kOriginalTitleKey, originalTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return result;
}

- (void)setNormalTitle:(NSString *)normalTitle {
    // 保存原始标题用于图标匹配
    NSString *originalTitle = [normalTitle copy];
    
    // 应用自定义文本
    NSString *customText = getCustomTextForTitle(normalTitle);
    NSString *finalTitle = customText ? customText : normalTitle;
    
    %orig(finalTitle);
    
    // 根据原始标题设置index
    NSInteger index = getIndexForTitle(originalTitle);
    if (index >= 0) {
        self.index = index;
        // 保存原始标题
        objc_setAssociatedObject(self, kOriginalTitleKey, originalTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setNormalImage:(UIImage *)normalImage {
    %orig;
    
    if (gTabBarStyleEnabled) {
        // 使用原始标题获取图标
        NSString *originalTitle = objc_getAssociatedObject(self, kOriginalTitleKey);
        if (!originalTitle) {
            originalTitle = self.normalTitle;
        }
        UIImage *customIcon = getIconForTitle(originalTitle, NO);
        if (customIcon) {
            %orig(customIcon);
        }
    }
}

- (void)setHighlightImage:(UIImage *)highlightImage {
    %orig;
    
    if (gTabBarStyleEnabled) {
        // 使用原始标题获取图标
        NSString *originalTitle = objc_getAssociatedObject(self, kOriginalTitleKey);
        if (!originalTitle) {
            originalTitle = self.normalTitle;
        }
        UIImage *customIcon = getIconForTitle(originalTitle, YES);
        if (customIcon) {
            %orig(customIcon);
        }
    }
}

%end

// Hook MMTabBarItemView以控制文本显示和图标
%hook MMTabBarItemView

- (void)setTitle:(NSString *)title {
    if (gTabBarStyleEnabled) {
        // 先应用自定义文本
        NSString *customText = getCustomTextForTitle(title);
        if (customText) {
            %orig(customText);
            return;
        }
        
        // 如果隐藏文本
        if (gTabBarHideText) {
            %orig(@"");
            return;
        }
    }
    %orig;
}

- (void)setSelected:(BOOL)selected {
    %orig;
    
    if (gTabBarStyleEnabled && self.item) {
        // 使用原始标题获取图标
        NSString *originalTitle = objc_getAssociatedObject(self.item, kOriginalTitleKey);
        if (!originalTitle) {
            originalTitle = self.item.normalTitle;
        }
        UIImage *customIcon = getIconForTitle(originalTitle, selected);
        if (customIcon && self.imageView) {
            self.imageView.image = customIcon;
        }
    }
}

- (void)layoutSubviews {
    %orig;
    
    if (gTabBarStyleEnabled && gTabBarHideText && self.textLabel) {
        self.textLabel.hidden = YES;
        
        // 调整图标位置到中心
        if (self.imageView) {
            CGRect frame = self.imageView.frame;
            frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
            self.imageView.frame = frame;
        }
    }
}

%end

// MMTabBar类定义
@interface MMTabBar : UITabBar
@property (retain, nonatomic) UIView *backgroundView;
@property (retain, nonatomic) NSMutableArray *tabBarItemViews;
@property (nonatomic) double extraKeyboardHeight;
- (void)relayoutTabBarItems;
@end

// Hook MMTabBar的setHidden方法，确保在启用自定义TabBar时始终隐藏
%hook MMTabBar

- (void)setHidden:(BOOL)hidden {
    // 如果启用了自定义TabBar，强制隐藏官方TabBar
    if (gTabBarStyleEnabled) {
        %orig(YES);
    } else {
        %orig(hidden);
    }
}

%end

// MMTabBarController类定义
@interface MMTabBarController : UITabBarController
@end

// 自定义TabBar视图
@interface CSCustomTabBar : UIView
@property (nonatomic, weak) MMTabBarController *tabBarController;
@property (nonatomic, strong) NSMutableArray *tabButtons;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSTimer *badgeUpdateTimer;
- (void)updateSelectedIndex:(NSInteger)index;
- (void)updateTabBarItems;
- (void)updateAllBadges;
- (void)applyBorderAnimation;
- (void)startBadgeUpdateTimer;
- (void)stopBadgeUpdateTimer;
@end

@implementation CSCustomTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tabButtons = [NSMutableArray array];
        _selectedIndex = 0;
    }
    return self;
}

- (void)dealloc {
    [self stopBadgeUpdateTimer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 更新角标
    [self updateAllBadges];
}

- (void)startBadgeUpdateTimer {
    if (!self.badgeUpdateTimer) {
        self.badgeUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                 target:self
                                                               selector:@selector(updateAllBadges)
                                                               userInfo:nil
                                                                repeats:YES];
    }
}

- (void)stopBadgeUpdateTimer {
    if (self.badgeUpdateTimer) {
        [self.badgeUpdateTimer invalidate];
        self.badgeUpdateTimer = nil;
    }
}

- (void)updateTabBarItems {
    // 清除旧的按钮
    for (UIButton *button in self.tabButtons) {
        [button removeFromSuperview];
    }
    [self.tabButtons removeAllObjects];
    
    if (!self.tabBarController) return;
    
    // 获取官方的tabBar items
    UITabBar *officialTabBar = self.tabBarController.tabBar;
    NSArray *items = officialTabBar.items;
    
    if (!items || items.count == 0) return;
    
    // 使用当前bounds的宽度（已经是缩放后的宽度）
    CGFloat tabBarWidth = self.bounds.size.width;
    CGFloat tabBarHeight = self.bounds.size.height;
    
    CGFloat buttonWidth = tabBarWidth / items.count;
    CGFloat buttonHeight = tabBarHeight;
    
    for (NSInteger i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        button.tag = i;
        [button addTarget:self action:@selector(tabButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置图标
        // 优先使用 MMTabbarItem 的属性，因为微信使用的是 normalImage 和 highlightImage
        UIImage *icon = nil;
        UIImage *selectedIcon = nil;
        
        if ([item isKindOfClass:objc_getClass("MMTabbarItem")]) {
            MMTabbarItem *mmItem = (MMTabbarItem *)item;
            icon = mmItem.normalImage;
            selectedIcon = mmItem.highlightImage;
        }
        
        // 如果 MMTabbarItem 的属性为空，尝试使用 UITabBarItem 的标准属性
        if (!icon) {
            icon = item.image;
        }
        if (!selectedIcon) {
            selectedIcon = item.selectedImage;
        }
        
        // 检查是否有自定义图标
        UIImage *customIcon = nil;
        UIImage *customSelectedIcon = nil;
        
        NSString *originalTitle = [item.title lowercaseString];
        if ([originalTitle containsString:@"微信"] || [originalTitle containsString:@"chats"]) {
            customIcon = gChatIcon;
            customSelectedIcon = gSelectedChatIcon;
        } else if ([originalTitle containsString:@"通讯录"] || [originalTitle containsString:@"contacts"]) {
            customIcon = gContactsIcon;
            customSelectedIcon = gSelectedContactsIcon;
        } else if ([originalTitle containsString:@"发现"] || [originalTitle containsString:@"discover"]) {
            customIcon = gDiscoverIcon;
            customSelectedIcon = gSelectedDiscoverIcon;
        } else if ([originalTitle containsString:@"我"] || [originalTitle containsString:@"me"]) {
            customIcon = gMeIcon;
            customSelectedIcon = gSelectedMeIcon;
        }
        
        if (i == self.selectedIndex) {
            if (customSelectedIcon) {
                // 调整图标尺寸
                CGSize iconSize = CGSizeMake(25, 25);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, [UIScreen mainScreen].scale);
                [customSelectedIcon drawInRect:CGRectMake(0, 0, iconSize.width, iconSize.height)];
                UIImage *resizedIcon = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [button setImage:resizedIcon forState:UIControlStateNormal];
            } else if (selectedIcon) {
                [button setImage:selectedIcon forState:UIControlStateNormal];
            } else if (customIcon) {
                CGSize iconSize = CGSizeMake(25, 25);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, [UIScreen mainScreen].scale);
                [customIcon drawInRect:CGRectMake(0, 0, iconSize.width, iconSize.height)];
                UIImage *resizedIcon = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [button setImage:resizedIcon forState:UIControlStateNormal];
            } else {
                [button setImage:icon forState:UIControlStateNormal];
            }
            button.tintColor = self.tabBarController.tabBar.tintColor;
        } else {
            if (customIcon) {
                CGSize iconSize = CGSizeMake(25, 25);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, [UIScreen mainScreen].scale);
                [customIcon drawInRect:CGRectMake(0, 0, iconSize.width, iconSize.height)];
                UIImage *resizedIcon = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [button setImage:resizedIcon forState:UIControlStateNormal];
            } else {
                [button setImage:icon forState:UIControlStateNormal];
            }
            button.tintColor = [UIColor grayColor];
        }
        
        // 设置标题
        if (!gTabBarHideText) {
            NSString *title = item.title;
            // 应用文本自定义
            if ([originalTitle containsString:@"微信"] || [originalTitle containsString:@"chats"]) {
                if (gChatText) title = gChatText;
            } else if ([originalTitle containsString:@"通讯录"] || [originalTitle containsString:@"contacts"]) {
                if (gContactsText) title = gContactsText;
            } else if ([originalTitle containsString:@"发现"] || [originalTitle containsString:@"discover"]) {
                if (gDiscoverText) title = gDiscoverText;
            } else if ([originalTitle containsString:@"我"] || [originalTitle containsString:@"me"]) {
                if (gMeText) title = gMeText;
            }
            
            [button setTitle:title forState:UIControlStateNormal];
            
            // 设置文本字体大小（参考官方 TabBar 的文本大小）
            button.titleLabel.font = [UIFont systemFontOfSize:10];
            
            if (i == self.selectedIndex) {
                [button setTitleColor:self.tabBarController.tabBar.tintColor forState:UIControlStateNormal];
            } else {
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
        
        // 调整图标和标题的位置
        if (!gTabBarHideText) {
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.bounds.size.width, -button.imageView.bounds.size.height - 5, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.bounds.size.height - 5, 0, 0, -button.titleLabel.bounds.size.width);
        }
        
        // 添加角标
        [self updateBadgeForButton:button item:item index:i];
        
        [self addSubview:button];
        [self.tabButtons addObject:button];
    }
    
    // 启动角标更新定时器
    [self startBadgeUpdateTimer];
}

- (void)updateBadgeForButton:(UIButton *)button item:(UITabBarItem *)item index:(NSInteger)index {
    // 获取角标值 - 微信使用自己的角标系统
    NSString *badgeValue = nil;
    long long unreadCount = 0;
    
    // 尝试从官方 TabBar 的 subviews 中获取 MMTabBarItemView 的角标信息
    if (self.tabBarController && self.tabBarController.tabBar) {
        UITabBar *officialTabBar = self.tabBarController.tabBar;
        
        // 遍历官方 TabBar 的 subviews 查找 MMTabBarItemView
        for (UIView *subview in officialTabBar.subviews) {
            if ([subview isKindOfClass:objc_getClass("MMTabBarItemView")]) {
                // 检查这个 MMTabBarItemView 是否对应当前 index
                NSInteger itemIndex = -1;
                @try {
                    // MMTabBarItemView 有一个 item 属性，item 有 index 属性
                    id tabItem = [subview valueForKey:@"item"];
                    if (tabItem && [tabItem respondsToSelector:@selector(index)]) {
                        itemIndex = [(MMTabbarItem *)tabItem index];
                    }
                } @catch (NSException *e) {
                    // 忽略异常
                }
                
                if (itemIndex == index) {
                    // 优先获取 unreadCount
                    @try {
                        unreadCount = [(MMTabBarItemView *)subview unreadCount];
                        NSLog(@"[CSTabBar] Index %ld, unreadCount: %lld", (long)index, unreadCount);
                    } @catch (NSException *e) {
                        // 忽略异常
                    }
                    
                    // 如果有未读数量，使用数字
                    if (unreadCount > 0) {
                        badgeValue = [NSString stringWithFormat:@"%lld", unreadCount];
                    } else {
                        // 否则获取 badgeString
                        @try {
                            badgeValue = [subview valueForKey:@"badgeString"];
                            NSLog(@"[CSTabBar] Index %ld, badgeString: %@", (long)index, badgeValue);
                        } @catch (NSException *e) {
                            // 忽略异常
                        }
                    }
                    
                    // 如果还是没有，检查 badgeView 是否存在
                    if (!badgeValue || badgeValue.length == 0) {
                        @try {
                            id badgeView = [subview valueForKey:@"badgeView"];
                            if (badgeView && ![(UIView *)badgeView isHidden]) {
                                // 如果有 badgeView 但没有值，显示小红点
                                badgeValue = @"•";
                            }
                        } @catch (NSException *e) {
                            // 忽略异常
                        }
                    }
                    
                    break;
                }
            }
        }
    }
    
    // 如果从 MMTabBarItemView 获取失败，尝试使用标准的 badgeValue
    if (!badgeValue || badgeValue.length == 0) {
        badgeValue = item.badgeValue;
    }
    
    NSLog(@"[CSTabBar] Final badge for index %ld: %@", (long)index, badgeValue);
    
    // 检查现有的角标视图
    UIView *existingBadge = [button viewWithTag:9999 + index];
    
    // 如果没有角标值，移除现有角标
    if (!badgeValue || badgeValue.length == 0) {
        if (existingBadge) {
            [existingBadge removeFromSuperview];
        }
        return;
    }
    
    // 如果已有角标且值相同，不更新
    if (existingBadge && [existingBadge isKindOfClass:objc_getClass("MMBadgeView")]) {
        MMBadgeView *existingMMBadge = (MMBadgeView *)existingBadge;
        @try {
            UILabel *badgeLabel = [existingMMBadge valueForKey:@"badgeLabel"];
            NSString *existingText = badgeLabel.text;
            
            // 对于小红点，检查是否是小红点样式
            if ([badgeValue isEqualToString:@"•"] || [badgeValue isEqualToString:@""]) {
                if (existingText.length == 0 || [existingText isEqualToString:@""]) {
                    NSLog(@"[CSTabBar] Red dot unchanged, skip update");
                    return;
                }
            } else {
                // 对于数字角标，检查文本是否相同
                if ([existingText isEqualToString:badgeValue]) {
                    NSLog(@"[CSTabBar] Badge unchanged, skip update");
                    return;
                }
            }
        } @catch (NSException *e) {
            // 忽略异常
        }
    }
    
    // 如果已有角标视图，直接更新内容，不移除
    if (existingBadge && [existingBadge isKindOfClass:objc_getClass("MMBadgeView")]) {
        MMBadgeView *existingMMBadge = (MMBadgeView *)existingBadge;
        @try {
            if ([badgeValue isEqualToString:@"•"] || [badgeValue isEqualToString:@""]) {
                // 小红点 - 设置为小红点样式
                [existingMMBadge performSelector:@selector(setAsSmallDot)];
            } else {
                // 数字角标 - 使用 setString: 方法，避免 maxCount 限制
                [existingMMBadge performSelector:@selector(setString:) withObject:badgeValue];
            }
            NSLog(@"[CSTabBar] Updated existing badge");
            return;
        } @catch (NSException *e) {
            NSLog(@"[CSTabBar] Failed to update existing badge: %@", e);
            // 如果更新失败，移除旧的角标
            [existingBadge removeFromSuperview];
            existingBadge = nil;
        }
    }
    
    // 移除旧的角标（如果不是 MMBadgeView 或更新失败）
    if (existingBadge) {
        [existingBadge removeFromSuperview];
    }
    
    // 创建新的角标视图 - 使用官方的 MMBadgeView
    MMBadgeView *badgeView = [[objc_getClass("MMBadgeView") alloc] init];
    
    @try {
        if ([badgeValue isEqualToString:@"•"] || [badgeValue isEqualToString:@""]) {
            // 小红点 - 设置为小红点样式
            [badgeView performSelector:@selector(setAsSmallDot)];
        } else {
            // 数字角标 - 使用 setString: 方法，避免 maxCount 限制
            [badgeView performSelector:@selector(setString:) withObject:badgeValue];
        }
    } @catch (NSException *e) {
        NSLog(@"[CSTabBar] Failed to setup MMBadgeView: %@", e);
    }
    
    if (!badgeView) {
        NSLog(@"[CSTabBar] Failed to create MMBadgeView");
        return;
    }
    
    badgeView.tag = 9999 + index;
    
    // 使用延迟布局，确保按钮已经完成布局
    dispatch_async(dispatch_get_main_queue(), ^{
        // 计算角标位置（在图标右上角）
        CGFloat iconWidth = button.imageView.bounds.size.width;
        CGFloat iconHeight = button.imageView.bounds.size.height;
        
        NSLog(@"[CSTabBar] Icon size: %.1f x %.1f", iconWidth, iconHeight);
        
        // 图标中心位置
        CGFloat iconCenterX = button.bounds.size.width / 2;
        CGFloat iconCenterY = button.bounds.size.height / 2 - (gTabBarHideText ? 0 : 10);
        
        // 角标位置（图标右上角）
        CGFloat ratio = 0.1; // 10%的图标宽度
        CGFloat badgeX = iconCenterX + iconWidth / 2 - 5 - (iconWidth * ratio);
        CGFloat badgeY = iconCenterY - iconHeight / 2 - 5;
        
        badgeView.center = CGPointMake(badgeX + badgeView.bounds.size.width / 2, badgeY + badgeView.bounds.size.height / 2);
        
        NSLog(@"[CSTabBar] Badge frame: %@", NSStringFromCGRect(badgeView.frame));
    });
    
    [button addSubview:badgeView];
}

- (void)tabButtonTapped:(UIButton *)sender {
    NSInteger index = sender.tag;
    
    // 根据触感设置触发相应的反馈
    if (gHapticFeedback > 0) {
        UIImpactFeedbackGenerator *generator = nil;
        switch (gHapticFeedback) {
            case 1: // 舒适
                if (@available(iOS 13.0, *)) {
                    generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft];
                }
                break;
            case 2: // 轻柔
                generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
                break;
            case 3: // 中度
                generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
                break;
            case 4: // 强烈
                generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
                break;
            default:
                break;
        }
        
        if (generator) {
            [generator impactOccurred];
        }
    }
    
    // 调用官方的切换方法
    if (self.tabBarController) {
        self.tabBarController.selectedIndex = index;
        [self updateSelectedIndex:index];
    }
}

- (void)updateSelectedIndex:(NSInteger)index {
    self.selectedIndex = index;
    [self updateButtonStates];
}

- (void)updateButtonStates {
    if (!self.tabBarController || self.tabButtons.count == 0) return;
    
    UITabBar *officialTabBar = self.tabBarController.tabBar;
    NSArray *items = officialTabBar.items;
    
    if (!items || items.count != self.tabButtons.count) return;
    
    for (NSInteger i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        UIButton *button = self.tabButtons[i];
        
        // 获取图标
        UIImage *icon = nil;
        UIImage *selectedIcon = nil;
        
        if ([item isKindOfClass:objc_getClass("MMTabbarItem")]) {
            MMTabbarItem *mmItem = (MMTabbarItem *)item;
            icon = mmItem.normalImage;
            selectedIcon = mmItem.highlightImage;
        }
        
        if (!icon) {
            icon = item.image;
        }
        if (!selectedIcon) {
            selectedIcon = item.selectedImage;
        }
        
        // 检查是否有自定义图标
        UIImage *customIcon = nil;
        UIImage *customSelectedIcon = nil;
        
        NSString *originalTitle = [item.title lowercaseString];
        if ([originalTitle containsString:@"微信"] || [originalTitle containsString:@"chats"]) {
            customIcon = gChatIcon;
            customSelectedIcon = gSelectedChatIcon;
        } else if ([originalTitle containsString:@"通讯录"] || [originalTitle containsString:@"contacts"]) {
            customIcon = gContactsIcon;
            customSelectedIcon = gSelectedContactsIcon;
        } else if ([originalTitle containsString:@"发现"] || [originalTitle containsString:@"discover"]) {
            customIcon = gDiscoverIcon;
            customSelectedIcon = gSelectedDiscoverIcon;
        } else if ([originalTitle containsString:@"我"] || [originalTitle containsString:@"me"]) {
            customIcon = gMeIcon;
            customSelectedIcon = gSelectedMeIcon;
        }
        
        // 更新图标
        if (i == self.selectedIndex) {
            if (customSelectedIcon) {
                CGSize iconSize = CGSizeMake(25, 25);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, [UIScreen mainScreen].scale);
                [customSelectedIcon drawInRect:CGRectMake(0, 0, iconSize.width, iconSize.height)];
                UIImage *resizedIcon = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [button setImage:resizedIcon forState:UIControlStateNormal];
            } else if (selectedIcon) {
                [button setImage:selectedIcon forState:UIControlStateNormal];
            } else if (customIcon) {
                CGSize iconSize = CGSizeMake(25, 25);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, [UIScreen mainScreen].scale);
                [customIcon drawInRect:CGRectMake(0, 0, iconSize.width, iconSize.height)];
                UIImage *resizedIcon = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [button setImage:resizedIcon forState:UIControlStateNormal];
            } else {
                [button setImage:icon forState:UIControlStateNormal];
            }
            button.tintColor = self.tabBarController.tabBar.tintColor;
        } else {
            if (customIcon) {
                CGSize iconSize = CGSizeMake(25, 25);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, [UIScreen mainScreen].scale);
                [customIcon drawInRect:CGRectMake(0, 0, iconSize.width, iconSize.height)];
                UIImage *resizedIcon = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [button setImage:resizedIcon forState:UIControlStateNormal];
            } else {
                [button setImage:icon forState:UIControlStateNormal];
            }
            button.tintColor = [UIColor grayColor];
        }
        
        // 更新文本颜色
        if (!gTabBarHideText) {
            if (i == self.selectedIndex) {
                [button setTitleColor:self.tabBarController.tabBar.tintColor forState:UIControlStateNormal];
            } else {
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)updateAllBadges {
    if (!self.tabBarController) return;
    
    NSArray *items = self.tabBarController.tabBar.items;
    if (!items || items.count != self.tabButtons.count) return;
    
    for (NSInteger i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        UIButton *button = self.tabButtons[i];
        
        if (button && item) {
            [self updateBadgeForButton:button item:item index:i];
        }
    }
}

- (void)applyBorderAnimation {
    // 移除之前的动画
    [self.layer removeAllAnimations];
    
    // 根据动画类型应用不同的动画
    if (gBorderAnimation == 1) {
        // 呼吸动画 - 阴影效果
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        opacityAnimation.fromValue = @(0.3);
        opacityAnimation.toValue = @(1.0);
        opacityAnimation.duration = 1.5;
        opacityAnimation.autoreverses = YES;
        opacityAnimation.repeatCount = HUGE_VALF;
        opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:opacityAnimation forKey:@"shadowBreathAnimation"];
        
        CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        radiusAnimation.fromValue = @(3.0);
        radiusAnimation.toValue = @(8.0);
        radiusAnimation.duration = 1.5;
        radiusAnimation.autoreverses = YES;
        radiusAnimation.repeatCount = HUGE_VALF;
        radiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:radiusAnimation forKey:@"shadowRadiusBreathAnimation"];
    } else if (gBorderAnimation == 2) {
        // 心跳动画 - 阴影效果
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"shadowOpacity"];
        opacityAnimation.values = @[@(0.5), @(1.0), @(0.5), @(0.8), @(0.5)];
        opacityAnimation.keyTimes = @[@(0.0), @(0.2), @(0.4), @(0.6), @(1.0)];
        opacityAnimation.duration = 1.0;
        opacityAnimation.repeatCount = HUGE_VALF;
        opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:opacityAnimation forKey:@"shadowHeartbeatAnimation"];
        
        CAKeyframeAnimation *radiusAnimation = [CAKeyframeAnimation animationWithKeyPath:@"shadowRadius"];
        radiusAnimation.values = @[@(4.0), @(10.0), @(4.0), @(7.0), @(4.0)];
        radiusAnimation.keyTimes = @[@(0.0), @(0.2), @(0.4), @(0.6), @(1.0)];
        radiusAnimation.duration = 1.0;
        radiusAnimation.repeatCount = HUGE_VALF;
        radiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:radiusAnimation forKey:@"shadowRadiusHeartbeatAnimation"];
    }
}

@end

// Hook MMTabBarController以应用位置偏移
%hook MMTabBarController

- (void)viewDidLoad {
    %orig;
    
    // 检查当前视图控制器是否应该显示TabBar
    UIViewController *currentVC = self.selectedViewController;
    BOOL shouldShowTabBar = shouldShowTabBarForViewController(currentVC);
    
    if (gTabBarStyleEnabled) {
        // 开启底栏样式：隐藏官方TabBar
        self.tabBar.hidden = YES;
    } else {
        // 不开启底栏样式：只有四个主要页面显示官方TabBar
        self.tabBar.hidden = !shouldShowTabBar;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    %orig(animated);
    
    // 检查当前视图控制器是否应该显示TabBar
    UIViewController *currentVC = self.selectedViewController;
    BOOL shouldShowTabBar = shouldShowTabBarForViewController(currentVC);
    
    if (gTabBarStyleEnabled) {
        // 开启底栏样式：隐藏官方TabBar
        self.tabBar.hidden = YES;
    } else {
        // 不开启底栏样式：只有四个主要页面显示官方TabBar
        self.tabBar.hidden = !shouldShowTabBar;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    %orig(animated);
    
    // 检查当前视图控制器是否应该显示TabBar
    UIViewController *currentVC = self.selectedViewController;
    BOOL shouldShowTabBar = shouldShowTabBarForViewController(currentVC);
    
    if (gTabBarStyleEnabled) {
        // 开启底栏样式：隐藏官方TabBar
        self.tabBar.hidden = YES;
    } else {
        // 不开启底栏样式：只有四个主要页面显示官方TabBar
        self.tabBar.hidden = !shouldShowTabBar;
    }
}

- (void)viewWillLayoutSubviews {
    %orig;
    
    // 检查当前视图控制器是否应该显示TabBar
    UIViewController *currentVC = self.selectedViewController;
    BOOL shouldShowTabBar = shouldShowTabBarForViewController(currentVC);
    
    if (!gTabBarStyleEnabled) {
        // 不开启底栏样式：只有四个主要页面显示官方TabBar
        self.tabBar.hidden = !shouldShowTabBar;
        
        // 移除自定义TabBar
        CSCustomTabBar *customTabBar = (CSCustomTabBar *)objc_getAssociatedObject(self, kCustomTabBarKey);
        if (customTabBar) {
            [customTabBar removeFromSuperview];
            objc_setAssociatedObject(self, kCustomTabBarKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return;
    }
    
    // 开启底栏样式：隐藏官方TabBar，显示自定义TabBar
    self.tabBar.hidden = YES;
    
    // 创建或更新自定义TabBar
    CSCustomTabBar *customTabBar = (CSCustomTabBar *)objc_getAssociatedObject(self, kCustomTabBarKey);
    
    if (!shouldShowTabBar) {
        // 如果不应该显示TabBar，隐藏自定义TabBar
        if (customTabBar) {
            customTabBar.hidden = YES;
        }
        return;
    }
    
    // 应该显示TabBar
    if (!customTabBar) {
        customTabBar = [[CSCustomTabBar alloc] initWithFrame:CGRectZero];
        customTabBar.tabBarController = self;
        [self.view addSubview:customTabBar];
        objc_setAssociatedObject(self, kCustomTabBarKey, customTabBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    customTabBar.hidden = NO;
    
    // 设置自定义TabBar的frame
    CGRect tabBarFrame = self.tabBar.frame;
    CGFloat positionOffset = getPositionOffset();
    CGFloat scale = getScale();
    
    // 应用缩放：调整宽度、高度和位置
    CGFloat scaledWidth = tabBarFrame.size.width * scale;
    
    // 如果隐藏文本，高度应该更小
    CGFloat heightScale = scale;
    if (gTabBarHideText) {
        // 隐藏文本时，高度约为原来的0.8倍
        heightScale = scale * 0.88;
    }
    
    CGFloat scaledHeight = tabBarFrame.size.height * heightScale;
    CGFloat leftOffset = (tabBarFrame.size.width - scaledWidth) / 2;
    CGFloat bottomOffset = tabBarFrame.size.height - scaledHeight;
    
    tabBarFrame.size.width = scaledWidth;
    tabBarFrame.size.height = scaledHeight;
    tabBarFrame.origin.x += leftOffset;
    tabBarFrame.origin.y += bottomOffset;
    
    if (positionOffset != 0) {
        tabBarFrame.origin.y -= positionOffset;
    }
    
    customTabBar.frame = tabBarFrame;
    
    // 应用样式
    CGFloat cornerRadius = getCornerRadius();
    UIColor *bgColor = getBgColor();
    NSInteger borderStyle = getBorderStyle();
    
    // 根据边框样式设置圆角
    if (borderStyle == 0) {
        // 半圆（胶囊）：圆角为高度的一半
        customTabBar.layer.cornerRadius = tabBarFrame.size.height / 2.0;
        customTabBar.layer.masksToBounds = YES;
    } else if (cornerRadius > 0) {
        // 圆角：使用自定义圆角
        customTabBar.layer.cornerRadius = cornerRadius;
        customTabBar.layer.masksToBounds = YES;
    } else {
        customTabBar.layer.cornerRadius = 0;
        customTabBar.layer.masksToBounds = NO;
    }
    
    if (bgColor) {
        customTabBar.backgroundColor = bgColor;
    } else {
        customTabBar.backgroundColor = self.tabBar.backgroundColor;
    }
    
    // 应用描边 - 根据动画类型选择不同的效果
    if (gBorderAnimation == 0) {
        // 无动画：使用边框线条
        customTabBar.layer.shadowOpacity = 0;
        customTabBar.layer.shadowColor = nil;
        customTabBar.layer.shadowRadius = 0;
        customTabBar.layer.shadowOffset = CGSizeZero;
        
        if (gBorderColor) {
            customTabBar.layer.borderWidth = 1.0;
            customTabBar.layer.borderColor = gBorderColor.CGColor;
        } else {
            customTabBar.layer.borderWidth = 0;
            customTabBar.layer.borderColor = nil;
        }
    } else {
        // 有动画：使用阴影效果
        customTabBar.layer.borderWidth = 0;
        customTabBar.layer.borderColor = nil;
        
        if (gBorderColor) {
            customTabBar.layer.shadowColor = gBorderColor.CGColor;
            customTabBar.layer.shadowOpacity = 0.8;
            customTabBar.layer.shadowRadius = 5.0;
            customTabBar.layer.shadowOffset = CGSizeZero;
            customTabBar.layer.masksToBounds = NO;
        } else {
            customTabBar.layer.shadowOpacity = 0;
            customTabBar.layer.shadowColor = nil;
            customTabBar.layer.shadowRadius = 0;
            customTabBar.layer.shadowOffset = CGSizeZero;
        }
    }
    
    // 应用描边动画
    [customTabBar applyBorderAnimation];
    
    // 更新tabBar items
    [customTabBar updateTabBarItems];
}

- (void)viewDidLayoutSubviews {
    %orig;
    
    // 检查当前视图控制器是否应该显示TabBar
    UIViewController *currentVC = self.selectedViewController;
    BOOL shouldShowTabBar = shouldShowTabBarForViewController(currentVC);
    
    if (!gTabBarStyleEnabled) {
        // 不开启底栏样式：控制官方TabBar的显示
        self.tabBar.hidden = !shouldShowTabBar;
        return;
    }
    
    // 开启底栏样式：控制自定义TabBar的显示
    CSCustomTabBar *customTabBar = (CSCustomTabBar *)objc_getAssociatedObject(self, kCustomTabBarKey);
    if (customTabBar) {
        customTabBar.hidden = !shouldShowTabBar;
        if (shouldShowTabBar) {
            [self.view bringSubviewToFront:customTabBar];
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    %orig(selectedIndex);
    
    // 检查当前视图控制器是否应该显示TabBar
    UIViewController *currentVC = self.selectedViewController;
    BOOL shouldShowTabBar = shouldShowTabBarForViewController(currentVC);
    
    if (gTabBarStyleEnabled) {
        // 开启底栏样式：隐藏官方TabBar，控制自定义TabBar
        self.tabBar.hidden = YES;
        
        CSCustomTabBar *customTabBar = (CSCustomTabBar *)objc_getAssociatedObject(self, kCustomTabBarKey);
        if (customTabBar) {
            customTabBar.hidden = !shouldShowTabBar;
            if (shouldShowTabBar) {
                [customTabBar updateSelectedIndex:selectedIndex];
            }
        }
    } else {
        // 不开启底栏样式：控制官方TabBar的显示
        self.tabBar.hidden = !shouldShowTabBar;
    }
}

%end

// 构造函数，在加载时执行
%ctor {
    // 加载设置
    loadSettings();
    
    // 添加通知观察者，当设置变化时重新加载
    // 使用Darwin通知（进程间通信）
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)loadSettings,
                                    CFSTR("com.wechat.enhance.tabbar_style.changed"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    
    // 同时监听应用内通知
    [[NSNotificationCenter defaultCenter] addObserverForName:@"com.wechat.enhance.tabbar_style.changed"
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        loadSettings();
    }];
}
