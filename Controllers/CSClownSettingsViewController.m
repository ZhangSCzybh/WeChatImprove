#import "CSClownSettingsViewController.h"
#import "CSClownPreferences.h"
#import "CSSettingTableViewCell.h"
#import "CSNativeContactPicker.h"
#import "CSChatNativeBridge.h"
#import "CSBackupBootstrap.h"

@interface CSClownSettingsViewController ()
@property(nonatomic, copy) NSArray<CSSettingSection *> *sections;
@end

@implementation CSClownSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小丑功能";
    self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    [CSSettingTableViewCell registerToTableView:self.tableView];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(accountChanged:) name:@"CSBackupAccountChanged" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(accountChanged:) name:CSClownSettingsDidChangeNotification object:CSClownPreferences.sharedPreferences];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)accountChanged:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(), ^{ CSNativeContactPickerRevalidate(self); [self reloadSettings]; });
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadSettings];
}
- (CSSettingItem *)switchWithTitle:(NSString *)title iconName:(NSString *)iconName
                            color:(UIColor *)color key:(NSString *)key {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    __weak typeof(self) weakSelf = self;
    return [CSSettingItem switchItemWithTitle:title iconName:iconName iconColor:color
        switchValue:[defaults boolForKey:key] valueChangedBlock:^(BOOL isOn) {
            [defaults setBool:isOn forKey:key];
            [CSClownPreferences.sharedPreferences requestRefresh];
            [weakSelf reloadSettings];
        }];
}
- (void)reloadSettings {
    CSSettingItem *master = [self switchWithTitle:@"开启小丑功能" iconName:@"theatermasks.fill"
        color:UIColor.systemPurpleColor key:CSClownEnabledKey];
    NSMutableArray<CSSettingItem *> *items = [NSMutableArray arrayWithObject:master];
    if ([NSUserDefaults.standardUserDefaults boolForKey:CSClownEnabledKey]) {
        [items addObject:[self switchWithTitle:@"聊天文字修改" iconName:@"text.bubble.fill"
            color:UIColor.systemBlueColor key:CSClownTextEnabledKey]];
        [items addObject:[self switchWithTitle:@"聊天时间修改" iconName:@"clock.fill"
            color:UIColor.systemOrangeColor key:CSClownTimeEnabledKey]];
        [items addObject:[self switchWithTitle:@"聊天图片修改" iconName:@"photo.fill"
            color:UIColor.systemGreenColor key:CSClownImageEnabledKey]];
        [items addObject:[self switchWithTitle:@"聊天转账修改" iconName:@"yensign.circle.fill"
            color:UIColor.systemOrangeColor key:CSClownAmountEnabledKey]];
        [items addObject:[self switchWithTitle:@"你别冷漠好不好" iconName:@"heart.text.square.fill"
            color:UIColor.systemPinkColor key:CSClownWarmthEnabledKey]];
        if ([NSUserDefaults.standardUserDefaults boolForKey:CSClownWarmthEnabledKey]) {
            for (NSNumber *group in @[@NO, @YES]) {
                BOOL groups = group.boolValue;
                NSArray *names = [CSClownPreferences.sharedPreferences.snapshot warmthTargetsForAccount:CSMessageCurrentAccount() groups:groups];
                CSSettingItem *item = [CSSettingItem itemWithTitle:groups ? @"生效群聊" : @"生效联系人"
                    iconName:groups ? @"person.3.fill" : @"person.fill" iconColor:UIColor.systemBlueColor
                    detail:[NSString stringWithFormat:@"已选 %lu 个", (unsigned long)names.count]];
                __weak typeof(self) weakSelf = self;
                item.actionBlock = ^{ [weakSelf selectWarmthTargets:groups]; };
                [items addObject:item];
            }
        }
        [items addObject:[self switchWithTitle:@"假的引用好玩吗" iconName:@"quote.bubble.fill"
            color:UIColor.systemTealColor key:CSClownFakeQuoteEnabledKey]];
    }
    self.sections = @[[CSSettingSection sectionWithHeader:@"功能设置" items:items]];
    [self.tableView reloadData];
}
- (void)selectWarmthTargets:(BOOL)groups {
    NSString *account = CSMessageCurrentAccount(); NSUInteger epoch = CSBackupAccountEpoch();
    if (!account.length || CSBackupAccountIsSuspended()) return;
    CSClownPreferences *preferences = CSClownPreferences.sharedPreferences;
    NSArray *selected = [preferences.snapshot warmthTargetsForAccount:account groups:groups];
    BOOL (^valid)(void) = ^BOOL { return [account isEqual:CSMessageCurrentAccount()] && epoch == CSBackupAccountEpoch() && !CSBackupAccountIsSuspended(); };
    __weak typeof(self) weakSelf = self; NSError *error = nil;
    BOOL shown = CSNativeContactPickerPresent(self, groups ? @"选择生效群聊" : @"选择生效联系人", groups, selected, valid,
        ^(NSArray<NSString *> *names) {
            if (!valid()) return;
            [preferences setWarmthTargets:names account:account groups:groups];
            [weakSelf reloadSettings];
        }, &error);
    if (!shown) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"小丑功能" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"长按修改\n"
        @"开启总开关和对应子项后，长按聊天文字、图片或转账可修改显示，长按系统时间可修改时间。\n\n"
        @"你别冷漠好不好\n"
        @"开启后，请先选择“生效联系人”或“生效群聊”，未选择时不生效。只在所选私聊或群聊中，将别人发来的整条纯文本“嗯、奥、恩、嗷、嗷嗷、行、好、可以、可、成、ok、OK”随机显示为更热情的表达。\n"
        @"例如：\n"
        @"“嗯”或“恩” → “嗯呐”“嗯嗯～”等\n"
        @"“好” → “好呀”“好哇”等\n"
        @"“可以” → “可以呀”“可以的～”等\n"
        @"同一条消息在当前聊天页面内保持一致。只改变你看到的文字，不修改服务器消息，不会自动回复，也不处理自己发送的消息；生效名单按微信账号分别保存。\n\n"
        @"假的引用好玩吗\n"
        @"输入格式：#假引用 被引用的内容；真正发送的内容\n"
        @"“#假引用”后要有空格，分隔支持中文分号“；”和英文分号“;”。本机显示分号前的引用内容，对方只收到分号后的正文。\n\n"
        @"生效范围\n"
        @"临时显示只保留在本机当前聊天页面，离开后清除。再次进入聊天时，“你别冷漠好不好”仍会按开关和名单自动生效。";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
    [self.sections[path.section].items[path.row] performAction];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier forIndexPath:path];
    [cell configureWithItem:self.sections[path.section].items[path.row]];
    return cell;
}
@end
