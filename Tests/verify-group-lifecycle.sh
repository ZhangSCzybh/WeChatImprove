#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-lifecycle.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-lifecycle.py" "$test_dir/GroupLifecycleBodies.h" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-variable \
    -framework Foundation -framework CoreGraphics -framework QuartzCore -I"$test_dir" \
    -I"$project_dir/Tests/BackgroundBlurUIKit" -I"$project_dir/Controllers" \
    "$project_dir/Tests/BackgroundBlurUIKit/BackgroundBlurUIKit.m" \
    "$project_dir/Controllers/CSCloseFriendListShield.m" \
    "$project_dir/Controllers/CSCloseFriendPolicy.m" \
    "$project_dir/Controllers/CSGroupProjection.m" "$project_dir/Controllers/WESessionTabItem.m" \
    "$project_dir/Tests/GroupLifecycleTests.m" -o "$test_dir/lifecycle-tests"
"$test_dir/lifecycle-tests"
