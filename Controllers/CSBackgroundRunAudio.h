#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
extern NSNotificationName const CSBackgroundRunHostAudioChangedNotification;
extern NSNotificationName const CSBackgroundRunPlaybackFailedNotification;
extern NSNotificationName const CSBackgroundRunPlaybackFinishedNotification;

@protocol CSBackgroundRunAudio <NSObject>
@property(nonatomic, readonly) BOOL playing;
@property(nonatomic, readonly) BOOL hostBusy;
@property(nonatomic, readonly) BOOL sessionOwned;
// Main-thread delivery interest, initially disabled. Native ownership tracking
// always continues. Enable before reading hostBusy to synchronize renewed demand.
- (void)setHostNotificationsEnabled:(BOOL)enabled;
- (BOOL)startWithError:(NSError * _Nullable * _Nullable)error;
- (void)stop;
- (void)suspend;
// Establish the media-loss boundary before host reset observers can reactivate.
- (void)invalidateForMediaServicesLoss;
// Media services invalidated prior activation observations and audio objects.
// Calls already in flight still complete and balance their tracking scopes.
- (void)resetAfterMediaServicesReset;
// The host or audio server owns the session now. Never restore/deactivate it.
- (void)relinquish;
@end

@interface CSBackgroundRunAudio : NSObject <CSBackgroundRunAudio>
@end

// Observe native session changes without blocking their thread or changing results.
// Nested native calls and this module's calls are excluded by thread-local scopes.
#ifdef __cplusplus
extern "C" {
#endif
BOOL CSBackgroundRunAudioWillChange(void);
void CSBackgroundRunAudioDidChange(BOOL succeeded, BOOL activation, BOOL active);
#ifdef __cplusplus
}
#endif
NS_ASSUME_NONNULL_END
