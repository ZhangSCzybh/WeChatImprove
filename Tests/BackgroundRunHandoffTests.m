#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <float.h>
#import <math.h>
#import "CSBackgroundRunManager.h"
#import "BackgroundRunFakeRuntime.h"

static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"HANDOFF FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)

// A bridge grant may change UIKit's budget. Keep that system response separate
// from the manager so tests can distinguish a valid identifier from usable time.
@interface CSHandoffBudgetRuntime : CSTestBackgroundRuntime
@property(nonatomic) BOOL adjustNextBegin;
@property(nonatomic) NSTimeInterval budgetAfterBegin;
@end
@implementation CSHandoffBudgetRuntime
- (id<CSBackgroundRunTask>)beginTaskWithExpirationHandler:(void (^)(id<CSBackgroundRunTask>))handler {
    id<CSBackgroundRunTask> task=[super beginTaskWithExpirationHandler:handler];
    if (self.adjustNextBegin) { self.adjustNextBegin=NO; self.backgroundTimeRemaining=self.budgetAfterBegin; }
    return task;
}
@end

static NSUserDefaults *defaults;
static CSBackgroundRunManager *manager;
static CSBackgroundRunAudio *audio;
static CSHandoffBudgetRuntime *runtime;
static NSDictionary *lastHostInfo;
static void Drain(void) { for (NSUInteger i=0;i<4;i++) [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.001]]; }
static void Post(NSString *name,NSDictionary *info) { [NSNotificationCenter.defaultCenter postNotificationName:name object:nil userInfo:info]; }
static void Enable(BOOL enabled) { [defaults setBool:enabled forKey:CSBackgroundRunEnabledKey]; [manager reloadSettings]; }
static void Foreground(void) {
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    Post(UIApplicationWillEnterForegroundNotification,nil);
    Post(UIApplicationDidBecomeActiveNotification,nil);
}
static void Background(void) {
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    Post(UIApplicationDidEnterBackgroundNotification,nil);
}
static void HostBegin(void) {
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
}
static void HostRelease(void) { [AVAudioSession.sharedInstance setActive:NO error:NULL]; Drain(); }
static void FinishPulse(void) { CHECK(CSTestLastPlayer!=nil); [CSTestLastPlayer finishSuccessfully:YES]; }
static NSUInteger EventCount(NSString *source) {
    NSUInteger count=0;
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents)
        if ([event.source isEqual:source]) count++;
    return count;
}
static void Create(NSTimeInterval remaining) {
    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil;
    [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.failDeactivationWithBusy=NO; session.activationAction=nil;
    session.secondaryAudioShouldBeSilencedHint=NO;
    CSTestFailPlayerCreation=CSTestFailPlayerPreparation=CSTestFailPlayerPlay=NO;
    CSTestBlankResourceAvailable=YES;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    UIApplication.sharedApplication.connectedScenes=[NSSet set];
    [defaults setBool:YES forKey:CSBackgroundRunEnabledKey];
    [defaults removeObjectForKey:CSBackgroundRunCheckIntervalKey];
    audio=[CSBackgroundRunAudio new]; runtime=[CSHandoffBudgetRuntime new];
    runtime.backgroundTimeRemaining=remaining; runtime.decrementsBudget=NO;
    manager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:YES runtime:runtime];
    [manager start]; lastHostInfo=nil;
}

int main(void) { @autoreleasepool {
    CSTestInstallBlankBundle();
    NSString *suite=[@"background-handoff-tests-" stringByAppendingString:NSUUID.UUID.UUIDString];
    defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    id hostObserver=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunHostAudioChangedNotification object:nil queue:nil usingBlock:^(NSNotification *note) { lastHostInfo=[note.userInfo copy]; }];

    // A real release between periodic checks reuses the existing task and starts
    // within the notification delivery, including budgets above the old 30s gate.
    const NSTimeInterval handoffBudgets[]={20,30,120,DBL_MAX,INFINITY};
    for (NSUInteger index=0;index<sizeof(handoffBudgets)/sizeof(*handoffBudgets);index++) {
        Create(handoffBudgets[index]); HostBegin(); Background();
        [runtime advanceBy:12]; CHECK(!audio.playing && audio.hostBusy);
        NSUInteger starts=CSTestPlayerStarts, attempts=runtime.beginAttempts;
        NSTimeInterval releasedAt=runtime.uptime;
        HostRelease();
        CHECK(audio.playing && manager.backgroundAudioActive && manager.canAttemptBackgroundWork);
        CHECK(CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
        CHECK(runtime.uptime==releasedAt && manager.periodicCheckCount==0);
        CHECK([lastHostInfo[@"releaseConfirmed"] boolValue] && [lastHostInfo[@"releaseEpisode"] unsignedLongLongValue]>0);
        Foreground(); CHECK(!audio.playing && !runtime.liveTaskCount && !runtime.pendingCheckCount);
    }

    // The last fraction of the lease must not be spent waiting 0.4s. An old
    // task expiration after a successful handoff cannot erase the active audio.
    Create(20); HostBegin(); Background(); [runtime advanceBy:26.4];
    runtime.backgroundTimeRemaining=.2;
    NSUInteger starts=CSTestPlayerStarts, attempts=runtime.beginAttempts;
    CSTestBackgroundTask *oldTask=runtime.tasks.lastObject;
    HostRelease(); CHECK(audio.playing && CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    [oldTask expire]; CHECK(audio.playing && manager.backgroundAudioActive);
    CHECK(runtime.beginAttempts==attempts && EventCount(@"系统到期")==1);
    Foreground();

    // Finite expiration is not an audio trigger. The subsequent genuine host
    // release provides a new opportunity and receives just one bridging task.
    Create(20); HostBegin(); Background(); [runtime advanceBy:2];
    oldTask=runtime.tasks.lastObject; attempts=runtime.beginAttempts; starts=CSTestPlayerStarts;
    [oldTask expire];
    CHECK(!audio.playing && !runtime.liveTaskCount && !runtime.pendingCheckCount);
    [runtime advanceBy:60];
    CHECK(runtime.beginAttempts==attempts && CSTestPlayerStarts==starts);
    runtime.backgroundTimeRemaining=20; HostRelease();
    CHECK(audio.playing && runtime.beginAttempts==attempts+1 && runtime.liveTaskCount==1);
    CHECK(EventCount(@"系统到期")==1);
    Foreground();

    // Deactivation and later native category/mode cleanup are one release
    // episode. Stable notifications do not replay. A real native cleanup
    // may revoke the lease and receives at most one repair using the same task.
    Create(120); HostBegin(); Background(); [runtime advanceBy:2]; HostRelease();
    NSDictionary *releasedInfo=lastHostInfo;
    CHECK(audio.playing && [releasedInfo[@"releaseConfirmed"] boolValue]);
    FinishPulse(); starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
    Post(CSBackgroundRunHostAudioChangedNotification,releasedInfo);
    CHECK(CSTestPlayerStarts==starts && runtime.beginAttempts==attempts);
    [AVAudioSession.sharedInstance setMode:AVAudioSessionModeDefault error:NULL]; Drain();
    CHECK(audio.playing && CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryAmbient error:NULL]; Drain();
    [AVAudioSession.sharedInstance setActive:NO error:NULL]; Drain();
    CHECK(CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    CHECK([lastHostInfo[@"releaseEpisode"] isEqual:releasedInfo[@"releaseEpisode"]]);
    [runtime advanceBy:.4]; CHECK(CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    CHECK(EventCount(@"交接清理补偿")==1);
    Foreground();

    // No/invalid budget permits one fresh bridge request, then waits for an
    // external opportunity. A valid task identifier alone must not start audio.
    const NSTimeInterval missingBudgets[]={0,-1,NAN};
    for (NSUInteger index=0;index<sizeof(missingBudgets)/sizeof(*missingBudgets);index++) {
        Create(20); HostBegin(); Background(); [runtime advanceBy:2];
        runtime.backgroundTimeRemaining=missingBudgets[index]; attempts=runtime.beginAttempts; starts=CSTestPlayerStarts;
        HostRelease(); releasedInfo=lastHostInfo;
        CHECK(runtime.beginAttempts==attempts+1 && CSTestPlayerStarts==starts && !audio.playing);
        CHECK(!manager.canAttemptBackgroundWork);
        Post(CSBackgroundRunHostAudioChangedNotification,releasedInfo);
        [manager reloadSettings]; [runtime advanceBy:50];
        CHECK(runtime.beginAttempts==attempts+1 && CSTestPlayerStarts==starts);
        Foreground(); CHECK(!runtime.liveTaskCount && !runtime.pendingCheckCount);
    }

    // Re-read the real budget after a bridge response; a grant with newly
    // usable time can complete the same handoff without a second request.
    Create(20); HostBegin(); Background(); [runtime advanceBy:2];
    runtime.backgroundTimeRemaining=0; runtime.adjustNextBegin=YES; runtime.budgetAfterBegin=12;
    attempts=runtime.beginAttempts; starts=CSTestPlayerStarts;
    HostRelease();
    CHECK(audio.playing && runtime.beginAttempts==attempts+1 && CSTestPlayerStarts==starts+1);
    Foreground();

    // A refused bridge does not become a retry timer. New host work starts a
    // new episode and can recover after the system permits tasks again.
    Create(20); HostBegin(); Background(); [runtime advanceBy:2];
    [runtime.tasks.lastObject expire]; runtime.failBegin=YES;
    attempts=runtime.beginAttempts; starts=CSTestPlayerStarts;
    HostRelease(); releasedInfo=lastHostInfo;
    CHECK(runtime.beginAttempts==attempts+1 && CSTestPlayerStarts==starts);
    runtime.failBegin=NO; Post(CSBackgroundRunHostAudioChangedNotification,releasedInfo);
    [runtime advanceBy:60]; CHECK(runtime.beginAttempts==attempts+1 && CSTestPlayerStarts==starts);
    HostBegin(); HostRelease();
    CHECK(audio.playing && runtime.beginAttempts==attempts+2 && CSTestPlayerStarts==starts+1);
    Foreground();

    // An old successful release cannot overrule renewed host activity. Queued
    // release delivery is likewise harmless after foreground or demand ends.
    Create(120); HostBegin(); Background(); HostRelease(); releasedInfo=lastHostInfo;
    HostBegin(); starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
    Post(CSBackgroundRunHostAudioChangedNotification,releasedInfo);
    CHECK(!audio.playing && audio.hostBusy && AVAudioSession.sharedInstance.active);
    CHECK(CSTestPlayerStarts==starts && runtime.beginAttempts==attempts);
    [AVAudioSession.sharedInstance setActive:NO error:NULL]; Foreground(); Drain();
    CHECK(CSTestPlayerStarts==starts && !runtime.liveTaskCount && !runtime.pendingCheckCount);
    Create(120); HostBegin(); Background(); starts=CSTestPlayerStarts;
    [AVAudioSession.sharedInstance setActive:NO error:NULL]; Enable(NO); Drain();
    CHECK(CSTestPlayerStarts==starts && !runtime.liveTaskCount && !runtime.pendingCheckCount);

    // Yield probes only read state. They do not refresh leases or play, stop
    // on expiration, and remain bounded even when the host never releases.
    Create(20); HostBegin(); Background(); [runtime advanceBy:1.5];
    attempts=runtime.beginAttempts; starts=CSTestPlayerStarts;
    [runtime advanceBy:10.5];
    CHECK(runtime.beginAttempts==attempts && CSTestPlayerStarts==starts && audio.hostBusy);
    CHECK(runtime.checks.count>2); // Additional checks are actually exercised.
    runtime.backgroundTimeRemaining=8;
    [runtime advanceBy:8];
    CHECK(runtime.beginAttempts==attempts && CSTestPlayerStarts==starts && audio.hostBusy);
    CHECK(runtime.maximumPendingChecks<=3);
    oldTask=runtime.tasks.lastObject; [oldTask expire];
    NSUInteger scheduled=runtime.checks.count;
    [runtime advanceBy:100];
    CHECK(runtime.beginAttempts==attempts && CSTestPlayerStarts==starts && runtime.checks.count==scheduled);
    CHECK(!runtime.pendingCheckCount && audio.hostBusy);
    Foreground();
    Create(8); HostBegin(); Background(); [runtime advanceBy:24];
    scheduled=runtime.checks.count; [runtime advanceBy:.9];
    CHECK(runtime.checks.count==scheduled && runtime.maximumPendingChecks<=3);
    CHECK(CSTestPlayerStarts==starts && audio.hostBusy);
    CHECK(EventCount(@"让出复核结束")==1);
    Foreground();

    // A confirmed release is tracked synchronously before its queued delivery.
    // The low-budget probe can recover that exact signal, then the later native
    // notification must not create another audio player or bridging task.
    Create(8); HostBegin(); Background(); [runtime advanceBy:.49];
    starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
    [AVAudioSession.sharedInstance setActive:NO error:NULL];
    [runtime advanceBy:.01];
    CHECK(audio.playing && CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    Drain(); CHECK(CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    Foreground();

    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil;
    [audio stop]; audio=nil; Drain();
    [NSNotificationCenter.defaultCenter removeObserver:hostObserver];
    [defaults removePersistentDomainForName:suite];
    printf("Background handoff: %lu checks passed; immediate native release, budget bridge, deduplication and bounded observation verified\n",(unsigned long)checks);
} return 0; }
