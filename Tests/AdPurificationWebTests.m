#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSAdPurification.h"

static NSUInteger Checks,EventCalls,EventDeallocations,InvokerCalls,InvokerDeallocations,BridgeCalls,BridgeDeallocations,DefinitionCalls,SearchCalls;
static id LastFirst,LastSecond,LastThird,LastURLInput,ReturnToken,ContextArguments;
static SEL LastSelector;
static int64_t LastType,LastByte;
static uint32_t LastBits;
static uint64_t LastWebType;
static IMP OriginalURL;
#define CHECK(c) do {Checks++;if(!(c)){NSLog(@"Ad web FAIL %d: %s",__LINE__,#c);exit(1);}} while(0)

@interface JSEvent : NSObject
@property(nonatomic,strong) id delegate;
@property(nonatomic,strong) id parameters;
- (instancetype)initWithDelegate:(id)delegate parameters:(id)parameters;
@end
@implementation JSEvent
- (instancetype)initWithDelegate:(id)delegate parameters:(id)parameters {
    if((self=[super init])){EventCalls++;self.delegate=delegate;self.parameters=parameters;}return self;
}
- (void)dealloc {EventDeallocations++;}
@end

@interface WCJSInvoker : NSObject
@property(nonatomic,strong) id object;
@property(nonatomic,strong) id function;
@property(nonatomic,strong) id arguments;
@property(nonatomic,strong) id javascript;
- (instancetype)initWithObj:(id)object Func:(id)function Args:(id)arguments;
- (instancetype)initWithJavascript:(id)javascript;
@end
@implementation WCJSInvoker
- (instancetype)initWithObj:(id)object Func:(id)function Args:(id)arguments {
    if((self=[super init])){self.object=object;self.function=function;self.arguments=arguments;InvokerCalls++;}return self;
}
- (instancetype)initWithJavascript:(id)javascript {
    if((self=[super init])){self.javascript=javascript;InvokerCalls++;}return self;
}
- (void)dealloc {InvokerDeallocations++;}
@end
@interface WAJSInvoker : WCJSInvoker
- (id)invokeInJsContext:(id)context;
@end
@implementation WAJSInvoker
- (id)invokeInJsContext:(id)context {LastFirst=context;InvokerCalls++;return ReturnToken;}
@end
@interface JSContext : NSObject
+ (id)currentArguments;
@end
@implementation JSContext
+ (id)currentArguments {return ContextArguments;}
@end
@interface CSAdThrowingDescription : NSObject @end
@implementation CSAdThrowingDescription
- (NSString *)description {@throw [NSException exceptionWithName:@"fixture" reason:nil userInfo:nil];}
@end

@interface LocalJSEventHandler_WebAPIBridge : NSObject
@property(nonatomic,strong) id event;
@property(nonatomic,strong) id context;
- (instancetype)initWithEvent:(id)event context:(id)context;
@end
@implementation LocalJSEventHandler_WebAPIBridge
- (instancetype)initWithEvent:(id)event context:(id)context {
    if((self=[super init])){self.event=event;self.context=context;BridgeCalls++;}return self;
}
- (void)dealloc {BridgeDeallocations++;}
@end

@interface JSFunctionDef : NSObject
+ (id)FuncDefWithFunc:(id)function Selector:(SEL)selector FuncType:(int64_t)type PermissionBitSet:(uint32_t)bits RunInWebViewType:(uint64_t)webType;
+ (id)FuncDefWithFunc:(id)function Selector:(SEL)selector FuncType:(int64_t)type PermissionBitSet2:(uint32_t)bits RunInWebViewType:(uint64_t)webType;
+ (id)FuncDefWithFunc:(id)function Selector:(SEL)selector FuncType:(int64_t)type PermissionBitSet3:(uint32_t)bits RunInWebViewType:(uint64_t)webType;
+ (id)FuncDefWithFunc:(id)function Selector:(SEL)selector FuncType:(int64_t)type PermissionByteIndex:(int64_t)byte RunInWebViewType:(uint64_t)webType;
@end
static id CaptureDefinition(id function,SEL selector,int64_t type,uint32_t bits,uint64_t webType) {
    DefinitionCalls++;LastFirst=function;LastSelector=selector;LastType=type;LastBits=bits;LastWebType=webType;return ReturnToken;
}
@implementation JSFunctionDef
+ (id)FuncDefWithFunc:(id)function Selector:(SEL)selector FuncType:(int64_t)type PermissionBitSet:(uint32_t)bits RunInWebViewType:(uint64_t)webType {return CaptureDefinition(function,selector,type,bits,webType);}
+ (id)FuncDefWithFunc:(id)function Selector:(SEL)selector FuncType:(int64_t)type PermissionBitSet2:(uint32_t)bits RunInWebViewType:(uint64_t)webType {return CaptureDefinition(function,selector,type,bits,webType);}
+ (id)FuncDefWithFunc:(id)function Selector:(SEL)selector FuncType:(int64_t)type PermissionBitSet3:(uint32_t)bits RunInWebViewType:(uint64_t)webType {return CaptureDefinition(function,selector,type,bits,webType);}
+ (id)FuncDefWithFunc:(id)function Selector:(SEL)selector FuncType:(int64_t)type PermissionByteIndex:(int64_t)byte RunInWebViewType:(uint64_t)webType {LastByte=byte;return CaptureDefinition(function,selector,type,0,webType);}
@end

@interface LocalJSLogicBase : NSObject
- (void)sendEvent:(id)event handler:(id)handler result:(id)result;
@end
@implementation LocalJSLogicBase
- (void)sendEvent:(id)event handler:(id)handler result:(id)result {SearchCalls++;LastFirst=event;LastSecond=handler;LastThird=result;}
@end
@interface WXSearchJSLogicImpl : NSObject
- (void)functionCall:(id)function withParams:(id)parameters withCallbackID:(id)callback;
@end
@implementation WXSearchJSLogicImpl
- (void)functionCall:(id)function withParams:(id)parameters withCallbackID:(id)callback {SearchCalls++;LastFirst=function;LastSecond=parameters;LastThird=callback;}
@end

void CSAdPurificationInstallNativeHooks(void) {}
void CSAdPurificationTestHookMessage(Class cls,SEL selector,IMP replacement,IMP *original) {
    Method method=class_getInstanceMethod(cls,selector);*original=method_getImplementation(method);
    if(!class_addMethod(cls,selector,replacement,method_getTypeEncoding(method)))method_setImplementation(method,replacement);
}
static id TrackURL(id cls,SEL selector,id input) {
    LastURLInput=input;return ((id(*)(id,SEL,id))OriginalURL)(cls,selector,input);
}
static void Configure(NSUserDefaults *defaults,NSArray *identifiers) {
    [defaults setBool:YES forKey:CSAdPurificationEnabledKey];
    for(NSDictionary *option in CSAdPurificationOptions())
        [defaults setBool:[identifiers containsObject:option[@"identifier"]] forKey:CSAdPurificationPreferenceKey(option[@"identifier"])];
    CSAdPurificationRefresh();
}
static NSDictionary *SearchPayload(NSArray *items) {
    NSDictionary *json=@{@"cgiName":@"SearchGuide",@"data":@[@{@"items":items}],@"keep":@7};
    NSData *encoded=[NSJSONSerialization dataWithJSONObject:json options:0 error:NULL];
    return @{@"json":[[NSString alloc]initWithData:encoded encoding:NSUTF8StringEncoding],@"callback":@"unchanged"};
}
static id Definition(NSString *name,id function,SEL target) {
    return ((id(*)(id,SEL,id,SEL,int64_t,uint32_t,uint64_t))objc_msgSend)(JSFunctionDef.class,NSSelectorFromString(name),function,target,INT64_MIN,UINT32_C(0x80000001),UINT64_MAX);
}
int main(void) {@autoreleasepool {
    Method url=class_getClassMethod(NSURL.class,@selector(URLWithString:));OriginalURL=method_getImplementation(url);method_setImplementation(url,(IMP)TrackURL);
    NSString *suite=[@"CSAdWebTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    CSAdPurificationUseTestDefaults(defaults);CSAdPurificationStart();CHECK(CSAdPurificationInstalledHookCount()==0);
    ReturnToken=[NSObject new];NSObject *context=[NSObject new],*delegate=[NSObject new];
    NSString *adFunction=@"getAdIdInfo",*callbackFunction=@"callback",*ordinaryFunction=@"ordinary",*scriptText=@"getadvert()",*reportFunction=@"adDataReport";
    NSMutableString *article=[@"https://mp.weixin.qq.com/mp/getappmsgad?x=1" mutableCopy];
    NSMutableString *ordinary=[@"https://example.com/read?ad_data=1" mutableCopy];
    NSMutableString *moment=[@"https://wxsnsdy.wxs.qq.com/video.mp4" mutableCopy];
    NSMutableString *mini=[@"https://example.com/lib/WAAppAd.js" mutableCopy];
    NSDictionary *adParameters=@{@"reqUrl":@"https://mp.weixin.qq.com/mp/getappmsgad"};
    Configure(defaults,@[@"articles"]);
    CHECK([[[NSURL URLWithString:article]absoluteString]isEqual:@"/t"] && [LastURLInput isEqual:@"/t"]);
    [NSURL URLWithString:ordinary];CHECK(LastURLInput==ordinary);
    [NSURL URLWithString:moment];CHECK(LastURLInput==moment);[NSURL URLWithString:mini];CHECK(LastURLInput==mini);
    NSUInteger eventDeaths=EventDeallocations;
    CHECK([[JSEvent alloc]initWithDelegate:delegate parameters:adParameters]==nil);
    CHECK(EventDeallocations==eventDeaths+1 && EventCalls==0);
    @autoreleasepool {
        NSDictionary *normal=@{@"reqUrl":@"https://example.com/read"};
        JSEvent *event=[[JSEvent alloc]initWithDelegate:delegate parameters:normal];CHECK(event.delegate==delegate && event.parameters==normal);
    }
    CHECK(EventDeallocations==eventDeaths+2 && EventCalls==1);
    @autoreleasepool {
        LocalJSEventHandler_WebAPIBridge *bridge=[[LocalJSEventHandler_WebAPIBridge alloc]initWithEvent:adFunction context:context];
        CHECK(bridge.event==adFunction && bridge.context==context);
    }
    Configure(defaults,@[@"mini_programs"]);
    [NSURL URLWithString:mini];CHECK([LastURLInput isEqual:@"/t"]);[NSURL URLWithString:article];CHECK(LastURLInput==article);
    NSUInteger invokerDeaths=InvokerDeallocations,invokerCalls=InvokerCalls;
    CHECK([[WAJSInvoker alloc]initWithJavascript:@"getadvert()"]==nil);
    CHECK(InvokerDeallocations==invokerDeaths+1 && InvokerCalls==invokerCalls);
    @autoreleasepool {
        NSString *script=@"getadvert()";
        WCJSInvoker *generic=[[WCJSInvoker alloc]initWithJavascript:script];CHECK(generic.javascript==script);
        WAJSInvoker *library=[[WAJSInvoker alloc]initWithJavascript:@"this.__wxLibrary.getadvert()"];CHECK(library!=nil);
    }
    CHECK(InvokerDeallocations==invokerDeaths+3);
    NSDictionary *args=@{@"nested":@[@"advert_group",@"unchanged"],@"token":@9};
    @autoreleasepool {
        WAJSInvoker *wa=[[WAJSInvoker alloc]initWithObj:delegate Func:callbackFunction Args:args];
        CHECK(wa.object==delegate && wa.function==callbackFunction && wa.arguments!=args);
        CHECK([wa.arguments[@"nested"][0]isEqual:@"orz"] && [args[@"nested"][0]isEqual:@"advert_group"]);
        WCJSInvoker *generic=[[WCJSInvoker alloc]initWithObj:delegate Func:@"callback" Args:args];CHECK(generic.arguments==args);
        NSDictionary *clean=@{@"nested":@[@"unchanged"]};
        WAJSInvoker *unchanged=[[WAJSInvoker alloc]initWithObj:delegate Func:@"callback" Args:clean];CHECK(unchanged.arguments==clean);
    }
    WAJSInvoker *wa=[WAJSInvoker new];
    ContextArguments=@[@"getAdPreloadData"];
    CHECK([wa invokeInJsContext:context]==ReturnToken && LastFirst==nil);
    ContextArguments=@[@"normal"];
    CHECK([wa invokeInJsContext:context]==ReturnToken && LastFirst==context);
    ContextArguments=@[[CSAdThrowingDescription new]];
    CHECK([wa invokeInJsContext:context]==ReturnToken && LastFirst==context);
    ContextArguments=@"unexpected";CHECK([wa invokeInJsContext:context]==ReturnToken && LastFirst==context);
    NSMutableArray *tooMany=[NSMutableArray array];for(NSUInteger i=0;i<1025;i++)[tooMany addObject:@"getadvert"];
    ContextArguments=tooMany;
    CHECK([wa invokeInJsContext:context]==ReturnToken && LastFirst==context);
    Configure(defaults,@[@"moments"]);
    [NSURL URLWithString:moment];CHECK([LastURLInput isEqual:@"/t"]);
    [NSURL URLWithString:article];CHECK(LastURLInput==article);
    [NSURL URLWithString:mini];CHECK(LastURLInput==mini);
    Configure(defaults,@[@"search"]);
    LocalJSLogicBase *logic=[LocalJSLogicBase new];WXSearchJSLogicImpl *search=[WXSearchJSLogicImpl new];
    NSDictionary *organic=@{@"title":@"advertisement_ appears in normal text",@"id":@1};
    NSDictionary *ad=@{@"isAd":@YES,@"id":@2};
    NSDictionary *payload=SearchPayload(@[organic,ad]);
    NSString *eventName=@"onSearchWebQueryReady",*handler=@"handler querySearchWeb #1";
    [logic sendEvent:eventName handler:handler result:payload];
    CHECK(LastFirst==eventName && LastSecond==handler && LastThird!=payload);
    NSDictionary *cleanJSON=[NSJSONSerialization JSONObjectWithData:[LastThird[@"json"]dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    CHECK([cleanJSON[@"data"][0][@"items"]count]==1 && [cleanJSON[@"data"][0][@"items"][0]isEqual:organic]);
    CHECK([LastThird[@"callback"]isEqual:@"unchanged"] && [cleanJSON[@"keep"]isEqual:@7]);
    CHECK([[[NSJSONSerialization JSONObjectWithData:[payload[@"json"]dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]objectForKey:@"data"][0][@"items"]count]==2);
    NSDictionary *noAds=SearchPayload(@[organic]);[logic sendEvent:eventName handler:handler result:noAds];CHECK(LastThird==noAds);
    [logic sendEvent:@"otherEvent" handler:handler result:payload];CHECK(LastThird==payload);
    [logic sendEvent:eventName handler:@"other handler" result:payload];CHECK(LastThird==payload);
    [logic sendEvent:eventName handler:[CSAdThrowingDescription new] result:payload];CHECK(LastThird==payload);
    NSDictionary *malformed=@{@"json":@"{oops"};[logic sendEvent:eventName handler:handler result:malformed];CHECK(LastThird==malformed);
    NSUInteger searchBefore=SearchCalls;[search functionCall:@"adDataReport" withParams:payload withCallbackID:context];CHECK(SearchCalls==searchBefore);
    [search functionCall:@"reportSearchStatistics" withParams:payload withCallbackID:context];CHECK(SearchCalls==searchBefore+1 && LastSecond==payload && LastThird==context);

    NSArray *all=@[@"articles",@"subscriptions",@"moments",@"finder",@"mini_programs",@"search"];
    Configure(defaults,all);NSUInteger installed=CSAdPurificationInstalledHookCount();CSAdPurificationRefresh();CHECK(installed==CSAdPurificationInstalledHookCount());
    NSArray *definitions=@[@"FuncDefWithFunc:Selector:FuncType:PermissionBitSet:RunInWebViewType:",@"FuncDefWithFunc:Selector:FuncType:PermissionBitSet2:RunInWebViewType:",@"FuncDefWithFunc:Selector:FuncType:PermissionBitSet3:RunInWebViewType:"];
    SEL target=NSSelectorFromString(@"nativeCallback:context:");
    for(NSString *name in definitions) {
        NSUInteger before=DefinitionCalls;CHECK(Definition(name,@"getAdIdInfo",target)==nil && DefinitionCalls==before);
        CHECK(Definition(name,ordinaryFunction,target)==ReturnToken && LastFirst==ordinaryFunction && LastSelector==target && LastType==INT64_MIN && LastBits==UINT32_C(0x80000001) && LastWebType==UINT64_MAX);
    }
    CHECK([JSFunctionDef FuncDefWithFunc:@"ordinary" Selector:target FuncType:INT64_MIN PermissionByteIndex:INT64_MIN RunInWebViewType:UINT64_MAX]==ReturnToken);
    CHECK(LastSelector==target && LastType==INT64_MIN && LastByte==INT64_MIN && LastWebType==UINT64_MAX);
    CHECK([JSFunctionDef FuncDefWithFunc:adFunction Selector:target FuncType:INT64_MIN PermissionByteIndex:INT64_MIN RunInWebViewType:UINT64_MAX]==nil);
    @autoreleasepool {
        WCJSInvoker *shared=[[WCJSInvoker alloc]initWithObj:delegate Func:callbackFunction Args:args];
        CHECK(shared.arguments!=args && [shared.arguments[@"nested"][0]isEqual:@"orz"] && shared.object==delegate && shared.function==callbackFunction);
    }
    NSUInteger bridgeDeaths=BridgeDeallocations,bridgeCalls=BridgeCalls;
    CHECK([[LocalJSEventHandler_WebAPIBridge alloc]initWithEvent:@"openADCanvas" context:context]==nil);
    CHECK(BridgeDeallocations==bridgeDeaths+1 && BridgeCalls==bridgeCalls);
    invokerDeaths=InvokerDeallocations;CHECK([[WCJSInvoker alloc]initWithJavascript:@"getadvert()"]==nil);CHECK(InvokerDeallocations==invokerDeaths+1);
    for(NSString *excluded in all) {
        NSMutableArray *partial=[all mutableCopy];[partial removeObject:excluded];Configure(defaults,partial);
        CHECK(Definition(definitions[0],@"getAdIdInfo",target)==ReturnToken);
        @autoreleasepool {
            LocalJSEventHandler_WebAPIBridge *bridge=[[LocalJSEventHandler_WebAPIBridge alloc]initWithEvent:@"openADCanvas" context:context];CHECK(bridge.context==context);
            NSString *script=@"getadvert()";WCJSInvoker *generic=[[WCJSInvoker alloc]initWithJavascript:script];CHECK(generic.javascript==script);
        }
    }
    Configure(defaults,all);CSAdPurificationSetSetting(CSAdPurificationEnabledKey,NO);CHECK(CSAdPurificationActiveScopes()==0);
    ContextArguments=@[@"getadvert"];
    CHECK([wa invokeInJsContext:context]==ReturnToken && LastFirst==context);
    [NSURL URLWithString:article];CHECK(LastURLInput==article);[NSURL URLWithString:mini];CHECK(LastURLInput==mini);[NSURL URLWithString:moment];CHECK(LastURLInput==moment);
    eventDeaths=EventDeallocations;invokerDeaths=InvokerDeallocations;bridgeDeaths=BridgeDeallocations;
    @autoreleasepool {
        JSEvent *event=[[JSEvent alloc]initWithDelegate:delegate parameters:adParameters];CHECK(event.delegate==delegate && event.parameters==adParameters);
        WCJSInvoker *generic=[[WCJSInvoker alloc]initWithObj:delegate Func:context Args:args];CHECK(generic.object==delegate && generic.function==context && generic.arguments==args);
        WAJSInvoker *miniInvoker=[[WAJSInvoker alloc]initWithJavascript:scriptText];CHECK(miniInvoker.javascript==scriptText);
        LocalJSEventHandler_WebAPIBridge *bridge=[[LocalJSEventHandler_WebAPIBridge alloc]initWithEvent:adFunction context:context];CHECK(bridge.event==adFunction && bridge.context==context);
    }
    CHECK(EventDeallocations==eventDeaths+1 && InvokerDeallocations==invokerDeaths+2 && BridgeDeallocations==bridgeDeaths+1);
    [logic sendEvent:eventName handler:handler result:payload];CHECK(LastThird==payload);
    searchBefore=SearchCalls;[search functionCall:reportFunction withParams:payload withCallbackID:context];CHECK(SearchCalls==searchBefore+1 && LastFirst==reportFunction && LastSecond==payload && LastThird==context);
    for(NSString *name in definitions)CHECK(Definition(name,@"getAdIdInfo",target)==ReturnToken && LastType==INT64_MIN && LastBits==UINT32_C(0x80000001) && LastWebType==UINT64_MAX);
    CHECK([JSFunctionDef FuncDefWithFunc:@"adDataReport" Selector:target FuncType:INT64_MIN PermissionByteIndex:INT64_MIN RunInWebViewType:UINT64_MAX]==ReturnToken && LastByte==INT64_MIN && LastSelector==target);
    [defaults removePersistentDomainForName:suite];printf("Ad purification web: %lu checks passed\n",(unsigned long)Checks);
}return 0;}
