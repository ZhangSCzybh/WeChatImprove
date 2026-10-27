#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-close-friend-automation.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSScheduledTaskSettingsViewController.m').read_text().split('@implementation CSScheduledTaskSettingsViewController',1)[1]
methods=[]
for marker in ['- (BOOL)tableView:', '- (void)tableView:(UITableView *)tableView commitEditingStyle:']:
    start=source.index(marker); pos=source.index('{',start)+1; depth=1
    while depth:
        depth+=(source[pos]=='{')-(source[pos]=='}'); pos+=1
    methods.append(source[start:pos])
Path(sys.argv[1],'ScheduledTaskListActionsUnderTest.h').write_text('\n'.join(methods))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -Wno-unused-parameter -IControllers -I"$test_dir" Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendAutomationProjection.m \
  Tests/CloseFriendAutomationTests.m -o "$test_dir/tests"
"$test_dir/tests"
