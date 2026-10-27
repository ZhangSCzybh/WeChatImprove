#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-native-picker.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -I"$project_dir/Tests/NativePickerUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" "$project_dir/Controllers/CSNativeContactPicker.m" \
  "$project_dir/Tests/NativeContactPickerTests.m" -o "$test_dir/tests"
"$test_dir/tests"
