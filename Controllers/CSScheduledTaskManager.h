#import "CSScheduledTaskStore.h"
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSScheduledTasksDidChange;
@interface CSScheduledTaskManager : NSObject
+ (instancetype)sharedManager;
- (void)start;
- (void)refresh;
@property(nonatomic, readonly, nullable) CSScheduledTaskStore *store;
@property(nonatomic, readonly) NSString *statusText;
- (BOOL)setEnabled:(BOOL)enabled account:(NSString *)account error:(NSError **)error;
- (BOOL)saveTask:(NSDictionary *)task account:(NSString *)account error:(NSError **)error;
- (BOOL)removeTask:(NSString *)identifier account:(NSString *)account error:(NSError **)error;
- (NSString *)displayNameForTarget:(NSString *)target;
@end
NS_ASSUME_NONNULL_END
