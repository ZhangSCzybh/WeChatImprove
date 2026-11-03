#!/usr/bin/env python3
"""Ensure targeted behavior assertions fail when removed work is restored temporarily."""
import argparse
from concurrent.futures import ThreadPoolExecutor
from hashlib import sha256
import json
import os
from pathlib import Path
import subprocess

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PATHS=['Controllers/CSGroupNativeModel.h','Controllers/CSGroupNativeModel.m',
       'Controllers/CSGroupNativeSessionCoordinator.h','Controllers/CSGroupNativeSessionCoordinator.m',
       'Controllers/CSGroupListAdapter.h','Controllers/CSGroupListAdapter.m',
       'Controllers/CSGroupNativeBridge.h','Controllers/CSGroupNativeBridge.m',
       'Controllers/CSGroupProjection.h','Controllers/CSGroupProjection.m',
       'Controllers/WESessionTabItem.h','Controllers/WESessionTabItem.m',
       'Hooks/NativeSessionGroupHooks.xm','Hooks/SessionGroupHooks.xm']
def hashes():return {p:sha256((ROOT/p).read_bytes()).hexdigest() for p in PATHS}
def main():
    parser=argparse.ArgumentParser();parser.add_argument('--output-dir',default='final');args=parser.parse_args()
    output=HERE/args.output_dir;output.mkdir(parents=True,exist_ok=True)
    before=hashes()
    controls=[('forced-full-ui','WECHAT_VALIDATION_FORCE_FULL_UI','table.reloads==0'),
              ('old-recovery-reset','WECHAT_VALIDATION_RESTORE_OLD_RECOVERY_RESET','external')]
    def run(control):
        name,variable,expected=control;env=os.environ.copy();env[variable]='1'
        result=subprocess.run(['bash',str(HERE/'run-native-behavior.sh')],cwd=ROOT,env=env,text=True,capture_output=True)
        combined=result.stdout+result.stderr;(output/(name+'-negative-control.log')).write_text(combined)
        # The recovery assertion is an exact old fixture predicate; its line
        # carries attempts==1 and the named comments document external events.
        expected_match=(expected in combined if name=='forced-full-ui' else 'failing.nativeRecoveryAttempts==1 && failing.nativeRecoveryGeneration==recoveryGeneration' in combined)
        return {'name':name,'environment_override':variable+'=1','exit_code':result.returncode,
            'expected_assertion_failed':result.returncode!=0 and expected_match,
            'output':combined,'scope':'Only an extracted temporary adapter method body is altered; production is unchanged.'}
    with ThreadPoolExecutor(max_workers=2) as pool:results=list(pool.map(run,controls))
    after=hashes();report={'source_unchanged_during_controls':before==after,'production_source_sha256':after,'runs':results}
    (output/'negative-controls-result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    for result in results:print(result['name']+': expected failure '+str(result['expected_assertion_failed']))
    if before!=after or not all(result['expected_assertion_failed'] for result in results):raise SystemExit(1)
if __name__=='__main__':main()
