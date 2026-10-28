#import <Foundation/Foundation.h>
#import "CSAIClient.h"
#import "CSAIReplyStore.h"
#import "CSAICredentialStore.h"
#import <Security/Security.h>
#define CHECK(...) do { if(!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while(0)
// Link-time Security fakes guarantee these tests never access the real Keychain.
static NSMutableDictionary *FakeSecrets;
static NSDictionary *LastKeychainQuery;
OSStatus SecItemAdd(CFDictionaryRef attributes, CFTypeRef *result) {
    (void)result; NSDictionary *query=(__bridge NSDictionary *)attributes; LastKeychainQuery=query;
    NSString *slot=query[(__bridge id)kSecAttrAccount]; if(FakeSecrets[slot]) return errSecDuplicateItem;
    FakeSecrets[slot]=query[(__bridge id)kSecValueData]; return errSecSuccess;
}
OSStatus SecItemCopyMatching(CFDictionaryRef queryRef, CFTypeRef *result) {
    NSDictionary *query=(__bridge NSDictionary *)queryRef; LastKeychainQuery=query;
    NSData *data=FakeSecrets[query[(__bridge id)kSecAttrAccount]]; if(!data) return errSecItemNotFound;
    if(result) *result=CFBridgingRetain(data); return errSecSuccess;
}
OSStatus SecItemDelete(CFDictionaryRef queryRef) {
    NSDictionary *query=(__bridge NSDictionary *)queryRef; LastKeychainQuery=query;
    [FakeSecrets removeObjectForKey:query[(__bridge id)kSecAttrAccount]]; return errSecSuccess;
}
static NSString *Scenario;
static NSURLRequest *Captured;
static NSUInteger Requests;
static NSData *SSEData;
static NSUInteger SSEFragmentSize;
static BOOL SSEHold, SSEFailAfterData;
@interface AIFakeProtocol : NSURLProtocol
@end
static AIFakeProtocol *PendingStream;
@implementation AIFakeProtocol
+ (BOOL)canInitWithRequest:(NSURLRequest *)request { (void)request; return YES; }
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request { return request; }
- (void)startLoading {
    Captured=self.request; Requests++;
    NSString *scenario=Scenario;
    if([scenario isEqual:@"delayed"]) return;
    if([scenario isEqual:@"timeout"]) { [self.client URLProtocol:self didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:@{NSLocalizedDescriptionKey:@"secret upstream error"}]]; return; }
    NSInteger status=200; if([scenario isEqual:@"401"]) status=401; if([scenario isEqual:@"429"]) status=429; if([scenario isEqual:@"500"]) status=500; if([scenario isEqual:@"redirect"]) status=302;
    NSDictionary *headers=[scenario isEqual:@"declared-bound"]?@{@"Content-Length":@"1048577"}:([scenario isEqual:@"sse"]?@{@"Content-Type":@"text/event-stream"}:@{});
    NSHTTPURLResponse *response=[[NSHTTPURLResponse alloc] initWithURL:self.request.URL statusCode:status HTTPVersion:@"HTTP/1.1" headerFields:headers];
    if([scenario isEqual:@"redirect"]) {
        NSMutableURLRequest *redirect=[self.request mutableCopy]; redirect.URL=[NSURL URLWithString:@"https://other.invalid/never-follow"];
        [self.client URLProtocol:self wasRedirectedToRequest:redirect redirectResponse:response]; return;
    }
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    if([scenario isEqual:@"sse"]) {
        NSUInteger size=SSEFragmentSize?:SSEData.length;
        for(NSUInteger offset=0;offset<SSEData.length;offset+=size) [self.client URLProtocol:self didLoadData:[SSEData subdataWithRange:NSMakeRange(offset,MIN(size,SSEData.length-offset))]];
        if(SSEHold) { PendingStream=self; return; }
        if(SSEFailAfterData) [self.client URLProtocol:self didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:@{NSLocalizedDescriptionKey:@"secret upstream error"}]];
        else [self.client URLProtocolDidFinishLoading:self];
        return;
    }
    NSData *data;
    if([scenario isEqual:@"malformed"]) data=[@"not JSON secret" dataUsingEncoding:NSUTF8StringEncoding];
    else if([scenario isEqual:@"empty"]) data=[NSJSONSerialization dataWithJSONObject:@{@"choices":@[@{@"message":@{@"content":@"  "}}]} options:0 error:NULL];
    else if([scenario isEqual:@"stream-bound"]) data=[NSMutableData dataWithLength:1048577];
    else { NSString *content=[scenario isEqual:@"output-bound"]?[@"x" stringByPaddingToLength:4001 withString:@"x" startingAtIndex:0]:@"  你好  "; data=[NSJSONSerialization dataWithJSONObject:@{@"choices":@[@{@"message":@{@"content":content}}],@"error":@"secret upstream body"} options:0 error:NULL]; }
    [self.client URLProtocol:self didLoadData:data]; [self.client URLProtocolDidFinishLoading:self];
}
- (void)stopLoading {}
@end
static void PumpUntil(BOOL (^predicate)(void), NSTimeInterval timeout) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:timeout]; while(!predicate() && end.timeIntervalSinceNow>0) [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.005]]; CHECK(predicate()); }
static NSDictionary *Config(void) { return @{@"endpoint":@"https://example.invalid/v1/chat/completions",@"model":@"test-model"}; }
static NSArray *Messages(void) { return @[@{@"role":@"system",@"content":@"test prompt"},@{@"role":@"user",@"content":@"test message"}]; }
static NSDictionary *BailianConfig(NSString *mode) { NSMutableDictionary *configuration=[Config() mutableCopy]; configuration[@"provider"]=@"bailian"; configuration[@"searchMode"]=mode; return configuration; }
static void RunRequest(CSAIClient *client, NSDictionary *configuration, NSArray *messages, NSString *scenario, BOOL success, NSInteger code) {
    Scenario=scenario; __block NSUInteger calls=0; __block NSError *failure; __block NSString *output;
    [client generateWithConfiguration:configuration apiKey:@"fake-test-key" messages:messages completion:^(NSString *text,NSError *error) { CHECK(NSThread.isMainThread); calls++; output=text; failure=error; }];
    PumpUntil(^BOOL{return calls>0;},3);
    CHECK(calls==1); CHECK(success?(output.length>0 && !failure):(!output && failure)); if(code) CHECK(failure.code==code); if(failure) CHECK([failure.localizedDescription rangeOfString:@"secret"].location==NSNotFound);
    if(success) CHECK([output isEqual:@"你好"]);
}
static void Run(CSAIClient *client, NSString *scenario, BOOL success, NSInteger code) { RunRequest(client,Config(),Messages(),scenario,success,code); }
static NSDictionary *CapturedBody(void) {
    NSData *body=Captured.HTTPBody;
    if(!body && Captured.HTTPBodyStream) { NSInputStream *stream=Captured.HTTPBodyStream; [stream open]; NSMutableData *bytes=[NSMutableData data]; uint8_t buffer[4096]; NSInteger length; while((length=[stream read:buffer maxLength:sizeof(buffer)])>0) [bytes appendBytes:buffer length:(NSUInteger)length]; [stream close]; body=bytes; }
    return body?[NSJSONSerialization JSONObjectWithData:body options:0 error:NULL]:nil;
}
static NSString *Packet(NSDictionary *choice) { NSData *data=[NSJSONSerialization dataWithJSONObject:@{@"choices":@[choice]} options:0 error:NULL]; return [NSString stringWithFormat:@"data: %@\r\n\r\n",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]]; }
static void Stream(CSAIClient *client, NSString *data, NSUInteger fragments, BOOL success, NSInteger code) { SSEData=[data dataUsingEncoding:NSUTF8StringEncoding]; SSEFragmentSize=fragments; RunRequest(client,BailianConfig(@"auto"),Messages(),@"sse",success,code); }
static NSArray *ImageMessages(NSString *url) { return @[@{@"role":@"user",@"content":@[@{@"type":@"image_url",@"image_url":@{@"url":url}},@{@"type":@"text",@"text":@"这是什么？"}]}]; }
static NSString *ImageURL(NSUInteger size, BOOL png) { NSMutableData *data=[NSMutableData dataWithLength:size]; const unsigned char signature[]={137,80,78,71,13,10,26,10}; if(png) memcpy(data.mutableBytes,signature,MIN(sizeof(signature),size)); else if(size>=3) { unsigned char *bytes=data.mutableBytes; bytes[0]=0xff; bytes[1]=0xd8; bytes[2]=0xff; } return [NSString stringWithFormat:@"data:image/%@;base64,%@",png?@"png":@"jpeg",[data base64EncodedStringWithOptions:0]]; }
static void Reject(CSAIClient *client, NSDictionary *configuration, NSArray *messages) { NSUInteger before=Requests; RunRequest(client,configuration,messages,@"valid",NO,24); CHECK(Requests==before); }
int main(void) { @autoreleasepool {
    NSURLSessionConfiguration *configuration=NSURLSessionConfiguration.ephemeralSessionConfiguration; configuration.protocolClasses=@[AIFakeProtocol.class];
    CSAIClient *client=[[CSAIClient alloc] initWithSessionConfiguration:configuration];
    Run(client,@"valid",YES,0);
    CHECK([Captured.HTTPMethod isEqual:@"POST"]); CHECK([[Captured valueForHTTPHeaderField:@"Authorization"] isEqual:@"Bearer fake-test-key"]); CHECK(!Captured.HTTPShouldHandleCookies); CHECK(Captured.timeoutInterval==60);
    NSDictionary *body=CapturedBody();
    CHECK([body[@"model"] isEqual:@"test-model"]); CHECK([body[@"messages"] isEqual:Messages()]); CHECK([body[@"stream"] isEqual:@NO]);
    CHECK(!body[@"enable_search"] && !body[@"search_options"] && !body[@"enable_thinking"]);
    Run(client,@"401",NO,401); Run(client,@"429",NO,429); Run(client,@"500",NO,500); Run(client,@"malformed",NO,23); Run(client,@"empty",NO,23); Run(client,@"timeout",NO,NSURLErrorTimedOut); NSUInteger beforeRedirect=Requests; Run(client,@"redirect",NO,302); CHECK(Requests==beforeRedirect+1); Run(client,@"declared-bound",NO,21); Run(client,@"stream-bound",NO,21); Run(client,@"output-bound",NO,23);
    // Provider adaptation uses the configured complete endpoint and never leaks Bailian fields to generic CC.
    NSString *validStream=[NSString stringWithFormat:@": heartbeat\r\nevent: message\r\n%@%@%@data: [DONE]\r\n\r\n",Packet(@{@"delta":@{@"reasoning_content":@"secret hidden reasoning"}}),Packet(@{@"delta":@{@"content":@"  你"}}),Packet(@{@"delta":@{@"content":@"好  "},@"finish_reason":@"stop"})];
    Stream(client,validStream,1,YES,0); body=CapturedBody();
    CHECK([Captured.URL.absoluteString isEqual:Config()[@"endpoint"]]); CHECK([[Captured valueForHTTPHeaderField:@"Accept"] isEqual:@"text/event-stream"]); CHECK(Captured.timeoutInterval==60);
    CHECK([body[@"stream"] isEqual:@YES]); CHECK([body[@"enable_thinking"] isEqual:@NO]); CHECK([body[@"enable_search"] isEqual:@YES]); CHECK([body[@"search_options"] isEqual:@{@"search_strategy":@"turbo",@"forced_search":@NO}]); CHECK([body[@"messages"] isEqual:Messages()]);
    SSEData=[validStream dataUsingEncoding:NSUTF8StringEncoding]; SSEFragmentSize=7;
    NSMutableDictionary *provider=[BailianConfig(@"always") mutableCopy]; provider[@"thinkingEnabled"]=@YES;
    RunRequest(client,provider,Messages(),@"sse",YES,0); body=CapturedBody(); CHECK([body[@"enable_thinking"] isEqual:@YES]); CHECK([body[@"search_options"][@"forced_search"] isEqual:@YES]);
    RunRequest(client,BailianConfig(@"off"),Messages(),@"sse",YES,0); body=CapturedBody(); CHECK([body[@"enable_search"] isEqual:@NO]); CHECK(!body[@"search_options"]);
    provider=[Config() mutableCopy]; provider[@"thinkingEnabled"]=@YES; Reject(client,provider,Messages());
    provider[@"provider"]=@"openai-compatible"; Reject(client,provider,Messages());
    provider[@"thinkingEnabled"]=@NO; RunRequest(client,provider,Messages(),@"valid",YES,0); body=CapturedBody(); CHECK(!body[@"enable_thinking"] && !body[@"enable_search"] && !body[@"search_options"]); CHECK([body[@"stream"] isEqual:@NO]);
    // Split UTF-8 and CRLF, multiline data, EOF finalization and explicit terminal events.
    Stream(client,@"data: {\"choices\":\r\ndata: [{\"delta\":{\"content\":\"你好\"},\"finish_reason\":\"stop\"}]}\r\n\r\n",3,YES,0);
    Stream(client,[Packet(@{@"delta":@{@"content":@"你好"}}) stringByAppendingString:@"data: [DONE]\n\n"],2,YES,0);
    Stream(client,@"data: {\"choices\":[{\"delta\":{\"content\":\"你好\"},\"finish_reason\":\"stop\"}]}",1,YES,0);
    Stream(client,Packet(@{@"delta":@{@"content":@"你好"}}),4,NO,23);
    Stream(client,Packet(@{@"delta":@{@"content":@"你好"},@"finish_reason":@"length"}),4,NO,23);
    Stream(client,Packet(@{@"delta":@{@"reasoning_content":@"secret"},@"finish_reason":@"stop"}),4,NO,23);
    Stream(client,Packet(@{@"delta":@{@"tool_calls":@[@{@"id":@"secret"}]},@"finish_reason":@"tool_calls"}),4,NO,23);
    Stream(client,@"event: error\ndata: {\"message\":\"secret upstream details\"}\n\n",3,NO,25);
    Stream(client,@"event: error\n\n",1,NO,25);
    Stream(client,@"data: {\"error\":{\"message\":\"secret\"}}\n\n",3,NO,25);
    Stream(client,[validStream stringByAppendingString:@"data: {\"error\":{\"message\":\"secret\"}}\n\n"],9,NO,25);
    Stream(client,[validStream stringByAppendingString:Packet(@{@"delta":@{@"content":@"late"}})],5,NO,23);
    Stream(client,@"data: not JSON secret\n\n",5,NO,23);
    Stream(client,Packet(@{@"delta":@{@"content":[@"x" stringByPaddingToLength:4001 withString:@"x" startingAtIndex:0]},@"finish_reason":@"stop"}),4096,NO,23);
    Stream(client,[@"data: " stringByPaddingToLength:128*1024+1 withString:@"x" startingAtIndex:0],4096,NO,21);
    NSString *largeLine=[@"data: " stringByPaddingToLength:100*1024 withString:@"x" startingAtIndex:0]; Stream(client,[NSString stringWithFormat:@"%@\n%@\n%@\n\n",largeLine,largeLine,largeLine],8192,NO,21);
    Stream(client,[@": ping\n\n" stringByPaddingToLength:1024*1024+1 withString:@": ping\n\n" startingAtIndex:0],8192,NO,21);
    SSEData=[NSData dataWithBytes:"data: \xff\n\n" length:9]; SSEFragmentSize=1; RunRequest(client,BailianConfig(@"auto"),Messages(),@"sse",NO,23);
    SSEFailAfterData=YES; Stream(client,validStream,13,NO,NSURLErrorTimedOut); SSEFailAfterData=NO;
    // A terminal chunk alone does not deliver a reply until the transport also completes.
    SSEData=[validStream dataUsingEncoding:NSUTF8StringEncoding]; SSEFragmentSize=5; SSEHold=YES; Scenario=@"sse"; PendingStream=nil; __block NSUInteger heldCalls=0;
    [client generateWithConfiguration:BailianConfig(@"auto") apiKey:@"fake" messages:Messages() completion:^(NSString *text,NSError *error) { CHECK([text isEqual:@"你好"] && !error); heldCalls++; }];
    PumpUntil(^BOOL{return PendingStream!=nil;},3); [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]]; CHECK(heldCalls==0); [PendingStream.client URLProtocolDidFinishLoading:PendingStream]; PumpUntil(^BOOL{return heldCalls>0;},3); CHECK(heldCalls==1); PendingStream=nil; SSEHold=NO;
    Stream(client,[validStream stringByAppendingString:@"data: {\"choices\":[],\"usage\":{\"completion_tokens\":2}}\r\n\r\n"],11,YES,0);
    // Cancelling a held SSE request suppresses both its buffered success and all later delivery.
    SSEData=[validStream dataUsingEncoding:NSUTF8StringEncoding]; SSEHold=YES; Scenario=@"sse"; __block NSUInteger cancelledStreamCalls=0;
    id<CSAICancellable> streamToken=[client generateWithConfiguration:BailianConfig(@"auto") apiKey:@"fake" messages:Messages() completion:^(NSString *text,NSError *error) { CHECK(!text && error.code==NSURLErrorCancelled); cancelledStreamCalls++; }];
    PumpUntil(^BOOL{return PendingStream!=nil;},3); [streamToken cancel]; [streamToken cancel]; PumpUntil(^BOOL{return cancelledStreamCalls>0;},3); [PendingStream.client URLProtocolDidFinishLoading:PendingStream]; [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]]; CHECK(cancelledStreamCalls==1); PendingStream=nil; SSEHold=NO;
    // Image content uses strict Data URLs, byte bounds and opt-in without changing message/provider shape.
    NSString *png=ImageURL(32,YES), *jpeg=ImageURL(32,NO); provider=[Config() mutableCopy]; provider[@"imageEnabled"]=@YES;
    RunRequest(client,provider,ImageMessages(png),@"valid",YES,0); body=CapturedBody(); CHECK([body[@"messages"] isEqual:ImageMessages(png)]); CHECK(!body[@"enable_thinking"] && !body[@"enable_search"]);
    RunRequest(client,provider,ImageMessages(ImageURL(2*1024*1024,YES)),@"valid",YES,0);
    provider=[BailianConfig(@"auto") mutableCopy]; provider[@"imageEnabled"]=@YES; SSEData=[validStream dataUsingEncoding:NSUTF8StringEncoding]; RunRequest(client,provider,ImageMessages(jpeg),@"sse",YES,0); CHECK([CapturedBody()[@"messages"] isEqual:ImageMessages(jpeg)]);
    Reject(client,Config(),ImageMessages(png)); Reject(client,provider,ImageMessages(@"https://example.invalid/private.png")); Reject(client,provider,ImageMessages(@"file:///private.png")); Reject(client,provider,ImageMessages(@"data:image/webp;base64,UklGRg==")); Reject(client,provider,ImageMessages(@"data:image/png;base64,AAAA")); Reject(client,provider,ImageMessages([png stringByAppendingString:@"\n"])); Reject(client,provider,ImageMessages([png stringByReplacingOccurrencesOfString:@"png" withString:@"jpeg"])); Reject(client,provider,ImageMessages(ImageURL(2*1024*1024+1,YES)));
    Reject(client,provider,[@[ImageMessages(png).firstObject,ImageMessages(jpeg).firstObject] copy]);
    Reject(client,provider,@[@{@"role":@"assistant",@"content":ImageMessages(png).firstObject[@"content"]}]);
    Reject(client,provider,@[@{@"role":@"user",@"content":@[@{@"type":@"audio",@"url":@"secret"}]}]);
    NSMutableData *slashes=[NSMutableData dataWithLength:2*1024*1024]; memset(slashes.mutableBytes,0xff,slashes.length); ((unsigned char *)slashes.mutableBytes)[1]=0xd8; NSString *largeRequest=[@"data:image/jpeg;base64," stringByAppendingString:[slashes base64EncodedStringWithOptions:0]]; Reject(client,provider,ImageMessages(largeRequest));
    for(id invalid in @[@"unknown",NSNull.null]) { provider=[Config() mutableCopy]; provider[@"provider"]=invalid; Reject(client,provider,Messages()); }
    provider=[Config() mutableCopy]; provider[@"searchMode"]=@"auto"; Reject(client,provider,Messages());
    provider=[BailianConfig(@"agent") mutableCopy]; Reject(client,provider,Messages()); provider=[Config() mutableCopy]; provider[@"imageEnabled"]=@2; Reject(client,provider,Messages()); provider=[Config() mutableCopy]; provider[@"thinkingEnabled"]=@"YES"; Reject(client,provider,Messages());
    Reject(client,Config(),@[@{@"role":@"user",@"content":[@"x" stringByPaddingToLength:128*1024+1 withString:@"x" startingAtIndex:0]}]);
    // Caller mutation after return cannot alter an asynchronously encoded request.
    NSMutableString *mutableText=[@"original" mutableCopy], *mutableModel=[@"snapshot-model" mutableCopy]; NSMutableArray *mutableParts=[NSMutableArray arrayWithObject:[@{@"type":@"text",@"text":mutableText} mutableCopy]]; NSMutableDictionary *mutableMessage=[@{@"role":@"user",@"content":mutableParts} mutableCopy]; NSMutableArray *mutableMessages=[NSMutableArray arrayWithObject:mutableMessage]; NSMutableDictionary *mutableConfig=[Config() mutableCopy]; mutableConfig[@"model"]=mutableModel; Scenario=@"valid"; __block BOOL snapshotDone=NO;
    [client generateWithConfiguration:mutableConfig apiKey:@"fake" messages:mutableMessages completion:^(NSString *text,NSError *error) { CHECK(text && !error); snapshotDone=YES; }]; [mutableText setString:@"changed"]; [mutableModel setString:@"changed"]; [mutableParts removeAllObjects]; [mutableMessage removeAllObjects]; [mutableMessages removeAllObjects]; [mutableConfig removeAllObjects]; PumpUntil(^BOOL{return snapshotDone;},3); body=CapturedBody(); CHECK([body[@"model"] isEqual:@"snapshot-model"]); CHECK([body[@"messages"][0][@"content"][0][@"text"] isEqual:@"original"]);
    Scenario=@"delayed"; __block NSUInteger cancelledCalls=0;
    id<CSAICancellable> token=[client generateWithConfiguration:Config() apiKey:@"fake-test-key" messages:Messages() completion:^(NSString *text,NSError *error) { CHECK(NSThread.isMainThread); CHECK(!text); CHECK(error.code==NSURLErrorCancelled); cancelledCalls++; }];
    [token cancel]; [token cancel]; PumpUntil(^BOOL{return cancelledCalls>0;},3); CHECK(cancelledCalls==1);
    // Background encoding must not start a late network task after immediate cancellation.
    NSUInteger beforeEarlyCancel=Requests; Scenario=@"valid"; __block NSUInteger earlyCancelCalls=0;
    token=[client generateWithConfiguration:Config() apiKey:@"fake" messages:Messages() completion:^(NSString *text,NSError *error) { CHECK(!text && error.code==NSURLErrorCancelled); earlyCancelCalls++; }]; BOOL cancelledBeforeTask;
    @synchronized(token) { cancelledBeforeTask=[(NSObject *)token valueForKey:@"task"]==nil; [token cancel]; }
    PumpUntil(^BOOL{return earlyCancelCalls>0;},3); [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]]; CHECK(earlyCancelCalls==1); if(cancelledBeforeTask) CHECK(Requests==beforeEarlyCancel);
    // A completed response queued to main cannot survive cancellation before delivery.
    Scenario=@"valid"; __block NSUInteger lateCalls=0;
    token=[client generateWithConfiguration:Config() apiKey:@"fake-test-key" messages:Messages() completion:^(NSString *text,NSError *error) { CHECK(!text); CHECK(error.code==NSURLErrorCancelled); lateCalls++; }];
    // Hold the main run loop until the production delegate has queued its success.
    // KVC observes the private terminal flag without replacing any client behavior.
    NSDate *lateDeadline=[NSDate dateWithTimeIntervalSinceNow:3]; BOOL queued=NO;
    while(!queued && lateDeadline.timeIntervalSinceNow>0) {
        @synchronized(token) { queued=[[(NSObject *)token valueForKey:@"finished"] boolValue]; }
        if(!queued) [NSThread sleepForTimeInterval:0.001];
    }
    CHECK(queued); [token cancel]; PumpUntil(^BOOL{return lateCalls>0;},3); CHECK(lateCalls==1);
    // Invalid input finishes asynchronously on main without invoking any protocol.
    NSUInteger prior=Requests; __block BOOL invalidDone=NO;
    [client generateWithConfiguration:@{@"endpoint":@"http://example.invalid",@"model":@"test"} apiKey:@"fake" messages:Messages() completion:^(NSString *text,NSError *error) { CHECK(NSThread.isMainThread); CHECK(!text && error); invalidDone=YES; }];
    PumpUntil(^BOOL{return invalidDone;},3); CHECK(Requests==prior);
    FakeSecrets=[NSMutableDictionary dictionary]; NSError *keychainError=nil;
    CHECK(CSAIWriteCredential(@"alice",@"v1",@"fake-only",&keychainError));
    CHECK([LastKeychainQuery[(__bridge id)kSecAttrService] isEqual:@"com.wechatimprove.ai-reply.v1"]);
    CHECK([LastKeychainQuery[(__bridge id)kSecAttrAccessible] isEqual:(__bridge id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly]);
    CHECK([LastKeychainQuery[(__bridge id)kSecAttrSynchronizable] isEqual:@NO]);
    CHECK(!CSAIWriteCredential(@"alice",@"v1",@"replacement",&keychainError)); CHECK([CSAIReadCredential(@"alice",@"v1",&keychainError) isEqual:@"fake-only"]);
    CHECK(CSAIWriteCredential(@"bob",@"v1",@"other-account",&keychainError)); CHECK(CSAIWriteCredential(@"alice",@"v2",@"new-version",&keychainError));
    CHECK([CSAIReadCredential(@"alice",@"v2",&keychainError) isEqual:@"new-version"]); CHECK(!CSAIReadCredential(@"bob",@"v2",&keychainError));
    CSAIRemoveCredential(@"alice",@"v1"); CHECK(!CSAIReadCredential(@"alice",@"v1",&keychainError)); CHECK([CSAIReadCredential(@"alice",@"v2",&keychainError) isEqual:@"new-version"]);
    CHECK(!CSAIWriteCredential(@"",@"v1",@"fake",&keychainError)); CHECK(!CSAIWriteCredential(@"alice",@"v3",@"fake\nheader",&keychainError));
    puts("AIClientTests passed: generic/Bailian CC, search modes, strict image/request bounds, fragmented SSE, terminal/error handling, cancellation, immutable inputs, safe HTTP failures and credential isolation");
} return 0; }
