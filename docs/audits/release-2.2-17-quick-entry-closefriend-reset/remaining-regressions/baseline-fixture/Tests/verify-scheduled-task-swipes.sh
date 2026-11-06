#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-scheduled-swipes.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSScheduledTaskSettingsViewController.m').read_text().split('@implementation CSScheduledTaskSettingsViewController',1)[1]
def method(selector):
    start=source.index(selector)
    opening=source.index('{',start)
    depth=1
    end=opening+1
    while depth:
        depth+=(source[end]=='{')-(source[end]=='}')
        end+=1
    return source[start:end]
selectors=(
    '- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:',
    '- (NSDictionary *)swipeTaskWithID:',
    '- (void)performTaskAction:',
    '- (UISwipeActionsConfiguration *)tableView:',
    '- (void)tableView:(UITableView *)tableView commitEditingStyle:',
)
Path(sys.argv[1],'ScheduledTaskSwipeUnderTest.h').write_text('\n'.join(method(selector) for selector in selectors))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -IControllers -I"$test_dir" -framework Foundation \
  Controllers/CSScheduledTaskStore.m Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendAutomationProjection.m \
  Tests/ScheduledTaskSwipeTests.m -o "$test_dir/tests"
"$test_dir/tests" "$test_dir/data"
