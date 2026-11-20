#import <Foundation/Foundation.h>
#import "CSPluginVerseProvider.h"

@interface CSPluginVerseProvider (Testing)
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration cacheURL:(NSURL *)cacheURL clock:(NSDate *(^)(void))clock;
@end

static NSUInteger checks;
static void Check(BOOL condition, NSString *message) {
    checks++;
    if (!condition) { fprintf(stderr,"FAIL: %s\n",message.UTF8String); exit(1); }
}
static void Await(BOOL (^condition)(void)) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:3];
    while (!condition() && deadline.timeIntervalSinceNow > 0) {
        [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    Check(condition(),@"asynchronous operation finishes");
}
static void RunFor(NSTimeInterval duration) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:duration];
    while (deadline.timeIntervalSinceNow > 0) {
        [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
}

static NSMutableArray<NSDictionary *> *plans;
static NSMutableArray<NSString *> *requestedHosts;
static BOOL unexpectedRequest, requestContainsPrivateData;
static NSUInteger cancellations;
static dispatch_semaphore_t startSignal;

@interface VerseProtocol : NSURLProtocol
@end
@implementation VerseProtocol {
    BOOL _stopped;
}
+ (BOOL)canInitWithRequest:(NSURLRequest *)request { return [@[@"api.qemao.com",@"api.yujn.cn"] containsObject:request.URL.host]; }
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request { return request; }
- (void)startLoading {
    NSDictionary *plan;
    dispatch_semaphore_t signal;
    @synchronized(VerseProtocol.class) {
        [requestedHosts addObject:self.request.URL.host];
        plan=plans.firstObject;
        if (plans.count) [plans removeObjectAtIndex:0];
        if (!plan || ![plan[@"host"] isEqual:self.request.URL.host]) unexpectedRequest=YES;
        if (![self.request.URL.scheme isEqual:@"https"] || self.request.URL.query.length || self.request.HTTPBody.length || [self.request valueForHTTPHeaderField:@"Cookie"] || [self.request valueForHTTPHeaderField:@"Authorization"]) requestContainsPrivateData=YES;
        signal=startSignal;startSignal=nil;
    }
    if (signal) dispatch_semaphore_signal(signal);
    NSData *data=plan[@"data"] ?: [NSData data];
    NSInteger status=[plan[@"status"] integerValue];
    NSTimeInterval delay=plan[@"delay"] ? [plan[@"delay"] doubleValue] : 0.01;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay*NSEC_PER_SEC)),dispatch_get_global_queue(QOS_CLASS_DEFAULT,0), ^{
        @synchronized(self) { if (self->_stopped) return; }
        if (plan[@"error"]) {
            [self.client URLProtocol:self didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:[plan[@"error"] integerValue] userInfo:nil]];
            return;
        }
        NSHTTPURLResponse *response=[[NSHTTPURLResponse alloc] initWithURL:self.request.URL statusCode:status HTTPVersion:@"HTTP/1.1" headerFields:@{@"Content-Type":@"text/html; charset=utf-8"}];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    });
}
- (void)stopLoading {
    @synchronized(self) { _stopped=YES; }
    @synchronized(VerseProtocol.class) { cancellations++; }
}
@end

static NSDictionary *Response(NSString *host, NSString *body, NSInteger status) {
    return @{@"host":host,@"data":[body dataUsingEncoding:NSUTF8StringEncoding],@"status":@(status)};
}
static void SetPlans(NSArray<NSDictionary *> *responses) {
    @synchronized(VerseProtocol.class) {
        Check(!plans.count,@"previous response script was consumed");
        plans=[responses mutableCopy];
    }
}
static NSUInteger RequestCount(void) { @synchronized(VerseProtocol.class) { return requestedHosts.count; } }
static NSArray<NSString *> *Hosts(void) { @synchronized(VerseProtocol.class) { return [requestedHosts copy]; } }
static void RefreshExpecting(CSPluginVerseProvider *provider, NSArray<NSString *> *expected) {
    __block NSUInteger delivered=0;
    [provider refreshWithCompletion:^(NSString *verse) {
        Check(NSThread.isMainThread,@"cache and network callbacks run on main");
        Check(delivered < expected.count,@"refresh does not produce extra callbacks");
        Check([verse isEqual:expected[delivered]],@"refresh delivers cache first, then the final result");
        delivered++;
    }];
    Await(^{ return (BOOL)(delivered==expected.count); });
}

int main(void) { @autoreleasepool {
    NSString *poem=@"香炉初上日，瀑水喷成虹。";
    NSString *secondPoem=@"海内存知己，天涯若比邻。";
    NSString *quote=@"愿你心中总有光";
    NSString *ellipsis=@"无论发生什么，都请不要后悔与我的相遇……";
    for (NSString *delimiter in @[@"──",@"——",@"--"]) {
        Check([CSPluginVerseTextFromResponse([NSString stringWithFormat:@"%@ %@孟浩然《彭蠡湖中望庐山》",poem,delimiter]) isEqual:poem],@"verse attribution is removed for service separators");
    }
    Check([CSPluginVerseTextFromResponse(@"香炉初上日，瀑水喷成虹。 孟浩然《彭蠡湖中望庐山》") isEqual:poem],@"verse title suffix is removed");
    Check([CSPluginVerseTextFromResponse(@" \uFEFF海内存知己，\n 天涯若比邻。 \r\n") isEqual:secondPoem],@"verse normalization preserves full body and punctuation");
    Check([CSPluginQuoteTextFromResponse(@"藏好自己，做好清理。——三体") isEqual:@"藏好自己，做好清理。"],@"new source's work attribution is removed");
    Check([CSPluginQuoteTextFromResponse([ellipsis stringByAppendingString:@"——CLANNAD"]) isEqual:ellipsis],@"quotation ellipsis is preserved");
    Check([CSPluginQuoteTextFromResponse(@"深处暖春，才会怕冷。\\r\\n——全球高考") isEqual:@"深处暖春，才会怕冷。"],@"literal escaped CRLF before attribution is removed");
    Check([CSPluginQuoteTextFromResponse(@"深处暖春，才会怕冷。\r\n——全球高考") isEqual:@"深处暖春，才会怕冷。"],@"actual CRLF before attribution is removed");
    Check([CSPluginQuoteTextFromResponse(quote) isEqual:quote],@"short Chinese quotation does not require punctuation");
    Check(CSPluginVerseTextFromResponse(quote)==nil,@"verse source keeps its stricter punctuation rule");
    for (id invalid in @[@"",@"  \n",@"<html>请求失败，请稍后重试。</html>",@"{\"message\":\"请求失败，请稍后重试。\"}",@"[\"今日文案\"]",@"请求过于频繁，请稍后重试。",@"error: 请求失败。",@"Access denied: 您无权访问。",@"您访问接口过于频繁，请稍后重试。",@"server unavailable",[NSNull null]]) {
        Check(CSPluginVerseTextFromResponse(invalid)==nil && CSPluginQuoteTextFromResponse(invalid)==nil,@"both parsers reject malformed and error bodies");
    }
    Check(CSPluginVerseTextFromResponse(nil)==nil && CSPluginQuoteTextFromResponse(nil)==nil,@"missing response is rejected");

    NSString *verseHost=@"api.qemao.com", *quoteHost=@"api.yujn.cn";
    requestedHosts=[NSMutableArray array];plans=[NSMutableArray array];
    NSString *temporary=[NSTemporaryDirectory() stringByAppendingPathComponent:[@"wechat-verse-tests-" stringByAppendingString:NSUUID.UUID.UUIDString]];
    NSURL *cacheURL=[NSURL fileURLWithPath:[temporary stringByAppendingPathComponent:@"HeaderVerse.plist"]];
    NSURLSessionConfiguration *configuration=NSURLSessionConfiguration.ephemeralSessionConfiguration;
    configuration.protocolClasses=@[VerseProtocol.class];
    __block NSDate *now=[NSDate dateWithTimeIntervalSince1970:1800000000];
    CSPluginVerseProvider *provider=[[CSPluginVerseProvider alloc] initWithSessionConfiguration:configuration cacheURL:cacheURL clock:^{ return now; }];
    Check(provider.currentVerse.length > 0,@"first visit has an immediate local fallback");
    SetPlans(@[Response(verseHost,[poem stringByAppendingString:@" ──孟浩然《彭蠡湖中望庐山》"],200)]);
    RefreshExpecting(provider,@[poem]);
    Check([provider.currentVerse isEqual:poem] && RequestCount()==1,@"first entry requests verse source and saves its parsed result");

    SetPlans(@[Response(quoteHost,[quote stringByAppendingString:@"——匿名"],200)]);
    RefreshExpecting(provider,@[poem,quote]);
    Check(RequestCount()==2 && [Hosts() isEqual:@[verseHost,quoteHost]],@"second entry requests alternate source even with a fresh cache");
    NSDictionary *persisted=[NSDictionary dictionaryWithContentsOfURL:cacheURL];
    Check([persisted[@"verse"] isEqual:quote] && [persisted[@"source"] isEqual:@"quote"],@"unpunctuated quote saves its parser type");

    CSPluginVerseProvider *reopened=[[CSPluginVerseProvider alloc] initWithSessionConfiguration:configuration cacheURL:cacheURL clock:^{ return now; }];
    SetPlans(@[Response(verseHost,secondPoem,200)]);
    RefreshExpecting(reopened,@[quote,secondPoem]);
    Check(RequestCount()==3,@"restart immediately shows quote cache and still requests network");

    SetPlans(@[@{@"host":verseHost,@"error":@(NSURLErrorNotConnectedToInternet)},Response(quoteHost,[ellipsis stringByAppendingString:@"——CLANNAD"],200)]);
    RefreshExpecting(provider,@[quote,ellipsis]);
    Check(RequestCount()==5 && [[Hosts() subarrayWithRange:NSMakeRange(3,2)] isEqual:@[verseHost,quoteHost]],@"network failure falls back to the other source");
    SetPlans(@[Response(quoteHost,@"服务不可用，请稍后重试。",503),Response(verseHost,secondPoem,200)]);
    RefreshExpecting(provider,@[ellipsis,secondPoem]);
    Check(RequestCount()==7 && [[Hosts() subarrayWithRange:NSMakeRange(5,2)] isEqual:@[quoteHost,verseHost]],@"HTTP failure falls back in the reverse direction");

    NSData *cacheBeforeFailure=[NSData dataWithContentsOfURL:cacheURL];
    now=[now dateByAddingTimeInterval:1];
    const unsigned char bytes[]={0xff,0xfe,0xff};
    SetPlans(@[Response(verseHost,@"<html>不是诗句。</html>",200),@{@"host":quoteHost,@"data":[NSData dataWithBytes:bytes length:sizeof(bytes)],@"status":@200}]);
    RefreshExpecting(provider,@[secondPoem,secondPoem]);
    Check(RequestCount()==9,@"HTML parse failure and invalid UTF8 consume at most the two sources");
    Check([[NSData dataWithContentsOfURL:cacheURL] isEqual:cacheBeforeFailure],@"both failures preserve the successful disk cache byte for byte");
    SetPlans(@[Response(quoteHost,@"{\"message\":\"错误文案\"}",200),Response(verseHost,@"请求过于频繁，请稍后重试。",200)]);
    RefreshExpecting(provider,@[secondPoem,secondPoem]);
    Check(RequestCount()==11,@"next immediate entry retries both sources without failure cooldown");
    Check([[NSData dataWithContentsOfURL:cacheURL] isEqual:cacheBeforeFailure],@"JSON and error text never overwrite the successful cache");
    SetPlans(@[Response(verseHost,quote,200),Response(quoteHost,quote,200)]);
    RefreshExpecting(provider,@[secondPoem,quote]);
    Check(RequestCount()==13,@"punctuation-free body fails strict verse parsing but succeeds through quote fallback");

    NSUInteger beforeCancel=RequestCount(), beforeCancellationCount;
    @synchronized(VerseProtocol.class) { beforeCancellationCount=cancellations;startSignal=dispatch_semaphore_create(0); }
    dispatch_semaphore_t signal=startSignal;
    SetPlans(@[@{@"host":quoteHost,@"data":[@"旧文案不得回填——旧来源" dataUsingEncoding:NSUTF8StringEncoding],@"status":@200,@"delay":@0.20},Response(verseHost,poem,200)]);
    __block NSUInteger oldCallbacks=0;
    [provider refreshWithCompletion:^(__unused NSString *verse) { oldCallbacks++; }];
    // Keep main busy until the previous entry has queued its initial cache callback.
    Check(dispatch_semaphore_wait(signal,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0,@"previous request began while its cache callback was still queued");
    RefreshExpecting(provider,@[quote,poem]);
    RunFor(0.25);
    Check(oldCallbacks==0,@"new entry suppresses even an old cache callback already queued on main");
    Check(RequestCount()==beforeCancel+2 && [provider.currentVerse isEqual:poem],@"superseding entry requests its next source and rejects the late old response");
    @synchronized(VerseProtocol.class) { Check(cancellations > beforeCancellationCount,@"superseded NSURLSession task is cancelled"); }
    persisted=[NSDictionary dictionaryWithContentsOfURL:cacheURL];
    Check([persisted[@"verse"] isEqual:poem],@"late response cannot replace the newer disk result");

    NSUInteger beforeRepeat=RequestCount();
    SetPlans(@[Response(quoteHost,poem,200),Response(verseHost,secondPoem,200)]);
    RefreshExpecting(provider,@[poem,secondPoem]);
    Check(RequestCount()==beforeRepeat+2,@"a repeated primary body tries the alternate source once for a new sentence");
    SetPlans(@[Response(verseHost,secondPoem,200),Response(quoteHost,secondPoem,200)]);
    RefreshExpecting(provider,@[secondPoem,secondPoem]);
    Check(RequestCount()==beforeRepeat+4,@"if both sources repeat, a refresh still stops after two requests");

    NSURL *legacyURL=[NSURL fileURLWithPath:[temporary stringByAppendingPathComponent:@"LegacyVerse.plist"]];
    [@{@"verse":secondPoem,@"fetchedAt":@1800000000} writeToURL:legacyURL atomically:YES];
    CSPluginVerseProvider *legacy=[[CSPluginVerseProvider alloc] initWithSessionConfiguration:configuration cacheURL:legacyURL clock:^{ return now; }];
    SetPlans(@[Response(verseHost,@"",503),Response(quoteHost,@"",503)]);
    RefreshExpecting(legacy,@[secondPoem,secondPoem]);
    Check([legacy.currentVerse isEqual:secondPoem],@"beta02 cache without a source field remains a valid fallback");
    CSPluginVerseProvider *offline=[[CSPluginVerseProvider alloc] initWithSessionConfiguration:configuration cacheURL:nil clock:^{ return now; }];
    NSString *fallback=offline.currentVerse;
    SetPlans(@[Response(verseHost,@"请求失败。",503),Response(quoteHost,@"访问错误。",503)]);
    RefreshExpecting(offline,@[fallback]);
    @synchronized(VerseProtocol.class) {
        Check(!unexpectedRequest && !plans.count,@"all requests followed the expected source order with no extra retries");
        Check(!requestContainsPrivateData,@"both sources use HTTPS with no query, body, cookies or credentials");
    }
    [NSFileManager.defaultManager removeItemAtPath:temporary error:NULL];
    printf("Plugin verse: %lu checks passed\n",(unsigned long)checks);
} return 0; }
