#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-quick-panel-background.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -framework Foundation -framework CoreGraphics -framework ImageIO \
  -I"$project_dir/Tests/QuickPanelBackgroundUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Tests/QuickPanelBackgroundUIKit/QuickPanelBackgroundUIKit.m" \
  "$project_dir/Controllers/CSQuickPanelBackgroundView.m" \
  "$project_dir/Controllers/CSQuickPanelPreferences.m" \
  "$project_dir/Controllers/CSQuickPanelBackgroundImageStore.m" \
  "$project_dir/Controllers/CSManagedImageFile.m" \
  "$project_dir/Controllers/CSBackupMutation.m" \
  "$project_dir/Tests/QuickPanelBackgroundTests.m" -o "$test_dir/background-tests"
"$test_dir/background-tests"
