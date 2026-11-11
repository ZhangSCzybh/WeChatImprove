from pathlib import Path
path=Path('Controllers/CSGroupChatSettingsViewController.m')
s=path.read_text()
start=s.index('@interface CSGroupChatTemplateEditor')
end=s.index('- (void)cancel {',start)
new=r'''// Only this editor adapts long action details; the settings home keeps its existing layout.
@interface CSGroupChatTemplateActionCell : CSGroupChatSettingsCell
- (CGFloat)heightForContentWidth:(CGFloat)width;
@end
@implementation CSGroupChatTemplateActionCell
- (BOOL)stacksLabelsForWidth:(CGFloat)width {
    return [self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width+
        [self.detailTextLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)].width+8>MAX(1,width-69);
}
- (CGFloat)heightForContentWidth:(CGFloat)width {
    CGFloat available=MAX(1,width-69);
    if (![self stacksLabelsForWidth:width]) return MAX(52,ceil(MAX(self.textLabel.font.lineHeight,self.detailTextLabel.font.lineHeight))+24);
    return ceil([self.textLabel sizeThatFits:CGSizeMake(available,CGFLOAT_MAX)].height+
        [self.detailTextLabel sizeThatFits:CGSizeMake(available,CGFLOAT_MAX)].height)+28;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=CGRectGetWidth(self.contentView.bounds),available=MAX(1,width-69);
    if (![self stacksLabelsForWidth:width]) return;
    CGFloat titleHeight=ceil([self.textLabel sizeThatFits:CGSizeMake(available,CGFLOAT_MAX)].height);
    CGFloat detailHeight=ceil([self.detailTextLabel sizeThatFits:CGSizeMake(available,CGFLOAT_MAX)].height);
    self.textLabel.frame=CGRectMake(54,12,available,titleHeight);
    self.detailTextLabel.frame=CGRectMake(54,16+titleHeight,available,detailHeight);
}
@end

@interface CSGroupChatTemplateEditor : CSSettingsTableViewController <UITextViewDelegate>
@property(nonatomic,copy) NSDictionary *context;
@property(nonatomic,copy) NSString *configurationKey;
@property(nonatomic,copy) NSString *initialText;
@property(nonatomic,copy) NSString *defaultText;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,weak) UILabel *counterLabel;
@property(nonatomic,strong) UILabel *previewLabel;
@property(nonatomic,weak) UILabel *stateLabel;
@property(nonatomic,copy) NSString *counterText;
@property(nonatomic,copy) NSString *stateText;
@property(nonatomic,copy) NSString *variableHelp;
@property(nonatomic,copy) NSArray<CSSettingSection *> *sections;
@property(nonatomic,strong) CSSettingTableViewCell *editorCell;
@property(nonatomic,strong) CSSettingTableViewCell *previewCell;
@property(nonatomic,copy) NSArray<CSGroupChatTemplateActionCell *> *actionCells;
@property(nonatomic,strong) NSLayoutConstraint *editorHeight;
@property(nonatomic) CGFloat measuredWidth;
@property(nonatomic) CGFloat previewHeight;
@property(nonatomic) CGRect keyboardScreenFrame;
@property(nonatomic) CGFloat keyboardInset;
@property(nonatomic) BOOL updatingHeights;
@property(nonatomic) BOOL saving;
@end
@implementation CSGroupChatTemplateEditor
- (BOOL)hidesBottomBarWhenPushed { return YES; }
- (void)viewDidLoad {
    [super viewDidLoad]; CSGCConfigureTable(self.tableView);
    self.tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeInteractive;
    // Exact heights prevent estimated offsets from moving the caret during a height update.
    self.tableView.estimatedRowHeight=0; self.tableView.estimatedSectionFooterHeight=0;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    UITextView *text=[UITextView new]; self.textView=text; text.delegate=self; text.text=self.initialText?:@"";
    text.accessibilityLabel=self.title; text.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; text.adjustsFontForContentSizeCategory=YES;
    text.textColor=UIColor.labelColor; text.backgroundColor=UIColor.clearColor;
    text.textContainerInset=UIEdgeInsetsMake(12,0,12,0); text.scrollEnabled=NO;
    text.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever; text.automaticallyAdjustsScrollIndicatorInsets=NO;
    // These two cells never enter the shared reuse pool: keep the live text view and selection attached.
    self.editorCell=[[CSSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [self.editorCell configureWithItem:CSGCRow(@"",@"text.alignleft",UIColor.systemBlueColor,nil,nil)];
    self.editorCell.selectionStyle=UITableViewCellSelectionStyleNone;
    text.translatesAutoresizingMaskIntoConstraints=NO; [self.editorCell.contentView addSubview:text];
    self.editorHeight=[text.heightAnchor constraintEqualToConstant:200];
    [NSLayoutConstraint activateConstraints:@[
        [text.leadingAnchor constraintEqualToAnchor:self.editorCell.contentView.leadingAnchor constant:54],
        [text.trailingAnchor constraintEqualToAnchor:self.editorCell.contentView.trailingAnchor constant:-15],
        [text.topAnchor constraintEqualToAnchor:self.editorCell.contentView.topAnchor],
        [text.bottomAnchor constraintEqualToAnchor:self.editorCell.contentView.bottomAnchor],self.editorHeight
    ]];
    self.previewCell=[[CSSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [self.previewCell configureWithItem:CSGCRow(@"",@"text.bubble",UIColor.systemGreenColor,nil,nil)];
    self.previewCell.selectionStyle=UITableViewCellSelectionStyleNone;
    self.previewLabel=[UILabel new]; self.previewLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.previewLabel.adjustsFontForContentSizeCategory=YES; self.previewLabel.numberOfLines=0; self.previewLabel.textColor=UIColor.labelColor;
    self.previewLabel.translatesAutoresizingMaskIntoConstraints=NO; [self.previewCell.contentView addSubview:self.previewLabel];
    [NSLayoutConstraint activateConstraints:@[
        [self.previewLabel.leadingAnchor constraintEqualToAnchor:self.previewCell.contentView.leadingAnchor constant:54],
        [self.previewLabel.trailingAnchor constraintEqualToAnchor:self.previewCell.contentView.trailingAnchor constant:-15],
        [self.previewLabel.topAnchor constraintEqualToAnchor:self.previewCell.contentView.topAnchor constant:12],
        [self.previewLabel.bottomAnchor constraintEqualToAnchor:self.previewCell.contentView.bottomAnchor constant:-12]
    ]];
    __weak typeof(self) weakSelf=self;
    self.sections=@[
        [CSSettingSection sectionWithHeader:@"文案内容" items:@[]],
        [CSSettingSection sectionWithHeader:@"快捷操作" items:@[
            CSGCRow(@"插入变量",@"textformat",UIColor.systemBlueColor,@"在光标处插入",^{ [weakSelf insertVariable]; }),
            CSGCRow(@"恢复默认",@"arrow.counterclockwise",UIColor.systemOrangeColor,@"使用默认文案",^{ [weakSelf restoreDefault]; })]],
        [CSSettingSection sectionWithHeader:@"预览" items:@[]]
    ];
    NSMutableArray *actions=[NSMutableArray array];
    for (CSSettingItem *item in self.sections[1].items) {
        CSGroupChatTemplateActionCell *cell=[[CSGroupChatTemplateActionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        [cell configureWithItem:item]; cell.textLabel.numberOfLines=0; cell.detailTextLabel.numberOfLines=0;
        cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping; cell.detailTextLabel.lineBreakMode=NSLineBreakByWordWrapping;
        cell.textLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; cell.textLabel.adjustsFontForContentSizeCategory=YES;
        cell.detailTextLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]; cell.detailTextLabel.adjustsFontForContentSizeCategory=YES;
        [actions addObject:cell];
    }
    self.actionCells=actions;
    if ([self.configurationKey isEqual:@"welcomeTemplate"])
        self.variableHelp=@"@昵称显示微信昵称并提醒新成员；@备注显示群内备注；@微信ID显示成员的微信账号标识。备注或 ID 缺失时留空。支持换行、标点和表情。";
    else if ([self.configurationKey isEqual:@"departureRoomTemplate"])
        self.variableHelp=@"消息会发到成员离开的群，群内成员可见。@昵称、@备注和@微信ID均为文字，ID 缺失时留空；@离群类型显示已确认的离群原因。";
    else
        self.variableHelp=@"此通知仅自己可见，点击昵称可查看成员资料。@备注显示群内备注；@微信ID显示成员的微信账号标识。备注或 ID 缺失时留空；@离群类型显示已确认的离群原因。";
    self.variableHelp=[self.variableHelp stringByAppendingString:@"\n@群昵称显示群聊名称；@群人数显示群成员人数；@时间显示当前时间。"];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(stateChanged:) name:CSGroupChatConfigurationDidChange object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(stateChanged:) name:@"CSBackupAccountChanged" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillHideNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(contentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    [self updatePreview]; [self stateChanged:nil];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView; return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { (void)tableView; return section==1?self.sections[section].items.count:1; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { (void)tableView; return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView; return section==0?self.counterText:(section==1?self.variableHelp:self.stateText);
}
- (CGFloat)footerHeightForText:(NSString *)text {
    CGFloat width=MAX(1,CGRectGetWidth(self.tableView.bounds)-self.tableView.layoutMargins.left-self.tableView.layoutMargins.right);
    return ceil([text boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
        attributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]} context:nil].size.height)+20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (section==0) return [self footerHeightForText:@"4,000 / 4,000"];
    if (section==1) return [self footerHeightForText:self.variableHelp];
    // Reserve both states so account invalidation changes only text, never the card positions.
    return MAX([self footerHeightForText:@"预览使用示例成员与群聊，不会发送消息。"],
        [self footerHeightForText:@"账号或设置已变化，请返回后重新编辑。当前内容尚未保存。"]);
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    (void)tableView; if (![view isKindOfClass:UITableViewHeaderFooterView.class]) return;
    UILabel *label=((UITableViewHeaderFooterView *)view).textLabel;
    label.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]; label.adjustsFontForContentSizeCategory=YES; label.numberOfLines=0;
    label.text=[self tableView:self.tableView titleForFooterInSection:section]; label.textColor=UIColor.secondaryLabelColor;
    if (section==0) { self.counterLabel=label; label.textColor=self.textView.text.length>4000?UIColor.systemRedColor:UIColor.secondaryLabelColor; }
    if (section==2) self.stateLabel=label;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    (void)tableView; return path.section==0?self.editorCell:(path.section==2?self.previewCell:self.actionCells[path.row]);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)path {
    if (path.section==0) return self.editorHeight.constant;
    if (path.section==2) return MAX(52,self.previewHeight);
    CGFloat width=MAX(1,CGRectGetWidth(tableView.bounds)-tableView.layoutMargins.left-tableView.layoutMargins.right-34);
    return [self.actionCells[path.row] heightForContentWidth:width];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
    if (path.section==1) { CSSettingItem *item=self.sections[1].items[path.row]; if (item.actionBlock) item.actionBlock(); }
}
- (void)stateChanged:(NSNotification *)note {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self stateChanged:note]; }); return; }
    BOOL valid=CSGCContextValid(self.context,YES);
    self.navigationItem.rightBarButtonItem.enabled=valid && !self.saving;
    self.navigationItem.rightBarButtonItem.title=self.saving?@"保存中…":@"保存";
    self.textView.editable=valid && !self.saving;
    self.stateText=valid || self.saving?@"预览使用示例成员与群聊，不会发送消息。":@"账号或设置已变化，请返回后重新编辑。当前内容尚未保存。";
    self.stateLabel.text=self.stateText;
}
- (void)textViewDidChange:(UITextView *)textView { (void)textView; [self updatePreview]; }
- (void)textViewDidChangeSelection:(UITextView *)textView { (void)textView; [self revealCaret]; }
- (void)updatePreview {
    NSString *text=self.textView.text?:@"";
    self.counterText=[NSString stringWithFormat:@"%lu / 4,000",(unsigned long)text.length];
    self.counterLabel.text=self.counterText;
    self.counterLabel.textColor=text.length>4000?UIColor.systemRedColor:UIColor.secondaryLabelColor;
    NSMutableDictionary *values=[@{@"@昵称":@"张三",@"@备注":@"三哥",@"@微信ID":@"wxid_zhangsan",@"@群昵称":@"读书群",@"@群人数":@"128",@"@时间":CSGroupChatDateText(NSDate.date)} mutableCopy];
    if ([self.configurationKey isEqual:@"welcomeTemplate"]) values[@"@昵称"]=@"@张三\u2005";
    else values[@"@离群类型"]=@"被移出";
    self.previewLabel.text=CSGroupChatRenderTemplate(text,values);
    [self updateContentHeights];
}
- (void)updateContentHeights {
    if (self.updatingHeights || !self.textView) return;
    CGFloat width=CGRectGetWidth(self.textView.bounds); if (width<=0) return;
    CGFloat minimum=[[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody] scaledValueForValue:200];
    CGFloat editor=ceil(MAX(minimum,[self.textView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)].height));
    CGFloat preview=ceil([self.previewLabel sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)].height)+24;
    if (fabs(editor-self.editorHeight.constant)<0.5 && fabs(preview-self.previewHeight)<0.5 && fabs(width-self.measuredWidth)<0.5) return;
    self.editorHeight.constant=editor; self.previewHeight=preview; self.measuredWidth=width;
    self.updatingHeights=YES;
    [UIView performWithoutAnimation:^{ [self.tableView beginUpdates]; [self.tableView endUpdates]; [self.tableView layoutIfNeeded]; }];
    self.updatingHeights=NO;
    [self revealCaret];
}
- (void)contentSizeChanged:(NSNotification *)note {
    (void)note; self.measuredWidth=0;
    self.textView.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; self.previewLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    for (CSGroupChatTemplateActionCell *cell in self.actionCells) {
        cell.textLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; cell.detailTextLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    }
    [self updateContentHeights];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews]; [self updateContentHeights]; [self updateKeyboardInset];
}
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange]; [self updateKeyboardInset];
}
- (CGRect)keyboardFrameInTable {
    UIWindow *window=self.view.window; if (!window || CGRectIsEmpty(self.keyboardScreenFrame)) return CGRectZero;
    CGRect frame=[window.screen.coordinateSpace convertRect:self.keyboardScreenFrame toCoordinateSpace:window];
    return [self.tableView convertRect:frame fromView:window];
}
- (void)keyboardChanged:(NSNotification *)note {
    self.keyboardScreenFrame=[note.name isEqual:UIKeyboardWillHideNotification]?CGRectZero:[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self updateKeyboardInset]; [self revealCaret];
}
- (void)updateKeyboardInset {
    if (!self.isViewLoaded) return;
    CGRect bounds=self.tableView.bounds,keyboard=[self keyboardFrameInTable];
    CGRect overlap=CGRectIntersection(bounds,keyboard);
    BOOL docked=!CGRectIsNull(overlap) && CGRectGetMaxY(keyboard)>=CGRectGetMaxY(bounds)-1 && CGRectGetWidth(overlap)>=CGRectGetWidth(bounds)-1;
    CGFloat inset=docked?MAX(0,CGRectGetHeight(overlap)-self.view.safeAreaInsets.bottom):0;
    CGFloat delta=inset-self.keyboardInset; if (fabs(delta)<0.5) return;
    self.keyboardInset=inset;
    // Own only the keyboard delta; CSSettingsTableViewController retains its safe-area contribution.
    UIEdgeInsets content=self.tableView.contentInset; content.bottom=MAX(0,content.bottom+delta); self.tableView.contentInset=content;
    UIEdgeInsets indicator=self.tableView.verticalScrollIndicatorInsets; indicator.bottom=MAX(0,indicator.bottom+delta); self.tableView.verticalScrollIndicatorInsets=indicator;
}
- (void)revealCaret {
    if (!self.textView.isFirstResponder || !self.textView.selectedTextRange) return;
    CGRect caret=[self.textView caretRectForPosition:self.textView.selectedTextRange.end];
    CGRect rect=[self.textView convertRect:CGRectInset(caret,-8,-12) toView:self.tableView];
    CGRect keyboard=[self keyboardFrameInTable];
    if (self.keyboardInset<0.5 && !CGRectIsEmpty(keyboard) && CGRectIntersectsRect(rect,keyboard)) {
        // Floating iPad keyboard: move only the covered caret above the actual keyboard.
        CGFloat target=self.tableView.contentOffset.y+CGRectGetMaxY(rect)-CGRectGetMinY(keyboard)+12;
        CGFloat maximum=MAX(-self.tableView.adjustedContentInset.top,self.tableView.contentSize.height-CGRectGetHeight(self.tableView.bounds)+self.tableView.adjustedContentInset.bottom);
        [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x,MIN(maximum,MAX(-self.tableView.adjustedContentInset.top,target))) animated:NO];
    } else [self.tableView scrollRectToVisible:rect animated:NO];
}
'''
s=s[:start]+new+s[end:]
old='    sheet.popoverPresentationController.sourceView=self.view; sheet.popoverPresentationController.sourceRect=CGRectMake(CGRectGetMidX(self.view.bounds),180,1,1);'
replacement='''    UIView *anchor=self.actionCells.firstObject;
    CGRect visible=UIEdgeInsetsInsetRect(self.tableView.bounds,self.tableView.adjustedContentInset);
    CGRect source=CGRectIntersection([anchor convertRect:anchor.bounds toView:self.view],visible);
    if (CGRectIsNull(source) || CGRectIsEmpty(source)) source=CGRectMake(CGRectGetMidX(visible),CGRectGetMidY(visible),1,1);
    sheet.popoverPresentationController.sourceView=self.view; sheet.popoverPresentationController.sourceRect=source;'''
assert old in s
s=s.replace(old,replacement)
s=s.replace('CSGroupChatTemplateEditor *editor=[CSGroupChatTemplateEditor new];','CSGroupChatTemplateEditor *editor=[[CSGroupChatTemplateEditor alloc] initWithStyle:UITableViewStyleInsetGrouped];')
path.write_text(s)
