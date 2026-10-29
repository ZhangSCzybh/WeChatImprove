#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, CSBackupChangeKind) {
    CSBackupChangePreferences = 1 << 0,
    CSBackupChangeResources = 1 << 1,
    CSBackupChangeContext = 1 << 2,
};
/// Constant-cost notification ingress. Taking a batch never consumes a later event.
@interface CSBackupChangeBatch : NSObject
@property(nonatomic,readonly) uint64_t generation;
/// Returns YES only when the caller must enqueue a drain on the I/O queue.
- (BOOL)note:(CSBackupChangeKind)kind at:(NSTimeInterval)time;
- (void)dequeued;
- (NSTimeInterval)deadline;
- (nullable NSDictionary *)take;
@end

/// Clock-independent scheduling policy. The manager owns the timer and serial queue.
@interface CSBackupScheduler : NSObject
@property(nonatomic) NSTimeInterval quietInterval;
@property(nonatomic) NSTimeInterval checkpointInterval;
@property(nonatomic,readonly) BOOL dirty;
- (void)changedAt:(NSTimeInterval)time;
- (NSTimeInterval)deadline;
- (BOOL)shouldRunAt:(NSTimeInterval)time enabled:(BOOL)enabled active:(BOOL)active;
- (void)completed:(BOOL)success at:(NSTimeInterval)time;
@end
NS_ASSUME_NONNULL_END
