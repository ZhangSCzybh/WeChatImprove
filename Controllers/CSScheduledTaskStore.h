#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString *const CSScheduledTaskErrorDomain;
FOUNDATION_EXPORT NSNotificationName const CSScheduledTaskConfigurationDidChange;
FOUNDATION_EXPORT NSString *const CSScheduledTaskBackupDomain;
FOUNDATION_EXPORT NSURL *CSScheduledTaskFileURL(NSURL *resourceRoot, NSString *account);
/// Portable definitions only. Execution claims, history and next-run timestamps stay local.
FOUNDATION_EXPORT NSDictionary *CSScheduledTaskBackupConfiguration(NSDictionary *state);
/// Accepts portable configuration or a full before-image used exclusively by the restore journal.
FOUNDATION_EXPORT BOOL CSScheduledTaskBackupValueValidate(id value, NSString *account, NSError **error);
// Immutable property-list rules. Intervals are anchored durations; daily/weekly use the saved time zone.
FOUNDATION_EXPORT BOOL CSScheduledTaskValidate(NSDictionary *task, NSError **error);
FOUNDATION_EXPORT NSDate * _Nullable CSScheduledTaskNext(NSDictionary *task, NSDate *after);
FOUNDATION_EXPORT NSDate * _Nullable CSScheduledTaskLatest(NSDictionary *task, NSDate *now);
FOUNDATION_EXPORT NSString *CSScheduledTaskRuleDescription(NSDictionary *task);

typedef void (^CSScheduledTaskStoreCompletion)(BOOL success, NSError * _Nullable error);
typedef void (^CSScheduledTaskClaimCompletion)(NSDictionary * _Nullable claim, NSError * _Nullable error);
// One serial I/O queue owns account files and their lifetime locks. Getters read snapshots.
// A durable claim advances nextRun before any native side effect. Unknown results are never retried.
@interface CSScheduledTaskStore : NSObject
/// Read an atomic file without acquiring the scheduler's lifetime lock or changing its state.
+ (nullable NSDictionary *)readStateAtURL:(NSURL *)url account:(NSString *)account error:(NSError **)error;
/// Startup-only transaction write. Refuses while a live scheduler owns the file lock.
+ (BOOL)replaceState:(nullable NSDictionary *)state atURL:(NSURL *)url account:(NSString *)account error:(NSError **)error;
- (instancetype)initWithURL:(NSURL *)url account:(NSString *)account;
@property(nonatomic, readonly) NSString *account;
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, readonly) BOOL ready;
@property(nonatomic, readonly) NSArray<NSDictionary *> *tasks;
@property(nonatomic, readonly) NSArray<NSDictionary *> *history;
@property(nonatomic, readonly, nullable) NSError *error;
/// Production operations never wait for disk; completions are asynchronous on main.
- (void)loadWithCompletion:(nullable CSScheduledTaskStoreCompletion)completion;
- (void)setEnabled:(BOOL)enabled now:(NSDate *)now completion:(nullable CSScheduledTaskStoreCompletion)completion;
- (void)saveTask:(NSDictionary *)task now:(NSDate *)now completion:(nullable CSScheduledTaskStoreCompletion)completion;
- (void)removeTask:(NSString *)identifier completion:(nullable CSScheduledTaskStoreCompletion)completion;
- (void)claimTask:(NSString *)identifier now:(NSDate *)now completion:(CSScheduledTaskClaimCompletion)completion;
- (void)finishClaim:(NSString *)claimID result:(NSString *)result detail:(NSString *)detail completion:(nullable CSScheduledTaskStoreCompletion)completion;
/// Revoke business callbacks immediately; drain accepted finishes before releasing the old file lock.
- (void)invalidate;
/// Background backup boundary. Waits for previously accepted disk work, never for main callbacks.
+ (BOOL)flushPendingOperations:(NSError **)error;
/// Blocking compatibility methods for offline tools/tests only.
- (BOOL)load;
- (BOOL)setEnabled:(BOOL)enabled now:(NSDate *)now;
- (BOOL)saveTask:(NSDictionary *)task now:(NSDate *)now;
- (BOOL)removeTask:(NSString *)identifier;
- (nullable NSDictionary *)claimTask:(NSString *)identifier now:(NSDate *)now;
- (BOOL)finishClaim:(NSString *)claimID result:(NSString *)result detail:(NSString *)detail;
@end
NS_ASSUME_NONNULL_END
