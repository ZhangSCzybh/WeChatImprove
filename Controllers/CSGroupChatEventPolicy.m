#import "CSGroupChatEventPolicy.h"
BOOL CSGroupChatValidMemberID(id value) {
    if(![value isKindOfClass:NSString.class] || ![value length] || [value length]>128 || [value hasSuffix:@"@chatroom"] || [value isEqual:@"notify@all"])return NO;
    NSCharacterSet *allowed=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-@."];
    return [value rangeOfCharacterFromSet:allowed.invertedSet].location==NSNotFound;
}
NSSet<NSString *> *CSGroupChatValidatedMembers(id list,NSUInteger count) {
    if(![list isKindOfClass:NSArray.class] || !count || count>10000 || [list count]!=count)return nil;
    NSMutableSet *members=[NSMutableSet set];for(id member in list){if(!CSGroupChatValidMemberID(member) || [members containsObject:member])return nil;[members addObject:member];}
    return [members copy];
}
static BOOL Snapshot(NSDictionary *value) {
    if(![value isKindOfClass:NSDictionary.class] || ![value[@"roomID"] isKindOfClass:NSString.class] || ![value[@"roomID"] hasSuffix:@"@chatroom"] ||
       ![value[@"version"] isKindOfClass:NSNumber.class] || ![value[@"observedAt"] isKindOfClass:NSDate.class] || ![value[@"members"] isKindOfClass:NSArray.class])return NO;
    return CSGroupChatValidatedMembers(value[@"members"],[value[@"members"] count])!=nil;
}
NSDictionary *CSGroupChatMemberDelta(NSDictionary *previous,NSDictionary *current,NSString *account) {
    if(!Snapshot(current) || !CSGroupChatValidMemberID(account))return nil;
    NSSet *next=[NSSet setWithArray:current[@"members"]];
    if(previous){
        if(!Snapshot(previous) || ![previous[@"roomID"] isEqual:current[@"roomID"]] || [current[@"version"] unsignedLongLongValue]<[previous[@"version"] unsignedLongLongValue])return nil;
        if([current[@"version"] isEqual:previous[@"version"]] && ![[NSSet setWithArray:previous[@"members"]] isEqual:next])return nil;
    }
    if(![next containsObject:account] || [current[@"unavailable"] boolValue])return @{@"invalidate":@YES,@"joined":@[],@"left":@[]};
    if(!previous || [previous[@"unavailable"] boolValue])return @{@"baseline":@YES,@"joined":@[],@"left":@[]};
    if(!Snapshot(previous) || ![previous[@"roomID"] isEqual:current[@"roomID"]])return nil;
    unsigned long long oldVersion=[previous[@"version"] unsignedLongLongValue],newVersion=[current[@"version"] unsignedLongLongValue];
    if(newVersion<oldVersion)return nil;
    NSSet *old=[NSSet setWithArray:previous[@"members"]];
    if(newVersion==oldVersion && ![old isEqual:next])return nil;
    if(![old containsObject:account])return @{@"baseline":@YES,@"joined":@[],@"left":@[]};
    NSMutableSet *joined=[next mutableCopy],*left=[old mutableCopy];[joined minusSet:old];[left minusSet:next];
    return @{@"joined":[joined.allObjects sortedArrayUsingSelector:@selector(compare:)],@"left":[left.allObjects sortedArrayUsingSelector:@selector(compare:)]};
}
BOOL CSGroupChatMayWelcome(NSDictionary *previous,NSDictionary *current,NSString *member,NSDate *now) {
    return CSGroupChatMayWelcomeAfterGap(previous,current,member,now,NO);
}
BOOL CSGroupChatMayWelcomeAfterGap(NSDictionary *previous,NSDictionary *current,NSString *member,NSDate *now,BOOL recovering) {
    if(!previous || ![current[@"members"] containsObject:member] || [previous[@"members"] containsObject:member] || ![current[@"active"] boolValue])return NO;
    NSDate *observed=current[@"observedAt"],*oldObserved=previous[@"observedAt"];
    if(![observed isKindOfClass:NSDate.class] || ![oldObserved isKindOfClass:NSDate.class] || [now timeIntervalSinceDate:observed]>120 || [observed timeIntervalSinceDate:now]>5)return NO;
    NSNumber *joined=current[@"joinTimes"][member];
    if([joined isKindOfClass:NSNumber.class] && joined.doubleValue>0){NSTimeInterval age=[now timeIntervalSince1970]-joined.doubleValue;return age>=-5 && (recovering || age<=120) && joined.doubleValue>=[oldObserved timeIntervalSince1970]-5;}
    // Both snapshots are verified in the same account/configuration session.
    // Without a server join time only the ordered full-list change is known.
    return [previous[@"active"] boolValue] && [observed timeIntervalSinceDate:oldObserved]>=0;
}
