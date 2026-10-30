#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-background-sync.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -IControllers -framework Foundation Controllers/CSAIBackgroundSync.m Tests/AIBackgroundSyncTests.m -o "$test_dir/tests"
"$test_dir/tests"
if [[ "${1:-}" == "--ios" ]]; then
 sdk_dir=$(xcrun --sdk iphoneos --show-sdk-path)
 for arch in arm64 arm64e; do
  xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
   -fobjc-arc -fblocks -Wall -Wextra -Werror -IControllers \
   -c Controllers/CSAIBackgroundSync.m -o "$test_dir/scheduler.$arch.o"
 done
 printf 'AI background sync iOS: arm64 + arm64e source objects compiled\n'
fi
