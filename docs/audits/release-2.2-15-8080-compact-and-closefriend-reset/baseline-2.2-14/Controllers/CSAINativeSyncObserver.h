#import <Foundation/Foundation.h>

/// Observes the evidenced native transaction path without changing its arguments,
/// account wrapper, result or pause/busy state. Unsupported hosts keep the fallback.
FOUNDATION_EXPORT void CSAIInstallNativeSyncObserver(void);
/// Keeps the caller's account-bound wrapper invocation intact while identifying
/// the concrete service that creates its scene-12 transaction. Main-thread only.
FOUNDATION_EXPORT void CSAIObserveBackgroundSyncRequest(NSUInteger expectedEpoch, void (^request)(void));
