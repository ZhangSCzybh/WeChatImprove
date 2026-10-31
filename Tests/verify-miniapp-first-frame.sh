#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
source_dir="${1:-$project_dir}"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-miniapp-first-frame.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$source_dir" "$test_dir" "${FIRST_FRAME_PROVENANCE_PATH:-}" <<'PY'
from pathlib import Path
import hashlib,json,subprocess,sys
project,source,output=map(Path,sys.argv[1:4]);provenance_path=sys.argv[4]
# Reuse the unmodified fixture generators, then extract the actual visibility
# boundaries and gate. An absent 2.2-2 gate is its existing no-op behavior.
generator=(project/'Tests/verify-miniapp-private-layout.sh').read_text().split("<<'PY'\n",1)[1].split('\nPY\n',1)[0]
sys.argv=['extract-miniapp-fixture',str(project),str(source),str(output)]
exec(compile(generator,str(project/'Tests/verify-miniapp-private-layout.sh'),'exec'),{'__name__':'first_frame_fixture_extractor'})
(output/'MiniappFirstFrameBase.h').write_text((project/'Tests/MiniappPrivateLayoutTests.m').read_text().replace('int main(void)', 'int CSUnusedMiniappLayoutFixtureMain(void)'))
session_fixture=(project/'Tests/CloseFriendSessionTests.m').read_text()
snapshot_provider='static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return policy; }'
assert session_fixture.count(snapshot_provider)==1
(output/'CloseFriendSessionTests.m').write_text(session_fixture.replace(snapshot_provider,'static void (^firstFrameSnapshotRead)(void);\nstatic CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { if(firstFrameSnapshotRead)firstFrameSnapshotRead(); return policy; }'))
adapter=(source/'Controllers/CSGroupListAdapter.m').read_text()
hooks=(source/'Hooks/SessionGroupHooks.xm').read_text()
def method(text,marker):
    start=text.index(marker);brace=text.index('{',start);depth=0
    for end in range(brace,len(text)):
        if text[end]=='{':depth+=1
        elif text[end]=='}':
            depth-=1
            if not depth:return text[start:end+1]
    raise AssertionError(marker)
bodies=[]
for marker,fallback in [
    ('+ (void)prepareForListVisibility {', '+ (void)prepareForListVisibility {}'),
    ('- (void)prepareForVisibility {', '- (void)prepareForVisibility {}'),
]:
    bodies.append(method(adapter,marker) if marker in adapter else fallback)
(output/'FirstFrameGateBodies.h').write_text('\n'.join(bodies)+'\n')
entries=[
 ('WAAppDismissAnimateTransition','- (void)animateTransition:', '- (void)animateTransition:(id)context { (void)context; %orig; }'),
 ('WAAppTansitionController','- (void)onMiniTaskDismissalGestureWillBegin', '- (void)onMiniTaskDismissalGestureWillBegin { %orig; }'),
 ('WAAppTansitionController','- (void)sheetDismissalTransitionWillBegin:', '- (void)sheetDismissalTransitionWillBegin:(id)context { (void)context; %orig; }'),
]
hook_bodies=[]
for cls,marker,fallback in entries:
    chunk=hooks.split('%hook '+cls+'\n',1)[1].split('%end',1)[0] if '%hook '+cls+'\n' in hooks else ''
    body=method(chunk,marker) if marker in chunk else fallback
    if ':' in marker:
        brace=body.index('{');declaration=body[:brace]
        # Real transition protocols are UIKit-only; retain selector/body and use
        # id for the host protocol type. The argument is deliberately inert.
        import re
        declaration=re.sub(r'\(id<[^>]+>\)', '(id)', declaration)
        body=declaration+body[brace:]
    hook_bodies.append((cls,body.replace('%orig','[self captureOriginal]')))
(output/'FirstFrameAnimatorHook.h').write_text(hook_bodies[0][1]+'\n')
(output/'FirstFrameContainerHooks.h').write_text('\n'.join(b for c,b in hook_bodies[1:])+'\n')
paths=['Controllers/CSGroupListAdapter.m','Hooks/SessionGroupHooks.xm','Controllers/CSCloseFriendListShield.m','Controllers/CSGroupProjection.m','Controllers/CSCloseFriendPolicy.m']
provenance={'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=project,text=True).strip(),'source_sha256':{p:hashlib.sha256((source/p).read_bytes()).hexdigest() for p in paths},'gate_bodies_sha256':[hashlib.sha256(b.encode()).hexdigest() for b in bodies],'new_gate_present':'- (void)prepareForVisibility' in adapter,'boundaries':'Complete production table layout/projection/cell/index-scope/gate/hook bodies; UIKit visibility and native callbacks are host doubles. Policy mutation injection changes only the temporary snapshot provider, never production sources. No natural device lifecycle or screen frame is measured.'}
print('PROVENANCE '+json.dumps(provenance,sort_keys=True))
if provenance_path:
    Path(provenance_path).write_text(json.dumps(provenance,indent=2)+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-undeclared-selector \
 -Wno-unused-function -Wno-unused-parameter -framework Foundation -framework CoreGraphics \
 -I"$test_dir" -I"$project_dir/Controllers" -I"$project_dir/Tests" \
 "$test_dir/MeasuredProjection.m" "$source_dir/Controllers/WESessionTabItem.m" \
 "$source_dir/Controllers/CSGroupInvocationMapper.m" "$source_dir/Controllers/CSGroupNativeBridge.m" \
 "$source_dir/Controllers/CSGroupIndexScope.m" "$source_dir/Controllers/CSCloseFriendPolicy.m" \
 "$source_dir/Controllers/CSCloseFriendSignatures.m" "$project_dir/Tests/MiniappFirstFrameTests.m" \
 -o "$test_dir/first-frame-tests"
"$test_dir/first-frame-tests"
