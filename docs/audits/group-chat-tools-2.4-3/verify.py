#!/usr/bin/env python3
"""Run the release's host-only fixture and regression checks; no WeChat operations."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import json
import subprocess
import time

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
SCRIPTS = [
    'group-chat-core', 'group-chat-store', 'group-chat-mentions',
    'group-chat-notice', 'group-chat-manager', 'group-chat-quit', 'group-chat-backup',
    'message-actions-execution', 'native-contact-picker', 'revoke-reference',
    'backup-registry', 'backup-engine', 'backup-reset', 'backup-transactions',
    'ai-backup', 'scheduled-task-backup', 'backup-codec',
    'backup-restore-paths', 'backup-compatibility',
]
if (ROOT/'Tests/verify-group-chat-runtime.sh').is_file():
    SCRIPTS.append('group-chat-runtime')
LOGS = AUDIT/'test-logs'
LOGS.mkdir(exist_ok=True)

def run(name):
    start = time.monotonic()
    result = subprocess.run(['bash', str(ROOT/f'Tests/verify-{name}.sh')], cwd=ROOT,
                            text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    log = LOGS/f'{name}.log'
    log.write_text(result.stdout)
    return {'name': name, 'exit_code': result.returncode,
            'seconds': round(time.monotonic()-start, 2), 'log': str(log),
            'result': result.stdout.strip().splitlines()[-1] if result.stdout.strip() else ''}

with ThreadPoolExecutor(max_workers=3) as pool:
    results = list(pool.map(run, SCRIPTS))
report = {'checkout': str(ROOT), 'real_wechat_operations': False,
          'passed': all(item['exit_code']==0 for item in results), 'checks': results}
(AUDIT/'test-results.json').write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n')
for item in results:
    print(f"{item['name']}: exit {item['exit_code']}; {item['result']}")
raise SystemExit(0 if report['passed'] else 1)
