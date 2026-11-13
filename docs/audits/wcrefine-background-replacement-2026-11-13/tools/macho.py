import struct,mmap,json,bisect,sys
from pathlib import Path
sys.path.insert(0,'/private/tmp/wechat-native-deps-20261113')
import capstone
from capstone.arm64 import *
DEFAULT=None
class MachO:
 def __init__(self,path=DEFAULT):
  self.path=path;self.f=open(path,'rb');self.d=mmap.mmap(self.f.fileno(),0,access=mmap.ACCESS_READ);self.segs=[];self.sections={};self.methods={};self.classes={};self.classaddrs={};self.starts=[];self.symbols={};self.stubs={};self.selrefs={};self.cfstrings={};self.ivars={}
  off=32;nc=self.u32off(16);symtab=None;dysym=None;fs=None;fix=None
  for i in range(nc):
   cmd,size=struct.unpack_from('<II',self.d,off)
   if cmd==0x19:
    name,va,vs,fo,sz,mx,ini,ns,flags=struct.unpack_from('<16sQQQQiiII',self.d,off+8);name=name.rstrip(b'\0').decode();self.segs.append((va,va+sz,fo,name))
    for j in range(ns):
     sn,sg,a,s,o,al,rel,nrel,fl,r1,r2,r3=struct.unpack_from('<16s16sQQ8I',self.d,off+72+j*80);sn=sn.rstrip(b'\0').decode();sg=sg.rstrip(b'\0').decode();self.sections[(sg,sn)]=(a,s,o,fl,r1,r2)
   if cmd==2:symtab=struct.unpack_from('<4I',self.d,off+8)
   if cmd==0xb:dysym=struct.unpack_from('<18I',self.d,off+8)
   if cmd==0x26:fs=struct.unpack_from('<II',self.d,off+8)
   if cmd==0x80000034:fix=struct.unpack_from('<II',self.d,off+8)
   off+=size
  self.base=next(x[0] for x in self.segs if x[3]=='__TEXT');self.fixups=set();self.bindings={}
  if fix:
   foff=fix[0];version,starts,imports,strings,nimp,ifmt,sfmt=struct.unpack_from('<7I',self.d,foff);self.imports=[]
   for i in range(nimp):
    raw=self.u32off(foff+imports+i*(4 if ifmt==1 else 8 if ifmt==2 else 16));nameoff=raw>>9 if ifmt in (1,2) else self.u32off(foff+imports+i*16+4);self.imports.append(self.cstroff(foff+strings+nameoff))
   st=foff+starts;nseg=self.u32off(st)
   for si in range(nseg):
    rel=self.u32off(st+4+si*4)
    if not rel:continue
    sp=st+rel;ss,ps,pfmt,segoff,maxp,npage=struct.unpack_from('<IHHQIH',self.d,sp)
    if pfmt!=6:raise ValueError('unsupported pointer format '+str(pfmt))
    for page in range(npage):
     start=struct.unpack_from('<H',self.d,sp+22+page*2)[0]
     if start==0xffff:continue
     if start&0x8000:
      ai=start&0x7fff;begins=[]
      while True:
       val=struct.unpack_from('<H',self.d,sp+22+ai*2)[0];begins.append(val&0x7fff);ai+=1
       if val&0x8000:break
     else:begins=[start]
     for begin in begins:
      a=self.base+segoff+page*ps+begin
      while True:
       raw=self.u64(a);self.fixups.add(a)
       if raw>>63:
        ordinal=raw&0xffffff
        if ordinal<len(self.imports):self.bindings[a]=self.imports[ordinal]
       delta=(raw>>51)&0xfff
       if not delta:break
       a+=delta*4
  if fs:
   p,end=fs[0],sum(fs);v=self.base
   while p<end:
    delta=0;shift=0
    while p<end:
     b=self.d[p];p+=1;delta|=(b&127)<<shift;shift+=7
     if not b&128:break
    if not delta:break
    v+=delta;self.starts.append(v)
  self.symnames=[]
  if symtab:
   so,n,stro,strsz=symtab
   for i in range(n):
    sx,typ,sect,desc,val=struct.unpack_from('<IBBHQ',self.d,so+i*16);name=self.cstroff(stro+sx) if sx else '';self.symnames.append(name)
    if val and name:self.symbols[val]=name
  if dysym:
   io,ni=dysym[12:14]
   indirect=struct.unpack_from('<'+str(ni)+'I',self.d,io)
   for (sg,sn),(a,s,o,fl,r1,r2) in self.sections.items():
    if fl&255==8 and r2:
     for j in range(s//r2):
      idx=indirect[r1+j]
      if idx<len(self.symnames):self.stubs[a+j*r2]=self.symnames[idx]
  if dysym:
   for (sg,sn),(a,s,o,fl,r1,r2) in self.sections.items():
    if fl&255 in (6,7):
     for j in range(s//8):
      idx=indirect[r1+j]
      if idx<len(self.symnames):self.bindings[a+j*8]=self.symnames[idx]
  sec=self.section('__objc_selrefs')
  if sec:
   for a in range(sec[0],sec[0]+sec[1],8):
    try:self.selrefs[a]=self.cstr(self.ptr(a))
    except (ValueError,IndexError):pass
  sec=self.section('__cfstring')
  if sec:
   for a in range(sec[0],sec[0]+sec[1],32):
    try:
     flags=self.u64(a+8);ptr=self.ptr(a+16);n=self.u64(a+24);o=self.offset(ptr)
     if n<10000:self.cfstrings[a]=bytes(self.d[o:o+n*(2 if flags&16 else 1)]).decode('utf-16le' if flags&16 else 'utf-8',errors='replace')
    except (ValueError,IndexError):pass
  sec=self.section('__objc_classlist')
  if sec:
   for a in range(sec[0],sec[0]+sec[1],8):
    try:
     cl=self.ptr(a);ro=self.ptr(cl+32)&~7;name=self.cstr(self.ptr(ro+24));self.classes[name]=cl;self.classaddrs[cl]=name
    except (ValueError,IndexError):pass
 def u32off(self,o):return struct.unpack_from('<I',self.d,o)[0]
 def offset(self,a):
  for lo,hi,fo,n in self.segs:
   if lo<=a<hi:return fo+a-lo
  raise ValueError(hex(a))
 def u64(self,a):return struct.unpack_from('<Q',self.d,self.offset(a))[0]
 def ptr(self,a):
  raw=self.u64(a)
  if a not in self.fixups:return raw
  if raw>>63:return 0
  return (self.base+(raw&0xfffffffff))|(((raw>>36)&0xff)<<56)
 def u32(self,a):return struct.unpack_from('<I',self.d,self.offset(a))[0]
 def i32(self,a):return struct.unpack_from('<i',self.d,self.offset(a))[0]
 def cstroff(self,o):
  e=self.d.find(b'\0',o,min(o+65536,len(self.d)));return bytes(self.d[o:e if e>=o else o]).decode('utf-8',errors='replace')
 def cstr(self,a):return self.cstroff(self.offset(a))
 def section(self,name):return next((s for (sg,sn),s in self.sections.items() if sn==name),None)
 def methods_for(self,name):
  if name not in self.classes:return []
  cl=self.classes[name];out=[]
  for prefix,c in [('-',cl),('+',self.ptr(cl))]:
   try:
    ro=self.ptr(c+32)&~7;ml=self.ptr(ro+32);iv=self.ptr(ro+48)
    if iv:
     ivsize=self.u32(iv);ivcount=self.u32(iv+4)
     for j in range(ivcount):
      p=iv+8+j*ivsize;offptr=self.ptr(p);ivname=self.cstr(self.ptr(p+8));self.ivars[offptr]=name+'.'+ivname
    if not ml:continue
    flags=self.u32(ml);count=self.u32(ml+4);small=bool(flags&0x80000000);size=flags&0xffff;size&=~3
    if count>100000:raise ValueError('method count')
    for i in range(count):
     p=ml+8+i*size
     if small:
      np=p+self.i32(p);np=np if flags&0x40000000 else self.ptr(np);tp=p+4+self.i32(p+4);imp=p+8+self.i32(p+8)
     else:np,tp,imp=self.ptr(p),self.ptr(p+8),self.ptr(p+16)
     sel=self.cstr(np);types=self.cstr(tp);label=f'{prefix}[{name} {sel}]';rec={'class':name,'selector':sel,'type':types,'address':hex(imp),'label':label};out.append(rec);self.methods[imp]=label
   except (ValueError,IndexError,struct.error) as e:out.append({'error':str(e),'class':name})
  return out
 def bounds(self,a):
  idx=bisect.bisect_right(self.starts,a)
  return (self.starts[idx-1] if idx else a,self.starts[idx] if idx<len(self.starts) else a+4096)
 def describe(self,a):
  if a in self.methods:return self.methods[a]
  if a in self.stubs:return self.stubs[a]
  if a in self.symbols:return self.symbols[a]
  if a in self.selrefs:return '@selector('+self.selrefs[a]+')'
  if a in self.cfstrings:return '@'+repr(self.cfstrings[a])
  if a in self.classaddrs:return 'Class '+self.classaddrs[a]
  if a in self.ivars:return 'ivar_offset '+self.ivars[a]+'='+hex(self.u32(a))
  if a in self.bindings:return self.bindings[a]
  try:
   p=self.ptr(a)
   if p in self.classaddrs:return 'classref '+self.classaddrs[p]
  except (ValueError,IndexError):pass
  try:
   for (sg,sn),(v,s,*_) in self.sections.items():
    if v<=a<v+s and sn in ('__cstring','__objc_methname'):return repr(self.cstr(a))
  except (ValueError,IndexError):pass
  return ''
 def branch_name(self,a):
  seen=set()
  for i in range(8):
   if a in seen:break
   seen.add(a);desc=self.describe(a)
   if desc:return desc
   try:
    ins=self.u32(a)
    if ins&0xfc000000!=0x14000000:break
    imm=ins&0x3ffffff
    if imm&0x2000000:imm-=0x4000000
    a+=imm*4
   except ValueError:break
  return ''
 def disasm(self,a,end=None):
  _,bound=self.bounds(a);end=end or bound;end=min(end,a+65536);off=self.offset(a);md=capstone.Cs(capstone.CS_ARCH_ARM64,capstone.CS_MODE_LITTLE_ENDIAN);md.detail=True;regs={};lines=[]
  def rn(op):return md.reg_name(op.reg)
  for ins in md.disasm(bytes(self.d[off:off+end-a]),a):
   ops=ins.operands;ann=[]
   try:
    if ins.mnemonic in ('adrp','adr') and len(ops)==2:regs[rn(ops[0])]=ops[1].imm
    elif ins.mnemonic=='add' and len(ops)==3 and ops[2].type==ARM64_OP_IMM:
     src=regs.get(rn(ops[1]));regs[rn(ops[0])]=src+ops[2].imm if src is not None else None
    elif ins.mnemonic=='mov' and len(ops)==2:
     regs[rn(ops[0])]=regs.get(rn(ops[1])) if ops[1].type==ARM64_OP_REG else ops[1].imm if ops[1].type==ARM64_OP_IMM else None
    elif ins.mnemonic in ('ldr','ldur','ldrsw') and len(ops)==2:
     dst=rn(ops[0]);mem=ops[1]
     if mem.type==ARM64_OP_MEM:
      base=regs.get(md.reg_name(mem.mem.base));addr=base+mem.mem.disp if base is not None else None
      if addr is not None:
       desc=self.describe(addr)
       if desc:ann.append(desc)
       try:regs[dst]=self.ptr(addr) if dst.startswith('x') else self.u32(addr)
       except ValueError:regs[dst]=None
      else:regs[dst]=None
    if ops and ops[0].type==ARM64_OP_REG:
     val=regs.get(rn(ops[0]));desc=self.describe(val) if val is not None else ''
     if desc and desc not in ann:ann.append(desc)
    if ins.mnemonic in ('bl','b') and ops[0].type==ARM64_OP_IMM:
     target=ops[0].imm;desc=self.branch_name(target)
     if desc:ann.append(desc)
     sel=regs.get('x1')
     if 'objc_msgSend' in desc and sel is not None:
      try:ann.append('selector='+self.cstr(sel))
      except ValueError:pass
    if ins.mnemonic=='bl':
     for r in range(19):regs['x'+str(r)]=None;regs['w'+str(r)]=None
   except (ValueError,IndexError,struct.error):pass
   lines.append(f'{ins.address:#x}: {ins.mnemonic:8} {ins.op_str}'+(' ; '+' | '.join(ann) if ann else ''))
  return '\n'.join(lines)+'\n'
if __name__=='__main__':
 import argparse
 p=argparse.ArgumentParser();p.add_argument('classes',nargs='*');p.add_argument('--binary',required=True);p.add_argument('--out',default='/private/tmp/wechat-native-pat-fresh');p.add_argument('--address');args=p.parse_args();m=MachO(args.binary);out=Path(args.out);out.mkdir(parents=True,exist_ok=True)
 if args.address:
  a=int(args.address,0);print(m.disasm(a));sys.exit()
 names=args.classes or ['WCRefineBackgroundKeepAlive'];index={name:m.methods_for(name) for name in names};(out/'methods.json').write_text(json.dumps(index,ensure_ascii=False,indent=2));(out/'classes.json').write_text(json.dumps(m.classes,ensure_ascii=False));print(json.dumps({k:len(v) for k,v in index.items()}))
 for name,methods in index.items():
  for rec in methods:
   if 'address' not in rec:continue
   a=int(rec['address'],0);filename=name+'_'+rec['selector'].replace(':','_').replace('/','_')+'.asm';(out/filename).write_text(rec['label']+' '+rec['address']+' '+rec['type']+'\n'+m.disasm(a))
