from pathlib import Path
import json,struct,re,subprocess
out=Path(__file__).parent
old=out.parent/'message-actions-native-2026-10-17'
exec((old/'extract.py').read_text().split('import re, subprocess')[0])
classes=json.loads((old/'classes.json').read_text())
rows=[]
for name,ca in classes.items():
 for kind,cl in [('instance',int(ca,16)),('class',ptr(pos(int(ca,16))))]:
  try:
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
    rows.append(dict(cls=name,kind=kind,selector=sel,address=hex(imp),types=typ))
  except (ValueError,struct.error):pass
scope={'AudioHelper','AudioUtil','AudioReceiver','AudioSender','SilkAudioPlayer','OpusAudioPlayer','CMessageWrap','CExtendInfoOfVoiceMsg','VoiceMsgDownloader','CDownloadVoiceMgr','DownloadVoiceCDNMgr','DownloadVoiceCommon','DownloadVoiceWrap','ForwardMessageLogicController'}
rows=[r for r in rows if r['cls'] in scope]
out.joinpath('native-voice-all-methods.json').write_text(json.dumps(rows,indent=2))
print('\n'.join(str(r) for r in rows if ('Audio' in r['selector'] and r['cls'] in ['CMessageWrap','AudioFile','AudioUtil']) or (r['cls'] in ['CExtendInfoOfVoiceMsg','AudioPlayer','AudioReceiver'])))
