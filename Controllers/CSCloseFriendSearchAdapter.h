#import "CSCloseFriendContactAdapter.h"
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT void CSCFSearchBegin(id section);
FOUNDATION_EXPORT void CSCFSearchDidUpdate(id section,NSString *arrayKey);
FOUNDATION_EXPORT BOOL CSCFSearchPrepare(id section);
FOUNDATION_EXPORT void CSCFSearchDidRender(id section);
FOUNDATION_EXPORT BOOL CSCFSearchAllowsSelection(id section);
FOUNDATION_EXPORT BOOL CSCFSearchGated(id section);
FOUNDATION_EXPORT void CSCFSearchUpdateGroupCell(id cell,id item);
FOUNDATION_EXPORT UITableViewCell *CSCFSearchUnlockCell(void);
FOUNDATION_EXPORT void CSCFSearchUnlock(id section);
#ifdef __cplusplus
}
#endif
