#import <Foundation/Foundation.h>
#import "CSScheduledTaskManager.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendAutomationProjection.h"
#import "CSAuthorizationManager.h"
#import "CSGroupNativeBridge.h"
#import "ScheduledNativeDispatchUnderTest.m"
#import "ScheduledSendUnderTest.m"

static NSUInteger checks,epoch=1,submissions,caseNumber;
static NSString *account=@"account", *sentTarget, *sentText;
static BOOL suspended,missingContact;
static BOOL authorized=YES;
static void (^duringPreparation)(void);
static CSCloseFriendSnapshot *privacy;
#define CHECK(...) do { checks++; if(!(__VA_ARGS__)) { NSLog(@"FAIL %d %s",__LINE__,#__VA_ARGS__);exit(1); } } while(0)
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
- (id)getContactByName:(NSString *)name{if(missingContact || [name isEqual:@"missing"])return nil;TestContact *contact=[TestContact new];contact.m_nsUsrName=name;return contact;}
@end
@interface CMessageMgr : NSObject
- (void)AddMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap;
@end
@implementation CMessageMgr
- (void)AddMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap{submissions++;sentTarget=target;sentText=wrap.m_nsContent;CHECK([wrap.m_nsToUsr isEqual:target] && [wrap.m_nsFromUsr isEqual:account]);}
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
@end
static NSDate *At(NSTimeInterval value){return [NSDate dateWithTimeIntervalSince1970:value];}
static CSScheduledTaskManager *Manager(NSURL *root,NSString *target,BOOL global,BOOL taskEnabled){
    NSURL *url=[root URLByAppendingPathComponent:[NSString stringWithFormat:@"%lu.plist",(unsigned long)++caseNumber]];
    CSScheduledTaskStore *store=[[CSScheduledTaskStore alloc]initWithURL:url account:account];CHECK([store load]);
    CHECK([store setEnabled:global now:At(2000)]);
    NSDictionary *task=@{@"id":@"task",@"title":@"synthetic task",@"target":target,@"text":@"synthetic text",@"enabled":@(taskEnabled),@"catchUp":@NO,@"mode":@"minutes",@"interval":@1,@"anchor":At(2060),@"hour":@9,@"minute":@0,@"weekdays":@[@2],@"zone":@"Asia/Shanghai"};
    CHECK([store saveTask:task now:At(2000)]);
    CSScheduledTaskManager *manager=[CSScheduledTaskManager new];[manager setValue:store forKey:@"store"];[manager setValue:@(epoch) forKey:@"epoch"];return manager;
}
int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2);NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    for(NSNumber *revealed in @[@NO,@YES])for(NSNumber *sessions in @[@NO,@YES])for(NSNumber *tasks in @[@NO,@YES])for(NSString *target in @[@"friend",@"room@chatroom"]){
        SetPrivacy(revealed.boolValue,sessions.boolValue,tasks.boolValue);CSScheduledTaskManager *manager=Manager(root,target,YES,YES);
        CSScheduledTaskStore *store=manager.store;NSDictionary *task=store.tasks.firstObject;NSUInteger before=submissions;
        CHECK(CSCloseFriendVisibleScheduledTasks(store.tasks,account,privacy).count==(!revealed.boolValue && tasks.boolValue?0:1));
        [manager run:task now:At(2060)];CHECK(submissions==before+1 && [sentTarget isEqual:target] && [sentText isEqual:task[@"text"]]);
        CHECK([store.history.firstObject[@"result"] isEqual:@"submitted"]);
        CHECK([store.tasks.firstObject[@"nextRun"] isEqual:At(2120)] && [store.tasks.firstObject[@"enabled"] boolValue]);
        [manager run:task now:At(2060)];CHECK(submissions==before+1); // duplicate occurrence never resends
    }
    SetPrivacy(NO,YES,YES);
    // Existing global/task switches, account boundary, authorization and recipient validity still stop sends.
    for(NSUInteger gate=0;gate<8;gate++){
        NSString *target=gate==5?@"missing":gate==6?@"service":@"friend";
        CSScheduledTaskManager *manager=Manager(root,target,gate!=0,gate!=1);NSUInteger before=submissions;
        if(gate==2)authorized=NO;if(gate==3)suspended=YES;if(gate==4)epoch++;if(gate==7)account=@"other";
        [manager run:manager.store.tasks.firstObject now:At(2060)];CHECK(submissions==before);
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
        [manager run:manager.store.tasks.firstObject now:At(2060)];
        CHECK(submissions==before+(gate==0?1:0));
        CHECK(!CSCloseFriendVisibleScheduledTasks(manager.store.tasks,@"account",privacy).count);
        duringPreparation=nil;authorized=YES;missingContact=NO;if(gate==2)epoch--;
    }
    printf("Scheduled task manager: %lu checks passed (production scheduler/send route, isolated stores and native fakes)\n",(unsigned long)checks);
}return 0;}
