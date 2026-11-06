#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// Explicit plugin preference allowlist. Domains are aliases, never host domain names.
@interface CSBackupRegistry : NSObject
+ (NSArray<NSDictionary *> *)entries;
+ (NSDictionary<NSString *, NSString *> *)moduleTitles;
+ (nullable NSDictionary *)entryForDomain:(NSString *)domain key:(NSString *)key;
+ (BOOL)validateValue:(id)value entry:(NSDictionary *)entry error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
