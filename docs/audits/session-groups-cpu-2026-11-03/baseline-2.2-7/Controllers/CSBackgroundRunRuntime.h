#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CSBackgroundRunTask <NSObject>
@property(nonatomic, readonly) BOOL valid;
- (void)end;
@end

@protocol CSBackgroundRunScheduledCheck <NSObject>
- (void)cancel;
@end

// Runtime handles are owned by the main thread. Each handle releases only its
// own task or timer, including when an older expiration arrives after a restart.
@protocol CSBackgroundRunRuntime <NSObject>
@property(nonatomic, readonly) NSTimeInterval uptime;
@property(nonatomic, readonly) NSDate *currentDate;
@property(nonatomic, readonly) NSTimeInterval backgroundTimeRemaining;
- (id<CSBackgroundRunTask>)beginTaskWithExpirationHandler:(void (^)(id<CSBackgroundRunTask> task))handler;
- (id<CSBackgroundRunScheduledCheck>)scheduleAfter:(NSTimeInterval)delay handler:(dispatch_block_t)handler;
@end

@interface CSBackgroundRunRuntime : NSObject <CSBackgroundRunRuntime>
@end

NS_ASSUME_NONNULL_END
