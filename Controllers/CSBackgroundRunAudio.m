#import "CSBackgroundRunAudio.h"
#import <AVFoundation/AVFoundation.h>
#import <stdatomic.h>
#import <os/lock.h>

NSNotificationName const CSBackgroundRunHostAudioChangedNotification = @"CSBackgroundRunHostAudioChanged";
NSNotificationName const CSBackgroundRunPlaybackFailedNotification = @"CSBackgroundRunPlaybackFailed";
NSNotificationName const CSBackgroundRunPlaybackFinishedNotification = @"CSBackgroundRunPlaybackFinished";
static atomic_uint_fast64_t hostEpoch;
static atomic_uint_fast64_t mediaGeneration;
static atomic_uint hostCalls;
static atomic_bool hostActive, hostActiveKnown, hostNotificationPending;
static atomic_bool hostNotificationsEnabled;
static BOOL mediaLossObserved;
static _Thread_local unsigned int ownChanges, nativeChanges;
static _Thread_local uint64_t nativeMediaGeneration;
// Only tracker bookkeeping is protected; never hold this across an audio API.
static os_unfair_lock hostStateLock=OS_UNFAIR_LOCK_INIT;

BOOL CSBackgroundRunAudioWillChange(void) {
    if (ownChanges || nativeChanges) return NO;
    nativeChanges++;
    atomic_fetch_add(&hostCalls, 1);
    nativeMediaGeneration=atomic_load(&mediaGeneration);
    return YES;
}
void CSBackgroundRunAudioDidChange(BOOL succeeded, BOOL activation, BOOL active) {
    os_unfair_lock_lock(&hostStateLock);
    if (succeeded && nativeMediaGeneration==atomic_load(&mediaGeneration)) {
        // Pending calls block borrowing, but a failed write cannot revoke a
        // valid lease or discard its original pre-plugin configuration snapshot.
        atomic_fetch_add(&hostEpoch, 1);
        if (activation) {
            atomic_store(&hostActive, active);
            atomic_store(&hostActiveKnown, true);
        }
    }
    os_unfair_lock_unlock(&hostStateLock);
    atomic_fetch_sub(&hostCalls, 1);
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
        BOOL released=!atomic_load(&hostCalls) && !atomic_load(&hostActive);
        [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunHostAudioChangedNotification object:nil userInfo:@{@"released":@(released)}];
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
- (BOOL)hostBusy {
    if (atomic_load(&hostCalls) || atomic_load(&hostActive)) return YES;
    if ([self ownsConfiguration]) return NO;
    if (atomic_load(&hostActiveKnown)) return NO;
    // A late-loaded plugin cannot know whether an existing session is active.
    // Only borrow a default ambient session until we observe native activation.
    AVAudioSession *session=AVAudioSession.sharedInstance;
    return !([session.category isEqual:AVAudioSessionCategoryAmbient] || [session.category isEqual:AVAudioSessionCategorySoloAmbient]) || ![session.mode isEqual:AVAudioSessionModeDefault];
}
- (BOOL)ownsConfiguration {
    if (!self.configured) return NO;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    return self.configured && self.epoch==atomic_load(&hostEpoch) && !atomic_load(&hostCalls) &&
        [session.category isEqual:AVAudioSessionCategoryPlayback] && [session.mode isEqual:AVAudioSessionModeDefault] &&
        session.categoryOptions==AVAudioSessionCategoryOptionMixWithOthers && session.routeSharingPolicy==AVAudioSessionRouteSharingPolicyDefault;
}
- (BOOL)startWithError:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Background audio is main-thread owned");
    uint64_t requestedEpoch=atomic_load(&hostEpoch);
    BOOL owned=[self ownsConfiguration];
    if (!owned) [self relinquish];
    AVAudioSession *session=AVAudioSession.sharedInstance;
    // External playback may coexist through MixWithOthers; native WeChat audio
    // still owns this process's session and must never be displaced.
    if (self.hostBusy) {
        [self relinquish];
        if (error) *error=CSAudioError(1,@"微信正在使用音频，保活已让出");
        return NO;
    }
    if (self.playing && owned) return YES;
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
    // An in-flight native call blocks playback immediately, but it may fail.
    // Preserve the original snapshot until a confirmed mutation revokes it.
    BOOL pendingLease=self.configured && self.epoch==atomic_load(&hostEpoch) && atomic_load(&hostCalls)>0;
    ownChanges++;
    @try { [self releasePlayer]; }
    @finally {
        if (!pendingLease || self.epoch!=atomic_load(&hostEpoch)) [self clearLease];
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
    if (!mediaLossObserved) atomic_fetch_add(&mediaGeneration, 1);
    atomic_fetch_add(&hostEpoch, 1);
    mediaLossObserved=NO;
    os_unfair_lock_unlock(&hostStateLock);
    [self relinquish];
}
- (void)stop {
    ownChanges++;
    @try {
        [self releasePlayer];
        if ([self ownsConfiguration]) {
            AVAudioSession *session=AVAudioSession.sharedInstance;
            // A failed deactivation means another audio object may be running.
            // Do not overwrite its session category in that case.
            BOOL released=!self.activated || [session setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:NULL];
            if (released && [self ownsConfiguration] && self.previousCategory && self.previousMode) {
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
