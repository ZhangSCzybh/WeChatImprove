#!/usr/bin/env python3
"""Build both schemes in fresh directories and preserve existing artifacts."""
from collections import Counter
import concurrent.futures
import hashlib
import json
from pathlib import Path
import re
import subprocess
import tempfile
import time

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
VERSION = '2.1-30'
MAX_WARNINGS = 6
WARNING_BASELINE_VERSION = '2.1-29'
WARNING_BASELINE_AUDIT = ROOT / 'docs/audits/release-2.1-29-top-chrome-return-flicker'
PACKAGES = ROOT / 'packages/2.1-30-miniapp-return-and-top-flicker'


def sha(path):
    with path.open('rb') as source:
        return hashlib.file_digest(source, 'sha256').hexdigest()


def input_hashes():
    paths = [p for folder in ('Controllers', 'Hooks', 'Headers', 'HeadersFile', 'layout')
             for p in (ROOT / folder).rglob('*') if p.is_file() and p.name != '.DS_Store']
    paths += [ROOT / name for name in ('Makefile', 'control', 'WeChatImprove.plist')]
    return {str(p.relative_to(ROOT)): sha(p) for p in sorted(paths) if p.is_file()}


def existing_artifacts():
    return {str(p.relative_to(ROOT)): sha(p)
            for folder in (ROOT / '.theos', ROOT / 'packages')
            for p in sorted(folder.rglob('*')) if p.is_file()}


def save(name, value):
    (AUDIT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def normalized_warnings(lines):
    ansi = re.compile(r'\x1b\[[0-?]*[ -/]*[@-~]')
    return Counter(ansi.sub('', line).strip() for line in lines)


def main():
    assert re.search(r'^Version: ' + re.escape(VERSION) + r'$', (ROOT / 'control').read_text(), re.M)
    assert '#define kPluginVersionString @"' + VERSION + '"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
    assert '@"' + VERSION + '": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text()
    if PACKAGES.exists() and list(PACKAGES.iterdir()):
        raise SystemExit('Delivery directory is not empty; preserve the existing delivery.')
    guard = json.loads(subprocess.check_output(['python3', '-B', str(AUDIT / 'verify-source-guards.py')], text=True))
    if guard['protected_count'] != 6 or not guard['all_protected_methods_byte_identical']:
        raise SystemExit('A protected 2.1-26/27/28/29 definition changed.')
    save('source-guard-prebuild-check.json', guard)
    task_start = json.loads((AUDIT / 'task-start-artifacts-sha256.json').read_text())
    if not all((ROOT / name).is_file() and sha(ROOT / name) == digest
               for name, digest in task_start.items()):
        raise SystemExit('A package/.theos file recorded at task start changed.')
    historical = json.loads((AUDIT / 'historical-packages-before.json').read_text())
    if not all((ROOT / name).is_file() and sha(ROOT / name) == digest
               for name, digest in historical.items()):
        raise SystemExit('A package recorded at task start changed; preserve the historical delivery.')
    preserved = existing_artifacts()
    before = input_hashes()
    save('preserved-artifacts-before.json', preserved)
    save('build-input-sha256.json', before)
    PACKAGES.mkdir(exist_ok=True)
    build_root = Path(tempfile.mkdtemp(prefix='wechat-miniapp-return-and-top-flicker-2.1-30-build-'))
    (AUDIT / 'build-directory.txt').write_text(str(build_root) + '\n')

    def build(scheme):
        output = build_root / scheme
        output.mkdir()
        command = ['make', 'package', '-j4', 'SCHEME=' + scheme, 'PACKAGE_VERSION=' + VERSION,
                   '_THEOS_LOCAL_DATA_DIR=' + str(output / '.theos'),
                   'THEOS_BUILD_DIR=' + str(output), 'THEOS_PACKAGE_DIR=' + str(PACKAGES)]
        started = time.monotonic()
        result = subprocess.run(command, cwd=ROOT, stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT, text=True)
        (AUDIT / ('build-' + scheme + '.log')).write_text(result.stdout)
        warnings = [line for line in result.stdout.splitlines() if 'warning:' in line]
        baseline_path = WARNING_BASELINE_AUDIT / ('build-' + scheme + '-result.json')
        frozen_warning_rows = json.loads((AUDIT / 'warning-baseline-2.1-29.json').read_text())['warnings']
        frozen_warning = next(row for row in frozen_warning_rows if row['scheme'] == scheme)
        if sha(baseline_path) != frozen_warning['sha256']:
            raise RuntimeError('Frozen 2.1-29 warning record changed: ' + scheme)
        baseline = json.loads(baseline_path.read_text())
        if baseline['warning_count'] != MAX_WARNINGS or baseline['exit_code'] != 0:
            raise RuntimeError('Unexpected 2.1-29 warning baseline: ' + scheme)
        baseline_warnings = normalized_warnings(baseline['warnings'])
        if dict(baseline_warnings) != frozen_warning['normalized_warnings']:
            raise RuntimeError('Frozen 2.1-29 warning multiset changed: ' + scheme)
        actual_warnings = normalized_warnings(warnings)
        row = {'scheme': scheme, 'command': command, 'exit_code': result.returncode,
               'duration_seconds': round(time.monotonic() - started, 3),
               'warning_count': len(warnings), 'warnings': warnings,
               'warning_limit': MAX_WARNINGS, 'warning_baseline_version': WARNING_BASELINE_VERSION,
               'warning_limit_satisfied': len(warnings) <= MAX_WARNINGS,
               'warning_baseline_record': str(baseline_path.relative_to(ROOT)),
               'warning_baseline_record_sha256': sha(baseline_path),
               'normalized_warnings': dict(actual_warnings),
               'normalized_baseline_warnings': dict(baseline_warnings),
               'warnings_match_baseline': actual_warnings == baseline_warnings}
        save('build-' + scheme + '-result.json', row)
        return row

    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
        rows = list(pool.map(build, ('rootless', 'rootful')))
    after = input_hashes()
    save('build-input-sha256-after.json', after)
    preservation = {'existing_file_count': len(preserved), 'missing': [], 'changed': []}
    for relative, digest in preserved.items():
        path = ROOT / relative
        if not path.is_file():
            preservation['missing'].append(relative)
        elif sha(path) != digest:
            preservation['changed'].append(relative)
    preservation['all_preserved'] = not (preservation['missing'] or preservation['changed'])
    save('preserved-artifacts-after.json', preservation)
    result = {'input_hashes_unchanged': before == after,
              'existing_artifacts_preserved': preservation['all_preserved'],
              'task_start_artifact_count': len(task_start),
              'protected_definitions_verified': guard['protected_count'],
              'warning_limit': MAX_WARNINGS, 'warning_baseline_version': WARNING_BASELINE_VERSION,
              'warning_limits_satisfied': all(row['warning_limit_satisfied'] for row in rows),
              'warning_multisets_match_baseline': all(row['warnings_match_baseline'] for row in rows),
              'builds': rows}
    save('build-result.json', result)
    print(json.dumps(result, ensure_ascii=False, indent=2))
    if (not result['input_hashes_unchanged'] or not preservation['all_preserved'] or
            not result['warning_limits_satisfied'] or not result['warning_multisets_match_baseline'] or
            any(row['exit_code'] for row in rows)):
        raise SystemExit(1)


if __name__ == '__main__':
    main()
