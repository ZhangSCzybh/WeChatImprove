#import <Foundation/Foundation.h>
#import <math.h>

// Appearance preferences follow the existing global group colors and haptics.
static NSString *const CSGroupTabFontSizeKey = @"com.wechat.enhance.chat_group.tab_font_size";
static NSString *const CSGroupSearchButtonVisibleKey = @"com.wechat.enhance.chat_group.show_search_button";
static NSString *const CSGroupPageTransitionEnabledKey = @"com.wechat.enhance.chat_group.page_transition_enabled";
static NSString *const CSGroupIndicatorAnimationEnabledKey = @"com.wechat.enhance.chat_group.indicator_animation_enabled";
// Use a new key: an abandoned release used indicator_animation_style for other motions.
static NSString *const CSGroupIndicatorStyleKey = @"com.wechat.enhance.chat_group.selection_indicator_style";
typedef NS_ENUM(NSInteger, CSGroupIndicatorStyle) {
    CSGroupIndicatorStyleNone = 0,
    CSGroupIndicatorStyleUnderline = 1,
    CSGroupIndicatorStyleCapsule = 2,
};
static NSInteger const CSGroupDefaultTabFontSize = 18;
static NSInteger const CSGroupMinTabFontSize = 12;
static NSInteger const CSGroupMaxTabFontSize = 28;

NS_INLINE NSInteger CSGroupTabFontSize(NSUserDefaults *defaults) {
    id stored = [defaults objectForKey:CSGroupTabFontSizeKey];
    if (![stored isKindOfClass:NSNumber.class]) return CSGroupDefaultTabFontSize;
    double size = [stored doubleValue];
    if (!isfinite(size) || size < CSGroupMinTabFontSize || size > CSGroupMaxTabFontSize || floor(size) != size)
        return CSGroupDefaultTabFontSize;
    return (NSInteger)size;
}

NS_INLINE BOOL CSGroupSearchButtonVisible(NSUserDefaults *defaults) {
    id stored = [defaults objectForKey:CSGroupSearchButtonVisibleKey];
    return [stored isKindOfClass:NSNumber.class] ? [stored boolValue] : YES;
}

NS_INLINE BOOL CSGroupPageTransitionEnabled(NSUserDefaults *defaults) {
    id stored = [defaults objectForKey:CSGroupPageTransitionEnabledKey];
    return [stored isKindOfClass:NSNumber.class] && [stored doubleValue] == 1.0;
}

NS_INLINE CSGroupIndicatorStyle CSGroupCurrentIndicatorStyle(NSUserDefaults *defaults) {
    id style = [defaults objectForKey:CSGroupIndicatorStyleKey];
    if ([style isKindOfClass:NSNumber.class]) {
        double value = [style doubleValue];
        if (isfinite(value) && floor(value) == value && value >= CSGroupIndicatorStyleNone && value <= CSGroupIndicatorStyleCapsule)
            return (CSGroupIndicatorStyle)value;
    }
    id stored = [defaults objectForKey:CSGroupIndicatorAnimationEnabledKey];
    return [stored isKindOfClass:NSNumber.class] && ![stored boolValue] ? CSGroupIndicatorStyleNone : CSGroupIndicatorStyleUnderline;
}

NS_INLINE BOOL CSGroupIndicatorAnimationEnabled(NSUserDefaults *defaults) {
    return CSGroupCurrentIndicatorStyle(defaults) != CSGroupIndicatorStyleNone;
}

NS_INLINE NSString *CSGroupIndicatorStyleName(CSGroupIndicatorStyle style) {
    switch (style) {
        case CSGroupIndicatorStyleNone: return @"关闭";
        case CSGroupIndicatorStyleCapsule: return @"胶囊包裹";
        default: return @"下划线";
    }
}

NS_INLINE void CSGroupSetIndicatorStyle(NSUserDefaults *defaults, CSGroupIndicatorStyle style) {
    if (style < CSGroupIndicatorStyleNone || style > CSGroupIndicatorStyleCapsule) return;
    [defaults setInteger:style forKey:CSGroupIndicatorStyleKey];
    // Keep downgrades compatible with the original on/off setting.
    [defaults setBool:style != CSGroupIndicatorStyleNone forKey:CSGroupIndicatorAnimationEnabledKey];
}
