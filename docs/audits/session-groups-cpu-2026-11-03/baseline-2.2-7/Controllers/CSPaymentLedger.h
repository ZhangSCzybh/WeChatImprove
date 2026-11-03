#import <Foundation/Foundation.h>
FOUNDATION_EXPORT NSString * _Nonnull const CSPaymentStatisticsDidChangeNotification;
NS_ASSUME_NONNULL_BEGIN
@interface CSPaymentLedger : NSObject
@property(nonatomic, readonly) BOOL ready;
@property(nonatomic, readonly) NSDictionary *totals;
- (instancetype)initWithURL:(NSURL *)url defaults:(NSUserDefaults *)defaults;
- (void)load:(dispatch_block_t)completion;
- (BOOL)containsKey:(NSString *)key;
- (void)recordKey:(NSString *)key envelope:(BOOL)envelope cents:(long long)cents currency:(NSString *)currency completion:(void (^)(BOOL))completion;
- (void)resetEnvelopes:(dispatch_block_t)completion;
@end
NS_ASSUME_NONNULL_END
