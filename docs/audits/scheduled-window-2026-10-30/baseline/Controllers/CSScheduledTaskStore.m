#import "CSScheduledTaskStore.h"
#include <math.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/file.h>
#include <sys/stat.h>
#import <TargetConditionals.h>
#import <CommonCrypto/CommonDigest.h>
#if TARGET_OS_IPHONE || defined(CS_SCHEDULED_STORE_TRACK_MUTATIONS)
#import "CSBackupMutation.h"
#endif
NSString *const CSScheduledTaskErrorDomain=@"CSScheduledTaskError";
NSNotificationName const CSScheduledTaskConfigurationDidChange=@"CSScheduledTaskConfigurationDidChange";
NSString *const CSScheduledTaskBackupDomain=@"scheduled";
static NSError *CSTaskError(NSString *text) { return [NSError errorWithDomain:CSScheduledTaskErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey:text}]; }
static BOOL CSString(id v, NSUInteger max) { return [v isKindOfClass:NSString.class] && [v length]>0 && [v length]<=max; }
static BOOL CSInteger(id v, NSInteger low, NSInteger high) { return [v isKindOfClass:NSNumber.class] && isfinite([v doubleValue]) && [v doubleValue]==[v integerValue] && [v integerValue]>=low && [v integerValue]<=high; }
static NSArray *CSDefinitionKeys(void) {
    return @[@"id",@"title",@"target",@"text",@"enabled",@"catchUp",@"mode",@"anchor",@"zone",@"interval",@"hour",@"minute",@"weekdays"];
}
NSURL *CSScheduledTaskFileURL(NSURL *resourceRoot, NSString *account) {
    NSData *data=[account dataUsingEncoding:NSUTF8StringEncoding]; unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes,(CC_LONG)data.length,hash); NSMutableString *name=[NSMutableString string];
    for (NSUInteger i=0;i<sizeof(hash);i++) [name appendFormat:@"%02x",hash[i]];
    return [resourceRoot URLByAppendingPathComponent:[NSString stringWithFormat:@"ScheduledTasks/%@.plist",name]];
}
NSDictionary *CSScheduledTaskBackupConfiguration(NSDictionary *state) {
    NSMutableArray *tasks=[NSMutableArray array];
    for (NSDictionary *task in state[@"tasks"]) {
        NSMutableDictionary *definition=[NSMutableDictionary dictionary];
        for (NSString *key in CSDefinitionKeys()) if (task[key]) definition[key]=task[key];
        [tasks addObject:definition];
    }
    return @{@"schema":@1,@"account":state[@"account"],@"enabled":state[@"enabled"],@"tasks":tasks};
}
BOOL CSScheduledTaskBackupValueValidate(id value, NSString *account, NSError **error) {
    BOOL ok=[value isKindOfClass:NSDictionary.class]; NSDictionary *state=ok?value:nil;
    if (ok) ok=CSString(account,256) && [state[@"schema"] isEqual:@1] && [state[@"account"] isEqual:account] && CSInteger(state[@"enabled"],0,1) && [state[@"tasks"] isKindOfClass:NSArray.class] && [state[@"tasks"] count]<=100;
    BOOL runtime=state[@"history"]!=nil;
    if (ok) for (id key in state) if (![@[@"schema",@"account",@"enabled",@"tasks",@"history"] containsObject:key]) { ok=NO; break; }
    NSMutableSet *ids=[NSMutableSet set];
    if (ok) for (id task in state[@"tasks"]) {
        if (!CSScheduledTaskValidate(task,NULL) || !CSInteger(task[@"enabled"],0,1) || !CSInteger(task[@"catchUp"],0,1) || [ids containsObject:task[@"id"]]) { ok=NO; break; }
        [ids addObject:task[@"id"]];
        for (id key in task) if (![CSDefinitionKeys() containsObject:key] && !(runtime && [@[@"nextRun",@"lastOccurrence"] containsObject:key])) { ok=NO; break; }
        for (NSString *key in @[@"nextRun",@"lastOccurrence"]) if (task[key] && (![task[key] isKindOfClass:NSDate.class] || !isfinite([task[key] timeIntervalSince1970]))) ok=NO;
        // Paused restored definitions get their nextRun only when explicitly enabled.
        if (runtime && [state[@"enabled"] boolValue] && [task[@"enabled"] boolValue] && !task[@"nextRun"]) ok=NO;
        if (!ok) break;
    }
    if (ok && runtime) {
        ok=[state[@"history"] isKindOfClass:NSArray.class] && [state[@"history"] count]<=50;
        if (ok) for (id h in state[@"history"]) if (![h isKindOfClass:NSDictionary.class] || !CSString(h[@"id"],80) || !CSString(h[@"result"],40) || !CSString(h[@"title"],80) || !CSString(h[@"detail"],512) || ![h[@"date"] isKindOfClass:NSDate.class]) { ok=NO; break; }
    }
    if (ok) ok=[NSPropertyListSerialization propertyList:state isValidForFormat:NSPropertyListBinaryFormat_v1_0];
    if (!ok && error) *error=CSTaskError(@"定时任务数据无法校验或所属账号不匹配，原文件已保留。");
    return ok;
}
BOOL CSScheduledTaskValidate(NSDictionary *t, NSError **error) {
    BOOL ok=[t isKindOfClass:NSDictionary.class];
    if (ok) ok=CSString(t[@"id"],80) && CSString(t[@"title"],80) && CSString(t[@"target"],256) && CSString(t[@"text"],4000) && [t[@"text"] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length &&
        [t[@"enabled"] isKindOfClass:NSNumber.class] && [t[@"catchUp"] isKindOfClass:NSNumber.class] && [t[@"anchor"] isKindOfClass:NSDate.class] && isfinite([t[@"anchor"] timeIntervalSince1970]) &&
        CSString(t[@"zone"],100) && [NSTimeZone timeZoneWithName:t[@"zone"]] && [@[@"once",@"minutes",@"hours",@"daily",@"weekly"] containsObject:t[@"mode"]];
    if (ok && [@[@"minutes",@"hours"] containsObject:t[@"mode"]]) ok=CSInteger(t[@"interval"],1,[t[@"mode"] isEqual:@"minutes"]?1440:168);
    if (ok && [@[@"daily",@"weekly"] containsObject:t[@"mode"]]) ok=CSInteger(t[@"hour"],0,23) && CSInteger(t[@"minute"],0,59);
    if (ok && [t[@"mode"] isEqual:@"weekly"]) {
        ok=[t[@"weekdays"] isKindOfClass:NSArray.class] && [t[@"weekdays"] count]>0 && [t[@"weekdays"] count]<=7;
        if (ok) for (id day in t[@"weekdays"]) if (!CSInteger(day,1,7)) { ok=NO; break; }
    }
    if (!ok && error) *error=CSTaskError(@"任务配置无效：请检查会话、文字和时间规则。");
    return ok;
}
static NSDate *CSCalendarOccurrence(NSDictionary *t, NSDate *pivot, BOOL backward) {
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; calendar.timeZone=[NSTimeZone timeZoneWithName:t[@"zone"]];
    NSArray *days=[t[@"mode"] isEqual:@"weekly"]?t[@"weekdays"]:@[@0]; NSDate *best=nil;
    for (NSNumber *day in days) {
        NSDateComponents *c=[NSDateComponents new]; c.hour=[t[@"hour"] integerValue]; c.minute=[t[@"minute"] integerValue]; c.second=0; if (day.integerValue) c.weekday=day.integerValue;
        NSDate *d=[calendar nextDateAfterDate:pivot matchingComponents:c options:NSCalendarMatchNextTime|NSCalendarMatchFirst|(backward?NSCalendarSearchBackwards:0)];
        // A backwards search picks the second occurrence in a DST fold on Darwin.
        // Normalize within that local day using the same forward rule as Next.
        if (backward && d) d=[calendar nextDateAfterDate:[[calendar startOfDayForDate:d] dateByAddingTimeInterval:-0.001] matchingComponents:c options:NSCalendarMatchNextTime|NSCalendarMatchFirst];
        if (d && [d compare:t[@"anchor"]]!=NSOrderedAscending && (!best || (backward?[d compare:best]==NSOrderedDescending:[d compare:best]==NSOrderedAscending))) best=d;
    }
    return best;
}
NSDate *CSScheduledTaskNext(NSDictionary *t, NSDate *after) {
    if (!CSScheduledTaskValidate(t,NULL)) return nil;
    NSDate *anchor=t[@"anchor"]; NSString *mode=t[@"mode"];
    if ([mode isEqual:@"once"]) return [anchor compare:after]==NSOrderedDescending?anchor:nil;
    if ([mode isEqual:@"minutes"] || [mode isEqual:@"hours"]) {
        double period=[t[@"interval"] doubleValue]*([mode isEqual:@"minutes"]?60:3600);
        double n=fmax(0,floor([after timeIntervalSinceDate:anchor]/period)+1); return [anchor dateByAddingTimeInterval:n*period];
    }
    NSDate *pivot=[after compare:anchor]==NSOrderedAscending?[anchor dateByAddingTimeInterval:-0.001]:after;
    return CSCalendarOccurrence(t,pivot,NO);
}
NSDate *CSScheduledTaskLatest(NSDictionary *t, NSDate *now) {
    if (!CSScheduledTaskValidate(t,NULL) || [now compare:t[@"anchor"]]==NSOrderedAscending) return nil;
    NSString *mode=t[@"mode"]; NSDate *anchor=t[@"anchor"];
    if ([mode isEqual:@"once"]) return anchor;
    if ([mode isEqual:@"minutes"] || [mode isEqual:@"hours"]) {
        double period=[t[@"interval"] doubleValue]*([mode isEqual:@"minutes"]?60:3600);
        return [anchor dateByAddingTimeInterval:floor([now timeIntervalSinceDate:anchor]/period)*period];
    }
    return CSCalendarOccurrence(t,[now dateByAddingTimeInterval:0.001],YES);
}
NSString *CSScheduledTaskRuleDescription(NSDictionary *t) {
    NSString *mode=t[@"mode"];
    if ([mode isEqual:@"minutes"]) return [NSString stringWithFormat:@"每 %@ 分钟",t[@"interval"]];
    if ([mode isEqual:@"hours"]) return [NSString stringWithFormat:@"每 %@ 小时",t[@"interval"]];
    if ([mode isEqual:@"once"]) return @"单次";
    NSString *prefix=@"每天";
    if ([mode isEqual:@"weekly"]) { NSMutableArray *days=[NSMutableArray array]; NSArray *names=@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]; for (NSNumber *d in t[@"weekdays"]) if (d.integerValue>=1 && d.integerValue<=7) [days addObject:names[d.integerValue-1]]; prefix=[@"每周" stringByAppendingString:[days componentsJoinedByString:@"、"]]; }
    return [NSString stringWithFormat:@"%@ %02ld:%02ld（%@）",prefix,(long)[t[@"hour"] integerValue],(long)[t[@"minute"] integerValue],t[@"zone"]?:@""];
}
static void *CSTaskStoreQueueKey=&CSTaskStoreQueueKey;
static dispatch_queue_t CSTaskStoreQueue(void) {
    static dispatch_queue_t queue;static dispatch_once_t once;
    dispatch_once(&once,^{queue=dispatch_queue_create("com.wechatimprove.scheduled-store",DISPATCH_QUEUE_SERIAL);dispatch_queue_set_specific(queue,CSTaskStoreQueueKey,CSTaskStoreQueueKey,NULL);});return queue;
}
static void CSTaskStoreSync(dispatch_block_t work) {
    if(dispatch_get_specific(CSTaskStoreQueueKey)){work();return;}
    // Compatibility callers may wait, but their filesystem work still belongs
    // to the store queue; dispatch_sync can execute on the waiting thread.
    dispatch_semaphore_t finished=dispatch_semaphore_create(0);
    dispatch_async(CSTaskStoreQueue(),^{@autoreleasepool{work();}dispatch_semaphore_signal(finished);});
    dispatch_semaphore_wait(finished,DISPATCH_TIME_FOREVER);
}
static NSHashTable<CSScheduledTaskStore *> *CSTaskLiveStores(void) {static NSHashTable *stores;static dispatch_once_t once;dispatch_once(&once,^{stores=NSHashTable.weakObjectsHashTable;});return stores;}
static id CSTaskFreeze(id value) {return value?CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault,(__bridge CFPropertyListRef)value,kCFPropertyListImmutable)):nil;}
static NSError *CSTaskCancelled(void) {return CSTaskError(@"账号或任务状态已改变，本次操作已取消。");}
@interface CSScheduledTaskStore ()
@property NSURL *url;
@property NSString *account;
@property NSDictionary *state;
@property NSError *queueError;
@property int lockFD;
@property BOOL queueReady;
@property NSDictionary *snapshotState;
@property NSError *snapshotError;
@property BOOL snapshotReady,invalidated;
@property NSUInteger generation;
@end
@implementation CSScheduledTaskStore

+ (NSDictionary *)readStateAtURL:(NSURL *)url account:(NSString *)account error:(NSError **)error {
    int fd=open(url.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW|O_NONBLOCK);
    if (fd<0) { if (errno!=ENOENT && error) *error=[NSError errorWithDomain:NSPOSIXErrorDomain code:errno userInfo:@{NSFilePathErrorKey:url.path}]; return nil; }
    struct stat metadata; BOOL ok=fstat(fd,&metadata)==0 && S_ISREG(metadata.st_mode) && metadata.st_size>=0 && metadata.st_size<=4*1024*1024;
    NSMutableData *data=ok?[NSMutableData dataWithLength:(NSUInteger)metadata.st_size]:nil; NSUInteger offset=0;
    while (ok && offset<data.length) { ssize_t count=read(fd,(char *)data.mutableBytes+offset,data.length-offset); if (count<0 && errno==EINTR) continue; if (count<=0) { ok=NO; break; } offset+=(NSUInteger)count; }
    close(fd);
    id state=ok?[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error]:nil;
    if (![state isKindOfClass:NSDictionary.class] || !state[@"history"] || !CSScheduledTaskBackupValueValidate(state,account,error)) {
        if (error && !*error) *error=CSTaskError(@"定时任务文件无法读取或校验，已保留原文件。"); return nil;
    }
    return state;
}
+ (BOOL)replaceStateOnQueue:(NSDictionary *)state atURL:(NSURL *)url account:(NSString *)account error:(NSError **)error {
    if (state && !CSScheduledTaskBackupValueValidate(state,account,error)) return NO;
    if (state && !state[@"history"]) { if (error) *error=CSTaskError(@"定时任务恢复状态不完整，未覆盖原文件。"); return NO; }
    CSScheduledTaskStore *writer=[[self alloc] initWithURL:url account:account];
    if (![writer acquireLock]) { if (error) *error=writer.queueError; return NO; }
    struct stat metadata; int status=lstat(url.fileSystemRepresentation,&metadata);
    if ((!status && !S_ISREG(metadata.st_mode)) || (status && errno!=ENOENT)) { if (error) *error=CSTaskError(@"定时任务文件不是可写的普通文件，原文件已保留。"); return NO; }
    if (state) { BOOL ok=[writer persist:state]; if (!ok && error) *error=writer.queueError; return ok; }
#if TARGET_OS_IPHONE || defined(CS_SCHEDULED_STORE_TRACK_MUTATIONS)
    CSBackupResourceMutationScope();
#endif
    BOOL ok=status || unlink(url.fileSystemRepresentation)==0;
    int fd=open(url.URLByDeletingLastPathComponent.fileSystemRepresentation,O_RDONLY); ok=ok && fd>=0 && fsync(fd)==0; if (fd>=0) close(fd);
    if (!ok && error) *error=CSTaskError(@"定时任务重置未完成，请检查写入权限后重试。"); return ok;
}
- (instancetype)initWithURL:(NSURL *)url account:(NSString *)account { if ((self=[super init])) { _url=url; _account=[account copy]; _lockFD=-1; } return self; }
- (void)dealloc {int fd=_lockFD;if(fd>=0){dispatch_block_t closeLock=^{flock(fd,LOCK_UN);close(fd);};if(dispatch_get_specific(CSTaskStoreQueueKey))closeLock();else dispatch_async(CSTaskStoreQueue(),closeLock);}}
- (BOOL)queueEnabled {return [_state[@"enabled"] boolValue];}
- (NSArray *)queueTasks {return _state[@"tasks"]?:@[];}
- (NSArray *)queueHistory {return _state[@"history"]?:@[];}
- (BOOL)enabled {@synchronized(self){return [self.snapshotState[@"enabled"] boolValue];}}
- (BOOL)ready {@synchronized(self){return self.snapshotReady && !self.invalidated;}}
- (NSArray *)tasks {@synchronized(self){return self.snapshotState[@"tasks"]?:@[];}}
- (NSArray *)history {@synchronized(self){return self.snapshotState[@"history"]?:@[];}}
- (NSError *)error {@synchronized(self){return self.snapshotError;}}
- (void)publish {@synchronized(self){if(!self.invalidated){self.snapshotState=self.state;self.snapshotReady=self.queueReady;self.snapshotError=self.queueError;}}}
- (BOOL)validGeneration:(NSUInteger)generation {@synchronized(self){return !self.invalidated && generation==self.generation;}}
- (void)invalidate {
    @synchronized(self){
        if(self.invalidated)return;self.invalidated=YES;self.generation++;self.snapshotReady=NO;
        dispatch_async(CSTaskStoreQueue(),^{if(self.lockFD>=0){flock(self.lockFD,LOCK_UN);close(self.lockFD);self.lockFD=-1;}self.queueReady=NO;});
    }
}
- (void)performAsync:(id(^)(NSError **))work drainFinish:(BOOL)drain completion:(void(^)(id,NSError *))completion {
    @synchronized(self){
        if(self.invalidated){if(completion)dispatch_async(dispatch_get_main_queue(),^{completion(nil,CSTaskCancelled());});return;}
        NSUInteger generation=self.generation;
        dispatch_async(CSTaskStoreQueue(),^{@autoreleasepool{
            NSError *error=nil;id result=nil;
            if(drain || [self validGeneration:generation]){result=work(&error);[self publish];}else error=CSTaskCancelled();
            if(completion)dispatch_async(dispatch_get_main_queue(),^{if(![self validGeneration:generation])completion(nil,CSTaskCancelled());else completion(result,error);});
        }});
    }
}
- (BOOL)persist:(NSDictionary *)state {
#if TARGET_OS_IPHONE || defined(CS_SCHEDULED_STORE_TRACK_MUTATIONS)
    CSBackupResourceMutationScope();
#endif
    NSError *error=nil; NSData *data=[NSPropertyListSerialization dataWithPropertyList:state format:NSPropertyListBinaryFormat_v1_0 options:0 error:&error];
    NSDataWritingOptions options=NSDataWritingAtomic;
#if TARGET_OS_IOS
    options|=NSDataWritingFileProtectionCompleteUntilFirstUserAuthentication;
#endif
    BOOL ok=data && [data writeToURL:_url options:options error:&error];
    // Flush the replacement and directory before authorizing a native send.
    if (ok) { int fd=open(_url.fileSystemRepresentation,O_RDONLY); ok=fd>=0 && fchmod(fd,0600)==0 && fsync(fd)==0; if (fd>=0) close(fd); }
    if (ok) { int fd=open(_url.URLByDeletingLastPathComponent.fileSystemRepresentation,O_RDONLY); ok=fd>=0 && fsync(fd)==0; if (fd>=0) close(fd); }
    if (!ok) { _queueReady=NO; _queueError=error?:CSTaskError(@"无法保存任务执行记录，本次未继续发送。请检查存储空间或写入权限。"); return NO; }
    _state=CSTaskFreeze(state); _queueError=nil; _queueReady=YES; return YES;
}
- (BOOL)loadOnQueue {
    [CSTaskLiveStores() addObject:self];
    _queueReady=NO;
    if (![self acquireLock]) return NO;
    NSError *error=nil; NSDictionary *state=[self.class readStateAtURL:_url account:_account error:&error];
    if (!state) {
        if (error) { _queueError=error; return NO; }
        return [self persist:@{@"schema":@1,@"account":_account,@"enabled":@NO,@"tasks":@[],@"history":@[]}];
    }
    _state=state; _queueError=nil; _queueReady=YES;
    NSMutableArray *history=[self.queueHistory mutableCopy]; BOOL changed=NO;
    for (NSUInteger i=0;i<history.count;i++) if ([history[i][@"result"] isEqual:@"submitting"]) { NSMutableDictionary *h=[history[i] mutableCopy]; h[@"result"]=@"unknown"; h[@"detail"]=@"上次发送期间进程退出，结果未确认；不会自动重发。"; history[i]=h; changed=YES; }
    if (changed) { NSMutableDictionary *s=[_state mutableCopy]; s[@"history"]=history; return [self persist:s]; } return YES;
}
- (BOOL)acquireLock {
    NSError *error=nil;
    if (!CSString(_account,256) || ![NSFileManager.defaultManager createDirectoryAtURL:_url.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:&error]) { _queueError=error?:CSTaskError(@"账号尚未就绪。"); return NO; }
    if (_lockFD<0) { _lockFD=open([[_url.path stringByAppendingString:@".lock"] fileSystemRepresentation],O_CREAT|O_RDWR|O_NOFOLLOW|O_NONBLOCK,0600); if (_lockFD<0 || flock(_lockFD,LOCK_EX|LOCK_NB)!=0) { if (_lockFD>=0) close(_lockFD); _lockFD=-1; _queueError=CSTaskError(@"任务数据正被其他实例使用，请完全退出微信后重新打开。"); return NO; } }
    return YES;
}
- (BOOL)persistConfiguration:(NSDictionary *)state {
    if (![self persist:state]) return NO;
    return YES;
}
- (BOOL)setEnabledOnQueue:(BOOL)enabled now:(NSDate *)now {
    if (!_queueReady) return NO;
    NSMutableDictionary *s=[_state mutableCopy]; s[@"enabled"]=@(enabled);
    // Explicit enabling never replays occurrences while the master switch was off.
    if (enabled && !self.queueEnabled) { NSMutableArray *tasks=[NSMutableArray array]; for (NSDictionary *t in self.queueTasks) { NSMutableDictionary *m=[t mutableCopy]; NSDate *next=CSScheduledTaskNext(t,now); if (next) m[@"nextRun"]=next; else { [m removeObjectForKey:@"nextRun"]; m[@"enabled"]=@NO; } [tasks addObject:m]; } s[@"tasks"]=tasks; }
    return [self persistConfiguration:s];
}
- (BOOL)saveTaskOnQueue:(NSDictionary *)task now:(NSDate *)now {
    if (!_queueReady) return NO;
    NSError *error=nil; if (!CSScheduledTaskValidate(task,&error)) { _queueError=error; return NO; }
    NSMutableArray *tasks=[self.queueTasks mutableCopy]; NSUInteger index=[tasks indexOfObjectPassingTest:^BOOL(NSDictionary *t,NSUInteger i,BOOL *stop){ (void)i;(void)stop; return [t[@"id"] isEqual:task[@"id"]]; }];
    if (index==NSNotFound && tasks.count>=100) { _queueError=CSTaskError(@"最多保存 100 个定时任务。"); return NO; }
    NSMutableDictionary *m=[task mutableCopy]; [m removeObjectForKey:@"lastOccurrence"]; [m removeObjectForKey:@"nextRun"];
    NSDate *last=index==NSNotFound?nil:tasks[index][@"lastOccurrence"];
    if (last) m[@"lastOccurrence"]=last;
    NSDate *pivot=last && [last compare:now]==NSOrderedDescending?last:now;
    NSDate *next=CSScheduledTaskNext(m,pivot); if (!next && [m[@"enabled"] boolValue]) { _queueError=CSTaskError(@"请选择未来的执行时间。"); return NO; } if (next) m[@"nextRun"]=next;
    if (index==NSNotFound) [tasks addObject:m]; else tasks[index]=m;
    NSMutableDictionary *s=[_state mutableCopy]; s[@"tasks"]=tasks; return [self persistConfiguration:s];
}
- (BOOL)removeTaskOnQueue:(NSString *)identifier { if (!_queueReady) return NO; NSMutableArray *tasks=[self.queueTasks mutableCopy]; NSIndexSet *indices=[tasks indexesOfObjectsPassingTest:^BOOL(NSDictionary *t,NSUInteger i,BOOL *stop){ (void)i;(void)stop; return [t[@"id"] isEqual:identifier]; }]; [tasks removeObjectsAtIndexes:indices]; NSMutableDictionary *s=[_state mutableCopy]; s[@"tasks"]=tasks; return [self persistConfiguration:s]; }
- (NSDictionary *)claimTaskOnQueue:(NSString *)identifier now:(NSDate *)now {
    if (!self.queueEnabled || !_queueReady) return nil;
    NSMutableArray *tasks=[self.queueTasks mutableCopy]; NSUInteger i=[tasks indexOfObjectPassingTest:^BOOL(NSDictionary *t,NSUInteger index,BOOL *stop){ (void)index;(void)stop; return [t[@"id"] isEqual:identifier]; }]; if (i==NSNotFound) return nil;
    NSDictionary *task=tasks[i]; NSDate *due=task[@"nextRun"]; if (![task[@"enabled"] boolValue] || !due || [due compare:now]==NSOrderedDescending) return nil;
    NSDate *occurrence=CSScheduledTaskLatest(task,now); if (!occurrence) return nil;
    BOOL duplicate=task[@"lastOccurrence"] && [occurrence compare:task[@"lastOccurrence"]]!=NSOrderedDescending;
    NSTimeInterval late=[now timeIntervalSinceDate:occurrence]; BOOL send=!duplicate && (late<=30 || ([task[@"catchUp"] boolValue] && late<=600));
    NSMutableDictionary *t=[task mutableCopy]; NSDate *base=duplicate?task[@"lastOccurrence"]:now; NSDate *next=CSScheduledTaskNext(t,base);
    if (next) t[@"nextRun"]=next; else { [t removeObjectForKey:@"nextRun"]; t[@"enabled"]=@NO; } if (!duplicate) t[@"lastOccurrence"]=occurrence; tasks[i]=t;
    NSString *claimID=NSUUID.UUID.UUIDString;
    NSMutableArray *history=[self.queueHistory mutableCopy]; [history insertObject:@{@"id":claimID,@"taskID":identifier,@"title":task[@"title"],@"date":now,@"occurrence":occurrence,@"result":send?@"submitting":@"skipped",@"detail":send?@"已记录发送意图":@"已跳过错过或重复的执行时间"} atIndex:0]; while (history.count>50) [history removeLastObject];
    NSMutableDictionary *s=[_state mutableCopy]; s[@"tasks"]=tasks; s[@"history"]=history;
    if (![self persist:s] || !send) return nil;
    return @{@"id":claimID,@"task":task,@"taskAfterClaim":[t copy],@"account":_account,@"occurrence":occurrence};
}
- (BOOL)finishClaimOnQueue:(NSString *)claimID result:(NSString *)result detail:(NSString *)detail {
    if (!_queueReady) return NO; NSMutableArray *history=[self.queueHistory mutableCopy]; BOOL found=NO;
    for (NSUInteger i=0;i<history.count;i++) if ([history[i][@"id"] isEqual:claimID] && [history[i][@"result"] isEqual:@"submitting"]) { NSMutableDictionary *h=[history[i] mutableCopy]; h[@"result"]=result; h[@"detail"]=detail; history[i]=h; found=YES; break; }
    if (!found) return NO; NSMutableDictionary *s=[_state mutableCopy]; s[@"history"]=history; return [self persist:s];
}
- (void)loadWithCompletion:(CSScheduledTaskStoreCompletion)completion {
    [self performAsync:^id(NSError **error){BOOL ok=[self loadOnQueue];if(!ok && error)*error=self.queueError;return ok?@YES:nil;} drainFinish:NO completion:^(id result,NSError *error){if(completion)completion(result!=nil,error);}];
}
- (void)performConfiguration:(BOOL(^)(void))work completion:(CSScheduledTaskStoreCompletion)completion {
    [self performAsync:^id(NSError **error){BOOL ok=work();if(!ok && error)*error=self.queueError?:CSTaskError(@"无法保存定时任务。");return ok?@YES:nil;} drainFinish:NO completion:^(id result,NSError *error){if(result)[NSNotificationCenter.defaultCenter postNotificationName:CSScheduledTaskConfigurationDidChange object:nil];if(completion)completion(result!=nil,error);}];
}
- (void)setEnabled:(BOOL)enabled now:(NSDate *)now completion:(CSScheduledTaskStoreCompletion)completion {
    NSDate *date=[now copy];[self performConfiguration:^BOOL{return [self setEnabledOnQueue:enabled now:date];} completion:completion];
}
- (void)saveTask:(NSDictionary *)task now:(NSDate *)now completion:(CSScheduledTaskStoreCompletion)completion {
    NSDictionary *snapshot=CSTaskFreeze(task);NSDate *date=[now copy];[self performConfiguration:^BOOL{return [self saveTaskOnQueue:snapshot now:date];} completion:completion];
}
- (void)removeTask:(NSString *)identifier completion:(CSScheduledTaskStoreCompletion)completion {
    NSString *key=[identifier copy];[self performConfiguration:^BOOL{return [self removeTaskOnQueue:key];} completion:completion];
}
- (void)claimTask:(NSString *)identifier now:(NSDate *)now completion:(CSScheduledTaskClaimCompletion)completion {
    NSString *key=[identifier copy];NSDate *date=[now copy];[self performAsync:^id(NSError **error){NSDictionary *claim=[self claimTaskOnQueue:key now:date];if(!self.queueReady && error)*error=self.queueError;return claim;} drainFinish:NO completion:completion];
}
- (void)finishClaim:(NSString *)claimID result:(NSString *)result detail:(NSString *)detail completion:(CSScheduledTaskStoreCompletion)completion {
    NSString *key=[claimID copy],*outcome=[result copy],*text=[detail copy];
    [self performAsync:^id(NSError **error){BOOL ok=[self finishClaimOnQueue:key result:outcome detail:text];if(!ok && error)*error=self.queueError?:CSTaskError(@"任务执行记录已改变。");return ok?@YES:nil;} drainFinish:YES completion:^(id value,NSError *error){if(completion)completion(value!=nil,error);}];
}
+ (BOOL)flushPendingOperations:(NSError **)error {
    if(NSThread.isMainThread){if(error)*error=CSTaskError(@"请在后台队列准备定时任务备份。");return NO;}
    __block NSError *failure=nil;
    CSTaskStoreSync(^{for(CSScheduledTaskStore *store in CSTaskLiveStores().allObjects){BOOL invalidated;@synchronized(store){invalidated=store.invalidated;}if(!invalidated && !store.queueReady && store.queueError){failure=store.queueError;break;}}});
    if(error)*error=failure;return failure==nil;
}
+ (BOOL)replaceState:(NSDictionary *)state atURL:(NSURL *)url account:(NSString *)account error:(NSError **)error {
    __block BOOL ok;__block NSError *failure=nil;CSTaskStoreSync(^{ok=[self replaceStateOnQueue:state atURL:url account:account error:&failure];});if(error)*error=failure;return ok;
}
// Offline compatibility. Production uses only the asynchronous entry points above.
- (BOOL)load {__block BOOL ok;CSTaskStoreSync(^{ok=[self loadOnQueue];[self publish];});return ok;}
- (BOOL)configurationSync:(BOOL(^)(void))work {__block BOOL ok;CSTaskStoreSync(^{ok=work();[self publish];});if(ok)[NSNotificationCenter.defaultCenter postNotificationName:CSScheduledTaskConfigurationDidChange object:nil];return ok;}
- (BOOL)setEnabled:(BOOL)enabled now:(NSDate *)now {return [self configurationSync:^BOOL{return [self setEnabledOnQueue:enabled now:now];}];}
- (BOOL)saveTask:(NSDictionary *)task now:(NSDate *)now {NSDictionary *snapshot=CSTaskFreeze(task);return [self configurationSync:^BOOL{return [self saveTaskOnQueue:snapshot now:now];}];}
- (BOOL)removeTask:(NSString *)identifier {return [self configurationSync:^BOOL{return [self removeTaskOnQueue:identifier];}];}
- (NSDictionary *)claimTask:(NSString *)identifier now:(NSDate *)now {__block NSDictionary *claim;CSTaskStoreSync(^{claim=[self claimTaskOnQueue:identifier now:now];[self publish];});return claim;}
- (BOOL)finishClaim:(NSString *)claimID result:(NSString *)result detail:(NSString *)detail {__block BOOL ok;CSTaskStoreSync(^{ok=[self finishClaimOnQueue:claimID result:result detail:detail];[self publish];});return ok;}
@end
