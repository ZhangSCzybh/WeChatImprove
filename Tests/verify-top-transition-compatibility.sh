#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-top-transition-compatibility.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
source_root="${1:-$project_dir}"
python3 "$project_dir/Tests/extract-list-corners.py" "$test_dir/ListCornerBodies.h"
python3 "$project_dir/Tests/extract-top-transition.py" "$test_dir/TopTransitionHooks.h" "$source_root"
python3 - "$project_dir/Tests/TopTransitionTests.m" "$test_dir/TopTransitionCompatibilityHarness.m" <<'PY'
from pathlib import Path
import sys
source=Path(sys.argv[1]).read_text()
assert source.count('int main(void)')==1
Path(sys.argv[2]).write_text(source.replace('int main(void)','int TopTransitionRedGreenMain(void)'))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-incomplete-implementation \
    -framework Foundation -framework CoreText -framework QuartzCore -framework CoreGraphics \
    -I"$test_dir" -I"$project_dir/Tests" -I"$project_dir/Tests/ListCornerUIKit" -I"$project_dir/Controllers" \
    "$project_dir/Tests/TopTransitionCompatibilityTests.m" "$project_dir/Tests/ListCornerUIKit/ListCornerUIKit.m" \
    "$project_dir/Controllers/CSListCornerConfiguration.m" "$project_dir/Controllers/CSListCornerSectionPolicy.m" \
    "$source_root/Controllers/CSListCornerPageContext.m" "$test_dir/TopTransitionRenderer.m" \
    "$source_root/Controllers/CSListCornerSessionAdapter.m" "$project_dir/Controllers/CSListCornerContactsAdapter.m" \
    "$source_root/Controllers/CSListCornerSessionRestore.m" \
    "$project_dir/Controllers/CSListCornerDiscoverAdapter.m" "$project_dir/Controllers/CSListCornerMoreAdapter.m" \
    "$project_dir/Controllers/CSGroupIndexScope.m" "$project_dir/Controllers/CSGroupProjection.m" \
    "$project_dir/Controllers/WESessionTabItem.m" "$project_dir/Controllers/CSCloseFriendPolicy.m" -o "$test_dir/top-transition-compatibility-tests"
"$test_dir/top-transition-compatibility-tests"
