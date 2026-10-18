#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <stdatomic.h>

// Host-only diagnostic: unique notification names, no WeChat/defaults/database access.
// Both experiments are bounded; these are Foundation semantics, not iPhone timings.
static unsigned darwinCount, darwinDepth, darwinMaxDepth;
static void DarwinEcho(CFNotificationCenterRef center, void *observer,
                       CFStringRef name, const void *object, CFDictionaryRef info) {
    darwinDepth++;
    darwinMaxDepth=MAX(darwinMaxDepth,darwinDepth);
    darwinCount++;
    if (darwinCount<100) CFNotificationCenterPostNotification(center,name,NULL,NULL,true);
    else CFNotificationCenterRemoveObserver(center,observer,name,NULL);
    darwinDepth--;
}

int main(void) {
    @autoreleasepool {
        NSString *name=[@"wechat.audit.mainqueue." stringByAppendingString:NSUUID.UUID.UUIDString];
        dispatch_semaphore_t started=dispatch_semaphore_create(0);
        dispatch_semaphore_t finished=dispatch_semaphore_create(0);
        __block BOOL delivered=NO;
        id token=[NSNotificationCenter.defaultCenter addObserverForName:name object:nil
            queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) { delivered=YES; }];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
            dispatch_semaphore_signal(started);
            [NSNotificationCenter.defaultCenter postNotificationName:name object:nil];
            dispatch_semaphore_signal(finished);
        });
        long startResult=dispatch_semaphore_wait(started,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC));
        long blocked=dispatch_semaphore_wait(finished,dispatch_time(DISPATCH_TIME_NOW,200*NSEC_PER_MSEC));
        BOOL deliveredBeforeRunloop=delivered;
        NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:1];
        while (!delivered && deadline.timeIntervalSinceNow>0)
            [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
        long completion=dispatch_semaphore_wait(finished,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC));
        [NSNotificationCenter.defaultCenter removeObserver:token];
        printf("mainQueue: producer_started=%d producer_blocked_during_200ms_main_wait=%d observer_before_main_runloop=%d observer_after_runloop=%d producer_finished_after_runloop=%d\n",
            startResult==0,blocked!=0,deliveredBeforeRunloop,delivered,completion==0);

        NSString *darwin=[@"wechat.audit.darwin." stringByAppendingString:NSUUID.UUID.UUIDString];
        CFNotificationCenterRef center=CFNotificationCenterGetDarwinNotifyCenter();
        CFNotificationCenterAddObserver(center,&darwinCount,DarwinEcho,(__bridge CFStringRef)darwin,NULL,
                                        CFNotificationSuspensionBehaviorDeliverImmediately);
        CFAbsoluteTime start=CFAbsoluteTimeGetCurrent();
        CFNotificationCenterPostNotification(center,(__bridge CFStringRef)darwin,NULL,NULL,true);
        while (darwinCount<100 && CFAbsoluteTimeGetCurrent()-start<1)
            CFRunLoopRunInMode(kCFRunLoopDefaultMode,0.01,true);
        CFNotificationCenterRemoveObserver(center,&darwinCount,(__bridge CFStringRef)darwin,NULL);
        printf("darwinEcho: callbacks=%u hard_limit=100 max_stack_depth=%u elapsed_ms=%.3f\n",
            darwinCount,darwinMaxDepth,(CFAbsoluteTimeGetCurrent()-start)*1000);
        return (startResult==0 && blocked!=0 && delivered && completion==0 && darwinCount==100) ? 0 : 1;
    }
}
