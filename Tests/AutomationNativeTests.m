#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import "CSAutomationNativeAdapter.h"
#import "CSMessageSendAdapter.h"
#import "CSAutomationManager.h"
#import "CSAutomationEventAdapter.h"
#import "CSAutomationOwnership.h"
#import "CSBackupBootstrap.h"

static NSUInteger checks,hooks,epoch=12,messageEvents,patEvents,ownedRemembers;
static BOOL suspended,accountLock;
static id receivedSession,receivedWrap,receivedPat;
static NSMutableArray *receivedPats;
static NSString *managerAccount=@"me",*rememberedAccount;
static id mustBeRememberedBeforeWrap;
static unsigned int rememberedLocalID;
static NSMutableArray *trace;
static NSUInteger xmlParserCalls;
static id xmlParserWrap,xmlParserSession;
static NSDictionary *xmlParserResult;
static BOOL xmlParserThrows;
#define CHECK(c) do {checks++;if(!(c)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c);exit(1);}}while(0)
void CSAutomationTestInstallIngressHooks(void);
void CSAutomationTestBootstrapIngress(void);
// This fixture covers message/pat ingress and send hooks; sync wake hooks have
// their own runtime fixture in AutomationNativeSyncTests.m.
void CSAutomationInstallNativeSync(void){}
NSUInteger CSBackupAccountEpoch(void){return epoch;}
BOOL CSBackupAccountIsSuspended(void){return suspended;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger expected,void (^handoff)(void)){
    CHECK(NSThread.isMainThread);CHECK(!accountLock);if(expected!=epoch)return NO;
    accountLock=YES;handoff();accountLock=NO;return YES;
}
void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original){
    CHECK(NSThread.isMainThread);Method method=class_getInstanceMethod(cls,selector);CHECK(method && replacement && original);
    *original=method_getImplementation(method);class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));hooks++;
}
void CSAutomationMarkOwnedSend(id wrap){CSAutomationTagOwnedSend(wrap);}
BOOL CSAutomationIsOwnedSend(id wrap){return CSAutomationHasOwnedTag(wrap);}
void CSAutomationRememberOwnedSend(id wrap,NSString *account,NSString *conversation){
    CHECK(NSThread.isMainThread);CHECK([account isEqual:@"me"]);CHECK([conversation isEqual:receivedSession] || receivedSession==nil);
    CHECK(CSAutomationIsOwnedSend(wrap));rememberedAccount=account;rememberedLocalID=[CSMessageNativeInvoke(wrap,@"m_uiMesLocalID",@[]) unsignedIntValue];ownedRemembers++;[trace addObject:@"remember"];
}
// This suite owns the ingress seam only. Core and manager integration suites
// exercise the real XML parser and authorization; this must not parse fixtures
// or manufacture PatMessageWraps and claim protocol coverage.
NSDictionary *CSAutomationPatFromXMLMessage(id wrap,NSString *session){
    CHECK(NSThread.isMainThread);xmlParserCalls++;xmlParserWrap=wrap;xmlParserSession=session;[trace addObject:@"xml-parser"];
    if(xmlParserThrows)[NSException raise:@"ParserFailure" format:@"isolated from native reception"];
    return xmlParserResult;
}
// Legacy ingress fixtures expose no unified SyncCmdHandler selectors. Resolve
// that new production class dependency without creating another native route.
@implementation CSMessageNativeEnvironment
- (NSString *)currentAccountID{return managerAccount;}
- (id)serviceNamed:(NSString *)name{(void)name;return nil;}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
@implementation CSAutomationManager
+ (instancetype)sharedManager{static id value;static dispatch_once_t once;dispatch_once(&once,^{value=[self new];});return value;}
- (NSString *)accountID{return managerAccount;}
- (BOOL)ready{return NO;}
- (void)receiveNativeSession:(id)session wrap:(id)wrap epoch:(NSUInteger)eventEpoch{
    if(wrap==mustBeRememberedBeforeWrap){CHECK([rememberedAccount isEqual:@"me"]);CHECK(rememberedLocalID==17);}
    CHECK(NSThread.isMainThread);CHECK(eventEpoch==epoch);messageEvents++;receivedSession=session;receivedWrap=wrap;[trace addObject:@"message"];
}
- (void)receivePat:(id)pat conversation:(NSString *)conversation epoch:(NSUInteger)eventEpoch{
    CHECK(NSThread.isMainThread);CHECK(eventEpoch==epoch);CHECK([conversation isEqual:@"room@chatroom"]);patEvents++;receivedPat=pat;[receivedPats addObject:pat];[trace addObject:@"pat"];
}
@end

@interface PatWrap : NSObject
@property(nonatomic,copy) NSString *fromUserName,*pattedUserName;
@property long long serverId;
@property unsigned long long createTime;
@property BOOL canRevoke;
@end
@implementation PatWrap @end
@interface TestPatMessageWrap : NSObject
@property(nonatomic,copy) NSString *chatUserName;
@property(nonatomic,strong) id patWraps;
@end
@implementation TestPatMessageWrap @end
@interface WrongPatTime : NSObject
@property long long serverId;
@property unsigned int createTime;
@end
@implementation WrongPatTime @end
@interface TestSendPatWrap : NSObject
@property(nonatomic,copy) NSString *fromUserName,*pattedUserName,*chatUserName;
@property unsigned long long scene;
@property(nonatomic,strong) PatWrap *patWrap;
- (BOOL)isValid;
@end
@implementation TestSendPatWrap
- (BOOL)isValid{return self.fromUserName.length && self.pattedUserName.length && self.chatUserName.length;}
@end
@interface SendPatCgi : NSObject
@property(nonatomic,strong) TestSendPatWrap *sendPatWrap;
@property NSUInteger failures;
- (void)didFailWithError:(id)error response:(id)response;
@end
@implementation SendPatCgi
- (void)didFailWithError:(id)error response:(id)response{(void)error;(void)response;self.failures++;[trace addObject:@"cgi-failure"];}
@end
@interface TestSendPatMgr : NSObject
@property BOOL accepts,syncSuccess,throwsSend,throwsRevoke,throwsAdd;
@property NSUInteger sends,revokes,guides,updates,adds;
@property unsigned int interval,nextLocalID;
@property(nonatomic,strong) TestSendPatWrap *lastSend,*lastRevoke;
@property(nonatomic,strong) id lastPat,lastChat,lastXML;
@property(nonatomic,copy) void (^duringSend)(TestSendPatWrap *wrap);
- (BOOL)sendPat:(TestSendPatWrap *)wrap;
- (BOOL)checkAndShowRevokeGuideForSendPat:(TestSendPatWrap *)wrap;
- (void)updatePatSuffix:(id)suffix serverId:(long long)serverID forSendPatWrap:(TestSendPatWrap *)wrap;
- (void)revokeSendPat:(TestSendPatWrap *)wrap;
- (unsigned int)patSendLongPressRevokeInterval;
- (unsigned int)addPatWrap:(id)pat toChat:(id)chat newXMLMessageWrap:(id)xml index:(unsigned long long *)index;
@end
@implementation TestSendPatMgr
- (BOOL)sendPat:(TestSendPatWrap *)wrap{
    CHECK(NSThread.isMainThread);CHECK(accountLock);self.sends++;self.lastSend=wrap;[trace addObject:@"send"];
    if(self.throwsSend)[NSException raise:@"NativeSend" format:@"after submission"];
    if(!self.accepts)return NO;
    CHECK(![self checkAndShowRevokeGuideForSendPat:wrap]);
    PatWrap *pat=[PatWrap new];pat.fromUserName=wrap.fromUserName;pat.pattedUserName=wrap.pattedUserName;pat.canRevoke=YES;wrap.patWrap=pat;
    if(self.duringSend)self.duringSend(wrap);
    if(self.syncSuccess){pat.serverId=101;[self updatePatSuffix:nil serverId:101 forSendPatWrap:wrap];}
    return YES;
}
- (BOOL)checkAndShowRevokeGuideForSendPat:(TestSendPatWrap *)wrap{(void)wrap;self.guides++;[trace addObject:@"guide"];return YES;}
- (void)updatePatSuffix:(id)suffix serverId:(long long)serverID forSendPatWrap:(TestSendPatWrap *)wrap{
    (void)suffix;(void)serverID;(void)wrap;self.updates++;[trace addObject:@"native-success"];
}
- (void)revokeSendPat:(TestSendPatWrap *)wrap{
    CHECK(NSThread.isMainThread);CHECK(accountLock);self.revokes++;self.lastRevoke=wrap;
    if(self.throwsRevoke)[NSException raise:@"NativeRevoke" format:@"after submission"];
}
- (unsigned int)patSendLongPressRevokeInterval{return self.interval;}
- (unsigned int)addPatWrap:(id)pat toChat:(id)chat newXMLMessageWrap:(id)xml index:(unsigned long long *)index{
    self.adds++;self.lastPat=pat;self.lastChat=chat;self.lastXML=xml;
    if(self.throwsAdd)[NSException raise:@"NativeAddPat" format:@"must propagate"];
    if(index)*index=91;return self.nextLocalID;
}
@end
@interface CMessageWrap : NSObject
@property long long m_n64MesSvrID;
@property unsigned int m_uiMesLocalID,m_uiCreateTime,m_uiStatus,m_uiMessageType,m_uiAppMsgInnerType;
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsRealChatUsr,*m_nsAtUserList;
@property(nonatomic,strong) id quoteSource;
@property(nonatomic,strong) id patMessageWrap;
@property long long constructedType;
@property NSUInteger builds,sourceUpdates;
@property BOOL referenceable;
- (instancetype)initWithMsgType:(long long)type;
- (BOOL)msgCanBeRefered;
- (void)updateForReferMsg:(id)source replyContent:(NSString *)content;
- (void)UpdateMsgSource;
@end
@implementation CMessageWrap
- (instancetype)initWithMsgType:(long long)type{if((self=[super init])){_constructedType=type;_m_uiMessageType=(unsigned int)type;_referenceable=YES;}return self;}
- (BOOL)msgCanBeRefered{return self.referenceable;}
- (void)updateForReferMsg:(id)source replyContent:(NSString *)content{self.quoteSource=source;self.m_nsContent=[@"native-escaped:" stringByAppendingString:content];self.builds++;}
- (void)UpdateMsgSource{self.sourceUpdates++;}
@end
@interface WrongXMLMessageType : NSObject
@property unsigned long long m_uiMessageType;
@end
@implementation WrongXMLMessageType @end
@interface CMessageMgr : NSObject
@property NSUInteger adds,asyncs,syncs,notAddDBs,batches;
@property BOOL throwsAdd,throwsAsync,throwsSync,throwsNotAddDB,throwsBatch;
@property BOOL throwsRevokeLookup;
@property long long revokedServer;
@property NSUInteger revokeLookups;
@property(nonatomic,strong) id lastSession,lastWrap,lastUsers;
@property(nonatomic,copy) void (^duringAdd)(id session,id wrap);
- (void)AddMsg:(id)session MsgWrap:(id)wrap;
- (void)AsyncOnAddMsg:(id)session MsgWrap:(id)wrap;
- (void)onNewSyncAddMessage:(id)wrap;
- (void)onNewSyncNotAddDBMessage:(id)wrap;
- (void)AsyncOnAddMsgListForSession:(id)sessions NotifyUsrName:(id)users;
- (void)AsyncOnAddMsgForSession:(id)session MsgWrap:(id)wrap;
- (id)GetRevokeMsgBySvrId:(long long)server;
@end
@implementation CMessageMgr
- (id)GetRevokeMsgBySvrId:(long long)server{
    self.revokeLookups++;if(self.throwsRevokeLookup)[NSException raise:@"RevokeLookup" format:@"unavailable"];
    return server==self.revokedServer?self:nil;
}
- (void)AddMsg:(id)session MsgWrap:(id)wrap{
    self.adds++;self.lastSession=session;self.lastWrap=wrap;[trace addObject:@"add"];
    if(self.throwsAdd)[NSException raise:@"NativeAdd" format:@"must propagate"];
    if([wrap isKindOfClass:CMessageWrap.class])((CMessageWrap *)wrap).m_uiMesLocalID=17;
    if(self.duringAdd)self.duringAdd(session,wrap);
}
- (void)AsyncOnAddMsg:(id)session MsgWrap:(id)wrap{
    self.asyncs++;self.lastSession=session;self.lastWrap=wrap;[trace addObject:@"async"];
    if(self.throwsAsync)[NSException raise:@"NativeAsync" format:@"must propagate"];
}
- (void)onNewSyncAddMessage:(id)wrap{
    self.syncs++;self.lastWrap=wrap;[trace addObject:@"sync"];
    // Native m_bNew=NO still notifies onNewSyncAddMessage but returns before
    // AsyncOnAddMsg. Reproduce that confirmed branch at the native boundary.
    if(self.throwsSync)[NSException raise:@"NativeSync" format:@"must propagate"];
}
- (void)onNewSyncNotAddDBMessage:(id)wrap{
    self.notAddDBs++;self.lastWrap=wrap;[trace addObject:@"not-add-db"];
    // This callback is independent of Add/AsyncOnAdd and the generated49/62
    // callback. Its original can complete without producing either model.
    if(self.throwsNotAddDB)[NSException raise:@"NativeNotAddDB" format:@"must propagate"];
}
- (void)AsyncOnAddMsgListForSession:(id)sessions NotifyUsrName:(id)users{
    self.batches++;self.lastSession=sessions;self.lastUsers=users;[trace addObject:@"batch"];
    if(self.throwsBatch)[NSException raise:@"NativeBatch" format:@"must propagate"];
}
- (void)AsyncOnAddMsgForSession:(id)session MsgWrap:(id)wrap{
    [self AsyncOnAddMsgListForSession:@{session:wrap} NotifyUsrName:@[]];
}
@end
@interface TestEnvironment : NSObject <CSMessageActionEnvironment>
@property(nonatomic,copy) NSString *account;
@property(nonatomic,strong) TestSendPatMgr *pat;
@property(nonatomic,strong) CMessageMgr *message;
@end
@implementation TestEnvironment
- (NSString *)currentAccountID{CHECK(NSThread.isMainThread);return self.account;}
- (id)serviceNamed:(NSString *)name{CHECK(NSThread.isMainThread);return [name isEqual:@"SendPatMgr"]?self.pat:[name isEqual:@"CMessageMgr"]?self.message:nil;}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
static void Drain(void){
    __block BOOL done=NO;dispatch_async(dispatch_get_main_queue(),^{done=YES;});
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:3];
    while(!done && deadline.timeIntervalSinceNow>0)[NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.002]];
    CHECK(done);
}
static void OffMain(void (^operation)(void)){
    dispatch_semaphore_t signal=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{operation();dispatch_semaphore_signal(signal);});
    CHECK(!dispatch_semaphore_wait(signal,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC)));
}
static TestEnvironment *Environment(void){
    TestEnvironment *environment=[TestEnvironment new];environment.account=@"me";environment.pat=[NSClassFromString(@"SendPatMgr") new];environment.message=[CMessageMgr new];
    environment.pat.accepts=YES;environment.pat.interval=133;environment.pat.nextLocalID=8;return environment;
}
static CMessageWrap *Source(NSString *from,NSString *to){CMessageWrap *wrap=[[CMessageWrap alloc]initWithMsgType:1];wrap.m_nsFromUsr=from;wrap.m_nsToUsr=to;wrap.m_nsContent=@"source";wrap.m_n64MesSvrID=22;return wrap;}
static void TestPatSending(void){
    TestEnvironment *env=Environment();CSAutomationNativeAdapter *adapter=[[CSAutomationNativeAdapter alloc]initWithEnvironment:env];
    __block NSUInteger completions=0;__block BOOL result=NO;
    env.pat.syncSuccess=YES;
    id first=[adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}];
    CHECK(first && first==env.pat.lastSend);CHECK([first scene]==1);CHECK([[first fromUserName]isEqual:@"me"]);
    CHECK([[first pattedUserName]isEqual:@"alice"] && [[first chatUserName]isEqual:@"alice"]);CHECK(env.pat.guides==0);
    CSAutomationObservePatResult(first,^(BOOL success){CHECK(NSThread.isMainThread);completions++;result=success;});
    CHECK(completions==0);Drain();CHECK(completions==1 && result);
    [env.pat updatePatSuffix:nil serverId:101 forSendPatWrap:first];Drain();CHECK(completions==1);
    CHECK([adapter revokeWindow]==133);
    TestSendPatWrap *manual=[TestSendPatWrap new];CHECK([env.pat checkAndShowRevokeGuideForSendPat:manual]);CHECK(env.pat.guides==1);
    __weak TestSendPatMgr *weakPat=env.pat;
    env.pat.duringSend=^(TestSendPatWrap *wrap){CHECK(wrap!=manual);CHECK([weakPat checkAndShowRevokeGuideForSendPat:manual]);};
    id second=[adapter sendPatTo:@"bob" conversation:@"room@chatroom" account:@"me" valid:^{return YES;}];
    env.pat.duringSend=nil;CHECK(second && second!=first && [second scene]==2);CHECK(env.pat.guides==2);
    CHECK([adapter revokePat:first conversation:@"alice" account:@"me" valid:^{return YES;}]);CHECK(env.pat.lastRevoke==first);
    CSAutomationCancelPatObservation(first);CHECK([adapter revokePat:first conversation:@"alice" account:@"me" valid:^{return YES;}]);
    env.pat.throwsRevoke=YES;NSUInteger revokes=env.pat.revokes;
    CHECK(![adapter revokePat:first conversation:@"alice" account:@"me" valid:^{return YES;}]);CHECK(!accountLock && env.pat.revokes==revokes+1);env.pat.throwsRevoke=NO;
    CHECK(![adapter revokePat:manual conversation:@"alice" account:@"me" valid:^{return YES;}]);
    CHECK(![adapter revokePat:first conversation:@"bob" account:@"me" valid:^{return YES;}]);
    CHECK(![adapter revokePat:first conversation:@"alice" account:@"other" valid:^{return YES;}]);
    CHECK(![adapter revokePat:first conversation:@"alice" account:@"me" valid:^{return NO;}]);
    ((TestSendPatWrap *)first).patWrap.canRevoke=NO;CHECK(![adapter revokePat:first conversation:@"alice" account:@"me" valid:^{return YES;}]);
    ((TestSendPatWrap *)first).patWrap.canRevoke=YES;((TestSendPatWrap *)first).patWrap.serverId=-1;
    CHECK(![adapter revokePat:first conversation:@"alice" account:@"me" valid:^{return YES;}]);((TestSendPatWrap *)first).patWrap.serverId=101;
    NSUInteger sends=env.pat.sends;
    CHECK(![adapter sendPatTo:@"alice" conversation:@"bob" account:@"me" valid:^{return YES;}] && env.pat.sends==sends);
    CHECK(![adapter sendPatTo:@"me" conversation:@"room@chatroom" account:@"me" valid:^{return YES;}]);
    CHECK(![adapter sendPatTo:@"x@chatroom" conversation:@"room@chatroom" account:@"me" valid:^{return YES;}]);
    CHECK(![adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return NO;}] && env.pat.sends==sends);
    __block NSUInteger validation=0;
    CHECK(![adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^BOOL{return ++validation==1;}]);CHECK(env.pat.sends==sends);
    env.account=@"other";CHECK(![adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}]);
    CHECK(![adapter revokePat:first conversation:@"alice" account:@"me" valid:^{return YES;}]);env.account=@"me";
    suspended=YES;CHECK(![adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}]);suspended=NO;
    epoch++;CHECK(![adapter revokePat:first conversation:@"alice" account:@"me" valid:^{return YES;}] );
    env.pat.accepts=NO;CHECK(![adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}]);CHECK(env.pat.sends==sends+1);
    env.pat.accepts=YES;env.pat.throwsSend=YES;CHECK(![adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}]);CHECK(!accountLock);
    env.pat.throwsSend=NO;id afterThrow=[adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}];CHECK(afterThrow);
    CHECK([env.pat checkAndShowRevokeGuideForSendPat:manual]);
    __block id background=nil;OffMain(^{background=[adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}];});CHECK(!background);
}
static void TestPatObservation(void){
    TestEnvironment *env=Environment();CSAutomationNativeAdapter *adapter=[[CSAutomationNativeAdapter alloc]initWithEnvironment:env];
    id wrap=[adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}];CHECK(wrap);
    __block NSUInteger calls=0;__block BOOL result=NO;CSAutomationObservePatResult(wrap,^(BOOL success){calls++;result=success;});
    [env.pat updatePatSuffix:nil serverId:0 forSendPatWrap:wrap];Drain();CHECK(!calls);
    [env.pat updatePatSuffix:nil serverId:5 forSendPatWrap:wrap];Drain();CHECK(!calls);
    ((TestSendPatWrap *)wrap).patWrap.serverId=5;
    id other=[TestSendPatWrap new];[env.pat updatePatSuffix:nil serverId:5 forSendPatWrap:other];Drain();CHECK(!calls);
    OffMain(^{[env.pat updatePatSuffix:nil serverId:5 forSendPatWrap:wrap];});Drain();CHECK(calls==1 && result);
    id failed=[adapter sendPatTo:@"bob" conversation:@"bob" account:@"me" valid:^{return YES;}];
    SendPatCgi *cgi=[SendPatCgi new];cgi.sendPatWrap=failed;
    __block NSUInteger failures=0;CSAutomationObservePatResult(failed,^(BOOL success){CHECK(!success);failures++;});
    OffMain(^{[cgi didFailWithError:@"error" response:nil];});Drain();CHECK(failures==1 && cgi.failures==1);
    ((TestSendPatWrap *)failed).patWrap.serverId=11;[env.pat updatePatSuffix:nil serverId:11 forSendPatWrap:failed];Drain();CHECK(failures==1);
    CHECK(![adapter revokePat:failed conversation:@"bob" account:@"me" valid:^{return YES;}]);
    id cancelled=[adapter sendPatTo:@"c" conversation:@"c" account:@"me" valid:^{return YES;}];
    __block NSUInteger cancelledCalls=0;CSAutomationObservePatResult(cancelled,^(BOOL success){(void)success;cancelledCalls++;});
    CSAutomationCancelPatObservation(cancelled);((TestSendPatWrap *)cancelled).patWrap.serverId=10;
    [env.pat updatePatSuffix:nil serverId:10 forSendPatWrap:cancelled];Drain();CHECK(cancelledCalls==0);
    id stale=[adapter sendPatTo:@"d" conversation:@"d" account:@"me" valid:^{return YES;}];
    __block NSUInteger staleCalls=0;CSAutomationObservePatResult(stale,^(BOOL success){CHECK(!success);staleCalls++;});
    ((TestSendPatWrap *)stale).patWrap.serverId=9;[env.pat updatePatSuffix:nil serverId:9 forSendPatWrap:stale];epoch++;Drain();CHECK(staleCalls==1);
}
static void TestPatUnavailableAccount(void){
    TestEnvironment *env=Environment();CSAutomationNativeAdapter *adapter=[[CSAutomationNativeAdapter alloc]initWithEnvironment:env];
    id locked=[adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}];CHECK(locked);
    __block NSUInteger calls=0;CSAutomationObservePatResult(locked,^(BOOL success){CHECK(success);calls++;});
    env.account=nil;((TestSendPatWrap *)locked).patWrap.serverId=71;
    [env.pat updatePatSuffix:nil serverId:71 forSendPatWrap:locked];Drain();CHECK(calls==1);
    // Recording a confirmed result does not authorize a locked-account send.
    NSUInteger sends=env.pat.sends;
    CHECK(![adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}]);CHECK(env.pat.sends==sends);
    CHECK(![adapter revokePat:locked conversation:@"alice" account:@"me" valid:^{return YES;}]);CHECK(!env.pat.revokes);
    env.account=@"me";CHECK([adapter revokePat:locked conversation:@"alice" account:@"me" valid:^{return YES;}]);
    CHECK(env.pat.revokes==1 && env.pat.lastRevoke==locked);
    [env.pat updatePatSuffix:nil serverId:71 forSendPatWrap:locked];Drain();CHECK(calls==1);
    id deliveryLocked=[adapter sendPatTo:@"bob" conversation:@"bob" account:@"me" valid:^{return YES;}];CHECK(deliveryLocked);
    __block NSUInteger deliveryCalls=0;CSAutomationObservePatResult(deliveryLocked,^(BOOL success){CHECK(success);deliveryCalls++;});
    ((TestSendPatWrap *)deliveryLocked).patWrap.serverId=72;
    [env.pat updatePatSuffix:nil serverId:72 forSendPatWrap:deliveryLocked];env.account=nil;Drain();CHECK(deliveryCalls==1);
    env.account=@"me";CHECK([adapter revokePat:deliveryLocked conversation:@"bob" account:@"me" valid:^{return YES;}]);CHECK(env.pat.lastRevoke==deliveryLocked);
    id wrong=[adapter sendPatTo:@"c" conversation:@"c" account:@"me" valid:^{return YES;}];CHECK(wrong);
    __block NSUInteger wrongCalls=0;CSAutomationObservePatResult(wrong,^(BOOL success){(void)success;wrongCalls++;});
    ((TestSendPatWrap *)wrong).patWrap.serverId=73;env.account=@"other";
    [env.pat updatePatSuffix:nil serverId:73 forSendPatWrap:wrong];Drain();CHECK(!wrongCalls);
    CHECK(![adapter revokePat:wrong conversation:@"c" account:@"me" valid:^{return YES;}]);
    env.account=@"me";CSAutomationCancelPatObservation(wrong);
    printf("Automation native protected-data account gap: success retained; send/revoke paused; exact revoke after recovery\n");
}
static void TestQuotes(void){
    TestEnvironment *env=Environment();CSMessageSendAdapter *adapter=[[CSMessageSendAdapter alloc]initWithEnvironment:env];
    CMessageWrap *source=Source(@"alice",@"me");
    CSMessagePreparedSend *route=[adapter prepareAutomationQuote:@"<& quote" source:source targetID:@"alice" accountID:@"me"];
    CMessageWrap *out=route.outputWrap;CHECK(route && env.message.adds==0);CHECK(out!=source && out.constructedType==49 && out.m_uiAppMsgInnerType==57);
    CHECK(out.quoteSource==source && out.builds==1 && out.sourceUpdates==1);CHECK([out.m_nsContent isEqual:@"native-escaped:<& quote"]);
    CHECK([out.m_nsFromUsr isEqual:@"me"] && [out.m_nsToUsr isEqual:@"alice"]);CHECK(!out.m_n64MesSvrID && !out.m_uiMesLocalID);
    CHECK(source.m_n64MesSvrID==22 && [source.m_nsContent isEqual:@"source"]);CHECK(CSAutomationIsOwnedSend(out));
    [route submit];CHECK(env.message.adds==1 && env.message.lastWrap==out && route.nativeHandoffReturned);
    [route submit];CHECK(env.message.adds==1);
    CHECK(![adapter prepareAutomationQuote:@"x" source:source targetID:@"bob" accountID:@"me"]);
    source.m_n64MesSvrID=-1;CHECK(![adapter prepareAutomationQuote:@"x" source:source targetID:@"alice" accountID:@"me"]);source.m_n64MesSvrID=22;
    source.referenceable=NO;CHECK(![adapter prepareAutomationQuote:@"x" source:source targetID:@"alice" accountID:@"me"]);source.referenceable=YES;
    CMessageWrap *group=Source(@"room@chatroom",@"me");
    CHECK(![adapter prepareAutomationQuote:@"x" source:group targetID:@"room@chatroom" accountID:@"me"]);
    group.m_nsRealChatUsr=@"alice";CHECK([adapter prepareAutomationQuote:@"x" source:group targetID:@"room@chatroom" accountID:@"me"]);
    CMessageWrap *own=Source(@"me",@"room@chatroom");CHECK([adapter prepareAutomationQuote:@"x" source:own targetID:@"room@chatroom" accountID:@"me"]);
    env.account=@"other";CHECK(![adapter prepareAutomationQuote:@"x" source:source targetID:@"alice" accountID:@"me"]);env.account=@"me";
    CHECK(CSAutomationIsOwnedSend([adapter prepareScheduledText:@"task" targetID:@"alice" accountID:@"me"].outputWrap));
    CSMessagePreparedSend *mention=[adapter prepareGroupText:@"hello" mentions:@[@"alice"] targetID:@"room@chatroom" accountID:@"me"];
    CHECK(CSAutomationIsOwnedSend(mention.outputWrap));CHECK([[(CMessageWrap *)mention.outputWrap m_nsAtUserList]isEqual:@"alice"]);
    Drain();
}
static void TestIngress(void){
    // Bootstrap installs thin hooks before manager/backup readiness, without
    // requiring start, a foreground container, or a keepalive switch.
    CHECK(!CSAutomationManager.sharedManager.ready);CSAutomationTestBootstrapIngress();NSUInteger installed=hooks;CHECK(installed>=8);
    CSAutomationTestInstallIngressHooks();CHECK(hooks==installed);TestEnvironment *env=Environment();CMessageWrap *wrap=Source(@"alice",@"me");
    messageEvents=patEvents=ownedRemembers=0;receivedSession=nil;[trace removeAllObjects];
    [env.message AsyncOnAddMsg:@"alice" MsgWrap:wrap];CHECK(!messageEvents && env.message.asyncs==1);Drain();
    CHECK(messageEvents==1 && receivedSession==env.message.lastSession && receivedWrap==wrap);CHECK([trace[0]isEqual:@"async"]);
    receivedSession=nil;wrap.m_nsFromUsr=@"me";wrap.m_nsToUsr=@"alice";CSAutomationMarkOwnedSend(wrap);[trace removeAllObjects];
    [env.message AddMsg:@"alice" MsgWrap:wrap];CHECK(ownedRemembers==1 && wrap.m_uiMesLocalID==17);Drain();CHECK(ownedRemembers==1);
    CHECK(([trace isEqual:@[@"add",@"remember",@"message"]]));
    NSUInteger before=messageEvents;[env.message AsyncOnAddMsg:@"alice" MsgWrap:wrap];epoch++;Drain();CHECK(messageEvents==before);
    OffMain(^{[env.message AsyncOnAddMsg:@"alice" MsgWrap:wrap];});Drain();CHECK(messageEvents==before+1);
    env.message.throwsAsync=YES;BOOL threw=NO;@try{[env.message AsyncOnAddMsg:@"alice" MsgWrap:wrap];}@catch(NSException *exception){threw=[exception.name isEqual:@"NativeAsync"];}
    CHECK(threw);Drain();CHECK(messageEvents==before+1);
    env.message.throwsAsync=NO;before=messageEvents;[trace removeAllObjects];NSUInteger asyncs=env.message.asyncs,adds=env.message.adds;
    [env.message onNewSyncAddMessage:wrap];CHECK(env.message.syncs==1 && messageEvents==before);Drain();
    CHECK(messageEvents==before+1 && receivedWrap==wrap && [receivedSession isEqual:@""]);
    CHECK(env.message.asyncs==asyncs && env.message.adds==adds);CHECK(([trace isEqual:@[@"sync",@"message"]]));
    before=messageEvents;[trace removeAllObjects];id users=@[@"alice"];NSDictionary *sessions=@{@"alice":wrap,@"invalid":@"not-a-wrap"};
    [env.message AsyncOnAddMsgListForSession:sessions NotifyUsrName:users];CHECK(env.message.lastSession==sessions && env.message.lastUsers==users && messageEvents==before);Drain();
    CHECK(messageEvents==before+1 && receivedWrap==wrap && [receivedSession isEqual:@"alice"]);
    CHECK(env.message.asyncs==asyncs && env.message.adds==adds);CHECK(([trace isEqual:@[@"batch",@"message"]]));
    before=messageEvents;[env.message AsyncOnAddMsgForSession:@"alice" MsgWrap:wrap];Drain();CHECK(messageEvents==before+1);
    CHECK(env.message.asyncs==asyncs && env.message.adds==adds);
    before=messageEvents;OffMain(^{[env.message onNewSyncAddMessage:wrap];});Drain();CHECK(messageEvents==before+1 && receivedWrap==wrap);
    before=messageEvents;OffMain(^{[env.message AsyncOnAddMsgListForSession:@{@"alice":wrap} NotifyUsrName:nil];});Drain();CHECK(messageEvents==before+1);
    before=messageEvents;[env.message onNewSyncAddMessage:wrap];[env.message AsyncOnAddMsgListForSession:@{@"alice":wrap} NotifyUsrName:nil];epoch++;Drain();CHECK(messageEvents==before);
    suspended=YES;[env.message onNewSyncAddMessage:wrap];[env.message AsyncOnAddMsgListForSession:@{@"alice":wrap} NotifyUsrName:nil];Drain();CHECK(messageEvents==before);suspended=NO;
    env.message.throwsSync=YES;threw=NO;@try{[env.message onNewSyncAddMessage:wrap];}@catch(NSException *exception){threw=[exception.name isEqual:@"NativeSync"];}
    CHECK(threw);Drain();CHECK(messageEvents==before);env.message.throwsSync=NO;
    env.message.throwsBatch=YES;threw=NO;@try{[env.message AsyncOnAddMsgListForSession:@{@"alice":wrap} NotifyUsrName:nil];}@catch(NSException *exception){threw=[exception.name isEqual:@"NativeBatch"];}
    CHECK(threw);Drain();CHECK(messageEvents==before);env.message.throwsBatch=NO;
    // All overlapping callbacks preserve the same wrap/IDs for the manager's
    // durable ledger. Exactly-once submission is exercised by Manager A–E.
    [env.message onNewSyncAddMessage:wrap];[env.message AsyncOnAddMsgListForSession:@{@"alice":wrap} NotifyUsrName:nil];[env.message AsyncOnAddMsg:@"alice" MsgWrap:wrap];Drain();
    CHECK(messageEvents==before+3 && receivedWrap==wrap);
    printf("Automation native sync ingress: per-wrap m_bNew=NO and session batch bypass old callbacks; originals preserved before admission\n");
    PatWrap *pat=[PatWrap new];pat.serverId=123;unsigned long long index=0;
    unsigned int localID=[env.pat addPatWrap:pat toChat:@"room@chatroom" newXMLMessageWrap:wrap index:&index];
    CHECK(localID==8 && index==91 && env.pat.lastPat==pat && env.pat.lastXML==wrap);CHECK(!patEvents);Drain();CHECK(patEvents==1 && receivedPat==pat);
    [env.pat addPatWrap:pat toChat:@"room@chatroom" newXMLMessageWrap:nil index:NULL];Drain();CHECK(patEvents==1);
    pat.serverId=0;[env.pat addPatWrap:pat toChat:@"room@chatroom" newXMLMessageWrap:wrap index:NULL];Drain();CHECK(patEvents==1);
    pat.serverId=-2;[env.pat addPatWrap:pat toChat:@"room@chatroom" newXMLMessageWrap:wrap index:NULL];Drain();CHECK(patEvents==1);pat.serverId=123;
    env.pat.nextLocalID=0;[env.pat addPatWrap:pat toChat:@"room@chatroom" newXMLMessageWrap:wrap index:NULL];Drain();CHECK(patEvents==1);env.pat.nextLocalID=8;
    [env.pat addPatWrap:pat toChat:@"room@chatroom" newXMLMessageWrap:wrap index:NULL];epoch++;Drain();CHECK(patEvents==1);
    env.pat.throwsAdd=YES;threw=NO;@try{[env.pat addPatWrap:pat toChat:@"room@chatroom" newXMLMessageWrap:wrap index:NULL];}@catch(NSException *exception){threw=[exception.name isEqual:@"NativeAddPat"];}
    CHECK(threw);Drain();CHECK(patEvents==1);
}
static void TestColdOwnedIngress(void){
    TestEnvironment *env=Environment();CMessageWrap *outgoing=Source(@"me",@"alice"),*rebuilt=Source(@"me",@"alice");
    CSAutomationMarkOwnedSend(outgoing);CHECK(!CSAutomationIsOwnedSend(rebuilt));
    managerAccount=@"";receivedSession=nil;rememberedAccount=nil;rememberedLocalID=0;mustBeRememberedBeforeWrap=rebuilt;
    __weak CMessageMgr *message=env.message;
    env.message.duringAdd=^(id session,id wrap){
        CHECK(wrap==outgoing);rebuilt.m_uiMesLocalID=outgoing.m_uiMesLocalID;
        [message AsyncOnAddMsg:session MsgWrap:rebuilt];
    };
    NSUInteger remembered=ownedRemembers;[trace removeAllObjects];[env.message AddMsg:@"alice" MsgWrap:outgoing];
    CHECK(ownedRemembers==remembered+1 && [rememberedAccount isEqual:@"me"] && rememberedLocalID==17);
    CHECK(([trace isEqual:@[@"add",@"async",@"remember"]]));Drain();
    CHECK(([trace isEqual:@[@"add",@"async",@"remember",@"message",@"message"]]));
    CHECK(ownedRemembers==remembered+1);mustBeRememberedBeforeWrap=nil;env.message.duringAdd=nil;
    // An unavailable source or a known conflicting account must not report a
    // successful registration under an empty or incorrect account namespace.
    managerAccount=@"other";receivedSession=nil;[env.message AddMsg:@"alice" MsgWrap:outgoing];Drain();CHECK(ownedRemembers==remembered+1);
    managerAccount=@"";outgoing.m_nsFromUsr=@"";[env.message AddMsg:@"alice" MsgWrap:outgoing];Drain();CHECK(ownedRemembers==remembered+1);
    managerAccount=@"me";
    printf("Automation native cold-owned ingress: native sender fallback registered exact IDs before rebuilt queued consumer\n");
}
static void TestCompoundPatIngress(void){
    TestEnvironment *env=Environment();CMessageWrap *wrap=Source(@"room@chatroom",@"me");
    wrap.m_uiMessageType=49;wrap.m_uiAppMsgInnerType=62;wrap.m_n64MesSvrID=999;
    TestPatMessageWrap *compound=[TestPatMessageWrap new];compound.chatUserName=@"room@chatroom";
    PatWrap *first=[PatWrap new],*second=[PatWrap new];
    first.fromUserName=second.fromUserName=@"alice";first.pattedUserName=second.pattedUserName=@"me";
    first.serverId=701;second.serverId=702;first.createTime=1794384000123ULL;second.createTime=first.createTime+1;
    compound.patWraps=@[first,second];wrap.patMessageWrap=compound;
    NSUInteger before=patEvents,oldMessages=messageEvents,oldAdds=env.pat.adds;
    [receivedPats removeAllObjects];[trace removeAllObjects];
    OffMain(^{[env.message onNewSyncAddMessage:wrap];});CHECK(patEvents==before);Drain();
    CHECK(env.message.syncs==1 && env.pat.adds==oldAdds && messageEvents==oldMessages+1);
    CHECK(patEvents==before+2 && receivedPats[0]==first && receivedPats[1]==second);
    CHECK(first.serverId==701 && second.serverId==702 && first.createTime==1794384000123ULL);
    CHECK(([trace isEqual:@[@"sync",@"message",@"pat",@"pat"]]));
    // The outer merged message ID is never used as a pat identity. Overlapping
    // native callbacks intentionally retain 701/702 for the manager's ledger.
    [env.message AsyncOnAddMsgListForSession:@{@"room@chatroom":wrap} NotifyUsrName:nil];Drain();
    [env.pat addPatWrap:first toChat:@"room@chatroom" newXMLMessageWrap:wrap index:NULL];Drain();
    CHECK(patEvents==before+5 && receivedPats[2]==first && receivedPats[3]==second && receivedPats[4]==first);
    before=patEvents;
    compound.chatUserName=@"unrelated@chatroom";[env.message onNewSyncAddMessage:wrap];Drain();CHECK(patEvents==before);
    compound.chatUserName=@"room@chatroom";
    [env.message AsyncOnAddMsgListForSession:@{@"wrong@chatroom":wrap} NotifyUsrName:nil];Drain();CHECK(patEvents==before);
    wrap.m_nsToUsr=@"";[env.message onNewSyncAddMessage:wrap];Drain();CHECK(patEvents==before);wrap.m_nsToUsr=@"me";
    wrap.m_nsFromUsr=@"other";[env.message onNewSyncAddMessage:wrap];Drain();CHECK(patEvents==before);wrap.m_nsFromUsr=@"room@chatroom";
    wrap.m_uiMessageType=1;[env.message onNewSyncAddMessage:wrap];Drain();CHECK(patEvents==before);wrap.m_uiMessageType=49;
    wrap.m_uiAppMsgInnerType=57;[env.message onNewSyncAddMessage:wrap];Drain();CHECK(patEvents==before);wrap.m_uiAppMsgInnerType=62;
    compound.patWraps=@{@"not":@"an array"};[env.message onNewSyncAddMessage:wrap];Drain();CHECK(patEvents==before);
    WrongPatTime *wrong=[WrongPatTime new];wrong.serverId=703;wrong.createTime=123;
    first.serverId=0;second.createTime=0;compound.patWraps=@[first,second,wrong,@"not a pat"];
    [env.message onNewSyncAddMessage:wrap];Drain();CHECK(patEvents==before);
    first.serverId=701;second.createTime=1794384000124ULL;compound.patWraps=@[first,second];
    [env.message onNewSyncAddMessage:wrap];epoch++;Drain();CHECK(patEvents==before);
    suspended=YES;[env.message onNewSyncAddMessage:wrap];Drain();CHECK(patEvents==before);suspended=NO;
    env.message.throwsSync=YES;BOOL threw=NO;
    @try{[env.message onNewSyncAddMessage:wrap];}@catch(NSException *exception){threw=[exception.name isEqual:@"NativeSync"];}
    CHECK(threw);Drain();CHECK(patEvents==before);
    printf("Automation native compound pat ingress: sync/batch bypass XML insertion; each native server ID, millisecond timestamp, conversation and ABI retained\n");
}
static void TestRawXMLPatIngress(void){
    TestEnvironment *env=Environment();CMessageWrap *raw=Source(@"room@chatroom",@"me");
    raw.m_uiMessageType=10002;raw.m_uiCreateTime=1794384000;raw.m_n64MesSvrID=801;raw.m_uiMesLocalID=0;
    raw.m_nsContent=@"<sysmsg type=\"pat\"><pat><fromusername>alice</fromusername><chatusername>room@chatroom</chatusername><pattedusername>me</pattedusername><template>pat</template></pat></sysmsg>";
    id snapshot=[NSObject new];xmlParserResult=@{@"pat":snapshot,@"conversation":@"room@chatroom"};
    NSUInteger before=patEvents,messages=messageEvents,calls=xmlParserCalls;
    [trace removeAllObjects];[receivedPats removeAllObjects];
    OffMain(^{[env.message onNewSyncNotAddDBMessage:raw];});
    CHECK(env.message.notAddDBs==1 && env.message.lastWrap==raw && patEvents==before && xmlParserCalls==calls);
    CHECK(!env.message.adds && !env.message.asyncs && !env.message.syncs && !env.pat.adds && raw.patMessageWrap==nil);
    Drain();CHECK(messageEvents==messages+1 && patEvents==before+1 && receivedPat==snapshot);
    CHECK(xmlParserCalls==calls+1 && xmlParserWrap==raw && [xmlParserSession isEqual:@""]);
    CHECK(raw.m_uiMesLocalID==0 && raw.m_n64MesSvrID==801 && raw.m_uiCreateTime==1794384000);
    CHECK(([trace isEqual:@[@"not-add-db",@"message",@"xml-parser",@"pat"]]));
    // Existing message callbacks can overlap the new route. They carry the
    // same raw wrapper/session into the real parser and manager ledger.
    [env.message onNewSyncAddMessage:raw];[env.message AsyncOnAddMsg:@"room@chatroom" MsgWrap:raw];Drain();
    CHECK(patEvents==before+3 && receivedPats[0]==snapshot && receivedPats[1]==snapshot && receivedPats[2]==snapshot);
    CHECK(xmlParserWrap==raw && [xmlParserSession isEqual:@"room@chatroom"]);
    before=patEvents;calls=xmlParserCalls;xmlParserResult=nil;
    [env.message onNewSyncNotAddDBMessage:raw];Drain();CHECK(patEvents==before && xmlParserCalls==calls+1);
    xmlParserResult=@{@"pat":snapshot,@"conversation":@"room@chatroom"};calls=xmlParserCalls;
    raw.m_uiMessageType=1;[env.message onNewSyncNotAddDBMessage:raw];Drain();CHECK(patEvents==before && xmlParserCalls==calls);raw.m_uiMessageType=10002;
    WrongXMLMessageType *wrong=[WrongXMLMessageType new];wrong.m_uiMessageType=10002;
    [env.message onNewSyncNotAddDBMessage:wrong];[env.message onNewSyncNotAddDBMessage:nil];Drain();CHECK(patEvents==before && xmlParserCalls==calls);
    [env.message onNewSyncNotAddDBMessage:raw];epoch++;Drain();CHECK(patEvents==before && xmlParserCalls==calls);
    suspended=YES;[env.message onNewSyncNotAddDBMessage:raw];Drain();CHECK(patEvents==before && xmlParserCalls==calls);suspended=NO;
    messages=messageEvents;env.message.throwsNotAddDB=YES;BOOL threw=NO;
    @try{[env.message onNewSyncNotAddDBMessage:raw];}@catch(NSException *exception){threw=[exception.name isEqual:@"NativeNotAddDB"];}
    CHECK(threw);Drain();CHECK(messageEvents==messages && patEvents==before && xmlParserCalls==calls);env.message.throwsNotAddDB=NO;
    xmlParserThrows=YES;[env.message onNewSyncNotAddDBMessage:raw];Drain();CHECK(patEvents==before && xmlParserCalls==calls+1);xmlParserThrows=NO;
    calls=xmlParserCalls;env.message.revokedServer=raw.m_n64MesSvrID;
    NSUInteger lookups=env.message.revokeLookups;
    [env.message onNewSyncNotAddDBMessage:raw];CHECK(env.message.revokeLookups==lookups+1);Drain();CHECK(patEvents==before && xmlParserCalls==calls);
    [env.message onNewSyncAddMessage:raw];[env.message AsyncOnAddMsg:@"room@chatroom" MsgWrap:raw];Drain();CHECK(patEvents==before && xmlParserCalls==calls);
    // A missing/temporarily unavailable optional lookup must not turn into a
    // new global readiness gate for raw pat reception.
    env.message.throwsRevokeLookup=YES;[env.message onNewSyncNotAddDBMessage:raw];Drain();CHECK(patEvents==before+1 && xmlParserCalls==calls+1);env.message.throwsRevokeLookup=NO;
    xmlParserResult=nil;xmlParserWrap=xmlParserSession=nil;
    printf("Automation native raw XML ingress seam: separate NotAddDB original precedes main-queue parser; raw identity, zero localID, ABI, epoch and exception boundaries preserved\n");
}
static void ChangeABI(Class cls,NSString *selector,const char *encoding){Method method=class_getInstanceMethod(cls,NSSelectorFromString(selector));CHECK(method);CHECK(class_addMethod(cls,NSSelectorFromString(selector),method_getImplementation(method),encoding));}
int main(int argc,const char **argv){@autoreleasepool{
    trace=[NSMutableArray array];receivedPats=[NSMutableArray array];
    Class patService=objc_allocateClassPair(TestSendPatMgr.class,"SendPatMgr",0);CHECK(patService);objc_registerClassPair(patService);
    Class patSend=objc_allocateClassPair(TestSendPatWrap.class,"SendPatWrap",0);CHECK(patSend);objc_registerClassPair(patSend);
    if(argc>1){
        NSString *mode=@(argv[1]);
        if([mode isEqual:@"guide-I"])ChangeABI(patService,@"checkAndShowRevokeGuideForSendPat:","I24@0:8@16");
        else if([mode isEqual:@"result-Q"])ChangeABI(patService,@"updatePatSuffix:serverId:forSendPatWrap:","v40@0:8@16Q24@32");
        else if([mode isEqual:@"send-I"])ChangeABI(patService,@"sendPat:","I24@0:8@16");
        else if([mode isEqual:@"scene-I"])ChangeABI(patSend,@"setScene:","v20@0:8I16");
        else CHECK(NO);
        TestEnvironment *env=Environment();CSAutomationNativeAdapter *adapter=[[CSAutomationNativeAdapter alloc]initWithEnvironment:env];
        CHECK(![adapter sendPatTo:@"alice" conversation:@"alice" account:@"me" valid:^{return YES;}]);CHECK(!env.pat.sends);
        printf("Automation native ABI %s: %lu checks passed\n",argv[1],(unsigned long)checks);return 0;
    }
    CSAutomationInstallNativeHooks();CHECK(hooks==3);CSAutomationInstallNativeHooks();CHECK(hooks==3);
    TestPatSending();TestPatObservation();TestPatUnavailableAccount();TestQuotes();TestIngress();TestColdOwnedIngress();TestCompoundPatIngress();TestRawXMLPatIngress();CHECK(hooks==9);
    printf("Automation native: %lu checks passed\n",(unsigned long)checks);return 0;
}}
