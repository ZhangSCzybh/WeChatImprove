// 消息手势Hook
// 实现聊天消息左滑右滑引用功能

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "../Headers/WCHeaders.h"
#import "../HeadersFile/CommonMessageCellView.h"
#import "../Controllers/WCPLMessagePersistenceAdapter.h"

// These methods are installed by the Logos hook below and called before their definitions.
@interface CommonMessageCellView (WCMessageGestureActions)
- (void)wchook_performDeleteMessage;
- (void)wchook_performForwardMessage;
- (void)wchook_performFavoriteMessage;
- (void)wchook_performRevokeMessage;
- (void)wchook_performRepeatMessage;
@end

static NSString * const kMessageGestureEnabledKey = @"com.wechat.enhance.message_gesture.enabled";
static NSString * const kLeftSwipeOtherActionKey = @"com.wechat.enhance.left_swipe_other.action";
static NSString * const kLeftSwipeSelfActionKey = @"com.wechat.enhance.left_swipe_self.action";
static NSString * const kRightSwipeOtherActionKey = @"com.wechat.enhance.right_swipe_other.action";
static NSString * const kRightSwipeSelfActionKey = @"com.wechat.enhance.right_swipe_self.action";

typedef NS_ENUM(NSInteger, WCSwipeAction) {
    WCSwipeActionDisabled = 0,
    WCSwipeActionQuote = 1,
    WCSwipeActionDelete = 2,
    WCSwipeActionForward = 3,
    WCSwipeActionFavorite = 4,
    WCSwipeActionRevoke = 5,
    WCSwipeActionRepeat = 6
};

static const void *kWCHookSwipeGestureKey = &kWCHookSwipeGestureKey;
static const void *kWCHookFeedbackGeneratorKey = &kWCHookFeedbackGeneratorKey;
static const void *kWCHookFeedbackTriggeredKey = &kWCHookFeedbackTriggeredKey;
static const void *kWCHookSwipeTriggerStageKey = &kWCHookSwipeTriggerStageKey;

static BOOL isMessageGestureEnabled() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kMessageGestureEnabledKey];
}

static WCSwipeAction getSwipeAction(NSString *key) {
    NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    return (WCSwipeAction)value;
}

static WCSwipeAction getActionForDirection(WCHookSwipeDirection direction, BOOL isSelf) {
    if (direction == WCHookSwipeDirectionLeft) {
        return isSelf ? getSwipeAction(kLeftSwipeSelfActionKey) : getSwipeAction(kLeftSwipeOtherActionKey);
    } else if (direction == WCHookSwipeDirectionRight) {
        return isSelf ? getSwipeAction(kRightSwipeSelfActionKey) : getSwipeAction(kRightSwipeOtherActionKey);
    }
    return WCSwipeActionDisabled;
}

static BOOL wchook_isMessageFromOther(CMessageWrap *msgWrap) {
    if (!msgWrap) {
        return NO;
    }

    BOOL isSender = NO;
    BOOL shouldFallback = YES;

    @try {
        Class msgWrapClass = NSClassFromString(@"CMessageWrap");
        SEL selector = @selector(isSenderFromMsgWrap:);
        if (msgWrapClass && [msgWrapClass respondsToSelector:selector]) {
            isSender = ((BOOL (*)(id, SEL, id))objc_msgSend)(msgWrapClass, selector, msgWrap);
            shouldFallback = !isSender;
        }
    } @catch (NSException *e) {
        NSLog(@"[消息手势] isSenderFromMsgWrap 异常: %@", e);
    }

    if (shouldFallback) {
        @try {
            if (msgWrap.m_uiIsSenderStatus > 0) {
                isSender = YES;
                shouldFallback = NO;
            }
        } @catch (NSException *e) {
            NSLog(@"[消息手势] m_uiIsSenderStatus 异常: %@", e);
        }

        if (shouldFallback) {
            @try {
                id fromMeValue = [msgWrap valueForKey:@"m_bFromMe"];
                if ([fromMeValue respondsToSelector:@selector(boolValue)]) {
                    isSender = [fromMeValue boolValue];
                }
            } @catch (NSException *e) {
                NSLog(@"[消息手势] m_bFromMe 异常: %@", e);
            }
        }
    }

    return !isSender;
}

static NSString *wchook_extractXMLValue(NSString *content, NSString *startTag, NSString *endTag) {
    if (!content || !startTag || !endTag) {
        return nil;
    }
    
    NSRange startRange = [content rangeOfString:startTag];
    if (startRange.location == NSNotFound) {
        return nil;
    }
    
    NSUInteger startLocation = startRange.location + startRange.length;
    NSRange endRange = [content rangeOfString:endTag options:0 range:NSMakeRange(startLocation, content.length - startLocation)];
    if (endRange.location == NSNotFound) {
        return nil;
    }
    
    return [content substringWithRange:NSMakeRange(startLocation, endRange.location - startLocation)];
}

static NSString *wchook_emoticonMD5FromMessageWrap(CMessageWrap *msgWrap) {
    if (!msgWrap) {
        return nil;
    }
    
    NSString *md5 = msgWrap.m_nsEmoticonMD5;
    if (md5.length == 32) {
        return md5;
    }
    
    NSString *content = msgWrap.m_nsContent;
    if (![content isKindOfClass:[NSString class]] || content.length == 0) {
        return nil;
    }
    
    NSArray<NSString *> *patterns = @[
        @"<md5><![CDATA[",
        @"<md5>",
        @"md5=\""
    ];
    
    for (NSString *start in patterns) {
        NSString *end = [start isEqualToString:@"md5=\""] ? @"\"" : ([start isEqualToString:@"<md5>"] ? @"</md5>" : @"]]></md5>");
        NSString *value = wchook_extractXMLValue(content, start, end);
        if (value.length == 32) {
            return value;
        }
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-fA-F0-9]{32}" options:0 error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:content options:0 range:NSMakeRange(0, content.length)];
    if (!match || match.range.location == NSNotFound) {
        return nil;
    }
    return [content substringWithRange:match.range];
}

static id wchook_resolveEmoticonWrap(CMessageWrap *msgWrap, NSString *emoticonMD5) {
    id emoticonManager = nil;
    
    Class mmContextClass = NSClassFromString(@"MMContext");
    if (mmContextClass) {
        SEL currentContextSelector = NSSelectorFromString(@"currentContext");
        if ([mmContextClass respondsToSelector:currentContextSelector]) {
            id mmContext = [mmContextClass performSelector:currentContextSelector];
            if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                Class emoticonMgrClass = NSClassFromString(@"CEmoticonMgr");
                emoticonManager = [mmContext performSelector:@selector(getService:) withObject:emoticonMgrClass];
            }
        }
    }
    
    if (!emoticonManager) {
        Class mmServiceCenterClass = NSClassFromString(@"MMServiceCenter");
        if (mmServiceCenterClass) {
            SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
            if ([mmServiceCenterClass respondsToSelector:defaultCenterSelector]) {
                id serviceCenter = [mmServiceCenterClass performSelector:defaultCenterSelector];
                if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                    Class emoticonMgrClass = NSClassFromString(@"CEmoticonMgr");
                    emoticonManager = [serviceCenter performSelector:@selector(getService:) withObject:emoticonMgrClass];
                }
            }
        }
    }
    
    if (!emoticonManager) {
        NSLog(@"[消息手势] 无法获取 CEmoticonMgr");
        return nil;
    }
    
    id emoticonWrap = nil;
    NSString *md5 = emoticonMD5.length == 32 ? emoticonMD5 : nil;
    
    if (md5.length == 32) {
        SEL getEmoticonByMd5Selector = NSSelectorFromString(@"getEmoticonWrapByMd5:");
        if ([emoticonManager respondsToSelector:getEmoticonByMd5Selector]) {
            @try {
                NSMethodSignature *signature = [emoticonManager methodSignatureForSelector:getEmoticonByMd5Selector];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                [invocation setTarget:emoticonManager];
                [invocation setSelector:getEmoticonByMd5Selector];
                [invocation setArgument:&md5 atIndex:2];
                [invocation invoke];
                id result = nil;
                [invocation getReturnValue:&result];
                emoticonWrap = result;
            } @catch (NSException *e) {
                NSLog(@"[消息手势] getEmoticonWrapByMd5: 失败: %@", e);
            }
        }
    }
    
    if (!emoticonWrap) {
        SEL getEmoticonByMsgSelector = NSSelectorFromString(@"getEmoticonWrapByMessageWrap:");
        if ([emoticonManager respondsToSelector:getEmoticonByMsgSelector]) {
            @try {
                NSMethodSignature *signature = [emoticonManager methodSignatureForSelector:getEmoticonByMsgSelector];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                [invocation setTarget:emoticonManager];
                [invocation setSelector:getEmoticonByMsgSelector];
                [invocation setArgument:&msgWrap atIndex:2];
                [invocation invoke];
                id result = nil;
                [invocation getReturnValue:&result];
                emoticonWrap = result;
            } @catch (NSException *e) {
                NSLog(@"[消息手势] getEmoticonWrapByMessageWrap: 失败: %@", e);
            }
        }
    }
    
    if (!emoticonWrap) {
        NSString *content = msgWrap.m_nsContent;
        SEL getEmoticonByContentSelector = NSSelectorFromString(@"getEmoticonWrapByContent:");
        if ([emoticonManager respondsToSelector:getEmoticonByContentSelector]) {
            @try {
                NSMethodSignature *signature = [emoticonManager methodSignatureForSelector:getEmoticonByContentSelector];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                [invocation setTarget:emoticonManager];
                [invocation setSelector:getEmoticonByContentSelector];
                [invocation setArgument:&content atIndex:2];
                [invocation invoke];
                id result = nil;
                [invocation getReturnValue:&result];
                emoticonWrap = result;
            } @catch (NSException *e) {
                NSLog(@"[消息手势] getEmoticonWrapByContent: 失败: %@", e);
            }
        }
    }
    
    return emoticonWrap;
}

static BOOL wchook_sendEmoticonViaLogicController(id emoticonWrap, id logicController, BaseMsgContentViewController *chatVC) {
    if (!emoticonWrap) {
        return NO;
    }
    
    SEL sendEmoticonSelector = NSSelectorFromString(@"SendEmoticonMessage:");
    if (logicController && [logicController respondsToSelector:sendEmoticonSelector]) {
        @try {
            NSMethodSignature *signature = [logicController methodSignatureForSelector:sendEmoticonSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:logicController];
            [invocation setSelector:sendEmoticonSelector];
            [invocation setArgument:&emoticonWrap atIndex:2];
            [invocation invoke];
            return YES;
        } @catch (NSException *e) {
            NSLog(@"[消息手势] logicController.SendEmoticonMessage: 失败: %@", e);
        }
    }
    
    SEL sendEmoticonToolSelector = NSSelectorFromString(@"SendEmoticonMesssageToolView:");
    if (chatVC && [chatVC respondsToSelector:sendEmoticonToolSelector]) {
        @try {
            NSMethodSignature *signature = [chatVC methodSignatureForSelector:sendEmoticonToolSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:chatVC];
            [invocation setSelector:sendEmoticonToolSelector];
            [invocation setArgument:&emoticonWrap atIndex:2];
            [invocation invoke];
            return YES;
        } @catch (NSException *e) {
            NSLog(@"[消息手势] chatVC.SendEmoticonMesssageToolView: 失败: %@", e);
        }
    }
    
    return NO;
}

static BaseMsgContentViewController *wchook_findChatViewController(id view) {
    if (!view) return nil;
    
    Class chatVCClass = NSClassFromString(@"BaseMsgContentViewController");
    if (!chatVCClass) return nil;
    
    @try {
        UIResponder *responder = nil;
        
        if ([view isKindOfClass:[UIResponder class]]) {
            responder = (UIResponder *)view;
        } else if ([view respondsToSelector:@selector(nextResponder)]) {
            responder = [view nextResponder];
        }
        
        while (responder) {
            if ([responder isKindOfClass:chatVCClass]) {
                return (BaseMsgContentViewController *)responder;
            }
            
            if (![responder respondsToSelector:@selector(nextResponder)]) {
                break;
            }
            
            responder = [responder nextResponder];
        }
    } @catch (NSException *e) {
        NSLog(@"[消息手势] wchook_findChatViewController异常: %@", e);
    }
    
    return nil;
}

%hook CommonMessageCellView

%new
- (UIPanGestureRecognizer *)wchook_swipeGesture {
    return objc_getAssociatedObject(self, kWCHookSwipeGestureKey);
}

%new
- (void)setWchook_swipeGesture:(UIPanGestureRecognizer *)gesture {
    objc_setAssociatedObject(self, kWCHookSwipeGestureKey, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%new
- (UIImpactFeedbackGenerator *)wchook_feedbackGenerator {
    return objc_getAssociatedObject(self, kWCHookFeedbackGeneratorKey);
}

%new
- (void)setWchook_feedbackGenerator:(UIImpactFeedbackGenerator *)generator {
    objc_setAssociatedObject(self, kWCHookFeedbackGeneratorKey, generator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%new
- (BOOL)wchook_feedbackTriggered {
    return [objc_getAssociatedObject(self, kWCHookFeedbackTriggeredKey) boolValue];
}

%new
- (void)setWchook_feedbackTriggered:(BOOL)triggered {
    objc_setAssociatedObject(self, kWCHookFeedbackTriggeredKey, @(triggered), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%new
- (NSInteger)wchook_swipeTriggerStage {
    return [objc_getAssociatedObject(self, kWCHookSwipeTriggerStageKey) integerValue];
}

%new
- (void)setWchook_swipeTriggerStage:(NSInteger)stage {
    objc_setAssociatedObject(self, kWCHookSwipeTriggerStageKey, @(stage), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%new
- (void)wchook_setupSwipeGestureIfNeeded {
    if (!isMessageGestureEnabled()) {
        if (self.wchook_swipeGesture) {
            self.wchook_swipeGesture.enabled = NO;
        }
        return;
    }
    
    BOOL hasAnySwipeEnabled = (getSwipeAction(kLeftSwipeOtherActionKey) != WCSwipeActionDisabled ||
                                getSwipeAction(kLeftSwipeSelfActionKey) != WCSwipeActionDisabled ||
                                getSwipeAction(kRightSwipeOtherActionKey) != WCSwipeActionDisabled ||
                                getSwipeAction(kRightSwipeSelfActionKey) != WCSwipeActionDisabled);
    if (!hasAnySwipeEnabled) {
        if (self.wchook_swipeGesture) {
            self.wchook_swipeGesture.enabled = NO;
        }
        return;
    }
    
    UIPanGestureRecognizer *gesture = self.wchook_swipeGesture;
    if (!gesture) {
        gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wchook_handleSwipe:)];
        gesture.maximumNumberOfTouches = 1;
        gesture.minimumNumberOfTouches = 1;
        gesture.cancelsTouchesInView = YES;
        gesture.delaysTouchesBegan = NO;
        gesture.delaysTouchesEnded = NO;
        gesture.delegate = (id<UIGestureRecognizerDelegate>)self;
        [self addGestureRecognizer:gesture];
        self.wchook_swipeGesture = gesture;
    }
    
    gesture.cancelsTouchesInView = YES;
    gesture.delaysTouchesBegan = NO;
    gesture.delaysTouchesEnded = NO;
    gesture.enabled = YES;
    
    if (!self.wchook_feedbackGenerator) {
        self.wchook_feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    }
}

%new
- (void)wchook_handleSwipe:(UIPanGestureRecognizer *)gesture {
    @try {
        if (!gesture || !isMessageGestureEnabled()) {
            [self wchook_resetSwipeAnimated:YES];
            return;
        }
        
        BOOL hasAnySwipeEnabled = (getSwipeAction(kLeftSwipeOtherActionKey) != WCSwipeActionDisabled ||
                                    getSwipeAction(kLeftSwipeSelfActionKey) != WCSwipeActionDisabled ||
                                    getSwipeAction(kRightSwipeOtherActionKey) != WCSwipeActionDisabled ||
                                    getSwipeAction(kRightSwipeSelfActionKey) != WCSwipeActionDisabled);
        if (!hasAnySwipeEnabled) {
            [self wchook_resetSwipeAnimated:YES];
            return;
        }
        
        CGPoint translation = [gesture translationInView:self];
        CGPoint velocity = [gesture velocityInView:self];
        
        WCHookSwipeDirection direction = WCHookSwipeDirectionNone;
        if (fabs(translation.x) >= fabs(translation.y) * 1.5f) {
            direction = translation.x < 0 ? WCHookSwipeDirectionLeft : WCHookSwipeDirectionRight;
        }
        
        if (direction == WCHookSwipeDirectionNone) {
            if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
                [self wchook_resetSwipeAnimated:YES];
            }
            return;
        }
        
        CGFloat threshold = CGRectGetWidth(self.bounds) * 0.2f;
        if (threshold < 60.0f) threshold = 60.0f;
        
        switch (gesture.state) {
            case UIGestureRecognizerStateBegan: {
                self.wchook_feedbackTriggered = NO;
                self.wchook_swipeTriggerStage = 0;
                [self.wchook_feedbackGenerator prepare];
                break;
            }
                
            case UIGestureRecognizerStateChanged: {
                CGFloat clamped = translation.x;
                if (translation.x < -threshold) {
                    clamped = -threshold;
                } else if (translation.x > threshold) {
                    clamped = threshold;
                }
                
                CGAffineTransform transform = CGAffineTransformMakeTranslation(clamped, 0);
                self.transform = transform;
                
                CGFloat progress = fabs(clamped) / threshold;
                NSInteger newStage = (NSInteger)(progress * 3);
                
                if (newStage != self.wchook_swipeTriggerStage) {
                    self.wchook_swipeTriggerStage = newStage;
                    if (newStage >= 2 && !self.wchook_feedbackTriggered) {
                        [self.wchook_feedbackGenerator impactOccurred];
                        self.wchook_feedbackTriggered = YES;
                    }
                }
                break;
            }
                
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled: {
                CGFloat absTranslation = fabs(translation.x);
                CGFloat absVelocity = fabs(velocity.x);
                
                
                BOOL shouldTrigger = (absTranslation >= threshold) || (absVelocity >= 600.0f);
                
                if (shouldTrigger) {
                    [self wchook_triggerActionForDirection:direction];
                }
                
                [self wchook_resetSwipeAnimated:YES];
                break;
            }
                
            default:
                break;
        }
    } @catch (NSException *e) {
        NSLog(@"[消息手势] handleSwipe异常: %@", e);
        NSLog(@"[消息手势] 异常调用栈: %@", e.callStackSymbols);
        [self wchook_resetSwipeAnimated:YES];
    }
}

%new
- (void)wchook_resetSwipeAnimated:(BOOL)animated {
    void (^resetBlock)(void) = ^{
        self.transform = CGAffineTransformIdentity;
    };
    
    if (animated) {
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:resetBlock completion:nil];
    } else {
        resetBlock();
    }
    
    self.wchook_feedbackTriggered = NO;
    self.wchook_swipeTriggerStage = 0;
}

%new
- (void)wchook_triggerActionForDirection:(WCHookSwipeDirection)direction {
    
    @try {
        CMessageWrap *msgWrap = nil;
        
        if ([self respondsToSelector:@selector(getCurrentMessageWrap)]) {
            msgWrap = [self getCurrentMessageWrap];
        } else if ([self respondsToSelector:@selector(viewModel)]) {
            id viewModel = [self viewModel];
            
            if (viewModel && [viewModel respondsToSelector:@selector(messageWrap)]) {
                msgWrap = [viewModel messageWrap];
            }
        }
        
        if (!msgWrap) {
            NSLog(@"[消息手势] 无法获取消息，跳过操作");
            return;
        }
        
        
        BOOL isSelfMessage = NO;
        @try {
            Class msgWrapClass = NSClassFromString(@"CMessageWrap");
            if (msgWrapClass && [msgWrapClass respondsToSelector:@selector(isSenderFromMsgWrap:)]) {
                isSelfMessage = [msgWrapClass isSenderFromMsgWrap:msgWrap];
            } else {
                unsigned int senderStatus = msgWrap.m_uiIsSenderStatus;
                isSelfMessage = (senderStatus == 1);
            }
        } @catch (NSException *e) {
            NSLog(@"[消息手势] 获取isSender异常: %@", e);
        }
        
        WCSwipeAction action = getActionForDirection(direction, isSelfMessage);
        if (action == WCSwipeActionDisabled) {
            return;
        }
        
        if (action == WCSwipeActionQuote) {
            [self wchook_performQuoteReply];
        } else if (action == WCSwipeActionDelete) {
            [self wchook_performDeleteMessage];
        } else if (action == WCSwipeActionForward) {
            [self wchook_performForwardMessage];
        } else if (action == WCSwipeActionFavorite) {
            [self wchook_performFavoriteMessage];
        } else if (action == WCSwipeActionRevoke) {
            [self wchook_performRevokeMessage];
        } else if (action == WCSwipeActionRepeat) {
            [self wchook_performRepeatMessage];
        }
    } @catch (NSException *e) {
        NSLog(@"[消息手势] triggerActionForDirection异常: %@", e);
        NSLog(@"[消息手势] 异常调用栈: %@", e.callStackSymbols);
    }
}

%new
- (void)wchook_performQuoteReply {
    @try {
        CMessageWrap *msgWrap = nil;
        
        if ([self respondsToSelector:@selector(getCurrentMessageWrap)]) {
            msgWrap = [self getCurrentMessageWrap];
        } else if ([self respondsToSelector:@selector(viewModel)]) {
            id viewModel = [self viewModel];
            
            if (viewModel && [viewModel respondsToSelector:@selector(messageWrap)]) {
                msgWrap = [viewModel messageWrap];
            }
        }
        
        if (!msgWrap) {
            NSLog(@"[消息手势] 无法获取消息");
            return;
        }
        
        unsigned int msgType = msgWrap.m_uiMessageType;
        
        if (msgType == 10000) {
            return;
        }
        
        if (msgType == 10002) {
            return;
        }
        
        BaseMsgContentViewController *chatVC = wchook_findChatViewController(self);
        if (!chatVC) {
            NSLog(@"[消息手势] 无法找到聊天控制器");
        } else {
        }
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        SEL hideMenuSelector = NSSelectorFromString(@"hideMenuFromView:");
        if ([menuController respondsToSelector:hideMenuSelector]) {
            NSMethodSignature *signature = [menuController methodSignatureForSelector:hideMenuSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:menuController];
            [invocation setSelector:hideMenuSelector];
            UIView *selfView = self;
            [invocation setArgument:&selfView atIndex:2];
            [invocation invoke];
        }
        
        if (chatVC) {
            BOOL responds = [chatVC respondsToSelector:@selector(startReplyWithMessageWrap:)];
            
            if (responds) {
                @try {
                    void (*msgSend)(id, SEL, id) = (void (*)(id, SEL, id))objc_msgSend;
                    msgSend(chatVC, @selector(startReplyWithMessageWrap:), msgWrap);
                    return;
                } @catch (NSException *innerException) {
                    NSLog(@"[消息手势] startReplyWithMessageWrap调用失败: %@", innerException);
                }
            }
            
            SEL inputPresenterSelector = @selector(inputPresenter);
            if ([chatVC respondsToSelector:inputPresenterSelector]) {
                id inputPresenter = [chatVC performSelector:inputPresenterSelector];
                
                if (inputPresenter) {
                    SEL replySelector = @selector(replyMessage:becomeFirstResponder:showDisplayName:);
                    if ([inputPresenter respondsToSelector:replySelector]) {
                        @try {
                            ((void (*)(id, SEL, id, BOOL, BOOL))objc_msgSend)(inputPresenter,
                                                                               replySelector,
                                                                               msgWrap,
                                                                               YES,
                                                                               YES);
                            return;
                        } @catch (NSException *exception) {
                            NSLog(@"[消息手势] inputPresenter.replyMessage失败: %@", exception);
                        }
                    }
                }
            }
        }
        
        BOOL selfResponds = [self respondsToSelector:@selector(onClickAsRefer)];
        
        if (selfResponds) {
            @try {
                [self performSelector:@selector(onClickAsRefer)];
                return;
            } @catch (NSException *onClickException) {
                NSLog(@"[消息手势] onClickAsRefer调用失败: %@", onClickException);
            }
        }
        
    } @catch (NSException *e) {
        NSLog(@"[消息手势] 引用异常: %@", e);
        NSLog(@"[消息手势] 异常调用栈: %@", e.callStackSymbols);
    }
}

%new
- (void)wchook_performDeleteMessage {
    @try {
        CMessageWrap *msgWrap = nil;
        
        if ([self respondsToSelector:@selector(getCurrentMessageWrap)]) {
            msgWrap = [self getCurrentMessageWrap];
        } else if ([self respondsToSelector:@selector(viewModel)]) {
            id viewModel = [self viewModel];
            
            if (viewModel && [viewModel respondsToSelector:@selector(messageWrap)]) {
                msgWrap = [viewModel messageWrap];
            }
        }
        
        if (!msgWrap) {
            NSLog(@"[消息手势] 无法获取消息，删除失败");
            return;
        }
        
        unsigned int msgType = msgWrap.m_uiMessageType;
        
        if (msgType == 10000) {
            return;
        }
        
        BaseMsgContentViewController *chatVC = wchook_findChatViewController(self);
        if (!chatVC) {
            NSLog(@"[消息手势] 无法找到聊天控制器");
            return;
        }
        
        __block CMessageWrap *blockMsgWrap = msgWrap;
        __block BaseMsgContentViewController *blockChatVC = chatVC;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除消息"
                                                                       message:@"确定要删除这条消息吗？"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除"
                                                               style:UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction * _Nonnull action) {
            @try {
                SEL deleteSelector = NSSelectorFromString(@"deleteNode:withDB:animated:");
                if ([blockChatVC respondsToSelector:deleteSelector]) {
                    NSMethodSignature *signature = [blockChatVC methodSignatureForSelector:deleteSelector];
                    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                    [invocation setTarget:blockChatVC];
                    [invocation setSelector:deleteSelector];
                    [invocation setArgument:&blockMsgWrap atIndex:2];
                    BOOL withDB = YES;
                    [invocation setArgument:&withDB atIndex:3];
                    BOOL animated = YES;
                    [invocation setArgument:&animated atIndex:4];
                    [invocation invoke];
                } else {
                }
            } @catch (NSException *e) {
                NSLog(@"[消息手势] 删除消息异常: %@", e);
            }
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:deleteAction];
        
        [chatVC presentViewController:alert animated:YES completion:nil];
    } @catch (NSException *e) {
        NSLog(@"[消息手势] 删除消息异常: %@", e);
        NSLog(@"[消息手势] 异常调用栈: %@", e.callStackSymbols);
    }
}

%new
- (void)wchook_performForwardMessage {
    @try {
        
        if ([self respondsToSelector:@selector(onForward:)]) {
            [self performSelector:@selector(onForward:) withObject:nil];
        } else {
        }
    } @catch (NSException *e) {
        NSLog(@"[消息手势] 转发消息异常: %@", e);
        NSLog(@"[消息手势] 异常调用栈: %@", e.callStackSymbols);
    }
}

%new
- (void)wchook_performFavoriteMessage {
    @try {
        
        if ([self respondsToSelector:@selector(doFavorite)]) {
            [self performSelector:@selector(doFavorite)];
        } else {
        }
    } @catch (NSException *e) {
        NSLog(@"[消息手势] 收藏消息异常: %@", e);
        NSLog(@"[消息手势] 异常调用栈: %@", e.callStackSymbols);
    }
}

%new
- (void)wchook_performRevokeMessage {
    @try {
        
        CMessageWrap *msgWrap = nil;
        
        if ([self respondsToSelector:@selector(getCurrentMessageWrap)]) {
            msgWrap = [self getCurrentMessageWrap];
        } else if ([self respondsToSelector:@selector(viewModel)]) {
            id viewModel = [self viewModel];
            
            if (viewModel && [viewModel respondsToSelector:@selector(messageWrap)]) {
                msgWrap = [viewModel messageWrap];
            }
        }
        
        if (!msgWrap) {
            NSLog(@"[消息手势] 撤回失败: 未找到消息包装对象");
            return;
        }
        
        BaseMsgContentViewController *chatVC = wchook_findChatViewController(self);
        if (!chatVC) {
            NSLog(@"[消息手势] 撤回失败: 未找到聊天视图控制器");
            return;
        }
        
        // 检查消息是否可以撤回
        if ([chatVC respondsToSelector:@selector(isMsgCanRevoke:)]) {
            BOOL canRevoke = [chatVC performSelector:@selector(isMsgCanRevoke:) withObject:msgWrap];
            if (!canRevoke) {
                NSLog(@"[消息手势] 撤回失败: 消息不可撤回（可能超过2分钟）");
                return;
            }
        }
        
        // 显示二次确认对话框
        UIViewController *presentingVC = chatVC;
        while (presentingVC.presentedViewController) {
            presentingVC = presentingVC.presentedViewController;
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"撤回消息"
                                                                       message:@"确定要撤回这条消息吗？"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(msgWrap) weakMsgWrap = msgWrap;
        __weak typeof(chatVC) weakChatVC = chatVC;
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"撤回"
                                                                style:UIAlertActionStyleDestructive
                                                              handler:^(UIAlertAction * _Nonnull action) {
            @try {
                if (weakMsgWrap && weakChatVC && [weakChatVC respondsToSelector:@selector(revokeMsgByNodeView:)]) {
                    [weakChatVC performSelector:@selector(revokeMsgByNodeView:) withObject:weakMsgWrap];
                }
            } @catch (NSException *e) {
                NSLog(@"[消息手势] 撤回消息异常: %@", e);
            }
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        
        [alert addAction:cancelAction];
        [alert addAction:confirmAction];
        
        [presentingVC presentViewController:alert animated:YES completion:nil];
    } @catch (NSException *e) {
        NSLog(@"[消息手势] 撤回消息异常: %@", e);
        NSLog(@"[消息手势] 异常调用栈: %@", e.callStackSymbols);
    }
}

%new
- (void)wchook_performRepeatMessage {
    @try {
        
        CMessageWrap *msgWrap = nil;
        
        if ([self respondsToSelector:@selector(getCurrentMessageWrap)]) {
            msgWrap = [self getCurrentMessageWrap];
        } else if ([self respondsToSelector:@selector(viewModel)]) {
            id viewModel = [self viewModel];
            if (viewModel && [viewModel respondsToSelector:@selector(messageWrap)]) {
                msgWrap = [viewModel messageWrap];
            }
        }
        
        if (!msgWrap) {
            NSLog(@"[消息手势] 复读失败: 未找到消息包装对象");
            return;
        }
        
        BaseMsgContentViewController *chatVC = wchook_findChatViewController(self);
        if (!chatVC) {
            NSLog(@"[消息手势] 复读失败: 未找到聊天视图控制器");
            return;
        }
        
        // 获取逻辑控制器（先尝试 m_logicController 属性，再尝试 logicController 方法，最后从 MMMsgLogicManager 获取）
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
        
        // 如果还是获取不到，尝试从 MMMsgLogicManager 获取当前逻辑控制器
        if (!logicController) {
            
            // 尝试从服务中心获取 MMMsgLogicManager
            id logicManager = nil;
            
            // 方法1: 从 MMContext 获取
            Class mmContextClass = NSClassFromString(@"MMContext");
            if (mmContextClass) {
                SEL currentContextSelector = NSSelectorFromString(@"currentContext");
                if ([mmContextClass respondsToSelector:currentContextSelector]) {
                    id mmContext = [mmContextClass performSelector:currentContextSelector];
                    if (mmContext && [mmContext respondsToSelector:@selector(getService:)]) {
                        Class logicManagerClass = NSClassFromString(@"MMMsgLogicManager");
                        logicManager = [mmContext performSelector:@selector(getService:) withObject:logicManagerClass];
                    }
                }
            }
            
            // 方法2: 从 MMServiceCenter 获取
            if (!logicManager) {
                Class mmServiceCenterClass = NSClassFromString(@"MMServiceCenter");
                if (mmServiceCenterClass) {
                    SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                    if ([mmServiceCenterClass respondsToSelector:defaultCenterSelector]) {
                        id serviceCenter = [mmServiceCenterClass performSelector:defaultCenterSelector];
                        if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                            Class logicManagerClass = NSClassFromString(@"MMMsgLogicManager");
                            logicManager = [serviceCenter performSelector:@selector(getService:) withObject:logicManagerClass];
                        }
                    }
                }
            }
            
            // 方法3: 从 ServiceCenter 获取
            if (!logicManager) {
                Class serviceCenterClass = NSClassFromString(@"ServiceCenter");
                if (serviceCenterClass) {
                    SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                    if ([serviceCenterClass respondsToSelector:defaultCenterSelector]) {
                        id serviceCenter = [serviceCenterClass performSelector:defaultCenterSelector];
                        if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                            Class logicManagerClass = NSClassFromString(@"MMMsgLogicManager");
                            logicManager = [serviceCenter performSelector:@selector(getService:) withObject:logicManagerClass];
                        }
                    }
                }
            }
            
            if (logicManager) {
                SEL getCurrentLogicSelector = NSSelectorFromString(@"GetCurrentLogicController");
                if ([logicManager respondsToSelector:getCurrentLogicSelector]) {
                    logicController = [logicManager performSelector:getCurrentLogicSelector];
                }
            }
        }
        
        if (!logicController) {
            NSLog(@"[消息手势] 复读失败: 未找到逻辑控制器");
            return;
        }
        
        
        // 获取消息类型
        int msgType = 0;
        if ([msgWrap respondsToSelector:@selector(m_uiMessageType)]) {
            msgType = [msgWrap m_uiMessageType];
        }
        
        
        // 根据消息类型选择不同的复读方式
        if (msgType == 1) {
            // 文本消息：使用 SendTextMessage: 发送新消息
            NSString *msgContent = nil;
            if ([msgWrap respondsToSelector:@selector(m_nsContent)]) {
                msgContent = [msgWrap m_nsContent];
            }
            
            if (!msgContent || msgContent.length == 0) {
                NSLog(@"[消息手势] 复读失败: 文本消息内容为空");
                return;
            }
            
            
            // 尝试多种发送方式
            BOOL sent = NO;
            
            // 方式1: 通过 logicController 发送
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
                    NSLog(@"[消息手势] SendTextMessage: 失败: %@", e);
                }
            }
            
            // 方式2: 通过 SendTextMessage:externInfo: 发送
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
                        NSLog(@"[消息手势] SendTextMessage:externInfo: 失败: %@", e);
                    }
                }
            }
            
            // 方式3: 通过 chatVC 发送
            if (!sent && chatVC) {
                if ([chatVC respondsToSelector:sendTextSelector]) {
                    @try {
                        NSMethodSignature *signature = [chatVC methodSignatureForSelector:sendTextSelector];
                        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                        [invocation setTarget:chatVC];
                        [invocation setSelector:sendTextSelector];
                        [invocation setArgument:&msgContent atIndex:2];
                        [invocation invoke];
                        sent = YES;
                    } @catch (NSException *e) {
                        NSLog(@"[消息手势] chatVC.SendTextMessage: 失败: %@", e);
                    }
                }
            }
            
            if (!sent) {
                NSLog(@"[消息手势] 复读失败: 无法发送文本消息");
            }
        } else if (msgType == 34) {
            // 语音消息：使用语音转发功能
            
            // 获取当前聊天名称
            NSString *chatName = nil;
            BOOL isSender = NO;
            @try {
                Class msgWrapClass = NSClassFromString(@"CMessageWrap");
                if (msgWrapClass && [msgWrapClass respondsToSelector:@selector(isSenderFromMsgWrap:)]) {
                    isSender = [msgWrapClass isSenderFromMsgWrap:msgWrap];
                }
            } @catch (NSException *e) {
                NSLog(@"[消息手势] 获取isSender异常: %@", e);
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
                NSLog(@"[消息手势] 语音复读失败: 无法获取聊天名称");
                return;
            }
            
            // 获取 CContactMgr 并查找目标联系人
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
            
            if (!contactMgr) {
                Class serviceCenterClass = NSClassFromString(@"ServiceCenter");
                if (serviceCenterClass) {
                    SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                    if ([serviceCenterClass respondsToSelector:defaultCenterSelector]) {
                        id serviceCenter = [serviceCenterClass performSelector:defaultCenterSelector];
                        if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                            Class contactMgrClass = NSClassFromString(@"CContactMgr");
                            contactMgr = [serviceCenter performSelector:@selector(getService:) withObject:contactMgrClass];
                        }
                    }
                }
            }
            
            id targetContact = nil;
            SEL getContactSelector = NSSelectorFromString(@"getContactByName:");
            if (contactMgr && [contactMgr respondsToSelector:getContactSelector]) {
                @try {
                    targetContact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, getContactSelector, chatName);
                } @catch (NSException *e) {
                    NSLog(@"[消息手势] 获取联系人失败: %@", e);
                }
            }
            
            if (!targetContact) {
                NSLog(@"[消息手势] 语音复读失败: 无法获取目标联系人");
                return;
            }
            
            // 调用语音转发功能
            
            // 获取语音音频数据
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
                    NSLog(@"[消息手势] 获取音频路径失败: %@", e);
                }
            }
            
            if (!audioData || audioData.length == 0) {
                // 尝试下载语音
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
                        NSLog(@"[消息手势] 触发语音下载失败: %@", e);
                    }
                }
                return;
            }
            
            // 获取语音属性
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
            // 如果时长无效，从消息内容中解析 voicelength
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
            // 如果格式无效，从消息内容中解析 voiceformat
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
            
            
            // 获取当前用户名
            NSString *selfUserName = nil;
            if (contactMgr && [contactMgr respondsToSelector:@selector(getSelfContact)]) {
                @try {
                    id selfContact = [contactMgr getSelfContact];
                    if (selfContact && [selfContact respondsToSelector:@selector(m_nsUsrName)]) {
                        selfUserName = [selfContact m_nsUsrName];
                    }
                } @catch (NSException *e) {}
            }
            
            // 创建发送消息包装
            CMessageWrap *sendWrap = nil;
            Class wrapClass = %c(CMessageWrap);
            if (wrapClass && [wrapClass instancesRespondToSelector:@selector(initWithMsgType:)]) {
                @try {
                    sendWrap = ((id (*)(id, SEL, int))objc_msgSend)([wrapClass alloc], @selector(initWithMsgType:), 34);
                } @catch (NSException *e) {}
            }
            
            if (!sendWrap) {
                NSLog(@"[消息手势] 语音复读失败: 无法创建消息包装");
                return;
            }
            
            // 设置消息属性
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
            
            // 设置消息内容
            unsigned int voiceLengthMs = voiceTime * 1000;
            NSString *voiceContent = [NSString stringWithFormat:@"<msg><voicemsg voicelength=\"%u\" voiceformat=\"%u\" forwardflag=\"0\" /></msg>", voiceLengthMs, voiceFormat];
            if ([sendWrap respondsToSelector:@selector(setM_nsContent:)]) {
                [sendWrap setValue:voiceContent forKey:@"m_nsContent"];
            }
            
            // 重置身份
            if ([sendWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
                [sendWrap setValue:@(0) forKey:@"m_uiMesLocalID"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
                [sendWrap setValue:@(0) forKey:@"m_n64MesSvrID"];
            }
            
            // 设置时间
            unsigned int now = (unsigned int)[[NSDate date] timeIntervalSince1970];
            if ([sendWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
                [sendWrap setValue:@(now) forKey:@"m_uiCreateTime"];
            }
            if ([sendWrap respondsToSelector:@selector(setM_uiSendTime:)]) {
                [sendWrap setValue:@(now) forKey:@"m_uiSendTime"];
            }
            
            // 生成并设置客户端消息ID（关键！）
            NSString *clientMsgID = nil;
            if (selfUserName.length > 0) {
                clientMsgID = [NSString stringWithFormat:@"%@_%u_%u", selfUserName, now, arc4random()];
            } else {
                clientMsgID = [NSString stringWithFormat:@"cs_%u_%u", now, arc4random()];
            }
            if ([sendWrap respondsToSelector:@selector(setM_nsClientMsgID:)]) {
                [sendWrap setValue:clientMsgID forKey:@"m_nsClientMsgID"];
            }
            
            // 设置扩展信息
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
                    NSLog(@"[消息手势] 设置语音扩展信息失败: %@", e);
                }
            }
            
            
            // 发送语音消息
            BOOL voiceSent = NO;
            
            // 方式1: 使用 SendMessageMgr.AddMsgToSendTable:MsgWrap:
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
                        // 记录发送前状态
                        unsigned int beforeStatus = 0;
                        unsigned int beforeLocalID = 0;
                        @try {
                            beforeStatus = [sendWrap respondsToSelector:@selector(m_uiStatus)] ?
                                ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiStatus)) : 0;
                            beforeLocalID = [sendWrap respondsToSelector:@selector(m_uiMesLocalID)] ?
                                ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiMesLocalID)) : 0;
                        } @catch (NSException *e) {}
                        
                        ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgSelector, chatName, sendWrap);
                        
                        // 记录发送后状态
                        unsigned int afterStatus = 0;
                        unsigned int afterLocalID = 0;
                        @try {
                            afterStatus = [sendWrap respondsToSelector:@selector(m_uiStatus)] ?
                                ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiStatus)) : 0;
                            afterLocalID = [sendWrap respondsToSelector:@selector(m_uiMesLocalID)] ?
                                ((unsigned int (*)(id, SEL))objc_msgSend)(sendWrap, @selector(m_uiMesLocalID)) : 0;
                        } @catch (NSException *e) {}
                        
                        if (afterStatus == 5 || afterLocalID == 0) {
                        } else {
                            voiceSent = YES;
                        }
                    } @catch (NSException *e) {
                        NSLog(@"[消息手势] SendMessageMgr.AddMsgToSendTable:MsgWrap: 失败: %@", e);
                    }
                }
            }
            
            // 方式2: 使用 CMessageMgr.AddLocalMsg (通过持久化适配器)
            if (!voiceSent) {
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
                        
                        // AddLocalMsg 成功后，需要调用 ResendVoiceMsg 触发上传
                        SEL resendVoiceSel = NSSelectorFromString(@"ResendVoiceMsg:MsgWrap:");
                        
                        // 尝试 AudioSender
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
                                voiceSent = YES;
                            } @catch (NSException *e) {
                                NSLog(@"[消息手势] AudioSender.ResendVoiceMsg 失败: %@", e);
                            }
                        }
                        
                        // 尝试 MMNewUploadVoiceMgr
                        if (!voiceSent) {
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
                                    voiceSent = YES;
                                } @catch (NSException *e) {
                                    NSLog(@"[消息手势] MMNewUploadVoiceMgr.ResendVoiceMsg 失败: %@", e);
                                }
                            }
                        }
                        
                        // 尝试 UploadVoiceCDNMgr
                        if (!voiceSent) {
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
                                    voiceSent = YES;
                                } @catch (NSException *e) {
                                    NSLog(@"[消息手势] UploadVoiceCDNMgr.ResendVoiceMsg 失败: %@", e);
                                }
                            }
                        }
                        
                        if (!voiceSent) {
                        }
                    } else {
                    }
                }
            }
            
            if (!voiceSent) {
                NSLog(@"[消息手势] 语音复读失败: 所有发送方式均失败");
            }
        } else if (msgType == 43) {
            
            NSString *chatName = nil;
            BOOL isSender = NO;
            @try {
                Class msgWrapClass = NSClassFromString(@"CMessageWrap");
                if (msgWrapClass && [msgWrapClass respondsToSelector:@selector(isSenderFromMsgWrap:)]) {
                    isSender = [msgWrapClass isSenderFromMsgWrap:msgWrap];
                }
            } @catch (NSException *e) {
                NSLog(@"[消息手势] 获取isSender异常: %@", e);
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
                NSLog(@"[消息手势] 视频复读失败: 无法获取聊天名称");
                return;
            }
            
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
                
                if (sendMessageMgr && [sendMessageMgr respondsToSelector:addMsgSelector]) {
                    @try {
                        ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgSelector, chatName, msgWrap);
                    } @catch (NSException *e) {
                        NSLog(@"[消息手势] SendMessageMgr.AddMsgToSendTable 失败: %@", e);
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
                                NSLog(@"[消息手势] 获取 msgWrap 失败: %@", e);
                            }
                        }
                    } @catch (NSException *e) {
                        NSLog(@"[消息手势] GenForwardVideoFromMsgWrap 失败: %@", e);
                    }
                }
                
                BOOL sent = NO;
                
                if (videoInfo) {
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
                    
                    NSString *selfUserName = nil;
                    if (contactMgr && [contactMgr respondsToSelector:@selector(getSelfContact)]) {
                        @try {
                            id selfContact = [contactMgr getSelfContact];
                            if (selfContact && [selfContact respondsToSelector:@selector(m_nsUsrName)]) {
                                selfUserName = [selfContact m_nsUsrName];
                            }
                        } @catch (NSException *e) {}
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
                                NSLog(@"[消息手势] %@ 失败: %@", selectorName, e);
                            }
                        }
                    }
                }
                
                if (!sent && !forwardWrap && hasGenericSelector) {
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
                    
                    id contact = nil;
                    SEL getContactSelector = NSSelectorFromString(@"getContactByName:");
                    if (contactMgr && [contactMgr respondsToSelector:getContactSelector]) {
                        @try {
                            contact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, getContactSelector, chatName);
                        } @catch (NSException *e) {
                            NSLog(@"[消息手势] 获取联系人失败: %@", e);
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
                                    NSLog(@"[消息手势] 获取 msgWrap 失败: %@", e);
                                }
                            }
                        } @catch (NSException *e) {
                            NSLog(@"[消息手势] GenForwardMsgFromMsgWrap:ToContact: 失败: %@", e);
                        }
                    } else {
                        NSLog(@"[消息手势] 无法获取联系人对象");
                    }
                }
                
                if (!sent && forwardWrap) {
                    if (forwardWrap == msgWrap) {
                        sent = YES;
                    }
                    
                    if (!sent) {
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
                        
                        NSString *selfUserName = nil;
                        if (contactMgr && [contactMgr respondsToSelector:@selector(getSelfContact)]) {
                            @try {
                                id selfContact = [contactMgr getSelfContact];
                                if (selfContact && [selfContact respondsToSelector:@selector(m_nsUsrName)]) {
                                    selfUserName = [selfContact m_nsUsrName];
                                }
                            } @catch (NSException *e) {}
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
                                NSLog(@"[消息手势] SendMessageMgr.AddMsgToSendTable 失败: %@", e);
                            }
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
                            ((void (*)(id, SEL, id, id))objc_msgSend)(sendMessageMgr, addMsgSelector, chatName, msgWrap);
                            sent = YES;
                        } @catch (NSException *e) {
                            NSLog(@"[消息手势] SendMessageMgr.AddMsgToSendTable 失败: %@", e);
                        }
                    }
                }
                
                if (!sent) {
                    NSLog(@"[消息手势] 视频复读失败: 所有发送方式均失败");
                }
            }
        } else {
            // 其他类型消息：使用 AddMsgToSendTable:MsgWrap: 方法复读
            
            // 获取当前聊天名称
            // 对于己方消息，使用 m_nsToUsr；对于对方消息，使用 m_nsFromUsr
            NSString *chatName = nil;
            BOOL isSender = NO;
            @try {
                Class msgWrapClass = NSClassFromString(@"CMessageWrap");
                if (msgWrapClass && [msgWrapClass respondsToSelector:@selector(isSenderFromMsgWrap:)]) {
                    isSender = [msgWrapClass isSenderFromMsgWrap:msgWrap];
                }
            } @catch (NSException *e) {
                NSLog(@"[消息手势] 获取isSender异常: %@", e);
            }
            
            if (isSender) {
                // 己方消息：使用 m_nsToUsr
                if ([msgWrap respondsToSelector:@selector(m_nsToUsr)]) {
                    chatName = [msgWrap m_nsToUsr];
                }
            } else {
                // 对方消息：使用 m_nsFromUsr
                if ([msgWrap respondsToSelector:@selector(m_nsFromUsr)]) {
                    chatName = [msgWrap m_nsFromUsr];
                }
            }
            
            
            if (!chatName) {
                NSLog(@"[消息手势] 复读失败: 无法获取聊天名称");
                return;
            }
            
            // 创建新的消息包装对象
            CMessageWrap *sendWrap = nil;
            
            // 尝试使用 copy 方法
            if ([msgWrap respondsToSelector:@selector(copy)]) {
                @try {
                    id copiedWrap = [msgWrap copy];
                    if ([copiedWrap isKindOfClass:%c(CMessageWrap)] && copiedWrap != msgWrap) {
                        sendWrap = (CMessageWrap *)copiedWrap;
                    }
                } @catch (NSException *e) {
                    NSLog(@"[消息手势] copy 失败: %@", e);
                }
            }
            
            // 如果 copy 失败，使用 initWithMsgType: 方法
            if (!sendWrap) {
                Class wrapClass = %c(CMessageWrap);
                if (wrapClass && [wrapClass instancesRespondToSelector:@selector(initWithMsgType:)]) {
                    @try {
                        sendWrap = ((id (*)(id, SEL, int))objc_msgSend)([wrapClass alloc], @selector(initWithMsgType:), msgType);
                    } @catch (NSException *e) {
                        NSLog(@"[消息手势] initWithMsgType: 失败: %@", e);
                    }
                }
            }
            
            if (!sendWrap) {
                NSLog(@"[消息手势] 复读失败: 无法创建新消息包装对象");
                return;
            }
            
            // 获取当前登录用户名
            NSString *selfUserName = nil;
            id contactMgr = nil;
            
            // 从 MMContext 获取 CContactMgr
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
            
            // 从 CContactMgr 获取当前登录用户
            if (contactMgr && [contactMgr respondsToSelector:@selector(getSelfContact)]) {
                @try {
                    id selfContact = [contactMgr getSelfContact];
                    if (selfContact && [selfContact respondsToSelector:@selector(m_nsUsrName)]) {
                        selfUserName = [selfContact m_nsUsrName];
                    }
                } @catch (NSException *e) {
                    NSLog(@"[消息手势] 获取当前用户失败: %@", e);
                }
            }
            
            // 设置发送路由
            if ([sendWrap respondsToSelector:@selector(setM_nsToUsr:)]) {
                [sendWrap setValue:chatName forKey:@"m_nsToUsr"];
            }
            
            if (selfUserName.length > 0 && [sendWrap respondsToSelector:@selector(setM_nsFromUsr:)]) {
                [sendWrap setValue:selfUserName forKey:@"m_nsFromUsr"];
            }
            
            // 设置发送者身份
            if ([sendWrap respondsToSelector:@selector(setM_uiIsSenderStatus:)]) {
                [sendWrap setValue:@(1) forKey:@"m_uiIsSenderStatus"];
            }
            
            // 重置发送身份信息
            if ([sendWrap respondsToSelector:@selector(setM_uiMesLocalID:)]) {
                [sendWrap setValue:@(0) forKey:@"m_uiMesLocalID"];
            }
            
            if ([sendWrap respondsToSelector:@selector(setM_n64MesSvrID:)]) {
                [sendWrap setValue:@(0) forKey:@"m_n64MesSvrID"];
            }
            
            if ([sendWrap respondsToSelector:@selector(setM_uiStatus:)]) {
                [sendWrap setValue:@(0) forKey:@"m_uiStatus"];
            }
            
            // 设置创建时间和发送时间
            unsigned int now = (unsigned int)[[NSDate date] timeIntervalSince1970];
            if ([sendWrap respondsToSelector:@selector(setM_uiCreateTime:)]) {
                [sendWrap setValue:@(now) forKey:@"m_uiCreateTime"];
            }
            
            if ([sendWrap respondsToSelector:@selector(setM_uiSendTime:)]) {
                [sendWrap setValue:@(now) forKey:@"m_uiSendTime"];
            }
            
            
            // 判断消息是否来自对方
            BOOL isFromOther = wchook_isMessageFromOther(msgWrap);
            
            // 根据消息类型选择不同的发送方式
            if (msgType == 47) {
                // 表情消息
                
                // 获取表情 MD5
                NSString *emoticonMD5 = nil;
                if ([msgWrap respondsToSelector:@selector(m_nsEmoticonMD5)]) {
                    emoticonMD5 = [msgWrap m_nsEmoticonMD5];
                }
                
                if (emoticonMD5.length == 32 && [sendWrap respondsToSelector:@selector(setM_nsEmoticonMD5:)]) {
                    [sendWrap setValue:emoticonMD5 forKey:@"m_nsEmoticonMD5"];
                }
                
                // 己方消息：使用 CMessageMgr 的 AddEmoticonMsg:MsgWrap: 方法
                // 对方消息：使用 SendMessageMgr 的 AddMsgToSendTable:MsgWrap: 方法
                if (!isFromOther) {
                    
                    // 尝试通过多种方式获取 CMessageMgr
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
                    
                    if (!messageMgr) {
                        Class serviceCenterClass = NSClassFromString(@"ServiceCenter");
                        if (serviceCenterClass) {
                            SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                            if ([serviceCenterClass respondsToSelector:defaultCenterSelector]) {
                                id serviceCenter = [serviceCenterClass performSelector:defaultCenterSelector];
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
                            } @catch (NSException *e) {
                                NSLog(@"[消息手势] CMessageMgr.AddEmoticonMsg:MsgWrap: 失败: %@", e);
                            }
                        } else {
                            NSLog(@"[消息手势] 复读失败: CMessageMgr 不响应 AddEmoticonMsg:MsgWrap:");
                        }
                    } else {
                        NSLog(@"[消息手势] 复读失败: 无法获取 CMessageMgr");
                    }
                } else {
                    
                    // 从消息内容中解析表情 MD5
                    NSString *emoticonMD5 = wchook_emoticonMD5FromMessageWrap(msgWrap);
                    
                    // 按照参考项目的顺序设置消息属性
                    // 1. 设置消息类型
                    sendWrap.m_uiMessageType = 47;
                    
                    // 2. 设置目标用户
                    sendWrap.m_nsToUsr = chatName;
                    
                    // 3. 设置来源用户
                    if (selfUserName.length > 0) {
                        sendWrap.m_nsFromUsr = selfUserName;
                    }
                    
                    // 4. 如果是群聊，设置 m_nsRealChatUsr
                    BOOL isChatRoom = [chatName containsString:@"@chatroom"];
                    if (isChatRoom && selfUserName.length > 0) {
                        @try {
                            [sendWrap setValue:selfUserName forKey:@"m_nsRealChatUsr"];
                        } @catch (NSException *e) {
                            NSLog(@"[消息手势] 设置 m_nsRealChatUsr 失败: %@", e);
                        }
                    }
                    
                    // 5. 设置消息内容
                    sendWrap.m_nsContent = msgWrap.m_nsContent ?: @"";
                    
                    // 6. 设置表情 MD5
                    if (emoticonMD5.length == 32) {
                        sendWrap.m_nsEmoticonMD5 = emoticonMD5;
                    }
                    
                    // 7. 重置消息身份
                    @try {
                        [sendWrap setValue:@(0) forKey:@"m_uiMesLocalID"];
                        [sendWrap setValue:@(0) forKey:@"m_n64MesSvrID"];
                        [sendWrap setValue:@(0) forKey:@"m_uiStatus"];
                    } @catch (NSException *e) {
                        NSLog(@"[消息手势] 重置消息身份失败: %@", e);
                    }
                    
                    NSString *realChatUsr = nil;
                    @try {
                        realChatUsr = [sendWrap valueForKey:@"m_nsRealChatUsr"];
                    } @catch (NSException *e) {
                        // ignore
                    }
                    
                    
                    // 首先尝试使用 CMessageMgr 的 AddEmoticonMsg:MsgWrap: 方法
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
                    
                    if (!messageMgr) {
                        Class serviceCenterClass = NSClassFromString(@"ServiceCenter");
                        if (serviceCenterClass) {
                            SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                            if ([serviceCenterClass respondsToSelector:defaultCenterSelector]) {
                                id serviceCenter = [serviceCenterClass performSelector:defaultCenterSelector];
                                if (serviceCenter && [serviceCenter respondsToSelector:@selector(getService:)]) {
                                    Class messageMgrClass = NSClassFromString(@"CMessageMgr");
                                    messageMgr = [serviceCenter performSelector:@selector(getService:) withObject:messageMgrClass];
                                }
                            }
                        }
                    }
                    
                    BOOL resentSuccess = NO;
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
                                resentSuccess = YES;
                            } @catch (NSException *e) {
                                NSLog(@"[消息手势] CMessageMgr.AddEmoticonMsg:MsgWrap: 失败: %@", e);
                            }
                        }
                    }
                    
                    // 如果 AddEmoticonMsg 失败，尝试通过表情对象发送
                    if (!resentSuccess) {
                        
                        id emoticonWrap = wchook_resolveEmoticonWrap(msgWrap, emoticonMD5);
                        
                        if (wchook_sendEmoticonViaLogicController(emoticonWrap, logicController, chatVC)) {
                            return;
                        }
                        
                        // 如果表情对象发送失败，尝试使用 SendMessageMgr
                        
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
                        
                        if (!sendMessageMgr) {
                            Class serviceCenterClass = NSClassFromString(@"ServiceCenter");
                            if (serviceCenterClass) {
                                SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                                if ([serviceCenterClass respondsToSelector:defaultCenterSelector]) {
                                    id serviceCenter = [serviceCenterClass performSelector:defaultCenterSelector];
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
                                    NSMethodSignature *signature = [sendMessageMgr methodSignatureForSelector:addMsgSelector];
                                    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                                    [invocation setTarget:sendMessageMgr];
                                    [invocation setSelector:addMsgSelector];
                                    [invocation setArgument:&chatName atIndex:2];
                                    [invocation setArgument:&sendWrap atIndex:3];
                                    [invocation invoke];
                                } @catch (NSException *e) {
                                    NSLog(@"[消息手势] SendMessageMgr.AddMsgToSendTable:MsgWrap: 失败: %@", e);
                                }
                            } else {
                                NSLog(@"[消息手势] 复读失败: SendMessageMgr 不响应 AddMsgToSendTable:MsgWrap:");
                            }
                        } else {
                            NSLog(@"[消息手势] 复读失败: 无法获取 SendMessageMgr");
                        }
                    }
                }
            } else if (msgType == 3 || msgType == 42 || msgType == 49) {
                // 图片消息、名片消息或文件/引用消息：使用 CMessageMgr 的 ResendMsg:MsgWrap: 方法
                
                // 尝试通过多种方式获取 CMessageMgr
                id messageMgr = nil;
                
                // 方法1: 从 MMContext 获取
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
                
                // 方法2: 从 MMServiceCenter 获取
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
                
                // 方法3: 从 ServiceCenter 获取
                if (!messageMgr) {
                    Class serviceCenterClass = NSClassFromString(@"ServiceCenter");
                    if (serviceCenterClass) {
                        SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                        if ([serviceCenterClass respondsToSelector:defaultCenterSelector]) {
                            id serviceCenter = [serviceCenterClass performSelector:defaultCenterSelector];
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
                        } @catch (NSException *e) {
                            NSLog(@"[消息手势] CMessageMgr.ResendMsg:MsgWrap: 失败: %@", e);
                        }
                    } else {
                        NSLog(@"[消息手势] 复读失败: CMessageMgr 不响应 ResendMsg:MsgWrap:");
                    }
                } else {
                    NSLog(@"[消息手势] 复读失败: 无法获取 CMessageMgr");
                }
            } else {
                // 其他类型消息：使用 SendMessageMgr 的 AddMsgToSendTable:MsgWrap: 方法
                
                // 尝试通过多种方式获取 SendMessageMgr
                id sendMessageMgr = nil;
                
                // 方法1: 从 MMContext 获取
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
                
                // 方法2: 从 MMServiceCenter 获取
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
                
                // 方法3: 从 ServiceCenter 获取
                if (!sendMessageMgr) {
                    Class serviceCenterClass = NSClassFromString(@"ServiceCenter");
                    if (serviceCenterClass) {
                        SEL defaultCenterSelector = NSSelectorFromString(@"defaultCenter");
                        if ([serviceCenterClass respondsToSelector:defaultCenterSelector]) {
                            id serviceCenter = [serviceCenterClass performSelector:defaultCenterSelector];
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
                            NSMethodSignature *signature = [sendMessageMgr methodSignatureForSelector:addMsgSelector];
                            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                            [invocation setTarget:sendMessageMgr];
                            [invocation setSelector:addMsgSelector];
                            [invocation setArgument:&chatName atIndex:2];
                            [invocation setArgument:&sendWrap atIndex:3];
                            [invocation invoke];
                        } @catch (NSException *e) {
                            NSLog(@"[消息手势] SendMessageMgr.AddMsgToSendTable:MsgWrap: 失败: %@", e);
                        }
                    } else {
                        NSLog(@"[消息手势] 复读失败: SendMessageMgr 不响应 AddMsgToSendTable:MsgWrap:");
                    }
                } else {
                    NSLog(@"[消息手势] 复读失败: 无法获取 SendMessageMgr");
                }
            }
        }
    } @catch (NSException *e) {
        NSLog(@"[消息手势] 复读消息异常: %@", e);
        NSLog(@"[消息手势] 异常调用栈: %@", e.callStackSymbols);
    }
}

%new
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.wchook_swipeGesture) {
        if (!isMessageGestureEnabled()) {
            return NO;
        }
        
        return (getSwipeAction(kLeftSwipeOtherActionKey) != WCSwipeActionDisabled ||
                getSwipeAction(kLeftSwipeSelfActionKey) != WCSwipeActionDisabled ||
                getSwipeAction(kRightSwipeOtherActionKey) != WCSwipeActionDisabled ||
                getSwipeAction(kRightSwipeSelfActionKey) != WCSwipeActionDisabled);
    }
    return YES;
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.wchook_swipeGesture) {
        if ([otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            return NO;
        }
        
        if ([otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            return NO;
        }
        
        if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            UIPanGestureRecognizer *otherPan = (UIPanGestureRecognizer *)otherGestureRecognizer;
            CGPoint translation = [otherPan translationInView:self];
            
            if (fabs(translation.x) > fabs(translation.y)) {
                return NO;
            }
        }
        
        NSString *otherClassName = NSStringFromClass([otherGestureRecognizer class]);
        if ([otherClassName containsString:@"ScreenEdge"] || [otherClassName containsString:@"Edge"]) {
            return NO;
        }
    }
    return YES;
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.wchook_swipeGesture) {
        NSString *otherClassName = NSStringFromClass([otherGestureRecognizer class]);
        if ([otherClassName containsString:@"ScreenEdge"] || [otherClassName containsString:@"Edge"]) {
            return YES;
        }
    }
    return NO;
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.wchook_swipeGesture) {
        if ([otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            return YES;
        }
        if ([otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareForReuse {
    %orig;
    [self wchook_resetSwipeAnimated:NO];
}

- (void)layoutSubviews {
    %orig;
    [self wchook_setupSwipeGestureIfNeeded];
}

%end

@interface VoiceMessageCellView : CommonMessageCellView
@end

%hook VoiceMessageCellView

- (void)prepareForReuse {
    %orig;
    [self wchook_resetSwipeAnimated:NO];
}

- (void)layoutSubviews {
    %orig;
    [self wchook_setupSwipeGestureIfNeeded];
}

%end

%ctor {
}
