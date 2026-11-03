#!/usr/bin/env python3
"""Offline parser regression checks, using captured smoke plus labeled derivatives.

Derived event sequences below validate parser behavior only. They are never
written to measured summaries and never count as device observations.
"""
import copy
import importlib.util
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('signposts',BASE/'analyze-signposts.py')
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
raw = BASE.parent/'smoke/export/smoke-signposts.xml'
args = BASE.parent/'smoke/export/smoke-signpost-args.xml'
before = [module.digest(raw),module.digest(args)]
events,info = module.parse_raw(raw,args,40208)
checks=[]
def check(condition,name):
    assert condition,name
    checks.append(name)
check(len(events)==215,'actual smoke: 215 distinct own events')
check(info['cross_table_duplicate_events_merged']==215,'actual smoke: 215 cross-table duplicate rows merged')
check(not info['issues'] and not info['arguments']['issues'],'actual smoke: XML references and numeric payloads resolve without issues')
check(all(e['name'] in module.OPERATIONS+module.EVENTS for e in events),'actual smoke: only fixed own probe names leave parser')
intervals,incomplete,issues = module.pair(copy.deepcopy(events))
check(len(intervals)==16 and not incomplete and not issues,'actual smoke: 16 complete intervals, no unmatched or crossing pairs')
check(all(x['name']=='TabRecordsUpdateAttempt' and x['outcome']==8 for x in intervals),'actual smoke: Tab update Unchanged outcome retained')
wrong,_ = module.parse_raw(raw,args,40209)
check(not wrong,'negative control: wrong target PID yields no own observations')
removed=copy.deepcopy(events)
first_end=next(i for i,e in enumerate(removed) if e['kind']=='End')
removed.pop(first_end)
truncated,truncated_incomplete,_=module.pair(removed)
check(len(truncated)==15 and any(x['reason']=='begin_without_end' for x in truncated_incomplete),'negative control: missing end excluded from completed timing')
summary=module.summarize(events,intervals,incomplete,0,32_000_000_000)
check(summary['main_table_reload_coverage']['MainTableReloadData']['status']=='unavailable','actual smoke: absent target is unavailable, never validated zero')
left=intervals[0]['start_ns']; right=intervals[0]['end_ns']
boundary=module.summarize(events,intervals,incomplete,left+1,right+1)
check(boundary['operations']['TabRecordsUpdateAttempt']['complete_interval_count']==0 and boundary['complete_intervals_crossing_analysis_boundary']==1,'negative control: boundary-crossing interval excluded')
# A labeled parser-only fixture validates nesting/target attribution not yet
# present in the first actual smoke. These are not device observations.
def fixture(time,name,kind,identifier,**payload):
    return {'time_ns':time,'thread_id':1,'identifier':identifier,'name':name,'kind':kind,**payload}
nested=[fixture(0,'CoordinatorApply','Begin',100),fixture(1,'ModelSelection','Begin',101),
        fixture(2,'ModelSelection','End',101,outcome=2,units=0),fixture(3,'CoordinatorApply','End',100,outcome=6,units=0),
        fixture(4,'MainTableTargetVerified','Event',999,units=3),fixture(5,'AdapterPublication','Begin',102),
        fixture(6,'MainTableReloadRows','Begin',103),fixture(7,'ReloadRowsCompleted','Event',999,units=2),
        fixture(8,'MainTableReloadRows','End',103,outcome=1,units=2),fixture(9,'PublicationCompleted','Event',999,units=0),
        fixture(10,'AdapterPublication','End',102,outcome=1,units=0)]
ni,unpaired,nissues=module.pair(nested)
check(not unpaired and not nissues and next(x for x in ni if x['name']=='ModelSelection')['coordinator_index']==0,
      'parser-only fixture: same-thread nested model belongs to coordinator')
ns=module.summarize(nested,ni,[],0,11)
check(ns['main_table_reload_coverage']['MainTableReloadRows']['status']=='verified_publication_scope_only' and
      ns['events']['ReloadRowsCompleted']['units_sum']==2 and ns['events']['PublicationCompleted']['unowned_completion_count']==0,
      'parser-only fixture: target mask and completion scope are distinct from reload units')
check(before==[module.digest(raw),module.digest(args)],'raw XML remains byte-identical after parsing')
result={'kind':'offline_parser_regression_not_device_measurement','passed':len(checks),'checks':checks,
        'actual_smoke_input_sha256':before}
path=BASE/'parser-validation-v2.json'
if path.exists():raise SystemExit('Refusing to overwrite parser validation evidence')
path.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'passed':len(checks),'output':str(path)}))
