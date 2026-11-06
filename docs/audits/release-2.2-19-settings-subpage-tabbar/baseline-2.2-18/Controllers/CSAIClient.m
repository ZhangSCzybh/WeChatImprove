#import "CSAIClient.h"
#import "CSAIReplyStore.h"

static NSUInteger const CSAIMaxResponseBytes=1024*1024;
static NSUInteger const CSAIMaxRequestBytes=4*1024*1024;
static NSUInteger const CSAIMaxImageBytes=2*1024*1024;
static NSUInteger const CSAIMaxSSELineBytes=128*1024;
static NSUInteger const CSAIMaxSSEEventBytes=256*1024;
static NSUInteger const CSAIMaxReplyCharacters=4000;

static NSError *SafeHTTPError(NSInteger status) {
    if(status==401 || status==403) return CSAIError(status,@"API Key 无效或没有访问权限");
    if(status==429) return CSAIError(status,@"请求过于频繁，请稍后再试");
    if(status>=300 && status<400) return CSAIError(status,@"请求地址发生重定向，请填写最终 HTTPS 地址");
    return CSAIError(status,@"AI 服务暂时不可用，请稍后再试");
}
static NSError *InvalidMessages(void) { return CSAIError(24,@"模型、API Key 或图文消息配置无效"); }
static NSError *InvalidResponse(void) { return CSAIError(23,@"AI 返回内容为空、格式无效、未完成或超过长度限制"); }
static BOOL ClientBoolean(id value) { return [value isKindOfClass:NSNumber.class] && ([value isEqual:@NO] || [value isEqual:@YES]); }

// Copy only the bounded, supported message shape. Expensive Base64 validation and JSON encoding run later off main.
static NSArray *SnapshotMessages(id messages, BOOL imageEnabled) {
    if(![messages isKindOfClass:NSArray.class] || ![messages count] || [messages count]>64) return nil;
    NSMutableArray *snapshot=[NSMutableArray arrayWithCapacity:[messages count]];
    NSUInteger images=0, textCharacters=0;
    for(id message in messages) {
        if(![message isKindOfClass:NSDictionary.class]) return nil;
        id role=message[@"role"], content=message[@"content"];
        if(![role isKindOfClass:NSString.class] || ![@[@"system",@"user",@"assistant"] containsObject:role]) return nil;
        if([content isKindOfClass:NSString.class]) {
            if([content length]>128*1024-textCharacters) return nil;
            textCharacters+=[content length]; content=[content copy];
        } else {
            if(![role isEqual:@"user"] || ![content isKindOfClass:NSArray.class] || ![content count] || [content count]>32) return nil;
            NSMutableArray *parts=[NSMutableArray arrayWithCapacity:[content count]];
            for(id part in content) {
                if(![part isKindOfClass:NSDictionary.class]) return nil;
                if([part[@"type"] isEqual:@"text"]) {
                    id text=part[@"text"];
                    if(![text isKindOfClass:NSString.class] || [text length]>128*1024-textCharacters) return nil;
                    textCharacters+=[text length]; [parts addObject:@{@"type":@"text",@"text":[text copy]}];
                } else if([part[@"type"] isEqual:@"image_url"]) {
                    id image=part[@"image_url"], url=[image isKindOfClass:NSDictionary.class]?image[@"url"]:nil;
                    if(!imageEnabled || ++images>1 || ![url isKindOfClass:NSString.class] || [url length]>((CSAIMaxImageBytes+2)/3)*4+23 || (![url hasPrefix:@"data:image/jpeg;base64,"] && ![url hasPrefix:@"data:image/png;base64,"])) return nil;
                    [parts addObject:@{@"type":@"image_url",@"image_url":@{@"url":[url copy]}}];
                } else return nil;
            }
            content=[parts copy];
        }
        [snapshot addObject:@{@"role":[role copy],@"content":content}];
    }
    return [snapshot copy];
}
static BOOL ValidateImages(NSArray *messages) {
    for(NSDictionary *message in messages) {
        id parts=message[@"content"]; if(![parts isKindOfClass:NSArray.class]) continue;
        for(NSDictionary *part in parts) {
            if(![part[@"type"] isEqual:@"image_url"]) continue;
            NSString *url=part[@"image_url"][@"url"];
            BOOL png=[url hasPrefix:@"data:image/png;base64,"];
            NSString *encoded=[url substringFromIndex:png?22:23];
            if(!encoded.length || encoded.length%4) return NO;
            NSData *data=[[NSData alloc] initWithBase64EncodedString:encoded options:0];
            if(!data.length || data.length>CSAIMaxImageBytes || ![[data base64EncodedStringWithOptions:0] isEqual:encoded]) return NO;
            const unsigned char *bytes=data.bytes;
            static const unsigned char pngSignature[]={137,80,78,71,13,10,26,10};
            if(png ? (data.length<sizeof(pngSignature) || memcmp(bytes,pngSignature,sizeof(pngSignature))!=0) : (data.length<3 || bytes[0]!=0xff || bytes[1]!=0xd8 || bytes[2]!=0xff)) return NO;
        }
    }
    return YES;
}

@interface CSAIRequest : NSObject <CSAICancellable,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
@property(nonatomic,strong) NSURLSession *session;
@property(nonatomic,strong) NSURLSessionDataTask *task;
@property(nonatomic,strong) NSMutableData *data;
@property(nonatomic,copy) CSAICompletion completion;
@property(nonatomic) BOOL finished;
@property(nonatomic) BOOL cancelled;
@property(nonatomic) BOOL streaming;
@property(nonatomic) NSUInteger receivedBytes;
@property(nonatomic) NSUInteger scanOffset;
@property(nonatomic) NSUInteger eventBytes;
@property(nonatomic,strong) NSMutableString *eventData;
@property(nonatomic,copy) NSString *eventName;
@property(nonatomic,strong) NSMutableString *reply;
@property(nonatomic) BOOL skipLF;
@property(nonatomic) BOOL sawStop;
@property(nonatomic) BOOL sawDone;
- (void)finish:(NSString *)text error:(NSError *)error;
@end
@implementation CSAIRequest
- (void)finish:(NSString *)text error:(NSError *)error {
    @synchronized(self) { if(self.finished) return; self.finished=YES; }
    [self.session invalidateAndCancel];
    dispatch_async(dispatch_get_main_queue(), ^{
        CSAICompletion completion;
        BOOL cancelled;
        @synchronized(self) { completion=self.completion; self.completion=nil; cancelled=self.cancelled; }
        if(completion) completion(cancelled?nil:text,cancelled?CSAIError(NSURLErrorCancelled,@"请求已取消"):error);
    });
}
- (void)cancel { @synchronized(self) { self.cancelled=YES; [self.task cancel]; [self finish:nil error:CSAIError(NSURLErrorCancelled,@"请求已取消")]; } }
- (BOOL)consumeEvent {
    if([self.eventName isEqual:@"error"]) { [self finish:nil error:CSAIError(25,@"AI 服务返回错误，请稍后再试")]; return NO; }
    if(!self.eventData.length) { self.eventName=nil; return YES; }
    NSString *event=[self.eventData copy]; [self.eventData setString:@""]; self.eventBytes=0; self.eventName=nil;
    if([event isEqual:@"[DONE]"]) { self.sawDone=YES; return YES; }
    id body=[NSJSONSerialization JSONObjectWithData:[event dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    if(![body isKindOfClass:NSDictionary.class]) { [self finish:nil error:InvalidResponse()]; return NO; }
    if(body[@"error"] && body[@"error"]!=NSNull.null) { [self finish:nil error:CSAIError(25,@"AI 服务返回错误，请稍后再试")]; return NO; }
    id choices=body[@"choices"];
    if(![choices isKindOfClass:NSArray.class]) { [self finish:nil error:InvalidResponse()]; return NO; }
    if(![choices count]) { if([body[@"usage"] isKindOfClass:NSDictionary.class]) return YES; [self finish:nil error:InvalidResponse()]; return NO; }
    id choice=[choices firstObject], delta=[choice isKindOfClass:NSDictionary.class]?choice[@"delta"]:nil;
    if(![choice isKindOfClass:NSDictionary.class] || (delta && ![delta isKindOfClass:NSDictionary.class])) { [self finish:nil error:InvalidResponse()]; return NO; }
    id text=delta[@"content"];
    if(text && text!=NSNull.null) {
        if(![text isKindOfClass:NSString.class] || ((self.sawStop || self.sawDone) && [text length]) || [text length]>CSAIMaxReplyCharacters-self.reply.length) { [self finish:nil error:InvalidResponse()]; return NO; }
        [self.reply appendString:text];
    }
    id reason=choice[@"finish_reason"];
    if(reason && reason!=NSNull.null) {
        if(![reason isEqual:@"stop"]) { [self finish:nil error:InvalidResponse()]; return NO; }
        self.sawStop=YES;
    }
    return YES;
}
- (BOOL)consumeLine:(NSData *)data {
    if(data.length>CSAIMaxSSELineBytes) { [self finish:nil error:CSAIError(21,@"AI 响应过大")]; return NO; }
    NSString *line=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if(!line) { [self finish:nil error:InvalidResponse()]; return NO; }
    if(!line.length) return [self consumeEvent];
    if([line hasPrefix:@":"]) return YES;
    NSRange colon=[line rangeOfString:@":"];
    NSString *field=colon.location==NSNotFound?line:[line substringToIndex:colon.location];
    NSString *value=colon.location==NSNotFound?@"":[line substringFromIndex:colon.location+1];
    if([value hasPrefix:@" "]) value=[value substringFromIndex:1];
    if([field isEqual:@"data"]) {
        NSUInteger length=[value lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        NSUInteger existing=self.eventBytes, separator=self.eventData.length?1:0;
        if(length>CSAIMaxSSEEventBytes || separator>CSAIMaxSSEEventBytes-length || existing>CSAIMaxSSEEventBytes-length-separator) { [self finish:nil error:CSAIError(21,@"AI 响应过大")]; return NO; }
        if(self.eventData.length) [self.eventData appendString:@"\n"]; [self.eventData appendString:value]; self.eventBytes+=length+separator;
    } else if([field isEqual:@"event"]) self.eventName=value;
    return YES;
}
- (BOOL)consumeStreamBytes:(NSData *)data {
    [self.data appendData:data];
    const unsigned char *bytes=self.data.bytes; NSUInteger start=0;
    for(NSUInteger i=self.scanOffset;i<self.data.length;i++) {
        if(self.skipLF) { self.skipLF=NO; if(bytes[i]=='\n') { start=i+1; continue; } }
        if(bytes[i]!='\r' && bytes[i]!='\n') continue;
        NSData *line=[self.data subdataWithRange:NSMakeRange(start,i-start)];
        self.skipLF=(bytes[i]=='\r'); start=i+1;
        if(![self consumeLine:line]) return NO;
    }
    if(start) [self.data replaceBytesInRange:NSMakeRange(0,start) withBytes:NULL length:0];
    self.scanOffset=self.data.length;
    if(self.data.length>CSAIMaxSSELineBytes) { [self finish:nil error:CSAIError(21,@"AI 响应过大")]; return NO; }
    return YES;
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)task didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    (void)session; (void)task;
    @synchronized(self) {
        if(self.finished) { completionHandler(NSURLSessionResponseCancel); return; }
        if(![response isKindOfClass:NSHTTPURLResponse.class]) { completionHandler(NSURLSessionResponseCancel); [self finish:nil error:CSAIError(20,@"AI 响应格式无效")]; return; }
        NSInteger status=((NSHTTPURLResponse *)response).statusCode;
        if(status<200 || status>=300) { completionHandler(NSURLSessionResponseCancel); [self finish:nil error:SafeHTTPError(status)]; return; }
        if(response.expectedContentLength>(int64_t)CSAIMaxResponseBytes) { completionHandler(NSURLSessionResponseCancel); [self finish:nil error:CSAIError(21,@"AI 响应过大")]; return; }
        completionHandler(NSURLSessionResponseAllow);
    }
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)task didReceiveData:(NSData *)data {
    (void)session; (void)task;
    @synchronized(self) {
        if(self.finished) return;
        if(data.length>CSAIMaxResponseBytes-self.receivedBytes) { [self finish:nil error:CSAIError(21,@"AI 响应过大")]; return; }
        self.receivedBytes+=data.length;
        if(self.streaming) [self consumeStreamBytes:data]; else [self.data appendData:data];
    }
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler {
    (void)session; (void)task; (void)request; completionHandler(nil); [self finish:nil error:SafeHTTPError(response.statusCode)];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    (void)session; (void)task;
    @synchronized(self) {
        if(self.finished) return;
        if(error) { [self finish:nil error:CSAIError(error.code==NSURLErrorTimedOut?NSURLErrorTimedOut:22,error.code==NSURLErrorTimedOut?@"AI 请求超时，请稍后再试":@"网络请求失败，请检查连接")]; return; }
        NSString *text;
        if(self.streaming) {
            if(self.data.length && ![self consumeLine:self.data]) return;
            [self.data setLength:0]; if(![self consumeEvent]) return;
            if(!self.sawStop && !self.sawDone) { [self finish:nil error:InvalidResponse()]; return; }
            text=self.reply;
        } else {
            id body=[NSJSONSerialization JSONObjectWithData:self.data options:0 error:NULL];
            id choices=[body isKindOfClass:NSDictionary.class]?body[@"choices"]:nil;
            id choice=[choices isKindOfClass:NSArray.class] && [choices count]?[choices firstObject]:nil;
            id message=[choice isKindOfClass:NSDictionary.class]?choice[@"message"]:nil;
            text=[message isKindOfClass:NSDictionary.class]?message[@"content"]:nil;
        }
        NSString *trimmed=[text isKindOfClass:NSString.class]?[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]:nil;
        if(!trimmed.length || trimmed.length>CSAIMaxReplyCharacters) { [self finish:nil error:InvalidResponse()]; return; }
        [self finish:trimmed error:nil];
    }
}
@end
@interface CSAIClient ()
@property(nonatomic,strong) NSURLSessionConfiguration *configuration;
@end
@implementation CSAIClient
- (instancetype)init { return [self initWithSessionConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration]; }
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration { if((self=[super init])) _configuration=[configuration copy]; return self; }
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)configuration apiKey:(NSString *)apiKey messages:(NSArray<NSDictionary *> *)messages completion:(CSAICompletion)completion {
    CSAIRequest *operation=[CSAIRequest new]; operation.completion=completion; operation.data=[NSMutableData data]; operation.eventData=[NSMutableString string]; operation.reply=[NSMutableString string];
    if(![configuration isKindOfClass:NSDictionary.class]) { [operation finish:nil error:InvalidMessages()]; return operation; }
    id provider=configuration[@"provider"]?:@"openai-compatible", searchMode=configuration[@"searchMode"]?:@"off", imageEnabled=configuration[@"imageEnabled"]?:@NO, thinkingEnabled=configuration[@"thinkingEnabled"]?:@NO;
    id endpoint=configuration[@"endpoint"], model=configuration[@"model"];
    BOOL bailian=[provider isEqual:@"bailian"];
    if(![@[@"openai-compatible",@"bailian"] containsObject:provider] || ![@[@"off",@"auto",@"always"] containsObject:searchMode] || (!bailian && ![searchMode isEqual:@"off"]) || !ClientBoolean(imageEnabled) || !ClientBoolean(thinkingEnabled) || (!bailian && [thinkingEnabled boolValue]) || ![endpoint isKindOfClass:NSString.class] || ![model isKindOfClass:NSString.class] || ![model stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length || [model length]>200 || ![apiKey isKindOfClass:NSString.class] || !apiKey.length || apiKey.length>16384 || [apiKey rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location!=NSNotFound) { [operation finish:nil error:InvalidMessages()]; return operation; }
    NSArray *snapshot=SnapshotMessages(messages,[imageEnabled boolValue]);
    if(!snapshot) { [operation finish:nil error:InvalidMessages()]; return operation; }
    NSString *url=[endpoint copy], *modelName=[model copy], *secret=[apiKey copy], *mode=[searchMode copy]; BOOL thinking=[thinkingEnabled boolValue];
    NSURLSessionConfiguration *sessionConfig=[self.configuration copy];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY,0), ^{
        @synchronized(operation) { if(operation.finished || operation.cancelled) return; }
        NSError *error=nil;
        if(!CSAIValidateEndpoint(url,&error)) { [operation finish:nil error:error]; return; }
        if(!ValidateImages(snapshot)) { [operation finish:nil error:InvalidMessages()]; return; }
        NSMutableDictionary *payload=[@{@"model":modelName,@"messages":snapshot,@"stream":@(bailian)} mutableCopy];
        if(bailian) {
            payload[@"enable_thinking"]=@(thinking); payload[@"enable_search"]=@(![mode isEqual:@"off"]);
            if(![mode isEqual:@"off"]) payload[@"search_options"]=@{@"search_strategy":@"turbo",@"forced_search":@([mode isEqual:@"always"])};
        }
        NSData *body=[NSJSONSerialization dataWithJSONObject:payload options:0 error:NULL];
        if(!body || body.length>CSAIMaxRequestBytes) { [operation finish:nil error:InvalidMessages()]; return; }
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60]; request.HTTPMethod=@"POST"; request.HTTPBody=body; request.HTTPShouldHandleCookies=NO;
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; [request setValue:bailian?@"text/event-stream":@"application/json" forHTTPHeaderField:@"Accept"]; [request setValue:[@"Bearer " stringByAppendingString:secret] forHTTPHeaderField:@"Authorization"];
        sessionConfig.URLCache=nil; sessionConfig.HTTPCookieStorage=nil; sessionConfig.HTTPShouldSetCookies=NO; sessionConfig.URLCredentialStorage=nil; sessionConfig.requestCachePolicy=NSURLRequestReloadIgnoringLocalCacheData; sessionConfig.timeoutIntervalForRequest=60; sessionConfig.timeoutIntervalForResource=60; sessionConfig.HTTPAdditionalHeaders=@{};
        @synchronized(operation) {
            if(operation.finished || operation.cancelled) return;
            operation.streaming=bailian; operation.session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:operation delegateQueue:nil]; operation.task=[operation.session dataTaskWithRequest:request]; [operation.task resume];
        }
    });
    return operation;
}
@end
