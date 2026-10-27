#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol CSAICancellable <NSObject>
- (void)cancel;
@end
typedef void (^CSAICompletion)(NSString * _Nullable text, NSError * _Nullable error);
/// Result contains text, optional responseID and normalized usage counters only.
typedef void (^CSAIResultCompletion)(NSDictionary * _Nullable result, NSError * _Nullable error);
enum { CSAIResponseReferenceExpired = 41001 };
@protocol CSAIGenerating <NSObject>
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)configuration apiKey:(NSString *)apiKey messages:(NSArray<NSDictionary *> *)messages completion:(CSAICompletion)completion;
@optional
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)configuration apiKey:(NSString *)apiKey messages:(NSArray<NSDictionary *> *)messages previousResponseID:(nullable NSString *)previousResponseID completion:(CSAIResultCompletion)completion;
@end
FOUNDATION_EXPORT BOOL CSAIValidateEndpoint(NSString *endpoint, NSError **error);
@interface CSAIClient : NSObject <CSAIGenerating>
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;
@end
NS_ASSUME_NONNULL_END
