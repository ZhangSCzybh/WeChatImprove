#import "CSFavoriteVoiceContext.h"
#import "CSMessageMediaProvider.h"
#import "CSMessageNativeActionAdapter.h"

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT BOOL CSFavoriteHasPendingVoiceDownloads(void);
@interface CSFavoriteVoiceMediaProvider : NSObject
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment;
- (void)prepareContext:(CSFavoriteVoiceContext *)context operationID:(NSString *)operationID
    completion:(void (^)(CSMessageVoiceResource * _Nullable resource, NSString * _Nullable reason))completion;
- (void)cancelOperationID:(NSString *)operationID;
- (BOOL)sourceIsCurrentForContext:(CSFavoriteVoiceContext *)context;
- (void)downloadFinishedForItem:(id)item error:(int)error accountID:(NSString *)accountID epoch:(NSUInteger)epoch;
- (void)cancelAll;
@property(nonatomic, copy, nullable) BOOL (^isContextValid)(CSFavoriteVoiceContext *context);
@property(nonatomic, copy, nullable) void (^waitingHandler)(NSString *operationID);
@end
NS_ASSUME_NONNULL_END
