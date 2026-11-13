#import "CSAutomationStore.h"
#import <CommonCrypto/CommonDigest.h>
#import <TargetConditionals.h>
#include <math.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
NSString *const CSAutomationBackupDomain=@"automation";
static NSError *StoreError(NSString *detail) {return [NSError errorWithDomain:@"CSAutomationStore" code:1 userInfo:@{NSLocalizedDescriptionKey:detail}];}
static NSError *IOError(NSString *operation,int value,NSError *underlying) {
    NSMutableDictionary *info=[@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"自动功能存储暂不可用（%@），保留数据等待重试。",operation],@"operation":operation} mutableCopy];
    if(value){info[@"errno"]=@(value);if(!underlying)underlying=[NSError errorWithDomain:NSPOSIXErrorDomain code:value userInfo:nil];}
    if(underlying)info[NSUnderlyingErrorKey]=underlying;
    return [NSError errorWithDomain:@"CSAutomationStore" code:2 userInfo:info];
}
BOOL CSAutomationStorageErrorIsRetryable(NSError *error){return [error.domain isEqual:@"CSAutomationStore"] && error.code==2;}
static NSDictionary *StorageAttributes(BOOL directory) {
    NSMutableDictionary *attributes=[@{NSFilePosixPermissions:directory?@0700:@0600} mutableCopy];
#if TARGET_OS_IPHONE
    attributes[NSFileProtectionKey]=NSFileProtectionCompleteUntilFirstUserAuthentication;
#endif
    return attributes;
}
static BOOL PreparePath(NSURL *url,BOOL directory,BOOL missingAllowed,NSError **error) {
    struct stat metadata;
    if(lstat(url.fileSystemRepresentation,&metadata)!=0){int value=errno;if(value==ENOENT && missingAllowed)return YES;if(error)*error=IOError(@"lstat",value,nil);return NO;}
    if(directory?!S_ISDIR(metadata.st_mode):!S_ISREG(metadata.st_mode)){if(error)*error=StoreError(@"自动功能存储路径类型无效，原有数据已保留。");return NO;}
    BOOL correct=(metadata.st_mode&07777)==(directory?0700:0600);
#if TARGET_OS_IPHONE
    NSError *failure=nil;NSDictionary *attributes=[NSFileManager.defaultManager attributesOfItemAtPath:url.path error:&failure];
    if(!attributes){if(error)*error=IOError(@"read-protection",0,failure);return NO;}
    correct=correct && [attributes[NSFileProtectionKey] isEqual:NSFileProtectionCompleteUntilFirstUserAuthentication];
#endif
    if(correct)return YES;
    NSError *failureToSet=nil;
    if(![NSFileManager.defaultManager setAttributes:StorageAttributes(directory) ofItemAtPath:url.path error:&failureToSet]){if(error)*error=IOError(@"set-protection",0,failureToSet);return NO;}
    return YES;
}
static BOOL PrepareExistingFile(NSURL *url,NSError **error) {
    return PreparePath(url.URLByDeletingLastPathComponent,YES,YES,error) && PreparePath(url,NO,YES,error) &&
        PreparePath([NSURL fileURLWithPath:[url.path stringByAppendingString:@".lock"]],NO,YES,error);
}
// The caller holds the account file's exclusive lock. Sync the temporary file
// before replacement, then sync the containing directory before reporting a
// durable commit; deleting a configuration needs the same directory barrier.
static BOOL ReplaceStateData(NSData *data,NSURL *url,NSError **error) {
    NSURL *parent=url.URLByDeletingLastPathComponent;
    int directory=open(parent.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
    if(directory<0){if(error)*error=IOError(@"open-directory",errno,nil);return NO;}
    if(!data){
        BOOL removed=unlink(url.fileSystemRepresentation)==0;
        if(!removed && errno==ENOENT){close(directory);return YES;}
        BOOL success=removed && fsync(directory)==0;int value=success?0:errno;close(directory);
        if(!success && error)*error=IOError(removed?@"sync-deletion":@"unlink",value,nil);
        return success;
    }
    NSURL *temporary=[parent URLByAppendingPathComponent:[@".automation-" stringByAppendingString:NSUUID.UUID.UUIDString]];
    int descriptor=open(temporary.fileSystemRepresentation,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);
    if(descriptor<0){int value=errno;close(directory);if(error)*error=IOError(@"create-temporary",value,nil);return NO;}
    NSError *failure=nil;BOOL success=fchmod(descriptor,0600)==0;int value=success?0:errno;
    if(success)success=PreparePath(temporary,NO,NO,&failure);
    const unsigned char *bytes=data.bytes;NSUInteger remaining=data.length;
    while(success && remaining){ssize_t count=write(descriptor,bytes,remaining);if(count<0 && errno==EINTR)continue;if(count<=0){value=count<0?errno:EIO;success=NO;break;}remaining-=(NSUInteger)count;bytes+=count;}
    if(success && fsync(descriptor)!=0){value=errno;success=NO;}if(close(descriptor)!=0 && success){value=errno;success=NO;}
    struct stat existing;BOOL exists=lstat(url.fileSystemRepresentation,&existing)==0;
    if(!exists && errno!=ENOENT && success){value=errno;success=NO;}
    if(exists && !S_ISREG(existing.st_mode)){failure=StoreError(@"自动功能目标路径类型无效，原有数据已保留。");success=NO;}
    BOOL renamed=NO;if(success){renamed=rename(temporary.fileSystemRepresentation,url.fileSystemRepresentation)==0;if(!renamed)value=errno;}
    success=renamed;if(success && fsync(directory)!=0){value=errno;success=NO;}close(directory);
    if(!success){unlink(temporary.fileSystemRepresentation);if(error)*error=failure?:IOError(renamed?@"sync-replacement":@"replace-file",value,nil);}
    return success;
}
static BOOL Identifier(id value,BOOL room) {
    if(![value isKindOfClass:NSString.class] || ![value length] || [value length]>128)return NO;
    NSCharacterSet *allowed=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-@."];
    return [value rangeOfCharacterFromSet:allowed.invertedSet].location==NSNotFound && (room?[value hasSuffix:@"@chatroom"]:YES);
}
static BOOL Switch(id value){return [value isKindOfClass:NSNumber.class] && ([value doubleValue]==0 || [value doubleValue]==1);}
static BOOL Integer(id value,NSInteger low,NSInteger high){double number=[value isKindOfClass:NSNumber.class]?[value doubleValue]:NAN;return isfinite(number) && number==floor(number) && number>=low && number<=high;}
static BOOL Text(id value,NSUInteger max){return [value isKindOfClass:NSString.class] && [value length]<=max && [value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length>0;}
static BOOL Contents(id value){if(![value isKindOfClass:NSArray.class] || [value count]>100)return NO;for(id text in value)if(!Text(text,4000))return NO;return YES;}
NSDictionary *CSAutomationDefaultConfiguration(void){
    NSDictionary *common=@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"delay":@3};
    NSMutableDictionary *back=[common mutableCopy],*pat=[common mutableCopy],*mention=[common mutableCopy],*keyword=[common mutableCopy];
    [back addEntriesFromDictionary:@{@"revoke":@NO,@"revokeDelay":@3}];
    [pat addEntriesFromDictionary:@{@"contents":@[],@"mention":@NO}];[mention addEntriesFromDictionary:@{@"contents":@[],@"mention":@NO}];
    [mention removeObjectForKey:@"friends"];
    [keyword addEntriesFromDictionary:@{@"quote":@YES,@"own":@NO,@"others":@YES,@"rules":@[]}];
    return @{@"schemaVersion":@1,@"patBackgroundFallback":@NO,@"patBack":back,@"patReply":pat,@"mentionReply":mention,@"keywordReply":keyword};
}
BOOL CSAutomationValidateConfiguration(id configuration){
    if(![configuration isKindOfClass:NSDictionary.class] || ![configuration[@"schemaVersion"] isEqual:@1])return NO;
    id fallback=configuration[@"patBackgroundFallback"];
    if([configuration count]!=(fallback?6UL:5UL) || (fallback && !Switch(fallback)))return NO;
    for(id key in configuration)if(![@[@"schemaVersion",@"patBackgroundFallback",@"patBack",@"patReply",@"mentionReply",@"keywordReply"] containsObject:key])return NO;
    for(NSString *name in @[@"patBack",@"patReply",@"mentionReply",@"keywordReply"]){
        id module=configuration[name];if(![module isKindOfClass:NSDictionary.class] || !Switch(module[@"enabled"]) || !Integer(module[@"delay"],0,300))return NO;
        BOOL mention=[name isEqual:@"mentionReply"],legacyFriends=mention && module[@"friends"]!=nil;
        NSUInteger count=[name isEqual:@"keywordReply"]?8:(mention && !legacyFriends?5:6);if([module count]!=count)return NO;
        for(NSString *key in mention && !legacyFriends?@[@"groups"]:@[@"friends",@"groups"]){id list=module[key];if(![list isKindOfClass:NSArray.class] || [list count]>10000)return NO;NSMutableSet *seen=[NSMutableSet set];BOOL room=[key isEqual:@"groups"];for(id value in list){if(!Identifier(value,room) || (!room && [value hasSuffix:@"@chatroom"]) || [seen containsObject:value])return NO;[seen addObject:value];}}
        if([name isEqual:@"patBack"]){if(!Switch(module[@"revoke"]) || !Integer(module[@"revokeDelay"],1,300))return NO;}
        else if([name isEqual:@"keywordReply"]){
            if(!Switch(module[@"quote"]) || !Switch(module[@"own"]) || !Switch(module[@"others"]))return NO;
            id rules=module[@"rules"];if(![rules isKindOfClass:NSArray.class] || [rules count]>200)return NO;NSMutableSet *ids=[NSMutableSet set];
            for(id rule in rules){if(![rule isKindOfClass:NSDictionary.class] || [rule count]!=4 || ![[NSUUID alloc]initWithUUIDString:[rule[@"id"] isKindOfClass:NSString.class]?rule[@"id"]:@""] || [ids containsObject:rule[@"id"]] || !Text(rule[@"keyword"],256) || ![@[@"exact",@"prefix",@"contains"] containsObject:rule[@"match"]] || !Contents(rule[@"contents"]))return NO;[ids addObject:rule[@"id"]];}
        }else if(!Switch(module[@"mention"]) || !Contents(module[@"contents"]))return NO;
    }
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:configuration format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];return data && data.length<=4*1024*1024;
}
NSDictionary *CSAutomationNormalizeConfiguration(id configuration){
    if(!CSAutomationValidateConfiguration(configuration))return nil;
    NSMutableDictionary *result=[configuration mutableCopy],*mention=[configuration[@"mentionReply"] mutableCopy];
    [mention removeObjectForKey:@"friends"];result[@"mentionReply"]=[mention copy];
    result[@"patBackgroundFallback"]=configuration[@"patBackgroundFallback"]?:@NO;
    return [result copy];
}
BOOL CSAutomationValidateState(id state,NSString *account,NSError **error){
    BOOL valid=Identifier(account,NO) && [state isKindOfClass:NSDictionary.class] && [state count]==3 && [state[@"schema"] isEqual:@1] && [state[@"account"] isEqual:account] && CSAutomationValidateConfiguration(state[@"configuration"]);
    if(!valid && error)*error=StoreError(@"自动功能配置格式或所属账号无效，原有文件已保留。");return valid;
}
NSURL *CSAutomationFileURL(NSURL *root,NSString *account){
    NSData *bytes=[account dataUsingEncoding:NSUTF8StringEncoding];unsigned char digest[CC_SHA256_DIGEST_LENGTH];CC_SHA256(bytes.bytes,(CC_LONG)bytes.length,digest);
    NSMutableString *name=[NSMutableString string];for(NSUInteger i=0;i<sizeof(digest);i++)[name appendFormat:@"%02x",digest[i]];
    return [[root URLByAppendingPathComponent:@"Automation" isDirectory:YES] URLByAppendingPathComponent:[name stringByAppendingString:@".plist"]];
}
static id ReadPlist(NSURL *url,NSError **error){
    if(!PrepareExistingFile(url,error))return nil;
    struct stat st;if(lstat(url.fileSystemRepresentation,&st)!=0){if(errno!=ENOENT && error)*error=IOError(@"lstat-file",errno,nil);return nil;}
    if(!S_ISREG(st.st_mode) || st.st_size<0 || st.st_size>4*1024*1024){if(error)*error=StoreError(@"自动功能文件无效，已保留原文件。");return nil;}
    int fd=open(url.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW);if(fd<0){if(error)*error=IOError(@"open-file",errno,nil);return nil;}
    NSMutableData *data=[NSMutableData data];unsigned char buffer[16384];ssize_t length;
    while((length=read(fd,buffer,sizeof(buffer)))!=0){if(length<0){if(errno==EINTR)continue;break;}[data appendBytes:buffer length:(NSUInteger)length];if(data.length>4*1024*1024)break;}
    int saved=errno;close(fd);if(length<0){if(error)*error=IOError(@"read-file",saved,nil);return nil;}
    if(data.length>4*1024*1024){if(error)*error=StoreError(@"自动功能文件超过限额，已保留原文件。");return nil;}
    return [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
}
NSDictionary *CSAutomationReadState(NSURL *url,NSString *account,NSError **error){
    if(error)*error=nil;
    // Upgrade only this account's automation files while unlocked, including
    // existing sidecar locks that otherwise retain their old protection class.
    NSURL *base=url.URLByDeletingPathExtension;
    for(NSURL *file in @[url,[base URLByAppendingPathExtension:@"runtime.plist"],[base URLByAppendingPathExtension:@"owned.plist"]])if(!PrepareExistingFile(file,error))return nil;
    id state=ReadPlist(url,error);if(!state || !CSAutomationValidateState(state,account,error))return nil;
    NSMutableDictionary *result=[state mutableCopy];result[@"configuration"]=CSAutomationNormalizeConfiguration(state[@"configuration"]);return [result copy];
}
static int Lock(NSURL *url,NSError **error){
    NSError *failure=nil;
    if(![NSFileManager.defaultManager createDirectoryAtURL:url.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:StorageAttributes(YES) error:&failure]){if(error)*error=IOError(@"create-directory",0,failure);return -1;}
    if(!PrepareExistingFile(url,error))return -1;
    NSString *path=[url.path stringByAppendingString:@".lock"];int fd=open(path.fileSystemRepresentation,O_CREAT|O_RDWR|O_NOFOLLOW,0600);
    if(fd<0){if(error)*error=IOError(@"open-lock",errno,nil);return -1;}
    if(!PreparePath([NSURL fileURLWithPath:path],NO,NO,error)){close(fd);return -1;}
    if(flock(fd,LOCK_EX|LOCK_NB)!=0){int value=errno;close(fd);if(error)*error=IOError(@"flock",value,nil);return -1;}return fd;
}
BOOL CSAutomationWriteState(NSDictionary *state,NSURL *url,NSString *account,NSError **error){
    if(error)*error=nil;if(!Identifier(account,NO) || (state && !CSAutomationValidateState(state,account,error)))return NO;
    int fd=Lock(url,error);if(fd<0)return NO;BOOL success=NO;
    @try{NSError *failure=nil;CSAutomationReadState(url,account,&failure);if(failure){if(error)*error=failure;}else {NSMutableDictionary *canonical=[state mutableCopy];if(state)canonical[@"configuration"]=CSAutomationNormalizeConfiguration(state[@"configuration"]);NSData *data=state?[NSPropertyListSerialization dataWithPropertyList:canonical format:NSPropertyListBinaryFormat_v1_0 options:0 error:error]:nil;success=(!state || data) && ReplaceStateData(data,url,error);}}
    @finally{flock(fd,LOCK_UN);close(fd);}return success;
}
static BOOL Selected(NSDictionary *module,NSDictionary *event){return [module[@"enabled"] boolValue] && [module[[event[@"group"] boolValue]?@"groups":@"friends"] containsObject:event[@"conversation"]?:@""];}
static NSDictionary *Decision(NSString *name,NSString *action,NSDictionary *module,NSDictionary *rule){
    NSMutableDictionary *result=[@{@"module":name,@"action":action,@"delay":module[@"delay"]} mutableCopy];
    if(rule){result[@"ruleID"]=rule[@"id"];result[@"contents"]=rule[@"contents"];}else if(module[@"contents"])result[@"contents"]=module[@"contents"];
    for(NSString *key in @[@"mention",@"quote",@"revoke",@"revokeDelay"])if(module[key])result[key]=module[key];return result;
}
NSArray<NSDictionary *> *CSAutomationDecisions(NSDictionary *configuration,NSDictionary *event,BOOL pat){
    if(!CSAutomationValidateConfiguration(configuration) || ![event isKindOfClass:NSDictionary.class])return @[];
    if(pat){if([event[@"own"] boolValue])return @[];NSMutableArray *result=[NSMutableArray array];for(NSString *name in @[@"patBack",@"patReply"]){NSDictionary *m=configuration[name];if(Selected(m,event) && ([name isEqual:@"patBack"] || [m[@"contents"] count]))[result addObject:Decision(name,name,m,nil)];}return result;}
    NSDictionary *mention=configuration[@"mentionReply"];if([event[@"group"] boolValue] && ![event[@"own"] boolValue] && [event[@"mentioned"] boolValue] && [mention[@"enabled"] boolValue] && [mention[@"groups"] containsObject:event[@"conversation"]?:@""] && [mention[@"contents"] count])return @[Decision(@"mentionReply",@"text",mention,nil)];
    NSDictionary *keyword=configuration[@"keywordReply"];if(!Selected(keyword,event) || ![keyword[[event[@"own"] boolValue]?@"own":@"others"] boolValue])return @[];
    NSString *text=event[@"text"];if(![text isKindOfClass:NSString.class])return @[];
    for(NSDictionary *rule in keyword[@"rules"]){NSString *needle=rule[@"keyword"],*mode=rule[@"match"];BOOL matches=[mode isEqual:@"exact"]?[text isEqual:needle]:([mode isEqual:@"prefix"]?[text hasPrefix:needle]:[text rangeOfString:needle].location!=NSNotFound);if(matches && [rule[@"contents"] count])return @[Decision(@"keywordReply",@"text",keyword,rule)];}return @[];
}
@interface CSAutomationLedger ()
@property NSURL *url;
@property NSString *account;
@property NSArray<NSDictionary *> *records;
@end
@implementation CSAutomationLedger
static BOOL RuntimeValid(id state,NSString *account){
    if(![state isKindOfClass:NSDictionary.class] || [state count]!=3 || ![state[@"schema"] isEqual:@1] || ![state[@"account"] isEqual:account] || ![state[@"records"] isKindOfClass:NSArray.class] || [state[@"records"] count]>5000)return NO;
    for(id record in state[@"records"]){if(![record isKindOfClass:NSDictionary.class] || [record count]!=3 || ![@[@"text",@"patBack",@"patReply",@"owned"] containsObject:record[@"action"]] || ![record[@"time"] isKindOfClass:NSDate.class] || ![record[@"ids"] isKindOfClass:NSArray.class] || ![record[@"ids"] count] || [record[@"ids"] count]>32)return NO;for(id key in record[@"ids"])if(!Text(key,512) || ![key hasPrefix:[account stringByAppendingString:@"|"]])return NO;}return YES;
}
- (instancetype)initWithURL:(NSURL *)url account:(NSString *)account error:(NSError **)error{
    if(error)*error=nil;if(!Identifier(account,NO))return nil;NSError *failure=nil;id state=ReadPlist(url,&failure);
    if(state && !RuntimeValid(state,account))failure=StoreError(@"自动功能运行记录无效，已保留原文件并暂停自动发送。");
    if(failure){if(error)*error=failure;return nil;}if((self=[super init])){_url=url;_account=[account copy];_records=state[@"records"]?:@[];}return self;
}
- (BOOL)hasIdentifiers:(NSArray<NSString *> *)identifiers action:(NSString *)action{NSSet *ids=[NSSet setWithArray:identifiers];for(NSDictionary *record in self.records)if([record[@"action"] isEqual:action] && [ids intersectsSet:[NSSet setWithArray:record[@"ids"]]])return YES;return NO;}
- (BOOL)claimIdentifiers:(NSArray<NSString *> *)identifiers action:(NSString *)action now:(NSDate *)now error:(NSError **)error{
    if(error)*error=nil;if(!identifiers.count || identifiers.count>32 || ![@[@"text",@"patBack",@"patReply",@"owned"] containsObject:action])return NO;
    for(id key in identifiers)if(!Text(key,512) || ![key hasPrefix:[self.account stringByAppendingString:@"|"]])return NO;
    int fd=Lock(self.url,error);if(fd<0)return NO;BOOL claimed=NO;
    @try{
        NSError *failure=nil;id state=ReadPlist(self.url,&failure);if(state && !RuntimeValid(state,self.account))failure=StoreError(@"自动功能运行记录损坏，已停止认领。");
        if(failure){if(error)*error=failure;return NO;}
        NSArray *existing=state[@"records"]?:@[];NSMutableArray *records=[NSMutableArray array];NSMutableSet *aliases=[NSMutableSet setWithArray:identifiers];BOOL duplicate=NO;NSDate *time=now;
        // Iterate until all transitive aliases of this event have joined the claim.
        NSMutableIndexSet *merged=[NSMutableIndexSet indexSet];BOOL changed=YES;
        while(changed){changed=NO;for(NSUInteger i=0;i<existing.count;i++){NSDictionary *record=existing[i];if(![merged containsIndex:i] && [record[@"action"] isEqual:action] && [aliases intersectsSet:[NSSet setWithArray:record[@"ids"]]]){[merged addIndex:i];[aliases addObjectsFromArray:record[@"ids"]];duplicate=YES;changed=YES;if([time compare:record[@"time"]]==NSOrderedAscending)time=record[@"time"];}}}
        for(NSUInteger i=0;i<existing.count;i++)if(![merged containsIndex:i] && [now timeIntervalSinceDate:existing[i][@"time"]]<=7*24*3600)[records addObject:existing[i]];
        if(aliases.count>32 || records.count>=5000){if(error)*error=StoreError(@"自动功能运行记录已满，本次不发送。");return NO;}
        [records addObject:@{@"action":action,@"ids":[aliases.allObjects sortedArrayUsingSelector:@selector(compare:)],@"time":time}];
        NSDictionary *next=@{@"schema":@1,@"account":self.account,@"records":records};NSData *data=[NSPropertyListSerialization dataWithPropertyList:next format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
        if(data.length>4*1024*1024){if(error)*error=StoreError(@"自动功能运行记录超过文件限额，本次不发送。");}
        else if(data && ReplaceStateData(data,self.url,error)){self.records=records;claimed=!duplicate;}
    }@finally{flock(fd,LOCK_UN);close(fd);}return claimed;
}
@end
