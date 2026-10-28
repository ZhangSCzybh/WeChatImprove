#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-background-sync.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -IControllers -framework Foundation Controllers/CSAIBackgroundSync.m Tests/AIBackgroundSyncTests.m -o "$test_dir/tests"
"$test_dir/tests"
