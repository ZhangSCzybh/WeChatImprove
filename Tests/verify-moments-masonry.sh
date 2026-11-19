#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-masonry.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -std=c11 -Wall -Wextra -Werror \
  -I"$project_dir/Controllers" "$project_dir/Tests/MomentsMasonryTests.m" \
  -o "$test_dir/tests"
"$test_dir/tests"
ios_sdk="$(xcrun --sdk iphoneos --show-sdk-path)"
xcrun --sdk iphoneos clang -target arm64-apple-ios15.0 -isysroot "$ios_sdk" \
  -fobjc-arc -fblocks -fsyntax-only -Wall -Wextra -Werror \
  -I"$project_dir/Controllers" "$project_dir/Controllers/CSMomentsMasonryLayout.m"
