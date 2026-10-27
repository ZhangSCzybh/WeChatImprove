"""Read-only bounded Objective-C metadata inventory for ChatBox presentation.

The root task first bound the supplied WeChat artifact with REA. REA's native
metadata snapshot rejected its size; this reuses the existing mmap parser
without executing any previous inventory writer or launching the target.
"""
from pathlib import Path
import json, struct, bisect, hashlib

root = Path(__file__).resolve().parents[4]
source = (root / 'docs/evidence/close-friends-native-2026-10-20/extract.py').read_text()
exec(source.split('import re,subprocess,hashlib,bisect')[0])
exec('starts=[]' + source.split('starts=[]', 1)[1].split('rows=[];missing=[]', 1)[0])
classes = json.loads((root / 'docs/evidence/message-actions-native-2026-10-17/classes.json').read_text())
selected = ['ChatBoxMgr', 'ChatBoxUtil', 'SessionBox', 'NewMainFrameViewController',
            'MainFrameLogicController', 'MainFrameCellData', 'MainFrameCellDataManager',
            'MainFrameAggregationCell', 'NewMainFrameCell', 'MainFrameItemView']
rows = []
for name in selected:
    ca = int(classes[name], 16)
    for kind, cl in [('instance', ca), ('class', ptr(pos(ca)))]:
        rp = pos(ptr(pos(cl) + 32) & ~7)
        if not u64(rp + 32):
            continue
        ml = ptr(rp + 32); mp = pos(ml)
        flags, count = struct.unpack_from('<II', b, mp)
        for n in range(count):
            en = mp + 8 + n * (flags & 0xffff)
            ev = ml + 8 + n * (flags & 0xffff)
            if flags & 0x80000000:
                sa = ev + i32(en)
                if not flags & 0x40000000:
                    sa = ptr(pos(sa))
                sel = string(sa); imp = ev + 8 + i32(en + 8)
                typ = string(ev + 4 + i32(en + 4))
            else:
                sel = string(ptr(en)); imp = ptr(en + 16); typ = string(ptr(en + 8))
            idx = bisect.bisect_right(starts, imp)
            rows.append(dict(cls=name, kind=kind, selector=sel, address=hex(imp),
                             end=hex(starts[idx]), types=typ))
out = Path(__file__).parent
(out / 'methods.json').write_text(json.dumps(rows, indent=2) + '\n')
digest = hashlib.sha256()
with open('/tmp/wechat-8.0.78-inset-analysis/WeChat', 'rb') as target:
    for block in iter(lambda: target.read(1024 * 1024), b''):
        digest.update(block)
assert digest.hexdigest() == '0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e'
print(json.dumps(dict(methods=len(rows), classes=selected, sha256=digest.hexdigest())))
