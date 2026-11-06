#import "BackgroundRunFakeRuntime.h"
#import <float.h>
#import <math.h>

@interface CSTestBackgroundTask ()
@property(nonatomic, readwrite) BOOL valid;
@property(nonatomic, readwrite) NSUInteger endCalls, number;
@property(nonatomic, weak) CSTestBackgroundRuntime *runtime;
@property(nonatomic, copy) void (^expiration)(id<CSBackgroundRunTask>);
@end
@interface CSTestBackgroundCheck ()
@property(nonatomic, readwrite) BOOL cancelled, fired;
@property(nonatomic, readwrite) NSTimeInterval deadline;
@property(nonatomic, copy) dispatch_block_t handler;
@end
@interface CSTestBackgroundRuntime ()
@property(nonatomic, readwrite) NSUInteger beginAttempts, maximumPendingChecks;
@property(nonatomic, strong) NSMutableArray<CSTestBackgroundTask *> *mutableTasks;
@property(nonatomic, strong) NSMutableArray<CSTestBackgroundCheck *> *mutableChecks;
@property(nonatomic, strong) NSMutableArray<NSString *> *mutableEvents;
@end

@implementation CSTestBackgroundTask
- (void)end {
    if (!self.valid) return;
    self.endCalls++;
    self.valid=NO;
    [self.runtime.mutableEvents addObject:[NSString stringWithFormat:@"end:%lu",(unsigned long)self.number]];
}
- (void)expire { if (self.valid) [self end]; if (self.expiration) self.expiration(self); }
@end

@implementation CSTestBackgroundCheck
- (void)cancel { self.cancelled=YES; }
- (void)fireEvenIfCancelled { self.fired=YES; if (self.handler) self.handler(); }
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
    NSUInteger count=0; for (CSTestBackgroundCheck *check in self.checks) if (!check.cancelled && !check.fired) count++; return count;
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
    NSCAssert(isfinite(delay) && delay>0,@"Scheduled delay must be finite and positive");
    CSTestBackgroundCheck *check=[CSTestBackgroundCheck new];
    check.deadline=self.uptime+delay; check.handler=handler;
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
            if (!check.cancelled && !check.fired && check.deadline<=target && (!next || check.deadline<next.deadline)) next=check;
        if (!next) break;
        NSCAssert(++deliveries<1000,@"Timer callback storm");
        [self elapseTo:next.deadline];
        [next fireEvenIfCancelled];
    }
    [self elapseTo:target];
}
@end
