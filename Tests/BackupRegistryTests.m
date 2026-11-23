#import <Foundation/Foundation.h>
#import "CSBackupRegistry.h"
#include <math.h>
static NSUInteger assertions;
#define CHECK(condition) do { assertions++; if (!(condition)) { NSLog(@"FAIL line %d: %s", __LINE__, #condition); exit(1); } } while (0)
static NSDictionary *Entry(NSString *key) { return [CSBackupRegistry entryForDomain:@"standard" key:key]; }
static BOOL Valid(id value, NSDictionary *entry) { NSError *error=nil; BOOL ok=[CSBackupRegistry validateValue:value entry:entry error:&error]; CHECK(ok || error != nil); return ok; }
int main(void) { @autoreleasepool {
    CHECK([CSBackupRegistry entryForDomain:@"legacy" key:@"roundAvatar"] != nil);
    CHECK([CSBackupRegistry entryForDomain:@"standard" key:@"roundAvatar"] == nil);
    CHECK([CSBackupRegistry entryForDomain:@"layout" key:@"font.chat_size"] != nil);
    CHECK([CSBackupRegistry entryForDomain:@"com.wechat.enhance" key:@"font.chat_size"] == nil);
    CHECK(Entry(@"GameCheat_Enabled") != nil);
    CHECK(Entry(@"WCTimeLineMessageTailText") != nil);
    CHECK(Entry(@"kReceiveTransferAutoEnableKey") != nil);
    NSDictionary *homeIndex=Entry(@"com.wechat.enhance.home_theme.index"),*homeRGB=Entry(@"com.wechat.enhance.home_theme.custom_rgb");
    CHECK([homeIndex[@"module"] isEqual:@"home_theme"] && [homeIndex[@"scope"] isEqual:@"global"]);
    CHECK([CSBackupRegistry.moduleTitles[@"home_theme"] isEqual:@"首页调色"]);
    CHECK(Valid(@0,homeIndex) && Valid(@4,homeIndex));
    CHECK(!Valid(@(-1),homeIndex) && !Valid(@5,homeIndex) && !Valid(@0.5,homeIndex) && !Valid(@"1",homeIndex));
    CHECK(Valid(@0,homeRGB) && Valid(@0xffffff,homeRGB));
    CHECK(!Valid(@(-1),homeRGB) && !Valid(@0x1000000,homeRGB) && !Valid(@1.5,homeRGB) && !Valid(@"ffffff",homeRGB));
    NSDictionary *momentsLayout=Entry(@"com.wechat.enhance.moments_layout.enabled");
    CHECK([momentsLayout[@"module"] isEqual:@"moments_layout"] && [momentsLayout[@"scope"] isEqual:@"global"] && [momentsLayout[@"type"] isEqual:@"bool"]);
    CHECK([CSBackupRegistry.moduleTitles[@"moments_layout"] isEqual:@"朋友圈布局"]);
    CHECK(Valid(@YES,momentsLayout) && Valid(@NO,momentsLayout));
    CHECK(!Valid(@"YES",momentsLayout) && !Valid(@2,momentsLayout));
    CHECK([CSBackupRegistry entryForDomain:@"legacy" key:@"com.wechat.enhance.moments_layout.enabled"] == nil);
    CHECK(Entry(@"com.wechat.enhance.moments_layout.unknown") == nil);
    NSArray *guardIdentifiers=@[@"enabled",@"scoped_queries",@"environment",@"frameworks",@"provision_path",
        @"provision_read",@"bundle_info",@"receipt",@"crash_block",@"crash_monitor",@"vendor_id",@"checks",@"images",@"safe_mode",
        @"friend_scope",@"device_checks",@"device_report",@"fingerprint_data",@"basic_data",@"risk_results",@"policy_completion",
        @"cc_data",@"device_reports",@"safety_reports",@"behavior_reports",@"detection_results",@"detection_reports",
        @"experiment_reports",@"tls_trust",@"tls_pinning"];
    CHECK(guardIdentifiers.count==30);
    NSUInteger guardFields=0;
    for(NSDictionary *entry in CSBackupRegistry.entries)if([entry[@"module"] isEqual:@"client_guard"])guardFields++;
    CHECK(guardFields==guardIdentifiers.count);
    CHECK([CSBackupRegistry.moduleTitles[@"client_guard"] isEqual:@"反检测"]);
    for(NSString *identifier in guardIdentifiers){
        NSString *key=[@"com.wechat.enhance.client_guard." stringByAppendingString:identifier];
        NSDictionary *entry=Entry(key);
        CHECK([entry[@"module"] isEqual:@"client_guard"] && [entry[@"scope"] isEqual:@"global"] && [entry[@"type"] isEqual:@"bool"]);
        CHECK(Valid(@YES,entry) && Valid(@NO,entry));
        CHECK(!Valid(@"YES",entry) && !Valid(@2,entry));
        CHECK([CSBackupRegistry entryForDomain:@"legacy" key:key]==nil);
    }
    // Only user choices travel in a backup; device-local identifiers and observations do not.
    for(NSString *identifier in @[@"vendor_uuid",@"local_vendor_uuid",@"image_names",@"diagnostics",@"disabled",@"unknown"])
        CHECK(Entry([@"com.wechat.enhance.client_guard." stringByAppendingString:identifier])==nil);
    NSDictionary *favoriteVoice=Entry(@"com.wechat.enhance.voice_forward.favorite_enabled");
    CHECK([favoriteVoice[@"module"] isEqual:@"message_actions"] && [favoriteVoice[@"scope"] isEqual:@"global"] && [favoriteVoice[@"type"] isEqual:@"bool"]);
    CHECK(Valid(@YES,favoriteVoice) && Valid(@NO,favoriteVoice));
    CHECK(!Valid(@"YES",favoriteVoice) && !Valid(@2,favoriteVoice));
    CHECK([CSBackupRegistry entryForDomain:@"legacy" key:@"com.wechat.enhance.voice_forward.favorite_enabled"]==nil);
    for (NSString *key in @[@"com.wechat.enhance.voice_playback.progress_enabled"]) {
        NSDictionary *playback=Entry(key);
        CHECK([playback[@"module"] isEqual:@"message_actions"] && [playback[@"scope"] isEqual:@"global"] && [playback[@"type"] isEqual:@"bool"]);
        CHECK(Valid(@YES,playback) && Valid(@NO,playback));
        CHECK(!Valid(@"YES",playback) && !Valid(@2,playback));
        CHECK([CSBackupRegistry entryForDomain:@"legacy" key:key]==nil);
    }
    for (NSString *key in @[@"com.wechat.enhance.unknown", @"AppleLanguages", @"CSAuthorizationStatus", @"CSLastAuthorizationCheckTime", @"com.wechat.enhance.redenvelop.totalCount", @"com.wechat.enhance.redenvelop.totalAmount", @"kReceiveTransferTotalCountKey", @"kReceiveTransferTotalAmountKey", @"com.wechat.enhance.chat_group.profile_backups", @"com.wechat.enhance.chat_group.legacy_backup"]) CHECK(Entry(key)==nil);
    NSString *prefix=@"com.wechat.enhance.chat_group.selection.";
    CHECK(Entry([prefix stringByAppendingString:@"wxid_abc-123"]) != nil);
    for (NSString *suffix in @[@"",@"../x",@"a/b",@"a.b",@"a b",@"<account>"]) CHECK(Entry([prefix stringByAppendingString:suffix])==nil);
    CHECK(Valid(@YES,Entry(@"GameCheat_Enabled")));
    CHECK(!Valid(@"YES",Entry(@"GameCheat_Enabled")));
    CHECK(!Valid(@2,Entry(@"GameCheat_Enabled")));
    CHECK(Valid(@0,Entry(@"GameCheat_Enabled")));
    CHECK(Valid(@1,Entry(@"GameCheat_Enabled")));
    CHECK(!Valid(@(NAN),[CSBackupRegistry entryForDomain:@"layout" key:@"font.chat_size"]));
    CHECK(!Valid(@"17",[CSBackupRegistry entryForDomain:@"layout" key:@"font.chat_size"]));
    CHECK(Valid(@[@"room@chatroom"],Entry(@"com.wechat.enhance.redenvelop.allowedGroups")));
    CHECK(!Valid(@[@12],Entry(@"com.wechat.enhance.redenvelop.allowedGroups")));
    CHECK([Entry(@"com.wechat.enhance.redenvelop.allowedGroups")[@"scope"] isEqual:@"relationship"]);
    CHECK(Entry(@"com.wechat.enhance.redenvelop.allowedGroups")[@"resource"]==nil);
    CHECK(Entry(@"com.wechat.enhance.redenvelop.blockedGroups")[@"resource"]==nil);
    CHECK([Entry(@"com.wechat.tweak.navigation.contact.overrides")[@"resource"] isEqual:@"contacts"]);
    CHECK([Entry(@"com.wechat.tweak.navigation.separator.image")[@"resource"] isEqual:@"file"]);
    CHECK([Entry(@"com.wechat.enhance.tabbar_style.icon.selected.chat")[@"resource"] isEqual:@"file"]);
    NSDictionary *clickEffect=Entry(@"com.wechat.enhance.tabbar_style.click_effect");
    CHECK([clickEffect[@"module"] isEqual:@"tabbar"] && [clickEffect[@"scope"] isEqual:@"global"]);
    CHECK(Valid(@0,clickEffect) && Valid(@1,clickEffect));
    CHECK(!Valid(@"1",clickEffect));
    NSDictionary *panelEnabled=Entry(@"com.wechat.enhance.quick_panel.enabled");
    NSDictionary *panelLocations=Entry(@"com.wechat.enhance.quick_panel.trigger_locations");
    NSDictionary *panelActions=Entry(@"com.wechat.enhance.quick_panel.selected_actions");
    NSDictionary *panelStyle=Entry(@"com.wechat.enhance.quick_panel.background_style");
    NSDictionary *panelColor=Entry(@"com.wechat.enhance.quick_panel.background_color_hex");
    NSDictionary *panelOpacity=Entry(@"com.wechat.enhance.quick_panel.background_opacity");
    NSDictionary *panelImage=Entry(@"com.wechat.enhance.quick_panel.background_image_path");
    NSDictionary *panelTextColor=Entry(@"com.wechat.enhance.quick_panel.text_color_hex");
    NSDictionary *panelIconColor=Entry(@"com.wechat.enhance.quick_panel.icon_color_hex");
    CHECK([CSBackupRegistry.moduleTitles[@"quick_panel"] isEqual:@"快捷面板"]);
    CHECK([panelEnabled[@"type"] isEqual:@"bool"] && [panelLocations[@"type"] isEqual:@"number"] && [panelActions[@"type"] isEqual:@"array"]);
    NSUInteger panelFields=0;
    for (NSDictionary *entry in CSBackupRegistry.entries) if ([entry[@"module"] isEqual:@"quick_panel"]) panelFields++;
    CHECK(panelFields==9);
    for (NSDictionary *entry in @[panelEnabled,panelLocations,panelActions,panelStyle,panelColor,panelOpacity,panelTextColor,panelIconColor]) {
        CHECK([entry[@"module"] isEqual:@"quick_panel"] && [entry[@"scope"] isEqual:@"global"] && [entry[@"domain"] isEqual:@"standard"] && entry[@"resource"]==nil);
        CHECK([CSBackupRegistry entryForDomain:@"legacy" key:entry[@"key"]]==nil);
    }
    CHECK(Valid(@YES,panelEnabled) && Valid(@NO,panelEnabled) && Valid(@0,panelEnabled) && Valid(@1,panelEnabled));
    CHECK(!Valid(@"YES",panelEnabled) && !Valid(@2,panelEnabled) && !Valid(@(-1),panelEnabled) && !Valid(@0.5,panelEnabled));
    CHECK(Valid(@1,panelLocations) && Valid(@2,panelLocations) && Valid(@3,panelLocations));
    CHECK(!Valid(@0,panelLocations) && !Valid(@4,panelLocations) && !Valid(@(-1),panelLocations) && !Valid(@1.5,panelLocations));
    CHECK(!Valid(@"1",panelLocations) && !Valid(@(NAN),panelLocations) && !Valid(@(INFINITY),panelLocations));
    CHECK([panelImage[@"resource"] isEqual:@"file"] && [panelImage[@"module"] isEqual:@"quick_panel"]);
    CHECK(Valid(@"default",panelStyle) && Valid(@"color",panelStyle) && Valid(@"image",panelStyle));
    CHECK(!Valid(@"blur",panelStyle) && !Valid(@1,panelStyle));
    for (NSDictionary *color in @[panelColor,panelTextColor,panelIconColor]) {
        CHECK([color[@"type"] isEqual:@"string"]);
        CHECK(Valid(@"#000000",color) && Valid(@"#ABCDEF",color) && Valid(@"#FFFFFF",color));
        CHECK(!Valid(@"#abcdef",color) && !Valid(@"#GG0000",color) && !Valid(@"ABCDEF",color) && !Valid(@"#000000FF",color));
        CHECK(!Valid(@"",color) && !Valid(@" #123456",color) && !Valid(@"#12345",color));
        CHECK(!Valid(@17,color) && !Valid(NSNull.null,color) && !Valid(@{},color));
    }
    CHECK(Valid(@0,panelOpacity) && Valid(@1,panelOpacity) && Valid(@0.35,panelOpacity));
    CHECK(!Valid(@(-0.1),panelOpacity) && !Valid(@1.1,panelOpacity) && !Valid(@(NAN),panelOpacity) && !Valid(@(INFINITY),panelOpacity) && !Valid(@"0.5",panelOpacity));
    NSArray *legacyPanelIdentifiers=@[@"scan",@"wallet",@"moments",@"my_qrcode",@"favorites",@"plugin_home",@"profile",@"create_group",@"add_friend",@"emoji_store",@"panel_settings"];
    CHECK(legacyPanelIdentifiers.count==11 && Valid(legacyPanelIdentifiers,panelActions));
    NSArray *newPanelIdentifiers=@[@"payment_code",@"channels",@"file_transfer"];
    NSArray *panelIdentifiers=[legacyPanelIdentifiers arrayByAddingObjectsFromArray:newPanelIdentifiers];
    CHECK(panelIdentifiers.count==14 && Valid(panelIdentifiers,panelActions));
    NSArray *allPanelIdentifiers=[panelIdentifiers arrayByAddingObject:@"chat_background"];
    CHECK(allPanelIdentifiers.count==15 && Valid(allPanelIdentifiers,panelActions) && Valid(@[@"chat_background"],panelActions));
    NSArray *sixteenPanelIdentifiers=[allPanelIdentifiers arrayByAddingObject:@"receive_code"];
    CHECK(sixteenPanelIdentifiers.count==16 && Valid(sixteenPanelIdentifiers,panelActions));
    CHECK(Valid(@[@"receive_code"],panelActions) && Valid(@[@"receive_code",@"payment_code"],panelActions));
    CHECK(!Valid(@[@"receive_code",@"receive_code"],panelActions) && !Valid(@[@"receive_code.extra"],panelActions));
    CHECK(!Valid(@[@"receive_code",NSNull.null],panelActions));
    NSArray *seventeenPanelIdentifiers=[sixteenPanelIdentifiers arrayByAddingObject:@"my_moments"];
    CHECK(seventeenPanelIdentifiers.count==17 && Valid(seventeenPanelIdentifiers,panelActions));
    CHECK(Valid(@[@"my_moments"],panelActions) && Valid(@[@"my_moments",@"moments"],panelActions) && Valid(@[@"moments",@"my_moments"],panelActions));
    CHECK(!Valid(@[@"my_moments",@"my_moments"],panelActions) && !Valid(@[@"my_moments.extra"],panelActions));
    CHECK(!Valid(@[@"my_moments",NSNull.null],panelActions));
    NSArray *nineteenPanelIdentifiers=[seventeenPanelIdentifiers arrayByAddingObjectsFromArray:@[@"create_note",@"switch_account"]];
    CHECK(nineteenPanelIdentifiers.count==19 && Valid(nineteenPanelIdentifiers,panelActions));
    CHECK(Valid(@[@"create_note"],panelActions) && Valid(@[@"switch_account"],panelActions));
    CHECK(Valid(@[@"create_note",@"switch_account"],panelActions) && Valid(@[@"switch_account",@"create_note"],panelActions));
    CHECK(!Valid(@[@"create_note",@"create_note"],panelActions) && !Valid(@[@"switch_account",@"switch_account"],panelActions));
    CHECK(!Valid(@[@"create_note.extra"],panelActions) && !Valid(@[@"switch_account.extra"],panelActions));
    CHECK(!Valid(@[@"create_note",NSNull.null],panelActions) && !Valid(@[@"switch_account",@19],panelActions));
    CHECK(!Valid(@[@"chat_background",@"chat_background"],panelActions));
    CHECK(Valid(newPanelIdentifiers,panelActions) && Valid(@[@"file_transfer",@"scan",@"payment_code",@"channels"],panelActions));
    CHECK(Valid(@[],panelActions) && Valid(@[@"panel_settings",@"scan",@"favorites"],panelActions));
    CHECK(!Valid(@[@"scan",@"scan"],panelActions) && !Valid(@[@"unknown"],panelActions) && !Valid(@[@""],panelActions));
    CHECK(!Valid(@[@"channels",@"channels"],panelActions) && !Valid(@[@"payment_code",@"payment_code"],panelActions) && !Valid(@[@"file_transfer",@"file_transfer"],panelActions));
    CHECK(!Valid(@[@1],panelActions) && !Valid(@[NSNull.null],panelActions) && !Valid(@"scan",panelActions) && !Valid(@{},panelActions));
    CHECK(!Valid([panelIdentifiers arrayByAddingObject:@"scan"],panelActions));
    for (NSString *suffix in @[@"unknown",@"account",@"avatar",@"selected_actions.extra",@"text_color_hex.extra",@"icon_color_hex.extra"])
        CHECK(Entry([@"com.wechat.enhance.quick_panel." stringByAppendingString:suffix])==nil);
    CHECK(!Valid(@YES,@{@"domain":@"standard",@"key":@"com.wechat.enhance.quick_panel.unknown",@"module":@"quick_panel",@"type":@"bool",@"scope":@"global"}));
    for (NSString *base in @[@"sender_light",@"receiver_light",@"sender_dark",@"receiver_dark"]) {
        for (NSString *component in @[@"red",@"green",@"blue",@"alpha"]) CHECK(Entry([NSString stringWithFormat:@"com.wechat.enhance.bubble_style.%@_color.%@",base,component])!=nil);
        for (NSString *component in @[@"red",@"green",@"blue"]) CHECK(Entry([NSString stringWithFormat:@"com.wechat.enhance.bubble_style.%@_text_color.%@",base,component])!=nil);
    }
    CHECK(Entry(@"com.wechat.enhance.bubble_style.sender_light_color.purple")==nil);
    CHECK(Entry(@"com.wechat.enhance.bubble_style.sender_light_text_color.alpha")==nil);
    CHECK(Valid(@[@1,@7,@12],Entry(@"com.wechat.tweak.chat.attachment.private.hidden.buttons")));
    CHECK(!Valid(@[@"1"],Entry(@"com.wechat.tweak.chat.attachment.private.hidden.buttons")));
    CHECK(!Valid(@[@1.5],Entry(@"com.wechat.tweak.chat.attachment.private.sort.order")));
    CHECK(Valid(@{@"服务":@"My service"},Entry(@"com.wechat.tweak.custom_menu_names")));
    CHECK(!Valid(@{@"服务":@[@"wrong"]},Entry(@"com.wechat.tweak.custom_menu_names")));
    CHECK(Valid(@{@"wxid_a":@{@"enabled":@YES,@"separatorImagePath":@"/tmp/image.png",@"separatorSize":@18,@"verticalOffset":@(-2)}},Entry(@"com.wechat.tweak.navigation.contact.overrides")));
    CHECK(!Valid(@{@"wxid_a":@{@"enabled":@YES,@"separatorImagePath":@1}},Entry(@"com.wechat.tweak.navigation.contact.overrides")));
    CHECK(!Valid(@{@"wxid_a":@{@"enabled":@YES,@"unexpected":@YES}},Entry(@"com.wechat.tweak.navigation.contact.overrides")));
    CHECK(!Valid(@{@"wxid_a":@[]},Entry(@"com.wechat.tweak.navigation.contact.overrides")));
    CHECK(Valid([@"opaque UIColor archive" dataUsingEncoding:NSUTF8StringEncoding],Entry(@"com.wechat.enhance.inputText.color")));
    CHECK(!Valid(NSData.data,Entry(@"com.wechat.enhance.inputText.color")));
    CHECK(!Valid(@"not data",Entry(@"com.wechat.enhance.inputText.color")));
    CHECK(!Valid(@5,Entry(@"WCTimeLineMessageTailText")));
    NSDictionary *profile=@{@"version":@1,@"customTabs":@[@{@"id":@"custom_1",@"name":@"Work",@"members":@[@"wxid_a"],@"created":[NSDate date],@"updated":[NSDate date]}],@"presetNames":@{@"preset_0":@"All"},@"tabOrder":@[@"preset_0",@"custom_1"],@"hiddenPresetTabs":@[],@"selectedTabID":@"preset_0",@"filterDuplicates":@YES,@"legacyImported":@NO};
    NSDictionary *profilesEntry=Entry(@"com.wechat.enhance.chat_group.account_profiles");
    CHECK(Valid(@{@"wxid_a":profile},profilesEntry));
    NSMutableDictionary *bad=[profile mutableCopy]; bad[@"customTabs"]=@[@{@"id":@"custom_1",@"name":@"Work",@"members":@[@12]}];
    CHECK(!Valid(@{@"wxid_a":bad},profilesEntry));
    bad=[profile mutableCopy]; bad[@"version"]=@2; CHECK(!Valid(@{@"wxid_a":bad},profilesEntry));
    bad=[profile mutableCopy]; bad[@"customTabs"]=@[@{@"id":@"custom_1",@"name":@"Work",@"members":@[],@"created":@"today"}]; CHECK(!Valid(@{@"wxid_a":bad},profilesEntry));
    CHECK(!Valid(@{@"wxid_a":@"bad"},profilesEntry));
    bad=[profile mutableCopy]; bad[@"hiddenPresetTabs"]=@[@"custom_1"]; CHECK(!Valid(@{@"wxid_a":bad},profilesEntry));
    bad=[profile mutableCopy]; bad[@"tabOrder"]=@[@"preset_0",@"preset_0"]; CHECK(!Valid(@{@"wxid_a":bad},profilesEntry));
    bad=[profile mutableCopy]; bad[@"presetNames"]=@{@"custom_1":@"Wrong"}; CHECK(!Valid(@{@"wxid_a":bad},profilesEntry));
    bad=[profile mutableCopy]; bad[@"filterDuplicates"]=@"yes"; CHECK(!Valid(@{@"wxid_a":bad},profilesEntry));
    bad=[profile mutableCopy]; bad[@"unknown"]=@"field"; CHECK(!Valid(@{@"wxid_a":bad},profilesEntry));
    CHECK(Valid(@{@"version":@1,@"tabID":@"preset_0"},Entry([prefix stringByAppendingString:@"wxid_a"])));
    CHECK(!Valid(@{@"version":@1,@"tabID":@12},Entry([prefix stringByAppendingString:@"wxid_a"])));
    CHECK(!Valid(@{@"version":@2,@"tabID":@"preset_0"},Entry([prefix stringByAppendingString:@"wxid_a"])));
    NSMutableDictionary *spoof=[Entry(@"GameCheat_Enabled") mutableCopy]; spoof[@"type"]=@"string"; CHECK(!Valid(@"YES",spoof));
    CHECK(!Valid(@YES,(NSDictionary *)(id)@[@"malformed metadata"]));
    CHECK(!Valid(@{ @"domain":@"standard",@"key":@"AppleLanguages",@"type":@"array" },@{}));
    NSMutableSet *identities=[NSMutableSet new];
    for (NSDictionary *entry in [CSBackupRegistry entries]) {
        NSString *identity=[NSString stringWithFormat:@"%@/%@",entry[@"domain"],entry[@"key"]]; CHECK(![identities containsObject:identity]); [identities addObject:identity];
        CHECK([CSBackupRegistry moduleTitles][entry[@"module"]]!=nil);
        CHECK(([@[@"bool",@"number",@"string",@"data",@"array",@"dictionary"] containsObject:entry[@"type"]]));
        CHECK(([@[@"standard",@"legacy",@"layout"] containsObject:entry[@"domain"]]));
    }
    // Exercise the allowlist against a disposable preference domain, never live defaults.
    NSString *suite=[@"CSBackupRegistryTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    [defaults setBool:YES forKey:@"GameCheat_Enabled"]; CHECK(Valid([defaults objectForKey:@"GameCheat_Enabled"],Entry(@"GameCheat_Enabled"))); [defaults removePersistentDomainForName:suite];
    NSLog(@"Backup registry passed %lu assertions",(unsigned long)assertions);
} return 0; }
