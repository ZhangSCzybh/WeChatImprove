#import "CSBackgroundRunAudio.h"
#import <AVFoundation/AVFoundation.h>
#import <stdatomic.h>
#import <os/lock.h>

NSNotificationName const CSBackgroundRunHostAudioChangedNotification = @"CSBackgroundRunHostAudioChanged";
NSNotificationName const CSBackgroundRunPlaybackFailedNotification = @"CSBackgroundRunPlaybackFailed";
NSNotificationName const CSBackgroundRunPlaybackFinishedNotification = @"CSBackgroundRunPlaybackFinished";

@implementation CSBackgroundRunAudioState
- (instancetype)initWithHostBusy:(BOOL)hostBusy
                        playing:(BOOL)playing
                   sessionOwned:(BOOL)sessionOwned
                 releaseEpisode:(NSUInteger)releaseEpisode
               releaseConfirmed:(BOOL)releaseConfirmed
                mediaGeneration:(uint64_t)mediaGeneration
          configurationRevision:(uint64_t)configurationRevision
                      hostCalls:(NSUInteger)hostCalls
            ownChangeInProgress:(BOOL)ownChangeInProgress
                         source:(NSString *)source {
    if ((self=[super init])) {
        _hostBusy=hostBusy; _playing=playing; _sessionOwned=sessionOwned;
        _hostReleaseEpisode=releaseEpisode; _hostReleaseConfirmed=releaseConfirmed;
        _mediaGeneration=mediaGeneration; _configurationRevision=configurationRevision;
        _hostCalls=hostCalls; _ownChangeInProgress=ownChangeInProgress; _source=[source copy];
    }
    return self;
}
@end

typedef NS_ENUM(NSUInteger, CSAudioHostChangeSource) {
    CSAudioHostInitial, CSAudioHostStaleCall, CSAudioHostFailedCall,
    CSAudioHostActivation, CSAudioHostRelease, CSAudioHostConfiguration,
    CSAudioHostMediaLost, CSAudioHostMediaReset
};
static NSString *CSAudioHostSourceDescription(CSAudioHostChangeSource source) {
    switch (source) {
        case CSAudioHostStaleCall: return @"旧媒体代际调用结束";
        case CSAudioHostFailedCall: return @"宿主调用结束（未成功）";
        case CSAudioHostActivation: return @"宿主激活";
        case CSAudioHostRelease: return @"宿主释放";
        case CSAudioHostConfiguration: return @"宿主配置变更";
        case CSAudioHostMediaLost: return @"音频服务丢失";
        case CSAudioHostMediaReset: return @"音频服务重置";
        case CSAudioHostInitial: return @"尚未观察宿主音频调用";
    }
}

static atomic_uint_fast64_t hostEpoch;
static atomic_uint_fast64_t mediaGeneration;
static atomic_uint hostCalls;
static atomic_bool hostActive, hostActiveKnown, hostNotificationPending;
static atomic_bool hostNotificationsEnabled;
static BOOL mediaLossObserved;
// Protected by hostStateLock. A release identity survives configuration cleanup,
// but never grants permission across a native activation or media generation.
static NSUInteger hostReleaseEpisode;
static uint64_t hostReleaseMediaGeneration;
static BOOL hostReleaseObserved;
static CSAudioHostChangeSource hostChangeSource;
// Includes failed calls and balanced begin/end pairs, so a sample cannot miss
// an entire native call whose successful-configuration revision stayed equal.
static uint64_t hostTrackingRevision;
static _Thread_local unsigned int ownChanges, nativeChanges;
static _Thread_local uint64_t nativeMediaGeneration;
// Only tracker bookkeeping is protected; never hold this across an audio API.
static os_unfair_lock hostStateLock=OS_UNFAIR_LOCK_INIT;

typedef struct {
    uint64_t configurationRevision, mediaGeneration, trackingRevision, releaseMediaGeneration;
    NSUInteger calls, releaseEpisode;
    BOOL active, activeKnown, releaseObserved;
    CSAudioHostChangeSource source;
} CSAudioHostTrackerState;
static CSAudioHostTrackerState CSAudioReadHostTracker(void) {
    os_unfair_lock_lock(&hostStateLock);
    CSAudioHostTrackerState state={
        .configurationRevision=atomic_load(&hostEpoch), .mediaGeneration=atomic_load(&mediaGeneration),
        .trackingRevision=hostTrackingRevision, .releaseMediaGeneration=hostReleaseMediaGeneration,
        .calls=atomic_load(&hostCalls), .releaseEpisode=hostReleaseEpisode,
        .active=atomic_load(&hostActive), .activeKnown=atomic_load(&hostActiveKnown),
        .releaseObserved=hostReleaseObserved, .source=hostChangeSource
    };
    os_unfair_lock_unlock(&hostStateLock);
    return state;
}
static BOOL CSAudioTrackerReleaseConfirmed(CSAudioHostTrackerState state) {
    return !state.calls && !state.active && state.releaseObserved &&
        state.releaseMediaGeneration==state.mediaGeneration;
}

BOOL CSBackgroundRunAudioWillChange(void) {
    if (ownChanges || nativeChanges) return NO;
    nativeChanges++;
    os_unfair_lock_lock(&hostStateLock);
    atomic_fetch_add(&hostCalls, 1);
    nativeMediaGeneration=atomic_load(&mediaGeneration);
    hostTrackingRevision++;
    os_unfair_lock_unlock(&hostStateLock);
    return YES;
}
void CSBackgroundRunAudioDidChange(BOOL succeeded, BOOL activation, BOOL active) {
    os_unfair_lock_lock(&hostStateLock);
    uint64_t currentMediaGeneration=atomic_load(&mediaGeneration);
    BOOL currentGeneration=nativeMediaGeneration==currentMediaGeneration;
    if (succeeded && currentGeneration) {
        // Pending calls block borrowing, but a failed write cannot revoke a
        // valid lease or discard its original pre-plugin configuration snapshot.
        atomic_fetch_add(&hostEpoch, 1);
        if (activation) {
            if (active) {
                hostReleaseObserved=NO;
            } else {
                // Initial explicit deactivation is useful evidence too. A
                // duplicate NO or later category cleanup is the same release.
                if (!hostReleaseObserved || hostReleaseMediaGeneration!=currentMediaGeneration) hostReleaseEpisode++;
                hostReleaseObserved=YES;
                hostReleaseMediaGeneration=currentMediaGeneration;
            }
            atomic_store(&hostActive, active);
            atomic_store(&hostActiveKnown, true);
        }
    }
    hostChangeSource=!currentGeneration?CSAudioHostStaleCall:(!succeeded?CSAudioHostFailedCall:
        (activation?(active?CSAudioHostActivation:CSAudioHostRelease):CSAudioHostConfiguration));
    atomic_fetch_sub(&hostCalls, 1);
    hostTrackingRevision++;
    os_unfair_lock_unlock(&hostStateLock);
    nativeChanges--;
    // Even a failed native call must finish tracking: an in-flight call may
    // have made a periodic check yield. Gate delivery only after it unwinds.
    if (!atomic_load(&hostNotificationsEnabled) || atomic_exchange(&hostNotificationPending, true)) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        atomic_store(&hostNotificationPending, false);
        if (!atomic_load(&hostNotificationsEnabled)) return;
        // Native cleanup may restore category/mode after deactivation. Such
        // writes invalidate our lease without making the native session active.
        // The manager also checks hostBusy before accepting a release, retaining
        // its conservative fallback for unobserved, non-default configurations.
        // Read at delivery, not at the original call's return: a coalesced
        // cleanup must preserve the release identity, while a newer activation
        // or media reset must revoke stale permission before the manager sees it.
        CSAudioHostTrackerState tracker=CSAudioReadHostTracker();
        NSDictionary *state=@{@"released":@(!tracker.calls && !tracker.active), @"releaseEpisode":@(tracker.releaseEpisode),
            @"releaseConfirmed":@(CSAudioTrackerReleaseConfirmed(tracker)), @"source":CSAudioHostSourceDescription(tracker.source),
            @"hostActive":@(tracker.active), @"hostActiveKnown":@(tracker.activeKnown), @"hostCalls":@(tracker.calls),
            @"mediaGeneration":@(tracker.mediaGeneration), @"configurationRevision":@(tracker.configurationRevision)};
        [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunHostAudioChangedNotification object:nil userInfo:state];
    });
}

static NSError *CSAudioError(NSInteger code, NSString *reason) {
    return [NSError errorWithDomain:@"CSBackgroundRunAudio" code:code userInfo:@{NSLocalizedDescriptionKey:reason}];
}

@interface CSBackgroundRunAudio () <AVAudioPlayerDelegate>
@property(nonatomic, strong) AVAudioPlayer *player;
// Bundle metadata survives audio-server resets; players and leases never do.
@property(nonatomic, copy) NSURL *blankURL;
@property(nonatomic, copy) NSString *previousCategory, *previousMode;
@property(nonatomic) AVAudioSessionCategoryOptions previousOptions;
@property(nonatomic) AVAudioSessionRouteSharingPolicy previousPolicy;
@property(nonatomic) uint64_t epoch;
@property(nonatomic) BOOL configured, activated;
@end

@implementation CSBackgroundRunAudio
- (void)setHostNotificationsEnabled:(BOOL)enabled {
    NSAssert(NSThread.isMainThread,@"Background audio delivery is main-thread owned");
    atomic_store(&hostNotificationsEnabled, enabled);
}
- (BOOL)playing { return self.player.isPlaying; }
- (BOOL)sessionOwned { return [self ownsConfiguration]; }
- (CSBackgroundRunAudioState *)currentState {
    NSAssert(NSThread.isMainThread,@"Background audio samples are main-thread owned");
    CSAudioHostTrackerState before=CSAudioReadHostTracker();
    BOOL configured=self.configured, playing=NO, readable=NO;
    uint64_t leaseEpoch=self.epoch;
    NSString *category=nil, *mode=nil;
    AVAudioSessionCategoryOptions options=0;
    AVAudioSessionRouteSharingPolicy policy=AVAudioSessionRouteSharingPolicyDefault;
    // Never hold the tracker lock across an audio API. Native calls on any
    // thread can run or even finish while these properties are being sampled.
    @try {
        AVAudioSession *session=AVAudioSession.sharedInstance;
        category=[session.category copy]; mode=[session.mode copy];
        options=session.categoryOptions; policy=session.routeSharingPolicy;
        playing=self.player.isPlaying;
        readable=category.length>0 && mode.length>0;
    } @catch (__unused NSException *exception) { readable=NO; }
    CSAudioHostTrackerState after=CSAudioReadHostTracker();
    BOOL stable=before.trackingRevision==after.trackingRevision &&
        before.configurationRevision==after.configurationRevision && before.mediaGeneration==after.mediaGeneration;
    BOOL owned=readable && stable && configured && self.configured && leaseEpoch==self.epoch &&
        leaseEpoch==after.configurationRevision && !after.calls &&
        [category isEqual:AVAudioSessionCategoryPlayback] && [mode isEqual:AVAudioSessionModeDefault] &&
        options==AVAudioSessionCategoryOptionMixWithOthers && policy==AVAudioSessionRouteSharingPolicyDefault;
    BOOL busy=!stable || !readable || after.calls || after.active;
    if (!busy && !owned && !after.activeKnown) {
        // A late-loaded plugin has no reliable active getter for the shared
        // session. Keep the conservative fallback for unobserved native audio.
        busy=!([category isEqual:AVAudioSessionCategoryAmbient] || [category isEqual:AVAudioSessionCategorySoloAmbient]) ||
            ![mode isEqual:AVAudioSessionModeDefault];
    }
    NSString *source=CSAudioHostSourceDescription(after.source);
    if (!stable) source=[source stringByAppendingString:@"（采样期间状态变化，保守让出）"];
    else if (!readable) source=[source stringByAppendingString:@"（音频配置暂不可读，保守让出）"];
    return [[CSBackgroundRunAudioState alloc] initWithHostBusy:busy playing:playing sessionOwned:owned
        releaseEpisode:after.releaseEpisode releaseConfirmed:!busy && CSAudioTrackerReleaseConfirmed(after)
        mediaGeneration:after.mediaGeneration configurationRevision:after.configurationRevision
        hostCalls:after.calls ownChangeInProgress:ownChanges>0 source:source];
}
- (NSUInteger)hostReleaseEpisode {
    return CSAudioReadHostTracker().releaseEpisode;
}
- (BOOL)hostReleaseConfirmed {
    return CSAudioTrackerReleaseConfirmed(CSAudioReadHostTracker());
}
- (BOOL)hostBusy {
    return self.currentState.hostBusy;
}
- (BOOL)ownsConfiguration {
    return self.currentState.sessionOwned;
}
- (BOOL)ownsConfigurationForCleanup {
    CSBackgroundRunAudioState *state=self.currentState;
    if (state.sessionOwned) return YES;
    // Cleanup must not discard the original configuration just because a
    // completed failed call crossed the sample. Retry once only while the
    // successful-change epoch is unchanged and no native operation is pending.
    if (!self.configured || self.epoch!=state.configurationRevision || state.hostCalls) return NO;
    return self.currentState.sessionOwned;
}
- (BOOL)startWithError:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Background audio is main-thread owned");
    // Keep the initial ownership and busy decision in one sample. A failed
    // native call can make that sample conservative without revoking the lease;
    // mixing it with a later idle read would replace the original snapshot.
    CSBackgroundRunAudioState *initialState=self.currentState;
    uint64_t requestedEpoch=initialState.configurationRevision;
    BOOL owned=initialState.sessionOwned;
    if (!owned) [self relinquish];
    AVAudioSession *session=AVAudioSession.sharedInstance;
    // External playback may coexist through MixWithOthers; native WeChat audio
    // still owns this process's session and must never be displaced.
    if (initialState.hostBusy) {
        [self relinquish];
        if (error) *error=CSAudioError(1,@"微信正在使用音频，保活已让出");
        return NO;
    }
    if (initialState.playing && owned) return YES;
    NSError *failure=nil;
    BOOL ok=NO;
    ownChanges++;
    @try {
        if (!owned) {
            self.epoch=requestedEpoch;
            self.previousCategory=session.category; self.previousMode=session.mode;
            self.previousOptions=session.categoryOptions; self.previousPolicy=session.routeSharingPolicy;
        }
        NSURL *url=self.blankURL;
        if (!url) {
            url=[NSBundle.mainBundle URLForResource:@"blank" withExtension:@"caf"];
            if (url) self.blankURL=url;
        }
        if (!url) failure=CSAudioError(2,@"当前微信包缺少 blank.caf，无法播放保活音频");
        else {
            [self releasePlayer];
            self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&failure];
            self.player.delegate=self;
            self.player.volume=0;
            if (!self.player) failure=failure?:CSAudioError(3,@"无法创建保活音频");
            else {
                if (!owned) {
                    if (self.epoch!=atomic_load(&hostEpoch) || atomic_load(&hostCalls) || atomic_load(&hostActive)) failure=CSAudioError(4,@"微信已接管音频");
                    else if ([session setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeDefault routeSharingPolicy:AVAudioSessionRouteSharingPolicyDefault options:AVAudioSessionCategoryOptionMixWithOthers error:&failure]) self.configured=YES;
                }
                if (!failure && [self ownsConfiguration] && [session setActive:YES error:&failure]) {
                    self.activated=YES;
                    // A short pulse may finish before a later isPlaying read.
                    if ([self ownsConfiguration]) ok=[self.player prepareToPlay] && [self.player play];
                }
            }
        }
    } @catch (__unused NSException *exception) { failure=CSAudioError(5,@"音频服务暂不可用"); }
    @finally { ownChanges--; }
    // A native change during activation invalidates our lease immediately.
    if (ok && ![self ownsConfiguration]) ok=NO;
    if (!ok) {
        [self stop];
        if (error) *error=failure?:CSAudioError(6,@"系统未允许启动后台音频");
    }
    return ok;
}
- (void)releasePlayer {
    self.player.delegate=nil;
    [self.player stop]; self.player=nil;
}
- (void)clearLease {
    self.configured=NO; self.activated=NO;
    self.previousCategory=nil; self.previousMode=nil;
}
- (void)relinquish {
    // A conservative sample can stop playback after a failed native call has
    // already finished. Its unchanged epoch still owns the original snapshot;
    // only a confirmed native mutation or media boundary can revoke that lease.
    BOOL currentLease=self.configured && self.epoch==atomic_load(&hostEpoch);
    ownChanges++;
    @try { [self releasePlayer]; }
    @finally {
        if (!currentLease || self.epoch!=atomic_load(&hostEpoch)) [self clearLease];
        ownChanges--;
    }
}
- (void)suspend {
    // iOS deactivates an interrupted session. Retain its configuration lease so
    // a permitted resume can restore the pre-plugin category before restarting.
    ownChanges++;
    @try { [self releasePlayer]; }
    @finally { self.activated=NO; ownChanges--; }
}
- (void)invalidateForMediaServicesLoss {
    os_unfair_lock_lock(&hostStateLock);
    atomic_fetch_add(&mediaGeneration, 1);
    atomic_fetch_add(&hostEpoch, 1);
    atomic_store(&hostActive, false);
    atomic_store(&hostActiveKnown, true);
    hostReleaseObserved=NO;
    hostChangeSource=CSAudioHostMediaLost;
    hostTrackingRevision++;
    mediaLossObserved=YES;
    os_unfair_lock_unlock(&hostStateLock);
    [self relinquish];
}
- (void)resetAfterMediaServicesReset {
    os_unfair_lock_lock(&hostStateLock);
    // WeChat may receive Reset first and successfully reactivate before our
    // observer runs. Preserve post-Lost results, including in-flight calls.
    // With no observed Lost, there is no reliable public boundary identifying
    // stale vs fresh native activation: keep it until a native release.
    if (!mediaLossObserved) {
        atomic_fetch_add(&mediaGeneration, 1);
        hostReleaseObserved=NO;
    }
    atomic_fetch_add(&hostEpoch, 1);
    hostChangeSource=CSAudioHostMediaReset;
    hostTrackingRevision++;
    mediaLossObserved=NO;
    os_unfair_lock_unlock(&hostStateLock);
    [self relinquish];
}
- (void)stop {
    ownChanges++;
    @try {
        [self releasePlayer];
        if ([self ownsConfigurationForCleanup]) {
            AVAudioSession *session=AVAudioSession.sharedInstance;
            // A failed deactivation means another audio object may be running.
            // Do not overwrite its session category in that case.
            BOOL released=!self.activated || [session setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:NULL];
            if (released && [self ownsConfigurationForCleanup] && self.previousCategory && self.previousMode) {
                [session setCategory:self.previousCategory mode:self.previousMode routeSharingPolicy:self.previousPolicy options:self.previousOptions error:NULL];
            }
        }
    } @catch (__unused NSException *exception) {
        // A foreign/session-server failure must not break UIKit lifecycle delivery.
    } @finally { ownChanges--; [self clearLease]; }
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    dispatch_block_t report=^{
        if (player!=self.player) return;
        player.delegate=nil;
        self.player=nil;
        // Successful one-shot playback is expected; retain the session lease
        // for the next pulse, and restore it only on stop or host handover.
        [NSNotificationCenter.defaultCenter postNotificationName:flag?CSBackgroundRunPlaybackFinishedNotification:CSBackgroundRunPlaybackFailedNotification object:self];
    };
    if (NSThread.isMainThread) report(); else dispatch_async(dispatch_get_main_queue(),report);
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    [self audioPlayerDidFinishPlaying:player successfully:NO];
}
@end
