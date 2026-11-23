#import <Foundation/Foundation.h>
#import "CSPluginFeatureSummary.h"

// These functions are never allowed to touch a real account in this host test.
BOOL CSBackupIsReady(void) { return NO; }
NSUInteger CSBackupAccountEpoch(void) { return 11; }
BOOL CSBackupAccountIsSuspended(void) { return YES; }

@interface CSPluginFeatureSummary (TestSnapshots)
+ (NSDictionary *)accountSnapshotsAtEpoch:(NSUInteger)epoch ready:(BOOL)ready;
@end

static NSUInteger checks, failures, sharedCalls;
static void Check(BOOL result, NSString *message) {
    checks++;
    if (!result) { failures++; fprintf(stderr, "FAIL: %s\n", message.UTF8String); }
}
static NSDictionary *States(NSDictionary *domains, NSDictionary *accounts, NSUInteger epoch, BOOL ready) {
    return [CSPluginFeatureSummary moduleStatesWithValueReader:^id(NSString *domain, NSString *key) {
        return domains[domain][key];
    } accountSnapshots:accounts epoch:epoch accountReady:ready];
}
static NSUInteger Count(NSDictionary *states) {
    NSUInteger count=0;
    for (NSNumber *enabled in states.allValues) if (enabled.boolValue) count++;
    return count;
}
static NSDictionary *Snapshot(NSDictionary *configuration, BOOL ready, NSUInteger epoch) {
    return @{@"account":@"fixture-account", @"epoch":@(epoch), @"ready":@(ready), @"configuration":configuration};
}

@interface CSAutomationManager : NSObject
@property(nonatomic) BOOL ready;
@property(nonatomic) NSUInteger accountEpoch, configurationReads;
@property(nonatomic, copy) NSString *accountID;
@property(nonatomic, copy) NSDictionary *configurationValue;
@end
@implementation CSAutomationManager
+ (id)sharedManager { sharedCalls++; [NSException raise:@"SideEffect" format:@"summary must not create managers"]; return nil; }
- (NSDictionary *)configuration { self.configurationReads++; return self.configurationValue; }
@end
@interface FeatureStore : NSObject
@property(nonatomic) BOOL ready, enabled;
@property(nonatomic, copy) NSString *account;
@end
@implementation FeatureStore @end
@interface CSScheduledTaskManager : NSObject
@property(nonatomic) NSUInteger epoch;
@property(nonatomic, strong) FeatureStore *store;
@end
@implementation CSScheduledTaskManager
+ (id)sharedManager { sharedCalls++; [NSException raise:@"SideEffect" format:@"summary must not create schedulers"]; return nil; }
@end

int main(void) { @autoreleasepool {
    NSDictionary *empty=States(@{}, @{}, 11, YES);
    Check(empty.count==33 && Count(empty)==0, @"explicit homepage module list starts disabled");
    Check(Count(States(@{@"standard":@{@"com.wechat.enhance.quick_panel.enabled":@YES}}, @{}, 11, YES))==1,
          @"quick panel counts once independently of trigger and entry choices");
    Check(Count(States(@{@"standard":@{@"com.wechat.enhance.quick_panel.trigger_locations":@3,
                                      @"com.wechat.enhance.quick_panel.selected_actions":@[@"scan"]}}, @{}, 11, YES))==0,
          @"configured panel entries do not enable a disabled module");
    NSDictionary *noise=@{@"standard":@{@"com.wechat.enhance.backup.auto_enabled":@YES,
                                         @"com.wechat.enhance.close_friend.enabled":@YES,
                                         @"com.wechat.tweak.version.selected":@123,
                                         @"unrelated.enabled":@YES}};
    Check(Count(States(noise, @{}, 11, YES))==0, @"private modules, tools and unrelated booleans never enter the count");

    NSDictionary *children=@{@"standard":@{@"com.wechat.enhance.clown.text.enabled":@YES,
                                            @"com.wechat.enhance.ad_purification.articles":@YES,
                                            @"com.wechat.tweak.chat.attachment.private.sort.enabled":@YES,
                                            @"com.wechat.tweak.navigation.show.in.private":@YES,
                                            @"com.wechat.enhance.redenvelop.groupEnable":@YES,
                                            @"kReceiveTransferPrivateEnableKey":@YES}};
    Check(Count(States(children, @{}, 11, YES))==0, @"remembered children of disabled parent modules do not count");
    NSDictionary *dedup=@{@"standard":@{@"com.wechat.enhance.voice_forward.enabled":@YES,
                                         @"com.wechat.enhance.voice_forward.favorite_enabled":@YES,
                                         @"com.wechat.enhance.voice_playback.progress_enabled":@YES,
                                         @"com.wechat.enhance.bubble_style.enabled":@YES,
                                         @"com.wechat.enhance.merge_messages.enabled":@YES,
                                         @"com.wechat.enhance.inputText.enabled":@YES,
                                         @"com.wechat.enhance.inputText.roundedCorners":@YES,
                                         @"com.wechat.enhance.inputText.border.enabled":@YES}};
    Check(Count(States(dedup, @{}, 11, YES))==3, @"independent children collapse to one homepage module");
    Check(Count(States(@{@"standard":@{@"com.wechat.enhance.voice_playback.progress_enabled":@YES}}, @{}, 11, YES))==1, @"voice progress is independently enabled without forwarding");
    Check(Count(States(@{@"standard":@{@"com.wechat.enhance.inputText.border.enabled":@YES}}, @{}, 11, YES))==1, @"input border independently enables its module");
    NSDictionary *payments=@{@"standard":@{@"com.wechat.enhance.redenvelop.autoReceive":@YES,
                                            @"kReceiveTransferAutoEnableKey":@YES},
                              @"legacy":@{@"BackgroundRunEnabled":@YES}};
    Check(Count(States(payments, @{}, 11, YES))==3, @"envelopes, transfers and legacy background are included");
    Check(Count(States(@{@"standard":@{@"BackgroundRunEnabled":@YES}}, @{}, 11, YES))==0, @"legacy settings are not silently read from a different domain");
    Check(Count(States(@{@"legacy":@{@"roundAvatar":@YES, @"rotateAvatar":@YES, @"hideSelfAvatarInGroupChat":@YES}}, @{}, 11, YES))==1, @"avatar subfeatures share one legacy module");
    Check(Count(States(@{@"standard":@{@"com.wechat.tweak.hide_setting_display":@YES, @"com.wechat.tweak.hide_discover_scan":@YES}}, @{}, 11, YES))==1, @"cleanup covers exact setting and discovery keys without double count");
    Check(Count(States(@{@"layout":@{@"font.chat_size":@17, @"global.scale":@1}}, @{}, 11, YES))==0, @"default layout does not count");
    Check(Count(States(@{@"layout":@{@"font.chat_size":@19, @"global.scale":@1.2}}, @{}, 11, YES))==1, @"custom font and scale share one layout module");
    Check(Count(States(@{@"layout":@{@"font.chat_size":@0, @"global.scale":@999}}, @{}, 11, YES))==0, @"invalid layout values use native defaults");

    NSDictionary *accounts=@{@"ai":Snapshot(@{@"enabled":@YES}, YES, 11),
                              @"scheduled":Snapshot(@{@"enabled":@YES}, YES, 11),
                              @"automation":Snapshot(@{@"patBack":@{@"enabled":@YES}, @"keywordReply":@{@"enabled":@YES}}, YES, 11),
                              @"group_tools":Snapshot(@{@"welcomeEnabled":@YES, @"monitorEnabled":@YES, @"autoSaveEnabled":@YES}, YES, 11)};
    Check(Count(States(@{}, accounts, 11, YES))==4, @"current account snapshots count each account module once");
    Check(Count(States(@{}, accounts, 12, YES))==0, @"old account epoch cannot affect a newly switched account");
    Check(Count(States(@{}, accounts, 11, NO))==0, @"suspended account excludes all account snapshots");
    Check(Count(States(@{}, @{@"ai":Snapshot(@{@"enabled":@YES}, NO, 11)}, 11, YES))==0, @"not ready store cannot expose retained configuration");
    Check(Count(States(@{}, @{@"ai":@{@"ready":@YES, @"epoch":@11, @"configuration":@{@"enabled":@YES}}}, 11, YES))==0, @"unknown account identity excludes configuration");
    Check(Count(States(payments, accounts, 11, NO))==3, @"account transitions retain independent global module settings");

    Check([CSPluginFeatureSummary accountSnapshotsAtEpoch:11 ready:YES][@"automation"]!=nil && !sharedCalls,
          @"snapshot reads never instantiate managers even before their first notification");
    CSAutomationManager *automatic=[CSAutomationManager new];
    automatic.ready=YES; automatic.accountEpoch=11; automatic.accountID=@"fixture-account";
    automatic.configurationValue=@{@"patBack":@{@"enabled":@YES}};
    [NSNotificationCenter.defaultCenter postNotificationName:@"CSAutomationConfigurationDidChange" object:automatic];
    NSDictionary *published=[CSPluginFeatureSummary accountSnapshotsAtEpoch:11 ready:YES];
    Check(Count(States(@{}, published, 11, YES))==1 && automatic.configurationReads==1,
          @"existing managers publish a read-only current snapshot through their notification object");
    [CSPluginFeatureSummary accountSnapshotsAtEpoch:12 ready:YES];
    [CSPluginFeatureSummary accountSnapshotsAtEpoch:11 ready:NO];
    Check(automatic.configurationReads==1, @"epoch mismatch and suspended account do not even read old configuration");
    automatic.ready=NO;
    [CSPluginFeatureSummary accountSnapshotsAtEpoch:11 ready:YES];
    Check(automatic.configurationReads==1, @"unready manager is rejected before its retained configuration getter");
    automatic.ready=YES;
    CSScheduledTaskManager *scheduler=[CSScheduledTaskManager new];
    scheduler.epoch=11; scheduler.store=[FeatureStore new];
    scheduler.store.account=@"fixture-account"; scheduler.store.ready=YES; scheduler.store.enabled=YES;
    [NSNotificationCenter.defaultCenter postNotificationName:@"CSScheduledTasksDidChange" object:scheduler];
    published=[CSPluginFeatureSummary accountSnapshotsAtEpoch:11 ready:YES];
    Check([published[@"scheduled"][@"configuration"][@"enabled"] boolValue] && !sharedCalls,
          @"scheduler uses its existing ready store without starting any execution");
    Check([[CSPluginFeatureSummary refreshNotificationNames] containsObject:CSPluginFeatureSummaryDidChangeNotification] &&
          [[CSPluginFeatureSummary refreshNotificationNames] containsObject:@"CSBackupAccountChanged"],
          @"UI observes snapshot changes and account boundary refreshes");
    Check([CSPluginFeatureSummary enabledModuleCount]==0, @"startup gate prevents reading real settings before readiness");
    fprintf(stdout, "Plugin feature summary: %lu checks, %lu failures\n", (unsigned long)checks, (unsigned long)failures);
    return failures ? 1 : 0;
} }
