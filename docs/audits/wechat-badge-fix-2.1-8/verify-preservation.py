#!/usr/bin/env python3
"""Compare this release with the captured 2.1-6 source and artifact baseline."""
from pathlib import Path
import difflib
import hashlib
import json

audit = Path(__file__).resolve().parent
root = audit.parents[2]
digest = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
baseline = json.loads((audit / 'baseline-source-sha256.json').read_text())
allowed = {
    'Controllers/CSGroupListAdapter.h', 'Controllers/CSGroupListAdapter.m',
    'Hooks/CloseFriendNotificationHooks.xm', 'Headers/CSUserInfoHelper.h', 'control',
    'Tests/verify-close-friend-alerts.sh', 'Tests/GroupLifecycleTests.m',
    'Tests/extract-group-lifecycle.py',
}
rows, changed, after = [], [], {}
patch = []
production_patch = []
for name, before_hash in sorted(baseline.items()):
    path = root / name
    after_hash = digest(path) if path.is_file() else None
    after[name] = after_hash
    status = 'unchanged' if before_hash == after_hash else 'changed'
    rows.append((name, status, before_hash, after_hash or 'MISSING'))
    if status == 'changed':
        assert name in allowed, ('Unexpected baseline change', name)
        snapshot = audit / 'baseline' / name
        assert digest(snapshot) == before_hash, ('Invalid baseline snapshot', name)
        changed.append(name)
        delta = list(difflib.unified_diff(snapshot.read_text().splitlines(True),
            path.read_text().splitlines(True), fromfile='a/' + name, tofile='b/' + name))
        patch.extend(delta)
        if not name.startswith('Tests/'):
            production_patch.extend(delta)
new_test = 'Tests/CloseFriendTabBadgeTests.m'
assert (root / new_test).is_file()
new_source_files = set()
for directory in ('Controllers', 'Headers', 'Hooks', 'Tests'):
    for path in (root / directory).rglob('*'):
        if path.is_file() and path.suffix in {'.h', '.m', '.xm', '.py', '.sh', '.c'}:
            name = str(path.relative_to(root))
            if name not in baseline:
                new_source_files.add(name)
assert new_source_files == {new_test}, ('Unexpected source additions', new_source_files)
after[new_test] = digest(root / new_test)
patch.extend(difflib.unified_diff([], (root / new_test).read_text().splitlines(True),
    fromfile='/dev/null', tofile='b/' + new_test))
(audit / 'source-comparison.tsv').write_text('file\tstatus\t2.1-6-sha256\t2.1-8-sha256\n' +
    ''.join('\t'.join(row) + '\n' for row in rows))
(audit / 'source-sha256-after.json').write_text(json.dumps(after, indent=2) + '\n')
(audit / 'release.patch').write_text(''.join(patch))
(audit / 'production.patch').write_text(''.join(production_patch))

historical = json.loads((audit / 'historical-artifacts-before.json').read_text())
artifact_rows = []
for name, before_hash in sorted(historical.items()):
    path = root / name
    after_hash = digest(path) if path.is_file() else None
    assert after_hash == before_hash, ('Historical artifact changed', name)
    artifact_rows.append((name, before_hash, after_hash))
(audit / 'historical-artifacts-comparison.tsv').write_text('file\tbefore-sha256\tafter-sha256\n' +
    ''.join('\t'.join(row) + '\n' for row in artifact_rows))

def block(source, marker):
    start = source.index(marker)
    opening = source.index('{', start)
    depth = 0
    for end in range(opening, len(source)):
        if source[end] == '{':
            depth += 1
        elif source[end] == '}':
            depth -= 1
            if not depth:
                return source[start:end+1]
    raise AssertionError(marker)

old_adapter = (audit / 'baseline/Controllers/CSGroupListAdapter.m').read_text()
new_adapter = (root / 'Controllers/CSGroupListAdapter.m').read_text()
old_hooks = (audit / 'baseline/Hooks/CloseFriendNotificationHooks.xm').read_text()
new_hooks = (root / 'Hooks/CloseFriendNotificationHooks.xm').read_text()
preserved = {}
for label, old, new, marker in (
    ('legacy_notification_badge_getter', old_adapter, new_adapter, '+ (NSNumber *)closeFriendAlertBadgeCount'),
    ('ChatTab', old_hooks, new_hooks, 'static BOOL ChatTab('),
):
    original = block(old, marker)
    assert original == block(new, marker), ('Protected behavior changed', label)
    preserved[label] = hashlib.sha256(original.encode()).hexdigest()
old_ctor = old_hooks[old_hooks.index('%ctor'):old_hooks.index('    __block IMP tab=NULL;')]
new_ctor = new_hooks[new_hooks.index('%ctor'):new_hooks.index('    __block IMP tab=NULL;')]
assert old_ctor == new_ctor
preserved['all_non_tab_hook_installations'] = hashlib.sha256(old_ctor.encode()).hexdigest()
observer = '    [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification'
old_prefix = old_hooks[old_hooks.index(observer):old_hooks.index('        if(value)for(id owner in TabOwners.allObjects)')]
new_prefix = new_hooks[new_hooks.index(observer):new_hooks.index('        CSPublishChatTabBadges();', new_hooks.index(observer))]
assert old_prefix == new_prefix
preserved['policy_observer_notification_and_app_icon_prefix'] = hashlib.sha256(old_prefix.encode()).hexdigest()
result = {
    'passed': True, 'baseline_files': len(baseline), 'unchanged': len(baseline)-len(changed),
    'changed': changed, 'added_tests': [new_test], 'historical_artifacts_matching': len(historical),
    'protected_code_sha256': preserved, 'version': '2.1-8',
}
assert 'Version: 2.1-8\n' in (root / 'control').read_text()
assert '#define kPluginVersionString @"2.1-8"' in (root / 'Headers/CSUserInfoHelper.h').read_text()
(audit / 'preservation-result.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
