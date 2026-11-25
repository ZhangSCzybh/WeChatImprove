#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-page-lifecycle.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" "$@" <<'PY'
from pathlib import Path
import sys
root, output = map(Path, sys.argv[1:3])
source = (Path(sys.argv[3]) if len(sys.argv)>3 else root / 'Controllers/CSGroupListAdapter.m').read_text()
methods = []
for marker in [
    '+ (instancetype)adapterForController:(id)controller {',
    '+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller {',
    '+ (void)finishPresentationReturnForController:(id)controller {',
    '- (void)performSessionListLayout:(void (^)(void))layout {',
    '- (NSDictionary *)captureViewportForTabID:(NSString *)tabID {',
    '- (void)prepareInitialViewport {',
    '- (void)cancelInitialViewport {',
    '- (void)restoreInitialViewport {',
    '- (void)clearPendingViewport {',
    '- (BOOL)restoreScrollHeight:(CGFloat)height {',
    '- (void)restorePendingViewport {',
    '- (void)restorePagePreview {',
    '- (void)cancelPageTransition {',
    '- (BOOL)pageTransitionContextIsValid {',
    '- (void)cancelInvalidPageTransition {',
    '- (BOOL)validViewport:(NSDictionary *)viewport {',
    '- (void)preparePageSourceForPan {',
    '- (BOOL)beginSwipePageTransitionToIndex:(NSInteger)index direction:(NSInteger)direction {',
    '- (void)preparePageTransitionForSelection:(NSInteger)index {',
    '- (void)rollbackPageTransitionWithVelocity:(CGFloat)velocity {',
    '- (void)selectSwipeIndex:(NSInteger)index direction:(NSInteger)direction {',
    '- (BOOL)pageTransitionTargetIsReady {',
    '- (void)finishPageTransitionIfReady {',
]:
    start = source.index(marker)
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{': depth += 1
        if source[end] == '}':
            depth -= 1
            if depth == 0:
                method=source[start:end+1]
                for name in ['restoreScrollHeight','restorePendingViewport','cancelInitialViewport']:
                    if marker.startswith('- (BOOL)'+name+':') or marker=='- (void)'+name+' {':
                        method=method.replace(name,name+'UnderTest',1)
                methods.append(method)
                break
    else:
        raise AssertionError('Unclosed production method: ' + marker)
(output / 'GroupPageLifecycleUnderTest.h').write_text('\n'.join(methods) + '\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -I"$test_dir" \
  "$project_dir/Tests/GroupPageLifecycleTests.m" -o "$test_dir/tests"
"$test_dir/tests"
