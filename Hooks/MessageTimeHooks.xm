// 消息时间显示Hook
// 显示每条消息的发送时间

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "../Controllers/CSPreferenceRefresh.h"
static atomic_bool timeRefreshPending, timeRefreshForced;
#import "../Controllers/CSMessageMergeAdapter.h"
#import "../Controllers/CSMessageTimeLayout.h"
#import "../Controllers/CSMessageCellLifecycle.h"

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
@interface CommonMessageCellView : UIView
@property(readonly, nonatomic) id viewModel; // 消息视图模型
@property(nonatomic, readonly) UIView *m_contentView; // 内容视图
- (UIView *)getBgImageView; // 获取背景图片视图
- (void)updateNodeStatus; // 更新节点状态
- (void)cs_messageTimeLayout;
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
static char kTimeBindingKey, kTimeLabelVersionKey;
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
    unsigned int timestamp = 0;
    if (!CSMessageTimeReadTimestamp(model,&timestamp)) { setMessageTime(model,nil); return; }
    BOOL show = CSMessageTimeShowsModel(model,timeBelowAvatar);
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

@interface CSMessageTimeTapDelegate : NSObject <UIGestureRecognizerDelegate>
@property(nonatomic, weak) CommonMessageCellView *cell;
@end
@implementation CSMessageTimeTapDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    CommonMessageCellView *cell=self.cell;
    if (!cell || !messageTimeEnabled || ![NSUserDefaults.standardUserDefaults boolForKey:kMessageTimeTapToShowKey]) return NO;
    UIView *anchor=CSMessageTimeAnchor(cell);
    if (anchor && CGRectContainsPoint([cell convertRect:anchor.bounds fromView:anchor],[touch locationInView:cell])) return NO;
    for (UIView *view=touch.view; view && view!=cell; view=view.superview)
        if ([view isKindOfClass:UIControl.class]) return NO;
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other {
    // Outside-bubble only; no native delegate or failure dependency is changed.
    return YES;
}
@end
static char kTimeTapDelegateKey;

static UILabel *ensureTimeView(CommonMessageCellView *view) {
    UILabel *label=(UILabel *)getTimeView(view);
    if (label) return label;
    label=[UILabel new];label.numberOfLines=0;label.adjustsFontSizeToFitWidth=NO;
    label.clipsToBounds=YES;label.textAlignment=NSTextAlignmentCenter;label.hidden=YES;
    setTimeView(view,label);setTimeViewVisible(view,NO);
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:view action:NSSelectorFromString(@"handleMessageTap:")];
    tap.numberOfTapsRequired=1;
    CSMessageTimeTapDelegate *delegate=[CSMessageTimeTapDelegate new]; delegate.cell=view;
    objc_setAssociatedObject(view,&kTimeTapDelegateKey,delegate,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    tap.delegate=delegate;
    tap.delaysTouchesBegan=NO;tap.delaysTouchesEnded=NO;tap.cancelsTouchesInView=NO;
    [view addGestureRecognizer:tap];view.userInteractionEnabled=YES;
    return label;
}
static void refreshMessageTimeView(CommonMessageCellView *self) {
    if (!NSThread.isMainThread) return;
    [timeCells addObject:self];
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
    BOOL sender=NO;
    if (!CSMessageTimeReadSender(viewModel,&sender)) {
        getTimeView(self).hidden=YES;
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
        UILabel *timeLabel = ensureTimeView(self);
        BOOL changed=[objc_getAssociatedObject(self,&kTimeLabelVersionKey) unsignedIntegerValue]!=timeSettingsVersion ||
            ![timeLabel.text isEqual:messageTime];

        // 更新时间标签的样式，以防设置有变化
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        if (changed) {
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
            objc_setAssociatedObject(self,&kTimeLabelVersionKey,@(timeSettingsVersion),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
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


        // Final positioning belongs to the shared lifecycle/merge renderer.

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

// These bridges retain the time feature's existing state and measurement behavior.
void CSMessageTimePrepareCell(id cell) { refreshMessageTimeView(cell); }
void CSMessageTimeResetCell(id cell) {
    setTimeViewVisible(cell,NO); getTimeView(cell).hidden=YES;
    if (getCurrentVisibleCellView()==cell) setCurrentVisibleCellView(nil);
}

%hook CommonMessageCellView
%new
- (void)cs_messageTimeLayout {
    UILabel *label = (UILabel *)getTimeView(self);
    if (!label) return;
    UIView *head = CSMessageNativeObject(self,@"getHeadImageView");
    UIView *content = CSMessageTimeAnchor(self);
    id model = CSMessageNativeObject(self,@"viewModel");
    BOOL sender=NO;
    if (!CSMessageTimeReadSender(model,&sender)) return;
    CSMessageTimePositionLabel(label,self,head,content,sender,timeBelowAvatar);
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

    UIView *anchor=CSMessageTimeAnchor(self);
    BOOL tappedInBubble=anchor && CGRectContainsPoint([self convertRect:anchor.bounds fromView:anchor],tapLocation);

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

%end

static void refreshTimeSettings(BOOL force) {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    NSMutableDictionary *snapshot = [NSMutableDictionary dictionary];
    for (NSString *key in @[kMessageTimeEnabledKey, kMessageTimeFontSizeKey, kMessageTimeTextColorKey,
        kMessageTimeBackgroundColorKey, kMessageTimeCornerRadiusKey, kMessageTimeShowBelowAvatarKey,
        kMessageTimeBoldFontKey, kMessageTimeTapToShowKey]) {
        id value = [defaults objectForKey:key];
        if (value) snapshot[key] = value;
    }
    if (!force && [snapshot isEqual:timeSettingsSnapshot]) return;
    timeSettingsSnapshot = [snapshot copy]; timeSettingsVersion++;
    messageTimeEnabled = [defaults boolForKey:kMessageTimeEnabledKey];
    timeBelowAvatar = [defaults boolForKey:kMessageTimeShowBelowAvatarKey];
    for (CommonMessageCellView *cell in timeCells) if (cell.window) {
        refreshMessageTimeView(cell); [cell cs_messageTimeLayout]; [cell setNeedsLayout];
    }
}
static void requestTimeRefresh(BOOL force) {
    if (force) atomic_store(&timeRefreshForced, true);
    CSRequestMainRefresh(&timeRefreshPending, ^{ refreshTimeSettings(atomic_exchange(&timeRefreshForced, false)); });
}
%ctor {
    timeCells = [NSHashTable weakObjectsHashTable];
    refreshTimeSettings(NO);
    [NSNotificationCenter.defaultCenter addObserverForName:NSUserDefaultsDidChangeNotification object:nil
        queue:nil usingBlock:^(NSNotification *note) { requestTimeRefresh(NO); }];
    for (NSString *name in @[NSSystemTimeZoneDidChangeNotification,NSCurrentLocaleDidChangeNotification])
        [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:nil
            usingBlock:^(NSNotification *note) { requestTimeRefresh(YES); }];
}
