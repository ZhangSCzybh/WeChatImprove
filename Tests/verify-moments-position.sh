#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-position.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import os, sys
project, output = map(Path, sys.argv[1:])
source = Path(os.environ.get('CS_MOMENTS_POSITION_SOURCE', project / 'Controllers/CSMomentsLayoutRuntime.m')).read_text()
def body(marker):
    start = source.index(marker)
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{':
            depth += 1
        elif source[end] == '}':
            depth -= 1
            if not depth:
                return source[start:end + 1]
    raise ValueError('Unclosed production body: ' + marker)
(output / 'MomentsPositionInsets.h').write_text(body('static UIEdgeInsets TimelineInsets('))
(output / 'MomentsPositionBodies.h').write_text('\n'.join(body(marker) for marker in [
    '- (void)clearPresentation {', '- (void)forgetPosition {', '- (void)resumePresentation {', '- (void)capturePosition {',
    '- (void)restorePosition {', '- (void)collectionView:(UICollectionView *)view didSelectItemAtIndexPath:']))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -framework CoreGraphics -I"$test_dir" \
  "$project_dir/Tests/MomentsPositionTests.m" -o "$test_dir/tests"
"$test_dir/tests"
