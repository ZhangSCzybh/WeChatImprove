#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-backup-registry.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$project_dir/Controllers" "$project_dir/Controllers/CSScheduledTaskStore.m" "$project_dir/Controllers/CSBackupRegistry.m" \
  "$project_dir/Tests/BackupRegistryTests.m" -o "$test_dir/registry-tests"
"$test_dir/registry-tests"
