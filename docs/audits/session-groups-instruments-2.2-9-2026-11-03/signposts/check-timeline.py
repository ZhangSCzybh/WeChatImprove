#!/usr/bin/env python3
"""Correlate an existing trace's TOC clock, capture start and external cue.

Reports only event timestamps/counts and fixed broad source groups. Does not
output any message text, user data, process names or non-public subsystem names.
"""
import argparse
import importlib.util
import json
import math
from collections import Counter
from datetime import datetime,timedelta
from pathlib import Path
import xml.etree.ElementTree as ET

base=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('signposts',base/'analyze-signposts.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

def summarize(times):
    times=sorted(times)
    return {'unique_event_count':len(times),'first_seconds':times[0]/1e9 if times else None,
            'last_seconds':times[-1]/1e9 if times else None,
            'counts_by_1s_bin':dict(sorted(Counter(str(t//1_000_000_000) for t in times).items(),key=lambda x:int(x[0]))),
            'maximum_gap_between_events_seconds':max((b-a)/1e9 for a,b in zip(times,times[1:])) if len(times)>1 else None}

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--toc',type=Path,required=True);p.add_argument('--xml',type=Path,required=True)
p.add_argument('--capture',type=Path,required=True);p.add_argument('--cue',required=True)
p.add_argument('--pid',type=int,required=True);p.add_argument('--output',type=Path,required=True)
a=p.parse_args()
if a.output.exists():p.error('Refusing to overwrite existing evidence')
toc=ET.parse(a.toc).getroot()
def toc_text(name):
    return next((x.text.strip() for x in toc.iter() if m.tag(x)==name and x.text),None)
start=datetime.fromisoformat(toc_text('start-date'));end=datetime.fromisoformat(toc_text('end-date'))
cue=datetime.fromisoformat(a.cue);capture=json.loads(a.capture.read_text())
started=datetime.fromisoformat(capture['started_at'])
source=m.Export(a.xml,'os-signpost');seen=set();groups={k:[] for k in ('all_sources','target_apple','other_process_apple','target_own')}
for table,seq,cells,types in source.rows():
    time=source.number(cells.get('time'));pid=source.pid(cells.get('process'))
    if time is None or pid is None:continue
    subsystem=source.text(cells.get('subsystem'))
    signature=(time,pid,source.tid(cells.get('thread')),*[source.text(cells.get(x),formatted=x=='message') for x in ('identifier','name','event-type','scope','subsystem','category','format-string','message')])
    if signature in seen:continue
    seen.add(signature);groups['all_sources'].append(time)
    if subsystem.startswith('com.apple.'):
        groups['target_apple' if pid==a.pid else 'other_process_apple'].append(time)
    if pid==a.pid and subsystem==m.SUBSYSTEM and source.text(cells.get('category'))==m.CATEGORY:
        groups['target_own'].append(time)
relative_cue=(cue-start).total_seconds()
window=capture['analysis_window_seconds'];first=min(groups['target_own'])/1e9 if groups['target_own'] else None
out={'target_pid':a.pid,'source_inputs':{str(x):m.digest(x) for x in (a.toc,a.xml,a.capture)},
     'clock':{'subprocess_started_at':started.isoformat(),'trace_start':start.isoformat(),'trace_end':end.isoformat(),
              'trace_toc_duration_seconds':float(toc_text('duration')),'trace_start_delay_from_subprocess_seconds':(start-started).total_seconds(),
              'cue':cue.isoformat(),'cue_trace_relative_seconds':relative_cue,
              'trace_time_remaining_after_cue_seconds':(end-cue).total_seconds(),
              'preset_analysis_window_seconds':window,'preset_window_after_cue_seconds':max(0,min(window[1],(end-start).total_seconds())-max(window[0],relative_cue)),
              'first_own_probe_wall_time':(start+timedelta(seconds=first)).isoformat() if first is not None else None,
              'first_own_probe_seconds_after_cue':first-relative_cue if first is not None else None},
     'event_timing_groups':{k:summarize(v) for k,v in groups.items()},'xml_issues':dict(source.issues),
     'limits':['Event presence throughout a trace establishes that those event sources were collected; it does not prove no lost records or that the user acted continuously.',
               'A cue time is not the user action start. First own probe time is not necessarily the first user interaction.',
               'Do not use fixed preset windows as active-scenario evidence when the cue occurs late. Raw signpost tails may extend slightly past TOC end due to instrument timestamp handling.']}
a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'output':str(a.output),'clock':out['clock'],'groups':{k:{'first':v['first_seconds'],'last':v['last_seconds'],'count':v['unique_event_count']} for k,v in out['event_timing_groups'].items()}},ensure_ascii=False))
