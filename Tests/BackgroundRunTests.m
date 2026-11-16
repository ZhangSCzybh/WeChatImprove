#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CSBackgroundRunAudio.h"

static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
static CSBackgroundRunAudio *audio;
static void Drain(void) { for (NSUInteger i=0;i<4;i++) [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.005]]; }
static void Fresh(void) {
    [audio setHostNotificationsEnabled:NO];
    [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.failDeactivationWithBusy=NO;
    session.secondaryAudioShouldBeSilencedHint=NO; session.activationAction=nil;
    CSTestFailPlayerCreation=CSTestFailPlayerPreparation=CSTestFailPlayerPlay=NO;
    CSTestBlankResourceAvailable=YES;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    audio=[CSBackgroundRunAudio new];
    [audio setHostNotificationsEnabled:YES];
}
static void Finish(BOOL success) { [CSTestLastPlayer finishSuccessfully:success]; }
int main(void) { @autoreleasepool {
    CSTestInstallBlankBundle();
    AVAudioSession *session=AVAudioSession.sharedInstance;
    __block NSUInteger hostEvents=0, finished=0, failed=0;
    __block BOOL hostReleased=NO;
    NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
    id hostObserver=[center addObserverForName:CSBackgroundRunHostAudioChangedNotification object:nil queue:nil usingBlock:^(NSNotification *note){ hostEvents++; hostReleased=[note.userInfo[@"released"] boolValue]; }];
    id finishedObserver=[center addObserverForName:CSBackgroundRunPlaybackFinishedNotification object:nil queue:nil usingBlock:^(NSNotification *note){ CHECK(note.object==audio); finished++; }];
    id failedObserver=[center addObserverForName:CSBackgroundRunPlaybackFailedNotification object:nil queue:nil usingBlock:^(NSNotification *note){ CHECK(note.object==audio); failed++; }];

    // The production adapter uses the host bundle resource, a muted one-shot
    // player, and the production audio-hook bodies without claiming host work.
    audio=[CSBackgroundRunAudio new];
    // Delivery starts disabled, including failures that still unwind tracking.
    // A failed category write leaves the initial, unobserved activation state.
    session.failCategory=YES; NSError *nativeFailure=nil;
    CHECK(![session setCategory:AVAudioSessionCategoryPlayAndRecord error:&nativeFailure] && nativeFailure.code==10);
    Drain(); CHECK(!hostEvents && !audio.hostBusy);
    session.failCategory=NO;
    [audio setHostNotificationsEnabled:YES];
    CHECK([audio startWithError:NULL] && audio.playing && audio.sessionOwned && session.active && !audio.hostBusy);
    CHECK([CSTestLastPlayerURL.path isEqual:@"/host/WeChat.app/blank.caf"]);
    CHECK(CSTestLastPlayer.numberOfLoops==0 && CSTestLastPlayer.volume==0);
    CHECK(CSTestPlayerCreates==1 && CSTestPlayersAlive==1 && CSTestBlankResourceLookups==1);
    NSUInteger configurations=session.configurations, activations=session.activations, deactivations=session.deactivations;
    CHECK([audio startWithError:NULL] && CSTestPlayerCreates==1);
    Drain(); CHECK(!hostEvents);

    // Before any native activation has been observed, a failed host write
    // cannot revoke our valid lease or turn its original snapshot into Playback.
    session.failCategory=YES; nativeFailure=nil;
    CHECK(![session setCategory:AVAudioSessionCategoryPlayAndRecord error:&nativeFailure] && nativeFailure.code==10);
    Drain();
    CHECK(audio.playing && audio.sessionOwned && !audio.hostBusy && hostReleased);
    session.failCategory=NO; configurations=session.configurations;

    // Finishing a short pulse is normal, preserves the original snapshot and
    // lease, and does not deactivate or rewrite the category between pulses.
    AVAudioPlayer *oldPlayer=CSTestLastPlayer;
    Finish(YES);
    CHECK(!audio.playing && audio.sessionOwned && session.active && finished==1 && !failed);
    CHECK(session.deactivations==deactivations && CSTestPlayersAlive==1); // retained only by this test
    oldPlayer=nil; CHECK(!CSTestPlayersAlive);
    CHECK([audio startWithError:NULL] && audio.playing && CSTestPlayerCreates==2 && CSTestBlankResourceLookups==1);
    CHECK(session.configurations==configurations && session.deactivations==deactivations && session.activations==activations+1);
    oldPlayer=CSTestLastPlayer;
    Finish(YES); CHECK(finished==2);
    CHECK([audio startWithError:NULL]);
    [(id<AVAudioPlayerDelegate>)audio audioPlayerDidFinishPlaying:oldPlayer successfully:NO];
    CHECK(audio.playing && finished==2 && !failed); // late callback from previous pulse
    oldPlayer=nil;
    [audio stop];
    CHECK(!audio.playing && !audio.sessionOwned && !session.active && !CSTestPlayersAlive);
    CHECK([session.category isEqual:AVAudioSessionCategoryAmbient]);

    // A denied native activation also preserves the existing player's lease
    // and the Ambient snapshot restored when this module later stops.
    Fresh(); CHECK([audio startWithError:NULL]);
    session.failActivation=YES; nativeFailure=nil;
    CHECK(![session setActive:YES error:&nativeFailure] && nativeFailure.code==11);
    Drain(); CHECK(audio.playing && audio.sessionOwned && !audio.hostBusy && hostReleased);
    session.failActivation=NO; [audio stop];
    CHECK(!session.active && [session.category isEqual:AVAudioSessionCategoryAmbient] && !session.categoryOptions);

    // Native cleanup is still a release if category/mode restoration follows
    // setActive:NO before the coalesced ownership notification is delivered.
    Fresh();
    [session setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [session setActive:YES error:NULL]; Drain(); CHECK(audio.hostBusy && !hostReleased);
    [session setActive:NO error:NULL];
    [session setMode:AVAudioSessionModeDefault error:NULL];
    [session setCategory:AVAudioSessionCategoryAmbient error:NULL];
    Drain(); CHECK(!audio.hostBusy && hostReleased);
    CHECK([audio startWithError:NULL] && audio.playing); [audio stop];

    // Older iOS versions can report IsBusy even though deactivation occurred.
    // Observe that specific outcome without changing the native BOOL or error.
    Fresh(); [session setActive:YES error:NULL]; Drain();
    session.failDeactivationWithBusy=YES; nativeFailure=nil;
    CHECK(![session setActive:NO withOptions:0 error:&nativeFailure]);
    CHECK([nativeFailure.domain isEqual:NSOSStatusErrorDomain] && nativeFailure.code==AVAudioSessionErrorCodeIsBusy);
    Drain(); CHECK(!session.active && !audio.hostBusy && hostReleased);
    session.failDeactivationWithBusy=NO;
    CHECK([audio startWithError:NULL] && audio.playing); [audio stop];

    // An unrelated deactivation failure does not prove that native audio ended.
    Fresh(); [session setActive:YES error:NULL]; Drain();
    session.failDeactivation=YES; nativeFailure=nil;
    CHECK(![session setActive:NO error:&nativeFailure] && nativeFailure.code==11);
    Drain(); CHECK(session.active && audio.hostBusy && !hostReleased);
    session.failDeactivation=NO; [session setActive:NO error:NULL]; Drain();

    // A media loss invalidates a prior native activation even if its category
    // still reads Playback. Reset can recover without another deactivation.
    Fresh();
    [session setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [session setActive:YES error:NULL]; Drain(); CHECK(audio.hostBusy);
    session.active=NO; [audio invalidateForMediaServicesLoss]; [audio resetAfterMediaServicesReset];
    CHECK(!audio.hostBusy && !audio.sessionOwned);
    CHECK([audio startWithError:NULL] && audio.playing); [audio stop];

    // A pre-reset activation completing afterward cannot resurrect stale host
    // ownership; its in-flight count must still balance before the next borrow.
    Fresh();
    __weak AVAudioSession *resetSession=session;
    session.activationAction=^{ resetSession.active=NO; [audio resetAfterMediaServicesReset]; };
    CHECK([session setActive:YES error:NULL]); Drain();
    CHECK(!session.active && !audio.hostBusy);
    CHECK([audio startWithError:NULL] && audio.playing); [audio stop];

    // WeChat may restore audio before our Reset observer runs. A successful
    // post-Lost activation must survive and continue blocking our own player.
    Fresh(); [audio invalidateForMediaServicesLoss];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
    [session setActive:YES error:NULL];
    [audio resetAfterMediaServicesReset]; Drain();
    CHECK(audio.hostBusy && session.active && !hostReleased);
    CHECK(![audio startWithError:NULL] && !audio.playing);
    CHECK([session.category isEqual:AVAudioSessionCategoryPlayAndRecord] && session.active);
    [session setActive:NO error:NULL]; Drain();
    CHECK(!audio.hostBusy && [audio startWithError:NULL]); [audio stop];

    // A fresh activation can also still be in flight across our Reset observer.
    // It belongs to the post-Lost generation and must keep its completion.
    Fresh(); [audio invalidateForMediaServicesLoss];
    session.activationAction=^{ [audio resetAfterMediaServicesReset]; };
    [session setActive:YES error:NULL]; Drain();
    CHECK(session.active && audio.hostBusy && !hostReleased);
    [session setActive:NO error:NULL]; Drain(); CHECK(!audio.hostBusy);

    // Without a preceding Lost there is no public active getter or boundary
    // identifying a host's activation as stale. Conservatively retain it.
    Fresh(); [session setActive:YES error:NULL]; Drain();
    [audio resetAfterMediaServicesReset];
    CHECK(audio.hostBusy && ![audio startWithError:NULL] && session.active);
    [session setActive:NO error:NULL]; Drain();
    CHECK(!audio.hostBusy && [audio startWithError:NULL]); [audio stop];

    // A missing host resource fails before changing the audio session. No
    // generated or bundled replacement is substituted.
    Fresh(); CSTestBlankResourceAvailable=NO;
    configurations=session.configurations; activations=session.activations;
    NSUInteger resourceLookups=CSTestBlankResourceLookups;
    NSError *error=nil;
    CHECK(![audio startWithError:&error] && [error.localizedDescription containsString:@"blank.caf"]);
    CHECK(!audio.playing && !audio.sessionOwned && !session.active && !CSTestPlayersAlive);
    CHECK(session.configurations==configurations && session.activations==activations);
    CHECK(CSTestBlankResourceLookups==resourceLookups+1);
    CHECK(![audio startWithError:&error] && CSTestBlankResourceLookups==resourceLookups+2);
    CHECK(session.configurations==configurations && session.activations==activations);
    CSTestBlankResourceAvailable=YES;
    CHECK([audio startWithError:NULL] && audio.playing && CSTestBlankResourceLookups==resourceLookups+3);
    [audio stop];

    // Other apps' primary audio may coexist with our muted, mixable pulse.
    Fresh(); session.secondaryAudioShouldBeSilencedHint=YES;
    configurations=session.configurations; activations=session.activations;
    CHECK([audio startWithError:NULL] && audio.playing && audio.sessionOwned && session.active);
    CHECK([session.category isEqual:AVAudioSessionCategoryPlayback] && [session.mode isEqual:AVAudioSessionModeDefault]);
    CHECK(session.categoryOptions==AVAudioSessionCategoryOptionMixWithOthers && CSTestLastPlayer.volume==0);
    CHECK(session.configurations==configurations+1 && session.activations==activations+1);
    [audio stop];
    CHECK(!audio.playing && !audio.sessionOwned && !session.active && !CSTestPlayersAlive);
    CHECK([session.category isEqual:AVAudioSessionCategoryAmbient] && !session.categoryOptions);

    // Failure at each resource boundary releases the player and only our own
    // session lease, without replacing errors returned by native setters.
    for (NSUInteger failure=0;failure<5;failure++) {
        Fresh();
        resourceLookups=CSTestBlankResourceLookups;
        CSTestFailPlayerCreation=failure==0;
        session.failCategory=failure==1; session.failActivation=failure==2;
        CSTestFailPlayerPreparation=failure==3; CSTestFailPlayerPlay=failure==4;
        error=nil;
        CHECK(![audio startWithError:&error] && error);
        CHECK(!audio.playing && !audio.sessionOwned && !session.active && !CSTestPlayersAlive);
        CHECK(CSTestBlankResourceLookups==resourceLookups+1);
        // A valid URL is metadata, not a cached playback/activation outcome.
        // Retrying after any of these failures must create a fresh player.
        NSUInteger playerCreates=CSTestPlayerCreates;
        CSTestFailPlayerCreation=CSTestFailPlayerPreparation=CSTestFailPlayerPlay=NO;
        session.failCategory=session.failActivation=NO;
        CHECK([audio startWithError:NULL] && audio.playing && CSTestPlayerCreates==playerCreates+1);
        CHECK(CSTestBlankResourceLookups==resourceLookups+1);
        [audio stop];
    }

    // Host voice/recording ownership wins even when a pulse is already playing.
    Fresh(); CHECK([audio startWithError:NULL]);
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        [session setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
        [session setActive:YES error:NULL];
    });
    deactivations=session.deactivations;
    CHECK(!audio.sessionOwned && audio.hostBusy);
    [audio relinquish];
    CHECK(!audio.playing && session.active && session.deactivations==deactivations);
    CHECK([session.category isEqual:AVAudioSessionCategoryPlayAndRecord] && [session.mode isEqual:@"VoiceChat"] && session.categoryOptions==4);
    CHECK(![audio startWithError:NULL] && session.active && session.deactivations==deactivations);

    // A same-value host write transfers ownership synchronously. A later stop
    // must not deactivate or restore a snapshot over the new owner's session.
    Fresh(); CHECK([audio startWithError:NULL]);
    [session setCategory:session.category mode:session.mode options:session.categoryOptions error:NULL];
    CHECK(!audio.sessionOwned);
    deactivations=session.deactivations; configurations=session.configurations;
    [audio stop];
    CHECK(session.active && session.deactivations==deactivations && session.configurations==configurations);

    // Native takeover during activation invalidates the lease before play or
    // cleanup; it cannot deactivate the newly active native call.
    Fresh(); __weak AVAudioSession *weakSession=session;
    session.activationAction=^{ dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        [weakSession setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
        [weakSession setActive:YES error:NULL];
    }); };
    deactivations=session.deactivations;
    CHECK(![audio startWithError:NULL] && !audio.playing && session.active && session.deactivations==deactivations);
    CHECK([session.category isEqual:AVAudioSessionCategoryPlayAndRecord] && !CSTestPlayersAlive);

    // Suspension retains the lease but treats the OS-deactivated session as
    // inactive; the manager controls whether a permitted resume reaches start.
    Fresh(); CHECK([audio startWithError:NULL]);
    session.active=NO; [audio suspend];
    CHECK(!audio.playing && audio.sessionOwned && !CSTestPlayersAlive);
    configurations=session.configurations;
    CHECK([audio startWithError:NULL] && audio.playing && session.configurations==configurations);
    Finish(NO); CHECK(!audio.playing && audio.sessionOwned && failed==1 && finished==2);
    [audio stop]; CHECK(!session.active && !CSTestPlayersAlive);

    // Native errors/throws remain observable and never leave the hook's thread
    // local scope stuck, including nested category and active variants.
    Fresh(); session.failCategory=YES; error=nil;
    CHECK(![session setCategory:AVAudioSessionCategoryPlayback error:&error] && error.code==10);
    session.failCategory=NO; session.throwCategory=YES; BOOL caught=NO;
    @try { [session setCategory:AVAudioSessionCategoryPlayback error:NULL]; } @catch (NSException *exception) { caught=YES; }
    CHECK(caught); session.throwCategory=NO;
    [session setActive:YES error:NULL]; Drain(); CHECK(audio.hostBusy);
    [session setActive:NO error:NULL]; Drain(); CHECK(!audio.hostBusy);

    // A failed deactivation must not reconfigure a session still in use.
    Fresh(); CHECK([audio startWithError:NULL]); session.failDeactivation=YES;
    configurations=session.configurations; [audio stop];
    CHECK(!audio.playing && session.active && session.configurations==configurations);
    session.failDeactivation=NO;

    // A check may land inside a native setter that ultimately fails. Pausing
    // and a rejected start must retain the original Ambient snapshot until its
    // tracked call completes, then allow the same lease to resume and restore.
    Fresh(); CHECK([audio startWithError:NULL]);
    NSUInteger failureEvents=hostEvents;
    CHECK(CSBackgroundRunAudioWillChange());
    [audio relinquish]; CHECK(!audio.playing && audio.hostBusy && !audio.sessionOwned);
    error=nil; CHECK(![audio startWithError:&error] && error.code==1);
    CSBackgroundRunAudioDidChange(NO,NO,NO); Drain();
    CHECK(!audio.hostBusy && audio.sessionOwned && hostEvents==failureEvents+1 && hostReleased);
    CHECK([audio startWithError:NULL] && audio.playing);
    [audio stop];
    CHECK(!session.active && [session.category isEqual:AVAudioSessionCategoryAmbient] && !session.categoryOptions);

    // The corresponding successful native write revokes the pending lease.
    // Cleanup must leave the host's configuration and active session untouched.
    Fresh(); CHECK([audio startWithError:NULL]);
    CHECK(CSBackgroundRunAudioWillChange()); [audio relinquish];
    CHECK(![audio startWithError:NULL]);
    CHECK([session setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL]);
    CSBackgroundRunAudioDidChange(YES,NO,NO); Drain();
    CHECK(!audio.sessionOwned);
    configurations=session.configurations; deactivations=session.deactivations;
    [audio stop];
    CHECK(session.active && session.configurations==configurations && session.deactivations==deactivations);
    CHECK([session.category isEqual:AVAudioSessionCategoryPlayAndRecord] && [session.mode isEqual:@"VoiceChat"] && session.categoryOptions==4);

    // Idle delivery never disables ownership tracking, including native calls
    // from another thread. Enabling first exposes the latest state immediately
    // without synthesizing a notification for work completed while idle.
    Fresh(); [audio setHostNotificationsEnabled:NO];
    NSUInteger idleEvents=hostEvents;
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        [session setCategory:AVAudioSessionCategoryPlayAndRecord mode:@"VoiceChat" options:4 error:NULL];
        [session setActive:YES error:NULL];
    });
    Drain(); CHECK(hostEvents==idleEvents && audio.hostBusy && session.active);
    [audio setHostNotificationsEnabled:YES];
    CHECK(audio.hostBusy); Drain(); CHECK(hostEvents==idleEvents);
    [session setActive:NO error:NULL];
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    Drain(); CHECK(hostEvents==idleEvents+1 && hostReleased && !audio.hostBusy);

    // A notification already queued while interested is suppressed if demand
    // ends before delivery. Native release while disabled is still observable
    // as soon as a new demand enables delivery and reads hostBusy.
    Fresh(); idleEvents=hostEvents;
    [session setActive:YES error:NULL];
    [audio setHostNotificationsEnabled:NO];
    Drain(); CHECK(hostEvents==idleEvents && audio.hostBusy);
    [session setActive:NO error:NULL];
    Drain(); CHECK(hostEvents==idleEvents && !audio.hostBusy);
    [audio setHostNotificationsEnabled:YES];
    CHECK(!audio.hostBusy); Drain(); CHECK(hostEvents==idleEvents);
    [session setActive:YES error:NULL];
    Drain(); CHECK(hostEvents==idleEvents+1 && !hostReleased && audio.hostBusy);

    // Even a same-value write while idle revokes our lease synchronously.
    // Later cleanup must leave the native owner's active session untouched.
    Fresh(); CHECK([audio startWithError:NULL]);
    [audio setHostNotificationsEnabled:NO]; idleEvents=hostEvents;
    [session setCategory:session.category mode:session.mode options:session.categoryOptions error:NULL];
    CHECK(!audio.sessionOwned);
    configurations=session.configurations; deactivations=session.deactivations;
    [audio stop]; Drain();
    CHECK(hostEvents==idleEvents && session.active && session.configurations==configurations && session.deactivations==deactivations);

    // A native call can start while idle and finish after renewed demand. Its
    // failed completion must still publish the in-flight release opportunity.
    Fresh(); [audio setHostNotificationsEnabled:NO];
    CHECK(CSBackgroundRunAudioWillChange());
    [audio setHostNotificationsEnabled:YES]; CHECK(audio.hostBusy);
    failureEvents=hostEvents;
    CSBackgroundRunAudioDidChange(NO,NO,NO); Drain();
    CHECK(hostEvents==failureEvents+1 && hostReleased && !audio.hostBusy);

    // Media loss/reset destroys the active audio object and lease. Only the
    // successful bundle URL survives; recovery and a later cycle use new players.
    Fresh(); resourceLookups=CSTestBlankResourceLookups;
    NSUInteger playerCreates=CSTestPlayerCreates;
    CHECK([audio startWithError:NULL] && CSTestBlankResourceLookups==resourceLookups+1);
    __weak AVAudioPlayer *preResetPlayer=CSTestLastPlayer;
    session.active=NO;
    [audio invalidateForMediaServicesLoss];
    CHECK(preResetPlayer==nil && !audio.playing && !audio.sessionOwned && !CSTestPlayersAlive);
    [audio resetAfterMediaServicesReset];
    CHECK([audio startWithError:NULL] && audio.playing && CSTestPlayerCreates==playerCreates+2);
    CHECK(CSTestBlankResourceLookups==resourceLookups+1);
    [audio stop]; CHECK(!CSTestPlayersAlive);
    CHECK([audio startWithError:NULL] && CSTestPlayerCreates==playerCreates+3 && CSTestBlankResourceLookups==resourceLookups+1);

    Fresh(); [audio setHostNotificationsEnabled:NO]; [audio stop]; audio=nil; Drain(); CHECK(!CSTestPlayersAlive);
    [center removeObserver:hostObserver]; [center removeObserver:finishedObserver]; [center removeObserver:failedObserver];
    printf("Background audio: %lu checks passed; blank.caf pulses, completion and native ownership verified\n",(unsigned long)checks);
} return 0; }
