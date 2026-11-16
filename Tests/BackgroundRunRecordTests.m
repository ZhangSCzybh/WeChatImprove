#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <math.h>
#import "CSBackgroundRunManager.h"
#import "BackgroundRunFakeRuntime.h"

static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"RECORD FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
static NSUserDefaults *defaults;
static CSBackgroundRunManager *manager;
static CSBackgroundRunAudio *audio;
static CSTestBackgroundRuntime *runtime;
static void Drain(void) { for (NSUInteger i=0;i<4;i++) [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.001]]; }
static void Post(NSString *name,id object,NSDictionary *info) { [NSNotificationCenter.defaultCenter postNotificationName:name object:object userInfo:info]; }
static void Enable(BOOL value) { [defaults setBool:value forKey:CSBackgroundRunEnabledKey]; [manager reloadSettings]; }
static void Background(void) { UIApplication.sharedApplication.applicationState=UIApplicationStateBackground; Post(UIApplicationDidEnterBackgroundNotification,nil,nil); }
static void Foreground(void) {
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive; Post(UIApplicationWillEnterForegroundNotification,nil,nil);
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive; Post(UIApplicationDidBecomeActiveNotification,nil,nil);
}
static BOOL SameDate(NSDate *a,NSDate *b) { return a && b && fabs([a timeIntervalSinceDate:b])<.000001; }
static NSUInteger EventCount(NSString *source) {
    NSUInteger count=0;
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents)
        if ([event.source isEqual:source]) count++;
    return count;
}
static void Create(NSTimeInterval remaining,BOOL alreadyBackground) {
    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.activationAction=nil; CSTestFailPlayerCreation=CSTestFailPlayerPlay=NO;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    UIApplication.sharedApplication.applicationState=alreadyBackground?UIApplicationStateBackground:UIApplicationStateActive;
    UIApplication.sharedApplication.connectedScenes=[NSSet set];
    [defaults setBool:YES forKey:CSBackgroundRunEnabledKey];
    audio=[CSBackgroundRunAudio new]; runtime=[CSTestBackgroundRuntime new];
    runtime.backgroundTimeRemaining=remaining; runtime.decrementsBudget=NO;
    manager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:YES runtime:runtime];
    [manager start];
}

int main(void) { @autoreleasepool {
    CSTestInstallBlankBundle();
    NSString *suite=[@"background-record-tests-" stringByAppendingString:NSUUID.UUID.UUIDString];
    defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];

    // Foreground setup has never observed a background entry or check.
    Create(120,NO);
    CHECK(!manager.lastBackgroundStartedAt && !manager.lastBackgroundCheckedAt);
    CHECK(!manager.lastForegroundReturnedAt && !manager.lastBackgroundStoppedAt);
    CHECK(!manager.lastBackgroundStartObserved && manager.lastCheckToForegroundInterval==-1);
    CHECK(manager.lastBackgroundCheckStatus.length && manager.lastBackgroundStopReason.length);

    // A successful check must advance the record even when its status is unchanged.
    NSDate *entry=runtime.currentDate; Background();
    CHECK(SameDate(manager.lastBackgroundStartedAt,entry) && manager.lastBackgroundStartObserved);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,entry));
    NSString *taskStatus=manager.statusText;
    CHECK([manager.lastBackgroundCheckStatus isEqual:taskStatus]);
    __block NSUInteger stateNotifications=0;
    id stateObserver=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note) { stateNotifications++; }];
    [runtime advanceBy:1.5];
    CHECK(SameDate(manager.lastBackgroundCheckedAt,runtime.currentDate));
    CHECK(stateNotifications==0);
    [runtime advanceBy:23.5];
    CHECK(SameDate(manager.lastBackgroundCheckedAt,runtime.currentDate));
    CHECK([manager.lastBackgroundCheckStatus isEqual:taskStatus]);
    CHECK(SameDate(manager.lastBackgroundStartedAt,entry));
    CHECK(stateNotifications==0); // A timestamp-only check must not wake AI/UI observers.

    // Opening settings and redundant lifecycle notifications cannot fabricate a
    // more recent heartbeat. Foreground return must preserve the real last check.
    NSDate *checked=manager.lastBackgroundCheckedAt;
    [runtime advanceBy:3];
    for (NSUInteger i=0;i<10;i++) { [manager reloadSettings]; Post(NSUserDefaultsDidChangeNotification,nil,nil); Background(); }
    CHECK(SameDate(manager.lastBackgroundCheckedAt,checked));
    CHECK(SameDate(manager.lastBackgroundStartedAt,entry));
    Foreground(); NSDate *returned=runtime.currentDate;
    CHECK(stateNotifications>0);
    CHECK(SameDate(manager.lastForegroundReturnedAt,returned));
    CHECK(SameDate(manager.lastBackgroundCheckedAt,checked));
    CHECK([manager.lastBackgroundCheckStatus isEqual:taskStatus]);
    CHECK(fabs(manager.lastCheckToForegroundInterval-3)<.000001);
    CHECK(SameDate(manager.lastBackgroundStoppedAt,returned) && [manager.lastBackgroundStopReason containsString:@"前台"]);
    [runtime advanceBy:7]; Foreground(); [manager reloadSettings];
    CHECK(SameDate(manager.lastForegroundReturnedAt,returned) && SameDate(manager.lastBackgroundStoppedAt,returned));
    CHECK(SameDate(manager.lastBackgroundCheckedAt,checked) && fabs(manager.lastCheckToForegroundInterval-3)<.000001);
    [NSNotificationCenter.defaultCenter removeObserver:stateObserver];

    // Expiration is an actual evaluation. A later return records its own time
    // without replacing the original terminal reason, time, or check snapshot.
    Create(120,NO); Background(); [runtime advanceBy:10];
    [runtime.tasks.firstObject expire]; NSDate *expired=runtime.currentDate;
    CHECK(SameDate(manager.lastBackgroundStoppedAt,expired) && [manager.lastBackgroundStopReason containsString:@"到期"]);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,expired));
    CHECK([manager.lastBackgroundCheckStatus isEqual:manager.statusText]);
    NSString *expiredStatus=manager.lastBackgroundCheckStatus, *expiredReason=manager.lastBackgroundStopReason;
    [runtime advanceBy:20]; Post(AVAudioSessionRouteChangeNotification,nil,nil); [manager reloadSettings];
    CHECK(SameDate(manager.lastBackgroundCheckedAt,expired));
    Foreground();
    CHECK(SameDate(manager.lastForegroundReturnedAt,runtime.currentDate));
    CHECK(SameDate(manager.lastBackgroundStoppedAt,expired) && [manager.lastBackgroundStopReason isEqual:expiredReason]);
    CHECK([manager.lastBackgroundCheckStatus isEqual:expiredStatus] && fabs(manager.lastCheckToForegroundInterval-20)<.000001);

    // Disabling records a stop, while re-enabling during the same background
    // stay starts another actual check without inventing a new entry timestamp.
    Create(120,NO); Background(); entry=manager.lastBackgroundStartedAt;
    CSTestBackgroundCheck *stale=runtime.checks.lastObject;
    [runtime advanceBy:5]; checked=manager.lastBackgroundCheckedAt; Enable(NO);
    CHECK(SameDate(manager.lastBackgroundStoppedAt,runtime.currentDate) && [manager.lastBackgroundStopReason containsString:@"关"]);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,checked));
    [runtime advanceBy:2]; Enable(YES);
    CHECK(SameDate(manager.lastBackgroundStartedAt,entry) && manager.lastBackgroundStartObserved);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,runtime.currentDate));
    CHECK(!manager.lastBackgroundStoppedAt && manager.lastCheckToForegroundInterval==-1);
    checked=manager.lastBackgroundCheckedAt; [runtime advanceBy:1]; [stale fireEvenIfCancelled];
    CHECK(SameDate(manager.lastBackgroundCheckedAt,checked));
    Foreground();

    // A new actual entry replaces the previous stay's return/stop information;
    // late callbacks from that previous stay must not modify the new record.
    Create(120,NO); Background(); stale=runtime.checks.lastObject;
    CSTestBackgroundTask *oldTask=runtime.tasks.firstObject;
    [runtime advanceBy:4]; Foreground(); [runtime advanceBy:6]; Background();
    entry=runtime.currentDate; checked=manager.lastBackgroundCheckedAt;
    CHECK(SameDate(manager.lastBackgroundStartedAt,entry) && manager.lastBackgroundStartObserved);
    CHECK(!manager.lastForegroundReturnedAt && !manager.lastBackgroundStoppedAt);
    CHECK(manager.lastCheckToForegroundInterval==-1);
    [runtime advanceBy:1]; [stale fireEvenIfCancelled]; [oldTask expire];
    CHECK(SameDate(manager.lastBackgroundStartedAt,entry) && SameDate(manager.lastBackgroundCheckedAt,checked));
    CHECK(!manager.lastBackgroundStoppedAt && manager.canAttemptBackgroundWork);
    Foreground();

    // A late-loaded manager only knows when it began observing the background.
    Create(120,YES);
    CHECK(SameDate(manager.lastBackgroundStartedAt,runtime.currentDate) && !manager.lastBackgroundStartObserved);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,runtime.currentDate));
    [runtime advanceBy:3]; Foreground(); CHECK(fabs(manager.lastCheckToForegroundInterval-1.5)<.000001);
    [runtime advanceBy:2]; Background();
    CHECK(SameDate(manager.lastBackgroundStartedAt,runtime.currentDate) && manager.lastBackgroundStartObserved);
    Foreground();

    // Display timestamps follow wall-clock changes. The diagnostic interval
    // follows monotonic time, including when the wall clock moves backwards.
    Create(120,NO); Background(); [runtime advanceBy:25]; checked=manager.lastBackgroundCheckedAt;
    runtime.currentDate=[runtime.currentDate dateByAddingTimeInterval:-3600];
    [runtime advanceBy:5]; Foreground();
    CHECK([manager.lastForegroundReturnedAt compare:checked]==NSOrderedAscending);
    CHECK(fabs(manager.lastCheckToForegroundInterval-5)<.000001);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,checked));

    // A synchronous foreground transition during native activation must not
    // publish a background check afterwards or erase the recorded return.
    Create(7,NO);
    AVAudioSession.sharedInstance.activationAction=^{
        runtime.uptime+=2; runtime.currentDate=[runtime.currentDate dateByAddingTimeInterval:2]; Foreground();
    };
    Background();
    // Deliver at the first deadline directly so the activation's simulated
    // synchronous two-second work is not rewound by advanceBy:'s target clock.
    NSTimeInterval delay=runtime.checks.lastObject.deadline-runtime.uptime;
    runtime.uptime+=delay; runtime.currentDate=[runtime.currentDate dateByAddingTimeInterval:delay];
    [runtime.checks.lastObject fireEvenIfCancelled]; returned=runtime.currentDate;
    CHECK(!manager.canAttemptBackgroundWork && !audio.playing && !runtime.liveTaskCount && !runtime.pendingCheckCount);
    CHECK(SameDate(manager.lastForegroundReturnedAt,returned));
    CHECK(!manager.lastBackgroundCheckedAt || [manager.lastBackgroundCheckedAt compare:returned]!=NSOrderedDescending);
    CHECK([manager.lastBackgroundStopReason containsString:@"前台"]);
    checked=manager.lastBackgroundCheckedAt;
    [runtime advanceBy:3]; [manager reloadSettings]; Foreground();
    CHECK(SameDate(manager.lastForegroundReturnedAt,returned));
    CHECK((!checked && !manager.lastBackgroundCheckedAt) || SameDate(manager.lastBackgroundCheckedAt,checked));

    // A final system expiration must remain distinct from the actual 1.5s and
    // 25s timer callbacks, with no invented periodic check at the expiration.
    Create(120,NO);
    CHECK(!manager.firstScheduledCheckAt && !manager.lastPeriodicCheckAt && !manager.lastTaskExpiredAt);
    CHECK(!manager.lastBackgroundEvents.count && !manager.periodicCheckCount && !manager.droppedBackgroundEventCount);
    Background(); entry=runtime.currentDate;
    CHECK([manager.lastBackgroundEvents.firstObject.source isEqual:@"进入后台"]);
    CHECK(fabs(manager.lastBackgroundEvents.firstObject.elapsed)<.000001);
    CHECK(!manager.firstScheduledCheckAt && !manager.lastPeriodicCheckAt);
    [runtime advanceBy:1.5]; NSDate *firstCheck=runtime.currentDate;
    CHECK(SameDate(manager.firstScheduledCheckAt,firstCheck));
    CHECK(EventCount(@"首次检查")==1 && !manager.periodicCheckCount);
    CHECK(!manager.lastPeriodicCheckAt && !manager.lastTaskExpiredAt);
    NSArray<CSBackgroundRunRecordEvent *> *snapshot=manager.lastBackgroundEvents;
    NSUInteger snapshotCount=snapshot.count;
    [runtime advanceBy:23.5]; NSDate *periodicCheck=runtime.currentDate;
    CHECK(manager.periodicCheckCount==1 && EventCount(@"周期检查")==1);
    CHECK(SameDate(manager.lastPeriodicCheckAt,periodicCheck));
    CHECK(SameDate(manager.firstScheduledCheckAt,firstCheck));
    CHECK(snapshot.count==snapshotCount); // Getter returns an immutable snapshot.
    NSUInteger beforeReread=manager.lastBackgroundEvents.count;
    for (NSUInteger i=0;i<10;i++) { [manager reloadSettings]; Post(NSUserDefaultsDidChangeNotification,nil,nil); Background(); }
    CHECK(manager.lastBackgroundEvents.count==beforeReread);
    [runtime advanceBy:8]; [runtime.tasks.lastObject expire]; expired=runtime.currentDate;
    CHECK(SameDate(manager.lastTaskExpiredAt,expired));
    CHECK(SameDate(manager.firstScheduledCheckAt,firstCheck));
    CHECK(SameDate(manager.lastPeriodicCheckAt,periodicCheck) && manager.periodicCheckCount==1);
    CHECK(EventCount(@"系统到期")==1 && EventCount(@"停止")==1);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,expired)); // Legacy evaluation timestamp remains compatible.
    CHECK(!runtime.liveTaskCount && !runtime.pendingCheckCount && !audio.playing);
    [runtime advanceBy:7]; Foreground();
    CHECK(EventCount(@"返回前台")==1 && EventCount(@"周期检查")==1);
    CHECK(SameDate(manager.lastPeriodicCheckAt,periodicCheck));
    CHECK(fabs(manager.lastBackgroundEvents.lastObject.elapsed-40)<.000001);

    // Observing an invalid handle is different from receiving a system
    // expiration callback; it must not fabricate the system-expiration time.
    Create(120,NO); Background(); [runtime advanceBy:1.5];
    [runtime.tasks.lastObject end];
    Post(AVAudioSessionRouteChangeNotification,nil,nil);
    CHECK(EventCount(@"任务失效")==1 && EventCount(@"系统到期")==0);
    CHECK(!manager.lastTaskExpiredAt && manager.lastBackgroundStoppedAt);
    CHECK(!runtime.pendingCheckCount && !runtime.liveTaskCount);

    // The system invalidates a task before its queued callback. An intervening
    // settings evaluation must retain the actual expiration date and elapsed
    // time, without a false "unknown invalidation" or a second terminal event.
    Create(120,NO); Background(); [runtime advanceBy:1.5];
    CSTestBackgroundTask *queuedExpiration=runtime.tasks.lastObject;
    [runtime advanceBy:8];
    expired=runtime.currentDate;
    NSTimeInterval expirationElapsed=runtime.uptime-100;
    [queuedExpiration expireDeferringCallback];
    CHECK(!queuedExpiration.valid && SameDate(queuedExpiration.expirationDate,expired));
    [runtime advanceBy:1]; [manager reloadSettings];
    CHECK(SameDate(manager.lastTaskExpiredAt,expired));
    CHECK(EventCount(@"系统到期")==1 && EventCount(@"任务失效")==0 && EventCount(@"停止")==1);
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents)
        if ([event.source isEqual:@"系统到期"]) CHECK(fabs(event.elapsed-expirationElapsed)<.000001);
    beforeReread=manager.lastBackgroundEvents.count;
    [queuedExpiration deliverExpirationCallback];
    CHECK(manager.lastBackgroundEvents.count==beforeReread && SameDate(manager.lastTaskExpiredAt,expired));
    CHECK(!runtime.pendingCheckCount && !runtime.liveTaskCount && queuedExpiration.endCalls==1);

    // Returning to the foreground can precede the queued callback. Closing the
    // observation must consume its real snapshot without starting new work.
    Create(120,NO); Background(); [runtime advanceBy:9.5];
    queuedExpiration=runtime.tasks.lastObject;
    expired=runtime.currentDate; expirationElapsed=runtime.uptime-100;
    [queuedExpiration expireDeferringCallback]; [runtime advanceBy:1];
    NSUInteger attemptsBeforeStop=runtime.beginAttempts, playersBeforeStop=CSTestPlayerCreates;
    Foreground();
    CHECK(SameDate(manager.lastTaskExpiredAt,expired));
    CHECK(EventCount(@"系统到期")==1 && EventCount(@"任务失效")==0 && EventCount(@"停止")==1);
    CHECK(EventCount(@"返回前台")==1 && SameDate(manager.lastForegroundReturnedAt,runtime.currentDate));
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents)
        if ([event.source isEqual:@"系统到期"]) CHECK(fabs(event.elapsed-expirationElapsed)<.000001);
    CHECK(!runtime.liveTaskCount && !runtime.pendingCheckCount && queuedExpiration.endCalls==1);
    CHECK(runtime.beginAttempts==attemptsBeforeStop && CSTestPlayerCreates==playersBeforeStop);
    beforeReread=manager.lastBackgroundEvents.count;
    [queuedExpiration deliverExpirationCallback]; Foreground();
    CHECK(manager.lastBackgroundEvents.count==beforeReread && SameDate(manager.lastTaskExpiredAt,expired));

    // Either the global toggle or the last group consumer can end the shared
    // cycle. Both shutdown paths preserve expiration before its callback.
    for (NSUInteger groupIsLast=0;groupIsLast<2;groupIsLast++) {
        Create(120,NO);
        if (groupIsLast) [manager setGroupChatBackgroundRequested:YES];
        Background(); [runtime advanceBy:1.5];
        if (groupIsLast) {
            Enable(NO);
            CHECK(runtime.liveTaskCount==1 && !manager.lastBackgroundStoppedAt);
        }
        [runtime advanceBy:8]; queuedExpiration=runtime.tasks.lastObject;
        expired=runtime.currentDate; expirationElapsed=runtime.uptime-100;
        [queuedExpiration expireDeferringCallback]; [runtime advanceBy:1];
        attemptsBeforeStop=runtime.beginAttempts; playersBeforeStop=CSTestPlayerCreates;
        if (groupIsLast) [manager setGroupChatBackgroundRequested:NO]; else Enable(NO);
        CHECK(SameDate(manager.lastTaskExpiredAt,expired));
        CHECK(EventCount(@"系统到期")==1 && EventCount(@"任务失效")==0 && EventCount(@"停止")==1);
        CHECK(SameDate(manager.lastBackgroundStoppedAt,runtime.currentDate));
        for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents)
            if ([event.source isEqual:@"系统到期"]) CHECK(fabs(event.elapsed-expirationElapsed)<.000001);
        CHECK(!runtime.liveTaskCount && !runtime.pendingCheckCount && queuedExpiration.endCalls==1);
        CHECK(runtime.beginAttempts==attemptsBeforeStop && CSTestPlayerCreates==playersBeforeStop);
        beforeReread=manager.lastBackgroundEvents.count;
        [queuedExpiration deliverExpirationCallback];
        CHECK(manager.lastBackgroundEvents.count==beforeReread && SameDate(manager.lastTaskExpiredAt,expired));
        Foreground();
    }

    // The notification writes its newer event before reconcile reads an older
    // expiration snapshot. Sort by elapsed even if wall time was set backward.
    Create(120,NO); Background(); [runtime advanceBy:9.5];
    queuedExpiration=runtime.tasks.lastObject;
    expired=runtime.currentDate; expirationElapsed=runtime.uptime-100;
    [queuedExpiration expireDeferringCallback];
    runtime.currentDate=[runtime.currentDate dateByAddingTimeInterval:-3600];
    [runtime advanceBy:1];
    Post(AVAudioSessionInterruptionNotification,AVAudioSession.sharedInstance,
        @{AVAudioSessionInterruptionTypeKey:@(AVAudioSessionInterruptionTypeBegan)});
    CHECK(SameDate(manager.lastTaskExpiredAt,expired) && EventCount(@"系统到期")==1);
    NSUInteger expirationIndex=NSNotFound, interruptionIndex=NSNotFound, eventIndex=0;
    NSTimeInterval orderedElapsed=-1;
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents) {
        if (event.elapsed>=0) { CHECK(event.elapsed>=orderedElapsed); orderedElapsed=event.elapsed; }
        if ([event.source isEqual:@"系统到期"]) {
            expirationIndex=eventIndex;
            CHECK(fabs(event.elapsed-expirationElapsed)<.000001);
        }
        if ([event.source isEqual:@"系统中断"]) {
            interruptionIndex=eventIndex;
            CHECK([event.date compare:expired]==NSOrderedAscending);
        }
        eventIndex++;
    }
    CHECK(expirationIndex!=NSNotFound && interruptionIndex!=NSNotFound && expirationIndex<interruptionIndex);
    CHECK([manager.lastBackgroundEvents.firstObject.source isEqual:@"进入后台"]);
    beforeReread=manager.lastBackgroundEvents.count;
    [queuedExpiration deliverExpirationCallback];
    CHECK(manager.lastBackgroundEvents.count==beforeReread && EventCount(@"系统到期")==1);
    Foreground();

    // A queued expiration from an already observed, ended visit cannot append
    // to the replacement visit even when delivered after a new lease starts.
    Create(120,NO); Background(); [runtime advanceBy:1.5];
    queuedExpiration=runtime.tasks.lastObject;
    [queuedExpiration expireDeferringCallback]; [manager reloadSettings];
    CHECK(EventCount(@"系统到期")==1);
    Foreground(); Background();
    beforeReread=manager.lastBackgroundEvents.count;
    [queuedExpiration deliverExpirationCallback];
    CHECK(manager.lastBackgroundEvents.count==beforeReread && !manager.lastTaskExpiredAt);
    CHECK(manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);

    // Retention is bounded, preserves the initial entry and stable first-check
    // summary, and reports omitted events instead of presenting a full history.
    Create(120,NO); Background();
    [runtime advanceBy:1.5]; firstCheck=manager.firstScheduledCheckAt;
    snapshot=manager.lastBackgroundEvents; snapshotCount=snapshot.count;
    [runtime advanceBy:1248.5];
    CHECK(manager.periodicCheckCount==50);
    CHECK(manager.lastBackgroundEvents.count<=80 && manager.droppedBackgroundEventCount>0);
    CHECK([manager.lastBackgroundEvents.firstObject.source isEqual:@"进入后台"]);
    CHECK(SameDate(manager.firstScheduledCheckAt,firstCheck));
    CHECK(snapshot.count==snapshotCount);
    NSTimeInterval previousElapsed=-1;
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents) {
        CHECK(event.date && event.source.length && event.detail.length);
        CHECK(event.elapsed>=previousElapsed);
        previousElapsed=event.elapsed;
    }
    // Inserting a late snapshot into a full timeline still retains the entry
    // and the latest 79 events, with bounded storage and ordered known offsets.
    CSBackgroundRunRecordEvent *retainedEntry=manager.lastBackgroundEvents.firstObject;
    NSUInteger droppedBeforeDelayed=manager.droppedBackgroundEventCount;
    queuedExpiration=runtime.tasks.lastObject;
    [queuedExpiration expireDeferringCallback]; [runtime advanceBy:1];
    Post(AVAudioSessionInterruptionNotification,AVAudioSession.sharedInstance,
        @{AVAudioSessionInterruptionTypeKey:@(AVAudioSessionInterruptionTypeBegan)});
    CHECK(manager.lastBackgroundEvents.count==80 && manager.droppedBackgroundEventCount>droppedBeforeDelayed);
    CHECK(manager.lastBackgroundEvents.firstObject==retainedEntry && EventCount(@"系统到期")==1);
    previousElapsed=-1;
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents) {
        if (event.elapsed>=0) { CHECK(event.elapsed>=previousElapsed); previousElapsed=event.elapsed; }
    }
    beforeReread=manager.lastBackgroundEvents.count;
    [queuedExpiration deliverExpirationCallback];
    CHECK(manager.lastBackgroundEvents.count==beforeReread && EventCount(@"系统到期")==1);
    Foreground(); Background();
    CHECK(!manager.droppedBackgroundEventCount && !manager.periodicCheckCount);
    CHECK(!manager.firstScheduledCheckAt && !manager.lastPeriodicCheckAt && !manager.lastTaskExpiredAt);
    CHECK([manager.lastBackgroundEvents.firstObject.source isEqual:@"进入后台"]);

    // Elapsed time is independent of wall-clock corrections. Delayed callbacks
    // from the previous visit must not append to the new visit's timeline.
    Create(120,NO); Background();
    [runtime advanceBy:1.5];
    CSTestBackgroundTask *previousTask=runtime.tasks.lastObject;
    CSTestBackgroundCheck *previousTimer=runtime.checks.firstObject;
    runtime.currentDate=[runtime.currentDate dateByAddingTimeInterval:-3600];
    [runtime advanceBy:23.5];
    CHECK(manager.periodicCheckCount==1);
    CHECK(fabs(manager.lastBackgroundEvents.lastObject.elapsed-25)<.000001);
    CHECK([manager.lastPeriodicCheckAt compare:manager.firstScheduledCheckAt]==NSOrderedAscending);
    Foreground(); Background();
    beforeReread=manager.lastBackgroundEvents.count;
    [previousTimer fireEvenIfCancelled]; [previousTask expire];
    CHECK(manager.lastBackgroundEvents.count==beforeReread);
    CHECK(!manager.firstScheduledCheckAt && !manager.lastPeriodicCheckAt && !manager.lastTaskExpiredAt);

    // Mid-background observation is explicit; enabling again during a visit
    // keeps that visit's earlier stop and restart events available for review.
    Create(120,YES);
    CHECK([manager.lastBackgroundEvents.firstObject.source isEqual:@"开始观察"]);
    CHECK(!manager.firstScheduledCheckAt);
    [runtime advanceBy:1.5];
    CHECK(EventCount(@"首次检查")==1);
    Enable(NO); beforeReread=manager.lastBackgroundEvents.count;
    Enable(YES);
    CHECK(manager.lastBackgroundEvents.count>beforeReread);
    CHECK([manager.lastBackgroundEvents.firstObject.source isEqual:@"开始观察"]);

    // Reusing recovery resources does not invent another audio/task attempt or
    // erase the real grace evaluation, original first check, or prior expiry.
    Create(29,NO); Background(); [runtime advanceBy:1.5];
    NSDate *recoveryFirst=manager.firstScheduledCheckAt;
    [CSTestLastPlayer finishSuccessfully:YES]; [runtime.tasks.lastObject expire];
    NSDate *recoveryExpiration=manager.lastTaskExpiredAt;
    runtime.backgroundTimeRemaining=29;
    Post(AVAudioSessionInterruptionNotification,AVAudioSession.sharedInstance,
        @{AVAudioSessionInterruptionTypeKey:@(AVAudioSessionInterruptionTypeEnded)});
    NSTimeInterval recoveryEntry=runtime.uptime;
    [runtime advanceBy:.4]; CHECK(audio.playing && EventCount(@"恢复检查")==1);
    [CSTestLastPlayer finishSuccessfully:YES];
    NSUInteger recoveryAttempts=runtime.beginAttempts, recoveryPlayers=CSTestPlayerCreates;
    NSUInteger recordedAttempts=EventCount(@"音频尝试"), recordedRenewals=EventCount(@"任务替换");
    [runtime advanceBy:1.1];
    CHECK(runtime.beginAttempts==recoveryAttempts && CSTestPlayerCreates==recoveryPlayers && !audio.playing);
    CHECK(EventCount(@"首次检查")==2 && EventCount(@"资源复用")==1);
    CHECK(EventCount(@"音频尝试")==recordedAttempts && EventCount(@"任务替换")==recordedRenewals);
    CHECK(SameDate(manager.firstScheduledCheckAt,recoveryFirst));
    CHECK(SameDate(manager.lastTaskExpiredAt,recoveryExpiration) && EventCount(@"系统到期")==1);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,runtime.currentDate));
    CHECK(!manager.periodicCheckCount && !manager.lastPeriodicCheckAt);
    CHECK([manager.lastBackgroundEvents.lastObject.source isEqual:@"资源复用"]);
    CHECK(fabs(manager.lastBackgroundEvents.lastObject.elapsed-3)<.000001);
    [runtime advanceBy:recoveryEntry+25-runtime.uptime];
    CHECK(manager.periodicCheckCount==1 && SameDate(manager.lastPeriodicCheckAt,runtime.currentDate));
    CHECK(runtime.beginAttempts==recoveryAttempts+1 && CSTestPlayerCreates==recoveryPlayers+1 && EventCount(@"资源复用")==1);
    Foreground();

    // A recovery above the threshold has no resource success to reuse. If the
    // budget crosses below 30s before grace, record its actual new requests.
    Create(31,NO); Background(); [runtime advanceBy:1.5];
    recoveryFirst=manager.firstScheduledCheckAt; [runtime.tasks.lastObject expire];
    runtime.backgroundTimeRemaining=31;
    Post(AVAudioSessionInterruptionNotification,AVAudioSession.sharedInstance,
        @{AVAudioSessionInterruptionTypeKey:@(AVAudioSessionInterruptionTypeEnded)});
    [runtime advanceBy:.4];
    CHECK(!audio.playing && !EventCount(@"音频尝试") && !EventCount(@"任务替换"));
    runtime.backgroundTimeRemaining=29;
    [runtime advanceBy:1.1];
    CHECK(audio.playing && EventCount(@"音频尝试")==1 && EventCount(@"任务替换")==1);
    CHECK(EventCount(@"首次检查")==2 && !EventCount(@"资源复用"));
    CHECK(SameDate(manager.firstScheduledCheckAt,recoveryFirst) && SameDate(manager.lastBackgroundCheckedAt,runtime.currentDate));
    Foreground();

    // Audio outcomes and task attempts are observable without issuing any extra
    // native work. A denied initial task must not fabricate a scheduled check.
    Create(7,NO); Background(); [runtime advanceBy:1.5];
    CHECK(audio.playing && runtime.beginAttempts==2);
    CHECK(EventCount(@"音频尝试")==1 && EventCount(@"任务替换")==1);
    [CSTestLastPlayer finishSuccessfully:YES];
    CHECK(EventCount(@"音频结束")==1 && !audio.playing);
    Create(7,NO); CSTestBlankResourceAvailable=NO;
    Background(); [runtime advanceBy:1.5];
    CHECK(EventCount(@"音频尝试")==1 && !audio.playing && runtime.beginAttempts==2);
    CSTestBlankResourceAvailable=YES;
    Create(120,NO); runtime.failBegin=YES; Background();
    CHECK(EventCount(@"任务初次申请")==1 && EventCount(@"停止")==1);
    CHECK(!manager.firstScheduledCheckAt && !runtime.liveTaskCount && !runtime.pendingCheckCount);

    // An old audio attempt cannot report success into a new visit when native
    // activation synchronously exits and re-enters the background.
    Create(7,NO);
    AVAudioSession.sharedInstance.activationAction=^{
        AVAudioSession.sharedInstance.activationAction=nil;
        Foreground(); Background();
    };
    Background(); [runtime advanceBy:1.5];
    CHECK(SameDate(manager.lastBackgroundStartedAt,runtime.currentDate));
    CHECK(!manager.firstScheduledCheckAt && !manager.periodicCheckCount);
    CHECK(EventCount(@"首次检查")==0 && EventCount(@"音频尝试")==0);
    CHECK(manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);

    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil; runtime=nil; Drain();
    CHECK(!CSTestPlayersAlive);
    [defaults removePersistentDomainForName:suite];
    printf("Background records: %lu checks passed; timer/expiration separation, bounded timelines, lifecycle timestamps and stale callbacks verified\n",(unsigned long)checks);
} return 0; }
