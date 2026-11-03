#import "CSGroupPerformanceObservation.h"

#if CS_GROUP_PERFORMANCE_OBSERVATION
#import <objc/runtime.h>

static os_log_t CSGroupPerformanceLog(void) {
    static os_log_t log;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        log=os_log_create("com.wechatimprove.performance", "SessionGroups");
    });
    return log;
}

BOOL CSGroupPerformanceObservationEnabled(void) {
    return os_signpost_enabled(CSGroupPerformanceLog());
}

// Names must remain compile-time literals for signpost tooling. There are no
// user strings or per-invocation string/array/dictionary allocations here.
#define CS_GROUP_OPERATION_CASE(operationValue, literalName, action) \
    case operationValue: action(log, identifier, literalName); break

CSGroupPerformanceToken CSGroupPerformanceBegin(CSGroupPerformanceOperation operation) {
    os_log_t log=CSGroupPerformanceLog();
    CSGroupPerformanceToken token={OS_SIGNPOST_ID_INVALID,operation};
    if (!os_signpost_enabled(log)) return token;
    os_signpost_id_t identifier=os_signpost_id_generate(log);
    token.identifier=identifier;
    switch (operation) {
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceModelFull, "ModelFull", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceModelDelta, "ModelDelta", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceModelSelection, "ModelSelection", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceCoordinatorApply, "CoordinatorApply", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceAdapterRefresh, "AdapterRefreshAttempt", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceAdapterPublication, "AdapterPublication", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceTableReloadData, "MainTableReloadData", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceTableReloadRows, "MainTableReloadRows", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceTabRecordsUpdate, "TabRecordsUpdateAttempt", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceTabLayout, "TabLayout", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceRefreshDispatch, "AdapterRefreshDispatchAttempt", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceProjectionBuild, "AdapterProjectionBuild", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceCompatibilityPublication, "CompatibilityPublication", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceAdapterLayout, "AdapterLayoutAttempt", os_signpost_interval_begin);
        CS_GROUP_OPERATION_CASE(CSGroupPerformanceCompatibilitySource, "CompatibilitySourceSnapshot", os_signpost_interval_begin);
    }
    return token;
}
#undef CS_GROUP_OPERATION_CASE

void CSGroupPerformanceEnd(CSGroupPerformanceToken token, CSGroupPerformanceOutcome outcome, NSUInteger units) {
    if (token.identifier==OS_SIGNPOST_ID_INVALID) return;
    os_log_t log=CSGroupPerformanceLog();
    os_signpost_id_t identifier=token.identifier;
#define CS_GROUP_END_CASE(operationValue, literalName) \
    case operationValue: os_signpost_interval_end(log,identifier,literalName,"outcome=%{public}u units=%{public}lu",(unsigned)outcome,(unsigned long)units); break
    switch (token.operation) {
        CS_GROUP_END_CASE(CSGroupPerformanceModelFull, "ModelFull");
        CS_GROUP_END_CASE(CSGroupPerformanceModelDelta, "ModelDelta");
        CS_GROUP_END_CASE(CSGroupPerformanceModelSelection, "ModelSelection");
        CS_GROUP_END_CASE(CSGroupPerformanceCoordinatorApply, "CoordinatorApply");
        CS_GROUP_END_CASE(CSGroupPerformanceAdapterRefresh, "AdapterRefreshAttempt");
        CS_GROUP_END_CASE(CSGroupPerformanceAdapterPublication, "AdapterPublication");
        CS_GROUP_END_CASE(CSGroupPerformanceTableReloadData, "MainTableReloadData");
        CS_GROUP_END_CASE(CSGroupPerformanceTableReloadRows, "MainTableReloadRows");
        CS_GROUP_END_CASE(CSGroupPerformanceTabRecordsUpdate, "TabRecordsUpdateAttempt");
        CS_GROUP_END_CASE(CSGroupPerformanceTabLayout, "TabLayout");
        CS_GROUP_END_CASE(CSGroupPerformanceRefreshDispatch, "AdapterRefreshDispatchAttempt");
        CS_GROUP_END_CASE(CSGroupPerformanceProjectionBuild, "AdapterProjectionBuild");
        CS_GROUP_END_CASE(CSGroupPerformanceCompatibilityPublication, "CompatibilityPublication");
        CS_GROUP_END_CASE(CSGroupPerformanceAdapterLayout, "AdapterLayoutAttempt");
        CS_GROUP_END_CASE(CSGroupPerformanceCompatibilitySource, "CompatibilitySourceSnapshot");
    }
#undef CS_GROUP_END_CASE
}

void CSGroupPerformanceEmit(CSGroupPerformanceEvent event, NSUInteger units) {
    os_log_t log=CSGroupPerformanceLog();
    if (!os_signpost_enabled(log)) return;
#define CS_GROUP_EVENT_CASE(eventValue, literalName) \
    case eventValue: os_signpost_event_emit(log,OS_SIGNPOST_ID_EXCLUSIVE,literalName,"units=%{public}lu",(unsigned long)units); break
    switch (event) {
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventTargetVerified, "MainTableTargetVerified");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventTargetUnavailable, "MainTableTargetUnavailable");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventReloadDispatchUnverified, "ReloadDispatchUnverified");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventPublicationCompleted, "PublicationCompleted");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventTableReloadDataCompleted, "ReloadDataCompleted");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventTableReloadRowsCompleted, "ReloadRowsCompleted");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventTabRecordsRebuilt, "TabRecordsRebuilt");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventKnownChangeHint, "KnownChangeHint");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventUnknownChangeHint, "UnknownChangeHint");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventAdapterRoute, "AdapterRoute");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventAdapterKnownChangeHint, "AdapterKnownChangeHint");
        CS_GROUP_EVENT_CASE(CSGroupPerformanceEventAdapterUnknownChangeHint, "AdapterUnknownChangeHint");
    }
#undef CS_GROUP_EVENT_CASE
}

static __thread CSGroupPerformancePublicationScope *CSGroupPerformanceCurrentPublication;

static BOOL CSGroupPerformanceHasBaseReloadDispatch(UITableView *table, SEL selector) {
    Method effective=class_getInstanceMethod(object_getClass(table),selector);
    Method base=class_getInstanceMethod(UITableView.class,selector);
    return effective && base && method_getImplementation(effective)==method_getImplementation(base);
}

void CSGroupPerformanceEnterPublication(CSGroupPerformancePublicationScope *scope, UITableView *table) {
    scope->previous=CSGroupPerformanceCurrentPublication;
    scope->table=NSThread.isMainThread ? table : nil;
    scope->verifiedReloadDispatch=0;
    if (scope->table) {
        if (CSGroupPerformanceHasBaseReloadDispatch(table,@selector(reloadData))) scope->verifiedReloadDispatch|=1;
        if (CSGroupPerformanceHasBaseReloadDispatch(table,@selector(reloadRowsAtIndexPaths:withRowAnimation:))) scope->verifiedReloadDispatch|=2;
        CSGroupPerformanceEmit(CSGroupPerformanceEventTargetVerified,scope->verifiedReloadDispatch);
        if (scope->verifiedReloadDispatch!=3)
            CSGroupPerformanceEmit(CSGroupPerformanceEventReloadDispatchUnverified,scope->verifiedReloadDispatch);
    } else CSGroupPerformanceEmit(CSGroupPerformanceEventTargetUnavailable,0);
    CSGroupPerformanceCurrentPublication=scope;
}

void CSGroupPerformanceLeavePublication(CSGroupPerformancePublicationScope *scope) {
    CSGroupPerformanceCurrentPublication=scope->previous;
    scope->table=nil;
}

BOOL CSGroupPerformanceObservesReload(UITableView *table, BOOL rows) {
    CSGroupPerformancePublicationScope *scope=CSGroupPerformanceCurrentPublication;
    return scope && scope->table==table && (scope->verifiedReloadDispatch&(rows ? 2 : 1));
}
#endif
