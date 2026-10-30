#import "CSBackgroundRunViewController.h"
#import "CSBackgroundRunManager.h"
#import "CSSettingTableViewCell.h"

@interface CSBackgroundRunViewController ()
@property(nonatomic, strong) NSArray<CSSettingSection *> *sections;
@end

@implementation CSBackgroundRunViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"后台运行设置";
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    [CSSettingTableViewCell registerToTableView:self.tableView];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(stateChanged:) name:CSBackgroundRunStateChangedNotification object:CSBackgroundRunManager.sharedManager];
    [CSBackgroundRunManager.sharedManager start];
    [self rebuildSections];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CSBackgroundRunManager.sharedManager reloadSettings];
    [self rebuildSections];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)stateChanged:(NSNotification *)notification { [self rebuildSections]; }
- (void)rebuildSections {
    CSBackgroundRunManager *manager=CSBackgroundRunManager.sharedManager;
    __weak typeof(self) weakSelf=self;
    CSSettingItem *toggle=[CSSettingItem switchItemWithTitle:@"后台运行" iconName:@"play.circle" iconColor:UIColor.systemGreenColor switchValue:manager.enabled valueChangedBlock:^(BOOL enabled) {
        NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:CSBackgroundRunDefaultsSuite];
        [defaults setBool:enabled forKey:CSBackgroundRunEnabledKey];
        [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunSettingsChangedNotification object:nil];
        [weakSelf rebuildSections];
    }];
    CSSettingItem *state=[CSSettingItem itemWithTitle:@"当前状态" iconName:@"waveform" iconColor:UIColor.systemBlueColor detail:manager.statusText];
    CSSettingItem *last=[CSSettingItem itemWithTitle:@"上次后台运行" iconName:@"clock" iconColor:UIColor.systemOrangeColor detail:manager.lastBackgroundResult];
    CSSettingItem *capability=[CSSettingItem itemWithTitle:@"后台音频支持" iconName:@"checkmark.shield" iconColor:UIColor.systemBlueColor detail:manager.supportsBackgroundAudio?@"当前微信包已声明":@"当前微信包未声明"];
    CSSettingItem *info=[CSSettingItem itemWithTitle:@"功能说明" iconName:@"info.circle" iconColor:UIColor.systemBlueColor detail:nil];
    self.sections=@[
        [CSSettingSection sectionWithHeader:@"开关设置" items:@[toggle]],
        [CSSettingSection sectionWithHeader:@"运行状态" items:@[state,last,capability]],
        [CSSettingSection sectionWithHeader:@"说明" items:@[info]]
    ];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.sections[section].items.count; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier];
    [cell configureWithItem:self.sections[indexPath.section].items[indexPath.row]];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section==0) return @"开启后，仅在后台尝试通过无声音频延长运行；回到前台立即释放保活资源。持续后台运行仍会增加耗电。";
    if (section==1) return @"状态表示本机音频启动结果，不代表系统保证持续运行或红包、收款已经成功。最近结果仅保留在本次微信进程中。";
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section!=2) return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"后台运行说明"
        message:@"适用于具备后台音频能力的微信安装包。开启后使用无声音频尝试延长后台运行，不需要设置触发间隔。\n\n返回前台或关闭开关时立即停止保活；微信通话、录音及系统音频中断优先，系统允许后再尝试恢复。启动失败不会反复重试，可回到前台后再切到后台。\n\n无法保证永久后台运行。系统挂起、结束进程或用户划掉微信后，插件无法自行唤醒微信；后台消息与自动领取仍依赖微信原生服务。"
        preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"了解了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
