#!/bin/bash
set -euo pipefail
audit_dir="$(cd "$(dirname "$0")" && pwd)"
project_dir="$(cd "$audit_dir/../../.." && pwd)"
work_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-retention-audit-build.XXXXXX")"
trap 'rm -rf "$work_dir"' EXIT
cd "$project_dir"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -IControllers -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
  Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m \
  Controllers/CSBackupStore.m Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m \
  "$audit_dir/reproduction.m" -o "$work_dir/reproduction"
"$work_dir/reproduction"
