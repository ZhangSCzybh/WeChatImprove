#!/usr/bin/env python3
"""Build a frozen copy of the current authorized checkout without cleaning it."""
import concurrent.futures
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import time
import zipfile

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
VERSION = '2.2-6-beta01'
DELIVERY = ROOT / 'packages' / (VERSION + '-native-session-groups')

def sha(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()

def run(command, **kwargs):
    return subprocess.check_output(command, text=True, stderr=subprocess.STDOUT, **kwargs).strip()

def save(name, value):
    (AUDIT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')

def production_hashes(base):
    paths = [base / name for name in ('Makefile', 'control', 'WeChatImprove.plist')]
    paths += [path for name in ('Controllers', 'Hooks', 'Headers', 'HeadersFile')
              for path in (base / name).rglob('*') if path.is_file() and path.name != '.DS_Store']
    return {str(path.relative_to(base)): sha(path) for path in sorted(paths)}

def main():
    assert not DELIVERY.exists(), 'Preserve existing delivery directory.'
    assert f'Version: {VERSION}\n' in (ROOT / 'control').read_text()
    assert f'#define kPluginVersionString @"{VERSION}"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
    assert f'@"{VERSION}": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text()
    before = production_hashes(ROOT)
    history = {str(path.relative_to(ROOT)): sha(path) for path in (ROOT / 'packages').rglob('*')
               if path.is_file() and path.suffix in ('.deb', '.zip')}
    save('historical-packages-before.json', history)
    save('build-input-sha256.json', before)
    temporary = Path(tempfile.mkdtemp(prefix='wechat-2.2-6-beta01-native-groups-'))
    snapshot = temporary / 'source'
    snapshot.mkdir()
    for name in ('Controllers', 'Hooks', 'Headers', 'HeadersFile'):
        shutil.copytree(ROOT / name, snapshot / name, symlinks=True)
    for name in ('Makefile', 'control', 'WeChatImprove.plist'):
        shutil.copy2(ROOT / name, snapshot / name)
    assert production_hashes(snapshot) == before
    (AUDIT / 'final-build-directory.txt').write_text(str(temporary) + '\n')

    def build(scheme):
        output = temporary / scheme
        output.mkdir()
        command = ['make', 'package', '-j4', 'SCHEME=' + scheme, 'PACKAGE_VERSION=' + VERSION,
                   '_THEOS_LOCAL_DATA_DIR=' + str(output / '.theos'),
                   'THEOS_BUILD_DIR=' + str(output), 'THEOS_PACKAGE_DIR=' + str(output / 'packages')]
        start = time.monotonic()
        with (AUDIT / ('final-build-' + scheme + '.log')).open('w') as log:
            result = subprocess.run(command, cwd=snapshot, stdout=log, stderr=subprocess.STDOUT)
        log = (AUDIT / ('final-build-' + scheme + '.log')).read_text()
        warnings = [line for line in log.splitlines() if 'warning:' in line]
        row = {'scheme': scheme, 'command': command, 'exit_code': result.returncode,
               'duration_seconds': round(time.monotonic() - start, 2), 'warnings': warnings}
        save('final-build-' + scheme + '-result.json', row)
        return row
    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
        builds = list(pool.map(build, ('rootless', 'rootful')))
    assert all(row['exit_code'] == 0 for row in builds), 'Build failed; inspect logs.'
    assert production_hashes(ROOT) == before, 'Inputs changed during frozen build; rebuild final state.'
    assert all((ROOT / name).is_file() and sha(ROOT / name) == value for name, value in history.items())

    checked = []
    symbol_sources = []
    packages = []
    for scheme, arch in (('rootless', 'iphoneos-arm64'), ('rootful', 'iphoneos-arm')):
        output = temporary / scheme
        package = output / 'packages' / f'com.wechat.improve_{VERSION}_{arch}.deb'
        assert package.is_file(), str(package)
        package_info = {field: run(['dpkg-deb', '-f', str(package), field]) for field in ('Package', 'Version', 'Architecture')}
        assert package_info == {'Package': 'com.wechat.improve', 'Version': VERSION, 'Architecture': arch}
        extracted = output / 'extracted'
        subprocess.run(['dpkg-deb', '-x', str(package), str(extracted)], check=True)
        prefix = extracted / ('var/jb/Library/MobileSubstrate/DynamicLibraries' if scheme == 'rootless'
                              else 'Library/MobileSubstrate/DynamicLibraries')
        dylib = prefix / 'WeChatImprove.dylib'
        assert dylib.is_file() and (prefix / 'WeChatImprove.plist').is_file()
        architectures = run(['xcrun', 'lipo', '-archs', str(dylib)]).split()
        assert set(architectures) == {'arm64', 'arm64e'}
        strings = run(['strings', str(dylib)])
        for required in (VERSION, 'CSGroupNativeModel', 'CSGroupNativeSessionCoordinator',
                         'CSGroupNativeSessionModelDidChangeNotification', 'CSBackgroundRunRuntime'):
            assert required in strings, required
        uuids = {}
        for cpu in ('arm64', 'arm64e'):
            dsym = output / '.theos/obj' / cpu / 'WeChatImprove.dylib.dSYM'
            assert dsym.is_dir()
            native_uuid = run(['xcrun', 'dwarfdump', '--uuid', str(dylib)])
            symbol_uuid = run(['xcrun', 'dwarfdump', '--uuid', str(dsym)])
            match = re.search(r'UUID: ([A-Fa-f0-9-]+) \(' + re.escape(cpu) + r'\)', native_uuid)
            assert match and match.group(1) in symbol_uuid, (cpu, native_uuid, symbol_uuid)
            uuids[cpu] = match.group(1)
            symbol_sources.append((scheme, cpu, dsym))
        checked.append({'scheme': scheme, **package_info, 'architectures': architectures,
                        'dylib_sha256': sha(dylib), 'package_sha256': sha(package), 'uuid_matches_dSYM': uuids})
        packages.append(package)

    DELIVERY.mkdir(exist_ok=False)
    for package in packages:
        shutil.copy2(package, DELIVERY / package.name)
    symbols = DELIVERY / f'com.wechat.improve_{VERSION}_symbols.zip'
    with zipfile.ZipFile(symbols, 'w', zipfile.ZIP_DEFLATED) as archive:
        for scheme, cpu, directory in symbol_sources:
            for path in sorted(directory.rglob('*')):
                if path.is_file():
                    archive.write(path, str(Path(scheme) / cpu / directory.name / path.relative_to(directory)))
    with zipfile.ZipFile(symbols) as archive:
        assert archive.testzip() is None
    entries = [path for path in sorted(DELIVERY.iterdir()) if path.suffix in ('.deb', '.zip')]
    (DELIVERY / 'SHA256SUMS').write_text(''.join(sha(path) + '  ' + path.name + '\n' for path in entries))
    result = {'version': VERSION, 'branch': run(['git', 'branch', '--show-current'], cwd=ROOT),
              'frozen_source_copy': str(snapshot), 'production_inputs_unchanged': production_hashes(ROOT) == before,
              'historical_packages_preserved': all(sha(ROOT / name) == value for name, value in history.items()),
              'includes_existing_background_runtime_changes': True, 'device_installed': False,
              'builds': builds, 'verified_packages': checked,
              'artifacts': [{'file': str(path.relative_to(ROOT)), 'bytes': path.stat().st_size, 'sha256': sha(path)} for path in entries]}
    save('final-build-result.json', result)
    print(json.dumps({key: result[key] for key in ('version', 'production_inputs_unchanged', 'historical_packages_preserved', 'verified_packages', 'artifacts')}, ensure_ascii=False, indent=2))

if __name__ == '__main__':
    main()
