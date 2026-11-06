#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-store-async.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
from pathlib import Path
import sys
Path(sys.argv[1],'AIStoreUnderTest.m').write_text('#import <Foundation/Foundation.h>\n#include <unistd.h>\nint CSAIAsyncFsync(int);\n#define fsync(...) CSAIAsyncFsync(__VA_ARGS__)\n#include "'+str(Path('Controllers/CSAIReplyStore.m').resolve())+'"\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
 -DCSAI_STORE_TRACK_MUTATIONS=1 -IControllers -framework Foundation \
 "$test_dir/AIStoreUnderTest.m" Controllers/CSBackupMutation.m Tests/AIReplyStoreAsyncTests.m -o "$test_dir/tests"
"$test_dir/tests"
