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
- (nullable CSMessagePreparedSend *)prepareContext:(CSMessageActionContext *)context targetID:(NSString *)targetID voice:(nullable CSMessageVoiceResource *)voice appData:(nullable NSData *)appData appDataPath:(nullable NSString *)path;
- (nullable CSMessagePreparedSend *)prepareContext:(CSMessageActionContext *)context targetID:(NSString *)targetID voice:(nullable CSMessageVoiceResource *)voice;
@end
NS_ASSUME_NONNULL_END
