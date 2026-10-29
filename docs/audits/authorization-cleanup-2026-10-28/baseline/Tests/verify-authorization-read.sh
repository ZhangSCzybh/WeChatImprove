#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-authorization-read.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
import sys
from pathlib import Path

source = Path('Controllers/CSAuthorizationManager.m').read_text()
prefix, marker, _ = source.partition('- (void)requestAuthorizationWithPresentingViewController:')
assert marker, 'Authorization implementation boundary changed; update the test extraction.'
prefix = prefix.replace('#import "../Headers/WCHeaders.h"\n', '')
Path(sys.argv[1], 'AuthorizationReadUnderTest.m').write_text(prefix + '\n@end\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-incomplete-implementation \
    -ITests/AIDetailUIKit -IControllers -I"$test_dir" -framework Foundation \
    Tests/AuthorizationReadTests.m -o "$test_dir/tests"
"$test_dir/tests"
