// Reuse only the isolated account/storage environment and recording send seams.
// Native ABI dispatch, manager, store and shared budget remain real.
// Event normalization is covered separately by AutomationPatIngressTests.m.
#import "CSMessageNativeActionAdapter.h"
#import "CSBackgroundSyncBudget.h"
#define CSMessageNativeSupports CSBackgroundFixtureNativeSupports
#define CSMessageNativeInvoke CSBackgroundFixtureNativeInvoke
#define CSMessageNativeUnsigned CSBackgroundFixtureNativeUnsigned
#define CSMessageActionNativeObject CSBackgroundFixtureNativeObject
#define main CSAutomationManagerFixtureUnusedMain
#import "AutomationManagerTests.m"
#undef main
#undef CSMessageNativeSupports
#undef CSMessageNativeInvoke
#undef CSMessageNativeUnsigned
#undef CSMessageActionNativeObject

@interface CSAutomationManager (BackgroundSyncFixture)
- (BOOL)backgroundSyncEligible;
- (void)backgroundSyncTick;
- (void)refreshBackgroundSync;
- (void)stopBackgroundSync;
@end

@interface TestNewSyncService : NSObject
@property(nonatomic) BOOL busy,accepted,throwsRequest,lastAcceptedReturn;
@property(nonatomic) NSUInteger requests,completedRequests,exceptions,getters;
@property(nonatomic,copy) dispatch_block_t duringGetter,duringRequest;
- (BOOL)isGettingData;
- (BOOL)BackGroundFetchToSync;
@end
@implementation TestNewSyncService
- (BOOL)isGettingData {
    self.getters++;
    dispatch_block_t action=self.duringGetter;self.duringGetter=nil;if(action)action();
    return self.busy;
}
- (BOOL)BackGroundFetchToSync {
    self.requests++;
    dispatch_block_t action=self.duringRequest;self.duringRequest=nil;if(action)action();
    if(self.throwsRequest){self.exceptions++;[NSException raise:@"SyncFixture" format:@"Native request exception"];}
    BOOL accepted=self.accepted;self.completedRequests++;self.lastAcceptedReturn=accepted;return accepted;
}
@end

@interface TestSyncEnvironment : CSMessageNativeEnvironment
@property(nonatomic,strong) TestNewSyncService *sync;
@property(nonatomic) BOOL throwsAccount;
@end
@implementation TestSyncEnvironment
- (NSString *)currentAccountID {
    if(self.throwsAccount)[NSException raise:@"AccountFixture" format:@"Account temporarily unavailable"];
    return [super currentAccountID];
}
- (id)serviceNamed:(NSString *)name {
    return [name isEqual:@"NewSyncService"]?self.sync:[super serviceNamed:name];
}
@end

static void SyncAdvance(NSTimeInterval seconds) {uptime+=seconds;wall+=seconds;}
static void SyncConfigure(CSAutomationManager *manager,BOOL backEnabled,BOOL replyEnabled,NSUInteger delay) {
    NSMutableDictionary *back=Module(manager,@"patBack"),*reply=Module(manager,@"patReply");
    [back addEntriesFromDictionary:@{@"enabled":@(backEnabled),@"friends":@[@"bob"],@"groups":@[@"room@chatroom"],@"delay":@(delay),@"revoke":@NO}];
    [reply addEntriesFromDictionary:@{@"enabled":@(replyEnabled),@"friends":@[@"bob"],@"groups":@[@"room@chatroom"],@"delay":@(delay),@"contents":@[@"pat answer"],@"mention":@YES}];
    Save(manager,@{@"patBack":back,@"patReply":reply});
}
static void SyncEnterBackground(CSAutomationManager *manager) {
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];
    [manager refreshBackgroundSync];
}

int main(int argc,const char **argv) {@autoreleasepool {
    CHECK(argc==2);testRoot=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    sent=[NSMutableArray array];pats=[NSMutableArray array];revoked=[NSMutableArray array];observations=[NSMapTable strongToStrongObjectsMapTable];
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;protectedAvailable=NO;
    CSBackgroundSyncBudget.sharedBudget.now=^{return uptime;};
    // No AI manager or AI configuration is linked into this executable.
    CHECK(NSClassFromString(@"CSAIReplyManager")==Nil);
    TestNewSyncService *service=[TestNewSyncService new];service.accepted=YES;
    CHECK(CSMessageNativeSupports(service,@"isGettingData",@"B",@[]));
    CHECK(CSMessageNativeSupports(service,@"BackGroundFetchToSync",@"B",@[]));
    TestSyncEnvironment *environment=[TestSyncEnvironment new];environment.sync=service;
    AutomationTestManager *manager=[AutomationTestManager new];[manager setValue:environment forKey:@"environment"];
    [manager start];Wait(^BOOL{return manager.ready;});SyncConfigure(manager,YES,NO,2);
    CHECK(![manager backgroundSyncEligible] && service.requests==0);
    // Contact refresh may itself require synchronization. It cannot prevent pull.
    contactsAvailable=NO;SyncEnterBackground(manager);
    CHECK([manager backgroundSyncEligible] && [manager valueForKey:@"backgroundSyncTimer"]!=nil);
    Wait(^BOOL{return service.requests==1;});
    CHECK(service.requests==1 && service.completedRequests==1);
    CHECK(service.lastAcceptedReturn && service.completedRequests==1);
    for(NSUInteger i=0;i<5;i++)[manager backgroundSyncTick];
    SyncAdvance(44);[manager backgroundSyncTick];CHECK(service.requests==1);
    SyncAdvance(1);[manager backgroundSyncTick];CHECK(service.requests==2);
    printf("Pat-only background timer: AI class/config absent, locked/contact-unavailable pull=1; attempt interval>=45s\n");

    contactsAvailable=YES;SyncConfigure(manager,YES,YES,2);
    NSUInteger previous=service.requests;[manager backgroundSyncTick];CHECK(service.requests==previous);
    SyncAdvance(45);service.duringRequest=^{[manager backgroundSyncTick];};
    [manager backgroundSyncTick];CHECK(service.requests==previous+1);
    CHECK(service.completedRequests==service.requests && service.exceptions==0);
    printf("Both pat modules and reentrant request: one native request, shared cooldown retained across configuration edit\n");

    // Future timer checks must survive temporary availability loss without any
    // incoming message, foreground event or configuration refresh to restart it.
    previous=service.requests;accountAvailable=NO;SyncAdvance(45);[manager backgroundSyncTick];
    CHECK(service.requests==previous && [manager valueForKey:@"backgroundSyncTimer"]!=nil);
    accountAvailable=YES;SyncAdvance(45);[manager backgroundSyncTick];CHECK(service.requests==previous+1);
    previous=service.requests;environment.throwsAccount=YES;SyncAdvance(45);[manager backgroundSyncTick];
    CHECK(service.requests==previous && [manager valueForKey:@"backgroundSyncTimer"]!=nil);
    environment.throwsAccount=NO;SyncAdvance(45);[manager backgroundSyncTick];CHECK(service.requests==previous+1);
    previous=service.requests;authorized=NO;SyncAdvance(45);[manager backgroundSyncTick];
    CHECK(service.requests==previous && [manager valueForKey:@"backgroundSyncTimer"]!=nil);
    authorized=YES;SyncAdvance(45);[manager backgroundSyncTick];CHECK(service.requests==previous+1);
    printf("Temporary nil/throwing account getter and unavailable authorization: future wake retained, recovered pull without external notification\n");

    service.busy=YES;previous=service.requests;NSUInteger gettersBefore=service.getters;SyncAdvance(45);
    [manager backgroundSyncTick];[manager backgroundSyncTick];
    CHECK(service.requests==previous && service.getters>gettersBefore);
    service.busy=NO;service.accepted=NO;NSUInteger completedBefore=service.completedRequests;SyncAdvance(45);[manager backgroundSyncTick];
    CHECK(service.requests==previous+1 && service.completedRequests==completedBefore+1 && !service.lastAcceptedReturn);
    for(NSUInteger i=0;i<5;i++)[manager backgroundSyncTick];
    SyncAdvance(44);[manager backgroundSyncTick];CHECK(service.requests==previous+1);
    SyncAdvance(1);service.accepted=YES;[manager backgroundSyncTick];CHECK(service.requests==previous+2);
    printf("Native busy skips pull; native NO consumes attempt and cannot retry before 45s\n");

    previous=service.requests;completedBefore=service.completedRequests;NSUInteger exceptionsBefore=service.exceptions;service.throwsRequest=YES;SyncAdvance(45);[manager backgroundSyncTick];
    CHECK(service.requests==previous+1 && service.exceptions==exceptionsBefore+1 && service.completedRequests==completedBefore);
    [manager backgroundSyncTick];SyncAdvance(44);[manager backgroundSyncTick];CHECK(service.requests==previous+1);
    service.throwsRequest=NO;SyncAdvance(1);[manager backgroundSyncTick];CHECK(service.requests==previous+2);
    CHECK(service.completedRequests==service.requests-service.exceptions && service.exceptions==1);
    printf("Native exception retains budget; completedRequests counts only returned native calls\n");

    // A real asynchronous configuration save begins inside the native getter.
    // The original request must not cross that generation/saving boundary.
    __block BOOL editDone=NO,editOK=NO;previous=service.requests;
    NSMutableDictionary *disabledBack=Module(manager,@"patBack"),*disabledReply=Module(manager,@"patReply");
    disabledBack[@"enabled"]=@NO;disabledReply[@"enabled"]=@NO;
    service.duringGetter=^{
        [manager updateConfiguration:@{@"patBack":disabledBack,@"patReply":disabledReply} completion:^(BOOL ok,NSError *error){(void)error;editOK=ok;editDone=YES;}];
    };
    SyncAdvance(45);[manager backgroundSyncTick];CHECK(service.requests==previous);
    Wait(^BOOL{return editDone;});CHECK(editOK && ![manager backgroundSyncEligible]);
    CHECK([manager valueForKey:@"backgroundSyncTimer"]==nil);
    SyncAdvance(90);[manager backgroundSyncTick];CHECK(service.requests==previous);
    printf("Native getter configuration-save reentry rejects stale pull; disabling both modules stops timer\n");

    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;SyncConfigure(manager,YES,YES,2);
    SyncEnterBackground(manager);previous=service.requests;
    service.duringGetter=^{account=@"carol";epoch++;[manager refresh];};
    [manager backgroundSyncTick];CHECK(service.requests==previous);
    Wait(^BOOL{return manager.ready;});CHECK([manager.accountID isEqual:@"carol"] && ![manager backgroundSyncEligible]);
    CHECK(service.requests==previous);
    printf("Native getter account/epoch reentry rejects previous-account pull; new account has independent disabled rules\n");

    // Configure the new account while active so no timer can race the fixture.
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;SyncConfigure(manager,YES,YES,2);
    SyncEnterBackground(manager);previous=service.requests;
    service.duringGetter=^{[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];};
    [manager backgroundSyncTick];CHECK(service.requests==previous);
    // UIKit can still report background during WillEnterForeground delivery.
    CHECK(UIApplication.sharedApplication.applicationState==UIApplicationStateBackground);
    CHECK(![manager backgroundSyncEligible] && [manager valueForKey:@"backgroundSyncTimer"]==nil);
    SyncAdvance(90);[manager backgroundSyncTick];CHECK(service.requests==previous);
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
    [manager backgroundSyncTick];CHECK(service.requests==previous && [manager valueForKey:@"backgroundSyncTimer"]==nil);
    printf("WillEnterForeground stops pull even before app-state updates; active foreground remains stopped\n");

    // This is an injected post-pull event, not a simulated raw native hook or a
    // claim that a server message was fetched. Real raw ingress/parser coverage
    // lives in AutomationPatIngressTests.m and the separate device report.
    SyncEnterBackground(manager);SyncAdvance(1);
    NSMutableDictionary *pulledEvent=Event(81001,YES,NO,NO);
    service.duringRequest=^{[manager receivePat:pulledEvent conversation:@"room@chatroom" epoch:epoch];};
    NSUInteger textBefore=sendCount,patBefore=patCount;previous=service.requests;completedBefore=service.completedRequests;
    [manager backgroundSyncTick];CHECK(service.requests==previous+1);
    Wait(^BOOL{return Pending(manager)==2;});
    CHECK(sendCount==textBefore && patCount==patBefore);
    Advance(manager,2);CHECK(sendCount==textBefore+1 && patCount==patBefore+1 && Pending(manager)==0);
    [manager receivePat:pulledEvent conversation:@"room@chatroom" epoch:epoch];Drain();
    CHECK(sendCount==textBefore+1 && patCount==patBefore+1 && Pending(manager)==0);
    CHECK(service.requests==previous+1 && service.completedRequests==completedBefore+1);
    CSAutomationLedger *ledger=[manager valueForKey:@"ledger"];
    CHECK([ledger hasIdentifiers:pulledEvent[@"identifiers"] action:@"patBack"] && [ledger hasIdentifiers:pulledEvent[@"identifiers"] action:@"patReply"]);

    CHECK(!protectedAvailable && UIApplication.sharedApplication.applicationState==UIApplicationStateBackground);
    [manager stopBackgroundSync];[NSNotificationCenter.defaultCenter removeObserver:manager];
    printf("Injected post-pull event -> real durable manager: one pat + one text; duplicate suppressed; no server/raw-hook claim\n");
    printf("Automation background sync: %lu checks passed\n",(unsigned long)checks);
}return 0;}
