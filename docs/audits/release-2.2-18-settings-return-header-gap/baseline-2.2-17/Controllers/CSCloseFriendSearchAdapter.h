#import "CSCloseFriendContactAdapter.h"
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT void CSCFSearchBegin(id section);
FOUNDATION_EXPORT id CSCFSearchModel(id row);
FOUNDATION_EXPORT NSArray *CSCFSearchVisibleRows(NSArray *rows);
FOUNDATION_EXPORT void CSCFSearchWillUpdate(id section);
FOUNDATION_EXPORT void CSCFSearchDidUpdate(id section,NSString *arrayKey);
FOUNDATION_EXPORT BOOL CSCFSearchPrepare(id section);
FOUNDATION_EXPORT void CSCFSearchDidRender(id section);
FOUNDATION_EXPORT BOOL CSCFSearchAllowsSelection(id section);
FOUNDATION_EXPORT BOOL CSCFSearchGated(id section);
FOUNDATION_EXPORT BOOL CSCFSearchRedactsGroupMatch(id contact);
FOUNDATION_EXPORT void CSCFSearchUpdateGroupCell(id cell,id item);
FOUNDATION_EXPORT BOOL CSCFSearchSuppressLoading(id page);
FOUNDATION_EXPORT void CSCFSearchClearResults(id page);
FOUNDATION_EXPORT BOOL CSCFSearchHasMarkedText(id range);
FOUNDATION_EXPORT void CSCFSearchDispatchInput(id page,id input,BOOL composing,void (^native)(void));
FOUNDATION_EXPORT void CSCFSearchDispatchQuery(id page,id input,void (^native)(void));
FOUNDATION_EXPORT void CSCFSearchSubmit(id page,void (^native)(void));
#ifdef __cplusplus
}
#endif
