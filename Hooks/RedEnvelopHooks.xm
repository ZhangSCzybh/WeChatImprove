//
// RedEnvelopHooks.xm
// 红包功能Hook
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

#import "CSRedEnvelopParam.h"
#import "CSRedEnvelopConfig.h"
#import "CSRedEnvelopParamQueue.h"
#import "CSReceiveRedEnvelopOperation.h"
#import "CSRedEnvelopTaskManager.h"
#import "CSServiceCenter.h"

// 微信红包相关类声明
@interface WCRedEnvelopesLogicMgr : NSObject
- (void)ReceiverQueryRedEnvelopesRequest:(id)arg1;
- (void)OpenRedEnvelopesRequest:(id)arg1;
- (void)OnWCToHongbaoCommonResponse:(id)arg1 Request:(id)arg2;
@end

// 支付信息类声明
@interface WCPayInfoItem : NSObject
@property (nonatomic, copy) NSString *m_c2cNativeUrl;
@end

// 消息包装类声明
@interface CMessageWrap : NSObject

@property (nonatomic, assign) unsigned int m_uiMessageType;
@property (nonatomic, copy) NSString *m_nsContent;
@property (nonatomic, copy) NSString *m_nsFromUsr;
@property (nonatomic, copy) NSString *m_nsToUsr;
@property (nonatomic, assign) unsigned int m_uiCreateTime;
@property (nonatomic, assign) unsigned int m_uiStatus;
@property (nonatomic, copy) NSString *m_nsRealChatUsr;
@property (nonatomic, strong) WCPayInfoItem *m_oWCPayInfoItem;

@end

// 消息管理类声明
@interface CMessageMgr : NSObject
- (void)AsyncOnAddMsg:(NSString *)msg MsgWrap:(CMessageWrap *)wrap;
- (void)AddMsg:(id)arg1 MsgWrap:(CMessageWrap *)arg2;
- (void)AddLocalMsg:(id)arg1 MsgWrap:(CMessageWrap *)arg2 fixTime:(_Bool)arg3 notify:(_Bool)arg4;
@end

// 联系人类声明
@interface CContact : NSObject
@property (nonatomic, copy) NSString *m_nsUsrName;
@property (nonatomic, copy) NSString *m_nsNickName;
@property (nonatomic, copy) NSString *m_nsHeadImgUrl;
- (NSString *)getContactDisplayName;
@end

// 红包请求/响应类声明
@interface HongBaoReq : NSObject
@property (nonatomic, strong) id reqText;
@property (nonatomic, assign) unsigned int cgiCmd;
@end

@interface HongBaoRes : NSObject
@property (nonatomic, strong) id retText;
@property (nonatomic, assign) int errorType;
@property (nonatomic, assign) int platRet;
@property (nonatomic, assign) unsigned int cgiCmdid;
@end

@interface SKBuiltinBuffer_t : NSObject
@property (nonatomic, strong) NSData *buffer;
@end

// WCRedEnvelopesLogicMgr 扩展声明
@interface WCRedEnvelopesLogicMgr (CSRedEnvelopExtension)
- (void)cs_handleRedEnvelopReceiverQueryResponse:(id)res request:(id)req;
- (void)cs_handleRedEnvelopOpenResponse:(id)res request:(id)req;
- (BOOL)cs_shouldReceiveRedEnvelop:(CSRedEnvelopParam *)param responseDict:(NSDictionary *)responseDict;
- (void)cs_sendRedEnvelopNotify:(NSString *)sessionUserName amount:(NSInteger)amount totalAmount:(NSInteger)totalAmount isGroup:(BOOL)isGroup;
- (BOOL)cs_sendTextMessage:(NSString *)content toSession:(NSString *)sessionUserName;
@end

// 辅助函数：判断是否是群聊名称
static BOOL CSIsChatRoomName(NSString *name) {
    if (!name || name.length == 0) return NO;
    return [name hasSuffix:@"@chatroom"];
}

// 辅助函数：判断用户名是否在列表中
static BOOL CSRedEnvelopUserNameInList(NSString *userName, NSArray *list) {
    if (!userName || userName.length == 0) return NO;
    if (!list || ![list isKindOfClass:[NSArray class]]) return NO;
    for (id item in list) {
        if ([item isKindOfClass:[NSString class]] && [item isEqualToString:userName]) {
            return YES;
        }
    }
    return NO;
}

// 辅助函数：获取联系人显示名称
static NSString *CSGetContactDisplayName(NSString *userName) {
    if (!userName || userName.length == 0) return userName;
    
    // 文件传输助手
    if ([userName isEqualToString:@"filehelper"]) {
        return @"文件传输助手";
    }
    
    // 获取联系人对象
    Class contactMgrClass = objc_getClass("CContactMgr");
    if (!contactMgrClass) return userName;
    
    id contactMgr = CSGetService(contactMgrClass);
    if (!contactMgr) return userName;
    
    // 尝试获取联系人
    id contact = nil;
    SEL getContactSel = @selector(getContactByName:);
    if ([contactMgr respondsToSelector:getContactSel]) {
        @try {
            contact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, getContactSel, userName);
        } @catch (NSException *exception) {
            NSLog(@"[红包] getContactByName异常: %@", exception);
        }
    }
    
    if (!contact) return userName;
    
    // 尝试获取显示名称：备注 > 昵称 > 别名 > 用户名
    NSArray *nameSelectors = @[@"m_nsRemark", @"m_nsNickName", @"m_nsAliasName", @"m_nsUsrName"];
    for (NSString *selName in nameSelectors) {
        SEL sel = NSSelectorFromString(selName);
        if ([contact respondsToSelector:sel]) {
            @try {
                NSString *name = ((NSString *(*)(id, SEL))objc_msgSend)(contact, sel);
                if (name.length > 0) {
                    return name;
                }
            } @catch (NSException *exception) {}
        }
    }
    
    return userName;
}

// 辅助函数：获取会话显示名称（用于通知）
static NSString *CSGetSessionDisplayName(NSString *sessionUserName) {
    if (!sessionUserName || sessionUserName.length == 0) {
        return @"当前会话";
    }
    
    BOOL isGroup = CSIsChatRoomName(sessionUserName);
    NSString *displayName = CSGetContactDisplayName(sessionUserName);
    
    // 如果获取到的还是原始ID，说明没找到名称
    if ([displayName isEqualToString:sessionUserName]) {
        if (isGroup) {
            return @"群聊(未命名群)";
        } else {
            // 私聊截取前12位
            NSString *peer = sessionUserName.length > 12 ? [sessionUserName substringToIndex:12] : sessionUserName;
            return [NSString stringWithFormat:@"私聊(%@)", peer];
        }
    }
    
    // 返回格式化名称
    if (isGroup) {
        return [NSString stringWithFormat:@"群聊(%@)", displayName];
    } else {
        return [NSString stringWithFormat:@"私聊(%@)", displayName];
    }
}

// 辅助函数：从URL中获取指定key的值
static NSString *CSQueryValueForKeyInURL(NSString *key, NSString *urlString) {
    if (!key || !urlString) return nil;
    
    NSString *queryKey = [NSString stringWithFormat:@"%@=", key];
    NSRange range = [urlString rangeOfString:queryKey];
    if (range.location == NSNotFound) return nil;
    
    NSUInteger start = range.location + queryKey.length;
    NSRange endRange = [urlString rangeOfString:@"&" options:0 range:NSMakeRange(start, urlString.length - start)];
    
    if (endRange.location == NSNotFound) {
        return [urlString substringFromIndex:start];
    } else {
        return [urlString substringWithRange:NSMakeRange(start, endRange.location - start)];
    }
}

// 辅助函数：从Buffer解析JSON或QueryString
static NSDictionary *CSParseBufferToDict(id buffer) {
    if (!buffer) return @{};
    
    @try {
        Class bufferClass = objc_getClass("SKBuiltinBuffer_t");
        NSData *data = nil;
        
        if (bufferClass && [buffer isKindOfClass:bufferClass]) {
            if ([buffer respondsToSelector:@selector(buffer)]) {
                data = [buffer buffer];
            }
        } else if ([buffer respondsToSelector:@selector(buffer)]) {
            data = [buffer buffer];
        } else if ([buffer isKindOfClass:[NSData class]]) {
            data = buffer;
        }
        
        if (!data || data.length == 0) return @{};
        
        NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!text || text.length == 0) {
            text = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
        }
        
        if (!text || text.length == 0) return @{};
        
        // 先尝试JSON解析
        NSData *jsonData = [text dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        if ([dict isKindOfClass:[NSDictionary class]] && dict.count > 0) {
            return dict;
        }
        
        // JSON解析失败，尝试QueryString解析
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSRange queryRange = [text rangeOfString:@"?"];
        NSString *query = queryRange.location != NSNotFound ? 
            [text substringFromIndex:queryRange.location + 1] : text;
        
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        for (NSString *pair in pairs) {
            NSArray *kv = [pair componentsSeparatedByString:@"="];
            if (kv.count >= 2) {
                NSString *key = [kv[0] stringByRemovingPercentEncoding];
                NSString *value = [[kv subarrayWithRange:NSMakeRange(1, kv.count - 1)] componentsJoinedByString:@"="];
                value = [value stringByRemovingPercentEncoding];
                if (key.length > 0) {
                    params[key] = value ?: @"";
                }
            } else if (kv.count == 1) {
                NSString *singleKey = kv[0];
                if (singleKey.length > 0) {
                    params[singleKey] = @"";
                }
            }
        }
        
        return [params copy];
    } @catch (NSException *exception) {
        NSLog(@"[红包] 解析Buffer异常: %@", exception);
        return @{};
    }
}

// 辅助函数：获取当前用户名
static NSString *CSGetCurrentUserName(void) {
    @try {
        Class contactMgrClass = objc_getClass("CContactMgr");
        if (!contactMgrClass) return nil;
        
        id contactMgr = CSGetService(contactMgrClass);
        if (!contactMgr) return nil;
        
        if ([contactMgr respondsToSelector:@selector(getSelfContact)]) {
            id selfContact = ((id (*)(id, SEL))objc_msgSend)(contactMgr, @selector(getSelfContact));
            if (selfContact && [selfContact respondsToSelector:@selector(m_nsUsrName)]) {
                return [selfContact m_nsUsrName];
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"[红包] 获取当前用户名异常: %@", exception);
    }
    return nil;
}

// 辅助函数：获取当前联系人
static id CSGetCurrentSelfContact(void) {
    @try {
        Class contactMgrClass = objc_getClass("CContactMgr");
        if (!contactMgrClass) return nil;
        
        id contactMgr = CSGetService(contactMgrClass);
        if (!contactMgr) return nil;
        
        if ([contactMgr respondsToSelector:@selector(getSelfContact)]) {
            return ((id (*)(id, SEL))objc_msgSend)(contactMgr, @selector(getSelfContact));
        }
    } @catch (NSException *exception) {
        NSLog(@"[红包] 获取当前联系人异常: %@", exception);
    }
    return nil;
}

// 辅助函数：格式化金额
static NSString *CSFormatCurrency(NSInteger amountInCent) {
    if (amountInCent <= 0) return @"0.00";
    double amount = ((double)amountInCent) / 100.0;
    return [NSString stringWithFormat:@"%.2f", amount];
}

// 辅助函数：获取红包命令ID
static unsigned int CSGetRedEnvelopCommandId(id res, id req) {
    unsigned int cmd = 0;
    
    // 优先从req.cgiCmd获取
    @try {
        if (req && [req respondsToSelector:@selector(cgiCmd)]) {
            cmd = [req cgiCmd];
        }
    } @catch (NSException *exception) {
        NSLog(@"[红包] 获取req.cgiCmd异常: %@", exception);
    }
    
    // 如果为0，尝试从res.cgiCmdid获取
    if (cmd == 0) {
        @try {
            if (res && [res respondsToSelector:@selector(cgiCmdid)]) {
                cmd = [res cgiCmdid];
            }
        } @catch (NSException *exception) {
            NSLog(@"[红包] 获取res.cgiCmdid异常: %@", exception);
        }
    }
    
    // 如果还是0，尝试从字典中获取
    if (cmd == 0) {
        NSDictionary *responseDict = CSParseBufferToDict([res retText]);
        if ([responseDict isKindOfClass:[NSDictionary class]]) {
            NSArray *cmdKeys = @[@"cmdId", @"cmdid", @"cgiCmd", @"cgiCmdId"];
            for (NSString *key in cmdKeys) {
                id value = responseDict[key];
                if ([value respondsToSelector:@selector(unsignedIntValue)]) {
                    cmd = [value unsignedIntValue];
                    if (cmd > 0) break;
                }
                if ([value respondsToSelector:@selector(integerValue)]) {
                    cmd = (unsigned int)[value integerValue];
                    if (cmd > 0) break;
                }
            }
        }
    }
    
    return cmd;
}

// Hook WCRedEnvelopesLogicMgr
%hook WCRedEnvelopesLogicMgr

// 红包响应处理
- (void)OnWCToHongbaoCommonResponse:(id)arg1 Request:(id)arg2 {

    
    // 自动抢红包：处理查询回包 -> 排队打开
    [self cs_handleRedEnvelopReceiverQueryResponse:arg1 request:arg2];
    // 自动回复：处理打开回包
    [self cs_handleRedEnvelopOpenResponse:arg1 request:arg2];
    %orig;
}

%new
- (void)cs_handleRedEnvelopReceiverQueryResponse:(id)res request:(id)req {
    if (!res || !req) {
        NSLog(@"[红包] 查询响应: res或req为空");
        return;
    }


    unsigned int cmdId = CSGetRedEnvelopCommandId(res, req);
    
    // 非参数查询请求（cmdId=3是查询响应）
    if (cmdId != 3) {
        return;
    }

    NSDictionary *responseDict = CSParseBufferToDict([res retText]);
    
    if (![responseDict isKindOfClass:[NSDictionary class]] || responseDict.count == 0) {
        return;
    }

    NSDictionary *requestDict = CSParseBufferToDict([req reqText]);
    if (![requestDict isKindOfClass:[NSDictionary class]]) {
        requestDict = @{};
    }

    // 检查是否已经抢过
    NSInteger receiveStatus = [responseDict[@"receiveStatus"] integerValue];
    if (receiveStatus == 2) {
        return;
    }

    // 检查红包是否被抢完
    NSInteger hbStatus = [responseDict[@"hbStatus"] integerValue];
    if (hbStatus == 4) {
        return;
    }

    // 获取timingIdentifier（没有这个字段会被判定为使用外挂）
    NSString *timingIdentifier = responseDict[@"timingIdentifier"];
    if (!timingIdentifier || timingIdentifier.length == 0) {
        return;
    }

    // 从请求中获取sign和sendId
    NSString *requestSign = requestDict[@"sign"];
    NSString *requestSendId = requestDict[@"sendId"];

    // 从队列中获取匹配的参数
    CSRedEnvelopParam *param = [[CSRedEnvelopParamQueue sharedQueue] dequeueMatchingSign:requestSign sendId:requestSendId];
    if (!param) {
        return;
    }

    // 更新timingIdentifier
    param.timingIdentifier = timingIdentifier;

    // 判断是否应该抢红包
    BOOL shouldReceive = [self cs_shouldReceiveRedEnvelop:param responseDict:responseDict];

    if (shouldReceive) {
        CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
        unsigned int delaySeconds = (unsigned int)config.delaySeconds;

        if (delaySeconds == 0) {
            // 无延迟，直接抢
            NSDictionary *params = [param toParams];
            if ([NSThread isMainThread]) {
                [self OpenRedEnvelopesRequest:params];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self OpenRedEnvelopesRequest:params];
                });
            }
        } else {
            // 有延迟，创建任务
            CSReceiveRedEnvelopOperation *operation = [[CSReceiveRedEnvelopOperation alloc] 
                initWithRedEnvelopParam:param delay:delaySeconds];
            
            if (config.serialReceive) {
                [[CSRedEnvelopTaskManager sharedManager] addSerialTask:operation];
            } else {
                [[CSRedEnvelopTaskManager sharedManager] addNormalTask:operation];
            }
        }
    }
}

%new
- (BOOL)cs_shouldReceiveRedEnvelop:(CSRedEnvelopParam *)param responseDict:(NSDictionary *)responseDict {
    CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
    
    if (!config.autoReceiveEnable) return NO;
    
    BOOL isGroupSession = CSIsChatRoomName(param.sessionUserName);
    
    if (isGroupSession) {
        // 群聊红包
        if (!config.groupRedEnvelopEnable) return NO;
        
        // 自己发的红包
        if (param.isGroupSender && !config.receiveSelfRedEnvelop) return NO;
        
        // 白名单模式（scope=1）
        if (config.groupRedEnvelopScope == 1) {
            if (!CSRedEnvelopUserNameInList(param.sessionUserName, config.allowedGroupList)) {
                return NO;
            }
        }
        // 黑名单模式（scope=2）
        else if (config.groupRedEnvelopScope == 2) {
            if (CSRedEnvelopUserNameInList(param.sessionUserName, config.blockedGroupList)) {
                return NO;
            }
        }
    } else {
        // 私聊红包
        if (!config.privateRedEnvelopEnable) return NO;
    }
    
    return YES;
}

%new
- (void)cs_handleRedEnvelopOpenResponse:(id)res request:(id)req {
    if (!res || !req) return;

    unsigned int cmdId = CSGetRedEnvelopCommandId(res, req);
    // cmdId=4 是打开响应
    if (cmdId != 4) {
        return;
    }

    CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
    
    NSDictionary *responseDict = CSParseBufferToDict([res retText]);
    NSDictionary *requestDict = CSParseBufferToDict([req reqText]);
    
    if (![responseDict isKindOfClass:[NSDictionary class]]) return;
    
    // 获取金额（尝试多种字段名）
    NSInteger amount = 0;
    NSArray *amountKeys = @[@"amount", @"receiveAmount", @"receive_amount", @"recvAmount", @"recv_amount"];
    for (NSString *key in amountKeys) {
        if (responseDict[key] && [responseDict[key] respondsToSelector:@selector(integerValue)]) {
            amount = [responseDict[key] integerValue];
            if (amount > 0) break;
        }
    }
    
    // 获取总金额（尝试多种字段名）
    NSInteger totalAmount = 0;
    NSArray *totalKeys = @[@"totalAmount", @"total_amount", @"totalFee", @"total_fee", @"totalMoney", @"total_money", @"hbTotalAmount", @"hb_total_amount"];
    for (NSString *key in totalKeys) {
        if (responseDict[key] && [responseDict[key] respondsToSelector:@selector(integerValue)]) {
            totalAmount = [responseDict[key] integerValue];
            if (totalAmount > 0) break;
        }
    }
    
    if (amount <= 0) {
        return;
    }
    
    // 获取会话（尝试多种字段名）
    NSString *sessionUserName = nil;
    NSArray *sessionKeys = @[@"sessionUserName", @"sessionusername", @"session_user_name"];
    for (NSString *key in sessionKeys) {
        sessionUserName = requestDict[key];
        if (sessionUserName && sessionUserName.length > 0) break;
    }
    
    if (!sessionUserName || sessionUserName.length == 0) {
        return;
    }
    
    BOOL isGroup = CSIsChatRoomName(sessionUserName);
    
    // 自动回复
    NSString *replyText = isGroup ? config.groupAutoReplyText : config.privateAutoReplyText;
    
    if (replyText && replyText.length > 0) {
        NSString *trimmedReply = [replyText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (trimmedReply.length > 0) {
            NSString *sessionCopy = [sessionUserName copy];
            NSString *replyCopy = [trimmedReply copy];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self cs_sendTextMessage:replyCopy toSession:sessionCopy];
            });
        }
    }
    
    // 记录领取统计
    [[CSRedEnvelopConfig sharedConfig] addReceiveRecordWithAmount:amount];
    
    // 抢到通知
    if (config.redEnvelopNotifyTarget != CSRedEnvelopNotifyTargetDisabled) {
        [self cs_sendRedEnvelopNotify:sessionUserName amount:amount totalAmount:totalAmount isGroup:isGroup];
    }
}

%new
- (void)cs_sendRedEnvelopNotify:(NSString *)sessionUserName amount:(NSInteger)amount totalAmount:(NSInteger)totalAmount isGroup:(BOOL)isGroup {
    CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
    
    NSString *notifyReceiver = nil;
    if (config.redEnvelopNotifyTarget == CSRedEnvelopNotifyTargetSelf) {
        notifyReceiver = CSGetCurrentUserName();
    } else if (config.redEnvelopNotifyTarget == CSRedEnvelopNotifyTargetFileHelper) {
        notifyReceiver = @"filehelper";
    }
    
    if (!notifyReceiver || notifyReceiver.length == 0) return;
    
    NSString *amountStr = CSFormatCurrency(amount);
    NSString *totalStr = CSFormatCurrency(totalAmount);
    
    // 获取会话显示名称
    NSString *sessionDisplayName = CSGetSessionDisplayName(sessionUserName);
    
    NSString *message = [NSString stringWithFormat:@"🎉 抢到红包提醒\n会话：%@\n本次金额：¥%@\n红包总额：¥%@\n状态：已自动领取", 
                         sessionDisplayName, amountStr, totalStr];
    
    NSString *receiverCopy = [notifyReceiver copy];
    NSString *messageCopy = [message copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cs_sendTextMessage:messageCopy toSession:receiverCopy];
    });
}

%new
- (BOOL)cs_sendTextMessage:(NSString *)content toSession:(NSString *)sessionUserName {
    if (![NSThread isMainThread]) {
        __block BOOL sentOnMain = NO;
        NSString *contentCopy = [content copy];
        NSString *sessionCopy = [sessionUserName copy];
        dispatch_sync(dispatch_get_main_queue(), ^{
            sentOnMain = [self cs_sendTextMessage:contentCopy toSession:sessionCopy];
        });
        return sentOnMain;
    }

    NSString *text = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *session = sessionUserName;
    if (text.length == 0 || session.length == 0) {
        NSLog(@"[红包] 发送消息失败: text或session为空");
        return NO;
    }

    NSString *selfUserName = CSGetCurrentUserName();
    if (selfUserName.length == 0) {
        NSLog(@"[红包] 发送消息失败: 无法获取selfUserName");
        return NO;
    }

    Class msgWrapClass = objc_getClass("CMessageWrap");
    if (!msgWrapClass) {
        NSLog(@"[红包] 发送消息失败: CMessageWrap类不可用");
        return NO;
    }

    // 尝试多种初始化方式
    id msgWrap = nil;
    
    // 方式1: initWithMsgType:nsFromUsr:
    @try {
        SEL initSel = @selector(initWithMsgType:nsFromUsr:);
        if ([msgWrapClass instancesRespondToSelector:initSel]) {
            msgWrap = ((id (*)(id, SEL, unsigned int, id))objc_msgSend)(
                [msgWrapClass alloc], initSel, 1, selfUserName);
        }
    } @catch (NSException *exception) {
        NSLog(@"[红包] initWithMsgType:nsFromUsr: 失败: %@", exception);
        msgWrap = nil;
    }
    
    // 方式2: initWithMsgType:
    if (!msgWrap) {
        @try {
            SEL initSel = @selector(initWithMsgType:);
            if ([msgWrapClass instancesRespondToSelector:initSel]) {
                msgWrap = ((id (*)(id, SEL, unsigned int))objc_msgSend)(
                    [msgWrapClass alloc], initSel, 1);
            }
        } @catch (NSException *exception) {
            NSLog(@"[红包] initWithMsgType: 失败: %@", exception);
            msgWrap = nil;
        }
    }
    
    // 方式3: init
    if (!msgWrap) {
        @try {
            msgWrap = [[msgWrapClass alloc] init];
        } @catch (NSException *exception) {
            NSLog(@"[红包] init 失败: %@", exception);
            msgWrap = nil;
        }
    }
    
    if (!msgWrap) {
        NSLog(@"[红包] 发送消息失败: 无法创建CMessageWrap实例");
        return NO;
    }

    // 设置消息属性（使用多种方式确保兼容性）
    // 消息类型
    if ([msgWrap respondsToSelector:@selector(setM_uiMessageType:)]) {
        [msgWrap setM_uiMessageType:1];
    } else {
        @try {
            [msgWrap setValue:@(1) forKey:@"m_uiMessageType"];
        } @catch (NSException *exception) {}
    }
    
    // 消息内容
    if ([msgWrap respondsToSelector:@selector(setM_nsContent:)]) {
        [msgWrap setM_nsContent:text];
    } else {
        @try {
            [msgWrap setValue:text forKey:@"m_nsContent"];
        } @catch (NSException *exception) {}
    }
    
    // 接收者
    if ([msgWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
        [msgWrap setM_nsToUsr:session];
    } else {
        @try {
            [msgWrap setValue:session forKey:@"m_nsToUsr"];
        } @catch (NSException *exception) {}
    }
    
    // 发送者
    if ([msgWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
        [msgWrap setM_nsFromUsr:selfUserName];
    } else {
        @try {
            [msgWrap setValue:selfUserName forKey:@"m_nsFromUsr"];
        } @catch (NSException *exception) {}
    }
    
    // 推送内容
    if ([msgWrap respondsToSelector:@selector(setM_nsPushContent:)]) {
        ((void (*)(id, SEL, id))objc_msgSend)(msgWrap, @selector(setM_nsPushContent:), text);
    } else {
        @try {
            [msgWrap setValue:text forKey:@"m_nsPushContent"];
        } @catch (NSException *exception) {}
    }
    
    // 创建时间
    unsigned int createTime = (unsigned int)[[NSDate date] timeIntervalSince1970];
    if ([msgWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
        [msgWrap setM_uiCreateTime:createTime];
    } else {
        @try {
            [msgWrap setValue:@(createTime) forKey:@"m_uiCreateTime"];
        } @catch (NSException *exception) {}
    }
    
    // 状态
    if ([msgWrap respondsToSelector:@selector(setM_uiStatus:)]) {
        [msgWrap setM_uiStatus:0];
    } else {
        @try {
            [msgWrap setValue:@(0) forKey:@"m_uiStatus"];
        } @catch (NSException *exception) {}
    }
    
    // 群聊需要设置m_nsRealChatUsr
    if (CSIsChatRoomName(session)) {
        if ([msgWrap respondsToSelector:@selector(setM_nsRealChatUsr:)]) {
            [msgWrap setM_nsRealChatUsr:selfUserName];
        } else {
            @try {
                [msgWrap setValue:selfUserName forKey:@"m_nsRealChatUsr"];
            } @catch (NSException *exception) {}
        }
    }

    Class msgMgrClass = objc_getClass("CMessageMgr");
    if (!msgMgrClass) {
        NSLog(@"[红包] 发送消息失败: CMessageMgr类不可用");
        return NO;
    }
    
    CMessageMgr *msgMgr = CSGetService(msgMgrClass);
    if (!msgMgr) {
        NSLog(@"[红包] 发送消息失败: 无法获取CMessageMgr实例");
        return NO;
    }
    
    // 尝试AddMsg:MsgWrap:
    if ([msgMgr respondsToSelector:@selector(AddMsg:MsgWrap:)]) {
        @try {
            [msgMgr AddMsg:session MsgWrap:msgWrap];
            return YES;
        } @catch (NSException *exception) {
            NSLog(@"[红包] AddMsg异常: %@", exception);
        }
    }
    
    // 尝试AddLocalMsg:
    if ([msgMgr respondsToSelector:@selector(AddLocalMsg:)]) {
        @try {
            ((void (*)(id, SEL, id))objc_msgSend)(msgMgr, @selector(AddLocalMsg:), msgWrap);
            return YES;
        } @catch (NSException *exception) {
            NSLog(@"[红包] AddLocalMsg异常: %@", exception);
        }
    }
    
    NSLog(@"[红包] 发送消息失败: 无可用发送方法");
    return NO;
}

%end

// Hook CMessageMgr 处理红包消息
%hook CMessageMgr

// 统一策略：同类入口先放行原生，再做插件功能
- (void)AsyncOnAddMsg:(NSString *)msg MsgWrap:(CMessageWrap *)wrap {
    %orig;

    // 消息类型49是AppNode（红包消息）
    if (wrap.m_uiMessageType != 49) return;


    // 获取红包nativeUrl
    WCPayInfoItem *payInfo = [wrap m_oWCPayInfoItem];
    
    NSString *nativeUrl = payInfo.m_c2cNativeUrl;
    
    // 如果nativeUrl为空，尝试从消息内容中解析
    if (!nativeUrl || nativeUrl.length == 0) {
        NSString *content = wrap.m_nsContent;
        
        // 尝试从content中提取nativeUrl
        NSRange urlRange = [content rangeOfString:@"nativeurl=\"" options:NSCaseInsensitiveSearch];
        if (urlRange.location != NSNotFound) {
            NSUInteger start = urlRange.location + urlRange.length;
            NSRange endRange = [content rangeOfString:@"\"" options:0 range:NSMakeRange(start, content.length - start)];
            if (endRange.location != NSNotFound) {
                nativeUrl = [content substringWithRange:NSMakeRange(start, endRange.location - start)];
            }
        }
        
        // 尝试另一种格式
        if (!nativeUrl || nativeUrl.length == 0) {
            urlRange = [content rangeOfString:@"nativeUrl=\"" options:NSCaseInsensitiveSearch];
            if (urlRange.location != NSNotFound) {
                NSUInteger start = urlRange.location + urlRange.length;
                NSRange endRange = [content rangeOfString:@"\"" options:0 range:NSMakeRange(start, content.length - start)];
                if (endRange.location != NSNotFound) {
                    nativeUrl = [content substringWithRange:NSMakeRange(start, endRange.location - start)];
                }
            }
        }
    }

    // 检查红包URL前缀
    NSString *prefix = @"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?";
    if (!nativeUrl || nativeUrl.length == 0) {
        return;
    }
    if (![nativeUrl hasPrefix:prefix]) {
        return;
    }


    CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
    if (!config.autoReceiveEnable) {
        return;
    }

    NSString *selfUserName = CSGetCurrentUserName() ?: @"";
    
    // 判断发送者
    BOOL isSender = (selfUserName.length > 0 && [wrap.m_nsFromUsr isEqualToString:selfUserName]);
    BOOL isGroupReceiver = CSIsChatRoomName(wrap.m_nsFromUsr);
    BOOL isGroupSender = (isSender && CSIsChatRoomName(wrap.m_nsToUsr));
    BOOL isGroup = (isGroupReceiver || isGroupSender);

    // 群聊红包检查
    if (isGroup) {
        if (!config.groupRedEnvelopEnable) {
            return;
        }
        if (isGroupSender && !config.receiveSelfRedEnvelop) {
            return;
        }

        NSString *groupUserName = isGroupReceiver ? wrap.m_nsFromUsr : wrap.m_nsToUsr;
        if (groupUserName.length == 0) {
            NSLog(@"[红包] 群会话为空");
            return;
        }

        // 白名单模式（scope=1）
        if (config.groupRedEnvelopScope == 1) {
            if (!CSRedEnvelopUserNameInList(groupUserName, config.allowedGroupList)) {
                return;
            }
        }
        // 黑名单模式（scope=2）
        else if (config.groupRedEnvelopScope == 2) {
            if (CSRedEnvelopUserNameInList(groupUserName, config.blockedGroupList)) {
                return;
            }
        }
    } else {
        // 私聊红包检查
        if (!config.privateRedEnvelopEnable) {
            return;
        }
    }

    // 解析红包参数
    NSString *msgType = CSQueryValueForKeyInURL(@"msgtype", nativeUrl) 
        ?: CSQueryValueForKeyInURL(@"msgType", nativeUrl);
    NSString *sendId = CSQueryValueForKeyInURL(@"sendid", nativeUrl) 
        ?: CSQueryValueForKeyInURL(@"sendId", nativeUrl);
    NSString *channelId = CSQueryValueForKeyInURL(@"channelid", nativeUrl) 
        ?: CSQueryValueForKeyInURL(@"channelId", nativeUrl);
    NSString *sign = CSQueryValueForKeyInURL(@"sign", nativeUrl);

    if (!msgType || !sendId || !channelId) {

    }


    // 创建红包参数
    CSRedEnvelopParam *param = [[CSRedEnvelopParam alloc] init];
    param.msgType = msgType;
    param.sendId = sendId;
    param.channelId = channelId;
    param.sign = sign;
    param.nativeUrl = nativeUrl;
    param.sessionUserName = isGroupSender ? wrap.m_nsToUsr : wrap.m_nsFromUsr;
    param.isGroupSender = isGroupSender;

    // 获取当前用户信息
    id selfContact = CSGetCurrentSelfContact();
    if (selfContact) {
        if ([selfContact respondsToSelector:@selector(getContactDisplayName)]) {
            param.nickName = [selfContact getContactDisplayName];
        }
        if ([selfContact respondsToSelector:@selector(m_nsHeadImgUrl)]) {
            param.headImg = [selfContact m_nsHeadImgUrl];
        }
    }

    // 加入队列
    [[CSRedEnvelopParamQueue sharedQueue] enqueue:param];

    // 发送查询请求
    NSDictionary *queryParams = @{
        @"agreeDuty": @"0",
        @"channelId": channelId ?: @"",
        @"inWay": @"0",
        @"msgType": msgType ?: @"",
        @"nativeUrl": nativeUrl ?: @"",
        @"sendId": sendId ?: @"",
    };

    Class logicMgrClass = objc_getClass("WCRedEnvelopesLogicMgr");
    
    if (logicMgrClass) {
        WCRedEnvelopesLogicMgr *logicMgr = CSGetService(logicMgrClass);
        if (logicMgr && [logicMgr respondsToSelector:@selector(ReceiverQueryRedEnvelopesRequest:)]) {
            [logicMgr ReceiverQueryRedEnvelopesRequest:[queryParams mutableCopy]];
        } else {
            NSLog(@"[红包] 无法获取WCRedEnvelopesLogicMgr");
        }
    }
}

%end

// 监听设置变化
static void CSRedEnvelopSettingsChanged(CFNotificationCenterRef center,
                                        void *observer,
                                        CFNotificationName name,
                                        const void *object,
                                        CFDictionaryRef userInfo) {
    [[CSRedEnvelopConfig sharedConfig] reload];
}

#pragma mark - 红包详情页汇总

static const void *kCSRedEnvelopSummaryLabelKey = &kCSRedEnvelopSummaryLabelKey;
static void (*cs_orig_StoryViewController_viewDidLoad)(id, SEL) = NULL;

static long long CSRedEnvelopSummaryLongLongFromObject(id obj, NSString *fieldName) {
    if (!obj || !fieldName || fieldName.length == 0) return 0;
    
    SEL sel = NSSelectorFromString(fieldName);
    if ([obj respondsToSelector:sel]) {
        @try {
            return ((long long (*)(id, SEL))objc_msgSend)(obj, sel);
        } @catch (NSException *exception) {}
    }
    
    @try {
        id value = [obj valueForKey:fieldName];
        if (value && [value respondsToSelector:@selector(longLongValue)]) {
            return [value longLongValue];
        }
        if (value && [value respondsToSelector:@selector(integerValue)]) {
            return (long long)[value integerValue];
        }
    } @catch (NSException *exception) {}
    
    return 0;
}

static id CSRedEnvelopSummaryGetData(id target) {
    if (!target) return nil;
    
    if ([target respondsToSelector:@selector(m_data)]) {
        @try {
            return ((id (*)(id, SEL))objc_msgSend)(target, @selector(m_data));
        } @catch (NSException *exception) {}
    }
    
    @try {
        return [target valueForKey:@"m_data"];
    } @catch (NSException *exception) {}
    
    return nil;
}

static id CSRedEnvelopSummaryGetDetailInfo(id data) {
    if (!data) return nil;
    
    if ([data respondsToSelector:@selector(m_oWCRedEnvelopesDetailInfo)]) {
        @try {
            return ((id (*)(id, SEL))objc_msgSend)(data, @selector(m_oWCRedEnvelopesDetailInfo));
        } @catch (NSException *exception) {}
    }
    
    @try {
        return [data valueForKey:@"m_oWCRedEnvelopesDetailInfo"];
    } @catch (NSException *exception) {}
    
    return nil;
}

static UILabel *CSRedEnvelopSummaryLabelForView(UIView *container, BOOL createIfNeeded) {
    UILabel *label = objc_getAssociatedObject(container, kCSRedEnvelopSummaryLabelKey);
    if (label || !createIfNeeded) return label;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.userInteractionEnabled = NO;
    label.hidden = NO;
    
    objc_setAssociatedObject(container, kCSRedEnvelopSummaryLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [container addSubview:label];
    
    return label;
}

static void CSRedEnvelopSummaryLayoutLabel(UIView *container, UILabel *label) {
    if (!container || !label) return;
    
    CGFloat width = CGRectGetWidth(container.frame);
    if (width <= 0) width = CGRectGetWidth(container.bounds);
    if (width <= 0) return;
    
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *scene = (UIWindowScene *)[UIApplication.sharedApplication.connectedScenes anyObject];
        if (scene) {
            statusBarHeight = scene.statusBarManager.statusBarFrame.size.height;
        }
    }
    if (statusBarHeight <= 0) {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    if (statusBarHeight <= 0) statusBarHeight = 44;
    
    label.frame = CGRectMake(0, statusBarHeight, width, 80);
}

static void CSRedEnvelopSummaryApplyToTarget(id target) {
    if (![target isKindOfClass:[UIViewController class]]) return;
    
    UIView *container = nil;
    @try {
        container = ((UIViewController *)target).view;
    } @catch (NSException *exception) {
        return;
    }
    
    if (!container) return;
    
    UILabel *existing = CSRedEnvelopSummaryLabelForView(container, NO);
    
    CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
    if (!config.receiveDonePageSummaryEnable) {
        existing.hidden = YES;
        return;
    }
    
    id data = CSRedEnvelopSummaryGetData(target);
    id detailInfo = CSRedEnvelopSummaryGetDetailInfo(data);
    
    if (!detailInfo) {
        existing.hidden = YES;
        return;
    }
    
    UILabel *label = existing ?: CSRedEnvelopSummaryLabelForView(container, YES);
    if (!label) return;
    
    long long totalAmount = CSRedEnvelopSummaryLongLongFromObject(detailInfo, @"m_lTotalAmount");
    long long totalNum = CSRedEnvelopSummaryLongLongFromObject(detailInfo, @"m_lTotalNum");
    long long recNum = CSRedEnvelopSummaryLongLongFromObject(detailInfo, @"m_lRecNum");
    long long recAmount = CSRedEnvelopSummaryLongLongFromObject(detailInfo, @"m_lRecAmount");
    
    totalAmount = MAX(0, totalAmount);
    totalNum = MAX(0, totalNum);
    recNum = MAX(0, recNum);
    recAmount = MAX(0, recAmount);
    
    long long remainNum = MAX(0, totalNum - recNum);
    long long remainAmount = MAX(0, totalAmount - recAmount);
    
    label.hidden = NO;
    label.text = [NSString stringWithFormat:@"总额：%.2f元 / 总数：%lld个\n剩余：%lld个(%.2f元)",
                  ((double)totalAmount) / 100.0,
                  totalNum,
                  remainNum,
                  ((double)remainAmount) / 100.0];
    
    CSRedEnvelopSummaryLayoutLabel(container, label);
    
}

static void CSRedEnvelopSummaryStoryViewControllerViewDidLoad(id self, SEL _cmd) {
    if (cs_orig_StoryViewController_viewDidLoad) {
        cs_orig_StoryViewController_viewDidLoad(self, _cmd);
    }
    
    @try {
        CSRedEnvelopSummaryApplyToTarget(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CSRedEnvelopSummaryApplyToTarget(self);
        });
    } @catch (NSException *exception) {
        NSLog(@"[红包] 详情页汇总异常: %@", exception);
    }
}

static void CSInstallRedEnvelopSummaryHook(void) {
    Class targetClass = objc_getClass("WCRedEnvelopesStoryViewController");
    if (!targetClass) {
        NSLog(@"[红包] 详情页汇总: WCRedEnvelopesStoryViewController类不存在");
        return;
    }
    
    Method method = class_getInstanceMethod(targetClass, @selector(viewDidLoad));
    if (!method) {
        NSLog(@"[红包] 详情页汇总: viewDidLoad方法不存在");
        return;
    }
    
    IMP newImp = (IMP)CSRedEnvelopSummaryStoryViewControllerViewDidLoad;
    IMP oldImp = method_getImplementation(method);
    if (oldImp == newImp) return;
    
    cs_orig_StoryViewController_viewDidLoad = (void (*)(id, SEL))oldImp;
    method_setImplementation(method, newImp);
    
}

%ctor {
    // 注册设置变化监听
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        CSRedEnvelopSettingsChanged,
        CFSTR("com.wechat.enhance.redenvelop.settings_changed"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
    
    // 安装红包详情页汇总Hook
    dispatch_async(dispatch_get_main_queue(), ^{
        CSInstallRedEnvelopSummaryHook();
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CSInstallRedEnvelopSummaryHook();
        });
    });
    
}
