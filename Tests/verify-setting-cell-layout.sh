#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-setting-cell-layout.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
# An alternate source permits a real pre-fix negative control. All cell and model
# methods are copied unchanged; only the unrelated alert-helper implementation is
# excluded from this host test translation unit.
source_path="${1:-$project_dir/Controllers/CSSettingTableViewCell.m}"
background_source_path="${2:-$project_dir/Controllers/CSBackgroundRunViewController.m}"
python3 - "$source_path" "$background_source_path" "$test_dir" <<'PY'
from pathlib import Path
import sys
source=Path(sys.argv[1]).read_text()
assert source.count('@implementation CSSettingTableViewCell')==1
assert '@implementation CSUIHelper' in source
out=Path(sys.argv[3])
(out/'SettingCellUnderTest.h').write_text(source.split('@implementation CSUIHelper',1)[0])
background=Path(sys.argv[2]).read_text()
def extract(marker):
    start=background.index(marker)
    opening=background.index('{',start)
    depth=1
    end=opening+1
    while depth:
        depth+=(background[end]=='{')-(background[end]=='}')
        end+=1
    return background[start:end]
(out/'BackgroundRecordSummaryUnderTest.h').write_text('\n'.join(extract(marker) for marker in (
    '- (NSString *)recordTime:', '- (NSString *)lastCheckToForegroundText:',
    '- (NSArray<NSDictionary<NSString *, NSString *> *> *)recordSummaryForManager:')))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
    -Wno-nullability-completeness -Wno-incompatible-pointer-types \
    -framework Foundation -framework CoreGraphics \
    -I"$test_dir" -I"$project_dir/Tests/SettingCellUIKit" -I"$project_dir/Controllers" \
    "$project_dir/Tests/SettingCellLayoutTests.m" "$project_dir/Tests/SettingCellUIKit/SettingCellUIKit.m" \
    -o "$test_dir/setting-cell-tests"
"$test_dir/setting-cell-tests"
