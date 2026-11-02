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
VERSION = '2.2-6'
WARNING_BASELINE_VERSION = '2.2-5'
PACKAGES = ROOT / 'packages/2.2-6-background-run-native-priority'
BACKGROUND_RECORD_SELECTORS = (
    'lastBackgroundStartedAt', 'lastBackgroundStartObserved',
    'lastBackgroundCheckedAt', 'lastBackgroundCheckStatus',
    'lastForegroundReturnedAt', 'lastBackgroundStoppedAt',
    'lastBackgroundStopReason', 'lastCheckToForegroundInterval',
    'showLastBackgroundRecord',
)
BACKGROUND_RECORD_UI_TEXT = (
    '最近一次后台', '最后状态', '进入后台', '开始观察', '最后检查',
    '检查时状态', '返回前台', '停止时间', '停止原因', '检查至返回间隔',
    '最近一次后台记录', '尚无记录', '尚未检查', '尚未返回前台',
    '尚未停止', '尚无法计算', '最后检查仅证明该时刻执行过检查',
    '开始观察表示中途开始记录',
)
BACKGROUND_RECORD_DATE_FORMATS = ('MM-dd HH:mm:ss', 'yyyy-MM-dd HH:mm:ss')


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


def check_background_record_interface(dylib, scheme, arch, extraction):
    # Check each architecture independently; a string in the other slice must
    # not satisfy the new interface or UI requirements for this architecture.
    thin = extraction / f'WeChatImprove.{arch}.dylib'
    subprocess.run(['xcrun', 'lipo', str(dylib), '-thin', arch, '-output', str(thin)], check=True)
    payload = thin.read_bytes()

    def text_presence(values):
        return {value: any(value.encode(encoding) in payload for encoding in ('utf-8', 'utf-16le'))
                for value in values}

    row = {
        'scheme': scheme, 'architecture': arch,
        'verification_scope': 'Static selector and UI string presence in this Mach-O slice; no runtime invocation.',
        'selector_checks': {value: value.encode('ascii') in payload for value in BACKGROUND_RECORD_SELECTORS},
        'ui_text_checks': text_presence(BACKGROUND_RECORD_UI_TEXT),
        'date_format_checks': text_presence(BACKGROUND_RECORD_DATE_FORMATS),
    }
    row['all_present'] = all(all(row[key].values()) for key in
                             ('selector_checks', 'ui_text_checks', 'date_format_checks'))
    evidence = AUDIT / f'background-record-interface-{scheme}-{arch}.json'
    evidence.write_text(json.dumps(row, ensure_ascii=False, indent=2) + '\n')
    assert row['all_present'], f'Background record interface/UI evidence missing: {evidence}'
    return row


def main():
    result = json.loads((AUDIT / 'build-result.json').read_text())
    assert result['input_hashes_unchanged'] and result['existing_artifacts_preserved']
    assert all(row['exit_code'] == 0 for row in result['builds'])
    assert result['warning_baseline_version'] == WARNING_BASELINE_VERSION
    assert result['warning_multisets_equal']
    assert {row['scheme'] for row in result['builds']} == {'rootless', 'rootful'}
    assert len(result['builds']) == 2
    assert all(row['warning_count'] == 6 and row['warning_multiset_equal'] for row in result['builds'])
    expected_inputs = json.loads((AUDIT / 'build-input-sha256.json').read_text())
    assert input_hashes() == expected_inputs, 'Production inputs changed after the recorded build.'
    assert re.search(r'^Version: ' + re.escape(VERSION) + r'$', (ROOT / 'control').read_text(), re.M)
    assert '#define kPluginVersionString @"' + VERSION + '"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
    assert '@"' + VERSION + '": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text()
    builds = Path((AUDIT / 'build-directory.txt').read_text().strip())
    extraction = Path(tempfile.mkdtemp(prefix='wechat-2.2-6-native-priority-package-check-'))
    required = ['_OBJC_CLASS_$_CSBackgroundRunRuntime', '_OBJC_CLASS_$_CSBackgroundRunManager', '_OBJC_CLASS_$_CSAIBackgroundSync', '_CSAIInstallNativeSyncObserver', '_CSAIObserveBackgroundSyncRequest',
                '_OBJC_CLASS_$_CSAINativeSyncObservation', '_OBJC_CLASS_$_CSAIBackgroundSyncContext',
                '_CSCFPaymentOutputAllowed', '_CSCFUnreadPanelInstallHooks', '_CSCFUnreadPanelNotifyCount',
                '_CSCFIncomingCallToken', '_CSLayoutPreferencesRead',
                '_CSGroupCopyFoldedRowsSelectingSummary', '_CSAIReplyMessageIngressEnabled',
                '_CSAIReplyMessageIngressAllowsSession', '_CSGroupResolveNativeRowPathReusing',
                '_OBJC_CLASS_$_CSNavigationImageBinding',
                '_CSListCornerPerformSessionTableLayout', '_CSAIReadCredentialAsync',
                '_CSTabBarBeginControllerLayout', '_CSTabBarEndControllerLayout',
                '_CSScheduledTaskAllowsExecution', '_OBJC_CLASS_$_CSScheduledTaskStore',
                '_OBJC_CLASS_$_CSScheduledTaskManager', '_OBJC_CLASS_$_CSScheduledTaskSettingsViewController']
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
            assert b'canAttemptBackgroundWork' in dylib.read_bytes()
            assert b'beginTaskWithExpirationHandler:' in dylib.read_bytes()
            assert b'windowStart' in dylib.read_bytes() and b'windowEnd' in dylib.read_bytes()
            # Objective-C non-ASCII constant strings are stored in __ustring as UTF-16LE.
            for label in ('时间段内执行', '停止'):
                assert any(label.encode(encoding) in dylib.read_bytes()
                           for encoding in ('utf-8', 'utf-16le'))
            assert plist(dylib.with_suffix('.plist')) == plist(ROOT / 'WeChatImprove.plist')
            archs = run('xcrun', 'lipo', '-archs', str(dylib)).split()
            assert set(archs) == {'arm64', 'arm64e'}
            commands = run('xcrun', 'otool', '-arch', 'all', '-l', str(dylib))
            (AUDIT / ('load-commands-' + scheme + '.log')).write_text(commands + '\n')
            minimums = re.findall(r'\bminos\s+([\d.]+)', commands)
            assert len(minimums) == 2 and all(float(v) == 15.0 for v in minimums)
            record_interface_checks = {}
            for arch in archs:
                exported = run('xcrun', 'nm', '-arch', arch, '-gU', str(dylib))
                assert all(name in exported for name in required)
                assert '_CSCloseFriendShouldSilence' not in exported
                (AUDIT / ('exported-symbols-' + scheme + '-' + arch + '.log')).write_text(exported + '\n')
                record_interface_checks[arch] = check_background_record_interface(dylib, scheme, arch, target)
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
                         'background_record_interfaces_verified': all(check['all_present'] for check in record_interface_checks.values()),
                         'background_record_interface_checks': record_interface_checks,
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
    with (PACKAGES / 'SHA256SUMS').open('x') as output:
        output.write('\n'.join(sums) + '\n')
    checked = subprocess.run(['shasum', '-a', '256', '-c', 'SHA256SUMS'], cwd=PACKAGES,
                             text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    (AUDIT / 'shasum-check.log').write_text(checked.stdout)
    assert checked.returncode == 0, checked.stdout
    assert checked.stdout.count(': OK') == 3
    preserved = json.loads((AUDIT / 'historical-artifacts-before.json').read_text())
    missing = [p for p in preserved if not (ROOT / p).is_file()]
    changed = [p for p, digest in preserved.items() if (ROOT / p).is_file() and sha(ROOT / p) != digest]
    existing_dirs = set(json.loads((AUDIT / 'historical-directories-before.json').read_text()))
    current_dirs = {str(path.relative_to(ROOT)) for base in (ROOT / '.theos', ROOT / 'packages')
                    for path in [base, *base.rglob('*')] if path.is_dir()}
    missing_dirs = sorted(existing_dirs - current_dirs)
    allowed = str(PACKAGES.relative_to(ROOT))
    unexpected_dirs = sorted(path for path in current_dirs - existing_dirs
                             if path != allowed and not path.startswith(allowed + '/'))
    preservation = {'existing_file_count': len(preserved), 'missing': missing, 'changed': changed,
                    'existing_directory_count': len(existing_dirs), 'missing_directories': missing_dirs,
                    'unexpected_directories': unexpected_dirs,
                    'all_preserved': not (missing or changed or missing_dirs or unexpected_dirs)}
    (AUDIT / 'historical-artifacts-after-packaging.json').write_text(json.dumps(preservation, indent=2) + '\n')
    assert preservation['all_preserved']
    record_verification = {
        'version': VERSION,
        'selectors': BACKGROUND_RECORD_SELECTORS,
        'ui_text': BACKGROUND_RECORD_UI_TEXT,
        'date_formats': BACKGROUND_RECORD_DATE_FORMATS,
        'all_present': all(row['background_record_interfaces_verified'] for row in rows),
        'packages': {row['scheme']: row['background_record_interface_checks'] for row in rows},
    }
    (AUDIT / 'background-record-interface-verification.json').write_text(json.dumps(record_verification, ensure_ascii=False, indent=2) + '\n')
    verification = {'packages': rows, 'symbols_zip_crc_valid': True, 'symbol_files': symbol_files,
                    'artifacts': artifacts, 'device_installed': False,
                    'shasum_check_exit_code': checked.returncode,
                    'background_record_interfaces_verified': record_verification['all_present'],
                    'historical_artifacts_preserved': preservation['all_preserved']}
    (AUDIT / 'package-verification.json').write_text(json.dumps(verification, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(verification, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
