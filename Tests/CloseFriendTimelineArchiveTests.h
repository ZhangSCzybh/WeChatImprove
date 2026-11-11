// safeRemoveObjectAtIndex: belongs to the native mutable-array category. An
// immutable singleton must fail this consumer instead of receiving a catch-all
// NSArray category that masks the broken model contract.
@interface NSMutableArray (CSCFTimelineArchiveNativeArray)
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;
@end
@implementation NSMutableArray (CSCFTimelineArchiveNativeArray)
- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if(index<self.count)[self removeObjectAtIndex:index];
}
@end

// Write the old projected representation while decoding as the real model.
// This models an existing buffer; it deliberately bypasses its new encoder.
@interface CSCFLegacyTimelineArchiveItem : NSObject <NSCoding>
@property(nonatomic,strong) NSArray *likes,*comments;
@end
@implementation CSCFLegacyTimelineArchiveItem
- (Class)classForKeyedArchiver {return WCDataItem.class;}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.likes forKey:@"likes"];
    [coder encodeObject:self.comments forKey:@"comments"];
}
- (instancetype)initWithCoder:(__unused NSCoder *)coder {return [super init];}
@end

@interface CSCFTimelineRecordingEncoder : NSCoder
@property(nonatomic,strong) NSArray *likes,*comments;
@property(nonatomic,strong) id observedScope;
@property(nonatomic) BOOL recordedScope,changedScope;
@property(nonatomic) NSInteger likesCount,commentsCount;
@end
@implementation CSCFTimelineRecordingEncoder
- (void)recordScope {
    if(!self.recordedScope) {self.observedScope=Scope;self.recordedScope=YES;}
    else if(self.observedScope!=Scope)self.changedScope=YES;
}
- (void)encodeObject:(id)object forKey:(NSString *)key {
    [self recordScope];
    if([key isEqual:@"likes"])self.likes=object;
    if([key isEqual:@"comments"])self.comments=object;
}
- (void)encodeInteger:(NSInteger)value forKey:(NSString *)key {
    [self recordScope];
    if([key isEqual:@"likeCount"])self.likesCount=value;
    if([key isEqual:@"commentCount"])self.commentsCount=value;
}
@end

@interface CSCFTimelineThrowingEncoder : NSCoder
@property(nonatomic,strong) NSArray *likes,*comments;
@property(nonatomic) BOOL sawScope;
@end
@implementation CSCFTimelineThrowingEncoder
- (void)encodeObject:(id)object forKey:(NSString *)key {
    self.sawScope|=Scope!=nil;
    if([key isEqual:@"likes"])self.likes=object;
    if([key isEqual:@"comments"]) {
        self.comments=object;
        @throw [NSException exceptionWithName:@"TimelineNativeArchiveFailure" reason:@"native encoder failed" userInfo:nil];
    }
}
@end

static id DecodeTimelineArchive(NSData *data,NSError **error) {
    NSKeyedUnarchiver *decoder=[[NSKeyedUnarchiver alloc]initForReadingFromData:data error:error];
    if(!decoder)return nil;
    decoder.requiresSecureCoding=NO;
    id result=[decoder decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [decoder finishDecoding];
    return result;
}

static int TestTimelineArchiveBoundaries(void) {
    Policy(NO,230);
    NSDictionary *ordinary=@{@"username":@"alice",@"id":@"ordinary"};
    NSDictionary *hidden=@{@"username":@"secret",@"id":@"hidden"};
    NSDictionary *reply=@{@"username":@"alice",@"refUserName":@"secret",@"id":@"reply"};
    NSMutableArray *likes=[@[ordinary,hidden] mutableCopy];
    NSMutableArray *comments=[@[hidden,reply,ordinary] mutableCopy];
    WCDataItem *item=[WCDataItem new];item.username=@"alice";item.itemID=@"archive-item";
    item.likeUsers=likes;item.commentUsers=comments;
    WCFacade *facade=[WCFacade new];facade.source=@[item];
    WCTimeLineViewController *page=[WCTimeLineViewController new];
    NSData *data=nil;
    WCDataItem *restored=nil;
    CSCFTimelineScope *previous=Enter(page,nil);
    @try {
        Check([facade countOfTimelineDataItem]==1 && item.likeCount==1 && item.commentCount==1);
        CSCFTimelineScope *active=Scope;Check(active!=nil);
        NSArray *visibleLikes=item.likeUsers,*visibleComments=item.commentUsers;
        Check([visibleLikes isEqual:@[ordinary]] && [visibleComments isEqual:@[ordinary]]);
        NSError *error=nil;
        data=[NSKeyedArchiver archivedDataWithRootObject:item requiringSecureCoding:NO error:&error];
        Check(data.length>0 && !error);
        Check(Scope==active && item.likeUsers==visibleLikes && item.commentUsers==visibleComments);
        Check(item.likeCount==1 && item.commentCount==1);
        // Inspect the buffer before the repair factory: the encoder itself
        // must retain full data and native mutability, including hidden users.
        WCDataItem *nativeBuffer=DecodeTimelineArchive(data,&error);Check(nativeBuffer && !error);
        Check(nativeBuffer.likeCount==2 && nativeBuffer.commentCount==3);
        Check(nativeBuffer.archivedLikeCount==2 && nativeBuffer.archivedCommentCount==3);
        Check([nativeBuffer.likeUsers isKindOfClass:NSMutableArray.class] && [nativeBuffer.commentUsers isKindOfClass:NSMutableArray.class]);
        Check([nativeBuffer.likeUsers isEqual:likes] && [nativeBuffer.commentUsers isEqual:comments]);
        restored=[WCDataItem fromNSCodingBuffer:data];Check(restored!=nil);
        Check(Scope==active && item.likeUsers==visibleLikes && item.commentUsers==visibleComments);
        // A native failure must propagate while the UI scope is restored.
        CSCFTimelineThrowingEncoder *throwing=[CSCFTimelineThrowingEncoder new];
        BOOL caught=NO;
        @try {[item encodeWithCoder:throwing];}
        @catch(NSException *exception) {caught=[exception.name isEqual:@"TimelineNativeArchiveFailure"];}
        Check(caught && !throwing.sawScope && throwing.likes==likes && throwing.comments==comments);
        Check(Scope==active && item.likeUsers==visibleLikes && item.commentUsers==visibleComments);

        // A background encoder must not read or clear the main-thread UI
        // Scope. Its native getters already bypass UI projection off-main.
        CSCFTimelineRecordingEncoder *background=[CSCFTimelineRecordingEncoder new];
        __block NSData *backgroundData=nil;__block NSError *backgroundError=nil;
        dispatch_group_t group=dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
            [item encodeWithCoder:background];
            backgroundData=[NSKeyedArchiver archivedDataWithRootObject:item requiringSecureCoding:NO error:&backgroundError];
        });
        Check(dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0);
        Check(background.recordedScope && background.observedScope==active && !background.changedScope);
        Check(background.likes==likes && background.comments==comments && background.likesCount==2 && background.commentsCount==3);
        Check(backgroundData.length>0 && !backgroundError && Scope==active);
        WCDataItem *backgroundBuffer=DecodeTimelineArchive(backgroundData,&error);Check(backgroundBuffer && !error);
        Check(backgroundBuffer.archivedLikeCount==2 && backgroundBuffer.archivedCommentCount==3);
        Check([backgroundBuffer.likeUsers isEqual:likes] && [backgroundBuffer.commentUsers isEqual:comments]);
        Check(item.likeUsers==visibleLikes && item.commentUsers==visibleComments);

        // The original factory's nil/exception behavior is not converted into
        // fabricated models or swallowed; the surrounding UI Scope survives.
        TimelineFactoryThrows=YES;caught=NO;
        @try {[WCDataItem fromNSCodingBuffer:data];}
        @catch(NSException *exception) {caught=[exception.name isEqual:@"TimelineNativeDecodeFailure"];}
        @finally {TimelineFactoryThrows=NO;}
        Check(caught && Scope==active);
        TimelineFactoryReturnsNil=YES;WCDataItem *missing=nil;
        @try {missing=[WCDataItem fromNSCodingBuffer:data];}
        @finally {TimelineFactoryReturnsNil=NO;}
        Check(!missing && Scope==active);
    } @finally {Leave(previous);}
    Check(!Scope && item.likeUsers==likes && item.commentUsers==comments);
    CSCFTimelineRecordingEncoder *unscoped=[CSCFTimelineRecordingEncoder new];
    [item encodeWithCoder:unscoped];
    Check(unscoped.recordedScope && !unscoped.observedScope && !unscoped.changedScope && !Scope);
    Check(unscoped.likes==likes && unscoped.comments==comments && unscoped.likesCount==2 && unscoped.commentsCount==3);
    NSError *error=nil;
    Check([restored isKindOfClass:WCDataItem.class]);
    Check([restored.likeUsers isKindOfClass:NSMutableArray.class] && [restored.commentUsers isKindOfClass:NSMutableArray.class]);
    Check(restored.likeUsers==TimelineFactoryDecodedLikes && restored.commentUsers==TimelineFactoryDecodedComments);
    Check(restored.likeCount==2 && restored.commentCount==3);
    Check([restored.likeUsers isEqual:likes] && [restored.commentUsers isEqual:comments]);
    Check(restored.likeUsers[0]==restored.commentUsers[2] && restored.likeUsers[1]==restored.commentUsers[0]);
    previous=Enter(nil,restored);
    @try {Check(restored.likeCount==1 && restored.commentCount==1 && [restored.commentUsers isEqual:@[ordinary]]);}
    @finally {Leave(previous);}
    Check(restored.likeCount==2 && restored.commentCount==3);

    // Old buffers may contain immutable singleton arrays, matching the device
    // failure. Decode through native setters, then exercise its exact consumer.
    CSCFLegacyTimelineArchiveItem *legacy=[CSCFLegacyTimelineArchiveItem new];
    legacy.likes=@[hidden,ordinary,reply];legacy.comments=@[ordinary];
    Check(![legacy.comments isKindOfClass:NSMutableArray.class]);
    data=[NSKeyedArchiver archivedDataWithRootObject:legacy requiringSecureCoding:NO error:&error];
    Check(data.length>0 && !error);
    // The repair is deliberately scoped to the native advertised-item factory;
    // ordinary decoding retains its original representation.
    WCDataItem *direct=DecodeTimelineArchive(data,&error);Check(direct && !error);
    Check(![direct.likeUsers isKindOfClass:NSMutableArray.class] && ![direct.commentUsers isKindOfClass:NSMutableArray.class]);
    Check(![direct.commentUsers respondsToSelector:@selector(safeRemoveObjectAtIndex:)]);
    WCDataItem *recovered=[WCDataItem fromNSCodingBuffer:data];Check(recovered!=nil);
    Check([recovered.likeUsers isKindOfClass:NSMutableArray.class] && [recovered.commentUsers isKindOfClass:NSMutableArray.class]);
    Check([recovered.likeUsers isEqual:legacy.likes] && [recovered.commentUsers isEqual:legacy.comments]);
    Check(recovered.likeUsers!=TimelineFactoryDecodedLikes && recovered.commentUsers!=TimelineFactoryDecodedComments);
    Check(recovered.likeUsers[0]==TimelineFactoryDecodedLikes[0] && recovered.likeUsers[1]==TimelineFactoryDecodedLikes[1] && recovered.likeUsers[2]==TimelineFactoryDecodedLikes[2]);
    Check(recovered.commentUsers[0]==TimelineFactoryDecodedComments[0]);
    NSMutableArray *nativeComments=(NSMutableArray *)recovered.commentUsers;
    Check([nativeComments respondsToSelector:@selector(safeRemoveObjectAtIndex:)]);
    [nativeComments safeRemoveObjectAtIndex:0];
    Check(recovered.commentUsers==nativeComments && recovered.commentCount==0);
    [nativeComments safeRemoveObjectAtIndex:0];Check(recovered.commentCount==0);

    legacy.likes=@[];legacy.comments=@[];
    data=[NSKeyedArchiver archivedDataWithRootObject:legacy requiringSecureCoding:NO error:&error];
    Check(data.length>0 && !error);
    WCDataItem *emptyArrays=[WCDataItem fromNSCodingBuffer:data];Check(emptyArrays!=nil);
    Check([emptyArrays.likeUsers isKindOfClass:NSMutableArray.class] && [emptyArrays.commentUsers isKindOfClass:NSMutableArray.class]);
    Check(emptyArrays.likeUsers.count==0 && emptyArrays.commentUsers.count==0);
    [(NSMutableArray *)emptyArrays.commentUsers safeRemoveObjectAtIndex:0];Check(emptyArrays.commentCount==0);

    WCDataItem *emptySource=[WCDataItem new];
    data=[NSKeyedArchiver archivedDataWithRootObject:emptySource requiringSecureCoding:NO error:&error];
    Check(data.length>0 && !error);
    WCDataItem *empty=[WCDataItem fromNSCodingBuffer:data];Check(empty!=nil);
    Check(empty.likeUsers==nil && empty.commentUsers==nil);
    Check(TimelineFactoryDecodedLikes==nil && TimelineFactoryDecodedComments==nil);
    puts("Timeline archive: real NSCoding preserves full arrays/counts and UI Scope on success/failure, nil Scope and background encoding remain unchanged; legacy singleton/empty decode supports native safeRemove with model writeback, preserving mutable identity, nil, element identity/order and native decode exceptions; direct unarchive stays native");
    return 0;
}
