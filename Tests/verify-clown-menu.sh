#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-clown-menu.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSClownPreferences.m" \
  "$project_dir/Controllers/CSMessageActionContext.m" \
  "$project_dir/Controllers/CSClownMenuAdapter.m" \
  "$project_dir/Tests/ClownMenuTests.m" -o "$test_dir/tests"
"$test_dir/tests" legacy
"$test_dir/tests" modern
"$test_dir/tests" wrong-modern
