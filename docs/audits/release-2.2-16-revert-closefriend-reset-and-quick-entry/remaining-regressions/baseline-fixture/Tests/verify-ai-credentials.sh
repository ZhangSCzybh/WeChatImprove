#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-credentials.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
from pathlib import Path
import sys
source='#import <Foundation/Foundation.h>\n#import <Security/Security.h>\nOSStatus CSAITestCopyMatching(CFDictionaryRef,CFTypeRef *);\n#define SecItemCopyMatching CSAITestCopyMatching\n#include "'+str(Path('Controllers/CSAICredentialStore.m').resolve())+'"\n'
Path(sys.argv[1],'CredentialStoreUnderTest.m').write_text(source)
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -IControllers \
 -framework Foundation -framework Security "$test_dir/CredentialStoreUnderTest.m" Tests/AICredentialStoreTests.m -o "$test_dir/tests"
"$test_dir/tests"
