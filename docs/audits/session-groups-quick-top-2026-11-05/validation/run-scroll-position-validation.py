from datetime import datetime
from hashlib import sha256
import argparse
import json
import os
from pathlib import Path
import re
import subprocess
import sys
from zoneinfo import ZoneInfo

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
BASELINE=HERE.parent/'baseline-2.2-10'
parser=argparse.ArgumentParser()
parser.add_argument('--output-dir',default='final')
args=parser.parse_args()
OUT=HERE/args.output_dir
OUT.mkdir(parents=True,exist_ok=True)
paths=[*['Controllers/'+name+ext for name in ['CSGroupNativeModel','CSGroupNativeSessionCoordinator',
    'CSGroupNativeBridge','CSGroupProjection','CSGroupIndexScope','CSGroupInvocationMapper',
    'CSGroupPreferences','WESessionTabItem','CSCloseFriendPolicy','CSCloseFriendSignatures'] for ext in ['.h','.m']],
    'Controllers/CSGroupListAdapter.h','Controllers/CSGroupListAdapter.m',
    'Hooks/NativeSessionGroupHooks.xm','Hooks/SessionGroupHooks.xm']
def hashes(root):return {name:sha256((root/name).read_bytes()).hexdigest() for name in paths}
start=hashes(ROOT)
runs=[]
configs=[('current-scroll-position',{},False),
    ('baseline-2.2-10-switch',{'WECHAT_VALIDATION_SOURCE_ROOT':str(BASELINE)},True),
    ('baseline-2.2-10-return',{'WECHAT_VALIDATION_SOURCE_ROOT':str(BASELINE),'WECHAT_SCROLL_PROBE':'return'},True),
    ('negative-ignore-failed-restore',{'WECHAT_SCROLL_IGNORE_FAILED_RESTORE':'1'},True),
    ('negative-skip-final-return',{'WECHAT_SCROLL_SKIP_FINAL_RETURN':'1'},True),
    ('negative-retarget-copy-identity',{'WECHAT_SCROLL_LOSE_RETARGET_IDENTITY':'1'},True),
    ('negative-ignore-selection-readback',{'WECHAT_SCROLL_IGNORE_SETTER_READBACK':'1'},True)]
for label,extra,negative in configs:
    env=os.environ.copy();env.update(extra);env['WECHAT_SCROLL_POSITION_ONLY']='1'
    result=subprocess.run(['bash',str(HERE/'run-native-behavior.sh')],cwd=ROOT,env=env,text=True,capture_output=True)
    log=result.stdout+result.stderr
    (OUT/(label+'.log')).write_text(log)
    checks=re.search(r'lifecycle: (\d+) behavior checks passed',log)
    ok=(result.returncode!=0 and 'FAIL ' in log and 'error:' not in log) if negative else result.returncode==0 and checks is not None
    runs.append({'label':label,'negative_control':negative,'exit_code':result.returncode,'passed':ok,
        'behavior_checks':int(checks[1]) if checks else None,'log':label+'.log','log_sha256':sha256(log.encode()).hexdigest()})
    print(f'{label}: '+('caught expected behavior failure' if negative and ok else f'{checks[1]} checks passed' if ok else 'FAILED'))
    if not ok:print(log)
finish=hashes(ROOT)
report={'timestamp':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),
    'project_checkout':str(ROOT),'baseline_checkout':str(BASELINE),
    'source_unchanged_during_checks':start==finish,'production_source_sha256':finish,
    'baseline_source_sha256':hashes(BASELINE),
    'validation_source_sha256':{str(p.relative_to(HERE)):sha256(p.read_bytes()).hexdigest()
        for p in sorted(HERE.rglob('*')) if p.is_file() and p.suffix in {'.m','.h','.sh','.py'}},
    'runs':runs,'passed':start==finish and all(r['passed'] for r in runs),
    'executed_contracts':['shared effective scroll height across groups, same-group selection stays in place',
        'same-group row anchor under native/compat source reordering',
        'first departure capture and native will/didAppear host offset reset',
        'reload geometry deferred until layout, invalid viewport/content retains pending restoration',
        'short-list clamp, inset transition with previous native top offset',
        'queued A-to-B-to-C selection and horizontal tracking completion',
        'real native begin-drag hook and compatibility invocation cancel prior position before host callback',
        'real native/compat status-bar Should acceptance/rejection and Did callback',
        'real native-search/native-navigation entry cancels prior group restoration',
        'synchronous restoration reentry and host overwrite of offset/inset/table',
        'privacy boundary and account/epoch invalidation',
        'settings deletion of a queued group retargets only after valid fallback publication',
        'actual preferences future-schema refusal clears rejected switch request',
        'UIKit pull bounce is not captured; waiting interactions do not poll'],
    'isolation':'Temporary macOS Foundation executables; in-memory defaults, deterministic dispatch clock, WeChat host and deferred UIKit geometry doubles. No device, account data, database, ports, services or packages modified.',
    'limits':['Production Adapter method bodies, main-owner lifecycle hooks, native scroll hooks and compatibility forwardInvocation are extracted unchanged except named temporary negative controls.',
        'Production model, coordinator, bridge, projection, preferences, invocation mapper, index scope and policy/signature translation units are compiled.',
        'UIKit geometry models reload/layout deferral, host clamping and synchronous callbacks; it cannot establish iPhone runtime private-interface compatibility or physical scrolling smoothness.',
        'No CPU, Core Animation, frame pacing, or Instruments improvement is inferred from these functional assertions.']}
(OUT/'scroll-position-result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
sys.exit(0 if report['passed'] else 1)
