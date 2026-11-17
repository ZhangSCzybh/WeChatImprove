#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <float.h>
#import <math.h>
#import "CSBackgroundRunManager.h"
#import "BackgroundRunFakeRuntime.h"

static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"COALESCE FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
static NSUserDefaults *defaults;
static CSBackgroundRunManager *manager;
static CSBackgroundRunAudio *audio;
static CSTestBackgroundRuntime *runtime;
static void Drain(void) { for (NSUInteger i=0;i<4;i++) [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.001]]; }
static void Post(NSString *name,NSDictionary *info) { [NSNotificationCenter.defaultCenter postNotificationName:name object:AVAudioSession.sharedInstance userInfo:info]; }
static void Enable(BOOL enabled) { [defaults setBool:enabled forKey:CSBackgroundRunEnabledKey]; [manager reloadSettings]; }
static void Foreground(void) {
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    Post(UIApplicationWillEnterForegroundNotification,nil); Post(UIApplicationDidBecomeActiveNotification,nil);
}
static void Background(void) {
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    Post(UIApplicationDidEnterBackgroundNotification,nil);
}
static void Interrupt(BOOL began) {
    Post(AVAudioSessionInterruptionNotification,@{AVAudioSessionInterruptionTypeKey:@(began?AVAudioSessionInterruptionTypeBegan:AVAudioSessionInterruptionTypeEnded)});
}
static void Route(NSUInteger reason) { Post(AVAudioSessionRouteChangeNotification,@{AVAudioSessionRouteChangeReasonKey:@(reason)}); }
static void Finish(void) { CHECK(CSTestLastPlayer!=nil); [CSTestLastPlayer finishSuccessfully:YES]; }
static NSUInteger EventCount(NSString *source) {
    NSUInteger count=0;
    for (CSBackgroundRunRecordEvent *event in manager.lastBackgroundEvents) if ([event.source isEqual:source]) count++;
    return count;
}
static void Create(NSTimeInterval remaining) {
    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.failDeactivationWithBusy=NO; session.activationAction=nil; session.categoryAction=nil; session.categoryReadAction=nil;
    CSTestFailPlayerCreation=CSTestFailPlayerPreparation=CSTestFailPlayerPlay=NO;
    CSTestBlankResourceAvailable=YES;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    UIApplication.sharedApplication.connectedScenes=[NSSet set];
    [defaults setBool:YES forKey:CSBackgroundRunEnabledKey]; [defaults removeObjectForKey:CSBackgroundRunCheckIntervalKey];
    audio=[CSBackgroundRunAudio new]; runtime=[CSTestBackgroundRuntime new];
    runtime.backgroundTimeRemaining=remaining; runtime.decrementsBudget=NO;
    manager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:YES runtime:runtime];
    [manager start];
}

int main(void) { @autoreleasepool {
    CSTestInstallBlankBundle();
    NSString *suite=[@"background-coalescing-tests-" stringByAppendingString:NSUUID.UUID.UUIDString];
    defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];

    // Recovery just before a periodic callback supplies one bounded success.
    // Only an actual owned resource and budget beyond the next deadline permit
    // reuse; proximity of the callbacks alone is insufficient.
    const NSTimeInterval budgets[]={29,26,20,DBL_MAX};
    for (NSUInteger index=0;index<sizeof(budgets)/sizeof(*budgets);index++) {
        Create(29); Background(); [runtime advanceBy:1.5]; Finish();
        [runtime advanceBy:22.7]; Interrupt(NO); [runtime advanceBy:.4];
        CHECK(audio.playing); Finish();
        NSUInteger starts=CSTestPlayerStarts, attempts=runtime.beginAttempts;
        runtime.backgroundTimeRemaining=budgets[index]; [runtime advanceBy:.4];
        BOOL reuse=index==0;
        BOOL ordinaryAttempt=index==1 || index==2;
        CHECK(CSTestPlayerStarts==starts+(ordinaryAttempt?1:0));
        CHECK(EventCount(@"资源复用")== (reuse?1:0));
        CHECK(runtime.beginAttempts==attempts && runtime.liveTaskCount==1);
        CHECK(manager.periodicCheckCount==1);
        Foreground();
    }

    // Once adjacency has elapsed, successful ownership and ample budget do not
    // suppress the ordinary cadence for the rest of the background visit.
    Create(29); Background(); [runtime advanceBy:1.5]; Finish();
    [runtime advanceBy:23.5]; CHECK(audio.playing && manager.periodicCheckCount==1);
    NSUInteger starts=CSTestPlayerStarts, attempts=runtime.beginAttempts;
    Finish(); [runtime advanceBy:25];
    CHECK(audio.playing && CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    CHECK(!EventCount(@"资源复用") && manager.periodicCheckCount==2);
    Foreground();

    // An existing playing audio resource can outlive its finite task. Only a
    // later actual ordinary audio attempt may acquire a missing task; a budget
    // skip leaves task ownership untouched, and stale expiration cannot undo it.
    for (NSUInteger skipped=0;skipped<2;skipped++) {
        Create(20); Background(); [runtime advanceBy:1.5];
        CSTestBackgroundTask *expiredTask=runtime.tasks.lastObject;
        attempts=runtime.beginAttempts; starts=CSTestPlayerStarts;
        [expiredTask expire]; CHECK(audio.playing && !runtime.liveTaskCount);
        runtime.backgroundTimeRemaining=skipped?DBL_MAX:20;
        [runtime advanceBy:23.5];
        CHECK(audio.playing && CSTestPlayerStarts==starts);
        CHECK(runtime.beginAttempts==attempts+(skipped?0:1));
        CHECK(runtime.liveTaskCount==(skipped?0:1));
        [expiredTask expire]; CHECK(audio.playing && runtime.beginAttempts==attempts+(skipped?0:1));
        Foreground();
    }

    // A pending recovery window wins over a colliding periodic delivery. The
    // periodic callback records its check but neither starts audio nor requests
    // another task, and recovery fires at its original deadline.
    Create(29); Background(); [runtime advanceBy:1.5]; Finish();
    [runtime advanceBy:23.3]; Interrupt(NO);
    starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
    [runtime advanceBy:.2];
    CHECK(!audio.playing && CSTestPlayerStarts==starts && runtime.beginAttempts==attempts);
    CHECK(manager.periodicCheckCount==1);
    [runtime advanceBy:.2];
    CHECK(audio.playing && CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    CHECK(EventCount(@"恢复检查")==1);
    Foreground();

    // Repeated benign route announcements preserve the existing player and do
    // not schedule recovery work. Native ownership checks remain authoritative.
    const NSUInteger benignReasons[]={AVAudioSessionRouteChangeReasonCategoryChange,AVAudioSessionRouteChangeReasonNewDeviceAvailable,
        AVAudioSessionRouteChangeReasonOverride,AVAudioSessionRouteChangeReasonRouteConfigurationChange};
    for (NSUInteger index=0;index<sizeof(benignReasons)/sizeof(*benignReasons);index++) {
        Create(29); Background(); [runtime advanceBy:1.5];
        NSUInteger scheduled=runtime.checks.count;
        starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
        Route(benignReasons[index]); Route(benignReasons[index]);
        CHECK(audio.playing && audio.sessionOwned && runtime.checks.count==scheduled);
        [runtime advanceBy:.4];
        CHECK(CSTestPlayerStarts==starts && runtime.beginAttempts==attempts && !EventCount(@"恢复检查"));
        Finish(); Route(benignReasons[index]); [runtime advanceBy:.4];
        CHECK(CSTestPlayerStarts==starts && runtime.checks.count==scheduled);
        Foreground();
    }

    // Route loss discards the old player immediately and keeps the full recovery
    // delay. Wake/unknown announcements also retain conservative recovery.
    const NSUInteger recoveryReasons[]={AVAudioSessionRouteChangeReasonOldDeviceUnavailable,AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory,
        AVAudioSessionRouteChangeReasonWakeFromSleep,AVAudioSessionRouteChangeReasonUnknown};
    for (NSUInteger index=0;index<sizeof(recoveryReasons)/sizeof(*recoveryReasons);index++) {
        Create(29); Background(); [runtime advanceBy:1.5];
        starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
        if (index>=2) Finish();
        Route(recoveryReasons[index]);
        CHECK(!audio.playing);
        [runtime advanceBy:.39]; CHECK(CSTestPlayerStarts==starts);
        [runtime advanceBy:.01];
        CHECK(audio.playing && CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
        CHECK(EventCount(@"恢复检查")==1);
        Foreground();
    }

    // An adverse route event cannot leave a permanent recovery barrier when
    // there was no timer to own it. A later confirmed release is a new chance.
    for (NSUInteger expired=0;expired<2;expired++) {
        Create(29); [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
        Background(); [runtime advanceBy:2];
        if (expired) [runtime.tasks.lastObject expire];
        starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
        Route(AVAudioSessionRouteChangeReasonOldDeviceUnavailable);
        [AVAudioSession.sharedInstance setActive:NO error:NULL]; Drain();
        CHECK(audio.playing && CSTestPlayerStarts==starts+1);
        CHECK(runtime.beginAttempts==attempts+expired);
        Foreground();
    }

    // When an actual route recovery timer exists, a confirmed host release
    // cannot bypass it. The same fresh event is completed at the .4s boundary.
    Create(29); Background(); [runtime advanceBy:1.5];
    starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
    Route(AVAudioSessionRouteChangeReasonOldDeviceUnavailable);
    [AVAudioSession.sharedInstance setActive:YES error:NULL];
    [AVAudioSession.sharedInstance setActive:NO error:NULL]; Drain();
    CHECK(!audio.playing && CSTestPlayerStarts==starts && runtime.beginAttempts==attempts);
    [runtime advanceBy:.39]; CHECK(!audio.playing && CSTestPlayerStarts==starts);
    [runtime advanceBy:.01];
    CHECK(audio.playing && CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    Foreground();

    // A benign reason cannot hide a real lease change. Even a same-value native
    // write revokes ownership, so a recent success is insufficient for reuse.
    Create(29); Background(); [runtime advanceBy:1.5]; Finish();
    starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
    [AVAudioSession.sharedInstance setMode:AVAudioSessionModeDefault error:NULL];
    Route(AVAudioSessionRouteChangeReasonCategoryChange); Drain(); [runtime advanceBy:.4];
    CHECK(audio.playing && CSTestPlayerStarts==starts+1 && runtime.beginAttempts==attempts);
    Foreground();

    // Media reset and failed playback invalidate credentials; a nearby check
    // must perform a real attempt after conditions become usable again.
    Create(29); Background(); [runtime advanceBy:1.5]; Finish();
    [runtime advanceBy:22.7]; Interrupt(NO); [runtime advanceBy:.4];
    [CSTestLastPlayer finishSuccessfully:NO]; starts=CSTestPlayerStarts;
    [runtime advanceBy:.4];
    CHECK(audio.playing && CSTestPlayerStarts==starts+1 && !EventCount(@"资源复用"));
    Foreground();
    Create(29); Background(); [runtime advanceBy:1.5]; Finish();
    [runtime advanceBy:22.7]; Interrupt(NO); [runtime advanceBy:.4]; Finish();
    starts=CSTestPlayerStarts;
    Post(AVAudioSessionMediaServicesWereLostNotification,nil);
    [runtime advanceBy:.4];
    CHECK(!audio.playing && CSTestPlayerStarts==starts && manager.periodicCheckCount==1);
    Post(AVAudioSessionMediaServicesWereResetNotification,nil); [runtime advanceBy:.4];
    CHECK(audio.playing && CSTestPlayerStarts==starts+1 && !EventCount(@"资源复用"));
    Foreground();

    // Notification payloads may be stale. Current immutable state must protect
    // both a plugin-owned player from false busy and native audio from release.
    Create(29); Background(); [runtime advanceBy:1.5];
    starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
    Post(CSBackgroundRunHostAudioChangedNotification,@{@"released":@NO,@"releaseConfirmed":@NO,@"hostCalls":@1});
    CHECK(audio.playing && audio.sessionOwned && CSTestPlayerStarts==starts && runtime.beginAttempts==attempts);
    [AVAudioSession.sharedInstance setActive:YES error:NULL]; Drain();
    CHECK(audio.hostBusy && !audio.playing);
    Post(CSBackgroundRunHostAudioChangedNotification,@{@"released":@YES,@"releaseConfirmed":@YES,@"releaseEpisode":@(audio.hostReleaseEpisode)});
    [runtime advanceBy:.4];
    CHECK(audio.hostBusy && !audio.playing && AVAudioSession.sharedInstance.active);
    CHECK(CSTestPlayerStarts==starts && runtime.beginAttempts==attempts);
    Foreground();

    // CategoryChange may be delivered inside our own setCategory before the
    // lease's configured flag is committed. It must not invalidate activation
    // or schedule a second recovery check for that same configuration request.
    Create(29); Background();
    AVAudioSession.sharedInstance.categoryAction=^{ Route(AVAudioSessionRouteChangeReasonCategoryChange); };
    [runtime advanceBy:1.5];
    CHECK(audio.playing && audio.sessionOwned && !EventCount(@"恢复检查"));
    NSUInteger scheduled=runtime.checks.count; starts=CSTestPlayerStarts; attempts=runtime.beginAttempts;
    [runtime advanceBy:.4];
    CHECK(CSTestPlayerStarts==starts && runtime.beginAttempts==attempts && runtime.checks.count==scheduled);
    AVAudioSession.sharedInstance.categoryAction=nil;
    Foreground();

    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil; Drain();
    [defaults removePersistentDomainForName:suite];
    printf("Background coalescing: %lu checks passed; task reuse, resource credentials, route filtering and current-state ownership verified\n",(unsigned long)checks);
} return 0; }
