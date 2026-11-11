#!/bin/bash
# Release audit only: use the existing manager harness and recording native-service fixtures.
set -euo pipefail
cd "$(dirname "$0")/../../.."
audit_tmp="$(mktemp -d "${TMPDIR:-/tmp}/wechat-246-manager.XXXXXX")"
trap 'rm -rf "$audit_tmp"' EXIT
cat > "$audit_tmp/manager.m" <<'OBJC'
#define main ExistingGroupManagerMain
#define CSGroupChatPostDepartureNotice ExistingGroupManagerPostDepartureNotice
#include "GroupChatManagerTests.m"
#undef CSGroupChatPostDepartureNotice
#undef main
#import "CSBackgroundRunManager.h"
#import "CSGroupChatTemplate.h"
#import <objc/runtime.h>

// The second audit links the real background manager and tests its one lease.
// Here a controllable opportunity lets the native-send fixture expire at the
// exact point between preparation and handoff.
@interface CSBackgroundRunManager ()
@property(nonatomic, readwrite) BOOL enabled;
@property(nonatomic) BOOL auditOpportunity;
@end
@implementation CSBackgroundRunManager
+ (instancetype)sharedManager {
    static CSBackgroundRunManager *manager;
    if(!manager)manager=[self new];
    return manager;
}
- (BOOL)canAttemptBackgroundWork { return self.enabled && self.auditOpportunity; }
@end

static BOOL requested;
static NSUInteger requestsMade;
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
static void Setup(BOOL globalEnabled,NSNumber *legacy,BOOL monitor){
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
    if(legacy)config[@"backgroundRealtimeEnabled"]=legacy;
    storedState=@{@"schema":@1,@"account":account,@"configuration":[config copy]};
    CSBackgroundRunManager.sharedManager.enabled=globalEnabled;
    responseManager=[CSGroupChatManager new];
    [responseManager configureBackgroundDemand:^(BOOL on){requested=on;if(on)requestsMade++;}
        canWork:^BOOL{return CSBackgroundRunManager.sharedManager.auditOpportunity;}];
    [responseManager start];
    Wait(^BOOL{return [Version() isEqual:@1];},@"foreground establishes authoritative full list v1");
    Check(requested==globalEnabled,@"configured groups follow the plugin setting regardless of the legacy value");
    // Existing scenarios separately exercise cooldown timing. Simulate that
    // the initial foreground baseline was already obtained six seconds ago.
    [responseManager valueForKey:@"requests"][room]=[NSDate.date dateByAddingTimeInterval:-6];
}
static void SetCapability(BOOL available){
    CSBackgroundRunManager.sharedManager.auditOpportunity=available;
    [responseManager backgroundCapabilityChanged];
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
static void Realtime(NSNumber *legacy){
    Setup(YES,legacy,YES);
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
static void GlobalOff(NSNumber *legacy){
    Setup(NO,legacy,YES);
    NSUInteger before=requests;
    Background();
    SetCapability(YES);
    ObserveNativeTransition(@[@"alice",@"new"],@[@"old"]);
    Pump(0.03);
    Check(!requested && !requestsMade && !runtimeEnabled && requests==before,@"global off prevents both ingress and background requests even with an obsolete opt-in");
    Check(!notices && !submitAttempts,@"global off cannot insert or send in background");
    SetCapability(NO);
    ActivateOnly();
    Wait(^BOOL{return [Version() isEqual:@2] && submissions==2 && notices==1;},@"full list after foreground catches up the missed net change");
    CheckOutputs(UIApplicationStateActive);
}
static void BudgetLost(void){
    Setup(YES,nil,NO);
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
    Setup(YES,nil,YES);
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
    if([scenario isEqual:@"global-on-no-key"])Realtime(nil);
    else if([scenario isEqual:@"global-on-legacy-off"])Realtime(@NO);
    else if([scenario isEqual:@"global-off-no-key"])GlobalOff(nil);
    else if([scenario isEqual:@"global-off-legacy-on"])GlobalOff(@YES);
    else if([scenario isEqual:@"budget-lost"])BudgetLost();
    else if([scenario isEqual:@"departure-budget-lost"])DepartureBudgetLost();
    else if([scenario isEqual:@"variables"])Variables();
    else return 2;
    printf("2.4-6 group audit %s: %u checks passed\n",scenario.UTF8String,checks);return 0;
}}
OBJC
cat > "$audit_tmp/backup.m" <<'OBJC'
#define main ExistingGroupBackupMain
#include "GroupChatBackupTests.m"
#undef main

static NSDictionary *ReadRawState(NSURL *file){
    NSData *data=[NSData dataWithContentsOfURL:file];
    return data?[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL]:nil;
}
int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;
    NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    NSString *suite=[@"group.backup.realtime.audit." stringByAppendingString:NSUUID.UUID.UUIDString];
    CSBackupEngine *engine=Engine(root,suite);
    NSURL *file=CSGroupChatFileURL(engine.resourceRoot,@"alice");
    NSString *key=@"backgroundRealtimeEnabled";
    NSError *error=nil;
    Check(!CSGroupChatDefaultConfiguration()[key],@"new account configuration has no retired switch");
    NSMutableDictionary *expected=[State(@"alice",@"旧欢迎 @昵称 @备注 @微信ID") mutableCopy];
    NSMutableDictionary *config=[expected[@"configuration"] mutableCopy];
    [config addEntriesFromDictionary:@{@"departureSendToRoom":@YES,@"departureRoomTemplate":@"原本群模板 @备注 @微信ID",@"departureTemplate":@"原本地模板 @微信ID"}];
    expected[@"configuration"]=[config copy];
    Check(CSGroupChatWriteState(expected,file,@"alice",&error) && [CSGroupChatReadState(file,@"alice",&error) isEqual:expected],@"actual account store round-trips settings without a retired key");
    NSDictionary *entry=[CSBackupRegistry entryForDomain:CSGroupChatBackupDomain key:@"alice"];
    NSMutableDictionary *legacy=[expected mutableCopy];
    for(id value in @[@YES,@NO,@"stale value",@2,@{@"old":@YES}]){
        config[key]=value;legacy[@"configuration"]=[config copy];
        NSData *raw=[NSPropertyListSerialization dataWithPropertyList:legacy format:NSPropertyListBinaryFormat_v1_0 options:0 error:&error];
        Check([raw writeToURL:file options:NSDataWritingAtomic error:&error],@"simulate pre-upgrade file bytes with retired key");
        Check(CSGroupChatValidateConfiguration(config) && [CSBackupRegistry validateValue:legacy entry:entry error:&error],@"retired value is ignored during local and backup validation");
        Check([CSGroupChatReadState(file,@"alice",&error) isEqual:legacy] && !error,@"Store validates and reads legacy data for the original account without interpreting the retired value");
        Check([[NSData dataWithContentsOfURL:file] isEqual:raw],@"opening old settings does not rewrite disk");
    }
    NSDictionary *backup=[engine save:@"旧群聊设置" error:&error];
    Check([Field(backup)[@"value"] isEqual:legacy] && [backup[@"source"][@"account"] isEqual:@"alice"],@"a backup of untouched old settings captures the exact opaque state and account");
    NSDictionary *portable=[CSBackupCodec decode:[CSBackupCodec encode:backup error:&error] error:&error];
    Check([Field(portable)[@"value"] isEqual:legacy],@"a portable old backup with a legacy value still decodes");
    NSDictionary *changed=State(@"alice",@"编辑后的本地配置");
    Check(CSGroupChatWriteState(changed,file,@"alice",&error),@"change active settings before trying a legacy restore");
    NSDictionary *preview=[engine preview:portable modules:[NSSet setWithObject:@"group_chat_tools"] accounts:[NSSet setWithObject:@"alice"] error:&error];
    Check([preview[@"changes"] count]==1 && [preview[@"fields"][0][@"key"] isEqual:@"alice"],error.description?:@"preview shows an account-scoped restore");
    Check([CSGroupChatReadState(file,@"alice",&error) isEqual:changed],@"preview does not change the file");
    Check([engine prepare:preview error:&error],error.description?:@"prepare legacy group restore");Complete(engine);
    Check([ReadRawState(file) isEqual:legacy] && [CSGroupChatReadState(file,@"alice",&error) isEqual:legacy],@"explicit historical backup replay preserves the exact state for the engine's restore verification");
    Check(CSGroupChatWriteState(expected,file,@"alice",&error) && [ReadRawState(file) isEqual:expected],@"writing a normalized state omits the retired key on disk");
    NSDictionary *newBackup=[engine save:@"新版群聊设置" error:&error];
    Check([Field(newBackup)[@"value"] isEqual:expected],@"after settings are rewritten without the key, subsequent backups do not recreate it");
    config[@"otherUnexpectedKey"]=@YES;legacy[@"configuration"]=[config copy];
    Check(!CSGroupChatValidateConfiguration(config) && ![CSBackupRegistry validateValue:legacy entry:entry error:&error],@"unknown keys other than the retired switch still fail validation");
    Check(!CSGroupChatWriteState(legacy,file,@"alice",&error) && [ReadRawState(file) isEqual:expected],@"invalid unrelated input cannot overwrite saved settings");
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:suite];
    printf("2.4-6 group audit settings-and-backup: %u checks passed\n",checks);return 0;
}}
OBJC
python3 - "$audit_tmp" <<'PY'
import os
from pathlib import Path
import re
import subprocess
import sys

audit_dir = Path(sys.argv[1])

def check_settings_layout():
    source = Path('Controllers/CSGroupChatSettingsViewController.m').read_text().split('@implementation CSGroupChatSettingsViewController', 1)[1]
    sections = source.split('self.sections=@[', 1)[1].split('[self.tableView reloadData]', 1)[0]
    assert re.findall(r'sectionWithHeader:@"([^"]+)"', sections) == ['入群欢迎', '退群监控', '自动添加通讯录', '批量退群']
    assert '后台实时运行' not in source and 'backgroundRealtimeEnabled' not in source
    footer = source.split('titleForFooterInSection:', 1)[1].split('cellForRowAtIndexPath:', 1)[0]
    assert re.findall(r'if \(section==(\d+)\)', footer) == ['0', '1', '2', '3']
    assert all(text in footer.split('if (section==1)', 1)[1].split('if (section==2)', 1)[0] for text in (
        '通知仅自己可见', '通知发送本群', '插件设置 → 后台运行', '后台执行机会', '可能增加耗电', '锁屏时受系统和微信连接限制', '回到前台会核对名单'))
    assert '第一次取得名单时不欢迎已有成员' in footer.split('if (section==0)', 1)[1].split('if (section==1)', 1)[0]
    assert '开启前已有群不补存' in footer.split('if (section==2)', 1)[1].split('if (section==3)', 1)[0]
    assert '默认保留聊天记录' in footer.split('if (section==3)', 1)[1]
    gates = source.split('- (BOOL)rowEnabled:', 1)[1].split('- (NSInteger)numberOfSectionsInTableView:', 1)[0]
    assert 'path.section==0 && path.row>0' in gates and 'welcomeEnabled' in gates
    assert 'path.section==1 && path.row>0' in gates and 'monitorEnabled' in gates and 'path.row!=4 || [manager.configuration[@"departureSendToRoom"] boolValue]' in gates
    assert 'path.section==3 && path.row<2' in gates and 'self.quitRooms.count>0' in gates
    assert 'path.section==3 && path.row==1' in source and '[self rowEnabled:path]' in source
    print('2.4-6 settings source: 4 headers and matching footers, welcome/monitor/quit row gating, and no independent toggle', flush=True)

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

check_settings_layout()
run_fixture("verify-group-chat-manager.sh", "Tests/GroupChatManagerTests.m", "manager.m", '"$test_dir/tests" "$@"',
    'for scenario in variables global-on-no-key global-on-legacy-off global-off-no-key global-off-legacy-on budget-lost departure-budget-lost; do "$test_dir/tests" "$scenario"; done')
run_fixture("verify-group-chat-backup.sh", "Tests/GroupChatBackupTests.m", "backup.m", '\n"$test_dir/tests"\n',
    '\n"$test_dir/tests" "$CS_GROUP_AUDIT_DIR/account-fixture"\n')
PY
