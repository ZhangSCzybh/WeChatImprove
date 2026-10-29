#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
#import "CSScheduledTaskStore.h"
#import "CSAIReplyStore.h"
#import "CSBackupManager.h"
#import "CSBackupRestoreDiagnostics.h"
#import "CSBackupMutation.h"
#import <unistd.h>
#import <stdatomic.h>
#import <sys/stat.h>
static atomic_uint checks;
#define CHECK(condition) do { checks++; if (!(condition)) { NSLog(@"FAIL line %d: %s", __LINE__, #condition); exit(1); } } while (0)
static atomic_bool blockNextFile,boundaryEntered;
static dispatch_semaphore_t entered,resumeIO;
int CSScheduledBackupFsync(int descriptor){
    CHECK(!NSThread.isMainThread);struct stat info;CHECK(fstat(descriptor,&info)==0);
    if(S_ISREG(info.st_mode) && atomic_exchange(&blockNextFile,false)){
        dispatch_semaphore_signal(entered);CHECK(dispatch_semaphore_wait(resumeIO,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0);
    }
    return fsync(descriptor);
}
@interface ScheduledBackupBoundary : NSObject
@property(nonatomic) CSBackupEngine *engine;
@property(nonatomic) NSString *status;
- (void)performRestore:(NSString *)stage work:(id(^)(NSError **))work completion:(CSBackupCompletion)completion;
- (BOOL)validateColors:(NSDictionary *)snapshot error:(NSError **)error;
- (void)preview:(NSDictionary *)snapshot modules:(NSSet *)modules accounts:(NSSet *)accounts completion:(CSBackupCompletion)completion;
- (void)prepare:(NSDictionary *)preview completion:(CSBackupCompletion)completion;
@end
@implementation ScheduledBackupBoundary
- (void)performRestore:(NSString *)stage work:(id(^)(NSError **))work completion:(CSBackupCompletion)completion {
    (void)stage;dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY,0),^{CHECK(!NSThread.isMainThread);atomic_store(&boundaryEntered,true);NSError *error=nil;id result=work(&error);dispatch_async(dispatch_get_main_queue(),^{completion(result,error);});});
}
- (BOOL)validateColors:(NSDictionary *)snapshot error:(NSError **)error {(void)snapshot;(void)error;return YES;}
#import "ScheduledBackupManagerBoundary.h"
@end
static void Wait(BOOL(^done)(void)){NSDate *limit=[NSDate dateWithTimeIntervalSinceNow:5];while(!done() && limit.timeIntervalSinceNow>0)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.002]];CHECK(done());}
static NSURL *TaskURL(NSURL *resources, NSString *account) {
    NSData *data=[account dataUsingEncoding:NSUTF8StringEncoding]; unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes,(CC_LONG)data.length,bytes); NSMutableString *name=[NSMutableString string];
    for (NSUInteger i=0;i<sizeof(bytes);i++) [name appendFormat:@"%02x",bytes[i]];
    return [resources URLByAppendingPathComponent:[NSString stringWithFormat:@"ScheduledTasks/%@.plist",name]];
}
static NSDictionary *Task(NSString *identifier, NSString *mode, NSString *target) {
    return @{@"id":identifier,@"title":[@"Task " stringByAppendingString:identifier],@"target":target,@"text":@"备份测试文字",
        @"enabled":@YES,@"catchUp":@YES,@"mode":mode,@"anchor":[NSDate dateWithTimeIntervalSince1970:1800000000],
        @"zone":@"Asia/Shanghai",@"interval":@5,@"hour":@9,@"minute":@30,@"weekdays":@[@2,@4]};
}
static NSDictionary *Field(NSDictionary *snapshot, NSString *account) {
    for (NSDictionary *f in snapshot[@"fields"]) if ([f[@"domain"] isEqual:@"scheduled"] && [f[@"key"] isEqual:account]) return f;
    return nil;
}
static CSBackupEngine *Engine(NSURL *root, NSString *suite) {
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    CSBackupEngine *engine=[[CSBackupEngine alloc] initWithDefaults:@{@"standard":defaults} domains:@{@"standard":suite}
        store:[[CSBackupStore alloc] initWithRoot:[root URLByAppendingPathComponent:@"BackupV2"]] resources:root];
    engine.context=^{return @{@"account":@"alice",@"epoch":@1,@"installationID":@"test-install",@"pluginVersion":@"2.0-13"};}; return engine;
}
static void Complete(CSBackupEngine *engine) {
    NSError *error=nil;
    BOOL ok=[engine applyPending:&error]; if (!ok) NSLog(@"apply: %@",error); CHECK(ok);
    CHECK([engine finishStartup:&error]); CHECK([engine confirmStartup:&error]); CHECK([engine cancelPending:&error]);
}
static int Crash(NSString *binary, NSURL *root, NSString *suite, NSString *stage) {
    NSTask *process=[NSTask new];process.executableURL=[NSURL fileURLWithPath:binary];process.arguments=@[@"--crash",root.path,suite,stage];
    CHECK([process launchAndReturnError:NULL]);[process waitUntilExit];return process.terminationStatus;
}
static void PendingWriteRestoreBoundary(NSURL *root){
    NSString *suite=[@"scheduled.pending.restore." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];CSBackupEngine *engine=Engine(root,suite);
    NSURL *url=TaskURL(root,@"alice");CSScheduledTaskStore *live=[[CSScheduledTaskStore alloc]initWithURL:url account:@"alice"];
    NSDate *before=[NSDate dateWithTimeIntervalSince1970:1799999900],*due=[NSDate dateWithTimeIntervalSince1970:1800000000];
    CHECK([live load]);CHECK([live saveTask:Task(@"pending",@"minutes",@"filehelper") now:before]);CHECK([live setEnabled:YES now:before]);
    NSDictionary *snapshot=[engine capture:@"before async edit" kind:@"manual" error:NULL];CHECK(snapshot!=nil);
    ScheduledBackupBoundary *boundary=[ScheduledBackupBoundary new];boundary.engine=engine;
    entered=dispatch_semaphore_create(0);resumeIO=dispatch_semaphore_create(0);
    NSMutableDictionary *edited=[Task(@"pending",@"minutes",@"filehelper") mutableCopy];edited[@"text"]=@"pending durable edit";
    __block BOOL editedDone=NO,previewDone=NO;__block NSDictionary *preview=nil;
    atomic_store(&blockNextFile,true);[live saveTask:edited now:before completion:^(BOOL ok,NSError *error){CHECK(ok && !error);editedDone=YES;}];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);CHECK(CSBackupResourceWriteInProgress());
    atomic_store(&boundaryEntered,false);[boundary preview:snapshot modules:[NSSet setWithObject:@"scheduled_tasks"] accounts:[NSSet setWithObject:@"alice"] completion:^(id result,NSError *error){CHECK(result && !error);preview=result;previewDone=YES;}];
    Wait(^BOOL{return atomic_load(&boundaryEntered);});CHECK(!previewDone);dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return editedDone && previewDone;});
    CHECK([live.tasks[0][@"text"] isEqual:edited[@"text"]]);
    NSDictionary *currentPreview=[engine preview:snapshot modules:[NSSet setWithObject:@"scheduled_tasks"] accounts:[NSSet setWithObject:@"alice"] error:NULL];CHECK([preview[@"revision"] isEqual:currentPreview[@"revision"]]);
    // A durable execution admitted after preview must invalidate prepare, even
    // when the facade starts while its fsync is still pending.
    __block NSDictionary *claim=nil;__block BOOL claimed=NO,prepared=NO;
    atomic_store(&blockNextFile,true);[live claimTask:@"pending" now:due completion:^(NSDictionary *value,NSError *error){CHECK(value && !error);claim=value;claimed=YES;}];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);
    atomic_store(&boundaryEntered,false);[boundary prepare:preview completion:^(id result,NSError *error){CHECK(!result && error);CHECK([error.localizedDescription containsString:@"配置或账号已变化"]);prepared=YES;}];
    Wait(^BOOL{return atomic_load(&boundaryEntered);});CHECK(!prepared);dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return claimed && prepared;});CHECK([engine.store journal:NULL]==nil);
    // An already accepted finish drains to its original file after invalidation;
    // its stale callback reports cancellation and cannot revive the scheduler.
    __block BOOL finished=NO;atomic_store(&blockNextFile,true);[live finishClaim:claim[@"id"] result:@"submitted" detail:@"isolated test" completion:^(BOOL ok,NSError *error){CHECK(!ok && error);finished=YES;}];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);[live invalidate];CHECK(!live.ready);dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return finished;});
    CHECK([[CSScheduledTaskStore readStateAtURL:url account:@"alice" error:NULL][@"history"][0][@"result"] isEqual:@"submitted"]);
    previewDone=NO;[boundary preview:snapshot modules:[NSSet setWithObject:@"scheduled_tasks"] accounts:[NSSet setWithObject:@"alice"] completion:^(id result,NSError *error){CHECK(result && !error);preview=result;previewDone=YES;}];Wait(^BOOL{return previewDone;});
    prepared=NO;[boundary prepare:preview completion:^(id result,NSError *error){CHECK(result && !error);prepared=YES;}];Wait(^BOOL{return prepared;});Complete(engine);
    NSDictionary *restored=[CSScheduledTaskStore readStateAtURL:url account:@"alice" error:NULL];CHECK(![restored[@"enabled"] boolValue] && ![restored[@"history"] count]);CHECK([restored[@"tasks"][0][@"text"] isEqual:Task(@"pending",@"minutes",@"filehelper")[@"text"]]);
    [defaults removePersistentDomainForName:suite];
}
int main(int argc, const char *argv[]) { @autoreleasepool {
    if (argc==5 && [@(argv[1]) isEqual:@"--crash"]) {
        CSBackupEngine *engine=Engine([NSURL fileURLWithPath:@(argv[2]) isDirectory:YES],@(argv[3]));
        engine.checkpoint=^(NSString *point){ if ([point isEqual:@(argv[4])]) _exit(77); };
        return [engine applyPending:NULL]?0:2;
    }
    CHECK(argc==2); NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    PendingWriteRestoreBoundary([root URLByAppendingPathComponent:@"pending-boundary"]);
    NSString *suite=[@"scheduled.backup." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    CSBackupEngine *engine=Engine(root,suite);
    NSMutableArray *audits=[NSMutableArray array];engine.store.eventHandler=^(NSString *event,NSDictionary *details){if([event isEqual:@"restore-write-scheduled-tasks"])[audits addObject:details];};
    __block NSString *account=@"alice"; __block NSUInteger epoch=1;
    engine.context=^{return @{@"account":account,@"epoch":@(epoch),@"installationID":@"test-install",@"pluginVersion":@"2.0-13"};};
    NSURL *aliceURL=TaskURL(root,@"alice"); NSError *error=nil;
    CSScheduledTaskStore *live=[[CSScheduledTaskStore alloc] initWithURL:aliceURL account:@"alice"];
    NSDate *before=[NSDate dateWithTimeIntervalSince1970:1799999900],*due=[NSDate dateWithTimeIntervalSince1970:1800000000];
    CHECK([live load]);
    NSArray *modes=@[@"once",@"minutes",@"hours",@"daily",@"weekly"],*targets=@[@"filehelper",@"wxid_friend",@"team@chatroom",@"wxid_friend",@"filehelper"];
    for (NSUInteger i=0;i<modes.count;i++) CHECK([live saveTask:Task(modes[i],modes[i],targets[i]) now:before]);
    CHECK([live setEnabled:YES now:before]);
    NSDictionary *claim=[live claimTask:@"minutes" now:due]; CHECK(claim!=nil); CHECK([live finishClaim:claim[@"id"] result:@"submitted" detail:@"test only, no native sends"]);
    NSDictionary *snapshot=[engine capture:@"scheduled" kind:@"manual" error:&error]; if (!snapshot) NSLog(@"capture: %@",error); CHECK(snapshot!=nil);
    // Reproduces the missing backup module even while the scheduler owns the file lock.
    CHECK([Field(snapshot,@"alice")[@"present"] boolValue]);
    NSDictionary *value=Field(snapshot,@"alice")[@"value"];
    CHECK([CSBackupRegistry.moduleTitles[@"scheduled_tasks"] isEqual:@"定时任务"]);
    CHECK([value[@"enabled"] boolValue] && [value[@"tasks"] count]==5 && !value[@"history"]);
    for (NSDictionary *task in value[@"tasks"]) CHECK(!task[@"nextRun"] && !task[@"lastOccurrence"]);
    CHECK([TaskURL(root,@"alice") isEqual:CSScheduledTaskFileURL(root,@"alice")]);
    CHECK([CSBackupCodec decode:[CSBackupCodec encode:snapshot error:&error] error:&error]!=nil);
    CHECK([engine.store publish:snapshot error:&error]);
    snapshot=[engine.store snapshot:snapshot[@"id"] error:&error]; CHECK([Field(snapshot,@"alice")[@"value"] isEqual:value]);
    NSDictionary *original=[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:&error]; CHECK([original[@"history"] count]==1);
    error=nil; CHECK(![CSScheduledTaskStore replaceState:original atURL:aliceURL account:@"alice" error:&error] && error!=nil);
    CHECK([CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL]!=nil && live.enabled);

    // Editing a task marks auto backup dirty; execution bookkeeping does not.
    __block NSUInteger notifications=0;
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSScheduledTaskConfigurationDidChange object:nil queue:nil usingBlock:^(__unused NSNotification *note){notifications++;}];
    NSDictionary *automatic=[engine save:@"auto" kind:@"automatic" error:&error]; CHECK(automatic!=nil);
    claim=[live claimTask:@"minutes" now:[due dateByAddingTimeInterval:300]]; CHECK(claim!=nil);
    CHECK([live finishClaim:claim[@"id"] result:@"submitted" detail:@"test only"]); CHECK(notifications==0);
    NSDictionary *same=[engine save:@"auto" kind:@"automatic" error:&error]; CHECK([same[@"id"] isEqual:automatic[@"id"]]);
    NSMutableDictionary *changed=[Task(@"minutes",@"minutes",@"filehelper") mutableCopy];changed[@"text"]=@"修改后的内容";
    CHECK([live saveTask:changed now:before]); CHECK(notifications==1);
    NSDictionary *newAuto=[engine save:@"auto" kind:@"automatic" error:&error]; CHECK(![newAuto[@"id"] isEqual:automatic[@"id"]]);
    [NSNotificationCenter.defaultCenter removeObserver:observer];

    NSSet *module=[NSSet setWithObject:@"scheduled_tasks"],*alice=[NSSet setWithObject:@"alice"];
    NSDictionary *preview=[engine preview:snapshot modules:module accounts:alice error:&error]; CHECK(preview!=nil && [preview[@"changes"] count]==1);
    CHECK([[preview[@"warnings"] componentsJoinedByString:@" "] containsString:@"总开关关闭"]);
    CHECK([engine prepare:preview error:&error]);
    NSDictionary *beforeImage=[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL];
    CHECK([[engine.store journal:NULL][@"before"][0][@"value"] isEqual:beforeImage]);
    live=nil; Complete(engine);
    NSDictionary *restored=[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:&error];
    CHECK(![restored[@"enabled"] boolValue] && [restored[@"tasks"] isEqual:value[@"tasks"]] && [restored[@"history"] count]==0);
    live=[[CSScheduledTaskStore alloc] initWithURL:aliceURL account:@"alice"];CHECK([live load]);
    CHECK(![live claimTask:@"minutes" now:[due dateByAddingTimeInterval:3600]]);
    NSDate *reenable=[due dateByAddingTimeInterval:3600];CHECK([live setEnabled:YES now:reenable]);
    for (NSDictionary *task in live.tasks) if ([task[@"enabled"] boolValue]) CHECK([task[@"nextRun"] compare:reenable]==NSOrderedDescending);
    CHECK(![live claimTask:@"minutes" now:reenable]);live=nil;

    // A backup made on another installation may restore only into its original account.
    NSMutableDictionary *imported=[snapshot mutableCopy];NSMutableDictionary *source=[snapshot[@"source"] mutableCopy];source[@"installationID"]=@"another-device";imported[@"source"]=source;
    CHECK([engine preview:imported modules:module accounts:alice error:NULL]!=nil);
    account=@"bob";epoch++;CHECK([engine preview:snapshot modules:module accounts:alice error:NULL]==nil);
    CSScheduledTaskStore *bob=[[CSScheduledTaskStore alloc] initWithURL:TaskURL(root,@"bob") account:@"bob"];CHECK([bob load]);CHECK([bob saveTask:Task(@"bob",@"daily",@"filehelper") now:before]);
    NSDictionary *bobBefore=[CSScheduledTaskStore readStateAtURL:TaskURL(root,@"bob") account:@"bob" error:NULL];bob=nil;
    account=@"alice";epoch++;CHECK([engine preview:snapshot modules:module accounts:[NSSet set] error:NULL]==nil);

    // A pre-feature backup, or deselected module, leaves the entire task file untouched.
    NSMutableDictionary *old=[snapshot mutableCopy];NSMutableArray *oldFields=[NSMutableArray array];
    for (NSDictionary *f in snapshot[@"fields"]) if (![f[@"domain"] isEqual:@"scheduled"]) [oldFields addObject:f];old[@"fields"]=oldFields;[old removeObjectForKey:@"scheduledTaskRevision"];
    beforeImage=[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL];
    for (NSDictionary *candidate in @[old,snapshot]) {
        preview=[engine preview:candidate modules:[NSSet setWithObject:@"games"] accounts:alice error:&error];CHECK(preview!=nil);CHECK([engine prepare:preview error:&error]);Complete(engine);
        CHECK([[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL] isEqual:beforeImage]);
    }
    preview=[engine preview:old modules:[NSSet setWithObject:@"games"] accounts:alice error:&error];CHECK([engine prepare:preview error:&error]);
    live=[[CSScheduledTaskStore alloc] initWithURL:aliceURL account:@"alice"];CHECK([live load]);CHECK([live claimTask:@"minutes" now:[reenable dateByAddingTimeInterval:300]]!=nil);live=nil;
    beforeImage=[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL];Complete(engine);
    CHECK([[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL] isEqual:beforeImage]);

    // Interrupted task writes recover the exact before-image, including claims and history.
    CHECK([CSScheduledTaskStore replaceState:original atURL:aliceURL account:@"alice" error:&error]);
    preview=[engine preview:snapshot modules:module accounts:alice error:&error];CHECK([engine prepare:preview error:&error]);
    CHECK(Crash(@(argv[0]),root,suite,@"scheduled-tasks")==77);
    CHECK(![[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL] isEqual:original]);
    account=@"bob";epoch++;Complete(engine); // The original account remains the rollback target.
    CHECK([[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL] isEqual:original]);
    CHECK([[CSScheduledTaskStore readStateAtURL:TaskURL(root,@"bob") account:@"bob" error:NULL] isEqual:bobBefore]);
    account=@"alice";epoch++;
    // A new execution claim after prepare invalidates the plan; it cannot rewind dedup state.
    preview=[engine preview:snapshot modules:module accounts:alice error:&error];CHECK([engine prepare:preview error:&error]);
    live=[[CSScheduledTaskStore alloc] initWithURL:aliceURL account:@"alice"];CHECK([live load]);
    CHECK([live claimTask:@"minutes" now:[due dateByAddingTimeInterval:300]]!=nil);live=nil;
    beforeImage=[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL];
    CHECK(![engine applyPending:NULL]);CHECK([[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL] isEqual:beforeImage]);CHECK([engine cancelPending:NULL]);

    // Reset only the selected account, and restore to a missing file through the same transaction.
    NSDictionary *reset=[engine resetSnapshot:&error];preview=[engine preview:reset modules:module accounts:alice error:&error];CHECK(preview!=nil);CHECK([engine prepare:preview error:&error]);Complete(engine);
    CHECK(![NSFileManager.defaultManager fileExistsAtPath:aliceURL.path]);
    CHECK([[CSScheduledTaskStore readStateAtURL:TaskURL(root,@"bob") account:@"bob" error:NULL] isEqual:bobBefore]);
    preview=[engine preview:snapshot modules:module accounts:alice error:&error];CHECK([engine prepare:preview error:&error]);
    CHECK(Crash(@(argv[0]),root,suite,@"scheduled-tasks")==77);Complete(engine);CHECK(![NSFileManager.defaultManager fileExistsAtPath:aliceURL.path]);
    preview=[engine preview:snapshot modules:module accounts:alice error:&error];CHECK([engine prepare:preview error:&error]);Complete(engine);
    CHECK([[CSScheduledTaskStore readStateAtURL:aliceURL account:@"alice" error:NULL][@"tasks"] isEqual:value[@"tasks"]]);
    CHECK(audits.count>0);BOOL wrote=NO;
    for (NSDictionary *record in audits) {CHECK([record[@"path"] isEqual:aliceURL.path]);CHECK(!record[@"text"] && !record[@"tasks"]);if([record[@"status"] isEqual:@"ok"])wrote=YES;}CHECK(wrote);

    // Malformed imports fail before creating a journal or overwriting a valid task file.
    NSDictionary *entry=[CSBackupRegistry entryForDomain:@"scheduled" key:@"alice"];
    CHECK([CSBackupRegistry entryForDomain:@"scheduled" key:@"../alice"]==nil);
    for (NSDictionary *bad in @[@{@"account":@"bob"},@{@"enabled":@2},@{@"tasks":@[value[@"tasks"][0],value[@"tasks"][0]]}]) {
        NSMutableDictionary *invalid=[value mutableCopy];[invalid addEntriesFromDictionary:bad];CHECK(![CSBackupRegistry validateValue:invalid entry:entry error:NULL]);
    }
    NSMutableDictionary *badTask=[value[@"tasks"][1] mutableCopy];badTask[@"interval"]=@0;NSMutableDictionary *invalid=[value mutableCopy];invalid[@"tasks"]=@[badTask];CHECK(![CSBackupRegistry validateValue:invalid entry:entry error:NULL]);
    NSURL *badURL=TaskURL(root,@"broken");NSData *badData=[NSPropertyListSerialization dataWithPropertyList:@[@"not a dictionary"] format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];CHECK([badData writeToURL:badURL atomically:YES]);
    error=nil;CHECK(![CSScheduledTaskStore readStateAtURL:badURL account:@"broken" error:&error] && error!=nil);CHECK([[NSData dataWithContentsOfURL:badURL] isEqual:badData]);
    CHECK([engine.store journal:NULL]==nil);
    [defaults removePersistentDomainForName:suite];
    printf("Scheduled task backup: %lu checks passed\n",(unsigned long)checks);
} return 0; }
