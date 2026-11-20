#import "CSBackgroundBlurSettingsViewController.h"
#import "CSBackgroundBlurManager.h"
#import "CSSettingTableViewCell.h"

@interface CSBackgroundBlurSettingsViewController ()
@property(nonatomic, strong) CSSettingItem *blurItem;
@end

@implementation CSBackgroundBlurSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"后台模糊";
    self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    [CSSettingTableViewCell registerToTableView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:CSBackgroundBlurDefaultsSuite];
    self.blurItem = [CSSettingItem switchItemWithTitle:@"启用后台模糊"
                                            iconName:@"eye.slash"
                                           iconColor:UIColor.systemIndigoColor
                                         switchValue:[defaults boolForKey:CSBackgroundBlurEnabledKey]
                                   valueChangedBlock:^(BOOL enabled) {
        [defaults setBool:enabled forKey:CSBackgroundBlurEnabledKey];
        [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundBlurSettingsChangedNotification object:nil];
    }];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.blurItem ? 1 : 0; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier]];
    [cell configureWithItem:self.blurItem];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"开启后，切换应用、进入后台或打开控制中心等系统界面时，自动模糊微信页面；回到微信后恢复清晰。";
}

@end
