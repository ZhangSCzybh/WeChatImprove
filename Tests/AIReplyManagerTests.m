#import <Foundation/Foundation.h>
#import "CSAIReplyManager.h"
#import "CSAIReplyCoordinator.h"
#import "CSAICredentialStore.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSCloseFriendBridge.h"
#import "CSGroupNativeBridge.h"
#import "CSAuthorizationManager.h"
#import "AINativeDispatchUnderTest.m"
#import "CSAIMessageAdapter.h"
#import "AIPreparedSendUnderTest.m"
#import "AIHooksUnderTest.m"
#import <sys/stat.h>
#import <unistd.h>
#import <errno.h>
static NSUInteger checks,epoch=7,submissions;
static NSString *account=@"alice";
static BOOL suspended,hidden,failKeyWrite,failDirectorySync,simulateSends;
static NSUInteger failedDirectorySyncs,manualSends,ownedSends;
static NSMutableArray<NSString *> *installedHooks;
static void (^duringManualSend)(void);
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
@property NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent;
@property unsigned int m_uiMessageType,m_uiMesLocalID,m_uiCreateTime;
@end
@implementation TestMessageWrap @end
@interface CMessageMgr : NSObject
- (void)AddMsg:(id)session MsgWrap:(id)wrap;
- (void)AsyncOnAddMsg:(id)session MsgWrap:(id)wrap;
@end
@implementation CMessageMgr
- (void)AddMsg:(id)session MsgWrap:(id)wrap{
    if(CSAIIsOwnedSend(wrap))ownedSends++;else {manualSends++;if(duringManualSend)duringManualSend();}
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
NSNotificationName const UIApplicationProtectedDataDidBecomeAvailable=@"test-unlocked";
NSString *const CSCloseFriendPolicyDidChangeNotification=@"test-privacy";
BOOL CSBackupIsReady(void){return YES;}
BOOL CSBackupAccountIsSuspended(void){return suspended;}
NSUInteger CSBackupAccountEpoch(void){return epoch;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger expected,void(^block)(void)){if(expected!=epoch || suspended)return NO;block();return YES;}
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface){(void)name;(void)surface;return hidden;}
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return nil;}
id CSGroupReadObject(id object,NSString *name){return CSMessageActionNativeObject(object,name);}
CSGroupRowCategory CSGroupCategoryForContact(id contact){return contact?CSGroupRowCategoryPrivate:CSGroupRowCategoryService;}
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
- (id)getContactByName:(NSString *)name{TestContact *contact=[TestContact new];contact.m_nsUsrName=name;return contact;}
@end
@implementation CSMessageNativeEnvironment
- (NSString *)currentAccountID{return account;}
- (id)serviceNamed:(NSString *)name{return [name isEqual:@"CMessageMgr"]?nativeMessages:[TestContacts new];}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static id value;static dispatch_once_t once;dispatch_once(&once,^{value=[self new];});return value;}
- (BOOL)isAuthorized{return YES;}
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
@end
@implementation TestCancellation
- (void)cancel{self.cancelled=YES;}
@end
@interface TestClient : CSAIClient
@property NSMutableArray<CSAICompletion> *callbacks;
@property NSMutableArray<TestCancellation *> *tasks;
@property NSArray *lastMessages;
@end
@implementation TestClient
- (instancetype)init{if((self=[super init])){_callbacks=[NSMutableArray array];_tasks=[NSMutableArray array];}return self;}
- (id<CSAICancellable>)generateWithConfiguration:(NSDictionary *)config apiKey:(NSString *)key messages:(NSArray *)messages completion:(CSAICompletion)completion{(void)config;(void)key;self.lastMessages=messages;[self.callbacks addObject:[completion copy]];TestCancellation *task=[TestCancellation new];[self.tasks addObject:task];return task;}
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
    hidden=YES;CHECK(![manager setConversation:@"friend" enabled:NO presetID:@"" account:account epoch:epoch error:&error]);hidden=NO;
    suspended=YES;CHECK(![manager isCurrentAccount:account epoch:epoch]);suspended=NO;
    CHECK([manager saveConnection:endpoint model:@"model-b" key:@"" account:account epoch:epoch error:&error]);CHECK(![store.configuration[@"credentialRevision"] length]);CHECK([CSAIReadCredential(account,first,NULL) isEqual:@"key-a"]);CHECK(submissions==0);
    ManualCoexistence([[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"coexistence.plist"]);
    printf("AI reply manager: %lu checks passed\n",(unsigned long)checks);return 0;
}}
