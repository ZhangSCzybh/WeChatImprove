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
@property(nonatomic) NSUInteger reloads;
@property(nonatomic,copy) NSArray<UITableViewCell *> *visibleCells;
@property(nonatomic,copy) void (^onReload)(void),(^onLayout)(void);
- (void)reloadData;
- (void)layoutIfNeeded;
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;
@end
@implementation UITableView
- (void)reloadData {self.reloads++;void(^callback)(void)=self.onReload;self.onReload=nil;if(callback)callback();}
- (void)layoutIfNeeded {void(^callback)(void)=self.onLayout;self.onLayout=nil;if(callback)callback();}
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
static BOOL CSGroupApplicationActive(void) {return FixtureActive;}
static BOOL CSGroupPrivacyActive(void) {return Policy.blocked || (Policy.enabled && !Policy.revealed && [Policy.options[@"hideSessions"] boolValue]);}
static BOOL Option(NSString *suffix) {return [Defaults boolForKey:[@"com.wechat.enhance.chat_group." stringByAppendingString:suffix]];}
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) {return [Policy hidesUserName:name surface:surface];}
static void CSCloseFriendUpdateSessionCover(id cell,CSGroupRow *row) {(void)cell;LastCoveredRow=row;}
static NSArray *FixtureSections(void) {
    NSMutableArray *out=[NSMutableArray array];NSUInteger section=0;
    for(NSArray *source in @[Main.topSessions ?: @[],Main.normalSessions ?: @[]]) {
        NSMutableArray *rows=[NSMutableArray array];NSUInteger row=0;
        for(id session in source) {NSUInteger indexes[]={section,row++};[rows addObject:CSGroupRowForNativeSession(session,[NSIndexPath indexPathWithIndexes:indexes length:2],section==0)];}
        [out addObject:rows];section++;
    }return out;
}
static NSArray *FixtureBuildSections(id owner,id table,id source,NSArray *previous) {
    (void)owner;(void)table;(void)source;(void)previous;
    NSArray *result=FixtureSections();void(^callback)(void)=OnBuild;OnBuild=nil;if(callback)callback();return result;
}
static NSString *FixtureNameAtPath(id owner,NSIndexPath *path) {
    (void)owner;NSArray *sections=FixtureSections();NSUInteger s=[path indexAtPosition:0],r=[path indexAtPosition:1];
    return s<sections.count && r<[sections[s] count] ? ((CSGroupRow *)sections[s][r]).userName : nil;
}
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
@interface FixtureProcessInfo:NSObject
+ (instancetype)processInfo;
- (double)systemUptime;
@end
@implementation FixtureProcessInfo
+ (instancetype)processInfo {static id clock;if(!clock)clock=[self new];return clock;}
- (double)systemUptime {return FixtureNow;}
@end
static int64_t FixtureTime(int64_t base,int64_t nanoseconds) {(void)base;return (int64_t)(FixtureNow*NSEC_PER_SEC)+nanoseconds;}
static void FixtureAfter(int64_t due,dispatch_queue_t queue,dispatch_block_t block) {(void)queue;if(!FixtureJobs)FixtureJobs=[NSMutableArray array];[FixtureJobs addObject:@{@"due":@((double)due/NSEC_PER_SEC),@"block":[block copy]}];}
static void FixtureAsync(dispatch_queue_t queue,dispatch_block_t block) {FixtureAfter(FixtureTime(0,0),queue,block);}
static void Advance(NSTimeInterval delta) {
    FixtureNow+=delta;
    for(NSUInteger round=0;round<100;round++) {
        NSDictionary *next=nil;
        for(NSDictionary *job in FixtureJobs)if([job[@"due"] doubleValue]<=FixtureNow && (!next || [job[@"due"] doubleValue]<[next[@"due"] doubleValue]))next=job;
        if(!next)return;[FixtureJobs removeObjectIdenticalTo:next];((dispatch_block_t)next[@"block"])();
    }CHECK(NO);
}
@implementation CSGroupListAdapter
- (void)pruneNativeActions {}
- (void)finishSuspendedBatches {}
- (BOOL)groupPanMoving {return NO;}
- (NSUInteger)nativeMenuState {return 0;}
- (void)saveAnchor {}
- (void)restoreAnchor {}
- (void)ensureChrome {if(!self.chrome)self.chrome=[WESessionTabContainerView new];}
- (void)layout {void(^callback)(void)=OnAdapterLayout;OnAdapterLayout=nil;if(callback)callback();}
- (void)refreshNavigationTitle {}
- (void)applyPendingScrollToTop {}
- (void)detach {[Adapters() removeObject:self];}
- (void)nativeSessionModelChanged:(NSNotification *)note {(void)note;}
- (void)scheduleNativeRecoveryForKey:(NSArray *)key {(void)key;self.fixtureRecoveries++;}
- (void)invalidateNativeSnapshot {self.modelRevision++;}
- (void)requestTabBadgeSourceRefresh {self.fixtureBadgeRequests++;}
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced {(void)coalesced;self.fixtureBadgeRequests++;}
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row {
    if(FailPath)return nil;
    for(NSArray *section in FixtureSections())for(CSGroupRow *current in section)
        if(current.userName.length && [current.userName isEqual:row.userName])return current.nativePath;
    return nil;
}
- (void)refresh {
    self.fixtureRefreshes++;
    if(self.fixtureScheduleOnly) {
        self.publishing=YES;self.dirty=NO;[self consumeRefreshRequest];
        if(self.fixtureOnRefresh)self.fixtureOnRefresh();
        self.publishing=NO;if(self.dirty)[self scheduleRefresh];
    }else [self refreshNativeSessionModel];
}
#define CSGroupBuildNativeSectionsReusing FixtureBuildSections
#define CSGroupNativeUserNameAtPath FixtureNameAtPath
#define dispatch_time FixtureTime
#define dispatch_after FixtureAfter
#define dispatch_async FixtureAsync
#define NSProcessInfo FixtureProcessInfo
#include "AdapterBodies.h"
#undef CSGroupBuildNativeSectionsReusing
#undef CSGroupNativeUserNameAtPath
#undef dispatch_time
#undef dispatch_after
#undef dispatch_async
#undef NSProcessInfo
@end

static void AdapterTests(NewMainFrameViewController *owner) {
    PublishPolicy(MakePolicy(@[@"a"],NO,NO,nil,20));Select(@"preset_1");
    UITableView *table=[UITableView new];id nativeData=[NSObject new],nativeDelegate=[NSObject new],nativePrefetch=[NSObject new];
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
    CHECK(anonymous.hidden && LastCoveredRow==nil);
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
