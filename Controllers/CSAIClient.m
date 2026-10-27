#import "CSAIClient.h"
#import "CSAIReplyStore.h"
static NSUInteger const CSAIMaxResponseBytes=1024*1024;
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
@property(nonatomic,copy) CSAICompletion completion;
@property(nonatomic) BOOL finished;
@property(nonatomic) BOOL cancelled;
- (void)finish:(NSString *)text error:(NSError *)error;
@end
@implementation CSAIRequest
- (void)finish:(NSString *)text error:(NSError *)error {
    @synchronized(self) { if(self.finished) return; self.finished=YES; }
    [self.session finishTasksAndInvalidate];
    dispatch_async(dispatch_get_main_queue(), ^{
        CSAICompletion completion;
        BOOL cancelled;
        @synchronized(self) { completion=self.completion; self.completion=nil; cancelled=self.cancelled; }
        if(completion) completion(cancelled?nil:text,cancelled?CSAIError(NSURLErrorCancelled,@"请求已取消"):error);
    });
}
- (void)cancel { @synchronized(self) { self.cancelled=YES; } [self.task cancel]; [self finish:nil error:CSAIError(NSURLErrorCancelled,@"请求已取消")]; }
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)task didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    (void)session; (void)task;
    if(![response isKindOfClass:NSHTTPURLResponse.class]) { completionHandler(NSURLSessionResponseCancel); [self finish:nil error:CSAIError(20,@"AI 响应格式无效")]; return; }
    NSInteger status=((NSHTTPURLResponse *)response).statusCode;
    if(status<200 || status>=300) { completionHandler(NSURLSessionResponseCancel); [self finish:nil error:SafeHTTPError(status)]; return; }
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
    id body=[NSJSONSerialization JSONObjectWithData:self.data options:0 error:NULL];
    id choices=[body isKindOfClass:NSDictionary.class]?body[@"choices"]:nil;
    id choice=[choices isKindOfClass:NSArray.class] && [choices count]?[choices firstObject]:nil;
    id message=[choice isKindOfClass:NSDictionary.class]?choice[@"message"]:nil;
    id text=[message isKindOfClass:NSDictionary.class]?message[@"content"]:nil;
    NSString *trimmed=[text isKindOfClass:NSString.class]?[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]:nil;
    if(!trimmed.length || trimmed.length>4000) { [self finish:nil error:CSAIError(23,@"AI 返回内容为空、格式无效或超过长度限制")]; return; }
    [self finish:trimmed error:nil];
}
@end
@interface CSAIClient ()
@property(nonatomic,strong) NSURLSessionConfiguration *configuration;
@end
@implementation CSAIClient
- (instancetype)init { return [self initWithSessionConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration]; }
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration { if((self=[super init])) _configuration=[configuration copy]; return self; }
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)configuration apiKey:(NSString *)apiKey messages:(NSArray<NSDictionary *> *)messages completion:(CSAICompletion)completion {
    CSAIRequest *operation=[CSAIRequest new]; operation.completion=completion; operation.data=[NSMutableData data];
    NSError *error=nil; NSString *model=configuration[@"model"];
    if(!CSAIValidateEndpoint(configuration[@"endpoint"],&error)) { [operation finish:nil error:error]; return operation; }
    if(![model isKindOfClass:NSString.class] || ![model stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length || model.length>200 || ![apiKey isKindOfClass:NSString.class] || !apiKey.length || apiKey.length>16384 || [apiKey rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location!=NSNotFound || ![messages isKindOfClass:NSArray.class] || !messages.count) { [operation finish:nil error:CSAIError(24,@"模型、API Key 或消息配置无效")]; return operation; }
    for(id message in messages) { if(![message isKindOfClass:NSDictionary.class] || ![@[@"system",@"user",@"assistant"] containsObject:message[@"role"]] || ![message[@"content"] isKindOfClass:NSString.class]) { [operation finish:nil error:CSAIError(24,@"消息配置无效")]; return operation; } }
    NSData *body=[NSJSONSerialization dataWithJSONObject:@{@"model":model,@"messages":messages,@"stream":@NO} options:0 error:NULL];
    if(!body) { [operation finish:nil error:CSAIError(24,@"消息配置无效")]; return operation; }
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:configuration[@"endpoint"]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60]; request.HTTPMethod=@"POST"; request.HTTPBody=body; request.HTTPShouldHandleCookies=NO;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; [request setValue:@"application/json" forHTTPHeaderField:@"Accept"]; [request setValue:[@"Bearer " stringByAppendingString:apiKey] forHTTPHeaderField:@"Authorization"];
    NSURLSessionConfiguration *sessionConfig=[self.configuration copy]; sessionConfig.URLCache=nil; sessionConfig.HTTPCookieStorage=nil; sessionConfig.HTTPShouldSetCookies=NO; sessionConfig.URLCredentialStorage=nil; sessionConfig.requestCachePolicy=NSURLRequestReloadIgnoringLocalCacheData; sessionConfig.timeoutIntervalForRequest=60; sessionConfig.timeoutIntervalForResource=60; sessionConfig.HTTPAdditionalHeaders=@{};
    operation.session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:operation delegateQueue:nil]; operation.task=[operation.session dataTaskWithRequest:request]; [operation.task resume]; return operation;
}
@end
