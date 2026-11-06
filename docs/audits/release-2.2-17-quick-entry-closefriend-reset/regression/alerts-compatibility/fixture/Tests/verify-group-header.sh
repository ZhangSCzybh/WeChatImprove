#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-header.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-header.py" "$test_dir/GroupHeaderBodies.h" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
    -framework Foundation -I"$test_dir" -I"$project_dir/Controllers" \
    "$project_dir/Tests/GroupHeaderSemanticsTests.m" "$project_dir/Controllers/CSGroupIndexScope.m" \
    -o "$test_dir/header-tests"
"$test_dir/header-tests"
