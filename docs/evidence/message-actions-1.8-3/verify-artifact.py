#!/usr/bin/env python3
"""Verify the built deb and decode relevant static MSHookMessageEx registrations.

The small register tracker handles this compiler's straight-line Logos constructors;
it does not emulate general control flow or prove that hooks load on a device.
Run from any directory while production inputs still match the source commit.
"""
from pathlib import Path
import json,re,subprocess
root=Path(__file__).resolve().parents[3]
ev=root/'docs/evidence/message-actions-1.8-3'
p=json.loads((ev/'build-provenance.json').read_text())
package=root/'packages/com.wechat.improve_1.8-3_iphoneos-arm64.deb'
import hashlib,tempfile
assert subprocess.run(['git','merge-base','--is-ancestor',p['source_commit'],'HEAD'],cwd=root).returncode==0
assert not subprocess.check_output(['git','diff',p['source_commit'],'--','Controllers','Hooks','Headers','HeadersFile','Makefile','control','WeChatImprove.plist','layout'],cwd=root,text=True).strip()
prior=json.loads((ev/'prior-packages.json').read_text())
assert all(hashlib.sha256((root/'packages'/name).read_bytes()).hexdigest()==digest for name,digest in prior.items())
assert p['original_theos_unchanged'] and p['original_theos_file_count']==777
assert not subprocess.check_output(['git','status','--porcelain','--','.theos'],cwd=root,text=True).strip()
metadata=subprocess.check_output(['/opt/homebrew/bin/dpkg-deb','-f',str(package)],text=True)
assert 'Version: 1.8-3\n' in metadata and 'Architecture: iphoneos-arm64\n' in metadata
(ev/'package-metadata.txt').write_text(metadata)
contents=subprocess.check_output(['/opt/homebrew/bin/dpkg-deb','-c',str(package)],text=True)
(ev/'package-contents.txt').write_text(contents)
extraction=tempfile.TemporaryDirectory(prefix='wechat-message-actions-artifact-')
subprocess.run(['/opt/homebrew/bin/dpkg-deb','-x',str(package),extraction.name],check=True)
base=Path(extraction.name)/'var/jb/Library/MobileSubstrate/DynamicLibraries'
d=base/'WeChatImprove.dylib'; plist=base/'WeChatImprove.plist'
assert d.is_file() and plist.is_file()
filter_json=subprocess.check_output(['plutil','-convert','json','-o','-',str(plist)],text=True)
assert json.loads(filter_json)['Filter']['Bundles']==['com.tencent.xin']
assert json.loads(filter_json)==json.loads(subprocess.check_output(['plutil','-convert','json','-o','-',str(root/'WeChatImprove.plist')],text=True))
architectures=subprocess.check_output(['xcrun','lipo','-archs',str(d)],text=True).strip().split()
assert set(architectures)=={'arm64','arm64e'}
assert b'1.8-3' in d.read_bytes()
required_classes=['CSMessageActionConfirmation','CSMessageActionContext','CSMessageActionCoordinator','CSMessageActionMenuAdapter','CSMessageActionPreferences','CSMessageActionSettings','CSMessageActionSubmissionLedger','CSMessageCellLifecycleState','CSMessageGestureAdapter','CSMessageMediaProvider','CSMessageNativeActionAdapter','CSMessageNativeEnvironment','CSMessagePreparedSend','CSMessageSendAdapter','CSMessageForwardBinding','CSVoiceForwardAdapter']
required_exports=['CSMessageActionSupportsRepeatMenuType','CSMessageActionNativeObject','CSMessageNativeObject','CSMessageCellPerformBinding','CSMessageCellPerformReuse','CSMessageCellPerformLayout','CSMessageGestureAdapterForCell','CSMessageGestureAccountBoundary','CSMessageActionAccountWillChangeAtNativeBoundary','CSMessageActionAccountDidChangeAtNativeBoundary','CSMessageTimePrepareCell','CSMessageTimeResetCell']
required_hooks={('CommonMessageCellView',x) for x in ['initWithViewModel:','setViewModel:','prepareForReuse','layoutSubviews','updateNodeStatus','onAppear','onDisappear','didMoveToWindow']}
required_hooks|={('VoiceMessageCellView',x) for x in ['setViewModel:','prepareForReuse','layoutSubviews']}
required_hooks|={('MMContextManager',x) for x in ['logout:','loginByContext:']}
required_hooks|={(c,x) for c in ['CommonMessageCellView','TextMessageCellView','ImageMessageCellView','EmoticonMessageCellView','VoiceMessageCellView','VideoMessageCellView','AppEmoticonMessageCellView','AppFileMessageCellView','ShareCardMessageCellView','GameMessageCellView'] for x in ['operationMenuItems','canPerformAction:withSender:']}
required_hooks|={('BaseMessageCellView','onForward:')}
required_hooks|={('ForwardMessageLogicController',x) for x in ['forwardMessage:','OnSharePreConfirmSheetViewSend:','ForwardMsgList:ToContact:WithRevokeBatchId:','ForwardMsg:ToContact:','clearData','bShowSendSuccessView','bHiddenSendSuccessToastView']}
required_hooks|={('ForwardMessageMgr',x) for x in ['OnForwardMessageSend:','OnForwardMessageCancel:','OnForwardMessageConfirmCanceled:']}
required_hooks|={('VoiceMsgDownloader','OnRecvData:MesLocalID:n64MesSvrID:CreateTime:VoiceTime:Offset:Len:Data:EndFlag:ErrNo:')}
manifest={'source_commit':p['source_commit'],'package':str(package.relative_to(root)),'package_sha256':hashlib.sha256(package.read_bytes()).hexdigest(),'dylib_sha256':hashlib.sha256(d.read_bytes()).hexdigest(),'version':'1.8-3','debian_architecture':'iphoneos-arm64','architectures':architectures,'payload_dylib':'var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib','payload_plist':'var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.plist','filter':json.loads(filter_json),'prior_packages_unchanged':prior,'tracked_theos_unchanged':True,'slices':{},'evidence_kind':'static packaged image verification; no device load, install, send or performance measurement'}
for arch in ['arm64','arm64e']:
 def run(args):return subprocess.check_output(['xcrun','otool','-arch',arch]+args+[str(d)],text=True)
 nm=subprocess.check_output(['xcrun','nm','-arch',arch,'-g',str(d)],text=True)
 for c in required_classes: assert '_OBJC_CLASS_$_'+c in nm, (arch,c)
 for symbol in required_exports: assert re.search(r' [TS] _'+symbol+r'$',nm,re.M), (arch,symbol)
 assert 'U _MSHookMessageEx' in nm
 (ev/(arch+'-symbols.txt')).write_text('\n'.join(l for l in nm.splitlines() if 'CSMessage' in l or 'CSVoiceForward' in l or 'MSHookMessageEx' in l)+'\n')
 ov=run(['-ov'])
 for c in required_classes: assert re.search(r' name\s+0x[0-9a-f]+ '+c+r'$',ov,re.M), (arch,c)
 raw=run(['-v','-s','__DATA','__objc_selrefs'])
 decoded=ov.split('Contents of (__DATA,__objc_selrefs) section\n')[1].split('Contents of')[0]
 names=[m.group(1) for l in decoded.splitlines() if (m:=re.match(r'\s+0x[0-9a-f]+ (.+)$',l))]
 addresses=[int(m.group(1),16) for l in raw.splitlines() if (m:=re.match(r'^([0-9a-f]{16})\s+',l))]
 assert len(names)==len(addresses),(len(names),len(addresses))
 sels=dict(zip(addresses,names));regs={};hooks=[]
 disassembly=run(['-tvV']).splitlines()
 for l in disassembly:
  m=re.match(r'^([0-9a-f]{16})\s+(\w+)\s*(.*)$',l)
  if not m:continue
  addr,op,args=m.groups();m=None
  if op=='adrp' and (m:=re.match(r'(x\d+),.*; (0x[0-9a-f]+)',args)):regs[m[1]]=int(m[2],16)
  elif op=='add' and (m:=re.match(r'(x\d+), (x\d+), #(0x[0-9a-f]+|\d+)',args)):
   value=regs.get(m[2]);literal=re.search(r'literal pool for: "([^"]+)"',args)
   regs[m[1]]= ('literal',literal[1]) if literal else value+int(m[3],0) if isinstance(value,int) else None
  elif op=='ldr' and (m:=re.match(r'(x\d+), \[(x\d+)(?:, #(0x[0-9a-f]+|\d+))?\]',args)):
   base=regs.get(m[2]);slot=base+int(m[3] or '0',0) if isinstance(base,int) else None
   regs[m[1]]=('selector',sels[slot]) if slot in sels else None
  elif op=='mov' and (m:=re.match(r'(x\d+), (x\d+)',args)):regs[m[1]]=regs.get(m[2])
  elif op in ('bl','b') and 'symbol stub for:' in args:
   if '_MSHookMessageEx' in args and isinstance(regs.get('x0'),tuple) and regs['x0'][0]=='class' and isinstance(regs.get('x1'),tuple) and regs['x1'][0]=='selector':
    hooks.append({'class':regs['x0'][1],'selector':regs['x1'][1],'registration_address':'0x'+addr,'replacement_imp':hex(regs['x2']) if isinstance(regs.get('x2'),int) else None})
   result=('class',regs['x0'][1]) if '_objc_getClass' in args and isinstance(regs.get('x0'),tuple) and regs['x0'][0]=='literal' else None
   for i in range(19):regs.pop('x'+str(i),None)
   if result:regs['x0']=result
  elif op.startswith('ret'):regs={}
 selected=[h for h in hooks if (h['class'],h['selector']) in required_hooks]
 assert required_hooks<={(h['class'],h['selector']) for h in selected}, (arch,'missing hooks',required_hooks-{(h['class'],h['selector']) for h in selected})
 assert all(h['replacement_imp'] for h in selected)
 (ev/(arch+'-hooks.json')).write_text(json.dumps(selected,indent=2)+'\n')
 selected_addresses={h['registration_address'][2:] for h in selected}
 excerpts=[]
 for i,line in enumerate(disassembly):
  if line.split('\t')[0] in selected_addresses: excerpts.extend(disassembly[max(0,i-12):i+2]+[''])
 (ev/(arch+'-hook-instructions.txt')).write_text('\n'.join(excerpts)+'\n')
 manifest['slices'][arch]={'required_classes':required_classes,'required_exports':required_exports,'required_hook_pairs':len(required_hooks),'matching_registration_sites':len(selected),'selector_reference_count':len(sels)}
(ev/'artifact-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
print('PASS: metadata, payload/filter/version, arm64+arm64e classes/exports and '+str(len(required_hooks))+' required hook pairs per slice; '+str(len(prior))+' prior packages and 777 tracked .theos files unchanged')
print('Source commit: '+p['source_commit'])
print('Package SHA-256: '+manifest['package_sha256'])
extraction.cleanup()
