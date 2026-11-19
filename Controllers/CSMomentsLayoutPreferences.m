#import "CSMomentsLayoutPreferences.h"
#import "CSPreferenceRefresh.h"

NSString *const CSMomentsLayoutEnabledKey = @"com.wechat.enhance.moments_layout.enabled";
NSNotificationName const CSMomentsLayoutChangedNotification = @"CSMomentsLayoutChangedNotification";

static atomic_bool Enabled, Started, RefreshPending;
#ifdef CS_MOMENTS_LAYOUT_TESTING
static NSUserDefaults *MomentsDefaults;
#endif
static NSNumber *PublishedEnabled;
static NSUInteger Revision, PendingWrites;

static NSObject *PolicyLock(void) {
    static NSObject *lock;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ lock = [NSObject new]; });
    return lock;
}

static NSUserDefaults *Defaults(void) {
#ifdef CS_MOMENTS_LAYOUT_TESTING
    if (MomentsDefaults) return MomentsDefaults;
#endif
    return NSUserDefaults.standardUserDefaults;
}

static void RequestRefresh(void) {
    if (!atomic_load_explicit(&Started, memory_order_acquire)) return;
    CSRequestMainRefresh(&RefreshPending, ^{ CSMomentsLayoutRefresh(); });
}

BOOL CSMomentsLayoutEnabled(void) {
    return atomic_load_explicit(&Enabled, memory_order_acquire);
}

void CSMomentsLayoutSetEnabled(BOOL enabled) {
    @synchronized (PolicyLock()) {
        Revision++;
        PendingWrites++;
        if (!enabled) atomic_store_explicit(&Enabled, false, memory_order_release);
    }
    // Defaults observers may re-enter this module. Never hold the policy lock
    // during I/O; an older in-flight read must not republish the disabled policy.
    @try {
        [Defaults() setBool:enabled forKey:CSMomentsLayoutEnabledKey];
    } @finally {
        @synchronized (PolicyLock()) {
            PendingWrites--;
            Revision++;
            if (!enabled) atomic_store_explicit(&Enabled, false, memory_order_release);
        }
        RequestRefresh();
    }
}

void CSMomentsLayoutRefresh(void) {
    if (!atomic_load_explicit(&Started, memory_order_acquire)) return;
    if (!NSThread.isMainThread) { RequestRefresh(); return; }
    NSUInteger revision;
    @synchronized (PolicyLock()) {
        if (PendingWrites) { RequestRefresh(); return; }
        revision = Revision;
    }
    id value = [Defaults() objectForKey:CSMomentsLayoutEnabledKey];
    BOOL enabled = [value isKindOfClass:NSNumber.class] && [value isEqual:@YES];
    BOOL changed;
    @synchronized (PolicyLock()) {
        if (PendingWrites || revision != Revision) { RequestRefresh(); return; }
        changed = !PublishedEnabled || PublishedEnabled.boolValue != enabled;
        PublishedEnabled = @(enabled);
        atomic_store_explicit(&Enabled, enabled, memory_order_release);
    }
    if (changed) [NSNotificationCenter.defaultCenter postNotificationName:CSMomentsLayoutChangedNotification object:nil];
}

void CSMomentsLayoutStart(void) {
    if (atomic_exchange_explicit(&Started, true, memory_order_acq_rel)) return;
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil
        usingBlock:^(__unused NSNotification *note) {
            @synchronized (PolicyLock()) { Revision++; }
            RequestRefresh();
        }];
    [center addObserverForName:@"UIApplicationDidBecomeActiveNotification" object:nil queue:nil
        usingBlock:^(__unused NSNotification *note) { RequestRefresh(); }];
    CSMomentsLayoutRefresh();
}

#ifdef CS_MOMENTS_LAYOUT_TESTING
void CSMomentsLayoutUseTestDefaults(NSUserDefaults *defaults) {
    NSCAssert(!atomic_load(&Started), @"Inject test defaults before starting moments layout");
    MomentsDefaults = defaults;
}
#endif
