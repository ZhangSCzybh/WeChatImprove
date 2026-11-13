#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendCallDiagnostics.h"
#import "CSCloseFriendSignatures.h"

static NSUInteger Checks,Epoch=19,HookInstalls;
static NSMutableDictionary *Capabilities;
#define CHECK(condition) do { Checks++; if(!(condition)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#condition); return 1; } } while(0)
static NSString *Counter(NSString *report,NSString *name) {
    NSString *prefix=[name stringByAppendingString:@"="];
    for(NSString *line in [report componentsSeparatedByString:@"\n"])
        if([line hasPrefix:prefix])return [line substringFromIndex:prefix.length];
    return nil;
}
NSUInteger CSCloseFriendAccountEpoch(void) {return Epoch;}
void CSCloseFriendRecordCapability(NSString *name,BOOL available) {Capabilities[name]=@(available);}
static void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original) {
    Method method=class_getInstanceMethod(cls,selector);*original=method_getImplementation(method);
    class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));HookInstalls++;
}
BOOL CSCloseFriendInstallHook(NSString *name,NSString *selectorName,IMP replacement,IMP *original,const char *encoding) {
    Class cls=NSClassFromString(name);SEL selector=NSSelectorFromString(selectorName);
    BOOL available=cls && CSCloseFriendMethodMatches(class_getInstanceMethod(cls,selector),encoding);
    if(available)MSHookMessageEx(cls,selector,replacement,original);
    CSCloseFriendRecordCapability([NSString stringWithFormat:@"%@.%@",name,selectorName],available);return available;
}

// Public UN boundaries only; no system notification daemon or device is used.
@interface UNPushNotificationTrigger : NSObject @end
@implementation UNPushNotificationTrigger @end
@interface UNTimeIntervalNotificationTrigger : NSObject @end
@implementation UNTimeIntervalNotificationTrigger @end
@interface UNNotificationRequest : NSObject
@property id trigger;
@property NSString *identifier;
@end
@implementation UNNotificationRequest @end
@interface UNNotification : NSObject
@property UNNotificationRequest *request;
@end
@implementation UNNotification @end
@interface UNNotificationResponse : NSObject
@property UNNotification *notification;
@end
@implementation UNNotificationResponse @end
@interface UNUserNotificationCenter : NSObject
@property(nonatomic,weak) id delegate;
+ (instancetype)currentNotificationCenter;
@end
@implementation UNUserNotificationCenter
+ (instancetype)currentNotificationCenter {static id center;static dispatch_once_t once;dispatch_once(&once,^{center=[self new];});return center;}
@end

@interface ResponseBoundary : NSObject
@property NSUInteger nativeCalls;
@property id lastOwner,lastCenter,lastResponse,lastCompletion;
@property(copy) void (^pendingCompletion)(void);
@property BOOL diagnosticVisibleAtEntry;
- (void)receiveCenter:(id)center response:(id)response completion:(void(^)(void))completion;
@end
@implementation ResponseBoundary
- (void)receiveCenter:(id)center response:(id)response completion:(void(^)(void))completion {
    self.nativeCalls++;self.lastOwner=self;self.lastCenter=center;self.lastResponse=response;self.lastCompletion=completion;
    self.pendingCompletion=completion;
    NSString *report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    self.diagnosticVisibleAtEntry=[Counter(report,@"response.enter") integerValue]>0;
}
@end
@interface MicroMessengerAppDelegate : ResponseBoundary
- (void)userNotificationCenter:(id)center didReceiveNotificationResponse:(id)response withCompletionHandler:(void(^)(void))completion;
- (void)internalHandleReceiveNotificationResponse:(id)response withCompletionHandler:(void(^)(void))completion;
@end
@implementation MicroMessengerAppDelegate
- (void)userNotificationCenter:(id)center didReceiveNotificationResponse:(id)response withCompletionHandler:(void(^)(void))completion {[self receiveCenter:center response:response completion:completion];}
- (void)internalHandleReceiveNotificationResponse:(id)response withCompletionHandler:(void(^)(void))completion {[self receiveCenter:nil response:response completion:completion];}
@end
@interface NotificationActionsMgr : ResponseBoundary
- (void)userNotificationCenter:(id)center didReceiveNotificationResponse:(id)response withCompletionHandler:(void(^)(void))completion;
@end
@implementation NotificationActionsMgr
- (void)userNotificationCenter:(id)center didReceiveNotificationResponse:(id)response withCompletionHandler:(void(^)(void))completion {[self receiveCenter:center response:response completion:completion];}
@end
@interface OtherNotificationDelegate : ResponseBoundary
- (void)userNotificationCenter:(id)center didReceiveNotificationResponse:(id)response withCompletionHandler:(void(^)(void))completion;
@end
@implementation OtherNotificationDelegate
// Runtime identity, rather than an overridable -class, selects the active route.
- (Class)class {return MicroMessengerAppDelegate.class;}
- (void)userNotificationCenter:(id)center didReceiveNotificationResponse:(id)response withCompletionHandler:(void(^)(void))completion {[self receiveCenter:center response:response completion:completion];}
@end
@interface InheritedNotificationDelegate : OtherNotificationDelegate @end
@implementation InheritedNotificationDelegate @end
@interface NoResponseDelegate : NSObject @end
@implementation NoResponseDelegate @end

#include "CallResponseProduction.inc"

static UNNotificationResponse *Response(BOOL remote) {
    UNNotificationRequest *request=[UNNotificationRequest new];request.trigger=remote?[UNPushNotificationTrigger new]:[UNTimeIntervalNotificationTrigger new];
    request.identifier=@"private-notification-identifier";
    UNNotification *notification=[UNNotification new];notification.request=request;
    UNNotificationResponse *response=[UNNotificationResponse new];response.notification=notification;return response;
}
int main(void) { @autoreleasepool {
    Capabilities=[NSMutableDictionary dictionary];UNUserNotificationCenter *center=UNUserNotificationCenter.currentNotificationCenter;
    UNNotificationResponse *remote=Response(YES),*local=Response(NO);
    __block NSUInteger completions=0;void (^completion)(void)=^{completions++;};
    NotificationActionsMgr *actions=[NotificationActionsMgr new];center.delegate=actions;
    // The previous observer hooks only the app delegate. The system's actual
    // actions delegate handles the tap while every response counter stays zero.
    InstallCallDiagnosticResponseForClass(MicroMessengerAppDelegate.class,@"response.app");
    CSCFCallDiagnosticsStartRecording(Epoch);
    [actions userNotificationCenter:center didReceiveNotificationResponse:remote withCompletionHandler:completion];
    NSString *report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    CHECK(actions.nativeCalls==1 && [Counter(report,@"response.enter") isEqual:@"0"]);
    CHECK([Counter(report,@"notification.response.remote") isEqual:@"0"] && completions==0);
    actions.pendingCompletion();CHECK(completions==1);

    // Run the production installers. Observation precedes the original method;
    // its receiver, arguments, and original deferred completion remain intact.
    InstallCallDiagnosticResponse();InstallCallDiagnosticInternalResponse();
    CSCFCallDiagnosticsStartRecording(Epoch);
    [actions userNotificationCenter:center didReceiveNotificationResponse:remote withCompletionHandler:completion];
    report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    CHECK(actions.nativeCalls==2 && actions.lastOwner==actions && actions.lastCenter==center);
    CHECK(actions.lastResponse==remote && actions.lastCompletion==completion);
    CHECK(actions.diagnosticVisibleAtEntry && completions==1);
    CHECK([Counter(report,@"response.actions") isEqual:@"1"] && [Counter(report,@"notification.response.remote") isEqual:@"1"]);
    actions.pendingCompletion();CHECK(completions==2);
    [actions userNotificationCenter:center didReceiveNotificationResponse:local withCompletionHandler:completion];
    report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    CHECK(actions.nativeCalls==3 && [Counter(report,@"notification.response.local") isEqual:@"1"]);
    CHECK([Counter(report,@"notification.response.remote") isEqual:@"1"] && completions==2);
    CHECK(![report containsString:@"private-notification-identifier"]);

    MicroMessengerAppDelegate *app=[MicroMessengerAppDelegate new];
    [app internalHandleReceiveNotificationResponse:remote withCompletionHandler:completion];
    report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    CHECK(app.nativeCalls==1 && app.lastOwner==app && app.lastCenter==nil && app.lastResponse==remote);
    CHECK(app.lastCompletion==completion && completions==2);
    CHECK([Counter(report,@"response.internal") isEqual:@"1"]);
    app.pendingCompletion();CHECK(completions==3);

    // Inspect the real center delegate, including a class that overrides -class.
    OtherNotificationDelegate *other=[OtherNotificationDelegate new];center.delegate=other;
    CSCFCallDiagnosticsInspectNotificationDelegate();NSUInteger installed=HookInstalls;
    CSCFCallDiagnosticsInspectNotificationDelegate();CHECK(HookInstalls==installed);
    CSCFCallDiagnosticsStartRecording(Epoch);
    [other userNotificationCenter:center didReceiveNotificationResponse:remote withCompletionHandler:completion];
    report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    CHECK(other.nativeCalls==1 && other.lastOwner==other && other.lastCenter==center && other.lastResponse==remote && other.lastCompletion==completion);
    CHECK([Counter(report,@"response.active") isEqual:@"1"] && [Counter(report,@"response.enter") isEqual:@"1"]);
    CHECK([Counter(report,@"notification.response.remote") isEqual:@"1"]);
    CHECK([Capabilities[@"calls.diagnostics.activeDelegate"] boolValue]);
    InheritedNotificationDelegate *inherited=[InheritedNotificationDelegate new];center.delegate=inherited;
    CSCFCallDiagnosticsInspectNotificationDelegate();CHECK(HookInstalls==installed);
    CSCFCallDiagnosticsStartRecording(Epoch);
    [inherited userNotificationCenter:center didReceiveNotificationResponse:local withCompletionHandler:completion];
    report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    CHECK(inherited.nativeCalls==1 && [Counter(report,@"response.enter") isEqual:@"1"]);
    CHECK([Counter(report,@"notification.response.local") isEqual:@"1"]);

    NoResponseDelegate *none=[NoResponseDelegate new];center.delegate=none;
    SEL selector=NSSelectorFromString(@"userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:");
    CHECK(![none respondsToSelector:selector]);CSCFCallDiagnosticsInspectNotificationDelegate();
    CHECK(![none respondsToSelector:selector] && HookInstalls==installed);
    CHECK(![Capabilities[@"calls.diagnostics.activeDelegate"] boolValue]);
    center.delegate=nil;CSCFCallDiagnosticsInspectNotificationDelegate();
    report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    CHECK([Counter(report,@"delegate.none") isEqual:@"1"]);

    CSCFCallDiagnosticsStopRecording();NSString *before=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    [other userNotificationCenter:center didReceiveNotificationResponse:remote withCompletionHandler:completion];
    report=CSCFCallDiagnosticsReport(@"response-test",Capabilities,Epoch);
    CHECK(other.nativeCalls==2 && other.lastCompletion==completion && completions==3);
    CHECK([Counter(before,@"response.enter") isEqual:Counter(report,@"response.enter")]);
    other.pendingCompletion();CHECK(completions==4);
    installed=HookInstalls;InstallCallDiagnosticResponse();InstallCallDiagnosticInternalResponse();
    CHECK(HookInstalls==installed);
    printf("Close-friend call response: %lu contract checks passed (actual actions, scene internal, delegate identity, passthrough, inheritance, opt-in)\n",(unsigned long)Checks);
} return 0; }
