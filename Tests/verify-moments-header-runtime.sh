#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-header-runtime.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import os, sys
project, output = map(Path, sys.argv[1:])
source = Path(os.environ.get('CS_MOMENTS_HEADER_RUNTIME_SOURCE', project / 'Controllers/CSMomentsLayoutRuntime.m')).read_text()
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
(output / 'MomentsHeaderRuntimeMethod.h').write_text(body('- (void)updateHeaderBackdrop {')+'\n'+body('- (void)layoutHeaderViewport {'))
(output / 'MomentsNativeHeaderInset.h').write_text(body('static CGFloat NativeHeaderTopInset('))
(output / 'MomentsHeaderSupplementMethod.h').write_text(body('- (void)layoutSubviews {'))
(output / 'MomentsHeaderRuntimeHooks.h').write_text('\n'.join(body(marker) for marker in [
    'static void RefreshHeaderBackdrop(', 'static void HookHeaderBackdrop(']))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Tests/MomentsHeaderRuntimeTests.m" -o "$test_dir/tests"
"$test_dir/tests"
