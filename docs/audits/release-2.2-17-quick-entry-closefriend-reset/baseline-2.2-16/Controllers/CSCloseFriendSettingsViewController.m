#import "CSCloseFriendSettingsViewController.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendManager.h"
#import "CSNativeContactPicker.h"
#import "CSSettingTableViewCell.h"
#import "CSBackupBootstrap.h"

// Keep long values within the common settings layout without changing other pages.
@interface CSCloseFriendSettingsCell : CSSettingTableViewCell
@property(nonatomic,weak) UISwitch *closeFriendSwitch;
- (void)configureCloseFriendSwitch:(UISwitch *)toggle;
@end

@implementation CSCloseFriendSettingsCell
+ (NSString *)reuseIdentifier { return @"CSCloseFriendSettingsCell"; }

- (void)prepareForReuse {
    [super prepareForReuse];
    self.closeFriendSwitch = nil;
}

- (void)configureWithItem:(CSSettingItem *)item {
    [super configureWithItem:item];
    self.textLabel.textColor=UIColor.labelColor;
    self.textLabel.numberOfLines = 1;
    self.detailTextLabel.numberOfLines = 1;
    self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}

- (void)configureCloseFriendSwitch:(UISwitch *)toggle {
    // Match the shared cell's switch placement, retaining the original target and tag.
    self.closeFriendSwitch = toggle;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:toggle];
    toggle.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [toggle.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [toggle.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15.0]
    ]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leading = 54.0, trailing = 15.0, gap = 8.0;
    CGFloat available = MAX(0, CGRectGetWidth(self.contentView.bounds) - leading - trailing);
    CGFloat titleWidth = available;
    if (self.closeFriendSwitch) {
        titleWidth = MAX(0, available - self.closeFriendSwitch.intrinsicContentSize.width - gap);
    } else if (self.detailTextLabel.text.length) {
        CGFloat titleDesired = [self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        CGFloat detailDesired = [self.detailTextLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        CGFloat reservedTitle = MIN(titleDesired, MAX(0, (available - gap) * 0.5));
        CGFloat detailWidth = MIN(detailDesired, MAX(0, available - reservedTitle - gap));
        CGRect detailFrame = self.detailTextLabel.frame;
        detailFrame.origin.x = leading + available - detailWidth;
        detailFrame.size.width = detailWidth;
        self.detailTextLabel.frame = detailFrame;
        titleWidth = MAX(0, available - detailWidth - gap);
    }
    CGRect titleFrame = self.textLabel.frame;
    titleFrame.origin.x = leading;
    titleFrame.size.width = titleWidth;
    self.textLabel.frame = titleFrame;
}
@end

@interface CSCloseFriendSettingsViewController ()
@property(nonatomic) BOOL requestingAuthentication, resetFinished;
@property(nonatomic,copy) NSArray<NSString *> *keys, *labels, *accountKeys, *protectionKeys;
@property(nonatomic,copy) NSDictionary<NSString *, NSString *> *optionIcons;
@end
@implementation CSCloseFriendSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad]; self.title=@"密友";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    [CSCloseFriendSettingsCell registerToTableView:self.tableView];
    self.keys=@[@"hideSessions",@"hideContacts",@"hideForwarding",@"hideTags",@"hideSearch",@"hideTimeline",@"hideInteractions",@"hideStatus",@"maskProfiles",@"hideScheduledTasks",@"hideAIReply",@"rejectVoice",@"rejectVideo",@"callReplyEnabled",@"callReplyText",@"hidePrivacyIcons",@"hideSettingsEntry",@"hidePluginEntry",@"biometric",@"shakeToLock",@"longPressUnlockEnabled",@"longPressUnlockDuration",@"unlockSeconds"];
    self.labels=@[@"隐藏聊天会话",@"隐藏通讯录页",@"隐藏转发页面",@"隐藏标签成员",@"隐藏搜索结果",@"隐藏友圈内容",@"隐藏互动痕迹",@"隐藏微信状态",@"隐藏个人资料",@"隐藏定时任务",@"隐藏自动回复",@"拒接语音来电",@"拒接视频来电",@"挂断自动回复",@"挂断回复内容",@"隐藏可见图标",@"隐藏密友设置",@"隐藏插件入口",@"生物识别解锁",@"摇晃立即隐藏",@"首页长按解锁",@"长按触发时间",@"临时解锁时间"];
    [self configureOptionGroups];
    self.optionIcons = @{
        @"hideSessions": @"bubble.left.and.bubble.right.fill",
        @"hideContacts": @"person.crop.circle.fill",
        @"hideForwarding": @"arrowshape.turn.up.right.fill",
        @"hideTags": @"tag.fill",
        @"hideSearch": @"magnifyingglass",
        @"hideTimeline": @"photo.on.rectangle",
        @"hideInteractions": @"hand.thumbsup.fill",
        @"hideStatus": @"quote.bubble.fill",
        @"maskProfiles": @"person.crop.rectangle.fill",
        @"hideScheduledTasks": @"calendar.badge.clock",
        @"hideAIReply": @"sparkles",
        @"rejectVoice": @"phone.down.fill",
        @"rejectVideo": @"video.slash.fill",
        @"callReplyEnabled": @"text.bubble.fill",
        @"callReplyText": @"square.and.pencil",
        @"hidePrivacyIcons": @"eye.slash.fill",
        @"hideSettingsEntry": @"gearshape.fill",
        @"hidePluginEntry": @"square.grid.2x2.fill",
        @"biometric": @"faceid",
        @"shakeToLock": @"iphone.radiowaves.left.and.right",
        @"longPressUnlockEnabled": @"hand.tap.fill",
        @"longPressUnlockDuration": @"timer",
        @"unlockSeconds": @"clock.fill"
    };
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(policyChanged:) name:CSCloseFriendPolicyDidChangeNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(invalidateQuickEntry) name:UIApplicationDidEnterBackgroundNotification object:nil];
}
- (void)configureOptionGroups {
    self.accountKeys=@[@"hideSettingsEntry",@"hidePluginEntry",@"biometric",@"shakeToLock",@"longPressUnlockEnabled",@"longPressUnlockDuration",@"unlockSeconds"];
    NSMutableArray *protection=[NSMutableArray new];
    for(NSString *key in self.keys) if(![self.accountKeys containsObject:key]) [protection addObject:key];
    self.protectionKeys=protection;
}
- (NSString *)optionKeyForIndexPath:(NSIndexPath *)path {
    if(path.section>1)return nil;
    NSInteger row=path.section==0 ? path.row-6 : path.row;
    NSArray *keys=path.section==0 ? self.accountKeys : self.protectionKeys;
    return row>=0 && (NSUInteger)row<keys.count ? keys[(NSUInteger)row] : nil;
}
- (void)dealloc { [CSCloseFriendManager.sharedManager.runtime invalidateSettingsAccessToken:self.quickEntryToken]; [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (BOOL)authorized { return self.quickEntry?[self settingsTokenIsCurrent:self.quickEntryToken]:!CSCloseFriendCurrentSnapshot().blocked && CSCloseFriendManager.sharedManager.runtime.isAuthorized; }
- (NSDictionary *)settingsProfile { return self.quickEntry?([self settingsTokenIsCurrent:self.quickEntryToken]?[CSCloseFriendManager.sharedManager.runtime profileForSettingsToken:self.quickEntryToken]:nil):CSCloseFriendCurrentProfile(); }
- (BOOL)settingsTokenIsCurrent:(NSDictionary *)token { return self.quickEntry?(token && !CSBackupAccountIsSuspended() && [token[@"epoch"] isEqual:@(CSCloseFriendAccountEpoch())] && (!self.navigationController || self.navigationController.topViewController==self) && [CSCloseFriendManager.sharedManager.runtime isSettingsTokenCurrent:token]):[CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token]; }
- (void)invalidateQuickEntry {
    if(!self.quickEntry)return;
    [CSCloseFriendManager.sharedManager.runtime invalidateSettingsAccessToken:self.quickEntryToken];
    self.quickEntryToken=nil;
    CSNativeContactPickerRevalidate(self);
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // The native member picker is a child operation of this visit. Popping or
    // replacing the settings page ends it; presenting its picker does not.
    if(self.isMovingFromParentViewController || self.isBeingDismissed || self.navigationController.isBeingDismissed ||
       (self.navigationController && self.navigationController.topViewController!=self))[self invalidateQuickEntry];
}
- (void)willMoveToParentViewController:(UIViewController *)parent {
    if(!parent)[self invalidateQuickEntry];
    [super willMoveToParentViewController:parent];
}
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; [self.tableView reloadData]; }
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(!self.quickEntry && ![self authorized] && !self.requestingAuthentication && !self.resetFinished) {
        self.requestingAuthentication=YES;
        [CSCloseFriendManager.sharedManager authenticateFrom:self completion:^(BOOL success){
            self.requestingAuthentication=NO; [self.tableView reloadData];
            // A relock or cancelled authentication clears sensitive rows in place.
            (void)success;
        }];
    }
}
- (void)policyChanged:(NSNotification *)note { if(self.quickEntry && ![self authorized])[self invalidateQuickEntry]; CSNativeContactPickerRevalidate(self); [self.tableView reloadData]; }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return [self authorized]?3:0; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return section==0?6+self.accountKeys.count:section==1?self.protectionKeys.count:1; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return @[@"账号保护",@"保护选项",@"重置密友"][section]; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section==0) {
        NSDictionary *options=[self settingsProfile][@"options"];
        NSString *entry=[options[@"longPressUnlockEnabled"] boolValue] ?
            [NSString stringWithFormat:@"长按微信首页顶部标题 %@ 秒，或在首页搜索框输入完整密码，即可解锁并显示密友设置入口。",options[@"longPressUnlockDuration"]] :
            @"首页长按解锁已关闭；在首页搜索框输入完整密码，仍可解锁并显示密友设置入口。";
        if(self.quickEntry)entry=[@"当前通过无密码快捷入口查看设置，微信列表仍按原锁定状态保护。任何能操作已解锁手机的人均可用此入口查看和修改名单。离开设置流程后须重新连点 5 次。\n" stringByAppendingString:entry];
        return [entry stringByAppendingString:@"开启“生物识别解锁”后，长按需通过面容或指纹验证；不可用或取消时可输入密友密码。密码验证信息仅保存在本机钥匙串；微信进入后台或切换账号时自动隐藏。开启“摇晃立即隐藏”后，轻摇手机即可隐藏。"];
    }
    if(section==1)return @"“隐藏定时任务”和“隐藏 AI 自动回复”默认关闭。开启后，锁定时分别隐藏任务列表中的密友任务、AI 回复管理中已开启的密友会话；解锁后显示。仅隐藏列表，定时发送和 AI 自动回复继续按原配置运行。“挂断回复”默认关闭，开启后仅对自动拒接的私聊发送预设消息，同一人5分钟内最多一次。搭配“免打扰”使用更加，免打扰需手动设置。隐藏个人资料：资料页隐藏发消息和音视频通话入口，显示添加到通讯录。";
    if(section==2)return @"仅重置当前账号的密友数据和密码，入口恢复首次隐藏。需验证当前密友密码并确认；不随插件的“重置设置”执行。";
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSCloseFriendSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:[CSCloseFriendSettingsCell reuseIdentifier]];
    if(indexPath.section==2) {
        [cell configureWithItem:[CSSettingItem itemWithTitle:@"重置密友" iconName:@"arrow.counterclockwise" iconColor:UIColor.systemRedColor detail:nil]];
        cell.textLabel.textColor=UIColor.systemRedColor;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    NSString *title, *iconName;
    NSString *optionKey=[self optionKeyForIndexPath:indexPath];
    UIColor *iconColor = [UIColor systemBlueColor];
    if(!optionKey) {
        title=@[@"启用密友功能",@"密友名单列表",@"密友群聊列表",@"修改解锁密码",@"立即隐藏密友",@"当前状态提醒"][indexPath.row];
        iconName=@[@"lock.shield.fill",@"person.fill",@"person.3.fill",@"key.fill",@"lock.fill",@"info.circle.fill"][indexPath.row];
        iconColor=@[[UIColor systemGreenColor],[UIColor systemBlueColor],[UIColor systemGreenColor],[UIColor systemOrangeColor],[UIColor systemRedColor],[UIColor systemGrayColor]][indexPath.row];
    } else {
        title=self.labels[[self.keys indexOfObject:optionKey]];
        iconName=self.optionIcons[optionKey];
    }
    [cell configureWithItem:[CSSettingItem itemWithTitle:title iconName:iconName iconColor:iconColor detail:nil]];
    NSDictionary *profile=[self settingsProfile];
    if(!optionKey) {
        if(indexPath.row==0) { UISwitch *toggle=[UISwitch new]; toggle.on=[profile[@"enabled"] boolValue]; toggle.tag=100; [toggle addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventValueChanged]; [cell configureCloseFriendSwitch:toggle]; }
        else if(indexPath.row==1 || indexPath.row==2) { cell.detailTextLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)[profile[indexPath.row==1?@"friends":@"groups"] count]]; cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator; }
        else if(indexPath.row==5) { cell.detailTextLabel.text=CSCloseFriendCurrentSnapshot().revealed?@"临时显示":@"保持隐藏"; cell.selectionStyle=UITableViewCellSelectionStyleNone; }
        else cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    } else {
        NSString *key=optionKey;
        if([key isEqual:@"unlockSeconds"] || [key isEqual:@"longPressUnlockDuration"]) { cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ 秒",profile[@"options"][key]]; cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator; }
        else if([key isEqual:@"callReplyText"]) {cell.detailTextLabel.text=profile[@"options"][key]; cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;}
        else { UISwitch *toggle=[UISwitch new]; toggle.tag=[self.keys indexOfObject:key]; toggle.on=[profile[@"options"][key] boolValue]; [toggle addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventValueChanged]; [cell configureCloseFriendSwitch:toggle]; }
    }
    return cell;
}
- (void)showError:(NSError *)error {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"未保存" message:error.localizedDescription?:@"操作已失效，请重新验证。" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]]; [self presentViewController:alert animated:YES completion:nil];
}
- (void)save:(NSDictionary *)profile {
    __block NSError *error=nil;
    __block BOOL saved=NO;
    if(self.quickEntry) {
        NSDictionary *token=self.quickEntryToken;
        CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
            if(CSBackupAccountIsSuspended())return;
            CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;
            [manager refreshAccount];
            if([self settingsTokenIsCurrent:token])saved=[manager.runtime updateProfile:profile settingsToken:token error:&error];
        });
    } else saved=CSCloseFriendUpdateCurrentProfile(profile,&error);
    if(!saved)[self showError:error];
    [self.tableView reloadData];
}
- (void)toggle:(UISwitch *)toggle {
    if(![self authorized]) { [self.tableView reloadData]; return; }
    NSMutableDictionary *profile=[[self settingsProfile] mutableCopy];
    if(toggle.tag==100)profile[@"enabled"]=@(toggle.on);
    else { NSMutableDictionary *options=[profile[@"options"] mutableCopy]; options[self.keys[toggle.tag]]=@(toggle.on); profile[@"options"]=options; }
    [self save:profile];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; if(![self authorized])return;
    if((indexPath.section==2 || (indexPath.section==0 && indexPath.row==3)) && self.quickEntry) {
        [self showError:[NSError errorWithDomain:@"CSCloseFriendSettings" code:3 userInfo:@{NSLocalizedDescriptionKey:@"修改密码和重置密友须从普通入口验证当前密友密码；快捷入口不提供凭据验证。"}]]; return;
    }
    if(indexPath.section==2) { [self resetCloseFriends]; return; }
    NSDictionary *token=self.quickEntry?self.quickEntryToken:CSCloseFriendManager.sharedManager.runtime.authenticationToken;
    NSString *optionKey=[self optionKeyForIndexPath:indexPath];
    if(indexPath.section==0 && (indexPath.row==1 || indexPath.row==2)) {
        NSString *key=indexPath.row==1?@"friends":@"groups";
        __weak typeof(self) weakSelf=self;
        NSError *error=nil;
        BOOL shown=CSNativeContactPickerPresent(self,indexPath.row==1?@"选择密友":@"选择密友群聊",indexPath.row==2,
          [self settingsProfile][key],^BOOL{
            return weakSelf && [weakSelf authorized] && [weakSelf settingsTokenIsCurrent:token];
          },^(NSArray<NSString *> *names){
            [CSCloseFriendManager.sharedManager refreshAccount];
            if(![weakSelf authorized] || ![weakSelf settingsTokenIsCurrent:token])return;
            NSMutableDictionary *profile=[[self settingsProfile] mutableCopy]; profile[key]=names; [weakSelf save:profile];
          },&error);
        if(!shown)[self showError:error];
    } else if(indexPath.section==0 && indexPath.row==3)[CSCloseFriendManager.sharedManager changePasswordFrom:self];
    else if(indexPath.section==0 && indexPath.row==4)CSCloseFriendLock();
    else if([optionKey isEqual:@"callReplyText"]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"挂断回复内容" message:@"输入 1–200 字的单行回复。自动拒接单人语音／视频来电后发送，同一人 5 分钟内最多一次。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *field){field.text=[self settingsProfile][@"options"][@"callReplyText"];field.placeholder=@"现在不方便接听，请留言。";}];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
            [CSCloseFriendManager.sharedManager refreshAccount];
            if(![self authorized] || ![self settingsTokenIsCurrent:token]) return;
            NSMutableDictionary *profile=[[self settingsProfile] mutableCopy], *options=[profile[@"options"] mutableCopy];
            options[@"callReplyText"]=alert.textFields.firstObject.text?:@"";
            profile[@"options"]=options;
            NSError *error=nil;
            if(!CSCloseFriendNormalizeProfile(profile,&error)) {
                [self showError:[NSError errorWithDomain:@"CSCloseFriendSettings" code:1 userInfo:@{NSLocalizedDescriptionKey:@"回复内容须为 1–200 字，不能是空白或包含换行。"}]];return;
            }
            [self save:profile];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if([optionKey isEqual:@"longPressUnlockDuration"]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"长按触发时长" message:@"范围 0.5–2 秒，默认 1 秒；保存后立即生效。关闭“首页长按解锁”时仍保留此时长。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *field){
            field.keyboardType=UIKeyboardTypeDecimalPad;
            field.text=[[self settingsProfile][@"options"][@"longPressUnlockDuration"] stringValue];
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
            [CSCloseFriendManager.sharedManager refreshAccount];
            if(![self authorized] || ![self settingsTokenIsCurrent:token]) return;
            NSString *text=[alert.textFields.firstObject.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
            NSScanner *scanner=[NSScanner scannerWithString:[text stringByReplacingOccurrencesOfString:@"," withString:@"."]?:@""];
            scanner.locale=[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            double duration=0;
            NSMutableDictionary *profile=[[self settingsProfile] mutableCopy], *options=[profile[@"options"] mutableCopy];
            BOOL parsed=[scanner scanDouble:&duration] && scanner.isAtEnd;
            options[@"longPressUnlockDuration"]=@(duration); profile[@"options"]=options;
            if(!parsed || !CSCloseFriendNormalizeProfile(profile,NULL)) {
                [self showError:[NSError errorWithDomain:@"CSCloseFriendSettings" code:2 userInfo:@{NSLocalizedDescriptionKey:@"请输入 0.5–2 之间的秒数，例如 0.5、1 或 1.5。"}]];
                return;
            }
            [self save:profile];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if([optionKey isEqual:@"unlockSeconds"]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"临时解锁时长" message:@"范围 1–86400 秒；下次验证后生效。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.keyboardType=UIKeyboardTypeNumberPad; field.text=[[self settingsProfile][@"options"][@"unlockSeconds"] stringValue]; }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
            [CSCloseFriendManager.sharedManager refreshAccount]; if(![self authorized] || ![self settingsTokenIsCurrent:token])return;
            NSString *text=alert.textFields.firstObject.text; NSCharacterSet *invalid=NSCharacterSet.decimalDigitCharacterSet.invertedSet;
            if(!text.length || [text rangeOfCharacterFromSet:invalid].location!=NSNotFound) { [self showError:nil]; return; }
            NSMutableDictionary *profile=[[self settingsProfile] mutableCopy], *options=[profile[@"options"] mutableCopy]; options[@"unlockSeconds"]=@([text integerValue]); profile[@"options"]=options; [self save:profile];
        }]]; [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)resetCloseFriends {
    if(self.requestingAuthentication || ![self authorized])return;
    self.requestingAuthentication=YES;
    __weak typeof(self) weakSelf=self;
    [CSCloseFriendManager.sharedManager resetFrom:self completion:^(BOOL success){
        typeof(self) self=weakSelf; if(!self)return;
        self.requestingAuthentication=NO;
        if(!success) { [self.tableView reloadData]; return; }
        self.resetFinished=YES;
        [self.tableView reloadData];
        [self leaveAfterReset];
    }];
}
- (void)leaveAfterReset {
    if(!self.view.window)return;
    UINavigationController *navigation=self.navigationController;
    if(navigation && navigation.topViewController!=self)return;
    UIAlertController *(^successAlert)(void)=^{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"密友已重置" message:@"“捉迷藏呀”已隐藏。需要重新使用时，在插件主设置页长按顶部头像 2 秒，再设置新的密友密码。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
        return alert;
    };
    if(navigation.viewControllers.count>1) {
        [navigation popViewControllerAnimated:NO];
        [navigation.topViewController presentViewController:successAlert() animated:YES completion:nil];
    } else {
        UIViewController *presenter=navigation.presentingViewController?:self.presentingViewController;
        if(presenter)[presenter dismissViewControllerAnimated:YES completion:^{ [presenter presentViewController:successAlert() animated:YES completion:nil]; }];
    }
}
@end
