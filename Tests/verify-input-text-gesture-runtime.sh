#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-input-gesture-runtime.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -Wno-unused-parameter -framework Foundation -framework CoreGraphics -framework QuartzCore \
  -I"$project_dir/Tests/InputTextGestureRuntimeUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Tests/TabBarUIKit/TabBarUIKit.m" "$project_dir/Tests/StyleUIKit/StyleUIKit.m" \
  "$project_dir/Tests/InputTextGestureRuntimeUIKit/RuntimeUIKit.m" \
  "$project_dir/Controllers/CSInputTextGesture.m" "$project_dir/Controllers/CSInputTextStyle.m" \
  "$project_dir/Controllers/CSInputTextGestureEditing.m" \
  "$project_dir/Controllers/CSInputTextGesturePreferences.m" \
  "$project_dir/Tests/InputTextGestureRuntimeTests.m" -o "$test_dir/tests"
"$test_dir/tests"
