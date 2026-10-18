// 布局和字体设置Hook
// 实现聊天界面字体大小和全局缩放控制

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSString * const kPreferencesSuiteName = @"com.wechat.enhance";
static NSString * const kChatFontSizeKey = @"font.chat_size";
static NSString * const kGlobalScaleKey = @"global.scale";

static const CGFloat kMinChatFontSize = 8.0;
static const CGFloat kMaxChatFontSize = 25.0;
static const CGFloat kDefaultChatFontSize = 17.0;

static const CGFloat kMinGlobalScale = 0.5;
static const CGFloat kMaxGlobalScale = 2.0;
static const CGFloat kDefaultGlobalScale = 1.0;

static NSUserDefaults *getDefaults() {
    static NSUserDefaults *defaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[NSUserDefaults alloc] initWithSuiteName:kPreferencesSuiteName];
    });
    return defaults;
}

static CGFloat getChatFontSize() {
    NSUserDefaults *defaults = getDefaults();
    CGFloat size = [defaults floatForKey:kChatFontSizeKey];
    if (size < kMinChatFontSize || size > kMaxChatFontSize) {
        return kDefaultChatFontSize;
    }
    return size;
}

static CGFloat getGlobalScale() {
    NSUserDefaults *defaults = getDefaults();
    CGFloat scale = [defaults floatForKey:kGlobalScaleKey];
    if (scale < kMinGlobalScale || scale > kMaxGlobalScale) {
        return kDefaultGlobalScale;
    }
    return scale;
}

@interface UIFont (PreHot)
+ (double)getNormalFontSizeByLevel:(unsigned int)arg1;
+ (double)getNormalFontSizeByLevelForChatOrTimeline:(unsigned int)arg1;
+ (double)getNormalFontSizeByDefaultLevel;
+ (double)getNormalFontSize;
+ (double)dynamicScale;
+ (double)dynamicScaleWithModule:(int)arg1;
+ (double)dynamicFontSize:(double)arg1;
+ (double)dynamicFontSize:(double)arg1 forModule:(int)arg2;
+ (double)dynamicFontSizeForNavigator:(double)arg1;
+ (double)dynamicCellHeight:(double)arg1;
+ (double)dynamicLength:(double)arg1;
+ (double)dynamicLength:(double)arg1 forModule:(int)arg2;
+ (double)dynamicLengthForNavigator:(double)arg1;
+ (unsigned int)globalFontLevel;
@end

@interface WAUtility : NSObject
+ (double)fontDynamicScale;
@end

@interface CLocalInfo : NSObject
@property(nonatomic) unsigned int m_uiFontLevel;
@property(nonatomic) unsigned int m_uiGlobalFontLevel;
@end

@interface LocalInfoMgr : NSObject
@property(readonly, nonatomic) CLocalInfo *localInfo;
+ (instancetype)sharedInstance;
@end

@interface SessionCellLayoutParam : NSObject
@property(nonatomic) double cellHeight;
@property(nonatomic) double headImgLeftMargin;
@property(nonatomic) double headImgTopMargin;
@property(nonatomic) double nameLabelTopMargin;
@property(nonatomic) double nameLabelBottomMargin;
@property(nonatomic) double nameLabelLeftMargin;
@property(nonatomic) double nameLabelHeight;
@property(nonatomic) double statusImgRightMargin;
@property(nonatomic) double timeLabelRightMargin;
@property(nonatomic) double chatNotPushViewRightMargin;
@property(nonatomic) struct CGSize headImgSize;
+ (id)defaultSessionCellLayoutParam;
+ (id)layoutParamForCellStyle:(id)arg1 expectedHeight:(double)arg2;
+ (id)layoutParamForCellStyle:(id)arg1;
@end

static CGFloat fontSizeToLevel(CGFloat fontSize) {
    if (fontSize <= 10.0) return 1;
    if (fontSize <= 12.0) return 2;
    if (fontSize <= 14.0) return 3;
    if (fontSize <= 15.0) return 4;
    if (fontSize <= 17.0) return 5;
    if (fontSize <= 18.0) return 6;
    if (fontSize <= 20.0) return 7;
    if (fontSize <= 22.0) return 8;
    if (fontSize <= 24.0) return 9;
    return 10;
}

static void applyGlobalScale(SessionCellLayoutParam *layoutParam, CGFloat scale) {
    if (!layoutParam || scale == 1.0) return;
    
    @try {
        layoutParam.cellHeight *= scale;
        layoutParam.headImgLeftMargin *= scale;
        layoutParam.headImgTopMargin *= scale;
        layoutParam.nameLabelTopMargin *= scale;
        layoutParam.nameLabelBottomMargin *= scale;
        layoutParam.nameLabelLeftMargin *= scale;
        layoutParam.nameLabelHeight *= scale;
        layoutParam.statusImgRightMargin *= scale;
        layoutParam.timeLabelRightMargin *= scale;
        layoutParam.chatNotPushViewRightMargin *= scale;
        
        CGSize size = layoutParam.headImgSize;
        size.width *= scale;
        size.height *= scale;
        layoutParam.headImgSize = size;
    } @catch (NSException *e) {
        NSLog(@"[LayoutHooks] 应用全局缩放失败: %@", e);
    }
}

%hook UIFont

+ (double)getNormalFontSizeByLevelForChatOrTimeline:(unsigned int)arg1 {
    CGFloat chatFontSize = getChatFontSize();
    if (chatFontSize != kDefaultChatFontSize) {
        return chatFontSize;
    }
    return %orig(arg1);
}

+ (double)dynamicScale {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return globalScale;
    }
    return %orig;
}

+ (double)dynamicScaleWithModule:(int)arg1 {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return globalScale;
    }
    return %orig(arg1);
}

+ (double)dynamicFontSize:(double)arg1 {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return arg1 * globalScale;
    }
    return %orig(arg1);
}

+ (double)dynamicFontSize:(double)arg1 forModule:(int)arg2 {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return arg1 * globalScale;
    }
    return %orig(arg1, arg2);
}

+ (double)dynamicFontSizeForNavigator:(double)arg1 {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return arg1 * globalScale;
    }
    return %orig(arg1);
}

+ (double)dynamicCellHeight:(double)arg1 {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return arg1 * globalScale;
    }
    return %orig(arg1);
}

+ (double)dynamicLength:(double)arg1 {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return arg1 * globalScale;
    }
    return %orig(arg1);
}

+ (double)dynamicLength:(double)arg1 forModule:(int)arg2 {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return arg1 * globalScale;
    }
    return %orig(arg1, arg2);
}

+ (double)dynamicLengthForNavigator:(double)arg1 {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return arg1 * globalScale;
    }
    return %orig(arg1);
}

%end

%hook WAUtility

+ (double)fontDynamicScale {
    CGFloat globalScale = getGlobalScale();
    if (globalScale != kDefaultGlobalScale) {
        return globalScale;
    }
    return %orig;
}

%end

%hook CLocalInfo

- (unsigned int)m_uiFontLevel {
    CGFloat chatFontSize = getChatFontSize();
    if (chatFontSize != kDefaultChatFontSize) {
        return fontSizeToLevel(chatFontSize);
    }
    return %orig;
}

%end

%hook SessionCellLayoutParam

+ (id)defaultSessionCellLayoutParam {
    id result = %orig;
    
    if (result) {
        CGFloat scale = getGlobalScale();
        applyGlobalScale(result, scale);
    }
    
    return result;
}

+ (id)layoutParamForCellStyle:(id)arg1 expectedHeight:(double)arg2 {
    id result = %orig;
    
    if (result) {
        CGFloat scale = getGlobalScale();
        applyGlobalScale(result, scale);
    }
    
    return result;
}

+ (id)layoutParamForCellStyle:(id)arg1 {
    id result = %orig;
    
    if (result) {
        CGFloat scale = getGlobalScale();
        applyGlobalScale(result, scale);
    }
    
    return result;
}

%end

// Layout getters read the current shared preferences directly. There is no
// cache to invalidate and no observer that republishes its own notification.
