#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import <math.h>
#import "CSAINativeSyncObserver.h"
#import "CSAIReplyManager.h"
#import "CSBackupBootstrap.h"

static NSUInteger checks,hookCalls,captureCalls,completionCalls;
static NSUInteger accountEpoch=50;
static BOOL ingressEnabled=YES,contextAllowed=YES,throwCapture,throwCompletion;
static id latestContext,completedContext;
static void (^duringCapture)(void);
static NSMutableArray<NSString *> *trace;
#define CHECK(c) do { checks++; if(!(c)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c); exit(1); } } while(0)

@interface CSAIReplyManager (ObserverFixture)
- (nullable id)captureBackgroundSyncContextForEpoch:(NSUInteger)epoch;
- (void)nativeFullSyncCompletedWithContext:(id _Nonnull)context;
@end
@implementation CSAIReplyManager
+ (instancetype)sharedManager { static CSAIReplyManager *manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager; }
- (id)captureBackgroundSyncContextForEpoch:(NSUInteger)epoch {
    CHECK(NSThread.isMainThread);captureCalls++;[trace addObject:@"capture"];
    if(throwCapture)[NSException raise:@"ObserverMetadata" format:@"capture"];
    void (^callback)(void)=duringCapture;if(callback)callback();
    latestContext=contextAllowed && epoch==accountEpoch?[NSObject new]:nil;return latestContext;
}
- (void)nativeFullSyncCompletedWithContext:(id)context {
    CHECK(NSThread.isMainThread);completionCalls++;completedContext=context;[trace addObject:@"complete"];
    if(throwCompletion)[NSException raise:@"ObserverMetadata" format:@"completion"];
}
@end
BOOL CSAIReplyMessageIngressEnabled(void) {return ingressEnabled;}
NSUInteger CSBackupAccountEpoch(void) {return accountEpoch;}

void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original) {
    CHECK(NSThread.isMainThread);Method method=class_getInstanceMethod(cls,selector);CHECK(method && original && replacement);
    *original=method_getImplementation(method);
    class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));hookCalls++;
}

@interface TestSyncRequest : NSObject
@property unsigned int selectorValue;
@property BOOL throwSelector;
- (unsigned int)selector;
@end
@implementation TestSyncRequest
- (unsigned int)selector {if(self.throwSelector)[NSException raise:@"ObserverMetadata" format:@"selector"];return self.selectorValue;}
@end
@interface TestSyncResponse : NSObject
@property int retValue;
@property unsigned int continuation;
@property BOOL throwRet,throwContinuation;
- (int)ret;
- (unsigned int)continueFlag;
@end
@implementation TestSyncResponse
- (int)ret {if(self.throwRet)[NSException raise:@"ObserverMetadata" format:@"ret"];return self.retValue;}
- (unsigned int)continueFlag {if(self.throwContinuation)[NSException raise:@"ObserverMetadata" format:@"continue"];return self.continuation;}
@end
@interface TestSyncWrapper : NSObject
@property unsigned int cgi,message;
@property(nonatomic,strong) id request,response;
@property(nonatomic,copy) NSString *throwField;
- (unsigned int)m_uiCgi;
- (unsigned int)m_uiMessage;
- (id)m_pbRequest;
- (id)m_pbResponse;
@end
@implementation TestSyncWrapper
- (void)checkField:(NSString *)field {if([self.throwField isEqual:field])[NSException raise:@"ObserverMetadata" format:@"%@",field];}
- (unsigned int)m_uiCgi {[self checkField:@"cgi"];return self.cgi;}
- (unsigned int)m_uiMessage {[self checkField:@"message"];return self.message;}
- (id)m_pbRequest {[self checkField:@"request"];return self.request;}
- (id)m_pbResponse {[self checkField:@"response"];return self.response;}
@end

@interface TestSyncService : NSObject {
@public
    unsigned int m_syncEventID;
    _Bool m_isGettingData,m_bSyncOperating,m_bSyncOpError,m_bIsSyncPause,m_bNeedSync,m_bHasInit;
}
@property _Bool accepts,acceptOnly,autoHandle,queueIdle,processed;
@property BOOL throwCreate,throwReturn,throwHandle;
@property unsigned int nextEvent,lastScene,lastEvent;
@property NSUInteger createCalls,returnCalls,handleCalls;
@property(nonatomic,strong) id lastWrapper,lastResponse;
@property _Bool lastProcessed;
@property(nonatomic,copy) void (^duringCreate)(void);
@property(nonatomic,copy) void (^afterIdle)(TestSyncService *service);
- (_Bool)creatPBNewSyncEvent:(unsigned int)scene;
- (void)MessageReturn:(id)wrapper Event:(unsigned int)event;
- (void)HandleSyncResp:(id)response handleResult:(_Bool)processed;
@end
static void NativeIdle(TestSyncService *service) {
    service->m_syncEventID=0;service->m_isGettingData=0;service->m_bSyncOperating=0;service->m_bSyncOpError=0;
    service->m_bIsSyncPause=0;service->m_bNeedSync=0;service->m_bHasInit=1;
}
@implementation TestSyncService
- (_Bool)creatPBNewSyncEvent:(unsigned int)scene {
    self.createCalls++;self.lastScene=scene;[trace addObject:@"create"];
    if(self.throwCreate)[NSException raise:@"NativeCreate" format:@"must propagate"];
    if(self->m_isGettingData || self->m_bSyncOperating)return 0;
    _Bool accepted=self.accepts;
    if(accepted && !self.acceptOnly){self->m_syncEventID=self.nextEvent++;self->m_isGettingData=1;self->m_bSyncOperating=1;}
    if(self.duringCreate)self.duringCreate();
    return accepted;
}
- (void)MessageReturn:(id)wrapper Event:(unsigned int)event {
    self.returnCalls++;self.lastWrapper=wrapper;self.lastEvent=event;[trace addObject:@"return"];
    if(self.throwReturn)[NSException raise:@"NativeReturn" format:@"must propagate"];
    if(self.queueIdle)dispatch_async(dispatch_get_main_queue(),^{
        [trace addObject:@"native-idle"];NativeIdle(self);if(self.afterIdle)self.afterIdle(self);
    });
    if(self.autoHandle)[self HandleSyncResp:[wrapper isKindOfClass:TestSyncWrapper.class]?((TestSyncWrapper *)wrapper).response:nil handleResult:self.processed];
}
- (void)HandleSyncResp:(id)response handleResult:(_Bool)processed {
    self.handleCalls++;self.lastResponse=response;self.lastProcessed=processed;[trace addObject:@"handle"];
    if(self.throwHandle)[NSException raise:@"NativeHandle" format:@"must propagate"];
}
@end

static void Drain(void) {
    __block BOOL done=NO;dispatch_async(dispatch_get_main_queue(),^{done=YES;});
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:3];
    while(!done && deadline.timeIntervalSinceNow>0)[NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.002]];
    CHECK(done);
}
static void OffMain(void (^operation)(void)) {
    dispatch_semaphore_t done=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{CHECK(!NSThread.isMainThread);operation();dispatch_semaphore_signal(done);});
    CHECK(!dispatch_semaphore_wait(done,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC)));
}
static void Reset(void) {
    Drain();captureCalls=0;completionCalls=0;accountEpoch=50;ingressEnabled=YES;contextAllowed=YES;
    throwCapture=NO;throwCompletion=NO;latestContext=nil;completedContext=nil;duringCapture=nil;trace=[NSMutableArray array];
}
static void ResetRecording(void) {captureCalls=0;completionCalls=0;latestContext=nil;completedContext=nil;[trace removeAllObjects];}
static TestSyncService *Service(void) {
    TestSyncService *service=[NSClassFromString(@"NewSyncService") new];NativeIdle(service);
    service.accepts=1;service.autoHandle=1;service.queueIdle=1;service.processed=1;service.nextEvent=17;return service;
}
static TestSyncWrapper *Wrapper(void) {
    TestSyncRequest *request=[NSClassFromString(@"NewSyncRequest") new];request.selectorValue=0x40007;
    TestSyncWrapper *wrapper=[NSClassFromString(@"ProtobufCGIWrap") new];wrapper.cgi=138;wrapper.request=request;
    wrapper.response=[NSClassFromString(@"NewSyncResponse") new];return wrapper;
}
static void Bind(TestSyncService *service) {
    CSAIObserveBackgroundSyncRequest(accountEpoch,^{CHECK([service creatPBNewSyncEvent:12]);});
    CHECK(service->m_syncEventID!=0);NativeIdle(service);ResetRecording();service.createCalls=0;
}
static void Begin(TestSyncService *service) {CHECK([service creatPBNewSyncEvent:37]);CHECK(service->m_syncEventID!=0);}
static void Return(TestSyncService *service,TestSyncWrapper *wrapper) {[service MessageReturn:wrapper Event:service->m_syncEventID];}

static NSBundle *fixtureBundle;
static NSDictionary *fixtureInfo;
static IMP originalBundleInfo;
static id BundleInfo(id receiver,SEL selector) {return receiver==fixtureBundle?fixtureInfo:((id(*)(id,SEL))originalBundleInfo)(receiver,selector);}
static void InstallForVersion(id version) {
    fixtureBundle=NSBundle.mainBundle;fixtureInfo=version?@{@"CFBundleShortVersionString":version}:@{};
    Method method=class_getInstanceMethod(NSBundle.class,@selector(infoDictionary));originalBundleInfo=method_setImplementation(method,(IMP)BundleInfo);
    @try {CSAIInstallNativeSyncObserver();}@finally{method_setImplementation(method,originalBundleInfo);fixtureBundle=nil;fixtureInfo=nil;}
}
static Class Register(NSString *name,Class parent) {Class cls=objc_allocateClassPair(parent,name.UTF8String,0);CHECK(cls);objc_registerClassPair(cls);return cls;}
static void RegisterNatives(NSString *mode) {
    Class service=objc_allocateClassPair(TestSyncService.class,"NewSyncService",0);CHECK(service);
    NSString *methodName=nil;const char *encoding=NULL;
    if([mode isEqual:@"create-return-c"]){methodName=@"creatPBNewSyncEvent:";encoding="c@:I";}
    if([mode isEqual:@"create-argument-Q"]){methodName=@"creatPBNewSyncEvent:";encoding="B@:Q";}
    if([mode isEqual:@"create-argument-count"]){methodName=@"creatPBNewSyncEvent:";encoding="B@:";}
    if([mode isEqual:@"return-result-B"]){methodName=@"MessageReturn:Event:";encoding="B@:@I";}
    if([mode isEqual:@"return-event-Q"]){methodName=@"MessageReturn:Event:";encoding="v@:@Q";}
    if([mode isEqual:@"handle-result-B"]){methodName=@"HandleSyncResp:handleResult:";encoding="B@:@B";}
    if([mode isEqual:@"handle-processed-c"]){methodName=@"HandleSyncResp:handleResult:";encoding="v@:@c";}
    if(methodName){SEL selector=NSSelectorFromString(methodName);CHECK(class_addMethod(service,selector,class_getMethodImplementation(TestSyncService.class,selector),encoding));}
    objc_registerClassPair(service);
    Register(@"NewSyncRequest",TestSyncRequest.class);Register(@"NewSyncResponse",TestSyncResponse.class);Register(@"ProtobufCGIWrap",TestSyncWrapper.class);
}

static void Installation(void) {
    __block NSUInteger ran=0;CSAIObserveBackgroundSyncRequest(accountEpoch,^{ran++;});CHECK(ran==1 && !captureCalls);
    InstallForVersion(nil);CHECK(!hookCalls);InstallForVersion(@"8.0.79");CHECK(!hookCalls);InstallForVersion(@8078);CHECK(!hookCalls);
    OffMain(^{CSAIInstallNativeSyncObserver();});CHECK(!hookCalls);
    NSDictionary *before=NSBundle.mainBundle.infoDictionary;InstallForVersion(@"8.0.78");CHECK(hookCalls==3);CHECK(NSBundle.mainBundle.infoDictionary==before || [NSBundle.mainBundle.infoDictionary isEqual:before]);
    InstallForVersion(@"8.0.78");CHECK(hookCalls==3);
}
static void NativeOrderAndFIFO(void) {
    Reset();TestSyncService *service=Service();TestSyncWrapper *wrapper=Wrapper();
    CSAIObserveBackgroundSyncRequest(accountEpoch,^{CHECK([service creatPBNewSyncEvent:12]);});
    id context=latestContext;unsigned int event=service->m_syncEventID;CHECK(captureCalls==1 && event);
    Return(service,wrapper);CHECK(completionCalls==0 && service->m_isGettingData && service->m_syncEventID==event);
    CHECK(service.lastScene==12 && service.lastWrapper==wrapper && service.lastEvent==event && service.lastResponse==wrapper.response && service.lastProcessed);
    CHECK(([trace isEqual:@[@"capture",@"create",@"return",@"handle"]]));
    Drain();CHECK(completionCalls==1 && completedContext==context && !service->m_syncEventID);
    CHECK(([trace isEqual:@[@"capture",@"create",@"return",@"handle",@"native-idle",@"complete"]]));
    [service HandleSyncResp:wrapper.response handleResult:1];Drain();CHECK(completionCalls==1);
    ResetRecording();Begin(service);context=latestContext;Return(service,Wrapper());Drain();CHECK(completionCalls==1 && completedContext==context);
}
static void BindingAndMarkerLifetime(void) {
    Reset();TestSyncService *service=Service();TestSyncWrapper *wrapper=Wrapper();
    CHECK([service creatPBNewSyncEvent:12]);Return(service,wrapper);Drain();CHECK(!captureCalls && !completionCalls);
    Begin(service);Return(service,Wrapper());Drain();CHECK(!captureCalls && !completionCalls);
    Bind(service);Begin(service);Return(service,Wrapper());Drain();CHECK(captureCalls==1 && completionCalls==1);
    accountEpoch++;ResetRecording();Begin(service);Return(service,Wrapper());Drain();CHECK(!captureCalls && !completionCalls);
    Bind(service);Begin(service);Return(service,Wrapper());Drain();CHECK(captureCalls==1 && completionCalls==1);
    Reset();service=Service();
    @try {CSAIObserveBackgroundSyncRequest(accountEpoch,^{[NSException raise:@"MarkerOriginal" format:@"must propagate"];});CHECK(NO);}
    @catch(NSException *exception){CHECK([exception.name isEqual:@"MarkerOriginal"]);}
    ResetRecording();CHECK([service creatPBNewSyncEvent:12]);Return(service,Wrapper());Drain();CHECK(!captureCalls && !completionCalls);
    NativeIdle(service);ResetRecording();CSAIObserveBackgroundSyncRequest(accountEpoch,^{CHECK([service creatPBNewSyncEvent:11]);});Return(service,Wrapper());Drain();
    ResetRecording();Begin(service);Return(service,Wrapper());Drain();CHECK(!captureCalls && !completionCalls);
    Reset();service=Service();CSAIObserveBackgroundSyncRequest(accountEpoch,^{
        @try {CSAIObserveBackgroundSyncRequest(accountEpoch,^{[NSException raise:@"NestedMarker" format:@"fixture"];});}@catch(__unused NSException *exception){}
        CHECK([service creatPBNewSyncEvent:12]);
    });Return(service,Wrapper());Drain();CHECK(completionCalls==1);
    Reset();service=Service();NSUInteger oldEpoch=accountEpoch;accountEpoch++;
    CSAIObserveBackgroundSyncRequest(oldEpoch,^{CHECK([service creatPBNewSyncEvent:12]);});Return(service,Wrapper());Drain();CHECK(!completionCalls);
    ResetRecording();Begin(service);Return(service,Wrapper());Drain();CHECK(!captureCalls && !completionCalls);
}
static void CreationRejections(void) {
    for(NSUInteger kind=0;kind<6;kind++){
        Reset();TestSyncService *service=Service();Bind(service);
        if(kind==0)service.accepts=0;if(kind==1)service.acceptOnly=1;if(kind==2)service->m_isGettingData=1;
        if(kind==3)ingressEnabled=NO;if(kind==4)contextAllowed=NO;if(kind==5)service->m_bSyncOperating=1;
        _Bool accepted=[service creatPBNewSyncEvent:0xF0000001];CHECK(accepted==(kind!=0 && kind!=2 && kind!=5));CHECK(service.lastScene==0xF0000001 && service.createCalls==1);
        [service MessageReturn:Wrapper() Event:service->m_syncEventID];Drain();CHECK(!completionCalls);
    }
    Reset();TestSyncService *service=Service();Bind(service);service.autoHandle=0;Begin(service);Drain();CHECK(!completionCalls); // Acceptance alone proves no coverage.
}
static void ResponseRejections(void) {
    for(NSUInteger kind=0;kind<16;kind++){
        Reset();TestSyncService *service=Service();Bind(service);Begin(service);TestSyncWrapper *wrapper=Wrapper();
        TestSyncRequest *request=wrapper.request;TestSyncResponse *response=wrapper.response;unsigned int event=service->m_syncEventID;
        switch(kind){
            case 0:request.selectorValue=0x40001;break;case 1:request.selectorValue=7;break;
            case 2:wrapper.cgi=139;break;case 3:wrapper.message=1;break;
            case 4:response.retValue=-2006;break;case 5:response.retValue=-1;break;case 6:response.retValue=1;break;
            case 7:response.continuation=1;break;case 8:response.continuation=2;break;case 9:response.continuation=UINT_MAX;break;
            case 10:service.processed=0;break;case 11:event++;break;case 12:service->m_syncEventID++;break;
            case 13:wrapper.request=[TestSyncRequest new];break;case 14:wrapper.response=[TestSyncResponse new];break;
            case 15:wrapper=[TestSyncWrapper new];break;
        }
        [service MessageReturn:wrapper Event:event];Drain();CHECK(!completionCalls);CHECK(service.returnCalls==1 && service.handleCalls==1);
        if(kind==10)CHECK(!service.lastProcessed);
        // A rejected response consumes its token; a later healthy callback is not a retry.
        service->m_syncEventID=event;service.processed=1;[service MessageReturn:Wrapper() Event:event];Drain();CHECK(!completionCalls);
    }
}
static void NativeIdleRejections(void) {
    for(NSUInteger kind=0;kind<8;kind++){
        Reset();TestSyncService *service=Service();Bind(service);Begin(service);
        service.afterIdle=^(TestSyncService *s){switch(kind){
            case 0:s->m_bHasInit=0;break;case 1:s->m_bIsSyncPause=1;break;case 2:s->m_bNeedSync=1;break;
            case 3:s->m_bSyncOpError=1;break;case 4:s->m_syncEventID=88;break;case 5:s->m_isGettingData=1;break;
            case 6:s->m_bSyncOperating=1;break;case 7:accountEpoch++;break;
        }};
        Return(service,Wrapper());Drain();CHECK(!completionCalls);
        NativeIdle(service);Drain();CHECK(!completionCalls); // Clearing flags later cannot revive a consumed completion.
    }
}
static void ServiceEpochAndThreadRejections(void) {
    Reset();TestSyncService *service=Service(),*other=Service();Bind(service);Begin(service);unsigned int event=service->m_syncEventID;
    other->m_syncEventID=event;[other MessageReturn:Wrapper() Event:event];Drain();CHECK(!completionCalls);
    Return(service,Wrapper());Drain();CHECK(completionCalls==1); // Another service cannot consume this service's observation.
    Reset();service=Service();other=Service();Bind(service);Begin(service);service.autoHandle=0;TestSyncWrapper *wrapper=Wrapper();Return(service,wrapper);
    [other HandleSyncResp:wrapper.response handleResult:1];[service HandleSyncResp:wrapper.response handleResult:1];Drain();CHECK(!completionCalls);
    for(NSUInteger stage=0;stage<3;stage++){
        Reset();service=Service();Bind(service);Begin(service);wrapper=Wrapper();
        if(stage==0){accountEpoch++;Return(service,wrapper);}
        if(stage==1){service.autoHandle=0;Return(service,wrapper);accountEpoch++;[service HandleSyncResp:wrapper.response handleResult:1];}
        if(stage==2){Return(service,wrapper);accountEpoch++;}
        Drain();CHECK(!completionCalls);
    }
    Reset();service=Service();OffMain(^{CSAIObserveBackgroundSyncRequest(accountEpoch,^{CHECK([service creatPBNewSyncEvent:12]);});});NativeIdle(service);ResetRecording();
    Begin(service);Return(service,Wrapper());Drain();CHECK(!captureCalls && !completionCalls);
    Reset();service=Service();Bind(service);Begin(service);wrapper=Wrapper();OffMain(^{Return(service,wrapper);});Drain();CHECK(!completionCalls);
    Reset();service=Service();Bind(service);Begin(service);wrapper=Wrapper();service.autoHandle=0;Return(service,wrapper);
    OffMain(^{[service HandleSyncResp:wrapper.response handleResult:1];});Drain();CHECK(!completionCalls);
}
static void MetadataAndNativeExceptions(void) {
    for(NSUInteger kind=0;kind<8;kind++){
        Reset();TestSyncService *service=Service();Bind(service);TestSyncWrapper *wrapper=Wrapper();
        if(kind==0)throwCapture=YES;Begin(service);
        switch(kind){
            case 1:wrapper.throwField=@"cgi";break;case 2:wrapper.throwField=@"message";break;
            case 3:wrapper.throwField=@"request";break;case 4:wrapper.throwField=@"response";break;
            case 5:((TestSyncRequest *)wrapper.request).throwSelector=YES;break;
            case 6:((TestSyncResponse *)wrapper.response).throwRet=YES;break;
            case 7:((TestSyncResponse *)wrapper.response).throwContinuation=YES;break;
        }
        Return(service,wrapper);Drain();CHECK(!completionCalls && service.returnCalls==1 && service.handleCalls==1);
    }
    Reset();TestSyncService *service=Service();Bind(service);Begin(service);throwCompletion=YES;Return(service,Wrapper());Drain();CHECK(completionCalls==1);
    NSArray *names=@[@"NativeCreate",@"NativeReturn",@"NativeHandle"];
    for(NSUInteger kind=0;kind<3;kind++){
        Reset();service=Service();Bind(service);if(kind)Begin(service);
        service.throwCreate=kind==0;service.throwReturn=kind==1;service.throwHandle=kind==2;
        @try {if(kind==0)[service creatPBNewSyncEvent:0xF0000002];else Return(service,Wrapper());CHECK(NO);}
        @catch(NSException *exception){CHECK([exception.name isEqual:names[kind]]);}
        Drain();CHECK(!completionCalls);
        if(kind==0)CHECK(service.createCalls==1 && service.lastScene==0xF0000002);
        if(kind==1)CHECK(service.returnCalls==1 && !service.handleCalls);
        if(kind==2)CHECK(service.returnCalls==1 && service.handleCalls==1);
    }
}
static void CreationReentry(void) {
    Reset();TestSyncService *service=Service();Bind(service);__block id innerContext;
    __weak TestSyncService *weak=service;
    service.duringCreate=^{
        TestSyncService *current=weak;current.duringCreate=nil;NativeIdle(current);
        CHECK([current creatPBNewSyncEvent:99]);innerContext=latestContext;
    };
    Begin(service);CHECK(captureCalls==2 && service.lastScene==99);Return(service,Wrapper());Drain();CHECK(completionCalls==1 && completedContext==innerContext);
}
static void MarkerClaimReentry(void) {
    for(NSUInteger rejection=0;rejection<3;rejection++){
        Reset();TestSyncService *first=Service(),*second=Service();
        if(rejection==0)first.duringCreate=^{CHECK([second creatPBNewSyncEvent:12]);};
        if(rejection==1)first.accepts=0;
        if(rejection==2)first.throwCreate=YES;
        CSAIObserveBackgroundSyncRequest(accountEpoch,^{
            if(rejection==0)CHECK([first creatPBNewSyncEvent:12]);
            else {
                @try {CHECK(![first creatPBNewSyncEvent:12]);CHECK(rejection==1);}
                @catch(NSException *exception){CHECK(rejection==2 && [exception.name isEqual:@"NativeCreate"]);}
                CHECK([second creatPBNewSyncEvent:12]);
            }
        });
        id firstContext=latestContext;
        Return(second,Wrapper());if(rejection==0)Return(first,Wrapper());Drain();
        CHECK(completionCalls==(rejection==0?1:0));if(!rejection)CHECK(completedContext==firstContext);
        ResetRecording();Begin(second);Return(second,Wrapper());Drain();CHECK(!captureCalls && !completionCalls);
    }
    // A getter crossed while capturing the inner scope cannot claim the outer
    // scope, nor bind a raw service before the account-wrapped request begins.
    Reset();TestSyncService *first=Service(),*second=Service();
    CSAIObserveBackgroundSyncRequest(accountEpoch,^{
        duringCapture=^{duringCapture=nil;CHECK([second creatPBNewSyncEvent:12]);};
        CSAIObserveBackgroundSyncRequest(accountEpoch,^{CHECK([first creatPBNewSyncEvent:12]);});
    });
    Return(second,Wrapper());Return(first,Wrapper());Drain();CHECK(completionCalls==1);
    ResetRecording();Begin(second);Return(second,Wrapper());Drain();CHECK(!captureCalls && !completionCalls);
}
static NSTimeInterval fixtureUptime;
static NSTimeInterval Uptime(__unused id receiver,__unused SEL selector) {return fixtureUptime;}
static void LateTerminalChangesAndAge(void) {
    for(NSUInteger stage=0;stage<4;stage++){
        Reset();TestSyncService *service=Service();Bind(service);Begin(service);TestSyncWrapper *wrapper=Wrapper();TestSyncResponse *response=wrapper.response;
        if(stage<2){
            service.autoHandle=0;Return(service,wrapper);
            response.throwRet=stage==0;response.throwContinuation=stage==1;
            [service HandleSyncResp:response handleResult:1];
        }else{
            Return(service,wrapper);if(stage==2)response.retValue=-2006;else response.continuation=1;
        }
        Drain();CHECK(!completionCalls && service.returnCalls==1 && service.handleCalls==1);
        response.throwRet=NO;response.throwContinuation=NO;response.retValue=0;response.continuation=0;
        [service HandleSyncResp:response handleResult:1];Drain();CHECK(!completionCalls);
    }
    // Exercise the actual production age/finite-clock check without a 45-second
    // sleep. The Foundation getter is restored before leaving every iteration.
    const NSTimeInterval queuedTimes[]={144.999,145,99,NAN,INFINITY};
    for(NSUInteger index=0;index<sizeof(queuedTimes)/sizeof(*queuedTimes);index++){
        Reset();TestSyncService *service=Service();Bind(service);Begin(service);
        Method method=class_getInstanceMethod(object_getClass(NSProcessInfo.processInfo),@selector(systemUptime));CHECK(method);
        IMP previous=method_setImplementation(method,(IMP)Uptime);fixtureUptime=100;
        @try {Return(service,Wrapper());fixtureUptime=queuedTimes[index];Drain();CHECK(completionCalls==(index==0?1:0));}
        @finally {method_setImplementation(method,previous);}
    }
}
int main(int argc,const char *argv[]) { @autoreleasepool {
    trace=[NSMutableArray array];NSString *mode=argc>1?[NSString stringWithUTF8String:argv[1]]:@"all";RegisterNatives(mode);
    if(![mode isEqual:@"all"]){InstallForVersion(@"8.0.78");CHECK(!hookCalls);printf("AI native sync observer ABI rejection %s: %lu checks passed\n",mode.UTF8String,(unsigned long)checks);return 0;}
    Installation();NativeOrderAndFIFO();BindingAndMarkerLifetime();CreationRejections();ResponseRejections();NativeIdleRejections();ServiceEpochAndThreadRejections();MetadataAndNativeExceptions();CreationReentry();MarkerClaimReentry();LateTerminalChangesAndAge();
    printf("AI native sync observer: %lu checks passed; real production hooks, original ordering/arguments/results, epoch-bound marker, full terminal response, main FIFO idle, rejection/exception/reentry fences\n",(unsigned long)checks);
} return 0; }
