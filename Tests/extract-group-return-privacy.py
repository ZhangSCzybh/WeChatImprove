"""Replay production visible-layout, projection, and cell delivery boundaries.

The old-release control lacks performVisibleLayout/layoutSubviews interception;
its fallback is the actual old behavior: UIKit original layout runs as-is.
"""
from pathlib import Path
import sys
root = Path(__file__).resolve().parent.parent
source = (Path(sys.argv[2]) if len(sys.argv) > 2 else root / 'Controllers/CSGroupListAdapter.m').read_text()
hooks = (Path(sys.argv[3]) if len(sys.argv) > 3 else root / 'Hooks/SessionGroupHooks.xm').read_text()
out = Path(sys.argv[1])
def method(text, marker):
    start = text.index(marker)
    brace = text.index('{', start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == '{': depth += 1
        elif text[end] == '}':
            depth -= 1
            if depth == 0: return text[start:end + 1]
    raise AssertionError(marker)
markers = ['static BOOL CSGroupPrivacyActive(', '- (CSGroupProjection *)projectionForSections:',
           '- (BOOL)accountMatches', '- (NSIndexPath *)currentPathForRow:',
           '- (NSIndexPath *)nativePath:', '- (NSIndexPath *)displayPath:',
           '- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target {', '- (void)forwardInvocation:(NSInvocation *)inv target:(id)target {',
           '- (void)publishProjection:', '- (void)shieldVisiblePrivateRows {']
visible = '- (void)performVisibleLayout:'
bodies = [method(source, marker) for marker in markers]
privacy = bodies.pop(0)
if visible in source: bodies.append(method(source, visible))
else: bodies.append('- (void)performVisibleLayout:(void (^)(void))layout { if (layout) layout(); }')
out.with_name('GroupReturnPrivacyActive.h').write_text(privacy + '\n')
out.write_text('\n\n'.join(bodies) + '\n')
native = method(hooks, 'static void Native(')
out.with_name('GroupReturnPrivacyNative.h').write_text(native + '\n')
section = hooks.split('%hook MainFrameTableView', 1)[1].split('%end', 1)[0]
body = method(section, '- (void)layoutSubviews {') if '- (void)layoutSubviews {' in section else '- (void)layoutSubviews { %orig; }'
body = body.split('{', 1)[1].rsplit('}', 1)[0].replace('%orig', 'original()')
out.with_name('GroupReturnPrivacyLayout.h').write_text('static void HookMainFrameLayout(id self,void (^original)(void)) { (void)self; ' + body + ' }\n')

shield=(root / 'Controllers/CSCloseFriendListShield.m').read_text()
out.with_name('GroupReturnPrivacyShield.h').write_text('\n'.join(line for line in shield.splitlines() if not line.startswith('#import')) + '\n')
