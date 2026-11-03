#import <UIKit/UIKit.h>
FOUNDATION_EXPORT BOOL CSMessageNavigateToRevoke(id controller, id messageManager, NSString *session, long long serverID);
FOUNDATION_EXPORT void CSMessageNavigationCheck(id controller);
FOUNDATION_EXPORT void CSMessageNavigationFinishedLoading(id controller);
FOUNDATION_EXPORT void CSMessageNavigationFailed(id controller);
FOUNDATION_EXPORT void CSMessageNavigationCancel(id controller);
FOUNDATION_EXPORT BOOL CSMessageNavigationIsActive(id controller);

FOUNDATION_EXPORT void CSMessageNavigationBind(id controller, UITableView *table, NSIndexPath *path, id cell);
FOUNDATION_EXPORT BOOL CSMessageHandleRevokeLink(id source, id manager, id clickedLink, id explicitWrap);
FOUNDATION_EXPORT void CSMessageNavigationLayoutReady(id controller);

FOUNDATION_EXPORT void CSMessageNavigationContentChanged(id controller);
