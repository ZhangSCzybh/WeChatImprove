//
// CSRedEnvelopParam.m
// 红包参数模型实现
//

#import "CSRedEnvelopParam.h"

@implementation CSRedEnvelopParam

- (NSDictionary *)toParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.msgType) params[@"msgType"] = self.msgType;
    if (self.sendId) params[@"sendId"] = self.sendId;
    if (self.channelId) params[@"channelId"] = self.channelId;
    if (self.nickName) params[@"nickName"] = self.nickName;
    if (self.headImg) params[@"headImg"] = self.headImg;
    if (self.nativeUrl) params[@"nativeUrl"] = self.nativeUrl;
    if (self.sessionUserName) params[@"sessionUserName"] = self.sessionUserName;
    if (self.timingIdentifier) params[@"timingIdentifier"] = self.timingIdentifier;
    if (self.sign) params[@"sign"] = self.sign;
    
    params[@"agreeDuty"] = @"0";
    params[@"inWay"] = @"0";
    
    return [params copy];
}

@end
