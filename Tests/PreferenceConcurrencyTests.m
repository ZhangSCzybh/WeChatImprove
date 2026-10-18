#import "CSAvatarURLCache.h"
#import "CSPreferenceRefresh.h"
#import "CSMessageActionPreferences.h"
static NSUInteger checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#x); return 1; } } while (0)
@interface CountingDefaults : NSUserDefaults
@property(nonatomic) NSUInteger writes;
@property(nonatomic,copy) void (^readProbe)(void);
@end
@implementation CountingDefaults
- (id)objectForKey:(NSString *)key { if (self.readProbe) self.readProbe(); return [super objectForKey:key]; }
- (void)setObject:(id)value forKey:(NSString *)key { self.writes++; [super setObject:value forKey:key]; }
@end
static void pump(void) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:0.05]; while ([end timeIntervalSinceNow]>0) [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:end]; }
int main(void) { @autoreleasepool {
    NSString *suite=[@"test.avatar." stringByAppendingString:NSUUID.UUID.UUIDString];
    CountingDefaults *defaults=[[CountingDefaults alloc] initWithSuiteName:suite];
    CSAvatarURLCache *cache=[[CSAvatarURLCache alloc] initWithDefaults:defaults key:@"avatar"];
    // Main is blocked waiting for a native worker. Capturing while that worker
    // owns a host lock must never synchronously write Defaults or wait for main.
    dispatch_semaphore_t completed=dispatch_semaphore_create(0);
    NSRecursiveLock *hostLock=[NSRecursiveLock new];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0), ^{
        [hostLock lock];
        for (NSUInteger i=0;i<1000;i++) [cache captureURL:@"a.png" account:@"alice" generation:cache.generation];
        [hostLock unlock]; dispatch_semaphore_signal(completed);
    });
    CHECK(dispatch_semaphore_wait(completed,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    CHECK(defaults.writes==0); pump(); CHECK([[defaults stringForKey:@"avatar"] isEqual:@"a.png"]);
    CHECK(defaults.writes==2);
    for (NSUInteger i=0;i<100;i++) [cache captureURL:@"a.png" account:@"alice" generation:cache.generation];
    pump(); CHECK(defaults.writes==2);
    NSUInteger old=cache.generation;
    [cache captureURL:@"old.png" account:@"alice" generation:old];
    [cache accountBoundaryAcceptingContacts:NO];
    [cache captureURL:@"late.png" account:@"alice" generation:old];
    pump(); CHECK([defaults objectForKey:@"avatar"]==nil);
    [cache accountBoundaryAcceptingContacts:YES];
    [cache captureURL:@"b.png" account:@"bob" generation:cache.generation];
    [cache captureURL:@"late.png" account:@"alice" generation:old];
    pump(); CHECK([[defaults stringForKey:@"avatar"] isEqual:@"b.png"]);
    CHECK([[defaults stringForKey:@"avatar.account"] isEqual:@"bob"]);
    static atomic_bool pending;
    static atomic_uint inputValue;
    __block NSUInteger refreshes=0, latest=0;
    id token=[NSNotificationCenter.defaultCenter addObserverForName:@"test.refresh" object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
        CSRequestMainRefresh(&pending, ^{ refreshes++; latest=atomic_load(&inputValue); });
    }];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0), ^{
        for (NSUInteger i=0;i<1000;i++) { atomic_store(&inputValue,(unsigned)i+1); [NSNotificationCenter.defaultCenter postNotificationName:@"test.refresh" object:nil]; }
        dispatch_semaphore_signal(completed);
    });
    CHECK(dispatch_semaphore_wait(completed,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    CHECK(refreshes==0); pump(); CHECK(refreshes==1 && latest==1000);
    [NSNotificationCenter.defaultCenter removeObserver:token];
    CSMessageActionPreferences *preferences=[[CSMessageActionPreferences alloc] initWithDefaults:defaults];
    __block BOOL notificationReturned=NO;
    __weak CountingDefaults *weakDefaults=defaults;
    defaults.readProbe=^{
        weakDefaults.readProbe=nil;
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0), ^{
            [preferences requestRefresh]; dispatch_semaphore_signal(completed);
        });
        notificationReturned=dispatch_semaphore_wait(completed,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0;
    };
    [preferences requestRefresh]; pump(); CHECK(notificationReturned);
    [defaults removePersistentDomainForName:suite];
    printf("Preference concurrency: %lu checks passed\n",(unsigned long)checks);
} return 0; }
