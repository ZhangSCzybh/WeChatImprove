// HOOK 隐藏我的页面选项
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSString * const kWCHideMomentsEnabledKey = @"com.wechat.tweak.hide_moments_enabled";
static NSString * const kWCHideFavoriteEnabledKey = @"com.wechat.tweak.hide_favorite_enabled";
static NSString * const kWCHideWalletEnabledKey = @"com.wechat.tweak.hide_wallet_enabled";
static NSString * const kWCHideStickerEnabledKey = @"com.wechat.tweak.hide_sticker_enabled";
static NSString * const kWCHideSettingsEnabledKey = @"com.wechat.tweak.hide_settings_enabled";
static NSString * const kWCHideServiceEnabledKey = @"com.wechat.tweak.hide_service_enabled";
static NSString * const kWCHideChannelsEnabledKey = @"com.wechat.tweak.hide_channels_enabled";

static BOOL gHideMomentsEnabled = NO;
static BOOL gHideFavoriteEnabled = NO;
static BOOL gHideWalletEnabled = NO;
static BOOL gHideStickerEnabled = NO;
static BOOL gHideSettingsEnabled = NO;
static BOOL gHideServiceEnabled = NO;
static BOOL gHideChannelsEnabled = NO;

static void loadSettings() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    gHideMomentsEnabled = [defaults objectForKey:kWCHideMomentsEnabledKey] ? [defaults boolForKey:kWCHideMomentsEnabledKey] : NO;
    gHideFavoriteEnabled = [defaults objectForKey:kWCHideFavoriteEnabledKey] ? [defaults boolForKey:kWCHideFavoriteEnabledKey] : NO;
    gHideWalletEnabled = [defaults objectForKey:kWCHideWalletEnabledKey] ? [defaults boolForKey:kWCHideWalletEnabledKey] : NO;
    gHideStickerEnabled = [defaults objectForKey:kWCHideStickerEnabledKey] ? [defaults boolForKey:kWCHideStickerEnabledKey] : NO;
    gHideSettingsEnabled = [defaults objectForKey:kWCHideSettingsEnabledKey] ? [defaults boolForKey:kWCHideSettingsEnabledKey] : NO;
    gHideServiceEnabled = [defaults objectForKey:kWCHideServiceEnabledKey] ? [defaults boolForKey:kWCHideServiceEnabledKey] : NO;
    gHideChannelsEnabled = [defaults objectForKey:kWCHideChannelsEnabledKey] ? [defaults boolForKey:kWCHideChannelsEnabledKey] : NO;
}

static void settingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    loadSettings();
}

static NSString *getCellTitle(id cellInfo) {
    @try {
        Class normalCellManagerClass = objc_getClass("WCTableViewNormalCellManager");
        if (!normalCellManagerClass || ![cellInfo isKindOfClass:normalCellManagerClass]) {
            return nil;
        }
        
        id cellConfig = [cellInfo valueForKey:@"cellConfig"];
        if (!cellConfig) return nil;
        
        id leftConfig = [cellConfig valueForKey:@"leftConfig"];
        if (!leftConfig) return nil;
        
        return [leftConfig valueForKey:@"title"];
    } @catch (NSException *e) {
        return nil;
    }
}

static BOOL shouldHideCell(NSString *title) {
    if (!title) return NO;
    
    if (gHideMomentsEnabled && ([title containsString:@"朋友圈"] || [title containsString:@"Moments"])) {
        return YES;
    }
    if (gHideFavoriteEnabled && ([title containsString:@"收藏"] || [title containsString:@"Favorites"] || [title containsString:@"Favorite"])) {
        return YES;
    }
    if (gHideWalletEnabled && ([title containsString:@"卡包"] || [title containsString:@"Cards"] || [title containsString:@"Wallet"])) {
        return YES;
    }
    if (gHideStickerEnabled && ([title containsString:@"表情"] || [title containsString:@"Stickers"] || [title containsString:@"Emoji"])) {
        return YES;
    }
    if (gHideSettingsEnabled && ([title containsString:@"设置"] || [title containsString:@"Settings"])) {
        return YES;
    }
    if (gHideServiceEnabled && ([title containsString:@"服务"] || [title containsString:@"Services"])) {
        return YES;
    }
    if (gHideChannelsEnabled && ([title containsString:@"视频号与公众号"] || [title containsString:@"视频号"] || [title containsString:@"Channels"])) {
        return YES;
    }
    
    return NO;
}

static void removeCellAt(id section, unsigned long long index) {
    @try {
        SEL selector = @selector(removeCellAt:);
        if (![section respondsToSelector:selector]) return;
        NSMethodSignature *signature = [section methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:section];
        [invocation setSelector:selector];
        [invocation setArgument:&index atIndex:2];
        [invocation invoke];
    } @catch (NSException *e) {
        NSLog(@"[HideMyPage] Exception in removeCellAt: %@", e);
    }
}

static void hideCellsInSection(id tableViewMgr) {
    if (!tableViewMgr) return;
    
    @try {
        NSMutableArray *sections = [tableViewMgr valueForKey:@"sections"];
        if (!sections || sections.count == 0) return;
        
        NSMutableArray *cellsToRemove = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < sections.count; i++) {
            id section = sections[i];
            if (!section) continue;
            
            NSMutableArray *cells = [section valueForKey:@"cells"];
            if (!cells) continue;
            
            for (NSUInteger j = 0; j < cells.count; j++) {
                id cellInfo = cells[j];
                if (!cellInfo) continue;
                
                NSString *title = getCellTitle(cellInfo);
                if (shouldHideCell(title)) {
                    [cellsToRemove addObject:@{@"section": @(i), @"cell": @(j)}];
                }
            }
        }
        
        if (cellsToRemove.count == 0) return;
        
        for (NSDictionary *info in [cellsToRemove reverseObjectEnumerator]) {
            NSUInteger sectionIdx = [info[@"section"] unsignedLongLongValue];
            NSUInteger cellIdx = [info[@"cell"] unsignedLongLongValue];
            
            sections = [tableViewMgr valueForKey:@"sections"];
            if (!sections || sectionIdx >= sections.count) continue;
            
            id section = sections[sectionIdx];
            if (!section) continue;
            
            NSMutableArray *cells = [section valueForKey:@"cells"];
            if (!cells || cellIdx >= cells.count) continue;
            
            removeCellAt(section, (unsigned long long)cellIdx);
        }
        
        UITableView *tableView = [tableViewMgr valueForKey:@"tableView"];
        if (tableView) {
            [tableView reloadData];
        }
        
    } @catch (NSException *e) {
        NSLog(@"[HideMyPage] CRASH in hideCellsInSection: %@", e);
    }
}

@interface MoreViewController : NSObject
@end

%hook MoreViewController

- (void)viewDidLoad {
    %orig;
    loadSettings();
    hideCellsInSection([self valueForKey:@"m_tableViewMgr"]);
}

- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    hideCellsInSection([self valueForKey:@"m_tableViewMgr"]);
}

- (void)reloadMoreView {
    %orig;
    hideCellsInSection([self valueForKey:@"m_tableViewMgr"]);
}

%end

%ctor {
    loadSettings();
    
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        settingsChanged,
        CFSTR("com.wechat.tweak.settings_changed"),
        NULL,
        CFNotificationSuspensionBehaviorCoalesce
    );
}
