from pathlib import Path
import json,hashlib,subprocess,time,os
root=Path(__file__).resolve().parents[3];out=Path(__file__).resolve().parent
work=Path((out/'work-path.txt').read_text().strip());build=work/'theos';packages=work/'packages'
names=set(json.loads((root/'docs/audits/merge-runtime-1.8-34/source-manifest.json').read_text()))
manifest={name:hashlib.sha256((root/name).read_bytes()).hexdigest() for name in sorted(names)}
(out/'source-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
(out/'build-paths.json').write_text(json.dumps({'checkout':str(root),'build':str(build),'packages':str(packages)},indent=2)+'\n')
args=['make','-j4','package','SCHEME=rootless','_THEOS_LOCAL_DATA_DIR='+str(build),'THEOS_PACKAGE_DIR='+str(packages)]
(out/'build-command.json').write_text(json.dumps(args,indent=2)+'\n')
env=os.environ.copy();env['THEOS']='/Users/zhangshichao/theos';start=time.monotonic()
with (out/'build.log').open('w') as log: result=subprocess.run(args,cwd=root,env=env,stdout=log,stderr=subprocess.STDOUT)
record={'exit_code':result.returncode,'seconds':round(time.monotonic()-start,2),'THEOS':env['THEOS'],'source_files':len(manifest)}
(out/'build-result.json').write_text(json.dumps(record,indent=2)+'\n');print(json.dumps(record));raise SystemExit(result.returncode)
