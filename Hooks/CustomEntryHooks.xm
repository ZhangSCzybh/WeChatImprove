// CustomEntryHooks.xm
// 微信自定义入口 Hook
// 该文件负责在微信注册自定义插件入口

#import "../Headers/WCHeaders.h"      // 微信相关的所有类和框架
#import "../Headers/CSUserInfoHelper.h" // 用户信息助手和全局常量
#import "../Headers/WCPluginsHeader.h"  // 其他插件提供的接口声明
#import "../Controllers/CSCustomViewController.h" // 自定义设置页面
#import "../Controllers/CSNativeSettingsHost.h"
#import "../Controllers/CSEntrySettingsViewController.h" // 入口设置控制器
#import "../Controllers/CSAuthorizationManager.h" // 授权管理器
#import "../Controllers/CSCloseFriendBridge.h"
#import "../Controllers/CSBackupManager.h" // 备份管理器

// 入口设置相关的键
static NSString * const kEntryDisplayModeKey = @"com.wechat.tweak.entry.display.mode";
static NSString * const kEntryCustomTitleKey = @"com.wechat.tweak.entry.custom.title";
static NSString * const kEntrySettingsChangedNotification = @"com.wechat.tweak.entry.settings.changed";

// 定义入口标题变量，可根据设置动态更改
static NSString *gCustomEntryTitle = nil;

// 获取入口图标
static inline UIImage * __nullable getCustomEntryIcon(void) {
    // 使用系统图标并设置蓝色
    UIImage *icon = [UIImage systemImageNamed:@"wand.and.stars"];
    return [icon imageWithTintColor:[UIColor systemBlueColor] renderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 获取显示模式设置
static CSEntryDisplayMode getEntryDisplayMode() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 首次安装时，默认显示在设置页面
    if (![defaults objectForKey:kEntryDisplayModeKey]) {
        return CSEntryDisplayModeSetting; // 值为 4
    }
    
    return (CSEntryDisplayMode)[defaults integerForKey:kEntryDisplayModeKey];
}

// 获取自定义标题
static NSString *getCustomEntryTitle() {
    if (!gCustomEntryTitle) {
        NSString *savedTitle = [[NSUserDefaults standardUserDefaults] objectForKey:kEntryCustomTitleKey];
        gCustomEntryTitle = savedTitle ?: @"再也不会";
    }
    return gCustomEntryTitle;
}

// 加载设置
static void loadEntrySettings() {
    // Reload the user's entry title when preferences change.
    gCustomEntryTitle = nil;
    // 加载自定义标题
    gCustomEntryTitle = getCustomEntryTitle();
}

static void CSRemoveHiddenPluginEntryFromHost(id host) {
    @try {
        id manager=CSCloseFriendRead(host,@"m_tableViewMgr");
        id sections=CSCloseFriendRead(manager,@"sections");
        if(![sections isKindOfClass:NSArray.class])return;
        for(id section in sections) {
            NSMutableArray *cells=CSCloseFriendRead(section,@"cells");
            if(![cells isKindOfClass:NSMutableArray.class])continue;
            for(id cell in [cells copy]) {
                id title=CSCloseFriendRead(CSCloseFriendRead(CSCloseFriendRead(cell,@"cellConfig"),@"leftConfig"),@"title");
                if([title isEqual:getCustomEntryTitle()])[cells removeObjectIdenticalTo:cell];
            }
        }
    } @catch(__unused NSException *exception) {}
}

// 监听设置变更的回调
static void entrySettingsChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    // 重新加载设置
    loadEntrySettings();
}

// 使用分类声明 MoreViewController 的新方法
@interface MoreViewController (CustomEntry)
- (void)addCustomEntryToMorePage;
- (void)openCustomViewController;
@end

%hook MoreViewController

- (void)viewDidLoad {
    %orig;
    loadEntrySettings();
    [self addCustomEntryToMorePage];
}

- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    [self addCustomEntryToMorePage];
}

- (void)reloadMoreView {
    %orig;
    [self addCustomEntryToMorePage];
}

// 在"我"页面添加功能入口
- (void)addFunctionSection {
    // 调用原始方法
    %orig;
    
    // 延迟执行，确保在 HideMomentsHooks 之后
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addCustomEntryToMorePage];
    });
}

// 添加自定义入口到我页面
%new
- (void)addCustomEntryToMorePage {
    if(CSCloseFriendPluginEntryHidden()) {
        CSRemoveHiddenPluginEntryFromHost(self);
        return;
    }
    // 获取显示模式
    CSEntryDisplayMode displayMode = getEntryDisplayMode();
    
    // 使用位掩码判断是否显示在我页面
    if ((displayMode & CSEntryDisplayModeMore) == 0) {
        return;
    }
    
    @try {
        // 获取自定义标题
        NSString *entryTitle = getCustomEntryTitle();
        
        // 获取tableViewMgr
        WCTableViewManager *tableViewMgr = MSHookIvar<id>(self, "m_tableViewMgr");
        if (!tableViewMgr) { 
            NSLog(@"[WeChatTweak] tableViewMgr is nil");
            return; 
        }
        
        // 获取第三个section（通常是功能区域）
        WCTableViewSectionManager *section = [tableViewMgr getSectionAt:2];
        if (!section) { 
            NSLog(@"[WeChatTweak] section is nil");
            return; 
        }
        
        // 检查是否已经添加过入口
        NSMutableArray *cells = [section valueForKey:@"cells"];
        if (cells) {
            for (id cell in cells) {
                NSString *title = nil;
                @try {
                    id cellConfig = [cell valueForKey:@"cellConfig"];
                    if (cellConfig) {
                        id leftConfig = [cellConfig valueForKey:@"leftConfig"];
                        if (leftConfig) {
                            title = [leftConfig valueForKey:@"title"];
                        }
                    }
                } @catch (NSException *e) {}
                
                if (title && [title isEqualToString:entryTitle]) {
                    return;
                }
            }
        }
        
        // 创建自定义入口cell
        WCTableViewCellManager *customEntryCell = [%c(WCTableViewCellManager) normalCellForSel:@selector(onCustomEntryClick)
                                                                                  target:self
                                                                               leftImage:getCustomEntryIcon()
                                                                                  title:entryTitle
                                                                                  badge:nil
                                                                             rightValue:nil
                                                                            rightImage:nil
                                                                       withRightRedDot:NO
                                                                              selected:NO];
        
        // 添加cell到section
        [section addCell:customEntryCell];
        
        // 刷新tableView
        UITableView *tableView = [tableViewMgr valueForKey:@"tableView"];
        if (tableView) {
            [tableView reloadData];
        }
    } @catch (NSException *e) {
        NSLog(@"[WeChatTweak] Exception in addCustomEntryToMorePage: %@", e);
    }
}

// 处理入口点击事件
%new
- (void)onCustomEntryClick {
    // 检查授权状态
    CSAuthorizationManager *authManager = [CSAuthorizationManager sharedManager];
    
    BOOL isAuthorized = [authManager isAuthorized];
    
    if (!isAuthorized) {
        // 未授权，显示授权弹窗
        [authManager requestAuthorizationWithPresentingViewController:self completion:^(BOOL success, NSString *message) {
            if (success) {
                // 授权成功，打开插件
                [self openCustomViewController];
            }
        }];
        return;
    }
    
    // 已授权，直接打开插件
    [self openCustomViewController];
}

// 打开自定义控制器
%new
- (void)openCustomViewController {
    if(CSCloseFriendPluginEntryHidden()) {
        CSCloseFriendAuthenticate((UIViewController *)(id)self,^(BOOL success){
            if(success && !CSCloseFriendPluginEntryHidden())[self openCustomViewController];
        });
        return;
    }
    // 创建并配置自定义控制器
    UIViewController *customVC = [[CSNativeSettingsControllerClass() alloc] init];
    customVC.title = getCustomEntryTitle();
    
    // 创建导航控制器（用于模态展示）
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:customVC];
    
    // 设置模态展示样式（iOS 13+）
    if (@available(iOS 13.0, *)) {
        navVC.modalPresentationStyle = UIModalPresentationFormSheet; // 使用表单样式
    } else {
        navVC.modalPresentationStyle = UIModalPresentationPageSheet; // 向上滑动样式
    }
    
    // 模态展示控制器
    [self presentViewController:navVC animated:YES completion:nil];
}

%end

%hook MinimizeViewController

static int isRegister = 0;

-(void)viewDidLoad{
    %orig;
    if(CSCloseFriendPluginEntryHidden())return;
    
    // 获取显示模式
    CSEntryDisplayMode displayMode = getEntryDisplayMode();
    
    // 使用位掩码判断是否显示在插件入口
    if ((displayMode & CSEntryDisplayModePlugin) == 0) {
        return;
    }
    
    if (NSClassFromString(@"WCPluginsMgr") && isRegister == 0) {
        isRegister = 1;
        
        // 获取自定义标题
        NSString *title = getCustomEntryTitle();
        NSString *version = kPluginVersionString;
        NSString *controller = NSStringFromClass(CSNativeSettingsControllerClass());
        
        
        @try {
            Class wcPluginsMgr = objc_getClass("WCPluginsMgr");
            if (wcPluginsMgr) {
                id instance = [wcPluginsMgr performSelector:@selector(sharedInstance)];
                if (instance) {
                    SEL registerSel = @selector(registerControllerWithTitle:version:controller:);
                    if ([instance respondsToSelector:registerSel]) {
                        [instance registerControllerWithTitle:title version:version controller:controller];
                    } else {
                        NSLog(@"[WeChatTweak] 注册失败: registerControllerWithTitle方法不存在");
                    }
                } else {
                    NSLog(@"[WeChatTweak] 注册失败: 无法获取WCPluginsMgr实例");
                }
            } else {
                NSLog(@"[WeChatTweak] 注册失败: WCPluginsMgr类不存在");
            }
        } @catch (NSException *exception) {
            NSLog(@"[WeChatTweak] 注册入口失败: %@", exception);
        }
    }
}
%end

// 声明 NewSettingViewController 类
@interface NewSettingViewController : NSObject
- (void)addCustomEntryToSettingPage;
- (void)openCustomViewControllerFromSetting;
@end

%hook NewSettingViewController

// 在"设置"页面添加功能入口
- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    
    // 延迟执行，确保在 HideSettingHooks 之后
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addCustomEntryToSettingPage];
    });
}

- (void)reloadTableData {
    %orig;
    
    // 延迟执行，确保在 HideSettingHooks 之后
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addCustomEntryToSettingPage];
    });
}

// 添加自定义入口到设置页面
%new
- (void)addCustomEntryToSettingPage {
    if(CSCloseFriendPluginEntryHidden()) {
        CSRemoveHiddenPluginEntryFromHost(self);
        return;
    }
    // 获取显示模式
    CSEntryDisplayMode displayMode = getEntryDisplayMode();
    
    // 使用位掩码判断是否显示在设置页面
    if ((displayMode & CSEntryDisplayModeSetting) == 0) {
        return;
    }
    
    @try {
        // 获取tableViewMgr
        id tableViewMgr = [self valueForKey:@"m_tableViewMgr"];
        if (!tableViewMgr) {
            NSLog(@"[WeChatTweak] tableViewMgr is nil");
            return;
        }
        
        // 获取sections数组
        NSMutableArray *sections = [tableViewMgr valueForKey:@"sections"];
        if (!sections || sections.count == 0) {
            NSLog(@"[WeChatTweak] sections is nil or empty");
            return;
        }
        
        // 获取自定义标题
        NSString *entryTitle = getCustomEntryTitle();
        
        // 查找合适的section（通常是第二个section，通用设置区域）
        id targetSection = nil;
        for (NSUInteger i = 0; i < sections.count; i++) {
            id section = sections[i];
            NSString *headerTitle = [section valueForKey:@"headerTitle"];
            
            // 查找"通用"或"General"section
            if (headerTitle && ([headerTitle containsString:@"通用"] || 
                               [headerTitle containsString:@"General"] ||
                               [headerTitle.lowercaseString containsString:@"general"])) {
                targetSection = section;
                break;
            }
        }
        
        // 如果没找到通用section，使用第二个section
        if (!targetSection && sections.count > 0) {
            targetSection = sections[MIN((NSUInteger)1, sections.count - 1)];
        }
        
        if (!targetSection) {
            NSLog(@"[WeChatTweak] 未找到合适的section");
            return;
        }
        
        // 检查是否已经添加过入口
        NSMutableArray *cells = [targetSection valueForKey:@"cells"];
        if (cells) {
            for (id cell in cells) {
                NSString *title = nil;
                @try {
                    id cellConfig = [cell valueForKey:@"cellConfig"];
                    if (cellConfig) {
                        id leftConfig = [cellConfig valueForKey:@"leftConfig"];
                        if (leftConfig) {
                            title = [leftConfig valueForKey:@"title"];
                        }
                    }
                } @catch (NSException *e) {}
                
                if (title && [title isEqualToString:entryTitle]) {
                    return;
                }
            }
        }
        
        // 创建自定义入口cell
        Class cellManagerClass = objc_getClass("WCTableViewNormalCellManager");
        if (!cellManagerClass) {
            NSLog(@"[WeChatTweak] WCTableViewNormalCellManager class not found");
            return;
        }
        
        SEL createCellSel = @selector(normalCellForSel:target:leftImage:title:badge:rightValue:rightImage:withRightRedDot:selected:);
        if (![cellManagerClass respondsToSelector:createCellSel]) {
            NSLog(@"[WeChatTweak] WCTableViewNormalCellManager does not respond to normalCellForSel");
            return;
        }
        
        id customEntryCell = [cellManagerClass normalCellForSel:@selector(onCustomEntryClickInSetting:)
                                                        target:self
                                                     leftImage:nil  // 设置页面不显示图标
                                                        title:entryTitle
                                                        badge:nil
                                                   rightValue:nil
                                                  rightImage:nil
                                             withRightRedDot:NO
                                                    selected:NO];
        
        if (!customEntryCell) {
            NSLog(@"[WeChatTweak] Failed to create custom entry cell");
            return;
        }
        
        // 添加cell到section
        SEL addCellSel = @selector(addCell:);
        if ([targetSection respondsToSelector:addCellSel]) {
            [targetSection addCell:customEntryCell];
            
            // 刷新tableView
            UITableView *tableView = [tableViewMgr valueForKey:@"tableView"];
            if (tableView) {
                [tableView reloadData];
            }
        } else {
            NSLog(@"[WeChatTweak] Section does not respond to addCell");
        }
    } @catch (NSException *e) {
        NSLog(@"[WeChatTweak] Exception in addCustomEntryToSettingPage: %@", e);
    }
}

// 处理入口点击事件
%new
- (void)onCustomEntryClickInSetting:(id)sender {
    // 检查授权状态
    CSAuthorizationManager *authManager = [CSAuthorizationManager sharedManager];
    
    BOOL isAuthorized = [authManager isAuthorized];
    
    if (!isAuthorized) {
        // 未授权，显示授权弹窗
        UINavigationController *navigationController = [self valueForKey:@"navigationController"];
        UIViewController *presentingVC = navigationController ? (UIViewController *)navigationController : (UIViewController *)self;
        
        [authManager requestAuthorizationWithPresentingViewController:presentingVC completion:^(BOOL success, NSString *message) {
            if (success) {
                // 授权成功，打开插件
                [self openCustomViewControllerFromSetting];
            }
        }];
        return;
    }
    
    // 已授权，直接打开插件
    [self openCustomViewControllerFromSetting];
}

// 打开自定义控制器
%new
- (void)openCustomViewControllerFromSetting {
    if(CSCloseFriendPluginEntryHidden()) {
        CSCloseFriendAuthenticate((UIViewController *)(id)self,^(BOOL success){
            if(success && !CSCloseFriendPluginEntryHidden())[self openCustomViewControllerFromSetting];
        });
        return;
    }
    // 创建并配置自定义控制器
    UIViewController *customVC = [[CSNativeSettingsControllerClass() alloc] init];
    customVC.title = getCustomEntryTitle();
    
    // 创建导航控制器（用于模态展示）
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:customVC];
    
    // 设置模态展示样式（iOS 13+）
    if (@available(iOS 13.0, *)) {
        navVC.modalPresentationStyle = UIModalPresentationFormSheet; // 使用表单样式
    } else {
        navVC.modalPresentationStyle = UIModalPresentationPageSheet; // 向上滑动样式
    }
    
    // 获取navigationController并模态展示
    UINavigationController *navigationController = [self valueForKey:@"navigationController"];
    if (navigationController) {
        [navigationController presentViewController:navVC animated:YES completion:nil];
    } else if ([(id)self isKindOfClass:UIViewController.class]) {
        [(UIViewController *)(id)self presentViewController:navVC animated:YES completion:nil];
    }
}

%end

// 注册设置变更通知和初始化
%ctor {
    // 加载设置
    loadEntrySettings();
    
    // 初始化备份管理器，确保自动备份功能可用
    // 这会在应用启动时触发，确保 CSBackupManager 单例被创建
    // CSBackupManager 会自动监听应用进入前台的通知
    dispatch_async(dispatch_get_main_queue(), ^{ [CSBackupManager sharedManager]; });
    
    // 注册通知观察者，当设置变化时重新加载
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                   NULL,
                                   entrySettingsChangedCallback,
                                   CFSTR("com.wechat.tweak.entry.settings.changed"),
                                   NULL,
                                   CFNotificationSuspensionBehaviorDeliverImmediately);
    // The original plugin framework remains available independently of backup status.
    %init;
}
