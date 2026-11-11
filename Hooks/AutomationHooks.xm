#import "../Controllers/CSAutomationManager.h"
#import "../Controllers/CSAutomationEventAdapter.h"
#import "../Controllers/CSAutomationNativeAdapter.h"
#import "../Controllers/CSBackupBootstrap.h"
#import <objc/runtime.h>
#import <substrate.h>
#if __has_include(<UIKit/UIApplication.h>)
#import <UIKit/UIApplication.h>
#else
static NSNotificationName const UIApplicationDidBecomeActiveNotification=@"UIApplicationDidBecomeActiveNotification";
static NSNotificationName const UIApplicationProtectedDataDidBecomeAvailable=@"UIApplicationProtectedDataDidBecomeAvailable";
#endif
#include <string.h>

static BOOL CSAutomationAsyncHookInstalled,CSAutomationAddHookInstalled,CSAutomationPatIngressInstalled;
static BOOL CSAutomationSyncHookInstalled,CSAutomationBatchHookInstalled;
static BOOL CSAutomationIngressMethod(Class cls,NSString *name,NSString *result,NSArray<NSString *> *arguments) {
    Method method=class_getInstanceMethod(cls,NSSelectorFromString(name));
    if(!method || method_getNumberOfArguments(method)!=arguments.count+2)return NO;
    char type[64]={0};method_getReturnType(method,type,sizeof(type));if(strcmp(type,result.UTF8String))return NO;
    for(NSUInteger index=0;index<arguments.count;index++){
        method_getArgumentType(method,(unsigned int)index+2,type,sizeof(type));
        if([arguments[index] isEqual:@"@"]){if(type[0]!='@')return NO;}else if(strcmp(type,arguments[index].UTF8String))return NO;
    }
    return YES;
}
static BOOL CSAutomationRememberOwnedMessage(id session,id wrap,NSUInteger epoch) {
    if(!NSThread.isMainThread || epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended() ||
       ![session isKindOfClass:NSString.class] || ![session length])return NO;
    @try {
        if(!CSAutomationIsOwnedSend(wrap))return NO;
        id from=CSMessageActionNativeObject(wrap,@"m_nsFromUsr");
        if(![from isKindOfClass:NSString.class] || ![from length] || [from hasSuffix:@"@chatroom"])return NO;
        NSString *account=CSAutomationManager.sharedManager.accountID;
        // The early ingress hook can run before the manager has loaded its
        // account. This tagged outgoing native wrap is a trusted registration
        // source, never permission to send. Do not misfile IDs under an empty
        // account, or accept a wrap which contradicts a known manager account.
        if(account.length){if(![account isEqual:from])return NO;}else account=from;
        CSAutomationRememberOwnedSend(wrap,account,session);return YES;
    }
    @catch(__unused NSException *exception) {return NO;}
}
static void CSAutomationPublishMessage(id session,id wrap,NSUInteger epoch,BOOL owned) {
    dispatch_async(dispatch_get_main_queue(),^{
        if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return;
        @try {
            CSAutomationManager *manager=CSAutomationManager.sharedManager;
            if(owned)CSAutomationRememberOwnedMessage(session,wrap,epoch);
            [manager receiveNativeSession:session wrap:wrap epoch:epoch];
        } @catch(__unused NSException *exception) {}
    });
}
static void CSAutomationInstallMessageIngress(NSString *name,BOOL detectsOwned) {
    Class cls=NSClassFromString(@"CMessageMgr");
    if(!CSAutomationIngressMethod(cls,name,@"v",@[@"@",@"@"]))return;
    SEL selector=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id service,id session,id wrap){
        NSUInteger epoch=CSBackupAccountEpoch();BOOL owned=NO;
        if(detectsOwned){@try {owned=CSAutomationIsOwnedSend(wrap);} @catch(__unused NSException *exception) {}}
        // Preserve original arguments, return and exceptions. Native reception
        // finishes before any automation normalization, storage or scheduling.
        ((void(*)(id,SEL,id,id))original)(service,selector,session,wrap);
        // The original can enqueue AsyncOnAddMsg with a rebuilt wrapper. On
        // main, remember its native IDs before any queued consumer can run.
        if(owned && NSThread.isMainThread && CSAutomationRememberOwnedMessage(session,wrap,epoch))owned=NO;
        CSAutomationPublishMessage(session,wrap,epoch,owned);
    });
    MSHookMessageEx(cls,selector,replacement,&original);
    if(detectsOwned)CSAutomationAddHookInstalled=YES;else CSAutomationAsyncHookInstalled=YES;
}
static void CSAutomationInstallSyncIngress(void) {
    Class cls=NSClassFromString(@"CMessageMgr");
    if(!CSAutomationSyncHookInstalled && CSAutomationIngressMethod(cls,@"onNewSyncAddMessage:",@"v",@[@"@"])){
        SEL selector=NSSelectorFromString(@"onNewSyncAddMessage:");__block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id service,id wrap){
            NSUInteger epoch=CSBackupAccountEpoch();
            ((void(*)(id,SEL,id))original)(service,selector,wrap);
            // SyncCmdHandler notifies every decoded wrap here, including the
            // m_bNew=NO branch which never calls AsyncOnAddMsg:MsgWrap:.
            // An empty session lets the event adapter derive the exact peer
            // from the native wrap; it never substitutes an active UI chat.
            CSAutomationPublishMessage(@"",wrap,epoch,NO);
        });
        MSHookMessageEx(cls,selector,replacement,&original);CSAutomationSyncHookInstalled=YES;
    }
    if(!CSAutomationBatchHookInstalled && CSAutomationIngressMethod(cls,@"AsyncOnAddMsgListForSession:NotifyUsrName:",@"v",@[@"@",@"@"])){
        SEL selector=NSSelectorFromString(@"AsyncOnAddMsgListForSession:NotifyUsrName:");__block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id service,id sessions,id users){
            NSUInteger epoch=CSBackupAccountEpoch();
            ((void(*)(id,SEL,id,id))original)(service,selector,sessions,users);
            // 8.0.80 also publishes session->wrap batches without either old
            // AddMsg callback. The per-message hook above covers full batches
            // even when this map contains only the last wrap for each session.
            @try {
                if(![sessions isKindOfClass:NSDictionary.class])return;
                NSDictionary *snapshot=[sessions copy];Class wrapper=NSClassFromString(@"CMessageWrap");
                if(!wrapper)return;
                for(id session in snapshot){
                    id wrap=snapshot[session];
                    if([session isKindOfClass:NSString.class] && [wrap isKindOfClass:wrapper])
                        CSAutomationPublishMessage(session,wrap,epoch,NO);
                }
            } @catch(__unused NSException *exception) {}
        });
        MSHookMessageEx(cls,selector,replacement,&original);CSAutomationBatchHookInstalled=YES;
    }
}
static void CSAutomationInstallIngressHooks(void) {
    if(!NSThread.isMainThread)return;
    if(!CSAutomationAsyncHookInstalled)CSAutomationInstallMessageIngress(@"AsyncOnAddMsg:MsgWrap:",NO);
    if(!CSAutomationAddHookInstalled)CSAutomationInstallMessageIngress(@"AddMsg:MsgWrap:",YES);
    CSAutomationInstallSyncIngress();
    Class cls=NSClassFromString(@"SendPatMgr");
    if(!CSAutomationPatIngressInstalled && CSAutomationIngressMethod(cls,@"addPatWrap:toChat:newXMLMessageWrap:index:",@"I",@[@"@",@"@",@"@",@"^Q"])){
        SEL selector=NSSelectorFromString(@"addPatWrap:toChat:newXMLMessageWrap:index:");__block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^unsigned int(id service,id pat,id conversation,id newXML,unsigned long long *index){
            NSUInteger epoch=CSBackupAccountEpoch();
            unsigned int localID=((unsigned int(*)(id,SEL,id,id,id,unsigned long long *))original)(service,selector,pat,conversation,newXML,index);
            // Native outgoing sends pass nil XML. The outer message can merge
            // several pats; the event adapter uses each PatWrap.serverId.
            if(localID && newXML && pat && [conversation isKindOfClass:NSString.class]){
                dispatch_async(dispatch_get_main_queue(),^{
                    if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return;
                    @try {
                        if(!CSMessageNativeSupports(pat,@"serverId",@"q",@[]) ||
                           [CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue]<=0)return;
                        [CSAutomationManager.sharedManager receivePat:pat conversation:conversation epoch:epoch];
                    } @catch(__unused NSException *exception) {}
                });
            }
            return localID;
        });
        MSHookMessageEx(cls,selector,replacement,&original);CSAutomationPatIngressInstalled=YES;
    }
}
static void CSAutomationBootstrapIngress(void) {
    if(!NSThread.isMainThread)return;
    static BOOL bootstrapped=NO;if(bootstrapped)return;bootstrapped=YES;
    // Install read-only ingress before backup/config readiness. The manager
    // retains raw events until ready and still owns all send authorization.
    CSAutomationInstallIngressHooks();
    // Some service classes arrive after this image. Retry without blocking the
    // main queue, then retry again on the existing readiness/lifecycle edges.
    for(NSNumber *delay in @[@0.25,@1,@3,@10]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay.doubleValue*NSEC_PER_SEC)),dispatch_get_main_queue(),^{CSAutomationInstallIngressHooks();});
    }
    for(NSString *name in @[UIApplicationDidBecomeActiveNotification,UIApplicationProtectedDataDidBecomeAvailable]){
        [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){CSAutomationInstallIngressHooks();}];
    }
}
%ctor {
    dispatch_async(dispatch_get_main_queue(),^{CSAutomationBootstrapIngress();});
    CSBackupWhenReady(^{dispatch_async(dispatch_get_main_queue(),^{
        [CSAutomationManager.sharedManager start];
        CSAutomationInstallNativeHooks();
        CSAutomationInstallIngressHooks();
    });});
}
