#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/// Read-only conversion. Never interprets imported paths as local write targets.
@interface CSBackupLegacyReader : NSObject
+ (nullable NSDictionary *)readURL:(NSURL *)url standardDomain:(NSString *)domain error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
