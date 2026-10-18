//
// CSRedEnvelopConfig.m
// 红包配置管理实现
//

#import "CSRedEnvelopConfig.h"
#import <dispatch/dispatch.h>

// UserDefaults Key常量定义
static NSString * const kRedEnvelopAutoReceiveKey = @"com.wechat.enhance.redenvelop.autoReceive";
static NSString * const kRedEnvelopPrivateEnableKey = @"com.wechat.enhance.redenvelop.privateEnable";
static NSString * const kRedEnvelopGroupEnableKey = @"com.wechat.enhance.redenvelop.groupEnable";
static NSString * const kRedEnvelopDelayKey = @"com.wechat.enhance.redenvelop.delay";
static NSString * const kRedEnvelopReceiveSelfKey = @"com.wechat.enhance.redenvelop.receiveSelf";
static NSString * const kRedEnvelopSerialReceiveKey = @"com.wechat.enhance.redenvelop.serialReceive";
static NSString * const kRedEnvelopGroupScopeKey = @"com.wechat.enhance.redenvelop.groupScope";
static NSString * const kRedEnvelopAllowedGroupsKey = @"com.wechat.enhance.redenvelop.allowedGroups";
static NSString * const kRedEnvelopBlockedGroupsKey = @"com.wechat.enhance.redenvelop.blockedGroups";
static NSString * const kRedEnvelopPrivateReplyKey = @"com.wechat.enhance.redenvelop.privateReply";
static NSString * const kRedEnvelopGroupReplyKey = @"com.wechat.enhance.redenvelop.groupReply";
static NSString * const kRedEnvelopNotifyTargetKey = @"com.wechat.enhance.redenvelop.notifyTarget";
static NSString * const kRedEnvelopPageSummaryKey = @"com.wechat.enhance.redenvelop.pageSummary";
static NSString * const kRedEnvelopTotalCountKey = @"com.wechat.enhance.redenvelop.totalCount";
static NSString * const kRedEnvelopTotalAmountKey = @"com.wechat.enhance.redenvelop.totalAmount";

@interface CSRedEnvelopConfig ()

@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, assign, readwrite) NSInteger totalReceiveCount;
@property (nonatomic, assign, readwrite) long long totalReceiveAmount;

@end

@implementation CSRedEnvelopConfig

+ (instancetype)sharedConfig {
    static CSRedEnvelopConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[CSRedEnvelopConfig alloc] init];
    });
    return config;
}

- (instancetype)init {
    if (self = [super init]) {
        _defaults = [NSUserDefaults standardUserDefaults];
        [self loadConfig];
    }
    return self;
}

- (void)loadConfig {
    _autoReceiveEnable = [self.defaults boolForKey:kRedEnvelopAutoReceiveKey];
    _privateRedEnvelopEnable = [self.defaults boolForKey:kRedEnvelopPrivateEnableKey];
    
    // 群红包默认开启
    id groupEnableValue = [self.defaults objectForKey:kRedEnvelopGroupEnableKey];
    _groupRedEnvelopEnable = groupEnableValue ? [groupEnableValue boolValue] : YES;
    
    _delaySeconds = [self.defaults integerForKey:kRedEnvelopDelayKey];
    _receiveSelfRedEnvelop = [self.defaults boolForKey:kRedEnvelopReceiveSelfKey];
    _serialReceive = [self.defaults boolForKey:kRedEnvelopSerialReceiveKey];
    _groupRedEnvelopScope = [self.defaults integerForKey:kRedEnvelopGroupScopeKey];
    _allowedGroupList = [self.defaults arrayForKey:kRedEnvelopAllowedGroupsKey];
    _blockedGroupList = [self.defaults arrayForKey:kRedEnvelopBlockedGroupsKey];
    _privateAutoReplyText = [self.defaults stringForKey:kRedEnvelopPrivateReplyKey];
    _groupAutoReplyText = [self.defaults stringForKey:kRedEnvelopGroupReplyKey];
    _redEnvelopNotifyTarget = [self.defaults integerForKey:kRedEnvelopNotifyTargetKey];
    _receiveDonePageSummaryEnable = [self.defaults boolForKey:kRedEnvelopPageSummaryKey];
    
    // 加载领取记录统计
    _totalReceiveCount = [self.defaults integerForKey:kRedEnvelopTotalCountKey];
    _totalReceiveAmount = [[self.defaults objectForKey:kRedEnvelopTotalAmountKey] longLongValue];
}

- (void)reload {
    [self loadConfig];
}

- (void)addReceiveRecordWithAmount:(NSInteger)amount {
    _totalReceiveCount++;
    _totalReceiveAmount += amount;
    
    [self.defaults setInteger:_totalReceiveCount forKey:kRedEnvelopTotalCountKey];
    [self.defaults setObject:@(_totalReceiveAmount) forKey:kRedEnvelopTotalAmountKey];
    [self.defaults synchronize];
    
}

- (void)resetReceiveRecords {
    _totalReceiveCount = 0;
    _totalReceiveAmount = 0;
    
    [self.defaults setInteger:0 forKey:kRedEnvelopTotalCountKey];
    [self.defaults setObject:@0 forKey:kRedEnvelopTotalAmountKey];
    [self.defaults synchronize];
    
}

@end
