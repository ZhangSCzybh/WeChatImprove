#import "CSQuickPanelPreferences.h"
#import "CSPreferenceRefresh.h"
#import "CSQuickPanelBackgroundImageStore.h"
#import "CSBackupMutation.h"
#include <math.h>

NSNotificationName const CSQuickPanelPreferencesDidChangeNotification = @"com.wechat.enhance.quick_panel.changed";
NSString * const CSQuickPanelEnabledKey = @"com.wechat.enhance.quick_panel.enabled";
NSString * const CSQuickPanelTriggerLocationsKey = @"com.wechat.enhance.quick_panel.trigger_locations";
NSString * const CSQuickPanelSelectedActionIdentifiersKey = @"com.wechat.enhance.quick_panel.selected_actions";
NSString * const CSQuickPanelBackgroundStyleKey = @"com.wechat.enhance.quick_panel.background_style";
NSString * const CSQuickPanelBackgroundColorHexKey = @"com.wechat.enhance.quick_panel.background_color_hex";
NSString * const CSQuickPanelBackgroundOpacityKey = @"com.wechat.enhance.quick_panel.background_opacity";
NSString * const CSQuickPanelBackgroundImagePathKey = @"com.wechat.enhance.quick_panel.background_image_path";
NSString * const CSQuickPanelTextColorHexKey = @"com.wechat.enhance.quick_panel.text_color_hex";
NSString * const CSQuickPanelIconColorHexKey = @"com.wechat.enhance.quick_panel.icon_color_hex";
CSQuickPanelBackgroundStyle const CSQuickPanelBackgroundStyleDefault = @"default";
CSQuickPanelBackgroundStyle const CSQuickPanelBackgroundStyleColor = @"color";
CSQuickPanelBackgroundStyle const CSQuickPanelBackgroundStyleImage = @"image";

static atomic_bool CSQuickPanelRefreshPending;

static CSQuickPanelTriggerLocations CSQuickPanelNormalizeLocations(NSUInteger value) {
    CSQuickPanelTriggerLocations locations = value & (CSQuickPanelTriggerHome | CSQuickPanelTriggerChat);
    return locations ?: CSQuickPanelTriggerHome;
}

static NSString *CSQuickPanelNormalizedColorHex(id value) {
    if (![value isKindOfClass:NSString.class] || [value length] != 7 || ![value hasPrefix:@"#"]) return nil;
    NSString *hex = [value substringFromIndex:1];
    if ([hex rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"] invertedSet]].location != NSNotFound) return nil;
    return [value uppercaseString];
}

@implementation CSQuickPanelPreferences

+ (NSUserDefaults *)cs_defaults {
    return NSUserDefaults.standardUserDefaults;
}

+ (Class)cs_backgroundImageStoreClass {
    return CSQuickPanelBackgroundImageStore.class;
}

+ (NSArray<NSString *> *)allActionIdentifiers {
    return @[@"scan", @"wallet", @"moments", @"my_qrcode", @"favorites", @"plugin_home",
             @"profile", @"create_group", @"add_friend", @"emoji_store", @"panel_settings",
             @"payment_code", @"channels", @"file_transfer", @"chat_background"];
}

+ (NSArray<NSString *> *)cs_defaultSelectedActionIdentifiers {
    return @[@"scan", @"wallet", @"moments", @"my_qrcode", @"favorites", @"plugin_home", @"profile", @"panel_settings"];
}

+ (NSArray<NSString *> *)cs_normalizedIdentifiers:(id)value {
    if (![value isKindOfClass:NSArray.class]) return @[];
    NSSet<NSString *> *known = [NSSet setWithArray:self.allActionIdentifiers];
    NSMutableSet<NSString *> *seen = [NSMutableSet set];
    NSMutableArray<NSString *> *result = [NSMutableArray array];
    for (id identifier in (NSArray *)value) {
        if (![identifier isKindOfClass:NSString.class] || ![known containsObject:identifier] || [seen containsObject:identifier]) continue;
        [result addObject:identifier];
        [seen addObject:identifier];
    }
    return result.copy;
}

+ (void)cs_storeValue:(id)value forKey:(NSString *)key {
    NSUserDefaults *defaults = [self cs_defaults];
    id previous = [defaults objectForKey:key];
    if (previous == value || [previous isEqual:value]) return;
    if (value) [defaults setObject:value forKey:key];
    else [defaults removeObjectForKey:key];
    // A setter can be called while a native service owns a lock. Observers
    // always receive one coalesced main-queue refresh after this call returns.
    CSRequestMainRefresh(&CSQuickPanelRefreshPending, ^{
        [NSNotificationCenter.defaultCenter postNotificationName:CSQuickPanelPreferencesDidChangeNotification object:nil];
    });
}

+ (BOOL)enabled {
    id value = [[self cs_defaults] objectForKey:CSQuickPanelEnabledKey];
    return [value isKindOfClass:NSNumber.class] ? [value boolValue] : NO;
}

+ (void)setEnabled:(BOOL)enabled {
    [self cs_storeValue:@(enabled) forKey:CSQuickPanelEnabledKey];
}

+ (CSQuickPanelTriggerLocations)triggerLocations {
    id value = [[self cs_defaults] objectForKey:CSQuickPanelTriggerLocationsKey];
    return CSQuickPanelNormalizeLocations([value isKindOfClass:NSNumber.class] ? [value unsignedIntegerValue] : 0);
}

+ (void)setTriggerLocations:(CSQuickPanelTriggerLocations)locations {
    [self cs_storeValue:@(CSQuickPanelNormalizeLocations(locations)) forKey:CSQuickPanelTriggerLocationsKey];
}

+ (NSArray<NSString *> *)selectedActionIdentifiers {
    id value = [[self cs_defaults] objectForKey:CSQuickPanelSelectedActionIdentifiersKey];
    if (![value isKindOfClass:NSArray.class]) return [self cs_defaultSelectedActionIdentifiers];
    return [self cs_normalizedIdentifiers:value];
}

+ (void)setSelectedActionIdentifiers:(NSArray<NSString *> *)identifiers {
    [self cs_storeValue:[self cs_normalizedIdentifiers:identifiers] forKey:CSQuickPanelSelectedActionIdentifiersKey];
}

+ (NSString *)titleForActionIdentifier:(NSString *)identifier {
    if (![identifier isKindOfClass:NSString.class]) return nil;
    return @{@"scan": @"扫一扫", @"wallet": @"钱包", @"moments": @"朋友圈", @"my_qrcode": @"我的二维码",
             @"favorites": @"收藏", @"plugin_home": @"插件主页", @"profile": @"个人资料", @"create_group": @"发起群聊",
             @"add_friend": @"添加朋友", @"emoji_store": @"表情商店", @"panel_settings": @"面板设置",
             @"payment_code": @"付款码", @"channels": @"视频号", @"file_transfer": @"文件传输助手", @"chat_background": @"聊天背景"}[identifier];
}

+ (NSString *)symbolNameForActionIdentifier:(NSString *)identifier {
    if (![identifier isKindOfClass:NSString.class]) return nil;
    return @{@"scan": @"qrcode.viewfinder", @"wallet": @"wallet.pass.fill", @"moments": @"camera.metering.center.weighted",
             @"my_qrcode": @"qrcode", @"favorites": @"star.fill", @"plugin_home": @"square.grid.2x2.fill",
             @"profile": @"person.crop.circle", @"create_group": @"person.3.fill", @"add_friend": @"person.badge.plus",
             @"emoji_store": @"face.smiling", @"panel_settings": @"slider.horizontal.3",
             @"payment_code": @"barcode.viewfinder", @"channels": @"play.rectangle.fill", @"file_transfer": @"arrow.up.doc.fill", @"chat_background": @"photo.fill"}[identifier];
}

+ (CSQuickPanelBackgroundStyle)backgroundStyle {
    id style = [[self cs_defaults] objectForKey:CSQuickPanelBackgroundStyleKey];
    return [@[CSQuickPanelBackgroundStyleDefault, CSQuickPanelBackgroundStyleColor, CSQuickPanelBackgroundStyleImage] containsObject:style ?: NSNull.null] ? style : CSQuickPanelBackgroundStyleDefault;
}

+ (void)setBackgroundStyle:(CSQuickPanelBackgroundStyle)style {
    if (![@[CSQuickPanelBackgroundStyleDefault, CSQuickPanelBackgroundStyleColor, CSQuickPanelBackgroundStyleImage] containsObject:style ?: NSNull.null]) style = CSQuickPanelBackgroundStyleDefault;
    [self cs_storeValue:style forKey:CSQuickPanelBackgroundStyleKey];
}

+ (NSString *)backgroundColorHex {
    return CSQuickPanelNormalizedColorHex([[self cs_defaults] objectForKey:CSQuickPanelBackgroundColorHexKey]) ?: @"#F2F2F7";
}

+ (void)setBackgroundColorHex:(NSString *)colorHex {
    NSString *normalized = CSQuickPanelNormalizedColorHex(colorHex);
    if (normalized) [self cs_storeValue:normalized forKey:CSQuickPanelBackgroundColorHexKey];
}

+ (double)backgroundOpacity {
    id value = [[self cs_defaults] objectForKey:CSQuickPanelBackgroundOpacityKey];
    double opacity = [value isKindOfClass:NSNumber.class] ? [value doubleValue] : NAN;
    return isfinite(opacity) && opacity >= 0 && opacity <= 1 ? opacity : 1;
}

+ (void)setBackgroundOpacity:(double)opacity {
    [self cs_storeValue:@(isfinite(opacity) ? fmin(1, fmax(0, opacity)) : 1) forKey:CSQuickPanelBackgroundOpacityKey];
}

+ (NSString *)backgroundImagePath {
    id path = [[self cs_defaults] objectForKey:CSQuickPanelBackgroundImagePathKey];
    return [[self cs_backgroundImageStoreClass] isManagedImagePath:path] ? path : nil;
}

+ (void)setBackgroundImagePath:(NSString *)path {
    if (path && ![[self cs_backgroundImageStoreClass] isManagedImagePath:path]) return;
    [self cs_storeValue:path forKey:CSQuickPanelBackgroundImagePathKey];
}

+ (BOOL)resetBackgroundWithError:(NSError **)error {
    if (error) *error = nil;
    CSBackupResourceMutationScope();
    id path = [[self cs_defaults] objectForKey:CSQuickPanelBackgroundImagePathKey];
    // Corrupt or foreign paths may be discarded from defaults, never removed.
    if ([[self cs_backgroundImageStoreClass] isManagedImagePath:path] &&
        ![[self cs_backgroundImageStoreClass] removeImageAtPath:path error:error]) return NO;
    for (NSString *key in @[CSQuickPanelBackgroundStyleKey, CSQuickPanelBackgroundColorHexKey,
                            CSQuickPanelBackgroundOpacityKey, CSQuickPanelBackgroundImagePathKey]) {
        [self cs_storeValue:nil forKey:key];
    }
    return YES;
}

+ (NSString *)textColorHex {
    return CSQuickPanelNormalizedColorHex([[self cs_defaults] objectForKey:CSQuickPanelTextColorHexKey]);
}

+ (void)setTextColorHex:(NSString *)colorHex {
    NSString *normalized = CSQuickPanelNormalizedColorHex(colorHex);
    if (!colorHex || normalized) [self cs_storeValue:normalized forKey:CSQuickPanelTextColorHexKey];
}

+ (NSString *)iconColorHex {
    return CSQuickPanelNormalizedColorHex([[self cs_defaults] objectForKey:CSQuickPanelIconColorHexKey]);
}

+ (void)setIconColorHex:(NSString *)colorHex {
    NSString *normalized = CSQuickPanelNormalizedColorHex(colorHex);
    if (!colorHex || normalized) [self cs_storeValue:normalized forKey:CSQuickPanelIconColorHexKey];
}

+ (void)resetForegroundColors {
    [self cs_storeValue:nil forKey:CSQuickPanelTextColorHexKey];
    [self cs_storeValue:nil forKey:CSQuickPanelIconColorHexKey];
}

@end
