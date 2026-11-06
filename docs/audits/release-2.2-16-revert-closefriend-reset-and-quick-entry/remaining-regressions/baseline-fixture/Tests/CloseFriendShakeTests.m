#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <math.h>
#import "CSCloseFriendShakeMonitor.h"
#import "CSCloseFriendPolicy.h"

static NSUInteger checks;
static void Check(BOOL ok,const char *message) {
    checks++; if(!ok) { fprintf(stderr,"FAIL: %s\n",message); exit(1); }
}
static BOOL hardwareAvailable=YES;
static __weak CMMotionManager *lastMotion;
@interface CMMotionManager ()
@property(nonatomic,strong) NSOperationQueue *sampleQueue;
@property(nonatomic,copy) void (^sampleHandler)(CMDeviceMotion *,NSError *);
@end
@implementation CMDeviceMotion
@end
@implementation CMMotionManager
- (instancetype)init { if((self=[super init]))lastMotion=self; return self; }
- (BOOL)isDeviceMotionAvailable { return hardwareAvailable; }
- (void)startDeviceMotionUpdatesToQueue:(NSOperationQueue *)queue withHandler:(void (^)(CMDeviceMotion *,NSError *))handler {
    self.sampleQueue=queue; self.sampleHandler=handler;
}
- (void)stopDeviceMotionUpdates { self.sampleHandler=nil; }
@end
static void Sample(double x,double y,double z,double timestamp) {
    CMDeviceMotion *sample=[CMDeviceMotion new]; sample.userAcceleration=(CMAcceleration){x,y,z}; sample.timestamp=timestamp;
    void (^handler)(CMDeviceMotion *,NSError *)=lastMotion.sampleHandler;
    NSCAssert(handler,@"Fixture must have an active motion subscription");
    [lastMotion.sampleQueue addOperationWithBlock:^{ handler(sample,nil); }];
}
static void Shake(void) { Sample(0.75,0,0,1); Sample(-0.8,0,0,1.12); }
static void Drain(void) {
    // Main never waits for a sensor callback in production. This host-only barrier
    // makes pending sensor -> main continuations deterministic for cancellation tests.
    [lastMotion.sampleQueue waitUntilAllOperationsAreFinished];
    __block BOOL drained=NO;
    dispatch_async(dispatch_get_main_queue(),^{drained=YES;});
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:1];
    while(!drained && deadline.timeIntervalSinceNow>0)
        [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:deadline];
    NSCAssert(drained,@"Main dispatch queue stalled");
}

// Only UIKit state/navigation is substituted; manager gates and native event
// wrappers below are extracted verbatim from the production sources.
typedef NS_ENUM(NSInteger,UIApplicationState) { UIApplicationStateActive,UIApplicationStateInactive,UIApplicationStateBackground };
@interface UIApplication : NSObject
@property(nonatomic) UIApplicationState applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; if(!app)app=[self new]; return app; }
@end
static CSCloseFriendSnapshot *snapshot;
static NSUInteger accountEpoch=1;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return snapshot; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return accountEpoch; }
static CSCloseFriendSnapshot *Snapshot(BOOL enabled,BOOL revealed,BOOL blocked,BOOL shake) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"shake-fixture" profile:@{@"enabled":@(enabled),@"friends":@[@"friend"],@"groups":@[],@"options":@{@"shakeToLock":@(shake)}} revealed:revealed revision:1 blocked:blocked];
}
@interface CSCloseFriendManager : NSObject
@property(nonatomic) BOOL started,backgroundCoverRequired;
@property(nonatomic,strong) CSCloseFriendShakeMonitor *shakeMonitor;
@property(nonatomic) NSUInteger lockCount;
+ (instancetype)sharedManager;
- (void)lockAndReturnToSafePage;
- (BOOL)canLockForShake;
- (void)refreshShakeMonitoring;
- (void)handleShake;
@end
static CSCloseFriendManager *manager;
@implementation CSCloseFriendManager
+ (instancetype)sharedManager { return manager; }
- (void)lockAndReturnToSafePage { [self.shakeMonitor stop]; self.lockCount++; snapshot=Snapshot(YES,NO,NO,YES); }
#import "ManagerShakeUnderTest.h"
@end
typedef NS_ENUM(NSInteger,UIEventSubtype) { UIEventSubtypeNone,UIEventSubtypeMotionShake };
@interface UIEvent : NSObject @end
@implementation UIEvent @end
#import "ShakeHooksUnderTest.h"
static NSUInteger nativeCalls;
static void NativeMotion(__unused id object,__unused SEL command,__unused UIEventSubtype motion,__unused UIEvent *event) { nativeCalls++; }

int main(void) { @autoreleasepool {
    CSCloseFriendShakeMonitor *monitor=[CSCloseFriendShakeMonitor new];
    __block NSUInteger triggered=0,lastEpoch=0;
    __block BOOL onMain=NO;
    void (^handler)(NSUInteger)=^(NSUInteger epoch){ triggered++; lastEpoch=epoch; onMain=NSThread.isMainThread; };
    [monitor startForAccountEpoch:1 onShake:handler];
    Shake(); Sample(0.9,0,0,1.24); Sample(-0.9,0,0,1.36); Drain();
    Check(triggered==1 && lastEpoch==1 && onMain && !lastMotion.sampleHandler,"light shake triggers once on main and stops sampling");

    NSArray<NSArray<NSArray<NSNumber *> *> *> *rejected=@[
        @[@[@0.15,@0.2,@0.1,@1],@[@(-0.3),@0,@0,@1.15]], // jitter
        @[@[@1.4,@0,@0,@1],@[@0,@0,@0,@1.12]], // single bump
        @[@[@0.8,@0,@0,@1],@[@0.9,@0,@0,@1.12]], // same direction
        @[@[@0.8,@0,@0,@1],@[@(-0.8),@0,@0,@1.6]], // unrelated later bump
        @[@[@0.8,@0,@0,@1],@[@(-0.8),@0,@0,@1.01]], // too brief
        @[@[@0,@0,@0,@1],@[@0,@0,@0,@1.2]], // gravity/rotation excluded
        @[@[@0.8,@0,@0,@1],@[@(NAN),@0,@0,@1.1],@[@(-0.8),@0,@0,@1.2]],
        @[@[@0.8,@0,@0,@1],@[@(-0.8),@0,@0,@0.9],@[@(-0.8),@0,@0,@1.2]]
    ];
    for(NSArray *samples in rejected) {
        [monitor stop]; [monitor startForAccountEpoch:1 onShake:handler];
        for(NSArray<NSNumber *> *s in samples)Sample(s[0].doubleValue,s[1].doubleValue,s[2].doubleValue,s[3].doubleValue);
        Drain();
    }
    Check(triggered==1,"jitter, bump, same direction, delayed/brief reversal and invalid samples do not lock");
    [monitor stop]; [monitor startForAccountEpoch:1 onShake:handler];
    Sample(0,0.55,0.55,1); Sample(0,-0.55,-0.55,1.12); Drain();
    Check(triggered==2,"light shake works across axes");

    [monitor startForAccountEpoch:1 onShake:handler]; Sample(0.75,0,0,1);
    [lastMotion.sampleQueue waitUntilAllOperationsAreFinished];
    [monitor startForAccountEpoch:1 onShake:handler]; Sample(-0.8,0,0,1.12); Drain();
    Check(triggered==3,"refreshing same account does not reset an in-progress shake");
    [monitor startForAccountEpoch:1 onShake:handler]; Shake();
    [lastMotion.sampleQueue waitUntilAllOperationsAreFinished];
    [monitor stop]; [monitor startForAccountEpoch:1 onShake:handler]; Drain();
    Check(triggered==3,"relocking and re-unlocking invalidate queued old callbacks");
    Shake(); Drain(); Check(triggered==4,"new unlock can detect a fresh shake");
    [monitor startForAccountEpoch:1 onShake:handler]; Shake();
    [lastMotion.sampleQueue waitUntilAllOperationsAreFinished];
    [monitor startForAccountEpoch:2 onShake:handler]; Drain();
    Check(triggered==4,"account switch invalidates queued old callbacks");
    Shake(); Drain(); Check(triggered==5 && lastEpoch==2,"fresh account receives its own callback");

    hardwareAvailable=NO; [monitor startForAccountEpoch:3 onShake:handler];
    Check(!lastMotion.sampleHandler && triggered==5,"unavailable hardware leaves native fallback available");
    hardwareAvailable=YES; [monitor startForAccountEpoch:3 onShake:handler];
    void (^errorHandler)(CMDeviceMotion *,NSError *)=lastMotion.sampleHandler;
    [lastMotion.sampleQueue addOperationWithBlock:^{errorHandler(nil,[NSError errorWithDomain:@"fixture" code:1 userInfo:nil]);}]; Drain();
    Check(!lastMotion.sampleHandler && triggered==5,"sensor failure stops sampling without locking");
    [monitor startForAccountEpoch:3 onShake:handler]; Shake(); Drain();
    Check(triggered==6,"subsequent start recovers after sensor failure");

    // started, covered, foreground, enabled, revealed, blocked, shake option
    NSArray<NSArray<NSNumber *> *> *gates=@[
        @[@NO,@NO,@YES,@YES,@YES,@NO,@YES],@[@YES,@YES,@YES,@YES,@YES,@NO,@YES],
        @[@YES,@NO,@NO,@YES,@YES,@NO,@YES],@[@YES,@NO,@YES,@NO,@YES,@NO,@YES],
        @[@YES,@NO,@YES,@YES,@NO,@NO,@YES],@[@YES,@NO,@YES,@YES,@YES,@YES,@YES],
        @[@YES,@NO,@YES,@YES,@YES,@NO,@NO]
    ];
    BOOL allGates=YES;
    for(NSArray<NSNumber *> *g in gates) {
        manager=[CSCloseFriendManager new]; manager.started=g[0].boolValue; manager.backgroundCoverRequired=g[1].boolValue;
        UIApplication.sharedApplication.applicationState=g[2].boolValue?UIApplicationStateActive:UIApplicationStateBackground;
        snapshot=Snapshot(g[3].boolValue,g[4].boolValue,g[5].boolValue,g[6].boolValue);
        [manager refreshShakeMonitoring]; [manager handleShake];
        allGates=allGates && manager.lockCount==0 && manager.shakeMonitor==nil;
    }
    Check(allGates,"disabled, locked, invalid and background states neither sample nor navigate");
    manager=[CSCloseFriendManager new]; manager.started=YES;
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    snapshot=Snapshot(YES,YES,NO,YES); [manager refreshShakeMonitoring];
    Shake(); Drain(); Check(manager.lockCount==1,"production manager routes light shake to safe-page lock");
    snapshot=Snapshot(YES,YES,NO,YES); [manager refreshShakeMonitoring];
    snapshot=Snapshot(YES,YES,NO,NO); [manager refreshShakeMonitoring];
    Check(!lastMotion.sampleHandler,"turning option off stops active sampling");
    snapshot=Snapshot(YES,YES,NO,YES); [manager refreshShakeMonitoring]; Shake();
    [lastMotion.sampleQueue waitUntilAllOperationsAreFinished]; accountEpoch++; Drain();
    Check(manager.lockCount==1,"manager rejects callback from a stale account epoch");

    snapshot=Snapshot(YES,YES,NO,YES); [manager refreshShakeMonitoring]; Shake();
    [lastMotion.sampleQueue waitUntilAllOperationsAreFinished];
    CSMotionBeganOriginal=NativeMotion; CSMotionEndedOriginal=NativeMotion;
    CSMotionBegan(nil,NULL,UIEventSubtypeMotionShake,nil);
    CSMotionEnded(nil,NULL,UIEventSubtypeMotionShake,nil); Drain();
    Check(manager.lockCount==2 && nativeCalls==2,"native begin locks immediately; end and pending sensor callback cannot duplicate lock");
    snapshot=Snapshot(YES,YES,NO,YES);
    CSMotionBegan(nil,NULL,UIEventSubtypeNone,nil);
    CSMotionEnded(nil,NULL,UIEventSubtypeNone,nil);
    Check(manager.lockCount==2 && nativeCalls==4,"non-shake native motion passes through unchanged");
    CSMotionEnded(nil,NULL,UIEventSubtypeMotionShake,nil);
    Check(manager.lockCount==3 && nativeCalls==5,"native ended event still serves as independent fallback");
    printf("CloseFriendShakeTests: %lu checks passed (recognition, lifecycle, stale callbacks, native fallback)\n",(unsigned long)checks);
}return 0; }
