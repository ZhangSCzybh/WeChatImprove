#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
engine_source="${CS_COMPAT_ENGINE_SOURCE:-Controllers/CSBackupEngine.m}"
test_source="${CS_COMPAT_TEST_SOURCE:-Tests/BackupCompatibilityTests.m}"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers \
 -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
 Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m Controllers/CSPluginStorage.m Controllers/CSBackupStore.m \
 Controllers/CSBackupAudit.m Controllers/CSManagedImageFile.m "$engine_source" Controllers/CSBackupMutation.m \
 "$test_source" -o "$work/tests"
"$work/tests" "$@"
