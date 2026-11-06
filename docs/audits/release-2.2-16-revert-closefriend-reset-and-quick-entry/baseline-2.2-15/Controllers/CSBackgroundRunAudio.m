#import "CSBackgroundRunAudio.h"
#import <AVFoundation/AVFoundation.h>
#import <stdatomic.h>

NSNotificationName const CSBackgroundRunHostAudioChangedNotification = @"CSBackgroundRunHostAudioChanged";
NSNotificationName const CSBackgroundRunPlaybackFailedNotification = @"CSBackgroundRunPlaybackFailed";
static atomic_uint_fast64_t hostEpoch;
static atomic_uint_fast64_t hostReleaseEpoch;
static atomic_uint hostCalls;
static atomic_bool hostActive, hostActiveKnown, hostNotificationPending;
static _Thread_local unsigned int ownChanges, nativeChanges;

BOOL CSBackgroundRunAudioWillChange(void) {
    if (ownChanges || nativeChanges) return NO;
    nativeChanges++;
    atomic_fetch_add(&hostCalls, 1);
    atomic_fetch_add(&hostEpoch, 1);
    return YES;
}
void CSBackgroundRunAudioDidChange(BOOL succeeded, BOOL activation, BOOL active) {
    if (succeeded && activation) {
        atomic_store(&hostActive, active);
        atomic_store(&hostActiveKnown, true);
        if (!active) atomic_store(&hostReleaseEpoch,atomic_load(&hostEpoch));
    }
    atomic_fetch_sub(&hostCalls, 1);
    nativeChanges--;
    if (atomic_exchange(&hostNotificationPending, true)) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        atomic_store(&hostNotificationPending, false);
        BOOL released=atomic_load(&hostReleaseEpoch)==atomic_load(&hostEpoch) && !atomic_load(&hostCalls) && !atomic_load(&hostActive);
        [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunHostAudioChangedNotification object:nil userInfo:@{@"released":@(released)}];
    });
}

NSData *CSBackgroundRunSilentAudioData(void) {
    static NSData *data;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        // Eight seconds of mono, 16-bit PCM. No decoder, file dependency or timer.
        const uint32_t rate=16000, samples=rate*8, bytes=samples*2;
        NSMutableData *wav=[NSMutableData dataWithLength:44+bytes];
        uint8_t *p=wav.mutableBytes;
        memcpy(p,"RIFF",4); memcpy(p+8,"WAVEfmt ",8); memcpy(p+36,"data",4);
        const uint32_t values[]={36+bytes,16,rate,rate*2,bytes};
        const NSUInteger offsets[]={4,16,24,28,40};
        for (NSUInteger i=0;i<5;i++) for (NSUInteger j=0;j<4;j++) p[offsets[i]+j]=(values[i]>>(8*j))&255;
        p[20]=1; p[22]=1; p[32]=2; p[34]=16;
        data=[wav copy];
    });
    return data;
}

static NSError *CSAudioError(NSInteger code, NSString *reason) {
    return [NSError errorWithDomain:@"CSBackgroundRunAudio" code:code userInfo:@{NSLocalizedDescriptionKey:reason}];
}

@interface CSBackgroundRunAudio () <AVAudioPlayerDelegate>
@property(nonatomic, strong) AVAudioPlayer *player;
@property(nonatomic, copy) NSString *previousCategory, *previousMode;
@property(nonatomic) AVAudioSessionCategoryOptions previousOptions;
@property(nonatomic) AVAudioSessionRouteSharingPolicy previousPolicy;
@property(nonatomic) uint64_t epoch;
@property(nonatomic) BOOL configured, activated;
@end

@implementation CSBackgroundRunAudio
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
    if (self.playing && [self ownsConfiguration]) return YES;
    [self stop];
    if (self.hostBusy) { if (error) *error=CSAudioError(1,@"微信正在使用音频，保活已让出"); return NO; }
    AVAudioSession *session=AVAudioSession.sharedInstance;
    self.epoch=atomic_load(&hostEpoch);
    self.previousCategory=session.category; self.previousMode=session.mode;
    self.previousOptions=session.categoryOptions; self.previousPolicy=session.routeSharingPolicy;
    NSError *failure=nil;
    BOOL ok=NO;
    ownChanges++;
    @try {
        self.player=[[AVAudioPlayer alloc] initWithData:CSBackgroundRunSilentAudioData() error:&failure];
        self.player.delegate=self;
        self.player.numberOfLoops=-1;
        if (!self.player) { failure=failure?:CSAudioError(2,@"无法创建保活音频"); }
        else if (self.epoch!=atomic_load(&hostEpoch) || atomic_load(&hostCalls)) { failure=CSAudioError(3,@"微信已接管音频"); }
        else if ([session setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeDefault routeSharingPolicy:AVAudioSessionRouteSharingPolicyDefault options:AVAudioSessionCategoryOptionMixWithOthers error:&failure]) {
            self.configured=YES;
            if ([self ownsConfiguration] && [session setActive:YES error:&failure]) {
                self.activated=YES;
                if ([self ownsConfiguration]) ok=[self.player play] && self.player.isPlaying;
            }
        }
    } @catch (__unused NSException *exception) { failure=CSAudioError(4,@"音频服务暂不可用"); }
    @finally { ownChanges--; }
    // A native change during activation invalidates our lease immediately.
    if (ok && ![self ownsConfiguration]) ok=NO;
    if (!ok) {
        [self stop];
        if (error) *error=failure?:CSAudioError(5,@"系统未允许启动后台音频");
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
    ownChanges++;
    @try { [self releasePlayer]; }
    @finally { [self clearLease]; ownChanges--; }
}
- (void)suspend {
    // iOS deactivates an interrupted session. Retain its configuration lease so
    // a permitted resume can restore the pre-plugin category before restarting.
    ownChanges++;
    @try { [self releasePlayer]; }
    @finally { self.activated=NO; ownChanges--; }
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
        [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunPlaybackFailedNotification object:self];
    };
    if (NSThread.isMainThread) report(); else dispatch_async(dispatch_get_main_queue(),report);
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    [self audioPlayerDidFinishPlaying:player successfully:NO];
}
@end
