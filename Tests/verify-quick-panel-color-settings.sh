#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-quick-panel-color-settings.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import re, sys
root, output = map(Path, sys.argv[1:])
source = (root / 'Controllers/CSQuickPanelSettingsViewController.m').read_text()
enum = re.search(r'typedef NS_ENUM\(NSInteger, CSQuickPanelColorTarget\) \{.*?\n\};', source, re.S)
picker = re.search(r'@interface CSQuickPanelColorPicker : UIColorPickerViewController.*?@end\s*@implementation CSQuickPanelColorPicker\s*@end', source, re.S)
if not enum or not picker:
    raise SystemExit('Missing production picker identity/target declaration')
(output / 'QuickPanelColorSettingsDeclarations.h').write_text(enum.group() + '\n' + picker.group() + '\n')
methods = []
for name in ['selectedBackgroundColor', 'showBackgroundColorPicker', 'showForegroundColorOptions:',
             'showColorPickerForTarget:', 'saveColorFromPicker:', 'colorPickerViewControllerDidSelectColor:',
             'colorPickerViewControllerDidFinish:', 'restoreDefaultForegroundColors']:
    match = re.search(r'^- \([^)]+\)' + re.escape(name) + r'(?=[ (:{])', source, re.M)
    if not match:
        raise SystemExit('Missing production method: ' + name)
    opening = source.index('{', match.start())
    depth, end = 1, opening + 1
    while depth:
        depth += (source[end] == '{') - (source[end] == '}')
        end += 1
    methods.append(source[match.start():end])
(output / 'QuickPanelColorSettingsUnderTest.h').write_text('\n'.join(methods) + '\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -I"$test_dir" -framework Foundation \
  "$project_dir/Tests/QuickPanelColorSettingsTests.m" -o "$test_dir/color-settings-tests"
"$test_dir/color-settings-tests"
