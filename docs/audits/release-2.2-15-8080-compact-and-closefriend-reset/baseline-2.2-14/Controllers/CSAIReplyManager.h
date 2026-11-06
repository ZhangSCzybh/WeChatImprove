#import <Foundation/Foundation.h>
#import <TargetConditionals.h>
#import "CSAIReplyStore.h"
#import "CSAIClient.h"
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSAIReplyDidChange;
/// Thread-safe admission hint only. Native objects and final account checks stay on main.
FOUNDATION_EXPORT BOOL CSAIReplyMessageIngressEnabled(void);
/// Reads an immutable admission snapshot; unknown session shapes retain main-thread validation.
FOUNDATION_EXPORT BOOL CSAIReplyMessageIngressAllowsSession(id _Nullable session, NSUInteger epoch);
@interface CSAIReplyManager : NSObject
+ (instancetype)sharedManager;
@property(nonatomic,strong,readonly,nullable) CSAIReplyStore *store;
@property(nonatomic,readonly) NSUInteger epoch;
@property(nonatomic,copy,readonly,nullable) NSString *connectionStatus;
- (void)start;
- (void)refresh;
/// Opaque, one-use scope captured before a native full synchronization starts.
/// Both methods are main-thread only; stale account/configuration scopes are ignored.
- (nullable id)captureBackgroundSyncContextForEpoch:(NSUInteger)epoch;
- (void)nativeFullSyncCompletedWithContext:(id)context;
- (BOOL)isCurrentAccount:(NSString *)account epoch:(NSUInteger)epoch;
/// Saves complete asynchronously on main after durable storage and account revalidation.
- (void)saveConfiguration:(NSDictionary *)configuration account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion;
- (void)saveConnection:(NSString *)endpoint model:(NSString *)model key:(nullable NSString *)key account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion;
- (id<CSAICancellable>)testConnectionForAccount:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAICompletion)completion;
- (void)setConversation:(NSString *)conversation enabled:(BOOL)enabled presetID:(NSString *)presetID account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion;
- (void)setConversation:(NSString *)conversation allowUnmentioned:(BOOL)allowUnmentioned account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion;
#if !TARGET_OS_IPHONE
/// Blocking host-fixture compatibility only; unavailable in the iPhone build.
- (BOOL)saveConfiguration:(NSDictionary *)configuration account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
- (BOOL)saveConnection:(NSString *)endpoint model:(NSString *)model key:(nullable NSString *)key account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
- (BOOL)setConversation:(NSString *)conversation enabled:(BOOL)enabled presetID:(NSString *)presetID account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
- (BOOL)setConversation:(NSString *)conversation allowUnmentioned:(BOOL)allowUnmentioned account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
#endif
- (NSString *)statusForConversation:(nullable NSString *)conversation;
- (NSString *)displayNameForConversation:(NSString *)conversation;
- (NSString *)presetNameForConversation:(nullable NSString *)conversation;
/// Presentation/editing access only; hidden conversations may still auto-reply.
- (BOOL)allowsConversation:(NSString *)conversation;
- (void)receiveNativeSession:(id)session wrap:(id)wrap epoch:(NSUInteger)epoch;
@end
NS_ASSUME_NONNULL_END
