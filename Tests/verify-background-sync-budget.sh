#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-background-sync-budget.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$project_dir/Controllers" "$project_dir/Controllers/CSBackgroundSyncBudget.m" \
  "$project_dir/Tests/BackgroundSyncBudgetTests.m" -o "$test_dir/tests"
"$test_dir/tests"
if [[ "${1:-}" == "--ios" ]]; then
  sdk_dir="$(xcrun --sdk iphoneos --show-sdk-path)"
  for arch in arm64 arm64e; do
    xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
      -fobjc-arc -fblocks -Wall -Wextra -Werror -I"$project_dir/Controllers" \
      -c "$project_dir/Controllers/CSBackgroundSyncBudget.m" -o "$test_dir/budget.$arch.o"
  done
  printf 'Background sync budget iOS: arm64 + arm64e source objects compiled\n'
fi
