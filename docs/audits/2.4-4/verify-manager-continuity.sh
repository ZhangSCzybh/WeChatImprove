#!/bin/bash
# 2.4-4 release audit only; reuses the existing manager harness and mock services.
set -euo pipefail
cd "$(dirname "$0")/../../.."
audit_tmp="$(mktemp -d "${TMPDIR:-/tmp}/wechat-244-manager.XXXXXX")"
trap 'rm -rf "$audit_tmp"' EXIT
cat > "$audit_tmp/manager.m" <<'OBJC'
#define main ExistingGroupManagerMain
#define CSGroupChatPostDepartureNotice ExistingGroupManagerPostDepartureNotice
#include "GroupChatManagerTests.m"
#undef CSGroupChatPostDepartureNotice
#undef main
#import "CSGroupChatTemplate.h"
#import <objc/runtime.h>

static NSDictionary *lastNotice;
static NSMutableArray<NSDictionary *> *outbound;
BOOL CSGroupChatPostDepartureNotice(NSString *owner,NSString *roomID,NSString *memberID,NSDate *date,NSString *eventID,NSString *format,NSDictionary<NSString *,NSString *> *values,BOOL (^stillAuthorized)(void)){
    lastNotice=@{@"room":roomID,@"member":memberID,@"text":CSGroupChatRenderTemplate(format,values)};
    return ExistingGroupManagerPostDepartureNotice(owner,roomID,memberID,date,eventID,format,values,stillAuthorized);
}
@interface CSMessageSendAdapter (GroupChatAudit)
- (CSMessagePreparedSend *)auditPrepareGroupText:(NSString *)text mentions:(NSArray *)mentions targetID:(NSString *)target accountID:(NSString *)owner;
@end
@implementation CSMessageSendAdapter (GroupChatAudit)
- (CSMessagePreparedSend *)auditPrepareGroupText:(NSString *)text mentions:(NSArray *)mentions targetID:(NSString *)target accountID:(NSString *)owner{
    [outbound addObject:@{@"room":target,@"account":owner,@"text":text,@"mentions":mentions}];
    return [self auditPrepareGroupText:text mentions:mentions targetID:target accountID:owner];
}
@end

static void Setup(BOOL send,BOOL welcome){
    outbound=[NSMutableArray array];
    Method normal=class_getInstanceMethod(CSMessageSendAdapter.class,@selector(prepareGroupText:mentions:targetID:accountID:));
    Method record=class_getInstanceMethod(CSMessageSendAdapter.class,@selector(auditPrepareGroupText:mentions:targetID:accountID:));
    method_exchangeImplementations(normal,record);
    deliverNativeSnapshots=YES;nativeJoinTimes=@{};
    roomData=[@{@"chatRoomVersion":@1,@"joinTime":@0} mutableCopy];
    liveMembers=[NSSet setWithArray:@[@"alice",@"old"]];
    NSMutableDictionary *config=[CSGroupChatDefaultConfiguration() mutableCopy];
    [config addEntriesFromDictionary:@{@"welcomeEnabled":@(welcome),@"welcomeRooms":@[room],@"welcomeTemplate":@"欢迎@昵称 / @备注",
        @"monitorEnabled":@YES,@"monitorRooms":@[room],@"departureTemplate":@"本地：@昵称 @离群类型",
        @"departureSendToRoom":@(send),@"departureRoomTemplate":@"@昵称 / @备注\n@群昵称：@离群类型 (@群人数)"}];
    storedState=@{@"schema":@1,@"account":account,@"configuration":[config copy]};
    responseManager=[CSGroupChatManager new];[responseManager start];
    Wait(^BOOL{return [[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] isEqual:@1];},@"fixture obtains initial authoritative baseline");
}

static void TestDeparture(BOOL send){
    Setup(send,NO);
    NSMutableDictionary *enriched=[Snapshot(@[@"alice",@"old"],1,nil) mutableCopy];
    enriched[@"names"]=@{@"old":@"微信昵称🐦"};enriched[@"remarks"]=@{@"old":@"群备注&<>"};
    [responseManager receiveMemberSnapshot:enriched epoch:epoch];
    if(send){
        [responseManager nativeMemberRemovals:@[@"old"] inRoom:room epoch:epoch-1];
        Check(![[responseManager valueForKey:@"confirmedRemovals"][room] count],@"expired epoch cannot mark an administrator removal");
        [responseManager nativeMemberRemovals:@[@"old"] inRoom:room epoch:epoch];
        Check(notices==0 && outbound.count==0,@"native removal response is only evidence until a full roster verifies absence");
    }
    Receive(responseManager,@[@"alice"],2);
    Check(notices==1 && [lastNotice[@"room"] isEqual:room] && [lastNotice[@"member"] isEqual:@"old"],@"one local notice is still posted for the source room");
    Check([lastNotice[@"text"] isEqual:send?@"本地：微信昵称🐦 被移出":@"本地：微信昵称🐦 离群（原因未确认）"],@"only confirmed native evidence labels the departure as an administrator removal");
    if(send){
        Check(submissions==1 && outbound.count==1,@"opt-in submits one additional group message");
        NSDictionary *message=outbound.firstObject;
        Check([message[@"room"] isEqual:room] && [message[@"account"] isEqual:account],@"additional message targets exactly the room and account for this departure");
        Check([message[@"mentions"] count]==0,@"departed member is not mentioned in the group message");
        Check([message[@"text"] isEqual:@"微信昵称🐦 / 群备注&<>\nFixture group：被移出 (1)"],@"independent multiline template preserves special characters and resolved values");
    }else Check(submissions==0 && outbound.count==0,@"opt-out does not prepare a group send");
    Receive(responseManager,@[@"alice"],2);
    Check(notices==1 && submissions==(send?1u:0u),@"duplicate snapshot repeats neither route");
}

static void TestContinuity(void){
    Setup(NO,YES);
    Receive(responseManager,@[@"alice",@"old",@"second"],2);
    Check([[responseManager valueForKey:@"pendingWelcomes"] count]==1,@"pre-background confirmed join has a welcome awaiting handoff");
    NSMutableDictionary *baselines=[responseManager valueForKey:@"baselines"];
    NSMutableDictionary *old=[baselines[room] mutableCopy];old[@"observedAt"]=[NSDate.date dateByAddingTimeInterval:-300];baselines[room]=old;
    Background();
    Receive(responseManager,@[@"alice",@"second",@"new"],3);
    Pump(0.03);
    Check(submissions==0 && notices==0,@"no simulated messages while app is backgrounded");
    // Native sync initially returns the unchanged authoritative version 2.
    liveMembers=[NSSet setWithArray:@[@"alice",@"old",@"second"]];roomData[@"chatRoomVersion"]=@2;
    ActivateOnly();
    Wait(^BOOL{return [baselines[room][@"version"] isEqual:@2] && submissions==1;},@"resume requests a full roster and restores the one eligible unsent welcome");
    Check(notices==0 && [outbound.firstObject[@"mentions"] isEqual:@[@"second"]],@"same-version response proves existing pending member without inventing a departure");
    // Version 3 arrives after initial sync. This join's server age exceeds
    // foreground freshness, but its timestamp follows the retained roster.
    nativeJoinTimes=@{@"new":@((unsigned long long)NSDate.date.timeIntervalSince1970-200)};
    Receive(responseManager,@[@"alice",@"second",@"new"],3);
    Wait(^BOOL{return submissions==2 && notices==1;},@"newer verified version reconciles join and departure after foreground");
    Check([outbound.lastObject[@"mentions"] isEqual:@[@"new"]] && [lastNotice[@"member"] isEqual:@"old"],@"join and departure use the verified identities");
    Receive(responseManager,@[@"alice",@"second",@"new"],3);ActivateOnly();Pump(0.03);
    Check(submissions==2 && notices==1,@"repeat version and active notification cannot duplicate catch-up messages");
}

int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;
    NSString *scenario=@(argv[1]);
    if([scenario isEqual:@"off"])TestDeparture(NO);
    else if([scenario isEqual:@"on"])TestDeparture(YES);
    else if([scenario isEqual:@"continuity"])TestContinuity();
    else return 2;
    printf("2.4-4 manager audit %s: %u checks passed\n",scenario.UTF8String,checks);return 0;
}}
OBJC
python3 - "$audit_tmp/manager.m" <<'PY'
import os
from pathlib import Path
import subprocess
import sys
harness = Path("Tests/verify-group-chat-manager.sh").resolve()
script = harness.read_text()
source = 'Tests/GroupChatManagerTests.m -o'
invoke = '"$test_dir/tests" "$@"'
if script.count(source) != 1 or script.count(invoke) != 1:
    raise SystemExit("Existing manager harness layout changed")
script = script.replace(source, '-ITests "$CS_MANAGER_AUDIT_SOURCE" -o')
script = script.replace(invoke, 'for scenario in off on continuity; do "$test_dir/tests" "$scenario"; done')
env = dict(os.environ, CS_MANAGER_AUDIT_SOURCE=sys.argv[1])
subprocess.run(["bash", "-c", script, str(harness)], env=env, check=True, timeout=12)
PY
