#import <Foundation/Foundation.h>
#ifdef __cplusplus
extern "C" {
#endif
/// Resolve authoritative account first. Available authoritative getter returning nil is logged out,
/// never permission to fall back to a cached self contact. Injectable class lookup for host tests.
FOUNDATION_EXPORT NSString *CSCloseFriendResolveAccount(Class (^classLookup)(NSString *));
#ifdef __cplusplus
}
#endif
