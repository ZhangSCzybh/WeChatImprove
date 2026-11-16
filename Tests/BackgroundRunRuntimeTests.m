#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <math.h>
#import <float.h>
#import "CSBackgroundRunRuntime.h"

// A delivered run-loop callback can race cancellation. Calling the production
// delivery boundary directly models that stale delivery without sleeping.
@interface NSObject (CSBackgroundRunRuntimeTestDelivery)
- (void)fireTimer:(NSTimer *)timer;
@end

static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)
static void Drain(void) {
    for (NSUInteger pass=0;pass<4;pass++) [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.005]];
}
static NSTimer *Timer(id<CSBackgroundRunScheduledCheck> check) { return [(id)check valueForKey:@"timer"]; }

int main(void) { @autoreleasepool {
    UIApplication *app=UIApplication.sharedApplication;
    CSBackgroundRunRuntime *runtime=[CSBackgroundRunRuntime new];
    NSTimeInterval before=NSProcessInfo.processInfo.systemUptime;
    CHECK(runtime.uptime>=before && runtime.uptime<=NSProcessInfo.processInfo.systemUptime);
    NSDate *wallBefore=NSDate.date, *reportedDate=runtime.currentDate, *wallAfter=NSDate.date;
    CHECK(reportedDate && [reportedDate compare:wallBefore]!=NSOrderedAscending && [reportedDate compare:wallAfter]!=NSOrderedDescending);
    CHECK(runtime.backgroundTimeRemaining==120);
    app.backgroundTimeRemaining=DBL_MAX;
    CHECK(runtime.backgroundTimeRemaining==DBL_MAX);

    __block NSUInteger expirations=0;
    app.failNextTask=YES;
    id<CSBackgroundRunTask> failed=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){ (void)task; expirations++; }];
    CHECK(failed!=nil && !failed.valid);
    CHECK(!failed.expirationDate && failed.expirationUptime==-1);
    [failed end]; [failed end]; Drain();
    CHECK(!app.begunIdentifiers.count && !app.endedIdentifiers.count && !expirations);

    id<CSBackgroundRunTask> first=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){ (void)task; expirations++; }];
    CHECK(first.valid && app.begunIdentifiers.count==1);
    dispatch_block_t lateFirst=[app.expirationHandlers[@1] copy];
    [first end]; [first end];
    CHECK(!first.valid && [app.endedIdentifiers isEqual:@[@1]]);
    CHECK(!first.expirationDate && first.expirationUptime==-1);
    lateFirst(); Drain();
    CHECK(!expirations && [app.endedIdentifiers isEqual:@[@1]]);
    CHECK(!first.expirationDate && first.expirationUptime==-1);

    __block id<CSBackgroundRunTask> delivered=nil;
    id<CSBackgroundRunTask> expired=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){
        CHECK(NSThread.isMainThread && !task.valid);
        CHECK([app.endedIdentifiers containsObject:@2]);
        delivered=task; expirations++;
        [task end];
    }];
    CHECK(expired.valid);
    CHECK(!expired.expirationDate && expired.expirationUptime==-1);
    dispatch_block_t expireSecond=[app.expirationHandlers[@2] copy];
    NSDate *expirationBefore=NSDate.date;
    NSTimeInterval expirationUptimeBefore=NSProcessInfo.processInfo.systemUptime;
    expireSecond();
    CHECK(!expired.valid && expirations==0 && [app.endedIdentifiers isEqual:@[@1,@2]]);
    // The snapshot is already available while delivery is still queued.
    NSDate *expirationDate=expired.expirationDate;
    NSTimeInterval expirationUptime=expired.expirationUptime;
    CHECK(expirationDate && [expirationDate compare:expirationBefore]!=NSOrderedAscending && [expirationDate compare:NSDate.date]!=NSOrderedDescending);
    CHECK(expirationUptime>=expirationUptimeBefore && expirationUptime<=NSProcessInfo.processInfo.systemUptime);
    expireSecond(); [expired end]; Drain();
    CHECK(delivered==expired && expirations==1 && app.endedIdentifiers.count==2);
    CHECK([expired.expirationDate isEqualToDate:expirationDate] && expired.expirationUptime==expirationUptime);
    delivered=nil;

    // Expiration is tied to its original handle even after another lease starts.
    __block NSUInteger olderCallbacks=0,newerCallbacks=0;
    id<CSBackgroundRunTask> older=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){ CHECK(!task.valid); olderCallbacks++; }];
    dispatch_block_t expireOlder=[app.expirationHandlers[@3] copy];
    id<CSBackgroundRunTask> newer=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){ (void)task; newerCallbacks++; }];
    expireOlder();
    CHECK(!older.valid && newer.valid);
    CHECK([app.endedIdentifiers.lastObject isEqual:@3]);
    Drain();
    CHECK(olderCallbacks==1 && !newerCallbacks && newer.valid);
    [newer end];
    CHECK([app.endedIdentifiers.lastObject isEqual:@4]);

    // UIKit may invoke expiration before returning its identifier. Delivery is
    // deferred until beginTask returns, and the returned identifier is released.
    app.expireSynchronously=YES;
    __block BOOL beginReturned=NO;
    id<CSBackgroundRunTask> synchronous=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){
        CHECK(beginReturned && !task.valid);
        CHECK([app.endedIdentifiers.lastObject isEqual:@5]);
        expirations++;
    }];
    beginReturned=YES;
    CHECK(!synchronous.valid && [app.endedIdentifiers.lastObject isEqual:@5] && expirations==1);
    CHECK(synchronous.expirationDate && synchronous.expirationUptime>=expirationUptime);
    app.expireSynchronously=NO;
    Drain(); CHECK(expirations==2);

    // Reentrant/duplicate expiration during native end cannot double-release.
    app.expireDuringEnd=YES;
    id<CSBackgroundRunTask> reentrant=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){ (void)task; expirations++; }];
    [reentrant end]; [reentrant end]; Drain();
    CHECK(!reentrant.valid && expirations==2);
    CHECK(!reentrant.expirationDate && reentrant.expirationUptime==-1);
    CHECK([app.endedIdentifiers filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF == 6"]].count==1);
    app.expireDuringEnd=NO;

    // An unexpected native delivery thread invalidates immediately, while the
    // native end and client callback are ordered on main without waiting on it.
    __block BOOL offMainDelivered=NO;
    id<CSBackgroundRunTask> offMain=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){
        CHECK(NSThread.isMainThread && !task.valid && [app.endedIdentifiers.lastObject isEqual:@7]);
        offMainDelivered=YES;
    }];
    dispatch_block_t expireOffMain=[app.expirationHandlers[@7] copy];
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{ expireOffMain(); CHECK(!offMain.valid); });
    CHECK(!offMainDelivered);
    CHECK(offMain.expirationDate && offMain.expirationUptime>=expirationUptime);
    Drain(); CHECK(offMainDelivered && [app.endedIdentifiers.lastObject isEqual:@7]);

    // UIKit holds a weak reference to the handle. Releasing the owner's handle
    // ends the lease immediately and leaves no task/native-handler retain loop.
    __weak id<CSBackgroundRunTask> weakTask;
    @autoreleasepool {
        id<CSBackgroundRunTask> disposable=[runtime beginTaskWithExpirationHandler:^(id<CSBackgroundRunTask> task){ (void)task; expirations++; }];
        weakTask=disposable; CHECK(disposable.valid);
        disposable=nil;
    }
    CHECK(weakTask==nil && [app.endedIdentifiers.lastObject isEqual:@8]);

    __block NSUInteger fires=0;
    id<CSBackgroundRunScheduledCheck> check=[runtime scheduleAfter:3600 handler:^{ fires++; }];
    NSTimer *timer=Timer(check);
    CHECK(timer.valid && timer.fireDate.timeIntervalSinceNow>3590 && timer.tolerance<=0.10001);
    [check cancel]; [check cancel];
    CHECK(!timer.valid && Timer(check)==nil);
    [(id)check fireTimer:timer]; [timer fire]; Drain();
    CHECK(!fires);

    check=[runtime scheduleAfter:3600 handler:^{ fires++; }]; timer=Timer(check);
    [(id)check fireTimer:timer];
    CHECK(fires==1 && !timer.valid && Timer(check)==nil);
    [(id)check fireTimer:timer]; [check cancel];
    CHECK(fires==1);

    __block id<CSBackgroundRunScheduledCheck> replacement;
    id<CSBackgroundRunScheduledCheck> original=[runtime scheduleAfter:3600 handler:^{
        fires++;
        replacement=[runtime scheduleAfter:3600 handler:^{ fires++; }];
    }];
    NSTimer *originalTimer=Timer(original);
    [(id)original fireTimer:originalTimer];
    CHECK(fires==2 && Timer(replacement).valid);
    [(id)original fireTimer:originalTimer]; [original cancel];
    CHECK(fires==2 && Timer(replacement).valid);
    [replacement cancel]; replacement=nil;

    __weak id<CSBackgroundRunScheduledCheck> weakCheck;
    __block BOOL abandonedFired=NO;
    @autoreleasepool {
        id<CSBackgroundRunScheduledCheck> abandoned=[runtime scheduleAfter:3600 handler:^{ abandonedFired=YES; }];
        weakCheck=abandoned; timer=Timer(abandoned);
        abandoned=nil;
    }
    CHECK(weakCheck==nil && !timer.valid);
    [timer fire]; Drain(); CHECK(!abandonedFired);

    // The actual Foundation run loop must fire the one-shot exactly once.
    __block NSUInteger actualFires=0;
    check=[runtime scheduleAfter:0.001 handler:^{ actualFires++; }];
    Drain(); CHECK(actualFires==1 && Timer(check)==nil);
    Drain(); CHECK(actualFires==1);

    // Periodic delivery keeps one native timer and slides its next deadline
    // from actual delivery, while one-shot semantics above remain unchanged.
    __block NSUInteger periodicFires=0;
    check=[runtime scheduleEvery:3600 handler:^{ periodicFires++; }]; timer=Timer(check);
    CHECK(timer.valid && timer.timeInterval==3600 && timer.tolerance<=0.10001);
    [(id)check fireTimer:timer]; [(id)check fireTimer:timer];
    CHECK(periodicFires==2 && Timer(check)==timer && timer.valid);
    CHECK(timer.fireDate.timeIntervalSinceNow>3590 && timer.fireDate.timeIntervalSinceNow<=3600.1);
    [check cancel]; [check cancel]; [(id)check fireTimer:timer];
    CHECK(periodicFires==2 && !timer.valid && Timer(check)==nil);

    check=[runtime scheduleEvery:3600 handler:^{ periodicFires++; }]; timer=Timer(check);
    // A missed sequence of native fire dates produces one delivery, followed
    // by a full interval, rather than immediate catch-up from the old phase.
    timer.fireDate=[NSDate dateWithTimeIntervalSinceNow:-36000];
    Drain(); CHECK(periodicFires==3 && Timer(check)==timer && timer.valid);
    CHECK(timer.fireDate.timeIntervalSinceNow>3590 && timer.fireDate.timeIntervalSinceNow<=3600.1);
    Drain(); CHECK(periodicFires==3); [check cancel];

    __block id<CSBackgroundRunScheduledCheck> periodic;
    periodic=[runtime scheduleEvery:3600 handler:^{
        periodicFires++;
        [(id)periodic fireTimer:Timer(periodic)]; // Nested delivery is ignored.
        [periodic cancel];
    }];
    timer=Timer(periodic); [(id)periodic fireTimer:timer];
    CHECK(periodicFires==4 && !timer.valid && Timer(periodic)==nil);
    [(id)periodic fireTimer:timer]; CHECK(periodicFires==4); periodic=nil;

    periodic=[runtime scheduleEvery:3600 handler:^{
        periodicFires++; [periodic cancel];
        replacement=[runtime scheduleEvery:3600 handler:^{ periodicFires++; }];
    }];
    timer=Timer(periodic); [(id)periodic fireTimer:timer];
    CHECK(periodicFires==5 && !timer.valid && Timer(replacement).valid);
    [(id)periodic fireTimer:timer]; CHECK(periodicFires==5 && Timer(replacement).valid);
    [replacement cancel]; replacement=nil; periodic=nil;

    periodic=[runtime scheduleEvery:3600 handler:^{
        periodicFires++;
        // Model a handler that consumed its next deadline without blocking.
        Timer(periodic).fireDate=[NSDate dateWithTimeIntervalSinceNow:-1];
    }];
    timer=Timer(periodic); [(id)periodic fireTimer:timer];
    CHECK(periodicFires==6 && timer.fireDate.timeIntervalSinceNow>3590);
    Drain(); CHECK(periodicFires==6); [periodic cancel]; periodic=nil;

    @autoreleasepool {
        id<CSBackgroundRunScheduledCheck> abandoned=[runtime scheduleEvery:3600 handler:^{ periodicFires++; }];
        weakCheck=abandoned; timer=Timer(abandoned); abandoned=nil;
    }
    CHECK(weakCheck==nil && !timer.valid); [timer fire]; Drain(); CHECK(periodicFires==6);

    __block NSUInteger actualPeriodicFires=0;
    periodic=[runtime scheduleEvery:.001 handler:^{ if (++actualPeriodicFires==3) [periodic cancel]; }];
    NSDate *limit=[NSDate dateWithTimeIntervalSinceNow:1];
    while (actualPeriodicFires<3 && limit.timeIntervalSinceNow>0)
        [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.005]];
    CHECK(actualPeriodicFires==3 && Timer(periodic)==nil);
    Drain(); CHECK(actualPeriodicFires==3); periodic=nil;

    for (NSNumber *invalid in @[@(-1),@(NAN),@(INFINITY)]) {
        check=[runtime scheduleAfter:invalid.doubleValue handler:^{ fires++; }];
        timer=Timer(check);
        CHECK(timer.valid && isfinite(timer.fireDate.timeIntervalSinceNow));
        [check cancel];
        check=[runtime scheduleEvery:invalid.doubleValue handler:^{ periodicFires++; }]; timer=Timer(check);
        CHECK(timer.valid && isfinite(timer.fireDate.timeIntervalSinceNow)); [check cancel];
    }
    __weak CSBackgroundRunRuntime *weakRuntime;
    @autoreleasepool {
        CSBackgroundRunRuntime *temporary=[CSBackgroundRunRuntime new]; weakRuntime=temporary;
        check=[temporary scheduleAfter:3600 handler:^{ fires++; }]; temporary=nil;
    }
    CHECK(weakRuntime==nil && Timer(check).valid);
    [check cancel];
    CHECK(app.begunIdentifiers.count==8 && app.endedIdentifiers.count==8 && !app.expirationHandlers.count);
    printf("Background runtime: %lu checks passed; task expiration, ownership, one-shot and reusable periodic checks verified\n",(unsigned long)checks);
} return 0; }
