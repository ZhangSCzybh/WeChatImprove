#import "CSMessageNativeActionAdapter.h"
#import "CSMessageMediaProvider.h"
NS_ASSUME_NONNULL_BEGIN
@interface CSMessagePreparedSend : NSObject
@property(nonatomic, strong, readonly, nullable) id outputWrap;
@property(nonatomic, copy, readonly) NSString *routeName;
// Only records a normal return from the selected native send call; never acceptance/delivery.
@property(nonatomic, readonly) BOOL nativeHandoffReturned;
@property(nonatomic, copy, nullable) BOOL (^submissionStillAuthorized)(void);
- (instancetype)initWithWrap:(nullable id)wrap routeName:(NSString *)routeName submission:(CSMessageActionSubmissionState (^)(void))submission;
// Called exactly once by the coordinator after the per-target ledger claim. Never retries.
- (CSMessageActionSubmissionState)submit;
@end
@interface CSMessageSendAdapter : NSObject
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment;
// Source-neutral voice construction: no source message/cell is required or mutated.
- (nullable id)voiceWrapForResource:(CSMessageVoiceResource *)resource accountID:(NSString *)accountID targetID:(NSString *)targetID;
- (nullable CSMessagePreparedSend *)prepareVoiceResource:(CSMessageVoiceResource *)resource accountID:(NSString *)accountID targetID:(NSString *)targetID;
// Fresh text for an explicitly configured task. Preparation never sends or opens a chat.
- (nullable CSMessagePreparedSend *)prepareScheduledText:(NSString *)text targetID:(NSString *)targetID accountID:(NSString *)accountID;
// Fresh group text with actual native mention metadata. Preparation never sends.
- (nullable CSMessagePreparedSend *)prepareGroupText:(NSString *)text mentions:(NSArray<NSString *> *)mentions targetID:(NSString *)targetID accountID:(NSString *)accountID;
// Native type-49/subtype-57 quote construction. Requires a referenceable source
// from this exact conversation and a positive server identity; never opens UI.
- (nullable CSMessagePreparedSend *)prepareAutomationQuote:(NSString *)text source:(id)source targetID:(NSString *)targetID accountID:(NSString *)accountID;
- (nullable CSMessagePreparedSend *)prepareContext:(CSMessageActionContext *)context targetID:(NSString *)targetID voice:(nullable CSMessageVoiceResource *)voice appData:(nullable NSData *)appData appDataPath:(nullable NSString *)path;
- (nullable CSMessagePreparedSend *)prepareContext:(CSMessageActionContext *)context targetID:(NSString *)targetID voice:(nullable CSMessageVoiceResource *)voice;
@end
NS_ASSUME_NONNULL_END
