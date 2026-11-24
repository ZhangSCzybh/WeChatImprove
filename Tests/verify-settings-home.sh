#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-settings-home.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import re, sys
root, output = map(Path, sys.argv[1:])
source = (root / 'Controllers/CSSettingsHomeModel.m').read_text()
assert source.count('#import "CSSettingsHomeModel.h"') == 1
assert source.count('#import "CSSettingTableViewCell.h"') == 1
# UIKit is needed only by the shared setting declarations. Foundation fixtures
# supply their data API; all model logic and CoreGraphics layout code stays real.
public = (root / 'Controllers/CSSettingsHomeModel.h').read_text()
source = source.replace('#import "CSSettingsHomeModel.h"', public)
source = source.replace('#import "CSSettingTableViewCell.h"', '')
(output / 'SettingsHomeModelUnderTest.h').write_text(source)
controller = (root / 'Controllers/CSCustomViewController.m').read_text()
methods = []
for name in ['setupData', 'currentHomeDistance', 'setHomeDistance:', 'positionSettingsTabBar',
             'updateHomeFooter', 'reloadSettingsKeepingPosition', 'reloadHomeAtDistance:',
             'selectHomeTab:', 'revealHomeAccountSection', 'openHomeSearch', 'updateHomeSearch:', 'closeHomeSearch',
             'updateHeaderLayout', 'viewWillAppear:', 'viewDidAppear:', 'viewWillDisappear:', 'viewDidLayoutSubviews',
             'currentOtherSettingsScope', 'currentHomePreparationScope',
             'returningFromOtherSettingsInCurrentScope']:
    match = re.search(r'^- \([^)]+\)' + re.escape(name) + r'(?=[ (:{])', controller, re.M)
    if not match:
        raise SystemExit('Missing real controller method: ' + name)
    opening = controller.index('{', match.start())
    depth, end = 1, opening + 1
    while depth:
        depth += (controller[end] == '{') - (controller[end] == '}')
        end += 1
    methods.append(controller[match.start():end])
selection = re.search(r'^- \(void\)tableView:\(UITableView \*\)tableView didSelectRowAtIndexPath:', controller, re.M)
if not selection:
    raise SystemExit('Missing real controller selection method')
opening = controller.index('{', selection.start())
depth, end = 1, opening + 1
while depth:
    depth += (controller[end] == '{') - (controller[end] == '}')
    end += 1
selection_source = controller[selection.start():end]
methods.append(selection_source)
# Compile the real selection method against navigation destinations that retain
# their actual class names. Tests execute every registered navigation branch.
destinations = sorted(set(re.findall(r'\[\[(\w+) alloc\]', selection_source)))
(output / 'SettingsHomeRouteControllers.h').write_text('\n'.join(
    '@interface ' + name + ' : HomeFixtureRouteController @end\n@implementation ' + name + ' @end'
    for name in destinations))
(output / 'SettingsHomeControllerUnderTest.h').write_text('\n'.join(methods))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-nullability-completeness \
  -I"$project_dir/Controllers" -I"$test_dir" \
  -framework Foundation -framework CoreGraphics \
  "$project_dir/Tests/SettingsHomeModelTests.m" -o "$test_dir/tests"
"$test_dir/tests"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-nullability-completeness -Wno-unused-parameter \
  -I"$project_dir/Controllers" -I"$project_dir/Headers" -I"$test_dir" \
  -framework Foundation -framework CoreGraphics \
  "$project_dir/Tests/SettingsHomeControllerTests.m" -o "$test_dir/controller-tests"
"$test_dir/controller-tests"
