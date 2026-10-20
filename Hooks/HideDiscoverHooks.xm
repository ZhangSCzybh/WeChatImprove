#import "../Controllers/CSBackupBootstrap.h"
// HOOK 隐藏发现页选项
// 控制器类: FindFriendEntryViewController, WCFinderDataService
// 通过Hook发现页控制器的shouldShow*Entry方法，控制各入口是否显示
// 这是更优雅的方式，直接控制入口显示逻辑，而不是操作UI
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 设置键定义
static NSString * const kWCHideDiscoverChannelsKey = @"com.wechat.tweak.hide_discover_channels";
static NSString * const kWCHideDiscoverLiveKey = @"com.wechat.tweak.hide_discover_live";
static NSString * const kWCHideDiscoverScanKey = @"com.wechat.tweak.hide_discover_scan";
static NSString * const kWCHideDiscoverListenKey = @"com.wechat.tweak.hide_discover_listen";
static NSString * const kWCHideDiscoverLookKey = @"com.wechat.tweak.hide_discover_look";
static NSString * const kWCHideDiscoverSearchKey = @"com.wechat.tweak.hide_discover_search";
static NSString * const kWCHideDiscoverNearbyKey = @"com.wechat.tweak.hide_discover_nearby";
static NSString * const kWCHideDiscoverGameKey = @"com.wechat.tweak.hide_discover_game";
static NSString * const kWCHideDiscoverMiniProgramKey = @"com.wechat.tweak.hide_discover_miniprogram";

// 全局设置变量
static BOOL gHideDiscoverChannels = NO;
static BOOL gHideDiscoverLive = NO;
static BOOL gHideDiscoverScan = NO;
static BOOL gHideDiscoverListen = NO;
static BOOL gHideDiscoverLook = NO;
static BOOL gHideDiscoverSearch = NO;
static BOOL gHideDiscoverNearby = NO;
static BOOL gHideDiscoverGame = NO;
static BOOL gHideDiscoverMiniProgram = NO;

// 加载设置
static void loadDiscoverSettings() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    gHideDiscoverChannels = [defaults objectForKey:kWCHideDiscoverChannelsKey] ? [defaults boolForKey:kWCHideDiscoverChannelsKey] : NO;
    gHideDiscoverLive = [defaults objectForKey:kWCHideDiscoverLiveKey] ? [defaults boolForKey:kWCHideDiscoverLiveKey] : NO;
    gHideDiscoverScan = [defaults objectForKey:kWCHideDiscoverScanKey] ? [defaults boolForKey:kWCHideDiscoverScanKey] : NO;
    gHideDiscoverListen = [defaults objectForKey:kWCHideDiscoverListenKey] ? [defaults boolForKey:kWCHideDiscoverListenKey] : NO;
    gHideDiscoverLook = [defaults objectForKey:kWCHideDiscoverLookKey] ? [defaults boolForKey:kWCHideDiscoverLookKey] : NO;
    gHideDiscoverSearch = [defaults objectForKey:kWCHideDiscoverSearchKey] ? [defaults boolForKey:kWCHideDiscoverSearchKey] : NO;
    gHideDiscoverNearby = [defaults objectForKey:kWCHideDiscoverNearbyKey] ? [defaults boolForKey:kWCHideDiscoverNearbyKey] : NO;
    gHideDiscoverGame = [defaults objectForKey:kWCHideDiscoverGameKey] ? [defaults boolForKey:kWCHideDiscoverGameKey] : NO;
    gHideDiscoverMiniProgram = [defaults objectForKey:kWCHideDiscoverMiniProgramKey] ? [defaults boolForKey:kWCHideDiscoverMiniProgramKey] : NO;
    
}

// 设置变化回调
static void discoverSettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    loadDiscoverSettings();
}

#pragma mark - FindFriendEntryViewController Hooks

// 声明FindFriendEntryViewController类
@interface FindFriendEntryViewController : NSObject
@end

%hook FindFriendEntryViewController

// Hook shouldShowBrowseEntry - 看一看入口
// 返回NO时隐藏看一看入口
- (_Bool)shouldShowBrowseEntry {
    if (gHideDiscoverLook) {
        return NO;
    }
    return %orig;
}

// Hook shouldShowTingEntry - 听一听入口
// 返回NO时隐藏听一听入口
- (_Bool)shouldShowTingEntry {
    if (gHideDiscoverListen) {
        return NO;
    }
    return %orig;
}

// Hook shouldShowSearchEntry - 搜一搜入口
// 返回NO时隐藏搜一搜入口
- (_Bool)shouldShowSearchEntry {
    if (gHideDiscoverSearch) {
        return NO;
    }
    return %orig;
}

// Hook shouldShowScanQRCodeEntry - 扫一扫入口
// 返回NO时隐藏扫一扫入口
- (_Bool)shouldShowScanQRCodeEntry {
    if (gHideDiscoverScan) {
        return NO;
    }
    return %orig;
}

// Hook shouldShowGameEntry - 游戏入口
// 返回NO时隐藏游戏入口
- (_Bool)shouldShowGameEntry {
    if (gHideDiscoverGame) {
        return NO;
    }
    return %orig;
}

// Hook shouldShowAppBrandEntry - 小程序入口
// 返回NO时隐藏小程序入口
- (_Bool)shouldShowAppBrandEntry {
    if (gHideDiscoverMiniProgram) {
        return NO;
    }
    return %orig;
}

// Hook shouldShowNearbyLiveEntry - 附近的人入口
// 返回NO时隐藏附近的人入口
- (_Bool)shouldShowNearbyLiveEntry {
    if (gHideDiscoverNearby) {
        return NO;
    }
    return %orig;
}

%end

#pragma mark - WCFinderDataService Hooks

// 声明WCFinderDataService类 - 控制视频号和直播入口
@interface WCFinderDataService : NSObject
@end

%hook WCFinderDataService

// Hook shouldShowFinderEntry - 视频号入口 (类方法)
// 返回NO时隐藏视频号入口
+ (_Bool)shouldShowFinderEntry {
    if (gHideDiscoverChannels) {
        return NO;
    }
    return %orig;
}

// Hook shouldShowDiscoveryFinderLiveEntry - 发现页直播入口 (实例方法)
// 返回NO时隐藏直播入口
- (_Bool)shouldShowDiscoveryFinderLiveEntry {
    if (gHideDiscoverLive) {
        return NO;
    }
    return %orig;
}

// Hook shouldShowFinderLiveEntry - 视频号直播入口 (实例方法)
// 返回NO时隐藏直播入口
- (_Bool)shouldShowFinderLiveEntry {
    if (gHideDiscoverLive) {
        return NO;
    }
    return %orig;
}

%end

#pragma mark - 构造函数

// 构造函数，插件加载时执行
%ctor {
    CSBackupWhenReady(^{
        loadDiscoverSettings();

        // 注册Darwin通知，监听设置变化
        CFNotificationCenterAddObserver(
            CFNotificationCenterGetDarwinNotifyCenter(),
            NULL,
            discoverSettingsChanged,
            CFSTR("com.wechat.tweak.settings_changed"),
            NULL,
            CFNotificationSuspensionBehaviorCoalesce
        );
        %init;
    });
}
