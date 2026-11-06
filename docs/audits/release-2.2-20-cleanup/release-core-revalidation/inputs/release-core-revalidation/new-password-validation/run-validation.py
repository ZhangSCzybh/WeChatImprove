#!/usr/bin/env python3
"""Exercise unchanged longpress/discovery/ordinary setup using production methods."""
from pathlib import Path
import hashlib,json,subprocess,sys,tempfile
A=Path(__file__).resolve().parent
ROOT=A.parents[3]
SOURCE=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else ROOT
LABEL=sys.argv[2] if len(sys.argv)>2 else 'green'
OUT=A/LABEL
OUT.mkdir(exist_ok=True)
def extract(text,prefix):
    start=text.index(prefix);opening=text.index('{',start);depth=1;pos=opening+1
    while depth:
        depth+=(text[pos]=='{')-(text[pos]=='}');pos+=1
    return text[start:pos]
selection={
 'Manager':['- (BOOL)validateToken:', '- (void)passwordPrompt:', '- (void)authenticateFrom:', '- (BOOL)settingsEntryVisible', '- (NSDictionary *)settingsEntryDiscoveryToken', '- (BOOL)discoverSettingsEntryWithToken:', '- (void)presentSettingsFrom:'],
 'Custom':['- (void)installCloseFriendEntryGesture', '- (BOOL)canDiscoverCloseFriendEntry', '- (BOOL)gestureRecognizer:', '- (void)discoverCloseFriendEntry:', '- (void)resetCloseFriendQuickEntry', '- (BOOL)closeFriendQuickEntryTokenIsCurrent:']}
for name,prefixes in selection.items():
    source=SOURCE/'Controllers'/('CSCloseFriendManager.m' if name=='Manager' else 'CSCustomViewController.m')
    text=source.read_text();methods=[extract(text,p) for p in prefixes]
    (OUT/f'{name}Methods.h').write_text('\n'.join(methods)+'\n')
    (OUT/f'{name}Declarations.h').write_text('\n'.join(m[:m.index('{')].strip()+';' for m in methods)+'\n')
names=['CSCloseFriendEntryState','CSCloseFriendReset','CSCloseFriendCrypto','CSCloseFriendPolicy','CSCloseFriendStore','CSCloseFriendRuntime','CSPluginStorage']
sources=[SOURCE/'Controllers'/f'{n}.m' for n in names]
fixture=A/'NewPasswordTests.m'
(OUT/'test-source.m').write_bytes(fixture.read_bytes())
(OUT/'runner.py').write_bytes(Path(__file__).read_bytes())
cmd=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-nonnull','-Wno-incomplete-implementation','-framework','Foundation','-framework','Security','-I'+str(SOURCE/'Controllers'),'-I'+str(OUT),*map(str,sources),str(fixture),'-o',str(OUT/'new-password-tests')]
p=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
(OUT/'compile.log').write_text(p.stdout)
if p.returncode:
    print(p.stdout);sys.exit(p.returncode)
with tempfile.TemporaryDirectory(prefix='wci-2217-password-') as temp:
    p=subprocess.run([str(OUT/'new-password-tests'),temp],text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
(OUT/'run.log').write_text(p.stdout);print(p.stdout)
manifest={'source':str(SOURCE),'label':LABEL,'exit':p.returncode,'production_sha256':{str(p.relative_to(SOURCE)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [*sources,SOURCE/'Controllers/CSCloseFriendManager.m',SOURCE/'Controllers/CSCustomViewController.m']},'test_sha256':hashlib.sha256(fixture.read_bytes()).hexdigest(),'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'command':cmd}
(OUT/'provenance.json').write_text(json.dumps(manifest,indent=2)+'\n')
sys.exit(p.returncode)
