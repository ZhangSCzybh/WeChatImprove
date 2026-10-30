#!/usr/bin/env python3
"""Account for every final difference from the verified 2.1-20 manifest."""
import difflib
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
MANIFEST = ROOT / 'docs/audits/release-2.1-20-scheduled-tasks/tested-source-sha256.json'
SNAPSHOT = Path((AUDIT / 'baseline-snapshot-directory.txt').read_text().strip())


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    manifest = json.loads(MANIFEST.read_text())
    restoration = json.loads((AUDIT / 'baseline-verification.json').read_text())
    assert restoration['matched'] == len(manifest) and not restoration['mismatches']
    backup = json.loads((AUDIT / 'backup/changed-files.json').read_text())
    allowed = {row['path'] for row in backup}
    allowed.update([
        'Controllers/CSGroupListAdapter.h', 'Controllers/CSGroupListAdapter.m',
        'Hooks/SessionGroupHooks.xm', 'Tests/GroupRefreshFixture.h',
        'Tests/GroupSearchTests.m', 'Tests/MiniappPrivateLayoutTests.m',
        'Tests/verify-miniapp-private-layout.sh', 'control',
        'Headers/CSUserInfoHelper.h', 'Controllers/CSReleaseNotesViewController.m',
        'README.md', 'docs/features/scheduled-tasks-and-image-stickers.md',
    ])
    changes = []
    untouched = 0
    for name, expected in manifest.items():
        path = ROOT / name
        actual = sha(path.read_bytes()) if path.is_file() else None
        if actual == expected:
            untouched += 1
        else:
            changes.append({'path': name, 'action': 'modified' if actual else 'deleted',
                            'baseline_sha256': expected, 'current_sha256': actual})
    extras = []
    for folder in ('Controllers', 'Hooks', 'Headers', 'HeadersFile', 'Tests'):
        for path in (ROOT / folder).rglob('*'):
            if (not path.is_file() or path.name == '.DS_Store'
                    or '__pycache__' in path.parts):
                continue
            name = str(path.relative_to(ROOT))
            if name not in manifest:
                extras.append(name)
                changes.append({'path': name, 'action': 'added',
                                'baseline_sha256': None, 'current_sha256': sha(path.read_bytes())})
    document_baselines = {
        'README.md': Path('/tmp/wechat-221-baseline-README.md'),
        'docs/features/scheduled-tasks-and-image-stickers.md': Path('/tmp/wechat-221-baseline-docs__features__scheduled-tasks-and-image-stickers.md'),
        'docs/backup-guide.md': Path('/tmp/wechat-221-baseline-docs__backup-guide.md'),
    }
    for name, old in document_baselines.items():
        before, after = sha(old.read_bytes()), sha((ROOT / name).read_bytes())
        if before != after:
            changes.append({'path': name, 'action': 'modified',
                            'baseline_sha256': before, 'current_sha256': after})
    name = 'docs/backup-configuration-registry.md'
    registry_before = subprocess.check_output(['git', 'show', 'd15acffe:' + name], cwd=ROOT)
    if sha(registry_before) != sha((ROOT / name).read_bytes()):
        changes.append({'path': name, 'action': 'modified',
                        'baseline_sha256': sha(registry_before),
                        'current_sha256': sha((ROOT / name).read_bytes())})
    unexpected = [row['path'] for row in changes if row['path'] not in allowed]
    assert not unexpected, unexpected
    assert set(extras) == {
        'Tests/BackupManualManagementTests.m', 'Tests/verify-backup-manual-management.sh',
        'Tests/MiniappPrivateLayoutTests.m', 'Tests/verify-miniapp-private-layout.sh',
    }, extras
    patch = []
    for row in sorted(changes, key=lambda item: item['path']):
        name = row['path']
        if name in document_baselines:
            before = document_baselines[name].read_bytes()
        elif name == 'docs/backup-configuration-registry.md':
            before = registry_before
        elif name in manifest:
            before = (SNAPSHOT / name).read_bytes()
            assert sha(before) == manifest[name]
        else:
            before = b''
        after = (ROOT / name).read_bytes() if (ROOT / name).is_file() else b''
        patch.extend(difflib.unified_diff(
            before.decode().splitlines(keepends=True), after.decode().splitlines(keepends=True),
            fromfile='a/' + name if before else '/dev/null',
            tofile='b/' + name if after else '/dev/null'))
    (AUDIT / 'changes.patch').write_text(''.join(patch))
    (AUDIT / 'final-changed-files.json').write_text(json.dumps(changes, ensure_ascii=False, indent=2) + '\n')
    prior_audit_differences = subprocess.check_output(
        ['git', 'diff', '--name-only', 'HEAD', '--', 'docs/audits/'], cwd=ROOT).decode().splitlines()
    assert not prior_audit_differences, prior_audit_differences
    result = {'baseline_manifest_entries': len(manifest), 'baseline_stage_all_matched': True,
              'final_unchanged_manifest_entries': untouched,
              'final_changed_or_deleted_manifest_entries': len(manifest) - untouched,
              'final_added_source_tests': sorted(extras), 'final_change_count_including_docs': len(changes),
              'unexpected_differences': unexpected, 'prior_audit_differences': prior_audit_differences,
              'all_final_changes_limited_to_two_requested_fixes_and_release_metadata': True}
    (AUDIT / 'final-scope-verification.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
