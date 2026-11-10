#import "CSFavoriteVoiceMediaProvider.h"
#import <CommonCrypto/CommonDigest.h>
#include <stdatomic.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

static const NSUInteger CSFavoriteVoiceMaximumBytes=16*1024*1024;
static atomic_uint CSFavoritePendingVoiceDownloads;
BOOL CSFavoriteHasPendingVoiceDownloads(void) { return atomic_load(&CSFavoritePendingVoiceDownloads)>0; }

@interface CSFavoriteVoicePreparation : NSObject
@property(nonatomic, strong) CSFavoriteVoiceContext *context;
@property(nonatomic, strong) NSMutableDictionary<NSString *, id> *subscribers;
@property(nonatomic, copy) NSString *token;
@property(nonatomic) BOOL reading, requestedDownload, downloadFinished;
@end
@implementation CSFavoriteVoicePreparation
- (void)dealloc { if (_requestedDownload) atomic_fetch_sub(&CSFavoritePendingVoiceDownloads,1); }
@end

@interface CSFavoriteVoiceMediaProvider ()
@property(nonatomic, strong) id<CSMessageActionEnvironment> environment;
@property(nonatomic, strong) NSMutableDictionary<NSString *, CSFavoriteVoicePreparation *> *preparations;
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *operationKeys;
@property(nonatomic, strong) dispatch_queue_t queue;
@end

static BOOL CSFavoriteStableAttributes(NSDictionary *before, NSDictionary *after, NSUInteger bytes) {
    if (![before[NSFileType] isEqual:NSFileTypeRegular] || ![after[NSFileType] isEqual:NSFileTypeRegular] ||
        ![before[NSFileSize] isEqual:after[NSFileSize]] || [after[NSFileSize] unsignedLongLongValue]!=bytes ||
        ![before[NSFileModificationDate] isEqual:after[NSFileModificationDate]]) return NO;
    for (NSString *key in @[NSFileSystemNumber,NSFileSystemFileNumber,NSFileCreationDate]) {
        if (!before[key] || !after[key] || ![before[key] isEqual:after[key]]) return NO;
    }
    return YES;
}
static NSData *CSFavoriteBoundedRead(NSString *path, NSDictionary *attributes) {
    int descriptor=open(path.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW);
    if (descriptor<0) return nil;
    struct stat before,after;
    if (fstat(descriptor,&before)!=0 || !S_ISREG(before.st_mode) || before.st_size<=0 ||
        (unsigned long long)before.st_size>CSFavoriteVoiceMaximumBytes ||
        (unsigned long long)before.st_ino!=[attributes[NSFileSystemFileNumber] unsignedLongLongValue] ||
        (unsigned long long)before.st_dev!=[attributes[NSFileSystemNumber] unsignedLongLongValue]) { close(descriptor); return nil; }
    NSMutableData *data=[NSMutableData dataWithLength:(NSUInteger)before.st_size]; NSUInteger used=0;
    while (used<data.length) {
        ssize_t count=read(descriptor,(unsigned char *)data.mutableBytes+used,data.length-used);
        if (count<0 && errno==EINTR) continue;
        if (count<=0) break;
        used+=(NSUInteger)count;
    }
    unsigned char extra; ssize_t trailing;
    do { trailing=read(descriptor,&extra,1); } while (trailing<0 && errno==EINTR);
    BOOL stable=used==data.length && trailing==0 && fstat(descriptor,&after)==0 && before.st_size==after.st_size &&
        before.st_ino==after.st_ino && before.st_dev==after.st_dev &&
        before.st_mtimespec.tv_sec==after.st_mtimespec.tv_sec && before.st_mtimespec.tv_nsec==after.st_mtimespec.tv_nsec &&
        before.st_ctimespec.tv_sec==after.st_ctimespec.tv_sec && before.st_ctimespec.tv_nsec==after.st_ctimespec.tv_nsec;
    close(descriptor);
    return stable ? [data copy] : nil;
}
static BOOL CSFavoriteDataMatchesMD5(NSData *data, NSString *expected) {
    if (!expected.length) return YES;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CC_MD5(data.bytes,(CC_LONG)data.length,digest);
#pragma clang diagnostic pop
    NSMutableString *actual=[NSMutableString stringWithCapacity:32];
    for (NSUInteger i=0;i<sizeof(digest);i++) [actual appendFormat:@"%02x",digest[i]];
    return [actual isEqualToString:expected];
}
static NSArray<NSString *> *CSFavoriteVoicePaths(id field) {
    NSMutableArray *paths=[NSMutableArray array];
    for (NSString *getter in @[@"dataPathForDisplay",@"GetDataPath",@"GetDataPathForFav",@"sourceDataPath"]) {
        id path=CSMessageActionObjectGetter(field,NSSelectorFromString(getter));
        if ([path isKindOfClass:NSString.class] && [path isAbsolutePath] && ![paths containsObject:path]) [paths addObject:[path copy]];
    }
    return [paths copy];
}

@implementation CSFavoriteVoiceMediaProvider
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment {
    if ((self=[super init])) { _environment=environment; _preparations=[NSMutableDictionary dictionary]; _operationKeys=[NSMutableDictionary dictionary]; _queue=dispatch_queue_create("com.wechat.enhance.favorite-voice-media",DISPATCH_QUEUE_SERIAL); }
    return self;
}
- (BOOL)validContext:(CSFavoriteVoiceContext *)context {
    if (!NSThread.isMainThread || !context) return NO;
    @try {
        if (![[self.environment currentAccountID] isEqualToString:context.accountID]) return NO;
        return !self.isContextValid || self.isContextValid(context);
    } @catch (__unused NSException *exception) { return NO; }
}
- (void)finishKey:(NSString *)key resource:(CSMessageVoiceResource *)resource reason:(NSString *)reason {
    CSFavoriteVoicePreparation *task=self.preparations[key]; if (!task) return;
    if (task.requestedDownload) { task.requestedDownload=NO; atomic_fetch_sub(&CSFavoritePendingVoiceDownloads,1); }
    NSDictionary *subscribers=[task.subscribers copy]; [task.subscribers removeAllObjects]; [self.preparations removeObjectForKey:key];
    for (NSString *operation in subscribers) { [self.operationKeys removeObjectForKey:operation]; }
    for (NSString *operation in subscribers) {
        void (^completion)(CSMessageVoiceResource *,NSString *)=subscribers[operation]; completion(resource,reason);
    }
}
- (id)refreshedItemForContext:(CSFavoriteVoiceContext *)context manager:(id)manager {
    if (![self validContext:context]) return nil;
    id item=nil; BOOL lookedUp=NO;
    @try {
        if (context.localID && CSMessageNativeSupports(manager,@"getFavoritesItemByLocalId:",@"@",@[@"I"])) {
            lookedUp=YES; item=CSMessageNativeInvoke(manager,@"getFavoritesItemByLocalId:",@[@(context.localID)]);
            if (item && ![context matchesItem:item]) return nil;
        }
        if (!item && context.favoriteID && CSMessageNativeSupports(manager,@"getFavoritesItemByfavId:",@"@",@[@"I"])) {
            lookedUp=YES; item=CSMessageNativeInvoke(manager,@"getFavoritesItemByfavId:",@[@(context.favoriteID)]);
        }
    } @catch (__unused NSException *exception) { return nil; }
    return lookedUp && [self validContext:context] && [context matchesItem:item] ? item : nil;
}
- (BOOL)sourceIsCurrentForContext:(CSFavoriteVoiceContext *)context {
    if (!NSThread.isMainThread || ![self validContext:context]) return NO;
    id manager=nil;
    @try { manager=[self.environment serviceNamed:@"FavoritesMgr"]; } @catch (__unused NSException *exception) {}
    id item=manager ? [self refreshedItemForContext:context manager:manager] : nil;
    CSFavoriteVoiceContext *current=item ? [CSFavoriteVoiceContext contextWithItem:item accountID:context.accountID accountEpoch:context.accountEpoch] : nil;
    // The final send must still refer to the captured audio metadata, including when
    // the favorite ID and data ID survived an edit or an asynchronous refresh.
    return current && current.durationMilliseconds==context.durationMilliseconds &&
        current.formatKnown==context.formatKnown && current.format==context.format &&
        current.expectedBytes==context.expectedBytes && [current.dataMD5 isEqualToString:context.dataMD5] && [self validContext:context];
}
- (void)requestDownloadForKey:(NSString *)key item:(id)item manager:(id)manager {
    CSFavoriteVoicePreparation *task=self.preparations[key]; if (!task) return;
    if (task.downloadFinished || ![self validContext:task.context] || ![task.context matchesItem:item]) {
        [self finishKey:key resource:nil reason:@"收藏语音文件未就绪，请重新打开收藏后重试"]; return;
    }
    if (task.requestedDownload) return;
    id field=[task.context dataItemInItem:item];
    id url=CSMessageActionObjectGetter(field,NSSelectorFromString(@"cdnDataUrl"));
    id secret=CSMessageActionObjectGetter(field,NSSelectorFromString(@"cdnDataKey"));
    if (![url isKindOfClass:NSString.class] || ![url length] || ![secret isKindOfClass:NSString.class] || ![secret length] ||
        !CSMessageNativeSupports(manager,@"startDownloadFavoritesItem:IsPriority:",@"v",@[@"@",@"B"])) {
        [self finishKey:key resource:nil reason:@"收藏语音尚未下载，请先播放后重试"]; return;
    }
    task.requestedDownload=YES; atomic_fetch_add(&CSFavoritePendingVoiceDownloads,1);
    if (self.waitingHandler) for (NSString *operation in task.subscribers.allKeys) self.waitingHandler(operation);
    if (self.preparations[key]!=task) return;
    if (![self validContext:task.context]) { [self finishKey:key resource:nil reason:@"账号或收藏状态已变化，请重新操作"]; return; }
    @try { CSMessageNativeInvoke(manager,@"startDownloadFavoritesItem:IsPriority:",@[item,@YES]); }
    @catch (__unused NSException *exception) { [self finishKey:key resource:nil reason:@"无法下载收藏语音，请稍后重试"]; }
}
- (void)readKey:(NSString *)key {
    CSFavoriteVoicePreparation *task=self.preparations[key]; if (!task || task.reading) return;
    if (![self validContext:task.context]) { [self finishKey:key resource:nil reason:@"账号或收藏状态已变化，请重新操作"]; return; }
    id manager=nil;
    @try { manager=[self.environment serviceNamed:@"FavoritesMgr"]; } @catch (__unused NSException *exception) {}
    if (self.preparations[key]!=task) return;
    if (!manager || ![self validContext:task.context]) { [self finishKey:key resource:nil reason:@"收藏服务暂不可用，请重新操作"]; return; }
    id item=[self refreshedItemForContext:task.context manager:manager];
    if (self.preparations[key]!=task) return;
    if (!item) { [self finishKey:key resource:nil reason:@"原收藏已变化或不可用，请重新打开收藏"]; return; }
    CSFavoriteVoiceContext *live=[CSFavoriteVoiceContext contextWithItem:item accountID:task.context.accountID accountEpoch:task.context.accountEpoch];
    if (!live || !live.formatKnown || !live.durationMilliseconds || live.expectedBytes>CSFavoriteVoiceMaximumBytes) {
        [self finishKey:key resource:nil reason:@"收藏语音格式、时长或文件大小不支持转发"]; return;
    }
    NSArray *paths=CSFavoriteVoicePaths(live.dataItem);
    if (![self validContext:task.context]) { [self finishKey:key resource:nil reason:@"账号或收藏状态已变化，请重新操作"]; return; }
    task.reading=YES;
    NSArray *snapshot=[paths copy]; NSString *md5=[live.dataMD5 copy], *token=[task.token copy];
    unsigned int expected=live.expectedBytes,duration=live.durationMilliseconds,format=live.format;
    __weak typeof(self) weakSelf=self;
    // Native models stay on main. Only immutable paths/metadata and copied file bytes enter IO.
    dispatch_async(self.queue,^{
        @autoreleasepool {
            NSData *bytes=nil; NSString *failure=nil, *readPath=nil; BOOL hadFile=NO;
            for (NSString *path in snapshot) {
                NSDictionary *before=[NSFileManager.defaultManager attributesOfItemAtPath:path error:NULL];
                if (!before) continue;
                hadFile=YES;
                if (![before[NSFileType] isEqual:NSFileTypeRegular] || ![before fileSize] || [before fileSize]>CSFavoriteVoiceMaximumBytes) { failure=@"收藏语音文件大小或类型不正确"; continue; }
                NSData *candidate=CSFavoriteBoundedRead(path,before);
                NSDictionary *after=[NSFileManager.defaultManager attributesOfItemAtPath:path error:NULL];
                if (!candidate.length || !CSFavoriteStableAttributes(before,after,candidate.length)) { failure=@"收藏语音文件仍在更新或不可读取，请稍后重试"; continue; }
                if ((expected && candidate.length!=expected) || !CSFavoriteDataMatchesMD5(candidate,md5)) { failure=@"收藏语音数据不完整，请先播放后重试"; continue; }
                bytes=candidate; readPath=path; break;
            }
            dispatch_async(dispatch_get_main_queue(),^{
                typeof(self) self=weakSelf; CSFavoriteVoicePreparation *current=self.preparations[key];
                if (!self || ![current.token isEqualToString:token]) return;
                current.reading=NO;
                if (![self validContext:current.context]) { [self finishKey:key resource:nil reason:@"账号或收藏状态已变化，请重新操作"]; return; }
                // Re-read identity after IO. Cached sourceItem is never accepted as proof of ownership.
                id currentManager=nil;
                @try { currentManager=[self.environment serviceNamed:@"FavoritesMgr"]; } @catch (__unused NSException *exception) {}
                id currentItem=[self refreshedItemForContext:current.context manager:currentManager];
                if (self.preparations[key]!=current) return;
                if (!currentItem) { [self finishKey:key resource:nil reason:@"原收藏已变化或不可用，请重新打开收藏"]; return; }
                if (!bytes) {
                    if (hadFile) [self finishKey:key resource:nil reason:failure ?: @"收藏语音文件不可读取"];
                    else [self requestDownloadForKey:key item:currentItem manager:currentManager];
                    return;
                }
                CSFavoriteVoiceContext *after=[CSFavoriteVoiceContext contextWithItem:currentItem accountID:current.context.accountID accountEpoch:current.context.accountEpoch];
                if (!after || !after.formatKnown || after.format!=format || after.durationMilliseconds!=duration ||
                    after.expectedBytes!=expected || ![after.dataMD5 isEqualToString:md5] || ![CSFavoriteVoicePaths(after.dataItem) containsObject:readPath]) {
                    [self finishKey:key resource:nil reason:@"收藏语音信息已变化，请重新操作"]; return;
                }
                NSString *reason=nil;
                CSMessageVoiceResource *resource=CSMessageValidateVoiceData(bytes,duration,format,YES,expected,&reason);
                if (resource && resource.format!=format) { resource=nil; reason=@"收藏语音格式与音频内容不一致"; }
                if (![self validContext:current.context]) { [self finishKey:key resource:nil reason:@"账号或收藏状态已变化，请重新操作"]; return; }
                [self finishKey:key resource:resource reason:resource ? nil : (reason ?: @"收藏语音内容无法转发")];
            });
        }
    });
}
- (void)prepareContext:(CSFavoriteVoiceContext *)context operationID:(NSString *)operationID completion:(void (^)(CSMessageVoiceResource *,NSString *))completion {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self prepareContext:context operationID:operationID completion:completion]; }); return; }
    if (!completion) return;
    if (!operationID.length || ![self validContext:context]) { completion(nil,@"账号或收藏状态已变化，请重新操作"); return; }
    NSString *key=context.stableIdentity, *old=self.operationKeys[operationID];
    if (old && ![old isEqualToString:key]) [self cancelOperationID:operationID];
    CSFavoriteVoicePreparation *task=self.preparations[key];
    if (!task) {
        if (self.preparations.count>=32) { completion(nil,@"正在处理的收藏语音过多，请稍后重试"); return; }
        task=[CSFavoriteVoicePreparation new]; task.context=context; task.subscribers=[NSMutableDictionary dictionary]; task.token=NSUUID.UUID.UUIDString; self.preparations[key]=task;
        NSString *token=[task.token copy]; __weak typeof(self) weakSelf=self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,60*NSEC_PER_SEC),dispatch_get_main_queue(),^{
            typeof(self) self=weakSelf; if ([self.preparations[key].token isEqualToString:token]) [self finishKey:key resource:nil reason:@"收藏语音准备超时，请稍后重试"];
        });
    }
    if (task.subscribers.count>=64 && !task.subscribers[operationID]) { completion(nil,@"正在处理的转发操作过多，请稍后重试"); return; }
    task.subscribers[operationID]=[completion copy]; self.operationKeys[operationID]=key;
    if (task.requestedDownload) { if (self.waitingHandler) self.waitingHandler(operationID); }
    else [self readKey:key];
}
- (void)cancelOperationID:(NSString *)operationID {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self cancelOperationID:operationID]; }); return; }
    NSString *key=self.operationKeys[operationID]; if (!key) return;
    CSFavoriteVoicePreparation *task=self.preparations[key]; [task.subscribers removeObjectForKey:operationID]; [self.operationKeys removeObjectForKey:operationID];
    if (!task.subscribers.count) {
        if (task.requestedDownload) { task.requestedDownload=NO; atomic_fetch_sub(&CSFavoritePendingVoiceDownloads,1); }
        [self.preparations removeObjectForKey:key];
    }
}
- (void)downloadFinishedForItem:(id)item error:(int)error accountID:(NSString *)accountID epoch:(NSUInteger)epoch {
    if (!NSThread.isMainThread) return; // The hook marshals native event objects to main.
    for (NSString *key in self.preparations.allKeys) {
        CSFavoriteVoicePreparation *task=self.preparations[key]; CSFavoriteVoiceContext *context=task.context;
        if (!task.requestedDownload || task.downloadFinished || context.accountEpoch!=epoch || ![context.accountID isEqualToString:accountID] || ![context matchesItem:item]) continue;
        if (![self validContext:context]) { [self finishKey:key resource:nil reason:@"账号或收藏状态已变化，请重新操作"]; continue; }
        if (error!=0) { [self finishKey:key resource:nil reason:@"收藏语音下载失败，请稍后重试"]; continue; }
        task.downloadFinished=YES; [self readKey:key];
    }
}
- (void)cancelAll {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self cancelAll]; }); return; }
    for (CSFavoriteVoicePreparation *task in self.preparations.allValues) if (task.requestedDownload) { task.requestedDownload=NO; atomic_fetch_sub(&CSFavoritePendingVoiceDownloads,1); }
    [self.preparations removeAllObjects]; [self.operationKeys removeAllObjects];
}
@end
