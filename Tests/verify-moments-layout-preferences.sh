#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-layout-preferences.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -DCS_MOMENTS_LAYOUT_TESTING=1 \
  -Wall -Wextra -Werror -framework Foundation -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSMomentsLayoutPreferences.m" \
  "$project_dir/Tests/MomentsLayoutPreferencesTests.m" -o "$test_dir/tests"
"$test_dir/tests"
