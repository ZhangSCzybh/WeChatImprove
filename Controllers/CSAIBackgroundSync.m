#import "CSAIBackgroundSync.h"
#import <math.h>

static NSTimeInterval const CSAIBackgroundSyncInterval=30;
@interface CSAIBackgroundSync ()
@property(nonatomic,copy) BOOL (^eligibility)(void);
@property(nonatomic,copy) void (^synchronize)(void);
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic) BOOL attempted;
@property(nonatomic) NSTimeInterval lastAttempt;
@end

@implementation CSAIBackgroundSync
- (instancetype)initWithEligibility:(BOOL (^)(void))eligibility synchronize:(void (^)(void))synchronize {
    if((self=[super init])){
        _eligibility=[eligibility copy];_synchronize=[synchronize copy];
        _now=^{return NSProcessInfo.processInfo.systemUptime;};
    }
    return self;
}
- (void)dealloc {[_timer invalidate];}
- (BOOL)active {return self.timer.valid;}
- (void)stop {
    NSAssert(NSThread.isMainThread,@"AI background sync requires the main thread");
    [self.timer invalidate];self.timer=nil;
}
- (void)tick:(NSTimer *)timer {
    if(timer!=self.timer || !timer.valid)return;
    if(!self.eligibility()){[self stop];return;}
    if(timer!=self.timer || !timer.valid)return;
    NSTimeInterval now=self.now();
    if(timer!=self.timer || !timer.valid || !isfinite(now) || (self.attempted && now<self.lastAttempt+CSAIBackgroundSyncInterval))return;
    // Reserve the interval before crossing the native boundary, including busy,
    // rejected and reentrant attempts. Never catch up missed timer intervals.
    self.attempted=YES;self.lastAttempt=now;
    self.synchronize();
}
- (void)refresh {
    NSAssert(NSThread.isMainThread,@"AI background sync requires the main thread");
    if(!self.eligibility()){[self stop];return;}
    if(self.active)return;
    __weak typeof(self) weakSelf=self;
    self.timer=[NSTimer timerWithTimeInterval:CSAIBackgroundSyncInterval repeats:YES block:^(NSTimer *timer){[weakSelf tick:timer];}];
    self.timer.tolerance=3;
    [NSRunLoop.mainRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self tick:self.timer];
}
@end
