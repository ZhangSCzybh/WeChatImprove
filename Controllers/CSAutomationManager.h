#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSAutomationConfigurationDidChange;
@interface CSAutomationManager : NSObject
+ (instancetype)sharedManager;
@property(nonatomic,copy,readonly) NSString *accountID;
@property(nonatomic,readonly) NSUInteger accountEpoch,configurationGeneration;
@property(nonatomic,copy,readonly) NSDictionary *configuration;
@property(nonatomic,readonly) BOOL ready;
@property(nonatomic,copy,readonly) NSString *statusText;
- (void)start;
- (void)refresh;
// Main-thread, current-service/account/configuration guard for native sync wakes.
- (void)performNativeSyncForService:(id)service epoch:(NSUInteger)epoch request:(void (^)(id receiver))request;
- (void)updateConfiguration:(NSDictionary *)changes completion:(void (^)(BOOL success,NSError *_Nullable error))completion;
- (void)receiveNativeSession:(id)session wrap:(id)wrap epoch:(NSUInteger)epoch;
- (void)receivePat:(id)pat conversation:(NSString *)conversation epoch:(NSUInteger)epoch;
// Main-thread arbitration: completion is called after durable fixed-reply admission.
- (void)receiveNativeSession:(id)session wrap:(id)wrap epoch:(NSUInteger)epoch completion:(void (^)(BOOL claimed))completion;
@end
NS_ASSUME_NONNULL_END
