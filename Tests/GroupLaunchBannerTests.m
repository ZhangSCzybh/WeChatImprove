// Production refresh/header/publication order with a reentrant UIKit boundary.
// Native evidence: getBanner: returns one shared UIView per banner; addSubview:
// transfers that view to the latest Header cell. This is not a device frame test.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <math.h>
#import "CSGroupProjection.h"
#import "CSGroupIndexScope.h"
#import "WESessionTabItem.h"

typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static const NSInteger UITableViewRowAnimationNone=0,UITableViewCellStyleDefault=0,UITableViewCellSelectionStyleNone=0;
@class CSGroupListAdapter,LaunchHost;
@interface NSIndexPath (LaunchRows)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (LaunchRows)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section { NSUInteger values[]={(NSUInteger)section,(NSUInteger)row};return [self indexPathWithIndexes:values length:2]; }
@end
@interface NSObject (LaunchPrefetch)
- (void)tableView:(id)table cancelPrefetchingForRowsAtIndexPaths:(NSArray *)paths;
@end
@interface LaunchProxy : NSObject
@property(nonatomic,weak) id target;
@end
@implementation LaunchProxy @end
@interface UIView : NSObject
@property(nonatomic) CGRect frame;
@property(nonatomic) BOOL hidden,userInteractionEnabled;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) NSMutableArray<UIView *> *subviews;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) _subviews=[NSMutableArray array]; return self; }
- (void)addSubview:(UIView *)view { [view removeFromSuperview];[self.subviews addObject:view];view.superview=self; }
- (void)removeFromSuperview { [self.superview.subviews removeObjectIdenticalTo:self];self.superview=nil; }
@end
@interface Label : NSObject
@property(nonatomic,copy) NSString *text;
@end
@implementation Label @end
@interface UITableViewCell : UIView
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) Label *textLabel;
@property(nonatomic) NSInteger selectionStyle;
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier;
@end
@implementation UITableViewCell
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier {
    (void)style;(void)identifier;if ((self=[super init])) {_contentView=[UIView new];_textLabel=[Label new];}return self;
}
@end
@interface Gesture : NSObject
@property(nonatomic) BOOL enabled;
@end
@implementation Gesture @end
@interface LaunchChrome : UIView
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic,readonly) CGSize intrinsicContentSize;
- (void)refreshAppearance;
- (void)updateTabs:(NSArray *)tabs;
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)dot forTabIndex:(NSInteger)index;
- (void)applyAppearanceWithFontSize:(CGFloat)size showsSearchButton:(BOOL)show;
@end
@implementation LaunchChrome
- (CGSize)intrinsicContentSize { return CGSizeMake(320,44); }
- (void)refreshAppearance {}
- (void)updateTabs:(NSArray *)tabs { (void)tabs; }
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)dot forTabIndex:(NSInteger)index { (void)count;(void)dot;(void)index; }
- (void)applyAppearanceWithFontSize:(CGFloat)size showsSearchButton:(BOOL)show { (void)size;(void)show; }
@end
@interface LaunchPolicy : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) NSUInteger revision;
@property(nonatomic) BOOL blocked;
@end
@implementation LaunchPolicy @end
@interface LaunchShield : NSObject
- (void)prepareForPublication;
@end
@implementation LaunchShield
- (void)prepareForPublication {}
@end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID,*selectedTabID;
@property(nonatomic,strong) NSArray *tabs;
@property(nonatomic) BOOL filterDuplicates;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)account;
- (void)reload;
@end
@implementation CSGroupPreferences
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)account {
    (void)defaults;if ((self=[super init])) {_accountID=[account copy];_selectedTabID=@"preset_0";_tabs=@[[WESessionTabItem tabWithType:WETabTypeAll],[WESessionTabItem tabWithType:WETabTypePrivate]];}return self;
}
- (void)reload {}
@end
@interface UITableView : UIView
@property(nonatomic,weak) CSGroupListAdapter *adapter;
@property(nonatomic,weak) LaunchHost *host;
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) double decelerationRate;
@property(nonatomic,strong) UIView *tableHeaderView;
@property(nonatomic,copy) NSArray<NSIndexPath *> *indexPathsForVisibleRows;
@property(nonatomic,strong) NSMutableArray<NSString *> *events;
@property(nonatomic,strong) NSArray<UITableViewCell *> *cells,*retiredCells,*initialCells;
@property(nonatomic) BOOL needsCells,reenterHeader;
@property(nonatomic) NSUInteger reloads,rowReloads,layouts,headerWrites,blankRetiredContainers;
- (void)reloadData;
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation;
- (void)layoutIfNeeded;
@end
@interface LaunchHost : NSObject
@property(nonatomic,strong) UITableView *m_tableView;
@property(nonatomic,strong) id m_mainFrameLogicController;
@property(nonatomic) BOOL isSearching;
@property(nonatomic,strong) NSArray<UIView *> *banners;
@property(nonatomic) NSUInteger nativeBannerCalls,nativeChatCalls;
@property(nonatomic,strong) NSMutableDictionary<NSNumber *,NSNumber *> *bannerCallsByRow;
@property(nonatomic) BOOL allNativeCallsScoped;
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)path;
@end
static NSString *account=@"launch-account";
static LaunchPolicy *policy;
static char CellRowKey;
static BOOL CSGroupApplicationActive(void) { return YES; }
static BOOL CSGroupPrivacyActive(void) { return NO; }
static NSString *CSGroupCurrentAccountID(void) { return account; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return 1; }
static LaunchPolicy *CSCloseFriendCurrentSnapshot(void) { return policy; }
static BOOL CSGroupIsFoldedController(id owner) { (void)owner;return NO; }
static BOOL Option(NSString *suffix) { return [suffix isEqual:@"enabled"]; }
static id CSGroupReadObject(id owner,NSString *key) { return [owner valueForKey:key]; }
static long long CSGroupReadInteger(id owner,NSString *key,long long fallback) {
    return [key isEqual:@"isSearching"] ? [(LaunchHost *)owner isSearching] : fallback;
}
static CGFloat CSGroupTabFontSize(NSUserDefaults *defaults) { (void)defaults;return 14; }
static BOOL CSGroupSearchButtonVisible(NSUserDefaults *defaults) { (void)defaults;return YES; }
static void CSCloseFriendUpdateSessionCover(id cell,id row) { (void)cell;(void)row; }
static NSIndexPath *Path(NSUInteger row) { NSUInteger indexes[]={0,row};return [NSIndexPath indexPathWithIndexes:indexes length:2]; }

@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) LaunchHost *controller;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong) LaunchChrome *chrome;
@property(nonatomic,strong) UIView *nativeHeader,*headerContainer;
@property(nonatomic,strong) Gesture *pan,*listPan;
@property(nonatomic,strong) LaunchShield *privacyShield;
@property(nonatomic,strong) NSMutableDictionary *anchors,*identityDisplayPaths;
@property(nonatomic,strong) NSMutableDictionary<NSNumber *,LaunchProxy *> *proxies;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) NSMutableArray *nativeActions,*completions;
@property(nonatomic,copy) NSArray *cachedNativeSections,*displayedTabs;
@property(nonatomic,strong) NSMutableSet *pendingContentUserNames;
@property(nonatomic,copy) NSString *publishedTabID;
@property(nonatomic) CSGroupChangeKind pendingChanges;
@property(nonatomic) BOOL publishing,dirty,presentationSuspended,privacyRefreshPending,swipeActive;
@property(nonatomic) BOOL scheduled,scheduledCoalesced,scheduledInteraction,scheduledRecovery,coalescingNotification,pendingImmediateRefresh;
@property(nonatomic) BOOL pendingContentUnattributed,recoveryPending,snapshotRetryAttempted,searchChromeVisible,searching,nativePresentation;
@property(nonatomic) BOOL projecting,chromeVisible,publishedEnabled,appearanceDirty,publicationNeedsFullReload,pendingScrollToTop,updatingHeader;
@property(nonatomic) NSUInteger changeDepth,interactionAttempts,refreshGeneration,snapshotRetryGeneration;
@property(nonatomic) NSTimeInterval interactionDeadline,pendingRefreshDeadline,scheduledRefreshDeadline;
@property(nonatomic) double baselineDeceleration;
- (void)refresh;
- (BOOL)isActive;
- (void)layout;
- (void)publishHeader:(UIView *)header;
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous changes:(CSGroupChangeKind)changes contentUserNames:(NSSet *)names contentIdentityKnown:(BOOL)known previouslyProjecting:(BOOL)previouslyProjecting;
- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target;
- (void)requestRefresh;
- (void)requestRecovery;
- (void)pruneNativeActions;
- (void)finishSuspendedBatches;
- (BOOL)groupPanMoving;
- (NSUInteger)nativeMenuState;
- (void)reconcileDeletedSwipeRow;
- (void)scheduleRefresh;
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay;
- (void)saveAnchor;
- (void)installProxies;
- (void)refreshNavigationTitle;
- (void)ensureChrome;
- (NSArray *)nativeSectionsForAccount:(NSString *)value;
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)value;
- (void)restoreViewportFromTab:(NSString *)tab scrollHeight:(CGFloat)height;
- (void)shieldVisiblePrivateRows;
- (void)applyPendingScrollToTop;
- (void)requestTabBadgeSourceRefresh;
- (BOOL)keepsGroupHeaderDuringSearch;
- (void)updateGroupGestureAvailability;
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row;
@property(nonatomic) BOOL tabBadgeSourceScheduled;
@end
@implementation CSGroupListAdapter
#include "GroupLaunchBannerBodies.h"
- (void)requestRefresh { self.dirty=YES; }
- (void)requestRecovery { [NSException raise:@"UnexpectedRecovery" format:@"valid banner row must remain resolvable"]; }
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
- (BOOL)groupPanMoving { return NO; }
- (NSUInteger)nativeMenuState { return 0; }
- (void)reconcileDeletedSwipeRow {}
- (void)scheduleRefresh {}
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay { (void)event;(void)delay; }
- (void)saveAnchor {}
- (void)installProxies {}
- (void)refreshNavigationTitle {}
- (void)ensureChrome { if (!self.chrome) self.chrome=[LaunchChrome new]; }
- (NSArray *)nativeSectionsForAccount:(NSString *)value { (void)value;return self.cachedNativeSections; }
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)value {
    return [[CSGroupProjection alloc] initWithSections:sections tabs:tabs selectedTabID:selected filterDuplicates:NO accountID:value previousProjection:self.projection];
}
- (void)restoreViewportFromTab:(NSString *)tab scrollHeight:(CGFloat)height { (void)tab;(void)height; }
- (void)shieldVisiblePrivateRows {}
- (void)applyPendingScrollToTop {}
- (void)requestTabBadgeSourceRefresh {}
- (BOOL)keepsGroupHeaderDuringSearch { return NO; }
- (void)updateGroupGestureAvailability {}
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row { return row.nativePath; }
@end
@implementation LaunchHost
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)path {
    self.allNativeCallsScoped &= CSGroupUsesNativeIndices(table);
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"Header"];
    NSUInteger row=[path indexAtPosition:1];
    if (row<self.banners.count) {
        self.nativeBannerCalls++;self.bannerCallsByRow[@(row)]=@([self.bannerCallsByRow[@(row)] unsignedIntegerValue]+1);
        [cell.contentView addSubview:self.banners[row]];
    }
    else { self.nativeChatCalls++;cell.textLabel.text=@"ordinary chat"; }
    return cell;
}
@end
@implementation UITableView
- (void)materialize {
    if (self.cells && !self.needsCells) return;
    NSMutableArray *next=[NSMutableArray array];
    for (NSIndexPath *path in self.indexPathsForVisibleRows)
        [next addObject:[self.adapter cellForDisplayPath:path target:self.host]];
    self.cells=next;if (!self.initialCells) self.initialCells=next;self.needsCells=NO;
    for (UITableViewCell *old in self.retiredCells) if (!old.contentView.subviews.count && !old.textLabel.text.length) self.blankRetiredContainers++;
}
- (void)setTableHeaderView:(UIView *)header {
    _tableHeaderView=header;self.headerWrites++;[self.events addObject:@"header"];
    // MMTableView wraps the UIKit setter and can synchronously layout. The
    // fixture makes that permitted callback ordering deterministic.
    if (self.reenterHeader) [self materialize];
}
- (void)reloadData {
    NSCAssert(!CSGroupUsesNativeIndices(self),@"table operations use display coordinates");
    self.reloads++;[self.events addObject:@"reload"];
    self.retiredCells=self.cells;self.cells=nil;self.needsCells=YES;
}
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation {
    (void)animation;self.rowReloads++;[self.events addObject:@"rows"];
    NSMutableArray *next=[self.cells mutableCopy];
    for (NSIndexPath *path in paths) {
        NSUInteger row=[path indexAtPosition:1];
        next[row]=[self.adapter cellForDisplayPath:path target:self.host];
    }
    self.cells=next;
}
- (void)layoutIfNeeded { self.layouts++;[self.events addObject:@"layout"];[self materialize]; }
@end
static NSUInteger checks,failures;
static void Check(BOOL value,NSString *message) { checks++;if (!value) {failures++;fprintf(stderr,"FAIL: %s\n",message.UTF8String);} }
static CSGroupRow *Row(NSUInteger index,NSString *name,CSGroupRowCategory category) {
    return [[CSGroupRow alloc] initWithNativePath:Path(index) userName:name kind:name.length ? CSGroupRowKindSession : CSGroupRowKindBusiness category:category top:NO unreadCount:0 redDot:NO];
}
static CSGroupListAdapter *List(BOOL reenter) {
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=[LaunchHost new];a.table=[UITableView new];
    a.controller.m_tableView=a.table;a.table.adapter=a;a.table.host=a.controller;
    a.table.bounds=CGRectMake(0,0,320,640);a.table.events=[NSMutableArray array];a.table.reenterHeader=reenter;
    a.table.indexPathsForVisibleRows=@[Path(0),Path(1),Path(2)];
    a.controller.banners=@[[UIView new],[UIView new]];a.controller.allNativeCallsScoped=YES;
    a.controller.bannerCallsByRow=[NSMutableDictionary dictionary];
    a.cachedNativeSections=@[@[Row(0,nil,CSGroupRowCategoryUnknown),Row(1,nil,CSGroupRowCategoryUnknown),Row(2,@"friend",CSGroupRowCategoryPrivate)]];
    a.nativeActions=[NSMutableArray array];a.completions=[NSMutableArray array];a.prefetchedPaths=[NSMutableSet set];
    a.proxies=[NSMutableDictionary dictionary];a.pan=[Gesture new];a.listPan=[Gesture new];a.anchors=[NSMutableDictionary dictionary];
    return a;
}
static BOOL ContentComplete(CSGroupListAdapter *a) {
    return a.table.cells.count==3 && a.table.cells[0].contentView.subviews.count==1 && a.table.cells[0].contentView.subviews[0]==a.controller.banners[0] && a.table.cells[1].contentView.subviews.count==1 && a.table.cells[1].contentView.subviews[0]==a.controller.banners[1];
}
int main(void) { @autoreleasepool {
    policy=[LaunchPolicy new];policy.accountID=account;policy.revision=1;
    for (NSNumber *reenter in @[@YES,@NO]) {
        CSGroupListAdapter *a=List(reenter.boolValue);[a refresh];
        NSString *mode=reenter.boolValue ? @"reentrant header" : @"deferred header";
        Check(a.isActive && a.projection.isValid,[mode stringByAppendingString:@": initial projection is valid"]);
        Check(a.table.reloads==1 && !a.table.rowReloads,[mode stringByAppendingString:@": first publication uses exactly its existing one full reload"]);
        for (NSUInteger row=0;row<2;row++) {
            Check([a.controller.bannerCallsByRow[@(row)] unsignedIntegerValue]==1,
                  [NSString stringWithFormat:@"%@: business row %lu is delivered exactly once during first publication",mode,(unsigned long)row]);
            Check(a.table.initialCells[row]==a.table.cells[row],
                  [NSString stringWithFormat:@"%@: business row %lu keeps its first published container",mode,(unsigned long)row]);
            Check(a.controller.banners[row].superview==a.table.initialCells[row].contentView,
                  [NSString stringWithFormat:@"%@: business row %lu never loses its shared native content to a replacement container",mode,(unsigned long)row]);
        }
        Check(a.table.blankRetiredContainers==0,[mode stringByAppendingString:@": no newly published banner container is stripped to a white board"]);
        Check(ContentComplete(a),[mode stringByAppendingString:@": both final business rows own their complete native content"]);
        Check([a.table.events.firstObject isEqual:@"reload"],[mode stringByAppendingString:@": old cells are invalidated before mounting the first grouped header"]);
        Check(a.table.layouts==1 && a.controller.allNativeCallsScoped,[mode stringByAppendingString:@": one synchronous final layout preserves native cell coordinates"]);
        NSUInteger calls=a.controller.nativeBannerCalls,reloads=a.table.reloads;
        [a refresh];
        Check(a.controller.nativeBannerCalls==calls && a.table.reloads==reloads && !a.table.rowReloads,[mode stringByAppendingString:@": unchanged return refresh preserves banner instances without a full or local reload"]);
        a.pendingChanges=CSGroupChangeContent;a.pendingContentUserNames=[NSMutableSet setWithObject:@"friend"];
        [a refresh];
        Check(a.table.reloads==reloads && a.table.rowReloads==1 && a.controller.nativeBannerCalls==calls,[mode stringByAppendingString:@": attributed chat content remains a local refresh and does not recreate banners"]);
        a.pendingChanges=CSGroupChangeContent;a.pendingContentUnattributed=YES;[a refresh];
        Check(a.table.reloads==reloads && a.table.rowReloads==2 && ContentComplete(a),
              [mode stringByAppendingString:@": real unattributed business content still refreshes locally without a new full reload"]);
        a.preferences.selectedTabID=[a.preferences.tabs[1] tabId];[a refresh];
        Check(a.projection.isValid && ContentComplete(a),[mode stringByAppendingString:@": group projection still retains both native business rows"]);
    }
    printf("Group launch banners: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
