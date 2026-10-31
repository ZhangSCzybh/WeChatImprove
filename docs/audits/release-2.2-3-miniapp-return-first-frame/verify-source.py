#!/usr/bin/env python3
"""Read-only source checks and scoped diff for the 2.2-3 release audit."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
BASELINE = 'faa294ff12ff17eab7336c0802693d968923154d'
FILES = [
    'Controllers/CSGroupListAdapter.h', 'Controllers/CSGroupListAdapter.m',
    'Controllers/CSReleaseNotesViewController.m', 'Headers/CSUserInfoHelper.h',
    'Hooks/SessionGroupHooks.xm', 'README.md', 'Tests/GroupSearchTests.m', 'control',
    'Tests/MiniappFirstFrameTests.m', 'Tests/verify-miniapp-first-frame.sh',
]


def run(*args):
    return subprocess.check_output(args, cwd=ROOT)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def block(text, marker, indented=False):
    start = text.index(marker)
    opening = text.index('{', start)
    depth = 0
    for end in range(opening, len(text)):
        if text[end] == '{':
            depth += 1
        elif text[end] == '}':
            depth -= 1
            if not depth:
                return text[start:end + 1]
    raise AssertionError(marker)


def main():
    current_head = run('git', 'rev-parse', 'HEAD').decode().strip()
    subprocess.run(['git', 'merge-base', '--is-ancestor', BASELINE, current_head], cwd=ROOT, check=True)
    adapter = 'Controllers/CSGroupListAdapter.m'
    old_text = run('git', 'show', BASELINE + ':' + adapter).decode()
    new_text = (ROOT / adapter).read_text()
    saved = json.loads((AUDIT / 'protected-blocks-before.json').read_text())
    comparisons = []
    for name in saved:
        marker = '    if (!ready) {' if name == 'ready-NO' else name
        old = block(old_text, marker)
        new = block(new_text, marker)
        assert old == saved[name]['text'] and digest(old.encode()) == saved[name]['sha256']
        comparisons.append({'definition': name, 'baseline_sha256': digest(old.encode()),
                            'current_sha256': digest(new.encode()), 'byte_identical': old == new})
    (AUDIT / 'protected-blocks-comparison.json').write_text(json.dumps(comparisons, indent=2) + '\n')
    assert all(row['byte_identical'] for row in comparisons)

    existing = [name for name in FILES if name not in FILES[-2:]]
    patch = run('git', 'diff', '--binary', BASELINE, '--', *existing)
    for name in FILES[-2:]:
        result = subprocess.run(['git', 'diff', '--no-index', '--', '/dev/null', name],
                                cwd=ROOT, stdout=subprocess.PIPE)
        assert result.returncode == 1
        patch += result.stdout
    (AUDIT / 'changes.patch').write_bytes(patch)
    inventory = []
    for name in FILES:
        current = (ROOT / name).read_bytes()
        if name in FILES[-2:]:
            before = None
            added, deleted = len(current.splitlines()), 0
        else:
            before = run('git', 'show', BASELINE + ':' + name)
            stat = run('git', 'diff', '--numstat', BASELINE, '--', name).decode().split('\t')
            added, deleted = int(stat[0]), int(stat[1])
        inventory.append({'file': name, 'added': added, 'deleted': deleted,
                          'baseline_sha256': digest(before) if before is not None else None,
                          'current_sha256': digest(current)})
    fixture = 'Tests/GroupSearchTests.m'
    assert (ROOT / fixture).read_bytes() == run('git', 'show', BASELINE + ':' + fixture).replace(
        b'#import <Foundation/Foundation.h>\n',
        b'#import <Foundation/Foundation.h>\n#import <objc/runtime.h>\n', 1)
    existing_tests = run('git', 'diff', '--name-only', BASELINE, '--', 'Tests').decode().splitlines()
    assert set(existing_tests) - set(FILES[-2:]) == {fixture}, existing_tests
    subprocess.run(['git', 'diff', '--check'], cwd=ROOT, check=True)
    result = {'baseline': BASELINE, 'current_head_at_inventory': current_head, 'files': inventory,
              'total_added': sum(row['added'] for row in inventory),
              'total_deleted': sum(row['deleted'] for row in inventory),
              'existing_test_assertions_changed': False,
              'existing_test_only_change': fixture + ': add objc/runtime.h import',
              'protected_definitions_byte_identical': True,
              'excluded_preexisting_changes': ['.DS_Store', 'packages/.DS_Store'],
              'scope_note': 'Audit files and pre-existing feedback assets are outside changes.patch. The shared checkout advanced to the recorded current HEAD during final verification; all source differences remain compared against faa294ff.'}
    (AUDIT / 'source-change-inventory.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
