#import "CSClientGuardSettingsViewController.h"
#import "CSClientGuard.h"

// This page owns its subtitle layout. Shared switch rows intentionally discard
// their detail text, so resource/restart states need a local cell instead.
@interface CSClientGuardOptionCell : UITableViewCell
@property(nonatomic,strong) UIImageView *guardIcon;
@property(nonatomic,strong) UILabel *guardTitle;
@property(nonatomic,strong) UILabel *guardDetail;
@property(nonatomic,strong) UISwitch *guardSwitch;
@property(nonatomic,copy) void (^valueChanged)(BOOL);
- (void)configureTitle:(NSString *)title detail:(NSString *)detail enabled:(BOOL)enabled
         experimental:(BOOL)experimental changed:(void (^)(BOOL))changed;
@end

@implementation CSClientGuardOptionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if((self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])){
        self.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.guardIcon=[UIImageView new];
        self.guardIcon.contentMode=UIViewContentModeCenter;
        self.guardIcon.isAccessibilityElement=NO;
        self.guardTitle=[UILabel new];
        self.guardTitle.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        self.guardTitle.adjustsFontForContentSizeCategory=YES;
        self.guardTitle.textColor=UIColor.labelColor;
        self.guardTitle.numberOfLines=0;
        self.guardDetail=[UILabel new];
        self.guardDetail.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        self.guardDetail.adjustsFontForContentSizeCategory=YES;
        self.guardDetail.textColor=UIColor.secondaryLabelColor;
        self.guardDetail.numberOfLines=0;
        self.guardSwitch=[UISwitch new];
        [self.guardSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [self.guardSwitch setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.guardSwitch setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        for(UIView *view in @[self.guardIcon,self.guardTitle,self.guardDetail,self.guardSwitch]){
            view.translatesAutoresizingMaskIntoConstraints=NO;
            [self.contentView addSubview:view];
        }
        [NSLayoutConstraint activateConstraints:@[
            [self.guardIcon.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
            [self.guardIcon.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [self.guardIcon.widthAnchor constraintEqualToConstant:29],
            [self.guardIcon.heightAnchor constraintEqualToConstant:29],
            [self.guardSwitch.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15],
            [self.guardSwitch.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [self.guardTitle.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:54],
            [self.guardTitle.trailingAnchor constraintEqualToAnchor:self.guardSwitch.leadingAnchor constant:-10],
            [self.guardTitle.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12],
            [self.guardDetail.leadingAnchor constraintEqualToAnchor:self.guardTitle.leadingAnchor],
            [self.guardDetail.trailingAnchor constraintEqualToAnchor:self.guardTitle.trailingAnchor],
            [self.guardDetail.topAnchor constraintEqualToAnchor:self.guardTitle.bottomAnchor constant:5],
            [self.guardDetail.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-12],
            [self.contentView.heightAnchor constraintGreaterThanOrEqualToConstant:70]
        ]];
    }
    return self;
}
- (void)configureTitle:(NSString *)title detail:(NSString *)detail enabled:(BOOL)enabled
         experimental:(BOOL)experimental changed:(void (^)(BOOL))changed {
    self.guardTitle.text=title;
    self.guardDetail.text=detail;
    self.guardSwitch.on=enabled;
    self.guardSwitch.accessibilityLabel=title;
    self.guardSwitch.accessibilityHint=detail;
    self.guardIcon.image=[UIImage systemImageNamed:experimental?@"slider.horizontal.3":@"shield.lefthalf.filled"];
    self.guardIcon.tintColor=experimental?UIColor.systemOrangeColor:UIColor.systemBlueColor;
    self.valueChanged=changed;
}
- (void)switchChanged:(UISwitch *)sender { if(self.valueChanged)self.valueChanged(sender.on); }
- (void)prepareForReuse {
    [super prepareForReuse];
    self.valueChanged=nil;
    self.guardTitle.text=nil;
    self.guardDetail.text=nil;
    self.guardSwitch.accessibilityLabel=nil;
    self.guardSwitch.accessibilityHint=nil;
}
@end

@interface CSClientGuardDiagnosticsViewController : UIViewController
@property(nonatomic,strong) UITextView *diagnosticText;
@end

@implementation CSClientGuardDiagnosticsViewController
- (instancetype)init {
    if((self=[super init])){
        // Establish the final boundary before the host's sheet push begins.
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.automaticallyAdjustsScrollViewInsets=NO;
#pragma clang diagnostic pop
        self.navigationItem.largeTitleDisplayMode=UINavigationItemLargeTitleDisplayModeNever;
        self.hidesBottomBarWhenPushed=YES;
        self.title=@"反检测诊断";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"刷新重检"
        style:UIBarButtonItemStylePlain target:self action:@selector(recheck)];
    UITextView *text=[UITextView new];
    self.diagnosticText=text;
    text.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    text.automaticallyAdjustsScrollIndicatorInsets=NO;
    text.translatesAutoresizingMaskIntoConstraints=NO;
    text.editable=NO;
    text.selectable=YES;
    text.backgroundColor=UIColor.systemGroupedBackgroundColor;
    text.textColor=UIColor.labelColor;
    text.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    text.adjustsFontForContentSizeCategory=YES;
    text.textContainerInset=UIEdgeInsetsMake(16,16,16,16);
    [self.view addSubview:text];
    [NSLayoutConstraint activateConstraints:@[
        [text.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [text.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [text.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [text.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
}
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; [self reloadSummary]; }
- (void)reloadSummary {
    CGPoint offset=self.diagnosticText.contentOffset;
    self.diagnosticText.text=CSClientGuardDiagnosticSummary();
    [self.diagnosticText layoutIfNeeded];
    CGFloat maximum=MAX(0,self.diagnosticText.contentSize.height-CGRectGetHeight(self.diagnosticText.bounds));
    offset.y=MIN(MAX(0,offset.y),maximum);
    [self.diagnosticText setContentOffset:offset animated:NO];
}
- (void)recheck {
    CSClientGuardRefresh();
    [self reloadSummary];
}
@end

@interface CSClientGuardSettingsViewController ()
@property(nonatomic, copy) NSArray<NSDictionary *> *sections;
@property(nonatomic) BOOL refreshPending;
@end

@implementation CSClientGuardSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"防封检测";
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    [self.tableView registerClass:CSClientGuardOptionCell.class forCellReuseIdentifier:@"CSClientGuardOptionCell"];
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=110;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"诊断"
        style:UIBarButtonItemStylePlain target:self action:@selector(showDiagnostics)];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(settingsChanged:)
        name:CSClientGuardChangedNotification object:nil];
    [self rebuildSections];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self rebuildSections];
    [self.tableView reloadData];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)settingsChanged:(NSNotification *)notification {
    (void)notification;
    // A change can be delivered synchronously while a switch is dispatching its action.
    // Rebuild after that action returns, rather than replacing its cell underneath it.
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.refreshPending)return;
        self.refreshPending=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.refreshPending=NO;
            if(!self.isViewLoaded || self.navigationController.topViewController!=self)return;
            [self rebuildSections];
            [self.tableView reloadData];
        });
    });
}
- (NSString *)detailForState:(NSDictionary *)state allStates:(NSDictionary<NSString *,NSDictionary *> *)allStates {
    NSMutableArray<NSString *> *status=[NSMutableArray array];
    if([state[@"experimental"] boolValue])[status addObject:@"实验"];
    if(![state[@"configured"] boolValue])[status addObject:@"已关闭"];
    else if(![state[@"published"] boolValue])[status addObject:@"已保存，策略未发布"];
    else if(![state[@"resourceReady"] boolValue])[status addObject:state[@"resourceStatus"]?:@"资源未就绪"];
    else [status addObject:state[@"installation"]?:@"等待接口检查"];
    if([state[@"scopedQuery"] boolValue])
        [status addObject:CSClientGuardSetting(CSClientGuardScopedKey)?@"限定同步检查范围":@"查询范围已扩大"];
    NSArray<NSString *> *dependencies=state[@"dependencies"];
    if(dependencies.count){
        BOOL paired=NO;
        for(NSString *identifier in dependencies)if([allStates[identifier][@"configured"] boolValue]){paired=YES;break;}
        [status addObject:paired?@"已有配套查询":@"需开启配套查询"];
    }
    if([state[@"restartPending"] boolValue])[status addObject:@"变更后需重新打开微信"];
    else if([state[@"restartRequired"] boolValue])[status addObject:@"启动时机需验证"];
    NSString *explanation=state[@"detail"]?:@"";
    NSString *stateText=[status componentsJoinedByString:@" · "];
    return explanation.length?[NSString stringWithFormat:@"%@\n%@",explanation,stateText]:stateText;
}
- (void)rebuildSections {
    NSArray<NSDictionary *> *states=[CSClientGuardCapabilityStates() sortedArrayUsingDescriptors:@[
        [NSSortDescriptor sortDescriptorWithKey:@"sectionOrder" ascending:YES],
        [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]
    ]];
    NSMutableDictionary<NSString *,NSDictionary *> *byIdentifier=[NSMutableDictionary dictionary];
    for(NSDictionary *state in states)byIdentifier[state[@"identifier"]]=state;
    NSMutableArray<NSDictionary *> *sections=[NSMutableArray arrayWithObject:@{
        @"header":@"总开关与范围",
        @"footer":@"总开关与各项能力默认关闭。“仅检查期间生效”只限定环境、资源与设备标识查询；本地风险、专用上报和证书能力在各自指定接口独立生效。诊断中的“刷新重检”会重新检查接口、资源及停用标记。",
        @"rows":@[
            @{@"title":@"启用防封检测",@"key":CSClientGuardEnabledKey,@"detail":@"开启已选择的能力；关闭后后续调用恢复原链路。",@"enabled":@(CSClientGuardSetting(CSClientGuardEnabledKey))},
            @{@"title":@"仅检查期间生效",@"key":CSClientGuardScopedKey,@"detail":@"仅限定环境、资源和设备标识查询；关闭后扩大这些查询的作用范围。",@"enabled":@(CSClientGuardSetting(CSClientGuardScopedKey))}
        ]
    }];
    NSMutableDictionary *group=nil;
    NSString *currentSection=nil;
    for(NSDictionary *state in states){
        NSString *section=state[@"section"]?:@"其他能力";
        if(![section isEqualToString:currentSection]){
            currentSection=section;
            group=[@{@"header":section,@"rows":[NSMutableArray array]} mutableCopy];
            [sections addObject:group];
        }
        NSDictionary *row=@{
            @"title":state[@"title"],
            @"key":CSClientGuardPreferenceKey(state[@"identifier"]),
            @"detail":[self detailForState:state allStates:byIdentifier],
            @"enabled":state[@"configured"],
            @"experimental":state[@"experimental"]
        };
        [group[@"rows"] addObject:row];
    }
    self.sections=[sections copy];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { (void)tableView;return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;return [self.sections[section][@"rows"] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;return self.sections[section][@"header"];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    return self.sections[section][@"footer"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSClientGuardOptionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CSClientGuardOptionCell" forIndexPath:path];
    NSDictionary *row=self.sections[path.section][@"rows"][path.row];
    NSString *key=row[@"key"];
    [cell configureTitle:row[@"title"] detail:row[@"detail"] enabled:[row[@"enabled"] boolValue]
        experimental:[row[@"experimental"] boolValue] changed:^(BOOL enabled){CSClientGuardSetSetting(key,enabled);}];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
}
- (void)showDiagnostics {
    [self.navigationController pushViewController:[CSClientGuardDiagnosticsViewController new] animated:YES];
}
@end
