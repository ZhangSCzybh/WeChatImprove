#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-moments-runtime.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import os, sys
project, output = map(Path, sys.argv[1:])
source = Path(os.environ.get('CS_MOMENTS_RUNTIME_SOURCE', project / 'Controllers/CSMomentsLayoutRuntime.m')).read_text()
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
markers = ['- (void)configureFooter:(CSMomentsSupplement *)footer {', '- (void)armTimeout {', '- (void)refresh:(UIRefreshControl *)sender {',
           '- (void)loadMore:(id)sender {', '- (void)requestFinished:(BOOL)noMore error:(BOOL)error {']
(output / 'MomentsPagingBodies.h').write_text('\n'.join(body(marker) for marker in markers))
(output / 'MomentsChangedBody.h').write_text(body('IMP changedIMP=imp_implementationWithBlock(') + ');\n')
(output / 'MomentsCompletionBody.h').write_text(body('static void HookCompletion(') + '\n' + body('static void HookNativeFooterCompletion('))
(output / 'MomentsNativeLoadingBody.h').write_text(body('- (BOOL)nativeLoading {').replace('nativeLoading {','nativeLoadingProduction {',1))
(output / 'MomentsDetailRouteBodies.h').write_text(body('static BOOL NativeDetailRouteAvailable(') + '\n' + body('static BOOL HookNativeDetailRoute(') + '\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" "$project_dir/Tests/MomentsRuntimeTests.m" \
  -o "$test_dir/tests"
"$test_dir/tests"
