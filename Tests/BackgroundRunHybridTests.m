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
        if (!check.cancelled && !check.fired) next=MIN(next,check.deadline);
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
    CHECK(runtime.beginAttempts==2 && runtime.liveTaskCount==1 && first.endCalls==1);
    CHECK([runtime.events indexOfObject:@"begin:2"]<[runtime.events indexOfObject:@"end:1"]);
    CHECK([CSTestLastPlayerURL.path isEqual:@"/host/WeChat.app/blank.caf"]);
    CHECK(CSTestLastPlayer.numberOfLoops==0 && CSTestLastPlayer.volume==0);
    CHECK(fabs(NextDeadline()-entry-25)<.000001);
    CSTestBackgroundTask *second=runtime.tasks.lastObject;
    [first expire]; CHECK(second.valid && second.endCalls==0 && manager.canAttemptBackgroundWork);
    FinishPulse();
    CHECK(!audio.playing && !manager.backgroundAudioActive && manager.canAttemptBackgroundWork && second.valid);
    players=CSTestPlayerCreates; NSUInteger attempts=runtime.beginAttempts;
    NSDate *pulseCheck=manager.lastBackgroundCheckedAt;
    for (NSUInteger i=0;i<20;i++) { Background(); Post(NSUserDefaultsDidChangeNotification,nil,nil); }
    CHECK(CSTestPlayerCreates==players && runtime.beginAttempts==attempts && [manager.lastBackgroundCheckedAt isEqualToDate:pulseCheck]);
    [runtime advanceBy:23.49]; CHECK(!audio.playing && runtime.beginAttempts==attempts);
    [runtime advanceBy:.01]; CHECK(audio.playing && runtime.beginAttempts==attempts+1);
    CHECK(fabs(NextDeadline()-entry-50)<.000001);
    Foreground(); NoResources(); CHECK(!AVAudioSession.sharedInstance.active);

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
        [runtime advanceBy:expected[i]-1.5]; CHECK(audio.playing && runtime.beginAttempts==3);
        Foreground(); NoResources();
    }

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

    // Audio/resource failures still permit native task renewal at the check.
    // Fixing the resource cannot cause an immediate audio or renewal retry.
    for (NSUInteger failure=0;failure<3;failure++) {
        Create(failure!=2,20); Background(); first=runtime.tasks.firstObject;
        CSTestBlankResourceAvailable=failure!=0; CSTestFailPlayerPlay=failure==1;
        [runtime advanceBy:1.5];
        CHECK(!audio.playing && first.endCalls==1 && runtime.liveTaskCount==1 && manager.canAttemptBackgroundWork);
        CHECK(runtime.beginAttempts==2 && runtime.tasks.lastObject.valid);
        players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
        CSTestBlankResourceAvailable=YES; CSTestFailPlayerPlay=NO;
        for (NSUInteger i=0;i<10;i++) Post(NSUserDefaultsDidChangeNotification,nil,nil);
        [runtime advanceBy:23.49];
        CHECK(!audio.playing && CSTestPlayerCreates==players && runtime.beginAttempts==attempts);
        [runtime advanceBy:.01];
        CHECK(audio.playing==(failure!=2));
        Foreground(); NoResources();
    }

    // Renewal failure never releases the previous valid assertion. A later
    // scheduled check may retry successfully; no historical rotation latch.
    Create(YES,20); Background(); first=runtime.tasks.firstObject; runtime.failBegin=YES;
    [runtime advanceBy:1.5];
    CHECK(audio.playing && runtime.beginAttempts==2 && first.valid && first.endCalls==0 && runtime.liveTaskCount==1);
    FinishPulse(); CHECK(manager.canAttemptBackgroundWork && !manager.backgroundAudioActive);
    runtime.failBegin=NO; attempts=runtime.beginAttempts;
    [manager reloadSettings]; CHECK(runtime.beginAttempts==attempts);
    [runtime advanceBy:23.5];
    CHECK(audio.playing && runtime.beginAttempts==attempts+1 && first.endCalls==1 && runtime.liveTaskCount==1);
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

    // The actual hook transfers audio ownership to native calls synchronously.
    // A release is debounced for .4 seconds without postponing periodic checks.
    Create(YES,20); Background(); entry=runtime.uptime; [runtime advanceBy:1.5];
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
    CHECK(!audio.playing && !manager.backgroundAudioActive && manager.canAttemptBackgroundWork);
    NSUInteger deactivations=AVAudioSession.sharedInstance.deactivations;
    CHECK(AVAudioSession.sharedInstance.active);
    [runtime advanceBy:1]; CHECK(!audio.playing && AVAudioSession.sharedInstance.deactivations==deactivations);
    [AVAudioSession.sharedInstance setActive:NO error:NULL]; Drain();
    players=CSTestPlayerCreates;
    [runtime advanceBy:.39]; CHECK(!audio.playing && CSTestPlayerCreates==players);
    [runtime advanceBy:.01]; CHECK(audio.playing && manager.canAttemptBackgroundWork);
    CHECK(fabs(NextDeadline()-entry-25)<.000001);
    Foreground(); NoResources();

    // A periodic check inside the host-release debounce may renew its task,
    // but audio must wait for the full .4 seconds without shifting the cadence.
    Create(YES,20); Background(); entry=runtime.uptime; [runtime advanceBy:1.5];
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
    [runtime advanceBy:entry+24.8-runtime.uptime]; CHECK(!audio.playing);
    [AVAudioSession.sharedInstance setActive:NO error:NULL]; Drain();
    players=CSTestPlayerCreates; attempts=runtime.beginAttempts;
    [runtime advanceBy:entry+25-runtime.uptime];
    CHECK(!audio.playing && CSTestPlayerCreates==players && runtime.beginAttempts==attempts+1);
    CHECK(manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);
    CHECK(fabs(NextDeadline()-entry-25.2)<.000001);
    [runtime advanceBy:.19]; CHECK(!audio.playing && CSTestPlayerCreates==players);
    [runtime advanceBy:NextDeadline()-runtime.uptime];
    CHECK(audio.playing && CSTestPlayerCreates==players+1 && fabs(runtime.uptime-entry-25.2)<.000001);
    CHECK(fabs(NextDeadline()-entry-50)<.000001);
    Foreground(); NoResources();

    // iOS interruption resumes only with ShouldResume, after the same delay.
    // A withheld permission continues to block both grace and periodic work.
    Create(YES,20); Background(); [runtime advanceBy:1.5];
    AVAudioSession.sharedInstance.active=NO; Interrupt(YES,NO);
    CHECK(!audio.playing && !manager.backgroundAudioActive && manager.canAttemptBackgroundWork);
    Interrupt(NO,YES); players=CSTestPlayerCreates;
    [runtime advanceBy:.39]; CHECK(CSTestPlayerCreates==players && !audio.playing);
    [runtime advanceBy:.01]; CHECK(audio.playing);
    AVAudioSession.sharedInstance.active=NO; Interrupt(YES,NO); Interrupt(NO,NO);
    players=CSTestPlayerCreates; [runtime advanceBy:50];
    CHECK(!audio.playing && CSTestPlayerCreates==players && manager.canAttemptBackgroundWork);
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
