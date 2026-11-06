#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSCloseFriendManager.m').read_text()
extracted=[]
for signature in ['static NSString *CSAccountDigest(', 'static BOOL CSCanCreatePolicyKey(']:
    start=source.index(signature)
    opening=source.index('{',start); depth=1; pos=opening+1
    while depth:
        depth+=(source[pos]=='{')-(source[pos]=='}'); pos+=1
    extracted.append(source[start:pos])
(Path(sys.argv[1])/'ManagerKeyGuardUnderTest.h').write_text('\n'.join(extracted))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -IControllers -I"$work" -framework Foundation -framework Security \
  Controllers/CSPluginStorage.m Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendCrypto.m \
  Controllers/CSCloseFriendStore.m Controllers/CSCloseFriendRuntime.m Tests/CloseFriendMigrationTests.m -o "$work/migration"
"$work/migration"
