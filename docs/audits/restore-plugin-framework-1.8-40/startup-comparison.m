#import <Foundation/Foundation.h>
#import "CSBackupBootstrap.h"
#import "CSBackupManager.h"
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation CSBackupManager
+ (instancetype)sharedManager {static CSBackupManager *m;if(!m)m=[self new];return m;}
- (void)resolveStartup:(CSBackupCompletion)completion {completion(nil,[NSError errorWithDomain:@"test" code:1 userInfo:nil]);}
@end
int main(void){@autoreleasepool{
 NSURL *journal=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSUUID.UUID.UUIDString stringByAppendingString:@"/transaction.plist"]]];
 __block NSUInteger features=0;
 BOOL held=CSBackupStartupNeedsResolution(journal,@"previous-version",@"new-version");
 CSBackupStartupGate *gate=[[CSBackupStartupGate alloc]initWithNeedsResolution:held resolver:^(CSBackupStartupCompletion completion){completion([NSError errorWithDomain:@"test.missing.image" code:1 userInfo:nil]);}];
 for(NSUInteger i=0;i<33;i++)[gate whenReady:^{features++;}];
 [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];
 printf("version_change_held=%d ready=%d initialized_features=%lu\n",held,gate.isReady,(unsigned long)features);
}return 0;}
