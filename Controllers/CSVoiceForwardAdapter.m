#import "CSVoiceForwardAdapter.h"
#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>
NSString *CSMessageForwardTargetID(id contact) {
    id name=CSMessageActionObjectGetter(contact,NSSelectorFromString(@"m_nsUsrName"));
    return [name isKindOfClass:NSString.class] && [name length] ? [name copy] : nil;
}
@interface CSMessageForwardBinding ()
@property(nonatomic, weak) id sourceWrap;
@property(nonatomic) NSUInteger messageType;
@property(nonatomic) unsigned long long localID, serverID;
@property(nonatomic, copy) NSString *fromUser, *toUser;
@end
@implementation CSMessageForwardBinding
@end
@implementation CSVoiceForwardAdapter
static const void *CSForwardBindingKey=&CSForwardBindingKey;
- (CSMessageForwardBinding *)bindingForLogic:(id)logic { return logic ? objc_getAssociatedObject(logic,CSForwardBindingKey) : nil; }
- (BOOL)bindLogic:(id)logic operationID:(NSString *)operationID context:(CSMessageActionContext *)context {
    CSMessageForwardBinding *old=[self bindingForLogic:logic];
    if (!logic || (old && !old.closed)) return old && [old.operationID isEqualToString:operationID];
    CSMessageForwardBinding *binding=[CSMessageForwardBinding new]; binding.operationID=operationID; binding.logic=logic; binding.context=context; binding.sourceWrap=context.sourceWrap; binding.messageType=context.messageType; binding.localID=context.localID; binding.serverID=context.serverID; binding.fromUser=context.outgoing ? context.accountID : context.sourceConversationID; binding.toUser=context.outgoing ? context.sourceConversationID : context.accountID;
    objc_setAssociatedObject(logic,CSForwardBindingKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC); return YES;
}
- (BOOL)confirmLogic:(id)logic {
    CSMessageForwardBinding *binding=[self bindingForLogic:logic];
    if (!binding || binding.cancelled || binding.confirmed) return NO;
    id contacts=CSMessageActionObjectGetter(logic,NSSelectorFromString(@"getToContacts"));
    if (![contacts isKindOfClass:NSArray.class] || ![contacts count]) return NO;
    NSMutableDictionary *targets=[NSMutableDictionary dictionary];
    for (id contact in contacts) { NSString *name=CSMessageForwardTargetID(contact); if (!name) return NO; if (!targets[name]) targets[name]=contact; }
    binding.targets=[targets copy]; binding.confirmed=YES; return YES;
}
- (BOOL)source:(id)source matchesBinding:(CSMessageForwardBinding *)binding {
    if (binding.context) return [self source:source matchesContext:binding.context];
    if ([source isKindOfClass:NSArray.class]) { if ([source count]!=1) return NO; source=[source firstObject]; }
    if (source && source==binding.sourceWrap) return YES;
    if (CSMessageNativeUnsigned(source,@"m_uiMessageType")!=binding.messageType) return NO;
    unsigned long long local=CSMessageNativeUnsigned(source,@"m_uiMesLocalID"), server=CSMessageNativeUnsigned(source,@"m_n64MesSvrID");
    if (binding.serverID && server && binding.serverID!=server) return NO;
    return ((binding.localID && binding.localID==local) || (binding.serverID && binding.serverID==server)) && [CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsFromUsr")) isEqual:binding.fromUser] && [CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsToUsr")) isEqual:binding.toUser];
}
- (BOOL)source:(id)source matchesContext:(CSMessageActionContext *)context {
    if ([source isKindOfClass:NSArray.class]) { if ([source count]!=1) return NO; source=[source firstObject]; }
    if (source==context.sourceWrap) return YES;
    if (CSMessageNativeUnsigned(source,@"m_uiMessageType")!=context.messageType) return NO;
    unsigned long long local=CSMessageNativeUnsigned(source,@"m_uiMesLocalID"), server=CSMessageNativeUnsigned(source,@"m_n64MesSvrID");
    if (context.serverID && server && context.serverID!=server) return NO;
    if (!(context.localID && context.localID==local) && !(context.serverID && context.serverID==server)) return NO;
    NSString *from=CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsFromUsr")), *to=CSMessageActionObjectGetter(source,NSSelectorFromString(@"m_nsToUsr"));
    return [from isEqualToString:context.outgoing ? context.accountID : context.sourceConversationID] && [to isEqualToString:context.outgoing ? context.sourceConversationID : context.accountID];
}
- (void)resetClosedBindingForLogic:(id)logic {
    if ([self bindingForLogic:logic].closed) objc_setAssociatedObject(logic,CSForwardBindingKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)detachLogic:(id)logic {
    CSMessageForwardBinding *binding=[self bindingForLogic:logic]; if (!binding) return;
    // One compact tombstone per native logic suppresses late duplicate voice callbacks. It owns
    // no source wrap, recipient objects, page, ledger, media, or native service after cleanup.
    binding.closed=YES; binding.cancelled=YES; binding.context=nil; binding.targets=nil;
}
@end
