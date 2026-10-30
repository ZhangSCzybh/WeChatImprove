#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-launch-banner.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-launch-banner.py" "$test_dir/GroupLaunchBannerBodies.h" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
    -framework Foundation -framework CoreGraphics -I"$test_dir" -I"$project_dir/Controllers" \
    "$project_dir/Controllers/CSGroupProjection.m" \
    "$project_dir/Controllers/CSGroupIndexScope.m" \
    "$project_dir/Controllers/WESessionTabItem.m" \
    "$project_dir/Tests/GroupLaunchBannerTests.m" -o "$test_dir/launch-banner-tests"
"$test_dir/launch-banner-tests"
