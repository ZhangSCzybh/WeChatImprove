#import <Foundation/Foundation.h>

// Host-only CoreMotion surface; production is built against the real iOS SDK.
typedef struct { double x,y,z; } CMAcceleration;
@interface CMDeviceMotion : NSObject
@property(nonatomic) CMAcceleration userAcceleration;
@property(nonatomic) NSTimeInterval timestamp;
@end
@interface CMMotionManager : NSObject
@property(nonatomic,readonly,getter=isDeviceMotionAvailable) BOOL deviceMotionAvailable;
@property(nonatomic) NSTimeInterval deviceMotionUpdateInterval;
- (void)startDeviceMotionUpdatesToQueue:(NSOperationQueue *)queue withHandler:(void (^)(CMDeviceMotion *,NSError *))handler;
- (void)stopDeviceMotionUpdates;
@end
