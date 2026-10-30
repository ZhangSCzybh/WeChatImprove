#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
# These symbols have no place in the passive implementation; validate the compiled source boundary as well as runtime IMPs.
if rg -n 'MSHook|method_setImplementation|method_exchangeImplementations|imp_implementationWithBlock|CSBackupInstallFileProtection|affectsBackup|moveFileToTmpTrash|moveFolderToTmpTrash' Controllers/CSBackupAudit.h Controllers/CSBackupAudit.m; then
    echo 'Passive audit unexpectedly contains interception code' >&2
    exit 1
fi
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics Controllers/CSScheduledTaskStore.m Controllers/CSAIReplyStore.m Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m Controllers/CSBackupStore.m Controllers/CSPluginStorage.m Controllers/CSBackupAudit.m Tests/BackupAuditTests.m -o "$work/tests"
"$work/tests"
