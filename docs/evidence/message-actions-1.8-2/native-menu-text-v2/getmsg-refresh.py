"""Read-only extraction of Objective-C metadata and bounded native disassembly."""
import mmap,struct,json
from pathlib import Path
f=open('/tmp/wechat-8.0.78-inset-analysis/WeChat','rb');b=mmap.mmap(f.fileno(),0,access=mmap.ACCESS_READ)
u32=lambda o:struct.unpack_from('<I',b,o)[0]
u64=lambda o:struct.unpack_from('<Q',b,o)[0]
i32=lambda o:struct.unpack_from('<i',b,o)[0]
segs=[];sections={};off=32
for _ in range(u32(16)):
 cmd,size=struct.unpack_from('<II',b,off)
 if cmd==0x19:
  name=b[off+8:off+24].split(b'\0')[0].decode();va,vs,fo,fs=struct.unpack_from('<QQQQ',b,off+24);segs.append((va,vs,fo,fs))
  for j in range(u32(off+64)):
   so=off+72+80*j;sn=b[so:so+16].split(b'\0')[0].decode();sections[(name,sn)]=struct.unpack_from('<QQI',b,so+32)
 if cmd==0x2c:print('encryption',struct.unpack_from('<III',b,off+8))
 off+=size
def pos(addr):
 for va,vs,fo,fs in segs:
  if va<=addr<va+fs:return fo+addr-va
 raise ValueError(hex(addr))
def string(addr):
 p=pos(addr);return b[p:b.find(b'\0',p)].decode(errors='replace')
def ptr(offset):
 v=u64(offset)
 if v>>63:raise ValueError('bind')
 return 0x100000000+(v&0xfffffffff)



import json,re,subprocess
out=Path(__file__).parent
allmethods=[]
def methods(addr):
 if not addr:return []
 mp=pos(addr);flags,count=struct.unpack_from('<II',b,mp);rows=[]
 for n in range(count):
  step=flags&0xffff;entry=mp+8+n*step;ev=addr+8+n*step
  if flags&0x80000000:
   seladdr=ev+i32(entry)
   if not flags&0x40000000:seladdr=ptr(pos(seladdr))
   sel=string(seladdr);imp=ev+8+i32(entry+8);types=string(ev+4+i32(entry+4))
  else:sel=string(ptr(entry));imp=ptr(entry+16);types=string(ptr(entry+8))
  rows.append({'selector':sel,'address':hex(imp),'types':types});allmethods.append(imp)
 return rows

known=json.loads(Path('docs/evidence/message-actions-native-2026-10-17/classes.json').read_text())
classes={}
for name in ['CMessageDB','CMessageMgr']:
 cls=int(known[name],16);rp=pos(ptr(pos(cls)+32)&~7);rows=methods(ptr(rp+32));classes[name]=rows
selected={'CMessageMgr':['GetMsg:LocalID:','GetMsg:LocalID:hasError:needOriginContent:','GetMsg:n64SvrID:','onGetMsg:LocalID:Wrap:','CheckMessageStatus:Msg:'], 'CMessageDB':['GetMsg:Where:order:Limit:hasError:needOriginContent:','GetMsg:LocalID:','GetMsg:n64SvrID:','GetMsg:LocalID:hasError:needOriginContent:']}
index=[]
for name,rows in classes.items():
 addresses=sorted(int(r['address'],16) for r in rows)
 for row in rows:
  if row['selector'] not in selected[name]:continue
  index.append({'class':name,**row});start=int(row['address'],16);end=min(v for v in addresses if v>start)
  result=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(min(end,start+0x4000)),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
  regs={};lines=[]
  for line in result.splitlines():
   z=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
   if z:regs[z[1]]=int(z[2],16)
   z=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
   if z and z[1] in regs:
    try:
     v=string(ptr(pos(regs[z[1]]+int(z[2],16))))
     if v and len(v)<180 and all(c.isprintable() for c in v):line+=' ; '+v
    except (ValueError,struct.error):pass
   lines.append(line)
  out.joinpath(name+'--'+row['selector'].replace(':','_')+'.asm').write_text('\n'.join(lines))
out.joinpath('getmsg-refresh-methods.json').write_text(json.dumps(index,indent=2))
print(json.dumps(index,indent=2))
