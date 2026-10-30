#!/usr/bin/env python3
"""Read-only byte checks for the protected 2.1-26/27/28/29 production definitions."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent


def method_bytes(source, marker):
    """Return the exact definition bytes, ignoring braces in strings/comments."""
    start = source.index(marker)
    cursor = source.index(b'{', start)
    depth = 0
    state = None
    while cursor < len(source):
        value = source[cursor:cursor + 1]
        following = source[cursor:cursor + 2]
        if state in (b'"', b"'"):
            if value == b'\\':
                cursor += 2
                continue
            if value == state:
                state = None
        elif state == b'//':
            if value in (b'\n', b'\r'):
                state = None
        elif state == b'/*':
            if following == b'*/':
                state = None
                cursor += 2
                continue
        elif following in (b'//', b'/*'):
            state = following
            cursor += 2
            continue
        elif value in (b'"', b"'"):
            state = value
        elif value == b'{':
            depth += 1
        elif value == b'}':
            depth -= 1
            if depth == 0:
                return source[start:cursor + 1]
        cursor += 1
    raise ValueError('Unclosed protected method: ' + marker.decode())


def main():
    manifest = json.loads((AUDIT / 'source-guard-sha256.json').read_text())
    rows = []
    for item in manifest['methods']:
        frozen = (AUDIT / item['snapshot_file']).read_bytes()
        baseline_source = subprocess.check_output(
            ['git', 'show', manifest['baseline_commit'] + ':' + item['production_file']], cwd=ROOT)
        marker = item['marker'].encode()
        try:
            current = method_bytes((ROOT / item['production_file']).read_bytes(), marker)
            row = {
                'origin_version': item['origin_version'], 'marker': item['marker'],
                'snapshot_sha256_matches': hashlib.sha256(frozen).hexdigest() == item['sha256'],
                'snapshot_length_matches': len(frozen) == item['bytes'],
                'snapshot_matches_git_baseline_bytes': method_bytes(baseline_source, marker) == frozen,
                'production_matches_frozen_bytes': current == frozen,
                'current_sha256': hashlib.sha256(current).hexdigest(),
            }
            row['passed'] = all(row[key] for key in (
                'snapshot_sha256_matches', 'snapshot_length_matches',
                'snapshot_matches_git_baseline_bytes', 'production_matches_frozen_bytes'))
        except ValueError:
            row = {'marker': item['marker'], 'passed': False, 'error': 'Protected definition is missing or incomplete'}
        rows.append(row)
    changed = subprocess.check_output([
        'git', 'diff', 'HEAD', '--name-only', '--', 'Controllers', 'Hooks', 'Headers',
        'HeadersFile', 'layout', 'Makefile', 'control', 'WeChatImprove.plist'], cwd=ROOT, text=True).splitlines()
    result = {'baseline_commit': manifest['baseline_commit'], 'protected_methods': rows,
              'protected_count': len(rows), 'all_protected_methods_byte_identical': all(row['passed'] for row in rows),
              'production_files_different_from_current_HEAD': changed,
              'device_frames_measured': False, 'runtime_event_counts_collected': False}
    print(json.dumps(result, ensure_ascii=False, indent=2))
    if not result['all_protected_methods_byte_identical']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
