#!/usr/bin/env python3
import pathlib,json,tempfile,subprocess,hashlib
repo=pathlib.Path(__file__).resolve().parents[3];audit=pathlib.Path(__file__).parent
build=pathlib.Path(tempfile.mkdtemp(prefix='wechat-list-restore-2.1-3-'))
for name in ['com.wechat.improve_2.1-3_iphoneos-arm.deb','com.wechat.improve_2.1-3_iphoneos-arm64.deb','com.wechat.improve_2.1-3_symbols.zip']:
 assert not (repo/'packages'/name).exists(),name
commands={scheme:['make','-j2','package','SCHEME='+scheme,'PACKAGE_VERSION=2.1-3','_THEOS_LOCAL_DATA_DIR='+str(build/scheme),'THEOS_BUILD_DIR='+str(build/(scheme+'-build')),'THEOS_PACKAGE_DIR='+str(build/'packages'),'COLOR=0'] for scheme in ['rootful','rootless']}
(audit/'build-environment.json').write_text(json.dumps({'workspace':str(repo),'buildRoot':str(build),'version':'2.1-3','commands':commands},indent=2))
inputs=json.loads((repo/'docs/audits/ai-muted-background-2.1-2/source-sha256.json').read_text())
inputs.update({'Controllers/CSListCornerSessionRestore.h':'','Controllers/CSListCornerSessionRestore.m':''})
(audit/'source-sha256.json').write_text(json.dumps({p:hashlib.sha256((repo/p).read_bytes()).hexdigest() for p in sorted(inputs)},indent=2))
for scheme,command in commands.items():
 print('Building '+scheme+' in '+str(build),flush=True)
 with (audit/('build-'+scheme+'.log')).open('w') as log:
  result=subprocess.run(command,cwd=repo,stdout=log,stderr=subprocess.STDOUT)
 print(scheme+' exit='+str(result.returncode),flush=True)
 if result.returncode:raise SystemExit(result.returncode)
