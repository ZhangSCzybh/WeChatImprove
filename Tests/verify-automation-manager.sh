#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-automation-manager.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-incomplete-implementation \
  -ITests/AIDetailUIKit -IControllers -IHeaders -framework Foundation \
  Controllers/CSAutomationStore.m Controllers/CSBackgroundSyncBudget.m "${CS_AUTOMATION_MANAGER_SOURCE:-Controllers/CSAutomationManager.m}" Tests/AutomationManagerTests.m -o "$test_dir/tests"
"$test_dir/tests" "$test_dir/resources"
"$test_dir/tests" "$test_dir/background" --background
"$test_dir/tests" "$test_dir/dispatch" --dispatch-only
if [[ "${1:-}" == "--ios" ]]; then
  sdk_dir=$(xcrun --sdk iphoneos --show-sdk-path)
  for arch in arm64 arm64e; do
    xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
      -fobjc-arc -fblocks -Wall -Wextra -Werror -IControllers -IHeaders \
      -c "${CS_AUTOMATION_MANAGER_SOURCE:-Controllers/CSAutomationManager.m}" -o "$test_dir/manager.$arch.o"
  done
  printf 'Automation manager iOS: arm64 + arm64e source objects compiled\n'
fi
