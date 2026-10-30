#import "CSAIReplySettingsViewController.h"
#import "CSAIReplyManager.h"
#import "CSSettingTableViewCell.h"
#import "CSNativeSettingsHost.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendAutomationProjection.h"

static void AIAlert(UIViewController *page,NSString *message){
    if(page.presentedViewController)return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"AI 自动回复" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];[page presentViewController:alert animated:YES completion:nil];
}
static void AIPopIfVisible(UIViewController *page){
    if(page.navigationController.topViewController==page)[page.navigationController popViewControllerAnimated:YES];
}
static CSSettingItem *AIRow(NSString *title,NSString *icon,NSString *detail,void(^action)(void)){
    CSSettingItem *item=[CSSettingItem itemWithTitle:title iconName:icon iconColor:UIColor.systemBlueColor detail:detail];item.actionBlock=action;return item;
}
@interface CSAISettingsCell : CSSettingTableViewCell
@end
@implementation CSAISettingsCell
+ (NSString *)reuseIdentifier{return @"CSAISettingsCell";}
- (void)configureWithItem:(CSSettingItem *)item{
    [super configureWithItem:item];self.textLabel.numberOfLines=1;self.detailTextLabel.numberOfLines=1;
    self.textLabel.lineBreakMode=NSLineBreakByTruncatingTail;self.detailTextLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    if(item.actionBlock)self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    else if(item.itemType!=CSSettingItemTypeSwitch)self.selectionStyle=UITableViewCellSelectionStyleNone;
}
- (void)layoutSubviews{
    [super layoutSubviews];CGFloat left=54,available=MAX(0,CGRectGetWidth(self.contentView.bounds)-left-15);
    CGFloat detailWidth=self.detailTextLabel.text.length?MIN(available*0.52,[self.detailTextLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width):0;
    CGFloat trailing=detailWidth?detailWidth+8:0;
    for(UIView *view in self.contentView.subviews)if([view isKindOfClass:UISwitch.class])trailing=CGRectGetWidth(view.bounds)+8;
    CGRect title=self.textLabel.frame;title.origin.x=left;title.size.width=MAX(0,available-trailing);self.textLabel.frame=title;
    CGRect detail=self.detailTextLabel.frame;detail.origin.x=left+available-detailWidth;detail.size.width=detailWidth;self.detailTextLabel.frame=detail;
}
@end
static void AIConfigureTable(UITableView *table){table.backgroundColor=UIColor.systemGroupedBackgroundColor;table.separatorInset=UIEdgeInsetsMake(0,54,0,0);[CSAISettingsCell registerToTableView:table];}

@interface CSAISettingsPage ()
@property(nonatomic,copy) NSString *account;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) BOOL saving;
@property(nonatomic,copy) NSArray<CSSettingSection *> *sections;
@property(nonatomic,copy) NSArray<NSString *> *footers;
- (BOOL)current;
- (void)reload;
- (void)save:(NSDictionary *)configuration;
- (void)save:(NSDictionary *)configuration completion:(void(^)(BOOL))completion;
@end
@implementation CSAISettingsPage
- (void)viewDidLoad{
    [super viewDidLoad];AIConfigureTable(self.tableView);
    if(!self.account){[CSAIReplyManager.sharedManager refresh];self.account=CSAIReplyManager.sharedManager.store.account?:@"";self.epoch=CSAIReplyManager.sharedManager.epoch;}
    for(NSString *name in @[CSAIReplyDidChange,CSCloseFriendPolicyDidChangeNotification,@"CSBackupAccountChanged"])
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [self reload];
}
- (void)dealloc{[NSNotificationCenter.defaultCenter removeObserver:self];}
- (void)viewWillAppear:(BOOL)animated{[super viewWillAppear:animated];[self reload];}
- (void)changed:(NSNotification *)note{(void)note;[self reload];}
- (BOOL)current{return !self.saving && [CSAIReplyManager.sharedManager isCurrentAccount:self.account epoch:self.epoch];}
- (void)reload{[self.tableView reloadData];}
- (void)save:(NSDictionary *)configuration {[self save:configuration completion:nil];}
- (void)save:(NSDictionary *)configuration completion:(void(^)(BOOL))completion {
    if(self.saving)return;self.saving=YES;[self reload];
    [CSAIReplyManager.sharedManager saveConfiguration:configuration account:self.account epoch:self.epoch completion:^(BOOL success,NSError *error){
        self.saving=NO;[self reload];if(!success)AIAlert(self,error.localizedDescription);if(completion)completion(success);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{(void)tableView;return self.sections.count;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{(void)tableView;return self.sections[section].items.count;}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{(void)tableView;return self.sections[section].header;}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{(void)tableView;return section<(NSInteger)self.footers.count?self.footers[section]:nil;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path{
    CSAISettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSAISettingsCell.reuseIdentifier forIndexPath:path];[cell configureWithItem:self.sections[path.section].items[path.row]];
    cell.userInteractionEnabled=[self current];cell.contentView.alpha=cell.userInteractionEnabled?1:0.5;return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path{[tableView deselectRowAtIndexPath:path animated:YES];if(![self current]){AIAlert(self,@"账号已改变，请重新打开 AI 设置。");return;}CSSettingItem *item=self.sections[path.section].items[path.row];if(item.actionBlock)item.actionBlock();}
@end

@interface CSAIOptionsPage : CSAISettingsPage
@property NSArray<NSDictionary *> *options;
@property NSString *selected;
@property NSString *optionsHeader;
@property(copy) void(^choose)(NSString *);
@end
@implementation CSAIOptionsPage
- (void)reload{
    NSMutableArray *rows=[NSMutableArray array];__weak typeof(self) weakSelf=self;
    for(NSDictionary *option in self.options)[rows addObject:AIRow(option[@"title"],@"text.bubble",[option[@"id"] isEqual:self.selected]?@"已选择":nil,^{if([weakSelf current] && weakSelf.choose)weakSelf.choose(option[@"id"]);})];
    self.sections=@[[CSSettingSection sectionWithHeader:self.optionsHeader?:@"选择预设" items:rows]];[super reload];
}
@end
static NSString *AIProviderTitle(NSDictionary *configuration){return [CSAIProvider(configuration) isEqual:@"bailian"]?@"阿里云百炼":@"通用兼容接口（默认）";}
static NSString *AISearchTitle(NSDictionary *configuration){NSString *mode=CSAISearchMode(configuration);return [mode isEqual:@"always"]?@"每次联网":[mode isEqual:@"auto"]?@"按需联网":@"关闭（默认）";}
static void AISaveCapabilityChanges(CSAISettingsPage *page,NSDictionary *changes,NSString *originalConnection,void(^completion)(BOOL)){
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;
    if(!page || ![page current] || ![originalConnection isEqual:CSAIConnectionIdentifier(manager.store.configuration)]){if(page)AIAlert(page,@"账号或模型能力已改变，请返回后重新设置。");if(completion)completion(NO);return;}
    NSMutableDictionary *configuration=[manager.store.configuration mutableCopy];[configuration addEntriesFromDictionary:changes];
    if([changes[@"provider"] isEqual:@"openai-compatible"]){configuration[@"searchMode"]=@"off";configuration[@"thinkingEnabled"]=@NO;}
    if(![originalConnection isEqual:CSAIConnectionIdentifier(configuration)]){configuration[@"verifiedConnection"]=@"";[configuration removeObjectForKey:@"verifiedAt"];}
    [page save:configuration completion:completion];
}
static void AIPresentCapabilityPicker(CSAISettingsPage *page,NSString *title,NSString *key,NSArray<NSDictionary *> *options,NSString *selected,NSString *footer){
    if(![page current])return;
    CSAIOptionsPage *picker=[[CSAIOptionsPage alloc]initWithStyle:UITableViewStyleInsetGrouped];picker.account=page.account;picker.epoch=page.epoch;
    picker.title=title;picker.optionsHeader=title;picker.options=options;picker.selected=selected;picker.footers=@[footer];
    NSString *original=CSAIConnectionIdentifier(CSAIReplyManager.sharedManager.store.configuration);
    __weak CSAISettingsPage *weakPage=page;__weak CSAIOptionsPage *weakPicker=picker;
    picker.choose=^(NSString *value){AISaveCapabilityChanges(weakPage,@{key:value},original,^(BOOL success){if(success)AIPopIfVisible(weakPicker);});};
    [page.navigationController pushViewController:picker animated:YES];
}
void CSAIPresentPresetPicker(UIViewController *controller,NSString *conversation,NSString *account,NSUInteger epoch){
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;
    if(![manager isCurrentAccount:account epoch:epoch])return;
    NSDictionary *config=manager.store.configuration;CSAIOptionsPage *picker=[[CSAIOptionsPage alloc]initWithStyle:UITableViewStyleInsetGrouped];
    picker.title=@"回复预设";picker.account=account;picker.epoch=epoch;
    NSMutableArray *options=[NSMutableArray array];if(conversation)[options addObject:@{@"id":@"",@"title":[@"跟随全局默认 · " stringByAppendingString:[manager presetNameForConversation:nil]]}];
    for(NSDictionary *preset in config[@"presets"])[options addObject:@{@"id":preset[@"id"],@"title":preset[@"name"]}];
    picker.options=options;picker.selected=conversation?config[@"conversations"][conversation][@"presetID"]?:@"":config[@"defaultPreset"];
    __weak CSAIOptionsPage *weakPicker=picker;
    picker.choose=^(NSString *identifier){
        CSAIOptionsPage *page=weakPicker;if(!page || page.saving)return;page.saving=YES;[page reload];
        CSAIReplyStoreCompletion finish=^(BOOL success,NSError *error){page.saving=NO;[page reload];if(success)AIPopIfVisible(page);else AIAlert(page,error.localizedDescription);};
        if(conversation){BOOL enabled=[manager.store.configuration[@"conversations"][conversation][@"enabled"] boolValue];[manager setConversation:conversation enabled:enabled presetID:identifier account:account epoch:epoch completion:finish];}
        else{NSMutableDictionary *updated=[manager.store.configuration mutableCopy];updated[@"defaultPreset"]=identifier;[manager saveConfiguration:updated account:account epoch:epoch completion:finish];}
    };
    [controller.navigationController pushViewController:picker animated:YES];
}

@interface CSAIConnectionEditor : UIViewController
@property NSString *account;
@property NSUInteger epoch;
@property UITextField *endpointField;
@property UITextField *modelField;
@property UITextField *keyField;
@property BOOL keyEdited;
@property BOOL saving;
@property NSString *originalConnection;
@end
@implementation CSAIConnectionEditor
- (UITextField *)field:(NSString *)label value:(NSString *)value secure:(BOOL)secure stack:(UIStackView *)stack{
    UILabel *title=[UILabel new];title.text=label;title.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];title.textColor=UIColor.secondaryLabelColor;[stack addArrangedSubview:title];
    UITextField *field=[UITextField new];field.text=value;field.borderStyle=UITextBorderStyleRoundedRect;field.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];field.adjustsFontForContentSizeCategory=YES;field.autocapitalizationType=UITextAutocapitalizationTypeNone;field.autocorrectionType=UITextAutocorrectionTypeNo;field.secureTextEntry=secure;field.accessibilityLabel=label;field.clearButtonMode=UITextFieldViewModeWhileEditing;[field.heightAnchor constraintGreaterThanOrEqualToConstant:44].active=YES;[stack addArrangedSubview:field];return field;
}
- (void)viewDidLoad{
    [super viewDidLoad];self.title=@"模型连接";self.view.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    UIScrollView *scroll=[UIScrollView new];scroll.translatesAutoresizingMaskIntoConstraints=NO;scroll.keyboardDismissMode=UIScrollViewKeyboardDismissModeInteractive;[self.view addSubview:scroll];
    UIStackView *stack=[UIStackView new];stack.axis=UILayoutConstraintAxisVertical;stack.spacing=10;stack.translatesAutoresizingMaskIntoConstraints=NO;[scroll addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[[scroll.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],[scroll.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],[scroll.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],[scroll.bottomAnchor constraintEqualToAnchor:self.view.keyboardLayoutGuide.topAnchor],[stack.leadingAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.leadingAnchor constant:20],[stack.trailingAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.trailingAnchor constant:-20],[stack.topAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.topAnchor constant:20],[stack.bottomAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.bottomAnchor constant:-20],[stack.widthAnchor constraintEqualToAnchor:scroll.frameLayoutGuide.widthAnchor constant:-40]]];
    NSDictionary *config=CSAIReplyManager.sharedManager.store.configuration;self.originalConnection=CSAIConnectionIdentifier(config);
    self.endpointField=[self field:@"API 请求地址" value:config[@"endpoint"] secure:NO stack:stack];self.endpointField.keyboardType=UIKeyboardTypeURL;self.endpointField.placeholder=@"https://服务域名/v1/chat/completions";
    self.modelField=[self field:@"模型名称" value:config[@"model"] secure:NO stack:stack];self.modelField.placeholder=@"输入服务商提供的模型名称";
    self.keyField=[self field:@"API Key" value:@"" secure:YES stack:stack];self.keyField.placeholder=[config[@"credentialRevision"] length]?@"已设置；留空保持原 Key":@"粘贴 API Key";
    [self.keyField addTarget:self action:@selector(keyChanged) forControlEvents:UIControlEventEditingChanged];
    UIButton *visibility=[UIButton buttonWithType:UIButtonTypeSystem];[visibility setTitle:@"显示 / 隐藏新输入的 Key" forState:UIControlStateNormal];[visibility addTarget:self action:@selector(toggleKey) forControlEvents:UIControlEventTouchUpInside];[stack addArrangedSubview:visibility];
    UIButton *clear=[UIButton buttonWithType:UIButtonTypeSystem];[clear setTitle:@"停用当前 Key" forState:UIControlStateNormal];[clear addTarget:self action:@selector(clearKey) forControlEvents:UIControlEventTouchUpInside];[stack addArrangedSubview:clear];
    UILabel *help=[UILabel new];help.text=@"填写兼容 Chat Completions 的完整 HTTPS 请求地址。保存连接变化后需重新测试。API Key 保存在本机钥匙串中，不随配置备份导出。";help.numberOfLines=0;help.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];help.textColor=UIColor.secondaryLabelColor;[stack addArrangedSubview:help];
}
- (void)keyChanged{self.keyEdited=YES;}
- (void)toggleKey{self.keyField.secureTextEntry=!self.keyField.secureTextEntry;}
- (void)clearKey{self.keyEdited=YES;self.keyField.text=@"";self.keyField.placeholder=@"保存后停用当前 Key";}
- (void)save{
    if(self.saving)return;
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;
    if(![manager isCurrentAccount:self.account epoch:self.epoch] || ![self.originalConnection isEqual:CSAIConnectionIdentifier(manager.store.configuration)]){AIAlert(self,@"账号或连接配置已改变，请返回后重新编辑。");return;}
    self.saving=YES;self.navigationItem.rightBarButtonItem.enabled=NO;
    [manager saveConnection:self.endpointField.text model:self.modelField.text key:self.keyEdited?self.keyField.text:nil account:self.account epoch:self.epoch completion:^(BOOL success,NSError *error){
        self.saving=NO;self.navigationItem.rightBarButtonItem.enabled=YES;
        if(success){self.keyField.text=@"";AIPopIfVisible(self);}else AIAlert(self,error.localizedDescription);
    }];
}
@end

@interface CSAIPresetEditor : UIViewController
@property NSString *account;
@property NSUInteger epoch;
@property NSDictionary *preset;
@property NSDictionary *original;
@property BOOL saving;
@property UITextField *nameField;
@property UITextView *promptView;
@end
@implementation CSAIPresetEditor
- (void)viewDidLoad{
    [super viewDidLoad];self.title=self.original?@"编辑预设":@"新增预设";self.view.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    UITextField *name=[UITextField new];self.nameField=name;name.borderStyle=UITextBorderStyleRoundedRect;name.placeholder=@"预设名称";name.text=self.preset[@"name"];name.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];name.translatesAutoresizingMaskIntoConstraints=NO;[self.view addSubview:name];
    UILabel *label=[UILabel new];label.text=@"角色与回复规则";label.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];label.textColor=UIColor.secondaryLabelColor;label.translatesAutoresizingMaskIntoConstraints=NO;[self.view addSubview:label];
    UITextView *prompt=[UITextView new];self.promptView=prompt;prompt.text=self.preset[@"prompt"];prompt.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];prompt.adjustsFontForContentSizeCategory=YES;prompt.textColor=UIColor.labelColor;prompt.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;prompt.layer.cornerRadius=10;prompt.textContainerInset=UIEdgeInsetsMake(12,12,12,12);prompt.translatesAutoresizingMaskIntoConstraints=NO;[self.view addSubview:prompt];
    [NSLayoutConstraint activateConstraints:@[[name.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],[name.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],[name.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-16],[name.heightAnchor constraintGreaterThanOrEqualToConstant:44],[label.topAnchor constraintEqualToAnchor:name.bottomAnchor constant:16],[label.leadingAnchor constraintEqualToAnchor:name.leadingAnchor],[prompt.topAnchor constraintEqualToAnchor:label.bottomAnchor constant:8],[prompt.leadingAnchor constraintEqualToAnchor:name.leadingAnchor],[prompt.trailingAnchor constraintEqualToAnchor:name.trailingAnchor],[prompt.bottomAnchor constraintEqualToAnchor:self.view.keyboardLayoutGuide.topAnchor constant:-16]]];
}
- (void)save{
    if(self.saving)return;
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;if(![manager isCurrentAccount:self.account epoch:self.epoch]){AIAlert(self,@"账号已改变，请重新打开预设。");return;}
    NSString *name=[self.nameField.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet],*prompt=[self.promptView.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSMutableDictionary *configuration=[manager.store.configuration mutableCopy];NSMutableArray *presets=[configuration[@"presets"] mutableCopy];NSUInteger index=[presets indexOfObjectPassingTest:^BOOL(NSDictionary *item,NSUInteger i,BOOL *stop){(void)i;(void)stop;return [item[@"id"] isEqual:self.preset[@"id"]];}];
    if(self.original && (index==NSNotFound || ![presets[index] isEqual:self.original])){AIAlert(self,@"此预设已被修改，请重新打开后编辑。");return;}
    NSDictionary *updated=@{@"id":self.preset[@"id"],@"name":name?:@"",@"prompt":prompt?:@""};if(index==NSNotFound)[presets addObject:updated];else presets[index]=updated;configuration[@"presets"]=presets;self.saving=YES;self.navigationItem.rightBarButtonItem.enabled=NO;
    [manager saveConfiguration:configuration account:self.account epoch:self.epoch completion:^(BOOL success,NSError *error){self.saving=NO;self.navigationItem.rightBarButtonItem.enabled=YES;if(success)AIPopIfVisible(self);else AIAlert(self,error.localizedDescription);}];
}
@end

@interface CSAIPresetsPage : CSAISettingsPage
@end
@implementation CSAIPresetsPage
- (void)viewDidLoad{[super viewDidLoad];self.title=@"管理预设";self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];}
- (void)open:(NSDictionary *)preset original:(NSDictionary *)original{
    CSAIPresetEditor *editor=[CSAIPresetEditor new];editor.account=self.account;editor.epoch=self.epoch;editor.preset=preset;editor.original=original;[self.navigationController pushViewController:editor animated:YES];
}
- (void)add{if(![self current])return;[self open:@{@"id":NSUUID.UUID.UUIDString,@"name":@"",@"prompt":@""} original:nil];}
- (void)reload{
    NSMutableArray *rows=[NSMutableArray array];__weak typeof(self) weakSelf=self;
    for(NSDictionary *preset in CSAIReplyManager.sharedManager.store.configuration[@"presets"])[rows addObject:AIRow(preset[@"name"],@"text.bubble",nil,^{[weakSelf open:preset original:preset];})];
    self.sections=@[[CSSettingSection sectionWithHeader:@"回复预设" items:rows]];self.footers=@[@"点击编辑，左滑复制或删除。每个会话可独立选择预设，未单独选择时跟随全局默认。"];
    self.navigationItem.rightBarButtonItem.enabled=[self current];[super reload];
}
- (void)remove:(NSDictionary *)preset replacement:(NSString *)replacement completion:(void(^)(BOOL))completion{
    if(![self current])return;NSMutableDictionary *config=[CSAIReplyManager.sharedManager.store.configuration mutableCopy];NSMutableArray *presets=[config[@"presets"] mutableCopy];
    NSIndexSet *indexes=[presets indexesOfObjectsPassingTest:^BOOL(NSDictionary *item,NSUInteger i,BOOL *stop){(void)i;(void)stop;return [item[@"id"] isEqual:preset[@"id"]];}];[presets removeObjectsAtIndexes:indexes];config[@"presets"]=presets;
    if([config[@"defaultPreset"] isEqual:preset[@"id"]])config[@"defaultPreset"]=replacement;
    NSMutableDictionary *conversations=[config[@"conversations"] mutableCopy];for(NSString *conversation in conversations.allKeys){NSMutableDictionary *item=[conversations[conversation] mutableCopy];if([item[@"presetID"] isEqual:preset[@"id"]]){item[@"presetID"]=replacement;conversations[conversation]=item;}}config[@"conversations"]=conversations;[self save:config completion:completion];
}
- (void)deletePreset:(NSDictionary *)preset{
    NSDictionary *config=CSAIReplyManager.sharedManager.store.configuration;NSArray *presets=config[@"presets"];
    if(presets.count<=1){AIAlert(self,@"至少保留一个回复预设。");return;}
    NSUInteger affected=0;for(NSDictionary *conversation in [config[@"conversations"] allValues])if([conversation[@"presetID"] isEqual:preset[@"id"]] || (![conversation[@"presetID"] length] && [config[@"defaultPreset"] isEqual:preset[@"id"]]))affected++;
    CSAIOptionsPage *picker=[[CSAIOptionsPage alloc]initWithStyle:UITableViewStyleInsetGrouped];picker.account=self.account;picker.epoch=self.epoch;picker.title=@"选择替代预设";
    picker.footers=@[[NSString stringWithFormat:@"删除“%@”并替换 %lu 个会话的关联。",preset[@"name"],(unsigned long)affected]];
    NSMutableArray *options=[NSMutableArray array];for(NSDictionary *item in presets)if(![item[@"id"] isEqual:preset[@"id"]])[options addObject:@{@"id":item[@"id"],@"title":item[@"name"]}];picker.options=options;
    __weak typeof(self) weakSelf=self;__weak CSAIOptionsPage *weakPicker=picker;
    picker.choose=^(NSString *replacement){if(weakPicker.saving)return;weakPicker.saving=YES;[weakPicker reload];[weakSelf remove:preset replacement:replacement completion:^(BOOL success){weakPicker.saving=NO;[weakPicker reload];if(success)AIPopIfVisible(weakPicker);}];};[self.navigationController pushViewController:picker animated:YES];
}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)path{
    (void)tableView;if(![self current])return nil;NSArray *presets=CSAIReplyManager.sharedManager.store.configuration[@"presets"];if(path.row>=(NSInteger)presets.count)return nil;NSDictionary *preset=presets[path.row];__weak typeof(self) weakSelf=self;
    UIContextualAction *copy=[UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"复制" handler:^(UIContextualAction *action,UIView *view,void(^completion)(BOOL)){(void)action;(void)view;NSMutableDictionary *item=[preset mutableCopy];item[@"id"]=NSUUID.UUID.UUIDString;item[@"name"]=[preset[@"name"] stringByAppendingString:@" 副本"];[weakSelf open:item original:nil];completion(YES);}];
    UIContextualAction *remove=[UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction *action,UIView *view,void(^completion)(BOOL)){(void)action;(void)view;[weakSelf deletePreset:preset];completion(YES);}];
    UISwipeActionsConfiguration *actions=[UISwipeActionsConfiguration configurationWithActions:@[remove,copy]];actions.performsFirstActionWithFullSwipe=NO;return actions;
}
@end

@interface CSAIConversationPage : CSAISettingsPage
@property NSString *conversation;
@end
@implementation CSAIConversationPage
- (void)reload{
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;self.title=[manager displayNameForConversation:self.conversation];NSDictionary *item=manager.store.configuration[@"conversations"][self.conversation];__weak typeof(self) weakSelf=self;
    CSSettingItem *toggle=[CSSettingItem switchItemWithTitle:@"启用 AI 回复" iconName:@"sparkles" iconColor:UIColor.systemGreenColor switchValue:[item[@"enabled"] boolValue] valueChangedBlock:^(BOOL on){typeof(self) self=weakSelf;if(!self || self.saving)return;self.saving=YES;[self reload];[manager setConversation:self.conversation enabled:on presetID:item[@"presetID"]?:@"" account:self.account epoch:self.epoch completion:^(BOOL success,NSError *error){self.saving=NO;if(!success)AIAlert(self,error.localizedDescription);[self reload];}];}];
    NSMutableArray *items=[NSMutableArray arrayWithObject:toggle];
    if([self.conversation hasSuffix:@"@chatroom"]){
        [items addObject:[CSSettingItem switchItemWithTitle:@"免 @ 回复" iconName:@"at" iconColor:UIColor.systemGreenColor switchValue:[item[@"allowUnmentioned"] boolValue] valueChangedBlock:^(BOOL on){typeof(self) self=weakSelf;if(!self || self.saving)return;self.saving=YES;[self reload];[manager setConversation:self.conversation allowUnmentioned:on account:self.account epoch:self.epoch completion:^(BOOL success,NSError *error){self.saving=NO;if(!success)AIAlert(self,error.localizedDescription);[self reload];}];}]];
    }
    [items addObject:AIRow(@"回复预设",@"text.bubble",[manager presetNameForConversation:self.conversation],^{CSAIPresentPresetPicker(weakSelf,weakSelf.conversation,weakSelf.account,weakSelf.epoch);})];
    self.sections=@[[CSSettingSection sectionWithHeader:@"AI 回复" items:items]];self.footers=@[[manager statusForConversation:self.conversation]];[super reload];
}
@end
@interface CSAIConversationsPage : CSAISettingsPage
@end
@implementation CSAIConversationsPage
- (void)reload{
    self.title=@"已开启的会话";CSAIReplyManager *manager=CSAIReplyManager.sharedManager;NSMutableArray *rows=[NSMutableArray array];__weak typeof(self) weakSelf=self;
    NSDictionary *conversations=manager.store.configuration[@"conversations"];
    NSArray *visible=[self current]?CSCloseFriendVisibleAIConversations(conversations,self.account,CSCloseFriendCurrentSnapshot()):@[];
    for(NSString *identifier in visible){
        [rows addObject:AIRow([manager displayNameForConversation:identifier],@"bubble.left.and.bubble.right",[manager presetNameForConversation:identifier],^{
            if(![weakSelf current] || ![CSCloseFriendVisibleAIConversations(manager.store.configuration[@"conversations"],weakSelf.account,CSCloseFriendCurrentSnapshot()) containsObject:identifier])return;
            CSAIConversationPage *page=[[CSAIConversationPage alloc]initWithStyle:UITableViewStyleInsetGrouped];page.account=weakSelf.account;page.epoch=weakSelf.epoch;page.conversation=identifier;[weakSelf.navigationController pushViewController:page animated:YES];
        })];
    }
    if(!rows.count)[rows addObject:AIRow(@"暂无可显示的会话",@"bubble.left",nil,nil)];
    self.sections=@[[CSSettingSection sectionWithHeader:@"会话" items:rows]];self.footers=@[@"在聊天窗口右上角“…”的聊天详情中，开启该会话的 AI 回复。"];
    [super reload];
}
@end
@interface CSAIHistoryPage : CSAISettingsPage
@end
@implementation CSAIHistoryPage
- (void)reload{
    self.title=@"回复记录";CSAIReplyManager *manager=CSAIReplyManager.sharedManager;NSMutableArray *rows=[NSMutableArray array];NSDateFormatter *formatter=[NSDateFormatter new];formatter.dateFormat=@"MM-dd HH:mm:ss";__weak typeof(self) weakSelf=self;
    NSDictionary *titles=@{@"submitted":@"已提交微信",@"unknown":@"发送结果未确认",@"failed":@"处理失败",@"cancelled":@"已取消",@"expired":@"已过期",@"skipped":@"已跳过"};
    for(NSDictionary *record in [manager.store.history reverseObjectEnumerator]){
        NSString *name=[manager displayNameForConversation:record[@"conversation"]],*result=titles[record[@"result"]]?:record[@"result"];
        NSString *presetName=@"已删除的预设";for(NSDictionary *preset in manager.store.configuration[@"presets"])if([preset[@"id"] isEqual:record[@"preset"]]){presetName=preset[@"name"];break;}
        NSString *detail=[NSString stringWithFormat:@"%@\n%@\n预设：%@\n%@\n%@",name,[formatter stringFromDate:record[@"date"]],presetName,result,record[@"detail"]];
        [rows addObject:AIRow(name,@"clock",result,^{AIAlert(weakSelf,detail);})];
    }
    if(!rows.count)[rows addObject:AIRow(@"暂无回复记录",@"clock",nil,nil)];self.sections=@[[CSSettingSection sectionWithHeader:@"最近 200 条" items:rows]];self.footers=@[@"已提交微信不代表对方已收到。记录不保存聊天正文或 API Key。发送结果未知时不会自动重发。"];
    [super reload];
}
@end

@interface CSAIReplySettingsViewController ()
@property id<CSAICancellable> test;
@property BOOL testing;
@end
@implementation CSAIReplySettingsViewController
- (void)viewDidLoad{[super viewDidLoad];self.title=@"AI 自动回复";}
- (void)dealloc{[self.test cancel];}
- (void)openConnection{
    CSAIConnectionEditor *editor=[CSAIConnectionEditor new];editor.account=self.account;editor.epoch=self.epoch;[self.navigationController pushViewController:editor animated:YES];
}
- (void)chooseProvider{
    AIPresentCapabilityPicker(self,@"服务商",@"provider",@[@{@"id":@"openai-compatible",@"title":@"通用兼容接口（默认）"},@{@"id":@"bailian",@"title":@"阿里云百炼"}],CSAIProvider(CSAIReplyManager.sharedManager.store.configuration),@"通用接口使用兼容 Chat Completions 的服务；百炼可配置联网与思考模式。切回通用接口会关闭联网与思考。服务商选择不会修改 API 地址、模型名或 Key，修改后需要重新测试连接。");
}
- (void)chooseSearchMode{
    NSDictionary *configuration=CSAIReplyManager.sharedManager.store.configuration;
    if(![CSAIProvider(configuration) isEqual:@"bailian"]){AIAlert(self,@"联网模式仅适用于阿里云百炼接口，请先选择对应服务商。通用接口默认关闭联网。");return;}
    AIPresentCapabilityPicker(self,@"联网模式",@"searchMode",@[@{@"id":@"off",@"title":@"关闭（默认）"},@{@"id":@"auto",@"title":@"按需联网"},@{@"id":@"always",@"title":@"每次联网"}],CSAISearchMode(configuration),@"按需联网由服务根据问题决定是否搜索；每次联网要求服务执行搜索。需要当前百炼模型支持。连接测试会检查参数是否可用，不代表该次一定执行了搜索。修改后需要重新测试连接。");
}
- (void)openPage:(Class)cls{
    CSAISettingsPage *page=[(CSAISettingsPage *)[cls alloc]initWithStyle:UITableViewStyleInsetGrouped];page.account=self.account;page.epoch=self.epoch;[self.navigationController pushViewController:page animated:YES];
}
- (void)testConnection{
    if(self.testing){[self.test cancel];return;}self.testing=YES;[self reload];__weak typeof(self) weakSelf=self;
    self.test=[CSAIReplyManager.sharedManager testConnectionForAccount:self.account epoch:self.epoch completion:^(NSString *text,NSError *error){
        typeof(self) self=weakSelf;if(!self)return;self.testing=NO;self.test=nil;[self reload];
        if(self.view.window && self.navigationController.topViewController==self)AIAlert(self,error.localizedDescription?:[NSString stringWithFormat:@"连接成功\n返回示例：%@",text]);
    }];
}
- (void)reload{
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;NSDictionary *config=manager.store.configuration?:CSAIReplyDefaultConfiguration();__weak typeof(self) weakSelf=self;
    CSSettingItem *toggle=[CSSettingItem switchItemWithTitle:@"启用 AI 自动回复" iconName:@"sparkles" iconColor:UIColor.systemGreenColor switchValue:[config[@"enabled"] boolValue] valueChangedBlock:^(BOOL on){NSMutableDictionary *next=[manager.store.configuration mutableCopy];next[@"enabled"]=@(on);[weakSelf save:next];}];
    NSString *originalConnection=CSAIConnectionIdentifier(config);BOOL bailian=[CSAIProvider(config) isEqual:@"bailian"];
    CSSettingItem *image=[CSSettingItem switchItemWithTitle:@"图片识别" iconName:@"photo" iconColor:UIColor.systemBlueColor switchValue:[config[@"imageEnabled"] boolValue] valueChangedBlock:^(BOOL on){AISaveCapabilityChanges(weakSelf,@{@"imageEnabled":@(on)},originalConnection,nil);}];
    CSSettingItem *thinking=[CSSettingItem switchItemWithTitle:@"思考模式" iconName:@"brain" iconColor:UIColor.systemBlueColor switchValue:[config[@"thinkingEnabled"] boolValue] valueChangedBlock:^(BOOL on){
        if(on && !bailian){AIAlert(weakSelf,@"思考模式仅适用于阿里云百炼接口，请先选择对应服务商。");[weakSelf reload];return;}
        AISaveCapabilityChanges(weakSelf,@{@"thinkingEnabled":@(on)},originalConnection,nil);
    }];
    NSUInteger count=[self current]?CSCloseFriendVisibleAIConversations(config[@"conversations"],self.account,CSCloseFriendCurrentSnapshot()).count:0;
    NSString *connection=manager.connectionStatus;if(!connection.length)connection=[config[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(config)]?@"已通过连接测试":@"尚未验证当前配置";
    self.sections=@[
        [CSSettingSection sectionWithHeader:@"功能" items:@[toggle,AIRow(@"当前状态",@"info.circle",[self current]?[manager statusForConversation:nil]:@"账号已改变或尚未就绪",nil)]],
        [CSSettingSection sectionWithHeader:@"模型连接" items:@[AIRow(@"服务商",@"cloud",AIProviderTitle(config),^{[weakSelf chooseProvider];}),AIRow(@"API 请求地址",@"link",[config[@"endpoint"] length]?config[@"endpoint"]:@"未设置",^{[weakSelf openConnection];}),AIRow(@"API Key",@"key",[config[@"credentialRevision"] length]?@"已设置":@"未设置",^{[weakSelf openConnection];}),AIRow(@"模型名称",@"cpu",[config[@"model"] length]?config[@"model"]:@"未设置",^{[weakSelf openConnection];}),image,AIRow(@"联网模式",@"globe",AISearchTitle(config),^{[weakSelf chooseSearchMode];}),thinking,AIRow(self.testing?@"取消连接测试":@"测试连接",@"network",self.testing?@"测试中…":nil,^{[weakSelf testConnection];}),AIRow(@"连接状态",@"checkmark.circle",connection,nil)]],
        [CSSettingSection sectionWithHeader:@"回复预设" items:@[AIRow(@"默认预设",@"text.bubble",[manager presetNameForConversation:nil],^{CSAIPresentPresetPicker(weakSelf,nil,weakSelf.account,weakSelf.epoch);}),AIRow(@"管理预设",@"square.stack",[NSString stringWithFormat:@"%lu 个",(unsigned long)[config[@"presets"] count]],^{[weakSelf openPage:CSAIPresetsPage.class];})]],
        [CSSettingSection sectionWithHeader:@"回复管理" items:@[AIRow(@"已开启的会话",@"bubble.left.and.bubble.right",[NSString stringWithFormat:@"%lu 个",(unsigned long)count],^{[weakSelf openPage:CSAIConversationsPage.class];}),AIRow(@"回复记录",@"clock",nil,^{[weakSelf openPage:CSAIHistoryPage.class];})]]
    ];
    self.footers=@[@"总开关与会话开关同时开启才会回复。手动回复不会暂停 AI。关闭时取消尚未提交的任务，重新开启不补回复历史消息。",@"能力设置作用于当前模型连接及所有已启用的会话。图片识别、联网、思考默认关闭，联网与思考仅支持百炼。修改连接或能力后需重新测试；启用图片时测试会发送合成图文样例，不发送微信消息。API Key 与原始图片不随配置备份导出。",@"启用后，符合规则的文本及有限上下文会发送到你配置的模型服务；开启图片识别后还会发送符合触发规则的图片，并以当前微信账号自动发送生成的回复。",@"群聊可发图后 30 秒内由同一人 @ 提问；免 @ 群可直接发图。群聊默认仅在被单独 @ 时回复，可在当前群开启“免 @ 回复”。微信被系统挂起或退出时无法保证自动回复；本功能不会自动开启后台保活。"];
    [super reload];
}
@end
