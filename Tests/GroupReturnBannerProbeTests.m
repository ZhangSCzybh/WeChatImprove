// HOST-ONLY probe. Explicit synthetic inputs are logged; their order is not
// evidence of WeChat device behavior. Production refresh/header/publication and
// NativeEvent attribution are replayed against counted UIKit/native doubles.
// Native evidence: getBanner: returns one shared UIView per banner; addSubview:
// transfers that view to the latest Header cell. This is not a device frame test.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import <math.h>
#pragma clang diagnostic ignored "-Wunused-parameter"
#import "CSGroupProjection.h"
#import "CSGroupIndexScope.h"
#import "WESessionTabItem.h"

typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static const NSInteger UITableViewRowAnimationNone=0,UITableViewCellStyleDefault=0,UITableViewCellSelectionStyleNone=0;
static NSString *probeScenario=@"initialization",*probePhase=@"setup";
static NSUInteger probeSequence,viewSequence;
static void Emit(NSString *kind,NSDictionary *fields) {
    NSMutableDictionary *event=[fields mutableCopy] ?: [NSMutableDictionary dictionary];event[@"kind"]=kind;
    event[@"scenario"]=probeScenario;event[@"phase"]=probePhase;event[@"sequence"]=@(++probeSequence);event[@"evidence"]=@"host-controlled";
    NSData *data=[NSJSONSerialization dataWithJSONObject:event options:NSJSONWritingSortedKeys error:NULL];
    printf("%s\n",[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] UTF8String]);
}
@class CSGroupListAdapter,LaunchHost;
static NSArray *ProbeSourceSections(LaunchHost *host);
@interface NSIndexPath (LaunchRows)
@property(nonatomic,readonly) NSInteger row,section;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (LaunchRows)
- (NSInteger)row { return (NSInteger)[self indexAtPosition:1]; }
- (NSInteger)section { return (NSInteger)[self indexAtPosition:0]; }
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
@property(nonatomic) NSUInteger viewID,probeAdds,probeRemoves,probeSuperviewChanges;
@property(nonatomic,copy) NSString *probeName,*renderedValue;
@property(nonatomic) BOOL hidden,userInteractionEnabled;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) NSMutableArray<UIView *> *subviews;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
- (BOOL)isDescendantOfView:(UIView *)parent;
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) _subviews=[NSMutableArray array];self.viewID=++viewSequence; return self; }
- (void)addSubview:(UIView *)view {
    NSUInteger previous=view.superview.viewID;[view removeFromSuperview];[self.subviews addObject:view];view.superview=self;
    if([view.probeName hasPrefix:@"banner-"]) {view.probeAdds++;view.probeSuperviewChanges++;Emit(@"shared-banner-add",@{@"banner":view.probeName,@"previousSuperview":@(previous),@"superview":@(self.viewID)});}
}
- (void)removeFromSuperview {
    if(self.superview && [self.probeName hasPrefix:@"banner-"]) {self.probeRemoves++;self.probeSuperviewChanges++;Emit(@"shared-banner-remove",@{@"banner":self.probeName,@"previousSuperview":@(self.superview.viewID),@"superview":@0});}
    [self.superview.subviews removeObjectIdenticalTo:self];self.superview=nil;
}
- (BOOL)isDescendantOfView:(UIView *)parent { for(UIView *view=self;view;view=view.superview)if(view==parent)return YES;return NO; }
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
@property(nonatomic) CGSize contentSize;
@property(nonatomic) NSUInteger offsetWrites,publicationRequests,deliveryRequests,publishHeaderCalls,adapterLayouts;
@property(nonatomic,strong) NSMutableArray *offsetTrace,*rowReloadPaths,*restoreTrace,*publicationTrace;
@property(nonatomic,strong) NSMutableDictionary *deliveryByRow;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) double decelerationRate;
@property(nonatomic,strong) UIView *tableHeaderView;
@property(nonatomic,copy) NSArray<NSIndexPath *> *indexPathsForVisibleRows;
@property(nonatomic,strong) NSMutableArray<NSString *> *events;
@property(nonatomic,strong) NSArray<UITableViewCell *> *cells,*retiredCells,*initialCells;
@property(nonatomic) BOOL needsCells,reenterHeader;
@property(nonatomic) NSUInteger reloads,rowReloads,layouts,headerWrites,blankRetiredContainers;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path;
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
@property(nonatomic) BOOL allNativeCallsScoped,hostMutatesReturnViewport,hostReplacesNativeHeader,hostInjectsUnattributedActiveNotification;
@property(nonatomic) NSUInteger friendUnread;
@property(nonatomic,strong) NSArray<NSString *> *businessSourceValues;
@property(nonatomic,strong) NSMutableDictionary<NSString *,NSNumber *> *headerClosingCalls;
- (void)onActiveUsrNameChange:(id)oldName curUsrName:(id)newName;
- (void)hostActiveUserChanged:(id)oldName newName:(id)newName;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidLayoutSubviews;
- (void)initTableHeaderView;
- (void)setSearchBarToTableHeaderView;
- (void)hostAppearance:(NSString *)callback;
- (void)hostHeaderClosing:(NSString *)callback;
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)path;
@end
static NSString *account=@"launch-account";
static LaunchPolicy *policy;
static char CellRowKey,PresentationSuspendedKey;
static BOOL CSGroupApplicationActive(void) { return YES; }
static BOOL CSGroupPrivacyActive(void) { return NO; }
static NSString *CSGroupCurrentAccountID(void) { return account; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return 1; }
static LaunchPolicy *CSCloseFriendCurrentSnapshot(void) { return policy; }
static BOOL CSGroupIsFoldedController(id owner) { (void)owner;return NO; }
static BOOL Option(NSString *suffix) { return [suffix isEqual:@"enabled"]; }
static id CSGroupReadObject(id owner,NSString *key) { @try { return [owner valueForKey:key]; } @catch(__unused NSException *error) {return nil;} }
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
@property(nonatomic,strong) NSMutableArray *nativeChangeIdentityStack;
@property(nonatomic,copy) NSSet *nativeChangeUserNames;
@property(nonatomic,copy) NSDictionary *presentationViewport;
@property(nonatomic) NSUInteger modelRevision;
@property(nonatomic) BOOL coalescedDispatchPending;
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
+ (instancetype)adapterForTable:(id)table;
+ (instancetype)adapterForController:(id)controller;
+ (void)attachToController:(id)controller;
+ (void)layoutForController:(id)controller;
- (void)probe_layoutBody;
- (void)probe_publishHeaderBody:(UIView *)header;
- (UITableViewCell *)probe_cellBody:(NSIndexPath *)path target:(id)target;
- (void)probe_restoreAnchorBody;
- (void)restoreAnchor;
- (void)restoreScrollHeight:(CGFloat)height;
- (NSNumber *)presentationScrollHeight;
- (void)beginNativeChange;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind sessionUserNames:(NSSet *)names;
- (void)endNativeChange;
- (void)endNativeChangeCoalesced:(BOOL)coalesced;
- (void)requestCoalescedRefresh;
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced;
- (void)invalidateNativeSnapshot;
- (void)recordRefreshReason:(NSString *)reason;
- (void)setNativeTableHeaderView:(UIView *)header;
- (void)refresh;
- (BOOL)isActive;
- (void)probe_publishProjectionBody:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous changes:(CSGroupChangeKind)changes contentUserNames:(NSSet *)names contentIdentityKnown:(BOOL)known previouslyProjecting:(BOOL)previouslyProjecting;
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
#include "GroupReturnBannerProbeBodies.h"
+ (instancetype)adapterForTable:(id)table { return [table adapter]; }
+ (instancetype)adapterForController:(id)controller { return [(LaunchHost *)controller m_tableView].adapter; }
+ (void)attachToController:(id)controller { CSGroupListAdapter *a=[self adapterForController:controller];if(a.dirty || !a.preferences)[a refresh];[a layout]; }
+ (void)layoutForController:(id)controller { [[self adapterForController:controller] layout]; }
- (void)layout { self.table.adapterLayouts++;[self probe_layoutBody]; }
- (void)publishHeader:(UIView *)header { self.table.publishHeaderCalls++;Emit(@"publish-header",@{@"requestedView":@(header.viewID),@"installedView":@(self.table.tableHeaderView.viewID)});[self probe_publishHeaderBody:header]; }
- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target { self.table.deliveryRequests++;self.table.deliveryByRow[@(path.row)]=@([self.table.deliveryByRow[@(path.row)] unsignedIntegerValue]+1);Emit(@"adapter-cell-delivery",@{@"section":@(path.section),@"row":@(path.row)});return [self probe_cellBody:path target:target]; }
- (void)restoreAnchor { CGFloat before=self.table.contentOffset.y;Emit(@"restore-anchor-enter",@{@"offset":@(before),@"insetTop":@(self.table.adjustedContentInset.top)});[self probe_restoreAnchorBody];NSDictionary *entry=@{@"before":@(before),@"after":@(self.table.contentOffset.y),@"insetTop":@(self.table.adjustedContentInset.top)};[self.table.restoreTrace addObject:entry];Emit(@"restore-anchor-exit",entry); }
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous changes:(CSGroupChangeKind)changes contentUserNames:(NSSet *)names contentIdentityKnown:(BOOL)known previouslyProjecting:(BOOL)previouslyProjecting {
    self.table.publicationRequests++;
    NSDictionary *entry=@{@"changes":@(changes),@"contentIdentityKnown":@(known),@"contentUserNamesCount":@(names.count),@"contentUserNames":names.allObjects ?: @[],@"previouslyProjecting":@(previouslyProjecting)};
    [self.table.publicationTrace addObject:entry];Emit(@"publication-enter",entry);
    [self probe_publishProjectionBody:projection previous:previous changes:changes contentUserNames:names contentIdentityKnown:known previouslyProjecting:previouslyProjecting];
}
- (void)invalidateNativeSnapshot { self.modelRevision++; }
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced { (void)coalesced; }
- (void)recordRefreshReason:(NSString *)reason { Emit(@"native-event-reason",@{@"reason":reason}); }
- (void)requestRecovery { [NSException raise:@"UnexpectedRecovery" format:@"valid banner row must remain resolvable"]; }
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
- (BOOL)groupPanMoving { return NO; }
- (NSUInteger)nativeMenuState { return 0; }
- (void)reconcileDeletedSwipeRow {}
- (void)scheduleRefresh {}
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay { Emit(@"production-refresh-event",@{@"event":event,@"delay":@(delay),@"pendingChanges":@(self.pendingChanges),@"contentUnattributed":@(self.pendingContentUnattributed),@"contentUserNames":self.pendingContentUserNames.allObjects ?: @[]}); }
- (void)installProxies {}
- (void)refreshNavigationTitle {}
- (void)ensureChrome { if (!self.chrome) self.chrome=[LaunchChrome new]; }
- (NSArray *)nativeSectionsForAccount:(NSString *)value { (void)value;return ProbeSourceSections(self.controller); }
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)value {
    return [[CSGroupProjection alloc] initWithSections:sections tabs:tabs selectedTabID:selected filterDuplicates:NO accountID:value previousProjection:self.projection];
}
- (void)shieldVisiblePrivateRows {}
- (void)applyPendingScrollToTop {}
- (void)requestTabBadgeSourceRefresh {}
- (BOOL)keepsGroupHeaderDuringSearch { return NO; }
- (void)updateGroupGestureAvailability {}
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row { return row.nativePath; }
@end
static CSGroupListAdapter *Adapter(id owner) { return [CSGroupListAdapter adapterForController:owner]; }
#include "GroupReturnBannerEvents.h"
#include "GroupReturnBannerHeaderHook.h"
@implementation LaunchHost
#include "GroupReturnBannerHostHooks.h"
- (void)hostActiveUserChanged:(id)oldName newName:(id)newName {
    (void)oldName;(void)newName;
    // Explicit host source mutation within the real hook's original boundary.
    // Its nested table invalidation follows the production native attribution.
    self.friendUnread=0;[self.m_tableView.adapter requestRefresh];
    if(self.hostInjectsUnattributedActiveNotification) {
        Emit(@"host-inject-nested-notification",@{@"subject":NSNull.null,@"kind":@(CSGroupChangeContent),@"businessSourceChanges":@YES});
        NativeNotification(self,CSGroupChangeContent,nil,@"host.nested-real-unattributed-content",^{ self.businessSourceValues=@[@"nested-favorite-updated",@"nested-login-updated"]; });
    }
    Emit(@"host-original-active-user-changed",@{@"sourceUnreadBefore":@9,@"sourceUnreadAfter":@0,@"nestedRequestRefresh":@YES});
}
- (void)hostAppearance:(NSString *)callback {
    Emit(@"host-original-appearance",@{@"callback":callback});
    if([callback isEqual:@"viewWillAppear"] && self.hostMutatesReturnViewport) {
        self.m_tableView.adjustedContentInset=(UIEdgeInsets){140,0,0,0};self.m_tableView.contentOffset=CGPointMake(0,-25);
        Emit(@"host-input-native-viewport-change",@{@"offset":@(-25),@"insetTop":@140});
    }
}
- (void)hostHeaderClosing:(NSString *)callback {
    self.headerClosingCalls[callback]=@([self.headerClosingCalls[callback] unsignedIntegerValue]+1);
    Emit(@"host-original-header-closing",@{@"callback":callback});
    if([callback isEqual:@"initTableHeaderView"] || [callback isEqual:@"setSearchBarToTableHeaderView"]) {
        UIView *header=self.m_tableView.adapter.nativeHeader;
        if(self.hostReplacesNativeHeader && [callback isEqual:@"initTableHeaderView"]) {header=[UIView new];header.frame=CGRectMake(0,0,320,32);}
        self.m_tableView.tableHeaderView=header;
    }
}
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)path {
    self.allNativeCallsScoped &= CSGroupUsesNativeIndices(table);
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"Header"];
    NSUInteger row=[path indexAtPosition:1];
    if (row<self.banners.count) {
        self.nativeBannerCalls++;Emit(@"host-native-banner-construct-configure",@{@"row":@(row),@"sourceValue":self.businessSourceValues[row]});self.banners[row].renderedValue=self.businessSourceValues[row];self.bannerCallsByRow[@(row)]=@([self.bannerCallsByRow[@(row)] unsignedIntegerValue]+1);
        [cell.contentView addSubview:self.banners[row]];
    }
    else { self.nativeChatCalls++;cell.textLabel.text=@"ordinary chat";Emit(@"host-native-session-construct",@{@"row":@(row),@"unread":@(self.friendUnread)}); }
    return cell;
}
@end
@implementation UITableView
- (void)setContentOffset:(CGPoint)offset { _contentOffset=offset;self.offsetWrites++;if(!self.offsetTrace)self.offsetTrace=[NSMutableArray array];[self.offsetTrace addObject:@(offset.y)];Emit(@"offset-write",@{@"y":@(offset.y),@"insetTop":@(self.adjustedContentInset.top)}); }
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated { (void)animated;self.contentOffset=offset; }
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path { return CGRectMake(0,80+path.row*78,320,78); }
- (void)materialize {
    if (self.cells && !self.needsCells) return;
    NSMutableArray *next=[NSMutableArray array];
    for (NSIndexPath *path in self.indexPathsForVisibleRows)
        [next addObject:[self.adapter cellForDisplayPath:path target:self.host]];
    self.cells=next;if (!self.initialCells) self.initialCells=next;self.needsCells=NO;
    for (UITableViewCell *old in self.retiredCells) if (!old.contentView.subviews.count && !old.textLabel.text.length) self.blankRetiredContainers++;
}
- (void)setTableHeaderView:(UIView *)header {
    ProbeHeaderSetter(self,header,^(UIView *published) {
        self->_tableHeaderView=published;self.headerWrites++;[self.events addObject:@"header"];
        Emit(@"host-ui-header-write",@{@"view":@(published.viewID),@"reentrant":@(self.reenterHeader)});
        if(self.reenterHeader)[self materialize];
    });
}
- (void)reloadData {
    NSCAssert(!CSGroupUsesNativeIndices(self),@"table operations use display coordinates");
    self.reloads++;[self.events addObject:@"reload"];Emit(@"host-table-full-reload",@{});
    self.retiredCells=self.cells;self.cells=nil;self.needsCells=YES;
}
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(NSInteger)animation {
    (void)animation;self.rowReloads++;[self.events addObject:@"rows"];NSMutableArray *loggedPaths=[NSMutableArray array];for(NSIndexPath *p in paths)[loggedPaths addObject:@[@(p.section),@(p.row)]];[self.rowReloadPaths addObject:loggedPaths];Emit(@"host-table-row-reload",@{@"paths":loggedPaths});
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
static void Check(BOOL value,NSString *message) {
    checks++;Emit(@"assertion",@{@"message":message,@"passed":@(value)});
    if(!value){failures++;fprintf(stderr,"FAIL: %s / %s\n",probeScenario.UTF8String,message.UTF8String);}
}
static CSGroupRow *Row(NSUInteger index,NSString *name,CSGroupRowCategory category,NSUInteger unread) {
    return [[CSGroupRow alloc] initWithNativePath:Path(index) userName:name
        kind:name.length ? CSGroupRowKindSession : CSGroupRowKindBusiness category:category top:NO unreadCount:unread redDot:NO];
}
static NSArray *ProbeSourceSections(LaunchHost *host) {
    // Explicit host native-snapshot boundary: same coarse business-row metadata
    // as the production bridge. Real banner text is absent from CSGroupRow.
    return @[@[Row(0,nil,CSGroupRowCategoryUnknown,0),Row(1,nil,CSGroupRowCategoryUnknown,0),Row(2,@"friend",CSGroupRowCategoryPrivate,host.friendUnread)]];
}
static CSGroupListAdapter *List(BOOL reenter) {
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=[LaunchHost new];a.table=[UITableView new];
    a.controller.m_tableView=a.table;a.table.adapter=a;a.table.host=a.controller;
    a.table.bounds=CGRectMake(0,0,320,640);a.table.contentSize=CGSizeMake(320,1600);
    a.table.adjustedContentInset=(UIEdgeInsets){100,0,0,0};
    a.table.events=[NSMutableArray array];a.table.offsetTrace=[NSMutableArray array];a.table.rowReloadPaths=[NSMutableArray array];
    a.table.restoreTrace=[NSMutableArray array];a.table.publicationTrace=[NSMutableArray array];a.table.deliveryByRow=[NSMutableDictionary dictionary];a.table.contentOffset=CGPointMake(0,20);
    a.table.reenterHeader=reenter;a.table.indexPathsForVisibleRows=@[Path(0),Path(1),Path(2)];
    a.controller.banners=@[[UIView new],[UIView new]];a.controller.banners[0].probeName=@"banner-favorite";a.controller.banners[1].probeName=@"banner-login";
    a.controller.businessSourceValues=@[@"favorite-initial",@"logged-in-Mac"];
    a.controller.friendUnread=9;a.controller.allNativeCallsScoped=YES;
    a.controller.bannerCallsByRow=[NSMutableDictionary dictionary];a.controller.headerClosingCalls=[NSMutableDictionary dictionary];
    a.nativeHeader=[UIView new];a.nativeHeader.frame=CGRectMake(0,0,320,32);
    a.nativeActions=[NSMutableArray array];a.completions=[NSMutableArray array];a.prefetchedPaths=[NSMutableSet set];
    a.proxies=[NSMutableDictionary dictionary];a.pan=[Gesture new];a.listPan=[Gesture new];a.anchors=[NSMutableDictionary dictionary];
    return a;
}
static BOOL ContentComplete(CSGroupListAdapter *a) {
    return a.table.cells.count==3 && a.table.cells[0].contentView.subviews.count==1 && a.table.cells[0].contentView.subviews[0]==a.controller.banners[0] && a.table.cells[1].contentView.subviews.count==1 && a.table.cells[1].contentView.subviews[0]==a.controller.banners[1];
}
static NSDictionary *Counters(CSGroupListAdapter *a) {
    NSMutableArray *banners=[NSMutableArray array];
    for(NSUInteger row=0;row<2;row++) {
        UIView *v=a.controller.banners[row];
        [banners addObject:@{@"row":@(row),@"view":@(v.viewID),@"adapterDeliveries":a.table.deliveryByRow[@(row)] ?: @0,
            @"hostNativeConstructConfigureCalls":a.controller.bannerCallsByRow[@(row)] ?: @0,@"adds":@(v.probeAdds),@"removes":@(v.probeRemoves),
            @"superviewChanges":@(v.probeSuperviewChanges),@"currentSuperview":@(v.superview.viewID),@"renderedValue":v.renderedValue ?: @""}];
    }
    return @{@"fullReloads":@(a.table.reloads),@"rowReloadCalls":@(a.table.rowReloads),@"rowReloadPaths":a.table.rowReloadPaths,
        @"banners":banners,@"adapterDeliveryRequests":@(a.table.deliveryRequests),@"publicationRequests":@(a.table.publicationRequests),
        @"publicationTrace":a.table.publicationTrace,@"headerClosuresRequestedByHost":a.controller.headerClosingCalls,
        @"adapterLayoutCalls":@(a.table.adapterLayouts),@"tableLayoutIfNeededCalls":@(a.table.layouts),@"publishHeaderCalls":@(a.table.publishHeaderCalls),
        @"actualHeaderWrites":@(a.table.headerWrites),@"offsetWrites":@(a.table.offsetWrites),@"offsetTrace":a.table.offsetTrace,
        @"restoreAnchorTrace":a.table.restoreTrace,@"offset":@(a.table.contentOffset.y),@"insetTop":@(a.table.adjustedContentInset.top),
        @"blankRetiredContainers":@(a.table.blankRetiredContainers)};
}
static void ResetCounters(CSGroupListAdapter *a) {
    a.table.reloads=0;a.table.rowReloads=0;a.table.layouts=0;a.table.headerWrites=0;a.table.blankRetiredContainers=0;
    a.table.offsetWrites=0;a.table.publicationRequests=0;a.table.deliveryRequests=0;a.table.publishHeaderCalls=0;a.table.adapterLayouts=0;
    [a.table.events removeAllObjects];[a.table.offsetTrace removeAllObjects];[a.table.rowReloadPaths removeAllObjects];[a.table.deliveryByRow removeAllObjects];
    [a.table.restoreTrace removeAllObjects];[a.table.publicationTrace removeAllObjects];[a.controller.headerClosingCalls removeAllObjects];
    [a.controller.bannerCallsByRow removeAllObjects];a.controller.nativeBannerCalls=0;a.controller.nativeChatCalls=0;
    for(UIView *view in a.controller.banners) view.probeAdds=view.probeRemoves=view.probeSuperviewChanges=0;
}
static void Scenario(NSString *input,BOOL reenter,BOOL mutateViewport,BOOL closeHeaders) {
    probeScenario=[NSString stringWithFormat:@"%@/%@/%@/%@",input,reenter ? @"reentrant" : @"deferred",mutateViewport ? @"native-viewport-input" : @"stable-viewport",closeHeaders ? @"requested-header-closures" : @"no-header-input"];
    probePhase=@"initial";
    Emit(@"host-scenario-inputs",@{@"event":input,@"reentrantHeaderSetter":@(reenter),@"hostOriginalAppearanceMutatesViewport":@(mutateViewport),
        @"hostRequestsEachHeaderClosingOnce":@(closeHeaders),@"scheduler":@"No-op: appearance attachment consumes suspended dirty snapshot synchronously; no timer drain is simulated.",
        @"nativeBoundary":@"Synthetic snapshot and cell factory. Construct/configure share one measured host getter call; true device configure counts require runtime instrumentation."});
    CSGroupListAdapter *a=List(reenter);[a refresh];
    Check(a.isActive && a.projection.isValid,@"initial real projection is active and valid");
    Check(a.table.reloads==1 && a.table.rowReloads==0,@"initial publication performs its existing single full reload");
    for(NSUInteger row=0;row<2;row++) Check([a.controller.bannerCallsByRow[@(row)] unsignedIntegerValue]==1,@"initial business native construct/configure occurs once per row");
    Check(ContentComplete(a),@"initial business content complete");
    Emit(@"initial-counters",Counters(a));
    NSArray *initialParents=@[@(a.controller.banners[0].superview.viewID),@(a.controller.banners[1].superview.viewID)];
    ResetCounters(a);probePhase=@"departure-and-suspended-event";
    [a.controller viewWillDisappear:NO];[a.controller viewDidDisappear:NO];
    if([input isEqual:@"attributed-unread-clear"]) {
        Emit(@"host-inject-event",@{@"api":@"NativeEvent",@"subject":@"friend",@"kind":@(CSGroupChangeContent|CSGroupChangeUnread),@"sourceUnreadBefore":@9,@"sourceUnreadAfter":@0});
        NativeEvent(a.controller,CSGroupChangeContent|CSGroupChangeUnread,@"friend",@"host.attributed-unread-clear",NO,^{ a.controller.friendUnread=0;[a requestRefresh]; });
    } else if([input isEqual:@"unattributed-content"] || [input isEqual:@"business-content-change"]) {
        Emit(@"host-inject-event",@{@"api":@"NativeNotification",@"subject":NSNull.null,@"kind":@(CSGroupChangeContent),@"businessSourceChanges":@([input isEqual:@"business-content-change"])});
        NativeNotification(a.controller,CSGroupChangeContent,nil,@"host.unattributed-content",^{ if([input isEqual:@"business-content-change"])a.controller.businessSourceValues=@[@"favorite-updated",@"logged-in-Windows"]; });
    }
    probePhase=@"return";a.controller.hostMutatesReturnViewport=mutateViewport;
    [a.controller viewWillAppear:NO];
    if(closeHeaders) {
        Emit(@"host-request-header-closures",@{@"order":@[@"viewDidLayoutSubviews",@"initTableHeaderView",@"setSearchBarToTableHeaderView"],@"orderEvidence":@"host-input-only"});
        [a.controller viewDidLayoutSubviews];[a.controller initTableHeaderView];[a.controller setSearchBarToTableHeaderView];
    }
    [a.controller viewDidAppear:NO];
    Check(ContentComplete(a),@"return content complete");
    Check(a.table.reloads==0,@"return uses no full reload");
    Check(a.controller.allNativeCallsScoped,@"all host native cell getters execute under production native index scope");
    BOOL localized=[input isEqual:@"no-event"] || [input isEqual:@"attributed-unread-clear"];
    if(localized) {
        Check(a.controller.nativeBannerCalls==0,@"no-event or attributed chat change causes no additional banner native construct/configure");
        for(NSUInteger row=0;row<2;row++) {
            UIView *view=a.controller.banners[row];
            Check([a.table.deliveryByRow[@(row)] unsignedIntegerValue]==0,@"return does not deliver unchanged banner again after initial delivery");
            Check(view.superview.viewID==[initialParents[row] unsignedIntegerValue],@"return preserves initial banner superview identity");
            Check(view.probeAdds==0 && view.probeRemoves==0,@"return does not remount unchanged shared banner");
        }
        Check(a.table.rowReloads==([input isEqual:@"attributed-unread-clear"] ? 1UL : 0UL),@"only attributed changed chat causes one local row publication");
    } else {
        Check(a.table.rowReloads==1,@"true unattributed content uses one local publication");
        Check(a.controller.nativeBannerCalls==2,@"unattributed content preserves conservative native business refresh");
    }
    if([input isEqual:@"business-content-change"]) {
        Check([a.controller.banners[0].renderedValue isEqual:@"favorite-updated"],@"real source favorite change remains rendered");
        Check([a.controller.banners[1].renderedValue isEqual:@"logged-in-Windows"],@"real source login change remains rendered");
    }
    if(!mutateViewport) Check(a.table.offsetWrites==0 && fabs(a.table.contentOffset.y-20)<0.001,@"stable host viewport produces no intermediate offset writes or rebound");
    else Check(fabs(a.table.contentOffset.y-(-20))<0.001,@"host-injected inset/offset change restores retained height synchronously");
    Check(a.table.headerWrites==0,@"unchanged header closings produce zero actual UI header writes");
    NSMutableDictionary *summary=[Counters(a) mutableCopy];summary[@"initialBannerParents"]=initialParents;
    summary[@"returnBannerNativeConstructConfigureCalls"]=@(a.controller.nativeBannerCalls);summary[@"returnNativeChatCalls"]=@(a.controller.nativeChatCalls);
    Emit(@"return-counters",summary);
}
static void ReturnHeaderReentryScenario(void) {
    probeScenario=@"no-event/actual-return-header-setter-reentry/host-width-change";probePhase=@"initial";
    Emit(@"host-scenario-inputs",@{@"event":@"none",@"explicitHostInput":@"Change table width 320 to 321 before one viewDidLayoutSubviews, forcing production header publication and synchronous host setter reentry."});
    CSGroupListAdapter *a=List(YES);[a refresh];
    NSArray *initialParents=@[@(a.controller.banners[0].superview.viewID),@(a.controller.banners[1].superview.viewID)];
    ResetCounters(a);probePhase=@"departure";[a.controller viewWillDisappear:NO];[a.controller viewDidDisappear:NO];
    probePhase=@"return";[a.controller viewWillAppear:NO];
    Emit(@"host-input-table-width-change",@{@"before":@320,@"after":@321});a.table.bounds=CGRectMake(0,0,321,640);
    [a.controller viewDidLayoutSubviews];[a.controller viewDidAppear:NO];
    Check(a.table.headerWrites==1,@"host width change causes one actual header write and actual synchronous setter reentry");
    Check(a.table.reloads==0 && a.table.rowReloads==0,@"header setter reentry produces no return reload");
    Check(a.controller.nativeBannerCalls==0 && a.table.deliveryRequests==0,@"header setter reentry delivers no replacement business cells");
    Check(ContentComplete(a),@"header setter reentry preserves complete shared business content");
    for(NSUInteger row=0;row<2;row++) {
        UIView *view=a.controller.banners[row];
        Check(view.superview.viewID==[initialParents[row] unsignedIntegerValue] && view.probeAdds==0 && view.probeRemoves==0,@"actual return header reentry preserves banner superview with zero remounts");
    }
    Check(a.table.offsetWrites==0,@"actual return header reentry produces no offset write");
    NSMutableDictionary *summary=[Counters(a) mutableCopy];summary[@"initialBannerParents"]=initialParents;
    summary[@"returnBannerNativeConstructConfigureCalls"]=@(a.controller.nativeBannerCalls);summary[@"returnNativeChatCalls"]=@(a.controller.nativeChatCalls);Emit(@"return-counters",summary);
}
@interface ProbeIdentityObject : NSObject
@property(nonatomic,copy) NSString *m_nsUserName,*userName;
@end
@implementation ProbeIdentityObject @end
static void ActiveUserHookScenario(NSString *name,id oldName,id newName,NSSet *expectedNames,BOOL requireIdentity,BOOL nestedUnknown) {
    probeScenario=[@"active-user-hook/" stringByAppendingString:name];probePhase=@"initial";
    Emit(@"host-scenario-inputs",@{@"event":@"Exact extracted onActiveUsrNameChange:curUsrName: hook",@"inputLabel":name,@"oldArgumentPresent":@(oldName!=nil),
        @"newArgumentPresent":@(newName!=nil),@"businessSourceChanges":@(nestedUnknown),@"nestedUnattributedContentNotification":@(nestedUnknown),@"requireIdentityRegressionMode":@(requireIdentity),
        @"boundary":@"Host invokes this selector; no assertion that a natural phone return invokes it."});
    CSGroupListAdapter *a=List(NO);a.controller.hostInjectsUnattributedActiveNotification=nestedUnknown;[a refresh];
    Check(ContentComplete(a),@"active-user-hook scenario starts with complete business content");
    NSArray *initialParents=@[@(a.controller.banners[0].superview.viewID),@(a.controller.banners[1].superview.viewID)];
    ResetCounters(a);probePhase=@"departure-and-suspended-hook";[a.controller viewWillDisappear:NO];[a.controller viewDidDisappear:NO];
    [a.controller onActiveUsrNameChange:oldName curUsrName:newName];
    probePhase=@"return";[a.controller viewWillAppear:NO];[a.controller viewDidAppear:NO];
    Check(ContentComplete(a),@"exact active-user hook keeps complete content after return");
    Check(a.table.reloads==0,@"exact active-user hook causes no return full reload");
    Check(a.table.offsetWrites==0,@"exact active-user hook causes no intermediate offset writes or rebound");
    Check(a.table.headerWrites==0,@"exact active-user hook leaves installed header unchanged");
    NSDictionary *publication=a.table.publicationTrace.firstObject;
    if(expectedNames && requireIdentity && !nestedUnknown) {
        Check([publication[@"contentIdentityKnown"] boolValue],@"requirement: fully identified active-user event remains attributed before publication");
        Check([[NSSet setWithArray:publication[@"contentUserNames"] ?: @[]] isEqual:expectedNames],@"requirement: old and new active-user identities are both retained");
        for(NSUInteger row=0;row<2;row++) {
            UIView *view=a.controller.banners[row];
            Check([a.table.deliveryByRow[@(row)] unsignedIntegerValue]==0,@"requirement: known active-user event preserves one total initial banner delivery");
            Check(view.superview.viewID==[initialParents[row] unsignedIntegerValue],@"requirement: known active-user event preserves banner superview identity");
            Check(view.probeAdds==0 && view.probeRemoves==0,@"requirement: known active-user event never remounts unchanged banner");
        }
    }
    if(!expectedNames || nestedUnknown) {
        Check(![publication[@"contentIdentityKnown"] boolValue],@"missing or conflicting active-user identities retain conservative unknown attribution");
        Check(a.table.rowReloads==1 && a.controller.nativeBannerCalls==2,@"unknown active-user event retains conservative business content refresh");
    }
    if(nestedUnknown) {
        Check([a.controller.banners[0].renderedValue isEqual:@"nested-favorite-updated"],@"nested real unattributed content still renders changed favorite");
        Check([a.controller.banners[1].renderedValue isEqual:@"nested-login-updated"],@"nested real unattributed content still renders changed login");
    }
    NSMutableDictionary *summary=[Counters(a) mutableCopy];summary[@"initialBannerParents"]=initialParents;
    summary[@"expectedNamesForRequirement"]=expectedNames.allObjects ?: @[];summary[@"expectedNamesCount"]=@(expectedNames.count);
    summary[@"returnBannerNativeConstructConfigureCalls"]=@(a.controller.nativeBannerCalls);summary[@"returnNativeChatCalls"]=@(a.controller.nativeChatCalls);Emit(@"return-counters",summary);
}
int main(void) { @autoreleasepool {
    Emit(@"probe-boundary",@{@"deviceEvidence":@NO,@"productionMethods":@"Complete refresh/layout/publishHeader/cell/publication/viewport/native event attribution bodies extracted unchanged except five method names for entry observers.",
        @"stubbedBoundaries":@[@"CSGroupNativeBridge snapshot",@"UIKit cell factory and geometry",@"adapter attach admission",@"scheduler",@"native lifecycle callback order and body"],
        @"countsMeaning":@"Only this synthetic host input sequence; never observed phone callback or frame counts."});
    policy=[LaunchPolicy new];policy.accountID=account;policy.revision=1;
    for(NSString *input in @[@"no-event",@"attributed-unread-clear",@"unattributed-content",@"business-content-change"])
        for(NSNumber *reenter in @[@NO,@YES])for(NSNumber *viewport in @[@NO,@YES])for(NSNumber *closures in @[@NO,@YES])
            Scenario(input,reenter.boolValue,viewport.boolValue,closures.boolValue);
    ReturnHeaderReentryScenario();
    BOOL requireIdentity=getenv("PROBE_REQUIRE_ACTIVE_IDENTITY")!=NULL;
    ActiveUserHookScenario(@"valid-pair",@"friend",@"other",[NSSet setWithObjects:@"friend",@"other",nil],requireIdentity,NO);
    ActiveUserHookScenario(@"valid-old-nil-new",@"friend",nil,[NSSet setWithObject:@"friend"],requireIdentity,NO);
    ActiveUserHookScenario(@"nil-old-valid-new",nil,@"friend",[NSSet setWithObject:@"friend"],requireIdentity,NO);
    ActiveUserHookScenario(@"both-nil",nil,nil,nil,requireIdentity,NO);
    ProbeIdentityObject *conflict=[ProbeIdentityObject new];conflict.m_nsUserName=@"first";conflict.userName=@"second";
    ActiveUserHookScenario(@"conflicting-old-valid-new",conflict,@"friend",nil,requireIdentity,NO);
    ActiveUserHookScenario(@"valid-old-conflicting-new",@"friend",conflict,nil,requireIdentity,NO);
    ActiveUserHookScenario(@"empty-old-valid-new",@"",@"friend",nil,requireIdentity,NO);
    ActiveUserHookScenario(@"valid-old-empty-new",@"friend",@"",nil,requireIdentity,NO);
    ActiveUserHookScenario(@"null-old-valid-new",NSNull.null,@"friend",nil,requireIdentity,NO);
    ActiveUserHookScenario(@"valid-old-null-new",@"friend",NSNull.null,nil,requireIdentity,NO);
    ActiveUserHookScenario(@"same-identity-deduplicated",@"friend",@"friend",[NSSet setWithObject:@"friend"],requireIdentity,NO);
    ProbeIdentityObject *matching=[ProbeIdentityObject new];matching.m_nsUserName=@"friend";matching.userName=@"friend";
    ActiveUserHookScenario(@"matching-identity-object",matching,@"friend",[NSSet setWithObject:@"friend"],requireIdentity,NO);
    ActiveUserHookScenario(@"known-outer-real-unattributed-inner",@"friend",@"friend",[NSSet setWithObject:@"friend"],requireIdentity,YES);
    Emit(@"probe-result",@{@"checks":@(checks),@"failures":@(failures),@"scenarios":@46,@"requireIdentityMode":@(requireIdentity)});
    fprintf(stderr,"Group return banner HOST probe: %lu checks, %lu failures, 46 synthetic scenarios\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
