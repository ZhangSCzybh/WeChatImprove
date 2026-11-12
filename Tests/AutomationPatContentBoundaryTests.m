// Strict native group sender-prefix and end-to-end pat boundary coverage.
// The generated fixture stops before its main and links the real parser,
// checked native dispatcher, ingress, manager and durable store.
#import "UnifiedPatIngressFixture.h"

static NSDictionary *BoundaryParse(CMessageWrap *wrap){
    return CSAutomationPatFromXMLMessage(wrap,@"");
}
static CMessageWrap *BoundaryPrefixed(long long server){
    CMessageWrap *wrap=IngressRaw(server);
    wrap.m_nsContent=[@"bob:\n" stringByAppendingString:wrap.m_nsContent];return wrap;
}
static void BoundaryReject(NSString *content){
    CMessageWrap *wrap=IngressRaw(21000);wrap.m_nsContent=content;
    CHECK(!BoundaryParse(wrap));

}
static void BoundaryParserTests(void){
    CMessageWrap *wrap=IngressRaw(21000);NSString *base=wrap.m_nsContent;
    NSDictionary *parsed=BoundaryParse(wrap);
    CHECK(parsed && [parsed[@"conversation"] isEqual:@"room@chatroom"]);
    CHECK([CSMessageNativeInvoke(parsed[@"pat"],@"fromUserName",@[]) isEqual:@"bob"] && [CSMessageNativeInvoke(parsed[@"pat"],@"pattedUserName",@[]) isEqual:@"alice"] && [CSMessageNativeInvoke(parsed[@"pat"],@"serverId",@[]) longLongValue]==21000);
    CHECK([CSAutomationEventFromPat(parsed[@"pat"],account,parsed[@"conversation"])[@"identifiers"] isEqual:@[@"alice|room@chatroom|pat:21000"]]);

    wrap=BoundaryPrefixed(21000);parsed=BoundaryParse(wrap);
    CHECK(parsed);
    CHECK([parsed[@"conversation"] isEqual:@"room@chatroom"]);
    id pat=parsed[@"pat"];
    CHECK([CSMessageActionNativeObject(pat,@"fromUserName") isEqual:@"bob"]);
    CHECK([CSMessageActionNativeObject(pat,@"pattedUserName") isEqual:@"alice"]);
    CHECK([CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue]==21000);
    NSDictionary *event=CSAutomationEventFromPat(pat,account,parsed[@"conversation"]);
    CHECK(event && [event[@"identifiers"] containsObject:@"alice|room@chatroom|pat:21000"]);

    wrap=BoundaryPrefixed(21000);wrap.m_nsFromUsr=@"bob";
    CHECK(BoundaryParse(wrap)!=nil);
    wrap.m_nsSpecifiedChatName=@"PRIVATE_OTHER_ROOM@chatroom";
    CHECK(!BoundaryParse(wrap));

    // This verifies the native-supported delimiter, not arbitrary prefix removal.
    NSArray *badPrefixes=@[@"PRIVATE_JUNK",@"PRIVATE_OTHER:\n",@"bob:",@"bob: ",@"bob:\r\n",@"bob\n",@" bob:\n",@"bob :\n",@"room@chatroom:\n",@"bob:\nbob:\n",@"bob:\nPRIVATE_JUNK",@"<![CDATA[bob:\n]]>"];
    for(NSString *prefix in badPrefixes)BoundaryReject([prefix stringByAppendingString:base]);
    BoundaryReject([@"bob:\n" stringByAppendingString:[base stringByReplacingOccurrencesOfString:@"type=\"pat\"" withString:@"type=\"PRIVATE_OTHER_TYPE\""]]);
    BoundaryReject([@"bob:\n" stringByAppendingString:[base stringByReplacingOccurrencesOfString:@"<fromusername><![CDATA[bob]]></fromusername>" withString:@"<fromusername><![CDATA[PRIVATE_DIFFERENT_SENDER]]></fromusername>"]]);
    BoundaryReject([@"bob:\n" stringByAppendingString:[base stringByReplacingOccurrencesOfString:@"<chatusername>room@chatroom</chatusername>" withString:@"<chatusername>PRIVATE_OTHER_ROOM@chatroom</chatusername>"]]);
    BoundaryReject([@"bob:\n" stringByAppendingString:[base stringByReplacingOccurrencesOfString:@"<pattedusername>alice</pattedusername>" withString:@"<pattedusername>PRIVATE_OTHER_TARGET</pattedusername>"]]);
    BoundaryReject([@"bob:\n" stringByAppendingString:[base stringByReplacingOccurrencesOfString:@"</pat>" withString:@"<fromusername>bob</fromusername></pat>"]]);
    BoundaryReject([@"bob:\n" stringByAppendingString:[base stringByReplacingOccurrencesOfString:@"</sysmsg>" withString:@""]]);
    BoundaryReject([@"bob:\n<!DOCTYPE sysmsg [<!ENTITY x 'PRIVATE_ENTITY'>]>" stringByAppendingString:base]);
    BoundaryReject([@"bob:\n" stringByAppendingString:[base stringByAppendingString:base]]);
    BoundaryReject([@"bob:\n" stringByAppendingString:[base stringByAppendingString:@"PRIVATE_TRAILING_JUNK"]]);
    BoundaryReject(@"bob:\n<msg><appmsg><title><![CDATA[<sysmsg type=\"pat\"><pat>PRIVATE_SPOOF</pat></sysmsg>]]></title></appmsg></msg>");

    wrap=IngressRaw(21000);wrap.m_nsFromUsr=@"bob";wrap.m_nsSpecifiedChatName=nil;
    wrap.m_nsContent=[base stringByReplacingOccurrencesOfString:@"<chatusername>room@chatroom</chatusername>" withString:@"<chatusername>alice</chatusername>"];
    CHECK(BoundaryParse(wrap)!=nil);
    wrap.m_nsContent=[@"bob:\n" stringByAppendingString:wrap.m_nsContent];
    CHECK(!BoundaryParse(wrap));

    // Non-pat sysmsg roots are rejected independently of length and prefix.
    for(NSString *content in @[@"<sysmsg type=\"PRIVATE_OTHER_TYPE\"><n/></sysmsg>",@"bob:\n<sysmsg type=\"PRIVATE_OTHER_TYPE\"><n/></sysmsg>"]){
        wrap=IngressRaw(21000);wrap.m_nsContent=content;
        CHECK(!BoundaryParse(wrap));
    }
    printf("Content boundary: strict XML and native group sender delimiter accepted; wrong identities, junk, private prefix, malformed and spoofed XML rejected\n");
}

int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2);testRoot=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    sent=[NSMutableArray array];pats=[NSMutableArray array];revoked=[NSMutableArray array];observations=[NSMapTable strongToStrongObjectsMapTable];
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;protectedAvailable=YES;
    BoundaryParserTests();
    UnifiedInstallMethods(@"");unifiedMessages=[CMessageMgr new];
    Method service=class_getInstanceMethod(CSMessageNativeEnvironment.class,@selector(serviceNamed:));CHECK(service);
    unifiedOriginalService=method_setImplementation(service,(IMP)UnifiedService);
    Method shared=class_getClassMethod(CSAutomationManager.class,@selector(sharedManager));CHECK(shared);
    method_setImplementation(shared,(IMP)IngressSharedManager);
    ingressManager=Manager();IngressConfigure(ingressManager);CSAutomationTestInstallIngressHooks();
    SyncCmdHandler *handler=[SyncCmdHandler new];

    UnifiedMutableRaw *raw=UnifiedMutableEnvelope(21001);
    raw.mutableBody=[[@"bob:\n" stringByAppendingString:[raw.mutableBody copy]] mutableCopy];
    NSString *originalBody=[raw.mutableBody copy];NSUInteger originalLength=originalBody.length;
    CHECK(originalLength>4 && [originalBody lengthOfBytesUsingEncoding:NSUTF8StringEncoding]>originalLength);
    unifiedReceiveList=@[raw];
    unifiedDuringOriginal=^{[raw.mutableBody setString:@"PRIVATE_ORIGINAL_MUTATED_BODY"];};
    NSTimeInterval started=wall;
    IngressOffMain(^{CHECK([handler BatchAddMsg:YES ShowPush:NO]);});
    CHECK(unifiedCalls==1 && !notAddDBCalls && !syncAddCalls && !nativePatCalls);
    Wait(^BOOL{return Pending(ingressManager)==2;});
    NSDictionary *snapshotEvent=[[[ingressManager valueForKey:@"tasks"] allValues].firstObject valueForKey:@"event"];id snapshotSource=snapshotEvent[@"source"];
    UnifiedExpectPair(0,0);IngressCheckClaims(21001,2);
    CHECK(wall-started<60 && UIApplication.sharedApplication.applicationState==UIApplicationStateBackground && protectedAvailable);
    CHECK([raw.mutableBody isEqual:@"PRIVATE_ORIGINAL_MUTATED_BODY"]);
    CHECK([sent.lastObject[@"target"] isEqual:@"room@chatroom"] && pats.count==1);
    CHECK([CSMessageNativeInvoke(snapshotSource,@"serverId",@[]) longLongValue]==21001 && CSMessageNativeUnsigned(snapshotSource,@"createTime")==raw.m_uiCreateTime*1000ULL);
    CHECK([snapshotEvent[@"identifiers"] isEqual:@[@"alice|room@chatroom|pat:21001"]] && ![snapshotSource isEqual:raw]);

    CHECK(unifiedReceiveList.count==1 && raw.m_uiMessageType==10002 && CSMessageNativeUnsigned(raw,@"m_uiAppMsgInnerType")==0);
    CHECK([snapshotEvent[@"conversation"] isEqual:@"room@chatroom"] && [snapshotEvent[@"sender"] isEqual:@"bob"] && [CSMessageNativeInvoke(snapshotSource,@"pattedUserName",@[]) isEqual:@"alice"]);
    Advance(ingressManager,58);CHECK(sendCount==1 && patCount==1 && Pending(ingressManager)==0);
    CHECK(UIApplication.sharedApplication.applicationState==UIApplicationStateBackground);
    printf("Background fixture: off-main raw10002 -> copied complete prefixed body -> real strict parser -> two durable actions within simulated 60s, no49/no foreground notification; phone delivery remains unproved\n");

    // Later native aggregate is only a duplicate, not a required source.
    unifiedReceiveList=@[UnifiedCompoundWrap(21001,NULL)];
    CHECK([handler BatchAddMsg:YES ShowPush:NO]);UnifiedExpectNoActions(1,1);IngressCheckClaims(21001,2);
    CHECK(((CMessageWrap *)unifiedReceiveList.firstObject).m_uiMessageType==49 && CSMessageNativeUnsigned(unifiedReceiveList.firstObject,@"m_uiAppMsgInnerType")==62);
    printf("Same-SID native49/62 arriving later: no second reply or back-pat\n");

    // This models a running background process with unavailable protected data.
    // It does not model iOS suspension or establish lock-screen wake capability.
    protectedAvailable=NO;unifiedReceiveList=@[BoundaryPrefixed(21002)];
    IngressOffMain(^{CHECK([handler BatchAddMsg:YES ShowPush:NO]);});
    UnifiedExpectPair(1,1);IngressCheckClaims(21002,4);
    CHECK(!protectedAvailable && UIApplication.sharedApplication.applicationState==UIApplicationStateBackground);
    printf("Protected-data-unavailable running-process fixture: two actions without unlock; real suspension and peer-visible delivery require phone validation\n");
    [NSNotificationCenter.defaultCenter removeObserver:ingressManager];
    printf("Automation pat content boundary: %lu checks passed\n",(unsigned long)checks);return 0;
}}
