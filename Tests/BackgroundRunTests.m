#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CSBackgroundRunAudio.h"

static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
static CSBackgroundRunAudio *audio;
static void Drain(void) { for (NSUInteger i=0;i<4;i++) [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.005]]; }
static void Fresh(void) {
    [audio stop]; audio=nil;
    AVAudioSession *session=AVAudioSession.sharedInstance;
    session.failCategory=session.failActivation=session.failDeactivation=session.throwCategory=NO;
    session.secondaryAudioShouldBeSilencedHint=NO; session.activationAction=nil;
    CSTestFailPlayerCreation=CSTestFailPlayerPreparation=CSTestFailPlayerPlay=NO;
    CSTestBlankResourceAvailable=YES;
    [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionModeDefault options:0 error:NULL];
    [session setActive:NO error:NULL]; Drain();
    audio=[CSBackgroundRunAudio new];
}
static void Finish(BOOL success) { [CSTestLastPlayer finishSuccessfully:success]; }
int main(void) { @autoreleasepool {
    CSTestInstallBlankBundle();
    AVAudioSession *session=AVAudioSession.sharedInstance;
    __block NSUInteger hostEvents=0, finished=0, failed=0;
    NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
    id hostObserver=[center addObserverForName:CSBackgroundRunHostAudioChangedNotification object:nil queue:nil usingBlock:^(NSNotification *note){ hostEvents++; }];
    id finishedObserver=[center addObserverForName:CSBackgroundRunPlaybackFinishedNotification object:nil queue:nil usingBlock:^(NSNotification *note){ CHECK(note.object==audio); finished++; }];
    id failedObserver=[center addObserverForName:CSBackgroundRunPlaybackFailedNotification object:nil queue:nil usingBlock:^(NSNotification *note){ CHECK(note.object==audio); failed++; }];

    // The production adapter uses the host bundle resource, a muted one-shot
    // player, and the production audio-hook bodies without claiming host work.
    audio=[CSBackgroundRunAudio new];
    CHECK([audio startWithError:NULL] && audio.playing && audio.sessionOwned && session.active && !audio.hostBusy);
    CHECK([CSTestLastPlayerURL.path isEqual:@"/host/WeChat.app/blank.caf"]);
    CHECK(CSTestLastPlayer.numberOfLoops==0 && CSTestLastPlayer.volume==0);
    CHECK(CSTestPlayerCreates==1 && CSTestPlayersAlive==1);
    NSUInteger configurations=session.configurations, activations=session.activations, deactivations=session.deactivations;
    CHECK([audio startWithError:NULL] && CSTestPlayerCreates==1);
    Drain(); CHECK(!hostEvents);

    // Finishing a short pulse is normal, preserves the original snapshot and
    // lease, and does not deactivate or rewrite the category between pulses.
    AVAudioPlayer *oldPlayer=CSTestLastPlayer;
    Finish(YES);
    CHECK(!audio.playing && audio.sessionOwned && session.active && finished==1 && !failed);
    CHECK(session.deactivations==deactivations && CSTestPlayersAlive==1); // retained only by this test
    oldPlayer=nil; CHECK(!CSTestPlayersAlive);
    CHECK([audio startWithError:NULL] && audio.playing && CSTestPlayerCreates==2);
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

    // A missing host resource fails before changing the audio session. No
    // generated or bundled replacement is substituted.
    Fresh(); CSTestBlankResourceAvailable=NO;
    configurations=session.configurations; activations=session.activations;
    NSError *error=nil;
    CHECK(![audio startWithError:&error] && [error.localizedDescription containsString:@"blank.caf"]);
    CHECK(!audio.playing && !audio.sessionOwned && !session.active && !CSTestPlayersAlive);
    CHECK(session.configurations==configurations && session.activations==activations);

    // The secondary-audio hint is checked before category or activation writes.
    Fresh(); session.secondaryAudioShouldBeSilencedHint=YES;
    configurations=session.configurations; activations=session.activations;
    CHECK(![audio startWithError:NULL]);
    CHECK(session.configurations==configurations && session.activations==activations && !CSTestPlayersAlive);

    // Failure at each resource boundary releases the player and only our own
    // session lease, without replacing errors returned by native setters.
    for (NSUInteger failure=0;failure<5;failure++) {
        Fresh();
        CSTestFailPlayerCreation=failure==0;
        session.failCategory=failure==1; session.failActivation=failure==2;
        CSTestFailPlayerPreparation=failure==3; CSTestFailPlayerPlay=failure==4;
        error=nil;
        CHECK(![audio startWithError:&error] && error);
        CHECK(!audio.playing && !audio.sessionOwned && !session.active && !CSTestPlayersAlive);
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

    Fresh(); [audio stop]; audio=nil; Drain(); CHECK(!CSTestPlayersAlive);
    [center removeObserver:hostObserver]; [center removeObserver:finishedObserver]; [center removeObserver:failedObserver];
    printf("Background audio: %lu checks passed; blank.caf pulses, completion and native ownership verified\n",(unsigned long)checks);
} return 0; }
