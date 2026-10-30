#import "CSBackupEngine.h"
#import "CSBackupRegistry.h"
#import "CSBackupCodec.h"
#import "CSBackupAssets.h"
#import "CSBackupMutation.h"
#import "CSManagedImageFile.h"
#import "CSBackupRestoreDiagnostics.h"
#import "CSScheduledTaskStore.h"
#import "CSAIReplyStore.h"
#import "CSBackgroundRunPolicy.h"
#import <sys/stat.h>
static NSString *const Profiles=@"com.wechat.enhance.chat_group.account_profiles";
static NSString *const Selection=@"com.wechat.enhance.chat_group.selection.";
static BOOL EngineFail(NSError **error,NSString *message){if(error)*error=CSBackupFailure(message);return NO;}
static BOOL HasRuntimeFields(NSArray *fields) {for(NSDictionary *field in fields)if([field[@"domain"] isEqual:CSScheduledTaskBackupDomain] || [field[@"domain"] isEqual:CSAIReplyBackupDomain])return YES;return NO;}
static NSArray *RevisionFields(NSArray *fields) {
    NSMutableArray *result=[NSMutableArray arrayWithCapacity:fields.count];
    for(NSDictionary *field in fields) {
        // Older pending transactions predate this optional preference. Keep explicit
        // absence in portable snapshots, while preserving their original revision.
        if([field[@"domain"] isEqual:@"legacy"]&&[field[@"key"] isEqual:CSBackgroundRunPolicyKey]&&![field[@"present"] boolValue])continue;
        [result addObject:field];
    }
    return result;
}
static NSString *Revision(NSDictionary *snapshot, BOOL runtime) {
    NSArray *fields=RevisionFields(snapshot[@"fields"]);
    if(runtime&&(snapshot[@"scheduledTaskRevision"] || snapshot[@"aiReplyRevision"]))return [CSBackupCodec digest:@[fields,snapshot[@"assets"],snapshot[@"scheduledTaskRevision"]?:@"",snapshot[@"aiReplyRevision"]?:@"",snapshot[@"resetRawRevision"]?:@"",snapshot[@"missingAssets"]?:@[]]];
    if(snapshot[@"resetRawRevision"])return [CSBackupCodec digest:@[fields,snapshot[@"assets"],snapshot[@"resetRawRevision"],snapshot[@"missingAssets"]?:@[]]];
    return [CSBackupCodec digest:@[fields,snapshot[@"assets"]]];
}
static BOOL IsReset(NSDictionary *snapshot) {return [snapshot[@"operation"] isEqual:@"reset"];}
static NSString *Identity(NSDictionary *f){return [NSString stringWithFormat:@"%@/%@",f[@"domain"],f[@"key"]];}
static NSString *StartupSession(void){static NSString *identifier;static dispatch_once_t once;dispatch_once(&once,^{identifier=NSUUID.UUID.UUIDString;});return identifier;}
@interface CSBackupEngine ()
@property(nonatomic) NSDictionary<NSString *,NSUserDefaults *> *defaults;
@property(nonatomic) NSDictionary<NSString *,NSString *> *domains;
@property(nonatomic,readwrite) NSDictionary *appliedContext;
@property(nonatomic) NSDictionary *activationRecord;
@property(nonatomic,readwrite) NSError *recoveryNotice;
@end
@implementation CSBackupEngine
- (instancetype)initWithDefaults:(NSDictionary *)defaults domains:(NSDictionary *)domains store:(CSBackupStore *)store resources:(NSURL *)resources {
    if((self=[super init])){_defaults=defaults;_domains=domains;_store=store;_resourceRoot=resources;_context=^{return @{@"account":@"",@"installationID":@"",@"pluginVersion":@""};};}return self;
}
- (id)runRestoreStage:(NSString *)stage category:(CSBackupRestoreErrorCode)category details:(NSDictionary *)details work:(id(^)(NSError **))work error:(NSError **)error {
    NSMutableDictionary *context=[@{@"resourceRoot":self.resourceRoot.path} mutableCopy];[context addEntriesFromDictionary:details];
    [self.store recordRestoreStage:stage status:@"started" error:nil details:context];
    NSError *failure=nil;id result=nil;
    @try {result=work(&failure);}
    @catch(NSException *exception){
        NSError *caught=CSBackupRestoreError(CSBackupFailure(exception.reason?:@"恢复操作异常中断"),stage,category,self.store.root.path);
        [self.store recordRestoreStage:stage status:@"failed" error:caught details:context];@throw;
    }
    if(!result)failure=CSBackupRestoreError(failure,stage,category,self.store.root.path);
    [self.store recordRestoreStage:stage status:result?@"ok":@"failed" error:result?nil:failure details:context];
    if(!result&&error)*error=failure;return result;
}
- (NSDictionary *)preview:(NSDictionary *)snapshot modules:(NSSet *)modules accounts:(NSSet *)accounts error:(NSError **)error {
    return [self runRestoreStage:@"validate" category:CSBackupRestoreValidation details:@{@"snapshotID":snapshot[@"id"]?:@""}
        work:^id(NSError **failure){return [self previewContent:snapshot modules:modules accounts:accounts error:failure];} error:error];
}
- (BOOL)prepare:(NSDictionary *)preview error:(NSError **)error {
    BOOL ok=[self runRestoreStage:@"prepare" category:CSBackupRestoreState details:@{@"snapshotID":preview[@"snapshot"][@"id"]?:@""}
        work:^id(NSError **failure){return [self prepareContent:preview error:failure]?@YES:nil;} error:error]!=nil;
    if(ok)[self.store recordRestoreStage:@"prepared" status:@"restart-required" error:nil details:@{}];return ok;
}
- (BOOL)applyPending:(NSError **)error {
    NSError *failure=nil;BOOL ok=[self runRestoreStage:@"apply" category:CSBackupRestoreState details:@{}
        work:^id(NSError **cause){return [self applyPendingContent:cause]?@YES:nil;} error:&failure]!=nil;
    if(!ok){
        NSMutableDictionary *journal=[[self.store journal:NULL] mutableCopy];
        id attempt=journal[@"startupAttempt"];
        if([journal[@"state"] isEqual:@"prepared"]&&[attempt isKindOfClass:NSDictionary.class]&&[attempt[@"sessionID"] isEqual:StartupSession()]&&[self validJournal:journal error:NULL]){
            NSString *reason=failure.localizedDescription?:@"上次启动未完成恢复前检查";
            journal[@"startupFailure"]=[reason substringToIndex:MIN(reason.length,(NSUInteger)2048)];
            NSError *recordError=nil;if(![self.store writeJournal:journal error:&recordError])
                [self.store recordRestoreStage:@"attempt-failure" status:@"failed" error:recordError details:@{}];
        }
        if(error)*error=failure;
    }return ok;
}
- (BOOL)finishStartup:(NSError **)error {
    return [self runRestoreStage:@"verify" category:CSBackupRestoreState details:@{}
        work:^id(NSError **failure){return [self finishStartupContent:failure]?@YES:nil;} error:error]!=nil;
}
- (BOOL)confirmStartup:(NSError **)error {
    return [self runRestoreStage:@"activation" category:CSBackupRestoreStorage details:@{}
        work:^id(NSError **failure){return [self confirmStartupContent:failure]?@YES:nil;} error:error]!=nil;
}
- (BOOL)cancelPending:(NSError **)error {
    return [self runRestoreStage:@"cancel" category:CSBackupRestoreState details:@{}
        work:^id(NSError **failure){return [self cancelPendingContent:failure]?@YES:nil;} error:error]!=nil;
}
- (NSArray *)preferenceFields:(NSError **)error {
    __block NSArray *fields=nil;__block NSError *readError=nil;
    if(!self.readPreferencesOnMain||NSThread.isMainThread)fields=[self readRawFields:&readError];
    else dispatch_sync(dispatch_get_main_queue(),^{fields=[self readRawFields:&readError];});
    if(!fields&&error)*error=readError;return fields;
}
- (NSArray *)rawFields:(NSError **)error {
    NSArray *fields=[self preferenceFields:error];if(!fields)return nil;
    NSMutableArray *result=[fields mutableCopy];NSString *account=self.context()[@"account"];
    if(account.length){NSDictionary *scheduled=[self scheduledFieldForAccount:account error:error];if(!scheduled)return nil;if([scheduled[@"present"] boolValue])[result addObject:scheduled];NSDictionary *ai=[self aiFieldForAccount:account error:error];if(!ai)return nil;if([ai[@"present"] boolValue])[result addObject:ai];}
    [result sortUsingComparator:^NSComparisonResult(NSDictionary *a,NSDictionary *b){return [Identity(a) compare:Identity(b)];}];return result;
}
- (NSDictionary *)scheduledFieldForAccount:(NSString *)account error:(NSError **)error {
    if(![CSBackupRegistry entryForDomain:CSScheduledTaskBackupDomain key:account]){EngineFail(error,@"定时任务所属账号无效");return nil;}
    NSError *failure=nil;NSDictionary *state=[CSScheduledTaskStore readStateAtURL:CSScheduledTaskFileURL(self.resourceRoot,account) account:account error:&failure];
    if(failure){if(error)*error=failure;return nil;}
    NSMutableDictionary *field=[@{@"domain":CSScheduledTaskBackupDomain,@"key":account,@"present":state?@YES:@NO} mutableCopy];if(state)field[@"value"]=state;return field;
}
- (NSDictionary *)aiFieldForAccount:(NSString *)account error:(NSError **)error {
    if(![CSBackupRegistry entryForDomain:CSAIReplyBackupDomain key:account]){EngineFail(error,@"AI 配置所属账号无效");return nil;}
    NSError *failure=nil;NSDictionary *state=[CSAIReplyStore readStateAtURL:CSAIReplyFileURL(self.resourceRoot,account) account:account error:&failure];
    if(failure){if(error)*error=failure;return nil;}
    NSMutableDictionary *field=[@{@"domain":CSAIReplyBackupDomain,@"key":account,@"present":state?@YES:@NO} mutableCopy];if(state)field[@"value"]=state;return field;
}
- (NSArray *)readRawFields:(NSError **)error {
    NSMutableDictionary *values=[NSMutableDictionary dictionary];
    for(NSString *alias in self.domains)values[alias]=[self.defaults[alias] persistentDomainForName:self.domains[alias]]?:@{};
    NSMutableArray *entries=[CSBackupRegistry.entries mutableCopy];NSMutableSet *keys=[NSMutableSet setWithArray:[values[@"standard"] allKeys]];
    id profiles=values[@"standard"][Profiles];if([profiles isKindOfClass:NSDictionary.class])for(NSString *account in profiles)[keys addObject:[Selection stringByAppendingString:account]];
    for(NSString *key in keys)if([key hasPrefix:Selection]){NSDictionary *entry=[CSBackupRegistry entryForDomain:@"standard" key:key];if(entry)[entries addObject:entry];}
    NSMutableArray *fields=[NSMutableArray array];
    for(NSDictionary *entry in entries){NSString *domain=entry[@"domain"],*key=entry[@"key"];id value=values[domain][key];
        if(value&&![CSBackupRegistry validateValue:value entry:entry error:error])return nil;
        NSMutableDictionary *field=[@{@"domain":domain,@"key":key,@"present":(value?@YES:@NO)} mutableCopy];if(value)field[@"value"]=value;[fields addObject:field];}
    [fields sortUsingComparator:^NSComparisonResult(NSDictionary *a,NSDictionary *b){return [Identity(a) compare:Identity(b)];}];return fields;
}
- (NSDictionary *)capture:(NSString *)name kind:(NSString *)kind error:(NSError **)error {
    return [self capture:name kind:kind allowingMissingAssets:NO error:error];
}
- (NSDictionary *)capture:(NSString *)name kind:(NSString *)kind allowingMissingAssets:(BOOL)allowMissing error:(NSError **)error {
    // Retry instead of publishing a snapshot spanning an observed configuration/image change.
    for(NSUInteger attempt=0;attempt<3;attempt++) {
        uint64_t generation=CSBackupResourceRevision();if(CSBackupResourceWriteInProgress())continue;
        NSDictionary *context=self.context();NSArray *raw=[self rawFields:error];if(!raw)return nil;
        NSMutableArray *missing=allowMissing?[NSMutableArray array]:nil;
        NSMutableDictionary *assets=[NSMutableDictionary dictionary];NSArray *fields=[CSBackupAssets captureFields:raw root:self.resourceRoot assets:assets missing:missing error:error];if(!fields)return nil;
        NSArray *again=[self rawFields:error];if(!again)return nil;NSMutableDictionary *secondAssets=[NSMutableDictionary dictionary];
        NSMutableArray *secondMissing=allowMissing?[NSMutableArray array]:nil;
        NSArray *second=[CSBackupAssets captureFields:again root:self.resourceRoot assets:secondAssets missing:secondMissing error:error];if(!second)return nil;
        if(CSBackupResourceWriteInProgress()||generation!=CSBackupResourceRevision()||![context isEqual:self.context()]||![fields isEqual:second]||![assets isEqual:secondAssets]||![raw isEqual:again]||(allowMissing&&![missing isEqual:secondMissing]))continue;
        NSMutableDictionary *source=[context mutableCopy];NSMutableSet *coverage=[NSMutableSet set];if([context[@"account"] length])[coverage addObject:context[@"account"]];
        for(NSDictionary *f in raw)if([f[@"key"] isEqual:Profiles]&&[f[@"value"] isKindOfClass:NSDictionary.class])[coverage addObjectsFromArray:[f[@"value"] allKeys]];
        source[@"accounts"]=[coverage.allObjects sortedArrayUsingSelector:@selector(compare:)];
        NSMutableDictionary *snapshot=[@{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":name,@"kind":kind,@"createdAt":NSDate.date,@"source":source,@"fields":fields,@"assets":assets,@"warnings":[context[@"account"] length]?@[]:@[@"当前账号尚未就绪；已保存现有账号记录，恢复关系配置前需要确认账号。"]} mutableCopy];
        NSMutableArray *portable=[NSMutableArray array],*scheduledState=[NSMutableArray array],*aiState=[NSMutableArray array];
        for(NSDictionary *field in fields){
            if([field[@"domain"] isEqual:CSScheduledTaskBackupDomain]&&[field[@"present"] boolValue]){
                [scheduledState addObject:field];NSMutableDictionary *copy=[field mutableCopy];copy[@"value"]=CSScheduledTaskBackupConfiguration(field[@"value"]);[portable addObject:copy];
            }else if([field[@"domain"] isEqual:CSAIReplyBackupDomain]&&[field[@"present"] boolValue]){[aiState addObject:field];NSMutableDictionary *copy=[field mutableCopy];copy[@"value"]=CSAIReplyPortableState(field[@"value"]);[portable addObject:copy];}else [portable addObject:field];
        }
        snapshot[@"fields"]=portable;
        // Claims affect the restore revision, but are never exported as replayable work.
        if(scheduledState.count)snapshot[@"scheduledTaskRevision"]=[CSBackupCodec digest:scheduledState];
        if(aiState.count)snapshot[@"aiReplyRevision"]=[CSBackupCodec digest:aiState];
        if(allowMissing){
            snapshot[@"resetRawRevision"]=[CSBackupCodec digest:RevisionFields(raw)];snapshot[@"missingAssets"]=missing;
            NSMutableArray *warnings=[snapshot[@"warnings"] mutableCopy];
            for(NSDictionary *record in missing){
                NSDictionary *entry=[CSBackupRegistry entryForDomain:record[@"domain"] key:record[@"key"]];
                [warnings addObject:[NSString stringWithFormat:@"%@：图片 %@ 已丢失，保护备份无法找回该图片；其余可读配置和图片会保存。",CSBackupRegistry.moduleTitles[entry[@"module"]],[record[@"path"] lastPathComponent]]];
            }
            snapshot[@"warnings"]=[NSOrderedSet orderedSetWithArray:warnings].array;
        }
        NSData *data=[CSBackupCodec encode:snapshot error:error];return data?[CSBackupCodec decode:data error:error]:nil;
    }
    EngineFail(error,@"配置或图片正在变化，未保存混合快照，请停止编辑后重试");return nil;
}
- (NSDictionary *)save:(NSString *)name error:(NSError **)error {
    NSDictionary *snapshot=[self capture:name kind:@"manual" error:error];if(!snapshot)return nil;
    return [self.store publish:snapshot error:error]?snapshot:nil;
}
- (NSDictionary *)previewContent:(NSDictionary *)snapshot modules:(NSSet *)modules accounts:(NSSet *)accounts error:(NSError **)error {
    NSData *encoded=[CSBackupCodec encode:snapshot error:error];if(!encoded)return nil;
    BOOL reset=IsReset(snapshot);
    if(reset){
        if([snapshot[@"assets"] count]){EngineFail(error,@"重置计划不能包含图片写入");return nil;}
        for(NSDictionary *field in snapshot[@"fields"])if([field[@"present"] boolValue]||field[@"fallbackAsset"]){EngineFail(error,@"重置计划只能清除已登记的配置");return nil;}
    }
    NSDictionary *current=[self capture:@"预览状态" kind:@"protection" allowingMissingAssets:reset error:error];if(!current)return nil;
    NSDictionary *context=self.context(),*source=snapshot[@"source"];
    NSMutableDictionary *byID=[NSMutableDictionary dictionary];for(NSDictionary *f in current[@"fields"])byID[Identity(f)]=f;
    // Show removal of a missing reference as a real change, although the portable
    // protection snapshot deliberately cannot recreate an image that no longer exists.
    for(NSDictionary *record in current[@"missingAssets"]){
        NSString *identity=Identity(record);NSMutableDictionary *field=[byID[identity] mutableCopy];
        if(record[@"contact"]){NSMutableDictionary *contacts=[field[@"value"] mutableCopy];NSMutableDictionary *config=[contacts[record[@"contact"]] mutableCopy];config[@"separatorImagePath"]=record[@"path"];contacts[record[@"contact"]]=config;field[@"value"]=contacts;}
        else {field[@"present"]=@YES;field[@"value"]=record[@"path"];}
        byID[identity]=field;
    }
    NSMutableArray *selected=[NSMutableArray array],*changes=[NSMutableArray array],*warnings=[(reset?current[@"warnings"]:snapshot[@"warnings"]) mutableCopy];
    if(!reset&&![source[@"pluginVersion"] isEqual:context[@"pluginVersion"]])
        [warnings addObject:[NSString stringWithFormat:@"备份来自插件 %@；已校验 v2 资源引用，图片会按当前资源目录重新生成路径。",source[@"pluginVersion"]?:@"未知版本"]];
    BOOL relationships=[source[@"installationID"] isEqual:context[@"installationID"]]&&[context[@"account"] length]&&[source[@"account"] isEqual:context[@"account"]];
    for(NSDictionary *field in snapshot[@"fields"]) {
        NSDictionary *entry=[CSBackupRegistry entryForDomain:field[@"domain"] key:field[@"key"]];if(![modules containsObject:entry[@"module"]])continue;
        if([entry[@"scope"] isEqual:@"relationship"]&&!relationships){[warnings addObject:@"已跳过联系人/群关系配置：仅允许同一本机来源及同一当前账号恢复。"];continue;}
        NSMutableDictionary *f=[field mutableCopy];NSString *key=f[@"key"];
        if([f[@"domain"] isEqual:CSScheduledTaskBackupDomain]) {
            if(![accounts containsObject:key]||![key isEqual:context[@"account"]]||![key isEqual:source[@"account"]]){
                [warnings addObject:@"已跳过其他账号的定时任务：请登录备份原账号后选择恢复。"];continue;
            }
            if([f[@"present"] boolValue]){
                NSMutableDictionary *state=[CSScheduledTaskBackupConfiguration(f[@"value"]) mutableCopy];state[@"enabled"]=@NO;state[@"history"]=@[];f[@"value"]=state;
                [warnings addObject:@"定时任务恢复后总开关关闭；不导入执行记录或待发送状态。请确认会话和时间规则后手动开启，关闭期间的消息不会补发。"];
            }
        }else if([f[@"domain"] isEqual:CSAIReplyBackupDomain]) {
            if(![accounts containsObject:key] || ![key isEqual:context[@"account"]] || ![key isEqual:source[@"account"]]){[warnings addObject:@"已跳过其他账号的 AI 回复配置：请登录备份原账号后恢复。"];continue;}
            if([f[@"present"] boolValue]){
                NSMutableDictionary *state=[CSAIReplyPortableState(f[@"value"]) mutableCopy],*configuration=[state[@"configuration"] mutableCopy];
                configuration[@"enabled"]=@NO;configuration[@"credentialRevision"]=@"";configuration[@"verifiedConnection"]=@"";
                state[@"configuration"]=configuration;state[@"handled"]=@{};state[@"history"]=@[];f[@"value"]=state;
                [warnings addObject:@"AI 回复恢复后总开关关闭；API Key、连接验证和运行记录不随备份导入。请重新设置 Key 并测试连接。"];
            }
        }else if([key isEqual:Profiles]) {
            if(!accounts.count)continue;
            NSDictionary *old=byID[Identity(f)][@"value"]?:@{};NSMutableDictionary *merged=[old mutableCopy];NSDictionary *incoming=f[@"value"]?:@{};
            for(NSString *account in accounts){if(incoming[account])merged[account]=incoming[account];else if(![f[@"present"] boolValue]&&old[account]&&([source[@"accounts"] containsObject:account]||[source[@"account"] isEqual:account]))[merged removeObjectForKey:account];}
            if(merged.count){f[@"present"]=@YES;f[@"value"]=merged;}else{f[@"present"]=@NO;[f removeObjectForKey:@"value"];}
        }else if([key hasPrefix:Selection]&&![accounts containsObject:[key substringFromIndex:Selection.length]])continue;
        [selected addObject:f];NSDictionary *before=byID[Identity(f)]?:@{@"domain":f[@"domain"],@"key":key,@"present":@NO};
        NSMutableDictionary *comparison=[f mutableCopy];if([f[@"domain"] isEqual:CSScheduledTaskBackupDomain]&&f[@"value"])comparison[@"value"]=CSScheduledTaskBackupConfiguration(f[@"value"]);if([f[@"domain"] isEqual:CSAIReplyBackupDomain]&&f[@"value"])comparison[@"value"]=CSAIReplyPortableState(f[@"value"]);
        if(![before isEqual:comparison])[changes addObject:@{@"module":entry[@"module"],@"key":key,@"before":before,@"after":f,@"reset":([f[@"present"] boolValue]?@NO:@YES)}];
    }
    if(!selected.count){EngineFail(error,@"没有可恢复的配置，请选择模块和账号");return nil;}
    NSMutableDictionary *writes=[NSMutableDictionary dictionary];NSArray *desired=[CSBackupAssets materializeFields:selected assets:snapshot[@"assets"] root:self.resourceRoot writes:writes error:error];if(!desired)return nil;
    return @{@"snapshot":snapshot,@"fields":desired,@"writes":writes,@"changes":changes,@"warnings":[NSOrderedSet orderedSetWithArray:warnings].array,@"revision":Revision(current,HasRuntimeFields(desired)),@"context":context,@"modules":modules.allObjects,@"accounts":accounts.allObjects};
}
- (NSArray *)beforeFields:(NSArray *)fields error:(NSError **)error {
    NSArray *raw=[self preferenceFields:error];if(!raw)return nil;NSMutableDictionary *byID=[NSMutableDictionary dictionary];for(NSDictionary *f in raw)byID[Identity(f)]=f;
    NSMutableArray *result=[NSMutableArray array];for(NSDictionary *f in fields){
        // Rollback may run after an account change; verify the journal's original file.
        NSDictionary *before=[f[@"domain"] isEqual:CSScheduledTaskBackupDomain]?[self scheduledFieldForAccount:f[@"key"] error:error]:([f[@"domain"] isEqual:CSAIReplyBackupDomain]?[self aiFieldForAccount:f[@"key"] error:error]:byID[Identity(f)]);
        if(([f[@"domain"] isEqual:CSScheduledTaskBackupDomain]||[f[@"domain"] isEqual:CSAIReplyBackupDomain])&&!before)return nil;
        [result addObject:before?:@{@"domain":f[@"domain"],@"key":f[@"key"],@"present":@NO}];
    }return result;
}
- (NSDictionary *)beforeWrites:(NSDictionary *)writes error:(NSError **)error {
    NSUInteger total=0;NSMutableDictionary *blobs=[NSMutableDictionary dictionary];NSMutableDictionary *result=[NSMutableDictionary dictionary];for(NSString *name in writes){NSURL *url=[self.resourceRoot URLByAppendingPathComponent:name];
        struct stat metadata;int status=lstat(url.fileSystemRepresentation,&metadata);
        if(status&&errno!=ENOENT){if(error)*error=CSBackupFileError(url.path,@"inspect-resource",errno);return nil;}
        if(!status){NSData *data=CSBackupReadFile(url,4*1024*1024,error);if(!data)return nil;NSString *hash=[CSBackupCodec digest:data];if(blobs[hash])data=blobs[hash];else{blobs[hash]=data;total+=data.length;}if(total>48*1024*1024){EngineFail(error,@"恢复前图片保护数据超过 48 MiB，未创建待恢复计划");return nil;}result[name]=@{@"present":@YES,@"data":data};}else result[name]=@{@"present":@NO};}
    return result;
}
- (BOOL)prepareContent:(NSDictionary *)preview error:(NSError **)error {
    NSError *existingError=nil;NSDictionary *existing=[self.store journal:&existingError];if(existingError){if(error)*error=existingError;return NO;}
    if(existing){if([existing[@"state"] isEqual:@"rolledBack"]||([existing[@"state"] isEqual:@"committed"]&&[self.store activationConfirmed:existing])){if(![self.store archiveJournal:error])return NO;}else return EngineFail(error,@"已有待处理的恢复，请先取消或完成它");}
    if(![self.context()[@"account"] length])return EngineFail(error,@"当前账号尚未就绪，请登录后重新预览恢复");
    BOOL reset=IsReset(preview[@"snapshot"]);
    NSDictionary *current=[self capture:reset?@"重置状态核验":@"恢复状态核验" kind:@"protection" allowingMissingAssets:reset error:error];if(!current)return NO;
    if(![preview[@"context"] isEqual:self.context()]||![preview[@"revision"] isEqual:Revision(current,HasRuntimeFields(preview[@"fields"]))])return EngineFail(error,@"配置或账号已变化，请重新打开恢复预览");
    NSDictionary *rebuilt=[self preview:preview[@"snapshot"] modules:[NSSet setWithArray:preview[@"modules"]?:@[]] accounts:[NSSet setWithArray:preview[@"accounts"]?:@[]] error:error];
    if(!rebuilt)return NO;
    if(![rebuilt[@"fields"] isEqual:preview[@"fields"]]||![rebuilt[@"writes"] isEqual:preview[@"writes"]]||![rebuilt[@"revision"] isEqual:preview[@"revision"]])return EngineFail(error,@"恢复计划已变化，请重新预览");
    // Only transaction before-images are persisted; no backup file is published here.
    NSArray *before=[self beforeFields:preview[@"fields"] error:error];NSDictionary *beforeWrites=[self beforeWrites:preview[@"writes"] error:error];if(!before||!beforeWrites)return NO;
    NSDictionary *journal=@{@"operation":reset?@"reset":@"restore",@"version":@1,@"transactionID":NSUUID.UUID.UUIDString,@"state":@"prepared",@"sourceID":preview[@"snapshot"][@"id"],@"account":preview[@"context"][@"account"],@"installationID":preview[@"context"][@"installationID"],@"revision":preview[@"revision"],@"before":before,@"after":preview[@"fields"],@"beforeWrites":beforeWrites,@"afterWrites":preview[@"writes"]};
    if(![self validJournal:journal error:error])return NO;
    BOOL ok=[self.store writeJournal:journal error:error];if(ok&&self.checkpoint)self.checkpoint(@"prepared");return ok;
}
- (BOOL)validJournal:(NSDictionary *)journal error:(NSError **)error {
    if(![journal[@"version"] isEqual:@1]||![@[@"prepared",@"applying",@"rollingBack",@"rolledBack",@"committed"] containsObject:journal[@"state"]])return EngineFail(error,@"恢复日志版本或状态无效");
    id attempt=journal[@"startupAttempt"];
    if(attempt&&(![attempt isKindOfClass:NSDictionary.class]||![attempt[@"sessionID"] isKindOfClass:NSString.class]||![[NSUUID alloc]initWithUUIDString:attempt[@"sessionID"]]||![attempt[@"startedAt"] isKindOfClass:NSDate.class]))return EngineFail(error,@"恢复启动记录无效，原事务已保留");
    for(NSString *key in @[@"startupFailure",@"resolutionReason"])if(journal[key]&&(![journal[key] isKindOfClass:NSString.class]||[journal[key] length]>2048))return EngineFail(error,@"恢复失败说明无效");
    if(journal[@"resolution"]&&(![journal[@"resolution"] isEqual:@"cancelledBeforeApply"]||![journal[@"state"] isEqual:@"rolledBack"]))return EngineFail(error,@"恢复撤销状态无效");
    for(NSString *part in @[@"before",@"after"]){NSArray *fields=journal[part];if(![fields isKindOfClass:NSArray.class]||fields.count>4096)return EngineFail(error,@"恢复日志配置列表无效");
        NSMutableSet *seen=[NSMutableSet set];for(NSDictionary *f in fields){if(![f isKindOfClass:NSDictionary.class])return EngineFail(error,@"恢复字段损坏");NSDictionary *entry=[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]];if(!entry||![f[@"present"] isKindOfClass:NSNumber.class]||[seen containsObject:Identity(f)])return EngineFail(error,@"恢复日志包含未登记或重复的配置");[seen addObject:Identity(f)];if([f[@"present"] boolValue]&&![CSBackupRegistry validateValue:f[@"value"] entry:entry error:error])return NO;
            if([f[@"domain"] isEqual:CSAIReplyBackupDomain]&&(![f[@"key"] isEqual:journal[@"account"]]||([f[@"present"] boolValue]&&(!f[@"value"][@"history"]||!f[@"value"][@"handled"]))))return EngineFail(error,@"AI 回复恢复日志所属账号或状态无效");
            if([f[@"domain"] isEqual:CSScheduledTaskBackupDomain]&&(![f[@"key"] isEqual:journal[@"account"]]||([f[@"present"] boolValue]&&!f[@"value"][@"history"])))return EngineFail(error,@"定时任务恢复日志所属账号或状态无效");}
    }
    for(NSString *part in @[@"beforeWrites",@"afterWrites"]){NSDictionary *writes=journal[part];if(![writes isKindOfClass:NSDictionary.class]||writes.count>256)return EngineFail(error,@"恢复日志资源无效");
        for(NSString *name in writes){BOOL valid=[name isEqual:@"separator_image.png"]||[name isEqual:@"touch_trail.png"]||([name hasPrefix:@"backup_"]&&[name hasSuffix:@".png"]&&name.length==75&&[[name substringWithRange:NSMakeRange(7,64)] rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdef"] invertedSet]].location==NSNotFound);
            id r=writes[name];if(!valid||![r isKindOfClass:NSDictionary.class]||![r[@"present"] isKindOfClass:NSNumber.class]||([r[@"present"] boolValue]&&(![r[@"data"] isKindOfClass:NSData.class]||[r[@"data"] length]>4*1024*1024)))return EngineFail(error,@"恢复日志资源路径或数据无效");}
    }return YES;
}
- (BOOL)writeFields:(NSArray *)fields writes:(NSDictionary *)writes context:(NSDictionary *)context error:(NSError **)error {
    for(NSString *name in [[writes allKeys] sortedArrayUsingSelector:@selector(compare:)]){
        if(context&&![context isEqual:self.context()])return EngineFail(error,@"恢复期间账号发生变化");
        NSURL *url=[self.resourceRoot URLByAppendingPathComponent:name];NSDictionary *r=writes[name];
        NSDictionary *details=@{@"path":url.path,@"action":[r[@"present"] boolValue]?@"write":@"remove"};
        [self.store recordRestoreStage:@"write-resource" status:@"started" error:nil details:details];
        NSError *failure=nil;BOOL ok=[r[@"present"] boolValue]?CSBackupAtomicWrite(r[@"data"],url,&failure):CSManagedImageRemoveInDirectory(url.path,self.resourceRoot,&failure);
        if(!ok)failure=CSBackupRestoreError(failure,@"write-resource",CSBackupRestoreStorage,url.path);
        [self.store recordRestoreStage:@"write-resource" status:ok?@"ok":@"failed" error:failure details:details];
        if(!ok){if(error)*error=failure;return NO;}
        if(self.checkpoint)self.checkpoint(@"resource");
    }
    return [self runRestoreStage:@"write-preferences" category:CSBackupRestoreStorage details:@{@"fieldCount":@(fields.count)}
        work:^id(NSError **failure){return [self writePreferences:fields writes:writes context:context error:failure]?@YES:nil;} error:error]!=nil;
}
- (BOOL)writePreferences:(NSArray *)fields writes:(NSDictionary *)writes context:(NSDictionary *)context error:(NSError **)error {
    for(NSDictionary *f in fields){if(context&&![context isEqual:self.context()])return EngineFail(error,@"恢复期间账号发生变化");NSUserDefaults *defaults=self.defaults[f[@"domain"]];
        if([f[@"domain"] isEqual:CSAIReplyBackupDomain]){
            BOOL ok=[CSAIReplyStore replaceState:[f[@"present"] boolValue]?f[@"value"]:nil atURL:CSAIReplyFileURL(self.resourceRoot,f[@"key"]) account:f[@"key"] error:error];
            if(!ok)return NO;if(self.checkpoint)self.checkpoint(@"preference");continue;
        }
        if([f[@"domain"] isEqual:CSScheduledTaskBackupDomain]){
            NSURL *url=CSScheduledTaskFileURL(self.resourceRoot,f[@"key"]);NSDictionary *details=@{@"path":url.path,@"action":[f[@"present"] boolValue]?@"write":@"reset"};
            [self.store recordRestoreStage:@"write-scheduled-tasks" status:@"started" error:nil details:details];NSError *failure=nil;
            BOOL ok=[CSScheduledTaskStore replaceState:[f[@"present"] boolValue]?f[@"value"]:nil atURL:url account:f[@"key"] error:&failure];
            [self.store recordRestoreStage:@"write-scheduled-tasks" status:ok?@"ok":@"failed" error:failure details:details];
            if(!ok){if(error)*error=failure;return NO;}
            if(self.checkpoint)self.checkpoint(@"scheduled-tasks");
        }else if([f[@"present"] boolValue])[defaults setObject:f[@"value"] forKey:f[@"key"]];else [defaults removeObjectForKey:f[@"key"]];if(self.checkpoint)self.checkpoint(@"field");}
    for(NSUserDefaults *defaults in self.defaults.allValues)if(![defaults synchronize])return EngineFail(error,@"偏好持久化失败");
    if(self.checkpoint)self.checkpoint(@"synchronized");
    if(context&&![context isEqual:self.context()])return EngineFail(error,@"恢复期间账号发生变化");
    BOOL verified=[self verifyFields:fields writes:writes error:error];
    if(context&&![context isEqual:self.context()])return EngineFail(error,@"核验期间账号发生变化");
    return verified;
}
- (BOOL)verifyFields:(NSArray *)fields writes:(NSDictionary *)writes error:(NSError **)error {
    NSArray *current=[self beforeFields:fields error:error];if(!current)return NO;if(![current isEqual:fields])return EngineFail(error,@"恢复配置回读校验失败");
    NSDictionary *resources=[self beforeWrites:writes error:error];if(!resources)return NO;if(![resources isEqual:writes])return EngineFail(error,@"恢复图片回读校验失败");return YES;
}
- (BOOL)applyPendingContent:(NSError **)error {
    if(![self.store prepareForWriting:error])return NO;
    self.appliedContext=nil;self.activationRecord=nil;self.recoveryNotice=nil;
    NSError *readError=nil;NSDictionary *record=[self.store journal:&readError];if(readError){if(error)*error=readError;return NO;}if(!record)return YES;
    if(![self validJournal:record error:error]){if(error)*error=CSBackupRestoreError(*error,@"journal-validate",CSBackupRestoreValidation,[self.store.root URLByAppendingPathComponent:@"transaction.plist"].path);return NO;}
    NSMutableDictionary *journal=[record mutableCopy];NSString *state=journal[@"state"];
    [self.store recordRestoreStage:@"journal-read" status:@"ok" error:nil details:@{@"state":state?:@"",@"transactionID":journal[@"transactionID"]?:@""}];
    if([state isEqual:@"rolledBack"]){
        if([record[@"resolution"] isEqual:@"cancelledBeforeApply"])self.recoveryNotice=CSBackupRestoreError(CSBackupFailure(record[@"resolutionReason"]?:@"上次未应用的恢复计划已撤销，当前配置和原备份已保留。"),@"prepared-expired",CSBackupRestoreState,self.store.root.path);
        return [self.store archiveJournal:error];
    }
    if([state isEqual:@"prepared"]){
        NSDictionary *attempt=journal[@"startupAttempt"];
        if(attempt&&![attempt[@"sessionID"] isEqual:StartupSession()]){
            // Prepared has never written live fields/resources. Rewriting its stale
            // before-image would lose edits or cross an account boundary. Retire it
            // durably without touching live state; applying still uses real rollback.
            NSString *reason=[NSString stringWithFormat:@"上次启动未能应用恢复计划，已自动撤销；当前配置和原备份已保留。原因：%@。请检查后重新准备恢复。",journal[@"startupFailure"]?:@"恢复前检查中断"];
            reason=[reason substringToIndex:MIN(reason.length,(NSUInteger)2048)];
            journal[@"state"]=@"rolledBack";journal[@"resolution"]=@"cancelledBeforeApply";journal[@"resolutionReason"]=reason;
            [self.store recordRestoreStage:@"prepared-expired" status:@"started" error:nil details:@{@"transactionID":journal[@"transactionID"]?:@"",@"liveWrites":@NO}];
            if(![self.store writeJournal:journal error:error]||![self.store archiveJournal:error]){
                [self.store recordRestoreStage:@"prepared-expired" status:@"failed" error:error?*error:nil details:@{@"liveWrites":@NO}];return NO;
            }
            self.recoveryNotice=CSBackupRestoreError(CSBackupFailure(reason),@"prepared-expired",CSBackupRestoreState,self.store.root.path);
            [self.store recordRestoreStage:@"prepared-expired" status:@"cancelled" error:self.recoveryNotice details:@{@"liveWrites":@NO,@"sourceRetained":@YES}];return YES;
        }
        if(!attempt){journal[@"startupAttempt"]=@{@"sessionID":StartupSession(),@"startedAt":NSDate.date};
            if(![self.store writeJournal:journal error:error])return NO;
            [self.store recordRestoreStage:@"startup-attempt" status:@"saved" error:nil details:@{@"sessionID":StartupSession(),@"transactionID":journal[@"transactionID"]?:@""}];
            if(self.checkpoint)self.checkpoint(@"startupAttempt");
        }
    }
    if([state isEqual:@"committed"]&&[self.store activationConfirmed:journal]){
        // A durable handoff occurred before hooks were released. Subsequent edits win.
        return [self.store archiveJournal:error];
    }
    if([state isEqual:@"committed"]){
        NSDictionary *now=self.context();
        if([now[@"account"] isEqual:journal[@"account"]]&&[now[@"installationID"] isEqual:journal[@"installationID"]]&&[self verifyFields:journal[@"after"] writes:journal[@"afterWrites"] error:NULL]){self.appliedContext=now;return YES;}
        // Committed but never handed off: recover the protected before-image.
        state=@"rollingBack";
    }
    BOOL rollback=[@[@"applying",@"rollingBack"] containsObject:state];
    NSDictionary *context=self.context();
    if(!rollback){
        if(![context[@"installationID"] isEqual:journal[@"installationID"]]||![context[@"account"] length]||![context[@"account"] isEqual:journal[@"account"]])return EngineFail(error,@"当前账号未就绪或已变化，恢复保持待处理；可在备份页取消");
        NSDictionary *current=[self capture:@"恢复核验" kind:@"protection" allowingMissingAssets:[journal[@"operation"] isEqual:@"reset"] error:error];if(!current)return NO;
        if(![Revision(current,HasRuntimeFields(journal[@"after"])) isEqual:journal[@"revision"]])return EngineFail(error,@"准备恢复后配置已变化，请取消待恢复计划并重新预览");
        journal[@"state"]=@"applying";if(![self.store writeJournal:journal error:error])return NO;if(self.checkpoint)self.checkpoint(@"applying");
        NSError *applyError=nil;
        if([self writeFields:journal[@"after"] writes:journal[@"afterWrites"] context:context error:&applyError]){
            journal[@"state"]=@"committed";if([context isEqual:self.context()]&&[self.store writeJournal:journal error:&applyError]){if(self.checkpoint)self.checkpoint(@"committed");if([context isEqual:self.context()]){self.appliedContext=context;[self.store recordRestoreStage:@"applied" status:@"committed" error:nil details:@{@"transactionID":journal[@"transactionID"]?:@""}];return YES;}}
        }
        [self.store recordRestoreStage:@"write-back" status:@"failed" error:applyError details:@{}];
        if(error)*error=applyError;rollback=YES;
    }
    if(rollback){journal[@"state"]=@"rollingBack";NSError *rollbackError=nil;
        [self.store recordRestoreStage:@"rollback" status:@"started" error:nil details:@{@"sourceRetained":@YES}];
        [self.store recordRestoreStage:@"failure-cleanup" status:@"rollingBack" error:nil details:@{@"sourceRetained":@YES}];
        if(![self.store writeJournal:journal error:&rollbackError]||![self writeFields:journal[@"before"] writes:journal[@"beforeWrites"] context:nil error:&rollbackError]){[self.store recordRestoreStage:@"failure-cleanup" status:@"failed" error:rollbackError details:@{@"sourceRetained":@YES}];[self.store recordRestoreStage:@"rollback" status:@"failed" error:rollbackError details:@{}];if(error)*error=rollbackError;return NO;}
        journal[@"state"]=@"rolledBack";if(![self.store writeJournal:journal error:&rollbackError]){[self.store recordRestoreStage:@"rollback" status:@"failed" error:rollbackError details:@{}];if(error)*error=rollbackError;return NO;}if(self.checkpoint)self.checkpoint(@"rolledBack");
        [self.store recordRestoreStage:@"failure-cleanup" status:@"rolledBack" error:nil details:@{@"sourceRetained":@YES}];
        [self.store recordRestoreStage:@"rollback" status:@"verified" error:nil details:@{@"sourceRetained":@YES}];
        // Recovery of an interrupted transaction succeeds only after the before-image is verified.
        if([@[@"applying",@"rollingBack"] containsObject:state])return YES;
        return NO;
    }return NO;
}
- (BOOL)rollbackBeforeActivation:(NSError **)error {
    NSError *readError=nil;NSDictionary *record=[self.store journal:&readError];if(readError){if(error)*error=readError;return NO;}if(!record)return YES;
    if(![record[@"state"] isEqual:@"committed"])return [self applyPending:error];
    NSMutableDictionary *journal=[record mutableCopy];journal[@"state"]=@"rollingBack";[journal removeObjectForKey:@"activated"];
    if(![self.store writeJournal:journal error:error])return NO;return [self applyPending:error];
}
- (BOOL)finishStartupContent:(NSError **)error {
    NSError *readError=nil;NSDictionary *record=[self.store journal:&readError];if(readError){if(error)*error=readError;return NO;}if(!record)return YES;
    NSMutableDictionary *journal=[record mutableCopy];
    if([journal[@"state"] isEqual:@"committed"]){
        BOOL valid=[self.appliedContext isEqual:self.context()]&&[self verifyFields:journal[@"after"] writes:journal[@"afterWrites"] error:NULL]&&[self.appliedContext isEqual:self.context()];
        if(valid){if(self.checkpoint)self.checkpoint(@"activationPrepared");valid=[self.appliedContext isEqual:self.context()];}
        if(valid)self.activationRecord=@{@"transactionID":journal[@"transactionID"],@"account":journal[@"account"],@"installationID":journal[@"installationID"]};
        if(!valid){if(![self rollbackBeforeActivation:error])return NO;return EngineFail(error,@"启动期间账号或配置变化，已回滚，请重新打开微信");}
        return YES;
    }
    return [journal[@"state"] isEqual:@"rolledBack"];
}
- (BOOL)confirmStartupContent:(NSError **)error {
    // Called on main under the native account boundary lock while the serial IO queue
    // waits for this handoff. Only the <=4 KiB confirmation is written here; all
    // preference/image work and the large journal have already completed off main.
    if(!self.activationRecord)return YES;
    NSError *publicationError=nil;
    if([self.store confirmActivation:self.activationRecord error:&publicationError])return YES;
    // rename can succeed before parent-directory fsync reports failure. If our exact
    // confirmation is already visible, finish the handoff under the account lock;
    // never leave a readable success marker while releasing that lock to roll back.
    // This guarantees process-interruption recovery, not storage/power-loss durability.
    if([self.store activationConfirmed:self.activationRecord])return YES;
    if(error)*error=publicationError?:CSBackupFailure(@"启动交接标记未保存");
    return NO;
}
- (BOOL)cancelPendingContent:(NSError **)error {
    NSError *readError=nil;NSDictionary *journal=[self.store journal:&readError];if(readError){if(error)*error=readError;return NO;}if(!journal)return YES;
    if([journal[@"state"] isEqual:@"committed"]&&![self.store activationConfirmed:journal]){if(![self rollbackBeforeActivation:error])return NO;return [self.store archiveJournal:error];}
    if(![@[@"prepared",@"committed",@"rolledBack"] containsObject:journal[@"state"]])return EngineFail(error,@"恢复已开始，必须先完成回滚才能取消");
    return [self.store archiveJournal:error];
}
- (NSDictionary *)resetSnapshot:(NSError **)error {
    NSDictionary *snapshot=[self capture:@"重置插件配置" kind:@"manual" allowingMissingAssets:YES error:error];if(!snapshot)return nil;
    NSMutableDictionary *result=[snapshot mutableCopy];NSMutableArray *fields=[NSMutableArray array];for(NSDictionary *f in snapshot[@"fields"])[fields addObject:@{@"domain":f[@"domain"],@"key":f[@"key"],@"present":@NO}];result[@"fields"]=fields;result[@"assets"]=@{};result[@"operation"]=@"reset";result[@"warnings"]=@[];[result removeObjectsForKeys:@[@"integrity",@"resetRawRevision",@"missingAssets"]];return result;
}
@end
