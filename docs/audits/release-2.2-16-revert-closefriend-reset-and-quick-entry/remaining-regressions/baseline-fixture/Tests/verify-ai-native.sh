#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-native.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
import sys
from pathlib import Path
source=Path('Controllers/CSMessageNativeActionAdapter.m').read_text().split('@interface NSObject (CSNativeAppPath)',1)[0]
Path(sys.argv[1],'AINativeDispatchUnderTest.m').write_text(source)
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
 -ITests/AIDetailUIKit -IControllers -I"$test_dir" -framework Foundation \
 Controllers/CSAIReplyStore.m Controllers/CSAIMessageAdapter.m Controllers/CSAIChatDetailAdapter.m Tests/AIReplyNativeTests.m -o "$test_dir/tests"
"$test_dir/tests" "$test_dir/state.plist"
