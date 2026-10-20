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
source=Path('Controllers/CSCloseFriendProfileAdapter.m').read_text()
(out/'ProfilePredicate.h').write_text(body(source,'static BOOL Masked(')+'\n'+body(source,'static NSString *PublicNickname('))
source=Path('Controllers/CSCloseFriendSearchAdapter.m').read_text()
(out/'GroupTitle.h').write_text(body(source,'static NSString *GroupDisplayTitle('))
source=Path('Hooks/CloseFriendProfileHooks.xm').read_text()
(out/'ProfileGuards.h').write_text(body(source,'static void Guard0(')+'\n'+body(source,'static void Guard1('))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
 -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendContactProjection.m \
 Tests/CloseFriendContactTests.m -o "$work/tests"
"$work/tests"
