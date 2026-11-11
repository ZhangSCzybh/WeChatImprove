#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
restore_image_source="${CS_RESTORE_IMAGE_SOURCE:-Controllers/CSManagedImageFile.m}"
flags=(-fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers)
# Define shims after system headers: Darwin's open declaration has an asm alias
# that otherwise silently bypasses a function-like macro supplied via -D.
cat > "$work/image.m" <<EOF_IMAGE
#import <Foundation/Foundation.h>
#include <fcntl.h>
#include <unistd.h>
int CSRestoreTestOpen(const char *, int, ...);
#define open(...) CSRestoreTestOpen(__VA_ARGS__)
#include "$(pwd)/$restore_image_source"
EOF_IMAGE
cat > "$work/store.m" <<EOF_STORE
#import <Foundation/Foundation.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
int CSRestoreStoreOpen(const char *, int, ...);
int CSRestoreStoreRename(const char *, const char *);
int CSRestoreStoreFsync(int);
#define open(...) CSRestoreStoreOpen(__VA_ARGS__)
#define rename(...) CSRestoreStoreRename(__VA_ARGS__)
#define fsync(...) CSRestoreStoreFsync(__VA_ARGS__)
#include "$(pwd)/Controllers/CSBackupStore.m"
EOF_STORE
xcrun --sdk macosx clang "${flags[@]}" -c "$work/image.m" -o "$work/image.o"
xcrun --sdk macosx clang "${flags[@]}" -c "$work/store.m" -o "$work/store.o"
nm -u "$work/image.o" | rg -q '_CSRestoreTestOpen$'
nm -u "$work/store.o" | rg -q '_CSRestoreStoreOpen$'
xcrun --sdk macosx clang "${flags[@]}" -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics Controllers/CSScheduledTaskStore.m Controllers/CSAIReplyStore.m Controllers/CSGroupChatStore.m Controllers/CSGroupChatTemplate.m Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m Controllers/CSPluginStorage.m Controllers/CSBackupAudit.m Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m Tests/BackupRestorePathTests.m "$work/image.o" "$work/store.o" -o "$work/tests"
"$work/tests" "$@"
