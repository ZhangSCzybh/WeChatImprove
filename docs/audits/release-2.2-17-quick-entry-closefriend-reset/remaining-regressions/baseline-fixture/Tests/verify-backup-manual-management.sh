#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics Controllers/CSScheduledTaskStore.m Controllers/CSAIReplyStore.m Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m Controllers/CSPluginStorage.m Controllers/CSBackupStore.m Tests/BackupManualManagementTests.m -o "$work/tests"
"$work/tests"
