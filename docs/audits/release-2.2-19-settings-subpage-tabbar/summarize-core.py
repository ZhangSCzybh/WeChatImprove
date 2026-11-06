#!/usr/bin/env python3
"""Summarize fresh revalidation outputs; never rewrite inherited raw gate results."""
from pathlib import Path
import hashlib
import json
import re
A=Path(__file__).resolve().parent
R=A/'release-core-revalidation'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def read(n): return (R/'runs'/(n+'.log')).read_text()
def count(n, pattern):
 m=re.search(pattern,read(n)); assert m,(n,pattern)
 return int(m.group(1))
def main():
 result=json.loads((R/'result.json').read_text())
 assert result['all_selected_passed'] and result['completed_tasks']==92
 assert result['raw_passed']==82 and result['raw_failed']==0
 assert result['modern_suite_count']==10
 assert result['production_unchanged_during_revalidation'] and result['fixture_bytes_preserved']
 counts={
 'quick_reset':count('quick-reset259',r'Quick reset: (\d+) checks, 0 failures'),
 'new_password':count('new-password105',r'new-password production path: (\d+) checks, 0 failures'),
 'quick_entry':count('quick90',r'Quick entry: (\d+) checks, 0 failures'),
 'rollback':count('rollback232',r'Rollback/migration: (\d+) checks, 0 failures'),
 'compact':sum(map(int,re.findall(r'PASS: (\d+) checks, 0 failures',read('compact1436')))),
 'settings':count('prior-settings',r'current accepted=True PASS: (\d+) settings lifecycle checks'),
 'search_title':0,
 'merge_policy':count('prior-merge',r'PASS: (\d+) message merge/navigation checks'),
 'header':count('header37152',r'Header gap lifecycle: (\d+) checks, 0 failures'),
 'layout_preferences':count('verify-layout-preferences.sh',r'PASS: (\d+) layout preference snapshot checks'),
 'list_corners':count('verify-list-corners.sh',r'List corners: (\d+) checks, 0 failures'),
 'group_header':count('verify-group-header.sh',r'Group header semantics: (\d+) checks, 0 failures'),
 'group_indicator':count('verify-group-indicator.sh',r'(\d+) checks'),
 'privacy':count('verify-close-friend-privacy.sh',r'CloseFriendPrivacyTests: (\d+) checks passed')}
 privacy=(R/'prior-privacy/results.json')
 privacy_runs=json.loads(privacy.read_text())['results']
 for row in privacy_runs:
  if row['source']=='current':
   assert row['exit_code']==0
   counts['search_title']+=sum(map(int,re.findall(r'(?:CloseFriendContactTests|CloseFriendRecoveryTests): (\d+) checks passed',row['output'])))
 merge_counts=list(map(int,re.findall(r'current [^ ]+ accepted=True PASS: (\d+) native adapter',read('prior-merge'))))
 assert len(merge_counts)==3 and len(set(merge_counts))==1
 counts['merge_adapter_per_supported_version']=merge_counts[0]
 tabbar=json.loads((R/'prior-tabbar/validation-result.json').read_text())
 assert all(x['exit_code']==0 for x in tabbar)
 counts['tabbar_validation_steps']=len(tabbar)
 six=['verify-message-merge.sh','verify-bubble-style.sh','verify-merge-bubble-integration.sh','verify-message-time.sh','verify-message-gesture.sh','verify-attachment-layout.sh']
 patterns={six[0]:r'PASS: (\d+) [^\n]*checks',six[1]:r': (\d+) checks passed',six[2]:r'; (\d+) checks;',six[3]:r'PASS: (\d+) message-time',six[4]:r'PASS: (\d+) production gesture',six[5]:r'Attachment layout: (\d+) checks passed'}
 layout_counts={n:sum(map(int,re.findall(patterns[n],read(n)))) for n in six}
 counts['message_layout_six_script_checks']=sum(layout_counts.values())
 assert [counts[k] for k in ['quick_reset','new_password','quick_entry','rollback','compact','settings','search_title','header']]==[259,105,90,232,1436,5114,357,37152],counts
 gate=json.loads((A/'REGRESSION-GATE.json').read_text())
 inherited=json.loads((A.parent/'release-2.2-18-settings-return-header-gap/REGRESSION-GATE.json').read_text())
 fields=['script_count','passed','failed','runs','failures','inherited_evidence_base']
 assert all(gate[k]==inherited[k] for k in fields)
 out={'fresh_revalidation':{'completed_tasks':92,'passed_tasks':92,'failed_tasks':0,'original_unwaived_scripts':82,'modern_suites':10},'core_counts':counts,'message_layout_six_details':layout_counts,'compact_gap_pt':2,'normal_gap_pt':[21,24],'header_geometry':{'checks':37152,'failed':0,'scenarios':432,'stages_per_scenario':14,'geometry_samples':6048},'original_gate_statistics_unchanged':{'script_count':100,'passed':82,'failed':18},'original_gate_raw_fields_unchanged':fields,'waived_failures':18,'waiver':'WAIVER.md','authority':'WAIVER-CONTINUATION.md','new_failures_outside_waiver':0,'fixtures_and_assertions_changed':False,'fixture_and_runner_files_protected':len(json.loads((R/'fixture-before.json').read_text())),'source_manifest_sha256':sha(R/'production-before.json'),'evidence_result_sha256':sha(R/'result.json'),'counts_overlap_do_not_sum':True,'device_validated':False,'host_boundary_tests_are_not_UIKit_device_runtime':True}
 (A/'CORE-REGRESSIONS.json').write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n')
 print(json.dumps(out,ensure_ascii=False,indent=2))
if __name__=='__main__':main()
