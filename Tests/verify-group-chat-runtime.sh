#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-runtime.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, temporary = map(Path,sys.argv[1:])
source=(root/'Controllers/CSGroupChatRuntime.m').read_text()
(temporary/'CSGroupChatRuntime-under-test.inc').write_text('\n'.join(line for line in source.splitlines() if not line.startswith('#import')))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
 -I"$test_dir" -I"$project_dir/Controllers" \
 "$project_dir/Controllers/CSMessageActionContext.m" "$project_dir/Controllers/CSMessageNativeActionAdapter.m" \
 "$project_dir/Controllers/CSGroupChatEventPolicy.m" "$project_dir/Tests/GroupChatRuntimeTests.m" \
 -o "$test_dir/group-chat-runtime-tests"
"$test_dir/group-chat-runtime-tests"
