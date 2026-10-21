#import "CSCloseFriendSettingsViewController.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendManager.h"
#import "CSNativeContactPicker.h"
#import "CSSettingTableViewCell.h"

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
@property(nonatomic) BOOL requestingAuthentication;
@property(nonatomic,copy) NSArray<NSString *> *keys, *labels;
@property(nonatomic,copy) NSDictionary<NSString *, NSString *> *optionIcons;
@end
@implementation CSCloseFriendSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad]; self.title=@"密友";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    [CSCloseFriendSettingsCell registerToTableView:self.tableView];
    self.keys=@[@"hideSessions",@"hideContacts",@"hideForwarding",@"hideTags",@"hideSearch",@"hideTimeline",@"hideInteractions",@"hideStatus",@"maskProfiles",@"silenceMessages",@"rejectVoice",@"rejectVideo",@"callReplyEnabled",@"callReplyText",@"hidePrivacyIcons",@"hideSettingsEntry",@"hidePluginEntry",@"biometric",@"shakeToLock",@"unlockSeconds"];
    self.labels=@[@"隐藏会话",@"隐藏联系人",@"隐藏转发候选",@"隐藏标签成员",@"隐藏搜索结果",@"隐藏朋友圈内容",@"隐藏互动痕迹",@"隐藏状态",@"资料页显示添加到通讯录",@"静默消息通知",@"拒接语音来电",@"拒接视频来电",@"挂断回复",@"挂断回复内容",@"隐藏全部朋友圈可见范围图标",@"隐藏密友设置入口",@"隐藏插件入口",@"允许生物识别解锁",@"摇动立即锁定",@"临时解锁时长"];
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
        @"silenceMessages": @"bell.slash.fill",
        @"rejectVoice": @"phone.down.fill",
        @"rejectVideo": @"video.slash.fill",
        @"callReplyEnabled": @"text.bubble.fill",
        @"callReplyText": @"square.and.pencil",
        @"hidePrivacyIcons": @"eye.slash.fill",
        @"hideSettingsEntry": @"gearshape.fill",
        @"hidePluginEntry": @"square.grid.2x2.fill",
        @"biometric": @"faceid",
        @"shakeToLock": @"iphone.radiowaves.left.and.right",
        @"unlockSeconds": @"clock.fill"
    };
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(policyChanged:) name:CSCloseFriendPolicyDidChangeNotification object:nil];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (BOOL)authorized { return !CSCloseFriendCurrentSnapshot().blocked && CSCloseFriendManager.sharedManager.runtime.isAuthorized; }
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; [self.tableView reloadData]; }
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(![self authorized] && !self.requestingAuthentication) {
        self.requestingAuthentication=YES;
        [CSCloseFriendManager.sharedManager authenticateFrom:self completion:^(BOOL success){
            self.requestingAuthentication=NO; [self.tableView reloadData];
            // A relock or cancelled authentication clears sensitive rows in place.
            (void)success;
        }];
    }
}
- (void)policyChanged:(NSNotification *)note { CSNativeContactPickerRevalidate(self); [self.tableView reloadData]; }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return [self authorized]?2:0; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return section==0?6:self.keys.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return @[@"账号保护",@"保护选项"][section]; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section==0)return @"密码仅保存在本机钥匙串。临时解锁期间可正常接听和拨打密友语音／视频通话，消息通知仍按静默开关处理；重新锁定后恢复来电拒接设置。后台或账号切换会立即锁定。挂断回复默认关闭；开启后，仅对自动拒接的单人语音／视频来电发送私聊回复，同一人 5 分钟内最多一次。";
    if(section==1)return @"长按微信首页顶部导航栏 1 秒直接临时解锁，或在首页搜索框输入完整密码解锁。开启“摇动立即锁定”后，临时解锁期间轻摇手机即可重新隐藏密友。密友隐藏时，搜索不显示“解锁后查看”占位，原生实时联想与网络搜索保持正常；解锁期间显示隐藏的密友设置入口。默认解锁 300 秒。微信原生“消息免打扰”由你手动设置，插件不会自动开启或恢复。";
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSCloseFriendSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:[CSCloseFriendSettingsCell reuseIdentifier]];
    NSString *title, *iconName;
    UIColor *iconColor = [UIColor systemBlueColor];
    if(indexPath.section==0) {
        title=@[@"启用密友",@"密友名单",@"密友群聊",@"修改密码",@"立即锁定",@"当前状态"][indexPath.row];
        iconName=@[@"lock.shield.fill",@"person.fill",@"person.3.fill",@"key.fill",@"lock.fill",@"info.circle.fill"][indexPath.row];
        iconColor=@[[UIColor systemGreenColor],[UIColor systemBlueColor],[UIColor systemGreenColor],[UIColor systemOrangeColor],[UIColor systemRedColor],[UIColor systemGrayColor]][indexPath.row];
    } else {
        title=self.labels[indexPath.row];
        iconName=self.optionIcons[self.keys[indexPath.row]];
    }
    [cell configureWithItem:[CSSettingItem itemWithTitle:title iconName:iconName iconColor:iconColor detail:nil]];
    NSDictionary *profile=CSCloseFriendCurrentProfile();
    if(indexPath.section==0) {
        if(indexPath.row==0) { UISwitch *toggle=[UISwitch new]; toggle.on=[profile[@"enabled"] boolValue]; toggle.tag=100; [toggle addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventValueChanged]; [cell configureCloseFriendSwitch:toggle]; }
        else if(indexPath.row==1 || indexPath.row==2) { cell.detailTextLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)[profile[indexPath.row==1?@"friends":@"groups"] count]]; cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator; }
        else if(indexPath.row==5) { cell.detailTextLabel.text=@"临时显示中"; cell.selectionStyle=UITableViewCellSelectionStyleNone; }
        else cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    } else if(indexPath.section==1) {
        NSString *key=self.keys[indexPath.row];
        if([key isEqual:@"unlockSeconds"]) { cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ 秒",profile[@"options"][key]]; cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator; }
        else if([key isEqual:@"callReplyText"]) {cell.detailTextLabel.text=profile[@"options"][key]; cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;}
        else { UISwitch *toggle=[UISwitch new]; toggle.tag=indexPath.row; toggle.on=[profile[@"options"][key] boolValue]; [toggle addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventValueChanged]; [cell configureCloseFriendSwitch:toggle]; }
    }
    return cell;
}
- (void)showError:(NSError *)error {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"未保存" message:error.localizedDescription?:@"操作已失效，请重新验证。" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]]; [self presentViewController:alert animated:YES completion:nil];
}
- (void)save:(NSDictionary *)profile { NSError *error=nil; if(!CSCloseFriendUpdateCurrentProfile(profile,&error))[self showError:error]; [self.tableView reloadData]; }
- (void)toggle:(UISwitch *)toggle {
    if(![self authorized]) { [self.tableView reloadData]; return; }
    NSMutableDictionary *profile=[CSCloseFriendCurrentProfile() mutableCopy];
    if(toggle.tag==100)profile[@"enabled"]=@(toggle.on);
    else { NSMutableDictionary *options=[profile[@"options"] mutableCopy]; options[self.keys[toggle.tag]]=@(toggle.on); profile[@"options"]=options; }
    [self save:profile];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; if(![self authorized])return;
    NSDictionary *token=CSCloseFriendManager.sharedManager.runtime.authenticationToken;
    if(indexPath.section==0 && (indexPath.row==1 || indexPath.row==2)) {
        NSString *key=indexPath.row==1?@"friends":@"groups";
        __weak typeof(self) weakSelf=self;
        NSError *error=nil;
        BOOL shown=CSNativeContactPickerPresent(self,indexPath.row==1?@"选择密友":@"选择密友群聊",indexPath.row==2,
          CSCloseFriendCurrentProfile()[key],^BOOL{
            return weakSelf && [weakSelf authorized] && [CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token];
          },^(NSArray<NSString *> *names){
            [CSCloseFriendManager.sharedManager refreshAccount];
            if(![weakSelf authorized] || ![CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token])return;
            NSMutableDictionary *profile=[CSCloseFriendCurrentProfile() mutableCopy]; profile[key]=names; [weakSelf save:profile];
          },&error);
        if(!shown)[self showError:error];
    } else if(indexPath.section==0 && indexPath.row==3)[CSCloseFriendManager.sharedManager changePasswordFrom:self];
    else if(indexPath.section==0 && indexPath.row==4)CSCloseFriendLock();
    else if(indexPath.section==1 && [self.keys[indexPath.row] isEqual:@"callReplyText"]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"挂断回复内容" message:@"输入 1–200 字的单行回复。自动拒接单人语音／视频来电后发送，同一人 5 分钟内最多一次。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *field){field.text=CSCloseFriendCurrentProfile()[@"options"][@"callReplyText"];field.placeholder=@"现在不方便接听，请留言。";}];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
            [CSCloseFriendManager.sharedManager refreshAccount];
            if(![self authorized] || ![CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token]) return;
            NSMutableDictionary *profile=[CSCloseFriendCurrentProfile() mutableCopy], *options=[profile[@"options"] mutableCopy];
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
    else if(indexPath.section==1 && [self.keys[indexPath.row] isEqual:@"unlockSeconds"]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"临时解锁时长" message:@"范围 1–86400 秒；下次验证后生效。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.keyboardType=UIKeyboardTypeNumberPad; field.text=[CSCloseFriendCurrentProfile()[@"options"][@"unlockSeconds"] stringValue]; }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
            [CSCloseFriendManager.sharedManager refreshAccount]; if(![self authorized] || ![CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token])return;
            NSString *text=alert.textFields.firstObject.text; NSCharacterSet *invalid=NSCharacterSet.decimalDigitCharacterSet.invertedSet;
            if(!text.length || [text rangeOfCharacterFromSet:invalid].location!=NSNotFound) { [self showError:nil]; return; }
            NSMutableDictionary *profile=[CSCloseFriendCurrentProfile() mutableCopy], *options=[profile[@"options"] mutableCopy]; options[@"unlockSeconds"]=@([text integerValue]); profile[@"options"]=options; [self save:profile];
        }]]; [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
