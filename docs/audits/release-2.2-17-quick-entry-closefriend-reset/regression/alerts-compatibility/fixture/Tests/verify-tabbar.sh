#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-tabbar.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun clang -Wall -Wextra -Werror -I"$project_dir/Headers" "$project_dir/Tests/TabBarGeometryTests.c" -o "$test_dir/geometry"
"$test_dir/geometry"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-const-variable -Wno-incompatible-pointer-types -framework Foundation -framework QuartzCore -framework CoreGraphics -I"$project_dir/Tests/TabBarUIKit" -I"$project_dir/Headers" -I"$project_dir/Controllers" "$project_dir/Tests/TabBarUIKit/TabBarUIKit.m" "$project_dir/Controllers/CSTabBarPreferences.m" "$project_dir/Controllers/CSTabBarNativeAdapter.m" "$project_dir/Tests/TabBarNativeTests.m" -o "$test_dir/native"
"$test_dir/native" "$test_dir/icon.png"
