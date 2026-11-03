#!/usr/bin/env python3
"""Compile old and new real model/projection translation units; compare equivalent output."""
import argparse
from hashlib import sha256
import json
from pathlib import Path
import subprocess
import tempfile

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
BASELINE=HERE.parent/'baseline-2.2-7'
SOURCES=['Controllers/CSGroupNativeModel.m','Controllers/CSGroupNativeModel.h',
         'Controllers/CSGroupProjection.m','Controllers/CSGroupProjection.h',
         'Controllers/WESessionTabItem.m','Controllers/WESessionTabItem.h']
def hashes(root):return {name:sha256((root/name).read_bytes()).hexdigest() for name in SOURCES}
def main():
    parser=argparse.ArgumentParser();parser.add_argument('--output-dir',default='final');parser.add_argument('--baseline-only',action='store_true');args=parser.parse_args()
    output=HERE/args.output_dir;output.mkdir(parents=True,exist_ok=True)
    modes=[('before',BASELINE,False)]
    if not args.baseline_only:modes.append(('after',ROOT,True))
    results={}
    for label,root,incremental in modes:
        before=hashes(root)
        with tempfile.TemporaryDirectory(prefix='wechat-model-cpu-'+label+'-') as temp:
            executable=Path(temp)/'model-benchmark'
            command=['xcrun','--sdk','macosx','clang','-O2','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-framework','Foundation',
                '-DCS_PERF_INCREMENTAL='+str(int(incremental)),'-I'+str(root/'Controllers'),str(root/'Controllers/CSGroupNativeModel.m'),
                str(root/'Controllers/CSGroupProjection.m'),str(root/'Controllers/WESessionTabItem.m'),str(HERE/'ModelPerfBench.m'),'-o',str(executable)]
            subprocess.run(command,check=True,cwd=ROOT)
            run=subprocess.run([str(executable)],check=True,text=True,capture_output=True)
            result=json.loads(run.stdout);after=hashes(root);assert before==after,'Source changed during benchmark'
            result.update({'production_source_sha256':after,'source_unchanged_during_run':True})
            results[label]=result;(output/('model-benchmark-'+label+'.json')).write_text(json.dumps(result,indent=2,ensure_ascii=False)+'\n')
            print(label+': median %.4f ms/update; metadata reads/round %s'%(result['median_milliseconds_per_update'],result['metadata_reads_per_round']))
    if 'after' in results:
        before,after=results['before'],results['after'];assert before['final_projection_fingerprint']==after['final_projection_fingerprint'],'Projection outputs differ'
        comparison={'equivalent_final_projection':True,'before':before,'after':after,
            'median_host_time_ratio_after_over_before':after['median_milliseconds_per_update']/before['median_milliseconds_per_update'],
            'metadata_read_ratio_after_over_before':sum(after['metadata_reads_per_round'])/sum(before['metadata_reads_per_round']),
            'interpretation':'Controlled host model workload only. Ratios are not a measurement of iPhone CPU, energy use or frame timing.'}
        (output/'model-benchmark-comparison.json').write_text(json.dumps(comparison,indent=2,ensure_ascii=False)+'\n')
if __name__=='__main__':main()
