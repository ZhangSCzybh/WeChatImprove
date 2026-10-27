#import "CSAIReplyStore.h"
#import "CSAIClient.h"
#import <CommonCrypto/CommonDigest.h>
#import <TargetConditionals.h>
#import <sys/stat.h>
#import <fcntl.h>
#import <unistd.h>
#import <errno.h>

NSNotificationName const CSAIReplyConfigurationDidChange = @"CSAIReplyConfigurationDidChange";
NSString *const CSAIReplyBackupDomain = @"aiReply";
NSString *const CSAIReplyStoreCommitUncertainKey = @"CSAIReplyStoreCommitUncertain";
NSError *CSAIError(NSInteger code, NSString *message) { return [NSError errorWithDomain:@"com.wechatimprove.ai-reply" code:code userInfo:@{NSLocalizedDescriptionKey:message}]; }
static BOOL Fail(NSError **error, NSString *message) { if(error) *error=CSAIError(1,message); return NO; }
static BOOL String(id value, NSUInteger min, NSUInteger max) { return [value isKindOfClass:NSString.class] && [value length]>=min && [value length]<=max; }
static BOOL IsBoolean(id value) { return [value isKindOfClass:NSNumber.class] && ([value isEqual:@NO] || [value isEqual:@YES]); }
static NSString *Digest(NSString *value) { NSData *data=[value dataUsingEncoding:NSUTF8StringEncoding]; unsigned char bytes[CC_SHA256_DIGEST_LENGTH]; CC_SHA256(data.bytes,(CC_LONG)data.length,bytes); NSMutableString *result=[NSMutableString string]; for(NSUInteger i=0;i<sizeof(bytes);i++) [result appendFormat:@"%02x",bytes[i]]; return result; }
static BOOL OnlyKeys(NSDictionary *dictionary, NSArray *keys) { for(id key in dictionary) if(![keys containsObject:key]) return NO; return YES; }
NSURL *CSAIReplyFileURL(NSURL *root, NSString *account) { return [root URLByAppendingPathComponent:[NSString stringWithFormat:@"ai-reply-%@.plist",Digest(account)]]; }
NSDictionary *CSAIReplyDefaultConfiguration(void) { return @{@"enabled":@NO,@"endpoint":@"",@"model":@"",@"credentialRevision":@"",@"verifiedConnection":@"",@"presets":@[@{@"id":@"default",@"name":@"默认回复",@"prompt":@"请根据对方的消息，用自然、友好、简洁的中文回复。不编造事实，不代替我作出承诺；不确定时明确说明。只输出要发送的回复正文，不附加解释或格式标记。"}],@"defaultPreset":@"default",@"conversations":@{}}; }
NSString *CSAIConnectionIdentifier(NSDictionary *configuration) { NSMutableString *value=[NSMutableString string]; for(NSString *key in @[@"endpoint",@"model",@"credentialRevision"]) { NSString *part=[configuration[key] isKindOfClass:NSString.class]?configuration[key]:@""; [value appendFormat:@"%lu:%@",(unsigned long)part.length,part]; } return Digest(value); }
BOOL CSAIValidateEndpoint(NSString *endpoint, NSError **error) {
    if(!String(endpoint,1,8192) || ![endpoint isEqualToString:[endpoint stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]]) return Fail(error,@"请输入完整 HTTPS 请求地址");
    NSURLComponents *parts=[NSURLComponents componentsWithString:endpoint];
    if(![parts.scheme.lowercaseString isEqualToString:@"https"] || !parts.host.length || parts.user || parts.password || parts.fragment || !parts.URL || (parts.port && (parts.port.integerValue<1 || parts.port.integerValue>65535))) return Fail(error,@"请输入完整 HTTPS 请求地址，且不含账号或片段");
    return YES;
}
BOOL CSAIReplyValidateConfiguration(id configuration, NSError **error) {
    if(![configuration isKindOfClass:NSDictionary.class]) return Fail(error,@"AI 配置格式无效");
    NSDictionary *c=configuration;
    if(!OnlyKeys(c,@[@"enabled",@"endpoint",@"model",@"credentialRevision",@"verifiedConnection",@"verifiedAt",@"presets",@"defaultPreset",@"conversations"]) || !IsBoolean(c[@"enabled"]) || !String(c[@"endpoint"],0,8192) || !String(c[@"model"],0,200)) return Fail(error,@"AI 配置字段无效");
    NSString *endpoint=c[@"endpoint"];
    if(endpoint.length && !CSAIValidateEndpoint(endpoint,error)) return NO;
    if(c[@"credentialRevision"] && !String(c[@"credentialRevision"],0,200)) return Fail(error,@"凭据版本无效");
    if(c[@"verifiedConnection"] && !String(c[@"verifiedConnection"],0,200)) return Fail(error,@"验证状态无效");
    if(c[@"verifiedAt"] && ![c[@"verifiedAt"] isKindOfClass:NSDate.class]) return Fail(error,@"验证时间无效");
    NSArray *presets=c[@"presets"]; if(![presets isKindOfClass:NSArray.class] || presets.count<1 || presets.count>50) return Fail(error,@"回复预设数量无效");
    NSMutableSet *ids=[NSMutableSet set];
    for(id p in presets) { if(![p isKindOfClass:NSDictionary.class] || !OnlyKeys(p,@[@"id",@"name",@"prompt"]) || !String(p[@"id"],1,200) || !String(p[@"name"],1,60) || !String(p[@"prompt"],1,12000) || [ids containsObject:p[@"id"]]) return Fail(error,@"回复预设无效"); [ids addObject:p[@"id"]]; }
    if(!String(c[@"defaultPreset"],1,200) || ![ids containsObject:c[@"defaultPreset"]]) return Fail(error,@"默认预设无效");
    NSDictionary *conversations=c[@"conversations"]; if(![conversations isKindOfClass:NSDictionary.class] || conversations.count>1000) return Fail(error,@"会话配置无效");
    for(id key in conversations) { id item=conversations[key]; if(!String(key,1,512) || ![item isKindOfClass:NSDictionary.class] || !OnlyKeys(item,@[@"enabled",@"presetID"]) || !IsBoolean(item[@"enabled"]) || !String(item[@"presetID"],0,200) || ([item[@"presetID"] length] && ![ids containsObject:item[@"presetID"]])) return Fail(error,@"会话预设无效"); }
    return YES;
}
static BOOL ValidRecord(id record) {
    if(![record isKindOfClass:NSDictionary.class] || !OnlyKeys(record,@[@"date",@"conversation",@"preset",@"result",@"detail"])) return NO;
    return [record[@"date"] isKindOfClass:NSDate.class] && String(record[@"conversation"],1,512) && String(record[@"preset"],0,200) && String(record[@"result"],1,100) && String(record[@"detail"],0,300);
}
BOOL CSAIReplyValidateState(id state, NSString *account, NSError **error) {
    if(![state isKindOfClass:NSDictionary.class] || !OnlyKeys(state,@[@"schema",@"account",@"configuration",@"handled",@"history"]) || ![state[@"schema"] isEqual:@1] || !String(account,1,512) || ![state[@"account"] isEqual:account]) return Fail(error,@"AI 状态或账号无效");
    if(!CSAIReplyValidateConfiguration(state[@"configuration"],error)) return NO;
    id handled=state[@"handled"]?:@{}; id history=state[@"history"]?:@[];
    if(![handled isKindOfClass:NSDictionary.class] || [handled count]>5000 || ![history isKindOfClass:NSArray.class] || [history count]>200) return Fail(error,@"AI 运行状态无效");
    for(id key in handled) if(!String(key,1,1024) || ![handled[key] isKindOfClass:NSDate.class]) return Fail(error,@"消息记录无效");
    for(id record in history) if(!ValidRecord(record)) return Fail(error,@"回复记录无效");
    return YES;
}
NSDictionary *CSAIReplyPortableState(NSDictionary *state) {
    NSMutableDictionary *c=[NSMutableDictionary dictionary]; NSDictionary *source=state[@"configuration"]?:CSAIReplyDefaultConfiguration();
    for(NSString *key in @[@"enabled",@"endpoint",@"model",@"presets",@"defaultPreset",@"conversations"]) if(source[key]) c[key]=source[key];
    return @{@"schema":@1,@"account":state[@"account"]?:@"",@"configuration":c};
}
static NSDictionary *NewState(NSString *account) { return @{@"schema":@1,@"account":account,@"configuration":CSAIReplyDefaultConfiguration(),@"handled":@{},@"history":@[]}; }
static NSDictionary *ImmutableSnapshot(NSDictionary *state) { NSData *data=[NSPropertyListSerialization dataWithPropertyList:state format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL]; return data?[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL]:nil; }
@interface CSAIReplyStore ()
@property(nonatomic,strong) NSURL *url;
@property(nonatomic,copy,readwrite) NSString *account;
@property(nonatomic,strong) NSDictionary *state;
@property(nonatomic,readwrite) BOOL ready;
@property(nonatomic,strong,readwrite) NSError *error;
@end
@implementation CSAIReplyStore
- (instancetype)initWithURL:(NSURL *)url account:(NSString *)account { if((self=[super init])) { _url=url; _account=[account copy]; _state=NewState(account); } return self; }
- (NSDictionary *)configuration { @synchronized(self) { return self.state[@"configuration"]; } }
- (NSArray *)history { @synchronized(self) { return self.state[@"history"]?:@[]; } }
+ (NSDictionary *)readStateAtURL:(NSURL *)url account:(NSString *)account error:(NSError **)error {
    if(error) *error=nil;
    int descriptor=open(url.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW|O_NONBLOCK);
    if(descriptor<0) { if(errno==ENOENT) return nil; Fail(error,@"无法读取 AI 状态文件"); return nil; }
    struct stat info; NSUInteger limit=4*1024*1024;
    if(fstat(descriptor,&info)!=0 || !S_ISREG(info.st_mode) || info.st_size<0 || (uint64_t)info.st_size>limit) { close(descriptor); Fail(error,@"AI 状态文件类型或大小无效"); return nil; }
    NSMutableData *data=[NSMutableData data]; unsigned char buffer[16384]; BOOL valid=YES;
    for(;;) { ssize_t count=read(descriptor,buffer,sizeof(buffer)); if(count<0 && errno==EINTR) continue; if(count<0) { valid=NO; break; } if(count==0) break; if((NSUInteger)count>limit-data.length) { valid=NO; break; } [data appendBytes:buffer length:(NSUInteger)count]; }
    if(close(descriptor)!=0) valid=NO;
    if(!valid) { Fail(error,@"无法完整读取 AI 状态文件"); return nil; }
    id state=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
    if(!CSAIReplyValidateState(state,account,error)) return nil;
    return state;
}
+ (BOOL)replaceState:(NSDictionary *)state atURL:(NSURL *)url account:(NSString *)account error:(NSError **)error {
    struct stat existing; BOOL exists=lstat(url.fileSystemRepresentation,&existing)==0;
    if((!exists && errno!=ENOENT) || (exists && !S_ISREG(existing.st_mode))) return Fail(error,@"AI 状态文件类型无效");
    NSURL *parent=[url URLByDeletingLastPathComponent];
    if(!state) {
        if(!exists) return YES;
        int directory=open(parent.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
        if(directory<0) return Fail(error,@"无法打开 AI 状态目录");
        BOOL removed=unlink(url.fileSystemRepresentation)==0;
        BOOL synced=removed && fsync(directory)==0; close(directory);
        return synced?YES:Fail(error,@"无法持久删除 AI 状态文件");
    }
    if(!CSAIReplyValidateState(state,account,error)) return NO;
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:state format:NSPropertyListBinaryFormat_v1_0 options:0 error:error]; if(!data) return NO;
    if(data.length>4*1024*1024) return Fail(error,@"AI 状态文件过大");
    if(![[NSFileManager defaultManager] createDirectoryAtURL:parent withIntermediateDirectories:YES attributes:nil error:error]) return NO;
    int directory=open(parent.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
    if(directory<0) return Fail(error,@"无法打开 AI 状态目录");
    NSURL *temporary=[parent URLByAppendingPathComponent:[@".ai-reply-" stringByAppendingString:NSUUID.UUID.UUIDString]];
    int descriptor=open(temporary.fileSystemRepresentation,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);
    if(descriptor<0) { close(directory); return Fail(error,@"无法创建 AI 状态临时文件"); }
    BOOL success=fchmod(descriptor,0600)==0;
#if TARGET_OS_IPHONE
    if(success) success=[[NSFileManager defaultManager] setAttributes:@{NSFileProtectionKey:NSFileProtectionCompleteUntilFirstUserAuthentication} ofItemAtPath:temporary.path error:error];
#endif
    const unsigned char *bytes=data.bytes; NSUInteger remaining=data.length;
    while(success && remaining) { ssize_t count=write(descriptor,bytes,remaining); if(count<0 && errno==EINTR) continue; if(count<=0) { success=NO; break; } remaining-=(NSUInteger)count; bytes+=count; }
    if(success) success=fsync(descriptor)==0;
    if(close(descriptor)!=0) success=NO;
    // Recheck the destination immediately before rename; never follow or delete links.
    exists=lstat(url.fileSystemRepresentation,&existing)==0;
    if((!exists && errno!=ENOENT) || (exists && !S_ISREG(existing.st_mode))) success=NO;
    BOOL renamed=success && rename(temporary.fileSystemRepresentation,url.fileSystemRepresentation)==0;
    success=renamed && fsync(directory)==0;
    close(directory);
    if(!success) {
        unlink(temporary.fileSystemRepresentation);
        if(renamed) {
            if(error)*error=[NSError errorWithDomain:@"com.wechatimprove.ai-reply" code:2 userInfo:@{
                NSLocalizedDescriptionKey:@"AI 配置文件已替换，但无法确认持久保存；自动回复已暂停，请重新打开设置并检查连接。",
                CSAIReplyStoreCommitUncertainKey:@YES}];
            return NO;
        }
        return Fail(error,@"无法持久保存 AI 状态文件");
    }
    return YES;
}
- (BOOL)load { @synchronized(self) { NSError *error=nil; NSDictionary *state=[self.class readStateAtURL:self.url account:self.account error:&error]; self.ready=(error==nil); self.error=error; if(self.ready) self.state=state?:NewState(self.account); return self.ready; } }
- (BOOL)commit:(NSDictionary *)state error:(NSError **)error {
    if(!self.ready) return Fail(error,@"AI 存储未就绪");
    NSError *failure=nil; if(![self.class replaceState:state atURL:self.url account:self.account error:&failure]) { self.ready=NO; self.error=failure; if(error) *error=failure; return NO; }
    self.state=ImmutableSnapshot(state); return YES;
}
- (BOOL)saveConfiguration:(NSDictionary *)configuration error:(NSError **)error { @synchronized(self) {
    if(!CSAIReplyValidateConfiguration(configuration,error)) return NO;
    NSMutableDictionary *state=[self.state mutableCopy]; state[@"configuration"]=configuration;
    if(![self commit:state error:error]) return NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:CSAIReplyConfigurationDidChange object:self]; return YES;
} }
- (BOOL)hasHandledMessageID:(NSString *)identifier { @synchronized(self) { NSDate *date=self.state[@"handled"][identifier]; return date && [date timeIntervalSinceNow]>=-7*86400; } }
- (BOOL)claimMessageIDs:(NSArray<NSString *> *)identifiers error:(NSError **)error { @synchronized(self) {
    if(![identifiers isKindOfClass:NSArray.class] || !identifiers.count || identifiers.count>5000) return Fail(error,@"消息身份无效");
    NSMutableSet *seen=[NSMutableSet set]; NSMutableDictionary *handled=[self.state[@"handled"] mutableCopy]?:[NSMutableDictionary dictionary]; NSDate *now=[NSDate date];
    for(NSString *key in [handled allKeys]) if([handled[key] timeIntervalSinceDate:now]<-7*86400) [handled removeObjectForKey:key];
    for(id identifier in identifiers) { if(!String(identifier,1,1024) || handled[identifier] || [seen containsObject:identifier]) return Fail(error,@"消息已处理或身份无效"); [seen addObject:identifier]; }
    for(NSString *identifier in identifiers) handled[identifier]=now;
    NSArray *oldest=[handled keysSortedByValueUsingComparator:^NSComparisonResult(NSDate *a, NSDate *b) { return [a compare:b]; }];
    NSUInteger removeCount=handled.count>5000?handled.count-5000:0; for(NSUInteger i=0;i<removeCount;i++) [handled removeObjectForKey:oldest[i]];
    NSMutableDictionary *state=[self.state mutableCopy]; state[@"handled"]=handled; return [self commit:state error:error];
} }
- (BOOL)appendHistory:(NSDictionary *)record error:(NSError **)error { @synchronized(self) {
    if(!ValidRecord(record)) return Fail(error,@"回复记录无效");
    NSMutableArray *history=[self.history mutableCopy]; [history addObject:record]; if(history.count>200) [history removeObjectsInRange:NSMakeRange(0,history.count-200)];
    NSMutableDictionary *state=[self.state mutableCopy]; state[@"history"]=history; return [self commit:state error:error];
} }
@end
