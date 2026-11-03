#import "CSGroupNativeBridge.h"
#import "CSServiceCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

static BOOL ObjectType(const char *type) {
    while (type && *type && strchr("rnNoORV",*type)) type++;
    return type && type[0]=='@' && (type[1]=='\0' || type[1]=='"');
}
static NSMethodSignature *Signature(id object, SEL sel, NSUInteger arguments) {
    if (!object || ![object respondsToSelector:sel]) return nil;
    // CMessageWrap (8.0.78) returns catchUnImplementMethod's q@: signature
    // from methodSignatureForSelector: even for implemented methods. Read
    // their actual ABI from the class/metaclass; ask the object only when the
    // selector has no concrete method and genuinely needs forwarding.
    Method method=class_getInstanceMethod(object_getClass(object),sel);
    const char *types=method ? method_getTypeEncoding(method) : NULL;
    NSMethodSignature *sig=types ? [NSMethodSignature signatureWithObjCTypes:types] : [object methodSignatureForSelector:sel];
    return sig.numberOfArguments==arguments && ObjectType([sig getArgumentTypeAtIndex:0]) &&
        strcmp([sig getArgumentTypeAtIndex:1],@encode(SEL))==0 ? sig : nil;
}
id CSGroupReadObject(id object, NSString *name) {
    if (!object) return nil;
    @try {
        SEL sel=NSSelectorFromString(name); NSMethodSignature *sig=Signature(object,sel,2);
        if (sig && ObjectType(sig.methodReturnType)) return ((id(*)(id,SEL))objc_msgSend)(object,sel);
        Ivar ivar=class_getInstanceVariable(object_getClass(object),name.UTF8String);
        if (ivar && ivar_getTypeEncoding(ivar)[0]=='@') return object_getIvar(object,ivar);
    } @catch (__unused NSException *e) {}
    return nil;
}
static long long IntegerInvocationValue(NSInvocation *inv, id target, long long fallback) {
    NSMethodSignature *sig=inv.methodSignature;
    // Check before invocation: even an unsupported getter may have host side effects.
    if (!sig || !sig.methodReturnLength || sig.methodReturnLength>8 || !strchr("BcCsSiIlLqQ",sig.methodReturnType[0])) return fallback;
    [inv invokeWithTarget:target];
        switch (sig.methodReturnType[0]) {
#define CS_GROUP_NUMBER(t,c) case c: { t v=0; [inv getReturnValue:&v]; return (long long)v; }
            CS_GROUP_NUMBER(BOOL,'B') CS_GROUP_NUMBER(signed char,'c') CS_GROUP_NUMBER(unsigned char,'C')
            CS_GROUP_NUMBER(short,'s') CS_GROUP_NUMBER(unsigned short,'S') CS_GROUP_NUMBER(int,'i')
            CS_GROUP_NUMBER(unsigned int,'I') CS_GROUP_NUMBER(long,'l')
            CS_GROUP_NUMBER(long long,'q')
            case 'L': { unsigned long v=0; [inv getReturnValue:&v]; return v>(unsigned long)LLONG_MAX ? LLONG_MAX : (long long)v; }
            case 'Q': { unsigned long long v=0; [inv getReturnValue:&v]; return v>LLONG_MAX ? LLONG_MAX : (long long)v; }
#undef CS_GROUP_NUMBER
        }
    return fallback;
}
long long CSGroupReadInteger(id object, NSString *name, long long fallback) {
    @try {
        SEL sel=NSSelectorFromString(name); NSMethodSignature *sig=Signature(object,sel,2);
        if (!sig) return fallback;
        NSInvocation *inv=[NSInvocation invocationWithMethodSignature:sig]; inv.selector=sel;
        return IntegerInvocationValue(inv,object,fallback);
    } @catch (__unused NSException *e) {}
    return fallback;
}
static id ObjectAtPath(id object, NSString *selector, NSIndexPath *path) {
    SEL sel=NSSelectorFromString(selector); NSMethodSignature *sig=Signature(object,sel,3);
    if (!sig || !ObjectType(sig.methodReturnType) || !ObjectType([sig getArgumentTypeAtIndex:2])) return nil;
    return ((id(*)(id,SEL,id))objc_msgSend)(object,sel,path);
}
static NSArray *CopyFoldedSessions(void) {
    @try {
        id manager=CSGetService(NSClassFromString(@"ChatBoxMgr"));
        NSMethodSignature *signature=Signature(manager,NSSelectorFromString(@"chatBoxSessions"),2);
        if (!signature || !ObjectType(signature.methodReturnType)) return nil;
        id sessions=CSGroupReadObject(manager,@"chatBoxSessions");
        if (![sessions isKindOfClass:NSArray.class] || [sessions count]>100000) return nil;
        NSArray *snapshot=[sessions copy];
        for (id session in snapshot) {
            id name=CSGroupReadObject(session,@"m_nsUserName");
            if (![name isKindOfClass:NSString.class] || ![name length]) return nil;
        }
        return snapshot;
    } @catch (__unused NSException *exception) { return nil; }
}
NSArray<NSString *> *CSGroupCopyFoldedUserNames(void) {
    NSArray *sessions=CopyFoldedSessions(); if (!sessions) return nil;
    NSMutableArray *names=[NSMutableArray arrayWithCapacity:sessions.count];
    for (id session in sessions) {
        id name=CSGroupReadObject(session,@"m_nsUserName");
        if (![name isKindOfClass:NSString.class] || ![name length]) return nil;
        [names addObject:[name copy]];
    }
    return [names copy];
}
CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(NSArray *names, NSSet *hiddenNames) {
    if (![names isKindOfClass:NSArray.class] || !names.count) return CSGroupFoldedPrivacyUnknown;
    NSUInteger hidden=0;
    for (id name in names) {
        if (![name isKindOfClass:NSString.class] || ![name length]) return CSGroupFoldedPrivacyUnknown;
        if ([hiddenNames containsObject:name]) hidden++;
    }
    return hidden==0 ? CSGroupFoldedPrivacyNoHidden : hidden==names.count ? CSGroupFoldedPrivacyAllHidden : CSGroupFoldedPrivacyMixed;
}
BOOL CSGroupIsFoldedController(id controller) {
    Class cls=NSClassFromString(@"ChatBoxSessionListViewController");
    return cls && [controller isKindOfClass:cls];
}
id CSGroupNativeLogic(id controller) {
    return CSGroupIsFoldedController(controller) ? controller : CSGroupReadObject(controller,@"m_mainFrameLogicController");
}
static NSString *SessionSelector(id logic) { return CSGroupIsFoldedController(logic) ? @"logicGetSessionAtIndexPath:" : @"getSessionInfoAtIndexPath:"; }
static NSString *DataSelector(id logic) { return CSGroupIsFoldedController(logic) ? @"logicGetCellDataAtIndexPath:" : @"getCellDataAtIndexPath:"; }
// MainSessionMgr may expose its aggregate wrapper while another native getter
// returns MMSessionInfo or MMBaseSessionInfo. Resolve all three through the
// same identity path so a real session cannot become an anonymous business row
// merely because the host changed the representation of one getter.
static id NativeSessionObject(id object) {
    return CSGroupReadObject(object,@"mainSession") ?: object;
}
static id NativeSessionName(id session) {
    return CSGroupReadObject(session,@"m_nsUserName") ?: CSGroupReadObject(session,@"sessionId");
}
NSString *CSGroupNativeUserNameAtPath(id controller, NSIndexPath *path) {
    if (![path isKindOfClass:NSIndexPath.class] || path.length!=2) return nil;
    @try {
    id logic=CSGroupNativeLogic(controller);
    id session=ObjectAtPath(logic,SessionSelector(logic),path);
    id data=session ? nil : ObjectAtPath(logic,DataSelector(logic),path);
    session=session ?: CSGroupReadObject(data,@"m_sessionInfo");
    id name=NativeSessionName(NativeSessionObject(session)) ?: CSGroupReadObject(data,@"userName");
    return [name isKindOfClass:NSString.class] ? name : nil;
    } @catch (__unused NSException *exception) { return nil; }
}
static BOOL IsNativePath(id path) {
    return [path isKindOfClass:NSIndexPath.class] && [path length]==2 &&
        [path indexAtPosition:0]<(NSUInteger)NSIntegerMax && [path indexAtPosition:1]<(NSUInteger)NSIntegerMax;
}
static id ResolverObjectAtPath(id logic, NSString *selector, id argument) {
    @try { return ObjectAtPath(logic,selector,argument); }
    @catch (__unused NSException *e) { return nil; }
}
static BOOL NativeIdentityMatches(id logic, NSIndexPath *path, CSGroupRow *row) {
    @try {
        if (!IsNativePath(path)) return NO;
        NSMethodSignature *sig=Signature(logic,NSSelectorFromString(SessionSelector(logic)),3);
        if (!sig || !ObjectType(sig.methodReturnType) || !ObjectType([sig getArgumentTypeAtIndex:2])) return NO;
        // An unavailable or throwing getter cannot prove that a real session is absent.
        id session=ObjectAtPath(logic,SessionSelector(logic),path);
        id data=nil;
        if (!session) {
            data=ObjectAtPath(logic,DataSelector(logic),path);
            session=CSGroupReadObject(data,@"m_sessionInfo");
        }
        if (row.kind==CSGroupRowKindFake) {
            // A stale Fake userName can remain in CellData after it acquires a real session.
            if (session) return NO;
            id name=CSGroupReadObject(data,@"userName");
            return [name isKindOfClass:NSString.class] && [name isEqualToString:row.userName];
        }
        id name=NativeSessionName(NativeSessionObject(session));
        return [name isKindOfClass:NSString.class] && [name isEqualToString:row.userName];
    } @catch (__unused NSException *e) { return NO; }
}
static long long ControllerCount(id controller, id table, SEL selector, NSInteger section, BOOL withSection) {
    NSMethodSignature *sig=Signature(controller,selector,withSection ? 4 : 3);
    if (!sig || !ObjectType([sig getArgumentTypeAtIndex:2]) ||
        (withSection && strcmp([sig getArgumentTypeAtIndex:3],@encode(NSInteger))!=0)) return -1;
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:sig]; inv.selector=selector;
    [inv setArgument:&table atIndex:2];
    if (withSection) [inv setArgument:&section atIndex:3];
    return IntegerInvocationValue(inv,controller,-1);
}
static BOOL AnonymousPathWithinBounds(id controller, NSIndexPath *path) {
    if (!IsNativePath(path)) return NO;
    id table=CSGroupReadObject(controller,CSGroupIsFoldedController(controller) ? @"tableView" : @"m_tableView");
    if (!table) return NO;
    long long sections=ControllerCount(controller,table,@selector(numberOfSectionsInTableView:),0,NO);
    NSUInteger section=[path indexAtPosition:0], row=[path indexAtPosition:1];
    if (sections<0 || sections>1024 || section>=(NSUInteger)sections) return NO;
    long long rows=ControllerCount(controller,table,@selector(tableView:numberOfRowsInSection:),(NSInteger)section,YES);
    return rows>=0 && rows<=100000 && row<(NSUInteger)rows;
}
static BOOL AnonymousPathStillBusiness(id logic, NSIndexPath *path) {
    // Rendering a banner does not require a chat username. During deferred
    // refresh, prove the slot is still non-session content before reusing it.
    for (NSString *name in @[SessionSelector(logic),DataSelector(logic)]) {
        NSMethodSignature *sig=Signature(logic,NSSelectorFromString(name),3);
        if (!sig || !ObjectType(sig.methodReturnType) || !ObjectType([sig getArgumentTypeAtIndex:2])) return NO;
    }
    if (ObjectAtPath(logic,SessionSelector(logic),path)) return NO;
    id data=ObjectAtPath(logic,DataSelector(logic),path);
    if (CSGroupReadObject(data,@"m_sessionInfo")) return NO;
    id name=CSGroupReadObject(data,@"userName");
    return !name || ([name isKindOfClass:NSString.class] && ![name length]);
}
@interface CSGroupFoldedPathIndex : NSObject
@property(nonatomic,copy) NSArray *version;
@property(nonatomic,copy) NSDictionary<NSString *,NSArray<NSIndexPath *> *> *paths;
@end
@implementation CSGroupFoldedPathIndex @end
static char FoldedPathIndexKey;
static NSIndexPath *FoldedIndexedPath(id controller,id logic,CSGroupRow *row,NSArray *version) {
    CSGroupFoldedPathIndex *index=objc_getAssociatedObject(controller,&FoldedPathIndexKey);
    if ([index.version isEqual:version]) {
        for (NSIndexPath *path in index.paths[row.userName]) if (NativeIdentityMatches(logic,path,row)) return path;
    }
    // A same-pointer, same-count native array may have reordered or replaced
    // rows without a known host callback. Never treat its shape as a version.
    objc_setAssociatedObject(controller,&FoldedPathIndexKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    id table=CSGroupReadObject(controller,@"tableView");
    long long count=ControllerCount(controller,table,@selector(tableView:numberOfRowsInSection:),0,YES);
    if (count<0 || count>100000) return nil;
    NSMutableDictionary *paths=[NSMutableDictionary dictionary];
    for (NSUInteger i=0;i<(NSUInteger)count;i++) {
        NSUInteger indexes[]={0,i};NSIndexPath *path=[NSIndexPath indexPathWithIndexes:indexes length:2];
        NSString *name=CSGroupNativeUserNameAtPath(controller,path);
        if (!name.length) continue;
        NSMutableArray *positions=paths[name];
        if (!positions) paths[[name copy]]=positions=[NSMutableArray array];
        [positions addObject:path];
    }
    if (ControllerCount(controller,table,@selector(tableView:numberOfRowsInSection:),0,YES)!=count) return nil;
    NSMutableDictionary *immutable=[NSMutableDictionary dictionaryWithCapacity:paths.count];
    for (NSString *name in paths) immutable[name]=[paths[name] copy];
    index=[CSGroupFoldedPathIndex new];index.version=version;index.paths=immutable;
    objc_setAssociatedObject(controller,&FoldedPathIndexKey,index,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (NSIndexPath *path in index.paths[row.userName]) if (NativeIdentityMatches(logic,path,row)) return path;
    return nil;
}
static NSIndexPath *ResolveNativeRowPath(id controller, CSGroupRow *row, BOOL modelDirty,NSArray *version) {
    @try {
        if (![row isKindOfClass:CSGroupRow.class] || !IsNativePath(row.nativePath)) return nil;
        id logic=CSGroupNativeLogic(controller);
        if (!logic) return nil;
        if (version.count && CSGroupIsFoldedController(controller)) {
            CSGroupFoldedPathIndex *index=objc_getAssociatedObject(controller,&FoldedPathIndexKey);
            if (index && ![index.version isEqual:version]) objc_setAssociatedObject(controller,&FoldedPathIndexKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        if (![row.userName isKindOfClass:NSString.class] || !row.userName.length) {
            if (row.kind!=CSGroupRowKindBusiness && row.kind!=CSGroupRowKindAggregate) return nil;
            if (!AnonymousPathWithinBounds(controller,row.nativePath)) return nil;
            return !modelDirty || AnonymousPathStillBusiness(logic,row.nativePath) ? row.nativePath : nil;
        }
        if (NativeIdentityMatches(logic,row.nativePath,row)) return row.nativePath;
        if (CSGroupIsFoldedController(controller)) {
            if (version.count) return FoldedIndexedPath(controller,logic,row,version);
            id table=CSGroupReadObject(controller,@"tableView");
            long long count=ControllerCount(controller,table,@selector(tableView:numberOfRowsInSection:),0,YES);
            if (count<0 || count>100000) return nil;
            for (NSUInteger i=0;i<(NSUInteger)count;i++) {
                NSUInteger indexes[]={0,i}; NSIndexPath *path=[NSIndexPath indexPathWithIndexes:indexes length:2];
                if (NativeIdentityMatches(logic,path,row)) return path;
            }
            return nil;
        }
        id path=ResolverObjectAtPath(logic,@"indexPathOfSessionUserName:",row.userName);
        return NativeIdentityMatches(logic,path,row) ? [path copy] : nil;
    } @catch (__unused NSException *e) { return nil; }
}
NSIndexPath *CSGroupResolveNativeRowPath(id controller, CSGroupRow *row, BOOL modelDirty) {
    return ResolveNativeRowPath(controller,row,modelDirty,nil);
}
NSIndexPath *CSGroupResolveNativeRowPathReusing(id controller, CSGroupRow *row, BOOL modelDirty,NSArray *sourceVersion) {
    return ResolveNativeRowPath(controller,row,modelDirty,sourceVersion);
}
NSString *CSGroupCurrentAccountID(void) {
    for (NSArray *entry in @[@[@"MMContext",@"currentUserName"],@[@"SettingUtil",@"getCurUsrName"]]) {
        id provider=NSClassFromString(entry[0]);
        NSMethodSignature *signature=Signature(provider,NSSelectorFromString(entry[1]),2);
        if (signature && ObjectType(signature.methodReturnType)) {
            id value=CSGroupReadObject(provider,entry[1]);
            // An available authoritative accessor returning nil means logged out.
            return [value isKindOfClass:NSString.class] && [value length]>0 ? [value copy] : nil;
        }
    }
    id contact=CSGroupReadObject(CSGetService(NSClassFromString(@"CContactMgr")),@"getSelfContact");
    id value=CSGroupReadObject(contact,@"m_nsUsrName");
    return [value isKindOfClass:NSString.class] && [value length]>0 ? [value copy] : nil;
}
static BOOL ServiceName(NSString *name) {
    return [name hasPrefix:@"gh_"] || [name hasPrefix:@"newsapp"] || [name hasSuffix:@"brandsessionholder"] || [name hasSuffix:@"brandservicesessionholder"] || [@[@"weixin",@"filehelper",@"notification_messages"] containsObject:name];
}
CSGroupRowCategory CSGroupCategoryForContact(id contact) {
    id name=CSGroupReadObject(contact,@"m_nsUsrName");
    if (![name isKindOfClass:NSString.class]) name=nil;
    if ([name hasSuffix:@"@chatroom"] || [name isEqual:@"chatroom_session_box"]) return CSGroupRowCategoryGroup;
    // Brand flags are authoritative even when the contact has no readable username.
    if (ServiceName(name ?: @"") || CSGroupReadInteger(contact,@"isBrandContact",0) ||
        CSGroupReadInteger(contact,@"isServiceBrand",0) || CSGroupReadInteger(contact,@"isSubscriptionBrand",0)) return CSGroupRowCategoryService;
    if (![name length]) return CSGroupRowCategoryUnknown;
    if (CSGroupReadInteger(contact,@"isMyContact",0)) return CSGroupRowCategoryPrivate;
    return CSGroupRowCategoryUnknown;
}
static CSGroupRowCategory CategoryForSession(id session,NSString *name,BOOL serviceContainer) {
    CSGroupRowCategory category=CSGroupCategoryForContact(CSGroupReadObject(session,@"m_contact") ?: CSGroupReadObject(session,@"contact"));
    if ([name hasSuffix:@"@chatroom"] || [name isEqual:@"chatroom_session_box"]) return CSGroupRowCategoryGroup;
    if (serviceContainer || ServiceName(name ?: @"") || CSGroupReadInteger(session,@"isInBrandServiceBox",0)) return CSGroupRowCategoryService;
    if (category==CSGroupRowCategoryUnknown && CSGroupReadInteger(session,@"isSingleChatSession",0)) return CSGroupRowCategoryPrivate;
    return category;
}
CSGroupRow *CSGroupRowForNativeSession(id object, NSIndexPath *path, BOOL top) {
    if (!object || ![path isKindOfClass:NSIndexPath.class] || path.length!=2) return nil;
    @try {
        id session=NativeSessionObject(object);
        id name=NativeSessionName(session);
        if (name && ![name isKindOfClass:NSString.class]) return nil;
        if (![name length]) name=nil;
        BOOL service=[@[@"brandsessionholder",@"brandservicesessionholder"] containsObject:name ?: @""] ||
            CSGroupReadInteger(session,@"isBrandServiceBoxSession",0) || CSGroupReadInteger(session,@"isBrandEcsMsgHolderSession",0);
        CSGroupRowKind kind=(!name ? CSGroupRowKindBusiness :
            ([name isEqual:@"chatroom_session_box"] || service) ? CSGroupRowKindAggregate : CSGroupRowKindSession);
        long long unread=CSGroupReadInteger(object,@"mainUnReadCount",-1);
        if (unread<0) unread=CSGroupReadInteger(session,@"m_uUnReadCount",CSGroupReadInteger(session,@"unreadCount",0));
        long long dot=CSGroupReadInteger(object,@"showAsRedDot",-1);
        if (dot<0) dot=CSGroupReadInteger(session,@"m_bShowUnReadAsRedDot",CSGroupReadInteger(session,@"showRedDotOuter",0));
        return [[CSGroupRow alloc] initWithNativePath:path userName:name kind:kind
            category:CategoryForSession(session,name,service) top:top unreadCount:(NSUInteger)MAX(0,unread) redDot:dot>0];
    } @catch (__unused NSException *exception) { return nil; }
}
static NSNumber *FoldedSessionSortTime(id session) {
    // MMSessionInfo.compare: (8.0.78): override/last time, then top time for
    // pinned rows, or untop/sort time otherwise. This is only a ranking aid,
    // never a digest validity gate or a source for a visible time/date label.
    long long override=MAX(0,CSGroupReadInteger(session,@"sortTimeOverride",0)),last=MAX(0,CSGroupReadInteger(session,@"m_uLastTime",0));
    BOOL top=CSGroupReadInteger(session,@"m_bIsTop",0)>0;
    long long time=override>0 ? override : last;
    time=MAX(time,CSGroupReadInteger(session,top ? @"m_uTopTime" : @"m_uUnTopTime",0));
    if (!top) time=MAX(time,CSGroupReadInteger(session,@"sortTime",0));
    return time>0 ? @(time) : nil;
}
static NSNumber *FoldedSortTime(id session,id resolvedMessage) {
    NSNumber *sessionTime=FoldedSessionSortTime(session);
    long long time=sessionTime.longLongValue;
    if (!time) {
        // Readonly native message time also handles the special pat-message
        // timestamp. Missing optional session getters must not force neutral.
        id message=resolvedMessage ?: CSGroupReadObject(session,@"m_msgWrap");
        time=MAX(0,CSGroupReadInteger(message,@"getSessionTime",0));
        if (!time) time=MAX(0,CSGroupReadInteger(message,@"m_uiCreateTime",0));
    }
    return time>0 ? @(time) : nil;
}
static unsigned long long FoldedMessageID(id object) {
    // 8.0.78: CMessageWrap uses q, MainFrameCellData uses Q. These are identity
    // bits, not counters; never saturate signed/unsigned IDs through LLONG_MAX.
    @try {
        SEL selector=NSSelectorFromString(@"m_n64MesSvrID");NSMethodSignature *sig=Signature(object,selector,2);
        if (!sig || sig.methodReturnLength!=sizeof(unsigned long long)) return 0;
        if (!strcmp(sig.methodReturnType,@encode(unsigned long long)))
            return ((unsigned long long(*)(id,SEL))objc_msgSend)(object,selector);
        if (!strcmp(sig.methodReturnType,@encode(long long)))
            return (unsigned long long)((long long(*)(id,SEL))objc_msgSend)(object,selector);
    } @catch (__unused NSException *exception) {}
    return 0;
}
static NSString *FoldedSummaryText(id text) {
    if ([text isKindOfClass:NSAttributedString.class]) text=[text string];
    return [text isKindOfClass:NSString.class] && [text length] ? [text copy] : nil;
}
static id FoldedLastMessage(id manager,NSString *name) {
    SEL selector=NSSelectorFromString(@"GetLastMsg:");NSMethodSignature *sig=Signature(manager,selector,3);
    if (!sig || !ObjectType(sig.methodReturnType) || !ObjectType([sig getArgumentTypeAtIndex:2])) return nil;
    id message=((id(*)(id,SEL,id))objc_msgSend)(manager,selector,name);
    return [CSGroupReadObject(message,@"GetChatName") isEqual:name] ? message : nil;
}
static BOOL FoldedSameMessage(id a,id b) {
    if (!a || !b || ![CSGroupReadObject(a,@"GetChatName") isEqual:CSGroupReadObject(b,@"GetChatName")]) return NO;
    if (a==b) return YES;
    unsigned long long server=FoldedMessageID(a);
    if (server) return server==FoldedMessageID(b);
    long long local=CSGroupReadInteger(a,@"m_uiMesLocalID",0);
    return !FoldedMessageID(b) && local>0 && local==CSGroupReadInteger(b,@"m_uiMesLocalID",0);
}
// Only the selectors read by 8.0.78 makeTextForQuoteMessage. Brand/favorite
// state stays neutral; this is not a live session and is never put in a manager.
@interface CSFoldedDigestSessionInfo : NSObject
@property(nonatomic,strong) id m_contact, m_msgWrap;
@property(nonatomic,copy) NSString *m_nsUserName, *m_nsBrandNotifyPrefixName;
@property(nonatomic) unsigned int m_uBrandNotifyType, m_uUnReadCount;
@property(nonatomic) BOOL m_bBrandNotifyNoPrefixName;
@end
@implementation CSFoldedDigestSessionInfo @end

static NSString *FoldedFormatMessage(id message,NSString *name,NSString **prefix) {
    Class cls=NSClassFromString(@"MainFrameCellData");
    SEL digest=NSSelectorFromString(@"digestForMsg:withSender:");
    NSMethodSignature *sig=Signature(cls,digest,4);
    if (!sig || !ObjectType(sig.methodReturnType) || !ObjectType([sig getArgumentTypeAtIndex:2]) || !ObjectType([sig getArgumentTypeAtIndex:3])) return nil;
    sig=Signature(message,@selector(copyWithZone:),3);
    if (!sig || !ObjectType(sig.methodReturnType) || strcmp([sig getArgumentTypeAtIndex:2],@encode(NSZone *))) return nil;
    id copy=[message copy];
    if (!copy || copy==message || FoldedMessageID(copy)!=FoldedMessageID(message) || ![CSGroupReadObject(copy,@"GetChatName") isEqual:name]) return nil;
    for (NSString *key in @[@"m_extendInfoWithMsgType",@"m_extendInfoWithFromUsr",@"m_extendInfoWithMsgTypeForBiz",@"referHostMsg"]) {
        id item=CSGroupReadObject(message,key);
        if (item && CSGroupReadObject(copy,key)==item) return nil;
    }
    SEL change=NSSelectorFromString(@"ChangeForDisplay");sig=Signature(copy,change,2);
    if (!sig || strcmp(sig.methodReturnType,@encode(void))) return nil;
    // Native formatting parses/mutates its argument: only give it an independent
    // copy. Aggregate uses an empty sender; the conversation name is a separate
    // native prefix, not the group sender prefix returned by getGroupName.
    ((void(*)(id,SEL))objc_msgSend)(copy,change);
    if (![CSGroupReadObject(copy,@"GetChatName") isEqual:name]) return nil;
    NSString *text=FoldedSummaryText(((id(*)(id,SEL,id,id))objc_msgSend)(cls,digest,copy,@""));
    if (!text.length) return nil;
    // Native holder/aggregate plain-text processing, without makeTextSession:
    // (which can clear exclusive red-packet counts on the real account).
    Class parser=NSClassFromString(@"LinkAnchorParser");SEL strip=NSSelectorFromString(@"stringByStrippingHref:");
    sig=Signature(parser,strip,3);
    if (sig && ObjectType(sig.methodReturnType) && ObjectType([sig getArgumentTypeAtIndex:2]))
        text=FoldedSummaryText(((id(*)(id,SEL,id))objc_msgSend)(parser,strip,text));
    if (!text.length) return nil;
    if (![CSGroupReadObject(copy,@"GetChatName") isEqual:name] || FoldedMessageID(copy)!=FoldedMessageID(message)) return nil;
    id formatter=[[cls alloc] init];
    SEL setter=NSSelectorFromString(@"setM_sessionInfo:"),make=NSSelectorFromString(@"makeTextForQuoteMessage");
    sig=Signature(formatter,setter,3);NSMethodSignature *makeSig=Signature(formatter,make,2);
    if (!sig || strcmp(sig.methodReturnType,@encode(void)) || !ObjectType([sig getArgumentTypeAtIndex:2]) ||
        !makeSig || strcmp(makeSig.methodReturnType,@encode(void))) return nil;
    CSFoldedDigestSessionInfo *snapshot=[CSFoldedDigestSessionInfo new];
    snapshot.m_nsUserName=@"chatroom_session_box";snapshot.m_msgWrap=copy;
    ((void(*)(id,SEL,id))objc_msgSend)(formatter,setter,snapshot);
    ((void(*)(id,SEL))objc_msgSend)(formatter,make);
    *prefix=FoldedSummaryText(CSGroupReadObject(formatter,@"m_prefixTextForQuoteMessage"));
    if (!(*prefix).length) return nil;
    return text;
}
// Transient native references live only for this synchronous snapshot. Published
// rows retain copied Foundation values, never message/session objects.
@interface CSFoldedMessageSnapshot : NSObject
@property(nonatomic,strong) id sessionMessage, message, messageManager;
@property(nonatomic) BOOL lookup;
@end
@implementation CSFoldedMessageSnapshot @end
static CSFoldedMessageSnapshot *FoldedResolveMessage(id session,NSString *name) {
    CSFoldedMessageSnapshot *snapshot=[CSFoldedMessageSnapshot new];
    @try {
        snapshot.sessionMessage=CSGroupReadObject(session,@"m_msgWrap");
        snapshot.message=snapshot.sessionMessage;
        snapshot.lookup=!snapshot.message || ([snapshot.message respondsToSelector:NSSelectorFromString(@"m_nsContent")] && ![FoldedSummaryText(CSGroupReadObject(snapshot.message,@"m_nsContent")) length]);
        if (snapshot.lookup) {
            snapshot.messageManager=CSGetService(NSClassFromString(@"CMessageMgr"));
            snapshot.message=FoldedLastMessage(snapshot.messageManager,name);
        }
        if (![CSGroupReadObject(snapshot.message,@"GetChatName") isEqual:name]) snapshot.message=nil;
    } @catch (__unused NSException *exception) { snapshot.message=nil; }
    return snapshot;
}
static NSString *FoldedNativeSummary(id manager,id session,NSString *name,NSString **prefix,CSFoldedMessageSnapshot *snapshot) {
    *prefix=nil;
    @try {
        id sessionMessage=snapshot.sessionMessage,message=snapshot.message;
        // ChatBoxMgr.lastMsgForChatBoxSession (8.0.78) performs this same
        // per-conversation read when its lightweight session has no content.
        // Keep it detached: never set m_msgWrap or borrow the global candidate.
        BOOL lookup=snapshot.lookup;
        id messageManager=snapshot.messageManager;
        if (!message) return nil;
        if (![CSGroupReadObject(message,@"GetChatName") isEqual:name]) return nil;
        unsigned long long messageID=FoldedMessageID(message);
        SEL selector=NSSelectorFromString(@"getCellDataByUsrName:");NSMethodSignature *sig=Signature(manager,selector,3);
        id data=nil;
        if (sig && ObjectType(sig.methodReturnType) && ObjectType([sig getArgumentTypeAtIndex:2]))
            data=((id(*)(id,SEL,id))objc_msgSend)(manager,selector,@"chatroom_session_box");
        NSString *text=nil;
        if (data) {
            id entry=CSGroupReadObject(data,@"m_sessionInfo"),entryMessage=CSGroupReadObject(entry,@"m_msgWrap");
            if ([CSGroupReadObject(entry,@"m_nsUserName") isEqual:@"chatroom_session_box"] && messageID &&
                FoldedMessageID(data)==messageID && FoldedMessageID(entryMessage)==messageID &&
                [CSGroupReadObject(entryMessage,@"GetChatName") isEqual:name]) {
                text=FoldedSummaryText(CSGroupReadObject(data,@"m_textForMessageLabel"));
                *prefix=FoldedSummaryText(CSGroupReadObject(data,@"m_prefixTextForQuoteMessage"));
                if (!(*prefix).length || CSGroupReadObject(entry,@"m_msgWrap")!=entryMessage || FoldedMessageID(data)!=messageID ||
                    FoldedMessageID(entryMessage)!=messageID || ![CSGroupReadObject(entryMessage,@"GetChatName") isEqual:name]) text=nil;
            }
        }
        if (!text) {
            *prefix=nil;
            text=FoldedFormatMessage(message,name,prefix);
        }
        if (CSGroupReadObject(session,@"m_msgWrap")!=sessionMessage || FoldedMessageID(message)!=messageID ||
            (lookup && !FoldedSameMessage(message,FoldedLastMessage(messageManager,name))) ||
            ![CSGroupReadObject(message,@"GetChatName") isEqual:name] || ![CSGroupReadObject(session,@"m_nsUserName") isEqual:name]) {
            text=nil;
        }
        if (!text) *prefix=nil;
        return text;
    } @catch (__unused NSException *exception) { *prefix=nil;return nil; }
}
static NSArray<CSGroupRow *> *CopyFoldedRows(CSGroupRow *(^selector)(NSArray<CSGroupRow *> *)) {
    NSArray *sessions=CopyFoldedSessions(); if (!sessions) return nil;
    id dataManager=nil;
    @try { dataManager=CSGetService(NSClassFromString(@"MainFrameCellDataManager")); } @catch (__unused NSException *exception) {}
    NSMutableArray *rows=[NSMutableArray arrayWithCapacity:sessions.count];
    NSMutableArray *sourceSessions=[NSMutableArray arrayWithCapacity:sessions.count];
    NSMutableDictionary<NSNumber *,CSFoldedMessageSnapshot *> *messages=[NSMutableDictionary dictionary];
    NSMutableSet *names=[NSMutableSet set];
    for (id session in sessions) {
        id name=CSGroupReadObject(session,@"m_nsUserName");
        if (![name isKindOfClass:NSString.class] || ![name length] || [names containsObject:name] || [name isEqual:@"chatroom_session_box"]) return nil;
        [names addObject:name];
        NSUInteger indexes[]={0,rows.count};
        NSNumber *time=FoldedSessionSortTime(session);
        if (!time) {
            CSFoldedMessageSnapshot *snapshot=FoldedResolveMessage(session,name);
            messages[@(rows.count)]=snapshot;
            time=FoldedSortTime(session,snapshot.message);
        }
        [sourceSessions addObject:session];
        [rows addObject:[[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:indexes length:2]
            userName:name kind:CSGroupRowKindSession category:CategoryForSession(session,name,NO)
            top:CSGroupReadInteger(session,@"m_bIsTop",0)!=0
            unreadCount:(NSUInteger)MAX(0,CSGroupReadInteger(session,@"m_uUnReadCount",0))
            redDot:CSGroupReadInteger(session,@"m_bShowUnReadAsRedDot",0)!=0
            nativeSummary:nil sortTime:time nativePrefix:nil]];
    }
    CSGroupRow *selected=selector ? selector([rows copy]) : nil;
    NSUInteger selectedIndex=selected ? [rows indexOfObjectIdenticalTo:selected] : NSNotFound;
    for (NSUInteger index=0;index<rows.count;index++) {
        if (selector && index!=selectedIndex) continue;
        CSGroupRow *row=rows[index];id session=sourceSessions[index];
        CSFoldedMessageSnapshot *snapshot=messages[@(index)] ?: FoldedResolveMessage(session,row.userName);
        NSString *prefix=nil,*summary=FoldedNativeSummary(dataManager,session,row.userName,&prefix,snapshot);
        rows[index]=[[CSGroupRow alloc] initWithNativePath:row.nativePath userName:row.userName kind:row.kind category:row.category
            top:row.top unreadCount:row.unreadCount redDot:row.redDot nativeSummary:summary sortTime:row.nativeSortTime nativePrefix:prefix];
    }
    return [rows copy];
}
NSArray<CSGroupRow *> *CSGroupCopyFoldedRows(void) { return CopyFoldedRows(nil); }
NSArray<CSGroupRow *> *CSGroupCopyFoldedRowsSelectingSummary(CSGroupRow *(^selector)(NSArray<CSGroupRow *> *)) {
    return CopyFoldedRows(selector);
}
NSArray *CSGroupBuildNativeSections(id controller,id table,id source) {
    return CSGroupBuildNativeSectionsReusing(controller,table,source,nil);
}
NSArray *CSGroupBuildNativeSectionsReusing(id controller,id table,id source,NSArray *previous) {
    @try {
        SEL rowsSEL=@selector(tableView:numberOfRowsInSection:);
        NSMethodSignature *rowSig=Signature(source,rowsSEL,4);
        if (!rowSig || strcmp(rowSig.methodReturnType,@encode(NSInteger)) ||
            strcmp([rowSig getArgumentTypeAtIndex:2],@encode(id)) || strcmp([rowSig getArgumentTypeAtIndex:3],@encode(NSInteger))) return nil;
        id logic=CSGroupNativeLogic(controller);
        if (!logic) return nil;
        NSMethodSignature *sessionSig=Signature(logic,NSSelectorFromString(SessionSelector(logic)),3);
        if (!sessionSig || !ObjectType(sessionSig.methodReturnType) || !ObjectType([sessionSig getArgumentTypeAtIndex:2])) return nil;
        NSInteger count=1;
        SEL sectionsSEL=@selector(numberOfSectionsInTableView:);
        NSMethodSignature *sectionSig=Signature(source,sectionsSEL,3);
        if (sectionSig) {
            if (strcmp(sectionSig.methodReturnType,@encode(NSInteger)) || strcmp([sectionSig getArgumentTypeAtIndex:2],@encode(id))) return nil;
            count=((NSInteger(*)(id,SEL,id))objc_msgSend)(source,sectionsSEL,table);
        }
        if (count<0 || count>1024) return nil;
        NSMutableArray *sections=[NSMutableArray array]; NSUInteger total=0;
        for (NSInteger section=0;section<count;section++) {
            NSInteger rows=((NSInteger(*)(id,SEL,id,NSInteger))objc_msgSend)(source,rowsSEL,table,section);
            if (rows<0 || rows>100000 || total+(NSUInteger)rows>100000) return nil;
            total+=rows;
            NSArray *oldSection=(NSUInteger)section<previous.count ? previous[section] : nil;
            BOOL sameCount=oldSection && oldSection.count==(NSUInteger)rows;
            NSMutableArray *values=sameCount ? nil : [NSMutableArray arrayWithCapacity:rows];
            for (NSInteger row=0;row<rows;row++) {
                CSGroupRow *old=(NSUInteger)row<oldSection.count ? oldSection[row] : nil;
                if (![old isMemberOfClass:CSGroupRow.class] || old.nativePath.length!=2 ||
                    [old.nativePath indexAtPosition:0]!=(NSUInteger)section || [old.nativePath indexAtPosition:1]!=(NSUInteger)row) old=nil;
                NSUInteger indices[]={(NSUInteger)section,(NSUInteger)row};
                NSIndexPath *path=old.nativePath ?: [NSIndexPath indexPathWithIndexes:indices length:2];
                id session=ObjectAtPath(logic,SessionSelector(logic),path);
                id cellData=nil;
                if (!session) { cellData=ObjectAtPath(logic,DataSelector(logic),path); session=CSGroupReadObject(cellData,@"m_sessionInfo"); }
                id nativeObject=session;
                session=NativeSessionObject(nativeObject);
                BOOL top=CSGroupReadInteger(session,@"m_bIsTop",CSGroupReadInteger(cellData,@"bTopCell",0))!=0;
                CSGroupRow *nativeRow=nativeObject ? CSGroupRowForNativeSession(nativeObject,path,top) : nil;
                if (nativeObject && !nativeRow) return nil;
                id name=nativeRow.userName;
                CSGroupRowKind kind=nativeRow ? nativeRow.kind : CSGroupRowKindSession;
                if (![name isKindOfClass:NSString.class] || ![name length]) {
                    name=CSGroupReadObject(cellData,@"userName"); kind=CSGroupRowKindFake;
                }
                if (![name isKindOfClass:NSString.class]) name=nil;
                if (![name length]) kind=CSGroupRowKindBusiness;
                BOOL serviceContainer=[@[@"brandsessionholder",@"brandservicesessionholder"] containsObject:name ?: @""] ||
                    CSGroupReadInteger(session,@"isBrandServiceBoxSession",0) || CSGroupReadInteger(session,@"isBrandEcsMsgHolderSession",0);
                if ([name isEqual:@"chatroom_session_box"] || serviceContainer) kind=CSGroupRowKindAggregate;
                CSGroupRowCategory category=nativeRow.userName.length ? nativeRow.category : CategoryForSession(session,name,serviceContainer);
                NSUInteger unread=nativeRow ? nativeRow.unreadCount : 0;
                BOOL dot=nativeRow.redDot;
                BOOL same=old && old.kind==kind && old.category==category && old.top==top && old.unreadCount==unread && old.redDot==dot &&
                    (old.userName==name || [old.userName isEqual:name]);
                if (!same || values) {
                    CSGroupRow *value=same ? old : [[CSGroupRow alloc] initWithNativePath:path userName:name kind:kind category:category top:top unreadCount:unread redDot:dot];
                    if (sameCount) { if (!values) values=[oldSection mutableCopy];values[row]=value; }
                    else [values addObject:value];
                }
            }
            if (((NSInteger(*)(id,SEL,id,NSInteger))objc_msgSend)(source,rowsSEL,table,section)!=rows) return nil;
            [sections addObject:values ? [values copy] : oldSection];
        }
        if (sectionSig && ((NSInteger(*)(id,SEL,id))objc_msgSend)(source,sectionsSEL,table)!=count) return nil;
        if ([sections isEqualToArray:previous]) return previous;
        return [sections copy];
    } @catch (__unused NSException *e) { return nil; }
}
