#import "CSAdPurification.h"
#import "CSAdPurificationFilters.h"
#import "CSCloseFriendSignatures.h"
#import <objc/message.h>

// A shared bridge-definition call does not identify its owning product. It is
// filtered only when all advertising ranges are enabled. Product-specific entry
// points below remain independently useful with just their own range enabled.
static const CSAdPurificationScope SharedBridgeScopes = CSAdPurificationArticles |
    CSAdPurificationSubscriptions | CSAdPurificationMoments | CSAdPurificationFinder |
    CSAdPurificationMiniPrograms | CSAdPurificationSearch;
static BOOL SharedBridgeEnabled(void) {
    return (CSAdPurificationActiveScopes() & SharedBridgeScopes) == SharedBridgeScopes;
}
static BOOL MiniProgramInvoker(id object) {
    Class cls = NSClassFromString(@"WAJSInvoker"); return cls && [object isKindOfClass:cls];
}
static BOOL InvokerEnabled(id object) {
    return MiniProgramInvoker(object) ? CSAdPurificationShouldApply(CSAdPurificationMiniPrograms) : SharedBridgeEnabled();
}

// Initializers consume their receiver and return +1. A normal id-returning block
// would use the wrong ARC ownership convention even with a matching type encoding.
typedef id (*CSAdInit1)(id __attribute__((ns_consumed)), SEL, id) __attribute__((ns_returns_retained));
typedef id (*CSAdInit2)(id __attribute__((ns_consumed)), SEL, id, id) __attribute__((ns_returns_retained));
typedef id (*CSAdInit3)(id __attribute__((ns_consumed)), SEL, id, id, id) __attribute__((ns_returns_retained));
static IMP EventOriginal, ArgumentsOriginal, JavascriptOriginal, WebBridgeOriginal;

static id EventInit(id receiver __attribute__((ns_consumed)), SEL command, id delegate, id parameters) __attribute__((ns_returns_retained));
static id EventInit(id receiver __attribute__((ns_consumed)), SEL command, id delegate, id parameters) {
    if (CSAdPurificationShouldApply(CSAdPurificationArticles) && CSAdPurificationArticleEventIsAd(parameters)) return nil;
    return ((CSAdInit2)EventOriginal)(receiver, command, delegate, parameters);
}
static id ArgumentsInit(id receiver __attribute__((ns_consumed)), SEL command, id object, id function, id arguments) __attribute__((ns_returns_retained));
static id ArgumentsInit(id receiver __attribute__((ns_consumed)), SEL command, id object, id function, id arguments) {
    if (InvokerEnabled(receiver)) arguments = CSAdPurificationProcessObject(arguments);
    return ((CSAdInit3)ArgumentsOriginal)(receiver, command, object, function, arguments);
}
static id JavascriptInit(id receiver __attribute__((ns_consumed)), SEL command, id javascript) __attribute__((ns_returns_retained));
static id JavascriptInit(id receiver __attribute__((ns_consumed)), SEL command, id javascript) {
    if (InvokerEnabled(receiver) && CSAdPurificationTextIsAd(javascript)) return nil;
    return ((CSAdInit1)JavascriptOriginal)(receiver, command, javascript);
}
static id WebBridgeInit(id receiver __attribute__((ns_consumed)), SEL command, id event, id context) __attribute__((ns_returns_retained));
static id WebBridgeInit(id receiver __attribute__((ns_consumed)), SEL command, id event, id context) {
    if (SharedBridgeEnabled() && [event isKindOfClass:NSString.class] &&
        [@[@"getAdIdInfo", @"adDataReport", @"openADCanvas"] containsObject:event]) return nil;
    return ((CSAdInit2)WebBridgeOriginal)(receiver, command, event, context);
}

static void InstallURLHook(void) {
    if (!CSAdPurificationShouldApply(CSAdPurificationArticles | CSAdPurificationMoments | CSAdPurificationMiniPrograms)) return;
    SEL selector = @selector(URLWithString:); __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id object, id string) {
        CSAdPurificationScope scopes = CSAdPurificationActiveScopes();
        id input = scopes ? CSAdPurificationURLString(string, scopes) : string;
        return ((id (*)(id, SEL, id))original)(object, selector, input);
    });
    CSAdPurificationInstallHook(@"NSURL", @"URLWithString:", YES, "@@:@", replacement, &original);
}
static void InstallFunctionDefinitions(void) {
    if (!SharedBridgeEnabled()) return;
    for (NSString *name in @[@"FuncDefWithFunc:Selector:FuncType:PermissionBitSet:RunInWebViewType:",
        @"FuncDefWithFunc:Selector:FuncType:PermissionBitSet2:RunInWebViewType:",
        @"FuncDefWithFunc:Selector:FuncType:PermissionBitSet3:RunInWebViewType:"]) {
        SEL selector = NSSelectorFromString(name); __block IMP original = NULL;
        IMP replacement = imp_implementationWithBlock(^id(id object, id function, SEL target, int64_t type, uint32_t bits, uint64_t webType) {
            if (SharedBridgeEnabled() && CSAdPurificationDisallowedBridgeFunction(function)) return nil;
            return ((id (*)(id, SEL, id, SEL, int64_t, uint32_t, uint64_t))original)(object, selector, function, target, type, bits, webType);
        });
        CSAdPurificationInstallHook(@"JSFunctionDef", name, YES, "@@:@:qIQ", replacement, &original);
    }
    SEL selector = NSSelectorFromString(@"FuncDefWithFunc:Selector:FuncType:PermissionByteIndex:RunInWebViewType:"); __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id object, id function, SEL target, int64_t type, int64_t byteIndex, uint64_t webType) {
        if (SharedBridgeEnabled() && CSAdPurificationDisallowedBridgeFunction(function)) return nil;
        return ((id (*)(id, SEL, id, SEL, int64_t, int64_t, uint64_t))original)(object, selector, function, target, type, byteIndex, webType);
    });
    CSAdPurificationInstallHook(@"JSFunctionDef", NSStringFromSelector(selector), YES, "@@:@:qqQ", replacement, &original);
}
static BOOL CurrentMiniProgramArgumentsAreAd(void) {
    Class cls = NSClassFromString(@"JSContext"); SEL selector = NSSelectorFromString(@"currentArguments");
    Method method = cls ? class_getClassMethod(cls, selector) : NULL;
    if (!CSCloseFriendMethodMatches(method, "@@:")) return NO;
    @try {
        id args = ((id (*)(id, SEL))objc_msgSend)(cls, selector);
        if (![args isKindOfClass:NSArray.class] || [args count] > 1024) return NO;
        for (id argument in args) {
            id text = [argument isKindOfClass:NSString.class] ? argument : [argument description];
            if (CSAdPurificationTextIsAd(text)) return YES;
        }
    } @catch (__unused NSException *exception) { return NO; }
    return NO;
}
static void InstallMiniProgramInvoker(void) {
    if (!CSAdPurificationShouldApply(CSAdPurificationMiniPrograms)) return;
    SEL selector = NSSelectorFromString(@"invokeInJsContext:"); __block IMP original = NULL;
    IMP replacement = imp_implementationWithBlock(^id(id object, id context) {
        if (CSAdPurificationShouldApply(CSAdPurificationMiniPrograms) && CurrentMiniProgramArgumentsAreAd()) context = nil;
        return ((id (*)(id, SEL, id))original)(object, selector, context);
    });
    CSAdPurificationInstallHook(@"WAJSInvoker", NSStringFromSelector(selector), NO, "@@:@", replacement, &original);
}
static void InstallSearchHooks(void) {
    if (!CSAdPurificationShouldApply(CSAdPurificationSearch)) return;
    SEL call = NSSelectorFromString(@"functionCall:withParams:withCallbackID:"); __block IMP callOriginal = NULL;
    IMP callReplacement = imp_implementationWithBlock(^(id object, id function, id parameters, id callback) {
        if (CSAdPurificationShouldApply(CSAdPurificationSearch) && [function isKindOfClass:NSString.class] &&
            [@[@"adDataReport", @"getAdIdInfo"] containsObject:function]) return;
        ((void (*)(id, SEL, id, id, id))callOriginal)(object, call, function, parameters, callback);
    });
    CSAdPurificationInstallHook(@"WXSearchJSLogicImpl", NSStringFromSelector(call), NO, "v@:@@@", callReplacement, &callOriginal);
    SEL event = NSSelectorFromString(@"sendEvent:handler:result:"); __block IMP eventOriginal = NULL;
    IMP eventReplacement = imp_implementationWithBlock(^(id object, id name, id handler, id result) {
        if (CSAdPurificationShouldApply(CSAdPurificationSearch)) {
            @try {
                id description = [handler isKindOfClass:NSString.class] ? handler : [handler description];
                result = CSAdPurificationSearchResult(name, description, result);
            } @catch (__unused NSException *exception) { /* Keep original result. */ }
        }
        ((void (*)(id, SEL, id, id, id))eventOriginal)(object, event, name, handler, result);
    });
    CSAdPurificationInstallHook(@"LocalJSLogicBase", NSStringFromSelector(event), NO, "v@:@@@", eventReplacement, &eventOriginal);
}
void CSAdPurificationInstallWebHooks(void) {
    InstallURLHook(); InstallSearchHooks(); InstallMiniProgramInvoker(); InstallFunctionDefinitions();
    if (CSAdPurificationShouldApply(CSAdPurificationArticles))
        CSAdPurificationInstallHook(@"JSEvent", @"initWithDelegate:parameters:", NO, "@@:@@", (IMP)EventInit, &EventOriginal);
    if (CSAdPurificationShouldApply(CSAdPurificationMiniPrograms) || SharedBridgeEnabled()) {
        CSAdPurificationInstallHook(@"WCJSInvoker", @"initWithObj:Func:Args:", NO, "@@:@@@", (IMP)ArgumentsInit, &ArgumentsOriginal);
        CSAdPurificationInstallHook(@"WCJSInvoker", @"initWithJavascript:", NO, "@@:@", (IMP)JavascriptInit, &JavascriptOriginal);
    }
    if (SharedBridgeEnabled())
        CSAdPurificationInstallHook(@"LocalJSEventHandler_WebAPIBridge", @"initWithEvent:context:", NO, "@@:@@", (IMP)WebBridgeInit, &WebBridgeOriginal);
}
