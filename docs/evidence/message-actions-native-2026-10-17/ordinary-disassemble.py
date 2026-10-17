"""Bounded ordinary-repeat follow-up; reuse identity and method inventory."""
import json,re,subprocess
from pathlib import Path
out=Path(__file__).parent
exec(out.joinpath('extract.py').read_text().split('import re, subprocess')[0])
methods=json.loads(out.joinpath('methods.json').read_text())
selected={
'CMessageMgr':['ResendMsg:MsgWrap:','AddMsg:MsgWrap:','ResendVideoMsg:MsgWrap:','AddVideoMsg:ToUsr:VideoInfo:MsgType:','AddShortVideoMsg:ToUsr:VideoInfo:','AddVideoMsg:ToUsr:VideoInfo:','AddAppMsg:MsgWrap:Data:Scene:','AddAppMsg:MsgWrap:DataPath:Scene:','AddEmoticonMsg:MsgWrap:','AddRecordMsg:MsgWrap:'],
'CMessageWrap':['copyWithZone:','copyToMsg:'],
'ForwardMsgUtil':['GenForwardVideoFromMsgWrap:','textMsgFromMsgWrap:','imgMsgFromMsgWrap:','appMsgFromMsgWrap:','emojiMsgFromMsgWrap:','cardMsgFromMsgWrap:','locMsgFromMsgWrap:'],
}
for cls in ['AudioUtil','SilkAudioPlayer','OpusAudioPlayer']:
 c=int(json.loads(out.joinpath('classes.json').read_text())[cls],16)
 rp=pos(ptr(pos(ptr(pos(c)))+32)&~7)
 ml=ptr(rp+32);mp=pos(ml);flags,count=struct.unpack_from('<II',b,mp)
 rows=[]
 for n in range(count):
  en=mp+8+n*(flags&0xffff);ev=ml+8+n*(flags&0xffff)
  sa=ev+i32(en)
  if not flags&0x40000000:sa=ptr(pos(sa))
  rows.append({'selector':string(sa),'address':hex(ev+8+i32(en+8)),'types':string(ev+4+i32(en+4))})
 methods[cls]=rows
selected['AudioUtil']=['calcVoiceTime:VoiceFormat:','calcSilkVoiceTime:']
selected['SilkAudioPlayer']=['calculateVoiceTime:']
selected['OpusAudioPlayer']=['calculateVoiceTime:']
lookups=json.loads(out.joinpath('ordinary-lookup-methods.json').read_text())
methods['CExtendInfoOfVoiceMsg']=[{'selector':r['sel'],'address':r['imp'],'types':r['types']} for r in lookups if r['cls']=='CExtendInfoOfVoiceMsg']
selected['CExtendInfoOfVoiceMsg']=['IsDownloadEnded','ChangeForDisplay']
methods['CMessageWrap'] += [{'selector':r['sel'],'address':r['imp'],'types':r['types']} for r in lookups if r['sel']=='GetPathOfAppDataByUserName:andMessageWrap:retStrPath:']
selected['CMessageWrap'] += ['GetPathOfAppDataByUserName:andMessageWrap:retStrPath:','forwardingTargetForSelector:']
selected['CDownloadVoiceMgr']=['OnSyncDownload:LocalID:n64SvrID:CreateTime:Xml:Voice:']
selected['DownloadVoiceCDNMgr']=['OnSyncDownload:LocalID:n64SvrID:CreateTime:Xml:Voice:']
voice_xml=json.loads(out.joinpath('ordinary-voice-xml-methods.json').read_text())
for cls in ['DownloadVoiceCommon','DownloadVoiceWrap']:
 methods[cls]=[{k:r[k] for k in ['selector','address','types']} for r in voice_xml if r['class']==cls]
selected['DownloadVoiceCommon']=['parseVoiceXml:']
selected['DownloadVoiceWrap']=['m_uiVoiceLen','m_uiVoiceTime','m_uiEndFlag']
methods['MMContextManager']=json.loads(out.joinpath('ordinary-context-methods.json').read_text())['methods']
selected['MMContextManager']=['loginByContext:','logout:','activeUserContext','loginContextTimes','loginNonGuestContextTimes']
addresses=sorted({int(r['address'],16) for rows in methods.values() for r in rows})
# These final class methods are followed by instance methods absent from the
# selected inventory; bounds are the next function after the verified return.
exact_ends={0x10017eb6c:0x10017eb80,0x1059f7988:0x1059f7b14,0x1052ad4fc:0x1052ad7f8,0x104b79258:0x104b7931c,0x101174448:0x1011748ac,0x1175dff4c:0x1175e01b4}
index=[]
for cls,sels in selected.items():
 for row in methods[cls]:
  if row['selector'] not in sels:continue
  start=int(row['address'],16);end=exact_ends.get(start) or min(v for v in addresses if v>start)
  assert 0 < end-start < 65536, (cls,row['selector'],hex(start),hex(end))
  raw=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
  regs={};lines=[]
  for line in raw.splitlines():
   m=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
   if m:regs[m[1]]=int(m[2],16)
   m=re.search(r'add\s+x\d+, (x\d+), #(0x[0-9a-f]+)',line)
   if cls=='DownloadVoiceCommon' and m and m[1] in regs:
    try:
     s=string(regs[m[1]]+int(m[2],16))
     if s and len(s)<180 and all(c.isprintable() and c!='�' for c in s):line+=' ; '+s
    except (ValueError,struct.error):pass
   m=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
   if m and m[1] in regs:
    try:
     a=regs[m[1]]+int(m[2],16);s=string(ptr(pos(a)))
     if s and len(s)<180 and all(c.isprintable() and c!='�' for c in s):line+=' ; '+s
    except (ValueError,struct.error):pass
   lines.append(line)
  file='ordinary--'+cls+'--'+row['selector'].replace(':','_')+'.asm'
  out.joinpath(file).write_text('\n'.join(lines))
  index.append({'class':cls,**row,'end':hex(end),'file':file})
out.joinpath('ordinary-methods.json').write_text(json.dumps(index,indent=2)+'\n')
print(json.dumps(index,indent=2))
