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
