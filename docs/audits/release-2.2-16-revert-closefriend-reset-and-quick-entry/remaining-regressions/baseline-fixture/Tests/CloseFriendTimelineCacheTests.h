// The device reports show WCDataItem hashing archives the model and reads hooked
// interaction getters. Ordinary NSObject fixtures never exercised that contract.
static NSUInteger NativeItemHashCalls,NativeItemEqualityCalls;
static BOOL RejectNativeItemCallbacks;
@interface ArchivedTimelineItem : WCDataItem <NSCoding> @end
@implementation ArchivedTimelineItem
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.likeUsers forKey:@"likes"];
    [coder encodeObject:self.commentUsers forKey:@"comments"];
}
- (instancetype)initWithCoder:(__unused NSCoder *)coder {return [super init];}
- (NSUInteger)hash {
    NativeItemHashCalls++;
    // Fail before Foundation deadlocks so the old-code regression is bounded.
    if(RejectNativeItemCallbacks) @throw [NSException exceptionWithName:@"NativeCacheReentry" reason:@"cache invoked native model hash, which archives hooked getters" userInfo:nil];
    return [NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:NO error:NULL].hash;
}
- (BOOL)isEqual:(id)other {
    NativeItemEqualityCalls++;
    if(RejectNativeItemCallbacks) @throw [NSException exceptionWithName:@"NativeCacheReentry" reason:@"cache compared native model contents" userInfo:nil];
    return self==other;
}
@end
static int TestTimelineCacheNativeCallbacks(void) {
    Policy(NO,220);
    NSDictionary *ordinary=@{@"username":@"alice"},*hidden=@{@"username":@"secret"};
    ArchivedTimelineItem *item=[ArchivedTimelineItem new];item.username=@"alice";item.itemID=@"same-id";
    item.likeUsers=@[ordinary,hidden];item.commentUsers=@[hidden,ordinary];
    WCFacade *facade=[WCFacade new];facade.source=@[item];
    WCTimeLineViewController *page=[WCTimeLineViewController new];
    NativeItemHashCalls=0;NativeItemEqualityCalls=0;RejectNativeItemCallbacks=YES;
    CSCFTimelineScope *previous=Enter(page,nil);
    @try {
        Check([facade countOfTimelineDataItem]==1 && item.likeCount==1 && item.commentCount==1);
        NSArray *likes=item.likeUsers,*comments=item.commentUsers;
        for(NSUInteger i=0;i<50;i++)Check(item.likeUsers==likes && item.commentUsers==comments);
    } @catch(NSException *exception) {
        fprintf(stderr,"FAIL native timeline cache: %s\n",exception.reason.UTF8String);return 1;
    } @finally {Leave(previous);}
    Check(!NativeItemHashCalls && !NativeItemEqualityCalls);
    // A refreshed model with the same native itemID is a different cache owner.
    ArchivedTimelineItem *replacement=[ArchivedTimelineItem new];replacement.username=@"alice";replacement.itemID=item.itemID;
    replacement.likeUsers=@[hidden];replacement.commentUsers=@[ordinary,ordinary];facade.source=@[replacement];
    previous=Enter(page,nil);
    @try {
        Check([facade getTimelineDataItemOfIndex:0]==replacement);
        Check(replacement.likeCount==0 && replacement.commentCount==2);
        Check(!NativeItemHashCalls && !NativeItemEqualityCalls);
        // Native code may independently archive a model; filtered getter reads
        // must not ask NSCache to hash that model again.
        RejectNativeItemCallbacks=NO;(void)replacement.hash;
        Check(NativeItemHashCalls==1);
    } @catch(NSException *exception) {
        fprintf(stderr,"FAIL refreshed timeline cache: %s\n",exception.reason.UTF8String);return 1;
    } @finally {Leave(previous);RejectNativeItemCallbacks=NO;}
    Check(item.likeCount==2 && replacement.likeCount==1 && replacement.commentCount==2);
    __weak ArchivedTimelineItem *released=nil;
    @autoreleasepool {
        ArchivedTimelineItem *temporary=[ArchivedTimelineItem new];temporary.likeUsers=@[ordinary];released=temporary;
        previous=Enter(nil,temporary);Check(temporary.likeCount==1);Leave(previous);
    }
    Check(!released); // Bounded cached interaction arrays do not retain their native owner.
    for(NSString *notification in @[CSCloseFriendPolicyDidChangeNotification,@"CSBackupAccountChanged"]) {
        __weak id releasedInteraction=nil;
        @autoreleasepool {
            NSMutableDictionary *interaction=[NSMutableDictionary dictionaryWithObject:@"alice" forKey:@"username"];
            releasedInteraction=interaction;item.likeUsers=@[interaction];
            previous=Enter(nil,item);Check(item.likeCount==1);Leave(previous);item.likeUsers=@[];
        }
        Check(releasedInteraction!=nil); // Only the cached projection now owns this interaction.
        [NSNotificationCenter.defaultCenter postNotificationName:notification object:nil];
        Check(!releasedInteraction && !State(page).posts);
    }
    puts("Timeline native cache: model hashing/equality bypassed, repeat reads and same-ID replacement preserved, native archive reentry completed; policy/account events release cached data");
    return 0;
}
