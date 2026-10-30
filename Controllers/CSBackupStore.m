#import "CSBackupStore.h"
#import "CSPluginStorage.h"
#import "CSBackupRestoreDiagnostics.h"
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
@property(nonatomic) CSPluginDirectoryMigration *migration;
@end
static BOOL StoreFail(NSError **error, NSString *message) { if(error)*error=CSBackupFailure(message);return NO; }
static NSDictionary *FileIdentityAtPath(NSString *path,const struct stat *st) {
    // Foundation enumeration may expand system aliases (/var -> /private/var).
    // Resolve only the parent; a leaf symlink remains its own identity.
    NSString *canonical=[path.stringByDeletingLastPathComponent.stringByResolvingSymlinksInPath stringByAppendingPathComponent:path.lastPathComponent];
    return @{@"path":canonical,@"device":@((uint64_t)st->st_dev),@"inode":@((uint64_t)st->st_ino),
        @"mode":@(st->st_mode),@"size":@(st->st_size),@"modified":@(st->st_mtimespec.tv_sec),
        @"modifiedNS":@(st->st_mtimespec.tv_nsec),@"changed":@(st->st_ctimespec.tv_sec),@"changedNS":@(st->st_ctimespec.tv_nsec)};
}
static NSDictionary *FileIdentity(NSURL *url) {
    struct stat st;if(lstat(url.fileSystemRepresentation,&st))return nil;
    return FileIdentityAtPath(url.path,&st);
}
static BOOL Directory(NSURL *url,NSError **error) {
    if(![NSFileManager.defaultManager createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:error])return NO;
    struct stat st;
    if(lstat(url.path.fileSystemRepresentation,&st)){if(error)*error=CSBackupFileError(url.path,@"inspect-directory",errno);return NO;}
    if(!S_ISDIR(st.st_mode))return StoreFail(error,@"备份目录无效或为符号链接");
    return YES;
}
NSData *CSBackupReadFile(NSURL *url,NSUInteger limit,NSError **error) {
    int fd=open(url.path.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW);
    if(fd<0){if(error)*error=CSBackupFileError(url.path,@"open-read",errno);return nil;}
    struct stat st;
    if(fstat(fd,&st)){int saved=errno;close(fd);if(error)*error=CSBackupFileError(url.path,@"stat-read",saved);return nil;}
    if(!S_ISREG(st.st_mode)||st.st_size<0||(uint64_t)st.st_size>limit){close(fd);StoreFail(error,@"文件无效或超过大小限制");return nil;}
    NSMutableData *data=[NSMutableData dataWithLength:(NSUInteger)st.st_size];NSUInteger offset=0;int failure=0;
    while(offset<data.length){ssize_t n=read(fd,(uint8_t *)data.mutableBytes+offset,data.length-offset);if(n<0&&errno==EINTR)continue;if(n<=0){failure=n<0?errno:EIO;break;}offset+=(NSUInteger)n;}
    close(fd);if(failure){if(error)*error=CSBackupFileError(url.path,@"read",failure);return nil;}return data;
}
BOOL CSBackupAtomicWrite(NSData *data,NSURL *url,NSError **error) {
    if(!data)return StoreFail(error,@"没有可写入的数据");
    NSURL *parent=url.URLByDeletingLastPathComponent;if(!Directory(parent,error))return NO;
    NSURL *temp=[parent URLByAppendingPathComponent:[@".pending-" stringByAppendingString:NSUUID.UUID.UUIDString]];
    int fd=open(temp.fileSystemRepresentation,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);
    if(fd<0){if(error)*error=CSBackupFileError(url.path,@"create-temp",errno);return NO;}
    NSUInteger offset=0;NSError *failure=nil;
    while(offset<data.length){ssize_t n=write(fd,(const uint8_t *)data.bytes+offset,data.length-offset);if(n<0&&errno==EINTR)continue;if(n<=0){failure=CSBackupFileError(url.path,@"write",n<0?errno:EIO);break;}offset+=(NSUInteger)n;}
    if(!failure&&fsync(fd))failure=CSBackupFileError(url.path,@"fsync-file",errno);
    if(close(fd)&&!failure)failure=CSBackupFileError(url.path,@"close",errno);
#if TARGET_OS_IPHONE
    if(!failure&&![NSFileManager.defaultManager setAttributes:@{NSFileProtectionKey:NSFileProtectionCompleteUntilFirstUserAuthentication} ofItemAtPath:temp.path error:&failure]&&!failure)
        failure=CSBackupFileError(url.path,@"file-protection",EACCES);
#endif
    if(!failure&&rename(temp.fileSystemRepresentation,url.fileSystemRepresentation))failure=CSBackupFileError(url.path,@"rename",errno);
    if(!failure){int dirfd=open(parent.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
        if(dirfd<0)failure=CSBackupFileError(parent.path,@"open-parent",errno);
        else{if(fsync(dirfd))failure=CSBackupFileError(parent.path,@"fsync-parent",errno);close(dirfd);}}
    if(failure){unlink(temp.fileSystemRepresentation);if(error)*error=failure;return NO;}
    return YES;
}
@implementation CSBackupStore
- (void)emit:(NSString *)event details:(NSDictionary *)details {
    @try {if(self.eventHandler)self.eventHandler(event,details);}
    @catch(__unused NSException *exception) {} // Diagnostics must not change storage results.
}
- (void)recordRestoreStage:(NSString *)stage status:(NSString *)status error:(NSError *)error details:(NSDictionary *)details {
    @try {
        NSMutableDictionary *payload=[@{@"stage":stage,@"status":status,@"path":self.root.path,
            @"writeRoot":self.root.path,@"readRoots":[(self.migration?self.migration.readRoots:@[self.root]) valueForKey:@"path"],
            @"journalPath":[self.root URLByAppendingPathComponent:@"transaction.plist"].path} mutableCopy];
        [payload addEntriesFromDictionary:details];[payload addEntriesFromDictionary:CSBackupRestoreErrorDetails(error)];
        [self emit:[@"restore-" stringByAppendingString:stage] details:payload];
    }@catch(__unused NSException *exception){}
}
- (instancetype)initWithRoot:(NSURL *)root {
    if((self=[super init]))_root=root;return self;
}
- (instancetype)initWithMigration:(CSPluginDirectoryMigration *)migration {
    [migration migrate:NULL];
    if((self=[self initWithRoot:migration.destinationRoot]))_migration=migration;
    return self;
}
- (BOOL)prepareForWriting:(NSError **)error {
    if(!self.migration)return YES;
    BOOL ok=[self.migration migrate:error];
    if(!ok)[self emit:@"migration-pending" details:@{@"error":self.migration.lastError.localizedDescription?:@""}];
    return ok;
}
- (BOOL)prepareForReading:(NSError **)error {
    if(!self.migration||[self.migration migrate:NULL])return YES;
    if(self.migration.lastError.code==CSPluginStorageErrorConflict){if(error)*error=self.migration.lastError;return NO;}
    return YES; // Old readable files remain available while relocation awaits retry.
}
- (NSURL *)readURL:(NSURL *)url {
    return self.migration?[self.migration readURLForName:url.lastPathComponent]:url;
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
    if(![self prepareForWriting:error])return NO;
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
    // Establish local name/favorite/import metadata before publishing a snapshot.
    // Preserve existing v2 metadata and conservatively retain any readable favorite.
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
    BOOL published=CSBackupAtomicWrite(encoded,url,error);
    [self emit:published?@"published":@"publish-failed" details:@{@"id":snapshot[@"id"],@"kind":snapshot[@"kind"]?:@"",@"imported":@(imported),@"bytes":@(encoded.length)}];
    return published;
}
- (NSDictionary *)snapshot:(NSString *)identifier error:(NSError **)error {
    NSError *failure=nil;NSURL *url=[self URLForID:identifier extension:@"wcbak"];
    if(!url){StoreFail(&failure,@"备份标识无效");}
    else if([self prepareForReading:&failure]){
        url=[self readURL:url];
        NSData *data=CSBackupReadFile(url,CSBackupMaximumFileSize,&failure);
        NSDictionary *snapshot=data?[CSBackupCodec decode:data error:&failure]:nil;
        if(snapshot&&[snapshot[@"id"] isEqual:identifier])return snapshot;
        if(snapshot)StoreFail(&failure,@"文件名与备份标识不一致");
    }
    if(error)*error=CSBackupRestoreError(failure,@"validate",CSBackupRestoreValidation,url.path);return nil;
}
- (NSDictionary *)snapshotForRestore:(NSString *)identifier error:(NSError **)error {
    NSURL *url=[self URLForID:identifier extension:@"wcbak"];
    if(!url)return [self snapshot:identifier error:error];
    [self recordRestoreStage:@"metadata" status:@"started" error:nil details:@{@"snapshotID":identifier}];
    NSError *metadataError=nil;[self metadata:identifier error:&metadataError];
    NSMutableArray *paths=[NSMutableArray array];for(NSString *extension in @[@"meta",@"meta.bak"])[paths addObject:[self readURL:[self URLForID:identifier extension:extension]].path];
    [self recordRestoreStage:@"metadata" status:metadataError?@"warning":@"ok" error:metadataError details:@{@"paths":paths,@"requiredForRestore":@NO}];
    // Local name/favorite/import metadata does not contain restore targets.
    // A damaged mirror must not invalidate a self-contained snapshot.
    [self recordRestoreStage:@"read-snapshot" status:@"started" error:nil details:@{@"path":[self readURL:url].path}];
    NSError *failure=nil;NSDictionary *snapshot=[self snapshot:identifier error:&failure];
    NSMutableDictionary *details=[@{@"path":[self readURL:url].path,@"snapshotID":identifier} mutableCopy];
    if(snapshot){details[@"sourceVersion"]=snapshot[@"source"][@"pluginVersion"]?:@"";details[@"assetCount"]=@([snapshot[@"assets"] count]);}
    [self recordRestoreStage:@"read-snapshot" status:snapshot?@"ok":@"failed" error:failure details:details];
    if(!snapshot&&error)*error=failure;return snapshot;
}
- (NSArray *)records:(NSError **)error {
    struct stat before;BOOL existed=lstat(self.root.path.fileSystemRepresentation,&before)==0;
    if(!self.migration&&!Directory(self.root,error))return @[];
    if(self.migration&&![self.migration migrate:error]){
        [self emit:@"migration-pending" details:@{@"error":self.migration.lastError.localizedDescription?:@""}];
    }
    NSMutableArray *urls=[NSMutableArray array];NSMutableSet *seen=[NSMutableSet set];
    for(NSURL *root in self.migration?self.migration.readRoots:@[self.root]){
        struct stat st;if(lstat(root.fileSystemRepresentation,&st)&&errno==ENOENT)continue;
        if(lstat(root.fileSystemRepresentation,&st)||!S_ISDIR(st.st_mode)){StoreFail(error,@"无法读取备份目录，原文件未修改");continue;}
        NSArray *entries=[NSFileManager.defaultManager contentsOfDirectoryAtURL:root includingPropertiesForKeys:nil options:0 error:error];
        for(NSURL *url in entries)if(![seen containsObject:url.lastPathComponent]){[urls addObject:url];[seen addObject:url.lastPathComponent];}
    }
    if(self.eventHandler&&urls) {
        NSMutableArray *names=[NSMutableArray array];for(NSURL *url in urls)[names addObject:url.lastPathComponent];
        [names sortUsingSelector:@selector(compare:)];
        [self emit:@"inventory" details:@{@"readRoots":[(self.migration?self.migration.readRoots:@[self.root]) valueForKey:@"path"],@"directoryExistedBeforeRead":@(existed),@"fileCount":@(names.count),@"files":[names subarrayWithRange:NSMakeRange(0,MIN(names.count,1000))]}];
    }
    NSMutableArray *items=[NSMutableArray array];
    for(NSURL *url in urls)if([url.pathExtension isEqual:@"wcbak"]) {
        NSDictionary *identity=FileIdentity([self readURL:url]);
        NSError *readError=nil;NSString *identifier=url.lastPathComponent.stringByDeletingPathExtension;
        NSDictionary *attributes=[NSFileManager.defaultManager attributesOfItemAtPath:url.path error:NULL];
        NSDictionary *s=[self snapshot:identifier error:&readError];
        if(!identity||![identity isEqual:FileIdentity([self readURL:url])]){s=nil;readError=CSBackupFailure(@"备份文件正在变化，已保留，稍后重试");}
        NSMutableDictionary *record=nil;
        if(s){
            NSMutableSet *modules=[NSMutableSet set],*accounts=[NSMutableSet set];
            for(NSDictionary *f in s[@"fields"]){[modules addObject:[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]][@"module"]];if([f[@"key"] isEqual:@"com.wechat.enhance.chat_group.account_profiles"]&&[f[@"value"] isKindOfClass:NSDictionary.class])[accounts addObjectsFromArray:[f[@"value"] allKeys]];}
            record=[@{@"id":s[@"id"],@"filename":url.lastPathComponent,@"name":s[@"name"],@"createdAt":s[@"createdAt"],@"kind":s[@"kind"],@"source":s[@"source"],@"warnings":s[@"warnings"],@"fieldCount":@([s[@"fields"] count]),@"assetCount":@([s[@"assets"] count]),@"modules":modules.allObjects,@"accounts":accounts.allObjects,@"size":attributes[NSFileSize]?:@0} mutableCopy];
        }else record=[@{@"id":identifier,@"filename":url.lastPathComponent,@"name":[@"无法读取的备份 · " stringByAppendingString:identifier],@"unavailable":@YES,@"issue":readError.localizedDescription?:@"文件校验未通过，原件已保留",@"size":attributes[NSFileSize]?:@0} mutableCopy];
        [items addObject:record];
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
    if(![self prepareForReading:error])return nil;
    return CSBackupReadFile([self readURL:[self.root URLByAppendingPathComponent:filename]],CSBackupMaximumFileSize,error);
}
- (BOOL)remove:(NSString *)identifier error:(NSError **)error {
    NSURL *url=[self URLForID:identifier extension:@"wcbak"];if(!url)return StoreFail(error,@"备份标识无效");
    return [self removeFile:url.lastPathComponent error:error];
}
- (BOOL)removeFile:(NSString *)filename error:(NSError **)error {
    if(![filename isKindOfClass:NSString.class]||!filename.length||![filename isEqual:filename.lastPathComponent]||
       [filename containsString:@"/"]||[filename rangeOfString:[NSString stringWithFormat:@"%C",(unichar)0]].location!=NSNotFound||
       ![filename.pathExtension isEqual:@"wcbak"])return StoreFail(error,@"备份文件名无效");
    if(![self prepareForWriting:error])return NO;
    NSString *identifier=filename.stringByDeletingPathExtension;
    NSError *journalError=nil;NSDictionary *journal=[self journal:&journalError];if(journalError){if(error)*error=journalError;return NO;}
    NSUUID *uuid=[[NSUUID alloc]initWithUUIDString:identifier];
    for(NSString *key in @[@"protectionID",@"sourceID"]){
        id reference=journal[key];
        if([reference isEqual:identifier]||(uuid&&[reference isKindOfClass:NSString.class]&&[uuid isEqual:[[NSUUID alloc]initWithUUIDString:reference]]))
            return StoreFail(error,@"恢复事务正在使用此备份，暂时不能删除");
    }
    NSDictionary *details=@{@"id":identifier,@"filename":filename};
    [self emit:@"remove-requested" details:details];
    NSURL *url=[self.root URLByAppendingPathComponent:filename];NSError *failure=nil;
    int directory=open(self.root.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
    if(directory<0)failure=CSBackupFileError(self.root.path,@"open-delete-directory",errno);
    else {
        struct stat st;
        if(fstatat(directory,filename.fileSystemRepresentation,&st,AT_SYMLINK_NOFOLLOW))failure=CSBackupFileError(url.path,@"inspect-delete",errno);
        else if(!S_ISREG(st.st_mode)&&!S_ISLNK(st.st_mode))StoreFail(&failure,@"备份不是普通文件或符号链接，未删除任何目录");
        else if(unlinkat(directory,filename.fileSystemRepresentation,0))failure=CSBackupFileError(url.path,@"delete",errno);
    }
    if(failure){if(directory>=0)close(directory);if(error)*error=failure;[self emit:@"remove-failed" details:details];return NO;}
    for(NSString *extension in @[@"meta",@"meta.bak"]){
        NSString *name=[identifier stringByAppendingPathExtension:extension];struct stat st;
        if(!fstatat(directory,name.fileSystemRepresentation,&st,AT_SYMLINK_NOFOLLOW)&&(S_ISREG(st.st_mode)||S_ISLNK(st.st_mode)))unlinkat(directory,name.fileSystemRepresentation,0);
    }
    close(directory);[self emit:@"removed" details:details];return YES;
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
    if(![self prepareForReading:error])return @{};
    NSURL *primary=[self URLForID:identifier extension:@"meta"],*mirror=[self URLForID:identifier extension:@"meta.bak"];
    if(!primary){StoreFail(error,@"备份标识无效，名称与收藏状态未确认");return @{};}
    NSDictionary *a=[self readMetadata:[self readURL:primary] identifier:identifier],*b=[self readMetadata:[self readURL:mirror] identifier:identifier];
    NSMutableDictionary *result=[(a?:b?:@{}) mutableCopy];
    // Conservative union protects collection/import across interrupted two-file updates.
    if([a[@"favorite"] boolValue]||[b[@"favorite"] boolValue])result[@"favorite"]=@YES;
    if(!result[@"importedAt"]&&(a[@"importedAt"]||b[@"importedAt"]))result[@"importedAt"]=a[@"importedAt"]?:b[@"importedAt"];
    if(!a||!b||![a isEqual:b])StoreFail(error,@"备份名称与收藏记录缺失、损坏或不一致，原件已保留。请重新确认名称与收藏状态。");
    return result;
}
- (BOOL)setMetadata:(NSDictionary *)metadata identifier:(NSString *)identifier error:(NSError **)error {
    if(![self prepareForWriting:error])return NO;
    NSURL *url=[self URLForID:identifier extension:@"meta"],*mirror=[self URLForID:identifier extension:@"meta.bak"];if(!url)return StoreFail(error,@"备份标识无效");
    if(!ValidMetadata(metadata))return StoreFail(error,@"备份名称与收藏信息无效，未覆盖原记录");
    NSMutableDictionary *normalized=[metadata mutableCopy];if(!normalized[@"favorite"])normalized[@"favorite"]=@NO;
    NSMutableDictionary *envelope=[@{@"schema":@1,@"identifier":identifier,@"metadata":normalized} mutableCopy];envelope[@"integrity"]=[CSBackupCodec digest:envelope];
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:envelope format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
    if(!data||data.length>MetadataLimit)return StoreFail(error,@"备份名称与收藏记录超过大小限制，原记录已保留");
    return CSBackupAtomicWrite(data,url,error)&&CSBackupAtomicWrite(data,mirror,error);
}
- (BOOL)writeJournal:(NSDictionary *)journal error:(NSError **)error {
    NSError *failure=nil;BOOL ok=[self writeJournalContent:journal error:&failure];
    [self recordRestoreStage:@"transaction" status:ok?@"saved":@"failed" error:failure
        details:@{@"state":journal[@"state"]?:@"",@"transactionID":journal[@"transactionID"]?:@"",
                  @"path":[self.root URLByAppendingPathComponent:@"transaction.plist"].path}];
    if(!ok&&error)*error=failure;return ok;
}
- (BOOL)writeJournalContent:(NSDictionary *)journal error:(NSError **)error {
    if(![self prepareForWriting:error])return NO;
    NSMutableDictionary *sealed=[journal mutableCopy];[sealed removeObjectForKey:@"integrity"];sealed[@"integrity"]=[CSBackupCodec digest:sealed];
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:sealed format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];if(data.length>80*1024*1024)return StoreFail(error,@"恢复日志超过 80 MiB，未发布待恢复计划");return data&&CSBackupAtomicWrite(data,[self.root URLByAppendingPathComponent:@"transaction.plist"],error);
}
- (NSDictionary *)journal:(NSError **)error {
    NSError *failure=nil;NSDictionary *journal=[self readJournalContent:&failure];
    if(failure&&error)*error=CSBackupRestoreError(failure,@"journal-read",CSBackupRestoreValidation,[self readURL:[self.root URLByAppendingPathComponent:@"transaction.plist"]].path);
    return journal;
}
- (NSDictionary *)readJournalContent:(NSError **)error {
    if(![self prepareForReading:error])return nil;
    NSURL *url=[self readURL:[self.root URLByAppendingPathComponent:@"transaction.plist"]];
    struct stat metadata;if(lstat(url.path.fileSystemRepresentation,&metadata)){if(errno==ENOENT)return nil;if(error)*error=CSBackupFileError(url.path,@"inspect-journal",errno);return nil;}
    if(!S_ISREG(metadata.st_mode)){StoreFail(error,@"恢复日志不是普通文件，启动保持等待");return nil;}
    NSData *data=CSBackupReadFile(url,80*1024*1024,error);if(!data)return nil;
    id value=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
    if(![value isKindOfClass:NSDictionary.class]){StoreFail(error,@"恢复日志损坏，配置未继续修改");return nil;}
    NSMutableDictionary *bare=[value mutableCopy];id hash=bare[@"integrity"];[bare removeObjectForKey:@"integrity"];
    if(![[CSBackupCodec digest:bare] isEqual:hash]){StoreFail(error,@"恢复日志校验失败，配置未继续修改");return nil;}return value;
}
- (BOOL)confirmActivation:(NSDictionary *)record error:(NSError **)error {
    if(![self prepareForWriting:error])return NO;
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:record format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
    if(!data||data.length>4096)return StoreFail(error,@"启动交接标记无效");
    return CSBackupAtomicWrite(data,[self.root URLByAppendingPathComponent:@"activation.plist"],error);
}
- (BOOL)activationConfirmed:(NSDictionary *)journal {
    if(![self prepareForReading:NULL])return NO;
    NSData *data=CSBackupReadFile([self readURL:[self.root URLByAppendingPathComponent:@"activation.plist"]],4096,NULL);if(!data)return NO;
    id record=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
    return [record isKindOfClass:NSDictionary.class]&&[record[@"transactionID"] isEqual:journal[@"transactionID"]]&&[record[@"account"] isEqual:journal[@"account"]]&&[record[@"installationID"] isEqual:journal[@"installationID"]];
}
- (BOOL)archiveJournal:(NSError **)error {
    NSError *failure=nil;BOOL ok=[self archiveJournalContent:&failure];
    [self recordRestoreStage:@"archive" status:ok?@"ok":@"failed" error:failure details:@{@"path":[self.root URLByAppendingPathComponent:@"transaction.plist"].path,@"archivePath":[self.root URLByAppendingPathComponent:@"last-transaction.plist"].path}];
    if(!ok&&error)*error=failure;return ok;
}
- (BOOL)archiveJournalContent:(NSError **)error {
    if(![self prepareForWriting:error])return NO;
    NSURL *source=[self.root URLByAppendingPathComponent:@"transaction.plist"];NSData *data=CSBackupReadFile(source,80*1024*1024,error);if(!data)return NO;
    if(!CSBackupAtomicWrite(data,[self.root URLByAppendingPathComponent:@"last-transaction.plist"],error))return NO;
    return [NSFileManager.defaultManager removeItemAtURL:source error:error];
}
@end
