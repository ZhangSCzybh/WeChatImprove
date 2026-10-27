"""Bounded, nonexecuting ChatBox entry and presentation evidence."""
from pathlib import Path
import json, re, subprocess, hashlib

out = Path(__file__).parent
root = Path(__file__).resolve().parents[4]
ctx = {}
exec((root / 'docs/evidence/close-friends-native-2026-10-20/extract.py').read_text().split('\nimport re,subprocess,hashlib,bisect')[0], ctx)
selected = {'CMessageWrap':['m_n64MesSvrID','m_nsPushContent','GetDisplayContent','getSessionTime','m_nsContent','copyWithZone:','copyToMsg:','ChangeForDisplay'], 'MMSessionInfo':['m_msgWrap','copyWithZone:','CopySessionInfo:','copySessionInfo:','setM_msgWrap:'], 'MainFrameCellData':['digestForMsg:withSender:','init','setM_sessionInfo:','makeTextSession:','makeTextForMessageLabel','getGroupName','getContact','makeTextForQuoteMessage','initWithSessionInfo:'], 'MainFrameCellDataManager':['getCellDataByUsrName:']}
rows = json.loads((out / 'methods.json').read_text())
class_names = {int(v, 16): k for k, v in json.loads((root / 'docs/evidence/message-actions-native-2026-10-17/classes.json').read_text()).items()}
reports = []
for row in rows:
    if row['selector'] not in selected.get(row['cls'], []) or (row['kind']=='class' and row['selector']!='digestForMsg:withSender:'):
        continue
    start = int(row['address'], 16); stop = min(int(row['end'], 16), start + 24000)
    raw = subprocess.check_output(['xcrun', 'llvm-objdump', '-d', '--start-address=' + hex(start),
                                   '--stop-address=' + hex(stop), '/tmp/wechat-8.0.78-inset-analysis/WeChat'], text=True)
    regs = {}; lines = []
    for line in raw.splitlines():
        m = re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)', line)
        if m:
            regs[m[1]] = int(m[2], 16)
        m = re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]', line)
        if m and m[1] in regs:
            try:
                pointer = ctx['ptr'](ctx['pos'](regs[m[1]] + int(m[2], 16)))
                value = class_names.get(pointer) or ctx['string'](pointer)
                if value and len(value) < 180 and all(c.isprintable() and c != '\ufffd' for c in value):
                    line += ' ; ' + value
            except Exception:
                pass
        m = re.search(r'add\s+(x\d+), (x\d+), #(0x[0-9a-f]+)', line)
        if m and m[2] in regs:
            try:
                address = regs[m[2]] + int(m[3], 16)
                p = ctx['pos'](address)
                if ctx['u64'](p + 8) == 0x7c8:
                    value = ctx['string'](ctx['ptr'](p + 16))
                    if len(value) < 250:
                        line += ' ; CFString ' + repr(value)
            except Exception:
                pass
        lines.append(line.rstrip())
    name = row['cls'] + '--' + row['selector'].replace(':', '_') + '.asm'
    (out / name).write_text('\n'.join(lines) + '\n')
    reports.append(dict(file=name, start=hex(start), stop=hex(stop), truncated=stop < int(row['end'], 16)))
manifest = dict(target='/tmp/wechat-8.0.78-inset-analysis/WeChat',
                sha256='0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e',
                static_only=True, disassembly=reports)
manifest['files'] = {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in out.iterdir()
                     if p.suffix in ['.py', '.asm', '.json', '.md'] and p.name != 'manifest.json'}
(out / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
print(json.dumps(reports, indent=2))
