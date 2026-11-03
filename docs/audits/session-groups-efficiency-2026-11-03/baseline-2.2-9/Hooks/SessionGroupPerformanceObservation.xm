#import "../Controllers/CSGroupPerformanceObservation.h"

#if CS_GROUP_PERFORMANCE_OBSERVATION
#import "../Controllers/CSGroupNativeModel.h"
#import "../Controllers/CSGroupNativeSessionCoordinator.h"
#import "../Controllers/CSGroupListAdapter.h"
#import "../Controllers/WESessionTabContainerView.h"

@interface CSGroupNativeSessionCoordinator (PerformanceObservation)
- (void)applyBaselineCandidate;
@end
@interface CSGroupListAdapter (PerformanceObservation)
- (void)refreshNativeSessionModel;
- (void)publishNativeProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
                       changes:(CSGroupChangeKind)changes changedUserNames:(NSSet<NSString *> *)changedUserNames
           previouslyProjecting:(BOOL)previouslyProjecting;
@end
@interface WESessionTabContainerView (PerformanceObservation)
@property (nonatomic, copy, readonly) NSArray *renderedTabRecords;
@end

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
    if (CSGroupPerformanceObservationEnabled())
        CSGroupPerformanceEmit(names ? CSGroupPerformanceEventKnownChangeHint : CSGroupPerformanceEventUnknownChangeHint,(NSUInteger)kind);
    %orig;
}
%end

%hook CSGroupListAdapter
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
    BOOL verified=self.usesNativeSessionModel && table && [CSGroupListAdapter adapterForTable:table]==self;
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
