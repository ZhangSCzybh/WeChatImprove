#import "CSCloseFriendContactProjection.h"
BOOL CSCloseFriendSurfaceConcealed(CSCloseFriendSnapshot *snapshot, CSCloseFriendSurface surface) {
    if(snapshot.blocked) return YES;
    for(NSString *name in snapshot.protectedUserNames) if([snapshot hidesUserName:name surface:surface]) return YES;
    return NO;
}
NSArray *CSCloseFriendVisibleContacts(NSArray *source, CSCloseFriendSnapshot *snapshot, CSCloseFriendSurface surface, CSCloseFriendIdentity identity) {
    if(![source isKindOfClass:NSArray.class]) return @[];
    if(snapshot.blocked) return @[];
    NSMutableArray *visible=[NSMutableArray array];
    for(id object in source) if(![snapshot hidesUserName:identity(object) surface:surface]) [visible addObject:object];
    return [visible copy];
}
@implementation CSCloseFriendContactProjection
- (instancetype)initWithKeys:(NSArray *)keys sections:(NSDictionary *)sections snapshot:(CSCloseFriendSnapshot *)snapshot surface:(CSCloseFriendSurface)surface identity:(CSCloseFriendIdentity)identity {
    if((self=[super init])) {
        NSMutableArray *visibleKeys=[NSMutableArray array]; NSMutableDictionary *visibleSections=[NSMutableDictionary dictionary];
        for(id key in keys) {
            NSArray *rows=CSCloseFriendVisibleContacts(sections[key],snapshot,surface,identity);
            if(rows.count) { [visibleKeys addObject:key]; visibleSections[key]=rows; _count+=rows.count; }
        }
        _keys=[visibleKeys copy]; _sections=[visibleSections copy];
    } return self;
}
@end
@implementation CSCloseFriendSelectionTicket {
    NSString *_accountID; NSUInteger _epoch; NSUInteger _revision;
}
- (instancetype)initWithSnapshot:(CSCloseFriendSnapshot *)snapshot epoch:(NSUInteger)epoch {
    if((self=[super init])) { _accountID=[snapshot.accountID copy]; _epoch=epoch; _revision=snapshot.revision; } return self;
}
- (BOOL)allowsRecipients:(NSArray *)recipients snapshot:(CSCloseFriendSnapshot *)snapshot epoch:(NSUInteger)epoch identity:(CSCloseFriendIdentity)identity {
    if(snapshot.blocked || _epoch!=epoch || ![_accountID isEqual:snapshot.accountID] || _revision!=snapshot.revision) return NO;
    for(id recipient in recipients) { NSString *name=identity(recipient); if(!name.length || [snapshot hidesUserName:name surface:CSCloseFriendSurfaceForward]) return NO; }
    return YES;
}
@end
