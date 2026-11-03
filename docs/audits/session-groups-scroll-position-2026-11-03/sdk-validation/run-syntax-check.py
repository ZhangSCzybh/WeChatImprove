#!/usr/bin/env python3
"""Check changed Adapter and generated hooks against the real iOS SDK."""
from pathlib import Path
import hashlib,json,subprocess,tempfile
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
sdk=subprocess.check_output(['xcrun','--sdk','iphoneos','--show-sdk-path'],text=True).strip()
paths=['Controllers/CSGroupListAdapter.m','Hooks/SessionGroupHooks.xm']
rows=[]
with tempfile.TemporaryDirectory(prefix='wechat-scroll-syntax-') as temp:
    generated={}
    for path in paths:
        if not path.endswith('.xm'):continue
        run=subprocess.run(['/Users/zhangshichao/theos/bin/logos.pl',str(ROOT/path)],text=True,capture_output=True)
        (HERE/(Path(path).stem+'-logos.log')).write_text(run.stderr)
        assert run.returncode==0
        source=Path(temp)/(Path(path).stem+'.mm');source.write_text(run.stdout);generated[path]=source
    for arch in ('arm64','arm64e'):
        flags=['xcrun','--sdk','iphoneos','clang','-fsyntax-only','-fobjc-arc','-fblocks',
               '-target',arch+'-apple-ios15.0','-isysroot',sdk,
               '-I'+str(ROOT/'Headers'),'-I'+str(ROOT/'Hooks'),'-I'+str(ROOT/'Controllers'),
               '-I/Users/zhangshichao/theos/include','-I/Users/zhangshichao/theos/vendor/include',
               '-F/Users/zhangshichao/theos/vendor/lib']
        for path in paths:
            source=generated.get(path,ROOT/path)
            command=flags+[str(source)]
            run=subprocess.run(command,text=True,capture_output=True)
            log=Path(path).stem+'-'+arch+'-syntax.log'
            (HERE/log).write_text(run.stdout+run.stderr)
            rows.append({'source':path,'source_sha256':hashlib.sha256((ROOT/path).read_bytes()).hexdigest(),
                         'arch':arch,'command':command,'exit_code':run.returncode,'log':log})
result={'sdk':sdk,'checks':rows,'passed':all(row['exit_code']==0 for row in rows)}
(HERE/'syntax-result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({'passed':result['passed'],'checks':len(rows),'failures':[r for r in rows if r['exit_code']]},indent=2))
raise SystemExit(0 if result['passed'] else 1)
