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
@interface AIFakeProtocol : NSURLProtocol
@end
@implementation AIFakeProtocol
+ (BOOL)canInitWithRequest:(NSURLRequest *)request { (void)request; return YES; }
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request { return request; }
- (void)startLoading {
    Captured=self.request; Requests++;
    NSString *scenario=Scenario;
    if([scenario isEqual:@"delayed"]) return;
    if([scenario isEqual:@"timeout"]) { [self.client URLProtocol:self didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:@{NSLocalizedDescriptionKey:@"secret upstream error"}]]; return; }
    NSInteger status=200; if([scenario isEqual:@"401"]) status=401; if([scenario isEqual:@"429"]) status=429; if([scenario isEqual:@"500"]) status=500; if([scenario isEqual:@"redirect"]) status=302;
    NSDictionary *headers=[scenario isEqual:@"declared-bound"]?@{@"Content-Length":@"1048577"}:@{};
    NSHTTPURLResponse *response=[[NSHTTPURLResponse alloc] initWithURL:self.request.URL statusCode:status HTTPVersion:@"HTTP/1.1" headerFields:headers];
    if([scenario isEqual:@"redirect"]) {
        NSMutableURLRequest *redirect=[self.request mutableCopy]; redirect.URL=[NSURL URLWithString:@"https://other.invalid/never-follow"];
        [self.client URLProtocol:self wasRedirectedToRequest:redirect redirectResponse:response]; return;
    }
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
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
static void Run(CSAIClient *client, NSString *scenario, BOOL success, NSInteger code) {
    Scenario=scenario; __block NSUInteger calls=0; __block NSError *failure; __block NSString *output;
    [client generateWithConfiguration:Config() apiKey:@"fake-test-key" messages:Messages() completion:^(NSString *text,NSError *error) { CHECK(NSThread.isMainThread); calls++; output=text; failure=error; }];
    PumpUntil(^BOOL{return calls>0;},3);
    CHECK(calls==1); CHECK(success?(output.length>0 && !failure):(!output && failure)); if(code) CHECK(failure.code==code); if(failure) CHECK([failure.localizedDescription rangeOfString:@"secret"].location==NSNotFound);
    if(success) CHECK([output isEqual:@"你好"]);
}
int main(void) { @autoreleasepool {
    NSURLSessionConfiguration *configuration=NSURLSessionConfiguration.ephemeralSessionConfiguration; configuration.protocolClasses=@[AIFakeProtocol.class];
    CSAIClient *client=[[CSAIClient alloc] initWithSessionConfiguration:configuration];
    Run(client,@"valid",YES,0);
    CHECK([Captured.HTTPMethod isEqual:@"POST"]); CHECK([[Captured valueForHTTPHeaderField:@"Authorization"] isEqual:@"Bearer fake-test-key"]); CHECK(!Captured.HTTPShouldHandleCookies); CHECK(Captured.timeoutInterval==60);
    NSData *requestBody=Captured.HTTPBody;
    if(!requestBody && Captured.HTTPBodyStream) { NSInputStream *stream=Captured.HTTPBodyStream; [stream open]; NSMutableData *bytes=[NSMutableData data]; uint8_t buffer[4096]; NSInteger length; while((length=[stream read:buffer maxLength:sizeof(buffer)])>0) [bytes appendBytes:buffer length:(NSUInteger)length]; [stream close]; requestBody=bytes; }
    NSDictionary *body=requestBody?[NSJSONSerialization JSONObjectWithData:requestBody options:0 error:NULL]:nil;
    CHECK([body[@"model"] isEqual:@"test-model"]); CHECK([body[@"messages"] isEqual:Messages()]); CHECK([body[@"stream"] isEqual:@NO]);
    Run(client,@"401",NO,401); Run(client,@"429",NO,429); Run(client,@"500",NO,500); Run(client,@"malformed",NO,23); Run(client,@"empty",NO,23); Run(client,@"timeout",NO,NSURLErrorTimedOut); NSUInteger beforeRedirect=Requests; Run(client,@"redirect",NO,302); CHECK(Requests==beforeRedirect+1); Run(client,@"declared-bound",NO,21); Run(client,@"stream-bound",NO,21); Run(client,@"output-bound",NO,23);
    Scenario=@"delayed"; __block NSUInteger cancelledCalls=0;
    id<CSAICancellable> token=[client generateWithConfiguration:Config() apiKey:@"fake-test-key" messages:Messages() completion:^(NSString *text,NSError *error) { CHECK(NSThread.isMainThread); CHECK(!text); CHECK(error.code==NSURLErrorCancelled); cancelledCalls++; }];
    [token cancel]; [token cancel]; PumpUntil(^BOOL{return cancelledCalls>0;},3); CHECK(cancelledCalls==1);
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
    puts("AIClientTests passed: URLProtocol request, success, safe HTTP errors, malformed/empty, timeout, redirect, bounds, cancellation, invalid input and immutable credential slots with Security fakes");
} return 0; }
