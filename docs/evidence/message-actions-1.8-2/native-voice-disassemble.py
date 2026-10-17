from pathlib import Path
import json,struct,re,subprocess,sys
out=Path(__file__).parent; old=out.parent/'message-actions-native-2026-10-17'
exec((old/'extract.py').read_text().split('import re, subprocess')[0])
rows=json.loads((out/'native-voice-all-methods.json').read_text())
starts=[]; off=32
for _ in range(u32(16)):
 cmd,sz=struct.unpack_from('<II',b,off)
 if cmd==0x26:
  p,size=struct.unpack_from('<II',b,off+8);end=p+size;addr=0x100000000
  while p<end:
   val=0;shift=0
   while True:
    v=b[p];p+=1;val|=(v&127)<<shift;shift+=7
    if not v&128:break
   if not val:break
   addr+=val;starts.append(addr)
 off+=sz
selected={
'CMessageWrap':['getPathOfAudio:','getVoicePath','getVoiceFormat'],
'CExtendInfoOfVoiceMsg':['ChangeForDisplay','UpdateContent:','SaveMesVoice:','IsRecording','SetPlayed','SetPlaySounded:'],
'VoiceMsgDownloader':['onServiceInit','init','Start','downloadMsg:'],
'AudioSender':['OnRecorderPart:Offset:Len:EndFlag:ForceDelete:Duration:','OnRecorderEndRecording:'],
'AudioReceiver':['StartPlay:Path:fromTime:'],
'ForwardMessageLogicController':['shouldShowSendSuccessView:','bShowSendSuccessView','bHiddenSendSuccessToastView','showSendSuccessView','onSendSuccess']}
if len(sys.argv)>1:selected=json.loads(sys.argv[1])
index=[]
for r in rows:
 if r['selector'] not in selected.get(r['cls'],[]):continue
 start=int(r['address'],16);end=min(v for v in starts if v>start)
 raw=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
 regs={};lines=[]
 for line in raw.splitlines():
  m=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
  if m:regs[m[1]]=int(m[2],16)
  m=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
  if m and m[1] in regs:
   try:
    s=string(ptr(pos(regs[m[1]]+int(m[2],16))))
    if s and len(s)<180 and all(c.isprintable() and c!='�' for c in s):line+=' ; '+s
   except (ValueError,struct.error):pass
  lines.append(line)
 file='native-voice-'+r['cls']+'-'+r['kind']+'-'+r['selector'].replace(':','_')+'.asm'
 out.joinpath(file).write_text('\n'.join(lines)+'\n');index.append({**r,'end':hex(end),'file':file})
p=out/'native-voice-selected-methods.json';prior=json.loads(p.read_text()) if p.exists() else []; d={r['file']:r for r in prior+index};p.write_text(json.dumps(list(d.values()),indent=2))
print(json.dumps(index,indent=2))
