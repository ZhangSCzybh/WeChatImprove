#!/usr/bin/env python3
"""Freeze 2.2-19 sources, enforce warning and environment preservation, and package both injection schemes."""
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



def protection_matches(name):
    expected = json.loads((AUDIT / (name + '-before.json')).read_text())
    return all((ROOT / p).is_file() and sha(ROOT / p) == digest for p, digest in expected.items())


def warning_multiset(path):
    clean = re.sub(r'\x1b\[[0-9;]*m', '', path.read_text(errors='replace'))
    latest = {}
    linker_cpu = None
    warnings = []
    for line in clean.splitlines():
        compiled = re.search(r'Compiling (.+?) \((arm64e?)\)', line)
        if compiled:
            latest[compiled.group(1)] = compiled.group(2)
        linked = re.search(r'Linking tweak .+? \((arm64e?)\)', line)
        if linked:
            linker_cpu = linked.group(1)
        diagnostic = re.match(r'(.+?):\d+:\d+: warning: (.+)', line)
        if diagnostic:
            source, message = diagnostic.groups()
            warnings.append((latest.get(source, 'UNATTRIBUTED'), source, message))
        elif line.startswith('ld: warning:'):
            warnings.append((linker_cpu or 'UNATTRIBUTED', 'ld', line.removeprefix('ld: warning: ').strip()))
    from collections import Counter
    return Counter(warnings)


def warning_comparison(evidence):
    rows = []
    for scheme in ('rootless', 'rootful'):
        previous = ROOT / 'docs/audits/release-2.2-18-settings-return-header-gap/delivery-build' / (scheme + '-build.log')
        current = evidence / (scheme + '-build.log')
        old, new = warning_multiset(previous), warning_multiset(current)
        def records(counter):
            return [{'architecture':key[0], 'source':key[1], 'diagnostic':key[2], 'count':value}
                    for key, value in sorted(counter.items())]
        added = new - old
        rows.append({'scheme':scheme, 'baseline_log':str(previous), 'baseline_sha256':sha(previous),
                     'current_log':str(current), 'current_sha256':sha(current),
                     'baseline':records(old), 'current':records(new), 'added':records(added),
                     'removed':records(old-new), 'added_count':sum(added.values()),
                     'architectures':sorted({key[0] for key in new})})
    return {'normalization':'Strip ANSI colors; omit diagnostic line/column only; retain source, architecture, complete message, and multiplicity. Architecture follows the latest compilation event for that source, or link event for ld.',
            'schemes':rows, 'new_warning_count':sum(row['added_count'] for row in rows)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--version', default='2.2-19')
    parser.add_argument('--delivery-name', default='2.2-19-settings-subpage-tabbar')
    parser.add_argument('--evidence-subdir')
    parser.add_argument('--compile-only', action='store_true', help='Compile isolated candidates with make all; create no deb, symbol zip, or delivery directory.')
    args = parser.parse_args()
    if Path(args.delivery_name).name != args.delivery_name:
        raise SystemExit('delivery-name must be a single directory name.')
    delivery = ROOT / 'packages' / args.delivery_name
    evidence = (AUDIT / (args.evidence_subdir or ('candidate-build' if args.compile_only else 'delivery-build'))).resolve()
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

    assert protection_matches('historical-packages'), 'Historical packages changed since task start.'
    assert protection_matches('main-theos'), 'Main .theos changed since task start.'
    before = source_manifest(ROOT)
    history = package_manifest()
    temporary = Path(tempfile.mkdtemp(prefix='wechat-2219-settings-tabbar-'))
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
        # Keep architecture-tagged diagnostics ordered inside each scheme. Parallel
        # architectures can otherwise emit a warning after the next CPU's marker.
        command = ['make', 'all' if args.compile_only else 'package', '-j1', 'SCHEME=' + scheme, 'PACKAGE_VERSION=' + version,
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
              'device_installed': False, 'compile_only': args.compile_only, 'builds': builds,
              'inputs_unchanged': source_manifest(ROOT) == before,
              'historical_packages_preserved': all((ROOT / p).is_file() and sha(ROOT / p) == digest
                                                   for p, digest in history.items())}
    save('build-result.json', result)
    assert all(row['exit_code'] == 0 for row in builds), 'Build failed; inspect logs.'
    assert result['inputs_unchanged'], 'Production changed during build; freeze again.'
    assert result['historical_packages_preserved'], 'Historical package changed.'
    assert protection_matches('main-theos'), 'Main .theos changed during isolated builds.'
    warning_report = warning_comparison(evidence)
    save('warning-comparison.json', warning_report)
    assert warning_report['new_warning_count'] == 0, 'New warnings compared with 2.2-18; fix before delivery.'
    result['new_warning_count'] = 0
    result['main_theos_preserved'] = True
    if args.compile_only:
        candidates = []
        for scheme in ('rootless', 'rootful'):
            target = temporary / scheme
            dylib = target / '.theos/obj/WeChatImprove.dylib'
            assert dylib.is_file(), (scheme, 'missing linked candidate')
            architectures = output(['xcrun', 'lipo', '-archs', str(dylib)]).split()
            assert set(architectures) == {'arm64', 'arm64e'}, (scheme, architectures)
            strings = output(['strings', str(dylib)])
            for marker in ('resetFrom:settingsToken:completion:', 'prepareResetWithSettingsToken:',
                           'tapCloseFriendQuickEntry:', 'beginResetForAccountID:error:',
                           'resumeResetForAccountID:error:'):
                assert marker in strings, (scheme, marker)
            candidates.append({'scheme': scheme, 'temporary_dylib': str(dylib),
                               'sha256': sha(dylib), 'architectures': architectures})
        assert not delivery.exists(), 'Compile-only must not create a delivery directory.'
        assert not list(temporary.rglob('*.deb')), 'Compile-only must not create a deb.'
        result['candidate_dylibs'] = candidates
        result['delivery_created'] = False
        result['deb_created'] = False
        save('build-result.json', result)
        print(json.dumps(result, ensure_ascii=False, indent=2))
        return

    checked, packages, symbols = [], [], []
    rootful_dylib = None
    parser_symbol = '_CSProvisioningProfileDictionaryFromData'
    required_sources = ('CSAccountDetailViewController', 'CSProvisioningProfile', 'CSCustomViewController',
                        'CSCloseFriendSettingsViewController', 'CSAIReplySettingsViewController',
                        'CSScheduledTaskSettingsViewController', 'CSSettingsTableViewController', 'CSTabBarNativeAdapter',
                        'CSMessageMergeAdapter', 'CSCloseFriendSearchAdapter', 'CSCloseFriendManager',
                        'CSBubbleStyleAdapter', 'CSCloseFriendReset', 'CSCloseFriendRuntime')
    required_hooks = ('CloseFriendSearchHooks', 'CloseFriendLifecycleHooks', 'TabBarStyleHooks')
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
                markers = {
                    'CSProvisioningProfile': 'T ' + parser_symbol,
                    'CSAccountDetailViewController': 'U ' + parser_symbol,
                    'CSCustomViewController': '_OBJC_CLASS_$_CSCustomViewController',
                    'CSCloseFriendSettingsViewController': '_OBJC_CLASS_$_CSCloseFriendSettingsViewController',
                    'CSSettingsTableViewController': '_OBJC_CLASS_$_CSSettingsTableViewController',
                    'CSAIReplySettingsViewController': '_OBJC_CLASS_$_CSAIReplySettingsViewController',
                    'CSScheduledTaskSettingsViewController': '_OBJC_CLASS_$_CSScheduledTaskSettingsViewController',
                    'CSTabBarNativeAdapter': 'T _CSTabBarForController',
                    'CSMessageMergeAdapter': 'T _CSMessageMergeActivate',
                    'CSCloseFriendSearchAdapter': 'T _CSCFSearchHasMarkedText',
                    'CSCloseFriendManager': '_OBJC_CLASS_$_CSCloseFriendManager',
                    'CSBubbleStyleAdapter': 'T _CSBubbleStyleModelInsets',
                    'CSCloseFriendReset': '_OBJC_CLASS_$_CSCloseFriendReset',
                    'CSCloseFriendRuntime': '_OBJC_CLASS_$_CSCloseFriendRuntime',
                }
                marker = markers[name]
                assert marker in nm, (scheme, cpu, name, marker)
                compiled_objects[cpu][name] = {'path': str(objects[0]), 'sha256': sha(objects[0]),
                                               'verified_symbol': marker}
            for name in required_hooks:
                assert f'Compiling Hooks/{name}.xm ({cpu})' in log, (scheme, cpu, name)
            for marker in ('CSSettingsTableViewController', 'WCTabBarView', 'CSCFSearchHasMarkedText'):
                # Exported C names are independently checked in their objects;
                # class/selector strings prove the modern path reached the dylib.
                if marker != 'CSCFSearchHasMarkedText':
                    assert marker in strings, (scheme, cpu, marker)
            # The no-password credential-reset feature is removed. The only retained
            # legacy kind string is the one-time migration reader, checked by tests.
            for marker in ('beginCredentialResetForAccountID:error:', 'requiresPasswordSetupForAccountID:error:',
                           'prepareCredentialResetWithAccountConfirmation:token:error:',
                           'finishCredentialResetForAccountID:error:', 'completeCredentialSetupForAccountID:error:'):
                assert marker not in strings, (scheme, cpu, 'removed selector remains', marker)
            for marker in ('tapCloseFriendQuickEntry:', 'settingsAccessToken',
                           'profileForSettingsToken:', 'updateProfile:settingsToken:error:',
                           'isSettingsTokenCurrent:', 'resetFrom:settingsToken:completion:',
                           'prepareResetWithSettingsToken:'):
                assert marker in strings, (scheme, cpu, marker)
            dsym = target / '.theos/obj' / cpu / 'WeChatImprove.dylib.dSYM'
            uuid = re.search(r'UUID: ([A-Fa-f0-9-]+)', output(['xcrun', 'dwarfdump', '--uuid', str(thin)])).group(1)
            assert uuid in output(['xcrun', 'dwarfdump', '--uuid', str(dsym)]), (scheme, cpu)
            uuids[cpu] = uuid
            symbols.append((scheme, cpu, dsym))
        packages.append(package)
        checked.append({**info, 'scheme': scheme, 'architectures': architectures,
                        'sha256': sha(package), 'dylib_sha256': sha(dylib),
                        'dsym_uuids': uuids, 'compiled_sources': list(required_sources), 'compiled_hooks': list(required_hooks),
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
    assert result['inputs_unchanged'] and result['historical_packages_preserved'] and protection_matches('main-theos')
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
