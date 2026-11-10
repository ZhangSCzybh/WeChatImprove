#import "CSVoicePlaybackPreferences.h"
#import "CSMessageActionPreferences.h"
#import <CoreFoundation/CoreFoundation.h>

NSString *const CSVoicePlaybackProgressEnabledKey = @"com.wechat.enhance.voice_playback.progress_enabled";
NSNotificationName const CSVoicePlaybackSettingsDidChangeNotification = @"CSVoicePlaybackSettingsDidChangeNotification";

static BOOL CSVoicePlaybackBool(NSUserDefaults *defaults, NSString *key) {
    id value=[defaults objectForKey:key];
    return [value respondsToSelector:@selector(boolValue)] ? [value boolValue] : NO;
}

@interface CSVoicePlaybackPreferences () {
    NSUserDefaults *_defaults;
    NSArray *_observers;
    BOOL _progressEnabled, _refreshPending;
}
@end

static void CSVoicePlaybackDarwinChanged(__unused CFNotificationCenterRef center, void *observer,
    __unused CFStringRef name, __unused const void *object, __unused CFDictionaryRef userInfo) {
    [(__bridge CSVoicePlaybackPreferences *)observer requestRefresh];
}

@implementation CSVoicePlaybackPreferences
+ (instancetype)sharedPreferences {
    static CSVoicePlaybackPreferences *preferences;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ preferences=[[self alloc] initWithDefaults:NSUserDefaults.standardUserDefaults]; });
    return preferences;
}
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults {
    if ((self=[super init])) {
        _defaults=defaults;
        _progressEnabled=CSVoicePlaybackBool(defaults,CSVoicePlaybackProgressEnabledKey);
        __weak typeof(self) weakSelf=self;
        NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
        id defaultsObserver=[center addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil
            usingBlock:^(__unused NSNotification *note){ [weakSelf requestRefresh]; }];
        // Keep this module Foundation-only while observing UIKit activation.
        id activationObserver=[center addObserverForName:@"UIApplicationDidBecomeActiveNotification" object:nil queue:nil
            usingBlock:^(__unused NSNotification *note){ [weakSelf requestRefresh]; }];
        _observers=@[defaultsObserver,activationObserver];
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),(__bridge const void *)self,
            CSVoicePlaybackDarwinChanged,(__bridge CFStringRef)CSMessageActionVoiceForwardDarwinNotification,NULL,
            CFNotificationSuspensionBehaviorCoalesce);
    }
    return self;
}
- (BOOL)progressEnabled { @synchronized(self) { return _progressEnabled; } }
- (void)requestRefresh {
    @synchronized(self) {
        if (_refreshPending) return;
        _refreshPending=YES;
    }
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf refreshOnMain]; });
}
- (void)refreshOnMain {
    NSAssert(NSThread.isMainThread,@"Playback settings updates must run on main");
    @synchronized(self) { _refreshPending=NO; }
    // A defaults read may synchronously call observers. Never hold our lock here.
    BOOL progress=CSVoicePlaybackBool(_defaults,CSVoicePlaybackProgressEnabledKey);
    BOOL changed;
    @synchronized(self) {
        changed=_progressEnabled!=progress;
        _progressEnabled=progress;
    }
    if (changed) [NSNotificationCenter.defaultCenter postNotificationName:CSVoicePlaybackSettingsDidChangeNotification object:self];
}
- (void)dealloc {
    for (id observer in _observers) [NSNotificationCenter.defaultCenter removeObserver:observer];
    CFNotificationCenterRemoveEveryObserver(CFNotificationCenterGetDarwinNotifyCenter(),(__bridge const void *)self);
}
@end
