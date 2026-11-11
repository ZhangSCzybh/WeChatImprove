#!/usr/bin/env python3
"""Independently verify delivered welcome-fix files and preserved inputs."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import zipfile

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
spec = importlib.util.spec_from_file_location('welcome_release_builder', AUDIT / 'build.py')
builder = importlib.util.module_from_spec(spec)
spec.loader.exec_module(builder)
build = json.loads((AUDIT / 'build-result.json').read_text())
tests = json.loads((AUDIT / 'test-results.json').read_text())
delivery = Path(build['delivery_directory'])
assert build['status'] == 'passed' and tests['passed'] and tests['inputs_unchanged']
frozen = json.loads((Path(build['audit_directory']) / 'production-inputs.json').read_text())
production_matches = builder.production_manifest(ROOT) == frozen
test_sources_match = all(hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == digest
                         for name, digest in tests['source_inputs'].items())
assert production_matches and test_sources_match
baseline = json.loads(builder.BASELINE.read_text())
before = builder.substantive_protected(baseline)
after = builder.substantive_protected(builder.protected_manifest())
preserved = {name: before[name] == after[name] for name in before}
assert all(preserved.values())
artifacts = {}
for line in (delivery / 'SHA256SUMS').read_text().splitlines():
    digest, name = line.split('  ', 1)
    path = delivery / name
    actual = hashlib.sha256(path.read_bytes()).hexdigest()
    assert actual == digest == build['artifacts'][name]
    artifacts[name] = {'sha256': actual, 'bytes': path.stat().st_size}
assert set(artifacts) == set(build['artifacts'])
assert {path.name for path in delivery.iterdir()} == set(artifacts) | {'SHA256SUMS'}
for path in delivery.glob('*.deb'):
    version = subprocess.check_output(['dpkg-deb', '-f', str(path), 'Version'], text=True).strip()
    assert version == build['version']
    subprocess.run(['dpkg-deb', '--contents', str(path)], check=True, stdout=subprocess.DEVNULL)
for path in delivery.glob('*.zip'):
    with zipfile.ZipFile(path) as archive:
        assert archive.testzip() is None
report = {'passed': True, 'version': build['version'], 'checkout': str(ROOT),
          'delivery': str(delivery), 'production_sources_match_frozen_build': production_matches,
          'test_sources_match': test_sources_match, 'host_check_groups': len(tests['checks']),
          'real_wechat_operations': False, 'device_installed': False,
          'preservation': preserved,
          'preserved_content_files': {name: len(before[name]['files']) for name in before},
          'artifacts': artifacts}
(AUDIT / 'final-verification.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps(report, ensure_ascii=False, indent=2))
