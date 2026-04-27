#import "CSRevokeSettingsViewController.h"
#import "CSSettingTableViewCell.h"

static NSString * const kWCHideRevokeMessageEnabledKey = @"com.wechat.tweak.hide_revoke_message_enabled";

@interface CSRevokeSettingsViewController ()
@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@end

@implementation CSRevokeSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.title = @"防止撤回";
    
    // 设置UI样式
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    // 注册设置单元格
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    // 设置数据
    [self setupData];
}

- (void)setupData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 创建防撤回开关
    CSSettingItem *enableItem = [CSSettingItem switchItemWithTitle:@"开启防撤回"
                                                         iconName:@"arrow.uturn.backward.circle"
                                                        iconColor:[UIColor systemRedColor]
                                                      switchValue:[defaults boolForKey:kRevokeEnabledKey]
                                                valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kRevokeEnabledKey];
        [defaults synchronize];
        
        // 发送通知，让Hook文件处理状态改变
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.revoke.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    // 创建隐藏撤回消息提示标签开关
    BOOL hideRevokeMessageEnabled = [defaults objectForKey:kWCHideRevokeMessageEnabledKey] ? [defaults boolForKey:kWCHideRevokeMessageEnabledKey] : NO;
    CSSettingItem *hideRevokeMessageItem = [CSSettingItem switchItemWithTitle:@"隐藏撤回消息提示标签"
                                                                   iconName:@"eye.slash"
                                                                  iconColor:[UIColor systemPurpleColor]
                                                                switchValue:hideRevokeMessageEnabled
                                                          valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kWCHideRevokeMessageEnabledKey];
        [defaults synchronize];
        
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.wechat.tweak.local_settings_changed" object:nil];
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.tweak.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    // 创建功能说明项
    CSSettingItem *infoItem = [CSSettingItem itemWithTitle:@"功能说明"
                                                 iconName:@"info.circle"
                                                iconColor:[UIColor systemBlueColor]
                                                  detail:nil];
    
    // 创建分组
    CSSettingSection *switchSection = [CSSettingSection sectionWithHeader:@"开关设置"
                                                                   items:@[enableItem, hideRevokeMessageItem]];
    
    CSSettingSection *infoSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[infoItem]];
    
    self.sections = @[switchSection, infoSection];
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
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    [cell configureWithItem:item];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return @"开启后，对方撤回的消息将被保留并显示提示。\n支持文本、图片、语音、视频、表情等消息类型。";
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 13.0, *)) {
        cell.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    if (@available(iOS 13.0, *)) {
        selectedBackgroundView.backgroundColor = [UIColor tertiarySystemGroupedBackgroundColor];
    } else {
        selectedBackgroundView.backgroundColor = [UIColor systemGray5Color];
    }
    cell.selectedBackgroundView = selectedBackgroundView;
}

@end
