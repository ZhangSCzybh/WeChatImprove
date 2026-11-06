#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"
typedef NSString *(^CSCloseFriendIdentity)(id object);
/// Immutable presentation copy. Never owns or edits native relationship/tag models.
@interface CSCloseFriendContactProjection : NSObject
@property(nonatomic,copy,readonly) NSArray *keys;
@property(nonatomic,copy,readonly) NSDictionary *sections;
@property(nonatomic,readonly) NSUInteger count;
- (instancetype)initWithKeys:(NSArray *)keys sections:(NSDictionary *)sections snapshot:(CSCloseFriendSnapshot *)snapshot surface:(CSCloseFriendSurface)surface identity:(CSCloseFriendIdentity)identity;
@end
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT NSArray *CSCloseFriendVisibleContacts(NSArray *source, CSCloseFriendSnapshot *snapshot, CSCloseFriendSurface surface, CSCloseFriendIdentity identity);
#ifdef __cplusplus
}
#endif
/// A selection is indivisible: never silently trim recipients at submission.
@interface CSCloseFriendSelectionTicket : NSObject
- (instancetype)initWithSnapshot:(CSCloseFriendSnapshot *)snapshot epoch:(NSUInteger)epoch;
- (BOOL)allowsRecipients:(NSArray *)recipients snapshot:(CSCloseFriendSnapshot *)snapshot epoch:(NSUInteger)epoch identity:(CSCloseFriendIdentity)identity;
@end
#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT BOOL CSCloseFriendSurfaceConcealed(CSCloseFriendSnapshot *snapshot, CSCloseFriendSurface surface);

#ifdef __cplusplus
}
#endif
