#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import <substrate.h>
#import "BackgroundRunFakeRuntime.h"
#import "CSBackgroundRunManager.h"
#import "CSBackupBootstrap.h"
#import "CSAuthorizationManager.h"
#import "CSChatNativeBridge.h"
#import "CSCloseFriendBridge.h"
#import "CSGroupChatManager.h"
#import "CSGroupChatLocalNotice.h"
#import "CSGroupChatNativeAdapter.h"
#import "CSGroupChatRuntime.h"
#import "CSGroupChatStore.h"
#import "CSGroupNativeBridge.h"
#import "CSMessageNativeActionAdapter.h"
#import "CSScheduledTaskManager.h"

static NSString *const Room=@"90001@chatroom", *const Owner=@"wxid_self";
static NSArray *serverMembers,*cachedMembers;
static unsigned serverVersion,checks,hookCount,systemEvents,removalEvents;
static NSUInteger epoch=42;
static BOOL suspended;
static BOOL blockGroupTextPreparation;
static NSUInteger blockedGroupPreparations;
static BOOL dropNextBackgroundRoster;
static NSUInteger droppedRosters;
static NSMutableArray<NSDictionary *> *outbound,*local,*requests;
static NSURL *fixtureRoot;
static CSTestBackgroundRuntime *runtime;
static CSBackgroundRunManager *backgroundManager;
static NSUserDefaults *defaults;
static NSString *defaultsSuite;

static void Check(BOOL value,NSString *reason) {
    checks++;
    if(!value){fprintf(stderr,"FAIL: %s\n",reason.UTF8String);exit(1);}
}
static void Wait(NSTimeInterval timeout,BOOL (^done)(void),NSString *reason) {
    NSTimeInterval deadline=NSProcessInfo.processInfo.systemUptime+timeout;
    while(!done() && NSProcessInfo.processInfo.systemUptime<deadline)
        [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.01]];
    Check(done(),reason);
}
static void Pump(void) {
    NSTimeInterval end=NSProcessInfo.processInfo.systemUptime+.05;
    while(NSProcessInfo.processInfo.systemUptime<end)
        [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.005]];
}
static UIApplicationState AppState(void){return UIApplication.sharedApplication.applicationState;}

NSNotificationName const UIApplicationSignificantTimeChangeNotification=@"FixtureSignificantTimeChange";
NSString *const CSCloseFriendPolicyDidChangeNotification=@"FixtureCloseFriendPolicyDidChange";
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface){return NO;}
BOOL CSBackupIsReady(void){return YES;}
BOOL CSBackupAccountIsSuspended(void){return suspended;}
NSUInteger CSBackupAccountEpoch(void){return epoch;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger value,void (^handoff)(void)){
    if(value!=epoch || suspended)return NO;handoff();return YES;
}
NSString *CSGroupCurrentAccountID(void){return Owner;}
NSString *CSMessageCurrentAccount(void){return Owner;}
id CSGroupReadObject(id object,NSString *key){return CSMessageActionNativeObject(object,key);}
CSGroupRowCategory CSGroupCategoryForContact(id contact){return CSGroupRowCategoryPrivate;}
NSURL *CSAuditUnredirectedGroupChatFileURL(NSURL *root,NSString *owner);
NSURL *CSGroupChatFileURL(NSURL *root,NSString *owner){return CSAuditUnredirectedGroupChatFileURL(fixtureRoot,owner);}
void CSGroupChatInstallNoticeHooks(void){}  // The UI link hooks are outside this fixture.

@implementation UIViewController @end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static id manager;if(!manager)manager=[self new];return manager;}
- (BOOL)isAuthorized{return YES;}
@end
@implementation CSGroupChatQuitCoordinator
+ (instancetype)sharedCoordinator{static id coordinator;if(!coordinator)coordinator=[self new];return coordinator;}
- (BOOL)isQuittingRoom:(NSString *)roomID{return NO;}
@end

// Same ABI and original-method replacement used by Tests/GroupChatRuntimeTests.m.
void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original){
    Method method=class_getInstanceMethod(cls,selector);
    *original=method_getImplementation(method);
    class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));
    hookCount++;
}

@interface AuditBaseResponse : NSObject
@property(nonatomic) int ret;
@end
@implementation AuditBaseResponse @end
@interface AuditMemberRow : NSObject
@property(nonatomic,copy) NSString *memberName;
@end
@implementation AuditMemberRow @end
@interface AuditPayload : NSObject
@property(nonatomic,copy) NSString *chatroomUserName,*chatRoomName;
@property(nonatomic,strong) AuditBaseResponse *baseResponse;
@property(nonatomic) unsigned int allMemberCount,serverVersion,memberCount;
@property(nonatomic,copy) NSArray *allMemberUserNameList,*memberList;
@end
@implementation AuditPayload @end
@interface AuditEnvelope : NSObject
@property(nonatomic,strong) AuditPayload *m_pbRequest,*m_pbResponse;
@end
@implementation AuditEnvelope @end
@interface AuditRoomData : NSObject
@property(nonatomic) unsigned int chatRoomVersion;
@end
@implementation AuditRoomData @end

@interface CContact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName,*m_nsNickName;
@property(nonatomic,strong) AuditRoomData *m_ChatRoomData;
@end
@implementation CContact
+ (BOOL)IsChatRoomContact:(CContact *)contact{return [contact.m_nsUsrName isEqual:Room];}
- (BOOL)isChatRoomDismissed{return NO;}
- (BOOL)isChatRoomBlocked{return NO;}
@end
static CContact *roomContact;

@interface CContactMgr : NSObject
- (CContact *)getSelfContact;
- (CContact *)getContactByName:(NSString *)name;
- (void)callOnModifyExt:(id)contact;
@end
@implementation CContactMgr
- (CContact *)getSelfContact{return [self getContactByName:Owner];}
- (CContact *)getContactByName:(NSString *)name{
    if([name isEqual:Room])return roomContact;
    CContact *contact=[CContact new];contact.m_nsUsrName=name;
    contact.m_nsNickName=@{@"wxid_old":@"Old",@"wxid_new":@"New"}[name]?:name;return contact;
}
- (void)callOnModifyExt:(id)contact{}
@end

// Fields mirror the recording CMessageWrap in Tests/ScheduledTaskManagerTests.m.
// Only AddMsg/MsgWrap and AddLocalMsg are replaced; preparation, submit,
// native ABI checks and invocation remain the production implementations.
@interface CMessageWrap : NSObject
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsClientMsgID,*m_nsAtUserList,*m_nsPattern;
@property(nonatomic) unsigned int m_uiMessageType,m_uiCreateTime,m_uiStatus,m_uiMesLocalID;
@property(nonatomic) long long m_n64MesSvrID;
- (instancetype)initWithMsgType:(long long)type;
@end
@implementation CMessageWrap
@synthesize m_nsContent=_m_nsContent;
- (instancetype)initWithMsgType:(long long)type{
    if((self=[super init]))self.m_uiMessageType=(unsigned int)type;
    return self;
}
- (void)setM_nsContent:(NSString *)text{
    if(blockGroupTextPreparation && self.m_uiMessageType==1 && [self.m_nsToUsr isEqual:Room]){
        blockedGroupPreparations++;
        [NSException raise:@"AuditTemporarilyUnavailable" format:@"Native text-wrap preparation unavailable"];
    }
    _m_nsContent=[text copy];
}
@end
@interface CMessageMgr : NSObject
- (void)AddMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap;
- (void)AddLocalMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap fixTime:(BOOL)fix NewMsgArriveNotify:(BOOL)notify Unique:(BOOL)unique;
- (void)AsyncOnAddMsg:(NSString *)room MsgWrap:(CMessageWrap *)wrap;
@end
@implementation CMessageMgr
- (void)AddMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap{
    Check(NSThread.isMainThread && wrap.m_uiMessageType==1 && [wrap.m_nsFromUsr isEqual:Owner] &&
        [wrap.m_nsToUsr isEqual:target] && wrap.m_uiStatus==1 && !wrap.m_uiMesLocalID && !wrap.m_n64MesSvrID,
        @"the real adapter handed a new text wrap to native AddMsg:MsgWrap:");
    [outbound addObject:@{@"target":target,@"text":wrap.m_nsContent,@"mentions":wrap.m_nsAtUserList?:@"",@"state":@(AppState())}];
}
- (void)AddLocalMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap fixTime:(BOOL)fix NewMsgArriveNotify:(BOOL)notify Unique:(BOOL)unique{
    Check(NSThread.isMainThread && wrap.m_uiMessageType==10000 && [target isEqual:Room] && fix && !notify && unique,
        @"production local notice used the native insertion route with arrival notifications off");
    [local addObject:@{@"text":wrap.m_nsContent,@"state":@(AppState()),@"pattern":wrap.m_nsPattern}];
}
- (void)AsyncOnAddMsg:(NSString *)room MsgWrap:(CMessageWrap *)wrap{systemEvents++;}
@end

@interface CGroupMgr : NSObject
- (void)replyWithCurrentRoster;
- (void)OnGetChatRoomMemberDetail:(AuditEnvelope *)envelope;
- (void)OnDeleteChatRoomMemberResponse:(AuditEnvelope *)envelope;
- (void)onModifyContact:(CContact *)contact;
@end
@implementation CGroupMgr
- (NSArray *)GetGroupMemberUserListByContact:(CContact *)contact{return cachedMembers;}
- (BOOL)IsUsrInChatRoom:(NSString *)room Usr:(NSString *)user{return [room isEqual:Room] && [cachedMembers containsObject:user];}
- (BOOL)GetEntireChatRoomMemberDetail:(CContact *)contact{
    Check(contact==roomContact,@"production native adapter requested the selected room");
    [requests addObject:@{@"state":@(AppState()),@"version":@(serverVersion)}];
    if(dropNextBackgroundRoster && AppState()==UIApplicationStateBackground && serverVersion==2){
        dropNextBackgroundRoster=NO;droppedRosters++;
        return YES; // Native accepted; no response reached the process.
    }
    [self replyWithCurrentRoster];
    return YES;
}
- (void)replyWithCurrentRoster{
    AuditEnvelope *envelope=[AuditEnvelope new];envelope.m_pbRequest=[AuditPayload new];envelope.m_pbResponse=[AuditPayload new];
    envelope.m_pbRequest.chatroomUserName=Room;envelope.m_pbResponse.chatroomUserName=Room;
    envelope.m_pbResponse.baseResponse=[AuditBaseResponse new];
    envelope.m_pbResponse.allMemberUserNameList=serverMembers;
    envelope.m_pbResponse.allMemberCount=(unsigned int)serverMembers.count;
    envelope.m_pbResponse.serverVersion=serverVersion;
    [self OnGetChatRoomMemberDetail:envelope];
}
- (void)OnGetChatRoomMemberDetail:(AuditEnvelope *)envelope{
    cachedMembers=envelope.m_pbResponse.allMemberUserNameList;
    roomContact.m_ChatRoomData.chatRoomVersion=envelope.m_pbResponse.serverVersion;
    [self onModifyContact:roomContact];
}
- (void)OnDeleteChatRoomMemberResponse:(AuditEnvelope *)envelope{removalEvents++;}
- (void)onModifyContact:(CContact *)contact{}
@end

@interface MMContext : NSObject
@end
@implementation MMContext
+ (instancetype)currentContext{static id context;if(!context)context=[self new];return context;}
- (id)getService:(Class)service{return [service new];}
@end
@interface CSBackgroundRunManager (Audit)
+ (instancetype)auditSharedManager;
@end
@implementation CSBackgroundRunManager (Audit)
+ (instancetype)auditSharedManager{return backgroundManager;}
@end
@interface CSScheduledTaskManager (Audit)
- (NSURL *)fileURLForAccount:(NSString *)account;
@end
@interface AuditScheduledManager : CSScheduledTaskManager
@end
@implementation AuditScheduledManager
- (NSURL *)fileURLForAccount:(NSString *)account{return CSScheduledTaskFileURL(fixtureRoot,account);}
@end

static void Background(void){
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];
}
static BOOL RetryArmed(void){return [CSGroupChatManager.sharedManager valueForKey:@"backgroundRetryTimer"]!=nil;}
static void Foreground(void){
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
    Check(!RetryArmed(),@"leaving background cancels the group's retry source before DidBecomeActive");
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
}
static void ServerChanges(void){serverMembers=@[Owner,@"wxid_new"];serverVersion=2;}
static void EmitChanges(void){
    ServerChanges();
    CMessageWrap *system=[[CMessageWrap alloc] initWithMsgType:10000];
    system.m_n64MesSvrID=7;system.m_nsFromUsr=Room;system.m_nsToUsr=Owner;
    [[CMessageMgr new] AsyncOnAddMsg:Room MsgWrap:system];
    AuditMemberRow *old=[AuditMemberRow new];old.memberName=@"wxid_old";
    AuditEnvelope *removed=[AuditEnvelope new];removed.m_pbRequest=[AuditPayload new];removed.m_pbResponse=[AuditPayload new];
    removed.m_pbRequest.chatRoomName=Room;removed.m_pbResponse.baseResponse=[AuditBaseResponse new];
    for(AuditPayload *payload in @[removed.m_pbRequest,removed.m_pbResponse]){payload.memberCount=1;payload.memberList=@[old];}
    [[CGroupMgr new] OnDeleteChatRoomMemberResponse:removed];
}
static NSNumber *Version(void){return [CSGroupChatManager.sharedManager valueForKey:@"baselines"][Room][@"version"];}
static NSArray<NSDictionary *> *GroupSends(void){
    return [outbound filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"target == %@",Room]];
}
static void CheckMessages(UIApplicationState welcomeState,UIApplicationState departureState,BOOL confirmed) {
    NSArray *sent=GroupSends();
    Check(sent.count==2 && local.count==1,@"one welcome, one same-room departure and one local departure");
    NSDictionary *welcome=nil,*departure=nil;
    for(NSDictionary *item in sent){
        if([item[@"mentions"] length])welcome=item;else departure=item;
    }
    Check([welcome[@"state"] isEqual:@(welcomeState)] && [departure[@"state"] isEqual:@(departureState)],
        @"native handoffs recorded the expected welcome and departure application states");
    NSString *reason=confirmed?@"被移出":@"离群（原因未确认）";
    Check([welcome[@"mentions"] isEqual:@"wxid_new"] && [welcome[@"text"] isEqual:@"欢迎@New\u2005（wxid_new）"],@"welcome has native @ metadata and the expected plain WeChat ID");
    Check([departure[@"text"] isEqual:[@"群通知 wxid_old " stringByAppendingString:reason]],@"same-room departure preserved identity and reason evidence");
    Check([local.firstObject[@"text"] containsString:[@"wxid_old " stringByAppendingString:reason]] &&
        [local.firstObject[@"state"] isEqual:@(departureState)],@"local template independently rendered the matching departure");
    printf("  native AddMsg: welcome with at-list in %s, departure in %s (%s); local AddLocalMsg=1\n",
        welcomeState==UIApplicationStateBackground?"Background":"Active",
        departureState==UIApplicationStateBackground?"Background":"Active",reason.UTF8String);
}
static void Setup(BOOL enabled,NSUInteger welcomeDelay){
    requests=[NSMutableArray array];outbound=[NSMutableArray array];local=[NSMutableArray array];
    cachedMembers=serverMembers=@[Owner,@"wxid_old"];serverVersion=1;
    roomContact=[CContact new];roomContact.m_nsUsrName=Room;roomContact.m_nsNickName=@"Fixture room";
    roomContact.m_ChatRoomData=[AuditRoomData new];roomContact.m_ChatRoomData.chatRoomVersion=1;
    NSMutableDictionary *config=[CSGroupChatDefaultConfiguration() mutableCopy];
    [config addEntriesFromDictionary:@{@"welcomeEnabled":@YES,@"welcomeRooms":@[Room],@"welcomeTemplate":@"欢迎@昵称（@微信ID）",@"welcomeDelay":@(welcomeDelay),
        @"monitorEnabled":@YES,@"monitorRooms":@[Room],@"departureTemplate":@"本地 @昵称 @微信ID @离群类型",
        @"departureSendToRoom":@YES,@"departureRoomTemplate":@"群通知 @微信ID @离群类型"}];
    NSError *error=nil;
    Check(CSGroupChatWriteState(@{@"schema":@1,@"account":Owner,@"configuration":config},CSGroupChatFileURL(fixtureRoot,Owner),Owner,&error),
        error.localizedDescription?:@"write actual group config inside fixture temp directory");
    defaultsSuite=[@"wechat.247.fixture." stringByAppendingString:NSUUID.UUID.UUIDString];
    defaults=[[NSUserDefaults alloc] initWithSuiteName:defaultsSuite];
    [defaults setBool:enabled forKey:CSBackgroundRunEnabledKey];
    runtime=[CSTestBackgroundRuntime new];runtime.backgroundTimeRemaining=7;
    backgroundManager=[[CSBackgroundRunManager alloc] initWithDefaults:defaults audio:[CSBackgroundRunAudio new]
        supportsBackgroundAudio:YES runtime:runtime];
    method_exchangeImplementations(class_getClassMethod(CSBackgroundRunManager.class,@selector(sharedManager)),
        class_getClassMethod(CSBackgroundRunManager.class,@selector(auditSharedManager)));
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    #include "GroupChatHookUnderTest.h"
    Check(hookCount==5,@"production constructor installed all five native ingress hooks");
    Wait(4,^BOOL{return [Version() isEqual:@1];},@"production runtime published foreground baseline v1");
    Check(backgroundManager.enabled==enabled,@"actual BackgroundRunEnabled value loaded by production background manager");
    Check(!GroupSends().count && !local.count,@"baseline only: no artificial join or leave");
    Check(!RetryArmed(),@"no group retry source in foreground");
}
static void NoPluginResources(void){
    Check(!backgroundManager.canAttemptBackgroundWork && !backgroundManager.canAttemptGroupChatBackgroundWork &&
        !runtime.beginAttempts && !runtime.liveTaskCount && !runtime.pendingCheckCount &&
        !CSTestPlayerCreates && !CSTestPlayerStarts && !backgroundManager.backgroundAudioActive,
        @"switch off: no plugin lease attempt or background audio player");
}
static AuditScheduledManager *Schedule(void){
    AuditScheduledManager *manager=[AuditScheduledManager new];[manager start];
    Wait(2,^BOOL{return manager.store.ready;},@"initialize actual scheduled-task store in fixture temp directory");
    [manager setEnabled:YES account:Owner completion:^(BOOL ok,NSError *error){Check(ok,error.localizedDescription?:@"enable scheduled comparison");}];
    Wait(2,^BOOL{return !manager.savingConfiguration && manager.store.enabled;},@"schedule setting committed");
    __block BOOL saved=NO;
    [manager saveTask:@{@"id":@"comparison",@"title":@"comparison",@"text":@"scheduled comparison",@"target":@"filehelper",
        @"enabled":@YES,@"catchUp":@NO,@"mode":@"once",@"anchor":[NSDate.date dateByAddingTimeInterval:2],@"zone":@"UTC"}
        account:Owner completion:^(BOOL ok,NSError *error){Check(ok,error.localizedDescription?:@"save future scheduled comparison");saved=YES;}];
    Wait(2,^BOOL{return saved && [manager valueForKey:@"timer"]!=nil;},@"production scheduled manager armed the actual main-queue timer");
    return manager;
}
static void ScenarioA(void){
    Setup(NO,0);
    AuditScheduledManager *scheduled=Schedule();
    Background();
    Check(RetryArmed(),@"unfinished member refresh uses the background dispatch source during cooldown");
    blockGroupTextPreparation=YES;
    dropNextBackgroundRoster=YES;
    EmitChanges();
    Check(systemEvents==1 && removalEvents==1,@"recording WeChat native events invoked the installed hooks");
    NoPluginResources();
    Wait(12,^BOOL{return droppedRosters==1;},@"first background roster request was accepted without a reply");
    Check(RetryArmed() && [Version() isEqual:@1] && !GroupSends().count,
        @"missing authoritative roster remains pending; no roster means no group send");
    Wait(12,^BOOL{return [Version() isEqual:@2] && blockedGroupPreparations>=2;},
        @"bounded retry delivered v2 while native text preparation was temporarily unavailable");
    NSArray *changedRequests=[requests filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"version == 2 AND state == %@",@(UIApplicationStateBackground)]];
    Check(changedRequests.count==2,@"accepted but unanswered roster had exactly one background retry");
    printf("  authoritative roster: first request accepted without response, one background retry produced v2\n");
    Check(RetryArmed() && !GroupSends().count && local.count==1,
        @"safe pre-handoff failures leave work for the tick; local insertion is already consumed");
    blockGroupTextPreparation=NO;
    Wait(12,^BOOL{return GroupSends().count==2 && [scheduled.store.history.firstObject[@"result"] isEqual:@"submitted"];},
        @"same live background visit submits both group sends and a real scheduled timer send");
    Check([Version() isEqual:@2],@"real native hook published changed authoritative roster v2");
    CheckMessages(UIApplicationStateBackground,UIApplicationStateBackground,YES);
    Check(!RetryArmed(),@"drained group work immediately stops the retry source");
    NSDictionary *comparison=[outbound filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"target == 'filehelper'"]].firstObject;
    Check([comparison[@"state"] isEqual:@(UIApplicationStateBackground)] && [comparison[@"text"] isEqual:@"scheduled comparison"],
        @"same background state and switch-off setting at scheduled native handoff");
    NoPluginResources();
    printf("  scheduled actual timer -> native AddMsg state=Background, persisted history=submitted, plugin leases/audio=0\n");
    Foreground();
    Wait(5,^BOOL{return [Version() isEqual:@2];},@"return to active verifies the same processed version v2");
    Pump();CheckMessages(UIApplicationStateBackground,UIApplicationStateBackground,YES);
}
static void ScenarioB(void){
    Setup(NO,2);
    Background();
    EmitChanges();
    [[CGroupMgr new] replyWithCurrentRoster];
    Wait(1,^BOOL{return GroupSends().count==1 && [Version() isEqual:@2] && [[CSGroupChatManager.sharedManager valueForKey:@"pendingWelcomes"] count]==1;},
        @"native v2 consumes departure once and leaves a delayed welcome when immediately returning");
    Check(RetryArmed(),@"unfinished welcome owns a background tick before returning");
    Foreground();
    Wait(6,^BOOL{return GroupSends().count==2 && [Version() isEqual:@2];},@"foreground restores the sole unfinished welcome without replaying departure");
    [[CGroupMgr new] replyWithCurrentRoster];Pump();
    CheckMessages(UIApplicationStateActive,UIApplicationStateBackground,YES);
    NoPluginResources();
}
static void ScenarioBQueued(void){
    Setup(NO,0);
    Background();
    EmitChanges();
    // Return synchronously, with the real native hook's main-queue callbacks
    // still queued. Foreground gets v2 from the authoritative member request.
    Foreground();
    Wait(6,^BOOL{return GroupSends().count==2 && [Version() isEqual:@2];},@"foreground verification wins immediate-return race");
    CheckMessages(UIApplicationStateActive,UIApplicationStateActive,NO);
    [[CGroupMgr new] GetEntireChatRoomMemberDetail:roomContact];Pump();
    CheckMessages(UIApplicationStateActive,UIApplicationStateActive,NO);
    NoPluginResources();
}
static void ScenarioC(void){
    Setup(YES,0);
    Background();
    Check(runtime.beginAttempts==1 && runtime.liveTaskCount==1 && backgroundManager.canAttemptGroupChatBackgroundWork,
        @"switch on: selected room requested the shared lease");
    Check(CSTestPlayerStarts==1 && backgroundManager.backgroundAudioActive,@"under the simulated low budget the plugin also started background audio");
    EmitChanges();
    Wait(16,^BOOL{return GroupSends().count==2;},@"same native group submission with plugin keepalive on");
    CheckMessages(UIApplicationStateBackground,UIApplicationStateBackground,YES);
    Foreground();
    Check(!runtime.liveTaskCount && !backgroundManager.backgroundAudioActive,@"foreground released plugin lease and audio");
    printf("  plugin lease attempts=1, audio starts=1; both released at foreground\n");
}
static void ScenarioD(void){
    Setup(NO,0);
    Background();
    Pump(); // deliver lifecycle work only, before simulated suspension
    NSUInteger prior=requests.count;
    // External roster changes while the app is frozen. Do not call the
    // process's native ingress methods or pump its main queue in this period.
    ServerChanges();
    Check(!GroupSends().count && !local.count && !systemEvents && !removalEvents,@"no realtime process callbacks during simulated suspension");
    Foreground();
    Wait(6,^BOOL{return GroupSends().count==2 && [Version() isEqual:@2];},@"foreground full roster catches up the suspended net change");
    Check(requests.count>prior && [requests.lastObject[@"state"] isEqual:@(UIApplicationStateActive)],
        @"v2 requested while active, not attributed to a realtime background event");
    CheckMessages(UIApplicationStateActive,UIApplicationStateActive,NO);
    NoPluginResources();
}
int main(int argc,char **argv){@autoreleasepool{
    if(argc!=3)return 2;
    fixtureRoot=[NSURL fileURLWithPath:@(argv[2]) isDirectory:YES];
    NSString *scenario=@(argv[1]);
    printf("Scenario %s\n",argv[1]);fflush(stdout);
    if([scenario isEqual:@"A"])ScenarioA();
    else if([scenario isEqual:@"B"])ScenarioB();
    else if([scenario isEqual:@"B-queued"])ScenarioBQueued();
    else if([scenario isEqual:@"C"])ScenarioC();
    else if([scenario isEqual:@"D"])ScenarioD();
    else return 2;
    [defaults removePersistentDomainForName:defaultsSuite];
    printf("PASS %s: %u assertions\n",argv[1],checks);
    return 0;
}}
