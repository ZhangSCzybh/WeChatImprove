#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
flags=(-fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers)
xcrun --sdk macosx clang "${flags[@]}" -Dlinkat=CSMigrationLinkat -Dunlinkat=CSMigrationUnlinkat -c Controllers/CSPluginStorage.m -o "$work/storage.o"
xcrun --sdk macosx clang "${flags[@]}" -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics Controllers/CSScheduledTaskStore.m Controllers/CSAIReplyStore.m Controllers/CSAutomationStore.m Controllers/CSGroupChatStore.m Controllers/CSGroupChatTemplate.m Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m Controllers/CSBackupStore.m Controllers/CSManagedImageFile.m Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m Tests/PluginStorageMigrationTests.m "$work/storage.o" -o "$work/tests"
"$work/tests"
