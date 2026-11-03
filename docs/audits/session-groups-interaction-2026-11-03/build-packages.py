#!/usr/bin/env python3
"""Build the current checkout in a frozen copy; preserve existing packages."""
from concurrent.futures import ThreadPoolExecutor
import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import time
import zipfile

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
DELIVERY = ROOT / 'packages/2.2-9-session-groups-interaction'
EVIDENCE = AUDIT


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inputs(root):
    files = [root / name for name in ('Makefile', 'control', 'WeChatImprove.plist')]
    files += [p for name in ('Controllers', 'Hooks', 'Headers', 'HeadersFile')
              for p in (root / name).rglob('*') if p.is_file() and p.name != '.DS_Store']
    tree = hashlib.sha256()
    details = {}
    for path in sorted(files):
        relative = str(path.relative_to(root))
        digest = sha(path)
        tree.update((relative + '\0' + digest + '\n').encode())
        if not relative.startswith('HeadersFile/'):
            details[relative] = digest
    return {'tree_sha256': tree.hexdigest(), 'file_count': len(files), 'production_files': details}


def save(name, value):
    (EVIDENCE / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def output(command):
    return subprocess.check_output(command, text=True, stderr=subprocess.STDOUT).strip()


def main():
    global DELIVERY, EVIDENCE
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--observation', action='store_true',
                        help='Build a separately labelled +observe package with native signposts.')
    parser.add_argument('--delivery-name', default=DELIVERY.name,
                        help='New directory name under packages; existing outputs are never replaced.')
    parser.add_argument('--evidence-subdir', default='.',
                        help='New evidence directory relative to this audit.')
    args = parser.parse_args()
    if Path(args.delivery_name).name != args.delivery_name:
        raise SystemExit('delivery-name must be a single directory name.')
    if args.observation and args.delivery_name == DELIVERY.name:
        args.delivery_name += '-observe'
    DELIVERY = ROOT / 'packages' / args.delivery_name
    EVIDENCE = (AUDIT / args.evidence_subdir).resolve()
    if not EVIDENCE.is_relative_to(AUDIT):
        raise SystemExit('Evidence must remain under this audit directory.')
    if DELIVERY.exists():
        raise SystemExit('Delivery already exists; preserve it and select a new output path explicitly.')
    EVIDENCE.mkdir(parents=True, exist_ok=True)
    if (EVIDENCE / 'build-result.json').exists():
        raise SystemExit('Build evidence already exists; select a new evidence directory explicitly.')
    version = re.search(r'^Version: (.+)$', (ROOT / 'control').read_text(), re.M).group(1)
    display_version = re.search(r'#define kPluginVersionString @"([^"]+)"', (ROOT / 'Headers/CSUserInfoHelper.h').read_text()).group(1)
    assert display_version == version, 'Package/display version mismatch.'
    assert '@"' + version + '": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text(), 'Missing matching release notes.'
    source_version = version
    observation = int(args.observation)
    if observation:
        version += '+observe'
    before = inputs(ROOT)
    history = {str(p.relative_to(ROOT)): sha(p) for p in (ROOT / 'packages').rglob('*')
               if p.is_file() and p.suffix in ('.deb', '.zip')}
    temporary = Path(tempfile.mkdtemp(prefix='wechat-groups-interaction-20261103-'))
    snapshot = temporary / 'source'
    snapshot.mkdir()
    for name in ('Controllers', 'Hooks', 'Headers', 'HeadersFile'):
        shutil.copytree(ROOT / name, snapshot / name, symlinks=True)
    for name in ('Makefile', 'control', 'WeChatImprove.plist'):
        shutil.copy2(ROOT / name, snapshot / name)
    assert inputs(snapshot) == before, 'Freeze did not preserve inputs.'
    if observation:
        replacements = {
            'control': ('Version: ' + source_version + '\n', 'Version: ' + version + '\n'),
            'Headers/CSUserInfoHelper.h': ('#define kPluginVersionString @"' + source_version + '"', '#define kPluginVersionString @"' + version + '"'),
            'Controllers/CSReleaseNotesViewController.m': ('@"' + source_version + '": @[', '@"' + version + '": @['),
        }
        for name, (original, replacement) in replacements.items():
            path = snapshot / name
            contents = path.read_text()
            assert contents.count(original) == 1, name
            path.write_text(contents.replace(original, replacement))
    save('production-inputs.json', before)
    save('effective-inputs.json', inputs(snapshot))
    save('historical-packages-before.json', history)

    def build(scheme):
        target = temporary / scheme
        target.mkdir()
        command = ['make', 'package', '-j4', 'SCHEME=' + scheme, 'PACKAGE_VERSION=' + version,
                   'CS_GROUP_PERFORMANCE_OBSERVATION=' + str(observation),
                   '_THEOS_LOCAL_DATA_DIR=' + str(target / '.theos'),
                   'THEOS_BUILD_DIR=' + str(target), 'THEOS_PACKAGE_DIR=' + str(target / 'packages')]
        start = time.monotonic()
        with (EVIDENCE / (scheme + '-build.log')).open('w') as log:
            result = subprocess.run(command, cwd=snapshot, stdout=log, stderr=subprocess.STDOUT)
        row = {'scheme': scheme, 'command': command, 'exit_code': result.returncode,
               'seconds': round(time.monotonic() - start, 2)}
        save(scheme + '-build-result.json', row)
        return row

    with ThreadPoolExecutor(max_workers=2) as pool:
        builds = list(pool.map(build, ('rootless', 'rootful')))
    result = {'version': version, 'source_version': source_version,
              'observation': bool(observation), 'observation_macro': observation, 'checkout': str(ROOT), 'frozen_source': str(snapshot),
              'device_installed': False, 'builds': builds,
              'inputs_unchanged': inputs(ROOT) == before,
              'historical_packages_preserved': all((ROOT / p).is_file() and sha(ROOT / p) == digest
                                                   for p, digest in history.items())}
    save('build-result.json', result)
    assert all(row['exit_code'] == 0 for row in builds), 'Build failed; inspect scheme logs.'
    assert result['inputs_unchanged'], 'Production changed during build; freeze again.'
    assert result['historical_packages_preserved'], 'Existing package changed.'

    checked, packages, symbol_sources = [], [], []
    for scheme, package_arch in (('rootless', 'iphoneos-arm64'), ('rootful', 'iphoneos-arm')):
        target = temporary / scheme
        package = target / 'packages' / f'com.wechat.improve_{version}_{package_arch}.deb'
        info = {key: output(['dpkg-deb', '-f', str(package), key])
                for key in ('Package', 'Version', 'Architecture')}
        assert info == {'Package': 'com.wechat.improve', 'Version': version, 'Architecture': package_arch}
        extracted = target / 'verified'
        subprocess.run(['dpkg-deb', '-x', str(package), str(extracted)], check=True)
        prefix = ('var/jb/' if scheme == 'rootless' else '') + 'Library/MobileSubstrate/DynamicLibraries'
        dylib = extracted / prefix / 'WeChatImprove.dylib'
        architectures = output(['xcrun', 'lipo', '-archs', str(dylib)]).split()
        assert set(architectures) == {'arm64', 'arm64e'}
        symbols = output(['strings', str(dylib)])
        for required in ('CSGroupNativeModel', 'CSGroupNativeSessionCoordinator', 'performWithCompleteSourceForSurface:original:',
                         'modelByUpdatingResult:changedUserNames:rowProvider:',
                         'projectionByRemappingVisibleRows:',
                         'modelBySelectingTabID:fromResult:foldedRows:',
                         'projectionBySelectingTabID:', 'refreshInteractionIsBlocking',
                         'performChangeForUserNames:kind:original:'):
            assert required in symbols, required
        observation_markers = ('com.wechatimprove.performance', 'SessionGroups', 'ModelSelection',
                               'ModelFull', 'MainTableReloadData', 'ReloadDispatchUnverified',
                               'AdapterRefreshAttempt', 'AdapterPublication', 'TabRecordsRebuilt')
        for marker in observation_markers:
            assert (marker in symbols) == bool(observation), (scheme, marker, observation)
        imported_symbols = output(['xcrun', 'nm', '-u', str(dylib)])
        assert ('_os_signpost_emit_with_name_impl' in imported_symbols) == bool(observation)
        for cpu in architectures:
            generated_hooks = list((target / '.theos/obj').rglob('SessionGroupPerformanceObservation.xm*'))
            if not observation:
                assert not generated_hooks, 'Observation hook was compiled into the normal build.'
        native_uuids = output(['xcrun', 'dwarfdump', '--uuid', str(dylib)])
        uuids = {}
        for cpu in architectures:
            dsym = target / '.theos/obj' / cpu / 'WeChatImprove.dylib.dSYM'
            symbol_uuid = output(['xcrun', 'dwarfdump', '--uuid', str(dsym)])
            uuid = re.search(r'UUID: ([A-Fa-f0-9-]+) \(' + re.escape(cpu) + r'\)', native_uuids).group(1)
            assert uuid in symbol_uuid
            uuids[cpu] = uuid
            symbol_sources.append((scheme, cpu, dsym))
        checked.append({**info, 'scheme': scheme, 'architectures': architectures,
                        'sha256': sha(package), 'dylib_sha256': sha(dylib), 'dsym_uuids': uuids,
                        'observation_markers_match': True, 'signpost_import_matches': True})
        packages.append(package)

    DELIVERY.mkdir()
    for package in packages:
        shutil.copy2(package, DELIVERY / package.name)
    with zipfile.ZipFile(DELIVERY / f'com.wechat.improve_{version}_symbols.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
        for scheme, cpu, dsym in symbol_sources:
            for path in sorted(dsym.rglob('*')):
                if path.is_file():
                    archive.write(path, str(Path(scheme) / cpu / dsym.name / path.relative_to(dsym)))
    artifacts = [p for p in sorted(DELIVERY.iterdir()) if p.is_file()]
    (DELIVERY / 'SHA256SUMS').write_text(''.join(sha(p) + '  ' + p.name + '\n' for p in artifacts))
    result['verified_packages'] = checked
    result['artifacts'] = [{'path': str(p.relative_to(ROOT)), 'sha256': sha(p), 'bytes': p.stat().st_size}
                           for p in artifacts]
    save('build-result.json', result)
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
