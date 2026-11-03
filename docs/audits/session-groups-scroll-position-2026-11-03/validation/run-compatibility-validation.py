#!/usr/bin/env python3
"""Run production compatibility paths and targeted temporary negative controls."""
import argparse
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime
from hashlib import sha256
import json
import os
import re
from pathlib import Path
import subprocess
from zoneinfo import ZoneInfo

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PATHS=['Controllers/CSGroupListAdapter.m','Controllers/CSGroupListAdapter.h',
       'Controllers/CSGroupProjection.m','Controllers/CSGroupNativeBridge.m',
       'Controllers/CSGroupPreferences.m','Controllers/CSGroupIndexScope.m']

def hashes(root):
    return {path:sha256((root/path).read_bytes()).hexdigest() for path in PATHS}

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--output-dir',default='final')
    args=parser.parse_args();output=HERE/args.output_dir;output.mkdir(parents=True,exist_ok=True)
    before=hashes(ROOT)
    baseline=HERE.parent/'baseline-2.2-10'
    def run(name,source,variables,expected=None):
        env=os.environ.copy();env.update(variables)
        env['WECHAT_VALIDATION_SOURCE_ROOT']=str(source);env['WECHAT_COMPATIBILITY_ONLY']='1'
        result=subprocess.run(['bash',str(HERE/'run-native-behavior.sh')],cwd=ROOT,env=env,text=True,capture_output=True)
        text=result.stdout+result.stderr;(output/(name+'.log')).write_text(text)
        accepted=result.returncode==0 if expected is None else result.returncode!=0 and expected in text
        row={'name':name,'source_root':str(source),'environment_overrides':variables,
             'exit_code':result.returncode,'accepted':accepted,'expected_assertion':expected,
             'output':text,'input_sha256':hashes(source)}
        print(name+': '+str(accepted));print(text,end='');return row
    runs=[run('baseline-compatibility',baseline,{}),
          run('current-compatibility',ROOT,{})]
    controls=[
        ('compat-full-ui','WECHAT_VALIDATION_COMPAT_FULL_UI','table.reloads==0 && table.rowReloads.count==0 && table.layouts==0'),
        ('compat-always-layout','WECHAT_VALIDATION_COMPAT_ALWAYS_LAYOUT','table.reloads==0 && table.rowReloads.count==0 && table.layouts==0'),
        ('compat-ignore-metadata','WECHAT_VALIDATION_COMPAT_IGNORE_METADATA','[table.rowReloads[0] isEqual:Path(1)]'),
        ('compat-drop-names','WECHAT_VALIDATION_COMPAT_DROP_NAMES','[table.rowReloads[0] isEqual:Path(0)]'),
        ('compat-ignore-reentrancy','WECHAT_VALIDATION_COMPAT_IGNORE_REENTRANCY','table.reloads==1 && table.layouts==1'),
        ('compat-ignore-structure-proof','WECHAT_VALIDATION_IGNORE_STRUCTURE_PROOF','all!=nil && (boundary==1 ? CpuUnreadGetterReads>=3'),
    ]
    with ThreadPoolExecutor(max_workers=2) as pool:
        runs+=list(pool.map(lambda c:run(c[0],ROOT,{c[1]:'1'},c[2]),controls))
    after=hashes(ROOT)
    current=next(row for row in runs if row['name']=='current-compatibility')
    counts=re.search(r'sessions=(\d+) complete_metadata_reads=(\d+) named_metadata_reads=(\d+) all_row_fields_equal=(YES|NO)',current['output'])
    workload={'sessions':int(counts[1]),'complete_metadata_reads':int(counts[2]),'named_metadata_reads':int(counts[3]),'all_row_fields_equal':counts[4]=='YES','scope':'Host Foundation real Adapter source helper + Bridge only; still performs complete coordinate proof; not phone CPU/time/energy.'} if counts else None
    report={'timestamp':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),
            'source_unchanged':before==after,'production_source_sha256':after,'runs':runs,'large_source_workload':workload,
            'isolation':'Temporary Foundation executables, in-memory preferences and controlled UIKit/native source. Negative controls alter extracted temporary methods only.',
            'scope':'Actual production compatibility refresh, publisher and nativeSections body are extracted verbatim; Bridge, Projection, IndexScope and preferences compile as full translation units. Source/viewport geometry is a fixture boundary. No device, real account/database, package, service or historical audit writes.'}
    (output/'compatibility-result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    if before!=after or not all(row['accepted'] for row in runs):raise SystemExit(1)

if __name__=='__main__':main()
