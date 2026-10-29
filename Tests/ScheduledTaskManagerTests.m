#import <Foundation/Foundation.h>
#import "CSScheduledTaskManager.h"
#import "CSBackupMutation.h"
#import <stdatomic.h>
#import <sys/stat.h>
#import <unistd.h>
#import <errno.h>
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendAutomationProjection.h"
#import "CSAuthorizationManager.h"
#import "CSGroupNativeBridge.h"
#import "ScheduledNativeDispatchUnderTest.m"
#import "ScheduledSendUnderTest.m"

static atomic_uint checks;
static NSUInteger epoch=1,submissions,caseNumber;
static NSString *account=@"account", *sentTarget, *sentText;
static BOOL suspended,missingContact;
static BOOL authorized=YES;
static void (^duringPreparation)(void);
static void (^duringContactLookup)(void);
static CSCloseFriendSnapshot *privacy;
#define CHECK(...) do { checks++; if(!(__VA_ARGS__)) { NSLog(@"FAIL %d %s",__LINE__,#__VA_ARGS__);exit(1); } } while(0)
static atomic_bool blockNextFile,failNextFile;
static atomic_uint fileFlushes,directoryFlushes;
static dispatch_semaphore_t entered,resumeIO;
static NSURL *expectedDurableURL;
int CSScheduledTestFsync(int descriptor){
    CHECK(!NSThread.isMainThread);struct stat info;CHECK(fstat(descriptor,&info)==0);
    if(S_ISREG(info.st_mode)){
        atomic_fetch_add(&fileFlushes,1);
        if(atomic_exchange(&blockNextFile,false)){dispatch_semaphore_signal(entered);CHECK(dispatch_semaphore_wait(resumeIO,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0);}
        if(atomic_exchange(&failNextFile,false)){errno=EIO;return -1;}
    }else if(S_ISDIR(info.st_mode))atomic_fetch_add(&directoryFlushes,1);
    return fsync(descriptor);
}
static void Wait(BOOL(^done)(void)){NSDate *limit=[NSDate dateWithTimeIntervalSinceNow:5];while(!done() && limit.timeIntervalSinceNow>0)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.002]];CHECK(done());}
NSNotificationName const UIApplicationDidBecomeActiveNotification=@"test-active";
NSNotificationName const UIApplicationSignificantTimeChangeNotification=@"test-time";
NSString *const CSCloseFriendPolicyDidChangeNotification=@"test-privacy";
BOOL CSBackupIsReady(void){return YES;}
BOOL CSBackupAccountIsSuspended(void){return suspended;}
NSUInteger CSBackupAccountEpoch(void){return epoch;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger expected,void(^block)(void)){if(expected!=epoch || suspended)return NO;block();return YES;}
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return privacy;}
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface){return [privacy hidesUserName:name surface:surface];}
id CSGroupReadObject(id object,NSString *key){return CSMessageActionNativeObject(object,key);}
CSGroupRowCategory CSGroupCategoryForContact(id contact){NSString *name=CSGroupReadObject(contact,@"m_nsUsrName");return !name || [name isEqual:@"service"]?CSGroupRowCategoryService:[name hasSuffix:@"@chatroom"]?CSGroupRowCategoryGroup:CSGroupRowCategoryPrivate;}
static void SetPrivacy(BOOL revealed,BOOL sessions,BOOL tasks){
    privacy=[[CSCloseFriendSnapshot alloc]initWithAccountID:account profile:@{@"enabled":@YES,@"friends":@[@"friend"],@"groups":@[@"room@chatroom"],@"options":@{@"hideSessions":@(sessions),@"hideScheduledTasks":@(tasks)}} revealed:revealed revision:1 blocked:NO];
}
@interface CMessageWrap : NSObject
@property NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsClientMsgID;
@property unsigned int m_uiCreateTime,m_uiStatus,m_uiMesLocalID;
@property long long m_n64MesSvrID;
@end
@implementation CMessageWrap
- (instancetype)initWithMsgType:(long long)type{(void)type;if((self=[super init]) && duringPreparation)duringPreparation();return self;}
@end
@interface TestContact : NSObject
@property NSString *m_nsUsrName;
@end
@implementation TestContact @end
@interface TestContacts : NSObject
- (id)getContactByName:(NSString *)name;
@end
@implementation TestContacts
- (id)getContactByName:(NSString *)name{if(duringContactLookup)duringContactLookup();if(missingContact || [name isEqual:@"missing"])return nil;TestContact *contact=[TestContact new];contact.m_nsUsrName=name;return contact;}
@end
@interface CMessageMgr : NSObject
- (void)AddMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap;
@end
@implementation CMessageMgr
- (void)AddMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap{if(expectedDurableURL){NSDictionary *state=[CSScheduledTaskStore readStateAtURL:expectedDurableURL account:account error:NULL];CHECK([state[@"history"][0][@"result"] isEqual:@"submitting"]);CHECK(!CSBackupResourceWriteInProgress());}submissions++;sentTarget=target;sentText=wrap.m_nsContent;CHECK([wrap.m_nsToUsr isEqual:target] && [wrap.m_nsFromUsr isEqual:account]);}
@end
@implementation CSMessageNativeEnvironment
- (NSString *)currentAccountID{return account;}
- (id)serviceNamed:(NSString *)name{return [name isEqual:@"CMessageMgr"]?[CMessageMgr new]:[TestContacts new];}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static id manager;if(!manager)manager=[self new];return manager;}
- (BOOL)isAuthorized{return authorized;}
@end
@interface CSScheduledTaskManager (Testing)
- (void)run:(NSDictionary *)task now:(NSDate *)now;
- (NSTimeInterval)elapsedTime;
- (NSURL *)fileURLForAccount:(NSString *)account;
@end
@interface TestScheduledManager : CSScheduledTaskManager
@property NSURL *testRoot;
@property NSTimeInterval clockOffset;
@end
@implementation TestScheduledManager
- (NSURL *)fileURLForAccount:(NSString *)name{return CSScheduledTaskFileURL(self.testRoot,name);}
- (NSTimeInterval)elapsedTime{return [super elapsedTime]+self.clockOffset;}
@end
static void Run(CSScheduledTaskManager *manager,NSDictionary *task,NSDate *now){[manager run:task now:now];Wait(^BOOL{return [manager valueForKey:@"runningStore"]==nil;});}
static NSDate *At(NSTimeInterval value){return [NSDate dateWithTimeIntervalSince1970:value];}
static CSScheduledTaskManager *Manager(NSURL *root,NSString *target,BOOL global,BOOL taskEnabled){
    NSURL *url=[root URLByAppendingPathComponent:[NSString stringWithFormat:@"%lu.plist",(unsigned long)++caseNumber]];
    CSScheduledTaskStore *store=[[CSScheduledTaskStore alloc]initWithURL:url account:account];CHECK([store load]);
    CHECK([store setEnabled:global now:At(2000)]);
    NSDictionary *task=@{@"id":@"task",@"title":@"synthetic task",@"target":target,@"text":@"synthetic text",@"enabled":@(taskEnabled),@"catchUp":@NO,@"mode":@"minutes",@"interval":@1,@"anchor":At(2060),@"hour":@9,@"minute":@0,@"weekdays":@[@2],@"zone":@"Asia/Shanghai"};
    CHECK([store saveTask:task now:At(2000)]);
    TestScheduledManager *manager=[TestScheduledManager new];manager.testRoot=[root URLByAppendingPathComponent:NSUUID.UUID.UUIDString];[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];return manager;
}
int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2);NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    for(NSNumber *revealed in @[@NO,@YES])for(NSNumber *sessions in @[@NO,@YES])for(NSNumber *tasks in @[@NO,@YES])for(NSString *target in @[@"friend",@"room@chatroom"]){
        SetPrivacy(revealed.boolValue,sessions.boolValue,tasks.boolValue);CSScheduledTaskManager *manager=Manager(root,target,YES,YES);
        CSScheduledTaskStore *store=manager.store;NSDictionary *task=store.tasks.firstObject;NSUInteger before=submissions;
        CHECK(CSCloseFriendVisibleScheduledTasks(store.tasks,account,privacy).count==(!revealed.boolValue && tasks.boolValue?0:1));
        Run(manager,task,At(2060));CHECK(submissions==before+1 && [sentTarget isEqual:target] && [sentText isEqual:task[@"text"]]);
        CHECK([store.history.firstObject[@"result"] isEqual:@"submitted"]);
        CHECK([store.tasks.firstObject[@"nextRun"] isEqual:At(2120)] && [store.tasks.firstObject[@"enabled"] boolValue]);
        Run(manager,task,At(2060));CHECK(submissions==before+1); // duplicate occurrence never resends
    }
    SetPrivacy(NO,YES,YES);
    // Existing global/task switches, account boundary, authorization and recipient validity still stop sends.
    for(NSUInteger gate=0;gate<8;gate++){
        NSString *target=gate==5?@"missing":gate==6?@"service":@"friend";
        CSScheduledTaskManager *manager=Manager(root,target,gate!=0,gate!=1);NSUInteger before=submissions;
        if(gate==2)authorized=NO;if(gate==3)suspended=YES;if(gate==4)epoch++;if(gate==7)account=@"other";
        Run(manager,manager.store.tasks.firstObject,At(2060));CHECK(submissions==before);
        authorized=YES;suspended=NO;if(gate==4)epoch--;account=@"account";
    }
    // Exercise production prepared-send validation after state changes during native wrap construction.
    for(NSUInteger gate=0;gate<5;gate++){
        SetPrivacy(YES,YES,YES);CSScheduledTaskManager *manager=Manager(root,@"friend",YES,YES);NSUInteger before=submissions;
        duringPreparation=^{
            SetPrivacy(NO,YES,YES);
            if(gate==1)authorized=NO;if(gate==2)epoch++;if(gate==3)missingContact=YES;
            if(gate==4)CHECK([manager.store setEnabled:NO now:At(2060)]);
        };
        Run(manager,manager.store.tasks.firstObject,At(2060));
        CHECK(submissions==before+(gate==0?1:0));
        CHECK(!CSCloseFriendVisibleScheduledTasks(manager.store.tasks,@"account",privacy).count);
        duringPreparation=nil;authorized=YES;missingContact=NO;if(gate==2)epoch--;
    }
    // The final contact query may synchronously reenter settings or switch accounts.
    for(NSUInteger gate=0;gate<2;gate++){
        CSScheduledTaskManager *manager=Manager(root,@"friend",YES,YES);NSUInteger before=submissions;__block NSUInteger lookups=0;__block BOOL saved=gate!=0;
        duringContactLookup=^{if(++lookups==3){if(gate==0)[manager setEnabled:NO account:account completion:^(BOOL ok,NSError *failure){CHECK(ok && !failure);saved=YES;}];else epoch++;}};
        Run(manager,manager.store.tasks.firstObject,At(2060));Wait(^BOOL{return saved;});CHECK(lookups==3 && submissions==before);
        duringContactLookup=nil;if(gate==1)epoch--;
    }
    // Production run remains responsive while claim fsync is blocked, and AddMsg sees durable intent.
    entered=dispatch_semaphore_create(0);resumeIO=dispatch_semaphore_create(0);
    CSScheduledTaskManager *manager=Manager(root,@"friend",YES,YES);CSScheduledTaskStore *live=manager.store;
    expectedDurableURL=[root URLByAppendingPathComponent:[NSString stringWithFormat:@"%lu.plist",(unsigned long)caseNumber]];
    NSUInteger before=submissions;unsigned files=atomic_load(&fileFlushes),directories=atomic_load(&directoryFlushes);atomic_store(&blockNextFile,true);
    [manager run:live.tasks.firstObject now:At(2060)];CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);
    CHECK(CSBackupResourceWriteInProgress() && submissions==before);NSArray *snapshot=live.tasks;
    NSTimeInterval start=NSDate.timeIntervalSinceReferenceDate;for(NSUInteger i=0;i<1000;i++)CHECK(live.ready && live.tasks==snapshot && !live.history.count);CHECK(NSDate.timeIntervalSinceReferenceDate-start<.1);
    __block BOOL mainTurn=NO;dispatch_async(dispatch_get_main_queue(),^{mainTurn=YES;});Wait(^BOOL{return mainTurn;});CHECK(submissions==before);
    dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return [manager valueForKey:@"runningStore"]==nil;});CHECK(submissions==before+1);CHECK(atomic_load(&fileFlushes)==files+2 && atomic_load(&directoryFlushes)==directories+2);expectedDurableURL=nil;
    // Closing or expiring while disk is blocked cannot resume a previously admitted send.
    for(NSUInteger gate=0;gate<2;gate++){
        manager=Manager(root,@"friend",YES,YES);live=manager.store;before=submissions;atomic_store(&blockNextFile,true);
        [manager run:live.tasks.firstObject now:At(2060)];CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);
        __block BOOL saved=gate!=0;
        if(gate==0){start=NSDate.timeIntervalSinceReferenceDate;[manager setEnabled:NO account:account completion:^(BOOL ok,NSError *error){CHECK(ok && !error);saved=YES;}];CHECK(manager.savingConfiguration && NSDate.timeIntervalSinceReferenceDate-start<.1);}
        else ((TestScheduledManager *)manager).clockOffset=31;
        dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return saved && [manager valueForKey:@"runningStore"]==nil;});CHECK(submissions==before && [live.history[0][@"result"] isEqual:@"failed"]);if(gate==0)CHECK(!live.enabled);
    }
    // A failed durable claim never reaches the native send boundary.
    manager=Manager(root,@"friend",YES,YES);before=submissions;atomic_store(&failNextFile,true);Run(manager,manager.store.tasks.firstObject,At(2060));CHECK(submissions==before && !manager.store.ready && manager.store.error);
    // Switching through the real refresh path keeps both account files in this fixture's temp root.
    manager=Manager(root,@"friend",YES,YES);live=manager.store;before=submissions;atomic_store(&blockNextFile,true);
    [manager run:live.tasks.firstObject now:At(2060)];CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);
    account=@"other";epoch++;start=NSDate.timeIntervalSinceReferenceDate;[manager refresh];CHECK(!live.ready && manager.store!=live && NSDate.timeIntervalSinceReferenceDate-start<.1);
    dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return manager.store.ready;});CHECK(submissions==before && [manager.store.account isEqual:@"other"] && !manager.store.enabled && !manager.store.tasks.count);
    account=@"account";epoch++;[manager refresh];Wait(^BOOL{return manager.store.ready;});CHECK(submissions==before); // the old late callback never sends into the new account
    printf("Scheduled task manager: %lu checks passed (production scheduler/send route, isolated stores and native fakes)\n",(unsigned long)checks);
}return 0;}
