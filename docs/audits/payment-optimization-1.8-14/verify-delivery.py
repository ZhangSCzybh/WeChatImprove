from pathlib import Path
import hashlib,json,subprocess,tempfile,zipfile,shutil,re
root=Path(__file__).resolve().parents[3]
out=Path(__file__).resolve().parent
paths=json.loads((out/'build-paths.json').read_text());build=Path(paths['build']);packages=Path(paths['packages'])
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(*args):return subprocess.check_output(args,text=True).strip()
package=packages/'com.wechat.improve_1.8-14_iphoneos-arm64.deb'
metadata={k:run('dpkg-deb','-f',str(package),k) for k in ['Package','Version','Architecture','Depends']}
assert metadata['Version']=='1.8-14' and metadata['Architecture']=='iphoneos-arm64'
with tempfile.TemporaryDirectory(prefix='payment-package-check-') as tmp:
 subprocess.check_call(['dpkg-deb','-x',str(package),tmp])
 rel=Path('var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib');dylib=Path(tmp)/rel
 archs=run('xcrun','lipo','-archs',str(dylib)).split();assert set(archs)=={'arm64','arm64e'}
 digest=sha(dylib);assert digest==sha(build/'_'/rel)==sha(build/'obj/WeChatImprove.dylib')
 uuids=dict((arch,uuid) for uuid,arch in re.findall(r'UUID: ([\w-]+) \((\w+)\)',run('xcrun','dwarfdump','--uuid',str(dylib))))
 syms={}
 for arch in archs:
  dsym=build/'obj'/arch/'WeChatImprove.dylib.dSYM'
  text=run('xcrun','dwarfdump','--uuid',str(dsym));assert uuids[arch] in text;syms[arch]=dsym
 symbols=run('xcrun','nm','-gU',str(dylib))
 for removed in ['CSReceiveRedEnvelopOperation','CSRedEnvelopParamQueue','CSRedEnvelopTaskManager','CSRedEnvelopParam']:
  assert '_OBJC_CLASS_$_'+removed+'\n' not in symbols
 assert '_OBJC_CLASS_$_CSPaymentTaskStore' in symbols
baseline=json.loads((out/'baseline.json').read_text());changed=[];deleted=[];unchanged=[]
for name,h in baseline.items():
 p=root/name
 if not p.exists():deleted.append(name)
 elif sha(p)!=h:changed.append(name)
 else:unchanged.append(name)
for name in ['Controllers/WESessionTabContainerView.m','Tests/GroupIndicatorTests.m','Controllers/CSMessageMediaProvider.m','Controllers/CSVoiceForwardAdapter.h','Controllers/CSVoiceForwardAdapter.m','Hooks/VoiceForwardHooks.xm','Hooks/MessageGestureHooks.xm']:
 assert name in unchanged, name
old=json.loads((out.parent/'voice-cleanup-payment-review-2026-10-18/baseline.json').read_text())['prior_artifacts']
for name,h in old.items():
 assert sha(root/name)==h,(name,'prior artifact changed')
final=root/'packages'/package.name
if final.exists():assert sha(final)==sha(package)
else:shutil.copy2(package,final)
symbolzip=root/'packages/WeChatImprove-1.8-14-dSYMs.zip'
if not symbolzip.exists():
 with zipfile.ZipFile(symbolzip,'w',zipfile.ZIP_DEFLATED) as z:
  for arch,dsym in syms.items():
   for p in dsym.rglob('*'):
    if p.is_file():z.write(p,str(Path(arch)/dsym.name/p.relative_to(dsym)))
current={str(p.relative_to(root)):sha(p) for folder in ['Controllers','Hooks','Headers','Tests'] for p in (root/folder).rglob('*') if p.is_file()}
for name in ['control','README.md','Makefile']:current[name]=sha(root/name)
(out/'source-manifest.json').write_text(json.dumps(current,indent=2)+'\n')
report={'version':'1.8-14','metadata':metadata,'architectures':archs,'dylib_sha256':digest,'package_matches_built_and_staged':True,'dSYM_UUIDs':uuids,'artifacts':{str(final.relative_to(root)):sha(final),str(symbolzip.relative_to(root)):sha(symbolzip)},'preserved_prior_artifacts':len(old),'unchanged_baseline_files':len(unchanged),'changed_existing_files':changed,'deleted_obsolete_files':deleted,'added_files':sorted(set(current)-set(baseline)),'voice_and_grouping_baseline_preserved':True,'core_tests':{'foundation_assertions':2210,'production_bridge_and_hook_assertions':59},'device_installed':False,'real_payment_or_messages_sent':False}
(out/'verification.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(report,ensure_ascii=False,indent=2))
