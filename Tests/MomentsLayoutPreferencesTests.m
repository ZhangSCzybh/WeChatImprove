#import <Foundation/Foundation.h>
#import "CSMomentsLayoutPreferences.h"

static NSUInteger Assertions;
#define CHECK(condition) do { Assertions++; if (!(condition)) { NSLog(@"Moments layout FAIL %d: %s", __LINE__, #condition); exit(1); } } while (0)

@interface CSMomentsTestDefaults : NSUserDefaults
@property(nonatomic, copy) void (^afterRead)(void);
@property(nonatomic, copy) void (^afterWrite)(void);
@end

@implementation CSMomentsTestDefaults
- (id)objectForKey:(NSString *)key {
    id value = [super objectForKey:key];
    if ([key isEqualToString:CSMomentsLayoutEnabledKey] && self.afterRead) {
        dispatch_block_t callback = self.afterRead;
        self.afterRead = nil;
        callback();
    }
    return value;
}
- (void)setBool:(BOOL)value forKey:(NSString *)key {
    [super setBool:value forKey:key];
    if ([key isEqualToString:CSMomentsLayoutEnabledKey] && self.afterWrite) {
        dispatch_block_t callback = self.afterWrite;
        self.afterWrite = nil;
        callback();
    }
}
@end

static void DrainMain(void) {
    for (NSUInteger pass = 0; pass < 4; pass++) {
        __block BOOL done = NO;
        dispatch_async(dispatch_get_main_queue(), ^{ done = YES; });
        NSDate *deadline = [NSDate dateWithTimeIntervalSinceNow:2];
        while (!done && deadline.timeIntervalSinceNow > 0)
            [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.002]];
        CHECK(done);
    }
}

static void Worker(dispatch_block_t work) {
    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        NSCAssert(!NSThread.isMainThread, @"Exercise a real worker");
        work();
        dispatch_semaphore_signal(done);
    });
    CHECK(dispatch_semaphore_wait(done, dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC)) == 0);
}

int main(void) { @autoreleasepool {
    NSString *suite = [@"CSMomentsLayoutTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    CSMomentsTestDefaults *defaults = [[CSMomentsTestDefaults alloc] initWithSuiteName:suite];
    CSMomentsLayoutUseTestDefaults(defaults);
    __block NSUInteger notifications = 0;
    __block BOOL allOnMain = YES;
    id observer = [NSNotificationCenter.defaultCenter addObserverForName:CSMomentsLayoutChangedNotification object:nil queue:nil
        usingBlock:^(__unused NSNotification *note) { notifications++; allOnMain &= NSThread.isMainThread; }];

    CHECK(!CSMomentsLayoutEnabled());
    CSMomentsLayoutStart();
    CHECK(!CSMomentsLayoutEnabled());
    CHECK([defaults objectForKey:CSMomentsLayoutEnabledKey] == nil);
    CHECK(notifications == 1);
    CSMomentsLayoutStart();
    DrainMain();
    CHECK(notifications == 1);

    CSMomentsLayoutSetEnabled(YES);
    CHECK([defaults boolForKey:CSMomentsLayoutEnabledKey]);
    DrainMain();
    CHECK(CSMomentsLayoutEnabled() && notifications == 2);
    CSMomentsLayoutSetEnabled(YES);
    DrainMain();
    CHECK(notifications == 2);

    CSMomentsLayoutSetEnabled(NO);
    CHECK(!CSMomentsLayoutEnabled());
    DrainMain();
    CHECK(notifications == 3);

    // Restores can update defaults outside the settings page and on a worker.
    Worker(^{
        [defaults setBool:YES forKey:CSMomentsLayoutEnabledKey];
        [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults];
        CSMomentsLayoutRefresh();
    });
    CHECK(!CSMomentsLayoutEnabled());
    DrainMain();
    CHECK(CSMomentsLayoutEnabled() && notifications == 4);
    [defaults removeObjectForKey:CSMomentsLayoutEnabledKey];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults];
    DrainMain();
    CHECK(!CSMomentsLayoutEnabled() && notifications == 5);

    for (id invalid in @[@"YES", @2, @[], @{}]) {
        [defaults setObject:invalid forKey:CSMomentsLayoutEnabledKey];
        CSMomentsLayoutRefresh();
        CHECK(!CSMomentsLayoutEnabled());
    }
    DrainMain();
    CHECK(notifications == 5);

    [defaults setBool:YES forKey:CSMomentsLayoutEnabledKey];
    CSMomentsLayoutRefresh();
    CHECK(CSMomentsLayoutEnabled());
    // The getter has returned an old YES when the settings action disables.
    defaults.afterRead = ^{ CSMomentsLayoutSetEnabled(NO); };
    CSMomentsLayoutRefresh();
    CHECK(!CSMomentsLayoutEnabled());
    DrainMain();
    CHECK(!CSMomentsLayoutEnabled());
    CHECK(![defaults boolForKey:CSMomentsLayoutEnabledKey]);

    CSMomentsLayoutSetEnabled(YES);
    DrainMain();
    CHECK(CSMomentsLayoutEnabled());
    defaults.afterWrite = ^{ CSMomentsLayoutRefresh(); };
    CSMomentsLayoutSetEnabled(NO);
    CHECK(!CSMomentsLayoutEnabled());
    DrainMain();
    CHECK(!CSMomentsLayoutEnabled());

    NSUInteger before = notifications;
    Worker(^{
        [defaults setBool:YES forKey:CSMomentsLayoutEnabledKey];
        for (NSUInteger index = 0; index < 50; index++)
            [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults];
    });
    DrainMain();
    CHECK(CSMomentsLayoutEnabled() && notifications == before + 1);
    CHECK(allOnMain);

    [NSNotificationCenter.defaultCenter removeObserver:observer];
    [defaults removePersistentDomainForName:suite];
    NSLog(@"Moments layout preferences: %lu assertions passed", (unsigned long)Assertions);
} return 0; }
