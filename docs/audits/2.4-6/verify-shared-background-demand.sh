#!/bin/bash
# Release audit only: link both production managers with the existing fake UIKit
# and runtime, using the actual hook's demand and state-notification bridge.
set -euo pipefail
cd "$(dirname "$0")/../../.."
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-246-background-demand.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
from pathlib import Path
import re
import sys

out = Path(sys.argv[1])
script = Path('Tests/verify-background-run.sh').read_text()
generate = script.split("<<'PY'\n", 1)[1].split('\nPY\n', 1)[0]
sys.argv = [sys.argv[0], '.', str(out)]
exec(compile(generate, 'Tests/verify-background-run.sh', 'exec'), {'__name__': '__main__'})
# The two existing harnesses ship different UIKit doubles. Use the background
# runtime's UIKit implementation and keep every group fixture method/assertion.
source = Path('Tests/GroupChatManagerTests.m').read_text()
source, n = re.subn(r'^NSNotificationName const UIApplication\w+Notification=.*?;\n', '', source, flags=re.M)
assert n == 2
source, n = re.subn(r'^@implementation UIApplication\n.*?^@end\n', '', source, flags=re.M | re.S)
assert n == 1
(out/'GroupChatFixture.h').write_text(source)
(out/'GroupChatUIKitTypes.h').write_text('@class UIViewController;\n')
hook = Path('Hooks/GroupChatHooks.xm').read_text()
start = hook.index('        [background start];')
end = hook.index('        [group start];', start) + len('        [group start];')
(out/'GroupChatBackgroundHook.h').write_text(hook[start:end]+'\n')
PY
cat > "$test_dir/demand.m" <<'OBJC'
#import <Foundation/Foundation.h>
@interface UIViewController:NSObject @end
#define main ExistingGroupManagerMain
#include "GroupChatFixture.h"
#undef main
#import "CSBackgroundRunManager.h"
#import "BackgroundRunFakeRuntime.h"
#import <objc/runtime.h>

static CSBackgroundRunManager *auditManager;
static CSTestBackgroundRuntime *auditRuntime;
static NSUserDefaults *auditDefaults;
@interface CSBackgroundRunManager (GroupBackgroundDemandAudit)
+ (instancetype)auditSharedManager;
@end
@implementation CSBackgroundRunManager (GroupBackgroundDemandAudit)
+ (instancetype)auditSharedManager { return auditManager; }
@end

static BOOL Requested(void){return [[auditManager valueForKey:@"groupChatRequested"] boolValue];}
static void SetGlobal(BOOL enabled){
    [auditDefaults setBool:enabled forKey:CSBackgroundRunEnabledKey];
    // Match the plugin settings page: write its suite, then post the setting event.
    [NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunSettingsChangedNotification object:nil];
    Check(auditManager.enabled==enabled,@"global manager has reloaded the plugin setting");
}
static void NoResources(void){
    Check(!auditManager.canAttemptBackgroundWork && !auditManager.canAttemptGroupChatBackgroundWork,@"neither consumer can work");
    Check(!auditRuntime.liveTaskCount && !auditRuntime.pendingCheckCount && !auditManager.backgroundAudioActive,@"no task, check or audio is held");
}
static void EnterForeground(void){
    UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
    ActivateOnly();
}

int main(void){@autoreleasepool{
    NSString *suite=[@"group.background.demand.audit." stringByAppendingString:NSUUID.UUID.UUIDString];
    auditDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    [auditDefaults setBool:NO forKey:CSBackgroundRunEnabledKey];
    auditRuntime=[CSTestBackgroundRuntime new];
    auditManager=[[CSBackgroundRunManager alloc] initWithDefaults:auditDefaults audio:[CSBackgroundRunAudio new] supportsBackgroundAudio:NO runtime:auditRuntime];
    method_exchangeImplementations(class_getClassMethod(CSBackgroundRunManager.class,@selector(sharedManager)),
        class_getClassMethod(CSBackgroundRunManager.class,@selector(auditSharedManager)));
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    CSGroupChatManager *group=[CSGroupChatManager new];
    responseManager=group;
    CSBackgroundRunManager *background=auditManager;
    NSMutableDictionary *config=[CSGroupChatDefaultConfiguration() mutableCopy];
    config[@"welcomeEnabled"]=@YES;
    config[@"welcomeRooms"]=@[room];
    config[@"welcomeTemplate"]=@"原欢迎 @备注 @微信ID";
    config[@"backgroundRealtimeEnabled"]=@YES;
    storedState=@{@"schema":@1,@"account":account,@"configuration":config};
    deliverNativeSnapshots=YES;roomData=[@{@"chatRoomVersion":@1,@"joinTime":@0} mutableCopy];liveMembers=[NSSet setWithArray:@[@"alice",@"old"]];
    #include "GroupChatBackgroundHook.h"
    Wait(^BOOL{return group.ready && acceptedResponses==1;},@"a selected welcome room is ready in foreground");
    Check(!Requested(),@"no group demand is registered when global is off");
    Check(!group.configuration[@"backgroundRealtimeEnabled"] && [group.configuration[@"welcomeTemplate"] isEqual:config[@"welcomeTemplate"]],@"manager discards only the retired key when loading old state");
    Background();NoResources();
    Check(!runtimeEnabled && auditRuntime.beginAttempts==0,@"global off leaves no background ingress and starts no task");

    SetGlobal(YES);
    Wait(^BOOL{return Requested() && runtimeEnabled;},@"actual state bridge opens group ingress");
    Check(Requested() && auditManager.canAttemptBackgroundWork && auditManager.canAttemptGroupChatBackgroundWork,@"configured groups automatically request and use the global opportunity");
    Check(auditRuntime.beginAttempts==1 && auditRuntime.liveTaskCount==1 && auditRuntime.pendingCheckCount==1,@"global and group consumers share one lease and one check");
    SetGlobal(NO);
    Check(!Requested(),@"turning the global switch off synchronously withdraws group demand");
    NoResources();
    Wait(^BOOL{return !runtimeEnabled;},@"actual state bridge closes group ingress");

    SetGlobal(YES);
    Wait(^BOOL{return runtimeEnabled;},@"a fresh enable restores group opportunity");
    Check(auditRuntime.beginAttempts==2 && auditRuntime.liveTaskCount==1 && auditRuntime.pendingCheckCount==1,@"enable starts just one new lease");
    [auditRuntime.tasks.lastObject expire];
    NoResources();
    Check(Requested(),@"an expired opportunity is not a change to group demand");
    Wait(^BOOL{return !runtimeEnabled;},@"expired opportunity closes ingress");
    SetGlobal(NO);
    Check(!Requested(),@"global off withdraws demand even when there is no opportunity and state would not otherwise change");
    NoResources();
    auditRuntime.failBegin=YES;
    SetGlobal(YES);
    Wait(^BOOL{return Requested();},@"selected room requests background execution even if no lease is available");
    NoResources();
    Check(auditRuntime.beginAttempts==3 && !runtimeEnabled,@"enabling with no available lease makes one failed attempt and keeps ingress closed");
    SetGlobal(NO);
    Check(!Requested(),@"an unsuccessful lease request is still synchronously withdrawn when global is off");
    auditRuntime.failBegin=NO;
    EnterForeground();

    SetGlobal(YES);
    Wait(^BOOL{return Requested();},@"group registers demand in foreground without a current execution opportunity");
    Configure(group,@{@"welcomeRooms":@[],@"monitorRooms":@[],@"backgroundRealtimeEnabled":@YES});
    NSMutableDictionary *expected=[config mutableCopy];
    [expected removeObjectForKey:@"backgroundRealtimeEnabled"];
    expected[@"welcomeRooms"]=@[];
    Check([storedState[@"configuration"] isEqual:expected],@"whole-dictionary settings writes never recreate the key and preserve unrelated values");
    Check(!Requested(),@"ready group config with no selected rooms stops requesting");
    Background();
    Check(auditManager.canAttemptBackgroundWork && !auditManager.canAttemptGroupChatBackgroundWork && !runtimeEnabled,@"global-only opportunity without selected rooms does not open group ingress");
    Check(auditRuntime.beginAttempts==4 && auditRuntime.liveTaskCount==1 && auditRuntime.pendingCheckCount==1,@"global consumer keeps its own lease after group demand is removed");
    SetGlobal(NO);NoResources();
    Check(!Requested(),@"no standalone group request survives global shutdown");
    [auditDefaults removePersistentDomainForName:suite];
    printf("2.4-6 shared background demand: %u checks passed; actual group bridge, single lease, synchronous withdrawal, expiry, and no selected rooms\n",checks);
}return 0;}
OBJC
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
    -Wno-nullability-completeness -Wno-incomplete-implementation -framework Foundation \
    -DAVAudioSession=CSTestAudioSession -DAVAudioPlayer=CSTestAudioPlayer \
    -include "$test_dir/GroupChatUIKitTypes.h" -ITests/BackgroundRunNative -IControllers -ITests -I"$test_dir" \
    Tests/BackgroundRunNative/BackgroundRunNative.m Controllers/CSBackgroundRunAudio.m \
    Controllers/CSBackgroundRunManager.m Controllers/CSBackgroundRunRuntime.m Tests/BackgroundRunFakeRuntime.m \
    Controllers/CSGroupChatManager.m Controllers/CSGroupChatEventPolicy.m Controllers/CSGroupChatTemplate.m \
    "$test_dir/demand.m" -o "$test_dir/demand"
"$test_dir/demand"
