#import "CSUICleanViewController.h"
#import "CSSettingTableViewCell.h"

// 定义NSUserDefaults的键（与HideQRCodeHooks.xm中保持一致）
static NSString * const kWCHideQRCodeEnabledKey = @"com.wechat.tweak.hide_qrcode_enabled";
// 添加隐藏聊天时间标签的键
static NSString * const kWCHideChatTimeEnabledKey = @"com.wechat.tweak.hide_chat_time_enabled";
// 添加隐藏拍一拍消息标签的键
static NSString * const kWCHidePatMessageEnabledKey = @"com.wechat.tweak.hide_pat_message_enabled";
// 添加隐藏语音红点和转文字标签的键
static NSString * const kWCHideVoiceHintEnabledKey = @"com.wechat.tweak.hide_voice_hint_enabled";
// 添加隐藏朋友圈选项的键
static NSString * const kWCHideMomentsEnabledKey = @"com.wechat.tweak.hide_moments_enabled";
// 添加隐藏收藏选项的键
static NSString * const kWCHideFavoriteEnabledKey = @"com.wechat.tweak.hide_favorite_enabled";
// 添加隐藏卡包选项的键
static NSString * const kWCHideWalletEnabledKey = @"com.wechat.tweak.hide_wallet_enabled";
// 添加隐藏表情选项的键
static NSString * const kWCHideStickerEnabledKey = @"com.wechat.tweak.hide_sticker_enabled";
// 添加隐藏设置选项的键
static NSString * const kWCHideSettingsEnabledKey = @"com.wechat.tweak.hide_settings_enabled";
// 添加隐藏服务选项的键
static NSString * const kWCHideServiceEnabledKey = @"com.wechat.tweak.hide_service_enabled";
// 添加隐藏视频号与公众号选项的键
static NSString * const kWCHideChannelsEnabledKey = @"com.wechat.tweak.hide_channels_enabled";
static NSString * const kWCHideWorksEnabledKey = @"com.wechat.tweak.hide_works_enabled";

// 发现页隐藏设置键
static NSString * const kWCHideDiscoverChannelsKey = @"com.wechat.tweak.hide_discover_channels";
static NSString * const kWCHideDiscoverLiveKey = @"com.wechat.tweak.hide_discover_live";
static NSString * const kWCHideDiscoverScanKey = @"com.wechat.tweak.hide_discover_scan";
static NSString * const kWCHideDiscoverListenKey = @"com.wechat.tweak.hide_discover_listen";
static NSString * const kWCHideDiscoverLookKey = @"com.wechat.tweak.hide_discover_look";
static NSString * const kWCHideDiscoverSearchKey = @"com.wechat.tweak.hide_discover_search";
static NSString * const kWCHideDiscoverNearbyKey = @"com.wechat.tweak.hide_discover_nearby";
static NSString * const kWCHideDiscoverGameKey = @"com.wechat.tweak.hide_discover_game";
static NSString * const kWCHideDiscoverMiniProgramKey = @"com.wechat.tweak.hide_discover_miniprogram";

// 设置页面隐藏设置键
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

// 定义通知名称
static NSString * const kWCSettingsChangedNotification = @"com.wechat.tweak.settings_changed";

// 功能说明详细文本
static NSString * const kFeatureDescription = @"此功能将隐藏不必要的界面元素，部分屏蔽可能需要重启才能完全生效。可能会误判，如有误判请关闭。";

@interface CSUICleanViewController ()

// 存储所有设置分区
@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;

// 存储UI元素的引用，方便直接操作
@property (nonatomic, strong) CSSettingItem *hideQRCodeItem;
// 添加隐藏聊天时间标签的控制项
@property (nonatomic, strong) CSSettingItem *hideChatTimeItem;
// 添加隐藏拍一拍消息标签的控制项
@property (nonatomic, strong) CSSettingItem *hidePatMessageItem;
// 添加隐藏语音红点和转文字标签的控制项
@property (nonatomic, strong) CSSettingItem *hideVoiceHintItem;
// 添加隐藏朋友圈选项的控制项
@property (nonatomic, strong) CSSettingItem *hideMomentsItem;
// 添加隐藏收藏选项的控制项
@property (nonatomic, strong) CSSettingItem *hideFavoriteItem;
// 添加隐藏卡包选项的控制项
@property (nonatomic, strong) CSSettingItem *hideWalletItem;
// 添加隐藏表情选项的控制项
@property (nonatomic, strong) CSSettingItem *hideStickerItem;
// 添加隐藏设置选项的控制项
@property (nonatomic, strong) CSSettingItem *hideSettingsItem;
// 添加隐藏服务选项的控制项
@property (nonatomic, strong) CSSettingItem *hideServiceItem;
// 添加隐藏视频号与公众号选项的控制项
@property (nonatomic, strong) CSSettingItem *hideChannelsItem;
@property (nonatomic, strong) CSSettingItem *hideWorksItem;

// 发现页隐藏选项
@property (nonatomic, strong) CSSettingItem *hideDiscoverChannelsItem;
@property (nonatomic, strong) CSSettingItem *hideDiscoverLiveItem;
@property (nonatomic, strong) CSSettingItem *hideDiscoverScanItem;
@property (nonatomic, strong) CSSettingItem *hideDiscoverListenItem;
@property (nonatomic, strong) CSSettingItem *hideDiscoverLookItem;
@property (nonatomic, strong) CSSettingItem *hideDiscoverSearchItem;
@property (nonatomic, strong) CSSettingItem *hideDiscoverNearbyItem;
@property (nonatomic, strong) CSSettingItem *hideDiscoverGameItem;
@property (nonatomic, strong) CSSettingItem *hideDiscoverMiniProgramItem;

// 设置页面隐藏选项
@property (nonatomic, strong) CSSettingItem *hideSettingProfileItem;
@property (nonatomic, strong) CSSettingItem *hideSettingAccountSecurityItem;
@property (nonatomic, strong) CSSettingItem *hideSettingPrivacyItem;
@property (nonatomic, strong) CSSettingItem *hideSettingNotificationItem;
@property (nonatomic, strong) CSSettingItem *hideSettingDisplayItem;
@property (nonatomic, strong) CSSettingItem *hideSettingFriendPermissionItem;
@property (nonatomic, strong) CSSettingItem *hideSettingStorageItem;
@property (nonatomic, strong) CSSettingItem *hideSettingMoreItem;
@property (nonatomic, strong) CSSettingItem *hideSettingChatItem;
@property (nonatomic, strong) CSSettingItem *hideSettingCallItem;
@property (nonatomic, strong) CSSettingItem *hideSettingChatHistoryItem;
@property (nonatomic, strong) CSSettingItem *hideSettingOtherItem;
@property (nonatomic, strong) CSSettingItem *hideSettingHelpItem;
@property (nonatomic, strong) CSSettingItem *hideSettingAboutItem;
@property (nonatomic, strong) CSSettingItem *hideSettingPluginItem;
@property (nonatomic, strong) CSSettingItem *hideSettingSwitchAccountItem;
@property (nonatomic, strong) CSSettingItem *hideSettingLogoutItem;

@end

@implementation CSUICleanViewController

#pragma mark - 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.title = @"界面净化";
    
    // 设置UI样式
    [self setupTableView];
    
    // 初始化数据
    [self setupData];
    
    // 注册通知，响应设置变化
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(settingsChanged:) 
                                                 name:@"com.wechat.tweak.local_settings_changed" 
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 确保UI刷新
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 私有方法

// 设置表格视图
- (void)setupTableView {
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 注册设置单元格
    [CSSettingTableViewCell registerToTableView:self.tableView];
}

// 响应设置变化的通知
- (void)settingsChanged:(NSNotification *)notification {
    [self reloadSettings];
}

// 显示功能说明弹窗
- (void)showFeatureDescription {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"功能说明"
                                                                   message:kFeatureDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 公共方法

// 重新加载设置
- (void)reloadSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL hideQRCodeEnabled = [defaults objectForKey:kWCHideQRCodeEnabledKey] ? [defaults boolForKey:kWCHideQRCodeEnabledKey] : NO;
    BOOL hideChatTimeEnabled = [defaults objectForKey:kWCHideChatTimeEnabledKey] ? [defaults boolForKey:kWCHideChatTimeEnabledKey] : NO;
    BOOL hidePatMessageEnabled = [defaults objectForKey:kWCHidePatMessageEnabledKey] ? [defaults boolForKey:kWCHidePatMessageEnabledKey] : NO;
    BOOL hideVoiceHintEnabled = [defaults objectForKey:kWCHideVoiceHintEnabledKey] ? [defaults boolForKey:kWCHideVoiceHintEnabledKey] : NO;
    BOOL hideMomentsEnabled = [defaults objectForKey:kWCHideMomentsEnabledKey] ? [defaults boolForKey:kWCHideMomentsEnabledKey] : NO;
    BOOL hideFavoriteEnabled = [defaults objectForKey:kWCHideFavoriteEnabledKey] ? [defaults boolForKey:kWCHideFavoriteEnabledKey] : NO;
    BOOL hideWalletEnabled = [defaults objectForKey:kWCHideWalletEnabledKey] ? [defaults boolForKey:kWCHideWalletEnabledKey] : NO;
    BOOL hideStickerEnabled = [defaults objectForKey:kWCHideStickerEnabledKey] ? [defaults boolForKey:kWCHideStickerEnabledKey] : NO;
    BOOL hideSettingsEnabled = [defaults objectForKey:kWCHideSettingsEnabledKey] ? [defaults boolForKey:kWCHideSettingsEnabledKey] : NO;
    BOOL hideServiceEnabled = [defaults objectForKey:kWCHideServiceEnabledKey] ? [defaults boolForKey:kWCHideServiceEnabledKey] : NO;
    BOOL hideChannelsEnabled = [defaults objectForKey:kWCHideChannelsEnabledKey] ? [defaults boolForKey:kWCHideChannelsEnabledKey] : NO;
    
    self.hideQRCodeItem.switchValue = hideQRCodeEnabled;
    self.hideChatTimeItem.switchValue = hideChatTimeEnabled;
    self.hidePatMessageItem.switchValue = hidePatMessageEnabled;
    self.hideVoiceHintItem.switchValue = hideVoiceHintEnabled;
    self.hideMomentsItem.switchValue = hideMomentsEnabled;
    self.hideFavoriteItem.switchValue = hideFavoriteEnabled;
    self.hideWalletItem.switchValue = hideWalletEnabled;
    self.hideStickerItem.switchValue = hideStickerEnabled;
    self.hideSettingsItem.switchValue = hideSettingsEnabled;
    self.hideServiceItem.switchValue = hideServiceEnabled;
    self.hideChannelsItem.switchValue = hideChannelsEnabled;
    self.hideWorksItem.switchValue = [defaults boolForKey:kWCHideWorksEnabledKey];
    
    // 发现页设置
    BOOL hideDiscoverChannels = [defaults objectForKey:kWCHideDiscoverChannelsKey] ? [defaults boolForKey:kWCHideDiscoverChannelsKey] : NO;
    BOOL hideDiscoverLive = [defaults objectForKey:kWCHideDiscoverLiveKey] ? [defaults boolForKey:kWCHideDiscoverLiveKey] : NO;
    BOOL hideDiscoverScan = [defaults objectForKey:kWCHideDiscoverScanKey] ? [defaults boolForKey:kWCHideDiscoverScanKey] : NO;
    BOOL hideDiscoverListen = [defaults objectForKey:kWCHideDiscoverListenKey] ? [defaults boolForKey:kWCHideDiscoverListenKey] : NO;
    BOOL hideDiscoverLook = [defaults objectForKey:kWCHideDiscoverLookKey] ? [defaults boolForKey:kWCHideDiscoverLookKey] : NO;
    BOOL hideDiscoverSearch = [defaults objectForKey:kWCHideDiscoverSearchKey] ? [defaults boolForKey:kWCHideDiscoverSearchKey] : NO;
    BOOL hideDiscoverNearby = [defaults objectForKey:kWCHideDiscoverNearbyKey] ? [defaults boolForKey:kWCHideDiscoverNearbyKey] : NO;
    BOOL hideDiscoverGame = [defaults objectForKey:kWCHideDiscoverGameKey] ? [defaults boolForKey:kWCHideDiscoverGameKey] : NO;
    BOOL hideDiscoverMiniProgram = [defaults objectForKey:kWCHideDiscoverMiniProgramKey] ? [defaults boolForKey:kWCHideDiscoverMiniProgramKey] : NO;
    
    self.hideDiscoverChannelsItem.switchValue = hideDiscoverChannels;
    self.hideDiscoverLiveItem.switchValue = hideDiscoverLive;
    self.hideDiscoverScanItem.switchValue = hideDiscoverScan;
    self.hideDiscoverListenItem.switchValue = hideDiscoverListen;
    self.hideDiscoverLookItem.switchValue = hideDiscoverLook;
    self.hideDiscoverSearchItem.switchValue = hideDiscoverSearch;
    self.hideDiscoverNearbyItem.switchValue = hideDiscoverNearby;
    self.hideDiscoverGameItem.switchValue = hideDiscoverGame;
    self.hideDiscoverMiniProgramItem.switchValue = hideDiscoverMiniProgram;
    
    // 设置页面设置
    BOOL hideSettingProfile = [defaults objectForKey:kWCHideSettingProfileKey] ? [defaults boolForKey:kWCHideSettingProfileKey] : NO;
    BOOL hideSettingAccountSecurity = [defaults objectForKey:kWCHideSettingAccountSecurityKey] ? [defaults boolForKey:kWCHideSettingAccountSecurityKey] : NO;
    BOOL hideSettingPrivacy = [defaults objectForKey:kWCHideSettingPrivacyKey] ? [defaults boolForKey:kWCHideSettingPrivacyKey] : NO;
    BOOL hideSettingNotification = [defaults objectForKey:kWCHideSettingNotificationKey] ? [defaults boolForKey:kWCHideSettingNotificationKey] : NO;
    BOOL hideSettingDisplay = [defaults objectForKey:kWCHideSettingDisplayKey] ? [defaults boolForKey:kWCHideSettingDisplayKey] : NO;
    BOOL hideSettingFriendPermission = [defaults objectForKey:kWCHideSettingFriendPermissionKey] ? [defaults boolForKey:kWCHideSettingFriendPermissionKey] : NO;
    BOOL hideSettingStorage = [defaults objectForKey:kWCHideSettingStorageKey] ? [defaults boolForKey:kWCHideSettingStorageKey] : NO;
    BOOL hideSettingMore = [defaults objectForKey:kWCHideSettingMoreKey] ? [defaults boolForKey:kWCHideSettingMoreKey] : NO;
    BOOL hideSettingChat = [defaults objectForKey:kWCHideSettingChatKey] ? [defaults boolForKey:kWCHideSettingChatKey] : NO;
    BOOL hideSettingCall = [defaults objectForKey:kWCHideSettingCallKey] ? [defaults boolForKey:kWCHideSettingCallKey] : NO;
    BOOL hideSettingChatHistory = [defaults objectForKey:kWCHideSettingChatHistoryKey] ? [defaults boolForKey:kWCHideSettingChatHistoryKey] : NO;
    BOOL hideSettingOther = [defaults objectForKey:kWCHideSettingOtherKey] ? [defaults boolForKey:kWCHideSettingOtherKey] : NO;
    BOOL hideSettingHelp = [defaults objectForKey:kWCHideSettingHelpKey] ? [defaults boolForKey:kWCHideSettingHelpKey] : NO;
    BOOL hideSettingAbout = [defaults objectForKey:kWCHideSettingAboutKey] ? [defaults boolForKey:kWCHideSettingAboutKey] : NO;
    BOOL hideSettingPlugin = [defaults objectForKey:kWCHideSettingPluginKey] ? [defaults boolForKey:kWCHideSettingPluginKey] : NO;
    BOOL hideSettingSwitchAccount = [defaults objectForKey:kWCHideSettingSwitchAccountKey] ? [defaults boolForKey:kWCHideSettingSwitchAccountKey] : NO;
    BOOL hideSettingLogout = [defaults objectForKey:kWCHideSettingLogoutKey] ? [defaults boolForKey:kWCHideSettingLogoutKey] : NO;
    
    self.hideSettingProfileItem.switchValue = hideSettingProfile;
    self.hideSettingAccountSecurityItem.switchValue = hideSettingAccountSecurity;
    self.hideSettingPrivacyItem.switchValue = hideSettingPrivacy;
    self.hideSettingNotificationItem.switchValue = hideSettingNotification;
    self.hideSettingDisplayItem.switchValue = hideSettingDisplay;
    self.hideSettingFriendPermissionItem.switchValue = hideSettingFriendPermission;
    self.hideSettingStorageItem.switchValue = hideSettingStorage;
    self.hideSettingMoreItem.switchValue = hideSettingMore;
    self.hideSettingChatItem.switchValue = hideSettingChat;
    self.hideSettingCallItem.switchValue = hideSettingCall;
    self.hideSettingChatHistoryItem.switchValue = hideSettingChatHistory;
    self.hideSettingOtherItem.switchValue = hideSettingOther;
    self.hideSettingHelpItem.switchValue = hideSettingHelp;
    self.hideSettingAboutItem.switchValue = hideSettingAbout;
    self.hideSettingPluginItem.switchValue = hideSettingPlugin;
    self.hideSettingSwitchAccountItem.switchValue = hideSettingSwitchAccount;
    self.hideSettingLogoutItem.switchValue = hideSettingLogout;
    
    [self.tableView reloadData];
}

- (void)setupData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL hideQRCodeEnabled = [defaults objectForKey:kWCHideQRCodeEnabledKey] ? [defaults boolForKey:kWCHideQRCodeEnabledKey] : NO;
    BOOL hideChatTimeEnabled = [defaults objectForKey:kWCHideChatTimeEnabledKey] ? [defaults boolForKey:kWCHideChatTimeEnabledKey] : NO;
    BOOL hidePatMessageEnabled = [defaults objectForKey:kWCHidePatMessageEnabledKey] ? [defaults boolForKey:kWCHidePatMessageEnabledKey] : NO;
    // 获取隐藏语音红点和转文字标签的设置，默认为关闭
    BOOL hideVoiceHintEnabled = [defaults objectForKey:kWCHideVoiceHintEnabledKey] ? [defaults boolForKey:kWCHideVoiceHintEnabledKey] : NO;
    BOOL hideMomentsEnabled = [defaults objectForKey:kWCHideMomentsEnabledKey] ? [defaults boolForKey:kWCHideMomentsEnabledKey] : NO;
    BOOL hideFavoriteEnabled = [defaults objectForKey:kWCHideFavoriteEnabledKey] ? [defaults boolForKey:kWCHideFavoriteEnabledKey] : NO;
    BOOL hideWalletEnabled = [defaults objectForKey:kWCHideWalletEnabledKey] ? [defaults boolForKey:kWCHideWalletEnabledKey] : NO;
    BOOL hideStickerEnabled = [defaults objectForKey:kWCHideStickerEnabledKey] ? [defaults boolForKey:kWCHideStickerEnabledKey] : NO;
    BOOL hideSettingsEnabled = [defaults objectForKey:kWCHideSettingsEnabledKey] ? [defaults boolForKey:kWCHideSettingsEnabledKey] : NO;
    BOOL hideServiceEnabled = [defaults objectForKey:kWCHideServiceEnabledKey] ? [defaults boolForKey:kWCHideServiceEnabledKey] : NO;
    BOOL hideChannelsEnabled = [defaults objectForKey:kWCHideChannelsEnabledKey] ? [defaults boolForKey:kWCHideChannelsEnabledKey] : NO;
    
    // 发现页设置默认值
    BOOL hideDiscoverChannels = [defaults objectForKey:kWCHideDiscoverChannelsKey] ? [defaults boolForKey:kWCHideDiscoverChannelsKey] : NO;
    BOOL hideDiscoverLive = [defaults objectForKey:kWCHideDiscoverLiveKey] ? [defaults boolForKey:kWCHideDiscoverLiveKey] : NO;
    BOOL hideDiscoverScan = [defaults objectForKey:kWCHideDiscoverScanKey] ? [defaults boolForKey:kWCHideDiscoverScanKey] : NO;
    BOOL hideDiscoverListen = [defaults objectForKey:kWCHideDiscoverListenKey] ? [defaults boolForKey:kWCHideDiscoverListenKey] : NO;
    BOOL hideDiscoverLook = [defaults objectForKey:kWCHideDiscoverLookKey] ? [defaults boolForKey:kWCHideDiscoverLookKey] : NO;
    BOOL hideDiscoverSearch = [defaults objectForKey:kWCHideDiscoverSearchKey] ? [defaults boolForKey:kWCHideDiscoverSearchKey] : NO;
    BOOL hideDiscoverNearby = [defaults objectForKey:kWCHideDiscoverNearbyKey] ? [defaults boolForKey:kWCHideDiscoverNearbyKey] : NO;
    BOOL hideDiscoverGame = [defaults objectForKey:kWCHideDiscoverGameKey] ? [defaults boolForKey:kWCHideDiscoverGameKey] : NO;
    BOOL hideDiscoverMiniProgram = [defaults objectForKey:kWCHideDiscoverMiniProgramKey] ? [defaults boolForKey:kWCHideDiscoverMiniProgramKey] : NO;
    
    // 我的页面设置项
    self.hideQRCodeItem = [CSSettingItem switchItemWithTitle:@"隐藏添加界面二维码" 
                                                   iconName:@"qrcode" 
                                                  iconColor:[UIColor systemGreenColor]
                                                switchValue:hideQRCodeEnabled
                                           valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideQRCodeEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideChatTimeItem = [CSSettingItem switchItemWithTitle:@"隐藏聊天界面时间标签" 
                                                     iconName:@"clock" 
                                                    iconColor:[UIColor systemBlueColor]
                                                  switchValue:hideChatTimeEnabled
                                             valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideChatTimeEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hidePatMessageItem = [CSSettingItem switchItemWithTitle:@"隐藏拍一拍消息提示标签" 
                                                       iconName:@"hand.tap" 
                                                      iconColor:[UIColor systemOrangeColor]
                                                    switchValue:hidePatMessageEnabled
                                               valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHidePatMessageEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideVoiceHintItem = [CSSettingItem switchItemWithTitle:@"隐藏语音红点和转文字标签" 
                                                       iconName:@"mic" 
                                                      iconColor:[UIColor systemRedColor]
                                                    switchValue:hideVoiceHintEnabled
                                               valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideVoiceHintEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideMomentsItem = [CSSettingItem switchItemWithTitle:@"隐藏朋友圈选项" 
                                                     iconName:@"person.2.circle" 
                                                    iconColor:[UIColor systemPinkColor]
                                                  switchValue:hideMomentsEnabled
                                             valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideMomentsEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideFavoriteItem = [CSSettingItem switchItemWithTitle:@"隐藏收藏选项" 
                                                     iconName:@"star" 
                                                    iconColor:[UIColor systemYellowColor]
                                                  switchValue:hideFavoriteEnabled
                                             valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideFavoriteEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideWalletItem = [CSSettingItem switchItemWithTitle:@"隐藏卡包选项" 
                                                   iconName:@"creditcard" 
                                                  iconColor:[UIColor systemBrownColor]
                                                switchValue:hideWalletEnabled
                                           valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideWalletEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideStickerItem = [CSSettingItem switchItemWithTitle:@"隐藏表情选项" 
                                                     iconName:@"face.smiling" 
                                                    iconColor:[UIColor systemPurpleColor]
                                                  switchValue:hideStickerEnabled
                                             valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideStickerEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingsItem = [CSSettingItem switchItemWithTitle:@"隐藏设置选项" 
                                                     iconName:@"gear" 
                                                    iconColor:[UIColor systemGrayColor]
                                                  switchValue:hideSettingsEnabled
                                             valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingsEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideServiceItem = [CSSettingItem switchItemWithTitle:@"隐藏服务选项" 
                                                     iconName:@"briefcase" 
                                                    iconColor:[UIColor systemIndigoColor]
                                                  switchValue:hideServiceEnabled
                                             valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideServiceEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideChannelsItem = [CSSettingItem switchItemWithTitle:@"隐藏视频号与公众号选项" 
                                                      iconName:@"play.rectangle.on.rectangle" 
                                                     iconColor:[UIColor systemTealColor]
                                                   switchValue:hideChannelsEnabled
                                              valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideChannelsEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideWorksItem = [CSSettingItem switchItemWithTitle:@"隐藏作品选项"
                                                 iconName:@"square.stack"
                                                iconColor:[UIColor systemBlueColor]
                                              switchValue:[defaults boolForKey:kWCHideWorksEnabledKey]
                                         valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideWorksEnabledKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];

    // 隐藏视频号
    self.hideDiscoverChannelsItem = [CSSettingItem switchItemWithTitle:@"隐藏视频号" 
                                                             iconName:@"video.circle" 
                                                            iconColor:[UIColor systemOrangeColor]
                                                          switchValue:hideDiscoverChannels
                                                     valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverChannelsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 隐藏直播
    self.hideDiscoverLiveItem = [CSSettingItem switchItemWithTitle:@"隐藏直播" 
                                                         iconName:@"video.fill" 
                                                        iconColor:[UIColor systemRedColor]
                                                      switchValue:hideDiscoverLive
                                                 valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverLiveKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 隐藏扫一扫
    self.hideDiscoverScanItem = [CSSettingItem switchItemWithTitle:@"隐藏扫一扫" 
                                                         iconName:@"qrcode.viewfinder" 
                                                        iconColor:[UIColor systemGreenColor]
                                                      switchValue:hideDiscoverScan
                                                 valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverScanKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 隐藏听一听
    self.hideDiscoverListenItem = [CSSettingItem switchItemWithTitle:@"隐藏听一听" 
                                                           iconName:@"headphones" 
                                                          iconColor:[UIColor systemCyanColor]
                                                        switchValue:hideDiscoverListen
                                                   valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverListenKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 隐藏看一看
    self.hideDiscoverLookItem = [CSSettingItem switchItemWithTitle:@"隐藏看一看" 
                                                         iconName:@"eye.fill" 
                                                        iconColor:[UIColor systemBlueColor]
                                                      switchValue:hideDiscoverLook
                                                 valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverLookKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 隐藏搜一搜
    self.hideDiscoverSearchItem = [CSSettingItem switchItemWithTitle:@"隐藏搜一搜" 
                                                           iconName:@"magnifyingglass" 
                                                          iconColor:[UIColor systemTealColor]
                                                        switchValue:hideDiscoverSearch
                                                   valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverSearchKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 隐藏附近的人
    self.hideDiscoverNearbyItem = [CSSettingItem switchItemWithTitle:@"隐藏附近的人" 
                                                           iconName:@"location.fill" 
                                                          iconColor:[UIColor systemMintColor]
                                                        switchValue:hideDiscoverNearby
                                                   valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverNearbyKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 隐藏游戏
    self.hideDiscoverGameItem = [CSSettingItem switchItemWithTitle:@"隐藏游戏" 
                                                         iconName:@"gamecontroller.fill" 
                                                        iconColor:[UIColor systemPurpleColor]
                                                      switchValue:hideDiscoverGame
                                                 valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverGameKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 隐藏小程序
    self.hideDiscoverMiniProgramItem = [CSSettingItem switchItemWithTitle:@"隐藏小程序" 
                                                                iconName:@"app.fill" 
                                                               iconColor:[UIColor systemYellowColor]
                                                             switchValue:hideDiscoverMiniProgram
                                                        valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideDiscoverMiniProgramKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    // 设置页面隐藏设置默认值
    BOOL hideSettingProfile = [defaults objectForKey:kWCHideSettingProfileKey] ? [defaults boolForKey:kWCHideSettingProfileKey] : NO;
    BOOL hideSettingAccountSecurity = [defaults objectForKey:kWCHideSettingAccountSecurityKey] ? [defaults boolForKey:kWCHideSettingAccountSecurityKey] : NO;
    BOOL hideSettingPrivacy = [defaults objectForKey:kWCHideSettingPrivacyKey] ? [defaults boolForKey:kWCHideSettingPrivacyKey] : NO;
    BOOL hideSettingNotification = [defaults objectForKey:kWCHideSettingNotificationKey] ? [defaults boolForKey:kWCHideSettingNotificationKey] : NO;
    BOOL hideSettingDisplay = [defaults objectForKey:kWCHideSettingDisplayKey] ? [defaults boolForKey:kWCHideSettingDisplayKey] : NO;
    BOOL hideSettingFriendPermission = [defaults objectForKey:kWCHideSettingFriendPermissionKey] ? [defaults boolForKey:kWCHideSettingFriendPermissionKey] : NO;
    BOOL hideSettingStorage = [defaults objectForKey:kWCHideSettingStorageKey] ? [defaults boolForKey:kWCHideSettingStorageKey] : NO;
    BOOL hideSettingMore = [defaults objectForKey:kWCHideSettingMoreKey] ? [defaults boolForKey:kWCHideSettingMoreKey] : NO;
    BOOL hideSettingChat = [defaults objectForKey:kWCHideSettingChatKey] ? [defaults boolForKey:kWCHideSettingChatKey] : NO;
    BOOL hideSettingCall = [defaults objectForKey:kWCHideSettingCallKey] ? [defaults boolForKey:kWCHideSettingCallKey] : NO;
    BOOL hideSettingChatHistory = [defaults objectForKey:kWCHideSettingChatHistoryKey] ? [defaults boolForKey:kWCHideSettingChatHistoryKey] : NO;
    BOOL hideSettingOther = [defaults objectForKey:kWCHideSettingOtherKey] ? [defaults boolForKey:kWCHideSettingOtherKey] : NO;
    BOOL hideSettingHelp = [defaults objectForKey:kWCHideSettingHelpKey] ? [defaults boolForKey:kWCHideSettingHelpKey] : NO;
    BOOL hideSettingAbout = [defaults objectForKey:kWCHideSettingAboutKey] ? [defaults boolForKey:kWCHideSettingAboutKey] : NO;
    BOOL hideSettingPlugin = [defaults objectForKey:kWCHideSettingPluginKey] ? [defaults boolForKey:kWCHideSettingPluginKey] : NO;
    BOOL hideSettingSwitchAccount = [defaults objectForKey:kWCHideSettingSwitchAccountKey] ? [defaults boolForKey:kWCHideSettingSwitchAccountKey] : NO;
    BOOL hideSettingLogout = [defaults objectForKey:kWCHideSettingLogoutKey] ? [defaults boolForKey:kWCHideSettingLogoutKey] : NO;
    
    // 设置页面隐藏选项
    self.hideSettingProfileItem = [CSSettingItem switchItemWithTitle:@"隐藏个人资料" 
                                                           iconName:@"person.fill" 
                                                          iconColor:[UIColor systemBlueColor]
                                                        switchValue:hideSettingProfile
                                                   valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingProfileKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingAccountSecurityItem = [CSSettingItem switchItemWithTitle:@"隐藏账号安全" 
                                                                   iconName:@"lock.shield.fill" 
                                                                  iconColor:[UIColor systemRedColor]
                                                                switchValue:hideSettingAccountSecurity
                                                           valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingAccountSecurityKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingPrivacyItem = [CSSettingItem switchItemWithTitle:@"隐藏个人信息与权限" 
                                                           iconName:@"hand.raised.fill" 
                                                          iconColor:[UIColor systemPurpleColor]
                                                        switchValue:hideSettingPrivacy
                                                   valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingPrivacyKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingNotificationItem = [CSSettingItem switchItemWithTitle:@"隐藏通知" 
                                                                iconName:@"bell.fill" 
                                                               iconColor:[UIColor systemOrangeColor]
                                                             switchValue:hideSettingNotification
                                                        valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingNotificationKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingDisplayItem = [CSSettingItem switchItemWithTitle:@"隐藏界面与显示" 
                                                           iconName:@"paintbrush.fill" 
                                                          iconColor:[UIColor systemPinkColor]
                                                        switchValue:hideSettingDisplay
                                                   valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingDisplayKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingFriendPermissionItem = [CSSettingItem switchItemWithTitle:@"隐藏朋友权限" 
                                                                    iconName:@"person.2.fill" 
                                                                   iconColor:[UIColor systemGreenColor]
                                                                 switchValue:hideSettingFriendPermission
                                                            valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingFriendPermissionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingStorageItem = [CSSettingItem switchItemWithTitle:@"隐藏存储空间" 
                                                           iconName:@"externaldrive.fill" 
                                                          iconColor:[UIColor systemGrayColor]
                                                        switchValue:hideSettingStorage
                                                   valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingStorageKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingMoreItem = [CSSettingItem switchItemWithTitle:@"隐藏更多" 
                                                        iconName:@"ellipsis.circle.fill" 
                                                       iconColor:[UIColor systemTealColor]
                                                     switchValue:hideSettingMore
                                                valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingMoreKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingChatItem = [CSSettingItem switchItemWithTitle:@"隐藏聊天" 
                                                        iconName:@"message.fill" 
                                                       iconColor:[UIColor systemGreenColor]
                                                     switchValue:hideSettingChat
                                                valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingChatKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingCallItem = [CSSettingItem switchItemWithTitle:@"隐藏音视频通话" 
                                                        iconName:@"video.fill" 
                                                       iconColor:[UIColor systemBlueColor]
                                                     switchValue:hideSettingCall
                                                valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingCallKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingChatHistoryItem = [CSSettingItem switchItemWithTitle:@"隐藏聊天记录管理" 
                                                               iconName:@"doc.text.fill" 
                                                              iconColor:[UIColor systemBrownColor]
                                                            switchValue:hideSettingChatHistory
                                                       valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingChatHistoryKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingOtherItem = [CSSettingItem switchItemWithTitle:@"隐藏其他" 
                                                         iconName:@"square.grid.2x2.fill" 
                                                        iconColor:[UIColor systemIndigoColor]
                                                      switchValue:hideSettingOther
                                                 valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingOtherKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingHelpItem = [CSSettingItem switchItemWithTitle:@"隐藏帮助与反馈" 
                                                        iconName:@"questionmark.circle.fill" 
                                                       iconColor:[UIColor systemCyanColor]
                                                     switchValue:hideSettingHelp
                                                valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingHelpKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingAboutItem = [CSSettingItem switchItemWithTitle:@"隐藏关于微信" 
                                                         iconName:@"info.circle.fill" 
                                                        iconColor:[UIColor systemGrayColor]
                                                      switchValue:hideSettingAbout
                                                 valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingAboutKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingPluginItem = [CSSettingItem switchItemWithTitle:@"隐藏插件" 
                                                          iconName:@"puzzlepiece.extension.fill" 
                                                         iconColor:[UIColor systemPurpleColor]
                                                       switchValue:hideSettingPlugin
                                                  valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingPluginKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingSwitchAccountItem = [CSSettingItem switchItemWithTitle:@"隐藏切换账号" 
                                                                 iconName:@"arrow.left.arrow.right" 
                                                                iconColor:[UIColor systemOrangeColor]
                                                              switchValue:hideSettingSwitchAccount
                                                         valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingSwitchAccountKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    self.hideSettingLogoutItem = [CSSettingItem switchItemWithTitle:@"隐藏退出登录" 
                                                          iconName:@"rectangle.portrait.and.arrow.right.fill" 
                                                         iconColor:[UIColor systemRedColor]
                                                       switchValue:hideSettingLogout
                                                  valueChangedBlock:^(BOOL isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kWCHideSettingLogoutKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)kWCSettingsChangedNotification, NULL, NULL, true);
    }];
    
    CSSettingItem *descriptionItem = [CSSettingItem itemWithTitle:@"功能说明" 
                                                        iconName:@"info.circle" 
                                                       iconColor:[UIColor systemGrayColor]
                                                         detail:@"点击查看"];
    
    // 创建各个分区
    CSSettingSection *qrcodeSection = [CSSettingSection sectionWithHeader:@"二维码设置" 
                                                                 items:@[self.hideQRCodeItem]];
    
    CSSettingSection *chatSection = [CSSettingSection sectionWithHeader:@"聊天界面设置" 
                                                                items:@[self.hideChatTimeItem, self.hidePatMessageItem, self.hideVoiceHintItem]];
    
    CSSettingSection *myPageSection = [CSSettingSection sectionWithHeader:@"我的页面设置" 
                                                                 items:@[self.hideMomentsItem, self.hideFavoriteItem, self.hideWalletItem, self.hideStickerItem, self.hideSettingsItem, self.hideServiceItem, self.hideChannelsItem, self.hideWorksItem]];
    
    // 创建发现页设置分区
    CSSettingSection *discoverSection = [CSSettingSection sectionWithHeader:@"发现页设置" 
                                                                   items:@[self.hideDiscoverChannelsItem, self.hideDiscoverLiveItem, self.hideDiscoverScanItem, self.hideDiscoverListenItem, self.hideDiscoverLookItem, self.hideDiscoverSearchItem, self.hideDiscoverNearbyItem, self.hideDiscoverGameItem, self.hideDiscoverMiniProgramItem]];
    
    // 创建设置页面设置分区
    CSSettingSection *settingSection = [CSSettingSection sectionWithHeader:@"设置页面设置" 
                                                                   items:@[self.hideSettingProfileItem, self.hideSettingAccountSecurityItem, self.hideSettingPrivacyItem, self.hideSettingNotificationItem, self.hideSettingDisplayItem, self.hideSettingFriendPermissionItem, self.hideSettingStorageItem, self.hideSettingMoreItem, self.hideSettingChatItem, self.hideSettingCallItem, self.hideSettingChatHistoryItem, self.hideSettingOtherItem, self.hideSettingHelpItem, self.hideSettingAboutItem, self.hideSettingPluginItem, self.hideSettingSwitchAccountItem, self.hideSettingLogoutItem]];
    
    CSSettingSection *descriptionSection = [CSSettingSection sectionWithHeader:@"说明" 
                                                                     items:@[descriptionItem]];
    
    // 设置sections数组
    self.sections = @[qrcodeSection, chatSection, myPageSection, discoverSection, settingSection, descriptionSection];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier]];
    
    // 获取当前项数据并配置cell
    CSSettingSection *section = self.sections[indexPath.section];
    CSSettingItem *item = section.items[indexPath.row];
    
    // 配置单元格
    [cell configureWithItem:item];
    
    // 如果是功能说明项，添加箭头指示器
    if ([item.title isEqualToString:@"功能说明"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    // 如果点击的是功能说明
    if ([item.title isEqualToString:@"功能说明"]) {
        // 显示功能说明弹窗
        [self showFeatureDescription];
        return;
    }
    
    // 处理不同类型的点击事件
    if (item.itemType == CSSettingItemTypeInput) {
        [CSUIHelper showInputAlertWithTitle:item.title
                                  message:nil
                               initialValue:item.inputValue
                               placeholder:item.inputPlaceholder
                          inViewController:self
                                completion:^(NSString *value) {
            // 更新item的值
            item.inputValue = value;
            item.detail = value;
            
            // 刷新表格
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            // 执行回调
            if (item.inputValueChanged) {
                item.inputValueChanged(value);
            }
        }];
    }
}

@end
