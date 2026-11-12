#import "CSAutomationNativeSync.h"
#import "CSAutomationManager.h"
#import "CSBackupBootstrap.h"
#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>
#import <substrate.h>
#import <string.h>

static BOOL CSAutomationSyncInstalled;
static const void *CSAutomationSyncStateKey=&CSAutomationSyncStateKey;
// Suppress callbacks inside our own synchronous request, including native NO
// paths which call setNeedSyncWithScene/resetGettingData again. A later external
// notification or real completion can still supply a new wake.
static _Thread_local NSUInteger CSAutomationSyncDriveDepth;
static _Thread_local NSUInteger CSAutomationSyncHandleDepth;

@interface CSAutomationSyncState : NSObject
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) BOOL pending,queued,driving;
@end
@implementation CSAutomationSyncState @end

static BOOL CSAutomationSyncConcrete(id service) {
    Class cls=NSClassFromString(@"NewSyncService");
    return service && cls && object_getClass(service)==cls;
}
static BOOL CSAutomationSyncIvar(Class cls,const char *name,const char *type,size_t size) {
    Ivar ivar=class_getInstanceVariable(cls,name);
    if(!ivar || strcmp(ivar_getTypeEncoding(ivar),type))return NO;
    ptrdiff_t offset=ivar_getOffset(ivar);size_t length=class_getInstanceSize(cls);
    return offset>=0 && (size_t)offset<=length && size<=length-(size_t)offset;
}
static BOOL CSAutomationSyncFlag(id service,const char *name) {
    bool value=false;Ivar ivar=class_getInstanceVariable(object_getClass(service),name);
    memcpy(&value,(const unsigned char *)(__bridge const void *)service+ivar_getOffset(ivar),sizeof(value));
    return value;
}
static BOOL CSAutomationSyncIdle(id service) {
    if(!CSAutomationSyncFlag(service,"m_bHasInit"))return NO;
    // isGettingData remains true across a successful continuation page. The
    // event ID and processing flag distinguish actual in-flight/decoding work;
    // requiring the terminal-idle flag here would strand the next page.
    // A previous processing error is cleared by a successful full sync; it
    // must not prevent a new external notification from requesting that sync.
    const char *busy[]={"m_bSyncOperating","m_bIsSyncPause"};
    for(NSUInteger i=0;i<sizeof(busy)/sizeof(*busy);i++)if(CSAutomationSyncFlag(service,busy[i]))return NO;
    unsigned int event=0;Ivar ivar=class_getInstanceVariable(object_getClass(service),"m_syncEventID");
    memcpy(&event,(const unsigned char *)(__bridge const void *)service+ivar_getOffset(ivar),sizeof(event));
    return event==0;
}
static void CSAutomationSyncDrain(id service,CSAutomationSyncState *state) {
    state.queued=NO;
    if(!state.pending || state.driving || state.epoch!=CSBackupAccountEpoch() ||
       objc_getAssociatedObject(service,CSAutomationSyncStateKey)!=state)return;
    @try {
        [CSAutomationManager.sharedManager performNativeSyncForService:service epoch:state.epoch request:^(id receiver){
            if(state.epoch!=CSBackupAccountEpoch() || !state.pending || state.driving)return;
            if(CSMessageNativeServiceIdentity(receiver,@"NewSyncService")!=service)return;
            if(!CSAutomationSyncFlag(service,"m_bNeedSync")){state.pending=NO;return;}
            // Never clear busy/pause/error flags to force a request. Busy needs
            // stay pending until a native completion/resume readiness event.
            if(!CSAutomationSyncIdle(service))return;
            state.pending=NO;state.driving=YES;CSAutomationSyncDriveDepth++;
            @try {
                // Uses the scene selected by WeChat; unlike BackGroundFetch it
                // consumes an existing notification, with no 10/45-second gate.
                [CSMessageNativeInvoke(receiver,@"NotifyToSync",@[]) boolValue];
            } @catch(__unused NSException *exception) {}
            @finally {CSAutomationSyncDriveDepth--;state.driving=NO;}
        }];
    } @catch(__unused NSException *exception) {}
}
static void CSAutomationSyncWake(id service,NSUInteger epoch,BOOL newNeed) {
    if(CSAutomationSyncDriveDepth || !CSAutomationSyncConcrete(service))return;
    if(!NSThread.isMainThread){
        dispatch_async(dispatch_get_main_queue(),^{CSAutomationSyncWake(service,epoch,newNeed);});return;
    }
    if(!CSAutomationSyncInstalled || epoch!=CSBackupAccountEpoch())return;
    CSAutomationSyncState *state=objc_getAssociatedObject(service,CSAutomationSyncStateKey);
    if(!state || state.epoch!=epoch){
        if(!newNeed)return;
        state=[CSAutomationSyncState new];state.epoch=epoch;
        objc_setAssociatedObject(service,CSAutomationSyncStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if(newNeed)state.pending=YES;
    if(!state.pending || state.queued || state.driving)return;
    state.queued=YES;
    // Leave the entire native callback (including key/status/extension updates)
    // before consuming its need; bursts in this run-loop turn share one wake.
    dispatch_async(dispatch_get_main_queue(),^{CSAutomationSyncDrain(service,state);});
}
void CSAutomationWakePendingNativeSync(id service,NSUInteger epoch) {
    @try {CSAutomationSyncWake(CSMessageNativeServiceIdentity(service,@"NewSyncService"),epoch,YES);} @catch(__unused NSException *exception) {}
}
BOOL CSAutomationNativeSyncAvailable(void) {return CSAutomationSyncInstalled;}
BOOL CSAutomationNativeSyncCanWake(id receiver) {
    return NSThread.isMainThread && CSAutomationSyncInstalled &&
        CSAutomationSyncConcrete(CSMessageNativeServiceIdentity(receiver,@"NewSyncService")) &&
        CSMessageNativeSupports(receiver,@"NotifyToSync",@"B",@[]);
}

static BOOL CSAutomationSyncMethod(Class cls,NSString *name,NSString *result,NSArray<NSString *> *arguments) {
    Method method=class_getInstanceMethod(cls,NSSelectorFromString(name));
    if(!method || method_getNumberOfArguments(method)!=arguments.count+2)return NO;
    char type[64]={0};method_getReturnType(method,type,sizeof(type));if(strcmp(type,result.UTF8String))return NO;
    for(NSUInteger i=0;i<arguments.count;i++){
        method_getArgumentType(method,(unsigned int)i+2,type,sizeof(type));
        if(strcmp(type,arguments[i].UTF8String))return NO;
    }
    return YES;
}
void CSAutomationInstallNativeSync(void) {
    if(CSAutomationSyncInstalled || !NSThread.isMainThread)return;
    // Reviewed 8.0.80.34: CMainControll notify 4/63 sets need; TimerCheckEvent
    // later consumes it. Other hosts retain the existing compatibility path.
    if(![NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"] isEqual:@"8.0.80"])return;
    Class cls=NSClassFromString(@"NewSyncService");if(!cls)return;
    if(!CSAutomationSyncMethod(cls,@"setNeedSyncWithScene:",@"v",@[@"i"]) ||
       !CSAutomationSyncMethod(cls,@"NotifyToSync",@"B",@[]) ||
       !CSAutomationSyncMethod(cls,@"HandleSyncResp:handleResult:",@"v",@[@"@",@"B"]) ||
       !CSAutomationSyncMethod(cls,@"makeSyncResume",@"v",@[]) ||
       !CSAutomationSyncMethod(cls,@"resetGettingData",@"v",@[]) ||
       !CSAutomationSyncIvar(cls,"m_syncEventID","I",sizeof(unsigned int)))return;
    const char *flags[]={"m_bHasInit","m_bNeedSync","m_bSyncOperating","m_bIsSyncPause"};
    for(NSUInteger i=0;i<sizeof(flags)/sizeof(*flags);i++)if(!CSAutomationSyncIvar(cls,flags[i],"B",sizeof(bool)))return;

    SEL need=NSSelectorFromString(@"setNeedSyncWithScene:");__block IMP originalNeed=NULL;
    IMP needReplacement=imp_implementationWithBlock(^(id service,int scene){
        NSUInteger epoch=CSBackupAccountEpoch();
        ((void(*)(id,SEL,int))originalNeed)(service,need,scene);
        CSAutomationWakePendingNativeSync(service,epoch);
    });
    MSHookMessageEx(cls,need,needReplacement,&originalNeed);
    SEL handle=NSSelectorFromString(@"HandleSyncResp:handleResult:");__block IMP originalHandle=NULL;
    IMP handleReplacement=imp_implementationWithBlock(^(id service,id response,bool processed){
        NSUInteger epoch=CSBackupAccountEpoch();
        CSAutomationSyncHandleDepth++;
        @try {((void(*)(id,SEL,id,bool))originalHandle)(service,handle,response,processed);}
        @finally {CSAutomationSyncHandleDepth--;}
        // Failed completion alone must not manufacture another request. On a
        // successful continuation WeChat itself has set m_bNeedSync again.
        @try {CSAutomationSyncWake(service,epoch,processed);} @catch(__unused NSException *exception) {}
    });
    MSHookMessageEx(cls,handle,handleReplacement,&originalHandle);
    SEL resume=NSSelectorFromString(@"makeSyncResume");__block IMP originalResume=NULL;
    IMP resumeReplacement=imp_implementationWithBlock(^(id service){
        NSUInteger epoch=CSBackupAccountEpoch();((void(*)(id,SEL))originalResume)(service,resume);
        CSAutomationWakePendingNativeSync(service,epoch);
    });
    MSHookMessageEx(cls,resume,resumeReplacement,&originalResume);
    SEL reset=NSSelectorFromString(@"resetGettingData");__block IMP originalReset=NULL;
    IMP resetReplacement=imp_implementationWithBlock(^(id service){
        NSUInteger epoch=CSBackupAccountEpoch();((void(*)(id,SEL))originalReset)(service,reset);
        // HandleSyncResp has not finished updating its selector/key yet. Let its
        // outer hook enqueue after those updates instead of queuing from here.
        if(!CSAutomationSyncHandleDepth){
            @try {CSAutomationSyncWake(service,epoch,NO);} @catch(__unused NSException *exception) {}
        }
    });
    MSHookMessageEx(cls,reset,resetReplacement,&originalReset);
    CSAutomationSyncInstalled=YES;
}
