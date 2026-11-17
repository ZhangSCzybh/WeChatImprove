#!/usr/bin/env python3
"""Execution-free bounded LLVM disassembly with literal-ref annotations.
Annotations are linear ADRP/ADD literal-address hints, not a control-flow proof.
"""
import json,re,subprocess,sys
from pathlib import Path
AUDIT=Path(__file__).resolve().parent
PARSER=AUDIT.parent/'ad-purification-8.0.80'/'inspect_objc_metadata.py'
BINARY=Path('/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-8.0.80-ad-audit-oaztrb2m/WeChat')
sys.argv=[str(PARSER),str(BINARY),str(AUDIT/'metadata-targets.json'),str(AUDIT)]
ctx={};exec(PARSER.read_text().split('\ntargets=')[0],ctx)
b=ctx['b'];u64=ctx['u64'];off=ctx['off'];pointer=ctx['pointer'];cstr=ctx['cstr'];classes=ctx['class_addresses'];sections=ctx['sections'];imports=ctx['imports']
def label(va):
 try:
  o=off(va);raw=u64(o)
  sec=next((k for k,s in sections.items() if s['address']<=va<s['address']+s['size']),None)
  if raw>>63 and sec and ('classrefs' in sec or '__got' in sec):return 'bind '+imports[raw&0xffffff]
  dst=pointer(o)
  if sec and '__objc_selrefs' in sec:return 'selector '+cstr(dst)
  if dst in classes:return 'class '+classes[dst]
  if sec and '__cfstring' in sec:return 'NSString '+repr(cstr(pointer(o+16)))
  if dst and sec and '__objc_classrefs' in sec:return 'classref '+hex(dst)
  if sec:return sec+' literal '+hex(raw)
 except (ValueError,IndexError,TypeError):pass
 return ''
def disasm(name,start,end):
 raw=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),str(BINARY)],text=True)
 pages={};out=[]
 for line in raw.splitlines():
  adrp=re.search(r'\badrp\s+(x\d+), (0x[0-9a-f]+)',line)
  if adrp:pages[adrp[1]]=int(adrp[2],16)
  add=re.search(r'\badd\s+(x\d+), (x\d+), #(0x[0-9a-f]+)',line)
  if add and add[2] in pages:pages[add[1]]=pages[add[2]]+int(add[3],16)
  ld=re.search(r'\bldr\s+(x\d+), \[(x\d+)(?:, #(0x[0-9a-f]+))?\]',line)
  if ld:
   if ld[2] in pages:
    va=pages[ld[2]]+int(ld[3] or '0',16);lab=label(va)
    if lab:line+='  // @'+hex(va)+' '+lab
   pages.pop(ld[1],None)
  ins=re.search(r': [0-9a-f]{8}\s+([a-z0-9.]+)\s+(.*)',line)
  if ins:
   op,args=ins.groups();dest=re.match(r'([xw]\d+)\b',args)
   if (op.startswith('ldr') or op.startswith('ldur') or op=='ldp') and dest:
    pages.pop('x'+dest[1][1:],None)
   if op=='bl':
    for i in range(19):pages.pop('x'+str(i),None)
   elif dest and op not in ['adrp','add','ldr','cmp','tst','str','strb','stur','stp','cbz','cbnz','tbz','tbnz','br','blr']:
    reg='x'+dest[1][1:]
    mov=re.match(r'x\d+, (x\d+)\b',args) if op=='mov' else None
    if mov and mov[1] in pages:pages[reg]=pages[mov[1]]
    else:pages.pop(reg,None)
   if op=='add' and not (add and add[2] in pages) and dest:pages.pop('x'+dest[1][1:],None)
  out.append(line)
 text='\n'.join(out)+'\n'
 (AUDIT/(name+'.asm.txt')).write_text(text)
 return text
if __name__=='__main__':
 specs=json.loads((AUDIT/'assembly-ranges.json').read_text())
 for name,start,end in specs:disasm(name,int(start,16),int(end,16))
 print(json.dumps(dict(ranges=len(specs),output_directory=str(AUDIT))))
