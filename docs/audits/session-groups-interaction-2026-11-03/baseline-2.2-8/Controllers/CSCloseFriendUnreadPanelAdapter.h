#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"

#ifdef __cplusplus
extern "C" {
#endif
/// Bind once, before native init can build its first session list.
FOUNDATION_EXPORT void CSCFUnreadPanelBind(id owner);
FOUNDATION_EXPORT BOOL CSCFUnreadPanelIsCurrent(id owner);
FOUNDATION_EXPORT BOOL CSCFUnreadPanelAllowsSession(id owner, id session);
FOUNDATION_EXPORT NSInteger CSCFUnreadPanelNotifyCount(id logic, NSInteger nativeCount);
FOUNDATION_EXPORT void CSCFUnreadPanelTrackController(id controller);
FOUNDATION_EXPORT void CSCFUnreadPanelRefresh(id controller);
FOUNDATION_EXPORT void CSCFUnreadPanelPreparePresentation(id controller);
FOUNDATION_EXPORT void CSCFUnreadPanelInvalidatePresentation(id controller);
FOUNDATION_EXPORT void CSCFUnreadPanelSourceWillChange(id logic);
FOUNDATION_EXPORT void CSCFUnreadPanelSourceDidChange(id logic);
FOUNDATION_EXPORT void CSCFUnreadPanelRecordRow(id controller, NSInteger index);
FOUNDATION_EXPORT id CSCFUnreadPanelCaptureRow(id controller, NSInteger index);
FOUNDATION_EXPORT BOOL CSCFUnreadPanelFinishRow(id controller, NSInteger index, id ticket, id cell);
FOUNDATION_EXPORT BOOL CSCFUnreadPanelAllowsRowAction(id controller, NSInteger index);
FOUNDATION_EXPORT BOOL CSCFUnreadPanelAllowsOpen(id controller, id session);
FOUNDATION_EXPORT void CSCFUnreadPanelPerformRowAction(id controller, NSInteger index, void (^action)(void));
FOUNDATION_EXPORT void CSCFUnreadPanelSetFilteringAvailable(BOOL available);
FOUNDATION_EXPORT void CSCFUnreadPanelInstallHooks(void);
#ifdef __cplusplus
}
#endif
