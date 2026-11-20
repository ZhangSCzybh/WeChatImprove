#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSNotificationName const CSPluginFeatureSummaryDidChangeNotification;

/// Read-only projection of ordinary settings modules. No manager is created or started.
@interface CSPluginFeatureSummary : NSObject
/// Call on main, alongside the settings page's other snapshot reads.
+ (NSUInteger)enabledModuleCount;
+ (NSArray<NSNotificationName> *)refreshNotificationNames;

/// Foundation-only seam. Domains are standard / legacy / layout. Account snapshots
/// contain ready, epoch, account and configuration, and never include private modules.
+ (NSDictionary<NSString *, NSNumber *> *)moduleStatesWithValueReader:(id _Nullable (^)(NSString *domain, NSString *key))reader
                                                   accountSnapshots:(NSDictionary<NSString *, NSDictionary *> *)snapshots
                                                              epoch:(NSUInteger)epoch
                                                       accountReady:(BOOL)accountReady;
@end

NS_ASSUME_NONNULL_END
