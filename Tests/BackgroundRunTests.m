#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CSBackgroundRunManager.h"

static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
static NSUserDefaults *defaults;
static CSBackgroundRunManager *manager;
static CSBackgroundRunAudio *audio;
static void Drain(void) { for (NSUInteger i=0;i<4;i++) [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.005]]; }
static void Post(NSString *name,id object,NSDictionary *info) { [NSNotificationCenter.defaultCenter postNotificationName:name object:object userInfo:info]; }
static void Enable(BOOL enabled) { [defaults setBool:enabled forKey:CSBackgroundRunEnabledKey]; [manager reloadSettings]; }
static void Foreground(void) {
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;
    Post(UIApplicationWillEnterForegroundNotification,nil,nil);
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    Post(UIApplicationDidBecomeActiveNotification,nil,nil);
}
static void Background(void) { UIApplication.sharedApplication.applicationState=UIApplicationStateBackground; Post(UIApplicationDidEnterBackgroundNotification,nil,nil); }
static void Create(BOOL supported, BOOL enabled) {
    Enable(NO); manager=nil; [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.activationAction=nil; CSTestFailPlayerCreation=CSTestFailPlayerPlay=NO;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    UIApplication.sharedApplication.connectedScenes=[NSSet set];
    [defaults removeObjectForKey:CSBackgroundRunPolicyKey];
    [defaults setBool:enabled forKey:CSBackgroundRunEnabledKey];
    audio=[CSBackgroundRunAudio new];
    manager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:supported];
    [manager start];
}
static void Interrupt(BOOL began,BOOL resume) {
    if (began) AVAudioSession.sharedInstance.active=NO; // OS deactivation, not a host API call.
    Post(AVAudioSessionInterruptionNotification,nil,@{AVAudioSessionInterruptionTypeKey:@(began?AVAudioSessionInterruptionTypeBegan:AVAudioSessionInterruptionTypeEnded),AVAudioSessionInterruptionOptionKey:@(resume?AVAudioSessionInterruptionOptionShouldResume:0)});
}
// Deterministic time and device inputs exercise the real production manager.
@interface CSClockedBackgroundManager : CSBackgroundRunManager
@property(nonatomic) NSTimeInterval testWall, testContinuous;
@property(nonatomic) BOOL testLowPower;
@property(nonatomic) NSProcessInfoThermalState testThermal;
@property(nonatomic, strong) NSCalendar *testCalendar;
@property(nonatomic, strong) NSMutableArray<NSTimer *> *testTimers;
@property(nonatomic, strong) NSMutableArray *testHandlers;
@property(nonatomic) NSTimeInterval lastDelay;
@end
@implementation CSClockedBackgroundManager
- (NSDate *)wallNow { return [NSDate dateWithTimeIntervalSince1970:self.testWall]; }
- (NSTimeInterval)continuousNow { return self.testContinuous; }
- (NSCalendar *)policyCalendar { return self.testCalendar; }
- (BOOL)lowPowerModeEnabled { return self.testLowPower; }
- (NSProcessInfoThermalState)thermalState { return self.testThermal; }
- (NSTimer *)createBoundaryTimerAfter:(NSTimeInterval)delay handler:(void (^)(NSTimer *))handler {
    for(NSTimer *existing in self.testTimers) CHECK(!existing.valid);
    NSTimer *timer=[NSTimer timerWithTimeInterval:delay repeats:NO block:handler];
    [self.testTimers addObject:timer];[self.testHandlers addObject:[handler copy]];self.lastDelay=delay;return timer;
}
@end
static CSClockedBackgroundManager *Controlled(id policy,BOOL legacy) {
    Create(YES,YES);manager=nil;
    [defaults removeObjectForKey:CSBackgroundRunPolicyKey];
    if(policy)[defaults setObject:policy forKey:CSBackgroundRunPolicyKey];
    else if(!legacy)[defaults removeObjectForKey:CSBackgroundRunEnabledKey];
    UIDevice.currentDevice.batteryLevel=.8f;UIDevice.currentDevice.batteryState=UIDeviceBatteryStateUnplugged;
    CSClockedBackgroundManager *clocked=[[CSClockedBackgroundManager alloc]initWithDefaults:defaults audio:audio supportsBackgroundAudio:YES];
    clocked.testCalendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];clocked.testCalendar.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:0];
    clocked.testWall=[[[NSISO8601DateFormatter alloc]init] dateFromString:@"2026-10-30T10:00:00Z"].timeIntervalSince1970;
    clocked.testTimers=[NSMutableArray array];clocked.testHandlers=[NSMutableArray array];manager=clocked;[manager start];return clocked;
}
static void Advance(CSClockedBackgroundManager *clocked,NSTimeInterval seconds) { clocked.testContinuous+=seconds;clocked.testWall+=seconds; }
static void FireBoundary(CSClockedBackgroundManager *clocked) { void (^handler)(NSTimer *)=clocked.testHandlers.lastObject;CHECK(handler!=nil);handler(clocked.testTimers.lastObject); }
static NSMutableDictionary *Policy(NSUInteger minutes) { NSMutableDictionary *policy=[CSBackgroundRunDefaultPolicy() mutableCopy];policy[@"maxMinutes"]=@(minutes);return policy; }
static void TestPolicyManager(void) {
    CSClockedBackgroundManager *clocked=Controlled(nil,YES);
    CHECK(manager.usesLegacyPolicy && [manager.policy isEqual:CSBackgroundRunLegacyPolicy()]);
    CHECK([defaults objectForKey:CSBackgroundRunPolicyKey]==nil);
    [manager setEnabled:NO];[manager setEnabled:YES];CHECK(manager.usesLegacyPolicy && [defaults objectForKey:CSBackgroundRunPolicyKey]==nil);
    Background();Advance(clocked,4000);CHECK(audio.playing && manager.remainingDuration==-1 && clocked.testTimers.count==0);
    CHECK([manager savePolicy:Policy(30) error:NULL]);CHECK(!audio.playing && manager.remainingDuration==0); // No fresh budget on adoption.

    clocked=Controlled(nil,NO);CHECK(!manager.enabled && !manager.usesLegacyPolicy && [manager.policy isEqual:CSBackgroundRunDefaultPolicy()]);
    CHECK([defaults objectForKey:CSBackgroundRunPolicyKey]==nil);
    [manager setEnabled:YES];CHECK([defaults objectForKey:CSBackgroundRunPolicyKey]!=nil);
    CHECK([manager.policy[@"maxMinutes"] isEqual:@30] && [manager.policy[@"energySaving"] boolValue]);
    Background();CHECK(audio.playing && manager.remainingDuration==1800 && UIDevice.currentDevice.batteryMonitoringEnabled);
    // A zero continuous-clock origin is valid. All pauses count against it.
    __block NSUInteger stateEvents=0;__block BOOL observedActive=NO;
    id observation=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note){stateEvents++;observedActive=manager.backgroundAudioActive;}];
    NSUInteger timers=clocked.testTimers.count,players=CSTestPlayerCreates;
    for(NSUInteger i=0;i<1000;i++)Post(NSUserDefaultsDidChangeNotification,nil,nil);
    CHECK(clocked.testTimers.count==timers && CSTestPlayerCreates==players && stateEvents==0);
    Advance(clocked,600);Interrupt(YES,NO);CHECK(!audio.playing && stateEvents==1 && !observedActive);
    Advance(clocked,300);Interrupt(NO,YES);CHECK(audio.playing && manager.remainingDuration==900 && stateEvents==2 && observedActive);
    [manager setEnabled:NO];Advance(clocked,300);[manager setEnabled:YES];CHECK(audio.playing && manager.remainingDuration==600);
    clocked.testLowPower=YES;Post(NSProcessInfoPowerStateDidChangeNotification,nil,nil);CHECK(!audio.playing && !observedActive);
    Advance(clocked,300);clocked.testLowPower=NO;Post(NSProcessInfoPowerStateDidChangeNotification,nil,nil);CHECK(audio.playing && manager.remainingDuration==300 && observedActive);
    Advance(clocked,301);FireBoundary(clocked);CHECK(!audio.playing && manager.remainingDuration==0 && !observedActive);
    CHECK([manager.statusText containsString:@"已用完"] && !((NSTimer *)[manager valueForKey:@"boundaryTimer"]).valid);
    players=CSTestPlayerCreates;[manager setEnabled:NO];[manager setEnabled:YES];Interrupt(YES,NO);Interrupt(NO,YES);
    Post(NSProcessInfoPowerStateDidChangeNotification,nil,nil);CHECK(!audio.playing && CSTestPlayerCreates==players);
    Foreground();CHECK(manager.remainingDuration==-1 && !UIDevice.currentDevice.batteryMonitoringEnabled);
    Background();CHECK(audio.playing && manager.remainingDuration==1800);
    [NSNotificationCenter.defaultCenter removeObserver:observation];

    // Editing limits uses the original success time, including an unlimited interval.
    clocked=Controlled(Policy(30),NO);Background();Advance(clocked,600);
    CHECK([manager savePolicy:Policy(5) error:NULL] && !audio.playing && manager.remainingDuration==0);
    CHECK([manager savePolicy:Policy(15) error:NULL] && audio.playing && manager.remainingDuration==300);
    CHECK([manager savePolicy:Policy(0) error:NULL] && audio.playing && manager.remainingDuration==-1);
    Advance(clocked,400);CHECK([manager savePolicy:Policy(15) error:NULL] && !audio.playing);
    Foreground();Background();CHECK(audio.playing && manager.remainingDuration==900);
    // Invalid writes are rejected atomically; invalid persisted input fails closed.
    NSDictionary *stored=[defaults objectForKey:CSBackgroundRunPolicyKey];NSMutableDictionary *bad=Policy(30);bad[@"maxMinutes"]=@1;NSError *failure=nil;
    CHECK(![manager savePolicy:bad error:&failure] && failure && [[defaults objectForKey:CSBackgroundRunPolicyKey] isEqual:stored] && audio.playing);
    [defaults setObject:@"corrupt" forKey:CSBackgroundRunPolicyKey];[manager reloadSettings];CHECK(!audio.playing && [manager.statusText containsString:@"无效"]);
    CHECK([manager savePolicy:Policy(30) error:NULL] && audio.playing);

    // Battery hysteresis, charging, unknown readings and thermal precedence.
    clocked=Controlled(Policy(30),NO);Background();
    UIDevice *device=UIDevice.currentDevice;device.batteryLevel=.20f;Post(UIDeviceBatteryLevelDidChangeNotification,nil,nil);CHECK(!audio.playing);
    for(NSNumber *level in @[@.21f,@.24f]){device.batteryLevel=level.floatValue;Post(UIDeviceBatteryLevelDidChangeNotification,nil,nil);CHECK(!audio.playing);}
    device.batteryLevel=.25f;Post(UIDeviceBatteryLevelDidChangeNotification,nil,nil);CHECK(audio.playing);
    device.batteryLevel=.19f;Post(UIDeviceBatteryLevelDidChangeNotification,nil,nil);CHECK(!audio.playing);
    device.batteryState=UIDeviceBatteryStateCharging;Post(UIDeviceBatteryStateDidChangeNotification,nil,nil);CHECK(audio.playing);
    device.batteryState=UIDeviceBatteryStateUnplugged;Post(UIDeviceBatteryStateDidChangeNotification,nil,nil);CHECK(!audio.playing);
    device.batteryLevel=-1;Post(UIDeviceBatteryLevelDidChangeNotification,nil,nil);CHECK(audio.playing);
    clocked.testThermal=NSProcessInfoThermalStateSerious;Post(NSProcessInfoThermalStateDidChangeNotification,nil,nil);CHECK(!audio.playing);
    clocked.testLowPower=YES;clocked.testThermal=NSProcessInfoThermalStateFair;Post(NSProcessInfoThermalStateDidChangeNotification,nil,nil);CHECK(!audio.playing && [manager.statusText containsString:@"低电量模式"]);
    clocked.testLowPower=NO;Post(NSProcessInfoPowerStateDidChangeNotification,nil,nil);CHECK(audio.playing);
    NSMutableDictionary *unprotected=Policy(30);unprotected[@"energySaving"]=@NO;CHECK([manager savePolicy:unprotected error:NULL]);
    clocked.testThermal=NSProcessInfoThermalStateCritical;Post(NSProcessInfoThermalStateDidChangeNotification,nil,nil);CHECK(!audio.playing);
    clocked.testThermal=NSProcessInfoThermalStateFair;Post(NSProcessInfoThermalStateDidChangeNotification,nil,nil);CHECK(audio.playing);
    // Do not disable monitoring already enabled by the host before our lease.
    Foreground();device.batteryMonitoringEnabled=YES;CHECK([manager savePolicy:Policy(30) error:NULL]);Background();Foreground();CHECK(device.batteryMonitoringEnabled);device.batteryMonitoringEnabled=NO;

    // Window boundary vs budget; stale timers cannot cancel a new generation.
    NSMutableDictionary *window=Policy(30);window[@"allDay"]=@NO;window[@"startMinute"]=@600;window[@"endMinute"]=@610;
    clocked=Controlled(window,NO);Background();CHECK(audio.playing && clocked.lastDelay==600);
    void (^stale)(NSTimer *)=clocked.testHandlers.lastObject;NSTimer *staleTimer=clocked.testTimers.lastObject;
    Advance(clocked,600);FireBoundary(clocked);CHECK(!audio.playing && [manager.statusText containsString:@"不在允许时段"] && manager.remainingDuration==1200);
    NSTimer *next=[manager valueForKey:@"boundaryTimer"];stale(staleTimer);CHECK([manager valueForKey:@"boundaryTimer"]==next && !audio.playing);
    // A significant wall-clock jump does not alter the continuous budget.
    clocked.testWall-=600;Post(UIApplicationSignificantTimeChangeNotification,nil,nil);CHECK(audio.playing && manager.remainingDuration==1200);
    clocked.testWall+=86400;Post(NSSystemTimeZoneDidChangeNotification,nil,nil);CHECK(audio.playing && manager.remainingDuration==1200);
    Advance(clocked,1201);FireBoundary(clocked);CHECK(!audio.playing && manager.remainingDuration==0);
    // Outside the window there is no origin until the first successful start.
    window[@"startMinute"]=@660;window[@"endMinute"]=@720;
    clocked=Controlled(window,NO);Background();CHECK(!audio.playing && manager.remainingDuration==-1 && clocked.lastDelay==3600);
    Advance(clocked,3600);FireBoundary(clocked);CHECK(audio.playing && manager.remainingDuration==1800);
    // A later callback after a simulated long suspension uses continuous elapsed time.
    Advance(clocked,7200);FireBoundary(clocked);CHECK(!audio.playing && manager.remainingDuration==0);

    // The host retains audio even when a policy stops our expired lease.
    clocked=Controlled(Policy(5),NO);Background();AVAudioSession *session=AVAudioSession.sharedInstance;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];[session setActive:YES error:NULL];Drain();
    CHECK(!audio.playing && session.active);
    NSUInteger deactivations=session.deactivations,configurations=session.configurations;
    Advance(clocked,301);FireBoundary(clocked);CHECK(session.active && session.deactivations==deactivations && session.configurations==configurations);
    [session setActive:NO error:NULL];Drain();CHECK(!audio.playing && manager.remainingDuration==0);
    Foreground();Background();CHECK(audio.playing && manager.remainingDuration==300);
    // A host-owned session before our first success does not spend a budget.
    clocked=Controlled(Policy(5),NO);
    [session setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];[session setActive:YES error:NULL];Drain();
    Background();CHECK(!audio.playing && manager.remainingDuration==-1 && clocked.testTimers.count==0);
    Advance(clocked,600);[session setActive:NO error:NULL];Drain();CHECK(audio.playing && manager.remainingDuration==300);
    Advance(clocked,60);[session setMode:@"VoiceChat" error:NULL];Drain();CHECK(!audio.playing);
    Advance(clocked,60);[session setActive:NO error:NULL];Drain();CHECK(audio.playing && manager.remainingDuration==180);
    // Changing time zones recalculates only the wall-clock boundary.
    window=Policy(30);window[@"allDay"]=@NO;window[@"startMinute"]=@600;window[@"endMinute"]=@660;
    clocked=Controlled(window,NO);Background();Advance(clocked,60);
    clocked.testCalendar.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:3600];Post(NSSystemTimeZoneDidChangeNotification,nil,nil);
    CHECK(!audio.playing && manager.remainingDuration==1740);
    clocked.testCalendar.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:0];Post(NSSystemTimeZoneDidChangeNotification,nil,nil);
    CHECK(audio.playing && manager.remainingDuration==1740);
    // A failed first attempt cannot consume the budget or retry on defaults noise.
    clocked=Controlled(Policy(5),NO);CSTestFailPlayerPlay=YES;Background();CHECK(!audio.playing && manager.remainingDuration==-1);
    timers=clocked.testTimers.count;players=CSTestPlayerCreates;Advance(clocked,600);Post(NSUserDefaultsDidChangeNotification,nil,nil);
    CHECK(clocked.testTimers.count==timers && CSTestPlayerCreates==players && manager.remainingDuration==-1);
    CSTestFailPlayerPlay=NO;Foreground();Background();CHECK(audio.playing && manager.remainingDuration==300);
    [manager setEnabled:NO];manager=nil;clocked=nil;
    __weak CSBackgroundRunManager *weakManager;void (^afterDeath)(NSTimer *);NSTimer *deathTimer;
    @autoreleasepool {
        clocked=Controlled(Policy(5),NO);Background();weakManager=manager;
        afterDeath=clocked.testHandlers.lastObject;deathTimer=clocked.testTimers.lastObject;
        [manager setEnabled:NO];manager=nil;clocked=nil;
    }
    CHECK(weakManager==nil && !deathTimer.valid);
    afterDeath(deathTimer);CHECK(!audio.playing);
}

int main(int argc,const char **argv) { @autoreleasepool {
    NSString *suite=[@"background-run-tests-" stringByAppendingString:NSUUID.UUID.UUIDString];
    defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    AVAudioSession *session=AVAudioSession.sharedInstance;
    __block NSUInteger hostEvents=0;
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunHostAudioChangedNotification object:nil queue:nil usingBlock:^(NSNotification *note){ hostEvents++; }];

    // Start without any observed native activation: our own session must not
    // later be mistaken for a pre-existing host audio session.
    [defaults setBool:YES forKey:CSBackgroundRunEnabledKey];
    audio=[CSBackgroundRunAudio new];
    manager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:YES];
    [manager start]; [manager start];
    CHECK(!audio.playing && !CSTestPlayerCreates && !session.configurations);
    CHECK(!manager.backgroundAudioActive);
    Background(); CHECK(audio.playing && session.active && audio.sessionOwned && !audio.hostBusy);
    CHECK(manager.backgroundAudioActive);
    CHECK(CSTestPlayersAlive==1 && CSTestPlayerCreates==1);
    for (NSUInteger i=0;i<100;i++) { Background(); Post(NSUserDefaultsDidChangeNotification,nil,nil); }
    Drain(); CHECK(audio.playing && CSTestPlayerCreates==1 && !hostEvents);
    Foreground(); CHECK(!audio.playing && !session.active && CSTestPlayersAlive==0);
    CHECK(!manager.backgroundAudioActive);
    CHECK([session.category isEqual:AVAudioSessionCategoryAmbient]);
    CHECK([manager.statusText isEqual:@"前台待机"] && [manager.lastBackgroundResult isEqual:@"后台音频已启动"]);

    // Repeated transitions have one player each and never retain idle players.
    NSUInteger initial=CSTestPlayerCreates;
    for (NSUInteger i=0;i<50;i++) { Background(); CHECK(CSTestPlayersAlive==1); Foreground(); CHECK(CSTestPlayersAlive==0); }
    CHECK(CSTestPlayerCreates-initial==50);
    Background(); Enable(NO); CHECK(!audio.playing && !session.active);
    CHECK(!manager.backgroundAudioActive);
    Enable(YES); CHECK(audio.playing); // Same background session, explicit enable.
    CHECK(manager.backgroundAudioActive);

    Create(NO,YES); initial=CSTestPlayerCreates; Background();
    CHECK(!audio.playing && CSTestPlayerCreates==initial && [manager.statusText containsString:@"未声明"]);
    CHECK(!manager.backgroundAudioActive);
    Create(YES,NO); initial=CSTestPlayerCreates; Background();
    CHECK(!audio.playing && CSTestPlayerCreates==initial);

    // Initializing after background entry is supported without another event.
    Create(YES,YES); manager=nil;
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    manager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:YES];
    [manager start]; CHECK(audio.playing);

    // An inactive but foreground scene still wins over another background scene.
    Create(YES,YES);
    UIScene *first=[UIScene new], *second=[UIScene new];
    first.activationState=UISceneActivationStateBackground; second.activationState=UISceneActivationStateForegroundInactive;
    UIApplication.sharedApplication.connectedScenes=[NSSet setWithObjects:first,second,nil];
    Post(UISceneDidEnterBackgroundNotification,first,nil); CHECK(!audio.playing);
    second.activationState=UISceneActivationStateBackground;
    Post(UISceneDidEnterBackgroundNotification,second,nil); CHECK(audio.playing);
    first.activationState=UISceneActivationStateForegroundInactive;
    Post(UISceneWillEnterForegroundNotification,first,nil); CHECK(!audio.playing);
    Post(UISceneDidEnterBackgroundNotification,first,nil); CHECK(!audio.playing); // stale event

    // Category, activation, player initialization and play failures release their
    // resources, preserve settings, and do not retry on unrelated defaults/events.
    for (NSUInteger failure=0;failure<4;failure++) {
        Create(YES,YES);
        session.failCategory=failure==0; session.failActivation=failure==1;
        CSTestFailPlayerCreation=failure==2; CSTestFailPlayerPlay=failure==3;
        Background(); CHECK(!audio.playing && !session.active && CSTestPlayersAlive==0);
        CHECK([manager.statusText containsString:@"启动失败"] && manager.enabled);
        initial=CSTestPlayerCreates;
        for (NSUInteger i=0;i<50;i++) { Post(NSUserDefaultsDidChangeNotification,nil,nil); Background(); Post(AVAudioSessionRouteChangeNotification,nil,nil); }
        CHECK(CSTestPlayerCreates==initial);
        CHECK([manager.statusText containsString:@"启动失败"]); // Self-induced route events preserve the actual failure.
        session.failCategory=session.failActivation=NO; CSTestFailPlayerCreation=CSTestFailPlayerPlay=NO;
        Foreground(); Background(); CHECK(audio.playing);
    }

    Create(YES,YES); Background(); initial=CSTestPlayerCreates;
    Interrupt(NO,NO); CHECK(audio.playing && session.active); // No matching interruption began.
    Interrupt(YES,NO); CHECK(!audio.playing && !session.active);
    CHECK(!manager.backgroundAudioActive);
    Post(NSUserDefaultsDidChangeNotification,nil,nil); CHECK(CSTestPlayerCreates==initial);
    Interrupt(NO,YES); CHECK(audio.playing && CSTestPlayerCreates==initial+1);
    CHECK(manager.backgroundAudioActive);
    Interrupt(YES,NO); Interrupt(NO,NO); CHECK(!audio.playing);
    initial=CSTestPlayerCreates; Background(); Post(NSUserDefaultsDidChangeNotification,nil,nil); CHECK(CSTestPlayerCreates==initial);
    Foreground(); Background(); CHECK(audio.playing); // Resume denial is not a permanent latch.
    Interrupt(YES,NO); Enable(NO); Interrupt(NO,YES); CHECK(!audio.playing);

    Create(YES,YES); Background();
    Post(AVAudioSessionMediaServicesWereLostNotification,nil,nil); CHECK(!audio.playing);
    CHECK(!manager.backgroundAudioActive);
    session.active=NO; session.category=AVAudioSessionCategorySoloAmbient;
    Post(AVAudioSessionMediaServicesWereResetNotification,nil,nil); CHECK(audio.playing);
    Post(CSBackgroundRunPlaybackFailedNotification,audio,nil); CHECK(!audio.playing);
    initial=CSTestPlayerCreates; Post(AVAudioSessionRouteChangeNotification,nil,nil); Post(NSUserDefaultsDidChangeNotification,nil,nil);
    CHECK(CSTestPlayerCreates==initial);

    // Native call audio wins, including native API invocations off main. Stopping
    // our player must never deactivate or overwrite the native call session.
    Create(YES,YES); Background();
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        [session setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
        [session setActive:YES error:NULL];
    });
    NSUInteger deactivations=session.deactivations;
    Drain(); CHECK(!audio.playing && session.active && session.deactivations==deactivations);
    CHECK([session.category isEqual:AVAudioSessionCategoryPlayAndRecord] && [session.mode isEqual:@"VoiceChat"] && session.categoryOptions==4);
    Enable(NO); CHECK(session.active && session.deactivations==deactivations);
    Enable(YES); CHECK(!audio.playing);
    [session setActive:NO error:NULL]; Drain(); CHECK(audio.playing);
    Foreground(); CHECK(!session.active && [session.category isEqual:AVAudioSessionCategoryPlayAndRecord] && [session.mode isEqual:@"VoiceChat"]);

    // A configuration claim is not a release, even when the last observed native
    // setActive was NO. Wait for an explicit release instead of fighting it.
    Create(YES,YES); Background(); initial=CSTestPlayerCreates;
    [session setMode:@"VoiceChat" error:NULL]; Drain();
    CHECK(!audio.playing && CSTestPlayerCreates==initial);
    Post(NSUserDefaultsDidChangeNotification,nil,nil); CHECK(!audio.playing);
    [session setActive:NO error:NULL]; Drain(); CHECK(audio.playing);

    // If the host takes ownership while our activation is running, the atomic
    // epoch prevents play/restoration/deactivation of its newer configuration.
    Create(YES,YES);
    __weak AVAudioSession *weakSession=session;
    session.activationAction=^{ dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        [weakSession setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
        [weakSession setActive:YES error:NULL];
    }); };
    deactivations=session.deactivations;
    Background(); CHECK(!audio.playing && session.active && session.deactivations==deactivations);
    CHECK([session.category isEqual:AVAudioSessionCategoryPlayAndRecord]); Drain();

    // A queued host notification from before a fresh lease cannot cancel it.
    Create(YES,YES);
    [session setActive:NO error:NULL]; Background(); CHECK(audio.playing);
    initial=CSTestPlayerCreates; Drain(); CHECK(audio.playing && CSTestPlayerCreates==initial);

    // Even a same-value native category write transfers ownership.
    [session setCategory:session.category mode:session.mode options:session.categoryOptions error:NULL];
    CHECK(!audio.sessionOwned);
    // Ownership is revoked synchronously, before the queued manager notification
    // stops the player or replaces the last successful status text.
    CHECK(audio.playing && [manager.statusText isEqual:@"后台音频已启动"] && !manager.backgroundAudioActive);
    Drain(); CHECK(!audio.playing);

    // Failed native methods retain errors and returns. Exceptions unwind the
    // observer scope, so future native calls are still observed.
    Create(YES,NO); session.failCategory=YES; NSError *error=nil;
    CHECK(![session setCategory:AVAudioSessionCategoryPlayback error:&error] && error.code==10);
    session.failCategory=NO; session.throwCategory=YES; BOOL caught=NO;
    @try { [session setCategory:AVAudioSessionCategoryPlayback error:NULL]; } @catch (NSException *e) { caught=YES; }
    CHECK(caught); session.throwCategory=NO;
    [session setActive:YES error:NULL]; Drain(); CHECK(audio.hostBusy);
    [session setActive:NO error:NULL]; Drain(); CHECK(!audio.hostBusy);

    // Failure to deactivate must not reconfigure an audio session that could be
    // occupied by another native audio object.
    Create(YES,YES); Background(); session.failDeactivation=YES;
    NSUInteger configurations=session.configurations;
    Foreground(); CHECK(!audio.playing && session.configurations==configurations);
    session.failDeactivation=NO;

    // Defaults notifications sent while native services hold their own thread
    // never synchronously wait for the main thread.
    dispatch_semaphore_t finished=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        for (NSUInteger i=0;i<1000;i++) Post(NSUserDefaultsDidChangeNotification,nil,nil);
        dispatch_semaphore_signal(finished);
    });
    CHECK(dispatch_semaphore_wait(finished,dispatch_time(DISPATCH_TIME_NOW,2*NSEC_PER_SEC))==0); Drain();

    TestPolicyManager();

    NSData *wav=CSBackgroundRunSilentAudioData();
    CHECK(wav==CSBackgroundRunSilentAudioData() && wav.length==256044);
    const uint8_t *bytes=wav.bytes;
    CHECK(!memcmp(bytes,"RIFF",4) && !memcmp(bytes+8,"WAVEfmt ",8) && !memcmp(bytes+36,"data",4));
    CHECK(bytes[20]==1 && bytes[22]==1 && bytes[32]==2 && bytes[34]==16);
    BOOL silent=YES; for (NSUInteger i=44;i<wav.length;i++) if (bytes[i]) { silent=NO; break; }
    CHECK(silent);
    CHECK(argc==2 && [wav writeToFile:[NSString stringWithUTF8String:argv[1]] atomically:YES]);
    Enable(NO); manager=nil; audio=nil; Drain(); CHECK(!CSTestPlayersAlive);
    [NSNotificationCenter.defaultCenter removeObserver:observer];
    [defaults removePersistentDomainForName:suite];
    printf("Background run: %lu checks passed; production manager, audio ownership and native hook bodies verified\n",(unsigned long)checks);
} return 0; }
