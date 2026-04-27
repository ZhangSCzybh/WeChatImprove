#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <CoreFoundation/CoreFoundation.h>
#import "../Headers/WCHeaders.h"
#import "../HeadersFile/CommonMessageCellView.h"
#import "../Controllers/WCPLMessagePersistenceAdapter.h"

static NSString * const kRepeatEnabledKey = @"com.wechat.enhance.repeat.enabled";
static NSString * const kVoiceForwardEnabledKey = @"com.wechat.enhance.voice_forward.enabled";

static BOOL cs_isRepeatEnabled(void) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kRepeatEnabledKey];
}

static BOOL cs_isVoiceForwardEnabled(void) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVoiceForwardEnabledKey];
}

static BOOL cs_isVoiceMessage(id msgWrap) {
    if (!msgWrap) return NO;
    if (![msgWrap isKindOfClass:NSClassFromString(@"CMessageWrap")]) return NO;
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
    
    return nil;
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

static BOOL cs_isSupportedMessageType(id msgWrap) {
    if (!msgWrap) return NO;
    if (![msgWrap isKindOfClass:NSClassFromString(@"CMessageWrap")]) return NO;
    CMessageWrap *wrap = (CMessageWrap *)msgWrap;
    
    int msgType = wrap.m_uiMessageType;
    
    switch (msgType) {
        case 1:
        case 3:
        case 34:
        case 43:
        case 47:
        case 48:
        case 49:
            return YES;
        default:
            return NO;
    }
}

static CMessageWrap *cs_messageWrapFromCell(id cell) {
    if (!cell) return nil;
    
    CMessageWrap *msgWrap = nil;
    
    if ([cell respondsToSelector:@selector(getCurrentMessageWrap)]) {
        msgWrap = [cell performSelector:@selector(getCurrentMessageWrap)];
    } else if ([cell respondsToSelector:@selector(viewModel)]) {
        id viewModel = [cell performSelector:@selector(viewModel)];
        if (viewModel && [viewModel respondsToSelector:@selector(messageWrap)]) {
            msgWrap = [viewModel performSelector:@selector(messageWrap)];
        }
    }
    
    return msgWrap;
}

static BaseMsgContentViewController *cs_findChatViewController(id view) {
    UIResponder *responder = (UIResponder *)view;
    while (responder) {
        if ([responder isKindOfClass:%c(BaseMsgContentViewController)]) {
            return (BaseMsgContentViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

static void cs_performRepeatMessage(id cellView) {
    
    CMessageWrap *msgWrap = cs_messageWrapFromCell(cellView);
    
    if (!msgWrap) {
        NSLog(@"[复读] 失败: 未找到消息包装对象");
        return;
    }
    
    BaseMsgContentViewController *chatVC = cs_findChatViewController(cellView);
    if (!chatVC) {
        NSLog(@"[复读] 失败: 未找到聊天视图控制器");
        return;
    }
    
    SEL logicControllerSelector = NSSelectorFromString(@"m_logicController");
    id logicController = nil;
    
    if ([chatVC respondsToSelector:logicControllerSelector]) {
        logicController = [chatVC performSelector:logicControllerSelector];
    }
    
    if (!logicController) {
        logicControllerSelector = NSSelectorFromString(@"logicController");
        if ([chatVC respondsToSelector:logicControllerSelector]) {
            logicController = [chatVC performSelector:logicControllerSelector];
        }
    }
    
    if (!logicController) {
        Class mmContextClass = NSClassFromString(@"MMContext");
        if (mmContextClass) {
            SEL currentContextSelector = NSSelectorFromString(@"currentContext");
            if ([mmContextClass respondsToSelector:currentContextSelector]) {
                id mmContext = [mmContextClass performSelector:currentContextSelector];
                if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                    Class logicManagerClass = NSClassFromString(@"MMMsgLogicManager");
                    id logicManager = [mmContext performSelector:@selector(getService:) withObject:logicManagerClass];
                    if (logicManager && [logicManager respondsToSelector:NSSelectorFromString(@"GetCurrentLogicController")]) {
                        logicController = [logicManager performSelector:NSSelectorFromString(@"GetCurrentLogicController")];
                    }
                }
            }
        }
    }
    
    if (!logicController) {
        Class mmServiceCenterClass = NSClassFromString(@"MMServiceCenter");
        if (mmServiceCenterClass) {
            SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
            if ([mmServiceCenterClass respondsToSelector:defaultCenterSelector]) {
                id serviceCenter = [mmServiceCenterClass performSelector:defaultCenterSelector];
                if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                    Class logicManagerClass = NSClassFromString(@"MMMsgLogicManager");
                    id logicManager = [serviceCenter performSelector:@selector(getService:) withObject:logicManagerClass];
                    if (logicManager && [logicManager respondsToSelector:NSSelectorFromString(@"GetCurrentLogicController")]) {
                        logicController = [logicManager performSelector:NSSelectorFromString(@"GetCurrentLogicController")];
                    }
                }
            }
        }
    }
    
    if (!logicController) {
        NSLog(@"[复读] 失败: 未找到逻辑控制器");
        return;
    }
    
    
    int msgType = 0;
    if ([msgWrap respondsToSelector:@selector(m_uiMessageType)]) {
        msgType = [msgWrap m_uiMessageType];
    }
    
    
    if (msgType == 1) {
        NSString *msgContent = nil;
        if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
            msgContent = [msgWrap m_nsContent];
        }
        
        if (!msgContent || msgContent.length == 0) {
            NSLog(@"[复读] 失败: 文本消息内容为空");
            return;
        }
        
        
        BOOL sent = NO;
        
        SEL sendTextSelector = NSSelectorFromString(@"SendTextMessage:");
        if ([logicController respondsToSelector:sendTextSelector]) {
            @try {
                NSMethodSignature *signature = [logicController methodSignatureForSelector:sendTextSelector];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                [invocation setTarget:logicController];
                [invocation setSelector:sendTextSelector];
                [invocation setArgument:&msgContent atIndex:2];
                [invocation invoke];
                sent = YES;
            } @catch (NSException *e) {
                NSLog(@"[复读] SendTextMessage: 失败: %@", e);
            }
        }
        
        if (!sent) {
            SEL sendTextExternSelector = NSSelectorFromString(@"SendTextMessage:externInfo:");
            if ([logicController respondsToSelector:sendTextExternSelector]) {
                @try {
                    NSMethodSignature *signature = [logicController methodSignatureForSelector:sendTextExternSelector];
                    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                    [invocation setTarget:logicController];
                    [invocation setSelector:sendTextExternSelector];
                    id nilParam = nil;
                    [invocation setArgument:&msgContent atIndex:2];
                    [invocation setArgument:&nilParam atIndex:3];
                    [invocation invoke];
                    sent = YES;
                } @catch (NSException *e) {
                    NSLog(@"[复读] SendTextMessage:externInfo: 失败: %@", e);
                }
            }
        }
        
        if (!sent) {
            NSLog(@"[复读] 失败: 无法发送文本消息");
        }
    } else {
        
        NSString *chatName = nil;
        BOOL isSender = NO;
        @try {
            Class msgWrapClass = NSClassFromString(@"CMessageWrap");
            if (msgWrapClass && [msgWrapClass respondsToSelector:@selector(isSenderFromMsgWrap:)]) {
                isSender = [msgWrapClass isSenderFromMsgWrap:msgWrap];
            }
        } @catch (NSException *e) {
            NSLog(@"[复读] 获取isSender异常: %@", e);
        }
        
        if (isSender) {
            if ([msgWrap respondsToSelector:@selector(m_nsToUsr)]) {
                chatName = [msgWrap m_nsToUsr];
            }
        } else {
            if ([msgWrap respondsToSelector:@selector(m_nsFromUsr)]) {
                chatName = [msgWrap m_nsFromUsr];
            }
        }
        
        
        if (!chatName) {
            NSLog(@"[复读] 失败: 无法获取聊天名称");
            return;
        }
        
        BOOL sent = NO;
        
        if (msgType == 34) {
            
            Class mmContextClass = NSClassFromString(@"MMContext");
            id contactMgr = nil;
            if (mmContextClass) {
                SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                if ([mmContextClass respondsToSelector:currentContextSelector]) {
                    id mmContext = [mmContextClass performSelector:currentContextSelector];
                    if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                        Class contactMgrClass = NSClassFromString(@"CContactMgr");
                        contactMgr = [mmContext performSelector:@selector(getService:) withObject:contactMgrClass];
                    }
                }
            }
            
            if (!contactMgr) {
                Class mmServiceCenterClass = NSClassFromString(@"MMServiceCenter");
                if (mmServiceCenterClass) {
                    SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                    if ([mmServiceCenterClass respondsToSelector:defaultCenterSelector]) {
                        id serviceCenter = [mmServiceCenterClass performSelector:defaultCenterSelector];
                        if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                            Class contactMgrClass = NSClassFromString(@"CContactMgr");
                            contactMgr = [serviceCenter performSelector:@selector(getService:) withObject:contactMgrClass];
                        }
                    }
                }
            }
            
            NSString *audioPath = nil;
            NSData *audioData = nil;
            Class msgWrapClass = NSClassFromString(@"CMessageWrap");
            SEL getPathSelector = @selector(getPathOfAudio:);
            if (msgWrapClass && [msgWrapClass respondsToSelector:getPathSelector]) {
                @try {
                    audioPath = ((id (*)(id, SEL, id))objc_msgSend)(msgWrapClass, getPathSelector, msgWrap);
                    if (audioPath.length > 0) {
                        audioData = [NSData dataWithContentsOfFile:audioPath];
                    }
                } @catch (NSException *e) {
                    NSLog(@"[复读] 获取音频路径失败: %@", e);
                }
            }
            
            if (!audioData || audioData.length == 0) {
                id messageMgr = nil;
                if (mmContextClass) {
                    SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                    if ([mmContextClass respondsToSelector:currentContextSelector]) {
                        id mmContext = [mmContextClass performSelector:currentContextSelector];
                        if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                            Class messageMgrClass = NSClassFromString(@"CMessageMgr");
                            messageMgr = [mmContext performSelector:@selector(getService:) withObject:messageMgrClass];
                        }
                    }
                }
                
                SEL startDownloadSelector = NSSelectorFromString(@"StartDownloadByRecordMsg:");
                if (messageMgr && [messageMgr respondsToSelector:startDownloadSelector]) {
                    @try {
                        ((void (*)(id, SEL, id))objc_msgSend)(messageMgr, startDownloadSelector, msgWrap);
                    } @catch (NSException *e) {
                        NSLog(@"[复读] 触发语音下载失败: %@", e);
                    }
                }
                return;
            }
            
            unsigned int voiceTime = 0;
            @try {
                id voiceTimeValue = [msgWrap valueForKey:@"m_uiVoiceTime"];
                if ([voiceTimeValue respondsToSelector:@selector(unsignedIntValue)]) {
                    voiceTime = [voiceTimeValue unsignedIntValue];
                } else if ([voiceTimeValue respondsToSelector:@selector(intValue)]) {
                    voiceTime = (unsigned int)[voiceTimeValue intValue];
                }
            } @catch (NSException *e) {}
            if (voiceTime > 300) {
                voiceTime = (voiceTime + 999) / 1000;
            }
            if (voiceTime <= 1) {
                @try {
                    NSString *content = [msgWrap respondsToSelector:@selector(m_nsContent)] ? [msgWrap m_nsContent] : nil;
                    if (content.length > 0) {
                        NSRange startRange = [content rangeOfString:@"voicelength=\""];
                        if (startRange.location != NSNotFound) {
                            NSUInteger start = startRange.location + startRange.length;
                            NSRange endRange = [content rangeOfString:@"\"" options:0 range:NSMakeRange(start, content.length - start)];
                            if (endRange.location != NSNotFound) {
                                NSString *lengthStr = [content substringWithRange:NSMakeRange(start, endRange.location - start)];
                                unsigned int lengthMs = (unsigned int)[lengthStr longLongValue];
                                if (lengthMs > 0) {
                                    unsigned int parsedSeconds = (lengthMs + 999) / 1000;
                                    if (parsedSeconds > voiceTime) {
                                        voiceTime = parsedSeconds;
                                    }
                                }
                            }
                        }
                    }
                } @catch (NSException *e) {}
            }
            if (voiceTime <= 0) voiceTime = 1;
            
            unsigned int voiceFormat = 0;
            @try {
                id voiceFormatValue = [msgWrap valueForKey:@"m_uiVoiceFormat"];
                if ([voiceFormatValue respondsToSelector:@selector(unsignedIntValue)]) {
                    voiceFormat = [voiceFormatValue unsignedIntValue];
                } else if ([voiceFormatValue respondsToSelector:@selector(intValue)]) {
                    voiceFormat = (unsigned int)[voiceFormatValue intValue];
                }
            } @catch (NSException *e) {}
            if (voiceFormat == 0) {
                @try {
                    NSString *content = [msgWrap respondsToSelector:@selector(m_nsContent)] ? [msgWrap m_nsContent] : nil;
                    if (content.length > 0) {
                        NSRange startRange = [content rangeOfString:@"voiceformat=\""];
                        if (startRange.location != NSNotFound) {
                            NSUInteger start = startRange.location + startRange.length;
                            NSRange endRange = [content rangeOfString:@"\"" options:0 range:NSMakeRange(start, content.length - start)];
                            if (endRange.location != NSNotFound) {
                                NSString *formatStr = [content substringWithRange:NSMakeRange(start, endRange.location - start)];
                                voiceFormat = (unsigned int)[formatStr longLongValue];
                            }
                        }
                    }
                } @catch (NSException *e) {}
            }
            if (voiceFormat == 0) voiceFormat = 4;
            
            
            NSString *selfUserName = nil;
            if (contactMgr && [contactMgr respondsToSelector:@selector(getSelfContact)]) {
                @try {
                    id selfContact = [contactMgr getSelfContact];
                    if (selfContact && [selfContact respondsToSelector:@selector(m_nsUsrName)]) {
                        selfUserName = [selfContact m_nsUsrName];
                    }
                } @catch (NSException *e) {}
            }
            
            CMessageWrap *sendWrap = nil;
            Class wrapClass = NSClassFromString(@"CMessageWrap");
            if (wrapClass && [wrapClass instancesRespondToSelector:@selector(initWithMsgType:)]) {
                @try {
                    sendWrap = ((id (*)(id, SEL, int))objc_msgSend)([wrapClass alloc], @selector(initWithMsgType:), 34);
                } @catch (NSException *e) {}
            }
            
            if (!sendWrap) {
                NSLog(@"[复读] 语音复读失败: 无法创建消息包装");
                return;
            }
            
            if ([sendWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
                [sendWrap setValue:chatName forKey:@"m_nsToUsr"];
            }
            if (selfUserName.length > 0 && [sendWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
                [sendWrap setValue:selfUserName forKey:@"m_nsFromUsr"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiIsSenderStatus:)]) {
                [sendWrap setValue:@(1) forKey:@"m_uiIsSenderStatus"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiMessageType:)]) {
                [sendWrap setValue:@(34) forKey:@"m_uiMessageType"];
            }
            if (audioData && [sendWrap respondsToSelector:@selector(setM_dtVoice:)]) {
                [sendWrap setValue:audioData forKey:@"m_dtVoice"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiVoiceTime:)]) {
                [sendWrap setValue:@(voiceTime) forKey:@"m_uiVoiceTime"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiVoiceFormat:)]) {
                [sendWrap setValue:@(voiceFormat) forKey:@"m_uiVoiceFormat"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiVoiceEndFlag:)]) {
                [sendWrap setValue:@(1) forKey:@"m_uiVoiceEndFlag"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiVoiceCancelFlag:)]) {
                [sendWrap setValue:@(0) forKey:@"m_uiVoiceCancelFlag"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiVoiceForwardFlag:)]) {
                [sendWrap setValue:@(0) forKey:@"m_uiVoiceForwardFlag"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiStatus:)]) {
                [sendWrap setValue:@(1) forKey:@"m_uiStatus"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiDownloadStatus:)]) {
                [sendWrap setValue:@(9) forKey:@"m_uiDownloadStatus"];
            }
            
            unsigned int voiceLengthMs = voiceTime * 1000;
            NSString *voiceContent = [NSString stringWithFormat:@"<msg><voicemsg voicelength=\"%u\" voiceformat=\"%u\" forwardflag=\"0\" /></msg>", voiceLengthMs, voiceFormat];
            if ([sendWrap respondsToSelector:@selector(setM_nsContent:)]) {
                [sendWrap setValue:voiceContent forKey:@"m_nsContent"];
            }
            
            if ([sendWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
                [sendWrap setValue:@(0) forKey:@"m_uiMesLocalID"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
                [sendWrap setValue:@(0) forKey:@"m_n64MesSvrID"];
            }
            
            unsigned int now = (unsigned int)[[NSDate date] timeIntervalSince1970];
            if ([sendWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
                [sendWrap setValue:@(now) forKey:@"m_uiCreateTime"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiSendTime:)]) {
                [sendWrap setValue:@(now) forKey:@"m_uiSendTime"];
            }
            
            NSString *clientMsgID = nil;
            if (selfUserName.length > 0) {
                clientMsgID = [NSString stringWithFormat:@"%@_%u_%u", selfUserName, now, arc4random()];
            } else {
                clientMsgID = [NSString stringWithFormat:@"cs_%u_%u", now, arc4random()];
            }
            if ([sendWrap respondsToSelector:@selector(setM_nsClientMsgID:)]) {
                [sendWrap setValue:clientMsgID forKey:@"m_nsClientMsgID"];
            }
            
            Class extendClass = NSClassFromString(@"CExtendInfoOfVoiceMsg");
            if (extendClass) {
                @try {
                    id extendInfo = [[extendClass alloc] init];
                    if (extendInfo) {
                        if (audioData && [extendInfo respondsToSelector:@selector(setM_dtVoice:)]) {
                            [extendInfo setValue:audioData forKey:@"m_dtVoice"];
                        }
                        if ([extendInfo respondsToSelector:@selector(setM_uiVoiceTime:)]) {
                            [extendInfo setValue:@(voiceTime) forKey:@"m_uiVoiceTime"];
                        }
                        if ([extendInfo respondsToSelector:@selector(setM_uiVoiceFormat:)]) {
                            [extendInfo setValue:@(voiceFormat) forKey:@"m_uiVoiceFormat"];
                        }
                        if ([extendInfo respondsToSelector:@selector(setM_uiVoiceForwardFlag:)]) {
                            [extendInfo setValue:@(0) forKey:@"m_uiVoiceForwardFlag"];
                        }
                        if ([extendInfo respondsToSelector:@selector(setM_uiVoiceCancelFlag:)]) {
                            [extendInfo setValue:@(0) forKey:@"m_uiVoiceCancelFlag"];
                        }
                        if ([extendInfo respondsToSelector:@selector(setM_uiVoiceEndFlag:)]) {
                            [extendInfo setValue:@(1) forKey:@"m_uiVoiceEndFlag"];
                        }
                        if ([extendInfo respondsToSelector:@selector(setM_refMessageWrap:)]) {
                            [extendInfo setValue:sendWrap forKey:@"m_refMessageWrap"];
                        }
                        if ([sendWrap respondsToSelector:@selector(setM_extendInfoWithMsgType:)]) {
                            [sendWrap setValue:extendInfo forKey:@"m_extendInfoWithMsgType"];
                        }
                    }
                } @catch (NSException *e) {
                    NSLog(@"[复读] 设置语音扩展信息失败: %@", e);
                }
            }
            
            id messageMgr = nil;
            if (mmContextClass) {
                SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                if ([mmContextClass respondsToSelector:currentContextSelector]) {
                    id mmContext = [mmContextClass performSelector:currentContextSelector];
                    if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                        Class messageMgrClass = NSClassFromString(@"CMessageMgr");
                        messageMgr = [mmContext performSelector:@selector(getService:) withObject:messageMgrClass];
                    }
                }
            }
            
            if (messageMgr) {
                WCPLAddLocalMsgInsertRequest request = {
                    .messageMgr = messageMgr,
                    .sessionUserName = chatName,
                    .msgWrap = sendWrap,
                    .fixTime = NO,
                    .notify = YES,
                    .unique = NO
                };
                
                WCPLAddLocalMsgInsertPath insertPath = WCPLAddLocalMsgInsertPathNone;
                BOOL inserted = WCPLAddLocalMsgInsert(request, &insertPath);
                
                if (inserted) {
                    unsigned int localID = 0;
                    @try {
                        localID = [sendWrap respondsToSelector:@selector(m_uiMesLocalID)] ?
                            ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiMesLocalID)) : 0;
                    } @catch (NSException *e) {}
                    
                    SEL resendVoiceSel = NSSelectorFromString(@"ResendVoiceMsg:MsgWrap:");
                    
                    id audioSender = nil;
                    if (mmContextClass) {
                        SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                        if ([mmContextClass respondsToSelector:currentContextSelector]) {
                            id mmContext = [mmContextClass performSelector:currentContextSelector];
                            if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                                Class audioSenderClass = NSClassFromString(@"AudioSender");
                                audioSender = [mmContext performSelector:@selector(getService:) withObject:audioSenderClass];
                            }
                        }
                    }
                    
                    if (audioSender && [audioSender respondsToSelector:resendVoiceSel]) {
                        @try {
                            ((void (*)(id, SEL, id, id))objc_msgSend)(audioSender, resendVoiceSel, chatName, sendWrap);
                            sent = YES;
                        } @catch (NSException *e) {
                            NSLog(@"[复读] AudioSender.ResendVoiceMsg 失败: %@", e);
                        }
                    }
                    
                    if (!sent) {
                        id uploadVoiceMgr = nil;
                        if (mmContextClass) {
                            SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                            if ([mmContextClass respondsToSelector:currentContextSelector]) {
                                id mmContext = [mmContextClass performSelector:currentContextSelector];
                                if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                                    Class uploadVoiceMgrClass = NSClassFromString(@"MMNewUploadVoiceMgr");
                                    uploadVoiceMgr = [mmContext performSelector:@selector(getService:) withObject:uploadVoiceMgrClass];
                                }
                            }
                        }
                        
                        if (uploadVoiceMgr && [uploadVoiceMgr respondsToSelector:resendVoiceSel]) {
                            @try {
                                ((void (*)(id, SEL, id, id))objc_msgSend)(uploadVoiceMgr, resendVoiceSel, chatName, sendWrap);
                                sent = YES;
                            } @catch (NSException *e) {
                                NSLog(@"[复读] MMNewUploadVoiceMgr.ResendVoiceMsg 失败: %@", e);
                            }
                        }
                    }
                    
                    if (!sent) {
                        id uploadVoiceCDNMgr = nil;
                        if (mmContextClass) {
                            SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                            if ([mmContextClass respondsToSelector:currentContextSelector]) {
                                id mmContext = [mmContextClass performSelector:currentContextSelector];
                                if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                                    Class uploadVoiceCDNMgrClass = NSClassFromString(@"UploadVoiceCDNMgr");
                                    uploadVoiceCDNMgr = [mmContext performSelector:@selector(getService:) withObject:uploadVoiceCDNMgrClass];
                                }
                            }
                        }
                        
                        if (uploadVoiceCDNMgr && [uploadVoiceCDNMgr respondsToSelector:resendVoiceSel]) {
                            @try {
                                ((void (*)(id, SEL, id, id))objc_msgSend)(uploadVoiceCDNMgr, resendVoiceSel, chatName, sendWrap);
                                sent = YES;
                            } @catch (NSException *e) {
                                NSLog(@"[复读] UploadVoiceCDNMgr.ResendVoiceMsg 失败: %@", e);
                            }
                        }
                    }
                } else {
                    NSLog(@"[复读] AddLocalMsg 失败");
                }
            } else {
                NSLog(@"[复读] 无法获取 CMessageMgr");
            }
            
            if (!sent) {
                NSLog(@"[复读] 语音复读失败: 所有发送方式均失败");
            }
        } else {
        
        CMessageWrap *sendWrap = nil;
        
        if ([msgWrap respondsToSelector:@selector(copy)]) {
            @try {
                id copiedWrap = [msgWrap copy];
                if ([copiedWrap isKindOfClass:NSClassFromString(@"CMessageWrap")] && copiedWrap != msgWrap) {
                    sendWrap = (CMessageWrap *)copiedWrap;
                }
            } @catch (NSException *e) {
                NSLog(@"[复读] copy 失败: %@", e);
            }
        }
        
        if (!sendWrap) {
            Class wrapClass = NSClassFromString(@"CMessageWrap");
            if (wrapClass && [wrapClass instancesRespondToSelector:@selector(initWithMsgType:)]) {
                @try {
                    sendWrap = ((id (*)(id, SEL, int))objc_msgSend)([wrapClass alloc], @selector(initWithMsgType:), msgType);
                } @catch (NSException *e) {
                    NSLog(@"[复读] initWithMsgType: 失败: %@", e);
                }
            }
        }
        
        if (!sendWrap) {
            NSLog(@"[复读] 失败: 无法创建新消息包装对象");
            return;
        }
        
        NSString *selfUserName = nil;
        id contactMgr = nil;
        
        Class mmContextClass = NSClassFromString(@"MMContext");
        if (mmContextClass) {
            SEL currentContextSelector = NSSelectorFromString(@"currentContext");
            if ([mmContextClass respondsToSelector:currentContextSelector]) {
                id mmContext = [mmContextClass performSelector:currentContextSelector];
                if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                    Class contactMgrClass = NSClassFromString(@"CContactMgr");
                    contactMgr = [mmContext performSelector:@selector(getService:) withObject:contactMgrClass];
                }
            }
        }
        
        if (contactMgr && [contactMgr respondsToSelector:@selector(getSelfContact)]) {
            @try {
                id selfContact = [contactMgr getSelfContact];
                if (selfContact && [selfContact respondsToSelector:@selector(m_nsUsrName)]) {
                    selfUserName = [selfContact m_nsUsrName];
                }
            } @catch (NSException *e) {
                NSLog(@"[复读] 获取当前用户失败: %@", e);
            }
        }
        
        if ([sendWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
            [sendWrap setValue:chatName forKey:@"m_nsToUsr"];
        }
        
        if (selfUserName.length > 0 && [sendWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
            [sendWrap setValue:selfUserName forKey:@"m_nsFromUsr"];
        }
        
        BOOL isChatRoom = [chatName containsString:@"@chatroom"];
        if (isChatRoom && selfUserName.length > 0 && [sendWrap respondsToSelector:@selector(setM_nsRealChatUsr:)]) {
            @try {
                [sendWrap setValue:selfUserName forKey:@"m_nsRealChatUsr"];
            } @catch (NSException *e) {
                NSLog(@"[复读] 设置 m_nsRealChatUsr 失败: %@", e);
            }
        }
        
        if ([sendWrap respondsToSelector:@selector(setM_uiIsSenderStatus:)]) {
            [sendWrap setValue:@(1) forKey:@"m_uiIsSenderStatus"];
        }
        
        if ([sendWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
            [sendWrap setValue:@(0) forKey:@"m_uiMesLocalID"];
        }
        
        if ([sendWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
            [sendWrap setValue:@(0) forKey:@"m_n64MesSvrID"];
        }
        
        if ([sendWrap respondsToSelector:@selector(setM_uiStatus:)]) {
            [sendWrap setValue:@(0) forKey:@"m_uiStatus"];
        }
        
        unsigned int now = (unsigned int)[[NSDate date] timeIntervalSince1970];
        if ([sendWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
            [sendWrap setValue:@(now) forKey:@"m_uiCreateTime"];
        }
        
        if ([sendWrap respondsToSelector:@selector(setM_uiSendTime:)]) {
            [sendWrap setValue:@(now) forKey:@"m_uiSendTime"];
        }
        
        NSString *clientMsgID = nil;
        if (selfUserName.length > 0) {
            clientMsgID = [NSString stringWithFormat:@"%@_%u_%u", selfUserName, now, arc4random()];
        } else {
            clientMsgID = [NSString stringWithFormat:@"cs_%u_%u", now, arc4random()];
        }
        if ([sendWrap respondsToSelector:@selector(setM_nsClientMsgID:)]) {
            [sendWrap setValue:clientMsgID forKey:@"m_nsClientMsgID"];
        }
        
        
        BOOL sent = NO;
        
        if (msgType == 43) {
            
            Class forwardUtilClass = NSClassFromString(@"ForwardMsgUtil");
            if (!forwardUtilClass) {
                
                SEL addMsgSelector = NSSelectorFromString(@"AddMsgToSendTable:MsgWrap:");
                id sendMessageMgr = nil;
                
                Class mmContextClass = NSClassFromString(@"MMContext");
                if (mmContextClass) {
                    SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                    if ([mmContextClass respondsToSelector:currentContextSelector]) {
                        id mmContext = [mmContextClass performSelector:currentContextSelector];
                        if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                            Class sendMessageMgrClass = NSClassFromString(@"SendMessageMgr");
                            sendMessageMgr = [mmContext performSelector:@selector(getService:) withObject:sendMessageMgrClass];
                        }
                    }
                }
                
                if (sendMessageMgr && [sendMessageMgr respondsToSelector:addMsgSelector]) {
                    @try {
                        ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgSelector, chatName, sendWrap);
                        sent = YES;
                    } @catch (NSException *e) {
                        NSLog(@"[复读] SendMessageMgr.AddMsgToSendTable 失败: %@", e);
                    }
                }
            } else {
                SEL specificSelector = NSSelectorFromString(@"GenForwardVideoFromMsgWrap:");
                SEL genericSelector = NSSelectorFromString(@"GenForwardMsgFromMsgWrap:ToContact:");
                
                BOOL hasSpecificSelector = [forwardUtilClass respondsToSelector:specificSelector];
                BOOL hasGenericSelector = [forwardUtilClass respondsToSelector:genericSelector];
                
                id generated = nil;
                CMessageWrap *forwardWrap = nil;
                id videoInfo = nil;
                
                if (hasSpecificSelector) {
                    @try {
                        generated = ((id (*)(id, SEL, id))objc_msgSend)(forwardUtilClass, specificSelector, msgWrap);
                        
                        if ([generated isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
                            forwardWrap = (CMessageWrap *)generated;
                        } else if ([generated isKindOfClass:NSClassFromString(@"CaptureVideoInfo")]) {
                            videoInfo = generated;
                        } else if ([generated respondsToSelector:@selector(msgWrap)]) {
                            @try {
                                id nested = [generated performSelector:@selector(msgWrap)];
                                if ([nested isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
                                    forwardWrap = (CMessageWrap *)nested;
                                }
                            } @catch (NSException *e) {
                                NSLog(@"[复读] 获取 msgWrap 失败: %@", e);
                            }
                        }
                    } @catch (NSException *e) {
                        NSLog(@"[复读] GenForwardVideoFromMsgWrap 失败: %@", e);
                    }
                }
                
                if (videoInfo) {
                    id messageMgr = nil;
                    Class mmContextClass = NSClassFromString(@"MMContext");
                    if (mmContextClass) {
                        SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                        if ([mmContextClass respondsToSelector:currentContextSelector]) {
                            id mmContext = [mmContextClass performSelector:currentContextSelector];
                            if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                                Class messageMgrClass = NSClassFromString(@"CMessageMgr");
                                messageMgr = [mmContext performSelector:@selector(getService:) withObject:messageMgrClass];
                            }
                        }
                    }
                    
                    if (messageMgr) {
                        NSArray<NSString *> *selectorCandidates = @[
                            @"AddVideoMsg:ToUsr:VideoInfo:MsgType:",
                            @"AddVideoMsg:ToUsr:VideoInfo:",
                            @"AddShortVideoMsg:ToUsr:VideoInfo:"
                        ];
                        
                        for (NSString *selectorName in selectorCandidates) {
                            SEL selector = NSSelectorFromString(selectorName);
                            if (![messageMgr respondsToSelector:selector]) {
                                continue;
                            }
                            
                            @try {
                                id sendResult = nil;
                                NSString *fromUser = selfUserName.length > 0 ? selfUserName : chatName;
                                
                                if ([selectorName isEqualToString:@"AddVideoMsg:ToUsr:VideoInfo:MsgType:"]) {
                                    sendResult = ((id (*)(id, SEL, id, id, id, unsigned int))objc_msgSend)(messageMgr,
                                                                                                             selector,
                                                                                                             fromUser,
                                                                                                             chatName,
                                                                                                             videoInfo,
                                                                                                             (unsigned int)43);
                                } else {
                                    sendResult = ((id (*)(id, SEL, id, id, id))objc_msgSend)(messageMgr,
                                                                                              selector,
                                                                                              fromUser,
                                                                                              chatName,
                                                                                              videoInfo);
                                }
                                
                                if (sendResult) {
                                    sent = YES;
                                    break;
                                }
                            } @catch (NSException *e) {
                                NSLog(@"[复读] %@ 失败: %@", selectorName, e);
                            }
                        }
                    }
                }
                
                if (!sent && !forwardWrap && hasGenericSelector) {
                    id contact = nil;
                    Class mmContextClass = NSClassFromString(@"MMContext");
                    if (mmContextClass) {
                        SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                        if ([mmContextClass respondsToSelector:currentContextSelector]) {
                            id mmContext = [mmContextClass performSelector:currentContextSelector];
                            if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                                Class contactMgrClass = NSClassFromString(@"CContactMgr");
                                id contactMgr = [mmContext performSelector:@selector(getService:) withObject:contactMgrClass];
                                if (contactMgr && [contactMgr respondsToSelector:@selector(getContactByName:)]) {
                                    contact = [contactMgr performSelector:@selector(getContactByName:) withObject:chatName];
                                }
                            }
                        }
                    }
                    
                    if (contact) {
                        @try {
                            generated = ((id (*)(id, SEL, id, id))objc_msgSend)(forwardUtilClass, genericSelector, msgWrap, contact);
                            
                            if ([generated isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
                                forwardWrap = (CMessageWrap *)generated;
                            } else if ([generated respondsToSelector:@selector(msgWrap)]) {
                                @try {
                                    id nested = [generated performSelector:@selector(msgWrap)];
                                    if ([nested isKindOfClass:NSClassFromString(@"CMessageWrap")]) {
                                        forwardWrap = (CMessageWrap *)nested;
                                    }
                                } @catch (NSException *e) {
                                    NSLog(@"[复读] 获取 msgWrap 失败: %@", e);
                                }
                            }
                        } @catch (NSException *e) {
                            NSLog(@"[复读] GenForwardMsgFromMsgWrap:ToContact: 失败: %@", e);
                        }
                    } else {
                    }
                }
                
                if (!sent && forwardWrap) {
                    if (forwardWrap == msgWrap) {
                        forwardWrap = sendWrap;
                    }
                    
                    if ([forwardWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
                        [forwardWrap setValue:chatName forKey:@"m_nsToUsr"];
                    }
                    
                    if (selfUserName.length > 0 && [forwardWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
                        [forwardWrap setValue:selfUserName forKey:@"m_nsFromUsr"];
                    }
                    
                    if ([forwardWrap respondsToSelector:@selector(setM_uiIsSenderStatus:)]) {
                        [forwardWrap setValue:@(1) forKey:@"m_uiIsSenderStatus"];
                    }
                    
                    if ([forwardWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
                        [forwardWrap setValue:@(0) forKey:@"m_uiMesLocalID"];
                    }
                    
                    if ([forwardWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
                        [forwardWrap setValue:@(0) forKey:@"m_n64MesSvrID"];
                    }
                    
                    unsigned int now = (unsigned int)[[NSDate date] timeIntervalSince1970];
                    if ([forwardWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
                        [forwardWrap setValue:@(now) forKey:@"m_uiCreateTime"];
                    }
                    
                    if ([forwardWrap respondsToSelector:@selector(setM_uiSendTime:)]) {
                        [forwardWrap setValue:@(now) forKey:@"m_uiSendTime"];
                    }
                    
                    NSString *forwardClientMsgID = nil;
                    if (selfUserName.length > 0) {
                        forwardClientMsgID = [NSString stringWithFormat:@"%@_%u_%u", selfUserName, now, arc4random()];
                    } else {
                        forwardClientMsgID = [NSString stringWithFormat:@"cs_%u_%u", now, arc4random()];
                    }
                    if ([forwardWrap respondsToSelector:@selector(setM_nsClientMsgID:)]) {
                        [forwardWrap setValue:forwardClientMsgID forKey:@"m_nsClientMsgID"];
                    }
                    
                    
                    SEL addMsgSelector = NSSelectorFromString(@"AddMsgToSendTable:MsgWrap:");
                    id sendMessageMgr = nil;
                    
                    Class mmContextClass = NSClassFromString(@"MMContext");
                    if (mmContextClass) {
                        SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                        if ([mmContextClass respondsToSelector:currentContextSelector]) {
                            id mmContext = [mmContextClass performSelector:currentContextSelector];
                            if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                                Class sendMessageMgrClass = NSClassFromString(@"SendMessageMgr");
                                sendMessageMgr = [mmContext performSelector:@selector(getService:) withObject:sendMessageMgrClass];
                            }
                        }
                    }
                    
                    if (sendMessageMgr && [sendMessageMgr respondsToSelector:addMsgSelector]) {
                        @try {
                            ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgSelector, chatName, forwardWrap);
                            sent = YES;
                        } @catch (NSException *e) {
                            NSLog(@"[复读] SendMessageMgr.AddMsgToSendTable 失败: %@", e);
                        }
                    }
                }
                
                if (!sent) {
                    
                    SEL addMsgSelector = NSSelectorFromString(@"AddMsgToSendTable:MsgWrap:");
                    id sendMessageMgr = nil;
                    
                    Class mmContextClass = NSClassFromString(@"MMContext");
                    if (mmContextClass) {
                        SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                        if ([mmContextClass respondsToSelector:currentContextSelector]) {
                            id mmContext = [mmContextClass performSelector:currentContextSelector];
                            if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                                Class sendMessageMgrClass = NSClassFromString(@"SendMessageMgr");
                                sendMessageMgr = [mmContext performSelector:@selector(getService:) withObject:sendMessageMgrClass];
                            }
                        }
                    }
                    
                    if (sendMessageMgr && [sendMessageMgr respondsToSelector:addMsgSelector]) {
                        @try {
                            ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgSelector, chatName, sendWrap);
                            sent = YES;
                        } @catch (NSException *e) {
                            NSLog(@"[复读] SendMessageMgr.AddMsgToSendTable 失败: %@", e);
                        }
                    }
                }
            }
            
            if (!sent) {
                NSLog(@"[复读] 视频复读失败: 所有发送方式均失败");
            }
        } else if (msgType == 47) {
            
            NSString *emoticonMD5 = nil;
            if ([msgWrap respondsToSelector:@selector(m_nsEmoticonMD5)]) {
                emoticonMD5 = [msgWrap m_nsEmoticonMD5];
            }
            
            if (emoticonMD5.length == 32 && [sendWrap respondsToSelector:@selector(setM_nsEmoticonMD5:)]) {
                [sendWrap setValue:emoticonMD5 forKey:@"m_nsEmoticonMD5"];
            }
            
            id messageMgr = nil;
            
            if (mmContextClass) {
                SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                if ([mmContextClass respondsToSelector:currentContextSelector]) {
                    id mmContext = [mmContextClass performSelector:currentContextSelector];
                    if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                        Class messageMgrClass = NSClassFromString(@"CMessageMgr");
                        messageMgr = [mmContext performSelector:@selector(getService:) withObject:messageMgrClass];
                    }
                }
            }
            
            if (!messageMgr) {
                Class mmServiceCenterClass = NSClassFromString(@"MMServiceCenter");
                if (mmServiceCenterClass) {
                    SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                    if ([mmServiceCenterClass respondsToSelector:defaultCenterSelector]) {
                        id serviceCenter = [mmServiceCenterClass performSelector:defaultCenterSelector];
                        if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                            Class messageMgrClass = NSClassFromString(@"CMessageMgr");
                            messageMgr = [serviceCenter performSelector:@selector(getService:) withObject:messageMgrClass];
                        }
                    }
                }
            }
            
            if (messageMgr) {
                SEL addEmoticonSelector = NSSelectorFromString(@"AddEmoticonMsg:MsgWrap:");
                if ([messageMgr respondsToSelector:addEmoticonSelector]) {
                    @try {
                        NSMethodSignature *signature = [messageMgr methodSignatureForSelector:addEmoticonSelector];
                        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                        [invocation setTarget:messageMgr];
                        [invocation setSelector:addEmoticonSelector];
                        [invocation setArgument:&chatName atIndex:2];
                        [invocation setArgument:&sendWrap atIndex:3];
                        [invocation invoke];
                        sent = YES;
                    } @catch (NSException *e) {
                        NSLog(@"[复读] CMessageMgr.AddEmoticonMsg:MsgWrap: 失败: %@", e);
                    }
                }
            }
        } else if (msgType == 3 || msgType == 42 || msgType == 49) {
            
            id messageMgr = nil;
            
            if (mmContextClass) {
                SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                if ([mmContextClass respondsToSelector:currentContextSelector]) {
                    id mmContext = [mmContextClass performSelector:currentContextSelector];
                    if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                        Class messageMgrClass = NSClassFromString(@"CMessageMgr");
                        messageMgr = [mmContext performSelector:@selector(getService:) withObject:messageMgrClass];
                    }
                }
            }
            
            if (!messageMgr) {
                Class mmServiceCenterClass = NSClassFromString(@"MMServiceCenter");
                if (mmServiceCenterClass) {
                    SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                    if ([mmServiceCenterClass respondsToSelector:defaultCenterSelector]) {
                        id serviceCenter = [mmServiceCenterClass performSelector:defaultCenterSelector];
                        if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                            Class messageMgrClass = NSClassFromString(@"CMessageMgr");
                            messageMgr = [serviceCenter performSelector:@selector(getService:) withObject:messageMgrClass];
                        }
                    }
                }
            }
            
            if (messageMgr) {
                SEL resendMsgSelector = NSSelectorFromString(@"ResendMsg:MsgWrap:");
                if ([messageMgr respondsToSelector:resendMsgSelector]) {
                    @try {
                        NSMethodSignature *signature = [messageMgr methodSignatureForSelector:resendMsgSelector];
                        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                        [invocation setTarget:messageMgr];
                        [invocation setSelector:resendMsgSelector];
                        [invocation setArgument:&chatName atIndex:2];
                        [invocation setArgument:&sendWrap atIndex:3];
                        [invocation invoke];
                        sent = YES;
                    } @catch (NSException *e) {
                        NSLog(@"[复读] CMessageMgr.ResendMsg:MsgWrap: 失败: %@", e);
                    }
                } else {
                }
            } else {
                NSLog(@"[复读] 复读失败: 无法获取 CMessageMgr");
            }
        }
        
        if (!sent) {
            id sendMessageMgr = nil;
            
            if (mmContextClass) {
                SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                if ([mmContextClass respondsToSelector:currentContextSelector]) {
                    id mmContext = [mmContextClass performSelector:currentContextSelector];
                    if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                        Class sendMessageMgrClass = NSClassFromString(@"SendMessageMgr");
                        sendMessageMgr = [mmContext performSelector:@selector(getService:) withObject:sendMessageMgrClass];
                    }
                }
            }
            
            if (!sendMessageMgr) {
                Class mmServiceCenterClass = NSClassFromString(@"MMServiceCenter");
                if (mmServiceCenterClass) {
                    SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                    if ([mmServiceCenterClass respondsToSelector:defaultCenterSelector]) {
                        id serviceCenter = [mmServiceCenterClass performSelector:defaultCenterSelector];
                        if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                            Class sendMessageMgrClass = NSClassFromString(@"SendMessageMgr");
                            sendMessageMgr = [serviceCenter performSelector:@selector(getService:) withObject:sendMessageMgrClass];
                        }
                    }
                }
            }
            
            if (sendMessageMgr) {
                SEL addMsgSelector = NSSelectorFromString(@"AddMsgToSendTable:MsgWrap:");
                if ([sendMessageMgr respondsToSelector:addMsgSelector]) {
                    @try {
                        ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgSelector, chatName, sendWrap);
                        sent = YES;
                    } @catch (NSException *e) {
                        NSLog(@"[复读] SendMessageMgr.AddMsgToSendTable:MsgWrap: 失败: %@", e);
                    }
                }
            }
        }
        
        if (!sent) {
            NSLog(@"[复读] 失败: 所有发送方式均失败");
        }
        }
    }
}

static BOOL cs_isRepeatSupportedForCell(id cell) {
    if (!cs_isRepeatEnabled()) {
        return NO;
    }
    
    CMessageWrap *msgWrap = cs_messageWrapFromCell(cell);
    return cs_isSupportedMessageType(msgWrap);
}

static void cs_applyMenuItemIcon(id menuItem, UIImage *icon, UIColor *tintColor) {
    if (!menuItem || ![icon isKindOfClass:[UIImage class]]) {
        return;
    }

    UIImage *finalIcon = icon;
    if (tintColor && [finalIcon respondsToSelector:@selector(imageWithTintColor:)]) {
        @try {
            finalIcon = [finalIcon imageWithTintColor:tintColor];
        } @catch (NSException *e) {
            NSLog(@"[菜单图标] imageWithTintColor失败: %@", e);
            finalIcon = icon;
        }
    }
    
    if ([finalIcon respondsToSelector:@selector(imageWithRenderingMode:)]) {
        finalIcon = [finalIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }

    if ([menuItem respondsToSelector:@selector(setIconImage:)]) {
        @try {
            [menuItem setIconImage:finalIcon];
            return;
        } @catch (NSException *e) {
            NSLog(@"[菜单图标] setIconImage失败: %@", e);
        }
    }

    @try {
        [menuItem setValue:finalIcon forKey:@"iconImage"];
    } @catch (NSException *e) {
        NSLog(@"[菜单图标] KVC设置iconImage失败: %@", e);
    }
}

static id cs_createRepeatMenuItem(Class menuItemClass, id cell, SEL action) {
    if (!menuItemClass || !cell || !action) {
        return nil;
    }
    
    id menuItem = nil;
    NSString *title = @"复读";
    UIImage *icon = [UIImage systemImageNamed:@"repeat"];
    
    if (icon && [menuItemClass instancesRespondToSelector:@selector(initWithTitle:icon:target:action:)]) {
        @try {
            menuItem = [[menuItemClass alloc] initWithTitle:title icon:icon target:cell action:action];
        } @catch (NSException *e) {
        }
    }
    
    if (!menuItem && [menuItemClass instancesRespondToSelector:@selector(initWithTitle:target:action:)]) {
        @try {
            menuItem = [[menuItemClass alloc] initWithTitle:title target:cell action:action];
        } @catch (NSException *e) {
        }
    }
    
    if (menuItem && icon) {
        UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        cs_applyMenuItemIcon(menuItem, icon, tintColor);
    }
    
    @try {
        [menuItem setValue:@(0) forKey:@"linePosition"];
    } @catch (NSException *e) {
        NSLog(@"[复读] 设置linePosition失败: %@", e);
    }
    
    @try {
        [menuItem setValue:@(0) forKey:@"menuType"];
    } @catch (NSException *e) {
        NSLog(@"[复读] 设置menuType失败: %@", e);
    }
    
    return menuItem;
}

static id cs_createVoiceForwardMenuItem(Class menuItemClass, id cell, SEL action) {
    if (!menuItemClass || !cell || !action) {
        return nil;
    }
    
    id menuItem = nil;
    NSString *title = @"语音转发";
    UIImage *icon = [UIImage systemImageNamed:@"arrowshape.turn.up.right"];
    
    if (icon && [menuItemClass instancesRespondToSelector:@selector(initWithTitle:icon:target:action:)]) {
        @try {
            menuItem = [[menuItemClass alloc] initWithTitle:title icon:icon target:cell action:action];
        } @catch (NSException *e) {
        }
    }
    
    if (!menuItem && [menuItemClass instancesRespondToSelector:@selector(initWithTitle:target:action:)]) {
        @try {
            menuItem = [[menuItemClass alloc] initWithTitle:title target:cell action:action];
        } @catch (NSException *e) {
        }
    }
    
    if (menuItem && icon) {
        UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        cs_applyMenuItemIcon(menuItem, icon, tintColor);
    }
    
    @try {
        [menuItem setValue:@(0) forKey:@"linePosition"];
    } @catch (NSException *e) {
        NSLog(@"[语音转发] 设置linePosition失败: %@", e);
    }
    
    @try {
        [menuItem setValue:@(0) forKey:@"menuType"];
    } @catch (NSException *e) {
        NSLog(@"[语音转发] 设置menuType失败: %@", e);
    }
    
    return menuItem;
}

static NSArray *cs_injectRepeatMenuItemIfNeeded(id cell, NSArray *items) {
    if (!cs_isRepeatSupportedForCell(cell)) {
        return items;
    }
    
    Class menuItemClass = NSClassFromString(@"MMMenuItem");
    if (!menuItemClass) {
        return items;
    }
    
    SEL action = @selector(cs_handleRepeatMenuItem:);
    NSMutableArray *mutableItems = items ? [items mutableCopy] : [NSMutableArray array];
    
    for (id item in mutableItems) {
        if (![item isKindOfClass:menuItemClass] || ![item respondsToSelector:@selector(action)]) {
            continue;
        }
        @try {
            SEL itemAction = [item action];
            if (itemAction == action) {
                return mutableItems;
            }
        } @catch (NSException *e) {
        }
    }
    
    id menuItem = cs_createRepeatMenuItem(menuItemClass, cell, action);
    if (menuItem) {
        [mutableItems addObject:menuItem];
    }
    
    return mutableItems;
}

static NSArray *cs_injectVoiceForwardMenuItem(id cell, NSArray *items) {
    if (!cs_isVoiceForwardEnabled()) {
        return items;
    }
    
    id msgWrap = cs_messageWrapFromCell(cell);
    if (!cs_isVoiceMessage(msgWrap)) {
        return items;
    }
    
    Class menuItemClass = objc_getClass("MMMenuItem");
    if (!menuItemClass) {
        return items;
    }
    
    SEL bridgeAction = @selector(cs_handleVoiceForwardMenuItem:);
    NSMutableArray *mutableItems = items ? [items mutableCopy] : [NSMutableArray array];
    
    
    for (id item in mutableItems) {
        if (![item isKindOfClass:menuItemClass] || ![item respondsToSelector:@selector(action)]) continue;
        @try {
            SEL itemAction = [item action];
            if (itemAction == bridgeAction) {
                return mutableItems;
            }
        } @catch (NSException *e) {}
    }
    
    id menuItem = cs_createVoiceForwardMenuItem(menuItemClass, cell, bridgeAction);
    if (menuItem) {
        [mutableItems addObject:menuItem];
    } else {
    }
    
    return mutableItems;
}

%hook CommonMessageCellView

- (id)operationMenuItems {
    NSArray *items = %orig;
    return cs_injectRepeatMenuItemIfNeeded(self, items);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(cs_handleRepeatMenuItem:)) {
        return cs_isRepeatSupportedForCell(self);
    }
    return %orig;
}

%new
- (void)cs_handleRepeatMenuItem:(id)sender {
    cs_performRepeatMessage(self);
}

%end

%hook TextMessageCellView

- (id)operationMenuItems {
    NSArray *items = %orig;
    return cs_injectRepeatMenuItemIfNeeded(self, items);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(cs_handleRepeatMenuItem:)) {
        return cs_isRepeatSupportedForCell(self);
    }
    return %orig;
}

%new
- (void)cs_handleRepeatMenuItem:(id)sender {
    cs_performRepeatMessage(self);
}

%end

%hook ImageMessageCellView

- (id)operationMenuItems {
    NSArray *items = %orig;
    return cs_injectRepeatMenuItemIfNeeded(self, items);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(cs_handleRepeatMenuItem:)) {
        return cs_isRepeatSupportedForCell(self);
    }
    return %orig;
}

%new
- (void)cs_handleRepeatMenuItem:(id)sender {
    cs_performRepeatMessage(self);
}

%end

%hook EmoticonMessageCellView

- (id)operationMenuItems {
    NSArray *items = %orig;
    return cs_injectRepeatMenuItemIfNeeded(self, items);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(cs_handleRepeatMenuItem:)) {
        return cs_isRepeatSupportedForCell(self);
    }
    return %orig;
}

%new
- (void)cs_handleRepeatMenuItem:(id)sender {
    cs_performRepeatMessage(self);
}

%end

%hook VideoMessageCellView

- (id)operationMenuItems {
    NSArray *items = %orig;
    return cs_injectRepeatMenuItemIfNeeded(self, items);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(cs_handleRepeatMenuItem:)) {
        return cs_isRepeatSupportedForCell(self);
    }
    return %orig;
}

%new
- (void)cs_handleRepeatMenuItem:(id)sender {
    cs_performRepeatMessage(self);
}

%end

%hook VoiceMessageCellView

- (id)operationMenuItems {
    NSArray *items = %orig;
    
    items = cs_injectVoiceForwardMenuItem(self, items);
    items = cs_injectRepeatMenuItemIfNeeded(self, items);
    
    NSInteger index = 0;
    for (id item in items) {
        NSString *className = NSStringFromClass([item class]);
        
        NSString *title = @"no title";
        NSString *actionStr = @"no action";
        @try {
            if ([item respondsToSelector:@selector(title)]) {
                id titleObj = [item title];
                title = titleObj ? [NSString stringWithFormat:@"%@", titleObj] : @"(nil)";
            } else {
            }
            
            if ([item respondsToSelector:@selector(action)]) {
                SEL action = [item action];
                actionStr = action ? NSStringFromSelector(action) : @"(nil)";
            } else {
            }
        } @catch (NSException *e) {
        }
        index++;
    }
    
    return items;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(cs_handleRepeatMenuItem:)) {
        return cs_isRepeatSupportedForCell(self);
    }
    if (action == @selector(cs_handleVoiceForwardMenuItem:)) {
        return cs_isVoiceForwardEnabled() && cs_isVoiceMessage(cs_messageWrapFromCell(self));
    }
    return %orig;
}

%new
- (void)cs_handleRepeatMenuItem:(id)sender {
    cs_performRepeatMessage(self);
}

%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender {
    id msgWrap = cs_messageWrapFromCell(self);
    if (!cs_isVoiceMessage(msgWrap)) {
        return;
    }
    
    cs_startDownloadVoiceIfNeeded(msgWrap);
    
    SEL onForwardSelector = @selector(onForward:);
    id selfId = self;
    if ([selfId respondsToSelector:onForwardSelector]) {
        ((void (*)(id, SEL, id))objc_msgSend)(selfId, onForwardSelector, sender);
    }
}

%end

%hook MMMenuController

- (void)setMenuItems:(id)items {
    
    NSMutableArray *mutableItems = [items mutableCopy];
    
    BOOL hasRepeatMenuItem = NO;
    BOOL hasVoiceForwardMenuItem = NO;
    id voiceForwardMenuItem = nil;
    
    for (id item in mutableItems) {
        @try {
            if ([item respondsToSelector:@selector(action)]) {
                SEL action = [item action];
                if (action == @selector(cs_handleRepeatMenuItem:)) {
                    hasRepeatMenuItem = YES;
                }
                if (action == @selector(cs_handleVoiceForwardMenuItem:)) {
                    hasVoiceForwardMenuItem = YES;
                    voiceForwardMenuItem = item;
                }
            }
        } @catch (NSException *e) {
            NSLog(@"[MMMenuController] 检查菜单项失败: %@", e);
        }
    }
    
    
    if (!hasRepeatMenuItem && hasVoiceForwardMenuItem && voiceForwardMenuItem) {
        
        Class menuItemClass = NSClassFromString(@"MMMenuItem");
        if (menuItemClass) {
            id target = nil;
            @try {
                if ([voiceForwardMenuItem respondsToSelector:@selector(target)]) {
                    target = [voiceForwardMenuItem target];
                }
            } @catch (NSException *e) {
                NSLog(@"[MMMenuController] 获取target失败: %@", e);
            }
            
            if (target) {
                SEL repeatAction = @selector(cs_handleRepeatMenuItem:);
                if ([target respondsToSelector:repeatAction]) {
                    id repeatMenuItem = cs_createRepeatMenuItem(menuItemClass, target, repeatAction);
                    if (repeatMenuItem) {
                        [mutableItems addObject:repeatMenuItem];
                    }
                }
            }
        }
    }
    
    NSInteger index = 0;
    for (id item in mutableItems) {
        NSString *title = @"no title";
        NSString *actionStr = @"no action";
        @try {
            if ([item respondsToSelector:@selector(title)]) {
                id titleObj = [item title];
                title = titleObj ? [NSString stringWithFormat:@"%@", titleObj] : @"(nil)";
            }
            if ([item respondsToSelector:@selector(action)]) {
                SEL action = [item action];
                actionStr = action ? NSStringFromSelector(action) : @"(nil)";
            }
        } @catch (NSException *e) {
            NSLog(@"[MMMenuController] 获取菜单项属性失败: %@", e);
        }
        index++;
    }
    
    %orig(mutableItems);
}

%end

static void cs_repeatSettingsChangedCallback(CFNotificationCenterRef center, void *observer, CFNotificationName name, const void *object, CFDictionaryRef userInfo) {
}

%ctor {
    
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        cs_repeatSettingsChangedCallback,
        CFSTR("com.wechat.enhance.repeat.settings_changed"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
}
