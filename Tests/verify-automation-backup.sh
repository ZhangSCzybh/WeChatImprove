#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-automation-backup.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers \
 -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
 Controllers/CSScheduledTaskStore.m Controllers/CSAIReplyStore.m Controllers/CSAutomationStore.m Controllers/CSGroupChatStore.m Controllers/CSGroupChatTemplate.m \
 Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m Controllers/CSPluginStorage.m \
 Controllers/CSBackupStore.m Controllers/CSManagedImageFile.m Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m \
 Tests/AutomationBackupTests.m -o "$test_dir/tests"
"$test_dir/tests"
