//
// CSReceiveRedEnvelopOperation.h
// 抢红包操作
//

#import <Foundation/Foundation.h>

@class CSRedEnvelopParam;

NS_ASSUME_NONNULL_BEGIN

typedef void(^CSRedEnvelopResultBlock)(BOOL success, NSError * _Nullable error);

@interface CSReceiveRedEnvelopOperation : NSOperation

- (instancetype)initWithRedEnvelopParam:(CSRedEnvelopParam *)param delay:(unsigned int)delaySeconds;

@property (nonatomic, copy, nullable) CSRedEnvelopResultBlock resultBlock;

@property (nonatomic, assign) NSInteger maxRetryCount;

@end

NS_ASSUME_NONNULL_END
