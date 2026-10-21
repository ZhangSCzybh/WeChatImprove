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
 if cmd==0x2c:encryption=struct.unpack_from('<III',b,off+8)
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

import re,subprocess,hashlib,bisect
out=Path(__file__).parent
classes=json.loads((Path('docs/evidence/message-actions-native-2026-10-17/classes.json')).read_text())
selected=['FTSHomeViewController', 'FTSVoiceSearchBarController', 'WCSearchBar']
starts=[];off=32
for _ in range(u32(16)):
 cmd,sz=struct.unpack_from('<II',b,off)
 if cmd==0x26:
  p,size=struct.unpack_from('<II',b,off+8);end=p+size;addr=0x100000000
  while p<end:
   value=0;shift=0
   while True:
    v=b[p];p+=1;value|=(v&127)<<shift;shift+=7
    if not v&128:break
   if not value:break
   addr+=value;starts.append(addr)
 off+=sz
rows=[];missing=[]
for name in selected:
 if name not in classes:missing.append(name);continue
 ca=int(classes[name],16)
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
   idx=bisect.bisect_right(starts,imp);end=starts[idx] if idx<len(starts) else imp
   row=dict(cls=name,kind=kind,selector=sel,address=hex(imp),end=hex(end),types=typ)
   rows.append(row)
wanted={'FTSHomeViewController': ['doSearch', 'shouldReturnStartSearch', 'mmInputBoxSearchButtonClick', 'mmInputBoxKeyBoardClick', 'textFieldShouldReturn:', 'onTextFieldChanged:', 'mmInputBoxTextChanged:text:', 'mmInputBoxClear', 'doWebSearchWithQuery:', 'onGetTextInput:isFromVoice:', 'onGetTextInputFromNewVoice:voiceId:', 'objectsForListAdapter:', 'reloadSugList', 'updateViewHideStates:'], 'FTSVoiceSearchBarController': ['handleTextDidChange:', 'handleTextDidChange:fromNewVoice:', 'doSearch:', 'doFTSSearch:', 'onClickSearchButton', 'delaySearchImp:', 'delayPardusSearchImp:', 'recordLocalSearchHistory:', 'reloadSearchDataAnimated:isDataFromChanged:', 'reloadSugList', 'fakeSugResultModel', 'searchResultList', 'disableRawQuerySug', 'setDisableRawQuerySug:', 'directJumpToResultPage:isFromNewVoiceInput:'], 'WCSearchBar': ['inputBoxSearchButtonClick', 'inputBoxKeyBoardClick', 'inputBoxTextChanged:isEditing:', 'inputBoxSetTextOnly:', 'inputBoxGetText']}
rows=[row for row in rows if row["selector"] in wanted.get(row["cls"],[])]
(out/'methods.json').write_text(json.dumps(rows,indent=2)+'\n')
sha=hashlib.sha256()
with open('/tmp/wechat-8.0.78-inset-analysis/WeChat','rb') as handle:
 for block in iter(lambda:handle.read(1024*1024),b''):sha.update(block)
(out/'manifest.json').write_text(json.dumps(dict(target='/tmp/wechat-8.0.78-inset-analysis/WeChat',sha256=sha.hexdigest(),static_only=True,classes=selected,missing=missing,encryption=encryption,method_count=len(rows),files={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in out.iterdir() if p.suffix in ['.py','.asm','.json'] and p.name!='manifest.json'}),indent=2)+'\n')
print(json.dumps(dict(methods=len(rows),missing=missing,manifest=str(out/'manifest.json'))))
