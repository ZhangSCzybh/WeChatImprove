#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-badges.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
# Optional pre-fix projection provides a reproducible red/green control.
projection_source="${1:-$project_dir/Controllers/CSGroupProjection.m}"
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, out = map(Path, sys.argv[1:])
source = (root/'Controllers/WESessionTabContainerView.m').read_text()
for name, marker in [('Badge', '- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot {'),
                     ('Container', '- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot forTabIndex:')]:
    start=source.index(marker); brace=source.index('{', start); depth=0
    for end in range(brace, len(source)):
        if source[end]=='{': depth+=1
        elif source[end]=='}':
            depth-=1
            if not depth: break
    (out/(name+'Body.h')).write_text(source[start:end+1])
source = (root/'Controllers/CSGroupListAdapter.m').read_text()
start=source.index('        id logic=CSGroupReadObject(self.controller,@"m_mainFrameLogicController");', source.index('- (void)refresh {'))
end=source.index('        [self layout];',start)
(out/'PublicationBody.h').write_text('- (void)publish:(CSGroupProjection *)projection tabs:(NSArray *)tabs privacy:(BOOL)privacy {\n'+source[start:end]+'\n}')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-undeclared-selector \
  -framework Foundation -I"$test_dir" -I"$project_dir/Controllers" \
  "$projection_source" "$project_dir/Controllers/CSGroupNativeBridge.m" \
  "$project_dir/Controllers/WESessionTabItem.m" "$project_dir/Tests/GroupBadgeTests.m" -o "$test_dir/tests"
"$test_dir/tests"
