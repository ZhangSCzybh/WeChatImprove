#import "CSClownSettingsViewController.h"
#import "CSClownPreferences.h"
#import "CSSettingTableViewCell.h"

@interface CSClownSettingsViewController ()
@property(nonatomic, copy) NSArray<CSSettingSection *> *sections;
@end

@implementation CSClownSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小丑功能";
    self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    [CSSettingTableViewCell registerToTableView:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadSettings];
}
- (CSSettingItem *)switchWithTitle:(NSString *)title iconName:(NSString *)iconName
                            color:(UIColor *)color key:(NSString *)key {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    __weak typeof(self) weakSelf = self;
    return [CSSettingItem switchItemWithTitle:title iconName:iconName iconColor:color
        switchValue:[defaults boolForKey:key] valueChangedBlock:^(BOOL isOn) {
            [defaults setBool:isOn forKey:key];
            [CSClownPreferences.sharedPreferences requestRefresh];
            [weakSelf reloadSettings];
        }];
}
- (void)reloadSettings {
    CSSettingItem *master = [self switchWithTitle:@"开启小丑功能" iconName:@"theatermasks.fill"
        color:UIColor.systemPurpleColor key:CSClownEnabledKey];
    NSMutableArray<CSSettingItem *> *items = [NSMutableArray arrayWithObject:master];
    if ([NSUserDefaults.standardUserDefaults boolForKey:CSClownEnabledKey]) {
        [items addObject:[self switchWithTitle:@"聊天文字修改" iconName:@"text.bubble.fill"
            color:UIColor.systemBlueColor key:CSClownTextEnabledKey]];
        [items addObject:[self switchWithTitle:@"聊天时间修改" iconName:@"clock.fill"
            color:UIColor.systemOrangeColor key:CSClownTimeEnabledKey]];
        [items addObject:[self switchWithTitle:@"聊天图片修改" iconName:@"photo.fill"
            color:UIColor.systemGreenColor key:CSClownImageEnabledKey]];
        [items addObject:[self switchWithTitle:@"聊天转账修改" iconName:@"yensign.circle.fill"
            color:UIColor.systemOrangeColor key:CSClownAmountEnabledKey]];
    }
    self.sections = @[[CSSettingSection sectionWithHeader:@"功能设置" items:items]];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"长按聊天文字、图片或转账，在菜单中选择修改；长按聊天中的系统时间可修改时间。金额最多两位小数。仅修改本机当前会话的显示，不上传，不改动原始聊天记录、真实转账或状态；离开会话后恢复原样。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier forIndexPath:path];
    [cell configureWithItem:self.sections[path.section].items[path.row]];
    return cell;
}
@end
