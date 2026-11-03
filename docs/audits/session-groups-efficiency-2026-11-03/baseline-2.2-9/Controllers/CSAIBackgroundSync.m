#import "CSAIBackgroundSync.h"
#import <math.h>

static NSTimeInterval const CSAIBackgroundSyncInterval=45;
@interface CSAIBackgroundSync ()
@property(nonatomic,copy) BOOL (^eligibility)(void);
@property(nonatomic,copy) void (^synchronize)(void);
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic) BOOL attempted;
@property(nonatomic) NSTimeInterval lastAttempt;
@property(nonatomic) BOOL running,verifiedSync;
@property(nonatomic) NSTimeInterval lastVerifiedSync;
@property(nonatomic) NSUInteger generation;
@end

@implementation CSAIBackgroundSync
- (instancetype)initWithEligibility:(BOOL (^)(void))eligibility synchronize:(void (^)(void))synchronize {
    if((self=[super init])){
        _eligibility=[eligibility copy];_synchronize=[synchronize copy];
        _fallbackEnabled=YES;
        _now=^{return NSProcessInfo.processInfo.systemUptime;};
    }
    return self;
}
- (void)dealloc {[_timer invalidate];}
- (BOOL)active {return self.running && self.timer.valid;}
- (void)setFallbackEnabled:(BOOL)fallbackEnabled {
    NSAssert(NSThread.isMainThread,@"AI background sync requires the main thread");
    if(_fallbackEnabled==fallbackEnabled)return;
    _fallbackEnabled=fallbackEnabled;
    if(!fallbackEnabled)[self stop];
}
- (void)stop {
    NSAssert(NSThread.isMainThread,@"AI background sync requires the main thread");
    self.running=NO;self.generation++;[self.timer invalidate];self.timer=nil;
}
- (NSTimeInterval)delayAtTime:(NSTimeInterval)now {
    if(!isfinite(now))return CSAIBackgroundSyncInterval;
    NSTimeInterval deadline=now;
    if(self.attempted)deadline=MAX(deadline,self.lastAttempt+CSAIBackgroundSyncInterval);
    if(self.verifiedSync)deadline=MAX(deadline,self.lastVerifiedSync+CSAIBackgroundSyncInterval);
    NSTimeInterval delay=deadline-now;
    return isfinite(delay)?MAX(0,delay):CSAIBackgroundSyncInterval;
}
- (void)scheduleAfter:(NSTimeInterval)delay {
    if(!self.running)return;
    [self.timer invalidate];self.generation++;
    __weak typeof(self) weakSelf=self;
    self.timer=[NSTimer timerWithTimeInterval:delay repeats:NO block:^(NSTimer *timer){[weakSelf tick:timer];}];
    self.timer.tolerance=3;
    [NSRunLoop.mainRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)tick:(NSTimer *)timer {
    // A one-shot timer may already be invalid when its callback runs. Ownership
    // and generation, rather than validity, fence stale/manual/reentrant fires.
    if(!self.running || timer!=self.timer)return;
    NSUInteger generation=self.generation;
    if(!self.eligibility()){[self stop];return;}
    if(!self.running || generation!=self.generation || timer!=self.timer)return;
    NSTimeInterval now=self.now();
    if(!self.running || generation!=self.generation || timer!=self.timer)return;
    NSTimeInterval delay=[self delayAtTime:now];
    if(!isfinite(now) || delay>0){[self scheduleAfter:delay];return;}
    // Reserve the interval before crossing the native boundary, including busy,
    // rejected and reentrant attempts. Never catch up missed timer intervals.
    self.attempted=YES;self.lastAttempt=now;
    // Arm before the native boundary: reentrant stop/restart, completion and
    // early fire retain one current deadline and the reserved attempt budget.
    [self scheduleAfter:CSAIBackgroundSyncInterval];
    self.synchronize();
}
- (void)refresh {
    NSAssert(NSThread.isMainThread,@"AI background sync requires the main thread");
    if(!self.fallbackEnabled)return;
    NSUInteger generation=self.generation;
    if(!self.eligibility()){[self stop];return;}
    if(generation!=self.generation)return;
    if(self.active)return;
    self.running=YES;[self scheduleAfter:CSAIBackgroundSyncInterval];
    [self tick:self.timer];
}
- (void)verifiedFullSyncCompleted {
    NSAssert(NSThread.isMainThread,@"AI background sync requires the main thread");
    if(!self.running)return;
    NSUInteger generation=self.generation;
    if(!self.eligibility()){[self stop];return;}
    if(!self.running || generation!=self.generation)return;
    NSTimeInterval now=self.now();
    if(!self.running || generation!=self.generation || !isfinite(now) ||
        (self.verifiedSync && now<self.lastVerifiedSync))return;
    self.verifiedSync=YES;self.lastVerifiedSync=now;
    [self scheduleAfter:[self delayAtTime:now]];
}
- (void)invalidateVerifiedSync {
    NSAssert(NSThread.isMainThread,@"AI background sync requires the main thread");
    self.verifiedSync=NO;self.lastVerifiedSync=0;self.generation++;
    if(!self.running)return;
    NSUInteger generation=self.generation;
    if(!self.eligibility()){[self stop];return;}
    if(!self.running || generation!=self.generation)return;
    NSTimeInterval now=self.now();
    if(!self.running || generation!=self.generation)return;
    [self scheduleAfter:[self delayAtTime:now]];
}
@end
