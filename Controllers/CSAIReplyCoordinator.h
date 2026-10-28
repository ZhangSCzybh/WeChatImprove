#import "CSAIReplyStore.h"
#import "CSAIClient.h"
#import "CSAIImagePreparer.h"
NS_ASSUME_NONNULL_BEGIN
@class CSAIReplyCoordinator;
@protocol CSAIReplyCoordinatorDelegate <NSObject>
- (BOOL)coordinator:(CSAIReplyCoordinator *)coordinator allowsConversation:(NSString *)conversation;
- (nullable NSString *)credentialForCoordinator:(CSAIReplyCoordinator *)coordinator error:(NSError **)error;
/// Returns submitted, unknown or failed. Must execute valid immediately at the native boundary.
- (NSString *)coordinator:(CSAIReplyCoordinator *)coordinator submitText:(NSString *)text conversation:(NSString *)conversation valid:(BOOL (^)(void))valid;
@end
@interface CSAIReplyCoordinator : NSObject
@property(nonatomic,strong,readonly) CSAIReplyStore *store;
@property(nonatomic,weak) id<CSAIReplyCoordinatorDelegate> delegate;
@property(nonatomic,copy) NSTimeInterval (^now)(void);
@property(nonatomic,strong,nullable) id<CSAIImagePreparing> imagePreparer;
@property(nonatomic,readonly) NSUInteger activeCount;
@property(nonatomic,readonly) NSUInteger pendingCount;
- (instancetype)initWithStore:(CSAIReplyStore *)store client:(id<CSAIGenerating>)client;
- (void)receiveEvent:(NSDictionary *)event;
- (void)configurationDidChange;
- (void)cancelAll;
/// Deterministic timer seam. Production also schedules bounded one-shot wakeups.
- (void)processPending;
@end
NS_ASSUME_NONNULL_END
