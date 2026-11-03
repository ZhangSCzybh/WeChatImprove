#!/usr/bin/env python3
"""Record one explicitly named iPhone scenario without launching or replacing an app."""
import argparse
from datetime import datetime
import json
from pathlib import Path
import subprocess
from zoneinfo import ZoneInfo

HERE=Path(__file__).resolve().parent
parser=argparse.ArgumentParser()
parser.add_argument('scenario',choices=['idle','messages','scroll','switch','smoke'])
parser.add_argument('--seconds',type=int,default=70)
parser.add_argument('--pid',type=int,required=True)
parser.add_argument('--device',required=True)
parser.add_argument('--all-processes',action='store_true',help='Use only if attaching the confirmed PID is unavailable.')
parser.add_argument('--label',help='Unique run folder, for a preserved retry.')
args=parser.parse_args()
label=args.label or args.scenario
if not label.replace('-','').replace('_','').isalnum():raise SystemExit('Invalid run label.')
folder=HERE/label
if folder.exists():raise SystemExit('Scenario output exists; preserve the previous run.')
folder.mkdir()
command=['xcrun','xctrace','record','--template','Activity Monitor','--instrument','Frame Lifetimes',
    '--instrument','Core Animation FPS','--instrument','Core Animation Commits',
    '--instrument','os_signpost','--instrument','Thermal State',
    '--recording-options',str(HERE/'recording-options.json'),
    '--device',args.device,*(['--all-processes'] if args.all_processes else ['--attach',str(args.pid)]),'--time-limit',str(args.seconds)+'s',
    '--run-name','2.2-9+observe-'+args.scenario,'--output',str(folder/'raw.trace')]
report={'scenario':args.scenario,'plugin_version':'2.2-9+observe','bundle_id':'com.tencent.xin',
    'target_pid':args.pid,'target_device':args.device,'command':command,
    'started_at':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),
    'analysis_window_seconds':[5,args.seconds-5],
    'scope':('System instrument acquisition' if args.all_processes else 'Instruments target attached to the confirmed PID')+'; analysis restricted to the explicitly selected WeChat PID where tables carry PID; no app launch, restart or configuration changes.'}
(folder/'capture-result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
with (folder/'record.log').open('w') as log:
    process=subprocess.Popen(command,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,bufsize=1)
    report['recorder_pid']=process.pid
    (folder/'capture-result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    for line in process.stdout:
        log.write(line);log.flush();print(line,end='',flush=True)
        phase = next((name for text,name in [
            ('Starting recording','starting_recording_output_at'),
            ('Reached specified time limit','time_limit_output_at'),
            ('Recording completed. Saving','saving_output_at')
        ] if text in line),None)
        if phase:
            report[phase]=datetime.now(ZoneInfo('Asia/Shanghai')).isoformat()
            (folder/'capture-result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    code=process.wait()
report.update({'exit_code':code,'ended_at':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),
    'trace_present':(folder/'raw.trace').exists()})
(folder/'capture-result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
raise SystemExit(code)
