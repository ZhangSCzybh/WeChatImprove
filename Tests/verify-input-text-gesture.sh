#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-input-text-gesture.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSInputTextGesturePreferences.m" \
  "$project_dir/Controllers/CSInputTextGestureEditing.m" \
  "$project_dir/Tests/InputTextGestureEditingTests.m" -o "$test_dir/tests"
"$test_dir/tests"
xcrun --sdk macosx clang -std=c11 -Wall -Wextra -Werror -fsanitize=undefined \
  -I"$project_dir/Controllers" "$project_dir/Tests/InputTextGesturePolicyTests.c" \
  -o "$test_dir/policy-tests"
"$test_dir/policy-tests"
