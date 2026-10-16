#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-lifecycle.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-lifecycle.py" "$test_dir/GroupLifecycleBodies.h" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-variable \
    -framework Foundation -I"$test_dir" \
    "$project_dir/Tests/GroupLifecycleTests.m" -o "$test_dir/lifecycle-tests"
"$test_dir/lifecycle-tests"
