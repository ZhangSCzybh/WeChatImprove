#import <Foundation/Foundation.h>
#import "CSAIBackgroundSync.h"
#import <math.h>

static NSUInteger checks;
#define CHECK(c) do { checks++; if(!(c)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)
@interface CSAIBackgroundSync (Testing)
- (void)tick:(NSTimer *)timer;
@end
static NSTimer *Timer(CSAIBackgroundSync *scheduler) { return [scheduler valueForKey:@"timer"]; }
static void Fire(CSAIBackgroundSync *scheduler) { [Timer(scheduler) fire]; }
// Foundation reports timeInterval == 0 for a non-repeating timer. Inspect its
// scheduled fire date to verify the delay; the scheduler's decision uses uptime.
static BOOL DelayIs(NSTimer *timer,NSTimeInterval delay) { return timer.valid && fabs([timer.fireDate timeIntervalSinceNow]-delay)<1; }

static void EligibilityAndCadence(void) {
    __block BOOL eligible=NO;__block NSUInteger attempts=0;__block NSTimeInterval now=100;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return eligible;} synchronize:^{CHECK(NSThread.isMainThread);attempts++;}];
    scheduler.now=^NSTimeInterval{return now;};
    [scheduler refresh];CHECK(!scheduler.active && !attempts);
    eligible=YES;[scheduler refresh];CHECK(scheduler.active && attempts==1);
    NSTimer *first=Timer(scheduler);CHECK(first.timeInterval==0 && first.tolerance==3 && DelayIs(first,45));
    for(NSUInteger i=0;i<50;i++)[scheduler refresh];CHECK(Timer(scheduler)==first && attempts==1);
    Fire(scheduler);CHECK(scheduler.active && Timer(scheduler)!=first && !first.valid && attempts==1);
    now=144.999;Fire(scheduler);CHECK(attempts==1 && scheduler.active);
    now=145;Fire(scheduler);CHECK(attempts==2 && scheduler.active && DelayIs(Timer(scheduler),45));
    now=10000;Fire(scheduler);CHECK(attempts==3);
    for(NSUInteger i=0;i<50;i++)Fire(scheduler);CHECK(attempts==3 && scheduler.active); // No catch-up loop after a delayed tick.
    eligible=NO;Fire(scheduler);CHECK(!scheduler.active && !first.valid && attempts==3);
    now=10045;eligible=YES;[scheduler refresh];CHECK(scheduler.active && attempts==4);
    eligible=NO;[scheduler refresh];CHECK(!scheduler.active && attempts==4);
}
static void StopRestartAndStaleTimers(void) {
    __block NSTimeInterval now=100;__block NSUInteger attempts=0;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{attempts++;}];scheduler.now=^NSTimeInterval{return now;};
    [scheduler refresh];NSTimer *first=Timer(scheduler);CHECK(attempts==1);
    [scheduler stop];[scheduler stop];CHECK(!scheduler.active && !first.valid);
    now=110;[scheduler refresh];NSTimer *second=Timer(scheduler);CHECK(second!=first && scheduler.active && attempts==1 && DelayIs(second,35));
    now=145;[scheduler tick:first];CHECK(attempts==1 && Timer(scheduler)==second);
    NSTimer *foreign=[NSTimer timerWithTimeInterval:45 repeats:NO block:^(__unused NSTimer *timer){}];[scheduler tick:foreign];CHECK(attempts==1);[foreign invalidate];
    Fire(scheduler);CHECK(attempts==2);
    [scheduler stop];now=146;[scheduler refresh];CHECK(attempts==2 && DelayIs(Timer(scheduler),44));
    now=190;Fire(scheduler);CHECK(attempts==3);
    [scheduler stop];
}
static void ReentryAndRejectedAttempts(void) {
    __block NSTimeInterval now=100;__block NSUInteger attempts=0,accepted=0;__block BOOL busy=YES;
    __block __weak CSAIBackgroundSync *weakScheduler;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{
        attempts++;if(!busy)accepted++;
        [weakScheduler refresh];Fire(weakScheduler);
    }];weakScheduler=scheduler;scheduler.now=^NSTimeInterval{return now;};
    [scheduler refresh];CHECK(attempts==1 && !accepted);
    busy=NO;now=144;Fire(scheduler);CHECK(attempts==1 && !accepted && scheduler.active);
    now=145;Fire(scheduler);CHECK(attempts==2 && accepted==1 && scheduler.active);
    [scheduler stop];
    // Reentrant stop/restart cannot erase an attempt reserved before the native call.
    attempts=0;now=200;
    scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{attempts++;[weakScheduler stop];[weakScheduler refresh];}];
    weakScheduler=scheduler;scheduler.now=^NSTimeInterval{return now;};[scheduler refresh];CHECK(attempts==1 && scheduler.active);
    now=245;Fire(scheduler);CHECK(attempts==2 && scheduler.active);[scheduler stop];
}
static void InvalidTimeAndRelease(void) {
    __block NSTimeInterval now=NAN;__block NSUInteger attempts=0;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{attempts++;}];scheduler.now=^NSTimeInterval{return now;};
    [scheduler refresh];CHECK(scheduler.active && !attempts);
    now=INFINITY;Fire(scheduler);now=-INFINITY;Fire(scheduler);CHECK(!attempts && scheduler.active);
    now=100;Fire(scheduler);CHECK(attempts==1);
    now=90;Fire(scheduler);CHECK(attempts==1 && DelayIs(Timer(scheduler),55));
    now=NAN;Fire(scheduler);CHECK(attempts==1 && scheduler.active);
    NSTimer *unchanged=Timer(scheduler);[scheduler verifiedFullSyncCompleted];CHECK(Timer(scheduler)==unchanged);
    now=INFINITY;[scheduler verifiedFullSyncCompleted];CHECK(Timer(scheduler)==unchanged);
    now=144;Fire(scheduler);CHECK(attempts==1);now=145;Fire(scheduler);CHECK(attempts==2);
    __weak CSAIBackgroundSync *weak=scheduler;NSTimer *timer=Timer(scheduler);scheduler=nil;
    CHECK(!weak && !timer.valid);[timer fire];CHECK(attempts==2);
}
static void RevocationInsideBoundaries(void) {
    __block NSUInteger attempts=0;__block BOOL revokeEligibility=NO,revokeClock=NO;__block NSTimeInterval now=100;
    __block __weak CSAIBackgroundSync *weak;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{if(revokeEligibility)[weak stop];return YES;} synchronize:^{attempts++;}];weak=scheduler;
    scheduler.now=^NSTimeInterval{if(revokeClock)[weak stop];return now;};[scheduler refresh];CHECK(attempts==1);
    now=145;revokeEligibility=YES;Fire(scheduler);CHECK(attempts==1 && !scheduler.active);
    revokeEligibility=NO;[scheduler refresh];CHECK(attempts==2 && scheduler.active);
    now=190;revokeClock=YES;Fire(scheduler);CHECK(attempts==2 && !scheduler.active);
    revokeClock=NO;[scheduler refresh];CHECK(attempts==3 && scheduler.active);[scheduler stop];
}
static void VerifiedCoverageAndInvalidation(void) {
    __block NSTimeInterval now=100;__block NSUInteger attempts=0;__block BOOL eligible=YES;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return eligible;} synchronize:^{attempts++;}];scheduler.now=^NSTimeInterval{return now;};
    [scheduler verifiedFullSyncCompleted];CHECK(!scheduler.active); // Completion cannot start a stopped scheduler.
    [scheduler refresh];CHECK(attempts==1 && scheduler.active);
    NSTimer *old=Timer(scheduler);now=120;[scheduler verifiedFullSyncCompleted];
    CHECK(attempts==1 && !old.valid && DelayIs(Timer(scheduler),45));
    now=145;[scheduler tick:old];CHECK(attempts==1);
    Fire(scheduler);CHECK(attempts==1 && scheduler.active && DelayIs(Timer(scheduler),20));
    now=164.999;Fire(scheduler);CHECK(attempts==1 && scheduler.active);
    now=165;Fire(scheduler);CHECK(attempts==2 && scheduler.active);
    now=170;[scheduler verifiedFullSyncCompleted];now=175;[scheduler verifiedFullSyncCompleted];
    CHECK(attempts==2 && DelayIs(Timer(scheduler),45));
    now=200;[scheduler invalidateVerifiedSync];CHECK(attempts==2 && DelayIs(Timer(scheduler),10));
    now=209.999;Fire(scheduler);CHECK(attempts==2);
    now=210;Fire(scheduler);CHECK(attempts==3);
    // Account/configuration coverage revocation never clears attempt cooldown.
    now=220;[scheduler verifiedFullSyncCompleted];now=230;[scheduler invalidateVerifiedSync];
    CHECK(attempts==3 && DelayIs(Timer(scheduler),25));
    now=255;Fire(scheduler);CHECK(attempts==4);
    // An already-expired cooldown gets one immediate deadline, no inline sync.
    now=260;[scheduler verifiedFullSyncCompleted];now=305;[scheduler invalidateVerifiedSync];
    CHECK(attempts==4 && scheduler.active && DelayIs(Timer(scheduler),0));
    Fire(scheduler);CHECK(attempts==5 && DelayIs(Timer(scheduler),45));
    now=310;[scheduler verifiedFullSyncCompleted];old=Timer(scheduler);
    now=300;[scheduler verifiedFullSyncCompleted];CHECK(Timer(scheduler)==old); // Clock regression cannot shorten coverage.
    now=320;[scheduler stop];[scheduler refresh];CHECK(attempts==5 && DelayIs(Timer(scheduler),35));
    now=355;Fire(scheduler);CHECK(attempts==6); // Valid coverage survives a short stop, not indefinitely.
    now=360;[scheduler verifiedFullSyncCompleted];eligible=NO;[scheduler verifiedFullSyncCompleted];CHECK(!scheduler.active);
    now=400;[scheduler verifiedFullSyncCompleted];[scheduler invalidateVerifiedSync];CHECK(!scheduler.active && attempts==6);
    eligible=YES;[scheduler refresh];CHECK(attempts==7 && scheduler.active);[scheduler stop];
}
static void CompletionReentryAndFailures(void) {
    __block NSTimeInterval now=100;__block NSUInteger attempts=0;
    __block __weak CSAIBackgroundSync *weak;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{
        attempts++;[weak verifiedFullSyncCompleted];[weak refresh];Fire(weak);
    }];weak=scheduler;scheduler.now=^NSTimeInterval{return now;};
    [scheduler refresh];CHECK(attempts==1 && scheduler.active);
    now=145;Fire(scheduler);CHECK(attempts==2 && scheduler.active);[scheduler stop];
    __block BOOL invalidateInsideClock=NO,stopInsideClock=NO;
    scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{attempts++;}];weak=scheduler;
    scheduler.now=^NSTimeInterval{
        if(invalidateInsideClock){invalidateInsideClock=NO;[weak invalidateVerifiedSync];}
        if(stopInsideClock){stopInsideClock=NO;[weak stop];}
        return now;
    };
    now=200;[scheduler refresh];CHECK(attempts==3);
    now=220;invalidateInsideClock=YES;[scheduler verifiedFullSyncCompleted];
    CHECK(DelayIs(Timer(scheduler),25) && ![[scheduler valueForKey:@"verifiedSync"] boolValue]);
    now=245;Fire(scheduler);CHECK(attempts==4);
    now=260;stopInsideClock=YES;[scheduler verifiedFullSyncCompleted];CHECK(!scheduler.active);
    [scheduler refresh];CHECK(scheduler.active && attempts==4);[scheduler stop];
    // Even a throwing native boundary leaves its reserved budget and one timer.
    now=300;attempts=0;
    scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{attempts++;[NSException raise:@"fixture" format:@"native rejection"]; }];scheduler.now=^NSTimeInterval{return now;};
    @try{[scheduler refresh];CHECK(NO);}@catch(NSException *exception){CHECK([exception.name isEqual:@"fixture"]);}
    CHECK(attempts==1 && scheduler.active && DelayIs(Timer(scheduler),45));
    now=344;Fire(scheduler);CHECK(attempts==1 && scheduler.active);
    now=345;@try{Fire(scheduler);CHECK(NO);}@catch(NSException *exception){CHECK([exception.name isEqual:@"fixture"]);}
    CHECK(attempts==2 && scheduler.active);[scheduler stop];
}
static void FallbackToggleDeadlines(void) {
    __block NSTimeInterval now=100;__block NSUInteger attempts=0,eligibilityReads=0;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{eligibilityReads++;return YES;} synchronize:^{attempts++;}];scheduler.now=^{return now;};
    CHECK(scheduler.fallbackEnabled && !scheduler.active);
    scheduler.fallbackEnabled=NO;[scheduler refresh];[scheduler verifiedFullSyncCompleted];
    CHECK(!scheduler.active && !Timer(scheduler) && !attempts && !eligibilityReads);
    scheduler.fallbackEnabled=YES;CHECK(!scheduler.active && !Timer(scheduler) && !attempts);
    [scheduler refresh];CHECK(scheduler.active && attempts==1 && DelayIs(Timer(scheduler),45));
    now=120;[scheduler verifiedFullSyncCompleted];NSTimer *covered=Timer(scheduler);CHECK(DelayIs(covered,45));
    now=125;scheduler.fallbackEnabled=NO;CHECK(!scheduler.active && !Timer(scheduler) && !covered.valid);
    now=130;[scheduler refresh];[scheduler verifiedFullSyncCompleted];[scheduler tick:covered];
    CHECK(!scheduler.active && !Timer(scheduler) && attempts==1);
    // Direct toggles preserve valid coverage as well as the attempt budget.
    scheduler.fallbackEnabled=YES;CHECK(!scheduler.active && attempts==1);
    [scheduler refresh];CHECK(scheduler.active && attempts==1 && DelayIs(Timer(scheduler),35) && Timer(scheduler).tolerance==3);
    now=145;Fire(scheduler);CHECK(attempts==1 && DelayIs(Timer(scheduler),20));
    now=164.999;Fire(scheduler);CHECK(attempts==1);now=165;Fire(scheduler);CHECK(attempts==2);
    now=170;scheduler.fallbackEnabled=NO;[scheduler invalidateVerifiedSync];[scheduler refresh];
    CHECK(!scheduler.active && !Timer(scheduler) && attempts==2);
    now=180;scheduler.fallbackEnabled=YES;[scheduler refresh];CHECK(attempts==2 && DelayIs(Timer(scheduler),30));
    // Repeated assignments and a stale timer cannot spend another budget.
    NSTimer *current=Timer(scheduler);scheduler.fallbackEnabled=YES;[scheduler refresh];[scheduler tick:covered];
    CHECK(Timer(scheduler)==current && attempts==2);
    now=209.999;Fire(scheduler);CHECK(attempts==2);now=210;Fire(scheduler);CHECK(attempts==3);
    scheduler.fallbackEnabled=NO;now=1000;[scheduler refresh];[scheduler verifiedFullSyncCompleted];CHECK(!scheduler.active && attempts==3);
    scheduler.fallbackEnabled=YES;CHECK(!scheduler.active && attempts==3);[scheduler refresh];CHECK(scheduler.active && attempts==4);[scheduler stop];
}
static void FallbackToggleReentry(void) {
    for(NSUInteger boundary=0;boundary<3;boundary++){
        __block NSTimeInterval now=100;__block NSUInteger attempts=0;__block BOOL disable=NO;
        __block __weak CSAIBackgroundSync *weak;
        CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{
            if(disable && boundary==0){disable=NO;weak.fallbackEnabled=NO;}return YES;
        } synchronize:^{
            attempts++;
            if(disable && boundary==2){
                disable=NO;weak.fallbackEnabled=NO;[weak refresh];[weak verifiedFullSyncCompleted];
                CHECK(!weak.active && !Timer(weak));weak.fallbackEnabled=YES;[weak refresh];
            }
        }];weak=scheduler;scheduler.now=^{if(disable && boundary==1){disable=NO;weak.fallbackEnabled=NO;}return now;};
        [scheduler refresh];CHECK(attempts==1 && scheduler.active);
        NSTimer *stale=Timer(scheduler);now=145;disable=YES;Fire(scheduler);
        if(boundary<2){
            CHECK(attempts==1 && !scheduler.active && !scheduler.fallbackEnabled && !Timer(scheduler));
            [scheduler refresh];[scheduler verifiedFullSyncCompleted];[scheduler tick:stale];CHECK(attempts==1 && !scheduler.active);
            scheduler.fallbackEnabled=YES;[scheduler refresh];CHECK(attempts==2 && scheduler.active);
        }else CHECK(attempts==2 && scheduler.active && DelayIs(Timer(scheduler),45));
        now=189.999;Fire(scheduler);CHECK(attempts==2);now=190;Fire(scheduler);CHECK(attempts==3);[scheduler stop];
    }
}
int main(void) { @autoreleasepool {
    EligibilityAndCadence();StopRestartAndStaleTimers();ReentryAndRejectedAttempts();InvalidTimeAndRelease();RevocationInsideBoundaries();VerifiedCoverageAndInvalidation();CompletionReentryAndFailures();
    FallbackToggleDeadlines();FallbackToggleReentry();
    printf("AI background sync scheduler: %lu checks passed; 45-second one-shot deadlines, verified coverage, revocation, cooldown, stale/early timers, reentry, failed attempts, finite time and release\n",(unsigned long)checks);
} return 0; }
