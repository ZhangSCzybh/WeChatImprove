#import "CSResetSettingsViewController.h"
#import "CSBackupManager.h"
#import "CSBackupPreviewViewController.h"
#import "CSBackupSettingsViewController.h"
#import "CSBackupSettingsCell.h"
@interface CSResetSettingsViewController ()
@property(nonatomic) NSArray<CSSettingSection *> *sections;
@property(nonatomic) BOOL busy;
@end
@implementation CSResetSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];self.title=@"重置设置";
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    [CSBackupSettingsCell registerToTableView:self.tableView];
    __weak typeof(self) weakSelf=self;
    // Use the same inherited typography as the normal rows on the transfer settings page.
    CSSettingItem *reset=[CSSettingItem itemWithTitle:@"重置范围" iconName:@"arrow.counterclockwise" iconColor:UIColor.systemRedColor detail:nil];
    reset.detail=@"预览";reset.actionBlock=^{[weakSelf previewReset];};
    CSSettingItem *backup=[CSSettingItem itemWithTitle:@"备份配置" iconName:@"archivebox.fill" iconColor:UIColor.systemBlueColor detail:nil];
    backup.actionBlock=^{[weakSelf.navigationController pushViewController:[[CSBackupSettingsViewController alloc]initWithStyle:UITableViewStyleInsetGrouped] animated:YES];};
    CSSettingItem *info=[CSSettingItem itemWithTitle:@"功能说明" iconName:@"info.circle" iconColor:UIColor.systemOrangeColor detail:nil];
    info.actionBlock=^{[weakSelf showExplanation];};
    self.sections=@[[CSSettingSection sectionWithHeader:@"重置插件配置" items:@[reset]],
                    [CSSettingSection sectionWithHeader:@"备份与说明" items:@[backup,info]]];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {(void)tableView;return self.sections.count;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {(void)tableView;return self.sections[section].items.count;}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {(void)tableView;return self.sections[section].header;}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    return section==0?@"先选择模块和账号、预览变化，确认后生成重置计划。重新打开微信时才会应用。":@"仅重置选中的插件配置。微信设置、登录状态、聊天记录和支付统计保持不变。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSBackupSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSBackupSettingsCell.reuseIdentifier];
    [cell configureWithItem:self.sections[path.section].items[path.row]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];if(!self.busy)[self.sections[path.section].items[path.row] performAction];
}
- (void)showExplanation {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"重置设置说明" message:@"只清除已登记且选中的插件配置，未选模块和其他账号保留。\n\n如需保留当前完整配置，请先到“备份配置”手动创建备份。重置不会额外创建备份，执行中断时依据本次操作日志回退；已丢失的图片会在预览中说明，无法找回。\n\n准备后请手动退出并重新打开微信。执行前可在备份页取消计划。" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];[self presentViewController:alert animated:YES completion:nil];
}
- (void)previewReset {
    self.busy=YES;self.tableView.userInteractionEnabled=NO;self.navigationItem.prompt=@"正在检查当前配置…";
    [CSBackupManager.sharedManager resetSnapshot:^(NSDictionary *snapshot,NSError *error){
        self.busy=NO;self.tableView.userInteractionEnabled=YES;self.navigationItem.prompt=nil;
        if(error){UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"无法准备重置" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];[alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];[self presentViewController:alert animated:YES completion:nil];}
        else [self.navigationController pushViewController:[[CSBackupPreviewViewController alloc]initWithSnapshot:snapshot] animated:YES];
    }];
}
@end
