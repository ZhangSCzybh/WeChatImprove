//
// CSRedEnvelopSettingsViewController.m
// 红包功能设置界面实现
//

#import "CSRedEnvelopSettingsViewController.h"
#import "CSPaymentLedger.h"
#import "CSSettingTableViewCell.h"
#import "CSNativeContactPicker.h"
#import "CSRedEnvelopConfig.h"

// Settings keys are private to this page; NSUserDefaults persists writes automatically.
static NSString * const kRedEnvelopAutoReceiveKey = @"com.wechat.enhance.redenvelop.autoReceive";
static NSString * const kRedEnvelopPrivateEnableKey = @"com.wechat.enhance.redenvelop.privateEnable";
static NSString * const kRedEnvelopGroupEnableKey = @"com.wechat.enhance.redenvelop.groupEnable";
static NSString * const kRedEnvelopDelayKey = @"com.wechat.enhance.redenvelop.delay";
static NSString * const kRedEnvelopReceiveSelfKey = @"com.wechat.enhance.redenvelop.receiveSelf";
static NSString * const kRedEnvelopSerialReceiveKey = @"com.wechat.enhance.redenvelop.serialReceive";
static NSString * const kRedEnvelopGroupScopeKey = @"com.wechat.enhance.redenvelop.groupScope";
static NSString * const kRedEnvelopAllowedGroupsKey = @"com.wechat.enhance.redenvelop.allowedGroups";
static NSString * const kRedEnvelopBlockedGroupsKey = @"com.wechat.enhance.redenvelop.blockedGroups";
static NSString * const kRedEnvelopAutoReplyEnableKey = @"com.wechat.enhance.redenvelop.autoReplyEnable";
static NSString * const kRedEnvelopPrivateReplyKey = @"com.wechat.enhance.redenvelop.privateReply";
static NSString * const kRedEnvelopGroupReplyKey = @"com.wechat.enhance.redenvelop.groupReply";
static NSString * const kRedEnvelopNotifyTargetKey = @"com.wechat.enhance.redenvelop.notifyTarget";
static NSString * const kRedEnvelopPageSummaryKey = @"com.wechat.enhance.redenvelop.pageSummary";

@interface CSRedEnvelopSettingsViewController ()

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;

@end

@implementation CSRedEnvelopSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(cs_paymentStatisticsChanged:) name:CSPaymentStatisticsDidChangeNotification object:nil];
    
    self.title = @"红包功能";
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
    
    // 创建自动抢红包开关
    CSSettingItem *autoReceiveItem = [CSSettingItem switchItemWithTitle:@"自动抢红包"
                                                              iconName:@"gift.fill"
                                                             iconColor:[UIColor systemRedColor]
                                                           switchValue:[defaults boolForKey:kRedEnvelopAutoReceiveKey]
                                                     valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kRedEnvelopAutoReceiveKey];
        
        // 发送通知，让Hook文件处理状态改变
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.redenvelop.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    // 创建私聊红包开关
    CSSettingItem *privateEnableItem = [CSSettingItem switchItemWithTitle:@"私聊红包"
                                                               iconName:@"person.fill"
                                                              iconColor:[UIColor systemBlueColor]
                                                            switchValue:[defaults boolForKey:kRedEnvelopPrivateEnableKey]
                                                      valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kRedEnvelopPrivateEnableKey];
    }];
    
    // 创建群聊红包开关
    id groupEnableValue = [defaults objectForKey:kRedEnvelopGroupEnableKey];
    BOOL groupEnable = groupEnableValue ? [groupEnableValue boolValue] : YES;
    CSSettingItem *groupEnableItem = [CSSettingItem switchItemWithTitle:@"群聊红包"
                                                             iconName:@"person.3.fill"
                                                            iconColor:[UIColor systemGreenColor]
                                                          switchValue:groupEnable
                                                    valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kRedEnvelopGroupEnableKey];
    }];
    
    // 创建抢自己发的红包开关
    CSSettingItem *receiveSelfItem = [CSSettingItem switchItemWithTitle:@"抢自己发的红包"
                                                             iconName:@"arrow.uturn.left.circle"
                                                            iconColor:[UIColor systemOrangeColor]
                                                          switchValue:[defaults boolForKey:kRedEnvelopReceiveSelfKey]
                                                    valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kRedEnvelopReceiveSelfKey];
    }];
    
    // 创建串行抢红包开关
    CSSettingItem *serialReceiveItem = [CSSettingItem switchItemWithTitle:@"串行抢红包"
                                                               iconName:@"list.bullet"
                                                              iconColor:[UIColor systemPurpleColor]
                                                            switchValue:[defaults boolForKey:kRedEnvelopSerialReceiveKey]
                                                      valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kRedEnvelopSerialReceiveKey];
    }];
    
    // 创建延迟时间设置
    NSInteger delaySeconds = [defaults integerForKey:kRedEnvelopDelayKey];
    NSString *delayDetail = delaySeconds == 0 ? @"不延迟" : [NSString stringWithFormat:@"%ld秒", (long)delaySeconds];
    CSSettingItem *delayItem = [CSSettingItem itemWithTitle:@"延迟抢红包"
                                                  iconName:@"clock.fill"
                                                 iconColor:[UIColor systemYellowColor]
                                                   detail:delayDetail];
    
    // 创建群聊范围设置
    NSInteger groupScope = [defaults integerForKey:kRedEnvelopGroupScopeKey];
    NSArray *allowedGroups = [defaults arrayForKey:kRedEnvelopAllowedGroupsKey] ?: @[];
    NSArray *blockedGroups = [defaults arrayForKey:kRedEnvelopBlockedGroupsKey] ?: @[];
    
    NSString *scopeDetail = nil;
    if (groupScope == 0) {
        scopeDetail = @"所有群";
    } else if (groupScope == 1) {
        scopeDetail = [NSString stringWithFormat:@"白名单(%lu)", (unsigned long)allowedGroups.count];
    } else {
        scopeDetail = [NSString stringWithFormat:@"黑名单(%lu)", (unsigned long)blockedGroups.count];
    }
    CSSettingItem *groupScopeItem = [CSSettingItem itemWithTitle:@"群聊范围"
                                                       iconName:@"rectangle.stack.fill"
                                                      iconColor:[UIColor systemTealColor]
                                                        detail:scopeDetail];
    
    // 创建白名单设置
    NSString *whitelistDetail = [NSString stringWithFormat:@"%lu个群", (unsigned long)allowedGroups.count];
    CSSettingItem *whitelistItem = [CSSettingItem itemWithTitle:@"白名单群"
                                                      iconName:@"checkmark.circle"
                                                     iconColor:[UIColor systemGreenColor]
                                                       detail:whitelistDetail];
    
    // 创建黑名单设置
    NSString *blacklistDetail = [NSString stringWithFormat:@"%lu个群", (unsigned long)blockedGroups.count];
    CSSettingItem *blacklistItem = [CSSettingItem itemWithTitle:@"黑名单群"
                                                      iconName:@"xmark.circle"
                                                     iconColor:[UIColor systemRedColor]
                                                       detail:blacklistDetail];
    
    id savedReplyEnabled=[defaults objectForKey:kRedEnvelopAutoReplyEnableKey];
    BOOL replyEnabled=savedReplyEnabled ? [savedReplyEnabled boolValue] :
        ([defaults stringForKey:kRedEnvelopPrivateReplyKey].length || [defaults stringForKey:kRedEnvelopGroupReplyKey].length);
    CSSettingItem *replyEnableItem=[CSSettingItem switchItemWithTitle:@"红包自动回复"
        iconName:@"bubble.left.and.bubble.right.fill" iconColor:UIColor.systemGreenColor
        switchValue:replyEnabled valueChangedBlock:^(BOOL isOn) {
            [defaults setBool:isOn forKey:kRedEnvelopAutoReplyEnableKey];
            [[CSRedEnvelopConfig sharedConfig] reload];
        }];

    // 创建私聊自动回复设置
    NSString *privateReply = [defaults stringForKey:kRedEnvelopPrivateReplyKey] ?: @"";
    CSSettingItem *privateReplyItem = [CSSettingItem itemWithTitle:@"私聊自动回复"
                                                        iconName:@"bubble.left.fill"
                                                       iconColor:[UIColor systemBlueColor]
                                                         detail:privateReply.length > 0 ? privateReply : @"未设置"];
    
    // 创建群聊自动回复设置
    NSString *groupReply = [defaults stringForKey:kRedEnvelopGroupReplyKey] ?: @"";
    CSSettingItem *groupReplyItem = [CSSettingItem itemWithTitle:@"群聊自动回复"
                                                      iconName:@"bubble.left.and.bubble.right.fill"
                                                     iconColor:[UIColor systemGreenColor]
                                                       detail:groupReply.length > 0 ? groupReply : @"未设置"];
    
    // 创建抢到通知设置
    NSInteger notifyTarget = [defaults integerForKey:kRedEnvelopNotifyTargetKey];
    NSString *notifyDetail = notifyTarget == 0 ? @"关闭" : (notifyTarget == 1 ? @"通知自己" : @"通知文件传输助手");
    CSSettingItem *notifyItem = [CSSettingItem itemWithTitle:@"抢到通知"
                                                   iconName:@"bell.fill"
                                                  iconColor:[UIColor systemRedColor]
                                                    detail:notifyDetail];
    
    // 创建红包详情页汇总开关
    CSSettingItem *pageSummaryItem = [CSSettingItem switchItemWithTitle:@"红包详情页汇总"
                                                             iconName:@"doc.text.fill"
                                                            iconColor:[UIColor systemIndigoColor]
                                                          switchValue:[defaults boolForKey:kRedEnvelopPageSummaryKey]
                                                    valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kRedEnvelopPageSummaryKey];
    }];
    
    // 创建领取记录项
    CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
    NSInteger totalCount = config.totalReceiveCount;
    long long totalAmount = config.totalReceiveAmount;
    NSString *recordDetail = [NSString stringWithFormat:@"已领%ld次，累计%.2f元！", (long)totalCount, (double)totalAmount / 100.0];
    CSSettingItem *receiveRecordItem = [CSSettingItem itemWithTitle:@"领取记录"
                                                         iconName:@"chart.bar.fill"
                                                        iconColor:[UIColor systemGreenColor]
                                                          detail:recordDetail];
    
    // 创建功能说明项
    CSSettingItem *infoItem = [CSSettingItem itemWithTitle:@"功能说明"
                                                 iconName:@"info.circle"
                                                iconColor:[UIColor systemGrayColor]
                                                  detail:@"修改立即生效；关闭后撤销待领取任务。"];
    
    // 创建分组
    CSSettingSection *switchSection = [CSSettingSection sectionWithHeader:@"开关设置"
                                                                   items:@[autoReceiveItem, privateEnableItem, groupEnableItem]];
    
    CSSettingSection *advancedSection = [CSSettingSection sectionWithHeader:@"高级设置"
                                                                     items:@[receiveSelfItem, serialReceiveItem, delayItem, groupScopeItem, whitelistItem, blacklistItem]];
    
    CSSettingSection *replySection = [CSSettingSection sectionWithHeader:@"自动回复"
                                                                  items:@[replyEnableItem, privateReplyItem, groupReplyItem]];
    
    CSSettingSection *notifySection = [CSSettingSection sectionWithHeader:@"通知设置"
                                                                   items:@[notifyItem, pageSummaryItem, receiveRecordItem]];
    
    CSSettingSection *infoSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[infoItem]];
    
    self.sections = @[switchSection, advancedSection, replySection, notifySection, infoSection];
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
            
            // 处理延迟时间设置
            if ([item.title isEqualToString:@"延迟抢红包"]) {
                [self showDelayPicker];
            }
            // 处理群聊范围设置
            else if ([item.title isEqualToString:@"群聊范围"]) {
                [self showGroupScopePicker];
            }
            // 处理白名单设置
            else if ([item.title isEqualToString:@"白名单群"]) {
                [self showWhitelistSelector];
            }
            // 处理黑名单设置
            else if ([item.title isEqualToString:@"黑名单群"]) {
                [self showBlacklistSelector];
            }
            // 处理私聊自动回复设置
            else if ([item.title isEqualToString:@"私聊自动回复"]) {
                [self showPrivateReplyInput];
            }
            // 处理群聊自动回复设置
            else if ([item.title isEqualToString:@"群聊自动回复"]) {
                [self showGroupReplyInput];
            }
            // 处理抢到通知设置
            else if ([item.title isEqualToString:@"抢到通知"]) {
                [self showNotifyTargetPicker];
            }
            // 处理领取记录
            else if ([item.title isEqualToString:@"领取记录"]) {
                [self showReceiveRecordActions];
            }
        }
    }
}

#pragma mark - 设置项处理

- (void)showDelayPicker {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger currentDelay = [defaults integerForKey:kRedEnvelopDelayKey];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"延迟抢红包"
                                                                   message:@"设置抢红包延迟时间（秒）"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i = 0; i <= 10; i++) {
        NSString *title = [NSString stringWithFormat:@"%ld秒", (long)i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            [defaults setInteger:i forKey:kRedEnvelopDelayKey];
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

- (void)showGroupScopePicker {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger currentScope = [defaults integerForKey:kRedEnvelopGroupScopeKey];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"群聊范围"
                                                                   message:@"选择抢红包的群聊范围"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *allAction = [UIAlertAction actionWithTitle:@"所有群"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        [defaults setInteger:0 forKey:kRedEnvelopGroupScopeKey];
        [self setupData];
        [self.tableView reloadData];
    }];
    if (currentScope == 0) {
        [allAction setValue:@(true) forKey:@"checked"];
    }
    [alert addAction:allAction];
    
    UIAlertAction *whitelistAction = [UIAlertAction actionWithTitle:@"仅白名单"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
        [defaults setInteger:1 forKey:kRedEnvelopGroupScopeKey];
        [self setupData];
        [self.tableView reloadData];
        [self showWhitelistSelector];
    }];
    if (currentScope == 1) {
        [whitelistAction setValue:@(true) forKey:@"checked"];
    }
    [alert addAction:whitelistAction];
    
    UIAlertAction *blacklistAction = [UIAlertAction actionWithTitle:@"排除黑名单"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
        [defaults setInteger:2 forKey:kRedEnvelopGroupScopeKey];
        [self setupData];
        [self.tableView reloadData];
        [self showBlacklistSelector];
    }];
    if (currentScope == 2) {
        [blacklistAction setValue:@(true) forKey:@"checked"];
    }
    [alert addAction:blacklistAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showWhitelistSelector {
    [self showGroupSelectorWithTitle:@"白名单群" key:kRedEnvelopAllowedGroupsKey];
}

- (void)showBlacklistSelector {
    [self showGroupSelectorWithTitle:@"黑名单群" key:kRedEnvelopBlockedGroupsKey];
}

- (void)showGroupSelectorWithTitle:(NSString *)title key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    __weak typeof(self) weakSelf=self;
    NSError *error=nil;
    if(!CSNativeContactPickerPresent(self,title,YES,[defaults arrayForKey:key]?:@[],nil,^(NSArray<NSString *> *names){
        [defaults setObject:names forKey:key];
        [weakSelf setupData]; [weakSelf.tableView reloadData];
    },&error)) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"无法选择群聊" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)showPrivateReplyInput {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentReply = [defaults stringForKey:kRedEnvelopPrivateReplyKey] ?: @"";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"私聊自动回复"
                                                                   message:@"设置抢到红包后自动回复的内容"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = currentReply;
        textField.placeholder = @"请输入自动回复内容";
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *text = textField.text ?: @"";
        [defaults setObject:text forKey:kRedEnvelopPrivateReplyKey];
        [self setupData];
        [self.tableView reloadData];
    }];
    [alert addAction:confirmAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showGroupReplyInput {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentReply = [defaults stringForKey:kRedEnvelopGroupReplyKey] ?: @"";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"群聊自动回复"
                                                                   message:@"设置抢到红包后自动回复的内容"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = currentReply;
        textField.placeholder = @"请输入自动回复内容";
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *text = textField.text ?: @"";
        [defaults setObject:text forKey:kRedEnvelopGroupReplyKey];
        [self setupData];
        [self.tableView reloadData];
    }];
    [alert addAction:confirmAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showReceiveRecordActions {
    CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
    NSInteger totalCount = config.totalReceiveCount;
    long long totalAmount = config.totalReceiveAmount;
    
    NSString *message = [NSString stringWithFormat:@"已领%ld次，累计%.2f元\n是否重置统计数据？", (long)totalCount, (double)totalAmount / 100.0];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"领取记录"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"重置记录"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [[CSRedEnvelopConfig sharedConfig] resetReceiveRecordsWithCompletion:^{
            [self setupData];
            [self.tableView reloadData];
        }];
    }];
    [alert addAction:resetAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showNotifyTargetPicker {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger currentTarget = [defaults integerForKey:kRedEnvelopNotifyTargetKey];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"抢到通知"
                                                                   message:@"选择抢到红包后的通知方式"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *titles = @[@"关闭通知", @"通知自己", @"通知文件传输助手"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i]
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            [defaults setInteger:i forKey:kRedEnvelopNotifyTargetKey];
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

@end
