#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
 -IControllers -framework Foundation -framework Security \
 Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendCrypto.m Controllers/CSCloseFriendStore.m \
 Controllers/CSCloseFriendAccount.m Controllers/CSCloseFriendRuntime.m Controllers/CSCloseFriendSignatures.m Tests/CloseFriendRuntimeTests.m -o "$work/runtime"
"$work/runtime"
python3 - "$work" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSCloseFriendManager.m').read_text()
start=source.index('- (void)startExpiryTimer {')
opening=source.index('{',start); depth=1; pos=opening+1
while depth:
    depth+=(source[pos]=='{')-(source[pos]=='}'); pos+=1
(Path(sys.argv[1])/'ManagerExpiryUnderTest.h').write_text(source[start:pos])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
 -IControllers -I"$work" -framework Foundation -framework Security \
 Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendCrypto.m Controllers/CSCloseFriendStore.m \
 Controllers/CSCloseFriendRuntime.m Tests/CloseFriendSchedulingTests.m -o "$work/scheduling"
"$work/scheduling"
