// HOOK 隐藏设置页面选项
// 控制器类: NewSettingViewController
// 通过Hook设置页控制器的viewWillAppear和reloadTableData方法，在页面显示时移除不需要的Cell
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 设置键定义
static NSString * const kWCHideSettingProfileKey = @"com.wechat.tweak.hide_setting_profile";
static NSString * const kWCHideSettingAccountSecurityKey = @"com.wechat.tweak.hide_setting_account_security";
static NSString * const kWCHideSettingPrivacyKey = @"com.wechat.tweak.hide_setting_privacy";
static NSString * const kWCHideSettingNotificationKey = @"com.wechat.tweak.hide_setting_notification";
static NSString * const kWCHideSettingDisplayKey = @"com.wechat.tweak.hide_setting_display";
static NSString * const kWCHideSettingFriendPermissionKey = @"com.wechat.tweak.hide_setting_friend_permission";
static NSString * const kWCHideSettingStorageKey = @"com.wechat.tweak.hide_setting_storage";
static NSString * const kWCHideSettingMoreKey = @"com.wechat.tweak.hide_setting_more";
static NSString * const kWCHideSettingChatKey = @"com.wechat.tweak.hide_setting_chat";
static NSString * const kWCHideSettingCallKey = @"com.wechat.tweak.hide_setting_call";
static NSString * const kWCHideSettingChatHistoryKey = @"com.wechat.tweak.hide_setting_chat_history";
static NSString * const kWCHideSettingOtherKey = @"com.wechat.tweak.hide_setting_other";
static NSString * const kWCHideSettingHelpKey = @"com.wechat.tweak.hide_setting_help";
static NSString * const kWCHideSettingAboutKey = @"com.wechat.tweak.hide_setting_about";
static NSString * const kWCHideSettingPluginKey = @"com.wechat.tweak.hide_setting_plugin";
static NSString * const kWCHideSettingSwitchAccountKey = @"com.wechat.tweak.hide_setting_switch_account";
static NSString * const kWCHideSettingLogoutKey = @"com.wechat.tweak.hide_setting_logout";

// 全局设置变量
static BOOL gHideSettingProfile = NO;
static BOOL gHideSettingAccountSecurity = NO;
static BOOL gHideSettingPrivacy = NO;
static BOOL gHideSettingNotification = NO;
static BOOL gHideSettingDisplay = NO;
static BOOL gHideSettingFriendPermission = NO;
static BOOL gHideSettingStorage = NO;
static BOOL gHideSettingMore = NO;
static BOOL gHideSettingChat = NO;
static BOOL gHideSettingCall = NO;
static BOOL gHideSettingChatHistory = NO;
static BOOL gHideSettingOther = NO;
static BOOL gHideSettingHelp = NO;
static BOOL gHideSettingAbout = NO;
static BOOL gHideSettingPlugin = NO;
static BOOL gHideSettingSwitchAccount = NO;
static BOOL gHideSettingLogout = NO;

// 加载设置
static void loadSettingPageSettings() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    gHideSettingProfile = [defaults objectForKey:kWCHideSettingProfileKey] ? [defaults boolForKey:kWCHideSettingProfileKey] : NO;
    gHideSettingAccountSecurity = [defaults objectForKey:kWCHideSettingAccountSecurityKey] ? [defaults boolForKey:kWCHideSettingAccountSecurityKey] : NO;
    gHideSettingPrivacy = [defaults objectForKey:kWCHideSettingPrivacyKey] ? [defaults boolForKey:kWCHideSettingPrivacyKey] : NO;
    gHideSettingNotification = [defaults objectForKey:kWCHideSettingNotificationKey] ? [defaults boolForKey:kWCHideSettingNotificationKey] : NO;
    gHideSettingDisplay = [defaults objectForKey:kWCHideSettingDisplayKey] ? [defaults boolForKey:kWCHideSettingDisplayKey] : NO;
    gHideSettingFriendPermission = [defaults objectForKey:kWCHideSettingFriendPermissionKey] ? [defaults boolForKey:kWCHideSettingFriendPermissionKey] : NO;
    gHideSettingStorage = [defaults objectForKey:kWCHideSettingStorageKey] ? [defaults boolForKey:kWCHideSettingStorageKey] : NO;
    gHideSettingMore = [defaults objectForKey:kWCHideSettingMoreKey] ? [defaults boolForKey:kWCHideSettingMoreKey] : NO;
    gHideSettingChat = [defaults objectForKey:kWCHideSettingChatKey] ? [defaults boolForKey:kWCHideSettingChatKey] : NO;
    gHideSettingCall = [defaults objectForKey:kWCHideSettingCallKey] ? [defaults boolForKey:kWCHideSettingCallKey] : NO;
    gHideSettingChatHistory = [defaults objectForKey:kWCHideSettingChatHistoryKey] ? [defaults boolForKey:kWCHideSettingChatHistoryKey] : NO;
    gHideSettingOther = [defaults objectForKey:kWCHideSettingOtherKey] ? [defaults boolForKey:kWCHideSettingOtherKey] : NO;
    gHideSettingHelp = [defaults objectForKey:kWCHideSettingHelpKey] ? [defaults boolForKey:kWCHideSettingHelpKey] : NO;
    gHideSettingAbout = [defaults objectForKey:kWCHideSettingAboutKey] ? [defaults boolForKey:kWCHideSettingAboutKey] : NO;
    gHideSettingPlugin = [defaults objectForKey:kWCHideSettingPluginKey] ? [defaults boolForKey:kWCHideSettingPluginKey] : NO;
    gHideSettingSwitchAccount = [defaults objectForKey:kWCHideSettingSwitchAccountKey] ? [defaults boolForKey:kWCHideSettingSwitchAccountKey] : NO;
    gHideSettingLogout = [defaults objectForKey:kWCHideSettingLogoutKey] ? [defaults boolForKey:kWCHideSettingLogoutKey] : NO;
    
}

// 设置变化回调
static void settingPageSettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    loadSettingPageSettings();
}

// 获取Cell标题
static NSString *getSettingCellTitle(id cellInfo) {
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
        NSLog(@"[HideSetting] Exception in getSettingCellTitle: %@", e);
        return nil;
    }
}

// 判断是否需要隐藏Cell
static BOOL shouldHideSettingCell(NSString *title) {
    if (!title) return NO;
    
    // 个人资料
    if (gHideSettingProfile && ([title containsString:@"个人资料"] || [title containsString:@"Profile"] || [title containsString:@"My Profile"])) {
        return YES;
    }
    // 账号安全
    if (gHideSettingAccountSecurity && ([title containsString:@"账号安全"] || [title containsString:@"Account Security"] || [title containsString:@"Security"])) {
        return YES;
    }
    // 个人信息与权限
    if (gHideSettingPrivacy && ([title containsString:@"个人信息与权限"] || [title containsString:@"个人信息"] || [title containsString:@"Privacy"] || [title containsString:@"Personal Info"])) {
        return YES;
    }
    // 通知
    if (gHideSettingNotification && ([title containsString:@"通知"] || [title containsString:@"Notification"] || [title containsString:@"Notifications"])) {
        return YES;
    }
    // 界面与显示
    if (gHideSettingDisplay && ([title containsString:@"界面与显示"] || [title containsString:@"界面"] || [title containsString:@"Display"] || [title containsString:@"Appearance"])) {
        return YES;
    }
    // 朋友权限
    if (gHideSettingFriendPermission && ([title containsString:@"朋友权限"] || [title containsString:@"Friend Permission"] || [title containsString:@"Privacy"])) {
        return YES;
    }
    // 存储空间
    if (gHideSettingStorage && ([title containsString:@"存储空间"] || [title containsString:@"Storage"] || [title containsString:@"Manage Storage"])) {
        return YES;
    }
    // 更多
    if (gHideSettingMore && ([title containsString:@"更多"] || [title containsString:@"More"] || [title containsString:@"More Settings"])) {
        return YES;
    }
    // 聊天
    if (gHideSettingChat && ([title containsString:@"聊天"] || [title containsString:@"Chat"] || [title containsString:@"Chats"])) {
        return YES;
    }
    // 音视频通话
    if (gHideSettingCall && ([title containsString:@"音视频通话"] || [title containsString:@"通话"] || [title containsString:@"Call"] || [title containsString:@"Video Call"])) {
        return YES;
    }
    // 聊天记录管理
    if (gHideSettingChatHistory && ([title containsString:@"聊天记录管理"] || [title containsString:@"聊天记录"] || [title containsString:@"Chat History"] || [title containsString:@"Chat Backup"])) {
        return YES;
    }
    // 其他
    if (gHideSettingOther && ([title containsString:@"其他"] || [title containsString:@"Other"] || [title containsString:@"Others"])) {
        return YES;
    }
    // 帮助与反馈
    if (gHideSettingHelp && ([title containsString:@"帮助与反馈"] || [title containsString:@"帮助"] || [title containsString:@"反馈"] || [title containsString:@"Help"] || [title containsString:@"Feedback"])) {
        return YES;
    }
    // 关于微信
    if (gHideSettingAbout && ([title containsString:@"关于微信"] || [title containsString:@"关于"] || [title containsString:@"About WeChat"] || [title containsString:@"About"])) {
        return YES;
    }
    // 插件
    if (gHideSettingPlugin && ([title containsString:@"插件"] || [title containsString:@"Plugin"] || [title containsString:@"Plugins"])) {
        return YES;
    }
    // 切换账号
    if (gHideSettingSwitchAccount && ([title containsString:@"切换账号"] || [title containsString:@"Switch Account"])) {
        return YES;
    }
    // 退出登录
    if (gHideSettingLogout && ([title containsString:@"退出登录"] || [title containsString:@"退出"] || [title containsString:@"Log Out"] || [title containsString:@"Logout"] || [title containsString:@"Sign Out"])) {
        return YES;
    }
    
    return NO;
}

// 移除指定索引的Cell
static void removeSettingCellAt(id section, unsigned long long index) {
    @try {
        SEL selector = @selector(removeCellAt:);
        if (![section respondsToSelector:selector]) {
            NSLog(@"[HideSetting] Section does not respond to removeCellAt:");
            return;
        }
        NSMethodSignature *signature = [section methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:section];
        [invocation setSelector:selector];
        [invocation setArgument:&index atIndex:2];
        [invocation invoke];
        NSLog(@"[HideSetting] Removed cell at index %llu", index);
    } @catch (NSException *e) {
        NSLog(@"[HideSetting] Exception in removeSettingCellAt: %@", e);
    }
}

// 隐藏设置页面中的Cell
static void hideSettingCells(id tableViewMgr) {    
    if (!tableViewMgr) {
        NSLog(@"[HideSetting] tableViewMgr is nil");
        return;
    }
    
    @try {
        NSMutableArray *sections = [tableViewMgr valueForKey:@"sections"];
        if (!sections) {
            NSLog(@"[HideSetting] sections is nil");
            return;
        }
        if (sections.count == 0) {
            NSLog(@"[HideSetting] sections is empty");
            return;
        }
                
        NSMutableArray *cellsToRemove = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < sections.count; i++) {
            id section = sections[i];
            if (!section) {
                NSLog(@"[HideSetting] Section %lu is nil", (unsigned long)i);
                continue;
            }
            
            NSMutableArray *cells = [section valueForKey:@"cells"];
            if (!cells) {
                NSLog(@"[HideSetting] Section %lu cells is nil", (unsigned long)i);
                continue;
            }
                        
            for (NSUInteger j = 0; j < cells.count; j++) {
                id cellInfo = cells[j];
                if (!cellInfo) continue;
                
                NSString *title = getSettingCellTitle(cellInfo);
                NSLog(@"[HideSetting] Section %lu Cell %lu: %@", (unsigned long)i, (unsigned long)j, title ?: @"(no title)");
                
                if (shouldHideSettingCell(title)) {
                    [cellsToRemove addObject:@{@"section": @(i), @"cell": @(j), @"title": title ?: @"(unknown)"}];
                }
            }
        }
                
        if (cellsToRemove.count == 0) {
            NSLog(@"[HideSetting] No cells to remove");
            return;
        }
        
        // 逆序移除，避免索引变化
        for (NSDictionary *info in [cellsToRemove reverseObjectEnumerator]) {
            NSUInteger sectionIdx = [info[@"section"] unsignedLongLongValue];
            NSUInteger cellIdx = [info[@"cell"] unsignedLongLongValue];
            NSString *title = info[@"title"];
                        
            sections = [tableViewMgr valueForKey:@"sections"];
            if (!sections || sectionIdx >= sections.count) {
                NSLog(@"[HideSetting] Skip - sections changed or index out of bounds");
                continue;
            }
            
            id section = sections[sectionIdx];
            if (!section) {
                NSLog(@"[HideSetting] Skip - section is nil");
                continue;
            }
            
            NSMutableArray *cells = [section valueForKey:@"cells"];
            if (!cells || cellIdx >= cells.count) {
                NSLog(@"[HideSetting] Skip - cells changed or index out of bounds");
                continue;
            }
            
            removeSettingCellAt(section, (unsigned long long)cellIdx);
        }
        
        // 检查并移除空分区
        NSMutableArray *sectionsToRemove = [NSMutableArray array];
        
        sections = [tableViewMgr valueForKey:@"sections"];
        if (!sections) {
            NSLog(@"[HideSetting] sections is nil after cell removal");
            return;
        }
        
        for (NSUInteger i = 0; i < sections.count; i++) {
            id section = sections[i];
            if (!section) continue;
            
            NSMutableArray *cells = [section valueForKey:@"cells"];
            
            // 尝试多种方式获取分区标题
            NSString *headerTitle = nil;
            
            // 方式1: 通过 headerTitle 属性
            headerTitle = [section valueForKey:@"headerTitle"];
            
            // 方式2: 如果为空，尝试 _headerTitle 实例变量
            if (!headerTitle || headerTitle.length == 0) {
                headerTitle = [section valueForKey:@"_headerTitle"];
            }
            
            // 方式3: 如果为空，尝试 attributedHeaderTitle
            if (!headerTitle || headerTitle.length == 0) {
                id attrTitle = [section valueForKey:@"attributedHeaderTitle"];
                if (attrTitle && [attrTitle isKindOfClass:[NSAttributedString class]]) {
                    headerTitle = [(NSAttributedString *)attrTitle string];
                }
            }
            
            // 方式4: 如果为空，尝试 _attributedHeaderTitle
            if (!headerTitle || headerTitle.length == 0) {
                id attrTitle = [section valueForKey:@"_attributedHeaderTitle"];
                if (attrTitle && [attrTitle isKindOfClass:[NSAttributedString class]]) {
                    headerTitle = [(NSAttributedString *)attrTitle string];
                }
            }
            
            // 方式5: 尝试从 headerView 获取
            if (!headerTitle || headerTitle.length == 0) {
                id headerView = [section valueForKey:@"headerView"];
                if (headerView) {
                    // 尝试获取 headerView 中的 label
                    id subview = nil;
                    for (id view in [headerView valueForKey:@"subviews"]) {
                        if ([view isKindOfClass:[UILabel class]]) {
                            subview = view;
                            break;
                        }
                    }
                    if (subview) {
                        headerTitle = [subview valueForKey:@"text"];
                    }
                }
            }

            // 检查是否为需要处理的分区（账号、通用、功能、帮助与关于）
            BOOL isTargetSection = NO;
            if (headerTitle && headerTitle.length > 0) {
                NSString *lowerTitle = [headerTitle lowercaseString];
                if ([lowerTitle containsString:@"账号"] || 
                    [lowerTitle containsString:@"通用"] || 
                    [lowerTitle containsString:@"功能"] || 
                    [lowerTitle containsString:@"帮助与关于"] ||
                    [lowerTitle containsString:@"帮助"] ||
                    [lowerTitle containsString:@"account"] || 
                    [lowerTitle containsString:@"general"] || 
                    [lowerTitle containsString:@"features"] || 
                    [lowerTitle containsString:@"help"]) {
                    isTargetSection = YES;
                }
            }
            
            // 如果是目标分区且没有剩余 Cell，则标记为需要移除
            if (isTargetSection && (!cells || cells.count == 0)) {
                NSLog(@"[HideSetting] Marking empty section %lu for removal: %@", (unsigned long)i, headerTitle);
                [sectionsToRemove addObject:@(i)];
            }
        }
        
        // 逆序移除空分区
        if (sectionsToRemove.count > 0) {
            NSLog(@"[HideSetting] Removing %lu empty sections", (unsigned long)sectionsToRemove.count);
            for (NSNumber *sectionIdx in [sectionsToRemove reverseObjectEnumerator]) {
                NSUInteger idx = [sectionIdx unsignedLongLongValue];
                sections = [tableViewMgr valueForKey:@"sections"];
                if (!sections || idx >= sections.count) {
                    NSLog(@"[HideSetting] Skip section removal - index out of bounds");
                    continue;
                }
                
                id section = sections[idx];
                NSString *headerTitle = [section valueForKey:@"headerTitle"];
                
                @try {
                    SEL selector = @selector(removeSection:);
                    if ([tableViewMgr respondsToSelector:selector]) {
                        NSMethodSignature *signature = [tableViewMgr methodSignatureForSelector:selector];
                        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                        [invocation setTarget:tableViewMgr];
                        [invocation setSelector:selector];
                        [invocation setArgument:&idx atIndex:2];
                        [invocation invoke];
                        NSLog(@"[HideSetting] Removed empty section: %@", headerTitle ?: @"(unknown)");
                    } else {
                        // 尝试直接从数组中移除
                        [sections removeObjectAtIndex:idx];
                        NSLog(@"[HideSetting] Removed empty section from array: %@", headerTitle ?: @"(unknown)");
                    }
                } @catch (NSException *e) {
                    NSLog(@"[HideSetting] Exception removing section: %@", e);
                }
            }
        }
                
        UITableView *tableView = [tableViewMgr valueForKey:@"tableView"];
        if (tableView) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView reloadData];
            });
        }
                
    } @catch (NSException *e) {
        NSLog(@"[HideSetting] CRASH in hideSettingCells: %@", e);
        NSLog(@"[HideSetting] Stack trace: %@", [e callStackSymbols]);
    }
}

#pragma mark - NewSettingViewController Hooks

// 声明NewSettingViewController类
@interface NewSettingViewController : NSObject
@end

%hook NewSettingViewController

- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            id tableViewMgr = [self valueForKey:@"m_tableViewMgr"];
            hideSettingCells(tableViewMgr);
        } @catch (NSException *e) {
            NSLog(@"[HideSetting] CRASH in viewWillAppear: %@", e);
        }
    });
}

- (void)reloadTableData {
    %orig;
    NSLog(@"[HideSetting] NewSettingViewController reloadTableData");
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            id tableViewMgr = [self valueForKey:@"m_tableViewMgr"];
            hideSettingCells(tableViewMgr);
        } @catch (NSException *e) {
            NSLog(@"[HideSetting] CRASH in reloadTableData: %@", e);
        }
    });
}

%end

#pragma mark - 构造函数

// 构造函数，插件加载时执行
%ctor {
    NSLog(@"[HideSetting] Tweak loaded");
    loadSettingPageSettings();
    
    // 注册Darwin通知，监听设置变化
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        settingPageSettingsChanged,
        CFSTR("com.wechat.tweak.settings_changed"),
        NULL,
        CFNotificationSuspensionBehaviorCoalesce
    );
}
