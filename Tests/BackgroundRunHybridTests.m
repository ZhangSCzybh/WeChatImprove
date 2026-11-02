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
    // Isolate observer lifetime across fixtures sharing this defaults suite.
    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.activationAction=nil; CSTestFailPlayerCreation=CSTestFailPlayerPlay=NO;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    UIApplication.sharedApplication.connectedScenes=[NSSet set];
    [defaults setBool:YES forKey:CSBackgroundRunEnabledKey];
    audio=[CSBackgroundRunAudio new]; runtime=[CSTestBackgroundRuntime new]; runtime.backgroundTimeRemaining=remaining;
    manager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:supported runtime:runtime];
    [manager start];
}
static void NoResources(void) {
    CHECK(!audio.playing && !manager.backgroundAudioActive && !manager.canAttemptBackgroundWork);
    CHECK(!runtime.liveTaskCount && !runtime.pendingCheckCount);
}

int main(void) { @autoreleasepool {
    NSString *suite=[@"background-hybrid-tests-" stringByAppendingString:NSUUID.UUID.UUIDString];
    defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];

    // A finite UIKit task is useful execution without opening an audio session.
    Create(YES,30); Background();
    CHECK(manager.canAttemptBackgroundWork && !manager.backgroundAudioActive && !audio.playing);
    CHECK(runtime.beginAttempts==1 && runtime.liveTaskCount==1 && runtime.pendingCheckCount==1);
    CHECK(runtime.checks.lastObject.deadline-runtime.uptime>1);
    NSUInteger players=CSTestPlayerCreates;
    for (NSUInteger i=0;i<20;i++) { Background(); Post(NSUserDefaultsDidChangeNotification,nil,nil); }
    CHECK(runtime.beginAttempts==1 && CSTestPlayerCreates==players && runtime.pendingCheckCount==1);
    [runtime advanceBy:22];
    CHECK(!audio.playing && manager.canAttemptBackgroundWork && runtime.backgroundTimeRemaining==8);
    [runtime advanceBy:1];
    CHECK(audio.playing && manager.backgroundAudioActive && manager.canAttemptBackgroundWork);
    CHECK(runtime.maximumPendingChecks==1);
    Foreground(); NoResources();

    // Runtime rotation is wall-clock based. Acquire first, then release the old
    // task, and ignore that old task's late expiration callback.
    Create(YES,120); Background();
    CSTestBackgroundTask *first=runtime.tasks.firstObject;
    [runtime advanceBy:25]; CHECK(runtime.beginAttempts==1 && first.valid);
    [runtime advanceBy:1]; CHECK(runtime.beginAttempts==2 && !first.valid && first.endCalls==1);
    CHECK(runtime.liveTaskCount==1 && !audio.playing);
    CHECK([runtime.events indexOfObject:@"begin:2"]<[runtime.events indexOfObject:@"end:1"]);
    CSTestBackgroundTask *second=runtime.tasks.lastObject;
    [first expire]; CHECK(second.valid && manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);
    Foreground(); CHECK(second.endCalls==1); NoResources();

    // A failed replacement leaves the previous task intact and never retries
    // every second or at each subsequent rotation node in this background epoch.
    Create(YES,120); Background(); first=runtime.tasks.firstObject; runtime.failBegin=YES;
    [runtime advanceBy:26]; CHECK(runtime.beginAttempts==2 && first.valid && first.endCalls==0);
    [runtime advanceBy:60]; CHECK(runtime.beginAttempts==2 && runtime.liveTaskCount==1);
    Foreground(); NoResources();

    // Returning to finite-task mode needs a stable budget and the minimum audio
    // tenure. High readings inside the first five seconds cannot stop it, and
    // after that two observations separated by one second are sufficient.
    Create(YES,7); runtime.decrementsBudget=NO; Background(); CHECK(audio.playing);
    runtime.backgroundTimeRemaining=12;
    [runtime advanceBy:4]; CHECK(audio.playing);
    [runtime advanceBy:1]; CHECK(audio.playing);
    [runtime advanceBy:1]; CHECK(!audio.playing && manager.canAttemptBackgroundWork && !manager.backgroundAudioActive);
    CHECK(runtime.liveTaskCount==1);
    Foreground(); NoResources();

    // Same-instant notification bursts cannot manufacture two independent
    // recovery observations; the exit threshold includes exactly twelve seconds.
    Create(YES,7); runtime.decrementsBudget=NO; Background(); [runtime advanceBy:5];
    runtime.backgroundTimeRemaining=12; Post(NSUserDefaultsDidChangeNotification,nil,nil);
    for (NSUInteger i=0;i<50;i++) Post(NSUserDefaultsDidChangeNotification,nil,nil);
    CHECK(audio.playing);
    [runtime advanceBy:.5]; CHECK(audio.playing);
    [runtime advanceBy:.5]; CHECK(!audio.playing && manager.canAttemptBackgroundWork);
    Foreground(); NoResources();

    // An unbounded reading before the minimum tenure must still schedule the
    // five-second decision point. A silent budget change can then recover there.
    Create(YES,7); runtime.decrementsBudget=NO; Background();
    runtime.backgroundTimeRemaining=DBL_MAX; [runtime advanceBy:1];
    CHECK(audio.playing && fabs(runtime.checks.lastObject.deadline-runtime.uptime-4)<.000001);
    [runtime advanceBy:2]; runtime.backgroundTimeRemaining=12; // No settings/audio notification.
    [runtime advanceBy:2];
    CHECK(audio.playing && [manager.lastBackgroundCheckedAt isEqualToDate:runtime.currentDate]);
    [runtime advanceBy:1]; CHECK(!audio.playing && manager.canAttemptBackgroundWork);
    CHECK(runtime.maximumPendingChecks==1);
    Foreground(); NoResources();

    // If the reading stays unbounded, the minimum-tenure decision is one check;
    // it must not turn into permanent one-second polling or parallel timers.
    Create(YES,7); runtime.decrementsBudget=NO; Background();
    runtime.backgroundTimeRemaining=DBL_MAX; [runtime advanceBy:5];
    NSUInteger scheduledAtMinimum=runtime.checks.count;
    NSDate *checkedAtMinimum=manager.lastBackgroundCheckedAt;
    CHECK(audio.playing && runtime.pendingCheckCount==1 && runtime.maximumPendingChecks==1);
    [runtime advanceBy:4];
    CHECK(audio.playing && runtime.checks.count==scheduledAtMinimum && [manager.lastBackgroundCheckedAt isEqualToDate:checkedAtMinimum]);
    CHECK(runtime.checks.lastObject.deadline-runtime.uptime>1 && runtime.pendingCheckCount==1);
    Foreground(); NoResources();

    // In the hysteresis band, keep the current strategy. After native recovery,
    // a budget of exactly eight seconds still does not reacquire audio.
    Create(YES,7); runtime.decrementsBudget=NO; Background(); [runtime advanceBy:5];
    players=CSTestPlayerCreates;
    const NSTimeInterval band[]={8,10,11.999};
    for (NSUInteger i=0;i<3;i++) {
        runtime.backgroundTimeRemaining=band[i]; Post(NSUserDefaultsDidChangeNotification,nil,nil); [runtime advanceBy:1];
        CHECK(audio.playing && CSTestPlayerCreates==players);
    }
    runtime.backgroundTimeRemaining=12; Post(NSUserDefaultsDidChangeNotification,nil,nil); [runtime advanceBy:1];
    CHECK(!audio.playing && manager.canAttemptBackgroundWork);
    for (NSUInteger i=0;i<3;i++) {
        runtime.backgroundTimeRemaining=band[2-i]; Post(NSUserDefaultsDidChangeNotification,nil,nil); [runtime advanceBy:1];
        CHECK(!audio.playing && CSTestPlayerCreates==players && manager.canAttemptBackgroundWork);
    }
    runtime.backgroundTimeRemaining=7.999; Post(NSUserDefaultsDidChangeNotification,nil,nil);
    CHECK(audio.playing && CSTestPlayerCreates==players+1);
    Foreground(); NoResources();

    // Unbounded/invalid values while audio is playing cannot prove that a fresh
    // finite UIKit budget exists. They reset any partial recovery observation.
    for (NSUInteger special=0;special<5;special++) {
        Create(YES,7); runtime.decrementsBudget=NO; Background(); [runtime advanceBy:5];
        runtime.backgroundTimeRemaining=12; Post(NSUserDefaultsDidChangeNotification,nil,nil); CHECK(audio.playing);
        const NSTimeInterval values[]={DBL_MAX,NAN,-1,INFINITY,1e13};
        runtime.backgroundTimeRemaining=values[special];
        Post(NSUserDefaultsDidChangeNotification,nil,nil);
        [runtime advanceBy:2]; CHECK(audio.playing && manager.canAttemptBackgroundWork);
        runtime.backgroundTimeRemaining=12; Post(NSUserDefaultsDidChangeNotification,nil,nil); [runtime advanceBy:.5]; CHECK(audio.playing);
        [runtime advanceBy:.5]; CHECK(!audio.playing && manager.canAttemptBackgroundWork);
        Foreground(); NoResources();
    }
    Create(YES,7); runtime.decrementsBudget=NO; Background(); runtime.backgroundTimeRemaining=DBL_MAX;
    players=CSTestPlayerCreates; [runtime advanceBy:120];
    CHECK(audio.playing && CSTestPlayerCreates==players && runtime.maximumPendingChecks==1);
    Foreground(); NoResources();

    // At the cleanup boundary no audio capability, playback failure, or native
    // audio ownership must turn into an endless task/timer retry loop.
    Create(NO,4); Background(); NoResources();
    Create(YES,4); CSTestFailPlayerPlay=YES; Background(); NoResources();
    players=CSTestPlayerCreates; NSUInteger attempts=runtime.beginAttempts;
    [runtime advanceBy:120]; Post(NSUserDefaultsDidChangeNotification,nil,nil); Background();
    CHECK(CSTestPlayerCreates==players && runtime.beginAttempts==attempts); NoResources();
    Create(YES,7); CSTestFailPlayerPlay=YES; Background();
    CHECK(!audio.playing && manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);
    players=CSTestPlayerCreates; [runtime advanceBy:1];
    CHECK(CSTestPlayerCreates==players && manager.canAttemptBackgroundWork);
    [runtime advanceBy:2]; CHECK(CSTestPlayerCreates==players && runtime.beginAttempts==1); NoResources();
    Create(YES,4);
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
    Background(); NoResources(); CHECK(AVAudioSession.sharedInstance.active);

    Create(YES,30); Background();
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
    CHECK(!audio.playing && manager.canAttemptBackgroundWork && runtime.liveTaskCount==1);
    NSUInteger deactivations=AVAudioSession.sharedInstance.deactivations;
    runtime.backgroundTimeRemaining=4; Post(NSUserDefaultsDidChangeNotification,nil,nil); NoResources();
    CHECK(AVAudioSession.sharedInstance.active && AVAudioSession.sharedInstance.deactivations==deactivations);

    // Initial begin failure can fall back once to audio, and its failure gets no
    // timer-driven retry. Explicit foreground/background is a new opportunity.
    Create(YES,30); runtime.failBegin=YES; Background(); CHECK(audio.playing && manager.canAttemptBackgroundWork);
    CHECK(!runtime.liveTaskCount && runtime.beginAttempts==1);
    Foreground(); NoResources();
    Create(YES,30); runtime.failBegin=YES; CSTestFailPlayerPlay=YES; Background(); NoResources();
    players=CSTestPlayerCreates; [runtime advanceBy:120]; CHECK(CSTestPlayerCreates==players && runtime.beginAttempts==1);
    CSTestFailPlayerPlay=NO; Foreground(); Background(); CHECK(audio.playing);
    Foreground(); NoResources();

    // Expiry ends precisely its own task. Healthy audio can continue, while a
    // task-only epoch closes without beginning a new UIKit assertion.
    Create(YES,30); Background(); first=runtime.tasks.firstObject; [first expire];
    CHECK(first.endCalls==1 && runtime.beginAttempts==1); NoResources();
    Create(YES,7); runtime.decrementsBudget=NO; Background(); first=runtime.tasks.firstObject;
    [first expire]; CHECK(first.endCalls==1 && audio.playing && manager.canAttemptBackgroundWork);
    attempts=runtime.beginAttempts; [runtime advanceBy:60]; CHECK(runtime.beginAttempts==attempts && audio.playing);
    Foreground(); NoResources();

    // Capability changes are published, so AI consumers can follow task-only
    // execution and the eventual stop without depending on the audio bit.
    Create(YES,30);
    NSMutableArray<NSNumber *> *capabilities=[NSMutableArray new];
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note) {
        [capabilities addObject:@(((CSBackgroundRunManager *)note.object).canAttemptBackgroundWork)];
    }];
    Background(); CHECK([capabilities containsObject:@YES] && !manager.backgroundAudioActive);
    [runtime.tasks.firstObject expire]; CHECK([capabilities.lastObject isEqual:@NO]); NoResources();
    [NSNotificationCenter.defaultCenter removeObserver:observer];

    // UIKit expiration can arrive synchronously inside native activation. The
    // resulting state must either own healthy audio or fully release that audio;
    // an apparently stopped manager must never leave its session active.
    Create(YES,7);
    AVAudioSession.sharedInstance.activationAction=^{ [runtime.tasks.firstObject expire]; };
    Background(); CHECK(AVAudioSession.sharedInstance.active==manager.backgroundAudioActive);
    CHECK(runtime.tasks.firstObject.endCalls==1 && runtime.beginAttempts==1 && !runtime.liveTaskCount);
    if (audio.playing) {
        CHECK(manager.backgroundAudioActive && manager.canAttemptBackgroundWork && runtime.pendingCheckCount==1);
    } else NoResources();
    Foreground(); NoResources(); CHECK(!AVAudioSession.sharedInstance.active);

    Create(YES,7); AVAudioSession.sharedInstance.activationAction=^{ Foreground(); };
    Background(); NoResources(); CHECK(!AVAudioSession.sharedInstance.active);

    // Consumers may update settings from the state notification itself. These
    // callbacks cannot resurrect a disabled cycle or create parallel resources.
    Create(YES,30); __block BOOL acted=NO;
    observer=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note) {
        if (!acted && ((CSBackgroundRunManager *)note.object).canAttemptBackgroundWork) { acted=YES; Enable(NO); }
    }];
    Background(); CHECK(acted); NoResources();
    [NSNotificationCenter.defaultCenter removeObserver:observer];
    Create(YES,30); acted=NO;
    observer=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note) {
        if (!acted && ((CSBackgroundRunManager *)note.object).canAttemptBackgroundWork) { acted=YES; Enable(NO); Enable(YES); }
    }];
    Background(); CHECK(acted && manager.canAttemptBackgroundWork && runtime.liveTaskCount==1 && runtime.pendingCheckCount==1);
    [NSNotificationCenter.defaultCenter removeObserver:observer]; Foreground(); NoResources();

    // Cancellation is authoritative even if an already queued timer is delivered
    // after the foreground transition or after a disable/enable cycle.
    Create(YES,30); Background(); CSTestBackgroundCheck *stale=runtime.checks.lastObject;
    Foreground(); NoResources(); attempts=runtime.beginAttempts; players=CSTestPlayerCreates;
    [stale fireEvenIfCancelled]; CHECK(runtime.beginAttempts==attempts && CSTestPlayerCreates==players); NoResources();
    Background(); stale=runtime.checks.lastObject; Enable(NO); NoResources(); Enable(YES);
    CHECK(runtime.liveTaskCount==1 && manager.canAttemptBackgroundWork);
    attempts=runtime.beginAttempts; [stale fireEvenIfCancelled]; CHECK(runtime.beginAttempts==attempts && runtime.liveTaskCount==1 && runtime.pendingCheckCount==1);
    Enable(NO); NoResources();

    // Any foreground scene wins, including an inactive one; stale scene events
    // neither reacquire tasks nor resume audio.
    Create(YES,30);
    UIScene *one=[UIScene new], *two=[UIScene new];
    one.activationState=UISceneActivationStateBackground; two.activationState=UISceneActivationStateForegroundInactive;
    UIApplication.sharedApplication.connectedScenes=[NSSet setWithObjects:one,two,nil];
    Post(UISceneDidEnterBackgroundNotification,one,nil); NoResources();
    two.activationState=UISceneActivationStateBackground; Post(UISceneDidEnterBackgroundNotification,two,nil);
    CHECK(runtime.liveTaskCount==1 && !audio.playing && manager.canAttemptBackgroundWork);
    one.activationState=UISceneActivationStateForegroundInactive; Post(UISceneWillEnterForegroundNotification,one,nil); NoResources();
    Post(UISceneDidEnterBackgroundNotification,one,nil); NoResources();

    Enable(NO); manager=nil; [audio stop]; audio=nil; runtime=nil; Drain(); CHECK(!CSTestPlayersAlive);
    [defaults removePersistentDomainForName:suite];
    printf("Background hybrid: %lu checks passed; deterministic budgets, lifecycle, audio handoff and expiration verified\n",(unsigned long)checks);
} return 0; }
