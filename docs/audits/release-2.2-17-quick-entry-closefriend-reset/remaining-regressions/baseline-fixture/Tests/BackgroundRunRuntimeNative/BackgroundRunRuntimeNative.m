// Independent UIKit double: these tests do not allocate iOS execution time.
#import <UIKit/UIKit.h>

@implementation UIApplication
+ (instancetype)sharedApplication {
    static UIApplication *application;
    static dispatch_once_t once;
    dispatch_once(&once,^{ application=[self new]; [application reset]; });
    return application;
}
- (void)reset {
    self.backgroundTimeRemaining=120;
    self.failNextTask=NO; self.expireSynchronously=NO; self.expireDuringEnd=NO;
    self.nextIdentifier=1;
    self.begunIdentifiers=[NSMutableArray array];
    self.endedIdentifiers=[NSMutableArray array];
    self.expirationHandlers=[NSMutableDictionary dictionary];
}
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)name expirationHandler:(dispatch_block_t)handler {
    NSAssert(NSThread.isMainThread,@"UIKit task creation requires the main thread");
    NSAssert([name isEqual:@"WeChatImprove.BackgroundRun"],@"Unexpected native task name");
    if (self.failNextTask) { self.failNextTask=NO; return UIBackgroundTaskInvalid; }
    UIBackgroundTaskIdentifier identifier=self.nextIdentifier++;
    [self.begunIdentifiers addObject:@(identifier)];
    self.expirationHandlers[@(identifier)]=[handler copy];
    if (self.expireSynchronously) handler();
    return identifier;
}
- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier {
    NSAssert(NSThread.isMainThread,@"UIKit task release requires the main thread");
    NSAssert(identifier!=UIBackgroundTaskInvalid,@"Invalid task must not be ended");
    [self.endedIdentifiers addObject:@(identifier)];
    if (self.expireDuringEnd) { dispatch_block_t handler=self.expirationHandlers[@(identifier)]; if (handler) handler(); }
    [self.expirationHandlers removeObjectForKey:@(identifier)];
}
@end
