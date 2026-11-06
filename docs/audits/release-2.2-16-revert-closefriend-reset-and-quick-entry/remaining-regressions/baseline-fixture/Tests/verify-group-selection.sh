#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-selection.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-selection.py" "$test_dir" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
    -framework Foundation -framework CoreGraphics -I"$test_dir" -I"$project_dir/Controllers" \
    "$project_dir/Controllers/CSCloseFriendPolicy.m" "$project_dir/Controllers/CSGroupProjection.m" "$project_dir/Controllers/CSGroupPreferences.m" \
    "$project_dir/Controllers/WESessionTabItem.m" "$project_dir/Controllers/CSGroupIndexScope.m" \
    "$project_dir/Controllers/CSGroupInvocationMapper.m" "$project_dir/Tests/GroupSelectionTests.m" \
    -o "$test_dir/selection-tests"
"$test_dir/selection-tests"
