#pragma once

// The release build does not declare, link or execute an observation API.
#ifndef CS_GROUP_PERFORMANCE_OBSERVATION
#define CS_GROUP_PERFORMANCE_OBSERVATION 0
#endif

#if CS_GROUP_PERFORMANCE_OBSERVATION
#import <UIKit/UIKit.h>
#import <os/signpost.h>

typedef NS_ENUM(uint8_t, CSGroupPerformanceOperation) {
    CSGroupPerformanceModelFull,
    CSGroupPerformanceModelDelta,
    CSGroupPerformanceModelSelection,
    CSGroupPerformanceCoordinatorApply,
    CSGroupPerformanceAdapterRefresh,
    CSGroupPerformanceAdapterPublication,
    CSGroupPerformanceTableReloadData,
    CSGroupPerformanceTableReloadRows,
    CSGroupPerformanceTabRecordsUpdate,
    CSGroupPerformanceTabLayout,
    CSGroupPerformanceRefreshDispatch,
    CSGroupPerformanceProjectionBuild,
    CSGroupPerformanceCompatibilityPublication,
    CSGroupPerformanceAdapterLayout,
    CSGroupPerformanceCompatibilitySource,
};

typedef NS_ENUM(uint8_t, CSGroupPerformanceOutcome) {
    CSGroupPerformanceOutcomeException = 0,
    CSGroupPerformanceOutcomeCompleted = 1,
    CSGroupPerformanceOutcomeValid = 2,
    CSGroupPerformanceOutcomeRejected = 3,
    CSGroupPerformanceOutcomeFallback = 4,
    CSGroupPerformanceOutcomeReused = 5,
    CSGroupPerformanceOutcomeReady = 6,
    CSGroupPerformanceOutcomeBoundary = 7,
    CSGroupPerformanceOutcomeUnchanged = 8,
};

typedef NS_ENUM(uint8_t, CSGroupPerformanceEvent) {
    CSGroupPerformanceEventTargetVerified,
    CSGroupPerformanceEventTargetUnavailable,
    CSGroupPerformanceEventReloadDispatchUnverified,
    CSGroupPerformanceEventPublicationCompleted,
    CSGroupPerformanceEventTableReloadDataCompleted,
    CSGroupPerformanceEventTableReloadRowsCompleted,
    CSGroupPerformanceEventTabRecordsRebuilt,
    CSGroupPerformanceEventKnownChangeHint,
    CSGroupPerformanceEventUnknownChangeHint,
    CSGroupPerformanceEventAdapterRoute,
    CSGroupPerformanceEventAdapterKnownChangeHint,
    CSGroupPerformanceEventAdapterUnknownChangeHint,
};

// Fixed flags only: no account, identity, message or host object is emitted.
typedef NS_OPTIONS(NSUInteger, CSGroupPerformanceRoute) {
    CSGroupPerformanceRouteNative = 1UL << 0,
    CSGroupPerformanceRouteCompatibilityFallback = 1UL << 1,
    CSGroupPerformanceRouteFolded = 1UL << 2,
    CSGroupPerformanceRouteMainOwner = 1UL << 3,
    CSGroupPerformanceRouteBoundTable = 1UL << 4,
    CSGroupPerformanceRouteRefreshExit = 1UL << 5,
    CSGroupPerformanceRouteMainThread = 1UL << 6,
};

typedef struct {
    os_signpost_id_t identifier;
    CSGroupPerformanceOperation operation;
} CSGroupPerformanceToken;

// Stack-owned, synchronous scopes nest without retaining a host table. A scope
// never survives its caller's finally block or propagates to another queue.
typedef struct CSGroupPerformancePublicationScope {
    __unsafe_unretained UITableView *table;
    struct CSGroupPerformancePublicationScope *previous;
    uint8_t verifiedReloadDispatch;
} CSGroupPerformancePublicationScope;

FOUNDATION_EXPORT BOOL CSGroupPerformanceObservationEnabled(void);
FOUNDATION_EXPORT CSGroupPerformanceToken CSGroupPerformanceBegin(CSGroupPerformanceOperation operation);
FOUNDATION_EXPORT void CSGroupPerformanceEnd(CSGroupPerformanceToken token, CSGroupPerformanceOutcome outcome, NSUInteger units);
FOUNDATION_EXPORT void CSGroupPerformanceEmit(CSGroupPerformanceEvent event, NSUInteger units);
FOUNDATION_EXPORT void CSGroupPerformanceEnterPublication(CSGroupPerformancePublicationScope *scope, UITableView *table);
FOUNDATION_EXPORT void CSGroupPerformanceLeavePublication(CSGroupPerformancePublicationScope *scope);
FOUNDATION_EXPORT BOOL CSGroupPerformanceObservesReload(UITableView *table, BOOL rows);
#endif
