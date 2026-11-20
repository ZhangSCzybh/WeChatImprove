#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
out=Path(sys.argv[1])
def body(source,marker):
    start=source.index(marker); brace=source.index('{',start); depth=0
    for end in range(brace,len(source)):
        if source[end]=='{': depth+=1
        elif source[end]=='}':
            depth-=1
            if not depth: return source[start:end+1]
    raise RuntimeError(marker)
source=Path('Controllers/CSCloseFriendBridge.m').read_text()
(out/'ContactReadBodies.h').write_text('\n'.join(body(source,m) for m in ['id CSCloseFriendRead(', 'NSString *CSCloseFriendUserName(']))
source=Path('Controllers/CSCloseFriendContactAdapter.m').read_text()
(out/'TagSummaryBodies.h').write_text('\n'.join(body(source,m) for m in ['NSArray *CSCFVisible(', 'NSArray<NSString *> *CSCFContactNames(', 'BOOL CSCFCallVoid(', 'BOOL CSCFSetObject(', 'static NSString *TagMemberCountText(', 'void CSCFUpdateTagSummary(']))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
    -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendSignatures.m \
    Controllers/CSCloseFriendContactProjection.m Tests/CloseFriendTagSummaryTests.m -o "$work/tests"
"$work/tests"
