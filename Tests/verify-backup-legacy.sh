#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-backup-legacy.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
  -I"$project_dir/Controllers" "$project_dir/Controllers/CSBackupRegistry.m" \
  "$project_dir/Controllers/CSBackupCodec.m" "$project_dir/Controllers/CSBackupAssets.m" \
  "$project_dir/Controllers/CSBackupLegacyReader.m" "$project_dir/Tests/BackupLegacyTests.m" -o "$test_dir/legacy-tests"
"$test_dir/legacy-tests" "$test_dir/fixtures"
