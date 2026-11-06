#!/usr/bin/env python3
"""Freeze production sources and build verified account-signature packages."""
import argparse
from concurrent.futures import ThreadPoolExecutor
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
SOURCE_DIRS = ('Controllers', 'Hooks', 'Headers', 'HeadersFile')
SOURCE_FILES = ('Makefile', 'control', 'WeChatImprove.plist')


def sha(path):
    digest = hashlib.sha256()
    with path.open('rb') as source:
        for block in iter(lambda: source.read(1024 * 1024), b''):
            digest.update(block)
    return digest.hexdigest()


def source_manifest(root):
    paths = [root / name for name in SOURCE_FILES]
    paths += [p for name in SOURCE_DIRS for p in (root / name).rglob('*')
              if p.is_file() and p.name != '.DS_Store']
    files = {str(p.relative_to(root)): sha(p) for p in sorted(paths)}
    digest = hashlib.sha256()
    for relative, value in files.items():
        digest.update((relative + '\0' + value + '\n').encode())
    return {'tree_sha256': digest.hexdigest(), 'file_count': len(files), 'files': files}


def package_manifest():
    return {str(p.relative_to(ROOT)): sha(p) for p in sorted((ROOT / 'packages').rglob('*'))
            if p.is_file() and p.name != '.DS_Store'}


def output(command):
    return subprocess.check_output(command, text=True, stderr=subprocess.STDOUT).strip()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--version', default='2.2-13')
    parser.add_argument('--delivery-name', default='2.2-13-account-signature-final')
    parser.add_argument('--evidence-subdir', default='delivery-build')
    args = parser.parse_args()
    if Path(args.delivery_name).name != args.delivery_name:
        raise SystemExit('delivery-name must be a single directory name.')
    delivery = ROOT / 'packages' / args.delivery_name
    evidence = (AUDIT / args.evidence_subdir).resolve()
    if not evidence.is_relative_to(AUDIT):
        raise SystemExit('Evidence must remain under this audit directory.')
    if delivery.exists() or evidence.exists():
        raise SystemExit('Preserve existing artifacts; select new delivery/evidence directories.')
    control = (ROOT / 'control').read_text()
    version = re.search(r'^Version: (.+)$', control, re.M).group(1)
    display = re.search(r'#define kPluginVersionString @"([^"]+)"',
                        (ROOT / 'Headers/CSUserInfoHelper.h').read_text()).group(1)
    if version != args.version or display != version:
        raise SystemExit('Requested, package and displayed versions must agree.')
    if '@"' + version + '": @[' not in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text():
        raise SystemExit('Missing matching release notes.')
    parser_source = ROOT / 'Controllers/CSProvisioningProfile.m'
    if not parser_source.is_file():
        raise SystemExit('Parser implementation missing: ' + str(parser_source))

    before = source_manifest(ROOT)
    history = package_manifest()
    temporary = Path(tempfile.mkdtemp(prefix='wechat-account-signature-20261105-'))
    snapshot = temporary / 'source'
    snapshot.mkdir()
    for name in SOURCE_DIRS:
        shutil.copytree(ROOT / name, snapshot / name, symlinks=True)
    for name in SOURCE_FILES:
        shutil.copy2(ROOT / name, snapshot / name)
    if source_manifest(snapshot) != before:
        raise SystemExit('Frozen sources differ from checkout.')
    evidence.mkdir(parents=True)

    def save(name, value):
        (evidence / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')

    save('production-inputs.json', before)
    save('effective-inputs.json', source_manifest(snapshot))
    save('historical-packages-before.json', history)

    def build(scheme):
        target = temporary / scheme
        target.mkdir()
        command = ['make', 'package', '-j4', 'SCHEME=' + scheme, 'PACKAGE_VERSION=' + version,
                   '_THEOS_LOCAL_DATA_DIR=' + str(target / '.theos'),
                   'THEOS_BUILD_DIR=' + str(target),
                   'THEOS_PACKAGE_DIR=' + str(target / 'packages')]
        start = time.monotonic()
        with (evidence / (scheme + '-build.log')).open('w') as log:
            run = subprocess.run(command, cwd=snapshot, stdout=log, stderr=subprocess.STDOUT)
        result = {'scheme': scheme, 'command': command, 'exit_code': run.returncode,
                  'seconds': round(time.monotonic() - start, 2)}
        save(scheme + '-build-result.json', result)
        return result

    with ThreadPoolExecutor(max_workers=2) as pool:
        builds = list(pool.map(build, ('rootless', 'rootful')))
    result = {'version': version, 'checkout': str(ROOT), 'frozen_source': str(snapshot),
              'device_installed': False, 'builds': builds,
              'inputs_unchanged': source_manifest(ROOT) == before,
              'historical_packages_preserved': all((ROOT / p).is_file() and sha(ROOT / p) == digest
                                                   for p, digest in history.items())}
    save('build-result.json', result)
    assert all(row['exit_code'] == 0 for row in builds), 'Build failed; inspect logs.'
    assert result['inputs_unchanged'], 'Production changed during build; freeze again.'
    assert result['historical_packages_preserved'], 'Historical package changed.'

    checked, packages, symbols = [], [], []
    rootful_dylib = None
    parser_symbol = '_CSProvisioningProfileDictionaryFromData'
    required_sources = ('CSAccountDetailViewController', 'CSProvisioningProfile')
    for scheme, architecture in (('rootless', 'iphoneos-arm64'), ('rootful', 'iphoneos-arm')):
        target = temporary / scheme
        package = target / 'packages' / f'com.wechat.improve_{version}_{architecture}.deb'
        info = {key: output(['dpkg-deb', '-f', str(package), key])
                for key in ('Package', 'Version', 'Architecture')}
        assert info == {'Package': 'com.wechat.improve', 'Version': version,
                        'Architecture': architecture}, info
        extracted = target / 'verified'
        subprocess.run(['dpkg-deb', '-x', str(package), str(extracted)], check=True)
        prefix = ('var/jb/' if scheme == 'rootless' else '') + 'Library/MobileSubstrate/DynamicLibraries'
        dylib = extracted / prefix / 'WeChatImprove.dylib'
        if scheme == 'rootful':
            rootful_dylib = dylib
        architectures = output(['xcrun', 'lipo', '-archs', str(dylib)]).split()
        assert set(architectures) == {'arm64', 'arm64e'}, architectures
        uuids = {}
        compiled_objects = {}
        log = (evidence / (scheme + '-build.log')).read_text()
        for cpu in architectures:
            thin = target / ('verified-' + cpu + '.dylib')
            subprocess.run(['xcrun', 'lipo', str(dylib), '-thin', cpu, '-output', str(thin)], check=True)
            strings = output(['strings', str(thin)])
            assert 'CSAccountDetailViewController' in strings, (scheme, cpu)
            compiled_objects[cpu] = {}
            for name in required_sources:
                assert f'Compiling Controllers/{name}.m ({cpu})' in log, (scheme, cpu, name)
                objects = list((target / '.theos/obj' / cpu / 'Controllers').glob(name + '.m.*.o'))
                assert len(objects) == 1, (scheme, cpu, name, objects)
                nm = output(['xcrun', 'nm', '-g', str(objects[0])])
                marker = ('T ' if name == 'CSProvisioningProfile' else 'U ') + parser_symbol
                assert marker in nm, (scheme, cpu, name, marker)
                compiled_objects[cpu][name] = {'path': str(objects[0]), 'sha256': sha(objects[0]),
                                               'parser_symbol': marker}
            dsym = target / '.theos/obj' / cpu / 'WeChatImprove.dylib.dSYM'
            uuid = re.search(r'UUID: ([A-Fa-f0-9-]+)', output(['xcrun', 'dwarfdump', '--uuid', str(thin)])).group(1)
            assert uuid in output(['xcrun', 'dwarfdump', '--uuid', str(dsym)]), (scheme, cpu)
            uuids[cpu] = uuid
            symbols.append((scheme, cpu, dsym))
        packages.append(package)
        checked.append({**info, 'scheme': scheme, 'architectures': architectures,
                        'sha256': sha(package), 'dylib_sha256': sha(dylib),
                        'dsym_uuids': uuids, 'compiled_sources': list(required_sources),
                        'compiled_objects': compiled_objects,
                        'controller_class_packaged': True})

    assert source_manifest(ROOT) == before, 'Production changed during verification.'
    delivery.mkdir()
    for package in packages:
        shutil.copy2(package, delivery / package.name)
    assert rootful_dylib is not None
    ipa_dylib = delivery / 'WeChatImprove.dylib'
    shutil.copy2(rootful_dylib, ipa_dylib)
    rootful_package = next(row for row in checked if row['scheme'] == 'rootful')
    assert sha(ipa_dylib) == rootful_package['dylib_sha256']
    result['ipa_dylib'] = {'path': str(ipa_dylib.relative_to(ROOT)),
                          'source': 'Rootful deb: Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib',
                          'sha256': sha(ipa_dylib), 'matches_deb_dylib': True,
                          'binary_modified': False, 'architectures': rootful_package['architectures']}
    with zipfile.ZipFile(delivery / f'com.wechat.improve_{version}_symbols.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
        for scheme, cpu, dsym in symbols:
            for path in sorted(dsym.rglob('*')):
                if path.is_file():
                    archive.write(path, str(Path(scheme) / cpu / dsym.name / path.relative_to(dsym)))
    artifacts = [p for p in sorted(delivery.iterdir()) if p.is_file()]
    (delivery / 'SHA256SUMS').write_text(''.join(sha(p) + '  ' + p.name + '\n' for p in artifacts))
    result['verified_packages'] = checked
    result['artifacts'] = [{'path': str(p.relative_to(ROOT)), 'sha256': sha(p), 'bytes': p.stat().st_size}
                           for p in artifacts]
    result['inputs_unchanged'] = source_manifest(ROOT) == before
    result['historical_packages_preserved'] = all((ROOT / p).is_file() and sha(ROOT / p) == digest
                                                for p, digest in history.items())
    save('build-result.json', result)
    assert result['inputs_unchanged'] and result['historical_packages_preserved']
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
