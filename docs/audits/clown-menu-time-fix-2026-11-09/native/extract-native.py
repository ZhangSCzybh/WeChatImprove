#!/usr/bin/env python3
"""Read the known WeChat Mach-O and retain focused metadata/assembly evidence."""
import bisect
import hashlib
import json
from pathlib import Path
import re
import runpy
import struct
import subprocess
import sys

project = Path(__file__).resolve().parents[4]
artifact = Path(sys.argv[1])
destination = Path(__file__).resolve().parent
reader = project / 'docs/audits/wechat-8.0.80-followup-2026-11-09/discover/objc-reader.py'
sys.argv = [str(reader), str(artifact)]
r = runpy.run_path(str(reader))
b, off, ptr, p64, u64, string = (r[k] for k in ['b', 'off', 'ptr', 'p64', 'u64', 's'])
classes = {}
va, size, fileoff = r['sections']['__objc_classlist']
for index in range(size // 8):
    try:
        address = ptr(struct.unpack_from('<Q', b, fileoff + index * 8)[0])
        name, ro = r['clsname'](address)
        classes[name] = (address, ro)
    except (ValueError, struct.error):
        pass

def ivars(ro):
    address = u64(ro + 48)
    if not address:
        return []
    address = ptr(address)
    stride, count = struct.unpack_from('<II', b, off(address))
    return [dict(name=string(p64(e + 8)), type=string(p64(e + 16)),
                 offset=struct.unpack_from('<I', b, off(p64(e)))[0])
            for e in (address + 8 + i * stride for i in range(count))]

def properties(ro):
    address = u64(ro + 64)
    if not address:
        return []
    address = ptr(address)
    stride, count = struct.unpack_from('<II', b, off(address))
    return [dict(name=string(p64(e)), attributes=string(p64(e + 8)))
            for e in (address + 8 + i * stride for i in range(count))]

selected = ['WCPayBaseMessageCellView', 'WCPayTransferMessageCellView',
            'WCPayTransferMessageViewModel', 'ChatTimeCellView', 'ChatTimeViewModel',
            'BaseMessageCellView', 'BaseMsgContentViewController', 'WCPayInfoItem', 'CMessageWrap']
metadata = []
for name in selected:
    address, ro = classes[name]
    try:
        superclass = r['clsname'](p64(address + 8))[0]
    except (ValueError, struct.error):
        superclass = hex(u64(address + 8))
    meta_ro = r['clsname'](p64(address))[1]
    metadata.append(dict(name=name, address=hex(address), superclass=superclass,
                         ivars=ivars(ro), properties=properties(ro),
                         methods=r['methods'](ro), class_methods=r['methods'](meta_ro)))
(destination / 'objc-metadata.json').write_text(json.dumps(metadata, ensure_ascii=False, indent=2) + '\n')
(destination / 'transfer-cell-class-inventory.json').write_text(json.dumps(
    sorted(n for n in classes if 'Transfer' in n and 'CellView' in n), indent=2) + '\n')

starts = []
pos = 32
for _ in range(struct.unpack_from('<I', b, 16)[0]):
    command, command_size = struct.unpack_from('<II', b, pos)
    if command == 0x26:
        dataoff, datasize = struct.unpack_from('<II', b, pos + 8)
        cursor, address = dataoff, 0x100000000
        while cursor < dataoff + datasize:
            delta, shift = 0, 0
            while True:
                byte = b[cursor]
                cursor += 1
                delta |= (byte & 127) << shift
                if byte < 128:
                    break
                shift += 7
            if not delta:
                break
            address += delta
            starts.append(address)
    pos += command_size

requests = {
    'WCPayBaseMessageCellView': ['initTitleLabel', 'initDescLabel'],
    'WCPayTransferMessageCellView': ['initTitleLabel', 'updateTitleLabel', 'operationMenuItems'],
    'WCPayTransferMessageViewModel': ['canCreateMessageViewModelWithMessageWrap:', 'titleText', 'innerTitleText'],
    'ChatTimeCellView': ['layoutInternal', 'onClickTimeLabel'],
    'ChatTimeViewModel': ['measure:', 'updateLayouts'],
    'BaseMsgContentViewController': ['toggleTimeShowMode:', 'isNeedShowTimeInDetail'],
    'BaseMessageCellView': ['uniqMenuItems:', 'filteredMenuItems:', 'LongPressEvents', 'onLongTouch', 'onLongTouch:',
                            'showOperationMenu', 'generateOperationMenu', 'operationMenuItems'],
}
commands = []
references = {}
for cls, names in requests.items():
    entry = next(item for item in metadata if item['name'] == cls)
    methods = (entry['methods']['entries'] if entry['methods'] else []) + (entry['class_methods']['entries'] if entry['class_methods'] else [])
    for method in methods:
        if method['selector'] not in names:
            continue
        start = int(method['imp'], 16)
        stop = starts[bisect.bisect_right(starts, start)]
        filename = cls + '-' + method['selector'].replace(':', '_') + '.asm'
        command = ['xcrun', 'llvm-objdump', '--disassemble', f'--start-address={start}',
                   f'--stop-address={stop}', str(artifact)]
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        (destination / filename).write_text(result.stdout)
        pages, found = {}, []
        for line in result.stdout.splitlines():
            instruction = re.search(r'^([0-9a-f]+):\s+[0-9a-f]+\s+(\w+)\s*(.*)', line)
            match = re.search(r'^([0-9a-f]+):.*\badrp\s+(x\d+),\s*(0x[0-9a-f]+)', line)
            if match:
                pages[match[2]] = int(match[3], 16)
                continue
            match = re.search(r'^([0-9a-f]+):.*\bldr\s+x\d+,\s*\[(x\d+)(?:,\s*#(0x[0-9a-f]+))?\]', line)
            if match and match[2] in pages:
                slot = pages[match[2]] + int(match[3] or '0', 16)
                for section_name in ['__objc_selrefs', '__objc_classrefs']:
                    section_start, section_size, _ = r['sections'][section_name]
                    if section_start <= slot < section_start + section_size:
                        try:
                            value = string(p64(slot)) if section_name == '__objc_selrefs' else r['clsname'](p64(slot))[0]
                        except (ValueError, struct.error):
                            value = f'unresolved external binding {u64(slot):#x}'
                        found.append(dict(instruction=hex(int(match[1], 16)), slot=hex(slot),
                                          kind=section_name, value=value))
            if instruction:
                mnemonic, operands = instruction[2], instruction[3]
                if mnemonic == 'bl':
                    for register in range(19):
                        pages.pop(f'x{register}', None)
                elif mnemonic not in ['str', 'stur', 'stp', 'cmp', 'cmn', 'tst', 'ret', 'cbz', 'cbnz', 'tbz', 'tbnz', 'b']:
                    destination_register = re.match(r'(x\d+)\b', operands)
                    if destination_register:
                        pages.pop(destination_register[1], None)
        references[filename] = found
        commands.append(dict(class_name=cls, method=method, start=hex(start), stop_exclusive=hex(stop),
                             filename=filename, command=command, stderr=result.stderr))
(destination / 'disassembly-commands.json').write_text(json.dumps(commands, ensure_ascii=False, indent=2) + '\n')
(destination / 'reference-annotations.json').write_text(json.dumps(references, ensure_ascii=False, indent=2) + '\n')
(destination / 'artifact.json').write_text(json.dumps(dict(
    path=str(artifact), sha256=hashlib.sha256(b).hexdigest(), bytes=len(b),
    extraction='Reused previously extracted artifact; no IPA extraction or binary execution',
    reader=str(reader), reader_sha256=hashlib.sha256(reader.read_bytes()).hexdigest(),
    function_bounds='LC_FUNCTION_STARTS entries; stop is exclusive',
    caveat='llvm-objdump nearby export labels are not Objective-C method identities; metadata IMP addresses identify methods',
), ensure_ascii=False, indent=2) + '\n')
print(f'Retained {len(metadata)} classes and {len(commands)} focused native methods.')
