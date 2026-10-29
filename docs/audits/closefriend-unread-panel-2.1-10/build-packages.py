#!/usr/bin/env python3
"""Build both delivery schemes without changing the existing .theos tree."""
import concurrent.futures
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
import time

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
PACKAGES = ROOT / 'packages/2.1-10-unread-panel'


def input_hashes():
    paths = [p for folder in ('Controllers', 'Hooks', 'Headers', 'HeadersFile', 'layout')
             for p in (ROOT / folder).rglob('*') if p.is_file() and p.name != '.DS_Store']
    paths += [ROOT / name for name in ('Makefile', 'control', 'WeChatImprove.plist')]
    return {str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in sorted(paths) if p.is_file()}


def main():
    PACKAGES.mkdir(exist_ok=True)
    if list(PACKAGES.glob('*.deb')):
        raise SystemExit('Delivery directory already contains packages; preserve them before a deliberate rebuild.')
    build_root = Path(tempfile.mkdtemp(prefix='wechat-unread-panel-2.1-10-build-'))
    (AUDIT / 'build-directory.txt').write_text(str(build_root) + '\n')
    before = input_hashes()
    (AUDIT / 'build-input-sha256.json').write_text(json.dumps(before, indent=2) + '\n')

    def build(scheme):
        output = build_root / scheme
        output.mkdir()
        command = ['make', 'package', '-j4', 'SCHEME=' + scheme, 'PACKAGE_VERSION=2.1-10',
                   '_THEOS_LOCAL_DATA_DIR=' + str(output / '.theos'),
                   'THEOS_BUILD_DIR=' + str(output), 'THEOS_PACKAGE_DIR=' + str(PACKAGES)]
        started = time.monotonic()
        result = subprocess.run(command, cwd=ROOT, stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT, text=True)
        (AUDIT / ('build-' + scheme + '.log')).write_text(result.stdout)
        warnings = [line for line in result.stdout.splitlines() if 'warning:' in line]
        row = {'scheme': scheme, 'command': command, 'exit_code': result.returncode,
               'duration_seconds': round(time.monotonic() - started, 3),
               'warning_count': len(warnings), 'warnings': warnings}
        (AUDIT / ('build-' + scheme + '-result.json')).write_text(json.dumps(row, indent=2) + '\n')
        return row

    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
        rows = list(pool.map(build, ('rootless', 'rootful')))
    unchanged = before == input_hashes()
    (AUDIT / 'build-result.json').write_text(json.dumps(
        {'input_hashes_unchanged': unchanged, 'builds': rows}, indent=2) + '\n')
    print(json.dumps({'input_hashes_unchanged': unchanged, 'builds': rows}, ensure_ascii=False, indent=2))
    if not unchanged or any(row['exit_code'] for row in rows):
        raise SystemExit(1)


if __name__ == '__main__':
    main()
