import mmap,struct,json,re,subprocess
from pathlib import Path
root=Path('/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove/docs/evidence/message-actions-native-2026-10-17')
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
selected={'MMContext','MMServiceCenter','MMServiceWrapper','MMBaseService','CContactMgr'}
rows=[];addresses=set();ivars={}
for (seg,sec),(addr,size,offset) in sections.items():
 if sec!='__objc_classlist':continue
 for off in range(offset,offset+size,8):
  try:
   cls=ptr(off);rp=pos(ptr(pos(cls)+32)&~7);name=string(ptr(rp+24))
  except ValueError:continue
  if name in selected:
   try:
    ip=pos(ptr(rp+48));iz,ic=struct.unpack_from('<II',b,ip);iv=[]
    for k in range(ic):
     en=ip+8+k*iz;oa=ptr(en);iv.append({'offset_address':hex(oa),'offset':u32(pos(oa)),'name':string(ptr(en+8)),'type':string(ptr(en+16))})
    ivars[name]=iv
   except ValueError:pass
  for kind in ['instance','class']:
   try:
    mr=rp if kind=='instance' else pos(ptr(pos(ptr(pos(cls)))+32)&~7)
    if not u64(mr+32):continue
    ml=ptr(mr+32);mp=pos(ml);flags,count=struct.unpack_from('<II',b,mp)
    for n in range(count):
     entry=mp+8+n*(flags&0xffff)
     if flags&0x80000000:
      ev=ml+8+n*(flags&0xffff);seladdr=ev+i32(entry)
      if not flags&0x40000000:seladdr=ptr(pos(seladdr))
      sel=string(seladdr);imp=ev+8+i32(entry+8);types=string(ev+4+i32(entry+4))
     else:sel=string(ptr(entry));imp=ptr(entry+16);types=string(ptr(entry+8))
     addresses.add(imp)
     if name in selected:rows.append({'class':name,'kind':kind,'selector':sel,'address':hex(imp),'types':types})
   except (ValueError,struct.error):pass
root.joinpath('service-entry-methods.json').write_text(json.dumps(rows,indent=2))
root.joinpath('service-entry-ivars.json').write_text(json.dumps(ivars,indent=2))
chosen={'MMContext':['getService:','unsafeGetServiceWrapper:','currentContext','currentUserName','userName','serviceCenter','activeUserContext'], 'MMServiceCenter':['defaultCenter','getService:','setService:for:'], 'MMServiceWrapper':['unsafeUnwrap','forwardingTargetForSelector:','methodSignatureForSelector:','forwardInvocation:','respondsToSelector:','initWithServiceObj:','strongContextObject','strongContextObjectWithContext:'], 'MMBaseService':['strongContextObject','strongContextObjectWithContext:'], 'CContactMgr':['getSelfContact']}
for row in rows:
 if row['selector'] not in chosen.get(row['class'],[]):continue
 start=int(row['address'],16);end=min((v for v in addresses if v>start),default=start+0x3000);end=min(end,start+0x6000)
 result=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
 regs={};lines=[]
 for line in result.splitlines():
  m=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
  if m:regs[m[1]]=int(m[2],16)
  m=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
  if m and m[1] in regs:
   try:
    s=string(ptr(pos(regs[m[1]]+int(m[2],16))))
    if s and len(s)<180 and all(c.isprintable() for c in s):line+=' ; '+s
   except (ValueError,struct.error):pass
  lines.append(line)
 filename='service-entry-'+row['class']+'-'+row['kind']+'-'+row['selector'].replace(':','_')+'.asm'
 root.joinpath(filename).write_text('\n'.join(lines))
 print(filename,row['address'],hex(end))
