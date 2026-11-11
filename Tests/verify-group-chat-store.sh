#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-chat-store.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers \
 -Dfsync=CSGroupChatStoreTestFsync -c Controllers/CSGroupChatStore.m -o "$test_dir/store.o"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers \
 -framework Foundation "$test_dir/store.o" Controllers/CSGroupChatTemplate.m Tests/GroupChatStoreTests.m -o "$test_dir/tests"
"$test_dir/tests"
