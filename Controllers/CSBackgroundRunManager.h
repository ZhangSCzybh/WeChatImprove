#import <Foundation/Foundation.h>
#import "CSBackgroundRunAudio.h"
#import "CSBackgroundRunRuntime.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const CSBackgroundRunDefaultsSuite;
extern NSString *const CSBackgroundRunEnabledKey;
extern NSString *const CSBackgroundRunCheckIntervalKey;
extern NSNotificationName const CSBackgroundRunSettingsChangedNotification;
extern NSNotificationName const CSBackgroundRunStateChangedNotification;

// An immutable, in-memory observation; elapsed is monotonic time since entry,
// or -1 when the clock is unavailable. It does not prove continuous execution.
@interface CSBackgroundRunRecordEvent : NSObject
@property(nonatomic, copy, readonly) NSDate *date;
@property(nonatomic, readonly) NSTimeInterval elapsed;
@property(nonatomic, copy, readonly) NSString *source;
@property(nonatomic, copy, readonly) NSString *detail;
@end

@interface CSBackgroundRunManager : NSObject
+ (instancetype)sharedManager;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults audio:(id<CSBackgroundRunAudio>)audio supportsBackgroundAudio:(BOOL)supported;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults audio:(id<CSBackgroundRunAudio>)audio supportsBackgroundAudio:(BOOL)supported runtime:(id<CSBackgroundRunRuntime>)runtime;
- (void)start;
- (void)reloadSettings;
// Main-thread request from the current group configuration. This does not change the global setting.
- (void)setGroupChatBackgroundRequested:(BOOL)requested;
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, readonly) NSTimeInterval checkInterval;
@property(nonatomic, readonly) BOOL backgroundAudioActive;
// A current execution opportunity, not a guarantee against system suspension.
@property(nonatomic, readonly) BOOL canAttemptBackgroundWork;
@property(nonatomic, readonly) BOOL supportsBackgroundAudio;
@property(nonatomic, copy, readonly) NSString *statusText;
@property(nonatomic, copy, readonly) NSString *lastBackgroundResult;
// The latest observed background visit, retained until the process exits.
@property(nonatomic, copy, readonly, nullable) NSDate *lastBackgroundStartedAt;
@property(nonatomic, readonly) BOOL lastBackgroundStartObserved;
// The last evaluation includes task expiration; it is not necessarily a timer check.
@property(nonatomic, copy, readonly, nullable) NSDate *lastBackgroundCheckedAt;
@property(nonatomic, copy, readonly) NSString *lastBackgroundCheckStatus;
@property(nonatomic, copy, readonly, nullable) NSDate *lastForegroundReturnedAt;
@property(nonatomic, copy, readonly, nullable) NSDate *lastBackgroundStoppedAt;
@property(nonatomic, copy, readonly) NSString *lastBackgroundStopReason;
// Monotonic elapsed time from the last evaluation to foreground; -1 if unknown.
@property(nonatomic, readonly) NSTimeInterval lastCheckToForegroundInterval;
// Snapshot of the latest visit: entry plus the newest 79 events, retained only
// in this process. Timer summaries survive event truncation and task expiration.
@property(nonatomic, copy, readonly) NSArray<CSBackgroundRunRecordEvent *> *lastBackgroundEvents;
@property(nonatomic, readonly) NSUInteger droppedBackgroundEventCount;
@property(nonatomic, copy, readonly, nullable) NSDate *firstScheduledCheckAt;
@property(nonatomic, copy, readonly, nullable) NSDate *lastPeriodicCheckAt;
@property(nonatomic, readonly) NSUInteger periodicCheckCount;
@property(nonatomic, copy, readonly, nullable) NSDate *lastTaskExpiredAt;
@end
NS_ASSUME_NONNULL_END
