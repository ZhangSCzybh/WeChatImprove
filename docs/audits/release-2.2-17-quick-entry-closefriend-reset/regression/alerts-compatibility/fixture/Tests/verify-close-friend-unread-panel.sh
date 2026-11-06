#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
unread_panel_work=$(mktemp -d "${TMPDIR:-/tmp}/wechat-unread-panel.XXXXXX")
trap 'rm -rf "$unread_panel_work"' EXIT
python3 - "$unread_panel_work" <<'PY'
from pathlib import Path
import sys

out = Path(sys.argv[1])

def balanced(source, marker):
    start = source.index(marker)
    opening = source.index('{', start)
    depth, state, pos = 0, 'code', opening
    while pos < len(source):
        char, pair = source[pos], source[pos:pos + 2]
        if state == 'line':
            if char == '\n':
                state = 'code'
        elif state == 'comment':
            if pair == '*/':
                state = 'code'
                pos += 1
        elif state in ('string', 'char'):
            if char == '\\':
                pos += 1
            elif char == ('"' if state == 'string' else "'"):
                state = 'code'
        elif pair == '//':
            state = 'line'
            pos += 1
        elif pair == '/*':
            state = 'comment'
            pos += 1
        elif char == '"':
            state = 'string'
        elif char == "'":
            state = 'char'
        elif char == '{':
            depth += 1
        elif char == '}':
            depth -= 1
            if not depth:
                return source[start:pos + 1]
        pos += 1
    raise AssertionError('Unbalanced production function: ' + marker)

bridge = Path('Controllers/CSCloseFriendBridge.m').read_text()
bridge_helpers = ['id CSCloseFriendRead(', 'NSString *CSCloseFriendUserName(',
                  'BOOL CSCloseFriendInstallHook(']
(out / 'UnreadPanelBridge.inc').write_text('\n'.join(balanced(bridge, marker) for marker in bridge_helpers) + '\n')
contact = Path('Controllers/CSCloseFriendContactAdapter.m').read_text()
surface_helpers = ['BOOL CSCFPageIsCurrent(', 'BOOL CSCFIsClass(', 'BOOL CSCFCallVoid(',
                   'BOOL CSCFSetObject(', 'static void ApplyPendingSurfaceRefresh(',
                   'static BOOL WatchSurfaceAppearance(', 'void CSCFRefreshSurface(']
(out / 'UnreadPanelSurface.inc').write_text(
    'static char PageEpochKey, PendingSurfaceRefreshKey, SurfaceAppearanceHookKey;\n' +
    '\n'.join(balanced(contact, marker) for marker in surface_helpers) + '\n')
adapter = Path('Controllers/CSCloseFriendUnreadPanelAdapter.m').read_text()
(out / 'UnreadPanelAdapter.inc').write_text('\n'.join(line for line in adapter.splitlines() if not line.startswith('#import')) + '\n')
hooks = Path('Hooks/CloseFriendUnreadPanelHooks.xm').read_text()
# Execute the complete production registrations; only the app startup dispatch is
# omitted so this command-line host controls when methods become hooked.
assert '%ctor' in hooks
hooks = hooks[:hooks.index('%ctor')]
(out / 'UnreadPanelHooks.inc').write_text('\n'.join(line for line in hooks.splitlines() if not line.startswith('#import')) + '\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -framework Foundation -IControllers -I"$unread_panel_work" \
 Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendSignatures.m \
 Tests/CloseFriendUnreadPanelTests.m -o "$unread_panel_work/unread-panel-tests"
if [[ "${1:-}" == "--native-control" ]]; then
 CS_TEST_UNREAD_PANEL_UNHOOKED=1 "$unread_panel_work/unread-panel-tests"
else
 "$unread_panel_work/unread-panel-tests"
 xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -DCS_UNREAD_PANEL_ABI=1 \
  -framework Foundation -IControllers -I"$unread_panel_work" \
  Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendSignatures.m \
  Tests/CloseFriendUnreadPanelTests.m -o "$unread_panel_work/unread-panel-abi-tests"
 "$unread_panel_work/unread-panel-abi-tests"
fi
if [[ "${1:-}" == "--ios" ]]; then
 bash Tests/verify-close-friend-ios.sh --unread-panel
fi
