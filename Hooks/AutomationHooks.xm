#import "../Controllers/CSAutomationManager.h"
#import "../Controllers/CSAutomationEventAdapter.h"
#import "../Controllers/CSAutomationNativeAdapter.h"
#import "../Controllers/CSAutomationNativeSync.h"
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
static BOOL CSAutomationSyncHookInstalled,CSAutomationNotAddDBHookInstalled,CSAutomationBatchHookInstalled;
static BOOL CSAutomationUnifiedBatchInstalled;

@interface CSAutomationIngressPatSnapshot : NSObject
@property(nonatomic,copy) NSString *fromUserName,*pattedUserName;
@property(nonatomic) long long serverId;
@property(nonatomic) unsigned long long createTime;
@end
@implementation CSAutomationIngressPatSnapshot @end
@interface CSAutomationIngressXMLSnapshot : NSObject
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsSpecifiedChatName;
@property(nonatomic) unsigned int m_uiMessageType,m_uiCreateTime;
@property(nonatomic) long long m_n64MesSvrID;
@end
@implementation CSAutomationIngressXMLSnapshot @end
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
static NSArray<NSDictionary *> *CSAutomationPatsInMessage(id session,id wrap,BOOL snapshot) {
    // Synced app-message 62 already contains native PatWraps. It can reach the
    // per-wrap/session batch callbacks without another addPatWrap/XML insertion.
    if(!CSMessageNativeSupports(wrap,@"m_uiMessageType",@"I",@[]) ||
       !CSMessageNativeSupports(wrap,@"m_uiAppMsgInnerType",@"I",@[]) ||
       CSMessageNativeUnsigned(wrap,@"m_uiMessageType")!=49 ||
       CSMessageNativeUnsigned(wrap,@"m_uiAppMsgInnerType")!=62)return @[];
    id compound=CSMessageActionNativeObject(wrap,@"patMessageWrap");
    id conversation=CSMessageActionNativeObject(compound,@"chatUserName");
    id from=CSMessageActionNativeObject(wrap,@"m_nsFromUsr"),to=CSMessageActionNativeObject(wrap,@"m_nsToUsr");
    if(![conversation isKindOfClass:NSString.class] || ![conversation length] ||
       ![from isKindOfClass:NSString.class] || ![from length] ||
       ![to isKindOfClass:NSString.class] || ![to length] ||
       (![conversation isEqual:from] && ![conversation isEqual:to]) ||
       ([session isKindOfClass:NSString.class] && [session length] && ![conversation isEqual:session])){return @[];}
    id pats=CSMessageActionNativeObject(compound,@"patWraps");
    if(![pats isKindOfClass:NSArray.class]){return @[];}
    NSMutableArray *result=[NSMutableArray array];
    NSArray *observed=snapshot?[pats subarrayWithRange:NSMakeRange(0,MIN([pats count],128UL))]:[pats copy];
    for(id pat in observed){
        if(!CSMessageNativeSupports(pat,@"serverId",@"q",@[]) ||
           !CSMessageNativeSupports(pat,@"createTime",@"Q",@[]) ||
           [CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue]<=0 ||
           !CSMessageNativeUnsigned(pat,@"createTime"))continue;
        // Keep each native pat identity; the manager applies target/account/age
        // checks and its durable ledger deduplicates XML, sync and batch overlap.
        id retainedPat=pat;
        if(snapshot){
            id fromUser=CSMessageActionNativeObject(pat,@"fromUserName"),target=CSMessageActionNativeObject(pat,@"pattedUserName");
            if(![fromUser isKindOfClass:NSString.class] || ![target isKindOfClass:NSString.class])continue;
            CSAutomationIngressPatSnapshot *copy=[CSAutomationIngressPatSnapshot new];copy.fromUserName=fromUser;copy.pattedUserName=target;
            copy.serverId=[CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue];copy.createTime=CSMessageNativeUnsigned(pat,@"createTime");retainedPat=copy;
        }
        [result addObject:@{@"pat":retainedPat,@"conversation":[conversation copy]}];
    }
    return [result copy];
}
static void CSAutomationPublishPatsInMessage(CSAutomationManager *manager,id session,id wrap,NSUInteger epoch) {
    for(NSDictionary *entry in CSAutomationPatsInMessage(session,wrap,NO)){
        [manager receivePat:entry[@"pat"] conversation:entry[@"conversation"] epoch:epoch];
    }
}
static void CSAutomationPublishMessage(id service,id session,id wrap,NSUInteger epoch,BOOL owned) {
    BOOL revokedRawPat=NO;
    @try {
        // Native OnGetNewXmlMsg ignores pats already present in the revoke
        // table. Query on the original service/caller context before queuing;
        // do not initialize another service or move it across account contexts.
        if(epoch==CSBackupAccountEpoch() && !CSBackupAccountIsSuspended() &&
           CSMessageNativeSupports(wrap,@"m_uiMessageType",@"I",@[]) && CSMessageNativeUnsigned(wrap,@"m_uiMessageType")==10002 &&
           CSMessageNativeSupports(wrap,@"m_n64MesSvrID",@"q",@[]) && CSMessageNativeSupports(service,@"GetRevokeMsgBySvrId:",@"@",@[@"q"])){
            NSNumber *server=CSMessageNativeInvoke(wrap,@"m_n64MesSvrID",@[]);
            if(server.longLongValue>0)revokedRawPat=CSMessageNativeInvoke(service,@"GetRevokeMsgBySvrId:",@[server])!=nil;
        }
    } @catch(__unused NSException *exception) {}
    dispatch_async(dispatch_get_main_queue(),^{
        if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return;
        @try {
            CSAutomationManager *manager=CSAutomationManager.sharedManager;
            if(owned)CSAutomationRememberOwnedMessage(session,wrap,epoch);
            [manager receiveNativeSession:session wrap:wrap epoch:epoch];
            CSAutomationPublishPatsInMessage(manager,session,wrap,epoch);
            // Raw pat sysmsgs have their own non-database sync route. Admit
            // their immutable snapshot before native XML aggregation/local
            // insertion is needed; all routes retain the same pat server ID.
            if(!revokedRawPat && CSMessageNativeSupports(wrap,@"m_uiMessageType",@"I",@[]) &&
               CSMessageNativeUnsigned(wrap,@"m_uiMessageType")==10002){
                NSDictionary *event=CSAutomationPatFromXMLMessage(wrap,session);
                id pat=event[@"pat"],conversation=event[@"conversation"];
                if(pat && [conversation isKindOfClass:NSString.class] && [conversation length])
                    [manager receivePat:pat conversation:conversation epoch:epoch];
            }
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
        CSAutomationPublishMessage(service,session,wrap,epoch,owned);
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
            CSAutomationPublishMessage(service,@"",wrap,epoch,NO);
        });
        MSHookMessageEx(cls,selector,replacement,&original);CSAutomationSyncHookInstalled=YES;
    }
    if(!CSAutomationNotAddDBHookInstalled && CSAutomationIngressMethod(cls,@"onNewSyncNotAddDBMessage:",@"v",@[@"@"])){
        SEL selector=NSSelectorFromString(@"onNewSyncNotAddDBMessage:");__block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id service,id wrap){
            NSUInteger epoch=CSBackupAccountEpoch();
            ((void(*)(id,SEL,id))original)(service,selector,wrap);
            // SyncCmdHandler dispatches non-database wraps separately from
            // onNewSyncAddMessage:. Type 10002 reaches HandleSvrCmd here.
            CSAutomationPublishMessage(service,@"",wrap,epoch,NO);
        });
        MSHookMessageEx(cls,selector,replacement,&original);CSAutomationNotAddDBHookInstalled=YES;
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
                        CSAutomationPublishMessage(service,session,wrap,epoch,NO);
                }
            } @catch(__unused NSException *exception) {}
        });
        MSHookMessageEx(cls,selector,replacement,&original);CSAutomationBatchHookInstalled=YES;
    }
}
static id CSAutomationSnapshotRawEnvelope(id wrap) {
    if(!CSMessageNativeSupports(wrap,@"m_uiMessageType",@"I",@[]) ||
       !CSMessageNativeSupports(wrap,@"m_uiCreateTime",@"I",@[]) || !CSMessageNativeSupports(wrap,@"m_n64MesSvrID",@"q",@[]))return nil;
    CSAutomationIngressXMLSnapshot *snapshot=[CSAutomationIngressXMLSnapshot new];snapshot.m_uiMessageType=10002;
    snapshot.m_uiCreateTime=(unsigned int)CSMessageNativeUnsigned(wrap,@"m_uiCreateTime");snapshot.m_n64MesSvrID=[CSMessageNativeInvoke(wrap,@"m_n64MesSvrID",@[]) longLongValue];
    for(NSString *key in @[@"m_nsFromUsr",@"m_nsToUsr",@"m_nsContent",@"m_nsSpecifiedChatName"]){
        id value=CSMessageActionNativeObject(wrap,key);
        if(value && ![value isKindOfClass:NSString.class])return nil;
        if([value length]>([key isEqual:@"m_nsContent"]?65536UL:1024UL)){
            return nil;
        }
        [snapshot setValue:[value copy]?:@"" forKey:key];
    }
    return snapshot;
}
// Snapshot before BatchAddMsg's display conversion and deferred extension
// notifications. Only strict pat events leave this boundary; ordinary messages
// keep their existing consumers and ordering.
static NSArray<NSDictionary *> *CSAutomationSnapshotDecodedBatch(id service,NSUInteger epoch) {
    @try {
        if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return @[];
        if(!CSMessageNativeSupports(service,@"getReceiveMsgList",@"@",@[])){
            return @[];
        }
        id list=CSMessageNativeInvoke(service,@"getReceiveMsgList",@[]);
        if(![list isKindOfClass:NSArray.class]){return @[];}
        NSUInteger total=[list count],limit=MIN(total,10000UL),snapshotBytes=0;
        NSArray *messages=[[list subarrayWithRange:NSMakeRange(0,limit)] copy];NSMutableArray *events=[NSMutableArray array];
        for(id wrap in messages){
            unsigned long long type=CSMessageNativeUnsigned(wrap,@"m_uiMessageType");
            if(type==10002){
                id content=CSMessageActionNativeObject(wrap,@"m_nsContent");
                NSUInteger bytes=[content isKindOfClass:NSString.class]?MIN([content length],65537UL)*sizeof(unichar):0;
                if(events.count>=128 || bytes>524288UL-snapshotBytes){continue;}
                id envelope=CSAutomationSnapshotRawEnvelope(wrap);
                // Copy on the native caller's context; the strict parser keeps
                // its original main-thread boundary after native acceptance.
                if(envelope){snapshotBytes+=bytes;[events addObject:@{@"xmlEnvelope":envelope}];}
            }else if(type==49 && CSMessageNativeUnsigned(wrap,@"m_uiAppMsgInnerType")==62){
                if(events.count>=128){continue;}
                NSArray *pats=CSAutomationPatsInMessage(@"",wrap,YES);NSUInteger count=MIN(pats.count,128-events.count);
                [events addObjectsFromArray:[pats subarrayWithRange:NSMakeRange(0,count)]];
            }
        }
        return [events copy];
    } @catch(__unused NSException *exception) {return @[];}
}
static void CSAutomationPublishDecodedPats(NSArray<NSDictionary *> *events,NSUInteger epoch) {
    if(!events.count)return;
    dispatch_async(dispatch_get_main_queue(),^{
        if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return;
        @try {
            CSAutomationManager *manager=CSAutomationManager.sharedManager;
            CSMessageNativeEnvironment *environment=[CSMessageNativeEnvironment new];
            id service=[environment serviceNamed:@"CMessageMgr"];
            // An earlier raw snapshot must not bypass the native revoke table.
            // Keep its normal account-bound service wrapper and scalar ABI.
            BOOL supportsRevoke=CSMessageNativeSupports(service,@"GetRevokeMsgBySvrId:",@"@",@[@"q"]);
            for(NSDictionary *entry in events){
                if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return;
                NSDictionary *event=entry;
                if(entry[@"xmlEnvelope"]){
                    event=CSAutomationPatFromXMLMessage(entry[@"xmlEnvelope"],@"");
                }
                if(!event)continue;
                if(!supportsRevoke){continue;}
                id pat=event[@"pat"];NSString *conversation=event[@"conversation"];
                if(![conversation isKindOfClass:NSString.class] || !conversation.length || !CSMessageNativeSupports(pat,@"serverId",@"q",@[]))continue;
                long long server=[CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue];if(server<=0)continue;
                if(CSMessageNativeInvoke(service,@"GetRevokeMsgBySvrId:",@[@(server)])){
                    continue;
                }
                if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return;
                [manager receivePat:pat conversation:conversation epoch:epoch];
            }
        } @catch(__unused NSException *exception) {}
    });
}
static void CSAutomationInstallUnifiedBatchIngress(void) {
    Class cls=NSClassFromString(@"SyncCmdHandler");
    if(!CSAutomationUnifiedBatchInstalled && CSAutomationIngressMethod(cls,@"BatchAddMsg:ShowPush:",@"B",@[@"B",@"B"])){
        SEL selector=NSSelectorFromString(@"BatchAddMsg:ShowPush:");__block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^BOOL(id service,BOOL fromPush,BOOL showPush){
            NSUInteger epoch=CSBackupAccountEpoch();
            NSArray *events=CSAutomationSnapshotDecodedBatch(service,epoch);
            BOOL accepted=((BOOL(*)(id,SEL,BOOL,BOOL))original)(service,selector,fromPush,showPush);
            // YES proves native batch acceptance only. It does not establish
            // delivery or a server response belonging to our local request.
            if(accepted)CSAutomationPublishDecodedPats(events,epoch);
            return accepted;
        });
        MSHookMessageEx(cls,selector,replacement,&original);CSAutomationUnifiedBatchInstalled=YES;
    }

}
static void CSAutomationInstallIngressHooks(void) {
    if(!NSThread.isMainThread)return;
    if(!CSAutomationAsyncHookInstalled)CSAutomationInstallMessageIngress(@"AsyncOnAddMsg:MsgWrap:",NO);
    if(!CSAutomationAddHookInstalled)CSAutomationInstallMessageIngress(@"AddMsg:MsgWrap:",YES);
    CSAutomationInstallSyncIngress();
    CSAutomationInstallUnifiedBatchIngress();
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
    CSAutomationInstallNativeSync();
    static BOOL bootstrapped=NO;if(bootstrapped)return;bootstrapped=YES;
    // Install read-only ingress before backup/config readiness. The manager
    // retains raw events until ready and still owns all send authorization.
    CSAutomationInstallIngressHooks();
    // Some service classes arrive after this image. Retry without blocking the
    // main queue, then retry again on the existing readiness/lifecycle edges.
    for(NSNumber *delay in @[@0.25,@1,@3,@10]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay.doubleValue*NSEC_PER_SEC)),dispatch_get_main_queue(),^{CSAutomationInstallIngressHooks();});
    }
    for(NSString *name in @[UIApplicationDidBecomeActiveNotification,UIApplicationProtectedDataDidBecomeAvailable,@"UIApplicationDidEnterBackgroundNotification",@"UIApplicationWillResignActiveNotification",@"UIApplicationProtectedDataWillBecomeUnavailable"]){
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
