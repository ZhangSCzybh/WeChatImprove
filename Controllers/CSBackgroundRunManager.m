#import "CSBackgroundRunManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <stdatomic.h>
#import <math.h>
#import <float.h>

NSString *const CSBackgroundRunDefaultsSuite=@"com.cyansmoke.wechattweak";
NSString *const CSBackgroundRunEnabledKey=@"BackgroundRunEnabled";
NSString *const CSBackgroundRunCheckIntervalKey=@"BackgroundRunCheckInterval";
NSNotificationName const CSBackgroundRunSettingsChangedNotification=@"BackgroundRunStatusChanged";
NSNotificationName const CSBackgroundRunStateChangedNotification=@"CSBackgroundRunStateChanged";

static const NSTimeInterval CSRunDefaultCheckInterval=25, CSRunGraceInterval=1.5;
static const NSTimeInterval CSRunResumeInterval=.4, CSRunAudioThreshold=30;
static const NSUInteger CSRunRecordEventLimit=80;
static NSTimeInterval CSRunCheckInterval(id value) {
    if (![value isKindOfClass:NSNumber.class] || !isfinite([value doubleValue])) return CSRunDefaultCheckInterval;
    return MIN(30,MAX(10,round([value doubleValue])));
}
typedef NS_ENUM(NSUInteger, CSBackgroundRunPhase) {
    CSRunDisabled, CSRunStandby, CSRunTask, CSRunAudio, CSRunYielding, CSRunWaiting, CSRunEnded
};

@interface CSBackgroundRunRecordEvent ()
- (instancetype)initWithDate:(NSDate *)date elapsed:(NSTimeInterval)elapsed source:(NSString *)source detail:(NSString *)detail;
@end

@implementation CSBackgroundRunRecordEvent
- (instancetype)initWithDate:(NSDate *)date elapsed:(NSTimeInterval)elapsed source:(NSString *)source detail:(NSString *)detail {
    if ((self=[super init])) {
        _date=[date copy]; _elapsed=elapsed; _source=[source copy]; _detail=[detail copy];
    }
    return self;
}
@end

static NSString *CSRunRecordedBudget(NSTimeInterval remaining) {
    if (!isfinite(remaining) || remaining>=DBL_MAX/2) return @"系统未提供有限的剩余时间，本次不触发短音频";
    if (remaining<=0) return [NSString stringWithFormat:@"系统报告剩余 %.1f 秒，已无可用执行时间，本次不触发短音频",remaining];
    if (remaining>=CSRunAudioThreshold) return [NSString stringWithFormat:@"系统报告剩余 %.1f 秒，不小于 30 秒，本次不触发短音频",remaining];
    return [NSString stringWithFormat:@"系统报告剩余约 %.3f 秒，满足大于 0 且小于 30 秒的尝试条件",remaining];
}

@interface CSBackgroundRunManager () {
    atomic_bool _refreshPending;
}
@property(nonatomic, strong) NSUserDefaults *defaults;
@property(nonatomic, strong) id<CSBackgroundRunAudio> audio;
@property(nonatomic, strong) id<CSBackgroundRunRuntime> runtime;
@property(nonatomic, strong) id<CSBackgroundRunTask> task;
@property(nonatomic, strong) id<CSBackgroundRunScheduledCheck> scheduledCheck, graceCheck, resumeCheck;
@property(nonatomic, readwrite) BOOL enabled, supportsBackgroundAudio;
@property(nonatomic, readwrite) NSTimeInterval checkInterval;
@property(nonatomic, copy, readwrite) NSString *statusText, *lastBackgroundResult;
@property(nonatomic, copy, readwrite) NSDate *lastBackgroundStartedAt, *lastBackgroundCheckedAt, *lastForegroundReturnedAt, *lastBackgroundStoppedAt;
@property(nonatomic, copy, readwrite) NSString *lastBackgroundCheckStatus, *lastBackgroundStopReason;
@property(nonatomic, readwrite) BOOL lastBackgroundStartObserved;
@property(nonatomic, readwrite) NSTimeInterval lastCheckToForegroundInterval;
@property(nonatomic) BOOL observationOpen, checkRecordRequested, checkDue;
@property(nonatomic) NSTimeInterval lastCheckUptime;
@property(nonatomic, copy) NSString *audioFailure;
@property(nonatomic) BOOL started, background, interrupted, resumeBlocked, mediaLost, hostYielded;
@property(nonatomic) BOOL cycleActive, cycleEnded, reconciling, reconcileAgain, taskExpirationPending;
@property(nonatomic) BOOL groupChatRequested, publishedWork, publishedAudio;
@property(nonatomic) NSUInteger generation, checkGeneration, resumeGeneration;
@property(nonatomic) CSBackgroundRunPhase phase;
@property(nonatomic, strong) NSMutableArray<CSBackgroundRunRecordEvent *> *recordEvents;
@property(nonatomic, readwrite) NSUInteger droppedBackgroundEventCount, periodicCheckCount;
@property(nonatomic, copy, readwrite) NSDate *firstScheduledCheckAt, *lastPeriodicCheckAt, *lastTaskExpiredAt;
@property(nonatomic) NSTimeInterval observationUptime;
@property(nonatomic) NSUInteger observationIdentifier, pendingCheckObservationIdentifier, pendingCheckGeneration;
@property(nonatomic, copy) NSString *pendingCheckSource;
@property(nonatomic) NSUInteger recordedAudioGeneration, recordedAudioObservationIdentifier;
@property(nonatomic) BOOL recordedAudioAttempt;
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
        _lastCheckToForegroundInterval=-1; _lastCheckUptime=-1; _checkInterval=CSRunDefaultCheckInterval;
        _recordEvents=[NSMutableArray new]; _observationUptime=-1;
    }
    return self;
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [_scheduledCheck cancel]; [_graceCheck cancel]; [_resumeCheck cancel]; [_task end]; [_audio stop];
}
- (BOOL)resourcesRequested { return self.enabled || self.groupChatRequested; }
- (BOOL)backgroundAudioActive { return self.resourcesRequested && self.background && self.audio.playing && self.audio.sessionOwned; }
- (BOOL)executionAvailable {
    return self.resourcesRequested && self.background && self.cycleActive && !self.cycleEnded &&
        (self.backgroundAudioActive || (self.task.valid && self.runtime.backgroundTimeRemaining>0));
}
- (BOOL)canAttemptBackgroundWork { return self.enabled && self.executionAvailable; }
- (void)start {
    NSAssert(NSThread.isMainThread,@"Background manager is main-thread owned");
    if (self.started) return;
    self.started=YES;
    self.background=UIApplication.sharedApplication.applicationState==UIApplicationStateBackground && ![self hasForegroundSceneExcept:nil];
    for (NSString *name in @[
        UIApplicationDidEnterBackgroundNotification, UIApplicationWillEnterForegroundNotification, UIApplicationDidBecomeActiveNotification,
        UISceneDidEnterBackgroundNotification, UISceneWillEnterForegroundNotification, UISceneDidActivateNotification, UISceneDidDisconnectNotification,
        AVAudioSessionInterruptionNotification, AVAudioSessionMediaServicesWereLostNotification, AVAudioSessionMediaServicesWereResetNotification,
        AVAudioSessionRouteChangeNotification,
        CSBackgroundRunHostAudioChangedNotification, CSBackgroundRunPlaybackFailedNotification, CSBackgroundRunPlaybackFinishedNotification,
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
    BOOL work=self.enabled && available;
    BOOL changed=self.phase!=phase || self.publishedWork!=work || self.publishedAudio!=audio || ![self.statusText isEqual:status];
    self.phase=phase; self.publishedWork=work; self.publishedAudio=audio; self.statusText=status;
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
- (NSArray<CSBackgroundRunRecordEvent *> *)lastBackgroundEvents { return [self.recordEvents copy]; }
- (void)recordEventWithSource:(NSString *)source detail:(NSString *)detail date:(NSDate *)date uptime:(NSTimeInterval)uptime {
    if (!self.observationOpen) return;
    NSTimeInterval elapsed=isfinite(uptime) && self.observationUptime>=0 && uptime>=self.observationUptime?uptime-self.observationUptime:-1;
    CSBackgroundRunRecordEvent *event=[[CSBackgroundRunRecordEvent alloc] initWithDate:date elapsed:elapsed source:source detail:detail];
    if (self.recordEvents.count>=CSRunRecordEventLimit) {
        // Retain the entry so a truncated timeline still has its original anchor.
        [self.recordEvents removeObjectAtIndex:1]; self.droppedBackgroundEventCount++;
    }
    [self.recordEvents addObject:event];
}
- (void)recordEventWithSource:(NSString *)source detail:(NSString *)detail {
    if (!self.observationOpen) return;
    [self recordEventWithSource:source detail:detail date:self.runtime.currentDate uptime:self.runtime.uptime];
}
- (void)recordTaskExpiration:(NSString *)detail {
    if (!self.observationOpen) return;
    self.lastTaskExpiredAt=self.runtime.currentDate;
    [self recordEventWithSource:@"系统到期" detail:detail date:self.lastTaskExpiredAt uptime:self.runtime.uptime];
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
    self.observationIdentifier++; [self.recordEvents removeAllObjects];
    self.droppedBackgroundEventCount=0; self.periodicCheckCount=0;
    self.firstScheduledCheckAt=nil; self.lastPeriodicCheckAt=nil; self.lastTaskExpiredAt=nil;
    self.pendingCheckSource=nil; self.recordedAudioAttempt=NO;
    NSTimeInterval now=self.runtime.uptime;
    self.observationUptime=isfinite(now) && now>=0?now:-1;
    [self recordEventWithSource:knownEntry?@"进入后台":@"开始观察"
        detail:knownEntry?@"已收到进入后台事件；随后申请有限后台任务":@"在后台中途开始观察，此时间不是实际进入后台时间"
        date:self.lastBackgroundStartedAt uptime:now];
}
- (void)recordStop:(NSString *)reason {
    if (!self.observationOpen || self.lastBackgroundStoppedAt) return;
    self.lastBackgroundStoppedAt=self.runtime.currentDate;
    self.lastBackgroundStopReason=reason;
    [self recordEventWithSource:@"停止" detail:reason date:self.lastBackgroundStoppedAt uptime:self.runtime.uptime];
}
- (void)recordForegroundReturn {
    if (!self.observationOpen) return;
    self.lastForegroundReturnedAt=self.runtime.currentDate;
    [self recordStop:@"返回前台，后台运行已停止"];
    NSTimeInterval now=self.runtime.uptime;
    self.lastCheckToForegroundInterval=self.lastCheckUptime>=0 && isfinite(now) && now>=self.lastCheckUptime?now-self.lastCheckUptime:-1;
    [self recordEventWithSource:@"返回前台" detail:@"已收到返回前台事件；该时间不代表此前一直在后台执行" date:self.lastForegroundReturnedAt uptime:now];
    self.observationOpen=NO;
    self.checkRecordRequested=NO;
}
- (void)cancelResumeCheck {
    self.resumeGeneration++; [self.resumeCheck cancel]; self.resumeCheck=nil;
}
- (void)cancelChecks {
    self.checkGeneration++; [self.scheduledCheck cancel]; self.scheduledCheck=nil;
    [self.graceCheck cancel]; self.graceCheck=nil;
    [self cancelResumeCheck];
}
- (void)releaseResources {
    self.generation++; self.cycleActive=NO;
    self.taskExpirationPending=NO; self.checkDue=NO;
    self.pendingCheckSource=nil; self.recordedAudioAttempt=NO;
    [self cancelChecks];
    id<CSBackgroundRunTask> task=self.task; self.task=nil; [task end];
    [self.audio stop];
}
- (void)finishCycle:(NSString *)reason {
    [self recordStop:reason];
    self.cycleEnded=YES; [self releaseResources];
    [self publish:reason phase:CSRunEnded];
}
- (void)reconcileDemandFrom:(BOOL)previouslyRequested stopReason:(NSString *)stopReason {
    BOOL requested=self.resourcesRequested;
    // Consumers share one task/audio cycle; changing the consumer alone does not restart it.
    if (requested!=previouslyRequested) {
        self.cycleEnded=NO; self.audioFailure=nil;
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
    NSTimeInterval previousInterval=self.checkInterval;
    self.enabled=[self.defaults boolForKey:CSBackgroundRunEnabledKey];
    self.checkInterval=CSRunCheckInterval([self.defaults objectForKey:CSBackgroundRunCheckIntervalKey]);
    if (previousInterval!=self.checkInterval && self.cycleActive) [self schedulePeriodicCheck];
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
    [self recordTaskExpiration:@"收到系统的后台任务到期通知；后续是否继续取决于可用任务和音频"];
    [task end]; self.task=nil;
    self.checkRecordRequested=YES;
    // Expiration can reenter a native audio activation. Let it unwind before cleanup.
    self.taskExpirationPending=YES;
    [self reconcile];
}
- (void)replaceTaskWithSource:(NSString *)source observationIdentifier:(NSUInteger)observationIdentifier {
    NSUInteger generation=self.generation;
    __weak typeof(self) weakSelf=self;
    id<CSBackgroundRunTask> candidate=[self.runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> expired){
        [weakSelf taskExpired:expired generation:generation];
    }];
    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) { [candidate end]; return; }
    BOOL valid=candidate.valid;
    if (observationIdentifier==self.observationIdentifier) [self recordEventWithSource:source detail:valid?@"后台任务申请获准；不代表系统已增加剩余执行时间":@"后台任务申请未获准"];
    if (!valid) { [candidate end]; return; }
    // Keep the live task until UIKit actually grants its replacement.
    id<CSBackgroundRunTask> old=self.task;
    self.task=candidate;
    [old end];
}
- (void)performScheduledCheckWithSource:(NSString *)source {
    self.checkDue=YES; self.checkRecordRequested=YES;
    self.pendingCheckSource=source; self.pendingCheckGeneration=self.generation;
    self.pendingCheckObservationIdentifier=self.observationIdentifier;
    if (self.observationOpen) {
        NSDate *date=self.runtime.currentDate;
        if ([source isEqual:@"首次检查"] && !self.firstScheduledCheckAt) self.firstScheduledCheckAt=date;
        if ([source isEqual:@"周期检查"]) { self.lastPeriodicCheckAt=date; self.periodicCheckCount++; }
        [self recordEventWithSource:source detail:@"本次检查已开始；剩余执行时间与处理结果见后续事件" date:date uptime:self.runtime.uptime];
    }
    [self reconcile];
}
- (void)schedulePeriodicCheck {
    self.checkGeneration++; [self.scheduledCheck cancel]; self.scheduledCheck=nil;
    if (!self.cycleActive) return;
    NSUInteger checkGeneration=self.checkGeneration, generation=self.generation;
    __weak typeof(self) weakSelf=self;
    self.scheduledCheck=[self.runtime scheduleAfter:self.checkInterval handler:^{
        CSBackgroundRunManager *manager=weakSelf;
        if (!manager || checkGeneration!=manager.checkGeneration || generation!=manager.generation || !manager.cycleActive) return;
        manager.scheduledCheck=nil;
        [manager schedulePeriodicCheck];
        [manager performScheduledCheckWithSource:@"周期检查"];
    }];
}
- (void)scheduleGraceCheck {
    NSUInteger generation=self.generation;
    __weak typeof(self) weakSelf=self;
    self.graceCheck=[self.runtime scheduleAfter:CSRunGraceInterval handler:^{
        CSBackgroundRunManager *manager=weakSelf;
        if (!manager || generation!=manager.generation || !manager.cycleActive) return;
        manager.graceCheck=nil;
        [manager performScheduledCheckWithSource:@"首次检查"];
    }];
}
- (void)scheduleAudioRecoveryReopeningCycle:(BOOL)reopen {
    if (!self.background || !self.resourcesRequested || self.interrupted || self.resumeBlocked || self.mediaLost || self.hostYielded) return;
    if (reopen && self.cycleEnded) {
        self.cycleEnded=NO; self.audioFailure=nil;
        self.lastBackgroundStoppedAt=nil; self.lastBackgroundStopReason=@"尚未结束";
        [self reconcile];
    }
    if (!self.cycleActive || self.resumeCheck) return;
    NSUInteger generation=self.generation, resumeGeneration=self.resumeGeneration;
    __weak typeof(self) weakSelf=self;
    self.resumeCheck=[self.runtime scheduleAfter:CSRunResumeInterval handler:^{
        CSBackgroundRunManager *manager=weakSelf;
        if (!manager || generation!=manager.generation || resumeGeneration!=manager.resumeGeneration || !manager.cycleActive) return;
        manager.resumeCheck=nil;
        if (!manager.background || !manager.resourcesRequested || manager.interrupted || manager.resumeBlocked || manager.mediaLost || manager.hostYielded || manager.audio.hostBusy) return;
        [manager performScheduledCheckWithSource:@"恢复检查"];
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
        self.cycleActive=YES; self.generation++;
        [self replaceTaskWithSource:@"任务初次申请" observationIdentifier:self.observationIdentifier];
        if (!self.cycleActive || !self.resourcesRequested || !self.background) return;
        if (!self.task.valid) { [self finishCycle:@"系统未允许后台任务，本轮运行结束"]; return; }
        // The entry grace check and periodic clock are independent (1.5, 25, 50...).
        [self schedulePeriodicCheck]; [self scheduleGraceCheck];
    }
    NSUInteger generation=self.generation;
    NSUInteger observationIdentifier=self.observationIdentifier;
    if (self.task && !self.task.valid) {
        id<CSBackgroundRunTask> expired=self.task; self.task=nil; [expired end];
        if (generation==self.generation && observationIdentifier==self.observationIdentifier) [self recordEventWithSource:@"任务失效" detail:@"检查发现当前后台任务已失效；未收到对应的系统到期通知"];
        if (!self.backgroundAudioActive) { [self finishCycle:@"后台任务已到期，本轮运行结束"]; return; }
    }
    NSString *audioBlocked=nil;
    CSBackgroundRunPhase blockedPhase=CSRunWaiting;
    if (!self.supportsBackgroundAudio) audioBlocked=@"当前微信包未声明后台音频能力";
    else if (self.mediaLost || self.interrupted || self.resumeBlocked) {
        audioBlocked=self.mediaLost?@"音频服务不可用":@"系统音频中断，等待允许恢复";
    } else if (self.hostYielded || self.audio.hostBusy) {
        [self.audio relinquish];
        audioBlocked=@"微信正在使用音频，保活已让出"; blockedPhase=CSRunYielding;
    }
    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
    BOOL checkDue=self.checkDue; self.checkDue=NO;
    NSString *checkSource=checkDue && self.pendingCheckGeneration==generation && self.pendingCheckObservationIdentifier==self.observationIdentifier?self.pendingCheckSource:nil;
    self.pendingCheckSource=nil;
    NSTimeInterval remaining=self.runtime.backgroundTimeRemaining;
    if (checkSource) [self recordEventWithSource:@"剩余时间" detail:[NSString stringWithFormat:@"%@：%@",checkSource,CSRunRecordedBudget(remaining)]];
    // Only a real check and a positive finite budget below 30s trigger a pulse.
    // Large/unbounded UIKit readings do not prove a need for audio renewal.
    if (checkDue && isfinite(remaining) && remaining>0 && remaining<CSRunAudioThreshold) {
        // A periodic check must not bypass the 0.4s audio recovery window.
        if (!audioBlocked && !self.resumeCheck) {
            NSError *error=nil;
            if (observationIdentifier==self.observationIdentifier) {
                self.recordedAudioAttempt=YES; self.recordedAudioGeneration=generation;
                self.recordedAudioObservationIdentifier=observationIdentifier;
            }
            BOOL started=[self.audio startWithError:&error];
            if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
            self.audioFailure=started?nil:[NSString stringWithFormat:@"启动失败：%@",error.localizedDescription?:@"系统未允许播放 blank.caf"];
            if (observationIdentifier==self.observationIdentifier) {
                if (!started) self.recordedAudioAttempt=NO;
                [self recordEventWithSource:@"音频尝试" detail:started?@"微信自带短音频播放请求成功；不代表系统已增加剩余执行时间":self.audioFailure];
            }
        } else {
            if (observationIdentifier==self.observationIdentifier) [self recordEventWithSource:@"音频跳过" detail:audioBlocked?:@"音频恢复等待窗口尚未结束，本次不启动播放"];
        }
        [self replaceTaskWithSource:@"任务替换" observationIdentifier:observationIdentifier];
        if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
    } else if (checkSource) {
        [self recordEventWithSource:@"音频跳过" detail:CSRunRecordedBudget(remaining)];
    }
    if (self.taskExpirationPending) return;
    BOOL taskUsable=self.task.valid && self.runtime.backgroundTimeRemaining>0;
    if (!self.backgroundAudioActive && !taskUsable) {
        [self finishCycle:audioBlocked?:self.audioFailure?:@"后台预算不足，本轮运行结束"];
        return;
    }
    NSString *status;
    CSBackgroundRunPhase phase;
    if (self.backgroundAudioActive) { status=@"blank.caf 短音频播放中"; phase=CSRunAudio; }
    else if (audioBlocked) { status=[@"有限后台任务运行中 · " stringByAppendingString:audioBlocked]; phase=blockedPhase; }
    else if (self.audioFailure) { status=[@"有限后台任务运行中 · " stringByAppendingString:self.audioFailure]; phase=CSRunTask; }
    else { status=@"有限后台任务运行中"; phase=CSRunTask; }
    [self publish:status phase:phase];
}
- (void)setBackgroundState:(BOOL)background {
    if (self.background!=background) {
        if (background && self.resourcesRequested) {
            [self beginObservationWithKnownEntry:YES];
            self.checkRecordRequested=YES;
        } else if (!background) [self recordForegroundReturn];
        self.background=background; self.cycleEnded=NO;
        self.hostYielded=NO; self.audioFailure=nil;
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
    BOOL recover=NO, reopen=NO;
    if ([name isEqual:AVAudioSessionInterruptionNotification]) {
        NSNumber *type=note.userInfo[AVAudioSessionInterruptionTypeKey];
        if (![type isKindOfClass:NSNumber.class]) return;
        if (type.unsignedIntegerValue==AVAudioSessionInterruptionTypeBegan) {
            self.interrupted=YES; [self cancelResumeCheck]; [self.audio suspend];
        } else if (type.unsignedIntegerValue==AVAudioSessionInterruptionTypeEnded) {
            if (!self.interrupted) return;
            NSNumber *options=note.userInfo[AVAudioSessionInterruptionOptionKey];
            BOOL resume=[options isKindOfClass:NSNumber.class] && (options.unsignedIntegerValue&AVAudioSessionInterruptionOptionShouldResume);
            self.interrupted=NO; self.resumeBlocked=!resume;
            recover=resume; reopen=resume;
        }
    } else if ([name isEqual:AVAudioSessionMediaServicesWereLostNotification]) {
        self.mediaLost=YES; [self cancelResumeCheck]; [self.audio relinquish];
    } else if ([name isEqual:AVAudioSessionMediaServicesWereResetNotification]) {
        [self.audio relinquish]; self.mediaLost=NO; recover=YES; reopen=YES;
    } else if ([name isEqual:CSBackgroundRunHostAudioChangedNotification]) {
        if ([note.userInfo[@"released"] boolValue] && !self.audio.hostBusy) {
            self.hostYielded=NO; recover=YES; reopen=YES;
        } else {
            self.hostYielded=YES; [self cancelResumeCheck]; [self.audio relinquish];
        }
    } else if ([name isEqual:CSBackgroundRunPlaybackFailedNotification]) {
        if (note.object!=self.audio) return;
        if (self.recordedAudioAttempt && self.recordedAudioGeneration==self.generation && self.recordedAudioObservationIdentifier==self.observationIdentifier) {
            [self recordEventWithSource:@"音频失败" detail:@"收到当前单次音频的播放失败通知；沿用原有后续检查策略"];
            self.recordedAudioAttempt=NO;
        }
        [self.audio stop]; self.audioFailure=@"blank.caf 播放失败，等待下次检查";
    } else if ([name isEqual:CSBackgroundRunPlaybackFinishedNotification]) {
        if (note.object!=self.audio) return;
        if (self.recordedAudioAttempt && self.recordedAudioGeneration==self.generation && self.recordedAudioObservationIdentifier==self.observationIdentifier) {
            [self recordEventWithSource:@"音频结束" detail:@"blank.caf 单次播放正常结束；不立即重播，继续按现有间隔检查"];
            self.recordedAudioAttempt=NO;
        }
        // A short file completing normally neither fails nor immediately replays.
    } else if ([name isEqual:AVAudioSessionRouteChangeNotification]) {
        recover=YES;
    }
    [self reconcile];
    if (recover) [self scheduleAudioRecoveryReopeningCycle:reopen];
}
@end
