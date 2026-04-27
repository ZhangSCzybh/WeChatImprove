//
// CSRedEnvelopParamQueue.m
// 红包参数队列实现
//

#import "CSRedEnvelopParamQueue.h"
#import "CSRedEnvelopParam.h"
#import <dispatch/dispatch.h>

@interface CSRedEnvelopParamQueue ()

@property (strong, nonatomic) NSMutableArray<CSRedEnvelopParam *> *queue;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSMutableArray<CSRedEnvelopParam *> *> *queueBySendId;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSMutableArray<CSRedEnvelopParam *> *> *queueBySign;
@property (nonatomic) dispatch_queue_t syncQueue;

@end

@implementation CSRedEnvelopParamQueue

+ (instancetype)sharedQueue {
    static CSRedEnvelopParamQueue *queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[CSRedEnvelopParamQueue alloc] init];
    });
    return queue;
}

- (instancetype)init {
    if (self = [super init]) {
        _queue = [[NSMutableArray alloc] init];
        _queueBySendId = [[NSMutableDictionary alloc] init];
        _queueBySign = [[NSMutableDictionary alloc] init];
        _syncQueue = dispatch_queue_create("com.wechat.enhance.redenvelop.queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)enqueue:(CSRedEnvelopParam *)param {
    if (!param) return;
    dispatch_sync(self.syncQueue, ^{
        [self.queue addObject:param];
        
        // 按sendId索引
        if (param.sendId.length > 0) {
            if (!self.queueBySendId[param.sendId]) {
                self.queueBySendId[param.sendId] = [NSMutableArray array];
            }
            [self.queueBySendId[param.sendId] addObject:param];
        }
        
        // 按sign索引
        if (param.sign.length > 0) {
            if (!self.queueBySign[param.sign]) {
                self.queueBySign[param.sign] = [NSMutableArray array];
            }
            [self.queueBySign[param.sign] addObject:param];
        }
    });
}

- (CSRedEnvelopParam *)dequeue {
    __block CSRedEnvelopParam *first = nil;
    dispatch_sync(self.syncQueue, ^{
        if (self.queue.count == 0) {
            return;
        }
        first = self.queue.firstObject;
        [self.queue removeObjectAtIndex:0];
        [self removeFromIndex:first];
    });
    return first;
}

- (CSRedEnvelopParam *)dequeueMatchingSign:(NSString *)sign sendId:(NSString *)sendId {
    __block CSRedEnvelopParam *matched = nil;
    dispatch_sync(self.syncQueue, ^{
        if (self.queue.count == 0) return;
        
        // 优先按sendId匹配
        if (sendId.length > 0 && self.queueBySendId[sendId].count > 0) {
            matched = self.queueBySendId[sendId].firstObject;
        }
        
        // 其次按sign匹配
        if (!matched && sign.length > 0 && self.queueBySign[sign].count > 0) {
            matched = self.queueBySign[sign].firstObject;
        }
        
        // 遍历查找
        if (!matched) {
            for (CSRedEnvelopParam *param in self.queue) {
                BOOL signMatch = (sign.length > 0 && [param.sign isEqualToString:sign]);
                BOOL sendIdMatch = (sendId.length > 0 && [param.sendId isEqualToString:sendId]);
                if (signMatch || sendIdMatch) {
                    matched = param;
                    break;
                }
            }
        }
        
        if (matched) {
            [self.queue removeObject:matched];
            [self removeFromIndex:matched];
        }
    });
    return matched;
}

- (CSRedEnvelopParam *)peek {
    __block CSRedEnvelopParam *first = nil;
    dispatch_sync(self.syncQueue, ^{
        if (self.queue.count == 0) {
            return;
        }
        first = self.queue.firstObject;
    });
    return first;
}

- (BOOL)isEmpty {
    __block BOOL empty = YES;
    dispatch_sync(self.syncQueue, ^{
        empty = (self.queue.count == 0);
    });
    return empty;
}

- (void)removeFromIndex:(CSRedEnvelopParam *)param {
    if (!param) return;
    
    if (param.sendId.length > 0 && self.queueBySendId[param.sendId]) {
        [self.queueBySendId[param.sendId] removeObject:param];
        if (self.queueBySendId[param.sendId].count == 0) {
            [self.queueBySendId removeObjectForKey:param.sendId];
        }
    }
    
    if (param.sign.length > 0 && self.queueBySign[param.sign]) {
        [self.queueBySign[param.sign] removeObject:param];
        if (self.queueBySign[param.sign].count == 0) {
            [self.queueBySign removeObjectForKey:param.sign];
        }
    }
}

@end
