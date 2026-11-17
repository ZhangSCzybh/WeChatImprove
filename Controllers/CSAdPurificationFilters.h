#import "CSAdPurification.h"

NS_ASSUME_NONNULL_BEGIN
#ifdef __cplusplus
extern "C" {
#endif
BOOL CSAdPurificationTextIsAd(id _Nullable text);
/// Returns the input identity when no enabled scope matches.
id _Nullable CSAdPurificationURLString(id _Nullable text, CSAdPurificationScope scopes);
BOOL CSAdPurificationArticleEventIsAd(id _Nullable parameters);
BOOL CSAdPurificationDisallowedBridgeFunction(id _Nullable name);
/// Copy-on-change, bounded traversal; malformed/unbounded input is passed through.
id _Nullable CSAdPurificationProcessObject(id _Nullable object);
/// Only recognized search events/handlers and explicit advertising markers are filtered.
id _Nullable CSAdPurificationSearchResult(id _Nullable event, id _Nullable handlerDescription, id _Nullable result);
#ifdef __cplusplus
}
#endif
NS_ASSUME_NONNULL_END
