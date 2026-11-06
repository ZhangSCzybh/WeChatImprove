#import "CSAINativeSyncObserver.h"
#import "CSAIReplyManager.h"
#import "CSBackupBootstrap.h"
#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>
#import <substrate.h>
#import <math.h>
#import <string.h>

static const void *CSAISyncTransactionKey=&CSAISyncTransactionKey;
static const void *CSAISyncResponseKey=&CSAISyncResponseKey;
static const void *CSAISyncServiceEpochKey=&CSAISyncServiceEpochKey;
static BOOL CSAISyncObserverInstalled,CSAISyncCapturingContext;

@interface CSAINativeSyncRequestFrame : NSObject
@property(nonatomic,strong) id context;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) BOOL claimed;
@end
@implementation CSAINativeSyncRequestFrame @end
static CSAINativeSyncRequestFrame *CSAISyncAccountRequestFrame;

@interface CSAINativeSyncObservation : NSObject
@property(nonatomic,strong) id context;
@property(nonatomic,weak) id service;
@property(nonatomic) unsigned int event;
@property(nonatomic) NSUInteger epoch;
@end
@implementation CSAINativeSyncObservation @end

static id CSAISyncCaptureContext(NSUInteger epoch) {
    if(CSAISyncCapturingContext)return nil;
    CSAISyncCapturingContext=YES;
    @try {return [CSAIReplyManager.sharedManager captureBackgroundSyncContextForEpoch:epoch];}
    @finally {CSAISyncCapturingContext=NO;}
}
void CSAIObserveBackgroundSyncRequest(NSUInteger expectedEpoch, void (^request)(void)) {
    if(!NSThread.isMainThread || !CSAISyncObserverInstalled){request();return;}
    CSAINativeSyncRequestFrame *previous=CSAISyncAccountRequestFrame;
    CSAINativeSyncRequestFrame *frame=[CSAINativeSyncRequestFrame new];frame.epoch=expectedEpoch;
    // Isolate the scope before crossing eligibility getters, which can reenter.
    CSAISyncAccountRequestFrame=frame;
    @try {
        @try {
            if(CSAIReplyMessageIngressEnabled()){
                id context=CSAISyncCaptureContext(frame.epoch);
                if(frame.epoch==CSBackupAccountEpoch())frame.context=context;
            }
        } @catch(__unused NSException *exception) {}
        request();
    } @finally {CSAISyncAccountRequestFrame=previous;}
}

static BOOL CSAISyncIsConcrete(id object, NSString *name) {
    Class cls=NSClassFromString(name);
    return object && cls && object_getClass(object)==cls;
}
static BOOL CSAISyncReadScalar(id object, const char *name, const char *encoding, void *value, size_t size) {
    if(!CSAISyncIsConcrete(object,@"NewSyncService"))return NO;
    Ivar ivar=class_getInstanceVariable(object_getClass(object),name);
    if(!ivar || strcmp(ivar_getTypeEncoding(ivar),encoding))return NO;
    ptrdiff_t offset=ivar_getOffset(ivar);
    size_t length=class_getInstanceSize(object_getClass(object));
    if(offset<0 || (size_t)offset>length || size>length-(size_t)offset)return NO;
    memcpy(value,(const unsigned char *)(__bridge const void *)object+offset,size);
    return YES;
}
static BOOL CSAISyncReadEvent(id service, unsigned int *event) {
    return CSAISyncReadScalar(service,"m_syncEventID","I",event,sizeof(*event));
}
static BOOL CSAISyncNativeIdle(id service) {
    unsigned int event=0;
    if(!CSAISyncReadEvent(service,&event) || event)return NO;
    const char *names[]={"m_isGettingData","m_bSyncOperating","m_bSyncOpError","m_bIsSyncPause","m_bNeedSync"};
    for(NSUInteger i=0;i<sizeof(names)/sizeof(*names);i++){
        bool flag=true;
        if(!CSAISyncReadScalar(service,names[i],"B",&flag,sizeof(flag)) || flag)return NO;
    }
    bool initialized=false;
    return CSAISyncReadScalar(service,"m_bHasInit","B",&initialized,sizeof(initialized)) && initialized;
}
static BOOL CSAISyncNumber(id object, NSString *selector, NSString *type, long long expected) {
    return CSMessageNativeSupports(object,selector,type,@[]) &&
        [CSMessageNativeInvoke(object,selector,@[]) longLongValue]==expected;
}
static BOOL CSAISyncTerminalResponse(id response) {
    // Ret -2006 and nonzero/unknown continuation flags are deliberately ineligible.
    return CSAISyncIsConcrete(response,@"NewSyncResponse") &&
        CSAISyncNumber(response,@"ret",@"i",0) && CSAISyncNumber(response,@"continueFlag",@"I",0);
}
static void CSAISyncAttachCreated(id service, CSAINativeSyncObservation *observation, BOOL bindService, BOOL accepted) {
    if(!observation || !NSThread.isMainThread || observation.epoch!=CSBackupAccountEpoch() ||
       objc_getAssociatedObject(service,CSAISyncTransactionKey)!=observation)return;
    unsigned int event=0;
    if(!accepted || !CSAISyncReadEvent(service,&event) || !event){
        objc_setAssociatedObject(service,CSAISyncTransactionKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);return;
    }
    observation.event=event;
    if(bindService)objc_setAssociatedObject(service,CSAISyncServiceEpochKey,@(observation.epoch),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static void CSAISyncAttachResponse(id service, id wrapper, unsigned int event, NSUInteger epoch) {
    CSAINativeSyncObservation *observation=objc_getAssociatedObject(service,CSAISyncTransactionKey);
    // MessageReturn clears the event ID in the original implementation, so match
    // it now. Every response consumes its observation, including rejected ones.
    objc_setAssociatedObject(service,CSAISyncTransactionKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(!NSThread.isMainThread || ![observation isKindOfClass:CSAINativeSyncObservation.class] ||
       observation.service!=service || observation.epoch!=epoch || epoch!=CSBackupAccountEpoch() ||
       !event || observation.event!=event || !CSAISyncIsConcrete(wrapper,@"ProtobufCGIWrap"))return;
    unsigned int current=0;
    if(!CSAISyncReadEvent(service,&current) || current!=event ||
       !CSAISyncNumber(wrapper,@"m_uiCgi",@"I",138) ||
       !CSMessageNativeSupports(wrapper,@"m_uiMessage",@"I",@[]) ||
       [CSMessageNativeInvoke(wrapper,@"m_uiMessage",@[]) unsignedIntValue]==1)return;
    id request=CSMessageActionNativeObject(wrapper,@"m_pbRequest");
    id response=CSMessageActionNativeObject(wrapper,@"m_pbResponse");
    // 8.0.78 creatPBNewSyncEvent builds this normal full-sync selector. Push-only,
    // init, partial or unknown requests never establish full-sync coverage.
    if(!CSAISyncIsConcrete(request,@"NewSyncRequest") ||
       !CSAISyncNumber(request,@"selector",@"I",0x40007) || !CSAISyncTerminalResponse(response))return;
    objc_setAssociatedObject(response,CSAISyncResponseKey,observation,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static id CSAISyncTakeCompletion(id service, id response, BOOL processed, NSUInteger epoch) {
    CSAINativeSyncObservation *observation=objc_getAssociatedObject(response,CSAISyncResponseKey);
    objc_setAssociatedObject(response,CSAISyncResponseKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(!processed || !NSThread.isMainThread || ![observation isKindOfClass:CSAINativeSyncObservation.class] ||
       observation.service!=service || observation.epoch!=epoch || epoch!=CSBackupAccountEpoch() ||
       !CSAISyncTerminalResponse(response))return nil;
    return observation;
}
static BOOL CSAISyncMethod(Class cls, NSString *name, NSString *result, NSArray<NSString *> *arguments) {
    Method method=class_getInstanceMethod(cls,NSSelectorFromString(name));
    if(!method || method_getNumberOfArguments(method)!=arguments.count+2)return NO;
    char encoding[32]={0};method_getReturnType(method,encoding,sizeof(encoding));
    if(strcmp(encoding,result.UTF8String))return NO;
    for(NSUInteger i=0;i<arguments.count;i++){
        method_getArgumentType(method,(unsigned int)i+2,encoding,sizeof(encoding));
        if(strcmp(encoding,arguments[i].UTF8String))return NO;
    }
    return YES;
}
void CSAIInstallNativeSyncObserver(void) {
    if(CSAISyncObserverInstalled || !NSThread.isMainThread)return;
    // The semantic checks below are based on this shipped version. New hosts
    // retain the 45-second fallback until their response path is reviewed.
    if(![NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"] isEqual:@"8.0.78"])return;
    Class cls=NSClassFromString(@"NewSyncService");if(!cls)return;
    if(!CSAISyncMethod(cls,@"creatPBNewSyncEvent:",@"B",@[@"I"]) ||
       !CSAISyncMethod(cls,@"MessageReturn:Event:",@"v",@[@"@",@"I"]) ||
       !CSAISyncMethod(cls,@"HandleSyncResp:handleResult:",@"v",@[@"@",@"B"]))return;
    CSAISyncObserverInstalled=YES;
    SEL create=NSSelectorFromString(@"creatPBNewSyncEvent:");__block IMP originalCreate=NULL;
    IMP createReplacement=imp_implementationWithBlock(^bool(id service,unsigned int scene){
        NSUInteger epoch=CSBackupAccountEpoch();CSAINativeSyncObservation *observation=nil;BOOL bindService=NO;
        @try {
            objc_setAssociatedObject(service,CSAISyncTransactionKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            if(NSThread.isMainThread && !CSAISyncCapturingContext && CSAIReplyMessageIngressEnabled() &&
               CSAISyncIsConcrete(service,@"NewSyncService")){
                id context=nil;
                CSAINativeSyncRequestFrame *frame=CSAISyncAccountRequestFrame;
                if(scene==12 && frame.context && !frame.claimed && frame.epoch==epoch){
                    // One wrapper scope proves ownership of one concrete create.
                    // Claim before the original or any reentrant eligibility getter.
                    frame.claimed=YES;context=frame.context;bindService=YES;
                }else{
                    NSNumber *boundEpoch=objc_getAssociatedObject(service,CSAISyncServiceEpochKey);
                    if(boundEpoch && boundEpoch.unsignedIntegerValue==epoch)
                        context=CSAISyncCaptureContext(epoch);
                }
                if(context){
                    observation=[CSAINativeSyncObservation new];observation.context=context;
                    observation.service=service;observation.epoch=epoch;
                    // A nested native creation replaces this identity. The old
                    // frame must not attach its context to the newer event ID.
                    objc_setAssociatedObject(service,CSAISyncTransactionKey,observation,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                }
            }
        } @catch(__unused NSException *exception) {}
        bool accepted=((bool(*)(id,SEL,unsigned int))originalCreate)(service,create,scene);
        @try {CSAISyncAttachCreated(service,observation,bindService,accepted);} @catch(__unused NSException *exception) {}
        return accepted;
    });
    MSHookMessageEx(cls,create,createReplacement,&originalCreate);
    SEL returned=NSSelectorFromString(@"MessageReturn:Event:");__block IMP originalReturn=NULL;
    IMP returnReplacement=imp_implementationWithBlock(^(id service,id wrapper,unsigned int event){
        NSUInteger epoch=CSBackupAccountEpoch();
        @try {CSAISyncAttachResponse(service,wrapper,event,epoch);} @catch(__unused NSException *exception) {}
        ((void(*)(id,SEL,id,unsigned int))originalReturn)(service,returned,wrapper,event);
    });
    MSHookMessageEx(cls,returned,returnReplacement,&originalReturn);
    SEL handled=NSSelectorFromString(@"HandleSyncResp:handleResult:");__block IMP originalHandle=NULL;
    IMP handleReplacement=imp_implementationWithBlock(^(id service,id response,bool processed){
        NSUInteger epoch=CSBackupAccountEpoch();CSAINativeSyncObservation *observation=nil;
        @try {observation=CSAISyncTakeCompletion(service,response,processed,epoch);} @catch(__unused NSException *exception) {}
        ((void(*)(id,SEL,id,bool))originalHandle)(service,handled,response,processed);
        if(!observation)return;
        NSTimeInterval observed=NSProcessInfo.processInfo.systemUptime;
        // Native key/status/extension work was queued to main before the result
        // callback. Stay behind it and never reinterpret an old queued result as
        // newly healthy after a full fallback interval has elapsed.
        dispatch_async(dispatch_get_main_queue(),^{
            @try {
                NSTimeInterval now=NSProcessInfo.processInfo.systemUptime;
                if(!isfinite(observed) || !isfinite(now) || now<observed || now-observed>=45 ||
                   observation.epoch!=CSBackupAccountEpoch() || observation.service!=service ||
                   !CSAISyncTerminalResponse(response) || !CSAISyncNativeIdle(service))return;
                [CSAIReplyManager.sharedManager nativeFullSyncCompletedWithContext:observation.context];
            } @catch(__unused NSException *exception) {}
        });
    });
    MSHookMessageEx(cls,handled,handleReplacement,&originalHandle);
}
