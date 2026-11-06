#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSAIReplyConfigurationDidChange;
FOUNDATION_EXPORT NSString *const CSAIReplyBackupDomain;
/// YES in a save error's userInfo when rename succeeded but directory durability
/// was not confirmed. The store is unready; retain credentials for both revisions.
FOUNDATION_EXPORT NSString *const CSAIReplyStoreCommitUncertainKey;
FOUNDATION_EXPORT NSURL *CSAIReplyFileURL(NSURL *root, NSString *account);
FOUNDATION_EXPORT NSDictionary *CSAIReplyDefaultConfiguration(void);
/// Missing capability fields keep the original generic text-only connection behavior.
FOUNDATION_EXPORT NSString *CSAIProvider(NSDictionary *configuration);
FOUNDATION_EXPORT NSString *CSAISearchMode(NSDictionary *configuration);
FOUNDATION_EXPORT BOOL CSAIReplyValidateConfiguration(id configuration, NSError **error);
FOUNDATION_EXPORT BOOL CSAIReplyValidateState(id state, NSString *account, NSError **error);
FOUNDATION_EXPORT NSDictionary *CSAIReplyPortableState(NSDictionary *state);
FOUNDATION_EXPORT NSString *CSAIConnectionIdentifier(NSDictionary *configuration);
FOUNDATION_EXPORT NSError *CSAIError(NSInteger code, NSString *message);
typedef void (^CSAIReplyStoreCompletion)(BOOL success, NSError * _Nullable error);
/// Disk operations share one serial queue; getters only read an immutable snapshot.
@interface CSAIReplyStore : NSObject
@property(nonatomic,copy,readonly) NSString *account;
@property(nonatomic,copy,readonly) NSDictionary *configuration;
@property(nonatomic,copy,readonly) NSArray<NSDictionary *> *history;
@property(nonatomic,readonly) BOOL ready;
@property(nonatomic,strong,readonly,nullable) NSError *error;
- (instancetype)initWithURL:(NSURL *)url account:(NSString *)account;
/// Production APIs. Completion is always delivered asynchronously on main.
- (void)loadWithCompletion:(nullable CSAIReplyStoreCompletion)completion;
- (void)saveConfiguration:(NSDictionary *)configuration expectedConfiguration:(NSDictionary *)expected completion:(nullable CSAIReplyStoreCompletion)completion;
- (void)claimMessageIDs:(NSArray<NSString *> *)identifiers completion:(nullable CSAIReplyStoreCompletion)completion;
/// Known-message aliases survive invalidate on their original account path.
/// Admissions coalesce into bounded batches; stale completions cannot resume business work.
- (void)claimMessageAliases:(NSArray<NSString *> *)identifiers completion:(nullable CSAIReplyStoreCompletion)completion;
/// Completion acknowledges an in-memory append; history flushes after 1s or 10 records.
- (void)appendHistory:(NSDictionary *)record completion:(nullable CSAIReplyStoreCompletion)completion;
- (void)flushHistoryWithCompletion:(nullable CSAIReplyStoreCompletion)completion;
/// Revokes queued operations and late completions without waiting for disk I/O.
- (void)invalidate;
/// Background backup boundary: drains accepted history before revision capture.
/// Refuses main-thread callers rather than blocking UI on disk I/O.
+ (BOOL)flushPendingHistory:(NSError **)error;
/// Synchronous compatibility APIs for offline tools/tests, never production UI.
- (BOOL)load;
- (BOOL)saveConfiguration:(NSDictionary *)configuration error:(NSError **)error;
- (BOOL)hasHandledMessageID:(NSString *)identifier;
/// Durably reserves all identities before network work; duplicates fail without mutation.
- (BOOL)claimMessageIDs:(NSArray<NSString *> *)identifiers error:(NSError **)error;
- (BOOL)appendHistory:(NSDictionary *)record error:(NSError **)error;
+ (nullable NSDictionary *)readStateAtURL:(NSURL *)url account:(NSString *)account error:(NSError **)error;
+ (BOOL)replaceState:(nullable NSDictionary *)state atURL:(NSURL *)url account:(NSString *)account error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
