#!/usr/bin/env python3
"""Run offline welcome-fix fixtures; never operate a live WeChat account."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import json
import hashlib
import subprocess
import time

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
LOGS = AUDIT / 'test-logs'
LOGS.mkdir(exist_ok=True)
SCRIPTS = [
    'group-chat-core', 'group-chat-store', 'group-chat-mentions',
    'group-chat-notice', 'group-chat-manager', 'group-chat-runtime',
    'group-chat-quit', 'group-chat-backup', 'message-actions-execution',
    'native-contact-picker', 'revoke-reference',
]
MODES = [
    'short-gap', 'quiet-active', 'submit-failure', 'prepare-failure',
    'inactive-bounce', 'deferred-coalescing', 'deferred-background',
    'deferred-config', 'deferred-account', 'deferred-covered',
    'system-hint', 'system-coalescing', 'system-covered',
    'system-expired-epoch', 'system-background', 'system-config', 'system-account',
    'inactive-deadline', 'inactive-deadline-background', 'inactive-deadline-config',
    'inactive-deadline-account', 'inactive-deadline-expired',
    'system-busy', 'system-busy-exhausted', 'system-busy-background',
]
JOBS = [(name, ['bash', str(ROOT / f'Tests/verify-{name}.sh')])
        for name in SCRIPTS]
JOBS += [('manager-' + mode, ['bash', str(ROOT / 'Tests/verify-group-chat-manager.sh'), mode])
         for mode in MODES]
sdk = subprocess.check_output(['xcrun', '--sdk', 'iphoneos', '--show-sdk-path'], text=True).strip()
JOBS.append(('group-chat-ios-strict-syntax', [
    'xcrun', '--sdk', 'iphoneos', 'clang', '-fsyntax-only', '-fobjc-arc', '-fblocks',
    '-arch', 'arm64e', '-miphoneos-version-min=15.0', '-isysroot', sdk,
    '-Wall', '-Wextra', '-Werror', '-Wno-deprecated-declarations',
    '-IHeaders', '-IControllers', '-IHooks', '-I/Users/zhangshichao/theos/vendor/include',
    '-F/Users/zhangshichao/theos/vendor/lib',
    *[str(path.relative_to(ROOT)) for path in sorted((ROOT / 'Controllers').glob('CSGroupChat*.m'))],
]))


def run(job):
    name, command = job
    start = time.monotonic()
    result = subprocess.run(command, cwd=ROOT, text=True,
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    log = LOGS / f'{name}.log'
    log.write_text(result.stdout)
    return {'name': name, 'command': command, 'exit_code': result.returncode,
            'seconds': round(time.monotonic() - start, 2), 'log': str(log),
            'result': result.stdout.strip().splitlines()[-1] if result.stdout.strip() else 'no diagnostics'}


def inputs():
    paths = [path for folder in ('Controllers', 'Hooks', 'Headers', 'Tests')
             for path in (ROOT / folder).rglob('*')
             if path.is_file() and path.suffix in ('.m', '.h', '.xm', '.sh')]
    paths += [ROOT / name for name in ('Makefile', 'control', 'WeChatImprove.plist')]
    return {str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest()
            for path in sorted(paths)}


before = inputs()
with ThreadPoolExecutor(max_workers=3) as pool:
    results = list(pool.map(run, JOBS))
report = {'checkout': str(ROOT), 'real_wechat_operations': False,
          'passed': all(item['exit_code'] == 0 for item in results) and before == inputs(),
          'inputs_unchanged': before == inputs(), 'source_inputs': before, 'checks': results}
(AUDIT / 'test-results.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
for item in results:
    print(f"{item['name']}: exit {item['exit_code']}; {item['result']}")
raise SystemExit(0 if report['passed'] else 1)
