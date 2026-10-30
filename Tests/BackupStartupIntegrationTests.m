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
static NSUInteger startupRetries,recoveryResumes;
static NSError *startupRetryFailure;
static void CSBackupRetryStartup(void (^completion)(NSError *)){startupRetries++;completion(startupRetryFailure);}
static void CSBackupResumeAfterRecovery(void){recoveryResumes++;}
static NSString *const RestoreErrorKey=@"com.wechat.enhance.backup.last_restore_error";
@interface TestStore : NSObject
@property(nonatomic) NSDictionary *record;
@property(nonatomic) BOOL activated;
@property(nonatomic) NSError *readFailure;
@property(nonatomic) NSError *archiveFailure;
@property(nonatomic) NSURL *root;
@property(nonatomic) NSMutableArray *events;
- (void)recordRestoreStage:(NSString *)stage status:(NSString *)status error:(NSError *)error details:(NSDictionary *)details;
- (NSDictionary *)journal:(NSError **)error;
- (BOOL)activationConfirmed:(NSDictionary *)journal;
- (BOOL)archiveJournal:(NSError **)error;
@end
@implementation TestStore
- (void)recordRestoreStage:(NSString *)stage status:(NSString *)status error:(NSError *)error details:(NSDictionary *)details{if(!self.events)self.events=[NSMutableArray array];[self.events addObject:@{@"stage":stage,@"status":status,@"code":@(error.code)}];}
- (NSDictionary *)journal:(NSError **)error{if(error)*error=self.readFailure;return self.readFailure?nil:self.record;}
- (BOOL)activationConfirmed:(NSDictionary *)journal{return self.activated;}
- (BOOL)archiveJournal:(NSError **)error{if(self.archiveFailure){if(error)*error=self.archiveFailure;return NO;}self.record=nil;return YES;}
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
@property(nonatomic) NSError *cancelFailure;
- (NSDictionary *)save:(NSString *)name error:(NSError **)error;
- (BOOL)applyPending:(NSError **)error;
- (BOOL)finishStartup:(NSError **)error;
- (BOOL)confirmStartup:(NSError **)error;
- (BOOL)rollbackBeforeActivation:(NSError **)error;
- (BOOL)cancelPending:(NSError **)error;
@end
@implementation TestEngine
- (NSDictionary *)save:(NSString *)name error:(NSError **)error{self.saves++;if(self.failBackup){if(error)*error=CSBackupFailure(@"底栏样式：图片 missing.png 无法完整读取");return nil;}return @{@"name":name};}
- (BOOL)applyPending:(NSError **)error{self.applies++;if(self.failApply){if(error)*error=self.applyFailure;return NO;}if([self.store.record[@"state"] isEqual:@"rolledBack"])self.store.record=nil;return YES;}
- (BOOL)finishStartup:(NSError **)error{return YES;}
- (BOOL)confirmStartup:(NSError **)error{return YES;}
- (BOOL)rollbackBeforeActivation:(NSError **)error{return YES;}
- (BOOL)cancelPending:(NSError **)error{if(self.cancelFailure){if(error)*error=self.cancelFailure;return NO;}return [self.store archiveJournal:error];}
@end
@interface TestManager : NSObject
@property(nonatomic) TestEngine *engine;
@property(nonatomic) NSUserDefaults *testDefaults;
@property(nonatomic) NSString *status;
@property(nonatomic,readonly) NSString *lastRestoreFailure;
- (NSError *)restoreError:(NSError *)error stage:(NSString *)stage;
- (void)clearRestoreFailure;
- (NSDictionary *)currentContext;
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion;
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion synchronousHandoff:(BOOL)handoff;
- (void)performRestore:(NSString *)stage work:(id (^)(NSError **))work completion:(CSBackupCompletion)completion;
- (void)create:(NSString *)name completion:(CSBackupCompletion)completion;
- (void)cancelPending:(CSBackupCompletion)completion;
- (void)retryPendingWork:(CSBackupCompletion)completion;
- (void)resolveStartup:(CSBackupCompletion)completion;
@end
@implementation TestManager
- (NSDictionary *)currentContext{return @{@"epoch":@1,@"account":@"test"};}
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion{[self perform:work completion:completion synchronousHandoff:NO];}
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion synchronousHandoff:(BOOL)handoff{NSError *error=nil;id value=work(&error);completion(value,error);}
#import "ManagerUnderTest.h"
@end
int main(void){@autoreleasepool{
    NSString *suite=[@"framework.startup.test." stringByAppendingString:NSUUID.UUID.UUIDString];
    TestManager *manager=[TestManager new];manager.testDefaults=[[NSUserDefaults alloc]initWithSuiteName:suite];manager.engine=[TestEngine new];manager.engine.store=[TestStore new];manager.engine.store.root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"test-only-store"]];manager.engine.failBackup=YES;
    [manager.testDefaults setObject:@"previous" forKey:@"com.wechat.enhance.backup.protectedVersion"];
    [manager.testDefaults setBool:YES forKey:@"com.wechat.enhance.backup.auto_enabled"];
    [manager.testDefaults setObject:@"keep my setting" forKey:@"existing.plugin.setting"];
    ready=NO;__block BOOL released=NO;
    [manager resolveStartup:^(id result,NSError *error){released=result!=nil&&error==nil;ready=released;}];
    Check(released&&ready&&manager.engine.applies==1,@"successful recovery releases plugin without creating a version backup");
    Check(manager.engine.saves==0,@"startup ignores legacy automatic and version backup preferences");
    Check([[manager.testDefaults stringForKey:@"existing.plugin.setting"] isEqual:@"keep my setting"],@"startup leaves live preferences intact");
    [manager retryPendingWork:^(id result,NSError *error){Check(result!=nil&&error==nil,@"retry without a pending transaction succeeds");}];
    Check(manager.engine.saves==0&&manager.engine.applies==1,@"idle retry neither creates a backup nor applies settings to live hooks");
    manager.engine.store.record=@{@"state":@"prepared"};
    [manager retryPendingWork:^(id result,NSError *error){Check(!result&&error.code==CSBackupRestoreRestart,@"prepared restore requires restart once features are active");}];
    Check(manager.engine.saves==0&&manager.engine.applies==1&&manager.engine.store.record!=nil,@"restart requirement preserves pending transaction without a backup");
    manager.engine.store.record=@{@"state":@"committed"};manager.engine.store.activated=NO;
    [manager retryPendingWork:^(id result,NSError *error){Check(!result&&error.code==CSBackupRestoreRestart,@"unhanded commit cannot be archived by a retry");}];
    manager.engine.store.activated=YES;
    [manager retryPendingWork:^(id result,NSError *error){Check(result!=nil&&error==nil&&!manager.engine.store.record,@"confirmed transaction is archived by retry");}];
    manager.engine.store.record=@{@"state":@"rolledBack"};manager.engine.store.archiveFailure=CSBackupFailure(@"fixture archive failure");
    [manager retryPendingWork:^(id result,NSError *error){Check(!result&&error!=nil&&manager.engine.store.record!=nil,@"archive failure preserves rollback evidence");}];
    manager.engine.store.archiveFailure=nil;
    [manager retryPendingWork:^(id result,NSError *error){Check(result!=nil&&error==nil&&!manager.engine.store.record,@"settled rollback can be archived on retry");}];
    manager.engine.store.readFailure=CSBackupFailure(@"fixture journal read failure");
    [manager retryPendingWork:^(id result,NSError *error){Check(!result&&error!=nil,@"unreadable journal is reported without creating a backup");}];
    manager.engine.store.readFailure=nil;
    Check(manager.engine.saves==0,@"all live recovery retries avoid creating snapshots");
    ready=NO;startupRetryFailure=CSBackupFailure(@"test pending recovery");
    [manager retryPendingWork:^(id result,NSError *error){Check(!result&&error!=nil&&startupRetries==1,@"unready retry delegates startup recovery and reports its error");}];
    Check([manager.lastRestoreFailure containsString:@"test pending recovery"],@"startup retry failure remains visible");
    startupRetryFailure=nil;
    [manager retryPendingWork:^(id result,NSError *error){Check(result!=nil&&error==nil&&startupRetries==2,@"successful startup retry returns its recovery result");}];
    ready=YES;manager.engine.store.record=@{@"state":@"prepared"};
    [manager cancelPending:^(id result,NSError *error){Check(result!=nil&&error==nil&&!manager.engine.store.record,@"cancel removes only the pending recovery plan");}];
    Check(recoveryResumes==1&&manager.engine.saves==0,@"successful cancellation resumes the recovery gate without creating a backup");
    manager.engine.cancelFailure=CSBackupFailure(@"fixture cancel failure");
    [manager cancelPending:^(id result,NSError *error){Check(!result&&error!=nil,@"failed cancellation is visible");}];
    Check(recoveryResumes==1&&manager.lastRestoreFailure.length>0,@"failed cancellation cannot release the recovery gate");
    manager.engine.cancelFailure=nil;
    [manager create:@"my manual copy" completion:^(NSDictionary *result,NSError *error){Check(!result&&error!=nil,@"manual backup failure reaches its caller");}];
    Check(manager.engine.saves==1,@"explicit create is the only backup entry point");
    manager.engine.failBackup=NO;
    [manager create:@"my manual copy" completion:^(NSDictionary *result,NSError *error){Check(result!=nil&&error==nil&&[result[@"name"] isEqual:@"my manual copy"],@"manual create preserves the chosen name");}];
    Check(manager.engine.saves==2,@"each explicit manual request creates exactly one backup");
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
