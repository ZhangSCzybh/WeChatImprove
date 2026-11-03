#!/usr/bin/env python3
"""Cross-check final behavior evidence, frozen build inputs and delivered files."""
from datetime import datetime
from hashlib import sha256
import json
from pathlib import Path
import runpy
import subprocess
from zoneinfo import ZoneInfo

AUDIT=Path(__file__).resolve().parent
ROOT=AUDIT.parents[2]

def digest(path):
    return sha256(path.read_bytes()).hexdigest()

def git(*args):
    return subprocess.check_output(['git',*args],cwd=ROOT,text=True).strip()

build=json.loads((AUDIT/'build-result.json').read_text())
inputs=json.loads((AUDIT/'production-inputs.json').read_text())
behavior=json.loads((AUDIT/'validation/final/behavior-result.json').read_text())
legacy=json.loads((AUDIT/'validation/final/legacy-core-result.json').read_text())
history=json.loads((AUDIT/'historical-packages-before.json').read_text())
benchmark=json.loads((AUDIT/'validation/final/model-benchmark-comparison.json').read_text())
baseline_inputs=json.loads((AUDIT/'baseline-source-hashes.json').read_text())
cleanup=json.loads((AUDIT/'cleanup-review.json').read_text())
controls=json.loads((AUDIT/'validation/final/negative-controls-result.json').read_text())
current_inputs=runpy.run_path(str(AUDIT/'build-packages.py'))['inputs'](ROOT)
status=subprocess.check_output(['git','status','--porcelain=v1','-z'],cwd=ROOT).split(b'\0')
deleted=sum(row[:2] in (b' D',b'D ') for row in status if row)
artifacts_ok=all(digest(ROOT/row['path'])==row['sha256'] for row in build['artifacts'])
fixture_ok=all(digest(AUDIT/'validation'/path)==value
    for path,value in behavior['validation_source_sha256'].items())
production_ok=all(inputs['production_files'].get(path)==value
    for path,value in behavior['production_source_sha256'].items())
history_ok=all((ROOT/path).is_file() and digest(ROOT/path)==value for path,value in history.items())
benchmark_ok=benchmark['equivalent_final_projection'] and all(
    inputs['production_files'].get(path)==value for path,value in benchmark['after']['production_source_sha256'].items())
baseline_ok=all(digest(AUDIT/'baseline-2.2-7'/path)==value for path,value in baseline_inputs.items()) and all(
    baseline_inputs.get(path)==value for path,value in benchmark['before']['production_source_sha256'].items())
controls_ok=controls['source_unchanged_during_controls'] and all(
    row['exit_code']!=0 and row['expected_assertion_failed'] for row in controls['runs']) and all(
    inputs['production_files'].get(path)==value for path,value in controls['production_source_sha256'].items())
cleanup_ok=not cleanup['production_debug_scan_matches'] and all(
    inputs['production_files'].get(path)==value for path,value in cleanup['reviewed_source_sha256'].items())
checksums=ROOT/'packages/2.2-8-session-groups-cpu/SHA256SUMS'
checksums_ok=all(digest(checksums.parent/line.split('  ',1)[1])==line.split('  ',1)[0]
    for line in checksums.read_text().splitlines() if line)

result={
    'timestamp':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),
    'checkout':str(ROOT),'head':git('rev-parse','HEAD'),'branch':git('branch','--show-current'),
    'version':build['version'],'production_matches_build':current_inputs==inputs,
    'behavior_source_hashes_match_build':production_ok,
    'behavior_production_file_count':len(behavior['production_source_sha256']),
    'behavior_fixture_hashes_match':fixture_ok,
    'benchmark_source_hashes_match_build':benchmark_ok,
    'benchmark_equivalent_final_projection':benchmark['equivalent_final_projection'],
    'baseline_snapshot_hashes_match':baseline_ok,
    'checksums_manifest_valid':checksums_ok,
    'negative_controls_valid_for_build':controls_ok,
    'cleanup_review_matches_build':cleanup_ok,
    'cleanup_production_file_count':len(cleanup['reviewed_source_sha256']),
    'behavior_source_unchanged_during_checks':behavior['source_unchanged_during_checks'],
    'behavior_suite_results':[{'runner':row['runner'],'exit_code':row['exit_code'],'stdout':row['stdout']}
        for row in behavior['runs']],
    'legacy_core_results':[{'suite':row['suite'],'exit_code':row['exit_code'],'output':row['output']}
        for row in legacy],
    'rootless_and_rootful_builds_passed':all(row['exit_code']==0 for row in build['builds']),
    'artifact_hashes_match':artifacts_ok,'historical_packages_preserved':history_ok,
    'historical_package_files_checked':len(history),'preexisting_deleted_paths_count':deleted,
    'workspace_Tests_present':(ROOT/'Tests').exists(),
    'device_installed':False,'actual_WeChat_database_accessed':False,
    'device_acceptance_complete':False,
}
(AUDIT/'delivery-verification.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
assert result['production_matches_build'] and production_ok and fixture_ok and benchmark_ok and baseline_ok and checksums_ok and cleanup_ok and controls_ok
assert result['behavior_source_unchanged_during_checks']
assert all(row['exit_code']==0 for row in behavior['runs'])
assert all(row['exit_code']==0 for row in legacy)
assert result['rootless_and_rootful_builds_passed'] and artifacts_ok and history_ok
assert deleted==6892 and not (ROOT/'Tests').exists()
print(json.dumps(result,ensure_ascii=False,indent=2))
