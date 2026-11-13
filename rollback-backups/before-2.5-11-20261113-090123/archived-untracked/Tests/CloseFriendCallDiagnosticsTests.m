#import <Foundation/Foundation.h>
#import "CSCloseFriendCallDiagnostics.h"

static NSUInteger Checks;
#define CHECK(condition) do { Checks++; if(!(condition)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#condition); return 1; } } while(0)
static NSString *Line(NSString *report,NSString *key) {
    NSString *prefix=[key stringByAppendingString:@"="];
    for(NSString *line in [report componentsSeparatedByString:@"\n"])
        if([line hasPrefix:prefix])return [line substringFromIndex:prefix.length];
    return nil;
}
static NSArray<NSString *> *Recent(NSString *report) {
    NSMutableArray *events=[NSMutableArray array];
    for(NSString *line in [report componentsSeparatedByString:@"\n"])
        if([line hasPrefix:@"+"])[events addObject:line];
    return events;
}
static NSString *RecordingBody(NSString *report) {
    NSRange marker=[report rangeOfString:@"\nCounters\n"];
    return marker.location==NSNotFound?nil:[report substringFromIndex:marker.location];
}

int main(void) { @autoreleasepool {
    const NSUInteger firstEpoch=73119,secondEpoch=73120;
    NSString *version=@"2.6-0+diag.1";
    CHECK(!CSCFCallDiagnosticsIsRecording());
    CSCFCallDiagnosticsRecord(@"mono.two",firstEpoch);
    NSString *report=CSCFCallDiagnosticsReport(version,@{},firstEpoch);
    CHECK([Line(report,@"recording") isEqual:@"NO"]);
    CHECK([Line(report,@"keptEvents") isEqual:@"0/64"]);
    CHECK([Line(report,@"mono.two") isEqual:@"0"] && Recent(report).count==0);

    CSCFCallDiagnosticsStartRecording(firstEpoch);
    CHECK(CSCFCallDiagnosticsIsRecording());
    CSCFCallDiagnosticsRecord(@"mono.two",firstEpoch);
    CSCFCallDiagnosticsRecord(@"notification.response.remote",firstEpoch);
    CSCFCallDiagnosticsRecord(@"response.voip.known",firstEpoch);
    NSString *privateValue=@"wxid_private_123 phone=13800138000 body=private-message /private/user/chat.db";
    CSCFCallDiagnosticsRecord(privateValue,firstEpoch);
    CSCFCallDiagnosticsRecord([@"mono.two\n" stringByAppendingString:privateValue],firstEpoch);
    CSCFCallDiagnosticsRecord((id)@99,firstEpoch);
    report=CSCFCallDiagnosticsReport(version,@{},firstEpoch);
    CHECK([Line(report,@"mono.two") isEqual:@"1"]);
    CHECK([Line(report,@"notification.response.remote") isEqual:@"1"]);
    CHECK([Line(report,@"response.voip.known") isEqual:@"1"]);
    CHECK(Recent(report).count==3 && ![report containsString:privateValue]);
    CHECK(![report containsString:@"wxid_private"] && ![report containsString:@"13800138000"]);
    CHECK(![report containsString:@"private-message"] && ![report containsString:@"/private/user/chat.db"]);
    CHECK(![report containsString:@"73119"]);
    NSMutableString *mutableEvent=[@"local.enter" mutableCopy];
    CSCFCallDiagnosticsRecord(mutableEvent,firstEpoch);[mutableEvent setString:privateValue];
    report=CSCFCallDiagnosticsReport(version,@{},firstEpoch);
    CHECK([Line(report,@"local.enter") isEqual:@"1"] && ![report containsString:privateValue]);

    // Only known Hook keys and normalized boolean results enter a copied report.
    NSString *monoCapability=@"MonoServiceMsgMgr.showLocalNotificationWithMsg:repeatVibration:";
    NSString *settingsCapability=@"calls.notifications.settingsCallback";
    NSString *responseCapability=@"MicroMessengerAppDelegate.userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:";
    NSString *unCapability=@"UNUserNotificationCenter.addNotificationRequest:withCompletionHandler:";
    NSDictionary *capabilities=@{monoCapability:@YES,settingsCapability:@NO,responseCapability:@YES,
        unCapability:privateValue,@"notifications.localInfo":NSNull.null,privateValue:@YES};
    report=CSCFCallDiagnosticsReport(version,capabilities,firstEpoch);
    CHECK([Line(report,@"plugin") isEqual:version]);
    CHECK([Line(report,monoCapability) isEqual:@"YES"]);
    CHECK([Line(report,settingsCapability) isEqual:@"NO"]);
    CHECK([Line(report,responseCapability) isEqual:@"YES"]);
    CHECK([Line(report,unCapability) isEqual:@"missing"]);
    CHECK([Line(report,@"notifications.localInfo") isEqual:@"missing"]);
    CHECK(![report containsString:privateValue]);
    CHECK([Line(CSCFCallDiagnosticsReport(privateValue,capabilities,firstEpoch),@"plugin") isEqual:@"unknown"]);

    // Restarting discards the old session. The event list is a bounded ring,
    // while counters retain totals for all accepted events in this session.
    CSCFCallDiagnosticsStartRecording(firstEpoch);
    report=CSCFCallDiagnosticsReport(version,@{},firstEpoch);
    CHECK([Line(report,@"mono.two") isEqual:@"0"] && Recent(report).count==0);
    for(NSUInteger i=0;i<5;i++)CSCFCallDiagnosticsRecord(@"mono.two",firstEpoch);
    for(NSUInteger i=0;i<80;i++)CSCFCallDiagnosticsRecord(@"un.enter",firstEpoch);
    report=CSCFCallDiagnosticsReport(version,@{},firstEpoch);
    CHECK([Line(report,@"keptEvents") isEqual:@"64/64"] && Recent(report).count==64);
    CHECK([Line(report,@"mono.two") isEqual:@"5"] && [Line(report,@"un.enter") isEqual:@"80"]);
    for(NSString *event in Recent(report))CHECK([event hasSuffix:@" un.enter"]);
    NSString *bodyBeforeStop=RecordingBody(report);
    CSCFCallDiagnosticsStopRecording();CHECK(!CSCFCallDiagnosticsIsRecording());
    CSCFCallDiagnosticsRecord(@"mono.two",firstEpoch);
    report=CSCFCallDiagnosticsReport(version,@{},firstEpoch);
    CHECK([Line(report,@"recording") isEqual:@"NO"]);
    CHECK([bodyBeforeStop isEqual:RecordingBody(report)]);

    // Any epoch boundary invalidates the retained trace, including a stopped
    // trace and an unknown event; no account identifier is ever exported.
    report=CSCFCallDiagnosticsReport(version,@{},secondEpoch);
    CHECK(!CSCFCallDiagnosticsIsRecording() && Recent(report).count==0);
    CHECK([Line(report,@"keptEvents") isEqual:@"0/64"] && [Line(report,@"un.enter") isEqual:@"0"]);
    CSCFCallDiagnosticsStartRecording(firstEpoch);CSCFCallDiagnosticsRecord(@"call.drop",firstEpoch);
    CSCFCallDiagnosticsRecord(@"not-an-allowed-event",secondEpoch);
    CHECK(!CSCFCallDiagnosticsIsRecording());
    report=CSCFCallDiagnosticsReport(version,@{},secondEpoch);
    CHECK(Recent(report).count==0 && [Line(report,@"call.drop") isEqual:@"0"]);
    CSCFCallDiagnosticsRecord(@"call.drop",secondEpoch);
    CHECK(Recent(CSCFCallDiagnosticsReport(version,@{},secondEpoch)).count==0);
    CSCFCallDiagnosticsStartRecording(firstEpoch);CSCFCallDiagnosticsRecord(@"call.pass",firstEpoch);
    report=CSCFCallDiagnosticsReport(version,@{},secondEpoch);
    CHECK(!CSCFCallDiagnosticsIsRecording() && Recent(report).count==0);
    CHECK([Line(report,@"call.pass") isEqual:@"0"]);
    CSCFCallDiagnosticsStartRecording(secondEpoch);CSCFCallDiagnosticsRecord(@"notification.response.local",secondEpoch);
    CSCFCallDiagnosticsStopRecording();report=CSCFCallDiagnosticsReport(version,@{},secondEpoch);
    CHECK(Recent(report).count==1 && [Line(report,@"notification.response.local") isEqual:@"1"]);
    CHECK(![report containsString:@"73120"]);
    printf("Close-friend call diagnostics: %lu focused checks passed (opt-in, allowlists, privacy, bounds, epochs, retained export)\n",(unsigned long)Checks);
} return 0; }
