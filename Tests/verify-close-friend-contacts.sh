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
(out/'ProfilePredicate.h').write_text(body(source,'static BOOL Masked('))
start=source.index('@interface CSCFProfileAssistBinding')
end=source.index('static char ProfileKey',start)
(out/'ProfileBindingClass.h').write_text(source[start:end])
(out/'ProfileBindings.h').write_text(body(source,'void CSCFProfileBind(')+'\n'+body(source,'BOOL CSCFProfileBlocksAction(')+'\n'+body(source,'void CSCFProfileWithNativePresentation(')+'\n'+body(source,'BOOL CSCFProfileUsesNativeStranger('))
source=Path('Controllers/CSCloseFriendContactAdapter.m').read_text()
(out/'ForwardBodies.h').write_text('\n'.join(body(source,marker) for marker in ['BOOL CSCFPageIsCurrent(', 'static BOOL SetPresentationBuffer(', 'void CSCFRefreshForwardSearch(', 'void CSCFForwardSearchWillUpdate(', 'void CSCFForwardSearchDidUpdate(']))
source=Path('Controllers/CSCloseFriendSearchAdapter.m').read_text()
(out/'GroupTitle.h').write_text('\n'.join(body(source,m) for m in ['id CSCFSearchModel(', 'NSArray *CSCFSearchVisibleRows(', 'static NSString *GroupDisplayTitle(']))
(out/'SearchInputBodies.h').write_text(body(source,'BOOL CSCFSearchConsumePassword(')+'\n'+body(Path('Hooks/CloseFriendSearchHooks.xm').read_text(),'static void DispatchSearchInput('))
source=Path('Hooks/CloseFriendProfileHooks.xm').read_text()
(out/'ProfileGuards.h').write_text(body(source,'static void Guard0(')+'\n'+body(source,'static void Guard1(')+'\n'+body(source,'static void Render0(')+'\n'+body(source,'static void DisplayFlag('))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
 -IControllers -I"$work" Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendContactProjection.m \
 Tests/CloseFriendContactTests.m -o "$work/tests"
"$work/tests"
