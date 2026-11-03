#!/usr/bin/env python3
"""Bind final behavior/ownership/SDK evidence and shipped builds to current sources."""
from pathlib import Path
from hashlib import sha256
import json
AUDIT=Path(__file__).resolve().parent
ROOT=AUDIT.parents[2]
def read(name):return json.loads((AUDIT/name).read_text())
def verify_hashes(mapping,base=ROOT):
    for name,digest in mapping.items():
        assert sha256((base/name).read_bytes()).hexdigest()==digest,name
behavior=read('validation/final/validation-integrity.json')
assert behavior['all_checks_passed'] and behavior['source_matches_current_production']
verify_hashes(behavior['production_source_sha256'])
verify_hashes(behavior['validation_source_sha256'],AUDIT/'validation')
for name in ('behavior-result.json','compatibility-result.json','negative-controls-result.json','interaction-comparison.json'):
    data=read('validation/final/'+name)
    verify_hashes(data['production_source_sha256'])
    if 'validation_source_sha256' in data:verify_hashes(data['validation_source_sha256'],AUDIT/'validation')
ui=read('ui-validation/current-result.json')
assert ui['exit_code']==0 and sha256(Path(ui['source']).read_bytes()).hexdigest()==ui['sha256']
ui_counts=json.loads(ui['output'])
assert ui_counts['checks']==135 and ui_counts['failures']==0
ui_negative=read('ui-validation/negative-controls-result.json')
assert ui_negative['all_caught'] and all(row['caught'] for row in ui_negative['results'])
observation=read('review/observation/result.json')
assert observation['exit_code']==0 and 'PASS 63 ' in observation['output']
verify_hashes(observation['source_sha256'])
syntax=read('observation-validation/syntax-result.json')
assert syntax['passed'] and len(syntax['checks'])==20
for row in syntax['checks']:
    assert row['exit_code']==0
    verify_hashes({row['source']:row['source_sha256']})
delivery=read('delivery-integrity.json')
assert delivery['build_source_matches_current_production'] and delivery['same_source_for_both_variants']
assert delivery['previous_tracked_deletions_preserved']==6892
for variant in ('normal','observation'):
    verify_hashes(read('builds/final/'+variant+'/production-inputs.json')['production_files'])
    build=read('builds/final/'+variant+'/build-result.json')
    assert all(row['exit_code']==0 for row in build['builds'])
    assert not build['device_installed']
    verify_hashes({row['path']:row['sha256'] for row in build['artifacts']})
assert not (ROOT/'Tests').exists()
result={
 'all_checks_passed':True,'current_sources_match_all_final_evidence':True,
 'behavior_assertions':behavior['assertion_counts'],
 'ui_assertions':ui_counts['checks'],'observation_scope_owner_hint_assertions':63,
 'negative_controls_caught':behavior['negative_controls_expected_failures']+ui_negative['negative_controls'],
 'sdk_syntax_checks':len(syntax['checks']),
 'large_source_workload':behavior['large_source_workload'],
 'stable_ui_workload':ui_counts,'final_packages_verified':len(delivery['verified_packages']),
 'device_installed':False,'device_performance_measurement':False,
 'tracked_deletions_preserved':6892,
 'prior_instruments_files_preserved':delivery['prior_instruments_files_preserved']}
(AUDIT/'final-evidence-integrity.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(result,ensure_ascii=False,indent=2))
