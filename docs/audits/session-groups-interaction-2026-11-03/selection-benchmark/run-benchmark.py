#!/usr/bin/env python3
"""Compile frozen 2.2-8 and current production modules, compare selection output."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
AUDIT = HERE.parent
ROOT = HERE.parents[3]
SOURCES = ['Controllers/CSGroupNativeModel.m', 'Controllers/CSGroupNativeModel.h',
           'Controllers/CSGroupProjection.m', 'Controllers/CSGroupProjection.h',
           'Controllers/WESessionTabItem.m', 'Controllers/WESessionTabItem.h']

def hashes(root):
    return {name: hashlib.sha256((root / name).read_bytes()).hexdigest() for name in SOURCES}

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output-dir', default='.')
    args = parser.parse_args()
    output = HERE / args.output_dir
    output.mkdir(parents=True, exist_ok=True)
    environment = {'started_utc': datetime.now(timezone.utc).isoformat(),
        'concurrency_limitation': 'Only matching build/benchmark executables are recorded. Other desktop/OS processes remain uncontrolled.',
        'matching_processes_before': build_processes()}
    results = {}
    for label, root, reuse in [('before', AUDIT / 'baseline-2.2-8', False), ('after', ROOT, True)]:
        initial = hashes(root)
        with tempfile.TemporaryDirectory(prefix='wechat-selection-benchmark-') as temp:
            binary = Path(temp) / 'selection-benchmark'
            command = ['xcrun', '--sdk', 'macosx', 'clang', '-O2', '-fobjc-arc', '-fblocks', '-Wall', '-Wextra', '-Werror',
                       '-framework', 'Foundation', '-DCS_SELECTION_REUSE=' + str(int(reuse)), '-I' + str(root / 'Controllers'),
                       str(root / 'Controllers/CSGroupNativeModel.m'), str(root / 'Controllers/CSGroupProjection.m'),
                       str(root / 'Controllers/WESessionTabItem.m'), str(HERE / 'SelectionBenchmark.m'), '-o', str(binary)]
            subprocess.run(command, check=True, cwd=ROOT)
            completed = subprocess.run([str(binary)], check=True, capture_output=True, text=True)
        assert initial == hashes(root), 'Production source changed during this run'
        result = json.loads(completed.stdout)
        result.update(production_source_sha256=initial, source_unchanged_during_run=True,
                      benchmark_source_sha256=hashlib.sha256((HERE / 'SelectionBenchmark.m').read_bytes()).hexdigest())
        results[label] = result
        (output / (label + '.json')).write_text(json.dumps(result, indent=2, ensure_ascii=False) + '\n')
    comparison = {}
    for workload in results['before']['workloads']:
        before, after = [results[label]['workloads'][workload] for label in ('before', 'after')]
        assert before['projection_fingerprints'] == after['projection_fingerprints'], workload + ': output mismatch'
        comparison[workload] = {'equivalent_all_destination_fingerprints': True,
            'before_median_ms': before['median_milliseconds_per_switch'],
            'after_median_ms': after['median_milliseconds_per_switch'],
            'time_ratio_after_over_before': after['median_milliseconds_per_switch'] / before['median_milliseconds_per_switch'],
            'before_metadata_reads_per_round': before['metadata_reads_per_round'],
            'after_metadata_reads_per_round': after['metadata_reads_per_round']}
    comparison['interpretation'] = ('Controlled macOS model workload only. Filtered switches reuse membership/badges; '
        'crossing All scopes rebuilds the projection from immutable copied values. Native source/folded capture and '
        'O(N) identity validation, UIKit, real device CPU and frame timing are outside measurement.')
    (output / 'comparison.json').write_text(json.dumps(comparison, indent=2, ensure_ascii=False) + '\n')
    environment.update(finished_utc=datetime.now(timezone.utc).isoformat(), matching_processes_after=build_processes())
    (output / 'host-execution-context.json').write_text(json.dumps(environment, indent=2, ensure_ascii=False) + '\n')
    print(json.dumps(comparison, indent=2, ensure_ascii=False))

def build_processes():
    snapshot = subprocess.run(['ps', '-Ao', 'pid=,pcpu=,comm='], check=True, capture_output=True, text=True)
    names = {'make', 'gmake', 'clang', 'clang++', 'ld', 'ld64', 'xcodebuild', 'ninja', 'selection-benchmark', 'native-behavior'}
    processes = []
    for line in snapshot.stdout.splitlines():
        fields = line.strip().split(None, 2)
        if len(fields) == 3 and Path(fields[2]).name in names:
            processes.append({'pid': int(fields[0]), 'cpu_percent': float(fields[1]), 'executable': Path(fields[2]).name})
    return processes

if __name__ == '__main__':
    main()
