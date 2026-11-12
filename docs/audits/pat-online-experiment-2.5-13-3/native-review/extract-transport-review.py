import mmap,struct,json,re,pathlib,sys
P=sys.argv[1] if len(sys.argv)>1 else '/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cef6fcae-2f83-4ef2-9bf6-ff3654f36375/Payload/WeChat.app/WeChat'
OUT=pathlib.Path(sys.argv[2]) if len(sys.argv)>2 else pathlib.Path(__file__).resolve().parent
OUT.mkdir(parents=True,exist_ok=True)
f=open(P,'rb');d=mmap.mmap(f.fileno(),0,access=mmap.ACCESS_READ)
u32=lambda o:struct.unpack_from('<I',d,o)[0]
i32=lambda o:struct.unpack_from('<i',d,o)[0]
u64=lambda o:struct.unpack_from('<Q',d,o)[0]
cstr=lambda o:d[o:d.find(b'\0',o)].decode('utf8','replace')
segs=[];secs={};o=32
for _ in range(u32(16)):
 cmd,sz=struct.unpack_from('<II',d,o)
 if cmd==0x19:
  name=d[o+8:o+24].split(b'\0')[0].decode();vm,vs,fo,fs=struct.unpack_from('<QQQQ',d,o+24);segs.append((vm,vs,fo,fs,name))
  for j in range(u32(o+64)):
   s=o+72+j*80;sn=d[s:s+16].split(b'\0')[0].decode();sg=d[s+16:s+32].split(b'\0')[0].decode();va,n,off=struct.unpack_from('<QQI',d,s+32);secs[(sg,sn)]=(va,n,off)
 o+=sz

def norm(a):
 if a & (1<<63): raise ValueError('bind pointer '+hex(a))
 a &= (1<<36)-1
 return a+0x100000000 if a<0x100000000 else a

def off(a):
 a=norm(a)
 for vm,vs,fo,fs,n in segs:
  if vm<=a<vm+fs:return fo+a-vm
 raise ValueError(hex(a))
def st(a):return cstr(off(a)) if a else None
def ptr(a):return norm(u64(off(a)))
def methods(a):
 if not a:return []
 a=norm(a);p=off(a);flags=u32(p);count=u32(p+4);size=flags&0xffff;small=bool(flags&0x80000000);direct=bool(flags&0x40000000);out=[]
 for j in range(count):
  q=p+8+j*size;v=a+8+j*size
  try:
   if small:
    np=v+i32(q);tp=v+4+i32(q+4);imp=v+8+i32(q+8)
    name=st(np if direct else ptr(np));types=st(tp)
   else:
    name=st(u64(q));types=st(u64(q+8));imp=norm(u64(q+16))
   out.append({'name':name,'types':types,'imp':hex(imp),'entry':hex(v)})
  except Exception as e:out.append({'error':str(e),'entry':hex(v),'flags':hex(flags),'size':size})
 return out

def cls(a):
 p=off(a);isa=u64(p);super=u64(p+8);ro=u64(p+32)&~7;rp=off(ro);name=st(u64(rp+24));meth=methods(u64(rp+32));return name,isa,super,norm(ro),meth


import subprocess,hashlib,uuid,shutil
from pathlib import Path
def section(a):
 for (sg,sn),(v,n,p) in secs.items():
  if v<=a<v+n:return sg,sn,v,n,p
 return None

def desc(a):
 try:
  sec=section(a)
  if not sec:return hex(a)
  sg,sn,*_=sec
  if sn=='__objc_selrefs':return 'selector '+st(ptr(a))
  if sn=='__objc_classrefs':return 'class '+classes.get(ptr(a),hex(ptr(a)))
  if sn=='__cfstring':return 'cfstring '+repr(st(ptr(a+16)))
  if sn in ['__cstring','__objc_methname','__objc_classname']:return repr(st(a))
  if sn=='__objc_ivar':return 'ivar-offset '+str(u32(off(a)))
  return hex(a)+' '+sn
 except Exception as e:return hex(a)+' (?) '+str(e)


# A bounded offline extraction. LC_FUNCTION_STARTS gives function boundaries.
starts=[];o=32;ident={}
for _ in range(u32(16)):
 cmd,sz=struct.unpack_from('<II',d,o)
 if cmd==0x1b:ident['uuid']=str(uuid.UUID(bytes=bytes(d[o+8:o+24]))).upper()
 if cmd==0x26:
  q,n=struct.unpack_from('<II',d,o+8);end=q+n;a=0x100000000
  while q<end:
   value=0;shift=0
   while q<end:
    b=d[q];q+=1;value|=(b&0x7f)<<shift;shift+=7
    if not b&0x80:break
   if value==0:break
   a+=value;starts.append(a)
 o+=sz
classes={int(c['address'],16):c['name'] for c in json.loads(Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/2.5-4/native-upstream/classes.json').read_text())}
j=json.loads(Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/2.5-4/native-upstream/metadata.json').read_text())
def dump_raw(name,start,end=None):
 if end is None:end=next(x for x in starts if x>start)
 raw=subprocess.check_output(['xcrun','llvm-objdump','--disassemble','--start-address='+hex(start),'--stop-address='+hex(end),P],text=True)
 regs={};lines=[]
 for line in raw.splitlines():
  ma=re.search(r'\badrp\s+(x\d+), (0x[0-9a-f]+)',line)
  if ma:regs[ma[1]]=int(ma[2],16)
  ma=re.search(r'\badd\s+(x\d+), (x\d+), #0x([0-9a-f]+)',line)
  if ma and ma[2] in regs:
   regs[ma[1]]=regs[ma[2]]+int(ma[3],16);line+=' ; '+desc(regs[ma[1]])
  ma=re.search(r'\bldr\s+([xw]\d+), \[(x\d+), #0x([0-9a-f]+)\]',line)
  if ma and ma[2] in regs:line+=' ; '+desc(regs[ma[2]]+int(ma[3],16))
  move=re.search(r'\bmov\s+(x\d+), (x\d+)',line)
  if move:
   if move[2] in regs:regs[move[1]]=regs[move[2]]
   else:regs.pop(move[1],None)
  if re.search(r'\bbl\s+',line):
   for ri in range(19):regs.pop('x'+str(ri),None)
  if ma:regs.pop(ma[1],None)
  lines.append(line)
 file=OUT/(name+'.asm')
 if file.exists():raise RuntimeError('Would overwrite '+str(file))
 file.write_text('\n'.join(lines)+'\n');print(name,hex(start),hex(end),len(lines))
 return {'file':file.name,'start':hex(start),'end':hex(end),'method':name}



expected="e484889f7e32adce054e6b19bef373e2d1c3eb6984bc01176bbd40906373f317"
actual=hashlib.sha256(d).hexdigest()
if actual!=expected:raise RuntimeError("Unexpected target hash")
records=[]
for name,start,abi in [('NewSyncService_MessageReturn_Event_',0x105463690,'v28@0:8@16I24'),('TransportSignal_dispatch',0x10b635598,None)]:
 record=dump_raw(name,start);record.update({'abi':abi,'sha256':hashlib.sha256((OUT/record['file']).read_bytes()).hexdigest()});records.append(record)
ident.update({'binary':str(Path(P).resolve()),'sha256':actual,'base':'0x100000000','architecture':'arm64','records':records,'note':'Independent bounded static review of native transport signal and MessageReturn. No target/REA session execution.'})
(OUT/'target.json').write_text(json.dumps(ident,ensure_ascii=False,indent=2)+'\n')
