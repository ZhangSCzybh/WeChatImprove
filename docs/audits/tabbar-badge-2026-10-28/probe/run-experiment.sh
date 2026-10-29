#!/bin/bash
set -euo pipefail
probe_dir="$(cd "$(dirname "$0")" && pwd)"
project_dir="$(cd "$probe_dir/../../../.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-tabbar-badge-experiment.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$probe_dir/prepare-experiment.py" "$project_dir/Controllers/CSTabBarNativeAdapter.m" "$test_dir/CSTabBarNativeAdapter.m" "$probe_dir"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-const-variable -Wno-incompatible-pointer-types -framework Foundation -framework QuartzCore -framework CoreGraphics -I"$project_dir/Tests/TabBarUIKit" -I"$project_dir/Headers" -I"$project_dir/Controllers" "$project_dir/Tests/TabBarUIKit/TabBarUIKit.m" "$project_dir/Controllers/CSTabBarPreferences.m" "$test_dir/CSTabBarNativeAdapter.m" "$probe_dir/TabBarBadgeProbe.m" -o "$test_dir/probe"
"$test_dir/probe" "$test_dir/icon.png" "${1:-flexible-left-margin}"
