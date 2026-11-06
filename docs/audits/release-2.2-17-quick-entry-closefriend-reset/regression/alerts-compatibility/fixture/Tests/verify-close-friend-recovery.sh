#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
recovery_work=$(mktemp -d)
trap 'rm -rf "$recovery_work"' EXIT
python3 - "$recovery_work" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSCloseFriendManager.m').read_text()
start=source.index('- (void)recovery:')
Path(sys.argv[1],'ManagerRecoveryUnderTest.h').write_text(source[start:source.index('\n@end',start)])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -IControllers -I"$recovery_work" \
 Controllers/CSCloseFriendPolicy.m Tests/CloseFriendRecoveryTests.m -o "$recovery_work/tests"
"$recovery_work/tests"
