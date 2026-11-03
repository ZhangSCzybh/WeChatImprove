#!/usr/bin/env python3
"""Bind final behavior, cleanup, SDK and binary evidence to the shipped source."""
from pathlib import Path
from hashlib import sha256
import json
import re
AUDIT=Path(__file__).resolve().parent
ROOT=AUDIT.parents[2]
V=AUDIT/'validation'
def read(path):return json.loads((AUDIT/path).read_text())
def check(mapping,base=ROOT):
    for name,digest in mapping.items():assert sha256((base/name).read_bytes()).hexdigest()==digest,str(base/name)
def report(name):
    data=read('validation/final/'+name)
    check(data.get('production_source_sha256',{}))
    check(data.get('validation_source_sha256',{}),V)
    return data
integrity=read('validation/final/validation-integrity.json')
assert integrity['passed'] and len(integrity['checks'])==227 and all(row['passed'] for row in integrity['checks'])
check(integrity['production_source_sha256']);check(integrity['validation_source_sha256'],V)
check(integrity['final_evidence_sha256'],V/'final')
behavior=report('behavior-result.json')
assert behavior['source_unchanged_during_checks'] and all(r['exit_code']==0 for r in behavior['runs'])
outputs={r['runner']:r['stdout']+r['stderr'] for r in behavior['runs']}
native=int(re.search(r'Native model/coordinator/adapter/scheduling: (\d+) behavior checks passed',outputs['run-native-behavior.sh'])[1])
panel=outputs['run-unread-panel.sh']
unread=int(re.search(r'Close-friend unread panel: (\d+) checks, 0 failures',panel)[1])
abi=int(re.search(r'Close-friend unread panel ABI: (\d+) checks, 0 failures',panel)[1])
legacy=read('validation/final/legacy-core-result.json');assert all(r['exit_code']==0 for r in legacy)
legacy_count=sum(int(re.search(r'(\d+) checks, 0 failures',r['output'])[1]) for r in legacy)
compat=report('compatibility-result.json');assert compat['source_unchanged'] and all(r['accepted'] for r in compat['runs'])
compat_count=int(re.search(r': (\d+) behavior checks passed',next(r['output'] for r in compat['runs'] if r['name']=='current-compatibility'))[1])
interaction=report('interaction-comparison.json');assert interaction['source_unchanged'] and all(r['accepted'] for r in interaction['runs'])
interaction_count=int(re.search(r': (\d+) behavior checks passed',next(r['output'] for r in interaction['runs'] if r['name']=='current-interaction'))[1])
controls=report('negative-controls-result.json');assert controls['source_unchanged_during_controls'] and all(r['expected_assertion_failed'] for r in controls['runs'])
scroll=report('scroll-position-result.json');assert scroll['passed'] and scroll['source_unchanged_during_checks']
check(scroll['baseline_source_sha256'],AUDIT/'baseline-2.2-10')
assert all(r['passed'] for r in scroll['runs'])
for row in scroll['runs']:assert sha256((V/'final'/row['log']).read_bytes()).hexdigest()==row['log_sha256']
scroll_count=next(r['behavior_checks'] for r in scroll['runs'] if not r['negative_control'])
negative_count=len(controls['runs'])+sum(r['name'].startswith('compat-') for r in compat['runs'])+sum(r['exit_code']!=0 for r in interaction['runs'])+sum(r['negative_control'] for r in scroll['runs'])
counts={'native_core':native,'unread_panel':unread,'unread_panel_abi':abi,'legacy_core':legacy_count,
        'independent_interaction':interaction_count,'compatibility_refresh_publication':compat_count}
assert sum(counts.values())==4052 and scroll_count==199 and negative_count==16
review=read('review/independent-review-result.json')
assert review['status']=='passed' and not review['remaining_blocking_findings']
check(review['production_inputs']);check(review['review_artifacts'],AUDIT/'review')
assert all(not (ROOT/n).exists() for n in review['removed_production_files'])
assert all(not r['matches'] for r in review['production_cleanup_scans'].values())
runtime=read('review/runtime-install-result.json');assert runtime['passed'] and runtime['total_assertions']==69
check(runtime['production_inputs'])
syntax=read('sdk-validation/syntax-result.json');assert syntax['passed'] and len(syntax['checks'])==4
for row in syntax['checks']:
    assert row['exit_code']==0
    check({row['source']:row['source_sha256']})
inherit=read('inherited-evidence.json');assert inherit['all_hashes_match'] and inherit['ui_checks_inherited_not_rerun']==135
check(inherit['production_source_sha256'])
delivery=read('delivery-integrity.json');assert delivery['build_source_matches_current_production'] and delivery['observation_source_and_binary_absent']
assert delivery['previous_tracked_deletions_preserved']==6892
check(read('builds/final/normal/production-inputs.json')['production_files'])
build=read('builds/final/normal/build-result.json');assert all(r['exit_code']==0 for r in build['builds']) and not build['device_installed']
check({r['path']:r['sha256'] for r in build['artifacts']})
assert not (ROOT/'Tests').exists()
result={'all_checks_passed':True,'current_sources_match_final_evidence_and_shipped_builds':True,
        'validation_integrity_checks':len(integrity['checks']),
        'core_behavior_assertions':counts,'core_behavior_total':sum(counts.values()),
        'scroll_position_assertions':scroll_count,'total_distinct_behavior_assertions':sum(counts.values())+scroll_count,
        'negative_controls_caught':negative_count,'runtime_optional_hook_assertions':69,'runtime_cases':7,
        'sdk_syntax_checks':len(syntax['checks']),'ui_checks_inherited_not_rerun':135,
        'prior_dead_top_contracts_removed':3,'prior_dead_top_contracts_reason':'Native, compatibility and legacy publishers each lost one assertion for the removed unreachable custom-top state; safety checks remain.',
        'final_packages_verified':len(delivery['verified_packages']),'removed_observation_files':delivery['removed_observation_files'],
        'tracked_deletions_preserved':6892,'prior_audits_preserved':delivery['prior_audits_preserved'],
        'device_installed':False,'device_performance_measurement':False}
(AUDIT/'final-evidence-integrity.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(result,ensure_ascii=False,indent=2))
