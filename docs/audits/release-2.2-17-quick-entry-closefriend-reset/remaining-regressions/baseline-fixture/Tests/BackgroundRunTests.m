#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CSBackgroundRunManager.h"
#import "BackgroundRunFakeRuntime.h"

static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
static NSUserDefaults *defaults;
static CSBackgroundRunManager *manager;
static CSBackgroundRunAudio *audio;
static CSBackgroundRunManager *AudioOnlyManager(BOOL supported) {
    CSTestBackgroundRuntime *runtime=[CSTestBackgroundRuntime new];
    runtime.failBegin=YES; runtime.backgroundTimeRemaining=0;
    return [[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:audio supportsBackgroundAudio:supported runtime:runtime];
}
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
    // Async callbacks can keep the previous fixture alive until this pool drains;
    // it must not observe the next fixture's settings in that interval.
    Enable(NO); [NSNotificationCenter.defaultCenter removeObserver:manager]; manager=nil; [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.activationAction=nil; CSTestFailPlayerCreation=CSTestFailPlayerPlay=NO;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    UIApplication.sharedApplication.connectedScenes=[NSSet set];
    [defaults setBool:enabled forKey:CSBackgroundRunEnabledKey];
    audio=[CSBackgroundRunAudio new];
    manager=AudioOnlyManager(supported);
    [manager start];
}
static void Interrupt(BOOL began,BOOL resume) {
    if (began) AVAudioSession.sharedInstance.active=NO; // OS deactivation, not a host API call.
    Post(AVAudioSessionInterruptionNotification,nil,@{AVAudioSessionInterruptionTypeKey:@(began?AVAudioSessionInterruptionTypeBegan:AVAudioSessionInterruptionTypeEnded),AVAudioSessionInterruptionOptionKey:@(resume?AVAudioSessionInterruptionOptionShouldResume:0)});
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
    manager=AudioOnlyManager(YES);
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
    manager=AudioOnlyManager(YES);
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
        Background();
        if (audio.playing || session.active || CSTestPlayersAlive) fprintf(stderr,"audio failure case %lu: playing=%d active=%d alive=%lu status=%s\n",(unsigned long)failure,audio.playing,session.active,(unsigned long)CSTestPlayersAlive,manager.statusText.UTF8String);
        CHECK(!audio.playing && !session.active && CSTestPlayersAlive==0);
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
