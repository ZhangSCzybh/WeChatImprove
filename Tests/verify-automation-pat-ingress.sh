#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-automation-pat-ingress.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" "${CS_AUTOMATION_HOOKS_SOURCE:-Hooks/AutomationHooks.xm}" <<'PY'
import sys
from pathlib import Path
target=Path(sys.argv[1])
source=Path('Controllers/CSMessageNativeActionAdapter.m').read_text().split('@interface NSObject (CSNativeAppPath)',1)[0]
(target/'NativeDispatchUnderTest.m').write_text(source)
source=Path('Controllers/CSAutomationEventAdapter.m').read_text()
# Isolate only the owned-ledger root, as the core runner does. Keep the
# production XML parser, event conversion and ownership behavior intact.
original='CSAutomationFileURL([library URLByAppendingPathComponent:@"Preferences/WeChatImprove"],account)'
assert source.count(original)==1
source=source.replace(original,'CSAutomationFileURL([NSURL fileURLWithPath:NSProcessInfo.processInfo.environment[@"CS_AUTOMATION_TEST_ROOT"]],account)').replace('NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;','')
(target/'EventAdapterUnderTest.m').write_text(source)
source=Path(sys.argv[2]).read_text().split('%ctor {',1)[0].replace('"../Controllers/','"')
(target/'AutomationIngressUnderTest.m').write_text(source+'\nvoid CSAutomationTestInstallIngressHooks(void){CSAutomationInstallIngressHooks();}\n')
(target/'substrate.h').write_text('#import <objc/runtime.h>\nvoid MSHookMessageEx(Class, SEL, IMP, IMP *);\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -Wno-incomplete-implementation -Wno-unused-function -ITests/AIDetailUIKit -ITests -IControllers -IHeaders -I"$test_dir" -framework Foundation \
 Controllers/CSAutomationStore.m Controllers/CSAutomationManager.m Controllers/CSBackgroundSyncBudget.m "$test_dir/EventAdapterUnderTest.m" \
 "$test_dir/NativeDispatchUnderTest.m" "$test_dir/AutomationIngressUnderTest.m" \
 Tests/AutomationPatIngressTests.m -o "$test_dir/tests"
CS_AUTOMATION_TEST_ROOT="$test_dir/resources" "$test_dir/tests" "$test_dir/resources"
