#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-tabbar-badge-tests.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-tabbar-badge-hooks.py" "$project_dir/Hooks/TabBarStyleHooks.xm" "$test_dir/TabBarBadgeHookConfiguration.h"
mode="${1:-both}"
for disable in 0 1; do
    if [[ "$mode" == "source" && "$disable" == 1 ]] || [[ "$mode" == "without-relayout" && "$disable" == 0 ]]; then continue; fi
    xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-const-variable -Wno-incompatible-pointer-types \
        -DCS_BADGE_DISABLE_RELAYOUT_HOOK="$disable" -framework Foundation -framework QuartzCore -framework CoreGraphics \
        -I"$test_dir" -I"$project_dir/Tests/TabBarUIKit" -I"$project_dir/Headers" -I"$project_dir/Controllers" \
        "$project_dir/Tests/TabBarUIKit/TabBarUIKit.m" "$project_dir/Controllers/CSTabBarPreferences.m" \
        "$project_dir/Controllers/CSTabBarNativeAdapter.m" "$project_dir/Tests/TabBarBadgeTests.m" -o "$test_dir/badge-$disable"
    "$test_dir/badge-$disable" "$test_dir/icon-$disable.png"
done
