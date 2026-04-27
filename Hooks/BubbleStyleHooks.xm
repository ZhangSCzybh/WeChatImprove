// 气泡样式Hook - 最终完美版 | 无双重气泡 | 长文本无残留 | 用户自定义圆角 | 文本自适应
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <substrate.h>

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

static BOOL isBubbleStyleEnabled = NO;
static CGFloat customCornerRadius = 16.0f;
static UIColor *senderLightColor = nil;
static UIColor *receiverLightColor = nil;
static UIColor *senderDarkColor = nil;
static UIColor *receiverDarkColor = nil;

@interface BubbleInfo : NSObject
@property(nonatomic, assign) unsigned long long position;
@property(retain, nonatomic) NSString *bubbleName;
- (id)getBubbleImage:(BOOL)arg1 isDarkMode:(BOOL)arg2 useCache:(BOOL)arg3;
@end

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
    
    NSLog(@"[BubbleStyle] 设置已加载 - 启用: %@, 圆角: %.1f", 
          isBubbleStyleEnabled ? @"是" : @"否", customCornerRadius);
}

// 绘制气泡（根据position绘制不同样式的圆角）
static UIImage *createBubbleImage(CGSize size, unsigned long long position, BOOL isSender, BOOL isDarkMode) {
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
    
    if (isSender) {
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
    
    UIImage *customBubble = createBubbleImage(originalImage.size, self.position, isSender, arg2);
    if (customBubble) {
        return customBubble;
    } else {
        return originalImage;
    }
}
%end

// 🔥 彻底删除所有背景视图Hook，从根源解决双气泡问题！