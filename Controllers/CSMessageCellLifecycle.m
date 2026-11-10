#import "CSMessageCellLifecycle.h"
#import "CSMessageGestureAdapter.h"
#import "CSMessageMergeAdapter.h"
#import "CSClownPresentation.h"
#import "CSVoicePlaybackOverlay.h"
#import <objc/runtime.h>
static char CSLifecycleKey;
@interface CSMessageCellLifecycleState : NSObject
@property(nonatomic) NSUInteger layoutDepth, bindingDepth, reuseDepth;
@end
@implementation CSMessageCellLifecycleState @end
static CSMessageCellLifecycleState *CSLifecycle(id cell) {
    CSMessageCellLifecycleState *state=objc_getAssociatedObject(cell,&CSLifecycleKey);
    if (!state) { state=[CSMessageCellLifecycleState new]; objc_setAssociatedObject(cell,&CSLifecycleKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
    return state;
}
void CSMessageCellPerformLayout(id cell, void (^native)(void)) {
    CSMessageCellLifecycleState *state=CSLifecycle(cell);
    // Native setters/reuse may synchronously lay out an intermediate binding.
    // Their outer boundary already detached/restored, and owns final preparation.
    if (state.bindingDepth || state.reuseDepth) { native(); return; }
    BOOL outer=state.layoutDepth++==0;
    CSMessageGestureAdapter *adapter=CSMessageGestureAdapterForCell(cell,YES);
    if (outer) { [adapter detachForLayout]; CSClownRestoreCell(cell); CSMessageMergeRestore(cell); }
    @try { native(); }
    @finally {
        state.layoutDepth--;
        if (outer) {
            CSMessageTimePrepareCell(cell);
            CSMessageMergeRender(cell); // merge owns final time positioning, active or inactive
            CSClownRenderCell(cell);
            [adapter refreshForLayout]; [adapter reattachAfterLayout];
            CSVoicePlaybackRefreshCell(cell);
        }
    }
}
void CSMessageCellPerformBinding(id cell, id model, void (^native)(void)) {
    CSMessageCellLifecycleState *state=CSLifecycle(cell);
    BOOL outer=state.bindingDepth++==0;
    CSMessageGestureAdapter *adapter=CSMessageGestureAdapterForCell(cell,NO);
    BOOL changed=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"viewModel"))!=model;
    if (outer) {
        CSVoicePlaybackDetachCell(cell);
        CSClownReuseCell(cell); [adapter invalidateBinding]; CSMessageMergeReuse(cell);
        if (changed) CSMessageTimeResetCell(cell);
    }
    @try { native(); }
    @finally {
        state.bindingDepth--;
        if (outer && !state.reuseDepth) { [adapter bind]; CSMessageCellRefresh(cell); }
    }
}
void CSMessageCellPerformReuse(id cell, void (^native)(void)) {
    CSMessageCellLifecycleState *state=CSLifecycle(cell);
    BOOL outer=state.reuseDepth++==0;
    if (outer) { CSVoicePlaybackDetachCell(cell); CSClownReuseCell(cell); [CSMessageGestureAdapterForCell(cell,NO) invalidateBinding]; CSMessageMergeReuse(cell); CSMessageTimeResetCell(cell); }
    @try { native(); }
    @finally { state.reuseDepth--; }
}
void CSMessageCellRefresh(id cell) {
    // Native setters may request layout synchronously. Let the outer layout own final geometry.
    CSMessageCellLifecycleState *state=CSLifecycle(cell);
    if (state.layoutDepth || state.bindingDepth || state.reuseDepth) return;
    CSMessageGestureAdapter *adapter=CSMessageGestureAdapterForCell(cell,YES);
    [adapter detachForLayout]; CSClownRestoreCell(cell); CSMessageTimePrepareCell(cell); CSMessageMergeRender(cell); CSClownRenderCell(cell);
    [adapter refreshForLayout]; [adapter reattachAfterLayout];
    CSVoicePlaybackRefreshCell(cell);
}
void CSMessageCellWindowChanged(id cell) {
    if (![(UIView *)cell window]) { CSVoicePlaybackDetachCell(cell); [CSMessageGestureAdapterForCell(cell,NO) cancel]; }
    else {
        CSMessageGestureAdapter *adapter=CSMessageGestureAdapterForCell(cell,NO);
        if (adapter) [adapter bind];
        else CSMessageGestureAdapterForCell(cell,YES); // A new adapter binds in its initializer.
        CSMessageCellRefresh(cell);
    }
}
