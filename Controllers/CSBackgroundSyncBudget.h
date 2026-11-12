#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Main-thread budget shared by independent background-sync request sources.
/// Attempt timestamps survive account changes. Verified coverage belongs only
/// to the current account epoch. Default callers retain the 45-second interval.
/// This class never starts a timer.
@interface CSBackgroundSyncBudget : NSObject
+ (instancetype)sharedBudget;
@property(nonatomic,copy) NSTimeInterval (^now)(void);
/// Zero permits an attempt now. Invalid/stale epochs, a nonfinite clock or a
/// clock regression fail closed with a positive delay.
- (NSTimeInterval)nextDelayForEpoch:(NSUInteger)epoch;
/// Uses the same shared timestamps with a caller-selected interval of 10–45
/// seconds. An invalid interval returns a conservative 45-second delay.
- (NSTimeInterval)nextDelayForEpoch:(NSUInteger)epoch minimumInterval:(NSTimeInterval)minimumInterval;
/// Reserves the cooldown before invoking request, including reentrant calls.
/// A refused request does not run. Native exceptions propagate and retain the
/// reserved attempt budget. Returns YES when the block was invoked.
- (BOOL)performForEpoch:(NSUInteger)epoch request:(void (^)(void))request;
/// Reserves the caller-selected 10–45 second interval before invoking request.
/// Invalid intervals are refused without invoking request or resetting history.
- (BOOL)performForEpoch:(NSUInteger)epoch minimumInterval:(NSTimeInterval)minimumInterval request:(void (^)(void))request;
/// Extends current-epoch coverage without requesting synchronization.
- (void)verifiedFullSyncForEpoch:(NSUInteger)epoch;
@end

NS_ASSUME_NONNULL_END
