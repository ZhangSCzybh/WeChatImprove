// The generated header contains the unchanged existing fixture before its main.
// Real XML, ABI dispatch, manager, store and ingress hooks are linked.
#import "PatIngressFixture.h"

@interface SyncCmdHandler (UnifiedIngressFixture)
- (id)getReceiveMsgList;
- (BOOL)BatchAddMsg:(BOOL)fromPush ShowPush:(BOOL)showPush;
- (BOOL)handleCmds:(id)commands isFromPushData:(BOOL)fromPush showLocalPush:(BOOL)showPush;
@end

static NSArray *unifiedReceiveList;
static CMessageMgr *unifiedMessages;
static BOOL unifiedResult=YES,unifiedThrows,unifiedFromPush,unifiedShowPush;
static BOOL unifiedRevokeUnavailable;
static NSUInteger unifiedCalls,unifiedCommandCalls;
static id unifiedLastCommands;
static dispatch_block_t unifiedDuringOriginal;
static IMP unifiedOriginalService;
static const void *UnifiedCompoundKey=&UnifiedCompoundKey;

static id UnifiedGetReceiveList(id receiver,SEL selector){(void)receiver;(void)selector;return unifiedReceiveList;}
static BOOL UnifiedBatchOriginal(id receiver,SEL selector,BOOL fromPush,BOOL showPush){
    (void)receiver;(void)selector;unifiedCalls++;unifiedFromPush=fromPush;unifiedShowPush=showPush;
    if(unifiedDuringOriginal){dispatch_block_t action=unifiedDuringOriginal;unifiedDuringOriginal=nil;action();}
    if(unifiedThrows)[NSException raise:@"UnifiedOriginalException" format:@"original exception must propagate"];
    return unifiedResult;
}
static BOOL UnifiedCommandsOriginal(id receiver,SEL selector,id commands,BOOL fromPush,BOOL showPush){
    (void)receiver;(void)selector;unifiedCommandCalls++;unifiedLastCommands=commands;
    unifiedFromPush=fromPush;unifiedShowPush=showPush;return showPush;
}
static id UnifiedService(id receiver,SEL selector,NSString *name){
    if([name isEqual:@"CMessageMgr"])return unifiedRevokeUnavailable?[NSObject new]:unifiedMessages;
    return ((id(*)(id,SEL,id))unifiedOriginalService)(receiver,selector,name);
}
static id UnifiedCompound(id receiver,SEL selector){(void)selector;return objc_getAssociatedObject(receiver,UnifiedCompoundKey);}
static unsigned int UnifiedInnerType(id receiver,SEL selector){(void)selector;return objc_getAssociatedObject(receiver,UnifiedCompoundKey)?62:0;}

@interface UnifiedPatContainer : NSObject
@property(nonatomic,copy) NSString *chatUserName;
@property(nonatomic,strong) NSArray *patWraps;
@end
@implementation UnifiedPatContainer @end
@interface UnifiedMutableRaw : CMessageWrap
@property(nonatomic,strong) NSMutableString *mutableBody;
@end
@implementation UnifiedMutableRaw
- (NSString *)m_nsContent{return self.mutableBody;}
@end

static UnifiedMutableRaw *UnifiedMutableEnvelope(long long server){
    CMessageWrap *base=IngressRaw(server);UnifiedMutableRaw *wrap=[UnifiedMutableRaw new];
    wrap.m_uiMessageType=base.m_uiMessageType;wrap.m_uiCreateTime=base.m_uiCreateTime;wrap.m_n64MesSvrID=base.m_n64MesSvrID;
    wrap.m_nsFromUsr=base.m_nsFromUsr;wrap.m_nsToUsr=base.m_nsToUsr;wrap.m_nsSpecifiedChatName=base.m_nsSpecifiedChatName;
    wrap.mutableBody=[base.m_nsContent mutableCopy];return wrap;
}

static CMessageWrap *UnifiedCompoundWrap(long long server,IngressNativePat **nativePat){
    CMessageWrap *wrap=IngressRaw(server);wrap.m_uiMessageType=49;wrap.m_nsContent=@"PRIVATE_COMPOUND_BODY";
    IngressNativePat *pat=[IngressNativePat new];pat.fromUserName=@"bob";pat.pattedUserName=@"alice";pat.serverId=server;pat.createTime=(unsigned long long)wrap.m_uiCreateTime*1000;
    UnifiedPatContainer *container=[UnifiedPatContainer new];container.chatUserName=@"room@chatroom";container.patWraps=@[pat];
    objc_setAssociatedObject(wrap,UnifiedCompoundKey,container,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(nativePat)*nativePat=pat;return wrap;
}
static CMessageWrap *UnifiedText(void){CMessageWrap *wrap=IngressRaw(0);wrap.m_uiMessageType=1;wrap.m_nsContent=@"PRIVATE_TEXT_BODY";return wrap;}
static CMessageWrap *UnifiedOther(void){CMessageWrap *wrap=IngressRaw(0);wrap.m_uiMessageType=3;wrap.m_nsContent=@"PRIVATE_OTHER_BODY";return wrap;}
static void UnifiedExpectNoActions(NSUInteger textBefore,NSUInteger patBefore){
    IngressFlush(ingressManager);Advance(ingressManager,3);
    CHECK(sendCount==textBefore && patCount==patBefore && Pending(ingressManager)==0);
}
static void UnifiedExpectPair(NSUInteger textBefore,NSUInteger patBefore){
    Wait(^BOOL{return Pending(ingressManager)==2;});CHECK(sendCount==textBefore && patCount==patBefore);
    Advance(ingressManager,2);CHECK(sendCount==textBefore+1 && patCount==patBefore+1 && Pending(ingressManager)==0);
}
static void UnifiedInstallMethods(NSString *badMode){
    const char *batchEncoding="B24@0:8B16B20",*getterEncoding="@16@0:8";
    if([badMode isEqual:@"batch-return-c"])batchEncoding="c24@0:8B16B20";
    else if([badMode isEqual:@"batch-argument-I"])batchEncoding="B24@0:8I16B20";
    else if([badMode isEqual:@"batch-argument-count"])batchEncoding="B16@0:8B16";
    else if([badMode isEqual:@"receive-return-I"])getterEncoding="I16@0:8";
    CHECK(class_addMethod(SyncCmdHandler.class,@selector(getReceiveMsgList),(IMP)UnifiedGetReceiveList,getterEncoding));
    CHECK(class_addMethod(SyncCmdHandler.class,@selector(BatchAddMsg:ShowPush:),(IMP)UnifiedBatchOriginal,batchEncoding));
    CHECK(class_addMethod(SyncCmdHandler.class,@selector(handleCmds:isFromPushData:showLocalPush:),(IMP)UnifiedCommandsOriginal,"B32@0:8@16B24B28"));
    CHECK(class_addMethod(CMessageWrap.class,NSSelectorFromString(@"m_uiAppMsgInnerType"),(IMP)UnifiedInnerType,"I16@0:8"));
    CHECK(class_addMethod(CMessageWrap.class,NSSelectorFromString(@"patMessageWrap"),(IMP)UnifiedCompound,"@16@0:8"));
}

int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2 || argc==3);NSString *badMode=argc==3?@(argv[2]):@"";
    testRoot=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    sent=[NSMutableArray array];pats=[NSMutableArray array];revoked=[NSMutableArray array];observations=[NSMapTable strongToStrongObjectsMapTable];
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;protectedAvailable=NO;
    UnifiedInstallMethods(badMode);unifiedMessages=[CMessageMgr new];
    Method service=class_getInstanceMethod(CSMessageNativeEnvironment.class,@selector(serviceNamed:));CHECK(service);
    unifiedOriginalService=method_setImplementation(service,(IMP)UnifiedService);
    Method shared=class_getClassMethod(CSAutomationManager.class,@selector(sharedManager));CHECK(shared);
    method_setImplementation(shared,(IMP)IngressSharedManager);
    ingressManager=Manager();IngressConfigure(ingressManager);CSAutomationTestInstallIngressHooks();NSUInteger installed=ingressHooks;
    CSAutomationTestInstallIngressHooks();CHECK(ingressHooks==installed);
    SyncCmdHandler *handler=[SyncCmdHandler new];
    if(badMode.length){
        unifiedReceiveList=@[IngressRaw(19001)];
        CHECK([handler BatchAddMsg:YES ShowPush:NO]);
        UnifiedExpectNoActions(0,0);CHECK(unifiedCalls==1 && !notAddDBCalls && !syncAddCalls && !nativePatCalls);
        printf("Unified pat ingress ABI rejection %s: %lu checks passed; original retained, no automation\n",badMode.UTF8String,(unsigned long)checks);return 0;
    }

    CMessageWrap *raw=IngressRaw(19001);unifiedReceiveList=@[raw,UnifiedText(),UnifiedOther()];
    CHECK([handler BatchAddMsg:YES ShowPush:NO]);
    CHECK(unifiedCalls==1 && unifiedFromPush && !unifiedShowPush && !notAddDBCalls && !syncAddCalls && !nativePatCalls);
    UnifiedExpectPair(0,0);IngressCheckClaims(19001,2);
    CHECK(revokeQueries>0 && lastRevokeQuery==19001);
    CHECK([sent.lastObject[@"target"] isEqual:@"room@chatroom"] && [sent.lastObject[@"text"] containsString:@"pat answer"]);
    printf("Unified decoded batch without any downstream/native pat callback: raw10002 -> real immutable parser -> two durable actions; revoke table checked\n");

    NSUInteger textBefore=sendCount,patBefore=patCount;UnifiedMutableRaw *mutating=UnifiedMutableEnvelope(19002);unifiedReceiveList=@[mutating];
    unifiedDuringOriginal=^{[mutating.mutableBody setString:@"PRIVATE_MUTATED_NOT_XML"];mutating.m_nsFromUsr=@"PRIVATE_REPLACED_ACCOUNT";mutating.m_nsToUsr=@"PRIVATE_REPLACED_TARGET";mutating.m_n64MesSvrID=19999;};
    CHECK([handler BatchAddMsg:NO ShowPush:YES]);CHECK(!unifiedFromPush && unifiedShowPush);
    UnifiedExpectPair(textBefore,patBefore);IngressCheckClaims(19002,4);
    CHECK([mutating.mutableBody isEqual:@"PRIVATE_MUTATED_NOT_XML"]);
    printf("Original mutates raw content, route and SID before returning: pre-original snapshot retains only original verified event\n");

    textBefore=sendCount;patBefore=patCount;IngressNativePat *compoundPat=nil;CMessageWrap *compound=UnifiedCompoundWrap(19003,&compoundPat);unifiedReceiveList=@[compound];
    unifiedDuringOriginal=^{compoundPat.fromUserName=@"PRIVATE_CHANGED_SENDER";compoundPat.pattedUserName=@"PRIVATE_CHANGED_TARGET";compoundPat.serverId=19998;compoundPat.createTime=0;};
    CHECK([handler BatchAddMsg:YES ShowPush:YES]);UnifiedExpectPair(textBefore,patBefore);IngressCheckClaims(19003,6);
    CHECK([sent.lastObject[@"target"] isEqual:@"room@chatroom"] && [sent.lastObject[@"mentions"] isEqual:@[@"bob"]]);
    printf("Unified native 49/62 compound: scalar and identity snapshots survive original mutations and create the two independent actions\n");

    textBefore=sendCount;patBefore=patCount;UnifiedMutableRaw *offMainRaw=UnifiedMutableEnvelope(19009);unifiedReceiveList=@[offMainRaw];
    unifiedDuringOriginal=^{[offMainRaw.mutableBody setString:@"PRIVATE_OFFMAIN_MUTATED_BODY"];};
    IngressOffMain(^{CHECK([handler BatchAddMsg:YES ShowPush:NO]);});
    UnifiedExpectPair(textBefore,patBefore);IngressCheckClaims(19009,8);
    CHECK([offMainRaw.mutableBody isEqual:@"PRIVATE_OFFMAIN_MUTATED_BODY"]);
    printf("Off-main decoded batch copies the raw envelope on caller context and strictly parses on main, producing the two actions\n");

    textBefore=sendCount;patBefore=patCount;unifiedResult=NO;unifiedReceiveList=@[IngressRaw(19004)];
    CHECK(![handler BatchAddMsg:NO ShowPush:NO]);UnifiedExpectNoActions(textBefore,patBefore);
    unifiedResult=YES;unifiedThrows=YES;unifiedReceiveList=@[IngressRaw(19005)];BOOL threw=NO;
    @try{[handler BatchAddMsg:YES ShowPush:NO];}@catch(NSException *exception){threw=[exception.name isEqual:@"UnifiedOriginalException"];}
    CHECK(threw);unifiedThrows=NO;UnifiedExpectNoActions(textBefore,patBefore);
    printf("Native rejection and original exception: no dispatch, BOOL and exception preserved\n");

    unifiedMessages.revokedServer=19006;unifiedReceiveList=@[IngressRaw(19006)];NSUInteger queries=revokeQueries;
    CHECK([handler BatchAddMsg:YES ShowPush:NO]);UnifiedExpectNoActions(textBefore,patBefore);
    CHECK(revokeQueries>queries && lastRevokeQuery==19006);unifiedMessages.revokedServer=0;
    printf("Existing native revoke-table entry blocks unified pat before claims and submissions\n");

    NSUInteger recordsBefore=[IngressRuntime()[@"records"] count];unifiedRevokeUnavailable=YES;unifiedReceiveList=@[IngressRaw(19010)];
    CHECK([handler BatchAddMsg:NO ShowPush:NO]);UnifiedExpectNoActions(textBefore,patBefore);
    CHECK(!CSMessageNativeSupports([[CSMessageNativeEnvironment new] serviceNamed:@"CMessageMgr"],@"GetRevokeMsgBySvrId:",@"@",@[@"q"]) && [IngressRuntime()[@"records"] count]==recordsBefore);unifiedRevokeUnavailable=NO;
    printf("Missing revoke-table ABI fails closed before ledger claims; no unverified action\n");

    unifiedReceiveList=@[IngressRaw(19007)];CHECK([handler BatchAddMsg:YES ShowPush:NO]);epoch++;
    UnifiedExpectNoActions(textBefore,patBefore);
    [ingressManager refresh];Wait(^BOOL{return ingressManager.ready && ingressManager.accountEpoch==epoch;});
    printf("Account epoch changes after accepted native batch but before queued main delivery: stale pat discarded\n");

    CMessageWrap *overlapRaw=IngressRaw(19008);unifiedReceiveList=@[overlapRaw];
    CHECK([handler BatchAddMsg:YES ShowPush:NO]);[unifiedMessages onNewSyncNotAddDBMessage:overlapRaw];
    Wait(^BOOL{return Pending(ingressManager)==2;});Advance(ingressManager,2);
    CHECK(sendCount==textBefore+1 && patCount==patBefore+1 && Pending(ingressManager)==0);
    IngressCheckClaims(19008,10);
    [unifiedMessages onNewSyncAddMessage:overlapRaw];CHECK([handler BatchAddMsg:NO ShowPush:YES]);
    UnifiedExpectNoActions(textBefore+1,patBefore+1);
    printf("Unified and overlapping NotAddDB/SyncAdd routes share stable identity and produce one text plus one pat total\n");

    NSArray *commands=@[@{@"PRIVATE_PROTOBUF_BODY":@"PRIVATE_IDENTITY"}];NSUInteger commandBefore=unifiedCommandCalls;
    CHECK(![handler handleCmds:commands isFromPushData:YES showLocalPush:NO]);
    CHECK(unifiedCommandCalls==commandBefore+1 && unifiedLastCommands==commands && unifiedFromPush && !unifiedShowPush);
    CHECK(!protectedAvailable && UIApplication.sharedApplication.applicationState==UIApplicationStateBackground);
    printf("Command boundary keeps original array/flags/BOOL and does not parse protobuf bodies\n");
    [NSNotificationCenter.defaultCenter removeObserver:ingressManager];
    printf("Automation unified pat ingress: %lu checks passed\n",(unsigned long)checks);return 0;
}}
