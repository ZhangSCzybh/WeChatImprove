#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <float.h>
#import <math.h>
#import "CSBackgroundRunManager.h"
#import "BackgroundRunFakeRuntime.h"

static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"HYBRID FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
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
static void Create(BOOL supported,NSTimeInterval remaining) {
    // Every fixture uses an isolated defaults domain and the production audio
    // adapter; only UIKit, AVFoundation and the execution clock are doubles.
    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.secondaryAudioShouldBeSilencedHint=NO; session.activationAction=nil;
    CSTestFailPlayerCreation=CSTestFailPlayerPreparation=CSTestFailPlayerPlay=NO;
    CSTestBlankResourceAvailable=YES;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    UIApplication.sharedApplication.connectedScenes=[NSSet set];
    [defaults setBool:YES forKey:CSBackgroundRunEnabledKey];
    [defaults removeObjectForKey:CSBackgroundRunCheckIntervalKey];
    audio=[CSBackgroundRunAudio new]; runtime=[CSTestBackgroundRuntime new];
    runtime.backgroundTimeRemaining=remaining; runtime.decrementsBudget=NO;
    manager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:supported runtime:runtime];
    [manager start];
}
static void SetInterval(id value) {
    if (value) [defaults setObject:value forKey:CSBackgroundRunCheckIntervalKey];
    else [defaults removeObjectForKey:CSBackgroundRunCheckIntervalKey];
    [manager reloadSettings];
}
static NSTimeInterval NextDeadline(void) {
    NSTimeInterval next=DBL_MAX;
    for (CSTestBackgroundCheck *check in runtime.checks)
        if (!check.cancelled && (!check.fired || check.repeating)) next=MIN(next,check.deadline);
    return next;
}
static void NoResources(void) {
    CHECK(!audio.playing && !manager.backgroundAudioActive && !manager.canAttemptBackgroundWork);
    CHECK(!runtime.liveTaskCount && !runtime.pendingCheckCount);
}
static void FinishPulse(void) { CHECK(CSTestLastPlayer!=nil); [CSTestLastPlayer finishSuccessfully:YES]; }
static void Interrupt(BOOL began,BOOL shouldResume) {
    Post(AVAudioSessionInterruptionNotification,AVAudioSession.sharedInstance,
        @{AVAudioSessionInterruptionTypeKey:@(began?AVAudioSessionInterruptionTypeBegan:AVAudioSessionInterruptionTypeEnded),
          AVAudioSessionInterruptionOptionKey:@(shouldResume?AVAudioSessionInterruptionOptionShouldResume:0)});
}
static id ObserveStateChanges(NSMutableArray<NSNumber *> *changes) {
    return [NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note) {
        NSNumber *mask=note.userInfo[CSBackgroundRunStateChangesKey];
        CHECK([mask isKindOfClass:NSNumber.class] && mask.unsignedIntegerValue!=0);
        [changes addObject:mask];
    }];
}
static NSTimeInterval ReopenExpiredCycle(NSTimeInterval remaining) {
    Create(YES,20); Background(); [runtime advanceBy:1.5]; FinishPulse();
    [runtime.tasks.lastObject expire]; NoResources();
    runtime.backgroundTimeRemaining=remaining; Interrupt(NO,NO);
    CHECK(manager.canAttemptBackgroundWork && runtime.liveTaskCount==1 && !audio.playing);
    return runtime.uptime;
}
static NSUInteger EventCount(NSString *source) {
    NSUInteger count=0;
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents)
        if ([event.source isEqual:source]) count++;
    return count;
}

int main(void) { @autoreleasepool {
    CSTestInstallBlankBundle();
    NSString *suite=[@"background-hybrid-tests-" stringByAppendingString:NSUUID.UUID.UUIDString];
    defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];

    // Entry acquires the native task immediately. The grace check and periodic
    // check have independent deadlines at 1.5 and 25 seconds from entry.
    Create(YES,20); Background();
    NSTimeInterval entry=runtime.uptime;
    CHECK(manager.checkInterval==25 && manager.canAttemptBackgroundWork && !audio.playing);
    CHECK(runtime.beginAttempts==1 && runtime.liveTaskCount==1);
    CHECK(fabs(NextDeadline()-entry-1.5)<.000001);
    NSDate *entryCheck=manager.lastBackgroundCheckedAt;
    NSUInteger players=CSTestPlayerCreates;
    for (NSUInteger i=0;i<20;i++) { Background(); Post(NSUserDefaultsDidChangeNotification,nil,nil); [manager reloadSettings]; }
    CHECK(runtime.beginAttempts==1 && CSTestPlayerCreates==players);
    CHECK([manager.lastBackgroundCheckedAt isEqualToDate:entryCheck] && fabs(NextDeadline()-entry-1.5)<.000001);
    [runtime advanceBy:1.49]; CHECK(!audio.playing && runtime.beginAttempts==1);
    CSTestBackgroundTask *first=runtime.tasks.firstObject;
    [runtime advanceBy:.01];
    CHECK(audio.playing && manager.backgroundAudioActive && manager.canAttemptBackgroundWork);
    CHECK(runtime.beginAttempts==1 && runtime.liveTaskCount==1 && first.endCalls==0);
    CHECK([CSTestLastPlayerURL.path isEqual:@"/host/WeChat.app/blank.caf"]);
    CHECK(CSTestLastPlayer.numberOfLoops==0 && CSTestLastPlayer.volume==0);
    CHECK(fabs(NextDeadline()-entry-25)<.000001);
    CSTestBackgroundTask *second=runtime.tasks.lastObject;
    CHECK(second==first && second.valid && second.endCalls==0 && manager.canAttemptBackgroundWork);
    FinishPulse();
    CHECK(!audio.playing && !manager.backgroundAudioActive && manager.canAttemptBackgroundWork && second.valid);
    players=CSTestPlayerCreates; NSUInteger attempts=runtime.beginAttempts;
    NSDate *pulseCheck=manager.lastBackgroundCheckedAt;
    for (NSUInteger i=0;i<20;i++) { Background(); Post(NSUserDefaultsDidChangeNotification,nil,nil); }
    CHECK(CSTestPlayerCreates==players && runtime.beginAttempts==attempts && [manager.lastBackgroundCheckedAt isEqualToDate:pulseCheck]);
    [runtime advanceBy:23.49]; CHECK(!audio.playing && runtime.beginAttempts==attempts);
    [runtime advanceBy:.01]; CHECK(audio.playing && runtime.beginAttempts==attempts);
    CHECK(fabs(NextDeadline()-entry-50)<.000001);
    Foreground(); NoResources(); CHECK(!AVAudioSession.sharedInstance.active);

    // External audio keeps the same grace and periodic cadence. Its silence
    // hints cannot stop a pulse or schedule extra recovery work between checks.
    Create(YES,20); AVAudioSession.sharedInstance.secondaryAudioShouldBeSilencedHint=YES;
    Background(); entry=runtime.uptime; [runtime advanceBy:1.5];
    CHECK(audio.playing && manager.backgroundAudioActive && runtime.beginAttempts==1);
    CHECK([AVAudioSession.sharedInstance.category isEqual:AVAudioSessionCategoryPlayback]);
    CHECK(AVAudioSession.sharedInstance.categoryOptions==AVAudioSessionCategoryOptionMixWithOthers);
    players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    NSUInteger hintScheduledChecks=runtime.checks.count;
    Post(AVAudioSessionSilenceSecondaryAudioHintNotification,AVAudioSession.sharedInstance,nil);
    CHECK(audio.playing && CSTestPlayerCreates==players && runtime.beginAttempts==attempts);
    CHECK(runtime.checks.count==hintScheduledChecks && fabs(NextDeadline()-entry-25)<.000001);
    FinishPulse();
    AVAudioSession.sharedInstance.secondaryAudioShouldBeSilencedHint=NO;
    Post(AVAudioSessionSilenceSecondaryAudioHintNotification,AVAudioSession.sharedInstance,nil);
    AVAudioSession.sharedInstance.secondaryAudioShouldBeSilencedHint=YES;
    Post(AVAudioSessionSilenceSecondaryAudioHintNotification,AVAudioSession.sharedInstance,nil);
    CHECK(!audio.playing && CSTestPlayerCreates==players && runtime.beginAttempts==attempts);
    CHECK(runtime.checks.count==hintScheduledChecks && fabs(NextDeadline()-entry-25)<.000001);
    [runtime advanceBy:23.49];
    CHECK(!audio.playing && CSTestPlayerCreates==players && runtime.beginAttempts==attempts);
    [runtime advanceBy:.01];
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
    CHECK(fabs(NextDeadline()-entry-50)<.000001);
    Foreground(); NoResources();

    // The public interval is normalized once. Grace remains 1.5 seconds while
    // actual subsequent checks use the configured wall-clock cadence.
    NSArray *settings=@[@10,@30,@9,@31,@10.6,@29.6,@"15",@[],@(NAN),@(INFINITY)];
    const NSTimeInterval expected[]={10,30,10,30,11,30,25,25,25,25};
    for (NSUInteger i=0;i<settings.count;i++) {
        Create(YES,20); SetInterval(settings[i]); CHECK(manager.checkInterval==expected[i]);
        Background(); entry=runtime.uptime;
        CHECK(!audio.playing && fabs(NextDeadline()-entry-1.5)<.000001);
        [runtime advanceBy:1.5]; CHECK(audio.playing); FinishPulse();
        CHECK(fabs(NextDeadline()-entry-expected[i])<.000001);
        [runtime advanceBy:expected[i]-1.5]; CHECK(audio.playing && runtime.beginAttempts==1);
        Foreground(); NoResources();
    }

    // One periodic handle survives normal ticks and a long suspension. The
    // delivery clock slides forward without allocating or catching up checks.
    Create(YES,20); Background(); entry=runtime.uptime;
    CSTestBackgroundCheck *periodicCheck=runtime.checks.firstObject;
    CHECK(periodicCheck.repeating && runtime.checks.count==2);
    [runtime advanceBy:1.5]; FinishPulse();
    [runtime advanceBy:23.5];
    CHECK(manager.periodicCheckCount==1 && audio.playing);
    CHECK(runtime.checks.count==2 && runtime.pendingCheckCount==1 && periodicCheck.fired);
    FinishPulse(); players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    [runtime advanceWithoutDeliveryBy:99];
    NSTimeInterval deliveredAt=runtime.uptime;
    CHECK(manager.periodicCheckCount==1 && !audio.playing);
    [runtime advanceBy:0];
    CHECK(runtime.uptime==deliveredAt && manager.periodicCheckCount==2);
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
    CHECK(runtime.checks.count==2 && runtime.checks.firstObject==periodicCheck);
    CHECK(fabs(NextDeadline()-deliveredAt-25)<.000001);
    FinishPulse(); [runtime advanceBy:24.999];
    CHECK(!audio.playing && manager.periodicCheckCount==2);
    [runtime advanceBy:.001]; CHECK(audio.playing && manager.periodicCheckCount==3);
    CHECK(runtime.checks.count==2 && fabs(NextDeadline()-runtime.uptime-25)<.000001);
    SetInterval(@10);
    CSTestBackgroundCheck *newPeriodic=runtime.checks.lastObject;
    CHECK(periodicCheck.cancelled && newPeriodic.repeating && newPeriodic!=periodicCheck && runtime.pendingCheckCount==1);
    [periodicCheck fireEvenIfCancelled];
    CHECK(manager.periodicCheckCount==3 && fabs(NextDeadline()-runtime.uptime-10)<.000001);
    Foreground(); NoResources();
    [newPeriodic fireEvenIfCancelled]; CHECK(manager.periodicCheckCount==3 && !audio.playing);

    // A native boundary can run a nested loop longer than one interval. The
    // deterministic clock must model Runtime's no-reentry/no-catch-up rule.
    CSTestBackgroundRuntime *nestedClock=[CSTestBackgroundRuntime new];
    __weak CSTestBackgroundRuntime *weakClock=nestedClock;
    __block NSUInteger nestedFires=0;
    id<CSBackgroundRunScheduledCheck> nestedCheck=[nestedClock scheduleEvery:10 handler:^{
        if (++nestedFires==1) [weakClock advanceBy:35];
    }];
    [nestedClock advanceBy:10];
    CHECK(nestedFires==1 && nestedClock.uptime==145 && nestedClock.pendingCheckCount==1);
    CHECK(nestedClock.checks.firstObject.deadline==155);
    [nestedClock advanceBy:10]; CHECK(nestedFires==2 && nestedClock.uptime==155);
    [nestedCheck cancel]; CHECK(!nestedClock.pendingCheckCount);

    // Only a real scheduled check and a strictly positive budget below thirty
    // seconds may pulse. Settings/lifecycle bursts never manufacture a pulse.
    const NSTimeInterval budgets[]={30,DBL_MAX,0,-1,NAN,INFINITY,29.999,.001};
    for (NSUInteger i=0;i<sizeof(budgets)/sizeof(budgets[0]);i++) {
        Create(YES,budgets[i]); Background(); players=CSTestPlayerCreates;
        CHECK(!audio.playing);
        Post(CSBackgroundRunSettingsChangedNotification,nil,nil); Background();
        CHECK(CSTestPlayerCreates==players);
        [runtime advanceBy:1.5];
        CHECK(audio.playing==(i>=6));
        CHECK(CSTestPlayerCreates==players+(i>=6?1:0));
        Foreground(); NoResources();
    }

    // Audio/resource failures retain the valid task without requesting another.
    // Fixing the resource cannot cause an immediate audio or task retry.
    for (NSUInteger failure=0;failure<3;failure++) {
        Create(failure!=2,20); Background(); first=runtime.tasks.firstObject;
        CSTestBlankResourceAvailable=failure!=0; CSTestFailPlayerPlay=failure==1;
        [runtime advanceBy:1.5];
        CHECK(!audio.playing && first.endCalls==0 && runtime.liveTaskCount==1 && manager.canAttemptBackgroundWork);
        CHECK(runtime.beginAttempts==1 && runtime.tasks.lastObject==first && first.valid);
        players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
        CSTestBlankResourceAvailable=YES; CSTestFailPlayerPlay=NO;
        for (NSUInteger i=0;i<10;i++) Post(NSUserDefaultsDidChangeNotification,nil,nil);
        [runtime advanceBy:23.49];
        CHECK(!audio.playing && CSTestPlayerCreates==players && runtime.beginAttempts==attempts);
        [runtime advanceBy:.01];
        CHECK(audio.playing==(failure!=2));
        Foreground(); NoResources();
    }

    // Ordinary checks never request replacement while a usable task exists,
    // even when a hypothetical new request would fail.
    Create(YES,20); Background(); first=runtime.tasks.firstObject; runtime.failBegin=YES;
    [runtime advanceBy:1.5];
    CHECK(audio.playing && runtime.beginAttempts==1 && first.valid && first.endCalls==0 && runtime.liveTaskCount==1);
    FinishPulse(); CHECK(manager.canAttemptBackgroundWork && !manager.backgroundAudioActive);
    runtime.failBegin=NO; attempts=runtime.beginAttempts;
    [manager reloadSettings]; CHECK(runtime.beginAttempts==attempts);
    [runtime advanceBy:23.5];
    CHECK(audio.playing && runtime.beginAttempts==attempts && first.endCalls==0 && runtime.liveTaskCount==1);
    Foreground(); NoResources();

    // An initial task refusal cannot create an immediate audio fallback or a
    // timer retry loop. A new foreground/background epoch is a new opportunity.
    Create(YES,20); runtime.failBegin=YES; Background();
    CHECK(!audio.playing && !manager.canAttemptBackgroundWork && runtime.beginAttempts==1);
    NoResources(); players=CSTestPlayerCreates;
    runtime.failBegin=NO; [runtime advanceBy:50];
    CHECK(runtime.beginAttempts==1 && CSTestPlayerCreates==players); NoResources();
    Foreground(); Background(); CHECK(!audio.playing);
    [runtime advanceBy:1.5];
    CHECK(audio.playing && manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);
    Foreground(); NoResources();

    // Native WeChat ownership wins even while external audio is allowed. A
    // a confirmed release resumes immediately despite the external silence hint.
    Create(YES,20); AVAudioSession.sharedInstance.secondaryAudioShouldBeSilencedHint=YES;
    Background(); entry=runtime.uptime; [runtime advanceBy:1.5]; CHECK(audio.playing);
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
    CHECK(!audio.playing && !manager.backgroundAudioActive && manager.canAttemptBackgroundWork);
    NSUInteger deactivations=AVAudioSession.sharedInstance.deactivations;
    NSUInteger hostConfigurations=AVAudioSession.sharedInstance.configurations;
    CHECK(AVAudioSession.sharedInstance.active);
    [runtime advanceBy:1]; CHECK(!audio.playing && AVAudioSession.sharedInstance.deactivations==deactivations);
    CHECK(AVAudioSession.sharedInstance.configurations==hostConfigurations);
    CHECK([AVAudioSession.sharedInstance.category isEqual:AVAudioSessionCategoryPlayAndRecord]);
    CHECK([AVAudioSession.sharedInstance.mode isEqual:@"VoiceChat"] && AVAudioSession.sharedInstance.categoryOptions==4);
    players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    [AVAudioSession.sharedInstance setActive:NO error:NULL];
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [AVAudioSession.sharedInstance setMode:AVAudioSessionModeDefault error:NULL]; Drain();
    CHECK(audio.playing && manager.canAttemptBackgroundWork && CSTestPlayerCreates==players+1);
    CHECK(runtime.beginAttempts==attempts); // The valid task bridges this handoff.
    [runtime advanceBy:.4]; CHECK(audio.playing && CSTestPlayerCreates==players+1);
    CHECK(fabs(NextDeadline()-entry-25)<.000001);
    Foreground(); NoResources();

    // A confirmed release just before a periodic check cannot wait for the old
    // debounce; the original periodic clock continues without a second player.
    Create(YES,20); Background(); entry=runtime.uptime; [runtime advanceBy:1.5];
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
    [runtime advanceBy:entry+24.8-runtime.uptime]; CHECK(!audio.playing);
    players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    [AVAudioSession.sharedInstance setActive:NO error:NULL]; Drain();
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
    [runtime advanceBy:entry+25-runtime.uptime];
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
    CHECK(manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);
    CHECK(fabs(NextDeadline()-entry-50)<.000001);
    Foreground(); NoResources();

    // An interruption suspends the pulse, not its finite task or normal clock.
    // Native activation may fail temporarily; a missing Ended cannot lock retries.
    Create(YES,20); AVAudioSession.sharedInstance.secondaryAudioShouldBeSilencedHint=YES;
    Background(); entry=runtime.uptime; [runtime advanceBy:1.5]; CHECK(audio.playing);
    second=runtime.tasks.lastObject; attempts=runtime.beginAttempts; players=CSTestPlayerCreates;
    AVAudioSession.sharedInstance.active=NO; Interrupt(YES,NO);
    CHECK(!audio.playing && !manager.backgroundAudioActive && manager.canAttemptBackgroundWork);
    CHECK(second.valid && second.endCalls==0 && runtime.liveTaskCount==1 && runtime.beginAttempts==attempts);
    CHECK(fabs(NextDeadline()-entry-25)<.000001);
    AVAudioSession.sharedInstance.failActivation=YES;
    [runtime advanceBy:23.5];
    CHECK(!audio.playing && CSTestPlayerCreates==players+1 && manager.canAttemptBackgroundWork);
    CHECK(runtime.beginAttempts==attempts && runtime.liveTaskCount==1);
    CHECK(fabs(NextDeadline()-entry-50)<.000001);
    AVAudioSession.sharedInstance.failActivation=NO;
    [runtime advanceBy:25];
    CHECK(audio.playing && CSTestPlayerCreates==players+2 && manager.backgroundAudioActive);
    CHECK(runtime.beginAttempts==attempts && runtime.liveTaskCount==1);
    Foreground(); NoResources();

    // Ended always requests one delayed recovery: with/without ShouldResume,
    // without options, and even when the matching Began was never observed.
    for (NSUInteger recovery=0;recovery<4;recovery++) {
        Create(YES,20); Background(); entry=runtime.uptime; [runtime advanceBy:1.5];
        CHECK(audio.playing); FinishPulse(); AVAudioSession.sharedInstance.active=NO;
        if (recovery!=3) Interrupt(YES,NO);
        if (recovery==2) {
            Post(AVAudioSessionInterruptionNotification,AVAudioSession.sharedInstance,
                @{AVAudioSessionInterruptionTypeKey:@(AVAudioSessionInterruptionTypeEnded)});
        } else Interrupt(NO,recovery==0);
        players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
        [runtime advanceBy:.39];
        CHECK(!audio.playing && CSTestPlayerCreates==players && runtime.beginAttempts==attempts);
        [runtime advanceBy:.01];
        CHECK(audio.playing && CSTestPlayerCreates==players+1 && manager.canAttemptBackgroundWork);
        CHECK(runtime.beginAttempts==attempts && runtime.liveTaskCount==1);
        CHECK(fabs(NextDeadline()-entry-25)<.000001);
        Foreground(); NoResources();
    }

    // A delivered Ended may reopen an expired cycle when a new execution
    // opportunity exists; the old lease stays ended and recovery still waits.
    Create(YES,20); Background(); [runtime advanceBy:1.5];
    AVAudioSession.sharedInstance.active=NO; Interrupt(YES,NO);
    second=runtime.tasks.lastObject; runtime.backgroundTimeRemaining=0;
    [second expire]; NoResources();
    runtime.backgroundTimeRemaining=20; Interrupt(NO,NO);
    CHECK(second.endCalls==1 && !second.valid && runtime.liveTaskCount==1 && manager.canAttemptBackgroundWork);
    players=CSTestPlayerCreates;
    [runtime advanceBy:.39]; CHECK(!audio.playing && CSTestPlayerCreates==players);
    [runtime advanceBy:.01]; CHECK(audio.playing && CSTestPlayerCreates==players+1);
    Foreground(); NoResources();

    // A reopened cycle retains its grace callback. Reuse requires the same
    // successful audio/task pair and finite budget beyond the next periodic
    // deadline plus 1s; task approval alone cannot stand in for extra budget.
    double graceBudgets[]={20,24.5,24.501,29};
    for (NSUInteger budget=0;budget<4;budget++) {
        entry=ReopenExpiredCycle(29);
        NSDate *originalFirst=manager.firstScheduledCheckAt;
        [runtime advanceBy:.4]; CHECK(audio.playing); FinishPulse();
        second=runtime.tasks.lastObject;
        players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
        runtime.backgroundTimeRemaining=graceBudgets[budget];
        [runtime advanceBy:1.1];
        BOOL reused=budget>=2;
        CHECK(CSTestPlayerCreates==players+(reused?0:1));
        CHECK(runtime.beginAttempts==attempts);
        CHECK(EventCount(@"资源复用")== (reused?1:0));
        CHECK(runtime.tasks.lastObject==second && second.valid);
        CHECK([manager.firstScheduledCheckAt isEqualToDate:originalFirst]);
        CHECK([manager.lastBackgroundCheckedAt isEqualToDate:runtime.currentDate] && !manager.periodicCheckCount);
        CHECK(fabs(NextDeadline()-entry-25)<.000001);
        if (reused) {
            [runtime advanceBy:23.5];
            CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
            CHECK(manager.periodicCheckCount==1 && EventCount(@"资源复用")==1);
        }
        Foreground(); NoResources();
    }

    // Independent failures and a threshold crossing preserve the nearby grace
    // retry. None of these recovery checks completed both resource requests.
    for (NSUInteger failure=0;failure<3;failure++) {
        entry=ReopenExpiredCycle(failure==2?31:29);
        CSTestFailPlayerPlay=failure==0; CSTestFailPlayerPreparation=failure==1;
        players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
        [runtime advanceBy:.4];
        CHECK(runtime.beginAttempts==attempts);
        CHECK(!audio.playing);
        if (audio.playing) FinishPulse();
        CSTestFailPlayerPlay=NO; CSTestFailPlayerPreparation=NO; runtime.backgroundTimeRemaining=29;
        players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
        [runtime advanceBy:1.1];
        CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
        CHECK(!EventCount(@"资源复用") && fabs(NextDeadline()-entry-25)<.000001);
        Foreground(); NoResources();
    }
    entry=ReopenExpiredCycle(29); [runtime advanceBy:.4]; CHECK(audio.playing);
    [runtime advanceBy:.2]; [CSTestLastPlayer finishSuccessfully:NO];
    CHECK(!audio.playing && manager.canAttemptBackgroundWork);
    players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    [runtime advanceBy:entry+1.5-runtime.uptime];
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
    CHECK(!EventCount(@"资源复用")); Foreground(); NoResources();

    // Interruption, media loss and native ownership changes revoke old reuse.
    // A later successful recovery may supply a fresh credential for grace.
    for (NSUInteger event=0;event<4;event++) {
        entry=ReopenExpiredCycle(29); [runtime advanceBy:.4]; FinishPulse();
        if (event==0) { AVAudioSession.sharedInstance.active=NO; Interrupt(YES,NO); }
        else if (event==1) Post(AVAudioSessionRouteChangeNotification,AVAudioSession.sharedInstance,nil);
        else if (event==2) {
            Post(AVAudioSessionMediaServicesWereLostNotification,AVAudioSession.sharedInstance,nil);
            Post(AVAudioSessionMediaServicesWereResetNotification,AVAudioSession.sharedInstance,nil);
        } else {
            [AVAudioSession.sharedInstance setMode:AVAudioSessionModeDefault error:NULL]; Drain();
        }
        if (event==1 || event==2) { [runtime advanceBy:.4]; CHECK(audio.playing); FinishPulse(); }
        if (event==3) CHECK(!audio.playing); // Cleanup is not a new release episode.
        players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
        [runtime advanceBy:entry+1.5-runtime.uptime];
        BOOL freshRecovery=event==1 || event==2;
        CHECK(audio.playing==!freshRecovery && CSTestPlayerCreates==players+(freshRecovery?0:1) && runtime.beginAttempts==attempts);
        CHECK(EventCount(@"资源复用")== (freshRecovery?1:0)); Foreground(); NoResources();
    }

    // Interval changes use the new explicit deadline when proving coverage.
    entry=ReopenExpiredCycle(29); [runtime advanceBy:.4]; FinishPulse();
    SetInterval(@30); players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    [runtime advanceBy:1.1];
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
    CHECK(!EventCount(@"资源复用") && fabs(NextDeadline()-entry-30.4)<.000001);
    Foreground(); NoResources();

    // A genuine first visit cannot reuse an early recovery as its first check.
    Create(YES,29); Background(); Interrupt(NO,NO); [runtime advanceBy:.4]; FinishPulse();
    CHECK(!manager.firstScheduledCheckAt);
    players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    [runtime advanceBy:1.1];
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
    CHECK(manager.firstScheduledCheckAt && !EventCount(@"资源复用")); Foreground(); NoResources();

    // A new observation invalidates a recovery even when the transitions occur
    // synchronously inside native activation before reconcile can release it.
    entry=ReopenExpiredCycle(29);
    AVAudioSession.sharedInstance.activationAction=^{
        AVAudioSession.sharedInstance.activationAction=nil; Foreground(); Background();
    };
    [runtime advanceBy:.4]; CHECK(audio.playing); FinishPulse();
    CHECK(!manager.firstScheduledCheckAt && !EventCount(@"资源复用"));
    players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    [runtime advanceBy:NextDeadline()-runtime.uptime];
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && runtime.beginAttempts==attempts);
    CHECK(manager.firstScheduledCheckAt && !EventCount(@"资源复用")); Foreground(); NoResources();

    // A foreground/background epoch cannot inherit a missing interruption end.
    Create(YES,20); Background(); [runtime advanceBy:1.5];
    AVAudioSession.sharedInstance.active=NO; Interrupt(YES,NO);
    Foreground(); NoResources(); Background();
    [runtime advanceBy:1.5]; CHECK(audio.playing && manager.canAttemptBackgroundWork);
    Foreground(); NoResources();

    // A media-server reset discards any old interruption, then recovers after
    // .4 seconds. No ShouldResume notification is needed to activate again.
    Create(YES,20); Background(); [runtime advanceBy:1.5];
    AVAudioSession.sharedInstance.active=NO; Interrupt(YES,NO);
    Post(AVAudioSessionMediaServicesWereLostNotification,AVAudioSession.sharedInstance,nil);
    CHECK(!audio.playing && manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);
    Post(AVAudioSessionMediaServicesWereResetNotification,AVAudioSession.sharedInstance,nil);
    players=CSTestPlayerCreates;
    [runtime advanceBy:.39]; CHECK(!audio.playing && CSTestPlayerCreates==players);
    [runtime advanceBy:.01]; CHECK(audio.playing && CSTestPlayerCreates==players+1);
    Foreground(); NoResources();

    // Unavailable media services block audio alone. Native task checks continue
    // until the OS expires the current lease, which remains a terminal boundary.
    Create(YES,20); Background(); entry=runtime.uptime; [runtime advanceBy:1.5];
    second=runtime.tasks.lastObject; attempts=runtime.beginAttempts; players=CSTestPlayerCreates;
    AVAudioSession.sharedInstance.active=NO;
    Post(AVAudioSessionMediaServicesWereLostNotification,AVAudioSession.sharedInstance,nil);
    CHECK(!audio.playing && second.valid && !second.endCalls && manager.canAttemptBackgroundWork);
    CHECK(fabs(NextDeadline()-entry-25)<.000001);
    [runtime advanceBy:23.5];
    CHECK(!audio.playing && CSTestPlayerCreates==players && manager.canAttemptBackgroundWork);
    CHECK(runtime.beginAttempts==attempts && runtime.liveTaskCount==1 && second.endCalls==0);
    [runtime.tasks.lastObject expire]; NoResources();
    Foreground(); NoResources();

    // Expiration of the current task cannot leak or resurrect it. An old
    // expiration and canceled timer remain harmless across a new epoch.
    Create(YES,60); Background(); first=runtime.tasks.firstObject;
    CSTestBackgroundCheck *stale=runtime.checks.lastObject;
    [first expire]; CHECK(first.endCalls==1 && !first.valid && !manager.canAttemptBackgroundWork);
    Foreground(); NoResources(); attempts=runtime.beginAttempts; players=CSTestPlayerCreates;
    [stale fireEvenIfCancelled]; [first expire];
    CHECK(runtime.beginAttempts==attempts && CSTestPlayerCreates==players); NoResources();
    Background(); stale=runtime.checks.lastObject; Enable(NO); NoResources(); Enable(YES);
    CHECK(runtime.liveTaskCount==1 && manager.canAttemptBackgroundWork && !audio.playing);
    attempts=runtime.beginAttempts; [stale fireEvenIfCancelled];
    CHECK(runtime.beginAttempts==attempts && runtime.liveTaskCount==1 && !audio.playing);
    Enable(NO); NoResources();

    // Native activation may synchronously expire the task or return to the
    // foreground. Completion cannot leave an orphaned player/session behind.
    Create(YES,20); Background(); first=runtime.tasks.firstObject;
    AVAudioSession.sharedInstance.activationAction=^{ [first expire]; };
    [runtime advanceBy:1.5];
    CHECK(first.endCalls==1);
    CHECK(AVAudioSession.sharedInstance.active==manager.backgroundAudioActive);
    if (audio.playing) CHECK(manager.canAttemptBackgroundWork);
    Foreground(); NoResources(); CHECK(!AVAudioSession.sharedInstance.active);
    Create(YES,20); Background();
    AVAudioSession.sharedInstance.activationAction=^{ Foreground(); };
    [runtime advanceBy:1.5]; NoResources(); CHECK(!AVAudioSession.sharedInstance.active);

    // Shared execution and the global work capability are distinct. Pulse
    // transitions update audio/display, while changing the global consumer alone
    // updates work without forcing display or audio consumers to refresh.
    Create(YES,20); [manager setGroupChatBackgroundRequested:YES];
    NSMutableArray<NSNumber *> *stateChanges=[NSMutableArray new];
    id stateObserver=ObserveStateChanges(stateChanges);
    Background();
    CHECK(stateChanges.count==1 && stateChanges.lastObject.unsignedIntegerValue==(CSBackgroundRunStateChangeWork|CSBackgroundRunStateChangeDisplay));
    [runtime advanceBy:1.5];
    CHECK(stateChanges.count==2 && stateChanges.lastObject.unsignedIntegerValue==(CSBackgroundRunStateChangeAudio|CSBackgroundRunStateChangeDisplay));
    CHECK(manager.canAttemptBackgroundWork && manager.backgroundAudioActive);
    FinishPulse();
    CHECK(stateChanges.count==3 && stateChanges.lastObject.unsignedIntegerValue==(CSBackgroundRunStateChangeAudio|CSBackgroundRunStateChangeDisplay));
    for (NSUInteger i=0;i<4;i++) [manager reloadSettings];
    CHECK(stateChanges.count==3);
    Enable(NO);
    CHECK(stateChanges.count==4 && stateChanges.lastObject.unsignedIntegerValue==CSBackgroundRunStateChangeWork);
    CHECK(!manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);
    [runtime advanceBy:23.5];
    CHECK(stateChanges.count==5 && stateChanges.lastObject.unsignedIntegerValue==(CSBackgroundRunStateChangeAudio|CSBackgroundRunStateChangeDisplay));
    CHECK(!manager.canAttemptBackgroundWork && manager.backgroundAudioActive);
    Enable(YES);
    CHECK(stateChanges.count==6 && stateChanges.lastObject.unsignedIntegerValue==CSBackgroundRunStateChangeWork);
    Foreground(); NoResources();
    CHECK(stateChanges.count==7 && stateChanges.lastObject.unsignedIntegerValue==(CSBackgroundRunStateChangeWork|CSBackgroundRunStateChangeAudio|CSBackgroundRunStateChangeDisplay));
    Foreground(); [manager reloadSettings]; CHECK(stateChanges.count==7);
    [NSNotificationCenter.defaultCenter removeObserver:stateObserver];

    // Timestamp-only checks stay silent. A service status can change display
    // while the native task keeps work available; actual expiration changes work
    // even though the enabled setting itself never changed.
    Create(YES,120); [stateChanges removeAllObjects];
    stateObserver=ObserveStateChanges(stateChanges);
    Background(); CHECK(stateChanges.count==1);
    NSDate *beforeTimestampCheck=manager.lastBackgroundCheckedAt;
    [runtime advanceBy:1.5];
    CHECK(stateChanges.count==1 && ![manager.lastBackgroundCheckedAt isEqualToDate:beforeTimestampCheck]);
    [runtime advanceBy:23.5]; CHECK(stateChanges.count==1);
    Post(AVAudioSessionMediaServicesWereLostNotification,AVAudioSession.sharedInstance,nil);
    CHECK(stateChanges.count==2 && stateChanges.lastObject.unsignedIntegerValue==CSBackgroundRunStateChangeDisplay);
    CHECK(manager.canAttemptBackgroundWork && !manager.backgroundAudioActive);
    Post(AVAudioSessionMediaServicesWereLostNotification,AVAudioSession.sharedInstance,nil);
    CHECK(stateChanges.count==2);
    Post(AVAudioSessionMediaServicesWereResetNotification,AVAudioSession.sharedInstance,nil);
    CHECK(stateChanges.count==3 && stateChanges.lastObject.unsignedIntegerValue==CSBackgroundRunStateChangeDisplay);
    [runtime advanceBy:.4]; CHECK(stateChanges.count==3);
    CHECK([manager.lastBackgroundCheckedAt isEqualToDate:runtime.currentDate]);
    second=runtime.tasks.lastObject; [second expire];
    CHECK(manager.enabled && !manager.canAttemptBackgroundWork);
    CHECK(stateChanges.count==4 && stateChanges.lastObject.unsignedIntegerValue==(CSBackgroundRunStateChangeWork|CSBackgroundRunStateChangeDisplay));
    [second expire]; [manager reloadSettings]; CHECK(stateChanges.count==4);
    Foreground(); NoResources();
    CHECK(stateChanges.count==5 && stateChanges.lastObject.unsignedIntegerValue==CSBackgroundRunStateChangeDisplay);
    [NSNotificationCenter.defaultCenter removeObserver:stateObserver];

    // A host release while all demand is off does not need a notification.
    // Re-enabling in the background must read current ownership, clearing the
    // earlier yielded state before its grace check attempts playback.
    Create(YES,20); Background(); [runtime advanceBy:1.5];
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
    CHECK(!audio.playing && audio.hostBusy && manager.canAttemptBackgroundWork);
    Enable(NO); NoResources();
    [AVAudioSession.sharedInstance setActive:NO error:NULL]; Drain();
    CHECK(!audio.hostBusy);
    Enable(YES); CHECK(manager.canAttemptBackgroundWork && !audio.playing);
    [runtime advanceBy:1.5]; CHECK(audio.playing && manager.backgroundAudioActive);
    Foreground(); NoResources();

    // State consumers can disable or replace demand during publication. They
    // must not create parallel tasks or let the old cycle regain ownership.
    Create(YES,20); __block BOOL acted=NO;
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note) {
        if (!acted && ((CSBackgroundRunManager *)note.object).canAttemptBackgroundWork) { acted=YES; Enable(NO); }
    }];
    Background(); CHECK(acted); NoResources(); [NSNotificationCenter.defaultCenter removeObserver:observer];
    Create(YES,20); acted=NO;
    observer=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note) {
        if (!acted && ((CSBackgroundRunManager *)note.object).canAttemptBackgroundWork) { acted=YES; Enable(NO); Enable(YES); }
    }];
    Background(); CHECK(acted && manager.canAttemptBackgroundWork && runtime.liveTaskCount==1 && !audio.playing);
    [NSNotificationCenter.defaultCenter removeObserver:observer]; Foreground(); NoResources();

    // Any foreground scene wins, including an inactive one. A stale scene
    // background event cannot reacquire execution while another scene is visible.
    Create(YES,20);
    UIScene *one=[UIScene new], *two=[UIScene new];
    one.activationState=UISceneActivationStateBackground; two.activationState=UISceneActivationStateForegroundInactive;
    UIApplication.sharedApplication.connectedScenes=[NSSet setWithObjects:one,two,nil];
    Post(UISceneDidEnterBackgroundNotification,one,nil); NoResources();
    two.activationState=UISceneActivationStateBackground; Post(UISceneDidEnterBackgroundNotification,two,nil);
    CHECK(runtime.liveTaskCount==1 && !audio.playing && manager.canAttemptBackgroundWork);
    [runtime advanceBy:1.5]; CHECK(audio.playing);
    one.activationState=UISceneActivationStateForegroundInactive; Post(UISceneWillEnterForegroundNotification,one,nil); NoResources();
    Post(UISceneDidEnterBackgroundNotification,one,nil); NoResources();

    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil; runtime=nil;
    Drain(); CHECK(!CSTestPlayersAlive);
    [defaults removePersistentDomainForName:suite];
    printf("Background hybrid: %lu checks passed; delayed pulses, configurable cadence, native ownership and lifecycle races verified\n",(unsigned long)checks);
} return 0; }
