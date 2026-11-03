from datetime import datetime
import argparse
from hashlib import sha256
import json
from pathlib import Path
import subprocess
import sys
from zoneinfo import ZoneInfo

validation=Path(__file__).resolve().parent
root=validation.parents[3]
parser=argparse.ArgumentParser()
parser.add_argument('--output-dir',default='final',help='Directory relative to validation for logs and result JSON.')
arguments=parser.parse_args()
output=validation/arguments.output_dir
output.mkdir(parents=True,exist_ok=True)
paths=['Controllers/CSGroupNativeModel.h','Controllers/CSGroupNativeModel.m',
       'Controllers/CSGroupNativeSessionCoordinator.h','Controllers/CSGroupNativeSessionCoordinator.m',
       'Controllers/CSGroupListAdapter.h','Controllers/CSGroupListAdapter.m',
       'Controllers/CSGroupNativeBridge.h','Controllers/CSGroupNativeBridge.m',
       'Controllers/CSGroupProjection.h','Controllers/CSGroupProjection.m',
       'Controllers/CSGroupPreferences.m','Controllers/WESessionTabItem.m',
       'Controllers/CSCloseFriendPolicy.m','Controllers/CSCloseFriendSignatures.m',
       'Controllers/CSCloseFriendUnreadPanelAdapter.m','Controllers/CSCloseFriendContactAdapter.m',
       'Controllers/CSCloseFriendBridge.m','Hooks/NativeSessionGroupHooks.xm',
       'Hooks/SessionGroupHooks.xm','Hooks/CloseFriendUnreadPanelHooks.xm']
def hashes():return {p:sha256((root/p).read_bytes()).hexdigest() for p in paths}
before=hashes();runs=[]
for name in ['run-native-behavior.sh','run-unread-panel.sh']:
    result=subprocess.run(['bash',str(validation/name)],cwd=root,text=True,capture_output=True)
    (output/(name+'.log')).write_text(result.stdout+result.stderr)
    runs.append({'runner':name,'exit_code':result.returncode,'stdout':result.stdout,'stderr':result.stderr})
    print(result.stdout+result.stderr,end='')
after=hashes()
report={'timestamp':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),
        'project_checkout':str(root),'source_unchanged_during_checks':before==after,
        'production_source_sha256':after,'runs':runs,
        'validation_source_sha256':{str(path.relative_to(validation)):sha256(path.read_bytes()).hexdigest()
            for path in sorted(validation.rglob('*')) if path.is_file() and path.suffix in {'.m','.h','.py','.sh'}},
        'isolation':'Temporary macOS Foundation executables, in-memory NSUserDefaults and host doubles; no live WeChat, account data, database, ports or service changes.',
        'limitations':['Native coordinator/model/bridge/projection/preferences are compiled as production translation units.',
                      'Adapter publication, privacy shielding, fallback transition, native notification, recovery and scheduling bodies plus native forward-enumerator replacement are extracted from current production source.',
                      'Metadata construction, username reads and identity/path resolution use the real production bridge. UIKit, native data source/getters and dispatch are controlled fixture boundaries. The legacy refresh entry after handoff is observed, not its complete UIKit publication; legacy projection behavior has separate executable suites.',
                      'Unread panel runs current production bridge/contact helpers, adapter and hook registrations using a fixture from baseline commit 863bfdb350fddf678c349574d99badb241d98958 exported only into a temporary directory. The complete-source wrapper is a controlled test double; its real implementation is checked in the native suite.',
                      'These executable behavior tests do not replace an iPhone acceptance run.']}
(output/'behavior-result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
sys.exit(0 if before==after and all(r['exit_code']==0 for r in runs) else 1)
