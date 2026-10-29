#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CSCloseFriendPolicy.h"
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT NSString *const CSCloseFriendPolicyDidChangeNotification;
FOUNDATION_EXPORT CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void);
FOUNDATION_EXPORT NSUInteger CSCloseFriendAccountEpoch(void);
FOUNDATION_EXPORT BOOL CSCloseFriendShouldHideUserName(NSString *name, CSCloseFriendSurface surface);
FOUNDATION_EXPORT BOOL CSCloseFriendShouldRejectCall(NSString *caller, NSString *room, BOOL video);
FOUNDATION_EXPORT BOOL CSCloseFriendHidesPrivacyIcons(void);
FOUNDATION_EXPORT id CSCloseFriendRead(id object, NSString *key);
FOUNDATION_EXPORT NSString *CSCloseFriendUserName(id object);
FOUNDATION_EXPORT void CSCloseFriendLock(void);
FOUNDATION_EXPORT void CSCloseFriendAuthenticate(UIViewController *presenter, void (^completion)(BOOL));
FOUNDATION_EXPORT void CSCloseFriendRecordCapability(NSString *name, BOOL available);
FOUNDATION_EXPORT NSDictionary *CSCloseFriendCurrentProfile(void);
FOUNDATION_EXPORT BOOL CSCloseFriendUpdateCurrentProfile(NSDictionary *profile, NSError **error);
FOUNDATION_EXPORT BOOL CSCloseFriendInstallHook(NSString *className, NSString *selector, IMP replacement, IMP *original, const char *typeEncoding);
/// Shared full normalized signature comparison for guarded reads/calls and hooks.
FOUNDATION_EXPORT BOOL CSCloseFriendMethodMatches(Method method, const char *typeEncoding);
FOUNDATION_EXPORT BOOL CSCloseFriendPluginEntryHidden(void);
#ifdef __cplusplus
}
#endif
