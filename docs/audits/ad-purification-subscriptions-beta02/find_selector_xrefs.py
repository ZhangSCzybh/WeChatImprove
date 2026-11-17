#!/usr/bin/env python3
"""Find direct ADRP+LDR references to chosen selector slots, without execution.
Search restricted to main-image __TEXT,__text; 12-instruction backward scan,
register matching required. Reports candidates; control/data flow remains manual.
"""
import importlib.util,json,struct,sys
requested_names=sys.argv[1:]
from pathlib import Path
A=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('extract',A/'extract_assembly.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
ctx=m.ctx;b=m.b;sec=m.sections['__DATA,__objc_selrefs'] if '__DATA,__objc_selrefs' in m.sections else m.sections['__DATA_CONST,__objc_selrefs']
names=requested_names or ['convertAffMsgInfoDataListToMsgWrapList:','canTimlineMsgDiscard:']
slots={}
for off in range(sec['offset'],sec['offset']+sec['size'],8):
 try:
  n=m.cstr(m.pointer(off))
  if n in names:slots[n]=sec['address']+off-sec['offset']
 except (ValueError,TypeError):pass
textsec=m.sections['__TEXT,__text'];lo=textsec['offset'];hi=lo+textsec['size'];base=ctx['base'];rows=[]
for name,va in slots.items():
 imm=(va&0xfff)//8
 for rt in range(31):
  for rn in [8,9,10,16]:
   instr=0xf9400000|(imm<<10)|(rn<<5)|rt;needle=struct.pack('<I',instr);p=lo
   while True:
    p=b.find(needle,p,hi)
    if p<0:break
    if p%4==0:
     for q in range(p-4,max(lo,p-48)-1,-4):
      ad=struct.unpack_from('<I',b,q)[0]
      if (ad&0x9f00001f)==(0x90000000|rn):
       raw=((ad>>29)&3)|(((ad>>5)&0x7ffff)<<2)
       if raw&(1<<20):raw-=1<<21
       page=((base+q)&~0xfff)+(raw<<12)
       if page==va&~0xfff:rows.append(dict(selector=name,slot=hex(va),adrp=hex(base+q),load=hex(base+p),rt=rt,rn=rn))
       break
    p+=4
(A/('masssend-selector-xrefs.json' if requested_names else 'selector-xrefs.json')).write_text(json.dumps(rows,indent=2)+'\n')
print(json.dumps(rows,indent=2))
