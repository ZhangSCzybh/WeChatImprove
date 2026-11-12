// Keep the production manager, native coordinator/environment/ABI dispatcher,
// event normalizer and durable store. Reuse isolated storage and recording sends.
#import "NativeSyncIntegrationFixture.h"
#import "CSAutomationNativeSync.h"
@interface CSAutomationManager (IntegrationControl)
- (void)stopBackgroundSync;
- (void)refreshBackgroundSync;
- (void)backgroundSyncTick;
@end

static AutomationTestManager *integrationManager;
static NSMutableDictionary<NSString *,id> *integrationServices;
static NSString *nativeAccountContext=@"outside-context";
static NSURL *integrationRoot;
static NSUInteger integrationHooks,syncLookups;
static dispatch_block_t duringSelfContact;
static void (^duringServiceLookup)(NSString *name,NSUInteger lookup);
static NSMutableArray<NSString *> *integrationTrace;

@interface IntegrationPat : NSObject
@property(nonatomic,copy) NSString *fromUserName,*pattedUserName;
@property(nonatomic) long long serverId;
@property(nonatomic) unsigned long long createTime;
@end
@implementation IntegrationPat @end

@interface NewSyncService : NSObject {
@public
    _Bool m_bHasInit,m_bNeedSync,m_bSyncOperating,m_bIsSyncPause;
    unsigned int m_syncEventID;
}
@property(nonatomic) NSUInteger setters,notifies,handles,resumes,resets;
@property(nonatomic) int lastScene;
@property(nonatomic) BOOL throwNotify;
@property(nonatomic,strong) NSException *nativeException;
@property(nonatomic,copy) dispatch_block_t duringNotify;
- (void)setNeedSyncWithScene:(int)scene;
- (_Bool)NotifyToSync;
- (void)HandleSyncResp:(id)response handleResult:(_Bool)processed;
- (void)makeSyncResume;
- (void)resetGettingData;
@end
@implementation NewSyncService
- (instancetype)init {if((self=[super init])){m_bHasInit=1;_nativeException=[NSException exceptionWithName:@"ContextNative" reason:@"fixture" userInfo:nil];}return self;}
- (void)setNeedSyncWithScene:(int)scene {self.setters++;self.lastScene=scene;m_bNeedSync=1;[integrationTrace addObject:@"native-set-need"];}
- (_Bool)NotifyToSync {
    CHECK(NSThread.isMainThread);self.notifies++;CHECK(self.notifies<20);
    CHECK([nativeAccountContext isEqual:account]);[integrationTrace addObject:@"native-notify-with-account"];
    if(self.throwNotify)@throw self.nativeException;
    m_bNeedSync=0;if(self.duringNotify)self.duringNotify();return 1;
}
- (void)HandleSyncResp:(id)response handleResult:(_Bool)processed {(void)response;(void)processed;self.handles++;}
- (void)makeSyncResume {self.resumes++;m_bIsSyncPause=0;}
- (void)resetGettingData {self.resets++;m_bSyncOperating=0;m_syncEventID=0;}
@end

// Use the native ivar name and a real NSProxy. Its forwarding, rather than a
// service IMP call, establishes and then restores the account's context.
@interface MMServiceWrapper : NSProxy {
@public
    id m_service;
    NSString *_fixtureAccount;
    NSUInteger _notifyForwards,_forwards,_contextRestores;
}
@end
@implementation MMServiceWrapper
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {return [m_service methodSignatureForSelector:selector];}
- (void)forwardInvocation:(NSInvocation *)invocation {
    NSString *previous=nativeAccountContext;nativeAccountContext=_fixtureAccount;_forwards++;
    if(invocation.selector==@selector(NotifyToSync)){_notifyForwards++;[integrationTrace addObject:@"wrapper-push-account"];}
    @try {[invocation invokeWithTarget:m_service];}
    @finally {nativeAccountContext=previous;_contextRestores++;if(invocation.selector==@selector(NotifyToSync))[integrationTrace addObject:@"wrapper-restore-account"];}
}
- (BOOL)respondsToSelector:(SEL)selector {return [m_service respondsToSelector:selector];}
- (id)forwardingTargetForSelector:(SEL)selector {(void)selector;return nil;}
@end
static MMServiceWrapper *Wrap(id service) {
    MMServiceWrapper *wrapper=[MMServiceWrapper alloc];wrapper->m_service=service;wrapper->_fixtureAccount=[account copy];return wrapper;
}
@interface CContactMgr : AutomationContacts
- (id)getSelfContact;
@end
@implementation CContactMgr
- (id)getSelfContact {
    CHECK([nativeAccountContext isEqual:account]);
    dispatch_block_t callback=duringSelfContact;duringSelfContact=nil;if(callback)callback();
    if(!accountAvailable)return nil;AutomationContact *contact=[AutomationContact new];contact.m_nsUsrName=account;return contact;
}
@end
@interface CMessageMgr : AutomationMessages @end
@implementation CMessageMgr @end
@interface MMContext : NSObject
+ (id)currentContext;
- (id)getService:(Class)cls;
@end
@implementation MMContext
+ (id)currentContext {static MMContext *center;static dispatch_once_t once;dispatch_once(&once,^{center=[self new];});return center;}
- (id)getService:(Class)cls {
    NSString *name=NSStringFromClass(cls);id receiver=integrationServices[name];
    if([name isEqual:@"NewSyncService"])syncLookups++;
    if(duringServiceLookup)duringServiceLookup(name,syncLookups);
    return receiver;
}
@end
void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original) {
    CHECK(NSThread.isMainThread);Method method=class_getInstanceMethod(cls,selector);CHECK(method && replacement && original);
    *original=method_getImplementation(method);class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));integrationHooks++;
}
static id SharedIntegrationManager(id receiver,SEL selector) {(void)receiver;(void)selector;return integrationManager;}
static IMP originalBundleInfo;
static id IntegrationBundleInfo(id receiver,SEL selector) {
    return receiver==NSBundle.mainBundle?@{@"CFBundleShortVersionString":@"8.0.80"}:((id(*)(id,SEL))originalBundleInfo)(receiver,selector);
}
static void InstallIntegration(void) {
    Method info=class_getInstanceMethod(NSBundle.class,@selector(infoDictionary));originalBundleInfo=method_setImplementation(info,(IMP)IntegrationBundleInfo);
    @try {CSAutomationInstallNativeSync();}@finally {method_setImplementation(info,originalBundleInfo);}
    CHECK(CSAutomationNativeSyncAvailable() && integrationHooks==4);
    Method shared=class_getClassMethod(CSAutomationManager.class,@selector(sharedManager));CHECK(shared);method_setImplementation(shared,(IMP)SharedIntegrationManager);
}
static void Pump(void) {for(NSUInteger i=0;i<4;i++)Drain();}
static void FlushIntegration(void) {
    Pump();__block BOOL ioDone=NO;dispatch_async([integrationManager valueForKey:@"io"],^{dispatch_async(dispatch_get_main_queue(),^{ioDone=YES;});});
    Wait(^BOOL{return ioDone;});Pump();
}
static NewSyncService *Setup(NSString *name) {
    if(integrationManager){[NSNotificationCenter.defaultCenter removeObserver:integrationManager];[integrationManager stopBackgroundSync];}
    integrationManager=nil;epoch++;wall+=1;uptime+=1;account=@"alice";
    authorized=YES;backupReady=YES;suspended=NO;contactsAvailable=YES;accountAvailable=YES;protectedAvailable=NO;backgroundWorkAvailable=YES;
    duringSelfContact=nil;duringServiceLookup=nil;syncLookups=0;nativeAccountContext=@"outside-context";
    integrationTrace=[NSMutableArray array];sent=[NSMutableArray array];pats=[NSMutableArray array];revoked=[NSMutableArray array];observations=[NSMapTable strongToStrongObjectsMapTable];sendCount=0;patCount=0;
    testRoot=[integrationRoot URLByAppendingPathComponent:name isDirectory:YES];
    NewSyncService *service=[NewSyncService new];integrationServices=[@{@"NewSyncService":Wrap(service),@"CContactMgr":Wrap([CContactMgr new]),@"CMessageMgr":[CMessageMgr new]} mutableCopy];
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    integrationManager=[AutomationTestManager new];[integrationManager start];Wait(^BOOL{return integrationManager.ready;});
    CHECK([[[CSMessageNativeEnvironment new] currentAccountID] isEqual:account]);
    NSMutableDictionary *back=Module(integrationManager,@"patBack"),*reply=Module(integrationManager,@"patReply");
    [back addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"friends":@[@"bob"],@"delay":@0,@"revoke":@NO}];
    [reply addEntriesFromDictionary:@{@"enabled":@YES,@"groups":@[@"room@chatroom"],@"friends":@[@"bob"],@"delay":@0,@"contents":@[@"integration pat answer"],@"mention":@YES}];
    Save(integrationManager,@{@"patBack":back,@"patReply":reply});
    UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];FlushIntegration();
    CHECK(!service.notifies && !sendCount && !patCount);[integrationTrace removeAllObjects];return service;
}
static IntegrationPat *Pat(long long server) {
    IntegrationPat *pat=[IntegrationPat new];pat.fromUserName=@"bob";pat.pattedUserName=account;pat.serverId=server;pat.createTime=(unsigned long long)wall*1000;return pat;
}
static void DiskClaims(long long server,NSString *conversation,NSUInteger count) {
    NSURL *file=[[CSAutomationFileURL(testRoot,account) URLByDeletingPathExtension] URLByAppendingPathExtension:@"runtime.plist"];
    NSData *data=[NSData dataWithContentsOfURL:file];CHECK(data.length>0);
    NSDictionary *runtime=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
    CHECK([runtime[@"account"] isEqual:account] && [runtime[@"records"] count]==count);
    NSString *identity=[NSString stringWithFormat:@"%@|%@|pat:%lld",account,conversation,server];
    for(NSString *action in @[@"patBack",@"patReply"]){NSUInteger matches=0;for(NSDictionary *record in runtime[@"records"])if([record[@"action"] isEqual:action] && [record[@"ids"] containsObject:identity])matches++;CHECK(matches==1);}
}
static void GroupEventThroughWrapper(void) {
    NewSyncService *service=Setup(@"group-event");MMServiceWrapper *wrapper=integrationServices[@"NewSyncService"];
    CHECK((id)wrapper!=service);IntegrationPat *event=Pat(13001);
    service.duringNotify=^{[integrationManager receivePat:event conversation:@"room@chatroom" epoch:epoch];};
    NSTimeInterval started=NSProcessInfo.processInfo.systemUptime;NSTimeInterval eventClock=uptime;
    [service setNeedSyncWithScene:63];FlushIntegration();
    printf("Group integration observation: setters=%lu notify=%lu wrapperNotify=%lu text=%lu pat=%lu background=%d protected=%d context=%s\n",(unsigned long)service.setters,(unsigned long)service.notifies,(unsigned long)wrapper->_notifyForwards,(unsigned long)sendCount,(unsigned long)patCount,UIApplication.sharedApplication.applicationState==UIApplicationStateBackground,protectedAvailable,nativeAccountContext.UTF8String);fflush(stdout);
    CHECK(service.notifies==1);Wait(^BOOL{return sendCount==1 && patCount==1;});
    CHECK(wrapper->_notifyForwards==1 && [nativeAccountContext isEqual:@"outside-context"]);
    CHECK(uptime==eventClock && NSProcessInfo.processInfo.systemUptime-started<2);
    CHECK(UIApplication.sharedApplication.applicationState==UIApplicationStateBackground && !protectedAvailable);
    CHECK([sent.lastObject[@"target"] isEqual:@"room@chatroom"] && [sent.lastObject[@"mentions"] isEqual:@[@"bob"]]);DiskClaims(13001,@"room@chatroom",2);
    CHECK(([integrationTrace isEqual:@[@"native-set-need",@"wrapper-push-account",@"native-notify-with-account",@"wrapper-restore-account"]]));
    [service setNeedSyncWithScene:63];FlushIntegration();CHECK(service.notifies==2 && wrapper->_notifyForwards==2 && sendCount==1 && patCount==1);DiskClaims(13001,@"room@chatroom",2);
    printf("Real core -> real manager -> registered NSProxy context -> synchronous group pat -> durable patBack/patReply claims -> one text + one pat; repeat deduplicated\n");
}
static void WrapperIdentityAndLifecycle(void) {
    NewSyncService *service=Setup(@"wrapper-wake");MMServiceWrapper *wrapper=integrationServices[@"NewSyncService"];
    service->m_bNeedSync=1;CSAutomationWakePendingNativeSync(wrapper,epoch);FlushIntegration();CHECK(service.notifies==1 && wrapper->_notifyForwards==1);
    service=Setup(@"unregistered-wrapper");wrapper=integrationServices[@"NewSyncService"];MMServiceWrapper *unregistered=Wrap(service);
    service->m_bNeedSync=1;CSAutomationWakePendingNativeSync(unregistered,epoch);FlushIntegration();CHECK(!service.notifies && !unregistered->_notifyForwards);
    CSAutomationWakePendingNativeSync(wrapper,epoch);FlushIntegration();CHECK(service.notifies==1 && wrapper->_notifyForwards==1);

    service=Setup(@"wrapper-registered-for-other-service");wrapper=integrationServices[@"NewSyncService"];
    MMServiceWrapper *otherRegistration=Wrap(service);id contacts=integrationServices[@"CContactMgr"];
    integrationServices[@"CContactMgr"]=otherRegistration;
    CHECK([[CSMessageNativeEnvironment new] serviceNamed:@"CContactMgr"]==otherRegistration);
    integrationServices[@"CContactMgr"]=contacts;service->m_bNeedSync=1;
    CSAutomationWakePendingNativeSync(otherRegistration,epoch);FlushIntegration();CHECK(!service.notifies && !otherRegistration->_notifyForwards);
    CSAutomationWakePendingNativeSync(wrapper,epoch);FlushIntegration();CHECK(service.notifies==1 && wrapper->_notifyForwards==1);

    service=Setup(@"wrong-wrapper");wrapper=integrationServices[@"NewSyncService"];
    NewSyncService *other=[NewSyncService new];MMServiceWrapper *wrong=Wrap(other);integrationServices[@"NewSyncService"]=wrong;
    [service setNeedSyncWithScene:4];FlushIntegration();CHECK(!service.notifies && !other.notifies && !wrong->_notifyForwards);
    integrationServices[@"NewSyncService"]=wrapper;CSAutomationWakePendingNativeSync(wrapper,epoch);FlushIntegration();CHECK(service.notifies==1 && !other.notifies);

    service=Setup(@"replacement-wrapper-same-raw");wrapper=integrationServices[@"NewSyncService"];MMServiceWrapper *replacement=Wrap(service);
    integrationServices[@"NewSyncService"]=replacement;[service setNeedSyncWithScene:5];FlushIntegration();
    CHECK(service.notifies==1 && replacement->_notifyForwards==1 && !wrapper->_notifyForwards);
    CHECK([nativeAccountContext isEqual:@"outside-context"]);
    printf("Lifecycle normalizes trusted wrapper; unregistered and wrong-target proxies rejected; replacement proxy for same raw is invoked through current wrapper\n");
}
static void EpochAndQualification(void) {
    NewSyncService *service=Setup(@"epoch-aba");MMServiceWrapper *wrapper=integrationServices[@"NewSyncService"];NSUInteger oldEpoch=epoch;
    [service setNeedSyncWithScene:7];epoch+=2;FlushIntegration();CHECK(!service.notifies && integrationServices[@"NewSyncService"]==wrapper);
    CSAutomationWakePendingNativeSync(wrapper,oldEpoch);FlushIntegration();CHECK(!service.notifies);

    for(NSUInteger variant=0;variant<5;variant++){
        service=Setup([NSString stringWithFormat:@"qualification-%lu",(unsigned long)variant]);
        [service setNeedSyncWithScene:8];
        if(variant==0)authorized=NO;
        if(variant==1)accountAvailable=NO;
        if(variant==2)suspended=YES;
        if(variant==3)UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
        if(variant==4)[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
        FlushIntegration();CHECK(!service.notifies);
    }

    service=Setup(@"qualification-reentry");duringSelfContact=^{authorized=NO;};[service setNeedSyncWithScene:9];FlushIntegration();CHECK(!service.notifies);
    service=Setup(@"configuration-reentry");__block BOOL editDone=NO,editOK=NO;
    duringSelfContact=^{
        NSMutableDictionary *back=Module(integrationManager,@"patBack"),*reply=Module(integrationManager,@"patReply");back[@"enabled"]=@NO;reply[@"enabled"]=@NO;
        [integrationManager updateConfiguration:@{@"patBack":back,@"patReply":reply} completion:^(BOOL ok,NSError *error){(void)error;editOK=ok;editDone=YES;}];
    };
    [service setNeedSyncWithScene:9];FlushIntegration();Wait(^BOOL{return editDone;});CHECK(editOK && !service.notifies);
    service=Setup(@"lookup-reentry");NewSyncService *other=[NewSyncService new];MMServiceWrapper *wrong=Wrap(other);__block BOOL replaced=NO;
    duringServiceLookup=^(NSString *name,NSUInteger lookup){(void)lookup;if(!replaced && [name isEqual:@"NewSyncService"]){replaced=YES;integrationServices[@"NewSyncService"]=wrong;}};
    [service setNeedSyncWithScene:10];FlushIntegration();CHECK(replaced && !service.notifies && !other.notifies);
    duringServiceLookup=nil;
    printf("Same account/proxy ABA epoch, stale epoch, authorization/account/suspension/foreground, configuration save and native lookup/getter reentry all reject stale requests\n");
}
static void PrivateEventAndExceptionContext(void) {
    NewSyncService *service=Setup(@"private-event");MMServiceWrapper *wrapper=integrationServices[@"NewSyncService"];IntegrationPat *event=Pat(13002);
    service.duringNotify=^{[integrationManager receivePat:event conversation:@"bob" epoch:epoch];};
    [service setNeedSyncWithScene:4];FlushIntegration();Wait(^BOOL{return sendCount==1 && patCount==1;});
    CHECK(service.notifies==1 && wrapper->_notifyForwards==1 && [sent.lastObject[@"target"] isEqual:@"bob"]);DiskClaims(13002,@"bob",2);
    service=Setup(@"throwing-notify-context");wrapper=integrationServices[@"NewSyncService"];service.throwNotify=YES;
    [service setNeedSyncWithScene:4];FlushIntegration();CHECK(service.notifies==1 && wrapper->_notifyForwards==1 && [nativeAccountContext isEqual:@"outside-context"]);
    FlushIntegration();CHECK(service.notifies==1);service.throwNotify=NO;[service setNeedSyncWithScene:4];FlushIntegration();CHECK(service.notifies==2 && wrapper->_notifyForwards==2);
    printf("Private event also retains durable dual action; proxy restores outer context after native exception and new event can recover\n");
}
static void CompatibilityTimerRecoversToWrapper(void) {
    NewSyncService *service=Setup(@"compatibility-wrapper-recovery");MMServiceWrapper *wrapper=integrationServices[@"NewSyncService"];
    [integrationServices removeObjectForKey:@"NewSyncService"];
    [integrationManager refreshBackgroundSync];CHECK([integrationManager valueForKey:@"backgroundSyncTimer"]!=nil);
    CHECK(!service.notifies);NSTimeInterval elapsed=uptime;
    integrationServices[@"NewSyncService"]=wrapper;service->m_bNeedSync=1;
    [integrationManager backgroundSyncTick];CHECK([integrationManager valueForKey:@"backgroundSyncTimer"]==nil);
    FlushIntegration();CHECK(service.notifies==1 && wrapper->_notifyForwards==1 && uptime==elapsed);
    CHECK([nativeAccountContext isEqual:@"outside-context"] && [integrationManager valueForKey:@"backgroundSyncTimer"]==nil);
    printf("Missing service retains compatibility timer; recovered wrapper tick stops timer and immediately drives existing need without advancing uptime\n");
}
int main(int argc,const char *argv[]) {@autoreleasepool {
    CHECK(argc==3);integrationRoot=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];InstallIntegration();
    GroupEventThroughWrapper();
    if([@(argv[2]) isEqual:@"event-only"]){printf("Automation native sync integration event: %lu checks passed\n",(unsigned long)checks);return 0;}
    WrapperIdentityAndLifecycle();EpochAndQualification();PrivateEventAndExceptionContext();CompatibilityTimerRecoversToWrapper();
    printf("Automation native sync integration: %lu checks passed; production manager/environment/ABI/core/store, NSProxy account forwarding, group/private durable dual actions and identity/epoch/eligibility fences\n",(unsigned long)checks);
    return 0;
}}
