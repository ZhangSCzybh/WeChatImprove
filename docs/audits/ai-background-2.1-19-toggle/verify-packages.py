#!/usr/bin/env python3
"""Check delivery metadata, payloads, retained symbols, dSYM UUIDs and hashes."""
from contextlib import contextmanager
import hashlib
import json
import os
from pathlib import Path
import plistlib
import re
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
VERSION = '2.1-19'
MAX_WARNINGS = 6
WARNING_BASELINE_VERSION = '2.1-17'
PACKAGES = ROOT / 'packages/2.1-19-ai-fallback-toggle'


def run(*command):
    return subprocess.check_output(command, text=True).strip()


def sha(path):
    with path.open('rb') as source:
        return hashlib.file_digest(source, 'sha256').hexdigest()


def input_hashes():
    paths = [p for folder in ('Controllers', 'Hooks', 'Headers', 'HeadersFile', 'layout')
             for p in (ROOT / folder).rglob('*') if p.is_file() and p.name != '.DS_Store']
    paths += [ROOT / name for name in ('Makefile', 'control', 'WeChatImprove.plist')]
    return {str(p.relative_to(ROOT)): sha(p) for p in sorted(paths) if p.is_file()}


@contextmanager
def staged_symbols(destination):
    # Publish a complete archive exclusively; a failed check leaves no final ZIP.
    if destination.exists():
        raise SystemExit('Symbols archive exists; preserve the existing delivery.')
    descriptor, name = tempfile.mkstemp(prefix='.symbols-', suffix='.zip.tmp', dir=destination.parent)
    os.close(descriptor)
    draft = Path(name)
    try:
        with zipfile.ZipFile(draft, 'w', zipfile.ZIP_DEFLATED) as archive:
            yield archive
        with zipfile.ZipFile(draft) as archive:
            assert archive.testzip() is None
        os.link(draft, destination)
    finally:
        draft.unlink(missing_ok=True)


def uuid_map(path):
    output = run('xcrun', 'dwarfdump', '--uuid', str(path))
    return dict((arch, uuid) for uuid, arch in re.findall(r'UUID: ([A-F0-9-]+) \(([^)]+)\)', output))


def plist(path):
    return plistlib.loads(subprocess.check_output(['plutil', '-convert', 'xml1', '-o', '-', str(path)]))


def main():
    result = json.loads((AUDIT / 'build-result.json').read_text())
    assert result['input_hashes_unchanged'] and result['existing_artifacts_preserved']
    assert all(row['exit_code'] == 0 for row in result['builds'])
    assert result['warning_limit'] == MAX_WARNINGS and result['warning_baseline_version'] == WARNING_BASELINE_VERSION
    assert result['warning_limits_satisfied']
    assert {row['scheme'] for row in result['builds']} == {'rootless', 'rootful'}
    assert len(result['builds']) == 2
    assert all(row['warning_count'] <= MAX_WARNINGS and row['warning_limit_satisfied'] for row in result['builds'])
    expected_inputs = json.loads((AUDIT / 'build-input-sha256.json').read_text())
    assert input_hashes() == expected_inputs, 'Production inputs changed after the recorded build.'
    assert re.search(r'^Version: ' + re.escape(VERSION) + r'$', (ROOT / 'control').read_text(), re.M)
    assert '#define kPluginVersionString @"' + VERSION + '"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
    assert '@"' + VERSION + '": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text()
    builds = Path((AUDIT / 'build-directory.txt').read_text().strip())
    extraction = Path(tempfile.mkdtemp(prefix='wechat-ai-background-2.1-19-toggle-package-check-'))
    required = ['_OBJC_CLASS_$_CSAIBackgroundSync', '_CSAIInstallNativeSyncObserver', '_CSAIObserveBackgroundSyncRequest',
                '_OBJC_CLASS_$_CSAINativeSyncObservation', '_OBJC_CLASS_$_CSAIBackgroundSyncContext',
                '_CSCFPaymentOutputAllowed', '_CSCFUnreadPanelInstallHooks', '_CSCFUnreadPanelNotifyCount',
                '_CSCFIncomingCallToken', '_CSLayoutPreferencesRead',
                '_CSGroupCopyFoldedRowsSelectingSummary', '_CSAIReplyMessageIngressEnabled',
                '_CSAIReplyMessageIngressAllowsSession', '_CSGroupResolveNativeRowPathReusing',
                '_OBJC_CLASS_$_CSNavigationImageBinding',
                '_CSListCornerPerformSessionTableLayout', '_CSAIReadCredentialAsync',
                '_CSTabBarBeginControllerLayout', '_CSTabBarEndControllerLayout']
    rows = []
    symbols = PACKAGES / f'com.wechat.improve_{VERSION}_symbols.zip'
    with staged_symbols(symbols) as archive:
        for scheme, package_arch, prefix in (
                ('rootless', 'iphoneos-arm64', 'var/jb/'), ('rootful', 'iphoneos-arm', '')):
            package = PACKAGES / f'com.wechat.improve_{VERSION}_{package_arch}.deb'
            version = run('dpkg-deb', '-f', str(package), 'Version')
            architecture = run('dpkg-deb', '-f', str(package), 'Architecture')
            assert version == VERSION and architecture == package_arch
            target = extraction / scheme
            subprocess.run(['dpkg-deb', '-x', str(package), str(target)], check=True)
            install_path = prefix + 'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib'
            dylib = target / install_path
            staged = builds / scheme / '.theos/_' / install_path
            assert dylib.is_file() and sha(dylib) == sha(staged)
            assert VERSION.encode('ascii') in dylib.read_bytes()
            assert b'backgroundFallback' in dylib.read_bytes()
            assert plist(dylib.with_suffix('.plist')) == plist(ROOT / 'WeChatImprove.plist')
            archs = run('xcrun', 'lipo', '-archs', str(dylib)).split()
            assert set(archs) == {'arm64', 'arm64e'}
            commands = run('xcrun', 'otool', '-arch', 'all', '-l', str(dylib))
            (AUDIT / ('load-commands-' + scheme + '.log')).write_text(commands + '\n')
            minimums = re.findall(r'\bminos\s+([\d.]+)', commands)
            assert len(minimums) == 2 and all(float(v) == 15.0 for v in minimums)
            for arch in archs:
                exported = run('xcrun', 'nm', '-arch', arch, '-gU', str(dylib))
                assert all(name in exported for name in required)
                assert '_CSCloseFriendShouldSilence' not in exported
                (AUDIT / ('exported-symbols-' + scheme + '-' + arch + '.log')).write_text(exported + '\n')
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
                         'retained_symbols': required, 'silence_bridge_symbol_absent': True,
                         'filter_matches_source': True, 'staged_payload_matches_package': True,
                         'version_string_present': True,
                         'uuid_matches_dSYM': uuids, 'dylib_sha256': sha(dylib)})
    with zipfile.ZipFile(symbols) as archive:
        assert archive.testzip() is None
        symbol_files = len(archive.namelist())
    sums = []
    artifacts = []
    for path in sorted(PACKAGES.iterdir()):
        if path.suffix in ('.deb', '.zip'):
            digest = sha(path)
            sums.append(digest + '  ' + path.name)
            artifacts.append({'file': path.name, 'bytes': path.stat().st_size, 'sha256': digest})
    (PACKAGES / 'SHA256SUMS').write_text('\n'.join(sums) + '\n')
    verification = {'packages': rows, 'symbols_zip_crc_valid': True, 'symbol_files': symbol_files,
                    'artifacts': artifacts, 'device_installed': False}
    (AUDIT / 'package-verification.json').write_text(json.dumps(verification, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(verification, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
