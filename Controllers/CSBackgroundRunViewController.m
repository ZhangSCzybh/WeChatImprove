#import "CSBackgroundRunViewController.h"
#import "CSBackgroundRunManager.h"
#import "CSSettingTableViewCell.h"
#import <math.h>

@interface CSBackgroundRunViewController ()
@property(nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property(nonatomic, strong) NSDateFormatter *recordDateFormatter;
@property(nonatomic, strong) NSDateFormatter *fullRecordDateFormatter;
@property(nonatomic, strong) UIAlertAction *intervalSaveAction;
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
- (NSString *)recordTime:(NSDate *)date full:(BOOL)full fallback:(NSString *)fallback {
    if (!date) return fallback;
    NSDateFormatter *formatter=full?self.fullRecordDateFormatter:self.recordDateFormatter;
    if (!formatter) {
        formatter=[NSDateFormatter new];
        formatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        formatter.dateFormat=full?@"yyyy-MM-dd HH:mm:ss":@"MM-dd HH:mm:ss";
        if (full) self.fullRecordDateFormatter=formatter; else self.recordDateFormatter=formatter;
    }
    formatter.timeZone=NSTimeZone.localTimeZone;
    return [formatter stringFromDate:date];
}
- (NSString *)lastCheckToForegroundText:(CSBackgroundRunManager *)manager {
    NSTimeInterval interval=manager.lastCheckToForegroundInterval;
    if (!isfinite(interval) || interval<0) return @"尚无法计算";
    return [NSString stringWithFormat:@"%.1f 秒",interval];
}
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
    CSSettingItem *checkInterval=[CSSettingItem itemWithTitle:@"检查间隔" iconName:@"timer" iconColor:UIColor.systemBlueColor detail:[NSString stringWithFormat:@"%.0f 秒",manager.checkInterval]];
    CSSettingItem *capability=[CSSettingItem itemWithTitle:@"后台音频声明" iconName:@"checkmark.shield" iconColor:UIColor.systemBlueColor detail:manager.supportsBackgroundAudio?@"当前微信包已声明":@"当前微信包未声明"];
    BOOL hasRecord=manager.lastBackgroundStartedAt!=nil;
    CSSettingItem *last=[CSSettingItem itemWithTitle:@"最后状态" iconName:@"clock" iconColor:UIColor.systemOrangeColor detail:manager.lastBackgroundResult];
    CSSettingItem *started=[CSSettingItem itemWithTitle:manager.lastBackgroundStartObserved?@"进入后台":@"开始观察" iconName:@"arrow.down.circle" iconColor:UIColor.systemBlueColor detail:[self recordTime:manager.lastBackgroundStartedAt full:NO fallback:@"尚无记录"]];
    CSSettingItem *checked=[CSSettingItem itemWithTitle:@"最后检查" iconName:@"clock.arrow.circlepath" iconColor:UIColor.systemBlueColor detail:[self recordTime:manager.lastBackgroundCheckedAt full:NO fallback:@"尚未检查"]];
    CSSettingItem *checkState=[CSSettingItem itemWithTitle:@"检查时状态" iconName:@"waveform" iconColor:UIColor.systemBlueColor detail:manager.lastBackgroundCheckStatus.length?manager.lastBackgroundCheckStatus:@"尚未检查"];
    CSSettingItem *returned=[CSSettingItem itemWithTitle:@"返回前台" iconName:@"arrow.up.circle" iconColor:UIColor.systemBlueColor detail:[self recordTime:manager.lastForegroundReturnedAt full:NO fallback:hasRecord?@"尚未返回前台":@"尚无记录"]];
    CSSettingItem *stopped=[CSSettingItem itemWithTitle:@"停止时间" iconName:@"stop.circle" iconColor:UIColor.systemOrangeColor detail:[self recordTime:manager.lastBackgroundStoppedAt full:NO fallback:hasRecord?@"尚未停止":@"尚无记录"]];
    CSSettingItem *stopReason=[CSSettingItem itemWithTitle:@"停止原因" iconName:@"info.circle" iconColor:UIColor.systemOrangeColor detail:manager.lastBackgroundStopReason.length?manager.lastBackgroundStopReason:hasRecord?@"尚未停止":@"尚无记录"];
    CSSettingItem *interval=[CSSettingItem itemWithTitle:@"检查至返回间隔" iconName:@"timer" iconColor:UIColor.systemBlueColor detail:[self lastCheckToForegroundText:manager]];
    CSSettingItem *info=[CSSettingItem itemWithTitle:@"功能说明" iconName:@"info.circle" iconColor:UIColor.systemBlueColor detail:nil];
    self.sections=@[
        [CSSettingSection sectionWithHeader:@"开关设置" items:@[toggle,checkInterval]],
        [CSSettingSection sectionWithHeader:@"运行状态" items:@[state,capability]],
        [CSSettingSection sectionWithHeader:@"最近一次后台" items:@[last,started,checked,checkState,returned,stopped,stopReason,interval]],
        [CSSettingSection sectionWithHeader:@"说明" items:@[info]]
    ];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.sections[section].items.count; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier];
    [cell configureWithItem:self.sections[indexPath.section].items[indexPath.row]];
    if (indexPath.section==2 || (indexPath.section==0 && indexPath.row==1)) cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.accessibilityHint=indexPath.section==2?@"查看完整后台记录":(indexPath.section==0 && indexPath.row==1)?@"设置 10 至 30 秒的检查间隔":nil;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section==0) return @"进入后台后先在 1.5 秒检查一次，之后按设置的间隔检查；默认 25 秒，可设为 10–30 秒。剩余执行时间大于 0 且不足 30 秒时，尝试播放微信自带的短静音音频并续接后台任务。返回前台或关闭后释放资源，微信通话和录音优先。";
    if (section==1) return @"当前状态表示此刻可尝试的后台执行条件，不代表系统保证持续运行或红包、收款已经成功。后台音频声明仅表示安装包配置，不能证明系统已允许持续运行。";
    if (section==2) return @"仅保留当前微信进程中最近一次后台记录，时间按设备本地时区显示。最后检查仅证明该时刻执行过检查，不能证明此前一直运行；开始观察表示中途开始记录，不是真实进入后台时刻。点击任意记录查看完整信息。";
    return nil;
}
- (NSInteger)parsedCheckInterval:(NSString *)text {
    NSString *trimmed=[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (!trimmed.length) return NSNotFound;
    NSScanner *scanner=[NSScanner scannerWithString:trimmed];
    NSInteger interval=0;
    return [scanner scanInteger:&interval] && scanner.isAtEnd && interval>=10 && interval<=30?interval:NSNotFound;
}
- (void)checkIntervalInputChanged:(UITextField *)field {
    self.intervalSaveAction.enabled=[self parsedCheckInterval:field.text]!=NSNotFound;
}
- (void)showCheckIntervalEditor {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"检查间隔" message:@"输入 10–30 之间的整数秒数，默认 25 秒。间隔决定后台条件的检查频率，实际续接取决于系统剩余执行时间。" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf=self;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.keyboardType=UIKeyboardTypeNumberPad;
        field.text=[NSString stringWithFormat:@"%.0f",CSBackgroundRunManager.sharedManager.checkInterval];
        field.placeholder=@"10–30";
        field.accessibilityLabel=@"后台检查间隔，单位秒";
        [field addTarget:weakSelf action:@selector(checkIntervalInputChanged:) forControlEvents:UIControlEventEditingChanged];
    }];
    __weak UIAlertController *weakAlert=alert;
    self.intervalSaveAction=[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        CSBackgroundRunViewController *self=weakSelf;
        if (!self) return;
        NSInteger interval=[self parsedCheckInterval:weakAlert.textFields.firstObject.text];
        if (interval==NSNotFound) return;
        NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:CSBackgroundRunDefaultsSuite];
        [defaults setInteger:interval forKey:CSBackgroundRunCheckIntervalKey];
        [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunSettingsChangedNotification object:nil];
        [self rebuildSections];
    }];
    self.intervalSaveAction.enabled=[self parsedCheckInterval:alert.textFields.firstObject.text]!=NSNotFound;
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:self.intervalSaveAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)showLastBackgroundRecord {
    CSBackgroundRunManager *manager=CSBackgroundRunManager.sharedManager;
    BOOL hasRecord=manager.lastBackgroundStartedAt!=nil;
    NSString *message=[NSString stringWithFormat:@"最后状态：%@\n%@：%@\n最后检查：%@\n检查时状态：%@\n返回前台：%@\n停止时间：%@\n停止原因：%@\n检查至返回间隔：%@\n\n仅保留当前微信进程中最近一次记录。最后检查不能证明此前持续运行；开始观察不代表真实进入后台时刻。",
        manager.lastBackgroundResult,
        manager.lastBackgroundStartObserved?@"进入后台":@"开始观察",
        [self recordTime:manager.lastBackgroundStartedAt full:YES fallback:@"尚无记录"],
        [self recordTime:manager.lastBackgroundCheckedAt full:YES fallback:@"尚未检查"],
        manager.lastBackgroundCheckStatus.length?manager.lastBackgroundCheckStatus:@"尚未检查",
        [self recordTime:manager.lastForegroundReturnedAt full:YES fallback:hasRecord?@"尚未返回前台":@"尚无记录"],
        [self recordTime:manager.lastBackgroundStoppedAt full:YES fallback:hasRecord?@"尚未停止":@"尚无记录"],
        manager.lastBackgroundStopReason.length?manager.lastBackgroundStopReason:hasRecord?@"尚未停止":@"尚无记录",
        [self lastCheckToForegroundText:manager]];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"最近一次后台记录" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"了解了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0 && indexPath.row==1) { [self showCheckIntervalEditor]; return; }
    if (indexPath.section==2) { [self showLastBackgroundRecord]; return; }
    if (indexPath.section!=3) return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"后台运行说明"
        message:@"进入后台后申请系统允许的有限后台任务，1.5 秒后首次检查，之后按设置的间隔检查，默认 25 秒，可配置 10–30 秒。有效剩余时间大于 0 且不足 30 秒时，尝试短静音播放并续接后台任务。\n\n音源直接使用当前微信主包的 blank.caf，单次播放，不另外生成音频，也不无限循环。资源缺失或系统不允许播放时，当前状态会显示原因。播放正常结束后继续按间隔检查；音频播放和任务申请均不保证系统补充执行时间。\n\n微信通话、录音及系统音频中断优先，满足恢复条件后再尝试。返回前台或关闭后台运行后，停止检查并释放本插件的任务与音频资源。此开关控制本插件额外申请后台执行机会，群功能仍按自身设置和实际执行条件处理。\n\n当前状态和最近检查仅表示已观察到的执行条件，不能证明全程持续运行。后台消息和自动处理仍依赖微信原生服务；系统挂起、结束进程或用户划掉微信后，插件无法自行唤醒微信。"
        preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"了解了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
