#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-entry.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import os, sys
project, output = map(Path, sys.argv[1:])
source = Path(os.environ.get('CS_MOMENTS_ENTRY_SOURCE', project / 'Controllers/CSMomentsLayoutRuntime.m')).read_text()
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
(output / 'MomentsEntryUpdate.h').write_text(body('- (void)update {'))
(output / 'MomentsEntryLifecycle.h').write_text(body('- (void)clearPresentation {')+'\n'+body('- (void)resumePresentation {'))
(output / 'MomentsEntryDisappear.h').write_text(body('IMP disappearedIMP=imp_implementationWithBlock(')+');\n')
(output / 'MomentsEntryHook.h').write_text(body('static void Hook0('))
line = next(line for line in source.splitlines() if 'Hook0(@"viewDidLoad"' in line)
(output / 'MomentsEntryRegistration.h').write_text(line+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics -I"$test_dir" \
  "$project_dir/Tests/MomentsEntryTests.m" -o "$test_dir/tests"
"$test_dir/tests"
