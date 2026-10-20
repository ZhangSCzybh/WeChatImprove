#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
#ifdef __cplusplus
extern "C" {
#endif
typedef NS_ENUM(NSUInteger, CSCloseFriendSurface) {
    CSCloseFriendSurfaceSession, CSCloseFriendSurfaceContact, CSCloseFriendSurfaceForward,
    CSCloseFriendSurfaceTag, CSCloseFriendSurfaceSearch, CSCloseFriendSurfaceTimeline,
    CSCloseFriendSurfaceInteraction, CSCloseFriendSurfaceStatus, CSCloseFriendSurfaceProfile
};
FOUNDATION_EXPORT NSDictionary *CSCloseFriendDefaultOptions(void);
/// Rejects unknown fields, malformed booleans, invalid names and oversized profiles. Returns a deep immutable value.
FOUNDATION_EXPORT NSDictionary * _Nullable CSCloseFriendNormalizeProfile(id profile, NSError **error);
@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic, copy, readonly) NSString *accountID;
@property(nonatomic, readonly) NSUInteger revision;
@property(nonatomic, readonly) BOOL enabled, revealed, blocked;
@property(nonatomic, copy, readonly) NSSet<NSString *> *protectedUserNames;
@property(nonatomic, copy, readonly) NSDictionary *options;
- (instancetype)initWithAccountID:(NSString *)accountID profile:(NSDictionary *)profile revealed:(BOOL)revealed revision:(NSUInteger)revision blocked:(BOOL)blocked;
- (BOOL)containsUserName:(nullable NSString *)name;
- (BOOL)hidesUserName:(nullable NSString *)name surface:(CSCloseFriendSurface)surface;
- (BOOL)silencesSession:(nullable NSString *)session sender:(nullable NSString *)sender;
- (BOOL)rejectsCaller:(nullable NSString *)caller chatRoom:(nullable NSString *)room video:(BOOL)video;
@end
#ifdef __cplusplus
}
#endif
NS_ASSUME_NONNULL_END
