#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-viewport.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-viewport.py" "$test_dir/GroupViewportBodies.h" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
    -framework Foundation -framework CoreGraphics -I"$test_dir" \
    "$project_dir/Tests/GroupViewportTests.m" -o "$test_dir/viewport-tests"
"$test_dir/viewport-tests"
