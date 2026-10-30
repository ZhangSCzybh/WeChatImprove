#import "CSScheduledTaskSettingsViewController.h"
#import "CSSettingsPresentation.h"
#import "CSScheduledTaskManager.h"
#import "CSNativeContactPicker.h"
#import "CSSettingTableViewCell.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendAutomationProjection.h"
#import "CSBackupBootstrap.h"
#include <math.h>

static void CSTaskAlert(UIViewController *vc, NSString *message) {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"定时任务" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
    [vc presentViewController:alert animated:YES completion:nil];
}
static NSString *CSDateText(NSDate *date, NSString *zone) {
    if (!date) return @"无后续执行";
    NSDateFormatter *f=[NSDateFormatter new]; f.dateFormat=@"yyyy-MM-dd HH:mm";
    f.timeZone=[NSTimeZone timeZoneWithName:zone?:NSTimeZone.localTimeZone.name]; return [f stringFromDate:date];
}
static CSSettingItem *CSTaskRow(NSString *title, NSString *icon, UIColor *color, NSString *detail, void (^action)(void)) {
    CSSettingItem *item=action?[CSSettingItem actionItemWithTitle:title iconName:icon iconColor:color]:
        [CSSettingItem itemWithTitle:title iconName:icon iconColor:color detail:detail];
    item.detail=detail; item.actionBlock=action; return item;
}

// Bound long conversation names and message previews locally, retaining the shared settings font and spacing.
@interface CSScheduledTaskSettingsCell : CSSettingTableViewCell
@end
@implementation CSScheduledTaskSettingsCell
+ (NSString *)reuseIdentifier { return @"CSScheduledTaskSettingsCell"; }
- (void)prepareForReuse { [super prepareForReuse]; self.settingSwitch=nil; }
- (void)configureWithItem:(CSSettingItem *)item {
    [super configureWithItem:item];
    self.textLabel.numberOfLines=1; self.detailTextLabel.numberOfLines=1;
    self.textLabel.lineBreakMode=NSLineBreakByTruncatingTail; self.detailTextLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.settingSwitch=nil;
    for (UIView *view in self.contentView.subviews) if ([view isKindOfClass:UISwitch.class]) self.settingSwitch=(UISwitch *)view;
    if (!item.actionBlock && item.itemType!=CSSettingItemTypeInput) self.selectionStyle=UITableViewCellSelectionStyleNone;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leading=54, gap=8, available=MAX(0,CGRectGetWidth(self.contentView.bounds)-leading-15), titleWidth=available;
    if (self.settingSwitch) titleWidth=MAX(0,available-self.settingSwitch.intrinsicContentSize.width-gap);
    else if (self.detailTextLabel.text.length) {
        CGFloat desiredTitle=[self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width;
        CGFloat reservedTitle=MIN(desiredTitle,MAX(0,(available-gap)*0.5));
        CGFloat detailWidth=MIN([self.detailTextLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width,MAX(0,available-reservedTitle-gap));
        CGRect detail=self.detailTextLabel.frame; detail.origin.x=leading+available-detailWidth; detail.size.width=detailWidth;
        self.detailTextLabel.frame=detail; titleWidth=MAX(0,available-detailWidth-gap);
    }
    CGRect title=self.textLabel.frame; title.origin.x=leading; title.size.width=titleWidth; self.textLabel.frame=title;
}
@end
static void CSTaskConfigureTable(UITableView *table) {
    table.backgroundColor=UIColor.systemGroupedBackgroundColor;
    table.separatorStyle=UITableViewCellSeparatorStyleSingleLine; table.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    [CSScheduledTaskSettingsCell registerToTableView:table];
}

@interface CSScheduledTaskTextEditor : UIViewController
@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) void (^completion)(NSString *);
@property(nonatomic,strong) UITextView *textView;
@end
@implementation CSScheduledTaskTextEditor
- (void)viewDidLoad {
    [super viewDidLoad]; self.title=@"消息内容"; self.view.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    UITextView *text=[UITextView new]; self.textView=text; text.text=self.text; text.accessibilityLabel=@"消息内容";
    text.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; text.adjustsFontForContentSizeCategory=YES;
    text.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor; text.textColor=UIColor.labelColor;
    text.layer.cornerRadius=10; text.textContainerInset=UIEdgeInsetsMake(12,12,12,12); text.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:text];
    [NSLayoutConstraint activateConstraints:@[
        [text.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],
        [text.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-16],
        [text.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [text.bottomAnchor constraintEqualToAnchor:self.view.keyboardLayoutGuide.topAnchor constant:-16]
    ]];
}
- (void)viewDidAppear:(BOOL)animated { [super viewDidAppear:animated]; [self.textView becomeFirstResponder]; }
- (void)done {
    if (self.textView.text.length>4000) { CSTaskAlert(self,@"消息内容不能超过 4,000 个字符。"); return; }
    if (self.completion) self.completion(self.textView.text?:@"");
    [self.navigationController popViewControllerAnimated:YES];
}
@end

@interface CSScheduledTaskTimeEditor : UIViewController
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,copy) NSString *zone;
@property(nonatomic) BOOL calendarMode;
@property(nonatomic,copy) void (^completion)(NSDate *);
@property(nonatomic,strong) UIDatePicker *picker;
@end
@implementation CSScheduledTaskTimeEditor
- (void)viewDidLoad {
    [super viewDidLoad]; self.view.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    UIDatePicker *picker=[UIDatePicker new]; self.picker=picker;
    picker.preferredDatePickerStyle=UIDatePickerStyleWheels; picker.datePickerMode=self.calendarMode?UIDatePickerModeTime:UIDatePickerModeDateAndTime;
    picker.timeZone=[NSTimeZone timeZoneWithName:self.zone]; picker.date=self.date; picker.minuteInterval=1;
    picker.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor; picker.layer.cornerRadius=10; picker.clipsToBounds=YES;
    picker.translatesAutoresizingMaskIntoConstraints=NO; [self.view addSubview:picker];
    UILabel *zone=[UILabel new]; zone.text=[NSString stringWithFormat:@"时区：%@",self.zone]; zone.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    zone.textColor=UIColor.secondaryLabelColor; zone.numberOfLines=0; zone.translatesAutoresizingMaskIntoConstraints=NO; [self.view addSubview:zone];
    [NSLayoutConstraint activateConstraints:@[
        [picker.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],
        [picker.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-16],
        [picker.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [zone.leadingAnchor constraintEqualToAnchor:picker.leadingAnchor constant:16],
        [zone.trailingAnchor constraintEqualToAnchor:picker.trailingAnchor constant:-16],
        [zone.topAnchor constraintEqualToAnchor:picker.bottomAnchor constant:12]
    ]];
}
- (void)done { if (self.completion) self.completion(self.picker.date); [self.navigationController popViewControllerAnimated:YES]; }
@end

@interface CSScheduledTaskEditor : UITableViewController
@property(nonatomic,strong) NSMutableDictionary *task;
@property(nonatomic,copy) NSString *account;
@property(nonatomic) NSUInteger accountEpoch;
@property(nonatomic) BOOL saving;
@property(nonatomic,copy) NSArray<CSSettingSection *> *sections;
@end
@implementation CSScheduledTaskEditor
- (void)viewDidLoad {
    [super viewDidLoad]; self.title=@"编辑任务"; CSTaskConfigureTable(self.tableView);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    for (NSString *name in @[CSScheduledTasksDidChange,CSCloseFriendPolicyDidChangeNotification,@"CSBackupAccountChanged"])
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(stateChanged:) name:name object:nil];
    [self reload];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; [self reload]; }
- (BOOL)canEdit {
    CSScheduledTaskStore *store=CSScheduledTaskManager.sharedManager.store;
    return !self.saving && !CSScheduledTaskManager.sharedManager.savingConfiguration && store.ready && [store.account isEqual:self.account] && CSBackupIsReady() && !CSBackupAccountIsSuspended() && self.accountEpoch==CSBackupAccountEpoch();
}
- (void)stateChanged:(NSNotification *)note {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self stateChanged:note]; }); return; }
    CSNativeContactPickerRevalidate(self); [self reload];
}
- (BOOL)intervalMode { return [@[@"minutes",@"hours"] containsObject:self.task[@"mode"]]; }
- (BOOL)calendarMode { return [@[@"daily",@"weekly"] containsObject:self.task[@"mode"]]; }
- (BOOL)windowMode { return [self.task[@"mode"] isEqual:@"window"]; }
- (NSString *)windowDaysText {
    NSArray *days=self.task[@"weekdays"];
    if ([days isEqual:@[@1,@2,@3,@4,@5,@6,@7]]) return @"每天";
    if ([days isEqual:@[@2,@3,@4,@5,@6]]) return @"周一至周五";
    NSMutableArray *names=[NSMutableArray array]; NSArray *labels=@[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (NSNumber *day in days) if (day.integerValue>=1 && day.integerValue<=7) [names addObject:labels[day.integerValue-1]];
    return names.count?[names componentsJoinedByString:@"、"]:@"请选择星期";
}
- (NSInteger)timeRowForTitle:(NSString *)title {
    NSArray *items=self.sections[1].items;
    NSUInteger row=[items indexOfObjectPassingTest:^BOOL(CSSettingItem *item,NSUInteger index,BOOL *stop){ (void)index;(void)stop; return [item.title isEqual:title]; }];
    return row==NSNotFound?0:(NSInteger)row;
}
- (void)reload {
    self.navigationItem.rightBarButtonItem.enabled=[self canEdit];
    self.navigationItem.rightBarButtonItem.title=self.saving?@"保存中…":@"保存";
    self.tableView.userInteractionEnabled=!self.saving;
    __weak typeof(self) weakSelf=self;
    CSSettingItem *title=CSTaskRow(@"任务名称",@"pencil",UIColor.systemBlueColor,self.task[@"title"],^{ [weakSelf input:@"title" title:@"任务名称" numeric:NO]; });
    CSSettingItem *enabled=[CSSettingItem switchItemWithTitle:@"启用此任务" iconName:@"checkmark.circle.fill" iconColor:UIColor.systemGreenColor switchValue:[self.task[@"enabled"] boolValue] valueChangedBlock:^(BOOL value){ weakSelf.task[@"enabled"]=@(value); }];
    CSSettingItem *target=CSTaskRow(@"发送到",@"person.crop.circle",UIColor.systemBlueColor,[CSScheduledTaskManager.sharedManager displayNameForTarget:self.task[@"target"]],^{ [weakSelf chooseTarget]; });
    NSString *preview=[self.task[@"text"] stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    CSSettingItem *text=CSTaskRow(@"消息内容",@"text.bubble",UIColor.systemGreenColor,preview.length?preview:@"请输入文字",^{ [weakSelf editText]; });
    NSMutableArray *times=[NSMutableArray arrayWithObject:CSTaskRow(@"时间规则",@"repeat",UIColor.systemOrangeColor,self.windowMode?@"时间段内执行":CSScheduledTaskRuleDescription(self.task),^{ [weakSelf chooseRule]; })];
    if (self.windowMode) {
        [times addObject:CSTaskRow(@"执行日期",@"calendar",UIColor.systemOrangeColor,[self windowDaysText],^{ [weakSelf chooseExecutionDays]; })];
        NSInteger start=[self.task[@"windowStart"] integerValue], end=[self.task[@"windowEnd"] integerValue];
        [times addObject:CSTaskRow(@"开始时间",@"clock",UIColor.systemOrangeColor,[NSString stringWithFormat:@"%02ld:%02ld",(long)(start/60),(long)(start%60)],^{ [weakSelf editWindowTime:@"windowStart"]; })];
        [times addObject:CSTaskRow(@"结束时间",@"clock",UIColor.systemOrangeColor,[NSString stringWithFormat:@"%@%02ld:%02ld",end<start?@"次日 ":@"",(long)(end/60),(long)(end%60)],^{ [weakSelf editWindowTime:@"windowEnd"]; })];
        BOOL minutes=[self.task[@"windowUnit"] isEqual:@"minutes"];
        [times addObject:CSTaskRow(@"间隔单位",@"timer",UIColor.systemOrangeColor,minutes?@"分钟":@"小时",^{ [weakSelf chooseWindowUnit]; })];
        [times addObject:CSTaskRow(@"执行间隔",@"timer",UIColor.systemOrangeColor,[NSString stringWithFormat:@"%@ %@",self.task[@"interval"],minutes?@"分钟":@"小时"],^{
            [weakSelf input:@"interval" title:[weakSelf.task[@"windowUnit"] isEqual:@"minutes"]?@"间隔分钟数（1–1440）":@"间隔小时数（1–168）" numeric:YES];
        })];
        [times addObject:CSTaskRow(@"生效时间",@"calendar.badge.clock",UIColor.systemOrangeColor,CSDateText(self.task[@"anchor"],self.task[@"zone"]),^{ [weakSelf editTime]; })];
    } else {
        NSString *time=self.calendarMode?[NSString stringWithFormat:@"%02ld:%02ld",(long)[self.task[@"hour"] integerValue],(long)[self.task[@"minute"] integerValue]]:CSDateText(self.task[@"anchor"],self.task[@"zone"]);
        [times addObject:CSTaskRow(self.calendarMode?@"每天时间":@"首次时间",@"clock",UIColor.systemOrangeColor,time,^{ [weakSelf editTime]; })];
    }
    if (self.intervalMode) [times addObject:CSTaskRow(@"间隔",@"timer",UIColor.systemOrangeColor,[NSString stringWithFormat:@"%@ %@",self.task[@"interval"],[self.task[@"mode"] isEqual:@"minutes"]?@"分钟":@"小时"],^{
        [weakSelf input:@"interval" title:[weakSelf.task[@"mode"] isEqual:@"minutes"]?@"间隔分钟数（1–1440）":@"间隔小时数（1–168）" numeric:YES];
    })];
    if ([self.task[@"mode"] isEqual:@"weekly"]) [times addObject:CSTaskRow(@"星期",@"calendar",UIColor.systemOrangeColor,CSScheduledTaskRuleDescription(self.task),^{ [weakSelf chooseWeekdays]; })];
    if (self.task[@"nextRun"]) [times addObject:CSTaskRow(@"已保存的下次执行",@"calendar.badge.clock",UIColor.systemGrayColor,CSDateText(self.task[@"nextRun"],self.task[@"zone"]),nil)];
    CSSettingItem *catchUp=[CSSettingItem switchItemWithTitle:@"允许补发最近一次" iconName:@"arrow.clockwise" iconColor:UIColor.systemPurpleColor switchValue:[self.task[@"catchUp"] boolValue] valueChangedBlock:^(BOOL value){ weakSelf.task[@"catchUp"]=@(value); }];
    self.sections=@[[CSSettingSection sectionWithHeader:@"任务内容" items:@[title,enabled,target,text]],
        [CSSettingSection sectionWithHeader:@"执行时间" items:times], [CSSettingSection sectionWithHeader:@"错过执行时间" items:@[catchUp]]];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.sections[section].items.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section==0) return @"每个任务向一个会话发送文字，消息内容最多 4,000 个字符。修改完成后点击右上角“保存”。";
    if (section==1 && self.windowMode) return [NSString stringWithFormat:@"不早于生效时间执行。包含开始时间，不包含结束时间；每个时段从开始时间重新计算间隔。结束早于开始表示次日，执行星期按开始当天计算。时段外不补发。任务按 %@ 执行；修改手机时区不会改变此任务的时区。",self.task[@"zone"]];
    if (section==1) return [NSString stringWithFormat:@"分钟/小时规则从首次时间起计算。每天/每周按 %@ 执行；修改手机时区不会改变此任务的时区。",self.task[@"zone"]];
    NSString *catchUp=@"关闭：错过超过 30 秒即跳过。开启：恢复运行后仅补发最近 10 分钟内的最后一次。总开关关闭期间不补发。";
    return self.windowMode?[catchUp stringByAppendingString:@"时间段任务仅在原执行时段内补发，时段结束后跳过。"]:catchUp;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSScheduledTaskSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSScheduledTaskSettingsCell.reuseIdentifier forIndexPath:path];
    [cell configureWithItem:self.sections[path.section].items[path.row]]; return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
    if (![self canEdit]) { CSTaskAlert(self,@"账号已改变或任务存储不可用，请重新打开定时任务。"); return; }
    CSSettingItem *item=self.sections[path.section].items[path.row]; if (item.actionBlock) item.actionBlock();
}
- (void)input:(NSString *)key title:(NSString *)title numeric:(BOOL)numeric {
    UIAlertController *a=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [a addTextFieldWithConfigurationHandler:^(UITextField *f){ f.text=[self.task[key] description]; f.keyboardType=numeric?UIKeyboardTypeNumberPad:UIKeyboardTypeDefault; }];
    [a addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [a addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        NSString *value=a.textFields.firstObject.text; self.task[key]=numeric?@([value integerValue]):value?:@""; [self reload];
    }]]; [self presentViewController:a animated:YES completion:nil];
}
- (void)presentSheet:(UIAlertController *)sheet section:(NSInteger)section row:(NSInteger)row {
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    sheet.popoverPresentationController.sourceView=self.tableView;
    sheet.popoverPresentationController.sourceRect=[self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    [self presentViewController:sheet animated:YES completion:nil];
}
- (void)chooseTarget {
    UIAlertController *sheet=[UIAlertController alertControllerWithTitle:@"选择发送会话" message:@"每个任务选择一个会话。更换选择时，请先取消原来的勾选。" preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"文件传输助手" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){ self.task[@"target"]=@"filehelper"; [self reload]; }]];
    __weak typeof(self) weakSelf=self;
    __weak UIAlertController *weakSheet=sheet;
    for (NSUInteger i=0;i<2;i++) [sheet addAction:[UIAlertAction actionWithTitle:i?@"群聊":@"私聊" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        [weakSelf finishTargetSheet:weakSheet groups:i==1];
    }]];
    [self presentSheet:sheet section:0 row:2];
}
- (BOOL)canPresentTargetPicker {
    return CSSettingsCanPresentFrom(self);
}
- (void)finishTargetSheet:(UIAlertController *)sheet groups:(BOOL)groups {
    __weak typeof(self) weakSelf=self;
    void (^showPicker)(void)=^{ [weakSelf presentTargetPicker:groups]; };
    CSSettingsAfterDismissingSheet(sheet,showPicker);
}
- (void)presentTargetPicker:(BOOL)groups {
    if (![self canPresentTargetPicker]) {
        return;
    }
    if (![self canEdit]) { CSTaskAlert(self,@"账号已改变或任务存储不可用，请重新打开定时任务。"); return; }
    __weak typeof(self) weakSelf=self;
    NSUInteger privacyEpoch=CSCloseFriendAccountEpoch(), revision=CSCloseFriendCurrentSnapshot().revision;
    NSString *target=self.task[@"target"];
    if ([target isEqual:@"filehelper"] || CSCloseFriendShouldHideUserName(target,CSCloseFriendSurfaceSession)) target=nil;
    NSError *error=nil;
    BOOL shown=CSNativeContactPickerPresentSingle(self,groups?@"选择一个群聊":@"选择一个好友",groups,target,^BOOL {
        return weakSelf && [weakSelf canEdit] && !CSCloseFriendCurrentSnapshot().blocked && privacyEpoch==CSCloseFriendAccountEpoch() && revision==CSCloseFriendCurrentSnapshot().revision;
    },^(NSString *name){
        if (![weakSelf canEdit]) return;
        if (CSCloseFriendShouldHideUserName(name,CSCloseFriendSurfaceSession)) { CSTaskAlert(weakSelf,@"请先解锁该会话后再选择。"); return; }
        weakSelf.task[@"target"]=name; [weakSelf reload];
    },&error);
    if (!shown) CSTaskAlert(self,error.localizedDescription?:@"当前无法打开微信原生选择器，原有发送会话已保留。");
}
- (void)editText {
    CSScheduledTaskTextEditor *editor=[CSScheduledTaskTextEditor new]; editor.text=self.task[@"text"];
    __weak typeof(self) weakSelf=self; editor.completion=^(NSString *text){ weakSelf.task[@"text"]=text; [weakSelf reload]; };
    [self.navigationController pushViewController:editor animated:YES];
}
- (void)editTime {
    CSScheduledTaskTimeEditor *editor=[CSScheduledTaskTimeEditor new]; editor.calendarMode=self.calendarMode; editor.zone=self.task[@"zone"];
    editor.title=self.windowMode?@"生效时间":self.calendarMode?@"每天时间":@"首次时间";
    NSCalendar *cal=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; cal.timeZone=[NSTimeZone timeZoneWithName:editor.zone];
    editor.date=self.calendarMode?[cal dateBySettingHour:[self.task[@"hour"] integerValue] minute:[self.task[@"minute"] integerValue] second:0 ofDate:NSDate.date options:0]:self.task[@"anchor"];
    BOOL calendarMode=self.calendarMode; __weak typeof(self) weakSelf=self;
    editor.completion=^(NSDate *date){
        if (calendarMode) { NSDateComponents *c=[cal components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date]; weakSelf.task[@"hour"]=@(c.hour); weakSelf.task[@"minute"]=@(c.minute); }
        else weakSelf.task[@"anchor"]=[NSDate dateWithTimeIntervalSince1970:floor(date.timeIntervalSince1970/60)*60];
        [weakSelf reload];
    };
    [self.navigationController pushViewController:editor animated:YES];
}
- (void)editWindowTime:(NSString *)key {
    CSScheduledTaskTimeEditor *editor=[CSScheduledTaskTimeEditor new]; editor.calendarMode=YES; editor.zone=self.task[@"zone"];
    editor.title=[key isEqual:@"windowStart"]?@"开始时间":@"结束时间";
    NSCalendar *cal=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; cal.timeZone=[NSTimeZone timeZoneWithName:editor.zone];
    NSInteger minute=[self.task[key] integerValue];
    editor.date=[cal dateBySettingHour:minute/60 minute:minute%60 second:0 ofDate:NSDate.date options:0];
    __weak typeof(self) weakSelf=self;
    editor.completion=^(NSDate *date){
        NSDateComponents *c=[cal components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
        weakSelf.task[key]=@(c.hour*60+c.minute); [weakSelf reload];
    };
    [self.navigationController pushViewController:editor animated:YES];
}
- (void)chooseExecutionDays {
    UIAlertController *sheet=[UIAlertController alertControllerWithTitle:@"执行日期" message:@"跨午夜的时段按开始当天的星期计算。" preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"每天" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){ self.task[@"weekdays"]=@[@1,@2,@3,@4,@5,@6,@7]; [self reload]; }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"周一至周五" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){ self.task[@"weekdays"]=@[@2,@3,@4,@5,@6]; [self reload]; }]];
    __weak typeof(self) weakSelf=self; __weak UIAlertController *weakSheet=sheet;
    [sheet addAction:[UIAlertAction actionWithTitle:@"自定义星期" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        CSSettingsAfterDismissingSheet(weakSheet,^{ if ([weakSelf canEdit] && CSSettingsCanPresentFrom(weakSelf)) [weakSelf chooseWeekdays]; });
    }]];
    [self presentSheet:sheet section:1 row:[self timeRowForTitle:@"执行日期"]];
}
- (void)chooseWindowUnit {
    UIAlertController *sheet=[UIAlertController alertControllerWithTitle:@"间隔单位" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *units=@[@"minutes",@"hours"], *names=@[@"分钟",@"小时"];
    for (NSUInteger i=0;i<units.count;i++) [sheet addAction:[UIAlertAction actionWithTitle:names[i] style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        self.task[@"windowUnit"]=units[i];
        if (i==1 && [self.task[@"interval"] integerValue]>168) self.task[@"interval"]=@1;
        [self reload];
    }]];
    [self presentSheet:sheet section:1 row:[self timeRowForTitle:@"间隔单位"]];
}
- (void)chooseRule {
    UIAlertController *sheet=[UIAlertController alertControllerWithTitle:@"时间规则" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *modes=@[@"once",@"minutes",@"hours",@"daily",@"weekly",@"window"], *names=@[@"单次",@"每 N 分钟",@"每 N 小时",@"每天",@"每周",@"时间段内执行"];
    for (NSUInteger i=0;i<modes.count;i++) [sheet addAction:[UIAlertAction actionWithTitle:names[i] style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        self.task[@"mode"]=modes[i]; if (self.calendarMode) self.task[@"anchor"]=NSDate.date;
        if ([modes[i] isEqual:@"hours"] && [self.task[@"interval"] integerValue]>168) self.task[@"interval"]=@1;
        if (self.windowMode) {
            if (!self.task[@"windowStart"]) { self.task[@"windowStart"]=@(9*60); self.task[@"windowEnd"]=@(18*60); self.task[@"weekdays"]=@[@1,@2,@3,@4,@5,@6,@7]; }
            if (!self.task[@"windowUnit"]) self.task[@"windowUnit"]=@"minutes";
            if ([self.task[@"windowUnit"] isEqual:@"hours"] && [self.task[@"interval"] integerValue]>168) self.task[@"interval"]=@1;
        }
        [self reload];
    }]];
    [self presentSheet:sheet section:1 row:0];
}
- (void)chooseWeekdays {
    UIAlertController *sheet=[UIAlertController alertControllerWithTitle:@"选择星期（可多次调整）" message:@"至少保留一天。" preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *names=@[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (NSUInteger i=0;i<7;i++) {
        NSNumber *day=@(i+1); BOOL selected=[self.task[@"weekdays"] containsObject:day];
        [sheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@ %@",selected?@"✓":@"",names[i]] style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
            NSMutableArray *days=[self.task[@"weekdays"] mutableCopy]; if (selected) [days removeObject:day]; else [days addObject:day];
            self.task[@"weekdays"]=[days sortedArrayUsingSelector:@selector(compare:)]; [self reload];
        }]];
    }
    [self presentSheet:sheet section:1 row:[self timeRowForTitle:self.windowMode?@"执行日期":@"星期"]];
}
- (void)save {
    if (![self canEdit]) { CSTaskAlert(self,@"账号已改变或任务存储不可用，请重新打开定时任务。"); return; }
    self.saving=YES;[self reload];
    [CSScheduledTaskManager.sharedManager saveTask:self.task account:self.account completion:^(BOOL success,NSError *error){
        self.saving=NO;[self reload];if(self.navigationController.topViewController!=self)return;
        if(success)[self.navigationController popViewControllerAnimated:YES];else CSTaskAlert(self,error.localizedDescription?:@"保存失败");
    }];
}
@end

@interface CSScheduledTaskSettingsViewController ()
@property(nonatomic,copy) NSArray<CSSettingSection *> *sections;
@property(nonatomic,copy) NSArray<NSDictionary *> *displayedTasks;
@property(nonatomic,copy) NSString *displayedAccount;
@property(nonatomic) NSUInteger displayedEpoch;
@end
@implementation CSScheduledTaskSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad]; self.title=@"定时任务"; CSTaskConfigureTable(self.tableView);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reload) name:CSScheduledTasksDidChange object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reload) name:CSCloseFriendPolicyDidChangeNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reload) name:@"CSBackupAccountChanged" object:nil];
    [CSScheduledTaskManager.sharedManager start]; [self reload];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; [CSScheduledTaskManager.sharedManager refresh]; [self reload]; }
- (void)reload {
    CSScheduledTaskManager *manager=CSScheduledTaskManager.sharedManager; CSScheduledTaskStore *store=manager.store;
    self.navigationItem.rightBarButtonItem.enabled=store.ready && !manager.savingConfiguration;
    self.displayedTasks=CSCloseFriendVisibleScheduledTasks(store.tasks,store.account,CSCloseFriendCurrentSnapshot()); self.displayedAccount=store.account;self.displayedEpoch=CSBackupAccountEpoch();
    __weak typeof(self) weakSelf=self;
    NSString *account=store.account?:@"";
    CSSettingItem *enabled=[CSSettingItem switchItemWithTitle:@"开启定时任务" iconName:@"calendar.badge.clock" iconColor:UIColor.systemOrangeColor switchValue:store.enabled valueChangedBlock:^(BOOL value){
        [manager setEnabled:value account:account completion:^(BOOL success,NSError *error){if(!success && weakSelf.navigationController.topViewController==weakSelf)CSTaskAlert(weakSelf,error.localizedDescription?:@"保存失败");[weakSelf reload];}];
    }];
    NSMutableArray *tasks=[NSMutableArray array], *history=[NSMutableArray array];
    for (NSDictionary *task in self.displayedTasks) {
        NSString *title=[NSString stringWithFormat:@"%@%@",[task[@"enabled"] boolValue]?@"":@"[停用] ",task[@"title"]];
        NSString *detail=[NSString stringWithFormat:@"%@ · %@",[manager displayNameForTarget:task[@"target"]],CSScheduledTaskRuleDescription(task)];
        [tasks addObject:CSTaskRow(title,@"text.bubble",[task[@"enabled"] boolValue]?UIColor.systemBlueColor:UIColor.systemGrayColor,detail,^{ [weakSelf edit:task account:account]; })];
    }
    if (!tasks.count) [tasks addObject:CSTaskRow(@"新建任务",@"plus.circle.fill",UIColor.systemGreenColor,nil,^{ [weakSelf add]; })];
    for (NSDictionary *entry in [store.history subarrayWithRange:NSMakeRange(0,MIN((NSUInteger)10,store.history.count))]) {
        NSString *detail=CSDateText(entry[@"date"],nil);
        [history addObject:CSTaskRow(entry[@"title"],@"clock.arrow.circlepath",UIColor.systemGrayColor,detail,^{
            CSTaskAlert(weakSelf,[NSString stringWithFormat:@"%@\n%@\n%@",entry[@"title"],detail,entry[@"detail"]]);
        })];
    }
    if (!history.count) [history addObject:CSTaskRow(@"暂无执行记录",@"clock.arrow.circlepath",UIColor.systemGrayColor,nil,nil)];
    self.sections=@[[CSSettingSection sectionWithHeader:@"功能设置" items:@[enabled]], [CSSettingSection sectionWithHeader:@"任务" items:tasks], [CSSettingSection sectionWithHeader:@"最近执行" items:history]];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.sections[section].items.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section==0) return [CSScheduledTaskManager.sharedManager.statusText stringByAppendingString:@"\n微信被系统挂起、强退或手机关机时无法保证准点发送。可在“后台运行”设置中查看运行状态。未确认的发送不会在重启后自动重试。"];
    if (section==1) return @"点击任务编辑并查看下次执行时间；左滑可启用、停止或删除。启用单项任务后仍需开启总开关才会执行。任务按账号保存在本机，并纳入配置备份。恢复后总开关关闭，执行记录不恢复；请检查会话和时间规则后手动开启。";
    return @"点击记录查看执行结果。“已提交微信发送”不代表对方已收到。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSScheduledTaskSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSScheduledTaskSettingsCell.reuseIdentifier forIndexPath:path];
    [cell configureWithItem:self.sections[path.section].items[path.row]];
    if (path.section==0) cell.settingSwitch.enabled=CSScheduledTaskManager.sharedManager.store.ready && !CSScheduledTaskManager.sharedManager.savingConfiguration;
    return cell;
}
- (void)edit:(NSDictionary *)task account:(NSString *)account {
    CSScheduledTaskStore *store=CSScheduledTaskManager.sharedManager.store;
    if (!store.ready || CSScheduledTaskManager.sharedManager.savingConfiguration || ![store.account isEqual:account]) { CSTaskAlert(self,@"账号已改变或任务存储不可用，请重新打开定时任务。"); return; }
    if (!CSCloseFriendVisibleScheduledTasks(@[task],account,CSCloseFriendCurrentSnapshot()).count) { [self reload]; return; }
    CSScheduledTaskEditor *vc=[[CSScheduledTaskEditor alloc] initWithStyle:UITableViewStyleInsetGrouped]; vc.task=[task mutableCopy]; vc.account=account; vc.accountEpoch=CSBackupAccountEpoch();
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)add {
    [self edit:@{@"id":NSUUID.UUID.UUIDString,@"title":@"定时消息",@"target":@"filehelper",@"text":@"",@"enabled":@YES,@"catchUp":@NO,@"mode":@"once",@"interval":@1,
        @"anchor":[NSDate dateWithTimeIntervalSince1970:ceil((NSDate.date.timeIntervalSince1970+300)/60)*60],@"hour":@9,@"minute":@0,@"weekdays":@[@2],@"zone":NSTimeZone.localTimeZone.name}
        account:CSScheduledTaskManager.sharedManager.store.account];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES]; CSSettingItem *item=self.sections[path.section].items[path.row]; if (item.actionBlock) item.actionBlock();
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)path { return !CSScheduledTaskManager.sharedManager.savingConfiguration && path.section==1 && path.row>=0 && (NSUInteger)path.row<self.displayedTasks.count; }
- (NSDictionary *)swipeTaskWithID:(NSString *)identifier account:(NSString *)account epoch:(NSUInteger)epoch {
    CSScheduledTaskManager *manager=CSScheduledTaskManager.sharedManager;CSScheduledTaskStore *store=manager.store;
    if (!store.ready || manager.savingConfiguration || CSBackupAccountEpoch()!=epoch || ![store.account isEqual:account]) return nil;
    for (NSDictionary *task in store.tasks) if ([task[@"id"] isEqual:identifier]) {
        return CSCloseFriendVisibleScheduledTasks(@[task],account,CSCloseFriendCurrentSnapshot()).count?task:nil;
    }
    return nil;
}
- (void)performTaskAction:(NSString *)identifier account:(NSString *)account epoch:(NSUInteger)epoch enabled:(BOOL)enabled remove:(BOOL)remove completion:(void(^)(BOOL))completion {
    NSDictionary *task=[self swipeTaskWithID:identifier account:account epoch:epoch];
    if (!task) { [self reload];completion(NO);return; }
    // The menu names a target state, never another inversion of the latest flag.
    // An explicit stop still saves: a single-use task turns itself off when
    // claimed, but its pending native handoff must also be revoked by Manager.
    if (!remove && enabled && [task[@"enabled"] boolValue]) { [self reload];completion(YES);return; }
    __weak typeof(self) weakSelf=self;
    CSScheduledTaskStoreCompletion finished=^(BOOL success,NSError *error){
        typeof(self) controller=weakSelf;
        if (!success && controller && controller.navigationController.topViewController==controller) CSTaskAlert(controller,error.localizedDescription?:@"操作失败");
        [controller reload];completion(success);
    };
    CSScheduledTaskManager *manager=CSScheduledTaskManager.sharedManager;
    if (remove) [manager removeTask:identifier account:account completion:finished];
    else { NSMutableDictionary *updated=[task mutableCopy];updated[@"enabled"]=@(enabled);[manager saveTask:updated account:account completion:finished]; }
}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)path {
    if (![self tableView:tableView canEditRowAtIndexPath:path]) return nil;
    NSDictionary *task=self.displayedTasks[path.row];NSString *identifier=task[@"id"],*account=self.displayedAccount;NSUInteger epoch=self.displayedEpoch;
    if (![self swipeTaskWithID:identifier account:account epoch:epoch]) return nil;
    BOOL enabled=![task[@"enabled"] boolValue];__weak typeof(self) weakSelf=self;
    UIContextualAction *toggle=[UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:enabled?@"启用":@"停止" handler:^(__unused UIContextualAction *action,__unused UIView *view,void(^done)(BOOL)){
        typeof(self) controller=weakSelf;if (!controller) { done(NO);return; }
        [controller performTaskAction:identifier account:account epoch:epoch enabled:enabled remove:NO completion:done];
    }];
    toggle.backgroundColor=enabled?UIColor.systemGreenColor:UIColor.systemOrangeColor;
    UIContextualAction *remove=[UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(__unused UIContextualAction *action,__unused UIView *view,void(^done)(BOOL)){
        typeof(self) controller=weakSelf;if (!controller) { done(NO);return; }
        [controller performTaskAction:identifier account:account epoch:epoch enabled:NO remove:YES completion:done];
    }];
    return [UISwipeActionsConfiguration configurationWithActions:@[remove,toggle]];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)style forRowAtIndexPath:(NSIndexPath *)path {
    if (style!=UITableViewCellEditingStyleDelete || ![self tableView:tableView canEditRowAtIndexPath:path]) return;
    NSDictionary *task=self.displayedTasks[path.row];
    if (!CSCloseFriendVisibleScheduledTasks(@[task],self.displayedAccount,CSCloseFriendCurrentSnapshot()).count) { [self reload]; return; }
    [CSScheduledTaskManager.sharedManager removeTask:task[@"id"] account:self.displayedAccount completion:^(BOOL success,NSError *error){if(!success && self.navigationController.topViewController==self)CSTaskAlert(self,error.localizedDescription?:@"删除失败");[self reload];}];
}
@end
