#import "CSMessageActionPolicy.h"
NS_ASSUME_NONNULL_BEGIN
// A checked concrete ABI boundary shared by production adapters and invocation-recording host tests.
FOUNDATION_EXPORT BOOL CSMessageNativeSupports(id _Nullable receiver, NSString *selector, NSString *resultType, NSArray<NSString *> *argumentTypes);
FOUNDATION_EXPORT id _Nullable CSMessageNativeInvoke(id receiver, NSString *selector, NSArray *arguments);
FOUNDATION_EXPORT NSString * _Nullable CSMessageNativeAppDataPath(CSMessageActionContext *context);
FOUNDATION_EXPORT id _Nullable CSMessageNativeObject(id _Nullable receiver, NSString *selector);
FOUNDATION_EXPORT unsigned long long CSMessageNativeUnsigned(id _Nullable receiver, NSString *selector);
FOUNDATION_EXPORT BOOL CSMessageNativeSet(id receiver, NSString *setter, id _Nullable value, BOOL required);
@protocol CSMessageActionEnvironment <NSObject>
- (nullable NSString *)currentAccountID;
- (nullable id)serviceNamed:(NSString *)name;
- (nullable id)controllerForCell:(id)cell;
@end
@interface CSMessageNativeEnvironment : NSObject <CSMessageActionEnvironment>
@end
@interface CSMessageNativeActionAdapter : NSObject
- (BOOL)canPerformAction:(CSMessageAction)action context:(CSMessageActionContext *)context;
// Confirmation must call valid again immediately before performing its native side effect.
- (void)performAction:(CSMessageAction)action context:(CSMessageActionContext *)context
    valid:(BOOL (^)(void))valid completion:(void (^)(CSMessageActionSubmissionState))completion;
@end
NS_ASSUME_NONNULL_END
