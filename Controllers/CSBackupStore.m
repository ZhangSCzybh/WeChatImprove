#import "CSBackupStore.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
#import <TargetConditionals.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
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
- (instancetype)initWithRoot:(NSURL *)root {if((self=[super init]))_root=root;return self;}
- (NSURL *)URLForID:(NSString *)identifier extension:(NSString *)extension {
    if(![identifier isKindOfClass:NSString.class]||![[NSUUID alloc]initWithUUIDString:identifier])return nil;
    return [self.root URLByAppendingPathComponent:[identifier stringByAppendingPathExtension:extension]];
}
- (BOOL)publish:(NSDictionary *)snapshot error:(NSError **)error {
    NSURL *url=[self URLForID:snapshot[@"id"] extension:@"wcbak"];if(!url)return StoreFail(error,@"备份标识无效");
    NSData *encoded=[CSBackupCodec encode:snapshot error:error];if(!encoded||![CSBackupCodec decode:encoded error:error])return NO;
    if([NSFileManager.defaultManager fileExistsAtPath:url.path]) {
        NSDictionary *existing=[self snapshot:snapshot[@"id"] error:error];
        if(existing&&[existing[@"integrity"] isEqual:[CSBackupCodec decode:encoded error:error][@"integrity"]])return YES;
        return StoreFail(error,@"同一备份标识已有不同内容，原备份已保留");
    }
    return CSBackupAtomicWrite(encoded,url,error);
}
- (NSDictionary *)snapshot:(NSString *)identifier error:(NSError **)error {
    NSURL *url=[self URLForID:identifier extension:@"wcbak"];if(!url){StoreFail(error,@"备份标识无效");return nil;}
    NSData *data=CSBackupReadFile(url,CSBackupMaximumFileSize,error);if(!data)return nil;
    NSDictionary *s=[CSBackupCodec decode:data error:error];if(s&&![s[@"id"] isEqual:identifier]){StoreFail(error,@"文件名与备份标识不一致");return nil;}return s;
}
- (NSArray *)snapshots:(NSError **)error {
    if(!Directory(self.root,error))return @[];
    NSArray *urls=[NSFileManager.defaultManager contentsOfDirectoryAtURL:self.root includingPropertiesForKeys:nil options:0 error:error];
    NSMutableArray *items=[NSMutableArray array];NSUInteger corrupt=0;
    for(NSURL *url in urls)if([url.pathExtension isEqual:@"wcbak"]) {
        NSDictionary *s=[self snapshot:url.lastPathComponent.stringByDeletingPathExtension error:NULL];if(s){
            NSMutableArray *stable=[NSMutableArray array];NSMutableSet *modules=[NSMutableSet set],*accounts=[NSMutableSet set];
            for(NSDictionary *f in s[@"fields"]){if(![f[@"key"] hasPrefix:@"com.wechat.enhance.chat_group.selection."])[stable addObject:f];[modules addObject:[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]][@"module"]];if([f[@"key"] isEqual:@"com.wechat.enhance.chat_group.account_profiles"]&&[f[@"value"] isKindOfClass:NSDictionary.class])[accounts addObjectsFromArray:[f[@"value"] allKeys]];}
            NSDictionary *attributes=[NSFileManager.defaultManager attributesOfItemAtPath:url.path error:NULL];
            [items addObject:@{@"id":s[@"id"],@"name":s[@"name"],@"createdAt":s[@"createdAt"],@"kind":s[@"kind"],@"source":s[@"source"],@"warnings":s[@"warnings"],@"fieldCount":@([s[@"fields"] count]),@"assetCount":@([s[@"assets"] count]),@"modules":modules.allObjects,@"accounts":accounts.allObjects,@"size":attributes[NSFileSize]?:@0,@"contentDigest":[CSBackupCodec digest:@{@"fields":stable,@"assets":s[@"assets"]}]}];
        }else corrupt++;
    }
    if(corrupt)StoreFail(error,[NSString stringWithFormat:@"%lu 个损坏或不兼容的文件已保留，未列入可恢复备份",(unsigned long)corrupt]);
    [items sortUsingComparator:^NSComparisonResult(NSDictionary *a,NSDictionary *b){return [b[@"createdAt"] compare:a[@"createdAt"]];}];return items;
}
- (BOOL)remove:(NSString *)identifier error:(NSError **)error {
    NSURL *url=[self URLForID:identifier extension:@"wcbak"];if(!url)return StoreFail(error,@"备份标识无效");
    NSError *journalError=nil;NSDictionary *journal=[self journal:&journalError];if(journalError){if(error)*error=journalError;return NO;}
    if([journal[@"protectionID"] isEqual:identifier]||[journal[@"sourceID"] isEqual:identifier])return StoreFail(error,@"恢复事务正在使用此备份，暂时不能删除");
    return [NSFileManager.defaultManager removeItemAtURL:url error:error];
}
- (NSDictionary *)metadata:(NSString *)identifier {
    NSURL *url=[self URLForID:identifier extension:@"meta"];if(!url)return @{};
    NSData *data=CSBackupReadFile(url,16384,NULL);id value=data?[NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL]:nil;
    return [value isKindOfClass:NSDictionary.class]?value:@{};
}
- (BOOL)setMetadata:(NSDictionary *)metadata identifier:(NSString *)identifier error:(NSError **)error {
    NSURL *url=[self URLForID:identifier extension:@"meta"];if(!url)return StoreFail(error,@"备份标识无效");
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:metadata format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];return data&&CSBackupAtomicWrite(data,url,error);
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
- (BOOL)prune:(NSError **)error {
    NSError *listError=nil;NSArray *snapshots=[self snapshots:&listError];if(listError){if(error)*error=listError;return NO;}
    NSMutableDictionary *counts=[NSMutableDictionary dictionary];
    for(NSDictionary *s in snapshots){NSString *kind=s[@"kind"];NSUInteger quota=[kind isEqual:@"automatic"]?20:([@[@"protection",@"upgrade"] containsObject:kind]?5:0);
        NSDictionary *metadata=[self metadata:s[@"id"]];if(!quota||[metadata[@"favorite"] boolValue]||metadata[@"importedAt"])continue;
        if([kind isEqual:@"upgrade"])kind=@"protection";
        NSUInteger n=[counts[kind] unsignedIntegerValue]+1;counts[kind]=@(n);
        if(n>quota){NSError *ignored=nil;if(![self remove:s[@"id"] error:&ignored]){/* Active transaction protection is deliberately retained. */}}
    }return YES;
}
@end
