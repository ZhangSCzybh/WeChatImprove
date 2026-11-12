// Reuse only the isolated capability environment and recording send seams.
// Event normalization, native ABI dispatch, manager and storage stay real.
#define CS_AUTOMATION_REAL_EVENT_ADAPTER 1
#define main CSAutomationManagerFixtureUnusedMain
#import "AutomationManagerTests.m"
#undef main

static AutomationTestManager *ingressManager;
static NSUInteger ingressHooks,notAddDBCalls,syncAddCalls,nativePatCalls,revokeQueries;
static long long lastRevokeQuery;
static id lastNativeRaw;

void CSAutomationTestInstallIngressHooks(void);
void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original){
    CHECK(NSThread.isMainThread);Method method=class_getInstanceMethod(cls,selector);CHECK(method && replacement && original);
    *original=method_getImplementation(method);class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));ingressHooks++;
}

@interface CMessageWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType,m_uiCreateTime,m_uiMesLocalID;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsSpecifiedChatName;
@end
@implementation CMessageWrap @end

@interface CMessageMgr : NSObject
@property(nonatomic) long long revokedServer;
- (void)onNewSyncNotAddDBMessage:(id)wrap;
- (void)onNewSyncAddMessage:(id)wrap;
- (id)GetRevokeMsgBySvrId:(long long)server;
@end
@implementation CMessageMgr
- (void)onNewSyncNotAddDBMessage:(id)wrap{notAddDBCalls++;lastNativeRaw=wrap;}
- (void)onNewSyncAddMessage:(id)wrap{syncAddCalls++;lastNativeRaw=wrap;}
- (id)GetRevokeMsgBySvrId:(long long)server{revokeQueries++;lastRevokeQuery=server;return self.revokedServer==server?@YES:nil;}
@end

@interface SyncCmdHandler : NSObject
@property(nonatomic,strong) id lastMessages;
@property(nonatomic) BOOL lastFromPush,lastShowPush,throwsBatch;
- (BOOL)handleBatchMessages:(id)messages isFromPushData:(BOOL)fromPush ShowPush:(BOOL)showPush;
@end
@implementation SyncCmdHandler
- (BOOL)handleBatchMessages:(id)messages isFromPushData:(BOOL)fromPush ShowPush:(BOOL)showPush{
    self.lastMessages=messages;self.lastFromPush=fromPush;self.lastShowPush=showPush;
    if(self.throwsBatch)[NSException raise:@"NativeBatch" format:@"must propagate"];
    return showPush;
}
@end

@interface IngressNativePat : NSObject
@property(nonatomic,copy) NSString *fromUserName,*pattedUserName;
@property(nonatomic) long long serverId;
@property(nonatomic) unsigned long long createTime;
@end
@implementation IngressNativePat @end

@interface SendPatMgr : NSObject
- (unsigned int)addPatWrap:(id)pat toChat:(id)conversation newXMLMessageWrap:(id)xml index:(unsigned long long *)index;
@end
@implementation SendPatMgr
- (unsigned int)addPatWrap:(id)pat toChat:(id)conversation newXMLMessageWrap:(id)xml index:(unsigned long long *)index{
    (void)pat;(void)conversation;(void)xml;if(index)*index=0;nativePatCalls++;return 1;
}
@end

static id IngressSharedManager(id receiver,SEL selector){(void)receiver;(void)selector;return ingressManager;}
static void IngressOffMain(void (^operation)(void)){
    dispatch_semaphore_t finished=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{operation();dispatch_semaphore_signal(finished);});
    CHECK(!dispatch_semaphore_wait(finished,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC)));
}
static void IngressFlush(AutomationTestManager *manager){
    __block BOOL mainDone=NO,ioDone=NO;
    dispatch_async(dispatch_get_main_queue(),^{mainDone=YES;});Wait(^BOOL{return mainDone;});
    dispatch_async([manager valueForKey:@"io"],^{dispatch_async(dispatch_get_main_queue(),^{ioDone=YES;});});
    Wait(^BOOL{return ioDone && [[manager valueForKey:@"admissions"] count]==0;});
}
static CMessageWrap *IngressRaw(long long server){
    CMessageWrap *raw=[CMessageWrap new];raw.m_uiMessageType=10002;raw.m_uiCreateTime=(unsigned int)wall;raw.m_uiMesLocalID=0;raw.m_n64MesSvrID=server;
    raw.m_nsFromUsr=@"room@chatroom";raw.m_nsToUsr=@"alice";raw.m_nsSpecifiedChatName=@"room@chatroom";
    raw.m_nsContent=@"<sysmsg type=\"pat\"><pat><fromusername><![CDATA[bob]]></fromusername><chatusername>room@chatroom</chatusername><pattedusername>alice</pattedusername><template><![CDATA[bob拍了拍alice]]></template></pat></sysmsg>";
    return raw;
}
static void IngressConfigure(AutomationTestManager *manager){
    NSMutableDictionary *back=Module(manager,@"patBack"),*reply=Module(manager,@"patReply");
    [back addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"delay":@2,@"revoke":@NO}];
    [reply addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"delay":@2,@"contents":@[@"pat answer"],@"mention":@YES}];
    Save(manager,@{@"patBack":back,@"patReply":reply});
}
static NSDictionary *IngressRuntime(void){
    NSURL *url=[[CSAutomationFileURL(testRoot,account) URLByDeletingPathExtension] URLByAppendingPathExtension:@"runtime.plist"];
    NSData *data=[NSData dataWithContentsOfURL:url];CHECK(data.length>0);NSError *error=nil;
    NSDictionary *runtime=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
    CHECK(runtime && !error && [runtime[@"account"] isEqual:account]);return runtime;
}
static void IngressCheckClaims(long long server,NSUInteger total){
    NSArray *records=IngressRuntime()[@"records"];CHECK(records.count==total);
    NSString *identity=[NSString stringWithFormat:@"alice|room@chatroom|pat:%lld",server];
    for(NSString *action in @[@"patBack",@"patReply"]){
        NSUInteger matches=0;for(NSDictionary *record in records)if([record[@"action"] isEqual:action] && [record[@"ids"] containsObject:identity])matches++;
        CHECK(matches==1);
    }
}

int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2);testRoot=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    sent=[NSMutableArray array];pats=[NSMutableArray array];revoked=[NSMutableArray array];observations=[NSMapTable strongToStrongObjectsMapTable];
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;protectedAvailable=NO;
    Method shared=class_getClassMethod(CSAutomationManager.class,@selector(sharedManager));CHECK(shared);
    method_setImplementation(shared,(IMP)IngressSharedManager);
    ingressManager=Manager();IngressConfigure(ingressManager);CSAutomationTestInstallIngressHooks();NSUInteger installed=ingressHooks;
    CSAutomationTestInstallIngressHooks();CHECK(ingressHooks==installed);

    CMessageMgr *messages=[CMessageMgr new];SendPatMgr *native=[SendPatMgr new];CMessageWrap *raw=IngressRaw(9001);
    SyncCmdHandler *sync=[SyncCmdHandler new];NSArray *batch=@[raw];
    CHECK(![sync handleBatchMessages:batch isFromPushData:YES ShowPush:NO]);
    CHECK(sync.lastMessages==batch && sync.lastFromPush && !sync.lastShowPush && !notAddDBCalls && !patCount && !sendCount);
    sync.throwsBatch=YES;BOOL nativeThrew=NO;
    @try{[sync handleBatchMessages:batch isFromPushData:NO ShowPush:YES];}@catch(NSException *exception){nativeThrew=[exception.name isEqual:@"NativeBatch"];}
    CHECK(nativeThrew && sync.lastMessages==batch && !sync.lastFromPush && sync.lastShowPush);sync.throwsBatch=NO;
    CHECK(![raw respondsToSelector:NSSelectorFromString(@"patMessageWrap")] && raw.m_uiMesLocalID==0);
    IngressOffMain(^{[messages onNewSyncNotAddDBMessage:raw];});
    CHECK(notAddDBCalls==1 && lastNativeRaw==raw && !syncAddCalls && !nativePatCalls && !sendCount && !patCount);
    Wait(^BOOL{return Pending(ingressManager)==2;});
    CHECK(!sendCount && !patCount);IngressCheckClaims(9001,2);
    NSArray *tasks=[[ingressManager valueForKey:@"tasks"] allValues];
    id parsedSource=[[tasks.firstObject valueForKey:@"event"] objectForKey:@"source"];
    CHECK([NSStringFromClass([parsedSource class]) isEqual:@"CSAutomationPatSnapshot"]);
    CHECK(CSMessageNativeSupports(parsedSource,@"serverId",@"q",@[]) && CSMessageNativeSupports(parsedSource,@"createTime",@"Q",@[]));
    CHECK([CSMessageNativeInvoke(parsedSource,@"serverId",@[]) longLongValue]==9001 && CSMessageNativeUnsigned(parsedSource,@"createTime")==raw.m_uiCreateTime*1000ULL);
    NSDictionary *parsedEvent=[tasks.firstObject valueForKey:@"event"];
    CHECK([parsedEvent[@"conversation"] isEqual:@"room@chatroom"] && [parsedEvent[@"sender"] isEqual:@"bob"] && [CSMessageNativeInvoke(parsedSource,@"pattedUserName",@[]) isEqual:@"alice"] && [parsedEvent[@"identifiers"] isEqual:@[@"alice|room@chatroom|pat:9001"]]);
    contactsAvailable=NO;Advance(ingressManager,2);CHECK(sendCount==0 && patCount==0 && Pending(ingressManager)==2);
    for(id task in tasks)CHECK([[[ingressManager valueForKey:@"tasks"] allValues] containsObject:task] && [[task valueForKey:@"wakeAt"] doubleValue]>uptime && [[task valueForKey:@"wakeAt"] doubleValue]<=[[task valueForKey:@"deadline"] doubleValue]);
    contactsAvailable=YES;Advance(ingressManager,5);CHECK(sendCount==1 && patCount==1 && Pending(ingressManager)==0);
    CHECK(sent.count==1 && pats.count==1);
    CHECK([sent.lastObject[@"target"] isEqual:@"room@chatroom"] && [sent.lastObject[@"text"] containsString:@"pat answer"] && [sent.lastObject[@"mentions"] isEqual:@[@"bob"]]);
    CHECK(!protectedAvailable && UIApplication.sharedApplication.applicationState==UIApplicationStateBackground);
    printf("Raw10002 NotAddDB -> real XML parser -> real EventFromPat -> two durable claims -> text=1 pat=1; localID=0 no native PatMessageWrap; simulated locked/background fixture=yes\n");

    IngressNativePat *overlap=[IngressNativePat new];overlap.fromUserName=@"bob";overlap.pattedUserName=@"alice";overlap.serverId=9001;overlap.createTime=raw.m_uiCreateTime*1000ULL;
    [messages onNewSyncAddMessage:raw];[native addPatWrap:overlap toChat:@"room@chatroom" newXMLMessageWrap:raw index:NULL];[messages onNewSyncNotAddDBMessage:raw];
    IngressFlush(ingressManager);Advance(ingressManager,3);CHECK(sendCount==1 && patCount==1 && Pending(ingressManager)==0);IngressCheckClaims(9001,2);
    [NSNotificationCenter.defaultCenter removeObserver:ingressManager];ingressManager=Manager();
    [messages onNewSyncNotAddDBMessage:raw];IngressFlush(ingressManager);Advance(ingressManager,3);
    CHECK(sendCount==1 && patCount==1 && Pending(ingressManager)==0);IngressCheckClaims(9001,2);
    printf("Same SID raw/syncAdd/nativePat/repeated raw and manager rebuild: no duplicate text/pat; both independent claims retained on disk\n");

    messages.revokedServer=9003;CMessageWrap *revokedRaw=IngressRaw(9003);NSUInteger previousQueries=revokeQueries;
    IngressOffMain(^{[messages onNewSyncNotAddDBMessage:revokedRaw];});IngressFlush(ingressManager);Advance(ingressManager,3);
    CHECK(revokeQueries>previousQueries && lastRevokeQuery==9003 && sendCount==1 && patCount==1 && Pending(ingressManager)==0);IngressCheckClaims(9001,2);
    messages.revokedServer=0;
    printf("Revoke preceding raw pat: native service lookup confirmed existing revoke; no pat/text claims or submissions created\n");

    [NSNotificationCenter.defaultCenter removeObserver:ingressManager];backupReady=NO;ingressManager=[AutomationTestManager new];CMessageWrap *coldRaw=IngressRaw(9002);
    IngressOffMain(^{[messages onNewSyncNotAddDBMessage:coldRaw];});
    Wait(^BOOL{return [[ingressManager valueForKey:@"waitingIngress"] count]==2;});
    CHECK(!ingressManager.ready && sendCount==1 && patCount==1);
    NSArray *waiting=[ingressManager valueForKey:@"waitingIngress"];id queuedPat=nil;
    for(NSDictionary *entry in waiting)if([entry[@"pat"] boolValue])queuedPat=entry[@"wrap"];else CHECK(entry[@"wrap"]==coldRaw);
    CHECK(queuedPat && [NSStringFromClass([queuedPat class]) isEqual:@"CSAutomationPatSnapshot"]);
    CHECK([CSMessageNativeInvoke(queuedPat,@"serverId",@[]) longLongValue]==9002 && CSMessageNativeUnsigned(queuedPat,@"createTime")==coldRaw.m_uiCreateTime*1000ULL);
    Advance(ingressManager,10);CHECK(sendCount==1 && patCount==1 && !protectedAvailable);
    backupReady=YES;[ingressManager refresh];Wait(^BOOL{return ingressManager.ready && sendCount==2 && patCount==2;});
    CHECK(!protectedAvailable && UIApplication.sharedApplication.applicationState==UIApplicationStateBackground && Pending(ingressManager)==0);IngressCheckClaims(9002,4);
    [messages onNewSyncNotAddDBMessage:coldRaw];IngressFlush(ingressManager);CHECK(sendCount==2 && patCount==2);
    printf("Cold backup !ready: original raw and immutable parsed pat retained; recovery with protectedAvailable=NO submits text=1 pat=1 without restarting original delay (simulated fixture)\n");
    printf("Automation real pat ingress: %lu checks passed\n",(unsigned long)checks);return 0;
}}
