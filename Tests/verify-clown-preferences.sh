#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-clown-preferences.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSClownPreferences.m" \
  "$project_dir/Controllers/CSScheduledTaskStore.m" \
  "$project_dir/Controllers/CSAIReplyStore.m" "$project_dir/Controllers/CSAutomationStore.m" "$project_dir/Controllers/CSGroupChatStore.m" "$project_dir/Controllers/CSGroupChatTemplate.m" \
  "$project_dir/Controllers/CSBackupRegistry.m" \
  "$project_dir/Tests/ClownPreferencesTests.m" -o "$test_dir/tests"
"$test_dir/tests"
