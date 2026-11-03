#!/usr/bin/env python3
"""Validate modified Objective-C and generated Logos code with the real iOS SDK."""
from pathlib import Path
import hashlib,json,subprocess,tempfile
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
sdk=subprocess.check_output(['xcrun','--sdk','iphoneos','--show-sdk-path'],text=True).strip()
paths=['Controllers/CSGroupListAdapter.m','Controllers/CSGroupNativeBridge.m','Controllers/WESessionTabContainerView.m',
       'Controllers/CSGroupPerformanceObservation.m','Hooks/SessionGroupPerformanceObservation.xm']
rows=[]
with tempfile.TemporaryDirectory(prefix='wechat-groups-syntax-') as temp:
    generated=Path(temp)/'SessionGroupPerformanceObservation.mm'
    logos=subprocess.run(['/Users/zhangshichao/theos/bin/logos.pl',str(ROOT/paths[-1])],text=True,capture_output=True)
    (HERE/'logos.log').write_text(logos.stderr)
    assert logos.returncode==0
    generated.write_text(logos.stdout)
    for arch in ('arm64','arm64e'):
        for observation in (0,1):
            flags=['xcrun','--sdk','iphoneos','clang','-fsyntax-only','-fobjc-arc','-fblocks',
                   '-target',arch+'-apple-ios15.0','-isysroot',sdk,
                   '-I'+str(ROOT/'Headers'),'-I'+str(ROOT/'Hooks'),'-I'+str(ROOT/'Controllers'),
                   '-I/Users/zhangshichao/theos/include','-I/Users/zhangshichao/theos/vendor/include',
                   '-F/Users/zhangshichao/theos/vendor/lib','-DCS_GROUP_PERFORMANCE_OBSERVATION='+str(observation)]
            for path in paths:
                source=generated if path.endswith('.xm') else ROOT/path
                command=flags+[str(source)]
                run=subprocess.run(command,text=True,capture_output=True)
                log=Path(path).stem+'-'+arch+'-obs'+str(observation)+'-syntax.log'
                (HERE/log).write_text(run.stdout+run.stderr)
                rows.append({'source':path,'source_sha256':hashlib.sha256((ROOT/path).read_bytes()).hexdigest(),
                             'arch':arch,'observation':observation,'command':command,'exit_code':run.returncode,'log':log})
result={'sdk':sdk,'logos_exit_code':logos.returncode,'checks':rows,'passed':all(row['exit_code']==0 for row in rows)}
(HERE/'syntax-result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({'passed':result['passed'],'checks':len(rows),'failures':[r for r in rows if r['exit_code']]},indent=2))
raise SystemExit(0 if result['passed'] else 1)
