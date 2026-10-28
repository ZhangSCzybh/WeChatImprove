#import <Foundation/Foundation.h>
#import "CSAIReplyManager.h"
#import "CSAIReplyCoordinator.h"
#import "CSAICredentialStore.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendAutomationProjection.h"
#import "CSGroupNativeBridge.h"
#import "CSAuthorizationManager.h"
#import "CSAIBackgroundSync.h"
#import "CSBackgroundRunManager.h"
#import "AINativeDispatchUnderTest.m"
#import "CSAIMessageAdapter.h"
#import "AIPreparedSendUnderTest.m"
#import "AIHooksUnderTest.m"
#import <sys/stat.h>
#import <unistd.h>
#import <errno.h>
static NSUInteger checks,epoch=7,submissions;
static NSString *account=@"alice";
static BOOL suspended,failKeyWrite,failDirectorySync,simulateSends;
static BOOL authorized=YES;
static CSCloseFriendSnapshot *privacy;
static NSUInteger failedDirectorySyncs,manualSends,ownedSends;
static NSString *lastSentTo;
static NSMutableArray<NSString *> *installedHooks;
static void (^duringManualSend)(void);
static BOOL backgroundAudioActive,backupReady=YES;
static id nativeSyncService;
static dispatch_block_t duringContactLookup;
@interface TestNativeSync : NSObject
@property BOOL busy,accepts,throwBusy,throwSync;
@property NSUInteger busyChecks,syncCalls;
@property(copy) dispatch_block_t afterBusyCheck,didSynchronize;
- (BOOL)isGettingData;
- (BOOL)BackGroundFetchToSync;
@end
@implementation TestNativeSync
- (BOOL)isGettingData{self.busyChecks++;if(self.afterBusyCheck)self.afterBusyCheck();if(self.throwBusy)[NSException raise:@"NativeBusyError" format:@"synthetic"];return self.busy;}
- (BOOL)BackGroundFetchToSync{self.syncCalls++;if(self.throwSync)[NSException raise:@"NativeSyncError" format:@"synthetic"];if(self.accepts && self.didSynchronize)self.didSynchronize();return self.accepts;}
@end
@interface TestWrongSyncReturn : NSObject
@property NSUInteger calls;
- (BOOL)isGettingData;
- (void)BackGroundFetchToSync;
@end
@implementation TestWrongSyncReturn
- (BOOL)isGettingData{self.calls++;return NO;}
- (void)BackGroundFetchToSync{self.calls++;}
@end
@interface TestWrongBusyReturn : NSObject
@property NSUInteger calls;
- (id)isGettingData;
- (BOOL)BackGroundFetchToSync;
@end
@implementation TestWrongBusyReturn
- (id)isGettingData{self.calls++;return @NO;}
- (BOOL)BackGroundFetchToSync{self.calls++;return YES;}
@end
@interface TestBoolNativeSync : NSObject
@property NSUInteger calls;
- (_Bool)isGettingData;
- (_Bool)BackGroundFetchToSync;
@end
@implementation TestBoolNativeSync
- (_Bool)isGettingData{return 0;}
- (_Bool)BackGroundFetchToSync{self.calls++;return 1;}
@end
@interface MMServiceWrapper : NSProxy
@property id target;
@property NSUInteger forwards;
@end
@implementation MMServiceWrapper
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector{return [self.target methodSignatureForSelector:selector];}
- (void)forwardInvocation:(NSInvocation *)invocation{self.forwards++;[invocation invokeWithTarget:self.target];}
@end
int CSAITestFsync(int descriptor){
    struct stat info;
    if(failDirectorySync && fstat(descriptor,&info)==0 && S_ISDIR(info.st_mode)){
        failedDirectorySyncs++;errno=EIO;return -1;
    }
    return fsync(descriptor);
}
void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original){
    Method method=class_getInstanceMethod(cls,selector);*original=method_getImplementation(method);
    class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));
    [installedHooks addObject:NSStringFromSelector(selector)];
}
void CSBackupWhenReady(void(^callback)(void)){callback();}
void CSAIRefreshChatDetail(id page){(void)page;}
@interface TestMessageWrap : NSObject
@property NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsRealChatUsr,*m_nsAtUserList;
@property BOOL m_nsAtAll;
@property unsigned int m_uiMessageType,m_uiMesLocalID,m_uiCreateTime;
@end
@implementation TestMessageWrap @end
@interface TestAdmissionWrap : TestMessageWrap
@property NSUInteger identityReads;
@property NSUInteger typeReads;
@end
@implementation TestAdmissionWrap
- (NSString *)m_nsFromUsr{self.identityReads++;return [super m_nsFromUsr];}
- (unsigned int)m_uiMessageType{self.typeReads++;return [super m_uiMessageType];}
@end
@interface CMessageMgr : NSObject
- (void)AddMsg:(id)session MsgWrap:(id)wrap;
- (void)AsyncOnAddMsg:(id)session MsgWrap:(id)wrap;
@end
@implementation CMessageMgr
- (void)AddMsg:(id)session MsgWrap:(id)wrap{
    if(CSAIIsOwnedSend(wrap)){ownedSends++;lastSentTo=session;}else {manualSends++;if(duringManualSend)duringManualSend();}
    // Native outgoing echo still passes through the production incoming hook/filter.
    [self AsyncOnAddMsg:session MsgWrap:wrap];
}
- (void)AsyncOnAddMsg:(id)session MsgWrap:(id)wrap{(void)session;(void)wrap;}
@end
static CMessageMgr *nativeMessages;
static TestMessageWrap *Message(NSString *from,NSString *to,NSUInteger identity,NSTimeInterval created){
    TestMessageWrap *wrap=[TestMessageWrap new];wrap.m_nsFromUsr=from;wrap.m_nsToUsr=to;wrap.m_nsContent=@"synthetic body";
    wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=(unsigned int)identity;wrap.m_uiCreateTime=(unsigned int)created;return wrap;
}
static void DrainMain(void){for(NSUInteger i=0;i<4;i++)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];}

static NSMutableDictionary *keys;
#define CHECK(c) do{checks++;if(!(c)){NSLog(@"FAIL %d %s",__LINE__,#c);exit(1);}}while(0)
NSNotificationName const UIApplicationDidBecomeActiveNotification=@"test-active";
NSNotificationName const UIApplicationDidEnterBackgroundNotification=@"test-background";
NSNotificationName const UIApplicationWillEnterForegroundNotification=@"test-foreground";
NSNotificationName const UIApplicationProtectedDataDidBecomeAvailable=@"test-unlocked";
NSNotificationName const CSBackgroundRunStateChangedNotification=@"test-audio-state";
NSString *const CSCloseFriendPolicyDidChangeNotification=@"test-privacy";
@implementation UIApplication
+ (instancetype)sharedApplication{static UIApplication *app;static dispatch_once_t once;dispatch_once(&once,^{app=[self new];});return app;}
@end
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation CSBackgroundRunManager
+ (instancetype)sharedManager{static CSBackgroundRunManager *manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (BOOL)backgroundAudioActive{return backgroundAudioActive;}
@end
#pragma clang diagnostic pop
BOOL CSBackupIsReady(void){return backupReady;}
BOOL CSBackupAccountIsSuspended(void){return suspended;}
NSUInteger CSBackupAccountEpoch(void){return epoch;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger expected,void(^block)(void)){if(expected!=epoch || suspended)return NO;block();return YES;}
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface){return [privacy hidesUserName:name surface:surface];}
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return privacy;}
static void SetPrivacy(BOOL revealed,BOOL hideSessions,BOOL hideAI){
    NSDictionary *profile=@{@"enabled":@YES,@"friends":@[@"friend"],@"groups":@[@"room@chatroom"],@"options":@{@"hideSessions":@(hideSessions),@"hideAIReply":@(hideAI)}};
    privacy=[[CSCloseFriendSnapshot alloc]initWithAccountID:account profile:profile revealed:revealed revision:1 blocked:NO];
}
id CSGroupReadObject(id object,NSString *name){return CSMessageActionNativeObject(object,name);}
CSGroupRowCategory CSGroupCategoryForContact(id contact){NSString *name=CSGroupReadObject(contact,@"m_nsUsrName");return !name || [name isEqual:@"service"]?CSGroupRowCategoryService:[name hasSuffix:@"@chatroom"]?CSGroupRowCategoryGroup:CSGroupRowCategoryPrivate;}
NSString *CSAIReadCredential(NSString *owner,NSString *revision,NSError **error){(void)error;return keys[@[owner,revision]];}
BOOL CSAIWriteCredential(NSString *owner,NSString *revision,NSString *key,NSError **error){if(failKeyWrite){if(error)*error=CSAIError(99,@"test key write denied");return NO;}keys[@[owner,revision]]=key;return YES;}
void CSAIRemoveCredential(NSString *owner,NSString *revision){[keys removeObjectForKey:@[owner,revision]];}
@interface TestContact : NSObject
@property NSString *m_nsUsrName;
@end
@implementation TestContact @end
@interface TestContacts : NSObject
- (id)getContactByName:(NSString *)name;
@end
@implementation TestContacts
- (id)getContactByName:(NSString *)name{if(duringContactLookup){dispatch_block_t action=duringContactLookup;duringContactLookup=nil;action();}if([name isEqual:@"missing"] || [name isEqual:@"missing@chatroom"])return nil;TestContact *contact=[TestContact new];contact.m_nsUsrName=name;return contact;}
@end
@implementation CSMessageNativeEnvironment
- (NSString *)currentAccountID{return account;}
- (id)serviceNamed:(NSString *)name{if([name isEqual:@"NewSyncService"])return nativeSyncService;return [name isEqual:@"CMessageMgr"]?nativeMessages:[TestContacts new];}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static id value;static dispatch_once_t once;dispatch_once(&once,^{value=[self new];});return value;}
- (BOOL)isAuthorized{return authorized;}
@end
@implementation CSMessageSendAdapter
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment{(void)environment;return [super init];}
- (CSMessagePreparedSend *)prepareScheduledText:(NSString *)text targetID:(NSString *)targetID accountID:(NSString *)accountID{
    (void)text;if(!simulateSends){submissions++;return nil;}
    TestMessageWrap *wrap=Message(accountID,targetID,0,1000);
    __block __weak CSMessagePreparedSend *weakRoute;
    CSMessagePreparedSend *route=[[CSMessagePreparedSend alloc]initWithWrap:wrap routeName:@"fake native AddMsg" submission:^{
        submissions++;[nativeMessages AddMsg:targetID MsgWrap:wrap];
        [weakRoute setValue:@YES forKey:@"nativeHandoffReturned"];return CSMessageActionSubmissionStateUnknown;
    }];weakRoute=route;return route;
}
@end
@interface TestCancellation : NSObject <CSAICancellable>
@property BOOL cancelled;
@property(copy) dispatch_block_t onCancel;
@end
@implementation TestCancellation
- (void)cancel{self.cancelled=YES;if(self.onCancel)self.onCancel();}
@end
@interface TestClient : CSAIClient
@property NSMutableArray<CSAICompletion> *callbacks;
@property NSMutableArray<TestCancellation *> *tasks;
@property NSArray *lastMessages;
@property NSDictionary *lastConfiguration;
@property BOOL inlineCompletion;
@end
@implementation TestClient
- (instancetype)init{if((self=[super init])){_callbacks=[NSMutableArray array];_tasks=[NSMutableArray array];}return self;}
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)config apiKey:(NSString *)key messages:(NSArray *)messages completion:(CSAICompletion)completion{(void)key;self.lastConfiguration=config;self.lastMessages=messages;[self.callbacks addObject:[completion copy]];TestCancellation *task=[TestCancellation new];[self.tasks addObject:task];if(self.inlineCompletion)completion(@"合成图测试正常",nil);return task;}
@end
@interface TestImages : NSObject <CSAIImagePreparing>
@property NSDictionary *event;
@property(copy) CSAIImageCompletion completion;
@property TestCancellation *task;
@end
@implementation TestImages
- (id<CSAICancellable>)prepareImageForEvent:(NSDictionary *)event completion:(CSAIImageCompletion)completion{self.event=event;self.completion=completion;self.task=[TestCancellation new];return self.task;}
@end
@interface TestStore : CSAIReplyStore
@property BOOL failSave;
@end
@implementation TestStore
- (BOOL)saveConfiguration:(NSDictionary *)config error:(NSError **)error{if(self.failSave){if(error)*error=CSAIError(99,@"test disk write denied");return NO;}return [super saveConfiguration:config error:error];}
@end
static void ManualCoexistence(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/chat";
    config[@"model"]=@"fake-model";config[@"credentialRevision"]=@"manual-coexistence";keys[@[account,@"manual-coexistence"]]=@"fake-key";
    config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""}};
    CHECK([store saveConfiguration:config error:NULL]);
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;TestClient *client=[TestClient new];
    [manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];[manager setValue:@YES forKey:@"started"];
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;
    __block NSTimeInterval clock=1000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];
    nativeMessages=[CMessageMgr new];installedHooks=[NSMutableArray array];simulateSends=YES;submissions=0;
    IMP outgoingBefore=class_getMethodImplementation(CMessageMgr.class,@selector(AddMsg:MsgWrap:));
    CSAITestInstallHooks();DrainMain();
    CHECK(installedHooks.count==1);CHECK([installedHooks[0] isEqual:@"AsyncOnAddMsg:MsgWrap:"]);
    CHECK(class_getMethodImplementation(CMessageMgr.class,@selector(AddMsg:MsgWrap:))==outgoingBefore);
    CHECK(![manager respondsToSelector:NSSelectorFromString(@"observeOutgoingWrap:epoch:")]);
    CHECK(![coordinator respondsToSelector:NSSelectorFromString(@"manualReplyInConversation:")]);
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,1,clock)];DrainMain();CHECK(coordinator.pendingCount==1);
    [nativeMessages AddMsg:@"friend" MsgWrap:Message(account,@"friend",101,clock)];DrainMain();CHECK(coordinator.pendingCount==1 && !client.callbacks.count);
    clock+=2;[coordinator processPending];CHECK(coordinator.activeCount==1 && client.callbacks.count==1);
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,2,clock)];DrainMain();CHECK(coordinator.pendingCount==1);
    TestMessageWrap *ownedEcho=Message(@"friend",account,99,clock);CSAIMarkOwnedSend(ownedEcho);
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:ownedEcho];DrainMain();
    CHECK(coordinator.activeCount==1 && coordinator.pendingCount==1 && ![store hasHandledMessageID:@"alice|friend|l:99:1002"]);
    // An already queued completion still submits after a manual send. Own AI echoes
    // are filtered, and manual sends preserve both active work and the next batch.
    dispatch_async(dispatch_get_main_queue(),^{client.callbacks[0](@"AI one",nil);});
    [nativeMessages AddMsg:@"friend" MsgWrap:Message(account,@"friend",102,clock)];
    CHECK(coordinator.activeCount==1 && coordinator.pendingCount==1 && !client.tasks[0].cancelled);DrainMain();
    CHECK(submissions==1 && ownedSends==1 && !coordinator.activeCount && coordinator.pendingCount==1);
    clock+=2;[coordinator processPending];CHECK(coordinator.activeCount==1 && client.lastMessages.count==4);
    // Reentry from native outgoing implementation may complete the active request.
    duringManualSend=^{client.callbacks[1](@"AI two",nil);};
    [nativeMessages AddMsg:@"friend" MsgWrap:Message(account,@"friend",103,clock)];duringManualSend=nil;DrainMain();
    CHECK(submissions==2 && ownedSends==2 && !client.tasks[1].cancelled);
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,3,clock)];DrainMain();clock+=2;[coordinator processPending];
    CHECK(coordinator.activeCount==1 && client.lastMessages.count==6);
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,4,clock)];DrainMain();CHECK(coordinator.pendingCount==1);
    // Off-main outgoing calls finish without dispatch_sync or main-queue draining.
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{@autoreleasepool{[nativeMessages AddMsg:@"friend" MsgWrap:Message(account,@"friend",104,clock)];}});
    CHECK(dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    CHECK(coordinator.activeCount==1 && coordinator.pendingCount==1 && !client.tasks[2].cancelled);DrainMain();
    client.callbacks[2](@"AI three",nil);DrainMain();CHECK(submissions==3 && ownedSends==3 && manualSends==4);
    CHECK(coordinator.pendingCount==1 && !coordinator.activeCount && store.history.count==3);
    [coordinator cancelAll];simulateSends=NO;
}
static void HiddenConversationReplies(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/chat";
    config[@"model"]=@"fake-model";config[@"credentialRevision"]=@"hidden-replies";keys[@[account,@"hidden-replies"]]=@"fake-key";
    config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);
    config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""},@"room@chatroom":@{@"enabled":@YES,@"presetID":@""},@"missing":@{@"enabled":@YES,@"presetID":@""},@"service":@{@"enabled":@YES,@"presetID":@""}};
    CHECK([store saveConfiguration:config error:NULL]);NSDictionary *original=store.configuration;
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;TestClient *client=[TestClient new];
    [manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;
    __block NSTimeInterval clock=2000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];
    SetPrivacy(YES,YES,YES);simulateSends=YES;submissions=0;
    // start installs the production policy observer while retaining this isolated store.
    [manager setValue:@NO forKey:@"started"];[manager start];
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,1,clock)];DrainMain();
    clock+=2;[coordinator processPending];CHECK(coordinator.activeCount==1 && client.callbacks.count==1);
    SetPrivacy(NO,YES,YES);
    [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];DrainMain();
    CHECK(coordinator.activeCount==1 && !client.tasks[0].cancelled);
    NSArray *visible=CSCloseFriendVisibleAIConversations(store.configuration[@"conversations"],account,privacy);
    CHECK(![visible containsObject:@"friend"] && ![visible containsObject:@"room@chatroom"]);
    CHECK(![manager allowsConversation:@"friend"]); // concealed editing surface remains protected
    CHECK([[manager statusForConversation:@"friend"] hasPrefix:@"已启用"]);
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,2,clock)];DrainMain();CHECK(coordinator.pendingCount==1);
    SetPrivacy(NO,YES,NO);
    [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];DrainMain();
    CHECK(coordinator.activeCount==1 && coordinator.pendingCount==1 && !client.tasks[0].cancelled);
    CHECK([CSCloseFriendVisibleAIConversations(store.configuration[@"conversations"],account,privacy) containsObject:@"friend"]);
    SetPrivacy(NO,YES,YES);
    [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];DrainMain();
    client.callbacks[0](@"reply after lock",nil);DrainMain();
    CHECK(submissions==1 && [lastSentTo isEqual:@"friend"] && coordinator.pendingCount==1);
    clock+=2;[coordinator processPending];CHECK(coordinator.activeCount==1 && client.lastMessages.count==4);
    SetPrivacy(YES,YES,YES);
    [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];DrainMain();
    CHECK(!client.tasks[1].cancelled && coordinator.activeCount==1);
    client.callbacks[1](@"reply after unlock",nil);DrainMain();CHECK(submissions==2);

    // New private replies work under every combination of list/session concealment.
    NSUInteger identity=10;
    for(NSNumber *sessions in @[@NO,@YES])for(NSNumber *list in @[@NO,@YES]){
        SetPrivacy(NO,sessions.boolValue,list.boolValue);
        [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];DrainMain();
        BOOL listed=[CSCloseFriendVisibleAIConversations(store.configuration[@"conversations"],account,privacy) containsObject:@"friend"];
        CHECK(listed==!list.boolValue);
        NSUInteger before=submissions;
        [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,identity++,clock)];DrainMain();
        CHECK(coordinator.pendingCount==1);clock+=2;[coordinator processPending];CHECK(coordinator.activeCount==1);
        client.callbacks.lastObject(@"hidden private reply",nil);DrainMain();
        CHECK(submissions==before+1 && [lastSentTo isEqual:@"friend"]);
    }
    CHECK([store.configuration isEqual:original]); // visibility never rewrites enablement or presets

    // Hidden groups still require a structured individual mention, and reject @all.
    SetPrivacy(NO,YES,YES);NSUInteger requests=client.callbacks.count;
    TestMessageWrap *group=Message(@"room@chatroom",account,identity++,clock);group.m_nsRealChatUsr=@"member";
    [nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();
    CHECK(!coordinator.pendingCount && client.callbacks.count==requests);
    group.m_nsAtUserList=account;group.m_nsAtAll=YES;
    [nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();CHECK(!coordinator.pendingCount);
    group.m_nsAtAll=NO;[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();
    CHECK(coordinator.pendingCount==1);clock+=2;[coordinator processPending];CHECK(client.callbacks.count==requests+1);
    NSUInteger before=submissions;client.callbacks.lastObject(@"hidden group reply",nil);DrainMain();
    CHECK(submissions==before+1 && [lastSentTo isEqual:@"room@chatroom"]);
    CHECK(![CSCloseFriendVisibleAIConversations(store.configuration[@"conversations"],account,privacy) containsObject:@"room@chatroom"]);

    // Execution guards still reject unsupported contacts, disabled AI, invalid connection and authorization.
    for(NSString *target in @[@"service",@"missing"]){
        [nativeMessages AsyncOnAddMsg:target MsgWrap:Message(target,account,identity++,clock)];DrainMain();CHECK(!coordinator.pendingCount);
    }
    for(NSUInteger gate=0;gate<4;gate++){
        NSMutableDictionary *disabled=[original mutableCopy];
        if(gate==0)disabled[@"enabled"]=@NO;
        if(gate==1){NSMutableDictionary *items=[disabled[@"conversations"] mutableCopy];items[@"friend"]=@{@"enabled":@NO,@"presetID":@""};disabled[@"conversations"]=items;}
        if(gate==2)disabled[@"verifiedConnection"]=@"";
        if(gate==3)authorized=NO;
        CHECK([manager saveConfiguration:disabled account:account epoch:epoch error:NULL]);requests=client.callbacks.count;
        [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,identity++,clock)];DrainMain();
        clock+=2;[coordinator processPending];CHECK(!coordinator.pendingCount && !coordinator.activeCount && client.callbacks.count==requests);
        authorized=YES;CHECK([manager saveConfiguration:original account:account epoch:epoch error:NULL]);
    }
    // Turning AI off still cancels an in-flight hidden reply and rejects late completion.
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,identity++,clock)];DrainMain();clock+=2;[coordinator processPending];
    CHECK(coordinator.activeCount==1);CSAICompletion late=client.callbacks.lastObject;TestCancellation *active=client.tasks.lastObject;
    NSMutableDictionary *off=[original mutableCopy];off[@"enabled"]=@NO;CHECK([manager saveConfiguration:off account:account epoch:epoch error:NULL]);
    CHECK(active.cancelled && !coordinator.activeCount);before=submissions;late(@"late disabled reply",nil);DrainMain();CHECK(submissions==before);
    CHECK([manager saveConfiguration:original account:account epoch:epoch error:NULL]);
    // Account epoch invalidation still rejects completion even before async refresh runs.
    [nativeMessages AsyncOnAddMsg:@"friend" MsgWrap:Message(@"friend",account,identity++,clock)];DrainMain();clock+=2;[coordinator processPending];CHECK(coordinator.activeCount==1);
    epoch++;client.callbacks.lastObject(@"old account reply",nil);DrainMain();CHECK(submissions==before);epoch--;
    [coordinator cancelAll];[NSNotificationCenter.defaultCenter removeObserver:manager];simulateSends=NO;SetPrivacy(YES,YES,YES);
}
static void GroupUnmentionedReplies(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/chat";
    config[@"model"]=@"fake-model";config[@"credentialRevision"]=@"unmentioned-replies";keys[@[account,@"unmentioned-replies"]]=@"fake-key";config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);
    NSMutableArray *presets=[config[@"presets"] mutableCopy];[presets addObject:@{@"id":@"custom",@"name":@"Custom",@"prompt":@"custom prompt"}];config[@"presets"]=presets;
    config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""},@"room@chatroom":@{@"enabled":@YES,@"presetID":@""},@"other@chatroom":@{@"enabled":@YES,@"presetID":@""}};CHECK([store saveConfiguration:config error:NULL]);
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;TestClient *client=[TestClient new];
    [manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;
    __block NSTimeInterval clock=3000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];
    SetPrivacy(YES,YES,YES);simulateSends=YES;submissions=0;NSUInteger identity=1;NSError *error=nil;
    NSDictionary *other=store.configuration[@"conversations"][@"other@chatroom"],*friend=store.configuration[@"conversations"][@"friend"];
    CHECK(![store.configuration[@"conversations"][@"room@chatroom"][@"allowUnmentioned"] boolValue]);CHECK([[manager statusForConversation:@"room@chatroom"] isEqual:@"已启用 · 仅被 @ 时回复"]);
    TestMessageWrap *group=Message(@"room@chatroom",account,identity++,clock);group.m_nsRealChatUsr=@"member";
    [nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();CHECK(!coordinator.pendingCount && !client.callbacks.count);
    CHECK([manager setConversation:@"room@chatroom" allowUnmentioned:YES account:account epoch:epoch error:&error]);CHECK([store.configuration[@"conversations"][@"room@chatroom"][@"allowUnmentioned"] boolValue]);CHECK([[manager statusForConversation:@"room@chatroom"] isEqual:@"已启用 · 无需 @ 即可回复"]);
    CHECK([store.configuration[@"conversations"][@"other@chatroom"] isEqual:other]);CHECK([store.configuration[@"conversations"][@"friend"] isEqual:friend]);
    CSAIReplyStore *reload=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([reload load]);CHECK([reload.configuration[@"conversations"][@"room@chatroom"][@"allowUnmentioned"] boolValue]);
    // Both existing mutation paths preserve the per-group opt-in.
    CHECK([manager setConversation:@"room@chatroom" enabled:YES presetID:@"custom" account:account epoch:epoch error:&error]);CHECK([store.configuration[@"conversations"][@"room@chatroom"][@"allowUnmentioned"] boolValue]);
    CHECK([manager setConversation:@"room@chatroom" enabled:NO presetID:@"custom" account:account epoch:epoch error:&error]);CHECK([store.configuration[@"conversations"][@"room@chatroom"][@"allowUnmentioned"] boolValue]);CHECK([[manager statusForConversation:@"room@chatroom"] isEqual:@"此会话未启用"]);
    group=Message(@"room@chatroom",account,identity++,clock);group.m_nsRealChatUsr=@"member";[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();CHECK(!coordinator.pendingCount);
    CHECK([manager setConversation:@"room@chatroom" enabled:YES presetID:@"custom" account:account epoch:epoch error:&error]);CHECK([store.configuration[@"conversations"][@"room@chatroom"][@"allowUnmentioned"] boolValue]);
    NSDictionary *before=store.configuration;
    CHECK(![manager setConversation:@"friend" allowUnmentioned:YES account:account epoch:epoch error:&error]);CHECK(![manager setConversation:@"room@chatroom" allowUnmentioned:NO account:@"bob" epoch:epoch error:&error]);CHECK(![manager setConversation:@"room@chatroom" allowUnmentioned:NO account:account epoch:epoch+1 error:&error]);CHECK([store.configuration isEqual:before]);
    SetPrivacy(NO,YES,YES);CHECK(![manager setConversation:@"room@chatroom" allowUnmentioned:NO account:account epoch:epoch error:&error]);CHECK([store.configuration isEqual:before]);
    // Hiding an opted-in group only affects presentation; ordinary messages still reply.
    group=Message(@"room@chatroom",account,identity++,clock);group.m_nsRealChatUsr=@"member";[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();CHECK(coordinator.pendingCount==1);
    [nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();CHECK(coordinator.pendingCount==1);
    TestMessageWrap *otherGroup=Message(@"other@chatroom",account,identity++,clock);otherGroup.m_nsRealChatUsr=@"member";[nativeMessages AsyncOnAddMsg:@"other@chatroom" MsgWrap:otherGroup];DrainMain();CHECK(coordinator.pendingCount==1);
    TestMessageWrap *all=Message(@"room@chatroom",account,identity++,clock);all.m_nsRealChatUsr=@"member";all.m_nsAtUserList=account;all.m_nsAtAll=YES;[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:all];DrainMain();CHECK(coordinator.pendingCount==1);
    clock+=2;[coordinator processPending];CHECK(client.callbacks.count==1 && coordinator.activeCount==1);CHECK([client.lastMessages[0][@"content"] isEqual:@"custom prompt"]);
    client.callbacks.lastObject(@"unmentioned group reply",nil);DrainMain();CHECK(submissions==1 && [lastSentTo isEqual:@"room@chatroom"] && !coordinator.pendingCount);
    SetPrivacy(YES,YES,YES);
    group=Message(@"room@chatroom",account,identity++,clock);group.m_nsRealChatUsr=@"member";[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();clock+=2;[coordinator processPending];CHECK(coordinator.activeCount==1);
    group=Message(@"room@chatroom",account,identity++,clock);group.m_nsRealChatUsr=@"member";[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();CHECK(coordinator.pendingCount==1);
    TestCancellation *active=client.tasks.lastObject;CSAICompletion late=client.callbacks.lastObject;
    CHECK([manager setConversation:@"room@chatroom" allowUnmentioned:NO account:account epoch:epoch error:&error]);CHECK(active.cancelled && !coordinator.activeCount && !coordinator.pendingCount);CHECK([[manager statusForConversation:@"room@chatroom"] isEqual:@"已启用 · 仅被 @ 时回复"]);CHECK([store.configuration[@"conversations"][@"room@chatroom"][@"presetID"] isEqual:@"custom"]);
    late(@"late unmentioned reply",nil);DrainMain();CHECK(submissions==1);
    group=Message(@"room@chatroom",account,identity++,clock);group.m_nsRealChatUsr=@"member";[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();CHECK(!coordinator.pendingCount);
    group.m_nsAtUserList=account;[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:group];DrainMain();CHECK(coordinator.pendingCount==1);clock+=2;[coordinator processPending];client.callbacks.lastObject(@"mentioned group reply",nil);DrainMain();CHECK(submissions==2 && [lastSentTo isEqual:@"room@chatroom"]);
    CHECK([store.configuration[@"conversations"][@"other@chatroom"] isEqual:other]);CHECK([store.configuration[@"conversations"][@"friend"] isEqual:friend]);[coordinator cancelAll];simulateSends=NO;
}
static void DisabledSessionFastPath(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/chat";config[@"model"]=@"fake-model";
    config[@"credentialRevision"]=@"admission";config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""},@"disabled@chatroom":@{@"enabled":@NO,@"presetID":@"",@"allowUnmentioned":@YES}};
    CHECK([store saveConfiguration:config error:NULL]);
    CSAIReplyManager *manager=[CSAIReplyManager new];[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];
    TestClient *client=[TestClient new];CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;coordinator.now=^{return 5000.0;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];
    TestAdmissionWrap *wrap=[TestAdmissionWrap new];wrap.m_nsFromUsr=@"friend";wrap.m_nsToUsr=account;wrap.m_nsContent=@"ordinary text";wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=1;wrap.m_uiCreateTime=5000;
    for(NSUInteger i=0;i<1000;i++)[manager receiveNativeSession:i%2?@"disabled@chatroom":@"unconfigured" wrap:wrap epoch:epoch];
    CHECK(!wrap.identityReads && !coordinator.pendingCount && !client.callbacks.count);
    // Empty/non-string session fallback still derives and validates the conversation from the wrap.
    [manager receiveNativeSession:@"" wrap:wrap epoch:epoch];CHECK(wrap.identityReads==1 && coordinator.pendingCount==1);
    wrap.m_uiMesLocalID=2;[manager receiveNativeSession:@42 wrap:wrap epoch:epoch];CHECK(wrap.identityReads==2 && coordinator.pendingCount==1);
    wrap.m_uiMesLocalID=3;[manager receiveNativeSession:@"friend" wrap:wrap epoch:epoch];CHECK(wrap.identityReads==3 && coordinator.pendingCount==1);
    [coordinator cancelAll];config[@"enabled"]=@NO;CHECK([store saveConfiguration:config error:NULL]);[manager receiveNativeSession:@"friend" wrap:wrap epoch:epoch];CHECK(wrap.identityReads==3 && !coordinator.pendingCount);
}
static NSTimer *SyncTimer(CSAIBackgroundSync *scheduler){return [scheduler valueForKey:@"timer"];}
static void FireSync(CSAIBackgroundSync *scheduler){[SyncTimer(scheduler) fire];}
static void BackgroundSyncReplies(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/chat";config[@"model"]=@"fake-model";
    config[@"credentialRevision"]=@"background-replies";keys[@[account,@"background-replies"]]=@"fake-key";config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);
    config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""},@"room@chatroom":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES},@"other@chatroom":@{@"enabled":@YES,@"presetID":@""}};CHECK([store saveConfiguration:config error:NULL]);NSDictionary *original=store.configuration;
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;TestClient *client=[TestClient new];[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;__block NSTimeInterval messageClock=4000;coordinator.now=^{return messageClock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];
    CSAIBackgroundSync *scheduler=[manager valueForKey:@"backgroundSync"];[scheduler stop];__block NSTimeInterval syncClock=4000;scheduler.now=^{return syncClock;};
    TestNativeSync *service=[TestNativeSync new];service.accepts=YES;nativeSyncService=service;UIApplication.sharedApplication.applicationState=UIApplicationStateActive;backgroundAudioActive=NO;SetPrivacy(NO,YES,YES);simulateSends=YES;submissions=0;
    [manager setValue:@NO forKey:@"started"];[manager start];DrainMain();CHECK(!scheduler.active && !service.syncCalls);
    // The fake native sync releases an already queued silent-group message through the unchanged incoming hook.
    TestMessageWrap *queued=Message(@"room@chatroom",account,1,messageClock);queued.m_nsRealChatUsr=@"member";
    service.didSynchronize=^{[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:queued];};
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];DrainMain();CHECK(!scheduler.active && !service.syncCalls);
    backgroundAudioActive=YES;[NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:nil];DrainMain();CHECK(scheduler.active && service.syncCalls==1 && coordinator.pendingCount==1);
    messageClock+=2;[coordinator processPending];CHECK(client.callbacks.count==1);client.callbacks.lastObject(@"background unmentioned reply",nil);DrainMain();CHECK(submissions==1 && [lastSentTo isEqual:@"room@chatroom"]);
    for(NSUInteger i=0;i<5;i++){[NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:nil];[manager refresh];}DrainMain();CHECK(service.syncCalls==1);
    syncClock=4029;FireSync(scheduler);CHECK(service.syncCalls==1);syncClock=4030;FireSync(scheduler);DrainMain();CHECK(service.syncCalls==2 && !coordinator.pendingCount && client.callbacks.count==1 && submissions==1);service.didSynchronize=nil;
    CHECK([store.configuration isEqual:original]); // No mute, audio or AI preference is rewritten by a sync.
    // WillEnterForeground stops immediately even while UIKit still reports Background.
    NSTimer *old=SyncTimer(scheduler);[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];CHECK(!scheduler.active && !old.valid);[manager refresh];CHECK(!scheduler.active);
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];DrainMain();CHECK(!scheduler.active);
    syncClock=4060;UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];DrainMain();CHECK(scheduler.active && service.syncCalls==3);
    // A queued background refresh must not override a newer foreground transition.
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];CHECK(!scheduler.active);DrainMain();CHECK(!scheduler.active && service.syncCalls==3);
    syncClock=4090;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];DrainMain();CHECK(scheduler.active && service.syncCalls==4);
    backgroundAudioActive=NO;[NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:nil];DrainMain();CHECK(!scheduler.active);syncClock=4120;[old fire];CHECK(service.syncCalls==4);backgroundAudioActive=YES;
    [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:nil];DrainMain();CHECK(scheduler.active && service.syncCalls==5);
    // Each eligibility requirement independently closes the scheduler without switching the test store.
    for(NSUInteger gate=0;gate<19;gate++){
        [scheduler stop];syncClock+=30;NSMutableDictionary *disabled=[original mutableCopy];
        if(gate==4)disabled[@"enabled"]=@NO;
        if(gate==5 || gate==6){NSMutableDictionary *items=[disabled[@"conversations"] mutableCopy];NSMutableDictionary *room=[items[@"room@chatroom"] mutableCopy];room[gate==5?@"enabled":@"allowUnmentioned"]=@NO;items[@"room@chatroom"]=room;disabled[@"conversations"]=items;}
        if(gate==7)disabled[@"verifiedConnection"]=@"";if(gate==8)disabled[@"verifiedConnection"]=@"stale";
        if(gate>=9 && gate<=11){disabled[gate==9?@"credentialRevision":gate==10?@"endpoint":@"model"]=@"";disabled[@"verifiedConnection"]=CSAIConnectionIdentifier(disabled);}
        if(gate==12)disabled[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES}};
        if(gate==13)disabled[@"conversations"]=@{@"missing@chatroom":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES}};
        CHECK([store saveConfiguration:disabled error:NULL]);
        if(gate==0)UIApplication.sharedApplication.applicationState=UIApplicationStateActive;if(gate==1)UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;
        if(gate==2)backgroundAudioActive=NO;if(gate==3)authorized=NO;if(gate==14)epoch++;if(gate==15)account=@"bob";if(gate==16)suspended=YES;if(gate==17)backupReady=NO;if(gate==18)[store setValue:@NO forKey:@"ready"];
        NSUInteger before=service.syncCalls;[scheduler refresh];CHECK(!scheduler.active && service.syncCalls==before);
        UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;backgroundAudioActive=YES;authorized=YES;epoch=7;account=@"alice";suspended=NO;backupReady=YES;[store setValue:@YES forKey:@"ready"];
        CHECK([store saveConfiguration:original error:NULL]);[scheduler refresh];DrainMain();CHECK(scheduler.active && service.syncCalls==before+1);
    }
    // Native busy and rejected attempts consume the same 30-second budget.
    NSUInteger before=service.syncCalls,busyChecks=service.busyChecks;syncClock+=30;service.busy=YES;FireSync(scheduler);CHECK(service.syncCalls==before && service.busyChecks==busyChecks+1);service.busy=NO;FireSync(scheduler);CHECK(service.syncCalls==before && service.busyChecks==busyChecks+1);
    syncClock+=30;service.accepts=NO;FireSync(scheduler);CHECK(service.syncCalls==before+1);FireSync(scheduler);CHECK(service.syncCalls==before+1);service.accepts=YES;
    service.throwBusy=YES;syncClock+=30;FireSync(scheduler);CHECK(service.syncCalls==before+1);service.throwBusy=NO;FireSync(scheduler);CHECK(service.syncCalls==before+1);
    service.throwSync=YES;syncClock+=30;FireSync(scheduler);CHECK(service.syncCalls==before+2);service.throwSync=NO;FireSync(scheduler);CHECK(service.syncCalls==before+2);
    // Revalidate immediately after a native boundary that can revoke authorization.
    service.afterBusyCheck=^{authorized=NO;};syncClock+=30;FireSync(scheduler);CHECK(service.syncCalls==before+2);service.afterBusyCheck=nil;authorized=YES;FireSync(scheduler);CHECK(service.syncCalls==before+2);
    // A contact lookup can reenter account switching while the old service is retained.
    CSAIReplyStore *nextStore=[[CSAIReplyStore alloc]initWithURL:[[url URLByDeletingLastPathComponent]URLByAppendingPathComponent:@"background-bob.plist"] account:@"bob"];CHECK([nextStore load]);CHECK([nextStore saveConfiguration:original error:NULL]);DrainMain();
    service.afterBusyCheck=^{duringContactLookup=^{account=@"bob";epoch++;[manager setValue:nextStore forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];};};
    syncClock+=30;FireSync(scheduler);CHECK(service.syncCalls==before+2 && [account isEqual:@"bob"]);service.afterBusyCheck=nil;duringContactLookup=nil;account=@"alice";epoch=7;[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];
    // Missing and mismatched methods are ignored before invoking either method.
    TestWrongBusyReturn *badBusy=[TestWrongBusyReturn new];nativeSyncService=badBusy;syncClock+=30;FireSync(scheduler);CHECK(!badBusy.calls);
    TestWrongSyncReturn *badSync=[TestWrongSyncReturn new];nativeSyncService=badSync;syncClock+=30;FireSync(scheduler);CHECK(!badSync.calls);
    nativeSyncService=[NSObject new];syncClock+=30;FireSync(scheduler);nativeSyncService=nil;syncClock+=30;FireSync(scheduler);CHECK(service.syncCalls==before+2);
    TestBoolNativeSync *boolean=[TestBoolNativeSync new];nativeSyncService=boolean;syncClock+=30;FireSync(scheduler);CHECK(boolean.calls==1); // B as well as platform BOOL/c encodings.
    MMServiceWrapper *wrapper=[MMServiceWrapper alloc];wrapper.target=service;nativeSyncService=wrapper;syncClock+=30;FireSync(scheduler);CHECK(wrapper.forwards==0 && service.syncCalls==before+2);
    objc_setAssociatedObject(wrapper,CSNativeServiceClassKey,TestNativeSync.class,OBJC_ASSOCIATION_RETAIN_NONATOMIC);syncClock+=30;FireSync(scheduler);CHECK(wrapper.forwards==2 && service.syncCalls==before+3);
    nativeSyncService=service;[coordinator cancelAll];[scheduler stop];[NSNotificationCenter.defaultCenter removeObserver:manager];UIApplication.sharedApplication.applicationState=UIApplicationStateActive;backgroundAudioActive=NO;simulateSends=NO;nativeSyncService=nil;SetPrivacy(YES,YES,YES);CHECK([store.configuration isEqual:original]);
}
static void CapabilityAndImageIntegration(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/v1/chat/completions";config[@"model"]=@"qwen3.8-flash";
    config[@"credentialRevision"]=@"image-integration";keys[@[account,@"image-integration"]]=@"synthetic-key";config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""}};CHECK([store saveConfiguration:config error:NULL]);
    CSAIReplyManager *manager=[CSAIReplyManager new];TestClient *client=[TestClient new];TestImages *images=[TestImages new];
    [manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;coordinator.imagePreparer=images;
    __block NSTimeInterval clock=7000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];
    TestAdmissionWrap *off=[TestAdmissionWrap new];off.m_uiMessageType=3;[manager receiveNativeSession:@"friend" wrap:off epoch:epoch];CHECK(!off.identityReads && !images.event && off.typeReads==1);
    off.m_uiMessageType=1;off.m_nsFromUsr=@"friend";off.m_nsToUsr=account;off.m_nsContent=@"synthetic text";off.m_uiMesLocalID=66;off.m_uiCreateTime=(unsigned int)clock;off.typeReads=0;
    [manager receiveNativeSession:@"friend" wrap:off epoch:epoch];CHECK(off.typeReads==1 && coordinator.pendingCount==1);[coordinator cancelAll];
    __block NSUInteger completions=0;__block NSError *failure=nil;
    [manager testConnectionForAccount:account epoch:epoch completion:^(NSString *text,NSError *error){(void)text;completions++;failure=error;}];
    TestCancellation *oldTask=client.tasks.lastObject;CSAICompletion oldCallback=client.callbacks.lastObject;
    oldTask.onCancel=^{oldCallback(@"late inline old success",nil);};
    config=[store.configuration mutableCopy];config[@"provider"]=@"bailian";config[@"imageEnabled"]=@YES;config[@"searchMode"]=@"auto";config[@"thinkingEnabled"]=@NO;
    CHECK([manager saveConfiguration:config account:account epoch:epoch error:NULL]);CHECK(oldTask.cancelled && failure.code==22 && completions==1);CHECK(!manager.connectionStatus && ![store.configuration[@"verifiedConnection"] length]);
    CHECK([store.configuration[@"endpoint"] isEqual:@"https://example.invalid/v1/chat/completions"] && [store.configuration[@"credentialRevision"] isEqual:@"image-integration"]);
    client.inlineCompletion=YES;[manager testConnectionForAccount:account epoch:epoch completion:^(NSString *text,NSError *error){CHECK(text.length && !error);completions++;}];client.inlineCompletion=NO;
    CHECK([client.lastMessages[0][@"content"] isKindOfClass:NSArray.class]);NSArray *parts=client.lastMessages[0][@"content"];CHECK(parts.count==2 && [parts[0][@"image_url"][@"url"] hasPrefix:@"data:image/png;base64,"]);
    CHECK([client.lastConfiguration[@"provider"] isEqual:@"bailian"] && [client.lastConfiguration[@"searchMode"] isEqual:@"auto"]);
    CHECK(![manager valueForKey:@"connectionTest"] && [store.configuration[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(store.configuration)]);
    client.callbacks.lastObject(@"duplicate inline completion",nil);CHECK(completions==2);
    TestMessageWrap *wrap=Message(@"friend",account,77,clock);wrap.m_uiMessageType=3;wrap.m_nsContent=@"";[manager receiveNativeSession:@"friend" wrap:wrap epoch:epoch];
    CHECK(coordinator.pendingCount==1 && !images.event && [store hasHandledMessageID:@"alice|friend|l:77:7000"]);clock+=2;[coordinator processPending];
    CHECK([images.event[@"epoch"] isEqual:@(epoch)] && images.event[@"imageSource"]==wrap && coordinator.activeCount==1);
    BOOL (^valid)(void)=images.event[@"imageStillValid"];CHECK(valid());NSUInteger requests=client.callbacks.count;
    config=[store.configuration mutableCopy];config[@"searchMode"]=@"always";CHECK([manager saveConfiguration:config account:account epoch:epoch error:NULL]);
    CHECK(images.task.cancelled && !valid() && !coordinator.activeCount && !manager.connectionStatus && ![store.configuration[@"verifiedConnection"] length]);
    images.completion(@"data:image/jpeg;base64,AQ==",nil);CHECK(client.callbacks.count==requests);
    [coordinator cancelAll];
}
int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2);keys=[NSMutableDictionary dictionary];NSURL *url=[NSURL fileURLWithPath:@(argv[1])];
    TestStore *store=[[TestStore alloc]initWithURL:url account:account];CHECK([store load]);
    CSAIReplyManager *manager=[CSAIReplyManager new];TestClient *client=[TestClient new];
    [manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
    NSError *error=nil;NSString *endpoint=@"https://example.invalid/v1/chat/completions";
    CHECK([manager isCurrentAccount:@"alice" epoch:7]);CHECK(![manager isCurrentAccount:@"bob" epoch:7]);
    CHECK([manager saveConnection:endpoint model:@"model-a" key:@"key-a" account:account epoch:epoch error:&error]);
    NSString *first=store.configuration[@"credentialRevision"];CHECK([CSAIReadCredential(account,first,NULL) isEqual:@"key-a"]);CHECK(![store.configuration[@"enabled"] boolValue]);
    __block NSString *result;__block NSError *failure;
    CSAICompletion completion=^(NSString *text,NSError *e){result=text;failure=e;};
    [manager testConnectionForAccount:account epoch:epoch completion:completion];
    CHECK(client.callbacks.count==1);CHECK(client.lastMessages.count==1);CHECK([client.lastMessages[0][@"content"] isEqual:@"请只回复：连接正常。"]);CHECK(submissions==0);
    client.callbacks[0](@"连接正常",nil);CHECK(!failure && result.length);CHECK([store.configuration[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(store.configuration)]);CHECK(![store.configuration[@"enabled"] boolValue]);
    // A repeated failed test revokes an earlier successful verification.
    [manager testConnectionForAccount:account epoch:epoch completion:completion];client.callbacks[1](nil,CSAIError(401,@"认证失败"));CHECK(failure.code==401);CHECK(![store.configuration[@"verifiedConnection"] length]);
    [manager testConnectionForAccount:account epoch:epoch completion:completion];client.callbacks[2](@"正常",nil);NSString *verified=store.configuration[@"verifiedConnection"];
    [manager testConnectionForAccount:account epoch:epoch completion:completion];client.callbacks[3](nil,CSAIError(NSURLErrorCancelled,@"取消"));CHECK([store.configuration[@"verifiedConnection"] isEqual:verified]);
    // Failed Keychain or plist writes keep the active slot unchanged; staged keys are discarded.
    NSDictionary *before=store.configuration;NSUInteger keyCount=keys.count;failKeyWrite=YES;
    CHECK(![manager saveConnection:endpoint model:@"model-b" key:@"key-b" account:account epoch:epoch error:&error]);CHECK([store.configuration isEqual:before]);CHECK(keys.count==keyCount);failKeyWrite=NO;store.failSave=YES;
    CHECK(![manager saveConnection:endpoint model:@"model-b" key:@"key-b" account:account epoch:epoch error:&error]);CHECK([store.configuration isEqual:before]);CHECK(keys.count==keyCount);store.failSave=NO;
    // Exercise production file fsync/rename and fail only parent-directory fsync.
    // Failure retains old in-memory config, marks storage unready, and preserves
    // the staged key because the destination already names its new revision.
    failDirectorySync=YES;error=nil;
    CHECK(![manager saveConnection:endpoint model:@"model-uncertain" key:@"key-uncertain" account:account epoch:epoch error:&error]);
    CHECK(failedDirectorySyncs==1);CHECK([error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue]);
    CHECK(!store.ready);CHECK(![manager isCurrentAccount:account epoch:epoch]);CHECK([store.configuration isEqual:before]);CHECK(keys.count==keyCount+1);
    failDirectorySync=NO;
    CSAIReplyStore *reopened=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([reopened load]);
    NSString *uncertainRevision=reopened.configuration[@"credentialRevision"];
    CHECK(![uncertainRevision isEqual:first]);CHECK([CSAIReadCredential(account,uncertainRevision,NULL) isEqual:@"key-uncertain"]);
    CHECK([CSAIReadCredential(account,first,NULL) isEqual:@"key-a"]);CHECK([reopened.configuration[@"model"] isEqual:@"model-uncertain"]);
    CHECK(![reopened.configuration[@"verifiedConnection"] length]);
    [manager refresh];CHECK(store.ready);CHECK([store.configuration isEqual:reopened.configuration]);
    CHECK(![store.configuration[@"verifiedConnection"] length]);
    // A nil NSError destination must preserve the uncertain credential as well.
    failDirectorySync=YES;
    CHECK(![manager saveConnection:endpoint model:@"model-uncertain-2" key:@"key-uncertain-2" account:account epoch:epoch error:NULL]);
    CHECK(failedDirectorySyncs==2);failDirectorySync=NO;CHECK([reopened load]);
    CHECK([CSAIReadCredential(account,reopened.configuration[@"credentialRevision"],NULL) isEqual:@"key-uncertain-2"]);
    CHECK([store load]);CHECK([store saveConfiguration:before error:&error]);keyCount=keys.count;
    // Late success from a saved old connection cannot verify the replacement.
    [manager testConnectionForAccount:account epoch:epoch completion:completion];TestCancellation *oldTask=client.tasks.lastObject;
    CHECK([manager saveConnection:endpoint model:@"model-b" key:nil account:account epoch:epoch error:&error]);CHECK(oldTask.cancelled);CHECK([store.configuration[@"credentialRevision"] isEqual:first]);CHECK(![store.configuration[@"verifiedConnection"] length]);
    client.callbacks[4](@"old success",nil);CHECK(failure.code==22);CHECK(![store.configuration[@"verifiedConnection"] length]);
    // A test on a former account cannot mutate persisted state or verify the next account.
    [manager testConnectionForAccount:account epoch:epoch completion:completion];before=store.configuration;account=@"bob";epoch++;
    client.callbacks[5](@"old account",nil);CHECK(failure.code==22);CHECK([store.configuration isEqual:before]);
    CHECK(![manager saveConnection:endpoint model:@"wrong" key:@"wrong" account:@"alice" epoch:7 error:&error]);CHECK(keys.count==keyCount);account=@"alice";epoch=7;
    CHECK([manager setConversation:@"friend" enabled:YES presetID:@"" account:account epoch:epoch error:&error]);CHECK([store.configuration[@"conversations"][@"friend"][@"enabled"] boolValue]);
    SetPrivacy(NO,YES,YES);CHECK(![manager setConversation:@"friend" enabled:NO presetID:@"" account:account epoch:epoch error:&error]);SetPrivacy(YES,YES,YES);
    suspended=YES;CHECK(![manager isCurrentAccount:account epoch:epoch]);suspended=NO;
    CHECK([manager saveConnection:endpoint model:@"model-b" key:@"" account:account epoch:epoch error:&error]);CHECK(![store.configuration[@"credentialRevision"] length]);CHECK([CSAIReadCredential(account,first,NULL) isEqual:@"key-a"]);CHECK(submissions==0);
    ManualCoexistence([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"coexistence.plist"]);
    HiddenConversationReplies([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"hidden-replies.plist"]);
    GroupUnmentionedReplies([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"unmentioned-replies.plist"]);
    DisabledSessionFastPath([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"disabled-session.plist"]);
    BackgroundSyncReplies([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"background-replies.plist"]);
    CapabilityAndImageIntegration([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"image-integration.plist"]);
    printf("AI reply manager: %lu checks passed\n",(unsigned long)checks);return 0;
}}
