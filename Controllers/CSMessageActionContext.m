#import "CSMessageActionContext.h"
#import "CSMessageActionDiagnostics.h"
#import <objc/runtime.h>
#import <objc/message.h>
#include <string.h>

// No dynamic forwarding/KVC: invoke only a concrete method with the exact supported ABI.
static Method CSActionMethod(id object, SEL selector, unsigned arguments) {
    if (!object) return NULL;
    Method method=class_getInstanceMethod(object_getClass(object),selector);
    return method && method_getNumberOfArguments(method)==arguments ? method : NULL;
}
static char CSActionReturnType(Method method) {
    char type[64]={0};
    if (method) method_getReturnType(method,type,sizeof(type));
    // Skip Objective-C type qualifiers, preserving the actual ABI type.
    const char *p=type;
    while (*p && strchr("rnNoORV",*p)) p++;
    return *p;
}
id CSMessageActionObjectGetter(id object, SEL selector) {
    Method method=CSActionMethod(object,selector,2);
    if (CSActionReturnType(method)!='@') return nil;
    @try { return ((id (*)(id,SEL))objc_msgSend)(object,selector); }
    @catch (__unused NSException *exception) { return nil; }
}
static NSString *CSActionString(id object, SEL selector) {
    id value=CSMessageActionObjectGetter(object,selector);
    return [value isKindOfClass:NSString.class] ? value : nil;
}
static unsigned long long CSActionUnsigned(id object, SEL selector) {
    Method method=CSActionMethod(object,selector,2);
    @try {
        switch (CSActionReturnType(method)) {
            case 'I': return ((unsigned int (*)(id,SEL))objc_msgSend)(object,selector);
            case 'Q': return ((unsigned long long (*)(id,SEL))objc_msgSend)(object,selector);
            case 'L': return ((unsigned long (*)(id,SEL))objc_msgSend)(object,selector);
            case 'i': { int n=((int (*)(id,SEL))objc_msgSend)(object,selector); return n>0 ? (unsigned)n : 0; }
            case 'q': { long long n=((long long (*)(id,SEL))objc_msgSend)(object,selector); return n>0 ? (unsigned long long)n : 0; }
            case 'l': { long n=((long (*)(id,SEL))objc_msgSend)(object,selector); return n>0 ? (unsigned long)n : 0; }
            default: return 0;
        }
    } @catch (__unused NSException *exception) { return 0; }
}
// NO is an authoritative result, not a reason to try unrelated sender flags.
static BOOL CSActionNativeOutgoing(id wrap, BOOL *outgoing) {
    Class cls=object_getClass(wrap); // instance's actual class, not a process-wide service cache
    SEL selector=NSSelectorFromString(@"isSenderFromMsgWrap:");
    Method method=CSActionMethod(cls,selector,3);
    char argument[16]={0};
    if (method) method_getArgumentType(method,2,argument,sizeof(argument));
    char type=CSActionReturnType(method);
    if (!method || (type!='B' && type!='c') || strcmp(argument,"@")!=0) return NO;
    @try {
        if (type=='B') *outgoing=((bool (*)(id,SEL,id))objc_msgSend)(cls,selector,wrap);
        else *outgoing=((signed char (*)(id,SEL,id))objc_msgSend)(cls,selector,wrap)!=0;
        return YES;
    } @catch (__unused NSException *exception) { return NO; }
}
id CSMessageActionResolveSourceWrap(id cell) {
    if (!NSThread.isMainThread) return nil;
    id wrap=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"getCurrentMessageWrap"));
    id model=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"viewModel"));
    // parentModel is authoritative for split text; traverse a bounded, cycle-checked chain.
    NSMutableArray *seen=[NSMutableArray array];
    id root=model;
    while (root && seen.count<16) {
        if ([seen indexOfObjectIdenticalTo:root]!=NSNotFound) return nil;
        [seen addObject:root];
        id parent=CSMessageActionObjectGetter(root,NSSelectorFromString(@"parentModel"));
        if (!parent) break;
        root=parent;
    }
    if (seen.count==16 && CSMessageActionObjectGetter(root,NSSelectorFromString(@"parentModel"))) return nil;
    if (root && root!=model) {
        id parentWrap=CSMessageActionObjectGetter(root,NSSelectorFromString(@"messageWrap"));
        if (parentWrap) return parentWrap;
    }
    if (wrap) return wrap;
    return CSMessageActionObjectGetter(root,NSSelectorFromString(@"messageWrap")) ?:
        CSMessageActionObjectGetter(model,NSSelectorFromString(@"messageWrap"));
}
static NSString *CSActionScope(NSString *account, NSString *chat) {
    // Length delimiters prevent collisions even when native IDs contain separators.
    return [NSString stringWithFormat:@"%lu:%@|%lu:%@",(unsigned long)account.length,account,(unsigned long)chat.length,chat];
}
static const void *CSActionObjectTokenKey=&CSActionObjectTokenKey;
@implementation CSMessageActionContext
+ (instancetype)contextWithCell:(id)cell controller:(id)controller accountID:(NSString *)accountID
    accountEpoch:(NSUInteger)accountEpoch conversationID:(NSString *)conversationID bindingGeneration:(NSUInteger)bindingGeneration {
    if (!NSThread.isMainThread || ![accountID isKindOfClass:NSString.class] || !accountID.length || !accountEpoch) { if (CSMessageActionDiagnostics.isEnabled) [CSMessageActionDiagnostics record:@"context.reject" fields:@{@"reason":@"thread_or_account"}]; return nil; }
    id wrap=CSMessageActionResolveSourceWrap(cell);
    if (!wrap) { if (CSMessageActionDiagnostics.isEnabled) [CSMessageActionDiagnostics record:@"context.reject" fields:@{@"reason":@"source_missing",@"cell":NSStringFromClass([cell class]) ?: @"nil",@"model":NSStringFromClass([CSMessageActionObjectGetter(cell,NSSelectorFromString(@"viewModel")) class]) ?: @"nil"}]; return nil; }
    NSString *from=CSActionString(wrap,NSSelectorFromString(@"m_nsFromUsr"));
    NSString *to=CSActionString(wrap,NSSelectorFromString(@"m_nsToUsr"));
    BOOL outgoing=NO;
    BOOL known=CSActionNativeOutgoing(wrap,&outgoing);
    BOOL fromSelf=[from isEqualToString:accountID], toSelf=[to isEqualToString:accountID];
    if (CSMessageActionDiagnostics.isEnabled) [CSMessageActionDiagnostics record:@"context.source" fields:@{@"cell":NSStringFromClass([cell class]) ?: @"nil",@"model":NSStringFromClass([CSMessageActionObjectGetter(cell,NSSelectorFromString(@"viewModel")) class]) ?: @"nil",@"wrap":NSStringFromClass([wrap class]),@"controller":NSStringFromClass([controller class]) ?: @"nil",@"type":@(CSActionUnsigned(wrap,NSSelectorFromString(@"m_uiMessageType"))),@"hasFrom":@(from.length>0),@"hasTo":@(to.length>0),@"fromSelf":@(fromSelf),@"toSelf":@(toSelf),@"senderKnown":@(known),@"outgoing":@(outgoing)}];
    if (!known) {
        if (fromSelf) outgoing=YES;
        else if (toSelf) outgoing=NO;
        else { [CSMessageActionDiagnostics record:@"context.reject" fields:@{@"reason":@"endpoints_unmatched"}]; return nil; }
    } else if ((outgoing && !fromSelf) || (!outgoing && !toSelf)) { [CSMessageActionDiagnostics record:@"context.reject" fields:@{@"reason":@"direction_unmatched"}]; return nil; }
    NSString *chat=outgoing ? to : from;
    if (!chat.length || (conversationID && (![conversationID isKindOfClass:NSString.class] || ![conversationID isEqualToString:chat]))) { [CSMessageActionDiagnostics record:@"context.reject" fields:@{@"reason":@"conversation_unmatched"}]; return nil; }
    unsigned long long local=CSActionUnsigned(wrap,NSSelectorFromString(@"m_uiMesLocalID"));
    unsigned long long server=CSActionUnsigned(wrap,NSSelectorFromString(@"m_n64MesSvrID"));
    if (!local && !server && !bindingGeneration) { [CSMessageActionDiagnostics record:@"context.reject" fields:@{@"reason":@"identity_missing"}]; return nil; }
    CSMessageActionContext *context=[self new];
    context->_accountID=[accountID copy]; context->_accountEpoch=accountEpoch;
    context->_sourceConversationID=[chat copy]; context->_sourceWrap=wrap;
    context->_cell=cell; context->_controller=controller; context->_outgoing=outgoing;
    context->_bindingGeneration=bindingGeneration; context->_localID=local; context->_serverID=server;
    context->_messageType=(NSUInteger)CSActionUnsigned(wrap,NSSelectorFromString(@"m_uiMessageType"));
    NSString *identity;
    if (server) identity=[NSString stringWithFormat:@"s:%llu",server];
    else if (local) identity=[NSString stringWithFormat:@"l:%llu",local];
    else {
        NSString *token=objc_getAssociatedObject(wrap,CSActionObjectTokenKey);
        if (!token) {
            token=NSUUID.UUID.UUIDString;
            objc_setAssociatedObject(wrap,CSActionObjectTokenKey,token,OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        identity=[NSString stringWithFormat:@"o:%@|b:%lu",token,(unsigned long)bindingGeneration];
    }
    context->_stableMessageIdentity=[[CSActionScope(accountID,chat) stringByAppendingFormat:@"|%@",identity] copy];
    return context;
}
- (BOOL)isValidForAccountID:(NSString *)accountID epoch:(NSUInteger)epoch {
    return _accountID.length && _sourceConversationID.length && _sourceWrap &&
        epoch==_accountEpoch && [_accountID isEqualToString:accountID];
}
- (BOOL)matchesSourceContext:(CSMessageActionContext *)other {
    if (!other || ![self isValidForAccountID:other.accountID epoch:other.accountEpoch] ||
        ![_sourceConversationID isEqualToString:other.sourceConversationID] || _outgoing!=other.outgoing) return NO;
    if (_serverID && other.serverID) return _serverID==other.serverID;
    if (_localID && other.localID) return _localID==other.localID;
    if (_localID || other.localID || _serverID || other.serverID) return NO;
    return _sourceWrap==other.sourceWrap && _bindingGeneration && _bindingGeneration==other.bindingGeneration;
}
@end
