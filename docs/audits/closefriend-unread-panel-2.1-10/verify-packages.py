#!/usr/bin/env python3
"""Check delivery metadata, payloads, architectures, symbols and checksums."""
import hashlib
import json
from pathlib import Path
import plistlib
import re
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
PACKAGES = ROOT / 'packages/2.1-10-unread-panel'


def run(*command):
    return subprocess.check_output(command, text=True).strip()


def uuid_map(path):
    output = run('xcrun', 'dwarfdump', '--uuid', str(path))
    return dict((arch, uuid) for uuid, arch in re.findall(r'UUID: ([A-F0-9-]+) \(([^)]+)\)', output))


def plist(path):
    # Theos converts the source OpenStep plist to a binary property list.
    return plistlib.loads(subprocess.check_output(['plutil', '-convert', 'xml1', '-o', '-', str(path)]))


def main():
    builds = Path((AUDIT / 'build-directory.txt').read_text().strip())
    extraction = Path(tempfile.mkdtemp(prefix='wechat-unread-panel-2.1-10-package-check-'))
    rows = []
    symbols = PACKAGES / 'com.wechat.improve_2.1-10_symbols.zip'
    with zipfile.ZipFile(symbols, 'w', zipfile.ZIP_DEFLATED) as archive:
        for scheme, package_arch, prefix in (
                ('rootless', 'iphoneos-arm64', 'var/jb/'), ('rootful', 'iphoneos-arm', '')):
            package = PACKAGES / f'com.wechat.improve_2.1-10_{package_arch}.deb'
            version = run('dpkg-deb', '-f', str(package), 'Version')
            architecture = run('dpkg-deb', '-f', str(package), 'Architecture')
            assert version == '2.1-10' and architecture == package_arch
            target = extraction / scheme
            subprocess.run(['dpkg-deb', '-x', str(package), str(target)], check=True)
            install_path = prefix + 'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib'
            dylib = target / install_path
            assert dylib.is_file()
            assert plist(dylib.with_suffix('.plist')) == plist(ROOT / 'WeChatImprove.plist')
            archs = run('xcrun', 'lipo', '-archs', str(dylib)).split()
            assert set(archs) == {'arm64', 'arm64e'}
            commands = run('xcrun', 'otool', '-arch', 'all', '-l', str(dylib))
            (AUDIT / ('load-commands-' + scheme + '.log')).write_text(commands + '\n')
            minimums = re.findall(r'\bminos\s+([\d.]+)', commands)
            assert len(minimums) == 2 and all(float(v) == 15.0 for v in minimums)
            exported = run('xcrun', 'nm', '-arch', 'all', '-gU', str(dylib))
            assert '_CSCFUnreadPanelInstallHooks' in exported and '_CSCFUnreadPanelNotifyCount' in exported
            uuids = uuid_map(dylib)
            for arch in archs:
                dsym = builds / scheme / '.theos/obj' / arch / 'WeChatImprove.dylib.dSYM'
                debug_file = dsym / 'Contents/Resources/DWARF/WeChatImprove.dylib'
                assert uuid_map(debug_file) == {arch: uuids[arch]}
                for path in sorted(dsym.rglob('*')):
                    if path.is_file():
                        archive.write(path, str(Path(scheme) / arch / path.relative_to(dsym.parent)))
            rows.append({'scheme': scheme, 'package': package.name, 'version': version,
                         'package_architecture': architecture, 'dylib_architectures': archs,
                         'install_path': '/' + install_path, 'minimum_iOS': minimums,
                         'unread_panel_symbols_present': True, 'filter_matches_source': True, 'uuid_matches_dSYM': uuids})
    with zipfile.ZipFile(symbols) as archive:
        assert archive.testzip() is None
        symbol_files = len(archive.namelist())
    sums = []
    artifacts = []
    for path in sorted(PACKAGES.iterdir()):
        if path.suffix in ('.deb', '.zip'):
            sha = hashlib.sha256(path.read_bytes()).hexdigest()
            sums.append(sha + '  ' + path.name)
            artifacts.append({'file': path.name, 'bytes': path.stat().st_size, 'sha256': sha})
    (PACKAGES / 'SHA256SUMS').write_text('\n'.join(sums) + '\n')
    result = {'packages': rows, 'symbols_zip_crc_valid': True, 'symbol_files': symbol_files,
              'artifacts': artifacts, 'device_installed': False}
    (AUDIT / 'package-verification.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
