#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Main-thread installation. Unsupported hosts retain the compatibility pull.
FOUNDATION_EXPORT void CSAutomationInstallNativeSync(void);
FOUNDATION_EXPORT BOOL CSAutomationNativeSyncAvailable(void);
// Lifecycle/configuration readiness can consume an already pending native need.
// This never invents a sync need, changes native flags, or starts a timer.
FOUNDATION_EXPORT void CSAutomationWakePendingNativeSync(id service, NSUInteger epoch);
NS_ASSUME_NONNULL_END
