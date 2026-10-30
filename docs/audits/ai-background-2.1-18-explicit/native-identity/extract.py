"""Bounded, read-only native service identity review for WeChat 8.0.78.

The target is never executed. Existing repository metadata supplies class roots;
this script re-decodes selected method/ivar metadata and hashes the target.
"""
import bisect
import hashlib
import json
import mmap
import re
import struct
import subprocess
from pathlib import Path

out = Path(__file__).resolve().parent
repo = out.parents[3]
target = Path('/tmp/wechat-8.0.78-inset-analysis/WeChat')
expected = '0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e'
with target.open('rb') as stream:
    digest = hashlib.file_digest(stream, 'sha256').hexdigest()
if digest != expected:
    raise SystemExit('Target identity mismatch; do not reuse selected addresses')
handle = target.open('rb')
data = mmap.mmap(handle.fileno(), 0, access=mmap.ACCESS_READ)
u32 = lambda offset: struct.unpack_from('<I', data, offset)[0]
u64 = lambda offset: struct.unpack_from('<Q', data, offset)[0]
i32 = lambda offset: struct.unpack_from('<i', data, offset)[0]
segments, sections, starts, imports = [], {}, [], []
offset = 32
for _ in range(u32(16)):
    command, size = struct.unpack_from('<II', data, offset)
    if command == 0x19:
        name = data[offset+8:offset+24].split(b'\0')[0].decode()
        segments.append(struct.unpack_from('<QQQQ', data, offset+24))
        for index in range(u32(offset+64)):
            section = offset+72+80*index
            section_name = data[section:section+16].split(b'\0')[0].decode()
            sections[(name, section_name)] = struct.unpack_from('<QQI', data, section+32)
    if command == 0x26:
        cursor, count = struct.unpack_from('<II', data, offset+8)
        end = cursor+count
        address = 0x100000000
        while cursor < end:
            value, shift = 0, 0
            while True:
                byte = data[cursor]
                cursor += 1
                value |= (byte & 127) << shift
                shift += 7
                if not byte & 128:
                    break
            if not value:
                break
            address += value
            starts.append(address)
    if command == 0x80000034:
        fixup_offset = u32(offset+8)
        _, _, imports_offset, symbols_offset, imports_count, imports_format, _ = struct.unpack_from('<7I', data, fixup_offset)
        for index in range(imports_count):
            if imports_format in (1, 2):
                item = fixup_offset+imports_offset+index*(4 if imports_format == 1 else 8)
                name_offset = u32(item) >> 9
            elif imports_format == 3:
                item = fixup_offset+imports_offset+index*16
                name_offset = u64(item) >> 32
            else:
                raise ValueError('Unsupported chained import format')
            name_start = fixup_offset+symbols_offset+name_offset
            imports.append(data[name_start:data.find(b'\0', name_start)].decode())
    offset += size

def position(address):
    for va, virtual_size, file_offset, file_size in segments:
        if va <= address < va+file_size:
            return file_offset+address-va
    raise ValueError(hex(address))

def pointer(offset):
    value = u64(offset)
    if value >> 63:
        raise ValueError('external bind')
    return 0x100000000+(value & 0xfffffffff)

def string(address):
    cursor = position(address)
    return data[cursor:data.find(b'\0', cursor)].decode(errors='replace')

classes = json.loads((repo/'docs/evidence/message-actions-native-2026-10-17/classes.json').read_text())
class_names = {int(address, 16): name for name, address in classes.items()}
rows, ivars = [], {}
for name in ['NewSyncService', 'MMUserService', 'MMBaseService', 'MMContext', 'MMContextManager', 'MMServiceWrapper', 'CUtility']:
    if name not in classes:
        continue
    class_address = int(classes[name], 16)
    ro = position(pointer(position(class_address)+32) & ~7)
    if u64(ro+48):
        array = position(pointer(ro+48))
        size, count = struct.unpack_from('<II', data, array)
        for index in range(count):
            item = array+8+index*size
            offset_address = pointer(item)
            ivars[offset_address] = {'class': name, 'name': string(pointer(item+8)),
                'type': string(pointer(item+16)), 'offset': u32(position(offset_address))}
    for kind, address in [('instance', class_address), ('class', pointer(position(class_address)))]:
        ro = position(pointer(position(address)+32) & ~7)
        if not u64(ro+32):
            continue
        array_address = pointer(ro+32)
        array = position(array_address)
        flags, count = struct.unpack_from('<II', data, array)
        for index in range(count):
            item = array+8+index*(flags & 0xffff)
            item_address = array_address+8+index*(flags & 0xffff)
            if flags & 0x80000000:
                selector = item_address+i32(item)
                if not flags & 0x40000000:
                    selector = pointer(position(selector))
                implementation = item_address+8+i32(item+8)
                types = string(item_address+4+i32(item+4))
            else:
                selector, implementation = pointer(item), pointer(item+16)
                types = string(pointer(item+8))
            next_index = bisect.bisect_right(starts, implementation)
            rows.append({'class': name, 'kind': kind, 'selector': string(selector),
                'address': hex(implementation), 'end_exclusive': hex(starts[next_index]), 'types': types})
(out/'methods.json').write_text(json.dumps(rows, indent=2)+'\n')
(out/'ivars.json').write_text(json.dumps({hex(k): v for k, v in ivars.items()}, indent=2)+'\n')

def label(address):
    if address in ivars:
        v = ivars[address]
        return 'ivar '+v['class']+'.'+v['name']+' offset='+str(v['offset'])+' type='+v['type']
    raw = u64(position(address))
    if raw >> 63:
        return 'bind '+imports[raw & 0xffffff]
    destination = pointer(position(address))
    if destination in class_names:
        return 'class '+class_names[destination]
    value = string(destination)
    if value and len(value) < 180 and all(c.isprintable() and c != '�' for c in value):
        return 'selector/string '+value
    return None

hierarchies = {}
for name in ['NewSyncService', 'MMUserService', 'MMBaseService', 'MMContext', 'MMServiceWrapper']:
    address, chain = int(classes[name], 16), []
    while address:
        chain.append({'name': class_names.get(address, hex(address)), 'address': hex(address)})
        raw = u64(position(address)+8)
        if not raw:
            break
        if raw >> 63:
            chain.append({'external_bind': imports[raw & 0xffffff]})
            break
        address = pointer(position(address)+8)
    hierarchies[name] = chain
(out/'hierarchies.json').write_text(json.dumps(hierarchies, indent=2)+'\n')
selected = {
    'MMBaseService': ['context', 'isServiceRemoved'],
    'MMContext': ['currentContext', 'activeUserContext', 'userName', 'isUserContext', 'isInvalidContext'],
    'MMContextManager': ['activeUserContext'],
    'MMServiceWrapper': ['initWithServiceObj:', 'forwardingTargetForSelector:', 'forwardInvocation:'],
    'NewSyncService': ['BackGroundFetchToSync', 'isGettingData', 'InternalCreateSync:', 'creatPBNewSyncEvent:', 'HandleSyncResp:handleResult:'],
    'CUtility': ['NeedNewSync:'],
}
selected_rows = [row for row in rows if row['selector'] in selected.get(row['class'], [])]
reports = []
for row in selected_rows:
    start, end = int(row['address'], 16), int(row['end_exclusive'], 16)
    raw = subprocess.check_output(['xcrun', 'llvm-objdump', '-d', '--start-address='+hex(start),
        '--stop-address='+hex(end), str(target)], text=True)
    name = row['class']+'--'+row['selector'].replace(':', '_')
    (out/(name+'.asm')).write_text(raw)
    registers, lines = {}, []
    for line in raw.splitlines():
        match = re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)', line)
        if match:
            registers[match[1]] = int(match[2], 16)
        match = re.search(r'(?:ldr|ldrsw)\s+[xw]\d+, \[(x\d+), #(0x[0-9a-f]+)\]', line)
        if match and match[1] in registers:
            try:
                text = label(registers[match[1]]+int(match[2], 16))
                if text:
                    line += ' ; '+text
            except (ValueError, IndexError, struct.error):
                pass
        match = re.search(r'add\s+x\d+, (x\d+), #(0x[0-9a-f]+)', line)
        if match and match[1] in registers:
            try:
                address = registers[match[1]]+int(match[2], 16)
                section = next((key[1] for key, value in sections.items() if value[0] <= address < value[0]+value[1]), None)
                if section == '__cstring':
                    line += ' ; string '+repr(string(address))
                elif section == '__cfstring':
                    line += ' ; CFString '+repr(string(pointer(position(address)+16)))
                elif section == '__objc_selrefs':
                    line += ' ; '+label(address)
            except (ValueError, IndexError, struct.error):
                pass
        lines.append(line)
    (out/(name+'.annotated.asm')).write_text('\n'.join(lines)+'\n')
    reports.append(row)
manifest = {'target': str(target), 'sha256': digest, 'static_only': True, 'target_executed': False,
    'producer': 'read-only mmap ObjC metadata and bounded xcrun llvm-objdump; not REA function Evidence',
    'rea_session': 'binary_session confirmed no active target; existing same-target audit records costly Ghidra import, so bounded parser reused',
    'limitations': ['No device, response, server-coverage or runtime thread observation.', 'Context type predicates are not proof of native login state.',
        'Annotations are direct ADRP/load decoding aids; raw instructions and metadata remain evidence.'],
    'methods': reports, 'files': {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in out.iterdir() if p.name != 'manifest.json'}}
(out/'manifest.json').write_text(json.dumps(manifest, indent=2)+'\n')
print(json.dumps({'methods': len(reports), 'sha256': digest, 'output': str(out)}))
