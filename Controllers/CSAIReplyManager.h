#import <Foundation/Foundation.h>
#import "CSAIReplyStore.h"
#import "CSAIClient.h"
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSNotificationName const CSAIReplyDidChange;
@interface CSAIReplyManager : NSObject
+ (instancetype)sharedManager;
@property(nonatomic,strong,readonly,nullable) CSAIReplyStore *store;
@property(nonatomic,readonly) NSUInteger epoch;
@property(nonatomic,copy,readonly,nullable) NSString *connectionStatus;
- (void)start;
- (void)refresh;
- (BOOL)isCurrentAccount:(NSString *)account epoch:(NSUInteger)epoch;
- (BOOL)saveConfiguration:(NSDictionary *)configuration account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
- (BOOL)saveConnection:(NSString *)endpoint model:(NSString *)model key:(nullable NSString *)key account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
- (id<CSAICancellable>)testConnectionForAccount:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAICompletion)completion;
- (BOOL)setConversation:(NSString *)conversation enabled:(BOOL)enabled presetID:(NSString *)presetID account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
- (NSString *)statusForConversation:(nullable NSString *)conversation;
- (NSString *)displayNameForConversation:(NSString *)conversation;
- (NSString *)presetNameForConversation:(nullable NSString *)conversation;
/// Presentation/editing access only; hidden conversations may still auto-reply.
- (BOOL)allowsConversation:(NSString *)conversation;
- (void)receiveNativeSession:(id)session wrap:(id)wrap epoch:(NSUInteger)epoch;
@end
NS_ASSUME_NONNULL_END
