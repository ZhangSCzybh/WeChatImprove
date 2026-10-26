"""Read-only, bounded evidence for the established WeChat 8.0.78 arm64 target."""
from pathlib import Path
import bisect, hashlib, json, re, struct, subprocess

repo = Path(__file__).resolve().parents[4]
out = Path(__file__).resolve().parent
# Reuse only the existing read-only Mach-O reader definitions (not its output loop).
reader = repo / 'docs/evidence/message-actions-native-2026-10-17/extract.py'
exec(reader.read_text().split('\nimport re, subprocess')[0])
assert hashlib.sha256(b).hexdigest() == '0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e'
classes = json.loads((reader.parent / 'classes.json').read_text())
class_names = {int(addr, 16): name for name, addr in classes.items()}
starts, offset = [], 32
for _ in range(u32(16)):
    command, size = struct.unpack_from('<II', b, offset)
    if command == 0x26:
        start, length = struct.unpack_from('<II', b, offset + 8)
        p, address = start, 0x100000000
        while p < start + length:
            value = shift = 0
            while True:
                byte = b[p]; p += 1
                value |= (byte & 127) << shift; shift += 7
                if not byte & 128: break
            if not value: break
            address += value; starts.append(address)
    offset += size
selected = {
    'EmoticonCustomManageAddLogic': ['showSavedTips', 'disableAutoShowSucToast', 'setDisableAutoShowSucToast:'],
    'EmoticonCustomCreateLogic': ['AddEmoticonFinishedWithWrap:IsSuccessed:', 'AddEmoticonFinishedWithWraps:sessionID:'],
    'EmoticonCustomAddResult': ['uploadSuccess', 'setUploadSuccess:'],
}
methods, ivars, output = [], {}, []
for name, selectors in selected.items():
    ro = pos(ptr(pos(int(classes[name], 16)) + 32) & ~7)
    if u64(ro + 48):
        table = pos(ptr(ro + 48)); size, count = struct.unpack_from('<II', b, table)
        for i in range(count):
            entry = table + 8 + i * size
            ivars[ptr(entry)] = {'class': name, 'name': string(ptr(entry + 8)), 'type': string(ptr(entry + 16)), 'offset': u32(pos(ptr(entry)))}
    if not u64(ro + 32): continue
    address = ptr(ro + 32); table = pos(address)
    flags, count = struct.unpack_from('<II', b, table)
    for i in range(count):
        entry = table + 8 + i * (flags & 0xffff)
        if flags & 0x80000000:
            entry_va = address + 8 + i * (flags & 0xffff)
            selector_va = entry_va + i32(entry)
            if not flags & 0x40000000: selector_va = ptr(pos(selector_va))
            selector, imp = string(selector_va), entry_va + 8 + i32(entry + 8)
            types = string(entry_va + 4 + i32(entry + 4))
        else:
            selector, imp, types = string(ptr(entry)), ptr(entry + 16), string(ptr(entry + 8))
        if selector not in selectors: continue
        end = starts[bisect.bisect(starts, imp)]
        methods.append({'class': name, 'selector': selector, 'types': types, 'start': hex(imp), 'endExclusive': hex(end)})
        asm = subprocess.check_output(['xcrun', 'llvm-objdump', '-d', '--start-address=' + hex(imp), '--stop-address=' + hex(end), f.name], text=True)
        output.append(f'=== {name} {selector} ({types}) ===')
        registers = {}
        for line in asm.splitlines():
            match = re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)', line)
            if match: registers[match[1]] = int(match[2], 16)
            match = re.search(r'(?:ldr|ldrsw)\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]', line)
            if match and match[1] in registers:
                reference = registers[match[1]] + int(match[2], 16)
                try:
                    text = (ivars[reference]['name'] if reference in ivars else class_names.get(ptr(pos(reference))) or string(ptr(pos(reference))))
                    if text and len(text) < 180 and all(c.isprintable() for c in text): line += ' ; ' + text
                except (ValueError, struct.error): pass
            output.append(line)
(out / 'methods.json').write_text(json.dumps(methods, indent=2) + '\n')
(out / 'ivars.json').write_text(json.dumps({hex(k): v for k, v in ivars.items()}, indent=2) + '\n')
(out / 'selected-disassembly.txt').write_text('\n'.join(output) + '\n')
print('Methods:', len(methods), 'lines:', len(output))
print('Native success localization:', string(ptr(pos(0x11e5718e8) + 16)))
