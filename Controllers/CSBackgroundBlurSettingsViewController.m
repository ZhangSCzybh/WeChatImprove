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
    return @"开启后，拉起 App 切换器或切到后台时，微信页面会显示模糊效果；回到微信后恢复清晰。\n\n下拉控制中心、通知中心或系统认证导致微信暂时失去活跃状态时，也会暂时模糊。关闭后立即移除后台模糊和密友的后台整屏遮罩；密友仍会在后台锁定，前台手动锁定时的短暂保护不受影响。";
}

@end
