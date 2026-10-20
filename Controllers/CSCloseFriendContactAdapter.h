#import "CSCloseFriendBridge.h"
#import "CSCloseFriendContactProjection.h"
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT NSArray *CSCFVisible(NSArray *source, CSCloseFriendSurface surface);
FOUNDATION_EXPORT BOOL CSCFIsClass(id object, NSString *className);
FOUNDATION_EXPORT BOOL CSCFCallVoid(id object, NSString *selector);
FOUNDATION_EXPORT BOOL CSCFSetObject(id object, NSString *selector, id value);
FOUNDATION_EXPORT void CSCFTrackSurface(id owner, NSString *refreshSelector);
FOUNDATION_EXPORT void CSCFReloadTables(id owner);
FOUNDATION_EXPORT BOOL CSCFContactLogicSurface(id logic, CSCloseFriendSurface *surface);
FOUNDATION_EXPORT BOOL CSCFPageIsCurrent(id owner);
FOUNDATION_EXPORT void CSCFForwardSearchWillUpdate(id owner);
FOUNDATION_EXPORT void CSCFForwardSearchDidUpdate(id owner);
FOUNDATION_EXPORT void CSCFRefreshForwardSearch(id owner);
FOUNDATION_EXPORT void CSCFBeginSelection(id owner);
FOUNDATION_EXPORT BOOL CSCFAllowSelection(id owner, NSArray *recipients);
FOUNDATION_EXPORT void CSCFCancelSelection(id owner);
/// Stops the current operation. Successful authentication asks user to repeat on native full data.
FOUNDATION_EXPORT BOOL CSCFRequireTagAuthentication(id owner);
FOUNDATION_EXPORT void CSCFUpdateTagSummary(id cell,id tag);
FOUNDATION_EXPORT void CSCFUpdateTagDetail(id owner);
#ifdef __cplusplus
}
#endif
