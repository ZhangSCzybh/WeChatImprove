#import "../Controllers/CSGroupPerformanceObservation.h"

#if CS_GROUP_PERFORMANCE_OBSERVATION
#import "../Controllers/CSGroupNativeModel.h"
#import "../Controllers/CSGroupNativeSessionCoordinator.h"
#import "../Controllers/CSGroupListAdapter.h"
#import "../Controllers/CSGroupNativeBridge.h"
#import "../Controllers/CSGroupProjection.h"
#import "../Controllers/WESessionTabContainerView.h"

@interface CSGroupNativeSessionCoordinator (PerformanceObservation)
- (void)applyBaselineCandidate;
@end
@interface CSGroupListAdapter (PerformanceObservation)
@property (nonatomic, weak, readonly) id controller;
- (void)refreshNativeSessionModel;
- (void)publishNativeProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                       changes:(CSGroupChangeKind)changes changedUserNames:(NSSet<NSString *> *)changedUserNames
           previouslyProjecting:(BOOL)previouslyProjecting;
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                 changes:(CSGroupChangeKind)changes changedUserNames:(NSSet<NSString *> *)changedUserNames
    previouslyProjecting:(BOOL)previouslyProjecting;
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs
                              selectedTabID:(NSString *)selected accountID:(NSString *)account;
- (NSArray *)nativeSectionsForAccount:(NSString *)account changes:(CSGroupChangeKind)changes
                   changedUserNames:(NSSet<NSString *> *)changedUserNames;
- (void)mergePendingChangeOfKind:(CSGroupChangeKind)kind changedUserNames:(NSSet<NSString *> *)changedUserNames;
@end
@interface WESessionTabContainerView (PerformanceObservation)
@property (nonatomic, copy, readonly) NSArray *renderedTabRecords;
@end

static NSUInteger CSGroupPerformanceAdapterRoute(CSGroupListAdapter *adapter) {
    id owner=adapter.controller;
    Class mainOwner=NSClassFromString(@"NewMainFrameViewController");
    NSUInteger route=0;
    if (adapter.usesNativeSessionModel) route|=CSGroupPerformanceRouteNative;
    if (CSGroupNativeSessionCoordinator.sharedCoordinator.compatibilityFallback) route|=CSGroupPerformanceRouteCompatibilityFallback;
    if (CSGroupIsFoldedController(owner)) route|=CSGroupPerformanceRouteFolded;
    if (mainOwner && [owner isKindOfClass:mainOwner]) route|=CSGroupPerformanceRouteMainOwner;
    if (NSThread.isMainThread) route|=CSGroupPerformanceRouteMainThread;
    UITableView *table=adapter.table;
    if (table && [CSGroupListAdapter adapterForTable:table]==adapter &&
        [CSGroupListAdapter adapterForController:owner]==adapter) route|=CSGroupPerformanceRouteBoundTable;
    return route;
}

static BOOL CSGroupPerformanceAdapterTargetsMain(CSGroupListAdapter *adapter) {
    NSUInteger route=CSGroupPerformanceAdapterRoute(adapter);
    NSUInteger required=CSGroupPerformanceRouteMainOwner|CSGroupPerformanceRouteBoundTable|CSGroupPerformanceRouteMainThread;
    return (route&required)==required && !(route&CSGroupPerformanceRouteFolded);
}

static BOOL CSGroupPerformanceHintIsKnown(NSSet *names, CSGroupChangeKind kind) {
    if (![names isKindOfClass:NSSet.class] || (kind&CSGroupChangeUnknown)) return NO;
    for (id name in names)
        if (![name isKindOfClass:NSString.class] || ![name length]) return NO;
    return YES;
}

%group CSGroupPerformanceObservationHooks
%hook CSGroupNativeModel
+ (CSGroupNativeModelResult *)buildWithTopSessions:(NSArray *)topSessions normalSessions:(NSArray *)normalSessions
    allTopSessions:(NSArray *)allTopSessions allSessions:(NSArray *)allSessions tabs:(NSArray *)tabs
    selectedTabID:(NSString *)selectedTabID groupingEnabled:(BOOL)groupingEnabled filterDuplicates:(BOOL)filterDuplicates
    accountID:(NSString *)accountID hiddenUserNames:(NSSet *)hiddenUserNames privacyRevision:(NSUInteger)privacyRevision
    scopeFoldedEntry:(BOOL)scopeFoldedEntry foldedRows:(NSArray *)foldedRows rowProvider:(CSGroupNativeRowProvider)rowProvider {
    if (!CSGroupPerformanceObservationEnabled()) return %orig;
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceModelFull);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        CSGroupNativeModelResult *result=%orig;
        outcome=result.isValid ? CSGroupPerformanceOutcomeValid : CSGroupPerformanceOutcomeRejected;
        return result;
    } @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
+ (CSGroupNativeModelResult *)modelByUpdatingResult:(CSGroupNativeModelResult *)previous
    changedUserNames:(NSSet *)changedUserNames rowProvider:(CSGroupNativeRowProvider)rowProvider {
    if (!CSGroupPerformanceObservationEnabled()) return %orig;
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceModelDelta);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        CSGroupNativeModelResult *result=%orig;
        outcome=!result ? CSGroupPerformanceOutcomeFallback : (!result.isValid ? CSGroupPerformanceOutcomeRejected :
            (result==previous ? CSGroupPerformanceOutcomeReused : CSGroupPerformanceOutcomeValid));
        return result;
    } @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
+ (CSGroupNativeModelResult *)modelBySelectingTabID:(NSString *)selectedTabID fromResult:(CSGroupNativeModelResult *)previous
    foldedRows:(NSArray *)foldedRows {
    if (!CSGroupPerformanceObservationEnabled()) return %orig;
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceModelSelection);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        CSGroupNativeModelResult *result=%orig;
        outcome=!result ? CSGroupPerformanceOutcomeFallback : (!result.isValid ? CSGroupPerformanceOutcomeRejected :
            (result==previous ? CSGroupPerformanceOutcomeReused : CSGroupPerformanceOutcomeValid));
        return result;
    } @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
%end

%hook CSGroupNativeSessionCoordinator
- (void)applyBaselineCandidate {
    if (!CSGroupPerformanceObservationEnabled()) { %orig; return; }
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceCoordinatorApply);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        %orig;
        outcome=self.model.isValid && !self.boundary ? CSGroupPerformanceOutcomeReady : CSGroupPerformanceOutcomeBoundary;
    } @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
- (void)performChangeForUserNames:(NSSet *)names kind:(CSGroupChangeKind)kind original:(void (^)(void))original {
    // Only hint completeness/kind is emitted. No names or source counts escape.
    if (CSGroupPerformanceObservationEnabled()) {
        BOOL known=CSGroupPerformanceHintIsKnown(names,kind);
        CSGroupPerformanceEmit(known ? CSGroupPerformanceEventKnownChangeHint : CSGroupPerformanceEventUnknownChangeHint,(NSUInteger)kind);
    }
    %orig;
}
%end

%hook CSGroupListAdapter
- (void)mergePendingChangeOfKind:(CSGroupChangeKind)kind changedUserNames:(NSSet *)changedUserNames {
    if (CSGroupPerformanceObservationEnabled()) {
        BOOL known=CSGroupPerformanceHintIsKnown(changedUserNames,kind);
        CSGroupPerformanceEmit(known ? CSGroupPerformanceEventAdapterKnownChangeHint : CSGroupPerformanceEventAdapterUnknownChangeHint,
            (NSUInteger)kind);
    }
    %orig;
}
- (void)refresh {
    if (!CSGroupPerformanceObservationEnabled()) { %orig; return; }
    NSUInteger route=CSGroupPerformanceAdapterRoute(self);
    CSGroupPerformanceEmit(CSGroupPerformanceEventAdapterRoute,route);
    // This outer attempt may adopt the compatibility path during the call.
    // Its duration includes synchronous host work and is not CPU time.
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceRefreshDispatch);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try { %orig; outcome=CSGroupPerformanceOutcomeCompleted; }
    @finally {
        CSGroupPerformanceEnd(token,outcome,0);
        CSGroupPerformanceEmit(CSGroupPerformanceEventAdapterRoute,
            CSGroupPerformanceAdapterRoute(self)|CSGroupPerformanceRouteRefreshExit);
    }
}
- (void)refreshNativeSessionModel {
    if (!CSGroupPerformanceObservationEnabled()) { %orig; return; }
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceAdapterRefresh);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try { %orig; outcome=CSGroupPerformanceOutcomeCompleted; }
    @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
- (void)publishNativeProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                       changes:(CSGroupChangeKind)changes changedUserNames:(NSSet *)changedUserNames
           previouslyProjecting:(BOOL)previouslyProjecting {
    if (!CSGroupPerformanceObservationEnabled()) { %orig; return; }
    UITableView *table=self.table;
    BOOL verified=self.usesNativeSessionModel && CSGroupPerformanceAdapterTargetsMain(self);
    CSGroupPerformancePublicationScope scope={nil,NULL,0};
    CSGroupPerformanceEnterPublication(&scope,verified ? table : nil);
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceAdapterPublication);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        %orig;
        outcome=CSGroupPerformanceOutcomeCompleted;
        if (verified) CSGroupPerformanceEmit(CSGroupPerformanceEventPublicationCompleted,0);
    } @finally {
        CSGroupPerformanceEnd(token,outcome,0);
        CSGroupPerformanceLeavePublication(&scope);
    }
}
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs
                              selectedTabID:(NSString *)selected accountID:(NSString *)account {
    if (!CSGroupPerformanceObservationEnabled()) return %orig;
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceProjectionBuild);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        CSGroupProjection *result=%orig;
        outcome=result.isValid ? CSGroupPerformanceOutcomeValid : CSGroupPerformanceOutcomeRejected;
        return result;
    } @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
- (NSArray *)nativeSectionsForAccount:(NSString *)account changes:(CSGroupChangeKind)changes
                   changedUserNames:(NSSet *)changedUserNames {
    if (!CSGroupPerformanceObservationEnabled()) return %orig;
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceCompatibilitySource);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        NSArray *result=%orig;
        outcome=result ? CSGroupPerformanceOutcomeValid : CSGroupPerformanceOutcomeRejected;
        return result;
    } @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                 changes:(CSGroupChangeKind)changes changedUserNames:(NSSet *)changedUserNames
    previouslyProjecting:(BOOL)previouslyProjecting {
    if (!CSGroupPerformanceObservationEnabled()) { %orig; return; }
    UITableView *table=self.table;
    BOOL verified=!self.usesNativeSessionModel && CSGroupPerformanceAdapterTargetsMain(self);
    CSGroupPerformancePublicationScope scope={nil,NULL,0};
    CSGroupPerformanceEnterPublication(&scope,verified ? table : nil);
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceCompatibilityPublication);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        %orig;
        outcome=CSGroupPerformanceOutcomeCompleted;
        if (verified) CSGroupPerformanceEmit(CSGroupPerformanceEventPublicationCompleted,0);
    } @finally {
        CSGroupPerformanceEnd(token,outcome,0);
        CSGroupPerformanceLeavePublication(&scope);
    }
}
- (void)layout {
    if (!CSGroupPerformanceObservationEnabled()) { %orig; return; }
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceAdapterLayout);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try { %orig; outcome=CSGroupPerformanceOutcomeCompleted; }
    @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
%end

%hook UITableView
- (void)reloadData {
    if (!CSGroupPerformanceObservesReload(self,NO) || !CSGroupPerformanceObservationEnabled()) { %orig; return; }
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceTableReloadData);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try { %orig; outcome=CSGroupPerformanceOutcomeCompleted; CSGroupPerformanceEmit(CSGroupPerformanceEventTableReloadDataCompleted,0); }
    @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation {
    if (!CSGroupPerformanceObservesReload(self,YES) || !CSGroupPerformanceObservationEnabled()) { %orig; return; }
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceTableReloadRows);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try { %orig; outcome=CSGroupPerformanceOutcomeCompleted; CSGroupPerformanceEmit(CSGroupPerformanceEventTableReloadRowsCompleted,paths.count); }
    @finally { CSGroupPerformanceEnd(token,outcome,paths.count); }
}
%end

%hook WESessionTabContainerView
- (void)updateTabs:(NSArray *)tabs {
    if (!CSGroupPerformanceObservationEnabled()) { %orig; return; }
    NSArray *before=self.renderedTabRecords;
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceTabRecordsUpdate);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try {
        %orig;
        BOOL rebuilt=self.renderedTabRecords!=before;
        outcome=rebuilt ? CSGroupPerformanceOutcomeCompleted : CSGroupPerformanceOutcomeUnchanged;
        if (rebuilt) CSGroupPerformanceEmit(CSGroupPerformanceEventTabRecordsRebuilt,0);
    } @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
- (void)layoutSubviews {
    if (!CSGroupPerformanceObservationEnabled()) { %orig; return; }
    CSGroupPerformanceToken token=CSGroupPerformanceBegin(CSGroupPerformanceTabLayout);
    CSGroupPerformanceOutcome outcome=CSGroupPerformanceOutcomeException;
    @try { %orig; outcome=CSGroupPerformanceOutcomeCompleted; }
    @finally { CSGroupPerformanceEnd(token,outcome,0); }
}
%end
%end

%ctor {
    %init(CSGroupPerformanceObservationHooks);
}
#endif
