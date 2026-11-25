// Host replay of real header publication / search-hook bodies, not an iOS render test.
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSGroupAppearance.h"
#import "CSGroupRefreshState.h"
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"
#define CGRect NSRect
#define CGSize NSSize
#define CGRectMake NSMakeRect
#define CGRectGetHeight NSHeight
#define CGRectGetWidth NSWidth
#define CGRectEqualToRect NSEqualRects
typedef double UIScrollViewDecelerationRate;
static BOOL enabled=YES,appActive=YES,privacyEnabled;
static NSString *account=@"A";
static NSSet *hiddenNames;
static BOOL Option(NSString *key) { return [key isEqual:@"enabled"] && enabled; }
static BOOL CSGroupApplicationActive(void) { return appActive; }
static NSString *CSGroupCurrentAccountID(void) { return account; }
static BOOL CSGroupPrivacyActive(void) { return privacyEnabled; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return 1; }
static BOOL CSGroupIsFoldedController(id owner) { (void)owner; return NO; }
static id CSGroupReadObject(id owner,NSString *key) { return [owner valueForKey:key]; }
static long long CSGroupReadInteger(id owner,NSString *key,long long fallback) { return owner ? [[owner valueForKey:key] longLongValue] : fallback; }
static NSUInteger nativeIndicesDepth,displayIndicesDepth;
static BOOL fixtureNativeIndexScope=YES;
static BOOL CSGroupUsesNativeIndices(id table) { (void)table; return nativeIndicesDepth && !displayIndicesDepth; }
static BOOL CSGroupUsesNativeHeader(id table) { (void)table; return NO; }
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) {
    (void)table; displayIndicesDepth++; @try { body(); } @finally { displayIndicesDepth--; }
}
static void CSGroupWithNativeIndices(id table,void (^body)(void)) {
    (void)table; nativeIndicesDepth++; @try { body(); } @finally { nativeIndicesDepth--; }
}
@interface SearchPolicy : NSObject
@property(nonatomic) BOOL blocked;
@end
@implementation SearchPolicy @end
static SearchPolicy *CSCloseFriendCurrentSnapshot(void) { return nil; }
@interface NSIndexPath (SearchUIKit)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (SearchUIKit)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row}; return [self indexPathWithIndexes:indexes length:2];
}
@end
@interface NSObject (SearchPrefetch)
- (void)tableView:(id)table cancelPrefetchingForRowsAtIndexPaths:(NSArray *)paths;
@end
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) BOOL hidden,userInteractionEnabled;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) NSMutableArray *children;
@property(nonatomic) NSUInteger removals;
- (void)removeFromSuperview;
- (void)addSubview:(UIView *)view;
- (BOOL)isDescendantOfView:(UIView *)view;
@end
@implementation UIView
- (void)removeFromSuperview { self.removals++; [self.superview.children removeObject:self]; self.superview=nil; }
- (void)addSubview:(UIView *)view {
    [view removeFromSuperview]; if (!self.children) self.children=[NSMutableArray array];
    [self.children addObject:view]; view.superview=self;
}
- (BOOL)isDescendantOfView:(UIView *)view { return self==view || [self.superview isDescendantOfView:view]; }
@end
@interface Chrome : UIView
@property(nonatomic) CGSize intrinsicContentSize;
@property(nonatomic,copy) NSString *selectedTabID;
- (void)applyAppearanceWithFontSize:(CGFloat)size showsSearchButton:(BOOL)visible;
- (void)refreshAppearance;
- (void)updateTabs:(NSArray *)tabs;
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)dot forTabIndex:(NSInteger)index;
@end
@implementation Chrome
- (void)applyAppearanceWithFontSize:(CGFloat)size showsSearchButton:(BOOL)visible { (void)size; (void)visible; }
- (void)refreshAppearance {}
- (void)updateTabs:(NSArray *)tabs { (void)tabs; }
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)dot forTabIndex:(NSInteger)index { (void)count; (void)dot; (void)index; }
@end
@interface Pan : NSObject
@property(nonatomic) BOOL enabled;
@end
@implementation Pan @end
@interface UITableView : UIView
@property(nonatomic,strong) UIView *tableHeaderView;
@property(nonatomic,strong) NSMutableArray *installedHeaders;
@property(nonatomic,weak) id testAdapter;
@property(nonatomic) double decelerationRate;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
- (void)reloadData;
- (void)layoutIfNeeded;
@end
@implementation UITableView
@synthesize tableHeaderView=_tableHeaderView;
- (void)setTableHeaderView:(UIView *)header {
    _tableHeaderView=header;
    [self.installedHeaders addObject:header ?: NSNull.null];
}
- (void)reloadData {}
- (void)layoutIfNeeded {}
@end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic,copy) NSArray *tabs;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)accountID;
- (void)reload;
@end
@implementation CSGroupPreferences
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)accountID {
    (void)defaults;
    if ((self=[super init])) {
        self.accountID=accountID; self.selectedTabID=@"preset_2";
        self.tabs=@[[WESessionTabItem tabWithType:WETabTypeAll], [WESessionTabItem tabWithType:WETabTypePrivate], [WESessionTabItem tabWithType:WETabTypeGroup]];
    }
    return self;
}
- (void)reload {}
@end
@interface Proxy : NSObject
@property(nonatomic,strong) id target;
@end
@implementation Proxy @end
@interface SearchPrivacyShield : NSObject
- (void)prepareForPublication;
@end
@implementation SearchPrivacyShield
- (void)prepareForPublication {}
@end
@interface CSGroupListAdapter : NSObject
@property(nonatomic) BOOL tabBadgeSourceScheduled;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) Chrome *chrome;
@property(nonatomic,strong) UIView *nativeHeader,*headerContainer;
@property(nonatomic,strong) Pan *pan,*listPan;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,weak) id controller;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) NSMutableDictionary *anchors;
@property(nonatomic,strong) NSArray *sourceSections,*cachedNativeSections,*displayedTabs;
@property(nonatomic,strong) NSDictionary *identityDisplayPaths;
@property(nonatomic,strong) NSDictionary *presentationViewport,*switchViewport;
@property(nonatomic,strong) NSMutableSet *pendingChangedUserNames;
@property(nonatomic,strong) NSMutableArray *completions,*nativeActions;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) NSDictionary<NSNumber *,Proxy *> *proxies;
@property(nonatomic,copy) NSString *publishedTabID;
@property(nonatomic,copy) NSString *pagePreviewTabID;
@property(nonatomic,copy) NSDictionary *pageTransitionContext;
@property(nonatomic) BOOL preparingPagePreview;
@property(nonatomic) BOOL chromeVisible,searching,searchChromeVisible,pendingScrollToTop,presentationSuspended,updatingHeader;
@property(nonatomic) BOOL publishing,privacyRefreshPending,dirty,swipeActive,recoveryPending,nativePresentation,projecting,publishedEnabled;
@property(nonatomic) BOOL appearanceDirty,snapshotRetryAttempted,sessionLayoutHeld;
@property(nonatomic) BOOL usesNativeSessionModel,pendingChangeNamesUnknown;
@property(nonatomic,strong) SearchPrivacyShield *privacyShield;
@property(nonatomic) NSUInteger changeDepth,interactionAttempts,publications;
@property(nonatomic) NSUInteger modelRevision,snapshotEpoch;
@property(nonatomic) CSGroupChangeKind pendingChanges;
@property(nonatomic) NSTimeInterval interactionDeadline;
@property(nonatomic) double baselineDeceleration;
@property(nonatomic) NSUInteger invalidations,anchorSaves,titles,refreshes,requests;
- (void)layout;
- (void)publishHeader:(UIView *)header;
- (void)shieldVisiblePrivateRows;
- (void)cancelPageTransition;
- (void)cancelInvalidPageTransition;
- (void)finishPageTransitionIfReady;
+ (instancetype)adapterForTable:(UITableView *)table;
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller;
+ (void)attachToController:(id)controller;
+ (void)layoutForController:(id)controller;
+ (void)finishPresentationReturnForController:(id)controller;
@end
@implementation CSGroupListAdapter
+ (instancetype)adapterForTable:(UITableView *)table { return table.testAdapter; }
// The fixture models owner attachment; the production appearance hook itself
// is replayed below. Viewport restoration belongs to GroupInitialViewportTests.
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller {
    CSGroupListAdapter *adapter=[controller valueForKey:@"adapter"];
    adapter.presentationSuspended=suspended;
}
+ (void)attachToController:(id)controller { CSGroupListAdapter *adapter=[controller valueForKey:@"adapter"]; [adapter refresh]; [adapter layout]; }
+ (void)layoutForController:(id)controller { [[controller valueForKey:@"adapter"] layout]; }
+ (void)finishPresentationReturnForController:(id)controller { (void)controller; }
// Badge source lifecycle is exercised in GroupLifecycleTests.
- (void)requestTabBadgeSourceRefresh {}
- (void)shieldVisiblePrivateRows {}
- (BOOL)adoptCompatibilityModelIfNeeded { return NO; }
- (void)refreshNativeSessionModel { [NSException raise:@"UnexpectedNativeModel" format:@"Search projection fixture uses the compatibility model"]; }
- (void)prepareInitialViewport {}
- (void)clearPendingViewport {}
- (void)restorePendingViewport {}
// Snapshot animation lifecycle is tested separately from search projection.
- (void)cancelPageTransition {}
- (void)cancelInvalidPageTransition {}
- (void)finishPageTransitionIfReady {}
- (NSDictionary *)captureViewportForTabID:(NSString *)tabID { (void)tabID; return nil; }
- (void)restoreViewportFromSource:(NSDictionary *)viewport { (void)viewport; }
- (void)consumeRefreshRequest {}
- (void)invalidateNativeSnapshot { self.invalidations++; }
- (void)saveAnchor { self.anchorSaves++; }
- (void)restoreAnchor {}
- (void)refreshNavigationTitle { self.titles++; }
- (void)ensureChrome {}
- (void)updateGroupGestureAvailability { self.pan.enabled=self.listPan.enabled=!self.searching; }
- (void)applyPendingScrollToTop {}
- (void)refresh { self.refreshes++; if (self.controller) [self refreshProjection]; }
- (void)requestRefresh { self.requests++; }
- (void)scheduleRefresh { self.requests++; }
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
- (BOOL)groupPanMoving { return NO; }
- (NSUInteger)nativeMenuState { return 0; }
- (void)reconcileDeletedSwipeRow {}
- (void)installProxies {}
- (BOOL)isActive { return self.projecting; }
- (NSArray *)nativeSectionsForAccount:(NSString *)accountID changes:(CSGroupChangeKind)changes changedUserNames:(NSSet *)names { (void)accountID; (void)changes; (void)names; return self.sourceSections; }
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)accountID {
    return [[CSGroupProjection alloc] initWithSections:sections tabs:tabs selectedTabID:selected filterDuplicates:NO
        accountID:accountID hiddenUserNames:privacyEnabled ? hiddenNames : [NSSet set] privacyRevision:self.publications+1 previousProjection:nil];
}
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous changes:(CSGroupChangeKind)changes changedUserNames:(NSSet *)names previouslyProjecting:(BOOL)previouslyProjecting {
    (void)projection; (void)previous; (void)changes; (void)names; (void)previouslyProjecting; self.publications++;
}
#include "SearchBodies.h"
@end
@interface SearchTable : UITableView @end
@implementation SearchTable
#include "SearchTableHooks.h"
@end
@interface Host : NSObject
@property(nonatomic,strong) CSGroupListAdapter *adapter;
@property(nonatomic,strong) UIView *searchBar,*presentedSearchBar;
@property(nonatomic) NSUInteger calls;
@property(nonatomic) BOOL sawNativeBeforePrepare,isSearching;
@property(nonatomic,copy) void (^nativeCall)(Host *,NSString *);
- (void)originalSearchCall:(NSString *)selector;
- (void)originalSearchCall:(NSString *)selector searchBar:(UIView *)searchBar;
- (void)onSearchButtonTapped;
- (void)showSearchBar:(id)sender;
- (void)showSearchBar:(id)sender searchBar:(id)searchBar autoStartGreenMic:(BOOL)autoStartGreenMic;
- (id)m_mainFrameLogicController;
@end
static CSGroupListAdapter *Adapter(Host *host) { return host.adapter; }
static void Native(Host *owner,BOOL change,void (^body)(void)) {
    (void)change;
    if (fixtureNativeIndexScope) CSGroupWithNativeIndices(owner.adapter.table,body);
    else body();
}
@implementation Host
@synthesize adapter=_adapter;
- (void)setAdapter:(CSGroupListAdapter *)adapter { _adapter=adapter; self.searchBar=adapter.nativeHeader; }
- (id)m_mainFrameLogicController { return nil; }
- (void)onSearchButtonTapped { [self showSearchBar:self]; }
- (void)showSearchBar:(id)sender { [self showSearchBar:sender searchBar:self.searchBar autoStartGreenMic:NO]; }
- (void)originalSearchCall:(NSString *)selector searchBar:(UIView *)searchBar {
    self.presentedSearchBar=searchBar;
    [self originalSearchCall:selector];
}
- (void)originalSearchCall:(NSString *)selector {
    self.calls++;
    __block UIView *installed=nil;
    CSGroupWithDisplayIndices(self.adapter.table,^{ installed=self.adapter.table.tableHeaderView; });
    if (installed==self.adapter.nativeHeader) self.sawNativeBeforePrepare=YES;
    if (self.nativeCall) self.nativeCall(self,selector);
}
#include "SearchHooks.h"
@end
static NSUInteger checks,failures;
static void Check(BOOL ok,NSString *message) { checks++; if (!ok) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); } }
static CSGroupListAdapter *List(void) {
    CSGroupListAdapter *a=[CSGroupListAdapter new]; a.table=[SearchTable new]; a.table.testAdapter=a;
    a.table.installedHeaders=[NSMutableArray array]; a.table.bounds=NSMakeRect(0,0,430,900);
    a.nativeHeader=[UIView new]; a.nativeHeader.frame=NSMakeRect(0,0,430,47);
    a.chrome=[Chrome new]; a.chrome.intrinsicContentSize=NSMakeSize(430,52);
    a.pan=[Pan new]; a.listPan=[Pan new]; a.preferences=[[CSGroupPreferences alloc] initWithDefaults:nil accountID:account];
    a.anchors=[NSMutableDictionary dictionary]; a.completions=[NSMutableArray array]; a.nativeActions=[NSMutableArray array];
    a.prefetchedPaths=[NSMutableSet set]; a.proxies=@{};
    a.chromeVisible=YES; a.baselineDeceleration=.99; [a layout]; return a;
}
static NSArray *DisplayedNames(CSGroupListAdapter *adapter) {
    NSMutableArray *names=[NSMutableArray array];
    for (NSArray *section in adapter.projection.sections) for (CSGroupRow *row in section) [names addObject:row.userName];
    return names;
}
static CSGroupRow *Row(NSUInteger index,NSString *name,CSGroupRowCategory category) {
    return [[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathForRow:(NSInteger)index inSection:0]
        userName:name kind:CSGroupRowKindSession category:category top:NO unreadCount:0 redDot:NO];
}
static UIView *DisplayedHeader(CSGroupListAdapter *adapter) {
    __block UIView *header=nil;
    CSGroupWithDisplayIndices(adapter.table,^{ header=adapter.table.tableHeaderView; });
    return header;
}
static void ReplayQuickSearchReturn(BOOL resetsBeforeAppearance,BOOL usesNativeIndexScope) {
    // Scope mode follows both production Native() branches. Projection refresh
    // remains the compatibility fixture; this is not a native-model data replay.
    BOOL previousScope=fixtureNativeIndexScope; fixtureNativeIndexScope=usesNativeIndexScope;
    Host *host=[Host new]; CSGroupListAdapter *a=List(); host.adapter=a; a.controller=host;
    a.sourceSections=@[@[Row(0,@"ordinary",CSGroupRowCategoryPrivate),Row(1,@"group",CSGroupRowCategoryGroup)]];
    [a refresh]; UIView *wrapper=DisplayedHeader(a);
    host.nativeCall=^(Host *owner,NSString *selector) {
        CSGroupListAdapter *adapter=owner.adapter;
        if ([selector isEqual:@"showSearchBar:"]) {
            Check(adapter.searching && adapter.searchChromeVisible && DisplayedHeader(adapter)==wrapper,
                @"quick button reaches the real presenter after backing-header preparation");
            Check(owner.presentedSearchBar==owner.searchBar && owner.searchBar==adapter.nativeHeader,
                @"three-argument presenter receives the native searchBar object independently of table scope");
            Check(CSGroupUsesNativeIndices(adapter.table)==usesNativeIndexScope &&
                adapter.table.tableHeaderView==(usesNativeIndexScope ? adapter.nativeHeader : wrapper),
                @"native body uses the selected scope while the displayed group header stays installed");
            UIView *searchPage=[UIView new]; [searchPage addSubview:owner.presentedSearchBar];
            NSUInteger removals=adapter.nativeHeader.removals;
            owner.isSearching=YES; [adapter refresh]; [adapter layout];
            Check(adapter.nativeHeader.superview==searchPage && adapter.nativeHeader.removals==removals,
                @"presenter keeps ownership of its moved search view");
            [owner viewWillDisappear:YES]; [owner viewDidDisappear:YES];
        } else if ([selector isEqual:@"setSearchBarToTableHeaderView"]) {
            // Replay the 8.0.80 host method: table.tableHeaderView=searchBar.
            // This passes through the extracted production UITableView setter.
            adapter.table.tableHeaderView=owner.searchBar;
            Check(DisplayedHeader(adapter)==wrapper,@"host header restoration cannot install a visible native search bar");
        } else if ([selector isEqual:@"viewWillAppear:"]) {
            [owner setSearchBarToTableHeaderView];
            Check(DisplayedHeader(adapter)==wrapper,@"first native appearance body keeps the group before attachment refresh");
        } else if ([selector isEqual:@"cancelSearch"]) owner.isSearching=NO;
    };
    // The quick router invokes the native button. The fixture follows the
    // verified button -> showSearchBar: -> three-argument presenter chain.
    [host onSearchButtonTapped];
    Check(a.presentationSuspended && DisplayedHeader(a)==wrapper && a.searchChromeVisible,
        @"covered main page retains the prepared group backing header");
    if (resetsBeforeAppearance) host.isSearching=NO;
    [host setSearchBarToTableHeaderView]; [a refresh];
    Check(DisplayedHeader(a)==wrapper,@"suspended native restoration leaves the installed group header intact");
    [host viewWillAppear:YES];
    Check(DisplayedHeader(a)==wrapper && a.chromeVisible && [a.publishedTabID isEqual:@"preset_2"],
        @"first returned frame keeps the selected group for either native search-state timing");
    for (NSUInteger frame=0;frame<6;frame++) {
        [host setSearchBarToTableHeaderView]; [host viewDidLayoutSubviews]; [a refresh];
        Check(DisplayedHeader(a)==wrapper && !a.chrome.hidden && [a.publishedTabID isEqual:@"preset_2"],
            @"every cancellation-transition slice retains the displayed group header");
    }
    [host cancelSearch]; [host onFTSSearchEnd]; [host setSearchBarActive:NO]; [host viewDidAppear:YES];
    Check(!a.searching && !a.searchChromeVisible && a.chrome.userInteractionEnabled && DisplayedHeader(a)==wrapper,
        @"completed quick search restores group interaction without a header swap");
    Check([DisplayedNames(a) isEqual:@[@"ordinary"]],@"quick search return retains the selected group's rows");
    BOOL onlyGroup=YES;
    for (id installed in a.table.installedHeaders) onlyGroup &= installed==wrapper;
    Check(onlyGroup && !host.sawNativeBeforePrepare,
        @"recorded actual header installations contain no native search flash at any phase");
    fixtureNativeIndexScope=previousScope;
}
int main(void) { @autoreleasepool {
    // Use a private defaults suite: never modify the developer's real settings.
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    [defaults setVolatileDomain:@{CSGroupSearchButtonVisibleKey:@YES} forName:NSArgumentDomain];
    CSGroupListAdapter *a=List(); UIView *wrapper=a.table.tableHeaderView;
    Check(wrapper==a.headerContainer && !a.nativeHeader.superview,@"shortcut hides the original search header");
    CGRect originalFrame=a.nativeHeader.frame;
    [a prepareForNativeSearch];
    Check(a.searching && a.searchChromeVisible && a.table.tableHeaderView==wrapper && !a.chrome.hidden,@"entry keeps the grouping header visible");
    Check(!a.pan.enabled && !a.listPan.enabled && !a.chrome.userInteractionEnabled,@"group swipes are disabled while searching");
    Check([a nativeTableHeaderView]==a.nativeHeader && NSEqualRects(originalFrame,a.nativeHeader.frame),@"native search retains original identity and geometry");
    [a prepareForNativeSearch];
    Check(a.anchorSaves==1 && a.searchChromeVisible,@"nested onSearch and active callbacks preserve the transition");
    // Explicit native result navigation may release projection/chrome ownership;
    // header presentation must still remain stable throughout the pop.
    a.chromeVisible=NO;
    for (NSUInteger i=0;i<20;i++) { [a layout]; Check(a.table.tableHeaderView==wrapper && !a.chrome.hidden,@"search/interactive return frames never install the native header"); }
    UIView *searchPage=[UIView new]; [searchPage addSubview:a.nativeHeader];
    NSUInteger removals=a.nativeHeader.removals;
    [a layout];
    Check(a.nativeHeader.superview==searchPage && a.nativeHeader.removals==removals,@"search layout does not steal the host search view");
    UIView *newHeader=[UIView new]; newHeader.frame=NSMakeRect(0,0,430,60);
    [a setNativeTableHeaderView:newHeader];
    Check(a.nativeHeader==newHeader && a.table.tableHeaderView==wrapper,@"native header replacement remains invisible behind search");
    a.presentationSuspended=YES; [a layout];
    Check(a.table.tableHeaderView==wrapper,@"offscreen suspension preserves the transition backing header");
    a.presentationSuspended=NO; a.searching=NO; a.searchChromeVisible=NO; a.chromeVisible=YES; [a layout];
    Check(a.table.tableHeaderView==wrapper && a.pan.enabled && a.chrome.userInteractionEnabled,@"completed return restores group interaction without changing header identity");
    a=List(); [a prepareForNativeSearch]; account=@"B";
    Check(![a keepsGroupHeaderDuringSearch],@"retained chrome cannot cross accounts"); account=@"A";
    enabled=NO; [a layout];
    Check(a.table.tableHeaderView==a.nativeHeader && a.chrome.hidden,@"disabling grouping restores native header even during search"); enabled=YES;
    [defaults setVolatileDomain:@{CSGroupSearchButtonVisibleKey:@NO} forName:NSArgumentDomain];
    a=List(); Check(NSHeight(a.headerContainer.frame)==99 && a.nativeHeader.superview==a.headerContainer,@"shortcut disabled retains native search above groups");
    [a prepareForNativeSearch];
    Check(!a.searchChromeVisible && a.table.tableHeaderView==a.nativeHeader,@"ordinary native search retains its previous presentation");
    [defaults setVolatileDomain:@{CSGroupSearchButtonVisibleKey:@YES} forName:NSArgumentDomain];
    Host *host=[Host new]; host.adapter=List();
    [host onSearch]; [host setSearchBarActive:YES];
    Check(host.calls==2 && !host.sawNativeBeforePrepare && host.adapter.searchChromeVisible,@"real hooks prepare the stable header before invoking native search");
    NSUInteger refreshes=host.adapter.refreshes, requests=host.adapter.requests;
    [host cancelSearch]; [host onFTSSearchEnd]; [host setSearchBarActive:NO];
    Check(host.calls==5 && host.adapter.refreshes==refreshes+3 && host.adapter.requests==requests,@"search end hooks reconcile synchronously without the scheduled delay");

    ReplayQuickSearchReturn(NO,YES); ReplayQuickSearchReturn(YES,YES);
    ReplayQuickSearchReturn(NO,NO); ReplayQuickSearchReturn(YES,NO);
    host=[Host new]; host.adapter=List(); a=host.adapter; a.controller=host;
    enabled=NO; [a refresh]; [host onSearchButtonTapped];
    Check(!a.searchChromeVisible && DisplayedHeader(a)==a.nativeHeader,
        @"quick search leaves the native header in charge when grouping is disabled");
    enabled=YES;
    [defaults setVolatileDomain:@{CSGroupSearchButtonVisibleKey:@NO} forName:NSArgumentDomain];
    host=[Host new]; host.adapter=List(); [host onSearchButtonTapped];
    Check(!host.adapter.searchChromeVisible && DisplayedHeader(host.adapter)==host.adapter.nativeHeader,
        @"quick search retains ordinary native search when the group search shortcut is disabled");
    [defaults setVolatileDomain:@{CSGroupSearchButtonVisibleKey:@YES} forName:NSArgumentDomain];
    host=[Host new]; host.adapter=List(); a=host.adapter; a.controller=host;
    a.sourceSections=@[@[Row(0,@"account-A",CSGroupRowCategoryPrivate)]]; [a refresh];
    host.nativeCall=^(Host *owner,NSString *selector) {
        if ([selector isEqual:@"showSearchBar:"]) { owner.isSearching=YES; [owner viewWillDisappear:YES]; }
        else if ([selector isEqual:@"viewWillAppear:"]) [owner setSearchBarToTableHeaderView];
        else if ([selector isEqual:@"setSearchBarToTableHeaderView"]) owner.adapter.table.tableHeaderView=owner.adapter.nativeHeader;
    };
    [host onSearchButtonTapped]; account=@"B";
    Check(![a keepsGroupHeaderDuringSearch],@"quick-search backing-header ownership cannot cross accounts while suspended");
    a.sourceSections=@[@[Row(0,@"account-B",CSGroupRowCategoryPrivate)]];
    [host viewWillAppear:YES];
    Check(!a.searchChromeVisible && DisplayedHeader(a)==a.nativeHeader && !a.projecting,
        @"account change releases the old quick-search group before native return is displayed");
    host.isSearching=NO; [host cancelSearch];
    Check([a.preferences.accountID isEqual:@"B"] && [DisplayedNames(a) isEqual:@[@"account-B"]],
        @"completed quick search republishes only the current account's group");
    account=@"A";

    // Replay the production refresh, including its real projection decisions.
    // The native source deliberately contains a protected private chat and a
    // group chat so switching to All, or dropping privacy, changes visible rows.
    privacyEnabled=YES; hiddenNames=[NSSet setWithObject:@"hidden"];
    host=[Host new]; host.adapter=List(); a=host.adapter; a.controller=host;
    a.sourceSections=@[@[Row(0,@"ordinary",CSGroupRowCategoryPrivate),Row(1,@"hidden",CSGroupRowCategoryPrivate),Row(2,@"group",CSGroupRowCategoryGroup)]];
    [a refresh]; a.table.tracking=YES; NSUInteger previewPublications=a.publications;
    [a refresh];
    Check(a.publications==previewPublications,@"ordinary tracking still blocks real compatibility publication outside preview preparation");
    a.preparingPagePreview=YES;a.pagePreviewTabID=@"preset_1";a.pageTransitionContext=@{@"source":@"preset_2"};
    [a refresh];
    Check([a.publishedTabID isEqual:@"preset_1"] && [DisplayedNames(a) isEqual:@[@"group"]],@"transient preview renders actual neighboring group rows while horizontal tracking continues");
    Check([a.preferences.selectedTabID isEqual:@"preset_2"] && [a.chrome.selectedTabID isEqual:@"preset_2"],@"actual target publication preserves saved source selection and indicator ownership");
    a.pagePreviewTabID=nil;[a refresh];
    Check([a.publishedTabID isEqual:@"preset_2"] && [DisplayedNames(a) isEqual:@[@"ordinary"]] && [a.preferences.selectedTabID isEqual:@"preset_2"],@"clearing transient preview republishes the private source with privacy filtering intact");
    host=[Host new]; host.adapter=List(); a=host.adapter; a.controller=host;
    a.sourceSections=@[@[Row(0,@"ordinary",CSGroupRowCategoryPrivate), Row(1,@"hidden",CSGroupRowCategoryPrivate), Row(2,@"group",CSGroupRowCategoryGroup)]];
    [a refresh];
    Check([a.publishedTabID isEqual:@"preset_2"] && [DisplayedNames(a) isEqual:@[@"ordinary"]],@"private-group baseline filters protected sessions before search");
    CSGroupProjection *beforeSearch=a.projection; NSUInteger publications=a.publications;
    UIView *searchHeader=a.table.tableHeaderView;
    host.isSearching=YES; [host onSearch]; [host setSearchBarActive:YES];
    Check(a.projection==beforeSearch && a.publications==publications && a.projecting,@"search entry keeps the selected group projection when close friends are enabled");
    Check([a.chrome.selectedTabID isEqual:@"preset_2"] && [a.publishedTabID isEqual:@"preset_2"] && a.chromeVisible,@"entry retains selected tab and navigation-title ownership");
    Check(a.table.tableHeaderView==searchHeader && [DisplayedNames(a) isEqual:@[@"ordinary"]],@"search transition never paints All rows under the retained group header");
    // A privacy change must rebuild the group, not freeze a stale visible friend.
    hiddenNames=[NSSet setWithObjects:@"ordinary",@"hidden",nil]; a.privacyRefreshPending=YES;
    [a refresh];
    Check(a.projecting && !a.table.hidden && !a.privacyRefreshPending && DisplayedNames(a).count==0,@"locking another friend during search republishes a safely filtered group");
    Check([a.publishedTabID isEqual:@"preset_2"] && [a.chrome.selectedTabID isEqual:@"preset_2"] && a.chromeVisible,@"privacy refresh retains the group selection and title behind search");
    privacyEnabled=NO; a.privacyRefreshPending=YES; [a refresh];
    Check(a.projecting && [DisplayedNames(a) isEqual:@[@"ordinary",@"hidden"]] && [a.publishedTabID isEqual:@"preset_2"],@"unlock during search restores only the selected group's rows");
    beforeSearch=a.projection; [a refresh];
    Check(a.projection==beforeSearch && a.table.tableHeaderView==searchHeader,@"ordinary search refresh also preserves the group backing view");
    // WeChat can begin its return while isSearching still reports YES.
    a.presentationSuspended=YES; [a refresh]; a.presentationSuspended=NO; [a refresh];
    Check([a.publishedTabID isEqual:@"preset_2"] && a.projecting && a.table.tableHeaderView==searchHeader,@"early return frame keeps the group before native search state resets");
    host.isSearching=NO; [host cancelSearch]; [host onFTSSearchEnd]; [host setSearchBarActive:NO];
    Check([a.publishedTabID isEqual:@"preset_2"] && a.chromeVisible && !a.searching && !a.searchChromeVisible && [DisplayedNames(a) isEqual:@[@"ordinary",@"hidden"]],@"completed cancellation returns directly to the original group");
    Check(a.chrome.userInteractionEnabled && a.table.tableHeaderView==searchHeader,@"return restores interaction without replacing the group header");
    // Result navigation is still allowed to resolve global native coordinates.
    privacyEnabled=YES; hiddenNames=[NSSet setWithObject:@"hidden"];
    host.isSearching=YES; [host onSearch]; a.nativePresentation=YES; [a refresh];
    Check([a.publishedTabID isEqual:@"preset_0"] && [DisplayedNames(a) isEqual:@[@"ordinary",@"group"]],@"explicit global result navigation retains native All coordinates with privacy filtering");
    Check([a.preferences.selectedTabID isEqual:@"preset_2"],@"temporary result navigation never changes the stored group selection");
    account=@"B"; [a refresh];
    Check(!a.searchChromeVisible && a.table.tableHeaderView==a.nativeHeader && [a.preferences.accountID isEqual:@"B"],@"account changes discard the old search backing header before republishing");
    account=@"A";
    // Same real refresh/projection chain as the switcher: selected group and its
    // header survive, private rows are removed while the ordinary row remains.
    host.isSearching=NO; a.nativePresentation=NO; privacyEnabled=NO; [a refresh];
    UIView *switcherHeader=a.table.tableHeaderView;
    Check([DisplayedNames(a) isEqual:@[@"ordinary",@"hidden"]],@"switcher baseline contains ordinary and revealed private rows");
    appActive=NO; privacyEnabled=YES; a.privacyRefreshPending=YES; [a refresh];
    Check([DisplayedNames(a) isEqual:@[@"ordinary"]] && !a.table.hidden,@"inactive privacy publication removes only private row before switcher snapshot");
    Check(a.table.tableHeaderView==switcherHeader && a.chromeVisible && [a.publishedTabID isEqual:@"preset_2"],@"switcher privacy publication preserves group header and selection");
    publications=a.publications; [a refresh];
    Check(a.publications==publications,@"ordinary inactive publications remain deferred after privacy settles");
    UIView *inactiveHeader=DisplayedHeader(host.adapter);
    host.adapter.table.tableHeaderView=nil; [host.adapter layout];
    Check(DisplayedHeader(host.adapter)==inactiveHeader && !host.adapter.nativeHeader,
        @"inactive application records the native header change without publishing it");
    fprintf(stdout,"Group search: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
