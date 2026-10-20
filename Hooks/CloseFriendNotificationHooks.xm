#import "../Controllers/CSCloseFriendNotificationAdapter.h"
#import "../Controllers/CSCloseFriendMuteAdapter.h"
#import "../Controllers/CSCloseFriendCallAdapter.h"
#import "../Controllers/CSCloseFriendBridge.h"
#import "../Controllers/CSGroupListAdapter.h"
#import <UserNotifications/UserNotifications.h>
#import <substrate.h>
#import <objc/message.h>
static NSMutableDictionary<NSString *,NSDictionary *> *Requests;
static NSHashTable *TabOwners;
static BOOL Silent(CSCloseFriendAlertSubject *subject) { return [subject shouldDiscardOutput] || CSCFCallOutputSuppressed(); }
static CSCloseFriendAlertSubject *ItemSubject(id item) {
    return CSCFBoundAlert(item) ?: CSCFMessageSubject(CSCloseFriendRead(item,@"message"),CSCloseFriendRead(item,@"contact") ?: CSCloseFriendRead(item,@"username"));
}
static void RemoveKnown(NSArray<UNNotificationRequest *> *requests,BOOL delivered) {
    NSMutableArray *ids=[NSMutableArray array];
    @synchronized(Requests) {
        for(UNNotificationRequest *request in requests) {
            NSDictionary *entry=Requests[request.identifier];
            CSCloseFriendAlertSubject *subject=entry[@"subject"];
            if([subject shouldDiscardOutput] && [entry[@"content"] isEqual:request.content])[ids addObject:request.identifier];
        }
        if(!ids.count)return;
        if(delivered)[UNUserNotificationCenter.currentNotificationCenter removeDeliveredNotificationsWithIdentifiers:ids];
        else [UNUserNotificationCenter.currentNotificationCenter removePendingNotificationRequestsWithIdentifiers:ids];
    }
}
static BOOL ChatTab(id controller,NSUInteger index) {
    id views=CSCloseFriendRead(controller,@"viewControllers");if(![views isKindOfClass:NSArray.class] || index>=[views count])return NO;
    id root=views[index];if([root isKindOfClass:UINavigationController.class])root=[root viewControllers].firstObject;
    Class cls=NSClassFromString(@"NewMainFrameViewController");BOOL matches=cls && [root isKindOfClass:cls];
    if(matches && NSThread.isMainThread)[TabOwners addObject:controller];return matches;
}
%ctor { dispatch_async(dispatch_get_main_queue(),^{
    Requests=[NSMutableDictionary dictionary]; TabOwners=[NSHashTable weakObjectsHashTable]; [CSCloseFriendMuteAdapter start];
    for(NSString *name in @[@"showQuickReplyItem:",@"showQuickReplyItem:timeout:"]) {
        __block IMP orig=NULL;SEL sel=NSSelectorFromString(name);BOOL timed=[name hasSuffix:@"timeout:"];
        IMP imp=timed?imp_implementationWithBlock(^(id owner,id item,double timeout){CSCloseFriendAlertSubject *s=ItemSubject(item);if(Silent(s))return;CSCFWithAlert(s,^{((void(*)(id,SEL,id,double))orig)(owner,sel,item,timeout);});}):imp_implementationWithBlock(^(id owner,id item){CSCloseFriendAlertSubject *s=ItemSubject(item);if(Silent(s))return;CSCFWithAlert(s,^{((void(*)(id,SEL,id))orig)(owner,sel,item);});});
        if(!CSCloseFriendInstallHook(@"QuickReplyMsgMgr",name,imp,&orig,timed?"v@:@d":"v@:@"))imp_removeBlock(imp);
    }
    __block IMP quick=NULL;
    IMP imp=imp_implementationWithBlock(^(id owner,id contact,id message,double timeout){CSCloseFriendAlertSubject *s=CSCFMessageSubject(message,contact);if(Silent(s))return;CSCFWithAlert(s,^{((void(*)(id,SEL,id,id,double))quick)(owner,NSSelectorFromString(@"showQuickReplyMsg:message:timeout:"),contact,message,timeout);});});
    if(!CSCloseFriendInstallHook(@"QuickReplyMsgMgr",@"showQuickReplyMsg:message:timeout:",imp,&quick,"v@:@@d"))imp_removeBlock(imp);
    __block IMP canShow=NULL;
    imp=imp_implementationWithBlock(^BOOL(id owner,id contact,id message){if([CSCFMessageSubject(message,contact) shouldDiscardOutput])return NO;return ((BOOL(*)(id,SEL,id,id))canShow)(owner,NSSelectorFromString(@"canShowPushForContact:msgWrap:"),contact,message);});
    if(!CSCloseFriendInstallHook(@"QuickReplyMsgMgr",@"canShowPushForContact:msgWrap:",imp,&canShow,"B@:@@"))imp_removeBlock(imp);
    __block IMP arriving=NULL;
    imp=imp_implementationWithBlock(^(id owner,id message,long long flags){CSCFWithAlert(CSCFMessageSubject(message,nil),^{((void(*)(id,SEL,id,long long))arriving)(owner,NSSelectorFromString(@"onNewMsgArriving:NotifyFlag:"),message,flags);});});
    if(!CSCloseFriendInstallHook(@"QuickReplyMsgMgr",@"onNewMsgArriving:NotifyFlag:",imp,&arriving,"v@:@q"))imp_removeBlock(imp);
    // Never globally disable audio/haptics. These native output functions are
    // gated only within an identity-bearing incoming alert scope, including stale
    // scopes whose old-account output must be discarded.
    Class audio=NSClassFromString(@"AudioHelper");SEL vibration=NSSelectorFromString(@"playVibration");
    if(CSCloseFriendMethodMatches(class_getClassMethod(audio,vibration),"v@:")) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id owner){if(!Silent(CSCFCurrentAlert()))((void(*)(id,SEL))original)(owner,vibration);});
        MSHookMessageEx(object_getClass(audio),vibration,replacement,&original);
        CSCloseFriendRecordCapability(@"notifications.boundVibration",original!=NULL);
    } else CSCloseFriendRecordCapability(@"notifications.boundVibration",NO);
    SEL sound=NSSelectorFromString(@"playSound:fileType:volume:ambient:");
    if(CSCloseFriendMethodMatches(class_getClassMethod(audio,sound),"v@:@@fB")) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id owner,id file,id type,float volume,BOOL ambient){if(!Silent(CSCFCurrentAlert()))((void(*)(id,SEL,id,id,float,BOOL))original)(owner,sound,file,type,volume,ambient);});
        MSHookMessageEx(object_getClass(audio),sound,replacement,&original);
        CSCloseFriendRecordCapability(@"notifications.boundSound",original!=NULL);
    } else CSCloseFriendRecordCapability(@"notifications.boundSound",NO);
    __block IMP push=NULL;
    imp=imp_implementationWithBlock(^(id owner,id message,id identifier,id date,BOOL voip,BOOL silent){CSCFWithAlert(CSCFMessageSubject(message,nil),^{((void(*)(id,SEL,id,id,id,BOOL,BOOL))push)(owner,NSSelectorFromString(@"showPushWithMessageWrap:identifier:fireDate:isFromVoipPush:shouldSilent:"),message,identifier,date,voip,silent);});});
    if(!CSCloseFriendInstallHook(@"MMLocalNotificationMgr",@"showPushWithMessageWrap:identifier:fireDate:isFromVoipPush:shouldSilent:",imp,&push,"v@:@@@BB"))imp_removeBlock(imp);
    __block IMP info=NULL;
    imp=imp_implementationWithBlock(^id(id owner,id message,id settings,BOOL voip){id result=((id(*)(id,SEL,id,id,BOOL))info)(owner,NSSelectorFromString(@"notificationInfoForMessage:withEnabledNotificationSettings:isFromVoipPush:"),message,settings,voip);CSCFBindAlert(result,CSCFMessageSubject(message,nil));return result;});
    if(!CSCloseFriendInstallHook(@"MMLocalNotificationMgr",@"notificationInfoForMessage:withEnabledNotificationSettings:isFromVoipPush:",imp,&info,"@@:@@B"))imp_removeBlock(imp);
    // Class-method boundary: full ABI gate, then hook its metaclass. Never inspect
    // unverified notification dictionary keys as account/session identity.
    Class utility=NSClassFromString(@"MMLocalNotificationUtil");SEL local=NSSelectorFromString(@"showLocalNotificationWithInfo:");
    if(CSCloseFriendMethodMatches(class_getClassMethod(utility,local),"v@:@")) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id owner,id value){CSCloseFriendAlertSubject *s=CSCFBoundAlert(value)?:CSCFCurrentAlert();if(Silent(s))return;CSCFWithAlert(s,^{((void(*)(id,SEL,id))original)(owner,local,value);});});
        // The installer takes class names for instance methods; install this
        // metaclass method through the same signature predicate and substrate.
        MSHookMessageEx(object_getClass(utility),local,replacement,&original);
        CSCloseFriendRecordCapability(@"notifications.localInfo",original!=NULL);
    } else CSCloseFriendRecordCapability(@"notifications.localInfo",NO);
    __block IMP add=NULL;
    imp=imp_implementationWithBlock(^(UNUserNotificationCenter *center,UNNotificationRequest *request,void (^completion)(NSError *)){
        CSCloseFriendAlertSubject *s=CSCFBoundAlert(request)?:CSCFCurrentAlert();
        if(Silent(s)) {if(completion)completion(nil);return;}
        NSNumber *badge=[CSGroupListAdapter closeFriendAlertBadgeCount];
        if(badge && request.content.badge) {UNMutableNotificationContent *content=[request.content mutableCopy];content.badge=badge;request=[UNNotificationRequest requestWithIdentifier:request.identifier content:content trigger:request.trigger];}
        if([s isCurrent]) { @synchronized(Requests){
            if(Requests.count>=512)[Requests removeAllObjects];
            Requests[request.identifier]=@{@"subject":s,@"content":request.content};
        }}
        ((void(*)(id,SEL,id,id))add)(center,@selector(addNotificationRequest:withCompletionHandler:),request,completion);
    });
    if(!CSCloseFriendInstallHook(@"UNUserNotificationCenter",@"addNotificationRequest:withCompletionHandler:",imp,&add,"v@:@@?"))imp_removeBlock(imp);
    for(NSString *name in @[@"presentLocalNotificationNow:",@"scheduleLocalNotification:"]) {
        __block IMP original=NULL;SEL sel=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id app,UILocalNotification *notification){CSCloseFriendAlertSubject *s=CSCFBoundAlert(notification)?:CSCFCurrentAlert();if(Silent(s))return;NSNumber *badge=[CSGroupListAdapter closeFriendAlertBadgeCount];if(badge){notification=[notification copy];notification.applicationIconBadgeNumber=badge.integerValue;}((void(*)(id,SEL,id))original)(app,sel,notification);});
        if(!CSCloseFriendInstallHook(@"UIApplication",name,replacement,&original,"v@:@"))imp_removeBlock(replacement);
    }
    __block IMP badge=NULL;
    imp=imp_implementationWithBlock(^(id app,NSInteger count){NSNumber *value=[CSGroupListAdapter closeFriendAlertBadgeCount];((void(*)(id,SEL,NSInteger))badge)(app,@selector(setApplicationIconBadgeNumber:),value?value.integerValue:count);});
    if(!CSCloseFriendInstallHook(@"UIApplication",@"setApplicationIconBadgeNumber:",imp,&badge,"v@:q"))imp_removeBlock(imp);
    __block IMP tab=NULL;
    imp=imp_implementationWithBlock(^(id owner,unsigned long long count,unsigned long long index){NSNumber *value=ChatTab(owner,(NSUInteger)index)?[CSGroupListAdapter closeFriendAlertBadgeCount]:nil;((void(*)(id,SEL,unsigned long long,unsigned long long))tab)(owner,NSSelectorFromString(@"setTabBarBadgeValue:forIndex:"),value?value.unsignedLongLongValue:count,index);});
    if(!CSCloseFriendInstallHook(@"MMTabBarController",@"setTabBarBadgeValue:forIndex:",imp,&tab,"v@:QQ"))imp_removeBlock(imp);
    __block IMP tabString=NULL;
    imp=imp_implementationWithBlock(^(id owner,id string,unsigned long long index){NSNumber *value=ChatTab(owner,(NSUInteger)index)?[CSGroupListAdapter closeFriendAlertBadgeCount]:nil;((void(*)(id,SEL,id,unsigned long long))tabString)(owner,NSSelectorFromString(@"setTabBarBadgeString:forIndex:"),value?(value.unsignedLongLongValue?value.stringValue:nil):string,index);});
    if(!CSCloseFriendInstallHook(@"MMTabBarController",@"setTabBarBadgeString:forIndex:",imp,&tabString,"v@:@Q"))imp_removeBlock(imp);
    __block IMP dot=NULL;
    imp=imp_implementationWithBlock(^(id owner,unsigned long long index){NSNumber *value=ChatTab(owner,(NSUInteger)index)?[CSGroupListAdapter closeFriendAlertBadgeCount]:nil;if(value && !value.unsignedLongLongValue)return;((void(*)(id,SEL,unsigned long long))dot)(owner,NSSelectorFromString(@"showRedDotOnTabBarItemAtIndex:"),index);});
    if(!CSCloseFriendInstallHook(@"MMTabBarController",@"showRedDotOnTabBarItemAtIndex:",imp,&dot,"v@:Q"))imp_removeBlock(imp);
    [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
        [UNUserNotificationCenter.currentNotificationCenter getPendingNotificationRequestsWithCompletionHandler:^(NSArray *requests){dispatch_async(dispatch_get_main_queue(),^{RemoveKnown(requests,NO);});}];
        [UNUserNotificationCenter.currentNotificationCenter getDeliveredNotificationsWithCompletionHandler:^(NSArray *notifications){NSMutableArray *requests=[NSMutableArray array];for(UNNotification *n in notifications)[requests addObject:n.request];dispatch_async(dispatch_get_main_queue(),^{RemoveKnown(requests,YES);});}];
        NSNumber *value=[CSGroupListAdapter closeFriendAlertBadgeCount];if(value)UIApplication.sharedApplication.applicationIconBadgeNumber=value.integerValue;
        if(value)for(id owner in TabOwners.allObjects) {
            NSArray *views=CSCloseFriendRead(owner,@"viewControllers");if(![views isKindOfClass:NSArray.class])continue;
            for(NSUInteger index=0;index<views.count;index++)if(ChatTab(owner,index)) {
                SEL set=NSSelectorFromString(@"setTabBarBadgeValue:forIndex:");
                if(CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],set),"v@:QQ"))((void(*)(id,SEL,unsigned long long,unsigned long long))objc_msgSend)(owner,set,value.unsignedLongLongValue,(unsigned long long)index);
                SEL remove=NSSelectorFromString(@"removeRedDotOnTabBarItemAtIndex:");
                if(!value.unsignedLongLongValue && CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],remove),"v@:Q"))((void(*)(id,SEL,unsigned long long))objc_msgSend)(owner,remove,(unsigned long long)index);
            }
        }
    }];
}); }
