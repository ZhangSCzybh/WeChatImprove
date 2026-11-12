#import <Foundation/Foundation.h>
#import "CSAutomationManager.h"
#import "CSAutomationStore.h"
#import "CSAutomationEventAdapter.h"
#import "CSAutomationNativeAdapter.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSAuthorizationManager.h"
#import "CSGroupNativeBridge.h"
#import "CSGroupChatNativeAdapter.h"
#import "CSBackgroundRunManager.h"
#import "CSAINativeSyncObserver.h"
#import "CSAutomationNativeSync.h"
#import <objc/runtime.h>
#include <sys/file.h>
#include <fcntl.h>
#include <unistd.h>

static NSUInteger checks,epoch=7,sendCount,patCount,revokeCount,marks,remembered,cancellations;
static BOOL authorized=YES,backupReady=YES,suspended,contactsAvailable=YES,patAccepted=YES,quoteAvailable=YES,protectedAvailable=YES,accountAvailable=YES;
static NSString *account=@"alice";
static NSURL *testRoot;
static NSTimeInterval wall=2000000000,uptime=1000;
static NSMutableArray *sent,*pats,*revoked;
static NSMapTable *observations;
static dispatch_block_t duringPreparation;
static id updatedQuoteSource;
static BOOL liveDispatch;
static BOOL backgroundWorkAvailable=YES;
#define CHECK(...) do{checks++;if(!(__VA_ARGS__)){fprintf(stderr,"Automation manager failed line %d: %s\n",__LINE__,#__VA_ARGS__);exit(1);}}while(0)

NSNotificationName const UIApplicationDidBecomeActiveNotification=@"active";
NSNotificationName const UIApplicationDidEnterBackgroundNotification=@"UIApplicationDidEnterBackgroundNotification";
NSNotificationName const UIApplicationWillEnterForegroundNotification=@"UIApplicationWillEnterForegroundNotification";
NSNotificationName const UIApplicationProtectedDataDidBecomeAvailable=@"unlocked";
NSNotificationName const CSBackgroundRunStateChangedNotification=@"background-work";
@implementation UIApplication
+ (instancetype)sharedApplication{static UIApplication *application;static dispatch_once_t once;dispatch_once(&once,^{application=[self new];});return application;}
- (BOOL)isProtectedDataAvailable{return protectedAvailable;}
@end
@implementation UIViewController @end
@implementation CSBackgroundRunManager
+ (instancetype)sharedManager{static CSBackgroundRunManager *manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (BOOL)canAttemptBackgroundWork{return backgroundWorkAvailable;}
- (BOOL)backgroundAudioActive{return NO;}
@end
void CSAIObserveBackgroundSyncRequest(NSUInteger expectedEpoch,void (^request)(void)){(void)expectedEpoch;if(request)request();}
// These manager fixtures exercise the compatibility pull. The native hook
// fixture links the real event coordinator and checks its independent contract.
#ifndef CS_AUTOMATION_REAL_NATIVE_SYNC
static BOOL nativeSyncAvailable;
static NSUInteger nativeSyncWakes;
void CSAutomationInstallNativeSync(void){}
BOOL CSAutomationNativeSyncAvailable(void){return nativeSyncAvailable;}
BOOL CSAutomationNativeSyncCanWake(id receiver){return nativeSyncAvailable && receiver;}
void CSAutomationWakePendingNativeSync(id service,NSUInteger expectedEpoch){(void)service;(void)expectedEpoch;nativeSyncWakes++;}
#endif
#if !defined(CS_AUTOMATION_REAL_SERVICE_IDENTITY) && !defined(CS_AUTOMATION_REAL_EVENT_ADAPTER)
id CSMessageNativeServiceIdentity(id receiver,NSString *className){(void)receiver;(void)className;return nil;}
#endif
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static id value;static dispatch_once_t once;dispatch_once(&once,^{value=[self new];});return value;}
- (BOOL)isAuthorized{return authorized;}
@end
BOOL CSBackupIsReady(void){return backupReady;}
BOOL CSBackupAccountIsSuspended(void){return suspended;}
NSUInteger CSBackupAccountEpoch(void){return epoch;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger expected,void(^handoff)(void)){if(expected!=epoch || suspended)return NO;handoff();return YES;}

@interface AutomationContact : NSObject
@property NSString *m_nsUsrName;
@end
@implementation AutomationContact @end
@interface AutomationContacts : NSObject
- (id)getContactByName:(NSString *)name;
@end
@implementation AutomationContacts
- (id)getContactByName:(NSString *)name {if(!contactsAvailable)return nil;AutomationContact *contact=[AutomationContact new];contact.m_nsUsrName=name;return contact;}
@end
@interface AutomationMessages : NSObject
- (id)GetMsg:(NSString *)name LocalID:(unsigned int)local;
@end
@implementation AutomationMessages
- (id)GetMsg:(NSString *)name LocalID:(unsigned int)local{(void)name;(void)local;return updatedQuoteSource;}
@end
#ifndef CS_AUTOMATION_REAL_NATIVE_ENVIRONMENT
@implementation CSMessageNativeEnvironment
- (NSString *)currentAccountID{return accountAvailable?account:nil;}
- (id)serviceNamed:(NSString *)name{return [name isEqual:@"CContactMgr"]?[AutomationContacts new]:[AutomationMessages new];}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
#endif
CSGroupRowCategory CSGroupCategoryForContact(id contact){return contact?CSGroupRowCategoryPrivate:CSGroupRowCategoryUnknown;}
BOOL CSGroupChatRoomUnavailable(NSString *room){(void)room;return !contactsAvailable;}
BOOL CSGroupChatIsMember(NSString *room,NSString *member){(void)room;(void)member;return contactsAvailable;}
NSString *CSGroupChatMemberName(NSString *room,NSString *member){(void)room;(void)member;return @"成员甲";}
@implementation CSGroupChatQuitCoordinator
+ (instancetype)sharedCoordinator{static id value;static dispatch_once_t once;dispatch_once(&once,^{value=[self new];});return value;}
- (BOOL)isQuittingRoom:(NSString *)room{(void)room;return NO;}
@end
#ifndef CS_AUTOMATION_REAL_EVENT_ADAPTER
BOOL CSMessageNativeSupports(id receiver,NSString *selector,NSString *result,NSArray *arguments){(void)result;(void)arguments;return [receiver respondsToSelector:NSSelectorFromString(selector)];}
id CSMessageNativeInvoke(id receiver,NSString *selector,NSArray *arguments){
    if([selector isEqual:@"GetMsg:LocalID:"])return [(AutomationMessages *)receiver GetMsg:arguments[0] LocalID:[arguments[1] unsignedIntValue]];
    return [(AutomationContacts *)receiver getContactByName:arguments[0]];
}
id CSMessageActionNativeObject(id receiver,NSString *selector){if([receiver isKindOfClass:NSDictionary.class])return receiver[selector];return [receiver valueForKey:selector];}
unsigned long long CSMessageNativeUnsigned(id receiver,NSString *selector){return [CSMessageActionNativeObject(receiver,selector) unsignedLongLongValue];}

NSDictionary *CSAutomationEventFromWrap(id wrap,NSString *owner,NSString *session){(void)owner;(void)session;return [wrap isKindOfClass:NSDictionary.class]?wrap:nil;}
NSDictionary *CSAutomationEventFromPat(id pat,NSString *owner,NSString *conversation){(void)owner;(void)conversation;return pat;}
NSArray *CSAutomationMessageIdentifiers(id wrap,NSString *owner,NSString *conversation){(void)owner;(void)conversation;return wrap[@"ids"]?:@[];}
void CSAutomationMarkOwnedSend(id wrap){if(wrap)marks++;}
void CSAutomationRememberOwnedSend(id wrap,NSString *owner,NSString *conversation){(void)owner;(void)conversation;if(wrap)remembered++;}
#endif

@interface CSMessagePreparedSend ()
@property(nonatomic,strong,readwrite) id outputWrap;
@property(nonatomic,readwrite) BOOL nativeHandoffReturned;
@property(nonatomic,copy) CSMessageActionSubmissionState (^fixtureSubmission)(void);
@property(nonatomic) BOOL fixtureSubmitted;
@end
@implementation CSMessagePreparedSend
- (instancetype)initWithWrap:(id)wrap routeName:(NSString *)name submission:(CSMessageActionSubmissionState(^)(void))submission{(void)name;if((self=[super init])){_outputWrap=wrap;_fixtureSubmission=[submission copy];}return self;}
- (CSMessageActionSubmissionState)submit{if(self.fixtureSubmitted)return CSMessageActionSubmissionStateUnknown;self.fixtureSubmitted=YES;if(self.submissionStillAuthorized && !self.submissionStillAuthorized())return CSMessageActionSubmissionStateFailedBeforeAcceptance;CSMessageActionSubmissionState result=self.fixtureSubmission();self.nativeHandoffReturned=YES;return result;}
@end
@implementation CSMessageSendAdapter
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment{(void)environment;return [super init];}
- (CSMessagePreparedSend *)fixtureRoute:(NSString *)text target:(NSString *)target mentions:(NSArray *)mentions quote:(BOOL)quote{
    if(duringPreparation){dispatch_block_t action=duringPreparation;duringPreparation=nil;action();}
    if(quote && !quoteAvailable)return nil;
    NSDictionary *record=@{@"text":text,@"target":target,@"mentions":mentions?:@[],@"quote":@(quote)};
    return [[CSMessagePreparedSend alloc]initWithWrap:[NSObject new] routeName:@"recording" submission:^{sendCount++;[sent addObject:record];return CSMessageActionSubmissionStateUnknown;}];
}
- (CSMessagePreparedSend *)prepareScheduledText:(NSString *)text targetID:(NSString *)target accountID:(NSString *)owner{(void)owner;return [self fixtureRoute:text target:target mentions:nil quote:NO];}
- (CSMessagePreparedSend *)prepareGroupText:(NSString *)text mentions:(NSArray *)mentions targetID:(NSString *)target accountID:(NSString *)owner{(void)owner;return [self fixtureRoute:text target:target mentions:mentions quote:NO];}
- (CSMessagePreparedSend *)prepareAutomationQuote:(NSString *)text source:(id)source targetID:(NSString *)target accountID:(NSString *)owner{(void)source;(void)owner;return [self fixtureRoute:text target:target mentions:nil quote:YES];}
@end
@implementation CSAutomationNativeAdapter
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment{(void)environment;return [super init];}
- (id)sendPatTo:(NSString *)sender conversation:(NSString *)conversation account:(NSString *)owner valid:(BOOL(^)(void))valid{
    (void)sender;(void)conversation;(void)owner;if(!valid() || !patAccepted)return nil;id object=[NSObject new];patCount++;[pats addObject:object];
    if(liveDispatch)dispatch_after(dispatch_time(DISPATCH_TIME_NOW,20*NSEC_PER_MSEC),dispatch_get_main_queue(),^{void (^success)(BOOL)=[observations objectForKey:object];if(success)success(YES);});return object;
}
- (BOOL)revokePat:(id)pat conversation:(NSString *)conversation account:(NSString *)owner valid:(BOOL(^)(void))valid{
    (void)conversation;(void)owner;if(!valid())return NO;revokeCount++;[revoked addObject:pat];return YES;
}
- (id)sendPatTo:(NSString *)sender conversation:(NSString *)conversation account:(NSString *)owner valid:(BOOL(^)(void))valid deferred:(BOOL *)deferred{
    if(deferred)*deferred=NO;return [self sendPatTo:sender conversation:conversation account:owner valid:valid];
}
- (BOOL)revokePat:(id)pat conversation:(NSString *)conversation account:(NSString *)owner valid:(BOOL(^)(void))valid deferred:(BOOL *)deferred{
    if(deferred)*deferred=NO;return [self revokePat:pat conversation:conversation account:owner valid:valid];
}
- (NSTimeInterval)revokeWindow{return 120;}
@end
void CSAutomationObservePatResult(id pat,void(^completion)(BOOL success)){[observations setObject:[completion copy] forKey:pat];}
void CSAutomationCancelPatObservation(id pat){if([observations objectForKey:pat])cancellations++;[observations removeObjectForKey:pat];}

@interface CSAutomationManager (AutomationFixture)
- (NSDate *)currentDate;
- (NSTimeInterval)elapsedTime;
- (NSURL *)resourceRoot;
- (void)processPending;
@end
@interface AutomationTestManager : CSAutomationManager @end
@implementation AutomationTestManager
- (NSDate *)currentDate{return [NSDate dateWithTimeIntervalSince1970:wall];}
- (NSTimeInterval)elapsedTime{return uptime;}
- (NSURL *)resourceRoot{return testRoot;}
@end
@interface AutomationCapabilityRaceLedger : CSAutomationLedger
@property(nonatomic,strong) NSError *observedFailure;
@end
@implementation AutomationCapabilityRaceLedger
- (BOOL)claimIdentifiers:(NSArray<NSString *> *)identifiers action:(NSString *)action now:(NSDate *)now error:(NSError **)error{
    NSError *failure=nil;BOOL fresh=[super claimIdentifiers:identifiers action:action now:now error:&failure];
    self.observedFailure=failure;backupReady=NO;if(error)*error=failure;return fresh;
}
@end
static void Drain(void){for(NSUInteger i=0;i<10;i++)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.005]];}
static void WaitAt(BOOL(^condition)(void),int line){for(NSUInteger i=0;i<100 && !condition();i++)Drain();if(!condition())fprintf(stderr,"Wait caller line %d timed out\n",line);CHECK(condition());}
#define Wait(c) WaitAt(c,__LINE__)
static AutomationTestManager *Manager(void){AutomationTestManager *manager=[AutomationTestManager new];[manager start];Wait(^BOOL{return manager.ready;});return manager;}
static NSDictionary *Rule(NSString *keyword,NSArray *contents){return @{@"id":NSUUID.UUID.UUIDString,@"keyword":keyword,@"match":@"contains",@"contents":contents};}
static NSMutableDictionary *Module(CSAutomationManager *manager,NSString *name){return [manager.configuration[name] mutableCopy];}
static void Save(CSAutomationManager *manager,NSDictionary *changes){__block BOOL done=NO,success=NO;[manager updateConfiguration:changes completion:^(BOOL ok,NSError *error){(void)error;done=YES;success=ok;}];Wait(^BOOL{return done;});CHECK(success);}
static void Keyword(CSAutomationManager *manager,NSUInteger delay,BOOL quote,BOOL own){NSMutableDictionary *module=Module(manager,@"keywordReply");[module addEntriesFromDictionary:@{@"enabled":@YES,@"friends":@[@"bob"],@"groups":@[@"room@chatroom"],@"delay":@(delay),@"quote":@(quote),@"own":@(own),@"rules":@[Rule(@"hello",@[@"one",@"two"])]}];Save(manager,@{@"keywordReply":module});}
static NSMutableDictionary *Event(NSUInteger identity,BOOL group,BOOL own,BOOL mentioned){NSString *conversation=group?@"room@chatroom":@"bob";NSString *key=[NSString stringWithFormat:@"%@|%@|l:%lu:2000000000",account,conversation,(unsigned long)identity];
    return [@{@"account":account,@"conversation":conversation,@"sender":own?account:@"bob",@"own":@(own),@"group":@(group),@"text":@"hello world",@"mentioned":@(mentioned),@"created":@(wall),@"identifiers":@[key],@"source":[@{@"m_n64MesSvrID":@10,@"m_uiMesLocalID":@(identity),@"ids":@[key]} mutableCopy]} mutableCopy];
}
static BOOL Receive(CSAutomationManager *manager,NSDictionary *event){__block BOOL done=NO,claimed=NO;[manager receiveNativeSession:event[@"conversation"] wrap:event epoch:epoch completion:^(BOOL result){done=YES;claimed=result;}];Wait(^BOOL{return done;});return claimed;}
static NSUInteger Pending(CSAutomationManager *manager){return [[manager valueForKey:@"tasks"] count];}
static void Advance(CSAutomationManager *manager,NSTimeInterval seconds){uptime+=seconds;wall+=seconds;[manager processPending];}


static void ConfigureAll(CSAutomationManager *manager,NSUInteger delay){
    Keyword(manager,delay,NO,NO);
    NSMutableDictionary *mention=Module(manager,@"mentionReply"),*back=Module(manager,@"patBack"),*reply=Module(manager,@"patReply");
    CHECK(mention[@"friends"]==nil);
    [mention addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"delay":@(delay),@"contents":@[@"mention answer"],@"mention":@YES}];
    [back addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"delay":@(delay),@"revoke":@YES,@"revokeDelay":@1}];
    [reply addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"delay":@(delay),@"contents":@[@"pat answer"],@"mention":@YES}];Save(manager,@{@"mentionReply":mention,@"patBack":back,@"patReply":reply});
}
static int BackgroundCases(void){
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;protectedAvailable=NO;
    AutomationTestManager *manager=Manager();ConfigureAll(manager,2);CHECK(UIApplication.sharedApplication.applicationState==UIApplicationStateBackground);
    CHECK(Receive(manager,Event(5001,YES,NO,YES)));Advance(manager,2);CHECK(sendCount==1 && Pending(manager)==0);
    printf("A Locked background real-mention: ProtectedData=NO sends=%lu pending=%lu (exactly once)\n",(unsigned long)sendCount,(unsigned long)Pending(manager));
    [manager receivePat:Event(5002,YES,NO,NO) conversation:@"room@chatroom" epoch:epoch];Wait(^BOOL{return Pending(manager)==2;});Advance(manager,2);CHECK(sendCount==2 && patCount==1);
    id exact=pats.lastObject;void (^success)(BOOL)=[observations objectForKey:exact];CHECK(success!=nil);success(YES);success(YES);Advance(manager,1);CHECK(!protectedAvailable && revokeCount==1 && revoked.lastObject==exact && Pending(manager)==0);
    printf("B Locked background pat: patSubmits=%lu patReplySubmits=1 revokeSubmits=%lu exactObject=yes unlockRequired=no\n",(unsigned long)patCount,(unsigned long)revokeCount);
    CHECK(Receive(manager,Event(5003,NO,NO,NO)));Advance(manager,2);CHECK(!protectedAvailable && sendCount==3 && Pending(manager)==0);printf("C Locked background keyword: newSubmits=1 totalText=%lu\n",(unsigned long)sendCount);
    CHECK(Receive(manager,Event(5004,NO,NO,NO)));Advance(manager,2);CHECK(!protectedAvailable && sendCount==4 && Pending(manager)==0 && [[manager valueForKey:@"waitingIngress"] count]==0);
    printf("D1 ProtectedData=NO with available account/storage: admittedAndSubmitted=1 noUnlockNotification=yes totalText=%lu\n",(unsigned long)sendCount);
    CHECK(Receive(manager,Event(5005,NO,NO,NO)));authorized=NO;Advance(manager,2);CHECK(sendCount==4 && Pending(manager)==1);authorized=YES;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];CHECK(sendCount==5 && Pending(manager)==0);
    printf("D2 Authorization unavailable: retained=1 restoredSubmits=1 totalText=%lu\n",(unsigned long)sendCount);
    CHECK(Receive(manager,Event(5006,NO,NO,NO)));accountAvailable=NO;[manager refresh];Advance(manager,2);CHECK(sendCount==5 && Pending(manager)==1 && [manager.accountID isEqual:account]);accountAvailable=YES;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];CHECK(sendCount==6 && Pending(manager)==0);
    printf("D3 Same-epoch account lookup nil: retained=1 restoredSubmits=1 totalText=%lu\n",(unsigned long)sendCount);
    CHECK(Receive(manager,Event(5007,NO,NO,NO)));backupReady=NO;[manager refresh];Advance(manager,2);CHECK(sendCount==6 && Pending(manager)==1);backupReady=YES;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationProtectedDataDidBecomeAvailable object:nil];CHECK(sendCount==7 && Pending(manager)==0);
    printf("D4 Backup/account initialization temporarily unavailable: retained=1 restoredSubmits=1\n");
    NSMutableDictionary *duplicate=Event(5008,YES,NO,YES);CHECK(Receive(manager,duplicate));Advance(manager,2);CHECK(sendCount==8);UIApplication.sharedApplication.applicationState=UIApplicationStateActive;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];CHECK(Receive(manager,duplicate));CHECK(sendCount==8 && Pending(manager)==0);
    printf("E Background then foreground duplicate callback: eventSubmits=1 totalText=%lu pending=0\n",(unsigned long)sendCount);
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;CHECK(Receive(manager,Event(5009,NO,NO,NO)));uptime+=62;wall+=62;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];CHECK(sendCount==9 && Pending(manager)==0);
    printf("F-after late catch-up: originalDue+60s submits=1 (old 30s cutoff lost this event)\n");
    NSMutableDictionary *expired=Event(5010,NO,NO,NO);CHECK(Receive(manager,expired));Advance(manager,303);CHECK(sendCount==9 && Pending(manager)==0 && [manager.statusText containsString:@"5 分钟"]);printf("F-after expiry: originalDue+301s submits=0 reason=%s\n",manager.statusText.UTF8String);
    expired[@"created"]=@(wall);CHECK(Receive(manager,expired));CHECK(sendCount==9 && Pending(manager)==0);
    // Actual backup/configuration unavailability still queues a cold ingress;
    // restoring that dependency while locked must work without an unlock.
    backupReady=NO;AutomationTestManager *cold=[AutomationTestManager new];__block BOOL admitted=NO,done=NO;
    NSMutableDictionary *coldMessage=Event(5011,NO,NO,NO),*coldPatEvent=Event(5012,YES,NO,NO);coldMessage[@"created"]=@(wall-3);coldPatEvent[@"created"]=@(wall-3);
    [cold receiveNativeSession:@"bob" wrap:coldMessage epoch:epoch completion:^(BOOL claim){admitted=claim;done=YES;}];
    [cold receivePat:coldPatEvent conversation:@"room@chatroom" epoch:epoch];CHECK(!cold.ready && !done && [[cold valueForKey:@"waitingIngress"] count]==2);Advance(cold,10);CHECK(!done);
    backupReady=YES;[cold refresh];Wait(^BOOL{return cold.ready && done && patCount==2;});CHECK(!protectedAvailable && admitted && sendCount==11);
    id coldPat=pats.lastObject;void (^coldSuccess)(BOOL)=[observations objectForKey:coldPat];CHECK(coldSuccess!=nil);coldSuccess(YES);Advance(cold,1);CHECK(revokeCount==2);
    Save(cold,@{@"keywordReply":Module(cold,@"keywordReply")});NSMutableDictionary *preEdit=Event(5017,NO,NO,NO);preEdit[@"created"]=@(wall-1);CHECK(!Receive(cold,preEdit));CHECK(Pending(cold)==0 && sendCount==11);
    printf("D5 Locked cold backup !ready (message+pat): queued=2 originalArrivalDuePreserved=yes restoredText=2 restoredPat=1 unlockRequired=no; preEditIncomingRejected=yes\n");
    // Backup availability can change after the native event was accepted
    // but before its serial durable claim runs. Preserve both old claimed work
    // and the unclaimed admission until the same epoch becomes available.
    CHECK(Receive(manager,Event(5013,NO,NO,NO)));dispatch_semaphore_t release=dispatch_semaphore_create(0);dispatch_queue_t io=[manager valueForKey:@"io"];
    dispatch_async(io,^{dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC));});__block BOOL raceDone=NO,raceClaim=NO;
    [manager receiveNativeSession:@"bob" wrap:Event(5014,NO,NO,NO) epoch:epoch completion:^(BOOL claim){raceDone=YES;raceClaim=claim;}];backupReady=NO;dispatch_semaphore_signal(release);
    Wait(^BOOL{NSArray *owners=[[manager valueForKey:@"admissions"] allValues];return owners.count && ![[owners.firstObject valueForKey:@"persisting"] boolValue];});Advance(manager,2);CHECK(!raceDone && Pending(manager)==1 && sendCount==11);
    backupReady=YES;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationProtectedDataDidBecomeAvailable object:nil];Wait(^BOOL{return raceDone;});CHECK(raceClaim && sendCount==13 && Pending(manager)==0);
    printf("D6 Native-ingress to durable-IO availability race: oldClaimRetained=1 newAdmissionRetained=1 restoredSubmits=2\n");
    protectedAvailable=YES;release=dispatch_semaphore_create(0);dispatch_async(io,^{dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC));});__block BOOL lockRaceDone=NO;
    [manager receiveNativeSession:@"bob" wrap:Event(5015,NO,NO,NO) epoch:epoch completion:^(BOOL claim){CHECK(claim);lockRaceDone=YES;}];protectedAvailable=NO;dispatch_semaphore_signal(release);Wait(^BOOL{return lockRaceDone;});CHECK(Pending(manager)==1 && sendCount==13);Advance(manager,2);
    CHECK(!protectedAvailable && Pending(manager)==0 && sendCount==14);printf("D7 ProtectedData became unavailable during durable IO: claimBeforeSubmit=yes submits=1 unlockRequired=no\n");
    release=dispatch_semaphore_create(0);dispatch_async(io,^{dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC));});__block NSUInteger expiredCallbacks=0;
    [manager receiveNativeSession:@"bob" wrap:Event(5016,NO,NO,NO) epoch:epoch completion:^(BOOL claim){CHECK(!claim);expiredCallbacks++;}];Advance(manager,303);CHECK(expiredCallbacks==1 && [[manager valueForKey:@"admissions"] count]==0 && sendCount==14);dispatch_semaphore_signal(release);
    __block BOOL ioFinished=NO;dispatch_async(io,^{dispatch_async(dispatch_get_main_queue(),^{ioFinished=YES;});});Wait(^BOOL{return ioFinished;});CHECK(expiredCallbacks==1 && Pending(manager)==0 && sendCount==14);printf("D9 Stalled durable admission expired: callback=1 lateIOCannotCreateSend=yes\n");
    NSMutableDictionary *lateDuplicate=Event(5016,NO,NO,NO);CHECK(Receive(manager,lateDuplicate));CHECK(Pending(manager)==0 && sendCount==14);

    // Use a real file lock, not the app-global protected-data flag, to deny a
    // durable claim. Releasing our fixture's lock must allow one same-account
    // retry while the phone-state fixture remains locked throughout.
    NSURL *runtime=[[CSAutomationFileURL(testRoot,account) URLByDeletingPathExtension] URLByAppendingPathExtension:@"runtime.plist"];
    NSData *runtimeBefore=[NSData dataWithContentsOfURL:runtime];CHECK(runtimeBefore!=nil);
    NSString *lockPath=[runtime.path stringByAppendingString:@".lock"];
    int lockDescriptor=open(lockPath.fileSystemRepresentation,O_CREAT|O_RDWR,0600);
    CHECK(lockDescriptor>=0 && flock(lockDescriptor,LOCK_EX|LOCK_NB)==0);
    __block BOOL storageDone=NO,storageClaim=NO;
    NSMutableDictionary *storageEvent=Event(5018,NO,NO,NO);
    [manager receiveNativeSession:@"bob" wrap:storageEvent epoch:epoch completion:^(BOOL claim){storageClaim=claim;storageDone=YES;}];
    Wait(^BOOL{NSArray *owners=[[manager valueForKey:@"admissions"] allValues];return owners.count && ![[owners.firstObject valueForKey:@"persisting"] boolValue];});
    CHECK(!storageDone && Pending(manager)==0 && sendCount==14 && !protectedAvailable);
    CHECK([[NSData dataWithContentsOfURL:runtime] isEqual:runtimeBefore]);
    CHECK(flock(lockDescriptor,LOCK_UN)==0 && close(lockDescriptor)==0);
    Advance(manager,5);Wait(^BOOL{return storageDone;});
    CHECK(storageClaim && sendCount==15 && Pending(manager)==0 && !protectedAvailable);
    storageEvent[@"created"]=@(wall);CHECK(Receive(manager,storageEvent));CHECK(sendCount==15 && Pending(manager)==0);
    printf("D10 Actual ledger IO blocked: noPreClaimSend=yes originalBytesPreserved=yes retainedAdmission=1 sameAccountRetrySubmits=1 duplicateSubmits=0 unlockRequired=no\n");

    lockDescriptor=open(lockPath.fileSystemRepresentation,O_CREAT|O_RDWR,0600);
    CHECK(lockDescriptor>=0 && flock(lockDescriptor,LOCK_EX|LOCK_NB)==0);
    __block NSUInteger storageExpiryCallbacks=0;NSMutableDictionary *storageExpiry=Event(5019,NO,NO,NO);
    [manager receiveNativeSession:@"bob" wrap:storageExpiry epoch:epoch completion:^(BOOL claim){CHECK(!claim);storageExpiryCallbacks++;}];
    Wait(^BOOL{NSArray *owners=[[manager valueForKey:@"admissions"] allValues];return owners.count && ![[owners.firstObject valueForKey:@"persisting"] boolValue];});
    CHECK(storageExpiryCallbacks==0 && sendCount==15);Advance(manager,303);
    CHECK(storageExpiryCallbacks==1 && [[manager valueForKey:@"admissions"] count]==0 && Pending(manager)==0 && sendCount==15);
    CHECK(flock(lockDescriptor,LOCK_UN)==0 && close(lockDescriptor)==0);
    [manager refresh];Wait(^BOOL{return manager.ready;});Advance(manager,5);CHECK(!Receive(manager,storageExpiry));
    CHECK(storageExpiryCallbacks==1 && Pending(manager)==0 && sendCount==15 && !protectedAvailable);
    printf("D11 Actual ledger IO expiry: callbackOnce=yes lateRecoverySubmits=0 staleEventSubmits=0 locked=yes\n");

    // A real malformed ledger is permanent even if account capability becomes
    // unavailable between the storage failure and its main-queue completion.
    runtimeBefore=[NSData dataWithContentsOfURL:runtime];CHECK(runtimeBefore!=nil);
    NSError *raceError=nil;AutomationCapabilityRaceLedger *raceLedger=[[AutomationCapabilityRaceLedger alloc]initWithURL:runtime account:account error:&raceError];
    CHECK(raceLedger!=nil && raceError==nil);[manager setValue:raceLedger forKey:@"ledger"];
    NSData *brokenRuntime=[@"permanent corrupt ledger" dataUsingEncoding:NSUTF8StringEncoding];CHECK([brokenRuntime writeToURL:runtime atomically:YES]);
    __block NSUInteger permanentCallbacks=0;
    [manager receiveNativeSession:@"bob" wrap:Event(5020,NO,NO,NO) epoch:epoch completion:^(BOOL claim){CHECK(!claim);permanentCallbacks++;}];
    Wait(^BOOL{return permanentCallbacks==1;});
    CHECK(!backupReady && raceLedger.observedFailure!=nil && !CSAutomationStorageErrorIsRetryable(raceLedger.observedFailure));
    CHECK(!manager.ready && [[manager valueForKey:@"admissions"] count]==0 && Pending(manager)==0 && sendCount==15);
    CHECK([[NSData dataWithContentsOfURL:runtime] isEqual:brokenRuntime]);
    backupReady=YES;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];Wait(^BOOL{return ![[manager valueForKey:@"loading"] boolValue];});
    CHECK(!manager.ready && permanentCallbacks==1 && sendCount==15 && [[NSData dataWithContentsOfURL:runtime] isEqual:brokenRuntime]);
    CHECK([runtimeBefore writeToURL:runtime atomically:YES]);[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];Wait(^BOOL{return manager.ready;});Advance(manager,5);
    CHECK(permanentCallbacks==1 && [[manager valueForKey:@"admissions"] count]==0 && Pending(manager)==0 && sendCount==15 && !protectedAvailable);
    printf("D12 Permanent ledger error + account capability race: corruptBytesPreserved=yes admissionEnded=yes callbackOnce=yes capabilityAndFixtureRecoveryCannotRevive=yes\n");
    [NSNotificationCenter.defaultCenter removeObserver:manager];[NSNotificationCenter.defaultCenter removeObserver:cold];
    printf("Automation background cases: %lu checks passed\n",(unsigned long)checks);return 0;
}
@interface AutomationLiveManager : CSAutomationManager @end
@implementation AutomationLiveManager
- (NSURL *)resourceRoot{return testRoot;}
@end
static char MainQueueKey;
static IMP OriginalIsMain;
static BOOL FixtureIsMain(id receiver,SEL selector){return ((BOOL(*)(id,SEL))OriginalIsMain)(receiver,selector) || dispatch_get_specific(&MainQueueKey)!=NULL;}
static BOOL controlNSTimerFired;
static void DispatchOnly(void){
    liveDispatch=YES;UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;protectedAvailable=NO;
    dispatch_queue_set_specific(dispatch_get_main_queue(),&MainQueueKey,&MainQueueKey,NULL);Method main=class_getClassMethod(NSThread.class,@selector(isMainThread));OriginalIsMain=method_getImplementation(main);method_setImplementation(main,(IMP)FixtureIsMain);
    NSMutableDictionary *configuration=[CSAutomationDefaultConfiguration() mutableCopy];
    for(NSString *name in @[@"patBack",@"patReply",@"mentionReply",@"keywordReply"]){NSMutableDictionary *module=[configuration[name] mutableCopy];module[@"enabled"]=@YES;module[@"groups"]=@[@"room@chatroom"];if([name isEqual:@"mentionReply"])CHECK(module[@"friends"]==nil);else module[@"friends"]=@[@"bob"];module[@"delay"]=@1;if([name isEqual:@"patBack"]){module[@"revoke"]=@YES;module[@"revokeDelay"]=@1;}else if([name isEqual:@"keywordReply"]){module[@"quote"]=@NO;module[@"rules"]=@[Rule(@"hello",@[@"keyword answer"])];}else module[@"contents"]=@[@"answer"];configuration[name]=module;}
    NSError *error=nil;CHECK(CSAutomationWriteState(@{@"schema":@1,@"account":account,@"configuration":configuration},CSAutomationFileURL(testRoot,account),account,&error));
    AutomationLiveManager *manager=[AutomationLiveManager new];[manager start];
    NSTimer *control=[NSTimer timerWithTimeInterval:0.05 repeats:NO block:^(__unused NSTimer *timer){controlNSTimerFired=YES;}];[NSRunLoop.mainRunLoop addTimer:control forMode:NSRunLoopCommonModes];
    __block void (^begin)(void);begin=^{if(!manager.ready || NSDate.date.timeIntervalSince1970<ceil([[manager valueForKey:@"admissionBoundary"] doubleValue])){dispatch_after(dispatch_time(DISPATCH_TIME_NOW,10*NSEC_PER_MSEC),dispatch_get_main_queue(),begin);return;}begin=nil;
        for(NSUInteger identity=6001;identity<=6002;identity++){NSMutableDictionary *event=Event(identity,identity==6001,NO,identity==6001);event[@"created"]=@(floor(NSDate.date.timeIntervalSince1970));[manager receiveNativeSession:event[@"conversation"] wrap:event epoch:epoch completion:^(BOOL claim){CHECK(claim);}];}
        NSMutableDictionary *pat=Event(6003,YES,NO,NO);pat[@"created"]=@(floor(NSDate.date.timeIntervalSince1970));[manager receivePat:pat conversation:@"room@chatroom" epoch:epoch];
    };dispatch_async(dispatch_get_main_queue(),begin);
    __block void (^finish)(void);finish=^{if(sendCount==3 && patCount==1 && revokeCount==1){finish=nil;CHECK(!controlNSTimerFired && !protectedAvailable);CHECK(UIApplication.sharedApplication.applicationState==UIApplicationStateBackground);CHECK(dispatch_get_specific(&MainQueueKey)!=NULL);CHECK([[manager valueForKey:@"waitingIngress"] count]==0);printf("A/B/C dispatch-only Locked Background: ProtectedData=NO text=3 (mention=1 keyword=1 patReply=1) pat=1 revoke=1; NSTimerControl=0; noUnlockNotification; NSRunLoop was never pumped after dispatch_main\n");printf("Automation dispatch timer: %lu checks passed\n",(unsigned long)checks);fflush(stdout);exit(0);}dispatch_after(dispatch_time(DISPATCH_TIME_NOW,20*NSEC_PER_MSEC),dispatch_get_main_queue(),finish);};dispatch_async(dispatch_get_main_queue(),finish);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,8*NSEC_PER_SEC),dispatch_get_main_queue(),^{fprintf(stderr,"F dispatch-only failure: text=%lu pat=%lu revoke=%lu NSTimerControl=%d\n",(unsigned long)sendCount,(unsigned long)patCount,(unsigned long)revokeCount,controlNSTimerFired);exit(1);});
    dispatch_main();
}
int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2 || argc==3);testRoot=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];sent=[NSMutableArray array];pats=[NSMutableArray array];revoked=[NSMutableArray array];observations=[NSMapTable strongToStrongObjectsMapTable];
    if(argc==3){if(!strcmp(argv[2],"--background"))return BackgroundCases();if(!strcmp(argv[2],"--dispatch-only"))DispatchOnly();CHECK(NO);}
    AutomationTestManager *manager=Manager();CHECK([manager.accountID isEqual:@"alice"]);Keyword(manager,5,NO,YES);
    NSMutableDictionary *event=Event(1,NO,NO,NO);__block NSUInteger callbacks=0;__block BOOL callbackBeforeSend=NO;
    [manager receiveNativeSession:@"bob" wrap:event epoch:epoch completion:^(BOOL claimed){CHECK(claimed);callbacks++;callbackBeforeSend=sendCount==0;}];
    NSMutableDictionary *alias=[event mutableCopy];alias[@"identifiers"]=[event[@"identifiers"] arrayByAddingObject:@"alice|bob|s:100"];
    [manager receiveNativeSession:@"bob" wrap:alias epoch:epoch completion:^(BOOL claimed){CHECK(claimed);callbacks++;}];
    Wait(^BOOL{return callbacks==2;});CHECK(callbackBeforeSend);CHECK(Pending(manager)==1);CHECK(sendCount==0);
    NSString *chosen=[[[manager valueForKey:@"tasks"] allValues].firstObject valueForKey:@"text"];CHECK([@[@"one",@"two"] containsObject:chosen]);
    Advance(manager,4);CHECK(sendCount==0);Advance(manager,1);CHECK(sendCount==1);CHECK([sent.lastObject[@"text"] isEqual:chosen]);CHECK(Pending(manager)==0);CHECK(marks==1 && remembered==2);
    NSMutableDictionary *serverOnly=[event mutableCopy];serverOnly[@"identifiers"]=@[@"alice|bob|s:100"];serverOnly[@"created"]=@(wall);
    CHECK(Receive(manager,serverOnly));CHECK(Pending(manager)==0 && sendCount==1);
    // Reopening the same account never replays a durably claimed message.
    AutomationTestManager *reopened=Manager();CHECK(Receive(reopened,serverOnly));CHECK(Pending(reopened)==0);
    NSMutableDictionary *ownBeforeStartup=Event(998,NO,YES,NO);ownBeforeStartup[@"created"]=@(wall-3);CHECK(!Receive(reopened,ownBeforeStartup));CHECK(Pending(reopened)==0);[NSNotificationCenter.defaultCenter removeObserver:reopened];
    // Startup arbitration waits for rules/claims instead of allowing AI to race
    // a cold configuration load. The same timer bounds ingress waiting to 10m.
    AutomationTestManager *cold=[AutomationTestManager new];__block BOOL coldDone=NO,coldClaim=NO;
    [cold receiveNativeSession:@"bob" wrap:serverOnly epoch:epoch completion:^(BOOL claim){coldDone=YES;coldClaim=claim;}];CHECK(!coldDone);Wait(^BOOL{return coldDone;});CHECK(coldClaim && Pending(cold)==0);[NSNotificationCenter.defaultCenter removeObserver:cold];
    AutomationTestManager *stalled=[AutomationTestManager new];dispatch_semaphore_t releaseLoad=dispatch_semaphore_create(0);dispatch_queue_t stalledIO=[stalled valueForKey:@"io"];
    dispatch_async(stalledIO,^{dispatch_semaphore_wait(releaseLoad,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC));});
    __block NSUInteger stalledCallbacks=0;[stalled receiveNativeSession:@"bob" wrap:Event(999,NO,NO,NO) epoch:epoch completion:^(BOOL claim){CHECK(!claim);stalledCallbacks++;}];
    CHECK(stalledCallbacks==0);Advance(stalled,601);CHECK(stalledCallbacks==1);dispatch_semaphore_signal(releaseLoad);Wait(^BOOL{return stalled.ready;});CHECK(stalledCallbacks==1 && Pending(stalled)==0);[NSNotificationCenter.defaultCenter removeObserver:stalled];
    CHECK(Receive(manager,Event(2,NO,YES,NO)));CHECK(Pending(manager)==1);Advance(manager,306);CHECK(sendCount==1 && Pending(manager)==0);
    // Freshness and explicit selection reject historical/unselected callbacks.
    NSMutableDictionary *old=Event(3,NO,NO,NO);old[@"created"]=@(wall-121);CHECK(!Receive(manager,old));
    NSMutableDictionary *unselected=Event(4,NO,NO,NO);unselected[@"conversation"]=@"stranger";CHECK(!Receive(manager,unselected));
    NSMutableDictionary *future=Event(5,NO,NO,NO);future[@"created"]=@(wall+31);CHECK(!Receive(manager,future));
    // Rule changes cancel delayed work but retain its shared text claim.
    NSMutableDictionary *canceled=Event(6,NO,NO,NO);CHECK(Receive(manager,canceled));Keyword(manager,8,NO,YES);CHECK(Pending(manager)==0);
    canceled[@"created"]=@(wall);CHECK(Receive(manager,canceled));CHECK(Pending(manager)==0);
    NSMutableDictionary *off=Module(manager,@"keywordReply");off[@"enabled"]=@NO;Save(manager,@{@"keywordReply":off});canceled[@"created"]=@(wall-200);
    CHECK(Receive(manager,canceled));CHECK(!Receive(manager,Event(600,NO,NO,NO)));Keyword(manager,8,NO,YES);
    // A later identity bridge retracts both queued observations rather than
    // allowing two tasks whose durable aliases now describe the same message.
    NSMutableDictionary *localObservation=Event(20,NO,NO,NO),*remoteObservation=Event(21,NO,NO,NO);
    remoteObservation[@"identifiers"]=@[@"alice|bob|s:2021"];CHECK(Receive(manager,localObservation));CHECK(Receive(manager,remoteObservation));CHECK(Pending(manager)==2);
    NSMutableDictionary *bridge=[localObservation mutableCopy];bridge[@"identifiers"]=[localObservation[@"identifiers"] arrayByAddingObject:@"alice|bob|s:2021"];
    CHECK(Receive(manager,bridge));CHECK(Pending(manager)==0);
    // Genuine group @ gets one text action even when a keyword also matches.
    NSMutableDictionary *mention=Module(manager,@"mentionReply");[mention addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"delay":@0,@"contents":@[@"mention answer"],@"mention":@YES}];Save(manager,@{@"mentionReply":mention});
    CHECK(Receive(manager,Event(7,YES,NO,YES)));CHECK(sendCount==2);CHECK([sent.lastObject[@"target"] isEqual:@"room@chatroom"]);CHECK([sent.lastObject[@"mentions"] isEqual:@[@"bob"]]);CHECK([sent.lastObject[@"text"] isEqual:@"@成员甲\u2005mention answer"]);
    // A final native preparation boundary can revoke authorization before submit.
    duringPreparation=^{authorized=NO;};CHECK(Receive(manager,Event(8,YES,NO,YES)));CHECK(sendCount==2 && Pending(manager)==1);authorized=YES;Save(manager,@{@"mentionReply":mention});CHECK(Pending(manager)==0);
    // A selected but unavailable recipient is rechecked at the actual send.
    CHECK(Receive(manager,Event(9,NO,NO,NO)));contactsAvailable=NO;Advance(manager,8);CHECK(sendCount==2 && Pending(manager)==1);contactsAvailable=YES;Save(manager,@{@"keywordReply":Module(manager,@"keywordReply")});CHECK(Pending(manager)==0);
    // Quote waits only for the original identity, retains the random choice,
    // and uses its original deadline rather than silently falling back to text.
    Keyword(manager,0,YES,YES);NSMutableDictionary *own=Event(10,NO,YES,NO);own[@"source"]=[@{@"m_n64MesSvrID":@0,@"m_uiMesLocalID":@10,@"ids":own[@"identifiers"]} mutableCopy];
    CHECK(Receive(manager,own));CHECK(sendCount==2 && Pending(manager)==1);chosen=[[[manager valueForKey:@"tasks"] allValues].firstObject valueForKey:@"text"];
    Advance(manager,1);CHECK(Pending(manager)==1 && sendCount==2);updatedQuoteSource=@{@"m_n64MesSvrID":@20,@"m_uiMesLocalID":@10,@"ids":own[@"identifiers"]};Advance(manager,1);
    CHECK(sendCount==3 && [sent.lastObject[@"quote"] boolValue]);CHECK([sent.lastObject[@"text"] isEqual:chosen]);updatedQuoteSource=nil;
    NSMutableDictionary *missing=Event(11,NO,YES,NO);missing[@"source"]=@{@"m_n64MesSvrID":@0,@"m_uiMesLocalID":@11};CHECK(Receive(manager,missing));Advance(manager,301);CHECK(sendCount==3 && Pending(manager)==0);
    // Two pat modules maintain independent claims, delays and conversation lists.
    NSMutableDictionary *back=Module(manager,@"patBack"),*reply=Module(manager,@"patReply");
    [back addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"delay":@2,@"revoke":@YES,@"revokeDelay":@3}];
    [reply addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"delay":@1,@"contents":@[@"pat answer"],@"mention":@YES}];Save(manager,@{@"patBack":back,@"patReply":reply});
    NSMutableDictionary *pat=Event(12,YES,NO,NO);[manager receivePat:pat conversation:@"room@chatroom" epoch:epoch];Wait(^BOOL{return Pending(manager)==2;});
    Advance(manager,1);CHECK(sendCount==4 && patCount==0);Advance(manager,1);CHECK(patCount==1 && Pending(manager)==1 && revokeCount==0);
    id exactPat=pats.lastObject;void(^success)(BOOL)=[observations objectForKey:exactPat];CHECK(success!=nil);Advance(manager,10);CHECK(revokeCount==0);success(YES);success(YES);
    CHECK(Pending(manager)==1);Advance(manager,2);CHECK(revokeCount==0);Advance(manager,1);CHECK(revokeCount==1 && revoked.lastObject==exactPat);CHECK(Pending(manager)==0);
    [manager receivePat:pat conversation:@"room@chatroom" epoch:epoch];Drain();CHECK(Pending(manager)==0 && patCount==1);
    // An unconfirmed accepted pat never starts its revoke countdown.
    [manager receivePat:Event(13,YES,NO,NO) conversation:@"room@chatroom" epoch:epoch];Wait(^BOOL{return Pending(manager)==2;});Advance(manager,2);CHECK(patCount==2);id unconfirmed=pats.lastObject;
    CHECK([observations objectForKey:unconfirmed]!=nil);Advance(manager,30);CHECK(Pending(manager)==0 && [observations objectForKey:unconfirmed]==nil && revokeCount==1);
    // Other module edits and delay/list changes keep cleanup for an already
    // submitted exact pat, while an explicit revoke-off cancels it.
    [manager receivePat:Event(14,YES,NO,NO) conversation:@"room@chatroom" epoch:epoch];Wait(^BOOL{return Pending(manager)==2;});Advance(manager,2);id preserved=pats.lastObject;void(^preservedSuccess)(BOOL)=[observations objectForKey:preserved];preservedSuccess(YES);
    back=Module(manager,@"patBack");back[@"groups"]=@[];back[@"delay"]=@9;Save(manager,@{@"patBack":back});CHECK(Pending(manager)==1);Advance(manager,3);CHECK(revokeCount==2 && revoked.lastObject==preserved);
    back=Module(manager,@"patBack");back[@"groups"]=@[@"room@chatroom"];back[@"delay"]=@0;Save(manager,@{@"patBack":back});
    [manager receivePat:Event(15,YES,NO,NO) conversation:@"room@chatroom" epoch:epoch];Wait(^BOOL{return [observations objectForKey:pats.lastObject]!=nil;});id stopped=pats.lastObject;void(^lateSuccess)(BOOL)=[observations objectForKey:stopped];
    back=Module(manager,@"patBack");back[@"revoke"]=@NO;Save(manager,@{@"patBack":back});lateSuccess(YES);CHECK(Pending(manager)==0);Advance(manager,4);CHECK(revokeCount==2);
    // Restore invalidates all in-memory work and reloads the account's rules.
    Keyword(manager,10,NO,NO);CHECK(Receive(manager,Event(16,NO,NO,NO)));CHECK(Pending(manager)==1);NSUInteger generation=manager.configurationGeneration;
    [NSNotificationCenter.defaultCenter postNotificationName:@"CSAutomationRestoreDidComplete" object:nil];Wait(^BOOL{return manager.ready;});CHECK(manager.configurationGeneration>generation && Pending(manager)==0);Advance(manager,10);CHECK(sendCount==6);
    // A -> B -> A has distinct epochs; no previous task becomes valid again.
    CHECK(Receive(manager,Event(17,NO,NO,NO)));CHECK(Pending(manager)==1);account=@"carol";epoch++;[manager refresh];Wait(^BOOL{return manager.ready;});CHECK(Pending(manager)==0 && [manager.accountID isEqual:@"carol"]);
    account=@"alice";epoch++;[manager refresh];Wait(^BOOL{return manager.ready;});CHECK(Pending(manager)==0);Advance(manager,10);CHECK(sendCount==6);
    // Native ordinary-message timestamps have whole-second resolution. A
    // message from the same second as enabling/restarting must not be revived.
    wall+=0.5;Keyword(manager,10,NO,YES);NSMutableDictionary *sameSecond=Event(180,NO,YES,NO);sameSecond[@"created"]=@(floor(wall));
    CHECK(!Receive(manager,sameSecond));CHECK(Pending(manager)==0);Advance(manager,0.5);
    // A corrupt durable ledger halts both new and already queued automatic
    // actions, preserving the unreadable file rather than resetting history.
    CHECK(Receive(manager,Event(18,NO,NO,NO)));CHECK(Pending(manager)==1);
    NSURL *runtime=[[CSAutomationFileURL(testRoot,account) URLByDeletingPathExtension] URLByAppendingPathExtension:@"runtime.plist"];
    NSData *lastGoodRuntime=[NSData dataWithContentsOfURL:runtime];CHECK(lastGoodRuntime!=nil);
    CHECK([[@"broken ledger" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:runtime atomically:YES]);
    CHECK(!Receive(manager,Event(19,NO,NO,NO)));CHECK(!manager.ready && Pending(manager)==1);CHECK([[NSString stringWithContentsOfURL:runtime encoding:NSUTF8StringEncoding error:NULL] isEqual:@"broken ledger"]);Advance(manager,10);Wait(^BOOL{return ![[manager valueForKey:@"loading"] boolValue];});CHECK(!manager.ready && Pending(manager)==1 && sendCount==6);
    // Only this fixture restores its own previously captured runtime bytes;
    // production never replaces or clears a corrupt ledger to make work run.
    CHECK([lastGoodRuntime writeToURL:runtime atomically:YES]);[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationProtectedDataDidBecomeAvailable object:nil];Wait(^BOOL{return manager.ready;});CHECK(Pending(manager)==0 && sendCount==7);CHECK(Receive(manager,Event(18,NO,NO,NO)));CHECK(sendCount==7);
    printf("D8 Durable storage unavailable: existingClaimRetained=1 corruptBytesPreserved=yes explicitFixtureRecoverySubmits=1\n");
    CHECK(cancellations>=4);[NSNotificationCenter.defaultCenter removeObserver:manager];
    printf("Automation manager: %lu checks passed\n",(unsigned long)checks);
}return 0;}
