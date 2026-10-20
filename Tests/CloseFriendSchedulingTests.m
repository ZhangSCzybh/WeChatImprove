#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "CSCloseFriendRuntime.h"
static NSUInteger checks;
static void Check(BOOL ok,const char *message) { checks++; if(!ok) { fprintf(stderr,"FAIL: %s\n",message);exit(1); } }
static CSCloseFriendRuntime *runtimeUnderTest;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return [runtimeUnderTest snapshotForEpoch:1 suspended:NO]; }
@interface CSExpirySchedulerFixture:NSObject
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic) BOOL lastRevealed;
@property(nonatomic) NSUInteger safePageTransitions;
- (void)startExpiryTimer;
- (void)lockAndReturnToSafePage;
@end
@implementation CSExpirySchedulerFixture
- (void)lockAndReturnToSafePage { self.safePageTransitions++; [runtimeUnderTest lock]; self.lastRevealed=NO; }
// The production manager method is extracted verbatim, so this exercises its real timer
// registration and fresh-snapshot decision. Only UIKit navigation is replaced with a counter.
#import "ManagerExpiryUnderTest.h"
@end
int main(void) { @autoreleasepool {
    __block NSTimeInterval elapsed=1000;
    __block NSDictionary *credential=nil;
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(__unused NSString *account,__unused NSError **error){ return [NSMutableData dataWithLength:64]; }];
    runtimeUnderTest=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{return 10000;} elapsedClock:^NSTimeInterval{return elapsed;} credentialReader:^NSDictionary *(__unused NSString *account,__unused NSError **error){return credential;} credentialWriter:^BOOL(__unused NSString *account,NSDictionary *value,__unused NSError **error){credential=value;return YES;}];
    [runtimeUnderTest synchronizeAccount:@"scheduling-fixture" epoch:1 suspended:NO];
    Check([runtimeUnderTest setPassword:@"123456" token:runtimeUnderTest.authenticationToken error:NULL],"fixture establishes real runtime authorization");
    CSExpirySchedulerFixture *scheduler=[CSExpirySchedulerFixture new]; scheduler.lastRevealed=YES; [scheduler startExpiryTimer];
    __block BOOL defaultTimerFired=NO;
    NSTimer *defaultTimer=[NSTimer scheduledTimerWithTimeInterval:0.01 repeats:NO block:^(__unused NSTimer *timer){defaultTimerFired=YES;}];
    NSString *trackingMode=@"CSCloseFriendTestTrackingRunLoopMode";
    CFRunLoopAddCommonMode(CFRunLoopGetMain(),(__bridge CFStringRef)trackingMode);
    elapsed+=301;
    NSDate *limit=[NSDate dateWithTimeIntervalSinceNow:3];
    while(!scheduler.safePageTransitions && limit.timeIntervalSinceNow>0) {
        [NSRunLoop.mainRunLoop runMode:trackingMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];
    }
    Check(!defaultTimerFired,"test stayed in a nondefault tracking mode; default timers cannot fire");
    Check(scheduler.safePageTransitions==1,"production expiry scheduler requests safe-page transition while tracking");
    Check(!runtimeUnderTest.isAuthorized && !CSCloseFriendCurrentSnapshot().revealed,"tracking callback locks expired authorization using fresh policy");
    Check(scheduler.timer.valid,"expiry scheduler remains installed for subsequent reveals");
    [scheduler.timer invalidate]; [defaultTimer invalidate];
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    printf("CloseFriendSchedulingTests: %lu checks passed\n",(unsigned long)checks);
}return 0; }
