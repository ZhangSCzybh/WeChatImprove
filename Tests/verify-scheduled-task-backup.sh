#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d "${TMPDIR:-/tmp}/wechat-scheduled-backup.XXXXXX")
trap 'rm -rf "$work"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -IControllers -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
  Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m \
  Controllers/CSPluginStorage.m Controllers/CSBackupStore.m Controllers/CSManagedImageFile.m \
  Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m Controllers/CSScheduledTaskStore.m \
  Tests/ScheduledTaskBackupTests.m -o "$work/tests"
"$work/tests" "$work/Library/Preferences/WeChatImprove"
