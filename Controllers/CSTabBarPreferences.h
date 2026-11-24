#import <UIKit/UIKit.h>

// Persisted values 1/2 retain the outward effects introduced in 1.6-38.
typedef NS_ENUM(NSInteger, CSTabBarBorderAnimation) {
    CSTabBarBorderAnimationNone = 0,
    CSTabBarBorderAnimationOutwardBreathing = 1,
    CSTabBarBorderAnimationOutwardHeartbeat = 2,
    CSTabBarBorderAnimationClassicBreathing = 3,
    CSTabBarBorderAnimationClassicHeartbeat = 4,
};

typedef NS_ENUM(NSInteger, CSTabBarClickEffect) {
    CSTabBarClickEffectNone = 0,
    CSTabBarClickEffectUnderline = 1,
    CSTabBarClickEffectBounce = CSTabBarClickEffectUnderline, // Persisted legacy value.
    CSTabBarClickEffectCapsule = 3,
};

static NSString * const kTabBarStyleEnabledKey = @"com.wechat.enhance.tabbar_style.enabled";
static NSString * const kTabBarHideTextKey = @"com.wechat.enhance.tabbar_style.hide_text";
static NSString * const kTabBarSwipeSwitchKey = @"com.wechat.enhance.tabbar_style.swipe_switch";

static NSString * const kTabBarIconChatKey = @"com.wechat.enhance.tabbar_style.icon.chat";
static NSString * const kTabBarIconContactsKey = @"com.wechat.enhance.tabbar_style.icon.contacts";
static NSString * const kTabBarIconDiscoverKey = @"com.wechat.enhance.tabbar_style.icon.discover";
static NSString * const kTabBarIconMeKey = @"com.wechat.enhance.tabbar_style.icon.me";

static NSString * const kTabBarIconSelectedChatKey = @"com.wechat.enhance.tabbar_style.icon.selected.chat";
static NSString * const kTabBarIconSelectedContactsKey = @"com.wechat.enhance.tabbar_style.icon.selected.contacts";
static NSString * const kTabBarIconSelectedDiscoverKey = @"com.wechat.enhance.tabbar_style.icon.selected.discover";
static NSString * const kTabBarIconSelectedMeKey = @"com.wechat.enhance.tabbar_style.icon.selected.me";

// 样式设置键
static NSString * const kTabBarCornerRadiusKey = @"com.wechat.enhance.tabbar_style.corner_radius";
static NSString * const kTabBarPositionOffsetKey = @"com.wechat.enhance.tabbar_style.position_offset";
static NSString * const kTabBarScaleKey = @"com.wechat.enhance.tabbar_style.scale";
static NSString * const kTabBarBorderStyleKey = @"com.wechat.enhance.tabbar_style.border_style";
static NSString * const kTabBarHapticFeedbackKey = @"com.wechat.enhance.tabbar_style.haptic_feedback";
static NSString * const kTabBarClickEffectKey = @"com.wechat.enhance.tabbar_style.click_effect";
static NSString * const kTabBarIndicatorColorKey = @"com.wechat.enhance.tabbar_style.indicator_color";
static NSString * const kTabBarIndicatorColorRedKey = @"com.wechat.enhance.tabbar_style.indicator_color.red";
static NSString * const kTabBarIndicatorColorGreenKey = @"com.wechat.enhance.tabbar_style.indicator_color.green";
static NSString * const kTabBarIndicatorColorBlueKey = @"com.wechat.enhance.tabbar_style.indicator_color.blue";
static NSString * const kTabBarIndicatorColorAlphaKey = @"com.wechat.enhance.tabbar_style.indicator_color.alpha";
static NSString * const kTabBarSelectedIconColorKey = @"com.wechat.enhance.tabbar_style.selected_icon_color";
static NSString * const kTabBarSelectedIconColorRedKey = @"com.wechat.enhance.tabbar_style.selected_icon_color.red";
static NSString * const kTabBarSelectedIconColorGreenKey = @"com.wechat.enhance.tabbar_style.selected_icon_color.green";
static NSString * const kTabBarSelectedIconColorBlueKey = @"com.wechat.enhance.tabbar_style.selected_icon_color.blue";
static NSString * const kTabBarSelectedIconColorAlphaKey = @"com.wechat.enhance.tabbar_style.selected_icon_color.alpha";
static NSString * const kTabBarBorderAnimationKey = @"com.wechat.enhance.tabbar_style.border_animation";
static NSString * const kTabBarBorderColorRedKey = @"com.wechat.enhance.tabbar_style.border_color.red";
static NSString * const kTabBarBorderColorGreenKey = @"com.wechat.enhance.tabbar_style.border_color.green";
static NSString * const kTabBarBorderColorBlueKey = @"com.wechat.enhance.tabbar_style.border_color.blue";
static NSString * const kTabBarBorderColorAlphaKey = @"com.wechat.enhance.tabbar_style.border_color.alpha";

static NSString * const kTabBarBgColorRedKey = @"com.wechat.enhance.tabbar_style.bg_color.red";
static NSString * const kTabBarBgColorGreenKey = @"com.wechat.enhance.tabbar_style.bg_color.green";
static NSString * const kTabBarBgColorBlueKey = @"com.wechat.enhance.tabbar_style.bg_color.blue";
static NSString * const kTabBarBgColorAlphaKey = @"com.wechat.enhance.tabbar_style.bg_color.alpha";

// 文本自定义键
static NSString * const kTabBarTextChatKey = @"com.wechat.enhance.tabbar_style.text.chat";
static NSString * const kTabBarTextContactsKey = @"com.wechat.enhance.tabbar_style.text.contacts";
static NSString * const kTabBarTextDiscoverKey = @"com.wechat.enhance.tabbar_style.text.discover";
static NSString * const kTabBarTextMeKey = @"com.wechat.enhance.tabbar_style.text.me";

// 默认值
static const CGFloat kDefaultCornerRadius = 20.0;
static const CGFloat kDefaultPositionOffset = 0.0;
static const CGFloat kDefaultScale = 0.9;
static const NSInteger kDefaultBorderStyle = 1; // 默认圆角


static NSString * const kTabBarContentHeightKey = @"com.wechat.enhance.tabbar_style.content_height";
static NSString * const kTabBarBorderWidthKey = @"com.wechat.enhance.tabbar_style.border_width";
static NSString * const CSTabBarPreferencesDidChange = @"com.wechat.enhance.tabbar_style.changed";

@interface CSTabBarPreferences : NSObject
@property(nonatomic) BOOL enabled, hideText, swipeSwitch;
@property(nonatomic) CGFloat scale, contentHeight, lift, cornerRadius, borderWidth;
@property(nonatomic) NSInteger borderStyle, haptic, animation;
@property(nonatomic) CSTabBarClickEffect clickEffect;
@property(nonatomic, strong) UIColor *backgroundColor, *borderColor;
// nil keeps the indicator's trait-dependent default; loading never persists it.
@property(nonatomic, strong) UIColor *indicatorColor;
// nil preserves WeChat's native selected artwork. Uploaded icons keep their colors.
@property(nonatomic, strong) UIColor *selectedIconColor;
@property(nonatomic, copy) NSArray *titles, *icons, *selectedIcons;
+ (instancetype)current;
+ (void)reload;
+ (UIColor *)colorInDefaults:(NSUserDefaults *)defaults prefix:(NSString *)prefix;
// Shared by preferences and settings previews. The resource identifier is its
// persisted icon key; file metadata and explicit mutations form its generation.
+ (UIImage *)cachedIconAtPath:(NSString *)path resourceIdentifier:(NSString *)identifier;
+ (void)invalidateIconAtPath:(NSString *)path resourceIdentifier:(NSString *)identifier;
- (UIImage *)iconAtIndex:(NSUInteger)index selected:(BOOL)selected;
- (NSString *)titleAtIndex:(NSUInteger)index;
@end
