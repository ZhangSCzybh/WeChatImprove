#import <UIKit/UIKit.h>

// Called from the two existing avatar hooks. Only tag=101 participates.
FOUNDATION_EXPORT void CSAvatarRotationUpdate(UIView *view);
FOUNDATION_EXPORT void CSAvatarRotationPageVisibility(UIViewController *controller, BOOL visible);
FOUNDATION_EXPORT void CSAvatarRotationRefreshViews(void);
FOUNDATION_EXPORT void CSAvatarRotationPreferencesChanged(void);
FOUNDATION_EXPORT void CSAvatarRotationInstall(NSUserDefaults *defaults);
