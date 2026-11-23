#import "CSOtherSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import "CSSettingsHomeAppearance.h"

@interface CSOtherSettingsViewController ()
@property(nonatomic, strong) NSArray<CSSettingItem *> *items;
@end

@implementation CSOtherSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"其他设置";
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    [CSSettingTableViewCell registerToTableView:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.items=@[
        [CSSettingItem switchItemWithTitle:@"图标底色" iconName:@"square.fill"
            iconColor:UIColor.systemBlueColor switchValue:CSSettingsHomeAppearance.iconBackgroundEnabled
            valueChangedBlock:^(BOOL enabled) {
                [CSSettingsHomeAppearance setIconBackgroundEnabled:enabled];
            }],
        [CSSettingItem switchItemWithTitle:@"右侧箭头" iconName:@"chevron.right"
            iconColor:UIColor.systemBlueColor switchValue:CSSettingsHomeAppearance.disclosureArrowEnabled
            valueChangedBlock:^(BOOL enabled) {
                [CSSettingsHomeAppearance setDisclosureArrowEnabled:enabled];
            }]
    ];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.items.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return @"首页样式"; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"仅调整插件首页功能行的样式，两个开关默认关闭。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier];
    [cell configureWithItem:self.items[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
