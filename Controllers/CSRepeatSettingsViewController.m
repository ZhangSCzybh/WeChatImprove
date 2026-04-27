#import "CSRepeatSettingsViewController.h"
#import "CSSettingTableViewCell.h"

static NSString * const kRepeatEnabledKey = @"com.wechat.enhance.repeat.enabled";

@interface CSRepeatSettingsViewController ()

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;

@end

@implementation CSRepeatSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"复读功能";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self setupData];
}

- (void)setupData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CSSettingItem *repeatEnabledItem = [CSSettingItem switchItemWithTitle:@"复读功能"
                                                                iconName:@"repeat.circle.fill"
                                                               iconColor:[UIColor systemPurpleColor]
                                                             switchValue:[defaults boolForKey:kRepeatEnabledKey]
                                                       valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kRepeatEnabledKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.repeat.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    CSSettingItem *descriptionItem = [CSSettingItem itemWithTitle:@"功能说明"
                                                        iconName:@"info.circle"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:@"长按消息显示复读按钮"];
    
    CSSettingItem *supportedTypesItem = [CSSettingItem itemWithTitle:@"支持类型"
                                                           iconName:@"doc.text"
                                                          iconColor:[UIColor systemOrangeColor]
                                                            detail:@"文字、图片、语音、视频、表情"];
    
    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"功能设置"
                                                                 items:@[repeatEnabledItem]];
    
    CSSettingSection *infoSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[descriptionItem, supportedTypesItem]];
    
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
