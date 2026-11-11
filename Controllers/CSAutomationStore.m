#import "CSAutomationStore.h"
#import <CommonCrypto/CommonDigest.h>
#include <math.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
NSString *const CSAutomationBackupDomain=@"automation";
static NSError *StoreError(NSString *detail) {return [NSError errorWithDomain:@"CSAutomationStore" code:1 userInfo:@{NSLocalizedDescriptionKey:detail}];}
// The caller holds the account file's exclusive lock. Sync the temporary file
// before replacement, then sync the containing directory before reporting a
// durable commit; deleting a configuration needs the same directory barrier.
static BOOL ReplaceStateData(NSData *data,NSURL *url,NSError **error) {
    NSURL *parent=url.URLByDeletingLastPathComponent;
    int directory=open(parent.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
    if(directory<0){if(error)*error=StoreError(@"无法打开自动功能配置目录，原有内容未更改。");return NO;}
    if(!data){
        BOOL removed=unlink(url.fileSystemRepresentation)==0;
        if(!removed && errno==ENOENT){close(directory);return YES;}
        BOOL success=removed && fsync(directory)==0;close(directory);
        if(!success && error)*error=StoreError(removed?@"自动功能配置已删除，但无法确认持久保存；请重新进入设置检查。":@"无法删除自动功能配置，原有文件已保留。");
        return success;
    }
    NSURL *temporary=[parent URLByAppendingPathComponent:[@".automation-" stringByAppendingString:NSUUID.UUID.UUIDString]];
    int descriptor=open(temporary.fileSystemRepresentation,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);
    if(descriptor<0){close(directory);if(error)*error=StoreError(@"无法创建自动功能配置临时文件，原有内容未更改。");return NO;}
    BOOL success=fchmod(descriptor,0600)==0;const unsigned char *bytes=data.bytes;NSUInteger remaining=data.length;
    while(success && remaining){ssize_t count=write(descriptor,bytes,remaining);if(count<0 && errno==EINTR)continue;if(count<=0){success=NO;break;}remaining-=(NSUInteger)count;bytes+=count;}
    if(success)success=fsync(descriptor)==0;if(close(descriptor)!=0)success=NO;
    struct stat existing;BOOL exists=lstat(url.fileSystemRepresentation,&existing)==0;
    if((!exists && errno!=ENOENT) || (exists && !S_ISREG(existing.st_mode)))success=NO;
    BOOL renamed=success && rename(temporary.fileSystemRepresentation,url.fileSystemRepresentation)==0;
    success=renamed && fsync(directory)==0;close(directory);
    if(!success){unlink(temporary.fileSystemRepresentation);if(error)*error=StoreError(renamed?@"自动功能配置已替换，但无法确认持久保存；请重新进入设置检查。":@"无法持久保存自动功能配置，原有内容未更改。");}
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
    [keyword addEntriesFromDictionary:@{@"quote":@YES,@"own":@NO,@"others":@YES,@"rules":@[]}];
    return @{@"schemaVersion":@1,@"patBack":back,@"patReply":pat,@"mentionReply":mention,@"keywordReply":keyword};
}
BOOL CSAutomationValidateConfiguration(id configuration){
    if(![configuration isKindOfClass:NSDictionary.class] || [configuration count]!=5 || ![configuration[@"schemaVersion"] isEqual:@1])return NO;
    for(NSString *name in @[@"patBack",@"patReply",@"mentionReply",@"keywordReply"]){
        id module=configuration[name];if(![module isKindOfClass:NSDictionary.class] || !Switch(module[@"enabled"]) || !Integer(module[@"delay"],0,300))return NO;
        NSUInteger count=[name isEqual:@"patBack"]?6:([name isEqual:@"keywordReply"]?8:6);if([module count]!=count)return NO;
        for(NSString *key in @[@"friends",@"groups"]){id list=module[key];if(![list isKindOfClass:NSArray.class] || [list count]>10000)return NO;NSMutableSet *seen=[NSMutableSet set];BOOL room=[key isEqual:@"groups"];for(id value in list){if(!Identifier(value,room) || (!room && [value hasSuffix:@"@chatroom"]) || [seen containsObject:value])return NO;[seen addObject:value];}}
        if([name isEqual:@"patBack"]){if(!Switch(module[@"revoke"]) || !Integer(module[@"revokeDelay"],1,300))return NO;}
        else if([name isEqual:@"keywordReply"]){
            if(!Switch(module[@"quote"]) || !Switch(module[@"own"]) || !Switch(module[@"others"]))return NO;
            id rules=module[@"rules"];if(![rules isKindOfClass:NSArray.class] || [rules count]>200)return NO;NSMutableSet *ids=[NSMutableSet set];
            for(id rule in rules){if(![rule isKindOfClass:NSDictionary.class] || [rule count]!=4 || ![[NSUUID alloc]initWithUUIDString:[rule[@"id"] isKindOfClass:NSString.class]?rule[@"id"]:@""] || [ids containsObject:rule[@"id"]] || !Text(rule[@"keyword"],256) || ![@[@"exact",@"prefix",@"contains"] containsObject:rule[@"match"]] || !Contents(rule[@"contents"]))return NO;[ids addObject:rule[@"id"]];}
        }else if(!Switch(module[@"mention"]) || !Contents(module[@"contents"]))return NO;
    }
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:configuration format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];return data && data.length<=4*1024*1024;
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
    struct stat st;if(lstat(url.fileSystemRepresentation,&st)!=0){if(errno!=ENOENT && error)*error=StoreError(@"无法读取自动功能文件。");return nil;}
    if(!S_ISREG(st.st_mode) || st.st_size<0 || st.st_size>4*1024*1024){if(error)*error=StoreError(@"自动功能文件无效，已保留原文件。");return nil;}
    int fd=open(url.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW);if(fd<0){if(error)*error=StoreError(@"无法安全打开自动功能文件。");return nil;}
    NSMutableData *data=[NSMutableData data];unsigned char buffer[16384];ssize_t length;
    while((length=read(fd,buffer,sizeof(buffer)))>0){[data appendBytes:buffer length:(NSUInteger)length];if(data.length>4*1024*1024)break;}
    int saved=errno;close(fd);if(length<0 || data.length>4*1024*1024){(void)saved;if(error)*error=StoreError(@"自动功能文件读取失败。");return nil;}
    return [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
}
NSDictionary *CSAutomationReadState(NSURL *url,NSString *account,NSError **error){if(error)*error=nil;id state=ReadPlist(url,error);return state && CSAutomationValidateState(state,account,error)?state:nil;}
static int Lock(NSURL *url,NSError **error){
    if(![NSFileManager.defaultManager createDirectoryAtURL:url.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:@{NSFilePosixPermissions:@0700} error:error])return -1;
    NSString *path=[url.path stringByAppendingString:@".lock"];int fd=open(path.fileSystemRepresentation,O_CREAT|O_RDWR|O_NOFOLLOW,0600);
    if(fd<0 || flock(fd,LOCK_EX|LOCK_NB)!=0){if(fd>=0)close(fd);if(error)*error=StoreError(@"自动功能文件正在更新，请稍后重试。");return -1;}return fd;
}
BOOL CSAutomationWriteState(NSDictionary *state,NSURL *url,NSString *account,NSError **error){
    if(error)*error=nil;if(!Identifier(account,NO) || (state && !CSAutomationValidateState(state,account,error)))return NO;
    int fd=Lock(url,error);if(fd<0)return NO;BOOL success=NO;
    @try{NSError *failure=nil;CSAutomationReadState(url,account,&failure);if(failure){if(error)*error=failure;}else {NSData *data=state?[NSPropertyListSerialization dataWithPropertyList:state format:NSPropertyListBinaryFormat_v1_0 options:0 error:error]:nil;success=(!state || data) && ReplaceStateData(data,url,error);}}
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
    NSDictionary *mention=configuration[@"mentionReply"];if(![event[@"own"] boolValue] && [event[@"mentioned"] boolValue] && Selected(mention,event) && [mention[@"contents"] count])return @[Decision(@"mentionReply",@"text",mention,nil)];
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
