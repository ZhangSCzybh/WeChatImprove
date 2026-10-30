#!/usr/bin/env python3
"""Build both schemes in fresh directories and preserve existing artifacts."""
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
VERSION = '2.1-20'
MAX_WARNINGS = 6
WARNING_BASELINE_VERSION = '2.1-17'
PACKAGES = ROOT / 'packages/2.1-20-scheduled-tasks'


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


def main():
    assert re.search(r'^Version: ' + re.escape(VERSION) + r'$', (ROOT / 'control').read_text(), re.M)
    assert '#define kPluginVersionString @"' + VERSION + '"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
    assert '@"' + VERSION + '": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text()
    if PACKAGES.exists() and list(PACKAGES.iterdir()):
        raise SystemExit('Delivery directory is not empty; preserve the existing delivery.')
    preserved = existing_artifacts()
    before = input_hashes()
    save('preserved-artifacts-before.json', preserved)
    save('build-input-sha256.json', before)
    PACKAGES.mkdir(exist_ok=True)
    build_root = Path(tempfile.mkdtemp(prefix='wechat-ai-background-2.1-20-scheduled-tasks-build-'))
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
        row = {'scheme': scheme, 'command': command, 'exit_code': result.returncode,
               'duration_seconds': round(time.monotonic() - started, 3),
               'warning_count': len(warnings), 'warnings': warnings,
               'warning_limit': MAX_WARNINGS, 'warning_baseline_version': WARNING_BASELINE_VERSION,
               'warning_limit_satisfied': len(warnings) <= MAX_WARNINGS}
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
              'warning_limit': MAX_WARNINGS, 'warning_baseline_version': WARNING_BASELINE_VERSION,
              'warning_limits_satisfied': all(row['warning_limit_satisfied'] for row in rows),
              'builds': rows}
    save('build-result.json', result)
    print(json.dumps(result, ensure_ascii=False, indent=2))
    if (not result['input_hashes_unchanged'] or not preservation['all_preserved'] or
            not result['warning_limits_satisfied'] or any(row['exit_code'] for row in rows)):
        raise SystemExit(1)


if __name__ == '__main__':
    main()
