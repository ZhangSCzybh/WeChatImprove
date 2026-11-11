#import <Foundation/Foundation.h>
#import "CSBackgroundRunAudio.h"
#import "CSBackgroundRunRuntime.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const CSBackgroundRunDefaultsSuite;
extern NSString *const CSBackgroundRunEnabledKey;
extern NSNotificationName const CSBackgroundRunSettingsChangedNotification;
extern NSNotificationName const CSBackgroundRunStateChangedNotification;

@interface CSBackgroundRunManager : NSObject
+ (instancetype)sharedManager;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults audio:(id<CSBackgroundRunAudio>)audio supportsBackgroundAudio:(BOOL)supported;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults audio:(id<CSBackgroundRunAudio>)audio supportsBackgroundAudio:(BOOL)supported runtime:(id<CSBackgroundRunRuntime>)runtime;
- (void)start;
- (void)reloadSettings;
// Main-thread request from the current group configuration. This does not change the global setting.
- (void)setGroupChatBackgroundRequested:(BOOL)requested;
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, readonly) BOOL backgroundAudioActive;
// A current execution opportunity, not a guarantee against system suspension.
@property(nonatomic, readonly) BOOL canAttemptBackgroundWork;
@property(nonatomic, readonly) BOOL canAttemptGroupChatBackgroundWork;
@property(nonatomic, readonly) BOOL supportsBackgroundAudio;
@property(nonatomic, copy, readonly) NSString *statusText;
@property(nonatomic, copy, readonly) NSString *lastBackgroundResult;
// The latest observed background visit, retained until the process exits.
@property(nonatomic, copy, readonly, nullable) NSDate *lastBackgroundStartedAt;
@property(nonatomic, readonly) BOOL lastBackgroundStartObserved;
@property(nonatomic, copy, readonly, nullable) NSDate *lastBackgroundCheckedAt;
@property(nonatomic, copy, readonly) NSString *lastBackgroundCheckStatus;
@property(nonatomic, copy, readonly, nullable) NSDate *lastForegroundReturnedAt;
@property(nonatomic, copy, readonly, nullable) NSDate *lastBackgroundStoppedAt;
@property(nonatomic, copy, readonly) NSString *lastBackgroundStopReason;
// Monotonic elapsed time from the last actual check to foreground; -1 if unknown.
@property(nonatomic, readonly) NSTimeInterval lastCheckToForegroundInterval;
@end
NS_ASSUME_NONNULL_END
