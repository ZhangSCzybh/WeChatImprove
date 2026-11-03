#import "CSAIReplyStore.h"
#import "CSAIClient.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <TargetConditionals.h>
#import <sys/stat.h>
#import <fcntl.h>
#import <unistd.h>
#import <errno.h>
#if TARGET_OS_IPHONE || defined(CSAI_STORE_TRACK_MUTATIONS)
#import "CSBackupMutation.h"
#endif

NSNotificationName const CSAIReplyConfigurationDidChange = @"CSAIReplyConfigurationDidChange";
NSString *const CSAIReplyBackupDomain = @"aiReply";
NSString *const CSAIReplyStoreCommitUncertainKey = @"CSAIReplyStoreCommitUncertain";
NSError *CSAIError(NSInteger code, NSString *message) { return [NSError errorWithDomain:@"com.wechatimprove.ai-reply" code:code userInfo:@{NSLocalizedDescriptionKey:message}]; }
static BOOL Fail(NSError **error, NSString *message) { if(error) *error=CSAIError(1,message); return NO; }
static BOOL String(id value, NSUInteger min, NSUInteger max) { return [value isKindOfClass:NSString.class] && [value length]>=min && [value length]<=max; }
static BOOL IsBoolean(id value) { return [value isKindOfClass:NSNumber.class] && ([value isEqual:@NO] || [value isEqual:@YES]); }
static BOOL IsStrictBoolean(id value) { return [value isKindOfClass:NSNumber.class] && CFGetTypeID((__bridge CFTypeRef)value)==CFBooleanGetTypeID(); }
static NSString *Digest(NSString *value) { NSData *data=[value dataUsingEncoding:NSUTF8StringEncoding]; unsigned char bytes[CC_SHA256_DIGEST_LENGTH]; CC_SHA256(data.bytes,(CC_LONG)data.length,bytes); NSMutableString *result=[NSMutableString string]; for(NSUInteger i=0;i<sizeof(bytes);i++) [result appendFormat:@"%02x",bytes[i]]; return result; }
static BOOL OnlyKeys(NSDictionary *dictionary, NSArray *keys) { for(id key in dictionary) if(![keys containsObject:key]) return NO; return YES; }
NSURL *CSAIReplyFileURL(NSURL *root, NSString *account) { return [root URLByAppendingPathComponent:[NSString stringWithFormat:@"ai-reply-%@.plist",Digest(account)]]; }
NSDictionary *CSAIReplyDefaultConfiguration(void) { return @{@"enabled":@NO,@"backgroundFallback":@YES,@"endpoint":@"",@"model":@"",@"credentialRevision":@"",@"verifiedConnection":@"",@"provider":@"openai-compatible",@"imageEnabled":@NO,@"searchMode":@"off",@"thinkingEnabled":@NO,@"presets":@[@{@"id":@"default",@"name":@"默认回复",@"prompt":@"请根据对方的消息，用自然、友好、简洁的中文回复。不编造事实，不代替我作出承诺；不确定时明确说明。只输出要发送的回复正文，不附加解释或格式标记。"}],@"defaultPreset":@"default",@"conversations":@{}}; }
NSString *CSAIProvider(NSDictionary *configuration) { id value=configuration[@"provider"]; return [value isKindOfClass:NSString.class]?value:@"openai-compatible"; }
NSString *CSAISearchMode(NSDictionary *configuration) { id value=configuration[@"searchMode"]; return [value isKindOfClass:NSString.class]?value:@"off"; }
NSString *CSAIConnectionIdentifier(NSDictionary *configuration) {
    NSMutableString *value=[NSMutableString string];
    for(NSString *key in @[@"endpoint",@"model",@"credentialRevision"]) { NSString *part=[configuration[key] isKindOfClass:NSString.class]?configuration[key]:@""; [value appendFormat:@"%lu:%@",(unsigned long)part.length,part]; }
    NSString *provider=CSAIProvider(configuration),*search=CSAISearchMode(configuration);
    BOOL image=[configuration[@"imageEnabled"] isKindOfClass:NSNumber.class] && [configuration[@"imageEnabled"] boolValue];
    BOOL thinking=[configuration[@"thinkingEnabled"] isKindOfClass:NSNumber.class] && [configuration[@"thinkingEnabled"] boolValue];
    // The complete default capability set must keep already-verified legacy connections valid.
    if(![provider isEqual:@"openai-compatible"] || image || ![search isEqual:@"off"] || thinking)
        for(NSString *part in @[@"capabilities-v1",provider,image?@"1":@"0",search,thinking?@"1":@"0"])
            [value appendFormat:@"%lu:%@",(unsigned long)part.length,part];
    return Digest(value);
}
BOOL CSAIValidateEndpoint(NSString *endpoint, NSError **error) {
    if(!String(endpoint,1,8192) || ![endpoint isEqualToString:[endpoint stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]]) return Fail(error,@"请输入完整 HTTPS 请求地址");
    NSURLComponents *parts=[NSURLComponents componentsWithString:endpoint];
    if(![parts.scheme.lowercaseString isEqualToString:@"https"] || !parts.host.length || parts.user || parts.password || parts.fragment || !parts.URL || (parts.port && (parts.port.integerValue<1 || parts.port.integerValue>65535))) return Fail(error,@"请输入完整 HTTPS 请求地址，且不含账号或片段");
    return YES;
}
BOOL CSAIReplyValidateConfiguration(id configuration, NSError **error) {
    if(![configuration isKindOfClass:NSDictionary.class]) return Fail(error,@"AI 配置格式无效");
    NSDictionary *c=configuration;
    if(!OnlyKeys(c,@[@"enabled",@"backgroundFallback",@"endpoint",@"model",@"credentialRevision",@"verifiedConnection",@"verifiedAt",@"provider",@"imageEnabled",@"searchMode",@"thinkingEnabled",@"presets",@"defaultPreset",@"conversations"]) || !IsBoolean(c[@"enabled"]) || (c[@"backgroundFallback"] && !IsStrictBoolean(c[@"backgroundFallback"])) || !String(c[@"endpoint"],0,8192) || !String(c[@"model"],0,200)) return Fail(error,@"AI 配置字段无效");
    if((c[@"provider"] && (!String(c[@"provider"],1,30) || ![@[@"openai-compatible",@"bailian"] containsObject:c[@"provider"]])) ||
       (c[@"imageEnabled"] && !IsBoolean(c[@"imageEnabled"])) || (c[@"thinkingEnabled"] && !IsBoolean(c[@"thinkingEnabled"])) ||
       (c[@"searchMode"] && (!String(c[@"searchMode"],1,10) || ![@[@"off",@"auto",@"always"] containsObject:c[@"searchMode"]]))) return Fail(error,@"模型能力配置无效");
    if(![CSAIProvider(c) isEqual:@"bailian"] && (![CSAISearchMode(c) isEqual:@"off"] || [c[@"thinkingEnabled"] boolValue])) return Fail(error,@"联网与思考模式仅支持阿里云百炼接口");
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
    for(id key in conversations) { id item=conversations[key]; if(!String(key,1,512) || ![item isKindOfClass:NSDictionary.class] || !OnlyKeys(item,@[@"enabled",@"presetID",@"allowUnmentioned"]) || !IsBoolean(item[@"enabled"]) || (item[@"allowUnmentioned"] && !IsBoolean(item[@"allowUnmentioned"])) || !String(item[@"presetID"],0,200) || ([item[@"presetID"] length] && ![ids containsObject:item[@"presetID"]])) return Fail(error,@"会话预设无效"); }
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
    for(NSString *key in @[@"enabled",@"backgroundFallback",@"endpoint",@"model",@"provider",@"imageEnabled",@"searchMode",@"thinkingEnabled",@"presets",@"defaultPreset",@"conversations"]) if(source[key]) c[key]=source[key];
    return @{@"schema":@1,@"account":state[@"account"]?:@"",@"configuration":c};
}
static NSDictionary *NewState(NSString *account) { return @{@"schema":@1,@"account":account,@"configuration":CSAIReplyDefaultConfiguration(),@"handled":@{},@"history":@[]}; }
// Freeze caller-owned input once; later commits share the immutable, unchanged branches.
static id ImmutablePropertyList(id value) { if(!value)return nil;return CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault,(__bridge CFPropertyListRef)value,kCFPropertyListImmutable)); }
// This queue outlives individual stores so an old account writer cannot race a new load.
static void *CSAIStoreQueueKey=&CSAIStoreQueueKey;
static dispatch_queue_t CSAIStoreQueue(void) {
    static dispatch_queue_t queue; static dispatch_once_t once;
    dispatch_once(&once,^{queue=dispatch_queue_create("com.wechatimprove.ai-store",DISPATCH_QUEUE_SERIAL);dispatch_queue_set_specific(queue,CSAIStoreQueueKey,CSAIStoreQueueKey,NULL);});
    return queue;
}
static void CSAIStoreSync(dispatch_block_t block) { if(dispatch_get_specific(CSAIStoreQueueKey))block();else dispatch_sync(CSAIStoreQueue(),block); }
@interface CSAIReplyDiskState : NSObject
@property NSDictionary *state;
@property BOOL ready;
@property NSError *error;
@property NSUInteger dirtyHistory;
@property dispatch_source_t historyTimer;
@property NSHashTable<CSAIReplyStore *> *stores;
@end
@implementation CSAIReplyDiskState
- (instancetype)init {if((self=[super init]))_stores=NSHashTable.weakObjectsHashTable;return self;}
@end
static NSMapTable<NSString *,CSAIReplyDiskState *> *CSAIStoreDiskStates(void) {
    static NSMapTable *states;static dispatch_once_t once;
    dispatch_once(&once,^{states=[NSMapTable strongToWeakObjectsMapTable];});return states;
}
@interface CSAIReplyAliasWaiter : NSObject
@property NSUInteger generation;
@property(copy) CSAIReplyStoreCompletion completion;
@end
@implementation CSAIReplyAliasWaiter @end
@interface CSAIReplyAliasBatch : NSObject
@property NSMutableSet<NSString *> *identifiers;
@property NSMutableArray<CSAIReplyAliasWaiter *> *waiters;
@end
@implementation CSAIReplyAliasBatch
- (instancetype)init {if((self=[super init])){_identifiers=[NSMutableSet set];_waiters=[NSMutableArray array];}return self;}
@end
@interface CSAIReplyStore ()
@property(nonatomic,strong) NSURL *url;
@property(nonatomic,copy,readwrite) NSString *account;
@property(nonatomic,strong) NSDictionary *state;
@property(nonatomic) BOOL snapshotReady;
@property(nonatomic,strong) NSError *snapshotError;
@property(nonatomic) BOOL invalidated;
@property(nonatomic) NSUInteger generation;
@property(nonatomic,strong) CSAIReplyDiskState *disk;
// Admission-only lock state. No serialization or file work holds this lock.
@property(nonatomic,strong) CSAIReplyAliasBatch *aliasBatch;
@property(nonatomic) NSUInteger aliasPendingIDs;
@property(nonatomic) NSUInteger aliasPendingCallbacks;
@property(nonatomic,strong) NSError *aliasAdmissionError;
@end
@implementation CSAIReplyStore
- (instancetype)initWithURL:(NSURL *)url account:(NSString *)account { if((self=[super init])) { _url=url; _account=[account copy]; _state=NewState(_account); } return self; }
- (NSDictionary *)configuration { @synchronized(self) { return self.state[@"configuration"]; } }
- (NSArray *)history { @synchronized(self) { return self.state[@"history"]?:@[]; } }
- (BOOL)ready { @synchronized(self) {return self.snapshotReady && !self.invalidated;} }
- (NSError *)error { @synchronized(self) {return self.snapshotError;} }
- (void)invalidate { @synchronized(self) {self.invalidated=YES;self.generation++;self.snapshotReady=NO;} }
- (BOOL)validGeneration:(NSUInteger)generation { @synchronized(self) {return !self.invalidated && self.generation==generation;} }
- (CSAIReplyDiskState *)diskState {
    NSAssert(dispatch_get_specific(CSAIStoreQueueKey),@"AI state must be queue owned");
    if(!self.disk){
        NSMapTable *states=CSAIStoreDiskStates();
        NSString *key=[NSString stringWithFormat:@"%@|%@",self.url.path.stringByStandardizingPath,self.account];
        self.disk=[states objectForKey:key];if(!self.disk){self.disk=[CSAIReplyDiskState new];self.disk.state=NewState(self.account);[states setObject:self.disk forKey:key];}
        [self.disk.stores addObject:self];
    }
    return self.disk;
}
- (void)publish {
    CSAIReplyDiskState *disk=[self diskState];
    for(CSAIReplyStore *store in disk.stores.allObjects)@synchronized(store){
        if(!store.invalidated){store.state=disk.state;store.snapshotReady=disk.ready && !store.aliasAdmissionError;store.snapshotError=store.aliasAdmissionError?:disk.error;}
    }
}
- (void)cancelHistoryTimer {CSAIReplyDiskState *disk=[self diskState];if(disk.historyTimer){dispatch_source_cancel(disk.historyTimer);disk.historyTimer=nil;}}
- (void)performAsync:(BOOL (^)(NSError **))work completion:(CSAIReplyStoreCompletion)completion {
    NSUInteger generation;@synchronized(self){generation=self.generation;}
    dispatch_async(CSAIStoreQueue(),^{@autoreleasepool{
        NSError *error=nil;BOOL success=NO;
        if([self validGeneration:generation])success=work(&error);else error=CSAIError(20,@"账号或存储状态已改变，本次操作已取消。");
        if(!completion)return;
        dispatch_async(dispatch_get_main_queue(),^{
            if(![self validGeneration:generation]){
                NSMutableDictionary *info=[@{NSLocalizedDescriptionKey:@"账号或存储状态已改变，本次操作已取消。"} mutableCopy];
                if(success || [error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue])info[CSAIReplyStoreCommitUncertainKey]=@YES;
                if(completion)completion(NO,[NSError errorWithDomain:@"com.wechatimprove.ai-reply" code:20 userInfo:info]);return;
            }
            if(completion)completion(success,error);
        });
    }});
}
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
- (BOOL)loadOnQueue:(NSError **)error {
    NSError *admissionFailure;@synchronized(self){admissionFailure=self.aliasAdmissionError;}
    if(admissionFailure){if(error)*error=admissionFailure;return NO;}
    CSAIReplyDiskState *disk=[self diskState];
    if(disk.dirtyHistory && disk.ready && ![self flushHistoryOnQueue:error])return NO;
    NSError *failure=nil;NSDictionary *state=[self.class readStateAtURL:self.url account:self.account error:&failure];
    disk.ready=(failure==nil);disk.error=failure;
    if(disk.ready){
        if(state && [state[@"configuration"] isEqual:disk.state[@"configuration"]]){NSMutableDictionary *stable=[state mutableCopy];stable[@"configuration"]=disk.state[@"configuration"];state=[stable copy];}
        disk.state=state?:NewState(self.account);
    }
    [self publish];@synchronized(self){admissionFailure=self.aliasAdmissionError;}
    if(error)*error=admissionFailure?:failure;return disk.ready && !admissionFailure;
}
- (BOOL)commitOnQueue:(NSDictionary *)state error:(NSError **)error {
    CSAIReplyDiskState *disk=[self diskState];
    if(!disk.ready)return Fail(error,@"AI 存储未就绪");
    NSError *failure=nil;
#if TARGET_OS_IPHONE || defined(CSAI_STORE_TRACK_MUTATIONS)
    CSBackupResourceMutationScope();
#endif
    BOOL success=[self.class replaceState:state atURL:self.url account:self.account error:&failure];
    if(success){disk.state=[state copy];disk.dirtyHistory=0;[self cancelHistoryTimer];}
    else {disk.ready=NO;disk.error=failure;[self cancelHistoryTimer];if(error)*error=failure;}
    [self publish];return success;
}
- (BOOL)saveOnQueue:(NSDictionary *)configuration expected:(NSDictionary *)expected error:(NSError **)error {
    CSAIReplyDiskState *disk=[self diskState];
    if(expected && ![expected isEqual:disk.state[@"configuration"]])return Fail(error,@"配置已改变，请刷新后重试。");
    if(!CSAIReplyValidateConfiguration(configuration,error))return NO;
    NSMutableDictionary *state=[disk.state mutableCopy];state[@"configuration"]=configuration;
    return [self commitOnQueue:state error:error];
}
- (BOOL)claimOnQueue:(NSArray<NSString *> *)identifiers error:(NSError **)error {
    CSAIReplyDiskState *disk=[self diskState];
    if(![identifiers isKindOfClass:NSArray.class] || !identifiers.count || identifiers.count>5000)return Fail(error,@"消息身份无效");
    NSMutableSet *seen=[NSMutableSet set];NSMutableArray<NSString *> *keys=[NSMutableArray arrayWithCapacity:identifiers.count];
    NSMutableDictionary *handled=[disk.state[@"handled"] mutableCopy]?:[NSMutableDictionary dictionary];NSDate *now=NSDate.date;
    for(NSString *key in handled.allKeys)if([handled[key] timeIntervalSinceDate:now]<-7*86400)[handled removeObjectForKey:key];
    for(id identifier in identifiers){if(!String(identifier,1,1024) || handled[identifier] || [seen containsObject:identifier])return Fail(error,@"消息已处理或身份无效");[seen addObject:identifier];[keys addObject:identifier];}
    for(NSString *identifier in keys)handled[identifier]=now;
    if(handled.count>5000){NSArray *oldest=[handled keysSortedByValueUsingSelector:@selector(compare:)];NSUInteger removeCount=handled.count-5000;for(NSUInteger i=0;i<removeCount;i++)[handled removeObjectForKey:oldest[i]];}
    NSMutableDictionary *state=[disk.state mutableCopy];state[@"handled"]=[handled copy];return [self commitOnQueue:state error:error];
}
- (BOOL)historyOnQueue:(NSDictionary *)record immediate:(BOOL)immediate error:(NSError **)error {
    CSAIReplyDiskState *disk=[self diskState];if(!disk.ready)return Fail(error,@"AI 存储未就绪");
    if(!ValidRecord(record))return Fail(error,@"回复记录无效");
    NSMutableArray *history=[disk.state[@"history"] mutableCopy]?:[NSMutableArray array];[history addObject:record];
    if(history.count>200)[history removeObjectsInRange:NSMakeRange(0,history.count-200)];
    NSMutableDictionary *state=[disk.state mutableCopy];state[@"history"]=[history copy];
    if(immediate)return [self commitOnQueue:state error:error];
    disk.state=[state copy];disk.dirtyHistory++;[self publish];
    if(disk.dirtyHistory>=10)return [self flushHistoryOnQueue:error];
    if(!disk.historyTimer){
        disk.historyTimer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,CSAIStoreQueue());
        dispatch_source_set_timer(disk.historyTimer,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC),DISPATCH_TIME_FOREVER,100*NSEC_PER_MSEC);
        // The timer keeps accepted history alive until its one-shot flush, even after account switching.
        dispatch_source_set_event_handler(disk.historyTimer,^{[self flushHistoryOnQueue:NULL];});dispatch_resume(disk.historyTimer);
    }
    return YES;
}
- (BOOL)flushHistoryOnQueue:(NSError **)error {CSAIReplyDiskState *disk=[self diskState];if(!disk.dirtyHistory)return disk.ready;return [self commitOnQueue:disk.state error:error];}
- (void)loadWithCompletion:(CSAIReplyStoreCompletion)completion {[self performAsync:^BOOL(NSError **error){return [self loadOnQueue:error];} completion:completion];}
- (void)saveConfiguration:(NSDictionary *)configuration expectedConfiguration:(NSDictionary *)expected completion:(CSAIReplyStoreCompletion)completion {
    NSDictionary *snapshot=ImmutablePropertyList(configuration),*base=ImmutablePropertyList(expected);
    [self performAsync:^BOOL(NSError **error){if(!base)return Fail(error,@"配置快照无效，请刷新后重试。");return [self saveOnQueue:snapshot expected:base error:error];} completion:^(BOOL success,NSError *error){if(success)[NSNotificationCenter.defaultCenter postNotificationName:CSAIReplyConfigurationDidChange object:self];if(completion)completion(success,error);}];
}
- (void)claimMessageIDs:(NSArray<NSString *> *)identifiers completion:(CSAIReplyStoreCompletion)completion {
    NSArray *snapshot=ImmutablePropertyList(identifiers);[self performAsync:^BOOL(NSError **error){return [self claimOnQueue:snapshot error:error];} completion:completion];
}
- (void)drainAliasBatch:(CSAIReplyAliasBatch *)batch {
    NSArray<NSString *> *identifiers;NSArray<CSAIReplyAliasWaiter *> *waiters;
    @synchronized(self){
        if(self.aliasBatch==batch)self.aliasBatch=nil;
        identifiers=batch.identifiers.allObjects;waiters=[batch.waiters copy];
    }
    // Accepted identity-only writes remain bound to this path after invalidate.
    // They must not use performAsync:, which revokes queued business operations.
    CSAIReplyDiskState *disk=[self diskState];NSError *error=nil;BOOL success=NO;
    if(!disk.ready)error=disk.error?:CSAIError(1,@"AI 存储未就绪");
    else {
        NSMutableArray *missing=[NSMutableArray array];NSDate *now=NSDate.date;
        for(NSString *identifier in identifiers){NSDate *date=disk.state[@"handled"][identifier];if(!date || [date timeIntervalSinceDate:now]<-7*86400)[missing addObject:identifier];}
        success=!missing.count || [self claimOnQueue:missing error:&error];
    }
    dispatch_async(dispatch_get_main_queue(),^{
        NSError *admissionFailure;
        @synchronized(self){
            self.aliasPendingIDs-=identifiers.count;self.aliasPendingCallbacks-=waiters.count;
            admissionFailure=self.aliasAdmissionError;
        }
        for(CSAIReplyAliasWaiter *waiter in waiters){
            if(!waiter.completion)continue;
            if(![self validGeneration:waiter.generation]){
                NSMutableDictionary *info=[@{NSLocalizedDescriptionKey:@"账号或存储状态已改变，本次操作已取消。"} mutableCopy];
                if(success || [error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue])info[CSAIReplyStoreCommitUncertainKey]=@YES;
                waiter.completion(NO,[NSError errorWithDomain:@"com.wechatimprove.ai-reply" code:20 userInfo:info]);
            }else waiter.completion(success && !admissionFailure,admissionFailure?:error);
        }
    });
}
- (void)claimMessageAliases:(NSArray<NSString *> *)identifiers completion:(CSAIReplyStoreCompletion)completion {
    NSMutableSet<NSString *> *snapshot=[NSMutableSet set];NSError *failure=nil;
    if(![identifiers isKindOfClass:NSArray.class] || !identifiers.count || identifiers.count>5000)failure=CSAIError(21,@"消息别名无效，自动回复已暂停。");
    else for(id identifier in identifiers){
        if(!String(identifier,1,1024)){failure=CSAIError(21,@"消息别名无效，自动回复已暂停。");break;}
        [snapshot addObject:[identifier copy]];
    }
    @synchronized(self){
        if(!failure)failure=self.aliasAdmissionError;
        NSUInteger added=0;for(NSString *identifier in snapshot)if(![self.aliasBatch.identifiers containsObject:identifier])added++;
        if(!failure && (added>5000-self.aliasPendingIDs || self.aliasPendingCallbacks>=256))failure=CSAIError(21,@"消息别名待保存数量过多，自动回复已暂停，请重新打开设置后重试。");
        if(failure){
            if(!self.aliasAdmissionError)self.aliasAdmissionError=failure;
            self.snapshotReady=NO;self.snapshotError=self.aliasAdmissionError;
            if(completion){NSError *reported=self.aliasAdmissionError;dispatch_async(dispatch_get_main_queue(),^{completion(NO,reported);});}
            return;
        }
        BOOL enqueue=!self.aliasBatch;if(enqueue)self.aliasBatch=[CSAIReplyAliasBatch new];
        CSAIReplyAliasBatch *batch=self.aliasBatch;[batch.identifiers unionSet:snapshot];
        CSAIReplyAliasWaiter *waiter=[CSAIReplyAliasWaiter new];waiter.generation=self.generation;waiter.completion=completion;[batch.waiters addObject:waiter];
        self.aliasPendingIDs+=added;self.aliasPendingCallbacks++;
        // Enqueue while admission is locked so a following account load cannot overtake it.
        if(enqueue)dispatch_async(CSAIStoreQueue(),^{@autoreleasepool{[self drainAliasBatch:batch];}});
    }
}
- (void)appendHistory:(NSDictionary *)record completion:(CSAIReplyStoreCompletion)completion {
    NSDictionary *snapshot=ImmutablePropertyList(record);[self performAsync:^BOOL(NSError **error){return [self historyOnQueue:snapshot immediate:NO error:error];} completion:completion];
}
- (void)flushHistoryWithCompletion:(CSAIReplyStoreCompletion)completion {[self performAsync:^BOOL(NSError **error){return [self flushHistoryOnQueue:error];} completion:completion];}
+ (BOOL)flushPendingHistory:(NSError **)error {
    if(NSThread.isMainThread)return Fail(error,@"请在后台队列准备 AI 历史备份。");
    __block NSError *failure=nil;__block BOOL success=YES;
    CSAIStoreSync(^{
        NSArray<CSAIReplyDiskState *> *states=CSAIStoreDiskStates().objectEnumerator.allObjects;
        for(CSAIReplyDiskState *disk in states){
            if(!disk.dirtyHistory)continue;
            if(!disk.ready){success=NO;failure=disk.error?:CSAIError(1,@"AI 存储未就绪");break;}
            CSAIReplyStore *store=disk.stores.allObjects.firstObject;
            if(!store){success=NO;failure=CSAIError(1,@"无法刷新 AI 历史记录");break;}
            if(![store flushHistoryOnQueue:&failure]){success=NO;break;}
        }
    });
    if(error)*error=failure;return success;
}
// Only offline tools and host regression fixtures use these blocking compatibility methods.
- (BOOL)load {__block BOOL result;CSAIStoreSync(^{result=[self loadOnQueue:NULL];});return result;}
- (BOOL)saveConfiguration:(NSDictionary *)configuration error:(NSError **)error {
    NSDictionary *snapshot=ImmutablePropertyList(configuration);__block BOOL result;__block NSError *failure=nil;
    CSAIStoreSync(^{result=[self saveOnQueue:snapshot expected:nil error:&failure];});if(error)*error=failure;
    if(result)[NSNotificationCenter.defaultCenter postNotificationName:CSAIReplyConfigurationDidChange object:self];return result;
}
- (BOOL)hasHandledMessageID:(NSString *)identifier {@synchronized(self){NSDate *date=self.state[@"handled"][identifier];return date && [date timeIntervalSinceNow]>=-7*86400;}}
- (BOOL)claimMessageIDs:(NSArray<NSString *> *)identifiers error:(NSError **)error {
    NSArray *snapshot=ImmutablePropertyList(identifiers);__block BOOL result;__block NSError *failure=nil;CSAIStoreSync(^{result=[self claimOnQueue:snapshot error:&failure];});if(error)*error=failure;return result;
}
- (BOOL)appendHistory:(NSDictionary *)record error:(NSError **)error {
    NSDictionary *snapshot=ImmutablePropertyList(record);__block BOOL result;__block NSError *failure=nil;CSAIStoreSync(^{result=[self historyOnQueue:snapshot immediate:YES error:&failure];});if(error)*error=failure;return result;
}
@end
