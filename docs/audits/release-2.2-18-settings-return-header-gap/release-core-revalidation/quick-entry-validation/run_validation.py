#!/usr/bin/env python3
"""Run production avatar methods and real runtime with isolated UIKit/storage doubles."""
from pathlib import Path
import sys,subprocess,json,hashlib,tempfile
A=Path(__file__).resolve().parent
ROOT=Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
SOURCE=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else ROOT
LABEL=sys.argv[2] if len(sys.argv)>2 else 'green'
OUT=A/LABEL;OUT.mkdir(exist_ok=True)
(OUT/'test-source.m').write_bytes((A/'QuickEntryTests.m').read_bytes())
(OUT/'runner.py').write_bytes(Path(__file__).read_bytes())
def extract(text,prefix):
 start=text.index(prefix); opening=text.index('{',start); depth=1;pos=opening+1
 while depth:
  depth+=(text[pos]=='{')-(text[pos]=='}');pos+=1
 return text[start:pos]
custom=(SOURCE/'Controllers/CSCustomViewController.m').read_text()
prefixes=['- (void)installCloseFriendEntryGesture','- (BOOL)canDiscoverCloseFriendEntry','- (BOOL)gestureRecognizer:', '- (void)discoverCloseFriendEntry:','- (void)resetCloseFriendQuickEntry','- (NSTimeInterval)closeFriendQuickEntryTimestamp','- (void)tapCloseFriendQuickEntry:','- (void)confirmCloseFriendQuickEntryWithToken:','- (void)finishCloseFriendQuickEntryAlert:','- (BOOL)closeFriendQuickEntryTokenIsCurrent:']
methods=[extract(custom,p) for p in prefixes if p in custom]
(OUT/'CustomMethods.h').write_text('\n'.join(methods))
(OUT/'CustomDeclarations.h').write_text('\n'.join(m[:m.index('{')].strip()+';' for m in methods))
settings=(SOURCE/'Controllers/CSCloseFriendSettingsViewController.m').read_text()
prefixes=['- (BOOL)authorized','- (NSDictionary *)settingsProfile','- (void)invalidateQuickEntry','- (void)viewWillDisappear:','- (BOOL)settingsTokenIsCurrent:','- (void)willMoveToParentViewController:','- (void)save:']
methods=[extract(settings,p) for p in prefixes if p in settings]
(OUT/'SettingsMethods.h').write_text('\n'.join(methods))
(OUT/'SettingsDeclarations.h').write_text('\n'.join(m[:m.index('{')].strip()+';' for m in methods))
manager=(SOURCE/'Controllers/CSCloseFriendManager.m').read_text()
start=manager.index('_runtime.resetStorage=');opening=manager.index('{',start);depth=1;pos=opening+1
while depth:
 depth+=(manager[pos]=='{')-(manager[pos]=='}');pos+=1
(OUT/'ManagerResetStorageUnderTest.h').write_text(manager[start:pos+1]+'\n')
names=['CSCloseFriendEntryState','CSCloseFriendReset','CSCloseFriendCrypto','CSCloseFriendPolicy','CSCloseFriendStore','CSCloseFriendRuntime','CSPluginStorage']
sources=[SOURCE/'Controllers'/f'{n}.m' for n in names]
cmd=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-nonnull','-Wno-incomplete-implementation','-Wno-objc-property-implementation','-framework','Foundation','-framework','Security','-I'+str(SOURCE/'Controllers'),'-I'+str(OUT),*map(str,sources),str(A/'QuickEntryTests.m'),'-o',str(OUT/'quick-tests')]
p=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT);(OUT/'compile.log').write_text(p.stdout)
if p.returncode:print(p.stdout);sys.exit(p.returncode)
with tempfile.TemporaryDirectory(prefix='wci-2216-quick-') as temp:
 p=subprocess.run([str(OUT/'quick-tests'),temp],text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
(OUT/'run.log').write_text(p.stdout);print(p.stdout)
manifest={'source':str(SOURCE),'label':LABEL,'exit':p.returncode,'production_sha256':{str(p.relative_to(SOURCE)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [*sources,SOURCE/'Controllers/CSCustomViewController.m',SOURCE/'Controllers/CSCloseFriendSettingsViewController.m']},'test_sha256':hashlib.sha256((A/'QuickEntryTests.m').read_bytes()).hexdigest(),'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(OUT/'provenance.json').write_text(json.dumps(manifest,indent=2)+'\n');sys.exit(p.returncode)
