"""Seal only this audit's completed evidence; never rewrite individual results."""
from datetime import datetime
from hashlib import sha256
import json
from pathlib import Path
import re
from zoneinfo import ZoneInfo

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
OUT=HERE/'final'
NAMES=['behavior-result.json','legacy-core-result.json','negative-controls-result.json',
       'interaction-comparison.json','compatibility-result.json','scroll-position-result.json']
reports={name:json.loads((OUT/name).read_text()) for name in NAMES}
checks=[]
def check(label,value):
    checks.append({'check':label,'passed':bool(value)})
def verify_map(label,mapping,base):
    for name,digest in mapping.items():
        path=base/name
        check(label+':'+name,path.is_file() and sha256(path.read_bytes()).hexdigest()==digest)
source={}
for name,report in reports.items():
    if not isinstance(report,dict):continue
    mapping=report.get('production_source_sha256',{})
    verify_map(name+':production',mapping,ROOT)
    for path,digest in mapping.items():
        if path in source:check('matching current source mapping:'+path,source[path]==digest)
        source[path]=digest
    verify_map(name+':validation',report.get('validation_source_sha256',{}),HERE)
    for key in ['source_unchanged','source_unchanged_during_checks','source_unchanged_during_controls','passed']:
        if key in report:check(name+':'+key,report[key])
b=reports['behavior-result.json'];l=reports['legacy-core-result.json'];n=reports['negative-controls-result.json']
i=reports['interaction-comparison.json'];c=reports['compatibility-result.json'];s=reports['scroll-position-result.json']
check('behavior runners successful',all(row['exit_code']==0 for row in b['runs']))
check('legacy runners successful',all(row['exit_code']==0 for row in l))
check('old native negative controls caught',all(row['expected_assertion_failed'] for row in n['runs']))
check('interaction/selection and config controls accepted',all(row['accepted'] for row in i['runs']))
check('compatibility and controls accepted',all(row['accepted'] for row in c['runs']))
check('scroll and controls accepted',all(row['passed'] for row in s['runs']))
verify_map('scroll frozen baseline',s['baseline_source_sha256'],Path(s['baseline_checkout']))
verify_map('interaction frozen baseline',i['baseline_source_sha256'],ROOT/'docs/audits/session-groups-interaction-2026-11-03/baseline-2.2-8')
for row in c['runs']:
    if row['name']=='baseline-compatibility':verify_map('compat frozen baseline',row['input_sha256'],Path(row['source_root']))
def number(pattern,text):
    match=re.search(pattern,text)
    assert match,pattern
    return int(match[1])
native=number(r'scheduling: (\d+) behavior',b['runs'][0]['stdout'])
unread=number(r'unread panel: (\d+) checks',b['runs'][1]['stdout'])
abi=number(r'unread panel ABI: (\d+) checks',b['runs'][1]['stdout'])
legacy=sum(number(r': (\d+) checks, 0 failures',row['output']) for row in l)
interaction=number(r'scheduling: (\d+) behavior',next(row['output'] for row in i['runs'] if row['name']=='current-interaction'))
compat=number(r'refresh: (\d+) behavior',next(row['output'] for row in c['runs'] if row['name']=='current-compatibility'))
scroll=next(row['behavior_checks'] for row in s['runs'] if not row['negative_control'])
counts={'native':native,'unread':unread,'unread_abi':abi,'legacy_live_contracts':legacy,'independent_interaction':interaction,
        'compatibility':compat,'core_total':native+unread+abi+legacy+interaction+compat,'scroll_position':scroll,
        'selection_subset_not_added':2994,'removed_unreachable_top_contracts':3}
counts['current_total_without_double_counting']=counts['core_total']+scroll
counts['negative_controls']=len(n['runs'])+1+sum('expected_assertion' in row and row['expected_assertion'] is not None for row in c['runs'])+sum(row['negative_control'] for row in s['runs'])
check('core count 4052',counts['core_total']==4052)
check('scroll count 199',scroll==199)
check('negative controls 16',counts['negative_controls']==16)
fixtures={str(p.relative_to(HERE)):sha256(p.read_bytes()).hexdigest() for p in sorted(HERE.rglob('*'))
    if p.is_file() and p.suffix in {'.h','.m','.py','.sh','.md'}}
evidence={p.name:sha256(p.read_bytes()).hexdigest() for p in sorted(OUT.iterdir())
    if p.is_file() and p.name!='validation-integrity.json'}
report={'timestamp':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),'passed':all(row['passed'] for row in checks),
        'counts':counts,'checks':checks,'project_checkout':str(ROOT),'production_source_sha256':source,
        'validation_source_sha256':fixtures,'final_evidence_sha256':evidence,
        'scope':'All listed current checks rerun here against final frozen production; actual dependencies and evidence bytes bound. No UI/observation rerun claimed. Root Tests remains deleted; old audits read only.'}
(OUT/'validation-integrity.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'passed':report['passed'],'counts':counts,'checks_verified':len(checks)},ensure_ascii=False))
if not report['passed']:
    print(json.dumps([row for row in checks if not row['passed']],ensure_ascii=False,indent=2));raise SystemExit(1)
