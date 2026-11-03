#import "CSCloseFriendShakeMonitor.h"
#import <CoreMotion/CoreMotion.h>
#import <math.h>

// userAcceleration excludes gravity: rotating the phone alone is not a shake.
// Two opposite impulses recognize a short, lighter shake while rejecting a
// single bump. UIKit's motion event remains an independent fallback.
@interface CSCFShakeDetector : NSObject
@property(nonatomic) BOOL hasPeak;
@property(nonatomic) double x,y,z,peakTime,lastTime;
- (BOOL)consume:(CMAcceleration)acceleration timestamp:(NSTimeInterval)timestamp;
@end
@implementation CSCFShakeDetector
- (BOOL)consume:(CMAcceleration)a timestamp:(NSTimeInterval)timestamp {
    if(!isfinite(timestamp) || !isfinite(a.x) || !isfinite(a.y) || !isfinite(a.z) || timestamp<=self.lastTime) {
        self.hasPeak=NO; return NO;
    }
    self.lastTime=timestamp;
    double magnitude=sqrt(a.x*a.x+a.y*a.y+a.z*a.z);
    if(!isfinite(magnitude) || magnitude<0.65) return NO;
    double x=a.x/magnitude,y=a.y/magnitude,z=a.z/magnitude;
    NSTimeInterval elapsed=timestamp-self.peakTime;
    if(!self.hasPeak || elapsed>0.45) {
        self.hasPeak=YES; self.peakTime=timestamp; self.x=x; self.y=y; self.z=z; return NO;
    }
    if(elapsed>=0.06 && x*self.x+y*self.y+z*self.z<=-0.35) {
        self.hasPeak=NO; return YES;
    }
    return NO;
}
@end

@interface CSCloseFriendShakeMonitor ()
@property(nonatomic,strong) CMMotionManager *motion;
@property(nonatomic,strong) NSOperationQueue *queue;
@property(nonatomic) NSUInteger generation,epoch;
@property(nonatomic) BOOL running;
@end
@implementation CSCloseFriendShakeMonitor
- (void)startForAccountEpoch:(NSUInteger)epoch onShake:(void (^)(NSUInteger))handler {
    NSAssert(NSThread.isMainThread,@"Shake lifecycle on main");
    if(self.running && self.epoch==epoch) return;
    [self stop];
    if(!handler) return;
    if(!self.motion) self.motion=[CMMotionManager new];
    if(!self.motion.isDeviceMotionAvailable) return;
    if(!self.queue) {
        self.queue=[NSOperationQueue new]; self.queue.name=@"com.wechatimprove.closefriends.shake";
        self.queue.maxConcurrentOperationCount=1; self.queue.qualityOfService=NSQualityOfServiceUtility;
    }
    self.running=YES; self.epoch=epoch;
    NSUInteger generation=self.generation;
    self.motion.deviceMotionUpdateInterval=1.0/40.0;
    CSCFShakeDetector *detector=[CSCFShakeDetector new];
    __weak typeof(self) weakSelf=self;
    __block BOOL finished=NO; // accessed only by this run's serial motion callback
    [self.motion startDeviceMotionUpdatesToQueue:self.queue withHandler:^(CMDeviceMotion *sample,NSError *error){
        if(finished) return;
        BOOL failed=error!=nil || sample==nil;
        if(!failed && ![detector consume:sample.userAcceleration timestamp:sample.timestamp]) return;
        finished=YES;
        dispatch_async(dispatch_get_main_queue(),^{
            typeof(self) self=weakSelf;
            if(!self || !self.running || self.generation!=generation || self.epoch!=epoch) return;
            [self stop];
            if(!failed) handler(epoch);
        });
    }];
}
- (void)stop {
    NSAssert(NSThread.isMainThread,@"Shake lifecycle on main");
    self.running=NO; self.generation++;
    [self.motion stopDeviceMotionUpdates]; [self.queue cancelAllOperations];
}
- (void)dealloc { [_motion stopDeviceMotionUpdates]; [_queue cancelAllOperations]; }
@end
