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
static NSUInteger checks,epoch=7,submissions;
static NSString *account=@"alice";
static BOOL suspended,hidden,failKeyWrite;
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
- (id)serviceNamed:(NSString *)name{(void)name;return [TestContacts new];}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static id value;static dispatch_once_t once;dispatch_once(&once,^{value=[self new];});return value;}
- (BOOL)isAuthorized{return YES;}
@end
@implementation CSMessageSendAdapter
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment{(void)environment;return [super init];}
- (CSMessagePreparedSend *)prepareScheduledText:(NSString *)text targetID:(NSString *)targetID accountID:(NSString *)accountID{(void)text;(void)targetID;(void)accountID;submissions++;return nil;}
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
    printf("AI reply manager: %lu checks passed\n",(unsigned long)checks);return 0;
}}
