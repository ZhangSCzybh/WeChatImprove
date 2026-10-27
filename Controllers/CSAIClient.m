#import "CSAIClient.h"
#import "CSAIReplyStore.h"
static NSUInteger const CSAIMaxResponseBytes=1024*1024;
static NSDictionary *AIDictionary(id value) { return [value isKindOfClass:NSDictionary.class]?value:@{}; }
static NSDictionary *AIUsage(NSDictionary *body,BOOL responses) {
    NSDictionary *usage=AIDictionary(body[@"usage"]),*input=AIDictionary(usage[responses?@"input_tokens_details":@"prompt_tokens_details"]);
    NSDictionary *output=AIDictionary(usage[responses?@"output_tokens_details":@"completion_tokens_details"]);
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    NSArray *pairs=@[@[@"inputTokens",usage[responses?@"input_tokens":@"prompt_tokens"]?:NSNull.null],
        @[@"outputTokens",usage[responses?@"output_tokens":@"completion_tokens"]?:NSNull.null],
        @[@"cachedTokens",input[@"cached_tokens"]?:NSNull.null],
        @[@"cacheCreationTokens",input[@"cache_creation_input_tokens"]?:NSNull.null],
        @[@"reasoningTokens",output[@"reasoning_tokens"]?:NSNull.null]];
    for(NSArray *pair in pairs)if(CSAIReplyValidateUsage(@{pair[0]:pair[1]}))result[pair[0]]=pair[1];
    // Bailian reports Session cache creation in x_details on some deployments.
    id details=usage[@"x_details"];
    if(responses && !result[@"cacheCreationTokens"] && [details isKindOfClass:NSArray.class]){
        unsigned long long total=0;BOOL found=NO;
        for(id item in details){id value=AIDictionary(AIDictionary(item)[@"input_tokens_details"])[@"cache_creation_input_tokens"];
            if(value && CSAIReplyValidateUsage(@{@"cacheCreationTokens":value})){found=YES;total+=[value unsignedLongLongValue];}}
        if(found && total<=1000000000000ULL)result[@"cacheCreationTokens"]=@(total);
    }
    if(!CSAIReplyValidateUsage(result))[result removeObjectForKey:@"cachedTokens"];
    return result;
}
static BOOL AIResponseID(id value) {
    return [value isKindOfClass:NSString.class] && [value length]>0 && [value length]<=512 && [value rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location==NSNotFound;
}
static NSError *SafeHTTPError(NSInteger status) {
    if(status==401 || status==403) return CSAIError(status,@"API Key 无效或没有访问权限");
    if(status==429) return CSAIError(status,@"请求过于频繁，请稍后再试");
    if(status>=300 && status<400) return CSAIError(status,@"请求地址发生重定向，请填写最终 HTTPS 地址");
    return CSAIError(status,@"AI 服务暂时不可用，请稍后再试");
}
@interface CSAIRequest : NSObject <CSAICancellable,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
@property(nonatomic,strong) NSURLSession *session;
@property(nonatomic,strong) NSURLSessionDataTask *task;
@property(nonatomic,strong) NSMutableData *data;
@property(nonatomic,copy) CSAIResultCompletion completion;
@property(nonatomic) BOOL finished;
@property(nonatomic) BOOL cancelled;
@property(nonatomic) BOOL responses;
@property(nonatomic) BOOL continuing;
@property(nonatomic) NSInteger status;
- (void)finish:(NSDictionary *)result error:(NSError *)error;
@end
@implementation CSAIRequest
- (void)finish:(NSDictionary *)result error:(NSError *)error {
    @synchronized(self) { if(self.finished) return; self.finished=YES; }
    [self.session finishTasksAndInvalidate];
    dispatch_async(dispatch_get_main_queue(), ^{
        CSAIResultCompletion completion;
        BOOL cancelled;
        @synchronized(self) { completion=self.completion; self.completion=nil; cancelled=self.cancelled; }
        if(completion) completion(cancelled?nil:result,cancelled?CSAIError(NSURLErrorCancelled,@"请求已取消"):error);
    });
}
- (void)cancel { @synchronized(self) { self.cancelled=YES; } [self.task cancel]; [self finish:nil error:CSAIError(NSURLErrorCancelled,@"请求已取消")]; }
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)task didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    (void)session; (void)task;
    if(![response isKindOfClass:NSHTTPURLResponse.class]) { completionHandler(NSURLSessionResponseCancel); [self finish:nil error:CSAIError(20,@"AI 响应格式无效")]; return; }
    NSInteger status=((NSHTTPURLResponse *)response).statusCode;
    self.status=status;
    // Only a rejected reference can safely restart a Responses chain. Read its
    // bounded error body; never retry transport failures or arbitrary HTTP errors.
    if((status<200 || status>=300) && !(self.continuing && (status==400 || status==404 || status==410))) { completionHandler(NSURLSessionResponseCancel); [self finish:nil error:SafeHTTPError(status)]; return; }
    if(response.expectedContentLength>(int64_t)CSAIMaxResponseBytes) { completionHandler(NSURLSessionResponseCancel); [self finish:nil error:CSAIError(21,@"AI 响应过大")]; return; }
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)task didReceiveData:(NSData *)data {
    (void)session; (void)task;
    @synchronized(self) { if(self.finished) return; if(data.length>CSAIMaxResponseBytes-self.data.length) { [self.task cancel]; [self finish:nil error:CSAIError(21,@"AI 响应过大")]; return; } [self.data appendData:data]; }
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler {
    (void)session; (void)task; (void)request; completionHandler(nil); [self finish:nil error:SafeHTTPError(response.statusCode)];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    (void)session; (void)task;
    if(error) { [self finish:nil error:CSAIError(error.code==NSURLErrorTimedOut?NSURLErrorTimedOut:22,error.code==NSURLErrorTimedOut?@"AI 请求超时，请稍后再试":@"网络请求失败，请检查连接")]; return; }
    NSDictionary *body=AIDictionary([NSJSONSerialization JSONObjectWithData:self.data options:0 error:NULL]);
    if(self.status<200 || self.status>=300){
        NSDictionary *failure=AIDictionary(body[@"error"]);
        BOOL reference=[failure[@"param"] isEqual:@"previous_response_id"] || [@[@"previous_response_not_found",@"invalid_previous_response_id",@"response_not_found"] containsObject:failure[@"code"]?:@""];
        [self finish:nil error:reference?CSAIError(CSAIResponseReferenceExpired,@"会话引用已失效"):SafeHTTPError(self.status)];return;
    }
    NSMutableDictionary *result=[NSMutableDictionary dictionary];NSDictionary *usage=AIUsage(body,self.responses);if(usage.count)result[@"usage"]=usage;
    id text=nil;
    if(self.responses){
        if([body[@"status"] isEqual:@"completed"] && AIResponseID(body[@"id"]) && [body[@"output"] isKindOfClass:NSArray.class]){
            NSMutableArray *parts=[NSMutableArray array];
            for(id item in body[@"output"]){NSDictionary *message=AIDictionary(item);
                if(![message[@"type"] isEqual:@"message"] || ![message[@"role"] isEqual:@"assistant"] || ![message[@"content"] isKindOfClass:NSArray.class])continue;
                for(id content in message[@"content"]){NSDictionary *part=AIDictionary(content);if([part[@"type"] isEqual:@"output_text"] && [part[@"text"] isKindOfClass:NSString.class])[parts addObject:part[@"text"]];}
            }
            text=[parts componentsJoinedByString:@"\n"];result[@"responseID"]=body[@"id"];
        }
    }else{
        id choices=body[@"choices"];
        NSDictionary *choice=AIDictionary([choices isKindOfClass:NSArray.class] && [choices count]?[choices firstObject]:nil);
        text=AIDictionary(choice[@"message"])[@"content"];
    }
    NSString *trimmed=[text isKindOfClass:NSString.class]?[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]:nil;
    if(!trimmed.length || trimmed.length>4000) { [self finish:result error:CSAIError(23,@"AI 返回内容为空、格式无效或超过长度限制")]; return; }
    result[@"text"]=trimmed;[self finish:result error:nil];
}
@end
@interface CSAIClient ()
@property(nonatomic,strong) NSURLSessionConfiguration *configuration;
@end
@implementation CSAIClient
- (instancetype)init { return [self initWithSessionConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration]; }
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration { if((self=[super init])) _configuration=[configuration copy]; return self; }
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)configuration apiKey:(NSString *)apiKey messages:(NSArray<NSDictionary *> *)messages completion:(CSAICompletion)completion {
    return [self generateWithConfiguration:configuration apiKey:apiKey messages:messages previousResponseID:nil completion:^(NSDictionary *result,NSError *error){completion(error?nil:result[@"text"],error);}];
}
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)configuration apiKey:(NSString *)apiKey messages:(NSArray<NSDictionary *> *)messages previousResponseID:(NSString *)previousResponseID completion:(CSAIResultCompletion)completion {
    CSAIRequest *operation=[CSAIRequest new]; operation.completion=completion; operation.data=[NSMutableData data];
    operation.responses=CSAIReplyUsesResponses(configuration);operation.continuing=operation.responses && previousResponseID.length;
    NSError *error=nil; NSString *model=configuration[@"model"];
    if(!CSAIValidateEndpoint(configuration[@"endpoint"],&error)) { [operation finish:nil error:error]; return operation; }
    if(configuration[@"mode"] && ![@[@"chat",@"bailianResponses"] containsObject:configuration[@"mode"]]){[operation finish:nil error:CSAIError(24,@"调用方式无效")];return operation;}
    if(![model isKindOfClass:NSString.class] || ![model stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length || model.length>200 || ![apiKey isKindOfClass:NSString.class] || !apiKey.length || apiKey.length>16384 || [apiKey rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location!=NSNotFound || ![messages isKindOfClass:NSArray.class] || !messages.count) { [operation finish:nil error:CSAIError(24,@"模型、API Key 或消息配置无效")]; return operation; }
    for(id message in messages) { if(![message isKindOfClass:NSDictionary.class] || ![@[@"system",@"user",@"assistant"] containsObject:message[@"role"]] || ![message[@"content"] isKindOfClass:NSString.class]) { [operation finish:nil error:CSAIError(24,@"消息配置无效")]; return operation; } }
    NSMutableDictionary *payload=[@{@"model":model,@"stream":@NO} mutableCopy];
    if(operation.responses){
        if(![[NSURL URLWithString:configuration[@"endpoint"]].path hasSuffix:@"/responses"] || (previousResponseID && !AIResponseID(previousResponseID))){[operation finish:nil error:CSAIError(24,@"百炼会话模式需要完整的 Responses 地址")];return operation;}
        if(operation.continuing && ![messages.lastObject[@"role"] isEqual:@"user"]){[operation finish:nil error:CSAIError(24,@"会话续接消息无效")];return operation;}
        payload[@"input"]=operation.continuing?@[messages.lastObject]:messages;payload[@"store"]=@YES;
        if(operation.continuing)payload[@"previous_response_id"]=previousResponseID;
    }else payload[@"messages"]=messages;
    NSData *body=[NSJSONSerialization dataWithJSONObject:payload options:0 error:NULL];
    if(!body) { [operation finish:nil error:CSAIError(24,@"消息配置无效")]; return operation; }
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:configuration[@"endpoint"]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60]; request.HTTPMethod=@"POST"; request.HTTPBody=body; request.HTTPShouldHandleCookies=NO;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; [request setValue:@"application/json" forHTTPHeaderField:@"Accept"]; [request setValue:[@"Bearer " stringByAppendingString:apiKey] forHTTPHeaderField:@"Authorization"];
    if(operation.responses && [configuration[@"sessionCache"] boolValue])[request setValue:@"enable" forHTTPHeaderField:@"x-dashscope-session-cache"];
    NSURLSessionConfiguration *sessionConfig=[self.configuration copy]; sessionConfig.URLCache=nil; sessionConfig.HTTPCookieStorage=nil; sessionConfig.HTTPShouldSetCookies=NO; sessionConfig.URLCredentialStorage=nil; sessionConfig.requestCachePolicy=NSURLRequestReloadIgnoringLocalCacheData; sessionConfig.timeoutIntervalForRequest=60; sessionConfig.timeoutIntervalForResource=60; sessionConfig.HTTPAdditionalHeaders=@{};
    operation.session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:operation delegateQueue:nil]; operation.task=[operation.session dataTaskWithRequest:request]; [operation.task resume]; return operation;
}
@end
