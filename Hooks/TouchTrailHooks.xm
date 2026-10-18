#import <UIKit/UIKit.h>
#import "../Controllers/CSPreferenceRefresh.h"
#import "../Controllers/CSTouchTrailPolicy.h"

// 触摸轨迹设置的键
static NSString * const kTouchTrailKey = @"com.wechat.tweak.touch.trail.enabled";
static NSString * const kTouchTrailColorRedKey = @"com.wechat.tweak.touch.trail.color.red";
static NSString * const kTouchTrailColorGreenKey = @"com.wechat.tweak.touch.trail.color.green";
static NSString * const kTouchTrailColorBlueKey = @"com.wechat.tweak.touch.trail.color.blue";
static NSString * const kTouchTrailColorAlphaKey = @"com.wechat.tweak.touch.trail.color.alpha";
static NSString * const kTouchTrailSizeKey = @"com.wechat.tweak.touch.trail.size";
static NSString * const kTouchTrailOnlyWhenRecordingKey = @"com.wechat.tweak.touch.trail.only.when.recording";
static NSString * const kTouchTrailDisplayStateKey = @"com.wechat.tweak.touch.trail.display.state";
// 触摸点边框相关设置
static NSString * const kTouchTrailBorderEnabledKey = @"com.wechat.tweak.touch.trail.border.enabled";
static NSString * const kTouchTrailBorderColorRedKey = @"com.wechat.tweak.touch.trail.border.color.red";
static NSString * const kTouchTrailBorderColorGreenKey = @"com.wechat.tweak.touch.trail.border.color.green";
static NSString * const kTouchTrailBorderColorBlueKey = @"com.wechat.tweak.touch.trail.border.color.blue";
static NSString * const kTouchTrailBorderColorAlphaKey = @"com.wechat.tweak.touch.trail.border.color.alpha";
static NSString * const kTouchTrailBorderWidthKey = @"com.wechat.tweak.touch.trail.border.width";
// 拖尾效果设置
static NSString * const kTouchTrailTailEnabledKey = @"com.wechat.tweak.touch.trail.tail.enabled";
// 拖尾密度和持续时间设置
static NSString * const kTouchTrailTailDensityKey = @"com.wechat.tweak.touch.trail.tail.density";
static NSString * const kTouchTrailTailDurationKey = @"com.wechat.tweak.touch.trail.tail.duration";
// 自定义图片轨迹设置键
static NSString * const kTouchTrailCustomImageEnabledKey = @"com.wechat.tweak.touch.trail.custom.image.enabled";
static NSString * const kTouchTrailCustomImagePathKey = @"com.wechat.tweak.touch.trail.custom.image.path";
// 自定义圆角程度设置键
static NSString * const kTouchTrailCustomImageCornerRadiusKey = @"com.wechat.tweak.touch.trail.custom.image.corner.radius";

// 触摸轨迹视图类
@interface WBTouchTrailView : UIView
@property(nonatomic) NSTimeInterval lastMoveTime;
@property(nonatomic) CGPoint lastMovePoint;
@property (nonatomic, strong) UIColor *trailColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat trailSize;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) BOOL hasBorder;
@property (nonatomic, assign) BOOL isMoving; // 新增属性，标记是否处于移动状态
@property (nonatomic, strong) UIImageView *customImageView; // 自定义图片视图
@property (nonatomic, assign) BOOL useCustomImage; // 是否使用自定义图片
@property (nonatomic, assign) CGFloat cornerRadiusRatio; // 圆角比例，0-1之间
- (void)updateWithPoint:(CGPoint)point;
- (void)updateWithPoint:(CGPoint)point isMoving:(BOOL)isMoving;
@end

// 触摸轨迹拖尾点视图类 - 用于显示轨迹上的每个点
@interface WBTouchTrailDotView : UIView
@property (nonatomic, strong) UIColor *dotColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat dotSize;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) BOOL hasBorder;
@property (nonatomic, strong) UIImageView *customImageView; // 自定义图片视图
@property (nonatomic, assign) BOOL useCustomImage; // 是否使用自定义图片
@property (nonatomic, assign) CGFloat cornerRadiusRatio; // 圆角比例，0-1之间
- (instancetype)initWithPoint:(CGPoint)point 
                     dotColor:(UIColor *)dotColor 
                  borderColor:(UIColor *)borderColor 
                     dotSize:(CGFloat)dotSize 
                 borderWidth:(CGFloat)borderWidth 
                   hasBorder:(BOOL)hasBorder
                    duration:(CGFloat)duration;
- (instancetype)initWithPoint:(CGPoint)point 
                     dotColor:(UIColor *)dotColor 
                  borderColor:(UIColor *)borderColor 
                     dotSize:(CGFloat)dotSize 
                 borderWidth:(CGFloat)borderWidth 
                   hasBorder:(BOOL)hasBorder
                    duration:(CGFloat)duration
                useCustomImage:(BOOL)useCustomImage
                  customImage:(UIImage *)customImage;
- (instancetype)initWithPoint:(CGPoint)point 
                     dotColor:(UIColor *)dotColor 
                  borderColor:(UIColor *)borderColor 
                     dotSize:(CGFloat)dotSize 
                 borderWidth:(CGFloat)borderWidth 
                   hasBorder:(BOOL)hasBorder
                    duration:(CGFloat)duration
                useCustomImage:(BOOL)useCustomImage
                  customImage:(UIImage *)customImage
             cornerRadiusRatio:(CGFloat)cornerRadiusRatio;
@end

@implementation WBTouchTrailDotView

- (instancetype)initWithPoint:(CGPoint)point 
                     dotColor:(UIColor *)dotColor 
                  borderColor:(UIColor *)borderColor 
                     dotSize:(CGFloat)dotSize 
                 borderWidth:(CGFloat)borderWidth 
                   hasBorder:(BOOL)hasBorder
                    duration:(CGFloat)duration {
    return [self initWithPoint:point
                      dotColor:dotColor
                   borderColor:borderColor
                       dotSize:dotSize
                   borderWidth:borderWidth
                     hasBorder:hasBorder
                      duration:duration
                useCustomImage:NO
                   customImage:nil
              cornerRadiusRatio:1.0]; // 默认圆形
}

- (instancetype)initWithPoint:(CGPoint)point 
                     dotColor:(UIColor *)dotColor 
                  borderColor:(UIColor *)borderColor 
                     dotSize:(CGFloat)dotSize 
                 borderWidth:(CGFloat)borderWidth 
                   hasBorder:(BOOL)hasBorder
                    duration:(CGFloat)duration
               useCustomImage:(BOOL)useCustomImage
                 customImage:(UIImage *)customImage {
    return [self initWithPoint:point
                      dotColor:dotColor
                   borderColor:borderColor
                       dotSize:dotSize
                   borderWidth:borderWidth
                     hasBorder:hasBorder
                      duration:duration
                useCustomImage:useCustomImage
                   customImage:customImage
              cornerRadiusRatio:0.5]; // 默认中等圆角
}

- (instancetype)initWithPoint:(CGPoint)point 
                     dotColor:(UIColor *)dotColor 
                  borderColor:(UIColor *)borderColor 
                     dotSize:(CGFloat)dotSize 
                 borderWidth:(CGFloat)borderWidth 
                   hasBorder:(BOOL)hasBorder
                    duration:(CGFloat)duration
               useCustomImage:(BOOL)useCustomImage
                 customImage:(UIImage *)customImage
            cornerRadiusRatio:(CGFloat)cornerRadiusRatio {
    CGRect frame = CGRectMake(point.x - dotSize/2, point.y - dotSize/2, dotSize, dotSize);
    self = [super initWithFrame:frame];
    if (self) {
        self.dotColor = dotColor;
        self.borderColor = borderColor;
        self.dotSize = dotSize;
        self.borderWidth = borderWidth;
        self.hasBorder = hasBorder;
        self.useCustomImage = useCustomImage;
        self.cornerRadiusRatio = cornerRadiusRatio;
        self.userInteractionEnabled = NO;
        
        if (useCustomImage) {
            // 使用自定义图片
            self.backgroundColor = [UIColor clearColor];
            
            // 创建自定义图片视图
            self.customImageView = [[UIImageView alloc] initWithFrame:self.bounds];
            self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.customImageView.image = customImage;
            [self addSubview:self.customImageView];
            
            // 根据cornerRadiusRatio计算圆角半径
            CGFloat maxRadius = dotSize / 2;
            CGFloat radius = maxRadius * cornerRadiusRatio;
            self.customImageView.layer.cornerRadius = radius;
            self.customImageView.clipsToBounds = YES;
            
            // 设置边框
            if (hasBorder) {
                self.customImageView.layer.borderWidth = borderWidth;
                self.customImageView.layer.borderColor = borderColor.CGColor;
            }
        } else {
            // 使用默认圆形
            self.backgroundColor = dotColor;
            self.layer.cornerRadius = dotSize / 2;
            
            // 设置边框
            if (hasBorder) {
                self.layer.borderWidth = borderWidth;
                self.layer.borderColor = borderColor.CGColor;
            }
        }
        
        // 随时间淡出效果，根据设置的持续时间调整
        self.alpha = 0.7;
        [UIView animateWithDuration:duration animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    return self;
}

@end

@implementation WBTouchTrailView

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        self.trailColor = [UIColor redColor]; // 默认红色
        self.borderColor = [UIColor whiteColor]; // 默认白色边框
        self.trailSize = 20.0; // 默认20.0点大小
        self.borderWidth = 1.0; // 默认边框宽度
        self.hasBorder = NO; // 默认无边框
        self.isMoving = NO;
        self.useCustomImage = NO;
        self.cornerRadiusRatio = 0.5; // 默认中等圆角
        
        // 初始化自定义图片视图
        self.customImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.customImageView];
        
        // 初始化时就设置圆形
        self.layer.masksToBounds = NO; // 改为NO以便显示边框和阴影
    }
    return self;
}

- (void)updateWithPoint:(CGPoint)point {
    [self updateWithPoint:point isMoving:NO];
}

- (void)updateWithPoint:(CGPoint)point isMoving:(BOOL)isMoving {
    self.isMoving = isMoving;
    
    // 取消所有正在进行的动画
    [self.layer removeAllAnimations];
    
    // 设置视图位置
    CGRect frame = CGRectMake(point.x - self.trailSize/2, point.y - self.trailSize/2, self.trailSize, self.trailSize);
    self.frame = frame;
    
    // 设置自定义图片视图的大小和位置
    self.customImageView.frame = self.bounds;
    
    if (self.useCustomImage) {
        // 使用自定义图片模式
        self.backgroundColor = [UIColor clearColor];
        self.customImageView.hidden = NO;
        
        // 根据cornerRadiusRatio计算圆角半径
        CGFloat maxRadius = self.trailSize / 2;
        CGFloat radius = maxRadius * self.cornerRadiusRatio;
        self.customImageView.layer.cornerRadius = radius;
        self.customImageView.clipsToBounds = YES;
        
        // 设置边框
        if (self.hasBorder) {
            self.customImageView.layer.borderWidth = self.borderWidth;
            self.customImageView.layer.borderColor = self.borderColor.CGColor;
        } else {
            self.customImageView.layer.borderWidth = 0;
        }
    } else {
        // 使用默认圆形模式
        self.customImageView.hidden = YES;
        
        // 确保是圆形
        self.layer.cornerRadius = self.trailSize / 2;
        
        // 设置颜色
        self.backgroundColor = self.trailColor;
        
        // 设置边框
        if (self.hasBorder) {
            self.layer.borderWidth = self.borderWidth;
            self.layer.borderColor = self.borderColor.CGColor;
        } else {
            self.layer.borderWidth = 0;
        }
    }
    
    // 重置transform
    self.transform = CGAffineTransformIdentity;
    
    if (!isMoving) {
        // 触摸开始或结束时的动画效果
        self.alpha = 1.0;
        
        // 添加发光效果 - 无论是默认圆形还是自定义图片都应用
        if (!self.useCustomImage) {
            self.layer.shadowColor = self.trailColor.CGColor;
        } else {
            self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        }
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5.0;
        
        // 点击动画 - 仅用于点击，不用于滑动
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0.8;
            self.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];
    } else {
        // 滑动时简单显示，不做变形动画
        self.alpha = 0.7; // 滑动时稍微透明一些
        
        // 滑动时也添加轻微发光效果但不那么强烈
        if (!self.useCustomImage) {
            self.layer.shadowColor = self.trailColor.CGColor;
        } else {
            self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        }
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 3.0;
    }
}

@end

// 获取当前设置的触摸轨迹颜色
static UIColor * getCurrentTrailColor() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat red = [defaults floatForKey:kTouchTrailColorRedKey];
    CGFloat green = [defaults floatForKey:kTouchTrailColorGreenKey];
    CGFloat blue = [defaults floatForKey:kTouchTrailColorBlueKey];
    CGFloat alpha = [defaults floatForKey:kTouchTrailColorAlphaKey];
    
    // 如果未设置颜色或值无效，返回默认值（红色）
    if (red == 0 && green == 0 && blue == 0 && alpha == 0) {
        return [UIColor redColor];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

// 获取当前设置的触摸轨迹大小
static CGFloat getCurrentTrailSize() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat size = [defaults floatForKey:kTouchTrailSizeKey];
    
    // 如果未设置大小或值无效，返回默认值
    if (size <= 0) {
        return 20.0;
    }
    
    return size;
}

// 获取当前设置的边框颜色
static UIColor * getBorderColor() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat red = [defaults floatForKey:kTouchTrailBorderColorRedKey];
    CGFloat green = [defaults floatForKey:kTouchTrailBorderColorGreenKey];
    CGFloat blue = [defaults floatForKey:kTouchTrailBorderColorBlueKey];
    CGFloat alpha = [defaults floatForKey:kTouchTrailBorderColorAlphaKey];
    
    // 如果未设置颜色或值无效，返回默认值（白色）
    if (red == 0 && green == 0 && blue == 0 && alpha == 0) {
        return [UIColor whiteColor];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

// 获取当前设置的边框宽度
static CGFloat getBorderWidth() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat width = [defaults floatForKey:kTouchTrailBorderWidthKey];
    
    // 如果未设置宽度或值无效，返回默认值
    if (width <= 0) {
        return 1.0;
    }
    
    return width;
}

// 获取是否启用边框
static BOOL isBorderEnabled() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kTouchTrailBorderEnabledKey];
}

// 获取是否启用拖尾效果
static BOOL isTailEnabled() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kTouchTrailTailEnabledKey];
}

// 获取拖尾密度设置 (1-100)
static CGFloat getTailDensity() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat density = [defaults floatForKey:kTouchTrailTailDensityKey];
    if (density < 1.0) {
        return 50.0; // 默认中等密度
    }
    return density;
}

// 获取拖尾持续时间设置 (秒)
static CGFloat getTailDuration() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat duration = [defaults floatForKey:kTouchTrailTailDurationKey];
    if (duration < 0.3) {
        return 0.8; // 默认0.8秒
    }
    return duration;
}

// 新增方法：检查是否使用自定义图片
static BOOL isUsingCustomImage() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kTouchTrailCustomImageEnabledKey];
}

// 新增方法：获取自定义图片路径
static NSString* getCustomImagePath() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *savedPath = [defaults objectForKey:kTouchTrailCustomImagePathKey];
    
    // 如果存在保存的路径，先检查文件是否还存在
    if (savedPath && [[NSFileManager defaultManager] fileExistsAtPath:savedPath]) {
        return savedPath;
    }
    
    // 尝试获取固定位置的图片
    NSString *prefsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    prefsPath = [prefsPath stringByAppendingPathComponent:@"Preferences"];
    // 资源存储路径：Preferences/WeChatImprove/touch_trail.png（原WechatEnhance已更名为WeChatImprove）
    NSString *enhanceFolderPath = [prefsPath stringByAppendingPathComponent:@"WeChatImprove"];
    NSString *fixedImagePath = [enhanceFolderPath stringByAppendingPathComponent:@"touch_trail.png"];
    
    // 检查固定位置的图片是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:fixedImagePath]) {
        return fixedImagePath;
    }
    
    return nil;
}

// 获取自定义图片
static UIImage* getCustomImage() {
    NSString *imagePath = getCustomImagePath();
    if (imagePath) {
        return [UIImage imageWithContentsOfFile:imagePath];
    }
    return nil;
}

// 获取自定义圆角比例
static CGFloat getCornerRadiusRatio() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat ratio = [defaults floatForKey:kTouchTrailCustomImageCornerRadiusKey];
    
    // 限制在0-1范围内
    if (ratio < 0) ratio = 0;
    if (ratio > 1) ratio = 1;
    
    return ratio;
}

// All UIKit state below is main-thread owned. Event delivery uses this snapshot
// and never opens a file or queries preferences.
static NSMutableDictionary *touchViews, *touchTailViews, *touchLastPointTimes;
static NSHashTable *allTrailViews;
static NSDictionary *trailSettingsSnapshot;
static UIColor *cachedTrailColor, *cachedBorderColor;
static UIImage *cachedTrailImage;
static CGFloat cachedTrailSize, cachedBorderWidth, cachedTailDensity, cachedTailDuration, cachedCornerRadius;
static BOOL cachedHasBorder, cachedShowTail, cachedUseImage, isTrailEnabled, trailInactive;
static atomic_bool trailRefreshPending, trailImageInvalidated;
static void CSClearTouchTrails(void) {
    for (UIView *view in allTrailViews.allObjects) { [view.layer removeAllAnimations]; [view removeFromSuperview]; }
    [allTrailViews removeAllObjects];
    for (UIView *view in touchViews.allValues) { [view.layer removeAllAnimations]; [view removeFromSuperview]; }
    for (NSHashTable *dots in touchTailViews.allValues) for (UIView *view in dots.allObjects) {
        [view.layer removeAllAnimations]; [view removeFromSuperview];
    }
    [touchViews removeAllObjects]; [touchTailViews removeAllObjects]; [touchLastPointTimes removeAllObjects];
}
static void CSReloadTouchTrails(void) {
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    NSMutableDictionary *snapshot=[NSMutableDictionary dictionary];
    for (NSString *key in @[kTouchTrailKey,
        kTouchTrailColorRedKey,
        kTouchTrailColorGreenKey,
        kTouchTrailColorBlueKey,
        kTouchTrailColorAlphaKey,
        kTouchTrailSizeKey,
        kTouchTrailOnlyWhenRecordingKey,
        kTouchTrailBorderEnabledKey,
        kTouchTrailBorderColorRedKey,
        kTouchTrailBorderColorGreenKey,
        kTouchTrailBorderColorBlueKey,
        kTouchTrailBorderColorAlphaKey,
        kTouchTrailBorderWidthKey,
        kTouchTrailTailEnabledKey,
        kTouchTrailTailDensityKey,
        kTouchTrailTailDurationKey,
        kTouchTrailCustomImageEnabledKey,
        kTouchTrailCustomImagePathKey,
        kTouchTrailCustomImageCornerRadiusKey]) { id value=[defaults objectForKey:key]; if (value) snapshot[key]=value; }
    BOOL imageChanged=atomic_exchange(&trailImageInvalidated,false);
    if (imageChanged || ![snapshot isEqual:trailSettingsSnapshot]) {
        BOOL imageSettingsChanged=imageChanged || !trailSettingsSnapshot ||
            ![snapshot[kTouchTrailCustomImagePathKey] ?: @"" isEqual:trailSettingsSnapshot[kTouchTrailCustomImagePathKey] ?: @""] ||
            [snapshot[kTouchTrailCustomImageEnabledKey] boolValue]!=cachedUseImage;
        trailSettingsSnapshot=[snapshot copy];
        cachedTrailColor=getCurrentTrailColor(); cachedTrailSize=getCurrentTrailSize();
        cachedHasBorder=isBorderEnabled(); cachedBorderColor=getBorderColor(); cachedBorderWidth=getBorderWidth();
        cachedShowTail=isTailEnabled(); cachedTailDensity=getTailDensity(); cachedTailDuration=MIN(2.0,getTailDuration());
        cachedUseImage=isUsingCustomImage(); cachedCornerRadius=getCornerRadiusRatio();
        if (imageSettingsChanged) cachedTrailImage=cachedUseImage ? getCustomImage() : nil;
        CSClearTouchTrails();
    }
    BOOL enabled=CSTouchTrailShouldDisplay([snapshot[kTouchTrailKey] boolValue],
        [snapshot[kTouchTrailOnlyWhenRecordingKey] boolValue],UIScreen.mainScreen.isCaptured,!trailInactive);
    if (!enabled) CSClearTouchTrails();
    isTrailEnabled=enabled;
}
static void CSRequestTouchTrailRefresh(void) {
    CSRequestMainRefresh(&trailRefreshPending, ^{ CSReloadTouchTrails(); });
}

%hook UIApplication

- (void)sendEvent:(UIEvent *)event {
    %orig;
    
    if (!isTrailEnabled || event.type!=UIEventTypeTouches) return;
    UIColor *trailColor=cachedTrailColor, *borderColor=cachedBorderColor;
    CGFloat trailSize=cachedTrailSize, borderWidth=cachedBorderWidth;
    BOOL hasBorder=cachedHasBorder, showTail=cachedShowTail && NSProcessInfo.processInfo.thermalState<NSProcessInfoThermalStateSerious;
    CGFloat tailDensity=cachedTailDensity, tailDuration=cachedTailDuration;
    BOOL useCustomImage=cachedUseImage;
    UIImage *customImage=cachedTrailImage;
    CGFloat cornerRadiusRatio=cachedCornerRadius;

    // 处理所有触摸事件
    NSSet *allTouches = event.allTouches;
    for (UITouch *touch in allTouches) {
        CGPoint location = [touch locationInView:touch.window];
        NSValue *key = [NSValue valueWithPointer:(__bridge const void *)(touch)];
        WBTouchTrailView *trailView = touchViews[key];
        
        switch (touch.phase) {
            case UITouchPhaseBegan: {
                // 触摸开始，创建新的轨迹视图
                if (!trailView) {
                    trailView = [[WBTouchTrailView alloc] init];
                    trailView.trailSize = trailSize;
                    trailView.trailColor = trailColor;
                    trailView.hasBorder = hasBorder;
                    trailView.borderColor = borderColor;
                    trailView.borderWidth = borderWidth;
                    
                    // 设置是否使用自定义图片和圆角比例
                    trailView.useCustomImage = useCustomImage;
                    trailView.cornerRadiusRatio = cornerRadiusRatio;
                    if (useCustomImage && customImage) {
                        trailView.customImageView.image = customImage;
                    }
                    
                    [touch.window addSubview:trailView];
                    [allTrailViews addObject:trailView];
                    touchViews[key] = trailView;
                }
                [trailView updateWithPoint:location isMoving:NO];
                
                // 如果启用了拖尾效果，初始化该触摸点的拖尾数组
                if (showTail) {
                    touchTailViews[key] = [NSHashTable weakObjectsHashTable];
                    touchLastPointTimes[key] = @(CACurrentMediaTime());
                }
                break;
            }
            case UITouchPhaseMoved: {
                NSTimeInterval moveTime=CACurrentMediaTime();
                if (!trailView || !CSTouchTrailShouldSample(moveTime,trailView.lastMoveTime,
                    location.x-trailView.lastMovePoint.x,location.y-trailView.lastMovePoint.y)) break;
                trailView.lastMoveTime=moveTime; trailView.lastMovePoint=location;
                [trailView updateWithPoint:location isMoving:YES];
                
                // 如果启用了拖尾效果，添加拖尾点
                if (showTail) {
                    NSHashTable *tailDots = touchTailViews[key];
                    if (tailDots) {
                        // 根据密度设置决定是否创建新的拖尾点
                        NSTimeInterval now = CACurrentMediaTime();
                        NSTimeInterval lastTime = [touchLastPointTimes[key] doubleValue];
                        CGFloat timeDiff = now - lastTime;
                        
                        // 密度值转换为时间间隔，值越大间隔越小（越密集）
                        // 密度范围1-100，对应时间间隔0.2秒-0.01秒
                        CGFloat timeInterval = CSTouchTrailSampleInterval(tailDensity);
                        
                        if (timeDiff >= timeInterval) {
                            // 计算轨迹点大小和不透明度 - 拖尾点比主点小一些
                            CGFloat dotSize = trailSize * 0.7;
                            
                            // 创建并添加拖尾点
                            WBTouchTrailDotView *dotView;
                            
                            if (useCustomImage && customImage) {
                                // 使用自定义图片创建拖尾点
                                dotView = [[WBTouchTrailDotView alloc] initWithPoint:location 
                                                                           dotColor:trailColor 
                                                                        borderColor:borderColor 
                                                                           dotSize:dotSize 
                                                                       borderWidth:borderWidth * 0.7 
                                                                         hasBorder:hasBorder
                                                                          duration:tailDuration
                                                                    useCustomImage:YES
                                                                      customImage:customImage
                                                                 cornerRadiusRatio:cornerRadiusRatio];
                            } else {
                                // 使用默认圆形创建拖尾点
                                dotView = [[WBTouchTrailDotView alloc] initWithPoint:location 
                                                                           dotColor:trailColor 
                                                                        borderColor:borderColor 
                                                                           dotSize:dotSize 
                                                                       borderWidth:borderWidth * 0.7 
                                                                         hasBorder:hasBorder
                                                                          duration:tailDuration];
                            }
                            
                            // Weak ownership releases expired dots during a long gesture;
                            // a hard cap also bounds live render layers at maximum density.
                            NSArray *liveDots=tailDots.allObjects;
                            NSUInteger excess=liveDots.count>=CSTouchTrailMaximumDots ? liveDots.count-CSTouchTrailMaximumDots+1 : 0;
                            for (NSUInteger i=0;i<excess;i++) {
                                UIView *expired=liveDots[i];
                                [expired.layer removeAllAnimations]; [expired removeFromSuperview]; [tailDots removeObject:expired];
                            }
                            [touch.window addSubview:dotView];
                            [allTrailViews addObject:dotView];
                            [tailDots addObject:dotView];
                            
                            // 更新最后一次记录时间
                            touchLastPointTimes[key] = @(now);
                        }
                    }
                }
                break;
            }
            case UITouchPhaseEnded:
            case UITouchPhaseCancelled: {
                // 触摸结束，淡出并移除轨迹视图
                if (trailView) {
                    [touchViews removeObjectForKey:key];
                    [UIView animateWithDuration:0.3 animations:^{
                        trailView.alpha = 0;
                    } completion:^(BOOL finished) {
                        [trailView removeFromSuperview];
                        if (touchViews[key]==trailView) [touchViews removeObjectForKey:key];
                    }];
                }
                
                // 移除拖尾数组（拖尾点会自动淡出并移除）和时间记录
                [touchTailViews removeObjectForKey:key];
                [touchLastPointTimes removeObjectForKey:key];
                break;
            }
            default:
                break;
        }
    }
}

%end
%ctor {
    touchViews=[NSMutableDictionary dictionary]; touchTailViews=[NSMutableDictionary dictionary];
    touchLastPointTimes=[NSMutableDictionary dictionary]; allTrailViews=[NSHashTable weakObjectsHashTable];
    trailInactive=UIApplication.sharedApplication.applicationState!=UIApplicationStateActive;
    CSRequestTouchTrailRefresh();
    NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
    [center addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note) { CSRequestTouchTrailRefresh(); }];
    for (NSString *name in @[@"CSTouchTrailImageDidChange", @"com.wechat.tweak.settings_changed"]) {
        [center addObserverForName:name object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
            atomic_store(&trailImageInvalidated,true); CSRequestTouchTrailRefresh();
        }];
    }
    [center addObserverForName:UIScreenCapturedDidChangeNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note) { CSRequestTouchTrailRefresh(); }];
    [center addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
        dispatch_async(dispatch_get_main_queue(), ^{ trailInactive=YES; isTrailEnabled=NO; CSClearTouchTrails(); });
    }];
    [center addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
        dispatch_async(dispatch_get_main_queue(), ^{ trailInactive=NO; CSReloadTouchTrails(); });
    }];
}
