#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-automation-core.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root,out=map(Path,sys.argv[1:])
source=(root/'Controllers/CSAutomationEventAdapter.m').read_text()
original='CSAutomationFileURL([library URLByAppendingPathComponent:@"Preferences/WeChatImprove"],account)'
assert source.count(original)==1
source=source.replace(original,'CSAutomationFileURL([NSURL fileURLWithPath:NSProcessInfo.processInfo.environment[@"CS_AUTOMATION_TEST_ROOT"]],account)').replace('NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;','')
(out/'EventAdapterUnderTest.m').write_text(source)
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -framework Foundation \
 -I"$project_dir/Controllers" "$project_dir/Controllers/CSAutomationStore.m" "$test_dir/EventAdapterUnderTest.m" \
 "$project_dir/Tests/AutomationCoreTests.m" -o "$test_dir/automation-core-tests"
CS_AUTOMATION_TEST_ROOT="$test_dir/fixtures" "$test_dir/automation-core-tests" "$test_dir/fixtures"
