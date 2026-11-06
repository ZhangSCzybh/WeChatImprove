#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

typedef NSUInteger UIBackgroundTaskIdentifier;
static const UIBackgroundTaskIdentifier UIBackgroundTaskInvalid=NSUIntegerMax;

@interface UIApplication : NSObject
+ (instancetype)sharedApplication;
@property(nonatomic) NSTimeInterval backgroundTimeRemaining;
@property(nonatomic) BOOL failNextTask, expireSynchronously, expireDuringEnd;
@property(nonatomic) UIBackgroundTaskIdentifier nextIdentifier;
@property(nonatomic, strong) NSMutableArray<NSNumber *> *begunIdentifiers, *endedIdentifiers;
@property(nonatomic, strong) NSMutableDictionary<NSNumber *, dispatch_block_t> *expirationHandlers;
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)name expirationHandler:(dispatch_block_t)handler;
- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier;
- (void)reset;
@end
