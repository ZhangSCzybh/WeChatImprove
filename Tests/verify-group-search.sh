#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-search.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-search.py" "$test_dir/SearchBodies.h"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$test_dir" -I"$project_dir/Controllers" "$project_dir/Tests/GroupSearchTests.m" -o "$test_dir/tests"
"$test_dir/tests"
