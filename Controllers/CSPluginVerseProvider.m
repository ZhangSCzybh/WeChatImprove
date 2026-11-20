#import "CSPluginVerseProvider.h"
#import <math.h>

static NSUInteger const CSPluginVerseMaximumResponseBytes = 16 * 1024;
static NSString * const CSPluginVerseFallback = @"山重水复疑无路，柳暗花明又一村。";

static NSString *CSPluginCleanTextResponse(NSString *response) {
    if (![response isKindOfClass:NSString.class] || !response.length || response.length > 4096) return nil;
    // The service currently labels valid plain text as text/html. Validate its body,
    // rather than trusting the MIME type or displaying an HTML error page.
    if ([response rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"<>{}`"]].location != NSNotFound) return nil;
    NSString *text=[response stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    text=[text stringByReplacingOccurrencesOfString:@"\uFEFF" withString:@""];
    text=[text stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    text=[text stringByReplacingOccurrencesOfString:@"\\r" withString:@"\n"];
    text=[text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    if ([text hasPrefix:@"["] || [text hasPrefix:@"\""]) return nil;
    return text;
}

NSString *CSPluginVerseTextFromResponse(NSString *response) {
    NSString *text=CSPluginCleanTextResponse(response);
    if (!text) return nil;
    static NSRegularExpression *attribution, *titleSuffix, *whitespace, *han, *punctuation, *errorPrefix;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        attribution=[NSRegularExpression regularExpressionWithPattern:@"(?:─{2,}|—{2,}|－{2,}|–{2,}|-{2,})[\\s\\S]*$" options:0 error:NULL];
        titleSuffix=[NSRegularExpression regularExpressionWithPattern:@"(?:\\s+|(?<=[。！？；]))[^\\s《》]{1,20}《[^《》]+》\\s*$" options:0 error:NULL];
        whitespace=[NSRegularExpression regularExpressionWithPattern:@"[\\s\\u00A0]+" options:0 error:NULL];
        han=[NSRegularExpression regularExpressionWithPattern:@"[\\p{Han}]" options:0 error:NULL];
        punctuation=[NSRegularExpression regularExpressionWithPattern:@"[，。！？；、,.!?;]" options:0 error:NULL];
        errorPrefix=[NSRegularExpression regularExpressionWithPattern:@"^(?:error|access\\s*denied|too\\s*many|not\\s*found|接口|请求|访问|系统|服务|错误|暂无|获取失败|网络|您(?:的)?(?:访问|请求))" options:NSRegularExpressionCaseInsensitive error:NULL];
    });
    text=[attribution stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0,text.length) withTemplate:@""];
    text=[titleSuffix stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0,text.length) withTemplate:@""];
    text=[whitespace stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0,text.length) withTemplate:@""];
    NSRange range=NSMakeRange(0,text.length);
    if (text.length < 4 || text.length > 512 || [text containsString:@"《"] || [text containsString:@"》"] ||
        [han numberOfMatchesInString:text options:0 range:range] < 4 ||
        ![punctuation firstMatchInString:text options:0 range:range] ||
        [errorPrefix firstMatchInString:text options:0 range:range]) return nil;
    return text;
}

NSString *CSPluginQuoteTextFromResponse(NSString *response) {
    NSString *text=CSPluginCleanTextResponse(response);
    if (!text) return nil;
    static NSRegularExpression *attribution, *whitespace, *han, *errorPrefix;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        attribution=[NSRegularExpression regularExpressionWithPattern:@"(?:─{2,}|—{2,}|－{2,}|–{2,}|-{2,})[\\s\\S]*$" options:0 error:NULL];
        whitespace=[NSRegularExpression regularExpressionWithPattern:@"[\\s\\u00A0]+" options:0 error:NULL];
        han=[NSRegularExpression regularExpressionWithPattern:@"[\\p{Han}]" options:0 error:NULL];
        errorPrefix=[NSRegularExpression regularExpressionWithPattern:@"^(?:error|access\\s*denied|too\\s*many|not\\s*found|接口|请求|访问|系统|服务|错误|暂无|获取失败|网络|您(?:的)?(?:访问|请求))" options:NSRegularExpressionCaseInsensitive error:NULL];
    });
    text=[attribution stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0,text.length) withTemplate:@""];
    text=[whitespace stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0,text.length) withTemplate:@" "];
    text=[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    NSRange range=NSMakeRange(0,text.length);
    if (text.length < 2 || text.length > 512 ||
        [han numberOfMatchesInString:text options:0 range:range] < 2 ||
        [errorPrefix firstMatchInString:text options:0 range:range]) return nil;
    return text;
}

@interface CSPluginVerseProvider ()
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
                                   cacheURL:(NSURL * _Nullable)cacheURL
                                      clock:(NSDate *(^)(void))clock;
@end

@implementation CSPluginVerseProvider {
    dispatch_queue_t _queue;
    NSURLSession *_session;
    NSURL *_cacheURL;
    NSDate *(^_clock)(void);
    NSString *_cachedVerse;
    NSDate *_cachedAt;
    BOOL _cachedQuote;
    NSURLSessionDataTask *_task;
    void (^_completion)(NSString *);
    NSUInteger _generation;
}

+ (instancetype)sharedProvider {
    static CSPluginVerseProvider *provider;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSURL *directory=[NSFileManager.defaultManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject;
        NSURL *cacheURL=[[directory URLByAppendingPathComponent:@"WeChatImprove" isDirectory:YES] URLByAppendingPathComponent:@"HeaderVerse.plist"];
        provider=[[self alloc] initWithSessionConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration
                                                 cacheURL:cacheURL clock:^{ return NSDate.date; }];
    });
    return provider;
}

- (instancetype)init {
    return [self initWithSessionConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration cacheURL:nil clock:^{ return NSDate.date; }];
}

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration cacheURL:(NSURL *)cacheURL clock:(NSDate *(^)(void))clock {
    if ((self=[super init])) {
        _queue=dispatch_queue_create("com.wechat.improve.header-verse",DISPATCH_QUEUE_SERIAL);
        _cacheURL=[cacheURL copy];
        _clock=[clock copy];
        _cachedVerse=CSPluginVerseFallback;
        NSURLSessionConfiguration *sessionConfiguration=[configuration copy];
        sessionConfiguration.timeoutIntervalForRequest=8;
        sessionConfiguration.timeoutIntervalForResource=12;
        sessionConfiguration.URLCache=nil;
        sessionConfiguration.HTTPCookieStorage=nil;
        sessionConfiguration.URLCredentialStorage=nil;
        sessionConfiguration.HTTPShouldSetCookies=NO;
        _session=[NSURLSession sessionWithConfiguration:sessionConfiguration];
        // Disk IO never runs on the settings page's main thread. Refresh requests
        // enqueue behind this read and therefore see the persisted cache first.
        dispatch_async(_queue, ^{ [self loadCache]; });
    }
    return self;
}

- (NSString *)currentVerse {
    @synchronized(self) { return _cachedVerse; }
}

- (void)loadCache {
    if (!_cacheURL) return;
    NSDictionary *attributes=[NSFileManager.defaultManager attributesOfItemAtPath:_cacheURL.path error:NULL];
    if (![attributes[NSFileType] isEqual:NSFileTypeRegular] || [attributes[NSFileSize] unsignedLongLongValue] > CSPluginVerseMaximumResponseBytes) return;
    NSData *data=[NSData dataWithContentsOfURL:_cacheURL options:NSDataReadingMappedIfSafe error:NULL];
    id object=data ? [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL] : nil;
    if (![object isKindOfClass:NSDictionary.class]) return;
    id source=object[@"source"];
    if (source && ![source isEqual:@"verse"] && ![source isEqual:@"quote"]) return;
    BOOL quote=[source isEqual:@"quote"];
    NSString *verse=quote ? CSPluginQuoteTextFromResponse(object[@"verse"]) : CSPluginVerseTextFromResponse(object[@"verse"]);
    id timestamp=object[@"fetchedAt"];
    if (!verse || ![timestamp isKindOfClass:NSNumber.class] || !isfinite([timestamp doubleValue]) || [timestamp doubleValue] <= 0) return;
    @synchronized(self) { _cachedVerse=verse; }
    _cachedAt=[NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    _cachedQuote=quote;
}

- (void)saveCache {
    if (!_cacheURL || !_cachedAt) return;
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:@{@"verse":[self currentVerse],@"fetchedAt":@(_cachedAt.timeIntervalSince1970),@"source":_cachedQuote ? @"quote" : @"verse"} format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];
    if (!data) return;
    [NSFileManager.defaultManager createDirectoryAtURL:[_cacheURL URLByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:NULL];
    [data writeToURL:_cacheURL options:NSDataWritingAtomic error:NULL];
}

- (BOOL)isCurrentGeneration:(NSUInteger)generation {
    @synchronized(self) { return generation==_generation; }
}

- (void)deliverVerse:(NSString *)verse completion:(void (^)(NSString *))completion generation:(NSUInteger)generation {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isCurrentGeneration:generation]) completion(verse);
    });
}

- (void)refreshWithCompletion:(void (^)(NSString *))completion {
    if (!completion) return;
    NSUInteger generation;
    // Invalidate synchronously so a previous callback already queued on main
    // cannot be delivered after the next page entry requests a new refresh.
    @synchronized(self) { generation=++_generation; }
    dispatch_async(_queue, ^{
        if (![self isCurrentGeneration:generation]) return;
        [self->_task cancel];
        self->_task=nil;
        self->_completion=[completion copy];
        if (self->_cachedAt) {
            [self deliverVerse:[self currentVerse] completion:completion generation:generation];
        }
        // Deterministic rotation is per entry; trying the alternate after a failure
        // does not consume the next entry's turn.
        [self requestSource:(generation-1)%2 allowFallback:YES generation:generation];
    });
}

- (void)requestSource:(NSUInteger)source allowFallback:(BOOL)allowFallback generation:(NSUInteger)generation {
    if (![self isCurrentGeneration:generation]) return;
    NSString *address=source==0 ? @"https://api.qemao.com/api/Verse/" : @"https://api.yujn.cn/api/sjyy.php";
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:address] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:8];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    __weak typeof(self) weakSelf=self;
    _task=[_session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        CSPluginVerseProvider *live=weakSelf;
        if (!live) return;
        dispatch_async(live->_queue, ^{
            if (![live isCurrentGeneration:generation]) return;
            NSHTTPURLResponse *http=[response isKindOfClass:NSHTTPURLResponse.class] ? (NSHTTPURLResponse *)response : nil;
            NSString *body=(!error && http.statusCode >= 200 && http.statusCode < 300 && data.length && data.length <= CSPluginVerseMaximumResponseBytes) ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
            NSString *verse=source==0 ? CSPluginVerseTextFromResponse(body) : CSPluginQuoteTextFromResponse(body);
            live->_task=nil;
            BOOL repeated=verse && live->_cachedAt && [verse isEqual:[live currentVerse]];
            if (allowFallback && (!verse || repeated)) {
                [live requestSource:1-source allowFallback:NO generation:generation];
                return;
            }
            if (verse) {
                @synchronized(live) {
                    if (generation!=live->_generation) return;
                    live->_cachedVerse=verse;
                    live->_cachedAt=live->_clock();
                    live->_cachedQuote=source==1;
                }
                [live saveCache];
            }
            void (^completion)(NSString *)=live->_completion;
            live->_completion=nil;
            if (completion) [live deliverVerse:[live currentVerse] completion:completion generation:generation];
        });
    }];
    [_task resume];
}

- (void)dealloc { [_session invalidateAndCancel]; }
@end
