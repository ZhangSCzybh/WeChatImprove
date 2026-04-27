#import "CSVoiceForwardSettingsViewController.h"
#import "CSSettingTableViewCell.h"

static NSString * const kVoiceForwardEnabledKey = @"com.wechat.enhance.voice_forward.enabled";

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
                                                                   switchValue:[defaults boolForKey:kVoiceForwardEnabledKey]
                                                             valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kVoiceForwardEnabledKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.voice_forward.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    CSSettingItem *descriptionItem = [CSSettingItem itemWithTitle:@"功能说明"
                                                        iconName:@"info.circle"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:@"长按语音消息显示转发按钮"];
    
    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"功能设置"
                                                                 items:@[voiceForwardEnabledItem]];
    
    CSSettingSection *infoSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[descriptionItem]];
    
    self.sections = @[mainSection, infoSection];
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    if (item.actionBlock) {
        item.actionBlock();
    }
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
