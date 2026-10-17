import mmap,struct,json
f=open('/tmp/wechat-8.0.78-inset-analysis/WeChat','rb'); b=mmap.mmap(f.fileno(),0,access=mmap.ACCESS_READ)
u=lambda off:struct.unpack_from('<Q',b,off)[0]
segments=[]; sections={}; off=32
for i in range(struct.unpack_from('<I',b,16)[0]):
 cmd,size=struct.unpack_from('<II',b,off)
 if cmd==0x19:
  name=b[off+8:off+24].rstrip(b'\0').decode(); vm,vs,fo,fs=struct.unpack_from('<QQQQ',b,off+24);segments.append((vm,vs,fo,fs))
  for j in range(struct.unpack_from('<I',b,off+64)[0]):
   s=off+72+j*80; sn=b[s:s+16].rstrip(b'\0').decode();sections[sn]=(struct.unpack_from('<Q',b,s+32)[0],struct.unpack_from('<Q',b,s+40)[0],struct.unpack_from('<I',b,s+48)[0])
 off+=size
def offset(a):
 for vm,vs,fo,fs in segments:
  if vm<=a<vm+fs:return a-vm+fo
 raise ValueError(hex(a))
def decode(a):return (a & 0xfffffffff)+0x100000000 if a else 0
def ptr(a):return decode(u(offset(a)))
def string(a):
 o=offset(a);return b[o:b.find(b'\0',o)].decode(errors='replace')
def methods(a):
 if not a:return []
 o=offset(a);flags,n=struct.unpack_from('<II',b,o);sz=flags&0xffff; out=[]
 for k in range(n):
  e=a+8+k*sz
  if flags&0x80000000:
   no,ty,imp=struct.unpack_from('<iii',b,offset(e)); np=e+no
   if not flags&0x40000000:np=ptr(np)
   out.append((string(np),hex(e+8+imp)))
  else:out.append((string(ptr(e)),hex(ptr(e+16))))
 return out

from capstone import *
starts=[]; off=32
for i in range(struct.unpack_from('<I',b,16)[0]):
 cmd,size=struct.unpack_from('<II',b,off)
 if cmd==0x26:
  data,length=struct.unpack_from('<II',b,off+8); value=0;shift=0;addr=0x100000000
  for ch in b[data:data+length]:
   value|=(ch&127)<<shift
   if ch&128:shift+=7;continue
   if not value:break
   addr+=value;starts.append(addr);value=0;shift=0
 off+=size
md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True
out=[]
for start in [0x101b46b80,0x101b4ad6c]:
 end=next(a for a in starts if a>start);regs={};lines=[]
 for ins in md.disasm(b[offset(start):offset(end)],start):
  ops=ins.operands;note=''
  if ins.mnemonic=='adrp':regs[ops[0].reg]=ops[1].imm
  if ins.mnemonic in ('ldr','ldrsw') and len(ops)>1 and ops[1].type==CS_OP_MEM and ops[1].mem.base in regs:
   a=regs[ops[1].mem.base]+ops[1].mem.disp
   selStart,selSize,_=sections['__objc_selrefs']
   try:
    if not selStart<=a<selStart+selSize:raise ValueError('not selector reference')
    text=string(ptr(a))
    if text and text.isprintable() and len(text)<250:note=' ; '+text
   except (ValueError,struct.error):pass
  lines.append(f'{ins.address:x}: {ins.mnemonic} {ins.op_str}'+note)
  for register in ins.regs_access()[1]:regs.pop(register,None)
  if ins.mnemonic=='adrp':regs[ops[0].reg]=ops[1].imm
  if ins.mnemonic in ('bl','blr'):
   for register in list(regs):
    if md.reg_name(register) in [f'x{i}' for i in range(19)]:regs.pop(register,None)
 out.append({'start':hex(start),'end_exclusive':hex(end),'assembly':lines})
print(json.dumps(out,indent=2))
