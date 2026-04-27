//
// CSRedEnvelopTaskManager.h
// 红包任务管理器
//

#import <Foundation/Foundation.h>

@class CSReceiveRedEnvelopOperation;

NS_ASSUME_NONNULL_BEGIN

@interface CSRedEnvelopTaskManager : NSObject

+ (instancetype)sharedManager;

- (void)addNormalTask:(CSReceiveRedEnvelopOperation *)task;
- (void)addSerialTask:(CSReceiveRedEnvelopOperation *)task;

- (BOOL)serialQueueIsEmpty;

@end

NS_ASSUME_NONNULL_END
