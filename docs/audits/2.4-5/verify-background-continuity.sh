#!/bin/bash
# Release audit only: use the existing manager harness and recording native-service fixtures.
set -euo pipefail
cd "$(dirname "$0")/../../.."
audit_tmp="$(mktemp -d "${TMPDIR:-/tmp}/wechat-245-manager.XXXXXX")"
trap 'rm -rf "$audit_tmp"' EXIT
cat > "$audit_tmp/manager.m" <<'OBJC'
#define main ExistingGroupManagerMain
#define CSGroupChatPostDepartureNotice ExistingGroupManagerPostDepartureNotice
#include "GroupChatManagerTests.m"
#undef CSGroupChatPostDepartureNotice
#undef main
#import "CSGroupChatTemplate.h"
#import <objc/runtime.h>

static BOOL requested,capability;
static NSMutableArray<NSDictionary *> *outbound,*local;

BOOL CSGroupChatPostDepartureNotice(NSString *owner,NSString *roomID,NSString *memberID,NSDate *date,NSString *eventID,NSString *format,NSDictionary<NSString *,NSString *> *values,BOOL (^stillAuthorized)(void)){
    BOOL posted=ExistingGroupManagerPostDepartureNotice(owner,roomID,memberID,date,eventID,format,values,stillAuthorized);
    if(posted)[local addObject:@{@"room":roomID,@"member":memberID,@"text":CSGroupChatRenderTemplate(format,values),
        @"state":@(UIApplication.sharedApplication.applicationState)}];
    return posted;
}
@interface CSMessageSendAdapter (GroupChatReleaseAudit)
- (CSMessagePreparedSend *)auditPrepareGroupText:(NSString *)text mentions:(NSArray *)mentions targetID:(NSString *)target accountID:(NSString *)owner;
@end
@implementation CSMessageSendAdapter (GroupChatReleaseAudit)
- (CSMessagePreparedSend *)auditPrepareGroupText:(NSString *)text mentions:(NSArray *)mentions targetID:(NSString *)target accountID:(NSString *)owner{
    [outbound addObject:@{@"room":target,@"account":owner,@"text":text,@"mentions":mentions,
        @"state":@(UIApplication.sharedApplication.applicationState)}];
    return [self auditPrepareGroupText:text mentions:mentions targetID:target accountID:owner];
}
@end

static NSNumber *Version(void){return [responseManager valueForKey:@"baselines"][room][@"version"];}
static void Setup(NSNumber *enabled,BOOL monitor){
    outbound=[NSMutableArray array];local=[NSMutableArray array];
    Method normal=class_getInstanceMethod(CSMessageSendAdapter.class,@selector(prepareGroupText:mentions:targetID:accountID:));
    Method record=class_getInstanceMethod(CSMessageSendAdapter.class,@selector(auditPrepareGroupText:mentions:targetID:accountID:));
    method_exchangeImplementations(normal,record);
    deliverNativeSnapshots=YES;nativeJoinTimes=@{};
    roomData=[@{@"chatRoomVersion":@1,@"joinTime":@0} mutableCopy];
    liveMembers=[NSSet setWithArray:@[@"alice",@"old"]];
    NSMutableDictionary *config=[CSGroupChatDefaultConfiguration() mutableCopy];
    [config addEntriesFromDictionary:@{@"welcomeEnabled":@YES,@"welcomeRooms":@[room],@"welcomeTemplate":@"欢迎@昵称（@微信ID）",
        @"monitorEnabled":@(monitor),@"monitorRooms":@[room],@"departureTemplate":@"本地 @昵称 @微信ID @离群类型",
        @"departureSendToRoom":@(monitor),@"departureRoomTemplate":@"群通知 @微信ID @离群类型"}];
    if(enabled)config[@"backgroundRealtimeEnabled"]=enabled;
    storedState=@{@"schema":@1,@"account":account,@"configuration":[config copy]};
    responseManager=[CSGroupChatManager new];
    [responseManager configureBackgroundDemand:^(BOOL on){requested=on;} canWork:^BOOL{return capability;}];
    [responseManager start];
    Wait(^BOOL{return [Version() isEqual:@1];},@"foreground establishes authoritative full list v1");
    Check(requested==enabled.boolValue,@"only explicit opt-in requests background execution");
    // Existing scenarios separately exercise cooldown timing. Simulate that
    // the initial foreground baseline was already obtained six seconds ago.
    [responseManager valueForKey:@"requests"][room]=[NSDate.date dateByAddingTimeInterval:-6];
}
static void SetCapability(BOOL available){
    capability=available;[responseManager backgroundCapabilityChanged];
}
static void ObserveNativeTransition(NSArray *members,NSArray *removed){
    // Let the real manager take the native-hint path without waiting out the
    // separately tested five-second cooldown. The fake server updates only
    // when the fixture's full-list request returns.
    NSMutableDictionary *lastRequests=[responseManager valueForKey:@"requests"];
    lastRequests[room]=[NSDate.date dateByAddingTimeInterval:-6];
    serverMembers=[NSSet setWithArray:members];serverVersion=@2;
    if(removed.count)[responseManager nativeMemberRemovals:removed inRoom:room epoch:epoch];
    else [responseManager nativeSystemMessageInRoom:room epoch:epoch];
}
static void CheckOutputs(UIApplicationState state){
    Check(submissions==2 && submitAttempts==2 && notices==1,@"one welcome, one remote departure submission and one local notice");
    Check(outbound.count==2 && local.count==1,@"only expected send preparations and local insertion are recorded");
    NSDictionary *welcome=nil,*departure=nil;
    for(NSDictionary *message in outbound){
        Check([message[@"room"] isEqual:room] && [message[@"account"] isEqual:account] && [message[@"state"] isEqual:@(state)],@"outbound uses exact room, account and expected application state");
        if([message[@"mentions"] count])welcome=message;else departure=message;
    }
    Check([welcome[@"mentions"] isEqual:@[@"new"]] && [welcome[@"text"] isEqual:@"欢迎@New\u2005（new）"],@"welcome uses actual member mention plus plain WeChat ID");
    NSString *reason=state==UIApplicationStateBackground?@"被移出":@"离群（原因未确认）";
    Check([departure[@"text"] isEqual:[@"群通知 old " stringByAppendingString:reason]],@"departure sends the native member ID and confirmed reason only when known");
    Check([local.firstObject[@"text"] isEqual:[@"本地 Old old " stringByAppendingString:reason]] && [local.firstObject[@"state"] isEqual:@(state)],@"local notice renders the same native member identity at insertion");
}
static void Realtime(void){
    Setup(@YES,YES);
    Background();
    SetCapability(YES);
    Wait(^BOOL{return runtimeEnabled && acceptedResponses>=2;},@"background opportunity reopens ingress and requests one authoritative list");
    NSUInteger before=requests;
    ObserveNativeTransition(@[@"alice",@"new"],@[@"old"]);
    Check(requests==before+1 && notices==0 && submissions==0,@"native administrator removal is only evidence until the full list arrives");
    Wait(^BOOL{return [Version() isEqual:@2] && submissions==2 && notices==1;},@"native roster drives welcome, room departure and local notice before foreground");
    CheckOutputs(UIApplicationStateBackground);
    Receive(responseManager,@[@"alice",@"new"],2);
    Pump(0.03);
    Check(submissions==2 && notices==1,@"same version is idempotent while backgrounded");
    before=requests;
    ActivateOnly();
    SetCapability(NO);
    Wait(^BOOL{return requests>before && [Version() isEqual:@2];},@"foreground requests a full roster against the latest background version");
    Pump(0.03);
    Check(submissions==2 && notices==1,@"foreground verification does not repeat successfully processed background changes");
}
static void OptOut(NSNumber *setting){
    Setup(setting,YES);
    NSUInteger before=requests;
    Background();
    SetCapability(YES);
    ObserveNativeTransition(@[@"alice",@"new"],@[@"old"]);
    Pump(0.03);
    Check(!requested && !runtimeEnabled && requests==before,@"disabled or missing setting prevents both ingress and background requests");
    Check(!notices && !submitAttempts,@"disabled or missing setting cannot insert or send in background");
    SetCapability(NO);
    ActivateOnly();
    Wait(^BOOL{return [Version() isEqual:@2] && submissions==2 && notices==1;},@"full list after foreground catches up the missed net change");
    CheckOutputs(UIApplicationStateActive);
}
static void BudgetLost(void){
    Setup(@YES,NO);
    Background();
    SetCapability(YES);
    Wait(^BOOL{return runtimeEnabled && acceptedResponses>=2;},@"capability allows native background query before simulated expiration");
    onPrepareSend=^{SetCapability(NO);};
    ObserveNativeTransition(@[@"alice",@"old",@"new"],nil);
    Wait(^BOOL{return outbound.count==1 && !runtimeEnabled;},@"fake execution budget expires after preparing the welcome");
    onPrepareSend=nil;
    Check(!submissions && !notices,@"no native handoff is possible after background capability expires");
    ActivateOnly();
    Wait(^BOOL{return [Version() isEqual:@2] && submissions==1;},@"foreground full-list revalidation restores the still-pending welcome");
    Check(outbound.count==2 && [outbound.lastObject[@"mentions"] isEqual:@[@"new"]] && [outbound.lastObject[@"state"] isEqual:@(UIApplicationStateActive)],@"recovered welcome targets the same member from foreground");
    Receive(responseManager,@[@"alice",@"old",@"new"],2);
    Pump(0.03);
    Check(submissions==1,@"the revalidated welcome is never replayed");
}
static void DepartureBudgetLost(void){
    Setup(@YES,YES);
    Background();
    SetCapability(YES);
    Wait(^BOOL{return runtimeEnabled && acceptedResponses>=2;},@"native full-list ingress is available before departure");
    onPrepareSend=^{SetCapability(NO);};
    ObserveNativeTransition(@[@"alice"],@[@"old"]);
    Wait(^BOOL{return outbound.count==1 && !runtimeEnabled;},@"background opportunity ends before group departure handoff");
    onPrepareSend=nil;
    Check(notices==1 && !submissions && [local.firstObject[@"state"] isEqual:@(UIApplicationStateBackground)],@"local departure was posted before expiration; remote route has no completed handoff");
    ActivateOnly();
    Wait(^BOOL{return [Version() isEqual:@2] && submissions==1;},@"foreground list revalidation submits only the unstarted remote route");
    Check(outbound.count==2 && notices==1 && [outbound.lastObject[@"text"] isEqual:@"群通知 old 被移出"],@"retained departure reason survives without reposting the local notice");
    Receive(responseManager,@[@"alice"],2);
    Pump(0.03);
    Check(submissions==1 && notices==1,@"repeat snapshot cannot resubmit either departure route");
}
static void Variables(void){
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:0];
    NSDictionary *welcome=CSGroupChatWelcomeTextWithRemarks(@"@昵称 | @备注 | @微信ID",@[@"id_1",@"@时间",@"(null)"],@{@"id_1":@"@微信ID",@"@时间":@"二"},@{@"id_1":@"@群人数",@"@时间":@"二哥"},@"群",5,date);
    Check([welcome[@"text"] isEqual:@"@@微信ID\u2005 @二\u2005 @(null)\u2005 | @群人数、二哥 | id_1、@时间"],@"new ID list shares remark separator and substituted names, remarks and IDs are not rescanned");
    NSDictionary *idOnly=CSGroupChatWelcomeText(@"（@微信ID）",@[@"id_1"],@{},@"群",5,date);
    Check([idOnly[@"text"] isEqual:@"（id_1）"] && ![idOnly[@"mentions"] count],@"nonempty ID retains parentheses without creating an @ mention");
    NSDictionary *missingWelcome=CSGroupChatWelcomeText(@"欢迎(@微信ID)来到群聊",@[@"null",@"(null)"],@{},@"群",5,date);
    Check([missingWelcome[@"text"] isEqual:@"欢迎来到群聊"],@"missing welcome IDs leave no null marker or empty parentheses");
    NSDictionary *missingDeparture=CSGroupChatDepartureValues(@" (null) ",@"旧成员",@"旧备注",@"群",4,date,@"被移出");
    Check([CSGroupChatRenderTemplate(@"离群（ @微信ID ） (@微信ID) @微信ID @昵称",missingDeparture) isEqual:@"离群   旧成员"],@"missing departure ID clears grouped and bare tokens without changing the nickname");
    Check([CSGroupChatRenderTemplate(@"前（(@微信ID @微信ID)　\n@微信ID）后",missingDeparture) isEqual:@"前后"],@"nested fullwidth and ASCII pairs containing multiple missing IDs are removed");
    Check([CSGroupChatRenderTemplate(@"@微(@微信ID)信ID / @备（@微信ID）注 / @昵称",missingDeparture) isEqual:@"@微信ID / @备注 / 旧成员"],@"removing source punctuation cannot create a token for a second replacement");
    Check([CSGroupChatRenderTemplate(@"（ID：@微信ID） 原有（）",missingDeparture) isEqual:@"（ID：） 原有（）"],@"source parentheses containing literal labels and unrelated empty pairs are preserved");
    NSDictionary *literal=CSGroupChatDepartureValues(@"@备注",@"@时间",@"@微信ID",@"群",4,date,@"被移出");
    Check([CSGroupChatRenderTemplate(@"@昵称 @备注 (@微信ID)",literal) isEqual:@"@时间 @微信ID (@备注)"],@"one pass is preserved for departure values");
    Check([CSGroupChatRenderTemplate(@"旧模板（）(@备注) @群人数",missingDeparture) isEqual:@"旧模板（）(旧备注) 4"],@"old template punctuation and substitutions are byte-for-byte unchanged");
}
int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;
    NSString *scenario=@(argv[1]);
    if([scenario isEqual:@"realtime"])Realtime();
    else if([scenario isEqual:@"opt-out"])OptOut(@NO);
    else if([scenario isEqual:@"missing-key"])OptOut(nil);
    else if([scenario isEqual:@"budget-lost"])BudgetLost();
    else if([scenario isEqual:@"departure-budget-lost"])DepartureBudgetLost();
    else if([scenario isEqual:@"variables"])Variables();
    else return 2;
    printf("2.4-5 group audit %s: %u checks passed\n",scenario.UTF8String,checks);return 0;
}}
OBJC
cat > "$audit_tmp/backup.m" <<'OBJC'
#define main ExistingGroupBackupMain
#include "GroupChatBackupTests.m"
#undef main

int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;
    NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    NSString *suite=[@"group.backup.realtime.audit." stringByAppendingString:NSUUID.UUID.UUIDString];
    CSBackupEngine *engine=Engine(root,suite);
    NSURL *file=CSGroupChatFileURL(engine.resourceRoot,@"alice");
    NSString *key=@"backgroundRealtimeEnabled";
    NSError *error=nil;
    Check([CSGroupChatDefaultConfiguration()[key] isEqual:@NO],@"new installations default the real-time switch to off");
    NSMutableDictionary *legacy=[State(@"alice",@"旧模板 @昵称") mutableCopy];
    NSMutableDictionary *config=[legacy[@"configuration"] mutableCopy];
    [config removeObjectForKey:key];legacy[@"configuration"]=[config copy];
    Check(CSGroupChatWriteState(legacy,file,@"alice",&error) && [CSGroupChatReadState(file,@"alice",&error) isEqual:legacy],@"actual account store accepts and preserves a configuration with no new key");
    NSMutableDictionary *enabled=[legacy mutableCopy];config[key]=@YES;enabled[@"configuration"]=[config copy];
    Check(CSGroupChatWriteState(enabled,file,@"alice",&error) && [CSGroupChatReadState(file,@"alice",&error) isEqual:enabled],@"actual account store round-trips the enabled switch");
    NSDictionary *backup=[engine save:@"后台实时开关" error:&error];
    Check([Field(backup)[@"value"][@"configuration"][key] isEqual:@YES],@"backup captures the enabled setting for its original account");
    backup=[CSBackupCodec decode:[CSBackupCodec encode:backup error:&error] error:&error];
    Check([Field(backup)[@"value"] isEqual:enabled],@"portable backup retains the exact configuration");
    Check(CSGroupChatWriteState(legacy,file,@"alice",&error),@"simulate the pre-upgrade account settings again before preview");
    NSDictionary *preview=[engine preview:backup modules:[NSSet setWithObject:@"group_chat_tools"] accounts:[NSSet setWithObject:@"alice"] error:&error];
    Check([preview[@"changes"] count]==1 && [preview[@"fields"][0][@"value"][@"configuration"][key] isEqual:@YES],@"backup preview exposes the saved enabled switch as an account-scoped change");
    Check([CSGroupChatReadState(file,@"alice",&error) isEqual:legacy],@"preview does not change the file");
    Check([engine prepare:preview error:&error],error.description?:@"prepare enabled switch restore");
    Complete(engine);
    Check([CSGroupChatReadState(file,@"alice",&error) isEqual:enabled],@"actual restore applies the enabled value and preserves the existing template");
    NSMutableDictionary *invalid=[enabled mutableCopy];config[key]=@"YES";invalid[@"configuration"]=[config copy];
    Check(!CSGroupChatValidateConfiguration(config) &&
        ![CSBackupRegistry validateValue:invalid entry:[CSBackupRegistry entryForDomain:CSGroupChatBackupDomain key:@"alice"] error:&error],
        @"configuration and backup validation reject a non-boolean setting");
    config[key]=@2;invalid[@"configuration"]=[config copy];
    Check(!CSGroupChatWriteState(invalid,file,@"alice",&error) && [CSGroupChatReadState(file,@"alice",&error) isEqual:enabled],@"an invalid numeric switch cannot overwrite the previously saved setting");
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:suite];
    printf("2.4-5 group audit settings-and-backup: %u checks passed\n",checks);return 0;
}}
OBJC
python3 - "$audit_tmp" <<'PY'
import os
from pathlib import Path
import subprocess
import sys

audit_dir = Path(sys.argv[1])

def run_fixture(script_name, existing_source, audit_source, invocation, replacement):
    harness = Path("Tests", script_name).resolve()
    script = harness.read_text()
    source = existing_source + " -o"
    if script.count(source) != 1 or script.count(invocation) != 1:
        raise SystemExit(f"Existing harness layout changed: {script_name}")
    script = script.replace(source, '-ITests "$CS_GROUP_AUDIT_SOURCE" -o').replace(invocation, replacement)
    env = dict(os.environ, CS_GROUP_AUDIT_SOURCE=str(audit_dir / audit_source), CS_GROUP_AUDIT_DIR=str(audit_dir))
    status = subprocess.run(["bash", "-c", script, str(harness)], env=env, timeout=25).returncode
    if status:
        raise SystemExit(status)

run_fixture("verify-group-chat-manager.sh", "Tests/GroupChatManagerTests.m", "manager.m", '"$test_dir/tests" "$@"',
    'for scenario in variables realtime opt-out missing-key budget-lost departure-budget-lost; do "$test_dir/tests" "$scenario"; done')
run_fixture("verify-group-chat-backup.sh", "Tests/GroupChatBackupTests.m", "backup.m", '\n"$test_dir/tests"\n',
    '\n"$test_dir/tests" "$CS_GROUP_AUDIT_DIR/account-fixture"\n')
PY
