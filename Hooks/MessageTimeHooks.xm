// 消息时间显示Hook
// 显示每条消息的发送时间

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "../Controllers/CSMessageMergeAdapter.h"
#import "../Controllers/CSMessageTimeLayout.h"

// UserDefaults Key常量
static NSString * const kMessageTimeEnabledKey = @"com.wechat.enhance.messageTime.enabled";
static NSString * const kMessageTimeFontSizeKey = @"com.wechat.enhance.messageTime.fontSize";
static NSString * const kMessageTimeTextColorKey = @"com.wechat.enhance.messageTime.textColor";
static NSString * const kMessageTimeBackgroundColorKey = @"com.wechat.enhance.messageTime.backgroundColor";
static NSString * const kMessageTimeCornerRadiusKey = @"com.wechat.enhance.messageTime.cornerRadius";
// 位置控制
static NSString * const kMessageTimeShowBelowAvatarKey = @"com.wechat.enhance.messageTime.showBelowAvatar";
// 字体加粗控制
static NSString * const kMessageTimeBoldFontKey = @"com.wechat.enhance.messageTime.boldFont";
// 点击显示控制
static NSString * const kMessageTimeTapToShowKey = @"com.wechat.enhance.messageTime.tapToShow";

// 默认值
static CGFloat const kDefaultFontSize = 9.0f;
static CGFloat const kDefaultCornerRadius = 2.0f;
static CGFloat const kMaxLabelWidth = 90.0f; // 时间标签最大宽度

// 类声明
@interface CMessageWrap : NSObject
@property(nonatomic) unsigned int m_uiCreateTime; // 消息创建时间
@property(nonatomic) unsigned int m_uiMessageType; // 消息类型
@property(readonly, nonatomic) BOOL IsImgMsg;      // 是否是图片消息
@property(readonly, nonatomic) BOOL IsVideoMsg;    // 是否是视频消息
@property(readonly, nonatomic) BOOL IsVoiceMsg;    // 是否是语音消息
@property(readonly, nonatomic) BOOL IsTextMsg;     // 是否是文本消息
@property(readonly, nonatomic) NSString *m_nsContent; // 消息内容
@property(readonly, nonatomic) unsigned int m_uiMesLocalID; // 消息本地ID，用于唯一标识消息
@end

@interface CommonMessageViewModel : NSObject
@property(readonly, nonatomic) BOOL isSender; // 是否是发送者
@property(retain, nonatomic) CMessageWrap *messageWrap; // 消息包装对象
@property(nonatomic) unsigned int createTime; // 消息创建时间
@end

@interface TextMessageSubViewModel : CommonMessageViewModel
@property(readonly, nonatomic) CommonMessageViewModel *parentModel; // 对于长文本消息，父模型
@property(readonly, nonatomic) NSArray *subViewModels; // 子视图模型列表
@end

@interface CommonMessageCellView : UIView <UIGestureRecognizerDelegate>
@property(readonly, nonatomic) CommonMessageViewModel *viewModel; // 消息视图模型
@property(nonatomic, readonly) UIView *m_contentView; // 内容视图
- (UIView *)getBgImageView; // 获取背景图片视图
- (void)updateNodeStatus; // 更新节点状态
- (void)cs_messageTimeLayout;
@end

@interface VoiceMessageCellView : CommonMessageCellView
@property(nonatomic, readonly) UILabel *m_secLabel; // 语音消息秒数标签
@end

@interface BaseMsgContentViewController : UIViewController
@property(nonatomic, readonly) UITableView *tableView; // 消息表格视图
@end

@interface ChatTableViewCell : UITableViewCell
- (CommonMessageCellView *)cellView; // 获取消息Cell视图
@end

// 存储消息时间的关联对象key
static char kMessageTimeKey;
// 存储消息时间视图的关联对象key
static char kTimeViewKey;
// 存储时间标签可见状态的关联对象key
static char kTimeViewVisibleKey;
// 存储当前显示时间的视图引用key
static __weak id currentVisibleTimeCell;
static BOOL timeBelowAvatar;
static BOOL messageTimeEnabled;
static NSUInteger timeSettingsVersion;
static NSDictionary *timeSettingsSnapshot;
static NSHashTable *timeCells;
static char kTimeBindingKey;
@interface CSMessageTimeBinding : NSObject
@property(nonatomic) unsigned int timestamp;
@property(nonatomic) NSUInteger version;
@property(nonatomic) BOOL show;
@end
@implementation CSMessageTimeBinding @end

// 辅助函数
static void setMessageTime(id self, NSString *time) {
    objc_setAssociatedObject(self, &kMessageTimeKey, time, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static NSString *getMessageTime(id self) {
    return objc_getAssociatedObject(self, &kMessageTimeKey);
}

static void setTimeView(id self, UIView *view) {
    objc_setAssociatedObject(self, &kTimeViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static UIView *getTimeView(id self) {
    return objc_getAssociatedObject(self, &kTimeViewKey);
}

static void setTimeViewVisible(id self, BOOL visible) {
    objc_setAssociatedObject(self, &kTimeViewVisibleKey, @(visible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static BOOL getTimeViewVisible(id self) {
    NSNumber *value = objc_getAssociatedObject(self, &kTimeViewVisibleKey);
    return value ? [value boolValue] : NO;
}

static void setCurrentVisibleCellView(id view) { currentVisibleTimeCell = view; }
static id getCurrentVisibleCellView() { return currentVisibleTimeCell; }

// 获取颜色设置
static UIColor *getTextColorFromDefaults() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 获取保存的颜色
    NSData *colorData = [defaults objectForKey:kMessageTimeTextColorKey];
    if (colorData) {
        NSError *error = nil;
        UIColor *savedColor = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIColor class] fromData:colorData error:&error];
        if (savedColor && !error) {
            return savedColor;
        }
        if (error) {
            NSLog(@"解档消息时间文字颜色时出错: %@", error);
        }
    }
    // 返回默认颜色
    return [UIColor colorWithWhite:0.5 alpha:0.8];
}

static UIColor *getBackgroundColorFromDefaults() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 获取保存的颜色
    NSData *colorData = [defaults objectForKey:kMessageTimeBackgroundColorKey];
    if (colorData) {
        NSError *error = nil;
        UIColor *savedColor = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIColor class] fromData:colorData error:&error];
        if (savedColor && !error) {
            return savedColor;
        }
        if (error) {
            NSLog(@"解档消息时间背景颜色时出错: %@", error);
        }
    }
    
    // 默认为透明
    return [UIColor clearColor];
}

static void assignMessageTime(CommonMessageCellView *view) {
    if (!NSThread.isMainThread) return;
    id model = CSMessageNativeObject(view,@"viewModel");
    if (!model) return;
    if (!messageTimeEnabled) {
        setMessageTime(model,nil);
        objc_setAssociatedObject(model,&kTimeBindingKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    id parent = CSMessageNativeObject(model,@"parentModel");
    unsigned int timestamp = 0;
    if (!CSMessageTimeReadTimestamp(model,&timestamp)) { setMessageTime(model,nil); return; }
    BOOL show = YES;
    if (parent) {
        NSArray *parts = CSMessageNativeObject(parent,@"subViewModels");
        if ([parts isKindOfClass:NSArray.class] && parts.count)
            show = (timeBelowAvatar ? parts.firstObject : parts.lastObject) == model;
    }
    CSMessageTimeBinding *binding = objc_getAssociatedObject(model,&kTimeBindingKey);
    if (binding && binding.version == timeSettingsVersion && binding.timestamp == timestamp && binding.show == show && getMessageTime(model)) return;
    setMessageTime(model,show ? CSMessageTimeText(timestamp,NSUserDefaults.standardUserDefaults) : @"-1");
    binding = [CSMessageTimeBinding new]; binding.version=timeSettingsVersion; binding.timestamp=timestamp; binding.show=show;
    objc_setAssociatedObject(model,&kTimeBindingKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 检查是否启用了时间显示功能
static BOOL isMessageTimeEnabled() {
    return messageTimeEnabled;
}

// Hook CommonMessageCellView类，这是消息气泡的基类
%hook CommonMessageCellView
- (void)setViewModel:(id)model {
    if (CSMessageNativeObject(self,@"viewModel") != model) {
        setTimeViewVisible(self,NO);
        getTimeView(self).hidden = YES;
        if (getCurrentVisibleCellView() == self) setCurrentVisibleCellView(nil);
    }
    %orig;
    assignMessageTime(self);
    if (getTimeView(self)) [self updateNodeStatus];
}

%new
- (void)cs_messageTimeLayout {
    UILabel *label = (UILabel *)getTimeView(self);
    if (!label) return;
    UIView *head = CSMessageNativeObject(self,@"getHeadImageView");
    UIView *content = CSMessageNativeObject(self,@"getContentView") ?: CSMessageNativeObject(self,@"getBgImageView");
    id model = CSMessageNativeObject(self,@"viewModel");
    BOOL sender = [model respondsToSelector:@selector(isSender)] && [model isSender];
    CSMessageTimePositionLabel(label,head,content,sender,timeBelowAvatar);
}


- (id)initWithViewModel:(id)arg1 {
    id view = %orig;
    if (view) {
        // 从UserDefaults获取字体大小设置
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        CGFloat fontSize = [defaults floatForKey:kMessageTimeFontSizeKey];
        if (fontSize == 0) fontSize = kDefaultFontSize;
        
        // 创建时间标签，但不立即添加到视图
        UILabel *timeLabel = [[UILabel alloc] init];
        
        // 根据设置决定是否使用粗体字
        BOOL useBoldFont = [defaults boolForKey:kMessageTimeBoldFontKey];
        if (useBoldFont) {
            timeLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        } else {
            timeLabel.font = [UIFont systemFontOfSize:fontSize];
        }
        
        timeLabel.textColor = getTextColorFromDefaults();
        timeLabel.backgroundColor = getBackgroundColorFromDefaults();
        
        // 设置圆角
        CGFloat cornerRadius = [defaults floatForKey:kMessageTimeCornerRadiusKey];
        if (cornerRadius == 0) cornerRadius = kDefaultCornerRadius;
        timeLabel.layer.cornerRadius = cornerRadius;
        
        // 支持换行和文字自动调整大小
        timeLabel.numberOfLines = 0; // 允许多行
        timeLabel.adjustsFontSizeToFitWidth = NO; // 不缩小字体，保持清晰度
        timeLabel.clipsToBounds = YES;
        timeLabel.textAlignment = NSTextAlignmentCenter; // 居中对齐
        
        // 计算标签的初始大小 - 真实大小将在updateNodeStatus中更新
        CGSize labelSize = CGSizeMake(40, 30); // 一个初始值，实际会在设置文本时调整
        timeLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
        
        // 关联时间标签到视图
        setTimeView(self, timeLabel);
        
        // 初始化可见状态为NO
        setTimeViewVisible(self, NO);
        
        // 添加点击手势识别器
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMessageTap:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.delegate = self;
        // 设置手势延迟触发，让其他手势优先
        tapGesture.delaysTouchesBegan = NO;
        tapGesture.delaysTouchesEnded = NO;
        tapGesture.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
    }
    if (view) [timeCells addObject:view];
    assignMessageTime(view);
    if (view) [view updateNodeStatus];
    return view;
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 允许与其他手势同时识别，不干扰原有手势
    return YES;
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 让我们的手势在其他手势失败后才触发
    // 如果其他手势是点击手势，我们的手势需要等待它失败
    if ([otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

%new
- (void)handleMessageTap:(UITapGestureRecognizer *)gesture {
    // 检查是否启用了"点击显示"功能
    BOOL tapToShow = [[NSUserDefaults standardUserDefaults] boolForKey:kMessageTimeTapToShowKey];
    id model = CSMessageNativeObject(self,@"viewModel");
    if (!CSMessageTimeCanToggle(messageTimeEnabled,tapToShow,getMessageTime(model))) {
        return;
    }
    
    // 获取点击位置
    CGPoint tapLocation = [gesture locationInView:self];
    
    // 获取气泡背景视图
    UIView *bgView = [self getBgImageView];
    UIView *contentView = CSMessageNativeObject(self,@"getContentView");
    
    // 判断点击是否在气泡内
    BOOL tappedInBubble = NO;
    if (bgView && CGRectContainsPoint(bgView.frame, tapLocation)) {
        tappedInBubble = YES;
    } else if (contentView && CGRectContainsPoint(contentView.frame, tapLocation)) {
        tappedInBubble = YES;
    }
    
    // 如果点击在气泡内，不处理，让原有事件触发
    if (tappedInBubble) {
        return;
    }
    
    // 点击在气泡外，处理时间显示逻辑
    // 获取当前时间标签
    UILabel *timeLabel = (UILabel *)getTimeView(self);
    if (!timeLabel) return;
    
    // 获取当前显示时间的视图
    id currentVisibleCellView = getCurrentVisibleCellView();
    
    // 如果当前已经有显示时间的视图，先隐藏它
    if (currentVisibleCellView && currentVisibleCellView != self) {
        // 隐藏之前显示的时间标签
        UILabel *previousTimeLabel = (UILabel *)getTimeView(currentVisibleCellView);
        if (previousTimeLabel) {
            previousTimeLabel.hidden = YES;
        }
        // 更新之前视图的可见状态
        setTimeViewVisible(currentVisibleCellView, NO);
    }
    
    // 切换当前时间标签的可见状态
    BOOL currentVisible = getTimeViewVisible(self);
    setTimeViewVisible(self, !currentVisible);
    
    // 更新显示状态
    timeLabel.hidden = !getTimeViewVisible(self);
    if (!timeLabel.hidden) [self cs_messageTimeLayout];
    [self setNeedsLayout];
    
    // 更新全局引用
    if (!timeLabel.hidden) {
        setCurrentVisibleCellView(self);
    } else {
        setCurrentVisibleCellView(nil);
    }
}

- (void)updateNodeStatus {
    %orig;
    if (!NSThread.isMainThread) return;
    assignMessageTime(self);
    
    // 如果功能未启用，直接返回
    if (!isMessageTimeEnabled()) {
        UIView *timeView = getTimeView(self);
        if (timeView) {
            timeView.hidden = YES;
        }
        return;
    }
    
    // 获取视图模型
    id viewModel = CSMessageNativeObject(self,@"viewModel");
    if (![viewModel respondsToSelector:@selector(isSender)]) {
        return;
    }
    
    // 获取时间文本
    NSString *messageTime = getMessageTime(viewModel);
    if (messageTime.length > 0) {
        // 如果标记为不显示，则隐藏
        if ([messageTime isEqualToString:@"-1"]) {
            getTimeView(self).hidden = YES;
            return;
        }
        
        // 获取时间标签并更新设置
        UILabel *timeLabel = (UILabel *)getTimeView(self);
        if (!timeLabel) return;
        
        // 更新时间标签的样式，以防设置有变化
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        // 更新字体大小和加粗
        CGFloat fontSize = [defaults floatForKey:kMessageTimeFontSizeKey];
        if (fontSize == 0) fontSize = kDefaultFontSize;
        
        // 根据设置决定是否使用粗体字
        BOOL useBoldFont = [defaults boolForKey:kMessageTimeBoldFontKey];
        if (useBoldFont) {
            timeLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        } else {
            timeLabel.font = [UIFont systemFontOfSize:fontSize];
        }
        
        // 更新颜色
        timeLabel.textColor = getTextColorFromDefaults();
        timeLabel.backgroundColor = getBackgroundColorFromDefaults();
        
        // 更新圆角
        CGFloat cornerRadius = [defaults floatForKey:kMessageTimeCornerRadiusKey];
        if (cornerRadius == 0) cornerRadius = kDefaultCornerRadius;
        timeLabel.layer.cornerRadius = cornerRadius;
        
        // 检查是否启用了"点击显示"功能
        BOOL tapToShow = [defaults boolForKey:kMessageTimeTapToShowKey];
        
        // 根据"点击显示"开关决定是否显示时间标签
        if (tapToShow) {
            // 点击显示模式：根据点击状态决定是否显示
            timeLabel.hidden = !getTimeViewVisible(self);
        } else {
            // 默认模式：直接显示
            timeLabel.hidden = NO;
        }
        
        timeLabel.text = messageTime;
        
        // 计算标签大小，限制最大宽度
        CGFloat padding = 10.0; // 左右各5点的内边距
        CGSize constraintSize = CGSizeMake(kMaxLabelWidth - padding, CGFLOAT_MAX);
        CGSize textSize = [messageTime boundingRectWithSize:constraintSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName: timeLabel.font}
                                               context:nil].size;
                                               
        // 确保有足够的空间包含文本
        CGFloat labelWidth = textSize.width + padding;
        if (labelWidth > kMaxLabelWidth) labelWidth = kMaxLabelWidth;
        if (labelWidth < 30) labelWidth = 30; // 最小宽度
        
        CGFloat labelHeight = textSize.height + 8.0; // 上下各4点的内边距
        timeLabel.frame = CGRectMake(0, 0, labelWidth, labelHeight);
        
        [self cs_messageTimeLayout];
        
        // 添加到视图上
        if (![timeLabel isDescendantOfView:self]) {
            [self addSubview:timeLabel];
        }
        
        [self bringSubviewToFront:timeLabel];
    } else {
        // 没有时间信息，隐藏标签
        getTimeView(self).hidden = YES;
    }
}

- (void)prepareForReuse {
    %orig;
    
    // 重置时间标签的可见状态
    setTimeViewVisible(self, NO);
    UILabel *timeLabel = (UILabel *)getTimeView(self);
    if (timeLabel) {
        timeLabel.hidden = YES;
    }
    
    // 如果当前显示时间的视图是这个视图，清除全局引用
    id currentVisibleCellView = getCurrentVisibleCellView();
    if (currentVisibleCellView == self) {
        setCurrentVisibleCellView(nil);
    }
}

%end


static void refreshTimeSettings(BOOL force) {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    NSMutableDictionary *snapshot = [NSMutableDictionary dictionary];
    NSDictionary *all = defaults.dictionaryRepresentation;
    for (NSString *key in all) if ([key hasPrefix:@"com.wechat.enhance.messageTime."]) snapshot[key] = all[key];
    if (!force && [snapshot isEqual:timeSettingsSnapshot]) return;
    timeSettingsSnapshot = [snapshot copy]; timeSettingsVersion++;
    messageTimeEnabled = [defaults boolForKey:kMessageTimeEnabledKey];
    timeBelowAvatar = [defaults boolForKey:kMessageTimeShowBelowAvatarKey];
    for (CommonMessageCellView *cell in timeCells) if (cell.window) {
        [cell updateNodeStatus]; [cell setNeedsLayout];
    }
}
%ctor {
    timeCells = [NSHashTable weakObjectsHashTable];
    refreshTimeSettings(NO);
    [NSNotificationCenter.defaultCenter addObserverForName:NSUserDefaultsDidChangeNotification object:nil
        queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) { refreshTimeSettings(NO); }];
    for (NSString *name in @[NSSystemTimeZoneDidChangeNotification,NSCurrentLocaleDidChangeNotification])
        [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:NSOperationQueue.mainQueue
            usingBlock:^(NSNotification *note) { refreshTimeSettings(YES); }];
}
