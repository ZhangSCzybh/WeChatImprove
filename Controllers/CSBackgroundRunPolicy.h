#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT NSString *const CSBackgroundRunPolicyKey;
FOUNDATION_EXPORT NSDictionary *CSBackgroundRunDefaultPolicy(void);
FOUNDATION_EXPORT NSDictionary *CSBackgroundRunLegacyPolicy(void);
FOUNDATION_EXPORT BOOL CSBackgroundRunValidatePolicy(id _Nullable policy, NSError **error);
/// Uses the supplied calendar's time zone. Start is inclusive and end is exclusive.
FOUNDATION_EXPORT BOOL CSBackgroundRunPolicyAllowsDate(NSDictionary *policy, NSDate *date, NSCalendar *calendar);
/// First strictly future change to the local-time window, including clock transitions.
/// Repeated hours may leave and re-enter a window; neither occurrence is skipped.
FOUNDATION_EXPORT NSDate * _Nullable CSBackgroundRunPolicyNextBoundary(NSDictionary *policy, NSDate *date, NSCalendar *calendar);
FOUNDATION_EXPORT NSString *CSBackgroundRunPolicyWindowDescription(NSDictionary *policy);
#ifdef __cplusplus
}
#endif
NS_ASSUME_NONNULL_END
