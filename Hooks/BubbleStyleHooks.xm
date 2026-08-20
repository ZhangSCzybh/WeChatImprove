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

static NSMutableDictionary *g_shouldHideHeadImageDict = nil;
static NSMutableDictionary *g_shouldHideNameLabelDict = nil;

static void initMergeMessagesDicts() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_shouldHideHeadImageDict = [NSMutableDictionary dictionary];
        g_shouldHideNameLabelDict = [NSMutableDictionary dictionary];
    });
}

%hook CommonMessageCellView

- (void)setViewModel:(id)viewModel {
    %orig;
    
    NSLog(@"[MergeMessages] setViewModel called, enabled: %d, viewModel: %@", isMergeMessagesEnabled, viewModel);
    
    initMergeMessagesDicts();
    
    if (!isMergeMessagesEnabled || !viewModel) {
        NSLog(@"[MergeMessages] Early return: enabled=%d, viewModel=%@", isMergeMessagesEnabled, viewModel);
        return;
    }
    
    @try {
        CommonMessageViewModel *msgViewModel = (CommonMessageViewModel *)viewModel;
        
        BOOL isShowHeadImage = [msgViewModel isShowHeadImage];
        NSLog(@"[MergeMessages] isShowHeadImage: %d", isShowHeadImage);
        
        if (!isShowHeadImage) {
            return;
        }
        
        BaseMsgContentViewController *chatVC = nil;
        
        UIResponder *responder = self;
        while ((responder = [responder nextResponder])) {
            if ([responder isKindOfClass:NSClassFromString(@"BaseMsgContentViewController")]) {
                chatVC = (BaseMsgContentViewController *)responder;
                break;
            }
        }
        
        NSLog(@"[MergeMessages] chatVC from responder chain: %@", chatVC);
        
        if (!chatVC) {
            UIViewController *topVC = nil;
            for (UIWindow *window in [UIApplication sharedApplication].windows) {
                if (window.isKeyWindow) {
                    topVC = window.rootViewController;
                    break;
                }
            }
            
            while (topVC.presentedViewController) {
                topVC = topVC.presentedViewController;
            }
            
            NSLog(@"[MergeMessages] topVC class: %@", NSStringFromClass([topVC class]));
            
            if ([topVC isKindOfClass:NSClassFromString(@"MainTabBarViewController")]) {
                UIViewController *selectedVC = [(UITabBarController *)topVC selectedViewController];
                NSLog(@"[MergeMessages] selectedVC class: %@", NSStringFromClass([selectedVC class]));
                
                if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                    UIViewController *navTopVC = [(UINavigationController *)selectedVC topViewController];
                    NSLog(@"[MergeMessages] navTopVC class: %@", NSStringFromClass([navTopVC class]));
                    
                    if ([navTopVC isKindOfClass:NSClassFromString(@"BaseMsgContentViewController")]) {
                        chatVC = (BaseMsgContentViewController *)navTopVC;
                    }
                }
            }
        }
        
        NSLog(@"[MergeMessages] final chatVC: %@", chatVC);
        
        if (!chatVC) {
            NSLog(@"[MergeMessages] No BaseMsgContentViewController found");
            return;
        }
        
        CContact *contact = [chatVC GetContact];
        
        NSLog(@"[MergeMessages] contact: %@", contact);
        
        if (!contact) {
            return;
        }
        
        BOOL isRoom = isChatRoom(contact);
        NSLog(@"[MergeMessages] isRoom: %d, scope: %ld", isRoom, (long)mergeMessagesScope);
        
        if (mergeMessagesScope == 1 && !isRoom) {
            NSLog(@"[MergeMessages] Scope mismatch: group only but not group");
            return;
        }
        
        if (mergeMessagesScope == 2 && isRoom) {
            NSLog(@"[MergeMessages] Scope mismatch: private only but is group");
            return;
        }
        
        CMessageWrap *currentMsgWrap = [msgViewModel messageWrap];
        NSLog(@"[MergeMessages] currentMsgWrap: %@", currentMsgWrap);
        
        if (!currentMsgWrap) {
            return;
        }
        
        NSString *currentSender = nil;
        if (isRoom) {
            currentSender = currentMsgWrap.m_nsRealChatUsr;
            if (!currentSender || currentSender.length == 0) {
                currentSender = currentMsgWrap.m_nsFromUsr;
            }
            NSLog(@"[MergeMessages] Group chat - using sender: %@", currentSender);
        } else {
            currentSender = currentMsgWrap.m_nsFromUsr;
            NSLog(@"[MergeMessages] Private chat - using m_nsFromUsr: %@", currentSender);
        }
        
        if (!currentSender) {
            return;
        }
        
        NSMutableArray *messageArray = [chatVC GetMessageNodeDataArray];
        NSLog(@"[MergeMessages] messageArray: %@, count: %ld", messageArray, messageArray ? (long)messageArray.count : 0);
        
        if (!messageArray || messageArray.count == 0) {
            return;
        }
        
        NSInteger currentIndex = -1;
        for (NSInteger i = 0; i < messageArray.count; i++) {
            id nodeData = messageArray[i];
            CMessageWrap *msgWrap = getMessageWrapFromNodeData(nodeData);
            if (msgWrap && msgWrap == currentMsgWrap) {
                currentIndex = i;
                NSLog(@"[MergeMessages] Found current message at index: %ld", (long)currentIndex);
                break;
            }
        }
        
        if (currentIndex < 0) {
            NSLog(@"[MergeMessages] Current message not found in array");
            return;
        }
        
        BOOL shouldHideHeadImage = NO;
        BOOL shouldHideNameLabel = NO;
        
        if (mergeMessagesAvatarPosition == 1) {
            if (currentIndex < messageArray.count - 1) {
                id nextNodeData = messageArray[currentIndex + 1];
                CMessageWrap *nextMsgWrap = getMessageWrapFromNodeData(nextNodeData);
                NSLog(@"[MergeMessages] nextMsgWrap: %@", nextMsgWrap);
                
                if (nextMsgWrap) {
                    NSString *nextSender = nil;
                    if (isRoom) {
                        nextSender = nextMsgWrap.m_nsRealChatUsr;
                        if (!nextSender || nextSender.length == 0) {
                            nextSender = nextMsgWrap.m_nsFromUsr;
                        }
                    } else {
                        nextSender = nextMsgWrap.m_nsFromUsr;
                    }
                    NSLog(@"[MergeMessages] nextSender: %@, currentSender: %@", nextSender, currentSender);
                    
                    if (nextSender && [nextSender isEqualToString:currentSender]) {
                        shouldHideHeadImage = YES;
                        shouldHideNameLabel = isRoom;
                        NSLog(@"[MergeMessages] Same sender detected (last message mode), hiding head image and name label");
                    }
                }
            } else {
                NSLog(@"[MergeMessages] Current message is the last one, showing head image");
            }
        } else if (mergeMessagesAvatarPosition == 2) {
            if (currentIndex > 0) {
                id prevNodeData = messageArray[currentIndex - 1];
                CMessageWrap *prevMsgWrap = getMessageWrapFromNodeData(prevNodeData);
                NSLog(@"[MergeMessages] prevMsgWrap: %@", prevMsgWrap);
                
                if (prevMsgWrap) {
                    NSString *prevSender = nil;
                    if (isRoom) {
                        prevSender = prevMsgWrap.m_nsRealChatUsr;
                        if (!prevSender || prevSender.length == 0) {
                            prevSender = prevMsgWrap.m_nsFromUsr;
                        }
                    } else {
                        prevSender = prevMsgWrap.m_nsFromUsr;
                    }
                    NSLog(@"[MergeMessages] prevSender: %@, currentSender: %@", prevSender, currentSender);
                    
                    if (prevSender && [prevSender isEqualToString:currentSender]) {
                        shouldHideHeadImage = YES;
                        shouldHideNameLabel = isRoom;
                        NSLog(@"[MergeMessages] Same sender detected (first message mode), hiding head image and name label");
                    }
                }
            } else {
                NSLog(@"[MergeMessages] Current message is the first one, showing head image");
            }
        }
        
        NSString *cellKey = [NSString stringWithFormat:@"%p", self];
        if (shouldHideHeadImage) {
            g_shouldHideHeadImageDict[cellKey] = @(YES);
        } else {
            [g_shouldHideHeadImageDict removeObjectForKey:cellKey];
        }
        
        if (shouldHideNameLabel) {
            g_shouldHideNameLabelDict[cellKey] = @(YES);
        } else {
            [g_shouldHideNameLabelDict removeObjectForKey:cellKey];
        }
        
        NSLog(@"[MergeMessages] Saved hide state - headImage: %d, nameLabel: %d", shouldHideHeadImage, shouldHideNameLabel);
        
        @try {
            if (shouldHideHeadImage) {
                UIView *headImageView = [self getHeadImageView];
                if (headImageView) {
                    headImageView.hidden = YES;
                    headImageView.alpha = 0.0;
                    NSLog(@"[MergeMessages] setViewModel - Head image hidden immediately");
                }
            }
            
            if (shouldHideNameLabel) {
                Ivar nameLabelIvar = class_getInstanceVariable([self class], "m_chatRoomNameLabel");
                if (nameLabelIvar) {
                    UILabel *nameLabel = object_getIvar(self, nameLabelIvar);
                    if (nameLabel) {
                        nameLabel.hidden = YES;
                        nameLabel.alpha = 0.0;
                        NSLog(@"[MergeMessages] setViewModel - Name label hidden immediately");
                    }
                }
            }
        } @catch (NSException *exception) {
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
    
    NSString *cellKey = [NSString stringWithFormat:@"%p", self];
    
    BOOL shouldHideHeadImage = [g_shouldHideHeadImageDict[cellKey] boolValue];
    BOOL shouldHideNameLabel = [g_shouldHideNameLabelDict[cellKey] boolValue];
    
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
    
    NSString *cellKey = [NSString stringWithFormat:@"%p", self];
    [g_shouldHideHeadImageDict removeObjectForKey:cellKey];
    [g_shouldHideNameLabelDict removeObjectForKey:cellKey];
    
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
    
    BOOL isCurrentLongSplit = NO;
    NSInteger numberOfRows = 1;
    Class textMessageViewModelClass = NSClassFromString(@"TextMessageViewModel");
    if (textMessageViewModelClass && [currentNodeData isKindOfClass:textMessageViewModelClass]) {
        SEL isLongSplitSelector = NSSelectorFromString(@"isLongSplitMessage");
        if ([currentNodeData respondsToSelector:isLongSplitSelector]) {
            NSMethodSignature *signature = [currentNodeData methodSignatureForSelector:isLongSplitSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:currentNodeData];
            [invocation setSelector:isLongSplitSelector];
            [invocation invoke];
            [invocation getReturnValue:&isCurrentLongSplit];
        }
        
        SEL numberOfRowsSelector = NSSelectorFromString(@"numberOfRowsInSection");
        if ([currentNodeData respondsToSelector:numberOfRowsSelector]) {
            NSMethodSignature *signature = [currentNodeData methodSignatureForSelector:numberOfRowsSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:currentNodeData];
            [invocation setSelector:numberOfRowsSelector];
            [invocation invoke];
            long long result = 0;
            [invocation getReturnValue:&result];
            numberOfRows = result;
        }
    }
    
    if (isCurrentLongSplit && indexPath.row < numberOfRows - 1) {
        return originalHeight;
    }
    
    NSString *currentSender = nil;
    BOOL isSelfMessage = NO;
    
    if (isRoom) {
        NSString *realChatUsr = currentMsgWrap.m_nsRealChatUsr;
        if (!realChatUsr || realChatUsr.length == 0) {
            currentSender = currentMsgWrap.m_nsFromUsr;
            isSelfMessage = YES;
        } else {
            currentSender = realChatUsr;
            isSelfMessage = NO;
        }
    } else {
        currentSender = currentMsgWrap.m_nsFromUsr;
        Class settingUtilClass = NSClassFromString(@"SettingUtil");
        if (settingUtilClass) {
            NSString *currentUser = [settingUtilClass getCurUsrName];
            isSelfMessage = [currentSender isEqualToString:currentUser];
        }
    }
    
    if (!currentSender) {
        return originalHeight;
    }
    
    CGFloat extraSpacing = 0.0;
    
    if (indexPath.section < messageArray.count - 1) {
        id nextNodeData = messageArray[indexPath.section + 1];
        
        if (![nextNodeData isKindOfClass:NSClassFromString(@"ChatTimeViewModel")]) {
            CMessageWrap *nextMsgWrap = getMessageWrapFromNodeData(nextNodeData);
            
            if (nextMsgWrap) {
                NSString *nextSender = nil;
                if (isRoom) {
                    nextSender = nextMsgWrap.m_nsRealChatUsr;
                    if (!nextSender || nextSender.length == 0) {
                        nextSender = nextMsgWrap.m_nsFromUsr;
                    }
                } else {
                    nextSender = nextMsgWrap.m_nsFromUsr;
                }
                
                if (nextSender && [nextSender isEqualToString:currentSender]) {
                    CGFloat spacingMultiplier = 1.0;
                    
                    if (isRoom && !isSelfMessage) {
                        BOOL isShowChatRoomDisplayName = NO;
                        Class commonMessageViewModelClass = NSClassFromString(@"CommonMessageViewModel");
                        if (commonMessageViewModelClass && [currentNodeData isKindOfClass:commonMessageViewModelClass]) {
                            isShowChatRoomDisplayName = [(CommonMessageViewModel *)currentNodeData isShowChatRoomDisplayName];
                        }
                        
                        if (isShowChatRoomDisplayName) {
                            spacingMultiplier = 2.0;
                        }
                    }
                    
                    extraSpacing = consecutiveMessagesSpacing * spacingMultiplier;
                }
            }
        }
    }
    
    return originalHeight + extraSpacing;
}

%end

// 🔥 彻底删除所有背景视图Hook，从根源解决双气泡问题！