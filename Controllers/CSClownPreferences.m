#import "CSClownPreferences.h"

NSString *const CSClownEnabledKey = @"com.wechat.enhance.clown.enabled";
NSString *const CSClownTextEnabledKey = @"com.wechat.enhance.clown.text.enabled";
NSString *const CSClownTimeEnabledKey = @"com.wechat.enhance.clown.time.enabled";
NSString *const CSClownImageEnabledKey = @"com.wechat.enhance.clown.image.enabled";
NSString *const CSClownAmountEnabledKey = @"com.wechat.enhance.clown.amount.enabled";
NSString *const CSClownWarmthEnabledKey = @"com.wechat.enhance.clown.warmth.enabled";
NSString *const CSClownWarmthTargetsKey = @"com.wechat.enhance.clown.warmth.targets";
NSString *const CSClownFakeQuoteEnabledKey = @"com.wechat.enhance.clown.fake_quote.enabled";
NSNotificationName const CSClownSettingsDidChangeNotification = @"CSClownSettingsDidChangeNotification";

static BOOL CSClownBool(NSUserDefaults *defaults, NSString *key) {
    id value = [defaults objectForKey:key];
    return [value respondsToSelector:@selector(boolValue)] ? [value boolValue] : NO;
}

@interface CSClownSettings ()
@property(nonatomic, copy) NSDictionary *warmthTargets;
@property(nonatomic, copy) NSDictionary<NSString *, NSSet<NSString *> *> *warmthConversations;
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
        _warmthEnabled = _enabled && CSClownBool(defaults, CSClownWarmthEnabledKey);
        _fakeQuoteEnabled = _enabled && CSClownBool(defaults, CSClownFakeQuoteEnabledKey);
        id targets = [defaults objectForKey:CSClownWarmthTargetsKey];
        _warmthTargets = [targets isKindOfClass:NSDictionary.class] ? [targets copy] : @{};
        NSMutableDictionary *conversations = [NSMutableDictionary dictionary];
        for (id account in _warmthTargets) if ([account isKindOfClass:NSString.class] && [account length]) {
            NSMutableSet *names = [NSMutableSet setWithArray:[self warmthTargetsForAccount:account groups:NO]];
            [names addObjectsFromArray:[self warmthTargetsForAccount:account groups:YES]];
            conversations[account] = [names copy];
        }
        _warmthConversations = conversations;
    }
    return self;
}
- (BOOL)hasSameValuesAs:(CSClownSettings *)other {
    return self.enabled == other.enabled && self.textEnabled == other.textEnabled &&
        self.timeEnabled == other.timeEnabled && self.imageEnabled == other.imageEnabled &&
        self.amountEnabled == other.amountEnabled && self.warmthEnabled == other.warmthEnabled &&
        self.fakeQuoteEnabled == other.fakeQuoteEnabled && [self.warmthTargets isEqual:other.warmthTargets];
}
- (NSArray<NSString *> *)warmthTargetsForAccount:(NSString *)account groups:(BOOL)groups {
    id profile = account.length ? self.warmthTargets[account] : nil;
    id names = [profile isKindOfClass:NSDictionary.class] ? profile[groups ? @"groups" : @"contacts"] : nil;
    if (![names isKindOfClass:NSArray.class]) return @[];
    NSMutableOrderedSet *valid = [NSMutableOrderedSet orderedSet];
    for (id name in names) if ([name isKindOfClass:NSString.class] && [name length] &&
        [name hasSuffix:@"@chatroom"] == groups) [valid addObject:name];
    return valid.array;
}
- (BOOL)warmsConversation:(NSString *)conversation account:(NSString *)account {
    return self.warmthEnabled && conversation.length && account.length &&
        [self.warmthConversations[account] containsObject:conversation];
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
- (void)setWarmthTargets:(NSArray<NSString *> *)names account:(NSString *)account groups:(BOOL)groups {
    if (!NSThread.isMainThread || !account.length) return;
    id stored = [_defaults objectForKey:CSClownWarmthTargetsKey];
    NSMutableDictionary *targets = [stored isKindOfClass:NSDictionary.class] ? [stored mutableCopy] : [NSMutableDictionary dictionary];
    id prior = targets[account];
    NSMutableDictionary *profile = [prior isKindOfClass:NSDictionary.class] ? [prior mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableOrderedSet *valid = [NSMutableOrderedSet orderedSet];
    for (id name in names) if ([name isKindOfClass:NSString.class] && [name length] &&
        [name hasSuffix:@"@chatroom"] == groups) [valid addObject:name];
    profile[groups ? @"groups" : @"contacts"] = valid.array;
    targets[account] = profile;
    [_defaults setObject:targets forKey:CSClownWarmthTargetsKey];
    [self requestRefresh];
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
