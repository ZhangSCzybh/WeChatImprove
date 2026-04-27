//
// CSRedEnvelopTaskManager.m
// 红包任务管理器实现
//

#import "CSRedEnvelopTaskManager.h"
#import "CSReceiveRedEnvelopOperation.h"

static const NSInteger kCSMaxConcurrentRedEnvelopTasks = 5;
static const NSInteger kCSSerialQueueConcurrency = 1;

@interface CSRedEnvelopTaskManager ()

@property (strong, nonatomic) NSOperationQueue *normalTaskQueue;
@property (strong, nonatomic) NSOperationQueue *serialTaskQueue;

@end

@implementation CSRedEnvelopTaskManager

+ (instancetype)sharedManager {
    static CSRedEnvelopTaskManager *taskManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        taskManager = [CSRedEnvelopTaskManager new];
    });
    return taskManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _serialTaskQueue = [[NSOperationQueue alloc] init];
        _serialTaskQueue.maxConcurrentOperationCount = kCSSerialQueueConcurrency;
        
        _normalTaskQueue = [[NSOperationQueue alloc] init];
        _normalTaskQueue.maxConcurrentOperationCount = kCSMaxConcurrentRedEnvelopTasks;
    }
    return self;
}

- (void)addNormalTask:(CSReceiveRedEnvelopOperation *)task {
    [self.normalTaskQueue addOperation:task];
}

- (void)addSerialTask:(CSReceiveRedEnvelopOperation *)task {
    [self.serialTaskQueue addOperation:task];
}

- (BOOL)serialQueueIsEmpty {
    return [self.serialTaskQueue operations].count == 0;
}

@end
