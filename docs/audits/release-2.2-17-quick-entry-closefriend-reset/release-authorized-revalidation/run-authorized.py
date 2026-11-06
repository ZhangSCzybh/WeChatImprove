#!/usr/bin/env python3
"""Re-run the unchanged release suites and exactly the 82 unwaived raw scripts."""
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
import hashlib
import json
import os
import subprocess
import tempfile
import threading
import time

HERE = Path(__file__).resolve().parent
AUDIT = HERE.parent
ROOT = AUDIT.parents[2]
STOP = threading.Event()


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def production():
    files = [ROOT / n for n in ('Makefile', 'control', 'WeChatImprove.plist')]
    files += [p for n in ('Controllers', 'Hooks', 'Headers', 'HeadersFile')
              for p in (ROOT / n).rglob('*') if p.is_file() and p.name != '.DS_Store']
    return {str(p.relative_to(ROOT)): sha(p) for p in sorted(files)}


def write(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def main():
    selection = json.loads((HERE / 'selection.json').read_text())
    fixtures = json.loads((HERE / 'fixture-before.json').read_text())
    assert all(sha(HERE / n) == h for n, h in fixtures.items()), 'Fixture provenance mismatch'
    original = json.loads((AUDIT / 'regression/fixture-provenance.json').read_text())['files']
    assert all(sha(HERE / 'fixture-project' / n) == h for n, h in original.items())
    before = production()
    before_digest = hashlib.sha256(json.dumps(before, sort_keys=True).encode()).hexdigest()
    write(HERE / 'production-before.json', before)
    tasks = [('rollback232', ['python3', str(HERE / 'rollback-validation/run-rollback.py')], ROOT),
             ('quick90', ['python3', str(HERE / 'quick-entry-validation/run_validation.py')], ROOT),
             ('compact1436', ['python3', str(HERE / 'prior-compact/run-native-contract.py'), '--phase', 'green'], ROOT)]
    tasks += [('prior-' + name, ['python3', str(HERE / ('prior-' + name) / script)], ROOT)
              for name, script in [('settings', 'run-validation.py'), ('tabbar', 'run-validation.py'),
                                   ('privacy', 'run_validation.py'), ('merge', 'run-validation.py')]]
    tasks += [(name, ['bash', str(HERE / 'fixture-project/Tests' / name)], HERE / 'fixture-project')
              for name in selection['selected_82']]
    assert len(tasks) == 89 and len(selection['waived_18']) == 18
    logs = HERE / 'runs'
    logs.mkdir()

    def run(task):
        name, command, cwd = task
        if STOP.is_set():
            return {'name': name, 'not_started_after_failure': True}
        started = time.monotonic()
        with tempfile.TemporaryDirectory(prefix='wci-2217-authorized-') as temporary:
            env = os.environ.copy()
            env['TMPDIR'] = temporary + '/'
            for var in ('CS_COMPAT_ENGINE_SOURCE', 'CS_COMPAT_TEST_SOURCE', 'CS_RESTORE_IMAGE_SOURCE'):
                env.pop(var, None)
            for var in ('_THEOS_LOCAL_DATA_DIR', 'THEOS_BUILD_DIR', 'THEOS_PACKAGE_DIR'):
                output = Path(temporary) / var
                output.mkdir()
                env[var] = str(output)
            for var in ('FIRST_FRAME_PROVENANCE_PATH', 'ADMISSION_PROVENANCE_PATH'):
                env[var] = str(logs / (name + '.' + var.lower() + '.json'))
            completed = subprocess.run(command, cwd=cwd, env=env, text=True,
                                       stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=600)
            (logs / (name + '.log')).write_text(completed.stdout)
            result = {'name': name, 'command': command, 'cwd': str(cwd), 'exit_code': completed.returncode,
                      'seconds': round(time.monotonic() - started, 3), 'log': str((logs / (name + '.log')).relative_to(HERE)),
                      'production_manifest_sha256': before_digest, 'temporary_data_root': temporary,
                      'temporary_theos_env': {k: env[k] for k in ('_THEOS_LOCAL_DATA_DIR', 'THEOS_BUILD_DIR', 'THEOS_PACKAGE_DIR')}}
            write(logs / (name + '.result.json'), result)
            print(name, completed.returncode, result['seconds'], flush=True)
            if completed.returncode:
                STOP.set()
                write(HERE / 'FAILED.json', result)
            return result

    results = []
    with ThreadPoolExecutor(max_workers=3) as pool:
        futures = [pool.submit(run, task) for task in tasks]
        for future in as_completed(futures):
            try:
                results.append(future.result())
            except Exception as error:
                STOP.set()
                write(HERE / 'FAILED.json', {'exception': repr(error)})
                raise
    after = production()
    preserved = all(sha(HERE / n) == h for n, h in fixtures.items())
    raw = [r for r in results if r['name'].startswith('verify-')]
    report = {'selected_raw_scripts': len(selection['selected_82']), 'waived_raw_scripts': selection['waived_18'],
              'raw_passed': sum(r.get('exit_code') == 0 for r in raw), 'raw_failed': sum(r.get('exit_code', 0) != 0 for r in raw),
              'modern_suite_count': 7, 'completed_tasks': sum('exit_code' in r for r in results),
              'all_selected_passed': all(r.get('exit_code') == 0 for r in results) and len(results) == 89,
              'production_bound_to_current_checkout': str(ROOT), 'production_file_count': len(before),
              'production_unchanged_during_revalidation': before == after, 'fixture_bytes_preserved': preserved,
              'old_evidence_overwritten': False, 'device_validated': False, 'runs': sorted(results, key=lambda r: r['name'])}
    write(HERE / 'production-after.json', after)
    write(HERE / 'result.json', report)
    print('SUMMARY', report['raw_passed'], report['raw_failed'], report['completed_tasks'],
          report['all_selected_passed'], report['production_unchanged_during_revalidation'], preserved, flush=True)
    assert report['all_selected_passed'] and before == after and preserved


if __name__ == '__main__':
    main()
