#!/usr/bin/env python3
"""Independently tie final tests, original red inputs and delivery to their hashes."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
BASELINE = 'faa294ff12ff17eab7336c0802693d968923154d'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(name):
    return json.loads((AUDIT / name).read_text())


def main():
    regression = read('regression-results.json')
    first = read('miniapp-first-frame-results.json')
    build = read('build-result.json')
    packages = read('package-verification.json')
    for manifest in (read('build-input-sha256.json'), regression['source_sha256'],
                     first['green']['provenance']['source_sha256'], first['test_inputs_sha256']):
        assert all(sha(ROOT / name) == value for name, value in manifest.items())
    for name, value in first['red']['provenance']['source_sha256'].items():
        old = subprocess.check_output(['git', 'show', BASELINE + ':' + name], cwd=ROOT)
        assert hashlib.sha256(old).hexdigest() == value
    assert all(sha(ROOT / row['log']) == row['log_sha256'] and row['exit_code'] == 0 and
               row['failures'] == 0 for row in regression['suites'])
    assert regression['total_checks'] == 2928 and regression['total_failures'] == 0
    assert first['green']['checks'] == 56 and first['green']['failures'] == 0
    assert all(row['exit_code'] == 0 and row['warning_count'] == 6 and row['warning_multiset_equal']
               for row in build['builds'])
    destination = ROOT / 'packages/2.2-3-miniapp-return-first-frame'
    assert all(sha(destination / row['file']) == row['sha256'] for row in packages['artifacts'])
    old_log = ROOT / 'docs/audits/release-2.2-2-privacy-admission-cache/admission-green.log'
    old_stable = [json.loads(line.split('ADMISSION ', 1)[1]) for line in old_log.read_text().splitlines()
                  if line.startswith('ADMISSION ') and 'stable-K25-N32' in line][-1]
    stable = regression['stable_admission_K25_N32']
    assert old_stable == stable
    historical = read('historical-artifacts-before.json')
    missing = [name for name in historical if not (ROOT / name).is_file()]
    changed = [name for name, value in historical.items()
               if (ROOT / name).is_file() and sha(ROOT / name) != value]
    assert not (missing or changed)
    checked = subprocess.run(['shasum', '-a', '256', '-c', 'SHA256SUMS'], cwd=destination,
                             text=True, capture_output=True)
    assert checked.returncode == 0 and checked.stdout.count(': OK') == 3
    (AUDIT / 'shasum-independent-check.log').write_text(checked.stdout)
    result = {'baseline': BASELINE,
              'current_head_at_final_verification': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
              'source_matches_final_green_and_build': True,
              'original_red_source_matches_git': True, 'current_tests_match_red_green_record': True,
              'regression_log_hashes_verified': True, 'green_checks': 2984, 'green_failures': 0,
              'red_checks': 56, 'red_failures': 23,
              'stable_admission_baseline_log': str(old_log.relative_to(ROOT)),
              'stable_admission_before': old_stable, 'stable_admission_after': stable,
              'historic_files_verified': len(historical), 'historic_missing': missing,
              'historic_changed': changed, 'packages_match_recorded_sha256': True,
              'independent_shasum_output': checked.stdout, 'device_verified': False}
    (AUDIT / 'independent-final-verification.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
