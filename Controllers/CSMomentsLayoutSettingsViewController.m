#import "CSMomentsLayoutSettingsViewController.h"
#import "CSMomentsLayoutPreferences.h"
#import "CSSettingTableViewCell.h"

@interface CSMomentsLayoutSettingsViewController ()
@property(nonatomic, strong) CSSettingItem *enabledItem;
@end

@implementation CSMomentsLayoutSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈布局";
    self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    [CSSettingTableViewCell registerToTableView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CSMomentsLayoutRefresh();
    self.enabledItem = [CSSettingItem switchItemWithTitle:@"启用瀑布流布局"
        iconName:@"rectangle.grid.2x2.fill" iconColor:UIColor.systemPinkColor
        switchValue:CSMomentsLayoutEnabled() valueChangedBlock:^(BOOL enabled) {
            CSMomentsLayoutSetEnabled(enabled);
        }];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return self.enabledItem ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    (void)indexPath;
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier];
    [cell configureWithItem:self.enabledItem];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return @"布局设置";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return @"默认关闭。开启后，朋友圈以双列瀑布流展示，卡片高度随封面比例和文字内容变化，显示头像、昵称、点赞与评论数量。\n\n点击卡片进入微信原生详情，可继续查看图片、视频并点赞、评论。更改后请退出并重新进入朋友圈。关闭后恢复微信原生布局。";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
