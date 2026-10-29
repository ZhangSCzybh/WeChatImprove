#import <Foundation/Foundation.h>
#import <stdatomic.h>
#import "CSBackupScheduler.h"
#import "CSBackupMutation.h"

static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static BOOL Near(NSTimeInterval a,NSTimeInterval b){return fabs(a-b)<0.00001;}
static BOOL ready=YES,suspended;
static NSUInteger recoveryResumes;
static BOOL CSBackupIsReady(void){return ready;}
static BOOL CSBackupAccountIsSuspended(void){return suspended;}
static void CSBackupResumeAfterRecovery(void){recoveryResumes++;}
static NSError *CSBackupFailure(NSString *message){return [NSError errorWithDomain:@"backup.scheduling.fixture" code:1 userInfo:@{NSLocalizedDescriptionKey:message}];}
static NSString *const AutoKey=@"fixture.auto";
static NSString *const UpgradeErrorKey=@"fixture.upgrade.error";
static NSString *const kPluginVersionString=@"fixture.version";
typedef void (^CSBackupCompletion)(id,NSError *);

@interface TestStore : NSObject
@property(nonatomic) NSDictionary *record;
@property(nonatomic) BOOL failRead;
@property(nonatomic) BOOL failArchive;
@property(nonatomic) NSUInteger reads;
- (NSDictionary *)journal:(NSError **)error;
- (BOOL)activationConfirmed:(NSDictionary *)journal;
- (BOOL)archiveJournal:(NSError **)error;
@end
@implementation TestStore
- (NSDictionary *)journal:(NSError **)error {self.reads++;if(self.failRead&&error)*error=CSBackupFailure(@"read failed");return self.record;}
- (BOOL)activationConfirmed:(NSDictionary *)journal {return YES;}
- (BOOL)archiveJournal:(NSError **)error {if(self.failArchive){if(error)*error=CSBackupFailure(@"archive failed");return NO;}self.record=nil;return YES;}
@end

@interface TestEngine : NSObject
@property(nonatomic) TestStore *store;
@property(nonatomic) NSMutableArray *saved;
@property(nonatomic) BOOL fail;
@property(nonatomic,copy) NSDictionary *(^snapshot)(void);
@property(nonatomic,copy) void (^duringSave)(void);
- (NSDictionary *)save:(NSString *)name kind:(NSString *)kind error:(NSError **)error;
- (BOOL)cancelPending:(NSError **)error;
- (NSUInteger)count:(NSString *)kind;
@end
@implementation TestEngine
- (instancetype)init {if((self=[super init])){_store=[TestStore new];_saved=[NSMutableArray array];}return self;}
- (NSDictionary *)save:(NSString *)name kind:(NSString *)kind error:(NSError **)error {
    if(self.fail){if(error)*error=CSBackupFailure(@"capture failed");return nil;}
    NSMutableDictionary *snapshot=[self.snapshot() mutableCopy];snapshot[@"kind"]=kind;snapshot[@"createdAt"]=NSDate.date;
    if(self.duringSave)self.duringSave();
    [self.saved addObject:snapshot];return snapshot;
}
- (BOOL)cancelPending:(NSError **)error {self.store.record=nil;return YES;}
- (NSUInteger)count:(NSString *)kind {NSUInteger count=0;for(NSDictionary *s in self.saved)if([s[@"kind"] isEqual:kind])count++;return count;}
@end

@interface TestManager : NSObject
@property(nonatomic) TestEngine *engine;
@property(nonatomic) CSBackupScheduler *scheduler;
@property(nonatomic) CSBackupChangeBatch *changes;
@property(nonatomic) dispatch_queue_t queue;
@property(nonatomic) NSUserDefaults *testDefaults;
@property(nonatomic) NSString *suite;
@property(nonatomic) NSString *status;
@property(nonatomic) NSString *signature;
@property(nonatomic) NSDictionary *observedContext;
@property(nonatomic) uint64_t observedResourceRevision;
@property(nonatomic) BOOL hasObservation,lastAutoEnabled,forceReconcile,forceAutomaticBackup,waitingForRecovery,upgradeRequested,active;
@property(nonatomic) NSTimeInterval now,armedDeadline;
@property(nonatomic) NSUInteger digests;
@property(nonatomic) NSString *configuration;
@property(nonatomic) NSDictionary *context;
@property(nonatomic,copy) void (^duringDigest)(void);
- (BOOL)isAutoBackupEnabled;
- (NSTimeInterval)uptime;
- (NSDictionary *)currentContext;
- (NSString *)preferenceSignature;
- (void)armTimerForDeadline:(NSTimeInterval)deadline;
- (void)processScheduledWork;
- (void)reconcileChangesAt:(NSTimeInterval)now;
- (void)tick;
- (void)changed:(NSNotification *)note;
- (void)resourceChanged:(NSNotification *)note;
- (void)noteChange:(CSBackupChangeKind)kind;
- (void)foreground:(NSNotification *)note;
- (void)background:(NSNotification *)note;
- (void)resumeScheduledWork;
- (void)enableAutoBackup:(BOOL)enabled;
- (BOOL)attemptUpgradeBackup:(NSError **)error;
- (void)create:(NSString *)name completion:(CSBackupCompletion)completion;
- (void)cancelPending:(CSBackupCompletion)completion;
- (void)perform:(id(^)(NSError **))work completion:(CSBackupCompletion)completion;
- (void)performRestore:(NSString *)stage work:(id(^)(NSError **))work completion:(CSBackupCompletion)completion;
- (void)close;
@end
@implementation TestManager
- (instancetype)init {
    if((self=[super init])){
        _queue=dispatch_queue_create("backup.scheduling.fixture",DISPATCH_QUEUE_SERIAL);
        _scheduler=[CSBackupScheduler new];_changes=[CSBackupChangeBatch new];_engine=[TestEngine new];
        _suite=[@"backup.scheduling.fixture." stringByAppendingString:NSUUID.UUID.UUIDString];
        _testDefaults=[[NSUserDefaults alloc]initWithSuiteName:_suite];
        [_testDefaults setObject:kPluginVersionString forKey:@"com.wechat.enhance.backup.protectedVersion"];
        _now=100;_active=YES;_configuration=@"A";_context=@{@"account":@"a",@"epoch":@1};_armedDeadline=DBL_MAX;
        __weak TestManager *weakSelf=self;
        _engine.snapshot=^{return @{@"configuration":weakSelf.configuration,@"context":weakSelf.context};};
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(resourceChanged:) name:@"CSBackupResourcesChanged" object:nil];
    }return self;
}
- (NSTimeInterval)uptime {return self.now;}
- (NSDictionary *)currentContext {return self.context;}
- (NSString *)preferenceSignature {self.digests++;NSString *value=self.configuration;if(self.duringDigest)self.duringDigest();return value;}
- (void)armTimerForDeadline:(NSTimeInterval)deadline {self.armedDeadline=deadline;}
- (void)perform:(id(^)(NSError **))work completion:(CSBackupCompletion)completion {dispatch_async(self.queue,^{NSError *error=nil;id result=work(&error);if(completion)completion(result,error);});}
- (void)performRestore:(NSString *)stage work:(id(^)(NSError **))work completion:(CSBackupCompletion)completion {[self perform:work completion:completion];}
- (void)close {dispatch_sync(self.queue,^{});[NSNotificationCenter.defaultCenter removeObserver:self];[self.testDefaults removePersistentDomainForName:self.suite];}
#import "BackupSchedulingUnderTest.h"
@end

static void Flush(TestManager *manager){dispatch_sync(manager.queue,^{});dispatch_sync(manager.queue,^{});}
static void Advance(TestManager *manager,NSTimeInterval time){manager.now=time;dispatch_sync(manager.queue,^{[manager processScheduledWork];});Flush(manager);}
static TestManager *Enabled(void){TestManager *m=[TestManager new];[m enableAutoBackup:YES];Flush(m);return m;}
static void Baseline(TestManager *m){Advance(m,130);Check([m.engine count:@"automatic"]==1&&!m.scheduler.dirty,@"baseline automatically saved");}

static void BatchTests(void){
    CSBackupChangeBatch *b=[CSBackupChangeBatch new];
    Check(b.deadline==DBL_MAX&&!b.take,@"empty batch has no deadline");
    __block atomic_uint enqueues;atomic_init(&enqueues,0);
    dispatch_apply(1000,dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^(size_t i){if([b note:CSBackupChangePreferences at:10])atomic_fetch_add(&enqueues,1);});
    Check(b.generation==1000&&atomic_load(&enqueues)==1,@"concurrent ingress retains every generation with one queued drain");
    Check(Near(b.deadline,10.3),@"burst trails last event by 300 ms");
    [b dequeued];for(int i=1;i<=30;i++)[b note:CSBackupChangePreferences at:10+i*0.1];
    Check(Near(b.deadline,12),@"continuous notices reconcile no later than first event plus two seconds");
    NSDictionary *taken=b.take;
    [b note:CSBackupChangeResources at:14];
    Check([taken[@"generation"] unsignedLongLongValue]==1030&&b.generation==1031&&Near(b.deadline,14.3),@"taking one generation preserves the next batch");
    Check([b.take[@"kind"] unsignedIntegerValue]==CSBackupChangeResources,@"later resource event is retained");
}
static void DisabledAndBackgroundTests(void){
    TestManager *m=[TestManager new];
    [m enableAutoBackup:NO];Flush(m);m.configuration=@"disabled change";
    for(int i=0;i<100;i++)[m changed:nil];Flush(m);
    Check(!m.digests&&!m.engine.saved.count&&m.armedDeadline==DBL_MAX,@"disabled burst performs no digest/capture and leaves no timer");
    [m enableAutoBackup:YES];Flush(m);
    Check(m.digests==1&&m.scheduler.dirty,@"enabling reconciles all changes made while disabled");
    Advance(m,130);
    Check([m.engine.saved.lastObject[@"configuration"] isEqual:@"disabled change"],@"reenabled backup includes disabled-period state");
    NSUInteger digests=m.digests,saves=m.engine.saved.count;
    [m background:nil];Flush(m);m.now=200;m.configuration=@"background change";
    [m changed:nil];Flush(m);Advance(m,250);
    Check(m.digests==digests&&m.engine.saved.count==saves&&m.armedDeadline==DBL_MAX,@"background changes retain pending work without digest/capture/timer");
    [m foreground:nil];Flush(m);Advance(m,280);
    Check([m.engine.saved.lastObject[@"configuration"] isEqual:@"background change"],@"foreground reconciles background changes");
    saves=m.engine.saved.count;[m background:nil];Flush(m);[m foreground:nil];Flush(m);
    Check(m.engine.saved.count==saves&&!m.scheduler.dirty&&m.armedDeadline==DBL_MAX,@"unchanged foreground performs no automatic capture");
    [m close];
}
static void DebounceTests(void){
    TestManager *m=Enabled();Baseline(m);NSUInteger digests=m.digests;
    m.now=200;for(int i=0;i<100;i++)[m changed:nil];Flush(m);
    Check(m.digests==digests&&Near(m.armedDeadline,200.3),@"defaults burst waits for its trailing deadline");
    Advance(m,200.31);
    Check(m.digests==digests+1&&!m.scheduler.dirty&&m.armedDeadline==DBL_MAX,@"one unchanged digest creates no capture or idle wake");
    m.now=300;m.configuration=@"B";[m changed:nil];Flush(m);
    for(int i=1;i<20;i++){m.now=300+i*0.1;[m changed:nil];Flush(m);}
    Check(m.digests==digests+1&&Near(m.armedDeadline,302),@"steady defaults stream retains the maximum two-second deadline");
    Advance(m,302);
    Check(m.digests==digests+2&&m.scheduler.dirty&&Near(m.scheduler.deadline,331.9),@"bounded digest retains original event time for quiet scheduling");
    Advance(m,331.9);Check([m.engine count:@"automatic"]==2,@"quiet interval remains thirty seconds after the last change");
    [m close];
}
static void WriterTests(void){
    TestManager *m=Enabled();Baseline(m);
    __attribute__((objc_precise_lifetime)) CSBackupMutation *first=[CSBackupMutation new],*second=[CSBackupMutation new];
    m.now=200;m.configuration=@"writer change";[m changed:nil];Flush(m);NSUInteger digests=m.digests;
    Advance(m,300);
    Check(m.digests==digests&&[m.engine count:@"automatic"]==1&&m.armedDeadline==DBL_MAX,@"active writers defer digest and capture without polling");
    first=nil;Flush(m);
    Check(CSBackupResourceWriteInProgress()&&m.armedDeadline==DBL_MAX,@"first overlapping writer completion cannot resume capture");
    second=nil;Flush(m);Advance(m,300.31);Advance(m,330);
    Check(!CSBackupResourceWriteInProgress()&&[m.engine count:@"automatic"]==2,@"final writer completion explicitly resumes one backup");
    [m close];
}
static void GenerationTests(void){
    TestManager *m=Enabled();__weak TestManager *weak=m;
    m.engine.duringSave=^{weak.engine.duringSave=nil;weak.now=130.05;weak.configuration=@"B";[weak changed:nil];};
    Advance(m,130);
    Check([m.engine.saved.firstObject[@"configuration"] isEqual:@"A"]&&m.changes.deadline<DBL_MAX,@"notice arriving during save remains pending after success");
    Advance(m,130.36);
    Check(m.scheduler.dirty&&Near(m.scheduler.deadline,160.05),@"successful old generation cannot swallow a later effective preference change");
    Advance(m,160.06);
    Check([m.engine.saved.lastObject[@"configuration"] isEqual:@"B"]&&[m.engine count:@"automatic"]==2,@"later generation receives its own capture");
    [m close];
    m=[TestManager new];weak=m;
    m.duringDigest=^{weak.duringDigest=nil;weak.now=100.05;weak.configuration=@"B";[weak changed:nil];};
    [m enableAutoBackup:YES];Flush(m);
    Check([m.signature isEqual:@"A"]&&m.changes.deadline<DBL_MAX,@"notice during digest survives batch consumption");
    Advance(m,100.36);
    Check([m.signature isEqual:@"B"]&&m.scheduler.dirty,@"next digest sees the generation received during the prior digest");
    [m close];
    m=Enabled();weak=m;
    m.engine.duringSave=^{weak.engine.duringSave=nil;weak.context=@{@"account":@"b",@"epoch":@2};};
    Advance(m,130);Advance(m,130.31);
    Check(m.scheduler.dirty&&[m.observedContext[@"epoch"] isEqual:@2],@"account boundary during save forces reconciliation even before delayed notification");
    Advance(m,160);
    Check([m.engine.saved.lastObject[@"context"][@"account"] isEqual:@"b"],@"old account save cannot mark new account context covered");
    [m close];
}
static void RecoveryAndPolicyTests(void){
    TestManager *m=[TestManager new];m.active=NO;[m.testDefaults removeObjectForKey:@"com.wechat.enhance.backup.protectedVersion"];
    ready=NO;[m resumeScheduledWork];Flush(m);
    Check(!m.engine.saved.count&&!m.digests&&m.armedDeadline==DBL_MAX,@"not-ready work waits without polling");
    ready=YES;[m resumeScheduledWork];Flush(m);
    Check([m.engine count:@"upgrade"]==1&&!m.digests&&m.armedDeadline==DBL_MAX,@"readiness resumes version backup while automatic is disabled and app inactive");
    __block BOOL manual=NO;[m create:@"manual" completion:^(id value,NSError *error){manual=value!=nil&&!error;}];Flush(m);
    Check(manual&&[m.engine count:@"manual"]==1&&!m.digests,@"manual capture stays independent of automatic state");
    [m close];
    m=[TestManager new];m.upgradeRequested=YES;
    [m.testDefaults removeObjectForKey:@"com.wechat.enhance.backup.protectedVersion"];
    __weak TestManager *weak=m;
    m.engine.duringSave=^{weak.engine.duringSave=nil;[weak enableAutoBackup:NO];};
    [m enableAutoBackup:YES];Flush(m);
    Check([m.engine count:@"upgrade"]==1&&!m.digests&&m.armedDeadline==DBL_MAX,@"disabling during optional upgrade prevents subsequent automatic digest");
    [m close];
    m=[TestManager new];m.upgradeRequested=YES;
    [m.testDefaults removeObjectForKey:@"com.wechat.enhance.backup.protectedVersion"];weak=m;
    m.engine.duringSave=^{weak.engine.duringSave=nil;[weak background:nil];};
    [m enableAutoBackup:YES];Flush(m);
    Check([m.engine count:@"upgrade"]==1&&!m.digests&&m.armedDeadline==DBL_MAX,@"background boundary during optional upgrade prevents automatic digest");
    [m close];
    m=Enabled();m.engine.store.record=@{@"state":@"prepared"};Advance(m,130);
    NSUInteger reads=m.engine.store.reads;
    Check(m.waitingForRecovery&&m.armedDeadline==DBL_MAX&&!m.engine.saved.count,@"prepared recovery disarms automatic work");
    Advance(m,1000);Check(m.engine.store.reads==reads,@"unresolved journal does not poll");
    __block BOOL cancelled=NO;[m cancelPending:^(id value,NSError *error){cancelled=value!=nil&&!error;}];Flush(m);
    Check(cancelled&&recoveryResumes>0&&!m.waitingForRecovery&&[m.engine count:@"automatic"]==1,@"cancelling recovery explicitly reschedules pending backup");
    [m close];
    m=Enabled();m.engine.store.failRead=YES;Advance(m,130);
    Check(m.scheduler.dirty&&Near(m.armedDeadline,190),@"journal read failure retains the sixty-second retry policy");
    m.engine.store.failRead=NO;Advance(m,190);
    Check([m.engine count:@"automatic"]==1&&m.armedDeadline==DBL_MAX,@"successful retry clears its only deadline");
    [m close];
    m=Enabled();m.engine.store.record=@{@"state":@"rolledBack"};m.engine.store.failArchive=YES;Advance(m,130);
    Check(!m.engine.saved.count&&Near(m.armedDeadline,190),@"archive failure cannot proceed to capture and retries after sixty seconds");
    [m close];
    m=Enabled();suspended=YES;Advance(m,130);
    Check(!m.engine.saved.count&&m.armedDeadline==DBL_MAX,@"native suspended account boundary disarms capture");
    suspended=NO;m.now=140;[m resourceChanged:[NSNotification notificationWithName:@"CSBackupAccountChanged" object:nil]];Flush(m);Advance(m,140.31);
    Check([m.engine count:@"automatic"]==1,@"stable account completion explicitly resumes due capture");
    [m close];
}
int main(void){@autoreleasepool{BatchTests();DisabledAndBackgroundTests();DebounceTests();WriterTests();GenerationTests();RecoveryAndPolicyTests();printf("Backup manager scheduling: %lu checks passed\n",(unsigned long)checks);}return 0;}
