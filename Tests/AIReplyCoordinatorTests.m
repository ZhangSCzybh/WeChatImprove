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
@interface FakeDelegate : NSObject <CSAIReplyCoordinatorDelegate>
@property(nonatomic) BOOL allowed;
@property(nonatomic) BOOL hasKey;
@property(nonatomic) NSUInteger attempts;
@property(nonatomic) NSUInteger sends;
@property(nonatomic,copy) NSString *result;
@property(nonatomic,copy) void (^beforeBoundary)(void);
@property(nonatomic,copy) void (^beforeCredential)(void);
@property(nonatomic,copy) BOOL (^lastValid)(void);
@property(nonatomic,strong) NSMutableArray *conversations;
@end
@implementation FakeDelegate
- (instancetype)init {if((self=[super init])){_allowed=YES;_hasKey=YES;_result=@"submitted";_conversations=[NSMutableArray array];}return self;}
- (BOOL)coordinator:(CSAIReplyCoordinator *)coordinator allowsConversation:(NSString *)conversation {(void)coordinator;(void)conversation;CHECK(NSThread.isMainThread);return self.allowed;}
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
@end
@implementation ClaimFailureStore
- (BOOL)claimMessageIDs:(NSArray<NSString *> *)identifiers error:(NSError **)error {return self.failClaims?NO:[super claimMessageIDs:identifiers error:error];}
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
static void CancellationAndBoundaries(void) {
    for(NSUInteger mode=0;mode<5;mode++){
        Fixture *f=[Fixture new];Receive(f,@"c",@"c",nil);Receive(f,@"d",@"d",nil);Receive(f,@"e",@"e",nil);[f advance:2];CHECK(f.coordinator.activeCount==2);
        f.client.operations[0].callbackOnCancel=YES;
        if(mode==0)[f save:^(NSMutableDictionary *c){c[@"enabled"]=@NO;}];
        if(mode==1)[f save:^(NSMutableDictionary *c){c[@"model"]=@"changed";}];
        if(mode==2){f.delegate.allowed=NO;[f.coordinator processPending];}
        if(mode==3)[f.coordinator cancelAll];
        if(mode==4){[f.coordinator manualReplyInConversation:@"c"];[f.coordinator manualReplyInConversation:@"d"];[f.coordinator manualReplyInConversation:@"e"];}
        Complete(f,0,@"late private reply",nil);Complete(f,1,@"late reply",nil);[f advance:5];CHECK(!f.delegate.sends);CHECK(!f.coordinator.activeCount && !f.coordinator.pendingCount);CHECK(f.client.operations[0].cancelled);
    }
    // Cancellation frees capacity immediately; an old callback cannot remove a new active batch.
    Fixture *f=[Fixture new];Receive(f,@"c",@"c",@"old");[f advance:2];[f.coordinator manualReplyInConversation:@"c"];
    Receive(f,@"c",@"c",@"new");[f advance:2];CHECK(f.coordinator.activeCount==1);Complete(f,0,@"stale",nil);CHECK(f.coordinator.activeCount==1);Complete(f,1,@"new reply",nil);CHECK(f.delegate.sends==1);
    // Both the initial submission check and native boundary closure recheck privacy/configuration.
    f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];__weak Fixture *weak=f;
    f.delegate.beforeBoundary=^{weak.delegate.allowed=NO;};Complete(f,0,@"reply",nil);CHECK(f.delegate.attempts==1 && !f.delegate.sends);
    f=[Fixture new];Receive(f,@"c",@"c",nil);[f advance:2];weak=f;
    f.delegate.beforeBoundary=^{[weak.coordinator configurationDidChange];};Complete(f,0,@"reply",nil);CHECK(!f.delegate.sends && !f.store.history.count);
    f=[Fixture new];weak=f;f.delegate.beforeCredential=^{[weak.coordinator manualReplyInConversation:@"c"];};Receive(f,@"c",@"c",nil);[f advance:2];CHECK(!f.client.operations.count && !f.coordinator.activeCount);
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
    [f.coordinator manualReplyInConversation:@"c"];Receive(f,@"c",@"c",nil);[f advance:2];CHECK(f.client.operations.lastObject.messages.count==2);
    f=[Fixture new];for(NSUInteger i=0;i<8;i++){Receive(f,@"c",@"c",nil);[f advance:2];Complete(f,i,@"short reply",nil);}
    CHECK(f.client.operations.lastObject.messages.count==11);
    [f.coordinator configurationDidChange];Receive(f,@"c",@"c",nil);[f advance:2];CHECK(f.client.operations.lastObject.messages.count==2);
    // A burst remains bounded even before a request exists.
    f=[Fixture new];for(NSUInteger i=0;i<8;i++){NSMutableDictionary *event=[f event:@"c" sender:@"c" identity:nil];event[@"text"]=[@"😀" stringByPaddingToLength:6000 withString:@"😀" startingAtIndex:0];[f.coordinator receiveEvent:event];}
    [f advance:2];CHECK([LastInput(f.client.operations[0]) length]<=12000);CHECK([LastInput(f.client.operations[0]) dataUsingEncoding:NSUTF8StringEncoding]);
}
static void OneShotProductionWakeup(void) {
    Fixture *f=[Fixture new];__block NSTimeInterval value=NSDate.date.timeIntervalSince1970;f.coordinator.now=^{return value;};[f.coordinator configurationDidChange];f.clock=value;
    Receive(f,@"c",@"c",nil);value+=2.1;
    // The timer uses a real run loop while only the injected logical clock is advanced.
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:2.3];while(!f.client.operations.count && [deadline timeIntervalSinceNow]>0)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];
    CHECK(f.client.operations.count==1);[f.coordinator cancelAll];
}
int main(void){@autoreleasepool{
    Filters();DedupeBatchingAndSerialization();CancellationAndBoundaries();LimitsExpiryAndErrors();ContextBudgetAndPreset();OneShotProductionWakeup();
    puts("AIReplyCoordinatorTests passed: filtering, alias claims, debounce, serialization, context bounds, cancellation, boundary authorization, expiry, concurrency, errors and one-shot timers");
}return 0;}
