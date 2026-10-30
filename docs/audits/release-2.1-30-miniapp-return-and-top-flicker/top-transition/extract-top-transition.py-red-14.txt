"""Exact hook/function bodies; only definition names change for host observers.

The original MMTableViewCell layout implementation is an explicit controlled
input block. No assumption is made that the device changes content containers.
"""
from pathlib import Path
import sys

root = Path(__file__).resolve().parent.parent
out = Path(sys.argv[1])
sources = Path(sys.argv[2]) if len(sys.argv) > 2 else root
hooks = (sources / 'Hooks/ListCornerRadiusHooks.xm').read_text()

def method(text, marker):
    start = text.index(marker)
    brace = text.index('{', start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == '{':
            depth += 1
        elif text[end] == '}':
            depth -= 1
            if not depth:
                return text[start:end + 1]
    raise ValueError(marker)

chunk = hooks.split('%hook MMTableViewCell\n', 1)[1].split('%end', 1)[0]
body = method(chunk, '- (void)layoutSubviews').split('{', 1)[1].rsplit('}', 1)[0]
assert body.count('%orig') == 1
out.write_text('static void TopTransitionMMCellLayout(id self, void (^original)(void)) {' +
               body.replace('%orig;', 'original();') + '}\n')
renderer = (sources / 'Controllers/CSListCornerRenderer.m').read_text()
for old, new in [('void CSListApplyCardBackground(', 'void TopRealApplyCardBackground('),
                 ('BOOL CSListRefreshCardBackground(', 'BOOL TopRealRefreshCardBackground(')]:
    assert renderer.count(old) == 1
    renderer = renderer.replace(old, new, 1)
out.with_name('TopTransitionRenderer.m').write_text(renderer)
