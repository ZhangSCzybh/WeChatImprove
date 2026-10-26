#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-background-blur.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
    -framework Foundation -framework CoreGraphics -framework QuartzCore \
    -I"$project_dir/Tests/BackgroundBlurUIKit" -I"$project_dir/Controllers" \
    "$project_dir/Tests/BackgroundBlurUIKit/BackgroundBlurUIKit.m" \
    "$project_dir/Controllers/CSBackgroundBlurManager.m" \
    "$project_dir/Tests/BackgroundBlurTests.m" -o "$test_dir/background-blur"
"$test_dir/background-blur"
