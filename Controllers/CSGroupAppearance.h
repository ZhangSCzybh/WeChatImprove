#import <Foundation/Foundation.h>
#import <math.h>

// Appearance preferences follow the existing global group colors and haptics.
static NSString *const CSGroupTabFontSizeKey = @"com.wechat.enhance.chat_group.tab_font_size";
static NSString *const CSGroupSearchButtonVisibleKey = @"com.wechat.enhance.chat_group.show_search_button";
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
