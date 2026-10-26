#import "CSBackupBootstrap.h"
#import "CSBackupManager.h"
#import "CSPluginStorage.h"
#import "CSUserInfoHelper.h"
#import <stdatomic.h>
#import <sys/stat.h>
#import <errno.h>

static NSError *CSBackupRestartRequired(void) {
    return [NSError errorWithDomain:@"CSBackupStartup" code:1 userInfo:@{NSLocalizedDescriptionKey:@"插件功能已启动，请重新打开微信后应用待恢复配置。"}];
}

BOOL CSBackupStartupNeedsResolution(NSURL *journalURL, NSString *protectedVersion, NSString *currentVersion) {
    // A version backup is optional work, never a prerequisite for the plugin framework.
    (void)protectedVersion;(void)currentVersion;
    // lstat detects dangling symlinks too; never interpret an unreadable journal as absent.
    struct stat metadata;
    if (lstat(journalURL.fileSystemRepresentation, &metadata) == 0) return YES;
    return errno != ENOENT;
}

@interface CSBackupStartupGate ()
@property(nonatomic) NSLock *lock;
@property(nonatomic) NSMutableArray<void (^)(void)> *callbacks;
@property(nonatomic) NSMutableArray<CSBackupStartupCompletion> *completions;
@property(nonatomic, copy) CSBackupStartupResolver resolver;
@property(nonatomic) BOOL resolved;
@property(nonatomic) BOOL resolving;
@property(nonatomic) BOOL attempted;
@end

@implementation CSBackupStartupGate
- (instancetype)initWithNeedsResolution:(BOOL)needsResolution resolver:(CSBackupStartupResolver)resolver {
    if ((self = [super init])) {
        _lock = [NSLock new];
        _callbacks = [NSMutableArray array];
        _completions = [NSMutableArray array];
        _resolver = [resolver copy];
        _resolved = !needsResolution;
    }
    return self;
}
- (BOOL)isReady {
    [self.lock lock]; BOOL ready = self.resolved; [self.lock unlock];
    return ready;
}
- (void)whenReady:(void (^)(void))callback {
    if (!callback) return;
    [self.lock lock];
    BOOL ready = self.resolved;
    BOOL start = !ready && !self.attempted;
    if (!ready) [self.callbacks addObject:[callback copy]];
    if (start) { self.resolving = YES; self.attempted = YES; }
    [self.lock unlock];
    if (ready) callback();
    else if (start) [self startResolution];
}
- (void)retry:(CSBackupStartupCompletion)completion {
    [self.lock lock];
    BOOL ready = self.resolved;
    BOOL start = !ready && !self.resolving;
    if (!ready && completion) [self.completions addObject:[completion copy]];
    if (start) { self.resolving = YES; self.attempted = YES; }
    [self.lock unlock];
    if (ready) {
        if (completion) dispatch_async(dispatch_get_main_queue(), ^{ completion(CSBackupRestartRequired()); });
    } else if (start) [self startResolution];
}
- (void)startResolution {
    // Never run manager construction, account discovery, or recovery from a dylib constructor.
    dispatch_async(dispatch_get_main_queue(), ^{
        __block BOOL delivered = NO;
        self.resolver(^(NSError *error) {
            void (^finish)(void) = ^{
                // A resolver completion is one-shot, including failure followed by a later retry.
                if (delivered) return;
                delivered = YES;
                [self.lock lock];
                self.resolving = NO;
                if (!error) self.resolved = YES;
                NSArray<void (^)(void)> *callbacks = error ? @[] : [self.callbacks copy];
                if (!error) [self.callbacks removeAllObjects];
                NSArray<CSBackupStartupCompletion> *completions = [self.completions copy];
                [self.completions removeAllObjects];
                [self.lock unlock];
                for (void (^callback)(void) in callbacks) callback();
                for (CSBackupStartupCompletion completion in completions) completion(error);
            };
            if (NSThread.isMainThread) finish(); else dispatch_async(dispatch_get_main_queue(), finish);
        });
    });
}
@end

static CSBackupStartupGate *CSBackupSharedGate(void) {
    static CSBackupStartupGate *gate;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSPluginDirectoryMigration *migration=CSPluginStorageMigration(@"BackupV2");
        [migration migrate:NULL]; // Raw filesystem relocation precedes journal detection.
        BOOL needsResolution=NO;
        for(NSURL *root in @[migration.destinationRoot,migration.legacyRoot])
            needsResolution |= CSBackupStartupNeedsResolution([root URLByAppendingPathComponent:@"transaction.plist"],nil,kPluginVersionString);
        gate = [[CSBackupStartupGate alloc] initWithNeedsResolution:needsResolution
            resolver:^(CSBackupStartupCompletion completion) {
                [CSBackupManager.sharedManager resolveStartup:^(id result, NSError *error) {
                    completion(error ?: (result ? nil : [NSError errorWithDomain:@"CSBackupStartup" code:2 userInfo:@{NSLocalizedDescriptionKey:@"启动配置尚未完成校验，可在备份与恢复中重试或取消。"}]));
                }];
            }];
        // Native lifecycle notification needs no feature singleton and produces at most one
        // attempt per foreground event. A failed/missing-account recovery never busy-loops.
        [NSNotificationCenter.defaultCenter addObserverForName:@"UIApplicationDidBecomeActiveNotification" object:nil queue:nil
            usingBlock:^(__unused NSNotification *note) { CSBackupResumeAfterRecovery(); }];
    });
    return gate;
}

void CSBackupWhenReady(void (^callback)(void)) { [CSBackupSharedGate() whenReady:callback]; }
BOOL CSBackupIsReady(void) { return CSBackupSharedGate().isReady; }
void CSBackupRetryStartup(CSBackupStartupCompletion completion) { [CSBackupSharedGate() retry:completion]; }
void CSBackupResumeAfterRecovery(void) {
    CSBackupStartupGate *gate = CSBackupSharedGate();
    if (!gate.isReady) [gate retry:nil];
}

// Epoch and suspension are one atomic word so every native boundary is visible immediately,
// even if WeChat calls it off main while the manager is validating resources on its I/O queue.
static atomic_uint_fast64_t CSBackupAccountBoundary = 2;
static NSRecursiveLock *CSBackupAccountLock(void){static NSRecursiveLock *lock;static dispatch_once_t once;dispatch_once(&once,^{lock=[NSRecursiveLock new];});return lock;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch,void (^handoff)(void)){
    NSCAssert(NSThread.isMainThread,@"Startup handoff is main-thread owned");
    NSRecursiveLock *lock=CSBackupAccountLock();[lock lock];BOOL valid=CSBackupAccountEpoch()==epoch;
    if(valid)handoff();[lock unlock];return valid;
}
NSUInteger CSBackupAccountEpoch(void) { return (NSUInteger)(atomic_load_explicit(&CSBackupAccountBoundary, memory_order_acquire) >> 1); }
BOOL CSBackupAccountIsSuspended(void) { return (atomic_load_explicit(&CSBackupAccountBoundary, memory_order_acquire) & 1) != 0; }
static void CSBackupMarkAccountBoundary(BOOL suspended) {
    NSRecursiveLock *lock=CSBackupAccountLock();[lock lock];
    uint_fast64_t old = atomic_load_explicit(&CSBackupAccountBoundary, memory_order_acquire), next;
    do { next = ((old + 2) & ~(uint_fast64_t)1) | (suspended ? 1 : 0); }
    while (!atomic_compare_exchange_weak_explicit(&CSBackupAccountBoundary, &old, next, memory_order_acq_rel, memory_order_acquire));
    [lock unlock];
}
void CSBackupAccountWillChangeAtNativeBoundary(void) { CSBackupMarkAccountBoundary(YES); }
void CSBackupAccountDidChangeAtNativeBoundary(void) {
    CSBackupMarkAccountBoundary(NO);
    dispatch_async(dispatch_get_main_queue(), ^{ [NSNotificationCenter.defaultCenter postNotificationName:@"CSBackupAccountChanged" object:nil]; CSBackupResumeAfterRecovery(); });
}
