#import <Foundation/Foundation.h>
#include <stdint.h>

NS_ASSUME_NONNULL_BEGIN
extern NSNotificationName const CSBackgroundRunHostAudioChangedNotification;
extern NSNotificationName const CSBackgroundRunPlaybackFailedNotification;
extern NSNotificationName const CSBackgroundRunPlaybackFinishedNotification;

// Immutable main-thread sample. A native change during session reads produces a
// conservative busy sample rather than combining observations from two epochs.
@interface CSBackgroundRunAudioState : NSObject
@property(nonatomic, readonly) BOOL hostBusy, playing, sessionOwned, hostReleaseConfirmed, ownChangeInProgress;
@property(nonatomic, readonly) NSUInteger hostReleaseEpisode, hostCalls;
@property(nonatomic, readonly) uint64_t mediaGeneration, configurationRevision;
@property(nonatomic, copy, readonly) NSString *source;
- (instancetype)initWithHostBusy:(BOOL)hostBusy
                        playing:(BOOL)playing
                   sessionOwned:(BOOL)sessionOwned
                 releaseEpisode:(NSUInteger)releaseEpisode
               releaseConfirmed:(BOOL)releaseConfirmed
                mediaGeneration:(uint64_t)mediaGeneration
          configurationRevision:(uint64_t)configurationRevision
                      hostCalls:(NSUInteger)hostCalls
            ownChangeInProgress:(BOOL)ownChangeInProgress
                         source:(NSString *)source NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end

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
@optional
// Read once per decision; individual compatibility properties are separate reads.
- (CSBackgroundRunAudioState *)currentState;
// One identity per explicitly observed native release. Category/mode cleanup
// and repeated deactivation retain it. A media reset invalidates confirmation.
@property(nonatomic, readonly) NSUInteger hostReleaseEpisode;
// Confirmation is current only while no native call or activation is pending.
// Consumers must also recheck hostBusy before borrowing the shared session.
@property(nonatomic, readonly) BOOL hostReleaseConfirmed;
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
