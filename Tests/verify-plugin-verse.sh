#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-plugin-verse.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -I"$project_dir/Controllers" -framework Foundation \
  "$project_dir/Controllers/CSPluginVerseProvider.m" "$project_dir/Tests/PluginVerseTests.m" -o "$test_dir/tests"
"$test_dir/tests"
if [[ "${1:-}" == "--ios" ]]; then
  xcrun --sdk iphoneos clang -target arm64-apple-ios15.0 -fobjc-arc -fblocks -Wall -Wextra -Werror \
    -isysroot "$(xcrun --sdk iphoneos --show-sdk-path)" -I"$project_dir/Controllers" \
    -fsyntax-only "$project_dir/Controllers/CSPluginVerseProvider.m"
fi
