#import <Foundation/Foundation.h>
#import "CSBackgroundSyncBudget.h"
#import "CSBackupBootstrap.h"
#include <math.h>
#include <float.h>
#include <stdatomic.h>

static NSUInteger checks;
static atomic_ulong liveEpoch=1;
NSUInteger CSBackupAccountEpoch(void) {return atomic_load(&liveEpoch);}
#define CHECK(condition) do {checks++;if(!(condition)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#condition);exit(1);}} while(0)
static BOOL DelayIs(CSBackgroundSyncBudget *budget,NSUInteger epoch,NSTimeInterval expected) {
    return fabs([budget nextDelayForEpoch:epoch]-expected)<0.00001;
}

static void SourcesShareOneAttempt(void) {
    atomic_store(&liveEpoch,1);__block NSTimeInterval time=100;__block NSUInteger ai=0,pat=0;
    CSBackgroundSyncBudget *budget=[CSBackgroundSyncBudget new];budget.now=^{return time;};
    CHECK(DelayIs(budget,1,0));
    CHECK([budget performForEpoch:1 request:^{ai++;}]);
    CHECK(![budget performForEpoch:1 request:^{pat++;}]);
    CHECK(ai==1 && pat==0 && DelayIs(budget,1,45));
    time=144.999;CHECK(![budget performForEpoch:1 request:^{pat++;}]);
    time=145;CHECK([budget performForEpoch:1 request:^{pat++;}]);
    CHECK(ai==1 && pat==1 && DelayIs(budget,1,45));
    // A suspended timer gets one attempt when it resumes, never a catch-up burst.
    time=10000;CHECK([budget performForEpoch:1 request:^{ai++;}]);
    for(NSUInteger i=0;i<5;i++)CHECK(![budget performForEpoch:1 request:^{pat++;}]);
    CHECK(ai==2 && pat==1 && DelayIs(budget,1,45));
}

static void BusyRejectionAndOriginalException(void) {
    atomic_store(&liveEpoch,2);__block NSTimeInterval time=100;__block NSUInteger invoked=0,accepted=0;
    CSBackgroundSyncBudget *budget=[CSBackgroundSyncBudget new];budget.now=^{return time;};
    CHECK([budget performForEpoch:2 request:^{invoked++;/* Native busy: no accepted work. */}]);
    CHECK(![budget performForEpoch:2 request:^{invoked++;accepted++;}]);
    CHECK(invoked==1 && accepted==0);
    time=145;CHECK([budget performForEpoch:2 request:^{invoked++;/* Native returned NO. */}]);
    CHECK(invoked==2 && accepted==0 && DelayIs(budget,2,45));
    time=190;NSException *original=[NSException exceptionWithName:@"native" reason:@"fixture" userInfo:nil];
    BOOL caught=NO;
    @try {[budget performForEpoch:2 request:^{invoked++;@throw original;}];}
    @catch(NSException *exception) {caught=YES;CHECK(exception==original);}
    CHECK(caught && invoked==3 && DelayIs(budget,2,45));
    CHECK(![budget performForEpoch:2 request:^{invoked++;}]);
    time=235;CHECK([budget performForEpoch:2 request:^{invoked++;accepted++;}]);
    CHECK(invoked==4 && accepted==1);
}

static void VerifiedCoverageAndEpochChanges(void) {
    atomic_store(&liveEpoch,3);__block NSTimeInterval time=100;__block NSUInteger invoked=0;
    CSBackgroundSyncBudget *budget=[CSBackgroundSyncBudget new];budget.now=^{return time;};
    [budget verifiedFullSyncForEpoch:3];CHECK(invoked==0 && DelayIs(budget,3,45));
    time=120;[budget verifiedFullSyncForEpoch:3];CHECK(DelayIs(budget,3,45));
    time=164.999;CHECK(![budget performForEpoch:3 request:^{invoked++;}]);
    time=165;CHECK([budget performForEpoch:3 request:^{invoked++;}]);
    time=175;[budget verifiedFullSyncForEpoch:3];CHECK(DelayIs(budget,3,45));
    time=180;atomic_store(&liveEpoch,4);
    CHECK(DelayIs(budget,4,30)); // Old coverage ends; the global attempt remains.
    [budget verifiedFullSyncForEpoch:3];CHECK(DelayIs(budget,4,30));
    CHECK([budget nextDelayForEpoch:3]>0);
    CHECK(![budget performForEpoch:3 request:^{invoked++;}]);
    time=210;CHECK([budget performForEpoch:4 request:^{invoked++;}]);
    time=215;[budget verifiedFullSyncForEpoch:4];CHECK(DelayIs(budget,4,45));
    atomic_store(&liveEpoch,5);time=220;CHECK(DelayIs(budget,5,35));
    [budget verifiedFullSyncForEpoch:4];CHECK(DelayIs(budget,5,35));
    CHECK(invoked==2);
    // Stopping source schedulers in foreground never resets this independent budget.
    time=230;CHECK(DelayIs(budget,5,25));
    time=255;CHECK([budget performForEpoch:5 request:^{invoked++;}]);
    CHECK(invoked==3 && DelayIs(budget,5,45));
}

static void ReentrantRequestsAndCompletions(void) {
    atomic_store(&liveEpoch,6);__block NSTimeInterval time=100;__block NSUInteger invoked=0;
    CSBackgroundSyncBudget *budget=[CSBackgroundSyncBudget new];budget.now=^{return time;};
    CHECK([budget performForEpoch:6 request:^{
        invoked++;CHECK(DelayIs(budget,6,45));
        CHECK(![budget performForEpoch:6 request:^{invoked++;}]);
        time=105;[budget verifiedFullSyncForEpoch:6];CHECK(DelayIs(budget,6,45));
    }]);
    CHECK(invoked==1 && DelayIs(budget,6,45));
    time=149;CHECK(![budget performForEpoch:6 request:^{invoked++;}]);
    time=150;CHECK([budget performForEpoch:6 request:^{
        invoked++;atomic_store(&liveEpoch,7);
        CHECK(![budget performForEpoch:7 request:^{invoked++;}]);
        CHECK(DelayIs(budget,7,45));
    }]);
    CHECK(invoked==2);
    time=195;CHECK([budget performForEpoch:7 request:^{invoked++;}]);
    CHECK(invoked==3);
}

static void InvalidAndRegressingClocks(void) {
    atomic_store(&liveEpoch,8);__block NSTimeInterval time=NAN;__block NSUInteger invoked=0;
    CSBackgroundSyncBudget *budget=[CSBackgroundSyncBudget new];budget.now=^{return time;};
    for(NSNumber *invalid in @[@(NAN),@(INFINITY),@(-INFINITY),@(-1),@(DBL_MAX)]){
        time=invalid.doubleValue;CHECK([budget nextDelayForEpoch:8]>0);
        CHECK(![budget performForEpoch:8 request:^{invoked++;}]);
        [budget verifiedFullSyncForEpoch:8];
    }
    time=100;CHECK(DelayIs(budget,8,0));
    time=99;CHECK([budget nextDelayForEpoch:8]>0);
    CHECK(![budget performForEpoch:8 request:^{invoked++;}]);
    time=100;CHECK([budget performForEpoch:8 request:^{invoked++;}]);
    time=145;CHECK(DelayIs(budget,8,0));
    time=144;CHECK(![budget performForEpoch:8 request:^{invoked++;}]);
    [budget verifiedFullSyncForEpoch:8];
    time=145;CHECK([budget performForEpoch:8 request:^{invoked++;}]);
    time=190;[budget verifiedFullSyncForEpoch:8];CHECK(DelayIs(budget,8,45));
    time=189;[budget verifiedFullSyncForEpoch:8];
    time=191;CHECK(DelayIs(budget,8,44));
    budget.now=^NSTimeInterval{@throw [NSException exceptionWithName:@"clock" reason:nil userInfo:nil];};
    CHECK([budget nextDelayForEpoch:8]>0);
    CHECK(![budget performForEpoch:8 request:^{invoked++;}]);
    [budget verifiedFullSyncForEpoch:8];
    budget.now=^{return time;};time=235;CHECK([budget performForEpoch:8 request:^{invoked++;}]);
    CHECK(invoked==3);
}

static void ClockBoundaryAndThreadFences(void) {
    atomic_store(&liveEpoch,9);__block NSTimeInterval time=100;__block NSUInteger invoked=0;
    CSBackgroundSyncBudget *budget=[CSBackgroundSyncBudget new];
    budget.now=^{atomic_store(&liveEpoch,10);return time;};
    CHECK(![budget performForEpoch:9 request:^{invoked++;}]);
    budget.now=^{return time;};CHECK(DelayIs(budget,10,0));
    __weak CSBackgroundSyncBudget *weakBudget=budget;
    budget.now=^{
        CHECK(![weakBudget performForEpoch:10 request:^{invoked++;}]);
        CHECK([weakBudget nextDelayForEpoch:10]>0);
        [weakBudget verifiedFullSyncForEpoch:10];return time;
    };
    CHECK([budget performForEpoch:10 request:^{invoked++;}]);
    budget.now=^{return time;};CHECK(invoked==1 && DelayIs(budget,10,45));
    __block BOOL offMainRefused=NO;__block NSTimeInterval offMainDelay=0;
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        offMainRefused=![budget performForEpoch:10 request:^{invoked++;}];
        offMainDelay=[budget nextDelayForEpoch:10];
        [budget verifiedFullSyncForEpoch:10];
    });
    CHECK(offMainRefused && offMainDelay>0 && invoked==1);
    time=145;CHECK(DelayIs(budget,10,0));
    CHECK([budget performForEpoch:10 request:^{invoked++;}]);
    CHECK(invoked==2);
}

int main(void) {
    @autoreleasepool {
        CHECK(NSThread.isMainThread);
        CHECK(CSBackgroundSyncBudget.sharedBudget==CSBackgroundSyncBudget.sharedBudget);
        CHECK(isfinite(CSBackgroundSyncBudget.sharedBudget.now()));
        SourcesShareOneAttempt();BusyRejectionAndOriginalException();
        VerifiedCoverageAndEpochChanges();ReentrantRequestsAndCompletions();
        InvalidAndRegressingClocks();ClockBoundaryAndThreadFences();
        printf("Background sync budget: %lu checks passed; shared sources, cooldown, epochs, verified coverage, exceptions, reentry, clocks and thread fences\n",(unsigned long)checks);
    }
    return 0;
}
