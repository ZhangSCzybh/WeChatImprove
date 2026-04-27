//
// CSRedEnvelopConfig.h
// 红包配置管理
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CSRedEnvelopNotifyTarget) {
    CSRedEnvelopNotifyTargetDisabled = 0,
    CSRedEnvelopNotifyTargetSelf = 1,
    CSRedEnvelopNotifyTargetFileHelper = 2,
};

@interface CSRedEnvelopConfig : NSObject

+ (instancetype)sharedConfig;

- (void)reload;

@property (assign, nonatomic) BOOL autoReceiveEnable;
@property (assign, nonatomic) BOOL privateRedEnvelopEnable;
@property (assign, nonatomic) BOOL groupRedEnvelopEnable;
@property (assign, nonatomic) NSInteger delaySeconds;
@property (assign, nonatomic) BOOL receiveSelfRedEnvelop;
@property (assign, nonatomic) BOOL serialReceive;
@property (assign, nonatomic) NSInteger groupRedEnvelopScope;
@property (strong, nonatomic, nullable) NSArray *allowedGroupList;
@property (strong, nonatomic, nullable) NSArray *blockedGroupList;
@property (copy, nonatomic, nullable) NSString *privateAutoReplyText;
@property (copy, nonatomic, nullable) NSString *groupAutoReplyText;
@property (assign, nonatomic) NSInteger redEnvelopNotifyTarget;
@property (assign, nonatomic) BOOL receiveDonePageSummaryEnable;

// 领取记录统计
@property (assign, nonatomic, readonly) NSInteger totalReceiveCount;
@property (assign, nonatomic, readonly) long long totalReceiveAmount;

- (void)addReceiveRecordWithAmount:(NSInteger)amount;
- (void)resetReceiveRecords;

@end

NS_ASSUME_NONNULL_END
