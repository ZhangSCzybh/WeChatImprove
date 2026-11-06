#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>
#import <TargetConditionals.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#endif
#include <string.h>
static const char *CSNativeType(const char *type) { while (*type && strchr("rnNoORV",*type)) type++; return type; }
static BOOL CSNativeTypeMatches(const char *actual, NSString *expected) {
    actual=CSNativeType(actual);
    if ([expected isEqualToString:@"B"]) return *actual=='B' || *actual=='c';
    if ([expected isEqualToString:@"@"]) return *actual=='@';
    return strcmp(actual,expected.UTF8String)==0;
}
// MMServiceCenter returns MMServiceWrapper:NSProxy unless the service opts into raw
// access. Its forwardInvocation: installs the service's account context, so do not
// unwrap it or invoke the service IMP directly. Trust only wrappers obtained from
// our service lookup, and obtain ABI evidence from the requested concrete class.
static const void *CSNativeServiceClassKey=&CSNativeServiceClassKey;
static BOOL CSNativeClassDescendsFrom(Class cls, Class ancestor) {
    if (!ancestor) return NO;
    for (; cls; cls=class_getSuperclass(cls)) if (cls==ancestor) return YES;
    return NO;
}
static BOOL CSNativeIsServiceWrapper(id object) {
    Class cls=object_getClass(object), wrapper=NSClassFromString(@"MMServiceWrapper");
    return CSNativeClassDescendsFrom(cls,wrapper) && CSNativeClassDescendsFrom(wrapper,NSProxy.class);
}
static Method CSNativeMethod(id receiver, SEL selector) {
    if (!receiver) return NULL;
    if (CSNativeIsServiceWrapper(receiver)) {
        Class serviceClass=objc_getAssociatedObject(receiver,CSNativeServiceClassKey);
        return serviceClass ? class_getInstanceMethod(serviceClass,selector) : NULL;
    }
    return class_getInstanceMethod(object_getClass(receiver),selector);
}
// Only the evidenced CMessageWrap -> type-extension forwarding path is eligible.
// Never trust a synthetic method signature or follow an arbitrary forwarding chain.
static id CSNativeReceiver(id receiver, SEL selector) {
    if (!receiver || CSNativeMethod(receiver,selector)) return receiver;
    if (CSNativeIsServiceWrapper(receiver)) return nil;
    Class wrapClass=NSClassFromString(@"CMessageWrap");
    if (!wrapClass || ![receiver isKindOfClass:wrapClass]) return nil;
    SEL extensionSelector=NSSelectorFromString(@"m_extendInfoWithMsgType"), forwardingSelector=@selector(forwardingTargetForSelector:);
    Method getter=class_getInstanceMethod(object_getClass(receiver),extensionSelector), forwarder=class_getInstanceMethod(object_getClass(receiver),forwardingSelector);
    if (!getter || !forwarder || method_getNumberOfArguments(getter)!=2 || method_getNumberOfArguments(forwarder)!=3) return nil;
    char type[128]={0}; method_getReturnType(getter,type,sizeof(type)); if (!CSNativeTypeMatches(type,@"@")) return nil;
    method_getReturnType(forwarder,type,sizeof(type)); if (!CSNativeTypeMatches(type,@"@")) return nil;
    method_getArgumentType(forwarder,2,type,sizeof(type)); if (!CSNativeTypeMatches(type,@":")) return nil;
    @try {
        id extension=((id (*)(id,SEL))method_getImplementation(getter))(receiver,extensionSelector);
        id target=((id (*)(id,SEL,SEL))method_getImplementation(forwarder))(receiver,forwardingSelector,selector);
        if (extension && extension!=receiver && target==extension && class_getInstanceMethod(object_getClass(extension),selector)) return extension;
    } @catch (__unused NSException *exception) {}
    return nil;
}
BOOL CSMessageNativeSupports(id receiver, NSString *selector, NSString *resultType, NSArray<NSString *> *argumentTypes) {
    receiver=CSNativeReceiver(receiver,NSSelectorFromString(selector));
    if (!receiver) return NO;
    Method method=CSNativeMethod(receiver,NSSelectorFromString(selector));
    if (!method || method_getNumberOfArguments(method)!=argumentTypes.count+2) return NO;
    char encoding[128]={0}; method_getReturnType(method,encoding,sizeof(encoding));
    if (!CSNativeTypeMatches(encoding,resultType)) return NO;
    for (NSUInteger i=0;i<argumentTypes.count;i++) { method_getArgumentType(method,(unsigned)i+2,encoding,sizeof(encoding)); if (!CSNativeTypeMatches(encoding,argumentTypes[i])) return NO; }
    return YES;
}
id CSMessageNativeInvoke(id receiver, NSString *selector, NSArray *arguments) {
    SEL sel=NSSelectorFromString(selector);
    receiver=CSNativeReceiver(receiver,sel);
    Method method=CSNativeMethod(receiver,sel);
    if (!method || method_getNumberOfArguments(method)!=arguments.count+2) [NSException raise:NSInvalidArgumentException format:@"Unsupported native ABI"];
    NSMethodSignature *signature=[NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
    NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:signature]; invocation.target=receiver; invocation.selector=sel;
    for (NSUInteger i=0;i<arguments.count;i++) {
        id object=arguments[i]==NSNull.null ? nil : arguments[i]; const char *type=CSNativeType([signature getArgumentTypeAtIndex:i+2]);
        switch (*type) {
            case '#':
            case '@': [invocation setArgument:&object atIndex:i+2]; break;
            case ':': { SEL value=NSSelectorFromString(object); [invocation setArgument:&value atIndex:i+2]; break; }
            case 'B': { bool value=[object boolValue]; [invocation setArgument:&value atIndex:i+2]; break; }
            case 'c': { signed char value=[object charValue]; [invocation setArgument:&value atIndex:i+2]; break; }
            case 'I': { unsigned int value=[object unsignedIntValue]; [invocation setArgument:&value atIndex:i+2]; break; }
            case 'i': { int value=[object intValue]; [invocation setArgument:&value atIndex:i+2]; break; }
            case 'q': { long long value=[object longLongValue]; [invocation setArgument:&value atIndex:i+2]; break; }
            case 'Q': { unsigned long long value=[object unsignedLongLongValue]; [invocation setArgument:&value atIndex:i+2]; break; }
            case 'l': { long value=[object longValue]; [invocation setArgument:&value atIndex:i+2]; break; }
            case 'L': { unsigned long value=[object unsignedLongValue]; [invocation setArgument:&value atIndex:i+2]; break; }
            default: [NSException raise:NSInvalidArgumentException format:@"Unsupported native argument"];
        }
    }
    [invocation invoke];
    const char *type=CSNativeType(signature.methodReturnType);
    switch (*type) {
        case 'v': return nil;
        case '@': { __unsafe_unretained id value=nil; [invocation getReturnValue:&value]; return value; }
        case 'B': { bool value=NO; [invocation getReturnValue:&value]; return @(value); }
        case 'c': { signed char value=0; [invocation getReturnValue:&value]; return @(value); }
        case 'I': { unsigned int value=0; [invocation getReturnValue:&value]; return @(value); }
        case 'i': { int value=0; [invocation getReturnValue:&value]; return @(value); }
        case 'q': { long long value=0; [invocation getReturnValue:&value]; return @(value); }
        case 'Q': { unsigned long long value=0; [invocation getReturnValue:&value]; return @(value); }
        case 'l': { long value=0; [invocation getReturnValue:&value]; return @(value); }
        case 'L': { unsigned long value=0; [invocation getReturnValue:&value]; return @(value); }
        default: [NSException raise:NSInvalidArgumentException format:@"Unsupported native result"];
    }
    return nil;
}
unsigned long long CSMessageNativeUnsigned(id receiver, NSString *selector) {
    @try { receiver=CSNativeReceiver(receiver,NSSelectorFromString(selector)); Method method=CSNativeMethod(receiver,NSSelectorFromString(selector)); char type[32]={0}; if (!method || method_getNumberOfArguments(method)!=2) return 0; method_getReturnType(method,type,sizeof(type)); if (!strchr("BIiQqLl",*CSNativeType(type))) return 0; return [CSMessageNativeInvoke(receiver,selector,@[]) unsignedLongLongValue]; }
    @catch (__unused NSException *exception) { return 0; }
}
id CSMessageActionNativeObject(id receiver, NSString *selector) {
    @try { return CSMessageNativeSupports(receiver,selector,@"@",@[]) ? CSMessageNativeInvoke(receiver,selector,@[]) : nil; }
    @catch (__unused NSException *exception) { return nil; }
}
BOOL CSMessageNativeSet(id receiver, NSString *setter, id value, BOOL required) {
    receiver=CSNativeReceiver(receiver,NSSelectorFromString(setter));
    Method method=CSNativeMethod(receiver,NSSelectorFromString(setter));
    if (!method) return !required;
    char result[16]={0}, argument[128]={0}; method_getReturnType(method,result,sizeof(result)); method_getArgumentType(method,2,argument,sizeof(argument));
    if (method_getNumberOfArguments(method)!=3 || *CSNativeType(result)!='v' || !strchr("@BIicqQlL",*CSNativeType(argument))) return NO;
    CSMessageNativeInvoke(receiver,setter,@[value ?: NSNull.null]); return YES;
}
@interface NSObject (CSNativeAppPath)
+ (void)GetPathOfAppDataByUserName:(NSString *)chat andMessageWrap:(id)wrap retStrPath:(NSString * __autoreleasing *)path;
@end
NSString *CSMessageNativeAppDataPath(CSMessageActionContext *context) {
    Class cls=NSClassFromString(@"CMessageWrap");
    if (!CSMessageNativeSupports(cls,@"GetPathOfAppDataByUserName:andMessageWrap:retStrPath:",@"v",@[@"@",@"@",@"^@"])) return nil;
    @try { NSString *path=nil; [cls GetPathOfAppDataByUserName:context.sourceConversationID andMessageWrap:context.sourceWrap retStrPath:&path]; return [path isKindOfClass:NSString.class] ? [path copy] : nil; } @catch (__unused NSException *exception) { return nil; }
}

@implementation CSMessageNativeEnvironment
- (id)serviceNamed:(NSString *)name {
    Class cls=NSClassFromString(name); if (!cls) return nil;
    id center=CSMessageActionObjectGetter(NSClassFromString(@"MMContext"),NSSelectorFromString(@"currentContext"));
    if (!center) center=CSMessageActionObjectGetter(NSClassFromString(@"MMServiceCenter"),NSSelectorFromString(@"defaultCenter"));
    @try {
        id service=nil;
        // getService: is declared as Class on some versions and id on others (same object ABI).
        if (CSMessageNativeSupports(center,@"getService:",@"@",@[@"#"]) || CSMessageNativeSupports(center,@"getService:",@"@",@[@"@"])) service=CSMessageNativeInvoke(center,@"getService:",@[cls]);
        if (CSNativeIsServiceWrapper(service)) {
            Class registered=objc_getAssociatedObject(service,CSNativeServiceClassKey);
            if (registered && registered!=cls) return nil;
            objc_setAssociatedObject(service,CSNativeServiceClassKey,cls,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return service;
        }
        return CSNativeClassDescendsFrom(object_getClass(service),cls) ? service : nil;
    }
    @catch (__unused NSException *exception) {} return nil;
}
- (NSString *)currentAccountID { id contact=CSMessageActionNativeObject([self serviceNamed:@"CContactMgr"],@"getSelfContact"); id name=CSMessageActionObjectGetter(contact,NSSelectorFromString(@"m_nsUsrName")); return [name isKindOfClass:NSString.class] ? name : nil; }
- (id)controllerForCell:(id)cell {
    Class controllerClass=NSClassFromString(@"BaseMsgContentViewController");
    // Native sticker cells obtain their chat page through BaseChatCellView's weak
    // delegate. Their responder chain is not required to contain that controller.
    id controller=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"getViewController"));
    if (controllerClass && [controller isKindOfClass:controllerClass]) return controller;
    id cursor=cell;
    for (NSUInteger i=0;cursor && i<32;i++) { if (controllerClass && [cursor isKindOfClass:controllerClass]) return cursor; cursor=CSMessageActionObjectGetter(cursor,NSSelectorFromString(@"nextResponder")); } return nil;
}
@end
@implementation CSMessageNativeActionAdapter
- (BOOL)canPerformAction:(CSMessageAction)action context:(CSMessageActionContext *)context {
    if (!context.cell || !context.controller || context.messageType==10000 || context.messageType==10002) return NO;
    NSString *permission=action==CSMessageActionDelete ? @"canShowDeleteMenuItem" : action==CSMessageActionFavorite ? @"canShowFavoriteMenuItem" : (action==CSMessageActionForward && context.messageType!=34) ? @"canShowForwardMenuItem" : nil;
    if (permission && CSMessageNativeSupports(context.cell,permission,@"B",@[])) {
        @try { if (![CSMessageNativeInvoke(context.cell,permission,@[]) boolValue]) return NO; } @catch (__unused NSException *exception) { return NO; }
    }
    switch (action) {
        case CSMessageActionQuote: return CSMessageNativeSupports(context.controller,@"startReplyWithMessageWrap:",@"v",@[@"@"]) || CSMessageNativeSupports(CSMessageActionObjectGetter(context.controller,NSSelectorFromString(@"inputPresenter")),@"replyMessage:becomeFirstResponder:showDisplayName:",@"v",@[@"@",@"B",@"B"]) || CSMessageNativeSupports(context.cell,@"onClickAsRefer",@"v",@[]);
        case CSMessageActionDelete: return CSMessageNativeSupports(context.controller,@"deleteNode:withDB:animated:",@"v",@[@"@",@"B",@"B"]);
        case CSMessageActionForward: return CSMessageNativeSupports(context.cell,@"onForward:",@"v",@[@"@"]);
        case CSMessageActionFavorite: return CSMessageNativeSupports(context.cell,@"doFavorite",@"v",@[]);
        case CSMessageActionRevoke:
            @try { return context.outgoing && CSMessageNativeSupports(context.cell,@"canShowRevokeMsgMenuItemForMessage:",@"B",@[@"@"]) && [CSMessageNativeInvoke(context.cell,@"canShowRevokeMsgMenuItemForMessage:",@[context.sourceWrap]) boolValue] && CSMessageNativeSupports(context.controller,@"revokeMsgByNodeView:",@"v",@[@"@"]); } @catch (__unused NSException *exception) { return NO; }
        default: return NO;
    }
}
- (void)performAction:(CSMessageAction)action context:(CSMessageActionContext *)context valid:(BOOL (^)(void))valid completion:(void (^)(CSMessageActionSubmissionState))completion {
    if (!valid() || ![self canPerformAction:action context:context]) { completion(CSMessageActionSubmissionStateFailedBeforeAcceptance); return; }
    // Pick one complete route before invoking. An exception can follow a UI mutation: never cascade.
    void (^invoke)(void)=^{
        if (!valid() || ![self canPerformAction:action context:context]) { completion(CSMessageActionSubmissionStateCancelled); return; }
        @try {
            switch (action) {
                case CSMessageActionQuote: {
                    id presenter=CSMessageActionObjectGetter(context.controller,NSSelectorFromString(@"inputPresenter"));
                    if (CSMessageNativeSupports(context.controller,@"startReplyWithMessageWrap:",@"v",@[@"@"])) CSMessageNativeInvoke(context.controller,@"startReplyWithMessageWrap:",@[context.sourceWrap]);
                    else if (CSMessageNativeSupports(presenter,@"replyMessage:becomeFirstResponder:showDisplayName:",@"v",@[@"@",@"B",@"B"])) CSMessageNativeInvoke(presenter,@"replyMessage:becomeFirstResponder:showDisplayName:",@[context.sourceWrap,@YES,@YES]);
                    else CSMessageNativeInvoke(context.cell,@"onClickAsRefer",@[]); break;
                }
                case CSMessageActionDelete: CSMessageNativeInvoke(context.controller,@"deleteNode:withDB:animated:",@[context.sourceWrap,@YES,@YES]); break;
                case CSMessageActionRevoke: CSMessageNativeInvoke(context.controller,@"revokeMsgByNodeView:",@[context.sourceWrap]); break;
                case CSMessageActionFavorite: CSMessageNativeInvoke(context.cell,@"doFavorite",@[]); break;
                case CSMessageActionForward: CSMessageNativeInvoke(context.cell,@"onForward:",@[NSNull.null]); break;
                default: completion(CSMessageActionSubmissionStateFailedBeforeAcceptance); return;
            }
            // Native owns UI feedback; a void return is not a delivery/favorite-success claim.
            completion(CSMessageActionSubmissionStateUnknown);
        } @catch (__unused NSException *exception) { completion(CSMessageActionSubmissionStateUnknown); }
    };
    if (action!=CSMessageActionDelete && action!=CSMessageActionRevoke) { invoke(); return; }
#if TARGET_OS_IOS
    NSString *verb=action==CSMessageActionDelete ? @"删除" : @"撤回";
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:[verb stringByAppendingString:@"消息"] message:[NSString stringWithFormat:@"确定要%@这条消息吗？",verb] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *item){ completion(CSMessageActionSubmissionStateCancelled); }]];
    [alert addAction:[UIAlertAction actionWithTitle:verb style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *item){ invoke(); }]];
    [(UIViewController *)context.controller presentViewController:alert animated:YES completion:nil];
#else
    // Host doubles implement the confirmation boundary, allowing identity changes before acceptance.
    if (CSMessageNativeSupports(context.controller,@"cs_confirmMessageAction:",@"v",@[@"@"])) CSMessageNativeInvoke(context.controller,@"cs_confirmMessageAction:",@[invoke]);
    else completion(CSMessageActionSubmissionStateFailedBeforeAcceptance);
#endif
}
@end
