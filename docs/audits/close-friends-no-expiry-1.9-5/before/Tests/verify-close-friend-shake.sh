#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
out=Path(sys.argv[1])
source=Path('Controllers/CSCloseFriendManager.m').read_text()
start=source.index('- (BOOL)canLockForShake {')
end=source.index('- (void)startExpiryTimer {',start)
(out/'ManagerShakeUnderTest.h').write_text(source[start:end])
source=Path('Hooks/CloseFriendLifecycleHooks.xm').read_text()
start=source.index('static void (*CSMotionEndedOriginal)')
(out/'ShakeHooksUnderTest.h').write_text(source[start:source.index('%ctor',start)])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -ITests/ShakeStubs -IControllers -I"$work" \
 Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendShakeMonitor.m \
 Tests/CloseFriendShakeTests.m -o "$work/tests"
python3 - "$work/tests" <<'PY'
import subprocess,sys
subprocess.run([sys.argv[1]],check=True,timeout=20)
PY
