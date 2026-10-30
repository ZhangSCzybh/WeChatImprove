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
static NSUInteger hookMainDispatches;
static void CSAITestHookDispatch(dispatch_queue_t queue,dispatch_block_t block){hookMainDispatches++;dispatch_async(queue,block);}
// Native full-sync hooks have their own fixtures; keep the ingress hook isolated.
static dispatch_block_t duringBackgroundSyncObservation;
static CSAIReplyManager *backgroundSyncObservationManager;
static BOOL insideBackgroundSyncRequest;
static NSUInteger nativeGetterReadsInObservedRequest;
void CSAIInstallNativeSyncObserver(void) {}
void CSAIObserveBackgroundSyncRequest(NSUInteger expectedEpoch,void (^request)(void)) {
    if(duringBackgroundSyncObservation){dispatch_block_t action=duringBackgroundSyncObservation;duringBackgroundSyncObservation=nil;action();}
    if(backgroundSyncObservationManager)[backgroundSyncObservationManager captureBackgroundSyncContextForEpoch:expectedEpoch];
    BOOL previous=insideBackgroundSyncRequest;insideBackgroundSyncRequest=YES;
    @try {request();} @finally {insideBackgroundSyncRequest=previous;}
}
#import "AIHooksUnderTest.m"
#import <sys/stat.h>
#import <unistd.h>
#import <errno.h>
#import <stdatomic.h>
@interface CSAIReplyManager (AdmissionFixture)
- (void)notify;
- (void)invalidateConnectionTest;
@end
static NSUInteger checks,epoch=7,submissions;
static NSString *account=@"alice";
static BOOL suspended,failKeyWrite,failDirectorySync,simulateSends;
static BOOL authorized=YES;
static CSCloseFriendSnapshot *privacy;
static NSUInteger failedDirectorySyncs,manualSends,ownedSends,nativeIncomingCalls;
static NSString *lastSentTo;
static NSMutableArray<NSString *> *installedHooks;
static void (^duringManualSend)(void);
static BOOL backgroundAudioActive,backupReady=YES;
static atomic_bool pauseNextFsync,ioPaused;
static dispatch_semaphore_t resumeFsync;
static id nativeSyncService;
static dispatch_block_t duringContactLookup;
static dispatch_block_t duringAccountLookup;
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
    if(fstat(descriptor,&info)==0 && S_ISREG(info.st_mode) && atomic_exchange(&pauseNextFsync,false)){
        atomic_store(&ioPaused,true);if(dispatch_semaphore_wait(resumeFsync,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))!=0)abort();atomic_store(&ioPaused,false);
    }
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
@property unsigned long long m_n64MesSvrID;
@end
@implementation TestMessageWrap @end
@interface TestAdmissionWrap : TestMessageWrap
@property NSUInteger identityReads;
@property NSUInteger typeReads;
@property NSUInteger bodyReads,identifierReads;
@property BOOL readOffMain;
@end
@implementation TestAdmissionWrap
- (NSString *)m_nsFromUsr{self.identityReads++;return [super m_nsFromUsr];}
- (unsigned int)m_uiMessageType{self.typeReads++;return [super m_uiMessageType];}
- (NSString *)m_nsContent{self.bodyReads++;self.readOffMain|=!NSThread.isMainThread;return [super m_nsContent];}
- (unsigned int)m_uiMesLocalID{self.identifierReads++;self.readOffMain|=!NSThread.isMainThread;return [super m_uiMesLocalID];}
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
- (void)AsyncOnAddMsg:(id)session MsgWrap:(id)wrap{(void)session;(void)wrap;nativeIncomingCalls++;}
@end
static CMessageMgr *nativeMessages;
static TestMessageWrap *Message(NSString *from,NSString *to,NSUInteger identity,NSTimeInterval created){
    TestMessageWrap *wrap=[TestMessageWrap new];wrap.m_nsFromUsr=from;wrap.m_nsToUsr=to;wrap.m_nsContent=@"synthetic body";
    wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=(unsigned int)identity;wrap.m_uiCreateTime=(unsigned int)created;return wrap;
}
static void DrainMain(void){for(NSUInteger i=0;i<4;i++)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];}

static NSMutableDictionary *keys;
#define CHECK(c) do{checks++;if(!(c)){NSLog(@"FAIL %d %s",__LINE__,#c);exit(1);}}while(0)
static void WaitFor(BOOL(^condition)(void)){NSDate *limit=[NSDate dateWithTimeIntervalSinceNow:5];while(!condition() && [limit timeIntervalSinceNow]>0)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.005]];CHECK(condition());}
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
- (id)getContactByName:(NSString *)name{if(insideBackgroundSyncRequest)nativeGetterReadsInObservedRequest++;if(duringContactLookup){dispatch_block_t action=duringContactLookup;duringContactLookup=nil;action();}if([name isEqual:@"missing"] || [name isEqual:@"missing@chatroom"])return nil;TestContact *contact=[TestContact new];contact.m_nsUsrName=name;return contact;}
@end
@implementation CSMessageNativeEnvironment
- (NSString *)currentAccountID{if(insideBackgroundSyncRequest)nativeGetterReadsInObservedRequest++;if(duringAccountLookup){dispatch_block_t action=duringAccountLookup;duringAccountLookup=nil;action();}return account;}
- (id)serviceNamed:(NSString *)name{if([name isEqual:@"NewSyncService"])return nativeSyncService;return [name isEqual:@"CMessageMgr"]?nativeMessages:[TestContacts new];}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static id value;static dispatch_once_t once;dispatch_once(&once,^{value=[self new];});return value;}
- (BOOL)isAuthorized{if(insideBackgroundSyncRequest)nativeGetterReadsInObservedRequest++;return authorized;}
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
static BOOL deferCredentialReads;
static NSMutableArray<CSAICompletion> *credentialCallbacks;
static NSMutableArray<TestCancellation *> *credentialTasks;
id<CSAICancellable> CSAIReadCredentialAsync(NSString *owner,NSString *revision,CSAICompletion completion){
    CHECK(NSThread.isMainThread);TestCancellation *task=[TestCancellation new];
    if(deferCredentialReads){[credentialCallbacks addObject:[completion copy]];[credentialTasks addObject:task];}
    else completion(CSAIReadCredential(owner,revision,NULL),nil);
    return task;
}
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
@property NSUInteger loadRequests;
@end
@implementation TestStore
- (void)loadWithCompletion:(CSAIReplyStoreCompletion)completion {self.loadRequests++;[super loadWithCompletion:completion];}
- (BOOL)saveConfiguration:(NSDictionary *)config error:(NSError **)error{if(self.failSave){if(error)*error=CSAIError(99,@"test disk write denied");return NO;}return [super saveConfiguration:config error:error];}
- (void)saveConfiguration:(NSDictionary *)config expectedConfiguration:(NSDictionary *)expected completion:(CSAIReplyStoreCompletion)completion {if(self.failSave){dispatch_async(dispatch_get_main_queue(),^{completion(NO,CSAIError(99,@"test disk write denied"));});return;}[super saveConfiguration:config expectedConfiguration:expected completion:completion];}
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
    __block NSTimeInterval clock=1000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];[manager notify];
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
    __block NSTimeInterval clock=2000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];[manager notify];
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
    __block NSTimeInterval clock=3000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];[manager notify];
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
    TestClient *client=[TestClient new];CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;coordinator.now=^{return 5000.0;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];[manager notify];
    TestAdmissionWrap *wrap=[TestAdmissionWrap new];wrap.m_nsFromUsr=@"friend";wrap.m_nsToUsr=account;wrap.m_nsContent=@"ordinary text";wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=1;wrap.m_uiCreateTime=5000;
    for(NSUInteger i=0;i<1000;i++)[manager receiveNativeSession:i%2?@"disabled@chatroom":@"unconfigured" wrap:wrap epoch:epoch];
    CHECK(!wrap.identityReads && !coordinator.pendingCount && !client.callbacks.count);
    // Empty/non-string session fallback still derives and validates the conversation from the wrap.
    [manager receiveNativeSession:@"" wrap:wrap epoch:epoch];CHECK(wrap.identityReads==1 && coordinator.pendingCount==1);
    wrap.m_uiMesLocalID=2;[manager receiveNativeSession:@42 wrap:wrap epoch:epoch];CHECK(wrap.identityReads==2 && coordinator.pendingCount==1);
    wrap.m_uiMesLocalID=3;[manager receiveNativeSession:@"friend" wrap:wrap epoch:epoch];CHECK(wrap.identityReads==3 && coordinator.pendingCount==1);
    [coordinator cancelAll];config[@"enabled"]=@NO;CHECK([store saveConfiguration:config error:NULL]);[manager receiveNativeSession:@"friend" wrap:wrap epoch:epoch];CHECK(wrap.identityReads==3 && !coordinator.pendingCount);
}
static void IngressAdmissionFastPath(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@NO;config[@"imageEnabled"]=@YES;
    config[@"endpoint"]=@"https://example.invalid/chat";config[@"model"]=@"fake-model";config[@"credentialRevision"]=@"ingress";
    config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);config[@"conversations"]=@{@"room@chatroom":@{@"enabled":@YES,@"presetID":@""},@"disabled@chatroom":@{@"enabled":@NO,@"presetID":@""}};
    CHECK([store saveConfiguration:config error:NULL]);
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:nil forKey:@"coordinator"];[manager refresh];
    TestAdmissionWrap *wrap=[TestAdmissionWrap new];wrap.m_nsFromUsr=@"room@chatroom";wrap.m_nsToUsr=account;wrap.m_nsRealChatUsr=@"member";
    wrap.m_nsContent=@"ordinary group text";wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=1;wrap.m_uiCreateTime=5000;
    NSUInteger before=hookMainDispatches,originalBefore=nativeIncomingCalls;CHECK(!CSAIReplyMessageIngressEnabled());
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{for(NSUInteger i=0;i<1000;i++)[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:wrap];});
    CHECK(hookMainDispatches==before && nativeIncomingCalls==originalBefore+1000 && !wrap.typeReads && !wrap.identityReads && !wrap.bodyReads);DrainMain();
    config[@"enabled"]=@YES;CHECK([store saveConfiguration:config error:NULL]);[manager refresh];CHECK(CSAIReplyMessageIngressEnabled());
    backupReady=NO;[manager notify];CHECK(!CSAIReplyMessageIngressEnabled());backupReady=YES;
    suspended=YES;[manager notify];CHECK(!CSAIReplyMessageIngressEnabled());suspended=NO;[manager notify];CHECK(CSAIReplyMessageIngressEnabled());
    // A globally enabled AI must not enqueue messages from disabled/unconfigured
    // sessions. Exercise the actual installed ingress, keeping native reception.
    before=hookMainDispatches;originalBefore=nativeIncomingCalls;
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{for(NSUInteger i=0;i<1000;i++)[nativeMessages AsyncOnAddMsg:i%2?@"disabled@chatroom":@"unconfigured" MsgWrap:wrap];});
    CHECK(hookMainDispatches==before && nativeIncomingCalls==originalBefore+1000 && !wrap.typeReads && !wrap.identityReads && !wrap.bodyReads);
    CHECK(CSAIReplyMessageIngressAllowsSession(@"room@chatroom",epoch));
    CHECK(!CSAIReplyMessageIngressAllowsSession(@"room@chatroom",epoch+1));
    CHECK(CSAIReplyMessageIngressAllowsSession(@"",epoch) && CSAIReplyMessageIngressAllowsSession(@42,epoch) && CSAIReplyMessageIngressAllowsSession(nil,epoch));
    epoch++;CHECK(!CSAIReplyMessageIngressAllowsSession(@"room@chatroom",epoch-1));epoch--;
    __block atomic_uint admissionFailures;atomic_init(&admissionFailures,0);
    dispatch_apply(1000,dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^(size_t index){
        (void)index;if(CSAIReplyMessageIngressAllowsSession(@"disabled@chatroom",epoch) || !CSAIReplyMessageIngressAllowsSession(@"room@chatroom",epoch))atomic_fetch_add(&admissionFailures,1);
    });CHECK(!atomic_load(&admissionFailures));
    // Configuration replacement updates the immutable admission projection in
    // both directions. Unknown session shapes still reach main validation.
    config[@"conversations"]=@{@"room@chatroom":@{@"enabled":@YES,@"presetID":@""},@"disabled@chatroom":@{@"enabled":@YES,@"presetID":@""}};
    CHECK([manager saveConfiguration:config account:account epoch:epoch error:NULL]);CHECK(CSAIReplyMessageIngressAllowsSession(@"disabled@chatroom",epoch));
    config[@"conversations"]=@{@"room@chatroom":@{@"enabled":@YES,@"presetID":@""},@"disabled@chatroom":@{@"enabled":@NO,@"presetID":@""}};
    CHECK([manager saveConfiguration:config account:account epoch:epoch error:NULL]);CHECK(!CSAIReplyMessageIngressAllowsSession(@"disabled@chatroom",epoch));
    CSAIReplyCoordinator *coordinator=[manager valueForKey:@"coordinator"];TestImages *images=[TestImages new];coordinator.imagePreparer=images;coordinator.now=^{return 5000.0;};[coordinator configurationDidChange];
    // Enabled ingress still transfers native parsing to main; ordinary unmentioned
    // text never reads the body or builds IDs. The empty-session fallback agrees.
    before=hookMainDispatches;dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:wrap];});
    CHECK(hookMainDispatches==before+1 && !wrap.typeReads);DrainMain();
    before=hookMainDispatches;[nativeMessages AsyncOnAddMsg:@"" MsgWrap:wrap];[nativeMessages AsyncOnAddMsg:@42 MsgWrap:wrap];[nativeMessages AsyncOnAddMsg:nil MsgWrap:wrap];
    CHECK(hookMainDispatches==before+3);DrainMain();
    for(NSUInteger i=0;i<1000;i++)[manager receiveNativeSession:@"" wrap:wrap epoch:epoch];
    CHECK(!wrap.bodyReads && !wrap.identifierReads && !wrap.readOffMain && !coordinator.pendingCount);
    // Images stay staged, including a later native server alias, then attach to
    // a same-sender mention. No untriggered image is durably claimed or prepared.
    wrap.m_uiMessageType=3;[manager receiveNativeSession:@"room@chatroom" wrap:wrap epoch:epoch];wrap.m_n64MesSvrID=99;
    [manager receiveNativeSession:@"room@chatroom" wrap:wrap epoch:epoch];CHECK(!coordinator.pendingCount && !images.event && ![store hasHandledMessageID:@"alice|room@chatroom|s:99"]);
    TestMessageWrap *mention=Message(@"room@chatroom",account,2,5000);mention.m_nsRealChatUsr=@"member";mention.m_nsAtUserList=account;
    [manager receiveNativeSession:@"room@chatroom" wrap:mention epoch:epoch];DrainMain();
    CHECK(coordinator.pendingCount==1 && [store hasHandledMessageID:@"alice|room@chatroom|l:1:5000"] && [store hasHandledMessageID:@"alice|room@chatroom|s:99"]);
    mention.m_n64MesSvrID=100;[manager receiveNativeSession:@"room@chatroom" wrap:mention epoch:epoch];DrainMain();
    CHECK(coordinator.pendingCount==1 && [store hasHandledMessageID:@"alice|room@chatroom|s:100"]);
    // A queued old-epoch callback cannot parse native data after account change.
    NSUInteger reads=wrap.typeReads;[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:wrap];epoch++;DrainMain();CHECK(wrap.typeReads==reads);epoch--;
    [coordinator cancelAll];config[@"enabled"]=@NO;CHECK([manager saveConfiguration:config account:account epoch:epoch error:NULL]);CHECK(!CSAIReplyMessageIngressEnabled());
    before=hookMainDispatches;[nativeMessages AsyncOnAddMsg:@"room@chatroom" MsgWrap:wrap];CHECK(hookMainDispatches==before);
    [manager setValue:nil forKey:@"store"];[manager notify];CHECK(!CSAIReplyMessageIngressEnabled());
}
static NSTimer *SyncTimer(CSAIBackgroundSync *scheduler){return [scheduler valueForKey:@"timer"];}
static void FireSync(CSAIBackgroundSync *scheduler){[SyncTimer(scheduler) fire];}
static void BackgroundSyncReplies(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/chat";config[@"model"]=@"fake-model";
    config[@"credentialRevision"]=@"background-replies";keys[@[account,@"background-replies"]]=@"fake-key";config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);
    config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""},@"room@chatroom":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES},@"other@chatroom":@{@"enabled":@YES,@"presetID":@""}};CHECK([store saveConfiguration:config error:NULL]);NSDictionary *original=store.configuration;
    CSAIReplyManager *manager=CSAIReplyManager.sharedManager;TestClient *client=[TestClient new];[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;__block NSTimeInterval messageClock=4000;coordinator.now=^{return messageClock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];[manager notify];
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
    syncClock=4044;FireSync(scheduler);CHECK(service.syncCalls==1);syncClock=4045;FireSync(scheduler);DrainMain();CHECK(service.syncCalls==2 && !coordinator.pendingCount && client.callbacks.count==1 && submissions==1);service.didSynchronize=nil;
    CHECK([store.configuration isEqual:original]); // No mute, audio or AI preference is rewritten by a sync.
    // WillEnterForeground stops immediately even while UIKit still reports Background.
    NSTimer *old=SyncTimer(scheduler);[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];CHECK(!scheduler.active && !old.valid);[manager refresh];CHECK(!scheduler.active);
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];DrainMain();CHECK(!scheduler.active);
    syncClock=4090;UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];DrainMain();CHECK(scheduler.active && service.syncCalls==3);
    // A queued background refresh must not override a newer foreground transition.
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];CHECK(!scheduler.active);DrainMain();CHECK(!scheduler.active && service.syncCalls==3);
    syncClock=4135;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];DrainMain();CHECK(scheduler.active && service.syncCalls==4);
    backgroundAudioActive=NO;[NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:nil];DrainMain();CHECK(!scheduler.active);syncClock=4180;[old fire];CHECK(service.syncCalls==4);backgroundAudioActive=YES;
    [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:nil];DrainMain();CHECK(scheduler.active && service.syncCalls==5);
    // Each eligibility requirement independently closes the scheduler without switching the test store.
    for(NSUInteger gate=0;gate<19;gate++){
        [scheduler stop];syncClock+=45;NSMutableDictionary *disabled=[original mutableCopy];
        if(gate==4)disabled[@"enabled"]=@NO;
        if(gate==5 || gate==6){NSMutableDictionary *items=[disabled[@"conversations"] mutableCopy];NSMutableDictionary *room=[items[@"room@chatroom"] mutableCopy];room[gate==5?@"enabled":@"allowUnmentioned"]=@NO;items[@"room@chatroom"]=room;disabled[@"conversations"]=items;}
        if(gate==7)disabled[@"verifiedConnection"]=@"";if(gate==8)disabled[@"verifiedConnection"]=@"stale";
        if(gate>=9 && gate<=11){disabled[gate==9?@"credentialRevision":gate==10?@"endpoint":@"model"]=@"";disabled[@"verifiedConnection"]=CSAIConnectionIdentifier(disabled);}
        if(gate==12)disabled[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES}};
        if(gate==13)disabled[@"conversations"]=@{@"missing@chatroom":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES}};
        CHECK([store saveConfiguration:disabled error:NULL]);
        if(gate==0)UIApplication.sharedApplication.applicationState=UIApplicationStateActive;if(gate==1)UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;
        if(gate==2)backgroundAudioActive=NO;if(gate==3)authorized=NO;if(gate==14)epoch++;if(gate==15)account=@"bob";if(gate==16)suspended=YES;if(gate==17)backupReady=NO;if(gate==18)[store setValue:@NO forKey:@"snapshotReady"];
        NSUInteger before=service.syncCalls;[scheduler refresh];CHECK(!scheduler.active && service.syncCalls==before);
        UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;backgroundAudioActive=YES;authorized=YES;epoch=7;account=@"alice";suspended=NO;backupReady=YES;[store setValue:@YES forKey:@"snapshotReady"];
        CHECK([store saveConfiguration:original error:NULL]);[scheduler refresh];DrainMain();CHECK(scheduler.active && service.syncCalls==before+1);
    }
    // Native busy and rejected attempts consume the same 45-second budget.
    NSUInteger before=service.syncCalls,busyChecks=service.busyChecks;syncClock+=45;service.busy=YES;FireSync(scheduler);CHECK(service.syncCalls==before && service.busyChecks==busyChecks+1);service.busy=NO;FireSync(scheduler);CHECK(service.syncCalls==before && service.busyChecks==busyChecks+1);
    syncClock+=45;service.accepts=NO;FireSync(scheduler);CHECK(service.syncCalls==before+1);FireSync(scheduler);CHECK(service.syncCalls==before+1);service.accepts=YES;
    service.throwBusy=YES;syncClock+=45;FireSync(scheduler);CHECK(service.syncCalls==before+1);service.throwBusy=NO;FireSync(scheduler);CHECK(service.syncCalls==before+1);
    service.throwSync=YES;syncClock+=45;FireSync(scheduler);CHECK(service.syncCalls==before+2);service.throwSync=NO;FireSync(scheduler);CHECK(service.syncCalls==before+2);
    // Revalidate immediately after a native boundary that can revoke authorization.
    service.afterBusyCheck=^{authorized=NO;};syncClock+=45;FireSync(scheduler);CHECK(service.syncCalls==before+2);service.afterBusyCheck=nil;authorized=YES;FireSync(scheduler);CHECK(service.syncCalls==before+2);
    // A contact lookup can reenter account switching while the old service is retained.
    CSAIReplyStore *nextStore=[[CSAIReplyStore alloc]initWithURL:[[url URLByDeletingLastPathComponent]URLByAppendingPathComponent:@"background-bob.plist"] account:@"bob"];CHECK([nextStore load]);CHECK([nextStore saveConfiguration:original error:NULL]);DrainMain();
    service.afterBusyCheck=^{duringContactLookup=^{account=@"bob";epoch++;[manager setValue:nextStore forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];};};
    syncClock+=45;FireSync(scheduler);CHECK(service.syncCalls==before+2 && [account isEqual:@"bob"]);service.afterBusyCheck=nil;duringContactLookup=nil;account=@"alice";epoch=7;[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];
    // Missing and mismatched methods are ignored before invoking either method.
    TestWrongBusyReturn *badBusy=[TestWrongBusyReturn new];nativeSyncService=badBusy;syncClock+=45;FireSync(scheduler);CHECK(!badBusy.calls);
    TestWrongSyncReturn *badSync=[TestWrongSyncReturn new];nativeSyncService=badSync;syncClock+=45;FireSync(scheduler);CHECK(!badSync.calls);
    nativeSyncService=[NSObject new];syncClock+=45;FireSync(scheduler);nativeSyncService=nil;syncClock+=45;FireSync(scheduler);CHECK(service.syncCalls==before+2);
    TestBoolNativeSync *boolean=[TestBoolNativeSync new];nativeSyncService=boolean;syncClock+=45;FireSync(scheduler);CHECK(boolean.calls==1); // B as well as platform BOOL/c encodings.
    MMServiceWrapper *wrapper=[MMServiceWrapper alloc];wrapper.target=service;nativeSyncService=wrapper;syncClock+=45;FireSync(scheduler);CHECK(wrapper.forwards==0 && service.syncCalls==before+2);
    objc_setAssociatedObject(wrapper,CSNativeServiceClassKey,TestNativeSync.class,OBJC_ASSOCIATION_RETAIN_NONATOMIC);syncClock+=45;FireSync(scheduler);CHECK(wrapper.forwards==2 && service.syncCalls==before+3);
    nativeSyncService=service;[coordinator cancelAll];[scheduler stop];[NSNotificationCenter.defaultCenter removeObserver:manager];UIApplication.sharedApplication.applicationState=UIApplicationStateActive;backgroundAudioActive=NO;simulateSends=NO;nativeSyncService=nil;SetPrivacy(YES,YES,YES);CHECK([store.configuration isEqual:original]);
}
static CSAIReplyManager *BackgroundSyncContextManager(NSURL *url,TestStore **result){
    TestStore *store=[[TestStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;
    config[@"endpoint"]=@"https://example.invalid/chat";config[@"model"]=@"fake-model";config[@"credentialRevision"]=@"context-fixture";
    config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);
    config[@"conversations"]=@{@"room@chatroom":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES}};
    CHECK([store saveConfiguration:config error:NULL]);
    CSAIReplyManager *manager=[CSAIReplyManager new];[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];
    [manager setValue:[TestClient new] forKey:@"client"];*result=store;return manager;
}
static BOOL HasVerifiedSync(CSAIBackgroundSync *scheduler){return [[scheduler valueForKey:@"verifiedSync"] boolValue];}
static void BackgroundSyncContexts(NSURL *root){
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;backgroundAudioActive=YES;SetPrivacy(YES,YES,YES);
    TestStore *store=nil;CSAIReplyManager *manager=BackgroundSyncContextManager([root URLByAppendingPathComponent:@"sync-context-valid.plist"],&store);
    CSAIBackgroundSync *scheduler=[manager valueForKey:@"backgroundSync"];__block NSTimeInterval clock=10000;scheduler.now=^{return clock;};
    TestNativeSync *service=[TestNativeSync new];service.accepts=YES;nativeSyncService=service;
    CHECK(![manager captureBackgroundSyncContextForEpoch:epoch]);[manager refresh];CHECK(scheduler.active && service.syncCalls==1 && !HasVerifiedSync(scheduler));
    CHECK(![manager captureBackgroundSyncContextForEpoch:epoch+1]);
    clock=10010;id context=[manager captureBackgroundSyncContextForEpoch:epoch];CHECK(context && !HasVerifiedSync(scheduler));
    dispatch_semaphore_t offMain=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{CHECK(!NSThread.isMainThread && ![manager captureBackgroundSyncContextForEpoch:epoch]);[manager nativeFullSyncCompletedWithContext:context];dispatch_semaphore_signal(offMain);});
    CHECK(dispatch_semaphore_wait(offMain,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0);
    CHECK(!HasVerifiedSync(scheduler));[manager nativeFullSyncCompletedWithContext:[NSObject new]];CHECK(!HasVerifiedSync(scheduler));
    CSAIReplyManager *other=[CSAIReplyManager new];[other nativeFullSyncCompletedWithContext:context];CHECK(!HasVerifiedSync(scheduler));
    duringContactLookup=^{[manager nativeFullSyncCompletedWithContext:context];};
    clock=10020;[manager nativeFullSyncCompletedWithContext:context];CHECK(HasVerifiedSync(scheduler) && [[scheduler valueForKey:@"lastVerifiedSync"] doubleValue]==clock);
    clock=10030;[manager nativeFullSyncCompletedWithContext:context];CHECK([[scheduler valueForKey:@"lastVerifiedSync"] doubleValue]==10020);
    clock=10045;FireSync(scheduler);CHECK(service.syncCalls==1);clock=10064;FireSync(scheduler);CHECK(service.syncCalls==1);
    clock=10065;FireSync(scheduler);CHECK(service.syncCalls==2);
    context=[manager captureBackgroundSyncContextForEpoch:epoch];CHECK(context);[scheduler stop];clock=10070;
    [manager nativeFullSyncCompletedWithContext:context];CHECK(!scheduler.active && [[scheduler valueForKey:@"lastVerifiedSync"] doubleValue]==10020);
    // Ordinary messages, accepted native starts and busy native attempts do not
    // establish complete coverage and therefore cannot extend the deadline.
    [scheduler invalidateVerifiedSync];[manager refresh];CHECK(scheduler.active && !HasVerifiedSync(scheduler));
    CSAIReplyCoordinator *coordinator=[manager valueForKey:@"coordinator"];coordinator.now=^{return clock;};
    TestMessageWrap *message=Message(@"room@chatroom",account,123,clock);message.m_nsRealChatUsr=@"member";
    [manager receiveNativeSession:@"room@chatroom" wrap:message epoch:epoch];CHECK(!HasVerifiedSync(scheduler));[coordinator cancelAll];
    clock=10110;service.busy=YES;NSUInteger calls=service.syncCalls;FireSync(scheduler);CHECK(service.syncCalls==calls && !HasVerifiedSync(scheduler));
    clock=10154;service.busy=NO;FireSync(scheduler);CHECK(service.syncCalls==calls);clock=10155;FireSync(scheduler);CHECK(service.syncCalls==calls+1 && !HasVerifiedSync(scheduler));[scheduler stop];
    // Every fixture starts with the same account, epoch, configuration and one
    // accepted attempt; each mutation independently invalidates the old scope.
    for(NSUInteger variant=0;variant<22;variant++){
        NSURL *url=[root URLByAppendingPathComponent:[NSString stringWithFormat:@"sync-context-%lu.plist",(unsigned long)variant]];
        manager=BackgroundSyncContextManager(url,&store);scheduler=[manager valueForKey:@"backgroundSync"];
        clock=20000;scheduler.now=^{return clock;};service=[TestNativeSync new];service.accepts=YES;nativeSyncService=service;[manager refresh];
        CHECK(scheduler.active && service.syncCalls==1);clock=20010;context=[manager captureBackgroundSyncContextForEpoch:epoch];CHECK(context);
        NSDictionary *original=store.configuration;
        CSAIReplyStore *replacement=nil;
        if(variant==0 || variant==11 || variant==20 || variant==21){
            replacement=[[CSAIReplyStore alloc]initWithURL:[root URLByAppendingPathComponent:[NSString stringWithFormat:@"sync-context-replacement-%lu.plist",(unsigned long)variant]] account:variant==21?@"bob":account];
            CHECK([replacement load] && [replacement saveConfiguration:original error:NULL]);
        }
        if(variant==0)[manager setValue:replacement forKey:@"store"];
        if(variant==1)CHECK([store saveConfiguration:original error:NULL]); // Equal values, new immutable snapshot.
        if(variant==2)account=@"bob";
        if(variant==3){epoch++;[manager setValue:@(epoch) forKey:@"epoch"];}
        if(variant==4){NSMutableDictionary *changed=[original mutableCopy];changed[@"enabled"]=@NO;CHECK([store saveConfiguration:changed error:NULL]);}
        if(variant==5)authorized=NO;
        if(variant==6)UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
        if(variant==7)backgroundAudioActive=NO;
        if(variant==8)suspended=YES;
        if(variant==9)backupReady=NO;
        if(variant==10)duringContactLookup=^{CHECK([store saveConfiguration:original error:NULL]);};
        if(variant==11)duringContactLookup=^{[manager setValue:replacement forKey:@"store"];};
        if(variant==12)duringAccountLookup=^{account=@"bob";epoch++;[manager setValue:@(epoch) forKey:@"epoch"];};
        if(variant==13)duringContactLookup=^{duringContactLookup=^{CHECK([store saveConfiguration:original error:NULL]);};};
        if(variant==14){duringContactLookup=^{CHECK([store saveConfiguration:original error:NULL]);};CHECK(![manager captureBackgroundSyncContextForEpoch:epoch]);}
        if(variant>=15 && variant<=17){
            // Revoke existing healthy coverage at save *start*, even if the
            // write fails or republishes exactly the same configuration.
            [manager nativeFullSyncCompletedWithContext:context];CHECK(HasVerifiedSync(scheduler));context=[manager captureBackgroundSyncContextForEpoch:epoch];CHECK(context);
            store.failSave=variant!=16;
            if(variant==17){CHECK(![manager saveConfiguration:original account:account epoch:epoch error:NULL]);}
            else{
                __block BOOL done=NO;[manager saveConfiguration:original account:account epoch:epoch completion:^(BOOL success,NSError *error){CHECK(success==(variant==16) && (success || error));done=YES;}];
                CHECK(!done && !scheduler.active && !HasVerifiedSync(scheduler));WaitFor(^BOOL{return done;});
            }
            CHECK(!HasVerifiedSync(scheduler) && scheduler.active && service.syncCalls==1);store.failSave=NO;
        }
        if(variant==18){epoch++;} // Backup epoch alone changes before manager refresh.
        if(variant==19)duringContactLookup=^{duringContactLookup=^{authorized=NO;};};
        if(variant==20){[manager setValue:replacement forKey:@"store"];[manager notify];[manager setValue:store forKey:@"store"];[manager notify];}
        if(variant==21){
            duringAccountLookup=^{account=@"bob";epoch++;[manager setValue:replacement forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager refresh];};
            NSUInteger oldEpoch=epoch;CHECK(![manager captureBackgroundSyncContextForEpoch:oldEpoch]);
            CHECK(scheduler.active && ![manager captureBackgroundSyncContextForEpoch:oldEpoch]);
            CHECK(scheduler.active && [manager captureBackgroundSyncContextForEpoch:epoch]);
        }
        clock=20020;[manager nativeFullSyncCompletedWithContext:context];CHECK(!HasVerifiedSync(scheduler));
        clock=20030;[manager nativeFullSyncCompletedWithContext:context];CHECK(!HasVerifiedSync(scheduler));
        if(variant==15 || variant==16 || variant==17){clock=20044;FireSync(scheduler);CHECK(service.syncCalls==1);clock=20045;FireSync(scheduler);CHECK(service.syncCalls==2);}
        [scheduler stop];[[manager valueForKey:@"coordinator"] cancelAll];duringContactLookup=nil;duringAccountLookup=nil;
        account=@"alice";epoch=7;authorized=YES;suspended=NO;backupReady=YES;backgroundAudioActive=YES;UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    }
    nativeSyncService=nil;backgroundAudioActive=NO;UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
}
static void BackgroundSyncRequestReentry(NSURL *root){
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;backgroundAudioActive=YES;
    for(NSUInteger variant=0;variant<5;variant++){
        TestStore *store=nil;CSAIReplyManager *manager=BackgroundSyncContextManager([root URLByAppendingPathComponent:[NSString stringWithFormat:@"sync-request-reentry-%lu.plist",(unsigned long)variant]],&store);
        backgroundSyncObservationManager=manager;
        CSAIBackgroundSync *scheduler=[manager valueForKey:@"backgroundSync"];__block NSTimeInterval clock=30000;scheduler.now=^{return clock;};
        TestNativeSync *service=[TestNativeSync new];service.accepts=YES;nativeSyncService=service;NSDictionary *original=store.configuration;
        CSAIReplyStore *replacement=nil;
        if(variant==4){replacement=[[CSAIReplyStore alloc]initWithURL:[root URLByAppendingPathComponent:@"sync-request-replacement.plist"] account:account];CHECK([replacement load] && [replacement saveConfiguration:original error:NULL]);}
        duringBackgroundSyncObservation=^{
            if(variant==0)account=@"bob";
            if(variant==1)CHECK([store saveConfiguration:original error:NULL]);
            if(variant==2)authorized=NO;
            if(variant==3){epoch++;[manager setValue:@(epoch) forKey:@"epoch"];}
            if(variant==4)[manager setValue:replacement forKey:@"store"];
        };
        [manager refresh];CHECK(!duringBackgroundSyncObservation && !service.syncCalls && !HasVerifiedSync(scheduler));CHECK(!nativeGetterReadsInObservedRequest);
        account=@"alice";epoch=7;authorized=YES;[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager refresh];CHECK(scheduler.active && !service.syncCalls);
        clock=30044;FireSync(scheduler);CHECK(!service.syncCalls);clock=30045;FireSync(scheduler);CHECK(service.syncCalls==1);
        [scheduler stop];[[manager valueForKey:@"coordinator"] cancelAll];backgroundSyncObservationManager=nil;
    }
    nativeSyncService=nil;backgroundAudioActive=NO;UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
}
static void CapabilityAndImageIntegration(NSURL *url){
    CSAIReplyStore *store=[[CSAIReplyStore alloc]initWithURL:url account:account];CHECK([store load]);
    NSMutableDictionary *config=[store.configuration mutableCopy];config[@"enabled"]=@YES;config[@"endpoint"]=@"https://example.invalid/v1/chat/completions";config[@"model"]=@"qwen3.8-flash";
    config[@"credentialRevision"]=@"image-integration";keys[@[account,@"image-integration"]]=@"synthetic-key";config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""}};CHECK([store saveConfiguration:config error:NULL]);
    CSAIReplyManager *manager=[CSAIReplyManager new];TestClient *client=[TestClient new];TestImages *images=[TestImages new];
    [manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;coordinator.imagePreparer=images;
    __block NSTimeInterval clock=7000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];[manager notify];
    TestAdmissionWrap *off=[TestAdmissionWrap new];off.m_uiMessageType=3;[manager receiveNativeSession:@"friend" wrap:off epoch:epoch];CHECK(!off.identityReads && !images.event && off.typeReads==1);
    off.m_uiMessageType=1;off.m_nsFromUsr=@"friend";off.m_nsToUsr=account;off.m_nsContent=@"synthetic text";off.m_uiMesLocalID=66;off.m_uiCreateTime=(unsigned int)clock;off.typeReads=0;
    [manager receiveNativeSession:@"friend" wrap:off epoch:epoch];CHECK(off.typeReads==1 && coordinator.pendingCount==1);DrainMain();[coordinator cancelAll];
    __block NSUInteger completions=0;__block NSError *failure=nil;
    [manager testConnectionForAccount:account epoch:epoch completion:^(NSString *text,NSError *error){(void)text;completions++;failure=error;}];
    TestCancellation *oldTask=client.tasks.lastObject;CSAICompletion oldCallback=client.callbacks.lastObject;
    oldTask.onCancel=^{oldCallback(@"late inline old success",nil);};
    config=[store.configuration mutableCopy];config[@"provider"]=@"bailian";config[@"imageEnabled"]=@YES;config[@"searchMode"]=@"auto";config[@"thinkingEnabled"]=@NO;
    CHECK([manager saveConfiguration:config account:account epoch:epoch error:NULL]);CHECK(oldTask.cancelled && failure.code==22 && completions==1);CHECK(!manager.connectionStatus && ![store.configuration[@"verifiedConnection"] length]);
    CHECK([store.configuration[@"endpoint"] isEqual:@"https://example.invalid/v1/chat/completions"] && [store.configuration[@"credentialRevision"] isEqual:@"image-integration"]);
    client.inlineCompletion=YES;[manager testConnectionForAccount:account epoch:epoch completion:^(NSString *text,NSError *error){CHECK(text.length && !error);completions++;}];client.inlineCompletion=NO;DrainMain();
    CHECK([client.lastMessages[0][@"content"] isKindOfClass:NSArray.class]);NSArray *parts=client.lastMessages[0][@"content"];CHECK(parts.count==2 && [parts[0][@"image_url"][@"url"] hasPrefix:@"data:image/png;base64,"]);
    CHECK([client.lastConfiguration[@"provider"] isEqual:@"bailian"] && [client.lastConfiguration[@"searchMode"] isEqual:@"auto"]);
    CHECK(![manager valueForKey:@"connectionTest"] && [store.configuration[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(store.configuration)]);
    client.callbacks.lastObject(@"duplicate inline completion",nil);CHECK(completions==2);
    TestMessageWrap *wrap=Message(@"friend",account,77,clock);wrap.m_uiMessageType=3;wrap.m_nsContent=@"";[manager receiveNativeSession:@"friend" wrap:wrap epoch:epoch];DrainMain();
    CHECK(coordinator.pendingCount==1 && !images.event && [store hasHandledMessageID:@"alice|friend|l:77:7000"]);clock+=2;[coordinator processPending];
    CHECK([images.event[@"epoch"] isEqual:@(epoch)] && images.event[@"imageSource"]==wrap && coordinator.activeCount==1);
    BOOL (^valid)(void)=images.event[@"imageStillValid"];CHECK(valid());NSUInteger requests=client.callbacks.count;
    config=[store.configuration mutableCopy];config[@"searchMode"]=@"always";CHECK([manager saveConfiguration:config account:account epoch:epoch error:NULL]);
    CHECK(images.task.cancelled && !valid() && !coordinator.activeCount && !manager.connectionStatus && ![store.configuration[@"verifiedConnection"] length]);
    images.completion(@"data:image/jpeg;base64,AQ==",nil);CHECK(client.callbacks.count==requests);
    [coordinator cancelAll];
}
static void AsyncManagerMutations(NSURL *url){
    TestStore *store=[[TestStore alloc]initWithURL:url account:account];CHECK([store load]);
    CSAIReplyManager *manager=[CSAIReplyManager new];TestClient *client=[TestClient new];
    [manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
    // refresh loads the established isolated file once, without a blocking load or a new checkout/path.
    store=[[TestStore alloc]initWithURL:url account:account];[manager setValue:store forKey:@"store"];
    [manager refresh];CHECK([[manager valueForKey:@"loadingStore"] boolValue]);[manager refresh];CHECK(store.loadRequests==1);
    WaitFor(^BOOL{return store.ready && ![[manager valueForKey:@"loadingStore"] boolValue];});
    NSString *endpoint=@"https://example.invalid/v1/chat/completions";__block BOOL done=NO;__block NSError *failure=nil;
    [manager saveConnection:endpoint model:@"async-model" key:@"async-key" account:account epoch:epoch completion:^(BOOL ok,NSError *error){CHECK(ok && !error && NSThread.isMainThread);done=YES;}];CHECK(!done);WaitFor(^BOOL{return done;});
    NSString *revision=store.configuration[@"credentialRevision"];CHECK([CSAIReadCredential(account,revision,NULL) isEqual:@"async-key"]);
    __block NSUInteger completions=0;
    [manager testConnectionForAccount:account epoch:epoch completion:^(NSString *text,NSError *error){CHECK(text.length && !error);CHECK([store.configuration[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(store.configuration)]);completions++;}];
    client.callbacks.lastObject(@"async verified",nil);CHECK(!completions);WaitFor(^BOOL{return completions==1;});
    done=NO;[manager setConversation:@"friend" enabled:YES presetID:@"" account:account epoch:epoch completion:^(BOOL ok,NSError *error){CHECK(ok && !error);done=YES;}];WaitFor(^BOOL{return done;});
    NSMutableDictionary *configuration=[store.configuration mutableCopy];configuration[@"enabled"]=@YES;
    done=NO;[manager saveConfiguration:configuration account:account epoch:epoch completion:^(BOOL ok,NSError *error){CHECK(ok && !error);done=YES;}];WaitFor(^BOOL{return done;});
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:client];coordinator.delegate=(id)manager;
    __block NSTimeInterval clock=9000;coordinator.now=^{return clock;};[coordinator configurationDidChange];[manager setValue:coordinator forKey:@"coordinator"];[manager notify];
    [manager receiveNativeSession:@"friend" wrap:Message(@"friend",account,1,clock) epoch:epoch];DrainMain();clock+=2;[coordinator processPending];CHECK(coordinator.activeCount==1);
    TestCancellation *active=client.tasks.lastObject;CSAICompletion late=client.callbacks.lastObject;
    configuration=[store.configuration mutableCopy];configuration[@"enabled"]=@NO;
    done=NO;[manager saveConfiguration:configuration account:account epoch:epoch completion:^(BOOL ok,NSError *error){CHECK(ok && !error);done=YES;}];
    CHECK(active.cancelled && !coordinator.activeCount && ![coordinator.delegate coordinator:coordinator allowsConversation:@"friend"]);
    __block BOOL rejectedOverlap=NO;[manager saveConfiguration:configuration account:account epoch:epoch completion:^(BOOL ok,NSError *error){CHECK(!ok && error);rejectedOverlap=YES;}];CHECK(rejectedOverlap);
    late(@"cancelled reply",nil);WaitFor(^BOOL{return done;});CHECK(![store.configuration[@"enabled"] boolValue]);
    // A confirmed failure retains the previous configuration and cleans a newly staged Keychain slot.
    NSUInteger keyCount=keys.count;NSDictionary *before=store.configuration;store.failSave=YES;done=NO;
    [manager saveConnection:endpoint model:@"failed-async" key:@"failed-key" account:account epoch:epoch completion:^(BOOL ok,NSError *error){CHECK(!ok && error.code==99);failure=error;done=YES;}];WaitFor(^BOOL{return done;});
    CHECK(failure && [store.configuration isEqual:before] && keys.count==keyCount);store.failSave=NO;
    // Directory-fsync uncertainty retains the new credential actually named by the replacement file.
    failDirectorySync=YES;done=NO;
    [manager saveConnection:endpoint model:@"uncertain-async" key:@"uncertain-key" account:account epoch:epoch completion:^(BOOL ok,NSError *error){CHECK(!ok && [error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue]);done=YES;}];WaitFor(^BOOL{return done;});failDirectorySync=NO;
    CHECK(!store.ready && keys.count==keyCount+1);CHECK([store load]);revision=store.configuration[@"credentialRevision"];
    CHECK([store.configuration[@"model"] isEqual:@"uncertain-async"] && [CSAIReadCredential(account,revision,NULL) isEqual:@"uncertain-key"]);
    // Switching accounts after rename-bound IO began must not delete an already referenced credential.
    resumeFsync=dispatch_semaphore_create(0);atomic_store(&pauseNextFsync,true);done=NO;
    [manager saveConnection:endpoint model:@"old-account-async" key:@"old-account-key" account:account epoch:epoch completion:^(BOOL ok,NSError *error){CHECK(!ok && [error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue]);done=YES;}];
    WaitFor(^BOOL{return atomic_load(&ioPaused);});NSUInteger oldEpoch=epoch;NSString *oldAccount=account;account=@"bob";epoch++;
    [store invalidate];[manager setValue:nil forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];dispatch_semaphore_signal(resumeFsync);
    CSAIReplyStore *next=[[CSAIReplyStore alloc]initWithURL:[[url URLByDeletingLastPathComponent]URLByAppendingPathComponent:@"async-bob.plist"] account:account];CHECK([next load]);[manager setValue:next forKey:@"store"];WaitFor(^BOOL{return done;});
    NSDictionary *written=[CSAIReplyStore readStateAtURL:url account:oldAccount error:NULL];revision=written[@"configuration"][@"credentialRevision"];
    CHECK([written[@"configuration"][@"model"] isEqual:@"old-account-async"] && [CSAIReadCredential(oldAccount,revision,NULL) isEqual:@"old-account-key"]);
    CHECK(![next.configuration[@"model"] length]);account=oldAccount;epoch=oldEpoch;[next invalidate];
}
static void AsyncCredentialBoundaries(NSURL *root){
    SetPrivacy(YES,YES,YES);
    for(NSUInteger variant=0;variant<7;variant++){
        NSURL *url=[root URLByAppendingPathComponent:[NSString stringWithFormat:@"credential-%lu.plist",(unsigned long)variant]];
        TestStore *store=[[TestStore alloc]initWithURL:url account:account];CHECK([store load]);
        NSMutableDictionary *config=[store.configuration mutableCopy];config[@"endpoint"]=@"https://example.invalid/chat";config[@"model"]=@"fake-model";config[@"credentialRevision"]=@"delayed";
        config[@"enabled"]=@YES;config[@"conversations"]=@{@"friend":@{@"enabled":@YES,@"presetID":@""}};config[@"verifiedConnection"]=CSAIConnectionIdentifier(config);
        CHECK([store saveConfiguration:config error:NULL]);keys[@[account,@"delayed"]]=@"synthetic-key";
        CSAIReplyManager *manager=[CSAIReplyManager new];TestClient *client=[TestClient new];
        [manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];[manager setValue:client forKey:@"client"];
        credentialCallbacks=[NSMutableArray array];credentialTasks=[NSMutableArray array];deferCredentialReads=YES;
        __block NSUInteger completions=0;__block NSError *failure=nil;
        id<CSAICancellable> operation=[manager testConnectionForAccount:account epoch:epoch completion:^(NSString *text,NSError *error){(void)text;CHECK(NSThread.isMainThread);completions++;failure=error;}];
        CHECK(!client.callbacks.count && !completions && credentialCallbacks.count==1);
        CSAICompletion late=credentialCallbacks[0];TestCancellation *read=credentialTasks[0];
        if(variant==0){
            late(@"synthetic-key",nil);CHECK(client.callbacks.count==1 && !completions);
            late(@"synthetic-key",nil);CHECK(client.callbacks.count==1);
            [operation cancel];CHECK(client.tasks[0].cancelled && completions==1 && failure.code==NSURLErrorCancelled);
            client.callbacks[0](@"late model",nil);CHECK(completions==1 && [store.configuration[@"verifiedConnection"] isEqual:config[@"verifiedConnection"]]);
        }else if(variant==1){
            [operation cancel];CHECK(read.cancelled && completions==1 && failure.code==NSURLErrorCancelled);late(@"synthetic-key",nil);CHECK(!client.callbacks.count && completions==1);
        }else if(variant==2){
            CHECK([manager saveConnection:config[@"endpoint"] model:@"replacement" key:@"replacement-key" account:account epoch:epoch error:NULL]);
            CHECK(read.cancelled && completions==1 && failure.code==22);late(@"synthetic-key",nil);CHECK(!client.callbacks.count && completions==1);
        }else if(variant==3){
            NSString *oldAccount=account;NSUInteger oldEpoch=epoch;account=@"bob";epoch++;
            late(@"synthetic-key",nil);CHECK(!client.callbacks.count && completions==1 && failure.code==22);account=oldAccount;epoch=oldEpoch;
        }else if(variant==4){
            [(NSTimer *)[(id)operation valueForKey:@"timer"] fire];CHECK(read.cancelled && completions==1 && failure.code==NSURLErrorTimedOut);
            late(@"synthetic-key",nil);CHECK(!client.callbacks.count && completions==1);
        }else if(variant==5){
            NSMutableDictionary *changed=[store.configuration mutableCopy];changed[@"enabled"]=@NO;CHECK([manager saveConfiguration:changed account:account epoch:epoch error:NULL]);
            late(@"synthetic-key",nil);CHECK(!client.callbacks.count && completions==1 && failure.code==22);
        }else{
            [(id)operation setValue:@0 forKey:@"deadline"];late(@"synthetic-key",nil);CHECK(!client.callbacks.count && completions==1 && failure.code==NSURLErrorTimedOut);
        }
        CHECK(![manager valueForKey:@"connectionTest"]);
        [manager invalidateConnectionTest];[store invalidate];
    }
    // The coordinator's delegate boundary revalidates even when an external
    // caller did not yet deliver account/config change notifications.
    TestStore *store=[[TestStore alloc]initWithURL:[root URLByAppendingPathComponent:@"credential-delegate.plist"] account:account];CHECK([store load]);
    CSAIReplyManager *manager=[CSAIReplyManager new];[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];
    CSAIReplyCoordinator *coordinator=[[CSAIReplyCoordinator alloc]initWithStore:store client:[TestClient new]];[manager setValue:coordinator forKey:@"coordinator"];
    for(NSUInteger variant=0;variant<4;variant++){
        credentialCallbacks=[NSMutableArray array];credentialTasks=[NSMutableArray array];__block NSString *key=nil;__block NSError *failure=nil;__block NSUInteger completions=0;
        [(id<CSAIReplyCoordinatorDelegate>)manager credentialForCoordinator:coordinator completion:^(NSString *value,NSError *error){CHECK(NSThread.isMainThread);key=value;failure=error;completions++;}];
        CHECK(!completions && credentialCallbacks.count==1);
        NSString *oldAccount=account;NSUInteger oldEpoch=epoch;
        if(variant==1)epoch++;else if(variant==2)account=@"bob";else if(variant==3){NSMutableDictionary *config=[store.configuration mutableCopy];config[@"credentialRevision"]=@"changed";CHECK([store saveConfiguration:config error:NULL]);}
        credentialCallbacks[0](@"synthetic-key",nil);
        CHECK(completions==1 && (variant?(!key && failure.code==20):([key isEqual:@"synthetic-key"] && !failure)));
        account=oldAccount;epoch=oldEpoch;
    }
    [coordinator cancelAll];[store invalidate];deferCredentialReads=NO;credentialCallbacks=nil;credentialTasks=nil;
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
    client.callbacks[0](@"连接正常",nil);DrainMain();CHECK(!failure && result.length);CHECK([store.configuration[@"verifiedConnection"] isEqual:CSAIConnectionIdentifier(store.configuration)]);CHECK(![store.configuration[@"enabled"] boolValue]);
    // A repeated failed test revokes an earlier successful verification.
    [manager testConnectionForAccount:account epoch:epoch completion:completion];client.callbacks[1](nil,CSAIError(401,@"认证失败"));DrainMain();CHECK(failure.code==401);CHECK(![store.configuration[@"verifiedConnection"] length]);
    [manager testConnectionForAccount:account epoch:epoch completion:completion];client.callbacks[2](@"正常",nil);DrainMain();NSString *verified=store.configuration[@"verifiedConnection"];
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
    IngressAdmissionFastPath([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"ingress-admission.plist"]);
    BackgroundSyncReplies([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"background-replies.plist"]);
    BackgroundSyncContexts([url URLByDeletingLastPathComponent]);
    BackgroundSyncRequestReentry([url URLByDeletingLastPathComponent]);
    CHECK(!insideBackgroundSyncRequest && !nativeGetterReadsInObservedRequest);
    CapabilityAndImageIntegration([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"image-integration.plist"]);
    AsyncManagerMutations([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"async-manager.plist"]);
    AsyncCredentialBoundaries([url URLByDeletingLastPathComponent]);
    printf("AI reply manager: %lu checks passed\n",(unsigned long)checks);return 0;
}}
