#import "CSCloseFriendCallDiagnostics.h"
#import <dispatch/dispatch.h>

static const NSUInteger EventLimit=64;
static BOOL Recording;
static NSUInteger RecordingEpoch;
static NSTimeInterval StartedAt;
static NSMutableDictionary<NSString *,NSNumber *> *Counters;
static NSMutableArray<NSDictionary *> *Events;

static NSObject *DiagnosticsLock(void) {
    static NSObject *lock;static dispatch_once_t once;
    dispatch_once(&once,^{lock=[NSObject new];});return lock;
}
static NSArray<NSString *> *AllowedEvents(void) {
    static NSArray *names;static dispatch_once_t once;
    dispatch_once(&once,^{names=@[@"mono.two",@"mono.three",@"mono.ilink",@"call.token",@"call.unknown",@"call.drop",@"call.pass",
        @"settings.capture",@"settings.enter",@"settings.drop",@"settings.pass",@"push.enter",@"info.enter",
        @"local.enter",@"local.drop",@"local.pass",@"un.enter",@"un.drop",@"un.pass",
        @"payload.known",@"payload.unknown",@"payload.drop",@"payload.pass",@"app.background",@"app.foreground",
        @"app.active",@"app.inactive",@"report.copied",@"voip.handle",@"voip.content",
        @"notification.response.local",@"notification.response.remote",@"response.enter",@"response.voip.known",@"response.voip.unknown",
        @"response.app",@"response.actions",@"response.active",@"response.internal",
        @"delegate.actions",@"delegate.app",@"delegate.other",@"delegate.none"];});
    return names;
}
static NSArray<NSString *> *AllowedCapabilities(void) {
    static NSArray *names;static dispatch_once_t once;
    dispatch_once(&once,^{names=@[
        @"MonoServiceMsgMgr.showLocalNotificationWithMsg:repeatVibration:",
        @"MonoServiceMsgMgr.showLocalNotificationWithMsg:repeatVibration:silently:",
        @"MonoServiceMsgMgr.showLocalNotificationByIlinkWithMsg:repeatVibration:isCallkitAvailable:",
        @"calls.notifications.settingsCallback",@"notifications.localInfo",
        @"UNUserNotificationCenter.addNotificationRequest:withCompletionHandler:",
        @"MMLocalNotificationMgr.showPushWithMessageWrap:identifier:fireDate:isFromVoipPush:shouldSilent:",
        @"MMLocalNotificationMgr.notificationInfoForMessage:withEnabledNotificationSettings:isFromVoipPush:",
        @"calls.diagnostics.pushRoute",@"calls.diagnostics.pushContent",
        @"calls.diagnostics.activeDelegate",
        @"NotificationActionsMgr.userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:",
        @"MicroMessengerAppDelegate.internalHandleReceiveNotificationResponse:withCompletionHandler:",
        @"MicroMessengerAppDelegate.userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:"];
    });return names;
}
static void CheckEpoch(NSUInteger epoch) {
    if(!StartedAt || RecordingEpoch==epoch)return;
    Recording=NO;RecordingEpoch=0;StartedAt=0;Counters=nil;Events=nil;
}
static NSString *Version(id value) {
    if(![value isKindOfClass:NSString.class] || ![value length] || [value length]>64)return @"unknown";
    NSCharacterSet *allowed=[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.+_-"];
    return [value rangeOfCharacterFromSet:allowed.invertedSet].location==NSNotFound?value:@"unknown";
}
void CSCFCallDiagnosticsStartRecording(NSUInteger epoch) {
    @synchronized(DiagnosticsLock()) {
        Recording=YES;RecordingEpoch=epoch;StartedAt=NSProcessInfo.processInfo.systemUptime;
        Counters=[NSMutableDictionary dictionary];Events=[NSMutableArray array];
    }
}
void CSCFCallDiagnosticsRecord(NSString *event,NSUInteger epoch) {
    @synchronized(DiagnosticsLock()) {
        CheckEpoch(epoch);
        if(!Recording || ![event isKindOfClass:NSString.class])return;
        NSUInteger eventIndex=[AllowedEvents() indexOfObject:event];
        if(eventIndex==NSNotFound)return;
        // Retain only our canonical string, never a caller-owned mutable value.
        event=AllowedEvents()[eventIndex];
        NSUInteger count=[Counters[event] unsignedIntegerValue];
        Counters[event]=@(count<NSUIntegerMax?count+1:count);
        if(Events.count>=EventLimit)[Events removeObjectAtIndex:0];
        [Events addObject:@{@"event":event,@"elapsed":@(MAX(0,NSProcessInfo.processInfo.systemUptime-StartedAt))}];
    }
}
void CSCFCallDiagnosticsStopRecording(void) {
    @synchronized(DiagnosticsLock()) {Recording=NO;}
}
BOOL CSCFCallDiagnosticsIsRecording(void) {
    @synchronized(DiagnosticsLock()) {return Recording;}
}
NSString *CSCFCallDiagnosticsReport(NSString *pluginVersion,NSDictionary *capabilities,NSUInteger epoch) {
    @synchronized(DiagnosticsLock()) {
        CheckEpoch(epoch);
        NSMutableString *report=[NSMutableString stringWithFormat:@"WeChatImprove call notification diagnostics\nplugin=%@\nwechat=%@ build=%@\nrecording=%@\nkeptEvents=%lu/%lu\n\nHook capabilities\n",
            Version(pluginVersion),Version([NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"]),
            Version([NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"]),Recording?@"YES":@"NO",
            (unsigned long)Events.count,(unsigned long)EventLimit];
        for(NSString *name in AllowedCapabilities()) {
            id value=capabilities[name];
            [report appendFormat:@"%@=%@\n",name,[value isKindOfClass:NSNumber.class]?([value boolValue]?@"YES":@"NO"):@"missing"];
        }
        [report appendString:@"\nCounters\n"];
        for(NSString *name in AllowedEvents())[report appendFormat:@"%@=%lu\n",name,(unsigned long)[Counters[name] unsignedIntegerValue]];
        [report appendString:@"\nRecent events (seconds after recording started)\n"];
        for(NSDictionary *entry in Events)[report appendFormat:@"+%.3f %@\n",[entry[@"elapsed"] doubleValue],entry[@"event"]];
        return [report copy];
    }
}
