#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CSBackupStartupCompletion)(NSError * _Nullable error);
typedef void (^CSBackupStartupResolver)(CSBackupStartupCompletion completion);

#ifdef __cplusplus
extern "C" {
#endif
/// On an ordinary launch, execute immediately in the caller's existing constructor order.
/// Recovery holds callbacks until a successful resolution, then executes them once on main.
void CSBackupWhenReady(void (^callback)(void));
BOOL CSBackupIsReady(void);
/// Retry only while startup is held. A prepared plan must never apply to active feature hooks.
void CSBackupRetryStartup(CSBackupStartupCompletion _Nullable completion);
void CSBackupResumeAfterRecovery(void);
NSUInteger CSBackupAccountEpoch(void);
BOOL CSBackupAccountIsSuspended(void);
/// Main-thread handoff and native account boundary markers share one short lock.
BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch, void (^handoff)(void));
void CSBackupAccountWillChangeAtNativeBoundary(void);
void CSBackupAccountDidChangeAtNativeBoundary(void);

/// Metadata-only startup probe. Only a journal or inaccessible journal path holds startup.
/// Version changes never block the original plugin framework.
BOOL CSBackupStartupNeedsResolution(NSURL *journalURL, NSString * _Nullable protectedVersion, NSString *currentVersion);
#ifdef __cplusplus
}
#endif

/// Foundation-only state machine shared by production startup and deterministic lifecycle tests.
/// The resolver starts asynchronously on main and owns all expensive work on its I/O queue.
@interface CSBackupStartupGate : NSObject
- (instancetype)initWithNeedsResolution:(BOOL)needsResolution resolver:(CSBackupStartupResolver)resolver;
@property(nonatomic, readonly, getter=isReady) BOOL ready;
- (void)whenReady:(void (^)(void))callback;
- (void)retry:(CSBackupStartupCompletion _Nullable)completion;
@end

NS_ASSUME_NONNULL_END
