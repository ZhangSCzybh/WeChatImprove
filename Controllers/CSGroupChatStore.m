#import "CSGroupChatStore.h"
#import "CSGroupChatTemplate.h"
#import <CommonCrypto/CommonDigest.h>
#include <math.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
NSString *const CSGroupChatBackupDomain=@"group_chat_tools";
static NSString *const CSGroupChatLegacyBackgroundKey=@"backgroundRealtimeEnabled";
static NSError *StoreError(NSString *detail) {return [NSError errorWithDomain:@"CSGroupChatStore" code:1 userInfo:@{NSLocalizedDescriptionKey:detail}];}
// The caller holds the account file's exclusive lock. Sync the temporary file
// before replacement, then sync the containing directory before reporting a
// durable commit; deleting a configuration needs the same directory barrier.
static BOOL ReplaceStateData(NSData *data,NSURL *url,NSError **error) {
    NSURL *parent=url.URLByDeletingLastPathComponent;
    int directory=open(parent.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
    if(directory<0){if(error)*error=StoreError(@"无法打开群聊配置目录，原有内容未更改。");return NO;}
    if(!data){
        BOOL removed=unlink(url.fileSystemRepresentation)==0;
        if(!removed && errno==ENOENT){close(directory);return YES;}
        BOOL success=removed && fsync(directory)==0;close(directory);
        if(!success && error)*error=StoreError(removed?@"群聊配置已删除，但无法确认持久保存；请重新进入设置检查。":@"无法删除群聊配置，原有文件已保留。");
        return success;
    }
    NSURL *temporary=[parent URLByAppendingPathComponent:[@".group-chat-" stringByAppendingString:NSUUID.UUID.UUIDString]];
    int descriptor=open(temporary.fileSystemRepresentation,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);
    if(descriptor<0){close(directory);if(error)*error=StoreError(@"无法创建群聊配置临时文件，原有内容未更改。");return NO;}
    BOOL success=fchmod(descriptor,0600)==0;const unsigned char *bytes=data.bytes;NSUInteger remaining=data.length;
    while(success && remaining){ssize_t count=write(descriptor,bytes,remaining);if(count<0 && errno==EINTR)continue;if(count<=0){success=NO;break;}remaining-=(NSUInteger)count;bytes+=count;}
    if(success)success=fsync(descriptor)==0;if(close(descriptor)!=0)success=NO;
    struct stat existing;BOOL exists=lstat(url.fileSystemRepresentation,&existing)==0;
    if((!exists && errno!=ENOENT) || (exists && !S_ISREG(existing.st_mode)))success=NO;
    BOOL renamed=success && rename(temporary.fileSystemRepresentation,url.fileSystemRepresentation)==0;
    success=renamed && fsync(directory)==0;close(directory);
    if(!success){unlink(temporary.fileSystemRepresentation);if(error)*error=StoreError(renamed?@"群聊配置已替换，但无法确认持久保存；请重新进入设置检查。":@"无法持久保存群聊配置，原有内容未更改。");}
    return success;
}
static BOOL Identifier(id value,BOOL room) {
    if(![value isKindOfClass:NSString.class] || ![value length] || [value length]>128)return NO;
    NSCharacterSet *allowed=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-@."];
    return [value rangeOfCharacterFromSet:allowed.invertedSet].location==NSNotFound && (!room || [value hasSuffix:@"@chatroom"]);
}
NSDictionary *CSGroupChatDefaultConfiguration(void) {
    return @{@"schemaVersion":@1,@"welcomeEnabled":@NO,@"welcomeRooms":@[],@"welcomeTemplate":CSGroupChatDefaultWelcome(),@"welcomeDelay":@3,
        @"monitorEnabled":@NO,@"monitorRooms":@[],@"departureTemplate":CSGroupChatDefaultDeparture(),
        @"departureSendToRoom":@NO,@"departureRoomTemplate":CSGroupChatDefaultRoomDeparture(),@"autoSaveEnabled":@NO};
}
static BOOL ConfigurationSwitch(id value) {
    return [value isKindOfClass:NSNumber.class] && ([value doubleValue]==0 || [value doubleValue]==1);
}
static BOOL ConfigurationTemplate(id value) {
    return [value isKindOfClass:NSString.class] && [value length]<=4000 && [value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length>0;
}
BOOL CSGroupChatValidateConfiguration(NSDictionary *configuration) {
    if(![configuration isKindOfClass:NSDictionary.class] || ![configuration[@"schemaVersion"] isEqual:@1])return NO;
    NSDictionary *defaults=CSGroupChatDefaultConfiguration();
    // Accept 2.4-5 account files and backups without interpreting the retired key.
    for(id key in configuration)if(!defaults[key] && ![key isEqual:CSGroupChatLegacyBackgroundKey])return NO;
    for(NSString *key in @[@"welcomeEnabled",@"monitorEnabled",@"autoSaveEnabled"])if(!ConfigurationSwitch(configuration[key]))return NO;
    id delay=configuration[@"welcomeDelay"];if(![delay isKindOfClass:NSNumber.class] || !isfinite([delay doubleValue]) || [delay doubleValue]!=floor([delay doubleValue]) || [delay integerValue]<0 || [delay integerValue]>300)return NO;
    for(NSString *key in @[@"welcomeTemplate",@"departureTemplate"])if(!ConfigurationTemplate(configuration[key]))return NO;
    // Older account files and portable backups can omit newly added keys.
    id roomSwitch=configuration[@"departureSendToRoom"],roomTemplate=configuration[@"departureRoomTemplate"];
    if((roomSwitch && !ConfigurationSwitch(roomSwitch)) || (roomTemplate && !ConfigurationTemplate(roomTemplate)))return NO;
    for(NSString *key in @[@"welcomeRooms",@"monitorRooms"]){id list=configuration[key];if(![list isKindOfClass:NSArray.class] || [list count]>10000)return NO;NSMutableSet *seen=[NSMutableSet set];for(id name in list){if(!Identifier(name,YES) || [seen containsObject:name])return NO;[seen addObject:name];}}
    return YES;
}
BOOL CSGroupChatValidateState(id state,NSString *account,NSError **error) {
    BOOL valid=Identifier(account,NO) && [state isKindOfClass:NSDictionary.class] && [state count]==3 && [state[@"schema"] isEqual:@1] && [state[@"account"] isEqual:account] && CSGroupChatValidateConfiguration(state[@"configuration"]);
    if(!valid && error)*error=StoreError(@"群聊配置格式或所属账号无效，原有文件已保留。");return valid;
}
NSURL *CSGroupChatFileURL(NSURL *root,NSString *account) {
    NSData *bytes=[account dataUsingEncoding:NSUTF8StringEncoding];unsigned char digest[CC_SHA256_DIGEST_LENGTH];CC_SHA256(bytes.bytes,(CC_LONG)bytes.length,digest);
    NSMutableString *name=[NSMutableString string];for(NSUInteger i=0;i<sizeof(digest);i++)[name appendFormat:@"%02x",digest[i]];
    return [[root URLByAppendingPathComponent:@"GroupChatTools" isDirectory:YES] URLByAppendingPathComponent:[name stringByAppendingString:@".plist"]];
}
NSDictionary *CSGroupChatReadState(NSURL *url,NSString *account,NSError **error) {
    if(error)*error=nil;struct stat metadata;
    if(lstat(url.fileSystemRepresentation,&metadata)!=0){if(errno!=ENOENT && error)*error=StoreError(@"无法读取群聊配置，原有内容未更改。");return nil;}
    NSDictionary *attrs=[NSFileManager.defaultManager attributesOfItemAtPath:url.path error:NULL];
    if(![attrs[NSFileType] isEqual:NSFileTypeRegular] || [attrs[NSFileSize] unsignedLongLongValue]>4*1024*1024){if(error)*error=StoreError(@"群聊配置文件无效，已保留原文件。");return nil;}
    NSData *data=[NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:error];if(!data)return nil;
    id state=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
    // Backup transactions verify the entire restored state; preserve its raw
    // shape here. The group manager omits the retired key from active settings.
    return CSGroupChatValidateState(state,account,error)?state:nil;
}
BOOL CSGroupChatWriteState(NSDictionary *state,NSURL *url,NSString *account,NSError **error) {
    if(error)*error=nil;if(state && !CSGroupChatValidateState(state,account,error))return NO;
    if(!Identifier(account,NO)){if(error)*error=StoreError(@"当前账号无效。");return NO;}
    NSURL *directory=url.URLByDeletingLastPathComponent;
    if(![NSFileManager.defaultManager createDirectoryAtURL:directory withIntermediateDirectories:YES attributes:@{NSFilePosixPermissions:@0700} error:error])return NO;
    NSString *lockPath=[url.path stringByAppendingString:@".lock"];int fd=open(lockPath.fileSystemRepresentation,O_CREAT|O_RDWR|O_NOFOLLOW,0600);
    if(fd<0 || flock(fd,LOCK_EX|LOCK_NB)!=0){if(fd>=0)close(fd);if(error)*error=StoreError(@"群聊配置正在更新，请稍后重试。");return NO;}
    BOOL success=NO;
    @try {
        NSDictionary *attrs=[NSFileManager.defaultManager attributesOfItemAtPath:url.path error:NULL];
        if(attrs && ![attrs[NSFileType] isEqual:NSFileTypeRegular]){if(error)*error=StoreError(@"群聊配置路径无效，未覆盖原内容。");}
        else {
            NSError *existingError=nil;CSGroupChatReadState(url,account,&existingError);
            if(existingError){if(error)*error=existingError;}
            else if(!state)success=ReplaceStateData(nil,url,error);
            else {NSData *data=[NSPropertyListSerialization dataWithPropertyList:state format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];success=data && ReplaceStateData(data,url,error);}
        }
    } @finally {flock(fd,LOCK_UN);close(fd);}
    return success;
}
