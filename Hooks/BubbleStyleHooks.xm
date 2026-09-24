// 气泡样式Hook - 最终完美版 | 无双重气泡 | 长文本无残留 | 用户自定义圆角 | 文本自适应
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <substrate.h>
#import "../Headers/WCHeaders.h"

static NSString * const kBubbleStyleEnabledKey = @"com.wechat.enhance.bubble_style.enabled";
static NSString * const kBubbleCornerRadiusKey = @"com.wechat.enhance.bubble_style.corner_radius";

static NSString * const kBubbleSenderLightColorRedKey = @"com.wechat.enhance.bubble_style.sender_light_color.red";
static NSString * const kBubbleSenderLightColorGreenKey = @"com.wechat.enhance.bubble_style.sender_light_color.green";
static NSString * const kBubbleSenderLightColorBlueKey = @"com.wechat.enhance.bubble_style.sender_light_color.blue";
static NSString * const kBubbleSenderLightColorAlphaKey = @"com.wechat.enhance.bubble_style.sender_light_color.alpha";

static NSString * const kBubbleReceiverLightColorRedKey = @"com.wechat.enhance.bubble_style.receiver_light_color.red";
static NSString * const kBubbleReceiverLightColorGreenKey = @"com.wechat.enhance.bubble_style.receiver_light_color.green";
static NSString * const kBubbleReceiverLightColorBlueKey = @"com.wechat.enhance.bubble_style.receiver_light_color.blue";
static NSString * const kBubbleReceiverLightColorAlphaKey = @"com.wechat.enhance.bubble_style.receiver_light_color.alpha";

static NSString * const kBubbleSenderDarkColorRedKey = @"com.wechat.enhance.bubble_style.sender_dark_color.red";
static NSString * const kBubbleSenderDarkColorGreenKey = @"com.wechat.enhance.bubble_style.sender_dark_color.green";
static NSString * const kBubbleSenderDarkColorBlueKey = @"com.wechat.enhance.bubble_style.sender_dark_color.blue";
static NSString * const kBubbleSenderDarkColorAlphaKey = @"com.wechat.enhance.bubble_style.sender_dark_color.alpha";

static NSString * const kBubbleReceiverDarkColorRedKey = @"com.wechat.enhance.bubble_style.receiver_dark_color.red";
static NSString * const kBubbleReceiverDarkColorGreenKey = @"com.wechat.enhance.bubble_style.receiver_dark_color.green";
static NSString * const kBubbleReceiverDarkColorBlueKey = @"com.wechat.enhance.bubble_style.receiver_dark_color.blue";
static NSString * const kBubbleReceiverDarkColorAlphaKey = @"com.wechat.enhance.bubble_style.receiver_dark_color.alpha";

static NSString * const kBubbleRedEnvelopSenderLightColorRedKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.red";
static NSString * const kBubbleRedEnvelopSenderLightColorGreenKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.green";
static NSString * const kBubbleRedEnvelopSenderLightColorBlueKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.blue";
static NSString * const kBubbleRedEnvelopSenderLightColorAlphaKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.alpha";

static NSString * const kBubbleRedEnvelopSenderDarkColorRedKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_dark_color.red";
static NSString * const kBubbleRedEnvelopSenderDarkColorGreenKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_dark_color.green";
static NSString * const kBubbleRedEnvelopSenderDarkColorBlueKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_dark_color.blue";
static NSString * const kBubbleRedEnvelopSenderDarkColorAlphaKey = @"com.wechat.enhance.bubble_style.redenvelop_sender_dark_color.alpha";

static NSString * const kBubbleRedEnvelopReceiverLightColorRedKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_light_color.red";
static NSString * const kBubbleRedEnvelopReceiverLightColorGreenKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_light_color.green";
static NSString * const kBubbleRedEnvelopReceiverLightColorBlueKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_light_color.blue";
static NSString * const kBubbleRedEnvelopReceiverLightColorAlphaKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_light_color.alpha";

static NSString * const kBubbleRedEnvelopReceiverDarkColorRedKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_dark_color.red";
static NSString * const kBubbleRedEnvelopReceiverDarkColorGreenKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_dark_color.green";
static NSString * const kBubbleRedEnvelopReceiverDarkColorBlueKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_dark_color.blue";
static NSString * const kBubbleRedEnvelopReceiverDarkColorAlphaKey = @"com.wechat.enhance.bubble_style.redenvelop_receiver_dark_color.alpha";

static NSString * const kMergeMessagesEnabledKey = @"com.wechat.enhance.merge_messages.enabled";
static NSString * const kMergeMessagesScopeKey = @"com.wechat.enhance.merge_messages.scope";
static NSString * const kMergeMessagesSpacingKey = @"com.wechat.enhance.merge_messages.spacing";
static NSString * const kMergeMessagesAvatarPositionKey = @"com.wechat.enhance.merge_messages.avatar_position";
static NSString * const kConsecutiveMessagesSpacingKey = @"com.wechat.enhance.consecutive_messages.spacing";

static BOOL isBubbleStyleEnabled = NO;
static CGFloat customCornerRadius = 16.0f;
static UIColor *senderLightColor = nil;
static UIColor *receiverLightColor = nil;
static UIColor *senderDarkColor = nil;
static UIColor *receiverDarkColor = nil;
static UIColor *redEnvelopSenderLightColor = nil;
static UIColor *redEnvelopReceiverLightColor = nil;
static UIColor *redEnvelopSenderDarkColor = nil;
static UIColor *redEnvelopReceiverDarkColor = nil;

static BOOL isMergeMessagesEnabled = NO;
static NSInteger mergeMessagesScope = 3;
static NSInteger mergeMessagesSpacing = 1;
static NSInteger mergeMessagesAvatarPosition = 1;
static CGFloat consecutiveMessagesSpacing = 4.0f;

@interface BubbleInfo : NSObject
@property(nonatomic, assign) unsigned long long position;
@property(nonatomic, assign) unsigned long long type;
@property(retain, nonatomic) NSString *bubbleName;
- (id)getBubbleImage:(BOOL)arg1 isDarkMode:(BOOL)arg2 useCache:(BOOL)arg3;
@end

@interface WCPayInfoItem : NSObject
@property(retain, nonatomic) NSString *m_c2cNativeUrl;
@end

@interface CMessageWrap (RedEnvelop)
@property (nonatomic, strong) WCPayInfoItem *m_oWCPayInfoItem;
@end

static const void *kIsRedEnvelopKey = &kIsRedEnvelopKey;

static UIColor *loadColorWithKeys(NSString *redKey, NSString *greenKey, NSString *blueKey, NSString *alphaKey,
                                  CGFloat defaultRed, CGFloat defaultGreen, CGFloat defaultBlue, CGFloat defaultAlpha) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CGFloat red = [defaults floatForKey:redKey];
    CGFloat green = [defaults floatForKey:greenKey];
    CGFloat blue = [defaults floatForKey:blueKey];
    CGFloat alpha = [defaults floatForKey:alphaKey];
    
    if (red == 0 && green == 0 && blue == 0 && alpha == 0) {
        return [UIColor colorWithRed:defaultRed green:defaultGreen blue:defaultBlue alpha:defaultAlpha];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

static void loadBubbleStyleSettings() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    isBubbleStyleEnabled = [defaults boolForKey:kBubbleStyleEnabledKey];
    
    CGFloat savedRadius = [defaults floatForKey:kBubbleCornerRadiusKey];
    if (savedRadius > 0) {
        customCornerRadius = savedRadius;
    } else {
        customCornerRadius = 16.0f;
    }
    
    senderLightColor = loadColorWithKeys(kBubbleSenderLightColorRedKey, kBubbleSenderLightColorGreenKey,
                                         kBubbleSenderLightColorBlueKey, kBubbleSenderLightColorAlphaKey,
                                         0.27, 0.78, 0.49, 1.0);
    
    receiverLightColor = loadColorWithKeys(kBubbleReceiverLightColorRedKey, kBubbleReceiverLightColorGreenKey,
                                           kBubbleReceiverLightColorBlueKey, kBubbleReceiverLightColorAlphaKey,
                                           0.95, 0.95, 0.95, 1.0);
    
    senderDarkColor = loadColorWithKeys(kBubbleSenderDarkColorRedKey, kBubbleSenderDarkColorGreenKey,
                                        kBubbleSenderDarkColorBlueKey, kBubbleSenderDarkColorAlphaKey,
                                        0.20, 0.60, 0.98, 1.0);
    
    receiverDarkColor = loadColorWithKeys(kBubbleReceiverDarkColorRedKey, kBubbleReceiverDarkColorGreenKey,
                                          kBubbleReceiverDarkColorBlueKey, kBubbleReceiverDarkColorAlphaKey,
                                          0.18, 0.18, 0.18, 1.0);
    
    redEnvelopSenderLightColor = loadColorWithKeys(kBubbleRedEnvelopSenderLightColorRedKey, kBubbleRedEnvelopSenderLightColorGreenKey,
                                                   kBubbleRedEnvelopSenderLightColorBlueKey, kBubbleRedEnvelopSenderLightColorAlphaKey,
                                                   0.91, 0.30, 0.24, 1.0);
    
    redEnvelopReceiverLightColor = loadColorWithKeys(kBubbleRedEnvelopReceiverLightColorRedKey, kBubbleRedEnvelopReceiverLightColorGreenKey,
                                                     kBubbleRedEnvelopReceiverLightColorBlueKey, kBubbleRedEnvelopReceiverLightColorAlphaKey,
                                                     0.91, 0.30, 0.24, 1.0);
    
    redEnvelopSenderDarkColor = loadColorWithKeys(kBubbleRedEnvelopSenderDarkColorRedKey, kBubbleRedEnvelopSenderDarkColorGreenKey,
                                                  kBubbleRedEnvelopSenderDarkColorBlueKey, kBubbleRedEnvelopSenderDarkColorAlphaKey,
                                                  0.86, 0.22, 0.10, 1.0);
    
    redEnvelopReceiverDarkColor = loadColorWithKeys(kBubbleRedEnvelopReceiverDarkColorRedKey, kBubbleRedEnvelopReceiverDarkColorGreenKey,
                                                    kBubbleRedEnvelopReceiverDarkColorBlueKey, kBubbleRedEnvelopReceiverDarkColorAlphaKey,
                                                    0.86, 0.22, 0.10, 1.0);
    
    isMergeMessagesEnabled = [defaults boolForKey:kMergeMessagesEnabledKey];
    mergeMessagesScope = [defaults integerForKey:kMergeMessagesScopeKey];
    if (mergeMessagesScope == 0) {
        mergeMessagesScope = 3;
    }
    
    mergeMessagesSpacing = [defaults integerForKey:kMergeMessagesSpacingKey];
    if (mergeMessagesSpacing == 0) {
        mergeMessagesSpacing = 1;
    }
    
    mergeMessagesAvatarPosition = [defaults integerForKey:kMergeMessagesAvatarPositionKey];
    if (mergeMessagesAvatarPosition == 0) {
        mergeMessagesAvatarPosition = 1;
    }
    
    CGFloat savedConsecutiveSpacing = [defaults floatForKey:kConsecutiveMessagesSpacingKey];
    if (savedConsecutiveSpacing != 0 || [defaults objectForKey:kConsecutiveMessagesSpacingKey]) {
        consecutiveMessagesSpacing = savedConsecutiveSpacing;
    } else {
        consecutiveMessagesSpacing = 4.0f;
    }
    
    NSLog(@"[BubbleStyle] 设置已加载 - 启用: %@, 圆角: %.1f, 合并消息: %@, 范围: %ld, 间距: %ld, 头像位置: %ld, 连续消息间距: %.1f", 
          isBubbleStyleEnabled ? @"是" : @"否", customCornerRadius,
          isMergeMessagesEnabled ? @"是" : @"否", (long)mergeMessagesScope, (long)mergeMessagesSpacing, (long)mergeMessagesAvatarPosition, consecutiveMessagesSpacing);
}

// 绘制气泡（根据position绘制不同样式的圆角）
static UIImage *createBubbleImage(CGSize size, unsigned long long position, BOOL isSender, BOOL isDarkMode, BOOL isRedEnvelop) {
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    CGSize actualSize = size;
    
    if (position == 0) {
        CGFloat minHeight = customCornerRadius;
        if (actualSize.height < minHeight) {
            actualSize.height = minHeight;
        }
    } else if (position == 1 || position == 3){
        CGFloat minHeight = customCornerRadius * 2 + 2;
        if (actualSize.height < minHeight) {
            actualSize.height = minHeight;
        }
}

    
    UIGraphicsBeginImageContextWithOptions(actualSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        UIGraphicsEndImageContext();
        return nil;
    }

    UIBezierPath *path;
    
    if (position == 0) {
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, actualSize.width, actualSize.height) 
                                   byRoundingCorners:UIRectCornerAllCorners
                                         cornerRadii:CGSizeMake(customCornerRadius, customCornerRadius)];
    } else if (position == 1) {
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, actualSize.width, actualSize.height) 
                                   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                         cornerRadii:CGSizeMake(customCornerRadius, customCornerRadius)];
    } else if (position == 3) {
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, actualSize.width, actualSize.height) 
                                   byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                         cornerRadii:CGSizeMake(customCornerRadius, customCornerRadius)];
    } else {
        path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, actualSize.width, actualSize.height)];
    }
    
    UIColor *fillColor;
    
    if (isRedEnvelop) {
        if (isSender) {
            fillColor = isDarkMode ? redEnvelopSenderDarkColor : redEnvelopSenderLightColor;
        } else {
            fillColor = isDarkMode ? redEnvelopReceiverDarkColor : redEnvelopReceiverLightColor;
        }
    } else if (isSender) {
        fillColor = isDarkMode ? senderDarkColor : senderLightColor;
    } else {
        fillColor = isDarkMode ? receiverDarkColor : receiverLightColor;
    }
    
    [fillColor setFill];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat topInset, bottomInset, leftInset, rightInset;
    
    if (position == 0) {
        topInset = customCornerRadius + 1;
        bottomInset = customCornerRadius + 1;
    } else if (position == 1) {
        topInset = customCornerRadius + 1;
        bottomInset = 1;
    } else if (position == 3) {
        topInset = 1;
        bottomInset = customCornerRadius + 1;
    } else {
        topInset = 1;
        bottomInset = 1;
    }
    
    leftInset = customCornerRadius + 1;
    rightInset = customCornerRadius + 1;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset);
    UIImage *resizableImage = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return resizableImage;
}

%ctor {
    loadBubbleStyleSettings();
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        (CFNotificationCallback)loadBubbleStyleSettings,
        CFSTR("com.wechat.enhance.bubble_style.settings_changed"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
    NSLog(@"[BubbleStyle] Hook已加载 - 圆角半径: %.1f", customCornerRadius);
}

%hook BubbleInfo
- (id)getBubbleImage:(BOOL)arg1 isDarkMode:(BOOL)arg2 useCache:(BOOL)arg3 {
    if (!isBubbleStyleEnabled) {
        return %orig;
    }
    
    UIImage *originalImage = %orig;
    
    if (!originalImage) {
        return nil;
    }
    
    BOOL isSender = NO;
    if (self.bubbleName) {
        isSender = [self.bubbleName containsString:@"Sender"];
    }
    
    BOOL isRedEnvelop = NO;
    
    NSLog(@"[BubbleStyle] bubbleName: %@, type: %llu, position: %llu", 
          self.bubbleName, self.type, self.position);
    
    if (self.bubbleName) {
        NSString *lowercaseName = [self.bubbleName lowercaseString];
        isRedEnvelop = [lowercaseName containsString:@"redenvelop"] || 
                       [lowercaseName containsString:@"redpack"] ||
                       [lowercaseName containsString:@"hongbao"] ||
                       [lowercaseName containsString:@"luckymoney"] ||
                       [lowercaseName containsString:@"wxpay"] ||
                       [lowercaseName containsString:@"c2c"] ||
                       [lowercaseName containsString:@"transfer"] ||
                       [lowercaseName containsString:@"pay"];
    }
    
    NSLog(@"[BubbleStyle] isSender: %d, isRedEnvelop: %d", isSender, isRedEnvelop);
    
    NSNumber *isRedEnvelopNumber = objc_getAssociatedObject(self, kIsRedEnvelopKey);
    if (isRedEnvelopNumber && [isRedEnvelopNumber boolValue]) {
        isRedEnvelop = YES;
    }
    
    NSLog(@"[BubbleStyle] Final isRedEnvelop: %d", isRedEnvelop);
    
    UIImage *customBubble = createBubbleImage(originalImage.size, self.position, isSender, arg2, isRedEnvelop);
    if (customBubble) {
        return customBubble;
    } else {
        return originalImage;
    }
}
%end

%hook CommonMessageViewModel

- (id)bgBubbleInfo {
    BubbleInfo *bubbleInfo = %orig;
    
    id messageWrap = [self messageWrap];
    if (bubbleInfo && messageWrap) {
        CMessageWrap *wrap = (CMessageWrap *)messageWrap;
        
        BOOL isRedEnvelop = NO;
        
        if (wrap.m_uiMessageType == 49) {
            id payInfo = [wrap m_oWCPayInfoItem];
            if (payInfo) {
                WCPayInfoItem *payItem = (WCPayInfoItem *)payInfo;
                NSString *nativeUrl = payItem.m_c2cNativeUrl;
                
                NSString *redEnvelopPrefix = @"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?";
                if (nativeUrl && [nativeUrl hasPrefix:redEnvelopPrefix]) {
                    isRedEnvelop = YES;
                }
                
                if (!isRedEnvelop && nativeUrl) {
                    NSString *lowercaseUrl = [nativeUrl lowercaseString];
                    if ([lowercaseUrl containsString:@"transfer"]) {
                        isRedEnvelop = YES;
                    }
                }
            }
            
            if (!isRedEnvelop) {
                NSString *content = [wrap m_nsContent];
                if (content) {
                    NSString *lowercaseContent = [content lowercaseString];
                    if ([lowercaseContent containsString:@"transfer"] || [content containsString:@"转账"]) {
                        isRedEnvelop = YES;
                    }
                }
            }
        }
        
        objc_setAssociatedObject(bubbleInfo, kIsRedEnvelopKey, @(isRedEnvelop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        NSLog(@"[BubbleStyle] CommonMessageViewModel - m_uiMessageType: %u, isRedEnvelop: %d", 
              wrap.m_uiMessageType, isRedEnvelop);
    }
    
    return bubbleInfo;
}

%end

@interface CommonMessageCellView : UIView
@property (nonatomic, strong) UIView *m_headImageView;
@property (nonatomic, strong) UILabel *m_chatRoomNameLabel;
@property (nonatomic, strong) id viewModel;
- (id)getHeadImageView;
@end

static BOOL isChatRoom(CContact *contact) {
    if (!contact) {
        return NO;
    }
    
    NSString *userName = contact.m_nsUsrName;
    if (userName.length > 0 && [userName hasSuffix:@"@chatroom"]) {
        return YES;
    }
    
    return NO;
}

static CMessageWrap *getMessageWrapFromNodeData(id nodeData) {
    Class baseChatViewModelClass = NSClassFromString(@"BaseChatViewModel");
    if (!baseChatViewModelClass) {
        return nil;
    }
    
    if (![nodeData isKindOfClass:baseChatViewModelClass]) {
        return nil;
    }
    
    SEL messageWrapSEL = @selector(messageWrap);
    if ([nodeData respondsToSelector:messageWrapSEL]) {
        return [nodeData messageWrap];
    }
    
    return nil;
}

static NSString *getSenderFromMessageWrap(CMessageWrap *msgWrap, BOOL isRoom) {
    if (!msgWrap) {
        return nil;
    }
    
    if (isRoom) {
        NSString *sender = msgWrap.m_nsRealChatUsr;
        if (!sender || sender.length == 0) {
            sender = msgWrap.m_nsFromUsr;
        }
        return sender;
    } else {
        return msgWrap.m_nsFromUsr;
    }
}

static BaseMsgContentViewController *findChatViewControllerFromResponder(UIResponder *responder) {
    UIResponder *current = responder;
    while ((current = [current nextResponder])) {
        if ([current isKindOfClass:NSClassFromString(@"BaseMsgContentViewController")]) {
            return (BaseMsgContentViewController *)current;
        }
    }
    return nil;
}

static BaseMsgContentViewController *findChatViewControllerFromWindow() {
    UIViewController *topVC = nil;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            topVC = window.rootViewController;
            break;
        }
    }
    
    if (!topVC) {
        return nil;
    }
    
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    if ([topVC isKindOfClass:NSClassFromString(@"MainTabBarViewController")]) {
        UIViewController *selectedVC = [(UITabBarController *)topVC selectedViewController];
        
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            UIViewController *navTopVC = [(UINavigationController *)selectedVC topViewController];
            
            if ([navTopVC isKindOfClass:NSClassFromString(@"BaseMsgContentViewController")]) {
                return (BaseMsgContentViewController *)navTopVC;
            }
        }
    }
    
    return nil;
}

typedef NS_ENUM(NSInteger, MessageSearchStrategy) {
    MessageSearchStrategyLinear = 0,  // 线性查找
    MessageSearchStrategyBinary,      // 二分查找
};

static inline MessageSearchStrategy selectSearchStrategy(NSInteger count) {
    if (count < 100) {
        return MessageSearchStrategyLinear;
    } else {
        return MessageSearchStrategyBinary;
    }
}

static inline NSInteger findMessageIndexLinear(NSMutableArray *messageArray, CMessageWrap *targetMsgWrap) {
    for (NSInteger i = 0; i < messageArray.count; i++) {
        id nodeData = messageArray[i];
        CMessageWrap *msgWrap = getMessageWrapFromNodeData(nodeData);
        if (msgWrap && msgWrap == targetMsgWrap) {
            return i;
        }
    }
    return -1;
}

static NSInteger findMessageIndexBinary(NSMutableArray *messageArray, CMessageWrap *targetMsgWrap) {
    NSUInteger targetTime = targetMsgWrap.m_uiCreateTime;
    NSInteger left = 0;
    NSInteger right = messageArray.count - 1;
    
    while (left <= right) {
        NSInteger mid = left + (right - left) / 2;
        id nodeData = messageArray[mid];
        CMessageWrap *msgWrap = getMessageWrapFromNodeData(nodeData);
        
        if (!msgWrap) {
            return findMessageIndexLinear(messageArray, targetMsgWrap);
        }
        
        NSUInteger midTime = msgWrap.m_uiCreateTime;
        
        if (midTime == targetTime) {
            NSInteger searchStart = MAX(0, mid - 20);
            NSInteger searchEnd = MIN((NSInteger)messageArray.count - 1, mid + 20);
            
            for (NSInteger i = searchStart; i <= searchEnd; i++) {
                nodeData = messageArray[i];
                msgWrap = getMessageWrapFromNodeData(nodeData);
                if (msgWrap && msgWrap == targetMsgWrap) {
                    return i;
                }
            }
            return -1;
        } else if (midTime < targetTime) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    
    return -1;
}

static NSInteger findMessageIndexInArray(NSMutableArray *messageArray, CMessageWrap *targetMsgWrap) {
    if (!messageArray || !targetMsgWrap) {
        return -1;
    }
    
    MessageSearchStrategy strategy = selectSearchStrategy(messageArray.count);
    
    switch (strategy) {
        case MessageSearchStrategyLinear:
            return findMessageIndexLinear(messageArray, targetMsgWrap);
            
        case MessageSearchStrategyBinary:
            return findMessageIndexBinary(messageArray, targetMsgWrap);
    }
    
    return -1;
}

static CGFloat calculateSpacingMultiplier(BOOL isRoom, BOOL isSelfMessage, id currentNodeData) {
    CGFloat spacingMultiplier = 1.0;
    
    if (isRoom && !isSelfMessage) {
        Class commonMessageViewModelClass = NSClassFromString(@"CommonMessageViewModel");
        if (commonMessageViewModelClass && [currentNodeData isKindOfClass:commonMessageViewModelClass]) {
            BOOL isShowChatRoomDisplayName = [(CommonMessageViewModel *)currentNodeData isShowChatRoomDisplayName];
            if (isShowChatRoomDisplayName) {
                spacingMultiplier = 2.0;
            }
        }
    }
    
    return spacingMultiplier;
}

static CGFloat calculateExtraSpacing(CMessageWrap *currentMsgWrap, CMessageWrap *nextMsgWrap, 
                                     BOOL isRoom, BOOL isSelfMessage, id currentNodeData,
                                     CGFloat originalHeight) {
    if (!nextMsgWrap) {
        return 0.0;
    }
    
    NSString *currentSender = getSenderFromMessageWrap(currentMsgWrap, isRoom);
    NSString *nextSender = getSenderFromMessageWrap(nextMsgWrap, isRoom);
    
    if (!currentSender || !nextSender || ![nextSender isEqualToString:currentSender]) {
        return 0.0;
    }
    
    CGFloat spacingMultiplier = calculateSpacingMultiplier(isRoom, isSelfMessage, currentNodeData);
    CGFloat extraSpacing = consecutiveMessagesSpacing * spacingMultiplier;
    
    if (extraSpacing < 0) {
        CGFloat minCellHeight = 20.0;
        CGFloat maxNegativeSpacing = originalHeight - minCellHeight;
        if (fabs(extraSpacing) > maxNegativeSpacing) {
            extraSpacing = -maxNegativeSpacing;
        }
    }
    
    return extraSpacing;
}

static BOOL isLongSplitMessage(id nodeData) {
    Class textMessageViewModelClass = NSClassFromString(@"TextMessageViewModel");
    if (!textMessageViewModelClass || ![nodeData isKindOfClass:textMessageViewModelClass]) {
        return NO;
    }
    
    SEL isLongSplitSelector = NSSelectorFromString(@"isLongSplitMessage");
    if (![nodeData respondsToSelector:isLongSplitSelector]) {
        return NO;
    }
    
    NSMethodSignature *signature = [nodeData methodSignatureForSelector:isLongSplitSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:nodeData];
    [invocation setSelector:isLongSplitSelector];
    [invocation invoke];
    
    BOOL result = NO;
    [invocation getReturnValue:&result];
    return result;
}

static NSInteger getNumberOfRowsInSection(id nodeData) {
    Class textMessageViewModelClass = NSClassFromString(@"TextMessageViewModel");
    if (!textMessageViewModelClass || ![nodeData isKindOfClass:textMessageViewModelClass]) {
        return 1;
    }
    
    SEL numberOfRowsSelector = NSSelectorFromString(@"numberOfRowsInSection");
    if (![nodeData respondsToSelector:numberOfRowsSelector]) {
        return 1;
    }
    
    NSMethodSignature *signature = [nodeData methodSignatureForSelector:numberOfRowsSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:nodeData];
    [invocation setSelector:numberOfRowsSelector];
    [invocation invoke];
    
    long long result = 1;
    [invocation getReturnValue:&result];
    return (NSInteger)result;
}

static NSMapTable *g_shouldHideHeadImageMap = nil;
static NSMapTable *g_shouldHideNameLabelMap = nil;
static dispatch_queue_t g_mergeMessagesQueue = nil;

static void initMergeMessagesDicts() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_shouldHideHeadImageMap = [NSMapTable weakToStrongObjectsMapTable];
        g_shouldHideNameLabelMap = [NSMapTable weakToStrongObjectsMapTable];
        g_mergeMessagesQueue = dispatch_queue_create("com.wechat.enhance.merge_messages", DISPATCH_QUEUE_SERIAL);
    });
}

%hook CommonMessageCellView

- (void)setViewModel:(id)viewModel {
    %orig;
    
    initMergeMessagesDicts();
    
    if (!isMergeMessagesEnabled || !viewModel) {
        return;
    }
    
    @try {
        CommonMessageViewModel *msgViewModel = (CommonMessageViewModel *)viewModel;
        
        if (![msgViewModel isShowHeadImage]) {
            return;
        }
        
        BaseMsgContentViewController *chatVC = findChatViewControllerFromResponder(self);
        if (!chatVC) {
            chatVC = findChatViewControllerFromWindow();
        }
        
        if (!chatVC) {
            return;
        }
        
        CContact *contact = [chatVC GetContact];
        if (!contact) {
            return;
        }
        
        BOOL isRoom = isChatRoom(contact);
        
        if (mergeMessagesScope == 1 && !isRoom) {
            return;
        }
        
        if (mergeMessagesScope == 2 && isRoom) {
            return;
        }
        
        CMessageWrap *currentMsgWrap = [msgViewModel messageWrap];
        if (!currentMsgWrap) {
            return;
        }
        
        NSString *currentSender = getSenderFromMessageWrap(currentMsgWrap, isRoom);
        if (!currentSender) {
            return;
        }
        
        NSMutableArray *messageArray = [chatVC GetMessageNodeDataArray];
        if (!messageArray || messageArray.count == 0) {
            return;
        }
        
        NSInteger currentIndex = findMessageIndexInArray(messageArray, currentMsgWrap);
        if (currentIndex < 0) {
            return;
        }
        
        BOOL shouldHideHeadImage = NO;
        BOOL shouldHideNameLabel = NO;
        
        if (mergeMessagesAvatarPosition == 1) {
            if (currentIndex < messageArray.count - 1) {
                CMessageWrap *nextMsgWrap = getMessageWrapFromNodeData(messageArray[currentIndex + 1]);
                if (nextMsgWrap) {
                    NSString *nextSender = getSenderFromMessageWrap(nextMsgWrap, isRoom);
                    if (nextSender && [nextSender isEqualToString:currentSender]) {
                        shouldHideHeadImage = YES;
                        shouldHideNameLabel = isRoom;
                    }
                }
            }
        } else if (mergeMessagesAvatarPosition == 2) {
            if (currentIndex > 0) {
                CMessageWrap *prevMsgWrap = getMessageWrapFromNodeData(messageArray[currentIndex - 1]);
                if (prevMsgWrap) {
                    NSString *prevSender = getSenderFromMessageWrap(prevMsgWrap, isRoom);
                    if (prevSender && [prevSender isEqualToString:currentSender]) {
                        shouldHideHeadImage = YES;
                        shouldHideNameLabel = isRoom;
                    }
                }
            }
        }
        
        dispatch_sync(g_mergeMessagesQueue, ^{
            if (shouldHideHeadImage) {
                [g_shouldHideHeadImageMap setObject:@(YES) forKey:self];
            } else {
                [g_shouldHideHeadImageMap removeObjectForKey:self];
            }
            
            if (shouldHideNameLabel) {
                [g_shouldHideNameLabelMap setObject:@(YES) forKey:self];
            } else {
                [g_shouldHideNameLabelMap removeObjectForKey:self];
            }
        });
        
        @try {
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            
            if (shouldHideHeadImage) {
                UIView *headImageView = [self getHeadImageView];
                if (headImageView && !headImageView.hidden) {
                    headImageView.hidden = YES;
                    headImageView.alpha = 0.0;
                }
            }
            
            if (shouldHideNameLabel) {
                Ivar nameLabelIvar = class_getInstanceVariable([self class], "m_chatRoomNameLabel");
                if (nameLabelIvar) {
                    UILabel *nameLabel = object_getIvar(self, nameLabelIvar);
                    if (nameLabel && !nameLabel.hidden) {
                        nameLabel.hidden = YES;
                        nameLabel.alpha = 0.0;
                    }
                }
            }
            
            [CATransaction commit];
        } @catch (NSException *exception) {
            [CATransaction commit];
            NSLog(@"[MergeMessages] setViewModel hide exception: %@", exception);
        }
        
    } @catch (NSException *exception) {
        NSLog(@"[MergeMessages] 处理合并消息时发生异常: %@", exception);
    }
}

- (void)layoutSubviews {
    %orig;
    
    if (!isMergeMessagesEnabled) {
        return;
    }
    
    initMergeMessagesDicts();
    
    __block BOOL shouldHideHeadImage = NO;
    __block BOOL shouldHideNameLabel = NO;
    
    dispatch_sync(g_mergeMessagesQueue, ^{
        shouldHideHeadImage = [[g_shouldHideHeadImageMap objectForKey:self] boolValue];
        shouldHideNameLabel = [[g_shouldHideNameLabelMap objectForKey:self] boolValue];
    });
    
    if (shouldHideHeadImage || shouldHideNameLabel) {
        @try {
            if (shouldHideHeadImage) {
                UIView *headImageView = [self getHeadImageView];
                if (headImageView) {
                    headImageView.hidden = YES;
                    headImageView.alpha = 0.0;
                }
            }
            
            if (shouldHideNameLabel) {
                Ivar nameLabelIvar = class_getInstanceVariable([self class], "m_chatRoomNameLabel");
                if (nameLabelIvar) {
                    UILabel *nameLabel = object_getIvar(self, nameLabelIvar);
                    if (nameLabel) {
                        nameLabel.hidden = YES;
                        nameLabel.alpha = 0.0;
                    }
                }
            }
        } @catch (NSException *exception) {
            NSLog(@"[MergeMessages] layoutSubviews exception: %@", exception);
        }
    }
}

- (void)prepareForReuse {
    %orig;
    
    initMergeMessagesDicts();
    
    dispatch_sync(g_mergeMessagesQueue, ^{
        [g_shouldHideHeadImageMap removeObjectForKey:self];
        [g_shouldHideNameLabelMap removeObjectForKey:self];
    });
    
    @try {
        UIView *headImageView = [self getHeadImageView];
        if (headImageView) {
            headImageView.hidden = NO;
            headImageView.alpha = 1.0;
        }
        
        Ivar nameLabelIvar = class_getInstanceVariable([self class], "m_chatRoomNameLabel");
        if (nameLabelIvar) {
            UILabel *nameLabel = object_getIvar(self, nameLabelIvar);
            if (nameLabel) {
                nameLabel.hidden = NO;
                nameLabel.alpha = 1.0;
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"[MergeMessages] prepareForReuse exception: %@", exception);
    }
}

%end

%hook BaseMsgContentViewController

- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat originalHeight = %orig;
    
    if (!isMergeMessagesEnabled) {
        return originalHeight;
    }
    
    NSMutableArray *messageArray = [self GetMessageNodeDataArray];
    if (!messageArray || indexPath.section >= messageArray.count) {
        return originalHeight;
    }
    
    CContact *contact = [self GetContact];
    if (!contact) {
        return originalHeight;
    }
    
    BOOL isRoom = isChatRoom(contact);
    
    if (mergeMessagesScope == 1 && !isRoom) {
        return originalHeight;
    }
    
    if (mergeMessagesScope == 2 && isRoom) {
        return originalHeight;
    }
    
    id currentNodeData = messageArray[indexPath.section];
    
    if ([currentNodeData isKindOfClass:NSClassFromString(@"ChatTimeViewModel")]) {
        return originalHeight;
    }
    
    CMessageWrap *currentMsgWrap = getMessageWrapFromNodeData(currentNodeData);
    if (!currentMsgWrap) {
        return originalHeight;
    }
    
    if (isLongSplitMessage(currentNodeData)) {
        NSInteger numberOfRows = getNumberOfRowsInSection(currentNodeData);
        if (indexPath.row < numberOfRows - 1) {
            return originalHeight;
        }
    }
    
    BOOL isSelfMessage = NO;
    if (isRoom) {
        NSString *realChatUsr = currentMsgWrap.m_nsRealChatUsr;
        isSelfMessage = (!realChatUsr || realChatUsr.length == 0);
    } else {
        Class settingUtilClass = NSClassFromString(@"SettingUtil");
        if (settingUtilClass) {
            NSString *currentUser = [settingUtilClass getCurUsrName];
            NSString *currentSender = currentMsgWrap.m_nsFromUsr;
            isSelfMessage = [currentSender isEqualToString:currentUser];
        }
    }
    
    CGFloat extraSpacing = 0.0;
    
    if (indexPath.section < messageArray.count - 1) {
        id nextNodeData = messageArray[indexPath.section + 1];
        
        if (![nextNodeData isKindOfClass:NSClassFromString(@"ChatTimeViewModel")]) {
            CMessageWrap *nextMsgWrap = getMessageWrapFromNodeData(nextNodeData);
            extraSpacing = calculateExtraSpacing(currentMsgWrap, nextMsgWrap, isRoom, isSelfMessage, 
                                                 currentNodeData, originalHeight);
        }
    }
    
    CGFloat finalHeight = originalHeight + extraSpacing;
    
    if (finalHeight < 20.0) {
        finalHeight = 20.0;
    }
    
    return finalHeight;
}

%end

// 🔥 彻底删除所有背景视图Hook，从根源解决双气泡问题！