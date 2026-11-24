#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-color-settings.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, out = map(Path, sys.argv[1:])
source = (root/'Controllers/CSChatGroupSettingsViewController.m').read_text()
def method(marker):
    start = source.index(marker)
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{': depth += 1
        elif source[end] == '}':
            depth -= 1
            if not depth: return source[start:end+1]
    raise ValueError(marker)
markers = ['- (void)traitCollectionDidChange:', '- (UIColor *)storedColorForKey:',
           '- (UIColor *)currentIndicatorColor', '- (UIColor *)currentSelectedTextColor',
           '- (BOOL)isDarkMode', '- (NSString *)colorPreferenceKeyForType:',
           '- (void)showColorPicker', '- (void)colorPickerViewControllerDidFinish:',
           '- (void)colorPickerViewControllerDidSelectColor:', '- (void)saveColor:']
(out/'GroupColorSettingsBodies.h').write_text('\n'.join(map(method, markers))+'\n')
start = source.index('    self.indicatorColorPreview.previewColor =')
end = source.index('    CSSettingItem *indicatorAnimationItem', start)
(out/'GroupColorSettingsRows.h').write_text(source[start:end])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
    -framework Foundation -I"$test_dir" "$project_dir/Tests/GroupColorSettingsTests.m" -o "$test_dir/tests"
"$test_dir/tests"
