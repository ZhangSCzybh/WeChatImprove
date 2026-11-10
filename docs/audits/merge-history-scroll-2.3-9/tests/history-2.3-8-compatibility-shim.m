// Test-only compatibility shim for the frozen 2.3-8 adapter.
// Preserve old raw-height semantics while allowing the new regression to execute.
#import "CSMessageMergeAdapter.h"
void CSMessageMergeBeginHistory(id controller) { CSMessageMergeWillMutate(controller); }
void CSMessageMergeEndHistory(id controller) { CSMessageMergeDidMutate(controller); }
unsigned long long CSMessageMergeHistoryContentHeight(id controller,unsigned long long nativeHeight) { return nativeHeight; }
