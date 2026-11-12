#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Main-thread budget shared by independent background-sync request sources.
/// The 45-second attempt cooldown survives account changes. Verified coverage
/// belongs only to the current account epoch. This class never starts a timer.
@interface CSBackgroundSyncBudget : NSObject
+ (instancetype)sharedBudget;
@property(nonatomic,copy) NSTimeInterval (^now)(void);
/// Zero permits an attempt now. Invalid/stale epochs, a nonfinite clock or a
/// clock regression fail closed with a positive delay.
- (NSTimeInterval)nextDelayForEpoch:(NSUInteger)epoch;
/// Reserves the cooldown before invoking request, including reentrant calls.
/// A refused request does not run. Native exceptions propagate and retain the
/// reserved attempt budget. Returns YES when the block was invoked.
- (BOOL)performForEpoch:(NSUInteger)epoch request:(void (^)(void))request;
/// Extends current-epoch coverage without requesting synchronization.
- (void)verifiedFullSyncForEpoch:(NSUInteger)epoch;
@end

NS_ASSUME_NONNULL_END
