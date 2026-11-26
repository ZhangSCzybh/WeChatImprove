#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSMessageMergePolicy.h"
id CSMessageNativeObject(id object,NSString *selector);
static Method CSGetter(id object, SEL selector) {
    if (!object) return NULL;
    Method method = class_getInstanceMethod(object_getClass(object),selector);
    return method && method_getNumberOfArguments(method) == 2 ? method : NULL;
}
static BOOL CSBoolSelector(id object, SEL sel, BOOL fallback) {
    Method method = CSGetter(object,sel);
    if (!method) return fallback;
    char type = method_getTypeEncoding(method)[0];
    if (type != 'B' && type != 'c') return fallback;
    return ((BOOL (*)(id, SEL))objc_msgSend)(object, sel);
}
static BOOL CSBool(id object, NSString *name, BOOL fallback) {
    return CSBoolSelector(object,NSSelectorFromString(name),fallback);
}
static unsigned long long CSUInt(id object, NSString *name) {
    SEL sel = NSSelectorFromString(name);
    Method method = CSGetter(object,sel);
    if (!method) return 0;
    switch (method_getTypeEncoding(method)[0]) {
        case 'I': return ((unsigned int (*)(id,SEL))objc_msgSend)(object,sel);
        case 'Q': return ((unsigned long long (*)(id,SEL))objc_msgSend)(object,sel);
        case 'q': { long long n = ((long long (*)(id,SEL))objc_msgSend)(object,sel); return n > 0 ? n : 0; }
        default: return 0;
    }
}
static NSString *CSString(id object) { return [object isKindOfClass:NSString.class] ? object : @""; }
static id CSParent(id model) { return CSMessageNativeObject(model, @"parentModel") ?: model; }
id CSMessageNativeObject(id object, NSString *selector) {
    SEL sel = NSSelectorFromString(selector);
    Method method = CSGetter(object,sel);
    if (!method || method_getTypeEncoding(method)[0] != '@') return nil;
    return ((id (*)(id, SEL))objc_msgSend)(object, sel);
}

@interface CSMessageMergeContext : NSObject
@property(nonatomic,copy) NSString *account,*session;
@end
@implementation CSMessageMergeContext @end
@interface CSMessageMergeDescriptor : NSObject
@property(nonatomic,strong) CSMessageMergeItem *item;
@property(nonatomic) unsigned long long localID,serverID;
@end
@implementation CSMessageMergeDescriptor @end
static char CSDescriptorKey;
@interface MergeWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType;
@property(nonatomic) unsigned long long m_uiMesLocalID,m_n64MesSvrID;
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsRealChatUsr;
@end
@implementation MergeWrap @end
@interface TextMessageViewModel : NSObject
@property(nonatomic,strong) MergeWrap *messageWrap;
@property(nonatomic,strong) id parentModel;
@property(nonatomic) unsigned long long numberOfRowsInSection;
@property(nonatomic) BOOL isSender;
@end
@implementation TextMessageViewModel @end
@interface VoiceTransTextMessageViewModel : TextMessageViewModel @end
@implementation VoiceTransTextMessageViewModel @end
@interface VoiceTransTextMessageViewModelV2 : TextMessageViewModel @end
@implementation VoiceTransTextMessageViewModelV2 @end
@interface UnknownVoiceTextSubclass : VoiceTransTextMessageViewModel @end
@implementation UnknownVoiceTextSubclass @end
@interface WCPayTransferMessageViewModel : TextMessageViewModel @end
@implementation WCPayTransferMessageViewModel @end
static NSUInteger checks;
static void check(BOOL ok) { checks++; if(!ok) { fprintf(stderr,"failed supplemental check %lu\n",(unsigned long)checks); exit(1); } }
static TextMessageViewModel *model(Class kind,unsigned long long local,unsigned int type) {
 TextMessageViewModel *m=[kind new];m.messageWrap=[MergeWrap new];m.messageWrap.m_uiMessageType=type;
 m.messageWrap.m_uiMesLocalID=local;m.numberOfRowsInSection=1;m.isSender=YES;return m;
}

static BOOL CSIsVoiceTransText(id model) {
    id logical=CSParent(model);
    NSString *name=NSStringFromClass([logical class]);
    return ([name isEqual:@"VoiceTransTextMessageViewModel"] || [name isEqual:@"VoiceTransTextMessageViewModelV2"]) &&
        CSUInt(CSMessageNativeObject(logical,@"messageWrap"),@"m_uiMessageType")==1;
}
static BOOL CSSupported(id model) {
    // Exact classes: subclasses with extra dynamic content require explicit qualification.
    NSString *name = NSStringFromClass([CSParent(model) class]);
    static NSSet *classes;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ classes = [NSSet setWithArray:@[@"TextMessageViewModel",@"ImageMessageViewModel",@"VoiceMessageViewModel",@"VideoMessageViewModel",@"EmoticonMessageViewModel"]]; });
    // Live speech-to-text sends keep these exact text models until the chat is
    // reloaded. Match the bubble-style contract without admitting other cards.
    return [classes containsObject:name] || CSIsVoiceTransText(model);
}
static CSMessageMergeItem *CSItem(id node, CSMessageMergeContext *ctx) {
    BOOL eligible = CSSupported(node) && CSUInt(node,@"numberOfRowsInSection")==1 &&
        !CSMessageNativeObject(node,@"parentModel");
    id parent = CSParent(node), wrap = CSMessageNativeObject(parent,@"messageWrap");
    BOOL hasSender=wrap && [parent respondsToSelector:@selector(isSender)];
    eligible &= hasSender;
    BOOL outgoing=hasSender && CSBool(parent,@"isSender",NO);
    BOOL group = [ctx.session hasSuffix:@"@chatroom"];
    NSString *sender=hasSender ? (outgoing ? ctx.account : CSString(CSMessageNativeObject(wrap,group ? @"m_nsRealChatUsr" : @"m_nsFromUsr"))) : @"";
    if ([sender isEqual:ctx.session] && group) sender=@"";
    unsigned long long local=CSUInt(wrap?:node,@"m_uiMesLocalID"),server=local ? 0 : CSUInt(wrap?:node,@"m_n64MesSvrID");
    CSMessageMergeDescriptor *cached=objc_getAssociatedObject(node,&CSDescriptorKey);
    CSMessageMergeItem *item=cached.item;
    // Validate scalar identity and mutable sender/eligibility on every access. A pointer/count
    // cache alone misses equal-count replacements and in-place native model changes.
    if (cached && cached.localID==local && cached.serverID==server && item.eligible==eligible && item.outgoing==outgoing &&
        [item.account isEqual:ctx.account] && [item.session isEqual:ctx.session] && [item.sender isEqual:sender]) return item;
#ifdef CS_MERGE_TESTING
    CSMessageMergeDescriptorBuildCount++;
#endif
    item=[CSMessageMergeItem new]; item.account=ctx.account; item.session=ctx.session;
    item.identity=local ? [NSString stringWithFormat:@"l:%llu",local] : (server ? [NSString stringWithFormat:@"s:%llu",server] : @"");
    item.sender=sender;item.eligible=eligible;item.outgoing=outgoing;
    cached=[CSMessageMergeDescriptor new];cached.item=item;cached.localID=local;cached.serverID=server;
    objc_setAssociatedObject(node,&CSDescriptorKey,cached,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return item;
}

int main(void) { @autoreleasepool {
 CSMessageMergeContext *ctx=[CSMessageMergeContext new];ctx.account=@"account";ctx.session=@"friend";
 TextMessageViewModel *plain=model(TextMessageViewModel.class,1,1);check(CSItem(plain,ctx).eligible);
 for(Class kind in @[VoiceTransTextMessageViewModel.class,VoiceTransTextMessageViewModelV2.class]) {
  TextMessageViewModel *live=model(kind,2,1);CSMessageMergeItem *first=CSItem(plain,ctx),*last=CSItem(live,ctx);
  check(last.eligible==VOICE_EXPECTED);check(CSMessageMergeCanJoin(first,last)==VOICE_EXPECTED);
  CSMessageMergeDecision decision=CSMessageMergeDecide(first,last,nil,2);
  check(decision.joinsPrevious==VOICE_EXPECTED);check(decision.hidesIdentity==VOICE_EXPECTED);
  check(CSItem(live,ctx)==last);
  live.messageWrap.m_uiMessageType=49;check(!CSItem(live,ctx).eligible);check(!CSMessageMergeCanJoin(first,CSItem(live,ctx)));
  live.messageWrap.m_uiMessageType=1;check(CSItem(live,ctx).eligible==VOICE_EXPECTED);
  live.numberOfRowsInSection=2;check(!CSItem(live,ctx).eligible);live.numberOfRowsInSection=1;
  live.parentModel=plain;check(!CSItem(live,ctx).eligible);live.parentModel=nil;
  live.isSender=NO;live.messageWrap.m_nsFromUsr=@"friend";check(!CSMessageMergeCanJoin(first,CSItem(live,ctx)));
  ctx.session=@"room@chatroom";plain.isSender=NO;plain.messageWrap.m_nsRealChatUsr=@"member";live.messageWrap.m_nsRealChatUsr=@"member";
  check(CSMessageMergeCanJoin(CSItem(plain,ctx),CSItem(live,ctx))==VOICE_EXPECTED);
  live.messageWrap.m_nsRealChatUsr=@"different";check(!CSMessageMergeCanJoin(CSItem(plain,ctx),CSItem(live,ctx)));
  plain.isSender=YES;ctx.session=@"friend";
  printf("%s type=1 eligible=%d (expected=%d)\n",class_getName(kind),last.eligible,VOICE_EXPECTED);
 }
 check(!CSItem(model(UnknownVoiceTextSubclass.class,3,1),ctx).eligible);
 check(!CSItem(model(WCPayTransferMessageViewModel.class,4,1),ctx).eligible);
 check(!CSItem(model(VoiceTransTextMessageViewModel.class,5,34),ctx).eligible);
 check(!CSItem(model(VoiceTransTextMessageViewModelV2.class,6,0),ctx).eligible);
 printf("PASS: %lu supplemental eligibility/cache/policy checks\n",(unsigned long)checks);return 0;
} }
