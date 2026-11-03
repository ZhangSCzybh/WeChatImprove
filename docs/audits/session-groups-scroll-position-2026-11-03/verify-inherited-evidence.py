#!/usr/bin/env python3
"""Bind unchanged UI/probe tests to the immutable 2.2-10 evidence; do not rerun or rewrite it."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
OLD=ROOT/'docs/audits/session-groups-efficiency-2026-11-03'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(p.read_text())
expected='01f8574a4bcdcf7466393bf89b09b193d08b3fd7d34aba07164f9f2a4de4f3a3'
assert sha(OLD/'evidence-manifest.json')==expected
manifest=read(OLD/'evidence-manifest.json')
assert all(sha(OLD/row['path'])==row['sha256'] for row in manifest['files'])
ui=read(OLD/'ui-validation/current-result.json');counts=json.loads(ui['output'])
assert ui['exit_code']==0 and sha(Path(ui['source']))==ui['sha256'] and counts['checks']==135 and counts['failures']==0
result={'previous_audit_manifest_sha256':expected,'previous_audit_verified_files':len(manifest['files']),
        'ui_checks_inherited_not_rerun':135,
        'observation_tests_not_inherited':'Observation production module intentionally removed.',
        'production_source_sha256':{str(Path(ui['source']).relative_to(ROOT)):ui['sha256']},
        'reason':'Unchanged UI geometry implementation source hash match the sealed 2.2-10 tests exactly.',
        'device_performance_measurement':False,'all_hashes_match':True}
(HERE/'inherited-evidence.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(result,ensure_ascii=False,indent=2))
