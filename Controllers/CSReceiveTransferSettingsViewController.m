//
// CSReceiveTransferSettingsViewController.m
// 自动收款设置界面实现
//

#import "CSReceiveTransferSettingsViewController.h"
#import "CSPaymentLedger.h"
#import "CSSettingTableViewCell.h"

static NSString * const kReceiveTransferAutoEnableKey = @"kReceiveTransferAutoEnableKey";
static NSString * const kReceiveTransferPrivateEnableKey = @"kReceiveTransferPrivateEnableKey";
static NSString * const kReceiveTransferGroupEnableKey = @"kReceiveTransferGroupEnableKey";
static NSString * const kReceiveTransferDelayKey = @"kReceiveTransferDelayKey";
static NSString * const kReceiveTransferNotifyTargetKey = @"kReceiveTransferNotifyTargetKey";
static NSString * const kReceiveTransferAutoReplyEnableKey = @"kReceiveTransferAutoReplyEnableKey";
static NSString * const kReceiveTransferPrivateAutoReplyKey = @"kReceiveTransferPrivateAutoReplyKey";
static NSString * const kReceiveTransferGroupAutoReplyKey = @"kReceiveTransferGroupAutoReplyKey";
static NSString * const kReceiveTransferTotalCountKey = @"kReceiveTransferTotalCountKey";
static NSString * const kReceiveTransferTotalAmountKey = @"kReceiveTransferTotalAmountKey";

@interface CSReceiveTransferSettingsViewController ()

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;

@end

@implementation CSReceiveTransferSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(cs_paymentStatisticsChanged:) name:CSPaymentStatisticsDidChangeNotification object:nil];
    
    self.title = @"自动收款";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupData];
    [self.tableView reloadData];
}
- (void)cs_paymentStatisticsChanged:(NSNotification *)notification {
    if (self.isViewLoaded && self.view.window) {
        [self setupData];
        [self.tableView reloadData];
    }
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:CSPaymentStatisticsDidChangeNotification object:nil];
}

- (void)setupData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CSSettingItem *autoReceiveItem = [CSSettingItem switchItemWithTitle:@"自动收款"
                                                              iconName:@"yensign.circle.fill"
                                                             iconColor:[UIColor systemGreenColor]
                                                           switchValue:[defaults boolForKey:kReceiveTransferAutoEnableKey]
                                                     valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kReceiveTransferAutoEnableKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.receivetransfer.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    CSSettingItem *privateEnableItem = [CSSettingItem switchItemWithTitle:@"私聊自动收款"
                                                               iconName:@"person.fill"
                                                              iconColor:[UIColor systemBlueColor]
                                                            switchValue:[defaults boolForKey:kReceiveTransferPrivateEnableKey]
                                                      valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kReceiveTransferPrivateEnableKey];
        [defaults synchronize];
    }];
    
    id groupEnableValue = [defaults objectForKey:kReceiveTransferGroupEnableKey];
    BOOL groupEnable = groupEnableValue ? [groupEnableValue boolValue] : YES;
    CSSettingItem *groupEnableItem = [CSSettingItem switchItemWithTitle:@"群聊自动收款"
                                                             iconName:@"person.3.fill"
                                                            iconColor:[UIColor systemGreenColor]
                                                          switchValue:groupEnable
                                                    valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kReceiveTransferGroupEnableKey];
        [defaults synchronize];
    }];
    
    NSInteger delaySeconds = [defaults integerForKey:kReceiveTransferDelayKey];
    NSString *delayDetail = delaySeconds == 0 ? @"不延迟" : [NSString stringWithFormat:@"%ld秒", (long)delaySeconds];
    CSSettingItem *delayItem = [CSSettingItem itemWithTitle:@"延迟收款"
                                                  iconName:@"clock.fill"
                                                 iconColor:[UIColor systemYellowColor]
                                                   detail:delayDetail];
    
    NSInteger notifyTarget = [defaults integerForKey:kReceiveTransferNotifyTargetKey];
    NSString *notifyDetail = notifyTarget == 0 ? @"关闭" : (notifyTarget == 1 ? @"通知自己" : @"通知文件传输助手");
    CSSettingItem *notifyItem = [CSSettingItem itemWithTitle:@"收款通知"
                                                   iconName:@"bell.fill"
                                                  iconColor:[UIColor systemRedColor]
                                                    detail:notifyDetail];
    
    CSSettingItem *autoReplyItem = [CSSettingItem switchItemWithTitle:@"自动回复"
                                                            iconName:@"bubble.left.and.bubble.right.fill"
                                                           iconColor:[UIColor systemPurpleColor]
                                                         switchValue:[defaults boolForKey:kReceiveTransferAutoReplyEnableKey]
                                                   valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kReceiveTransferAutoReplyEnableKey];
        [defaults synchronize];
    }];
    
    NSString *privateReplyContent = [defaults stringForKey:kReceiveTransferPrivateAutoReplyKey] ?: @"未设置";
    CSSettingItem *privateReplyItem = [CSSettingItem itemWithTitle:@"私聊自动回复"
                                                        iconName:@"person.fill"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:privateReplyContent];
    
    NSString *groupReplyContent = [defaults stringForKey:kReceiveTransferGroupAutoReplyKey] ?: @"未设置";
    CSSettingItem *groupReplyItem = [CSSettingItem itemWithTitle:@"群聊自动回复"
                                                      iconName:@"person.3.fill"
                                                     iconColor:[UIColor systemGreenColor]
                                                       detail:groupReplyContent];
    
    // 收款记录
    NSInteger totalCount = [defaults integerForKey:kReceiveTransferTotalCountKey];
    NSInteger totalAmount = [defaults integerForKey:kReceiveTransferTotalAmountKey];
    double totalAmountYuan = totalAmount / 100.0;
    NSString *recordDetail = [NSString stringWithFormat:@"接收转账%ld次，累计%.2f元！", (long)totalCount, totalAmountYuan];
    CSSettingItem *recordItem = [CSSettingItem itemWithTitle:@"收款记录"
                                                   iconName:@"chart.line.uptrend.xyaxis"
                                                  iconColor:[UIColor systemOrangeColor]
                                                    detail:recordDetail];
    
    CSSettingItem *infoItem = [CSSettingItem itemWithTitle:@"功能说明"
                                                 iconName:@"info.circle"
                                                iconColor:[UIColor systemGrayColor]
                                                  detail:@"自动收取转账，修改后需要重启微信。"];
    
    CSSettingSection *switchSection = [CSSettingSection sectionWithHeader:@"开关设置"
                                                                   items:@[autoReceiveItem, privateEnableItem, groupEnableItem]];
    
    CSSettingSection *advancedSection = [CSSettingSection sectionWithHeader:@"高级设置"
                                                                     items:@[delayItem, notifyItem]];
    
    CSSettingSection *autoReplySection = [CSSettingSection sectionWithHeader:@"自动回复"
                                                                      items:@[autoReplyItem, privateReplyItem, groupReplyItem]];
    
    CSSettingSection *recordSection = [CSSettingSection sectionWithHeader:@"收款记录"
                                                                   items:@[recordItem]];
    
    CSSettingSection *infoSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[infoItem]];
    
    self.sections = @[switchSection, advancedSection, autoReplySection, recordSection, infoSection];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < self.sections.count) {
        return self.sections[section].items.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier]];
    
    if (indexPath.section < self.sections.count) {
        CSSettingSection *section = self.sections[indexPath.section];
        if (indexPath.row < section.items.count) {
            [cell configureWithItem:section.items[indexPath.row]];
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section < self.sections.count) {
        return self.sections[section].header;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section < self.sections.count) {
        CSSettingSection *section = self.sections[indexPath.section];
        if (indexPath.row < section.items.count) {
            CSSettingItem *item = section.items[indexPath.row];
            
            if ([item.title isEqualToString:@"延迟收款"]) {
                [self showDelayPicker];
            }
            else if ([item.title isEqualToString:@"收款通知"]) {
                [self showNotifyTargetPicker];
            }
            else if ([item.title isEqualToString:@"私聊自动回复"]) {
                [self showAutoReplyEditorForPrivate];
            }
            else if ([item.title isEqualToString:@"群聊自动回复"]) {
                [self showAutoReplyEditorForGroup];
            }
        }
    }
}

#pragma mark - 设置项处理

- (void)showDelayPicker {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger currentDelay = [defaults integerForKey:kReceiveTransferDelayKey];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"延迟收款"
                                                                   message:@"设置收款延迟时间（秒）"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i = 0; i <= 10; i++) {
        NSString *title = [NSString stringWithFormat:@"%ld秒", (long)i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            [defaults setInteger:i forKey:kReceiveTransferDelayKey];
            [defaults synchronize];
            [self setupData];
            [self.tableView reloadData];
        }];
        if (i == currentDelay) {
            [action setValue:@(true) forKey:@"checked"];
        }
        [alert addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showNotifyTargetPicker {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger currentTarget = [defaults integerForKey:kReceiveTransferNotifyTargetKey];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收款通知"
                                                                   message:@"选择收款后的通知方式"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *titles = @[@"关闭通知", @"通知自己", @"通知文件传输助手"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i]
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            [defaults setInteger:i forKey:kReceiveTransferNotifyTargetKey];
            [defaults synchronize];
            [self setupData];
            [self.tableView reloadData];
        }];
        if (i == currentTarget) {
            [action setValue:@(true) forKey:@"checked"];
        }
        [alert addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAutoReplyEditorForPrivate {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentContent = [defaults stringForKey:kReceiveTransferPrivateAutoReplyKey] ?: @"";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"私聊自动回复"
                                                                   message:@"设置收到转账后的自动回复内容"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入自动回复内容";
        textField.text = currentContent;
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *content = textField.text ?: @"";
        [defaults setObject:content forKey:kReceiveTransferPrivateAutoReplyKey];
        [defaults synchronize];
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"清空"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [defaults removeObjectForKey:kReceiveTransferPrivateAutoReplyKey];
        [defaults synchronize];
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alert addAction:saveAction];
    [alert addAction:clearAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAutoReplyEditorForGroup {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentContent = [defaults stringForKey:kReceiveTransferGroupAutoReplyKey] ?: @"";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"群聊自动回复"
                                                                   message:@"设置收到转账后的自动回复内容"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入自动回复内容";
        textField.text = currentContent;
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *content = textField.text ?: @"";
        [defaults setObject:content forKey:kReceiveTransferGroupAutoReplyKey];
        [defaults synchronize];
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"清空"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [defaults removeObjectForKey:kReceiveTransferGroupAutoReplyKey];
        [defaults synchronize];
        [self setupData];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alert addAction:saveAction];
    [alert addAction:clearAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
