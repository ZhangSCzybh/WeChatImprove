#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
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
