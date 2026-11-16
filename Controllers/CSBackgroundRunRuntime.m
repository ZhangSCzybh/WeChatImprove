#import "CSBackgroundRunRuntime.h"
#import <UIKit/UIKit.h>
#import <math.h>

static void CSBackgroundRunEndNativeTask(UIBackgroundTaskIdentifier identifier) {
    if (identifier==UIBackgroundTaskInvalid) return;
    dispatch_block_t finish=^{ [UIApplication.sharedApplication endBackgroundTask:identifier]; };
    if (NSThread.isMainThread) finish(); else dispatch_async(dispatch_get_main_queue(),finish);
}

@interface CSBackgroundRunUIKitTask : NSObject <CSBackgroundRunTask> {
    UIBackgroundTaskIdentifier _identifier;
    BOOL _identifierInstalled, _finished;
    NSDate *_expirationDate;
    NSTimeInterval _expirationUptime;
    void (^_expirationHandler)(id<CSBackgroundRunTask> task);
}
- (instancetype)initWithExpirationHandler:(void (^)(id<CSBackgroundRunTask> task))handler;
- (void)installIdentifier:(UIBackgroundTaskIdentifier)identifier;
- (void)expire;
@end

@implementation CSBackgroundRunUIKitTask
- (instancetype)initWithExpirationHandler:(void (^)(id<CSBackgroundRunTask> task))handler {
    if ((self=[super init])) {
        _identifier=UIBackgroundTaskInvalid;
        _expirationUptime=-1;
        _expirationHandler=[handler copy];
    }
    return self;
}
- (BOOL)valid {
    @synchronized (self) { return !_finished && _identifierInstalled && _identifier!=UIBackgroundTaskInvalid; }
}
- (NSDate *)expirationDate {
    @synchronized (self) { return _expirationDate; }
}
- (NSTimeInterval)expirationUptime {
    @synchronized (self) { return _expirationUptime; }
}
- (void)installIdentifier:(UIBackgroundTaskIdentifier)identifier {
    BOOL release=NO;
    @synchronized (self) {
        _identifierInstalled=YES;
        if (_finished) release=YES;
        else if (identifier==UIBackgroundTaskInvalid) { _finished=YES; _expirationHandler=nil; }
        else _identifier=identifier;
    }
    // A synchronous expiration may precede the identifier returned by UIKit.
    // It must release that identifier once it becomes available.
    if (release) CSBackgroundRunEndNativeTask(identifier);
}
- (void)end {
    UIBackgroundTaskIdentifier identifier=UIBackgroundTaskInvalid;
    @synchronized (self) {
        if (_finished) return;
        _finished=YES;
        _expirationHandler=nil;
        identifier=_identifier;
        _identifier=UIBackgroundTaskInvalid;
    }
    CSBackgroundRunEndNativeTask(identifier);
}
- (void)expire {
    UIBackgroundTaskIdentifier identifier=UIBackgroundTaskInvalid;
    void (^handler)(id<CSBackgroundRunTask> task)=nil;
    @synchronized (self) {
        if (_finished) return;
        _expirationDate=NSDate.date;
        _expirationUptime=NSProcessInfo.processInfo.systemUptime;
        _finished=YES;
        identifier=_identifier;
        _identifier=UIBackgroundTaskInvalid;
        handler=_expirationHandler;
        _expirationHandler=nil;
    }
    // Invalidate synchronously, release this lease before notifying its owner,
    // and always defer delivery so beginTask can safely finish publishing it.
    CSBackgroundRunEndNativeTask(identifier);
    if (handler) dispatch_async(dispatch_get_main_queue(),^{ handler(self); });
}
- (void)dealloc { [self end]; }
@end

@class CSBackgroundRunTimerCheck;
@interface CSBackgroundRunTimerTarget : NSObject
@property(nonatomic, weak) CSBackgroundRunTimerCheck *check;
- (void)fire:(NSTimer *)timer;
@end

@interface CSBackgroundRunTimerCheck : NSObject <CSBackgroundRunScheduledCheck>
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, copy) dispatch_block_t handler;
@property(nonatomic) BOOL finished, repeating, delivering;
@property(nonatomic) NSTimeInterval interval;
- (instancetype)initWithDelay:(NSTimeInterval)delay repeating:(BOOL)repeating handler:(dispatch_block_t)handler;
- (void)fireTimer:(NSTimer *)timer;
@end

@implementation CSBackgroundRunTimerTarget
- (void)fire:(NSTimer *)timer { [self.check fireTimer:timer]; }
@end

@implementation CSBackgroundRunTimerCheck
- (instancetype)initWithDelay:(NSTimeInterval)delay repeating:(BOOL)repeating handler:(dispatch_block_t)handler {
    if ((self=[super init])) {
        _handler=[handler copy];
        NSTimeInterval interval=isfinite(delay)?MAX(0.001,delay):1;
        _repeating=repeating; _interval=interval;
        CSBackgroundRunTimerTarget *target=[CSBackgroundRunTimerTarget new];
        target.check=self;
        _timer=[NSTimer timerWithTimeInterval:interval target:target selector:@selector(fire:) userInfo:nil repeats:repeating];
        _timer.tolerance=MIN(0.1,interval*0.1);
        [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}
- (void)cancel {
    NSAssert(NSThread.isMainThread,@"Background checks are main-thread owned");
    if (self.finished) return;
    self.finished=YES;
    [self.timer invalidate]; self.timer=nil; self.handler=nil;
}
- (void)fireTimer:(NSTimer *)timer {
    NSAssert(NSThread.isMainThread,@"Background checks are main-thread owned");
    if (self.finished || self.delivering || timer!=self.timer) return;
    if (self.repeating) {
        self.delivering=YES;
        // Keep the old sliding cadence while reusing the same timer. A delayed
        // run loop must not immediately deliver missed slots from the old phase.
        timer.fireDate=[NSDate dateWithTimeIntervalSinceNow:self.interval];
        dispatch_block_t handler=self.handler;
        @try { if (handler) handler(); }
        @finally {
            self.delivering=NO;
            // A slow/reentrant handler may cancel this handle or consume an
            // entire interval. Do not resurrect it or catch up missed work.
            if (!self.finished && self.timer==timer && timer.fireDate.timeIntervalSinceNow<=0)
                timer.fireDate=[NSDate dateWithTimeIntervalSinceNow:self.interval];
        }
        return;
    }
    self.finished=YES;
    dispatch_block_t handler=self.handler;
    [self.timer invalidate]; self.timer=nil; self.handler=nil;
    if (handler) handler();
}
- (void)dealloc { [_timer invalidate]; }
@end

@implementation CSBackgroundRunRuntime
- (NSTimeInterval)uptime { return NSProcessInfo.processInfo.systemUptime; }
- (NSDate *)currentDate { return NSDate.date; }
- (NSTimeInterval)backgroundTimeRemaining {
    NSAssert(NSThread.isMainThread,@"Background runtime is main-thread owned");
    return UIApplication.sharedApplication.backgroundTimeRemaining;
}
- (id<CSBackgroundRunTask>)beginTaskWithExpirationHandler:(void (^)(id<CSBackgroundRunTask> task))handler {
    NSAssert(NSThread.isMainThread,@"Background runtime is main-thread owned");
    CSBackgroundRunUIKitTask *task=[[CSBackgroundRunUIKitTask alloc] initWithExpirationHandler:handler];
    __weak CSBackgroundRunUIKitTask *weakTask=task;
    UIBackgroundTaskIdentifier identifier=[UIApplication.sharedApplication beginBackgroundTaskWithName:@"WeChatImprove.BackgroundRun" expirationHandler:^{ [weakTask expire]; }];
    [task installIdentifier:identifier];
    return task;
}
- (id<CSBackgroundRunScheduledCheck>)scheduleAfter:(NSTimeInterval)delay handler:(dispatch_block_t)handler {
    NSAssert(NSThread.isMainThread,@"Background runtime is main-thread owned");
    return [[CSBackgroundRunTimerCheck alloc] initWithDelay:delay repeating:NO handler:handler];
}
- (id<CSBackgroundRunScheduledCheck>)scheduleEvery:(NSTimeInterval)interval handler:(dispatch_block_t)handler {
    NSAssert(NSThread.isMainThread,@"Background runtime is main-thread owned");
    return [[CSBackgroundRunTimerCheck alloc] initWithDelay:interval repeating:YES handler:handler];
}
@end
