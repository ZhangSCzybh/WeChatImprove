#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface CSBackupAssets : NSObject
+ (nullable NSArray<NSDictionary *> *)captureFields:(NSArray<NSDictionary *> *)fields root:(NSURL *)root assets:(NSMutableDictionary<NSString *,NSData *> *)assets error:(NSError **)error;
/// Reset protection only: records missing files explicitly. Existing unreadable/invalid files still fail.
+ (nullable NSArray<NSDictionary *> *)captureFields:(NSArray<NSDictionary *> *)fields root:(NSURL *)root assets:(NSMutableDictionary<NSString *,NSData *> *)assets missing:(nullable NSMutableArray<NSDictionary *> *)missing error:(NSError **)error;
+ (nullable NSArray<NSDictionary *> *)materializeFields:(NSArray<NSDictionary *> *)fields assets:(NSDictionary<NSString *,NSData *> *)assets root:(NSURL *)root writes:(NSMutableDictionary *)writes error:(NSError **)error;
/// Freeze resource bytes before validation/sealing; no verification result survives the call.
+ (nullable NSDictionary *)immutableAssets:(NSDictionary *)assets error:(NSError **)error;
+ (BOOL)validImage:(NSData *)data;
@end
NS_ASSUME_NONNULL_END
