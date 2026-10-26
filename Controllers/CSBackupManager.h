#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^CSBackupCompletion)(id _Nullable result,NSError * _Nullable error);
/// UIKit-facing asynchronous facade. Completions always run on the main thread.
@interface CSBackupManager : NSObject
+ (instancetype)sharedManager;
@property(atomic,copy,readonly) NSString *status;
/// Persisted startup/restore failure, also shown on the backup page after relaunch.
@property(nonatomic,copy,readonly) NSString *lastRestoreFailure;
- (void)list:(CSBackupCompletion)completion;
- (void)load:(NSDictionary *)record completion:(CSBackupCompletion)completion;
- (void)create:(NSString *)name completion:(CSBackupCompletion)completion;
- (void)importURL:(NSURL *)url completion:(CSBackupCompletion)completion;
- (void)exportSnapshot:(NSDictionary *)snapshot completion:(CSBackupCompletion)completion;
- (void)exportOriginal:(NSDictionary *)record completion:(CSBackupCompletion)completion;
- (void)remove:(NSDictionary *)record completion:(CSBackupCompletion)completion;
- (void)updateMetadata:(NSDictionary *)metadata record:(NSDictionary *)record completion:(CSBackupCompletion)completion;
- (void)preview:(NSDictionary *)snapshot modules:(NSSet<NSString *> *)modules accounts:(NSSet<NSString *> *)accounts completion:(CSBackupCompletion)completion;
- (void)prepare:(NSDictionary *)preview completion:(CSBackupCompletion)completion;
- (void)resetSnapshot:(CSBackupCompletion)completion;
- (void)checkRepairAccess:(CSBackupCompletion)completion;
/// Retry pending recovery before activation, or optional version backup after activation.
- (void)retryPendingWork:(CSBackupCompletion)completion;
- (void)cancelPending:(CSBackupCompletion)completion;
- (BOOL)isAutoBackupEnabled;
- (void)enableAutoBackup:(BOOL)enabled;
- (NSDictionary *)currentContext;
/// Called only by the startup barrier before feature hooks are installed.
- (void)resolveStartup:(CSBackupCompletion)completion;
@end
NS_ASSUME_NONNULL_END
