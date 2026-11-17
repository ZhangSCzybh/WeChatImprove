#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSAdPurification.h"
#include <stdbool.h>
#include <stdatomic.h>

static NSUInteger Assertions, NativeInstallCalls, WebInstallCalls, HookCalls;
static NSUInteger BaselineCalls, PredecessorCalls, ClassBaselineCalls;
static IMP BaselineProbe, PreviousProbe, PreviousClassProbe;
static atomic_bool Completed;
#define CHECK(condition) do { Assertions++; if (!(condition)) { NSLog(@"AdPurification preferences FAIL %d: %s", __LINE__, #condition); exit(1); } } while (0)

// Exercise the real preferences and installer while keeping all actual WeChat
// providers out of this Foundation-only process.
void CSAdPurificationInstallNativeHooks(void) { NativeInstallCalls++; }
void CSAdPurificationInstallWebHooks(void) { WebInstallCalls++; }
void CSAdPurificationTestHookMessage(Class cls, SEL selector, IMP replacement, IMP *original) {
    Method method = class_getInstanceMethod(cls, selector);
    *original = method_getImplementation(method);
    if (!class_addMethod(cls, selector, replacement, method_getTypeEncoding(method)))
        method_setImplementation(method, replacement);
    HookCalls++;
}

@interface CSAdPreferencesDefaults : NSUserDefaults
@property(nonatomic, copy) NSString *interceptedKey;
@property(nonatomic, copy) void (^afterRead)(void);
@property(nonatomic, copy) NSString *interceptedWriteKey;
@property(nonatomic, copy) void (^afterWrite)(void);
@end
@implementation CSAdPreferencesDefaults
- (id)objectForKey:(NSString *)key {
    id result = [super objectForKey:key];
    if (self.afterRead && [key isEqualToString:self.interceptedKey]) {
        void (^callback)(void) = self.afterRead;
        self.afterRead = nil;
        callback();
    }
    return result;
}
- (void)setBool:(BOOL)value forKey:(NSString *)key {
    [super setBool:value forKey:key];
    if (self.afterWrite && [key isEqualToString:self.interceptedWriteKey]) {
        void (^callback)(void) = self.afterWrite;
        self.afterWrite = nil;
        callback();
    }
}
@end

@interface CSAdPreferenceHookFixture : NSObject
- (id)probe:(id)value;
+ (id)classProbe:(id)value;
@end
@implementation CSAdPreferenceHookFixture
- (id)probe:(id)value { BaselineCalls++; return value; }
+ (id)classProbe:(id)value { ClassBaselineCalls++; return value; }
@end

static id PredecessorProbe(id object, SEL selector, id value) {
    PredecessorCalls++;
    return ((id (*)(id, SEL, id))BaselineProbe)(object, selector, value);
}
static id NativePassthrough(id object, SEL selector, id value) {
    (void)object; (void)selector;
    return value;
}
static void DrainMainQueue(void) {
    // A publication can enqueue a second refresh while rejecting an obsolete
    // snapshot. Several barriers drain that finite work without a timed sleep.
    for (NSUInteger pass = 0; pass < 4; pass++) {
        __block BOOL done = NO;
        dispatch_async(dispatch_get_main_queue(), ^{ done = YES; });
        NSDate *deadline = [NSDate dateWithTimeIntervalSinceNow:2];
        while (!done && deadline.timeIntervalSinceNow > 0)
            [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.002]];
        CHECK(done);
    }
}
static void RunWorker(dispatch_block_t work) {
    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    // dispatch_sync is allowed to execute a global-queue block on the caller's
    // thread. Use an asynchronous worker so this verifies a real thread handoff.
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        CHECK(!NSThread.isMainThread);
        work();
        dispatch_semaphore_signal(done);
    });
    CHECK(dispatch_semaphore_wait(done, dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC)) == 0);
}
static void Configure(NSUserDefaults *defaults, CSAdPurificationScope scopes, BOOL master) {
    for (NSDictionary *row in CSAdPurificationOptions())
        [defaults setBool:(scopes & [row[@"capability"] unsignedLongLongValue]) != 0
                  forKey:CSAdPurificationPreferenceKey(row[@"identifier"])];
    [defaults setBool:master forKey:CSAdPurificationEnabledKey];
    CSAdPurificationRefresh();
}
static void CheckInvalidInstaller(NSString *className, NSString *selector, BOOL classMethod, const char *encoding) {
    NSUInteger before = HookCalls, installed = CSAdPurificationInstalledHookCount();
    IMP original = NULL;
    CHECK(!CSAdPurificationInstallHook(className, selector, classMethod, encoding, (IMP)NativePassthrough, &original));
    CHECK(original == NULL);
    CHECK(HookCalls == before && CSAdPurificationInstalledHookCount() == installed);
}

int main(void) { @autoreleasepool {
    // A deadlock is a test failure, including regressions caused by synchronous
    // defaults observers during publication or a nested write.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 15 * NSEC_PER_SEC), dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        if (!atomic_load(&Completed)) { NSLog(@"AdPurification preferences timed out"); exit(2); }
    });
    NSString *suite = [@"AdPurificationPreferencesTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    CSAdPreferencesDefaults *defaults = [[CSAdPreferencesDefaults alloc] initWithSuiteName:suite];
    [defaults removePersistentDomainForName:suite];
    CSAdPurificationUseTestDefaults(defaults);

    CHECK(CSAdPurificationOptions().count == 7);
    NSSet *expected = [NSSet setWithArray:@[@"articles", @"subscriptions", @"moments", @"finder", @"mini_programs", @"search", @"recommendations"]];
    NSMutableSet *identifiers = [NSMutableSet set];
    CSAdPurificationScope all = 0;
    for (NSDictionary *row in CSAdPurificationOptions()) {
        NSString *identifier = row[@"identifier"];
        CHECK(row[@"title"] && row[@"icon"] && row[@"capability"]);
        CHECK(![identifiers containsObject:identifier]);
        [identifiers addObject:identifier];
        CSAdPurificationScope bit = [row[@"capability"] unsignedLongLongValue];
        CHECK(bit && !(all & bit));
        all |= bit;
        CHECK(!CSAdPurificationSetting(CSAdPurificationPreferenceKey(identifier)));
    }
    CHECK([identifiers isEqual:expected]);
    CHECK(all == 127);
    CHECK(!CSAdPurificationSetting(CSAdPurificationEnabledKey));
    CHECK([defaults persistentDomainForName:suite].count == 0);
    CSAdPurificationStart();
    CSAdPurificationStart();
    CHECK(CSAdPurificationActiveScopes() == 0);
    CHECK(NativeInstallCalls == 0 && WebInstallCalls == 0 && HookCalls == 0);
    CHECK([defaults persistentDomainForName:suite].count == 0);

    __block NSUInteger notifications = 0;
    id observer = [NSNotificationCenter.defaultCenter addObserverForName:CSAdPurificationChangedNotification object:nil queue:nil
        usingBlock:^(__unused NSNotification *note) { CHECK(NSThread.isMainThread); notifications++; }];

    NSString *article = CSAdPurificationPreferenceKey(@"articles");
    NSString *finder = CSAdPurificationPreferenceKey(@"finder");
    CSAdPurificationSetSetting(article, YES);
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationSetting(article));
    CHECK(CSAdPurificationActiveScopes() == 0);
    CSAdPurificationSetSetting(CSAdPurificationEnabledKey, YES);
    CHECK(CSAdPurificationActiveScopes() == 0);
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == CSAdPurificationArticles);
    CHECK(CSAdPurificationShouldApply(CSAdPurificationArticles));
    CHECK(!CSAdPurificationShouldApply(CSAdPurificationFinder));
    CHECK(!CSAdPurificationShouldApply(0));
    CHECK(!CSAdPurificationShouldApply((CSAdPurificationScope)(1ULL << 40)));
    CHECK(NativeInstallCalls > 0 && WebInstallCalls > 0);

    CSAdPurificationSetSetting(finder, YES);
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == (CSAdPurificationArticles | CSAdPurificationFinder));
    CSAdPurificationSetSetting(article, NO);
    CHECK(CSAdPurificationActiveScopes() == CSAdPurificationFinder);
    CSAdPurificationSetSetting(article, YES);
    CHECK(CSAdPurificationActiveScopes() == CSAdPurificationFinder);
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == (CSAdPurificationArticles | CSAdPurificationFinder));
    CSAdPurificationSetSetting(CSAdPurificationEnabledKey, NO);
    CHECK(CSAdPurificationActiveScopes() == 0);
    CHECK(CSAdPurificationSetting(article) && CSAdPurificationSetting(finder));
    DrainMainQueue();
    CHECK(CSAdPurificationActiveScopes() == 0);
    CSAdPurificationSetSetting(CSAdPurificationEnabledKey, YES);
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == (CSAdPurificationArticles | CSAdPurificationFinder));

    Configure(defaults, all, YES);
    CHECK(CSAdPurificationActiveScopes() == all);
    CSAdPurificationSetSetting(CSAdPurificationPreferenceKey(@"recommendations"), NO);
    CHECK(CSAdPurificationActiveScopes() == (all & ~CSAdPurificationRecommendations));
    RunWorker(^{
        CSAdPurificationSetSetting(CSAdPurificationEnabledKey, NO);
    });
    CHECK(CSAdPurificationActiveScopes() == 0);
    CHECK(CSAdPurificationSetting(article));
    DrainMainQueue();
    CHECK(CSAdPurificationActiveScopes() == 0);

    for (NSString *badKey in @[@"", @"unknown", @"com.wechat.enhance.ad_purification.unknown", @"AppleLanguages"]) {
        id before = [defaults objectForKey:badKey];
        CSAdPurificationSetSetting(badKey, YES);
        CHECK(([defaults objectForKey:badKey] == before) || [[defaults objectForKey:badKey] isEqual:before]);
    }
    NSArray *invalidValues = @[@"YES", @"1", @2, @(-1), @0.5, @[], @{}];
    for (id invalid in invalidValues) {
        Configure(defaults, CSAdPurificationArticles, YES);
        [defaults setObject:invalid forKey:CSAdPurificationEnabledKey];
        CSAdPurificationRefresh();
        CHECK(!CSAdPurificationSetting(CSAdPurificationEnabledKey));
        CHECK(CSAdPurificationActiveScopes() == 0);
        Configure(defaults, CSAdPurificationArticles, YES);
        [defaults setObject:invalid forKey:article];
        CSAdPurificationRefresh();
        CHECK(!CSAdPurificationSetting(article));
        CHECK(CSAdPurificationActiveScopes() == 0);
    }
    // External preferences changes (for example restored configuration) become
    // visible after a manual refresh, including removal to defaults.
    Configure(defaults, CSAdPurificationSearch | CSAdPurificationRecommendations, YES);
    CHECK(CSAdPurificationActiveScopes() == (CSAdPurificationSearch | CSAdPurificationRecommendations));
    [defaults removeObjectForKey:CSAdPurificationPreferenceKey(@"search")];
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == CSAdPurificationRecommendations);
    NSUInteger unchanged = notifications;
    CSAdPurificationRefresh();
    CHECK(notifications == unchanged);
    [defaults removePersistentDomainForName:suite];
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == 0);
    CHECK(!CSAdPurificationSetting(CSAdPurificationEnabledKey));
    for (NSString *identifier in expected) CHECK(!CSAdPurificationSetting(CSAdPurificationPreferenceKey(identifier)));

    // Simulate a defaults read returning an old YES after a worker closes the
    // master. The stale main-thread snapshot must never republish that scope.
    Configure(defaults, CSAdPurificationArticles, YES);
    defaults.interceptedKey = CSAdPurificationEnabledKey;
    defaults.afterRead = ^{
        RunWorker(^{
            CSAdPurificationSetSetting(CSAdPurificationEnabledKey, NO);
        });
    };
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == 0);
    CHECK(!CSAdPurificationSetting(CSAdPurificationEnabledKey));
    DrainMainQueue();
    CHECK(CSAdPurificationActiveScopes() == 0);

    // A synchronous defaults observer may hand work to another thread, and that
    // worker may change this module. Do not hold the publication lock across
    // defaults writes; an in-progress write must also defer manual publication.
    Configure(defaults, CSAdPurificationArticles, YES);
    defaults.interceptedWriteKey = article;
    defaults.afterWrite = ^{
        RunWorker(^{
            CSAdPurificationSetSetting(CSAdPurificationEnabledKey, NO);
        });
        CSAdPurificationRefresh();
        CHECK(CSAdPurificationActiveScopes() == 0);
    };
    CSAdPurificationSetSetting(article, NO);
    CHECK(CSAdPurificationActiveScopes() == 0);
    CHECK(!CSAdPurificationSetting(CSAdPurificationEnabledKey));
    CHECK(!CSAdPurificationSetting(article));
    DrainMainQueue();
    CHECK(CSAdPurificationActiveScopes() == 0);
    Configure(defaults, CSAdPurificationFinder, NO);
    [defaults setBool:YES forKey:CSAdPurificationEnabledKey];
    RunWorker(^{ CSAdPurificationRefresh(); });
    CHECK(CSAdPurificationActiveScopes() == 0);
    DrainMainQueue();
    CHECK(CSAdPurificationActiveScopes() == CSAdPurificationFinder);

    CSAdPurificationSetSetting(CSAdPurificationEnabledKey, NO);
    NSString *fixture = NSStringFromClass(CSAdPreferenceHookFixture.class);
    CheckInvalidInstaller(fixture, @"probe:", NO, "@@:@"); // Disabled master.
    Configure(defaults, CSAdPurificationArticles, YES);
    CheckInvalidInstaller(@"CSMissingAdPreferenceFixture", @"probe:", NO, "@@:@");
    CheckInvalidInstaller(fixture, @"missingMethod:", NO, "@@:@");
    CheckInvalidInstaller(fixture, @"probe:", YES, "@@:@"); // Wrong method kind.
    CheckInvalidInstaller(fixture, @"probe:", NO, "d@:@"); // Unknown return ABI.
    CheckInvalidInstaller(fixture, @"probe:", NO, "@@:q"); // Wrong parameter ABI.
    CheckInvalidInstaller(fixture, @"probe:", NO, "@@:"); // Wrong arity.

    Method method = class_getInstanceMethod(CSAdPreferenceHookFixture.class, @selector(probe:));
    BaselineProbe = method_setImplementation(method, (IMP)PredecessorProbe);
    IMP wrapper = imp_implementationWithBlock(^id(id object, id value) {
        if (CSAdPurificationShouldApply(CSAdPurificationArticles)) return @"filtered";
        return ((id (*)(id, SEL, id))PreviousProbe)(object, @selector(probe:), value);
    });
    NSUInteger installed = CSAdPurificationInstalledHookCount();
    CHECK(CSAdPurificationInstallHook(fixture, @"probe:", NO, "@@:@", wrapper, &PreviousProbe));
    CHECK(PreviousProbe == (IMP)PredecessorProbe);
    CHECK(CSAdPurificationInstalledHookCount() == installed + 1);
    CHECK(HookCalls == 1);
    CSAdPreferenceHookFixture *object = [CSAdPreferenceHookFixture new];
    NSObject *argument = [NSObject new];
    CHECK([[object probe:argument] isEqual:@"filtered"]);
    CHECK(BaselineCalls == 0 && PredecessorCalls == 0);

    // Duplicate and rejected block IMPs are consumed, so they must not leak
    // retained captures or replace the existing predecessor pointer.
    __weak NSObject *duplicateCapture;
    @autoreleasepool {
        NSObject *token = [NSObject new]; duplicateCapture = token;
        IMP duplicate = imp_implementationWithBlock(^id(id receiver, id value) { (void)receiver; (void)value; return token; });
        IMP duplicateOriginal = NULL;
        CHECK(CSAdPurificationInstallHook(fixture, @"probe:", NO, "@@:@", duplicate, &duplicateOriginal));
        CHECK(duplicateOriginal == NULL);
        token = nil;
    }
    CHECK(duplicateCapture == nil);
    CHECK(HookCalls == 1 && CSAdPurificationInstalledHookCount() == installed + 1);
    CHECK(PreviousProbe == (IMP)PredecessorProbe);
    __weak NSObject *rejectedCapture;
    @autoreleasepool {
        NSObject *token = [NSObject new]; rejectedCapture = token;
        IMP rejected = imp_implementationWithBlock(^id(id receiver) { (void)receiver; return token; });
        IMP rejectedOriginal = NULL;
        CHECK(!CSAdPurificationInstallHook(fixture, @"missingMethod", NO, "@@:", rejected, &rejectedOriginal));
        token = nil;
    }
    CHECK(rejectedCapture == nil);

    CSAdPurificationSetSetting(CSAdPurificationEnabledKey, NO);
    CHECK([object probe:argument] == argument);
    CHECK(BaselineCalls == 1 && PredecessorCalls == 1);
    CSAdPurificationSetSetting(CSAdPurificationEnabledKey, YES);
    CSAdPurificationRefresh();
    CHECK([[object probe:argument] isEqual:@"filtered"]);
    CHECK(BaselineCalls == 1 && PredecessorCalls == 1);
    CHECK(HookCalls == 1);

    IMP classWrapper = imp_implementationWithBlock(^id(id receiver, id value) {
        if (CSAdPurificationShouldApply(CSAdPurificationArticles)) return @"class filtered";
        return ((id (*)(id, SEL, id))PreviousClassProbe)(receiver, @selector(classProbe:), value);
    });
    CHECK(CSAdPurificationInstallHook(fixture, @"classProbe:", YES, "@@:@", classWrapper, &PreviousClassProbe));
    CHECK([[CSAdPreferenceHookFixture classProbe:argument] isEqual:@"class filtered"]);
    CHECK(ClassBaselineCalls == 0 && HookCalls == 2);
    CSAdPurificationSetSetting(article, NO);
    CHECK([CSAdPreferenceHookFixture classProbe:argument] == argument);
    CHECK(ClassBaselineCalls == 1);
    CHECK([object probe:argument] == argument);
    CHECK(BaselineCalls == 2 && PredecessorCalls == 2);

    [NSNotificationCenter.defaultCenter removeObserver:observer];
    [defaults removePersistentDomainForName:suite];
    CSAdPurificationRefresh();
    CHECK(CSAdPurificationActiveScopes() == 0);
    atomic_store(&Completed, true);
    NSLog(@"AdPurification preferences passed %lu assertions (isolated suite, real core/signature matcher)", (unsigned long)Assertions);
} return 0; }
