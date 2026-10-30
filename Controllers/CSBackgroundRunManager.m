#import "CSBackgroundRunManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <stdatomic.h>
#import <mach/mach_time.h>
#include <float.h>

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
@property(nonatomic, copy, readwrite) NSDictionary *policy;
@property(nonatomic, readwrite) BOOL usesLegacyPolicy;
@property(nonatomic) BOOL invalidPolicy, hasRunStart, policyPaused, lowBatteryPaused, batteryMonitoringOwned, publishedAudioActive;
@property(nonatomic) NSTimeInterval runStart;
@property(nonatomic, strong) NSTimer *boundaryTimer;
@property(nonatomic, copy) NSDate *boundaryDate;
@property(nonatomic) NSTimeInterval boundaryBudget;
@property(nonatomic) NSUInteger boundaryGeneration;
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
        id stored=[defaults objectForKey:CSBackgroundRunPolicyKey];
        _usesLegacyPolicy=stored==nil && [defaults objectForKey:CSBackgroundRunEnabledKey]!=nil;
        _invalidPolicy=stored!=nil && !CSBackgroundRunValidatePolicy(stored,NULL);
        _policy=[(stored && !_invalidPolicy?stored:(_usesLegacyPolicy?CSBackgroundRunLegacyPolicy():CSBackgroundRunDefaultPolicy())) copy];
    }
    return self;
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [_boundaryTimer invalidate];
    [_audio stop];
    if (_batteryMonitoringOwned) UIDevice.currentDevice.batteryMonitoringEnabled=NO;
}
// Keep clocks and device inputs injectable without changing the audio ownership layer.
- (NSDate *)wallNow { return NSDate.date; }
- (NSTimeInterval)continuousNow {
    static mach_timebase_info_data_t scale; static dispatch_once_t once;
    dispatch_once(&once,^{ mach_timebase_info(&scale); });
    return (NSTimeInterval)mach_continuous_time()*scale.numer/scale.denom/NSEC_PER_SEC;
}
- (NSCalendar *)policyCalendar { return NSCalendar.currentCalendar; }
- (BOOL)lowPowerModeEnabled { return NSProcessInfo.processInfo.lowPowerModeEnabled; }
- (NSProcessInfoThermalState)thermalState { return NSProcessInfo.processInfo.thermalState; }
- (float)batteryLevel { return UIDevice.currentDevice.batteryLevel; }
- (UIDeviceBatteryState)batteryState { return UIDevice.currentDevice.batteryState; }
- (NSTimeInterval)remainingDuration {
    NSTimeInterval limit=[self.policy[@"maxMinutes"] doubleValue]*60;
    return self.hasRunStart && limit>0?MAX(0,limit-([self continuousNow]-self.runStart)):-1;
}
- (void)cancelBoundaryTimer {
    self.boundaryGeneration++; [self.boundaryTimer invalidate]; self.boundaryTimer=nil;
    self.boundaryDate=nil; self.boundaryBudget=0;
}
- (NSTimer *)createBoundaryTimerAfter:(NSTimeInterval)delay handler:(void (^)(NSTimer *))handler {
    NSTimer *timer=[NSTimer timerWithTimeInterval:MAX(.01,delay) repeats:NO block:handler];
    [NSRunLoop.mainRunLoop addTimer:timer forMode:NSRunLoopCommonModes];return timer;
}
- (void)updateBoundaryTimerAt:(NSDate *)now {
    NSDate *date=CSBackgroundRunPolicyNextBoundary(self.policy,now,[self policyCalendar]);
    NSTimeInterval budget=self.hasRunStart && [self.policy[@"maxMinutes"] doubleValue]>0?self.runStart+[self.policy[@"maxMinutes"] doubleValue]*60:0;
    if (budget>0 && budget<=[self continuousNow]) { [self cancelBoundaryTimer];return; }
    if (!date && budget==0) { if(self.boundaryTimer)[self cancelBoundaryTimer];return; }
    if (self.boundaryTimer.valid && ((date==nil && self.boundaryDate==nil)||[date isEqual:self.boundaryDate]) && budget==self.boundaryBudget) return;
    [self cancelBoundaryTimer];self.boundaryDate=date;self.boundaryBudget=budget;
    NSTimeInterval delay=date?[date timeIntervalSinceDate:now]:DBL_MAX;
    if (budget>0) delay=MIN(delay,budget-[self continuousNow]);
    NSUInteger generation=self.boundaryGeneration;
    __weak typeof(self) weakSelf=self;
    self.boundaryTimer=[self createBoundaryTimerAfter:delay handler:^(__unused NSTimer *timer){
        typeof(self) self=weakSelf;if(!self || self.boundaryGeneration!=generation)return;
        [self cancelBoundaryTimer];[self reconcile];
    }];
}
- (void)updateBatteryMonitoring {
    BOOL needed=self.enabled && self.background && !self.invalidPolicy && [self.policy[@"energySaving"] boolValue];
    UIDevice *device=UIDevice.currentDevice;
    if (needed && !device.batteryMonitoringEnabled) { device.batteryMonitoringEnabled=YES;self.batteryMonitoringOwned=YES; }
    else if (!needed && self.batteryMonitoringOwned) { device.batteryMonitoringEnabled=NO;self.batteryMonitoringOwned=NO; }
}
- (void)setEnabled:(BOOL)enabled {
    NSAssert(NSThread.isMainThread,@"Background settings are main-thread owned");
    // A new user's first toggle persists the new defaults before creating the
    // legacy enable key. Existing users retain their original effective policy.
    if (!self.usesLegacyPolicy && ![self.defaults objectForKey:CSBackgroundRunPolicyKey])
        [self.defaults setObject:CSBackgroundRunDefaultPolicy() forKey:CSBackgroundRunPolicyKey];
    [self.defaults setBool:enabled forKey:CSBackgroundRunEnabledKey];
    [self reloadSettings];
    [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunSettingsChangedNotification object:self];
}
- (BOOL)savePolicy:(NSDictionary *)policy error:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Background settings are main-thread owned");
    if(!CSBackgroundRunValidatePolicy(policy,error))return NO;
    [self.defaults setObject:[policy copy] forKey:CSBackgroundRunPolicyKey];
    [self reloadSettings];
    [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunSettingsChangedNotification object:self];return YES;
}
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
        UIDeviceBatteryLevelDidChangeNotification, UIDeviceBatteryStateDidChangeNotification,
        NSProcessInfoPowerStateDidChangeNotification, NSProcessInfoThermalStateDidChangeNotification,
        UIApplicationSignificantTimeChangeNotification, NSSystemTimeZoneDidChangeNotification,
        @"com.wechat.tweak.settings_changed", @"com.wechat.tweak.local_settings_changed"
    ]) [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleNotification:) name:name object:nil];
    [self reloadSettings];
    [self reconcile];
}
- (BOOL)hasForegroundSceneExcept:(id)excluded {
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (scene==excluded) continue;
        if (scene.activationState==UISceneActivationStateForegroundActive || scene.activationState==UISceneActivationStateForegroundInactive) return YES;
    }
    return NO;
}
- (void)publish:(NSString *)status {
    BOOL active=self.backgroundAudioActive;
    BOOL changed=![self.statusText isEqual:status] || active!=self.publishedAudioActive;
    self.publishedAudioActive=active;
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
    id stored=[self.defaults objectForKey:CSBackgroundRunPolicyKey];
    BOOL invalid=stored!=nil && !CSBackgroundRunValidatePolicy(stored,NULL);
    BOOL legacy=stored==nil && self.usesLegacyPolicy;
    NSDictionary *policy=stored && !invalid?stored:(legacy?CSBackgroundRunLegacyPolicy():CSBackgroundRunDefaultPolicy());
    BOOL changed=enabled!=self.enabled || invalid!=self.invalidPolicy || legacy!=self.usesLegacyPolicy || ![policy isEqual:self.policy];
    if (!changed) return; // Unrelated defaults notifications do not touch audio or timers.
    if (enabled!=self.enabled) self.attempted=NO;
    _enabled=enabled;self.policy=[policy copy];self.usesLegacyPolicy=legacy;self.invalidPolicy=invalid;
    [self reconcile];
}
- (NSString *)energyPauseReason {
    NSProcessInfoThermalState thermal=[self thermalState];
    if (thermal==NSProcessInfoThermalStateCritical) return @"温度过高，保活已停止";
    if (![self.policy[@"energySaving"] boolValue]) { self.lowBatteryPaused=NO;return nil; }
    float level=[self batteryLevel];UIDeviceBatteryState state=[self batteryState];
    BOOL charging=state==UIDeviceBatteryStateCharging || state==UIDeviceBatteryStateFull;
    if (charging || level>=.25f || level<0) self.lowBatteryPaused=NO;
    else if (level<=.20f) self.lowBatteryPaused=YES;
    if (thermal==NSProcessInfoThermalStateSerious) return @"温度偏高，节能暂停";
    if ([self lowPowerModeEnabled]) return @"低电量模式，节能暂停";
    return self.lowBatteryPaused?@"电量不足，节能暂停":nil;
}
- (void)pauseForPolicy:(NSString *)reason {
    self.policyPaused=YES;[self.audio stop];[self publish:reason];
}
- (void)reconcile {
    [self updateBatteryMonitoring];
    if (!self.enabled || !self.background) {
        [self cancelBoundaryTimer];[self.audio stop];
        [self publish:self.enabled?@"前台待机":@"未启用"];return;
    }
    if (self.invalidPolicy) { [self cancelBoundaryTimer];[self pauseForPolicy:@"后台策略无效，请重新保存设置"];return; }
    if (!self.supportsBackgroundAudio) { [self cancelBoundaryTimer];[self.audio stop];[self publish:@"当前微信包未声明后台音频能力"];return; }
    NSDate *now=[self wallNow];
    if (self.remainingDuration==0) { [self cancelBoundaryTimer];[self pauseForPolicy:@"本次后台运行时长已用完"];return; }
    [self updateBoundaryTimerAt:now];
    NSString *energy=[self energyPauseReason]; // Update battery hysteresis even outside the time window.
    if (!CSBackgroundRunPolicyAllowsDate(self.policy,now,[self policyCalendar])) { [self pauseForPolicy:@"不在允许时段"];return; }
    if (energy) { [self pauseForPolicy:energy];return; }
    if (self.policyPaused) { self.policyPaused=NO;self.attempted=NO; }
    if (self.mediaLost || self.interrupted || self.resumeBlocked) {
        if (self.mediaLost) [self.audio relinquish]; else [self.audio suspend];
        [self publish:self.mediaLost?@"音频服务不可用":@"系统音频中断，等待允许恢复"];return;
    }
    if (self.hostYielded || self.audio.hostBusy) {
        self.hostYielded=YES;[self.audio relinquish];[self publish:@"微信正在使用音频，保活已让出"];return;
    }
    if (self.audio.playing) { [self publish:@"后台音频已启动"];return; }
    if (self.attempted) return;
    self.attempted=YES;NSError *error=nil;
    if ([self.audio startWithError:&error]) {
        if (!self.hasRunStart) { self.runStart=[self continuousNow];self.hasRunStart=YES;[self updateBoundaryTimerAt:now]; }
        self.hostYielded=NO;[self publish:@"后台音频已启动"];
    } else [self publish:[NSString stringWithFormat:@"启动失败：%@",error.localizedDescription?:@"音频未开始播放"]];
}
- (void)setBackgroundState:(BOOL)background {
    if (self.background!=background) {
        self.background=background; self.attempted=NO;
        self.hostYielded=NO;
        // Returning to the foreground creates a new opportunity on the next exit.
        // Media-server loss and an ongoing interruption remain authoritative.
        if (!background) {
            self.resumeBlocked=NO;self.hasRunStart=NO;self.runStart=0;
            self.policyPaused=NO;self.lowBatteryPaused=NO;
        }
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
    if ([name isEqual:UIApplicationSignificantTimeChangeNotification] || [name isEqual:NSSystemTimeZoneDidChangeNotification]) {
        [self cancelBoundaryTimer];[self reconcile];return;
    }
    if ([name isEqual:UIDeviceBatteryLevelDidChangeNotification] || [name isEqual:UIDeviceBatteryStateDidChangeNotification] ||
        [name isEqual:NSProcessInfoPowerStateDidChangeNotification] || [name isEqual:NSProcessInfoThermalStateDidChangeNotification]) {
        [self reconcile];return;
    }
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
