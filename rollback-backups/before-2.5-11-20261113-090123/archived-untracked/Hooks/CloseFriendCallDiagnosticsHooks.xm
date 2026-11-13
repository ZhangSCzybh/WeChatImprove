#import "../Controllers/CSCloseFriendCallDiagnostics.h"
#import "../Controllers/CSCloseFriendBridge.h"
#import <UserNotifications/UserNotifications.h>
#import <substrate.h>

// Observe the actual notification the user taps. A remote push is delivered by
// the system and never needs to call this process's addNotificationRequest:.
static void ObserveCallResponse(id response,NSString *fixedRoute) {
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    CSCFCallDiagnosticsRecord(fixedRoute,epoch);
    CSCFCallDiagnosticsRecord(@"response.enter",epoch);
    if(CSCFCallDiagnosticsIsRecording() && [response isKindOfClass:UNNotificationResponse.class]) {
        UNNotificationRequest *request=((UNNotificationResponse *)response).notification.request;
        if(request)CSCFCallDiagnosticsRecord([request.trigger isKindOfClass:UNPushNotificationTrigger.class]?
            @"notification.response.remote":@"notification.response.local",epoch);
    }
}

static NSObject *CallResponseObserverLock(void) {
    static NSObject *lock;static dispatch_once_t once;
    dispatch_once(&once,^{lock=[NSObject new];});return lock;
}
static NSMutableDictionary<NSValue *,NSMutableDictionary<NSString *,NSValue *> *> *CallResponseObservers(void) {
    static NSMutableDictionary *observers;static dispatch_once_t once;
    dispatch_once(&once,^{observers=[NSMutableDictionary dictionary];});return observers;
}
static NSValue *CallResponseClassKey(Class owner) {
    return [NSValue valueWithPointer:(__bridge const void *)owner];
}

// Only wrap a verified existing method. Inherited observers already cover a
// delegate subclass unless it overrides the callback with a different IMP.
static BOOL InstallCallDiagnosticResponseForClass(Class owner,NSString *fixedRoute) {
    if(!owner)return NO;
    SEL selector=NSSelectorFromString(@"userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:");
    NSString *name=NSStringFromSelector(selector);
    @synchronized(CallResponseObserverLock()) {
        Method method=class_getInstanceMethod(owner,selector);
        if(!CSCloseFriendMethodMatches(method,"v@:@@@?"))return NO;
        NSMutableDictionary *observers=CallResponseObservers();
        NSValue *key=CallResponseClassKey(owner);
        if(observers[key][name])return YES;
        IMP current=method_getImplementation(method);
        for(Class parent=class_getSuperclass(owner);parent;parent=class_getSuperclass(parent)) {
            NSValue *inherited=observers[CallResponseClassKey(parent)][name];
            if(inherited && inherited.pointerValue==(const void *)current)return YES;
        }
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id target,id center,id response,void (^completion)(void)) {
            ObserveCallResponse(response,fixedRoute);
            ((void(*)(id,SEL,id,id,void(^)(void)))original)(target,selector,center,response,completion);
        });
        MSHookMessageEx(owner,selector,replacement,&original);
        if(!original)return NO;
        if(!observers[key])observers[key]=[NSMutableDictionary dictionary];
        observers[key][name]=[NSValue valueWithPointer:(const void *)method_getImplementation(class_getInstanceMethod(owner,selector))];
        return YES;
    }
}

static void InstallCallDiagnosticResponse(void) {
    BOOL available=InstallCallDiagnosticResponseForClass(NSClassFromString(@"MicroMessengerAppDelegate"),@"response.app");
    CSCloseFriendRecordCapability(@"MicroMessengerAppDelegate.userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:",available);
    available=InstallCallDiagnosticResponseForClass(NSClassFromString(@"NotificationActionsMgr"),@"response.actions");
    CSCloseFriendRecordCapability(@"NotificationActionsMgr.userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:",available);
}

static void InstallCallDiagnosticInternalResponse(void) {
    Class owner=NSClassFromString(@"MicroMessengerAppDelegate");
    SEL selector=NSSelectorFromString(@"internalHandleReceiveNotificationResponse:withCompletionHandler:");
    NSString *name=NSStringFromSelector(selector);
    BOOL available=NO;
    @synchronized(CallResponseObserverLock()) {
        available=owner && CSCloseFriendMethodMatches(class_getInstanceMethod(owner,selector),"v@:@@?");
        if(available) {
            NSMutableDictionary *observers=CallResponseObservers();
            NSValue *key=CallResponseClassKey(owner);
            if(!observers[key][name]) {
                __block IMP original=NULL;
                IMP replacement=imp_implementationWithBlock(^(id target,id response,void (^completion)(void)) {
                    ObserveCallResponse(response,@"response.internal");
                    ((void(*)(id,SEL,id,void(^)(void)))original)(target,selector,response,completion);
                });
                MSHookMessageEx(owner,selector,replacement,&original);
                available=original!=NULL;
                if(available) {
                    if(!observers[key])observers[key]=[NSMutableDictionary dictionary];
                    observers[key][name]=[NSValue valueWithPointer:(const void *)method_getImplementation(class_getInstanceMethod(owner,selector))];
                }
            }
        }
    }
    CSCloseFriendRecordCapability(@"MicroMessengerAppDelegate.internalHandleReceiveNotificationResponse:withCompletionHandler:",available);
}

static BOOL CallResponseClassInherits(Class candidate,Class known) {
    if(!known)return NO;
    for(Class owner=candidate;owner;owner=class_getSuperclass(owner))if(owner==known)return YES;
    return NO;
}

void CSCFCallDiagnosticsInspectNotificationDelegate(void) {
    id delegate=UNUserNotificationCenter.currentNotificationCenter.delegate;
    Class owner=object_getClass(delegate);
    NSString *event=!delegate?@"delegate.none":
        CallResponseClassInherits(owner,NSClassFromString(@"NotificationActionsMgr"))?@"delegate.actions":
        CallResponseClassInherits(owner,NSClassFromString(@"MicroMessengerAppDelegate"))?@"delegate.app":@"delegate.other";
    CSCFCallDiagnosticsRecord(event,CSCloseFriendAccountEpoch());
    BOOL available=InstallCallDiagnosticResponseForClass(owner,@"response.active");
    CSCloseFriendRecordCapability(@"calls.diagnostics.activeDelegate",available);
}

static void InstallCallDiagnosticPushRoutes(void) {
    Class service=NSClassFromString(@"VoIPPushKitNotifyService");
    SEL canHandle=NSSelectorFromString(@"canHandleVoIPPushInfo:type:");
    BOOL available=CSCloseFriendMethodMatches(class_getClassMethod(service,canHandle),"B@:@@");
    if(available) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^BOOL(id owner,id info,id type) {
            CSCFCallDiagnosticsRecord(@"voip.handle",CSCloseFriendAccountEpoch());
            return ((BOOL(*)(id,SEL,id,id))original)(owner,canHandle,info,type);
        });
        MSHookMessageEx(object_getClass(service),canHandle,replacement,&original);
        available=original!=NULL;
    }
    CSCloseFriendRecordCapability(@"calls.diagnostics.pushRoute",available);

    SEL content=NSSelectorFromString(@"handleVoIPPushInfoContent:VoIPPushInfo:type:completion:");
    available=CSCloseFriendMethodMatches(class_getClassMethod(service,content),"B@:@@@@?");
    if(available) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^BOOL(id owner,id value,id info,id type,id completion) {
            CSCFCallDiagnosticsRecord(@"voip.content",CSCloseFriendAccountEpoch());
            return ((BOOL(*)(id,SEL,id,id,id,id))original)(owner,content,value,info,type,completion);
        });
        MSHookMessageEx(object_getClass(service),content,replacement,&original);
        available=original!=NULL;
    }
    CSCloseFriendRecordCapability(@"calls.diagnostics.pushContent",available);
}

%ctor {dispatch_async(dispatch_get_main_queue(),^{
    InstallCallDiagnosticResponse();
    InstallCallDiagnosticInternalResponse();
    InstallCallDiagnosticPushRoutes();
});}
