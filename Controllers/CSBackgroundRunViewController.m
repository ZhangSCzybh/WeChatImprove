#import "CSBackgroundRunViewController.h"
#import "CSBackgroundRunManager.h"
#import "CSBackgroundRunPolicy.h"
#import "CSSettingTableViewCell.h"
#include <math.h>

static void CSBackgroundRunAlert(UIViewController *controller, NSString *title, NSString *message) {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
    [controller presentViewController:alert animated:YES completion:nil];
}

// A daily minute is a wall-clock value, not an instant on today's DST calendar.
static NSCalendar *CSBackgroundRunWindowCalendar(void) {
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:0];
    return calendar;
}

// Keep both times in one draft. A cancelled or invalid draft never writes settings.
@interface CSBackgroundRunWindowEditor : UITableViewController
@property(nonatomic, copy) NSDictionary *policy;
@property(nonatomic, copy) BOOL (^saveWindow)(BOOL allDay, NSInteger start, NSInteger end, NSError **error);
@property(nonatomic, strong) UISwitch *allDaySwitch;
@property(nonatomic, strong) UIDatePicker *startPicker;
@property(nonatomic, strong) UIDatePicker *endPicker;
@end

@implementation CSBackgroundRunWindowEditor
- (UIDatePicker *)pickerWithMinute:(NSInteger)minute label:(NSString *)label {
    UIDatePicker *picker=[UIDatePicker new];
    picker.datePickerMode=UIDatePickerModeTime;
    picker.preferredDatePickerStyle=UIDatePickerStyleCompact;
    picker.minuteInterval=1;
    picker.accessibilityLabel=label;
    NSCalendar *calendar=CSBackgroundRunWindowCalendar();
    picker.calendar=calendar;
    picker.timeZone=calendar.timeZone;
    NSDateComponents *reference=[NSDateComponents new];
    reference.year=2001; reference.month=1; reference.day=1;
    reference.hour=minute/60; reference.minute=minute%60;
    picker.date=[calendar dateFromComponents:reference];
    return picker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"每日允许时段";
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.allDaySwitch=[UISwitch new];
    self.allDaySwitch.on=[self.policy[@"allDay"] boolValue];
    self.allDaySwitch.accessibilityLabel=@"全天允许后台运行";
    [self.allDaySwitch addTarget:self action:@selector(allDayChanged:) forControlEvents:UIControlEventValueChanged];
    self.startPicker=[self pickerWithMinute:[self.policy[@"startMinute"] integerValue] label:@"允许时段开始时间"];
    self.endPicker=[self pickerWithMinute:[self.policy[@"endMinute"] integerValue] label:@"允许时段结束时间"];
    [self allDayChanged:self.allDaySwitch];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView; return 2; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView; return section==0?1:2; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    (void)tableView;
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=path.section==0?@"全天":(path.row==0?@"开始时间":@"结束时间");
    cell.accessoryView=path.section==0?self.allDaySwitch:(path.row==0?self.startPicker:self.endPicker);
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    return section==0?@"关闭“全天”后，使用下方的每日时段。起止时间一起保存，取消不会修改设置。":@"使用设备当前时区；开始时间包含，结束时间不包含。开始晚于结束表示跨午夜，例如 22:00 至次日 07:00。起止时间不能相同；全天请使用上方开关。";
}
- (void)allDayChanged:(UISwitch *)sender {
    self.startPicker.enabled=self.endPicker.enabled=!sender.on;
    self.startPicker.alpha=self.endPicker.alpha=sender.on?0.45:1;
}
- (void)cancel { [self dismissViewControllerAnimated:YES completion:nil]; }
- (void)save {
    NSCalendar *calendar=CSBackgroundRunWindowCalendar();
    NSDateComponents *start=[calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self.startPicker.date];
    NSDateComponents *end=[calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self.endPicker.date];
    NSError *error=nil;
    if (!self.saveWindow || !self.saveWindow(self.allDaySwitch.on,start.hour*60+start.minute,end.hour*60+end.minute,&error)) {
        CSBackgroundRunAlert(self,@"无法保存时段",error.localizedDescription?:@"设置页已失效，请返回后重新打开。");
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

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
- (void)stateChanged:(NSNotification *)notification { (void)notification; [self rebuildSections]; }
- (NSString *)remainingDescription {
    CSBackgroundRunManager *manager=CSBackgroundRunManager.sharedManager;
    if (![manager.policy[@"maxMinutes"] integerValue]) return @"不限";
    NSTimeInterval remaining=manager.remainingDuration;
    if (remaining<0) return @"首次成功启动后计时";
    if (remaining<=0) return @"本次时长已用完";
    return [NSString stringWithFormat:@"约 %ld 分钟",(long)ceil(remaining/60.0)];
}
- (void)rebuildSections {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self rebuildSections]; }); return; }
    CSBackgroundRunManager *manager=CSBackgroundRunManager.sharedManager;
    NSDictionary *policy=manager.policy;
    __weak typeof(self) weakSelf=self;
    CSSettingItem *toggle=[CSSettingItem switchItemWithTitle:@"后台运行" iconName:@"play.circle" iconColor:UIColor.systemGreenColor switchValue:manager.enabled valueChangedBlock:^(BOOL enabled) {
        [CSBackgroundRunManager.sharedManager setEnabled:enabled];
        [weakSelf rebuildSections];
    }];
    CSSettingItem *window=[CSSettingItem actionItemWithTitle:@"每日允许时段" iconName:@"clock" iconColor:UIColor.systemBlueColor];
    window.detail=CSBackgroundRunPolicyWindowDescription(policy);
    window.actionBlock=^{ [weakSelf editWindow]; };
    NSInteger minutes=[policy[@"maxMinutes"] integerValue];
    CSSettingItem *limit=[CSSettingItem actionItemWithTitle:@"每次后台最长运行" iconName:@"hourglass" iconColor:UIColor.systemOrangeColor];
    limit.detail=minutes?[NSString stringWithFormat:@"%ld 分钟",(long)minutes]:@"不限";
    limit.actionBlock=^{ [weakSelf chooseDuration]; };
    CSSettingItem *energy=[CSSettingItem switchItemWithTitle:@"节能保护" iconName:@"leaf" iconColor:UIColor.systemGreenColor switchValue:[policy[@"energySaving"] boolValue] valueChangedBlock:^(BOOL enabled) {
        NSMutableDictionary *updated=[CSBackgroundRunManager.sharedManager.policy mutableCopy];
        updated[@"energySaving"]=@(enabled);
        [weakSelf savePolicy:updated];
    }];
    CSSettingItem *state=[CSSettingItem itemWithTitle:@"当前状态" iconName:@"waveform" iconColor:UIColor.systemBlueColor detail:manager.statusText];
    CSSettingItem *remaining=[CSSettingItem itemWithTitle:@"本轮剩余时长" iconName:@"timer" iconColor:UIColor.systemBlueColor detail:[self remainingDescription]];
    CSSettingItem *last=[CSSettingItem itemWithTitle:@"上次后台运行" iconName:@"clock.arrow.circlepath" iconColor:UIColor.systemOrangeColor detail:manager.lastBackgroundResult];
    CSSettingItem *capability=[CSSettingItem itemWithTitle:@"后台音频支持" iconName:@"checkmark.shield" iconColor:UIColor.systemBlueColor detail:manager.supportsBackgroundAudio?@"当前微信包已声明":@"当前微信包未声明"];
    CSSettingItem *info=[CSSettingItem actionItemWithTitle:@"功能说明" iconName:@"info.circle" iconColor:UIColor.systemBlueColor];
    info.actionBlock=^{ [weakSelf showInformation]; };
    self.sections=@[
        [CSSettingSection sectionWithHeader:@"开关设置" items:@[toggle]],
        [CSSettingSection sectionWithHeader:@"运行策略" items:@[window,limit,energy]],
        [CSSettingSection sectionWithHeader:@"运行状态" items:@[state,remaining,last,capability]],
        [CSSettingSection sectionWithHeader:@"说明" items:@[info]]
    ];
    [self.tableView reloadData];
}
- (BOOL)saveWindowAllDay:(BOOL)allDay start:(NSInteger)start end:(NSInteger)end error:(NSError **)error {
    if (!allDay && start==end) {
        if (error) *error=[NSError errorWithDomain:@"CSBackgroundRunSettings" code:1 userInfo:@{NSLocalizedDescriptionKey:@"起止时间不能相同。全天运行请打开“全天”。"}];
        return NO;
    }
    NSMutableDictionary *updated=[CSBackgroundRunManager.sharedManager.policy mutableCopy];
    updated[@"allDay"]=@(allDay); updated[@"startMinute"]=@(start); updated[@"endMinute"]=@(end);
    BOOL saved=[CSBackgroundRunManager.sharedManager savePolicy:updated error:error];
    [self rebuildSections];
    return saved;
}
- (void)savePolicy:(NSDictionary *)policy {
    NSError *error=nil;
    if (![CSBackgroundRunManager.sharedManager savePolicy:policy error:&error])
        CSBackgroundRunAlert(self,@"无法保存后台设置",error.localizedDescription?:@"设置未保存，请重试。");
    [self rebuildSections];
}
- (void)editWindow {
    CSBackgroundRunWindowEditor *editor=[[CSBackgroundRunWindowEditor alloc] initWithStyle:UITableViewStyleInsetGrouped];
    editor.policy=CSBackgroundRunManager.sharedManager.policy;
    __weak typeof(self) weakSelf=self;
    editor.saveWindow=^BOOL(BOOL allDay,NSInteger start,NSInteger end,NSError **error) {
        CSBackgroundRunViewController *controller=weakSelf;
        return controller?[controller saveWindowAllDay:allDay start:start end:end error:error]:NO;
    };
    UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:editor];
    navigation.modalPresentationStyle=UIModalPresentationPageSheet;
    navigation.sheetPresentationController.detents=@[UISheetPresentationControllerDetent.mediumDetent,UISheetPresentationControllerDetent.largeDetent];
    navigation.sheetPresentationController.prefersGrabberVisible=YES;
    [self presentViewController:navigation animated:YES completion:nil];
}
- (void)chooseDuration {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"每次后台最长运行" message:@"从本轮第一次成功启动保活起计时。中断或暂停仍消耗本轮时长；回到前台后再次进入后台，才开始新一轮。" preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf=self;
    for (NSNumber *minutes in @[@5,@15,@30,@60,@120,@0]) {
        NSString *title=minutes.integerValue?[NSString stringWithFormat:@"%ld 分钟",(long)minutes.integerValue]:@"不限";
        [alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            NSMutableDictionary *updated=[CSBackgroundRunManager.sharedManager.policy mutableCopy];
            updated[@"maxMinutes"]=minutes;
            [weakSelf savePolicy:updated];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    UIView *anchor=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]]?:self.view;
    alert.popoverPresentationController.sourceView=anchor;
    alert.popoverPresentationController.sourceRect=anchor.bounds;
    [self presentViewController:alert animated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView; return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView; return self.sections[section].items.count; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier];
    [cell configureWithItem:self.sections[indexPath.section].items[indexPath.row]];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { (void)tableView; return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (section==0) return @"仅在允许条件内尝试用无声音频延长后台运行；回到前台立即释放保活资源。持续后台运行仍会增加耗电。";
    if (section==1) return CSBackgroundRunManager.sharedManager.usesLegacyPolicy?@"当前沿用原设置：全天、不限时、节能保护关闭。打开页面或切换总开关不会改变这些规则；首次编辑并保存策略后，才使用所选限制。":@"时段使用设备当前时区，支持跨午夜。时长从本轮首次成功启动保活起计算，暂停期间仍计时；修改策略不会重置起点。";
    if (section==2) return @"剩余时长为本次查看值，返回页面或状态变化时更新。状态表示本机音频结果，不保证系统持续运行或任务成功；上次结果仅保留在本次微信进程。";
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CSSettingItem *item=self.sections[indexPath.section].items[indexPath.row];
    if (item.actionBlock) item.actionBlock();
}
- (void)showInformation {
    CSBackgroundRunAlert(self,@"后台运行说明",@"适用于具备后台音频能力的微信安装包。允许时段、每次最长时长和节能保护共同约束无声音频保活；前台立即停止。\n\n每次最长时长从本轮第一次成功启动保活起计算。微信通话、录音、系统音频中断或节能暂停期间仍计时；不会因切换开关、修改设置或恢复音频重新赠送时间。返回前台后再进入后台才开始新一轮。\n\n节能保护开启时，低电量模式、未充电且电量不足、系统热状态过高会暂停保活。系统严重过热时始终停止。微信通话、录音和宿主音频优先；启动失败不会循环重试。\n\n允许时段不能定时唤醒已被系统挂起或结束的微信，用户划掉进程后也无法自行启动。到期、离开时段或节能暂停后，微信可能挂起，AI 自动回复和定时任务可能无法及时执行；这不会关闭它们的功能设置。后台消息与自动领取仍依赖微信原生服务。");
}
@end
