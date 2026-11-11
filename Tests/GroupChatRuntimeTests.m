#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSMessageNativeActionAdapter.h"
#import "CSGroupChatEventPolicy.h"

static unsigned checks,failures;
#define CHECK(value) do { checks++; if (!(value)) { failures++; fprintf(stderr,"FAIL %d: %s\n",__LINE__,#value); } } while(0)
static NSUInteger fixtureEpoch=42;
static BOOL fixtureReady=YES,fixtureSuspended,changeIngressDuringNames,changeVersionDuringNames,changeIdentitiesDuringNames;
BOOL CSBackupIsReady(void){return fixtureReady;}
BOOL CSBackupAccountIsSuspended(void){return fixtureSuspended;}
NSUInteger CSBackupAccountEpoch(void){return fixtureEpoch;}
void CSGroupChatSetRuntimeEnabled(BOOL enabled);
static unsigned hookRegistrations;
static void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original){
    Method method=class_getInstanceMethod(cls,selector);if(original)*original=method_getImplementation(method);
    class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));hookRegistrations++;
}

@interface RuntimeString : NSObject
@property(nonatomic,copy) NSString *string;
@end
@implementation RuntimeString
@end
@interface RuntimeBaseResponse : NSObject
@property(nonatomic) int ret;
@end
@implementation RuntimeBaseResponse
@end
@interface RuntimeRequest : NSObject
@property(nonatomic,copy) NSString *chatroomUserName;
@end
@implementation RuntimeRequest
@end
@interface RuntimeResponse : NSObject
@property(nonatomic,copy) NSString *chatroomUserName;
@property(nonatomic,strong) RuntimeBaseResponse *baseResponse;
@property(nonatomic) unsigned int allMemberCount,serverVersion;
@property(nonatomic,copy) NSArray *allMemberUserNameList;
@end
@implementation RuntimeResponse
@end
@interface RuntimeWrapper : NSObject
@property(nonatomic,strong) RuntimeRequest *m_pbRequest;
@property(nonatomic,strong) RuntimeResponse *m_pbResponse;
@end
@implementation RuntimeWrapper
@end
@interface RuntimeRoomData : NSObject
@property(nonatomic) unsigned int chatRoomVersion;
@property(nonatomic,copy) NSDictionary *times;
@end
@implementation RuntimeRoomData
- (BOOL)hasJoinInfoForUsername:(NSString *)name{return self.times[name]!=nil;}
- (unsigned int)getJoinTimeForUsername:(NSString *)name{return [self.times[name] unsignedIntValue];}
@end
@interface RuntimeContact : NSObject
@property(nonatomic,strong) RuntimeRoomData *m_ChatRoomData;
@property(nonatomic,copy) NSString *m_nsUsrName;
@end
@implementation RuntimeContact
@end
static RuntimeContact *fixtureContact;
static NSSet *fixtureIdentities;
static BOOL unavailable;
id CSGroupChatRoomContact(NSString *room){return [room isEqual:@"90001@chatroom"]?fixtureContact:nil;}
NSSet *CSGroupChatMemberIDs(NSString *room){(void)room;return fixtureIdentities;}
NSString *CSGroupChatRoomName(NSString *room){(void)room;return @"夹具群";}
NSString *CSGroupChatMemberName(NSString *room,NSString *member){
    (void)room;
    if(changeIngressDuringNames){changeIngressDuringNames=NO;CSGroupChatSetRuntimeEnabled(YES);}
    if(changeVersionDuringNames){changeVersionDuringNames=NO;fixtureContact.m_ChatRoomData.chatRoomVersion++;}
    if(changeIdentitiesDuringNames){changeIdentitiesDuringNames=NO;fixtureIdentities=[NSSet setWithObject:@"wxid_self"];}
    return [@"成员-" stringByAppendingString:member];
}
BOOL CSGroupChatRoomUnavailable(NSString *room){(void)room;return unavailable;}
@interface CSGroupChatManager : NSObject
@property(nonatomic,strong) NSMutableArray *received;
@property(nonatomic,strong) NSMutableArray *contactChanges;
@property(nonatomic,strong) NSMutableArray *systemHints;
+ (instancetype)sharedManager;
- (void)receiveMemberSnapshot:(NSDictionary *)snapshot epoch:(NSUInteger)epoch;
- (void)nativeContactChanged:(NSString *)room epoch:(NSUInteger)epoch;
- (void)nativeSystemMessageInRoom:(NSString *)room epoch:(NSUInteger)epoch;
- (void)nativeMemberRemovals:(NSArray<NSString *> *)members inRoom:(NSString *)room epoch:(NSUInteger)epoch;
@end
@implementation CSGroupChatManager
+ (instancetype)sharedManager{static CSGroupChatManager *manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];manager.received=[NSMutableArray array];manager.contactChanges=[NSMutableArray array];manager.systemHints=[NSMutableArray array];});return manager;}
- (void)receiveMemberSnapshot:(NSDictionary *)snapshot epoch:(NSUInteger)epoch{[self.received addObject:@{@"snapshot":snapshot,@"epoch":@(epoch)}];}
- (void)nativeContactChanged:(NSString *)room epoch:(NSUInteger)epoch{[self.contactChanges addObject:@{@"room":room,@"epoch":@(epoch)}];}
- (void)nativeSystemMessageInRoom:(NSString *)room epoch:(NSUInteger)epoch{[self.systemHints addObject:@{@"room":room,@"epoch":@(epoch)}];}
- (void)nativeMemberRemovals:(NSArray<NSString *> *)members inRoom:(NSString *)room epoch:(NSUInteger)epoch{(void)members;(void)room;(void)epoch;}
@end

@interface RuntimeMessageWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsToUsr;
- (NSString *)m_nsContent;
@end
static unsigned messageContentReads;
@implementation RuntimeMessageWrap
- (NSString *)m_nsContent{messageContentReads++;[NSException raise:@"UnexpectedContentRead" format:@"The runtime must not parse localized system text"];return nil;}
@end
@interface CMessageMgr : NSObject
- (void)AsyncOnAddMsg:(id)room MsgWrap:(id)wrap;
@end

@interface CContactMgr : NSObject
- (void)callOnModifyExt:(id)contact;
@end
@interface CGroupMgr : NSObject
- (void)OnGetChatRoomMemberDetail:(id)wrapper;
- (void)onModifyContact:(id)contact;
@end

// The script removes imports only. Capture, Publish and ingress are the complete
// production functions; native reads and publication are recording fixtures.
#include "CSGroupChatRuntime-under-test.inc"

static unsigned nativeResponses,nativeGroupContacts,nativeContactContacts,depthInsideResponse;
static BOOL throwDuringResponse;
static CContactMgr *fixtureContactManager;
static unsigned nativeSystemMessages;
static BOOL changeTokenInSystemOriginal,changeEpochInSystemOriginal,throwInSystemOriginal;
static id lastNativeSystemRoom,lastNativeSystemWrap;
@implementation CMessageMgr
- (void)AsyncOnAddMsg:(id)room MsgWrap:(id)wrap{
    nativeSystemMessages++;lastNativeSystemRoom=room;lastNativeSystemWrap=wrap;
    if(changeTokenInSystemOriginal)CSGroupChatSetRuntimeEnabled(YES);
    if(changeEpochInSystemOriginal)fixtureEpoch++;
    if(throwInSystemOriginal)[NSException raise:@"FixtureSystemMessageException" format:@"Injected native processing exception"];
}
@end
@implementation CContactMgr
- (void)callOnModifyExt:(id)contact{(void)contact;nativeContactContacts++;}
@end
@implementation CGroupMgr
- (void)OnGetChatRoomMemberDetail:(id)wrapper{
    (void)wrapper;nativeResponses++;depthInsideResponse=MemberResponseDepth;
    [self onModifyContact:fixtureContact];[fixtureContactManager callOnModifyExt:fixtureContact];
    if(throwDuringResponse)[NSException raise:@"FixtureResponseException" format:@"Injected after native contact callbacks"];
}
- (void)onModifyContact:(id)contact{(void)contact;nativeGroupContacts++;}
@end
static void Pump(void){
    NSDate *end=[NSDate.date dateByAddingTimeInterval:0.025];
    do{[NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate.date dateByAddingTimeInterval:0.001]];}while(end.timeIntervalSinceNow>0);
}

static RuntimeWrapper *GoodResponse(void){
    RuntimeWrapper *wrapper=[RuntimeWrapper new];wrapper.m_pbRequest=[RuntimeRequest new];wrapper.m_pbRequest.chatroomUserName=@"90001@chatroom";
    RuntimeResponse *response=[RuntimeResponse new];wrapper.m_pbResponse=response;response.chatroomUserName=wrapper.m_pbRequest.chatroomUserName;
    response.baseResponse=[RuntimeBaseResponse new];response.allMemberCount=2;response.serverVersion=10;response.allMemberUserNameList=@[@"wxid_self",@"wxid_one"];return wrapper;
}
static NSUInteger Published(void){return CSGroupChatManager.sharedManager.received.count;}
static void TestCapture(void){
    RuntimeWrapper *wrapper=GoodResponse();NSDictionary *packet=CaptureResponse(wrapper);CHECK(packet!=nil);
    CHECK([packet[@"roomID"] isEqual:@"90001@chatroom"]);CHECK([packet[@"version"] isEqual:@10]);CHECK([packet[@"observedAt"] isKindOfClass:NSDate.class]);
    CHECK([packet[@"members"] isEqual:(@[@"wxid_self",@"wxid_one"])]);
    // Native mutation after original processing must not alter the packet.
    NSMutableArray *mutable=[wrapper.m_pbResponse.allMemberUserNameList mutableCopy];wrapper.m_pbResponse.allMemberUserNameList=mutable;packet=CaptureResponse(wrapper);[mutable removeLastObject];CHECK([packet[@"members"] count]==2);
    wrapper=GoodResponse();RuntimeString *member=[RuntimeString new];member.string=@"wxid_one";wrapper.m_pbResponse.allMemberUserNameList=@[@"wxid_self",member];CHECK(CaptureResponse(wrapper)!=nil);
    wrapper.m_pbResponse.chatroomUserName=@"other@chatroom";CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbRequest.chatroomUserName=@"not_a_room";CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbResponse.allMemberCount=3;CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbResponse.allMemberCount=0;wrapper.m_pbResponse.allMemberUserNameList=@[];CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbResponse.allMemberCount=10001;CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbResponse.allMemberUserNameList=@[@"wxid_self",@"wxid_self"];CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbResponse.allMemberUserNameList=@[@"wxid_self",@"notify@all"];CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbResponse.allMemberUserNameList=@[@"wxid_self",@42];CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbResponse.baseResponse.ret=-1;CHECK(!CaptureResponse(wrapper));
    wrapper=GoodResponse();wrapper.m_pbResponse.baseResponse=nil;CHECK(!CaptureResponse(wrapper));
    CHECK(!CaptureResponse([NSObject new]));
}
static void TestPublish(void){
    fixtureContact=[RuntimeContact new];fixtureContact.m_ChatRoomData=[RuntimeRoomData new];fixtureContact.m_ChatRoomData.chatRoomVersion=10;
    fixtureContact.m_nsUsrName=@"90001@chatroom";
    fixtureContact.m_ChatRoomData.times=@{@"wxid_one":@1700000000};fixtureIdentities=[NSSet setWithArray:@[@"wxid_self",@"wxid_one"]];
    NSDictionary *packet=CaptureResponse(GoodResponse());CSGroupChatSetRuntimeEnabled(YES);unsigned long token=Token();
    CHECK(Active());CHECK((token&1UL)==1);Publish(packet,fixtureEpoch,token);CHECK(Published()==1);
    NSDictionary *snapshot=CSGroupChatManager.sharedManager.received.lastObject[@"snapshot"];
    CHECK([snapshot[@"roomName"] isEqual:@"夹具群"]);CHECK([snapshot[@"names"][@"wxid_one"] isEqual:@"成员-wxid_one"]);
    CHECK([snapshot[@"joinTimes"][@"wxid_one"] isEqual:@1700000000]);CHECK([snapshot[@"active"] boolValue]);CHECK(![snapshot[@"unavailable"] boolValue]);
    fixtureContact.m_ChatRoomData.chatRoomVersion=9;Publish(packet,fixtureEpoch,token);CHECK(Published()==1);
    fixtureContact.m_ChatRoomData.chatRoomVersion=11;Publish(packet,fixtureEpoch,token);CHECK(Published()==1);fixtureContact.m_ChatRoomData.chatRoomVersion=10;
    fixtureIdentities=[NSSet setWithArray:@[@"wxid_self",@"wxid_other"]];Publish(packet,fixtureEpoch,token);CHECK(Published()==1);
    fixtureIdentities=nil;Publish(packet,fixtureEpoch,token);CHECK(Published()==1);fixtureIdentities=[NSSet setWithArray:packet[@"members"]];
    Publish(packet,fixtureEpoch+1,token);CHECK(Published()==1);
    fixtureSuspended=YES;Publish(packet,fixtureEpoch,token);CHECK(!Active());CHECK(Published()==1);fixtureSuspended=NO;
    fixtureReady=NO;Publish(packet,fixtureEpoch,token);CHECK(Published()==1);fixtureReady=YES;
    // Foreground rebase changes the token even when ingress remains enabled.
    CSGroupChatSetRuntimeEnabled(YES);CHECK(Token()!=token);Publish(packet,fixtureEpoch,token);CHECK(Published()==1);token=Token();
    Publish(packet,fixtureEpoch,token);CHECK(Published()==2);
    // A config write disables ingress; completion enables a distinct session.
    CSGroupChatSetRuntimeEnabled(NO);CHECK(!Active());Publish(packet,fixtureEpoch,token);CHECK(Published()==2);
    CSGroupChatSetRuntimeEnabled(YES);Publish(packet,fixtureEpoch,token);CHECK(Published()==2);token=Token();
    changeIngressDuringNames=YES;Publish(packet,fixtureEpoch,token);CHECK(Published()==2);token=Token();
    changeVersionDuringNames=YES;Publish(packet,fixtureEpoch,token);CHECK(Published()==2);fixtureContact.m_ChatRoomData.chatRoomVersion=10;
    changeIdentitiesDuringNames=YES;Publish(packet,fixtureEpoch,token);CHECK(Published()==2);fixtureIdentities=[NSSet setWithArray:packet[@"members"]];
    unavailable=YES;Publish(packet,fixtureEpoch,token);CHECK(Published()==3);CHECK([CSGroupChatManager.sharedManager.received.lastObject[@"snapshot"][@"unavailable"] boolValue]);
}
static void TestHookResponseDepth(void){
    unavailable=NO;CSGroupChatSetRuntimeEnabled(YES);CSGroupChatInstallRuntimeHooks();CHECK(hookRegistrations==4);
    CGroupMgr *groups=[CGroupMgr new];fixtureContactManager=[CContactMgr new];
    NSUInteger priorPublished=Published();CSGroupChatManager *manager=CSGroupChatManager.sharedManager;
    [groups OnGetChatRoomMemberDetail:GoodResponse()];
    CHECK(nativeResponses==1);CHECK(depthInsideResponse==1);CHECK(MemberResponseDepth==0);
    CHECK(nativeGroupContacts==1);CHECK(nativeContactContacts==1);CHECK(manager.contactChanges.count==0);
    Pump();CHECK(Published()==priorPublished+1);CHECK(manager.contactChanges.count==0);
    // Ordinary external contact changes still dispatch after the native methods.
    [groups onModifyContact:fixtureContact];[fixtureContactManager callOnModifyExt:fixtureContact];
    CHECK(nativeGroupContacts==2);CHECK(nativeContactContacts==2);CHECK(manager.contactChanges.count==0);
    Pump();CHECK(manager.contactChanges.count==2);CHECK([manager.contactChanges.lastObject[@"room"] isEqual:@"90001@chatroom"]);
    CHECK([manager.contactChanges.lastObject[@"epoch"] unsignedIntegerValue]==fixtureEpoch);
    throwDuringResponse=YES;BOOL caught=NO;
    @try{[groups OnGetChatRoomMemberDetail:GoodResponse()];}@catch(NSException *exception){caught=[exception.name isEqual:@"FixtureResponseException"];}
    throwDuringResponse=NO;CHECK(caught);CHECK(nativeResponses==2);CHECK(depthInsideResponse==1);CHECK(MemberResponseDepth==0);
    CHECK(nativeGroupContacts==3);CHECK(nativeContactContacts==3);
    Pump();CHECK(Published()==priorPublished+1);CHECK(manager.contactChanges.count==2);
    [groups onModifyContact:fixtureContact];[fixtureContactManager callOnModifyExt:fixtureContact];Pump();
    CHECK(nativeGroupContacts==4);CHECK(nativeContactContacts==4);CHECK(manager.contactChanges.count==4);
    // Also exercise a real queued contact block crossing an ingress boundary.
    [groups onModifyContact:fixtureContact];CSGroupChatSetRuntimeEnabled(YES);Pump();
    CHECK(nativeGroupContacts==5);CHECK(manager.contactChanges.count==4);CHECK(MemberResponseDepth==0);
}
static RuntimeMessageWrap *SystemWrap(unsigned int type,long long serverID,NSString *from,NSString *to){
    RuntimeMessageWrap *wrap=[RuntimeMessageWrap new];wrap.m_uiMessageType=type;wrap.m_n64MesSvrID=serverID;wrap.m_nsFromUsr=from;wrap.m_nsToUsr=to;return wrap;
}
static void EmitSystem(CMessageMgr *messages,id room,id wrap,BOOL expected){
    NSUInteger beforeNative=nativeSystemMessages,beforeHints=CSGroupChatManager.sharedManager.systemHints.count;
    [messages AsyncOnAddMsg:room MsgWrap:wrap];CHECK(nativeSystemMessages==beforeNative+1);
    CHECK(lastNativeSystemRoom==room && lastNativeSystemWrap==wrap);
    CHECK(CSGroupChatManager.sharedManager.systemHints.count==beforeHints);
    Pump();CHECK(CSGroupChatManager.sharedManager.systemHints.count==beforeHints+(expected?1:0));CHECK(messageContentReads==0);
}
static void TestSystemMessageHook(void){
    CMessageMgr *messages=[CMessageMgr new];CSGroupChatSetRuntimeEnabled(YES);NSString *room=@"90001@chatroom";
    RuntimeMessageWrap *valid=SystemWrap(10000,123,room,@"wxid_self");EmitSystem(messages,room,valid,YES);
    NSDictionary *hint=CSGroupChatManager.sharedManager.systemHints.lastObject;CHECK([hint[@"room"] isEqual:room]);CHECK([hint[@"epoch"] unsignedIntegerValue]==fixtureEpoch);
    EmitSystem(messages,room,SystemWrap(10002,124,@"wxid_self",room),YES);
    EmitSystem(messages,room,SystemWrap(1,125,room,@"wxid_self"),NO);
    EmitSystem(messages,room,SystemWrap(10000,0,room,@"wxid_self"),NO);
    EmitSystem(messages,@"other@chatroom",valid,NO);
    EmitSystem(messages,@"friend",SystemWrap(10000,126,@"friend",@"wxid_self"),NO);
    EmitSystem(messages,@42,valid,NO);
    EmitSystem(messages,room,SystemWrap(10000,127,@"wxid_sender",@"wxid_self"),NO);
    EmitSystem(messages,room,nil,NO);
    fixtureSuspended=YES;EmitSystem(messages,room,valid,NO);fixtureSuspended=NO;
    fixtureReady=NO;EmitSystem(messages,room,valid,NO);fixtureReady=YES;
    CSGroupChatSetRuntimeEnabled(NO);EmitSystem(messages,room,valid,NO);CSGroupChatSetRuntimeEnabled(YES);
    MemberResponseDepth++;@try{EmitSystem(messages,room,valid,NO);}@finally{MemberResponseDepth--;}CHECK(MemberResponseDepth==0);
    changeTokenInSystemOriginal=YES;EmitSystem(messages,room,valid,NO);changeTokenInSystemOriginal=NO;
    changeEpochInSystemOriginal=YES;EmitSystem(messages,room,valid,NO);changeEpochInSystemOriginal=NO;
    NSUInteger beforeHints=CSGroupChatManager.sharedManager.systemHints.count,beforeNative=nativeSystemMessages;
    [messages AsyncOnAddMsg:room MsgWrap:valid];CSGroupChatSetRuntimeEnabled(YES);Pump();
    CHECK(nativeSystemMessages==beforeNative+1);CHECK(CSGroupChatManager.sharedManager.systemHints.count==beforeHints);
    [messages AsyncOnAddMsg:room MsgWrap:valid];fixtureEpoch++;Pump();
    CHECK(nativeSystemMessages==beforeNative+2);CHECK(CSGroupChatManager.sharedManager.systemHints.count==beforeHints);
    BOOL caught=NO;throwInSystemOriginal=YES;
    @try{[messages AsyncOnAddMsg:room MsgWrap:valid];}@catch(NSException *exception){caught=[exception.name isEqual:@"FixtureSystemMessageException"];}
    throwInSystemOriginal=NO;Pump();CHECK(caught);CHECK(nativeSystemMessages==beforeNative+3);CHECK(CSGroupChatManager.sharedManager.systemHints.count==beforeHints);
    EmitSystem(messages,room,valid,YES);CHECK(messageContentReads==0);
}
int main(void){@autoreleasepool{TestCapture();TestPublish();TestHookResponseDepth();TestSystemMessageHook();fprintf(stdout,"Group chat runtime: %u checks, %u failures (offline fixtures only)\n",checks,failures);return failures?1:0;}}
