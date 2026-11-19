#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-names.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import os, sys
project, output = map(Path, sys.argv[1:])
source = Path(os.environ.get('CS_MOMENTS_NAMES_SOURCE', project / 'Controllers/CSMomentsLayoutRuntime.m')).read_text()
def body(marker):
    start = source.index(marker)
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{': depth += 1
        elif source[end] == '}':
            depth -= 1
            if not depth: return source[start:end + 1]
    raise ValueError('Unclosed production body: ' + marker)
markers = ['static BOOL Matches(', 'static id Read(', 'static id CurrentService(',
           'static id CurrentFacade(', 'static void ApplyContactRemarks(', 'static BOOL SameCards(']
(output / 'MomentsNamesBodies.h').write_text('\n'.join(body(marker) for marker in markers))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" "$project_dir/Tests/MomentsNamesTests.m" \
  -o "$test_dir/tests"
"$test_dir/tests"
