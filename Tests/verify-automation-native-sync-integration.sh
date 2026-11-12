#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-native-sync-integration.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
manager_source=${CS_AUTOMATION_MANAGER_SOURCE:-Controllers/CSAutomationManager.m}
sync_source=${CS_AUTOMATION_NATIVE_SYNC_SOURCE:-Controllers/CSAutomationNativeSync.m}
environment_source=${CS_AUTOMATION_NATIVE_ENV_SOURCE:-Controllers/CSMessageNativeActionAdapter.m}
python3 - "$test_dir" "$manager_source" "$environment_source" "$sync_source" <<'PY'
import re
import sys
from pathlib import Path
target=Path(sys.argv[1])
manager=Path(sys.argv[2]).read_text()
native=Path(sys.argv[3]).read_text()
(target/'ManagerUnderTest.m').write_text(manager)
(target/'SyncUnderTest.m').write_text(Path(sys.argv[4]).read_text())
(target/'CSAutomationManager.h').write_text(Path(sys.argv[2]).with_name('CSAutomationManager.h').read_text())
prefix=native.split('@interface NSObject (CSNativeAppPath)',1)[0]
environment='@implementation CSMessageNativeEnvironment'+native.split('@implementation CSMessageNativeEnvironment',1)[1].split('@implementation CSMessageNativeActionAdapter',1)[0]
(target/'NativeEnvironmentUnderTest.m').write_text(prefix+'\n'+environment)
fixture=Path('Tests/AutomationManagerTests.m').read_text().split('static void ConfigureAll(',1)[0]
# The baseline predates these optional guards. Strip only its three one-line
# sync stubs and environment implementation, retaining real manager methods.
for name in ['CSAutomationInstallNativeSync','CSAutomationNativeSyncAvailable','CSAutomationWakePendingNativeSync']:
    fixture,n=re.subn(r'^(?:void|BOOL) '+name+r'\([^\n]*\n','',fixture,flags=re.M)
    assert n==1,(name,n)
fixture,n=re.subn(r'@implementation CSMessageNativeEnvironment\n.*?\n@end\n','',fixture,count=1,flags=re.S)
assert n==1
(target/'NativeSyncIntegrationFixture.h').write_text(fixture)
source=Path('Controllers/CSAutomationEventAdapter.m').read_text()
original='CSAutomationFileURL([library URLByAppendingPathComponent:@"Preferences/WeChatImprove"],account)'
assert source.count(original)==1
source=source.replace(original,'CSAutomationFileURL([NSURL fileURLWithPath:NSProcessInfo.processInfo.environment[@"CS_AUTOMATION_TEST_ROOT"]],account)').replace('NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;','')
(target/'EventAdapterUnderTest.m').write_text(source)
signature='void (^)(id)' if re.search(r'request:\(void\s*\(\^\)\(id',manager) else 'void (^)(void)'
(target/'IntegrationManagerAPI.h').write_text('#import "CSAutomationManager.h"\n@interface CSAutomationManager (IntegrationFixturePrefix)\n- (void)performNativeSyncForService:(id)service epoch:(NSUInteger)epoch request:('+signature+')request;\n@end\n')
(target/'substrate.h').write_text('#import <objc/runtime.h>\nvoid MSHookMessageEx(Class, SEL, IMP, IMP *);\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -Wno-incomplete-implementation -Wno-unused-function -Wno-unused-variable \
 -DCS_AUTOMATION_REAL_EVENT_ADAPTER=1 -DCS_AUTOMATION_REAL_NATIVE_SYNC=1 \
 -DCS_AUTOMATION_REAL_NATIVE_ENVIRONMENT=1 -DCS_AUTOMATION_REAL_SERVICE_IDENTITY=1 \
 -I"$test_dir" -ITests/AIDetailUIKit -ITests -IControllers -IHeaders \
 -include "$test_dir/IntegrationManagerAPI.h" -framework Foundation \
 Controllers/CSMessageActionContext.m "$test_dir/NativeEnvironmentUnderTest.m" \
 Controllers/CSAutomationStore.m Controllers/CSBackgroundSyncBudget.m \
 "$test_dir/ManagerUnderTest.m" "$test_dir/SyncUnderTest.m" "$test_dir/EventAdapterUnderTest.m" \
 Tests/AutomationNativeSyncIntegrationTests.m -o "$test_dir/tests"
test_mode=all
if [[ "${1:-}" == "--event-only" ]]; then test_mode=event-only; fi
CS_AUTOMATION_TEST_ROOT="$test_dir/resources" "$test_dir/tests" "$test_dir/resources" "$test_mode"
if [[ "${1:-}" == "--ios" ]]; then
 sdk_dir=$(xcrun --sdk iphoneos --show-sdk-path)
 for arch in arm64 arm64e; do
  for source in "$test_dir/ManagerUnderTest.m" "$test_dir/SyncUnderTest.m" "$test_dir/NativeEnvironmentUnderTest.m"; do
   xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
    -fobjc-arc -fblocks -Wall -Wextra -Werror -I"$test_dir" -IControllers -IHeaders \
    -include "$test_dir/IntegrationManagerAPI.h" -c "$source" \
    -o "$test_dir/$(basename "$source").$arch.o"
  done
 done
 printf 'Automation native sync integration iOS: arm64 + arm64e manager/core/environment objects compiled\n'
fi
