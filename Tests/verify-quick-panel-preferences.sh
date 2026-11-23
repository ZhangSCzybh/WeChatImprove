#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-quick-panel-preferences.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -framework Foundation -framework ImageIO -framework CoreGraphics \
    -I"$project_dir/Controllers" \
    "$project_dir/Controllers/CSQuickPanelPreferences.m" \
    "$project_dir/Controllers/CSQuickPanelBackgroundImageStore.m" \
    "$project_dir/Controllers/CSManagedImageFile.m" \
    "$project_dir/Controllers/CSBackupMutation.m" \
    "$project_dir/Tests/QuickPanelPreferencesTests.m" -o "$test_dir/preferences"
"$test_dir/preferences"
