#!/usr/bin/env python3
"""Read-only checks for the final 2.2-12 package and protected checkout state."""
import hashlib
import json
from pathlib import Path
import subprocess

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def deleted(status):
    return sorted(row[3:] for row in status.split(b'\0')
                  if row[:2] in (b' D', b'D ', b'DD'))


def main():
    build = json.loads((AUDIT / 'delivery-build/build-result.json').read_text())
    inputs = json.loads((AUDIT / 'delivery-build/production-inputs.json').read_text())
    review = json.loads((AUDIT / 'review/reviewed-production-hashes.json').read_text())
    history = json.loads((AUDIT / 'delivery-build/historical-packages-before.json').read_text())
    baseline = json.loads((AUDIT / 'baseline.json').read_text())
    initial = (AUDIT / 'initial-status.z').read_bytes()
    current = subprocess.check_output(['git', 'status', '--porcelain=v1', '-z'], cwd=ROOT)
    checks = {
        'correct_version': build['version'] == '2.2-12',
        'both_schemes_built': len(build['builds']) == 2 and all(x['exit_code'] == 0 for x in build['builds']),
        'production_matches_frozen_build': all(sha(ROOT / name) == digest for name, digest in inputs['production_files'].items()),
        'review_matches_frozen_build': all(inputs['production_files'][name] == digest for name, digest in review['files'].items()),
        'artifacts_match_build': all(sha(ROOT / x['path']) == x['sha256'] for x in build['artifacts']),
        'historical_packages_preserved': all(sha(ROOT / name) == digest for name, digest in history.items()),
        'baseline_preserved': all(sha(AUDIT / 'baseline-2.2-11' / name) == digest for name, digest in baseline['sources'].items()),
        'initial_deletions_preserved': deleted(initial) == deleted(current),
        'root_tests_remains_absent': not (ROOT / 'Tests').exists(),
        'old_audit_manifest_preserved': sha(ROOT / 'docs/audits/session-groups-scroll-position-2026-11-03/evidence-manifest.json') == '9b93a5d9d9a4516709a60ad3fcd790e57f9223bef500e9fd518c7e5b46e0ab08',
        'both_architectures': all(set(x['architectures']) == {'arm64', 'arm64e'} for x in build['verified_packages']),
        'observation_absent': all(x['observation_markers_absent'] and x['signpost_import_absent'] for x in build['verified_packages']),
    }
    print(json.dumps({'checks': checks, 'initial_deleted_file_count': len(deleted(initial)),
                      'device_installed': False, 'passed': all(checks.values())}, ensure_ascii=False, indent=2))
    raise SystemExit(0 if all(checks.values()) else 1)


if __name__ == '__main__':
    main()
