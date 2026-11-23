#import "CSPluginFeatureSummary.h"
#import "CSBackupBootstrap.h"
#import <objc/message.h>
#include <math.h>

NSNotificationName const CSPluginFeatureSummaryDidChangeNotification = @"CSPluginFeatureSummaryDidChangeNotification";

// Capture only objects already published by their owners. Calling sharedManager
// here would create senders, clients or schedulers just to draw a settings label.
static __weak id AutomationSource, AISource, ScheduledSource, GroupChatSource;

static BOOL FeatureBool(id value) {
    return [value respondsToSelector:@selector(boolValue)] && [value boolValue];
}
static BOOL AnyFeature(id (^reader)(NSString *, NSString *), NSString *domain, NSArray<NSString *> *keys) {
    for (NSString *key in keys) if (FeatureBool(reader(domain, key))) return YES;
    return NO;
}
static NSDictionary *Dictionary(id value) {
    return [value isKindOfClass:NSDictionary.class] ? value : @{};
}
static NSDictionary *CurrentConfiguration(NSDictionary *snapshot, NSUInteger epoch, BOOL ready) {
    if (!ready || !FeatureBool(snapshot[@"ready"]) || ![snapshot[@"epoch"] isEqual:@(epoch)] ||
        ![snapshot[@"account"] isKindOfClass:NSString.class] || ![snapshot[@"account"] length]) return @{};
    return Dictionary(snapshot[@"configuration"]);
}

// All selectors below are zero-argument snapshot getters on a captured instance.
static id ObjectGetter(id object, NSString *name) {
    SEL selector=NSSelectorFromString(name);
    return [object respondsToSelector:selector] ? ((id (*)(id, SEL))objc_msgSend)(object, selector) : nil;
}
static BOOL BoolGetter(id object, NSString *name) {
    SEL selector=NSSelectorFromString(name);
    return [object respondsToSelector:selector] && ((BOOL (*)(id, SEL))objc_msgSend)(object, selector);
}
static NSUInteger IntegerGetter(id object, NSString *name) {
    SEL selector=NSSelectorFromString(name);
    return [object respondsToSelector:selector] ? ((NSUInteger (*)(id, SEL))objc_msgSend)(object, selector) : NSUIntegerMax;
}
static NSDictionary *AccountSnapshot(id source, BOOL stored, NSUInteger epoch) {
    if (!source) return @{};
    @try {
        NSString *epochName=stored ? @"epoch" : @"accountEpoch";
        if (IntegerGetter(source, epochName)!=epoch) return @{};
        id owner=stored ? ObjectGetter(source, @"store") : source;
        if (!BoolGetter(owner, @"ready")) return @{};
        id account=ObjectGetter(owner, stored ? @"account" : @"accountID");
        if (![account isKindOfClass:NSString.class] || ![account length]) return @{};
        NSDictionary *configuration=Dictionary(ObjectGetter(owner, @"configuration"));
        if (stored && [owner respondsToSelector:@selector(enabled)]) configuration=@{@"enabled":@(BoolGetter(owner, @"enabled"))};
        if (IntegerGetter(source, epochName)!=epoch || !BoolGetter(owner, @"ready")) return @{};
        return @{@"ready":@YES, @"epoch":@(epoch), @"account":account, @"configuration":configuration};
    } @catch (__unused NSException *exception) { return @{}; }
}

@implementation CSPluginFeatureSummary
+ (void)load {
    @autoreleasepool {
        for (NSString *name in @[@"CSAutomationConfigurationDidChange", @"CSAIReplyDidChange",
                                 @"CSScheduledTasksDidChange", @"CSGroupChatConfigurationDidChange"])
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(accountSourceChanged:) name:name object:nil];
    }
}
+ (void)accountSourceChanged:(NSNotification *)note {
    // Queue:nil delivery may be on a worker with a native lock held. Do not read
    // owner properties there; the view and account owners publish on main.
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ [self accountSourceChanged:note]; });
        return;
    }
    NSDictionary *classes=@{@"CSAutomationConfigurationDidChange":@"CSAutomationManager",
                            @"CSAIReplyDidChange":@"CSAIReplyManager",
                            @"CSScheduledTasksDidChange":@"CSScheduledTaskManager",
                            @"CSGroupChatConfigurationDidChange":@"CSGroupChatManager"};
    Class ownerClass=NSClassFromString(classes[note.name]);
    if (!ownerClass || ![note.object isKindOfClass:ownerClass]) return;
    if ([note.name isEqual:@"CSAutomationConfigurationDidChange"]) AutomationSource=note.object;
    else if ([note.name isEqual:@"CSAIReplyDidChange"]) AISource=note.object;
    else if ([note.name isEqual:@"CSScheduledTasksDidChange"]) ScheduledSource=note.object;
    else GroupChatSource=note.object;
    [NSNotificationCenter.defaultCenter postNotificationName:CSPluginFeatureSummaryDidChangeNotification object:self];
}
+ (NSArray<NSNotificationName> *)refreshNotificationNames {
    return @[NSUserDefaultsDidChangeNotification, @"com.wechat.tweak.settings_changed",
             @"com.wechat.tweak.local_settings_changed", @"CSNavigationTitleSettingsChanged",
             @"com.wechat.enhance.tabbar_style.changed", @"com.wechat.tweak.background.blur.changed",
             @"CSBackgroundRunStateChanged", @"CSMessageActionSettingsDidChangeNotification",
             @"CSVoicePlaybackSettingsDidChangeNotification", @"CSClownSettingsDidChangeNotification",
             @"CSMomentsLayoutChangedNotification", @"CSAdPurificationChangedNotification",
             @"CSClientGuardChangedNotification", @"CSBackupAccountChanged", @"com.wechat.enhance.quick_panel.changed",
             @"UIApplicationDidBecomeActiveNotification", CSPluginFeatureSummaryDidChangeNotification];
}
+ (NSUInteger)enabledModuleCount {
    if (!NSThread.isMainThread || !CSBackupIsReady()) return 0;
    NSUInteger epoch=CSBackupAccountEpoch();
    BOOL ready=!CSBackupAccountIsSuspended();
    NSDictionary *accounts=[self accountSnapshotsAtEpoch:epoch ready:ready];
    static NSUserDefaults *legacy, *layout;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        legacy=[[NSUserDefaults alloc] initWithSuiteName:@"com.cyansmoke.wechattweak"];
        layout=[[NSUserDefaults alloc] initWithSuiteName:@"com.wechat.enhance"];
    });
    NSDictionary *states=[self moduleStatesWithValueReader:^id(NSString *domain, NSString *key) {
        NSUserDefaults *defaults=[domain isEqual:@"legacy"] ? legacy : [domain isEqual:@"layout"] ? layout : NSUserDefaults.standardUserDefaults;
        return [defaults objectForKey:key];
    } accountSnapshots:accounts epoch:epoch accountReady:ready && epoch==CSBackupAccountEpoch() && !CSBackupAccountIsSuspended()];
    // A native account boundary can advance the epoch from another thread while
    // global defaults are being read. Keep global modules, reject the old account.
    BOOL accountsCurrent=ready && CSBackupIsReady() && epoch==CSBackupAccountEpoch() && !CSBackupAccountIsSuspended();
    NSArray *accountModules=@[@"automation", @"ai", @"scheduled", @"group_tools"];
    NSUInteger count=0;
    for (NSString *module in states)
        if ([states[module] boolValue] && (accountsCurrent || ![accountModules containsObject:module])) count++;
    return count;
}
+ (NSDictionary *)accountSnapshotsAtEpoch:(NSUInteger)epoch ready:(BOOL)ready {
    return ready ? @{@"automation":AccountSnapshot(AutomationSource, NO, epoch),
                     @"ai":AccountSnapshot(AISource, YES, epoch),
                     @"scheduled":AccountSnapshot(ScheduledSource, YES, epoch),
                     @"group_tools":AccountSnapshot(GroupChatSource, NO, epoch)} : @{};
}
+ (NSDictionary<NSString *, NSNumber *> *)moduleStatesWithValueReader:(id (^)(NSString *, NSString *))reader
                                                   accountSnapshots:(NSDictionary<NSString *, NSDictionary *> *)snapshots
                                                              epoch:(NSUInteger)epoch
                                                       accountReady:(BOOL)accountReady {
    NSMutableDictionary *states=[NSMutableDictionary dictionary];
    // One row per ordinary homepage module; children of a disabled parent never
    // enter this list. Account information, management tools and private modules
    // intentionally have no row, regardless of their stored preferences.
    NSArray *rules=@[
        @[@"favorite", @"legacy", @[@"com.wechat.tweak.biometric.auth.favorite"]],
        @[@"client_guard", @"standard", @[@"com.wechat.enhance.client_guard.enabled"]],
        @[@"navigation", @"standard", @[@"com.wechat.tweak.navigation.show.avatar"]],
        @[@"avatar", @"legacy", @[@"roundAvatar", @"rotateAvatar", @"hideOtherAvatarInPrivateChat", @"hideSelfAvatarInPrivateChat", @"hideBothAvatarInPrivateChat", @"hideOtherAvatarInGroupChat", @"hideSelfAvatarInGroupChat", @"hideBothAvatarInGroupChat", @"hideOtherAvatarInOfficialAccount", @"hideSelfAvatarInOfficialAccount", @"hideBothAvatarInOfficialAccount"]],
        @[@"touch", @"standard", @[@"com.wechat.tweak.touch.trail.enabled"]],
        @[@"simple_ui", @"standard", @[@"com.wechat.tweak.simple_ui_enabled"]],
        @[@"bubble", @"standard", @[@"com.wechat.enhance.bubble_style.enabled", @"com.wechat.enhance.merge_messages.enabled"]],
        @[@"list", @"standard", @[@"com.wechat.enhance.list_corner_radius.enabled"]],
        @[@"tabbar", @"standard", @[@"com.wechat.enhance.tabbar_style.enabled"]],
        @[@"quick_panel", @"standard", @[@"com.wechat.enhance.quick_panel.enabled"]],
        @[@"attachments", @"standard", @[@"com.wechat.tweak.chat.attachment.layout.enabled"]],
        @[@"input", @"standard", @[@"com.wechat.enhance.inputText.enabled", @"com.wechat.enhance.inputText.roundedCorners", @"com.wechat.enhance.inputText.border.enabled"]],
        @[@"groups", @"standard", @[@"com.wechat.enhance.chat_group.enabled"]],
        @[@"message_time", @"standard", @[@"com.wechat.enhance.messageTime.enabled"]],
        @[@"background_blur", @"legacy", @[@"com.wechat.tweak.background.blur.enabled"]],
        @[@"ads", @"standard", @[@"com.wechat.enhance.ad_purification.enabled"]],
        @[@"moments", @"standard", @[@"com.wechat.enhance.moments_layout.enabled"]],
        @[@"background", @"legacy", @[@"BackgroundRunEnabled"]],
        @[@"games", @"standard", @[@"GameCheat_Enabled"]],
        @[@"revoke", @"standard", @[@"com.wechat.enhance.revoke.enabled"]],
        @[@"red_envelop", @"standard", @[@"com.wechat.enhance.redenvelop.autoReceive"]],
        @[@"transfers", @"standard", @[@"kReceiveTransferAutoEnableKey"]],
        @[@"gestures", @"standard", @[@"com.wechat.enhance.message_gesture.enabled"]],
        @[@"voice", @"standard", @[@"com.wechat.enhance.voice_forward.enabled", @"com.wechat.enhance.voice_forward.favorite_enabled", @"com.wechat.enhance.voice_playback.progress_enabled"]],
        @[@"repeat", @"standard", @[@"com.wechat.enhance.repeat.enabled"]],
        @[@"sticker", @"standard", @[@"com.wechat.enhance.image_sticker.enabled"]],
        @[@"clown", @"standard", @[@"com.wechat.enhance.clown.enabled"]]
    ];
    for (NSArray *row in rules) states[row[0]]=@(AnyFeature(reader, row[1], row[2]));

    NSMutableArray *cleanKeys=[NSMutableArray array];
    for (NSString *suffix in @[@"qrcode", @"chat_time", @"pat_message", @"voice_hint", @"moments", @"favorite", @"wallet", @"sticker", @"settings", @"service", @"channels", @"works"])
        [cleanKeys addObject:[NSString stringWithFormat:@"com.wechat.tweak.hide_%@_enabled", suffix]];
    for (NSString *suffix in @[@"channels", @"live", @"scan", @"listen", @"look", @"search", @"nearby", @"game", @"miniprogram"])
        [cleanKeys addObject:[@"com.wechat.tweak.hide_discover_" stringByAppendingString:suffix]];
    for (NSString *suffix in @[@"profile", @"account_security", @"privacy", @"notification", @"display", @"friend_permission", @"storage", @"more", @"chat", @"call", @"chat_history", @"other", @"help", @"about", @"plugin", @"switch_account", @"logout"])
        [cleanKeys addObject:[@"com.wechat.tweak.hide_setting_" stringByAppendingString:suffix]];
    states[@"ui_clean"]=@(AnyFeature(reader, @"standard", cleanKeys));
    id font=reader(@"layout", @"font.chat_size"), scale=reader(@"layout", @"global.scale");
    double fontValue=[font respondsToSelector:@selector(doubleValue)] ? [font doubleValue] : 17;
    double scaleValue=[scale respondsToSelector:@selector(doubleValue)] ? [scale doubleValue] : 1;
    states[@"layout"]=@((isfinite(fontValue) && fontValue>=8 && fontValue<=25 && fabs(fontValue-17)>0.001) ||
                         (isfinite(scaleValue) && scaleValue>=0.5 && scaleValue<=2 && fabs(scaleValue-1)>0.001));

    NSDictionary *ai=CurrentConfiguration(Dictionary(snapshots[@"ai"]), epoch, accountReady);
    NSDictionary *scheduled=CurrentConfiguration(Dictionary(snapshots[@"scheduled"]), epoch, accountReady);
    NSDictionary *automation=CurrentConfiguration(Dictionary(snapshots[@"automation"]), epoch, accountReady);
    NSDictionary *group=CurrentConfiguration(Dictionary(snapshots[@"group_tools"]), epoch, accountReady);
    states[@"ai"]=@(FeatureBool(ai[@"enabled"]));
    states[@"scheduled"]=@(FeatureBool(scheduled[@"enabled"]));
    BOOL automatic=NO;
    for (NSString *key in @[@"patBack", @"patReply", @"mentionReply", @"keywordReply"])
        automatic=automatic || FeatureBool(Dictionary(automation[key])[@"enabled"]);
    states[@"automation"]=@(automatic);
    states[@"group_tools"]=@(FeatureBool(group[@"welcomeEnabled"]) || FeatureBool(group[@"monitorEnabled"]) || FeatureBool(group[@"autoSaveEnabled"]));
    return [states copy];
}
@end
