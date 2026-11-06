#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-backup-codec.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
sources=("$project_dir/Controllers/CSBackupCodec.m" "$project_dir/Controllers/CSBackupAssets.m")
sources+=("$project_dir/Controllers/CSScheduledTaskStore.m" "$project_dir/Controllers/CSAIReplyStore.m")
if [[ -f "$project_dir/Controllers/CSBackupRegistry.m" ]]; then sources+=("$project_dir/Controllers/CSBackupRegistry.m"); fi
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics -I"$project_dir/Controllers" "${sources[@]}" "$project_dir/Tests/BackupCodecTests.m" -o "$test_dir/tests"
"$test_dir/tests"
