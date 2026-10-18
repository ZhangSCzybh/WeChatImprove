#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
// Settings UI facade. Automation uses its own immutable, main-queue snapshot.
@interface CSRedEnvelopConfig : NSObject
+ (instancetype)sharedConfig;
- (void)reload;
@property(nonatomic, readonly) BOOL receiveDonePageSummaryEnable;
@property(nonatomic, readonly) NSInteger totalReceiveCount;
@property(nonatomic, readonly) long long totalReceiveAmount;
- (void)resetReceiveRecordsWithCompletion:(dispatch_block_t)completion;
@end
NS_ASSUME_NONNULL_END
