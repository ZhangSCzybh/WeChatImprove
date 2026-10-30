#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-publication.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
source=(Path(sys.argv[1])/'Hooks/SessionGroupHooks.xm').read_text()
start=source.index('// BEGIN Session event identity')
end=source.index('// END Session event identity',start)
parts=[source[start:end]]
for signature in ['static void Native(id owner,', 'static void NativeEvent(', 'static void NativeNotification(', 'static void NativeReload(']:
    start=source.index(signature)
    brace=source.index('{',start)
    depth=0
    for end in range(brace,len(source)):
        if source[end]=='{': depth+=1
        elif source[end]=='}':
            depth-=1
            if depth==0: break
    parts.append(source[start:end+1])
(Path(sys.argv[2])/'GroupEventIdentityBody.h').write_text('\n'.join(parts))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSGroupProjection.m" "$project_dir/Controllers/WESessionTabItem.m" \
  "$project_dir/Tests/GroupPublicationPlanTests.m" -o "$test_dir/tests"
"$test_dir/tests"
