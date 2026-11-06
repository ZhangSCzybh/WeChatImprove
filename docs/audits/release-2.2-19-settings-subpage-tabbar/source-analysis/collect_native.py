#!/usr/bin/env python3
"""Read-only native navigation evidence; never executes or mutates the WeChat image."""
import hashlib,importlib.util,json,pathlib,subprocess
root=pathlib.Path(__file__).resolve().parents[4]
out=pathlib.Path(__file__).resolve().parent
binary=pathlib.Path('/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat')
reader=root/'docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/objc_metadata.py'
annotator=root/'docs/audits/wechat-8.0.80-2026-11-05/merge-validation/inspect_objc.py'
digest=lambda p:hashlib.file_digest(pathlib.Path(p).open('rb'),'sha256').hexdigest()
assert digest(binary)=='571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9'
spec=importlib.util.spec_from_file_location('metadata',reader);mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
image=mod.MachO(binary);cache={n:image.readclass(n) for n in image.classmap}
classes=['MMUIViewController','MMUINavigationController','MMTabBarBaseNavigationController','WCTabBarBaseNavigationController','MMTabBarController','WCTabBarController']
(out/'native-class-metadata.json').write_text(json.dumps({'binary':str(binary),'sha256':digest(binary),'classes':[cache[n] for n in classes]},ensure_ascii=False,indent=2)+'\n')
targets={
'MMUIViewController':['initWithNibName:bundle:','viewWillAppear:','viewDidAppear:'],
'MMTabBarBaseNavigationController':['PushViewController:animated:isForceFullScreen:isAutoRotatePortrait:completion:'],
'WCTabBarBaseNavigationController':['pushViewController:animated:','navigationController:willShowViewController:animated:','navigationController:didShowViewController:animated:'],
'WCTabBarController':['tabBarNavigationController:willPushViewController:animated:','tabBarNavigationController:willShowViewController:animated:','tabBarNavigationController:didShowViewController:animated:','transitionForNavigationController:destinationViewController:animated:','prepareTabBarForTransition:','beginTabBarTransition:','syncTabBarVisibilityForNavigationController:','finishTabBarTransition:cancelled:','setTabBarHidden:animated:']}
starts=sorted({int(m['imp'],16) for c in cache.values() for m in c['methods']});commands=[]
for cls,selectors in targets.items():
 for selector in selectors:
  method=next(m for m in cache[cls]['methods'] if m['selector']==selector)
  start=int(method['imp'],16);stop=next(a for a in starts if a>start)
  name=cls+'-'+selector.replace(':','_')+'.asm'
  command=['xcrun','llvm-objdump','--disassemble','--start-address='+hex(start),'--stop-address='+hex(stop),str(binary)]
  (out/name).write_text(subprocess.check_output(command,text=True));commands.append({'command':command,'output':name,'start':hex(start),'stop':hex(stop)})
command=['python3',str(annotator),str(binary),*classes,'--annotate-directory',str(out)]
(out/'annotator-metadata.json').write_text(subprocess.check_output(command,text=True));commands.append({'command':command,'output':'annotator-metadata.json'})
(out/'commands.json').write_text(json.dumps(commands,ensure_ascii=False,indent=2)+'\n')
(out/'native-provenance.json').write_text(json.dumps({'binary':str(binary),'binary_sha256':digest(binary),'metadata_reader':str(reader),'metadata_reader_sha256':digest(reader),'annotator':str(annotator),'annotator_sha256':digest(annotator),'scope':'Offline metadata and targeted disassembly. This establishes static calls and policies, not process execution or actual runtime view values.'},ensure_ascii=False,indent=2)+'\n')
print('Wrote',len(commands)-1,'native method disassemblies; binary SHA256 matched.')
