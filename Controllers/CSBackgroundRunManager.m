#import "CSBackgroundRunManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <stdatomic.h>
#import <math.h>

NSString *const CSBackgroundRunDefaultsSuite=@"com.cyansmoke.wechattweak";
NSString *const CSBackgroundRunEnabledKey=@"BackgroundRunEnabled";
NSNotificationName const CSBackgroundRunSettingsChangedNotification=@"BackgroundRunStatusChanged";
NSNotificationName const CSBackgroundRunStateChangedNotification=@"CSBackgroundRunStateChanged";

static const NSTimeInterval CSRunRotationInterval=26, CSRunAudioThreshold=8, CSRunCleanupThreshold=5;
static const NSTimeInterval CSRunRecoveryThreshold=12, CSRunMinimumAudioDuration=5;
static const NSUInteger CSRunRecoverySampleCount=2;
// UIKit can report an effectively unlimited budget while audio is active. Such
// values are execution opportunities, but never independent recovery evidence.
static BOOL CSRunFiniteBudget(NSTimeInterval remaining) { return isfinite(remaining) && remaining>=0 && remaining<1e12; }
typedef NS_ENUM(NSUInteger, CSBackgroundRunPhase) {
    CSRunDisabled, CSRunStandby, CSRunTask, CSRunAudio, CSRunYielding, CSRunWaiting, CSRunEnded
};

@interface CSBackgroundRunManager () {
    atomic_bool _refreshPending;
}
@property(nonatomic, strong) NSUserDefaults *defaults;
@property(nonatomic, strong) id<CSBackgroundRunAudio> audio;
@property(nonatomic, strong) id<CSBackgroundRunRuntime> runtime;
@property(nonatomic, strong) id<CSBackgroundRunTask> task;
@property(nonatomic, strong) id<CSBackgroundRunScheduledCheck> scheduledCheck;
@property(nonatomic, readwrite) BOOL enabled, supportsBackgroundAudio;
@property(nonatomic, copy, readwrite) NSString *statusText, *lastBackgroundResult;
@property(nonatomic, copy, readwrite) NSDate *lastBackgroundStartedAt, *lastBackgroundCheckedAt, *lastForegroundReturnedAt, *lastBackgroundStoppedAt;
@property(nonatomic, copy, readwrite) NSString *lastBackgroundCheckStatus, *lastBackgroundStopReason;
@property(nonatomic, readwrite) BOOL lastBackgroundStartObserved;
@property(nonatomic, readwrite) NSTimeInterval lastCheckToForegroundInterval;
@property(nonatomic) BOOL observationOpen, checkRecordRequested;
@property(nonatomic) NSTimeInterval lastCheckUptime;
@property(nonatomic, copy) NSString *audioFailure;
@property(nonatomic) BOOL started, background, attempted, interrupted, resumeBlocked, mediaLost, hostYielded;
@property(nonatomic) BOOL cycleActive, cycleEnded, rotationFailed, reconciling, reconcileAgain;
@property(nonatomic) BOOL taskExpirationPending;
@property(nonatomic) BOOL groupChatRequested, publishedWork, publishedGroupChatWork, publishedAudio;
@property(nonatomic) NSUInteger generation, checkGeneration, recoverySamples;
@property(nonatomic) CSBackgroundRunPhase phase;
@property(nonatomic) NSTimeInterval nextRotation, checkDeadline, audioStartedAt, lastRecoverySample;
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
    return [self initWithDefaults:defaults audio:audio supportsBackgroundAudio:supported runtime:[CSBackgroundRunRuntime new]];
}
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults audio:(id<CSBackgroundRunAudio>)audio supportsBackgroundAudio:(BOOL)supported runtime:(id<CSBackgroundRunRuntime>)runtime {
    if ((self=[super init])) {
        _defaults=defaults; _audio=audio; _runtime=runtime; _supportsBackgroundAudio=supported;
        _statusText=@"未启用"; _lastBackgroundResult=@"尚未尝试";
        _lastBackgroundCheckStatus=@"尚未检查"; _lastBackgroundStopReason=@"尚无记录";
        _lastCheckToForegroundInterval=-1; _lastCheckUptime=-1;
    }
    return self;
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [_scheduledCheck cancel]; [_task end]; [_audio stop];
}
- (BOOL)resourcesRequested { return self.enabled || self.groupChatRequested; }
- (BOOL)backgroundAudioActive { return self.resourcesRequested && self.background && self.audio.playing && self.audio.sessionOwned; }
- (BOOL)executionAvailable {
    return self.resourcesRequested && self.background && self.cycleActive && !self.cycleEnded &&
        (self.backgroundAudioActive || (self.task.valid && self.runtime.backgroundTimeRemaining>0));
}
- (BOOL)canAttemptBackgroundWork { return self.enabled && self.executionAvailable; }
- (BOOL)canAttemptGroupChatBackgroundWork { return self.groupChatRequested && self.executionAvailable; }
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
- (void)publish:(NSString *)status phase:(CSBackgroundRunPhase)phase {
    BOOL available=self.executionAvailable, audio=self.backgroundAudioActive;
    BOOL work=self.enabled && available, groupWork=self.groupChatRequested && available;
    BOOL changed=self.phase!=phase || self.publishedWork!=work || self.publishedGroupChatWork!=groupWork || self.publishedAudio!=audio || ![self.statusText isEqual:status];
    self.phase=phase; self.publishedWork=work; self.publishedGroupChatWork=groupWork; self.publishedAudio=audio; self.statusText=status;
    if (self.checkRecordRequested && self.observationOpen && self.background && self.resourcesRequested) {
        self.checkRecordRequested=NO;
        self.lastBackgroundCheckedAt=self.runtime.currentDate;
        self.lastBackgroundCheckStatus=status;
        NSTimeInterval now=self.runtime.uptime;
        self.lastCheckUptime=isfinite(now) && now>=0?now:-1;
        // Settings reread records on foreground entry. A timestamp-only update
        // must not wake state observers such as the AI configuration manager.
    }
    if (self.background && self.resourcesRequested && ![self.lastBackgroundResult isEqual:status]) { self.lastBackgroundResult=status; changed=YES; }
    if (changed) [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:self];
}
- (void)beginObservationWithKnownEntry:(BOOL)knownEntry {
    self.observationOpen=YES;
    self.lastBackgroundStartedAt=self.runtime.currentDate;
    self.lastBackgroundStartObserved=knownEntry;
    self.lastBackgroundCheckedAt=nil; self.lastBackgroundCheckStatus=@"尚未检查";
    self.lastForegroundReturnedAt=nil; self.lastBackgroundStoppedAt=nil;
    self.lastBackgroundStopReason=@"尚未结束";
    self.lastCheckToForegroundInterval=-1; self.lastCheckUptime=-1;
    self.lastBackgroundResult=@"尚未检查";
}
- (void)recordStop:(NSString *)reason {
    if (!self.observationOpen || self.lastBackgroundStoppedAt) return;
    self.lastBackgroundStoppedAt=self.runtime.currentDate;
    self.lastBackgroundStopReason=reason;
}
- (void)recordForegroundReturn {
    if (!self.observationOpen) return;
    self.lastForegroundReturnedAt=self.runtime.currentDate;
    [self recordStop:@"返回前台，后台运行已停止"];
    NSTimeInterval now=self.runtime.uptime;
    self.lastCheckToForegroundInterval=self.lastCheckUptime>=0 && isfinite(now) && now>=self.lastCheckUptime?now-self.lastCheckUptime:-1;
    self.observationOpen=NO;
    self.checkRecordRequested=NO;
}
- (void)cancelCheck {
    self.checkGeneration++; [self.scheduledCheck cancel]; self.scheduledCheck=nil;
}
- (void)releaseResources {
    self.generation++; self.cycleActive=NO;
    self.taskExpirationPending=NO;
    [self cancelCheck];
    id<CSBackgroundRunTask> task=self.task; self.task=nil; [task end];
    [self.audio stop]; self.recoverySamples=0;
}
- (void)finishCycle:(NSString *)reason {
    [self recordStop:reason];
    self.cycleEnded=YES; [self releaseResources];
    [self publish:reason phase:CSRunEnded];
}
- (void)reconcileDemandFrom:(BOOL)previouslyRequested stopReason:(NSString *)stopReason {
    BOOL requested=self.resourcesRequested;
    // A second consumer shares the current cycle, including its budget and expiration.
    if (requested!=previouslyRequested) {
        self.attempted=NO; self.cycleEnded=NO; self.audioFailure=nil;
        if (self.background) {
            if (requested) {
                if (!self.observationOpen) [self beginObservationWithKnownEntry:NO];
                self.lastBackgroundStoppedAt=nil; self.lastBackgroundStopReason=@"尚未结束";
                self.checkRecordRequested=YES;
            } else { [self recordStop:stopReason]; self.checkRecordRequested=NO; }
        }
    }
    [self reconcile];
}
- (void)reloadSettings {
    if (!NSThread.isMainThread) {
        if (!atomic_exchange(&_refreshPending,true)) dispatch_async(dispatch_get_main_queue(),^{ atomic_store(&self->_refreshPending,false); [self reloadSettings]; });
        return;
    }
    BOOL previouslyRequested=self.resourcesRequested;
    self.enabled=[self.defaults boolForKey:CSBackgroundRunEnabledKey];
    [self reconcileDemandFrom:previouslyRequested stopReason:@"关闭后台运行"];
}
- (void)setGroupChatBackgroundRequested:(BOOL)requested {
    NSAssert(NSThread.isMainThread,@"Background manager is main-thread owned");
    if (self.groupChatRequested==requested) return;
    BOOL previouslyRequested=self.resourcesRequested;
    self.groupChatRequested=requested;
    [self reconcileDemandFrom:previouslyRequested stopReason:@"群聊已停止请求后台运行"];
}
- (void)taskExpired:(id<CSBackgroundRunTask>)task generation:(NSUInteger)generation {
    if (generation!=self.generation || task!=self.task) return;
    [task end]; self.task=nil; self.rotationFailed=YES;
    self.checkRecordRequested=YES;
    // Expiration can reenter while a native activation is still on the stack.
    // Finish that operation before stopping/restoring its audio session.
    self.taskExpirationPending=YES;
    [self reconcile];
}
- (void)replaceTaskAtTime:(NSTimeInterval)now {
    NSUInteger generation=self.generation;
    __weak typeof(self) weakSelf=self;
    id<CSBackgroundRunTask> candidate=[self.runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> expired){
        [weakSelf taskExpired:expired generation:generation];
    }];
    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) { [candidate end]; return; }
    if (!candidate.valid) { [candidate end]; self.rotationFailed=YES; return; }
    id<CSBackgroundRunTask> old=self.task;
    self.task=candidate; self.nextRotation=now+CSRunRotationInterval;
    [old end];
}
- (void)scheduleCheckAfter:(NSTimeInterval)delay now:(NSTimeInterval)now {
    if (!isfinite(delay)) delay=CSRunRotationInterval;
    delay=MAX(.1,delay);
    NSTimeInterval deadline=now+delay;
    // Repeated settings/lifecycle notifications cannot postpone an earlier check.
    if (self.scheduledCheck && self.checkDeadline<=deadline+.01) return;
    [self cancelCheck];
    self.checkDeadline=deadline;
    NSUInteger checkGeneration=self.checkGeneration, generation=self.generation;
    __weak typeof(self) weakSelf=self;
    self.scheduledCheck=[self.runtime scheduleAfter:delay handler:^{
        CSBackgroundRunManager *manager=weakSelf;
        if (!manager || checkGeneration!=manager.checkGeneration || generation!=manager.generation || !manager.cycleActive) return;
        manager.scheduledCheck=nil;
        manager.checkRecordRequested=YES;
        [manager reconcile];
    }];
}
- (void)reconcile {
    if (self.reconciling) { self.reconcileAgain=YES; return; }
    self.reconciling=YES;
    @try {
        do { self.reconcileAgain=NO; [self reconcileOnce]; } while (self.reconcileAgain);
    } @finally { self.reconciling=NO; }
}
- (void)reconcileOnce {
    if (!self.resourcesRequested || !self.background) {
        self.checkRecordRequested=NO;
        [self releaseResources]; self.cycleEnded=NO;
        NSString *status=self.enabled?@"前台待机":(self.groupChatRequested?@"群聊实时待机":@"未启用");
        [self publish:status phase:self.resourcesRequested?CSRunStandby:CSRunDisabled];
        return;
    }
    if (self.cycleEnded) { [self publish:self.statusText phase:CSRunEnded]; return; }
    if (self.taskExpirationPending) {
        self.taskExpirationPending=NO;
        if (!self.task.valid && !self.backgroundAudioActive) { [self finishCycle:@"后台任务已到期，本轮运行结束"]; return; }
    }
    NSTimeInterval now=self.runtime.uptime;
    if (!isfinite(now) || now<0) { [self finishCycle:@"后台时钟不可用，本轮运行结束"]; return; }
    if (!self.cycleActive) {
        self.cycleActive=YES; self.generation++; self.rotationFailed=NO;
        [self replaceTaskAtTime:now];
    }
    if (!self.cycleActive || !self.resourcesRequested || !self.background) return;
    NSUInteger generation=self.generation;
    if (self.task && !self.task.valid) {
        id<CSBackgroundRunTask> expired=self.task; self.task=nil; [expired end]; self.rotationFailed=YES;
        if (!self.backgroundAudioActive) { [self finishCycle:@"后台任务已到期，本轮运行结束"]; return; }
    }
    if (self.task.valid && !self.rotationFailed && now>=self.nextRotation) [self replaceTaskAtTime:now];
    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
    if (self.taskExpirationPending) return;
    NSTimeInterval remaining=self.runtime.backgroundTimeRemaining;
    BOOL finite=CSRunFiniteBudget(remaining);
    BOOL taskUsable=self.task.valid && remaining>0;
    NSString *audioBlocked=nil;
    CSBackgroundRunPhase blockedPhase=CSRunWaiting;
    if (!self.supportsBackgroundAudio) audioBlocked=@"当前微信包未声明后台音频能力";
    else if (self.mediaLost || self.interrupted || self.resumeBlocked) {
        if (self.mediaLost) [self.audio relinquish]; else [self.audio suspend];
        audioBlocked=self.mediaLost?@"音频服务不可用":@"系统音频中断，等待允许恢复";
    } else if (self.hostYielded || self.audio.hostBusy) {
        self.hostYielded=YES; [self.audio relinquish];
        audioBlocked=@"微信正在使用音频，保活已让出"; blockedPhase=CSRunYielding;
    }
    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
    if (!self.backgroundAudioActive) self.recoverySamples=0;
    BOOL needsAudio=!taskUsable || (finite && remaining<CSRunAudioThreshold);
    if (needsAudio && !self.backgroundAudioActive && !audioBlocked && !self.attempted) {
        self.attempted=YES;
        NSError *error=nil;
        BOOL started=[self.audio startWithError:&error];
        if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
        if (started && self.backgroundAudioActive) {
            self.hostYielded=NO; self.audioFailure=nil; self.audioStartedAt=now;
            self.recoverySamples=0; self.lastRecoverySample=-INFINITY;
        } else self.audioFailure=[NSString stringWithFormat:@"启动失败：%@",error.localizedDescription?:@"音频未开始播放"];
    }
    if (self.taskExpirationPending) return;
    if (self.backgroundAudioActive) {
        if (taskUsable && finite && remaining>=CSRunRecoveryThreshold && now-self.audioStartedAt>=CSRunMinimumAudioDuration) {
            if (!self.recoverySamples || now-self.lastRecoverySample>=1) { self.recoverySamples++; self.lastRecoverySample=now; }
            if (self.recoverySamples>=CSRunRecoverySampleCount) {
                [self.audio stop]; self.recoverySamples=0; self.attempted=NO;
            }
        } else self.recoverySamples=0;
    }
    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
    if (!self.backgroundAudioActive && (!taskUsable || (finite && remaining<CSRunCleanupThreshold))) {
        [self finishCycle:audioBlocked?:self.audioFailure?:@"后台预算不足，本轮运行结束"];
        return;
    }
    NSString *status;
    CSBackgroundRunPhase phase;
    if (self.backgroundAudioActive) { status=@"后台音频已启动"; phase=CSRunAudio; }
    else if (audioBlocked) { status=[@"有限后台任务运行中 · " stringByAppendingString:audioBlocked]; phase=blockedPhase; }
    else if (self.audioFailure) { status=[@"有限后台任务运行中 · " stringByAppendingString:self.audioFailure]; phase=CSRunTask; }
    else { status=@"有限后台任务运行中"; phase=CSRunTask; }
    NSTimeInterval delay=CSRunRotationInterval;
    if (self.task.valid && !self.rotationFailed) delay=MIN(delay,self.nextRotation-now);
    // Observe the earliest allowed audio exit even if UIKit currently reports
    // an unbounded budget. This adds one boundary check, not a polling loop.
    if (self.backgroundAudioActive && now-self.audioStartedAt<CSRunMinimumAudioDuration)
        delay=MIN(delay,CSRunMinimumAudioDuration-(now-self.audioStartedAt));
    if (finite && self.task.valid) {
        if (!self.backgroundAudioActive) delay=MIN(delay,remaining>CSRunAudioThreshold?remaining-CSRunAudioThreshold:1);
        else if (remaining>=CSRunRecoveryThreshold) delay=MIN(delay,MAX(1,CSRunMinimumAudioDuration-(now-self.audioStartedAt)));
        else if (remaining<CSRunAudioThreshold) delay=MIN(delay,1);
    }
    [self scheduleCheckAfter:delay now:now];
    [self publish:status phase:phase];
}
- (void)setBackgroundState:(BOOL)background {
    if (self.background!=background) {
        if (background && self.resourcesRequested) {
            [self beginObservationWithKnownEntry:YES];
            self.checkRecordRequested=YES;
        } else if (!background) [self recordForegroundReturn];
        self.background=background; self.attempted=NO; self.cycleEnded=NO;
        self.hostYielded=NO; self.audioFailure=nil;
        if (!background) self.resumeBlocked=NO;
    }
    [self reconcile];
}
- (void)allowAudioRetry {
    self.attempted=NO; self.audioFailure=nil;
    // A real release/resume event may create a new opportunity after a task-only
    // session ended. Ordinary route/defaults notifications cannot do so.
    self.cycleEnded=NO;
    if (self.observationOpen && self.background && self.resourcesRequested) {
        self.lastBackgroundStoppedAt=nil; self.lastBackgroundStopReason=@"尚未结束";
        self.checkRecordRequested=YES;
    }
}
- (void)handleNotification:(NSNotification *)note {
    NSString *name=note.name;
    if ([name isEqual:CSBackgroundRunSettingsChangedNotification] || [name isEqual:NSUserDefaultsDidChangeNotification] ||
        [name isEqual:@"com.wechat.tweak.settings_changed"] || [name isEqual:@"com.wechat.tweak.local_settings_changed"]) {
        [self reloadSettings]; return;
    }
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
            if (!self.interrupted) return;
            NSNumber *options=note.userInfo[AVAudioSessionInterruptionOptionKey];
            BOOL resume=[options isKindOfClass:NSNumber.class] && (options.unsignedIntegerValue&AVAudioSessionInterruptionOptionShouldResume);
            self.interrupted=NO; self.resumeBlocked=!resume;
            if (resume) [self allowAudioRetry];
        }
    } else if ([name isEqual:AVAudioSessionMediaServicesWereLostNotification]) {
        self.mediaLost=YES; [self.audio relinquish];
    } else if ([name isEqual:AVAudioSessionMediaServicesWereResetNotification]) {
        [self.audio relinquish]; self.mediaLost=NO; [self allowAudioRetry];
    } else if ([name isEqual:CSBackgroundRunHostAudioChangedNotification]) {
        if (self.audio.playing && self.audio.sessionOwned) return;
        [self.audio relinquish]; self.hostYielded=YES; self.attempted=YES;
        if ([note.userInfo[@"released"] boolValue] && !self.audio.hostBusy) { self.hostYielded=NO; [self allowAudioRetry]; }
    } else if ([name isEqual:CSBackgroundRunPlaybackFailedNotification]) {
        if (note.object!=self.audio) return;
        [self.audio stop]; self.attempted=YES; self.audioFailure=@"后台音频已停止，下次进入后台再尝试";
    } else if ([name isEqual:AVAudioSessionRouteChangeNotification]) {
        if (self.resourcesRequested && self.background && self.audio.sessionOwned && !self.audio.playing && self.attempted && !self.hostYielded && !self.interrupted && !self.mediaLost) {
            [self.audio stop]; self.audioFailure=@"音频路由已变化，下次进入后台再尝试";
        }
    }
    if (self.background && self.resourcesRequested && !self.cycleEnded) self.checkRecordRequested=YES;
    [self reconcile];
}
@end
