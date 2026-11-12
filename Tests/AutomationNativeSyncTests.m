// The production observer owns hooks, native ivar checks and event coalescing.
// Only account eligibility and the native service implementation are fixtures.
#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import <stdatomic.h>
#import <string.h>
#import <limits.h>
#import "CSAutomationNativeSync.h"
#import "CSAutomationManager.h"
#import "CSBackupBootstrap.h"

static NSUInteger checks,hookCalls,managerCalls,requestCalls;
static atomic_ulong liveEpoch=100;
static BOOL eligible=YES,suspended,backupReady=YES,throwManager;
static id lastManagerService;
static NSUInteger lastManagerEpoch;
static dispatch_block_t duringManager;
static NSMutableArray<NSString *> *trace;
#define CHECK(c) do {checks++;if(!(c)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c);exit(1);}} while(0)

@interface CSAutomationManager (NativeSyncFixture)
- (void)performNativeSyncForService:(id)service epoch:(NSUInteger)epoch request:(void (^)(void))request;
@end
@implementation CSAutomationManager
+ (instancetype)sharedManager {static CSAutomationManager *manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (void)performNativeSyncForService:(id)service epoch:(NSUInteger)epoch request:(void (^)(void))request {
    CHECK(NSThread.isMainThread);managerCalls++;lastManagerService=service;lastManagerEpoch=epoch;[trace addObject:@"manager"];
    dispatch_block_t callback=duringManager;duringManager=nil;if(callback)callback();
    if(throwManager)[NSException raise:@"ManagerMetadata" format:@"fixture"];
    if(eligible && backupReady && !suspended && epoch==atomic_load(&liveEpoch)){requestCalls++;request();}
}
@end
NSUInteger CSBackupAccountEpoch(void) {return atomic_load(&liveEpoch);}
BOOL CSBackupAccountIsSuspended(void) {return suspended;}
BOOL CSBackupIsReady(void) {return backupReady;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch,void (^handoff)(void)) {
    if(epoch!=CSBackupAccountEpoch() || suspended)return NO;handoff();return YES;
}
void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original) {
    CHECK(NSThread.isMainThread);Method method=class_getInstanceMethod(cls,selector);CHECK(method && replacement && original);
    *original=method_getImplementation(method);class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));hookCalls++;
}

static void SetFlag(id service,const char *name,_Bool value) {
    Ivar ivar=class_getInstanceVariable(object_getClass(service),name);CHECK(ivar && !strcmp(ivar_getTypeEncoding(ivar),"B"));
    memcpy((unsigned char *)(__bridge void *)service+ivar_getOffset(ivar),&value,sizeof(value));
}
static _Bool Flag(id service,const char *name) {
    Ivar ivar=class_getInstanceVariable(object_getClass(service),name);CHECK(ivar && !strcmp(ivar_getTypeEncoding(ivar),"B"));_Bool value=0;
    memcpy(&value,(const unsigned char *)(__bridge const void *)service+ivar_getOffset(ivar),sizeof(value));return value;
}
static void SetEvent(id service,unsigned int value) {
    Ivar ivar=class_getInstanceVariable(object_getClass(service),"m_syncEventID");CHECK(ivar && !strcmp(ivar_getTypeEncoding(ivar),"I"));
    memcpy((unsigned char *)(__bridge void *)service+ivar_getOffset(ivar),&value,sizeof(value));
}

@interface NativeSyncFixtureService : NSObject
@property(nonatomic) NSUInteger setters,handles,resumes,resets,notifies;
@property(nonatomic) int lastScene;
@property(nonatomic,strong) id lastResponse;
@property(nonatomic) _Bool lastProcessed,notifyResult;
@property(nonatomic) BOOL suppressNeed,throwSetter,throwHandle,throwResume,throwReset,throwNotify;
@property(nonatomic,strong) NSException *nativeException;
@property(nonatomic,copy) dispatch_block_t duringSetter,duringHandle,duringResume,duringReset,duringNotify;
- (void)setNeedSyncWithScene:(int)scene;
- (void)HandleSyncResp:(id)response handleResult:(_Bool)processed;
- (void)makeSyncResume;
- (void)resetGettingData;
- (_Bool)NotifyToSync;
@end
@implementation NativeSyncFixtureService
- (void)setNeedSyncWithScene:(int)scene {
    self.setters++;self.lastScene=scene;[trace addObject:@"setter"];
    if(self.throwSetter)@throw self.nativeException;
    if(!self.suppressNeed)SetFlag(self,"m_bNeedSync",1);
    if(self.duringSetter)self.duringSetter();
}
- (void)HandleSyncResp:(id)response handleResult:(_Bool)processed {
    self.handles++;self.lastResponse=response;self.lastProcessed=processed;[trace addObject:@"handle"];
    if(self.throwHandle)@throw self.nativeException;
    if(self.duringHandle)self.duringHandle();
}
- (void)makeSyncResume {
    self.resumes++;[trace addObject:@"resume"];
    if(self.throwResume)@throw self.nativeException;
    SetFlag(self,"m_bIsSyncPause",0);if(self.duringResume)self.duringResume();
}
- (void)resetGettingData {
    self.resets++;[trace addObject:@"reset"];
    if(self.throwReset)@throw self.nativeException;
    SetFlag(self,"m_isGettingData",0);SetFlag(self,"m_bSyncOperating",0);SetEvent(self,0);
    if(self.duringReset)self.duringReset();
}
- (_Bool)NotifyToSync {
    CHECK(NSThread.isMainThread);self.notifies++;CHECK(self.notifies<=20);[trace addObject:@"notify"];
    if(self.throwNotify)@throw self.nativeException;
    SetFlag(self,"m_bNeedSync",0);if(self.duringNotify)self.duringNotify();return self.notifyResult;
}
@end

static void Drain(void) {
    __block BOOL done=NO;dispatch_async(dispatch_get_main_queue(),^{done=YES;});
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:3];
    while(!done && deadline.timeIntervalSinceNow>0)[NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.001]];
    CHECK(done);
}
static void Settle(void) {for(NSUInteger i=0;i<8;i++)Drain();}
static void OffMain(void (^operation)(void)) {
    dispatch_semaphore_t done=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{CHECK(!NSThread.isMainThread);operation();dispatch_semaphore_signal(done);});
    CHECK(!dispatch_semaphore_wait(done,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC)));
}
static void Reset(void) {
    Settle();atomic_fetch_add(&liveEpoch,1);eligible=YES;suspended=NO;backupReady=YES;throwManager=NO;
    managerCalls=0;requestCalls=0;lastManagerService=nil;lastManagerEpoch=0;duringManager=nil;trace=[NSMutableArray array];
}
static NativeSyncFixtureService *Service(void) {
    NativeSyncFixtureService *service=[NSClassFromString(@"NewSyncService") new];
    SetFlag(service,"m_bHasInit",1);service.notifyResult=1;
    service.nativeException=[NSException exceptionWithName:@"OriginalNative" reason:@"same exception object" userInfo:nil];return service;
}
static NSBundle *fixtureBundle;
static NSDictionary *fixtureInfo;
static IMP originalInfo;
static id BundleInfo(id receiver,SEL selector) {return receiver==fixtureBundle?fixtureInfo:((id(*)(id,SEL))originalInfo)(receiver,selector);}
static void Install(id version) {
    fixtureBundle=NSBundle.mainBundle;fixtureInfo=version?@{@"CFBundleShortVersionString":version}:@{};
    Method method=class_getInstanceMethod(NSBundle.class,@selector(infoDictionary));originalInfo=method_setImplementation(method,(IMP)BundleInfo);
    @try {CSAutomationInstallNativeSync();}@finally {method_setImplementation(method,originalInfo);fixtureBundle=nil;fixtureInfo=nil;}
}
static void RegisterNatives(NSString *mode) {
    if([mode isEqual:@"class-missing"])return;
    // Installation-only missing-selector modes use NSObject directly, so the
    // intentionally absent selector cannot be inherited from the recording base.
    BOOL missingSelector=[mode hasSuffix:@"-missing"];
    Class cls=objc_allocateClassPair(missingSelector?NSObject.class:NativeSyncFixtureService.class,"NewSyncService",0);CHECK(cls);
    const char *ivars[]={"m_bHasInit","m_bNeedSync","m_syncEventID","m_isGettingData","m_bSyncOperating","m_bSyncOpError","m_bIsSyncPause","m_lastSyncFinishCallingExtension"};
    for(NSUInteger i=0;i<sizeof(ivars)/sizeof(*ivars);i++){
        NSString *name=@(ivars[i]);if([mode isEqual:[@"ivar-missing:" stringByAppendingString:name]])continue;
        BOOL event=!strcmp(ivars[i],"m_syncEventID"),wrong=[mode isEqual:[@"ivar-type:" stringByAppendingString:name]];
        const char *encoding=wrong?(event?"Q":"c"):(event?"I":"B");size_t size=wrong && event?sizeof(unsigned long long):(event?sizeof(unsigned int):sizeof(_Bool));
        uint8_t alignment=wrong && event?3:(event?2:0);CHECK(class_addIvar(cls,ivars[i],size,alignment,encoding));
    }
    NSArray *selectors=@[@"setNeedSyncWithScene:",@"HandleSyncResp:handleResult:",@"makeSyncResume",@"resetGettingData",@"NotifyToSync"];
    NSArray *prefixes=@[@"setter",@"handle",@"resume",@"reset",@"notify"];
    for(NSUInteger i=0;i<selectors.count;i++){
        NSString *name=selectors[i],*prefix=prefixes[i];SEL selector=NSSelectorFromString(name);
        Method method=class_getInstanceMethod(NativeSyncFixtureService.class,selector);CHECK(method);
        const char *encoding=method_getTypeEncoding(method);IMP implementation=method_getImplementation(method);
        if([mode isEqual:[prefix stringByAppendingString:@"-missing"]])continue;
        if([mode isEqual:[prefix stringByAppendingString:@"-result-B"]])encoding=i==0?"B@:i":i==1?"B@:@B":"B@:";
        if([mode isEqual:@"notify-result-v"] && i==4)encoding="v@:";
        if([mode isEqual:@"setter-argument-I"] && i==0)encoding="v@:I";
        if([mode isEqual:@"handle-processed-c"] && i==1)encoding="v@:@c";
        if([mode isEqual:[prefix stringByAppendingString:@"-count"]])encoding=i==0?"v@:":i==1?"v@:@":i==4?"B@:I":"v@:I";
        CHECK(class_addMethod(cls,selector,implementation,encoding));
    }
    objc_registerClassPair(cls);
}

static void Installation(void) {
    CHECK(!CSAutomationNativeSyncAvailable());
    for(id version in @[@"8.0.78",@"8.0.79",@"8.0.80.1",@8080]){Install(version);CHECK(!hookCalls && !CSAutomationNativeSyncAvailable());}
    Install(nil);CHECK(!hookCalls && !CSAutomationNativeSyncAvailable());
    OffMain(^{CSAutomationInstallNativeSync();});CHECK(!hookCalls);
    Install(@"8.0.80");CHECK(hookCalls==4 && CSAutomationNativeSyncAvailable());
    Install(@"8.0.80");CHECK(hookCalls==4 && CSAutomationNativeSyncAvailable());
}
static void ImmediateAndBurst(void) {
    Reset();NativeSyncFixtureService *service=Service();NSTimeInterval started=NSProcessInfo.processInfo.systemUptime;
    [service setNeedSyncWithScene:-37];CHECK(service.setters==1 && service.lastScene==-37 && !service.notifies);
    Settle();CHECK(service.notifies==1 && managerCalls==1 && requestCalls==1);
    CHECK(lastManagerService==service && lastManagerEpoch==CSBackupAccountEpoch());
    CHECK(([trace isEqual:@[@"setter",@"manager",@"notify"]]));CHECK(NSProcessInfo.processInfo.systemUptime-started<1);
    Settle();CHECK(service.notifies==1);
    Reset();service=Service();for(int scene=0;scene<32;scene++)[service setNeedSyncWithScene:scene];
    CHECK(service.setters==32 && !service.notifies);Settle();CHECK(service.notifies==1 && managerCalls==1 && service.lastScene==31);
    [service setNeedSyncWithScene:44];Settle();CHECK(service.notifies==2);
    printf("Immediate native event + 32-event burst: main asynchronous drive below 1s, one merged request, no timer or polling\n");
}
static void BusyCompletionAndResume(void) {
    const char *busyFlags[]={"m_bSyncOperating","m_bIsSyncPause"};
    for(NSUInteger i=0;i<sizeof(busyFlags)/sizeof(*busyFlags);i++){
        Reset();NativeSyncFixtureService *service=Service();SetFlag(service,busyFlags[i],1);
        [service setNeedSyncWithScene:5];Settle();CHECK(!service.notifies);
        SetFlag(service,busyFlags[i],0);id response=[NSObject new];[service HandleSyncResp:response handleResult:1];Settle();
        CHECK(service.notifies==1 && service.handles==1 && service.lastResponse==response && service.lastProcessed);
        CHECK(!Flag(service,"m_bNeedSync"));Settle();CHECK(service.notifies==1);
    }
    Reset();NativeSyncFixtureService *extension=Service();SetFlag(extension,"m_lastSyncFinishCallingExtension",1);
    [extension setNeedSyncWithScene:4];Settle();CHECK(extension.notifies==1 && Flag(extension,"m_lastSyncFinishCallingExtension"));
    Reset();NativeSyncFixtureService *oldError=Service();SetFlag(oldError,"m_bSyncOpError",1);
    [oldError setNeedSyncWithScene:5];Settle();CHECK(oldError.notifies==1 && Flag(oldError,"m_bSyncOpError"));
    Reset();NativeSyncFixtureService *service=Service();SetEvent(service,91);[service setNeedSyncWithScene:6];Settle();CHECK(!service.notifies);
    [service resetGettingData];Settle();CHECK(service.resets==1 && service.notifies==1);
    Reset();service=Service();SetFlag(service,"m_bHasInit",0);[service setNeedSyncWithScene:8];Settle();CHECK(!service.notifies);
    SetFlag(service,"m_bHasInit",1);CSAutomationWakePendingNativeSync(service,CSBackupAccountEpoch());Settle();CHECK(service.notifies==1);
    Reset();service=Service();SetFlag(service,"m_bIsSyncPause",1);[service setNeedSyncWithScene:9];Settle();CHECK(!service.notifies);
    [service makeSyncResume];Settle();CHECK(service.resumes==1 && service.notifies==1);
    printf("Busy/event/init/pause boundaries retain pending until real completion, reset, resume or lifecycle wake; originals retain exact response/processed values\n");
}
static void NoNeedAndSuccessfulContinuation(void) {
    Reset();NativeSyncFixtureService *service=Service();id response=[NSObject new];
    [service resetGettingData];[service makeSyncResume];[service HandleSyncResp:response handleResult:1];
    CSAutomationWakePendingNativeSync(service,CSBackupAccountEpoch());Settle();CHECK(!service.notifies);
    service.suppressNeed=YES;[service setNeedSyncWithScene:1];Settle();CHECK(!service.notifies);
    Reset();service=Service();SetFlag(service,"m_bNeedSync",1);[service resetGettingData];Settle();CHECK(!service.notifies);
    [service HandleSyncResp:response handleResult:0];Settle();CHECK(!service.notifies && !service.lastProcessed);
    [service HandleSyncResp:response handleResult:1];Settle();CHECK(service.notifies==1 && service.lastProcessed);
    [service HandleSyncResp:response handleResult:1];Settle();CHECK(service.notifies==1);
    Reset();service=Service();SetFlag(service,"m_bNeedSync",1);[service makeSyncResume];Settle();CHECK(service.notifies==1);
    // A successful native continuation retains gettingData, selects scene 6
    // and sets need without resetGettingData. MessageReturn has cleared eventID;
    // InternalCreateSync may proceed once operating/pause/error are clear.
    Reset();service=Service();SetFlag(service,"m_isGettingData",1);service.lastScene=6;
    SetFlag(service,"m_bNeedSync",1);SetEvent(service,0);SetFlag(service,"m_bSyncOperating",0);
    [service HandleSyncResp:response handleResult:1];Settle();
    CHECK(service.notifies==1 && service.lastProcessed && service.lastScene==6 && !service.resets);
    CHECK(Flag(service,"m_isGettingData") && !Flag(service,"m_bSyncOperating"));
    printf("No-need and untracked reset/failure produce no request; processed YES with native need or resume supplies a real continuation opportunity\n");
    printf("Successful native scene-6 continuation: gettingData remains YES, eventID=0/operating=NO, no reset, one immediate request\n");
}
static void CompletionResetOrdering(void) {
    Reset();NativeSyncFixtureService *service=Service();SetFlag(service,"m_bSyncOperating",1);
    [service setNeedSyncWithScene:7];Settle();CHECK(!service.notifies);
    __weak NativeSyncFixtureService *weak=service;__block BOOL nativeFinished=NO;
    service.duringHandle=^{
        [weak resetGettingData];
        dispatch_async(dispatch_get_main_queue(),^{nativeFinished=YES;[trace addObject:@"native-finish"];});
    };
    service.duringNotify=^{CHECK(nativeFinished);};
    [trace removeAllObjects];[service HandleSyncResp:[NSObject new] handleResult:1];CHECK(!service.notifies);
    Settle();CHECK(service.notifies==1);
    CHECK(([trace isEqual:@[@"handle",@"reset",@"native-finish",@"manager",@"notify"]]));

    // If HandleSyncResp throws after its nested reset, no premature reset wake
    // may escape. The depth guard must also unwind for a later external reset.
    Reset();service=Service();weak=service;SetFlag(service,"m_bSyncOperating",1);
    [service setNeedSyncWithScene:8];Settle();CHECK(!service.notifies);
    service.duringHandle=^{NativeSyncFixtureService *current=weak;[current resetGettingData];@throw current.nativeException;};
    BOOL caught=NO;
    @try {[service HandleSyncResp:[NSObject new] handleResult:1];CHECK(NO);}
    @catch(NSException *exception){caught=YES;CHECK(exception==service.nativeException);}
    CHECK(caught);Settle();CHECK(!service.notifies);
    [service resetGettingData];Settle();CHECK(service.notifies==1);
    printf("Nested reset stays behind native completion FIFO/key updates; throwing completion restores suppression depth for later external recovery\n");
}
static void RefusalAndNoSelfLoop(void) {
    Reset();NativeSyncFixtureService *service=Service();service.notifyResult=0;[service setNeedSyncWithScene:1];Settle();CHECK(service.notifies==1);
    SetFlag(service,"m_bSyncOpError",1);SetFlag(service,"m_bNeedSync",1);
    [service HandleSyncResp:[NSObject new] handleResult:0];Settle();CHECK(service.notifies==1 && !service.lastProcessed);
    [service resetGettingData];Settle();CHECK(service.notifies==1);
    [service setNeedSyncWithScene:2];Settle();CHECK(service.notifies==2 && Flag(service,"m_bSyncOpError"));
    Reset();service=Service();service.throwNotify=YES;[service setNeedSyncWithScene:3];Settle();CHECK(service.notifies==1);
    Settle();[service resetGettingData];Settle();CHECK(service.notifies==1);
    service.throwNotify=NO;[service setNeedSyncWithScene:4];Settle();CHECK(service.notifies==2);
    Reset();service=Service();__weak NativeSyncFixtureService *weak=service;
    service.duringNotify=^{NativeSyncFixtureService *current=weak;[current setNeedSyncWithScene:12];[current resetGettingData];};
    [service setNeedSyncWithScene:5];Settle();CHECK(service.notifies==1 && service.setters==2 && service.resets==1);
    service.duringNotify=nil;[service setNeedSyncWithScene:6];Settle();CHECK(service.notifies==2);
    printf("Native NO/exception consumes one ticket without retry; setter/reset nested in native drive cannot create an asynchronous self-loop\n");
    printf("Old sync error does not block a new external need; failed completion after consumed ticket never self-retries\n");
}
static void ManagerEligibilityAndReentry(void) {
    for(NSUInteger variant=0;variant<4;variant++){
        Reset();NativeSyncFixtureService *service=Service();eligible=variant!=0;backupReady=variant!=1;suspended=variant==2;throwManager=variant==3;
        [service setNeedSyncWithScene:3];Settle();CHECK(!service.notifies);
        eligible=YES;backupReady=YES;suspended=NO;throwManager=NO;CSAutomationWakePendingNativeSync(service,CSBackupAccountEpoch());Settle();
        CHECK(service.notifies==1);
    }
    Reset();NativeSyncFixtureService *service=Service();duringManager=^{atomic_fetch_add(&liveEpoch,1);};
    [service setNeedSyncWithScene:1];Settle();CHECK(!service.notifies);
    Reset();service=Service();__weak NativeSyncFixtureService *weak=service;
    duringManager=^{[weak setNeedSyncWithScene:42];};[service setNeedSyncWithScene:1];Settle();CHECK(service.notifies==1);
    printf("Manager qualification/refusal/exception and epoch reentry cannot issue a stale request; synchronous manager reentry coalesces\n");
}
static void ThreadEpochAndServiceBoundaries(void) {
    Reset();NativeSyncFixtureService *service=Service();OffMain(^{[service setNeedSyncWithScene:-91];});
    CHECK(service.setters==1 && service.lastScene==-91);Settle();CHECK(service.notifies==1);
    Reset();service=Service();[service setNeedSyncWithScene:1];atomic_fetch_add(&liveEpoch,1);Settle();CHECK(!service.notifies);
    CSAutomationWakePendingNativeSync(service,CSBackupAccountEpoch()-1);Settle();CHECK(!service.notifies);
    Reset();service=Service();service.duringSetter=^{atomic_fetch_add(&liveEpoch,1);};[service setNeedSyncWithScene:2];Settle();CHECK(!service.notifies);
    Reset();service=Service();NativeSyncFixtureService *other=Service();SetFlag(service,"m_bSyncOperating",1);
    [service setNeedSyncWithScene:3];Settle();[other resetGettingData];[other HandleSyncResp:[NSObject new] handleResult:1];Settle();CHECK(!service.notifies && !other.notifies);
    SetFlag(service,"m_bSyncOperating",0);[service resetGettingData];Settle();CHECK(service.notifies==1 && !other.notifies);
    CSAutomationWakePendingNativeSync([NSObject new],CSBackupAccountEpoch());Settle();
    Class subclass=objc_allocateClassPair(NSClassFromString(@"NewSyncService"),"NativeSyncDerivedService",0);CHECK(subclass);objc_registerClassPair(subclass);
    NativeSyncFixtureService *derived=[subclass new];SetFlag(derived,"m_bHasInit",1);[derived setNeedSyncWithScene:4];Settle();CHECK(derived.setters==1 && !derived.notifies);
    printf("Off-main ingress delivers on main; epoch changes across queue/original discard old work; other service and subclass cannot steal pending\n");
}
static void OriginalArgumentsAndExceptions(void) {
    for(NSUInteger variant=0;variant<4;variant++){
        Reset();NativeSyncFixtureService *service=Service();service.throwSetter=variant==0;service.throwHandle=variant==1;service.throwResume=variant==2;service.throwReset=variant==3;
        id response=[NSObject new];BOOL caught=NO;
        @try {
            if(variant==0)[service setNeedSyncWithScene:INT_MIN];
            if(variant==1)[service HandleSyncResp:response handleResult:0];
            if(variant==2)[service makeSyncResume];if(variant==3)[service resetGettingData];CHECK(NO);
        }@catch(NSException *exception){caught=YES;CHECK(exception==service.nativeException);}
        CHECK(caught);Settle();CHECK(!service.notifies);
        CHECK(service.setters==(variant==0) && service.handles==(variant==1) && service.resumes==(variant==2) && service.resets==(variant==3));
        if(variant==0)CHECK(service.lastScene==INT_MIN);if(variant==1)CHECK(service.lastResponse==response && !service.lastProcessed);
    }
    Reset();NativeSyncFixtureService *service=Service();BOOL before=service.notifyResult;CHECK([service NotifyToSync]==before && service.notifies==1);Settle();CHECK(service.notifies==1);
    printf("All four original hooks called exactly once; signed scene, object/BOOL, native exception identity and untouched NotifyToSync result preserved\n");
}
int main(int argc,const char *argv[]) {@autoreleasepool {
    trace=[NSMutableArray array];NSString *mode=argc>1?@(argv[1]):@"all";RegisterNatives(mode);
    if(![mode isEqual:@"all"]){Install(@"8.0.80");CHECK(!hookCalls && !CSAutomationNativeSyncAvailable());printf("Automation native sync rejection %s: %lu checks passed; no partial hook installation\n",mode.UTF8String,(unsigned long)checks);return 0;}
    Installation();ImmediateAndBurst();BusyCompletionAndResume();NoNeedAndSuccessfulContinuation();CompletionResetOrdering();RefusalAndNoSelfLoop();ManagerEligibilityAndReentry();ThreadEpochAndServiceBoundaries();OriginalArgumentsAndExceptions();
    printf("Automation native sync: %lu checks passed; real runtime hooks, event coalescing, pending-only recovery, no self-loop, epoch/thread/service isolation and original semantics\n",(unsigned long)checks);
    return 0;
}}
