#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSDictionary * _Nullable CSAIEventFromWrap(id wrap, NSString *account, NSString *session);
FOUNDATION_EXPORT NSDictionary * _Nullable CSAIEventFromWrapWithImages(id wrap, NSString *account, NSString *session, BOOL imagesEnabled);
FOUNDATION_EXPORT void CSAIMarkOwnedSend(id wrap);
FOUNDATION_EXPORT BOOL CSAIIsOwnedSend(id wrap);
NS_ASSUME_NONNULL_END
