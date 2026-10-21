// A deferred table render models the UIKit boundary that host Foundation cannot
// supply. Assertions exercise production lifecycle registrations and projections;
// they do not claim to reproduce CoreAnimation or prove the phone's pixel output.
@interface UIView : NSObject
@property(nonatomic) BOOL needsLayout;
@property(nonatomic) NSUInteger layouts,displays;
@property(nonatomic) double height;
@property(nonatomic,copy) void(^onLayout)(void);
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
- (void)setNeedsDisplay;
@end
@implementation UIView
- (void)setNeedsLayout {self.needsLayout=YES;}
- (void)layoutIfNeeded {if(self.needsLayout) {self.needsLayout=NO; self.layouts++; if(self.onLayout) self.onLayout();}}
- (void)setNeedsDisplay {self.displays++;}
@end
@interface UITableView : UIView
@property(nonatomic,strong) UIView *tableFooterView;
@property(nonatomic,copy) NSArray *paintedItems;
@property(nonatomic,copy) NSArray *(^readItems)(void);
@property(nonatomic) NSUInteger reloads;
@property(nonatomic) double contentOffset;
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData {self.reloads++; [self setNeedsLayout];}
- (void)layoutIfNeeded {
    BOOL pending=self.needsLayout;
    [super layoutIfNeeded];
    if(pending && self.readItems) self.paintedItems=self.readItems();
}
@end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,getter=isViewLoaded) BOOL viewLoaded;
@end
@implementation UIViewController @end
@interface WCTimeLineViewController : UIViewController
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) WCFacade *facade;
@property(nonatomic) NSUInteger nativeReloads,nativeWillAppear,nativeDidAppear,footerLayouts,scrolls;
- (void)reloadDataWrap;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidLayoutSubviews;
- (void)layoutTableFooterView;
- (void)onMessageUnReadCountChanged;
- (void)scrollViewDidScroll:(id)scroll;
@end
@implementation WCTimeLineViewController
- (instancetype)init {
    if((self=[super init])) {
        self.view=[UIView new]; self.view.height=844; self.viewLoaded=YES;
        self.tableView=[UITableView new]; self.tableView.tableFooterView=[UIView new];
        __weak WCTimeLineViewController *weakSelf=self;
        self.view.onLayout=^{[weakSelf viewDidLayoutSubviews];};
        self.tableView.readItems=^NSArray *{return [weakSelf.facade getTimelineDataItem];};
    } return self;
}
- (void)reloadDataWrap {self.nativeReloads++; [self.tableView reloadData];}
- (void)viewWillAppear:(__unused BOOL)animated {self.nativeWillAppear++;}
- (void)viewDidAppear:(__unused BOOL)animated {self.nativeDidAppear++;}
- (void)viewDidLayoutSubviews {self.tableView.height=self.view.height; [self layoutTableFooterView];}
- (void)layoutTableFooterView {self.footerLayouts++; self.tableView.tableFooterView.height=50;}
- (void)onMessageUnReadCountChanged {}
- (void)scrollViewDidScroll:(__unused id)scroll {self.scrolls++;}
@end
static void Policy(BOOL revealed,NSUInteger revision);
static int TestTimelineFirstLayout(void) {
#define LayoutCheck(x) do {if(!(x)){fprintf(stderr,"timeline first layout FAIL line %d: %s\n",__LINE__,#x);return 1;}}while(0)
    Policy(YES,200);
    WCDataItem *ordinary=[WCDataItem new];ordinary.username=@"alice";ordinary.itemID=@"layout-a";
    WCDataItem *secret=[WCDataItem new];secret.username=@"secret";secret.itemID=@"layout-s";
    WCFacade *facade=[WCFacade new];facade.source=@[ordinary,secret];
    NSArray *source=facade.source;
    WCTimeLineViewController *page=[WCTimeLineViewController new];page.facade=facade;
    UITableView *table=page.tableView; UIView *footer=table.tableFooterView;
    table.contentOffset=123;
    // Native reload alone leaves first-frame cells unpainted. The hooked
    // appearance must complete it without manufacturing a scroll callback.
    [table reloadData]; LayoutCheck(table.paintedItems==nil && table.height==0);
    [page viewWillAppear:YES];
    LayoutCheck([table.paintedItems isEqual:source] && table.height==844);
    LayoutCheck(page.nativeReloads==1 && table.contentOffset==123 && page.scrolls==0);
    [page viewDidAppear:YES];
    LayoutCheck(page.nativeWillAppear==1 && page.nativeDidAppear==1 && page.nativeReloads==1);
    LayoutCheck(table.tableFooterView==footer && footer.height==50 && footer.layouts>0);
    void(^refresh)(id)=[Refreshes objectForKey:page];LayoutCheck(refresh!=nil);
    Policy(NO,201);refresh(page);
    LayoutCheck([table.paintedItems isEqual:@[ordinary]] && facade.source==source && [facade getTimelineDataItem]==source);
    Policy(YES,202);refresh(page);
    LayoutCheck([table.paintedItems isEqual:source] && table.contentOffset==123 && page.scrolls==0);
    // Data arriving after initial appearance also uses the current scoped model.
    Policy(NO,203);facade.source=@[secret,ordinary,secret];
    [page reloadDataWrap];[page.view layoutIfNeeded];
    LayoutCheck([table.paintedItems isEqual:@[ordinary]] && facade.source.count==3);
    WCTimeLineViewController *unloaded=[WCTimeLineViewController new];unloaded.facade=facade;unloaded.viewLoaded=NO;
    [unloaded viewWillAppear:NO];LayoutCheck(unloaded.nativeReloads==0);
    unloaded.viewLoaded=YES;[unloaded viewWillAppear:NO];
    LayoutCheck(unloaded.nativeReloads==1 && [unloaded.tableView.paintedItems isEqual:@[ordinary]]);
    NSUInteger calls=page.nativeReloads,layouts=table.layouts;
    Epoch++;[page viewWillAppear:NO];[page viewDidAppear:NO];
    LayoutCheck(page.nativeReloads==calls && table.layouts==layouts);
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:NO revision:204 blocked:NO];
    WCTimeLineViewController *disabled=[WCTimeLineViewController new];
    [disabled viewWillAppear:NO];[disabled viewDidAppear:NO];
    LayoutCheck(disabled.nativeReloads==0 && disabled.tableView.layouts==0);
    puts("Timeline first layout: native appearance, immediate reveal/relock rendering, footer/offset preservation, async data refresh, unloaded/stale pages and disabled bypass passed");
#undef LayoutCheck
    return 0;
}
