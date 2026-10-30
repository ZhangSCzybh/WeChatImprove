#import <UIKit/UIKit.h>
#import "GroupRefreshFixture.h"
#import "CSCloseFriendListShield.h"
#import "CSCloseFriendPolicy.h"
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"
#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <math.h>
#include "GroupLifecycleTabBadgeDependencies.h"
#include "GroupLifecycleTabBadgeImplementation.inc"
@class CSGroupListAdapter;
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
@interface UITableView (LifecycleDataSource)
@property(nonatomic,readonly) id dataSource;
@property(nonatomic,readonly) CGPoint contentOffset;
@property(nonatomic,readonly) UIEdgeInsets adjustedContentInset;
@property(nonatomic,readonly) NSArray<NSIndexPath *> *indexPathsForVisibleRows;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)paths withRowAnimation:(NSInteger)animation;
@end
#define UITableViewRowAnimationNone 0
@interface LifecycleTable : UITableView
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic,copy) NSArray<NSIndexPath *> *indexPathsForVisibleRows,*reloadedPaths;
@property(nonatomic) NSUInteger rowReloads,layoutMeasurements;
@end
@interface Host : NSObject
@property(nonatomic,strong) UITableView *m_tableView;
@property(nonatomic) BOOL isSearching;
@property(nonatomic) BOOL folded;
@property(nonatomic) NSUInteger originalCalls;
@property(nonatomic) BOOL suppressNativeInvalidation;
- (void)nativeAppearance:(BOOL)animated;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
@end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic,copy) NSString *selectedTabID;
@property(nonatomic,strong) NSArray *tabs;
@end
static NSMutableDictionary *selectedGroups;
@implementation CSGroupPreferences
- (NSString *)selectedTabID { return selectedGroups[self.accountID] ?: @"preset_0"; }
- (void)setSelectedTabID:(NSString *)value {
    if (!selectedGroups) selectedGroups=[NSMutableDictionary dictionary];selectedGroups[self.accountID]=value;
}
@end
static char AdapterKey, PresentationSuspendedKey, CellRowKey;
static NSString *account=@"account-A";
static BOOL enabled=YES;
static BOOL privacyEnabled;
static BOOL CSGroupPrivacyActive(void) { return privacyEnabled; }
static NSUInteger accountEpoch=1;
static NSUInteger CSCloseFriendAccountEpoch(void) { return accountEpoch; }
static BOOL CSGroupIsFoldedController(id owner) { return [owner isKindOfClass:Host.class] && [owner folded]; }
static BOOL policyBlocked;
static NSArray *policyFriends;
static BOOL badgePolicyEnabled,policyRevealed;
static NSDictionary *policyOptions;
static NSUInteger policyRevision=1;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:account profile:@{@"enabled":@((BOOL)(privacyEnabled || badgePolicyEnabled)),@"friends":policyFriends ?: @[@"secret"],@"groups":@[],@"options":policyOptions ?: @{}} revealed:policyRevealed revision:policyRevision blocked:policyBlocked];
}
#if CS_GROUP_LIFECYCLE_TAB_BADGE
typedef NS_ENUM(NSUInteger, CSGroupFoldedPrivacyState) {
    CSGroupFoldedPrivacyUnknown, CSGroupFoldedPrivacyNoHidden,
    CSGroupFoldedPrivacyMixed, CSGroupFoldedPrivacyAllHidden
};
// This lifecycle fixture has no aggregate rows; folded membership stays unknown.
static NSArray *CSGroupCopyFoldedUserNames(void) { return nil; }
static CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(NSArray *names,NSSet *hidden) {
    (void)names; (void)hidden; return CSGroupFoldedPrivacyUnknown;
}
#endif
static NSUInteger scopes,snapshotBuilds;
static NSArray *fixtureNativeSections;
static void (^snapshotMutation)(id);
static BOOL mutateDuringSnapshot,failPublication,rawPublicationFailure;
static void (^publicationMutation)(id);
static NSArray *CSGroupBuildNativeSections(id controller,id table,id source);
static NSArray *CSGroupBuildNativeSectionsReusing(id controller,id table,id source,NSArray *previous);
static NSHashTable *Adapters(void) {
    static NSHashTable *adapters; if (!adapters) adapters=[NSHashTable weakObjectsHashTable]; return adapters;
}
static BOOL Option(NSString *key) { (void)key; return enabled; }
static NSString *CSGroupCurrentAccountID(void) { return account; }
static id CSGroupReadObject(id owner,NSString *key) { return [owner valueForKey:key]; }
static long long CSGroupReadInteger(id owner,NSString *key,long long fallback) { return owner ? [[owner valueForKey:key] longLongValue] : fallback; }
static void CSGroupWithNativeIndices(id table,void (^body)(void)) { (void)table; body(); }
static void CSGroupWithDisplayIndices(id table,void (^body)(void)) { (void)table; scopes++; body(); }
@interface LifecycleChrome : NSObject
@property(nonatomic,copy) NSString *selectedTabID;
@end
@implementation LifecycleChrome @end
@interface CSGroupListAdapter : NSObject
CS_GROUP_REFRESH_TEST_PROPERTIES
@property(nonatomic) NSUInteger modelRevision,snapshotRevision,snapshotEpoch,refreshGeneration;
@property(nonatomic) BOOL coalescingNotification,scheduledCoalesced,coalescedDispatchPending;
@property(nonatomic,copy) NSString *snapshotAccount;
@property(nonatomic,strong) NSArray *cachedNativeSections;
#if CS_GROUP_LIFECYCLE_TAB_BADGE
@property(nonatomic,strong) CSGroupBadge *tabAlertBadge;
@property(nonatomic,copy) NSArray *tabAlertBadgeKey,*tabBadgeSections,*tabBadgePublishedKey;
@property(nonatomic,copy) NSString *tabBadgeAccount;
@property(nonatomic) NSUInteger tabBadgeRevision,tabBadgeEpoch;
@property(nonatomic) BOOL tabBadgeSourceRequired,tabBadgeRestorePending,tabBadgeSourceScheduled,tabBadgeSourceRefreshing,tabBadgeRequestDispatchPending,tabBadgeRefreshAgain;
@property(nonatomic) BOOL tabBadgeRefreshAgainCoalesced,tabBadgeRequestImmediate,tabBadgeImmediatePending;
@property(nonatomic,strong) NSTimer *tabBadgeSourceTimer;
@property(nonatomic,copy) NSArray *tabBadgeScheduleKey;
@property(nonatomic) NSUInteger tabBadgeSourceGeneration;
@property(nonatomic) NSTimeInterval tabBadgeBurstStart,tabBadgeDue;
+ (void)requestTabBadgeSourcesRefresh;
- (void)requestTabBadgeSourceRefresh;
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced;
- (void)cancelTabBadgeSourceRefresh;
- (void)refreshTabBadgeSource;
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision;
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:(BOOL)includeNative;
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:(id)controller includeNative:(BOOL)includeNative;
#endif
@property(nonatomic,copy) NSString *nativeActionsAccount;
@property(nonatomic,copy) NSString *publishedTabID;
@property(nonatomic,strong) NSArray *displayedTabs;
@property(nonatomic,weak) UITableView *table;
@property(nonatomic,weak) Host *controller;
@property(nonatomic,strong) NSMutableDictionary *proxies,*anchors;
@property(nonatomic,copy) NSDictionary *presentationViewport;
@property(nonatomic,strong) NSMutableArray *completions,*nativeActions;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) id nativeHeader,projection,identityDisplayPaths;
@property(nonatomic) BOOL chromeVisible,searchChromeVisible,privacyRefreshPending,privacyShielded,privacyTableWasHidden;
@property(nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property(nonatomic) CSGroupChangeKind lastPublishedChanges;
@property(nonatomic,copy) NSSet<NSString *> *lastPublishedContentUserNames;
@property(nonatomic) BOOL lastPublishedContentIdentityKnown;
@property(nonatomic,strong) LifecycleChrome *chrome;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic) double baselineDeceleration;
@property(nonatomic) BOOL active,presentationSuspended,publishedEnabled,searching,dirty,scheduled,publishing,groupPanMoving,swipeActive,nativePresentation,updatingHeader,snapshotRetryAttempted;
@property(nonatomic) NSUInteger changeDepth,snapshotRetryGeneration,refreshCount,layoutCount,anchorOrTitleCount,menuReads,menuState;
@property(nonatomic) BOOL pendingScrollToTop;
+ (instancetype)adapterForController:(id)controller;
+ (instancetype)adapterForTable:(id)table;
+ (void)setPresentationSuspended:(BOOL)value forController:(id)controller;
+ (void)finishPresentationReturnForController:(id)controller;
- (void)refresh;
- (void)requestRefresh;
- (void)finishSuspendedBatches;
- (void)saveAnchor;
- (void)refreshNavigationTitle;
- (void)useNativePresentation;
- (void)shieldVisiblePrivateRows;
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                  changes:(CSGroupChangeKind)changes contentUserNames:(NSSet<NSString *> *)names
     contentIdentityKnown:(BOOL)known previouslyProjecting:(BOOL)previouslyProjecting;
@end
@implementation CSGroupListAdapter
#include "GroupLifecycleBodies.h"
- (BOOL)isActive { return self.active; }
- (BOOL)projecting { return self.active; }
- (void)setProjecting:(BOOL)value { self.active=value; }
- (NSUInteger)nativeMenuState { self.menuReads++; return self.menuState; }
- (void)reconcileDeletedSwipeRow {}
- (id)nativeSource { return self; }
- (void)applyPendingScrollToTop {}
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay { (void)event; (void)delay; }
- (void)recordRefreshReason:(NSString *)reason { (void)reason; }
- (void)detach {
#if CS_GROUP_LIFECYCLE_TAB_BADGE
    [self cancelTabBadgeSourceRefresh];
#endif
    [self cancelScheduledRefresh];
    self.presentationSuspended=YES; self.active=NO;
    [self.nativeActions removeAllObjects];
    objc_setAssociatedObject(self.table,&AdapterKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)publishFixture {
    [self.privacyShield prepareForPublication];
    if (publicationMutation) publicationMutation(self);
    self.refreshCount++;
    if (!self.nativePresentation) [self nativeSectionsForAccount:account];
    self.preferences=[CSGroupPreferences new]; self.preferences.accountID=account;
    WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll],*a=[WESessionTabItem customTabWithName:@"A" sessionUserNames:@[@"a"]],*b=[WESessionTabItem customTabWithName:@"B" sessionUserNames:@[@"b"]];
    a.tabId=@"custom-a";b.tabId=@"custom-b";self.preferences.tabs=@[all,a,b];self.displayedTabs=self.preferences.tabs;
    self.publishedTabID=self.preferences.selectedTabID;
    self.publishedEnabled=enabled; self.searching=self.controller.isSearching;
    self.active=privacyEnabled || (enabled && !self.searching && !self.nativePresentation);
    [self layout];
    if (failPublication) { if (rawPublicationFailure) [self requestRefresh]; else [self requestRecovery]; }
}
@end
static NSArray *CSGroupBuildNativeSections(id controller,id table,id source) {
    NSCAssert(NSThread.isMainThread,@"Native session reads must stay on the main thread");
    (void)controller; (void)table; snapshotBuilds++;
    if (mutateDuringSnapshot) [source invalidateNativeSnapshot];
    if(snapshotMutation)snapshotMutation(source);
    return fixtureNativeSections ?: @[@[]];
}
static NSArray *CSGroupBuildNativeSectionsReusing(id controller,id table,id source,NSArray *previous) {
    (void)previous;return CSGroupBuildNativeSections(controller,table,source);
}
static CSGroupListAdapter *Adapter(id owner) { return [CSGroupListAdapter adapterForController:owner]; }
static void Native(id owner,BOOL change,void (^body)(void)) { (void)owner; (void)change; body(); }
static BOOL Projected(CSGroupListAdapter *a) { return a.isActive && !a.publishing; }
@implementation Host
- (UITableView *)tableView { return self.m_tableView; }
- (void)nativeAppearance:(BOOL)animated {
    (void)animated; self.originalCalls++;
    // Native lifecycle may itself produce a session/UI invalidation.
    if (!self.suppressNativeInvalidation) [Adapter(self) requestRefresh];
}
#include "GroupLifecycleHooks.h"
@end
static void FoldedAppearOriginal(id owner,SEL selector,BOOL animated) { (void)selector;[owner nativeAppearance:animated]; }
static void FoldedDisappearOriginal(id owner,SEL selector,BOOL animated) { (void)selector;[owner nativeAppearance:animated]; }
#include "FoldedLifecycleHooks.h"
#include "GroupLifecycleReloadHelpers.h"
@implementation LifecycleTable
#include "GroupLifecycleReload.h"
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)paths withRowAnimation:(NSInteger)animation {
    (void)animation; self.rowReloads++; self.reloadedPaths=paths;
}
- (void)layoutIfNeeded { self.layoutMeasurements++; }
@end
static NSUInteger checks,failures;
static void Check(BOOL condition,NSString *message) {
    checks++; if (!condition) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static void RunFor(double interval) { [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:interval]]; }
static CSGroupListAdapter *List(Host **owner) {
    Host *host=[Host new]; host.m_tableView=[LifecycleTable new];
    [CSGroupListAdapter attachToController:host]; *owner=host;
    return Adapter(host);
}
static UITableViewCell *Cell(NSString *name) {
    UITableViewCell *cell=[[UITableViewCell alloc] initWithFrame:CGRectMake(0,0,320,64)];
    NSUInteger indexes[]={0,0};
    CSGroupRow *row=[[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:indexes length:2]
        userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:0 redDot:NO];
    objc_setAssociatedObject(cell,&CellRowKey,@{@"row":row,@"account":account},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    cell.isAccessibilityElement=YES; cell.accessibilityElements=@[@"original-cell"];
    return cell;
}
static NSIndexPath *BannerPath(NSUInteger row) {
    NSUInteger indexes[]={0,row}; return [NSIndexPath indexPathWithIndexes:indexes length:2];
}
static CSGroupRow *BannerRow(NSString *name,NSUInteger index,CSGroupRowKind kind,NSString *summary) {
    return [[CSGroupRow alloc] initWithNativePath:BannerPath(index) userName:name kind:kind
        category:kind==CSGroupRowKindSession ? CSGroupRowCategoryPrivate : CSGroupRowCategoryUnknown
        top:NO unreadCount:0 redDot:NO nativeSummary:summary sortTime:nil];
}
static CSGroupProjection *BannerProjection(CSGroupListAdapter *adapter) {
    return [[CSGroupProjection alloc] initWithSections:adapter.cachedNativeSections tabs:adapter.preferences.tabs
        selectedTabID:adapter.preferences.selectedTabID filterDuplicates:NO accountID:account
        hiddenUserNames:NSSet.set privacyRevision:policyRevision previousProjection:adapter.projection];
}
static CSGroupListAdapter *BannerList(Host **owner,NSArray *rows,CSGroupProjection **previous) {
    fixtureNativeSections=@[rows];
    CSGroupListAdapter *adapter=List(owner);
    (*owner).suppressNativeInvalidation=YES;
    adapter.projection=BannerProjection(adapter); *previous=adapter.projection;
    ((LifecycleTable *)adapter.table).indexPathsForVisibleRows=@[BannerPath(0),BannerPath(1),BannerPath(2)];
    return adapter;
}
static void BannerDepart(Host *host) { [host viewWillDisappear:YES]; [host viewDidDisappear:YES]; }
static void BannerReturn(Host *host) { [host viewWillAppear:YES]; [host viewDidAppear:YES]; }
static LifecycleTable *PublishRecordedReturn(CSGroupListAdapter *adapter,CSGroupProjection *previous) {
    // Keep lifecycle admission/merging and both production publication layers
    // real. Only the native data reader and UIKit operations are host doubles.
    CSGroupProjection *next=BannerProjection(adapter); adapter.projection=next;
    LifecycleTable *table=(LifecycleTable *)adapter.table;
    table.reloads=0; table.rowReloads=0; table.layoutMeasurements=0; table.reloadedPaths=nil;
    adapter.publishing=YES;
    @try {
        [adapter publishProjection:next previous:previous changes:adapter.lastPublishedChanges
            contentUserNames:adapter.lastPublishedContentUserNames contentIdentityKnown:adapter.lastPublishedContentIdentityKnown
            previouslyProjecting:YES];
    } @finally { adapter.publishing=NO; }
    return table;
}
static void CheckReturnBannerPublication(void) {
    // Synthetic immutable row values exercise projection input changes. They
    // do not cover WeChat's private banner-text reader or UIView identity.
    NSArray *rows=@[BannerRow(nil,0,CSGroupRowKindBusiness,@"收藏置顶"),
                    BannerRow(nil,1,CSGroupRowKindBusiness,@"已登录 Mac"),
                    BannerRow(@"ordinary-a",2,CSGroupRowKindSession,nil)];
    Host *host=nil; CSGroupProjection *previous=nil;
    CSGroupListAdapter *adapter=BannerList(&host,rows,&previous);
    NSUInteger before=adapter.refreshCount,builds=snapshotBuilds;
    BannerDepart(host);
    Check(adapter.pendingChanges==CSGroupChangeUnknown && !adapter.pendingContentUnattributed,
        @"departure without native invalidation requests reconciliation without inventing banner content");
    BannerReturn(host);
    Check(host.originalCalls==4 && adapter.refreshCount==before+1 && snapshotBuilds==builds+1,
        @"the complete quiet departure/return runs native callbacks and rebuilds one fresh snapshot");
    LifecycleTable *table=PublishRecordedReturn(adapter,previous);
    Check(!table.reloads && !table.rowReloads && !table.layoutMeasurements,
        @"real lifecycle event state and real publication perform no table operation for unchanged business rows on return");

    NSSet *names=[NSSet setWithObject:@"ordinary-a"];
    for (NSUInteger timing=0;timing<2;timing++) {
        adapter=BannerList(&host,rows,&previous);
        if (!timing) [adapter beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:names];
        [host viewWillDisappear:YES];
        if (timing) [adapter beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:names];
        [adapter endNativeChange]; [host viewDidDisappear:YES];
        Check(!adapter.pendingContentUnattributed && [adapter.pendingContentUserNames isEqual:names],
            @"both disappearance callbacks preserve a real session event's existing content attribution");
        BannerReturn(host); table=PublishRecordedReturn(adapter,previous);
        Check(adapter.lastPublishedContentIdentityKnown && [adapter.lastPublishedContentUserNames isEqual:names] &&
              !table.reloads && table.rowReloads==1 && [table.reloadedPaths isEqual:@[BannerPath(2)]] && !table.layoutMeasurements,
            @"real content queued before or during departure refreshes only its session after return");
    }

    adapter=BannerList(&host,rows,&previous); BannerDepart(host); [adapter requestRefresh]; BannerReturn(host);
    table=PublishRecordedReturn(adapter,previous);
    Check((adapter.lastPublishedChanges&CSGroupChangeContent) && !adapter.lastPublishedContentIdentityKnown &&
          !table.reloads && [table.reloadedPaths isEqual:@[BannerPath(0),BannerPath(1),BannerPath(2)]] && table.layoutMeasurements==1,
        @"a genuine unknown refresh while away still republishes both business rows and their native geometry");

    adapter=BannerList(&host,rows,&previous); BannerDepart(host);
    fixtureNativeSections=@[@[rows[0],BannerRow(nil,1,CSGroupRowKindBusiness,@"已登录 Windows"),rows[2]]];
    BannerReturn(host); table=PublishRecordedReturn(adapter,previous);
    Check(!table.reloads && [table.reloadedPaths isEqual:@[BannerPath(1)]] && table.layoutMeasurements==1,
        @"a changed verified business-row value refreshes its row even on a reconciliation-only return");
    for (NSUInteger adding=0;adding<2;adding++) {
        adapter=BannerList(&host,rows,&previous); BannerDepart(host);
        fixtureNativeSections=adding ? @[@[rows[0],rows[1],BannerRow(nil,2,CSGroupRowKindBusiness,@"new business row"),
            BannerRow(@"ordinary-a",3,CSGroupRowKindSession,nil)]] :
            @[@[rows[0],BannerRow(@"ordinary-a",1,CSGroupRowKindSession,nil)]];
        BannerReturn(host); table=PublishRecordedReturn(adapter,previous);
        Check(table.reloads==1 && !table.rowReloads && table.layoutMeasurements==1,
            @"business-row insertion and removal retain the full structural publication boundary");
    }

    adapter=BannerList(&host,rows,&previous); BannerDepart(host);
    NSString *oldAccount=account; NSUInteger oldEpoch=accountEpoch;
    account=@"banner-return-replacement"; accountEpoch++;
    BannerReturn(host); table=PublishRecordedReturn(adapter,previous);
    Check(table.reloads==1 && table.layoutMeasurements==1 && [adapter.preferences.accountID isEqual:account],
        @"a return across accounts still rebuilds table coordinates in the current account");
    account=oldAccount; accountEpoch=oldEpoch;
    adapter=BannerList(&host,rows,&previous); BannerDepart(host);
    privacyEnabled=YES; policyRevision++; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    BannerReturn(host); table=PublishRecordedReturn(adapter,previous);
    Check(table.reloads==1 && table.layoutMeasurements==1 && !adapter.privacyRefreshPending,
        @"a privacy policy change while away retains the safe full publication boundary on return");
    privacyEnabled=NO; fixtureNativeSections=nil;
}
int main(void) { @autoreleasepool {
    Host *host=nil; CSGroupListAdapter *a=List(&host);
    if (getenv("CS_PRIVACY_BLANK_PROBE")) {
        NSUInteger before=a.refreshCount; privacyEnabled=YES;
        [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:@"willResign" object:nil]];
        [CSGroupListAdapter closeFriendPolicyChanged:nil];
        Check(!a.table.hidden,@"switcher lock must keep ordinary list and header visible before returning");
        Check(a.refreshCount==before+1 && !a.privacyRefreshPending,@"switcher lock must finish safe publication without foreground or another runloop");
        fprintf(stdout,"Switcher blank boundary: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
        return failures ? 1 : 0;
    }
    CheckReturnBannerPublication();
    NSUInteger before=a.refreshCount, layouts=a.layoutCount;
    [host viewWillDisappear:YES]; [host viewDidDisappear:YES]; RunFor(.02);
    Check(a.presentationSuspended && host.originalCalls==2,@"native disappearance runs and suspends grouping");
    Check(a.refreshCount==before && a.layoutCount==layouts,@"disappearance's own invalidation does not publish");
    a.anchorOrTitleCount=0; a.menuReads=0;
    __block NSUInteger models=0;
    for (NSUInteger i=0;i<200;i++) {
        [a beginNativeChange]; models++; [a endNativeChange];
        [CSGroupListAdapter layoutForController:host];
        [CSGroupListAdapter attachToController:host];
        [a refresh];
    }
    [a saveAnchor]; [a restoreAnchor]; [a returnToGroupTop]; [a refreshNavigationTitle];
    RunFor(.08);
    Check(models==200 && !a.changeDepth,@"all native changes still execute and transactions balance");
    Check(a.refreshCount==before && a.layoutCount==layouts,@"200 hidden updates do zero publication or header layout");
    Check(!a.anchorOrTitleCount && !a.menuReads,@"hidden work avoids anchor/title work and menu scans");
    Check(a.dirty && !a.scheduled,@"hidden changes retain dirty state without polling");
    [CSGroupListAdapter settingsChanged]; RunFor(.02);
    Check(a.refreshCount==before && a.layoutCount==layouts,@"settings notifications also respect suspension");
    [host viewWillAppear:YES]; RunFor(.02);
    Check(!a.presentationSuspended && a.refreshCount==before+1 && !a.dirty,@"return publishes merged changes once");
    // An interactive pop toward the list may cancel and hide it again.
    [host viewWillDisappear:YES]; [host viewDidDisappear:YES]; before=a.refreshCount;
    [a requestRefresh]; RunFor(.08);
    Check(a.presentationSuspended && a.refreshCount==before && !a.scheduled,@"cancelled interactive return stays suspended");
    // A cancelled push gives appearance callbacks back to the list.
    [host viewWillAppear:YES]; [host viewDidAppear:YES]; RunFor(.02);
    Check(!a.presentationSuspended && !a.dirty,@"cancelled departure resumes on appearance callbacks");

    a=List(&host); a.chromeVisible=YES;
    LifecycleTable *returnTable=(LifecycleTable *)a.table;
    returnTable.contentOffset=CGPointMake(0,400); returnTable.adjustedContentInset=(UIEdgeInsets){100,0,0,0};
    [host viewWillDisappear:YES];
    Check([a.presentationViewport[@"height"] doubleValue]==500,@"real suspension captures the main list's effective scroll height");
    returnTable.contentOffset=CGPointMake(0,900); [host viewDidDisappear:YES];
    Check([a.presentationViewport[@"height"] doubleValue]==500,@"didDisappear preserves the earlier willDisappear height");
    [host viewWillAppear:YES]; [host viewDidAppear:YES]; RunFor(.02);
    Check(!a.presentationViewport && host.originalCalls==4,@"real didAppear Hook finishes and clears the presentation return record");

    // A visible sync burst retains the first viewport anchor, then publishes
    // one final snapshot. Native model mutation still runs for every event.
    a=List(&host); before=a.refreshCount; a.anchorOrTitleCount=0;
    for (NSUInteger i=0;i<200;i++) { [a beginNativeChange]; [a endNativeChangeCoalesced:YES]; }
    Check(a.anchorOrTitleCount==1,@"one viewport anchor is captured for 200 pending notifications");
    RunFor(.12); Check(a.refreshCount==before+1,@"200 visible notifications publish once");

    // Separate run-loop turns reproduce normal event delivery, not just one burst.
    a=List(&host); [host viewWillDisappear:NO]; RunFor(.02); before=a.refreshCount;
    for (NSUInteger i=0;i<20;i++) {
        [a beginNativeChange]; models++; [a endNativeChange]; RunFor(.004);
    }
    fprintf(stdout,"Hidden native event publications: %lu / 20 events\n",(unsigned long)(a.refreshCount-before));
    Check(a.refreshCount==before && !a.scheduled,@"events on separate run-loop turns do not rebuild the hidden list");

    a=List(&host); before=a.refreshCount;
    [a requestRefresh]; [host viewWillDisappear:YES]; RunFor(.08);
    Check(a.refreshCount==before && a.dirty && !a.scheduled,@"already queued immediate refresh rechecks visibility");
    a=List(&host); a.table.tracking=YES; [a requestRefresh];
    before=a.refreshCount; [host viewWillDisappear:YES]; RunFor(.16);
    Check(a.refreshCount==before && !a.scheduled,@"tracking wake-up stops rescheduling after departure");
    a=List(&host); a.groupPanMoving=YES; [a requestRefresh];
    before=a.refreshCount; [host viewWillDisappear:YES]; RunFor(.16);
    Check(a.refreshCount==before && !a.scheduled,@"group-pan polling stops after departure");
    a=List(&host); a.menuState=3; [a requestRefresh];
    before=a.refreshCount; [host viewWillDisappear:YES]; RunFor(.16);
    Check(a.refreshCount==before && !a.scheduled,@"custom-menu polling stops after departure");

    a=List(&host); [host viewWillDisappear:YES]; before=a.refreshCount;
    __block NSUInteger callbacks=0; __block BOOL completed=YES;
    [a performNativeBatch:^{ models++; } completion:^(BOOL finished) { callbacks++; completed=finished; }];
    Check(callbacks==1 && !completed && !a.completions.count,@"hidden batch completes once with interrupted UI semantics");
    [a beginNativeChange];
    [a performNativeBatch:^{ models++; } completion:^(BOOL finished) { (void)finished; callbacks++; }];
    Check(callbacks==1,@"nested batch waits for outer native transaction");
    [a endNativeChange];
    Check(callbacks==2 && !a.changeDepth && !a.completions.count,@"outer transaction drains hidden callbacks");
    @try {
        [a performNativeBatch:^{ @throw [NSException exceptionWithName:@"fixture" reason:nil userInfo:nil]; }
                   completion:^(BOOL finished) { (void)finished; callbacks++; }];
    } @catch (NSException *e) { (void)e; }
    Check(callbacks==3 && !a.changeDepth,@"throwing batch completes only once and balances depth");
    Check(a.refreshCount==before && !a.scheduled,@"batch completion does not force a hidden reload");
    // Explicit native navigation is intentionally allowed one native publication.
    __block NSUInteger actions=0;
    a.table.tracking=YES; a.table.editing=YES; a.swipeActive=YES; a.menuState=3;
    [a performInNativePresentation:^{ actions++; }];
    Check(actions==1 && a.refreshCount==before+1 && !a.nativeActions.count,@"explicit hidden navigation publishes native indices and drains action");
    Check(a.presentationSuspended && !a.active,@"native navigation does not resume ordinary hidden work");
    [a requestRefresh]; RunFor(.08);
    Check(a.refreshCount==before+1 && !a.scheduled,@"passive events after explicit navigation remain deferred");

    a=List(&host); [host viewWillDisappear:YES];
    [a beginNativeChange]; [a performInNativePresentation:^{ actions++; }];
    NSUInteger actionBefore=actions; account=@"account-B"; [a endNativeChange]; RunFor(.02);
    Check(actions==actionBefore && !a.nativeActions.count,@"queued navigation never crosses accounts");
    a=List(&host); [host viewWillDisappear:YES];
    enabled=NO; host.isSearching=YES; [CSGroupListAdapter settingsChanged]; RunFor(.02);
    [host viewWillAppear:NO];
    Check(!a.publishedEnabled && a.searching && [a.preferences.accountID isEqual:account],@"return applies latest account, settings and search state");
    enabled=YES;

    a=List(&host); a.searchChromeVisible=YES; host.isSearching=YES;
    NSUInteger searchReloads=a.table.reloads,searchBuilds=snapshotBuilds;
    a.pendingChanges=CSGroupChangeContent; [a refresh];
    Check(a.searching && a.searchChromeVisible && a.active,@"search retains selected projection rather than publishing unfiltered rows");
    Check(a.table.reloads==searchReloads && snapshotBuilds==searchBuilds && (a.pendingChanges&CSGroupChangeUnknown),@"entering search neither reloads all rows nor loses deferred content changes");
    for (NSUInteger i=0;i<12;i++) { [a beginNativeChange]; [a endNativeChange]; }
    RunFor(.08);
    Check(a.active && a.table.reloads==searchReloads && snapshotBuilds==searchBuilds,@"messages during search retain the selected list without rebuilding snapshots");
    host.isSearching=NO; [a refresh];
    Check(a.lastPublishedChanges&CSGroupChangeUnknown,@"return reconciles accumulated search-time changes with a full publication");
    Check(!a.searching && !a.searchChromeVisible && a.active,@"completed search clears transition ownership during normal publication");

    a=List(&host); a.searchChromeVisible=YES; host.isSearching=YES; [a refresh];
    NSUInteger beforeSearchAction=actions;
    [a performInNativePresentation:^{ actions++; }];
    Check(actions==beforeSearchAction+1 && !a.active && !a.nativeActions.count,@"explicit search result navigation can still request native presentation");

    a=List(&host); [host viewWillDisappear:NO];
    CSGroupListAdapter *old=a; host.m_tableView=[UITableView new];
    [CSGroupListAdapter attachToController:host]; a=Adapter(host);
    Check(a!=old && a.presentationSuspended && !a.refreshCount,@"replacement table inherits hidden owner state");
    [host viewWillAppear:NO];
    Check(a.refreshCount==1 && !a.presentationSuspended,@"replacement table initializes once when owner returns");

    UITableView *chat=[LifecycleTable new]; NSUInteger scopesBefore=scopes;
    [chat reloadData];
    Check(chat.reloads==1 && scopes==scopesBefore,@"unrelated chat table reload bypasses grouping scopes");
    a=List(&host); [host viewWillDisappear:NO]; [a beginNativeChange];
    [a performInNativePresentation:^{ actions++; }]; before=a.refreshCount;
    account=@"account-C"; [a endNativeChange]; RunFor(.02);
    Check(!a.nativeActions.count && a.refreshCount==before,@"account change prunes obsolete hidden navigation before publication");
    for (NSUInteger i=0;i<3;i++) { [a requestRefresh]; RunFor(.01); }
    Check(a.refreshCount==before && !a.scheduled,@"pruned navigation cannot reopen hidden refresh admission");
    a=List(&host); a.publishing=YES; actionBefore=actions;
    [a performInNativePresentation:^{ actions++; }];
    Check(a.dirty && a.nativeActions.count==1,@"navigation during publication marks a follow-up dirty");
    a.publishing=NO; [a requestRefresh]; RunFor(.02);
    Check(actions==actionBefore+1 && !a.nativeActions.count,@"reentrant navigation drains on the next publication");
    a=List(&host); [host viewWillDisappear:NO]; account=@"account-D"; actionBefore=actions;
    [a performInNativePresentation:^{ actions++; }];
    Check(actions==actionBefore+1 && !a.nativeActions.count,@"valid new-account navigation survives preference account reset");
    a=List(&host); [host viewWillDisappear:NO];
    Check(!a.cachedNativeSections,@"leaving chat list releases the retained full snapshot");
    [host viewWillAppear:NO]; NSUInteger builds=snapshotBuilds;
    for (NSUInteger i=0;i<10;i++) [a refresh];
    Check(snapshotBuilds==builds,@"ten selection-only publications reuse immutable native snapshot");
    [a beginNativeChange]; [a endNativeChange]; RunFor(.02);
    Check(snapshotBuilds==builds+1,@"native change invalidates snapshot before next publication");
    builds=snapshotBuilds; enabled=NO; [a refresh]; [a refresh];
#if CS_GROUP_LIFECYCLE_TAB_BADGE
    Check(snapshotBuilds==builds && !a.active,@"disabled grouping without tab ownership never builds a badge source");
#else
    Check(snapshotBuilds==builds && !a.active,@"disabled grouping never builds a snapshot");
#endif
    enabled=YES; [a refresh]; builds=snapshotBuilds;
    a.searchChromeVisible=YES; host.isSearching=YES; [a refresh]; [a refresh];
    Check(snapshotBuilds==builds && a.active,@"search retains selected rows without rebuilding or exposing native rows");
    host.isSearching=NO; [a refresh];
    Check(snapshotBuilds==builds+1,@"search exit rebuilds native data before reactivating projection");
    [a invalidateNativeSnapshot]; mutateDuringSnapshot=YES;
    Check(![a nativeSectionsForAccount:account] && !a.cachedNativeSections,@"mutation during snapshot build cannot populate the cache");
    mutateDuringSnapshot=NO; [a nativeSectionsForAccount:account]; builds=snapshotBuilds;
    account=@"account-E"; [a nativeSectionsForAccount:account];
    Check(snapshotBuilds==builds+1,@"snapshot cache never crosses accounts");
    a=List(&host); before=a.refreshCount;
    for (NSUInteger i=0;i<10;i++) { [a requestCoalescedRefresh]; RunFor(.001); }
    Check(a.refreshCount==before && a.scheduled,@"passive notification burst waits for bounded merge window");
    RunFor(.12);
    Check(a.refreshCount==before+1 && !a.scheduled,@"burst produces one publication at first-event deadline");
    before=a.refreshCount; [a requestCoalescedRefresh]; [a requestRefresh]; RunFor(.02);
    Check(a.refreshCount==before+1,@"direct request promotes a queued passive refresh immediately");
    RunFor(.12); Check(a.refreshCount==before+1,@"superseded notification timer cannot publish twice");
    before=a.refreshCount; [a requestCoalescedRefresh]; [a refresh]; RunFor(.12);
    Check(a.refreshCount==before+1,@"synchronous user publication consumes pending notification work");

    // A scheduled wake-up is not a model event. Replaying layout/menu callbacks
    // must not manufacture another publication on a clean list.
    a=List(&host); before=a.refreshCount; NSUInteger cleanRevision=a.modelRevision;
    for (NSUInteger i=0;i<12;i++) [a scheduleRefresh];
    RunFor(.025);
    Check(a.refreshCount==before && !a.dirty && !a.scheduled && a.modelRevision==cleanRevision,@"clean scheduling wakes neither invalidate nor publish the list");
    __block BOOL wakeDuringPublication=YES;
    publicationMutation=^(CSGroupListAdapter *current) {
        if (wakeDuringPublication && current==a) { wakeDuringPublication=NO; [current scheduleRefresh]; }
    };
    [a requestRefresh]; RunFor(.025); publicationMutation=nil;
    Check(a.refreshCount==before+1 && !a.dirty && !a.scheduled,@"a clean UI wake during publication cannot create a follow-up refresh");

    // Native notifications delivered by a synchronous host callback during
    // reload retain their passive deadline after the outer publish unwinds.
    a=List(&host); before=a.refreshCount;
    __block BOOL notificationDuringPublication=YES;
    publicationMutation=^(CSGroupListAdapter *current) {
        if (notificationDuringPublication && current==a) {
            notificationDuringPublication=NO;
            [current beginNativeChangeOfKind:CSGroupChangeUnread];
            [current endNativeChangeCoalesced:YES];
        }
    };
    [a requestRefresh]; RunFor(.025); publicationMutation=nil;
    Check(a.refreshCount==before+1 && a.dirty && a.scheduled,@"native notification during publication retains its merge delay");
    RunFor(.12);
    Check(a.refreshCount==before+2 && !a.dirty && !a.scheduled && a.lastPublishedChanges==CSGroupChangeUnread,@"the deferred native notification publishes once with its real change kind");

    // A synchronous publication consumes the old timer. A later notification
    // owns a new deadline that the obsolete timer must not shorten.
    a=List(&host); before=a.refreshCount;
    [a requestCoalescedRefresh]; RunFor(.04); [a refresh];
    [a requestCoalescedRefresh]; RunFor(.055);
    Check(a.refreshCount==before+1 && a.scheduled,@"an obsolete notification timer cannot consume a newer event early");
    RunFor(.065);
    Check(a.refreshCount==before+2 && !a.scheduled,@"the newer notification keeps its own deadline after a synchronous publication");

    a=List(&host); before=a.refreshCount;
    [a endNativeChange]; RunFor(.025);
    Check(a.refreshCount==before && !a.dirty && !a.scheduled && !a.changeDepth,@"an unmatched native end cannot invent a model refresh");
    [a beginNativeChangeOfKind:CSGroupChangeUnread];
    [a beginNativeChangeOfKind:CSGroupChangeContent]; [a endNativeChange]; RunFor(.025);
    Check(a.refreshCount==before && a.changeDepth==1 && !a.scheduled,@"an inner native end waits for the real outer transaction");
    [a endNativeChange]; RunFor(.025);
    Check(a.refreshCount==before+1 && !a.changeDepth && !a.dirty && a.lastPublishedChanges==(CSGroupChangeUnread|CSGroupChangeContent),@"only the outer native end publishes all accumulated change kinds");

    a=List(&host);
    NSSet *namesA=[NSSet setWithObject:@"ordinary-a"],*namesB=[NSSet setWithObject:@"ordinary-b"];
    [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesA];
    [a beginNativeChange]; [a endNativeChange]; [a endNativeChange]; RunFor(.025);
    Check(a.lastPublishedContentIdentityKnown && [a.lastPublishedContentUserNames isEqual:namesA],@"generic native wrappers inherit the enclosing attributed session identity");
    [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesA];
    [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesB];
    [a endNativeChange]; [a endNativeChange]; RunFor(.025);
    Check(a.lastPublishedContentIdentityKnown && [a.lastPublishedContentUserNames isEqual:[namesA setByAddingObjectsFromSet:namesB]],@"nested real content events retain every affected session identity");
    [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesA];
    [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:nil];
    [a endNativeChange]; [a endNativeChange]; RunFor(.025);
    Check(!a.lastPublishedContentIdentityKnown,@"an explicitly unidentifiable nested content event cannot borrow a sibling identity");
    [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesA];
    [a beginNativeChangeOfKind:CSGroupChangeUnread sessionUserNames:namesB];
    [a beginNativeChange]; [a endNativeChange]; [a endNativeChange];
    Check([a.nativeChangeUserNames isEqual:namesA],@"ending a nested real event restores the outer session identity");
    [a endNativeChange]; RunFor(.025);
    Check(a.lastPublishedContentIdentityKnown && [a.lastPublishedContentUserNames isEqual:[namesA setByAddingObjectsFromSet:namesB]],@"a nested event's generic content wrapper uses that event's own identity");
    [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesA];
    [a beginNativeChangeOfKind:CSGroupChangeUnread sessionUserNames:nil];
    [a beginNativeChange]; [a endNativeChange]; [a endNativeChange];
    Check([a.nativeChangeUserNames isEqual:namesA],@"an explicitly unknown nested identity restores its outer scope when it ends");
    [a endNativeChange]; RunFor(.025);
    Check(!a.lastPublishedContentIdentityKnown && !a.nativeChangeIdentityStack.count,@"unknown nested content remains unattributed and balances every identity scope");

    // Native notifications can arrive off-main. Their identities cannot rely on
    // the adapter's shared LIFO scope, and publication must stay on the main loop.
    a=List(&host); before=a.refreshCount; NSUInteger backgroundBuilds=snapshotBuilds;
    __block BOOL nativeEventWasOffMain=NO;
    dispatch_semaphore_t nativeEventDone=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        nativeEventWasOffMain=!NSThread.isMainThread;
        [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesA];
        [a endNativeChangeCoalesced:YES];
        dispatch_semaphore_signal(nativeEventDone);
    });
    long nativeEventWait=dispatch_semaphore_wait(nativeEventDone,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC));
    Check(!nativeEventWait && nativeEventWasOffMain && snapshotBuilds==backgroundBuilds && a.refreshCount==before,@"a real background native event completes without native reads or publication off-main");
    RunFor(.12);
    Check(a.refreshCount==before+1 && !a.lastPublishedContentIdentityKnown && [a.lastPublishedContentUserNames isEqual:namesA] && !a.changeDepth && !a.nativeChangeIdentityStack.count,@"a background content event preserves its change and uses conservative content publication");

    a=List(&host); before=a.refreshCount;
    __block BOOL contentDuringPublication=YES;
    publicationMutation=^(CSGroupListAdapter *current) {
        if (contentDuringPublication && current==a) {
            contentDuringPublication=NO;
            [current beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesB];
            [current endNativeChangeCoalesced:YES];
        }
    };
    [a beginNativeChangeOfKind:CSGroupChangeContent sessionUserNames:namesA]; [a endNativeChange];
    RunFor(.025); publicationMutation=nil;
    Check(a.refreshCount==before+1 && [a.lastPublishedContentUserNames isEqual:namesA] && [a.pendingContentUserNames isEqual:namesB],@"a reentrant content event remains pending outside the already admitted publication");
    RunFor(.12);
    Check(a.refreshCount==before+2 && a.lastPublishedContentIdentityKnown && [a.lastPublishedContentUserNames isEqual:namesB] && !a.pendingContentUserNames,@"the next publication consumes the reentrant session identity exactly once");

    a=List(&host); before=a.refreshCount;
    [a requestCoalescedRefresh]; [a detach];
    Check(!a.scheduled,@"detaching immediately cancels a pending notification task");
    RunFor(.12);
    Check(a.refreshCount==before,@"a detached list cannot publish from its obsolete notification timer");

    a=List(&host); before=a.refreshCount;
    [a requestCoalescedRefresh]; NSString *scheduledAccount=account; NSUInteger scheduledEpoch=accountEpoch;
    account=@"account-scheduler-replacement"; accountEpoch++;
    RunFor(.12);
    Check(a.refreshCount==before && a.dirty && !a.scheduled,@"a scheduled task cannot publish after its account or epoch is replaced");
    [a requestRefresh]; RunFor(.025);
    Check(a.refreshCount==before+1 && [a.preferences.accountID isEqual:account] && !a.dirty,@"a real event in the replacement account wakes one current publication");
    account=scheduledAccount; accountEpoch=scheduledEpoch;

    a=List(&host); NSString *accountBeforeLogout=account; account=nil;
    NSUInteger nilAccountReloads=[(LifecycleTable *)a.table reloads];
    [a requestRefresh]; RunFor(.03);
    Check(!a.dirty && !a.scheduled && !a.publishing && !a.active && [(LifecycleTable *)a.table reloads]==nilAccountReloads+1,@"a queued logout publication accepts two nil accounts and settles in native presentation");
    [a refresh]; RunFor(.12);
    Check(!a.dirty && !a.scheduled && !a.publicationNeedsFullReload,@"a stable nil account cannot be mistaken for a superseded publication or create a refresh loop");
    account=accountBeforeLogout;

    a=List(&host); before=a.refreshCount;
    [a requestRefresh];
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:@"willResign" object:nil]];
    for (NSUInteger i=0;i<30;i++) { [a beginNativeChange]; [a endNativeChange]; }
    [a refresh]; [a layout]; RunFor(.08);
    Check(a.refreshCount==before && !a.scheduled && a.dirty,@"inactive app cancels queued refresh and defers every publication");
    actionBefore=actions; [a performInNativePresentation:^{ actions++; }]; RunFor(.03);
    Check(actions==actionBefore && a.nativeActions.count==1,@"inactive state defers even explicit navigation");
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:UIApplicationDidBecomeActiveNotification object:nil]];
    RunFor(.03);
    Check(actions==actionBefore+1 && !a.nativeActions.count,@"active notification resumes valid navigation once");
    a=List(&host); before=a.refreshCount; NSUInteger recoveryModelRevision=a.modelRevision;
    [a requestRecovery]; RunFor(.14);
    Check(a.refreshCount==before+1 && a.lastPublishedChanges==(CSGroupChangeUnknown|CSGroupChangeContent) && !a.lastPublishedContentIdentityKnown,@"placeholder recovery retries content even when native row metadata has not changed");
    Check(a.modelRevision==recoveryModelRevision && !a.dirty && !a.scheduled && a.recoveryAttempts==1,@"a successful conservative recovery settles without inventing a model revision");
    a=List(&host); before=a.refreshCount; failPublication=YES; [a requestRefresh]; RunFor(1.1);
    Check(a.refreshCount==before+4 && a.recoveryAttempts==3 && a.dirty && !a.scheduled,@"persistent render failure stops after three bounded delayed retries");
    before=a.refreshCount; [a requestRecovery]; [a requestRecovery]; RunFor(.12);
    Check(a.refreshCount==before && !a.scheduled,@"duplicate failures of the exhausted revision cannot restart a loop");
    a.pendingScrollToTop=YES;
    for (NSUInteger i=0;i<12;i++) [a scheduleRefresh];
    RunFor(.12);
    Check(a.refreshCount==before && !a.scheduled && a.recoveryAttempts==3,@"UI and return-to-top wakes cannot restart an exhausted recovery revision");
    a.pendingScrollToTop=NO;
    failPublication=NO; [a beginNativeChange]; [a endNativeChange]; RunFor(.03);
    Check(a.refreshCount==before+1 && !a.dirty,@"new model event wakes an exhausted recovery without waiting");
    a=List(&host); before=a.refreshCount; a.menuState=3; [a requestRefresh]; RunFor(2.5);
    Check(a.refreshCount==before && !a.scheduled && a.dirty,@"stuck menu animation exhausts interaction polling without forcing a reload");
    a.menuState=0; [a scheduleRefresh]; RunFor(.03);
    Check(a.refreshCount==before+1 && !a.dirty,@"real interaction end wakes work after polling budget exhaustion");
    a=List(&host); [host viewWillDisappear:NO]; before=a.refreshCount;
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:@"willResign" object:nil]];
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:UIApplicationDidBecomeActiveNotification object:nil]]; RunFor(.03);
    Check(a.refreshCount==before && a.presentationSuspended,@"app foreground does not unhide a covered chat list");
    a=List(&host);
    [a beginNativeChangeOfKind:CSGroupChangeUnread]; [a endNativeChangeCoalesced:YES]; RunFor(.12);
    Check(a.lastPublishedChanges==CSGroupChangeUnread && !a.pendingChanges,@"unread notification kind is consumed exactly once");
    [a beginNativeChangeOfKind:CSGroupChangeUnread]; [a beginNativeChangeOfKind:CSGroupChangeContent];
    [a endNativeChange]; [a endNativeChangeCoalesced:YES]; RunFor(.12);
    Check(a.lastPublishedChanges==(CSGroupChangeUnread|CSGroupChangeContent),@"nested content change cannot be downgraded to unread-only");
    a.table.tracking=YES; [a requestRefresh]; NSUInteger revision=a.modelRevision; RunFor(.2);
    Check(a.modelRevision==revision && a.dirty,@"interaction retries do not invalidate a valid snapshot repeatedly");
    a.table.tracking=NO; [a scheduleRefresh]; RunFor(.03);
    a=List(&host); before=a.refreshCount; failPublication=YES; rawPublicationFailure=YES;
    [a requestRefresh]; RunFor(1.1);
    Check(a.refreshCount==before+4 && !a.scheduled,@"generic refresh requests during publication also share the bounded recovery budget");
    failPublication=NO; rawPublicationFailure=NO;

    // A policy can change synchronously inside native reload. The old publish
    // owns neither that new request nor its temporary private-cell suppression.
    a=List(&host); before=a.refreshCount;
    UITableViewCell *reentrantSecret=Cell(@"secret"); a.table.visibleCells=@[reentrantSecret];
    __block BOOL lockDuringPublication=YES,shieldedDuringPublication=NO;
    publicationMutation=^(CSGroupListAdapter *current) {
        if (lockDuringPublication && current==a) {
            lockDuringPublication=NO; privacyEnabled=YES; policyRevision++;
            [CSGroupListAdapter closeFriendPolicyChanged:nil];
            shieldedDuringPublication=reentrantSecret.hidden;
        }
    };
    [a refresh]; publicationMutation=nil;
    Check(shieldedDuringPublication && reentrantSecret.hidden && a.privacyRefreshPending && a.dirty,@"a new privacy lock stays synchronously shielded after an older publication returns");
    Check(a.publicationNeedsFullReload,@"a superseded publication requires fresh table coordinates before incremental publication resumes");
    RunFor(.03);
    Check(a.refreshCount==before+2 && !a.privacyRefreshPending && !reentrantSecret.hidden && a.active,@"one current safe publication consumes the reentrant privacy lock and releases its shield");
    privacyEnabled=NO;

    a=List(&host); privacyEnabled=YES; enabled=NO; before=a.refreshCount;
    [a refresh];
    Check(a.refreshCount==before+1 && a.active,@"privacy reaches publication with grouping disabled");
    host.isSearching=YES; a.searchChromeVisible=YES; before=a.refreshCount; [a refresh];
    Check(a.refreshCount==before+1 && a.active,@"search cannot bypass privacy projection or preserve stale rows");
    a.table.tracking=YES; a.table.editing=YES; a.menuState=3; before=a.refreshCount;
    [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(a.refreshCount==before+1 && !a.table.hidden && !a.privacyRefreshPending,@"privacy refresh bypasses tracking/edit/menu deferral and republishes immediately");
    [a beginNativeChange]; before=a.refreshCount; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(!a.table.hidden && a.privacyRefreshPending && a.refreshCount==before,@"policy change preserves list container while native transaction is open");
    [a endNativeChange]; RunFor(.03);
    Check(!a.table.hidden && a.refreshCount==before+1,@"transaction completion publishes current privacy and releases temporary shield");
    a.table.tracking=NO; a.table.editing=NO; a.menuState=0;
    a.publishing=YES; actionBefore=actions; [a performInNativePresentation:^{actions++;}]; a.publishing=NO;
    [a refresh]; Check(actions==actionBefore+1 && a.active && !a.nativeActions.count,@"native action drains through privacy projection without disabling it");
    a.publishing=YES; actionBefore=actions; [a performInNativePresentation:^{actions++;}]; a.publishing=NO;
    accountEpoch++; [a refresh];
    Check(actions==actionBefore && !a.nativeActions.count,@"same-account epoch replacement discards queued native action");
    privacyEnabled=NO; enabled=YES;
    // Device recording: opening the switcher locks close friends while the list
    // is still visible. The privacy publication must not wait for foreground.
    a=List(&host); before=a.refreshCount; privacyEnabled=YES;
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:@"willResign" object:nil]];
    [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(!a.table.hidden,@"switcher privacy lock keeps the list/header container visible (no title-only frame)");
    Check(a.refreshCount==before+1 && !a.privacyRefreshPending,@"switcher privacy lock synchronously publishes safe rows before foreground");
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:UIApplicationDidBecomeActiveNotification object:nil]];
    RunFor(.03); privacyEnabled=NO;

    // Deferred publication: suppress only private cells, with no visual transition.
    a=List(&host); privacyEnabled=YES;
    UIWindow *window=[UIWindow new]; [window addSubview:a.table];
    UITableViewCell *ordinary=Cell(@"ordinary"), *secret=Cell(@"secret");
    a.table.visibleCells=@[ordinary,secret]; [a.table addSubview:ordinary]; [a.table addSubview:secret];
    UIView *header=[UIView new]; a.table.tableHeaderView=header;
    [a beginNativeChange]; before=a.refreshCount;
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:@"willResign" object:nil]];
    [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(!a.table.hidden && a.table.tableHeaderView==header && !ordinary.subviews.count,@"native transaction preserves header and ordinary conversation during switcher lock");
    Check(secret.hidden && !secret.subviews.count,@"pending private row disappears silently without adding a placeholder");
    Check(secret.hidden && !ordinary.hidden && !a.table.hidden,@"only private cell is excluded from rendering, interaction and accessibility");
    [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(secret.hidden && !secret.subviews.count && a.refreshCount==before,@"repeated policy events remain silent and never publish inside native mutation");
    [a endNativeChange]; RunFor(.03);
    Check(a.refreshCount==before+1 && !a.privacyRefreshPending && !a.table.hidden && !secret.hidden,@"inactive native transaction completion releases cell suppression after one safe publication");
    Check(secret.userInteractionEnabled && secret.isAccessibilityElement && [secret.accessibilityElements isEqual:@[@"original-cell"]],@"publication releases row interaction and accessibility ownership");
    CAKeyframeAnimation *shake=(id)[a.table.layer animationForKey:@"CSCloseFriendHideShake"];
    CAKeyframeAnimation *settle=(id)[a.table.layer animationForKey:@"CSCloseFriendHideSettle"];
    Check(!shake,@"silent hiding must not submit a shake animation");
    Check(!settle && CATransform3DIsIdentity(a.table.layer.transform),@"silent hiding must not submit a scale animation or change table transform");
    a.table.visibleCells=@[ordinary]; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check([a.table.layer animationForKey:@"CSCloseFriendHideShake"]==nil,@"repeated lock remains silent with no delayed animation");
    before=a.refreshCount; [a requestRefresh]; RunFor(.03);
    Check(a.refreshCount==before && !a.scheduled,@"privacy exception does not enable passive background refresh loops");
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:UIApplicationDidEnterBackgroundNotification object:nil]];
    Check(![a.table.layer animationForKey:@"CSCloseFriendHideShake"] && ![a.table.layer animationForKey:@"CSCloseFriendHideSettle"],@"true background contains no hiding animation");
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:UIApplicationDidBecomeActiveNotification object:nil]];
    RunFor(.03);
    // Reduce Motion / suspension never depend on an animation completion callback.
    CSTestReduceMotionEnabled=YES; a.table.visibleCells=@[secret]; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(!secret.hidden && !secret.subviews.count && ![a.table.layer animationForKey:@"CSCloseFriendHideShake"],@"Reduce Motion also completes silent privacy publication without any overlay");
    CSTestReduceMotionEnabled=NO; UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(!secret.subviews.count && ![a.table.layer animationForKey:@"CSCloseFriendHideShake"],@"already-background lock never starts a suspended animation");
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    [host viewWillDisappear:NO]; before=a.refreshCount; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(a.refreshCount==before && secret.hidden && !a.table.hidden,@"offscreen owner stays deferred with private rows suppressed, not a hidden table");
    [host viewWillAppear:NO];
    Check(!secret.hidden && a.refreshCount==before+1,@"return from protected chat publishes and releases cell suppression");
    a.table.visibleCells=@[ordinary,secret]; policyBlocked=YES; [a beginNativeChange]; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(ordinary.hidden && secret.hidden && !a.table.hidden,@"unreadable policy suppresses unknown rows without removing list chrome");
    policyBlocked=NO; [a endNativeChange]; RunFor(.03);
    a.table.hidden=YES; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(a.table.hidden,@"privacy publication preserves pre-existing native table visibility");
    a.table.hidden=NO;
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:@"willResign" object:nil]];
    privacyEnabled=NO; before=a.refreshCount; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(a.refreshCount==before && a.privacyRefreshPending,@"inactive exception cannot publish a reveal or unlock");
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:UIApplicationDidBecomeActiveNotification object:nil]];
    RunFor(.03);
    a=List(&host); privacyEnabled=YES; secret=Cell(@"secret"); a.table.visibleCells=@[secret];
    publicationMutation=^(id current){ if (current==a) [NSException raise:@"FixtureNativePublicationFailure" format:@"native reload interrupted"]; };
    BOOL threw=NO;
    @try { [CSGroupListAdapter closeFriendPolicyChanged:nil]; } @catch (NSException *exception) { threw=[exception.name isEqual:@"FixtureNativePublicationFailure"]; }
    Check(threw && a.privacyRefreshPending && secret.hidden && !a.table.hidden,@"failed native publication suppresses private rows before unwinding without blanking list");
    publicationMutation=^(id current){ if (current==a) { secret.isAccessibilityElement=YES; secret.accessibilityElements=@[@"new-native-cell"]; secret.userInteractionEnabled=NO; } };
    [a refresh]; publicationMutation=nil;
    Check(!secret.subviews.count && secret.isAccessibilityElement && [secret.accessibilityElements isEqual:@[@"new-native-cell"]] && !secret.userInteractionEnabled,@"cell reuse keeps freshly configured accessibility and interaction after publication");
    NSString *previousAccount=account; account=@""; policyBlocked=YES;
    [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(secret.hidden && !a.table.hidden,@"account-unavailable fallback suppresses private rows after native reload without hiding table");
    account=previousAccount; policyBlocked=NO; [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(!secret.hidden,@"resolved account releases cell suppression after safe publication");
    privacyEnabled=NO;
    // Replay both native owner lifecycles against independently cached adapters.
    Host *groupHost=nil;CSGroupListAdapter *groupOwner=List(&groupHost);
    Host *foldedHost=[Host new];foldedHost.folded=YES;foldedHost.m_tableView=[LifecycleTable new];
    [CSGroupListAdapter attachToController:foldedHost];CSGroupListAdapter *foldedOwner=Adapter(foldedHost);
    [groupOwner selectIndex:1];RunFor(.03);
    Check([groupOwner.publishedTabID isEqual:@"custom-a"] && [foldedOwner.publishedTabID isEqual:@"custom-a"],@"selecting main group refreshes a visible folded owner of the same account");
    FoldedDisappear(foldedHost,@selector(viewWillDisappear:),NO);before=foldedOwner.refreshCount;
    [groupOwner selectIndex:2];RunFor(.03);
    Check(foldedOwner.presentationSuspended && foldedOwner.dirty && foldedOwner.refreshCount==before,@"switching group keeps hidden folded owner deferred");
    FoldedAppear(foldedHost,@selector(viewDidAppear:),NO);RunFor(.03);
    Check(!foldedOwner.presentationSuspended && [foldedOwner.publishedTabID isEqual:@"custom-b"] && foldedOwner.refreshCount==before+1,@"folded appearance reloads selected group before publishing once");
    Check(!groupOwner.nativePresentation && [groupOwner.preferences.selectedTabID isEqual:@"custom-b"],@"folded lifecycle never forces parent selection to All");
    foldedOwner.preferences.accountID=@"stale-account";before=foldedOwner.refreshCount;
    [groupOwner selectIndex:1];RunFor(.03);
    Check(foldedOwner.refreshCount==before,@"selection broadcast does not refresh another account's stale folded owner");
#if CS_GROUP_LIFECYCLE_TAB_BADGE
    // Full production decision, source request/refresh, native begin/end and
    // notification paths run here. Only the immutable native row reader and UI
    // publication sink are host boundaries; source timing is not hand-set.
    RunFor(.03);[Adapters() removeAllObjects];
    enabled=NO;privacyEnabled=NO;badgePolicyEnabled=NO;policyFriends=@[];policyOptions=nil;policyRevealed=NO;policyRevision++;
    NSUInteger coldBuilds=snapshotBuilds;
    __block NSUInteger sourceEvents=0;
    __block BOOL sourceSawReady=NO,sourceSawDot=NO;
    __block NSUInteger sourceCount=0,sourceRevision=0;
    __block id sourceController=nil;
    __block void (^sourceMutation)(CSGroupListAdapter *source);
    id sourceObserver=[NSNotificationCenter.defaultCenter addObserverForName:CSGroupTabBadgeSourceDidRefreshNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        CSGroupListAdapter *source=note.object;
        CSGroupTabBadgeDecision *decision=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:source.controller includeNative:YES];
        sourceEvents++;sourceSawReady=!source.publishing && !source.changeDepth && decision.badge && decision.sourceController==source.controller;
        sourceSawDot=decision.badge.redDot && decision.badge.count==0;sourceCount=decision.badge.count;sourceRevision=decision.sourceRevision;sourceController=decision.sourceController;
        if(sourceMutation)sourceMutation(source);
    }];
    a=List(&host);[a refresh];[a refresh];RunFor(.03);
    Check(snapshotBuilds==coldBuilds && !a.cachedNativeSections && !a.tabBadgeSections && !a.tabAlertBadge,@"cold empty protection list with grouping off never reads or retains a native badge snapshot");
    Check(sourceEvents==0 && !a.active && !a.tabBadgeSourceScheduled,@"cold empty protection list never schedules or publishes badge-source work");
    enabled=YES;[a refresh];RunFor(.02);
    Check(a.active && a.cachedNativeSections && !a.tabAlertBadge && !sourceEvents,@"empty list with grouping on builds only the group source, without acquiring tab badge ownership");
    coldBuilds=snapshotBuilds;enabled=NO;[a refresh];[a refresh];RunFor(.02);
    Check(snapshotBuilds==coldBuilds && !a.cachedNativeSections && !a.tabBadgeSections && !sourceEvents,@"grouping off after an empty-list publication adds no badge source reads");

    [Adapters() removeAllObjects];sourceEvents=0;
    Host *lateHost=[Host new];
    CSGroupTabBadgeDecision *latePending=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:lateHost includeNative:YES];
    Check(latePending && !latePending.badge && ![CSGroupListAdapter adapterForController:lateHost],@"an explicit native restoration request can stay pending before its root adapter exists");
    NSUInteger latePath[]={0,0};CSGroupRow *lateRow=[[CSGroupRow alloc]initWithNativePath:[NSIndexPath indexPathWithIndexes:latePath length:2] userName:@"ordinary" kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:6 redDot:NO];
    fixtureNativeSections=@[@[lateRow]];lateHost.m_tableView=[LifecycleTable new];coldBuilds=snapshotBuilds;
    [CSGroupListAdapter attachToController:lateHost];RunFor(.02);
    Check(sourceEvents==1 && sourceSawReady && sourceCount==6 && sourceController==lateHost && snapshotBuilds==coldBuilds+1,@"late attachment consumes the explicit root request and publishes one verified native source");
    Check(![CSGroupListAdapter closeFriendTabBadgeDecisionForController:lateHost includeNative:NO],@"late native restoration never enables filtering or takes ordinary setter ownership");
    sourceEvents=0;coldBuilds=snapshotBuilds;[CSGroupListAdapter attachToController:lateHost];RunFor(.02);
    Check(!sourceEvents && snapshotBuilds==coldBuilds,@"a consumed late-attach restoration request does not persistently rebuild native sources");
    [Adapters() removeAllObjects];
    for(NSString *stale in @[@"epoch",@"account"]){
        Host *staleHost=[Host new];[CSGroupListAdapter closeFriendTabBadgeDecisionForController:staleHost includeNative:YES];NSString *savedAccount=account;
        if([stale isEqual:@"epoch"])accountEpoch++;else account=@"replacement-account";
        staleHost.m_tableView=[LifecycleTable new];sourceEvents=0;coldBuilds=snapshotBuilds;[CSGroupListAdapter attachToController:staleHost];RunFor(.02);
        Check(!sourceEvents && snapshotBuilds==coldBuilds,@"a late-attach request from another account or epoch is discarded without source reads");account=savedAccount;[Adapters() removeAllObjects];
    }
    fixtureNativeSections=nil;sourceEvents=0;

    [Adapters() removeAllObjects];policyFriends=@[@"secret"];badgePolicyEnabled=YES;policyRevealed=YES;policyOptions=@{@"silenceMessages":@YES};policyRevision++;
    coldBuilds=snapshotBuilds;a=List(&host);RunFor(.02);
    Check(![CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO] && !sourceEvents && snapshotBuilds==coldBuilds && !a.tabBadgeSections,@"revealed legacy silence option does not filter badges or acquire a badge source");
    [Adapters() removeAllObjects];policyRevealed=NO;policyOptions=@{@"hideSessions":@NO,@"silenceMessages":@YES};policyRevision++;
    a=List(&host);RunFor(.02);
    Check(![CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO] && !sourceEvents && snapshotBuilds==coldBuilds && !a.tabBadgeSourceRequired,@"locked legacy silence option with session hiding off leaves native badge ownership intact");
    [Adapters() removeAllObjects];policyOptions=@{@"hideSessions":@YES,@"silenceMessages":@YES};policyRevision++;
    CSGroupRow *(^nativeRow)(NSString *,NSUInteger,BOOL,BOOL)=^CSGroupRow *(NSString *name,NSUInteger count,BOOL dot,BOOL first){NSUInteger path[]={0,first?0:1};return [[CSGroupRow alloc]initWithNativePath:[NSIndexPath indexPathWithIndexes:path length:2] userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:count redDot:dot];};
    fixtureNativeSections=@[@[nativeRow(@"secret",3,NO,YES),nativeRow(@"ordinary",7,NO,NO)]];
    a=List(&host);
    Check(!a.active && !a.cachedNativeSections && ![CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO].badge,@"concealed session policy starts pending with grouping off and no UI cache");
    RunFor(.02);
    Check(sourceEvents==1 && sourceSawReady && sourceCount==7 && sourceController==host && sourceRevision==a.modelRevision,@"real source reader publishes ordinary 7 while protected sessions are concealed");
    Check(!a.active && !a.cachedNativeSections && a.tabBadgeSections && !a.tabBadgeSourceScheduled,@"source maintenance does not activate grouping or install the UI cache");
    [host viewWillDisappear:NO];RunFor(.02);before=a.refreshCount;layouts=a.layoutCount;NSUInteger sourceAnchors=a.anchorOrTitleCount;
    sourceEvents=0;
    [a beginNativeChange];
    Check(![CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO].badge,@"beginNativeChange invalidates the badge source before a synchronous native setter can read it");
    fixtureNativeSections=@[@[nativeRow(@"secret",3,NO,YES),nativeRow(@"ordinary",9,NO,NO)]];
    RunFor(.005);Check(!sourceEvents,@"an unfinished native transaction never publishes a badge source");
    [a endNativeChange];RunFor(.02);
    Check(sourceEvents==1 && sourceSawReady && sourceCount==9 && sourceRevision==a.modelRevision,@"endNativeChange rebuilds and publishes the latest source without returning to the list");
    Check(a.presentationSuspended && a.refreshCount==before && a.layoutCount==layouts && a.anchorOrTitleCount==sourceAnchors,@"offscreen badge maintenance performs no list reload, header layout or anchor work");
    sourceEvents=0;NSUInteger offscreenBuilds=snapshotBuilds;
    NSTimer *burstTimer=nil;
    for(NSUInteger i=0;i<20;i++){
        [a beginNativeChangeOfKind:CSGroupChangeUnread];
        fixtureNativeSections=@[@[nativeRow(@"secret",3,NO,YES),nativeRow(@"ordinary",10+i,NO,NO)]];
        [a endNativeChangeCoalesced:YES];
        if(!burstTimer)burstTimer=a.tabBadgeSourceTimer;
        Check(a.tabBadgeSourceTimer==burstTimer,@"separate passive notifications reuse one pending badge timer");
        RunFor(.004);
    }
    Check(!sourceEvents && snapshotBuilds==offscreenBuilds,@"twenty offscreen notifications wait until the latest-event deadline");
    CSGroupTabBadgeDecision *burstPending=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO];
    Check(!burstPending.badge && a.tabBadgeSourceTimer==burstTimer,@"a pending badge query does not bypass passive coalescing");
    RunFor(.1);
    Check(sourceEvents==1 && snapshotBuilds==offscreenBuilds+1 && sourceCount==29,@"twenty offscreen notifications publish the newest count with one native read");
    Check(a.refreshCount==before && a.layoutCount==layouts && a.anchorOrTitleCount==sourceAnchors,@"independent offscreen source events still perform zero grouping UI work");
    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    for(NSUInteger i=0;i<200;i++){[a beginNativeChange];[a endNativeChangeCoalesced:YES];}
    RunFor(.02);Check(!sourceEvents && a.tabBadgeSourceTimer,@"two hundred native notifications retain a single delayed badge task");
    RunFor(.1);Check(sourceEvents==1 && snapshotBuilds==offscreenBuilds+1 && !a.tabBadgeSourceTimer,@"one synchronous burst of two hundred native changes coalesces to one source rebuild");

    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    [a beginNativeChange];[a endNativeChangeCoalesced:YES];RunFor(.04);
    [a beginNativeChange];[a endNativeChangeCoalesced:YES];RunFor(.05);
    Check(!sourceEvents,@"a later notification moves the 80ms trailing deadline beyond the first deadline");
    RunFor(.05);Check(sourceEvents==1 && snapshotBuilds==offscreenBuilds+1,@"the trailing timer publishes once after the final message");

    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    for(NSUInteger i=0;i<8;i++){
        [a beginNativeChange];[a endNativeChangeCoalesced:YES];
        Check(a.tabBadgeDue<=a.tabBadgeBurstStart+.250001,@"continuous notification deadlines never exceed 250ms from the first event");
        RunFor(.03);
    }
    RunFor(.06);
    Check(sourceEvents==1 && snapshotBuilds==offscreenBuilds+1 && !a.tabBadgeSourceScheduled,@"continuous notifications flush at the maximum window instead of waiting for silence");

    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    [a beginNativeChange];[a endNativeChangeCoalesced:YES];NSTimer *supersededTimer=a.tabBadgeSourceTimer;
    policyRevision++;[CSGroupListAdapter closeFriendPolicyChanged:nil];RunFor(.02);
    Check(sourceEvents==1 && !supersededTimer.valid && !a.tabBadgeSourceTimer,@"privacy changes immediately supersede an ordinary pending badge timer");
    [supersededTimer fire];RunFor(.1);
    Check(sourceEvents==1 && snapshotBuilds==offscreenBuilds+1,@"a superseded privacy timer cannot read or publish a second source");

    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    [a beginNativeChange];[a endNativeChangeCoalesced:YES];supersededTimer=a.tabBadgeSourceTimer;
    accountEpoch++;policyRevision++;[CSGroupListAdapter closeFriendPolicyChanged:nil];RunFor(.02);
    Check(sourceEvents==1 && a.tabBadgeEpoch==accountEpoch && !supersededTimer.valid,@"account-epoch changes replace the pending task with a current immediate source");
    [supersededTimer fire];RunFor(.1);
    Check(sourceEvents==1 && snapshotBuilds==offscreenBuilds+1,@"the old account-epoch task cannot publish after replacement");

    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    [a beginNativeChange];[a endNativeChangeCoalesced:YES];supersededTimer=a.tabBadgeSourceTimer;
    policyRevision++;
    burstPending=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO];
    Check(!burstPending.badge && !supersededTimer.valid,@"a lookup observing a newer privacy token immediately invalidates a stale passive task");
    RunFor(.02);Check(sourceEvents==1 && snapshotBuilds==offscreenBuilds+1,@"a newer-token lookup recovers without waiting for a separate policy notification");

    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    [a requestTabBadgeSourceRefresh];RunFor(.02);
    Check(!sourceEvents && snapshotBuilds==offscreenBuilds,@"unchanged source versions reuse sections and badge computation without another publication");

    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    [a beginNativeChange];[a endNativeChangeCoalesced:YES];[a beginNativeChange];RunFor(.1);
    Check(!sourceEvents && snapshotBuilds==offscreenBuilds,@"a timer reaching its deadline cannot read inside a native transaction");
    [a endNativeChangeCoalesced:YES];RunFor(.1);
    Check(sourceEvents==1 && sourceSawReady && snapshotBuilds==offscreenBuilds+1,@"a stable outer end wakes one badge read after a blocked deadline");

    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    dispatch_semaphore_t workerDone=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        for(NSUInteger i=0;i<100;i++){[a beginNativeChangeOfKind:CSGroupChangeUnread];[a endNativeChangeCoalesced:YES];}
        dispatch_semaphore_signal(workerDone);
    });
    dispatch_semaphore_wait(workerDone,DISPATCH_TIME_FOREVER);RunFor(.02);
    Check(!sourceEvents && a.tabBadgeSourceTimer,@"background notification bursts forward one passive request without native reads");
    RunFor(.1);Check(sourceEvents==1 && snapshotBuilds==offscreenBuilds+1 && sourceSawReady,@"background notification sources are read once on the main thread after the merge window");
    sourceEvents=0;offscreenBuilds=snapshotBuilds;[a beginNativeChange];[a beginNativeChange];[a endNativeChange];RunFor(.005);
    Check(!sourceEvents && snapshotBuilds==offscreenBuilds,@"nested native transaction waits for the outer end");
    [a endNativeChange];RunFor(.02);Check(sourceEvents==1 && sourceSawReady,@"outer native end releases one source publication");

    sourceEvents=0;__block BOOL mutateOnSource=YES;
    sourceMutation=^(CSGroupListAdapter *source){if(mutateOnSource){mutateOnSource=NO;[source beginNativeChange];fixtureNativeSections=@[@[nativeRow(@"secret",3,NO,YES),nativeRow(@"ordinary",33,NO,NO)]];[source endNativeChange];}};
    [a beginNativeChange];[a endNativeChange];RunFor(.03);sourceMutation=nil;
    Check(sourceEvents==2 && sourceCount==33 && sourceRevision==a.modelRevision && !a.tabBadgeSourceScheduled && !a.tabBadgeRefreshAgain,@"source notification reentry with a real native transaction schedules exactly one newer source");
    Check(a.refreshCount==before && a.layoutCount==layouts,@"reentrant source transactions leave offscreen grouping UI untouched");

    sourceEvents=0;[a beginNativeChange];[a endNativeChange];
    __block BOOL flipEpoch=YES;snapshotMutation=^(id current){(void)current;if(flipEpoch){flipEpoch=NO;accountEpoch++;}};RunFor(.02);snapshotMutation=nil;
    Check(!sourceEvents && ![CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO].badge,@"epoch mutation inside the actual row reader prevents stale source publication");
    [a requestTabBadgeSourceRefresh];RunFor(.02);Check(sourceEvents==1 && sourceSawReady && a.tabBadgeEpoch==accountEpoch,@"the next source event recovers only in the current epoch");
    sourceEvents=0;[a beginNativeChange];[a endNativeChange];mutateDuringSnapshot=YES;RunFor(.02);mutateDuringSnapshot=NO;
    Check(!sourceEvents && a.tabBadgeRevision!=a.modelRevision,@"model mutation inside the actual reader cannot publish a mismatched revision");
    offscreenBuilds=snapshotBuilds;RunFor(.03);Check(snapshotBuilds==offscreenBuilds && !a.tabBadgeSourceScheduled,@"an unstable source does not start an endless retry or timer");
    [a beginNativeChange];[a endNativeChange];RunFor(.02);Check(sourceEvents==1 && sourceSawReady,@"a later native event recovers after the unstable source ends");

    sourceEvents=0;[a beginNativeChange];[a endNativeChangeCoalesced:YES];supersededTimer=a.tabBadgeSourceTimer;
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:@"willResign" object:nil]];RunFor(.02);offscreenBuilds=snapshotBuilds;
    Check(!supersededTimer.valid && !a.tabBadgeSourceScheduled,@"application inactivity cancels the pending passive badge task");
    [a beginNativeChange];[a endNativeChange];RunFor(.02);Check(!sourceEvents && snapshotBuilds==offscreenBuilds,@"inactive app neither reads nor publishes badge sources");
    [CSGroupListAdapter applicationActivityChanged:[NSNotification notificationWithName:UIApplicationDidBecomeActiveNotification object:nil]];RunFor(.02);
    Check(sourceEvents==1 && sourceSawReady && a.refreshCount==before,@"foreground activity restores the offscreen source without publishing grouping UI");
    [supersededTimer fire];RunFor(.1);Check(sourceEvents==1,@"the superseded pre-background timer cannot publish after foreground recovery");

    [a beginNativeChange];[a endNativeChangeCoalesced:YES];supersededTimer=a.tabBadgeSourceTimer;
    fixtureNativeSections=@[@[nativeRow(@"secret",3,YES,YES),nativeRow(@"ordinary",2,YES,NO)]];policyFriends=@[];badgePolicyEnabled=NO;policyRevision++;sourceEvents=0;
    CSGroupTabBadgeDecision *nativePending=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:YES];
    Check(!nativePending.badge && !supersededTimer.valid && a.tabBadgeRestorePending,@"explicit native restoration immediately promotes an ordinary pending source");
    RunFor(.02);
    Check(![CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO],@"removing the final protected name returns ordinary interception to Native");
    Check(sourceEvents==1 && sourceSawReady && sourceSawDot && !a.tabBadgeSourceRequired && !a.tabBadgeRestorePending,@"clearing the final name offscreen publishes one verified native-dot source and completes source restoration");
    Check(a.presentationSuspended && a.refreshCount==before && a.layoutCount==layouts,@"native-dot recovery leaves the hidden grouping UI suspended");
    sourceEvents=0;offscreenBuilds=snapshotBuilds;[a beginNativeChange];[a endNativeChange];RunFor(.02);[CSGroupListAdapter requestTabBadgeSourcesRefresh];RunFor(.02);
    Check(!sourceEvents && snapshotBuilds==offscreenBuilds,@"after restoration native-only changes add no repeated source reads or publications");

    policyFriends=@[@"secret"];badgePolicyEnabled=YES;policyRevision++;[CSGroupListAdapter closeFriendPolicyChanged:nil];RunFor(.02);sourceEvents=0;
    __block BOOL restorationReentry=YES,restorationRequested=NO;
    sourceMutation=^(CSGroupListAdapter *source){if(restorationReentry){restorationReentry=NO;[source beginNativeChange];fixtureNativeSections=@[@[nativeRow(@"ordinary",5,NO,YES)]];[source endNativeChange];CSGroupTabBadgeDecision *pending=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:source.controller includeNative:YES];restorationRequested=!pending.badge && source.tabBadgeRestorePending;}};
    badgePolicyEnabled=NO;policyRevision++;[CSGroupListAdapter closeFriendPolicyChanged:nil];RunFor(.03);sourceMutation=nil;
    if(!(restorationRequested && sourceEvents==2 && sourceCount==5))fprintf(stderr,"RESTORE reentry requested=%d events=%lu count=%lu model=%lu source=%lu pending=%d again=%d scheduled=%d required=%d\n",restorationRequested,(unsigned long)sourceEvents,(unsigned long)sourceCount,(unsigned long)a.modelRevision,(unsigned long)a.tabBadgeRevision,a.tabBadgeRestorePending,a.tabBadgeRefreshAgain,a.tabBadgeSourceScheduled,a.tabBadgeSourceRequired);
    Check(restorationRequested && sourceEvents==2 && sourceCount==5 && !a.tabBadgeRestorePending && !a.tabBadgeRefreshAgain,@"native-restoration consumer reentry retains pending debt and publishes the newer real source once");
    Check(sourceEvents==2 && sourceSawReady && ![CSGroupListAdapter closeFriendTabBadgeDecisionForController:host includeNative:NO],@"disabling protection with names retained returns to Native after the reentrant source settles");
    badgePolicyEnabled=YES;policyRevision++;[CSGroupListAdapter closeFriendPolicyChanged:nil];RunFor(.02);
    sourceEvents=0;offscreenBuilds=snapshotBuilds;
    [a beginNativeChange];[a endNativeChangeCoalesced:YES];supersededTimer=a.tabBadgeSourceTimer;
    [a detach];[supersededTimer fire];RunFor(.1);
    Check(!supersededTimer.valid && !sourceEvents && snapshotBuilds==offscreenBuilds,@"detaching an adapter invalidates its sole pending badge task");
    [NSNotificationCenter.defaultCenter removeObserver:sourceObserver];
    fixtureNativeSections=nil;policyFriends=nil;badgePolicyEnabled=NO;policyOptions=nil;policyRevealed=NO;enabled=YES;
#endif
    fprintf(stdout,"Group lifecycle: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
