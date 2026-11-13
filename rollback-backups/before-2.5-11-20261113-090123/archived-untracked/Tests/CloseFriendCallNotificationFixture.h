// These native-boundary doubles exercise the production installation blocks,
// call adapter, settings-callback wrapper, and UN submission hook together.
// They do not contact an iPhone, the notification daemon, or WeChat servers.
#import "CSCloseFriendCallDiagnostics.h"
static UNUserNotificationCenter *CallNotificationSettingsCenter;
@interface CAppUtil : NSObject
+ (void)GetEnabledNotificationSettingWithCompletionHandler:(void(^)(id))completion;
@end
@implementation CAppUtil
+ (void)GetEnabledNotificationSettingWithCompletionHandler:(void(^)(id))completion {
    [CallNotificationSettingsCenter getNotificationSettingsWithCompletionHandler:completion];
}
@end
static void MSHookMessageEx(Class cls,SEL selector,IMP replacement,IMP *original) {
    Method method=class_getInstanceMethod(cls,selector);*original=method_getImplementation(method);
    class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));
}
@interface MonoServiceMsgMgr : NSObject
@property UNUserNotificationCenter *center;
@property NSUInteger entries,vibrations,callbacks;
@property BOOL lastRepeat,lastSilent,lastCallkit;
@property id lastMessage,lastSettings;
- (void)showLocalNotificationWithMsg:(id)message repeatVibration:(BOOL)repeat;
- (void)showLocalNotificationWithMsg:(id)message repeatVibration:(BOOL)repeat silently:(BOOL)silent;
- (void)showLocalNotificationByIlinkWithMsg:(id)message repeatVibration:(BOOL)repeat isCallkitAvailable:(BOOL)callkit;
@end
@implementation MonoServiceMsgMgr
- (void)emitMessage:(id)message repeat:(BOOL)repeat silent:(BOOL)silent callkit:(BOOL)callkit {
    self.entries++;self.lastMessage=message;self.lastRepeat=repeat;self.lastSilent=silent;self.lastCallkit=callkit;
    UNUserNotificationCenter *previous=CallNotificationSettingsCenter;CallNotificationSettingsCenter=self.center;
    @try {[CAppUtil GetEnabledNotificationSettingWithCompletionHandler:^(id settings){
        self.callbacks++;self.lastSettings=settings;
        UNNotificationRequest *request=[UNNotificationRequest requestWithIdentifier:@"native-call" content:[UNMutableNotificationContent new] trigger:nil];
        [self.center addNotificationRequest:request withCompletionHandler:nil];
        if(repeat && !silent)self.vibrations++;
    }];} @finally {CallNotificationSettingsCenter=previous;}
}
- (void)showLocalNotificationWithMsg:(id)message repeatVibration:(BOOL)repeat {
    [self emitMessage:message repeat:repeat silent:NO callkit:NO];
}
- (void)showLocalNotificationWithMsg:(id)message repeatVibration:(BOOL)repeat silently:(BOOL)silent {
    [self emitMessage:message repeat:repeat silent:silent callkit:NO];
}
- (void)showLocalNotificationByIlinkWithMsg:(id)message repeatVibration:(BOOL)repeat isCallkitAvailable:(BOOL)callkit {
    [self emitMessage:message repeat:repeat silent:NO callkit:callkit];
}
@end
#import "AlertCallNotificationHooks.h"
static MonoServiceMsgMgr *NotificationManager(BOOL deferred) {
    MonoServiceMsgMgr *manager=[MonoServiceMsgMgr new];manager.center=[UNUserNotificationCenter new];manager.center.deferSettings=deferred;return manager;
}
static void ShowCallNotification(MonoServiceMsgMgr *manager,id message,NSUInteger route) {
    if(route==0)[manager showLocalNotificationWithMsg:message repeatVibration:YES];
    else if(route==1)[manager showLocalNotificationWithMsg:message repeatVibration:YES silently:NO];
    else [manager showLocalNotificationByIlinkWithMsg:message repeatVibration:YES isCallkitAvailable:YES];
}
static void CompleteCallNotification(MonoServiceMsgMgr *manager) {
    NSArray *callbacks=[manager.center.settingsCallbacks copy];[manager.center.settingsCallbacks removeAllObjects];
    for(void (^completion)(id) in callbacks)completion(@"deferred-native-settings");
}
static void CallNotificationChecks(void) {
    NSUInteger firstCheck=Checks;
    CSCloseFriendSnapshot *savedPolicy=Policy;NSDictionary *savedServices=[FixtureServices copy];
    id savedCache=VoIPMPSubCallService.sharedInstance.cache;
    InstallCallNotifications();
    unsigned long long room=90000;
    // All three native notification boundaries stop protected audio/video calls
    // before vibration, settings queries, asynchronous callbacks, or submission.
    Policy=Snapshot(YES,NO,nil);
    for(NSUInteger route=0;route<3;route++)for(NSNumber *ilink in @[@NO,@YES])for(NSNumber *video in @[@NO,@YES]) {
        MonoServiceMsgMgr *manager=NotificationManager(NO);
        VoipMonoMsg *message=IncomingMessage(@"friend",room++,ilink.boolValue,video.boolValue);
        ShowCallNotification(manager,message,route);
        CHECK(manager.entries==0 && manager.vibrations==0 && manager.callbacks==0);
        CHECK(manager.center.settingsRequests==0 && manager.center.submissions==0);
        CHECK(!CSCFCallOutputSuppressed() && !CSCFCurrentAlert());
    }
    // Ordinary callers and temporarily revealed friends retain the native path.
    for(NSUInteger route=0;route<3;route++)for(NSNumber *revealed in @[@NO,@YES]) {
        Policy=Snapshot(YES,revealed.boolValue,nil);
        MonoServiceMsgMgr *manager=NotificationManager(NO);
        VoipMonoMsg *message=IncomingMessage(revealed.boolValue?@"friend":@"ordinary",room++,route==2,NO);
        ShowCallNotification(manager,message,route);
        CHECK(manager.entries==1 && manager.vibrations==1 && manager.callbacks==1);
        CHECK(manager.center.settingsRequests==1 && manager.center.submissions==1);
        CHECK(manager.lastMessage==message && manager.lastRepeat && !manager.lastSilent && manager.lastCallkit==(route==2));
        CHECK([manager.lastSettings isEqual:@"native-settings"]);
    }
    // Only the matching media option matters; disabling the master switch also
    // preserves notifications even when individual rejection options are on.
    for(NSNumber *video in @[@NO,@YES]) {
        Policy=Snapshot(YES,NO,@{(video.boolValue?@"rejectVideo":@"rejectVoice"):@NO});
        MonoServiceMsgMgr *manager=NotificationManager(NO);
        ShowCallNotification(manager,IncomingMessage(@"friend",room++,YES,video.boolValue),2);
        CHECK(manager.entries==1 && manager.center.submissions==1);
    }
    Policy=Snapshot(NO,NO,nil);
    MonoServiceMsgMgr *manager=NotificationManager(NO);
    [manager showLocalNotificationWithMsg:IncomingMessage(@"friend",room++,NO,NO) repeatVibration:NO silently:YES];
    CHECK(manager.entries==1 && manager.vibrations==0 && manager.center.submissions==1);
    CHECK(!manager.lastRepeat && manager.lastSilent);
    // Re-check policy after the system settings callback crosses an async gap.
    // This covers re-locking, newly protected membership, and enabling rejection.
    for(NSUInteger transition=0;transition<3;transition++) {
        Policy=transition==0?Snapshot(YES,YES,nil):transition==1?Snapshot(YES,NO,nil):Snapshot(YES,NO,@{@"rejectVoice":@NO});
        manager=NotificationManager(YES);
        VoipMonoMsg *message=IncomingMessage(transition==1?@"ordinary":@"friend",room++,NO,NO);
        ShowCallNotification(manager,message,0);
        CHECK(manager.entries==1 && manager.center.settingsRequests==1 && manager.callbacks==0);
        CHECK(!CSCFCallOutputSuppressed() && !CSCFCurrentAlert());
        if(transition==1)Policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@YES,@"friends":@[@"ordinary"]} revealed:NO revision:Epoch blocked:NO];
        else Policy=Snapshot(YES,NO,nil);
        CompleteCallNotification(manager);
        CHECK(manager.callbacks==0 && manager.center.submissions==0 && manager.vibrations==0);
        CHECK(!CSCFCallOutputSuppressed() && !CSCFCurrentAlert());
    }
    // An old account's queued callback never borrows the new account's policy.
    Policy=Snapshot(YES,YES,nil);manager=NotificationManager(YES);
    VoipMonoMsg *stale=IncomingMessage(@"friend",room++,YES,NO);ShowCallNotification(manager,stale,2);
    Epoch++;Policy=Snapshot(NO,YES,nil);CompleteCallNotification(manager);
    CHECK(manager.entries==1 && manager.callbacks==0 && manager.center.submissions==0 && manager.vibrations==0);
    // Stale entry messages are likewise discarded before any native side effect.
    MonoServiceMsgMgr *staleManager=NotificationManager(NO);ShowCallNotification(staleManager,stale,0);
    CHECK(staleManager.entries==0 && staleManager.center.submissions==0);
    // A notification already queued for a call that was later rejected stays
    // suppressed even if the user unlocks again before the callback arrives.
    VoipUIManager *ui=[VoipUIManager new];MultiTalkMgr *multi=[MultiTalkMgr new];VoIPConfSDKService *sdk=[VoIPConfSDKService new];
    FixtureServices=[@{@"VoipUIManager":ui,@"MultiTalkMgr":multi,@"VoIPConfSDKService":sdk} mutableCopy];
    VoIPMPSubCallService.sharedInstance.cache=nil;
    Policy=Snapshot(YES,YES,nil);manager=NotificationManager(YES);
    VoipMonoMsg *rejected=IncomingMessage(@"friend",room++,YES,NO);ShowCallNotification(manager,rejected,2);
    Policy=Snapshot(YES,NO,nil);VoIPilinkMgr *ilink=[VoIPilinkMgr new];
    CHECK(CSCFHandleIncomingCall(ilink,rejected,YES) && ilink.rejects==1 && sdk.submissions==1);
    Policy=Snapshot(YES,YES,nil);CompleteCallNotification(manager);
    CHECK(manager.callbacks==0 && manager.center.submissions==0 && manager.vibrations==0);
    // A still-valid ordinary call completes after the async gap with the same
    // settings value; cancellation and message-key reuse invalidate captured work.
    Policy=Snapshot(YES,NO,nil);manager=NotificationManager(YES);
    ShowCallNotification(manager,IncomingMessage(@"ordinary",room++,NO,NO),0);
    CompleteCallNotification(manager);
    CHECK(manager.callbacks==1 && manager.center.submissions==1 && manager.vibrations==1);
    CHECK([manager.lastSettings isEqual:@"deferred-native-settings"]);
    for(NSUInteger invalidation=0;invalidation<2;invalidation++) {
        manager=NotificationManager(YES);
        VoipMonoMsg *message=IncomingMessage(@"ordinary",room++,NO,NO);ShowCallNotification(manager,message,0);
        if(invalidation==0)message.cancel=YES;else message.msgKey=@"reused-native-message";
        CompleteCallNotification(manager);
        CHECK(manager.callbacks==0 && manager.center.submissions==0 && manager.vibrations==0);
    }
    // A nested unknown notification cannot borrow the enclosing call's policy.
    // Both nesting and native exceptions restore the previous thread scopes.
    Policy=Snapshot(YES,YES,nil);
    VoipMonoMsg *outer=IncomingMessage(@"friend",room++,NO,NO);
    CSCFPerformCallNotification(outer,^{
        CHECK(CSCFCurrentAlert().isCurrent);
        Policy=Snapshot(YES,NO,nil);CHECK(CSCFCallOutputSuppressed());
        MonoServiceMsgMgr *unknown=NotificationManager(NO);ShowCallNotification(unknown,@{},0);
        CHECK(unknown.entries==1 && unknown.callbacks==1 && unknown.center.submissions==1 && unknown.vibrations==1);
        CHECK(CSCFCallOutputSuppressed() && CSCFCurrentAlert().isCurrent);
        @try {CSCFPerformCallNotification(@{},^{
            CHECK(!CSCFCallOutputSuppressed() && !CSCFCurrentAlert());
            @throw [NSException exceptionWithName:@"native-notification" reason:nil userInfo:nil];
        });CHECK(NO);} @catch(NSException *exception){CHECK([exception.name isEqual:@"native-notification"]);}
        CHECK(CSCFCallOutputSuppressed() && CSCFCurrentAlert().isCurrent);
    });
    CHECK(!CSCFCallOutputSuppressed() && !CSCFCurrentAlert());
    // Without a call scope, the completion keeps its identity and native use.
    __block NSUInteger ordinaryCallbacks=0;id settings=[NSObject new];
    void (^ordinaryCompletion)(id)=^(id value){CHECK(value==settings);ordinaryCallbacks++;};
    CHECK(CSCFCallNotificationCompletion(ordinaryCompletion)==ordinaryCompletion);
    UNUserNotificationCenter *plain=[UNUserNotificationCenter new];plain.deferSettings=YES;
    CallNotificationSettingsCenter=plain;
    [CAppUtil GetEnabledNotificationSettingWithCompletionHandler:ordinaryCompletion];
    CallNotificationSettingsCenter=nil;
    CHECK(plain.settingsCallbacks.count==1 && plain.settingsCallbacks.firstObject==ordinaryCompletion);
    ((void(^)(id))plain.settingsCallbacks.firstObject)(settings);CHECK(ordinaryCallbacks==1);
    CHECK(!CSCFCallNotificationCompletion(nil));
    // Native output outside the call path still accepts a current friend.
    Policy=Snapshot(YES,NO,nil);plain=[UNUserNotificationCenter new];
    UNNotificationRequest *ordinaryRequest=[UNNotificationRequest requestWithIdentifier:@"ordinary-message" content:[UNMutableNotificationContent new] trigger:nil];
    CSCFWithAlert([CSCloseFriendAlertSubject subjectForSession:@"friend" sender:nil],^{[plain addNotificationRequest:ordinaryRequest withCompletionHandler:nil];});
    CHECK(plain.submissions==1);
    FixtureServices=[savedServices mutableCopy];VoIPMPSubCallService.sharedInstance.cache=savedCache;Policy=savedPolicy;
    printf("Close-friend call notifications: %lu core integration checks passed\n",(unsigned long)(Checks-firstCheck));
}
