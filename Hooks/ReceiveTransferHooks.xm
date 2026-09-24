//
// ReceiveTransferHooks.xm
// 自动收款功能Hook
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

#import "CSServiceCenter.h"

typedef NS_ENUM(NSInteger, CSTransferNotifyTarget) {
    CSTransferNotifyTargetDisabled = 0,
    CSTransferNotifyTargetSelf = 1,
    CSTransferNotifyTargetFileHelper = 2,
};

static NSString * const kReceiveTransferAutoEnableKey = @"kReceiveTransferAutoEnableKey";
static NSString * const kReceiveTransferPrivateEnableKey = @"kReceiveTransferPrivateEnableKey";
static NSString * const kReceiveTransferGroupEnableKey = @"kReceiveTransferGroupEnableKey";
static NSString * const kReceiveTransferDelayKey = @"kReceiveTransferDelayKey";
static NSString * const kReceiveTransferNotifyTargetKey = @"kReceiveTransferNotifyTargetKey";
static NSString * const kReceiveTransferAutoReplyEnableKey = @"kReceiveTransferAutoReplyEnableKey";
static NSString * const kReceiveTransferPrivateAutoReplyKey = @"kReceiveTransferPrivateAutoReplyKey";
static NSString * const kReceiveTransferGroupAutoReplyKey = @"kReceiveTransferGroupAutoReplyKey";
static NSString * const kReceiveTransferTotalCountKey = @"kReceiveTransferTotalCountKey";
static NSString * const kReceiveTransferTotalAmountKey = @"kReceiveTransferTotalAmountKey";

@interface CMessageWrap : NSObject

@property (nonatomic, assign) unsigned int m_uiMessageType;
@property (nonatomic, copy) NSString *m_nsContent;
@property (nonatomic, copy) NSString *m_nsFromUsr;
@property (nonatomic, copy) NSString *m_nsToUsr;
@property (nonatomic, assign) unsigned int m_uiCreateTime;
@property (nonatomic, assign) unsigned int m_uiStatus;
@property (nonatomic, copy) NSString *m_nsRealChatUsr;
@property (nonatomic, strong) id m_oWCPayInfoItem;
@property (nonatomic, assign) long long m_n64MesLocalID;
@property (nonatomic, copy) NSString *m_nsMsgLocalId;

@end

@interface CContact : NSObject
@property (nonatomic, copy) NSString *m_nsUsrName;
@property (nonatomic, copy) NSString *m_nsNickName;
@property (nonatomic, copy) NSString *m_nsRemark;
@property (nonatomic, copy) NSString *m_nsAliasName;
- (NSString *)getContactDisplayName;
@end

@interface CMessageMgr : NSObject
- (void)AsyncOnAddMsg:(NSString *)msg MsgWrap:(CMessageWrap *)wrap;
- (void)AddMsg:(id)arg1 MsgWrap:(CMessageWrap *)arg2;
- (void)AddLocalMsg:(id)arg1 MsgWrap:(CMessageWrap *)arg2 fixTime:(BOOL)arg3 notify:(BOOL)arg4;
@end

@interface WCPayInfoItem : NSObject
@property (nonatomic, copy) NSString *m_c2cNativeUrl;
@end

@interface WCPayConfirmTransferRequest : NSObject
@property (nonatomic, copy) NSString *m_nsTransferID;
@property (nonatomic, copy) NSString *m_nsFromUserName;
@property (nonatomic, assign) unsigned long long m_uiInvalidTime;
@property (nonatomic, assign) unsigned int recv_channel_type;
@property (nonatomic, assign) unsigned int groupType;
@property (nonatomic, copy) NSString *group_username;
@end

@interface WCPayConfirmTransferResponse : NSObject
@property (nonatomic, assign) long long m_llFee;
@property (nonatomic, copy) NSString *m_nsFeeType;
@property (nonatomic, copy) NSString *m_nsPayer;
@property (nonatomic, copy) NSString *m_nsReceiver;
@end

@interface WCPayReveiverControlTransferControlLogic : NSObject
- (void)OnWCPayTransferMoneyStatusViewControllerConfirmTransfer;
- (void)OnConfirmTransferMoney:(id)arg1 Error:(id)arg2;
- (id)initWithData:(id)arg1;
- (void)startLogic;
- (void)stopLogic;
@end

@interface WCPayControlData : NSObject
@property (nonatomic, retain) NSString *m_nsTransferID;
@property (nonatomic, retain) NSString *m_nsSelectedUserNameFromQRCode;
@property (nonatomic) unsigned long long m_uiTransferInvalidTime;
@property (nonatomic, retain) NSString *selectedTransferChatroomUsername;
@end

@interface WCPayControlMgr : NSObject
+ (instancetype)defaultManager;
- (unsigned int)startReceiverConfirmTransferMoneyLogic:(id)arg1 Data:(id)arg2;
@end

@interface WCPayLogicMgr : NSObject
- (void)ConfirmTransferMoney:(id)arg1;
- (void)insideCallBackOnConfirmTransferMoneyResponse:(id)arg1 OnRequest:(id)arg2;
@end

static BOOL CSIsChatRoomName(NSString *name) {
    if (!name || name.length == 0) return NO;
    return [name hasSuffix:@"@chatroom"];
}

static UIViewController *cs_findViewController(UIViewController *vc, NSString *className) {
    if (!vc || !className) return nil;
    
    if ([NSStringFromClass([vc class]) isEqualToString:className]) {
        return vc;
    }
    
    // 检查子ViewController
    for (UIViewController *child in vc.childViewControllers) {
        UIViewController *found = cs_findViewController(child, className);
        if (found) return found;
    }
    
    // 检查导航控制器
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        for (UIViewController *child in nav.viewControllers) {
            UIViewController *found = cs_findViewController(child, className);
            if (found) return found;
        }
    }
    
    // 检查标签栏控制器
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        for (UIViewController *child in tab.viewControllers) {
            UIViewController *found = cs_findViewController(child, className);
            if (found) return found;
        }
    }
    
    return nil;
}

static NSString *CSGetContactDisplayName(NSString *userName) {
    if (!userName || userName.length == 0) return userName;
    
    if ([userName isEqualToString:@"filehelper"]) {
        return @"文件传输助手";
    }
    
    Class contactMgrClass = objc_getClass("CContactMgr");
    if (!contactMgrClass) return userName;
    
    id contactMgr = CSGetService(contactMgrClass);
    if (!contactMgr) return userName;
    
    SEL getContactSel = @selector(getContactByName:);
    if ([contactMgr respondsToSelector:getContactSel]) {
        @try {
            id contact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, getContactSel, userName);
            if (contact) {
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
            }
        } @catch (NSException *exception) {
            NSLog(@"[自动收款] getContactByName异常: %@", exception);
        }
    }
    
    return userName;
}

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
        NSLog(@"[自动收款] 获取当前用户名异常: %@", exception);
    }
    return nil;
}

static BOOL isReceiveTransferEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kReceiveTransferAutoEnableKey];
}

static BOOL isPrivateReceiveEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kReceiveTransferPrivateEnableKey];
}

static BOOL isGroupReceiveEnabled() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id value = [defaults objectForKey:kReceiveTransferGroupEnableKey];
    return value ? [value boolValue] : YES;
}

static NSInteger getDelaySeconds() {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kReceiveTransferDelayKey];
}

static NSInteger getNotifyTarget() {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kReceiveTransferNotifyTargetKey];
}

static BOOL isAutoReplyEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kReceiveTransferAutoReplyEnableKey];
}

static NSString *getPrivateAutoReplyContent() {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kReceiveTransferPrivateAutoReplyKey];
}

static NSString *getGroupAutoReplyContent() {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kReceiveTransferGroupAutoReplyKey];
}

static BOOL CSSendTextMessage(NSString *content, NSString *sessionUserName) {
    if (!content || content.length == 0 || !sessionUserName || sessionUserName.length == 0) {
        return NO;
    }
    
    NSString *selfUserName = CSGetCurrentUserName();
    if (!selfUserName || selfUserName.length == 0) {
        return NO;
    }
    
    Class msgMgrClass = NSClassFromString(@"CMessageMgr");
    if (!msgMgrClass) return NO;
    
    id msgMgr = CSGetService(msgMgrClass);
    if (!msgMgr) return NO;
    
    Class msgWrapClass = NSClassFromString(@"CMessageWrap");
    if (!msgWrapClass) return NO;
    
    // 尝试多种初始化方式
    id msgWrap = nil;
    
    // 方式1: initWithMsgType:nsFromUsr:
    @try {
        SEL initSel = NSSelectorFromString(@"initWithMsgType:nsFromUsr:");
        if ([msgWrapClass instancesRespondToSelector:initSel]) {
            msgWrap = ((id (*)(id, SEL, unsigned int, id))objc_msgSend)(
                [msgWrapClass alloc], initSel, 1, selfUserName);
        }
    } @catch (NSException *exception) {
        msgWrap = nil;
    }
    
    // 方式2: initWithMsgType:
    if (!msgWrap) {
        @try {
            SEL initSel = NSSelectorFromString(@"initWithMsgType:");
            if ([msgWrapClass instancesRespondToSelector:initSel]) {
                msgWrap = ((id (*)(id, SEL, unsigned int))objc_msgSend)(
                    [msgWrapClass alloc], initSel, 1);
            }
        } @catch (NSException *exception) {
            msgWrap = nil;
        }
    }
    
    // 方式3: init
    if (!msgWrap) {
        @try {
            msgWrap = [[msgWrapClass alloc] init];
        } @catch (NSException *exception) {
            msgWrap = nil;
        }
    }
    
    if (!msgWrap) return NO;
    
    @try {
        // 设置消息属性
        if ([msgWrap respondsToSelector:@selector(setM_uiMessageType:)]) {
            [msgWrap setM_uiMessageType:1];
        } else {
            @try {
                [msgWrap setValue:@(1) forKey:@"m_uiMessageType"];
            } @catch (NSException *exception) {}
        }
        
        // 消息内容
        if ([msgWrap respondsToSelector:@selector(setM_nsContent:)]) {
            [msgWrap setM_nsContent:content];
        } else {
            @try {
                [msgWrap setValue:content forKey:@"m_nsContent"];
            } @catch (NSException *exception) {}
        }
        
        // 接收者
        if ([msgWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
            [msgWrap setM_nsToUsr:sessionUserName];
        } else {
            @try {
                [msgWrap setValue:sessionUserName forKey:@"m_nsToUsr"];
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
            [msgWrap setM_uiStatus:1];
        } else {
            @try {
                [msgWrap setValue:@(1) forKey:@"m_uiStatus"];
            } @catch (NSException *exception) {}
        }
        
        SEL addMsgSelector = NSSelectorFromString(@"AddMsg:MsgWrap:");
        if ([msgMgr respondsToSelector:addMsgSelector]) {
            ((void (*)(id, SEL, id, id))objc_msgSend)(msgMgr, addMsgSelector, sessionUserName, msgWrap);
            return YES;
        }
    } @catch (NSException *e) {
        NSLog(@"[自动收款] 发送消息失败: %@", e);
    }
    return NO;
}

static void cs_sendTransferNotification(NSString *sessionName, NSInteger amount, NSString *payerName, BOOL isGroup) {
    NSInteger notifyTarget = getNotifyTarget();
    
    if (notifyTarget == CSTransferNotifyTargetDisabled) {
        return;
    }
    
    NSString *notifyReceiver = nil;
    if (notifyTarget == CSTransferNotifyTargetSelf) {
        notifyReceiver = CSGetCurrentUserName();
    } else if (notifyTarget == CSTransferNotifyTargetFileHelper) {
        notifyReceiver = @"filehelper";
    }
    
    if (!notifyReceiver || notifyReceiver.length == 0) {
        return;
    }
    
    NSString *amountStr = [NSString stringWithFormat:@"%.2f", (double)amount / 100.0];
    NSString *chatType = nil;
    
    if (isGroup) {
        NSString *groupName = CSGetContactDisplayName(sessionName);
        chatType = [NSString stringWithFormat:@"%@", groupName];
    } else {
        chatType = @"私聊";
    }
    
    NSString *message = [NSString stringWithFormat:@"💰 收到转账提醒\n发送者：%@（%@）\n金额：¥%@\n状态：已自动收款", 
                         payerName ?: @"用户", chatType, amountStr];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CSSendTextMessage(message, notifyReceiver);
    });
}

static void cs_confirmTransfer(CMessageWrap *msgWrap, BOOL isGroup, NSString *fromUsr, NSString *toUsr);

static void cs_handleTransferMessage(CMessageWrap *msgWrap) {
    if (!msgWrap) {
        return;
    }
    
    if (!isReceiveTransferEnabled()) {
        return;
    }
    
    unsigned int msgType = [msgWrap m_uiMessageType];
    
    // 转账消息是type=49的AppNode消息
    if (msgType != 49) {
        return;
    }
    
    // 获取消息内容
    NSString *content = [msgWrap m_nsContent];
    
    // 检查是否是转账消息
    BOOL isTransfer = NO;
    
    // 方法1: 检查WCPayInfoItem中的nativeUrl
    id payInfo = [msgWrap m_oWCPayInfoItem];
    NSString *nativeUrl = nil;
    
    if (payInfo) {
        if ([payInfo respondsToSelector:@selector(m_c2cNativeUrl)]) {
            nativeUrl = [payInfo m_c2cNativeUrl];
        }
    }
    
    // 检查nativeUrl是否包含转账标识
    if (nativeUrl && ([nativeUrl containsString:@"transfer"] || [nativeUrl containsString:@"Transfer"])) {
        isTransfer = YES;
    }
    
    // 方法2: 从content中检查
    if (!isTransfer && content) {
        if ([content containsString:@"transfer"] || [content containsString:@"Transfer"] ||
            [content containsString:@"转账"]) {
            isTransfer = YES;
        }
    }
    
    if (!isTransfer) {
        return;
    }
    
    
    // 检查paysubtype，避免重复处理
    // paysubtype=1: 收到转账消息
    // paysubtype=3: 收款成功回执消息
    NSString *paySubType = nil;
    
    // 从XML中提取paysubtype（支持CDATA和非CDATA两种格式）
    NSRange paySubTypeStart = [content rangeOfString:@"<paysubtype>"];
    if (paySubTypeStart.location != NSNotFound) {
        NSUInteger start = paySubTypeStart.location + paySubTypeStart.length;
        NSRange paySubTypeEnd = [content rangeOfString:@"</paysubtype>" options:0 range:NSMakeRange(start, content.length - start)];
        if (paySubTypeEnd.location != NSNotFound) {
            NSString *value = [content substringWithRange:NSMakeRange(start, paySubTypeEnd.location - start)];
            // 清理CDATA标记
            value = [value stringByReplacingOccurrencesOfString:@"<![CDATA[" withString:@""];
            value = [value stringByReplacingOccurrencesOfString:@"]]>" withString:@""];
            value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            paySubType = value;
        }
    }
    
    // 只处理paysubtype=1的收款消息，跳过paysubtype=3的回执消息
    if (paySubType && ![paySubType isEqualToString:@"1"]) {
        return;
    }
    
    NSString *fromUsr = [msgWrap m_nsFromUsr];
    NSString *toUsr = [msgWrap m_nsToUsr];
    
    if (!fromUsr || fromUsr.length == 0) {
        return;
    }
    
    NSString *selfUserName = CSGetCurrentUserName();
    
    // 判断是否群聊：检查fromUsr或toUsr是否为群聊ID
    BOOL isGroup = CSIsChatRoomName(fromUsr) || CSIsChatRoomName(toUsr);
    
    if (isGroup) {
        if (!isGroupReceiveEnabled()) {
            return;
        }
    } else {
        if (!isPrivateReceiveEnabled()) {
            return;
        }
    }
    
    if (!content || content.length == 0) {
        return;
    }
    
    
    NSInteger delaySeconds = getDelaySeconds();
    if (delaySeconds > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cs_confirmTransfer(msgWrap, isGroup, fromUsr, toUsr);
        });
    } else {
        cs_confirmTransfer(msgWrap, isGroup, fromUsr, toUsr);
    }
}

static void cs_confirmTransfer(CMessageWrap *msgWrap, BOOL isGroup, NSString *fromUsr, NSString *toUsr) {
    if (!msgWrap) {
        return;
    }
    
    
    NSString *content = [msgWrap m_nsContent];
    
    
    NSString *transferId = nil;
    NSString *payerName = nil;
    NSInteger amount = 0;
    
    // 转账消息内容是XML格式，需要从XML中解析transferid
    if (content && content.length > 0) {
        
        // 方法1: 使用正则表达式从XML中提取transferid
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression 
            regularExpressionWithPattern:@"<transferid><!?\\[CDATA\\[(.+?)\\]\\]></transferid>" 
            options:NSRegularExpressionCaseInsensitive 
            error:&error];
        
        if (regex && !error) {
            NSTextCheckingResult *match = [regex firstMatchInString:content options:0 range:NSMakeRange(0, content.length)];
            if (match && match.numberOfRanges >= 2) {
                transferId = [content substringWithRange:[match rangeAtIndex:1]];
            }
        }
        
        // 提取金额
        NSRegularExpression *amountRegex = [NSRegularExpression 
            regularExpressionWithPattern:@"<feedesc><!?\\[CDATA\\[￥?(.+?)\\]\\]></feedesc>" 
            options:NSRegularExpressionCaseInsensitive 
            error:&error];
        
        if (amountRegex && !error) {
            NSTextCheckingResult *match = [amountRegex firstMatchInString:content options:0 range:NSMakeRange(0, content.length)];
            if (match && match.numberOfRanges >= 2) {
                NSString *amountStr = [content substringWithRange:[match rangeAtIndex:1]];
                // 将金额字符串转换为分（整数）
                NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
                NSString *cleanAmount = [[amountStr componentsSeparatedByCharactersInSet:nonDigits] componentsJoinedByString:@""];
                if (cleanAmount.length > 0) {
                    // 假设金额是元，转换为分
                    double amountDouble = [amountStr doubleValue];
                    amount = (NSInteger)(amountDouble * 100);
                }
            }
        }
        
        // 方法2: 如果正则失败，尝试简单字符串查找
        if (!transferId || transferId.length == 0) {
            NSRange startRange = [content rangeOfString:@"<transferid>"];
            if (startRange.location != NSNotFound) {
                NSUInteger start = startRange.location + startRange.length;
                
                // 查找<![CDATA[
                NSRange cdataStart = [content rangeOfString:@"<![CDATA[" options:0 range:NSMakeRange(start, content.length - start)];
                if (cdataStart.location != NSNotFound) {
                    NSUInteger valueStart = cdataStart.location + cdataStart.length;
                    NSRange cdataEnd = [content rangeOfString:@"]]>" options:0 range:NSMakeRange(valueStart, content.length - valueStart)];
                    if (cdataEnd.location != NSNotFound) {
                        transferId = [content substringWithRange:NSMakeRange(valueStart, cdataEnd.location - valueStart)];
                    }
                }
                
                // 如果CDATA方式失败，尝试直接查找
                if (!transferId || transferId.length == 0) {
                    NSRange endRange = [content rangeOfString:@"</transferid>" options:0 range:NSMakeRange(start, content.length - start)];
                    if (endRange.location != NSNotFound) {
                        NSString *value = [content substringWithRange:NSMakeRange(start, endRange.location - start)];
                        // 清理CDATA标记
                        value = [value stringByReplacingOccurrencesOfString:@"<![CDATA[" withString:@""];
                        value = [value stringByReplacingOccurrencesOfString:@"]]>" withString:@""];
                        value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        if (value.length > 0) {
                            transferId = value;
                        }
                    }
                }
            }
        }
        
        // 方法3: 从nativeUrl中提取
        if (!transferId || transferId.length == 0) {
            id payInfo = [msgWrap m_oWCPayInfoItem];
            if (payInfo) {
                if ([payInfo respondsToSelector:@selector(m_c2cNativeUrl)]) {
                    NSString *nativeUrl = [payInfo m_c2cNativeUrl];
                    
                    if (nativeUrl) {
                        NSURL *url = [NSURL URLWithString:nativeUrl];
                        if (url) {
                            NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
                            for (NSURLQueryItem *item in components.queryItems) {
                                if ([item.name isEqualToString:@"transferid"] || [item.name isEqualToString:@"tranferid"]) {
                                    transferId = item.value;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    } else {
    }
    
    if (!transferId || transferId.length == 0) {
        return;
    }
    
    
    // 获取付款人信息
    // 群聊消息：内容前面有发送者ID，格式为 "wxid_xxx: <msg>..."
    // 私聊消息：fromUsr 就是付款人
    NSString *payerId = nil;
    if (isGroup) {
        // 群聊：从消息内容开头提取发送者ID
        NSRange colonRange = [content rangeOfString:@":"];
        if (colonRange.location != NSNotFound && colonRange.location < 50) {
            payerId = [[content substringToIndex:colonRange.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
    }
    
    // 如果没有提取到，使用fromUsr
    if (!payerId || payerId.length == 0) {
        payerId = fromUsr;
    }
    
    payerName = CSGetContactDisplayName(payerId);
    
    Class controlMgrClass = NSClassFromString(@"WCPayControlMgr");
    if (!controlMgrClass) {
        return;
    }
    
    id controlMgr = CSGetService(controlMgrClass);
    if (!controlMgr) {
        return;
    }
    
    Class controlDataClass = NSClassFromString(@"WCPayControlData");
    if (!controlDataClass) {
        return;
    }
    
    WCPayControlData *controlData = [[controlDataClass alloc] init];
    if (!controlData) {
        return;
    }
    
    // 从XML中提取invalidtime
    unsigned long long invalidTime = 0;
    NSRange invalidTimeRange = [content rangeOfString:@"<invalidtime><![CDATA["];
    if (invalidTimeRange.location != NSNotFound) {
        NSString *substring = [content substringFromIndex:invalidTimeRange.location + invalidTimeRange.length];
        NSRange endRange = [substring rangeOfString:@"]]></invalidtime>"];
        if (endRange.location != NSNotFound) {
            NSString *timeStr = [substring substringToIndex:endRange.location];
            invalidTime = [timeStr longLongValue];
        }
    }
    
    // 设置转账相关数据（参考手动收款日志）
    [controlData setValue:transferId forKey:@"m_nsTransferID"];
    [controlData setValue:nil forKey:@"m_nsSelectedUserNameFromQRCode"];  // 手动收款时是null
    [controlData setValue:@(invalidTime) forKey:@"m_uiTransferInvalidTime"];  // 使用XML中的invalidtime
    
    if (CSIsChatRoomName(fromUsr)) {
        [controlData setValue:fromUsr forKey:@"selectedTransferChatroomUsername"];
    }
    
    
    // 获取或创建BaseMsgContentViewController
    UIViewController *currentVC = nil;
    
    // 方法1: 尝试从当前窗口获取
    UIWindow *keyWindow = nil;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    
    if (keyWindow) {
        UIViewController *rootVC = keyWindow.rootViewController;
        while (rootVC.presentedViewController) {
            rootVC = rootVC.presentedViewController;
        }
        
        if ([rootVC isKindOfClass:NSClassFromString(@"BaseMsgContentViewController")]) {
            currentVC = rootVC;
        } else {
            currentVC = cs_findViewController(rootVC, @"BaseMsgContentViewController");
        }
    }
    
    // 方法2: 如果找不到，创建一个新的BaseMsgContentViewController实例
    if (!currentVC) {
        Class vcClass = NSClassFromString(@"BaseMsgContentViewController");
        if (vcClass) {
            currentVC = [[vcClass alloc] init];
        }
    }
    
    if (!currentVC) {
        return;
    }
    
    
    SEL startLogicSelector = NSSelectorFromString(@"startReceiverConfirmTransferMoneyLogic:Data:");
    if (![controlMgr respondsToSelector:startLogicSelector]) {
        return;
    }
    
    // 调用收款接口（参考手动收款日志）
    @try {
        
        unsigned int result = ((unsigned int (*)(id, SEL, id, id))objc_msgSend)(controlMgr, startLogicSelector, currentVC, controlData);
        
        // 更新收款统计
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSInteger totalCount = [defaults integerForKey:kReceiveTransferTotalCountKey];
        NSInteger totalAmount = [defaults integerForKey:kReceiveTransferTotalAmountKey];
        
        totalCount++;
        totalAmount += amount;
        
        [defaults setInteger:totalCount forKey:kReceiveTransferTotalCountKey];
        [defaults setInteger:totalAmount forKey:kReceiveTransferTotalAmountKey];
        [defaults synchronize];
        
        
        // 发送通知
        cs_sendTransferNotification(fromUsr, amount, payerName, isGroup);
        
        // 自动回复
        if (isAutoReplyEnabled()) {
            NSString *replyContent = nil;
            if (isGroup) {
                replyContent = getGroupAutoReplyContent();
            } else {
                replyContent = getPrivateAutoReplyContent();
            }
            
            if (replyContent && replyContent.length > 0) {
                
                // 确定回复目标
                NSString *replyTarget = nil;
                if (isGroup) {
                    // 群聊：回复到群
                    replyTarget = fromUsr;
                    if (CSIsChatRoomName(toUsr)) {
                        replyTarget = toUsr;
                    }
                } else {
                    // 私聊：回复给付款人
                    replyTarget = fromUsr;
                }
                
                if (replyTarget && replyTarget.length > 0) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        BOOL replySent = CSSendTextMessage(replyContent, replyTarget);
                    });
                } else {
                }
            } else {
            }
        } else {
        }
    } @catch (NSException *e) {
    }
}

#pragma mark - Hook手动收款流程

%hook WCPayReveiverControlTransferControlLogic

- (id)initWithData:(id)arg1 {
    id result = %orig;
    return result;
}

- (void)startLogic {
    // 检查自动收款功能是否开启
    if (!isReceiveTransferEnabled()) {
        // 功能关闭时，调用原始方法，显示正常的确认界面
        %orig;
        return;
    }
    
    // 功能开启时，不调用原始的startLogic，避免打开界面
    // %orig;
    
    // 直接自动确认收款（后台模式）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self respondsToSelector:@selector(OnWCPayTransferMoneyStatusViewControllerConfirmTransfer)]) {
            [self OnWCPayTransferMoneyStatusViewControllerConfirmTransfer];
        } else {
        }
    });
}

%end


%hook CMessageMgr

- (void)AsyncOnAddMsg:(NSString *)msg MsgWrap:(CMessageWrap *)wrap {
    %orig;
    
    if (wrap) {
        unsigned int msgType = [wrap m_uiMessageType];
        
        // 转账消息是type=49的AppNode消息
        if (msgType == 49) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cs_handleTransferMessage(wrap);
            });
        }
    }
}

- (void)AddMsg:(id)arg1 MsgWrap:(CMessageWrap *)arg2 {
    %orig;
    
    if (arg2) {
        unsigned int msgType = [arg2 m_uiMessageType];
        
        // 转账消息是type=49的AppNode消息
        if (msgType == 49) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cs_handleTransferMessage(arg2);
            });
        }
    }
}

%end

static void cs_receiveTransferSettingsChanged(CFNotificationCenterRef center, void *observer, CFNotificationName name, const void *object, CFDictionaryRef userInfo) {
}

%ctor {
    
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        cs_receiveTransferSettingsChanged,
        CFSTR("com.wechat.enhance.receivetransfer.settings_changed"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
    
}
