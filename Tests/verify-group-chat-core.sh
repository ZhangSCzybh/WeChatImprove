#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-core.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -framework Foundation \
 -I"$project_dir/Controllers" \
 "$project_dir/Controllers/CSGroupChatTemplate.m" "$project_dir/Controllers/CSGroupChatStore.m" \
 "$project_dir/Controllers/CSGroupChatEventPolicy.m" "$project_dir/Tests/GroupChatCoreTests.m" \
 -o "$test_dir/group-chat-core-tests"
"$test_dir/group-chat-core-tests" "$test_dir/fixtures"
