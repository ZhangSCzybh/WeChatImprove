#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-managed-image-files.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
flags=(-fobjc-arc -fblocks -Wall -Wextra -Werror -I"$project_dir/Controllers")
xcrun --sdk macosx clang "${flags[@]}" -Dunlinkat=CSManagedImageTestUnlinkAt \
    -c "$project_dir/Controllers/CSManagedImageFile.m" -o "$test_dir/managed-image.o"
xcrun --sdk macosx clang "${flags[@]}" -framework Foundation \
    "$test_dir/managed-image.o" "$project_dir/Tests/ManagedImageFileTests.m" -o "$test_dir/tests"
"$test_dir/tests" "$test_dir/fixtures"
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
source = (Path(sys.argv[1]) / "Controllers/CSTabBarStyleSettingsViewController.m").read_text()
start = source.index("- (void)clearCustomIcon {")
end = source.index("\n- (NSString *)iconKeyForType:", start)
methods = source[start:end]
source = (Path(sys.argv[1]) / "Controllers/CSNavigationTitleSettingsViewController.m").read_text()
start = source.index("- (void)saveSeparatorImage:(UIImage *)image {")
end = source.index("\n// 设置cell的背景色", start)
(Path(sys.argv[2]) / "ManagedImageCleanupMethods.inc").write_text(methods + "\n" + source[start:end])
PY
xcrun --sdk macosx clang "${flags[@]}" -Wno-deprecated-declarations -I"$test_dir" \
    -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
    "$project_dir/Controllers/CSManagedImageFile.m" \
    "$project_dir/Controllers/CSPluginStorage.m" "$project_dir/Controllers/CSBackupStore.m" "$project_dir/Controllers/CSBackupCodec.m" \
    "$project_dir/Controllers/CSBackupRegistry.m" "$project_dir/Controllers/CSBackupAssets.m" \
    "$project_dir/Tests/ManagedImageCleanupIntegrationTests.m" -o "$test_dir/integration"
"$test_dir/integration" "$test_dir/integration-fixtures"
