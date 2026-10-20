"""Read-only, bounded Objective-C metadata/native inspection for WeChat 8.0.78.

The target is never loaded or executed. Outputs remain next to this script.
Reuses the parser prefix of the already-reviewed root evidence extractor.
"""
import bisect
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[4]
OUT = Path(__file__).resolve().parent
TARGET = Path('/tmp/wechat-8.0.78-inset-analysis/WeChat')
ctx = {}
exec((ROOT / 'docs/evidence/close-friends-native-2026-10-20/extract.py').read_text().split('\nimport re,subprocess,hashlib,bisect')[0], ctx)
b, u32, u64, i32, pos, ptr, string = [ctx[x] for x in ('b', 'u32', 'u64', 'i32', 'pos', 'ptr', 'string')]
classes = json.loads((ROOT / 'docs/evidence/message-actions-native-2026-10-17/classes.json').read_text())
class_names = {int(v, 16): k for k, v in classes.items()}
starts = []
off = 32
for _ in range(u32(16)):
    cmd, sz = struct.unpack_from('<II', b, off)
    if cmd == 0x26:
        p, size = struct.unpack_from('<II', b, off + 8)
        end, addr = p + size, 0x100000000
        while p < end:
            value = shift = 0
            while True:
                v = b[p]; p += 1; value |= (v & 127) << shift; shift += 7
                if not v & 128: break
            if not value: break
            addr += value; starts.append(addr)
    off += sz

def methods(name):
    ca = int(classes[name], 16)
    for kind, cl in [('instance', ca), ('class', ptr(pos(ca)))]:
        rp = pos(ptr(pos(cl) + 32) & ~7)
        if not u64(rp + 32): continue
        ml = ptr(rp + 32); mp = pos(ml)
        flags, count = struct.unpack_from('<II', b, mp)
        for n in range(count):
            en, ev = mp + 8 + n * (flags & 0xffff), ml + 8 + n * (flags & 0xffff)
            if flags & 0x80000000:
                sa = ev + i32(en)
                if not flags & 0x40000000: sa = ptr(pos(sa))
                sel, imp, typ = string(sa), ev + 8 + i32(en + 8), string(ev + 4 + i32(en + 4))
            else:
                sel, imp, typ = string(ptr(en)), ptr(en + 16), string(ptr(en + 8))
            idx = bisect.bisect_right(starts, imp)
            yield dict(cls=name, kind=kind, selector=sel, address=hex(imp), end=hex(starts[idx] if idx < len(starts) else imp), types=typ)

def section(addr):
    for (seg, sec), (va, size, fileoff) in ctx['sections'].items():
        if va <= addr < va + size: return seg, sec
    return None, None

def annotation(addr):
    seg, sec = section(addr)
    if sec == '__objc_selrefs': return 'selector=' + string(ptr(pos(addr)))
    if sec == '__objc_classrefs':
        val = ptr(pos(addr))
        return 'class=' + class_names.get(val, hex(val))
    if sec == '__cstring': return 'cstring=' + repr(string(addr))
    if sec == '__cfstring':
        val = ptr(pos(addr) + 16)
        return 'cfstring=' + repr(string(val))
    if sec == '__objc_protorefs':
        val = ptr(pos(addr))
        return 'protocol=' + string(ptr(pos(val) + 8))
    return None

def disassemble(name, start, end):
    stop = min(end, start + 16000)
    raw = subprocess.check_output(['xcrun', 'llvm-objdump', '-d', '--start-address=' + hex(start), '--stop-address=' + hex(stop), str(TARGET)], text=True)
    # Only annotate values whose source is a known metadata/string section.
    # These are reference hints, not a full register value-flow analysis.
    regs, lines = {}, []
    for line in raw.splitlines():
        m = re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)', line)
        if m: regs[m[1]] = int(m[2], 16)
        m = re.search(r'ldr\s+x\d+, \[(x\d+)(?:, #(0x[0-9a-f]+))?\]', line)
        if m and m[1] in regs:
            try:
                hint = annotation(regs[m[1]] + int(m[2] or '0', 16))
                if hint: line += ' ; ' + hint
            except Exception: pass
        m = re.search(r'add\s+(x\d+), (x\d+), #(0x[0-9a-f]+)', line)
        if m and m[2] in regs:
            val = regs[m[2]] + int(m[3], 16)
            try:
                hint = annotation(val)
                if hint: line += ' ; ' + hint
            except Exception: pass
            regs[m[1]] = val
        lines.append(line.rstrip())
    (OUT / (name + '.asm')).write_text('\n'.join(lines) + '\n')
    return dict(file=name + '.asm', start=hex(start), stop=hex(stop), truncated=stop < end)

if sys.argv[1] == 'inventory':
    selected = ['VoIPInvitationInfo', 'VoIPInvitationService', 'VoIPInvitationViewController', 'VoipMonoMsg', 'MultiTalkMgr', 'VoipUIManager', 'VOIPMgr', 'VoIPilinkMgr', 'VoipCXMgr', 'VoIPPushKitNotifyService', 'MonoServiceMgr', 'MonoServiceLogic', 'MultiTalkSessionMgr', 'MultiTalkTerminationService', 'VoIPConfSDKService', 'VoIPConfigUtils']
    keys = ['voIPInvitationServiceDidRejectWithInfo:', 'voIPInvitationServiceDidReject', 'handleInvitationInfo:withTalkingRoomID:talkingRoomKey:']
    rows, callbacks, errors = [], [], []
    for name in classes:
        try:
            for row in methods(name):
                if name in selected: rows.append(row)
                if any(k in row['selector'] for k in keys): callbacks.append(row)
        except Exception as e: errors.append(dict(cls=name, error=str(e)))
    (OUT / 'methods.json').write_text(json.dumps(rows, indent=2) + '\n')
    (OUT / 'callback-methods.json').write_text(json.dumps(callbacks, indent=2) + '\n')
    manifest = dict(target=str(TARGET), sha256=hashlib.sha256(b).hexdigest(), static_only=True, selected_classes=selected, method_count=len(rows), callback_count=len(callbacks), class_count=len(classes), errors=errors)
    (OUT / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(json.dumps(manifest, indent=2))
elif sys.argv[1] == 'method':
    name, selector = sys.argv[2:4]
    rows = [r for r in methods(name) if r['selector'] == selector]
    if not rows: raise SystemExit('No matching method')
    for row in rows:
        filename = row['cls'] + '--' + row['kind'] + '--' + row['selector'].replace(':', '_')
        print(json.dumps(row | disassemble(filename, int(row['address'], 16), int(row['end'], 16))))
elif sys.argv[1] == 'raw':
    start = int(sys.argv[2], 16)
    idx = bisect.bisect_right(starts, start)
    end = starts[idx]
    print(json.dumps(disassemble('function-' + hex(start), start, end)))
elif sys.argv[1] == 'resolve':
    for v in sys.argv[2:]:
        addr = int(v, 16)
        print(v, section(addr), annotation(addr))
elif sys.argv[1] == 'list':
    name = sys.argv[2]
    rows = list(methods(name))
    (OUT / (name + '-methods.json')).write_text(json.dumps(rows, indent=2) + '\n')
    pattern = re.compile(sys.argv[3]) if len(sys.argv) > 3 else None
    for row in rows:
        if pattern is None or pattern.search(row['selector']): print(json.dumps(row))
