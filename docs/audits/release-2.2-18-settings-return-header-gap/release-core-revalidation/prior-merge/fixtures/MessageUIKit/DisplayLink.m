#import <QuartzCore/CADisplayLink.h>
#import <objc/message.h>
static NSMutableArray *links;
@interface CADisplayLink ()
@property(nonatomic,strong) id target;
@property(nonatomic) SEL selector;
@end
@implementation CADisplayLink
+ (instancetype)displayLinkWithTarget:(id)target selector:(SEL)selector {
    CADisplayLink *link=[self new];link.target=target;link.selector=selector;return link;
}
- (void)addToRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode {
    if (!links) links=[NSMutableArray array];[links addObject:self];
}
- (void)invalidate { [links removeObject:self];self.target=nil; }
+ (void)testAdvanceFrame {
    for (CADisplayLink *link in links.copy) if (link.target)
        ((void (*)(id,SEL,id))objc_msgSend)(link.target,link.selector,link);
}
+ (NSUInteger)testPendingCount { return links.count; }
@end
