#import "CSBackupAudit.h"
#import "CSPluginStorage.h"
#import "../Headers/CSUserInfoHelper.h"
#import <TargetConditionals.h>
#include <sys/stat.h>
#include <mach-o/dyld.h>
#include <mach-o/loader.h>

static const NSUInteger AuditEventLimit=96,AuditByteLimit=512*1024;
static void *AuditQueueKey=&AuditQueueKey;
static NSDictionary *Identity(NSString *path) {
    struct stat st;
    if(lstat(path.fileSystemRepresentation,&st))return @{@"exists":@NO};
    return @{@"exists":@YES,@"device":@(st.st_dev),@"inode":@(st.st_ino),@"mode":@(st.st_mode),
        @"birth":@(st.st_birthtimespec.tv_sec),@"mtime":@(st.st_mtimespec.tv_sec),@"ctime":@(st.st_ctimespec.tv_sec)};
}
static NSString *MainImageUUID(void) {
    const struct mach_header *header=_dyld_get_image_header(0);
    if(!header||header->magic!=MH_MAGIC_64)return @"";
    const uint8_t *cursor=(const uint8_t *)header+sizeof(struct mach_header_64);
    const uint8_t *end=cursor+header->sizeofcmds;
    for(uint32_t i=0;i<header->ncmds&&cursor+sizeof(struct load_command)<=end;i++) {
        const struct load_command *command=(const struct load_command *)cursor;
        if(command->cmdsize<sizeof(*command)||cursor+command->cmdsize>end)break;
        if(command->cmd==LC_UUID&&command->cmdsize>=sizeof(struct uuid_command))return [[NSUUID alloc]initWithUUIDBytes:((const struct uuid_command *)command)->uuid].UUIDString;
        cursor+=command->cmdsize;
    }
    return @"";
}
@interface CSBackupAudit ()
@property(nonatomic) NSMutableDictionary *state;
@property(nonatomic) dispatch_queue_t queue;
@property(nonatomic) BOOL dirty;
@property(nonatomic) BOOL persistenceScheduled;
@end
@implementation CSBackupAudit
- (instancetype)initWithRoot:(NSURL *)root auditURL:(NSURL *)auditURL {
    if((self=[super init])) {
        _root=[root copy];_auditURL=[auditURL copy];
        _queue=dispatch_queue_create("com.wechat.improve.backup-audit",DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(_queue,dispatch_get_global_queue(QOS_CLASS_UTILITY,0));
        dispatch_queue_set_specific(_queue,AuditQueueKey,(__bridge void *)self,NULL);
        _state=[@{@"events":[NSMutableArray array]} mutableCopy];
        dispatch_async(_queue,^{@autoreleasepool{@try{
            struct stat st;NSData *data=nil;
            if(!lstat(self.auditURL.path.fileSystemRepresentation,&st)&&S_ISREG(st.st_mode)&&st.st_size>=0&&(uint64_t)st.st_size<=AuditByteLimit)data=[NSData dataWithContentsOfURL:self.auditURL];
            id value=data?[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:NULL]:nil;
            if([value isKindOfClass:NSDictionary.class]) {
                for(NSString *key in @[@"lastPublished",@"inventory",@"lastRestore",@"lastRestoreFailure"])if([value[key] isKindOfClass:NSDictionary.class])self.state[key]=value[key];
                if([value[@"events"] isKindOfClass:NSArray.class])self.state[@"events"]=[value[@"events"] mutableCopy];
            }
            NSMutableArray *events=self.state[@"events"];
            if(events.count>AuditEventLimit)[events removeObjectsInRange:NSMakeRange(0,events.count-AuditEventLimit)];
        }@catch(__unused NSException *exception){NSLog(@"[CSBackupAudit] unable to load diagnostics");}}});
    }return self;
}
- (NSData *)serializedState {
    return [NSPropertyListSerialization dataWithPropertyList:self.state format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];
}
- (void)persist {
    if(!self.dirty)return;
    self.dirty=NO;
    @try {
        // This flat plist remains outside the backup/resource subdirectories. It contains no settings payload.
        NSURL *parent=self.auditURL.URLByDeletingLastPathComponent;struct stat st;
        if(!lstat(self.auditURL.path.fileSystemRepresentation,&st)&&!S_ISREG(st.st_mode))return;
        if(![NSFileManager.defaultManager createDirectoryAtURL:parent withIntermediateDirectories:YES attributes:nil error:NULL])return;
        NSMutableArray *events=self.state[@"events"];NSData *data=[self serializedState];
        while(data.length>AuditByteLimit&&events.count>1) {
            [events removeObjectsInRange:NSMakeRange(0,MAX((NSUInteger)1,events.count/2))];data=[self serializedState];
        }
        if(data.length>AuditByteLimit) {
            // Even one unexpected oversized event must not grow the diagnostics file without bound.
            [self.state removeObjectForKey:@"inventory"];
            NSMutableDictionary *last=[events.lastObject mutableCopy];
            if(last){last[@"details"]=@{@"omitted":@"event exceeds audit size limit"};[events removeAllObjects];[events addObject:last];}
            data=[self serializedState];
        }
        if(!data||data.length>AuditByteLimit||![data writeToURL:self.auditURL options:NSDataWritingAtomic error:NULL])NSLog(@"[CSBackupAudit] unable to persist diagnostics");
#if TARGET_OS_IPHONE
        [NSFileManager.defaultManager setAttributes:@{NSFileProtectionKey:NSFileProtectionCompleteUntilFirstUserAuthentication} ofItemAtPath:self.auditURL.path error:NULL];
#endif
    }@catch(__unused NSException *exception){NSLog(@"[CSBackupAudit] unable to persist diagnostics");}
}
- (void)schedulePersistence {
    self.dirty=YES;
    if(self.persistenceScheduled)return;
    self.persistenceScheduled=YES;
    dispatch_async(self.queue,^{@autoreleasepool{self.persistenceScheduled=NO;[self persist];}});
}
- (void)enqueue:(NSString *)event details:(NSDictionary *)details stack:(BOOL)stack store:(BOOL)store {
    // Copy the caller's data and stack before returning. All filesystem access and serialization run on the audit queue.
    @try {
        if(![event isKindOfClass:NSString.class]||![details isKindOfClass:NSDictionary.class])return;
        NSDictionary *snapshot=CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault,(__bridge CFPropertyListRef)details,kCFPropertyListImmutable));
        if(!snapshot)return;
        NSString *name=[event copy];NSDate *time=NSDate.date;NSArray *frames=nil;
        if(stack){NSArray *symbols=NSThread.callStackSymbols;frames=[symbols subarrayWithRange:NSMakeRange(0,MIN(symbols.count,24))];}
        dispatch_async(self.queue,^{@autoreleasepool{@try{
            NSDictionary *identity=Identity(self.root.path);NSMutableDictionary *payload=[snapshot mutableCopy];
            if(store&&[name isEqual:@"inventory"]) {
                NSDictionary *current=@{@"root":self.root.path,@"files":snapshot[@"files"]?:@[],@"identity":identity};
                NSDictionary *previous=self.state[@"inventory"];
                if([previous isEqual:current])return;
                self.state[@"inventory"]=current;if(previous)payload[@"previous"]=previous;
            }
            if(store&&[name isEqual:@"published"]) {
                NSString *identifier=[snapshot[@"id"] isKindOfClass:NSString.class]?snapshot[@"id"]:@"";
                if(identifier.length>128)identifier=[identifier substringToIndex:128];
                self.state[@"lastPublished"]=@{@"root":self.root.path,@"time":time,@"id":identifier};
            }
            NSMutableDictionary *entry=[@{@"event":name,@"time":time,@"pid":@(NSProcessInfo.processInfo.processIdentifier),
                @"pluginVersion":kPluginVersionString,
                @"root":self.root.path,@"rootIdentity":identity,@"rootIdentityObservedAt":NSDate.date,@"details":payload,
                @"hostVersion":[NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"]?:@"",
                @"bundleID":NSBundle.mainBundle.bundleIdentifier?:@"",@"hostImageUUID":MainImageUUID()} mutableCopy];
            if(frames)entry[@"stack"]=frames;
            if([name hasPrefix:@"restore-"]){
                self.state[@"lastRestore"]=entry;
                if([snapshot[@"status"] isEqual:@"failed"])self.state[@"lastRestoreFailure"]=entry;
            }
            NSMutableArray *events=self.state[@"events"];[events addObject:entry];
            while(events.count>AuditEventLimit)[events removeObjectAtIndex:0];
            self.state[@"schema"]=@2;[self schedulePersistence];
        }@catch(__unused NSException *exception){NSLog(@"[CSBackupAudit] unable to record %@",name);}}});
    }@catch(__unused NSException *exception){NSLog(@"[CSBackupAudit] unable to queue diagnostics");}
}
- (void)record:(NSString *)event details:(NSDictionary *)details stack:(BOOL)stack {
    [self enqueue:event details:details stack:stack store:NO];
}
- (void)storeEvent:(NSString *)event details:(NSDictionary *)details {
    [self enqueue:event details:details stack:[event hasPrefix:@"remove"] store:YES];
}
- (void)flush {
    if(dispatch_get_specific(AuditQueueKey)==(__bridge void *)self){[self persist];return;}
    dispatch_sync(self.queue,^{[self persist];});
}
@end

CSBackupAudit *CSBackupDefaultAudit(void) {
    static CSBackupAudit *audit;static dispatch_once_t once;
    dispatch_once(&once,^{
        NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
        audit=[[CSBackupAudit alloc]initWithRoot:CSPluginStorageMigration(@"BackupV2").destinationRoot
            auditURL:[library URLByAppendingPathComponent:@"Preferences/com.wechat.improve.backup-audit.plist"]];
    });return audit;
}
