#import <Foundation/Foundation.h>
#import "CSUserInfoHelper.h"
#import "CSBackupRestoreDiagnostics.h"
static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
typedef void (^CSBackupCompletion)(id,NSError *);
static BOOL ready;
static BOOL CSBackupIsReady(void){return ready;}
static NSError *CSBackupFailure(NSString *message){return [NSError errorWithDomain:@"test.backup" code:1 userInfo:@{NSLocalizedDescriptionKey:message}];}
static BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch,void (^block)(void)){block();return YES;}
static void CSBackupRetryStartup(void (^completion)(NSError *)){completion(CSBackupFailure(@"test pending recovery"));}
static NSString *const RestoreErrorKey=@"com.wechat.enhance.backup.last_restore_error";
static NSString *const UpgradeErrorKey=@"com.wechat.enhance.backup.upgrade_error";
@interface TestStore : NSObject
@property(nonatomic) NSDictionary *record;
@property(nonatomic) BOOL activated;
@property(nonatomic) NSURL *root;
@property(nonatomic) NSMutableArray *events;
- (void)recordRestoreStage:(NSString *)stage status:(NSString *)status error:(NSError *)error details:(NSDictionary *)details;
- (NSDictionary *)journal:(NSError **)error;
- (BOOL)activationConfirmed:(NSDictionary *)journal;
- (BOOL)archiveJournal:(NSError **)error;
@end
@implementation TestStore
- (void)recordRestoreStage:(NSString *)stage status:(NSString *)status error:(NSError *)error details:(NSDictionary *)details{if(!self.events)self.events=[NSMutableArray array];[self.events addObject:@{@"stage":stage,@"status":status,@"code":@(error.code)}];}
- (NSDictionary *)journal:(NSError **)error{return self.record;}
- (BOOL)activationConfirmed:(NSDictionary *)journal{return self.activated;}
- (BOOL)archiveJournal:(NSError **)error{self.record=nil;return YES;}
@end
@interface TestEngine : NSObject
@property(nonatomic) TestStore *store;
@property(nonatomic) NSDictionary *appliedContext;
@property(nonatomic) NSError *recoveryNotice;
@property(nonatomic) NSUInteger saves;
@property(nonatomic) NSUInteger applies;
@property(nonatomic) BOOL failBackup;
@property(nonatomic) BOOL failApply;
@property(nonatomic) NSError *applyFailure;
- (NSDictionary *)save:(NSString *)name kind:(NSString *)kind error:(NSError **)error;
- (BOOL)applyPending:(NSError **)error;
- (BOOL)finishStartup:(NSError **)error;
- (BOOL)confirmStartup:(NSError **)error;
- (BOOL)rollbackBeforeActivation:(NSError **)error;
@end
@implementation TestEngine
- (NSDictionary *)save:(NSString *)name kind:(NSString *)kind error:(NSError **)error{self.saves++;if(self.failBackup){if(error)*error=CSBackupFailure(@"底栏样式：图片 missing.png 无法完整读取");return nil;}return @{@"kind":kind};}
- (BOOL)applyPending:(NSError **)error{self.applies++;if(self.failApply){if(error)*error=self.applyFailure;return NO;}if([self.store.record[@"state"] isEqual:@"rolledBack"])self.store.record=nil;return YES;}
- (BOOL)finishStartup:(NSError **)error{return YES;}
- (BOOL)confirmStartup:(NSError **)error{return YES;}
- (BOOL)rollbackBeforeActivation:(NSError **)error{return YES;}
@end
@interface TestManager : NSObject
@property(nonatomic) TestEngine *engine;
@property(nonatomic) NSUserDefaults *testDefaults;
@property(nonatomic) dispatch_queue_t queue;
@property(nonatomic) NSString *status;
@property(nonatomic,readonly) NSString *lastRestoreFailure;
- (NSError *)restoreError:(NSError *)error stage:(NSString *)stage;
- (void)clearRestoreFailure;
- (NSDictionary *)currentContext;
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion;
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion synchronousHandoff:(BOOL)handoff;
- (BOOL)attemptUpgradeBackup:(NSError **)error;
- (void)resumeScheduledWork;
- (void)retryPendingWork:(CSBackupCompletion)completion;
- (void)resolveStartup:(CSBackupCompletion)completion;
@end
@implementation TestManager
- (NSDictionary *)currentContext{return @{@"epoch":@1,@"account":@"test"};}
- (void)resumeScheduledWork {dispatch_async(self.queue,^{[self attemptUpgradeBackup:NULL];});} // Scheduling is exercised separately.
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion{[self perform:work completion:completion synchronousHandoff:NO];}
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion synchronousHandoff:(BOOL)handoff{NSError *error=nil;id value=work(&error);completion(value,error);}
#import "ManagerUnderTest.h"
@end
int main(void){@autoreleasepool{
    NSString *suite=[@"framework.startup.test." stringByAppendingString:NSUUID.UUID.UUIDString];
    TestManager *manager=[TestManager new];manager.testDefaults=[[NSUserDefaults alloc]initWithSuiteName:suite];manager.queue=dispatch_queue_create("test.optional-backup",DISPATCH_QUEUE_SERIAL);manager.engine=[TestEngine new];manager.engine.store=[TestStore new];manager.engine.store.root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"test-only-store"]];manager.engine.failBackup=YES;
    NSString *versionKey=@"com.wechat.enhance.backup.protectedVersion";[manager.testDefaults setObject:@"previous" forKey:versionKey];
    [manager.testDefaults setObject:@"keep my setting" forKey:@"existing.plugin.setting"];
    ready=NO;__block BOOL released=NO;
    [manager resolveStartup:^(id result,NSError *error){released=result!=nil&&error==nil;ready=released;}];
    Check(released&&ready,@"successful recovery releases plugin even when version backup fails");
    [manager resumeScheduledWork]; // CSBackupWhenReady invokes this after the gate releases.
    dispatch_sync(manager.queue,^{});
    Check(manager.engine.applies==1&&manager.engine.saves==1,@"optional backup runs after recovery handoff");
    Check([[manager.testDefaults stringForKey:versionKey] isEqual:@"previous"],@"failed version backup is not marked complete");
    Check([manager.testDefaults stringForKey:UpgradeErrorKey].length>0,@"failure is retained for backup settings");
    Check([[manager.testDefaults stringForKey:@"existing.plugin.setting"] isEqual:@"keep my setting"],@"backup failure does not reset live preferences");
    __block NSError *retryError=nil;[manager retryPendingWork:^(id result,NSError *error){retryError=error;}];
    Check(retryError!=nil&&ready&&manager.engine.applies==1,@"failed backup retry leaves feature initialization and recovery untouched");
    manager.engine.failBackup=NO;[manager retryPendingWork:^(id result,NSError *error){Check(result!=nil&&error==nil,@"repair permits optional backup retry");}];
    Check([[manager.testDefaults stringForKey:versionKey] isEqual:kPluginVersionString]&&![manager.testDefaults objectForKey:UpgradeErrorKey],@"successful retry clears the failure and records current version");
    NSUInteger saved=manager.engine.saves;[manager retryPendingWork:^(id result,NSError *error){Check(error==nil,@"completed version backup retry succeeds");}];
    Check(manager.engine.saves==saved,@"one version is not backed up repeatedly");
    manager.engine.store.record=@{@"state":@"prepared"};[manager retryPendingWork:^(id result,NSError *error){Check(!result&&error!=nil,@"prepared restore requires restart once features are active");}];
    Check(manager.engine.applies==1,@"retry cannot apply settings to live hooks");
    [manager.testDefaults removeObjectForKey:versionKey];[manager attemptUpgradeBackup:NULL];
    Check(manager.engine.saves==saved,@"optional version backup never competes with pending restoration");
    manager.engine.store.record=@{@"state":@"committed"};manager.engine.store.activated=YES;
    Check([manager attemptUpgradeBackup:NULL]&&manager.engine.saves==saved+1&&!manager.engine.store.record,@"settled recovery can archive before optional backup");
    [manager resolveStartup:^(id result,NSError *error){Check(!result&&error.code==CSBackupRestoreRestart&&[error.localizedDescription containsString:@"重新打开微信"],@"active gate returns explicit restart reason");}];
    ready=NO;manager.engine.failApply=YES;manager.engine.applyFailure=CSBackupFileError(@"/test/transaction.plist",@"rename",EACCES);
    [manager resolveStartup:^(id result,NSError *error){Check(!result&&error.code==CSBackupRestorePermission,@"startup permission failure reaches completion");}];
    Check([manager.lastRestoreFailure containsString:@"权限"],@"startup failure remains visible after transient callback");
    TestManager *reopened=[TestManager new];reopened.testDefaults=manager.testDefaults;
    Check([reopened.lastRestoreFailure isEqual:manager.lastRestoreFailure],@"failure survives controller/manager recreation");
    manager.engine.applyFailure=nil;
    [manager resolveStartup:^(id result,NSError *error){Check(!result&&error!=nil,@"false result without NSError becomes visible failure");}];
    Check([[manager.engine.store.events.lastObject objectForKey:@"status"] isEqual:@"failed"],@"startup gate failure is passively audited");
    manager.engine.failApply=NO;manager.engine.store.record=nil;manager.engine.recoveryNotice=CSBackupFailure(@"恢复计划已自动撤销，当前配置和原备份已保留");
    [manager resolveStartup:^(id result,NSError *error){Check(result!=nil&&error==nil,@"retired prepared plan releases feature gate");}];
    Check([manager.lastRestoreFailure containsString:@"自动撤销"],@"successful self-healing retains a visible failure reason");
    manager.engine.recoveryNotice=nil;manager.engine.store.record=@{@"state":@"rolledBack"};
    [manager resolveStartup:^(id result,NSError *error){Check(result!=nil&&error==nil,@"already rolled-back startup can release feature gate");}];
    Check([manager.lastRestoreFailure containsString:@"已回滚"],@"archiving old rolled-back transaction does not hide its outcome");
    [manager clearRestoreFailure];Check(!manager.lastRestoreFailure.length,@"explicit success cleanup clears persisted failure");
    [manager.testDefaults removePersistentDomainForName:suite];printf("Backup startup integration: %lu checks passed\n",(unsigned long)checks);
}return 0;}
