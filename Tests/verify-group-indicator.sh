#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-indicator.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-indicator.py" "$test_dir/GroupIndicatorBodies.h"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
    -framework Foundation -framework QuartzCore -framework CoreGraphics -I"$test_dir" \
    "$project_dir/Tests/GroupIndicatorTests.m" -o "$test_dir/indicator-tests"
"$test_dir/indicator-tests"
