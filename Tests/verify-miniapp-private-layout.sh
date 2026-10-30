#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
source_dir="${1:-$project_dir}"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-miniapp-private-layout.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$source_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
project, source, output = map(Path, sys.argv[1:])
# Reuse the baseline session fixture's extraction of complete production methods.
generator = (project/'Tests/verify-close-friend-session.sh').read_text().split("<<'PY'\n", 1)[1].split('\nPY\n', 1)[0]
sys.argv = ['extract-session-fixture', str(source), str(output)]
exec(compile(generator, str(project/'Tests/verify-close-friend-session.sh'), 'exec'), {'__name__':'miniapp_fixture_extractor'})
adapter = (source/'Controllers/CSGroupListAdapter.m').read_text()
hooks = (source/'Hooks/SessionGroupHooks.xm').read_text()
def method(text, marker):
    start = text.index(marker)
    brace = text.index('{', start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == '{': depth += 1
        elif text[end] == '}':
            depth -= 1
            if depth == 0: return text[start:end+1]
    raise AssertionError(marker)
marker = '- (void)performSessionListLayout:'
body = method(adapter, marker) if marker in adapter else '- (void)performSessionListLayout:(void (^)(void))layout { layout(); }'
(output/'MiniappLayoutBody.h').write_text(body+'\n')
refresh=method(adapter,'- (void)refresh {')
release=method(refresh[refresh.index('    } @finally {'):], '        if (finished) {')
(output/'MiniappPublicationRelease.h').write_text('- (void)finishPublicationFixture { BOOL finished=YES; '+release+' }\n')
main_table = hooks.split('%hook MainFrameTableView\n', 1)[1].split('%end', 1)[0]
marker = '- (void)layoutSubviews {'
body = method(main_table, marker) if marker in main_table else marker+' %orig; }'
(output/'MiniappTableLayoutHook.h').write_text(body.replace('%orig', '[self captureLayout]')+'\n')
(output/'MiniappCardPosition.h').write_text(method(adapter, 'BOOL CSGroupCardPosition(')+'\n')
(output/'MiniappShieldBody.h').write_text('\n'.join(line for line in (source/'Controllers/CSCloseFriendListShield.m').read_text().splitlines() if not line.startswith('#import'))+'\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-undeclared-selector \
 -Wno-unused-function -framework Foundation -framework CoreGraphics \
 -I"$test_dir" -I"$project_dir/Controllers" -I"$project_dir/Tests" \
 "$test_dir/MeasuredProjection.m" "$source_dir/Controllers/WESessionTabItem.m" \
 "$source_dir/Controllers/CSGroupInvocationMapper.m" "$source_dir/Controllers/CSGroupNativeBridge.m" \
 "$source_dir/Controllers/CSGroupIndexScope.m" "$source_dir/Controllers/CSCloseFriendPolicy.m" \
 "$source_dir/Controllers/CSCloseFriendSignatures.m" "$project_dir/Tests/MiniappPrivateLayoutTests.m" \
 -o "$test_dir/miniapp-tests"
"$test_dir/miniapp-tests"
