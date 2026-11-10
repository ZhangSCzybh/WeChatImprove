#!/usr/bin/env python3
"""Bind focused regression and package checks to the current production source."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import re
import subprocess

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]


def sha(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def load(name):
    return json.loads((AUDIT / name).read_text())


inputs = load('production-inputs.json')
assert all(sha(ROOT / path) == digest for path, digest in inputs.items())
build = load('build-result.json')
assert build['version'] == '2.3-9'
assert build['sources_unchanged_during_build'] and build['previous_packages_preserved']
assert all(item['exit_code'] == 0 for item in build['builds'])
provenance = load('tests/history-regression-provenance.json')
adapter = sha(ROOT / 'Controllers/CSMessageMergeAdapter.m')
assert adapter == provenance['greenAdapterSha256'] == provenance['finalJointSameAdapterSha256']
assert adapter == inputs['Controllers/CSMessageMergeAdapter.m']
assert sha(ROOT / 'Tests/MessageMergeAdapterTests.m') == provenance['fixtureSha256']
assert sha(ROOT / 'Tests/MergeBubbleIntegrationTests.m') == provenance['jointFixtureSha256']
assert sha(AUDIT / 'tests/CSMessageMergeAdapter-2.3-8-red.m') == provenance['redAdapterSha256']
assert sha(AUDIT / 'tests/history-2.3-8-compatibility-shim.m') == provenance['compatibilityShimSha256']
core = (AUDIT / 'tests/final-merge.log').read_text()
joint = (AUDIT / 'tests/final-integration.log').read_text()
assert 'PASS: 235148' in core and 'PASS: 41190' in core
assert 'PASS: 2880' in joint and '1392136 checks' in joint
joint_result = load('tests/final-integration-results.json')
assert joint_result['exitCode'] == 0
assert joint_result['adapterSha256Before'] == adapter == joint_result['adapterSha256After']

verified = {}
for version, folder in [('2.3-7', '2.3-7-merge-nickname-scroll'),
                        ('2.3-8', '2.3-8-merge-first-seam'),
                        ('2.3-9', '2.3-9-merge-history-scroll')]:
    base = ROOT / 'packages' / folder
    files = {}
    for line in (base / 'SHA256SUMS').read_text().splitlines():
        digest, name = line.split(None, 1)
        path = base / name.strip().removeprefix('*')
        assert path.is_file() and sha(path) == digest, str(path)
        files[path.name] = digest
    verified[version] = files
assert verified['2.3-9'] == build['artifacts']
diff = subprocess.run(['git', 'diff', '--check'], cwd=ROOT, capture_output=True, text=True)
assert diff.returncode == 0, diff.stdout + diff.stderr

report = {
    'timestamp': datetime.now(timezone.utc).isoformat(),
    'checkout': str(ROOT), 'version': '2.3-9',
    'production_manifest_matches_current_checkout': True,
    'test_and_build_adapter_sha256': adapter,
    'core': {'policy': 235148, 'adapter': 41190, 'pass': True,
             'log_sha256': sha(AUDIT / 'tests/final-merge.log')},
    'joint': {'combinations': 2880, 'checks': 1392136, 'pass': True,
              'log_sha256': sha(AUDIT / 'tests/final-integration.log')},
    'semantic_red': {'old_adapter_build_succeeded': True, 'history_anchor_drift_pt': -90,
                     'reload_extra_transactions': 1, 'reload_extra_offset_writes': 1,
                     'values_are_synthetic': True},
    'media': {
        'source': '/Users/zhangshichao/Downloads/ScreenRecording_11-10-2026 11-48-46_1.MOV',
        'inspected': ['media/contact-5fps.jpg', 'media/detail-1.4-2.0s-20fps.jpg'],
        'visual_observation': 'Same separator/avatar and neighboring bubbles briefly reverse then continue; exact callback timing cannot be inferred from video.'},
    'build_result_sha256': sha(AUDIT / 'build-result.json'),
    'checksums_verified': verified, 'previous_packages_preserved_during_build': True,
    'git_diff_check_passed': True, 'device_installed': False,
    'services_started_or_switched': False, 'chat_database_modified': False,
    'limits': 'Host synthetic regression and static native evidence; iPhone WeChat touch momentum, boundary clamping and repeated history loads require device acceptance.'
}
(AUDIT / 'final-verification.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
for document in [AUDIT / 'README.md', ROOT / 'README.md']:
    for target in re.findall(r'\]\(([^)]+)\)', document.read_text()):
        if target.startswith(('http', '#')):
            continue
        assert (document.parent / target.split('#', 1)[0]).exists(), (str(document), target)
print(json.dumps({'version': report['version'], 'adapter_sha256': adapter,
                  'source_files': len(inputs), 'checksum_versions': list(verified),
                  'all_checks_passed': True}, ensure_ascii=False, indent=2))
