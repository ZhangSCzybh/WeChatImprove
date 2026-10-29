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
#include "GroupLifecycleTabBadgeDependencies.h"
#include "GroupLifecycleTabBadgeImplementation.inc"
@class CSGroupListAdapter;
@interface LifecycleTable : UITableView @end
@interface Host : NSObject
@property(nonatomic,strong) UITableView *m_tableView;
@property(nonatomic) BOOL isSearching;
@property(nonatomic) BOOL folded;
@property(nonatomic) NSUInteger originalCalls;
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
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:account profile:@{@"enabled":@(privacyEnabled),@"friends":policyFriends ?: @[@"secret"],@"groups":@[],@"options":@{}} revealed:NO revision:1 blocked:policyBlocked];
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
@property(nonatomic,copy) NSArray *tabAlertBadgeKey;
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision;
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:(BOOL)includeNative;
#endif
@property(nonatomic,copy) NSString *nativeActionsAccount;
@property(nonatomic,copy) NSString *publishedTabID;
@property(nonatomic,strong) NSArray *displayedTabs;
@property(nonatomic,weak) UITableView *table;
@property(nonatomic,weak) Host *controller;
@property(nonatomic,strong) NSMutableDictionary *proxies,*anchors;
@property(nonatomic,strong) NSMutableArray *completions,*nativeActions;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) id nativeHeader,projection,identityDisplayPaths;
@property(nonatomic) BOOL chromeVisible,searchChromeVisible,privacyRefreshPending,privacyShielded,privacyTableWasHidden;
@property(nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property(nonatomic) CSGroupChangeKind lastPublishedChanges;
@property(nonatomic,strong) LifecycleChrome *chrome;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic) double baselineDeceleration;
@property(nonatomic) BOOL active,presentationSuspended,publishedEnabled,searching,dirty,scheduled,publishing,groupPanMoving,swipeActive,nativePresentation,updatingHeader,snapshotRetryAttempted;
@property(nonatomic) NSUInteger changeDepth,snapshotRetryGeneration,refreshCount,layoutCount,anchorOrTitleCount,menuReads,menuState;
@property(nonatomic) BOOL pendingScrollToTop;
+ (instancetype)adapterForController:(id)controller;
+ (instancetype)adapterForTable:(id)table;
+ (void)setPresentationSuspended:(BOOL)value forController:(id)controller;
- (void)refresh;
- (void)requestRefresh;
- (void)finishSuspendedBatches;
- (void)saveAnchor;
- (void)refreshNavigationTitle;
- (void)useNativePresentation;
- (void)shieldVisiblePrivateRows;
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
- (void)detach {
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
    (void)controller; (void)table; snapshotBuilds++;
    if (mutateDuringSnapshot) [source invalidateNativeSnapshot];
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
    [Adapter(self) requestRefresh];
}
#include "GroupLifecycleHooks.h"
@end
static void FoldedAppearOriginal(id owner,SEL selector,BOOL animated) { (void)selector;[owner nativeAppearance:animated]; }
static void FoldedDisappearOriginal(id owner,SEL selector,BOOL animated) { (void)selector;[owner nativeAppearance:animated]; }
#include "FoldedLifecycleHooks.h"
@implementation LifecycleTable
#include "GroupLifecycleReload.h"
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
    Check(snapshotBuilds==builds+2 && !a.active,@"disabled grouping with protected names rebuilds only a reliable badge source, without activating grouping");
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
    a=List(&host); before=a.refreshCount; failPublication=YES; [a requestRefresh]; RunFor(1.1);
    Check(a.refreshCount==before+4 && a.recoveryAttempts==3 && a.dirty && !a.scheduled,@"persistent render failure stops after three bounded delayed retries");
    before=a.refreshCount; [a requestRecovery]; [a requestRecovery]; RunFor(.12);
    Check(a.refreshCount==before && !a.scheduled,@"duplicate failures of the exhausted revision cannot restart a loop");
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
    // Run the real non-projection branch and @finally source publication. A tab
    // decision fixture would miss the last-protected-name recovery regression.
    [Adapters() removeAllObjects];
    enabled=NO; privacyEnabled=NO; policyFriends=@[];
    NSUInteger coldBuilds=snapshotBuilds;
    __block NSUInteger sourceEvents=0;
    __block BOOL sourceSawReady=NO,sourceSawDot=NO;
    id sourceObserver=[NSNotificationCenter.defaultCenter addObserverForName:CSGroupTabBadgeSourceDidRefreshNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        CSGroupListAdapter *source=note.object;
        CSGroupTabBadgeDecision *decision=[CSGroupListAdapter closeFriendTabBadgeDecisionForPublication:YES];
        sourceEvents++;
        sourceSawReady=!source.publishing && !source.dirty && !source.changeDepth && source.cachedNativeSections && decision.badge;
        sourceSawDot=decision.badge.redDot && decision.badge.count==0;
    }];
    a=List(&host); [a refresh]; [a refresh];
    Check(snapshotBuilds==coldBuilds && !a.cachedNativeSections && !a.tabAlertBadge,@"cold empty protection list with grouping off never reads or retains a native badge snapshot");
    Check(sourceEvents==0 && !a.active,@"cold empty protection list never publishes a badge-source event or activates grouping");
    enabled=YES; [a refresh];
    Check(a.active && a.cachedNativeSections && !a.tabAlertBadge && !sourceEvents,@"cold empty list with grouping on builds only the group source, without acquiring tab badge ownership");
    coldBuilds=snapshotBuilds; enabled=NO; [a refresh]; [a refresh];
    Check(snapshotBuilds==coldBuilds && !a.cachedNativeSections && !a.tabAlertBadge && !sourceEvents,@"switching grouping off after a cold empty-list publication adds no badge snapshot reads or source events");

    // Start hidden, with only a protected dot, then cover the list and remove
    // the final protected name. Native total is zero; numeric-only restoration
    // cannot recover this dot, so the reliable immutable row source is required.
    [Adapters() removeAllObjects]; policyFriends=@[@"secret"]; privacyEnabled=YES;
    NSUInteger dotPath[]={0,0};
    CSGroupRow *dotRow=[[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:dotPath length:2] userName:@"secret" kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:2 redDot:YES];
    fixtureNativeSections=@[@[dotRow]];
    a=List(&host);
    CSGroupTabBadgeDecision *hiddenDecision=[CSGroupListAdapter closeFriendTabBadgeDecision];
    Check(hiddenDecision.badge && !hiddenDecision.badge.count && !hiddenDecision.badge.redDot && a.tabAlertBadge,@"hidden protected dot records a verified filtered-zero badge before native restoration");
    [host viewWillDisappear:NO];
    Check(!a.cachedNativeSections && a.tabAlertBadge,@"covered list releases native rows but retains the prior tab source marker");
    policyFriends=@[]; privacyEnabled=NO; sourceEvents=0; sourceSawReady=NO; sourceSawDot=NO;
    [CSGroupListAdapter closeFriendPolicyChanged:nil];
    Check(!a.cachedNativeSections && !sourceEvents,@"removing the last protected name respects offscreen suspension before recovery");
    NSUInteger recoveryBuilds=snapshotBuilds;
    [host viewWillAppear:NO];
    Check(snapshotBuilds==recoveryBuilds+1 && a.cachedNativeSections && !a.active,@"return with grouping off rebuilds one native source after clearing the last protected name");
    Check(sourceEvents==1 && sourceSawReady && sourceSawDot,@"real refresh finally emits one verified native-dot source after publishing/depth/dirty ownership clears");
    Check(![CSGroupListAdapter closeFriendTabBadgeDecision],@"empty protection list keeps ordinary badge interception in native passthrough");
    [NSNotificationCenter.defaultCenter removeObserver:sourceObserver];
    fixtureNativeSections=nil; policyFriends=nil; enabled=YES;
#endif
    fprintf(stdout,"Group lifecycle: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
