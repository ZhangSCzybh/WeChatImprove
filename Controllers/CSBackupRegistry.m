#import "CSBackupRegistry.h"
#import "CSScheduledTaskStore.h"
#import "CSGroupChatStore.h"
#import "CSAutomationStore.h"
#import "CSAIReplyStore.h"
#include <math.h>

static NSString *const CSSelectionPrefix = @"com.wechat.enhance.chat_group.selection.";
static BOOL CSNonemptyString(id value) { return [value isKindOfClass:NSString.class] && [value length]>0 && [value length]<=4096; }
static BOOL CSAccountID(id value) {
    if (!CSNonemptyString(value) || [value length]>128) return NO;
    NSCharacterSet *allowed=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-@"];
    return [value rangeOfCharacterFromSet:allowed.invertedSet].location==NSNotFound;
}
static BOOL CSNumber(id value) { return [value isKindOfClass:NSNumber.class] && isfinite([value doubleValue]); }
static BOOL CSBoolean(id value) { return CSNumber(value) && ([value doubleValue]==0 || [value doubleValue]==1); }
static BOOL CSStrings(id value) {
    if (![value isKindOfClass:NSArray.class] || [value count]>100000) return NO;
    for (id item in value) if (!CSNonemptyString(item)) return NO;
    return YES;
}
static BOOL CSOnlyKeys(NSDictionary *value, NSArray *keys) {
    for (id key in value) if (![key isKindOfClass:NSString.class] || ![keys containsObject:key]) return NO;
    return YES;
}
static BOOL CSProfile(id value) {
    if (![value isKindOfClass:NSDictionary.class]) return NO;
    NSDictionary *p=value;
    if (!CSOnlyKeys(p,@[@"version",@"customTabs",@"presetNames",@"tabOrder",@"hiddenPresetTabs",@"selectedTabID",@"filterDuplicates",@"legacyImported"]) || !CSNumber(p[@"version"]) || ![p[@"version"] isEqual:@1] || ![p[@"customTabs"] isKindOfClass:NSArray.class] || [p[@"customTabs"] count]>10000 || ![p[@"presetNames"] isKindOfClass:NSDictionary.class] || !CSStrings(p[@"tabOrder"]) || !CSStrings(p[@"hiddenPresetTabs"]) || !CSNonemptyString(p[@"selectedTabID"]) || !CSBoolean(p[@"filterDuplicates"]) || !CSBoolean(p[@"legacyImported"])) return NO;
    NSArray *presets=@[@"preset_0",@"preset_1",@"preset_2",@"preset_3"];
    NSMutableSet *ids=[NSMutableSet setWithArray:presets];
    for (id raw in p[@"customTabs"]) {
        if (![raw isKindOfClass:NSDictionary.class]) return NO;
        NSDictionary *r=raw;
        if (!CSOnlyKeys(r,@[@"id",@"name",@"members",@"created",@"updated"]) || !CSNonemptyString(r[@"id"]) || [r[@"id"] hasPrefix:@"preset_"] || [ids containsObject:r[@"id"]] || !CSNonemptyString(r[@"name"]) || !CSStrings(r[@"members"])) return NO;
        for (NSString *date in @[@"created",@"updated"]) if (r[date] && (![r[date] isKindOfClass:NSDate.class] || !isfinite([r[date] timeIntervalSince1970]))) return NO;
        [ids addObject:r[@"id"]];
    }
    for (id key in p[@"presetNames"]) if (![presets containsObject:key] || !CSNonemptyString(p[@"presetNames"][key])) return NO;
    for (id key in p[@"hiddenPresetTabs"]) if (![presets containsObject:key]) return NO;
    NSMutableSet *order=[NSMutableSet new];
    for (id key in p[@"tabOrder"]) { if (![ids containsObject:key] || [order containsObject:key]) return NO; [order addObject:key]; }
    return [ids containsObject:p[@"selectedTabID"]];
}
static BOOL CSContacts(id value) {
    if (![value isKindOfClass:NSDictionary.class] || [value count]>100000) return NO;
    for (id contact in value) {
        id raw=value[contact];
        if (!CSNonemptyString(contact) || ![raw isKindOfClass:NSDictionary.class]) return NO;
        NSDictionary *config=raw;
        if (!CSOnlyKeys(config,@[@"separatorText",@"separatorImagePath",@"separatorSize",@"avatarSpacing",@"verticalOffset",@"enabled"]) || !CSBoolean(config[@"enabled"])) return NO;
        for (NSString *key in @[@"separatorText",@"separatorImagePath"]) if (config[key] && ![config[key] isKindOfClass:NSString.class]) return NO;
        for (NSString *key in @[@"separatorSize",@"avatarSpacing",@"verticalOffset"]) if (config[key] && !CSNumber(config[key])) return NO;
    }
    return YES;
}

@implementation CSBackupRegistry
+ (NSArray<NSDictionary *> *)entries {
    static NSArray *entries; static dispatch_once_t once;
    dispatch_once(&once, ^{
        // Every row is an exact domain/key identity. Do not replace this with prefix matching.
        NSArray *rows=@[
            @[@"standard",@"com.wechat.enhance.home_theme.index",@"home_theme",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.home_theme.custom_rgb",@"home_theme",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.moments_layout.enabled",@"moments_layout",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.ad_purification.enabled",@"ad_purification",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.ad_purification.articles",@"ad_purification",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.ad_purification.subscriptions",@"ad_purification",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.ad_purification.moments",@"ad_purification",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.ad_purification.finder",@"ad_purification",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.ad_purification.mini_programs",@"ad_purification",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.ad_purification.search",@"ad_purification",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.ad_purification.recommendations",@"ad_purification",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.enabled",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.scoped_queries",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.environment",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.frameworks",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.provision_path",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.provision_read",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.bundle_info",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.receipt",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.crash_block",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.crash_monitor",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.vendor_id",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.checks",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.images",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.safe_mode",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.friend_scope",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.device_checks",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.device_report",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.fingerprint_data",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.basic_data",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.risk_results",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.policy_completion",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.cc_data",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.device_reports",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.safety_reports",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.behavior_reports",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.detection_results",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.detection_reports",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.experiment_reports",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.tls_trust",@"client_guard",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.client_guard.tls_pinning",@"client_guard",@"bool",@"global",@""],
            // Preserve the legacy backup value without treating it as the new check cadence.
            @[@"legacy",@"BackgroundInterval",@"background",@"number",@"global",@""],
            @[@"legacy",@"BackgroundRunEnabled",@"background",@"bool",@"global",@""],
            @[@"legacy",@"BackgroundRunCheckInterval",@"background",@"number",@"global",@""],
            @[@"standard",@"GameCheat_Enabled",@"games",@"bool",@"global",@""],
            @[@"standard",@"WCTimeLineMessageTailEnabled",@"timeline",@"bool",@"global",@""],
            @[@"standard",@"WCTimeLineMessageTailText",@"timeline",@"string",@"global",@""],
            @[@"legacy",@"avatarCornerRadius",@"avatar",@"number",@"global",@""],
            // Inert compatibility field: old snapshots and pending journal revisions include it.
            // No runtime consumer or automatic backup scheduler remains.
            @[@"standard",@"com.wechat.enhance.backup.auto_enabled",@"backup",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.corner_radius",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.enabled",@"bubble",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.kind",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_dark_color.alpha",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_dark_color.blue",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_dark_color.green",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_dark_color.red",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_dark_text_color.blue",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_dark_text_color.green",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_dark_text_color.red",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_light_color.alpha",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_light_color.blue",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_light_color.green",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_light_color.red",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_light_text_color.blue",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_light_text_color.green",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.receiver_light_text_color.red",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_dark_color.alpha",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_dark_color.blue",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_dark_color.green",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_dark_color.red",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_dark_text_color.blue",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_dark_text_color.green",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_dark_text_color.red",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_light_color.alpha",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_light_color.blue",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_light_color.green",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_light_color.red",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_light_text_color.blue",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_light_text_color.green",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.bubble_style.sender_light_text_color.red",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.account_profiles",@"groups",@"dictionary",@"account",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.enabled",@"groups",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.haptic_feedback",@"groups",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.hide_all_badge",@"groups",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.hide_group_badge",@"groups",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.indicator_animation_enabled",@"groups",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.indicator_color",@"groups",@"data",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.indicator_color_dark",@"groups",@"data",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.selected_text_color",@"groups",@"data",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.selected_text_color_dark",@"groups",@"data",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.selection_indicator_style",@"groups",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.show_search_button",@"groups",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.swipe_gesture_enabled",@"groups",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.chat_group.tab_font_size",@"groups",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.consecutive_messages.spacing",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.alpha",@"input",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.bold",@"input",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.border.color",@"input",@"data",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.border.enabled",@"input",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.border.width",@"input",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.color",@"input",@"data",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.content",@"input",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.cornerRadius",@"input",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.enabled",@"input",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.fontSize",@"input",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.inputText.roundedCorners",@"input",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.left_swipe_other.action",@"message_actions",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.left_swipe_self.action",@"message_actions",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.dark_bg_color.alpha",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.dark_bg_color.blue",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.dark_bg_color.green",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.dark_bg_color.red",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.enabled",@"list",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.left_margin",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.light_bg_color.alpha",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.light_bg_color.blue",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.light_bg_color.green",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.light_bg_color.red",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.alpha",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.blue",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.green",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.red",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.alpha",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.blue",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.green",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.red",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.radius",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.right_margin",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.alpha",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.blue",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.green",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.red",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.alpha",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.blue",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.green",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.red",@"list",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.merge_messages.avatar_position",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.merge_messages.enabled",@"bubble",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.merge_messages.scope",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.merge_messages.spacing_mode",@"bubble",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.backgroundColor",@"message_time",@"data",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.boldFont",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.cornerRadius",@"message_time",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.enabled",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.fontSize",@"message_time",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.showBelowAvatar",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.showDay",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.showHour",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.showMinute",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.showMonth",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.showSecond",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.showYear",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.singleLine",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.tapToShow",@"message_time",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.messageTime.textColor",@"message_time",@"data",@"global",@""],
            @[@"standard",@"com.wechat.enhance.message_gesture.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.allowedGroups",@"red_envelopes",@"array",@"relationship",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.autoReceive",@"red_envelopes",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.autoReplyEnable",@"red_envelopes",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.blockedGroups",@"red_envelopes",@"array",@"relationship",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.delay",@"red_envelopes",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.groupEnable",@"red_envelopes",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.groupReply",@"red_envelopes",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.groupScope",@"red_envelopes",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.notifyTarget",@"red_envelopes",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.pageSummary",@"red_envelopes",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.privateEnable",@"red_envelopes",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.privateReply",@"red_envelopes",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.receiveSelf",@"red_envelopes",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.redenvelop.serialReceive",@"red_envelopes",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.repeat.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.revoke.enabled",@"revoke",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.right_swipe_other.action",@"message_actions",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.right_swipe_self.action",@"message_actions",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.scroll_sensitivity",@"groups",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.quick_panel.enabled",@"quick_panel",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.quick_panel.trigger_locations",@"quick_panel",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.quick_panel.selected_actions",@"quick_panel",@"array",@"global",@""],
            @[@"standard",@"com.wechat.enhance.quick_panel.background_style",@"quick_panel",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.quick_panel.background_color_hex",@"quick_panel",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.quick_panel.background_opacity",@"quick_panel",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.quick_panel.background_image_path",@"quick_panel",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.quick_panel.text_color_hex",@"quick_panel",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.quick_panel.icon_color_hex",@"quick_panel",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.bg_color.alpha",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.bg_color.blue",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.bg_color.green",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.bg_color.red",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.border_animation",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.border_color.alpha",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.border_color.blue",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.border_color.green",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.border_color.red",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.border_style",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.border_width",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.click_effect",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.content_height",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.corner_radius",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.enabled",@"tabbar",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.haptic_feedback",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.hide_text",@"tabbar",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.icon.chat",@"tabbar",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.tabbar_style.icon.contacts",@"tabbar",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.tabbar_style.icon.discover",@"tabbar",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.tabbar_style.icon.me",@"tabbar",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.tabbar_style.icon.selected.chat",@"tabbar",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.tabbar_style.icon.selected.contacts",@"tabbar",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.tabbar_style.icon.selected.discover",@"tabbar",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.tabbar_style.icon.selected.me",@"tabbar",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.enhance.tabbar_style.position_offset",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.scale",@"tabbar",@"number",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.text.chat",@"tabbar",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.text.contacts",@"tabbar",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.text.discover",@"tabbar",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.tabbar_style.text.me",@"tabbar",@"string",@"global",@""],
            @[@"standard",@"com.wechat.enhance.voice_forward.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.voice_forward.favorite_enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.voice_playback.progress_enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.image_sticker.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.clown.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.clown.text.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.clown.time.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.clown.image.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.clown.amount.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.clown.warmth.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.clown.fake_quote.enabled",@"message_actions",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.enhance.clown.warmth.targets",@"message_actions",@"dictionary",@"relationship",@""],
            @[@"legacy",@"com.wechat.tweak.background.blur.enabled",@"background",@"bool",@"global",@""],
            @[@"legacy",@"com.wechat.tweak.biometric.auth.favorite",@"privacy",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.columns",@"attachments",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.group.hidden.buttons",@"attachments",@"array",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.group.sort.enabled",@"attachments",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.group.sort.order",@"attachments",@"array",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.layout.enabled",@"attachments",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.official.hidden.buttons",@"attachments",@"array",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.official.sort.enabled",@"attachments",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.official.sort.order",@"attachments",@"array",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.private.hidden.buttons",@"attachments",@"array",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.private.sort.enabled",@"attachments",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.private.sort.order",@"attachments",@"array",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.show.in.group",@"attachments",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.show.in.official",@"attachments",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.show.in.private",@"attachments",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.chat.attachment.spacing",@"attachments",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.contacts_replacement",@"custom_text",@"string",@"global",@""],
            @[@"standard",@"com.wechat.tweak.custom_menu_names",@"custom_text",@"dictionary",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.allUpdateFunctions",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.forceUpdate",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.immediateRenameUpdate",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.loadAndExecute",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.loadBundle",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.loadMainUpdateBundle",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.loadPluginInBundle",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.loadResource",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.onPResUpdateFinish",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.registerUpdate",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.shouldTrace",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.tryRegisterUpdate",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.tryRenameTmpUpdateDataDir",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.unzipBundleUpdates",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.disable.unzipDownloadUpdates",@"updates",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.discover_replacement",@"custom_text",@"string",@"global",@""],
            @[@"standard",@"com.wechat.tweak.entry.custom.title",@"entry",@"string",@"global",@""],
            @[@"standard",@"com.wechat.tweak.entry.display.mode",@"entry",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.entry.show.in.more",@"entry",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.entry.show.in.plugin",@"entry",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.entry.show.in.setting",@"entry",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.friends_count_replacement",@"custom_text",@"string",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_channels_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_chat_time_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_channels",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_game",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_listen",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_live",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_look",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_miniprogram",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_nearby",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_scan",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_discover_search",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_favorite_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_moments_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_pat_message_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_qrcode_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_revoke_message_enabled",@"revoke",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_service_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_about",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_account_security",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_call",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_chat",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_chat_history",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_display",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_friend_permission",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_help",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_logout",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_more",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_notification",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_other",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_plugin",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_privacy",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_profile",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_storage",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_setting_switch_account",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_settings_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_sticker_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_voice_hint_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_wallet_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.hide_works_enabled",@"ui",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.main_title_replacement",@"custom_text",@"string",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.avatar.mode",@"navigation",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.avatar.radius",@"navigation",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.avatar.size",@"navigation",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.avatar.spacing",@"navigation",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.contact.overrides",@"navigation",@"dictionary",@"relationship",@"contacts"],
            @[@"standard",@"com.wechat.tweak.navigation.nickname.position",@"navigation",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.nickname.size",@"navigation",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.separator.image",@"navigation",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.tweak.navigation.separator.size",@"navigation",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.separator.text",@"navigation",@"string",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.avatar",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.in.group",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.in.official",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.in.private",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.other",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.other.nickname",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.popover.when.tap.avatar",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.remark.name",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.show.self",@"navigation",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.navigation.vertical.offset",@"navigation",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.simple_ui_enabled",@"custom_text",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.border.color.alpha",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.border.color.blue",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.border.color.green",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.border.color.red",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.border.enabled",@"touch",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.border.width",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.color.alpha",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.color.blue",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.color.green",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.color.red",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.custom.image.corner.radius",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.custom.image.enabled",@"touch",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.custom.image.path",@"touch",@"string",@"global",@"file"],
            @[@"standard",@"com.wechat.tweak.touch.trail.display.state",@"touch",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.enabled",@"touch",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.only.when.recording",@"touch",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.size",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.tail.density",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.tail.duration",@"touch",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.touch.trail.tail.enabled",@"touch",@"bool",@"global",@""],
            @[@"standard",@"com.wechat.tweak.version.custom",@"version",@"string",@"global",@""],
            @[@"standard",@"com.wechat.tweak.version.selected",@"version",@"number",@"global",@""],
            @[@"standard",@"com.wechat.tweak.wallet_balance_replacement",@"custom_text",@"string",@"global",@""],
            @[@"layout",@"font.chat_size",@"layout",@"number",@"global",@""],
            @[@"layout",@"global.scale",@"layout",@"number",@"global",@""],
            @[@"legacy",@"hideBothAvatarInGroupChat",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"hideBothAvatarInOfficialAccount",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"hideBothAvatarInPrivateChat",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"hideOtherAvatarInGroupChat",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"hideOtherAvatarInOfficialAccount",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"hideOtherAvatarInPrivateChat",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"hideSelfAvatarInGroupChat",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"hideSelfAvatarInOfficialAccount",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"hideSelfAvatarInPrivateChat",@"avatar",@"bool",@"global",@""],
            @[@"standard",@"kReceiveTransferAutoEnableKey",@"transfers",@"bool",@"global",@""],
            @[@"standard",@"kReceiveTransferAutoReplyEnableKey",@"transfers",@"bool",@"global",@""],
            @[@"standard",@"kReceiveTransferDelayKey",@"transfers",@"number",@"global",@""],
            @[@"standard",@"kReceiveTransferGroupAutoReplyKey",@"transfers",@"string",@"global",@""],
            @[@"standard",@"kReceiveTransferGroupEnableKey",@"transfers",@"bool",@"global",@""],
            @[@"standard",@"kReceiveTransferNotifyTargetKey",@"transfers",@"number",@"global",@""],
            @[@"standard",@"kReceiveTransferPrivateAutoReplyKey",@"transfers",@"string",@"global",@""],
            @[@"standard",@"kReceiveTransferPrivateEnableKey",@"transfers",@"bool",@"global",@""],
            @[@"legacy",@"rotateAvatar",@"avatar",@"bool",@"global",@""],
            @[@"legacy",@"rotateSpeed",@"avatar",@"number",@"global",@""],
            @[@"legacy",@"roundAvatar",@"avatar",@"bool",@"global",@""],
        ];
        NSMutableArray *result=[NSMutableArray new];
        for (NSArray *row in rows) {
            NSMutableDictionary *entry=[@{@"domain":row[0],@"key":row[1],@"module":row[2],@"type":row[3],@"scope":row[4]} mutableCopy];
            if ([row[5] length]) entry[@"resource"]=row[5];
            [result addObject:[entry copy]];
        }
        entries=[result copy];
    });
    return entries;
}
+ (NSDictionary<NSString *,NSString *> *)moduleTitles {
    return @{@"home_theme":@"首页调色",@"avatar":@"头像",@"background":@"后台与隐私模糊",@"privacy":@"收藏保护",@"layout":@"布局与字体",@"bubble":@"气泡与连续消息",@"groups":@"会话分组",@"list":@"列表圆角",@"input":@"输入文本",@"message_time":@"消息时间",@"red_envelopes":@"红包设置",@"tabbar":@"底栏样式",@"attachments":@"附件布局",@"updates":@"更新控制",@"entry":@"插件入口",@"ui":@"界面精简",@"navigation":@"聊天导航",@"touch":@"触摸轨迹",@"version":@"版本设置",@"backup":@"备份设置",@"revoke":@"防撤回",@"message_actions":@"消息操作",@"transfers":@"转账设置",@"timeline":@"朋友圈尾巴",@"games":@"游戏设置",@"custom_text":@"界面文字",@"scheduled_tasks":@"定时任务",@"ai_reply":@"AI 自动回复",@"group_chat_tools":@"群聊功能",@"automation":@"自动功能",@"client_guard":@"反检测",@"ad_purification":@"广告净化",@"moments_layout":@"朋友圈布局",@"quick_panel":@"快捷面板"};
}
+ (NSDictionary *)entryForDomain:(NSString *)domain key:(NSString *)key {
    if (![domain isKindOfClass:NSString.class] || ![key isKindOfClass:NSString.class]) return nil;
    for (NSDictionary *entry in self.entries) if ([entry[@"domain"] isEqual:domain] && [entry[@"key"] isEqual:key]) return entry;
    if ([domain isEqual:CSAIReplyBackupDomain] && CSAccountID(key))
        return @{@"domain":CSAIReplyBackupDomain,@"key":key,@"module":@"ai_reply",@"type":@"dictionary",@"scope":@"account"};
    if ([domain isEqual:CSScheduledTaskBackupDomain] && CSAccountID(key))
        return @{@"domain":CSScheduledTaskBackupDomain,@"key":key,@"module":@"scheduled_tasks",@"type":@"dictionary",@"scope":@"account"};
    if ([domain isEqual:CSGroupChatBackupDomain] && CSAccountID(key))
        return @{@"domain":CSGroupChatBackupDomain,@"key":key,@"module":@"group_chat_tools",@"type":@"dictionary",@"scope":@"account"};
    if ([domain isEqual:CSAutomationBackupDomain] && CSAccountID(key))
        return @{@"domain":CSAutomationBackupDomain,@"key":key,@"module":@"automation",@"type":@"dictionary",@"scope":@"account"};
    if ([domain isEqual:@"standard"] && [key hasPrefix:CSSelectionPrefix] && CSAccountID([key substringFromIndex:CSSelectionPrefix.length]))
        return @{@"domain":@"standard",@"key":key,@"module":@"groups",@"type":@"dictionary",@"scope":@"account"};
    return nil;
}
+ (BOOL)validateValue:(id)value entry:(NSDictionary *)entry error:(NSError **)error {
    if (error) *error=nil;
    NSDictionary *metadata=[entry isKindOfClass:NSDictionary.class] ? entry : @{};
    NSDictionary *registered=[self entryForDomain:metadata[@"domain"] key:metadata[@"key"]];
    BOOL valid=registered && [registered isEqual:entry];
    NSString *type=registered[@"type"], *key=registered[@"key"];
    if (valid) {
        if ([type isEqual:@"bool"]) valid=CSBoolean(value);
        else if ([type isEqual:@"number"]) {
            valid=CSNumber(value);
            if (valid && [key isEqual:@"com.wechat.enhance.home_theme.index"]) valid=[value doubleValue]>=0 && [value doubleValue]<=4 && floor([value doubleValue])==[value doubleValue];
            if (valid && [key isEqual:@"com.wechat.enhance.home_theme.custom_rgb"]) valid=[value doubleValue]>=0 && [value doubleValue]<=0xffffff && floor([value doubleValue])==[value doubleValue];
            if (valid && [key isEqual:@"com.wechat.enhance.quick_panel.trigger_locations"]) valid=[value doubleValue]>=1 && [value doubleValue]<=3 && floor([value doubleValue])==[value doubleValue];
            if (valid && [key isEqual:@"com.wechat.enhance.quick_panel.background_opacity"]) valid=[value doubleValue]>=0 && [value doubleValue]<=1;
            if (valid && [registered[@"domain"] isEqual:@"legacy"] && [key isEqual:@"BackgroundRunCheckInterval"])
                valid=[value doubleValue]>=10 && [value doubleValue]<=30 && floor([value doubleValue])==[value doubleValue];
        }
        else if ([type isEqual:@"string"]) {
            valid=[value isKindOfClass:NSString.class] && [value length]<=1048576;
            if (valid && [key isEqual:@"com.wechat.enhance.quick_panel.background_style"]) valid=[@[@"default",@"color",@"image"] containsObject:value];
            if (valid && ([@[@"com.wechat.enhance.quick_panel.background_color_hex",@"com.wechat.enhance.quick_panel.text_color_hex",@"com.wechat.enhance.quick_panel.icon_color_hex"] containsObject:key])) {
                valid=[value length]==7 && [value hasPrefix:@"#"];
                if(valid)valid=[[value substringFromIndex:1] rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEF"] invertedSet]].location==NSNotFound;
            }
        }
        // Existing UIColor archives are opaque data: never instantiate archive classes from a backup.
        else if ([type isEqual:@"data"]) valid=[value isKindOfClass:NSData.class] && [value length]>0 && [value length]<=1048576;
        else if ([type isEqual:@"array"]) {
            if ([key containsString:@"chat.attachment."]) {
                valid=[value isKindOfClass:NSArray.class] && [value count]<=1000;
                if (valid) for (id item in value) if (!CSNumber(item) || floor([item doubleValue])!=[item doubleValue]) { valid=NO; break; }
            } else if ([key isEqual:@"com.wechat.enhance.quick_panel.selected_actions"]) {
                // This backup schema stays independent of the UIKit quick-panel implementation.
                NSSet *known=[NSSet setWithArray:@[@"scan",@"wallet",@"moments",@"my_qrcode",@"favorites",@"plugin_home",@"profile",@"create_group",@"add_friend",@"emoji_store",@"panel_settings",@"payment_code",@"channels",@"file_transfer",@"chat_background",@"receive_code",@"my_moments",@"create_note",@"switch_account"]];
                valid=[value isKindOfClass:NSArray.class] && [value count]<=known.count;
                NSMutableSet *seen=[NSMutableSet new];
                if (valid) for (id identifier in value) {
                    if (![identifier isKindOfClass:NSString.class] || ![known containsObject:identifier] || [seen containsObject:identifier]) { valid=NO; break; }
                    [seen addObject:identifier];
                }
            } else valid=CSStrings(value);
        } else if ([type isEqual:@"dictionary"]) {
            if ([key isEqual:@"com.wechat.enhance.clown.warmth.targets"]) {
                valid = [value isKindOfClass:NSDictionary.class] && [value count] <= 10000;
                if (valid) for (id account in value) {
                    id profile = value[account];
                    if (!CSAccountID(account) || ![profile isKindOfClass:NSDictionary.class] ||
                        !CSOnlyKeys(profile, @[@"contacts", @"groups"])) { valid = NO; break; }
                    for (NSString *kind in @[@"contacts", @"groups"]) {
                        id names = profile[kind]; if (!names) continue;
                        if (!CSStrings(names)) { valid = NO; break; }
                        for (NSString *name in names) if (!CSAccountID(name) || [name hasSuffix:@"@chatroom"] != [kind isEqual:@"groups"]) { valid = NO; break; }
                    }
                    if (!valid) break;
                }
            } else if ([registered[@"domain"] isEqual:CSScheduledTaskBackupDomain]) {
                valid=CSScheduledTaskBackupValueValidate(value,key,error);
            } else if ([registered[@"domain"] isEqual:CSAIReplyBackupDomain]) {
                valid=CSAIReplyValidateState(value,key,error);
            } else if ([registered[@"domain"] isEqual:CSGroupChatBackupDomain]) {
                valid=CSGroupChatValidateState(value,key,error);
            } else if ([registered[@"domain"] isEqual:CSAutomationBackupDomain]) {
                valid=CSAutomationValidateState(value,key,error);
            } else if ([key hasSuffix:@"account_profiles"]) {
                valid=[value isKindOfClass:NSDictionary.class] && [value count]<=10000;
                if (valid) for (id account in value) if (!CSAccountID(account) || !CSProfile(value[account])) { valid=NO; break; }
            } else if ([key hasPrefix:CSSelectionPrefix]) {
                valid=[value isKindOfClass:NSDictionary.class] && CSOnlyKeys(value,@[@"version",@"tabID"]) && CSNumber(value[@"version"]) && [value[@"version"] isEqual:@1] && CSNonemptyString(value[@"tabID"]);
            } else if ([key hasSuffix:@"contact.overrides"]) valid=CSContacts(value);
            else {
                valid=[value isKindOfClass:NSDictionary.class] && [value count]<=1000;
                if (valid) for (id name in value) if (!CSNonemptyString(name) || ![value[name] isKindOfClass:NSString.class]) { valid=NO; break; }
            }
        } else valid=NO;
    }
    // Dates are allowed within account profiles, as written by CSGroupPreferences.
    if (valid) valid=[NSPropertyListSerialization propertyList:value isValidForFormat:NSPropertyListBinaryFormat_v1_0];
    if (!valid && error) *error=[NSError errorWithDomain:@"CSBackupRegistry" code:1 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Invalid or unregistered configuration value: %@/%@",metadata[@"domain"] ?: @"?",metadata[@"key"] ?: @"?"]}];
    return valid;
}
@end
