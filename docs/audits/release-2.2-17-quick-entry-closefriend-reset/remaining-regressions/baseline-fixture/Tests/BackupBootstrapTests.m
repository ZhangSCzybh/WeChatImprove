#import <Foundation/Foundation.h>
#import "CSBackupBootstrap.h"
#import "CSBackupManager.h"

static NSUInteger checks;
static void Check(BOOL condition, NSString *message) {
    checks++;
    if (!condition) { NSLog(@"FAIL: %@", message); exit(1); }
}
static BOOL Await(BOOL (^condition)(void)) {
    NSDate *deadline = [NSDate dateWithTimeIntervalSinceNow:2];
    while (!condition() && deadline.timeIntervalSinceNow > 0)
        [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.001]];
    return condition();
}
static NSError *Failure(void) { return [NSError errorWithDomain:@"test" code:7 userInfo:nil]; }

// The actual bootstrap implementation is linked unchanged. This inert facade replaces only
// UIKit/device I/O so native-boundary retry coverage cannot touch any real defaults or files.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation CSBackupManager
+ (instancetype)sharedManager { static CSBackupManager *value; if (!value) value = [self new]; return value; }
- (void)resolveStartup:(CSBackupCompletion)completion { completion(nil, Failure()); }
@end
#pragma clang diagnostic pop

static void TestMetadataProbe(void) {
    NSURL *root = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    Check([NSFileManager.defaultManager createDirectoryAtURL:root withIntermediateDirectories:YES attributes:nil error:NULL], @"Create isolated test root");
    NSURL *journal = [root URLByAppendingPathComponent:@"transaction.plist"];
    Check(!CSBackupStartupNeedsResolution(journal), @"Ordinary launch requires no resolution");
    __block NSUInteger initialized=0,resolutions=0;
    CSBackupStartupGate *ordinary=[[CSBackupStartupGate alloc]initWithNeedsResolution:CSBackupStartupNeedsResolution(journal) resolver:^(CSBackupStartupCompletion done){resolutions++;done(Failure());}];
    for(NSUInteger i=0;i<33;i++)[ordinary whenReady:^{initialized++;}];
    Check(ordinary.isReady&&initialized==33&&resolutions==0,@"All feature consumers initialize without invoking recovery when no journal exists");
    Check([[@"not a valid journal" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:journal atomically:YES], @"Create corrupt journal");
    Check(CSBackupStartupNeedsResolution(journal), @"Any journal is held without parsing on main");
    Check(CSBackupStartupNeedsResolution([journal URLByAppendingPathComponent:@"child"]), @"Invalid parent path fails closed");
    [NSFileManager.defaultManager removeItemAtURL:journal error:NULL];
    Check([NSFileManager.defaultManager createSymbolicLinkAtURL:journal withDestinationURL:[root URLByAppendingPathComponent:@"missing"] error:NULL], @"Create dangling journal link");
    Check(CSBackupStartupNeedsResolution(journal), @"Dangling journal link cannot bypass recovery");
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];
}

static void TestFastPath(void) {
    __block NSUInteger resolutions = 0;
    NSMutableArray *order = [NSMutableArray array];
    CSBackupStartupGate *gate = [[CSBackupStartupGate alloc] initWithNeedsResolution:NO resolver:^(__unused CSBackupStartupCompletion completion) { resolutions++; }];
    [gate whenReady:^{ [order addObject:@1]; }];
    Check([order isEqual:@[@1]], @"Fast callback runs before whenReady returns");
    [order addObject:@2];
    [gate whenReady:^{ [order addObject:@3]; }];
    Check([order isEqual:@[@1, @2, @3]] && gate.isReady && resolutions == 0, @"Fast launch preserves constructor order and performs no recovery");
    __block BOOL done = NO;
    [gate retry:^(NSError *error) { Check(error != nil && NSThread.isMainThread, @"Retry once features are active requires restart"); done = YES; }];
    Check(Await(^BOOL { return done; }) && resolutions == 0, @"Retry cannot apply a prepared plan into live hooks");
}

static void TestHeldStartup(void) {
    __block NSUInteger resolutions = 0;
    __block CSBackupStartupCompletion resolve;
    NSMutableArray *order = [NSMutableArray array];
    CSBackupStartupGate *gate = [[CSBackupStartupGate alloc] initWithNeedsResolution:YES resolver:^(CSBackupStartupCompletion completion) {
        Check(NSThread.isMainThread, @"Resolver starts on main asynchronously");
        resolutions++; resolve = [completion copy];
    }];
    [gate whenReady:^{ Check(NSThread.isMainThread && gate.isReady, @"Held callback sees committed readiness on main"); [order addObject:@1]; }];
    [gate whenReady:^{ [order addObject:@2]; }];
    Check(resolutions == 0 && order.count == 0 && !gate.isReady, @"Constructors only enqueue, without manager I/O");
    Check(Await(^BOOL { return resolutions == 1; }), @"All constructors share one startup attempt");
    __block NSUInteger failures = 0;
    [gate retry:^(NSError *error) { Check(error.code == 7, @"Failure is reported to recovery UI"); failures++; }];
    CSBackupStartupCompletion firstResolve = resolve;
    resolve(Failure());
    Check(order.count == 0 && !gate.isReady && failures == 1, @"Failed recovery holds every feature consumer");
    [gate whenReady:^{ [order addObject:@3]; }];
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    Check(resolutions == 1 && order.count == 0, @"Failure does not busy-loop or retry for a new consumer");
    __block NSUInteger successes = 0;
    [gate retry:^(NSError *error) { Check(error == nil && order.count == 3, @"Retry UI completes after feature callbacks release"); successes++; }];
    [gate retry:^(NSError *error) { Check(error == nil, @"Concurrent retries join one attempt"); successes++; }];
    Check(Await(^BOOL { return resolutions == 2; }), @"Explicit retry starts one fresh recovery");
    firstResolve(nil);
    Check(!gate.isReady && order.count == 0, @"Stale duplicate completion cannot release consumers");
    CSBackupStartupCompletion successResolve = resolve;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{ successResolve(nil); });
    Check(Await(^BOOL { return successes == 2; }), @"Off-main I/O completion releases on main");
    Check(gate.isReady && [order isEqual:@[@1, @2, @3]], @"Success releases all consumers once in registration order");
    successResolve(nil);
    Check(order.count == 3 && successes == 2, @"Duplicate success cannot install hooks twice");
    [gate whenReady:^{ [order addObject:@4]; }];
    Check(order.count == 4, @"New consumers run immediately after recovery");
}

static void TestAccountBoundary(void) {
    NSUInteger initial = CSBackupAccountEpoch();
    Check(initial > 0 && !CSBackupAccountIsSuspended(), @"Initial account epoch is valid without creating a feature singleton");
    CSBackupAccountWillChangeAtNativeBoundary();
    Check(CSBackupAccountEpoch() == initial + 1 && CSBackupAccountIsSuspended(), @"Logout suspends synchronously before native replacement");
    CSBackupAccountWillChangeAtNativeBoundary();
    Check(CSBackupAccountEpoch() == initial + 2 && CSBackupAccountIsSuspended(), @"Repeated native boundaries invalidate stale captures");
    CSBackupAccountDidChangeAtNativeBoundary();
    Check(CSBackupAccountEpoch() == initial + 3 && !CSBackupAccountIsSuspended(), @"Login advances epoch and resumes identity discovery");
    __block BOOL handedOff=NO;
    Check(!CSBackupPerformAtAccountEpoch(initial,^{handedOff=YES;})&&!handedOff,@"stale final handoff cannot activate consumers");
    Check(CSBackupPerformAtAccountEpoch(CSBackupAccountEpoch(),^{handedOff=YES;})&&handedOff,@"matching epoch activates synchronously on main");
}

int main(void) {
    @autoreleasepool {
        TestMetadataProbe(); TestFastPath(); TestHeldStartup(); TestAccountBoundary();
        printf("Backup bootstrap: %lu checks passed\n", (unsigned long)checks);
    }
    return 0;
}
