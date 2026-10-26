#import "CSMessageMediaProvider.h"
#import "CSMessageNativeActionAdapter.h"
NS_ASSUME_NONNULL_BEGIN
@interface CSMessageImageStickerAdapter : NSObject
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment media:(CSMessageMediaProvider *)media;
@property(nonatomic, copy) BOOL (^validate)(CSMessageActionContext *context);
// WeChat owns all progress/result UI; this adapter never presents plugin feedback.
// The factory separates UIKit image decoding from the native lifecycle for host regression tests.
@property(nonatomic, copy) id _Nullable (^taskFactory)(NSData *data);
- (void)addContext:(CSMessageActionContext *)context;
- (void)cancelInvalidOperations;
- (void)cancelAllOperations;
@end
NS_ASSUME_NONNULL_END
