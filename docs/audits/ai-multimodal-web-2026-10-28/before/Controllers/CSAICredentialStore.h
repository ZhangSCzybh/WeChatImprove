#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/// Versioned immutable slots permit atomic configuration activation after a Keychain write.
FOUNDATION_EXPORT NSString * _Nullable CSAIReadCredential(NSString *account, NSString *revision, NSError **error);
FOUNDATION_EXPORT BOOL CSAIWriteCredential(NSString *account, NSString *revision, NSString *key, NSError **error);
FOUNDATION_EXPORT void CSAIRemoveCredential(NSString *account, NSString *revision);
NS_ASSUME_NONNULL_END
