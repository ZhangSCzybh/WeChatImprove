#import "CSInputTextGesturePreferences.h"
#import "CSPreferenceRefresh.h"
#import <math.h>

NSString *const CSInputTextGestureEnabledKey = @"com.wechat.enhance.inputText.gesture.enabled";
NSString *const CSInputTextGestureLeftActionKey = @"com.wechat.enhance.inputText.gesture.leftAction";
NSString *const CSInputTextGestureRightActionKey = @"com.wechat.enhance.inputText.gesture.rightAction";
NSNotificationName const CSInputTextGesturePreferencesDidChangeNotification = @"com.wechat.enhance.inputText.gesture.changed";

static atomic_bool CSInputGestureRefreshPending;

static BOOL CSInputGestureIsActionKey(NSString *key) {
    return [key isEqualToString:CSInputTextGestureLeftActionKey] ||
           [key isEqualToString:CSInputTextGestureRightActionKey];
}

static CSInputTextGestureAction CSInputGestureNormalizeAction(id value) {
    if (![value isKindOfClass:NSNumber.class]) return CSInputTextGestureActionDisabled;
    double number = [value doubleValue];
    if (!isfinite(number) || number != floor(number) ||
        number < CSInputTextGestureActionDisabled || number > CSInputTextGestureActionSend)
        return CSInputTextGestureActionDisabled;
    return (CSInputTextGestureAction)[value integerValue];
}

@implementation CSInputTextGesturePreferences

+ (NSUserDefaults *)cs_defaults {
    return NSUserDefaults.standardUserDefaults;
}

+ (void)cs_storeValue:(NSNumber *)value forKey:(NSString *)key {
    NSUserDefaults *defaults = [self cs_defaults];
    if ([[defaults objectForKey:key] isEqual:value]) return;
    [defaults setObject:value forKey:key];
    CSRequestMainRefresh(&CSInputGestureRefreshPending, ^{
        [NSNotificationCenter.defaultCenter postNotificationName:CSInputTextGesturePreferencesDidChangeNotification object:nil];
    });
}

+ (BOOL)enabled {
    id value = [[self cs_defaults] objectForKey:CSInputTextGestureEnabledKey];
    return [value isKindOfClass:NSNumber.class] ? [value boolValue] : NO;
}

+ (void)setEnabled:(BOOL)enabled {
    [self cs_storeValue:@(enabled) forKey:CSInputTextGestureEnabledKey];
}

+ (CSInputTextGestureAction)actionForKey:(NSString *)key {
    if (!CSInputGestureIsActionKey(key)) return CSInputTextGestureActionDisabled;
    return CSInputGestureNormalizeAction([[self cs_defaults] objectForKey:key]);
}

+ (void)setAction:(CSInputTextGestureAction)action forKey:(NSString *)key {
    if (!CSInputGestureIsActionKey(key)) return;
    [self cs_storeValue:@(CSInputGestureNormalizeAction(@(action))) forKey:key];
}

+ (NSString *)titleForAction:(CSInputTextGestureAction)action {
    switch (action) {
        case CSInputTextGestureActionClear: return @"清空输入框内容";
        case CSInputTextGestureActionCopy: return @"复制输入框内容";
        case CSInputTextGestureActionCut: return @"剪切输入框内容";
        case CSInputTextGestureActionPaste: return @"粘贴";
        case CSInputTextGestureActionSend: return @"发送";
        default: return @"禁用";
    }
}

@end
