#!/usr/bin/env python3
"""Compare frozen 2.2-8 behavior and run selection's stale-config negative control."""
import argparse
from datetime import datetime
from hashlib import sha256
import json
import os
from pathlib import Path
import subprocess
import tempfile
from zoneinfo import ZoneInfo

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PATHS=['Controllers/CSGroupListAdapter.m','Controllers/CSGroupNativeModel.h','Controllers/CSGroupNativeModel.m',
       'Controllers/CSGroupProjection.h','Controllers/CSGroupProjection.m',
       'Controllers/CSGroupNativeSessionCoordinator.h','Controllers/CSGroupNativeSessionCoordinator.m',
       'Hooks/SessionGroupHooks.xm']
def hashes(root):return {path:sha256((root/path).read_bytes()).hexdigest() for path in PATHS}
def main():
    parser=argparse.ArgumentParser();parser.add_argument('--output-dir',default='final');args=parser.parse_args()
    output=HERE/args.output_dir;output.mkdir(parents=True,exist_ok=True)
    baseline=ROOT/'docs/audits/session-groups-interaction-2026-11-03/baseline-2.2-8'
    before=hashes(ROOT);runs=[]
    def run(name,source,variables,expected=None):
        env=os.environ.copy();env.update(variables);env['WECHAT_VALIDATION_SOURCE_ROOT']=str(source)
        process=subprocess.run(['bash',str(HERE/'run-native-behavior.sh')],cwd=ROOT,env=env,text=True,capture_output=True)
        combined=process.stdout+process.stderr;(output/(name+'.log')).write_text(combined)
        accepted=process.returncode==0 if expected is None else process.returncode!=0 and expected in combined
        row={'name':name,'source_root':str(source),'environment_overrides':variables,'exit_code':process.returncode,
             'accepted':accepted,'expected_failure_assertion':expected,'output':combined,'input_sha256':hashes(source)}
        runs.append(row);print(name+': '+str(accepted));print(combined,end='')
    run('baseline-idle-interaction-loop',baseline,{'WECHAT_INTERACTION_ONLY':'1','WECHAT_INTERACTION_EXPECT_BASELINE':'1'})
    run('baseline-selection-source-reads',baseline,{'WECHAT_SELECTION_ONLY':'1','WECHAT_SELECTION_EXPECT_BASELINE':'1'})
    run('current-interaction',ROOT,{'WECHAT_INTERACTION_ONLY':'1'})
    run('current-selection',ROOT,{'WECHAT_SELECTION_ONLY':'1'})
    with tempfile.TemporaryDirectory(prefix='wechat-selection-negative-') as temporary:
        sandbox=Path(temporary);controllers=sandbox/'Controllers';controllers.mkdir()
        for file in (ROOT/'Controllers').iterdir():
            if file.name=='CSGroupNativeSessionCoordinator.m':
                source=file.read_text();needle='@(self.preferences.filterDuplicates),[definitions copy],'
                assert source.count(needle)==1
                (controllers/file.name).write_text(source.replace(needle,'@(self.preferences.filterDuplicates),[self.preferences.selectedTabID copy] ?: @"",[definitions copy],'))
            else:(controllers/file.name).symlink_to(file,target_is_directory=file.is_dir())
        (sandbox/'Hooks').symlink_to(ROOT/'Hooks',target_is_directory=True)
        for folder in ('Headers','HeadersFile'):
            if (ROOT/folder).exists():(sandbox/folder).symlink_to(ROOT/folder,target_is_directory=True)
        run('selected-config-key-negative-control',sandbox,{'WECHAT_SELECTION_ONLY':'1'},'reads==0')
    after=hashes(ROOT)
    report={'timestamp':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),'source_unchanged':before==after,
            'production_source_sha256':after,'baseline_source_sha256':hashes(baseline),'runs':runs,
            'isolation':'Temporary macOS Foundation executables with in-memory preferences and host doubles; no device, install, real account/database or service writes.',
            'scope':'Real production native refresh/scheduler/helper and scroll/edit hook bodies are extracted. Model, Projection and Coordinator compile as complete production translation units. Negative controls alter temporary extracted or copied code only.'}
    (output/'interaction-comparison.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    if before!=after or not all(run['accepted'] for run in runs):raise SystemExit(1)
if __name__=='__main__':main()
