#import "CSMessageNativeActionAdapter.h"
#import "CSMessageMediaProvider.h"
NS_ASSUME_NONNULL_BEGIN
@class CSMessageSendAdapter;
// Thread-safe, service-free boundary markers. Call immediately on the native hook thread.
FOUNDATION_EXPORT void CSMessageActionAccountWillChangeAtNativeBoundary(void);
FOUNDATION_EXPORT void CSMessageActionAccountDidChangeAtNativeBoundary(void);
// Published on main whenever this coordinator invalidates an account generation.
FOUNDATION_EXPORT NSNotificationName const CSMessageActionAccountStateDidChangeNotification;
@interface CSMessageActionCoordinator : NSObject
+ (instancetype)sharedCoordinator;
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment
    preferences:(CSMessageActionPreferences *)preferences mediaProvider:(CSMessageMediaProvider *)provider;
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment
    preferences:(CSMessageActionPreferences *)preferences mediaProvider:(CSMessageMediaProvider *)provider
    sendAdapter:(CSMessageSendAdapter *)sender nativeAdapter:(CSMessageNativeActionAdapter *)native;
@property(nonatomic, copy, nullable) void (^feedbackHandler)(NSString *message);
@property(nonatomic, readonly) CSMessageActionSettings *settings;
@property(nonatomic, copy, readonly, nullable) NSString *accountID;
@property(nonatomic, readonly) NSUInteger accountEpoch;
// Source-neutral account boundary used by independently identified media sources.
- (void)refreshAccountState;
- (BOOL)isCurrentAccountID:(NSString *)accountID epoch:(NSUInteger)epoch;
- (nullable CSMessageActionContext *)captureContextForCell:(id)cell controller:(nullable id)controller bindingGeneration:(NSUInteger)generation;
- (BOOL)validateContext:(CSMessageActionContext *)context;
- (BOOL)canExecuteContext:(CSMessageActionContext *)context action:(CSMessageAction)action entry:(CSMessageActionEntry)entry;
// Returns an ID only for plugin-owned repeat/enhanced-voice operations. Native
// actions return nil; their UI/confirmation lifetime does not occupy the send pool.
- (nullable NSString *)executeContext:(CSMessageActionContext *)context action:(CSMessageAction)action entry:(CSMessageActionEntry)entry;
- (void)cancelOperationID:(nullable NSString *)operationID;
- (void)cancelOperationsForCell:(id)cell;
- (void)cancelAllUnsubmittedOperations;
// Invoke at the established account lifecycle boundary, including logout/login to the same account.
// Logout boundary: invalidates immediately and blocks capture/submission until accountDidChange.
- (void)accountWillChange;
- (void)accountDidChange;
- (NSDictionary<NSString *, NSNumber *> *)resultsForOperationID:(nullable NSString *)operationID;
// Exact native logic bridge; callbacks never discover a different/global pending operation.
- (void)withForwardContext:(CSMessageActionContext *)context entry:(CSMessageActionEntry)entry perform:(void (^)(void))perform;
- (void)bindForwardLogic:(id)logic source:(id)source;
- (void)confirmForwardLogic:(id)logic;
- (BOOL)shouldSuppressNativeSuccessForLogic:(id)logic;
- (BOOL)handleForwardLogic:(id)logic source:(id)source target:(id)target;
- (void)finishForwardLogic:(id)logic cancelled:(BOOL)cancelled;
- (void)voiceDownloadCompletedForChat:(NSString *)chat localID:(unsigned int)localID serverID:(long long)serverID endFlag:(unsigned int)endFlag error:(unsigned int)error;
@end
NS_ASSUME_NONNULL_END
