#!/usr/bin/env python3
"""Freeze/check the source manifest used by both isolated release builds."""
from pathlib import Path
import hashlib
import json
import sys

audit = Path(__file__).resolve().parent
root = audit.parents[2]
manifest = audit / 'build-input-sha256.json'
names = json.loads((audit / 'baseline-source-sha256.json').read_text())
paths = sorted(set(names) | {'Tests/CloseFriendTabBadgeTests.m'})
actual = {name: hashlib.sha256((root / name).read_bytes()).hexdigest() for name in paths}
if sys.argv[1:] == ['freeze']:
    assert not manifest.exists(), 'Refuse to overwrite frozen release inputs'
    manifest.write_text(json.dumps(actual, indent=2) + '\n')
    print(f'Frozen {len(actual)} release input files')
else:
    assert actual == json.loads(manifest.read_text()), 'Source changed after release inputs were frozen'
    warnings = {}
    for scheme in ('rootful', 'rootless'):
        result = json.loads((audit / f'build-{scheme}-result.json').read_text())
        assert result['exit_code'] == 0 and result['warning_count'] == 6, result
        lines = result['warnings']
        assert sum("'UILocalNotification' is deprecated" in line for line in lines) == 2
        assert sum("'statusBarFrame' is deprecated" in line for line in lines) == 2
        assert sum('-multiply_defined is obsolete' in line for line in lines) == 2
        warnings[scheme] = {'count': len(lines), 'lines': lines, 'new_warnings': 0}
    (audit / 'warnings.json').write_text(json.dumps(warnings, indent=2) + '\n')
    print(f'Both builds match all {len(actual)} frozen inputs; each has six historical warnings, zero new warnings')
