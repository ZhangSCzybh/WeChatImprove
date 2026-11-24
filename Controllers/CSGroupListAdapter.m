#import "CSGroupListAdapter.h"
#import "CSGroupProjection.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendSessionPresentation.h"
#import "CSCloseFriendListShield.h"
#import "CSGroupPreferences.h"
#import "CSGroupAppearance.h"
#import "CSGroupInvocationMapper.h"
#import "CSGroupNativeBridge.h"
#import "CSGroupNativeModel.h"
#import "CSGroupNativeSessionCoordinator.h"
#import "WESessionTabContainerView.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <math.h>

NSNotificationName const CSGroupTabBadgeSourceDidRefreshNotification=@"CSGroupTabBadgeSourceDidRefreshNotification";
@implementation CSGroupTabBadgeDecision
+ (instancetype)decisionWithPolicy:(CSCloseFriendSnapshot *)policy epoch:(NSUInteger)epoch
                         boundary:(BOOL)boundary badge:(CSGroupBadge *)badge {
    return [self decisionWithPolicy:policy epoch:epoch boundary:boundary badge:badge sourceController:nil sourceRevision:0];
}
+ (instancetype)decisionWithPolicy:(CSCloseFriendSnapshot *)policy epoch:(NSUInteger)epoch
                         boundary:(BOOL)boundary badge:(CSGroupBadge *)badge sourceController:(id)controller sourceRevision:(NSUInteger)revision {
    CSGroupTabBadgeDecision *result=[self new];
    result->_accountID=[policy.accountID copy]; result->_epoch=epoch;
    result->_policyRevision=policy.revision; result->_boundary=boundary; result->_badge=badge;
    if (badge && !boundary) { result->_sourceController=controller; result->_sourceRevision=revision; }
    return result;
}
@end

static BOOL CSGroupAppInactive;
static BOOL CSGroupApplicationActive(void) { return !CSGroupAppInactive && UIApplication.sharedApplication.applicationState==UIApplicationStateActive; }

static BOOL CSGroupPrivacyActive(void) {
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    return snapshot.blocked || (snapshot.enabled && !snapshot.revealed && [snapshot.options[@"hideSessions"] boolValue]);
}
static char AdapterKey, CellRowKey, TitleContextKey, PresentationSuspendedKey;
static NSHashTable<CSGroupListAdapter *> *Adapters(void) {
    static NSHashTable *adapters; static dispatch_once_t once;
    dispatch_once(&once, ^{ adapters=[NSHashTable weakObjectsHashTable]; }); return adapters;
}
static BOOL Option(NSString *suffix) {
    return [NSUserDefaults.standardUserDefaults boolForKey:[@"com.wechat.enhance.chat_group." stringByAppendingString:suffix]];
}
@class CSGroupTableProxy;
@interface CSGroupListAdapter () <UIGestureRecognizerDelegate>
@property (nonatomic, weak, readwrite) UITableView *table;
@property (nonatomic, weak) id controller;
@property (nonatomic, readwrite) BOOL usesNativeSessionModel;
@property (nonatomic, strong) CSGroupProjection *projection;
@property (nonatomic, strong) CSGroupPreferences *preferences;
@property (nonatomic, strong) WESessionTabContainerView *chrome;
@property (nonatomic, strong) UIView *headerContainer;
@property (nonatomic, strong) UIView *nativeHeader;
@property (nonatomic, readwrite) BOOL updatingHeader;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UIPanGestureRecognizer *listPan;
@property (nonatomic) BOOL barTouchAllowed, listTouchAllowed, swipeActive;
@property (nonatomic, strong) CSGroupRow *swipeRow;
@property (nonatomic, copy) NSString *swipeAccount;
@property (nonatomic, copy) NSIndexPath *swipeDisplayPath;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,CSGroupTableProxy *> *proxies;
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSDictionary *> *anchors;
@property (nonatomic, strong) NSMutableArray *completions;
@property (nonatomic, copy) NSArray<WESessionTabItem *> *displayedTabs;
@property (nonatomic, copy) NSDictionary<NSString *,id> *identityDisplayPaths;
@property (nonatomic, copy) NSString *publishedTabID;
@property (nonatomic) BOOL projecting, chromeVisible;
@property (nonatomic) BOOL privacyRefreshPending;
@property (nonatomic) BOOL sessionLayoutHeld;
@property (nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property (nonatomic) BOOL searchChromeVisible;
@property (nonatomic) BOOL presentationSuspended;
@property (nonatomic, copy) NSDictionary *presentationViewport, *switchViewport;
@property (nonatomic) BOOL presentationReturnFinished, restoringViewport;
@property (nonatomic) NSUInteger viewportGeneration;
@property (nonatomic, copy) NSArray *initialViewportKey;
@property (nonatomic) NSUInteger initialViewportGeneration;
@property (nonatomic) BOOL initialViewportPending;
@property (nonatomic) BOOL publishedEnabled;
@property (nonatomic, strong) NSMutableSet<NSIndexPath *> *prefetchedPaths;
@property (nonatomic, strong) NSMutableArray *nativeActions;
@property (nonatomic, copy) NSString *nativeActionsAccount;
@property (nonatomic, copy) NSArray *cachedNativeSections;
@property (nonatomic, copy) NSString *snapshotAccount;
@property (nonatomic, strong) NSNumber *alertBadge;
@property (nonatomic, copy) NSArray *alertBadgeKey;
@property (nonatomic, strong) CSGroupBadge *tabAlertBadge;
@property (nonatomic, copy) NSArray *tabAlertBadgeKey;
// Badge data is independent of the list's visibility, chrome and UI dirty state.
@property (nonatomic, copy) NSArray *tabBadgeSections;
@property (nonatomic, copy) NSString *tabBadgeAccount;
@property (nonatomic) NSUInteger tabBadgeRevision, tabBadgeEpoch;
@property (nonatomic) BOOL tabBadgeSourceRequired, tabBadgeRestorePending;
@property (nonatomic) BOOL tabBadgeSourceScheduled, tabBadgeSourceRefreshing, tabBadgeRequestDispatchPending;
@property (nonatomic) BOOL tabBadgeRefreshAgain;
@property (nonatomic) BOOL tabBadgeRefreshAgainCoalesced, tabBadgeRequestImmediate, tabBadgeImmediatePending;
@property (nonatomic, strong) NSTimer *tabBadgeSourceTimer;
@property (nonatomic, copy) NSArray *tabBadgeScheduleKey;
@property (nonatomic) NSUInteger tabBadgeSourceGeneration;
@property (nonatomic) NSTimeInterval tabBadgeBurstStart, tabBadgeDue;
@property (nonatomic, copy) NSArray *tabBadgePublishedKey;
- (void)requestTabBadgeSourceRefresh;
- (void)prepareForVisibility;
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced;
- (void)cancelTabBadgeSourceRefresh;
- (void)refreshTabBadgeSource;
+ (void)requestTabBadgeSourcesRefresh;
@property (atomic) NSUInteger modelRevision;
@property (nonatomic) NSUInteger snapshotRevision, snapshotEpoch, refreshGeneration;
@property (nonatomic) NSUInteger nativeModelRevision;
@property (nonatomic) BOOL nativeBoundaryHeld;
@property (nonatomic) NSUInteger nativeRecoveryAttempts, nativeRecoveryGeneration;
@property (nonatomic, copy) NSArray *nativeRecoveryKey;
@property (nonatomic) BOOL coalescingNotification, scheduledCoalesced;
@property (nonatomic) BOOL immediateRefreshPending;
@property (nonatomic) NSTimeInterval refreshBurstStart, refreshCoalescedDue, scheduledRefreshDue;
@property (nonatomic) BOOL coalescedDispatchPending;
@property (atomic) CSGroupChangeKind pendingChanges;
@property (nonatomic, strong) NSMutableSet<NSString *> *pendingChangedUserNames;
@property (nonatomic) BOOL pendingChangeNamesUnknown;
@property (atomic) BOOL recoveryPending;
@property (nonatomic) BOOL scheduledInteraction, scheduledRecovery, appearanceDirty;
@property (nonatomic) NSUInteger recoveryAttempts, recoveryRevision, interactionAttempts;
@property (nonatomic, copy) NSString *recoveryAccount;
@property (nonatomic) NSTimeInterval interactionDeadline;
- (void)scheduleRefresh;
- (BOOL)refreshInteractionIsBlocking;
- (void)consumeRefreshRequest;
- (BOOL)adoptCompatibilityModelIfNeeded;
- (void)mergePendingChangeOfKind:(CSGroupChangeKind)kind changedUserNames:(NSSet<NSString *> *)names;
- (void)publishNativeProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                       changes:(CSGroupChangeKind)changes changedUserNames:(NSSet<NSString *> *)changedUserNames
           previouslyProjecting:(BOOL)previouslyProjecting;
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                  changes:(CSGroupChangeKind)changes changedUserNames:(NSSet<NSString *> *)changedUserNames
      previouslyProjecting:(BOOL)previouslyProjecting;
- (NSArray *)nativeSectionsForAccount:(NSString *)account changes:(CSGroupChangeKind)changes
                     changedUserNames:(NSSet<NSString *> *)changedUserNames;
- (NSDictionary *)captureViewportForTabID:(NSString *)tabID;
- (BOOL)validViewport:(NSDictionary *)viewport;
- (BOOL)restoreScrollHeight:(CGFloat)height;
- (void)restorePendingViewport;
- (void)restoreViewportFromSource:(NSDictionary *)viewport;
- (void)clearPendingViewport;
- (void)prepareInitialViewport;
- (void)cancelInitialViewport;
- (void)restoreInitialViewport;
- (void)tablePan:(UIPanGestureRecognizer *)pan;
- (void)requestRecovery;
- (void)cancelScheduledRefresh;
@property (nonatomic) BOOL nativePresentation, scheduled, dirty, searching;
@property (nonatomic) BOOL snapshotRetryAttempted;
@property (nonatomic) NSUInteger snapshotRetryGeneration;
@property (nonatomic, readwrite) BOOL publishing;
@property (atomic, readwrite) NSUInteger changeDepth;
@property (nonatomic) UIScrollViewDecelerationRate baselineDeceleration;
- (void)useNativePresentation;
- (void)forwardInvocation:(NSInvocation *)inv target:(id)target;
- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target;
@end
@interface CSGroupTableProxy : NSObject
@property (nonatomic, weak) CSGroupListAdapter *adapter;
@property (nonatomic, weak) id target;
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSMethodSignature *> *signatures;
@end
@implementation CSGroupTableProxy
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)path {
    (void)table; return [self.adapter cellForDisplayPath:path target:self.target];
}
- (BOOL)respondsToSelector:(SEL)selector {
    if ([super respondsToSelector:selector]) return YES;
    if (self.adapter.isActive && !CSGroupUsesNativeIndices(self.adapter.table) && !CSGroupInvocationIsSupported(selector)) return NO;
    id target=self.target;
    BOOL responds=[target respondsToSelector:selector];
    // UITableView caches optional delegate capabilities. Animation completion
    // can arrive after the weak native owner has gone away or been replaced.
    if (responds) {
        NSMethodSignature *signature=[target methodSignatureForSelector:selector];
        if (signature) {
            if (!self.signatures) self.signatures=[NSMutableDictionary dictionary];
            self.signatures[NSStringFromSelector(selector)]=signature;
        }
    }
    return responds;
}
- (BOOL)conformsToProtocol:(Protocol *)protocol { return [self.target conformsToProtocol:protocol] || [super conformsToProtocol:protocol]; }
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [self.target methodSignatureForSelector:selector] ?: self.signatures[NSStringFromSelector(selector)] ?: [super methodSignatureForSelector:selector];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    NSUInteger length=invocation.methodSignature.methodReturnLength;
    if (length) { void *zero=calloc(1,length); [invocation setReturnValue:zero]; free(zero); }
    id target=self.target;
    CSGroupListAdapter *adapter=self.adapter;
    if (adapter && [target respondsToSelector:invocation.selector]) [adapter forwardInvocation:invocation target:target];
}
@end

@implementation CSGroupListAdapter
- (void)dealloc {
    [_table.panGestureRecognizer removeTarget:self action:@selector(tablePan:)];
    [_tabBadgeSourceTimer invalidate]; [NSNotificationCenter.defaultCenter removeObserver:self];
}
+ (instancetype)adapterForTable:(id)table { return objc_getAssociatedObject(table,&AdapterKey); }
+ (instancetype)adapterForController:(id)controller { return objc_getAssociatedObject(controller,&AdapterKey); }
+ (void)attachToController:(id)controller {
    // The native main-frame owner can expose curViewController instead of inheriting UIKit.
    // Attachment is authorized by its actual chat table, not an assumed superclass.
    if (!NSThread.isMainThread || !controller) return;
    id table=CSGroupReadObject(controller,CSGroupIsFoldedController(controller) ? @"tableView" : @"m_tableView");
    if (![table isKindOfClass:UITableView.class]) return;
    CSGroupListAdapter *adapter=[self adapterForController:controller];
    if (adapter.table!=table) {
        if (adapter) [adapter detach];
        adapter=[self new]; adapter.controller=controller; adapter.table=table;
        adapter.usesNativeSessionModel=!CSGroupIsFoldedController(controller) &&
            !CSGroupNativeSessionCoordinator.sharedCoordinator.compatibilityFallback;
        if (adapter.usesNativeSessionModel) {
            [[CSGroupNativeSessionCoordinator sharedCoordinator] setMainController:controller];
            [NSNotificationCenter.defaultCenter addObserver:adapter selector:@selector(nativeSessionModelChanged:)
                name:CSGroupNativeSessionModelDidChangeNotification object:nil];
        }
        adapter.presentationSuspended=[objc_getAssociatedObject(controller,&PresentationSuspendedKey) boolValue];
        adapter.proxies=[NSMutableDictionary dictionary]; adapter.anchors=[NSMutableDictionary dictionary]; adapter.completions=[NSMutableArray array]; adapter.prefetchedPaths=[NSMutableSet set]; adapter.nativeActions=[NSMutableArray array];
        adapter.nativeHeader=[table tableHeaderView]; adapter.baselineDeceleration=[table decelerationRate];
        // Observe the existing scroll gesture even when the host changes its
        // delegate. Do not participate in recognition or handle changed frames.
        [[table panGestureRecognizer] addTarget:adapter action:@selector(tablePan:)];
        objc_setAssociatedObject(controller,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(table,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [Adapters() addObject:adapter];
    }
    [adapter requestTabBadgeSourceRefresh];
    if (adapter.presentationSuspended || !CSGroupApplicationActive()) { adapter.dirty=YES; return; }
    // Appearance is not a data change. Repeated reload/anchor restoration here
    // competes with WeChat's own search/task-bar inset and offset restoration.
    NSString *account=CSGroupCurrentAccountID();
    BOOL sameAccount=adapter.preferences.accountID==account || [adapter.preferences.accountID isEqualToString:account];
    BOOL searching=CSGroupReadInteger(controller,@"isSearching",0)!=0;
    if (!adapter.preferences || adapter.dirty || !sameAccount ||
        adapter.publishedEnabled!=Option(@"enabled") || adapter.searching!=searching) [adapter refresh];
    [adapter layout];
}
// Visibility belongs to the native owner lifecycle, not table.window: a covered
// main list can remain attached while chat scrolling and keyboard layout run.
+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller {
    if (!NSThread.isMainThread || !controller) return;
    objc_setAssociatedObject(controller,&PresentationSuspendedKey,@(suspended),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSGroupListAdapter *adapter=[self adapterForController:controller];
    if (suspended && !adapter.presentationSuspended) {
        [adapter cancelInitialViewport];
        // willDisappear and didDisappear share one departure. The second call
        // must not replace its height with a covered/host-adjusted viewport.
        if (![adapter validViewport:adapter.presentationViewport]) {
            adapter.presentationViewport=[adapter validViewport:adapter.switchViewport] ? adapter.switchViewport :
                [adapter captureViewportForTabID:adapter.publishedTabID];
            if (adapter.presentationViewport) adapter.switchViewport=nil;
        }
        adapter.presentationReturnFinished=NO;
    }
    if (!suspended && adapter.presentationSuspended && adapter.usesNativeSessionModel && !adapter.nativeActions.count)
        adapter.nativePresentation=NO;
    adapter.presentationSuspended=suspended;
    if (suspended) {
        adapter.dirty=YES; [adapter invalidateNativeSnapshot]; adapter.cachedNativeSections=nil;
        [adapter.projection discardComputationCache]; [adapter cancelScheduledRefresh];
        adapter.snapshotRetryAttempted=NO; adapter.snapshotRetryGeneration++;
        [adapter finishSuspendedBatches];
    }
    [adapter requestTabBadgeSourceRefresh];
}
+ (void)finishPresentationReturnForController:(id)controller {
    if (!NSThread.isMainThread || !controller) return;
    CSGroupListAdapter *adapter=[self adapterForController:controller];
    if (!adapter.presentationViewport && !adapter.initialViewportPending) return;
    if (adapter.presentationViewport) adapter.presentationReturnFinished=YES;
    // The host has completed viewDidAppear. Dirty/privacy-held geometry waits
    // for the existing publication/layout callbacks instead of polling.
    if (!adapter.dirty && !adapter.publishing && !adapter.changeDepth && !adapter.presentationSuspended &&
        !CSCloseFriendCurrentSnapshot().blocked) [adapter.table layoutIfNeeded];
    [adapter restorePendingViewport];
}
- (void)finishSuspendedBatches {
    if ((!self.presentationSuspended && CSGroupApplicationActive()) || self.changeDepth || self.publishing) return;
    // Native model updates have run, but their requested UI animation was
    // interrupted. Complete exactly once rather than retaining callbacks in chat.
    NSArray *callbacks=[self.completions copy]; [self.completions removeAllObjects];
    for (void (^completion)(BOOL) in callbacks) completion(NO);
}
+ (void)layoutForController:(id)controller {
    if (!NSThread.isMainThread || !controller) return;
    CSGroupListAdapter *adapter=[self adapterForController:controller];
    id table=CSGroupReadObject(controller,CSGroupIsFoldedController(controller) ? @"tableView" : @"m_tableView");
    if (!adapter || adapter.table!=table) { [self attachToController:controller]; return; }
    [adapter layout];
}
+ (NSNumber *)closeFriendAlertBadgeCount {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL filtering=[policy concealsSurface:CSCloseFriendSurfaceSession];
    if(!policy.blocked && (!filtering || !policy.protectedUserNames.count))return nil;
    NSMutableSet *hidden=[policy.protectedUserNames mutableCopy];
    if(!NSThread.isMainThread || policy.blocked)return @0;
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    for(CSGroupListAdapter *adapter in Adapters().allObjects) {
        BOOL currentSource=adapter.usesNativeSessionModel ?
            (adapter.tabBadgeSections && adapter.tabBadgeRevision==adapter.modelRevision && adapter.tabBadgeEpoch==epoch &&
             [adapter.tabBadgeAccount isEqual:policy.accountID]) :
            (adapter.cachedNativeSections && !adapter.dirty && adapter.snapshotRevision==adapter.modelRevision &&
             adapter.snapshotEpoch==epoch && [adapter.snapshotAccount isEqual:policy.accountID]);
        if(CSGroupIsFoldedController(adapter.controller) || adapter.changeDepth || !currentSource ||
           ![policy.accountID isEqual:CSGroupCurrentAccountID()])continue;
        NSUInteger revision=adapter.modelRevision;
        NSArray *foldedNames=CSGroupCopyFoldedUserNames();
        NSArray *cacheKey=@[policy.accountID,@(epoch),@(revision),@(policy.revision),foldedNames ?: NSNull.null];
        if(adapter.alertBadge && [adapter.alertBadgeKey isEqual:cacheKey])return adapter.alertBadge;
        NSMutableSet *unmasked=[NSMutableSet set];
        CSGroupFoldedPrivacyState folded=CSGroupAssessFoldedUserNames(foldedNames,hidden);
        if(folded==CSGroupFoldedPrivacyAllHidden)[hidden addObject:@"chatroom_session_box"];
        else if(folded==CSGroupFoldedPrivacyNoHidden)[unmasked addObject:@"chatroom_session_box"];
        WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];
        CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:(adapter.usesNativeSessionModel ? adapter.tabBadgeSections : adapter.cachedNativeSections) tabs:@[all] selectedTabID:all.tabId
            filterDuplicates:NO accountID:policy.accountID hiddenUserNames:hidden unmaskedAggregateUserNames:unmasked privacyRevision:policy.revision previousProjection:nil];
        if(!projection.isValid || revision!=adapter.modelRevision || epoch!=CSCloseFriendAccountEpoch() || policy.revision!=CSCloseFriendCurrentSnapshot().revision)return @0;
        adapter.alertBadgeKey=cacheKey; adapter.alertBadge=@([projection badgeForTabID:all.tabId].count);
        return adapter.alertBadge;
    }
    return @0;
}
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision {
    return [self closeFriendTabBadgeDecisionForPublication:NO];
}
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:(BOOL)includeNative {
    return [self closeFriendTabBadgeDecisionForController:nil includeNative:includeNative];
}
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:(id)controller includeNative:(BOOL)includeNative {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    BOOL boundary=policy.blocked || (NSThread.isMainThread && ![policy.accountID isEqual:CSGroupCurrentAccountID()]);
    if (boundary) return [CSGroupTabBadgeDecision decisionWithPolicy:policy epoch:epoch boundary:YES badge:nil];
    // Public badges exclude protected sessions only while their rows are concealed.
    BOOL filtering=[policy concealsSurface:CSCloseFriendSurfaceSession];
    filtering=filtering && policy.protectedUserNames.count>0;
    if (!includeNative && !filtering) return nil;
    CSGroupTabBadgeDecision *pending=[CSGroupTabBadgeDecision decisionWithPolicy:policy epoch:epoch boundary:NO badge:nil];
    if (!NSThread.isMainThread) return pending;
    // A tab can owe native restoration before its chat table has an adapter.
    // Keep only a root-scoped request, never a trusted count or display token.
    SEL restoreKey=@selector(closeFriendTabBadgeDecisionForController:includeNative:);
    if (includeNative && !filtering && controller)
        objc_setAssociatedObject(controller,restoreKey,@[policy.accountID,@(epoch)],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSSet *protected=filtering ? policy.protectedUserNames : [NSSet set];
    for (CSGroupListAdapter *adapter in Adapters().allObjects) {
        if ((controller && adapter.controller!=controller) || CSGroupIsFoldedController(adapter.controller)) continue;
        NSUInteger revision=adapter.modelRevision;
        NSArray *sections=nil;
        if (!adapter.changeDepth && adapter.tabBadgeSections && adapter.tabBadgeRevision==revision &&
            adapter.tabBadgeEpoch==epoch && [adapter.tabBadgeAccount isEqual:policy.accountID]) sections=adapter.tabBadgeSections;
        else if (!adapter.usesNativeSessionModel && !adapter.changeDepth && !adapter.dirty && adapter.cachedNativeSections && adapter.snapshotRevision==revision &&
            adapter.snapshotEpoch==epoch && [adapter.snapshotAccount isEqual:policy.accountID]) sections=adapter.cachedNativeSections;
        if (!sections) {
            if (includeNative && !filtering) adapter.tabBadgeRestorePending=YES;
            // Passive bursts keep their deadline; native restoration is urgent.
            NSArray *scheduleKey=@[policy.accountID ?: @"",@(epoch),@(policy.revision)];
            if ((includeNative && !filtering) || (!adapter.changeDepth &&
                (!adapter.tabBadgeSourceScheduled || ![adapter.tabBadgeScheduleKey isEqual:scheduleKey])))
                [adapter requestTabBadgeSourceRefresh];
            continue;
        }
        NSArray *foldedNames=CSGroupCopyFoldedUserNames();
        NSArray *key=@[policy.accountID,@(epoch),@(revision),@(policy.revision),foldedNames ?: NSNull.null];
        if (adapter.tabAlertBadge && [adapter.tabAlertBadgeKey isEqual:key]) {
            CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
            if (adapter.changeDepth || revision!=adapter.modelRevision || epoch!=CSCloseFriendAccountEpoch() || current.blocked ||
                policy.revision!=current.revision || ![policy.accountID isEqual:current.accountID] || ![policy.accountID isEqual:CSGroupCurrentAccountID()]) return pending;
            if (includeNative && !filtering && controller) objc_setAssociatedObject(controller,restoreKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return [CSGroupTabBadgeDecision decisionWithPolicy:policy epoch:epoch boundary:NO badge:adapter.tabAlertBadge sourceController:adapter.controller sourceRevision:revision];
        }
        NSMutableSet *hidden=[protected mutableCopy], *unmasked=[NSMutableSet set];
        CSGroupFoldedPrivacyState folded=CSGroupAssessFoldedUserNames(foldedNames,hidden);
        if (folded==CSGroupFoldedPrivacyAllHidden) [hidden addObject:@"chatroom_session_box"];
        else if (folded==CSGroupFoldedPrivacyNoHidden) [unmasked addObject:@"chatroom_session_box"];
        WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];
        CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:sections tabs:@[all] selectedTabID:all.tabId
            filterDuplicates:NO accountID:policy.accountID hiddenUserNames:hidden unmaskedAggregateUserNames:unmasked
            privacyRevision:policy.revision previousProjection:nil];
        CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
        if (!projection.isValid || adapter.changeDepth || revision!=adapter.modelRevision || epoch!=CSCloseFriendAccountEpoch() ||
            current.blocked || policy.revision!=current.revision || ![policy.accountID isEqual:current.accountID] ||
            ![policy.accountID isEqual:CSGroupCurrentAccountID()]) return pending;
        adapter.tabAlertBadgeKey=key; adapter.tabAlertBadge=[projection badgeForTabID:all.tabId];
        if (includeNative && !filtering && controller) objc_setAssociatedObject(controller,restoreKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return [CSGroupTabBadgeDecision decisionWithPolicy:policy epoch:epoch boundary:NO badge:adapter.tabAlertBadge sourceController:adapter.controller sourceRevision:revision];
    }
    return pending;
}
+ (void)requestTabBadgeSourcesRefresh {
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ [self requestTabBadgeSourcesRefresh]; }); return;
    }
    for (CSGroupListAdapter *adapter in Adapters().allObjects) [adapter requestTabBadgeSourceRefresh];
}
- (void)requestTabBadgeSourceRefresh {
    [self requestTabBadgeSourceRefreshCoalesced:NO];
}
- (void)cancelTabBadgeSourceRefresh {
    self.tabBadgeSourceGeneration++;
    [self.tabBadgeSourceTimer invalidate]; self.tabBadgeSourceTimer=nil;
    self.tabBadgeSourceScheduled=NO; self.tabBadgeScheduleKey=nil;
    self.tabBadgeBurstStart=0; self.tabBadgeDue=0;
}
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced {
    if (!NSThread.isMainThread) {
        @synchronized (self) {
            self.tabBadgeRequestImmediate|=!coalesced;
            if (self.tabBadgeRequestDispatchPending) return;
            self.tabBadgeRequestDispatchPending=YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL immediate;
            @synchronized (self) {
                immediate=self.tabBadgeRequestImmediate;
                self.tabBadgeRequestImmediate=NO; self.tabBadgeRequestDispatchPending=NO;
            }
            [self requestTabBadgeSourceRefreshCoalesced:!immediate];
        });
        return;
    }
    if (!coalesced) self.tabBadgeImmediatePending=YES;
    if (!self.controller || !self.table || CSGroupIsFoldedController(self.controller)) return;
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    SEL restoreKey=@selector(closeFriendTabBadgeDecisionForController:includeNative:);
    NSArray *restore=objc_getAssociatedObject(self.controller,restoreKey);
    if (!policy.blocked && [restore isKindOfClass:NSArray.class] && restore.count==2) {
        if ([restore[0] isEqual:policy.accountID] && [restore[1] unsignedIntegerValue]==CSCloseFriendAccountEpoch()) self.tabBadgeRestorePending=YES;
        else objc_setAssociatedObject(self.controller,restoreKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    BOOL filtering=[policy concealsSurface:CSCloseFriendSurfaceSession] && policy.protectedUserNames.count>0;
    if (!policy.blocked) {
        if (filtering) self.tabBadgeSourceRequired=YES;
        else if (self.tabBadgeSourceRequired) { self.tabBadgeSourceRequired=NO; self.tabBadgeRestorePending=YES; }
    }
    NSArray *scheduleKey=@[policy.accountID ?: @"",@(CSCloseFriendAccountEpoch()),@(policy.revision)];
    if (self.tabBadgeRestorePending || (self.tabBadgeScheduleKey && ![scheduleKey isEqual:self.tabBadgeScheduleKey])) coalesced=NO;
    coalesced=coalesced && !self.tabBadgeImmediatePending;
    if ((!self.tabBadgeSourceRequired && !self.tabBadgeRestorePending) || policy.blocked || !CSGroupApplicationActive() || self.changeDepth) {
        if (!coalesced) [self cancelTabBadgeSourceRefresh];
        return;
    }
    if (self.tabBadgeSourceRefreshing) {
        self.tabBadgeRefreshAgainCoalesced=self.tabBadgeRefreshAgain ? self.tabBadgeRefreshAgainCoalesced && coalesced : coalesced;
        self.tabBadgeRefreshAgain=YES; return;
    }
    if (self.tabBadgeSourceScheduled && !self.tabBadgeSourceTimer && [scheduleKey isEqual:self.tabBadgeScheduleKey]) {
        self.tabBadgeImmediatePending=NO; return;
    }
    NSTimeInterval now=NSProcessInfo.processInfo.systemUptime;
    if (coalesced && self.tabBadgeSourceTimer) {
        self.tabBadgeDue=MIN(now+0.08,self.tabBadgeBurstStart+0.25);
        self.tabBadgeSourceTimer.fireDate=[NSDate dateWithTimeIntervalSinceNow:MAX(0,self.tabBadgeDue-now)];
        return;
    }
    [self cancelTabBadgeSourceRefresh];
    self.tabBadgeSourceScheduled=YES;
    self.tabBadgeScheduleKey=scheduleKey;
    self.tabBadgeImmediatePending=NO;
    NSUInteger generation=self.tabBadgeSourceGeneration;
    __weak typeof(self) weakSelf=self;
    void (^publish)(void)=^{
        CSGroupListAdapter *self=weakSelf;
        if (!self || generation!=self.tabBadgeSourceGeneration) return;
        [self cancelTabBadgeSourceRefresh];
        CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
        if (![scheduleKey isEqual:@[current.accountID ?: @"",@(CSCloseFriendAccountEpoch()),@(current.revision)]]) return;
        [self refreshTabBadgeSource];
    };
    if (coalesced) {
        self.tabBadgeBurstStart=now; self.tabBadgeDue=now+0.08;
        self.tabBadgeSourceTimer=[NSTimer timerWithTimeInterval:0.08 repeats:NO block:^(__unused NSTimer *timer) { publish(); }];
        [NSRunLoop.mainRunLoop addTimer:self.tabBadgeSourceTimer forMode:NSRunLoopCommonModes];
    } else dispatch_async(dispatch_get_main_queue(),publish);
}
- (void)refreshTabBadgeSource {
    if (!NSThread.isMainThread) { [self requestTabBadgeSourceRefresh]; return; }
    if (self.tabBadgeSourceRefreshing || self.publishing || self.changeDepth || !CSGroupApplicationActive() ||
        !self.controller || !self.table || CSGroupIsFoldedController(self.controller)) return;
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    NSString *account=CSGroupCurrentAccountID();
    NSUInteger epoch=CSCloseFriendAccountEpoch(), revision=self.modelRevision;
    id controller=self.controller;
    UITableView *table=self.table;
    if (policy.blocked || !account.length || ![account isEqual:policy.accountID] ||
        (!self.tabBadgeSourceRequired && !self.tabBadgeRestorePending)) return;
    self.tabBadgeSourceRefreshing=YES;
    @try {
        NSArray *sections=nil;
        if (self.usesNativeSessionModel) {
            CSGroupNativeSessionCoordinator *coordinator=[CSGroupNativeSessionCoordinator sharedCoordinator];
            if (coordinator.boundary || !coordinator.model.isValid || coordinator.epoch!=epoch ||
                ![coordinator.accountID isEqual:account]) return;
            sections=@[coordinator.model.sourceRows];
        }
        else if (self.tabBadgeSections && self.tabBadgeRevision==revision && self.tabBadgeEpoch==epoch &&
            [self.tabBadgeAccount isEqual:account]) sections=self.tabBadgeSections;
        else if (!self.dirty && self.cachedNativeSections && self.snapshotRevision==revision && self.snapshotEpoch==epoch &&
            [self.snapshotAccount isEqual:account]) sections=self.cachedNativeSections;
        else {
            id source=[self nativeSource] ?: table.dataSource;
            NSArray *previous=self.tabBadgeEpoch==epoch && [self.tabBadgeAccount isEqual:account] ? self.tabBadgeSections : nil;
            __block NSArray *built=nil;
            // Only native data-source reads run here. Offscreen lists never reload,
            // lay out, install chrome, or save/restore anchors for badge maintenance.
            CSGroupWithNativeIndices(table, ^{ built=CSGroupBuildNativeSectionsReusing(controller,table,source,previous); });
            if (self.controller!=controller || self.table!=table || source!=([self nativeSource] ?: table.dataSource)) return;
            sections=built;
        }
        CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
        if (!sections || self.changeDepth || revision!=self.modelRevision || epoch!=CSCloseFriendAccountEpoch() ||
            current.blocked || current.revision!=policy.revision || ![current.accountID isEqual:account] ||
            ![account isEqual:CSGroupCurrentAccountID()]) return;
        self.tabBadgeSections=sections; self.tabBadgeAccount=account;
        self.tabBadgeRevision=revision; self.tabBadgeEpoch=epoch;
        CSGroupTabBadgeDecision *decision=[CSGroupListAdapter closeFriendTabBadgeDecisionForController:self.controller includeNative:YES];
        if (!decision.badge || decision.boundary || decision.sourceController!=self.controller || decision.epoch!=epoch ||
            ![decision.accountID isEqual:account] || decision.policyRevision!=policy.revision || revision!=self.modelRevision ||
            self.changeDepth || epoch!=CSCloseFriendAccountEpoch() || ![account isEqual:CSGroupCurrentAccountID()]) return;
        NSArray *key=@[account,@(epoch),@(revision),@(policy.revision),@(decision.badge.count),@(decision.badge.redDot)];
        self.tabBadgeRestorePending=NO;
        if ([self.tabBadgePublishedKey isEqual:key]) return;
        self.tabBadgePublishedKey=key;
        [NSNotificationCenter.defaultCenter postNotificationName:CSGroupTabBadgeSourceDidRefreshNotification object:self];
    } @finally {
        self.tabBadgeSourceRefreshing=NO;
        if (self.tabBadgeRefreshAgain) {
            BOOL coalesced=self.tabBadgeRefreshAgainCoalesced;
            self.tabBadgeRefreshAgain=NO; self.tabBadgeRefreshAgainCoalesced=NO;
            [self requestTabBadgeSourceRefreshCoalesced:coalesced];
        }
    }
}
+ (void)settingsChanged {
    dispatch_async(dispatch_get_main_queue(), ^{ for (CSGroupListAdapter *adapter in Adapters().allObjects) { @synchronized (adapter) { adapter.pendingChanges|=CSGroupChangeUnknown; } [adapter invalidateNativeSnapshot]; adapter.appearanceDirty=YES; [adapter requestTabBadgeSourceRefresh]; [adapter refresh]; [adapter layout]; } });
}
+ (void)closeFriendPolicyChanged:(NSNotification *)notification {
    (void)notification;
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ [self closeFriendPolicyChanged:notification]; }); return;
    }
    for (CSGroupListAdapter *adapter in Adapters().allObjects) {
        // Preserve the header and ordinary rows even if the native model is in a
        // transaction. Redact sensitive rows before attempting the safe publication.
        adapter.privacyRefreshPending=YES; adapter.dirty=YES;
        [adapter shieldVisiblePrivateRows];
        [adapter cancelScheduledRefresh]; [adapter invalidateNativeSnapshot];
        @synchronized (adapter) { adapter.pendingChanges|=CSGroupChangeUnknown; }
        [adapter requestTabBadgeSourceRefresh];
        [adapter refresh];
    }
}
- (void)shieldVisiblePrivateRows {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if (!CSGroupPrivacyActive()) return;
    if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
    for (UITableViewCell *cell in self.table.visibleCells) {
        // Use the delivered identity, never current native indexes during mutation.
        NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);
        CSGroupRow *row=delivery[@"row"];
        BOOL unknown=policy.blocked || ![delivery[@"account"] isEqual:policy.accountID] ||
            ![policy.accountID isEqual:CSGroupCurrentAccountID()] || !row;
        BOOL sensitive=unknown || [policy hidesUserName:row.userName surface:CSCloseFriendSurfaceSession] ||
            (row.kind==CSGroupRowKindAggregate && policy.protectedUserNames.count>0);
        if (sensitive) [self.privacyShield shieldCell:cell];
    }
}
// Ordinary background updates remain deferred. A pending privacy publication is
// the one exception, so the switcher never waits for foreground to get safe rows.
+ (void)applicationActivityChanged:(NSNotification *)notification {
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ [self applicationActivityChanged:notification]; }); return;
    }
    CSGroupAppInactive=![notification.name isEqual:UIApplicationDidBecomeActiveNotification];
    for (CSGroupListAdapter *adapter in Adapters().allObjects) {
        [adapter cancelScheduledRefresh]; [adapter invalidateNativeSnapshot];
        @synchronized (adapter) { adapter.pendingChanges|=CSGroupChangeUnknown; } adapter.dirty=YES; adapter.recoveryPending=NO;
        adapter.cachedNativeSections=nil; [adapter.projection discardComputationCache];
        adapter.snapshotRetryGeneration++; adapter.snapshotRetryAttempted=NO;
        [adapter requestTabBadgeSourceRefresh];
        if (CSGroupApplicationActive() && !adapter.presentationSuspended) [adapter scheduleRefresh];
        else [adapter finishSuspendedBatches];
    }
}
- (BOOL)isActive {
    return self.projecting;
}
- (id)nativeSource { return self.usesNativeSessionModel ? self.table.dataSource : self.proxies[@0].target; }
- (void)installProxies {
    if (self.usesNativeSessionModel) return;
    UITableView *table=self.table; if (!table) return;
    table.dataSource=[self proxyForTarget:table.dataSource role:0];
    table.delegate=[self proxyForTarget:table.delegate role:1];
    table.prefetchDataSource=[self proxyForTarget:table.prefetchDataSource role:2];
}
- (id)proxyForTarget:(id)target role:(NSUInteger)role {
    if (self.usesNativeSessionModel) return [target isKindOfClass:CSGroupTableProxy.class] ? [target target] : target;
    if ([target isKindOfClass:CSGroupTableProxy.class]) return target;
    CSGroupTableProxy *proxy=self.proxies[@(role)];
    if (!target) { proxy.target=nil; return nil; }
    if (!proxy) { proxy=[CSGroupTableProxy new]; proxy.adapter=self; self.proxies[@(role)]=proxy; }
    proxy.target=target; return proxy;
}
- (void)detach {
    [self.table.panGestureRecognizer removeTarget:self action:@selector(tablePan:)];
    objc_setAssociatedObject(self,@selector(performSessionListLayout:),nil,OBJC_ASSOCIATION_RETAIN);
    [self cancelTabBadgeSourceRefresh];
    [Adapters() removeObject:self];
    self.tabBadgeSections=nil; self.tabAlertBadge=nil; self.tabAlertBadgeKey=nil;
    self.tabBadgeSourceRequired=NO; self.tabBadgeRestorePending=NO;
    UITableView *table=self.table; self.nativePresentation=YES; self.projecting=NO; self.chromeVisible=NO;
    [self.privacyShield prepareForPublication]; self.privacyShield=nil;
    [self refreshNavigationTitle];
    self.presentationSuspended=YES; [self cancelScheduledRefresh];
    [self publishHeader:self.nativeHeader]; [self.chrome removeFromSuperview]; [self.chrome removeGestureRecognizer:self.pan]; [table removeGestureRecognizer:self.listPan];
    objc_setAssociatedObject(table,&AdapterKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (table.dataSource==self.proxies[@0]) table.dataSource=self.proxies[@0].target;
    if (table.delegate==self.proxies[@1]) table.delegate=self.proxies[@1].target;
    if (table.prefetchDataSource==self.proxies[@2]) table.prefetchDataSource=self.proxies[@2].target;
    table.decelerationRate=self.baselineDeceleration;
    for (void (^completion)(BOOL) in self.completions) completion(NO);
    [self.completions removeAllObjects];
    [self.nativeActions removeAllObjects];
}
- (void)ensureChrome {
    if (self.chrome) return;
    self.chrome=[WESessionTabContainerView new];
    __weak typeof(self) weakSelf=self;
    self.chrome.onTabSelected=^(NSInteger index) { [weakSelf selectIndex:index]; };
    self.chrome.onSearchButtonTapped=^{
        CSGroupListAdapter *self=weakSelf; if (!self) return;
        [self prepareForNativeSearch];
        CSGroupWithNativeIndices(self.table, ^{
            SEL search=NSSelectorFromString(@"onSearch");
            if ([self.controller respondsToSelector:search]) ((void(*)(id,SEL))objc_msgSend)(self.controller,search);
        });
        [self requestRefresh];
    };
    self.pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(groupPan:)];
    self.pan.delegate=self; self.pan.maximumNumberOfTouches=1; self.pan.cancelsTouchesInView=NO;
    [self.chrome addGestureRecognizer:self.pan];
    self.listPan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(groupPan:)];
    self.listPan.delegate=self; self.listPan.maximumNumberOfTouches=1;
    // Once a row swipe belongs to grouping, cancel the row's pending tap.
    // Rejected right-zone touches never reach this recognizer.
    self.listPan.cancelsTouchesInView=YES;
    [self.table addGestureRecognizer:self.listPan];
}
- (UIView *)nativeTableHeaderView { return self.nativeHeader; }
- (void)setNativeTableHeaderView:(UIView *)header {
    if (header && header==self.headerContainer) return;
    if (self.nativeHeader!=header) {
        // WeChat may wrap the existing search view in a new composite header.
        if (!header || ![self.nativeHeader isDescendantOfView:header]) [self.nativeHeader removeFromSuperview];
    }
    self.nativeHeader=header;
    [self layout];
}
- (void)prepareForNativeSearch {
    [self clearPendingViewport];
    [self invalidateNativeSnapshot];
    if (!self.searching) {
        [self saveAnchor];
        // Keep the main-list header stable behind the native search page. Native
        // callers still obtain the original search object through header scope.
        self.searchChromeVisible=self.chromeVisible && self.headerContainer &&
            Option(@"enabled") && CSGroupSearchButtonVisible(NSUserDefaults.standardUserDefaults);
    }
    self.searching=YES;
    [self refreshNavigationTitle];
    [self layout];
}
- (BOOL)keepsGroupHeaderDuringSearch {
    return self.searching && self.searchChromeVisible && Option(@"enabled") &&
        CSGroupSearchButtonVisible(NSUserDefaults.standardUserDefaults) &&
        [self.preferences.accountID isEqualToString:CSGroupCurrentAccountID()];
}
- (void)publishHeader:(UIView *)header {
    if (!self.table) return;
    self.updatingHeader=YES;
    @try { CSGroupWithDisplayIndices(self.table, ^{ self.table.tableHeaderView=header; }); }
    @finally { self.updatingHeader=NO; }
}
- (void)layout {
    UITableView *table=self.table; if (self.presentationSuspended || !CSGroupApplicationActive() || !table || self.updatingHeader) return;
    __block UIView *installed=nil;
    CSGroupWithDisplayIndices(table, ^{ installed=table.tableHeaderView; });
    // Search changes data/index ownership, not the header seen behind the
    // transition. Do not mount, hide or resize the native search view here: the
    // host may already have moved it into its search controller.
    if ([self keepsGroupHeaderDuringSearch]) {
        if (self.chrome.hidden) self.chrome.hidden=NO;
        if (self.chrome.userInteractionEnabled) self.chrome.userInteractionEnabled=NO;
        if (self.pan.enabled) self.pan.enabled=NO;
        if (self.listPan.enabled) self.listPan.enabled=NO;
        if (installed!=self.headerContainer) [self publishHeader:self.headerContainer];
        if (table.decelerationRate!=self.baselineDeceleration) table.decelerationRate=self.baselineDeceleration;
        return;
    }
    BOOL visible=self.chromeVisible && !self.searching;
    if (!visible) {
        if (!self.chrome.hidden) self.chrome.hidden=YES;
        if (self.pan.enabled) self.pan.enabled=NO;
        if (self.listPan.enabled) self.listPan.enabled=NO;
        if (installed!=self.nativeHeader) [self publishHeader:self.nativeHeader];
        if (table.decelerationRate!=self.baselineDeceleration) table.decelerationRate=self.baselineDeceleration;
        return;
    }
    [self ensureChrome];
    if (!self.chrome.userInteractionEnabled) self.chrome.userInteractionEnabled=YES;
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    [self.chrome applyAppearanceWithFontSize:CSGroupTabFontSize(defaults) showsSearchButton:CSGroupSearchButtonVisible(defaults)];
    if (!self.headerContainer) self.headerContainer=[UIView new];
    CGFloat width=CGRectGetWidth(table.bounds);
    CGFloat nativeHeight=MAX(0,CGRectGetHeight(self.nativeHeader.frame));
    CGFloat height=self.chrome.intrinsicContentSize.height;
    BOOL replacesNativeHeader=CSGroupSearchButtonVisible(defaults);
    CGFloat displayedNativeHeight=replacesNativeHeader ? 0 : nativeHeight;
    // The shortcut replaces the entire native search header, including decoration,
    // wrappers and padding. Keep its object and full height for native search/restore.
    if (replacesNativeHeader) { if (self.nativeHeader.superview) [self.nativeHeader removeFromSuperview]; }
    else if (self.nativeHeader && self.nativeHeader.superview!=self.headerContainer) [self.headerContainer addSubview:self.nativeHeader];
    if (self.chrome.superview!=self.headerContainer) [self.headerContainer addSubview:self.chrome];
    CGRect nativeFrame=CGRectMake(0,0,width,nativeHeight);
    if (!CGRectEqualToRect(self.nativeHeader.frame,nativeFrame)) self.nativeHeader.frame=nativeFrame;
    CGRect chromeFrame=CGRectMake(0,displayedNativeHeight,width,height);
    if (!CGRectEqualToRect(self.chrome.frame,chromeFrame)) self.chrome.frame=chromeFrame;
    if (self.chrome.hidden) self.chrome.hidden=NO;
    CGRect headerFrame=CGRectMake(0,0,width,displayedNativeHeight+height);
    BOOL resized=!CGRectEqualToRect(self.headerContainer.frame,headerFrame);
    if (resized) self.headerContainer.frame=headerFrame;
    if (installed!=self.headerContainer || resized) [self publishHeader:self.headerContainer];
    NSInteger sensitivity=[NSUserDefaults.standardUserDefaults integerForKey:@"com.wechat.enhance.scroll_sensitivity"];
    UIScrollViewDecelerationRate deceleration=sensitivity==1 ? 0.998 : sensitivity==2 ? 0.9998 : sensitivity==3 ? 0.999 : self.baselineDeceleration;
    if (table.decelerationRate!=deceleration) table.decelerationRate=deceleration;
    [self updateGroupGestureAvailability];
    [self restorePendingViewport];
}
- (void)performSessionListLayout:(void (^)(void))layout {
    if ([self adoptCompatibilityModelIfNeeded]) {
        if (!self.publishing) [self requestRefresh];
        return;
    }
    if (self.usesNativeSessionModel) {
        CSGroupNativeSessionCoordinator *coordinator=[CSGroupNativeSessionCoordinator sharedCoordinator];
        if (coordinator.boundary || self.nativeModelRevision!=coordinator.revision) {
            if (coordinator.boundary) self.nativeBoundaryHeld=YES;
            self.sessionLayoutHeld=YES;
            if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
            for (UITableViewCell *cell in self.table.visibleCells) [self.privacyShield shieldCell:cell];
            if (!self.publishing && !coordinator.boundary) [self requestRefresh];
            return;
        }
    }
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL privacy=policy.blocked || ![policy.options[@"hideSessions"] isKindOfClass:NSNumber.class] ||
        ![policy.accountID isEqual:CSGroupCurrentAccountID()] ||
        (policy.enabled && !policy.revealed && [policy.options[@"hideSessions"] boolValue]);
    BOOL visibilityHeld=[objc_getAssociatedObject(self,@selector(prepareForVisibility)) boolValue];
    if (!self.isActive && !privacy && !visibilityHeld) {
        objc_setAssociatedObject(self,@selector(performSessionListLayout:),nil,OBJC_ASSOCIATION_RETAIN);
        layout();
        self.sessionLayoutHeld=NO;
        [self.privacyShield prepareForPublication];
        return;
    }
    NSString *account=CSGroupCurrentAccountID();
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    CSGroupProjection *projection=self.projection;
    id table=self.table;
    NSUInteger modelRevision=self.modelRevision, revision=policy.revision;
    BOOL enabled=policy.enabled, revealed=policy.revealed, blocked=policy.blocked;
    BOOL retry=self.snapshotRetryAttempted;
    id hideOption=policy.options[@"hideSessions"];
    BOOL hideSessions=[hideOption boolValue];
    long long privacyRevision=CSGroupReadInteger(projection,@"privacyRevision",-1);
    BOOL ready=self.isActive && (!visibilityHeld || (self.publishing && [hideOption isKindOfClass:NSNumber.class])) &&
        !policy.blocked && [policy.accountID isEqual:account] &&
        projection.isValid && !retry && self.snapshotEpoch==epoch &&
        [projection.accountID isEqual:account] && privacyRevision==(long long)revision;
    // A proof belongs to one immutable projection and one fully known policy.
    // Snapshot reads above and below still detect synchronous unlock expiry.
    BOOL cacheable=ready && table && account.length && privacyRevision>=0 && [hideOption isKindOfClass:NSNumber.class];
    NSDictionary *proof=objc_getAssociatedObject(self,@selector(performSessionListLayout:));
    BOOL admitted=cacheable && proof[@"projection"]==projection && proof[@"policy"]==policy &&
        [proof[@"table"] anyObject]==table &&
        [proof[@"account"] isEqual:account] && [proof[@"epoch"] unsignedIntegerValue]==epoch &&
        [proof[@"revision"] unsignedIntegerValue]==revision &&
        [proof[@"enabled"] boolValue]==enabled && [proof[@"revealed"] boolValue]==revealed &&
        [proof[@"blocked"] boolValue]==blocked && [proof[@"hideSessions"] boolValue]==hideSessions &&
        [proof[@"privacyRevision"] longLongValue]==privacyRevision && [proof[@"retry"] boolValue]==retry &&
        [proof[@"modelRevision"] unsignedIntegerValue]==modelRevision;
    if (!admitted) objc_setAssociatedObject(self,@selector(performSessionListLayout:),nil,OBJC_ASSOCIATION_RETAIN);
    if (ready && !admitted) for (NSArray *section in projection.sections) for (CSGroupRow *row in section)
        if ([policy hidesUserName:row.userName surface:CSCloseFriendSurfaceSession]) ready=NO;
    if (!ready) {
        self.sessionLayoutHeld=YES;
        if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
        for (UITableViewCell *cell in self.table.visibleCells) [self.privacyShield shieldCell:cell];
        BOOL needsRefresh=!self.privacyRefreshPending;
        self.privacyRefreshPending=YES;
        if (!policy.blocked && [policy.accountID isEqual:account]) {
            self.dirty=YES;
            if (needsRefresh && !self.publishing && !self.changeDepth) [self requestRefresh];
        }
        return;
    }
    // A container can lay out this table inside its owner's native index scope.
    // UIKit must consume the already filtered projection, including its geometry.
    CSGroupWithDisplayIndices(self.table,layout);
    CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
    // Layout can synchronously replace the table/projection or invalidate policy.
    // Never attach the old scan's proof to a replacement or an unknown key.
    id currentHideOption=current.options[@"hideSessions"];
    BOOL proofStillValid=cacheable && current==policy && self.projection==projection && self.table==table &&
        projection.isValid && !self.snapshotRetryAttempted && self.snapshotEpoch==epoch &&
        self.modelRevision==modelRevision && epoch==CSCloseFriendAccountEpoch() &&
        [account isEqual:CSGroupCurrentAccountID()] && [current.accountID isEqual:account] &&
        [projection.accountID isEqual:account] && current.revision==revision &&
        current.enabled==enabled && current.revealed==revealed && current.blocked==blocked &&
        [currentHideOption isKindOfClass:NSNumber.class] && [currentHideOption boolValue]==hideSessions &&
        CSGroupReadInteger(projection,@"privacyRevision",-1)==privacyRevision;
    if (!proofStillValid) objc_setAssociatedObject(self,@selector(performSessionListLayout:),nil,OBJC_ASSOCIATION_RETAIN);
    if (current.blocked || current.revision!=policy.revision || epoch!=CSCloseFriendAccountEpoch() ||
        ![current.accountID isEqual:account] || ![account isEqual:CSGroupCurrentAccountID()]) {
        self.sessionLayoutHeld=YES;
        if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
        for (UITableViewCell *cell in self.table.visibleCells) [self.privacyShield shieldCell:cell];
        self.privacyRefreshPending=YES;
        if (!current.blocked && [current.accountID isEqual:CSGroupCurrentAccountID()]) {
            self.dirty=YES;
            if (!self.publishing && !self.changeDepth) [self requestRefresh];
        }
        return;
    }
    if (proofStillValid && !admitted) {
        NSHashTable *tables=[NSHashTable weakObjectsHashTable];
        if (table) [tables addObject:table];
        proof=@{@"projection":projection,@"policy":policy,@"account":[account copy],@"epoch":@(epoch),
            @"revision":@(revision),@"enabled":@(enabled),@"revealed":@(revealed),@"blocked":@(blocked),
            @"hideSessions":@(hideSessions),@"privacyRevision":@(privacyRevision),@"retry":@(retry),
            @"modelRevision":@(modelRevision),@"table":tables};
        objc_setAssociatedObject(self,@selector(performSessionListLayout:),proof,OBJC_ASSOCIATION_RETAIN);
    }
    self.sessionLayoutHeld=NO;
    [self.privacyShield prepareForPublication];
    [self restorePendingViewport];
}
+ (void)prepareForListVisibility {
    if (!NSThread.isMainThread) return;
    for (CSGroupListAdapter *adapter in Adapters().allObjects) [adapter prepareForVisibility];
}
- (void)prepareForVisibility {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    NSString *account=CSGroupCurrentAccountID();
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    NSArray *cells=self.table.visibleCells;
    BOOL known=policy && !policy.blocked && account.length && [policy.accountID isEqual:account] &&
        [policy.options[@"hideSessions"] isKindOfClass:NSNumber.class];
    BOOL privacy=!known || (policy.enabled && !policy.revealed && [policy.options[@"hideSessions"] boolValue]);
    BOOL unsafe=privacy && (!known || !self.isActive || !self.projection.isValid || self.snapshotRetryAttempted ||
        self.snapshotEpoch!=epoch || ![self.projection.accountID isEqual:account] ||
        CSGroupReadInteger(self.projection,@"privacyRevision",-1)!=(long long)policy.revision);
    if (privacy && !unsafe) for (UITableViewCell *cell in cells) {
        NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);
        CSGroupRow *row=delivery[@"row"];
        if (!row || ![delivery[@"account"] isEqual:account] ||
            [policy hidesUserName:row.userName surface:CSCloseFriendSurfaceSession]) { unsafe=YES; break; }
    }
    CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
    if (current!=policy || current.blocked || current.revision!=policy.revision ||
        epoch!=CSCloseFriendAccountEpoch() || ![current.accountID isEqual:account] ||
        ![account isEqual:CSGroupCurrentAccountID()]) unsafe=YES;
    if (!unsafe) return;
    // Neutralize the existing content layer before the animator can expose it.
    // Preserve table geometry/gestures; only a completed publication releases it.
    if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
    for (UITableViewCell *cell in cells) [self.privacyShield shieldCell:cell];
    objc_setAssociatedObject(self,@selector(prepareForVisibility),@YES,OBJC_ASSOCIATION_RETAIN);
    self.sessionLayoutHeld=YES;
    BOOL needsRefresh=!self.privacyRefreshPending;
    self.privacyRefreshPending=YES; self.dirty=YES;
    if (needsRefresh && !current.blocked && [current.accountID isEqual:CSGroupCurrentAccountID()] &&
        !self.publishing && !self.changeDepth) [self requestRefresh];
}
- (BOOL)groupPanMoving {
    return self.pan.state==UIGestureRecognizerStateBegan || self.pan.state==UIGestureRecognizerStateChanged ||
        self.listPan.state==UIGestureRecognizerStateBegan || self.listPan.state==UIGestureRecognizerStateChanged;
}
- (NSInteger)listZoneForTouch:(UITouch *)touch {
    CGPoint point=[touch locationInView:self.table];
    CGRect viewport=self.table.bounds;
    if (!CGRectContainsPoint(viewport,point)) return -1;
    return point.x>=CGRectGetMinX(viewport)+CGRectGetWidth(viewport)*0.85 ? 1 : 0;
}
- (BOOL)nativeMenuGesture:(UIGestureRecognizer *)gesture inCell:(UIView *)cell shouldReceiveTouch:(UITouch *)touch {
    if (![self groupSwipesAvailable] || gesture!=CSGroupReadObject(cell,@"_panGestureRecognizer")) return YES;
    // UIKit asks once at touch-down. Never reconsider using the translated row
    // frame or the finger's position after crossing the 85% boundary.
    return [self listZoneForTouch:touch]==1;
}
- (BOOL)closeMenusForGroupSwitch {
    if (![self nativeMenuState] && !self.swipeActive && !self.table.editing) return YES;
    [self beginNativeChange];
    @try {
        __block NSArray *cells=nil;
        CSGroupWithDisplayIndices(self.table, ^{ cells=self.table.visibleCells; });
        Class menuClass=NSClassFromString(@"MMBaseMultiMenuTableViewCell");
        SEL hide=NSSelectorFromString(@"setMenuOptionsViewHidden:animated:completionHandler:");
        for (UITableViewCell *cell in cells) {
            if (menuClass && [cell isKindOfClass:menuClass] && [cell respondsToSelector:hide])
                ((void(*)(id,SEL,BOOL,BOOL,id))objc_msgSend)(cell,hide,YES,NO,nil);
        }
        [self.table setEditing:NO animated:NO];
        [self endSwipeEditing];
    } @finally { [self endNativeChange]; }
    return ![self nativeMenuState] && !self.table.editing && !self.swipeActive;
}
- (NSUInteger)nativeMenuState {
    // WeChat's custom row menu is independent of UITableView.editing/tracking.
    // Bit 0 blocks publication; bit 1 needs a short wake-up while motion settles.
    if (!self.table || !self.chromeVisible || !Option(@"enabled") || self.searching) return 0;
    Class menuClass=NSClassFromString(@"MMBaseMultiMenuTableViewCell");
    if (!menuClass) return 0;
    __block NSArray *cells=nil;
    CSGroupWithDisplayIndices(self.table, ^{ cells=self.table.visibleCells; });
    NSUInteger state=0;
    for (UITableViewCell *cell in cells) {
        if (![cell isKindOfClass:menuClass]) continue;
        NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);
        if (delivery && ![delivery[@"account"] isEqual:CSGroupCurrentAccountID()]) continue;
        CSGroupRow *row=delivery[@"row"];
        // A genuinely deleted row must not keep its stale menu alive forever.
        if (self.dirty && !self.changeDepth && row.userName.length && ![self currentPathForRow:row]) continue;
        id pan=CSGroupReadObject(cell,@"_panGestureRecognizer");
        BOOL moving=[pan isKindOfClass:UIGestureRecognizer.class] &&
            ([(UIGestureRecognizer *)pan state]==UIGestureRecognizerStateBegan || [(UIGestureRecognizer *)pan state]==UIGestureRecognizerStateChanged);
        Ivar hiding=class_getInstanceVariable(object_getClass(cell),"_inHideAnimation");
        if (hiding && strchr("Bc",ivar_getTypeEncoding(hiding)[0])) {
            unsigned char flag=0;
            memcpy(&flag,(const char *)(__bridge const void *)cell+ivar_getOffset(hiding),sizeof(flag));
            moving |= flag!=0;
        }
        if (moving) state|=3;
        else if (!CSGroupReadInteger(cell,@"isMenuHidden",1)) state|=1;
    }
    return state;
}
- (void)nativeMenuDidChange {
    if (self.presentationSuspended || !CSGroupApplicationActive()) return;
    [self updateGroupGestureAvailability];
    [self restorePendingViewport];
    if (self.dirty) [self scheduleRefresh];
}
- (void)invalidateNativeSnapshot {
    objc_setAssociatedObject(self,@selector(performSessionListLayout:),nil,OBJC_ASSOCIATION_RETAIN);
    @synchronized (self) { self.modelRevision++; }
}
- (NSArray *)nativeSectionsForAccount:(NSString *)account changes:(CSGroupChangeKind)changes
                     changedUserNames:(NSSet<NSString *> *)changedUserNames {
    NSUInteger revision=self.modelRevision, epoch=CSCloseFriendAccountEpoch();
    if (![account isEqual:CSGroupCurrentAccountID()] || epoch!=CSCloseFriendAccountEpoch() || revision!=self.modelRevision) {
        self.cachedNativeSections=nil; return nil;
    }
    if (self.cachedNativeSections && self.snapshotRevision==revision && self.snapshotEpoch==epoch && [self.snapshotAccount isEqual:account]) return self.cachedNativeSections;
    if (!self.changeDepth && self.tabBadgeSections && self.tabBadgeRevision==revision && self.tabBadgeEpoch==epoch && [self.tabBadgeAccount isEqual:account]) {
        self.cachedNativeSections=self.tabBadgeSections; self.snapshotAccount=account; self.snapshotRevision=revision; self.snapshotEpoch=epoch;
        return self.cachedNativeSections;
    }
    __block NSArray *sections=nil;
    NSArray *previous=self.snapshotEpoch==epoch && [self.snapshotAccount isEqual:account] ? self.cachedNativeSections : nil;
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    long long previousPrivacyRevision=CSGroupReadInteger(self.projection,@"privacyRevision",-1);
    BOOL reusable=previous && !self.privacyRefreshPending && !policy.blocked && previousPrivacyRevision>=0 &&
        previousPrivacyRevision==(long long)policy.revision && [policy.accountID isEqual:account] &&
        [policy.options[@"hideSessions"] isKindOfClass:NSNumber.class] &&
        revision==self.modelRevision && epoch==CSCloseFriendAccountEpoch() && [account isEqual:CSGroupCurrentAccountID()];
    CSGroupChangeKind effectiveChanges=reusable ? changes : changes|CSGroupChangeUnknown;
    NSSet *effectiveNames=reusable ? changedUserNames : nil;
    // Hints reduce metadata reads only. The bridge still verifies every host
    // identity, slot, top flag and final count before retaining an old value.
    CSGroupWithNativeIndices(self.table, ^{
        sections=CSGroupBuildNativeSectionsForChanges(self.controller,self.table,[self nativeSource],previous,effectiveChanges,effectiveNames);
    });
    // Only immutable row values are cached; never hold private sessions/contacts.
    CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
    if (![account isEqual:CSGroupCurrentAccountID()] || epoch!=CSCloseFriendAccountEpoch() || revision!=self.modelRevision ||
        (reusable && (current.blocked || current.revision!=policy.revision || ![current.accountID isEqual:account]))) {
        self.cachedNativeSections=nil; return nil;
    }
    self.cachedNativeSections=sections; self.snapshotAccount=account; self.snapshotRevision=revision; self.snapshotEpoch=epoch;
    return sections;
}
- (void)pruneNativeActions {
    if (!self.nativeActions.count) return;
    if (![self.nativeActionsAccount isEqual:CSGroupCurrentAccountID()]) {
        [self.nativeActions removeAllObjects]; self.nativeActionsAccount=nil;
        self.nativePresentation=NO;
    }
}
// Native arrays already own membership and ordering. This snapshot is only
// display metadata; it is never used as a UITableView data source or row mapper.
- (BOOL)adoptCompatibilityModelIfNeeded {
    if (!self.usesNativeSessionModel || !CSGroupNativeSessionCoordinator.sharedCoordinator.compatibilityFallback) return NO;
    // The coordinator has restored the complete host source before releasing
    // ownership. Reuse the established projection/privacy path for this page.
    self.usesNativeSessionModel=NO;
    self.nativeRecoveryGeneration++;self.nativeRecoveryKey=nil;
    self.projection=nil;self.cachedNativeSections=nil;self.tabBadgeSections=nil;
    self.identityDisplayPaths=nil;self.nativeBoundaryHeld=NO;
    self.projecting=YES;self.sessionLayoutHeld=YES;self.snapshotRetryAttempted=NO;
    self.privacyRefreshPending=YES;self.dirty=YES;self.immediateRefreshPending=YES;
    [self invalidateNativeSnapshot];
    @synchronized (self) { self.pendingChanges|=CSGroupChangeUnknown; }
    if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
    for (UITableViewCell *cell in self.table.visibleCells) [self.privacyShield shieldCell:cell];
    [self installProxies];
    return YES;
}
- (void)nativeSessionModelChanged:(NSNotification *)notification {
    if ([self adoptCompatibilityModelIfNeeded]) { [self requestRefresh];return; }
    if (!self.usesNativeSessionModel) return;
    CSGroupNativeSessionCoordinator *coordinator=[CSGroupNativeSessionCoordinator sharedCoordinator];
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL urgent=coordinator.boundary || self.nativeBoundaryHeld || [notification.userInfo[@"boundary"] boolValue] ||
        self.privacyRefreshPending || self.nativeActions.count ||
        self.snapshotEpoch!=coordinator.epoch || ![self.snapshotAccount isEqual:coordinator.accountID] ||
        policy.blocked || ![policy.accountID isEqual:self.snapshotAccount] ||
        CSGroupReadInteger(self.projection,@"privacyRevision",-1)!=(long long)policy.revision;
    NSNumber *kind=notification.userInfo[@"changes"];
    id names=notification.userInfo[@"changedUserNames"];
    BOOL named=[notification.userInfo[@"allChangesKnown"] boolValue] && [names isKindOfClass:NSSet.class];
    [self mergePendingChangeOfKind:[kind isKindOfClass:NSNumber.class] ? kind.unsignedIntegerValue : CSGroupChangeUnknown
        changedUserNames:named ? names : nil];
    [self invalidateNativeSnapshot];
    // Keep immutable values as reuse candidates; account/epoch/revision checks
    // still gate every read and all current host identities are revalidated.
    self.tabBadgeSections=nil;
    self.dirty=YES;
    [self shieldVisiblePrivateRows];
    // Source messages may wake recovery early, but do not reset a persistent
    // metadata failure. Its budget belongs to the account/policy/group key and
    // is reset only when that key changes or a publication succeeds.
    if (urgent) {
        self.immediateRefreshPending=YES;
        [self scheduleRefresh];
        [self requestTabBadgeSourceRefresh];
    } else {
        // Persist the request even if this notification arrives inside a
        // publication; its finally block schedules the next merged refresh.
        [self requestCoalescedRefresh];
        [self requestTabBadgeSourceRefreshCoalesced:YES];
    }
}
- (void)scheduleNativeRecoveryForKey:(NSArray *)key {
    if (![self.nativeRecoveryKey isEqual:key]) {
        self.nativeRecoveryKey=key;self.nativeRecoveryAttempts=0;self.nativeRecoveryGeneration++;
    }
    if (self.nativeRecoveryAttempts>=3) {
        // Persistent host metadata incompatibility is different from an
        // uncertain privacy boundary. Fall back only after the coordinator has
        // safely relinquished its native arrays under the current policy.
        [CSGroupNativeSessionCoordinator.sharedCoordinator useCompatibilityFallback];
        if ([self adoptCompatibilityModelIfNeeded]) [self scheduleRefresh];
        return;
    }
    static const NSTimeInterval delays[]={0.1,0.25,0.5};
    NSTimeInterval delay=delays[self.nativeRecoveryAttempts++];
    NSUInteger generation=++self.nativeRecoveryGeneration;
    __weak typeof(self) weakSelf=self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        CSGroupListAdapter *self=weakSelf;
        if (!self || generation!=self.nativeRecoveryGeneration || ![self.nativeRecoveryKey isEqual:key]) return;
        self.dirty=YES;[self refresh];
    });
}
- (void)refreshNativeSessionModel {
    if (!NSThread.isMainThread) { [self requestRefresh]; return; }
    if ([self adoptCompatibilityModelIfNeeded]) { [self refresh];return; }
    if (self.publishing) return;
    [self prepareInitialViewport];
    NSDictionary *sourceViewport=(self.presentationViewport || self.switchViewport) ? nil : [self captureViewportForTabID:self.publishedTabID];
    [self pruneNativeActions];
    if ((!CSGroupApplicationActive() && !self.privacyRefreshPending) ||
        (self.presentationSuspended && !self.nativeActions.count)) { self.dirty=YES; return; }
    if (self.changeDepth || (!self.privacyRefreshPending && !self.presentationSuspended &&
        [self refreshInteractionIsBlocking])) {
        self.dirty=YES; [self scheduleRefresh]; return;
    }
    [self consumeRefreshRequest];
    self.publishing=YES; self.dirty=NO;
    CSGroupChangeKind changes;
    NSSet *changedUserNames;
    NSUInteger requestedRevision;
    @synchronized (self) {
        changes=self.pendingChanges; self.pendingChanges=0;
        changedUserNames=self.pendingChangeNamesUnknown ? nil : [self.pendingChangedUserNames copy];
        self.pendingChangedUserNames=nil;self.pendingChangeNamesUnknown=NO;
        requestedRevision=self.modelRevision;
    }
    BOOL finished=NO;
    @try {
        [self saveAnchor];
        NSString *account=CSGroupCurrentAccountID();
        if (![self.preferences.accountID isEqual:account]) {
            self.preferences=account.length ? [[CSGroupPreferences alloc] initWithDefaults:NSUserDefaults.standardUserDefaults accountID:account] : nil;
            self.anchors=[NSMutableDictionary dictionary]; self.projection=nil;
            self.nativePresentation=self.nativeActions.count>0;
        } else [self.preferences reload];
        BOOL enabled=Option(@"enabled");
        self.searching=CSGroupReadInteger(self.controller,@"isSearching",0)!=0;
        if (!self.searching) self.searchChromeVisible=NO;
        BOOL keepsSearchGroup=enabled && self.searching && self.searchChromeVisible && !self.nativePresentation;
        CSGroupNativeSessionCoordinator *coordinator=[CSGroupNativeSessionCoordinator sharedCoordinator];
        [coordinator setMainController:self.controller];
        coordinator.nativePresentation=self.nativePresentation || (self.searching && !keepsSearchGroup);
        [coordinator refreshFromPreferences];
        if (coordinator.compatibilityFallback) { [self adoptCompatibilityModelIfNeeded];return; }
        CSGroupNativeModelResult *model=coordinator.model;
        NSUInteger nativeRevision=coordinator.revision, epoch=CSCloseFriendAccountEpoch();
        NSUInteger modelRevision=self.modelRevision;
        CSGroupChangeKind effectiveChanges=modelRevision==requestedRevision ? changes : changes|CSGroupChangeUnknown;
        NSSet *effectiveNames=modelRevision==requestedRevision ? changedUserNames : nil;
        CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
        NSArray *tabs=self.preferences.tabs ?: @[];
        NSString *selected=model.selectedTabID ?: self.preferences.selectedTabID ?: @"preset_0";
        if (![tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab,NSDictionary *bindings) {
            (void)bindings; return [tab.tabId isEqual:selected];
        }]].count) tabs=[@[[WESessionTabItem tabWithType:WETabTypeAll]] arrayByAddingObjectsFromArray:tabs];
        BOOL previouslyProjecting=self.projecting && !self.snapshotRetryAttempted && !self.nativeBoundaryHeld &&
            !self.privacyRefreshPending && [self.snapshotAccount isEqual:account] && self.snapshotEpoch==epoch &&
            [self.publishedTabID isEqual:selected] && self.publishedEnabled==enabled;
        NSArray *sections=nil;
        if (!coordinator.boundary && model.isValid && [account isEqual:coordinator.accountID] &&
            coordinator.epoch==epoch) {
            NSArray *reuse=self.snapshotEpoch==epoch && [self.snapshotAccount isEqual:account] ? self.cachedNativeSections : nil;
            sections=CSGroupBuildNativeSectionsForChanges(self.controller,self.table,[self nativeSource],reuse,effectiveChanges,effectiveNames);
        }
        CSGroupProjection *previous=self.projection;
        // Named rows can remap the coordinator's already computed
        // membership and badges into verified host coordinates. Scoped folded
        // summaries, wrapper counters and incomplete shapes retain the full projection.
        NSArray *mapped=sections ? CSGroupMapNativeSectionsToProjection(sections,model.projection) : nil;
        CSGroupProjection *metadata=mapped ? [model.projection projectionByRemappingVisibleRows:mapped] : nil;
        if (!metadata && sections) metadata=[self projectionForSections:sections tabs:tabs selectedTabID:selected accountID:account];
        // Never create a second visible list. Reject metadata if classification
        // would change even one host slot (including anonymous business rows).
        BOOL identical=metadata.isValid && metadata.sections.count==sections.count;
        for (NSUInteger i=0;identical && i<sections.count;i++) {
            NSArray *nativeRows=sections[i],*displayRows=metadata.sections[i];
            identical=nativeRows.count==displayRows.count;
            for (NSUInteger j=0;identical && j<nativeRows.count;j++)
                identical=[((CSGroupRow *)nativeRows[j]).nativePath isEqual:((CSGroupRow *)displayRows[j]).nativePath];
        }
        // Host getters and folded-summary formatting can synchronously publish
        // another native revision. Never stamp old metadata with that revision.
        CSCloseFriendSnapshot *currentPolicy=CSCloseFriendCurrentSnapshot();
        if (self.changeDepth || coordinator.boundary || coordinator.model!=model || coordinator.revision!=nativeRevision ||
            self.modelRevision!=modelRevision || coordinator.epoch!=epoch || epoch!=CSCloseFriendAccountEpoch() || policy.blocked || !identical ||
            currentPolicy.blocked || currentPolicy.revision!=policy.revision ||
            ![currentPolicy.options[@"hideSessions"] isKindOfClass:NSNumber.class] ||
            ![account isEqual:policy.accountID] || ![account isEqual:currentPolicy.accountID] ||
            ![account isEqual:coordinator.accountID] || ![account isEqual:CSGroupCurrentAccountID()]) {
            self.projection=nil; self.projecting=YES; self.snapshotRetryAttempted=YES;
            self.sessionLayoutHeld=YES; self.privacyRefreshPending=YES;
            if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
            for (UITableViewCell *cell in self.table.visibleCells) [self.privacyShield shieldCell:cell];
            // Host row counts may settle after its source rebuild. Retry this
            // UI boundary finitely; our own rebuild notification cannot renew it.
            self.dirty=NO;
            [self scheduleNativeRecoveryForKey:@[account ?: @"",@(CSCloseFriendAccountEpoch()),@(policy.revision),selected,@(enabled)]];
            return;
        }
        self.nativeRecoveryKey=nil;self.nativeRecoveryAttempts=0;self.nativeRecoveryGeneration++;
        self.nativeBoundaryHeld=NO;
        self.projection=metadata; self.cachedNativeSections=sections;
        self.snapshotAccount=account; self.snapshotEpoch=epoch; self.snapshotRevision=self.modelRevision;
        self.nativeModelRevision=nativeRevision;
        self.snapshotRetryAttempted=NO; self.snapshotRetryGeneration++;
        self.tabBadgeSections=@[model.sourceRows]; self.tabBadgeAccount=account;
        self.tabBadgeEpoch=epoch; self.tabBadgeRevision=self.modelRevision;
        self.identityDisplayPaths=nil; // Native identity resolution is the only index domain.
        self.projecting=YES; self.publishedEnabled=enabled; self.publishedTabID=selected;
        self.chromeVisible=enabled && (!self.searching || keepsSearchGroup) && account.length>0;
        self.displayedTabs=tabs;
        // Consume this publication's privacy/visibility request before any UI
        // call can synchronously raise a new request for the next publication.
        self.privacyRefreshPending=NO;
        objc_setAssociatedObject(self,@selector(prepareForVisibility),nil,OBJC_ASSOCIATION_RETAIN);
        [self ensureChrome];
        BOOL appearanceChanged=self.appearanceDirty;
        if (appearanceChanged) { [self.chrome refreshAppearance];self.appearanceDirty=NO; }
        [self.chrome updateTabs:tabs];
        if (appearanceChanged || ![self.chrome.selectedTabID isEqual:selected]) self.chrome.selectedTabID=selected;
        [tabs enumerateObjectsUsingBlock:^(WESessionTabItem *tab,NSUInteger index,BOOL *stop) {
            (void)stop;CSGroupBadge *badge=[model.projection badgeForTabID:tab.tabId];
            BOOL hidden=Option(tab.type==WETabTypeAll ? @"hide_all_badge" : @"hide_group_badge");
            [self.chrome updateUnreadCount:hidden ? 0 : (NSInteger)MIN(badge.count,(NSUInteger)NSIntegerMax)
                hasRedDot:!hidden && badge.redDot forTabIndex:(NSInteger)index];
        }];
        [self layout];
        CSCloseFriendSnapshot *publicationPolicy=CSCloseFriendCurrentSnapshot();
        if (self.changeDepth || self.privacyRefreshPending || coordinator.boundary || coordinator.model!=model ||
            coordinator.revision!=nativeRevision || self.modelRevision!=modelRevision ||
            epoch!=CSCloseFriendAccountEpoch() || publicationPolicy.blocked ||
            publicationPolicy.revision!=policy.revision ||
            ![publicationPolicy.accountID isEqual:account] || ![account isEqual:CSGroupCurrentAccountID()]) {
            self.privacyRefreshPending=YES;self.dirty=YES;
            if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
            for (UITableViewCell *cell in self.table.visibleCells) [self.privacyShield shieldCell:cell];
            return;
        }
        [self.privacyShield prepareForPublication];
        [self publishNativeProjection:metadata previous:previous changes:effectiveChanges changedUserNames:effectiveNames
            previouslyProjecting:previouslyProjecting];
        for (UITableViewCell *cell in self.table.visibleCells) {
            NSIndexPath *path=[self.table indexPathForCell:cell];
            if (path) [self bindNativeCell:cell atPath:path];
        }
        [self restoreViewportFromSource:sourceViewport]; [self refreshNavigationTitle]; finished=YES;
    } @finally {
        self.publishing=NO;
        if (!finished && changes) [self mergePendingChangeOfKind:changes changedUserNames:changedUserNames];
        if (finished) {
            [self restorePendingViewport];
            NSArray *actions=[self.nativeActions copy];[self.nativeActions removeAllObjects];
            for (void (^action)(void) in actions) action();
        }
        [self requestTabBadgeSourceRefresh];
        if (self.dirty) [self scheduleRefresh];
    }
}
- (void)bindNativeCell:(UITableViewCell *)cell atPath:(NSIndexPath *)path {
    if (!self.usesNativeSessionModel || !cell) return;
    CSGroupNativeSessionCoordinator *coordinator=[CSGroupNativeSessionCoordinator sharedCoordinator];
    CSGroupRow *row=[self.projection rowAtDisplayPath:path];
    NSString *name=CSGroupNativeUserNameAtPath(self.controller,path);
    NSIndexPath *verifiedPath=row ? [self currentPathForRow:row] : nil;
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL known=!policy.blocked && [policy.accountID isEqual:self.snapshotAccount] &&
        CSGroupReadInteger(self.projection,@"privacyRevision",-1)==(long long)policy.revision && !coordinator.boundary && self.nativeModelRevision==coordinator.revision &&
        self.snapshotEpoch==coordinator.epoch && [self.snapshotAccount isEqual:coordinator.accountID] &&
        [self.snapshotAccount isEqual:CSGroupCurrentAccountID()] && row && [verifiedPath isEqual:path] &&
        [(name ?: @"") isEqual:(row.userName ?: @"")] && !CSCloseFriendShouldHideUserName(name,CSCloseFriendSurfaceSession);
    objc_setAssociatedObject(cell,&CellRowKey,known ? @{@"row":row,@"account":self.snapshotAccount} : nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSCloseFriendUpdateSessionCover(cell,known ? row : nil);
    if (!known) {
        if (coordinator.boundary) self.nativeBoundaryHeld=YES;
        if (!self.privacyShield) self.privacyShield=[CSCloseFriendListShield new];
        [self.privacyShield shieldCell:cell];
        if (!self.publishing && !coordinator.boundary) [self requestRecovery];
    }
}
- (void)refresh {
    if (NSThread.isMainThread) [self adoptCompatibilityModelIfNeeded];
    if (self.usesNativeSessionModel) { [self refreshNativeSessionModel]; return; }
    if (!NSThread.isMainThread) { [self requestRefresh]; return; }
    if (self.publishing) return;
    [self prepareInitialViewport];
    NSDictionary *sourceViewport=(self.presentationViewport || self.switchViewport) ? nil : [self captureViewportForTabID:self.publishedTabID];
    [self pruneNativeActions];
    // Explicit native navigation is the only offscreen publication exception.
    // Ordinary message/unread/draft updates merely invalidate the cached list.
    if ((!CSGroupApplicationActive() && !(self.privacyRefreshPending && CSGroupPrivacyActive())) || (self.presentationSuspended && !self.nativeActions.count)) {
        self.dirty=YES; [self finishSuspendedBatches]; return;
    }
    // A horizontal row swipe starts tracking before UIKit reports editing or
    // dragging. Reloading in that window replaces the cell under the finger.
    if (!self.privacyRefreshPending && !self.presentationSuspended && (self.table.tracking || [self groupPanMoving])) { self.dirty=YES; [self scheduleRefresh]; return; }
    NSUInteger menuState=(self.privacyRefreshPending || self.presentationSuspended) ? 0 : [self nativeMenuState];
    if (menuState) {
        self.dirty=YES;
        if (menuState&2) [self scheduleRefresh];
        return;
    }
    if (!self.presentationSuspended) [self reconcileDeletedSwipeRow];
    if (self.changeDepth || (!self.privacyRefreshPending && !self.presentationSuspended && (self.table.dragging || self.table.decelerating || self.table.editing || self.swipeActive))) { self.dirty=YES; return; }
    self.interactionDeadline=0; self.interactionAttempts=0;
    [self consumeRefreshRequest];
    self.publishing=YES; self.dirty=NO;
    CSGroupChangeKind changes;
    NSSet *changedUserNames;
    NSUInteger requestedRevision;
    @synchronized (self) {
        changes=self.pendingChanges; self.pendingChanges=0;
        changedUserNames=self.pendingChangeNamesUnknown ? nil : [self.pendingChangedUserNames copy];
        self.pendingChangedUserNames=nil;self.pendingChangeNamesUnknown=NO;
        requestedRevision=self.modelRevision;
    }
    self.recoveryPending=NO;
    BOOL finished=NO;
    @try {
        [self saveAnchor];
        [self installProxies];
        NSString *account=CSGroupCurrentAccountID();
        BOOL changed= ![self.preferences.accountID isEqualToString:account];
        if (changed) { [self invalidateNativeSnapshot]; self.anchors=[NSMutableDictionary dictionary]; self.nativePresentation=self.nativeActions.count>0; self.projection=nil; self.snapshotRetryAttempted=NO; self.searchChromeVisible=NO; }
        self.searching=CSGroupReadInteger(self.controller,@"isSearching",0)!=0;
        if (!self.searching) self.searchChromeVisible=NO;
        BOOL enabled=Option(@"enabled");
        BOOL privacy=CSGroupPrivacyActive();
        // Search owns a separate page. Preserve the selected list behind its
        // transition instead of publishing unfiltered rows underneath group tabs.
        // Explicit result navigation may still require native coordinates.
        BOOL keepsSearchGroup=enabled && self.searching && self.searchChromeVisible && account.length && !changed &&
            !self.nativePresentation && !self.nativeActions.count;
        if (keepsSearchGroup && !self.privacyRefreshPending && self.projecting) {
            @synchronized (self) { self.pendingChanges|=changes|CSGroupChangeUnknown; }
            self.cachedNativeSections=nil; [self.projection discardComputationCache];
            [self layout]; finished=YES; return;
        }
        if ((!privacy && (!enabled || (self.searching && !keepsSearchGroup))) || !account.length) {
            BOOL needsReload=self.projecting || self.nativeActions.count>0;
            BOOL hadChrome=self.chromeVisible;
            self.projecting=NO; self.chromeVisible=NO; self.publishedEnabled=enabled;
            self.projection=nil; self.identityDisplayPaths=nil; self.cachedNativeSections=nil;
            [self layout];
            if (needsReload) CSGroupWithDisplayIndices(self.table, ^{
                [self.privacyShield prepareForPublication];
                [self.table reloadData]; [self.table layoutIfNeeded];
            });
            if (hadChrome) [self refreshNavigationTitle];
            finished=YES; return;
        }
        if (!self.preferences || changed) self.preferences=[[CSGroupPreferences alloc] initWithDefaults:NSUserDefaults.standardUserDefaults accountID:account];
        else [self.preferences reload];
        [self ensureChrome];
        NSArray *tabs=self.preferences.tabs; NSString *selected=self.preferences.selectedTabID;
        // A privacy change during search must rebuild this same group. It must
        // neither retain newly hidden rows nor replace the transition with All.
        if (self.nativePresentation || !enabled || (self.searching && !keepsSearchGroup)) {
            selected=@"preset_0";
            if (![tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab, NSDictionary *bindings) { (void)bindings; return [tab.tabId isEqual:selected]; }]].count)
                tabs=[@[[WESessionTabItem tabWithType:WETabTypeAll]] arrayByAddingObjectsFromArray:tabs];
        }
        CSGroupProjection *previous=self.projection;
        BOOL previouslyProjecting=self.projecting && self.snapshotEpoch==CSCloseFriendAccountEpoch();
        BOOL requestedSourceCurrent=self.modelRevision==requestedRevision;
        NSArray *sections=(self.nativePresentation && !privacy) ? nil : [self nativeSectionsForAccount:account
            changes:requestedSourceCurrent ? changes : changes|CSGroupChangeUnknown
            changedUserNames:requestedSourceCurrent ? changedUserNames : nil];
        CSGroupProjection *projection=(self.nativePresentation && !privacy) ? nil : [self projectionForSections:sections tabs:tabs selectedTabID:selected accountID:account];
        self.projection=projection;
        if (![projection hasSameDisplayStructureAs:previous]) {
            NSMutableDictionary *identities=[NSMutableDictionary dictionary];
            [self.projection.sections enumerateObjectsUsingBlock:^(NSArray *rows, NSUInteger s, BOOL *stop) {
                (void)stop; [rows enumerateObjectsUsingBlock:^(CSGroupRow *row, NSUInteger r, BOOL *end) {
                    (void)end; if (row.userName.length) identities[row.userName]=identities[row.userName] ? (id)NSNull.null : [NSIndexPath indexPathForRow:(NSInteger)r inSection:(NSInteger)s];
                }];
            }]; self.identityDisplayPaths=identities;
        }
        self.displayedTabs=tabs;
        BOOL projecting=(privacy || (enabled && (!self.searching || keepsSearchGroup) && !self.nativePresentation)) && self.projection.isValid && account.length>0;
        if (projecting && self.prefetchedPaths.count) {
            id prefetch=self.proxies[@2].target;
            NSArray *paths=self.prefetchedPaths.allObjects;
            CSGroupWithNativeIndices(self.table, ^{ if ([prefetch respondsToSelector:@selector(tableView:cancelPrefetchingForRowsAtIndexPaths:)]) [prefetch tableView:self.table cancelPrefetchingForRowsAtIndexPaths:paths]; });
            [self.prefetchedPaths removeAllObjects];
        }
        self.projecting=projecting;
        self.chromeVisible=enabled && !CSGroupIsFoldedController(self.controller) && (!self.searching || keepsSearchGroup) && account.length>0;
        self.publishedEnabled=Option(@"enabled");
        self.publishedTabID=selected;
        if (self.appearanceDirty) { [self.chrome refreshAppearance]; self.appearanceDirty=NO; }
        self.chrome.selectedTabID=selected; [self.chrome updateTabs:tabs]; self.chrome.selectedTabID=selected;
        id logic=CSGroupReadObject(self.controller,@"m_mainFrameLogicController");
        [tabs enumerateObjectsUsingBlock:^(WESessionTabItem *tab, NSUInteger index, BOOL *stop) {
            (void)stop; if (!projection && tab.type!=WETabTypeAll) return;
            CSGroupBadge *badge=[projection badgeForTabID:tab.tabId];
            NSInteger count=tab.type==WETabTypeAll && !privacy ? (NSInteger)MAX(0,CSGroupReadInteger(logic,@"getTotalUnreadCount",(long long)badge.count)) : (NSInteger)MIN(badge.count,(NSUInteger)NSIntegerMax);
            BOOL hidden=Option(tab.type==WETabTypeAll ? @"hide_all_badge" : @"hide_group_badge");
            [self.chrome updateUnreadCount:hidden ? 0 : count hasRedDot:!hidden && badge.redDot forTabIndex:(NSInteger)index];
        }];
        [self layout];
        [self.privacyShield prepareForPublication];
        // A source getter or header layout may synchronously raise another
        // native change. Its names belong to the next batch; this publication
        // must retain the conservative complete refresh in that case.
        BOOL sourceUnchanged=self.modelRevision==requestedRevision;
        [self publishProjection:projection previous:previous
            changes:sourceUnchanged ? changes : changes|CSGroupChangeUnknown
            changedUserNames:sourceUnchanged ? changedUserNames : nil previouslyProjecting:previouslyProjecting];
        [self restoreViewportFromSource:sourceViewport];
        [self refreshNavigationTitle];
        finished=YES;
    } @finally {
        self.publishing=NO;
        if (!finished && self.privacyRefreshPending) [self shieldVisiblePrivateRows];
        if (finished) {
            if (![objc_getAssociatedObject(self,@selector(prepareForVisibility)) boolValue] ||
                [CSGroupReadObject(CSCloseFriendCurrentSnapshot(),@"options")[@"hideSessions"] isKindOfClass:NSNumber.class])
                objc_setAssociatedObject(self,@selector(prepareForVisibility),nil,OBJC_ASSOCIATION_RETAIN);
            self.privacyRefreshPending=NO;
            if (CSCloseFriendCurrentSnapshot().blocked && !CSGroupCurrentAccountID().length)
                [self shieldVisiblePrivateRows];
            else if (!self.sessionLayoutHeld)
                [self.privacyShield prepareForPublication];
        }
        if (finished) [self restorePendingViewport];
        NSArray *callbacks=[self.completions copy]; [self.completions removeAllObjects];
        for (void (^completion)(BOOL) in callbacks) completion(finished);
        if (finished && CSGroupApplicationActive() && (!self.isActive || CSGroupPrivacyActive()) && !self.changeDepth) {
            NSArray *actions=[self.nativeActions copy]; [self.nativeActions removeAllObjects];
            for (void (^action)(void) in actions) CSGroupWithNativeIndices(self.table,action);
        }
        if (self.dirty) [self scheduleRefresh];
        if (finished && !self.tabBadgeSourceScheduled) [self requestTabBadgeSourceRefresh];
    }
}
// Native membership/order already belongs to MainSessionMgr. Content changes
// (including a folded digest/count) do not replace that verified coordinate
// space, so UIKit can refresh just the affected visible cells and their heights.
- (void)publishNativeProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                       changes:(CSGroupChangeKind)changes changedUserNames:(NSSet<NSString *> *)changedUserNames
           previouslyProjecting:(BOOL)previouslyProjecting {
    BOOL (^equal)(id,id)=^BOOL(id a,id b) { return a==b || [a isEqual:b]; };
    BOOL incremental=previouslyProjecting && self.projecting &&
        !(changes&CSGroupChangeUnknown) && projection.isValid && previous.isValid &&
        [projection.accountID isEqual:previous.accountID] && projection.sections.count==previous.sections.count;
    for (NSUInteger s=0;incremental && s<projection.sections.count;s++) {
        NSArray *rows=projection.sections[s],*oldRows=previous.sections[s];
        incremental=rows.count==oldRows.count;
        for (NSUInteger r=0;incremental && r<rows.count;r++) {
            CSGroupRow *row=rows[r],*old=oldRows[r];
            incremental=row==old || ([row.nativePath isEqual:old.nativePath] && equal(row.userName,old.userName) &&
                row.kind==old.kind && row.category==old.category && row.top==old.top &&
                row.privacyMasked==old.privacyMasked && row.foldedEntryScoped==old.foldedEntryScoped &&
                row.foldedEntryPrivacyRevision==old.foldedEntryPrivacyRevision && equal(row.foldedEntryAccountID,old.foldedEntryAccountID));
        }
    }
    // UIKit keeps its previous row counts until an update is delivered. A host
    // update or a replaced table may have invalidated them independently.
    if (incremental) incremental=self.table.numberOfSections==(NSInteger)projection.sections.count;
    for (NSUInteger s=0;incremental && s<projection.sections.count;s++)
        incremental=[self.table numberOfRowsInSection:(NSInteger)s]==(NSInteger)projection.sections[s].count;
    if (!incremental) {
        [self.table reloadData];
        [self.table layoutIfNeeded];
        return;
    }
    NSMutableArray *reload=[NSMutableArray array];
    for (NSIndexPath *path in self.table.indexPathsForVisibleRows ?: @[]) {
        CSGroupRow *row=[projection rowAtDisplayPath:path],*old=[previous rowAtDisplayPath:path];
        if (!row || !old) continue;
        BOOL changed=row!=old && (row.unreadCount!=old.unreadCount || row.redDot!=old.redDot ||
            !equal(row.nativeSummary,old.nativeSummary) || !equal(row.nativePrefix,old.nativePrefix) ||
            !equal(row.nativeSortTime,old.nativeSortTime) || !equal(row.foldedEntryCount,old.foldedEntryCount) ||
            !equal(row.foldedEntrySummary,old.foldedEntrySummary) || !equal(row.foldedEntryPrefix,old.foldedEntryPrefix) ||
            !equal(row.foldedEntrySummaryUserName,old.foldedEntrySummaryUserName));
        if (changes&(CSGroupChangeContent|CSGroupChangeStructure))
            changed |= !changedUserNames || !row.userName.length || row.kind!=CSGroupRowKindSession ||
                [changedUserNames containsObject:row.userName];
        if (changed) [reload addObject:path];
    }
    if (reload.count) [self.table reloadRowsAtIndexPaths:reload withRowAnimation:UITableViewRowAnimationNone];
    // A badge-only event has no table geometry work. Held visibility/layout is
    // always released through the existing verified layout hook.
    if (reload.count || self.sessionLayoutHeld) [self.table layoutIfNeeded];
}
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                  changes:(CSGroupChangeKind)changes changedUserNames:(NSSet<NSString *> *)changedUserNames
      previouslyProjecting:(BOOL)previouslyProjecting {
    BOOL (^equal)(id,id)=^BOOL(id a,id b) { return a==b || [a isEqual:b]; };
    NSString *selected=CSGroupReadObject(projection,@"selectedTabID");
    long long privacyRevision=CSGroupReadInteger(projection,@"privacyRevision",-1);
    BOOL incremental=previouslyProjecting && self.projecting && !self.privacyRefreshPending &&
        !(changes&CSGroupChangeUnknown) && projection.isValid && previous.isValid &&
        [projection.accountID isEqual:previous.accountID] && selected.length &&
        [selected isEqual:CSGroupReadObject(previous,@"selectedTabID")] && privacyRevision>=0 &&
        privacyRevision==CSGroupReadInteger(previous,@"privacyRevision",-1) &&
        projection.sections.count==previous.sections.count;
    // Coordinate ownership is independent of copied text and counters. Stable
    // named session rows can update their content without replacing the table.
    // Anonymous and aggregate rows retain their complete geometry publication.
    for (NSUInteger s=0;incremental && s<projection.sections.count;s++) {
        NSArray *rows=projection.sections[s],*oldRows=previous.sections[s];
        incremental=rows.count==oldRows.count;
        for (NSUInteger r=0;incremental && r<rows.count;r++) {
            CSGroupRow *row=rows[r],*old=oldRows[r];
            incremental=row.userName.length && row.kind!=CSGroupRowKindBusiness && row.kind!=CSGroupRowKindAggregate &&
                (row==old || ([row.nativePath isEqual:old.nativePath] && equal(row.userName,old.userName) &&
                    row.kind==old.kind && row.category==old.category && row.top==old.top &&
                    row.privacyMasked==old.privacyMasked && row.foldedEntryScoped==old.foldedEntryScoped &&
                    row.foldedEntryPrivacyRevision==old.foldedEntryPrivacyRevision && equal(row.foldedEntryAccountID,old.foldedEntryAccountID)));
        }
    }
    CSGroupWithDisplayIndices(self.table, ^{
        BOOL stable=incremental && self.table.numberOfSections==(NSInteger)projection.sections.count;
        for (NSUInteger s=0;stable && s<projection.sections.count;s++)
            stable=[self.table numberOfRowsInSection:(NSInteger)s]==(NSInteger)projection.sections[s].count;
        BOOL reloaded=NO;
        if (!stable) { [self.table reloadData]; reloaded=YES; }
        else {
            NSMutableArray *reload=[NSMutableArray array];
            for (NSIndexPath *path in self.table.indexPathsForVisibleRows ?: @[]) {
                CSGroupRow *row=[projection rowAtDisplayPath:path],*old=[previous rowAtDisplayPath:path];
                if (!row || !old) continue;
                BOOL changed=row!=old && (row.unreadCount!=old.unreadCount || row.redDot!=old.redDot ||
                    !equal(row.nativeSummary,old.nativeSummary) || !equal(row.nativePrefix,old.nativePrefix) ||
                    !equal(row.nativeSortTime,old.nativeSortTime) || !equal(row.foldedEntryCount,old.foldedEntryCount) ||
                    !equal(row.foldedEntrySummary,old.foldedEntrySummary) || !equal(row.foldedEntryPrefix,old.foldedEntryPrefix) ||
                    !equal(row.foldedEntrySummaryUserName,old.foldedEntrySummaryUserName));
                if (changes&(CSGroupChangeContent|CSGroupChangeStructure))
                    changed |= !changedUserNames || [changedUserNames containsObject:row.userName];
                if (changed) [reload addObject:path];
            }
            if (reload.count) { [self.table reloadRowsAtIndexPaths:reload withRowAnimation:UITableViewRowAnimationNone]; reloaded=YES; }
        }
        if (reloaded || self.sessionLayoutHeld) [self.table layoutIfNeeded];
    });
}
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)account {
    if (!account.length) return nil;
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    NSMutableSet *hidden=[NSMutableSet set];
    for (NSString *name in policy.protectedUserNames)
        if ([policy hidesUserName:name surface:CSCloseFriendSurfaceSession]) [hidden addObject:name];
    NSMutableSet *unmasked=[NSMutableSet set];
    BOOL scopeFolded=Option(@"enabled") && !CSGroupIsFoldedController(self.controller) && !self.nativePresentation &&
        (!self.usesNativeSessionModel || ![selected isEqual:@"preset_0"]);
    __block CSGroupProjection *foldedProjection=nil;
    if (scopeFolded) {
        __block CSGroupRow *summaryCandidate=nil;
        NSArray *foldedRows=CSGroupCopyFoldedRowsSelectingSummary(^CSGroupRow *(NSArray<CSGroupRow *> *rows) {
            foldedProjection=[[CSGroupProjection alloc] initWithSections:@[rows] tabs:tabs selectedTabID:selected
                filterDuplicates:self.preferences.filterDuplicates accountID:account hiddenUserNames:hidden
                privacyRevision:policy.revision previousProjection:nil];
            if (!foldedProjection.isValid) {foldedProjection=nil; return nil;}
            CSGroupRow *latest=nil;
            for (NSArray *section in foldedProjection.sections) for (CSGroupRow *row in section) {
                if (row.kind==CSGroupRowKindSession && (!latest || row.nativeSortTime.unsignedLongLongValue>latest.nativeSortTime.unsignedLongLongValue)) latest=row;
            }
            summaryCandidate=latest; return latest;
        });
        if (!foldedRows) foldedProjection=nil;
        else if (summaryCandidate) {
            // The bridge changes only the selected candidate's verified native text.
            // Retain the complete child membership/counts and replace that immutable row.
            NSUInteger index=[summaryCandidate.nativePath indexAtPosition:1];
            foldedProjection=index<foldedRows.count ? [foldedProjection projectionByAttachingNativeSummaryRow:foldedRows[index]] : nil;
        }
    } else if (hidden.count && !CSGroupIsFoldedController(self.controller)) {
        CSGroupFoldedPrivacyState folded=CSGroupAssessFoldedUserNames(CSGroupCopyFoldedUserNames(),hidden);
        if (folded==CSGroupFoldedPrivacyAllHidden) [hidden addObject:@"chatroom_session_box"];
        else if (folded==CSGroupFoldedPrivacyNoHidden) [unmasked addObject:@"chatroom_session_box"];
    }
    // Account transitions and unreadable policy never expose a partially classified list.
    BOOL stale=policy.blocked || ![policy.accountID isEqual:account] || ![account isEqual:CSGroupCurrentAccountID()] || epoch!=CSCloseFriendAccountEpoch() ||
        CSCloseFriendCurrentSnapshot().revision!=policy.revision;
    if (stale) sections=@[];
    CSGroupProjection *projection=sections ? [[CSGroupProjection alloc] initWithSections:sections tabs:tabs selectedTabID:selected
        filterDuplicates:self.preferences.filterDuplicates accountID:account hiddenUserNames:hidden unmaskedAggregateUserNames:unmasked privacyRevision:policy.revision
        scopeFoldedEntry:scopeFolded foldedProjection:foldedProjection previousProjection:self.projection] : nil;
    if (projection.isValid) { self.snapshotRetryAttempted=NO; self.snapshotRetryGeneration++; return projection; }
    // A partially rebuilt native snapshot must not permanently select All.
    // Publish a safe empty projection for the selected group, then retry once.
    // Never expose unfiltered rows under a filtered group's label.
    if (!self.snapshotRetryAttempted) {
        self.snapshotRetryAttempted=YES;
        NSUInteger generation=++self.snapshotRetryGeneration;
        __weak typeof(self) weakSelf=self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            CSGroupListAdapter *self=weakSelf;
            if (self.snapshotRetryAttempted && self.snapshotRetryGeneration==generation && epoch==CSCloseFriendAccountEpoch() && [account isEqual:CSGroupCurrentAccountID()]) [self requestRecovery];
        });
    }
    projection=[[CSGroupProjection alloc] initWithSections:@[] tabs:tabs selectedTabID:selected
        filterDuplicates:self.preferences.filterDuplicates accountID:account];
    return projection.isValid ? projection : nil;
}
- (void)cancelScheduledRefresh {
    self.refreshGeneration++; self.scheduled=NO; self.scheduledCoalesced=NO; self.scheduledInteraction=NO; self.scheduledRecovery=NO;
    self.interactionDeadline=0; self.interactionAttempts=0;
    [self consumeRefreshRequest];
}
- (void)consumeRefreshRequest {
    // Consume before publication, so synchronous callbacks create the next request.
    self.refreshGeneration++; self.scheduled=NO; self.scheduledCoalesced=NO;
    self.scheduledInteraction=NO; self.scheduledRecovery=NO;
    self.coalescingNotification=NO; self.immediateRefreshPending=NO;
    self.refreshBurstStart=0; self.refreshCoalescedDue=0; self.scheduledRefreshDue=0;
}
- (void)requestRecovery {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self requestRecovery]; }); return; }
    self.dirty=YES; self.recoveryPending=YES; @synchronized (self) { self.pendingChanges|=CSGroupChangeUnknown; }
    // Do not invent a model revision for a failed rendering attempt. All failures
    // of the same account/revision share one finite retry budget.
    self.cachedNativeSections=nil;
    self.immediateRefreshPending=YES;
    [self scheduleRefresh];
}
- (void)requestRefresh {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self requestRefresh]; }); return; }
    if (self.publishing && !self.changeDepth && !self.nativeActions.count) { [self requestRecovery]; return; }
    self.dirty=YES;
    self.immediateRefreshPending=YES;
    if (!self.changeDepth) { self.recoveryPending=NO; @synchronized (self) { self.pendingChanges|=CSGroupChangeUnknown; } [self invalidateNativeSnapshot]; }
    [self scheduleRefresh];
}
- (BOOL)refreshInteractionIsBlocking {
    // The scheduler must wait for every interaction that makes native
    // publication defer. In particular, tracking ends before deceleration;
    // treating that phase as ready repeatedly enqueues an immediate refresh.
    return self.table.tracking || self.table.dragging || self.table.decelerating ||
        self.table.editing || self.swipeActive || [self groupPanMoving] || [self nativeMenuState];
}
- (void)scheduleRefresh {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self scheduleRefresh]; }); return; }
    [self pruneNativeActions];
    if (!self.dirty && !self.nativeActions.count) return;
    if ((!CSGroupApplicationActive() && !(self.privacyRefreshPending && CSGroupPrivacyActive())) || (self.presentationSuspended && !self.nativeActions.count)) { [self finishSuspendedBatches]; return; }
    if (self.changeDepth || self.publishing) return;
    BOOL coalesced=!self.privacyRefreshPending && !self.immediateRefreshPending && self.coalescingNotification && !self.nativeActions.count;
    BOOL waiting=!self.privacyRefreshPending && !self.presentationSuspended && [self refreshInteractionIsBlocking];
    BOOL releasedWait=self.scheduledInteraction && !waiting;
    BOOL freshEvent=self.scheduledRecovery && !self.recoveryPending;
    if (self.scheduled && !releasedWait && !freshEvent &&
        ((!self.scheduledCoalesced && !self.scheduledInteraction && !self.scheduledRecovery) ||
         (self.scheduledInteraction && waiting) ||
         (self.scheduledRecovery && self.recoveryPending && !self.privacyRefreshPending && !self.nativeActions.count))) return;
    NSTimeInterval now=NSProcessInfo.processInfo.systemUptime;
    NSTimeInterval delay=coalesced ? MAX(0,self.refreshCoalescedDue-now) : 0;
    if (waiting) {
        if (!self.interactionDeadline) self.interactionDeadline=now+2.0;
        if (now>=self.interactionDeadline) return; // Keep dirty; actual end/lifecycle events wake it.
        delay=MIN(self.interactionDeadline-now,MIN(0.4,0.05*(1UL<<MIN(self.interactionAttempts++,3UL))));
    } else { self.interactionDeadline=0; self.interactionAttempts=0; }
    if (self.recoveryPending && !waiting && !self.privacyRefreshPending && !self.nativeActions.count) {
        NSString *account=CSGroupCurrentAccountID();
        BOOL sameAccount=self.recoveryAccount==account || [self.recoveryAccount isEqual:account];
        if (self.recoveryRevision!=self.modelRevision || !sameAccount) {
            self.recoveryRevision=self.modelRevision; self.recoveryAccount=account; self.recoveryAttempts=0;
        }
        if (self.recoveryAttempts>=3) return;
        static const NSTimeInterval delays[]={0.1,0.25,0.5};
        delay=MAX(delay,delays[self.recoveryAttempts++]);
    }
    NSTimeInterval due=now+delay;
    if (self.scheduled && !releasedWait && !freshEvent) {
        // Keep urgent work urgent. A burst may move its deadline later, bounded
        // by refreshBurstStart + 250ms; no event disappears during publication.
        BOOL sameDeadline=fabs(self.scheduledRefreshDue-due)<0.001;
        if ((!self.scheduledCoalesced && !self.scheduledInteraction && !self.scheduledRecovery) ||
            (self.scheduledCoalesced==coalesced && sameDeadline)) return;
    }
    self.scheduledRefreshDue=due;
    self.scheduled=YES; self.scheduledCoalesced=coalesced; self.scheduledInteraction=waiting; self.scheduledRecovery=self.recoveryPending && !waiting;
    NSUInteger generation=++self.refreshGeneration;
    __weak typeof(self) weakSelf=self;
    void (^publish)(void)=^{
        CSGroupListAdapter *self=weakSelf;
        if (!self || generation!=self.refreshGeneration) return;
        self.scheduled=NO;
        if (self.dirty || self.nativeActions.count) [self refresh];
        else [self consumeRefreshRequest];
    };
    if (delay>0) dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay*NSEC_PER_SEC)),dispatch_get_main_queue(),publish);
    else dispatch_async(dispatch_get_main_queue(),publish);
}
- (void)requestCoalescedRefresh {
    if (!NSThread.isMainThread) {
        @synchronized (self) { if (self.coalescedDispatchPending) return; self.coalescedDispatchPending=YES; }
        dispatch_async(dispatch_get_main_queue(), ^{
            @synchronized (self) { self.coalescedDispatchPending=NO; }
            [self requestCoalescedRefresh];
        });
        return;
    }
    self.dirty=YES;
    NSTimeInterval now=NSProcessInfo.processInfo.systemUptime;
    if (!self.coalescingNotification) self.refreshBurstStart=now;
    self.coalescingNotification=YES;
    self.refreshCoalescedDue=MIN(now+0.08,self.refreshBurstStart+0.25);
    [self scheduleRefresh];
}

- (void)beginNativeChange { [self beginNativeChangeOfKind:CSGroupChangeStructure|CSGroupChangeContent]; }
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind {
    [self beginNativeChangeOfKind:kind changedUserNames:nil];
}
- (void)mergePendingChangeOfKind:(CSGroupChangeKind)kind changedUserNames:(NSSet<NSString *> *)names {
    BOOL known=[names isKindOfClass:NSSet.class];
    if (known) for (id name in names) if (![name isKindOfClass:NSString.class] || ![name length]) { known=NO;break; }
    @synchronized (self) {
        self.pendingChanges|=kind;
        if (!known || (kind&CSGroupChangeUnknown)) self.pendingChangeNamesUnknown=YES;
        else if (!self.pendingChangeNamesUnknown) {
            if (!self.pendingChangedUserNames) self.pendingChangedUserNames=[NSMutableSet set];
            [self.pendingChangedUserNames unionSet:names];
        }
    }
}
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind changedUserNames:(NSSet<NSString *> *)names {
    [self invalidateNativeSnapshot];
    [self mergePendingChangeOfKind:kind changedUserNames:names];
    BOOL captureAnchor=NO;
    @synchronized (self) {
        self.recoveryPending=NO;
        captureAnchor=!self.changeDepth && NSThread.isMainThread && !self.presentationSuspended && !(self.dirty && self.scheduledCoalesced);
        self.changeDepth++;
    }
    // Native/UI reads must not hold the lock used by background notifications.
    if (captureAnchor) [self saveAnchor];
}
- (void)endNativeChange { [self endNativeChangeCoalesced:NO]; }
- (void)endNativeChangeCoalesced:(BOOL)coalesced {
    BOOL outer=NO;
    @synchronized (self) { if (self.changeDepth) { self.changeDepth--; outer=self.changeDepth==0; } }
    if (outer) {
        self.dirty=YES;
        [self requestTabBadgeSourceRefreshCoalesced:coalesced];
        if (coalesced) [self requestCoalescedRefresh];
        else { self.immediateRefreshPending=YES; [self scheduleRefresh]; }
    }
}
- (void)performNativeBatch:(void (^)(void))updates completion:(void (^)(BOOL))completion {
    void (^callback)(BOOL)=[completion copy];
    [self beginNativeChange]; if (callback) [self.completions addObject:callback];
    @try { CSGroupWithNativeIndices(self.table, ^{ if (updates) updates(); }); }
    @catch (NSException *exception) {
        if (callback) { [self.completions removeObjectIdenticalTo:callback]; callback(NO); }
        @throw exception;
    }
    @finally { [self endNativeChange]; }
}
- (void)useNativePresentation {
    if (!self.isActive || self.swipeActive || self.table.editing || [self nativeMenuState]) return;
    [self clearPendingViewport];
    [self saveAnchor]; self.nativePresentation=YES; [self.table setEditing:NO animated:NO]; [self refresh];
}
- (void)performInNativePresentation:(void (^)(void))action {
    NSString *account=CSGroupCurrentAccountID(); if (!account.length) return;
    [self clearPendingViewport];
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL privacy=policy.blocked || ![policy.accountID isEqual:account] ||
        ![policy.options[@"hideSessions"] isKindOfClass:NSNumber.class] ||
        (policy.enabled && !policy.revealed && [policy.options[@"hideSessions"] boolValue]);
    void (^guarded)(void)=^{ if (epoch==CSCloseFriendAccountEpoch() && CSGroupApplicationActive() && [account isEqualToString:CSGroupCurrentAccountID()]) action(); };
    if (CSGroupApplicationActive() && !self.isActive && !privacy && !self.publishing && !self.changeDepth) { CSGroupWithNativeIndices(self.table,guarded); return; }
    [self pruneNativeActions];
    self.nativeActionsAccount=account;
    [self.nativeActions addObject:[guarded copy]];
    if (!CSGroupApplicationActive()) { self.nativePresentation=YES; self.dirty=YES; return; }
    if (self.publishing) {
        self.nativePresentation=YES; [self requestRefresh]; return;
    }
    if (self.presentationSuspended || (privacy && !self.isActive)) {
        // Search/next-chat navigation can target the main list from another page.
        // Publish native coordinates once for that action, then remain suspended.
        self.nativePresentation=YES; [self refresh]; return;
    }
    if (self.swipeActive || self.table.editing || [self nativeMenuState]) {
        // Native navigation waits for the menu to close; do not discard its queued action.
        self.nativePresentation=YES; [self requestRefresh]; return;
    }
    [self useNativePresentation];
}
- (BOOL)navigatePrivateSessionsForward:(BOOL)forward unreadOnly:(BOOL)unreadOnly {
    if (!CSGroupPrivacyActive()) return NO;
    if (!NSThread.isMainThread || !CSGroupApplicationActive() || self.changeDepth || self.publishing) return YES;
    [self clearPendingViewport];
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    NSString *account=CSGroupCurrentAccountID();
    __block NSIndexPath *oldSelected=nil;
    CSGroupWithDisplayIndices(self.table, ^{ oldSelected=self.table.indexPathForSelectedRow; });
    NSString *selectedName=[self.projection rowAtDisplayPath:oldSelected].userName;
    self.nativePresentation=YES;
    // Build All without disabling privacy; next/previous must not escape via native services.
    [self refresh];
    if (!self.isActive || ![self.projection.accountID isEqual:account]) return YES;
    CSGroupRow *selectedRow=nil;
    NSMutableArray<CSGroupRow *> *rows=[NSMutableArray array];
    for (NSArray *section in self.projection.sections) for (CSGroupRow *row in section)
        if (row.userName.length && row.kind!=CSGroupRowKindAggregate && row.kind!=CSGroupRowKindBusiness) {
            [rows addObject:row]; if ([row.userName isEqual:selectedName]) selectedRow=row;
        }
    if (!rows.count) return YES;
    NSUInteger current=selectedRow ? [rows indexOfObject:selectedRow] : NSNotFound;
    for (NSUInteger step=1;step<=rows.count;step++) {
        NSUInteger index=current==NSNotFound ? (forward ? step-1 : rows.count-step) :
            (forward ? (current+step)%rows.count : (current+rows.count-step)%rows.count);
        CSGroupRow *row=rows[index];
        if (unreadOnly && !row.unreadCount && !row.redDot) continue;
        NSIndexPath *path=[self currentPathForRow:row];
        if (!path || CSCloseFriendShouldHideUserName(row.userName,CSCloseFriendSurfaceSession)) continue;
        SEL selector=NSSelectorFromString(@"handleSelectIndexPath:tableView:");
        Method method=class_getInstanceMethod(object_getClass(self.controller),selector);
        if (epoch!=CSCloseFriendAccountEpoch() || ![account isEqual:CSGroupCurrentAccountID()] ||
            !CSCloseFriendMethodMatches(method,"v@:@@")) return YES;
        CSGroupWithNativeIndices(self.table, ^{ ((void(*)(id,SEL,id,id))objc_msgSend)(self.controller,selector,path,self.table); });
        return YES;
    }
    return YES;
}
- (BOOL)accountMatches { return [self.projection.accountID isEqualToString:CSGroupCurrentAccountID()]; }
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row {
    if (!row || ![self accountMatches] || CSCloseFriendShouldHideUserName(row.userName,CSCloseFriendSurfaceSession)) return nil;
    NSString *account=self.projection.accountID;
    NSUInteger epoch=CSCloseFriendAccountEpoch(),revision=self.modelRevision;
    NSArray *version=CSGroupIsFoldedController(self.controller) ? @[account,@(epoch),@(revision)] : @[];
    __block NSIndexPath *path=nil;
    CSGroupWithNativeIndices(self.table, ^{ path=CSGroupResolveNativeRowPathReusing(self.controller,row,self.dirty,version); });
    return epoch==CSCloseFriendAccountEpoch() && revision==self.modelRevision && [account isEqual:CSGroupCurrentAccountID()] &&
        !CSCloseFriendShouldHideUserName(row.userName,CSCloseFriendSurfaceSession) ? path : nil;
}
- (NSIndexPath *)nativePath:(NSIndexPath *)displayPath {
    if (!displayPath) return nil;
    NSIndexPath *path=[self currentPathForRow:[self.projection rowAtDisplayPath:displayPath]];
    if (self.usesNativeSessionModel) return [path isEqual:displayPath] ? displayPath : nil;
    if (!path) [self requestRecovery]; return path;
}
- (NSIndexPath *)displayPath:(NSIndexPath *)nativePath {
    if (![nativePath isKindOfClass:NSIndexPath.class] || nativePath.length!=2 || ![self accountMatches]) return nil;
    if (self.usesNativeSessionModel) return [self nativePath:nativePath];
    NSString *name=CSGroupNativeUserNameAtPath(self.controller,nativePath);
    if (CSCloseFriendShouldHideUserName(name,CSCloseFriendSurfaceSession)) return nil;
    if (name.length) {
        // The snapshot stores original positions; resolve current native positions by identity.
        id path=self.identityDisplayPaths[name]; return [path isKindOfClass:NSIndexPath.class] ? path : nil;
    }
    NSIndexPath *display=[self.projection displayPathForNativePath:nativePath];
    CSGroupRow *row=[self.projection rowAtDisplayPath:display];
    // A deferred refresh alone does not invalidate a banner. Revalidate in both
    // directions so native rect/cell queries keep addressing the displayed row.
    return [[self currentPathForRow:row] isEqual:nativePath] ? display : nil;
}
- (NSArray *)nativePaths:(NSArray *)displayPaths {
    NSMutableArray *out=[NSMutableArray array];
    for (NSIndexPath *path in displayPaths) { NSIndexPath *native=[self nativePath:path]; if (native) [out addObject:native]; }
    return [out copy];
}
- (NSInteger)nativeRowCount:(NSInteger)section {
    id source=[self nativeSource];
    return [source respondsToSelector:@selector(tableView:numberOfRowsInSection:)] ? [source tableView:self.table numberOfRowsInSection:section] : 0;
}
- (NSInteger)nativeSectionCount {
    id source=[self nativeSource]; return [source respondsToSelector:@selector(numberOfSectionsInTableView:)] ? [source numberOfSectionsInTableView:self.table] : 1;
}
- (NSDictionary *)captureNativeEditingContextAtPath:(NSIndexPath *)path {
    if (!self.table || !self.isActive || ![self accountMatches]) return nil;
    CSGroupRow *row=[self.projection rowAtDisplayPath:[self displayPath:path]];
    if (!row.userName.length) return nil;
    return @{@"row":row,@"account":self.projection.accountID,@"epoch":@(CSCloseFriendAccountEpoch())};
}
- (BOOL)performNativeEditingContext:(NSDictionary *)context action:(void (^)(NSIndexPath *))action {
    if (!self.table || !NSThread.isMainThread || [context[@"epoch"] unsignedIntegerValue]!=CSCloseFriendAccountEpoch() || ![context[@"account"] isEqual:CSGroupCurrentAccountID()]) return NO;
    CSGroupRow *row=context[@"row"];
    if (![row isKindOfClass:CSGroupRow.class] || !row.userName.length || CSCloseFriendShouldHideUserName(row.userName,CSCloseFriendSurfaceSession)) return NO;
    __block NSIndexPath *current=nil;
    CSGroupWithNativeIndices(self.table, ^{ current=CSGroupResolveNativeRowPath(self.controller,row,YES); });
    if (!current) { [self requestRefresh]; return NO; }
    // Private edit actions can arrive without the projected willBegin callback.
    // Retain the identity while UIKit still reports editing so a later native
    // deletion can release that state even if didEnd is never delivered.
    if (self.table.editing && !self.swipeRow) {
        self.swipeActive=YES; self.swipeRow=row; self.swipeAccount=context[@"account"];
        self.swipeDisplayPath=[self displayPath:current];
    }
    [self beginNativeChange];
    @try { CSGroupWithNativeIndices(self.table, ^{ action(current); }); }
    @finally { [self endNativeChange]; }
    return YES;
}
- (void)updateGroupGestureAvailability {
    // Editing/open menus do not transfer left-zone touches to the native menu.
    BOOL enabled=self.chromeVisible && !self.searching && Option(@"swipe_gesture_enabled");
    if (self.pan.enabled!=enabled) self.pan.enabled=enabled;
    if (self.listPan.enabled!=enabled) self.listPan.enabled=enabled;
}
- (void)endSwipeEditing {
    self.swipeActive=NO; self.swipeRow=nil; self.swipeAccount=nil; self.swipeDisplayPath=nil;
    // Closing a clean menu must restore group gestures without rebuilding cells.
    [self updateGroupGestureAvailability];
    [self restorePendingViewport];
    if (self.dirty) [self scheduleRefresh];
}
- (void)reconcileDeletedSwipeRow {
    // A projected deletion suppresses UIKit's row removal. The native menu may
    // therefore never emit didEndEditing. Release it only after identity loss,
    // not merely because another message arrived while the menu was open.
    if (!self.swipeActive || !self.swipeRow || self.changeDepth) return;
    if ([self.swipeAccount isEqual:CSGroupCurrentAccountID()] && [self currentPathForRow:self.swipeRow]) return;
    [self endSwipeEditing];
    [self.table setEditing:NO animated:NO];
}
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target {
    NSString *name=NSStringFromSelector(inv.selector);
    BOOL begin=[name isEqual:@"tableView:willBeginEditingRowAtIndexPath:"];
    BOOL end=[name isEqual:@"tableView:didEndEditingRowAtIndexPath:"];
    BOOL commit=[name isEqual:@"tableView:commitEditingStyle:forRowAtIndexPath:"];
    if ((!begin && !end && !commit) || (!self.isActive && !self.swipeRow)) return NO;
    if (CSGroupUsesNativeIndices(self.table)) {
        if (!end) return NO;
        @try { [inv invokeWithTarget:target]; }
        @finally { [self endSwipeEditing]; }
        return YES;
    }
    NSUInteger slot=commit ? 4 : 3;
    __unsafe_unretained NSIndexPath *display=nil; [inv getArgument:&display atIndex:slot];
    CSGroupRow *row=self.swipeRow;
    BOOL sameAccount=!row || [self.swipeAccount isEqual:CSGroupCurrentAccountID()];
    if (begin || !row) row=[self.projection rowAtDisplayPath:display];
    NSIndexPath *native=sameAccount && row.userName.length ? [self currentPathForRow:row] : nil;
    // A commit must belong to the row whose swipe UI is open, even if native rows moved.
    if (commit && self.swipeRow && ![display isEqual:self.swipeDisplayPath]) native=nil;
    if (begin && native) {
        self.swipeActive=YES; self.swipeRow=row;
        self.swipeAccount=self.projection.accountID; self.swipeDisplayPath=display;
    }
    @try {
        if (native || (end && sameAccount)) {
            [inv setArgument:&native atIndex:slot]; [inv retainArguments];
            if (commit) [self beginNativeChange];
            @try { CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; }); }
            @finally { if (commit) [self endNativeChange]; }
        }
    } @finally {
        if (end) {
            [self endSwipeEditing];
        }
    }
    return YES;
}
- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target {
    BOOL projected=self.isActive && !CSGroupUsesNativeIndices(self.table);
    CSGroupRow *row=projected ? [self.projection rowAtDisplayPath:path] : nil;
    NSIndexPath *native=projected ? [self currentPathForRow:row] : path;
    __block UITableViewCell *cell=nil;
    if (native && [target respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)])
        CSGroupWithNativeIndices(self.table, ^{ cell=[target tableView:self.table cellForRowAtIndexPath:native]; });
    if (!cell) {
        // Required data-source callbacks must return a cell even while an old identity disappears.
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=@"正在更新会话…"; cell.userInteractionEnabled=NO; cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self requestRecovery];
    }
    id delivery=row ? @{@"row":row,@"account":self.projection.accountID} : nil;
    objc_setAssociatedObject(cell,&CellRowKey,delivery,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSCloseFriendUpdateSessionCover(cell,row);
    return cell;
}
- (void)forwardInvocation:(NSInvocation *)inv target:(id)target {
    NSUInteger length=inv.methodSignature.methodReturnLength;
    if (length) { void *zero=calloc(1,length); [inv setReturnValue:zero]; free(zero); }
    if (!target) return;
    NSString *name=NSStringFromSelector(inv.selector);
    if ([name isEqual:@"scrollViewWillBeginDragging:"]) [self beginUserDragging];
    else if ([name isEqual:@"scrollViewDidScrollToTop:"]) [self beginUserScrolling];
    BOOL viewportEvent=[name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] ||
        [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"] || [name isEqual:@"scrollViewDidEndScrollingAnimation:"] ||
        [name isEqual:@"scrollViewDidChangeAdjustedContentInset:"];
    if ([name isEqual:@"scrollViewDidEndDragging:willDecelerate:"]) {
        BOOL decelerates=NO; [inv getArgument:&decelerates atIndex:3];
        if (decelerates) viewportEvent=NO;
    }
    if ([self forwardSwipeInvocation:inv target:target]) return;
    BOOL cellLifecycle=[name isEqual:@"tableView:willDisplayCell:forRowAtIndexPath:"] || [name isEqual:@"tableView:didEndDisplayingCell:forRowAtIndexPath:"];
    CSGroupRow *cellRow=nil;
    __unsafe_unretained UITableViewCell *cell=nil;
    if (cellLifecycle) {
        [inv getArgument:&cell atIndex:3];
        NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);
        if (delivery) {
            if (![delivery[@"account"] isEqual:CSGroupCurrentAccountID()]) return;
            cellRow=delivery[@"row"];
            if (!self.isActive || CSGroupUsesNativeIndices(self.table)) {
                if (!CSGroupMapInvocationPaths(inv, ^NSIndexPath *(NSIndexPath *path) { (void)path; return [self currentPathForRow:cellRow]; })) return;
                CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; }); CSCloseFriendRefreshSessionCover(cell); return;
            }
        } else if (self.publishing && [name isEqual:@"tableView:didEndDisplayingCell:forRowAtIndexPath:"]) {
            // Cells delivered before activation were native and never carried projected coordinates.
            CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; }); CSCloseFriendRefreshSessionCover(cell); return;
        }
    }
    BOOL prefetch=[name isEqual:@"tableView:prefetchRowsAtIndexPaths:"];
    BOOL cancelPrefetch=[name isEqual:@"tableView:cancelPrefetchingForRowsAtIndexPaths:"];
    if (prefetch || cancelPrefetch) {
        // Native prefetch cancellation captures positions. It stays disabled in projected lists.
        if (self.isActive) return;
        __unsafe_unretained NSArray *paths=nil; [inv getArgument:&paths atIndex:3];
        if (prefetch) [self.prefetchedPaths addObjectsFromArray:paths]; else [self.prefetchedPaths minusSet:[NSSet setWithArray:paths]];
    }
    if (!self.isActive || CSGroupUsesNativeIndices(self.table)) {
        CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; });
        if (cellLifecycle) CSCloseFriendRefreshSessionCover(cell);
        if ([name isEqual:@"scrollViewShouldScrollToTop:"]) {
            BOOL accepted=NO; [inv getReturnValue:&accepted];
            if (accepted) [self beginUserScrolling];
        }
        if (self.dirty && ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"])) [self scheduleRefresh];
        if (viewportEvent) [self restorePendingViewport];
        return;
    }
    if ([name isEqual:@"numberOfSectionsInTableView:"]) { NSInteger count=(NSInteger)self.projection.sections.count; [inv setReturnValue:&count]; return; }
    if ([name isEqual:@"tableView:numberOfRowsInSection:"]) {
        NSInteger section=0; [inv getArgument:&section atIndex:3];
        NSInteger count=section>=0 && section<(NSInteger)self.projection.sections.count ? (NSInteger)self.projection.sections[(NSUInteger)section].count : 0;
        [inv setReturnValue:&count]; return;
    }
    // Optional queries and unsupported coordinate/block callbacks do not express
    // a request to select All. Keep the initialized neutral return and selection.
    if (!CSGroupInvocationIsSupported(inv.selector) || [@[@"tableView:shouldShowMenuForRowAtIndexPath:",@"tableView:moveRowAtIndexPath:toIndexPath:",@"tableView:performAction:forRowAtIndexPath:withSender:"] containsObject:name]) return;
    __block CSGroupRow *deliveredRow=nil;
    BOOL mapped=CSGroupMapInvocationPaths(inv, ^NSIndexPath *(NSIndexPath *path) {
        deliveredRow=cellRow ?: [self.projection rowAtDisplayPath:path];
        BOOL action=[name containsString:@"didSelectRow"] || [name containsString:@"commitEditingStyle"] || [name containsString:@"moveRowAt"] || [name containsString:@"performAction:"];
        if (action && !deliveredRow.userName.length) return nil;
        return [self currentPathForRow:deliveredRow];
    });
    if (!mapped) {
        if ([name isEqual:@"tableView:heightForRowAtIndexPath:"] || [name isEqual:@"tableView:estimatedHeightForRowAtIndexPath:"]) {
            CGFloat height=44; [inv setReturnValue:&height]; [self requestRecovery];
        } else if (!cellLifecycle) [self requestRecovery];
        return;
    }
    CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; });
    if (cellLifecycle) CSCloseFriendRefreshSessionCover(cell);
    if ([name isEqual:@"scrollViewShouldScrollToTop:"]) {
        BOOL accepted=NO; [inv getReturnValue:&accepted];
        if (accepted) [self beginUserScrolling];
    }
    if (CSGroupInvocationReturnsPath(inv.selector)) {
        __unsafe_unretained NSIndexPath *native=nil; [inv getReturnValue:&native];
        NSIndexPath *display=[self displayPath:native]; [inv setReturnValue:&display]; [inv retainArguments];
    }
    if ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"]) {
        if (self.dirty) [self scheduleRefresh];
    }
    if (viewportEvent) [self restorePendingViewport];
}
- (BOOL)hasScrollableContent {
    UITableView *table=self.table;
    CGFloat viewport=CGRectGetHeight(table.bounds);
    CGFloat content=table.contentSize.height;
    UIEdgeInsets inset=table.adjustedContentInset;
    return viewport>0 && isfinite(viewport) && isfinite(content) &&
        isfinite(inset.top) && isfinite(inset.bottom) && content+inset.top+inset.bottom>viewport+0.5;
}
- (BOOL)canRestoreAnchor {
    UITableView *table=self.table;
    // Do not turn a pull-down/bounce or a native top-area transition into a
    // persistent row anchor. The host owns these positions, including short lists.
    return [self hasScrollableContent] && !self.searching && !table.tracking &&
        !table.dragging && !table.decelerating && isfinite(table.contentOffset.y) &&
        table.contentOffset.y>=-table.adjustedContentInset.top-0.5;
}
- (NSDictionary *)captureViewportForTabID:(NSString *)tabID {
    if (self.initialViewportPending) return nil;
    NSUInteger generation=self.viewportGeneration;
    UITableView *table=self.table;
    CGFloat height=table.contentOffset.y+table.adjustedContentInset.top;
    CGFloat viewport=CGRectGetHeight(table.bounds), content=table.contentSize.height;
    UIEdgeInsets inset=table.adjustedContentInset;
    if (!tabID.length || self.presentationSuspended || !CSGroupApplicationActive() || !self.isActive ||
        !self.chromeVisible || self.searching || self.nativePresentation || self.nativeActions.count ||
        table.dragging || table.decelerating || table.editing || self.swipeActive || [self groupPanMoving] || [self nativeMenuState] ||
        !isfinite(height) || !isfinite(viewport) || !isfinite(content) || !isfinite(inset.top) || !isfinite(inset.bottom) ||
        viewport<=0 || content<0 || height< -0.5 || height>MAX(0,content-viewport+inset.top+inset.bottom)+0.5) return nil;
    NSString *account=self.preferences.accountID;
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if (!account.length || !self.projection.isValid || self.snapshotRetryAttempted || policy.blocked ||
        ![policy.options[@"hideSessions"] isKindOfClass:NSNumber.class] || ![policy.accountID isEqual:account] ||
        ![self.projection.accountID isEqual:account] || self.snapshotEpoch!=epoch ||
        CSGroupReadInteger(self.projection,@"privacyRevision",-1)!=(long long)policy.revision ||
        ![account isEqual:CSGroupCurrentAccountID()] || epoch!=CSCloseFriendAccountEpoch()) return nil;
    // A horizontal group gesture can end while UIKit still reports tracking.
    // Capturing that stationary height is safe; restoration waits for tracking
    // to finish, and a real vertical drag cancels the request at its callback.
    if (content==0) for (NSArray *rows in self.projection.sections) if (rows.count) return nil;
    if (generation!=self.viewportGeneration) return nil;
    return @{@"height":@(MAX(0,height)),@"account":account,@"epoch":@(epoch),@"tab":tabID,
        @"generation":@(generation)};
}
- (BOOL)validViewport:(NSDictionary *)viewport {
    NSNumber *height=viewport[@"height"];
    return [height isKindOfClass:NSNumber.class] && isfinite(height.doubleValue) && height.doubleValue>=0 &&
        [viewport[@"generation"] isKindOfClass:NSNumber.class] &&
        [viewport[@"generation"] unsignedIntegerValue]==self.viewportGeneration &&
        [viewport[@"account"] isEqual:CSGroupCurrentAccountID()] &&
        [self.preferences.accountID isEqual:viewport[@"account"]] &&
        [viewport[@"epoch"] unsignedIntegerValue]==CSCloseFriendAccountEpoch();
}
- (void)clearPendingViewport {
    [self cancelInitialViewport];
    self.presentationViewport=nil; self.switchViewport=nil; self.presentationReturnFinished=NO;
}
- (void)prepareInitialViewport {
    NSString *account=CSGroupCurrentAccountID();
    if (!account.length) { self.initialViewportKey=nil; self.initialViewportPending=NO; return; }
    NSArray *key=@[account,@(CSCloseFriendAccountEpoch())];
    if ([self.initialViewportKey isEqual:key]) return;
    self.initialViewportKey=key;
    self.initialViewportGeneration=self.viewportGeneration;
    BOOL previousPublication=self.preferences.accountID.length &&
        (![self.preferences.accountID isEqual:account] || self.snapshotEpoch!=CSCloseFriendAccountEpoch());
    self.initialViewportPending=Option(@"enabled") && !CSGroupIsFoldedController(self.controller) &&
        !self.presentationSuspended && !CSGroupReadInteger(self.controller,@"isSearching",0) &&
        (previousPublication || (!self.nativePresentation && !self.nativeActions.count &&
            !self.presentationViewport && !self.switchViewport && !self.searching));
}
- (void)cancelInitialViewport {
    self.initialViewportPending=NO;
    // A user command before the first valid publication also consumes this
    // account's startup request; a later refresh must not arm it again.
    NSString *account=CSGroupCurrentAccountID();
    if (account.length) self.initialViewportKey=@[account,@(CSCloseFriendAccountEpoch())];
}
- (void)restoreInitialViewport {
    if (!self.initialViewportPending) return;
    NSArray *key=@[CSGroupCurrentAccountID() ?: @"",@(CSCloseFriendAccountEpoch())];
    // Expire the old account without consuming the next account's startup.
    // Its layout can arrive before the first publication for that account.
    if (![self.initialViewportKey isEqual:key]) { self.initialViewportPending=NO; return; }
    if (self.initialViewportGeneration!=self.viewportGeneration || !Option(@"enabled") || self.presentationSuspended) {
        [self cancelInitialViewport]; return;
    }
    // Until the new account publishes, its predecessor's search/native state
    // must neither move the list nor consume the new startup request.
    if (![self.preferences.accountID isEqual:key.firstObject] || self.snapshotEpoch!=CSCloseFriendAccountEpoch()) return;
    if (self.searching || self.nativePresentation || self.nativeActions.count) { [self cancelInitialViewport]; return; }
    UITableView *table=self.table;
    if (!table.window || !self.chromeVisible || self.chrome.hidden || !self.headerContainer ||
        self.chrome.superview!=self.headerContainer || ![self.headerContainer isDescendantOfView:table]) return;
    CGRect chromeRect=[self.chrome convertRect:self.chrome.bounds toView:table];
    CGFloat height=CGRectGetMinY(chromeRect);
    CGFloat visibleTop=table.contentOffset.y+table.adjustedContentInset.top;
    if (!isfinite(height) || height<0 || !isfinite(visibleTop) ||
        !isfinite(CGRectGetWidth(chromeRect)) || !isfinite(CGRectGetHeight(chromeRect)) ||
        CGRectGetWidth(chromeRect)<=0 || CGRectGetHeight(chromeRect)<=0 || visibleTop<=height+0.5) return;
    // Keep this request for the first presentation, until the user takes over.
    // WeChat can reset its top area after didAppear; a temporarily visible
    // first frame is not proof that the native startup positioning has ended.
    // The shared restore validates policy/model/interaction and reentrant reads.
    [self restoreScrollHeight:height];
}
- (void)beginUserScrolling {
    // A real drag is a newer positioning command. Waiting for that drag to end
    // must not resurrect a height or row saved before the user took control.
    self.viewportGeneration++;
    [self clearPendingViewport];
    [self.anchors removeAllObjects];
}
- (void)tablePan:(UIPanGestureRecognizer *)pan {
    if (pan==self.table.panGestureRecognizer && pan.state==UIGestureRecognizerStateBegan) [self beginUserDragging];
}
- (void)beginUserDragging {
    if ([self groupPanMoving]) return;
    UIPanGestureRecognizer *pan=self.table.panGestureRecognizer;
    CGPoint velocity=[pan velocityInView:self.table];
    if ([self groupSwipesAvailable] && self.listTouchAllowed && fabs(velocity.x)>fabs(velocity.y)*1.5) return;
    [self beginUserScrolling];
}
- (BOOL)restoreScrollHeight:(CGFloat)height {
    NSUInteger generation=self.viewportGeneration;
    UITableView *table=self.table;
    if (self.restoringViewport || self.presentationSuspended || !CSGroupApplicationActive() || self.publishing || self.dirty ||
        self.changeDepth || self.privacyRefreshPending || self.sessionLayoutHeld || self.snapshotRetryAttempted ||
        !self.isActive || !self.chromeVisible || !self.publishedTabID.length || self.searching || self.nativePresentation || self.nativeActions.count ||
        table.tracking || table.dragging || table.decelerating || table.editing || self.swipeActive || [self groupPanMoving] || [self nativeMenuState]) return NO;
    NSString *account=CSGroupCurrentAccountID(), *tabID=self.publishedTabID;
    NSUInteger epoch=CSCloseFriendAccountEpoch(), revision=self.modelRevision;
    CSGroupProjection *projection=self.projection;
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if (!account.length || !projection.isValid || policy.blocked || ![policy.options[@"hideSessions"] isKindOfClass:NSNumber.class] ||
        ![account isEqual:self.preferences.accountID] || ![projection.accountID isEqual:account] || ![policy.accountID isEqual:account] ||
        self.snapshotEpoch!=epoch || CSGroupReadInteger(projection,@"privacyRevision",-1)!=(long long)policy.revision) return NO;
    if (self.usesNativeSessionModel) {
        CSGroupNativeSessionCoordinator *coordinator=CSGroupNativeSessionCoordinator.sharedCoordinator;
        if (coordinator.boundary || self.nativeModelRevision!=coordinator.revision || coordinator.epoch!=epoch ||
            ![coordinator.accountID isEqual:account]) return NO;
    }
    UIEdgeInsets inset=table.adjustedContentInset;
    CGFloat viewport=CGRectGetHeight(table.bounds),content=table.contentSize.height,offset=table.contentOffset.y;
    if (!isfinite(height) || height<0 || !isfinite(inset.top) || !isfinite(inset.bottom) ||
        !isfinite(viewport) || !isfinite(content) || !isfinite(offset) || viewport<=0 || content<0) return NO;
    if (content==0) for (NSArray *rows in projection.sections) if (rows.count) return NO;
    CGFloat minimum=-inset.top, maximum=MAX(minimum,content-viewport+inset.bottom);
    CGFloat target=MIN(maximum,MAX(minimum,height-inset.top));
    CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
    if (!isfinite(target) || current.blocked || current.revision!=policy.revision || ![current.accountID isEqual:account] ||
        ![account isEqual:CSGroupCurrentAccountID()] || epoch!=CSCloseFriendAccountEpoch() || self.modelRevision!=revision ||
        self.table!=table || self.projection!=projection || ![self.publishedTabID isEqual:tabID] ||
        self.dirty || self.privacyRefreshPending || self.sessionLayoutHeld || generation!=self.viewportGeneration) return NO;
    self.restoringViewport=YES;
    @try {
        CSGroupWithDisplayIndices(table, ^{
            if (fabs(target-table.contentOffset.y)>0.5)
                [table setContentOffset:CGPointMake(table.contentOffset.x,target) animated:NO];
        });
    } @finally { self.restoringViewport=NO; }
    current=CSCloseFriendCurrentSnapshot();
    if (current.blocked || current.revision!=policy.revision || ![current.accountID isEqual:account] ||
        generation!=self.viewportGeneration ||
        ![account isEqual:CSGroupCurrentAccountID()] || epoch!=CSCloseFriendAccountEpoch() || self.modelRevision!=revision ||
        self.table!=table || self.projection!=projection || ![self.publishedTabID isEqual:tabID] ||
        self.presentationSuspended || !CSGroupApplicationActive() || self.publishing || self.dirty || self.changeDepth ||
        self.privacyRefreshPending || self.sessionLayoutHeld || self.snapshotRetryAttempted || !self.isActive || !self.chromeVisible ||
        self.searching || self.nativePresentation || self.nativeActions.count ||
        table.tracking || table.dragging || table.decelerating || table.editing || self.swipeActive || [self groupPanMoving] || [self nativeMenuState]) return NO;
    if (self.usesNativeSessionModel) {
        CSGroupNativeSessionCoordinator *coordinator=CSGroupNativeSessionCoordinator.sharedCoordinator;
        if (coordinator.boundary || self.nativeModelRevision!=coordinator.revision || coordinator.epoch!=epoch ||
            ![coordinator.accountID isEqual:account]) return NO;
    }
    // setContentOffset can synchronously call the host's layout/delegate code.
    // Consume only the position it actually accepted under its final geometry.
    inset=table.adjustedContentInset; viewport=CGRectGetHeight(table.bounds);
    content=table.contentSize.height; offset=table.contentOffset.y;
    if (!isfinite(inset.top) || !isfinite(inset.bottom) || !isfinite(viewport) || !isfinite(content) ||
        !isfinite(offset) || viewport<=0 || content<0) return NO;
    if (content==0) for (NSArray *rows in projection.sections) if (rows.count) return NO;
    minimum=-inset.top; maximum=MAX(minimum,content-viewport+inset.bottom);
    target=MIN(maximum,MAX(minimum,height-inset.top));
    return isfinite(target) && fabs(offset-target)<=0.5 &&
        generation==self.viewportGeneration &&
        !current.blocked && current.revision==policy.revision && [current.accountID isEqual:account] &&
        [account isEqual:CSGroupCurrentAccountID()] && epoch==CSCloseFriendAccountEpoch() && self.modelRevision==revision &&
        self.table==table && self.projection==projection && [self.publishedTabID isEqual:tabID] &&
        !self.dirty && !self.privacyRefreshPending && !self.sessionLayoutHeld;
}
- (void)restorePendingViewport {
    if (self.restoringViewport) return;
    if (self.initialViewportPending) {
        [self restoreInitialViewport];
        if (self.initialViewportPending) return;
    }
    if (self.presentationViewport && ![self validViewport:self.presentationViewport]) {
        self.presentationViewport=nil; self.presentationReturnFinished=NO;
    }
    if (self.switchViewport && ![self validViewport:self.switchViewport]) self.switchViewport=nil;
    NSDictionary *viewport=self.presentationViewport ?: self.switchViewport;
    if (!viewport) return;
    BOOL returning=viewport==self.presentationViewport;
    if (!returning && ![viewport[@"targetTab"] isEqual:self.publishedTabID]) {
        // Settings can remove a requested group while publication is waiting
        // for an interaction. Once its valid fallback has been published, keep
        // the common height on that group instead of waiting forever for an ID
        // which can no longer be selected.
        if (self.publishing || self.dirty || self.changeDepth || self.privacyRefreshPending || self.sessionLayoutHeld ||
            self.snapshotRetryAttempted || !self.projection.isValid || !self.publishedTabID.length ||
            ![self.preferences.selectedTabID isEqual:self.publishedTabID]) return;
        BOOL targetExists=NO, publishedExists=NO;
        for (WESessionTabItem *tab in self.preferences.tabs) {
            if ([tab.tabId isEqual:viewport[@"targetTab"]]) targetExists=YES;
            if ([tab.tabId isEqual:self.publishedTabID]) publishedExists=YES;
        }
        if (targetExists || !publishedExists) return;
        NSMutableDictionary *request=[viewport mutableCopy]; request[@"targetTab"]=self.publishedTabID;
        self.switchViewport=request; viewport=self.switchViewport;
    }
    if (![self restoreScrollHeight:[viewport[@"height"] doubleValue]]) return;
    if (![self validViewport:viewport] || (returning ? self.presentationViewport!=viewport : self.switchViewport!=viewport)) return;
    [self.anchors removeObjectForKey:self.publishedTabID];
    if (returning) {
        // Keep the departure height through intermediate willAppear refreshes;
        // the host can still adjust the offset in its final appearance layout.
        if (self.presentationReturnFinished && self.presentationViewport==viewport) {
            self.presentationViewport=nil; self.presentationReturnFinished=NO;
        }
    } else if (self.switchViewport==viewport) self.switchViewport=nil;
    if (!self.presentationViewport && !self.switchViewport) [self saveAnchor];
}
- (void)restoreViewportFromSource:(NSDictionary *)viewport {
    if (!self.presentationViewport && !self.switchViewport && [self validViewport:viewport] &&
        ![viewport[@"tab"] isEqual:self.publishedTabID] && self.publishedTabID.length &&
        !self.searching && !self.nativePresentation && !self.nativeActions.count) {
        NSMutableDictionary *request=[viewport mutableCopy]; request[@"targetTab"]=self.publishedTabID;
        self.switchViewport=request;
    }
    [self restoreAnchor];
}
- (void)saveAnchor {
    NSUInteger generation=self.viewportGeneration;
    if (self.initialViewportPending) return;
    if (self.presentationSuspended || !CSGroupApplicationActive()) return;
    if ([self validViewport:self.presentationViewport] || [self validViewport:self.switchViewport]) return;
    if (!self.isActive || !self.publishedTabID) return;
    if (![self hasScrollableContent]) { [self.anchors removeObjectForKey:self.publishedTabID]; return; }
    if (![self canRestoreAnchor]) return;
    __block NSIndexPath *first=nil; __block CGRect rect=CGRectZero;
    CSGroupWithDisplayIndices(self.table, ^{ first=[self.table.indexPathsForVisibleRows sortedArrayUsingSelector:@selector(compare:)].firstObject; if (first) rect=[self.table rectForRowAtIndexPath:first]; });
    CSGroupRow *row=[self.projection rowAtDisplayPath:first];
    if (generation==self.viewportGeneration && row.userName.length)
        self.anchors[self.publishedTabID]=@{@"name":row.userName,@"kind":@(row.kind),@"offset":@(self.table.contentOffset.y+self.table.adjustedContentInset.top-rect.origin.y)};
}
- (void)restoreAnchor {
    NSUInteger generation=self.viewportGeneration;
    if (self.initialViewportPending) { [self restorePendingViewport]; return; }
    if (self.presentationSuspended || !CSGroupApplicationActive()) return;
    if (self.presentationViewport || self.switchViewport) { [self restorePendingViewport]; return; }
    NSDictionary *anchor=self.anchors[self.publishedTabID];
    if (!self.isActive || !anchor || ![self canRestoreAnchor]) return;
    for (NSUInteger s=0;s<self.projection.sections.count;s++) {
        NSArray *rows=self.projection.sections[s];
        for (NSUInteger r=0;r<rows.count;r++) { CSGroupRow *row=rows[r];
            if ([row.userName isEqual:anchor[@"name"]] && row.kind==[anchor[@"kind"] unsignedIntegerValue]) {
                NSIndexPath *path=[NSIndexPath indexPathForRow:(NSInteger)r inSection:(NSInteger)s];
                CSGroupWithDisplayIndices(self.table, ^{
                    // Keep the row relative to the unobscured viewport, not an
                    // absolute offset captured with an earlier navigation inset.
                    CGFloat y=[self.table rectForRowAtIndexPath:path].origin.y+[anchor[@"offset"] doubleValue]-self.table.adjustedContentInset.top;
                    CGFloat min=-self.table.adjustedContentInset.top;
                    CGFloat max=MAX(min,self.table.contentSize.height-self.table.bounds.size.height+self.table.adjustedContentInset.bottom);
                    CGFloat target=MIN(max,MAX(min,y));
                    if ([self canRestoreAnchor] && generation==self.viewportGeneration &&
                        isfinite(y) && fabs(target-self.table.contentOffset.y)>0.5)
                        [self.table setContentOffset:CGPointMake(self.table.contentOffset.x,target) animated:NO];
                }); return;
            }
        }
    }
}
- (void)selectIndex:(NSInteger)index {
    if (self.swipeActive || self.table.editing || [self nativeMenuState]) { self.chrome.selectedTabID=self.publishedTabID; return; }
    NSArray *tabs=self.displayedTabs; if (index<0 || index>=(NSInteger)tabs.count) return;
    if (![self.preferences.accountID isEqualToString:CSGroupCurrentAccountID()]) { [self requestRefresh]; return; }
    NSString *tabID=[tabs[(NSUInteger)index] tabId];
    [self cancelInitialViewport];
    BOOL belongs=[self.preferences.tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab, NSDictionary *bindings) { (void)bindings; return [tab.tabId isEqual:tabID]; }]].count>0;
    if (belongs && !self.nativePresentation && !self.nativeActions.count &&
        [tabID isEqual:self.publishedTabID] && [tabID isEqual:self.preferences.selectedTabID] &&
        (!self.switchViewport || [self.switchViewport[@"targetTab"] isEqual:tabID])) return;
    // One height follows successive A -> B -> C selections until the latest
    // publication accepts it. Never read an intermediate short group's clamp
    // as a new source, and never restore an older position belonging to C.
    NSDictionary *viewport=[self validViewport:self.switchViewport] ? self.switchViewport :
        [self captureViewportForTabID:self.publishedTabID];
    if (!viewport && [self validViewport:self.presentationViewport]) viewport=self.presentationViewport;
    [self clearPendingViewport];
    if (belongs && viewport) {
        NSMutableDictionary *request=[viewport mutableCopy]; request[@"targetTab"]=tabID;
        self.switchViewport=request;
    }
    // A newer user selection supersedes any queued explicit native navigation.
    [self.nativeActions removeAllObjects];
    self.snapshotRetryAttempted=NO; self.recoveryAttempts=0; self.recoveryPending=NO;
    self.nativePresentation=!belongs;
    if (belongs) {
        self.preferences.selectedTabID=tabID;
        if (![self.preferences.selectedTabID isEqual:tabID]) {
            // A protected schema or failed defaults write can reject selection.
            // Do not retain a viewport request for a group never accepted.
            self.switchViewport=nil;
            self.chrome.selectedTabID=self.preferences.selectedTabID;
        }
    }
    [self.anchors removeObjectForKey:tabID];
    [self refresh];
    if (belongs) [CSGroupListAdapter refreshFoldedListsForAccount:self.preferences.accountID];
}
+ (void)refreshFoldedListsForAccount:(NSString *)account {
    if (!account.length || ![account isEqual:CSGroupCurrentAccountID()]) return;
    // Separate native owners cache the same account's group selection. A hidden
    // folded page only becomes dirty; its appearance reloads preferences once.
    for (CSGroupListAdapter *adapter in Adapters().allObjects)
        if (CSGroupIsFoldedController(adapter.controller) && [adapter.preferences.accountID isEqual:account]) [adapter requestRefresh];
}
+ (NSString *)groupTitleForTitleView:(id)titleView {
    if (!titleView || !Option(@"enabled")) return nil;
    for (CSGroupListAdapter *adapter in Adapters().allObjects) {
        // The main list remains visible behind the shortcut-search transition.
        // Its title follows the retained group chrome; other title views and
        // ordinary native search still use their own title policy.
        if (CSGroupReadObject(adapter.controller,@"m_titleView")!=titleView || !adapter.chromeVisible ||
            (adapter.searching && ![adapter keepsGroupHeaderDuringSearch]) ||
            ![adapter.preferences.accountID isEqual:CSGroupCurrentAccountID()]) continue;
        for (WESessionTabItem *tab in adapter.displayedTabs)
            if ([tab.tabId isEqual:adapter.publishedTabID]) return tab.displayName;
    }
    return nil;
}
+ (void)recordNativeTitle:(NSString *)title status:(unsigned int)status forTitleView:(id)titleView {
    objc_setAssociatedObject(titleView,&TitleContextKey,@{@"title":title ?: NSNull.null,@"status":@(status)},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)refreshNavigationTitle {
    if (self.presentationSuspended || !CSGroupApplicationActive()) return;
    id titleView=CSGroupReadObject(self.controller,@"m_titleView");
    NSDictionary *before=objc_getAssociatedObject(titleView,&TitleContextKey);
    SEL selector=NSSelectorFromString(@"updateTitleView");
    if ([self.controller respondsToSelector:selector]) ((void(*)(id,SEL))objc_msgSend)(self.controller,selector);
    // Native updateTitleView may skip an unchanged "WeChat" title. Replaying its
    // last input still updates the group name, without changing its cached title
    // or inventing a status flag. The hook resolves the new group at render time.
    if (before && before==objc_getAssociatedObject(titleView,&TitleContextKey)) {
        SEL render=NSSelectorFromString(@"updateTitleView:title:");
        NSString *title=before[@"title"]==NSNull.null ? nil : before[@"title"];
        if ([titleView respondsToSelector:render])
            ((void(*)(id,SEL,unsigned int,id))objc_msgSend)(titleView,render,[before[@"status"] unsignedIntValue],title);
    }
}
- (BOOL)groupSwipesAvailable {
    return self.table && Option(@"enabled") && Option(@"swipe_gesture_enabled") && self.chromeVisible && !self.searching;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    BOOL allowed=NO;
    if (gesture==self.pan) self.barTouchAllowed=NO; else if (gesture==self.listPan) self.listTouchAllowed=NO;
    if ((gesture!=self.pan && gesture!=self.listPan) || ![self groupSwipesAvailable]) return NO;
    // Decide using the initial touch, before either recognizer can begin or cancel another.
    for (UIView *view=touch.view; view; view=view.superview) {
        if ([view isKindOfClass:UIControl.class] && gesture==self.pan && ![view isDescendantOfView:self.chrome.scrollView]) return NO;
        if (view==self.table || view==self.chrome) break;
    }
    if (gesture==self.listPan) {
        // Menu state never changes zone ownership; menu buttons still receive taps
        // unless a left-zone horizontal group pan actually begins.
        if ([self listZoneForTouch:touch]!=0) return NO;
        if (touch.view==self.chrome || [touch.view isDescendantOfView:self.headerContainer]) return NO;
        allowed=YES;
    } else if (self.chrome.scrollView.contentSize.width>self.chrome.scrollView.bounds.size.width) {
        allowed=!CGRectContainsPoint(self.chrome.scrollView.bounds,[touch locationInView:self.chrome.scrollView]);
    } else allowed=YES;
    if (gesture==self.pan) self.barTouchAllowed=allowed; else self.listTouchAllowed=allowed;
    return allowed;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other {
    if (gesture!=self.listPan || other==gesture || other==self.pan || !self.listTouchAllowed || ![self groupSwipesAvailable]) return NO;
    if (![other isKindOfClass:UIPanGestureRecognizer.class] && ![other isKindOfClass:UISwipeGestureRecognizer.class]) return NO;
    UIView *view=other.view;
    if (!view || (view!=self.table && ![view isDescendantOfView:self.table])) return NO;
    if ([view isDescendantOfView:self.headerContainer]) return NO;
    // Native row swipes (and the table's scroll pan) wait for our direction decision.
    // A vertical drag fails shouldBegin immediately; an admitted horizontal drag
    // owns the sequence even if the host permits simultaneous recognition.
    // This is a per-attempt delegate dependency, not a permanent native modification.
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture {
    if ((gesture!=self.pan && gesture!=self.listPan) || ![self groupSwipesAvailable]) return NO;
    if (!(gesture==self.pan ? self.barTouchAllowed : self.listTouchAllowed)) return NO;
    UIPanGestureRecognizer *pan=(UIPanGestureRecognizer *)gesture;
    CGPoint v=[pan velocityInView:self.chrome]; return fabs(v.x)>fabs(v.y)*1.5;
}
- (void)groupPan:(UIPanGestureRecognizer *)pan {
    if (pan!=self.pan && pan!=self.listPan) return;
    BOOL terminal=pan.state==UIGestureRecognizerStateEnded || pan.state==UIGestureRecognizerStateCancelled || pan.state==UIGestureRecognizerStateFailed;
    if (terminal && self.dirty) [self scheduleRefresh];
    if (terminal) {
        // A horizontal gesture can leave table.tracking set until this event
        // unwinds without ever producing a vertical scroll-end callback.
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{
            CSGroupListAdapter *adapter=weakSelf;
            if (adapter.dirty) [adapter scheduleRefresh];
            [adapter restorePendingViewport];
        });
    }
    // Admission is latched at touch-down; crossing the 85% boundary cannot change owners.
    BOOL admitted=[self groupSwipesAvailable] && (pan==self.pan ? self.barTouchAllowed : self.listTouchAllowed);
    if (!admitted || pan.state==UIGestureRecognizerStateCancelled || pan.state==UIGestureRecognizerStateFailed) {
        [self.chrome cancelInteractiveTransition]; return;
    }
    CGPoint p=[pan translationInView:self.chrome],v=[pan velocityInView:self.chrome];
    NSInteger index=self.chrome.selectedIndex+(p.x<0 || (p.x==0 && v.x<0) ? 1 : -1);
    BOOL valid=index>=0 && index<(NSInteger)self.displayedTabs.count;
    if (pan.state==UIGestureRecognizerStateBegan || pan.state==UIGestureRecognizerStateChanged) {
        if (valid) {
            CGFloat travel=MAX(88,MIN(160,CGRectGetWidth(self.table.bounds)*0.28));
            [self.chrome updateInteractiveTransitionToIndex:index progress:MIN(1,fabs(p.x)/travel)];
        } else [self.chrome cancelInteractiveTransition];
        return;
    }
    if (pan.state!=UIGestureRecognizerStateEnded) return;
    if ((fabs(p.x)>=44 || fabs(v.x)>=350) && valid && [self closeMenusForGroupSwitch]) {
        [self.chrome selectTabAtIndex:index animated:YES]; [self selectIndex:index];
    } else [self.chrome cancelInteractiveTransition];
}
@end
BOOL CSGroupCardPosition(UITableView *table, NSIndexPath *path, BOOL *first, BOOL *last) {
    CSGroupListAdapter *adapter=[CSGroupListAdapter adapterForTable:table];
    if (!adapter.isActive) return NO;
    if (CSGroupUsesNativeIndices(table)) path=[adapter displayPath:path];
    if (!path || path.length!=2 || path.section<0 || path.section>=(NSInteger)adapter.projection.sections.count) return NO;
    NSArray *rows=adapter.projection.sections[(NSUInteger)path.section];
    if (path.row<0 || path.row>=(NSInteger)rows.count) return NO;
    // Aggregates participate in the same continuous section card as sessions.
    if (first) *first=path.row==0;
    if (last) *last=path.row==(NSInteger)rows.count-1;
    return YES;
}
