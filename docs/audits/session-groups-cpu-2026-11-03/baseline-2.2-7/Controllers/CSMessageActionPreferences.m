#import "CSMessageActionPreferences.h"
#import <CoreFoundation/CoreFoundation.h>

NSString *const CSMessageActionGestureEnabledKey = @"com.wechat.enhance.message_gesture.enabled";
NSString *const CSMessageActionRepeatEnabledKey = @"com.wechat.enhance.repeat.enabled";
NSString *const CSMessageActionVoiceForwardEnabledKey = @"com.wechat.enhance.voice_forward.enabled";
NSString *const CSMessageActionImageStickerEnabledKey = @"com.wechat.enhance.image_sticker.enabled";
NSString *const CSMessageActionLeftOtherKey = @"com.wechat.enhance.left_swipe_other.action";
NSString *const CSMessageActionLeftSelfKey = @"com.wechat.enhance.left_swipe_self.action";
NSString *const CSMessageActionRightOtherKey = @"com.wechat.enhance.right_swipe_other.action";
NSString *const CSMessageActionRightSelfKey = @"com.wechat.enhance.right_swipe_self.action";
NSNotificationName const CSMessageActionSettingsDidChangeNotification = @"CSMessageActionSettingsDidChangeNotification";
NSString *const CSMessageActionGestureDarwinNotification = @"com.wechat.enhance.message_gesture.settings_changed";
NSString *const CSMessageActionRepeatDarwinNotification = @"com.wechat.enhance.repeat.settings_changed";
NSString *const CSMessageActionVoiceForwardDarwinNotification = @"com.wechat.enhance.voice_forward.settings_changed";

static NSInteger CSActionInteger(NSUserDefaults *defaults, NSString *key) {
    id value=[defaults objectForKey:key];
    return [value respondsToSelector:@selector(integerValue)] ? [value integerValue] : 0;
}
static BOOL CSActionBool(NSUserDefaults *defaults, NSString *key) {
    id value=[defaults objectForKey:key];
    return [value respondsToSelector:@selector(boolValue)] ? [value boolValue] : NO;
}
@implementation CSMessageActionSettings
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults version:(NSUInteger)version {
    if ((self=[super init])) {
        _gestureEnabled=CSActionBool(defaults,CSMessageActionGestureEnabledKey);
        _repeatEnabled=CSActionBool(defaults,CSMessageActionRepeatEnabledKey);
        _voiceForwardEnabled=CSActionBool(defaults,CSMessageActionVoiceForwardEnabledKey);
        _imageStickerEnabled=CSActionBool(defaults,CSMessageActionImageStickerEnabledKey);
        _leftOtherAction=CSActionInteger(defaults,CSMessageActionLeftOtherKey);
        _leftSelfAction=CSActionInteger(defaults,CSMessageActionLeftSelfKey);
        _rightOtherAction=CSActionInteger(defaults,CSMessageActionRightOtherKey);
        _rightSelfAction=CSActionInteger(defaults,CSMessageActionRightSelfKey);
        _version=version;
    }
    return self;
}
- (BOOL)hasSameValuesAs:(CSMessageActionSettings *)other {
    return _gestureEnabled==other.gestureEnabled && _repeatEnabled==other.repeatEnabled &&
        _voiceForwardEnabled==other.voiceForwardEnabled && _imageStickerEnabled==other.imageStickerEnabled && _leftOtherAction==other.leftOtherAction &&
        _leftSelfAction==other.leftSelfAction && _rightOtherAction==other.rightOtherAction &&
        _rightSelfAction==other.rightSelfAction;
}
@end

@interface CSMessageActionPreferences () {
    NSUserDefaults *_defaults;
    CSMessageActionSettings *_snapshot;
    NSArray *_observers;
    BOOL _refreshPending;
}
@end
static void CSActionDarwinChanged(__unused CFNotificationCenterRef center, void *observer,
    __unused CFStringRef name, __unused const void *object, __unused CFDictionaryRef userInfo) {
    [(__bridge CSMessageActionPreferences *)observer requestRefresh];
}
static NSArray<NSString *> *CSActionDarwinNames(void) {
    return @[CSMessageActionGestureDarwinNotification,CSMessageActionRepeatDarwinNotification,
        CSMessageActionVoiceForwardDarwinNotification];
}
@implementation CSMessageActionPreferences
+ (instancetype)sharedPreferences {
    static CSMessageActionPreferences *preferences;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ preferences=[[self alloc] initWithDefaults:NSUserDefaults.standardUserDefaults]; });
    return preferences;
}
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults {
    if ((self=[super init])) {
        _defaults=defaults;
        _snapshot=[[CSMessageActionSettings alloc] initWithDefaults:defaults version:1];
        __weak typeof(self) weakSelf=self;
        NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
        id defaultsObserver=[center addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil
            usingBlock:^(__unused NSNotification *note) { [weakSelf requestRefresh]; }];
        // Foundation core intentionally does not link UIKit. This is UIKit's public notification name.
        id activationObserver=[center addObserverForName:@"UIApplicationDidBecomeActiveNotification" object:nil queue:nil
            usingBlock:^(__unused NSNotification *note) { [weakSelf requestRefresh]; }];
        _observers=@[defaultsObserver,activationObserver];
        for (NSString *name in CSActionDarwinNames())
            CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),(__bridge const void *)self,
                CSActionDarwinChanged,(__bridge CFStringRef)name,NULL,CFNotificationSuspensionBehaviorCoalesce);
    }
    return self;
}
- (CSMessageActionSettings *)snapshot { @synchronized(self) { return _snapshot; } }
- (void)requestRefresh {
    @synchronized(self) {
        if (_refreshPending) return;
        _refreshPending=YES;
    }
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf refreshOnMain]; });
}
- (void)refreshOnMain {
    NSAssert(NSThread.isMainThread,@"Settings updates must run on main");
    BOOL changed=NO;
    NSUInteger version;
    @synchronized(self) { _refreshPending=NO; version=_snapshot.version+1; }
    // Defaults may synchronously notify a worker that needs requestRefresh's
    // lock. Never read preferences while holding that lock.
    CSMessageActionSettings *candidate=[[CSMessageActionSettings alloc] initWithDefaults:_defaults version:version];
    @synchronized(self) {
        if (![_snapshot hasSameValuesAs:candidate]) { _snapshot=candidate; changed=YES; }
    }
    if (changed) [NSNotificationCenter.defaultCenter postNotificationName:CSMessageActionSettingsDidChangeNotification object:self];
}
- (void)dealloc {
    for (id observer in _observers) [NSNotificationCenter.defaultCenter removeObserver:observer];
    CFNotificationCenterRemoveEveryObserver(CFNotificationCenterGetDarwinNotifyCenter(),(__bridge const void *)self);
}
@end
