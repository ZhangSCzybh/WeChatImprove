#import "CSAutomationNativeAdapter.h"
#import "CSBackupBootstrap.h"
#import <objc/runtime.h>
#import <substrate.h>
#include <string.h>

// 8.0.80.34: a native send owns one SendPatWrap throughout CGI completion and
// retraction. Keep that identity instead of consulting SendPatMgr.lastSendPatWrap.
static const void *CSAutomationPatKey=&CSAutomationPatKey;
static id CSAutomationActivePatSend;
static BOOL CSAutomationGuideHookInstalled,CSAutomationResultHookInstalled,CSAutomationFailureHookInstalled;

@interface CSAutomationPatObservation : NSObject
@property(nonatomic,copy) NSString *account,*conversation,*sender;
@property(nonatomic,strong) id<CSMessageActionEnvironment> environment;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) NSInteger result;
@property(nonatomic) BOOL registered,queued,delivered,cancelled;
@property(nonatomic,copy) void (^completion)(BOOL success);
@end
@implementation CSAutomationPatObservation @end

static BOOL CSAutomationRequireLivePatAccount(id<CSMessageActionEnvironment> environment,NSString *account,NSUInteger epoch,BOOL *deferred) {
    if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return NO;
    id live=[environment currentAccountID];
    if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return NO;
    BOOL unavailable=!live || ([live isKindOfClass:NSString.class] && ![live length]);
    if(unavailable){if(deferred)*deferred=YES;return NO;}
    return [live isKindOfClass:NSString.class] && [live isEqual:account];
}
static BOOL CSAutomationPatResultIdentityValid(CSAutomationPatObservation *state) {
    if(!state || state.epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended())return NO;
    // A native CGI success belongs to this exact SendPatWrap and account epoch.
    // Protected data can temporarily hide the live account; keep the success
    // fact so its retraction can resume after unlock. Submissions still use
    // CSAutomationRequireLivePatAccount and require the live account to match.
    id live=[state.environment currentAccountID];
    return !live || ([live isKindOfClass:NSString.class] && (![live length] || [live isEqual:state.account]));
}
static void CSAutomationDeliverPatResult(id sendPat,CSAutomationPatObservation *state) {
    if(!state.result || !state.completion || state.queued || state.delivered || state.cancelled)return;
    state.queued=YES;
    dispatch_async(dispatch_get_main_queue(),^{
        if(objc_getAssociatedObject(sendPat,CSAutomationPatKey)!=state || state.delivered || state.cancelled)return;
        state.queued=NO;state.delivered=YES;
        void (^completion)(BOOL)=state.completion;state.completion=nil;
        BOOL successful=NO;
        @try {successful=state.result==1 && CSAutomationPatResultIdentityValid(state);} @catch(__unused NSException *exception) {}
        if(completion)completion(successful);
    });
}
static void CSAutomationFinishPat(id sendPat,BOOL success) {
    CSAutomationPatObservation *state=objc_getAssociatedObject(sendPat,CSAutomationPatKey);
    if(![state isKindOfClass:CSAutomationPatObservation.class] || state.result || state.cancelled)return;
    state.result=success?1:2;CSAutomationDeliverPatResult(sendPat,state);
}
void CSAutomationObservePatResult(id sendPat,void (^completion)(BOOL success)) {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{CSAutomationObservePatResult(sendPat,completion);});return;}
    CSAutomationPatObservation *state=objc_getAssociatedObject(sendPat,CSAutomationPatKey);
    if(![state isKindOfClass:CSAutomationPatObservation.class] || state.cancelled){dispatch_async(dispatch_get_main_queue(),^{completion(NO);});return;}
    if(state.registered)return;
    state.registered=YES;state.completion=[completion copy];CSAutomationDeliverPatResult(sendPat,state);
}
void CSAutomationCancelPatObservation(id sendPat) {
    if(!NSThread.isMainThread){dispatch_async(dispatch_get_main_queue(),^{CSAutomationCancelPatObservation(sendPat);});return;}
    CSAutomationPatObservation *state=objc_getAssociatedObject(sendPat,CSAutomationPatKey);
    // Retain the exact-send identity for its scheduled retraction, while releasing
    // the manager callback on completion/timeout/account change.
    state.cancelled=YES;state.completion=nil;
}
static BOOL CSAutomationMethod(Class cls,NSString *name,NSString *result,NSArray<NSString *> *arguments) {
    Method method=class_getInstanceMethod(cls,NSSelectorFromString(name));
    if(!method || method_getNumberOfArguments(method)!=arguments.count+2)return NO;
    char type[64]={0};method_getReturnType(method,type,sizeof(type));
    if([result isEqual:@"B"]){if(type[0]!='B' && type[0]!='c')return NO;}else if(strcmp(type,result.UTF8String))return NO;
    for(NSUInteger index=0;index<arguments.count;index++){
        method_getArgumentType(method,(unsigned int)index+2,type,sizeof(type));
        if([arguments[index] isEqual:@"@"]){if(type[0]!='@')return NO;}else if(strcmp(type,arguments[index].UTF8String))return NO;
    }
    return YES;
}
static void CSAutomationPatSucceeded(id sendPat,long long serverID) {
    @try {
        CSAutomationPatObservation *state=objc_getAssociatedObject(sendPat,CSAutomationPatKey);
        if(serverID<=0 || !CSAutomationPatResultIdentityValid(state))return;
        id pat=CSMessageActionNativeObject(sendPat,@"patWrap");
        if(!CSMessageNativeSupports(pat,@"serverId",@"q",@[]) ||
           [CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue]!=serverID)return;
        CSAutomationFinishPat(sendPat,YES);
    } @catch(__unused NSException *exception) {}
}
void CSAutomationInstallNativeHooks(void) {
    if(!NSThread.isMainThread)return;
    Class manager=NSClassFromString(@"SendPatMgr");
    if(!CSAutomationGuideHookInstalled && CSAutomationMethod(manager,@"checkAndShowRevokeGuideForSendPat:",@"B",@[@"@"])){
        SEL selector=NSSelectorFromString(@"checkAndShowRevokeGuideForSendPat:");__block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^BOOL(id service,id sendPat){
            // YES means a guide took over and will send after dismissal. NO lets
            // sendPat: proceed. Suppress only this exact automatic invocation.
            if(NSThread.isMainThread && sendPat==CSAutomationActivePatSend &&
               objc_getAssociatedObject(sendPat,CSAutomationPatKey))return NO;
            return ((BOOL(*)(id,SEL,id))original)(service,selector,sendPat);
        });
        MSHookMessageEx(manager,selector,replacement,&original);CSAutomationGuideHookInstalled=YES;
    }
    if(!CSAutomationResultHookInstalled && CSAutomationMethod(manager,@"updatePatSuffix:serverId:forSendPatWrap:",@"v",@[@"@",@"q",@"@"])){
        SEL selector=NSSelectorFromString(@"updatePatSuffix:serverId:forSendPatWrap:");__block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id service,id suffix,long long serverID,id sendPat){
            ((void(*)(id,SEL,id,long long,id))original)(service,selector,suffix,serverID,sendPat);
            // Prefetch invokes this with ID 0. A suffix may legitimately be nil.
            if(serverID<=0 || !sendPat)return;
            if(NSThread.isMainThread)CSAutomationPatSucceeded(sendPat,serverID);
            else dispatch_async(dispatch_get_main_queue(),^{CSAutomationPatSucceeded(sendPat,serverID);});
        });
        MSHookMessageEx(manager,selector,replacement,&original);CSAutomationResultHookInstalled=YES;
    }
    Class cgi=NSClassFromString(@"SendPatCgi");
    if(!CSAutomationFailureHookInstalled && CSAutomationMethod(cgi,@"didFailWithError:response:",@"v",@[@"@",@"@"]) &&
       CSAutomationMethod(cgi,@"sendPatWrap",@"@",@[])){
        SEL selector=NSSelectorFromString(@"didFailWithError:response:");__block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id request,id error,id response){
            ((void(*)(id,SEL,id,id))original)(request,selector,error,response);
            void (^record)(void)=^{
                @try {CSAutomationFinishPat(CSMessageActionNativeObject(request,@"sendPatWrap"),NO);} @catch(__unused NSException *exception) {}
            };
            if(NSThread.isMainThread)record();else dispatch_async(dispatch_get_main_queue(),record);
        });
        MSHookMessageEx(cgi,selector,replacement,&original);CSAutomationFailureHookInstalled=YES;
    }
}
@interface CSAutomationNativeAdapter ()
@property(nonatomic,strong) id<CSMessageActionEnvironment> environment;
@end
@implementation CSAutomationNativeAdapter
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment {if((self=[super init]))_environment=environment;return self;}
- (id)sendPatTo:(NSString *)sender conversation:(NSString *)conversation account:(NSString *)account valid:(BOOL (^)(void))valid {
    return [self sendPatTo:sender conversation:conversation account:account valid:valid deferred:NULL];
}
- (id)sendPatTo:(NSString *)sender conversation:(NSString *)conversation account:(NSString *)account valid:(BOOL (^)(void))valid deferred:(BOOL *)deferred {
    if(deferred)*deferred=NO;
    if(!NSThread.isMainThread || ![sender isKindOfClass:NSString.class] || !sender.length ||
       [sender hasSuffix:@"@chatroom"] || ![conversation isKindOfClass:NSString.class] || !conversation.length ||
       ![account isKindOfClass:NSString.class] || !account.length || [sender isEqual:account] || !valid)return nil;
    BOOL group=[conversation hasSuffix:@"@chatroom"];
    if(!group && ![conversation isEqual:sender])return nil;
    @try {
        NSUInteger epoch=CSBackupAccountEpoch();
        CSAutomationInstallNativeHooks();
        if(!CSAutomationGuideHookInstalled || !CSAutomationResultHookInstalled || !valid() ||
           !CSAutomationRequireLivePatAccount(_environment,account,epoch,deferred))return nil;
        id manager=[_environment serviceNamed:@"SendPatMgr"],sendPat=[NSClassFromString(@"SendPatWrap") new];
        if(!sendPat || !CSMessageNativeSupports(manager,@"sendPat:",@"B",@[@"@"]) ||
           !CSMessageNativeSupports(sendPat,@"setFromUserName:",@"v",@[@"@"]) ||
           !CSMessageNativeSupports(sendPat,@"setPattedUserName:",@"v",@[@"@"]) ||
           !CSMessageNativeSupports(sendPat,@"setChatUserName:",@"v",@[@"@"]) ||
           !CSMessageNativeSupports(sendPat,@"setScene:",@"v",@[@"Q"]) ||
           !CSMessageNativeSupports(sendPat,@"isValid",@"B",@[]))return nil;
        CSMessageNativeInvoke(sendPat,@"setFromUserName:",@[account]);
        CSMessageNativeInvoke(sendPat,@"setPattedUserName:",@[sender]);
        CSMessageNativeInvoke(sendPat,@"setChatUserName:",@[conversation]);
        CSMessageNativeInvoke(sendPat,@"setScene:",@[group?@2:@1]);
        if(![CSMessageNativeInvoke(sendPat,@"isValid",@[]) boolValue])return nil;
        CSAutomationPatObservation *state=[CSAutomationPatObservation new];
        state.account=account;state.conversation=conversation;state.sender=sender;state.environment=_environment;
        state.epoch=epoch;
        objc_setAssociatedObject(sendPat,CSAutomationPatKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        __block BOOL accepted=NO;
        BOOL handedOff=CSBackupPerformAtAccountEpoch(state.epoch,^{
            // The account handoff holds a shared recursive lock. Keep native
            // exceptions inside its block so they cannot skip its unlock.
            @try {
                if(!valid() || !CSAutomationRequireLivePatAccount(state.environment,state.account,state.epoch,deferred))return;
                id previous=CSAutomationActivePatSend;CSAutomationActivePatSend=sendPat;
                if(deferred)*deferred=NO;
                @try {accepted=[CSMessageNativeInvoke(manager,@"sendPat:",@[sendPat]) boolValue];}
                @finally {CSAutomationActivePatSend=previous;}
            } @catch(__unused NSException *exception) {if(deferred)*deferred=NO;}
        });
        if(!handedOff || !accepted){CSAutomationCancelPatObservation(sendPat);return nil;}
        return sendPat;
    } @catch(__unused NSException *exception) {if(deferred)*deferred=NO;return nil;}
}
- (BOOL)revokePat:(id)sendPat conversation:(NSString *)conversation account:(NSString *)account valid:(BOOL (^)(void))valid {
    return [self revokePat:sendPat conversation:conversation account:account valid:valid deferred:NULL];
}
- (BOOL)revokePat:(id)sendPat conversation:(NSString *)conversation account:(NSString *)account valid:(BOOL (^)(void))valid deferred:(BOOL *)deferred {
    if(deferred)*deferred=NO;
    if(!NSThread.isMainThread || !sendPat || !valid || !conversation.length || !account.length)return NO;
    @try {
        CSAutomationPatObservation *state=objc_getAssociatedObject(sendPat,CSAutomationPatKey);
        if(![state isKindOfClass:CSAutomationPatObservation.class] || state.result!=1 ||
           ![state.account isEqual:account] || ![state.conversation isEqual:conversation] ||
           !valid() || !CSAutomationRequireLivePatAccount(state.environment,state.account,state.epoch,deferred) ||
           !CSAutomationRequireLivePatAccount(_environment,account,state.epoch,deferred))return NO;
        if(![CSMessageActionNativeObject(sendPat,@"fromUserName") isEqual:account] ||
           ![CSMessageActionNativeObject(sendPat,@"chatUserName") isEqual:conversation] ||
           ![CSMessageActionNativeObject(sendPat,@"pattedUserName") isEqual:state.sender])return NO;
        id pat=CSMessageActionNativeObject(sendPat,@"patWrap"),manager=[_environment serviceNamed:@"SendPatMgr"];
        if(!CSMessageNativeSupports(pat,@"serverId",@"q",@[]) || [CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue]<=0 ||
           !CSMessageNativeSupports(pat,@"canRevoke",@"B",@[]) || ![CSMessageNativeInvoke(pat,@"canRevoke",@[]) boolValue] ||
           ![CSMessageActionNativeObject(pat,@"fromUserName") isEqual:account] ||
           ![CSMessageActionNativeObject(pat,@"pattedUserName") isEqual:state.sender] ||
           !CSMessageNativeSupports(manager,@"revokeSendPat:",@"v",@[@"@"]))return NO;
        __block BOOL invoked=NO;
        CSBackupPerformAtAccountEpoch(state.epoch,^{
            @try {
                if(!valid() || !CSAutomationRequireLivePatAccount(state.environment,state.account,state.epoch,deferred) ||
                   !CSAutomationRequireLivePatAccount(_environment,account,state.epoch,deferred) ||
                   ![CSMessageNativeInvoke(pat,@"canRevoke",@[]) boolValue])return;
                if(deferred)*deferred=NO;
                CSMessageNativeInvoke(manager,@"revokeSendPat:",@[sendPat]);invoked=YES;
            } @catch(__unused NSException *exception) {if(deferred)*deferred=NO;}
        });
        // This reports handoff to native retraction, not server confirmation.
        return invoked;
    } @catch(__unused NSException *exception) {if(deferred)*deferred=NO;return NO;}
}
- (NSTimeInterval)revokeWindow {
    if(!NSThread.isMainThread)return 0;
    @try {id manager=[_environment serviceNamed:@"SendPatMgr"];
        return CSMessageNativeSupports(manager,@"patSendLongPressRevokeInterval",@"I",@[]) ?
            [CSMessageNativeInvoke(manager,@"patSendLongPressRevokeInterval",@[]) unsignedIntValue]:0;
    } @catch(__unused NSException *exception) {return 0;}
}
@end
