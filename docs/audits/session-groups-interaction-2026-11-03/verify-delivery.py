#!/usr/bin/env python3
"""Verify frozen builds, probe separation and preservation of existing evidence."""
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def command(args):
    return subprocess.check_output(args, text=True, stderr=subprocess.STDOUT)


def main():
    # The initial snapshot includes tracked changes only; preserve every prior deletion.
    initial_status = (AUDIT / 'initial-git-status.z').read_bytes()
    current_status = subprocess.check_output(
        ['git', 'status', '--porcelain=v1', '-z', '--untracked-files=no'], cwd=ROOT)
    deleted = lambda data: {row[3:] for row in data.split(b'\0') if b'D' in row[:2]}
    previous_deletions, current_deletions = deleted(initial_status), deleted(current_status)
    assert previous_deletions == current_deletions
    assert not (ROOT / 'Tests').exists()
    baseline = read(AUDIT / 'baseline-source-sha256.json')
    assert all(sha(AUDIT / 'baseline-2.2-8' / name) == digest for name, digest in baseline.items())

    old_audit = ROOT / 'docs/audits/session-groups-instruments-2026-11-03'
    old_manifest = read(old_audit / 'evidence-manifest.json')
    assert all(sha(old_audit / item['path']) == item['sha256'] for item in old_manifest['files'])

    packages = []
    source_sets = []
    observation_source_changes = None
    with tempfile.TemporaryDirectory(prefix='wechat-groups-delivery-check-') as temporary:
        for variant in ('normal', 'observation'):
            folder = AUDIT / 'builds' / 'final' / variant
            build = read(folder / 'build-result.json')
            assert all(item['exit_code'] == 0 for item in build['builds'])
            assert build['inputs_unchanged'] and build['historical_packages_preserved']
            before = read(folder / 'production-inputs.json')['production_files']
            assert all(sha(ROOT / name) == digest for name, digest in before.items())
            source_sets.append(before)
            effective = read(folder / 'effective-inputs.json')['production_files']
            differences = sorted(name for name in before if before[name] != effective[name])
            if variant == 'normal':
                assert not differences
            else:
                assert differences == ['Controllers/CSReleaseNotesViewController.m', 'Headers/CSUserInfoHelper.h', 'control']
                observation_source_changes = differences
            history = read(folder / 'historical-packages-before.json')
            assert all(sha(ROOT / name) == digest for name, digest in history.items())
            for artifact in build['artifacts']:
                assert sha(ROOT / artifact['path']) == artifact['sha256']
                if not artifact['path'].endswith('.deb'):
                    continue
                target = Path(temporary) / variant / Path(artifact['path']).name
                target.mkdir(parents=True)
                subprocess.run(['dpkg-deb', '-x', str(ROOT / artifact['path']), str(target)], check=True)
                dylibs = list(target.rglob('WeChatImprove.dylib'))
                assert len(dylibs) == 1
                dylib = dylibs[0]
                slices = {}
                for arch in ('arm64', 'arm64e'):
                    thin = target / (arch + '.dylib')
                    subprocess.run(['xcrun', 'lipo', str(dylib), '-thin', arch, '-output', str(thin)], check=True)
                    strings = command(['strings', str(thin)])
                    symbols = command(['xcrun', 'nm', str(thin)])
                    observed = variant == 'observation'
                    for marker in ('com.wechatimprove.performance', 'ModelFull', 'ModelDelta',
                                   'ModelSelection', 'AdapterPublication', 'ReloadDispatchUnverified'):
                        assert (marker in strings) == observed, (variant, arch, marker)
                    assert ('_CSGroupPerformanceBegin' in symbols) == observed
                    assert ('_os_signpost_emit_with_name_impl' in symbols) == observed
                    assert 'modelBySelectingTabID:fromResult:foldedRows:' in strings
                    assert 'refreshInteractionIsBlocking' in strings
                    slices[arch] = {'probe_symbols_match': True, 'probe_markers_match': True,
                                    'new_optimization_methods_present': True}
                packages.append({'path': artifact['path'], 'sha256': artifact['sha256'],
                                 'observation': variant == 'observation', 'slices': slices})
    assert source_sets[0] == source_sets[1]
    result = {
        'checkout': str(ROOT), 'device_installed': False,
        'previous_tracked_deletions_preserved': len(previous_deletions),
        'root_tests_remain_deleted': True, 'frozen_baseline_files_verified': len(baseline),
        'prior_instruments_files_preserved': len(old_manifest['files']),
        'historical_packages_preserved': True, 'build_source_matches_current_production': True,
        'same_source_for_both_variants': True,
        'observation_version_only_snapshot_transformations': observation_source_changes,
        'verified_packages': packages,
    }
    (AUDIT / 'delivery-integrity.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
