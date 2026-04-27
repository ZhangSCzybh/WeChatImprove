//
// CSRedEnvelopParamQueue.h
// 红包参数队列
//

#import <Foundation/Foundation.h>

@class CSRedEnvelopParam;

NS_ASSUME_NONNULL_BEGIN

@interface CSRedEnvelopParamQueue : NSObject

+ (instancetype)sharedQueue;

- (void)enqueue:(CSRedEnvelopParam *)param;
- (CSRedEnvelopParam * _Nullable)dequeue;
- (CSRedEnvelopParam * _Nullable)dequeueMatchingSign:(NSString * _Nullable)sign sendId:(NSString * _Nullable)sendId;
- (CSRedEnvelopParam * _Nullable)peek;
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
