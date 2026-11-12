#import "CSAutomationSettingsViewController.h"
#import "CSAutomationManager.h"
#import "CSAutomationTiming.h"
#import "CSAutomationStore.h"
#import "CSAutomationNativeAdapter.h"
#import "CSNativeContactPicker.h"
#import "CSSettingTableViewCell.h"
#import "CSSettingsPresentation.h"
#import "CSAuthorizationManager.h"
#import "CSBackupBootstrap.h"
#import <math.h>

static NSArray<NSString *> *CSAutoModules(void) { return @[@"patBack",@"patReply",@"mentionReply",@"keywordReply"]; }
static NSArray<NSString *> *CSAutoTitles(void) { return @[@"拍我自动回拍",@"拍我自动回复",@"@我自动回复",@"关键词自动回复"]; }
static NSDictionary *CSAutoContext(void) {
    CSAutomationManager *manager=CSAutomationManager.sharedManager;
    return @{@"account":manager.accountID?:@"",@"epoch":@(manager.accountEpoch),@"generation":@(manager.configurationGeneration)};
}
static BOOL CSAutoValid(NSDictionary *context) {
    CSAutomationManager *manager=CSAutomationManager.sharedManager;
    return NSThread.isMainThread && manager.ready && CSBackupIsReady() && !CSBackupAccountIsSuspended() &&
        [context[@"account"] length] && [context[@"account"] isEqual:manager.accountID] &&
        [context[@"epoch"] unsignedIntegerValue]==manager.accountEpoch && manager.accountEpoch==CSBackupAccountEpoch() &&
        [context[@"generation"] unsignedIntegerValue]==manager.configurationGeneration;
}
static void CSAutoAlert(UIViewController *page, NSString *message) {
    if (!CSSettingsCanPresentFrom(page)) return;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"自动功能" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
    [page presentViewController:alert animated:YES completion:nil];
}
static BOOL CSAutoRequire(UIViewController *page, NSDictionary *context) {
    if (!CSAutoValid(context)) { CSAutoAlert(page,@"账号或设置已变化，请返回自动功能页面重新编辑。当前草稿尚未保存。"); return NO; }
    if (CSAuthorizationManager.sharedManager.isAuthorized) return YES;
    if (CSSettingsCanPresentFrom(page)) {
        __weak UIViewController *weakPage=page;
        [CSAuthorizationManager.sharedManager requestAuthorizationWithPresentingViewController:page completion:^(BOOL success,NSString *message){
            if (!success) dispatch_async(dispatch_get_main_queue(),^{ CSAutoAlert(weakPage,message.length?message:@"请先完成授权，再使用自动功能。"); });
        }];
    }
    return NO;
}
static BOOL CSAutoTextValid(NSString *text, NSUInteger maximum) {
    return [text isKindOfClass:NSString.class] && text.length<=maximum && [text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length>0;
}
static NSString *CSAutoMatchTitle(NSString *match) {
    return [@{@"exact":@"全匹配",@"prefix":@"开头匹配",@"contains":@"模糊匹配"} objectForKey:match]?:@"全匹配";
}
static CSSettingItem *CSAutoRow(NSString *title,NSString *icon,NSString *detail,void (^action)(void)) {
    CSSettingItem *item=[CSSettingItem itemWithTitle:title iconName:icon iconColor:UIColor.systemBlueColor detail:detail];
    item.actionBlock=action; return item;
}

@interface CSAutomationSettingsCell : CSSettingTableViewCell @end
@implementation CSAutomationSettingsCell
+ (NSString *)reuseIdentifier { return @"CSAutomationSettingsCell"; }
- (void)configureWithItem:(CSSettingItem *)item {
    [super configureWithItem:item]; self.textLabel.numberOfLines=1; self.detailTextLabel.numberOfLines=1;
    self.textLabel.lineBreakMode=NSLineBreakByTruncatingTail; self.detailTextLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.textLabel.textColor=UIColor.labelColor; self.detailTextLabel.textColor=UIColor.secondaryLabelColor;
    self.contentView.alpha=1; self.userInteractionEnabled=YES;
    self.accessoryType=item.actionBlock?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    self.selectionStyle=item.actionBlock?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
}
- (void)layoutSubviews {
    [super layoutSubviews]; CGFloat leading=54,available=MAX(0,CGRectGetWidth(self.contentView.bounds)-leading-15),titleWidth=available;
    UISwitch *toggle=nil;for(UIView *view in self.contentView.subviews)if([view isKindOfClass:UISwitch.class])toggle=(UISwitch *)view;
    if(toggle)titleWidth=MAX(0,available-toggle.intrinsicContentSize.width-8);
    else if(self.detailTextLabel.text.length) {
        CGFloat desired=[self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width;
        CGFloat reserved=MIN(desired,MAX(0,(available-8)*0.58));
        CGFloat detailWidth=MIN([self.detailTextLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width,MAX(0,available-reserved-8));
        CGRect detail=self.detailTextLabel.frame;detail.origin.x=leading+available-detailWidth;detail.size.width=detailWidth;self.detailTextLabel.frame=detail;
        titleWidth=MAX(0,available-detailWidth-8);
    }
    CGRect title=self.textLabel.frame;title.origin.x=leading;title.size.width=titleWidth;self.textLabel.frame=title;
}
@end
static void CSAutoConfigureTable(UITableView *table) {
    table.backgroundColor=UIColor.systemGroupedBackgroundColor;table.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    table.rowHeight=UITableViewAutomaticDimension;table.estimatedRowHeight=52;
    [CSAutomationSettingsCell registerToTableView:table];
}
typedef void (^CSAutoCommit)(id value,void (^done)(BOOL success));

@interface CSAutomationTextEditor : UIViewController <UITextViewDelegate>
@property(nonatomic,copy) NSDictionary *context;
@property(nonatomic,copy) NSString *initialText;
@property(nonatomic) NSUInteger maximum;
@property(nonatomic,copy) CSAutoCommit commit;
@property(nonatomic) UITextView *editor;
@property(nonatomic) UILabel *counter;
@property(nonatomic) BOOL saving;
@end
@implementation CSAutomationTextEditor
- (BOOL)hidesBottomBarWhenPushed { return YES; }
- (void)viewDidLoad {
    [super viewDidLoad];self.view.backgroundColor=UIColor.systemGroupedBackgroundColor;self.navigationItem.largeTitleDisplayMode=UINavigationItemLargeTitleDisplayModeNever;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.editor=[UITextView new];self.editor.translatesAutoresizingMaskIntoConstraints=NO;self.editor.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.editor.adjustsFontForContentSizeCategory=YES;self.editor.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
    self.editor.textColor=UIColor.labelColor;self.editor.layer.cornerRadius=10;self.editor.textContainerInset=UIEdgeInsetsMake(12,10,12,10);
    self.editor.text=self.initialText?:@"";self.editor.delegate=self;self.editor.accessibilityLabel=self.title;
    self.counter=[UILabel new];self.counter.translatesAutoresizingMaskIntoConstraints=NO;self.counter.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    self.counter.numberOfLines=0;self.counter.textColor=UIColor.secondaryLabelColor;
    [self.view addSubview:self.editor];[self.view addSubview:self.counter];
    UILayoutGuide *safe=self.view.safeAreaLayoutGuide;
    NSLayoutConstraint *minimumHeight=[self.editor.heightAnchor constraintGreaterThanOrEqualToConstant:140];minimumHeight.priority=UILayoutPriorityDefaultLow;
    [NSLayoutConstraint activateConstraints:@[
        [self.editor.topAnchor constraintEqualToAnchor:safe.topAnchor constant:16], [self.editor.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor constant:16],
        [self.editor.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor constant:-16], minimumHeight,
        [self.editor.bottomAnchor constraintEqualToAnchor:self.counter.topAnchor constant:-10], [self.counter.leadingAnchor constraintEqualToAnchor:self.editor.leadingAnchor],
        [self.counter.trailingAnchor constraintEqualToAnchor:self.editor.trailingAnchor], [self.counter.bottomAnchor constraintEqualToAnchor:self.view.keyboardLayoutGuide.topAnchor constant:-12]
    ]];
    for(NSString *name in @[CSAutomationConfigurationDidChange,@"CSBackupAccountChanged"])[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [self updateState];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)changed:(NSNotification *)note { (void)note;dispatch_async(dispatch_get_main_queue(),^{[self updateState];}); }
- (void)textViewDidChange:(UITextView *)textView { (void)textView;[self updateState]; }
- (void)updateState {
    BOOL valid=CSAutoValid(self.context);
    self.counter.text=valid?[NSString stringWithFormat:@"%lu / %lu 字。支持多行；保存本段后返回上一级，完成列表保存后生效。",(unsigned long)self.editor.text.length,(unsigned long)self.maximum]:@"账号或设置已变化，请返回重新编辑。草稿未保存。";
    self.counter.textColor=self.editor.text.length>self.maximum?UIColor.systemRedColor:UIColor.secondaryLabelColor;
    self.navigationItem.rightBarButtonItem.enabled=valid && !self.saving && CSAutoTextValid(self.editor.text,self.maximum);
}
- (void)save {
    if(self.saving || !CSAutoRequire(self,self.context) || !CSAutoTextValid(self.editor.text,self.maximum))return;
    self.saving=YES;[self updateState];__weak typeof(self) weakSelf=self;
    self.commit(self.editor.text,^(BOOL success){dispatch_async(dispatch_get_main_queue(),^{typeof(self) page=weakSelf;if(!page)return;page.saving=NO;[page updateState];if(success && page.navigationController.topViewController==page)[page.navigationController popViewControllerAnimated:YES];});});
}
@end

@interface CSAutomationDraftList : CSSettingsTableViewController
@property(nonatomic,copy) NSDictionary *context;
@property(nonatomic,copy) CSAutoCommit commit;
@property(nonatomic) NSMutableArray *entries;
@property(nonatomic,copy) NSString *saveHint;
@property(nonatomic) BOOL saving;
- (void)addEntry;
- (void)editEntry:(NSUInteger)index;
- (NSString *)entryTitle:(id)entry index:(NSUInteger)index;
- (NSString *)entryDetail:(id)entry;
- (NSUInteger)maximumEntries;
- (BOOL)entriesValid;
- (NSString *)listHelp;
- (void)updateState;
@end
@implementation CSAutomationDraftList
- (void)viewDidLoad {
    [super viewDidLoad];CSAutoConfigureTable(self.tableView);
    self.navigationItem.rightBarButtonItems=@[
        [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)],
        [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditing)]
    ];
    for(NSString *name in @[CSAutomationConfigurationDidChange,@"CSBackupAccountChanged"])[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [self updateState];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated];[self updateState]; }
- (void)changed:(NSNotification *)note { (void)note;dispatch_async(dispatch_get_main_queue(),^{[self updateState];}); }
- (void)updateState {
    self.navigationItem.rightBarButtonItems[0].enabled=!self.saving && CSAutoValid(self.context) && [self entriesValid];
    self.navigationItem.rightBarButtonItems[1].enabled=!self.saving && CSAutoValid(self.context) && self.entries.count>0;
    [self.tableView reloadData];
}
- (void)toggleEditing { if(!CSAutoRequire(self,self.context)||self.saving)return;[self setEditing:!self.editing animated:YES];self.navigationItem.rightBarButtonItems[1].title=self.editing?@"完成":@"编辑"; }
- (void)save {
    if(self.saving||!CSAutoRequire(self,self.context)||![self entriesValid])return;
    self.saving=YES;[self updateState];__weak typeof(self) weakSelf=self;
    self.commit([self.entries copy],^(BOOL success){dispatch_async(dispatch_get_main_queue(),^{typeof(self) page=weakSelf;if(!page)return;page.saving=NO;[page updateState];if(success && page.navigationController.topViewController==page)[page.navigationController popViewControllerAnimated:YES];});});
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView;return 2; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView;return section==0?self.entries.count:1; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;if(section!=1)return nil;return CSAutoValid(self.context)?[self listHelp]:@"账号或设置已变化，请返回重新编辑。当前草稿未保存。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSAutomationSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSAutomationSettingsCell.reuseIdentifier forIndexPath:path];
    NSString *title=path.section==0?[self entryTitle:self.entries[path.row] index:path.row]:@"添加";
    CSSettingItem *item=CSAutoRow(title,path.section==0?@"text.bubble.fill":@"plus.circle.fill",path.section==0?[self entryDetail:self.entries[path.row]]:nil,^{ });
    [cell configureWithItem:item];
    BOOL enabled=!self.saving && CSAutoValid(self.context) && (path.section==0 || self.entries.count<[self maximumEntries]);
    cell.userInteractionEnabled=enabled;cell.contentView.alpha=enabled?1:0.45;return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];if(self.saving||!CSAutoRequire(self,self.context))return;
    if(path.section==0)[self editEntry:path.row];else if(self.entries.count<[self maximumEntries])[self addEntry];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)path { (void)tableView;return path.section==0 && !self.saving && CSAutoValid(self.context); }
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)path { return [self tableView:tableView canEditRowAtIndexPath:path]; }
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)style forRowAtIndexPath:(NSIndexPath *)path {
    (void)tableView;if(style==UITableViewCellEditingStyleDelete && !self.saving && CSAutoRequire(self,self.context)){[self.entries removeObjectAtIndex:path.row];[self updateState];}
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)source toProposedIndexPath:(NSIndexPath *)destination {
    (void)tableView;return destination.section==0?destination:[NSIndexPath indexPathForRow:MAX(0,(NSInteger)self.entries.count-1) inSection:source.section];
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)source toIndexPath:(NSIndexPath *)destination {
    (void)tableView;if(self.saving||!CSAutoValid(self.context)||source.section!=0||destination.section!=0){[self updateState];return;}
    id value=self.entries[source.row];[self.entries removeObjectAtIndex:source.row];[self.entries insertObject:value atIndex:destination.row];[self updateState];
}
- (void)addEntry {}
- (void)editEntry:(NSUInteger)index { (void)index; }
- (NSString *)entryTitle:(id)entry index:(NSUInteger)index { (void)index;return [entry description]; }
- (NSString *)entryDetail:(id)entry { (void)entry;return nil; }
- (NSUInteger)maximumEntries { return 100; }
- (BOOL)entriesValid { return YES; }
- (NSString *)listHelp { return @"编辑后可删除或拖动排序。点击保存后生效，返回不保存。"; }
@end

@interface CSAutomationContentList : CSAutomationDraftList @end
@implementation CSAutomationContentList
- (BOOL)entriesValid { if(self.entries.count>100)return NO;for(NSString *text in self.entries)if(!CSAutoTextValid(text,4000))return NO;return YES; }
- (NSString *)entryTitle:(id)entry index:(NSUInteger)index { (void)entry;return [NSString stringWithFormat:@"回复 %lu",(unsigned long)index+1]; }
- (NSString *)entryDetail:(id)entry { return [entry stringByReplacingOccurrencesOfString:@"\n" withString:@" "]; }
- (NSString *)listHelp { return [@"最多 100 条，每条 1–4000 字，支持多行。每次触发随机选一条；空列表不发送。编辑后可删除或拖动排序。" stringByAppendingString:self.saveHint?:@"点保存后整份内容生效，返回不保存。"]; }
- (void)addEntry { [self openText:NSNotFound]; }
- (void)editEntry:(NSUInteger)index { [self openText:index]; }
- (void)openText:(NSUInteger)index {
    CSAutomationTextEditor *editor=[CSAutomationTextEditor new];editor.context=self.context;editor.maximum=4000;editor.title=index==NSNotFound?@"添加回复":@"编辑回复";
    editor.initialText=index==NSNotFound?@"":self.entries[index];__weak typeof(self) weakSelf=self;
    editor.commit=^(NSString *text,void (^done)(BOOL)){typeof(self) page=weakSelf;if(!page||!CSAutoValid(page.context)){done(NO);return;}
        if(index==NSNotFound){if(page.entries.count>=100){done(NO);return;}[page.entries addObject:text];}else if(index<page.entries.count)page.entries[index]=text;else{done(NO);return;}
        [page updateState];done(YES);
    };[self.navigationController pushViewController:editor animated:YES];
}
@end

@interface CSAutomationRuleEditor : CSSettingsTableViewController
@property(nonatomic,copy) NSDictionary *context;
@property(nonatomic) NSMutableDictionary *rule;
@property(nonatomic,copy) CSAutoCommit commit;
@property(nonatomic) BOOL saving;
@property(nonatomic,copy) NSArray<CSSettingItem *> *rows;
@end
@implementation CSAutomationRuleEditor
- (void)viewDidLoad {
    [super viewDidLoad];CSAutoConfigureTable(self.tableView);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    for(NSString *name in @[CSAutomationConfigurationDidChange,@"CSBackupAccountChanged"])[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [self reloadRows];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated];[self reloadRows]; }
- (void)changed:(NSNotification *)note { (void)note;dispatch_async(dispatch_get_main_queue(),^{[self reloadRows];}); }
- (BOOL)ruleValid { return CSAutoTextValid(self.rule[@"keyword"],256) && [self.rule[@"contents"] count]>0; }
- (void)reloadRows {
    __weak typeof(self) weakSelf=self;
    self.rows=@[
        CSAutoRow(@"关键词",@"text.magnifyingglass",[self.rule[@"keyword"] length]?self.rule[@"keyword"]:@"请输入",^{[weakSelf editKeyword];}),
        CSAutoRow(@"匹配方式",@"line.3.horizontal.decrease.circle",CSAutoMatchTitle(self.rule[@"match"]),^{[weakSelf chooseMatch];}),
        CSAutoRow(@"回复内容",@"text.bubble.fill",[NSString stringWithFormat:@"%lu 条",(unsigned long)[self.rule[@"contents"] count]],^{[weakSelf editContents];})
    ];self.navigationItem.rightBarButtonItem.enabled=!self.saving && CSAutoValid(self.context) && [self ruleValid];[self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView;(void)section;return self.rows.count; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;(void)section;return CSAutoValid(self.context)?@"全匹配：消息全文相同。开头匹配：消息以关键词开头。模糊匹配：消息中包含关键词。每个关键词独立配置回复内容，触发时随机选择一条。保存本项后，需在关键词列表再次保存才会生效。":@"账号或设置已变化，请返回重新编辑。草稿未保存。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSAutomationSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSAutomationSettingsCell.reuseIdentifier forIndexPath:path];[cell configureWithItem:self.rows[path.row]];
    BOOL enabled=!self.saving && CSAutoValid(self.context);cell.userInteractionEnabled=enabled;cell.contentView.alpha=enabled?1:0.45;return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];if(!self.saving && CSAutoRequire(self,self.context)){CSSettingItem *item=self.rows[path.row];if(item.actionBlock)item.actionBlock();}
}
- (void)editKeyword {
    CSAutomationTextEditor *editor=[CSAutomationTextEditor new];editor.title=@"关键词";editor.context=self.context;editor.maximum=256;editor.initialText=self.rule[@"keyword"];
    __weak typeof(self) weakSelf=self;editor.commit=^(NSString *text,void (^done)(BOOL)){typeof(self) page=weakSelf;if(!page||!CSAutoValid(page.context)){done(NO);return;}page.rule[@"keyword"]=text;[page reloadRows];done(YES);};
    [self.navigationController pushViewController:editor animated:YES];
}
- (void)chooseMatch {
    if(!CSSettingsCanPresentFrom(self))return;
    UIAlertController *sheet=[UIAlertController alertControllerWithTitle:@"匹配方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf=self;
    for(NSString *match in @[@"exact",@"prefix",@"contains"])[sheet addAction:[UIAlertAction actionWithTitle:CSAutoMatchTitle(match) style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        typeof(self) page=weakSelf;if(page && CSAutoValid(page.context)){page.rule[@"match"]=match;[page reloadRows];}
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    sheet.popoverPresentationController.sourceView=self.view;sheet.popoverPresentationController.sourceRect=CGRectMake(CGRectGetMidX(self.view.bounds),100,1,1);
    [self presentViewController:sheet animated:YES completion:nil];
}
- (void)editContents {
    CSAutomationContentList *page=[[CSAutomationContentList alloc]initWithStyle:UITableViewStyleInsetGrouped];page.title=@"关键词回复内容";page.context=self.context;page.entries=[self.rule[@"contents"] mutableCopy]?:[NSMutableArray array];
    page.saveHint=@"此页保存仅更新关键词草稿，完成关键词和列表保存后生效。返回不保存。";
    __weak typeof(self) weakSelf=self;page.commit=^(NSArray *contents,void (^done)(BOOL)){typeof(self) owner=weakSelf;if(!owner||!CSAutoValid(owner.context)){done(NO);return;}owner.rule[@"contents"]=contents;[owner reloadRows];done(YES);};
    [self.navigationController pushViewController:page animated:YES];
}
- (void)save {
    if(self.saving||!CSAutoRequire(self,self.context)||![self ruleValid])return;
    self.saving=YES;[self reloadRows];__weak typeof(self) weakSelf=self;
    self.commit([self.rule copy],^(BOOL success){dispatch_async(dispatch_get_main_queue(),^{typeof(self) page=weakSelf;if(!page)return;page.saving=NO;[page reloadRows];if(success && page.navigationController.topViewController==page)[page.navigationController popViewControllerAnimated:YES];});});
}
@end

@interface CSAutomationKeywordList : CSAutomationDraftList @end
@implementation CSAutomationKeywordList
- (NSUInteger)maximumEntries { return 200; }
- (BOOL)entriesValid {
    if(self.entries.count>200)return NO;
    for(NSDictionary *rule in self.entries){if(!CSAutoTextValid(rule[@"keyword"],256)||![rule[@"contents"] count])return NO;}return YES;
}
- (NSString *)entryTitle:(id)entry index:(NSUInteger)index { (void)index;return entry[@"keyword"]; }
- (NSString *)entryDetail:(id)entry { return [NSString stringWithFormat:@"%@ · %lu 条",CSAutoMatchTitle(entry[@"match"]),(unsigned long)[entry[@"contents"] count]]; }
- (NSString *)listHelp { return @"最多 200 个关键词。编辑后可删除或拖动调整优先顺序；同一消息命中多个关键词时，只回复排在最前的一项。点保存后整份列表生效，返回不保存。"; }
- (void)addEntry { [self openRule:NSNotFound]; }
- (void)editEntry:(NSUInteger)index { [self openRule:index]; }
- (void)openRule:(NSUInteger)index {
    CSAutomationRuleEditor *editor=[[CSAutomationRuleEditor alloc]initWithStyle:UITableViewStyleInsetGrouped];editor.context=self.context;editor.title=index==NSNotFound?@"添加关键词":@"编辑关键词";
    editor.rule=index==NSNotFound?[@{@"id":NSUUID.UUID.UUIDString,@"keyword":@"",@"match":@"exact",@"contents":@[]} mutableCopy]:[self.entries[index] mutableCopy];
    __weak typeof(self) weakSelf=self;editor.commit=^(NSDictionary *rule,void (^done)(BOOL)){typeof(self) page=weakSelf;if(!page||!CSAutoValid(page.context)){done(NO);return;}
        if(index==NSNotFound){if(page.entries.count>=200){done(NO);return;}[page.entries addObject:rule];}else if(index<page.entries.count)page.entries[index]=rule;else{done(NO);return;}
        [page updateState];done(YES);
    };[self.navigationController pushViewController:editor animated:YES];
}
@end

@interface CSAutomationSettingsViewController ()
@property(nonatomic,copy) NSArray<CSSettingSection *> *sections;
@property(nonatomic) BOOL saving;
@property(nonatomic) CSAutomationNativeAdapter *nativeAdapter;
@end
@implementation CSAutomationSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];self.title=@"自动功能";CSAutoConfigureTable(self.tableView);
    self.nativeAdapter=[[CSAutomationNativeAdapter alloc]initWithEnvironment:[CSMessageNativeEnvironment new]];
    for(NSString *name in @[CSAutomationConfigurationDidChange,@"CSBackupAccountChanged"])[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:name object:nil];
    [CSAutomationManager.sharedManager start];[self reloadSettings];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated];[CSAutomationManager.sharedManager refresh];[self reloadSettings]; }
- (void)changed:(NSNotification *)note { (void)note;dispatch_async(dispatch_get_main_queue(),^{CSNativeContactPickerRevalidate(self);[self reloadSettings];}); }
- (void)saveModule:(NSString *)module changes:(NSDictionary *)changes context:(NSDictionary *)context completion:(void (^)(BOOL))completion {
    UIViewController *presenter=self.navigationController.topViewController?:self;
    if(self.saving || !CSAutoRequire(presenter,context)){if(completion)completion(NO);[self reloadSettings];return;}
    NSMutableDictionary *value=[CSAutomationManager.sharedManager.configuration[module] mutableCopy];[value addEntriesFromDictionary:changes];
    self.saving=YES;[self reloadSettings];__weak typeof(self) weakSelf=self;
    [CSAutomationManager.sharedManager updateConfiguration:@{module:value} completion:^(BOOL success,NSError *error){dispatch_async(dispatch_get_main_queue(),^{
        typeof(self) page=weakSelf;if(!page){if(completion)completion(NO);return;}page.saving=NO;[page reloadSettings];
        if(!success)CSAutoAlert(page.navigationController.topViewController?:page,error.localizedDescription?:@"设置未保存，请稍后重试。");if(completion)completion(success);
    });}];
}
- (CSSettingItem *)toggle:(NSString *)title icon:(NSString *)icon module:(NSString *)module key:(NSString *)key {
    NSDictionary *config=CSAutomationManager.sharedManager.configuration[module];__weak typeof(self) weakSelf=self;
    return [CSSettingItem switchItemWithTitle:title iconName:icon iconColor:UIColor.systemGreenColor switchValue:[config[key] boolValue] valueChangedBlock:^(BOOL on){
        typeof(self) page=weakSelf;if(!page)return;
        if([key isEqual:@"revoke"] && on){NSTimeInterval window=[page.nativeAdapter revokeWindow];if(!isfinite(window)||window<=1){CSAutoAlert(page,@"当前微信无法提供可用的拍一拍撤回时间，请稍后重试。");[page reloadSettings];return;}
            NSUInteger delay=[config[@"revokeDelay"] unsignedIntegerValue];if(delay>=window){CSAutoAlert(page,@"撤回延迟须小于微信当前允许的撤回时间，请先调整撤回延迟。");[page reloadSettings];return;}}
        [page saveModule:module changes:@{key:@(on)} context:CSAutoContext() completion:nil];
    }];
}
- (void)reloadSettings {
    NSDictionary *configuration=CSAutomationManager.sharedManager.configuration?:CSAutomationDefaultConfiguration();NSMutableArray *sections=[NSMutableArray array];__weak typeof(self) weakSelf=self;
    for(NSUInteger index=0;index<CSAutoModules().count;index++){
        NSString *module=CSAutoModules()[index];NSDictionary *config=configuration[module];
        NSMutableArray *rows=[NSMutableArray arrayWithObject:[self toggle:@"开启功能" icon:index==0?@"hand.tap.fill":@"text.bubble.fill" module:module key:@"enabled"]];
        if(![module isEqual:@"mentionReply"])[rows addObject:CSAutoRow(@"生效私聊",@"person.fill",[NSString stringWithFormat:@"已选 %lu 人",(unsigned long)[config[@"friends"] count]],^{[weakSelf chooseConversations:module groups:NO];})];
        [rows addObjectsFromArray:@[
            CSAutoRow(@"生效群聊",@"person.3.fill",[NSString stringWithFormat:@"已选 %lu 个群",(unsigned long)[config[@"groups"] count]],^{[weakSelf chooseConversations:module groups:YES];}),
            CSAutoRow(@"执行延迟",@"clock.fill",[NSString stringWithFormat:@"%@ 秒",config[@"delay"]?:@0],^{[weakSelf editDelay:module revoke:NO];})
        ]];
        if(index==0){
            [rows addObject:[self toggle:@"撤回自动回拍" icon:@"arrow.uturn.backward" module:module key:@"revoke"]];
            [rows addObject:CSAutoRow(@"撤回延迟",@"clock.arrow.circlepath",[NSString stringWithFormat:@"%@ 秒",config[@"revokeDelay"]?:@3],^{[weakSelf editDelay:module revoke:YES];})];
        }else if(index<3){
            [rows addObject:CSAutoRow(@"回复内容",@"text.alignleft",[NSString stringWithFormat:@"%lu 条",(unsigned long)[config[@"contents"] count]],^{[weakSelf editContents:module];})];
            [rows addObject:[self toggle:@"回复时 @ 对方" icon:@"at" module:module key:@"mention"]];
        }else{
            [rows addObject:[self toggle:@"引用原消息" icon:@"quote.bubble.fill" module:module key:@"quote"]];
            [rows addObject:[self toggle:@"回复自己的消息" icon:@"person.crop.circle" module:module key:@"own"]];
            [rows addObject:[self toggle:@"回复别人的消息" icon:@"person.2.fill" module:module key:@"others"]];
            [rows addObject:CSAutoRow(@"关键词列表",@"list.bullet",[NSString stringWithFormat:@"%lu 项",(unsigned long)[config[@"rules"] count]],^{[weakSelf editKeywords];})];
        }
        [sections addObject:[CSSettingSection sectionWithHeader:CSAutoTitles()[index] items:rows]];
    }
    self.sections=sections;[self.tableView reloadData];
}
- (BOOL)rowEnabled:(NSIndexPath *)path {
    if(self.saving || !CSAutoValid(CSAutoContext()))return NO;
    (void)path;return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView;return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView;return self.sections[section].items.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { (void)tableView;return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if(!CSAutomationManager.sharedManager.ready)return section==0?(CSAutomationManager.sharedManager.statusText.length?CSAutomationManager.sharedManager.statusText:@"当前账号尚未就绪，请稍后重试。"):nil;
    NSArray *details=@[@"仅处理拍到自己的新拍一拍。撤回只针对本功能本次自动发出的回拍，从微信确认发送成功后开始计时，并受微信允许的撤回时间限制。",
        @"每次从本模块的回复内容中随机选一条。@ 仅在群聊生效；私聊发送普通回复。名单和延迟与其他模块独立。",
        @"识别群聊中真正 @ 当前账号的消息。每次随机回复一条；同一条消息同时命中关键词时，优先执行本模块。",
        @"仅匹配文字消息，按关键词列表顺序采用第一条命中的规则。回复自己指在所选会话中回复本人发出的消息，自动功能产生的消息不会再次触发自身。"];
    NSString *boundary=[NSString stringWithFormat:@"设备首次解锁后，微信有后台执行机会且本功能存储、账号和授权可用时，锁屏也可处理，不要求本插件开启后台运行。条件暂不可用时保留等待；恢复可用或回前台后，未完成的任务在到期后 %.0f 分钟内补发一次，超过不补发。系统挂起或进程退出期间不能实时处理；撤回另受微信原生时间窗口限制。",CSAutomationLateAllowance/60.0];
    return [NSString stringWithFormat:@"%@\n\n%@",details[(NSUInteger)MIN(MAX(section,0),3)],boundary];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSAutomationSettingsCell *cell=[tableView dequeueReusableCellWithIdentifier:CSAutomationSettingsCell.reuseIdentifier forIndexPath:path];[cell configureWithItem:self.sections[path.section].items[path.row]];
    BOOL enabled=[self rowEnabled:path];cell.userInteractionEnabled=enabled;cell.contentView.alpha=enabled?1:0.45;return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];if(![self rowEnabled:path]||!CSAutoRequire(self,CSAutoContext()))return;
    CSSettingItem *item=self.sections[path.section].items[path.row];if(item.actionBlock)item.actionBlock();
}
- (void)chooseConversations:(NSString *)module groups:(BOOL)groups {
    if([module isEqual:@"mentionReply"] && !groups)return;
    NSDictionary *context=CSAutoContext();if(self.saving||!CSAutoRequire(self,context)||!CSSettingsCanPresentFrom(self))return;
    NSString *key=groups?@"groups":@"friends";NSArray *selected=CSAutomationManager.sharedManager.configuration[module][key];__weak typeof(self) weakSelf=self;NSError *error=nil;
    BOOL shown=CSNativeContactPickerPresent(self,groups?@"选择生效群聊":@"选择生效私聊",groups,selected?:@[],^BOOL{return weakSelf && !weakSelf.saving && CSAutoValid(context) && CSAuthorizationManager.sharedManager.isAuthorized;},^(NSArray<NSString *> *names){
        [weakSelf saveModule:module changes:@{key:names} context:context completion:nil];
    },&error);if(!shown)CSAutoAlert(self,error.localizedDescription?:@"当前无法打开微信原生选择器，原有名单已保留。");
}
- (void)editDelay:(NSString *)module revoke:(BOOL)revoke {
    NSDictionary *context=CSAutoContext();if(self.saving||!CSAutoRequire(self,context)||!CSSettingsCanPresentFrom(self))return;
    NSString *key=revoke?@"revokeDelay":@"delay";NSUInteger maximum=300;
    NSTimeInterval window=revoke?[self.nativeAdapter revokeWindow]:0;
    if(revoke){if(!isfinite(window)||window<=1){CSAutoAlert(self,@"当前微信无法提供可用的拍一拍撤回时间，请稍后重试。");return;}maximum=(NSUInteger)MIN(300,ceil(window)-1);}
    NSUInteger minimum=revoke?1:0;
    NSString *message=[NSString stringWithFormat:revoke?@"输入 %lu–%lu 的整数秒数，从本次回拍确认发送成功后计时。":@"输入 %lu–%lu 的整数秒数，0 表示立即执行。",(unsigned long)minimum,(unsigned long)maximum];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:revoke?@"撤回延迟":@"执行延迟" message:message preferredStyle:UIAlertControllerStyleAlert];__weak UIAlertController *weakAlert=alert;__weak typeof(self) weakSelf=self;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field){field.keyboardType=UIKeyboardTypeNumberPad;field.text=[CSAutomationManager.sharedManager.configuration[module][key] description];}];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        NSString *text=[weakAlert.textFields.firstObject.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        BOOL valid=text.length>0 && text.length<=3 && [text rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"].invertedSet].location==NSNotFound && text.integerValue>=(NSInteger)minimum && text.integerValue<=(NSInteger)maximum;
        CSSettingsAfterDismissingSheet(weakAlert,^{typeof(self) page=weakSelf;if(!page)return;if(!valid){CSAutoAlert(page,message);return;}
            if(revoke){NSTimeInterval latest=[page.nativeAdapter revokeWindow];if(!isfinite(latest)||latest<=text.integerValue){CSAutoAlert(page,@"微信允许的撤回时间已变化，请重新设置。");return;}}
            [page saveModule:module changes:@{key:@(text.integerValue)} context:context completion:nil];
        });
    }]];[self presentViewController:alert animated:YES completion:nil];
}
- (void)editContents:(NSString *)module {
    NSDictionary *context=CSAutoContext();if(self.saving||!CSAutoRequire(self,context))return;
    CSAutomationContentList *page=[[CSAutomationContentList alloc]initWithStyle:UITableViewStyleInsetGrouped];page.title=@"回复内容";page.context=context;page.entries=[CSAutomationManager.sharedManager.configuration[module][@"contents"] mutableCopy]?:[NSMutableArray array];
    __weak typeof(self) weakSelf=self;page.commit=^(NSArray *contents,void (^done)(BOOL)){[weakSelf saveModule:module changes:@{@"contents":contents} context:context completion:done];};
    [self.navigationController pushViewController:page animated:YES];
}
- (void)editKeywords {
    NSDictionary *context=CSAutoContext();if(self.saving||!CSAutoRequire(self,context))return;
    CSAutomationKeywordList *page=[[CSAutomationKeywordList alloc]initWithStyle:UITableViewStyleInsetGrouped];page.title=@"关键词列表";page.context=context;page.entries=[CSAutomationManager.sharedManager.configuration[@"keywordReply"][@"rules"] mutableCopy]?:[NSMutableArray array];
    __weak typeof(self) weakSelf=self;page.commit=^(NSArray *rules,void (^done)(BOOL)){[weakSelf saveModule:@"keywordReply" changes:@{@"rules":rules} context:context completion:done];};
    [self.navigationController pushViewController:page animated:YES];
}
@end
