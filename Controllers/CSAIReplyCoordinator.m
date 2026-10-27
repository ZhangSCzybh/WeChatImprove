#import "CSAIReplyCoordinator.h"
#import <math.h>

static BOOL AIString(id value, NSUInteger minimum, NSUInteger maximum) {
    return [value isKindOfClass:NSString.class] && [value length]>=minimum && [value length]<=maximum;
}
static void AIRequireMain(void) { NSCAssert(NSThread.isMainThread,@"AI reply coordinator requires the main thread"); }
// Keep the newest complete UTF-16 characters when a burst exceeds the context budget.
static NSString *AITail(NSString *text, NSUInteger limit) {
    if(text.length<=limit)return text;
    NSUInteger start=text.length-limit;
    if(start && CFStringIsSurrogateLowCharacter([text characterAtIndex:start]) && CFStringIsSurrogateHighCharacter([text characterAtIndex:start-1]))start++;
    return [text substringFromIndex:start];
}
static NSArray<NSDictionary *> *AIBoundedMessages(NSArray<NSDictionary *> *messages) {
    NSMutableArray *result=[NSMutableArray array];NSUInteger budget=12000;
    for(NSDictionary *message in [messages reverseObjectEnumerator]) {
        if(result.count==10 || !budget)break;
        NSString *text=AITail(message[@"content"],budget);
        if(text.length){[result insertObject:@{@"role":message[@"role"],@"content":text} atIndex:0];budget-=text.length;}
    }
    return result;
}
@interface CSAIReplyBatch : NSObject
@property(nonatomic,copy) NSString *conversation;
@property(nonatomic,copy) NSArray<NSString *> *contextKey;
@property(nonatomic,copy) NSDictionary *configuration;
@property(nonatomic,copy) NSDictionary *preset;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSArray<NSDictionary *> *messages;
@property(nonatomic) NSTimeInterval due;
@property(nonatomic) NSTimeInterval expires;
@property(nonatomic) NSTimeInterval started;
@property(nonatomic) NSUInteger generation;
@property(nonatomic,strong) id<CSAICancellable> task;
@property(nonatomic,copy) NSString *previousResponseID;
@property(nonatomic,copy) NSDictionary *usage;
@property(nonatomic) BOOL retriedReference;
@property(nonatomic) NSUInteger requestAttempt;
@end
@implementation CSAIReplyBatch
@end

@interface CSAIReplyCoordinator ()
@property(nonatomic,strong,readwrite) CSAIReplyStore *store;
@property(nonatomic,strong) id<CSAIGenerating> client;
@property(nonatomic,strong) NSMutableArray<CSAIReplyBatch *> *pending;
@property(nonatomic,strong) NSMutableDictionary<NSString *,CSAIReplyBatch *> *active;
@property(nonatomic,strong) NSMutableDictionary<NSArray<NSString *> *,NSArray<NSDictionary *> *> *contexts;
@property(nonatomic,strong) NSMutableDictionary<NSArray<NSString *> *,NSDictionary *> *responses;
@property(nonatomic,copy) NSDictionary *configuration;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic) NSUInteger generation;
@property(nonatomic) NSTimeInterval admissionBoundary;
@property(nonatomic) BOOL processing;
@end
@implementation CSAIReplyCoordinator
- (instancetype)initWithStore:(CSAIReplyStore *)store client:(id<CSAIGenerating>)client {
    AIRequireMain();
    if((self=[super init])) {
        _store=store;_client=client;_now=^{return NSDate.date.timeIntervalSince1970;};
        _pending=[NSMutableArray array];_active=[NSMutableDictionary dictionary];_contexts=[NSMutableDictionary dictionary];_responses=[NSMutableDictionary dictionary];
        _configuration=store.configuration;_admissionBoundary=_now();
    }
    return self;
}
- (void)dealloc { [_timer invalidate];for(CSAIReplyBatch *batch in _active.allValues)[batch.task cancel]; }
- (NSUInteger)activeCount { AIRequireMain();return self.active.count; }
- (NSUInteger)pendingCount { AIRequireMain();return self.pending.count; }
- (NSDictionary *)presetForConversation:(NSString *)conversation configuration:(NSDictionary *)configuration {
    NSString *identifier=configuration[@"conversations"][conversation][@"presetID"];
    if(!identifier.length)identifier=configuration[@"defaultPreset"];
    for(NSDictionary *preset in configuration[@"presets"])if([preset[@"id"] isEqual:identifier])return preset;
    return nil;
}
- (BOOL)allowsConversation:(NSString *)conversation configuration:(NSDictionary *)configuration {
    return self.store.ready && [configuration isEqual:self.store.configuration] &&
        [configuration[@"enabled"] boolValue] && [configuration[@"conversations"][conversation][@"enabled"] boolValue] &&
        [configuration[@"endpoint"] length] && [configuration[@"model"] length] && [configuration[@"credentialRevision"] length] &&
        [configuration[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(configuration)] &&
        [self.delegate coordinator:self allowsConversation:conversation];
}
- (BOOL)isCurrent:(CSAIReplyBatch *)batch {
    AIRequireMain();
    BOOL allowed=[self allowsConversation:batch.conversation configuration:batch.configuration];
    NSTimeInterval now=self.now();
    // The delegate is an external boundary and may synchronously cancel or change configuration.
    return allowed && self.active[batch.conversation]==batch && batch.generation==self.generation &&
        [batch.configuration isEqual:self.store.configuration] &&
        isfinite(now) && now<batch.expires && now<batch.started+60;
}
- (void)record:(CSAIReplyBatch *)batch result:(NSString *)result detail:(NSString *)detail {
    // Only fixed, local status strings reach history. Never forward error descriptions or model output.
    NSMutableDictionary *record=[@{@"date":[NSDate dateWithTimeIntervalSince1970:self.now()],@"conversation":batch.conversation,
        @"preset":batch.preset[@"id"]?:@"",@"result":result,@"detail":detail,@"model":batch.configuration[@"model"]?:@"",@"mode":CSAIReplyUsesResponses(batch.configuration)?@"bailianResponses":@"chat"} mutableCopy];
    if(batch.usage.count && CSAIReplyValidateUsage(batch.usage))record[@"usage"]=batch.usage;
    [self.store appendHistory:record error:NULL];
}
- (void)clearContextsForConversation:(NSString *)conversation {
    for(NSArray *key in self.contexts.allKeys)if([key.firstObject isEqual:conversation])[self.contexts removeObjectForKey:key];
    for(NSArray *key in self.responses.allKeys)if([key.firstObject isEqual:conversation])[self.responses removeObjectForKey:key];
}
- (void)cancelBatch:(CSAIReplyBatch *)batch {
    // Remove ownership before calling a cancellation implementation that may call back synchronously.
    if(self.active[batch.conversation]==batch)[self.active removeObjectForKey:batch.conversation];
    id<CSAICancellable> task=batch.task;batch.task=nil;[task cancel];
}
- (void)cancelAll {
    AIRequireMain();self.generation++;[self.timer invalidate];self.timer=nil;
    NSArray *active=self.active.allValues;[self.active removeAllObjects];[self.pending removeAllObjects];[self.contexts removeAllObjects];[self.responses removeAllObjects];
    self.admissionBoundary=self.now();
    for(CSAIReplyBatch *batch in active){id<CSAICancellable> task=batch.task;batch.task=nil;[task cancel];}
}
- (void)configurationDidChange {
    AIRequireMain();[self cancelAll];self.configuration=self.store.configuration;
}
- (void)receiveEvent:(NSDictionary *)event {
    AIRequireMain();
    if(![self.configuration isEqual:self.store.configuration])[self configurationDidChange];
    if(![event isKindOfClass:NSDictionary.class])return;
    NSString *conversation=event[@"conversation"],*sender=event[@"sender"],*text=event[@"text"];
    if(![event[@"account"] isEqual:self.store.account] || !AIString(conversation,1,512) || !AIString(sender,1,512) ||
       [sender isEqual:self.store.account] || [conversation isEqual:self.store.account] || !AIString(text,1,12000) ||
       ![event[@"type"] isEqual:@1] || ![event[@"live"] isEqual:@YES])return;
    if(![event[@"group"] isEqual:@NO] && ![event[@"group"] isEqual:@YES])return;
    BOOL withoutMention=[self.configuration[@"conversations"][conversation][@"replyWithoutMention"] boolValue];
    if([event[@"group"] boolValue] && !withoutMention && (![event[@"mentioned"] isEqual:@YES] || ![event[@"atAll"] isEqual:@NO]))return;
    if(![event[@"created"] isKindOfClass:NSNumber.class])return;
    NSTimeInterval now=self.now(),created=[event[@"created"] doubleValue];
    if(!isfinite(now) || !isfinite(created) || created<self.admissionBoundary || created<now-120 || created>now+30)return;
    text=[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];if(!text.length)return;
    if(![self allowsConversation:conversation configuration:self.configuration])return;
    NSDictionary *preset=[self presetForConversation:conversation configuration:self.configuration];if(!preset)return;
    NSArray *identifiers=event[@"identifiers"];
    if(![identifiers isKindOfClass:NSArray.class] || !identifiers.count || identifiers.count>10)return;
    NSMutableSet *unique=[NSMutableSet set];NSMutableArray *newAliases=[NSMutableArray array];BOOL duplicate=NO;
    for(id identifier in identifiers){
        if(!AIString(identifier,1,1024) || [unique containsObject:identifier])return;
        [unique addObject:identifier];
        if([self.store hasHandledMessageID:identifier])duplicate=YES;else [newAliases addObject:identifier];
    }
    if(duplicate){
        // Native callbacks can acquire a server identity after their first local-only callback.
        // Preserve every new alias before suppressing the duplicate, including unknown sends.
        if(newAliases.count && ![self.store claimMessageIDs:newAliases error:NULL])[self cancelAll];
        return;
    }
    NSArray *key=@[conversation,sender];CSAIReplyBatch *batch=nil;
    for(CSAIReplyBatch *candidate in self.pending)if([candidate.contextKey isEqual:key] && now<candidate.expires){batch=candidate;break;}
    if(!batch && self.pending.count>=20)return;
    // Claim every server/local alias durably before retaining text or starting any model work.
    if(![self.store claimMessageIDs:identifiers error:NULL]){[self cancelAll];return;}
    if(!batch){
        batch=[CSAIReplyBatch new];batch.conversation=conversation;batch.contextKey=key;batch.configuration=self.configuration;
        batch.preset=preset;batch.generation=self.generation;batch.expires=now+120;batch.text=@"";[self.pending addObject:batch];
    }
    batch.text=AITail(batch.text.length?[NSString stringWithFormat:@"%@\n%@",batch.text,text]:text,12000);
    batch.due=now+2;[self processPending];
}
- (void)finishBatch:(CSAIReplyBatch *)batch result:(NSDictionary *)result error:(NSError *)error {
    AIRequireMain();
    if(self.active[batch.conversation]!=batch || batch.generation!=self.generation)return;
    if(![self isCurrent:batch]){[self cancelBatch:batch];[self clearContextsForConversation:batch.conversation];[self processPending];return;}
    batch.task=nil;
    if(error.code==CSAIResponseReferenceExpired && [error.domain isEqual:@"com.wechatimprove.ai-reply"] && batch.previousResponseID.length && !batch.retriedReference){
        batch.retriedReference=YES;batch.previousResponseID=nil;[self.responses removeObjectForKey:batch.contextKey];
        [self requestBatch:batch];return;
    }
    if(CSAIReplyValidateUsage(result[@"usage"]))batch.usage=result[@"usage"];
    NSString *text=result[@"text"];
    NSString *reply=[text isKindOfClass:NSString.class]?[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]:nil;
    if(error || !reply.length || reply.length>4000){
        [self.active removeObjectForKey:batch.conversation];
        BOOL authentication=error && (error.code==401 || error.code==403);
        [self record:batch result:@"failed" detail:authentication?@"连接认证失效，请重新测试":@"生成失败、超时或回复无效"];
        if(authentication){
            NSMutableDictionary *configuration=[self.store.configuration mutableCopy];configuration[@"verifiedConnection"]=@"";[configuration removeObjectForKey:@"verifiedAt"];
            [self.store saveConfiguration:configuration error:NULL];[self configurationDidChange];
        }
        [self processPending];return;
    }
    __weak typeof(self) weakSelf=self;
    BOOL (^valid)(void)=^BOOL {return [weakSelf isCurrent:batch];};
    if(!valid()){[self cancelBatch:batch];[self processPending];return;}
    NSString *submission=[self.delegate coordinator:self submitText:reply conversation:batch.conversation valid:valid];
    // Submission may itself trigger configuration/account cancellation.
    if(self.active[batch.conversation]!=batch || batch.generation!=self.generation){[self processPending];return;}
    [self.active removeObjectForKey:batch.conversation];
    if([submission isEqual:@"submitted"]){
        NSMutableArray *messages=[batch.messages mutableCopy];[messages addObject:@{@"role":@"assistant",@"content":reply}];
        self.contexts[batch.contextKey]=AIBoundedMessages(messages);
        // Only commit server state after native handoff. Trimming the local
        // window requires a new chain, otherwise the server would retain more
        // history than the user-approved context limit.
        if(CSAIReplyUsesResponses(batch.configuration) && AIString(result[@"responseID"],1,512) && [messages isEqual:self.contexts[batch.contextKey]])
            self.responses[batch.contextKey]=@{@"id":result[@"responseID"],@"created":@(self.now())};
        else [self.responses removeObjectForKey:batch.contextKey];
        [self record:batch result:@"submitted" detail:@"已提交，不代表送达"];
    }else if([submission isEqual:@"unknown"]){
        [self record:batch result:@"unknown" detail:@"提交结果未知，不会重试"];
    }else [self record:batch result:@"failed" detail:@"未通过最终发送校验或提交失败"];
    [self processPending];
}
- (void)startBatch:(CSAIReplyBatch *)batch {
    [self.pending removeObjectIdenticalTo:batch];
    // Own the slot before credential lookup, so even reentrant configuration/account cancellation can revoke it.
    batch.started=self.now();self.active[batch.conversation]=batch;
    NSMutableArray *messages=[self.contexts[batch.contextKey] mutableCopy]?:[NSMutableArray array];
    [messages addObject:@{@"role":@"user",@"content":batch.text}];batch.messages=AIBoundedMessages(messages);
    NSDictionary *previous=self.responses[batch.contextKey];
    if(CSAIReplyUsesResponses(batch.configuration) && previous && [messages isEqual:batch.messages] && self.now()<[previous[@"created"] doubleValue]+7*86400)
        batch.previousResponseID=previous[@"id"];
    [self requestBatch:batch];
}
- (void)requestBatch:(CSAIReplyBatch *)batch {
    NSError *error=nil;NSString *key=[self.delegate credentialForCoordinator:self error:&error];
    if(!key.length || error || ![self isCurrent:batch]){
        if(self.active[batch.conversation]==batch){[self.active removeObjectForKey:batch.conversation];[self record:batch result:@"failed" detail:@"凭据或当前会话状态不可用"];}return;
    }
    NSMutableArray *request=[NSMutableArray arrayWithObject:@{@"role":@"system",@"content":batch.preset[@"prompt"]}];[request addObjectsFromArray:batch.messages];
    __weak typeof(self) weakSelf=self;
    NSUInteger attempt=++batch.requestAttempt;
    CSAIResultCompletion completion=^(NSDictionary *result,NSError *failure){
        void(^deliver)(void)=^{if(batch.requestAttempt==attempt)[weakSelf finishBatch:batch result:result error:failure];};
        if(NSThread.isMainThread)deliver();else dispatch_async(dispatch_get_main_queue(),deliver);
    };
    id<CSAICancellable> task;
    if([self.client respondsToSelector:@selector(generateWithConfiguration:apiKey:messages:previousResponseID:completion:)])
        task=[self.client generateWithConfiguration:batch.configuration apiKey:key messages:request previousResponseID:batch.previousResponseID completion:completion];
    else task=[self.client generateWithConfiguration:batch.configuration apiKey:key messages:request completion:^(NSString *text,NSError *failure){completion(text?@{@"text":text}:nil,failure);}];
    // A fake or preflight failure may complete inline; never attach that old task to a replacement.
    if(self.active[batch.conversation]==batch && batch.requestAttempt==attempt)batch.task=task;else [task cancel];
}
- (void)scheduleWakeup {
    [self.timer invalidate];self.timer=nil;
    NSTimeInterval now=self.now(),next=INFINITY;
    for(CSAIReplyBatch *batch in self.active.allValues)next=MIN(next,MIN(batch.expires,batch.started+60));
    for(CSAIReplyBatch *batch in self.pending){
        next=MIN(next,batch.expires);
        if(self.active.count<2 && !self.active[batch.conversation])next=MIN(next,batch.due);
    }
    if(!isfinite(now) || !isfinite(next))return;
    __weak typeof(self) weakSelf=self;
    self.timer=[NSTimer timerWithTimeInterval:MAX(0.01,next-now) repeats:NO block:^(__unused NSTimer *timer){[weakSelf processPending];}];
    [NSRunLoop.mainRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)processPending {
    AIRequireMain();if(self.processing)return;
    self.processing=YES;
    if(![self.configuration isEqual:self.store.configuration])[self configurationDidChange];
    NSTimeInterval now=self.now();
    if(!isfinite(now)){[self cancelAll];self.processing=NO;return;}
    for(CSAIReplyBatch *batch in self.active.allValues){
        if(![self isCurrent:batch]){
            BOOL expired=now>=batch.expires || now>=batch.started+60;
            [self cancelBatch:batch];[self clearContextsForConversation:batch.conversation];
            if(expired)[self record:batch result:@"expired" detail:@"请求或等待已超时，不会重试"];
        }
    }
    for(CSAIReplyBatch *batch in [self.pending copy]){
        if(now>=batch.expires || batch.generation!=self.generation || ![self allowsConversation:batch.conversation configuration:batch.configuration]){
            [self.pending removeObjectIdenticalTo:batch];[self clearContextsForConversation:batch.conversation];
            if(now>=batch.expires)[self record:batch result:@"expired" detail:@"等待已过期，不会补发"];
        }
    }
    while(self.active.count<2){
        CSAIReplyBatch *next=nil;
        for(CSAIReplyBatch *batch in self.pending)if(batch.due<=self.now() && !self.active[batch.conversation]){next=batch;break;}
        if(!next)break;[self startBatch:next];
    }
    self.processing=NO;[self scheduleWakeup];
}
@end
