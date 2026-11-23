// Reuse the minimal setting declarations and real production presentation model.
#define main SettingsModelFixtureMain
#include "SettingsHomeModelTests.m"
#undef main
#import "CSUserInfoHelper.h"

typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
enum { UIViewAnimationOptionBeginFromCurrentState=1, UIViewAnimationOptionAllowUserInteraction=2,
       UIViewAnimationOptionCurveEaseOut=4 };
enum { UITableViewStyleInsetGrouped=2, UITableViewRowAnimationNone=5 };
typedef NS_ENUM(NSUInteger, CSSettingItemType) { CSSettingItemTypeNormal, CSSettingItemTypeInput };

// The production selection method reads the shared item's native data API.
// This suite exercises normal navigation; input UI remains an uncalled fixture.
@interface CSSettingItem (SelectionFixture)
@property(nonatomic, readonly) CSSettingItemType itemType;
@property(nonatomic, copy) NSString *inputValue;
@property(nonatomic, readonly) NSString *inputPlaceholder;
@property(nonatomic, readonly) void (^inputValueChanged)(NSString *value);
@end
@implementation CSSettingItem (SelectionFixture)
- (CSSettingItemType)itemType { return CSSettingItemTypeNormal; }
- (NSString *)inputValue { return nil; }
- (void)setInputValue:(NSString *)value {}
- (NSString *)inputPlaceholder { return nil; }
- (void (^)(NSString *))inputValueChanged { return nil; }
@end

@interface NSIndexPath (TableFixture)
@property(nonatomic, readonly) NSUInteger section,row;
+ (instancetype)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section;
@end
@implementation NSIndexPath (TableFixture)
+ (instancetype)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section {
    NSUInteger indexes[]={section,row}; return [self indexPathWithIndexes:indexes length:2];
}
- (NSUInteger)section { return [self indexAtPosition:0]; }
- (NSUInteger)row { return [self indexAtPosition:1]; }
@end

@interface HomeFixtureRouteController : NSObject
@property(nonatomic) NSUInteger style;
- (instancetype)initWithStyle:(NSUInteger)style;
@end
@implementation HomeFixtureRouteController
- (instancetype)initWithStyle:(NSUInteger)style { if ((self=[super init])) _style=style; return self; }
@end
#include "SettingsHomeRouteControllers.h"
@interface HomeFixtureNavigationController : NSObject
@property(nonatomic, strong) HomeFixtureRouteController *lastPushed;
@property(nonatomic) NSUInteger pushes;
@property(nonatomic) BOOL animated;
- (void)pushViewController:(HomeFixtureRouteController *)controller animated:(BOOL)animated;
@end
@implementation HomeFixtureNavigationController
- (void)pushViewController:(HomeFixtureRouteController *)controller animated:(BOOL)animated {
    self.lastPushed=controller; self.pushes++; self.animated=animated;
}
@end
@interface CSUIHelper : NSObject
+ (void)showInputAlertWithTitle:(NSString *)title message:(NSString *)message initialValue:(NSString *)value
                   placeholder:(NSString *)placeholder inViewController:(id)controller completion:(void (^)(NSString *))completion;
@end
@implementation CSUIHelper
+ (void)showInputAlertWithTitle:(NSString *)title message:(NSString *)message initialValue:(NSString *)value
                   placeholder:(NSString *)placeholder inViewController:(id)controller completion:(void (^)(NSString *))completion {}
@end

@interface HomeFixtureLayer : NSObject
@property(nonatomic) NSUInteger resets;
- (void)removeAllAnimations;
@end
@implementation HomeFixtureLayer
- (void)removeAllAnimations { self.resets++; }
@end
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic) BOOL hidden;
@property(nonatomic, strong) HomeFixtureLayer *layer;
@property(nonatomic, weak) UIView *superview;
@property(nonatomic) NSUInteger requestedLayouts,completedLayouts;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
+ (void)performWithoutAnimation:(void (^)(void))actions;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options
                animations:(void (^)(void))actions completion:(void (^)(BOOL))completion;
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) { _layer=[HomeFixtureLayer new]; _alpha=1; _transform=CGAffineTransformIdentity; } return self; }
- (void)setFrame:(CGRect)frame { _frame=frame; _bounds=(CGRect){CGPointZero,frame.size}; }
- (void)setNeedsLayout { self.requestedLayouts++; }
- (void)layoutIfNeeded { self.completedLayouts++; }
+ (void)performWithoutAnimation:(void (^)(void))actions { actions(); }
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options
                animations:(void (^)(void))actions completion:(void (^)(BOOL))completion { actions(); if (completion) completion(YES); }
@end
@interface UILabel : UIView @end
@implementation UILabel @end
@interface UITableViewCell : NSObject
@property(nonatomic,strong) UIView *contentView;
@end
@implementation UITableViewCell
- (instancetype)init { if ((self=[super init])) _contentView=[UIView new]; return self; }
@end
@interface UITableView : UIView
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) UIEdgeInsets adjustedContentInset,layoutMargins,safeAreaInsets;
@property(nonatomic, strong) UIView *tableHeaderView,*tableFooterView;
@property(nonatomic, copy) NSArray<UITableViewCell *> *visibleCells;
@property(nonatomic, copy) NSArray<CSSettingSection *> *(^sectionsProvider)(void);
@property(nonatomic) NSUInteger reloads,deselections;
- (void)reloadData;
- (void)layoutIfNeeded;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(NSUInteger)animation;
@end
@implementation UITableView
- (void)reloadData { self.reloads++; [self layoutIfNeeded]; }
- (void)layoutIfNeeded {
    NSArray *sections=self.sectionsProvider ? self.sectionsProvider() : @[];
    CGFloat height=CGRectGetHeight(self.tableHeaderView.frame)+CGRectGetHeight(self.tableFooterView.frame);
    for (CSSettingSection *section in sections) height+=38+section.items.count*56+12;
    self.contentSize=CGSizeMake(CGRectGetWidth(self.bounds),height);
}
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated { self.contentOffset=offset; }
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated { self.deselections++; }
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(NSUInteger)animation {}
- (void)setTableHeaderView:(UIView *)view { _tableHeaderView=view; [self layoutIfNeeded]; }
- (void)setTableFooterView:(UIView *)view { _tableFooterView=view; [self layoutIfNeeded]; }
@end
@interface CSSettingsTabBar : UIView
@property(nonatomic) NSUInteger selectedIndex,resets;
@property(nonatomic) CGFloat horizontalInset;
- (void)resetSearch;
- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)reloadTheme;
@end
@implementation CSSettingsTabBar
- (void)resetSearch { self.resets++; }
- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated { self.selectedIndex=index; }
- (void)reloadTheme {}
@end
@interface CSSettingsHomeAnimator : NSObject
@property(nonatomic) NSUInteger transitions,cancellations;
- (void)cancel;
- (void)transitionTable:(UITableView *)table belowView:(UIView *)rail updates:(void (^)(void))updates;
@end
@implementation CSSettingsHomeAnimator
- (void)cancel { self.cancellations++; }
- (void)transitionTable:(UITableView *)table belowView:(UIView *)rail updates:(void (^)(void))updates {
    self.transitions++; updates();
}
@end
@interface CSPluginHeaderView : UIView
@property(nonatomic) CGFloat measuredHeight,horizontalInset;
@property(nonatomic) NSUInteger themeReloads;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
- (void)reloadTheme;
@end
@implementation CSPluginHeaderView
- (CGFloat)preferredHeightForWidth:(CGFloat)width { return self.measuredHeight; }
- (void)reloadTheme { self.themeReloads++; }
@end
@interface UIColor : NSObject
+ (instancetype)systemBlueColor; + (instancetype)systemYellowColor; + (instancetype)systemGreenColor;
+ (instancetype)systemOrangeColor; + (instancetype)systemTealColor; + (instancetype)systemIndigoColor;
+ (instancetype)systemRedColor; + (instancetype)systemPinkColor; + (instancetype)systemCyanColor;
+ (instancetype)systemPurpleColor; + (instancetype)systemBrownColor;
@end
@implementation UIColor
+ (instancetype)systemBlueColor { return nil; } + (instancetype)systemYellowColor { return nil; }
+ (instancetype)systemGreenColor { return nil; } + (instancetype)systemOrangeColor { return nil; }
+ (instancetype)systemTealColor { return nil; } + (instancetype)systemIndigoColor { return nil; }
+ (instancetype)systemRedColor { return nil; } + (instancetype)systemPinkColor { return nil; }
+ (instancetype)systemCyanColor { return nil; } + (instancetype)systemPurpleColor { return nil; }
+ (instancetype)systemBrownColor { return nil; }
@end
@interface CSSettingItem (NativeFactory)
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)name iconColor:(UIColor *)color detail:(NSString *)detail;
@end
@implementation CSSettingItem (NativeFactory)
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)name iconColor:(UIColor *)color detail:(NSString *)detail {
    CSSettingItem *item=Item(title); item.detail=detail; return item;
}
@end
static NSString *account=@"account-a";
static NSUInteger accountEpoch=42;
static BOOL storageReady=YES, accountSuspended;
static BOOL CSBackupIsReady(void) { return storageReady; }
static BOOL CSBackupAccountIsSuspended(void) { return accountSuspended; }
static NSUInteger CSBackupAccountEpoch(void) { return accountEpoch; }
@implementation CSUserInfoHelper
+ (NSString *)getUserWXID { return account; }
+ (NSString *)getUserNickname { return @"fixture"; }
+ (NSString *)getUserAliasName { return @"fixture"; }
+ (NSString *)getUserAvatarURL { return nil; }
+ (NSString *)getCurrentTimeString { return @"fixture"; }
@end
@interface CSCloseFriendManager : NSObject
@property(nonatomic) BOOL visible;
@property(nonatomic) NSUInteger presentations;
+ (instancetype)sharedManager;
- (BOOL)settingsEntryVisible;
- (void)presentSettingsFrom:(id)controller;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager { static CSCloseFriendManager *manager; if (!manager) manager=[self new]; return manager; }
- (BOOL)settingsEntryVisible { return self.visible; }
- (void)presentSettingsFrom:(id)controller { self.presentations++; }
@end

@interface CSCustomViewController : NSObject
@property(nonatomic,strong) HomeFixtureNavigationController *navigationController;
@property(nonatomic,copy) NSString *otherSettingsReturnScope;
@property(nonatomic) NSUInteger authorPresentations;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray<CSSettingSection *> *sections;
@property(nonatomic,strong) CSSettingsHomeModel *homeModel;
@property(nonatomic,strong) NSHashTable<UIView *> *homeSectionHeaders;
@property(nonatomic,strong) CSSettingsTabBar *settingsTabBar;
@property(nonatomic,strong) UIView *headerContainer,*homeFooter;
@property(nonatomic,strong) UILabel *emptySearchLabel;
@property(nonatomic,strong) NSMutableDictionary<NSNumber *,NSNumber *> *tabScrollDistances;
@property(nonatomic,strong) NSNumber *pendingHomeDistance;
@property(nonatomic) CGFloat laidOutProfileHeight;
@property(nonatomic) BOOL updatingHomeLayout,closeFriendEntryVisible;
@property(nonatomic) BOOL suppressHomeTransition;
@property(nonatomic,strong) CSSettingsHomeAnimator *homeAnimator;
@property(nonatomic,strong) CSPluginHeaderView *headerView;
- (void)setupData;
- (CGFloat)currentHomeDistance;
- (void)setHomeDistance:(CGFloat)distance;
- (void)positionSettingsTabBar;
- (void)updateHomeFooter;
- (void)reloadSettingsKeepingPosition;
- (void)reloadHomeAtDistance:(CGFloat)distance animated:(BOOL)animated;
- (void)selectHomeTab:(NSUInteger)index;
- (void)revealHomeAccountSection;
- (void)openHomeSearch;
- (void)updateHomeSearch:(NSString *)query;
- (void)closeHomeSearch;
- (void)updateHeaderLayout;
- (NSString *)currentOtherSettingsScope;
- (void)supportAuthor;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@implementation CSCustomViewController
- (NSString *)currentOtherSettingsScope { return account; }
- (void)supportAuthor { self.authorPresentations++; }
#include "SettingsHomeControllerUnderTest.h"
@end

static CSCustomViewController *Controller(void) {
    CSCustomViewController *controller=[CSCustomViewController new];
    controller.navigationController=[HomeFixtureNavigationController new];
    controller.tableView=[UITableView new];
    controller.tableView.frame=CGRectMake(0,0,390,844);
    controller.tableView.adjustedContentInset=(UIEdgeInsets){88,0,34,0};
    controller.tableView.contentOffset=CGPointMake(0,-88);
    controller.tableView.visibleCells=@[[UITableViewCell new],[UITableViewCell new]];
    __weak CSCustomViewController *weakController=controller;
    controller.tableView.sectionsProvider=^{ return weakController.sections; };
    controller.headerView=[CSPluginHeaderView new]; controller.headerView.measuredHeight=216;
    controller.headerContainer=[UIView new]; controller.homeFooter=[UIView new];
    controller.emptySearchLabel=[UILabel new]; controller.settingsTabBar=[CSSettingsTabBar new];
    controller.homeAnimator=[CSSettingsHomeAnimator new];
    controller.tableView.tableFooterView=controller.homeFooter;
    [controller setupData]; [controller updateHeaderLayout]; [controller reloadSettingsKeepingPosition];
    return controller;
}
static void TestController(void) {
    CSCustomViewController *controller=Controller();
    Check(controller.headerView.themeReloads>0,@"initial homepage reload synchronizes the quote icon with the current theme");
    NSUInteger themeReloads=controller.headerView.themeReloads;
    [controller reloadSettingsKeepingPosition];
    Check(controller.headerView.themeReloads==themeReloads+1,@"existing settings and theme refresh path forwards exactly one theme reload to the header");
    Check(controller.sections.count==2 && controller.sections[0].items.count==3,@"real source initially renders the account Tab with conditional entry hidden");
    Check([controller.sections.lastObject.header isEqual:@"关于"] && controller.sections.lastObject.items.count==2,@"real source includes version and support at the bottom");
    Check(Near(controller.settingsTabBar.frame.origin.y,88+216),@"real controller initially positions the rail immediately below its measured header");
    Check(Near(controller.tableView.tableHeaderView.frame.size.height,216+76),@"the table reserves exactly one shared Tab/search row");
    Check(Near(controller.headerView.horizontalInset,controller.settingsTabBar.horizontalInset),@"rail and profile share their computed horizontal insets");
    [controller setHomeDistance:100]; [controller selectHomeTab:1];
    Check(controller.homeModel.selectedIndex==1 && [controller.sections.firstObject.header isEqual:@"界面定制"],@"Tab selection displays the real selected category");
    Check(controller.sections.firstObject.items.count==16,@"all existing interface navigation entries remain present");
    Check(Near(controller.tabScrollDistances[@0].doubleValue,100),@"leaving a Tab records its scroll distance");
    Check(Near([controller currentHomeDistance],100),@"a new Tab preserves an already visible profile position");
    [controller setHomeDistance:430]; [controller selectHomeTab:3];
    Check(controller.sections.firstObject.items.count==6 && Near([controller currentHomeDistance],216),@"settings retains the inline palette and other settings while preserving a pinned rail when switching from a deep list");
    Check([controller.sections.firstObject.items.firstObject.title isEqual:@"界面调色"],@"the palette is the first Settings item and is part of the real searchable registry");
    Check(Near(controller.settingsTabBar.frame.origin.y,88),@"the short Tab retains a legal pinned position below navigation");
    [controller selectHomeTab:1];
    Check(Near([controller currentHomeDistance],430),@"returning to a visited Tab restores that Tab's prior scroll position");
    [controller openHomeSearch];
    Check(controller.homeModel.searching && controller.sections.count==5,@"opening search indexes the real five visible categories");
    Check(Near([controller currentHomeDistance],430) && Near(controller.settingsTabBar.frame.origin.y,88),@"opening search preserves an already pinned rail and the current legal scroll position");
    [controller updateHomeSearch:@"版本信息"];
    Check(controller.sections.count==1 && [controller.sections.firstObject.header isEqual:@"关于"],@"search locates the shared About entry across Tabs");
    [controller setupData]; [controller reloadSettingsKeepingPosition];
    Check(controller.homeModel.selectedIndex==1 && controller.homeModel.searching && [controller.homeModel.query isEqual:@"版本信息"],@"a normal source rebuild retains Tab and active query");
    [controller closeHomeSearch];
    Check(!controller.homeModel.searching && controller.homeModel.query.length==0 && controller.homeModel.selectedIndex==1,@"cancel search restores the prior Tab and clears only search state");
    Check(Near([controller currentHomeDistance],430),@"cancel search restores the Tab's pre-search scroll distance");
    CSCloseFriendManager.sharedManager.visible=YES;
    [controller openHomeSearch]; [controller updateHomeSearch:@"捉迷藏呀"];
    Check(controller.sections.count==1 && controller.sections.firstObject.items.count==1,@"real source exposes a conditional navigation entry only while its policy allows it");
    CSCloseFriendManager.sharedManager.visible=NO;
    [controller updateHomeSearch:@"捉迷藏呀"];
    Check(controller.sections.count==0 && !controller.emptySearchLabel.hidden,@"real source rebuild removes a newly hidden entry and displays the empty state");
    [controller closeHomeSearch]; [controller setHomeDistance:300];
    [controller openHomeSearch];
    accountEpoch++;
    [controller updateHomeSearch:@"头像"];
    Check(controller.homeModel.selectedIndex==0 && !controller.homeModel.searching && controller.homeModel.query.length==0,@"a new account epoch during typing discards the old search and selection");
    Check(Near([controller currentHomeDistance],0) && controller.tabScrollDistances.count==0,@"account reset clears saved positions and restores the natural top");
    Check(controller.settingsTabBar.resets>0 && controller.settingsTabBar.selectedIndex==0,@"account reset restores the rail alongside model state");
    [controller selectHomeTab:2]; [controller setHomeDistance:300];
    account=@"account-b";
    [controller openHomeSearch];
    Check(!controller.homeModel.searching && controller.homeModel.selectedIndex==0 && Near([controller currentHomeDistance],0),@"an account change detected while opening search aborts the pending search and resets safely");
    [controller selectHomeTab:1]; [controller setHomeDistance:350];
    CSCloseFriendManager.sharedManager.visible=YES;
    [controller revealHomeAccountSection];
    Check(controller.homeModel.selectedIndex==0 && controller.settingsTabBar.selectedIndex==0,@"successful discovery exposes the account group even when initiated from another Tab");
    Check(controller.sections.firstObject.items.count==4 && [controller.sections.firstObject.items.lastObject.title isEqual:@"捉迷藏呀"],@"discovery renders the newly permitted entry from the real source registry");
    Check(Near([controller currentHomeDistance],0) && Near(controller.tabScrollDistances[@1].doubleValue,350),@"discovery scrolls to the revealed account group while preserving the prior Tab's distance");
    [controller selectHomeTab:2]; [controller setHomeDistance:320];
    [controller openHomeSearch]; [controller updateHomeSearch:@"头像"];
    [controller revealHomeAccountSection];
    Check(!controller.homeModel.searching && controller.homeModel.query.length==0 && controller.homeModel.selectedIndex==0,@"successful discovery dismisses an active search before showing the account group");
    Check(Near(controller.tabScrollDistances[@2].doubleValue,320) && Near([controller currentHomeDistance],0),@"discovery during search preserves the Tab's pre-search distance rather than overwriting it with search position");
    [controller selectHomeTab:1]; [controller setHomeDistance:350];
    [controller selectHomeTab:2]; [controller setHomeDistance:320];
    controller.pendingHomeDistance=@340;
    controller.headerView.measuredHeight=230;
    [controller updateHeaderLayout];
    Check(Near(controller.laidOutProfileHeight,230) && Near([controller currentHomeDistance],334),@"async two-line verse growth preserves the live list position below the header");
    Check(Near(controller.tabScrollDistances[@1].doubleValue,364) && Near(controller.pendingHomeDistance.doubleValue,354),@"async header growth adjusts saved and pending distances together");
    Check(Near(controller.settingsTabBar.frame.origin.y,88),@"real rail remains pinned while async header growth changes table geometry");
    [controller reloadSettingsKeepingPosition];
    Check(!controller.pendingHomeDistance && Near([controller currentHomeDistance],354),@"a pending restore consumes the corrected distance exactly once");
    controller.headerView.measuredHeight=216;
    [controller updateHeaderLayout];
    Check(Near([controller currentHomeDistance],340) && Near(controller.tabScrollDistances[@1].doubleValue,350),@"header shrink preserves the same live and per-Tab content anchors");
    [controller setHomeDistance:50];
    controller.headerView.measuredHeight=230; [controller updateHeaderLayout];
    Check(Near([controller currentHomeDistance],50),@"header reflow while browsing the profile preserves natural distance");
    controller.tableView.contentOffset=CGPointMake(0,-118); [controller positionSettingsTabBar];
    Check(Near(controller.settingsTabBar.frame.origin.y,88+230+30),@"the actual rail follows pull-down overscroll with the profile instead of overlapping it");
    [controller setHomeDistance:0];
    NSUInteger transitions=controller.homeAnimator.transitions;
    for (NSUInteger index=0; index<4; index++) {
        [controller selectHomeTab:index];
        for (UITableViewCell *cell in controller.tableView.visibleCells)
            Check(cell.contentView.alpha==1 && CGAffineTransformIsIdentity(cell.contentView.transform),
                  @"group transitions leave the real reusable row content opaque and untransformed");
    }
    Check(controller.homeAnimator.transitions==transitions+4,@"each rapid Tab selection delegates one whole-group transition with its actual reload");
    NSUInteger cancellations=controller.homeAnimator.cancellations;
    [controller reloadSettingsKeepingPosition];
    Check(controller.homeAnimator.cancellations==cancellations+1,@"a nonanimated settings refresh cancels any stale group snapshots before reloading");
    [controller openHomeSearch]; [controller updateHomeSearch:@"界面调色"];
    Check(controller.sections.count==1 && controller.sections.firstObject.items.count==1 &&
          [controller.sections.firstObject.items.firstObject.title isEqual:@"界面调色"],@"global search returns the inline palette once from its original settings category");
    [controller closeHomeSearch];
    [controller selectHomeTab:0]; [controller openHomeSearch];
    [controller updateHomeSearch:@"捉迷藏呀"];
    CSCloseFriendManager.sharedManager.visible=NO;
    [controller closeHomeSearch];
    Check(controller.sections.firstObject.items.count==3 && !controller.homeModel.searching,@"cancel search rebuilds current visibility before restoring its original Tab");
    [controller selectHomeTab:2]; [controller setHomeDistance:300]; [controller openHomeSearch];
    account=@"account-c";
    [controller closeHomeSearch];
    Check(controller.homeModel.selectedIndex==0 && !controller.homeModel.searching && controller.homeModel.query.length==0,@"cancel search after an account change restores the new account's default Tab");
    Check(controller.tabScrollDistances.count==0 && !controller.pendingHomeDistance && Near([controller currentHomeDistance],0),@"cancel after account reset consumes pending restoration without resurrecting old scroll state");
}
static void TestSearchInPlace(void) {
    for (NSNumber *value in @[@0,@72,@216]) {
        CSCustomViewController *controller=Controller();
        [controller selectHomeTab:1];
        [controller setHomeDistance:value.doubleValue];
        CGRect railFrame=controller.settingsTabBar.frame;
        CGRect profileFrame=controller.headerView.frame;
        [controller openHomeSearch];
        Check(Near([controller currentHomeDistance],value.doubleValue) && CGRectEqualToRect(controller.settingsTabBar.frame,railFrame),
              @"opening search preserves the exact rail position with a full, partial or collapsed profile");
        [controller updateHomeSearch:@"版本信息"];
        Check(Near([controller currentHomeDistance],value.doubleValue) && CGRectEqualToRect(controller.settingsTabBar.frame,railFrame),
              @"filtering to a short result leaves the inline search in the same position");
        Check(CGRectEqualToRect(controller.headerView.frame,profileFrame),@"search does not change the profile card's measured height or frame");
        [controller closeHomeSearch];
        Check(Near([controller currentHomeDistance],value.doubleValue) && CGRectEqualToRect(controller.settingsTabBar.frame,railFrame),
              @"cancelling search restores the Tab at the same original rail position");
    }
}
static void TestSectionHeaderReflow(void) {
    CSCustomViewController *controller=Controller();
    UIView *mounted=[UIView new],*detached=[UIView new];
    mounted.superview=controller.tableView;
    controller.homeSectionHeaders=[NSHashTable weakObjectsHashTable];
    [controller.homeSectionHeaders addObject:mounted];
    [controller.homeSectionHeaders addObject:detached];
    controller.tableView.safeAreaInsets=(UIEdgeInsets){0,43,0,0};
    [controller updateHeaderLayout];
    Check(Near(controller.headerView.horizontalInset,59),@"a same-width safe-area change updates the profile text anchor");
    Check(mounted.requestedLayouts==1 && mounted.completedLayouts==1,@"mounted section headers reflow immediately after the controller updates the anchor");
    Check(detached.requestedLayouts==0 && detached.completedLayouts==0,@"detached headers wait for mounting instead of converting unrelated coordinates");
    controller.tableView.safeAreaInsets=(UIEdgeInsets){0,0,0,0};
    [controller updateHeaderLayout];
    Check(Near(controller.headerView.horizontalInset,20) && mounted.completedLayouts==2,@"returning to the portrait inset reflows existing section headers at unchanged viewport size");
}
static void TestQuickPanelIntegration(void) {
    CSCloseFriendManager.sharedManager.visible=NO;
    CSCustomViewController *controller=Controller();
    NSArray<NSString *> *headers=@[@"账号与安全",@"界面定制",@"功能增强",@"插件设置"];
    NSArray<NSArray<NSString *> *> *titles=@[
        @[@"账号信息",@"收藏验证",@"防封检测"],
        @[@"顶栏信息",@"头像设置",@"触摸轨迹",@"界面简化",@"界面净化",@"气泡样式",@"列表圆角",@"底栏样式",
          @"布局设置",@"附件布局",@"文本占位",@"聊天分组",@"信息时间",@"后台模糊",@"广告净化",@"友圈布局"],
        @[@"后台运行",@"游戏辅助",@"防止撤回",@"红包功能",@"自动收款",@"消息手势",@"语音转发",@"复读功能",
          @"人工智能",@"定时任务",@"表情功能",@"小丑功能",@"群聊功能",@"自动功能",@"快捷面板"],
        @[@"界面调色",@"入口设置",@"版本控制",@"更新控制",@"备份配置",@"其他设置"]
    ];
    NSDictionary<NSString *,NSString *> *routes=@{
        @"账号信息":@"CSAccountDetailViewController", @"收藏验证":@"CSFavoriteSettingsViewController",
        @"防封检测":@"CSClientGuardSettingsViewController", @"顶栏信息":@"CSNavigationTitleSettingsViewController",
        @"头像设置":@"CSAvatarSettingsViewController", @"触摸轨迹":@"CSTouchTrailViewController",
        @"界面简化":@"CSWCEnhanceViewController", @"界面净化":@"CSUICleanViewController",
        @"气泡样式":@"CSBubbleStyleSettingsViewController", @"列表圆角":@"CSListCornerRadiusSettingsViewController",
        @"底栏样式":@"CSTabBarStyleSettingsViewController", @"布局设置":@"CSLayoutSettingsViewController",
        @"附件布局":@"CSChatAttachmentSettingsViewController", @"文本占位":@"CSInputTextSettingsViewController",
        @"聊天分组":@"CSChatGroupSettingsViewController", @"信息时间":@"CSMessageTimeSettingsViewController",
        @"后台模糊":@"CSBackgroundBlurSettingsViewController", @"广告净化":@"CSAdPurificationSettingsViewController",
        @"友圈布局":@"CSMomentsLayoutSettingsViewController", @"后台运行":@"CSBackgroundRunViewController",
        @"游戏辅助":@"CSGameCheatsViewController", @"防止撤回":@"CSRevokeSettingsViewController",
        @"红包功能":@"CSRedEnvelopSettingsViewController", @"自动收款":@"CSReceiveTransferSettingsViewController",
        @"消息手势":@"CSMessageGestureSettingsViewController", @"语音转发":@"CSVoiceForwardSettingsViewController",
        @"复读功能":@"CSRepeatSettingsViewController", @"人工智能":@"CSAIReplySettingsViewController",
        @"定时任务":@"CSScheduledTaskSettingsViewController", @"表情功能":@"CSImageStickerSettingsViewController",
        @"小丑功能":@"CSClownSettingsViewController", @"群聊功能":@"CSGroupChatSettingsViewController",
        @"自动功能":@"CSAutomationSettingsViewController", @"快捷面板":@"CSQuickPanelSettingsViewController",
        @"入口设置":@"CSEntrySettingsViewController", @"版本控制":@"CSVersionSettingsViewController",
        @"更新控制":@"CSUpdateControlViewController", @"备份配置":@"CSBackupSettingsViewController",
        @"其他设置":@"CSOtherSettingsViewController", @"版本信息":@"CSReleaseNotesViewController"
    };
    NSMutableSet<NSString *> *visited=[NSMutableSet set];
    for (NSUInteger tab=0;tab<titles.count;tab++) {
        [controller selectHomeTab:tab];
        Check(controller.homeModel.selectedIndex==tab && [controller.sections.firstObject.header isEqual:headers[tab]],
              @"the real selected tab retains its original functional category");
        Check([[controller.sections.firstObject.items valueForKey:@"title"] isEqual:titles[tab]],
              [@"registered entries retain their full order in " stringByAppendingString:headers[tab]]);
        Check([[controller.sections.lastObject.items valueForKey:@"title"] isEqual:@[@"版本信息",@"支持作者"]],
              @"the quick panel leaves shared About entries intact in every tab");
        for (NSUInteger section=0;section<controller.sections.count;section++) {
            NSArray<CSSettingItem *> *items=controller.sections[section].items;
            for (NSUInteger row=0;row<items.count;row++) {
                NSString *title=items[row].title;
                if ([visited containsObject:title]) continue;
                [visited addObject:title];
                NSUInteger pushes=controller.navigationController.pushes;
                NSUInteger cancellations=controller.homeAnimator.cancellations;
                NSUInteger deselections=controller.tableView.deselections;
                NSUInteger authorPresentations=controller.authorPresentations;
                [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
                Check(controller.homeAnimator.cancellations==cancellations+1 && controller.tableView.deselections==deselections+1,
                      [@"the real selection clears animation and selection for " stringByAppendingString:title]);
                if ([title isEqual:@"界面调色"]) {
                    Check(controller.navigationController.pushes==pushes,@"the inline palette retains its existing nonnavigation behavior");
                } else if ([title isEqual:@"支持作者"]) {
                    Check(controller.navigationController.pushes==pushes && controller.authorPresentations==authorPresentations+1,
                          @"the author action retains its existing handler");
                } else {
                    NSString *expected=routes[title];
                    Check(expected!=nil && controller.navigationController.pushes==pushes+1 &&
                          [NSStringFromClass(controller.navigationController.lastPushed.class) isEqual:expected],
                          [@"the real title branch pushes the correct controller for " stringByAppendingString:title]);
                    Check(controller.navigationController.lastPushed.style==UITableViewStyleInsetGrouped && controller.navigationController.animated,
                          [@"navigation retains grouped presentation and animation for " stringByAppendingString:title]);
                }
            }
        }
    }
    Check(visited.count==routes.count+2,@"all existing registered entries and the new quick panel execute their actual selection branches");
    Check([controller.otherSettingsReturnScope isEqual:account],@"the other-settings route still captures the current account scope");
    [controller selectHomeTab:2];
    NSArray<NSString *> *enhancementTitles=[controller.sections.firstObject.items valueForKey:@"title"];
    NSUInteger automationIndex=[enhancementTitles indexOfObject:@"自动功能"];
    Check(automationIndex!=NSNotFound && automationIndex+1<enhancementTitles.count &&
          [enhancementTitles[automationIndex+1] isEqual:@"快捷面板"],
          @"quick panel is in the enhancement tab immediately after automation");
    [controller selectHomeTab:0]; [controller openHomeSearch]; [controller updateHomeSearch:@"快捷面板"];
    Check(controller.sections.count==1 && [controller.sections.firstObject.header isEqual:@"功能增强"] &&
          controller.sections.firstObject.items.count==1 && [controller.sections.firstObject.items.firstObject.title isEqual:@"快捷面板"],
          @"global search finds the quick panel exactly once in the enhancement category");
    NSUInteger pushes=controller.navigationController.pushes;
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    Check(controller.navigationController.pushes==pushes+1 &&
          [NSStringFromClass(controller.navigationController.lastPushed.class) isEqual:@"CSQuickPanelSettingsViewController"],
          @"the searched quick-panel entry executes the same real controller route");
    [controller closeHomeSearch];
    Check(controller.homeModel.selectedIndex==0 && !controller.homeModel.searching,
          @"opening the quick-panel route through search preserves the original tab restoration");
    CSCloseFriendManager.sharedManager.visible=YES;
    [controller selectHomeTab:0];
    NSUInteger presentations=CSCloseFriendManager.sharedManager.presentations;
    pushes=controller.navigationController.pushes;
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    Check(CSCloseFriendManager.sharedManager.presentations==presentations+1 && controller.navigationController.pushes==pushes,
          @"the conditional account entry retains its existing presentation handler");
    CSCloseFriendManager.sharedManager.visible=NO;
}
int main(void) { @autoreleasepool {
    TestController(); TestSearchInPlace(); TestSectionHeaderReflow(); TestQuickPanelIntegration();
    printf("SettingsHomeControllerTests: %lu checks, %lu failures (real setupData and selection/controller methods; quick-panel enhancement placement/search/route, all existing navigation destinations, selected/search state, inline palette search, current-policy visibility, account-reset races, per-Tab restoration, actual rail geometry, async header reflow and group transition delegation; UIKit/navigation/layout/animation are fixtures)\n",(unsigned long)checks,(unsigned long)failures);
} return failures ? 1 : 0; }
