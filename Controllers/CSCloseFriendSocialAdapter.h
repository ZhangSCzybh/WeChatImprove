#import "CSCloseFriendContactAdapter.h"
#import "CSCloseFriendSocialProjection.h"
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT void CSCFSocialInstall(void);
FOUNDATION_EXPORT void CSCFSocialProtectRoute(NSString *className,CSCloseFriendSurface surface);
FOUNDATION_EXPORT CSCloseFriendSocialProjection *CSCFSocialProject(NSArray *source,CSCloseFriendSurface surface);
FOUNDATION_EXPORT BOOL CSCFSocialHidden(id object,CSCloseFriendSurface surface);
FOUNDATION_EXPORT void CSCFSocialTrack(id owner, void (^refresh)(id));
FOUNDATION_EXPORT BOOL CSCFSocialGate(id owner,CSCloseFriendSurface surface,BOOL force);
FOUNDATION_EXPORT BOOL CSCFSocialRequireAuthentication(id owner,CSCloseFriendSurface surface);
FOUNDATION_EXPORT void CSCFSocialHook0(NSString *cls,NSString *name,void (^body)(id,void(^)(void)));
FOUNDATION_EXPORT void CSCFSocialHook1(NSString *cls,NSString *name,void (^body)(id,id,void(^)(id)));
FOUNDATION_EXPORT BOOL CSCFSocialSetIvar(id owner,NSString *name,id value);
FOUNDATION_EXPORT void CSCFSocialClearCaches(id owner,NSArray<NSString *> *names);
FOUNDATION_EXPORT id CSCFTimelineFacade(id owner);
FOUNDATION_EXPORT BOOL CSCFUnreadBegin(void);
FOUNDATION_EXPORT void CSCFUnreadEnd(BOOL previous);
FOUNDATION_EXPORT void CSCFTimelineInstall(void);
FOUNDATION_EXPORT void CSCFInteractionInstall(void);
FOUNDATION_EXPORT void CSCFStatusInstall(void);
FOUNDATION_EXPORT void CSCFAudienceInstall(void);
#ifdef __cplusplus
}
#endif
