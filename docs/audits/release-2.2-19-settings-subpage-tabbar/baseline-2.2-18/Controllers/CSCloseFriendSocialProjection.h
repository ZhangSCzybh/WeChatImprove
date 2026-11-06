#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"
typedef id (^CSCloseFriendSocialRead)(id object, NSString *key);
/// Original coordinates and native objects are retained; no native model is cloned or mutated.
@interface CSCloseFriendSocialProjection : NSObject
@property(nonatomic,copy,readonly) NSArray *source;
@property(nonatomic,copy,readonly) NSArray *visible;
@property(nonatomic,copy,readonly) NSArray<NSNumber *> *indexes;
- (instancetype)initWithSource:(NSArray *)source snapshot:(CSCloseFriendSnapshot *)snapshot surface:(CSCloseFriendSurface)surface read:(CSCloseFriendSocialRead)read;
- (NSUInteger)sourceIndex:(NSUInteger)visibleIndex;
@end
FOUNDATION_EXPORT BOOL CSCloseFriendSocialObjectHidden(id object, CSCloseFriendSnapshot *snapshot, CSCloseFriendSurface surface, CSCloseFriendSocialRead read);
