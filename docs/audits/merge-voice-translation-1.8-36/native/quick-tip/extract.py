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




starts=[];off=32
for _ in range(u32(16)):
 cmd,size=struct.unpack_from('<II',b,off)
 if cmd==0x26:
  p,length=struct.unpack_from('<II',b,off+8);limit=p+length;address=0x100000000
  while p<limit:
   value=0;shift=0
   while True:
    byte=b[p];p+=1;value|=(byte&127)<<shift
    if byte<128:break
    shift+=7
   if value==0:break
   address+=value;starts.append(address)
 off+=size

import subprocess,re,json,bisect
out=Path(__file__).parent
m=json.loads(Path('docs/audits/merge-runtime-1.8-34/native/spacing/metadata.json').read_text())
chosen={'VoiceMessageCellView':['initQuickTransTipButton','updateQuickTransTipButtonPosition','animateShowQuickTransTips','animateHiddenQuickTransTips','translateButtonWidth','layoutContentView','getQuickTransTipsView','initUnreadView'], 'VoiceMessageViewModel':['bShowingQuickTranTips','animateShowQuickTransTips','animateHiddenQuickTransTips','measureContentViewSize:']}
m['classes']['QuickTipBlocks']={'methods':[{'selector':'showAlpha','address':'0x10627958c'},{'selector':'showCompletion','address':'0x1062795c4'},{'selector':'hideAlpha','address':'0x106279700'},{'selector':'hideCompletion','address':'0x106279738'}]}
chosen['QuickTipBlocks']=['showAlpha','showCompletion','hideAlpha','hideCompletion']
for name,sels in chosen.items():
 methods=m['classes'][name]['methods']+m['classes'][name].get('class_methods',[]);addresses=sorted(int(r['address'],16) for r in methods)
 for row in methods:
  if row['selector'] not in sels:continue
  start=int(row['address'],16);end=starts[bisect.bisect_right(starts,start)]
  if name=='BaseChatViewModel' and row['selector']=='messageWrap':end=start+8
  result=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
  regs={};lines=[]
  for line in result.splitlines():
   z=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
   if z:regs[z[1]]=int(z[2],16)
   z=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
   if z and z[1] in regs:
    try:
     s=string(ptr(pos(regs[z[1]]+int(z[2],16))))
     if s and len(s)<180 and all(c.isprintable() for c in s):line+=' ; '+s
    except (ValueError,struct.error):pass
   lines.append(line)
  f=out/(name+'--'+row['selector'].replace(':','_')+'.asm');f.write_text('\n'.join(lines));print(f.name,hex(start),hex(end))
