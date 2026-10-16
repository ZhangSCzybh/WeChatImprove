// 防止撤回功能Hook
// 拦截微信撤回消息，保留被撤回的消息并显示提示

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <Foundation/Foundation.h>
#import "../Headers/WCHeaders.h"
#import "../Controllers/CSMessageNavigation.h"
#import "../Controllers/CSMessageMergeAdapter.h"
#import "../Controllers/CSMessageMergePolicy.h"
#import "../Controllers/CSRevokeReference.h"
#import "../Controllers/CSChatDiagnostics.h"

// UserDefaults Key常量
static NSString * const kRevokeEnabledKey = @"com.wechat.enhance.revoke.enabled";

// 检查功能是否启用
static BOOL isRevokeEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kRevokeEnabledKey];
}

// 去除字符串首尾空白
static NSString *trimString(NSString *str) {
    if (![str isKindOfClass:[NSString class]]) return nil;
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// 从XML中提取标签值
static NSString *extractXmlTagValue(NSString *xml, NSString *tagName) {
    if (![xml isKindOfClass:[NSString class]] || xml.length == 0) return nil;
    if (![tagName isKindOfClass:[NSString class]] || tagName.length == 0) return nil;
    
    NSString *startToken = [NSString stringWithFormat:@"<%@>", tagName];
    NSString *endToken = [NSString stringWithFormat:@"</%@>", tagName];
    
    NSRange startRange = [xml rangeOfString:startToken];
    if (startRange.location == NSNotFound) return nil;
    
    NSUInteger searchStart = NSMaxRange(startRange);
    if (searchStart >= xml.length) return nil;
    
    NSRange endRange = [xml rangeOfString:endToken options:0 range:NSMakeRange(searchStart, xml.length - searchStart)];
    if (endRange.location == NSNotFound) return nil;
    
    NSRange valueRange = NSMakeRange(searchStart, endRange.location - searchStart);
    return trimString([xml substringWithRange:valueRange]);
}

// 去除CDATA包装
static NSString *stripCDATA(NSString *text) {
    if (!text) return nil;
    
    NSString *cdataStart = @"<![CDATA[";
    NSString *cdataEnd = @"]]>";
    
    if ([text hasPrefix:cdataStart] && [text hasSuffix:cdataEnd]) {
        NSUInteger startLen = cdataStart.length;
        NSUInteger endLen = cdataEnd.length;
        if (text.length > startLen + endLen) {
            return [text substringWithRange:NSMakeRange(startLen, text.length - startLen - endLen)];
        }
    }
    return trimString(text);
}

// 格式化时间戳
static NSString *formatTimestamp(unsigned int timestamp) {
    NSDate *date = timestamp > 0 ? [NSDate dateWithTimeIntervalSince1970:timestamp] : [NSDate date];
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    
    return [formatter stringFromDate:date] ?: @"";
}

// 从撤回提示文本中提取撤回者名称
static NSString *extractRevokerName(NSString *replaceText) {
    if (!replaceText) return nil;
    
    NSScanner *scanner = [NSScanner scannerWithString:replaceText];
    NSString *prefix = nil;
    
    if ([scanner scanUpToString:@"撤回" intoString:&prefix]) {
        return trimString(prefix);
    }
    
    return nil;
}

// 从撤回提示文本中提取被撤回的内容
static NSString *extractRevokedContent(NSString *replaceText) {
    if (!replaceText) return nil;
    
    NSRange colonRange = [replaceText rangeOfString:@": "];
    if (colonRange.location != NSNotFound && colonRange.location < replaceText.length - 2) {
        return trimString([replaceText substringFromIndex:NSMaxRange(colonRange)]);
    }
    
    return nil;
}

// 获取消息管理器 - 照搬参考项目的实现
static id getMessageMgr() {
    // 方法1: 通过 MMContext 获取
    Class ctxClass = objc_getClass("MMContext");
    if (ctxClass) {
        id ctx = nil;
        if ([ctxClass respondsToSelector:@selector(currentContext)]) {
            ctx = ((id (*)(id, SEL))objc_msgSend)(ctxClass, @selector(currentContext));
        }
        if (ctx && [ctx respondsToSelector:@selector(getService:)]) {
            Class messageMgrClass = objc_getClass("CMessageMgr");
            if (messageMgrClass) {
                id service = ((id (*)(id, SEL, Class))objc_msgSend)(ctx, @selector(getService:), messageMgrClass);
                if (service) return service;
            }
        }
    }
    
    // 方法2: 通过 MMServiceCenter 获取
    Class serviceCenterClass = objc_getClass("MMServiceCenter");
    if (serviceCenterClass) {
        id center = nil;
        SEL centerSelectors[] = {
            @selector(defaultCenter),
            @selector(defaultServiceCenter),
            @selector(sharedCenter),
            @selector(sharedInstance)
        };
        for (int i = 0; i < 4; i++) {
            if ([serviceCenterClass respondsToSelector:centerSelectors[i]]) {
                center = ((id (*)(id, SEL))objc_msgSend)(serviceCenterClass, centerSelectors[i]);
                if (center) break;
            }
        }
        
        if (center && [center respondsToSelector:@selector(getService:)]) {
            Class messageMgrClass = objc_getClass("CMessageMgr");
            if (messageMgrClass) {
                id service = ((id (*)(id, SEL, Class))objc_msgSend)(center, @selector(getService:), messageMgrClass);
                if (service) return service;
            }
        }
    }
    
    // 方法3: 通过 ServiceCenter 获取
    Class legacyCenterClass = objc_getClass("ServiceCenter");
    if (legacyCenterClass) {
        id center = nil;
        if ([legacyCenterClass respondsToSelector:@selector(defaultCenter)]) {
            center = ((id (*)(id, SEL))objc_msgSend)(legacyCenterClass, @selector(defaultCenter));
        }
        
        if (center && [center respondsToSelector:@selector(getService:)]) {
            Class messageMgrClass = objc_getClass("CMessageMgr");
            if (messageMgrClass) {
                id service = ((id (*)(id, SEL, Class))objc_msgSend)(center, @selector(getService:), messageMgrClass);
                if (service) return service;
            }
        }
    }
    
    return nil;
}

// 获取消息摘要
static NSString *getMessageDigest(id msgWrap) {
    if (!msgWrap) return nil;
    
    unsigned int type = 0;
    @try {
        id typeValue = [msgWrap valueForKey:@"m_uiMessageType"];
        if ([typeValue respondsToSelector:@selector(unsignedIntValue)]) {
            type = [typeValue unsignedIntValue];
        }
    } @catch (NSException *e) {
        return nil;
    }
    
    NSString *content = nil;
    @try {
        content = [msgWrap valueForKey:@"m_nsContent"];
    } @catch (NSException *e) {}
    
    switch (type) {
        case 1:
            return trimString(content) ?: @"[文本]";
        case 3:
            return @"[图片]";
        case 34:
            return @"[语音]";
        case 43:
            return @"[视频]";
        case 47:
            return @"[表情]";
        case 49:
            return @"[应用消息]";
        default:
            return [NSString stringWithFormat:@"[类型:%u]", type];
    }
}

// 判断是否是自己撤回的消息
static BOOL isSelfRevokeMessage(id msgWrap) {
    if (!msgWrap) return NO;
    
    // 方法1: 检查 isSender
    @try {
        if ([msgWrap respondsToSelector:@selector(isSender)]) {
            BOOL isSender = ((BOOL (*)(id, SEL))objc_msgSend)(msgWrap, @selector(isSender));
            if (isSender) return YES;
        }
    } @catch (NSException *e) {}
    
    // 方法2: 检查撤回提示文本
    NSString *xml = nil;
    @try {
        xml = [msgWrap valueForKey:@"m_nsContent"];
    } @catch (NSException *e) {
        return NO;
    }
    
    xml = trimString(xml);
    if (xml.length == 0) return NO;
    
    NSString *replaceRaw = extractXmlTagValue(xml, @"replacemsg");
    NSString *replaceText = stripCDATA(replaceRaw);
    
    return CSRevokeIsSelfReplacement(replaceText);

}

// 插入本地提示消息 - 照搬参考项目的实现
static BOOL insertRevokeTipMessage(id messageMgr, NSString *session, NSString *tipText, unsigned int createTime, long long revokedMsgId) {
    if (!messageMgr || !session || session.length == 0) return NO;
    if (!tipText || tipText.length == 0) return NO;
    
    Class messageWrapClass = objc_getClass("CMessageWrap");
    if (!messageWrapClass) return NO;
    
    // 创建消息对象
    id msgWrap = nil;
    
    // 尝试使用 initWithMsgType:
    if ([messageWrapClass respondsToSelector:@selector(alloc)]) {
        id alloced = [messageWrapClass alloc];
        if (alloced) {
            if ([alloced respondsToSelector:@selector(initWithMsgType:)]) {
                msgWrap = ((id (*)(id, SEL, unsigned int))objc_msgSend)(alloced, @selector(initWithMsgType:), 0x2710);
            }
            if (!msgWrap && [alloced respondsToSelector:@selector(init)]) {
                msgWrap = [alloced init];
            }
        }
    }
    
    if (!msgWrap) return NO;
    
    // 设置消息属性
    @try {
        if ([msgWrap respondsToSelector:@selector(setM_uiStatus:)]) {
            ((void (*)(id, SEL, unsigned int))objc_msgSend)(msgWrap, @selector(setM_uiStatus:), 0x4);
        }
        if ([msgWrap respondsToSelector:@selector(setM_nsContent:)]) {
            ((void (*)(id, SEL, id))objc_msgSend)(msgWrap, @selector(setM_nsContent:), tipText);
        }
        if ([msgWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
            ((void (*)(id, SEL, unsigned int))objc_msgSend)(msgWrap, @selector(setM_uiCreateTime:), createTime);
        }
        if ([msgWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
            ((void (*)(id, SEL, id))objc_msgSend)(msgWrap, @selector(setM_nsToUsr:), session);
        }
        if ([msgWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
            ((void (*)(id, SEL, id))objc_msgSend)(msgWrap, @selector(setM_nsFromUsr:), session);
        }
        if ([msgWrap respondsToSelector:@selector(setM_nsRealChatUsr:)]) {
            ((void (*)(id, SEL, id))objc_msgSend)(msgWrap, @selector(setM_nsRealChatUsr:), nil);
        }
        
        // 存储被撤回消息的服务器ID到m_nsPattern字段，用于点击跳转

        if (revokedMsgId > 0 && [msgWrap respondsToSelector:@selector(setM_nsPattern:)]) {
            NSString *patternStr = [NSString stringWithFormat:@"revoke_jump_%lld", revokedMsgId];
            ((void (*)(id, SEL, id))objc_msgSend)(msgWrap, @selector(setM_nsPattern:), patternStr);            

        } else {
            NSLog(@"[防撤回] 跳过设置跳转标识: revokedMsgId=%lld", revokedMsgId);
        }
    } @catch (NSException *e) {
        NSLog(@"[防撤回] 设置消息属性异常: %@", e);
        return NO;
    }
    
    // 尝试多种 AddLocalMsg 方法
    @try {
        // 方法1: AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:Unique:
        SEL uniqueSel = @selector(AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:Unique:);
        if ([messageMgr respondsToSelector:uniqueSel]) {
            ((void (*)(id, SEL, id, id, BOOL, BOOL, BOOL))objc_msgSend)(messageMgr, uniqueSel, session, msgWrap, YES, NO, YES);
            return YES;
        }
        
        // 方法2: AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:
        SEL fixTimeSel = @selector(AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:);
        if ([messageMgr respondsToSelector:fixTimeSel]) {
            ((void (*)(id, SEL, id, id, BOOL, BOOL))objc_msgSend)(messageMgr, fixTimeSel, session, msgWrap, YES, NO);
            return YES;
        }
        
        // 方法3: AddLocalMsg:MsgWrap:
        SEL simpleSel = @selector(AddLocalMsg:MsgWrap:);
        if ([messageMgr respondsToSelector:simpleSel]) {
            ((void (*)(id, SEL, id, id))objc_msgSend)(messageMgr, simpleSel, session, msgWrap);
            return YES;
        }
    } @catch (NSException *e) {
        NSLog(@"[防撤回] 插入消息异常: %@", e);
        return NO;
    }
    
    return NO;
}

// 处理撤回消息 - 照搬参考项目的核心逻辑
static BOOL handleRevokeMessage(id revokeWrap, NSString *chatNameHint) {
    if (!revokeWrap) return NO;
    
    // 跳过自己撤回的消息
    if (isSelfRevokeMessage(revokeWrap)) {
        NSLog(@"[防撤回] 跳过自己撤回的消息");
        return NO;
    }
    
    NSString *xml = nil;
    @try {
        xml = [revokeWrap valueForKey:@"m_nsContent"];
    } @catch (NSException *e) {
        return NO;
    }
    
    if (!xml || xml.length == 0) return NO;
    
    CSRevokeEvent *event=[CSRevokeEvent eventFromXML:xml];
    if (!event) return NO;
    // 获取会话名称 - 按优先级尝试多种方式
    NSString *session = event.session;
    NSMutableArray *sessionCandidates = [NSMutableArray array];
    
    void (^appendSession)(NSString *) = ^(NSString *value) {
        NSString *trimmed = trimString(value);
        if (trimmed.length == 0) return;
        for (NSString *existing in sessionCandidates) {
            if ([existing isEqualToString:trimmed]) return;
        }
        [sessionCandidates addObject:trimmed];
    };
    
    appendSession(session);
    appendSession(chatNameHint);
    
    // 获取 ToUsr 和 FromUsr
    @try {
        appendSession([revokeWrap valueForKey:@"m_nsToUsr"]);
    } @catch (NSException *e) {}
    @try {
        appendSession([revokeWrap valueForKey:@"m_nsFromUsr"]);
    } @catch (NSException *e) {}
    
    session = sessionCandidates.firstObject;
    if (session.length == 0) return NO;
    
    NSString *replaceText=event.replacement;
    long long revokedMsgId=event.serverID;
    // 尝试获取被撤回的原消息
    id revokedMsgWrap = nil;
    id messageMgr = getMessageMgr();
    if (revokedMsgId > 0 && messageMgr) {
        SEL getMsgSel = @selector(GetMsg:n64SvrID:);
        if ([messageMgr respondsToSelector:getMsgSel]) {
            for (NSString *candidateSession in sessionCandidates) {
                @try {
                    id msg = ((id (*)(id, SEL, id, long long))objc_msgSend)(messageMgr, getMsgSel, candidateSession, revokedMsgId);
                    NSNumber *actualID=[msg valueForKey:@"m_n64MesSvrID"];
                    if (msg && actualID.longLongValue==revokedMsgId &&
                        CSRevokeSessionMatches(CSMessageCurrentAccount(),candidateSession,nil,
                            CSMessageNativeObject(msg,@"m_nsFromUsr"),CSMessageNativeObject(msg,@"m_nsToUsr"))) {
                        revokedMsgWrap = msg;
                        session = candidateSession;
                        break;
                    }
                } @catch (NSException *e) {}
            }
        }
    }
    
    // Do not suppress unknown events. Once the existing original is validated, protection
    // does not depend on whether a decorative local tip can be inserted.
    if (!revokedMsgWrap) return NO;
    // Original sender is authoritative even when WeChat localizes the self-revoke text.
    if ([CSMessageNativeObject(revokedMsgWrap,@"m_nsFromUsr") isEqual:CSMessageCurrentAccount()]) return NO;
    NSString *eventKey=[NSString stringWithFormat:@"%@/%@/%lld",CSMessageCurrentAccount(),session,revokedMsgId];
    static NSMutableOrderedSet *handled;
    @synchronized ([CSRevokeEvent class]) {
        if (!handled) handled=[NSMutableOrderedSet orderedSet];
        if ([handled containsObject:eventKey]) return YES;
        if (handled.count>=512) [handled removeObjectAtIndex:0];
        [handled addObject:eventKey];
    }
    CSChatRecordEvent(@"revoke",@"original-preserved");
    @try {
    // 获取被撤回内容的摘要
    NSString *revokedContent = getMessageDigest(revokedMsgWrap);
    if (revokedContent.length == 0) {
        revokedContent = extractRevokedContent(replaceText);
    }
    if (revokedContent.length == 0) {
        revokedContent = @"[表情]";
    }
    
    // 获取撤回者名称
    NSString *actorName = extractRevokerName(replaceText);
    if (actorName.length == 0) {
        // 尝试从消息中获取
        @try {
            NSString *fromUsr = [revokeWrap valueForKey:@"m_nsRealChatUsr"];
            if (fromUsr.length == 0) {
                fromUsr = [revokeWrap valueForKey:@"m_nsFromUsr"];
            }
            if (fromUsr.length > 0) {
                actorName = fromUsr;
            }
        } @catch (NSException *e) {}
    }
    if (actorName.length == 0) {
        actorName = @"对方";
    }
    
    // 获取撤回时间
    unsigned int createTime = 0;
    @try {
        id timeValue = [revokeWrap valueForKey:@"m_uiCreateTime"];
        if ([timeValue respondsToSelector:@selector(unsignedIntValue)]) {
            createTime = [timeValue unsignedIntValue];
        }
    } @catch (NSException *e) {}
    
    // 格式化时间
    NSString *timeText = formatTimestamp(createTime);
    
    // 构建提示文本 - 将被撤回内容设置为可点击的链接
    unsigned int localID=0;
    SEL localSelector=NSSelectorFromString(@"m_uiMesLocalID");
    Method localMethod=class_getInstanceMethod(object_getClass(revokedMsgWrap),localSelector);
    if (localMethod && method_getNumberOfArguments(localMethod)==2 && method_getTypeEncoding(localMethod)[0]=='I')
        localID=((unsigned int (*)(id,SEL))objc_msgSend)(revokedMsgWrap,localSelector);
    NSString *link=[[CSRevokeReference referenceWithServerID:revokedMsgId localID:localID] link];
    NSString *tipText = [NSString stringWithFormat:@"%@\n\"%@\"撤回了一条消息\n<a href=\"%@\">%@</a>",
                         timeText ?: @"",
                         CSMessageEscapeMarkup(actorName),
                         link,
                         CSMessageEscapeMarkup(revokedContent)];
        
    // 插入提示消息
    if (!messageMgr) {
        messageMgr = getMessageMgr();
    }
    
    BOOL inserted = insertRevokeTipMessage(messageMgr, session, tipText, createTime, revokedMsgId);
    
    CSChatRecordEvent(@"revoke",inserted ? @"tip-inserted" : @"tip-insert-failed-original-preserved");
    } @catch (__unused NSException *exception) {
        CSChatRecordEvent(@"revoke",@"tip-exception-original-preserved");
    }
    return YES;
}

// 从对象中获取消息包装对象
static id revokeMsgWrapFromObject(id obj) {
    if (!obj) return nil;
    
    // 如果本身就是 CMessageWrap
    NSString *className = NSStringFromClass([obj class]);
    if ([className containsString:@"CMessageWrap"]) {
        return obj;
    }
    
    // 尝试通过 msgWrap 属性获取
    if ([obj respondsToSelector:@selector(msgWrap)]) {
        @try {
            id wrap = [obj performSelector:@selector(msgWrap)];
            if (wrap) return wrap;
        } @catch (NSException *e) {}
    }
    
    return nil;
}

// 从对象中获取聊天名称
static NSString *revokeChatNameFromObject(id obj) {
    if (!obj) return nil;
    
    if ([obj respondsToSelector:@selector(nsChatName)]) {
        @try {
            id chatName = [obj performSelector:@selector(nsChatName)];
            if ([chatName isKindOfClass:[NSString class]]) {
                return trimString(chatName);
            }
        } @catch (NSException *e) {}
    }
    
    return nil;
}

// Hook CMessageMgr处理撤回消息
%hook CMessageMgr

- (void)onRevokeMsg:(id)arg1 {
    // 检查功能是否启用
    if (!isRevokeEnabled()) {
        %orig;
        return;
    }
    
    @try {
        // 处理撤回消息
        if (handleRevokeMessage(arg1, nil)) {
            // 如果成功处理，不调用原始方法（阻止撤回）
            return;
        }
    } @catch (NSException *exception) {
        NSLog(@"[防撤回] 处理异常: %@", exception);
    }
    
    // 如果处理失败，调用原始方法
    %orig;
}

%end

// All click routes share durable reference resolution and the current page binding.
%hook BaseMsgContentLogicController
- (void)onClickMsg:(id)wrap {
    if (isRevokeEnabled() && CSMessageHandleRevokeLink(self,getMessageMgr(),nil,wrap)) return;
    %orig;
}
%end

%hook SystemMessageCellView
- (void)onLinkClicked:(id)link withRect:(CGRect)rect {
    if (isRevokeEnabled() && CSMessageHandleRevokeLink(self,getMessageMgr(),link,nil)) return;
    %orig;
}
%end

%group CSRevokeLinkWithView
%hook SystemMessageCellView
- (void)onLinkClicked:(id)link withRect:(CGRect)rect withView:(id)view {
    if (isRevokeEnabled() && CSMessageHandleRevokeLink(self,getMessageMgr(),link,nil)) return;
    %orig;
}
%end
%end
%group CSRevokeLinkWithBackup
%hook SystemMessageCellView
- (void)onLinkClicked:(id)link backupUrl:(id)backup withRect:(CGRect)rect {
    if (isRevokeEnabled() && CSMessageHandleRevokeLink(self,getMessageMgr(),link,nil)) return;
    %orig;
}
%end
%end
%group CSRevokeLinkWithExtra
%hook SystemMessageCellView
- (void)onLinkClicked:(id)link backupUrl:(id)backup withRect:(CGRect)rect extraInfo:(id)info {
    if (isRevokeEnabled() && CSMessageHandleRevokeLink(self,getMessageMgr(),link,nil)) return;
    %orig;
}
%end
%end

// Hook MessageRevokeMgr（备用撤回管理器）
%hook MessageRevokeMgr

- (void)onRevokeMsg:(id)arg1 {
    if (!isRevokeEnabled()) {
        %orig;
        return;
    }
    
    @try {
        id revokeWrap = revokeMsgWrapFromObject(arg1);
        NSString *chatName = revokeChatNameFromObject(arg1);
        
        if (handleRevokeMessage(revokeWrap, chatName)) {
            return;
        }
    } @catch (NSException *exception) {
        NSLog(@"[防撤回] MessageRevokeMgr处理异常: %@", exception);
    }
    
    %orig;
}

- (void)replaceRevokedMsg:(id)arg1 {
    if (!isRevokeEnabled()) {
        %orig;
        return;
    }
    
    // 跳过替换被撤回消息的操作
    id revokeWrap = revokeMsgWrapFromObject(arg1);
    if (handleRevokeMessage(revokeWrap,revokeChatNameFromObject(arg1))) {
        return;
    }
    
    %orig;
}

- (void)deleteLocalProcessRevokeMsgWithToast:(id)arg1 {
    if (!isRevokeEnabled()) {
        %orig;
        return;
    }
    
    id revokeWrap = revokeMsgWrapFromObject(arg1);
    if (handleRevokeMessage(revokeWrap,revokeChatNameFromObject(arg1))) {
        return;
    }
    
    %orig;
}

%end

// 设置变化通知回调函数
static void revokeSettingsChangedCallback(CFNotificationCenterRef center, void *observer, CFNotificationName name, const void *object, CFDictionaryRef userInfo) {
    NSLog(@"[防撤回] 设置已更新");
}

// 监听设置变化
%ctor {
    %init;
    Class cell=NSClassFromString(@"SystemMessageCellView");
    if (class_getInstanceMethod(cell,NSSelectorFromString(@"onLinkClicked:withRect:withView:"))) { %init(CSRevokeLinkWithView); }
    if (class_getInstanceMethod(cell,NSSelectorFromString(@"onLinkClicked:backupUrl:withRect:"))) { %init(CSRevokeLinkWithBackup); }
    if (class_getInstanceMethod(cell,NSSelectorFromString(@"onLinkClicked:backupUrl:withRect:extraInfo:"))) { %init(CSRevokeLinkWithExtra); }
    // 监听设置变化通知
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        revokeSettingsChangedCallback,
        CFSTR("com.wechat.enhance.revoke.settings_changed"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
    
    NSLog(@"[防撤回] Hook已加载，当前状态: %@", isRevokeEnabled() ? @"启用" : @"禁用");
}
