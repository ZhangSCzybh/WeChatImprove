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
    [runtime advanceBy:26];
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
    Create(120,NO); Background(); entry=manager.lastBackgroundStartedAt; checked=manager.lastBackgroundCheckedAt;
    CSTestBackgroundCheck *stale=runtime.checks.lastObject;
    [runtime advanceBy:5]; Enable(NO);
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
    [runtime advanceBy:2]; [stale fireEvenIfCancelled]; [oldTask expire];
    CHECK(SameDate(manager.lastBackgroundStartedAt,entry) && SameDate(manager.lastBackgroundCheckedAt,checked));
    CHECK(!manager.lastBackgroundStoppedAt && manager.canAttemptBackgroundWork);
    Foreground();

    // A late-loaded manager only knows when it began observing the background.
    Create(120,YES);
    CHECK(SameDate(manager.lastBackgroundStartedAt,runtime.currentDate) && !manager.lastBackgroundStartObserved);
    CHECK(SameDate(manager.lastBackgroundCheckedAt,runtime.currentDate));
    [runtime advanceBy:3]; Foreground(); CHECK(fabs(manager.lastCheckToForegroundInterval-3)<.000001);
    [runtime advanceBy:2]; Background();
    CHECK(SameDate(manager.lastBackgroundStartedAt,runtime.currentDate) && manager.lastBackgroundStartObserved);
    Foreground();

    // Display timestamps follow wall-clock changes. The diagnostic interval
    // follows monotonic time, including when the wall clock moves backwards.
    Create(120,NO); Background(); [runtime advanceBy:26]; checked=manager.lastBackgroundCheckedAt;
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
    Background(); returned=runtime.currentDate;
    CHECK(!manager.canAttemptBackgroundWork && !audio.playing && !runtime.liveTaskCount && !runtime.pendingCheckCount);
    CHECK(SameDate(manager.lastForegroundReturnedAt,returned));
    CHECK(!manager.lastBackgroundCheckedAt || [manager.lastBackgroundCheckedAt compare:returned]!=NSOrderedDescending);
    CHECK([manager.lastBackgroundStopReason containsString:@"前台"]);
    checked=manager.lastBackgroundCheckedAt;
    [runtime advanceBy:3]; [manager reloadSettings]; Foreground();
    CHECK(SameDate(manager.lastForegroundReturnedAt,returned));
    CHECK((!checked && !manager.lastBackgroundCheckedAt) || SameDate(manager.lastBackgroundCheckedAt,checked));

    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil; runtime=nil; Drain();
    CHECK(!CSTestPlayersAlive);
    [defaults removePersistentDomainForName:suite];
    printf("Background records: %lu checks passed; actual checks, lifecycle timestamps, monotonic gaps and stale callbacks verified\n",(unsigned long)checks);
} return 0; }
