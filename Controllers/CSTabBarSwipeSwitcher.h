#import "CSTabBarNativeAdapter.h"

#ifdef __cplusplus
extern "C" {
#endif

UIControl *CSTabBarCreateTouchControl(MMTabBar *bar);
// Compatibility entry points for the existing native lifecycle hooks.
void CSTabBarSwipeRefresh(MMTabBar *bar);
void CSTabBarSwipeInstallObservers(void);

#ifdef __cplusplus
}
#endif
