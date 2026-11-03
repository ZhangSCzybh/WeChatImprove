#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSError *CSBackupFailure(NSString *message);
FOUNDATION_EXPORT const NSUInteger CSBackupMaximumFileSize;
@interface CSBackupCodec : NSObject
+ (nullable NSData *)encode:(NSDictionary *)snapshot error:(NSError **)error;
+ (nullable NSDictionary *)decode:(NSData *)data error:(NSError **)error;
+ (NSString *)digest:(id)value;
@end
NS_ASSUME_NONNULL_END
