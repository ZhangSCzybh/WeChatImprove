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
NSString *const CSBackgroundRunStateChangesKey=@"CSBackgroundRunStateChanges";

static const NSTimeInterval CSRunDefaultCheckInterval=25, CSRunGraceInterval=1.5;
static const NSTimeInterval CSRunResumeInterval=.4, CSRunAudioThreshold=30;
static const NSTimeInterval CSRunRecoveryBudgetMargin=1;
static const NSUInteger CSRunRecordEventLimit=80;
static const NSUInteger CSRunYieldProbeLimit=30;
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
@property(nonatomic, strong) id<CSBackgroundRunScheduledCheck> yieldCheck;
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
@property(nonatomic) BOOL started, background, mediaLost, hostYielded, hostNotificationsEnabled;
@property(nonatomic) BOOL cycleActive, cycleEnded, reconciling, reconcileAgain, taskExpirationPending, routeRecoveryPending;
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
// Adjacent checks share a successful resource decision only while its task,
// native ownership revision and media generation still match.
@property(nonatomic) BOOL resourceSuccessEligible, resourceUsesSnapshot;
@property(nonatomic) NSUInteger resourceGeneration, resourceObservationIdentifier, resourceRevision;
@property(nonatomic) uint64_t resourceConfigurationRevision, resourceMediaGeneration;
@property(nonatomic, strong) id<CSBackgroundRunTask> resourceTask;
@property(nonatomic) NSTimeInterval resourceSuccessUptime;
@property(nonatomic) NSTimeInterval nextPeriodicDeadline;
// The handoff belongs to a background visit and a real host release, not a task.
@property(nonatomic) BOOL handoffPending, handoffAttempted, handoffInProgress, handoffCleanupRetried;
@property(nonatomic) NSUInteger handoffEpisode, handoffObservationIdentifier, lastHandledReleaseEpisode;
@property(nonatomic) NSUInteger yieldCheckGeneration, yieldProbeCount;
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
        _nextPeriodicDeadline=-1;
    }
    return self;
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    if (_hostNotificationsEnabled) [_audio setHostNotificationsEnabled:NO];
    [_scheduledCheck cancel]; [_graceCheck cancel]; [_resumeCheck cancel]; [_yieldCheck cancel]; [_task end]; [_audio stop];
}
- (BOOL)resourcesRequested { return self.enabled || self.groupChatRequested; }
- (CSBackgroundRunAudioState *)currentAudioState {
    return [self.audio respondsToSelector:@selector(currentState)]?[self.audio currentState]:nil;
}
- (BOOL)hostAudioBusy {
    CSBackgroundRunAudioState *state=[self currentAudioState];
    return state?state.hostBusy:self.audio.hostBusy;
}
- (BOOL)backgroundAudioActive {
    if (!self.resourcesRequested || !self.background) return NO;
    CSBackgroundRunAudioState *state=[self currentAudioState];
    return state?(state.playing && state.sessionOwned):(self.audio.playing && self.audio.sessionOwned);
}
- (BOOL)executionAvailableWithAudio:(BOOL)audio {
    return self.resourcesRequested && self.background && self.cycleActive && !self.cycleEnded &&
        (audio || (self.task.valid && self.runtime.backgroundTimeRemaining>0));
}
- (BOOL)executionAvailable {
    // Keep the original cycle guard ahead of any audio/session reads.
    if (!self.resourcesRequested || !self.background || !self.cycleActive || self.cycleEnded) return NO;
    return [self executionAvailableWithAudio:self.backgroundAudioActive];
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
    // Both published values describe this one continuous, read-only sample.
    BOOL audio=self.backgroundAudioActive;
    BOOL work=self.enabled && [self executionAvailableWithAudio:audio];
    CSBackgroundRunStateChanges changes=0;
    if (self.publishedWork!=work) changes|=CSBackgroundRunStateChangeWork;
    if (self.publishedAudio!=audio) changes|=CSBackgroundRunStateChangeAudio;
    if (self.phase!=phase || ![self.statusText isEqual:status]) changes|=CSBackgroundRunStateChangeDisplay;
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
    if (self.background && self.resourcesRequested && ![self.lastBackgroundResult isEqual:status]) { self.lastBackgroundResult=status; changes|=CSBackgroundRunStateChangeDisplay; }
    if (changes) [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:self userInfo:@{CSBackgroundRunStateChangesKey:@(changes)}];
}
- (NSArray<CSBackgroundRunRecordEvent *> *)lastBackgroundEvents { return [self.recordEvents copy]; }
- (NSUInteger)lastBackgroundEventCount { return self.recordEvents.count; }
- (void)recordEventWithSource:(NSString *)source detail:(NSString *)detail date:(NSDate *)date uptime:(NSTimeInterval)uptime {
    if (!self.observationOpen) return;
    NSTimeInterval elapsed=isfinite(uptime) && self.observationUptime>=0 && uptime>=self.observationUptime?uptime-self.observationUptime:-1;
    CSBackgroundRunRecordEvent *event=[[CSBackgroundRunRecordEvent alloc] initWithDate:date elapsed:elapsed source:source detail:detail];
    NSUInteger index=self.recordEvents.count;
    // Most events arrive in order. Unknown offsets retain the existing append
    // rule; a known offset behind an unknown tail still needs the ordered scan.
    NSTimeInterval lastElapsed=self.recordEvents.lastObject.elapsed;
    if (elapsed>=0 && self.recordEvents.count && (lastElapsed<0 || elapsed<lastElapsed)) {
        // An expiration snapshot may arrive after a newer notification. Order
        // known offsets by the monotonic clock, preserving ties and the entry.
        for (NSUInteger i=1;i<self.recordEvents.count;i++) {
            NSTimeInterval recorded=self.recordEvents[i].elapsed;
            if (recorded>=0 && recorded>elapsed) { index=i; break; }
        }
    }
    [self.recordEvents insertObject:event atIndex:index];
    if (self.recordEvents.count>CSRunRecordEventLimit) {
        // Retain the entry so a truncated timeline still has its original anchor.
        [self.recordEvents removeObjectAtIndex:1]; self.droppedBackgroundEventCount++;
    }
}
- (void)recordEventWithSource:(NSString *)source detail:(NSString *)detail {
    if (!self.observationOpen) return;
    [self recordEventWithSource:source detail:detail date:self.runtime.currentDate uptime:self.runtime.uptime];
}
- (void)recordTaskExpirationForTask:(id<CSBackgroundRunTask>)task detail:(NSString *)detail {
    if (!self.observationOpen) return;
    NSDate *date=self.runtime.currentDate;
    NSTimeInterval uptime=self.runtime.uptime;
    if ([task respondsToSelector:@selector(expirationDate)] && task.expirationDate) {
        date=task.expirationDate;
        if ([task respondsToSelector:@selector(expirationUptime)]) uptime=task.expirationUptime;
    }
    self.lastTaskExpiredAt=date;
    [self recordEventWithSource:@"系统到期" detail:detail date:date uptime:uptime];
}
- (void)beginObservationWithKnownEntry:(BOOL)knownEntry {
    [self invalidateSuccessfulResources];
    [self invalidateHostHandoff:nil];
    CSBackgroundRunAudioState *state=[self currentAudioState];
    self.lastHandledReleaseEpisode=state?state.hostReleaseEpisode:([self.audio respondsToSelector:@selector(hostReleaseEpisode)]?self.audio.hostReleaseEpisode:0);
    self.yieldProbeCount=0;
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
    [self invalidateSuccessfulResources];
    if (!self.observationOpen) return;
    // A foreground or final-demand stop can beat the queued expiration callback.
    // Preserve its real snapshot, but leave valid tasks to releaseResources:
    // demand can be re-enabled synchronously before reconciliation finishes.
    id<CSBackgroundRunTask> task=self.task;
    if (task && !task.valid && [task respondsToSelector:@selector(expirationDate)] && task.expirationDate) {
        self.task=nil; [task end];
        [self recordTaskExpirationForTask:task detail:@"停止前的任务快照确认系统已到期；到期回调尚未送达，后续回调不会重复记录"];
    }
    if (self.lastBackgroundStoppedAt) return;
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
    self.routeRecoveryPending=NO;
}
- (void)cancelYieldCheck {
    self.yieldCheckGeneration++;
    [self.yieldCheck cancel]; self.yieldCheck=nil;
}
- (void)invalidateHostHandoff:(NSString *)reason {
    if (self.handoffPending && reason) [self recordEventWithSource:@"交接取消" detail:reason];
    self.handoffPending=NO; self.handoffAttempted=NO;
    self.handoffCleanupRetried=NO;
    self.handoffEpisode=0; self.handoffObservationIdentifier=0;
}
- (void)invalidateSuccessfulResources {
    self.resourceRevision++;
    self.resourceSuccessEligible=NO; self.resourceTask=nil;
}
- (void)cancelChecks {
    [self invalidateSuccessfulResources]; self.nextPeriodicDeadline=-1;
    self.checkGeneration++; [self.scheduledCheck cancel]; self.scheduledCheck=nil;
    [self.graceCheck cancel]; self.graceCheck=nil;
    [self cancelResumeCheck];
    [self cancelYieldCheck];
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
    BOOL waiting=self.background && self.resourcesRequested && (self.handoffPending || self.hostYielded || self.hostAudioBusy);
    [self publish:waiting?@"有限后台任务已结束，等待音频交接机会":reason phase:waiting?CSRunWaiting:CSRunEnded];
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
            } else { [self invalidateHostHandoff:@"后台需求已关闭"]; [self recordStop:stopReason]; self.checkRecordRequested=NO; }
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
    [self recordTaskExpirationForTask:task detail:@"收到系统的后台任务到期通知；后续是否继续取决于可用任务和音频"];
    [task end]; self.task=nil;
    self.checkRecordRequested=YES;
    // Expiration can reenter a native audio activation. Let it unwind before cleanup.
    self.taskExpirationPending=YES;
    [self reconcile];
}
- (BOOL)replaceTaskWithSource:(NSString *)source observationIdentifier:(NSUInteger)observationIdentifier {
    NSUInteger generation=self.generation;
    __weak typeof(self) weakSelf=self;
    id<CSBackgroundRunTask> candidate=[self.runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> expired){
        [weakSelf taskExpired:expired generation:generation];
    }];
    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) { [candidate end]; return NO; }
    BOOL valid=candidate.valid;
    if (observationIdentifier==self.observationIdentifier) [self recordEventWithSource:source detail:valid?@"后台任务申请获准；不代表系统已增加剩余执行时间":@"后台任务申请未获准"];
    if (!valid) { [candidate end]; return NO; }
    // Keep the current task until the request returns a valid identifier.
    id<CSBackgroundRunTask> old=self.task;
    [self invalidateSuccessfulResources];
    self.task=candidate;
    [old end];
    return generation==self.generation && self.task==candidate && candidate.valid;
}
- (void)performScheduledCheckWithSource:(NSString *)source {
    self.checkDue=YES; self.checkRecordRequested=YES;
    self.pendingCheckSource=source; self.pendingCheckGeneration=self.generation;
    self.pendingCheckObservationIdentifier=self.observationIdentifier;
    if (self.observationOpen) {
        NSDate *date=self.runtime.currentDate;
        if ([source isEqual:@"首次检查"] && !self.firstScheduledCheckAt) {
            // Keep the real visit's first check; only subsequent adjacent checks
            // may reuse an earlier successful recovery or handoff.
            [self invalidateSuccessfulResources]; self.firstScheduledCheckAt=date;
        }
        if ([source isEqual:@"周期检查"]) { self.lastPeriodicCheckAt=date; self.periodicCheckCount++; }
        [self recordEventWithSource:source detail:@"本次检查已开始；剩余执行时间与处理结果见后续事件" date:date uptime:self.runtime.uptime];
    }
    [self reconcile];
}
- (void)schedulePeriodicCheck {
    self.checkGeneration++; [self.scheduledCheck cancel]; self.scheduledCheck=nil;
    self.nextPeriodicDeadline=-1;
    if (!self.cycleActive) return;
    NSTimeInterval now=self.runtime.uptime;
    if (isfinite(now) && now>=0) self.nextPeriodicDeadline=now+self.checkInterval;
    NSUInteger checkGeneration=self.checkGeneration, generation=self.generation;
    __weak typeof(self) weakSelf=self;
    self.scheduledCheck=[self.runtime scheduleEvery:self.checkInterval handler:^{
        CSBackgroundRunManager *manager=weakSelf;
        if (!manager || checkGeneration!=manager.checkGeneration || generation!=manager.generation || !manager.cycleActive) return;
        NSTimeInterval deliveredAt=manager.runtime.uptime;
        manager.nextPeriodicDeadline=isfinite(deliveredAt) && deliveredAt>=0?deliveredAt+manager.checkInterval:-1;
        [manager performScheduledCheckWithSource:@"周期检查"];
        // Runtime also postpones a timer whose handler consumed a full period.
        // Keep the conservative budget guard aligned with that future check.
        NSTimeInterval completedAt=manager.runtime.uptime;
        if (checkGeneration==manager.checkGeneration && generation==manager.generation && manager.cycleActive &&
            isfinite(completedAt) && completedAt>=manager.nextPeriodicDeadline)
            manager.nextPeriodicDeadline=completedAt+manager.checkInterval;
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
- (void)requestHostHandoffForEpisode:(NSUInteger)episode {
    CSBackgroundRunAudioState *state=[self currentAudioState];
    if (!episode || !self.background || !self.resourcesRequested ||
        !self.observationOpen || self.mediaLost || (state?state.hostBusy:self.audio.hostBusy)) return;
    if (state && (!state.hostReleaseConfirmed || state.hostReleaseEpisode!=episode)) return;
    if (episode<=self.lastHandledReleaseEpisode) {
        // A later native cleanup can revoke a just-acquired lease. Allow one
        // correction on that real callback, using the existing task only.
        if (episode==self.handoffEpisode && self.handoffObservationIdentifier==self.observationIdentifier &&
            self.handoffAttempted && !self.handoffCleanupRetried && !(state?state.sessionOwned:self.audio.sessionOwned) &&
            self.task.valid && self.runtime.backgroundTimeRemaining>0) {
            self.handoffCleanupRetried=YES; self.handoffPending=YES; self.handoffAttempted=NO;
            self.checkRecordRequested=YES;
            if (!self.routeRecoveryPending) [self cancelResumeCheck];
            [self recordEventWithSource:@"交接清理补偿" detail:@"微信后续清理已撤销本次音频租约；仅复用当前任务补偿一次，不重新申请桥接任务"];
        }
        return;
    }
    self.lastHandledReleaseEpisode=episode;
    self.handoffEpisode=episode; self.handoffObservationIdentifier=self.observationIdentifier;
    self.handoffPending=YES; self.handoffAttempted=NO; self.handoffCleanupRetried=NO;
    self.hostYielded=NO; self.checkRecordRequested=YES;
    if (!self.routeRecoveryPending) [self cancelResumeCheck];
    [self cancelYieldCheck];
    NSString *timing=self.routeRecoveryPending?@"输出路由正在恢复，复用已安排的恢复检查":@"在当前主线程回调中评估，不等待普通周期或固定恢复延时";
    [self recordEventWithSource:@"交接待处理" detail:[NSString stringWithFormat:@"已确认微信释放音频（交接 %lu）；%@",(unsigned long)episode,timing]];
}
- (BOOL)hostHandoffIsCurrent:(NSUInteger)episode observation:(NSUInteger)observation {
    if (!self.handoffPending || self.handoffEpisode!=episode || self.handoffObservationIdentifier!=observation ||
        self.observationIdentifier!=observation || !self.background || !self.resourcesRequested ||
        self.mediaLost || self.hostYielded) return NO;
    CSBackgroundRunAudioState *state=[self currentAudioState];
    if (state) return !state.hostBusy && state.hostReleaseConfirmed && state.hostReleaseEpisode==episode;
    if (self.audio.hostBusy) return NO;
    if ([self.audio respondsToSelector:@selector(hostReleaseConfirmed)] && !self.audio.hostReleaseConfirmed) return NO;
    return ![self.audio respondsToSelector:@selector(hostReleaseEpisode)] || self.audio.hostReleaseEpisode==episode;
}
- (void)attemptHostHandoff {
    if (self.handoffInProgress || !self.handoffPending || self.handoffAttempted || self.resumeCheck || self.routeRecoveryPending) return;
    NSUInteger episode=self.handoffEpisode, observation=self.handoffObservationIdentifier;
    if (![self hostHandoffIsCurrent:episode observation:observation]) {
        [self invalidateHostHandoff:@"微信已重新占用音频，或交接事件已失效"];
        return;
    }
    self.handoffAttempted=YES; self.handoffInProgress=YES;
    @try {
        if (!self.supportsBackgroundAudio) {
            [self recordEventWithSource:@"交接跳过" detail:@"当前微信包未声明后台音频能力"];
            return;
        }
        BOOL reopened=!self.cycleActive;
        if (reopened) {
            self.cycleActive=YES; self.cycleEnded=NO; self.generation++;
            [self recordEventWithSource:@"恢复机会" detail:@"有限任务结束后收到新的明确音频释放事件；本次最多申请一次桥接任务"];
        }
        NSUInteger generation=self.generation;
        NSTimeInterval remaining=self.runtime.backgroundTimeRemaining;
        BOOL usable=self.task.valid && !isnan(remaining) && remaining>0;
        if (!usable && !self.handoffCleanupRetried) {
            [self replaceTaskWithSource:@"交接桥接申请" observationIdentifier:observation];
            if (generation!=self.generation || ![self hostHandoffIsCurrent:episode observation:observation]) return;
            remaining=self.runtime.backgroundTimeRemaining;
            usable=self.task.valid && !isnan(remaining) && remaining>0;
        } else if (usable) [self recordEventWithSource:@"交接资源复用" detail:@"复用仍有效的有限后台任务，本次不重复申请"];
        if (!usable) {
            [self recordEventWithSource:@"交接等待" detail:self.handoffCleanupRetried?@"清理补偿时原任务已无可用预算；保留交接记录等待新的真实事件，不再申请桥接任务":@"桥接后仍无可用执行预算；保留交接记录和音频监听，等待新的真实执行机会，不循环申请"];
            [self finishCycle:@"当前没有可用后台执行时间，等待新的音频事件"];
            return;
        }
        // A newly observed release is different from a periodic renewal. A large
        // or unbounded reading must not suppress this one bounded handoff.
        NSString *budget=isfinite(remaining) && remaining<DBL_MAX/2?
            [NSString stringWithFormat:@"当前报告剩余约 %.3f 秒",remaining]:@"系统未提供有限倒计时";
        [self recordEventWithSource:@"交接检查" detail:[budget stringByAppendingString:@"；已确认释放，尝试一次短音频，结果不保证系统增加执行时间"]];
        if (reopened) { [self schedulePeriodicCheck]; [self scheduleGraceCheck]; }
        NSUInteger resourceRevision=self.resourceRevision;
        self.recordedAudioAttempt=YES; self.recordedAudioGeneration=generation;
        self.recordedAudioObservationIdentifier=observation;
        NSError *error=nil;
        BOOL started=[self.audio startWithError:&error];
        if (generation!=self.generation || ![self hostHandoffIsCurrent:episode observation:observation]) return;
        self.audioFailure=started?nil:[NSString stringWithFormat:@"启动失败：%@",error.localizedDescription?:@"系统未允许播放 blank.caf"];
        if (started && self.audio.sessionOwned) {
            self.handoffPending=NO;
            self.lastBackgroundStoppedAt=nil; self.lastBackgroundStopReason=@"尚未结束";
            [self recordEventWithSource:@"交接成功" detail:@"短音频播放请求成功且会话所有权检查通过；后续执行仍由系统决定"];
            [self rememberSuccessfulResourcesForGeneration:generation observation:observation revision:resourceRevision];
        } else {
            self.recordedAudioAttempt=NO;
            [self recordEventWithSource:@"交接失败" detail:self.audioFailure?:@"播放期间微信已接管音频"];
        }
    } @finally {
        self.handoffInProgress=NO;
        self.reconcileAgain=YES;
    }
}
- (void)scheduleYieldCheckIfNeeded {
    if (self.yieldCheck || self.yieldProbeCount>=CSRunYieldProbeLimit || !self.cycleActive || self.cycleEnded ||
        !self.background || !self.resourcesRequested || self.mediaLost || !self.supportsBackgroundAudio || !self.task.valid) return;
    NSTimeInterval remaining=self.runtime.backgroundTimeRemaining;
    if (!isfinite(remaining) || remaining<=0 || remaining>=DBL_MAX/2) return;
    if (!self.yieldProbeCount) [self recordEventWithSource:@"让出复核" detail:@"有限任务有效期间轻量复核音频释放，间隔 1 秒，余量不超过 8 秒时为 0.5 秒；本次后台最多 30 次，不增加任务或播放请求"];
    NSUInteger generation=self.generation, revision=self.yieldCheckGeneration, observation=self.observationIdentifier;
    __weak typeof(self) weakSelf=self;
    self.yieldCheck=[self.runtime scheduleAfter:remaining<=8?.5:1 handler:^{
        CSBackgroundRunManager *manager=weakSelf;
        if (!manager || generation!=manager.generation || revision!=manager.yieldCheckGeneration || observation!=manager.observationIdentifier) return;
        manager.yieldCheck=nil;
        NSTimeInterval budget=manager.runtime.backgroundTimeRemaining;
        if (!manager.task.valid || !isfinite(budget) || budget<=0 || budget>=DBL_MAX/2) { [manager reconcile]; return; }
        manager.yieldProbeCount++;
        CSBackgroundRunAudioState *state=[manager currentAudioState];
        if (state) {
            if (state.hostReleaseConfirmed && !state.hostBusy) [manager requestHostHandoffForEpisode:state.hostReleaseEpisode];
        } else if ([manager.audio respondsToSelector:@selector(hostReleaseConfirmed)] && manager.audio.hostReleaseConfirmed &&
            [manager.audio respondsToSelector:@selector(hostReleaseEpisode)] && !manager.audio.hostBusy)
            [manager requestHostHandoffForEpisode:manager.audio.hostReleaseEpisode];
        if (manager.yieldProbeCount==CSRunYieldProbeLimit) [manager recordEventWithSource:@"让出复核结束" detail:@"本次后台已达到 30 次轻量复核上限；继续保留音频事件监听与普通周期检查"];
        [manager reconcile];
    }];
}
- (void)scheduleAudioRecoveryReopeningCycle:(BOOL)reopen {
    if (!self.background || !self.resourcesRequested || self.mediaLost || self.hostYielded) {
        // A route barrier belongs to an actual recovery timer, never to an
        // ended cycle or a host-owned session awaiting a future release.
        self.routeRecoveryPending=NO;
        return;
    }
    if (reopen && self.cycleEnded) {
        self.cycleEnded=NO; self.audioFailure=nil;
        self.lastBackgroundStoppedAt=nil; self.lastBackgroundStopReason=@"尚未结束";
        [self recordEventWithSource:@"恢复机会" detail:@"收到新的音频状态事件，重新申请有限后台任务；此前的停止记录仍保留在时间线中"];
        [self reconcile];
    }
    if (!self.cycleActive) {
        self.routeRecoveryPending=NO;
        if (self.handoffPending && !self.handoffAttempted) [self reconcile];
        return;
    }
    if (self.resumeCheck) return;
    NSUInteger generation=self.generation, resumeGeneration=self.resumeGeneration;
    __weak typeof(self) weakSelf=self;
    self.resumeCheck=[self.runtime scheduleAfter:CSRunResumeInterval handler:^{
        CSBackgroundRunManager *manager=weakSelf;
        if (!manager || generation!=manager.generation || resumeGeneration!=manager.resumeGeneration || !manager.cycleActive) return;
        manager.resumeCheck=nil; manager.routeRecoveryPending=NO;
        if (!manager.background || !manager.resourcesRequested || manager.mediaLost || manager.hostYielded || manager.hostAudioBusy) return;
        [manager performScheduledCheckWithSource:@"恢复检查"];
    }];
}
- (void)rememberSuccessfulResourcesForGeneration:(NSUInteger)generation observation:(NSUInteger)observation revision:(NSUInteger)revision {
    id<CSBackgroundRunTask> task=self.task;
    if (revision!=self.resourceRevision || generation!=self.generation || observation!=self.observationIdentifier ||
        !self.cycleActive || !self.background || !self.resourcesRequested || !self.task.valid || self.audioFailure || self.mediaLost) return;
    CSBackgroundRunAudioState *state=[self currentAudioState];
    if (state?(state.hostBusy || !state.sessionOwned):(self.audio.hostBusy || !self.audio.sessionOwned)) return;
    NSTimeInterval now=self.runtime.uptime;
    if (!isfinite(now) || now<0 || revision!=self.resourceRevision || generation!=self.generation ||
        observation!=self.observationIdentifier || task!=self.task || !task.valid ||
        !self.cycleActive || !self.background || !self.resourcesRequested || self.audioFailure || self.mediaLost) return;
    self.resourceSuccessEligible=YES; self.resourceTask=task;
    self.resourceGeneration=generation; self.resourceObservationIdentifier=observation;
    self.resourceSuccessUptime=now; self.resourceUsesSnapshot=state!=nil;
    self.resourceConfigurationRevision=state.configurationRevision;
    self.resourceMediaGeneration=state.mediaGeneration;
}
- (BOOL)successfulResourcesMatchState:(CSBackgroundRunAudioState *)state {
    if (!self.resourceSuccessEligible || self.resourceGeneration!=self.generation ||
        self.resourceObservationIdentifier!=self.observationIdentifier || !self.resourceTask ||
        self.resourceTask!=self.task || !self.task.valid || self.mediaLost || self.hostYielded || self.audioFailure) return NO;
    if (self.resourceUsesSnapshot) return state && !state.hostBusy && state.sessionOwned &&
        state.configurationRevision==self.resourceConfigurationRevision && state.mediaGeneration==self.resourceMediaGeneration;
    return !self.audio.hostBusy && self.audio.sessionOwned;
}
- (BOOL)canReuseSuccessfulResourcesWithRemaining:(NSTimeInterval)remaining {
    NSTimeInterval now=self.runtime.uptime;
    // Adjacency limits coalescing to grace/recovery overlap; successful pulses
    // never suppress the normal cadence solely because a lease remains owned.
    return [self successfulResourcesMatchState:[self currentAudioState]] && !self.resumeCheck && !self.handoffPending &&
        isfinite(now) && now>=self.resourceSuccessUptime && now-self.resourceSuccessUptime<=CSRunGraceInterval &&
        isfinite(self.nextPeriodicDeadline) && self.nextPeriodicDeadline>now &&
        isfinite(remaining) && remaining>self.nextPeriodicDeadline-now+CSRunRecoveryBudgetMargin;
}
- (void)reconcile {
    if (self.reconciling) { self.reconcileAgain=YES; return; }
    self.reconciling=YES;
    @try {
        do { self.reconcileAgain=NO; [self reconcileOnce]; } while (self.reconcileAgain);
    } @finally { self.reconciling=NO; }
}
- (void)reconcileOnce {
    BOOL hostNotificationsEnabled=self.background && self.resourcesRequested;
    if (self.hostNotificationsEnabled!=hostNotificationsEnabled) {
        self.hostNotificationsEnabled=hostNotificationsEnabled;
        [self.audio setHostNotificationsEnabled:hostNotificationsEnabled];
        // Native changes remain tracked while delivery is off. Enable first,
        // then resample so a release during that gap cannot leave stale yield.
        // Keep delivery on after a cycle ends: a host release may reopen it.
        if (hostNotificationsEnabled) self.hostYielded=self.hostAudioBusy;
    }
    CSBackgroundRunAudioState *currentState=[self currentAudioState];
    if (currentState) self.hostYielded=currentState.hostBusy;
    if (!self.resourcesRequested || !self.background) {
        self.checkRecordRequested=NO;
        [self invalidateHostHandoff:nil];
        [self releaseResources]; self.cycleEnded=NO;
        NSString *status=self.enabled?@"前台待机":(self.groupChatRequested?@"群聊实时待机":@"未启用");
        [self publish:status phase:self.resourcesRequested?CSRunStandby:CSRunDisabled];
        return;
    }
    if (self.taskExpirationPending) {
        self.taskExpirationPending=NO;
        if (!self.task.valid && !self.backgroundAudioActive) {
            [self finishCycle:@"后台任务已到期，本轮运行结束"];
            if (self.handoffPending && !self.handoffAttempted) self.reconcileAgain=YES;
            return;
        }
    }
    NSTimeInterval now=self.runtime.uptime;
    if (!isfinite(now) || now<0) { [self finishCycle:@"后台时钟不可用，本轮运行结束"]; return; }
    NSUInteger generation=self.generation;
    NSUInteger observationIdentifier=self.observationIdentifier;
    if (self.task && !self.task.valid) {
        id<CSBackgroundRunTask> expired=self.task; self.task=nil; [expired end];
        if (generation==self.generation && observationIdentifier==self.observationIdentifier) {
            // UIKit invalidates before dispatching its expiration callback. Read
            // the lease snapshot so an intervening notification cannot erase it.
            if ([expired respondsToSelector:@selector(expirationDate)] && expired.expirationDate) {
                [self recordTaskExpirationForTask:expired detail:@"任务快照确认系统已到期；到期回调尚未送达，后续回调不会重复记录"];
                self.checkRecordRequested=YES;
            } else [self recordEventWithSource:@"任务失效" detail:@"检查发现当前后台任务已失效；未收到对应的系统到期通知"];
        }
        if (!self.backgroundAudioActive) {
            [self finishCycle:@"后台任务已到期，本轮运行结束"];
            if (self.handoffPending && !self.handoffAttempted) self.reconcileAgain=YES;
            return;
        }
    }
    if (self.handoffPending && !self.handoffAttempted && !self.handoffInProgress && !self.resumeCheck && !self.routeRecoveryPending) { [self attemptHostHandoff]; return; }
    if (self.cycleEnded) { [self publish:self.statusText phase:self.handoffPending || self.hostYielded?CSRunWaiting:CSRunEnded]; return; }
    if (!self.cycleActive) {
        self.cycleActive=YES; self.generation++;
        [self replaceTaskWithSource:@"任务初次申请" observationIdentifier:self.observationIdentifier];
        if (!self.cycleActive || !self.resourcesRequested || !self.background) return;
        if (!self.task.valid) { [self finishCycle:@"系统未允许后台任务，本轮运行结束"]; return; }
        // The entry grace check and periodic clock are independent (1.5, 25, 50...).
        [self schedulePeriodicCheck]; [self scheduleGraceCheck];
    }
    generation=self.generation;
    NSString *audioBlocked=nil;
    CSBackgroundRunPhase blockedPhase=CSRunWaiting;
    if (!self.supportsBackgroundAudio) audioBlocked=@"当前微信包未声明后台音频能力";
    else if (self.mediaLost) audioBlocked=@"音频服务不可用，保留有限任务与周期检查";
    else if (self.hostYielded || self.hostAudioBusy) {
        [self.audio relinquish];
        audioBlocked=@"微信正在使用音频，保活已让出"; blockedPhase=CSRunYielding;
    }
    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
    BOOL checkDue=self.checkDue; self.checkDue=NO;
    NSString *checkSource=checkDue && self.pendingCheckGeneration==generation && self.pendingCheckObservationIdentifier==self.observationIdentifier?self.pendingCheckSource:nil;
    self.pendingCheckSource=nil;
    NSTimeInterval remaining=self.runtime.backgroundTimeRemaining;
    NSString *recordedBudget=checkSource?CSRunRecordedBudget(remaining):nil;
    if (checkSource) [self recordEventWithSource:@"剩余时间" detail:[NSString stringWithFormat:@"%@：%@",checkSource,recordedBudget]];
    BOOL reuseResources=checkSource && !audioBlocked && [self canReuseSuccessfulResourcesWithRemaining:remaining];
    // Only a real check and a positive finite budget below 30s trigger a pulse.
    // Large/unbounded UIKit readings do not prove a need for audio renewal.
    if (checkDue && isfinite(remaining) && remaining>0 && remaining<CSRunAudioThreshold) {
        if (reuseResources) {
            [self recordEventWithSource:@"资源复用" detail:@"相邻检查已有成功的短音频请求，当前任务、会话所有权和媒体代际仍有效；有限余量可覆盖下次周期检查及 1 秒余量，本次复用资源"];
        } else {
            NSUInteger resourceRevision=self.resourceRevision;
            // A periodic check must not bypass the 0.4s audio recovery window.
            if (!audioBlocked && !self.resumeCheck) {
                // Ordinary checks retain a valid task. Only actual audio work
                // lacking a task may request one; skips/failures never churn it.
                if (!self.task.valid) {
                    [self replaceTaskWithSource:@"任务补充申请" observationIdentifier:observationIdentifier];
                    if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
                    resourceRevision=self.resourceRevision;
                }
                NSError *error=nil;
                if (observationIdentifier==self.observationIdentifier) {
                    self.recordedAudioAttempt=YES; self.recordedAudioGeneration=generation;
                    self.recordedAudioObservationIdentifier=observationIdentifier;
                }
                BOOL started=[self.audio startWithError:&error];
                if (generation!=self.generation || !self.cycleActive || !self.resourcesRequested || !self.background) return;
                self.audioFailure=started?nil:[NSString stringWithFormat:@"启动失败：%@",error.localizedDescription?:@"系统未允许播放 blank.caf"];
                if (started && self.handoffPending && self.handoffObservationIdentifier==observationIdentifier) {
                    self.handoffPending=NO;
                    [self recordEventWithSource:@"交接成功" detail:@"后续正常检查的短音频请求成功；不代表系统已补充执行时间"];
                }
                if (started) [self rememberSuccessfulResourcesForGeneration:generation observation:observationIdentifier revision:resourceRevision];
                else [self invalidateSuccessfulResources];
                if (observationIdentifier==self.observationIdentifier) {
                    if (!started) self.recordedAudioAttempt=NO;
                    [self recordEventWithSource:@"音频尝试" detail:started?@"微信自带短音频播放请求成功；不代表系统已增加剩余执行时间":self.audioFailure];
                }
            } else {
                if (observationIdentifier==self.observationIdentifier) [self recordEventWithSource:@"音频跳过" detail:audioBlocked?:@"音频恢复等待窗口尚未结束，本次不启动播放"];
            }
        }
    } else if (checkSource) {
        [self recordEventWithSource:@"音频跳过" detail:recordedBudget];
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
    if (blockedPhase==CSRunYielding && audioBlocked) [self scheduleYieldCheckIfNeeded];
    else if (self.yieldCheck) [self cancelYieldCheck];
    [self publish:status phase:phase];
}
- (void)setBackgroundState:(BOOL)background {
    if (self.background!=background) {
        if (background && self.resourcesRequested) {
            [self beginObservationWithKnownEntry:YES];
            self.checkRecordRequested=YES;
        } else if (!background) [self recordForegroundReturn];
        [self invalidateHostHandoff:background?nil:@"返回前台，旧交接已取消"];
        self.background=background; self.cycleEnded=NO;
        self.hostYielded=NO; self.audioFailure=nil;
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
        [self invalidateSuccessfulResources];
        if (type.unsignedIntegerValue==AVAudioSessionInterruptionTypeBegan) {
            // iOS has already deactivated this session. Discard only the stale
            // player; native task renewal and the periodic audio attempts stay.
            [self.audio suspend]; self.recordedAudioAttempt=NO;
            [self recordEventWithSource:@"系统中断" detail:@"系统已停用当前音频会话；保留有限后台任务与周期检查，后续继续尝试混音播放"];
            [self reconcile];
            // A delayed interruption can be the first callback after suspension.
            // It is an execution opportunity, not proof the prior cycle lived on.
            if (self.cycleEnded) [self scheduleAudioRecoveryReopeningCycle:YES];
            return;
        } else if (type.unsignedIntegerValue==AVAudioSessionInterruptionTypeEnded) {
            NSNumber *options=note.userInfo[AVAudioSessionInterruptionOptionKey];
            BOOL resume=[options isKindOfClass:NSNumber.class] && (options.unsignedIntegerValue&AVAudioSessionInterruptionOptionShouldResume);
            [self recordEventWithSource:@"中断结束" detail:resume?@"系统建议恢复；等待 0.4 秒后重新检查实际播放条件":@"系统未提供建议恢复标记；该提示不阻断保活，等待 0.4 秒后重新尝试"];
            recover=YES; reopen=YES;
        } else return;
    } else if ([name isEqual:AVAudioSessionMediaServicesWereLostNotification]) {
        [self invalidateSuccessfulResources];
        [self invalidateHostHandoff:@"媒体服务已失效，等待新的音频事件"];
        [self cancelYieldCheck];
        self.mediaLost=YES; [self cancelResumeCheck]; [self.audio invalidateForMediaServicesLoss];
        self.recordedAudioAttempt=NO;
        [self recordEventWithSource:@"音频服务丢失" detail:@"音频服务暂不可用；保留有限后台任务和周期检查，等待服务重置"];
    } else if ([name isEqual:AVAudioSessionMediaServicesWereResetNotification]) {
        [self invalidateSuccessfulResources];
        [self invalidateHostHandoff:@"媒体服务代际已改变，旧交接已取消"];
        [self.audio resetAfterMediaServicesReset]; self.mediaLost=NO; self.hostYielded=NO;
        [self recordEventWithSource:@"音频服务恢复" detail:@"旧音频会话状态已失效；等待 0.4 秒后重新检查"];
        recover=YES; reopen=YES;
    } else if ([name isEqual:CSBackgroundRunHostAudioChangedNotification]) {
        CSBackgroundRunAudioState *state=[self currentAudioState];
        // Delivery may lag a newer activation/release. Production decisions use
        // one current sample; the notification is diagnostic, not permission.
        BOOL busy=state?state.hostBusy:(![note.userInfo[@"released"] boolValue] || self.audio.hostBusy);
        BOOL confirmed=state?state.hostReleaseConfirmed:[note.userInfo[@"releaseConfirmed"] boolValue];
        NSUInteger episode=state?state.hostReleaseEpisode:[note.userInfo[@"releaseEpisode"] unsignedIntegerValue];
        if (!state || ![self successfulResourcesMatchState:state]) [self invalidateSuccessfulResources];
        if (self.background && self.resourcesRequested) {
            NSString *source=state?state.source:([note.userInfo[@"source"] isKindOfClass:NSString.class]?note.userInfo[@"source"]:@"会话状态变化");
            [self recordEventWithSource:@"微信音频状态" detail:[NSString stringWithFormat:@"%@；当前释放确认 %@，交接编号 %lu，在途调用 %@",source,confirmed?@"是":@"否",(unsigned long)episode,state?@(state.hostCalls):(note.userInfo[@"hostCalls"]?:@"未知")]];
        }
        self.hostYielded=busy;
        if (!busy) {
            if (confirmed) {
                [self requestHostHandoffForEpisode:episode];
                [self reconcile]; return;
            }
            // Older adapters retain recovery behavior. Unconfirmed native
            // configuration writes cannot repeatedly reopen an expired cycle.
            recover=YES; reopen=!state && note.userInfo[@"releaseConfirmed"]==nil;
        } else {
            [self invalidateHostHandoff:@"微信重新占用音频，交接已取消"];
            [self cancelResumeCheck]; [self.audio relinquish];
        }
    } else if ([name isEqual:CSBackgroundRunPlaybackFailedNotification]) {
        if (note.object!=self.audio) return;
        [self invalidateSuccessfulResources];
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
        NSNumber *value=note.userInfo[AVAudioSessionRouteChangeReasonKey];
        AVAudioSessionRouteChangeReason reason=[value isKindOfClass:NSNumber.class]?value.unsignedIntegerValue:AVAudioSessionRouteChangeReasonUnknown;
        CSBackgroundRunAudioState *state=[self currentAudioState];
        // Our category write can notify synchronously, before startWithError:
        // has installed its lease. It must not schedule recovery of itself.
        if (reason==AVAudioSessionRouteChangeReasonCategoryChange && state.ownChangeInProgress) return;
        BOOL benign=reason==AVAudioSessionRouteChangeReasonCategoryChange || reason==AVAudioSessionRouteChangeReasonNewDeviceAvailable ||
            reason==AVAudioSessionRouteChangeReasonOverride || reason==AVAudioSessionRouteChangeReasonRouteConfigurationChange;
        BOOL owned=state?(!state.hostBusy && state.sessionOwned):(!self.audio.hostBusy && self.audio.sessionOwned);
        if (benign && owned && !self.mediaLost && !self.audioFailure) return;
        [self invalidateSuccessfulResources];
        if (reason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable || reason==AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory) {
            self.routeRecoveryPending=YES;
            [self invalidateHostHandoff:@"音频输出路由已失效，等待恢复检查"];
            [self.audio suspend]; self.recordedAudioAttempt=NO;
        }
        recover=YES;
    }
    [self reconcile];
    if (recover) [self scheduleAudioRecoveryReopeningCycle:reopen];
}
@end
