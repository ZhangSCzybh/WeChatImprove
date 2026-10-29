"""Bounded LLVM disassembly plus decoded selector/class/CFString references.

Read-only. Method ends come from LC_FUNCTION_STARTS. Annotations are decoded
metadata references, not claims about runtime receiver identity or execution.
"""
import bisect, json, re, struct, subprocess
from pathlib import Path
import extract as e

out = Path(__file__).parent
metadata = json.loads((out / 'metadata.json').read_text())
starts = []
off = 32
for _ in range(e.u32(16)):
    cmd, size = struct.unpack_from('<II', e.b, off)
    if cmd == 0x26:
        p, length = struct.unpack_from('<II', e.b, off + 8)
        stop = p + length
        addr = 0x100000000
        while p < stop:
            value = shift = 0
            while True:
                v = e.b[p]
                p += 1
                value |= (v & 127) << shift
                shift += 7
                if not v & 128:
                    break
            if not value:
                break
            addr += value
            starts.append(addr)
    off += size

def section(addr):
    for (_, name), (start, length, _) in e.sections.items():
        if start <= addr < start + length:
            return name
    return None

def reference(addr, dereference=True):
    name = section(addr)
    if name == '__objc_selrefs':
        return 'selector ' + e.string(e.ptr(e.pos(addr)))
    if name == '__objc_classrefs':
        return 'class ' + e.boundclass(e.pos(addr))
    if name == '__cfstring':
        return 'CFString ' + repr(e.string(e.ptr(e.pos(addr) + 16)))
    if name in ('__cstring', '__objc_methname'):
        return 'string ' + repr(e.string(addr))
    return None

wanted = {
 'MainFrameAggregationTransition':['animateTransition:','animatedTransitionRespondViewController'],
 'MainFrameAggregationLogic':['init','currentSessionList','sessionAtIndex:','sessionCount','notifySessionCount','rebuildSessionList','canShowSession:','onMainFrameBeginReload','onMainFrameHandleSession:','onMainFrameEndReload','onSessionTotalUnreadCountChange:','changeReadStatusAtIndex:'],
 'MainFrameAggregationViewController':['init','viewDidLoad','viewWillAppear:','updateContent','updateBottomTitle','onSessionListChange','onSessionUnreadChange','onPushTransitionWillBegin','onPushTransitionEnd','tableView:didSelectRowAtIndexPath:','tableView:commitEditingStyle:forRowAtIndexPath:'],
 'NewMainFrameViewController':['showAggregationWithShock:','onAggregation:openSession:'],
 'MainSessionMgr':['visibleSessionEnumerator'],
 'MMNewSessionMgr':['recountUnReadCount','GetUnreadNotifySessionCount'],
}
rows = []
for cls, selectors in wanted.items():
    for kind in ['methods', 'class_methods']:
        for method in metadata['classes'].get(cls,{}).get(kind,[]):
            if method['selector'] not in selectors:
                continue
            start = int(method['address'], 16)
            end = starts[bisect.bisect_right(starts, start)]
            filename = cls + ('++' if kind == 'class_methods' else '--') + method['selector'].replace(':', '_').replace('<', '').replace('>', '') + '.asm'
            raw = subprocess.check_output(['xcrun', 'llvm-objdump', '-d', '--start-address=' + hex(start), '--stop-address=' + hex(end), '/tmp/wechat-8.0.78-inset-analysis/WeChat'], text=True)
            regs = {}
            lines = []
            for line in raw.splitlines():
                m = re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)', line)
                if m:
                    regs[m[1]] = int(m[2], 16)
                m = re.search(r'ldr\s+(x\d+), \[(x\d+)(?:, #(0x[0-9a-f]+))?\]', line)
                if m and m[2] in regs:
                    try:
                        note = reference(regs[m[2]] + int(m[3] or '0', 16))
                        if note:
                            line += ' ; ' + note
                    except (ValueError, struct.error, TypeError):
                        pass
                if m:
                    regs.pop(m[1], None)
                m = re.search(r'add\s+(x\d+), (x\d+), #(0x[0-9a-f]+)', line)
                if m and m[2] in regs:
                    address = regs[m[2]] + int(m[3], 16)
                    try:
                        note = reference(address, False)
                        if note:
                            line += ' ; ' + note
                    except (ValueError, struct.error, TypeError):
                        pass
                    regs[m[1]] = address
                m = re.search(r'\b(?:ldr|ldrsw|ldrb|ldrh|mov|add|sub|and|orr|eor|lsl|lsr|sxtw|ubfx)\s+([xw]\d+),', line)
                if m:
                    regs.pop('x' + m[1][1:], None)
                if re.search(r'\b(?:bl|blr)\s', line):
                    regs = {k: v for k, v in regs.items() if int(k[1:]) >= 19}
                lines.append(line)
            (out / filename).write_text('\n'.join(lines) + '\n')
            rows.append(dict(cls=cls, kind=kind, **method, end_exclusive=hex(end), file=filename))
(out / 'methods.json').write_text(json.dumps(rows, indent=2) + '\n')
print(json.dumps({'methods': len(rows), 'directory': str(out)}))
