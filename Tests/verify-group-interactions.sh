#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-interactions.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-interactions.py" "$test_dir/GroupInteractionBodies.h"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
    -framework Foundation -framework CoreGraphics -I"$test_dir" \
    "$project_dir/Tests/GroupInteractionTests.m" -o "$test_dir/interaction-tests"
"$test_dir/interaction-tests"
