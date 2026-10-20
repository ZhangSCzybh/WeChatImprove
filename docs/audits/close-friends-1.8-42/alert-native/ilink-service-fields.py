"""Bounded read-only ivar metadata for the two inspected SDK wrappers."""
import json
from pathlib import Path

out = Path(__file__).resolve().parent
scope = {'__file__': str(out / 'analyze.py')}
exec((out / 'analyze.py').read_text().split("\nif sys.argv[1]")[0], scope)
classes, ptr, pos, u64, u32, string = [scope[k] for k in
    ('classes', 'ptr', 'pos', 'u64', 'u32', 'string')]
rows = []
interesting_offsets = {0x120237a08, 0x120237a68, 0x120237b40, 0x120201d00}
for name in ('VoIPConfSDKService', 'MMConfSDKService'):
    cl = int(classes[name], 16)
    ro = pos(ptr(pos(cl) + 32) & ~7)
    if not u64(ro + 48):
        continue
    ivars = pos(ptr(ro + 48))
    size, count = u32(ivars), u32(ivars + 4)
    for i in range(count):
        entry = ivars + 8 + i * size
        offset_storage = ptr(entry)
        if offset_storage not in interesting_offsets:
            continue
        rows.append({'class': name, 'name': string(ptr(entry + 8)),
                     'type': string(ptr(entry + 16)),
                     'offset_storage_address': hex(offset_storage),
                     'instance_offset': u32(pos(offset_storage))})
(out / 'ilink-service-fields.json').write_text(json.dumps(rows, indent=2) + '\n')
print(json.dumps(rows, indent=2))
