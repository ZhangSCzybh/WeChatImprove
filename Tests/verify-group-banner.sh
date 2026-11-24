#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-banner.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$project_dir/Tests/extract-group-banner.py" "$test_dir/GroupBannerHooks.h" "$@"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function \
    -framework Foundation -I"$test_dir" -I"$project_dir/Controllers" \
    "$project_dir/Tests/GroupBannerTests.m" -o "$test_dir/banner-tests"
"$test_dir/banner-tests"
