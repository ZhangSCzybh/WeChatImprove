#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-quick-panel-gesture.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -std=c11 -Wall -Wextra -Werror -fsanitize=undefined \
  -I"$project_dir/Controllers" "$project_dir/Tests/QuickPanelGesturePolicyTests.c" \
  -o "$test_dir/tests"
"$test_dir/tests"
