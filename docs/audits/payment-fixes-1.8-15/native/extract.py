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

import re, subprocess
out=Path(__file__).parent
results={}
ivars={}
classes={}
for (seg,sec),(addr,size,offset) in sections.items():
 if sec!='__objc_classlist':continue
 for off in range(offset,offset+size,8):
  cls=ptr(off)
  try:
   ro=ptr(pos(cls)+32)&~7;rp=pos(ro);name=string(ptr(rp+24))
  except ValueError:continue
  classes[name]=hex(cls)
  chosen=name in ['WXPBGeneratedMessage','WCRedEnvelopesNetworkHelper','WCPayNetworkHelper','WCPayControlData','WCPayReveiverControlTransferControlLogic','WCPayLogicMgr','WCPayControlMgr','WCPayControlLogic','WCBaseControlMgr','WCBizControlLogic','WCRedEnvelopesLogicMgr','WCPayUnionTransferConfirmCgi','WCRedEnvelopesStoryViewController']
  if chosen:
   try:
    ip=pos(ptr(rp+48));iz,ic=struct.unpack_from('<II',b,ip);iv=[]
    for k in range(ic):
     en=ip+8+k*iz;oa=ptr(en)
     iv.append({'offset_address':hex(oa),'offset':u32(pos(oa)),'name':string(ptr(en+8)),'type':string(ptr(en+16))})
    ivars[name]=iv
   except ValueError:pass
  if False:
   meta=ptr(pos(cls));mr=pos(ptr(pos(meta)+32)&~7);rp=mr
  if not u64(rp+32):continue
  ml=ptr(rp+32);mp=pos(ml);flags,count=struct.unpack_from('<II',b,mp);rows=[]
  for n in range(count):
   entry=mp+8+n*(flags&0xffff)
   if flags&0x80000000:
    ev=ml+8+n*(flags&0xffff);seladdr=ev+i32(entry)
    if not flags&0x40000000:seladdr=ptr(pos(seladdr))
    sel=string(seladdr);imp=ev+8+i32(entry+8);types=string(ev+4+i32(entry+4))
   else:sel=string(ptr(entry));imp=ptr(entry+16);types=string(ptr(entry+8))
   if chosen or sel in ['isMsgCanRevoke:','RevokeMsg:','onMsgDownloadVoiceOK:MsgWrap:','OnMsgDownloadVoiceOK:MsgWrap:','OnMsgDownloadVoiceFail:MsgWrap:']:
    rows.append({'selector':sel,'address':hex(imp),'types':types})
  if rows:results[name]=rows
out.joinpath('methods.json').write_text(json.dumps(results,indent=2))
out.joinpath('classes.json').write_text(json.dumps(classes,indent=2))
out.joinpath('ivars.json').write_text(json.dumps(ivars,indent=2))
if __name__=='__main__':
 for name,rows in results.items():
  for row in rows:
   if re.search('Forward|[Vv]oice|SendTable|[Rr]evoke|[Dd]ownload|ToContacts|clearData|[Ss]end:|[Cc]ancel:|SelectSessions',row['selector']):print(name,row)
