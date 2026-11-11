#import "CSMessageNativeActionAdapter.h"
NS_ASSUME_NONNULL_BEGIN
@interface CSAutomationNativeAdapter : NSObject
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment;
// Exact SendPatWrap on accepted native submission; never uses global lastSendPatWrap.
- (nullable id)sendPatTo:(NSString *)sender conversation:(NSString *)conversation account:(NSString *)account valid:(BOOL (^)(void))valid;
// deferred is YES only for an unavailable live-account lookup before any native
// invocation. A native call/exception/unknown result must never request a retry.
- (nullable id)sendPatTo:(NSString *)sender conversation:(NSString *)conversation account:(NSString *)account valid:(BOOL (^)(void))valid deferred:(BOOL *_Nullable)deferred;
// Reports only a normal native handoff; requires the exact successful auto send.
- (BOOL)revokePat:(id)sendPat conversation:(NSString *)conversation account:(NSString *)account valid:(BOOL (^)(void))valid;
- (BOOL)revokePat:(id)sendPat conversation:(NSString *)conversation account:(NSString *)account valid:(BOOL (^)(void))valid deferred:(BOOL *_Nullable)deferred;
- (NSTimeInterval)revokeWindow;
@end
// Main-thread native result observation. The adapter attaches state before native
// submission, so registering after sendPatTo returns also sees synchronous results.
FOUNDATION_EXPORT void CSAutomationObservePatResult(id sendPat,void (^completion)(BOOL success));
FOUNDATION_EXPORT void CSAutomationCancelPatObservation(id sendPat);
FOUNDATION_EXPORT void CSAutomationInstallNativeHooks(void);
NS_ASSUME_NONNULL_END
