#import "BackgroundRunFakeRuntime.h"
#import <float.h>
#import <math.h>

@interface CSTestBackgroundTask ()
@property(nonatomic, readwrite) BOOL valid;
@property(nonatomic, readwrite) NSUInteger endCalls, number;
@property(nonatomic, copy, readwrite) NSDate *expirationDate;
@property(nonatomic, readwrite) NSTimeInterval expirationUptime;
@property(nonatomic) BOOL expirationPending;
@property(nonatomic, weak) CSTestBackgroundRuntime *runtime;
@property(nonatomic, copy) void (^expiration)(id<CSBackgroundRunTask>);
@end
@interface CSTestBackgroundCheck ()
@property(nonatomic, readwrite) BOOL cancelled, fired, repeating;
@property(nonatomic, readwrite) NSTimeInterval deadline;
@property(nonatomic) NSTimeInterval interval;
@property(nonatomic) BOOL delivering;
@property(nonatomic, weak) CSTestBackgroundRuntime *runtime;
@property(nonatomic, copy) dispatch_block_t handler;
@end
@interface CSTestBackgroundRuntime ()
@property(nonatomic, readwrite) NSUInteger beginAttempts, maximumPendingChecks;
@property(nonatomic, strong) NSMutableArray<CSTestBackgroundTask *> *mutableTasks;
@property(nonatomic, strong) NSMutableArray<CSTestBackgroundCheck *> *mutableChecks;
@property(nonatomic, strong) NSMutableArray<NSString *> *mutableEvents;
@end

@implementation CSTestBackgroundTask
- (instancetype)init {
    if ((self=[super init])) _expirationUptime=-1;
    return self;
}
- (void)end {
    if (!self.valid) return;
    self.endCalls++;
    self.valid=NO;
    [self.runtime.mutableEvents addObject:[NSString stringWithFormat:@"end:%lu",(unsigned long)self.number]];
}
- (void)expireDeferringCallback {
    if (!self.valid) return;
    self.expirationDate=self.runtime.currentDate;
    self.expirationUptime=self.runtime.uptime;
    self.expirationPending=YES;
    [self end];
}
- (void)deliverExpirationCallback {
    if (!self.expirationPending) return;
    self.expirationPending=NO;
    if (self.expiration) self.expiration(self);
}
- (void)expire {
    [self expireDeferringCallback];
    self.expirationPending=NO;
    // Tests also use an old handle to deliver a deliberately stale callback.
    if (self.expiration) self.expiration(self);
}
@end

@implementation CSTestBackgroundCheck
- (void)cancel { self.cancelled=YES; }
- (void)fireEvenIfCancelled {
    if (self.delivering) return;
    self.fired=YES;
    self.delivering=YES;
    if (self.repeating && !self.cancelled) self.deadline=self.runtime.uptime+self.interval;
    @try { if (self.handler) self.handler(); }
    @finally {
        self.delivering=NO;
        if (self.repeating && !self.cancelled && self.deadline<=self.runtime.uptime)
            self.deadline=self.runtime.uptime+self.interval;
    }
}
@end

@implementation CSTestBackgroundRuntime
- (instancetype)init {
    if ((self=[super init])) {
        _uptime=100; _backgroundTimeRemaining=30; _decrementsBudget=YES;
        _currentDate=[NSDate dateWithTimeIntervalSince1970:1700000000];
        _mutableTasks=[NSMutableArray new]; _mutableChecks=[NSMutableArray new]; _mutableEvents=[NSMutableArray new];
    }
    return self;
}
- (NSArray *)tasks { return self.mutableTasks; }
- (NSArray *)checks { return self.mutableChecks; }
- (NSArray *)events { return self.mutableEvents; }
- (NSUInteger)liveTaskCount {
    NSUInteger count=0; for (CSTestBackgroundTask *task in self.tasks) if (task.valid) count++; return count;
}
- (NSUInteger)pendingCheckCount {
    NSUInteger count=0; for (CSTestBackgroundCheck *check in self.checks) if (!check.cancelled && (!check.fired || check.repeating)) count++; return count;
}
- (id<CSBackgroundRunTask>)beginTaskWithExpirationHandler:(void (^)(id<CSBackgroundRunTask>))handler {
    self.beginAttempts++;
    [self.mutableEvents addObject:[NSString stringWithFormat:@"begin:%lu",(unsigned long)self.beginAttempts]];
    CSTestBackgroundTask *task=[CSTestBackgroundTask new];
    task.valid=!self.failBegin; task.number=self.beginAttempts; task.runtime=self; task.expiration=handler;
    if (self.failBegin) return task; // Production also returns an invalid handle.
    [self.mutableTasks addObject:task];
    return task;
}
- (id<CSBackgroundRunScheduledCheck>)scheduleAfter:(NSTimeInterval)delay handler:(dispatch_block_t)handler {
    return [self schedule:delay repeating:NO handler:handler];
}
- (id<CSBackgroundRunScheduledCheck>)scheduleEvery:(NSTimeInterval)interval handler:(dispatch_block_t)handler {
    return [self schedule:interval repeating:YES handler:handler];
}
- (id<CSBackgroundRunScheduledCheck>)schedule:(NSTimeInterval)delay repeating:(BOOL)repeating handler:(dispatch_block_t)handler {
    NSCAssert(isfinite(delay) && delay>0,@"Scheduled delay must be finite and positive");
    CSTestBackgroundCheck *check=[CSTestBackgroundCheck new];
    check.deadline=self.uptime+delay; check.handler=handler;
    check.repeating=repeating; check.interval=delay; check.runtime=self;
    [self.mutableChecks addObject:check];
    self.maximumPendingChecks=MAX(self.maximumPendingChecks,self.pendingCheckCount);
    return check;
}
- (void)elapseTo:(NSTimeInterval)time {
    NSTimeInterval elapsed=time-self.uptime;
    if (self.decrementsBudget && isfinite(self.backgroundTimeRemaining) && self.backgroundTimeRemaining>=0 && self.backgroundTimeRemaining<DBL_MAX/2)
        self.backgroundTimeRemaining=MAX(0,self.backgroundTimeRemaining-elapsed);
    self.currentDate=[self.currentDate dateByAddingTimeInterval:elapsed];
    self.uptime=time;
}
- (void)advanceBy:(NSTimeInterval)elapsed {
    NSCAssert(elapsed>=0 && isfinite(elapsed),@"Clock must advance by a finite amount");
    NSTimeInterval target=self.uptime+elapsed;
    NSUInteger deliveries=0;
    while (YES) {
        CSTestBackgroundCheck *next=nil;
        for (CSTestBackgroundCheck *check in self.checks)
            if (!check.cancelled && !check.delivering && (!check.fired || check.repeating) && check.deadline<=target && (!next || check.deadline<next.deadline)) next=check;
        if (!next) break;
        NSCAssert(++deliveries<1000,@"Timer callback storm");
        [self elapseTo:MAX(self.uptime,next.deadline)];
        [next fireEvenIfCancelled];
        target=MAX(target,self.uptime);
    }
    [self elapseTo:target];
}
- (void)advanceWithoutDeliveryBy:(NSTimeInterval)elapsed {
    NSCAssert(elapsed>=0 && isfinite(elapsed),@"Clock must advance by a finite amount");
    [self elapseTo:self.uptime+elapsed];
}
@end
