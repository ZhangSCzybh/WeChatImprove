#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT NSString *const CSMomentsLayoutEnabledKey;
FOUNDATION_EXPORT NSNotificationName const CSMomentsLayoutChangedNotification;
/// Cached policy; safe to read from native callbacks without accessing defaults.
BOOL CSMomentsLayoutEnabled(void);
void CSMomentsLayoutSetEnabled(BOOL enabled);
/// Call after the backup startup gate has applied any pending restore.
void CSMomentsLayoutStart(void);
void CSMomentsLayoutRefresh(void);
#ifdef CS_MOMENTS_LAYOUT_TESTING
void CSMomentsLayoutUseTestDefaults(NSUserDefaults *defaults);
#endif
#ifdef __cplusplus
}
#endif

NS_ASSUME_NONNULL_END
