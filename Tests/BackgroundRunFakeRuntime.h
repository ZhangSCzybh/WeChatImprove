#import <Foundation/Foundation.h>
#import "CSBackgroundRunRuntime.h"

@class CSTestBackgroundRuntime;

@interface CSTestBackgroundTask : NSObject <CSBackgroundRunTask>
@property(nonatomic, readonly) BOOL valid;
@property(nonatomic, readonly) NSUInteger endCalls;
@property(nonatomic, readonly) NSUInteger number;
@property(nonatomic, copy, readonly, nullable) NSDate *expirationDate;
@property(nonatomic, readonly) NSTimeInterval expirationUptime;
- (void)expire;
- (void)expireDeferringCallback;
- (void)deliverExpirationCallback;
@end

@interface CSTestBackgroundCheck : NSObject <CSBackgroundRunScheduledCheck>
@property(nonatomic, readonly) BOOL cancelled;
@property(nonatomic, readonly) BOOL fired;
@property(nonatomic, readonly) BOOL repeating;
@property(nonatomic, readonly) NSTimeInterval deadline;
- (void)fireEvenIfCancelled;
@end

// The clock and callbacks are deterministic; no device or real-time waiting.
@interface CSTestBackgroundRuntime : NSObject <CSBackgroundRunRuntime>
@property(nonatomic) NSTimeInterval uptime;
@property(nonatomic) NSTimeInterval backgroundTimeRemaining;
@property(nonatomic, strong) NSDate *currentDate;
@property(nonatomic) BOOL failBegin, decrementsBudget;
@property(nonatomic, readonly) NSUInteger beginAttempts, maximumPendingChecks;
@property(nonatomic, readonly) NSArray<CSTestBackgroundTask *> *tasks;
@property(nonatomic, readonly) NSArray<CSTestBackgroundCheck *> *checks;
@property(nonatomic, readonly) NSArray<NSString *> *events;
@property(nonatomic, readonly) NSUInteger liveTaskCount, pendingCheckCount;
- (void)advanceBy:(NSTimeInterval)elapsed;
- (void)advanceWithoutDeliveryBy:(NSTimeInterval)elapsed;
@end
