#import "CSClownPreferences.h"

NSString *const CSClownEnabledKey = @"com.wechat.enhance.clown.enabled";
NSString *const CSClownTextEnabledKey = @"com.wechat.enhance.clown.text.enabled";
NSString *const CSClownTimeEnabledKey = @"com.wechat.enhance.clown.time.enabled";
NSString *const CSClownImageEnabledKey = @"com.wechat.enhance.clown.image.enabled";
NSString *const CSClownAmountEnabledKey = @"com.wechat.enhance.clown.amount.enabled";
NSNotificationName const CSClownSettingsDidChangeNotification = @"CSClownSettingsDidChangeNotification";

static BOOL CSClownBool(NSUserDefaults *defaults, NSString *key) {
    id value = [defaults objectForKey:key];
    return [value respondsToSelector:@selector(boolValue)] ? [value boolValue] : NO;
}

@interface CSClownSettings ()
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
- (BOOL)hasSameValuesAs:(CSClownSettings *)other;
@end

@implementation CSClownSettings
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults {
    if ((self = [super init])) {
        _enabled = CSClownBool(defaults, CSClownEnabledKey);
        _textEnabled = _enabled && CSClownBool(defaults, CSClownTextEnabledKey);
        _timeEnabled = _enabled && CSClownBool(defaults, CSClownTimeEnabledKey);
        _imageEnabled = _enabled && CSClownBool(defaults, CSClownImageEnabledKey);
        _amountEnabled = _enabled && CSClownBool(defaults, CSClownAmountEnabledKey);
    }
    return self;
}
- (BOOL)hasSameValuesAs:(CSClownSettings *)other {
    return self.enabled == other.enabled && self.textEnabled == other.textEnabled &&
        self.timeEnabled == other.timeEnabled && self.imageEnabled == other.imageEnabled &&
        self.amountEnabled == other.amountEnabled;
}
@end

@interface CSClownPreferences () {
    NSUserDefaults *_defaults;
    CSClownSettings *_snapshot;
    NSArray *_observers;
    BOOL _refreshPending;
}
@end

@implementation CSClownPreferences
+ (instancetype)sharedPreferences {
    static CSClownPreferences *preferences;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        preferences = [[self alloc] initWithDefaults:NSUserDefaults.standardUserDefaults];
    });
    return preferences;
}
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults {
    if ((self = [super init])) {
        _defaults = defaults;
        _snapshot = [[CSClownSettings alloc] initWithDefaults:defaults];
        __weak typeof(self) weakSelf = self;
        NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
        id defaultsObserver = [center addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil
            usingBlock:^(__unused NSNotification *note) { [weakSelf requestRefresh]; }];
        // Keep this preferences core independent of UIKit for host tests.
        id activationObserver = [center addObserverForName:@"UIApplicationDidBecomeActiveNotification" object:nil queue:nil
            usingBlock:^(__unused NSNotification *note) { [weakSelf requestRefresh]; }];
        _observers = @[defaultsObserver, activationObserver];
    }
    return self;
}
- (CSClownSettings *)snapshot {
    @synchronized(self) { return _snapshot; }
}
- (void)requestRefresh {
    @synchronized(self) {
        if (_refreshPending) return;
        _refreshPending = YES;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf refreshOnMain]; });
}
- (void)refreshOnMain {
    NSAssert(NSThread.isMainThread, @"Clown settings updates must run on main");
    @synchronized(self) { _refreshPending = NO; }
    // Reading defaults can synchronously notify other threads; do not hold the snapshot lock here.
    CSClownSettings *candidate = [[CSClownSettings alloc] initWithDefaults:_defaults];
    BOOL changed = NO;
    @synchronized(self) {
        if (![_snapshot hasSameValuesAs:candidate]) {
            _snapshot = candidate;
            changed = YES;
        }
    }
    if (changed) {
        [NSNotificationCenter.defaultCenter postNotificationName:CSClownSettingsDidChangeNotification object:self];
    }
}
- (void)dealloc {
    for (id observer in _observers) [NSNotificationCenter.defaultCenter removeObserver:observer];
}
@end
