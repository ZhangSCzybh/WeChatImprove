#import "CSSettingsHomeAppearance.h"

NSString *const CSHomeIconBackgroundKey=@"com.wechat.enhance.home.icon_background";
NSString *const CSHomeDisclosureArrowKey=@"com.wechat.enhance.home.disclosure_arrow";
NSNotificationName const CSSettingsHomeAppearanceDidChangeNotification=@"CSSettingsHomeAppearanceDidChangeNotification";

static void CSSetHomeAppearanceValue(NSString *key, BOOL enabled) {
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    if ([defaults boolForKey:key]==enabled) return;
    [defaults setBool:enabled forKey:key];
    [defaults synchronize];
    [NSNotificationCenter.defaultCenter postNotificationName:CSSettingsHomeAppearanceDidChangeNotification object:nil];
}

@implementation CSSettingsHomeAppearance
+ (BOOL)iconBackgroundEnabled {
    return [NSUserDefaults.standardUserDefaults boolForKey:CSHomeIconBackgroundKey];
}
+ (BOOL)disclosureArrowEnabled {
    return [NSUserDefaults.standardUserDefaults boolForKey:CSHomeDisclosureArrowKey];
}
+ (void)setIconBackgroundEnabled:(BOOL)enabled {
    CSSetHomeAppearanceValue(CSHomeIconBackgroundKey,enabled);
}
+ (void)setDisclosureArrowEnabled:(BOOL)enabled {
    CSSetHomeAppearanceValue(CSHomeDisclosureArrowKey,enabled);
}
@end
