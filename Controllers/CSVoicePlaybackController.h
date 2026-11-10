#import <Foundation/Foundation.h>
#import "CSMessageNativeActionAdapter.h"
#import "CSVoicePlaybackPreferences.h"

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSVoicePlaybackStateDidChangeNotification;

@interface CSVoicePlaybackSnapshot : NSObject
@property(nonatomic, readonly) NSUInteger generation;
@property(nonatomic, readonly) NSTimeInterval currentTime;
@property(nonatomic, readonly) NSTimeInterval duration;
@property(nonatomic, readonly) BOOL canSeek;
@end

// Main-thread adapter for WeChat's existing MsgPlayingFacade. It never owns an
// audio player, changes playback rate, or writes the source message/audio file.
@interface CSVoicePlaybackController : NSObject
+ (instancetype)sharedController;
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment
    preferences:(CSVoicePlaybackPreferences *)preferences;
- (nullable CSVoicePlaybackSnapshot *)snapshotForMessage:(id)message;
- (BOOL)seekToTime:(NSTimeInterval)seconds message:(id)message generation:(NSUInteger)generation;
- (void)messageDidBegin:(id)message;
- (void)messageDidEnd:(id)message;
- (void)invalidate;
@end
NS_ASSUME_NONNULL_END
