#import "CSBackupStore.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
#import <TargetConditionals.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <math.h>
static const NSUInteger MetadataLimit=16384;
static BOOL ValidMetadata(id object) {
    if(![object isKindOfClass:NSDictionary.class])return NO;
    NSDictionary *metadata=object;
    for(id key in metadata)if(![@[@"favorite",@"name",@"importedAt"] containsObject:key])return NO;
    id favorite=metadata[@"favorite"],name=metadata[@"name"],imported=metadata[@"importedAt"];
    return (!favorite||([favorite isKindOfClass:NSNumber.class]&&CFGetTypeID((__bridge CFTypeRef)favorite)==CFBooleanGetTypeID()))&&
        (!name||([name isKindOfClass:NSString.class]&&[name length]>0&&[name length]<=128))&&
        (!imported||([imported isKindOfClass:NSDate.class]&&isfinite([imported timeIntervalSince1970])));
}
@interface CSBackupStore ()
@property(nonatomic,copy,readwrite) NSString *cleanupStatus;
@end
static BOOL StoreFail(NSError **error, NSString *message) { if(error)*error=CSBackupFailure(message);return NO; }
static BOOL Directory(NSURL *url,NSError **error) {
    if(![NSFileManager.defaultManager createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:error])return NO;
    struct stat st;
    if(lstat(url.path.fileSystemRepresentation,&st)||!S_ISDIR(st.st_mode))return StoreFail(error,@"备份目录无效或为符号链接");
    return YES;
}
NSData *CSBackupReadFile(NSURL *url,NSUInteger limit,NSError **error) {
    int fd=open(url.path.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW);
    if(fd<0){StoreFail(error,@"无法读取备份文件");return nil;}
    struct stat st; if(fstat(fd,&st)||!S_ISREG(st.st_mode)||st.st_size<0||(uint64_t)st.st_size>limit) {close(fd);StoreFail(error,@"文件无效或超过大小限制");return nil;}
    NSMutableData *data=[NSMutableData dataWithLength:(NSUInteger)st.st_size];NSUInteger offset=0;
    while(offset<data.length) {ssize_t n=read(fd,(uint8_t *)data.mutableBytes+offset,data.length-offset);if(n<0&&errno==EINTR)continue;if(n<=0)break;offset+=(NSUInteger)n;}
    close(fd);if(offset!=data.length){StoreFail(error,@"文件读取不完整");return nil;}return data;
}
BOOL CSBackupAtomicWrite(NSData *data,NSURL *url,NSError **error) {
    if(!data)return StoreFail(error,@"没有可写入的数据");
    NSURL *parent=[url URLByDeletingLastPathComponent];if(!Directory(parent,error))return NO;
    NSURL *temp=[parent URLByAppendingPathComponent:[@".pending-" stringByAppendingString:NSUUID.UUID.UUIDString]];
    int fd=open(temp.path.fileSystemRepresentation,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);
    if(fd<0)return StoreFail(error,@"无法创建临时文件，可能没有可用空间");
    NSUInteger offset=0;BOOL ok=YES;
    while(offset<data.length){ssize_t n=write(fd,(const uint8_t *)data.bytes+offset,data.length-offset);if(n<0&&errno==EINTR)continue;if(n<=0){ok=NO;break;}offset+=(NSUInteger)n;}
    if(ok&&fsync(fd))ok=NO;if(close(fd))ok=NO;
#if TARGET_OS_IPHONE
    if(ok)ok=[NSFileManager.defaultManager setAttributes:@{NSFileProtectionKey:NSFileProtectionCompleteUntilFirstUserAuthentication} ofItemAtPath:temp.path error:error];
#endif
    if(ok&&rename(temp.path.fileSystemRepresentation,url.path.fileSystemRepresentation))ok=NO;
    if(ok){int dirfd=open(parent.path.fileSystemRepresentation,O_RDONLY);if(dirfd<0)ok=NO;else{if(fsync(dirfd))ok=NO;close(dirfd);}}
    if(!ok){unlink(temp.path.fileSystemRepresentation);return StoreFail(error,@"文件未完整提交，请检查存储空间后重试");}return YES;
}
@implementation CSBackupStore
- (instancetype)initWithRoot:(NSURL *)root {
    if((self=[super init])){
        _root=root;_cleanupStatus=@"";
        NSData *data=CSBackupReadFile([root URLByAppendingPathComponent:@"cleanup.plist"],256*1024,NULL);
        id report=data?[NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL]:nil;
        if([report isKindOfClass:NSDictionary.class]&&[report[@"summary"] isKindOfClass:NSString.class])_cleanupStatus=report[@"summary"];
    }return self;
}
- (NSURL *)URLForID:(NSString *)identifier extension:(NSString *)extension {
    if(![identifier isKindOfClass:NSString.class]||![[NSUUID alloc]initWithUUIDString:identifier])return nil;
    return [self.root URLByAppendingPathComponent:[identifier stringByAppendingPathExtension:extension]];
}
- (BOOL)publish:(NSDictionary *)snapshot error:(NSError **)error {
    return [self publish:snapshot imported:NO error:error];
}
- (BOOL)importSnapshot:(NSDictionary *)snapshot error:(NSError **)error {
    return [self publish:snapshot imported:YES error:error];
}
- (BOOL)publish:(NSDictionary *)snapshot imported:(BOOL)imported error:(NSError **)error {
    NSURL *url=[self URLForID:snapshot[@"id"] extension:@"wcbak"];if(!url)return StoreFail(error,@"备份标识无效");
    NSData *encoded=[CSBackupCodec encode:snapshot error:error];if(!encoded||![CSBackupCodec decode:encoded error:error])return NO;
    struct stat st;
    if(lstat(url.path.fileSystemRepresentation,&st)==0) {
        NSDictionary *existing=[self snapshot:snapshot[@"id"] error:error];
        if(existing&&[existing[@"integrity"] isEqual:[CSBackupCodec decode:encoded error:error][@"integrity"]]){
            if(!imported)return YES;
            NSError *metadataError=nil;NSMutableDictionary *metadata=[[self metadata:snapshot[@"id"] error:&metadataError] mutableCopy];
            if(metadataError)metadata[@"favorite"]=@YES;
            metadata[@"importedAt"]=NSDate.date;
            return [self setMetadata:metadata identifier:snapshot[@"id"] error:error];
        }
        return StoreFail(error,@"同一备份标识已有不同内容，原备份已保留");
    }
    if(errno!=ENOENT)return StoreFail(error,@"无法检查原备份，未覆盖任何文件");
    // Establish explicit protection state before making a new snapshot visible.
    // Existing v2 metadata is preserved; missing state on already-published files is unknown.
    NSURL *primary=[self URLForID:snapshot[@"id"] extension:@"meta"],*mirror=[self URLForID:snapshot[@"id"] extension:@"meta.bak"];
    struct stat primaryStat,mirrorStat;
    BOOL primaryMissing=lstat(primary.path.fileSystemRepresentation,&primaryStat)!=0&&errno==ENOENT;
    BOOL mirrorMissing=lstat(mirror.path.fileSystemRepresentation,&mirrorStat)!=0&&errno==ENOENT;
    NSMutableDictionary *initial=[@{@"favorite":@NO} mutableCopy];
    if(!primaryMissing||!mirrorMissing){
        NSError *metadataError=nil;initial=[[self metadata:snapshot[@"id"] error:&metadataError] mutableCopy];
        if(metadataError)initial[@"favorite"]=@YES;
    }
    if(imported)initial[@"importedAt"]=NSDate.date;
    if(![self setMetadata:initial identifier:snapshot[@"id"] error:error])return NO;
    return CSBackupAtomicWrite(encoded,url,error);
}
- (NSDictionary *)snapshot:(NSString *)identifier error:(NSError **)error {
    NSURL *url=[self URLForID:identifier extension:@"wcbak"];if(!url){StoreFail(error,@"备份标识无效");return nil;}
    NSData *data=CSBackupReadFile(url,CSBackupMaximumFileSize,error);if(!data)return nil;
    NSDictionary *s=[CSBackupCodec decode:data error:error];if(s&&![s[@"id"] isEqual:identifier]){StoreFail(error,@"文件名与备份标识不一致");return nil;}return s;
}
- (NSArray *)records:(NSError **)error {
    if(!Directory(self.root,error))return @[];
    NSArray *urls=[NSFileManager.defaultManager contentsOfDirectoryAtURL:self.root includingPropertiesForKeys:nil options:0 error:error];
    NSMutableArray *items=[NSMutableArray array];
    for(NSURL *url in urls)if([url.pathExtension isEqual:@"wcbak"]) {
        NSError *readError=nil;NSString *identifier=url.lastPathComponent.stringByDeletingPathExtension;
        NSDictionary *attributes=[NSFileManager.defaultManager attributesOfItemAtPath:url.path error:NULL];
        NSDictionary *s=[self snapshot:identifier error:&readError];if(s){
            NSMutableArray *stable=[NSMutableArray array];NSMutableSet *modules=[NSMutableSet set],*accounts=[NSMutableSet set];
            for(NSDictionary *f in s[@"fields"]){if(![f[@"key"] hasPrefix:@"com.wechat.enhance.chat_group.selection."])[stable addObject:f];[modules addObject:[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]][@"module"]];if([f[@"key"] isEqual:@"com.wechat.enhance.chat_group.account_profiles"]&&[f[@"value"] isKindOfClass:NSDictionary.class])[accounts addObjectsFromArray:[f[@"value"] allKeys]];}
            [items addObject:@{@"id":s[@"id"],@"filename":url.lastPathComponent,@"name":s[@"name"],@"createdAt":s[@"createdAt"],@"kind":s[@"kind"],@"source":s[@"source"],@"warnings":s[@"warnings"],@"fieldCount":@([s[@"fields"] count]),@"assetCount":@([s[@"assets"] count]),@"modules":modules.allObjects,@"accounts":accounts.allObjects,@"size":attributes[NSFileSize]?:@0,@"contentDigest":[CSBackupCodec digest:@{@"fields":stable,@"assets":s[@"assets"]}]}];
        }else [items addObject:@{@"id":identifier,@"filename":url.lastPathComponent,@"name":[@"无法读取的备份 · " stringByAppendingString:identifier],@"unavailable":@YES,@"issue":readError.localizedDescription?:@"文件校验未通过，原件已保留",@"size":attributes[NSFileSize]?:@0}];
    }
    [items sortUsingComparator:^NSComparisonResult(NSDictionary *a,NSDictionary *b){
        if(a[@"createdAt"]&&b[@"createdAt"])return [b[@"createdAt"] compare:a[@"createdAt"]];
        if(a[@"createdAt"])return NSOrderedAscending;if(b[@"createdAt"])return NSOrderedDescending;
        return [a[@"filename"] compare:b[@"filename"]];
    }];return items;
}
- (NSArray *)snapshots:(NSError **)error {
    NSMutableArray *valid=[NSMutableArray array];NSUInteger unavailable=0;
    for(NSDictionary *record in [self records:error]){if([record[@"unavailable"] boolValue])unavailable++;else [valid addObject:record];}
    if(unavailable)StoreFail(error,[NSString stringWithFormat:@"%lu 份备份无法读取，原件已保留，可在备份列表中查看",(unsigned long)unavailable]);
    return valid;
}
- (NSData *)originalData:(NSString *)filename error:(NSError **)error {
    if(![filename isKindOfClass:NSString.class]||![filename isEqual:filename.lastPathComponent]||[filename containsString:@"/"]||![filename.pathExtension isEqual:@"wcbak"]){StoreFail(error,@"备份文件名无效");return nil;}
    return CSBackupReadFile([self.root URLByAppendingPathComponent:filename],CSBackupMaximumFileSize,error);
}
- (BOOL)remove:(NSString *)identifier error:(NSError **)error {
    NSURL *url=[self URLForID:identifier extension:@"wcbak"];if(!url)return StoreFail(error,@"备份标识无效");
    NSError *journalError=nil;NSDictionary *journal=[self journal:&journalError];if(journalError){if(error)*error=journalError;return NO;}
    if([journal[@"protectionID"] isEqual:identifier]||[journal[@"sourceID"] isEqual:identifier])return StoreFail(error,@"恢复事务正在使用此备份，暂时不能删除");
    if(![NSFileManager.defaultManager removeItemAtURL:url error:error])return NO;
    for(NSString *extension in @[@"meta",@"meta.bak"]){
        NSURL *metadataURL=[self URLForID:identifier extension:extension];struct stat st;
        if(lstat(metadataURL.path.fileSystemRepresentation,&st)==0&&S_ISREG(st.st_mode))unlink(metadataURL.path.fileSystemRepresentation);
    }return YES;
}
- (NSDictionary *)metadata:(NSString *)identifier {return [self metadata:identifier error:NULL];}
- (NSDictionary *)readMetadata:(NSURL *)url identifier:(NSString *)identifier {
    NSData *data=CSBackupReadFile(url,MetadataLimit,NULL);
    id value=data?[NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL]:nil;
    if(![value isKindOfClass:NSDictionary.class])return nil;
    if(value[@"schema"]){
        NSMutableDictionary *bare=[value mutableCopy];id integrity=bare[@"integrity"];[bare removeObjectForKey:@"integrity"];
        if([bare count]!=3||![bare[@"schema"] isEqual:@1]||![bare[@"identifier"] isEqual:identifier]||![[CSBackupCodec digest:bare] isEqual:integrity])return nil;
        value=bare[@"metadata"];
    }
    // Existing v2 local metadata remains readable; this does not import legacy backups.
    return ValidMetadata(value)?value:nil;
}
- (NSDictionary *)metadata:(NSString *)identifier error:(NSError **)error {
    NSURL *primary=[self URLForID:identifier extension:@"meta"],*mirror=[self URLForID:identifier extension:@"meta.bak"];
    if(!primary){StoreFail(error,@"备份标识无效，保护状态未确认");return @{};}
    NSDictionary *a=[self readMetadata:primary identifier:identifier],*b=[self readMetadata:mirror identifier:identifier];
    NSMutableDictionary *result=[(a?:b?:@{}) mutableCopy];
    // Conservative union protects collection/import across interrupted two-file updates.
    if([a[@"favorite"] boolValue]||[b[@"favorite"] boolValue])result[@"favorite"]=@YES;
    if(!result[@"importedAt"]&&(a[@"importedAt"]||b[@"importedAt"]))result[@"importedAt"]=a[@"importedAt"]?:b[@"importedAt"];
    if(!a||!b||![a isEqual:b])StoreFail(error,@"备份保护记录缺失、损坏或不一致，已保留且不自动清理。请重新确认收藏状态。");
    return result;
}
- (BOOL)setMetadata:(NSDictionary *)metadata identifier:(NSString *)identifier error:(NSError **)error {
    NSURL *url=[self URLForID:identifier extension:@"meta"],*mirror=[self URLForID:identifier extension:@"meta.bak"];if(!url)return StoreFail(error,@"备份标识无效");
    if(!ValidMetadata(metadata))return StoreFail(error,@"备份保护信息无效，未覆盖原记录");
    NSMutableDictionary *normalized=[metadata mutableCopy];if(!normalized[@"favorite"])normalized[@"favorite"]=@NO;
    NSMutableDictionary *envelope=[@{@"schema":@1,@"identifier":identifier,@"metadata":normalized} mutableCopy];envelope[@"integrity"]=[CSBackupCodec digest:envelope];
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:envelope format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
    if(!data||data.length>MetadataLimit)return StoreFail(error,@"备份保护记录超过大小限制，原记录已保留");
    return CSBackupAtomicWrite(data,url,error)&&CSBackupAtomicWrite(data,mirror,error);
}
- (BOOL)writeJournal:(NSDictionary *)journal error:(NSError **)error {
    NSMutableDictionary *sealed=[journal mutableCopy];[sealed removeObjectForKey:@"integrity"];sealed[@"integrity"]=[CSBackupCodec digest:sealed];
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:sealed format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];if(data.length>80*1024*1024)return StoreFail(error,@"恢复日志超过 80 MiB，未发布待恢复计划");return data&&CSBackupAtomicWrite(data,[self.root URLByAppendingPathComponent:@"transaction.plist"],error);
}
- (NSDictionary *)journal:(NSError **)error {
    NSURL *url=[self.root URLByAppendingPathComponent:@"transaction.plist"];
    struct stat metadata;if(lstat(url.path.fileSystemRepresentation,&metadata)){if(errno==ENOENT)return nil;StoreFail(error,@"无法检查恢复日志，启动保持等待");return nil;}
    if(!S_ISREG(metadata.st_mode)){StoreFail(error,@"恢复日志不是普通文件，启动保持等待");return nil;}
    NSData *data=CSBackupReadFile(url,80*1024*1024,error);if(!data)return nil;
    id value=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
    if(![value isKindOfClass:NSDictionary.class]){StoreFail(error,@"恢复日志损坏，配置未继续修改");return nil;}
    NSMutableDictionary *bare=[value mutableCopy];id hash=bare[@"integrity"];[bare removeObjectForKey:@"integrity"];
    if(![[CSBackupCodec digest:bare] isEqual:hash]){StoreFail(error,@"恢复日志校验失败，配置未继续修改");return nil;}return value;
}
- (BOOL)confirmActivation:(NSDictionary *)record error:(NSError **)error {
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:record format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
    if(!data||data.length>4096)return StoreFail(error,@"启动交接标记无效");
    return CSBackupAtomicWrite(data,[self.root URLByAppendingPathComponent:@"activation.plist"],error);
}
- (BOOL)activationConfirmed:(NSDictionary *)journal {
    NSData *data=CSBackupReadFile([self.root URLByAppendingPathComponent:@"activation.plist"],4096,NULL);if(!data)return NO;
    id record=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
    return [record isKindOfClass:NSDictionary.class]&&[record[@"transactionID"] isEqual:journal[@"transactionID"]]&&[record[@"account"] isEqual:journal[@"account"]]&&[record[@"installationID"] isEqual:journal[@"installationID"]];
}
- (BOOL)archiveJournal:(NSError **)error {
    NSURL *source=[self.root URLByAppendingPathComponent:@"transaction.plist"];NSData *data=CSBackupReadFile(source,80*1024*1024,error);if(!data)return NO;
    if(!CSBackupAtomicWrite(data,[self.root URLByAppendingPathComponent:@"last-transaction.plist"],error))return NO;
    return [NSFileManager.defaultManager removeItemAtURL:source error:error];
}
- (BOOL)writeCleanup:(NSMutableDictionary *)report error:(NSError **)error {
    NSUInteger deleted=0,retained=0,failed=0,pending=0;
    for(NSDictionary *event in report[@"events"]){
        NSString *action=event[@"action"];
        if([action isEqual:@"deleted"])deleted++;else if([action isEqual:@"retained"])retained++;else if([action isEqual:@"failed"])failed++;else pending++;
    }
    report[@"summary"]=[NSString stringWithFormat:@"最近历史清理：删除 %lu 份，保护保留 %lu 份，失败 %lu 份，待处理 %lu 份%@",(unsigned long)deleted,(unsigned long)retained,(unsigned long)failed,(unsigned long)pending,report[@"issue"]?[@"。" stringByAppendingString:report[@"issue"]]:@""];
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:report format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
    if(!data||data.length>256*1024||!CSBackupAtomicWrite(data,[self.root URLByAppendingPathComponent:@"cleanup.plist"],error)){
        self.cleanupStatus=@"历史清理记录写入失败，已停止后续清理；新建备份单独保留。";return NO;
    }
    self.cleanupStatus=report[@"summary"];return YES;
}
- (BOOL)prune:(NSError **)error {
    NSError *listError=nil;NSArray *snapshots=[self records:&listError];
    NSDictionary *journal=listError?nil:[self journal:&listError];
    NSMutableArray *events=[NSMutableArray array];NSMutableDictionary *report=[@{@"date":NSDate.date,@"events":events} mutableCopy];
    if(listError){report[@"issue"]=listError.localizedDescription;[self writeCleanup:report error:NULL];if(error)*error=listError;return NO;}
    NSMutableDictionary *counts=[NSMutableDictionary dictionary];NSError *protectionError=nil;
    for(NSDictionary *s in snapshots){
        if([s[@"unavailable"] boolValue]){
            protectionError=CSBackupFailure(s[@"issue"]);
            if(events.count<100)[events addObject:[@{@"id":s[@"id"],@"kind":@"unavailable",@"action":@"retained",@"reason":s[@"issue"]} mutableCopy]];
            continue;
        }
        NSString *kind=s[@"kind"];NSUInteger quota=[kind isEqual:@"automatic"]?20:([@[@"protection",@"upgrade"] containsObject:kind]?5:0);
        if(!quota)continue;
        NSError *metadataError=nil;NSDictionary *metadata=[self metadata:s[@"id"] error:&metadataError];
        if(metadataError){
            protectionError=metadataError;
            if(events.count<100)[events addObject:[@{@"id":s[@"id"],@"kind":kind,@"action":@"retained",@"reason":metadataError.localizedDescription} mutableCopy]];
            continue;
        }
        if([metadata[@"favorite"] boolValue]||metadata[@"importedAt"])continue;
        NSString *bucket=[kind isEqual:@"upgrade"]?@"protection":kind;
        NSUInteger n=[counts[bucket] unsignedIntegerValue]+1;counts[bucket]=@(n);
        if(n<=quota||events.count>=100)continue;
        BOOL active=[journal[@"sourceID"] isEqual:s[@"id"]]||[journal[@"protectionID"] isEqual:s[@"id"]];
        [events addObject:[@{@"id":s[@"id"],@"kind":kind,@"action":active?@"retained":@"planned",@"reason":active?@"恢复事务正在使用":@"超过保留数量，已确认未收藏且非导入备份",@"metadataVerified":@YES} mutableCopy]];
    }
    if(!events.count&&!protectionError)return YES;
    if(protectionError)report[@"issue"]=protectionError.localizedDescription;
    // Persist the exact candidate IDs before deleting anything. An interrupted pass remains auditable.
    if(![self writeCleanup:report error:error])return NO;
    NSError *deletionError=nil;
    for(NSMutableDictionary *event in events){
        if(![event[@"action"] isEqual:@"planned"])continue;
        NSError *currentError=nil;NSDictionary *metadata=[self metadata:event[@"id"] error:&currentError];
        if(currentError||[metadata[@"favorite"] boolValue]||metadata[@"importedAt"]){
            event[@"action"]=@"retained";event[@"reason"]=currentError.localizedDescription?:@"备份保护状态已变化";
        }else if([self remove:event[@"id"] error:&currentError])event[@"action"]=@"deleted";
        else {event[@"action"]=@"failed";event[@"reason"]=currentError.localizedDescription?:@"文件删除失败";deletionError=currentError?:CSBackupFailure(event[@"reason"]);}
        if(![self writeCleanup:report error:error])return NO;
    }
    if(deletionError||protectionError){if(error)*error=deletionError?:protectionError;return NO;}
    return YES;
}
@end
