#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <CoreFoundation/CoreFoundation.h>
#import "../Headers/WCHeaders.h"
#import "../Controllers/WCPLMessagePersistenceAdapter.h"

static NSString * const kVoiceForwardEnabledKey = @"com.wechat.enhance.voice_forward.enabled";

static BOOL cs_isVoiceForwardEnabled(void) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVoiceForwardEnabledKey];
}

static BOOL cs_isVoiceMessage(id msgWrap) {
    if (!msgWrap) return NO;
    if (![msgWrap isKindOfClass:%c(CMessageWrap)]) return NO;
    CMessageWrap *wrap = (CMessageWrap *)msgWrap;
    return wrap.m_uiMessageType == 34;
}

static id cs_callClassSelectorIfExists(Class cls, SEL selector) {
    if (!cls || !selector) return nil;
    if (![cls respondsToSelector:selector]) return nil;
    return ((id (*)(id, SEL))objc_msgSend)(cls, selector);
}

static id cs_getServiceCenterFromMMContext(void) {
    Class ctxClass = objc_getClass("MMContext");
    if (!ctxClass) return nil;
    
    id ctx = cs_callClassSelectorIfExists(ctxClass, @selector(currentContext));
    if (!ctx) return nil;
    
    if ([ctx respondsToSelector:@selector(getService:)]) {
        return ctx;
    }
    
    if ([ctx respondsToSelector:@selector(serviceCenter)]) {
        @try {
            id center = ((id (*)(id, SEL))objc_msgSend)(ctx, @selector(serviceCenter));
            if (center && [center respondsToSelector:@selector(getService:)]) {
                return center;
            }
        } @catch (NSException *e) {
            NSLog(@"[语音转发] MMContext.serviceCenter 异常: %@", e);
        }
    }
    
    return nil;
}

static id cs_getServiceCenterForClass(Class cls) {
    if (!cls) return nil;
    
    const SEL selectors[] = {
        @selector(defaultCenter),
        @selector(defaultServiceCenter),
        @selector(sharedCenter),
        @selector(sharedInstance),
        @selector(sharedServiceCenter),
    };
    
    for (NSUInteger i = 0; i < sizeof(selectors) / sizeof(selectors[0]); i++) {
        id center = cs_callClassSelectorIfExists(cls, selectors[i]);
        if (center) {
            return center;
        }
    }
    
    return nil;
}

static id cs_getServiceFromCenter(id center, Class serviceClass) {
    if (!center || !serviceClass) return nil;
    if (![center respondsToSelector:@selector(getService:)]) return nil;
    return ((id (*)(id, SEL, Class))objc_msgSend)(center, @selector(getService:), serviceClass);
}

static id cs_getServiceByClass(Class serviceClass) {
    if (!serviceClass) return nil;
    
    id ctxCenter = cs_getServiceCenterFromMMContext();
    id service = cs_getServiceFromCenter(ctxCenter, serviceClass);
    if (service) {
        return service;
    }
    
    id mmCenter = cs_getServiceCenterForClass(objc_getClass("MMServiceCenter"));
    service = cs_getServiceFromCenter(mmCenter, serviceClass);
    if (service) {
        return service;
    }
    
    id legacyCenter = cs_getServiceCenterForClass(objc_getClass("ServiceCenter"));
    service = cs_getServiceFromCenter(legacyCenter, serviceClass);
    if (service) {
        return service;
    }
    
    NSLog(@"[语音转发] 无法获取服务: %@", NSStringFromClass(serviceClass));
    return nil;
}

static NSString *cs_currentSelfUserName(void) {
    id contactMgr = cs_getServiceByClass(objc_getClass("CContactMgr"));
    if (!contactMgr) return nil;
    SEL selector = @selector(getSelfContact);
    if (![contactMgr respondsToSelector:selector]) return nil;
    @try {
        id selfContact = ((id (*)(id, SEL))objc_msgSend)(contactMgr, selector);
        if ([selfContact respondsToSelector:@selector(m_nsUsrName)]) {
            return [selfContact m_nsUsrName];
        }
    } @catch (NSException *e) {
        NSLog(@"[语音转发] 获取自身用户名失败: %@", e);
    }
    return nil;
}

static NSString *cs_safeUserNameFromObject(id obj) {
    if (!obj) return nil;
    if ([obj respondsToSelector:@selector(m_nsUsrName)]) {
        NSString *userName = [obj m_nsUsrName];
        if (userName.length > 0) return userName;
    }
    return nil;
}

static NSString *cs_generateClientMsgID(NSString *sender) {
    NSString *senderName = sender.length > 0 ? sender : cs_currentSelfUserName();
    unsigned int now = (unsigned int)[[NSDate date] timeIntervalSince1970];
    unsigned int randomValue = arc4random();
    if (senderName.length > 0) {
        return [NSString stringWithFormat:@"%@_%u_%u", senderName, now, randomValue];
    }
    return [NSString stringWithFormat:@"cs_%u_%u", now, randomValue];
}

static NSString *cs_voiceAudioPathFromWrap(id msgWrap) {
    if (!msgWrap) return nil;
    Class msgWrapClass = objc_getClass("CMessageWrap");
    SEL selector = @selector(getPathOfAudio:);
    if (!(msgWrapClass && [msgWrapClass respondsToSelector:selector])) return nil;
    @try {
        id value = ((id (*)(id, SEL, id))objc_msgSend)(msgWrapClass, selector, msgWrap);
        if ([value isKindOfClass:[NSString class]]) {
            return (NSString *)value;
        }
    } @catch (NSException *e) {
        NSLog(@"[语音转发] 获取音频路径失败: %@", e);
    }
    return nil;
}

static NSData *cs_loadVoiceAudioData(id msgWrap, NSString **outPath) {
    if (outPath) *outPath = nil;
    NSString *audioPath = cs_voiceAudioPathFromWrap(msgWrap);
    if (outPath) *outPath = audioPath;
    if (audioPath.length == 0) return nil;
    NSError *readError = nil;
    NSData *audioData = [NSData dataWithContentsOfFile:audioPath options:NSDataReadingMappedIfSafe error:&readError];
    if (audioData.length == 0) return nil;
    static const NSUInteger kMaxVoiceBytes = 20 * 1024 * 1024;
    if (audioData.length > kMaxVoiceBytes) {
        return nil;
    }
    return audioData;
}

static unsigned int cs_extractVoiceAttrUInt(NSString *xml, NSString *attrName) {
    if (!xml || !attrName) return 0;
    NSString *pattern = [NSString stringWithFormat:@"%@=\"%@\"", attrName, @"([0-9]+)"];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (!regex) return 0;
    NSTextCheckingResult *match = [regex firstMatchInString:xml options:0 range:NSMakeRange(0, xml.length)];
    if (!match || match.numberOfRanges < 2) return 0;
    NSString *valueStr = [xml substringWithRange:[match rangeAtIndex:1]];
    return (unsigned int)[valueStr integerValue];
}

static unsigned int cs_voiceTime(id msgWrap) {
    if (!msgWrap) return 1;
    unsigned int voiceTime = 0;
    if ([msgWrap respondsToSelector:@selector(m_uiVoiceTime)]) {
        @try {
            voiceTime = ((unsigned int (*)(id, SEL))objc_msgSend)(msgWrap, @selector(m_uiVoiceTime));
        } @catch (NSException *e) {}
    }
    if (voiceTime > 300) voiceTime = (voiceTime + 999) / 1000;
    if (voiceTime <= 1) {
        if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
            NSString *content = [msgWrap m_nsContent];
            unsigned int lengthMs = cs_extractVoiceAttrUInt(content, @"voicelength");
            if (lengthMs > 0) {
                unsigned int parsedSeconds = (lengthMs + 999) / 1000;
                if (parsedSeconds > voiceTime) voiceTime = parsedSeconds;
            }
        }
    }
    return voiceTime > 0 ? voiceTime : 1;
}

static unsigned int cs_voiceFormat(id msgWrap) {
    if (!msgWrap) return 4;
    unsigned int voiceFormat = 0;
    if ([msgWrap respondsToSelector:@selector(m_uiVoiceFormat)]) {
        @try {
            voiceFormat = ((unsigned int (*)(id, SEL))objc_msgSend)(msgWrap, @selector(m_uiVoiceFormat));
        } @catch (NSException *e) {}
    }
    if (voiceFormat == 0) {
        if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
            NSString *content = [msgWrap m_nsContent];
            voiceFormat = cs_extractVoiceAttrUInt(content, @"voiceformat");
        }
    }
    return voiceFormat > 0 ? voiceFormat : 4;
}

static NSString *cs_buildMinimalVoiceContent(unsigned int voiceLengthMs, unsigned int voiceFormat) {
    unsigned int lengthMs = (voiceLengthMs > 0) ? voiceLengthMs : 1000;
    unsigned int fmt = (voiceFormat > 0) ? voiceFormat : 4;
    return [NSString stringWithFormat:@"<msg><voicemsg voicelength=\"%u\" voiceformat=\"%u\" forwardflag=\"0\" /></msg>", lengthMs, fmt];
}

static void cs_applyClientMsgID(id sendWrap, NSString *clientMsgID) {
    if (!sendWrap || clientMsgID.length == 0) return;
    SEL setSelector = NSSelectorFromString(@"setM_nsClientMsgID:");
    if ([sendWrap respondsToSelector:setSelector]) {
        @try {
            ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, setSelector, clientMsgID);
            return;
        } @catch (NSException *e) {}
    }
    @try {
        [sendWrap setValue:clientMsgID forKey:@"m_nsClientMsgID"];
    } @catch (NSException *e) {}
}

static void cs_resetIdentity(id sendWrap) {
    if (!sendWrap) return;
    if ([sendWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiMesLocalID:), 0); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
        @try { ((void (*)(id, SEL, long long))objc_msgSend)(sendWrap, @selector(setM_n64MesSvrID:), 0); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiStatus:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiStatus:), 0); } @catch (NSException *e) {}
    }
    unsigned int now = (unsigned int)[[NSDate date] timeIntervalSince1970];
    if ([sendWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiCreateTime:), now); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiSendTime:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiSendTime:), now); } @catch (NSException *e) {}
    }
}

static void cs_prepareRoute(id sendWrap, NSString *chatName, NSString *selfUserName) {
    if (!sendWrap || chatName.length == 0) return;
    if ([sendWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setM_nsToUsr:), chatName); } @catch (NSException *e) {}
    }
    if (selfUserName.length > 0 && [sendWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setM_nsFromUsr:), selfUserName); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiIsSenderStatus:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiIsSenderStatus:), 1); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_nsRealChatUsr:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setM_nsRealChatUsr:), nil); } @catch (NSException *e) {}
    }
    cs_applyClientMsgID(sendWrap, cs_generateClientMsgID(selfUserName));
}

static void cs_applyVoiceExtendInfo(id sendWrap, NSData *audioData, unsigned int voiceTime, unsigned int voiceFormat) {
    if (!sendWrap) return;
    Class extendClass = objc_getClass("CExtendInfoOfVoiceMsg");
    if (!extendClass) return;
    id extendInfo = nil;
    @try { extendInfo = [[extendClass alloc] init]; } @catch (NSException *e) {}
    if (!extendInfo) return;
    if (audioData && [extendInfo respondsToSelector:@selector(setM_dtVoice:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(extendInfo, @selector(setM_dtVoice:), audioData); } @catch (NSException *e) {}
    }
    if ([extendInfo respondsToSelector:@selector(setM_uiVoiceTime:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(extendInfo, @selector(setM_uiVoiceTime:), voiceTime); } @catch (NSException *e) {}
    }
    if ([extendInfo respondsToSelector:@selector(setM_uiVoiceFormat:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(extendInfo, @selector(setM_uiVoiceFormat:), voiceFormat); } @catch (NSException *e) {}
    }
    if ([extendInfo respondsToSelector:@selector(setM_uiVoiceForwardFlag:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(extendInfo, @selector(setM_uiVoiceForwardFlag:), 0); } @catch (NSException *e) {}
    }
    if ([extendInfo respondsToSelector:@selector(setM_uiVoiceCancelFlag:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(extendInfo, @selector(setM_uiVoiceCancelFlag:), 0); } @catch (NSException *e) {}
    }
    if ([extendInfo respondsToSelector:@selector(setM_uiVoiceEndFlag:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(extendInfo, @selector(setM_uiVoiceEndFlag:), 1); } @catch (NSException *e) {}
    }
    if ([extendInfo respondsToSelector:@selector(setM_refMessageWrap:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(extendInfo, @selector(setM_refMessageWrap:), sendWrap); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_extendInfoWithMsgType:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setM_extendInfoWithMsgType:), extendInfo); } @catch (NSException *e) {}
    }
}

static void cs_applyVoiceFields(id sendWrap, id sourceWrap, NSData *audioData, unsigned int voiceTime, unsigned int voiceFormat) {
    if (!sendWrap) return;
    if ([sendWrap respondsToSelector:@selector(setM_uiMessageType:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiMessageType:), 34); } @catch (NSException *e) {}
    }
    if (audioData && [sendWrap respondsToSelector:@selector(setM_dtVoice:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setM_dtVoice:), audioData); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiVoiceEndFlag:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiVoiceEndFlag:), 1); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiVoiceCancelFlag:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiVoiceCancelFlag:), 0); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiVoiceForwardFlag:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiVoiceForwardFlag:), 0); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiVoiceTime:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiVoiceTime:), voiceTime); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiVoiceFormat:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiVoiceFormat:), voiceFormat); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiIsSenderStatus:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiIsSenderStatus:), 1); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiStatus:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiStatus:), 1); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiDownloadStatus:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiDownloadStatus:), 9); } @catch (NSException *e) {}
    }
    unsigned int voiceLengthMs = 0;
    if ([sourceWrap respondsToSelector:@selector(m_nsContent)]) {
        voiceLengthMs = cs_extractVoiceAttrUInt([sourceWrap m_nsContent], @"voicelength");
    }
    if (voiceLengthMs == 0) voiceLengthMs = voiceTime * 1000;
    NSString *voiceContent = cs_buildMinimalVoiceContent(voiceLengthMs, voiceFormat);
    if ([sendWrap respondsToSelector:@selector(setM_nsContent:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setM_nsContent:), voiceContent); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_nsPushContent:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setM_nsPushContent:), @""); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_nsPushTitle:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setM_nsPushTitle:), @""); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
        @try { ((void (*)(id, SEL, unsigned int))objc_msgSend)(sendWrap, @selector(setM_uiMesLocalID:), 0); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
        @try { ((void (*)(id, SEL, long long))objc_msgSend)(sendWrap, @selector(setM_n64MesSvrID:), 0); } @catch (NSException *e) {}
    }
    if ([sendWrap respondsToSelector:@selector(setVoiceUrl:)]) {
        @try { ((void (*)(id, SEL, id))objc_msgSend)(sendWrap, @selector(setVoiceUrl:), @""); } @catch (NSException *e) {}
    }
    cs_applyVoiceExtendInfo(sendWrap, audioData, voiceTime, voiceFormat);
}

static id cs_buildFreshVoiceWrap(void) {
    Class wrapClass = objc_getClass("CMessageWrap");
    if (!wrapClass) return nil;
    id sendWrap = nil;
    if ([wrapClass instancesRespondToSelector:@selector(initWithMsgType:)]) {
        @try {
            sendWrap = ((id (*)(id, SEL, long long))objc_msgSend)([wrapClass alloc], @selector(initWithMsgType:), (long long)34);
        } @catch (NSException *e) {}
    }
    if (!sendWrap) {
        @try { sendWrap = [[wrapClass alloc] init]; } @catch (NSException *e) {}
    }
    return sendWrap;
}

static id cs_buildVoiceSendWrap(id sourceWrap, NSString *chatName, NSString *selfUserName, NSData *audioData, unsigned int voiceTime, unsigned int voiceFormat) {
    if (!sourceWrap || chatName.length == 0 || audioData.length == 0) return nil;
    id sendWrap = cs_buildFreshVoiceWrap();
    if (!sendWrap) return nil;
    cs_resetIdentity(sendWrap);
    cs_prepareRoute(sendWrap, chatName, selfUserName);
    cs_applyVoiceFields(sendWrap, sourceWrap, audioData, voiceTime, voiceFormat);
    return sendWrap;
}

static BOOL cs_forwardQueueVoiceBySendMessageMgr(NSString *chatName, id sendWrap, NSString *targetTag) {
    if (!(chatName.length > 0 && sendWrap)) {
        return NO;
    }
    id sendMessageMgr = cs_getServiceByClass(objc_getClass("SendMessageMgr"));
    if (!sendMessageMgr) {
        return NO;
    }
    SEL selector = @selector(AddMsgToSendTable:MsgWrap:);
    if (![sendMessageMgr respondsToSelector:selector]) {
        return NO;
    }
    @try {
        
        unsigned int beforeStatus = 0;
        unsigned int beforeLocalID = 0;
        if ([sendWrap respondsToSelector:@selector(m_uiStatus)]) {
            beforeStatus = ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiStatus));
        }
        if ([sendWrap respondsToSelector:@selector(m_uiMesLocalID)]) {
            beforeLocalID = ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiMesLocalID));
        }
        
        ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, selector, chatName, sendWrap);
        
        unsigned int afterStatus = 0;
        unsigned int afterLocalID = 0;
        if ([sendWrap respondsToSelector:@selector(m_uiStatus)]) {
            afterStatus = ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiStatus));
        }
        if ([sendWrap respondsToSelector:@selector(m_uiMesLocalID)]) {
            afterLocalID = ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiMesLocalID));
        }
        
        if (afterStatus == 5 || afterLocalID == 0) {
            return NO;
        }
        
        return YES;
    } @catch (NSException *e) {
        NSLog(@"[语音转发] SendMessageMgr.queue 发送失败: %@", e);
        return NO;
    }
}

static BOOL cs_forwardAddLocalVoiceMsg(id messageMgr, NSString *chatName, id sendWrap, NSString *targetTag) {
    if (!(messageMgr && chatName.length > 0 && sendWrap)) {
        return NO;
    }
    
    WCPLAddLocalMsgInsertPath insertPath = WCPLAddLocalMsgInsertPathNone;
    BOOL inserted = WCPLAddLocalMsgInsert((WCPLAddLocalMsgInsertRequest){
        .messageMgr = messageMgr,
        .sessionUserName = chatName,
        .msgWrap = sendWrap,
        .fixTime = NO,
        .notify = YES,
        .unique = NO
    }, &insertPath);
    
    return inserted;
}

static BOOL cs_forwardInvokeResendVoiceTarget(id target, id routeArg, id sendWrap, NSString *targetTag, NSString *senderTag) {
    SEL resendVoiceSel = NSSelectorFromString(@"ResendVoiceMsg:MsgWrap:");
    if (!(target && routeArg && sendWrap)) {
        return NO;
    }
    if (![target respondsToSelector:resendVoiceSel]) {
        return NO;
    }
    @try {
        ((void (*)(id, SEL, id, id))objc_msgSend)(target, resendVoiceSel, routeArg, sendWrap);
        return YES;
    } @catch (NSException *e) {
        return NO;
    }
}

static BOOL cs_forwardVoiceByResendRoute(NSString *chatName, id sendWrap, NSString *targetTag) {
    if (!(chatName.length > 0 && sendWrap)) {
        return NO;
    }
    id messageMgr = cs_getServiceByClass(objc_getClass("CMessageMgr"));
    if (!messageMgr) {
        return NO;
    }
    if (!cs_forwardAddLocalVoiceMsg(messageMgr, chatName, sendWrap, targetTag)) {
        return NO;
    }
    
    
    id audioSender = cs_getServiceByClass(objc_getClass("AudioSender"));
    if (audioSender) {
        if (cs_forwardInvokeResendVoiceTarget(audioSender, chatName, sendWrap, targetTag, @"AudioSender")) return YES;
    }
    
    id uploadVoiceMgr = cs_getServiceByClass(objc_getClass("MMNewUploadVoiceMgr"));
    if (uploadVoiceMgr) {
        if (cs_forwardInvokeResendVoiceTarget(uploadVoiceMgr, chatName, sendWrap, targetTag, @"MMNewUploadVoiceMgr")) return YES;
    }
    
    id uploadVoiceCDNMgr = cs_getServiceByClass(objc_getClass("UploadVoiceCDNMgr"));
    if (uploadVoiceCDNMgr) {
        if (cs_forwardInvokeResendVoiceTarget(uploadVoiceCDNMgr, chatName, sendWrap, targetTag, @"UploadVoiceCDNMgr")) return YES;
    }
    
    return NO;
}

static BOOL cs_forwardVoiceToTargetStrict(id msgWrap, id targetContact, NSString *targetIdentifier) {
    if (!(cs_isVoiceMessage(msgWrap) && targetContact)) return NO;
    NSString *target = targetIdentifier.length > 0 ? targetIdentifier : @"(unknown)";
    NSString *chatName = cs_safeUserNameFromObject(targetContact);
    if (chatName.length == 0 && [targetContact isKindOfClass:[NSString class]]) {
        chatName = [(NSString *)targetContact stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if (chatName.length == 0) {
        return NO;
    }
    NSString *audioPath = nil;
    NSData *audioData = cs_loadVoiceAudioData(msgWrap, &audioPath);
    if (audioData.length == 0) {
        return NO;
    }
    unsigned int voiceTime = cs_voiceTime(msgWrap);
    unsigned int voiceFormat = cs_voiceFormat(msgWrap);
    NSString *selfUserName = cs_currentSelfUserName();
    id sendWrap = cs_buildVoiceSendWrap(msgWrap, chatName, selfUserName, audioData, voiceTime, voiceFormat);
    if (!sendWrap) {
        return NO;
    }
    if (cs_forwardQueueVoiceBySendMessageMgr(chatName, sendWrap, target)) return YES;
    if (cs_forwardVoiceByResendRoute(chatName, sendWrap, target)) return YES;
    return NO;
}

static id cs_messageWrapFromCell(id cell) {
    if (!cell) return nil;
    SEL getMediaWrapSelector = NSSelectorFromString(@"getMediaWrap");
    if ([cell respondsToSelector:getMediaWrapSelector]) {
        @try {
            id msgWrap = ((id (*)(id, SEL))objc_msgSend)(cell, getMediaWrapSelector);
            if (msgWrap) return msgWrap;
        } @catch (NSException *e) {}
    }
    @try {
        id msgWrap = [cell valueForKey:@"m_messageWrap"];
        if (msgWrap) return msgWrap;
    } @catch (NSException *e) {}
    return nil;
}

static UIImage *cs_voiceForwardMenuIconImage(void) {
    static UIImage *icon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *svg = @"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24' fill='none'>"
                        "<path d='M8 6C8 4.89543 8.89543 4 10 4H18C19.1046 4 20 4.89543 20 6V14C20 15.1046 19.1046 16 18 16H16' stroke='#FFFFFF' stroke-width='1.8' stroke-linecap='round'/>"
                        "<path d='M4 10C4 8.89543 4.89543 8 6 8H14C15.1046 8 16 8.89543 16 10V18C16 19.1046 15.1046 20 14 20H6C4.89543 20 4 19.1046 4 18V10Z' stroke='#FFFFFF' stroke-width='1.8'/>"
                        "<path d='M10 17L13 14M13 14L10 11M13 14H7' stroke='#FFFFFF' stroke-width='1.8' stroke-linecap='round' stroke-linejoin='round'/>"
                        "</svg>";
        
        NSData *svgData = [svg dataUsingEncoding:NSUTF8StringEncoding];
        
        Class themeProxyClass = objc_getClass("WAThemeProxy");
        SEL svgFromDataSel = @selector(svgImageFromData:);
        if (themeProxyClass && [themeProxyClass respondsToSelector:svgFromDataSel] && svgData) {
            @try {
                id image = ((id (*)(id, SEL, id))objc_msgSend)(themeProxyClass, svgFromDataSel, svgData);
                if ([image isKindOfClass:[UIImage class]]) {
                    icon = (UIImage *)image;
                }
            } @catch (NSException *e) {}
        }
        
        if (!icon) {
            icon = [UIImage systemImageNamed:@"arrowshape.turn.up.right"];
        }
        
        if (icon && [icon respondsToSelector:@selector(imageWithRenderingMode:)]) {
            icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    });
    return icon;
}

static id cs_createVoiceForwardMenuItem(Class menuItemClass, id cell, SEL action) {
    if (!menuItemClass || !cell || !action) return nil;
    NSString *title = @"转发";
    UIImage *icon = cs_voiceForwardMenuIconImage();
    id menuItem = nil;
    @try {
        SEL initSelector = NSSelectorFromString(@"initWithTitle:icon:target:action:");
        if (icon && [menuItemClass instancesRespondToSelector:initSelector]) {
            menuItem = ((id (*)(id, SEL, id, id, id, SEL))objc_msgSend)([menuItemClass alloc], initSelector, title, icon, cell, action);
        }
    } @catch (NSException *e) {}
    if (!menuItem) {
        @try {
            SEL initSelector2 = NSSelectorFromString(@"initWithTitle:target:action:");
            if ([menuItemClass instancesRespondToSelector:initSelector2]) {
                menuItem = ((id (*)(id, SEL, id, id, SEL))objc_msgSend)([menuItemClass alloc], initSelector2, title, cell, action);
            }
        } @catch (NSException *e) {}
    }
    return menuItem;
}

static NSArray *cs_injectVoiceForwardMenuItem(id cell, NSArray *items) {
    if (!cs_isVoiceForwardEnabled()) return items;
    id msgWrap = cs_messageWrapFromCell(cell);
    if (!cs_isVoiceMessage(msgWrap)) return items;
    Class menuItemClass = objc_getClass("MMMenuItem");
    if (!menuItemClass) return items;
    SEL bridgeAction = @selector(cs_handleVoiceForwardMenuItem:);
    NSMutableArray *mutableItems = items ? [items mutableCopy] : [NSMutableArray array];
    for (id item in mutableItems) {
        if (![item isKindOfClass:menuItemClass] || ![item respondsToSelector:@selector(action)]) continue;
        @try {
            SEL itemAction = ((SEL (*)(id, SEL))objc_msgSend)(item, @selector(action));
            if (itemAction == bridgeAction) return mutableItems;
        } @catch (NSException *e) {}
    }
    id menuItem = cs_createVoiceForwardMenuItem(menuItemClass, cell, bridgeAction);
    if (menuItem) {
        [mutableItems addObject:menuItem];
    }
    return mutableItems;
}

static void cs_startDownloadVoiceIfNeeded(id msgWrap) {
    if (!cs_isVoiceMessage(msgWrap)) return;
    NSString *audioPath = cs_voiceAudioPathFromWrap(msgWrap);
    if ([[NSFileManager defaultManager] fileExistsAtPath:audioPath]) return;
    id messageMgr = cs_getServiceByClass(objc_getClass("CMessageMgr"));
    if (!(messageMgr && [messageMgr respondsToSelector:@selector(StartDownloadByRecordMsg:)])) return;
    @try {
        ((void (*)(id, SEL, id))objc_msgSend)(messageMgr, @selector(StartDownloadByRecordMsg:), msgWrap);
    } @catch (NSException *e) {}
}

static NSString *kPendingWrapKey = @"com.wechat.enhance.voice_forward.pending_wrap";
static NSString *kPendingVCKey = @"com.wechat.enhance.voice_forward.pending_vc";
static NSString *kPendingForwardTypeKey = @"com.wechat.enhance.voice_forward.pending_forward_type";
static NSString *kTargetObservedKey = @"com.wechat.enhance.voice_forward.target_observed";

static void cs_voiceForwardSetPendingContext(id mgr, id wrap, id vc, long long forwardType) {
    objc_setAssociatedObject(mgr, (__bridge const void *)kPendingWrapKey, wrap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(mgr, (__bridge const void *)kPendingVCKey, vc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(mgr, (__bridge const void *)kPendingForwardTypeKey, @(forwardType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(mgr, (__bridge const void *)kTargetObservedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void cs_voiceForwardClearPendingContext(id mgr) {
    objc_setAssociatedObject(mgr, (__bridge const void *)kPendingWrapKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(mgr, (__bridge const void *)kPendingVCKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(mgr, (__bridge const void *)kPendingForwardTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(mgr, (__bridge const void *)kTargetObservedKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void cs_voiceForwardMarkTargetObserved(id mgr) {
    objc_setAssociatedObject(mgr, (__bridge const void *)kTargetObservedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static BOOL cs_voiceForwardTargetObserved(id mgr) {
    NSNumber *value = objc_getAssociatedObject(mgr, (__bridge const void *)kTargetObservedKey);
    return value ? value.boolValue : NO;
}

static BOOL cs_voiceForwardClassLooksUseful(NSString *className) {
    if (!className || className.length == 0) return NO;
    NSArray *usefulPatterns = @[@"Contact", @"Select", @"Picker", @"Forward", @"Message", @"Session"];
    for (NSString *pattern in usefulPatterns) {
        if ([className containsString:pattern]) return YES;
    }
    return NO;
}

static id cs_safeObjectIvar(id obj, const char *ivarName) {
    if (!obj || !ivarName) return nil;
    Ivar ivar = class_getInstanceVariable([obj class], ivarName);
    if (!ivar) return nil;
    @try {
        return object_getIvar(obj, ivar);
    } @catch (NSException *e) {
        return nil;
    }
}

static void cs_voiceForwardCollectTargetsFromPayload(id payload, NSMutableDictionary *targetMap, NSMutableSet *visited, NSUInteger depth) {
    if (!(payload && targetMap && visited) || depth > 4) return;
    
    NSValue *identity = [NSValue valueWithPointer:(__bridge const void *)(payload)];
    if ([visited containsObject:identity]) return;
    [visited addObject:identity];
    
    if ([payload isKindOfClass:[NSArray class]]) {
        for (id item in (NSArray *)payload) {
            cs_voiceForwardCollectTargetsFromPayload(item, targetMap, visited, depth + 1);
        }
        return;
    }
    if ([payload isKindOfClass:[NSSet class]]) {
        for (id item in (NSSet *)payload) {
            cs_voiceForwardCollectTargetsFromPayload(item, targetMap, visited, depth + 1);
        }
        return;
    }
    if ([payload isKindOfClass:[NSDictionary class]]) {
        for (id value in ((NSDictionary *)payload).allValues) {
            cs_voiceForwardCollectTargetsFromPayload(value, targetMap, visited, depth + 1);
        }
        return;
    }
    
    NSString *userName = cs_safeUserNameFromObject(payload);
    if (userName.length == 0 && [payload isKindOfClass:[NSString class]]) {
        userName = [(NSString *)payload stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if (userName.length > 0) {
        if (!targetMap[userName]) {
            targetMap[userName] = payload;
        }
        return;
    }
    
    NSString *className = NSStringFromClass([payload class]) ?: @"";
    if (!cs_voiceForwardClassLooksUseful(className)) return;
    
    NSArray *keys = @[
        @"selectedContacts", @"selectedContact", @"selectedContactList", @"selectedContactsArray",
        @"allSelectedContacts", @"m_selectedContacts", @"m_arrSelectedContacts", @"m_arrSelectContacts",
        @"m_selectContacts", @"targets", @"targetContacts", @"targetContact", @"toContacts", @"toContact",
        @"contacts", @"pickedContacts", @"pickedUsers", @"selectedUsers", @"selectedItems",
        @"m_targets", @"m_targetContacts", @"m_toContacts", @"m_contacts", @"m_selectedUsers",
        @"m_oSelectContacts", @"m_oTargetContact", @"m_oToContact"
    ];
    
    for (NSString *key in keys) {
        SEL selector = NSSelectorFromString(key);
        if ([payload respondsToSelector:selector]) {
            @try {
                id value = ((id (*)(id, SEL))objc_msgSend)(payload, selector);
                cs_voiceForwardCollectTargetsFromPayload(value, targetMap, visited, depth + 1);
            } @catch (NSException *e) {}
        }
        
        @try {
            id value = [payload valueForKey:key];
            cs_voiceForwardCollectTargetsFromPayload(value, targetMap, visited, depth + 1);
        } @catch (NSException *e) {}
        
        id ivarValue = cs_safeObjectIvar(payload, key.UTF8String);
        cs_voiceForwardCollectTargetsFromPayload(ivarValue, targetMap, visited, depth + 1);
        
        if (![key hasPrefix:@"_"]) {
            NSString *underscoreKey = [@"_" stringByAppendingString:key];
            id underscoredValue = cs_safeObjectIvar(payload, underscoreKey.UTF8String);
            cs_voiceForwardCollectTargetsFromPayload(underscoredValue, targetMap, visited, depth + 1);
        }
    }
    
    if ([payload respondsToSelector:@selector(allValues)]) {
        @try {
            id values = ((id (*)(id, SEL))objc_msgSend)(payload, @selector(allValues));
            cs_voiceForwardCollectTargetsFromPayload(values, targetMap, visited, depth + 1);
        } @catch (NSException *e) {}
    }
    if ([payload respondsToSelector:@selector(allObjects)]) {
        @try {
            id values = ((id (*)(id, SEL))objc_msgSend)(payload, @selector(allObjects));
            cs_voiceForwardCollectTargetsFromPayload(values, targetMap, visited, depth + 1);
        } @catch (NSException *e) {}
    }
}

static NSArray *cs_voiceForwardExtractTargetsFromPayload(id payload) {
    NSMutableDictionary *targetMap = [NSMutableDictionary dictionary];
    NSMutableSet *visited = [NSMutableSet set];
    cs_voiceForwardCollectTargetsFromPayload(payload, targetMap, visited, 0);
    return targetMap.allValues ?: @[];
}

static id cs_extractForwardMessageWrap(id generated) {
    if (!generated) return nil;
    if ([generated isKindOfClass:%c(CMessageWrap)]) return generated;
    if ([generated isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)generated;
        NSArray *keys = @[@"msgWrap", @"messageWrap", @"wrap", @"forwardMsgWrap", @"sendWrap"];
        for (NSString *key in keys) {
            id value = dict[key];
            if ([value isKindOfClass:%c(CMessageWrap)]) return value;
        }
    }
    SEL selectors[] = {
        NSSelectorFromString(@"messageWrap"),
        NSSelectorFromString(@"msgWrap"),
        NSSelectorFromString(@"forwardMessageWrap"),
        NSSelectorFromString(@"sendWrap")
    };
    for (size_t i = 0; i < sizeof(selectors)/sizeof(selectors[0]); ++i) {
        SEL selector = selectors[i];
        if ([generated respondsToSelector:selector]) {
            @try {
                id value = ((id (*)(id, SEL))objc_msgSend)(generated, selector);
                if ([value isKindOfClass:%c(CMessageWrap)]) return value;
            } @catch (NSException *e) {}
        }
    }
    return nil;
}

static void cs_patchGeneratedNativeForwardVoiceWrap(id sourceWrap, id targetContact, id generated, NSString *sceneTag) {
    if (!cs_isVoiceMessage(sourceWrap)) return;
    id sendWrap = cs_extractForwardMessageWrap(generated);
    if (!(sendWrap && sendWrap != sourceWrap)) return;
    NSString *targetUserName = cs_safeUserNameFromObject(targetContact);
    if (targetUserName.length == 0 && [targetContact isKindOfClass:[NSString class]]) {
        targetUserName = [(NSString *)targetContact stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    NSString *audioPath = nil;
    NSData *audioData = cs_loadVoiceAudioData(sourceWrap, &audioPath);
    if (audioData.length == 0) {
        cs_startDownloadVoiceIfNeeded(sourceWrap);
        return;
    }
    unsigned int voiceTime = cs_voiceTime(sourceWrap);
    unsigned int voiceFormat = cs_voiceFormat(sourceWrap);
    NSString *selfUserName = cs_currentSelfUserName();
    cs_resetIdentity(sendWrap);
    if (targetUserName.length > 0) {
        cs_prepareRoute(sendWrap, targetUserName, selfUserName);
    }
    cs_applyVoiceFields(sendWrap, sourceWrap, audioData, voiceTime, voiceFormat);
}

%hook VoiceMessageCellView

%end

%hook ForwardMsgUtil

+ (id)GenForwardMsgFromMsgWrap:(id)arg1 ToContact:(id)arg2 {
    if (!cs_isVoiceForwardEnabled()) return %orig;
    id generated = %orig;
    id sourceWrap = [arg1 isKindOfClass:%c(CMessageWrap)] ? arg1 : nil;
    id generatedWrap = cs_extractForwardMessageWrap(generated);
    cs_patchGeneratedNativeForwardVoiceWrap(sourceWrap, arg2, generated, @"ForwardMsgUtil.class.GenForward");
    return generated;
}

- (id)GenForwardMsgFromMsgWrap:(id)arg1 ToContact:(id)arg2 {
    if (!cs_isVoiceForwardEnabled()) return %orig;
    id generated = %orig;
    id sourceWrap = [arg1 isKindOfClass:%c(CMessageWrap)] ? arg1 : nil;
    id generatedWrap = cs_extractForwardMessageWrap(generated);
    cs_patchGeneratedNativeForwardVoiceWrap(sourceWrap, arg2, generated, @"ForwardMsgUtil.instance.GenForward");
    return generated;
}

%end

%hook ForwardMessageMgr

- (void)forwardMessage:(id)arg1 fromViewController:(id)arg2 {
    if (!cs_isVoiceForwardEnabled()) {
        %orig;
        return;
    }
    id wrap = [arg1 isKindOfClass:%c(CMessageWrap)] ? arg1 : nil;
    if (cs_isVoiceMessage(wrap)) {
        cs_voiceForwardSetPendingContext(self, wrap, arg2, -1);
    } else {
        cs_voiceForwardClearPendingContext(self);
    }
    %orig;
}

- (void)forwardMessage:(id)arg1 fromViewController:(id)arg2 forwardType:(long long)arg3 {
    if (!cs_isVoiceForwardEnabled()) {
        %orig;
        return;
    }
    id wrap = [arg1 isKindOfClass:%c(CMessageWrap)] ? arg1 : nil;

    if (cs_isVoiceMessage(wrap)) {
        cs_voiceForwardSetPendingContext(self, wrap, arg2, arg3);
    } else {
        cs_voiceForwardClearPendingContext(self);
    }
    %orig;
}

- (void)forwardMessage:(id)arg1 fromViewController:(id)arg2 toContact:(id)arg3 {
    if (!cs_isVoiceForwardEnabled()) {
        %orig;
        return;
    }
    id wrap = [arg1 isKindOfClass:%c(CMessageWrap)] ? arg1 : nil;
    NSString *targetUserName = cs_safeUserNameFromObject(arg3);
    
    if (targetUserName.length > 0) {
        cs_voiceForwardMarkTargetObserved(self);
    } else {
        NSLog(@"[语音转发] target 为空，不标记已观察");
    }
    %orig;
}

- (void)forwardMessage:(id)arg1 fromViewController:(id)arg2 toContact:(id)arg3 forwardType:(long long)arg4 {
    if (!cs_isVoiceForwardEnabled()) {
        %orig;
        return;
    }
    id wrap = [arg1 isKindOfClass:%c(CMessageWrap)] ? arg1 : nil;
    NSString *targetUserName = cs_safeUserNameFromObject(arg3);
    
    if (targetUserName.length > 0) {
        cs_voiceForwardMarkTargetObserved(self);
    } else {
        NSLog(@"[语音转发] target 为空，不标记已观察");
    }
    %orig;
}

- (void)OnForwardMessageCancel:(id)arg1 {
    if (!cs_isVoiceForwardEnabled()) {
        %orig;
        return;
    }
    cs_voiceForwardClearPendingContext(self);
    %orig;
}

- (void)OnForwardMessageSend:(id)arg1 {
    if (!cs_isVoiceForwardEnabled()) {
        %orig;
        return;
    }
    
    id pendingWrap = objc_getAssociatedObject(self, (__bridge const void *)kPendingWrapKey);
    NSNumber *pendingForwardType = objc_getAssociatedObject(self, (__bridge const void *)kPendingForwardTypeKey);
    NSMutableArray *targetCandidates = [NSMutableArray array];
    NSArray *payloadTargets = cs_voiceForwardExtractTargetsFromPayload(arg1);
    if (payloadTargets.count > 0) {
        [targetCandidates addObjectsFromArray:payloadTargets];
    }
    if ([(id)self respondsToSelector:@selector(forwardMessageLogics)]) {
        @try {
            id logics = ((id (*)(id, SEL))objc_msgSend)(self, @selector(forwardMessageLogics));
            NSArray *logicTargets = cs_voiceForwardExtractTargetsFromPayload(logics);
            if (logicTargets.count > 0) {
                [targetCandidates addObjectsFromArray:logicTargets];
            }
        } @catch (NSException *e) {
            NSLog(@"[语音转发] 获取 forwardMessageLogics 异常: %@", e);
        }
    }
    NSArray *targets = cs_voiceForwardExtractTargetsFromPayload(targetCandidates);
    BOOL hasPendingVoice = (pendingWrap && cs_isVoiceMessage(pendingWrap));
    if (!(hasPendingVoice && targets.count > 0)) {
        %orig;
        return;
    }
    BOOL observed = cs_voiceForwardTargetObserved(self);
    cs_voiceForwardClearPendingContext(self);
    if (observed) {
        %orig;
        return;
    }
    NSUInteger successCount = 0;
    for (id target in targets) {
        NSString *identifier = cs_safeUserNameFromObject(target);
        if (cs_forwardVoiceToTargetStrict(pendingWrap, target, identifier)) {
            successCount += 1;
        }
    }
    if (successCount > 0) {
        return;
    }
    %orig;
}

%end

%ctor {
    NSLog(@"[语音转发] 插件加载");
    [[NSNotificationCenter defaultCenter] addObserverForName:@"com.wechat.enhance.voice_forward.settings_changed"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
        NSLog(@"[语音转发] 设置已更新");
    }];
}
