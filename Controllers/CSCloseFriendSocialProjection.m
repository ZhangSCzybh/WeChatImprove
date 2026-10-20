#import "CSCloseFriendSocialProjection.h"
BOOL CSCloseFriendSocialObjectHidden(id object,CSCloseFriendSnapshot *snapshot,CSCloseFriendSurface surface,CSCloseFriendSocialRead read) {
    if([object isKindOfClass:NSString.class]) return [snapshot hidesUserName:object surface:surface];
    // WCDataItem / WCUserComment. Message object IDs are deliberately not usernames.
    for(NSString *key in @[@"username",@"refUserName",@"dataItemUsrName"]) {
        id name=read(object,key);
        if([name isKindOfClass:NSString.class] && [snapshot hidesUserName:name surface:surface]) return YES;
    }
    for(NSString *key in @[@"comment",@"refComment"]) {
        id comment=read(object,key);
        if(comment && comment!=object) {
            for(NSString *identity in @[@"username",@"refUserName",@"dataItemUsrName"]) {
                id name=read(comment,identity);
                if([name isKindOfClass:NSString.class] && [snapshot hidesUserName:name surface:surface]) return YES;
            }
        }
    }
    return NO;
}
@implementation CSCloseFriendSocialProjection
- (instancetype)initWithSource:(NSArray *)source snapshot:(CSCloseFriendSnapshot *)snapshot surface:(CSCloseFriendSurface)surface read:(CSCloseFriendSocialRead)read {
    if((self=[super init])) {
        _source=[source isKindOfClass:NSArray.class] ? [source copy] : @[];
        NSMutableArray *items=[NSMutableArray array], *indexes=[NSMutableArray array];
        [_source enumerateObjectsUsingBlock:^(id item,NSUInteger index,__unused BOOL *stop){
            if(!CSCloseFriendSocialObjectHidden(item,snapshot,surface,read)) { [items addObject:item]; [indexes addObject:@(index)]; }
        }]; _visible=[items copy]; _indexes=[indexes copy];
    } return self;
}
- (NSUInteger)sourceIndex:(NSUInteger)index { return index<_indexes.count ? _indexes[index].unsignedIntegerValue : NSNotFound; }
@end
