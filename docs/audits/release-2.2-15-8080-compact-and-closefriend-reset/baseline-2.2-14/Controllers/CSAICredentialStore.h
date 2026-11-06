#import <Foundation/Foundation.h>
#import "CSAIClient.h"
NS_ASSUME_NONNULL_BEGIN
/// Versioned immutable slots permit atomic configuration activation after a Keychain write.
FOUNDATION_EXPORT NSString * _Nullable CSAIReadCredential(NSString *account, NSString *revision, NSError **error);
/// Reads on a dedicated worker, coalescing only in-flight reads of the same immutable slot.
/// Completion is delivered once on main; cancelling one reader leaves other readers intact.
FOUNDATION_EXPORT id<CSAICancellable> CSAIReadCredentialAsync(NSString *account, NSString *revision, CSAICompletion completion);
FOUNDATION_EXPORT BOOL CSAIWriteCredential(NSString *account, NSString *revision, NSString *key, NSError **error);
FOUNDATION_EXPORT void CSAIRemoveCredential(NSString *account, NSString *revision);
NS_ASSUME_NONNULL_END
