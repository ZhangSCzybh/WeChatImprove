#import "CSAIReplyCoordinator.h"
#import <math.h>

static BOOL AIString(id value, NSUInteger minimum, NSUInteger maximum) {
    return [value isKindOfClass:NSString.class] && [value length]>=minimum && [value length]<=maximum;
}
static void AIRequireMain(void) { NSCAssert(NSThread.isMainThread,@"AI reply coordinator requires the main thread"); }
static BOOL AIClientFailure(NSError *error) { return [error.domain isEqual:@"com.wechatimprove.ai-reply"]; }
static NSString *AIFailureDetail(NSError *error, BOOL preparingImage) {
    // Classify only known local domains/codes. Error descriptions may contain private input or credentials.
    BOOL imageError=[error.domain isEqual:@"CSAIImagePreparation"];
    if(preparingImage || imageError){
        if(imageError)switch(error.code){
            case 1:return @"图片处理任务暂不可用，未请求 AI";
            case 2:return @"图片消息或当前会话已失效，未请求 AI";
            case 3:return @"图片未就绪，无法启动下载，未请求 AI";
            case 4:return @"图片下载失败，未请求 AI";
            case 5:return @"图片下载超时，未请求 AI";
            case 6:return @"图片大小超过处理限制，未请求 AI";
            case 7:return @"图片不完整、格式不支持或无法解码，未请求 AI";
        }
        return @"图片准备失败，未请求 AI";
    }
    if(AIClientFailure(error))switch(error.code){
        case 401:case 403:return @"连接认证失效，请重新测试";
        case 429:return @"AI 请求过于频繁，请稍后再试";
        case NSURLErrorTimedOut:return @"AI 请求超时";
        case 20:return @"AI 响应格式无效";
        case 21:return @"AI 响应超过处理限制";
        case 22:return @"网络请求失败，请检查连接";
        case 23:return @"AI 返回为空、不完整或超过长度限制";
        case 24:return @"图文请求配置无效，请检查模型及能力设置";
        case 25:return @"AI 服务返回错误，请稍后再试";
        case 400:return @"AI 服务拒绝请求，请检查模型及能力设置";
        default:if(error.code>=300 && error.code<400)return @"请求地址发生重定向，请检查接口地址";
            if(error.code>=400 && error.code<600)return @"AI 服务请求失败，请稍后再试";
    }
    return @"生成失败、超时或回复无效";
}
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
@property(nonatomic,copy) NSDictionary *imageEvent;
@property(nonatomic,copy) NSArray<NSDictionary *> *messages;
@property(nonatomic) NSTimeInterval due;
@property(nonatomic) NSTimeInterval expires;
@property(nonatomic) NSTimeInterval started;
@property(nonatomic) NSUInteger generation;
@property(nonatomic) NSUInteger phase;
@property(nonatomic) BOOL preparingImage;
@property(nonatomic,strong) id<CSAICancellable> task;
@end
@implementation CSAIReplyBatch
@end

@interface CSAIReplyCoordinator ()
@property(nonatomic,strong,readwrite) CSAIReplyStore *store;
@property(nonatomic,strong) id<CSAIGenerating> client;
@property(nonatomic,strong) NSMutableArray<CSAIReplyBatch *> *pending;
@property(nonatomic,strong) NSMutableDictionary<NSString *,CSAIReplyBatch *> *active;
@property(nonatomic,strong) NSMutableDictionary<NSArray<NSString *> *,NSArray<NSDictionary *> *> *contexts;
@property(nonatomic,strong) NSMutableDictionary<NSArray<NSString *> *,NSDictionary *> *stagedImages;
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
        _pending=[NSMutableArray array];_active=[NSMutableDictionary dictionary];_contexts=[NSMutableDictionary dictionary];_stagedImages=[NSMutableDictionary dictionary];
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
    [self.store appendHistory:@{@"date":[NSDate dateWithTimeIntervalSince1970:self.now()],@"conversation":batch.conversation,
        @"preset":batch.preset[@"id"]?:@"",@"result":result,@"detail":detail} error:NULL];
}
- (void)clearContextsForConversation:(NSString *)conversation {
    for(NSArray *key in self.contexts.allKeys)if([key.firstObject isEqual:conversation])[self.contexts removeObjectForKey:key];
}
- (void)cancelBatch:(CSAIReplyBatch *)batch {
    // Remove ownership before calling a cancellation implementation that may call back synchronously.
    if(self.active[batch.conversation]==batch)[self.active removeObjectForKey:batch.conversation];
    id<CSAICancellable> task=batch.task;batch.task=nil;[task cancel];
}
- (void)cancelAll {
    AIRequireMain();self.generation++;[self.timer invalidate];self.timer=nil;
    NSArray *active=self.active.allValues;[self.active removeAllObjects];[self.pending removeAllObjects];[self.contexts removeAllObjects];[self.stagedImages removeAllObjects];
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
    BOOL image=[event[@"type"] isEqual:@3];
    if(![event[@"account"] isEqual:self.store.account] || !AIString(conversation,1,512) || !AIString(sender,1,512) ||
       [sender isEqual:self.store.account] || [conversation isEqual:self.store.account] ||
       (!image && (!AIString(text,1,12000) || ![event[@"type"] isEqual:@1])) ||
       (image && (![self.configuration[@"imageEnabled"] boolValue] || !self.imagePreparer || !event[@"imageSource"])) || ![event[@"live"] isEqual:@YES])return;
    if(![event[@"group"] isEqual:@NO] && ![event[@"group"] isEqual:@YES])return;
    BOOL stageImage=NO;
    if([event[@"group"] boolValue]){
        BOOL allowUnmentioned=[conversation hasSuffix:@"@chatroom"] && [self.configuration[@"conversations"][conversation][@"allowUnmentioned"] boolValue];
        if(![event[@"atAll"] isEqual:@NO])return;
        if(!allowUnmentioned && ![event[@"mentioned"] isEqual:@YES]){if(image)stageImage=YES;else return;}
    }
    if(![event[@"created"] isKindOfClass:NSNumber.class])return;
    NSTimeInterval now=self.now(),created=[event[@"created"] doubleValue];
    if(!isfinite(now) || !isfinite(created) || created<self.admissionBoundary || created<now-120 || created>now+30)return;
    text=image?@"":[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];if(!image && !text.length)return;
    NSUInteger admissionGeneration=self.generation;NSDictionary *admissionConfiguration=self.configuration;
    if(![self allowsConversation:conversation configuration:admissionConfiguration] || admissionGeneration!=self.generation ||
       !self.store.ready || ![admissionConfiguration isEqual:self.configuration] || ![admissionConfiguration isEqual:self.store.configuration])return;
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
    NSArray *key=@[conversation,sender];
    if(stageImage){
        // Keep only bounded metadata until this same sender explicitly mentions us.
        // No file read, download, upload or durable claim happens for an untriggered image.
        NSDictionary *previous=self.stagedImages[key];
        NSMutableDictionary *reference=[event mutableCopy];NSTimeInterval expiry=MIN(now+30,created+30);
        NSArray *previousIDs=previous[@"event"][@"identifiers"];
        NSMutableArray *superseded=[previous[@"supersededIDs"] mutableCopy]?:[NSMutableArray array];
        BOOL sameImage=previous && previous[@"event"][@"imageSource"]==event[@"imageSource"];
        for(NSString *identifier in identifiers)if([previousIDs containsObject:identifier])sameImage=YES;
        BOOL supersededImage=NO;
        for(NSString *identifier in identifiers)if([superseded containsObject:identifier])supersededImage=YES;
        if(!sameImage && supersededImage){
            // Remember evolving aliases even when native message timestamps share the same second.
            for(NSString *identifier in identifiers)if(superseded.count<100 && ![superseded containsObject:identifier])[superseded addObject:identifier];
            NSMutableDictionary *updated=[previous mutableCopy];updated[@"supersededIDs"]=superseded;self.stagedImages[key]=updated;return;
        }
        if(previous && !sameImage && created<[previous[@"event"][@"created"] doubleValue])return;
        if(sameImage){
            // Local/server aliases evolve across callbacks; retain their union and original deadline.
            NSMutableArray *aliases=[previousIDs mutableCopy];
            for(NSString *identifier in identifiers)if(![aliases containsObject:identifier])[aliases addObject:identifier];
            if(aliases.count>10){[self.stagedImages removeObjectForKey:key];[self scheduleWakeup];return;}
            reference[@"identifiers"]=aliases;expiry=MIN(expiry,[previous[@"expires"] doubleValue]);
        }else if(previous){
            // Keep a bounded identity-only history; high-volume bursts keep the current reference until expiry.
            if(superseded.count+previousIDs.count>100)return;
            for(NSString *identifier in previousIDs)if(![superseded containsObject:identifier])[superseded addObject:identifier];
        }
        if(expiry>now && (self.stagedImages.count<10 || previous))self.stagedImages[key]=@{@"event":reference,@"expires":@(expiry),@"supersededIDs":superseded};
        [self scheduleWakeup];return;
    }
    CSAIReplyBatch *batch=nil;
    for(CSAIReplyBatch *candidate in self.pending)if([candidate.contextKey isEqual:key] && now<candidate.expires){batch=candidate;break;}
    if(!batch && self.pending.count>=20)return;
    if(image && batch.imageEvent)return; // One image per request bounds memory and upload cost.
    NSDictionary *attachedImage=image?event:nil;
    NSDictionary *staged=self.stagedImages[key];
    if(!image && !batch.imageEvent && [self.configuration[@"imageEnabled"] boolValue] && staged && now<[staged[@"expires"] doubleValue]){
        NSDictionary *candidate=staged[@"event"];BOOL handled=NO;
        for(NSString *identifier in candidate[@"identifiers"])if([self.store hasHandledMessageID:identifier]){handled=YES;break;}
        if(!handled)attachedImage=candidate;
    }
    [self.stagedImages removeObjectForKey:key];
    NSMutableArray *claims=[identifiers mutableCopy];
    if(attachedImage && !image)for(NSString *identifier in attachedImage[@"identifiers"])if(![claims containsObject:identifier])[claims addObject:identifier];
    // Claim every server/local alias durably before retaining text or starting any model work.
    if(![self.store claimMessageIDs:claims error:NULL]){[self cancelAll];return;}
    if(!batch){
        batch=[CSAIReplyBatch new];batch.conversation=conversation;batch.contextKey=key;batch.configuration=self.configuration;
        batch.preset=preset;batch.generation=self.generation;batch.expires=now+120;batch.text=@"";[self.pending addObject:batch];
    }
    if(attachedImage)batch.imageEvent=[attachedImage copy];
    if(text.length)batch.text=AITail(batch.text.length?[NSString stringWithFormat:@"%@\n%@",batch.text,text]:text,12000);
    batch.due=now+2;[self processPending];
}
- (void)finishBatch:(CSAIReplyBatch *)batch text:(NSString *)text error:(NSError *)error {
    AIRequireMain();
    if(self.active[batch.conversation]!=batch || batch.generation!=self.generation)return;
    if(![self isCurrent:batch]){[self cancelBatch:batch];[self clearContextsForConversation:batch.conversation];[self processPending];return;}
    batch.task=nil;
    NSString *reply=[text isKindOfClass:NSString.class]?[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]:nil;
    if(error || !reply.length || reply.length>4000){
        [self.active removeObjectForKey:batch.conversation];
        BOOL authentication=!batch.preparingImage && AIClientFailure(error) && (error.code==401 || error.code==403);
        [self record:batch result:@"failed" detail:AIFailureDetail(error,batch.preparingImage)];
        if(authentication){
            NSMutableDictionary *configuration=[self.store.configuration mutableCopy];configuration[@"verifiedConnection"]=@"";[configuration removeObjectForKey:@"verifiedAt"];
            [self.store saveConfiguration:configuration error:NULL];[self configurationDidChange];
        }
        [self processPending];return;
    }
    __weak typeof(self) weakSelf=self;
    BOOL (^valid)(void)=^BOOL {return [weakSelf isCurrent:batch];};
    if(!valid()){[self cancelBatch:batch];[self processPending];return;}
    NSString *result=[self.delegate coordinator:self submitText:reply conversation:batch.conversation valid:valid];
    // Submission may itself trigger configuration/account cancellation.
    if(self.active[batch.conversation]!=batch || batch.generation!=self.generation){[self processPending];return;}
    [self.active removeObjectForKey:batch.conversation];
    if([result isEqual:@"submitted"]){
        NSMutableArray *messages=[batch.messages mutableCopy];[messages addObject:@{@"role":@"assistant",@"content":reply}];
        self.contexts[batch.contextKey]=AIBoundedMessages(messages);
        [self record:batch result:@"submitted" detail:@"已提交，不代表送达"];
    }else if([result isEqual:@"unknown"]){
        [self record:batch result:@"unknown" detail:@"提交结果未知，不会重试"];
    }else [self record:batch result:@"failed" detail:@"未通过最终发送校验或提交失败"];
    [self processPending];
}
- (void)generateBatch:(CSAIReplyBatch *)batch imageURL:(NSString *)imageURL {
    if(![self isCurrent:batch]){[self cancelBatch:batch];[self clearContextsForConversation:batch.conversation];[self processPending];return;}
    batch.preparingImage=NO;
    batch.phase++;NSUInteger phase=batch.phase;
    NSError *error=nil;NSString *key=[self.delegate credentialForCoordinator:self error:&error];
    if(!key.length || error || ![self isCurrent:batch]){
        if(self.active[batch.conversation]==batch){[self cancelBatch:batch];[self record:batch result:@"failed" detail:@"凭据或当前会话状态不可用"];}
        [self processPending];return;
    }
    NSMutableArray *messages=[self.contexts[batch.contextKey] mutableCopy]?:[NSMutableArray array];
    NSString *input=batch.text.length?batch.text:@"请识别这张图片，并简洁回答。";
    [messages addObject:@{@"role":@"user",@"content":input}];batch.messages=AIBoundedMessages(messages);
    NSMutableArray *request=[NSMutableArray arrayWithObject:@{@"role":@"system",@"content":batch.preset[@"prompt"]}];[request addObjectsFromArray:batch.messages];
    if(imageURL.length){
        // Only this request owns the encoded image. Text contexts never retain or resend it.
        request[request.count-1]=@{@"role":@"user",@"content":@[@{@"type":@"image_url",@"image_url":@{@"url":imageURL}},@{@"type":@"text",@"text":input}]};
    }
    __weak typeof(self) weakSelf=self;
    id<CSAICancellable> task=[self.client generateWithConfiguration:batch.configuration apiKey:key messages:request completion:^(NSString *text,NSError *failure){
        if(NSThread.isMainThread)[weakSelf finishBatch:batch text:text error:failure];
        else dispatch_async(dispatch_get_main_queue(),^{[weakSelf finishBatch:batch text:text error:failure];});
    }];
    // A fake or preflight failure may complete inline; never attach that old task to a replacement.
    if(self.active[batch.conversation]==batch && batch.phase==phase)batch.task=task;else [task cancel];
}
- (void)startBatch:(CSAIReplyBatch *)batch {
    [self.pending removeObjectIdenticalTo:batch];
    // Preparation and generation share the same slot, deadline and cancellation owner.
    batch.started=self.now();self.active[batch.conversation]=batch;
    if(![self isCurrent:batch]){[self cancelBatch:batch];return;}
    if(!batch.imageEvent){[self generateBatch:batch imageURL:nil];return;}
    batch.preparingImage=YES;
    if(!self.imagePreparer){[self finishBatch:batch text:nil error:CSAIError(25,@"图片处理不可用")];return;}
    NSMutableDictionary *event=[batch.imageEvent mutableCopy];batch.imageEvent=nil;
    __weak typeof(self) weakSelf=self;__weak CSAIReplyBatch *weakBatch=batch;
    event[@"imageStillValid"]=[^BOOL{typeof(self) self=weakSelf;CSAIReplyBatch *live=weakBatch;return self && live && [self isCurrent:live];} copy];
    batch.phase++;NSUInteger phase=batch.phase;
    id<CSAICancellable> task=[self.imagePreparer prepareImageForEvent:event completion:^(NSString *dataURL,NSError *error){
        void (^complete)(void)=^{
            typeof(self) self=weakSelf;CSAIReplyBatch *live=weakBatch;
            if(!self || !live || self.active[live.conversation]!=live || live.phase!=phase)return;
            live.task=nil;
            if(![self isCurrent:live]){[self cancelBatch:live];[self processPending];return;}
            if(error || !dataURL.length){[self finishBatch:live text:nil error:error?:CSAIError(25,@"图片未就绪")];return;}
            [self generateBatch:live imageURL:dataURL];
        };
        if(NSThread.isMainThread)complete();else dispatch_async(dispatch_get_main_queue(),complete);
    }];
    if(self.active[batch.conversation]==batch && batch.phase==phase)batch.task=task;else [task cancel];
}
- (void)scheduleWakeup {
    [self.timer invalidate];self.timer=nil;
    NSTimeInterval now=self.now(),next=INFINITY;
    for(CSAIReplyBatch *batch in self.active.allValues)next=MIN(next,MIN(batch.expires,batch.started+60));
    for(NSDictionary *staged in self.stagedImages.allValues)next=MIN(next,[staged[@"expires"] doubleValue]);
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
    for(NSArray *key in self.stagedImages.allKeys)if(now>=[self.stagedImages[key][@"expires"] doubleValue])[self.stagedImages removeObjectForKey:key];
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
