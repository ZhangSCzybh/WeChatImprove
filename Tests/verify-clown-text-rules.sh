#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-clown-text-rules.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$project_dir/Controllers" "$project_dir/Controllers/CSClownTextRules.m" \
  "$project_dir/Tests/ClownTextRulesTests.m" -o "$test_dir/tests"
"$test_dir/tests"
