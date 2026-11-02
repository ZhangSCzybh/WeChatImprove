#import "CSBackgroundRunViewController.h"
#import "CSBackgroundRunManager.h"
#import "CSSettingTableViewCell.h"
#import <math.h>

@interface CSBackgroundRunViewController ()
@property(nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property(nonatomic, strong) NSDateFormatter *recordDateFormatter;
@property(nonatomic, strong) NSDateFormatter *fullRecordDateFormatter;
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
        [CSSettingSection sectionWithHeader:@"开关设置" items:@[toggle]],
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
    if (indexPath.section==2) cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.accessibilityHint=indexPath.section==2?@"查看完整后台记录":nil;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section==0) return @"开启后先使用系统允许的有限后台执行时间，剩余时间不足时再按需尝试近静音音频；回到前台或关闭开关时释放资源。后台运行仍可能增加耗电。";
    if (section==1) return @"当前状态表示此刻可尝试的后台执行条件，不代表系统保证持续运行或红包、收款已经成功。后台音频声明仅表示安装包配置，不能证明系统已允许持续运行。";
    if (section==2) return @"仅保留当前微信进程中最近一次后台记录，时间按设备本地时区显示。最后检查仅证明该时刻执行过检查，不能证明此前一直运行；开始观察表示中途开始记录，不是真实进入后台时刻。点击任意记录查看完整信息。";
    return nil;
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
    if (indexPath.section==2) { [self showLastBackgroundRecord]; return; }
    if (indexPath.section!=3) return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"后台运行说明"
        message:@"开启后优先申请系统允许的有限后台执行时间。有限剩余时间不足 8 秒时，若当前微信包已声明后台音频且音频可用，再尝试近静音循环音频接力；初次任务申请失败时也可尝试音频。音频至少播放 5 秒，有限预算恢复至至少 12 秒并经两次相隔至少 1 秒的检查确认后停止音频，继续利用系统任务。不需要设置触发间隔。\n\n音频提供继续执行的机会，不能保证给系统任务补充时间。音频期间显示的极大剩余时间不能证明停止音频后预算仍然充足，因此部分情况下音频仍会持续。\n\n返回前台或关闭开关时立即释放后台任务与音频资源；微信通话、录音及系统音频中断优先，允许后再尝试恢复。音频启动失败不会连续重试，可回到前台后再切到后台。\n\n当前状态只表示此刻可尝试的执行条件，安装包中的后台音频声明也不代表系统保证永久后台运行。系统挂起、结束进程或用户划掉微信后，插件无法自行唤醒微信；后台消息与自动领取仍依赖微信原生服务。"
        preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"了解了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
