#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-automation-background-sync.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
project, output = map(Path, sys.argv[1:])
source = (project / 'Controllers/CSMessageNativeActionAdapter.m').read_text()
marker = '@interface NSObject (CSNativeAppPath)'
assert source.count(marker) == 1
(output / 'NativeDispatchUnderTest.m').write_text(source.split(marker, 1)[0])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -Wno-incomplete-implementation -Wno-unused-function \
  -I"$project_dir/Tests/AIDetailUIKit" -I"$project_dir/Tests" \
  -I"$project_dir/Controllers" -I"$project_dir/Headers" -framework Foundation \
  "$project_dir/Controllers/CSAutomationStore.m" \
  "$project_dir/Controllers/CSBackgroundSyncBudget.m" \
  "${CS_AUTOMATION_MANAGER_SOURCE:-$project_dir/Controllers/CSAutomationManager.m}" \
  "$test_dir/NativeDispatchUnderTest.m" \
  "$project_dir/Tests/AutomationBackgroundSyncTests.m" -o "$test_dir/tests"
"$test_dir/tests" "$test_dir/resources"
