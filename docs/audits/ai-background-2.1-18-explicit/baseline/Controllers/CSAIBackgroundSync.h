#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// Main-thread scheduler. The caller owns eligibility and the native sync boundary.
@interface CSAIBackgroundSync : NSObject
- (instancetype)initWithEligibility:(BOOL (^)(void))eligibility synchronize:(void (^)(void))synchronize;
@property(nonatomic,copy) NSTimeInterval (^now)(void);
@property(nonatomic,readonly) BOOL active;
- (void)refresh;
- (void)stop;
/// The manager must verify current account/epoch and complete message coverage.
/// An inactive scheduler ignores this signal; this never starts synchronization.
- (void)verifiedFullSyncCompleted;
/// Revoke account/configuration coverage, preserving the last-attempt cooldown.
- (void)invalidateVerifiedSync;
@end
NS_ASSUME_NONNULL_END
