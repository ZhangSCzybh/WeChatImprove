#import "CSBackupManager.h"
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupAssets.h"
#import "CSBackupRegistry.h"
#import "CSBackupScheduler.h"
#import "CSBackupBootstrap.h"
#import "CSBackupAudit.h"
#import "CSBackupRestoreDiagnostics.h"
#import "CSPluginStorage.h"
#import "CSServiceCenter.h"
#import "CSUserInfoHelper.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
static NSString *const UpgradeErrorKey=@"com.wechat.enhance.backup.upgrade_error";
static NSString *const RestoreErrorKey=@"com.wechat.enhance.backup.last_restore_error";
static NSString *const AutoKey=@"com.wechat.enhance.backup.auto_enabled";
@interface CSBackupManager ()
@property(nonatomic) CSBackupEngine *engine;
@property(nonatomic) CSBackupScheduler *scheduler;
@property(nonatomic) dispatch_queue_t queue;
@property(nonatomic) dispatch_source_t timer;
@property(nonatomic,copy) NSString *standardDomain;
@property(nonatomic,copy) NSString *installationID;
@property(nonatomic,copy) NSString *signature;
@property(atomic,copy,readwrite) NSString *status;
@property(nonatomic) BOOL active;
@end
@implementation CSBackupManager
+ (instancetype)sharedManager {static CSBackupManager *manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (instancetype)init {
    if((self=[super init])){
        _queue=dispatch_queue_create("com.wechat.improve.backup",DISPATCH_QUEUE_SERIAL);_scheduler=[CSBackupScheduler new];_status=@"本机备份尚未检查";
        NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
        CSBackupStore *store=[[CSBackupStore alloc]initWithMigration:CSPluginStorageMigration(@"BackupV2")];
        CSBackupAudit *audit=CSBackupDefaultAudit();
        store.eventHandler=^(NSString *event,NSDictionary *details){[audit storeEvent:event details:details];};
        _standardDomain=NSBundle.mainBundle.bundleIdentifier?:@"com.tencent.xin";
        NSDictionary *domains=@{@"standard":_standardDomain,@"legacy":@"com.cyansmoke.wechattweak",@"layout":@"com.wechat.enhance"};
        NSDictionary *defaults=@{@"standard":NSUserDefaults.standardUserDefaults,@"legacy":[[NSUserDefaults alloc]initWithSuiteName:domains[@"legacy"]],@"layout":[[NSUserDefaults alloc]initWithSuiteName:domains[@"layout"]]};
        _engine=[[CSBackupEngine alloc]initWithDefaults:defaults domains:domains store:store resources:[library URLByAppendingPathComponent:@"Preferences/WeChatImprove" isDirectory:YES]];
        _engine.readPreferencesOnMain=YES;
        NSString *identity=[NSUserDefaults.standardUserDefaults stringForKey:@"com.wechat.enhance.backup.installationID"];
        if(!identity.length){identity=NSUUID.UUID.UUIDString;[NSUserDefaults.standardUserDefaults setObject:identity forKey:@"com.wechat.enhance.backup.installationID"];[NSUserDefaults.standardUserDefaults synchronize];}_installationID=identity;
        __weak typeof(self) weakSelf=self;_engine.context=^{return [weakSelf currentContext];};
        NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
        [center addObserver:self selector:@selector(foreground:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [center addObserver:self selector:@selector(background:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [center addObserver:self selector:@selector(changed:) name:NSUserDefaultsDidChangeNotification object:nil];
        for(NSString *name in @[@"CSBackupAccountChanged",@"CSBackupResourcesChanged",@"CSNavigationTitleSettingsChanged",@"CSTouchTrailImageDidChange",@"com.wechat.enhance.tabbar_style.changed",@"CSContactSeparatorSettingsChanged"])[center addObserver:self selector:@selector(resourceChanged:) name:name object:nil];
        _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,_queue);dispatch_source_set_timer(_timer,dispatch_time(DISPATCH_TIME_NOW,10*NSEC_PER_SEC),10*NSEC_PER_SEC,NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer,^{[weakSelf tick];});dispatch_resume(_timer);
        dispatch_async(_queue,^{[weakSelf attemptUpgradeBackup:NULL];});
    }return self;
}
- (NSString *)lastRestoreFailure {return [NSUserDefaults.standardUserDefaults stringForKey:RestoreErrorKey]?:@"";}
- (NSError *)restoreError:(NSError *)error stage:(NSString *)stage {
    NSError *reported=CSBackupRestoreError(error,stage,CSBackupRestoreState,self.engine.store.root.path);
    self.status=reported.localizedDescription;
    [NSUserDefaults.standardUserDefaults setObject:self.status forKey:RestoreErrorKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    [self.engine.store recordRestoreStage:stage status:@"failed" error:reported details:@{}];return reported;
}
- (void)clearRestoreFailure {
    [NSUserDefaults.standardUserDefaults removeObjectForKey:RestoreErrorKey];[NSUserDefaults.standardUserDefaults synchronize];
}
- (void)performRestore:(NSString *)stage work:(id(^)(NSError **))work completion:(CSBackupCompletion)completion {
    [self perform:^id(NSError **error){
        [self.engine.store recordRestoreStage:stage status:@"started" error:nil details:@{}];return work(error);
    } completion:^(id result,NSError *error){
        if(error||!result){error=[self restoreError:error stage:stage];result=nil;}
        else {
            [self.engine.store recordRestoreStage:stage status:[stage isEqual:@"prepared"]?@"restart-required":@"ok" error:nil details:@{}];
            if([@[@"prepared",@"cancel"] containsObject:stage])[self clearRestoreFailure];
        }
        if(completion)completion(result,error);
    }];
}
- (NSDictionary *)currentContext {
    __block NSString *account=@"";__block NSUInteger epoch=0;
    void (^read)(void)=^{
        epoch=CSBackupAccountEpoch();
        if(CSBackupAccountIsSuspended())return;
        @try {id manager=CSGetService(NSClassFromString(@"CContactMgr"));SEL selfSelector=NSSelectorFromString(@"getSelfContact"),nameSelector=NSSelectorFromString(@"m_nsUsrName");
            id contact=[manager respondsToSelector:selfSelector]?((id(*)(id,SEL))objc_msgSend)(manager,selfSelector):nil;
            id name=[contact respondsToSelector:nameSelector]?((id(*)(id,SEL))objc_msgSend)(contact,nameSelector):nil;if([name isKindOfClass:NSString.class])account=[name copy];
        }@catch(__unused NSException *exception){}
    };
    if(NSThread.isMainThread)read();else dispatch_sync(dispatch_get_main_queue(),read);
    return @{@"account":account,@"epoch":@(epoch),@"installationID":self.installationID,@"pluginVersion":kPluginVersionString,@"hostVersion":[NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"]?:@"",@"systemVersion":UIDevice.currentDevice.systemVersion};
}
- (void)perform:(id(^)(NSError **))work completion:(CSBackupCompletion)completion {
    [self perform:work completion:completion synchronousHandoff:NO];
}
- (void)perform:(id(^)(NSError **))work completion:(CSBackupCompletion)completion synchronousHandoff:(BOOL)handoff {
    dispatch_async(self.queue,^{@autoreleasepool{
        NSError *error=nil;id result=nil;@try{result=work(&error);}@catch(NSException *exception){error=CSBackupFailure([@"备份操作中止：" stringByAppendingString:exception.reason?:@"未知异常"]);}
        if(error)self.status=error.localizedDescription;
        void (^deliver)(void)=^{if(completion)completion(result,error);};
        if(handoff)dispatch_sync(dispatch_get_main_queue(),deliver);else dispatch_async(dispatch_get_main_queue(),deliver);
    }});
}
- (void)list:(CSBackupCompletion)completion {
    [self perform:^id(NSError **error){
        NSMutableArray *records=[NSMutableArray array];NSUInteger bytes=0,unavailable=0,protectionIssues=0;
        for(NSDictionary *s in [self.engine.store records:error]){
            NSMutableDictionary *record=[s mutableCopy];NSError *metadataError=nil;
            record[@"metadata"]=[self.engine.store metadata:s[@"id"] error:&metadataError];
            if(metadataError){record[@"metadataWarning"]=metadataError.localizedDescription;protectionIssues++;}
            if([s[@"unavailable"] boolValue])unavailable++;
            bytes+=[s[@"size"] unsignedIntegerValue];[records addObject:record];
        }
        NSError *journalError=nil;NSDictionary *journal=[self.engine.store journal:&journalError];
        if(journalError){if(error)*error=journalError;}else if(journal)self.status=[NSString stringWithFormat:@"恢复状态：%@。本机备份占用 %@",[self stateTitle:journal[@"state"]],[NSByteCountFormatter stringFromByteCount:bytes countStyle:NSByteCountFormatterCountStyleFile]];
        else if(!(error&&*error))self.status=[NSString stringWithFormat:@"%lu 份可用备份 · %lu 份无法读取 · 占用 %@%@",(unsigned long)(records.count-unavailable),(unsigned long)unavailable,[NSByteCountFormatter stringFromByteCount:bytes countStyle:NSByteCountFormatterCountStyleFile],self.scheduler.dirty?@" · 自动备份等待中":@""];
        if(protectionIssues)self.status=[self.status stringByAppendingFormat:@"\n%lu 份备份保护状态需确认，已保留且不自动清理。",(unsigned long)protectionIssues];
        if(self.engine.store.cleanupStatus.length)self.status=[self.status stringByAppendingFormat:@"\n%@",self.engine.store.cleanupStatus];
        NSDate *last=[NSUserDefaults.standardUserDefaults objectForKey:@"com.wechat.enhance.backup.last_date"];
        if([last isKindOfClass:NSDate.class]){NSDateFormatter *date=[NSDateFormatter new];date.dateStyle=NSDateFormatterShortStyle;date.timeStyle=NSDateFormatterShortStyle;self.status=[self.status stringByAppendingFormat:@"\n最近自动备份：%@",[date stringFromDate:last]];}
        NSString *failure=[NSUserDefaults.standardUserDefaults stringForKey:@"com.wechat.enhance.backup.last_error"];
        if(failure.length)self.status=[self.status stringByAppendingFormat:@"\n最近自动备份未完成：%@",failure];
        NSString *upgradeFailure=[NSUserDefaults.standardUserDefaults stringForKey:UpgradeErrorKey];
        if(upgradeFailure.length)self.status=[self.status stringByAppendingFormat:@"\n版本更新备份未完成：%@",upgradeFailure];
        if(self.lastRestoreFailure.length)self.status=[self.status stringByAppendingFormat:@"\n上次恢复未完成：%@",self.lastRestoreFailure];
        return records;
    } completion:completion];
}
- (NSString *)stateTitle:(NSString *)state {return @{@"prepared":@"已准备，重新打开微信后应用",@"applying":@"应用中，需要完成恢复",@"rollingBack":@"回滚待完成",@"rolledBack":@"已回滚并保留原配置",@"committed":@"已应用并核验"}[state]?:state;}
- (void)load:(NSDictionary *)record completion:(CSBackupCompletion)completion {
    [self performRestore:@"selected" work:^id(NSError **error){
        [self.engine.store recordRestoreStage:@"selected" status:@"read" error:nil details:@{@"snapshotID":record[@"id"]?:@"",@"filename":record[@"filename"]?:@""}];
        return [self.engine.store snapshotForRestore:record[@"id"] error:error];} completion:completion];
}
- (void)create:(NSString *)name completion:(CSBackupCompletion)completion {[self perform:^id(NSError **error){NSDictionary *s=[self.engine save:name kind:@"manual" error:error];if(s)self.status=@"备份已完整保存在本机";return s;} completion:completion];}
- (void)importURL:(NSURL *)url completion:(CSBackupCompletion)completion {
    [self performRestore:@"import" work:^id(NSError **error){BOOL access=[url startAccessingSecurityScopedResource];__block NSDictionary *snapshot=nil;__block NSError *readError=nil;
        [self.engine.store recordRestoreStage:@"import" status:@"read" error:nil details:@{@"path":url.path?:@"",@"filename":url.lastPathComponent?:@""}];
        NSFileCoordinator *coordinator=[[NSFileCoordinator alloc]initWithFilePresenter:nil];
        [coordinator coordinateReadingItemAtURL:url options:0 error:&readError byAccessor:^(NSURL *readURL){
            NSData *data=CSBackupReadFile(readURL,CSBackupMaximumFileSize,&readError);if(!data)return;
            if(data.length<8||memcmp(data.bytes,"bplist00",8)){readError=CSBackupRestoreError(CSBackupFailure(@"仅支持 v2 .wcbak，不支持旧版 JSON 或目录备份；原文件未修改。"),@"import",CSBackupRestoreCompatibility,readURL.path);return;}
            snapshot=[CSBackupCodec decode:data error:&readError];
        }];if(access)[url stopAccessingSecurityScopedResource];
        if(!snapshot){if(error)*error=readError?:CSBackupFailure(@"无法读取备份");return nil;}
        // Validate asset references and image payloads before publishing imported files.
        NSMutableDictionary *writes=[NSMutableDictionary dictionary];
        if(![CSBackupAssets materializeFields:snapshot[@"fields"] assets:snapshot[@"assets"] root:self.engine.resourceRoot writes:writes error:error])return nil;
        if(![self validateColors:snapshot error:error]||![self.engine.store importSnapshot:snapshot error:error])return nil;
        self.status=@"导入完成，当前配置未改变";return snapshot;
    } completion:completion];
}
- (void)exportSnapshot:(NSDictionary *)snapshot completion:(CSBackupCompletion)completion {
    [self perform:^id(NSError **error){NSData *data=[CSBackupCodec encode:snapshot error:error];if(!data)return nil;
        NSURL *folder=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"WeChatImproveBackupExports"] isDirectory:YES];
        NSURL *url=[folder URLByAppendingPathComponent:[NSUUID.UUID.UUIDString stringByAppendingPathExtension:@"wcbak"]];return CSBackupAtomicWrite(data,url,error)?url:nil;
    } completion:completion];
}
- (void)exportOriginal:(NSDictionary *)record completion:(CSBackupCompletion)completion {
    [self perform:^id(NSError **error){
        NSData *data=[self.engine.store originalData:record[@"filename"] error:error];if(!data)return nil;
        NSURL *folder=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"WeChatImproveBackupExports"] isDirectory:YES];
        NSURL *url=[folder URLByAppendingPathComponent:[NSUUID.UUID.UUIDString stringByAppendingPathExtension:@"wcbak"]];
        return CSBackupAtomicWrite(data,url,error)?url:nil;
    } completion:completion];
}
- (void)remove:(NSDictionary *)record completion:(CSBackupCompletion)completion {[self perform:^id(NSError **error){return [self.engine.store remove:record[@"id"] error:error]?@YES:nil;} completion:completion];}
- (void)updateMetadata:(NSDictionary *)metadata record:(NSDictionary *)record completion:(CSBackupCompletion)completion {
    [self perform:^id(NSError **error){
        if(![self.engine.store snapshot:record[@"id"] error:error])return nil;
        NSError *metadataError=nil;NSMutableDictionary *current=[[self.engine.store metadata:record[@"id"] error:&metadataError] mutableCopy];
        if(metadataError&&!metadata[@"favorite"]){if(error)*error=metadataError;return nil;}
        [current addEntriesFromDictionary:metadata];
        return [self.engine.store setMetadata:current identifier:record[@"id"] error:error]?@YES:nil;
    } completion:completion];
}
- (BOOL)validateColors:(NSDictionary *)snapshot error:(NSError **)error {
    for(NSDictionary *f in snapshot[@"fields"])if([f[@"present"] boolValue]&&[[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]][@"type"] isEqual:@"data"]){
        NSError *decodeError=nil;UIColor *color=nil;@try{color=[NSKeyedUnarchiver unarchivedObjectOfClass:UIColor.class fromData:f[@"value"] error:&decodeError];}@catch(__unused NSException *exception){}
        if(!color||decodeError){if(error)*error=CSBackupFailure(@"备份中的颜色数据无法安全读取，未准备恢复");return NO;}
    }
    return YES;
}
- (void)preview:(NSDictionary *)snapshot modules:(NSSet *)modules accounts:(NSSet *)accounts completion:(CSBackupCompletion)completion {[self performRestore:@"validate" work:^id(NSError **error){if(![self validateColors:snapshot error:error]){if(error)*error=CSBackupRestoreError(*error,@"validate",CSBackupRestoreValidation,self.engine.store.root.path);return nil;}return [self.engine preview:snapshot modules:modules accounts:accounts error:error];} completion:completion];}
- (void)prepare:(NSDictionary *)preview completion:(CSBackupCompletion)completion {[self performRestore:@"prepared" work:^id(NSError **error){BOOL ok=[self.engine prepare:preview error:error];if(ok)self.status=[preview[@"snapshot"][@"operation"] isEqual:@"reset"]?@"重置已准备，请退出并重新打开微信后应用":@"恢复已准备，请退出并重新打开微信后应用";return ok?@YES:nil;} completion:completion];}
- (void)resetSnapshot:(CSBackupCompletion)completion {[self perform:^id(NSError **error){return [self.engine resetSnapshot:error];} completion:completion];}
- (void)checkRepairAccess:(CSBackupCompletion)completion {
    [self perform:^id(NSError **error){NSDictionary *journal=[self.engine.store journal:error];if(journal){if(error)*error=CSBackupFailure(@"请先取消尚未执行的恢复，或完成中断事务的回滚，再修复当前设置");return nil;}return (error&&*error)?nil:@YES;} completion:completion];
}
- (void)cancelPending:(CSBackupCompletion)completion {[self performRestore:@"cancel" work:^id(NSError **error){return [self.engine cancelPending:error]?@YES:nil;} completion:^(id result,NSError *error){if(!error)CSBackupResumeAfterRecovery();completion(result,error);}];}
- (BOOL)isAutoBackupEnabled {return [NSUserDefaults.standardUserDefaults boolForKey:AutoKey];}
- (void)enableAutoBackup:(BOOL)enabled {[NSUserDefaults.standardUserDefaults setBool:enabled forKey:AutoKey];[NSUserDefaults.standardUserDefaults synchronize];if(enabled)[self resourceChanged:nil];}
- (void)foreground:(NSNotification *)notification {(void)notification;dispatch_async(self.queue,^{self.active=YES;[self.scheduler changedAt:NSProcessInfo.processInfo.systemUptime-30];[self attemptUpgradeBackup:NULL];[self tick];});}
- (void)background:(NSNotification *)notification {(void)notification;dispatch_async(self.queue,^{self.active=NO;});}
- (NSString *)preferenceSignature {
    NSMutableDictionary *values=[NSMutableDictionary dictionary];NSMutableDictionary *domains=[NSMutableDictionary dictionary];
    for(NSDictionary *entry in CSBackupRegistry.entries){NSString *alias=entry[@"domain"],*domain=[alias isEqual:@"standard"]?self.standardDomain:([alias isEqual:@"legacy"]?@"com.cyansmoke.wechattweak":@"com.wechat.enhance");
        if(!domains[alias])domains[alias]=[NSUserDefaults.standardUserDefaults persistentDomainForName:domain]?:@{};
        id value=domains[alias][entry[@"key"]];if(value)values[[NSString stringWithFormat:@"%@/%@",alias,entry[@"key"]]]=value;}
    return [CSBackupCodec digest:values];
}
- (void)changed:(NSNotification *)notification {(void)notification;dispatch_async(self.queue,^{NSString *signature=[self preferenceSignature];if(![signature isEqual:self.signature]){self.signature=signature;[self.scheduler changedAt:NSProcessInfo.processInfo.systemUptime];}});}
- (void)resourceChanged:(NSNotification *)notification {(void)notification;dispatch_async(self.queue,^{[self.scheduler changedAt:NSProcessInfo.processInfo.systemUptime];});}
- (void)tick {
    if(!CSBackupIsReady()||![self.scheduler shouldRunAt:NSProcessInfo.processInfo.systemUptime enabled:self.isAutoBackupEnabled active:self.active])return;
    NSError *error=nil;NSDictionary *journal=[self.engine.store journal:&error];if(error)return;
    if(journal){if(([journal[@"state"] isEqual:@"committed"]&&[self.engine.store activationConfirmed:journal])||[journal[@"state"] isEqual:@"rolledBack"]){if(![self.engine.store archiveJournal:&error])return;}else return;}
    NSDictionary *saved=[self.engine save:@"自动备份" kind:@"automatic" error:&error];[self.scheduler completed:saved!=nil at:NSProcessInfo.processInfo.systemUptime];
    if(saved){[NSUserDefaults.standardUserDefaults removeObjectForKey:@"com.wechat.enhance.backup.last_error"];[NSUserDefaults.standardUserDefaults setObject:saved[@"createdAt"] forKey:@"com.wechat.enhance.backup.last_date"];self.status=@"自动备份已保存，未变化的内容会自动去重";}else {self.status=error.localizedDescription?:@"自动备份等待重试";[NSUserDefaults.standardUserDefaults setObject:self.status forKey:@"com.wechat.enhance.backup.last_error"];}
}
- (BOOL)attemptUpgradeBackup:(NSError **)error {
    // This method runs only on the serial I/O queue, after normal feature initialization.
    // Failure is local to backup settings and never participates in the startup gate.
    if(!CSBackupIsReady())return YES;
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    if([[defaults stringForKey:@"com.wechat.enhance.backup.protectedVersion"] isEqual:kPluginVersionString])return YES;
    NSError *failure=nil;NSDictionary *journal=[self.engine.store journal:&failure];
    if(journal){
        BOOL settled=[journal[@"state"] isEqual:@"rolledBack"]||([journal[@"state"] isEqual:@"committed"]&&[self.engine.store activationConfirmed:journal]);
        if(!settled)return YES; // Never compete with a prepared or unfinished transaction.
        if(![self.engine.store archiveJournal:&failure])failure=failure?:CSBackupFailure(@"恢复记录归档未完成");
    }
    NSDictionary *saved=failure?nil:[self.engine save:[@"版本更新备份 · " stringByAppendingString:kPluginVersionString] kind:@"upgrade" error:&failure];
    if(saved){
        [defaults setObject:kPluginVersionString forKey:@"com.wechat.enhance.backup.protectedVersion"];
        [defaults removeObjectForKey:UpgradeErrorKey];
        if(![defaults synchronize]){
            [defaults removeObjectForKey:@"com.wechat.enhance.backup.protectedVersion"];
            failure=CSBackupFailure(@"版本更新备份标记未保存");
        }
    }
    if(!saved||failure){
        NSString *message=failure.localizedDescription?:@"版本更新备份未完成";
        [defaults setObject:message forKey:UpgradeErrorKey];self.status=message;
        if(error)*error=failure?:CSBackupFailure(message);return NO;
    }
    return YES;
}
- (void)retryPendingWork:(CSBackupCompletion)completion {
    if(!CSBackupIsReady()){
        CSBackupRetryStartup(^(NSError *error){if(error)error=[self restoreError:error stage:@"startup-retry"];completion(error?nil:@YES,error);});return;
    }
    [self perform:^id(NSError **error){
        NSDictionary *journal=[self.engine.store journal:error];if(error&&*error)return nil;
        if(journal){
            BOOL settled=[journal[@"state"] isEqual:@"rolledBack"]||([journal[@"state"] isEqual:@"committed"]&&[self.engine.store activationConfirmed:journal]);
            if(!settled){if(error)*error=CSBackupRestoreError(CSBackupFailure(@"已有待执行计划；请完全退出微信进程后重新打开，切换前后台不会应用。也可先取消计划。"),@"restart-required",CSBackupRestoreRestart,self.engine.store.root.path);return nil;}
            if(![self.engine.store archiveJournal:error])return nil;
        }
        return [self attemptUpgradeBackup:error]?@YES:nil;
    } completion:completion];
}
- (void)resolveStartup:(CSBackupCompletion)completion {
    [self perform:^id(NSError **error){
        if(CSBackupIsReady()){if(error)*error=CSBackupRestoreError(CSBackupFailure(@"插件已初始化，请完全退出并重新打开微信后应用待恢复配置。"),@"startup",CSBackupRestoreRestart,self.engine.store.root.path);return nil;}
        [self.engine.store recordRestoreStage:@"startup" status:@"started" error:nil details:@{}];
        NSString *initialState=[self.engine.store journal:NULL][@"state"];
        if(![self.engine applyPending:error])return nil;
        if(self.engine.recoveryNotice)[self restoreError:self.engine.recoveryNotice stage:@"startup-recovered"];
        else if([initialState isEqual:@"rolledBack"]||[[self.engine.store journal:NULL][@"state"] isEqual:@"rolledBack"])
            [self restoreError:CSBackupFailure(@"上次恢复未完成，本次已回滚到恢复前配置；原备份仍保留，请检查原因后重新准备恢复。") stage:@"rolledBack"];
        NSDictionary *handoffContext=self.engine.appliedContext?:[self currentContext];
        if(![self.engine finishStartup:error])return nil;
        self.status=@"启动配置已就绪";return handoffContext;
    } completion:^(NSDictionary *context,NSError *error){
        if(error||!context){completion(nil,[self restoreError:error stage:@"startup"]);return;}
        __block BOOL delivered=NO;__block NSError *handoffError=nil;
        CSBackupPerformAtAccountEpoch([context[@"epoch"] unsignedIntegerValue],^{
            if([context isEqual:[self currentContext]]&&[self.engine confirmStartup:&handoffError]){delivered=YES;if(self.engine.appliedContext)[self clearRestoreFailure];[self.engine.store recordRestoreStage:@"startup" status:@"ready" error:nil details:@{}];completion(@YES,nil);dispatch_async(self.queue,^{[self attemptUpgradeBackup:NULL];});}
        });
        if(!delivered)[self perform:^id(NSError **rollbackError){return [self.engine rollbackBeforeActivation:rollbackError]?@YES:nil;} completion:^(__unused id result,NSError *rollbackError){completion(nil,[self restoreError:rollbackError?:handoffError?:CSBackupFailure(@"启动交接前账号发生变化，恢复已回滚，请重试") stage:@"account-handoff"]);}];
    } synchronousHandoff:YES];
}
@end
