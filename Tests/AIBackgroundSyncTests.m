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

static void EligibilityAndCadence(void) {
    __block BOOL eligible=NO;__block NSUInteger attempts=0;__block NSTimeInterval now=100;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return eligible;} synchronize:^{CHECK(NSThread.isMainThread);attempts++;}];
    scheduler.now=^NSTimeInterval{return now;};
    [scheduler refresh];CHECK(!scheduler.active && !attempts);
    eligible=YES;[scheduler refresh];CHECK(scheduler.active && attempts==1);
    NSTimer *first=Timer(scheduler);CHECK(first.valid && first.timeInterval==30);
    for(NSUInteger i=0;i<50;i++){[scheduler refresh];Fire(scheduler);}CHECK(Timer(scheduler)==first && attempts==1);
    now=129.999;Fire(scheduler);CHECK(attempts==1);
    now=130;Fire(scheduler);CHECK(attempts==2);
    now=10000;Fire(scheduler);CHECK(attempts==3);
    for(NSUInteger i=0;i<50;i++)Fire(scheduler);CHECK(attempts==3); // No catch-up loop after a delayed tick.
    eligible=NO;Fire(scheduler);CHECK(!scheduler.active && !first.valid && attempts==3);
    now=10030;eligible=YES;[scheduler refresh];CHECK(scheduler.active && attempts==4);
    eligible=NO;[scheduler refresh];CHECK(!scheduler.active && attempts==4);
}
static void StopRestartAndStaleTimers(void) {
    __block NSTimeInterval now=100;__block NSUInteger attempts=0;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{attempts++;}];scheduler.now=^NSTimeInterval{return now;};
    [scheduler refresh];NSTimer *first=Timer(scheduler);CHECK(attempts==1);
    [scheduler stop];[scheduler stop];CHECK(!scheduler.active && !first.valid);
    now=110;[scheduler refresh];NSTimer *second=Timer(scheduler);CHECK(second!=first && scheduler.active && attempts==1);
    now=130;[scheduler tick:first];CHECK(attempts==1 && Timer(scheduler)==second);
    NSTimer *foreign=[NSTimer timerWithTimeInterval:30 repeats:YES block:^(__unused NSTimer *timer){}];[scheduler tick:foreign];CHECK(attempts==1);[foreign invalidate];
    Fire(scheduler);CHECK(attempts==2);
    [scheduler stop];now=131;[scheduler refresh];CHECK(attempts==2);
    now=160;Fire(scheduler);CHECK(attempts==3);
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
    busy=NO;now=129;Fire(scheduler);CHECK(attempts==1 && !accepted);
    now=130;Fire(scheduler);CHECK(attempts==2 && accepted==1);
    [scheduler stop];
    // Reentrant stop/restart cannot erase an attempt reserved before the native call.
    attempts=0;now=200;
    scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{attempts++;[weakScheduler stop];[weakScheduler refresh];}];
    weakScheduler=scheduler;scheduler.now=^NSTimeInterval{return now;};[scheduler refresh];CHECK(attempts==1 && scheduler.active);
    now=230;Fire(scheduler);CHECK(attempts==2 && scheduler.active);[scheduler stop];
}
static void InvalidTimeAndRelease(void) {
    __block NSTimeInterval now=NAN;__block NSUInteger attempts=0;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{return YES;} synchronize:^{attempts++;}];scheduler.now=^NSTimeInterval{return now;};
    [scheduler refresh];CHECK(scheduler.active && !attempts);
    now=INFINITY;Fire(scheduler);now=-INFINITY;Fire(scheduler);CHECK(!attempts);
    now=100;Fire(scheduler);CHECK(attempts==1);
    now=90;Fire(scheduler);now=NAN;Fire(scheduler);CHECK(attempts==1);
    now=129;Fire(scheduler);CHECK(attempts==1);now=130;Fire(scheduler);CHECK(attempts==2);
    __weak CSAIBackgroundSync *weak=scheduler;NSTimer *timer=Timer(scheduler);scheduler=nil;
    CHECK(!weak && !timer.valid);[timer fire];CHECK(attempts==2);
}
static void RevocationInsideBoundaries(void) {
    __block NSUInteger attempts=0;__block BOOL revokeEligibility=NO,revokeClock=NO;__block NSTimeInterval now=100;
    __block __weak CSAIBackgroundSync *weak;
    CSAIBackgroundSync *scheduler=[[CSAIBackgroundSync alloc]initWithEligibility:^BOOL{if(revokeEligibility)[weak stop];return YES;} synchronize:^{attempts++;}];weak=scheduler;
    scheduler.now=^NSTimeInterval{if(revokeClock)[weak stop];return now;};[scheduler refresh];CHECK(attempts==1);
    now=130;revokeEligibility=YES;Fire(scheduler);CHECK(attempts==1 && !scheduler.active);
    revokeEligibility=NO;[scheduler refresh];CHECK(attempts==2 && scheduler.active);
    now=160;revokeClock=YES;Fire(scheduler);CHECK(attempts==2 && !scheduler.active);
    revokeClock=NO;[scheduler refresh];CHECK(attempts==3 && scheduler.active);[scheduler stop];
}
int main(void) { @autoreleasepool {
    EligibilityAndCadence();StopRestartAndStaleTimers();ReentryAndRejectedAttempts();InvalidTimeAndRelease();RevocationInsideBoundaries();
    printf("AI background sync scheduler: %lu checks passed; cadence, eligibility, stale timers, reentry, rejected attempts, finite time and release\n",(unsigned long)checks);
} return 0; }
