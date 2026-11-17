#import "CSAdPurificationSettingsViewController.h"
#import "CSAdPurification.h"
#import "CSSettingTableViewCell.h"

@interface CSAdPurificationSettingsViewController ()
@property(nonatomic, copy) NSArray<CSSettingSection *> *sections;
@property(nonatomic) BOOL refreshPending;
@end

@implementation CSAdPurificationSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告净化";
    self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    [CSSettingTableViewCell registerToTableView:self.tableView];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(settingsChanged:)
        name:CSAdPurificationChangedNotification object:nil];
    [self rebuildSections];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self rebuildSections];
    [self.tableView reloadData];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)settingsChanged:(NSNotification *)notification {
    (void)notification;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        CSAdPurificationSettingsViewController *controller = weakSelf;
        if (!controller || controller.refreshPending) return;
        controller.refreshPending = YES;
        // Let the active switch action finish before replacing its cell.
        dispatch_async(dispatch_get_main_queue(), ^{
            CSAdPurificationSettingsViewController *visibleController = weakSelf;
            if (!visibleController) return;
            visibleController.refreshPending = NO;
            if (!visibleController.isViewLoaded || !visibleController.view.window ||
                visibleController.navigationController.topViewController != visibleController) return;
            [visibleController rebuildSections];
            [visibleController.tableView reloadData];
        });
    });
}

- (CSSettingItem *)switchWithTitle:(NSString *)title icon:(NSString *)icon
                              key:(NSString *)key color:(UIColor *)color {
    return [CSSettingItem switchItemWithTitle:title iconName:icon iconColor:color
        switchValue:CSAdPurificationSetting(key) valueChangedBlock:^(BOOL enabled) {
            CSAdPurificationSetSetting(key, enabled);
        }];
}

- (void)rebuildSections {
    CSSettingItem *enabled = [self switchWithTitle:@"启用广告净化"
        icon:@"line.3.horizontal.decrease.circle.fill" key:CSAdPurificationEnabledKey
        color:UIColor.systemTealColor];
    NSMutableArray<CSSettingItem *> *advertising = [NSMutableArray array];
    NSMutableArray<CSSettingItem *> *recommendations = [NSMutableArray array];
    for (NSDictionary *option in CSAdPurificationOptions()) {
        BOOL recommendation = [option[@"identifier"] isEqualToString:@"recommendations"];
        CSSettingItem *item = [self switchWithTitle:option[@"title"] icon:option[@"icon"]
            key:CSAdPurificationPreferenceKey(option[@"identifier"])
            color:recommendation ? UIColor.systemOrangeColor : UIColor.systemTealColor];
        [(recommendation ? recommendations : advertising) addObject:item];
    }
    self.sections = @[
        [CSSettingSection sectionWithHeader:@"总开关" items:@[enabled]],
        [CSSettingSection sectionWithHeader:@"广告范围" items:advertising],
        [CSSettingSection sectionWithHeader:@"可选推荐内容" items:recommendations]
    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier];
    [cell configureWithItem:self.sections[indexPath.section].items[indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    return self.sections[section].header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (section == 0) return @"总开关与各范围默认关闭。开启总开关后，所选范围才会生效；关闭总开关会保留各范围的选择。";
    if (section == 1) return @"请打开需要净化的广告范围。更改后重新打开相关页面生效；关闭后影响后续加载，当前页面已加载的内容可能需要重新进入。";
    return @"按需净化订阅号页面的推荐内容，与订阅号广告分别配置。此项也需要开启总开关。";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
