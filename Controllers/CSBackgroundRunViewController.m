#import "CSBackgroundRunViewController.h"
#import "CSBackgroundRunManager.h"
#import "CSSettingTableViewCell.h"
#import <math.h>

static NSString *const CSBackgroundRunRecordExplanation=@"仅保留当前微信进程中最近一次后台过程。首次检查、周期检查与系统到期分别记录；最后评估也可能来自系统到期通知，不代表又执行了一次周期检查。记录和时间间隔不能证明全程持续保活。";

// The detail page receives text snapshots only. Reading historical records must
// never reload settings or request another background task.
@interface CSBackgroundRunRecordViewController : CSSettingsTableViewController
@property(nonatomic, copy) NSArray<NSDictionary<NSString *, NSString *> *> *summaryRows;
@property(nonatomic, copy) NSArray<NSDictionary<NSString *, NSString *> *> *eventRows;
@property(nonatomic, copy) NSString *timelineExplanation;
@property(nonatomic) BOOL hasRecord;
@end

@implementation CSBackgroundRunRecordViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"后台运行记录";
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=84;
    self.tableView.allowsSelection=NO;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"BackgroundRunRecordCell"];
    UIBarButtonItem *copy=[[UIBarButtonItem alloc] initWithTitle:@"复制记录" style:UIBarButtonItemStylePlain target:self action:@selector(copyRecord)];
    copy.enabled=self.hasRecord;
    copy.accessibilityLabel=@"复制后台运行摘要和事件时间线";
    self.navigationItem.rightBarButtonItem=copy;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 2; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?self.summaryRows.count:MAX((NSUInteger)1,self.eventRows.count);
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section==0?@"过程摘要":[NSString stringWithFormat:@"事件时间线（%lu 条）",(unsigned long)self.eventRows.count];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return section==0?CSBackgroundRunRecordExplanation:self.timelineExplanation;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BackgroundRunRecordCell" forIndexPath:indexPath];
    NSDictionary *row=indexPath.section==0?self.summaryRows[indexPath.row]:self.eventRows.count?self.eventRows[indexPath.row]:@{@"title":@"尚无事件记录",@"detail":@"进入后台后，关键检查和状态变化会记录在这里。"};
    UIListContentConfiguration *content=[cell defaultContentConfiguration];
    content.text=row[@"title"];
    content.secondaryText=row[@"detail"];
    content.textProperties.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    content.textProperties.color=UIColor.labelColor;
    content.textProperties.numberOfLines=0;
    content.textProperties.adjustsFontForContentSizeCategory=YES;
    content.secondaryTextProperties.font=[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    content.secondaryTextProperties.color=UIColor.secondaryLabelColor;
    content.secondaryTextProperties.numberOfLines=0;
    content.secondaryTextProperties.adjustsFontForContentSizeCategory=YES;
    content.textToSecondaryTextVerticalPadding=6;
    cell.contentConfiguration=content;
    cell.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)copyRecord {
    if (!self.hasRecord) return;
    NSMutableString *text=[NSMutableString stringWithString:@"后台运行记录\n\n过程摘要\n"];
    for (NSDictionary *row in self.summaryRows) [text appendFormat:@"%@：%@\n",row[@"title"],row[@"detail"]];
    [text appendString:@"\n事件时间线\n"];
    for (NSDictionary *row in self.eventRows) [text appendFormat:@"%@\n%@\n\n",row[@"title"],row[@"detail"]];
    if (!self.eventRows.count) [text appendString:@"尚无事件记录\n\n"];
    [text appendFormat:@"%@\n\n%@",self.timelineExplanation,CSBackgroundRunRecordExplanation];
    UIPasteboard.generalPasteboard.string=text;
    [CSUIHelper showCopySuccessToast:self];
}
@end

@interface CSBackgroundRunViewController ()
@property(nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property(nonatomic, strong) NSDateFormatter *recordDateFormatter;
@property(nonatomic, strong) NSDateFormatter *fullRecordDateFormatter;
@property(nonatomic, strong) UIAlertAction *intervalSaveAction;
@property(nonatomic) BOOL settingsPageVisible, sectionsDirty, sectionsRefreshPending;
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
    for (NSString *name in @[
        UIApplicationDidBecomeActiveNotification, UIApplicationWillResignActiveNotification, UIApplicationDidEnterBackgroundNotification,
        UISceneDidActivateNotification, UISceneWillDeactivateNotification, UISceneDidEnterBackgroundNotification
    ]) [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(activityChanged:) name:name object:nil];
    self.sectionsDirty=YES;
    [CSBackgroundRunManager.sharedManager start];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.settingsPageVisible=NO;
    self.sectionsDirty=YES;
    [CSBackgroundRunManager.sharedManager reloadSettings];
}
- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    self.settingsPageVisible=YES;
    // The window/scene are available here, before the first visible frame.
    // Settings notifications during viewWillAppear only marked this page dirty.
    [self refreshSectionsIfVisible];
}
- (void)viewWillDisappear:(BOOL)animated {
    self.settingsPageVisible=NO;
    [super viewWillDisappear:animated];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (BOOL)canRefreshSections {
    UIWindow *window=self.viewIfLoaded.window;
    if (!self.settingsPageVisible || !window || window.hidden || self.viewIfLoaded.hidden ||
        UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) return NO;
    if (self.navigationController && self.navigationController.topViewController!=self) return NO;
    UIScene *scene=window.windowScene;
    return !scene || scene.activationState==UISceneActivationStateForegroundActive;
}
- (void)refreshSectionsIfVisible {
    if (!self.sectionsDirty || ![self canRefreshSections]) return;
    self.sectionsDirty=NO;
    [self rebuildSections];
}
- (void)requestSectionsRefresh {
    if (self.sectionsRefreshPending || !self.sectionsDirty || ![self canRefreshSections]) return;
    self.sectionsRefreshPending=YES;
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(),^{
        CSBackgroundRunViewController *self=weakSelf;
        if (!self) return;
        self.sectionsRefreshPending=NO;
        // A queued notification may outlive visibility or foreground activity.
        [self refreshSectionsIfVisible];
    });
}
- (void)stateChanged:(NSNotification *)notification {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(),^{ [weakSelf stateChanged:nil]; });
        return;
    }
    self.sectionsDirty=YES;
    [self requestSectionsRefresh];
}
- (void)activityChanged:(NSNotification *)notification {
    if ([notification.object isKindOfClass:UIScene.class] && notification.object!=self.viewIfLoaded.window.windowScene) return;
    self.sectionsDirty=YES;
    if ([notification.name isEqual:UIApplicationDidBecomeActiveNotification] || [notification.name isEqual:UISceneDidActivateNotification])
        [self requestSectionsRefresh];
}
- (NSString *)recordTime:(NSDate *)date full:(BOOL)full fallback:(NSString *)fallback {
    if (!date) return fallback;
    NSDateFormatter *formatter=full?self.fullRecordDateFormatter:self.recordDateFormatter;
    if (!formatter) {
        formatter=[NSDateFormatter new];
        formatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        formatter.dateFormat=full?@"yyyy-MM-dd HH:mm:ss.SSS":@"MM-dd HH:mm:ss";
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
- (NSArray<NSDictionary<NSString *, NSString *> *> *)recordSummaryForManager:(CSBackgroundRunManager *)manager full:(BOOL)full {
    BOOL hasRecord=manager.lastBackgroundStartedAt!=nil;
    NSArray *summary=@[
        @{@"title":@"最后结果",@"icon":@"clock",@"detail":hasRecord?manager.lastBackgroundResult:@"尚无记录"},
        @{@"title":manager.lastBackgroundStartObserved?@"进入后台":@"开始观察",@"icon":@"arrow.down.circle",@"detail":[self recordTime:manager.lastBackgroundStartedAt full:full fallback:@"尚无记录"]},
        @{@"title":@"首次检查",@"icon":@"clock.badge.checkmark",@"detail":[self recordTime:manager.firstScheduledCheckAt full:full fallback:hasRecord?@"尚未记录":@"尚无记录"]},
        @{@"title":@"最近周期检查",@"icon":@"clock.arrow.circlepath",@"detail":[self recordTime:manager.lastPeriodicCheckAt full:full fallback:hasRecord?@"尚未记录":@"尚无记录"]},
        @{@"title":@"周期检查次数",@"icon":@"number.circle",@"detail":hasRecord?[NSString stringWithFormat:@"%lu 次",(unsigned long)manager.periodicCheckCount]:@"尚无记录"},
        @{@"title":@"系统到期时间",@"icon":@"hourglass",@"detail":[self recordTime:manager.lastTaskExpiredAt full:full fallback:hasRecord?@"未记录到期":@"尚无记录"]},
        @{@"title":@"停止时间",@"icon":@"stop.circle",@"detail":[self recordTime:manager.lastBackgroundStoppedAt full:full fallback:hasRecord?@"尚未停止":@"尚无记录"]},
        @{@"title":@"停止原因",@"icon":@"info.circle",@"detail":hasRecord?manager.lastBackgroundStopReason:@"尚无记录"},
        @{@"title":@"返回前台",@"icon":@"arrow.up.circle",@"detail":[self recordTime:manager.lastForegroundReturnedAt full:full fallback:hasRecord?@"尚未返回前台":@"尚无记录"]}
    ];
    if (!full) return summary;
    return [summary arrayByAddingObjectsFromArray:@[
        @{@"title":@"最后评估",@"icon":@"clock",@"detail":[self recordTime:manager.lastBackgroundCheckedAt full:full fallback:hasRecord?@"尚未评估":@"尚无记录"]},
        @{@"title":@"评估时状态",@"icon":@"waveform",@"detail":manager.lastBackgroundCheckedAt?manager.lastBackgroundCheckStatus:@"尚未评估"},
        @{@"title":@"评估至返回间隔",@"icon":@"timer",@"detail":[self lastCheckToForegroundText:manager]}
    ]];
}
- (void)rebuildSections {
    CSBackgroundRunManager *manager=CSBackgroundRunManager.sharedManager;
    __weak typeof(self) weakSelf=self;
    CSSettingItem *toggle=[CSSettingItem switchItemWithTitle:@"后台运行" iconName:@"play.circle" iconColor:UIColor.systemGreenColor switchValue:manager.enabled valueChangedBlock:^(BOOL enabled) {
        NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:CSBackgroundRunDefaultsSuite];
        [defaults setBool:enabled forKey:CSBackgroundRunEnabledKey];
        [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunSettingsChangedNotification object:nil];
        [weakSelf stateChanged:nil];
    }];
    CSSettingItem *state=[CSSettingItem itemWithTitle:@"当前状态" iconName:@"waveform" iconColor:UIColor.systemBlueColor detail:manager.statusText];
    CSSettingItem *checkInterval=[CSSettingItem itemWithTitle:@"检查间隔" iconName:@"timer" iconColor:UIColor.systemBlueColor detail:[NSString stringWithFormat:@"%.0f 秒",manager.checkInterval]];
    CSSettingItem *capability=[CSSettingItem itemWithTitle:@"后台音频声明" iconName:@"checkmark.shield" iconColor:UIColor.systemBlueColor detail:manager.supportsBackgroundAudio?@"当前微信包已声明":@"当前微信包未声明"];
    NSMutableArray<CSSettingItem *> *recordItems=[NSMutableArray new];
    NSArray *summary=[self recordSummaryForManager:manager full:NO];
    for (NSDictionary *row in summary) {
        [recordItems addObject:[CSSettingItem itemWithTitle:row[@"title"] iconName:row[@"icon"] iconColor:UIColor.systemBlueColor detail:row[@"detail"]]];
    }
    [recordItems addObject:[CSSettingItem itemWithTitle:@"事件时间线" iconName:@"list.bullet.rectangle" iconColor:UIColor.systemBlueColor detail:[NSString stringWithFormat:@"%lu 条记录",(unsigned long)manager.lastBackgroundEventCount]]];
    CSSettingItem *info=[CSSettingItem itemWithTitle:@"功能说明" iconName:@"info.circle" iconColor:UIColor.systemBlueColor detail:nil];
    self.sections=@[
        [CSSettingSection sectionWithHeader:@"开关设置" items:@[toggle,checkInterval]],
        [CSSettingSection sectionWithHeader:@"运行状态" items:@[state,capability]],
        [CSSettingSection sectionWithHeader:@"最近一次后台" items:recordItems],
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
    cell.accessibilityHint=indexPath.section==2?@"查看后台运行摘要和事件时间线，可复制记录":(indexPath.section==0 && indexPath.row==1)?@"设置 10 至 30 秒的检查间隔":nil;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section==0) return @"进入后台后先在 1.5 秒检查一次，之后按设置的间隔检查；默认 25 秒，可设为 10–30 秒。剩余执行时间大于 0 且不足 30 秒时，尝试播放微信自带的短静音音频并续接后台任务。返回前台或关闭后释放资源，微信通话和录音优先。";
    if (section==1) return @"当前状态表示此刻可尝试的后台执行条件，不代表系统保证持续运行或红包、收款已经成功。后台音频声明仅表示安装包配置，不能证明系统已允许持续运行。";
    if (section==2) return @"首次检查、周期检查和系统到期分别显示，互不覆盖。点击任意记录查看可滚动、可复制的事件时间线。仅保留当前微信进程中最近一次后台过程；记录不代表全程持续保活。";
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
        [self stateChanged:nil];
    }];
    self.intervalSaveAction.enabled=[self parsedCheckInterval:alert.textFields.firstObject.text]!=NSNotFound;
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:self.intervalSaveAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)showLastBackgroundRecord {
    CSBackgroundRunManager *manager=CSBackgroundRunManager.sharedManager;
    NSArray<CSBackgroundRunRecordEvent *> *events=manager.lastBackgroundEvents;
    NSUInteger dropped=manager.droppedBackgroundEventCount;
    NSMutableArray *eventRows=[NSMutableArray new];
    for (CSBackgroundRunRecordEvent *event in events) {
        NSString *offset=isfinite(event.elapsed) && event.elapsed>=0?[NSString stringWithFormat:@"+%.3f 秒",event.elapsed]:@"相对时间未知";
        [eventRows addObject:@{@"title":[NSString stringWithFormat:@"%@ · %@",event.source,offset],@"detail":[NSString stringWithFormat:@"%@\n%@",[self recordTime:event.date full:YES fallback:@"时间未知"],event.detail]}];
    }
    NSString *origin=manager.lastBackgroundStartObserved?@"进入后台":@"开始观察";
    NSString *timing=[NSString stringWithFormat:@"显示打开本页时的记录快照。时间为设备本地的事件处理时刻；“+秒数”从%@计算，用于比较先后与间隔。开始观察表示中途开始记录。",origin];
    NSString *retention=dropped?[NSString stringWithFormat:@"最多保留 80 条事件。已省略 %lu 条中间事件；当前保留本次开始 1 条及最近 %lu 条事件。",(unsigned long)dropped,(unsigned long)(events.count?events.count-1:0)]:@"事件按发生顺序显示，最多保留 80 条；达到上限后保留本次开始 1 条及最近 79 条事件。";
    CSBackgroundRunRecordViewController *record=[[CSBackgroundRunRecordViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
    record.summaryRows=[self recordSummaryForManager:manager full:YES];
    record.eventRows=eventRows;
    record.timelineExplanation=[NSString stringWithFormat:@"%@\n%@",retention,timing];
    record.hasRecord=manager.lastBackgroundStartedAt!=nil;
    [self.navigationController pushViewController:record animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0 && indexPath.row==1) { [self showCheckIntervalEditor]; return; }
    if (indexPath.section==2) { [self showLastBackgroundRecord]; return; }
    if (indexPath.section!=3) return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"后台运行说明"
        message:@"进入后台后申请系统允许的有限后台任务，1.5 秒后首次检查，之后按设置的间隔检查，默认 25 秒，可配置 10–30 秒。有效剩余时间大于 0 且不足 30 秒时，尝试短静音播放并续接后台任务。\n\n音源直接使用当前微信主包的 blank.caf，单次播放，不另外生成音频，也不无限循环。资源缺失或系统不允许播放时，当前状态会显示原因。播放正常结束后继续按间隔检查；音频播放和任务申请均不保证系统补充执行时间。\n\n微信自身使用音频时优先让出，释放后再尝试；其他 App 播放音乐或视频时，保活音频以混音方式继续尝试，不主动打断对方播放。电话、Siri 等系统音频中断不会主动终止保活请求；当前音频被系统停用后，保留可用的有限后台任务，并按原周期继续尝试。中断结束后也会重新检查，实际能否播放由系统决定。返回前台或关闭后台运行后，停止检查并释放本插件的任务与音频资源。此开关控制本插件额外申请后台执行机会，群功能仍按自身设置和实际执行条件处理。\n\n当前状态和最近检查仅表示已观察到的执行条件，不能证明全程持续运行。后台消息和自动处理仍依赖微信原生服务；系统挂起、结束进程或用户划掉微信后，插件无法自行唤醒微信。"
        preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"了解了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
