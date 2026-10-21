#import "CSCloseFriendContactAdapter.h"
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT void CSCFProfileBind(id controller);
FOUNDATION_EXPORT void CSCFProfileWithNativePresentation(id object,void (^render)(void));
FOUNDATION_EXPORT BOOL CSCFProfileUsesNativeStranger(id object);
FOUNDATION_EXPORT void CSCFProfileLocalAdd(id object);
FOUNDATION_EXPORT void CSCFProfileRefresh(id controller);
FOUNDATION_EXPORT BOOL CSCFProfileBlocksAction(id object);
/// Native album/social-info navigation remains available for a current concealed profile.
FOUNDATION_EXPORT BOOL CSCFProfileBlocksNavigation(id object);
#ifdef __cplusplus
}
#endif
