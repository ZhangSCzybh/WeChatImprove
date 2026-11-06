#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-list-corners.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-list-corners.py" "$test_dir/ListCornerBodies.h"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-incomplete-implementation \
    -framework Foundation -framework CoreText -framework QuartzCore -framework CoreGraphics \
    -I"$test_dir" -I"$project_dir/Tests/ListCornerUIKit" -I"$project_dir/Controllers" \
    "$project_dir/Tests/ListCornerSemanticsTests.m" "$project_dir/Tests/ListCornerUIKit/ListCornerUIKit.m" \
    "$project_dir/Controllers/CSListCornerConfiguration.m" "$project_dir/Controllers/CSListCornerSectionPolicy.m" \
    "$project_dir/Controllers/CSListCornerPageContext.m" "$project_dir/Controllers/CSListCornerRenderer.m" \
    "$project_dir/Controllers/CSListCornerSessionAdapter.m" "$project_dir/Controllers/CSListCornerContactsAdapter.m" \
    "$project_dir/Controllers/CSListCornerSessionRestore.m" \
    "$project_dir/Controllers/CSListCornerDiscoverAdapter.m" "$project_dir/Controllers/CSListCornerMoreAdapter.m" \
    "$project_dir/Controllers/CSGroupIndexScope.m" "$project_dir/Controllers/CSGroupProjection.m" \
    "$project_dir/Controllers/WESessionTabItem.m" "$project_dir/Controllers/CSCloseFriendPolicy.m" -o "$test_dir/list-tests"
"$test_dir/list-tests" "$project_dir/Tests/ListCornerBaseline.json"
