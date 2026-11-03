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
current_inputs=runpy.run_path(str(AUDIT/'build-packages.py'))['inputs'](ROOT)
status=subprocess.check_output(['git','status','--porcelain=v1','-z'],cwd=ROOT).split(b'\0')
deleted=sum(row[:2] in (b' D',b'D ') for row in status if row)
artifacts_ok=all(digest(ROOT/row['path'])==row['sha256'] for row in build['artifacts'])
fixture_ok=all(digest(AUDIT/'validation'/path)==value
    for path,value in behavior['validation_source_sha256'].items())
production_ok=all(inputs['production_files'].get(path)==value
    for path,value in behavior['production_source_sha256'].items())
history_ok=all((ROOT/path).is_file() and digest(ROOT/path)==value for path,value in history.items())
result={
    'timestamp':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),
    'checkout':str(ROOT),'head':git('rev-parse','HEAD'),'branch':git('branch','--show-current'),
    'version':build['version'],'production_matches_build':current_inputs==inputs,
    'behavior_source_hashes_match_build':production_ok,
    'behavior_production_file_count':len(behavior['production_source_sha256']),
    'behavior_fixture_hashes_match':fixture_ok,
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
assert result['production_matches_build'] and production_ok and fixture_ok
assert result['behavior_source_unchanged_during_checks']
assert all(row['exit_code']==0 for row in behavior['runs'])
assert all(row['exit_code']==0 for row in legacy)
assert result['rootless_and_rootful_builds_passed'] and artifacts_ok and history_ok
assert deleted==6892 and not (ROOT/'Tests').exists()
print(json.dumps(result,ensure_ascii=False,indent=2))
