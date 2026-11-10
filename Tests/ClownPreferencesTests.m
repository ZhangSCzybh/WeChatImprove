#import <Foundation/Foundation.h>
#import "CSClownPreferences.h"
#import "CSBackupRegistry.h"

static NSUInteger checks;
#define CHECK(condition) do { checks++; if (!(condition)) { NSLog(@"FAIL line %d: %s", __LINE__, #condition); exit(1); } } while (0)

@interface CSClownCountingDefaults : NSUserDefaults
@property(nonatomic) NSUInteger reads;
@end
@implementation CSClownCountingDefaults
- (id)objectForKey:(NSString *)key {
    self.reads++;
    return [super objectForKey:key];
}
@end

static NSArray<NSString *> *Keys(void) {
    return @[CSClownEnabledKey, CSClownTextEnabledKey, CSClownTimeEnabledKey, CSClownImageEnabledKey, CSClownAmountEnabledKey];
}
static void Drain(void) {
    NSDate *deadline = [NSDate dateWithTimeIntervalSinceNow:0.03];
    while (deadline.timeIntervalSinceNow > 0) {
        [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:deadline];
    }
}
static void TestSettings(CSClownCountingDefaults *defaults, NSString *suite) {
    NSDictionary *original = [defaults persistentDomainForName:suite];
    CSClownPreferences *preferences = [[CSClownPreferences alloc] initWithDefaults:defaults];
    CSClownSettings *initial = preferences.snapshot;
    CHECK(!initial.enabled && !initial.textEnabled && !initial.timeEnabled && !initial.imageEnabled && !initial.amountEnabled);
    CHECK((original == nil && [defaults persistentDomainForName:suite] == nil) ||
        [original isEqual:[defaults persistentDomainForName:suite]]);
    for (NSUInteger mask = 0; mask < 32; mask++) {
        NSMutableDictionary *values = [NSMutableDictionary dictionary];
        [Keys() enumerateObjectsUsingBlock:^(NSString *key, NSUInteger index, __unused BOOL *stop) {
            values[key] = @((mask & (1UL << index)) != 0);
        }];
        [defaults setPersistentDomain:values forName:suite];
        [preferences requestRefresh];
        Drain();
        CSClownSettings *settings = preferences.snapshot;
        CHECK(settings.enabled == ((mask & 1) != 0));
        CHECK(settings.textEnabled == ((mask & 1) != 0 && (mask & 2) != 0));
        CHECK(settings.timeEnabled == ((mask & 1) != 0 && (mask & 4) != 0));
        CHECK(settings.imageEnabled == ((mask & 1) != 0 && (mask & 8) != 0));
        CHECK(settings.amountEnabled == ((mask & 1) != 0 && (mask & 16) != 0));
        CHECK([[defaults persistentDomainForName:suite] isEqual:values]);
    }
    CHECK(!initial.enabled && !initial.textEnabled && !initial.timeEnabled && !initial.imageEnabled && !initial.amountEnabled);
    CSClownSettings *allEnabled = preferences.snapshot;
    [defaults setBool:NO forKey:CSClownEnabledKey];
    [preferences requestRefresh];
    Drain();
    CHECK(!preferences.snapshot.enabled && !preferences.snapshot.textEnabled &&
        !preferences.snapshot.timeEnabled && !preferences.snapshot.imageEnabled && !preferences.snapshot.amountEnabled);
    CHECK([defaults boolForKey:CSClownTextEnabledKey] && [defaults boolForKey:CSClownTimeEnabledKey] &&
        [defaults boolForKey:CSClownImageEnabledKey] && [defaults boolForKey:CSClownAmountEnabledKey]);
    CHECK(allEnabled.enabled && allEnabled.textEnabled && allEnabled.timeEnabled && allEnabled.imageEnabled && allEnabled.amountEnabled);
    [defaults setBool:YES forKey:CSClownEnabledKey];
    [preferences requestRefresh];
    Drain();
    CHECK(preferences.snapshot.textEnabled && preferences.snapshot.timeEnabled && preferences.snapshot.imageEnabled && preferences.snapshot.amountEnabled);

    __block NSUInteger notifications = 0;
    __block BOOL mainDelivery = YES;
    id observer = [NSNotificationCenter.defaultCenter addObserverForName:CSClownSettingsDidChangeNotification
        object:preferences queue:nil usingBlock:^(__unused NSNotification *note) {
            notifications++;
            mainDelivery = mainDelivery && NSThread.isMainThread;
        }];
    [defaults setBool:NO forKey:CSClownTextEnabledKey];
    dispatch_semaphore_t requested = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        for (NSUInteger index = 0; index < 100; index++) [preferences requestRefresh];
        dispatch_semaphore_signal(requested);
    });
    CHECK(dispatch_semaphore_wait(requested, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC)) == 0);
    Drain();
    CHECK(!preferences.snapshot.textEnabled && preferences.snapshot.timeEnabled && preferences.snapshot.imageEnabled && preferences.snapshot.amountEnabled);
    CHECK(notifications == 1 && mainDelivery);
    CSClownSettings *unchanged = preferences.snapshot;
    [defaults setBool:YES forKey:@"unrelated.setting"];
    [preferences requestRefresh];
    Drain();
    CHECK(preferences.snapshot == unchanged && notifications == 1);
    NSUInteger reads = defaults.reads;
    for (NSUInteger index = 0; index < 1000; index++) {
        (void)preferences.snapshot.enabled;
        (void)preferences.snapshot.timeEnabled;
    }
    CHECK(defaults.reads == reads);

    [defaults setBool:NO forKey:CSClownAmountEnabledKey];
    [preferences requestRefresh];
    Drain();
    CHECK(!preferences.snapshot.amountEnabled && preferences.snapshot.imageEnabled && notifications == 2);
    [defaults setBool:NO forKey:CSClownTimeEnabledKey];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults];
    Drain();
    CHECK(!preferences.snapshot.timeEnabled && notifications == 3);
    // Backup import/reset replaces a domain; activation must pick up those changes too.
    [defaults setPersistentDomain:@{} forName:suite];
    [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil];
    Drain();
    CHECK(!preferences.snapshot.enabled && !preferences.snapshot.textEnabled &&
        !preferences.snapshot.timeEnabled && !preferences.snapshot.imageEnabled && !preferences.snapshot.amountEnabled && notifications == 4);
    [defaults setPersistentDomain:@{CSClownEnabledKey:@YES, CSClownTextEnabledKey:@{},
        CSClownTimeEnabledKey:@[], CSClownImageEnabledKey:NSData.data, CSClownAmountEnabledKey:@{}} forName:suite];
    [preferences requestRefresh];
    Drain();
    CHECK(preferences.snapshot.enabled && !preferences.snapshot.textEnabled &&
        !preferences.snapshot.timeEnabled && !preferences.snapshot.imageEnabled && !preferences.snapshot.amountEnabled);
    [defaults setPersistentDomain:@{CSClownEnabledKey:@{}} forName:suite];
    [preferences requestRefresh];
    Drain();
    CHECK(!preferences.snapshot.enabled);
    [NSNotificationCenter.defaultCenter removeObserver:observer];
}
static void TestBackupRegistration(void) {
    for (NSString *key in Keys()) {
        NSDictionary *entry = [CSBackupRegistry entryForDomain:@"standard" key:key];
        CHECK(entry != nil);
        CHECK([entry[@"module"] isEqual:@"message_actions"] && [entry[@"type"] isEqual:@"bool"] &&
            [entry[@"scope"] isEqual:@"global"] && entry[@"resource"] == nil);
        NSError *error = nil;
        CHECK([CSBackupRegistry validateValue:@YES entry:entry error:&error] && error == nil);
        CHECK([CSBackupRegistry validateValue:@NO entry:entry error:&error]);
        CHECK(![CSBackupRegistry validateValue:@"message replacement" entry:entry error:&error] && error != nil);
        CHECK(![CSBackupRegistry validateValue:@{ @"message":@"replacement" } entry:entry error:&error]);
        CHECK([CSBackupRegistry entryForDomain:@"legacy" key:key] == nil);
    }
    for (NSString *key in @[@"com.wechat.enhance.clown.text", @"com.wechat.enhance.clown.overrides",
        @"com.wechat.enhance.clown.image.path", @"com.wechat.enhance.clown.message.content", @"com.wechat.enhance.clown.amount.value"]) {
        CHECK([CSBackupRegistry entryForDomain:@"standard" key:key] == nil);
    }
}
int main(void) {
    @autoreleasepool {
        NSString *suite = [@"CSClownPreferencesTests." stringByAppendingString:NSUUID.UUID.UUIDString];
        CSClownCountingDefaults *defaults = [[CSClownCountingDefaults alloc] initWithSuiteName:suite];
        TestSettings(defaults, suite);
        TestBackupRegistration();
        [defaults removePersistentDomainForName:suite];
        NSLog(@"Clown preferences and backup passed %lu checks (isolated defaults suite)", (unsigned long)checks);
    }
    return 0;
}
