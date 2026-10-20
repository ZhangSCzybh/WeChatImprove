#import "CSBackupEngine.h"
#import "CSBackupRegistry.h"
#import "CSBackupCodec.h"
#import "CSBackupAssets.h"
#import "CSBackupMutation.h"
static NSString *const Profiles=@"com.wechat.enhance.chat_group.account_profiles";
static NSString *const Selection=@"com.wechat.enhance.chat_group.selection.";
static BOOL EngineFail(NSError **error,NSString *message){if(error)*error=CSBackupFailure(message);return NO;}
static NSString *Revision(NSDictionary *snapshot) {
    if(snapshot[@"resetRawRevision"])return [CSBackupCodec digest:@[snapshot[@"fields"],snapshot[@"assets"],snapshot[@"resetRawRevision"],snapshot[@"missingAssets"]?:@[]]];
    return [CSBackupCodec digest:@[snapshot[@"fields"],snapshot[@"assets"]]];
}
static BOOL IsReset(NSDictionary *snapshot) {return [snapshot[@"operation"] isEqual:@"reset"];}
static NSString *Identity(NSDictionary *f){return [NSString stringWithFormat:@"%@/%@",f[@"domain"],f[@"key"]];}
@interface CSBackupEngine ()
@property(nonatomic) NSDictionary<NSString *,NSUserDefaults *> *defaults;
@property(nonatomic) NSDictionary<NSString *,NSString *> *domains;
@property(nonatomic,readwrite) NSDictionary *appliedContext;
@property(nonatomic) NSDictionary *activationRecord;
@end
@implementation CSBackupEngine
- (instancetype)initWithDefaults:(NSDictionary *)defaults domains:(NSDictionary *)domains store:(CSBackupStore *)store resources:(NSURL *)resources {
    if((self=[super init])){_defaults=defaults;_domains=domains;_store=store;_resourceRoot=resources;_context=^{return @{@"account":@"",@"installationID":@"",@"pluginVersion":@""};};}return self;
}
- (NSArray *)rawFields:(NSError **)error {
    if(!self.readPreferencesOnMain||NSThread.isMainThread)return [self readRawFields:error];
    __block NSArray *fields=nil;__block NSError *readError=nil;
    dispatch_sync(dispatch_get_main_queue(),^{fields=[self readRawFields:&readError];});if(readError&&error)*error=readError;return fields;
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
        if(allowMissing){
            snapshot[@"resetRawRevision"]=[CSBackupCodec digest:raw];snapshot[@"missingAssets"]=missing;
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
+ (NSString *)contentDigest:(NSDictionary *)snapshot {
    NSMutableArray *fields=[NSMutableArray array];for(NSDictionary *f in snapshot[@"fields"])if(![f[@"key"] hasPrefix:Selection])[fields addObject:f];
    return [CSBackupCodec digest:@{@"fields":fields,@"assets":snapshot[@"assets"]?:@{}}];
}
- (NSDictionary *)save:(NSString *)name kind:(NSString *)kind error:(NSError **)error {
    NSDictionary *snapshot=[self capture:name kind:kind error:error];if(!snapshot)return nil;
    if([kind isEqual:@"automatic"]){for(NSDictionary *existing in [self.store snapshots:NULL])if([existing[@"kind"] isEqual:@"automatic"]&&[existing[@"source"][@"account"] isEqual:snapshot[@"source"][@"account"]]&&[existing[@"source"][@"installationID"] isEqual:snapshot[@"source"][@"installationID"]]){if([existing[@"contentDigest"] isEqual:[self.class contentDigest:snapshot]])return [self.store snapshot:existing[@"id"] error:error];break;}}
    if(![self.store publish:snapshot error:error])return nil;
    // Retention runs only after successful publication; failures remain visible to caller.
    [self.store prune:NULL];return snapshot;
}
- (NSDictionary *)preview:(NSDictionary *)snapshot modules:(NSSet *)modules accounts:(NSSet *)accounts error:(NSError **)error {
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
    BOOL relationships=[source[@"installationID"] isEqual:context[@"installationID"]]&&[context[@"account"] length]&&[source[@"account"] isEqual:context[@"account"]];
    for(NSDictionary *field in snapshot[@"fields"]) {
        NSDictionary *entry=[CSBackupRegistry entryForDomain:field[@"domain"] key:field[@"key"]];if(![modules containsObject:entry[@"module"]])continue;
        if([entry[@"scope"] isEqual:@"relationship"]&&!relationships){[warnings addObject:@"已跳过联系人/群关系配置：仅允许同一本机来源及同一当前账号恢复。"];continue;}
        NSMutableDictionary *f=[field mutableCopy];NSString *key=f[@"key"];
        if([key isEqual:Profiles]) {
            if(!accounts.count)continue;
            NSDictionary *old=byID[Identity(f)][@"value"]?:@{};NSMutableDictionary *merged=[old mutableCopy];NSDictionary *incoming=f[@"value"]?:@{};
            for(NSString *account in accounts){if(incoming[account])merged[account]=incoming[account];else if(![f[@"present"] boolValue]&&old[account]&&([source[@"accounts"] containsObject:account]||[source[@"account"] isEqual:account]))[merged removeObjectForKey:account];}
            if(merged.count){f[@"present"]=@YES;f[@"value"]=merged;}else{f[@"present"]=@NO;[f removeObjectForKey:@"value"];}
        }else if([key hasPrefix:Selection]&&![accounts containsObject:[key substringFromIndex:Selection.length]])continue;
        [selected addObject:f];NSDictionary *before=byID[Identity(f)]?:@{@"domain":f[@"domain"],@"key":key,@"present":@NO};
        if(![before isEqual:f])[changes addObject:@{@"module":entry[@"module"],@"key":key,@"before":before,@"after":f,@"reset":([f[@"present"] boolValue]?@NO:@YES)}];
    }
    if(!selected.count){EngineFail(error,@"没有可恢复的配置，请选择模块和账号");return nil;}
    NSMutableDictionary *writes=[NSMutableDictionary dictionary];NSArray *desired=[CSBackupAssets materializeFields:selected assets:snapshot[@"assets"] root:self.resourceRoot writes:writes error:error];if(!desired)return nil;
    return @{@"snapshot":snapshot,@"fields":desired,@"writes":writes,@"changes":changes,@"warnings":[NSOrderedSet orderedSetWithArray:warnings].array,@"revision":Revision(current),@"context":context,@"modules":modules.allObjects,@"accounts":accounts.allObjects};
}
- (NSArray *)beforeFields:(NSArray *)fields error:(NSError **)error {
    NSArray *raw=[self rawFields:error];if(!raw)return nil;NSMutableDictionary *byID=[NSMutableDictionary dictionary];for(NSDictionary *f in raw)byID[Identity(f)]=f;
    NSMutableArray *result=[NSMutableArray array];for(NSDictionary *f in fields)[result addObject:byID[Identity(f)]?:@{@"domain":f[@"domain"],@"key":f[@"key"],@"present":@NO}];return result;
}
- (NSDictionary *)beforeWrites:(NSDictionary *)writes error:(NSError **)error {
    NSUInteger total=0;NSMutableDictionary *blobs=[NSMutableDictionary dictionary];NSMutableDictionary *result=[NSMutableDictionary dictionary];for(NSString *name in writes){NSURL *url=[self.resourceRoot URLByAppendingPathComponent:name];
        if([NSFileManager.defaultManager fileExistsAtPath:url.path]){NSData *data=CSBackupReadFile(url,4*1024*1024,error);if(!data)return nil;NSString *hash=[CSBackupCodec digest:data];if(blobs[hash])data=blobs[hash];else{blobs[hash]=data;total+=data.length;}if(total>48*1024*1024){EngineFail(error,@"恢复前图片保护数据超过 48 MiB，未创建待恢复计划");return nil;}result[name]=@{@"present":@YES,@"data":data};}else result[name]=@{@"present":@NO};}
    return result;
}
- (BOOL)prepare:(NSDictionary *)preview error:(NSError **)error {
    NSError *existingError=nil;NSDictionary *existing=[self.store journal:&existingError];if(existingError){if(error)*error=existingError;return NO;}
    if(existing){if([existing[@"state"] isEqual:@"rolledBack"]||([existing[@"state"] isEqual:@"committed"]&&[self.store activationConfirmed:existing])){if(![self.store archiveJournal:error])return NO;}else return EngineFail(error,@"已有待处理的恢复，请先取消或完成它");}
    if(![self.context()[@"account"] length])return EngineFail(error,@"当前账号尚未就绪，请登录后重新预览恢复");
    BOOL reset=IsReset(preview[@"snapshot"]);
    NSDictionary *current=[self capture:reset?@"重置前保护":@"恢复前保护" kind:@"protection" allowingMissingAssets:reset error:error];if(!current)return NO;
    if(![preview[@"context"] isEqual:self.context()]||![preview[@"revision"] isEqual:Revision(current)])return EngineFail(error,@"配置或账号已变化，请重新打开恢复预览");
    NSDictionary *rebuilt=[self preview:preview[@"snapshot"] modules:[NSSet setWithArray:preview[@"modules"]?:@[]] accounts:[NSSet setWithArray:preview[@"accounts"]?:@[]] error:error];
    if(!rebuilt)return NO;
    if(![rebuilt[@"fields"] isEqual:preview[@"fields"]]||![rebuilt[@"writes"] isEqual:preview[@"writes"]]||![rebuilt[@"revision"] isEqual:preview[@"revision"]])return EngineFail(error,@"恢复计划已变化，请重新预览");
    if(![self.store publish:current error:error])return NO;
    NSArray *before=[self beforeFields:preview[@"fields"] error:error];NSDictionary *beforeWrites=[self beforeWrites:preview[@"writes"] error:error];if(!before||!beforeWrites)return NO;
    NSDictionary *journal=@{@"operation":reset?@"reset":@"restore",@"version":@1,@"transactionID":NSUUID.UUID.UUIDString,@"state":@"prepared",@"sourceID":preview[@"snapshot"][@"id"],@"protectionID":current[@"id"],@"account":preview[@"context"][@"account"],@"installationID":preview[@"context"][@"installationID"],@"revision":preview[@"revision"],@"before":before,@"after":preview[@"fields"],@"beforeWrites":beforeWrites,@"afterWrites":preview[@"writes"]};
    if(![self validJournal:journal error:error])return NO;
    BOOL ok=[self.store writeJournal:journal error:error];if(ok&&self.checkpoint)self.checkpoint(@"prepared");return ok;
}
- (BOOL)validJournal:(NSDictionary *)journal error:(NSError **)error {
    if(![journal[@"version"] isEqual:@1]||![@[@"prepared",@"applying",@"rollingBack",@"rolledBack",@"committed"] containsObject:journal[@"state"]])return EngineFail(error,@"恢复日志版本或状态无效");
    for(NSString *part in @[@"before",@"after"]){NSArray *fields=journal[part];if(![fields isKindOfClass:NSArray.class]||fields.count>4096)return EngineFail(error,@"恢复日志配置列表无效");
        NSMutableSet *seen=[NSMutableSet set];for(NSDictionary *f in fields){if(![f isKindOfClass:NSDictionary.class])return EngineFail(error,@"恢复字段损坏");NSDictionary *entry=[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]];if(!entry||![f[@"present"] isKindOfClass:NSNumber.class]||[seen containsObject:Identity(f)])return EngineFail(error,@"恢复日志包含未登记或重复的配置");[seen addObject:Identity(f)];if([f[@"present"] boolValue]&&![CSBackupRegistry validateValue:f[@"value"] entry:entry error:error])return NO;}
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
        if([r[@"present"] boolValue]){if(!CSBackupAtomicWrite(r[@"data"],url,error))return NO;}
        else if([NSFileManager.defaultManager fileExistsAtPath:url.path]&&![NSFileManager.defaultManager removeItemAtURL:url error:error])return NO;
        if(self.checkpoint)self.checkpoint(@"resource");
    }
    for(NSDictionary *f in fields){if(context&&![context isEqual:self.context()])return EngineFail(error,@"恢复期间账号发生变化");NSUserDefaults *defaults=self.defaults[f[@"domain"]];
        if([f[@"present"] boolValue])[defaults setObject:f[@"value"] forKey:f[@"key"]];else [defaults removeObjectForKey:f[@"key"]];if(self.checkpoint)self.checkpoint(@"field");}
    for(NSUserDefaults *defaults in self.defaults.allValues)if(![defaults synchronize])return EngineFail(error,@"偏好持久化失败");
    if(self.checkpoint)self.checkpoint(@"synchronized");
    if(context&&![context isEqual:self.context()])return EngineFail(error,@"恢复期间账号发生变化");
    BOOL verified=[self verifyFields:fields writes:writes error:error];
    if(context&&![context isEqual:self.context()])return EngineFail(error,@"核验期间账号发生变化");return verified;
}
- (BOOL)verifyFields:(NSArray *)fields writes:(NSDictionary *)writes error:(NSError **)error {
    NSArray *current=[self beforeFields:fields error:error];if(![current isEqual:fields])return EngineFail(error,@"恢复配置回读校验失败");
    NSDictionary *resources=[self beforeWrites:writes error:error];if(![resources isEqual:writes])return EngineFail(error,@"恢复图片回读校验失败");return YES;
}
- (BOOL)applyPending:(NSError **)error {
    self.appliedContext=nil;self.activationRecord=nil;
    NSError *readError=nil;NSDictionary *record=[self.store journal:&readError];if(readError){if(error)*error=readError;return NO;}if(!record)return YES;
    if(![self validJournal:record error:error])return NO;
    NSMutableDictionary *journal=[record mutableCopy];NSString *state=journal[@"state"];
    if([state isEqual:@"rolledBack"])return [self.store archiveJournal:error];
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
        if(![Revision(current) isEqual:journal[@"revision"]])return EngineFail(error,@"准备恢复后配置已变化，请取消待恢复计划并重新预览");
        journal[@"state"]=@"applying";if(![self.store writeJournal:journal error:error])return NO;if(self.checkpoint)self.checkpoint(@"applying");
        NSError *applyError=nil;
        if([self writeFields:journal[@"after"] writes:journal[@"afterWrites"] context:context error:&applyError]){
            journal[@"state"]=@"committed";if([context isEqual:self.context()]&&[self.store writeJournal:journal error:&applyError]){if(self.checkpoint)self.checkpoint(@"committed");if([context isEqual:self.context()]){self.appliedContext=context;return YES;}}
        }
        if(error)*error=applyError;rollback=YES;
    }
    if(rollback){journal[@"state"]=@"rollingBack";NSError *rollbackError=nil;
        if(![self.store writeJournal:journal error:&rollbackError]||![self writeFields:journal[@"before"] writes:journal[@"beforeWrites"] context:nil error:&rollbackError]){if(error)*error=rollbackError;return NO;}
        journal[@"state"]=@"rolledBack";if(![self.store writeJournal:journal error:&rollbackError]){if(error)*error=rollbackError;return NO;}if(self.checkpoint)self.checkpoint(@"rolledBack");
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
- (BOOL)finishStartup:(NSError **)error {
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
- (BOOL)confirmStartup:(NSError **)error {
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
- (BOOL)cancelPending:(NSError **)error {
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
