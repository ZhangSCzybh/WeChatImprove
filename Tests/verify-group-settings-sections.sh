#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-settings-sections.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, out=map(Path,sys.argv[1:])
source=(root/'Controllers/CSChatGroupSettingsViewController.m').read_text()
def method(marker):
    start=source.index(marker); brace=source.index('{',start); depth=0
    for end in range(brace,len(source)):
        if source[end]=='{': depth+=1
        elif source[end]=='}':
            depth-=1
            if not depth: return source[start:end+1]
    raise ValueError(marker)
markers=['- (BOOL)isGroupSectionAtIndex:',
         '- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:',
         '- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:',
         '- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:',
         '- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:',
         '- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:']
bodies='\n'.join(method(marker) for marker in markers)
# Replay the production admission gate before UIKit creates any action objects.
swipe=method('- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:')
swipe=swipe[:swipe.index('    NSString *accountID')]+ '    return [UISwipeActionsConfiguration new];\n}'
(out/'GroupSettingsSectionBodies.h').write_text(bodies+'\n'+swipe+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-sign-compare \
    -framework Foundation -I"$test_dir" -I"$project_dir/Controllers" \
    "$project_dir/Controllers/WESessionTabItem.m" "$project_dir/Tests/GroupSettingsSectionTests.m" -o "$test_dir/tests"
"$test_dir/tests"
