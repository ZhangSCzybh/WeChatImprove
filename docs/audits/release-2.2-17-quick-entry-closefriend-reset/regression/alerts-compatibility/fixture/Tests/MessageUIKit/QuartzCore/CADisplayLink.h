#import <Foundation/Foundation.h>
// Avoid colliding with the macOS QuartzCore class loaded indirectly by CoreGraphics.
#define CADisplayLink CSMessageTestDisplayLink
// Deterministic display boundaries for the real navigation state machine.
@interface CADisplayLink : NSObject
+ (instancetype)displayLinkWithTarget:(id)target selector:(SEL)selector;
- (void)addToRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode;
- (void)invalidate;
+ (void)testAdvanceFrame;
+ (NSUInteger)testPendingCount;
@end
