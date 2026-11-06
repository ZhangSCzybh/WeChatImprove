#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
source_dir="${1:-$project_dir}"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-privacy-admission.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$source_dir" "$test_dir" "${ADMISSION_PROVENANCE_PATH:-}" <<'PY'
from pathlib import Path
import hashlib,json,subprocess,sys
source,output=map(Path,sys.argv[1:3]);adapter=(source/'Controllers/CSGroupListAdapter.m').read_text()
def method(text,marker):
    start=text.index(marker);opening=text.index('{',start);depth=0
    for end in range(opening,len(text)):
        if text[end]=='{':depth+=1
        elif text[end]=='}':
            depth-=1
            if not depth:return text[start:end+1]
    raise AssertionError(marker)
markers=['- (void)performSessionListLayout:','- (void)invalidateNativeSnapshot']
bodies=[method(adapter,marker) for marker in markers]
(output/'AdmissionProductionBody.h').write_text('\n\n'.join(bodies)+'\n')
shield=(source/'Controllers/CSCloseFriendListShield.m').read_text()
(output/'AdmissionShieldBody.h').write_text('\n'.join(line for line in shield.splitlines() if not line.startswith('#import'))+'\n')
paths=['Controllers/CSGroupListAdapter.m','Controllers/CSGroupProjection.m','Controllers/CSGroupNativeBridge.m','Controllers/CSGroupIndexScope.m','Controllers/CSCloseFriendPolicy.m','Controllers/CSCloseFriendRuntime.m','Controllers/CSCloseFriendListShield.m']
provenance={'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=source,text=True).strip(),'source_sha256':{name:hashlib.sha256((source/name).read_bytes()).hexdigest() for name in paths},'methods':{marker:hashlib.sha256(body.encode()).hexdigest() for marker,body in zip(markers,bodies)},'boundaries':'UIKit table/cells and native source are host doubles; real policy, runtime expiry, projection, safe numeric reader, and index scopes compile unchanged.'}
print('PROVENANCE '+json.dumps(provenance,sort_keys=True))
if sys.argv[3]:
    target=Path(sys.argv[3]);target.parent.mkdir(parents=True,exist_ok=True);target.write_text(json.dumps(provenance,indent=2)+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
 -framework Foundation -framework Security -I"$test_dir" -I"$source_dir/Controllers" \
 "$source_dir/Controllers/CSGroupProjection.m" "$source_dir/Controllers/WESessionTabItem.m" \
 "$source_dir/Controllers/CSGroupNativeBridge.m" "$source_dir/Controllers/CSGroupIndexScope.m" \
 "$source_dir/Controllers/CSCloseFriendPolicy.m" "$source_dir/Controllers/CSCloseFriendRuntime.m" \
 "$source_dir/Controllers/CSCloseFriendStore.m" "$source_dir/Controllers/CSCloseFriendCrypto.m" \
 "$source_dir/Controllers/CSPluginStorage.m" "$project_dir/Tests/PrivacyAdmissionCacheTests.m" \
 -o "$test_dir/admission-tests"
"$test_dir/admission-tests"
