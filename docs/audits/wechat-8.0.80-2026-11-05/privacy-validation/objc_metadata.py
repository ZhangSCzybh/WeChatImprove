#!/usr/bin/env python3
"""Offline Objective-C metadata reader for supplied arm64 userland Mach-O.
Parses observed DYLD_CHAINED_PTR_64 rebases. Does not execute target.
"""
import argparse,json,mmap,struct
from pathlib import Path
class MachO:
 def __init__(self,path):
  self.path=Path(path);self.handle=self.path.open('rb');self.b=mmap.mmap(self.handle.fileno(),0,access=mmap.ACCESS_READ);self.segments=[];self.sections={};self.fixups=None;off=32
  assert self.u32(0)==0xfeedfacf,'requires thin little-endian Mach-O 64'
  for _ in range(self.u32(16)):
   cmd,size=struct.unpack_from('<II',self.b,off)
   if cmd==0x19:
    name=self.b[off+8:off+24].split(b'\0')[0].decode();vm,vs,fo,fs=struct.unpack_from('<QQQQ',self.b,off+24);self.segments.append((vm,vs,fo,fs));ns=self.u32(off+64)
    for i in range(ns):
     p=off+72+i*80;sn=self.b[p:p+16].split(b'\0')[0].decode();addr,sz,ofs=struct.unpack_from('<QQI',self.b,p+32);self.sections[(name,sn)]=(addr,sz,ofs)
   if cmd==0x80000034:self.fixups=struct.unpack_from('<II',self.b,off+8)[0]
   off+=size
  self.base=min(s[0] for s in self.segments if s[3]);self.classmap={}
  _,size,ofs=self.sections[('__DATA_CONST','__objc_classlist')]
  for i in range(0,size,8):
   c=self.ptr(ofs+i);ro=self.ptr(c+32)&~7;name=self.cstr(self.ptr(ro+24));self.classmap[name]=(c,ro)
 def u32(self,o):return struct.unpack_from('<I',self.b,o)[0]
 def u64(self,o):return struct.unpack_from('<Q',self.b,o)[0]
 def vmoff(self,addr):
  for vm,vs,fo,fs in self.segments:
   if vm<=addr<vm+fs:return fo+addr-vm
  raise ValueError(hex(addr))
 def ptr(self,o):
  raw=self.u64(o)
  if not raw:return 0
  if raw&(1<<63):raise ValueError('bind/external pointer at '+hex(o))
  target=raw&0xffffffff
  return self.vmoff(self.base+target)
 def bindname(self,raw):
  assert self.fixups is not None and raw&(1<<63)
  _,_,imports,symbols,_,fmt,_=struct.unpack_from('<7I',self.b,self.fixups)
  assert fmt in [1,2], 'unsupported import format'
  entry=self.u32(self.fixups+imports+(raw&0xffffff)*(4 if fmt==1 else 8))
  return self.cstr(self.fixups+symbols+(entry>>9))
 def cstr(self,o):return self.b[o:self.b.find(b'\0',o)].decode()
 def classname(self,c):return self.cstr(self.ptr((self.ptr(c+32)&~7)+24))
 def methods(self,ro):
  m=self.ptr(ro+32)
  if not m:return []
  flags,n=struct.unpack_from('<II',self.b,m);r=[]
  for j in range(n):
   e=m+8+j*(flags&0xffff)
   if flags&0x80000000:
    x,y,z=struct.unpack_from('<iii',self.b,e);name=e+x;name=name if flags&0x40000000 else self.ptr(name);typ=e+4+y;imp=e+8+z
   else:name,typ,imp=[self.ptr(e+k) for k in [0,8,16]]
   r.append({'selector':self.cstr(name),'encoding':self.cstr(typ),'imp':hex(self.base+imp),'metadata_offset':hex(e)})
  return r
 def readclass(self,name):
  c,ro=self.classmap[name]
  try:supername=self.bindname(self.u64(c+8)).removeprefix('_OBJC_CLASS_$_') if self.u64(c+8)&(1<<63) else self.classname(self.ptr(c+8))
  except (ValueError,IndexError,struct.error):supername='external/bind'
  iv=self.ptr(ro+48);ivars=[]
  if iv:
   es,n=struct.unpack_from('<II',self.b,iv)
   for j in range(n):
    e=iv+8+j*es;ivars.append({'name':self.cstr(self.ptr(e+8)),'encoding':self.cstr(self.ptr(e+16))})
  return {'name':name,'class_offset':hex(c),'superclass':supername,'methods':self.methods(ro),'ivars':ivars}
if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('binary');ap.add_argument('classes',nargs='*');ap.add_argument('--filter',default='');a=ap.parse_args();m=MachO(a.binary)
 names=a.classes or [n for n in m.classmap if a.filter in n]
 print(json.dumps({'binary':str(m.path),'base':hex(m.base),'classes':[m.readclass(n) for n in names]},ensure_ascii=False,indent=2))
