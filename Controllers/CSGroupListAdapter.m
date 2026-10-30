#import "CSGroupListAdapter.h"
#import "CSGroupProjection.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendSessionPresentation.h"
#import "CSCloseFriendListShield.h"
#import "CSGroupPreferences.h"
#import "CSGroupAppearance.h"
#import "CSGroupInvocationMapper.h"
#import "CSGroupNativeBridge.h"
#import "WESessionTabContainerView.h"
#import <objc/runtime.h>
#import <objc/message.h>

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
@property (nonatomic) BOOL projecting, chromeVisible, publicationNeedsFullReload;
@property (nonatomic) BOOL privacyRefreshPending;
@property (nonatomic,strong) CSCloseFriendListShield *privacyShield;
@property (nonatomic) BOOL searchChromeVisible;
@property (nonatomic) BOOL presentationSuspended;
@property (nonatomic, copy) NSDictionary *presentationViewport;
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
- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced;
- (void)cancelTabBadgeSourceRefresh;
- (void)refreshTabBadgeSource;
+ (void)requestTabBadgeSourcesRefresh;
@property (atomic) NSUInteger modelRevision;
@property (nonatomic) NSUInteger snapshotRevision, snapshotEpoch, refreshGeneration;
// Pending admission survives re-entrant publication. A UI wake never creates work.
@property (nonatomic) BOOL coalescingNotification, scheduledCoalesced, pendingImmediateRefresh;
@property (nonatomic) NSTimeInterval pendingRefreshDeadline, scheduledRefreshDeadline;
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSNumber *> *refreshDiagnosticCounts;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *refreshDiagnosticEvents;
@property (nonatomic) NSTimeInterval refreshDiagnosticStart;
@property (nonatomic) NSUInteger refreshDiagnosticSamples;
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay;
@property (nonatomic) BOOL coalescedDispatchPending;
@property (atomic) CSGroupChangeKind pendingChanges;
@property (nonatomic, strong) NSMutableSet<NSString *> *pendingContentUserNames;
@property (nonatomic) BOOL pendingContentUnattributed;
@property (nonatomic, copy) NSSet<NSString *> *nativeChangeUserNames;
@property (nonatomic, strong) NSMutableArray *nativeChangeIdentityStack;
@property (atomic) BOOL recoveryPending;
@property (nonatomic) BOOL scheduledInteraction, scheduledRecovery, appearanceDirty;
@property (nonatomic) NSUInteger recoveryAttempts, recoveryRevision, interactionAttempts;
@property (nonatomic, copy) NSString *recoveryAccount;
@property (nonatomic) NSTimeInterval interactionDeadline;
- (void)scheduleRefresh;
- (void)requestRecovery;
- (void)cancelScheduledRefresh;
@property (nonatomic) BOOL nativePresentation, scheduled, dirty, searching, pendingScrollToTop;
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
- (void)dealloc { [_tabBadgeSourceTimer invalidate]; }
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
        adapter.presentationSuspended=[objc_getAssociatedObject(controller,&PresentationSuspendedKey) boolValue];
        adapter.proxies=[NSMutableDictionary dictionary]; adapter.anchors=[NSMutableDictionary dictionary]; adapter.completions=[NSMutableArray array]; adapter.prefetchedPaths=[NSMutableSet set]; adapter.nativeActions=[NSMutableArray array];
        adapter.nativeHeader=[table tableHeaderView]; adapter.baselineDeceleration=[table decelerationRate];
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
        adapter.presentationViewport=nil;
        NSString *account=adapter.preferences.accountID;
        CGFloat height=adapter.table.contentOffset.y+adapter.table.adjustedContentInset.top;
        if (!CSGroupIsFoldedController(controller) && adapter.isActive && adapter.chromeVisible && !adapter.searching &&
            !adapter.nativePresentation && !adapter.nativeActions.count && !adapter.pendingScrollToTop &&
            account.length && [account isEqual:CSGroupCurrentAccountID()] && isfinite(height))
            adapter.presentationViewport=@{@"height":@(MAX(0,height)),@"account":account,@"epoch":@(CSCloseFriendAccountEpoch())};
    }
    adapter.presentationSuspended=suspended;
    if (suspended) {
        adapter.dirty=YES; [adapter invalidateNativeSnapshot]; adapter.cachedNativeSections=nil;
        @synchronized (adapter) { adapter.pendingChanges|=CSGroupChangeUnknown|CSGroupChangeContent; adapter.pendingContentUnattributed=YES; }
        [adapter.projection discardComputationCache]; [adapter cancelScheduledRefresh];
        adapter.snapshotRetryAttempted=NO; adapter.snapshotRetryGeneration++;
        [adapter finishSuspendedBatches];
    }
    [adapter requestTabBadgeSourceRefresh];
}
+ (void)finishPresentationReturnForController:(id)controller {
    if (!NSThread.isMainThread || !controller) return;
    CSGroupListAdapter *adapter=[self adapterForController:controller];
    if (!adapter.presentationViewport) return;
    [adapter restoreAnchor];
    adapter.presentationViewport=nil;
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
        if(CSGroupIsFoldedController(adapter.controller) || !adapter.cachedNativeSections || adapter.changeDepth || adapter.dirty ||
           adapter.snapshotRevision!=adapter.modelRevision || adapter.snapshotEpoch!=epoch || ![adapter.snapshotAccount isEqual:policy.accountID] ||
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
        CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:adapter.cachedNativeSections tabs:@[all] selectedTabID:all.tabId
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
        else if (!adapter.changeDepth && !adapter.dirty && adapter.cachedNativeSections && adapter.snapshotRevision==revision &&
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
        if (self.tabBadgeSections && self.tabBadgeRevision==revision && self.tabBadgeEpoch==epoch &&
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
    dispatch_async(dispatch_get_main_queue(), ^{ for (CSGroupListAdapter *adapter in Adapters().allObjects) { @synchronized (adapter) { adapter.pendingChanges|=CSGroupChangeUnknown|CSGroupChangeContent; adapter.pendingContentUnattributed=YES; } [adapter invalidateNativeSnapshot]; adapter.appearanceDirty=YES; [adapter requestTabBadgeSourceRefresh]; [adapter refresh]; [adapter layout]; } });
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
        @synchronized (adapter) { adapter.pendingChanges|=CSGroupChangeUnknown|CSGroupChangeContent; adapter.pendingContentUnattributed=YES; } adapter.dirty=YES; adapter.recoveryPending=NO;
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
- (id)nativeSource { return self.proxies[@0].target; }
- (void)installProxies {
    UITableView *table=self.table; if (!table) return;
    id source=[self proxyForTarget:table.dataSource role:0];
    id delegate=[self proxyForTarget:table.delegate role:1];
    id prefetch=[self proxyForTarget:table.prefetchDataSource role:2];
    if (table.dataSource!=source) table.dataSource=source;
    if (table.delegate!=delegate) table.delegate=delegate;
    if (table.prefetchDataSource!=prefetch) table.prefetchDataSource=prefetch;
}
- (id)proxyForTarget:(id)target role:(NSUInteger)role {
    if ([target isKindOfClass:CSGroupTableProxy.class]) return target;
    CSGroupTableProxy *proxy=self.proxies[@(role)];
    if (!target) { proxy.target=nil; return nil; }
    if (!proxy) { proxy=[CSGroupTableProxy new]; proxy.adapter=self; self.proxies[@(role)]=proxy; }
    proxy.target=target; return proxy;
}
- (void)detach {
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
    [self invalidateNativeSnapshot];
    if (!self.searching) {
        [self saveAnchor];
        // Keep the main-list header stable behind the native search page. Native
        // callers still obtain the original search object through header scope.
        self.searchChromeVisible=self.chromeVisible && self.headerContainer &&
            Option(@"enabled") && CSGroupSearchButtonVisible(NSUserDefaults.standardUserDefaults);
    }
    self.searching=YES; self.pendingScrollToTop=NO;
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
        self.chrome.hidden=NO; self.chrome.userInteractionEnabled=NO;
        self.pan.enabled=NO; self.listPan.enabled=NO;
        if (installed!=self.headerContainer) [self publishHeader:self.headerContainer];
        table.decelerationRate=self.baselineDeceleration;
        return;
    }
    BOOL visible=self.chromeVisible && !self.searching;
    if (!visible) {
        self.chrome.hidden=YES;
        self.pan.enabled=NO; self.listPan.enabled=NO;
        if (installed!=self.nativeHeader) [self publishHeader:self.nativeHeader];
        table.decelerationRate=self.baselineDeceleration; return;
    }
    [self ensureChrome];
    self.chrome.userInteractionEnabled=YES;
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
    if (replacesNativeHeader) [self.nativeHeader removeFromSuperview];
    else if (self.nativeHeader && self.nativeHeader.superview!=self.headerContainer) [self.headerContainer addSubview:self.nativeHeader];
    if (self.chrome.superview!=self.headerContainer) [self.headerContainer addSubview:self.chrome];
    self.nativeHeader.frame=CGRectMake(0,0,width,nativeHeight);
    self.chrome.frame=CGRectMake(0,displayedNativeHeight,width,height); self.chrome.hidden=NO;
    CGRect headerFrame=CGRectMake(0,0,width,displayedNativeHeight+height);
    BOOL resized=!CGRectEqualToRect(self.headerContainer.frame,headerFrame);
    self.headerContainer.frame=headerFrame;
    if (installed!=self.headerContainer || resized) [self publishHeader:self.headerContainer];
    NSInteger sensitivity=[NSUserDefaults.standardUserDefaults integerForKey:@"com.wechat.enhance.scroll_sensitivity"];
    table.decelerationRate=sensitivity==1 ? 0.998 : sensitivity==2 ? 0.9998 : sensitivity==3 ? 0.999 : self.baselineDeceleration;
    [self updateGroupGestureAvailability];
    [self applyPendingScrollToTop];
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
    if (self.dirty || self.pendingScrollToTop) [self scheduleRefresh];
}
- (void)invalidateNativeSnapshot {
    @synchronized (self) { self.modelRevision++; }
}
- (NSArray *)nativeSectionsForAccount:(NSString *)account {
    NSUInteger revision=self.modelRevision, epoch=CSCloseFriendAccountEpoch();
    if (self.cachedNativeSections && self.snapshotRevision==revision && self.snapshotEpoch==epoch && [self.snapshotAccount isEqual:account]) return self.cachedNativeSections;
    if (!self.changeDepth && self.tabBadgeSections && self.tabBadgeRevision==revision && self.tabBadgeEpoch==epoch && [self.tabBadgeAccount isEqual:account]) {
        self.cachedNativeSections=self.tabBadgeSections; self.snapshotAccount=account; self.snapshotRevision=revision; self.snapshotEpoch=epoch;
        return self.cachedNativeSections;
    }
    __block NSArray *sections=nil;
    NSArray *previous=self.snapshotEpoch==epoch && [self.snapshotAccount isEqual:account] ? self.cachedNativeSections : nil;
    CSGroupWithNativeIndices(self.table, ^{ sections=CSGroupBuildNativeSectionsReusing(self.controller,self.table,[self nativeSource],previous); });
    // Only immutable row values are cached; never hold private sessions/contacts.
    if (revision!=self.modelRevision || epoch!=CSCloseFriendAccountEpoch() || ![account isEqual:CSGroupCurrentAccountID()]) { self.cachedNativeSections=nil; return nil; }
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
- (void)refresh {
    if (!NSThread.isMainThread) { [self requestRefresh]; return; }
    if (self.publishing) return;
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
    self.publishing=YES; self.dirty=NO;
    // A synchronous privacy/selection publication consumes any queued generation.
    // Otherwise an old timer can accidentally consume a later notification early.
    self.refreshGeneration++; self.scheduled=NO;
    self.scheduledCoalesced=NO; self.scheduledInteraction=NO; self.scheduledRecovery=NO;
    self.coalescingNotification=NO; self.pendingImmediateRefresh=NO;
    self.pendingRefreshDeadline=0; self.scheduledRefreshDeadline=0;
    [self recordRefreshEvent:@"publish" delay:0];
    CSGroupChangeKind changes;
    NSSet<NSString *> *contentUserNames; BOOL contentIdentityKnown;
    @synchronized (self) {
        changes=self.pendingChanges; self.pendingChanges=0;
        contentUserNames=[self.pendingContentUserNames copy]; contentIdentityKnown=!self.pendingContentUnattributed;
        self.pendingContentUserNames=nil; self.pendingContentUnattributed=NO;
    }
    self.recoveryPending=NO;
    NSUInteger publicationEpoch=CSCloseFriendAccountEpoch();
    NSUInteger publicationPrivacyRevision=CSCloseFriendCurrentSnapshot().revision;
    NSString *publicationAccount=CSGroupCurrentAccountID();
    BOOL finished=NO;
    @try {
        NSString *viewportTab=(self.chromeVisible && self.isActive && !self.searching && !self.nativePresentation && !self.nativeActions.count) ? self.publishedTabID : nil;
        CGFloat viewportHeight=self.table.contentOffset.y+self.table.adjustedContentInset.top;
        [self saveAnchor];
        [self installProxies];
        NSString *account=CSGroupCurrentAccountID();
        BOOL changed= ![self.preferences.accountID isEqualToString:account];
        if (changed) { self.anchors=[NSMutableDictionary dictionary]; self.nativePresentation=self.nativeActions.count>0; self.projection=nil; self.snapshotRetryAttempted=NO; self.searchChromeVisible=NO; }
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
            @synchronized (self) {
                self.pendingChanges|=changes|CSGroupChangeUnknown;
                if (contentUserNames.count) {
                    if (!self.pendingContentUserNames) self.pendingContentUserNames=[NSMutableSet set];
                    [self.pendingContentUserNames unionSet:contentUserNames];
                }
                self.pendingContentUnattributed|=!contentIdentityKnown;
            }
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
        BOOL previouslyProjecting=self.projecting;
        NSArray *sections=(self.nativePresentation && !privacy) ? nil : [self nativeSectionsForAccount:account];
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
        NSString *currentPublicationAccount=CSGroupCurrentAccountID();
        if (publicationEpoch!=CSCloseFriendAccountEpoch() || publicationPrivacyRevision!=CSCloseFriendCurrentSnapshot().revision ||
            !(publicationAccount==currentPublicationAccount || [publicationAccount isEqual:currentPublicationAccount])) return;
        [self.privacyShield prepareForPublication];
        [self publishProjection:projection previous:previous changes:changes contentUserNames:contentUserNames
            contentIdentityKnown:contentIdentityKnown previouslyProjecting:previouslyProjecting];
        currentPublicationAccount=CSGroupCurrentAccountID();
        if (publicationEpoch!=CSCloseFriendAccountEpoch() || publicationPrivacyRevision!=CSCloseFriendCurrentSnapshot().revision ||
            !(publicationAccount==currentPublicationAccount || [publicationAccount isEqual:currentPublicationAccount])) return;
        [self restoreViewportFromTab:(changed ? nil : viewportTab) scrollHeight:viewportHeight];
        [self refreshNavigationTitle];
        finished=YES;
    } @finally {
        self.publishing=NO;
        NSString *currentPublicationAccount=CSGroupCurrentAccountID();
        BOOL publicationCurrent=publicationEpoch==CSCloseFriendAccountEpoch() &&
            publicationPrivacyRevision==CSCloseFriendCurrentSnapshot().revision &&
            (publicationAccount==currentPublicationAccount || [publicationAccount isEqual:currentPublicationAccount]);
        if (!publicationCurrent) {
            finished=NO; self.dirty=YES; self.publicationNeedsFullReload=YES;
            // A policy callback may run inside native cell/layout work. The old
            // publication cannot acknowledge it or remove the synchronous shield.
            self.privacyRefreshPending|=CSGroupPrivacyActive();
            @synchronized (self) {
                self.pendingChanges|=changes|CSGroupChangeUnknown;
                if (contentUserNames.count) {
                    if (!self.pendingContentUserNames) self.pendingContentUserNames=[NSMutableSet set];
                    [self.pendingContentUserNames unionSet:contentUserNames];
                }
                self.pendingContentUnattributed|=!contentIdentityKnown;
            }
        }
        if (!finished && self.privacyRefreshPending) [self shieldVisiblePrivateRows];
        if (finished) {
            self.privacyRefreshPending=NO;
            if (CSCloseFriendCurrentSnapshot().blocked && !CSGroupCurrentAccountID().length)
                [self shieldVisiblePrivateRows];
            else
                [self.privacyShield prepareForPublication];
        }
        if (finished) [self applyPendingScrollToTop];
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
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                  changes:(CSGroupChangeKind)changes contentUserNames:(NSSet<NSString *> *)names
     contentIdentityKnown:(BOOL)known previouslyProjecting:(BOOL)previouslyProjecting {
    __block NSArray *visible;
    CSGroupWithDisplayIndices(self.table, ^{ visible=self.table.indexPathsForVisibleRows ?: @[]; });
    CSGroupPublicationPlan *plan=[projection publicationPlanFrom:previous changes:changes contentUserNames:names
        contentIdentityKnown:known visiblePaths:visible];
    BOOL incremental=previouslyProjecting && self.projecting && !self.pendingScrollToTop &&
        !self.publicationNeedsFullReload && projection && !plan.fullReload;
    // An unchanged notification may rebuild the immutable snapshot without any
    // table operation. This also breaks native layout/unread notification feedback.
    if (incremental && !plan.reloadPaths.count && !plan.geometryChanged) {
        [self recordRefreshEvent:@"publish.unchanged" delay:0]; return;
    }
    CSGroupWithDisplayIndices(self.table, ^{
        if (!incremental) {
            [self recordRefreshEvent:@"publish.full" delay:0];
            [self.table reloadData];
        } else if (plan.reloadPaths.count) {
            [self recordRefreshEvent:@"publish.rows" delay:0];
            [self.table reloadRowsAtIndexPaths:plan.reloadPaths withRowAnimation:UITableViewRowAnimationNone];
        }
        // Only structural/geometry changes need synchronous measurement for
        // anchor restoration. Ordinary unread/text updates use UIKit's layout pass.
        if (!incremental || plan.geometryChanged) [self.table layoutIfNeeded];
    });
    self.publicationNeedsFullReload=NO;
}
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)account {
    if (!account.length) return nil;
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    NSMutableSet *hidden=[NSMutableSet set];
    for (NSString *name in policy.protectedUserNames)
        if ([policy hidesUserName:name surface:CSCloseFriendSurfaceSession]) [hidden addObject:name];
    NSMutableSet *unmasked=[NSMutableSet set];
    BOOL scopeFolded=Option(@"enabled") && !CSGroupIsFoldedController(self.controller) && !self.nativePresentation;
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
// A bounded sample can be exported once from the debugger/console. It stores
// selector/counter state only, never session names, message contents or disk logs.
- (void)resetRefreshDiagnostics {
    @synchronized (self) {
        self.refreshDiagnosticStart=NSProcessInfo.processInfo.systemUptime;
        self.refreshDiagnosticSamples=0;
        self.refreshDiagnosticCounts=[NSMutableDictionary dictionary];
        self.refreshDiagnosticEvents=[NSMutableArray array];
    }
}
- (void)recordRefreshReason:(NSString *)reason { [self recordRefreshEvent:reason delay:0]; }
- (void)recordRefreshEvent:(NSString *)event delay:(NSTimeInterval)delay {
    @synchronized (self) {
        if (!self.refreshDiagnosticCounts) [self resetRefreshDiagnostics];
        NSTimeInterval elapsed=NSProcessInfo.processInfo.systemUptime-self.refreshDiagnosticStart;
        if (elapsed>60 || self.refreshDiagnosticSamples>=2048) return;
        NSString *key=event.length<=96 ? event : @"other";
        if (!self.refreshDiagnosticCounts[key] && self.refreshDiagnosticCounts.count>=48) key=@"other";
        self.refreshDiagnosticCounts[key]=@([self.refreshDiagnosticCounts[key] unsignedIntegerValue]+1);
        self.refreshDiagnosticSamples++;
        if (self.refreshDiagnosticEvents.count==32) [self.refreshDiagnosticEvents removeObjectAtIndex:0];
        [self.refreshDiagnosticEvents addObject:@{@"reason":key,@"elapsed":@(elapsed),@"publishing":@(self.publishing),
            @"dirty":@(self.dirty),@"revision":@(self.modelRevision),@"changes":@(self.pendingChanges),
            @"pendingTop":@(self.pendingScrollToTop),@"coalesced":@(self.coalescingNotification),@"delay":@(delay)}];
    }
}
- (NSDictionary *)refreshDiagnosticsSnapshot {
    @synchronized (self) {
        NSTimeInterval elapsed=self.refreshDiagnosticStart ? NSProcessInfo.processInfo.systemUptime-self.refreshDiagnosticStart : 0;
        return @{@"windowSeconds":@60,@"elapsedSeconds":@(elapsed),@"samples":@(self.refreshDiagnosticSamples),
            @"complete":@(elapsed>=60 || self.refreshDiagnosticSamples>=2048),
            @"counts":[self.refreshDiagnosticCounts copy] ?: @{},@"recent":[self.refreshDiagnosticEvents copy] ?: @[]};
    }
}
- (void)cancelScheduledRefresh {
    self.refreshGeneration++; self.scheduled=NO; self.scheduledCoalesced=NO; self.scheduledInteraction=NO; self.scheduledRecovery=NO;
    self.interactionDeadline=0; self.interactionAttempts=0;
    self.coalescingNotification=NO; self.pendingImmediateRefresh=NO;
    self.pendingRefreshDeadline=0; self.scheduledRefreshDeadline=0;
}
- (void)requestRecovery {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self requestRecovery]; }); return; }
    self.dirty=YES; self.recoveryPending=YES;
    @synchronized (self) {
        // A native cell may have failed after a placeholder was delivered.
        // Recovery must retry its content even if immutable row metadata matches.
        self.pendingChanges|=CSGroupChangeUnknown|CSGroupChangeContent; self.pendingContentUnattributed=YES;
    }
    // Do not invent a model revision for a failed rendering attempt. All failures
    // of the same account/revision share one finite retry budget.
    self.cachedNativeSections=nil;
    [self recordRefreshEvent:@"recovery" delay:0];
    [self scheduleRefresh];
}
- (void)requestRefresh {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self requestRefresh]; }); return; }
    if (self.publishing && !self.changeDepth && !self.nativeActions.count) { [self requestRecovery]; return; }
    // A table invalidation inside a native transaction belongs to that event.
    // Its outer end owns both content attribution and notification priority.
    if (self.changeDepth) { self.dirty=YES; [self scheduleRefresh]; return; }
    self.dirty=YES; self.pendingImmediateRefresh=YES;
    self.coalescingNotification=NO; self.pendingRefreshDeadline=0;
    if (!self.changeDepth) {
        self.recoveryPending=NO;
        @synchronized (self) { self.pendingChanges|=CSGroupChangeUnknown|CSGroupChangeContent; self.pendingContentUnattributed=YES; }
        [self invalidateNativeSnapshot];
    }
    [self recordRefreshEvent:@"request" delay:0];
    [self scheduleRefresh];
}
- (void)scheduleRefresh {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self scheduleRefresh]; }); return; }
    if (!self.dirty) { [self applyPendingScrollToTop]; return; }
    [self pruneNativeActions];
    if ((!CSGroupApplicationActive() && !(self.privacyRefreshPending && CSGroupPrivacyActive())) || (self.presentationSuspended && !self.nativeActions.count)) { [self finishSuspendedBatches]; return; }
    // The request already retained its priority/deadline; publication must not
    // turn a passive notification into an immediate refresh in its finally block.
    if (self.changeDepth || self.publishing) return;
    NSTimeInterval now=NSProcessInfo.processInfo.systemUptime;
    BOOL coalesced=!self.privacyRefreshPending && !self.pendingImmediateRefresh && self.coalescingNotification && !self.nativeActions.count;
    BOOL waiting=!self.privacyRefreshPending && !self.presentationSuspended && (self.table.tracking || [self groupPanMoving] || ([self nativeMenuState]&2));
    BOOL releasedWait=self.scheduledInteraction && !waiting;
    BOOL freshEvent=self.scheduledRecovery && !self.recoveryPending;
    NSTimeInterval delay=coalesced ? MAX(0,self.pendingRefreshDeadline-now) : 0;
    if (waiting) {
        if (!self.interactionDeadline) self.interactionDeadline=now+2.0;
        if (now>=self.interactionDeadline) return;
        delay=MAX(delay,MIN(self.interactionDeadline-now,MIN(0.4,0.05*(1UL<<MIN(self.interactionAttempts,3UL)))));
    } else { self.interactionDeadline=0; self.interactionAttempts=0; }
    BOOL recovery=self.recoveryPending && !waiting;
    if (recovery) {
        NSString *account=CSGroupCurrentAccountID();
        BOOL sameAccount=self.recoveryAccount==account || [self.recoveryAccount isEqual:account];
        if (self.recoveryRevision!=self.modelRevision || !sameAccount) {
            self.recoveryRevision=self.modelRevision; self.recoveryAccount=account; self.recoveryAttempts=0;
        }
        // A repeated UI wake does not spend or reset the finite recovery budget.
        if (self.scheduled && self.scheduledRecovery && !releasedWait) return;
        if (self.recoveryAttempts>=3) return;
        static const NSTimeInterval delays[]={0.1,0.25,0.5};
        delay=MAX(delay,delays[self.recoveryAttempts]);
    }
    NSTimeInterval due=now+delay;
    if (self.scheduled && !releasedWait && !freshEvent && self.scheduledRefreshDeadline<=due+0.001) return;
    if (waiting) self.interactionAttempts++;
    if (recovery) self.recoveryAttempts++;
    self.scheduled=YES; self.scheduledCoalesced=coalesced; self.scheduledInteraction=waiting; self.scheduledRecovery=recovery;
    self.scheduledRefreshDeadline=due;
    [self recordRefreshEvent:@"schedule" delay:delay];
    NSUInteger generation=++self.refreshGeneration;
    NSUInteger epoch=CSCloseFriendAccountEpoch(); NSString *account=CSGroupCurrentAccountID();
    __weak typeof(self) weakSelf=self;
    void (^publish)(void)=^{
        CSGroupListAdapter *self=weakSelf;
        if (!self || generation!=self.refreshGeneration) return;
        self.scheduled=NO; self.scheduledRefreshDeadline=0;
        NSString *currentAccount=CSGroupCurrentAccountID();
        if (epoch!=CSCloseFriendAccountEpoch() || !(account==currentAccount || [account isEqual:currentAccount])) return;
        if (self.dirty) [self refresh];
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
    if (!self.pendingImmediateRefresh) {
        self.coalescingNotification=YES;
        if (!self.pendingRefreshDeadline) self.pendingRefreshDeadline=NSProcessInfo.processInfo.systemUptime+0.08;
    }
    [self recordRefreshEvent:@"notification" delay:0];
    [self scheduleRefresh];
}

- (void)beginNativeChange { [self beginNativeChangeOfKind:CSGroupChangeStructure|CSGroupChangeContent]; }
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind {
    NSSet *names;
    // Generic native/table wrappers inside an attributed event describe that
    // event's work; an explicit unidentifiable notification still passes nil.
    @synchronized (self) { names=self.changeDepth ? self.nativeChangeUserNames : nil; }
    [self beginNativeChangeOfKind:kind sessionUserNames:names];
}
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind sessionUserNames:(NSSet<NSString *> *)names {
    [self invalidateNativeSnapshot];
    BOOL captureAnchor=NO;
    @synchronized (self) {
        self.recoveryPending=NO; self.pendingChanges|=kind; self.dirty=YES;
        // Concurrent native callbacks do not have a shared LIFO identity scope.
        // Keep their model change, and conservatively redraw content if any part
        // of this publication crosses a background callback.
        if (!NSThread.isMainThread) self.pendingContentUnattributed=YES;
        if (!self.nativeChangeIdentityStack) self.nativeChangeIdentityStack=[NSMutableArray array];
        [self.nativeChangeIdentityStack addObject:self.nativeChangeUserNames ?: (id)NSNull.null];
        self.nativeChangeUserNames=[names copy];
        if (kind&CSGroupChangeContent) {
            if (!names) self.pendingContentUnattributed=YES;
            else {
                if (!self.pendingContentUserNames) self.pendingContentUserNames=[NSMutableSet set];
                [self.pendingContentUserNames unionSet:names];
            }
        }
        captureAnchor=!self.changeDepth && NSThread.isMainThread && !self.presentationSuspended && !(self.dirty && self.scheduledCoalesced);
        self.changeDepth++;
    }
    [self recordRefreshEvent:@"native.begin" delay:0];
    // Native/UI reads must not hold the lock used by background notifications.
    if (captureAnchor) [self saveAnchor];
}
- (void)endNativeChange { [self endNativeChangeCoalesced:NO]; }
- (void)endNativeChangeCoalesced:(BOOL)coalesced {
    BOOL outer=NO;
    @synchronized (self) {
        if (self.changeDepth) {
            self.changeDepth--; outer=self.changeDepth==0;
            id previous=self.nativeChangeIdentityStack.lastObject;
            self.nativeChangeUserNames=previous==NSNull.null ? nil : previous;
            [self.nativeChangeIdentityStack removeLastObject];
        }
    }
    if (outer) {
        [self requestTabBadgeSourceRefreshCoalesced:coalesced];
        if (coalesced) [self requestCoalescedRefresh];
        else {
            self.pendingImmediateRefresh=YES; self.coalescingNotification=NO; self.pendingRefreshDeadline=0;
            [self scheduleRefresh];
        }
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
    [self saveAnchor]; self.nativePresentation=YES; [self.table setEditing:NO animated:NO]; [self refresh];
}
- (void)performInNativePresentation:(void (^)(void))action {
    NSString *account=CSGroupCurrentAccountID(); if (!account.length) return;
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    void (^guarded)(void)=^{ if (epoch==CSCloseFriendAccountEpoch() && CSGroupApplicationActive() && [account isEqualToString:CSGroupCurrentAccountID()]) action(); };
    if (CSGroupApplicationActive() && !self.isActive && !self.publishing && !self.changeDepth) { CSGroupWithNativeIndices(self.table,guarded); return; }
    [self pruneNativeActions];
    self.nativeActionsAccount=account;
    [self.nativeActions addObject:[guarded copy]];
    if (!CSGroupApplicationActive()) { self.nativePresentation=YES; self.dirty=YES; return; }
    if (self.publishing) {
        self.nativePresentation=YES; [self requestRefresh]; return;
    }
    if (self.presentationSuspended) {
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
    if (!path) [self requestRecovery]; return path;
}
- (NSIndexPath *)displayPath:(NSIndexPath *)nativePath {
    if (![nativePath isKindOfClass:NSIndexPath.class] || nativePath.length!=2 || ![self accountMatches]) return nil;
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
    if (self.dirty || self.pendingScrollToTop) [self scheduleRefresh];
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
        if ((self.dirty || self.pendingScrollToTop) && ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"])) [self scheduleRefresh];
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
    if (CSGroupInvocationReturnsPath(inv.selector)) {
        __unsafe_unretained NSIndexPath *native=nil; [inv getReturnValue:&native];
        NSIndexPath *display=[self displayPath:native]; [inv setReturnValue:&display]; [inv retainArguments];
    }
    if ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"]) {
        if (self.dirty || self.pendingScrollToTop) [self scheduleRefresh];
    }
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
- (void)saveAnchor {
    if (self.presentationSuspended || !CSGroupApplicationActive()) return;
    if (self.pendingScrollToTop) return;
    if (!self.isActive || !self.publishedTabID) return;
    if (![self hasScrollableContent]) { [self.anchors removeObjectForKey:self.publishedTabID]; return; }
    if (![self canRestoreAnchor]) return;
    __block NSIndexPath *first=nil; __block CGRect rect=CGRectZero;
    CSGroupWithDisplayIndices(self.table, ^{ first=[self.table.indexPathsForVisibleRows sortedArrayUsingSelector:@selector(compare:)].firstObject; if (first) rect=[self.table rectForRowAtIndexPath:first]; });
    CSGroupRow *row=[self.projection rowAtDisplayPath:first];
    if (row.userName.length) self.anchors[self.publishedTabID]=@{@"name":row.userName,@"kind":@(row.kind),@"offset":@(self.table.contentOffset.y+self.table.adjustedContentInset.top-rect.origin.y)};
}
- (void)restoreAnchor {
    if (self.presentationSuspended || !CSGroupApplicationActive()) return;
    if (self.pendingScrollToTop) { [self applyPendingScrollToTop]; return; }
    NSNumber *returnHeight=[self presentationScrollHeight];
    if (returnHeight) { [self restoreScrollHeight:returnHeight.doubleValue]; return; }
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
                    if (isfinite(y) && fabs(target-self.table.contentOffset.y)>0.5)
                        [self.table setContentOffset:CGPointMake(self.table.contentOffset.x,target) animated:NO];
                }); return;
            }
        }
    }
}
- (NSNumber *)presentationScrollHeight {
    NSDictionary *viewport=self.presentationViewport;
    if (!viewport) return nil;
    NSString *account=CSGroupCurrentAccountID();
    if (![viewport[@"account"] isEqual:account] || ![self.preferences.accountID isEqual:account] ||
        [viewport[@"epoch"] unsignedIntegerValue]!=CSCloseFriendAccountEpoch()) {
        self.presentationViewport=nil; return nil;
    }
    if (!self.isActive || !self.chromeVisible || self.searching || self.nativePresentation || self.nativeActions.count) return nil;
    return viewport[@"height"];
}
- (void)restoreViewportFromTab:(NSString *)previousTab scrollHeight:(CGFloat)height {
    NSNumber *returnHeight=[self presentationScrollHeight];
    if (returnHeight) { [self restoreScrollHeight:returnHeight.doubleValue]; return; }
    if (!previousTab.length || !self.publishedTabID.length || [previousTab isEqual:self.publishedTabID] ||
        !self.isActive || !self.chromeVisible || self.searching || self.nativePresentation || self.nativeActions.count || self.pendingScrollToTop) {
        [self restoreAnchor]; return;
    }
    [self restoreScrollHeight:height];
}
- (void)restoreScrollHeight:(CGFloat)height {
    // Switching groups and returning from chat both retain absolute height.
    [self.anchors removeObjectForKey:self.publishedTabID];
    UITableView *table=self.table;
    if (self.presentationSuspended || !CSGroupApplicationActive() || [self groupPanMoving] ||
        table.tracking || table.dragging || table.decelerating || table.editing || self.swipeActive || [self nativeMenuState]) return;
    CGFloat top=table.adjustedContentInset.top, bottom=table.adjustedContentInset.bottom;
    CGFloat viewport=CGRectGetHeight(table.bounds), content=table.contentSize.height;
    if (!isfinite(height) || !isfinite(top) || !isfinite(bottom) || !isfinite(viewport) || !isfinite(content) || viewport<=0) return;
    CGFloat min=-top, max=MAX(min,content-viewport+bottom);
    CGFloat target=MIN(max,MAX(min,MAX(0,height)-top));
    if (!isfinite(max) || !isfinite(target)) return;
    CSGroupWithDisplayIndices(table, ^{
        if (fabs(target-table.contentOffset.y)>0.5)
            [table setContentOffset:CGPointMake(table.contentOffset.x,target) animated:NO];
    });
    [self saveAnchor];
}
- (void)selectIndex:(NSInteger)index {
    if (self.swipeActive || self.table.editing || [self nativeMenuState]) { self.chrome.selectedTabID=self.publishedTabID; return; }
    NSArray *tabs=self.displayedTabs; if (index<0 || index>=(NSInteger)tabs.count) return;
    if (![self.preferences.accountID isEqualToString:CSGroupCurrentAccountID()]) { [self requestRefresh]; return; }
    NSString *tabID=[tabs[(NSUInteger)index] tabId];
    BOOL belongs=[self.preferences.tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab, NSDictionary *bindings) { (void)bindings; return [tab.tabId isEqual:tabID]; }]].count>0;
    // A newer user selection supersedes any queued explicit native navigation.
    [self.nativeActions removeAllObjects];
    self.snapshotRetryAttempted=NO; self.recoveryAttempts=0; self.recoveryPending=NO;
    self.nativePresentation=!belongs; if (belongs) self.preferences.selectedTabID=tabID;
    // Refresh carries the current height across groups. A new selection also
    // supersedes any older explicit top request.
    self.presentationViewport=nil; self.pendingScrollToTop=NO;
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
- (void)returnToGroupTop {
    if (self.presentationSuspended || !CSGroupApplicationActive()) return;
    if (!Option(@"enabled") || !self.chromeVisible || self.searching) return;
    self.presentationViewport=nil; self.pendingScrollToTop=YES;
    if (self.publishedTabID) [self.anchors removeObjectForKey:self.publishedTabID];
    [self.table layoutIfNeeded];
    [self applyPendingScrollToTop];
    [self refreshNavigationTitle];
}
- (void)applyPendingScrollToTop {
    UITableView *table=self.table;
    if (self.presentationSuspended || !CSGroupApplicationActive() || !self.pendingScrollToTop || self.publishing || self.dirty || self.changeDepth || !self.chromeVisible ||
        self.searching || [self groupPanMoving] || table.tracking || table.dragging || table.decelerating || table.editing || self.swipeActive || [self nativeMenuState]) return;
    CGFloat top=table.adjustedContentInset.top;
    if (CGRectGetHeight(table.bounds)<=0 || !isfinite(top)) return;
    self.pendingScrollToTop=NO;
    // Use UIKit's effective top, never the host's transformed contentInset getter.
    CSGroupWithDisplayIndices(table, ^{
        if (fabs(table.contentOffset.y+top)>0.5)
            [table setContentOffset:CGPointMake(table.contentOffset.x,-top) animated:NO];
    });
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
    if (terminal && (self.dirty || self.pendingScrollToTop)) [self scheduleRefresh];
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
