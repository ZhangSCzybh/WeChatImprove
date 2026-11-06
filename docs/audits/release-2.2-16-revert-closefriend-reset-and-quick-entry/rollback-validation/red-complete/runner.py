#!/usr/bin/env python3
"""New rollback assertions against real reset/runtime/store; isolated defaults + temp state only."""
from pathlib import Path
import hashlib, json, subprocess, sys
A=Path(__file__).resolve().parent
ROOT=A.parents[3]
SOURCE=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else ROOT
LABEL=sys.argv[2] if len(sys.argv)>2 else 'green'
OUT=A/LABEL; OUT.mkdir(exist_ok=True)
NAMES=['CSCloseFriendCrypto','CSCloseFriendPolicy','CSCloseFriendStore','CSCloseFriendEntryState','CSCloseFriendReset','CSCloseFriendRuntime','CSPluginStorage']
sources=[SOURCE/'Controllers'/f'{name}.m' for name in NAMES]
test=A/'RollbackMigrationTests.m'
(OUT/'test-source.m').write_bytes(test.read_bytes())
(OUT/'runner.py').write_bytes(Path(__file__).read_bytes())
manager=(SOURCE/'Controllers/CSCloseFriendManager.m').read_text()
start=manager.index('_runtime.resetStorage='); opening=manager.index('{',start); depth=1; pos=opening+1
while depth:
 depth+=(manager[pos]=='{')-(manager[pos]=='}');pos+=1
block=manager[start:pos+1]
(OUT/'ManagerResetStorageUnderTest.h').write_text(block+'\n')
cmd=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-nonnull','-framework','Foundation','-framework','Security','-I'+str(SOURCE/'Controllers'),'-I'+str(OUT),*map(str,sources),str(test),'-o',str(OUT/'rollback-tests')]
p=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
(OUT/'compile.log').write_text(p.stdout)
if p.returncode:
 print(p.stdout);sys.exit(p.returncode)
r=subprocess.run([str(OUT/'rollback-tests')],text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
(OUT/'run.log').write_text(r.stdout);print(r.stdout,end='')
(OUT/'provenance.json').write_text(json.dumps({'source':str(SOURCE),'label':LABEL,'test_sha256':hashlib.sha256(test.read_bytes()).hexdigest(),'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'manager_source_sha256':hashlib.sha256((SOURCE/'Controllers/CSCloseFriendManager.m').read_bytes()).hexdigest(),'extracted_block_sha256':hashlib.sha256(block.encode()).hexdigest(),'sources':{str(p.relative_to(SOURCE)):hashlib.sha256(p.read_bytes()).hexdigest() for p in sources},'compile':cmd,'compile_exit':p.returncode,'exit':r.returncode},indent=2)+'\n')
sys.exit(r.returncode)
