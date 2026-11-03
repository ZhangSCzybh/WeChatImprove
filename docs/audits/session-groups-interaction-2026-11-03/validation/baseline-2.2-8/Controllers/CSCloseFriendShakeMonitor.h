#import <Foundation/Foundation.h>

/// Main-thread lifecycle; motion samples are processed on a private serial queue.
@interface CSCloseFriendShakeMonitor : NSObject
- (void)startForAccountEpoch:(NSUInteger)epoch onShake:(void (^)(NSUInteger epoch))handler;
- (void)stop;
@end
