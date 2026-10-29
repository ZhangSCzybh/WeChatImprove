#!/usr/bin/env python3
"""Read-only verification of restored source and preserved release artifacts."""
from pathlib import Path
import datetime
import hashlib
import json
import re

audit = Path(__file__).resolve().parent
root = audit.parents[2]
digest = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
baseline = json.loads((root / 'docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json').read_text())
source = {}
for name, expected in baseline.items():
    path = root / name
    assert path.is_file() and digest(path) == expected, name
    source[name] = expected
extras = []
for folder in ('Controllers', 'Headers', 'Hooks', 'Tests'):
    for path in (root / folder).rglob('*'):
        if path.is_file() and path.suffix in {'.h', '.m', '.xm', '.py', '.sh', '.c'}:
            name = str(path.relative_to(root))
            if name not in baseline:
                extras.append(name)
assert not extras, extras
versions = {
    'control': re.search(r'^Version: (.+)$', (root / 'control').read_text(), re.M).group(1),
    'plugin': re.search(r'#define kPluginVersionString @"([^"]+)"', (root / 'Headers/CSUserInfoHelper.h').read_text()).group(1),
}
assert set(versions.values()) == {'2.1-6'}
artifacts = json.loads((audit / 'historical-artifacts-before.json').read_text())
rows = []
for name, expected in sorted(artifacts.items()):
    path = root / name
    actual = digest(path) if path.is_file() else None
    assert expected == actual, ('Changed historical artifact', name)
    rows.append((name, expected, actual))
actual_names = {
    str(path.relative_to(root))
    for folder in ('.theos', 'packages') for path in (root / folder).rglob('*') if path.is_file()
}
assert actual_names == set(artifacts), 'Artifact inventory changed'
(audit / 'historical-artifacts-comparison.tsv').write_text('file\tbefore-sha256\tafter-sha256\n' +
    ''.join('\t'.join(row) + '\n' for row in rows))
build = json.loads((audit / 'build-result.json').read_text())
assert build['exit_code'] == 0 and build['warning_count'] <= 6
regressions = {}
for script in ('verify-close-friend-alerts.sh', 'verify-group-lifecycle.sh'):
    result = json.loads((audit / (script + '.json')).read_text())
    assert result['exit_code'] == 0, result
    regressions[script] = result
result = {
    'passed': True, 'verified_at': datetime.datetime.now(datetime.timezone.utc).isoformat(),
    'source_authority': 'docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json',
    'source_count': len(source), 'matching_source_count': len(source), 'extra_source_files': extras,
    'versions': versions, 'historical_artifacts_preserved': len(rows),
    'historical_package_files': sum(name.startswith('packages/') for name in artifacts),
    'historical_deb_files': sum(name.startswith('packages/') and name.endswith('.deb') for name in artifacts),
    'build_exit': build['exit_code'], 'build_warning_count': build['warning_count'],
    'regressions': regressions, 'package_generated': False, 'device_changed': False,
}
(audit / 'final-result.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
print(json.dumps(result, ensure_ascii=False, indent=2))
