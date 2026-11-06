#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Extracts profile metadata; this does not verify the CMS signature or trust.
FOUNDATION_EXPORT NSDictionary * _Nullable CSProvisioningProfileDictionaryFromData(NSData * _Nullable data);

NS_ASSUME_NONNULL_END
