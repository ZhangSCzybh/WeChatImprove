#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <stdint.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(uint64_t, CSAdPurificationScope) {
    CSAdPurificationArticles = 1ULL << 0,
    CSAdPurificationSubscriptions = 1ULL << 1,
    CSAdPurificationMoments = 1ULL << 2,
    CSAdPurificationFinder = 1ULL << 3,
    CSAdPurificationMiniPrograms = 1ULL << 4,
    CSAdPurificationSearch = 1ULL << 5,
    CSAdPurificationRecommendations = 1ULL << 6,
};

#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT NSString *const CSAdPurificationEnabledKey;
FOUNDATION_EXPORT NSNotificationName const CSAdPurificationChangedNotification;
NSArray<NSDictionary *> *CSAdPurificationOptions(void);
NSString *CSAdPurificationPreferenceKey(NSString *identifier);
BOOL CSAdPurificationSetting(NSString *key);
void CSAdPurificationSetSetting(NSString *key, BOOL value);
void CSAdPurificationStart(void);
void CSAdPurificationRefresh(void);
CSAdPurificationScope CSAdPurificationActiveScopes(void);
BOOL CSAdPurificationShouldApply(CSAdPurificationScope scope);
/// The caller transfers ownership of block-created IMPs, including failed/duplicate attempts.
/// Native C IMPs are also accepted. A complete signature match is required.
BOOL CSAdPurificationInstallHook(NSString *className, NSString *selector, BOOL classMethod,
    const char *encoding, IMP replacement, IMP _Nullable * _Nonnull original);
void CSAdPurificationInstallNativeHooks(void);
void CSAdPurificationInstallSubscriptionHooks(void);
void CSAdPurificationInstallWebHooks(void);
BOOL CSAdPurificationFinderItemIsAd(id _Nullable item);
#ifdef CS_AD_PURIFICATION_TESTING
void CSAdPurificationUseTestDefaults(NSUserDefaults *defaults);
void CSAdPurificationTestHookMessage(Class cls, SEL selector, IMP replacement, IMP _Nullable * _Nonnull original);
NSUInteger CSAdPurificationInstalledHookCount(void);
#endif
#ifdef __cplusplus
}
#endif
NS_ASSUME_NONNULL_END
