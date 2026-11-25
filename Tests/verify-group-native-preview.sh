#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-native-preview.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, output = map(Path, sys.argv[1:])
source = (root / 'Controllers/CSGroupNativeSessionCoordinator.m').read_text()
methods = []
for marker in [
    '- (void)clearPagePreview {',
    '- (BOOL)pagePreviewContextMatchesPolicy:',
    '- (NSString *)effectiveSelectedTabIDForPolicy:',
    '- (BOOL)pagePreviewTokenIsValidForOwner:',
    '- (BOOL)pagePreviewIsValidForOwner:',
    '- (BOOL)beginPagePreviewForTabID:',
    '- (void)endPagePreviewForOwner:',
    '- (NSArray *)modelKeyForPolicy:',
    '- (void)applyBaselineCandidate {',
    '- (void)invalidateNativeData {',
    '- (void)privacyChanged:',
]:
    start = source.index(marker, source.index('@implementation CSGroupNativeSessionCoordinator'))
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{': depth += 1
        if source[end] == '}':
            depth -= 1
            if depth == 0:
                methods.append(source[start:end+1])
                break
    else:
        raise AssertionError('Unclosed production method: ' + marker)
(output / 'GroupNativePreviewUnderTest.h').write_text('\n'.join(methods) + '\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -I"$test_dir" \
  "$project_dir/Tests/GroupNativePreviewTests.m" -o "$test_dir/tests"
"$test_dir/tests"
