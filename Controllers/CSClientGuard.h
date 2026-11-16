#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <stdint.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(uint64_t, CSClientGuardCapability) {
    CSClientGuardEnvironment = 1ULL << 0,
    CSClientGuardFrameworks = 1ULL << 1,
    CSClientGuardProvisionPath = 1ULL << 2,
    CSClientGuardProvisionRead = 1ULL << 3,
    CSClientGuardBundleInfo = 1ULL << 4,
    CSClientGuardReceipt = 1ULL << 5,
    CSClientGuardCrashBlock = 1ULL << 6,
    CSClientGuardCrashMonitor = 1ULL << 7,
    CSClientGuardVendorID = 1ULL << 8,
    CSClientGuardChecks = 1ULL << 9,
    CSClientGuardImages = 1ULL << 10,
    CSClientGuardSafeMode = 1ULL << 11,
    CSClientGuardFriendScope = 1ULL << 12,
    CSClientGuardDeviceChecks = 1ULL << 13,
    CSClientGuardDeviceReport = 1ULL << 14,
    CSClientGuardFingerprintData = 1ULL << 15,
    CSClientGuardBasicData = 1ULL << 16,
    CSClientGuardRiskResults = 1ULL << 17,
    CSClientGuardPolicyCompletion = 1ULL << 18,
    CSClientGuardCCData = 1ULL << 19,
    CSClientGuardDeviceReports = 1ULL << 20,
    CSClientGuardSafetyReports = 1ULL << 21,
    CSClientGuardBehaviorReports = 1ULL << 22,
    CSClientGuardDetectionResults = 1ULL << 23,
    CSClientGuardDetectionReports = 1ULL << 24,
    CSClientGuardExperimentReports = 1ULL << 25,
    CSClientGuardTLSTrust = 1ULL << 26,
    CSClientGuardTLSPinning = 1ULL << 27,
};

typedef NS_ENUM(NSUInteger, CSClientGuardCallOutcome) {
    CSClientGuardCallApplied = 0,
    CSClientGuardCallDisabled,
    CSClientGuardCallOutOfScope,
    CSClientGuardCallBypassed,
    CSClientGuardCallResourceUnavailable,
    CSClientGuardCallUnexpectedValue,
    CSClientGuardCallUnsupportedCallback,
    CSClientGuardCallUnmatchedQuery,
    CSClientGuardCallOriginalException,
    CSClientGuardCallOutcomeCount
};

#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT NSString *const CSClientGuardEnabledKey;
FOUNDATION_EXPORT NSString *const CSClientGuardScopedKey;
FOUNDATION_EXPORT NSString *const CSClientGuardChangedNotification;
/// Rows also contain section, sectionOrder, order, scopedQuery, dependencies
/// (any matching query identifier), resource, restartRequired and interfaces.
NSArray<NSDictionary *> *CSClientGuardOptions(void);
/// Main-thread UI snapshots add configured, published, installation, observed,
/// applied, fallback, lastOutcome, resourceReady, resourceStatus and restartPending.
/// Interface records distinguish classFound/methodFound/oppositeMethodAvailable,
/// availabilityCode and installationCode; observing an opposite method never installs it.
NSArray<NSDictionary *> *CSClientGuardCapabilityStates(void);
/// Session version/build and aggregate refresh/resource counters; no persistent log.
NSDictionary *CSClientGuardSessionSnapshot(void);
/// Exact current host identity check for adapters verified against one build.
BOOL CSClientGuardHostMatches(NSString *version, NSString *build);
NSString *CSClientGuardPreferenceKey(NSString *identifier);
BOOL CSClientGuardSetting(NSString *key);
void CSClientGuardSetSetting(NSString *key, BOOL value);
void CSClientGuardStart(void);
void CSClientGuardRefresh(void);
BOOL CSClientGuardShouldApply(CSClientGuardCapability capability, BOOL scopedQuery);
/// Call only for a matched Hook invocation, never for installer eligibility.
/// Records observation and rejected admission; true requires one RecordOutcome.
BOOL CSClientGuardEvaluateCall(CSClientGuardCapability capability, BOOL scopedQuery);
void CSClientGuardRecordOutcome(CSClientGuardCapability capability, CSClientGuardCallOutcome outcome);
void CSClientGuardWithCheckScope(void (NS_NOESCAPE ^work)(void));
void CSClientGuardWithoutOverrides(void (NS_NOESCAPE ^work)(void));
NSString *CSClientGuardHostBundlePath(void);
NSString * _Nullable CSClientGuardReplacementInfoPath(void);
NSDictionary * _Nullable CSClientGuardReplacementInfo(void);
NSURL * _Nullable CSClientGuardReceiptURL(void);
NSUUID * _Nullable CSClientGuardVendorUUID(void);
NSSet<NSString *> *CSClientGuardImageNames(void);
void CSClientGuardRecordStatus(NSString *name, NSString *status);
NSString *CSClientGuardDiagnosticSummary(void);
/// Takes ownership of a block-created replacement, disposing it if not installed.
BOOL CSClientGuardInstallHook(NSString *className, NSString *selector, BOOL classMethod,
    const char *encoding, IMP replacement, IMP _Nullable * _Nonnull original);
void CSClientGuardInstallQueryHooks(void);
void CSClientGuardInstallNativeHooks(void);
void CSClientGuardInstallJiDeNativeHooks(void);
void CSClientGuardInstallJiDeQueryHooks(void);
#ifdef CS_CLIENT_GUARD_TESTING
NSDictionary<NSString *, NSString *> *CSClientGuardStatuses(void);
void CSClientGuardUseTestDefaults(NSUserDefaults *defaults, NSString *bundlePath, NSURL *libraryURL);
/// Both nil clears the isolated test identity and resumes main-bundle reads.
void CSClientGuardUseTestHostVersion(NSString * _Nullable version, NSString * _Nullable build);
void CSClientGuardBeforeRefreshResourcesForTesting(void (^ _Nullable callback)(void));
void CSClientGuardTestHookMessage(Class cls, SEL selector, IMP replacement, IMP _Nullable * _Nonnull original);
#endif
#ifdef __cplusplus
}
#endif
NS_ASSUME_NONNULL_END
