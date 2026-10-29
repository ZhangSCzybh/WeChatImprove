#import "CSScheduledTaskStore.h"
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSScheduledTasksDidChange;
@interface CSScheduledTaskManager : NSObject
+ (instancetype)sharedManager;
- (void)start;
- (void)refresh;
@property(nonatomic, readonly, nullable) CSScheduledTaskStore *store;
@property(nonatomic, readonly) NSString *statusText;
@property(nonatomic, readonly) BOOL savingConfiguration;
- (void)setEnabled:(BOOL)enabled account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion;
- (void)saveTask:(NSDictionary *)task account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion;
- (void)removeTask:(NSString *)identifier account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion;
- (NSString *)displayNameForTarget:(NSString *)target;
@end
NS_ASSUME_NONNULL_END
