#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-initial-viewport.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-initial-viewport.py" "$test_dir/GroupInitialViewportBodies.h" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
    -framework Foundation -framework CoreGraphics -I"$test_dir" \
    "$project_dir/Tests/GroupInitialViewportTests.m" -o "$test_dir/initial-viewport-tests"
"$test_dir/initial-viewport-tests"
