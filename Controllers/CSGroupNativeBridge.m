#import "CSGroupNativeBridge.h"
#import "CSServiceCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSMethodSignature *Signature(id object, SEL sel, NSUInteger arguments) {
    if (!object || ![object respondsToSelector:sel]) return nil;
    NSMethodSignature *sig=[object methodSignatureForSelector:sel];
    return sig.numberOfArguments==arguments ? sig : nil;
}
id CSGroupReadObject(id object, NSString *name) {
    if (!object) return nil;
    @try {
        SEL sel=NSSelectorFromString(name); NSMethodSignature *sig=Signature(object,sel,2);
        if (sig && sig.methodReturnType[0]=='@') return ((id(*)(id,SEL))objc_msgSend)(object,sel);
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
    if (!sig || sig.methodReturnType[0]!='@' || [sig getArgumentTypeAtIndex:2][0]!='@') return nil;
    return ((id(*)(id,SEL,id))objc_msgSend)(object,sel,path);
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
        NSMethodSignature *sig=Signature(logic,NSSelectorFromString(@"getSessionInfoAtIndexPath:"),3);
        if (!sig || sig.methodReturnType[0]!='@' || [sig getArgumentTypeAtIndex:2][0]!='@') return NO;
        // An unavailable or throwing getter cannot prove that a real session is absent.
        id session=ObjectAtPath(logic,@"getSessionInfoAtIndexPath:",path);
        id data=nil;
        if (!session) {
            data=ObjectAtPath(logic,@"getCellDataAtIndexPath:",path);
            session=CSGroupReadObject(data,@"m_sessionInfo");
        }
        if (row.kind==CSGroupRowKindFake) {
            // A stale Fake userName can remain in CellData after it acquires a real session.
            if (session) return NO;
            id name=CSGroupReadObject(data,@"userName");
            return [name isKindOfClass:NSString.class] && [name isEqualToString:row.userName];
        }
        id name=CSGroupReadObject(session,@"m_nsUserName");
        return [name isKindOfClass:NSString.class] && [name isEqualToString:row.userName];
    } @catch (__unused NSException *e) { return NO; }
}
static long long ControllerCount(id controller, id table, SEL selector, NSInteger section, BOOL withSection) {
    NSMethodSignature *sig=Signature(controller,selector,withSection ? 4 : 3);
    if (!sig || [sig getArgumentTypeAtIndex:2][0]!='@' ||
        (withSection && strcmp([sig getArgumentTypeAtIndex:3],@encode(NSInteger))!=0)) return -1;
    NSInvocation *inv=[NSInvocation invocationWithMethodSignature:sig]; inv.selector=selector;
    [inv setArgument:&table atIndex:2];
    if (withSection) [inv setArgument:&section atIndex:3];
    return IntegerInvocationValue(inv,controller,-1);
}
static BOOL AnonymousPathWithinBounds(id controller, NSIndexPath *path) {
    if (!IsNativePath(path)) return NO;
    id table=CSGroupReadObject(controller,@"m_tableView");
    if (!table) return NO;
    long long sections=ControllerCount(controller,table,@selector(numberOfSectionsInTableView:),0,NO);
    NSUInteger section=[path indexAtPosition:0], row=[path indexAtPosition:1];
    if (sections<0 || sections>1024 || section>=(NSUInteger)sections) return NO;
    long long rows=ControllerCount(controller,table,@selector(tableView:numberOfRowsInSection:),(NSInteger)section,YES);
    return rows>=0 && rows<=100000 && row<(NSUInteger)rows;
}
NSIndexPath *CSGroupResolveNativeRowPath(id controller, CSGroupRow *row, BOOL modelDirty) {
    @try {
        if (![row isKindOfClass:CSGroupRow.class] || !IsNativePath(row.nativePath)) return nil;
        id logic=CSGroupReadObject(controller,@"m_mainFrameLogicController");
        if (!logic) return nil;
        if (![row.userName isKindOfClass:NSString.class] || !row.userName.length) {
            if (row.kind!=CSGroupRowKindBusiness && row.kind!=CSGroupRowKindAggregate) return nil;
            return !modelDirty && AnonymousPathWithinBounds(controller,row.nativePath) ? row.nativePath : nil;
        }
        if (NativeIdentityMatches(logic,row.nativePath,row)) return row.nativePath;
        id path=ResolverObjectAtPath(logic,@"indexPathOfSessionUserName:",row.userName);
        return NativeIdentityMatches(logic,path,row) ? [path copy] : nil;
    } @catch (__unused NSException *e) { return nil; }
}
NSString *CSGroupCurrentAccountID(void) {
    for (NSArray *entry in @[@[@"MMContext",@"currentUserName"],@[@"SettingUtil",@"getCurUsrName"]]) {
        id provider=NSClassFromString(entry[0]);
        NSMethodSignature *signature=Signature(provider,NSSelectorFromString(entry[1]),2);
        if (signature && signature.methodReturnType[0]=='@') {
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
NSArray *CSGroupBuildNativeSections(id controller,id table,id source) {
    @try {
        SEL rowsSEL=@selector(tableView:numberOfRowsInSection:);
        NSMethodSignature *rowSig=Signature(source,rowsSEL,4);
        if (!rowSig || !strchr("qil",rowSig.methodReturnType[0]) || !strchr("qil",[rowSig getArgumentTypeAtIndex:3][0])) return nil;
        id logic=CSGroupReadObject(controller,@"m_mainFrameLogicController");
        if (!logic) return nil;
        NSInteger count=1;
        SEL sectionsSEL=@selector(numberOfSectionsInTableView:);
        NSMethodSignature *sectionSig=Signature(source,sectionsSEL,3);
        if (sectionSig) {
            if (!strchr("qil",sectionSig.methodReturnType[0])) return nil;
            count=((NSInteger(*)(id,SEL,id))objc_msgSend)(source,sectionsSEL,table);
        }
        if (count<0 || count>1024) return nil;
        NSMutableArray *sections=[NSMutableArray array]; NSUInteger total=0;
        for (NSInteger section=0;section<count;section++) {
            NSInteger rows=((NSInteger(*)(id,SEL,id,NSInteger))objc_msgSend)(source,rowsSEL,table,section);
            if (rows<0 || rows>100000 || total+(NSUInteger)rows>100000) return nil;
            total+=rows; NSMutableArray *values=[NSMutableArray arrayWithCapacity:rows];
            for (NSInteger row=0;row<rows;row++) {
                NSUInteger indices[]={(NSUInteger)section,(NSUInteger)row}; NSIndexPath *path=[NSIndexPath indexPathWithIndexes:indices length:2];
                id session=ObjectAtPath(logic,@"getSessionInfoAtIndexPath:",path);
                id cellData=nil;
                if (!session) { cellData=ObjectAtPath(logic,@"getCellDataAtIndexPath:",path); session=CSGroupReadObject(cellData,@"m_sessionInfo"); }
                id name=CSGroupReadObject(session,@"m_nsUserName");
                CSGroupRowKind kind=CSGroupRowKindSession;
                if (![name isKindOfClass:NSString.class] || ![name length]) {
                    name=CSGroupReadObject(cellData,@"userName"); kind=CSGroupRowKindFake;
                }
                if (![name isKindOfClass:NSString.class]) name=nil;
                if (![name length]) kind=CSGroupRowKindBusiness;
                BOOL serviceContainer=[@[@"brandsessionholder",@"brandservicesessionholder"] containsObject:name ?: @""] ||
                    CSGroupReadInteger(session,@"isBrandServiceBoxSession",0) || CSGroupReadInteger(session,@"isBrandEcsMsgHolderSession",0);
                if ([name isEqual:@"chatroom_session_box"] || serviceContainer) kind=CSGroupRowKindAggregate;
                id contact=CSGroupReadObject(session,@"m_contact"); CSGroupRowCategory category=CSGroupCategoryForContact(contact);
                if ([name hasSuffix:@"@chatroom"] || [name isEqual:@"chatroom_session_box"]) category=CSGroupRowCategoryGroup;
                else if (serviceContainer || ServiceName(name ?: @"") || CSGroupReadInteger(session,@"isInBrandServiceBox",0)) category=CSGroupRowCategoryService;
                else if (category==CSGroupRowCategoryUnknown && CSGroupReadInteger(session,@"isSingleChatSession",0)) category=CSGroupRowCategoryPrivate;
                BOOL top=CSGroupReadInteger(session,@"m_bIsTop",CSGroupReadInteger(cellData,@"bTopCell",0))!=0;
                NSUInteger unread=(NSUInteger)MAX(0,CSGroupReadInteger(session,@"m_uUnReadCount",0));
                BOOL dot=CSGroupReadInteger(session,@"m_bShowUnReadAsRedDot",0)!=0;
                [values addObject:[[CSGroupRow alloc] initWithNativePath:path userName:name kind:kind category:category top:top unreadCount:unread redDot:dot]];
            }
            if (((NSInteger(*)(id,SEL,id,NSInteger))objc_msgSend)(source,rowsSEL,table,section)!=rows) return nil;
            [sections addObject:[values copy]];
        }
        return [sections copy];
    } @catch (__unused NSException *e) { return nil; }
}
