#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-layout-preferences.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
 -framework Foundation -framework CoreFoundation -I"$project_dir/Controllers" \
 "$project_dir/Controllers/CSLayoutPreferences.m" "$project_dir/Tests/LayoutPreferencesTests.m" -o "$test_dir/tests"
"$test_dir/tests"
