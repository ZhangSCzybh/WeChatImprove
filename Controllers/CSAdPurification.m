#import "CSAdPurification.h"
#import "CSCloseFriendSignatures.h"
#import "CSPreferenceRefresh.h"
#ifndef CS_AD_PURIFICATION_TESTING
#import <substrate.h>
#endif

NSString *const CSAdPurificationEnabledKey = @"com.wechat.enhance.ad_purification.enabled";
NSNotificationName const CSAdPurificationChangedNotification = @"CSAdPurificationChangedNotification";
static atomic_uint_fast64_t ActiveScopes;
static atomic_bool Started, RefreshPending;
static NSUserDefaults *AdDefaults;
static NSDictionary *PublishedSettings;
static NSMutableSet<NSString *> *Installed;
static uint64_t Revision;
static NSUInteger PendingWrites;

static NSObject *PolicyLock(void) {
    static NSObject *lock; static dispatch_once_t once;
    dispatch_once(&once, ^{ lock = [NSObject new]; }); return lock;
}
static NSObject *InstallationLock(void) {
    static NSObject *lock; static dispatch_once_t once;
    dispatch_once(&once, ^{ lock = [NSObject new]; }); return lock;
}
NSArray<NSDictionary *> *CSAdPurificationOptions(void) {
    static NSArray *rows; static dispatch_once_t once;
    dispatch_once(&once, ^{
        rows = @[
            @{@"identifier":@"articles", @"title":@"公众号文章广告", @"icon":@"doc.text", @"capability":@(CSAdPurificationArticles)},
            @{@"identifier":@"subscriptions", @"title":@"订阅号广告", @"icon":@"rectangle.stack", @"capability":@(CSAdPurificationSubscriptions)},
            @{@"identifier":@"moments", @"title":@"朋友圈广告", @"icon":@"camera.aperture", @"capability":@(CSAdPurificationMoments)},
            @{@"identifier":@"finder", @"title":@"视频号广告", @"icon":@"play.rectangle", @"capability":@(CSAdPurificationFinder)},
            @{@"identifier":@"mini_programs", @"title":@"小程序广告", @"icon":@"app.dashed", @"capability":@(CSAdPurificationMiniPrograms)},
            @{@"identifier":@"search", @"title":@"搜一搜广告", @"icon":@"magnifyingglass", @"capability":@(CSAdPurificationSearch)},
            @{@"identifier":@"recommendations", @"title":@"订阅号推荐内容", @"icon":@"sparkles", @"capability":@(CSAdPurificationRecommendations)},
        ];
    }); return rows;
}
NSString *CSAdPurificationPreferenceKey(NSString *identifier) {
    return [@"com.wechat.enhance.ad_purification." stringByAppendingString:identifier];
}
static NSUserDefaults *Defaults(void) { return AdDefaults ?: NSUserDefaults.standardUserDefaults; }
static BOOL ReadBool(NSUserDefaults *defaults, NSString *key) {
    id value = [defaults objectForKey:key];
    return [value isKindOfClass:NSNumber.class] && ([value isEqual:@YES] || [value isEqual:@NO]) && [value boolValue];
}
BOOL CSAdPurificationSetting(NSString *key) { return ReadBool(Defaults(), key); }
static NSDictionary *RelevantSettings(void) {
    NSUserDefaults *defaults = Defaults();
    NSMutableDictionary *values = [NSMutableDictionary dictionaryWithObject:@(ReadBool(defaults, CSAdPurificationEnabledKey)) forKey:CSAdPurificationEnabledKey];
    for (NSDictionary *row in CSAdPurificationOptions()) {
        NSString *key = CSAdPurificationPreferenceKey(row[@"identifier"]);
        values[key] = @(ReadBool(defaults, key));
    }
    return [values copy];
}
static void RequestRefresh(void) {
    if (!atomic_load_explicit(&Started, memory_order_acquire)) return;
    CSRequestMainRefresh(&RefreshPending, ^{ CSAdPurificationRefresh(); });
}
void CSAdPurificationSetSetting(NSString *key, BOOL value) {
    CSAdPurificationScope scope = 0;
    BOOL master = [key isEqualToString:CSAdPurificationEnabledKey];
    for (NSDictionary *row in CSAdPurificationOptions())
        if ([key isEqualToString:CSAdPurificationPreferenceKey(row[@"identifier"])]) scope = [row[@"capability"] unsignedLongLongValue];
    if (!master && !scope) return;
    @synchronized (PolicyLock()) {
        Revision++; PendingWrites++;
        // Disabling is synchronous. An older queued publication cannot re-enable it.
        if (!value && master) atomic_store_explicit(&ActiveScopes, 0, memory_order_release);
        else if (!value) atomic_fetch_and_explicit(&ActiveScopes, ~(uint64_t)scope, memory_order_acq_rel);
    }
    // Defaults can synchronously notify other modules. Never hold the policy lock
    // during I/O or notification delivery; pending writes prevent stale publication.
    @try { [Defaults() setBool:value forKey:key]; }
    @finally {
        @synchronized (PolicyLock()) {
            PendingWrites--; Revision++;
            if (!value && master) atomic_store_explicit(&ActiveScopes, 0, memory_order_release);
            else if (!value) atomic_fetch_and_explicit(&ActiveScopes, ~(uint64_t)scope, memory_order_acq_rel);
        }
        RequestRefresh();
    }
}
CSAdPurificationScope CSAdPurificationActiveScopes(void) {
    return atomic_load_explicit(&ActiveScopes, memory_order_acquire);
}
BOOL CSAdPurificationShouldApply(CSAdPurificationScope scope) {
    return (CSAdPurificationActiveScopes() & scope) != 0;
}
void CSAdPurificationRefresh(void) {
    if (!atomic_load_explicit(&Started, memory_order_acquire)) return;
    if (!NSThread.isMainThread) { RequestRefresh(); return; }
    uint64_t revision;
    @synchronized (PolicyLock()) { if (PendingWrites) { RequestRefresh(); return; } revision = Revision; }
    // Native defaults notifications can re-enter observers. Do not read while publishing.
    NSDictionary *settings = RelevantSettings();
    CSAdPurificationScope scopes = 0;
    if ([settings[CSAdPurificationEnabledKey] boolValue])
        for (NSDictionary *row in CSAdPurificationOptions())
            if ([settings[CSAdPurificationPreferenceKey(row[@"identifier"])] boolValue]) scopes |= [row[@"capability"] unsignedLongLongValue];
    BOOL changed;
    @synchronized (PolicyLock()) {
        if (PendingWrites || revision != Revision) { RequestRefresh(); return; }
        changed = ![PublishedSettings isEqual:settings];
        PublishedSettings = settings;
        atomic_store_explicit(&ActiveScopes, scopes, memory_order_release);
    }
    // Retry missing interfaces on activation as well as on a settings change.
    // Installed wrappers stay in the predecessor chain and read the current mask.
    if (scopes) { CSAdPurificationInstallNativeHooks(); CSAdPurificationInstallWebHooks(); }
    if (changed) [NSNotificationCenter.defaultCenter postNotificationName:CSAdPurificationChangedNotification object:nil];
}
void CSAdPurificationStart(void) {
    if (atomic_exchange_explicit(&Started, true, memory_order_acq_rel)) return;
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
        @synchronized (PolicyLock()) { Revision++; }
        RequestRefresh();
    }];
    [center addObserverForName:@"UIApplicationDidBecomeActiveNotification" object:nil queue:nil usingBlock:^(__unused NSNotification *note) { RequestRefresh(); }];
    CSAdPurificationRefresh();
}
BOOL CSAdPurificationInstallHook(NSString *className, NSString *name, BOOL classMethod,
    const char *encoding, IMP replacement, IMP *original) {
    @synchronized (InstallationLock()) {
        NSString *identity = [NSString stringWithFormat:@"%c[%@ %@]", classMethod ? '+' : '-', className, name];
        if (!Installed) Installed = [NSMutableSet set];
        if ([Installed containsObject:identity]) { if (replacement) imp_removeBlock(replacement); return YES; }
        Class cls = NSClassFromString(className);
        if (cls && classMethod) cls = object_getClass(cls);
        SEL selector = NSSelectorFromString(name);
        Method method = cls ? class_getInstanceMethod(cls, selector) : NULL;
        if (!CSAdPurificationActiveScopes() || !replacement || !original || !CSCloseFriendMethodMatches(method, encoding)) {
            if (replacement) imp_removeBlock(replacement); return NO;
        }
        IMP predecessor = method_getImplementation(method);
        *original = predecessor;
        [Installed addObject:identity];
#ifdef CS_AD_PURIFICATION_TESTING
        CSAdPurificationTestHookMessage(cls, selector, replacement, original);
#else
        MSHookMessageEx(cls, selector, replacement, original);
#endif
        if (!*original) *original = predecessor;
        return YES;
    }
}
#ifdef CS_AD_PURIFICATION_TESTING
void CSAdPurificationUseTestDefaults(NSUserDefaults *defaults) {
    @synchronized (PolicyLock()) { AdDefaults = defaults; PublishedSettings = nil; Revision++; atomic_store(&ActiveScopes, 0); }
}
NSUInteger CSAdPurificationInstalledHookCount(void) { @synchronized (InstallationLock()) { return Installed.count; } }
#endif
