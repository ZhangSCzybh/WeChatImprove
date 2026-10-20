from pathlib import Path
import json,struct,bisect
root=Path(__file__).resolve().parents[4]
source=(root/'docs/evidence/close-friends-native-2026-10-20/extract.py').read_text()
exec(source.split("import re,subprocess,hashlib,bisect")[0])
classes=json.loads((root/'docs/evidence/message-actions-native-2026-10-17/classes.json').read_text())
selected=['ChatBoxSessionListViewController','ChatBoxMgr','ChatBoxUtil','SessionBox','MainFrameLogicController','NewMainFrameViewController']
exec('starts=[]'+source.split('starts=[]',1)[1].split('rows=[];missing=[]',1)[0])
rows=[];metadata={}
for name in selected:
 ca=int(classes[name],16)
 rp=pos(ptr(pos(ca)+32)&~7)
 try:
  sup=ptr(pos(ca)+8) if u64(pos(ca)+8) else None
  supname=string(ptr(pos(ptr(pos(sup)+32)&~7)+24)) if sup else None
 except ValueError:
  supname='<bound external>'
 metadata[name]={'superclass':supname,'ivars':[]}
 if u64(rp+48):
  ip=pos(ptr(rp+48));iz,ic=struct.unpack_from('<II',b,ip)
  for j in range(ic):
   en=ip+8+j*iz;oa=ptr(en)
   metadata[name]['ivars'].append({'offset_address':hex(oa),'offset':u32(pos(oa)),'name':string(ptr(en+8)),'type':string(ptr(en+16))})
 for kind,cl in [('instance',ca),('class',ptr(pos(ca)))]:
  rp=pos(ptr(pos(cl)+32)&~7)
  if not u64(rp+32):continue
  ml=ptr(rp+32);mp=pos(ml);flags,count=struct.unpack_from('<II',b,mp)
  for n in range(count):
   en=mp+8+n*(flags&0xffff);ev=ml+8+n*(flags&0xffff)
   if flags&0x80000000:
    sa=ev+i32(en)
    if not flags&0x40000000:sa=ptr(pos(sa))
    sel=string(sa);imp=ev+8+i32(en+8);typ=string(ev+4+i32(en+4))
   else:sel=string(ptr(en));imp=ptr(en+16);typ=string(ptr(en+8))
   rows.append(dict(cls=name,kind=kind,selector=sel,address=hex(imp),end=hex(starts[bisect.bisect_right(starts,imp)]),types=typ))
out=Path(__file__).parent
(out/'methods.json').write_text(json.dumps(rows,indent=2)+'\n')
(out/'metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')

for row in rows:
 if row['cls'] in selected[:4] and any(x in row['selector'].lower() for x in ['table','session','count','select','unread','contact','reload']):print(row)
