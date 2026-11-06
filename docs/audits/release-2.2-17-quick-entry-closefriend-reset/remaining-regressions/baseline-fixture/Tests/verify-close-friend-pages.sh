#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
out=Path(sys.argv[1])
for name in ['GroupListAdapter','Navigation']:
 source=Path('Controllers/CSCloseFriend'+name+'.m').read_text()
 (out/(name+'.h')).write_text('\n'.join(line for line in source.splitlines() if not line.startswith('#import')))
def body(s,marker):
 start=s.index(marker);brace=s.index('{',start);depth=0
 for end in range(brace,len(s)):
  if s[end]=='{':depth+=1
  elif s[end]=='}':
   depth-=1
   if not depth:return s[start:end+1]
s=Path('Controllers/CSCloseFriendSearchAdapter.m').read_text()
(out/'SearchCell.h').write_text('\n'.join(body(s,m) for m in ['id CSCFSearchModel(', 'static NSString *GroupDisplayTitle(', 'BOOL CSCFSearchRedactsGroupMatch(', 'void CSCFSearchUpdateGroupCell('])+ '\n'+body(Path('Hooks/CloseFriendSearchHooks.xm').read_text(),'static void InstallNativeSearchCell('))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
 -framework Foundation -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendSignatures.m Controllers/CSCloseFriendContactProjection.m \
 Tests/CloseFriendPageTests.m -o "$work/tests"
"$work/tests"
