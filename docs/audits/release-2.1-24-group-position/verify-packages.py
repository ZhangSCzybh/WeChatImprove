#!/usr/bin/env python3
"""Verify the frozen 2.1-24 build, archive its dSYMs, and record delivery hashes.

Only this release's audit records, symbols ZIP and SHA256SUMS are written. Existing
delivery artifacts are checked in place and never replaced with different bytes.
"""
import hashlib
import json
import os
from pathlib import Path
import plistlib
import re
import stat
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
VERSION = '2.1-24'
PACKAGES = ROOT / 'packages/2.1-24-group-position'
ARCHS = ('arm64', 'arm64e')
RETAINED_SYMBOLS = (
    '_OBJC_CLASS_$_CSAIBackgroundSync', '_CSAIInstallNativeSyncObserver',
    '_CSAIObserveBackgroundSyncRequest', '_OBJC_CLASS_$_CSAINativeSyncObservation',
    '_OBJC_CLASS_$_CSAIBackgroundSyncContext', '_CSCFPaymentOutputAllowed',
    '_CSCFUnreadPanelInstallHooks', '_CSCFUnreadPanelNotifyCount',
    '_CSCFIncomingCallToken', '_CSLayoutPreferencesRead',
    '_CSGroupCopyFoldedRowsSelectingSummary', '_CSAIReplyMessageIngressEnabled',
    '_CSAIReplyMessageIngressAllowsSession', '_CSGroupResolveNativeRowPathReusing',
    '_OBJC_CLASS_$_CSNavigationImageBinding', '_CSListCornerPerformSessionTableLayout',
    '_CSAIReadCredentialAsync', '_CSTabBarBeginControllerLayout',
    '_CSTabBarEndControllerLayout', '_OBJC_CLASS_$_CSGroupPublicationPlan',
    '_CSScheduledTaskAllowsExecution', '_OBJC_CLASS_$_CSScheduledTaskStore',
    '_OBJC_CLASS_$_CSScheduledTaskManager',
    '_OBJC_CLASS_$_CSScheduledTaskSettingsViewController',
)
POLICY_SYMBOLS = (
    '_CSBackgroundRunPolicyKey', '_CSBackgroundRunDefaultPolicy',
    '_CSBackgroundRunLegacyPolicy', '_CSBackgroundRunValidatePolicy',
    '_CSBackgroundRunPolicyAllowsDate', '_CSBackgroundRunPolicyNextBoundary',
    '_CSBackgroundRunPolicyWindowDescription',
    '_CSBackgroundRunSilentAudioData', '_CSBackgroundRunAudioWillChange',
    '_CSBackgroundRunAudioDidChange', '_CSBackgroundRunStateChangedNotification',
    '_OBJC_CLASS_$_CSBackgroundRunManager', '_OBJC_CLASS_$_CSBackgroundRunAudio',
    '_OBJC_CLASS_$_CSBackgroundRunViewController', '_OBJC_CLASS_$_CSBackupManager',
    '_OBJC_CLASS_$_CSBackupEngine', '_OBJC_CLASS_$_CSBackgroundRunWindowEditor',
)
METHODS = (
    '-[CSBackgroundRunManager savePolicy:error:]',
    '-[CSBackgroundRunManager updateBoundaryTimerAt:]',
    '-[CSBackgroundRunManager energyPauseReason]',
    '-[CSBackgroundRunManager setBackgroundState:]',
    '-[CSBackgroundRunManager remainingDuration]',
    '-[CSBackgroundRunManager reconcile]',
    '-[CSBackgroundRunManager publish:]',
    '-[CSBackgroundRunAudio hostBusy]',
    '-[CSBackgroundRunAudio startWithError:]',
    '-[CSBackgroundRunViewController saveWindowAllDay:start:end:error:]',
    '-[CSBackupManager create:completion:]',
    '-[CSBackupEngine save:error:]',
    '-[CSBackupEngine prepareContent:error:]',
    '-[CSBackupEngine capture:kind:allowingMissingAssets:error:]',
    '-[CSGroupListAdapter recordRefreshEvent:delay:]',
    '-[CSGroupListAdapter refreshDiagnosticsSnapshot]',
    '-[CSGroupProjection publicationPlanFrom:changes:contentUserNames:contentIdentityKnown:visiblePaths:]',
)
ABSENT_SYMBOLS = (
    '_OBJC_CLASS_$_CSBackupScheduler', '_OBJC_METACLASS_$_CSBackupScheduler',
    '_CSCloseFriendShouldSilence',
)
ABSENT_METHODS = (
    '-[CSBackupEngine save:kind:error:]', '+[CSBackupEngine contentDigest:]',
    '-[CSBackupManager processScheduledWork]', '-[CSBackupManager isAutoBackupEnabled]',
)


def require(value, message):
    if not value:
        raise RuntimeError(message)


def run(*command):
    return subprocess.check_output(command, text=True).strip()


def sha(path):
    with path.open('rb') as source:
        return hashlib.file_digest(source, 'sha256').hexdigest()


def save(name, value):
    (AUDIT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def input_hashes():
    paths = [p for folder in ('Controllers', 'Hooks', 'Headers', 'HeadersFile', 'layout')
             for p in (ROOT / folder).rglob('*') if p.is_file() and p.name != '.DS_Store']
    paths += [ROOT / name for name in ('Makefile', 'control', 'WeChatImprove.plist')]
    return {str(p.relative_to(ROOT)): sha(p) for p in sorted(paths) if p.is_file()}


def inventory(root):
    result = {}
    for path in sorted(root.rglob('*')):
        relative = path.relative_to(root)
        if relative.parts[0] == 'DEBIAN':
            continue
        mode = stat.S_IMODE(path.lstat().st_mode)
        if path.is_symlink():
            result[str(relative)] = {'type': 'symlink', 'target': os.readlink(path), 'mode': mode}
        elif path.is_file():
            result[str(relative)] = {'type': 'file', 'bytes': path.stat().st_size,
                                     'sha256': sha(path), 'mode': mode}
    return result


def uuid_map(path):
    output = run('xcrun', 'dwarfdump', '--uuid', str(path))
    matches = re.findall(r'UUID: ([A-F0-9-]+) \(([^)]+)\)', output)
    require(matches and len(matches) == len({arch for _, arch in matches}),
            'Missing or duplicate UUIDs: ' + str(path))
    return {arch: uuid for uuid, arch in matches}


def plist(path):
    return plistlib.loads(subprocess.check_output(['plutil', '-convert', 'xml1', '-o', '-', str(path)]))


def publish_identical_or_new(path, data):
    if path.exists():
        require(path.read_bytes() == data, 'Refusing to replace existing delivery: ' + str(path))
        return
    with path.open('xb') as output:
        output.write(data)


def main():
    build = json.loads((AUDIT / 'build-result.json').read_text())
    require(build['input_hashes_unchanged'] and build['existing_artifacts_preserved'],
            'Build input or historical artifact preservation failed')
    require(len(build['builds']) == 2 and {row['scheme'] for row in build['builds']} == {'rootless', 'rootful'},
            'Both build schemes are required')
    require(all(row['exit_code'] == 0 and row['warning_limit_satisfied'] for row in build['builds']),
            'A build failed or exceeded its warning limit')
    expected_inputs = json.loads((AUDIT / 'build-input-sha256.json').read_text())
    require(input_hashes() == expected_inputs, 'Production inputs changed after the recorded build')
    require(re.search(r'^Version: ' + re.escape(VERSION) + r'$', (ROOT / 'control').read_text(), re.M),
            'Source package version differs')
    require('#define kPluginVersionString @"' + VERSION + '"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text(),
            'Displayed plugin version differs')
    require('@"' + VERSION + '": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text(),
            'Release notes for this version are missing')
    builds = Path((AUDIT / 'build-directory.txt').read_text().strip())
    symbols = PACKAGES / f'com.wechat.improve_{VERSION}_symbols.zip'
    rows, dsym_sources = [], {}
    with tempfile.TemporaryDirectory(prefix='wechat-group-position-package-check-') as temporary:
        extraction = Path(temporary)
        for scheme, package_arch, prefix in (
                ('rootless', 'iphoneos-arm64', 'var/jb/'), ('rootful', 'iphoneos-arm', '')):
            package = PACKAGES / f'com.wechat.improve_{VERSION}_{package_arch}.deb'
            control = run('dpkg-deb', '-f', str(package))
            (AUDIT / f'control-{scheme}.log').write_text(control + '\n')
            metadata = {name: run('dpkg-deb', '-f', str(package), name)
                        for name in ('Package', 'Name', 'Version', 'Architecture', 'Depends', 'Section')}
            require(metadata['Package'] == 'com.wechat.improve' and metadata['Name'] == 'WeChatImprove',
                    'Wrong package identity: ' + scheme)
            require(metadata['Version'] == VERSION and metadata['Architecture'] == package_arch,
                    'Wrong version or package architecture: ' + scheme)
            require('mobilesubstrate' in metadata['Depends'], 'Missing substrate dependency')
            target = extraction / scheme
            subprocess.run(['dpkg-deb', '-x', str(package), str(target)], check=True)
            install = prefix + 'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib'
            dylib = target / install
            payload = inventory(target)
            staged = inventory(builds / scheme / '.theos/_')
            require(payload == staged and payload, 'Packaged files/resources differ from staging: ' + scheme)
            require(set(payload) == {install, str(Path(install).with_suffix('.plist'))},
                    'Unexpected package payload files: ' + scheme)
            package_filter = plist(dylib.with_suffix('.plist'))
            require(package_filter == plist(ROOT / 'WeChatImprove.plist'),
                    'Injection filter differs from source')
            require(package_filter == {'Filter': {'Executables': ['ZYBH'], 'Bundles': ['com.tencent.xin']}},
                    'Injection filter differs from the established WeChat target')
            archs = run('xcrun', 'lipo', '-archs', str(dylib)).split()
            require(set(archs) == set(ARCHS) and len(archs) == 2, 'Missing or unexpected dylib slices')
            uuids = uuid_map(dylib)
            require(set(uuids) == set(ARCHS), 'Dylib UUID architectures differ')
            commands = run('xcrun', 'otool', '-arch', 'all', '-l', str(dylib))
            (AUDIT / f'load-commands-{scheme}.log').write_text(commands + '\n')
            minimums = re.findall(r'\bminos\s+([\d.]+)', commands)
            require(minimums == ['15.0', '15.0'], 'Unexpected deployment targets')
            dependencies = {}
            selector_checks = {}
            for arch in ARCHS:
                arch_commands = run('xcrun', 'otool', '-arch', arch, '-l', str(dylib))
                require(re.findall(r'\bplatform\s+(\d+)', arch_commands) == ['2'], 'Expected the iOS platform')
                install_id = re.findall(r'cmd LC_ID_DYLIB\s+cmdsize \d+\s+name (.*?) \(offset', arch_commands)
                expected_id = ('@rpath/WeChatImprove.dylib' if scheme == 'rootless'
                               else '/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
                require(install_id == [expected_id], 'Unexpected dylib install ID')
                substrate = ('@rpath/CydiaSubstrate.framework/CydiaSubstrate' if scheme == 'rootless'
                             else '/Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate')
                require('name ' + substrate + ' (offset' in arch_commands, 'Wrong substrate path')
                rpaths = re.findall(r'\bpath\s+([^\n]+?)\s+\(offset', arch_commands)
                if scheme == 'rootless':
                    require({'/var/jb/Library/Frameworks', '/var/jb/usr/lib',
                             '@loader_path/.jbroot/Library/Frameworks', '@loader_path/.jbroot/usr/lib'} <= set(rpaths),
                            'Rootless rpaths are missing')
                else:
                    require(not any('/var/jb/' in path or '.jbroot' in path for path in rpaths),
                            'Rootful payload contains rootless rpaths')
                dependencies[arch] = {'platform': 'iOS', 'platform_id': 2, 'minimum_iOS': '15.0',
                                      'install_id': expected_id, 'substrate': substrate, 'rpaths': rpaths}
                exported = run('xcrun', 'nm', '-arch', arch, '-gU', str(dylib))
                names = {line.split()[-1] for line in exported.splitlines() if line.split()}
                require(set(RETAINED_SYMBOLS + POLICY_SYMBOLS) <= names, 'Required exported symbols are missing')
                require(not set(ABSENT_SYMBOLS) & names, 'Retired symbols remain in the dylib')
                (AUDIT / f'exported-symbols-{scheme}-{arch}.log').write_text(exported + '\n')
                thin = target / f'WeChatImprove.{arch}.dylib'
                subprocess.run(['xcrun', 'lipo', str(dylib), '-thin', arch, '-output', str(thin)], check=True)
                data = thin.read_bytes()
                require(VERSION.encode() + b'\0' in data, 'Version string is missing from a slice')
                for key in ('BackgroundRunPolicy', 'maxMinutes', 'energySaving', 'startMinute', 'endMinute'):
                    require(key.encode() + b'\0' in data, 'Policy key is missing from a slice: ' + key)
                selectors = [method[method.index(' ') + 1:-1] for method in METHODS]
                for selector in selectors:
                    require(selector.encode() + b'\0' in data, 'Selector is missing: ' + selector)
                require(b'save:kind:error:\0' not in data, 'Retired automatic-save selector remains')
                require(b'CSBackupScheduler\0' not in data, 'Retired scheduler class remains')
                selector_checks[arch] = selectors
                dsym = builds / scheme / '.theos/obj' / arch / 'WeChatImprove.dylib.dSYM'
                debug = dsym / 'Contents/Resources/DWARF/WeChatImprove.dylib'
                require(uuid_map(debug) == {arch: uuids[arch]}, 'Build dSYM UUID differs from package')
                for path in sorted(dsym.rglob('*')):
                    if path.is_file():
                        member = str(Path(scheme) / arch / path.relative_to(dsym.parent))
                        dsym_sources[member] = path
            rows.append({'scheme': scheme, 'package': package.name, 'metadata': metadata,
                         'version': VERSION, 'package_architecture': package_arch,
                         'install_path': '/' + install, 'dylib_architectures': archs,
                         'minimum_iOS': minimums, 'dependencies_per_architecture': dependencies,
                         'payload_files': payload, 'full_payload_matches_staging': True,
                         'filter_matches_source': True, 'filter': package_filter,
                         'retained_symbols': RETAINED_SYMBOLS,
                         'policy_symbols': POLICY_SYMBOLS, 'absent_symbols': ABSENT_SYMBOLS,
                         'selectors_per_architecture': selector_checks,
                         'retired_scheduler_and_automatic_save_absent': True,
                         'uuid_matches_dSYM': uuids, 'dylib_sha256': sha(dylib),
                         'external_resources': [], 'silent_audio_embedded_generator_present': True})

        # A completed existing symbols archive may be reverified, never replaced.
        if not symbols.exists():
            descriptor, draft_name = tempfile.mkstemp(prefix='.symbols-', suffix='.zip.tmp', dir=PACKAGES)
            os.close(descriptor)
            draft = Path(draft_name)
            try:
                with zipfile.ZipFile(draft, 'w', zipfile.ZIP_DEFLATED) as archive:
                    for member, path in dsym_sources.items():
                        archive.write(path, member)
                with zipfile.ZipFile(draft) as archive:
                    require(archive.testzip() is None, 'Draft symbols archive CRC failed')
                draft.chmod(0o644)
                os.link(draft, symbols)
            finally:
                draft.unlink(missing_ok=True)
        symbol_members, debug_checks = {}, []
        with zipfile.ZipFile(symbols) as archive:
            require(archive.testzip() is None, 'Delivered symbols archive CRC failed')
            require(len(archive.namelist()) == len(set(archive.namelist())) and
                    set(archive.namelist()) == set(dsym_sources), 'Symbols archive file inventory differs')
            for member, path in dsym_sources.items():
                data = archive.read(member)
                digest = hashlib.sha256(data).hexdigest()
                require(digest == sha(path), 'Archived symbol file differs from build: ' + member)
                symbol_members[member] = {'bytes': len(data), 'sha256': digest}
                if member.endswith('/Contents/Info.plist'):
                    info = plistlib.loads(data)
                    require(info.get('CFBundlePackageType') == 'dSYM' and
                            info.get('CFBundleIdentifier') == 'com.apple.xcode.dsym.WeChatImprove.dylib',
                            'Invalid archived dSYM bundle metadata')
                if '/DWARF/' not in member:
                    continue
                scheme, arch = Path(member).parts[:2]
                debug = extraction / 'delivered-symbols' / member
                debug.parent.mkdir(parents=True, exist_ok=True)
                debug.write_bytes(data)
                expected_uuid = next(row['uuid_matches_dSYM'][arch] for row in rows if row['scheme'] == scheme)
                require(uuid_map(debug) == {arch: expected_uuid}, 'Archived dSYM UUID differs from package')
                debug_symbols = run('xcrun', 'nm', '-a', str(debug))
                matching = []
                for method in METHODS:
                    lines = [line for line in debug_symbols.splitlines() if line.endswith(' ' + method)]
                    require(lines, 'Method implementation missing from delivered dSYM: ' + method)
                    matching.extend(lines)
                for method in ABSENT_METHODS:
                    require(not any(line.endswith(' ' + method) for line in debug_symbols.splitlines()),
                            'Retired automatic-backup implementation remains: ' + method)
                (AUDIT / f'dSYM-methods-{scheme}-{arch}.log').write_text('\n'.join(matching) + '\n')
                debug_checks.append({'scheme': scheme, 'architecture': arch, 'uuid': expected_uuid,
                                     'debug_file_sha256': hashlib.sha256(data).hexdigest(),
                                     'methods_present': METHODS, 'methods_absent': ABSENT_METHODS})
        require(len(debug_checks) == 4, 'All four delivered dSYMs must be checked')
    artifacts = [{'file': path.name, 'bytes': path.stat().st_size, 'sha256': sha(path)}
                 for path in sorted(PACKAGES.iterdir()) if path.suffix in ('.deb', '.zip')]
    require(len(artifacts) == 3, 'Expected exactly two packages and one symbols ZIP')
    sums = ''.join(row['sha256'] + '  ' + row['file'] + '\n' for row in artifacts)
    publish_identical_or_new(PACKAGES / 'SHA256SUMS', sums.encode())
    # Read the published manifest independently, checking names, duplicate entries,
    # and every final delivery byte rather than trusting the values just written.
    manifest = []
    for line in (PACKAGES / 'SHA256SUMS').read_text().splitlines():
        match = re.fullmatch(r'([a-f0-9]{64})  (.+)', line)
        require(match, 'Malformed SHA256SUMS entry')
        manifest.append(match.groups())
    expected_names = {row['file'] for row in artifacts}
    require(len(manifest) == 3 and len({name for _, name in manifest}) == 3 and
            {name for _, name in manifest} == expected_names, 'Incorrect SHA256SUMS file inventory')
    require({path.name for path in PACKAGES.iterdir()} == expected_names | {'SHA256SUMS'},
            'Unexpected files in the release delivery directory')
    require(all(sha(PACKAGES / name) == digest for digest, name in manifest),
            'Published delivery hash differs from SHA256SUMS')
    preserved = json.loads((AUDIT / 'preserved-artifacts-before.json').read_text())
    require(all((ROOT / name).is_file() and sha(ROOT / name) == digest for name, digest in preserved.items()),
            'A historical artifact changed after the build')
    verification = {'version': VERSION, 'production_input_hashes_match_build': True,
                    'production_input_file_count': len(expected_inputs),
                    'verification_script_sha256': sha(Path(__file__).resolve()),
                    'build_input_manifest_sha256': sha(AUDIT / 'build-input-sha256.json'),
                    'build_result_sha256': sha(AUDIT / 'build-result.json'),
                    'packages': rows, 'symbols_zip_crc_valid': True,
                    'symbol_files': len(symbol_members), 'symbol_archive_members': symbol_members,
                    'archived_dSYM_checks': debug_checks,
                    'artifacts': artifacts, 'sha256_manifest_verified': True,
                    'historical_artifacts_preserved_by_build': True,
                    'historical_artifacts_independently_rehashed': len(preserved),
                    'device_installed': False, 'device_energy_measured': False}
    save('package-verification.json', verification)
    print(json.dumps({'packages_verified': len(rows), 'dSYMs_verified': len(debug_checks),
                      'symbol_files': len(symbol_members), 'artifacts': artifacts}, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
