// Avatar preferences compose with native visibility and belong to each model's chat.
#import "../Controllers/CSAvatarSettingsViewController.h"
#import "../Controllers/CSMessageMergeAdapter.h"
#import "../Headers/WCHeaders.h"
#import "../Controllers/CSPreferenceRefresh.h"
static atomic_bool avatarRefreshPending;

static atomic_uint avatarHiddenMask;
static NSUserDefaults *avatarDefaults;
static void reloadAvatarVisibility(void) {
    unsigned mask = 0;
    NSArray *keys = @[@[kHideSelfAvatarInPrivateChatKey,kHideOtherAvatarInPrivateChatKey,kHideBothAvatarInPrivateChatKey],
                      @[kHideSelfAvatarInGroupChatKey,kHideOtherAvatarInGroupChatKey,kHideBothAvatarInGroupChatKey],
                      @[kHideSelfAvatarInOfficialAccountKey,kHideOtherAvatarInOfficialAccountKey,kHideBothAvatarInOfficialAccountKey]];
    for (NSUInteger i=0;i<keys.count;i++) {
        NSArray *group = keys[i];
        BOOL both = [avatarDefaults boolForKey:group[2]];
        if (both || [avatarDefaults boolForKey:group[0]]) mask |= 1u << (i*2);
        if (both || [avatarDefaults boolForKey:group[1]]) mask |= 1u << (i*2+1);
    }
    atomic_store(&avatarHiddenMask,mask);
}
%hook CommonMessageViewModel
- (BOOL)isShowHeadImage {
    BOOL native = %orig;
    if (!native) return NO;
    NSString *chat = CSMessageModelChatName(self);
    if (!chat.length) return native;
    NSUInteger scene = [chat hasSuffix:@"@chatroom"] ? 1 : ([chat hasPrefix:@"gh_"] ? 2 : 0);
    NSUInteger bit = scene * 2 + ([self isSender] ? 0 : 1);
    return !(atomic_load(&avatarHiddenMask) & (1u << bit));
}
%end
%ctor {
    avatarDefaults = [[NSUserDefaults alloc] initWithSuiteName:kUserDefaultsSuiteName];
    reloadAvatarVisibility();
    [NSNotificationCenter.defaultCenter addObserverForName:NSUserDefaultsDidChangeNotification object:nil
        queue:nil usingBlock:^(NSNotification *note) {
            CSRequestMainRefresh(&avatarRefreshPending, ^{ reloadAvatarVisibility(); });
        }];
}
