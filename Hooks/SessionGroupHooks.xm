#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "WESessionTabContainerView.h"
#import "WESessionTabItem.h"
#import "CSServiceCenter.h"

static NSString * const kChatGroupEnabledKey = @"com.wechat.enhance.chat_group.enabled";
static NSString * const kCustomTabsKey = @"com.wechat.enhance.chat_group.custom_tabs";
static NSString * const kPresetTabNamesKey = @"com.wechat.enhance.chat_group.preset_names";
static NSString * const kTabOrderKey = @"com.wechat.enhance.chat_group.tab_order";
static NSString * const kHiddenPresetTabsKey = @"com.wechat.enhance.chat_group.hidden_preset_tabs";
static NSString * const kFilterDuplicateContactsKey = @"com.wechat.enhance.chat_group.filter_duplicate_contacts";
static NSString * const kSwipeGestureEnabledKey = @"com.wechat.enhance.chat_group.swipe_gesture_enabled";
static NSString * const kHideGroupBadgeKey = @"com.wechat.enhance.chat_group.hide_group_badge";
static NSString * const kHideAllBadgeKey = @"com.wechat.enhance.chat_group.hide_all_badge";

static NSString * const kTabContainerViewKey = @"com.wechat.enhance.chat_group.tabContainerView";
static NSString * const kCurrentTabIndexKey = @"com.wechat.enhance.chat_group.currentTabIndex";
static NSString * const kCurrentTabsKey = @"com.wechat.enhance.chat_group.currentTabs";
static NSString * const kLogicControllerKey = @"com.wechat.enhance.chat_group.logicController";
static NSString * const kLayoutDebounceKey = @"com.wechat.enhance.chat_group.layoutDebounce";
static NSString * const kUnreadDebounceKey = @"com.wechat.enhance.chat_group.unreadDebounce";

// 列表圆角相关常量
static NSString * const kListCornerRadiusEnabledKey = @"com.wechat.enhance.list_corner_radius.enabled";
static NSString * const kListCornerRadiusKey = @"com.wechat.enhance.list_corner_radius.radius";
static NSString * const kListLeftMarginKey = @"com.wechat.enhance.list_corner_radius.left_margin";
static NSString * const kListRightMarginKey = @"com.wechat.enhance.list_corner_radius.right_margin";

// 列表滑动灵敏度相关常量
static NSString * const kScrollSensitivityKey = @"com.wechat.enhance.scroll_sensitivity";
static NSString * const kScrollAnimationEnabledKey = @"com.wechat.enhance.scroll_animation.enabled";

// 性能优化相关常量
static const NSTimeInterval kCacheExpireTime = 5.0;
static const NSTimeInterval kUnreadCacheExpireTime = 1.0;
static const NSTimeInterval kSettingsCacheExpireTime = 10.0;
static const NSTimeInterval kUnreadDebounceTime = 0.3;
static const CGFloat kTabHeight = 52.0;
static const CGFloat kDefaultCornerRadius = 10.0;
static const CGFloat kDefaultLeftMargin = 15.0;
static const CGFloat kDefaultRightMargin = 15.0;

// 缓存变量
static NSSet<NSString *> *gCachedGroupUserNames = nil;
static NSSet<NSString *> *gCachedPrivateUserNames = nil;
static NSDate *gLastCustomTabCacheTime = nil;
static NSMutableDictionary *gUnreadCountCache = nil;
static NSDate *gLastUnreadUpdateTime = nil;
static NSArray<WESessionTabItem *> *gCachedTabs = nil;
static NSDate *gLastTabsCacheTime = nil;
static BOOL gFilterDuplicateContacts = NO;
static BOOL gHideGroupBadge = NO;
static BOOL gHideAllBadge = NO;
static BOOL gSwipeGestureEnabled = NO;
static NSDate *gLastSettingsUpdateTime = nil;
static CGRect gLastViewBounds = CGRectZero;
static BOOL gIsTabSwitching = NO;
static BOOL gIsVerticalScrolling = NO;
static BOOL gLastChatGroupEnabled = NO;
static BOOL gLastListCornerRadiusEnabled = NO;

// 可见行索引缓存
static NSMutableDictionary *gVisibleRowsCache = nil;
static NSString * const kVisibleRowsCacheKey = @"com.wechat.enhance.chat_group.visible_rows_cache";

// 圆角路径缓存
static NSMutableDictionary *gCornerRadiusCache = nil;

static BOOL isChatGroupEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kChatGroupEnabledKey];
}

static BOOL isListCornerRadiusEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kListCornerRadiusEnabledKey];
}

static CGFloat getListCornerRadius() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat radius = [defaults floatForKey:kListCornerRadiusKey];
    return radius > 0 ? radius : kDefaultCornerRadius;
}

static CGFloat getListLeftMargin() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat margin = [defaults floatForKey:kListLeftMarginKey];
    return margin > 0 ? margin : kDefaultLeftMargin;
}

static CGFloat getListRightMargin() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat margin = [defaults floatForKey:kListRightMarginKey];
    return margin > 0 ? margin : kDefaultRightMargin;
}

static BOOL isScrollSensitivityEnabled() {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kScrollSensitivityKey] > 0;
}

static CGFloat getScrollDecelerationRate() {
    NSInteger sensitivity = [[NSUserDefaults standardUserDefaults] integerForKey:kScrollSensitivityKey];
    
    if (sensitivity == 0) {
        sensitivity = 3;
    }
    
    switch (sensitivity) {
        case 1:
            return 0.998;
        case 2:
            return 0.9998;
        case 3:
            return 0.999;
        default:
            return 0.999;
    }
}

static BOOL isScrollAnimationEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kScrollAnimationEnabledKey];
}

static void loadSettings() {
    NSDate *now = [NSDate date];
    if (gLastSettingsUpdateTime && 
        [now timeIntervalSinceDate:gLastSettingsUpdateTime] < kSettingsCacheExpireTime) {
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    gFilterDuplicateContacts = [defaults boolForKey:kFilterDuplicateContactsKey];
    gHideGroupBadge = [defaults boolForKey:kHideGroupBadgeKey];
    gHideAllBadge = [defaults boolForKey:kHideAllBadgeKey];
    gSwipeGestureEnabled = [defaults boolForKey:kSwipeGestureEnabledKey];
    gLastSettingsUpdateTime = now;
}

static BOOL shouldFilterDuplicateContacts() {
    loadSettings();
    return gFilterDuplicateContacts;
}

static BOOL shouldHideGroupBadge() {
    loadSettings();
    return gHideGroupBadge;
}

static BOOL shouldHideAllBadge() {
    loadSettings();
    return gHideAllBadge;
}

static BOOL isSwipeGestureEnabled() {
    loadSettings();
    return gSwipeGestureEnabled;
}

static void clearSettingsCache() {
    gLastSettingsUpdateTime = nil;
}

#pragma mark - 微信类声明

@class CContact, WCSearchBar;

@interface NewMainFrameViewController : NSObject
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UITableView *m_tableView;
@property (nonatomic, strong) WCSearchBar *searchBar;
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)onSearch;
@end

@interface MainFrameLogicController : NSObject
- (unsigned int)getSessionCount;
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)indexPath;
- (unsigned int)getTotalUnreadCount;
@end

@interface MMNewSessionMgr : NSObject
- (unsigned int)GetSessionCount;
- (id)GetSessionAtIndex:(unsigned int)arg1;
- (id)GetSessionInfoList;
@end

@interface MMSessionInfo : NSObject
@property (nonatomic, copy) NSString *m_nsUserName;
@property (nonatomic, strong) CContact *m_contact;
@property (nonatomic, assign) unsigned int m_uUnReadCount;
@end

@interface CContact : NSObject
@property (nonatomic, copy) NSString *m_nsUsrName;
@property (nonatomic, copy) NSString *m_nsChatRoomMemList;
@property (nonatomic, assign) unsigned int m_uiChatRoomStatus;
@property (nonatomic, assign) unsigned int m_uiCertificationFlag;
@end

#pragma mark - 会话类型判断辅助函数

/**
 判断是否为群聊会话
 @param contact 联系人对象
 @return YES表示群聊，NO表示非群聊
 */
static BOOL isGroupChat(id contact) {
    if (!contact) return NO;
    
    NSString *userName = nil;
    if ([contact respondsToSelector:@selector(m_nsUsrName)]) {
        userName = [contact m_nsUsrName];
    }
    
    if (!userName) return NO;
    
    // 群聊判断规则:
    // 1. @chatroom 结尾
    // 2. chatroom_session_box
    return [userName hasSuffix:@"@chatroom"] || [userName isEqualToString:@"chatroom_session_box"];
}

/**
 判断是否为公众号会话
 @param contact 联系人对象
 @return YES表示公众号，NO表示非公众号
 */
static BOOL isOfficialAccount(id contact) {
    if (!contact) return NO;
    
    NSString *userName = nil;
    if ([contact respondsToSelector:@selector(m_nsUsrName)]) {
        userName = [contact m_nsUsrName];
    }
    
    if (!userName) return NO;
    
    // 公众号判断规则:
    // 1. gh_ 开头
    // 2. newsapp
    // 3. brandsessionholder
    // 4. brandservicesessionholder
    // 5. weixin
    // 6. filehelper
    // 7. notification_messages
    return [userName hasPrefix:@"gh_"] ||
           [userName isEqualToString:@"newsapp"] ||
           [userName isEqualToString:@"brandsessionholder"] ||
           [userName isEqualToString:@"brandservicesessionholder"] ||
           [userName isEqualToString:@"weixin"] ||
           [userName isEqualToString:@"filehelper"] ||
           [userName isEqualToString:@"notification_messages"];
}

/**
 判断是否为私聊会话
 @param contact 联系人对象
 @return YES表示私聊，NO表示非私聊
 */
static BOOL isPrivateChat(id contact) {
    if (!contact) return NO;
    
    // 私聊 = 非群聊 且 非公众号
    return !isGroupChat(contact) && !isOfficialAccount(contact);
}

/**
 获取自定义分组
 @return 自定义分组数组
 */
static NSArray<WESessionTabItem *> *getCustomTabs() {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCustomTabsKey];
    if (data) {
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return array ?: @[];
    }
    return @[];
}

/**
 获取所有自定义分组中的会话用户名
 @param isGroup 是否获取群聊
 @return 用户名集合
 */
static NSSet<NSString *> *getCustomTabSessionUserNames(BOOL isGroup) {
    NSDate *now = [NSDate date];
    if (gLastCustomTabCacheTime && 
        [now timeIntervalSinceDate:gLastCustomTabCacheTime] < kCacheExpireTime) {
        return isGroup ? gCachedGroupUserNames : gCachedPrivateUserNames;
    }
    
    NSMutableSet<NSString *> *groupUserNames = [NSMutableSet set];
    NSMutableSet<NSString *> *privateUserNames = [NSMutableSet set];
    
    NSArray<WESessionTabItem *> *customTabs = getCustomTabs();
    
    NSMutableDictionary *contactsCache = [NSMutableDictionary dictionary];
    Class contactMgrClass = objc_getClass("CContactMgr");
    if (contactMgrClass) {
        id contactMgr = CSGetService(contactMgrClass);
        if (contactMgr) {
            for (WESessionTabItem *tab in customTabs) {
                for (NSString *userName in tab.sessionUserNames) {
                    if (!contactsCache[userName]) {
                        SEL getContactSelector = NSSelectorFromString(@"getContactByName:");
                        if ([contactMgr respondsToSelector:getContactSelector]) {
                            id contact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, getContactSelector, userName);
                            if (contact) {
                                contactsCache[userName] = contact;
                            }
                        }
                    }
                }
            }
        }
    }
    
    for (NSString *userName in contactsCache) {
        id contact = contactsCache[userName];
        if (isGroupChat(contact)) {
            [groupUserNames addObject:userName];
        } else if (isPrivateChat(contact)) {
            [privateUserNames addObject:userName];
        }
    }
    
    gCachedGroupUserNames = [groupUserNames copy];
    gCachedPrivateUserNames = [privateUserNames copy];
    gLastCustomTabCacheTime = now;
    
    return isGroup ? gCachedGroupUserNames : gCachedPrivateUserNames;
}

static void clearCustomTabCache() {
    gCachedGroupUserNames = nil;
    gCachedPrivateUserNames = nil;
    gLastCustomTabCacheTime = nil;
}

/**
 根据Tab类型判断会话是否应该显示
 @param sessionInfo 会话信息对象
 @param tabType Tab类型
 @param currentTab 当前Tab对象（用于自定义分组）
 @return YES表示应该显示，NO表示应该隐藏
 */
static BOOL shouldShowSession(id sessionInfo, WETabType tabType, WESessionTabItem *currentTab) {
    if (!sessionInfo) return YES;
    
    id contact = nil;
    if ([sessionInfo respondsToSelector:@selector(m_contact)]) {
        contact = [sessionInfo m_contact];
    }
    
    BOOL filterDuplicate = shouldFilterDuplicateContacts();
    
    switch (tabType) {
        case WETabTypeAll:
            return YES;
        case WETabTypeGroup: {
            if (!isGroupChat(contact)) return NO;
            
            // 如果开启过滤重复联系人，检查是否在自定义分组中
            if (filterDuplicate) {
                NSString *userName = nil;
                if ([contact respondsToSelector:@selector(m_nsUsrName)]) {
                    userName = [contact m_nsUsrName];
                }
                if (userName) {
                    NSSet<NSString *> *customGroupUserNames = getCustomTabSessionUserNames(YES);
                    if ([customGroupUserNames containsObject:userName]) {
                        return NO;
                    }
                }
            }
            return YES;
        }
        case WETabTypePrivate: {
            if (!isPrivateChat(contact)) return NO;
            
            // 如果开启过滤重复联系人，检查是否在自定义分组中
            if (filterDuplicate) {
                NSString *userName = nil;
                if ([contact respondsToSelector:@selector(m_nsUsrName)]) {
                    userName = [contact m_nsUsrName];
                }
                if (userName) {
                    NSSet<NSString *> *customPrivateUserNames = getCustomTabSessionUserNames(NO);
                    if ([customPrivateUserNames containsObject:userName]) {
                        return NO;
                    }
                }
            }
            return YES;
        }
        case WETabTypeOfficial:
            return isOfficialAccount(contact);
        case WETabTypeCustom: {
            if (!currentTab || !currentTab.sessionUserNames) return NO;
            
            NSString *userName = nil;
            if ([contact respondsToSelector:@selector(m_nsUsrName)]) {
                userName = [contact m_nsUsrName];
            }
            if (!userName) return NO;
            
            return [currentTab.sessionUserNames containsObject:userName];
        }
        default:
            return YES;
    }
}

static NSArray<WESessionTabItem *> *getPresetTabs() {
    NSDictionary *presetNames = nil;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kPresetTabNamesKey];
    if (data) {
        presetNames = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    NSDictionary *presetTabsDict = @{
        @"preset_0": [WESessionTabItem tabWithType:WETabTypeAll],
        @"preset_1": [WESessionTabItem tabWithType:WETabTypeGroup],
        @"preset_2": [WESessionTabItem tabWithType:WETabTypePrivate],
        @"preset_3": [WESessionTabItem tabWithType:WETabTypeOfficial]
    };
    
    for (NSString *tabId in presetTabsDict) {
        WESessionTabItem *tab = presetTabsDict[tabId];
        NSString *customName = presetNames[tabId];
        if (customName.length > 0) {
            tab.tabName = customName;
        }
    }
    
    return presetTabsDict.allValues;
}

static NSArray<WESessionTabItem *> *getAllTabs() {
    NSDate *now = [NSDate date];
    if (gLastTabsCacheTime && 
        [now timeIntervalSinceDate:gLastTabsCacheTime] < kCacheExpireTime) {
        return gCachedTabs;
    }
    
    NSArray *savedOrder = [[NSUserDefaults standardUserDefaults] objectForKey:kTabOrderKey];
    NSArray *hiddenPresetTabs = [[NSUserDefaults standardUserDefaults] objectForKey:kHiddenPresetTabsKey];
    NSSet *hiddenSet = [NSSet setWithArray:hiddenPresetTabs ?: @[]];
    
    NSMutableDictionary *allTabsDict = [NSMutableDictionary dictionary];
    
    NSArray<WESessionTabItem *> *presetTabs = getPresetTabs();
    for (WESessionTabItem *tab in presetTabs) {
        NSString *tabId = [NSString stringWithFormat:@"preset_%ld", (long)tab.type];
        allTabsDict[tabId] = tab;
    }
    
    NSArray<WESessionTabItem *> *customTabs = getCustomTabs();
    for (WESessionTabItem *tab in customTabs) {
        allTabsDict[tab.tabId] = tab;
    }
    
    NSMutableArray *orderedTabs = [NSMutableArray array];
    
    if (savedOrder && savedOrder.count > 0) {
        for (NSString *tabId in savedOrder) {
            if ([tabId hasPrefix:@"preset_"] && [hiddenSet containsObject:tabId]) {
                continue;
            }
            WESessionTabItem *tab = allTabsDict[tabId];
            if (tab) {
                [orderedTabs addObject:tab];
            }
        }
    } else {
        for (WESessionTabItem *tab in presetTabs) {
            NSString *tabId = [NSString stringWithFormat:@"preset_%ld", (long)tab.type];
            if (![hiddenSet containsObject:tabId]) {
                [orderedTabs addObject:tab];
            }
        }
        [orderedTabs addObjectsFromArray:customTabs];
    }
    
    gCachedTabs = [orderedTabs copy];
    gLastTabsCacheTime = now;
    
    return gCachedTabs;
}

static void clearTabsCache() {
    gCachedTabs = nil;
    gLastTabsCacheTime = nil;
}

static void reloadChatGroupSettings(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
}

#pragma mark - 布局辅助函数

static void updateTabContainerLayout(id self) {
    WESessionTabContainerView *tabContainer = objc_getAssociatedObject(self, (__bridge const void *)(kTabContainerViewKey));
    if (!tabContainer) {
        return;
    }

    UITableView *tableView = [self valueForKey:@"m_tableView"];
    UIView *view = [self valueForKey:@"view"];
    if (!tableView || !view) {
        return;
    }

    CGFloat containerWidth = view.bounds.size.width;
    CGFloat tabHeight = 52.0;

    tabContainer.frame = CGRectMake(0, 0, containerWidth, tabHeight);

    if (tableView.tableHeaderView != tabContainer) {
        tableView.tableHeaderView = tabContainer;
    }
}

static NSDictionary *calculateAllUnreadCounts(MainFrameLogicController *logicController, NSArray<WESessionTabItem *> *tabs) {
    NSDate *now = [NSDate date];
    if (gLastUnreadUpdateTime && 
        [now timeIntervalSinceDate:gLastUnreadUpdateTime] < kUnreadCacheExpireTime) {
        return gUnreadCountCache;
    }
    
    NSMutableDictionary *unreadCounts = [NSMutableDictionary dictionary];
    
    for (WESessionTabItem *tab in tabs) {
        unreadCounts[tab.tabId] = @0;
    }
    
    Class sessionMgrClass = objc_getClass("MMNewSessionMgr");
    if (!sessionMgrClass) return unreadCounts;
    
    id sessionMgr = CSGetService(sessionMgrClass);
    if (!sessionMgr) return unreadCounts;
    
    BOOL filterDuplicate = [[NSUserDefaults standardUserDefaults] boolForKey:kFilterDuplicateContactsKey];
    NSSet<NSString *> *customGroupUserNames = nil;
    NSSet<NSString *> *customPrivateUserNames = nil;
    
    if (filterDuplicate) {
        customGroupUserNames = getCustomTabSessionUserNames(YES);
        customPrivateUserNames = getCustomTabSessionUserNames(NO);
    }
    
    unsigned int sessionCount = (unsigned int)[sessionMgr GetSessionCount];
    
    for (unsigned int i = 0; i < sessionCount; i++) {
        id sessionInfo = [sessionMgr GetSessionAtIndex:i];
        if (!sessionInfo) continue;
        
        id contact = nil;
        if ([sessionInfo respondsToSelector:@selector(m_contact)]) {
            contact = [sessionInfo m_contact];
        }
        
        NSString *userName = nil;
        if ([contact respondsToSelector:@selector(m_nsUsrName)]) {
            userName = [contact m_nsUsrName];
        }
        
        BOOL isMuted = NO;
        if ([sessionInfo respondsToSelector:@selector(m_bShowUnReadAsRedDot)]) {
            NSNumber *mutedValue = [sessionInfo valueForKey:@"m_bShowUnReadAsRedDot"];
            isMuted = [mutedValue boolValue];
        }
        
        if (isMuted) continue;
        
        unsigned int sessionUnread = 0;
        if ([sessionInfo respondsToSelector:@selector(m_uUnReadCount)]) {
            sessionUnread = [sessionInfo m_uUnReadCount];
        }
        
        for (WESessionTabItem *tab in tabs) {
            BOOL shouldCount = NO;
            
            switch (tab.type) {
                case WETabTypeAll:
                    shouldCount = YES;
                    break;
                case WETabTypeGroup:
                    if (isGroupChat(contact)) {
                        if (filterDuplicate && userName && customGroupUserNames && [customGroupUserNames containsObject:userName]) {
                            shouldCount = NO;
                        } else {
                            shouldCount = YES;
                        }
                    }
                    break;
                case WETabTypePrivate:
                    if (isPrivateChat(contact)) {
                        if (filterDuplicate && userName && customPrivateUserNames && [customPrivateUserNames containsObject:userName]) {
                            shouldCount = NO;
                        } else {
                            shouldCount = YES;
                        }
                    }
                    break;
                case WETabTypeOfficial:
                    shouldCount = isOfficialAccount(contact);
                    break;
                case WETabTypeCustom:
                    if (tab.sessionUserNames && userName) {
                        shouldCount = [tab.sessionUserNames containsObject:userName];
                    }
                    break;
            }
            
            if (shouldCount) {
                NSNumber *currentCount = unreadCounts[tab.tabId];
                unreadCounts[tab.tabId] = @([currentCount unsignedIntValue] + sessionUnread);
            }
        }
    }
    
    gUnreadCountCache = unreadCounts;
    gLastUnreadUpdateTime = now;
    
    return unreadCounts;
}

static unsigned int calculateUnreadCountForTab(MainFrameLogicController *logicController, WESessionTabItem *tab) {
    if (!tab) return 0;
    
    if (tab.type == WETabTypeAll) {
        if (logicController) {
            return (unsigned int)[logicController getTotalUnreadCount];
        }
    }
    
    NSArray<WESessionTabItem *> *tabs = getAllTabs();
    NSDictionary *unreadCounts = calculateAllUnreadCounts(logicController, tabs);
    
    NSNumber *count = unreadCounts[tab.tabId];
    return count ? [count unsignedIntValue] : 0;
}

static void clearUnreadCache() {
    gUnreadCountCache = nil;
    gLastUnreadUpdateTime = nil;
}

/**
 计算并缓存指定 section 的可见行索引
 @param logicController 逻辑控制器
 @param tableView 表格视图
 @param currentTab 当前Tab
 @param section 指定的 section
 */
static void calculateAndCacheVisibleRowsForSection(id logicController, UITableView *tableView, WESessionTabItem *currentTab, NSInteger section) {
    if (!logicController || !tableView || !currentTab) return;
    
    NSInteger totalRows = [tableView numberOfRowsInSection:section];
    
    NSInteger firstVisibleRow = -1;
    NSInteger lastVisibleRow = -1;
    
    for (NSInteger r = 0; r < totalRows; r++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:r inSection:section];
        id tempSessionInfo = nil;
        @try {
            tempSessionInfo = [logicController getSessionInfoAtIndexPath:tempIndexPath];
        } @catch (NSException *exception) {
            continue;
        }
        
        if (tempSessionInfo && shouldShowSession(tempSessionInfo, currentTab.type, currentTab)) {
            if (firstVisibleRow == -1) firstVisibleRow = r;
            lastVisibleRow = r;
        }
    }
    
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%ld_%ld", kVisibleRowsCacheKey, (long)currentTab.type, (long)section];
    if (!gVisibleRowsCache) {
        gVisibleRowsCache = [NSMutableDictionary dictionary];
    }
    
    gVisibleRowsCache[cacheKey] = @{
        @"first": @(firstVisibleRow),
        @"last": @(lastVisibleRow)
    };
}

/**
 获取缓存的指定 section 的可见行索引
 @param currentTab 当前Tab
 @param section 指定的 section
 @return 包含 first 和 last 的字典，如果没有缓存返回 nil
 */
static NSDictionary *getCachedVisibleRowsForSection(WESessionTabItem *currentTab, NSInteger section) {
    if (!currentTab) return nil;
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%ld_%ld", kVisibleRowsCacheKey, (long)currentTab.type, (long)section];
    return gVisibleRowsCache[cacheKey];
}

/**
 清除可见行缓存
 */
static void clearVisibleRowsCache() {
    gVisibleRowsCache = nil;
}

/**
 获取缓存的圆角路径
 @param rect 矩形区域
 @param cornerRadius 圆角半径
 @param corners 圆角位置
 @return 缓存的 UIBezierPath
 */
static UIBezierPath *getCachedBezierPath(CGRect rect, CGFloat cornerRadius, UIRectCorner corners) {
    if (!gCornerRadiusCache) {
        gCornerRadiusCache = [NSMutableDictionary dictionary];
    }
    
    NSString *key = [NSString stringWithFormat:@"%.0f_%.0f_%.0f_%.0f_%.1f_%ld",
                     rect.origin.x, rect.origin.y, rect.size.width, rect.size.height,
                     cornerRadius, (long)corners];
    
    UIBezierPath *path = gCornerRadiusCache[key];
    if (!path || !CGRectEqualToRect(path.bounds, rect)) {
        if (corners == 0) {
            path = [UIBezierPath bezierPathWithRect:rect];
        } else {
            path = [UIBezierPath bezierPathWithRoundedRect:rect
                                             byRoundingCorners:corners
                                                   cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
        gCornerRadiusCache[key] = path;
    }
    
    return path;
}

/**
 清除圆角缓存
 */
static void clearCornerRadiusCache() {
    gCornerRadiusCache = nil;
}

static void updateUnreadBadge(id self) {
    NSTimer *existingTimer = objc_getAssociatedObject(self, (__bridge const void *)(kUnreadDebounceKey));
    if (existingTimer) {
        [existingTimer invalidate];
    }
    
    __weak typeof(self) weakSelf = self;
    NSTimer *debounceTimer = [NSTimer scheduledTimerWithTimeInterval:kUnreadDebounceTime repeats:NO block:^(NSTimer * _Nonnull timer) {
        if (!weakSelf) return;
        
        objc_setAssociatedObject(weakSelf, (__bridge const void *)(kUnreadDebounceKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        WESessionTabContainerView *tabContainer = objc_getAssociatedObject(weakSelf, (__bridge const void *)(kTabContainerViewKey));
        if (!tabContainer) {
            return;
        }
        
        MainFrameLogicController *logicController = [weakSelf valueForKey:@"m_mainFrameLogicController"];
        if (!logicController) {
            return;
        }
        
        NSArray<WESessionTabItem *> *tabs = objc_getAssociatedObject(weakSelf, (__bridge const void *)(kCurrentTabsKey));
        if (!tabs || tabs.count == 0) {
            return;
        }
        
        BOOL hideGroupBadge = shouldHideGroupBadge();
        BOOL hideAllBadge = shouldHideAllBadge();
        
        for (NSInteger i = 0; i < tabs.count; i++) {
            WESessionTabItem *tab = tabs[i];
            
            if (tab.type == WETabTypeAll) {
                if (hideAllBadge) {
                    [tabContainer updateUnreadCount:0 forTabIndex:i];
                } else {
                    unsigned int unreadCount = calculateUnreadCountForTab(logicController, tab);
                    [tabContainer updateUnreadCount:unreadCount forTabIndex:i];
                }
            } else {
                if (hideGroupBadge) {
                    [tabContainer updateUnreadCount:0 forTabIndex:i];
                } else {
                    unsigned int unreadCount = calculateUnreadCountForTab(logicController, tab);
                    [tabContainer updateUnreadCount:unreadCount forTabIndex:i];
                }
            }
        }
    }];
    
    objc_setAssociatedObject(self, (__bridge const void *)(kUnreadDebounceKey), debounceTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%hook NewMainFrameViewController

- (void)dealloc {
    NSTimer *timer = objc_getAssociatedObject(self, (__bridge const void *)(kUnreadDebounceKey));
    if (timer) {
        [timer invalidate];
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)(kTabContainerViewKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)(kCurrentTabsKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)(kCurrentTabIndexKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)(kUnreadDebounceKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)(kLogicControllerKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    %orig;
}

- (void)viewDidLoad {
    %orig;

    if (isChatGroupEnabled()) {
        clearVisibleRowsCache();
        clearCornerRadiusCache();
        
        UIView *searchBar = [self valueForKey:@"searchBar"];
        if (searchBar) {
            searchBar.hidden = YES;
            searchBar.frame = CGRectZero;
        }
        
        WESessionTabContainerView *tabContainer = [[WESessionTabContainerView alloc] init];
        objc_setAssociatedObject(self, (__bridge const void *)(kTabContainerViewKey), tabContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        NSArray *tabs = getAllTabs();
        
        objc_setAssociatedObject(self, (__bridge const void *)(kCurrentTabsKey), tabs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, (__bridge const void *)(kCurrentTabIndexKey), @0, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        tabContainer.hidden = NO;
        [tabContainer updateTabs:tabs];
        
        UITableView *tableView = [self valueForKey:@"m_tableView"];
        if (tableView) {
            objc_setAssociatedObject(tableView, (__bridge const void *)(kCurrentTabsKey), tabs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            objc_setAssociatedObject(tableView, (__bridge const void *)(kCurrentTabIndexKey), @0, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            CGFloat containerWidth = tableView.bounds.size.width;
            tabContainer.frame = CGRectMake(0, 0, containerWidth, kTabHeight);
            tableView.tableHeaderView = tabContainer;
            
            tableView.decelerationRate = getScrollDecelerationRate();
            tableView.scrollsToTop = YES;
            
            [self performSelector:@selector(setupSwipeGesturesForTableView:) withObject:tableView];
        }

        __weak typeof(self) weakSelf = self;
        tabContainer.onTabSelected = ^(NSInteger index) {
            objc_setAssociatedObject(weakSelf, (__bridge const void *)(kCurrentTabIndexKey), @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            clearVisibleRowsCache();
            clearCornerRadiusCache();
            
            UITableView *tableView = [weakSelf valueForKey:@"m_tableView"];
            if (tableView) {
                objc_setAssociatedObject(tableView, (__bridge const void *)(kCurrentTabIndexKey), @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                gIsTabSwitching = YES;
                [tableView reloadData];
                gIsTabSwitching = NO;
            }
        };

        tabContainer.onAddButtonTapped = ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新建分组"
                                                                           message:@"请输入分组名称"
                                                                    preferredStyle:UIAlertControllerStyleAlert];

            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"分组名称";
            }];

            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSString *name = alert.textFields.firstObject.text;
                if (name.length > 0) {
                    WESessionTabItem *tab = [WESessionTabItem customTabWithName:name sessionUserNames:@[]];

                    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCustomTabsKey];
                    NSMutableArray *customTabs = [NSMutableArray array];
                    if (data) {
                        NSArray *existingTabs = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                        if (existingTabs) {
                            [customTabs addObjectsFromArray:existingTabs];
                        }
                    }
                    [customTabs addObject:tab];

                    NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:customTabs];
                    [[NSUserDefaults standardUserDefaults] setObject:newData forKey:kCustomTabsKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];

                    NSArray *newTabs = getAllTabs();
                    objc_setAssociatedObject(weakSelf, (__bridge const void *)(kCurrentTabsKey), newTabs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

                    WESessionTabContainerView *container = objc_getAssociatedObject(weakSelf, (__bridge const void *)(kTabContainerViewKey));
                    if (container) {
                        [container updateTabs:newTabs];
                    }
                }
            }]];

            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            if (rootVC) {
                [rootVC presentViewController:alert animated:YES completion:nil];
            }
        };

        tabContainer.onSearchButtonTapped = ^{
            [weakSelf onSearch];
        };
    }
}

%new
- (void)setupSwipeGesturesForTableView:(UITableView *)tableView {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kSwipeGestureEnabledKey]) {
        return;
    }
    
    static void *kPanGestureKey = &kPanGestureKey;
    
    UIPanGestureRecognizer *existingPan = objc_getAssociatedObject(tableView, kPanGestureKey);
    
    if (existingPan) {
        [tableView removeGestureRecognizer:existingPan];
    }
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    pan.delegate = (id<UIGestureRecognizerDelegate>)self;
    pan.minimumNumberOfTouches = 1;
    pan.maximumNumberOfTouches = 1;
    objc_setAssociatedObject(tableView, kPanGestureKey, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [tableView addGestureRecognizer:pan];
}

%new
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    UITableView *tableView = [self valueForKey:@"m_tableView"];
    if (!tableView) return YES;
    
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint translation = [panGesture translationInView:tableView];
    
    if (fabs(translation.x) < fabs(translation.y)) {
        return NO;
    }
    
    CGPoint location = [gestureRecognizer locationInView:tableView];
    CGFloat screenWidth = tableView.bounds.size.width;
    CGFloat edgeThreshold = 80.0;
    
    if (location.x >= screenWidth - edgeThreshold) {
        return NO;
    }
    
    return YES;
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

%new
- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kSwipeGestureEnabledKey]) {
        return;
    }
    
    UITableView *tableView = [self valueForKey:@"m_tableView"];
    if (!tableView) return;
    
    CGPoint translation = [gesture translationInView:tableView];
    CGPoint velocity = [gesture velocityInView:tableView];
    CGFloat swipeThreshold = 20.0;
    CGFloat velocityThreshold = 300.0;
    
    BOOL shouldTriggerLeft = translation.x < -swipeThreshold || velocity.x < -velocityThreshold;
    BOOL shouldTriggerRight = translation.x > swipeThreshold || velocity.x > velocityThreshold;
    
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (shouldTriggerLeft) {
            NSNumber *tabIndexNumber = objc_getAssociatedObject(tableView, (__bridge const void *)(kCurrentTabIndexKey));
            NSInteger currentIndex = tabIndexNumber ? tabIndexNumber.integerValue : 0;
            
            NSArray *tabs = objc_getAssociatedObject(tableView, (__bridge const void *)(kCurrentTabsKey));
            if (tabs && currentIndex < tabs.count - 1) {
                NSInteger newIndex = currentIndex + 1;
                objc_setAssociatedObject(tableView, (__bridge const void *)(kCurrentTabIndexKey), @(newIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                objc_setAssociatedObject(self, (__bridge const void *)(kCurrentTabIndexKey), @(newIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
                WESessionTabContainerView *container = objc_getAssociatedObject(self, (__bridge const void *)(kTabContainerViewKey));
                if (container) {
                    [container selectTabAtIndex:newIndex animated:YES];
                }
                
                gIsTabSwitching = YES;
                [tableView reloadData];
                gIsTabSwitching = NO;
            }
        } else if (shouldTriggerRight) {
            NSNumber *tabIndexNumber = objc_getAssociatedObject(tableView, (__bridge const void *)(kCurrentTabIndexKey));
            NSInteger currentIndex = tabIndexNumber ? tabIndexNumber.integerValue : 0;
            
            if (currentIndex > 0) {
                NSInteger newIndex = currentIndex - 1;
                objc_setAssociatedObject(tableView, (__bridge const void *)(kCurrentTabIndexKey), @(newIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                objc_setAssociatedObject(self, (__bridge const void *)(kCurrentTabIndexKey), @(newIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
                WESessionTabContainerView *container = objc_getAssociatedObject(self, (__bridge const void *)(kTabContainerViewKey));
                if (container) {
                    [container selectTabAtIndex:newIndex animated:YES];
                }
                
                gIsTabSwitching = YES;
                [tableView reloadData];
                gIsTabSwitching = NO;
            }
        }
    }
}

- (void)viewDidLayoutSubviews {
    %orig;

    if (isChatGroupEnabled()) {
        UIView *view = [self valueForKey:@"view"];
        CGRect currentBounds = view.bounds;
        
        BOOL chatGroupEnabled = isChatGroupEnabled();
        BOOL listCornerRadiusEnabled = isListCornerRadiusEnabled();
        
        WESessionTabContainerView *tabContainer = objc_getAssociatedObject(self, (__bridge const void *)(kTabContainerViewKey));
        UITableView *tableView = [self valueForKey:@"m_tableView"];
        
        if (tabContainer && tableView) {
            if (!CGRectEqualToRect(currentBounds, gLastViewBounds) || chatGroupEnabled != gLastChatGroupEnabled) {
                if (tableView.tableHeaderView != tabContainer) {
                    CGFloat containerWidth = tableView.bounds.size.width;
                    tabContainer.frame = CGRectMake(0, 0, containerWidth, kTabHeight);
                    tableView.tableHeaderView = tabContainer;
                }
                
                NSTimer *debounceTimer = objc_getAssociatedObject(self, (__bridge const void *)(kLayoutDebounceKey));
                if (debounceTimer) {
                    [debounceTimer invalidate];
                }
                
                __weak typeof(self) weakSelf = self;
                debounceTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:NO block:^(NSTimer * _Nonnull timer) {
                    if (weakSelf) {
                        updateTabContainerLayout(weakSelf);
                    }
                }];
                objc_setAssociatedObject(self, (__bridge const void *)(kLayoutDebounceKey), debounceTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
                gLastViewBounds = currentBounds;
                gLastChatGroupEnabled = chatGroupEnabled;
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;

    if (isChatGroupEnabled()) {
        UIView *searchBar = [self valueForKey:@"searchBar"];
        if (searchBar) {
            searchBar.hidden = YES;
            searchBar.frame = CGRectZero;
        }
        
        updateTabContainerLayout(self);
        updateUnreadBadge(self);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    %orig;
    
    if (isChatGroupEnabled()) {
        UIView *searchBar = [self valueForKey:@"searchBar"];
        if (searchBar) {
            searchBar.hidden = YES;
            searchBar.frame = CGRectZero;
        }
        
        updateUnreadBadge(self);
    }
}

- (void)newMessageByContact:(id)arg1 msgWrapToAdd:(id)arg2 {
    %orig;
    
    if (isChatGroupEnabled()) {
        clearVisibleRowsCache();
        clearCornerRadiusCache();
        clearUnreadCache();
        updateUnreadBadge(self);
    }
}

- (void)updateSession:(id)arg1 {
    %orig;
    
    if (isChatGroupEnabled()) {
        clearVisibleRowsCache();
        clearCornerRadiusCache();
        updateUnreadBadge(self);
    }
}

- (void)reloadSessions {
    %orig;
    
    if (isChatGroupEnabled()) {
        clearVisibleRowsCache();
        clearCornerRadiusCache();
        updateUnreadBadge(self);
    }
}

- (void)updateItem:(id)arg1 {
    %orig;
    
    if (isChatGroupEnabled()) {
        clearVisibleRowsCache();
        updateUnreadBadge(self);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    %orig;
    
    if (isChatGroupEnabled() && [scrollView isKindOfClass:[UITableView class]]) {
        UIView *searchBar = [self valueForKey:@"searchBar"];
        if (searchBar) {
            searchBar.hidden = YES;
            searchBar.frame = CGRectZero;
        }
        
        UITableView *tableView = (UITableView *)scrollView;
        CGFloat offsetY = scrollView.contentOffset.y;
        
        if (offsetY <= 0) {
            WESessionTabContainerView *tabContainer = objc_getAssociatedObject(self, (__bridge const void *)(kTabContainerViewKey));
            if (tabContainer && tableView.tableHeaderView != tabContainer) {
                CGFloat containerWidth = tableView.bounds.size.width;
                tabContainer.frame = CGRectMake(0, 0, containerWidth, kTabHeight);
                tableView.tableHeaderView = tabContainer;
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    %orig;
    
    if (isChatGroupEnabled() && [scrollView isKindOfClass:[UITableView class]]) {
        gIsVerticalScrolling = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    %orig;
    
    if (isChatGroupEnabled() && [scrollView isKindOfClass:[UITableView class]]) {
        if (!decelerate) {
            gIsVerticalScrolling = NO;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    %orig;
    
    if (isChatGroupEnabled() && [scrollView isKindOfClass:[UITableView class]]) {
        gIsVerticalScrolling = NO;
    }
}

%end

#pragma mark - Hook TableView显示逻辑

%hook NewMainFrameViewController

/**
 Hook willDisplayCell方法，在cell即将显示时控制其可见性
 这是实现分组功能的核心逻辑
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    %orig;
    
    if (!isChatGroupEnabled()) return;
    
    // 使用静态变量缓存 Associated Object key 指针，避免重复桥接转换
    static void *kCurrentTabIndexKeyPtr = NULL;
    static void *kCurrentTabsKeyPtr = NULL;
    static void *kLogicControllerKeyPtr = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kCurrentTabIndexKeyPtr = (__bridge void *)kCurrentTabIndexKey;
        kCurrentTabsKeyPtr = (__bridge void *)kCurrentTabsKey;
        kLogicControllerKeyPtr = (__bridge void *)kLogicControllerKey;
    });
    
    NSNumber *tabIndexNumber = objc_getAssociatedObject(tableView, kCurrentTabIndexKeyPtr);
    NSInteger tabIndex = tabIndexNumber ? [tabIndexNumber integerValue] : 0;
    
    NSArray *tabs = objc_getAssociatedObject(tableView, kCurrentTabsKeyPtr);
    if (!tabs || tabIndex >= tabs.count) return;
    
    WESessionTabItem *currentTab = tabs[tabIndex];
    WETabType tabType = currentTab.type;
    
    if (tabType == WETabTypeAll) {
        cell.hidden = NO;
        
        if (isScrollAnimationEnabled() && gIsVerticalScrolling && !gIsTabSwitching) {
            cell.alpha = 0;
            cell.transform = CGAffineTransformMakeScale(0.3, 0.3);
            
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                cell.alpha = 1.0;
                cell.transform = CGAffineTransformIdentity;
            } completion:nil];
        } else {
            cell.alpha = 1.0;
        }
        return;
    }
    
    id logicController = objc_getAssociatedObject(self, kLogicControllerKeyPtr);
    if (!logicController) {
        logicController = [self valueForKey:@"m_mainFrameLogicController"];
        if (logicController) {
            objc_setAssociatedObject(self, kLogicControllerKeyPtr, logicController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    if (!logicController) return;
    
    id sessionInfo = nil;
    @try {
        sessionInfo = [logicController getSessionInfoAtIndexPath:indexPath];
    } @catch (NSException *exception) {
        return;
    }
    if (!sessionInfo) return;
    
    BOOL shouldShow = shouldShowSession(sessionInfo, tabType, currentTab);
    
    if (shouldShow) {
        cell.hidden = NO;
        
        if (isScrollAnimationEnabled() && gIsVerticalScrolling && !gIsTabSwitching) {
            cell.alpha = 0;
            cell.transform = CGAffineTransformMakeScale(0.3, 0.3);
            
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                cell.alpha = 1.0;
                cell.transform = CGAffineTransformIdentity;
            } completion:nil];
        } else {
            cell.alpha = 1.0;
        }
        
        if (isListCornerRadiusEnabled()) {
            CGFloat cornerRadius = getListCornerRadius();
            NSInteger section = indexPath.section;
            NSInteger row = indexPath.row;
            
            // 使用缓存的可见行索引，避免重复遍历
            NSDictionary *visibleRows = getCachedVisibleRowsForSection(currentTab, section);
            if (!visibleRows) {
                // 如果没有缓存，先计算并缓存
                calculateAndCacheVisibleRowsForSection(logicController, tableView, currentTab, section);
                visibleRows = getCachedVisibleRowsForSection(currentTab, section);
            }
            
            if (visibleRows) {
                NSInteger firstVisibleRow = [visibleRows[@"first"] integerValue];
                NSInteger lastVisibleRow = [visibleRows[@"last"] integerValue];
                BOOL isFirstVisible = (row == firstVisibleRow);
                BOOL isLastVisible = (row == lastVisibleRow);
                
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
                
                for (UIView *subview in cell.subviews) {
                    NSString *className = NSStringFromClass([subview class]);
                    if ([className containsString:@"Separator"] || [className containsString:@"Line"]) {
                        subview.hidden = YES;
                        subview.alpha = 0;
                    }
                    if ([className isEqualToString:@"UIView"] && subview.frame.size.height < 1.0) {
                        subview.hidden = YES;
                        subview.alpha = 0;
                    }
                }
                
                cell.separatorInset = UIEdgeInsetsMake(0, tableView.bounds.size.width, 0, 0);
                cell.layoutMargins = UIEdgeInsetsZero;
                cell.preservesSuperviewLayoutMargins = NO;
                
                for (UIView *subview in cell.contentView.subviews) {
                    if ([subview isKindOfClass:[UIView class]] && subview.tag != 9997) {
                        subview.backgroundColor = [UIColor clearColor];
                    }
                }
                
                UIView *bgView = [cell.contentView viewWithTag:9997];
                if (!bgView) {
                    bgView = [[UIView alloc] init];
                    bgView.tag = 9997;
                    bgView.layer.masksToBounds = YES;
                    [cell.contentView insertSubview:bgView atIndex:0];
                }
                
                CGFloat leftMargin = getListLeftMargin();
                CGFloat rightMargin = getListRightMargin();
                CGFloat bgWidth = tableView.bounds.size.width - leftMargin - rightMargin;
                CGFloat bgHeight = cell.bounds.size.height;
                
                bgView.backgroundColor = [UIColor whiteColor];
                bgView.frame = CGRectMake(leftMargin, 0, bgWidth, bgHeight);
                
                // 使用缓存的圆角路径，避免重复创建
                CGRect pathRect = CGRectMake(0, 0, bgWidth, bgHeight);
                UIRectCorner corners = 0;
                
                if (firstVisibleRow == lastVisibleRow) {
                    corners = UIRectCornerAllCorners;
                } else if (isFirstVisible) {
                    corners = UIRectCornerTopLeft | UIRectCornerTopRight;
                } else if (isLastVisible) {
                    corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
                }
                
                UIBezierPath *path = getCachedBezierPath(pathRect, cornerRadius, corners);
                
                CAShapeLayer *maskLayer = [CAShapeLayer layer];
                maskLayer.path = path.CGPath;
                bgView.layer.mask = maskLayer;
            }
        }
    } else {
        // heightForRow 已经返回极小值，这里确保 cell 完全不可见
        cell.hidden = YES;
        cell.alpha = 0.0;
        cell.clipsToBounds = YES;
    }
}

/**
 Hook heightForRowAtIndexPath方法，隐藏的cell返回极小值避免堆叠
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat originalHeight = %orig;
    
    if (!isChatGroupEnabled()) return originalHeight;
    
    // 使用静态变量缓存 Associated Object key 指针，避免重复桥接转换
    static void *kCurrentTabIndexKeyPtr = NULL;
    static void *kCurrentTabsKeyPtr = NULL;
    static void *kLogicControllerKeyPtr = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kCurrentTabIndexKeyPtr = (__bridge void *)kCurrentTabIndexKey;
        kCurrentTabsKeyPtr = (__bridge void *)kCurrentTabsKey;
        kLogicControllerKeyPtr = (__bridge void *)kLogicControllerKey;
    });
    
    NSNumber *tabIndexNumber = objc_getAssociatedObject(tableView, kCurrentTabIndexKeyPtr);
    NSInteger tabIndex = tabIndexNumber ? [tabIndexNumber integerValue] : 0;
    
    NSArray *tabs = objc_getAssociatedObject(tableView, kCurrentTabsKeyPtr);
    if (!tabs || tabIndex >= tabs.count) return originalHeight;
    
    WESessionTabItem *currentTab = tabs[tabIndex];
    WETabType tabType = currentTab.type;
    
    if (tabType == WETabTypeAll) return originalHeight;
    
    id logicController = objc_getAssociatedObject(self, kLogicControllerKeyPtr);
    if (!logicController) {
        logicController = [self valueForKey:@"m_mainFrameLogicController"];
        if (logicController) {
            objc_setAssociatedObject(self, kLogicControllerKeyPtr, logicController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    if (!logicController) return originalHeight;
    
    id sessionInfo = nil;
    @try {
        sessionInfo = [logicController getSessionInfoAtIndexPath:indexPath];
    } @catch (NSException *exception) {
        return originalHeight;
    }
    if (!sessionInfo) return originalHeight;
    
    BOOL shouldShow = shouldShowSession(sessionInfo, tabType, currentTab);
    
    // 返回极小值而不是 0，避免完全堆叠
    return shouldShow ? originalHeight : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return %orig;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return %orig;
}

%end

#pragma mark - Hook MainFrameLogicController

%hook MainFrameLogicController

- (id)getSessionInfoAtIndexPath:(NSIndexPath *)indexPath {
    return %orig;
}

%end

%ctor {
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        reloadChatGroupSettings,
        CFSTR("com.wechat.enhance.chat_group.settings_changed"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
}
