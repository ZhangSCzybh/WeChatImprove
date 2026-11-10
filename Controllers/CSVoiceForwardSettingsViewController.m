#import "CSVoiceForwardSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import "CSMessageActionPreferences.h"
#import "CSVoicePlaybackPreferences.h"

@interface CSVoiceForwardSettingsViewController ()

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;

@end

@implementation CSVoiceForwardSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"语音转发";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self setupData];
}

- (void)setupData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CSSettingItem *voiceForwardEnabledItem = [CSSettingItem switchItemWithTitle:@"语音转发"
                                                                      iconName:@"waveform.circle.fill"
                                                                     iconColor:[UIColor systemGreenColor]
                                                                   switchValue:[defaults boolForKey:CSMessageActionVoiceForwardEnabledKey]
                                                             valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:CSMessageActionVoiceForwardEnabledKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            (__bridge CFStringRef)CSMessageActionVoiceForwardDarwinNotification,
            NULL,
            NULL,
            true
        );
    }];

    CSSettingItem *favoriteVoiceForwardEnabledItem = [CSSettingItem switchItemWithTitle:@"收藏语音转发"
                                                                              iconName:@"star.circle.fill"
                                                                             iconColor:[UIColor systemOrangeColor]
                                                                           switchValue:[defaults boolForKey:CSMessageActionFavoriteVoiceForwardEnabledKey]
                                                                     valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:CSMessageActionFavoriteVoiceForwardEnabledKey];
        [defaults synchronize];

        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            (__bridge CFStringRef)CSMessageActionVoiceForwardDarwinNotification,
            NULL,
            NULL,
            true
        );
    }];

    CSSettingItem *progressItem=[CSSettingItem switchItemWithTitle:@"语音进度拖动"
        iconName:@"slider.horizontal.3" iconColor:UIColor.systemTealColor
        switchValue:[defaults boolForKey:CSVoicePlaybackProgressEnabledKey]
        valueChangedBlock:^(BOOL enabled){
            [defaults setBool:enabled forKey:CSVoicePlaybackProgressEnabledKey];
            [defaults synchronize];
            CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                (__bridge CFStringRef)CSMessageActionVoiceForwardDarwinNotification,NULL,NULL,true);
        }];
    
    CSSettingItem *descriptionItem = [CSSettingItem itemWithTitle:@"功能说明"
                                                        iconName:@"info.circle"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:@"长按语音消息显示转发按钮"];
    
    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"功能设置"
                                                                 items:@[voiceForwardEnabledItem, favoriteVoiceForwardEnabledItem]];
    CSSettingSection *playbackSection=[CSSettingSection sectionWithHeader:@"播放控制" items:@[progressItem]];
    
    CSSettingSection *infoSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[descriptionItem]];
    
    self.sections = @[mainSection, playbackSection, infoSection];
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
    (void)tableView;
    if (section == 1) return @"开启后，以正在播放的语音气泡长度显示进度，在气泡上左右滑动可预览位置，松手后从该位置继续播放。此开关独立于语音转发和收藏语音转发。";
    return section == 2 ? @"开启收藏语音转发后，在收藏中打开单条语音，点击右上角菜单 → 发送给朋友 → 选择联系人。此开关独立于聊天中的语音转发。" : nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    if (item.actionBlock) {
        item.actionBlock();
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor tertiarySystemGroupedBackgroundColor];
    cell.selectedBackgroundView = selectedBackgroundView;
}

@end
