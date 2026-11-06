#!/usr/bin/env python3
from pathlib import Path
import sys,subprocess,json,hashlib
A=Path(__file__).resolve().parent
SOURCE=Path(sys.argv[1]).resolve();LABEL=sys.argv[2];OUT=A/LABEL;OUT.mkdir(exist_ok=True)
def extract(text,prefix):
 start=text.index(prefix);opening=text.index('{',start);depth=1;pos=opening+1
 while depth:depth+=(text[pos]=='{')-(text[pos]=='}');pos+=1
 return text[start:pos]
manager=(SOURCE/'Controllers/CSCloseFriendManager.m').read_text()
prefixes=['- (void)refreshAccount','- (BOOL)validateToken:','- (BOOL)canResetFrom:','- (void)finishResetAlert:','- (void)confirmResetFrom:','- (void)resetFrom:(UIViewController *)presenter completion:','- (void)resetFrom:(UIViewController *)presenter settingsToken:']
methods=[extract(manager,p) for p in prefixes if p in manager]
(OUT/'ManagerMethods.h').write_text('\n'.join(methods));(OUT/'ManagerDeclarations.h').write_text('\n'.join(m[:m.index('{')].strip()+';' for m in methods))
start=manager.index('_runtime.resetStorage=');opening=manager.index('{',start);depth=1;pos=opening+1
while depth:depth+=(manager[pos]=='{')-(manager[pos]=='}');pos+=1
(OUT/'ManagerResetStorageUnderTest.h').write_text(manager[start:pos+1]+'\n')
settings=(SOURCE/'Controllers/CSCloseFriendSettingsViewController.m').read_text()
prefixes=['- (BOOL)authorized','- (BOOL)settingsTokenIsCurrent:','- (void)invalidateQuickEntry','- (void)resetCloseFriends']
methods=[extract(settings,p) for p in prefixes]
route=extract(settings,'- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:')
end=route.index('NSDictionary *token=')
route=route[:end]+'}'
route=route.replace('(UITableView *)','(TableView *)')
methods.append(route)
(OUT/'SettingsMethods.h').write_text('\n'.join(methods));(OUT/'SettingsDeclarations.h').write_text('\n'.join(m[:m.index('{')].strip()+';' for m in methods))
sources=[SOURCE/'Controllers'/f'{n}.m' for n in ['CSCloseFriendEntryState','CSCloseFriendReset','CSCloseFriendCrypto','CSCloseFriendPolicy','CSCloseFriendStore','CSCloseFriendRuntime','CSPluginStorage']]
(OUT/'test-source.m').write_bytes((A/'QuickResetTests.m').read_bytes());(OUT/'runner.py').write_bytes(Path(__file__).read_bytes())
cmd=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-nonnull','-Wno-incomplete-implementation','-Wno-objc-property-implementation','-framework','Foundation','-framework','Security','-I'+str(SOURCE/'Controllers'),'-I'+str(OUT),*map(str,sources),str(A/'QuickResetTests.m'),'-o',str(OUT/'quick-reset-tests')]
p=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT);(OUT/'compile.log').write_text(p.stdout)
if not p.returncode:p=subprocess.run([str(OUT/'quick-reset-tests')],text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT);(OUT/'run.log').write_text(p.stdout)
print(p.stdout)
manifest={'source':str(SOURCE),'label':LABEL,'exit':p.returncode,'production_sha256':{str(p.relative_to(SOURCE)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [*sources,SOURCE/'Controllers/CSCloseFriendSettingsViewController.m',SOURCE/'Controllers/CSCloseFriendManager.m']},'test_sha256':hashlib.sha256((A/'QuickResetTests.m').read_bytes()).hexdigest(),'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'unchanged_normal_method_sha256':{name:hashlib.sha256(extract((SOURCE/'Controllers'/file).read_text(),prefix).encode()).hexdigest() for name,file,prefix in [('manager_password_reset','CSCloseFriendManager.m','- (void)resetFrom:(UIViewController *)presenter completion:'),('runtime_password_proof','CSCloseFriendRuntime.m','- (NSDictionary *)prepareResetWithPassword:'),('settings_reset_exit','CSCloseFriendSettingsViewController.m','- (void)leaveAfterReset')]},'settings_routing_extraction':'unchanged method prefix through section 2 early return; remaining option/picker branches excluded'}
(OUT/'provenance.json').write_text(json.dumps(manifest,indent=2)+'\n');sys.exit(p.returncode)
