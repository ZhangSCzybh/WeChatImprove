#import "CSBackgroundRunManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <stdatomic.h>

NSString *const CSBackgroundRunDefaultsSuite=@"com.cyansmoke.wechattweak";
NSString *const CSBackgroundRunEnabledKey=@"BackgroundRunEnabled";
NSNotificationName const CSBackgroundRunSettingsChangedNotification=@"BackgroundRunStatusChanged";
NSNotificationName const CSBackgroundRunStateChangedNotification=@"CSBackgroundRunStateChanged";

@interface CSBackgroundRunManager () {
    atomic_bool _refreshPending;
}
@property(nonatomic, strong) NSUserDefaults *defaults;
@property(nonatomic, strong) id<CSBackgroundRunAudio> audio;
@property(nonatomic, readwrite) BOOL enabled, supportsBackgroundAudio;
@property(nonatomic, copy, readwrite) NSString *statusText, *lastBackgroundResult;
@property(nonatomic) BOOL started, background, attempted, interrupted, resumeBlocked, mediaLost, hostYielded;
@end

@implementation CSBackgroundRunManager
+ (instancetype)sharedManager {
    static CSBackgroundRunManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        id modes=[NSBundle.mainBundle objectForInfoDictionaryKey:@"UIBackgroundModes"];
        manager=[[self alloc] initWithDefaults:[[NSUserDefaults alloc] initWithSuiteName:CSBackgroundRunDefaultsSuite]
            audio:[CSBackgroundRunAudio new] supportsBackgroundAudio:[modes isKindOfClass:NSArray.class] && [modes containsObject:@"audio"]];
    });
    return manager;
}
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults audio:(id<CSBackgroundRunAudio>)audio supportsBackgroundAudio:(BOOL)supported {
    if ((self=[super init])) {
        _defaults=defaults; _audio=audio; _supportsBackgroundAudio=supported;
        _statusText=@"未启用"; _lastBackgroundResult=@"尚未尝试";
    }
    return self;
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (BOOL)backgroundAudioActive { return self.enabled && self.background && self.audio.playing && self.audio.sessionOwned; }
- (void)start {
    NSAssert(NSThread.isMainThread,@"Background manager is main-thread owned");
    if (self.started) return;
    self.started=YES;
    self.background=UIApplication.sharedApplication.applicationState==UIApplicationStateBackground && ![self hasForegroundSceneExcept:nil];
    for (NSString *name in @[
        UIApplicationDidEnterBackgroundNotification, UIApplicationWillEnterForegroundNotification, UIApplicationDidBecomeActiveNotification,
        UISceneDidEnterBackgroundNotification, UISceneWillEnterForegroundNotification, UISceneDidActivateNotification, UISceneDidDisconnectNotification,
        AVAudioSessionInterruptionNotification, AVAudioSessionMediaServicesWereLostNotification, AVAudioSessionMediaServicesWereResetNotification,
        AVAudioSessionRouteChangeNotification, CSBackgroundRunHostAudioChangedNotification, CSBackgroundRunPlaybackFailedNotification,
        CSBackgroundRunSettingsChangedNotification, NSUserDefaultsDidChangeNotification,
        @"com.wechat.tweak.settings_changed", @"com.wechat.tweak.local_settings_changed"
    ]) [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleNotification:) name:name object:nil];
    [self reloadSettings];
}
- (BOOL)hasForegroundSceneExcept:(id)excluded {
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (scene==excluded) continue;
        if (scene.activationState==UISceneActivationStateForegroundActive || scene.activationState==UISceneActivationStateForegroundInactive) return YES;
    }
    return NO;
}
- (void)publish:(NSString *)status {
    BOOL changed=![self.statusText isEqual:status];
    self.statusText=status;
    if (self.background && self.enabled && ![self.lastBackgroundResult isEqual:status]) { self.lastBackgroundResult=status; changed=YES; }
    if (changed) [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:self];
}
- (void)reloadSettings {
    if (!NSThread.isMainThread) {
        if (!atomic_exchange(&_refreshPending,true)) dispatch_async(dispatch_get_main_queue(),^{ atomic_store(&self->_refreshPending,false); [self reloadSettings]; });
        return;
    }
    BOOL enabled=[self.defaults boolForKey:CSBackgroundRunEnabledKey];
    if (self.enabled!=enabled) self.attempted=NO;
    self.enabled=enabled;
    [self reconcile];
}
- (void)reconcile {
    if (!self.enabled || !self.background) {
        [self.audio stop];
        [self publish:self.enabled?@"前台待机":@"未启用"];
        return;
    }
    if (!self.supportsBackgroundAudio) { [self.audio stop]; [self publish:@"当前微信包未声明后台音频能力"]; return; }
    if (self.mediaLost || self.interrupted || self.resumeBlocked) {
        if (self.mediaLost) [self.audio relinquish]; else [self.audio suspend];
        [self publish:self.mediaLost?@"音频服务不可用":@"系统音频中断，等待允许恢复"];
        return;
    }
    if (self.hostYielded || self.audio.hostBusy) {
        self.hostYielded=YES; [self.audio relinquish];
        [self publish:@"微信正在使用音频，保活已让出"];
        return;
    }
    if (self.audio.playing) { [self publish:@"后台音频已启动"]; return; }
    if (self.attempted) return;
    self.attempted=YES;
    NSError *error=nil;
    if ([self.audio startWithError:&error]) { self.hostYielded=NO; [self publish:@"后台音频已启动"]; }
    else [self publish:[NSString stringWithFormat:@"启动失败：%@",error.localizedDescription?:@"音频未开始播放"]];
}
- (void)setBackgroundState:(BOOL)background {
    if (self.background!=background) {
        self.background=background; self.attempted=NO;
        self.hostYielded=NO;
        // Returning to the foreground creates a new opportunity on the next exit.
        // Media-server loss and an ongoing interruption remain authoritative.
        if (!background) self.resumeBlocked=NO;
    }
    [self reconcile];
}
- (void)handleNotification:(NSNotification *)note {
    NSString *name=note.name;
    if ([name isEqual:CSBackgroundRunSettingsChangedNotification] || [name isEqual:NSUserDefaultsDidChangeNotification] ||
        [name isEqual:@"com.wechat.tweak.settings_changed"] || [name isEqual:@"com.wechat.tweak.local_settings_changed"]) {
        [self reloadSettings]; return;
    }
    // Never make a native audio/service thread wait for the main queue.
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self handleNotification:note]; }); return; }
    if ([name isEqual:UIApplicationWillEnterForegroundNotification] || [name isEqual:UIApplicationDidBecomeActiveNotification] ||
        [name isEqual:UISceneWillEnterForegroundNotification] || [name isEqual:UISceneDidActivateNotification]) {
        [self setBackgroundState:NO]; return;
    }
    if ([name isEqual:UIApplicationDidEnterBackgroundNotification] || [name isEqual:UISceneDidEnterBackgroundNotification]) {
        BOOL current=UIApplication.sharedApplication.applicationState==UIApplicationStateBackground;
        if ([note.object isKindOfClass:UIScene.class]) current=((UIScene *)note.object).activationState==UISceneActivationStateBackground;
        [self setBackgroundState:current && ![self hasForegroundSceneExcept:note.object]]; return;
    }
    if ([name isEqual:UISceneDidDisconnectNotification]) {
        [self setBackgroundState:UIApplication.sharedApplication.applicationState==UIApplicationStateBackground && ![self hasForegroundSceneExcept:note.object]]; return;
    }
    if ([name isEqual:AVAudioSessionInterruptionNotification]) {
        NSNumber *type=note.userInfo[AVAudioSessionInterruptionTypeKey];
        if (![type isKindOfClass:NSNumber.class]) return;
        if (type.unsignedIntegerValue==AVAudioSessionInterruptionTypeBegan) {
            self.interrupted=YES; [self.audio suspend];
        } else if (type.unsignedIntegerValue==AVAudioSessionInterruptionTypeEnded) {
            if (!self.interrupted) return; // Ignore stale/unpaired end notifications.
            NSNumber *options=note.userInfo[AVAudioSessionInterruptionOptionKey];
            BOOL resume=[options isKindOfClass:NSNumber.class] && (options.unsignedIntegerValue&AVAudioSessionInterruptionOptionShouldResume);
            self.interrupted=NO; self.resumeBlocked=!resume;
            if (resume) self.attempted=NO;
        }
    } else if ([name isEqual:AVAudioSessionMediaServicesWereLostNotification]) {
        self.mediaLost=YES; [self.audio relinquish];
    } else if ([name isEqual:AVAudioSessionMediaServicesWereResetNotification]) {
        [self.audio relinquish]; self.mediaLost=NO; self.attempted=NO;
    } else if ([name isEqual:CSBackgroundRunHostAudioChangedNotification]) {
        if (self.audio.playing && self.audio.sessionOwned) return; // A queued event predating this lease.
        [self.audio relinquish];
        self.hostYielded=YES; self.attempted=YES;
        if ([note.userInfo[@"released"] boolValue] && !self.audio.hostBusy) { self.hostYielded=NO; self.attempted=NO; }
    } else if ([name isEqual:CSBackgroundRunPlaybackFailedNotification]) {
        if (note.object!=self.audio) return;
        [self.audio stop]; self.attempted=YES;
        if (self.enabled && self.background) [self publish:@"后台音频已停止，下次进入后台再尝试"];
    } else if ([name isEqual:AVAudioSessionRouteChangeNotification]) {
        // Route changes can also be caused by our own category updates. Never
        // restart from this notification; that would create a feedback loop.
        if (self.enabled && self.background && self.audio.sessionOwned && !self.audio.playing && self.attempted && !self.hostYielded && !self.interrupted && !self.mediaLost) {
            [self.audio stop]; [self publish:@"音频路由已变化，下次进入后台再尝试"];
        }
    }
    [self reconcile];
}
@end
