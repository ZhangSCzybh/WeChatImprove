//
// CSReceiveRedEnvelopOperation.m
// 抢红包操作实现
//

#import "CSReceiveRedEnvelopOperation.h"
#import "CSRedEnvelopParam.h"
#import "CSRedEnvelopConfig.h"
#import "CSServiceCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <dispatch/dispatch.h>

static NSTimeInterval const kCSOperationTimeout = 30.0;
static NSTimeInterval const kCSLogicMgrRetrySleepInterval = 0.08;

@interface CSReceiveRedEnvelopOperation ()

@property (assign, nonatomic, getter=isExecuting) BOOL executing;
@property (assign, nonatomic, getter=isFinished) BOOL finished;
@property (strong, nonatomic) CSRedEnvelopParam *redEnvelopParam;
@property (assign, nonatomic) unsigned int delaySeconds;

@end

@implementation CSReceiveRedEnvelopOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithRedEnvelopParam:(CSRedEnvelopParam *)param delay:(unsigned int)delaySeconds {
    if (self = [super init]) {
        _redEnvelopParam = param;
        _delaySeconds = delaySeconds;
        _maxRetryCount = 3;
    }
    return self;
}

- (void)start {
    if (self.isCancelled) {
        [self completeOperation];
        return;
    }
    
    self.executing = YES;
    
    
    __weak typeof(self) weakSelf = self;
    
    // 超时保护
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kCSOperationTimeout * NSEC_PER_SEC)),
                   dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf && strongSelf.isExecuting && !strongSelf.isFinished) {
            NSLog(@"[抢红包] 操作超时: sendId=%@", strongSelf.redEnvelopParam.sendId ?: @"");
            [strongSelf cancel];
        }
    });
    
    if (self.delaySeconds == 0) {
        [self main];
        [self completeOperation];
        return;
    }
    
    uint64_t delayNsec = (uint64_t)self.delaySeconds * NSEC_PER_SEC;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, delayNsec);
    dispatch_after(when, dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        __strong typeof(weakSelf) self = weakSelf;
        if (!self) return;
        if (self.isCancelled) {
            [self completeOperation];
            return;
        }
        [self main];
        [self completeOperation];
    });
}

- (void)main {
    NSDictionary *params = [self.redEnvelopParam toParams];
    
    
    NSInteger maxRetry = self.maxRetryCount > 0 ? self.maxRetryCount : 1;
    BOOL didSchedule = NO;
    
    for (NSInteger attempt = 1; attempt <= maxRetry; attempt++) {
        if (self.isCancelled) {
            break;
        }
        
        // 获取红包逻辑管理器
        id logicMgr = nil;
        @try {
            Class logicMgrClass = objc_getClass("WCRedEnvelopesLogicMgr");
            if (logicMgrClass) {
                logicMgr = CSGetService(logicMgrClass);
            }
        } @catch (NSException *exception) {
            NSLog(@"[抢红包] 获取logicMgr异常: %@", exception);
        }
        
        if (!logicMgr) {
            NSLog(@"[抢红包] logicMgr=nil，准备重试(%ld/%ld) sendId=%@",
                  (long)attempt, (long)maxRetry, self.redEnvelopParam.sendId ?: @"");
            if (attempt < maxRetry) {
                [NSThread sleepForTimeInterval:kCSLogicMgrRetrySleepInterval];
                continue;
            }
            break;
        }
        
        if (![logicMgr respondsToSelector:@selector(OpenRedEnvelopesRequest:)]) {
            NSLog(@"[抢红包] OpenRedEnvelopesRequest 不存在");
            break;
        }
        
        didSchedule = YES;
        
        void (^performOpen)(void) = ^{
            if (self.isCancelled) return;
            @try {
                ((void (*)(id, SEL, id))objc_msgSend)(logicMgr, @selector(OpenRedEnvelopesRequest:), params);
            } @catch (NSException *exception) {
                NSLog(@"[抢红包] 调用异常: %@", exception);
            }
        };
        
        if ([NSThread isMainThread]) {
            performOpen();
        } else {
            dispatch_sync(dispatch_get_main_queue(), performOpen);
        }
        break;
    }
    
    if (!didSchedule) {
        NSLog(@"[抢红包] 任务失败: sendId=%@", self.redEnvelopParam.sendId ?: @"");
    }
}

- (void)cancel {
    [super cancel];
}

- (void)completeOperation {
    self.executing = NO;
    self.finished = YES;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end
