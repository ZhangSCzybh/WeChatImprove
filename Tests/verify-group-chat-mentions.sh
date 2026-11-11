#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-mentions.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
 -I"$project_dir/Controllers" \
 "$project_dir/Controllers/CSMessageActionContext.m" "$project_dir/Controllers/CSMessageNativeActionAdapter.m" \
 "$project_dir/Controllers/CSMessageSendAdapter.m" "$project_dir/Controllers/CSGroupChatTemplate.m" \
 "$project_dir/Tests/GroupChatMentionTests.m" -o "$test_dir/group-chat-mention-tests"
"$test_dir/group-chat-mention-tests"
