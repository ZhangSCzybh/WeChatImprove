#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-forward-selection-boundary.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" "${1:-}" <<'PYEXTRACT'
from pathlib import Path
import subprocess,sys
root,out=map(Path,sys.argv[1:3])
def body(source,marker):
    start=source.index(marker); brace=source.index('{',start); depth=0
    for end in range(brace,len(source)):
        if source[end]=='{': depth+=1
        elif source[end]=='}':
            depth-=1
            if not depth: return source[start:end+1]
    raise AssertionError(marker)
bridge=(root/'Controllers/CSCloseFriendBridge.m').read_text()
adapter=(root/'Controllers/CSCloseFriendContactAdapter.m').read_text()
pieces=[body(bridge,name) for name in ('id CSCloseFriendRead(', 'NSString *CSCloseFriendUserName(')]
pieces.extend(body(adapter,name) for name in ('BOOL CSCFIsClass(', 'BOOL CSCFCallVoid(', 'void CSCFBeginSelection(', 'void CSCFCancelSelection(', 'NSArray *CSCFCurrentForwardRecipients(', 'BOOL CSCFAllowSelection('))
(out/'ForwardSelectionProductionBodies.h').write_text('\n'.join(pieces))
hook_source=(subprocess.check_output(['git','show','HEAD:Hooks/CloseFriendContactHooks.xm'],cwd=root,text=True)
             if sys.argv[3]=='--baseline' else (root/'Hooks/CloseFriendContactHooks.xm').read_text())
hook=body(hook_source,'for(NSString *name in @[@"onMultiDone",@"onMultiDoneInPageSheetMode"])')
(out/'ForwardSelectionHooksUnderTest.h').write_text('static void InstallForwardSelectionBoundaryHooks(void) {\n'+hook+');\n}\n')
PYEXTRACT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendPolicy.m" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Controllers/CSCloseFriendContactProjection.m" \
  "$project_dir/Tests/ForwardSelectionBoundaryTests.m" -o "$test_dir/tests"
"$test_dir/tests"
