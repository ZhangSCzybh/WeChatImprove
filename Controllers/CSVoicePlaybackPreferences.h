#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const CSVoicePlaybackProgressEnabledKey;
// Object is this preferences instance. Changed values are delivered on main.
FOUNDATION_EXPORT NSNotificationName const CSVoicePlaybackSettingsDidChangeNotification;

// Playback progress has independent preferences so it cannot invalidate a
// message-action snapshot or a pending voice-forward operation.
@interface CSVoicePlaybackPreferences : NSObject
@property(nonatomic, readonly) BOOL progressEnabled;
+ (instancetype)sharedPreferences;
// Tests inject a unique suite. Reading does not write or register defaults.
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
// Coalesced main-thread refresh; also observes defaults, voice Darwin and activation.
- (void)requestRefresh;
@end

NS_ASSUME_NONNULL_END
