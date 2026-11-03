#import "CSGroupRefreshState.h"
#import <math.h>
typedef double UIScrollViewDecelerationRate;
@interface UITableViewCell:UIView
@property(nonatomic) BOOL hidden;
@property(nonatomic,strong) NSIndexPath *fixturePath;
@end
@implementation UITableViewCell @end
@interface UITableView:UIView
@property(nonatomic,strong) id dataSource,delegate,prefetchDataSource,tableHeaderView;
@property(nonatomic) double decelerationRate;
@property(nonatomic) BOOL tracking,dragging,decelerating,editing;
@property(nonatomic) NSUInteger reloads,layouts;
@property(nonatomic,strong) NSMutableArray<NSIndexPath *> *rowReloads;
@property(nonatomic,readonly) NSInteger numberOfSections;
@property(nonatomic,readonly) NSArray<NSIndexPath *> *indexPathsForVisibleRows;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)paths withRowAnimation:(NSInteger)animation;
@property(nonatomic,copy) NSArray<UITableViewCell *> *visibleCells;
@property(nonatomic,copy) void (^onReload)(void),(^onLayout)(void);
- (void)reloadData;
- (void)layoutIfNeeded;
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;
@end
static const NSInteger UITableViewRowAnimationNone=0;
@implementation UITableView
- (NSInteger)numberOfSections {return ((NSInteger(*)(id,SEL,id))objc_msgSend)(self.dataSource,@selector(numberOfSectionsInTableView:),self);}
- (NSInteger)numberOfRowsInSection:(NSInteger)section {return ((NSInteger(*)(id,SEL,id,NSInteger))objc_msgSend)(self.dataSource,@selector(tableView:numberOfRowsInSection:),self,section);}
- (NSArray *)indexPathsForVisibleRows {NSMutableArray *paths=[NSMutableArray array];for(UITableViewCell *cell in self.visibleCells)if(cell.fixturePath)[paths addObject:cell.fixturePath];return paths;}
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)paths withRowAnimation:(NSInteger)animation {(void)animation;if(!self.rowReloads)self.rowReloads=[NSMutableArray array];[self.rowReloads addObjectsFromArray:paths];}
- (void)reloadData {self.reloads++;void(^callback)(void)=self.onReload;self.onReload=nil;if(callback)callback();}
- (void)layoutIfNeeded {self.layouts++;void(^callback)(void)=self.onLayout;self.onLayout=nil;if(callback)callback();}
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell {return cell.fixturePath;}
@end
@interface UIPanGestureRecognizer:NSObject @end
@implementation UIPanGestureRecognizer @end
@interface WESessionTabContainerView:NSObject
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic,strong) NSMutableDictionary *counts;
- (void)refreshAppearance;
- (void)updateTabs:(NSArray *)tabs;
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)dot forTabIndex:(NSInteger)index;
@end
@implementation WESessionTabContainerView
- (instancetype)init {if((self=[super init]))_counts=[NSMutableDictionary dictionary];return self;}
- (void)refreshAppearance {}
- (void)updateTabs:(NSArray *)tabs {(void)tabs;}
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)dot forTabIndex:(NSInteger)index {self.counts[@(index)]=@[@(count),@(dot)];}
@end
@interface CSCloseFriendListShield:NSObject
@property(nonatomic,strong) NSMutableArray *cells;
- (void)prepareForPublication;
- (void)shieldCell:(UITableViewCell *)cell;
@end
@implementation CSCloseFriendListShield
- (void)shieldCell:(UITableViewCell *)cell {if(!self.cells)self.cells=[NSMutableArray array];[self.cells addObject:cell];cell.hidden=YES;}
- (void)prepareForPublication {for(UITableViewCell *cell in self.cells)cell.hidden=NO;[self.cells removeAllObjects];}
@end
static BOOL FixtureActive=YES,FailPath;
static void (^OnBuild)(void);
static void (^OnAdapterLayout)(void);
static CSGroupRow *LastCoveredRow;
// Exercise the production metadata bridge against native selector shapes.
// The old fixture directly manufactured CSGroupRow arrays at this boundary.
@interface FixtureMainFrameLogic:NSObject
@property(nonatomic,copy) NSArray *fixtureSessions,*fixtureData;
@property(nonatomic) BOOL useManager;
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path;
- (id)getCellDataAtIndexPath:(NSIndexPath *)path;
@end
@implementation FixtureMainFrameLogic
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path {
    NSArray *sections=self.useManager ? @[Main.topSessions ?: @[],Main.normalSessions ?: @[]] : self.fixtureSessions;
    NSUInteger section=[path indexAtPosition:0],row=[path indexAtPosition:1];
    id value=section<sections.count && row<[sections[section] count] ? sections[section][row] : nil;
    return value==NSNull.null ? nil : value;
}
- (id)getCellDataAtIndexPath:(NSIndexPath *)path {
    NSUInteger section=[path indexAtPosition:0],row=[path indexAtPosition:1];
    return section<self.fixtureData.count && row<[self.fixtureData[section] count] ? self.fixtureData[section][row] : nil;
}
@end
@interface FixtureMainFrameDataSource:NSObject
@property(nonatomic,strong) FixtureMainFrameLogic *logic;
@property(nonatomic,copy) void (^onRows)(void);
@property(nonatomic,copy) void (^onSections)(void);
@property(nonatomic) NSUInteger countOverride;
- (NSInteger)numberOfSectionsInTableView:(id)table;
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section;
@end
@implementation FixtureMainFrameDataSource
- (NSInteger)numberOfSectionsInTableView:(id)table {
    (void)table;
    NSInteger count=self.logic.useManager ? 2 : self.logic.fixtureSessions.count;
    void(^callback)(void)=OnBuild;OnBuild=nil;if(callback)callback();
    if(self.onSections)self.onSections();
    return count;
}
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section {
    (void)table;
    NSArray *sections=self.logic.useManager ? @[Main.topSessions ?: @[],Main.normalSessions ?: @[]] : self.logic.fixtureSessions;
    NSInteger count=section>=0 && (NSUInteger)section<sections.count ? [sections[(NSUInteger)section] count] : 0;
    void(^callback)(void)=self.onRows;self.onRows=nil;if(callback)callback();
    return self.countOverride ? (NSInteger)self.countOverride : count;
}
@end
@interface NewMainFrameViewController (FixtureDataSource)
- (NSInteger)numberOfSectionsInTableView:(id)table;
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section;
@end
@implementation NewMainFrameViewController (FixtureDataSource)
- (NSInteger)numberOfSectionsInTableView:(id)table {return [(UITableView *)table dataSource] ? [[(UITableView *)table dataSource] numberOfSectionsInTableView:table] : 0;}
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section {return [(UITableView *)table dataSource] ? [[(UITableView *)table dataSource] tableView:table numberOfRowsInSection:section] : 0;}
@end
static BOOL CSGroupApplicationActive(void) {return FixtureActive;}
static BOOL CSGroupPrivacyActive(void) {return Policy.blocked || (Policy.enabled && !Policy.revealed && [Policy.options[@"hideSessions"] boolValue]);}
static BOOL Option(NSString *suffix) {return [Defaults boolForKey:[@"com.wechat.enhance.chat_group." stringByAppendingString:suffix]];}
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) {return [Policy hidesUserName:name surface:surface];}
static void CSCloseFriendUpdateSessionCover(id cell,CSGroupRow *row) {(void)cell;LastCoveredRow=row;}
static char AdapterKey,CellRowKey,PresentationSuspendedKey;
@class CSGroupListAdapter,CSGroupTableProxy;
static NSHashTable *Adapters(void) {static NSHashTable *a;if(!a)a=[NSHashTable weakObjectsHashTable];return a;}
#include "BadgeDecisionDeclaration.h"
#include "BadgeDecisionImplementation.h"
#include "AdapterDeclarations.h"
@interface CSGroupTableProxy:NSObject
@property(nonatomic,weak) CSGroupListAdapter *adapter;
@property(nonatomic,strong) id target;
@end
@implementation CSGroupTableProxy @end

// Deterministic scheduling clock: production method bodies are unchanged; only
// dispatch/time host calls are redirected while these bodies are compiled.
static NSTimeInterval FixtureNow=100;
static NSMutableArray *FixtureJobs;
static NSUInteger FixtureJobsEnqueued,FixtureJobsExecuted;
static BOOL FixturePanMoving;
static NSUInteger FixtureMenuState;
@interface FixtureProcessInfo:NSObject
+ (instancetype)processInfo;
- (double)systemUptime;
@end
@implementation FixtureProcessInfo
+ (instancetype)processInfo {static id clock;if(!clock)clock=[self new];return clock;}
- (double)systemUptime {return FixtureNow;}
@end
static int64_t FixtureTime(int64_t base,int64_t nanoseconds) {(void)base;return (int64_t)(FixtureNow*NSEC_PER_SEC)+nanoseconds;}
static void FixtureAfter(int64_t due,dispatch_queue_t queue,dispatch_block_t block) {(void)queue;if(!FixtureJobs)FixtureJobs=[NSMutableArray array];FixtureJobsEnqueued++;[FixtureJobs addObject:@{@"due":@((double)due/NSEC_PER_SEC),@"block":[block copy]}];}
static void FixtureAsync(dispatch_queue_t queue,dispatch_block_t block) {FixtureAfter(FixtureTime(0,0),queue,block);}
static NSUInteger DrainFixtureJobs(NSTimeInterval delta,NSUInteger budget) {
    FixtureNow+=delta;NSUInteger executed=0;
    while(executed<budget) {
        NSDictionary *next=nil;
        for(NSDictionary *job in FixtureJobs)if([job[@"due"] doubleValue]<=FixtureNow && (!next || [job[@"due"] doubleValue]<[next[@"due"] doubleValue]))next=job;
        if(!next)return executed;[FixtureJobs removeObjectIdenticalTo:next];FixtureJobsExecuted++;executed++;((dispatch_block_t)next[@"block"])();
    }return executed;
}
static void Advance(NSTimeInterval delta) {
    NSUInteger executed=DrainFixtureJobs(delta,100);if(executed>=100)CHECK(NO);
}
@implementation CSGroupListAdapter
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
- (BOOL)groupPanMoving {return FixturePanMoving;}
- (NSUInteger)nativeMenuState {return FixtureMenuState;}
- (void)updateGroupGestureAvailability {}
- (void)saveAnchor {}
- (void)restoreAnchor {}
- (void)ensureChrome {if(!self.chrome)self.chrome=[WESessionTabContainerView new];}
- (void)layout {void(^callback)(void)=OnAdapterLayout;OnAdapterLayout=nil;if(callback)callback();}
- (void)refreshNavigationTitle {}
- (void)applyPendingScrollToTop {}
- (void)detach {[Adapters() removeObject:self];}
- (void)nativeSessionModelChanged:(NSNotification *)note {if(self.fixtureRealNotifications)[self productionNativeSessionModelChanged:note];}
- (void)scheduleNativeRecoveryForKey:(NSArray *)key {self.fixtureRecoveries++;if(self.fixtureRealRecovery)[self productionScheduleNativeRecoveryForKey:key];}
- (void)invalidateNativeSnapshot {self.modelRevision++;}
- (void)requestTabBadgeSourceRefresh {self.fixtureBadgeRequests++;}
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced {(void)coalesced;self.fixtureBadgeRequests++;}
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row {
    if(FailPath)return nil;
    return CSGroupResolveNativeRowPath(self.controller,row,NO);
}
- (void)refresh {
    self.fixtureRefreshes++;
    if(self.fixtureScheduleOnly) {
        self.publishing=YES;self.dirty=NO;[self consumeRefreshRequest];
        if(self.fixtureOnRefresh)self.fixtureOnRefresh();
        self.publishing=NO;if(self.dirty)[self scheduleRefresh];
    }else if(self.usesNativeSessionModel)[self refreshNativeSessionModel];
    else {self.fixtureLegacyRefreshes++;self.dirty=NO;[self consumeRefreshRequest];}
}
#define dispatch_time FixtureTime
#define dispatch_after FixtureAfter
#define dispatch_async FixtureAsync
#define NSProcessInfo FixtureProcessInfo
#include "AdapterBodies.h"
#undef dispatch_time
#undef dispatch_after
#undef dispatch_async
#undef NSProcessInfo
@end

static void AdapterTests(NewMainFrameViewController *owner) {
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,nil,20));Select(@"preset_1");
    UITableView *table=[UITableView new];id nativeDelegate=[NSObject new],nativePrefetch=[NSObject new];
    FixtureMainFrameLogic *logic=[FixtureMainFrameLogic new];logic.useManager=YES;owner.m_mainFrameLogicController=logic;
    FixtureMainFrameDataSource *nativeData=[FixtureMainFrameDataSource new];nativeData.logic=logic;
    table.dataSource=nativeData;table.delegate=nativeDelegate;table.prefetchDataSource=nativePrefetch;
    owner.m_tableView=table;[CSGroupListAdapter attachToController:owner];
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForController:owner];
    CHECK(a && a.usesNativeSessionModel && a.projection.isValid && !a.snapshotRetryAttempted);
    [a installProxies];CHECK(table.dataSource==nativeData && table.delegate==nativeDelegate && table.prefetchDataSource==nativePrefetch);
    CHECK([a proxyForTarget:nativeDelegate role:1]==nativeDelegate && a.proxies.count==0);
    CHECK(a.tabBadgeSections.count==1 && [a.tabBadgeSections[0] count]==3);
    CHECK(a.cachedNativeSections.count==2 && [a.cachedNativeSections[1] count]==1);
    CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@24]);
    CSGroupTabBadgeDecision *decision=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:owner includeNative:NO];
    CHECK(decision.badge.count==24 && decision.sourceController==owner);
    // A dirty selected UI never truncates full-source badge data.
    a.dirty=YES;a.cachedNativeSections=@[];
    CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@24]);
    [a refreshNativeSessionModel];
    UITableViewCell *cell=[UITableViewCell new];NSUInteger indexes[]={1,0};cell.fixturePath=[NSIndexPath indexPathWithIndexes:indexes length:2];
    [a bindNativeCell:cell atPath:cell.fixturePath];CHECK(!cell.hidden && LastCoveredRow.userName.length);
    FailPath=YES;[a bindNativeCell:cell atPath:cell.fixturePath];CHECK(cell.hidden && LastCoveredRow==nil);FailPath=NO;
    [a cancelScheduledRefresh];a.recoveryPending=NO;a.dirty=NO;
    [a refreshNativeSessionModel];
    NSUInteger recoveries=a.fixtureRecoveries;
    OnBuild=^{[Main rebuildMainSessions];};[a refreshNativeSessionModel];
    CHECK(a.projection==nil && a.snapshotRetryAttempted && a.privacyRefreshPending && a.fixtureRecoveries==recoveries+1);
    [a refreshNativeSessionModel];CHECK(a.projection.isValid && !a.snapshotRetryAttempted);
    OnBuild=^{Epoch++;};[a refreshNativeSessionModel];CHECK(a.projection==nil && a.snapshotRetryAttempted);
    [a refreshNativeSessionModel];CHECK(a.projection.isValid);
    OnBuild=^{Policy=MakePolicy(@[@"a"],NO,NO,nil,21);};[a refreshNativeSessionModel];
    CHECK(a.projection==nil && a.snapshotRetryAttempted);[a refreshNativeSessionModel];CHECK(a.projection.isValid);
    NSArray *normal=Main.hostNormal;
    Main.hostNormal=[normal arrayByAddingObject:[NSObject new]];[Main rebuildMainSessions];[a refreshNativeSessionModel];
    CHECK(a.projection.isValid);
    UITableViewCell *anonymous=[UITableViewCell new];NSUInteger unknownIndexes[]={1,1};
    [a bindNativeCell:anonymous atPath:[NSIndexPath indexPathWithIndexes:unknownIndexes length:2]];
    CHECK(!anonymous.hidden && LastCoveredRow.kind==CSGroupRowKindBusiness && !LastCoveredRow.userName.length);
    Main.hostNormal=normal;[Main rebuildMainSessions];[a refreshNativeSessionModel];
    CHECK(table.dataSource==nativeData && table.delegate==nativeDelegate && table.prefetchDataSource==nativePrefetch);
    // Reload and layout can synchronously introduce a new privacy request.
    // Consuming this publication must preserve that request and schedule its
    // next turn with privacy priority, regardless of notification coalescing.
    [a cancelScheduledRefresh];a.projection=nil;a.privacyRefreshPending=YES;
    __weak CSGroupListAdapter *weak=a;
    table.onReload=^{CSGroupListAdapter *current=weak;current.privacyRefreshPending=YES;[current requestCoalescedRefresh];};
    [a refreshNativeSessionModel];
    CHECK(a.privacyRefreshPending && a.dirty && a.scheduled && !a.scheduledCoalesced);
    Advance(0);CHECK(a.projection.isValid && !a.privacyRefreshPending && !a.dirty);
    table.onLayout=^{CSGroupListAdapter *current=weak;current.privacyRefreshPending=YES;[current requestCoalescedRefresh];};
    [a refreshNativeSessionModel];
    CHECK(a.privacyRefreshPending && a.dirty && a.scheduled && !a.scheduledCoalesced);
    Advance(0);CHECK(a.projection.isValid && !a.privacyRefreshPending && !a.dirty);
    table.visibleCells=@[cell];[a.privacyShield shieldCell:cell];
    OnAdapterLayout=^{CSGroupListAdapter *current=weak;current.privacyRefreshPending=YES;[current requestCoalescedRefresh];};
    [a refreshNativeSessionModel];
    CHECK(a.privacyRefreshPending && a.dirty && a.scheduled && !a.scheduledCoalesced && cell.hidden);
    Advance(0);CHECK(a.projection.isValid && !a.privacyRefreshPending && !a.dirty && !cell.hidden);
    [a.privacyShield shieldCell:cell];
    OnAdapterLayout=^{Policy=MakePolicy(@[@"a"],NO,NO,nil,22);CSGroupListAdapter *current=weak;current.privacyRefreshPending=YES;[current requestCoalescedRefresh];};
    [a refreshNativeSessionModel];
    CHECK(a.privacyRefreshPending && a.dirty && a.scheduled && !a.scheduledCoalesced && cell.hidden);
    Advance(0);CHECK(a.projection.isValid && !a.privacyRefreshPending && !a.dirty && !cell.hidden);
    [Adapters() removeObject:a];
}
static CSGroupListAdapter *SchedulingAdapter(void) {
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.fixtureScheduleOnly=YES;
    a.nativeActions=[NSMutableArray array];a.completions=[NSMutableArray array];FixtureJobs=[NSMutableArray array];FixtureNow=100;
    return a;
}
static void SchedulingTests(void) {
    CSGroupListAdapter *a=SchedulingAdapter();[a scheduleRefresh];Advance(1);
    CHECK(!a.dirty && !a.scheduled && a.fixtureRefreshes==0);
    // Notification state persists across native nesting and publication.
    a.changeDepth=1;[a requestCoalescedRefresh];CHECK(a.dirty && a.coalescingNotification && !a.scheduled);
    [a endNativeChangeCoalesced:YES];CHECK(a.scheduled && a.scheduledCoalesced);Advance(.079);CHECK(a.fixtureRefreshes==0);
    Advance(.002);CHECK(a.fixtureRefreshes==1 && !a.dirty && !a.coalescingNotification);
    NSUInteger badges=a.fixtureBadgeRequests;[a endNativeChangeCoalesced:YES];Advance(1);
    CHECK(a.fixtureBadgeRequests==badges && a.fixtureRefreshes==1);
    a=SchedulingAdapter();[a requestCoalescedRefresh];
    for(NSUInteger i=0;i<4;i++){Advance(.05);[a requestCoalescedRefresh];}
    CHECK(fabs(a.refreshCoalescedDue-100.25)<.0001);Advance(.049);CHECK(a.fixtureRefreshes==0);
    Advance(.002);CHECK(a.fixtureRefreshes==1);
    a=SchedulingAdapter();[a requestCoalescedRefresh];Advance(.02);[a requestRefresh];Advance(0);
    CHECK(a.fixtureRefreshes==1);Advance(.1);CHECK(a.fixtureRefreshes==1);
    // A notification synchronously raised after consume belongs to the next
    // publication; it must survive the outer finally and its original timer.
    a=SchedulingAdapter();__weak CSGroupListAdapter *weak=a;
    a.fixtureOnRefresh=^{CSGroupListAdapter *current=weak;current.fixtureOnRefresh=nil;[current requestCoalescedRefresh];};
    [a requestCoalescedRefresh];Advance(.081);CHECK(a.fixtureRefreshes==1 && a.dirty && a.coalescingNotification);
    Advance(.081);CHECK(a.fixtureRefreshes==2 && !a.dirty);
    a=SchedulingAdapter();a.presentationSuspended=YES;[a requestCoalescedRefresh];Advance(1);
    CHECK(a.fixtureRefreshes==0 && a.coalescingNotification);
    a.presentationSuspended=NO;[a scheduleRefresh];Advance(0);CHECK(a.fixtureRefreshes==1);
}
