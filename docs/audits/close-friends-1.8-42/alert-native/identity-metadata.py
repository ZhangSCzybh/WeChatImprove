"""Read-only property metadata and exact group-selector inventory.

This does not load the target or execute Objective-C initializers. Property
metadata with dynamic accessors must still be checked against runtime method
signatures before an implementation calls it.
"""
import json
from pathlib import Path

base = Path(__file__).resolve().parent
scope = {'__file__': str(base / 'analyze.py')}
exec((base / 'analyze.py').read_text().split("\nif sys.argv[1]")[0], scope)
classes, methods, ptr, pos, u64, u32, string = [scope[k] for k in
    ('classes', 'methods', 'ptr', 'pos', 'u64', 'u32', 'string')]
rows = []
for name in ('VoIPMtInviteMsg', 'ConfRecvInviteInfo', 'VoIPInvitationInfo', 'MultiTalkMonoMsg'):
    cl = int(classes[name], 16)
    ro = pos(ptr(pos(cl) + 32) & ~7)
    if not u64(ro + 64):
        continue
    props = pos(ptr(ro + 64))
    size, count = u32(props), u32(props + 4)
    for index in range(count):
        entry = props + 8 + size * index
        rows.append({'class': name, 'property': string(ptr(entry)),
                     'attributes': string(ptr(entry + 8))})
(base / 'identity-properties.json').write_text(json.dumps(rows, indent=2) + '\n')
matches, errors = [], []
for name in classes:
    try:
        matches.extend(row for row in methods(name)
                       if row['selector'] in ('mWxGroupId', 'mMultiTalkGroupId', 'mroomid'))
    except Exception as error:
        errors.append({'class': name, 'error': str(error)})
(base / 'group-identity-methods.json').write_text(json.dumps(matches, indent=2) + '\n')
print(json.dumps({'properties': rows, 'matching_methods': matches, 'errors': errors}, indent=2))
