#import "GroupRefreshFixture.h"
#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import <objc/message.h>
@class CSGroupListAdapter;
@interface UITableView : NSObject
@property(nonatomic) BOOL tracking,dragging,decelerating,editing,hidden;
@property(nonatomic) double decelerationRate;
@property(nonatomic,strong) id tableHeaderView;
@property(nonatomic) NSUInteger reloads;
- (void)setEditing:(BOOL)value animated:(BOOL)animated;
- (void)layoutIfNeeded;
- (void)reloadData;
@end
@interface Host : NSObject
@property(nonatomic,strong) UITableView *m_tableView;
@property(nonatomic) BOOL isSearching;
@property(nonatomic) NSUInteger originalCalls;
- (void)nativeAppearance:(BOOL)animated;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
@end
@interface CSGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID;
@end
@implementation CSGroupPreferences @end
static char AdapterKey, PresentationSuspendedKey;
static NSString *account=@"account-A";
static BOOL enabled=YES;
static BOOL privacyEnabled;
static BOOL CSGroupPrivacyActive(void) { return privacyEnabled; }
static NSUInteger accountEpoch=1;
static NSUInteger CSCloseFriendAccountEpoch(void) { return accountEpoch; }
static BOOL CSGroupIsFoldedController(id owner) { (void)owner; return NO; }
@interface PolicyFixture : NSObject
@property(nonatomic) BOOL blocked;
@end
@implementation PolicyFixture @end
static PolicyFixture *CSCloseFriendCurrentSnapshot(void) { return [PolicyFixture new]; }
static NSUInteger scopes,snapshotBuilds;
static BOOL mutateDuringSnapshot,failPublication,rawPublicationFailure;
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
@interface CSGroupListAdapter : NSObject
CS_GROUP_REFRESH_TEST_PROPERTIES
@property(nonatomic) NSUInteger modelRevision,snapshotRevision,refreshGeneration;
@property(nonatomic) BOOL coalescingNotification,scheduledCoalesced,coalescedDispatchPending;
@property(nonatomic,copy) NSString *snapshotAccount;
@property(nonatomic,strong) NSArray *cachedNativeSections;
@property(nonatomic,copy) NSString *nativeActionsAccount;
@property(nonatomic,weak) UITableView *table;
@property(nonatomic,weak) Host *controller;
@property(nonatomic,strong) NSMutableDictionary *proxies,*anchors;
@property(nonatomic,strong) NSMutableArray *completions,*nativeActions;
@property(nonatomic,strong) NSMutableSet *prefetchedPaths;
@property(nonatomic,strong) id nativeHeader,projection,identityDisplayPaths;
@property(nonatomic) BOOL chromeVisible,searchChromeVisible,privacyRefreshPending,privacyShielded,privacyTableWasHidden;
@property(nonatomic) CSGroupChangeKind lastPublishedChanges;
@property(nonatomic,strong) id chrome;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic) double baselineDeceleration;
@property(nonatomic) BOOL active,presentationSuspended,publishedEnabled,searching,dirty,scheduled,publishing,groupPanMoving,swipeActive,nativePresentation,updatingHeader,snapshotRetryAttempted;
@property(nonatomic) NSUInteger changeDepth,snapshotRetryGeneration,refreshCount,layoutCount,anchorOrTitleCount,menuReads,menuState;
+ (instancetype)adapterForController:(id)controller;
+ (instancetype)adapterForTable:(id)table;
+ (void)setPresentationSuspended:(BOOL)value forController:(id)controller;
- (void)refresh;
- (void)requestRefresh;
- (void)finishSuspendedBatches;
- (void)saveAnchor;
- (void)refreshNavigationTitle;
- (void)useNativePresentation;
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
    self.refreshCount++;
    if (!self.nativePresentation) [self nativeSectionsForAccount:account];
    self.preferences=[CSGroupPreferences new]; self.preferences.accountID=account;
    self.publishedEnabled=enabled; self.searching=self.controller.isSearching;
    self.active=privacyEnabled || (enabled && !self.searching && !self.nativePresentation);
    [self layout];
    if (failPublication) { if (rawPublicationFailure) [self requestRefresh]; else [self requestRecovery]; }
}
@end
static NSArray *CSGroupBuildNativeSections(id controller,id table,id source) {
    (void)controller; (void)table; snapshotBuilds++;
    if (mutateDuringSnapshot) [source invalidateNativeSnapshot];
    return @[@[]];
}
static NSArray *CSGroupBuildNativeSectionsReusing(id controller,id table,id source,NSArray *previous) {
    (void)previous;return CSGroupBuildNativeSections(controller,table,source);
}
static CSGroupListAdapter *Adapter(id owner) { return [CSGroupListAdapter adapterForController:owner]; }
static void Native(id owner,BOOL change,void (^body)(void)) { (void)owner; (void)change; body(); }
static BOOL Projected(CSGroupListAdapter *a) { return a.isActive && !a.publishing; }
@implementation Host
- (void)nativeAppearance:(BOOL)animated {
    (void)animated; self.originalCalls++;
    // Native lifecycle may itself produce a session/UI invalidation.
    [Adapter(self) requestRefresh];
}
#include "GroupLifecycleHooks.h"
@end
@implementation UITableView
- (void)layoutIfNeeded {}
- (void)setEditing:(BOOL)value animated:(BOOL)animated { (void)animated; self.editing=value; }
#include "GroupLifecycleReload.h"
@end
static NSUInteger checks,failures;
static void Check(BOOL condition,NSString *message) {
    checks++; if (!condition) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static void RunFor(double interval) { [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:interval]]; }
static CSGroupListAdapter *List(Host **owner) {
    Host *host=[Host new]; host.m_tableView=[UITableView new];
    [CSGroupListAdapter attachToController:host]; *owner=host;
    return Adapter(host);
}
int main(void) { @autoreleasepool {
    Host *host=nil; CSGroupListAdapter *a=List(&host);
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

    UITableView *chat=[UITableView new]; NSUInteger scopesBefore=scopes;
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
    Check(snapshotBuilds==builds && !a.active,@"disabled grouping never builds a snapshot");
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
    Check(a.table.hidden && a.privacyRefreshPending && a.refreshCount==before,@"policy change immediately hides old cells while native transaction is open");
    [a endNativeChange]; RunFor(.03);
    Check(!a.table.hidden && a.refreshCount==before+1,@"transaction completion publishes current privacy and releases temporary shield");
    a.table.tracking=NO; a.table.editing=NO; a.menuState=0;
    a.publishing=YES; actionBefore=actions; [a performInNativePresentation:^{actions++;}]; a.publishing=NO;
    [a refresh]; Check(actions==actionBefore+1 && a.active && !a.nativeActions.count,@"native action drains through privacy projection without disabling it");
    a.publishing=YES; actionBefore=actions; [a performInNativePresentation:^{actions++;}]; a.publishing=NO;
    accountEpoch++; [a refresh];
    Check(actions==actionBefore && !a.nativeActions.count,@"same-account epoch replacement discards queued native action");
    privacyEnabled=NO; enabled=YES;
    fprintf(stdout,"Group lifecycle: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
