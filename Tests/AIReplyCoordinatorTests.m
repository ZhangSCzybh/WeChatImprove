#import <Foundation/Foundation.h>
#import "CSAIReplyCoordinator.h"
#define CHECK(...) do { if(!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while(0)

@interface FakeOperation : NSObject <CSAICancellable>
@property(nonatomic,copy) CSAICompletion completion;
@property(nonatomic,copy) NSArray *messages;
@property(nonatomic) BOOL cancelled;
@property(nonatomic) BOOL callbackOnCancel;
@end
@implementation FakeOperation
- (void)cancel {self.cancelled=YES;if(self.callbackOnCancel)self.completion(nil,CSAIError(NSURLErrorCancelled,@"secret cancellation body"));}
@end
@interface FakeClient : NSObject <CSAIGenerating>
@property(nonatomic,strong) NSMutableArray<FakeOperation *> *operations;
@property(nonatomic) BOOL inlineCompletion;
@end
@implementation FakeClient
- (instancetype)init {if((self=[super init]))_operations=[NSMutableArray array];return self;}
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)configuration apiKey:(NSString *)apiKey messages:(NSArray<NSDictionary *> *)messages completion:(CSAICompletion)completion {
    CHECK(NSThread.isMainThread);CHECK([configuration[@"model"] isEqual:@"fake-model"]);CHECK([apiKey isEqual:@"secret-key"]);
    FakeOperation *operation=[FakeOperation new];operation.messages=messages;operation.completion=completion;[self.operations addObject:operation];
    if(self.inlineCompletion)completion(@"inline reply",nil);
    return operation;
}
@end
@interface FakeImages : NSObject <CSAIImagePreparing>
@property NSMutableArray<FakeOperation *> *operations;
@property NSMutableArray<NSDictionary *> *events;
@property BOOL inlineCompletion;
@end
@implementation FakeImages
- (instancetype)init{if((self=[super init])){_operations=[NSMutableArray array];_events=[NSMutableArray array];}return self;}
- (id<CSAICancellable>)prepareImageForEvent:(NSDictionary *)event completion:(CSAICompletion)completion{
    CHECK(NSThread.isMainThread);BOOL (^valid)(void)=event[@"imageStillValid"];CHECK(valid && valid());
    FakeOperation *task=[FakeOperation new];task.completion=completion;[self.events addObject:event];[self.operations addObject:task];
    if(self.inlineCompletion)completion(@"data:image/jpeg;base64,AQ==",nil);
    return task;
}
@end
@interface FakeDelegate : NSObject <CSAIReplyCoordinatorDelegate>
@property(nonatomic) BOOL allowed;
@property(nonatomic) BOOL hasKey;
@property(nonatomic) NSUInteger attempts;
@property(nonatomic) NSUInteger sends;
@property(nonatomic,copy) NSString *result;
@property(nonatomic,copy) void (^beforeBoundary)(void);
@property(nonatomic,copy) void (^beforeCredential)(void);
@property(nonatomic,copy) void (^beforeAllows)(void);
@property(nonatomic,copy) BOOL (^lastValid)(void);
@property(nonatomic,strong) NSMutableArray *conversations;
@end
@implementation FakeDelegate
- (instancetype)init {if((self=[super init])){_allowed=YES;_hasKey=YES;_result=@"submitted";_conversations=[NSMutableArray array];}return self;}
- (BOOL)coordinator:(CSAIReplyCoordinator *)coordinator allowsConversation:(NSString *)conversation {(void)coordinator;(void)conversation;CHECK(NSThread.isMainThread);if(self.beforeAllows)self.beforeAllows();return self.allowed;}
- (NSString *)credentialForCoordinator:(CSAIReplyCoordinator *)coordinator error:(NSError **)error {(void)coordinator;(void)error;if(self.beforeCredential)self.beforeCredential();return self.hasKey?@"secret-key":nil;}
- (NSString *)coordinator:(CSAIReplyCoordinator *)coordinator submitText:(NSString *)text conversation:(NSString *)conversation valid:(BOOL (^)(void))valid {
    (void)coordinator;CHECK(text.length && text.length<=4000);self.attempts++;self.lastValid=valid;
    if(self.beforeBoundary)self.beforeBoundary();
    if(!valid())return @"failed";
    self.sends++;[self.conversations addObject:conversation];return self.result;
}
@end
@interface ClaimFailureStore : CSAIReplyStore
@property(nonatomic) BOOL failClaims;
@property(nonatomic) BOOL deferClaims;
@property(nonatomic) BOOL useAsyncStore;
@property(nonatomic,strong) NSMutableArray<NSDictionary *> *claimRequests;
- (void)completeNextClaim;
@end
@implementation ClaimFailureStore
- (BOOL)claimMessageIDs:(NSArray<NSString *> *)identifiers error:(NSError **)error {return self.failClaims?NO:[super claimMessageIDs:identifiers error:error];}
- (void)claimMessageIDs:(NSArray<NSString *> *)identifiers completion:(CSAIReplyStoreCompletion)completion {
    if(self.useAsyncStore){[super claimMessageIDs:identifiers completion:completion];return;}
    if(self.deferClaims){
        if(!self.claimRequests)self.claimRequests=[NSMutableArray array];
        [self.claimRequests addObject:@{@"ids":[identifiers copy],@"completion":[completion copy]}];return;
    }
    NSError *error=nil;BOOL success=[self claimMessageIDs:identifiers error:&error];completion(success,error);
}
- (void)claimMessageAliases:(NSArray<NSString *> *)identifiers completion:(CSAIReplyStoreCompletion)completion {
    if(self.useAsyncStore){[super claimMessageAliases:identifiers completion:completion];return;}
    [self claimMessageIDs:identifiers completion:completion];
}
- (void)completeNextClaim {
    CHECK(self.claimRequests.count);NSDictionary *request=self.claimRequests.firstObject;[self.claimRequests removeObjectAtIndex:0];
    CSAIReplyStoreCompletion completion=request[@"completion"];NSError *error=nil;
    BOOL success=[self claimMessageIDs:request[@"ids"] error:&error];completion(success,error);
}
// Most fixtures isolate coordinator state transitions from disk scheduling.
// Dedicated deferred-claim cases below exercise the asynchronous boundary.
- (void)appendHistory:(NSDictionary *)record completion:(CSAIReplyStoreCompletion)completion {
    if(self.useAsyncStore){[super appendHistory:record completion:completion];return;}
    NSError *error=nil;BOOL success=[self appendHistory:record error:&error];if(completion)completion(success,error);
}
- (void)saveConfiguration:(NSDictionary *)configuration expectedConfiguration:(NSDictionary *)expected completion:(CSAIReplyStoreCompletion)completion {
    if(self.useAsyncStore){[super saveConfiguration:configuration expectedConfiguration:expected completion:completion];return;}
    NSError *error=nil;BOOL success=[expected isEqual:self.configuration] && [self saveConfiguration:configuration error:&error];
    if(completion)completion(success,error);
}
@end
@interface Fixture : NSObject
@property(nonatomic,strong) NSURL *root;
@property(nonatomic,strong) ClaimFailureStore *store;
@property(nonatomic,strong) CSAIReplyCoordinator *coordinator;
@property(nonatomic,strong) FakeClient *client;
@property(nonatomic,strong) FakeDelegate *delegate;
@property(nonatomic) NSTimeInterval clock;
- (NSMutableDictionary *)event:(NSString *)conversation sender:(NSString *)sender identity:(NSString *)identity;
- (void)advance:(NSTimeInterval)seconds;
- (void)save:(void (^)(NSMutableDictionary *))mutation;
@end
@implementation Fixture
- (instancetype)init {
    if((self=[super init])){
        _root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
        _store=[[ClaimFailureStore alloc]initWithURL:CSAIReplyFileURL(_root,@"me") account:@"me"];CHECK([_store load]);
        NSMutableDictionary *configuration=[_store.configuration mutableCopy];configuration[@"enabled"]=@YES;configuration[@"endpoint"]=@"https://example.invalid/chat";
        configuration[@"model"]=@"fake-model";configuration[@"credentialRevision"]=@"revision";configuration[@"verifiedConnection"]=CSAIConnectionIdentifier(configuration);
        configuration[@"presets"]=@[@{@"id":@"default",@"name":@"Default",@"prompt":@"default prompt"},@{@"id":@"custom",@"name":@"Custom",@"prompt":@"custom prompt"}];
        NSMutableDictionary *conversations=[NSMutableDictionary dictionary];
        for(NSString *name in @[@"c",@"d",@"e",@"room@chatroom"])conversations[name]=@{@"enabled":@YES,@"presetID":@""};
        for(NSUInteger i=0;i<30;i++)conversations[[NSString stringWithFormat:@"queue%lu",(unsigned long)i]]=@{@"enabled":@YES,@"presetID":@""};
        configuration[@"conversations"]=conversations;CHECK([_store saveConfiguration:configuration error:NULL]);
        _clock=1000;_client=[FakeClient new];_delegate=[FakeDelegate new];
        _coordinator=[[CSAIReplyCoordinator alloc]initWithStore:_store client:_client];_coordinator.delegate=_delegate;
        __weak Fixture *weakSelf=self;_coordinator.now=^{return weakSelf.clock;};[_coordinator configurationDidChange];
    }return self;
}
- (void)dealloc {[_coordinator cancelAll];[[NSFileManager defaultManager]removeItemAtURL:_root error:NULL];}
- (NSMutableDictionary *)event:(NSString *)conversation sender:(NSString *)sender identity:(NSString *)identity {
    BOOL group=[conversation hasSuffix:@"@chatroom"];
    return [@{@"account":@"me",@"conversation":conversation,@"sender":sender,@"identifiers":@[identity?:NSUUID.UUID.UUIDString],@"text":@"private input body",@"type":@1,@"group":@(group),@"mentioned":@(group),@"atAll":@NO,@"created":@(self.clock),@"live":@YES} mutableCopy];
}
- (void)advance:(NSTimeInterval)seconds {self.clock+=seconds;[self.coordinator processPending];}
- (void)save:(void (^)(NSMutableDictionary *))mutation {NSMutableDictionary *configuration=[self.store.configuration mutableCopy];mutation(configuration);CHECK([self.store saveConfiguration:configuration error:NULL]);[self.coordinator configurationDidChange];}
@end
static void Receive(Fixture *f,NSString *conversation,NSString *sender,NSString *identity) {[f.coordinator receiveEvent:[f event:conversation sender:sender identity:identity]];}
static void Complete(Fixture *f,NSUInteger index,NSString *text,NSError *error) {f.client.operations[index].completion(text,error);}
static NSString *LastInput(FakeOperation *operation) {return [operation.messages lastObject][@"content"];}
static void Filters(void) {
    NSArray *mutations=@[@{@"account":@"other"},@{@"sender":@"me"},@{@"type":@49},@{@"live":@NO},@{@"text":@""},@{@"text":@" \n "},@{@"created":@999},@{@"created":@1031},@{@"created":@(NAN)},@{@"identifiers":@[]},@{@"identifiers":@[@"same",@"same"]},@{@"group":@YES,@"mentioned":@NO},@{@"group":@YES,@"mentioned":@YES,@"atAll":@YES}];
    Fixture *f=[Fixture new];
    for(NSDictionary *mutation in mutations){NSMutableDictionary *event=[f event:@"c" sender:@"member" identity:nil];[event addEntriesFromDictionary:mutation];[f.coordinator receiveEvent:event];}
    [f.coordinator receiveEvent:(id)@"malformed"];
    [f advance:3];CHECK(f.client.operations.count==0);CHECK(f.delegate.sends==0);CHECK(f.coordinator.pendingCount==0);
    f.clock+=200;NSMutableDictionary *old=[f event:@"c" sender:@"member" identity:nil];old[@"created"]=@(f.clock-121);[f.coordinator receiveEvent:old];CHECK(f.coordinator.pendingCount==0);
    for(NSString *field in @[@"enabled",@"verifiedConnection",@"credentialRevision",@"endpoint",@"model"]){
        Fixture *g=[Fixture new];[g save:^(NSMutableDictionary *c){c[field]=[field isEqual:@"enabled"]?(id)@NO:@"";}];Receive(g,@"c",@"member",nil);[g advance:3];CHECK(!g.client.operations.count);
    }
    Fixture *g=[Fixture new];[g save:^(NSMutableDictionary *c){c[@"verifiedConnection"]=@"nonempty-but-stale";}];Receive(g,@"c",@"member",nil);[g advance:3];CHECK(!g.client.operations.count);
    g=[Fixture new];[g save:^(NSMutableDictionary *c){NSMutableDictionary *conversations=[c[@"conversations"] mutableCopy];conversations[@"c"]=@{@"enabled":@NO,@"presetID":@""};c[@"conversations"]=conversations;}];Receive(g,@"c",@"member",nil);[g advance:3];CHECK(!g.client.operations.count);
    g=[Fixture new];g.delegate.allowed=NO;Receive(g,@"c",@"member",nil);[g advance:3];CHECK(!g.client.operations.count);
    g=[Fixture new];g.delegate.hasKey=NO;Receive(g,@"c",@"member",nil);[g advance:3];CHECK(!g.client.operations.count && !g.coordinator.activeCount);
    g=[Fixture new];Receive(g,@"room@chatroom",@"member",nil);[g advance:2];CHECK(g.client.operations.count==1);Complete(g,0,@"reply",nil);CHECK(g.delegate.sends==1);
}
static void GroupUnmentioned(void) {
    Fixture *f=[Fixture new];NSMutableDictionary *event=[f event:@"room@chatroom" sender:@"member" identity:@"legacy-unmentioned"];event[@"mentioned"]=@NO;
    [f.coordinator receiveEvent:event];[f advance:2];CHECK(!f.client.operations.count);CHECK(![f.store hasHandledMessageID:@"legacy-unmentioned"]);
    [f save:^(NSMutableDictionary *c){NSMutableDictionary *items=[c[@"conversations"] mutableCopy];items[@"room@chatroom"]=@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES};items[@"other@chatroom"]=@{@"enabled":@YES,@"presetID":@""};c[@"conversations"]=items;}];
    event=[f event:@"room@chatroom" sender:@"member" identity:@"unmentioned"];event[@"mentioned"]=@NO;[f.coordinator receiveEvent:event];CHECK(f.coordinator.pendingCount==1);
    [f.coordinator receiveEvent:event];CHECK(f.coordinator.pendingCount==1);
    NSMutableDictionary *other=[f event:@"other@chatroom" sender:@"member" identity:@"other-unmentioned"];other[@"mentioned"]=@NO;[f.coordinator receiveEvent:other];CHECK(![f.store hasHandledMessageID:@"other-unmentioned"]);
    NSMutableDictionary *all=[f event:@"room@chatroom" sender:@"member" identity:@"at-all"];all[@"atAll"]=@YES;[f.coordinator receiveEvent:all];CHECK(![f.store hasHandledMessageID:@"at-all"]);
    [f advance:2];CHECK(f.client.operations.count==1);Complete(f,0,@"unmentioned reply",nil);CHECK(f.delegate.sends==1 && [f.delegate.conversations.lastObject isEqual:@"room@chatroom"]);
    // Private messages and individually mentioned messages in another group keep working.
    Receive(f,@"c",@"friend",nil);Receive(f,@"other@chatroom",@"member",nil);[f advance:2];CHECK(f.client.operations.count==3);Complete(f,1,@"private reply",nil);Complete(f,2,@"mentioned reply",nil);CHECK(f.delegate.sends==3);
    event=[f event:@"room@chatroom" sender:@"member" identity:@"cancel-active"];event[@"mentioned"]=@NO;[f.coordinator receiveEvent:event];[f advance:2];CHECK(f.coordinator.activeCount==1);
    event=[f event:@"room@chatroom" sender:@"member" identity:@"cancel-pending"];event[@"mentioned"]=@NO;[f.coordinator receiveEvent:event];CHECK(f.coordinator.pendingCount==1);
    [f save:^(NSMutableDictionary *c){NSMutableDictionary *items=[c[@"conversations"] mutableCopy];NSMutableDictionary *room=[items[@"room@chatroom"] mutableCopy];room[@"allowUnmentioned"]=@NO;items[@"room@chatroom"]=room;c[@"conversations"]=items;}];
    CHECK(f.client.operations[3].cancelled && !f.coordinator.activeCount && !f.coordinator.pendingCount);Complete(f,3,@"late unmentioned reply",nil);CHECK(f.delegate.sends==3);
    event=[f event:@"room@chatroom" sender:@"member" identity:@"disabled-unmentioned"];event[@"mentioned"]=@NO;[f.coordinator receiveEvent:event];[f advance:2];CHECK(f.client.operations.count==4);
    Receive(f,@"room@chatroom",@"member",nil);[f advance:2];CHECK(f.client.operations.count==5);Complete(f,4,@"mentioned after off",nil);CHECK(f.delegate.sends==4);
    // The opt-in never bypasses either the conversation or global enable switch.
    for(NSNumber *global in @[@NO,@YES]){
        Fixture *g=[Fixture new];[g save:^(NSMutableDictionary *c){c[@"enabled"]=global;NSMutableDictionary *items=[c[@"conversations"] mutableCopy];items[@"room@chatroom"]=@{@"enabled":@(!global.boolValue),@"presetID":@"",@"allowUnmentioned":@YES};c[@"conversations"]=items;}];
        event=[g event:@"room@chatroom" sender:@"member" identity:nil];event[@"mentioned"]=@NO;[g.coordinator receiveEvent:event];[g advance:2];CHECK(!g.client.operations.count);
    }
}
static void DedupeBatchingAndSerialization(void) {
    Fixture *f=[Fixture new];NSMutableDictionary *event=[f event:@"c" sender:@"member" identity:@"server"];
    event[@"identifiers"]=@[@"server",@"local"];event[@"text"]=@"first";[f.coordinator receiveEvent:event];
    CHECK([f.store hasHandledMessageID:@"server"] && [f.store hasHandledMessageID:@"local"]);
    event=[f event:@"c" sender:@"member" identity:nil];event[@"identifiers"]=@[@"server",@"new-local"];[f.coordinator receiveEvent:event];
    event=[f event:@"c" sender:@"member" identity:nil];event[@"identifiers"]=@[@"new-server",@"local"];[f.coordinator receiveEvent:event];
    CHECK(f.coordinator.pendingCount==1);[f advance:1];
    event=[f event:@"c" sender:@"member" identity:@"second"];event[@"text"]=@"second";[f.coordinator receiveEvent:event];[f advance:1];CHECK(!f.client.operations.count);[f advance:1];
    CHECK(f.client.operations.count==1);CHECK([LastInput(f.client.operations[0]) isEqual:@"first\nsecond"]);
    CHECK(f.client.operations[0].messages.count==2);CHECK([f.client.operations[0].messages[0][@"content"] isEqual:@"default prompt"]);
    // A second sender in the same group must wait behind the conversation's active request.
    Receive(f,@"room@chatroom",@"alice",@"alice-1");Receive(f,@"room@chatroom",@"bob",@"bob-1");Receive(f,@"d",@"d",@"d-1");[f advance:2];
    CHECK(f.coordinator.activeCount==2 && f.coordinator.pendingCount==2);CHECK(f.client.operations.count==2);
    Complete(f,0,@"reply-c",nil);CHECK(f.client.operations.count==3 && f.coordinator.activeCount==2);
    Complete(f,1,@"reply-alice",nil);CHECK(f.client.operations.count==4);CHECK(f.client.operations[3].messages.count==2);
    Complete(f,3,@"reply-bob",nil);Complete(f,2,@"reply-d",nil);CHECK(f.delegate.sends==4 && !f.coordinator.activeCount);
    CHECK(!f.delegate.lastValid());
    Receive(f,@"room@chatroom",@"alice",@"alice-2");[f advance:2];CHECK(f.client.operations.lastObject.messages.count==4);
    CHECK([f.client.operations.lastObject.messages[2][@"content"] isEqual:@"reply-alice"]);
    // Existing ledger survives a coordinator replacement (and aliases are durable, not memory-only).
    CSAIReplyStore *reload=[[CSAIReplyStore alloc]initWithURL:CSAIReplyFileURL(f.root,@"me") account:@"me"];CHECK([reload load]);CHECK([reload hasHandledMessageID:@"server"]);CHECK([reload hasHandledMessageID:@"local"]);
}
static void EvolvingAliasDurability(void) {
    for(NSString *result in @[@"submitted",@"unknown"]){
        Fixture *f=[Fixture new];f.delegate.result=result;
        NSMutableDictionary *event=[f event:@"c" sender:@"c" identity:@"local-only"];
        [f.coordinator receiveEvent:event];[f advance:2];Complete(f,0,@"reply",nil);
        CHECK(f.client.operations.count==1 && f.delegate.attempts==1 && f.delegate.sends==1);
        event[@"identifiers"]=@[@"server-later",@"local-only"];
        [f.coordinator receiveEvent:event];CHECK(!f.coordinator.pendingCount);
        CHECK([f.store hasHandledMessageID:@"server-later"]);
        // Independently read the file and reload the coordinator's store before the server-only replay.
        CSAIReplyStore *reload=[[CSAIReplyStore alloc]initWithURL:CSAIReplyFileURL(f.root,@"me") account:@"me"];
        CHECK([reload load] && [reload hasHandledMessageID:@"server-later"]);
        CHECK([f.store load]);event[@"identifiers"]=@[@"server-later"];
        [f.coordinator receiveEvent:event];[f advance:2];
        CHECK(f.client.operations.count==1 && f.delegate.attempts==1 && f.delegate.sends==1);
        CHECK(!f.coordinator.pendingCount && !f.coordinator.activeCount);
    }
    // Failure to persist an alias must cancel existing work before any later callback can send.
    Fixture *f=[Fixture new];f.delegate.result=@"unknown";
    NSMutableDictionary *event=[f event:@"c" sender:@"c" identity:@"local-only"];
    [f.coordinator receiveEvent:event];[f advance:2];Complete(f,0,@"unknown reply",nil);
    Receive(f,@"d",@"d",@"active-other");[f advance:2];Receive(f,@"e",@"e",@"pending-other");
    CHECK(f.coordinator.activeCount==1 && f.coordinator.pendingCount==1);
    f.store.failClaims=YES;event[@"identifiers"]=@[@"server-later",@"local-only"];
    [f.coordinator receiveEvent:event];CHECK(![f.store hasHandledMessageID:@"server-later"]);
    CHECK(f.client.operations[1].cancelled && !f.coordinator.activeCount && !f.coordinator.pendingCount);
    Complete(f,1,@"late reply",nil);event[@"identifiers"]=@[@"server-later"];event[@"created"]=@(f.clock);[f.coordinator receiveEvent:event];[f advance:2];
    CHECK(f.client.operations.count==2 && f.delegate.attempts==1 && f.delegate.sends==1);
    // Complete validation precedes any new alias claim, even when an earlier identity is known.
    f=[Fixture new];Receive(f,@"c",@"c",@"known");
    event=[f event:@"c" sender:@"c" identity:nil];event[@"identifiers"]=@[@"known",@"must-not-claim",@1];
    [f.coordinator receiveEvent:event];CHECK(![f.store hasHandledMessageID:@"must-not-claim"]);
}
static void CancellationAndBoundaries(void) {
    for(NSUInteger mode=0;mode<4;mode++){
        Fixture *f=[Fixture new];Receive(f,@"c",@"c",nil);Receive(f,@"d",@"d",nil);Receive(f,@"e",@"e",nil);[f advance:2];CHECK(f.coordinator.activeCount==2);
        f.client.operations[0].callbackOnCancel=YES;
        if(mode==0)[f save:^(NSMutableDictionary *c){c[@"enabled"]=@NO;}];
        if(mode==1)[f save:^(NSMutableDictionary *c){c[@"model"]=@"changed";}];
        if(mode==2){f.delegate.allowed=NO;[f.coordinator processPending];}
        if(mode==3)[f.coordinator cancelAll];
        Complete(f,0,@"late private reply",nil);Complete(f,1,@"late reply",nil);[f advance:5];CHECK(!f.delegate.sends);CHECK(!f.coordinator.activeCount && !f.coordinator.pendingCount);CHECK(f.client.operations[0].cancelled);
    }
    // Cancellation frees capacity immediately; an old callback cannot remove a new active batch.
    Fixture *f=[Fixture new];Receive(f,@"c",@"c",@"old");[f advance:2];[f.coordinator cancelAll];
    Receive(f,@"c",@"c",@"new");[f advance:2];CHECK(f.coordinator.activeCount==1);Complete(f,0,@"stale",nil);CHECK(f.coordinator.activeCount==1);Complete(f,1,@"new reply",nil);CHECK(f.delegate.sends==1);
    // Both the initial submission check and native boundary closure recheck privacy/configuration.
    f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];__weak Fixture *weak=f;
    f.delegate.beforeBoundary=^{weak.delegate.allowed=NO;};Complete(f,0,@"reply",nil);CHECK(f.delegate.attempts==1 && !f.delegate.sends);
    f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];weak=f;
    f.delegate.beforeBoundary=^{[weak.coordinator configurationDidChange];};Complete(f,0,@"reply",nil);CHECK(!f.delegate.sends && !f.store.history.count);
    f=[Fixture new];weak=f;f.delegate.beforeCredential=^{[weak.coordinator configurationDidChange];};Receive(f,@"c",@"c",nil);[f advance:2];CHECK(!f.client.operations.count && !f.coordinator.activeCount);
    // Changes saved without a manager notification still fail closed on the callback.
    f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];NSMutableDictionary *c=[f.store.configuration mutableCopy];c[@"enabled"]=@NO;CHECK([f.store saveConfiguration:c error:NULL]);Complete(f,0,@"late",nil);CHECK(!f.delegate.sends);
    f=[Fixture new];f.clock+=50;[f.coordinator configurationDidChange];NSMutableDictionary *old=[f event:@"c" sender:@"c" identity:nil];old[@"created"]=@(f.clock-1);[f.coordinator receiveEvent:old];[f advance:3];CHECK(!f.client.operations.count);
}
static void LimitsExpiryAndErrors(void) {
    Fixture *f=[Fixture new];
    for(NSUInteger i=0;i<21;i++){NSString *conversation=[NSString stringWithFormat:@"queue%lu",(unsigned long)i];Receive(f,conversation,conversation,nil);}
    CHECK(f.coordinator.pendingCount==20);[f advance:121];CHECK(!f.coordinator.pendingCount && !f.client.operations.count);CHECK(f.store.history.count==20);
    f=[Fixture new];Receive(f,@"c",@"c",nil);Receive(f,@"d",@"d",nil);Receive(f,@"e",@"e",nil);[f advance:2];[f advance:60];CHECK(f.client.operations[0].cancelled && f.client.operations[1].cancelled);CHECK(f.client.operations.count==3 && f.coordinator.activeCount==1);Complete(f,0,@"expired",nil);CHECK(!f.delegate.sends);
    f=[Fixture new];f.store.failClaims=YES;Receive(f,@"c",@"c",@"cannot-claim");[f advance:2];CHECK(!f.client.operations.count && !f.coordinator.pendingCount);
    f=[Fixture new];f.delegate.result=@"unknown";Receive(f,@"c",@"c",@"unknown");[f advance:2];Complete(f,0,@"reply",nil);Receive(f,@"c",@"c",@"unknown");[f advance:3];Complete(f,0,@"duplicate completion",nil);CHECK(f.client.operations.count==1 && f.delegate.sends==1);CHECK([f.store.history.lastObject[@"result"] isEqual:@"unknown"]);
    for(NSNumber *code in @[@401,@403,@429,@(NSURLErrorTimedOut)]){
        f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];Complete(f,0,nil,CSAIError(code.integerValue,@"RAW ERROR private input body secret-key"));
        CHECK(f.store.history.count==1);NSString *history=f.store.history.description;CHECK(![history containsString:@"RAW ERROR"] && ![history containsString:@"private input body"] && ![history containsString:@"secret-key"]);
        BOOL auth=code.integerValue==401 || code.integerValue==403;CHECK(([f.store.configuration[@"verifiedConnection"] length]==0)==auth);CHECK([f.store.configuration[@"enabled"] boolValue]);
        Receive(f,@"c",@"c",nil);[f advance:2];CHECK(f.client.operations.count==(auth?1:2));
    }
    for(NSString *reply in @[@"  ",[ @"x" stringByPaddingToLength:4001 withString:@"x" startingAtIndex:0]]){
        f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];Complete(f,0,reply,nil);CHECK(!f.delegate.sends && !f.coordinator.activeCount);
    }
    // Immediate callbacks must not leave stale tasks or consume capacity permanently.
    f=[Fixture new];f.client.inlineCompletion=YES;Receive(f,@"c",@"c",nil);Receive(f,@"d",@"d",nil);Receive(f,@"e",@"e",nil);[f advance:2];CHECK(f.delegate.sends==3 && f.client.operations.count==3 && !f.coordinator.activeCount && !f.coordinator.pendingCount);
}
static void ContextBudgetAndPreset(void) {
    Fixture *f=[Fixture new];[f save:^(NSMutableDictionary *c){NSMutableDictionary *conversations=[c[@"conversations"] mutableCopy];conversations[@"c"]=@{@"enabled":@YES,@"presetID":@"custom"};c[@"conversations"]=conversations;}];
    for(NSUInteger i=0;i<9;i++){
        NSMutableDictionary *event=[f event:@"c" sender:@"c" identity:nil];event[@"text"]=[@"u" stringByPaddingToLength:3000 withString:@"u" startingAtIndex:0];[f.coordinator receiveEvent:event];[f advance:2];
        FakeOperation *operation=f.client.operations.lastObject;CHECK(operation.messages.count<=11);CHECK([operation.messages[0][@"content"] isEqual:@"custom prompt"]);
        NSUInteger total=0;for(NSUInteger j=1;j<operation.messages.count;j++)total+=[operation.messages[j][@"content"] length];CHECK(total<=12000);
        Complete(f,i,[@"a" stringByPaddingToLength:2000 withString:@"a" startingAtIndex:0],nil);
    }
    CHECK([f.store.history.lastObject[@"preset"] isEqual:@"custom"]);
    [f.coordinator cancelAll];Receive(f,@"c",@"c",nil);[f advance:2];CHECK(f.client.operations.lastObject.messages.count==2);
    f=[Fixture new];for(NSUInteger i=0;i<8;i++){Receive(f,@"c",@"c",nil);[f advance:2];Complete(f,i,@"short reply",nil);}
    CHECK(f.client.operations.lastObject.messages.count==11);
    [f.coordinator configurationDidChange];Receive(f,@"c",@"c",nil);[f advance:2];CHECK(f.client.operations.lastObject.messages.count==2);
    // A burst remains bounded even before a request exists.
    f=[Fixture new];for(NSUInteger i=0;i<8;i++){NSMutableDictionary *event=[f event:@"c" sender:@"c" identity:nil];event[@"text"]=[@"😀" stringByPaddingToLength:6000 withString:@"😀" startingAtIndex:0];[f.coordinator receiveEvent:event];}
    [f advance:2];CHECK([LastInput(f.client.operations[0]) length]<=12000);CHECK([LastInput(f.client.operations[0]) dataUsingEncoding:NSUTF8StringEncoding]);
}
@interface CSAIReplyCoordinator (ContextTestAccess)
- (NSArray *)contextForKey:(NSArray *)key;
- (void)clearContextsForConversation:(NSString *)conversation;
@end
static void AddContext(Fixture *f,NSString *sender,NSUInteger length) {
    NSMutableDictionary *event=[f event:@"room@chatroom" sender:sender identity:nil];
    event[@"text"]=[@"u" stringByPaddingToLength:length withString:@"u" startingAtIndex:0];
    [f.coordinator receiveEvent:event];[f advance:2];Complete(f,f.client.operations.count-1,@"reply",nil);
}
static void GlobalContextBoundsAndMemoryPressure(void) {
    Fixture *f=[Fixture new];
    for(NSUInteger i=0;i<32;i++)AddContext(f,[NSString stringWithFormat:@"member-%lu",(unsigned long)i],20);
    NSDictionary *contexts=[f.coordinator valueForKey:@"contexts"];CHECK(contexts.count==32);
    CHECK([f.coordinator contextForKey:@[@"room@chatroom",@"member-0"]]);
    AddContext(f,@"member-32",20);CHECK(contexts.count==32);
    CHECK(contexts[@[@"room@chatroom",@"member-0"]] && !contexts[@[@"room@chatroom",@"member-1"]]);
    CHECK(![f.coordinator valueForKey:@"timer"]); // Cache retention never creates wakeups.
    [f.coordinator clearContextsForConversation:@"room@chatroom"];
    CHECK(!contexts.count && ![[f.coordinator valueForKey:@"contextUTF16Cost"] unsignedIntegerValue]);
    f=[Fixture new];
    for(NSUInteger i=0;i<22;i++)AddContext(f,[NSString stringWithFormat:@"long-%lu",(unsigned long)i],12000);
    contexts=[f.coordinator valueForKey:@"contexts"];CHECK(contexts.count==21);
    CHECK([[f.coordinator valueForKey:@"contextUTF16Cost"] unsignedIntegerValue]<=256*1024);
    CHECK(!contexts[@[@"room@chatroom",@"long-0"]]);
    [f.coordinator cancelAll];CHECK(![[f.coordinator valueForKey:@"contextUTF16Cost"] unsignedIntegerValue]);
    f=[Fixture new];AddContext(f,@"ttl",20);NSTimeInterval last=f.clock;
    f.clock=last+1799;CHECK([f.coordinator contextForKey:@[@"room@chatroom",@"ttl"]]);
    f.clock+=1800;CHECK(![f.coordinator contextForKey:@[@"room@chatroom",@"ttl"]]);
    AddContext(f,@"rollback",20);f.clock-=10;
    CHECK(![f.coordinator contextForKey:@[@"room@chatroom",@"rollback"]]);
    // Memory pressure discards cached history, without cancelling live requests.
    f=[Fixture new];AddContext(f,@"member",20);Receive(f,@"room@chatroom",@"member",nil);[f advance:2];
    Receive(f,@"d",@"d",nil);CHECK(f.coordinator.activeCount==1 && f.coordinator.pendingCount==1);
    NSUInteger history=f.store.history.count;
    [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidReceiveMemoryWarningNotification" object:nil];
    CHECK(f.coordinator.activeCount==1 && f.coordinator.pendingCount==1 && !f.client.operations[1].cancelled);
    CHECK(f.store.history.count==history && ![[f.coordinator valueForKey:@"contexts"] count]);
    Complete(f,1,@"valid after warning",nil);CHECK(f.delegate.sends==2);
    CHECK(![[f.coordinator valueForKey:@"contexts"] count]); // Old batch cannot repopulate cache.
    [f advance:2];Complete(f,2,@"new batch",nil);CHECK([[f.coordinator valueForKey:@"contexts"] count]==1);
}
static void DeferredClaimsAndAliases(void) {
    Fixture *f=[Fixture new];f.store.deferClaims=YES;
    NSMutableDictionary *event=[f event:@"c" sender:@"c" identity:@"local-A"];
    [f.coordinator receiveEvent:event];CHECK(f.coordinator.pendingCount==1 && f.store.claimRequests.count==1);
    [f advance:2];CHECK(!f.client.operations.count && ![f.store hasHandledMessageID:@"local-A"]);
    event[@"identifiers"]=@[@"local-A",@"server-B"];[f.coordinator receiveEvent:event];
    event[@"identifiers"]=@[@"server-B"];[f.coordinator receiveEvent:event];CHECK(f.store.claimRequests.count==2);
    [f.store completeNextClaim];CHECK(!f.client.operations.count);
    [f.store completeNextClaim];CHECK(f.client.operations.count==1 && !f.coordinator.pendingCount);
    // An alias arriving after model work begins still fences the final native send.
    event[@"identifiers"]=@[@"server-B",@"later-C"];[f.coordinator receiveEvent:event];
    Complete(f,0,@"reply",nil);Complete(f,0,@"duplicate completion",nil);
    CHECK(!f.delegate.sends && f.coordinator.activeCount==1);
    [f.store completeNextClaim];CHECK(f.delegate.sends==1 && !f.coordinator.activeCount);
    CHECK([f.store hasHandledMessageID:@"later-C"]);
    event[@"identifiers"]=@[@"later-C"];[f.coordinator receiveEvent:event];CHECK(!f.store.claimRequests.count && !f.coordinator.pendingCount);
    // Late disk success cannot resurrect cancelled or expired work.
    f=[Fixture new];f.store.deferClaims=YES;Receive(f,@"c",@"c",@"cancelled-claim");[f.coordinator cancelAll];
    [f.store completeNextClaim];[f advance:2];CHECK(!f.client.operations.count && !f.delegate.sends);
    CHECK([f.store hasHandledMessageID:@"cancelled-claim"]);
    f=[Fixture new];f.store.deferClaims=YES;Receive(f,@"c",@"c",@"expired-claim");[f advance:121];
    [f.store completeNextClaim];CHECK(!f.client.operations.count && !f.coordinator.pendingCount);
    // A failed alias commit cancels the waiting reply instead of retrying it.
    f=[Fixture new];Receive(f,@"c",@"c",@"known-local");[f advance:2];f.store.deferClaims=YES;
    event=[f event:@"c" sender:@"c" identity:nil];event[@"identifiers"]=@[@"known-local",@"failed-alias"];[f.coordinator receiveEvent:event];
    Complete(f,0,@"must not send",nil);f.store.failClaims=YES;[f.store completeNextClaim];
    CHECK(!f.delegate.sends && !f.coordinator.activeCount && !f.coordinator.pendingCount);
    // Waiting for a slow writer cannot build an unbounded admission queue.
    f=[Fixture new];f.store.deferClaims=YES;
    for(NSUInteger i=0;i<40;i++)Receive(f,@"c",@"c",nil);
    CHECK(f.store.claimRequests.count==20 && f.coordinator.pendingCount==1);
    [f advance:3];CHECK(!f.client.operations.count);
    while(f.store.claimRequests.count)[f.store completeNextClaim];CHECK(f.client.operations.count==1);
    // Business cancellation does not release ordinary disk queue capacity.
    // Late aliases reach the Store immediately even when all 20 slots are full.
    f=[Fixture new];f.store.deferClaims=YES;
    for(NSUInteger i=0;i<20;i++)Receive(f,@"c",@"c",[NSString stringWithFormat:@"slow-%lu",(unsigned long)i]);
    event=[f event:@"c" sender:@"c" identity:nil];event[@"identifiers"]=@[@"slow-0",@"buffered-server"];
    [f.coordinator receiveEvent:event];CHECK(f.store.claimRequests.count==21);
    CHECK([[f.coordinator valueForKey:@"outstandingClaimWrites"] unsignedIntegerValue]==20);
    [f.coordinator cancelAll];
    for(NSUInteger i=0;i<40;i++)Receive(f,@"d",@"d",nil);
    CHECK(f.store.claimRequests.count==21 && !f.coordinator.pendingCount);
    [f.store completeNextClaim];CHECK(f.store.claimRequests.count==20);
    event[@"identifiers"]=@[@"buffered-server"];[f.coordinator receiveEvent:event];CHECK(!f.coordinator.pendingCount);
    while(f.store.claimRequests.count)[f.store completeNextClaim];
    CHECK([f.store hasHandledMessageID:@"buffered-server"] && !f.client.operations.count);
    CHECK(![[f.coordinator valueForKey:@"outstandingClaimWrites"] unsignedIntegerValue]);
    Receive(f,@"d",@"d",@"after-drain");CHECK(f.store.claimRequests.count==1);[f.store completeNextClaim];
    [f advance:2];CHECK(f.client.operations.count==1);
    // Hitting the resident identity limit must still persist a known message's
    // newly discovered server ID. Seed the pressure directly to avoid 5000 fsyncs.
    f=[Fixture new];Receive(f,@"c",@"c",@"capacity-local");[f advance:2];Complete(f,0,@"original reply",nil);
    id resident=[NSClassFromString(@"CSAIReplyIdentityReservation") new];
    NSMutableSet *residentIDs=[NSMutableSet set];NSMutableDictionary *reservations=[f.coordinator valueForKey:@"reservedIdentities"];
    for(NSUInteger i=0;i<5000;i++){NSString *identifier=[NSString stringWithFormat:@"resident-%lu",(unsigned long)i];[residentIDs addObject:identifier];reservations[identifier]=resident;}
    [resident setValue:residentIDs forKey:@"identifiers"];
    f.store.deferClaims=YES;event=[f event:@"c" sender:@"c" identity:nil];
    event[@"created"]=@(f.clock+20);event[@"identifiers"]=@[@"capacity-local",@"capacity-server"];
    [f.coordinator receiveEvent:event];CHECK(f.store.claimRequests.count==1);
    [f.store completeNextClaim];CHECK([f.store hasHandledMessageID:@"capacity-server"]);
    [f.coordinator configurationDidChange];event[@"identifiers"]=@[@"capacity-server"];
    [f.coordinator receiveEvent:event];[f advance:2];
    CHECK(!f.store.claimRequests.count && f.client.operations.count==1 && f.delegate.sends==1);
}
static void WaitFor(BOOL (^condition)(void)) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:5];
    while(!condition() && deadline.timeIntervalSinceNow>0)
        [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.005]];
    CHECK(condition());
}
static void ProductionAsyncStoreIntegration(void) {
    Fixture *f=[Fixture new];f.store.useAsyncStore=YES;
    Receive(f,@"c",@"c",@"async-c");Receive(f,@"d",@"d",@"async-d");Receive(f,@"e",@"e",@"async-e");
    CHECK(!f.client.operations.count && f.coordinator.pendingCount==3);[f advance:2];
    WaitFor(^BOOL{return f.client.operations.count==2;});
    CHECK([f.store hasHandledMessageID:@"async-c"] && [f.store hasHandledMessageID:@"async-d"]);
    Complete(f,0,@"reply c",nil);WaitFor(^BOOL{return f.client.operations.count==3;});
    Complete(f,1,@"reply d",nil);Complete(f,2,@"reply e",nil);CHECK(f.delegate.sends==3);
    WaitFor(^BOOL{return f.store.history.count==3;});
    __block BOOL flushed=NO;[f.store flushHistoryWithCompletion:^(BOOL success,NSError *error){CHECK(success && !error);flushed=YES;}];
    WaitFor(^BOOL{return flushed;});
    NSDictionary *disk=[CSAIReplyStore readStateAtURL:CSAIReplyFileURL(f.root,@"me") account:@"me" error:NULL];
    CHECK([disk[@"history"] count]==3 && [disk[@"handled"] count]==3);
}
static void OneShotProductionWakeup(void) {
    Fixture *f=[Fixture new];__block NSTimeInterval value=NSDate.date.timeIntervalSince1970;f.coordinator.now=^{return value;};[f.coordinator configurationDidChange];f.clock=value;
    Receive(f,@"c",@"c",nil);value+=2.1;
    // The timer uses a real run loop while only the injected logical clock is advanced.
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:2.3];while(!f.client.operations.count && [deadline timeIntervalSinceNow]>0)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];
    CHECK(f.client.operations.count==1);[f.coordinator cancelAll];
}
static FakeImages *EnableImages(Fixture *f){
    [f save:^(NSMutableDictionary *c){c[@"imageEnabled"]=@YES;c[@"verifiedConnection"]=CSAIConnectionIdentifier(c);}];
    FakeImages *images=[FakeImages new];f.coordinator.imagePreparer=images;return images;
}
static NSMutableDictionary *ImageEvent(Fixture *f,NSString *conversation,NSString *sender,NSString *identity){
    NSMutableDictionary *event=[f event:conversation sender:sender identity:identity];event[@"type"]=@3;event[@"text"]=@"";event[@"imageSource"]=[NSObject new];return event;
}
static void ImagePreparationAndOwnership(void){
    Fixture *f=[Fixture new];FakeImages *images=[FakeImages new];f.coordinator.imagePreparer=images;
    [f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",@"disabled-image")];[f advance:2];CHECK(!images.operations.count && ![f.store hasHandledMessageID:@"disabled-image"]);
    images=EnableImages(f);[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",@"image")];CHECK([f.store hasHandledMessageID:@"image"] && !images.operations.count);
    [f advance:2];CHECK(images.operations.count==1 && !f.client.operations.count && f.coordinator.activeCount==1);
    images.operations[0].completion(@"data:image/jpeg;base64,AQ==",nil);CHECK(f.client.operations.count==1);
    NSArray *parts=f.client.operations[0].messages.lastObject[@"content"];CHECK([parts isKindOfClass:NSArray.class] && parts.count==2 && [parts[0][@"type"] isEqual:@"image_url"]);
    // A duplicate preparation completion cannot start a second model request.
    images.operations[0].completion(@"data:image/jpeg;base64,AQ==",nil);CHECK(f.client.operations.count==1);
    Complete(f,0,@"图中是一张照片。",nil);CHECK(f.delegate.sends==1);
    Receive(f,@"c",@"c",@"followup");[f advance:2];CHECK(![f.client.operations.lastObject.messages.description containsString:@"base64"]);
    [f.coordinator cancelAll];
    f=[Fixture new];images=EnableImages(f);[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",@"cancel-image")];[f advance:2];
    [f.coordinator configurationDidChange];CHECK(images.operations[0].cancelled);images.operations[0].completion(@"data:image/jpeg;base64,AQ==",nil);CHECK(!f.client.operations.count && !f.delegate.sends);
    BOOL (^valid)(void)=images.events[0][@"imageStillValid"];CHECK(!valid());
    f=[Fixture new];images=EnableImages(f);[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",@"failed-image")];[f advance:2];images.operations[0].completion(nil,CSAIError(25,@"private raw media error"));
    CHECK(!f.client.operations.count && !f.coordinator.activeCount && ![f.store.history.description containsString:@"private raw"]);
    f=[Fixture new];images=EnableImages(f);images.inlineCompletion=YES;[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",@"inline-image")];[f advance:2];
    CHECK(f.client.operations.count==1 && !f.client.operations[0].cancelled);[f.coordinator cancelAll];CHECK(f.client.operations[0].cancelled);
    f=[Fixture new];images=EnableImages(f);for(NSString *c in @[@"c",@"d",@"e"])[f.coordinator receiveEvent:ImageEvent(f,c,c,nil)];[f advance:2];
    CHECK(images.operations.count==2 && f.coordinator.activeCount==2 && f.coordinator.pendingCount==1);[f advance:60];CHECK(images.operations[0].cancelled && images.operations[1].cancelled && images.operations.count==3);
    f=[Fixture new];images=EnableImages(f);f.store.failClaims=YES;[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",@"failed-claim-image")];[f advance:2];CHECK(!images.operations.count && !f.coordinator.pendingCount);
    // An asynchronous preparation failure to acquire credentials releases its slot immediately.
    f=[Fixture new];images=EnableImages(f);for(NSString *c in @[@"c",@"d",@"e"])[f.coordinator receiveEvent:ImageEvent(f,c,c,nil)];[f advance:2];
    f.delegate.hasKey=NO;images.operations[0].completion(@"data:image/jpeg;base64,AQ==",nil);
    CHECK(images.operations.count==3 && f.coordinator.activeCount==2 && !f.coordinator.pendingCount && !f.client.operations.count);
    f=[Fixture new];images=EnableImages(f);[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",nil)];[f advance:2];
    images.operations[0].callbackOnCancel=YES;[f.coordinator cancelAll];CHECK(!f.coordinator.activeCount && !f.client.operations.count && !f.delegate.sends);
    for(NSNumber *image in @[@NO,@YES]){
        f=[Fixture new];images=EnableImages(f);__weak CSAIReplyCoordinator *weakCoordinator=f.coordinator;
        f.delegate.beforeAllows=^{[weakCoordinator cancelAll];};
        NSMutableDictionary *event=image.boolValue?ImageEvent(f,@"room@chatroom",@"member",@"cancel-admission-image"):[f event:@"c" sender:@"c" identity:@"cancel-admission-text"];
        event[@"mentioned"]=@NO;[f.coordinator receiveEvent:event];
        CHECK(!f.coordinator.pendingCount && ![[f.coordinator valueForKey:@"stagedImages"] count] && ![f.store hasHandledMessageID:[event[@"identifiers"] firstObject]]);
    }
}
static void CheckFailureHistory(Fixture *f,NSString *detail){
    CHECK(f.store.history.count==1 && [f.store.history.lastObject[@"result"] isEqual:@"failed"]);
    CHECK([f.store.history.lastObject[@"detail"] isEqual:detail]);
    CHECK(!f.coordinator.activeCount && !f.delegate.sends);
    NSString *history=f.store.history.description;
    for(NSString *privateValue in @[@"RAW ERROR",@"private input body",@"secret-key",@"/private/media.png"])
        CHECK(![history containsString:privateValue]);
}
static NSError *PrivateFailure(NSString *domain,NSInteger code){
    return [NSError errorWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey:@"RAW ERROR private input body secret-key /private/media.png"}];
}
static void SafeFailureDetails(void){
    // Image-stage errors stay distinct from model/network errors and never expose upstream text.
    NSDictionary *imageDetails=@{@1:@"图片处理任务暂不可用，未请求 AI",@2:@"图片消息或当前会话已失效，未请求 AI",
        @3:@"图片未就绪，无法启动下载，未请求 AI",@4:@"图片下载失败，未请求 AI",@5:@"图片下载超时，未请求 AI",
        @6:@"图片大小超过处理限制，未请求 AI",@7:@"图片不完整、格式不支持或无法解码，未请求 AI",
        @401:@"图片准备失败，未请求 AI",@403:@"图片准备失败，未请求 AI",@999:@"图片准备失败，未请求 AI"};
    for(NSNumber *code in imageDetails){
        Fixture *f=[Fixture new];FakeImages *images=EnableImages(f);
        [f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",nil)];[f advance:2];
        images.operations[0].completion(nil,PrivateFailure(@"CSAIImagePreparation",code.integerValue));
        CheckFailureHistory(f,imageDetails[code]);CHECK(!f.client.operations.count && [f.store.configuration[@"verifiedConnection"] length]);
    }
    // A missing preparer, empty result or unexpected preparer error uses the same safe stage fallback.
    for(NSUInteger mode=0;mode<4;mode++){
        Fixture *f=[Fixture new];FakeImages *images=EnableImages(f);
        [f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",nil)];if(!mode)f.coordinator.imagePreparer=nil;[f advance:2];
        if(mode)images.operations[0].completion(mode==1?@"":nil,mode==3?PrivateFailure(@"com.wechatimprove.ai-reply",401):nil);
        CheckFailureHistory(f,@"图片准备失败，未请求 AI");CHECK(!f.client.operations.count && [f.store.configuration[@"verifiedConnection"] length]);
    }
    NSDictionary *requestDetails=@{@20:@"AI 响应格式无效",@21:@"AI 响应超过处理限制",@22:@"网络请求失败，请检查连接",
        @23:@"AI 返回为空、不完整或超过长度限制",@24:@"图文请求配置无效，请检查模型及能力设置",@25:@"AI 服务返回错误，请稍后再试",
        @302:@"请求地址发生重定向，请检查接口地址",@400:@"AI 服务拒绝请求，请检查模型及能力设置",
        @401:@"连接认证失效，请重新测试",@403:@"连接认证失效，请重新测试",@429:@"AI 请求过于频繁，请稍后再试",
        @500:@"AI 服务请求失败，请稍后再试",@(NSURLErrorTimedOut):@"AI 请求超时",@999:@"生成失败、超时或回复无效"};
    for(NSNumber *code in requestDetails){
        Fixture *f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];
        Complete(f,0,nil,PrivateFailure(@"com.wechatimprove.ai-reply",code.integerValue));CheckFailureHistory(f,requestDetails[code]);
        CHECK(([f.store.configuration[@"verifiedConnection"] length]==0)==(code.integerValue==401 || code.integerValue==403));
    }
    // Matching numeric codes from an unrelated domain cannot revoke connection verification.
    for(NSNumber *code in @[@401,@403,@429,@(NSURLErrorTimedOut)]){
        Fixture *f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];
        Complete(f,0,nil,PrivateFailure(@"unrelated.private.domain",code.integerValue));CheckFailureHistory(f,@"生成失败、超时或回复无效");
        CHECK([f.store.configuration[@"verifiedConnection"] length]);
    }
    // Completing image preparation moves diagnostics to the model stage; it must not retain the image fallback.
    Fixture *f=[Fixture new];FakeImages *images=EnableImages(f);[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",nil)];[f advance:2];
    images.operations[0].completion(@"data:image/jpeg;base64,AQ==",nil);CHECK(f.client.operations.count==1);
    Complete(f,0,nil,PrivateFailure(@"com.wechatimprove.ai-reply",429));CheckFailureHistory(f,@"AI 请求过于频繁，请稍后再试");
}
static void GroupImagesAndBudgets(void){
    Fixture *f=[Fixture new];FakeImages *images=EnableImages(f);NSMutableDictionary *image=ImageEvent(f,@"room@chatroom",@"member",@"staged-image");image[@"mentioned"]=@NO;
    [f.coordinator receiveEvent:image];CHECK(!f.coordinator.pendingCount && !images.operations.count && ![f.store hasHandledMessageID:@"staged-image"]);
    NSMutableDictionary *question=[f event:@"room@chatroom" sender:@"other-member" identity:@"other-question"];[f.coordinator receiveEvent:question];[f advance:2];CHECK(!images.operations.count && f.client.operations.count==1);Complete(f,0,@"other answer",nil);
    question=[f event:@"room@chatroom" sender:@"member" identity:@"image-question"];question[@"text"]=@"请读图中的文字";[f.coordinator receiveEvent:question];CHECK([f.store hasHandledMessageID:@"staged-image"] && [f.store hasHandledMessageID:@"image-question"]);
    [f advance:2];CHECK(images.operations.count==1);images.operations[0].completion(@"data:image/jpeg;base64,AQ==",nil);
    CHECK([f.client.operations.lastObject.messages.lastObject[@"content"][1][@"text"] isEqual:@"请读图中的文字"]);Complete(f,1,@"recognized",nil);CHECK(f.delegate.sends==2);
    f=[Fixture new];images=EnableImages(f);image=ImageEvent(f,@"room@chatroom",@"member",@"expired-image");image[@"mentioned"]=@NO;[f.coordinator receiveEvent:image];[f advance:20];[f.coordinator receiveEvent:image];[f advance:11];
    CHECK([[f.coordinator valueForKey:@"stagedImages"] count]==0);Receive(f,@"room@chatroom",@"member",@"late-question");[f advance:2];CHECK(!images.operations.count && f.client.operations.count==1);
    // Staged callbacks can add a server ID then lose the local ID; preserve every alias.
    f=[Fixture new];images=EnableImages(f);image=ImageEvent(f,@"room@chatroom",@"member",@"stage-local");image[@"mentioned"]=@NO;[f.coordinator receiveEvent:image];
    image[@"identifiers"]=@[@"stage-local",@"stage-server"];[f.coordinator receiveEvent:image];
    image[@"identifiers"]=@[@"stage-server"];[f.coordinator receiveEvent:image];
    Receive(f,@"room@chatroom",@"member",@"alias-question");CHECK([f.store hasHandledMessageID:@"stage-local"] && [f.store hasHandledMessageID:@"stage-server"]);
    [f advance:2];CHECK(images.operations.count==1);images.operations[0].completion(@"data:image/jpeg;base64,AQ==",nil);Complete(f,0,@"one answer",nil);
    image[@"identifiers"]=@[@"stage-local"];[f.coordinator receiveEvent:image];Receive(f,@"room@chatroom",@"member",@"another-question");[f advance:2];CHECK(images.operations.count==1);
    f=[Fixture new];images=EnableImages(f);NSMutableDictionary *oldImage=ImageEvent(f,@"room@chatroom",@"member",@"old-image");oldImage[@"mentioned"]=@NO;[f.coordinator receiveEvent:oldImage];
    image=ImageEvent(f,@"room@chatroom",@"member",@"newest-image");image[@"mentioned"]=@NO;[f.coordinator receiveEvent:image];oldImage[@"identifiers"]=@[@"old-image",@"old-image-server"];[f.coordinator receiveEvent:oldImage];
    oldImage[@"identifiers"]=@[@"old-image-server"];[f.coordinator receiveEvent:oldImage];
    Receive(f,@"room@chatroom",@"member",@"newest-question");[f advance:2];CHECK([images.events[0][@"identifiers"] containsObject:@"newest-image"] && ![f.store hasHandledMessageID:@"old-image"]);
    f=[Fixture new];images=EnableImages(f);for(NSUInteger i=0;i<20;i++){image=ImageEvent(f,@"room@chatroom",[NSString stringWithFormat:@"sender%lu",(unsigned long)i],nil);image[@"mentioned"]=@NO;[f.coordinator receiveEvent:image];}
    CHECK([[f.coordinator valueForKey:@"stagedImages"] count]==10 && !images.operations.count);[f advance:30];CHECK([[f.coordinator valueForKey:@"stagedImages"] count]==0);
    f=[Fixture new];images=EnableImages(f);[f save:^(NSMutableDictionary *c){NSMutableDictionary *conversations=[c[@"conversations"] mutableCopy];conversations[@"room@chatroom"]=@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES};c[@"conversations"]=conversations;}];
    image=ImageEvent(f,@"room@chatroom",@"member",@"direct-image");image[@"mentioned"]=@NO;[f.coordinator receiveEvent:image];[f advance:2];CHECK(images.operations.count==1);
    image=ImageEvent(f,@"room@chatroom",@"member",@"all-image");image[@"atAll"]=@YES;[f.coordinator receiveEvent:image];CHECK(![f.store hasHandledMessageID:@"all-image"]);
    // Metadata for a second image never inflates a pending batch into an album upload.
    f=[Fixture new];images=EnableImages(f);[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",@"first-image")];[f.coordinator receiveEvent:ImageEvent(f,@"c",@"c",@"second-image")];
    CHECK(![f.store hasHandledMessageID:@"second-image"]);[f advance:2];CHECK(images.operations.count==1 && [images.events[0][@"identifiers"] containsObject:@"first-image"]);
}
int main(void){@autoreleasepool{
    Filters();GroupUnmentioned();DedupeBatchingAndSerialization();EvolvingAliasDurability();CancellationAndBoundaries();LimitsExpiryAndErrors();ContextBudgetAndPreset();GlobalContextBoundsAndMemoryPressure();DeferredClaimsAndAliases();ProductionAsyncStoreIntegration();ImagePreparationAndOwnership();SafeFailureDetails();GroupImagesAndBudgets();OneShotProductionWakeup();
    puts("AIReplyCoordinatorTests passed: filtering, alias durability fences, bounded async admissions, LRU/TTL/global text budget, memory pressure, serialization, cancellation, expiry, safe failure details and one-shot timers");
}return 0;}
