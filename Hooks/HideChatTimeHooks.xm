#import "../Controllers/CSBackupBootstrap.h"
// 禁用微信界面原生标签显示-界面净化

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#include <atomic>
#import "../Controllers/CSChatNativeBridge.h"
#import "../Controllers/CSRevokeReference.h"

// 定义NSUserDefaults键名与通知名称（与CSUICleanViewController.m中保持一致）
static NSString * const kWCHideChatTimeEnabledKey = @"com.wechat.tweak.hide_chat_time_enabled";
// 添加隐藏撤回消息标签的键
static NSString * const kWCHideRevokeMessageEnabledKey = @"com.wechat.tweak.hide_revoke_message_enabled";
// 添加隐藏拍一拍消息标签的键
static NSString * const kWCHidePatMessageEnabledKey = @"com.wechat.tweak.hide_pat_message_enabled";
// 添加隐藏语音红点和转文字标签的键
static NSString * const kWCHideVoiceHintEnabledKey = @"com.wechat.tweak.hide_voice_hint_enabled";
static NSString * const kWCSettingsChangedNotification = @"com.wechat.tweak.settings_changed";

// 全局变量，保存当前设置状态
static BOOL gHideChatTimeEnabled = NO;
// 隐藏撤回消息的全局变量
static std::atomic_bool gHideRevokeMessageEnabled{false};
static NSUInteger revokeVisibilityGeneration=1;
static char revokeHiddenKey,revokeGenerationKey;
@interface CSRevokeTipCache : NSObject
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *pattern;
@property(nonatomic) BOOL owned;
@end
@implementation CSRevokeTipCache @end
static char revokeTipCacheKey;
static BOOL CSIsRevokeTip(id model) {
    if (!model) return NO;
    id wrap=CSMessageNativeObject(model,@"messageWrap");
    NSString *content=CSMessageNativeObject(wrap,@"m_nsContent"),*pattern=CSMessageNativeObject(wrap,@"m_nsPattern");
    @synchronized(model) {
        CSRevokeTipCache *cache=objc_getAssociatedObject(model,&revokeTipCacheKey);
        if (cache && (cache.content==content || [cache.content isEqual:content]) &&
            (cache.pattern==pattern || [cache.pattern isEqual:pattern])) return cache.owned;
        cache=[CSRevokeTipCache new];cache.content=content;cache.pattern=pattern;
        cache.owned=CSRevokeResolveReference(nil,content,pattern)!=nil;
        objc_setAssociatedObject(model,&revokeTipCacheKey,cache,OBJC_ASSOCIATION_RETAIN);
        return cache.owned;
    }
}
static void CSRestoreRevokeView(UIView *view) {
    NSNumber *prior=objc_getAssociatedObject(view,&revokeHiddenKey);
    if (prior && view.hidden) view.hidden=prior.boolValue;
    objc_setAssociatedObject(view,&revokeHiddenKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static void CSResetTipModel(id model) {
    SEL sel=NSSelectorFromString(@"resetLayoutCache");
    Method method=class_getInstanceMethod(object_getClass(model),sel);
    if (method && method_getNumberOfArguments(method)==2 && method_getTypeEncoding(method)[0]=='v')
        ((void (*)(id,SEL))objc_msgSend)(model,sel);
}
// 隐藏拍一拍消息的全局变量
static BOOL gHidePatMessageEnabled = NO;
// 隐藏语音消息红点和转文字的全局变量
static BOOL gHideVoiceHintEnabled = NO;

// 从NSUserDefaults读取设置状态
static void loadSettings() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    gHideChatTimeEnabled = [defaults boolForKey:kWCHideChatTimeEnabledKey];
    BOOL hide=[defaults boolForKey:kWCHideRevokeMessageEnabledKey];
    if (hide!=gHideRevokeMessageEnabled) revokeVisibilityGeneration++;
    gHideRevokeMessageEnabled=hide;
    gHidePatMessageEnabled = [defaults boolForKey:kWCHidePatMessageEnabledKey];
    gHideVoiceHintEnabled = [defaults boolForKey:kWCHideVoiceHintEnabledKey];
}

// 设置更改通知回调
static void settingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    dispatch_async(dispatch_get_main_queue(), ^{loadSettings();});
}

// 前向声明
@class ChatTimeCellView, ChatTimeViewModel, SystemMessageCellView, SystemMessageViewModel, AppPatMessageCellView, AppPatMessageViewModel;

// Hook ChatTimeCellView类，根据设置决定是否隐藏
%hook ChatTimeCellView

// 初始化时根据设置决定是否隐藏视图
- (id)initWithViewModel:(id)arg1 {
    id view = %orig;
    if (view && gHideChatTimeEnabled) {
        // 根据设置决定是否隐藏视图
        UIView *selfView = (UIView *)view;
        [selfView setHidden:YES];
        
        // 设置高度为0，使其不占用空间
        CGRect frame = [selfView frame];
        frame.size.height = 0;
        [selfView setFrame:frame];
    }
    return view;
}

// 覆盖布局方法，根据设置决定是否执行
- (void)layoutInternal {
    if (gHideChatTimeEnabled) {
        // 设置为隐藏时不执行布局
        return;
    }
    %orig;
}

// 覆盖canBeReused方法
- (BOOL)canBeReused {
    if (gHideChatTimeEnabled) {
        return YES;
    }
    return %orig;
}

// 覆盖shouldLayoutIfNeeded方法
- (BOOL)shouldLayoutIfNeeded {
    if (gHideChatTimeEnabled) {
        return NO;
    }
    return %orig;
}

%end

// Hook ChatTimeViewModel，修改其尺寸计算方法
%hook ChatTimeViewModel

// 覆盖measure方法，根据设置决定返回值
- (CGSize)measure:(CGSize)arg1 {
    if (gHideChatTimeEnabled) {
        // 设置为隐藏时返回零高度
        return CGSizeMake(arg1.width, 0);
    }
    return %orig;
}

%end

// Only this plugin's identifiable revoke tips are hidden; other system messages stay native.
%hook SystemMessageCellView
- (void)setViewModel:(id)model { CSRestoreRevokeView((UIView *)self); %orig; }
- (void)prepareForReuse { CSRestoreRevokeView((UIView *)self); %orig; }
- (void)layoutInternal {
    UIView *view=(UIView *)self;
    CSRestoreRevokeView(view);
    %orig;
    if (gHideRevokeMessageEnabled && CSIsRevokeTip(CSMessageNativeObject(self,@"viewModel")) && !view.hidden) {
        objc_setAssociatedObject(view,&revokeHiddenKey,@(view.hidden),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        view.hidden=YES;
    }
}
%end
%hook SystemMessageViewModel
- (CGSize)measure:(CGSize)constraint {
    CGSize native=%orig;
    if (gHideRevokeMessageEnabled && CSIsRevokeTip(self)) native.height=0;
    return native;
}
%end
%hook BaseMsgContentViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSNumber *last=objc_getAssociatedObject(self,&revokeGenerationKey);
    if (last && last.unsignedIntegerValue==revokeVisibilityGeneration) return;
    UITableView *table=CSMessageNativeTable(self);
    if (table.dragging || table.decelerating || table.editing || table.hasUncommittedUpdates) return;
    objc_setAssociatedObject(self,&revokeGenerationKey,@(revokeVisibilityGeneration),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    BOOL changed=NO;
    NSArray *nodes=CSMessageNativeObject(self,@"GetMessageNodeDataArray");
    if ([nodes isKindOfClass:NSArray.class]) for (id node in nodes) {
        if ([node isKindOfClass:NSClassFromString(@"SystemMessageViewModel")] && CSIsRevokeTip(node)) {
            changed=YES;CSResetTipModel(node);
        }
    }
    for (NSIndexPath *path in table.indexPathsForVisibleRows) {
        UIView *view=CSMessageNativeObject([table cellForRowAtIndexPath:path],@"cellView");
        id model=CSMessageNativeObject(view,@"viewModel");
        if (!CSIsRevokeTip(model)) continue;
        changed=YES;CSRestoreRevokeView(view);CSResetTipModel(model);[view setNeedsLayout];
    }
    if (changed) [UIView performWithoutAnimation:^{[table beginUpdates];[table endUpdates];}];
}
%end

// Hook AppPatMessageCellView类，根据设置决定是否隐藏拍一拍消息
%hook AppPatMessageCellView

// 初始化时根据设置决定是否隐藏视图
- (id)initWithViewModel:(id)arg1 {
    id view = %orig;
    if (view && gHidePatMessageEnabled) {
        // 根据设置决定是否隐藏视图
        UIView *selfView = (UIView *)view;
        [selfView setHidden:YES];
        
        // 设置高度为0，使其不占用空间
        CGRect frame = [selfView frame];
        frame.size.height = 0;
        [selfView setFrame:frame];
    }
    return view;
}

// 覆盖布局方法，根据设置决定是否执行
- (void)layoutInternal {
    if (gHidePatMessageEnabled) {
        // 设置为隐藏时不执行布局
        return;
    }
    %orig;
}

// 覆盖canBeReused方法
- (BOOL)canBeReused {
    if (gHidePatMessageEnabled) {
        return YES;
    }
    return %orig;
}

// 覆盖shouldLayoutIfNeeded方法
- (BOOL)shouldLayoutIfNeeded {
    if (gHidePatMessageEnabled) {
        return NO;
    }
    return %orig;
}

%end

// Hook AppPatMessageViewModel，修改其尺寸计算方法
%hook AppPatMessageViewModel

// 覆盖measure方法，根据设置决定返回值
- (CGSize)measure:(CGSize)arg1 {
    if (gHidePatMessageEnabled) {
        // 设置为隐藏时返回零高度
        return CGSizeMake(arg1.width, 0);
    }
    return %orig;
}

%end

// 修改VoiceMessageCellView的声明，不使用具体属性
@interface VoiceMessageCellView : UIView
@end

// Hook VoiceMessageCellView类，隐藏语音消息的红点和转文字按钮
%hook VoiceMessageCellView

// 使用layoutSubviews方法来隐藏红点和转文字按钮
- (void)layoutSubviews {
    %orig;
    
    if (gHideVoiceHintEnabled) {
        // 使用KVC安全地获取并隐藏红点视图
        UIView *unreadView = [self valueForKey:@"m_unreadImageView"];
        if (unreadView) {
            [unreadView setHidden:YES];
        }
        
        // 使用KVC安全地获取并隐藏转文字按钮
        UIButton *transButton = [self valueForKey:@"m_quickTransTipButton"];
        if (transButton) {
            [transButton setHidden:YES];
        }
    }
}

%end

// 初始化函数
%ctor {
    CSBackupWhenReady(^{
        // 读取初始设置
        loadSettings();

        // 注册设置变更通知
        CFNotificationCenterAddObserver(
            CFNotificationCenterGetDarwinNotifyCenter(),
            NULL,
            settingsChanged,
            CFSTR("com.wechat.tweak.settings_changed"),
            NULL,
            CFNotificationSuspensionBehaviorCoalesce
        );
        %init;
    });
} 