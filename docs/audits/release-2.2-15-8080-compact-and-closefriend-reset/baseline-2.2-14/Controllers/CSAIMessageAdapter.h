#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSDictionary * _Nullable CSAIEventFromWrap(id wrap, NSString *account, NSString *session);
FOUNDATION_EXPORT NSDictionary * _Nullable CSAIEventFromWrapWithImages(id wrap, NSString *account, NSString *session, BOOL imagesEnabled);
/// Rejects disabled conversations and unmentioned group text before body/identity work.
/// Unmentioned images still reach the coordinator's bounded staging/alias path.
FOUNDATION_EXPORT NSDictionary * _Nullable CSAIEventFromWrapWithConfiguration(id wrap, NSString *account, NSString *session, NSDictionary *configuration);
FOUNDATION_EXPORT void CSAIMarkOwnedSend(id wrap);
FOUNDATION_EXPORT BOOL CSAIIsOwnedSend(id wrap);
NS_ASSUME_NONNULL_END
