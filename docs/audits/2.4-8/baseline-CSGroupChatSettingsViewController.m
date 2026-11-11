#import "CSGroupChatSettingsViewController.h"
#import "CSGroupChatManager.h"
#import "CSGroupChatNativeAdapter.h"
#import "CSGroupChatTemplate.h"
#import "CSNativeContactPicker.h"
#import "CSSettingTableViewCell.h"
#import "CSSettingsPresentation.h"
#import "CSAuthorizationManager.h"
#import "CSBackupBootstrap.h"

static void CSGCAlert(UIViewController *page, NSString *message) {
    if (!CSSettingsCanPresentFrom(page)) return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"群聊功能" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
    [page presentViewController:alert animated:YES completion:nil];
}
static NSDictionary *CSGCContext(void) {
    CSGroupChatManager *manager=CSGroupChatManager.sharedManager;
    return @{@"account":manager.accountID?:@"",@"epoch":@(manager.accountEpoch),@"generation":@(manager.configurationGeneration)};
}
static BOOL CSGCContextValid(NSDictionary *context, BOOL checkConfiguration) {
    CSGroupChatManager *manager=CSGroupChatManager.sharedManager;
    return manager.ready && CSBackupIsReady() && !CSBackupAccountIsSuspended() &&
        [context[@"account"] length] && [context[@"account"] isEqual:manager.accountID] &&
        [context[@"epoch"] unsignedIntegerValue]==manager.accountEpoch &&
        (!checkConfiguration || [context[@"generation"] unsignedIntegerValue]==manager.configurationGeneration);
}
static BOOL CSGCRequireAuthorization(UIViewController *page) {
    if (!CSGroupChatManager.sharedManager.ready || !CSBackupIsReady() || CSBackupAccountIsSuspended()) {
        CSGCAlert(page,CSGroupChatManager.sharedManager.statusText.length?CSGroupChatManager.sharedManager.statusText:@"当前账号尚未就绪，请稍后重试。");
        return NO;
    }
    if (CSAuthorizationManager.sharedManager.isAuthorized) return YES;
    if (CSSettingsCanPresentFrom(page)) {
        __weak UIViewController *weakPage=page;
        [CSAuthorizationManager.sharedManager requestAuthorizationWithPresentingViewController:page completion:^(BOOL success,NSString *message){
            dispatch_async(dispatch_get_main_queue(),^{
                if (!success) CSGCAlert(weakPage,message.length?message:@"请先完成授权，再使用群聊功能。");
            });
        }];
    }
    return NO;
}
static CSSettingItem *CSGCRow(NSString *title,NSString *icon,UIColor *color,NSString *detail,void (^action)(void)) {
    CSSettingItem *item=action?[CSSettingItem actionItemWithTitle:title iconName:icon iconColor:color]:
        [CSSettingItem itemWithTitle:title iconName:icon iconColor:color detail:detail];
    item.detail=detail; item.actionBlock=action; return item;
}

// Keep long room names and template previews within the same spacing as other settings pages.
@interface CSGroupChatSettingsCell : CSSettingTableViewCell
@end
@implementation CSGroupChatSettingsCell
+ (NSString *)reuseIdentifier { return @"CSGroupChatSettingsCell"; }
- (void)configureWithItem:(CSSettingItem *)item {
    [super configureWithItem:item]; self.textLabel.numberOfLines=1; self.detailTextLabel.numberOfLines=1;
    self.textLabel.lineBreakMode=NSLineBreakByTruncatingTail; self.detailTextLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.textLabel.textColor=UIColor.labelColor; self.detailTextLabel.textColor=UIColor.secondaryLabelColor;
    self.contentView.alpha=1; self.userInteractionEnabled=YES;
    if (!item.actionBlock && item.itemType!=CSSettingItemTypeSwitch) self.selectionStyle=UITableViewCellSelectionStyleNone;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leading=54,available=MAX(0,CGRectGetWidth(self.contentView.bounds)-leading-15),titleWidth=available;
    UISwitch *toggle=nil;
    for (UIView *view in self.contentView.subviews) if ([view isKindOfClass:UISwitch.class]) toggle=(UISwitch *)view;
    if (toggle) titleWidth=MAX(0,available-toggle.intrinsicContentSize.width-8);
    else if (self.detailTextLabel.text.length) {
        CGFloat titleDesired=[self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width;
        CGFloat titleReserved=MIN(titleDesired,MAX(0,(available-8)*0.58));
        CGFloat detailWidth=MIN([self.detailTextLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width,MAX(0,available-titleReserved-8));
        CGRect detail=self.detailTextLabel.frame; detail.origin.x=leading+available-detailWidth; detail.size.width=detailWidth;
        self.detailTextLabel.frame=detail; titleWidth=MAX(0,available-detailWidth-8);
    }
    CGRect title=self.textLabel.frame; title.origin.x=leading; title.size.width=titleWidth; self.textLabel.frame=title;
}
@end
static void CSGCConfigureTable(UITableView *table) {
    table.backgroundColor=UIColor.systemGroupedBackgroundColor;
    table.separatorStyle=UITableViewCellSeparatorStyleSingleLine; table.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    table.rowHeight=UITableViewAutomaticDimension; table.estimatedRowHeight=52;
    [CSGroupChatSettingsCell registerToTableView:table];
}

@interface CSGroupChatTemplateEditor : UIViewController <UITextViewDelegate>
@property(nonatomic,copy) NSDictionary *context;
@property(nonatomic,copy) NSString *configurationKey;
@property(nonatomic,copy) NSString *initialText;
@property(nonatomic,copy) NSString *defaultText;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UILabel *counterLabel;
@property(nonatomic,strong) UILabel *previewLabel;
@property(nonatomic,strong) UILabel *stateLabel;
@property(nonatomic) BOOL saving;
@end
@implementation CSGroupChatTemplateEditor
- (BOOL)hidesBottomBarWhenPushed { return YES; }
- (void)viewDidLoad {
    [super viewDidLoad]; self.edgesForExtendedLayout=UIRectEdgeNone; self.extendedLayoutIncludesOpaqueBars=NO;
    self.navigationItem.largeTitleDisplayMode=UINavigationItemLargeTitleDisplayModeNever;
    self.view.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    UIScrollView *scroll=[UIScrollView new]; scroll.translatesAutoresizingMaskIntoConstraints=NO;
    scroll.keyboardDismissMode=UIScrollViewKeyboardDismissModeInteractive; scroll.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:scroll];
    UIStackView *stack=[UIStackView new]; stack.axis=UILayoutConstraintAxisVertical; stack.spacing=12; stack.translatesAutoresizingMaskIntoConstraints=NO;
    [scroll addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [scroll.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [scroll.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [scroll.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [scroll.bottomAnchor constraintEqualToAnchor:self.view.keyboardLayoutGuide.topAnchor],
        [stack.leadingAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.leadingAnchor constant:16],
        [stack.trailingAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.trailingAnchor constant:-16],
        [stack.topAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.topAnchor constant:16],
        [stack.bottomAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.bottomAnchor constant:-24],
        [stack.widthAnchor constraintEqualToAnchor:scroll.frameLayoutGuide.widthAnchor constant:-32]
    ]];
    UITextView *text=[UITextView new]; self.textView=text; text.delegate=self; text.text=self.initialText?:@"";
    text.accessibilityLabel=self.title; text.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; text.adjustsFontForContentSizeCategory=YES;
    text.textColor=UIColor.labelColor; text.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
    text.layer.cornerRadius=10; text.textContainerInset=UIEdgeInsetsMake(12,12,12,12);
    text.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever; text.automaticallyAdjustsScrollIndicatorInsets=NO;
    [stack addArrangedSubview:text]; [text.heightAnchor constraintEqualToConstant:220].active=YES;
    self.counterLabel=[self labelWithStyle:UIFontTextStyleFootnote]; [stack addArrangedSubview:self.counterLabel];
    UIStackView *buttons=[UIStackView new]; buttons.axis=UILayoutConstraintAxisHorizontal; buttons.distribution=UIStackViewDistributionFillEqually; buttons.spacing=12;
    [stack addArrangedSubview:buttons];
    for (NSString *title in @[@"插入变量",@"恢复默认"]) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem]; [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; button.titleLabel.adjustsFontForContentSizeCategory=YES;
        [button addTarget:self action:[title isEqual:@"插入变量"]?@selector(insertVariable):@selector(restoreDefault) forControlEvents:UIControlEventTouchUpInside];
        [button.heightAnchor constraintGreaterThanOrEqualToConstant:44].active=YES; [buttons addArrangedSubview:button];
    }
    UILabel *help=[self labelWithStyle:UIFontTextStyleFootnote];
    if ([self.configurationKey isEqual:@"welcomeTemplate"])
        help.text=@"@昵称显示微信昵称并提醒新成员；@备注显示群内备注；@微信ID显示成员的微信账号标识。备注或 ID 缺失时留空。支持换行、标点和表情。";
    else if ([self.configurationKey isEqual:@"departureRoomTemplate"])
        help.text=@"消息会发到成员离开的群，群内成员可见。@昵称、@备注和@微信ID均为文字，ID 缺失时留空；@离群类型显示已确认的离群原因。";
    else
        help.text=@"此通知仅自己可见，点击昵称可查看成员资料。@备注显示群内备注；@微信ID显示成员的微信账号标识。备注或 ID 缺失时留空；@离群类型显示已确认的离群原因。";
    [stack addArrangedSubview:help];
    UILabel *heading=[self labelWithStyle:UIFontTextStyleHeadline]; heading.text=@"预览"; heading.textColor=UIColor.labelColor; [stack addArrangedSubview:heading];
    self.previewLabel=[self labelWithStyle:UIFontTextStyleBody]; self.previewLabel.textColor=UIColor.labelColor;
    self.previewLabel.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor; self.previewLabel.layer.cornerRadius=10; self.previewLabel.clipsToBounds=YES;
    [stack addArrangedSubview:self.previewLabel];
    self.stateLabel=[self labelWithStyle:UIFontTextStyleFootnote]; [stack addArrangedSubview:self.stateLabel];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(stateChanged:) name:CSGroupChatConfigurationDidChange object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(stateChanged:) name:@"CSBackupAccountChanged" object:nil];
    [self updatePreview]; [self stateChanged:nil];
}
- (UILabel *)labelWithStyle:(UIFontTextStyle)style {
    UILabel *label=[UILabel new]; label.font=[UIFont preferredFontForTextStyle:style]; label.adjustsFontForContentSizeCategory=YES;
    label.textColor=UIColor.secondaryLabelColor; label.numberOfLines=0; return label;
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)stateChanged:(NSNotification *)note {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self stateChanged:note]; }); return; }
    BOOL valid=CSGCContextValid(self.context,YES);
    self.navigationItem.rightBarButtonItem.enabled=valid && !self.saving;
    self.navigationItem.rightBarButtonItem.title=self.saving?@"保存中…":@"保存";
    self.textView.editable=valid && !self.saving;
    self.stateLabel.text=valid || self.saving?@"预览使用示例成员与群聊，不会发送消息。":@"账号或设置已变化，请返回后重新编辑。当前内容尚未保存。";
}
- (void)textViewDidChange:(UITextView *)textView { (void)textView; [self updatePreview]; }
- (void)updatePreview {
    NSString *text=self.textView.text?:@"";
    self.counterLabel.text=[NSString stringWithFormat:@"%lu / 4,000",(unsigned long)text.length];
    self.counterLabel.textColor=text.length>4000?UIColor.systemRedColor:UIColor.secondaryLabelColor;
    NSMutableDictionary *values=[@{@"@昵称":@"张三",@"@备注":@"三哥",@"@微信ID":@"wxid_zhangsan",@"@群昵称":@"读书群",@"@群人数":@"128",@"@时间":CSGroupChatDateText(NSDate.date)} mutableCopy];
    if ([self.configurationKey isEqual:@"welcomeTemplate"]) values[@"@昵称"]=@"@张三\u2005";
    else values[@"@离群类型"]=@"被移出";
    self.previewLabel.text=CSGroupChatRenderTemplate(text,values);
}
- (void)cancel { [self.navigationController popViewControllerAnimated:YES]; }
- (void)insertVariable {
    if (!CSGCContextValid(self.context,YES) || self.saving || !CSSettingsCanPresentFrom(self)) return;
    UIAlertController *sheet=[UIAlertController alertControllerWithTitle:@"插入变量" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf=self;
    __weak UIAlertController *weakSheet=sheet;
    NSMutableArray *tokens=[NSMutableArray arrayWithArray:@[@"@昵称",@"@备注",@"@微信ID",@"@群昵称",@"@时间",@"@群人数"]];
    if (![self.configurationKey isEqual:@"welcomeTemplate"]) [tokens addObject:@"@离群类型"];
    for (NSString *token in tokens) {
        [sheet addAction:[UIAlertAction actionWithTitle:token style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
            CSSettingsAfterDismissingSheet(weakSheet,^{
                typeof(self) page=weakSelf; if (!page || !CSGCContextValid(page.context,YES) || page.saving) return;
                [page.textView becomeFirstResponder]; [page.textView insertText:token]; [page updatePreview];
            });
        }]];
    }
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    sheet.popoverPresentationController.sourceView=self.view; sheet.popoverPresentationController.sourceRect=CGRectMake(CGRectGetMidX(self.view.bounds),180,1,1);
    [self presentViewController:sheet animated:YES completion:nil];
}
- (void)restoreDefault {
    if (!CSGCContextValid(self.context,YES) || self.saving) return;
    self.textView.text=self.defaultText?:@""; [self updatePreview];
}
- (void)save {
    if (!CSGCContextValid(self.context,YES) || self.saving) { CSGCAlert(self,@"账号或设置已变化，请返回后重新编辑。"); return; }
    if (!CSGCRequireAuthorization(self)) return;
    NSString *text=self.textView.text?:@"";
    if (![text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length) { CSGCAlert(self,@"请输入文案，内容不能全为空白。"); return; }
    if (text.length>4000) { CSGCAlert(self,@"文案不能超过 4,000 个字符。"); return; }
    self.saving=YES; [self stateChanged:nil];
    __weak typeof(self) weakSelf=self;
    [CSGroupChatManager.sharedManager updateConfiguration:@{self.configurationKey:text} completion:^(BOOL success,NSError *error){
        dispatch_async(dispatch_get_main_queue(),^{
            typeof(self) page=weakSelf; if (!page) return; page.saving=NO;
            if (success) { if (page.navigationController.topViewController==page) [page.navigationController popViewControllerAnimated:YES]; }
            else { [page stateChanged:nil]; CSGCAlert(page,error.localizedDescription?:@"保存失败，请重试。"); }
        });
    }];
}
@end

@interface CSGroupChatQuitResultsViewController : CSSettingsTableViewController
@property(nonatomic,copy) NSDictionary *context;
@property(nonatomic,copy) NSArray<NSDictionary *> *rows;
@property(nonatomic,copy) NSString *footerText;
@end
@implementation CSGroupChatQuitResultsViewController
- (void)viewDidLoad {
    [super viewDidLoad]; self.title=@"退群结果"; CSGCConfigureTable(self.tableView);
    for (NSString *name in @[CSGroupChatQuitDidChange,CSGroupChatConfigurationDidChange,@"CSBackupAccountChanged"])
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [self reloadResults];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; [self reloadResults]; }
- (void)changed:(NSNotification *)note {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self changed:note]; }); return; }
    [self reloadResults];
}
- (void)reloadResults {
    CSGroupChatQuitCoordinator *coordinator=CSGroupChatQuitCoordinator.sharedCoordinator;
    BOOL sameAccount=CSGCContextValid(self.context,NO);
    self.rows=sameAccount?coordinator.results:@[];
    self.footerText=sameAccount?(coordinator.statusText?:@""):@"账号已变化，本页已停止显示原账号的退群结果。";
    self.navigationItem.rightBarButtonItem=sameAccount && coordinator.running?[[UIBarButtonItem alloc] initWithTitle:@"停止后续" style:UIBarButtonItemStylePlain target:self action:@selector(stop)]:nil;
    [self.tableView reloadData];
}
- (void)stop {
    if (!CSGCContextValid(self.context,NO)) { [self reloadResults]; return; }
    [CSGroupChatQuitCoordinator.sharedCoordinator stopFollowingBatches]; [self reloadResults];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView; return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView;(void)section; return self.rows.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { (void)tableView;(void)section; return self.rows.count?[NSString stringWithFormat:@"%lu 个群聊",(unsigned long)self.rows.count]:@"暂无结果"; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section { (void)tableView;(void)section; return self.footerText; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    NSDictionary *row=self.rows[path.row]; NSString *state=row[@"status"];
    NSDictionary *labels=@{@"waiting":@"等待中",@"processing":@"处理中",@"succeeded":@"已退出",@"failed":@"失败",@"needsAction":@"需处理",@"unknown":@"结果待核实",@"skipped":@"已跳过"};
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CSGroupChatQuitResult"];
    if (!cell) cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CSGroupChatQuitResult"];
    cell.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
    cell.textLabel.text=row[@"name"]?:@"群聊"; cell.textLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.textLabel.numberOfLines=0; cell.textLabel.adjustsFontForContentSizeCategory=YES;
    NSString *detail=[row[@"detail"] isKindOfClass:NSString.class]?row[@"detail"]:@"";
    cell.detailTextLabel.text=detail.length?[NSString stringWithFormat:@"%@ · %@",labels[state]?:@"等待中",detail]:(labels[state]?:@"等待中");
    cell.detailTextLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]; cell.detailTextLabel.adjustsFontForContentSizeCategory=YES; cell.detailTextLabel.numberOfLines=0;
    cell.detailTextLabel.textColor=[state isEqual:@"succeeded"]?UIColor.systemGreenColor:([state isEqual:@"needsAction"]?UIColor.systemOrangeColor:UIColor.secondaryLabelColor);
    BOOL canOpen=[state isEqual:@"needsAction"] || [state isEqual:@"failed"] || [state isEqual:@"unknown"];
    cell.accessoryType=canOpen?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    cell.selectionStyle=canOpen?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
    if (path.row<0 || (NSUInteger)path.row>=self.rows.count || !CSGCContextValid(self.context,NO) || !CSGCRequireAuthorization(self)) return;
    NSDictionary *row=self.rows[path.row]; NSString *state=row[@"status"];
    if (![@[@"needsAction",@"failed",@"unknown"] containsObject:state]) return;
    if (!CSGroupChatOpenRoomProfile(row[@"roomID"],self)) CSGCAlert(self,[row[@"detail"] length]?row[@"detail"]:@"暂时无法打开群资料，请从微信进入该群处理后重试。");
}
@end

@interface CSGroupChatQuitConfirmViewController : CSSettingsTableViewController
@property(nonatomic,copy) NSDictionary *context;
@property(nonatomic,copy) NSArray<NSString *> *roomIDs;
@property(nonatomic,copy) NSArray<NSString *> *roomNames;
@property(nonatomic) BOOL clearHistory;
@end
@implementation CSGroupChatQuitConfirmViewController
- (void)viewDidLoad {
    [super viewDidLoad]; self.title=@"确认退出群聊"; CSGCConfigureTable(self.tableView);
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:CSGroupChatConfigurationDidChange object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:@"CSBackupAccountChanged" object:nil];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)changed:(NSNotification *)note { (void)note; dispatch_async(dispatch_get_main_queue(),^{ [self.tableView reloadData]; }); }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView; return 3; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView; return section==0?(CSGCContextValid(self.context,NO)?self.roomIDs.count:0):1; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    if (section==0) return CSGCContextValid(self.context,NO)?[NSString stringWithFormat:@"将退出以下 %lu 个群聊",(unsigned long)self.roomIDs.count]:@"原账号清单已隐藏";
    return section==1?@"聊天记录":nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (!CSGCContextValid(self.context,YES)) return section==2?@"账号或设置已变化，请返回后重新确认。":nil;
    if (section==1) return self.clearHistory?@"退出时同时清空这些群的本地聊天记录，清空后无法撤销。":@"退出后保留已有聊天记录。";
    return section==2?@"退出后需要重新受邀才能加入。需要先处理的群会单独列出，尚未开始的后续操作可停止。":nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSGroupChatSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSGroupChatSettingsCell.reuseIdentifier forIndexPath:path];
    CSSettingItem *item=nil; __weak typeof(self) weakSelf=self;
    if (path.section==0) item=CSGCRow(self.roomNames[path.row],@"person.3.fill",UIColor.systemGreenColor,nil,nil);
    else if (path.section==1) item=[CSSettingItem switchItemWithTitle:@"同时清空聊天记录" iconName:@"trash" iconColor:UIColor.systemRedColor switchValue:self.clearHistory valueChangedBlock:^(BOOL enabled){ weakSelf.clearHistory=enabled; [weakSelf.tableView reloadData]; }];
    else item=CSGCRow([NSString stringWithFormat:@"退出 %lu 个群聊",(unsigned long)self.roomIDs.count],@"rectangle.portrait.and.arrow.right",UIColor.systemRedColor,nil,^{ [weakSelf beginQuit]; });
    [cell configureWithItem:item];
    if (path.section==0) { cell.textLabel.numberOfLines=0; cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping; }
    if (path.section==2) { cell.textLabel.textColor=UIColor.systemRedColor; cell.accessoryType=UITableViewCellAccessoryNone; }
    if (path.section>0 && (!CSGCContextValid(self.context,YES) || CSGroupChatQuitCoordinator.sharedCoordinator.running)) { cell.userInteractionEnabled=NO; cell.contentView.alpha=0.45; }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES]; if (path.section==2) [self beginQuit];
}
- (void)beginQuit {
    if (!CSGCContextValid(self.context,YES)) { CSGCAlert(self,@"账号或设置已变化，请返回后重新确认。"); return; }
    if (!CSGCRequireAuthorization(self)) return;
    NSError *error=nil;
    if (![CSGroupChatQuitCoordinator.sharedCoordinator startRoomIDs:self.roomIDs clearHistory:self.clearHistory account:self.context[@"account"] epoch:[self.context[@"epoch"] unsignedIntegerValue] error:&error]) {
        CSGCAlert(self,error.localizedDescription?:@"暂时无法开始退群，请稍后重试。"); return;
    }
    CSGroupChatQuitResultsViewController *results=[[CSGroupChatQuitResultsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped]; results.context=self.context;
    NSMutableArray *pages=[self.navigationController.viewControllers mutableCopy];
    if (pages.lastObject==self) [pages removeLastObject]; [pages addObject:results];
    [self.navigationController setViewControllers:pages animated:YES];
}
@end

@interface CSGroupChatSettingsViewController ()
@property(nonatomic,copy) NSArray<CSSettingSection *> *sections;
@property(nonatomic,copy) NSArray<NSString *> *quitRooms;
@property(nonatomic,copy) NSString *displayAccount;
@property(nonatomic) NSUInteger displayEpoch;
@property(nonatomic) BOOL saving;
@end
@implementation CSGroupChatSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad]; self.title=@"群聊功能"; CSGCConfigureTable(self.tableView); self.quitRooms=@[];
    for (NSString *name in @[CSGroupChatConfigurationDidChange,CSGroupChatQuitDidChange,@"CSBackupAccountChanged"])
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [CSGroupChatManager.sharedManager start]; [self reloadSettings];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; [CSGroupChatManager.sharedManager refresh]; [self reloadSettings]; }
- (void)changed:(NSNotification *)note {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self changed:note]; }); return; }
    CSNativeContactPickerRevalidate(self); [self reloadSettings];
}
- (void)reloadSettings {
    CSGroupChatManager *manager=CSGroupChatManager.sharedManager;
    if (![self.displayAccount isEqual:manager.accountID] || self.displayEpoch!=manager.accountEpoch) {
        self.quitRooms=@[]; self.displayAccount=manager.accountID?:@""; self.displayEpoch=manager.accountEpoch;
    }
    NSDictionary *config=manager.configuration?:CSGroupChatDefaultConfiguration(); __weak typeof(self) weakSelf=self;
    CSSettingItem *(^toggle)(NSString *,NSString *,NSString *)=^CSSettingItem *(NSString *title,NSString *icon,NSString *key){
        return [CSSettingItem switchItemWithTitle:title iconName:icon iconColor:UIColor.systemGreenColor switchValue:[config[key] boolValue] valueChangedBlock:^(BOOL on){
            [weakSelf saveChanges:@{key:@(on)} context:CSGCContext()];
        }];
    };
    NSArray *welcomeRooms=[config[@"welcomeRooms"] isKindOfClass:NSArray.class]?config[@"welcomeRooms"]:@[];
    NSArray *monitorRooms=[config[@"monitorRooms"] isKindOfClass:NSArray.class]?config[@"monitorRooms"]:@[];
    NSArray *welcome=@[
        toggle(@"开启入群欢迎",@"hand.wave.fill",@"welcomeEnabled"),
        CSGCRow(@"选择群聊",@"person.3.fill",UIColor.systemGreenColor,[NSString stringWithFormat:@"已选 %lu 个群",(unsigned long)welcomeRooms.count],^{ [weakSelf chooseRoomsForKey:@"welcomeRooms"]; }),
        CSGCRow(@"欢迎文案",@"text.bubble.fill",UIColor.systemBlueColor,config[@"welcomeTemplate"],^{ [weakSelf editTemplate:@"welcomeTemplate"]; }),
        CSGCRow(@"发送延迟",@"clock.fill",UIColor.systemOrangeColor,[NSString stringWithFormat:@"%@ 秒",config[@"welcomeDelay"]?:@3],^{ [weakSelf editDelay]; })
    ];
    NSArray *monitor=@[
        toggle(@"开启退群监控",@"person.crop.circle.badge.minus",@"monitorEnabled"),
        CSGCRow(@"选择监控群聊",@"person.3.fill",UIColor.systemGreenColor,[NSString stringWithFormat:@"已选 %lu 个群",(unsigned long)monitorRooms.count],^{ [weakSelf chooseRoomsForKey:@"monitorRooms"]; }),
        CSGCRow(@"通知文案",@"bell.fill",UIColor.systemOrangeColor,config[@"departureTemplate"],^{ [weakSelf editTemplate:@"departureTemplate"]; }),
        toggle(@"通知发送本群",@"paperplane.fill",@"departureSendToRoom"),
        CSGCRow(@"本群文案",@"text.bubble.fill",UIColor.systemBlueColor,[config[@"departureSendToRoom"] boolValue]?(config[@"departureRoomTemplate"]?:CSGroupChatDefaultRoomDeparture()):@"开启后可编辑",^{ [weakSelf editTemplate:@"departureRoomTemplate"]; })
    ];
    NSMutableArray *quit=[NSMutableArray arrayWithArray:@[
        CSGCRow(@"选择群聊",@"person.3.fill",UIColor.systemGreenColor,[NSString stringWithFormat:@"已选 %lu 个群",(unsigned long)self.quitRooms.count],^{ [weakSelf chooseRoomsForKey:nil]; }),
        CSGCRow(@"退出所选群聊",@"rectangle.portrait.and.arrow.right",UIColor.systemRedColor,nil,^{ [weakSelf confirmQuit]; })
    ]];
    if (CSGroupChatQuitCoordinator.sharedCoordinator.results.count || CSGroupChatQuitCoordinator.sharedCoordinator.running)
        [quit addObject:CSGCRow(CSGroupChatQuitCoordinator.sharedCoordinator.running?@"查看退群进度":@"上次退群结果",@"list.bullet.rectangle",UIColor.systemBlueColor,nil,^{ [weakSelf showQuitResults]; })];
    self.sections=@[
        [CSSettingSection sectionWithHeader:@"入群欢迎" items:welcome],
        [CSSettingSection sectionWithHeader:@"退群监控" items:monitor],
        [CSSettingSection sectionWithHeader:@"自动添加通讯录" items:@[toggle(@"加入新群后自动保存",@"person.crop.rectangle.badge.plus",@"autoSaveEnabled")]],
        [CSSettingSection sectionWithHeader:@"批量退群" items:quit]
    ];
    [self.tableView reloadData];
}
- (BOOL)rowEnabled:(NSIndexPath *)path {
    CSGroupChatManager *manager=CSGroupChatManager.sharedManager;
    if (!manager.ready || self.saving || !CSBackupIsReady() || CSBackupAccountIsSuspended()) return NO;
    if (path.section==0 && path.row>0) return [manager.configuration[@"welcomeEnabled"] boolValue];
    if (path.section==1 && path.row>0) return [manager.configuration[@"monitorEnabled"] boolValue] &&
        (path.row!=4 || [manager.configuration[@"departureSendToRoom"] boolValue]);
    if (path.section==3 && path.row<2) return !CSGroupChatQuitCoordinator.sharedCoordinator.running && (path.row==0 || self.quitRooms.count>0);
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView; return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView; return self.sections[section].items.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { (void)tableView; return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (!CSGroupChatManager.sharedManager.ready) return section==0?(CSGroupChatManager.sharedManager.statusText?:@"当前账号尚未就绪，请稍后重试。"):nil;
    if (section==0) {
        NSString *help=@"变量：@昵称、@备注、@微信ID、@群昵称、@群人数、@时间。第一次取得名单时不欢迎已有成员。";
        NSString *status=CSGroupChatManager.sharedManager.statusText;
        return status.length?[help stringByAppendingFormat:@"\n%@",status]:help;
    }
    if (section==1) return @"变量：@昵称、@备注、@微信ID、@群昵称、@群人数、@时间、@离群类型。通知仅自己可见；打开「通知发送本群」后，另向成员离开的群发送本群文案。\n\n入群欢迎和退群监控跟随「插件设置 → 后台运行」。开启后，微信有后台执行机会时会尝试实时处理已选群，可能增加耗电；锁屏时受系统和微信连接限制。关闭后台运行、微信挂起或断线时，回到前台会核对名单并补处理仍能确认的变化。";
    if (section==2) return @"将新加入的群聊保存到微信通讯录，效果与群资料页一致；开启前已有群不补存。";
    if (section==3) return @"先选择群聊，再核对清单并确认退出。默认保留聊天记录。";
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSGroupChatSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSGroupChatSettingsCell.reuseIdentifier forIndexPath:path];
    [cell configureWithItem:self.sections[path.section].items[path.row]];
    if (path.section==3 && path.row==1) { cell.textLabel.textColor=UIColor.systemRedColor; cell.accessoryType=UITableViewCellAccessoryNone; }
    BOOL enabled=[self rowEnabled:path]; cell.userInteractionEnabled=enabled; cell.contentView.alpha=enabled?1:0.45;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
    if (![self rowEnabled:path] || !CSGCRequireAuthorization(self)) return;
    CSSettingItem *item=self.sections[path.section].items[path.row]; if (item.actionBlock) item.actionBlock();
}
- (void)saveChanges:(NSDictionary *)changes context:(NSDictionary *)context {
    if (self.saving || !CSGCContextValid(context,YES)) { [self reloadSettings]; return; }
    if (!CSGCRequireAuthorization(self)) { [self reloadSettings]; return; }
    self.saving=YES; [self reloadSettings]; __weak typeof(self) weakSelf=self;
    [CSGroupChatManager.sharedManager updateConfiguration:changes completion:^(BOOL success,NSError *error){
        dispatch_async(dispatch_get_main_queue(),^{
            typeof(self) page=weakSelf; if (!page) return; page.saving=NO; [page reloadSettings];
            if (!success) CSGCAlert(page,error.localizedDescription?:@"保存失败，请重试。");
        });
    }];
}
- (void)chooseRoomsForKey:(NSString *)key {
    if (!CSGCRequireAuthorization(self) || self.saving || !CSSettingsCanPresentFrom(self)) return;
    NSDictionary *context=CSGCContext(); NSArray *selected=key?CSGroupChatManager.sharedManager.configuration[key]:self.quitRooms;
    __weak typeof(self) weakSelf=self; NSError *error=nil;
    BOOL shown=CSNativeContactPickerPresent(self,key?([key isEqual:@"welcomeRooms"]?@"选择欢迎群聊":@"选择监控群聊"):@"选择待退出群聊",YES,selected?:@[],^BOOL{
        return weakSelf && CSGCContextValid(context,YES) && !weakSelf.saving;
    },^(NSArray<NSString *> *names){
        typeof(self) page=weakSelf; if (!page || !CSGCContextValid(context,YES)) return;
        if (key) [page saveChanges:@{key:names} context:context];
        else { page.quitRooms=names; [page reloadSettings]; }
    },&error);
    if (!shown) CSGCAlert(self,error.localizedDescription?:@"当前无法选择群聊，请稍后重试。原有名单已保留。");
}
- (void)editTemplate:(NSString *)key {
    if (!CSGCRequireAuthorization(self) || self.saving || !CSSettingsCanPresentFrom(self)) return;
    NSDictionary *config=CSGroupChatManager.sharedManager.configuration;
    BOOL welcome=[key isEqual:@"welcomeTemplate"],room=[key isEqual:@"departureRoomTemplate"];
    if (room && (![config[@"monitorEnabled"] boolValue] || ![config[@"departureSendToRoom"] boolValue])) return;
    CSGroupChatTemplateEditor *editor=[CSGroupChatTemplateEditor new]; editor.context=CSGCContext(); editor.configurationKey=key;
    editor.defaultText=welcome?CSGroupChatDefaultWelcome():(room?CSGroupChatDefaultRoomDeparture():CSGroupChatDefaultDeparture());
    editor.initialText=config[key]?:editor.defaultText;
    editor.title=welcome?@"欢迎文案":(room?@"本群文案":@"通知文案");
    [self.navigationController pushViewController:editor animated:YES];
}
- (void)editDelay {
    if (!CSGCRequireAuthorization(self) || self.saving || !CSSettingsCanPresentFrom(self)) return;
    NSDictionary *context=CSGCContext(); __weak typeof(self) weakSelf=self;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"发送延迟" message:@"输入 0–300 的整数秒数，0 表示立即发送。" preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlert=alert;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.keyboardType=UIKeyboardTypeNumberPad; field.text=[CSGroupChatManager.sharedManager.configuration[@"welcomeDelay"] description]; field.placeholder=@"3"; }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        NSString *text=[weakAlert.textFields.firstObject.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        NSCharacterSet *digits=[NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        BOOL valid=text.length>0 && [text rangeOfCharacterFromSet:digits.invertedSet].location==NSNotFound && text.length<=3 && text.integerValue<=300;
        CSSettingsAfterDismissingSheet(weakAlert,^{
            typeof(self) page=weakSelf; if (!page) return;
            if (!CSGCContextValid(context,YES)) { CSGCAlert(page,@"账号或设置已变化，请重新设置延迟。"); return; }
            if (!valid) { CSGCAlert(page,@"请输入 0–300 的整数秒数。"); return; }
            [page saveChanges:@{@"welcomeDelay":@(text.integerValue)} context:context];
        });
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)confirmQuit {
    if (!CSGCRequireAuthorization(self) || !self.quitRooms.count || CSGroupChatQuitCoordinator.sharedCoordinator.running || !CSSettingsCanPresentFrom(self)) return;
    NSDictionary *context=CSGCContext(); NSMutableArray *names=[NSMutableArray array];
    for (NSString *roomID in self.quitRooms) [names addObject:CSGroupChatRoomName(roomID)?:@"群聊暂不可用"];
    if (!CSGCContextValid(context,YES)) { [self reloadSettings]; return; }
    CSGroupChatQuitConfirmViewController *page=[[CSGroupChatQuitConfirmViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
    page.context=context; page.roomIDs=self.quitRooms; page.roomNames=names; page.clearHistory=NO;
    [self.navigationController pushViewController:page animated:YES];
}
- (void)showQuitResults {
    if (!CSGCRequireAuthorization(self) || !CSSettingsCanPresentFrom(self)) return;
    CSGroupChatQuitResultsViewController *page=[[CSGroupChatQuitResultsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped]; page.context=CSGCContext();
    [self.navigationController pushViewController:page animated:YES];
}
@end
