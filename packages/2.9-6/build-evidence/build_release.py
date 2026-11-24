#!/usr/bin/env python3
"""Isolated 2.9-6 final release packaging. Running without --build performs preflight only. Prepared without starting a build; use --baseline for the final explicit preserved-environment snapshot after runtime review."""
from __future__ import annotations

import argparse
import concurrent.futures
import datetime as dt
import hashlib
import io
import json
import os
from pathlib import Path
import plistlib
import re
import shutil
import subprocess
import sys
import tarfile
import zipfile

ROOT = Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
WORK = Path('/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-2.9-6-final-krbcf3bu')
VERSION = '2.9-6'
OUT = ROOT / 'packages' / VERSION
THEOS = Path('/Users/zhangshichao/theos')
ARCHS = {'arm64', 'arm64e'}
REMOVED_DIAGNOSTIC_TOKENS = ('CSInputTextGestureDiagnosticSummary', 'showInputGestureDiagnosticAlert', 'CSInputGestureRecordBinding', 'CSInputGestureObservedChats', 'CSInputGestureCreatedBindings', 'CSInputGestureInputCallbacks', 'CSInputGestureLastBindingComponents', 'CSInputGestureLastBindingStatus', 'CSInputGestureLastComponents', 'CSInputGestureLastResult', 'CSInputGestureLastTouchAt')
REMOVED_DIAGNOSTIC_UI_STRINGS = ('暂无检测结果', '请先返回聊天输入框滑动，再打开此处查看最近一次检测结果。\n\n%@', '当前存活聊天页：%lu\n当前绑定输入框：%lu\n累计观察聊天页：%lu')

BASELINE = WORK / 'preserved-environment-preparation.json'
INITIAL_DIFFERENCES = WORK / 'environment-preservation-initial-difference.json'
PREBUILD_DIFFERENCES = WORK / 'environment-differences-before-build.json'


def now():
    return dt.datetime.now(dt.timezone(dt.timedelta(hours=8))).isoformat()


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def digest(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def dump(path, value):
    Path(path).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def run(args, *, binary=False):
    result = subprocess.run([str(a) for a in args], cwd=str(ROOT),
                            check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return result.stdout if binary else result.stdout.decode('utf-8')


def source_manifest():
    # Production source includes all tracked and untracked hook, controller and local header files.
    files = [ROOT / n for n in ('Makefile', 'control', 'WeChatImprove.plist')]
    for directory in ('Controllers', 'Hooks', 'Headers'):
        files.extend(p for p in (ROOT / directory).rglob('*')
                     if p.is_file() and p.suffix in ('.h', '.m', '.mm', '.xm', '.x', '.c', '.cpp'))
    return {str(p.relative_to(ROOT)): digest(p) for p in sorted(set(files))}


def check_preserved(label, *, allow_external=False):
    original = json.loads(BASELINE.read_text())
    mismatches = []
    for rel, expected in original.items():
        path = ROOT / rel
        if not path.is_file():
            mismatches.append({'path': rel, 'reason': 'missing'})
        elif digest(path) != expected:
            mismatches.append({'path': rel, 'reason': 'sha256 changed'})
    extras = []
    for directory in (ROOT / '.theos', ROOT / 'packages'):
        for path in directory.rglob('*'):
            if not path.is_file() or path.is_relative_to(OUT):
                continue
            rel = str(path.relative_to(ROOT))
            if rel not in original:
                extras.append(rel)
    report = {'checked_at': now(), 'baseline': str(BASELINE), 'file_count': len(original),
              'unchanged': not mismatches and not extras,
              'mismatches': mismatches, 'new_preserved_area_files': sorted(extras)}
    if INITIAL_DIFFERENCES.is_file():
        report['initial_environment_difference_report'] = str(INITIAL_DIFFERENCES)
    if PREBUILD_DIFFERENCES.is_file():
        report['environment_differences_before_build'] = str(PREBUILD_DIFFERENCES)
    def permitted_external(path):
        return path.startswith('.theos/') or bool(re.fullmatch(r'packages/com\.wechat\.improve_[^/]*-test\d+_iphoneos-arm(?:64)?\.deb', path))
    changed_paths = [item['path'] for item in mismatches] + extras
    externally_changed = bool(changed_paths) and all(permitted_external(path) for path in changed_paths)
    report['allowed_external_concurrent_changes'] = bool(allow_external and externally_changed)
    dump(WORK / f'environment-preservation-{label}.json', report)
    require(report['unchanged'] or (allow_external and externally_changed),
            f'Preserved environment changed: {len(mismatches)} mismatches, {len(extras)} new files')
    return report


def preflight():
    require(Path.cwd().resolve() == ROOT.resolve(), f'Use explicit workdir {ROOT}')
    require(BASELINE.is_file(), 'Missing explicit preservation baseline')
    require(THEOS.is_dir(), f'Theos missing: {THEOS}')
    for command in ('make', 'dpkg-deb', 'xcrun', 'plutil'):
        require(shutil.which(command), f'Missing tool: {command}')
    control = (ROOT / 'control').read_text()
    header = (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
    require(re.search(rf'^Version: {re.escape(VERSION)}$', control, re.M), 'control version mismatch')
    require(f'#define kPluginVersionString @"{VERSION}"' in header, 'Plugin version mismatch')
    require(f'@"{VERSION}": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text(),
            'Missing current release notes')
    preserved = check_preserved('preflight')
    return {'version': VERSION, 'checkout': str(ROOT), 'build_root': str(WORK),
            'package_directory': str(OUT), 'preservation_baseline': str(BASELINE),
            'preserved_files': preserved['file_count']}


def build_one(scheme):
    local = WORK / scheme
    local.mkdir(exist_ok=True)
    args = ['make', 'package', '-j4', f'THEOS={THEOS}', f'SCHEME={scheme}',
            f'PACKAGE_VERSION={VERSION}', 'KEEP_LOGOS_INTERMEDIATES=1',
            f'THEOS_PROJECT_DIR={ROOT}', f'_THEOS_LOCAL_DATA_DIR={local}', f'THEOS_PACKAGE_DIR={OUT}']
    record = {'scheme': scheme, 'command': args, 'workdir': str(ROOT),
              'build_directory': str(local), 'started_at': now()}
    env = os.environ.copy()
    # Inherited overrides must not redirect outputs into the user's .theos tree.
    for key in ('MAKEFLAGS', 'MFLAGS', 'THEOS_OBJ_DIR', 'THEOS_STAGING_DIR',
                '_THEOS_LOCAL_DATA_DIR', 'THEOS_PACKAGE_DIR'):
        env.pop(key, None)
    with (OUT / f'build-{scheme}.log').open('wb') as log:
        result = subprocess.run(args, cwd=str(ROOT), env=env, stdout=log, stderr=subprocess.STDOUT)
    record.update(exit_code=result.returncode, completed_at=now())
    return record


def uuids(path):
    output = run(['xcrun', 'dwarfdump', '--uuid', path])
    return {arch: value.upper() for value, arch in
            re.findall(r'UUID:\s*([0-9A-Fa-f-]+)\s*\(([^)]+)\)', output)}


def package_metadata(path):
    text = run(['dpkg-deb', '-f', path])
    return {key: value for key, value in
            (line.split(': ', 1) for line in text.splitlines() if ': ' in line and not line.startswith(' '))}



def verify_removed_diagnostics(library, dwarf_files):
    library_bytes = library.read_bytes()
    symbol_bytes = {arch: path.read_bytes() for arch, path in dwarf_files.items()}
    found_binary_tokens = [token for token in REMOVED_DIAGNOSTIC_TOKENS if token.encode() in library_bytes]
    found_dsym_tokens = {arch: [token for token in REMOVED_DIAGNOSTIC_TOKENS if token.encode() in data]
                         for arch, data in symbol_bytes.items()}
    found_strings = [text for text in REMOVED_DIAGNOSTIC_UI_STRINGS
                     if any(text.encode(encoding) in library_bytes for encoding in ('utf-8', 'utf-16le'))]
    require(not found_binary_tokens and not any(found_dsym_tokens.values()) and not found_strings,
            f'Legacy input-gesture diagnostics remain: binary={found_binary_tokens}, dSYM={found_dsym_tokens}, strings={found_strings}')
    return {'removed_module_symbol_and_field_names': list(REMOVED_DIAGNOSTIC_TOKENS),
            'removed_diagnostic_only_strings': list(REMOVED_DIAGNOSTIC_UI_STRINGS),
            'historical_release_note_text_permitted': True,
            'packaged_binary_tokens_absent': True, 'packaged_binary_strings_absent': True,
            'compiled_dsym_tokens_absent': {arch: True for arch in symbol_bytes}}


def verify_package(scheme):
    arch = 'iphoneos-arm' if scheme == 'rootful' else 'iphoneos-arm64'
    package = OUT / f'com.wechat.improve_{VERSION}_{arch}.deb'
    require(package.is_file(), f'Missing package: {package}')
    metadata = package_metadata(package)
    require(metadata.get('Package') == 'com.wechat.improve', 'Unexpected package identifier')
    require(metadata.get('Version') == VERSION and metadata.get('Architecture') == arch,
            f'Package metadata mismatch: {metadata}')
    prefix = '' if scheme == 'rootful' else 'var/jb/'
    install = f'{prefix}Library/MobileSubstrate/DynamicLibraries/'
    expected = {f'{install}WeChatImprove.dylib', f'{install}WeChatImprove.plist'}
    data = run(['dpkg-deb', '--fsys-tarfile', package], binary=True)
    with tarfile.open(fileobj=io.BytesIO(data)) as archive:
        payload = {member.name.removeprefix('./') for member in archive.getmembers() if member.isfile()}
    require(payload == expected, f'Unexpected payload paths: {sorted(payload)}')
    extract = WORK / 'verify' / scheme
    extract.mkdir(parents=True, exist_ok=True)
    run(['dpkg-deb', '-x', package, extract])
    library = extract / install / 'WeChatImprove.dylib'
    plist = extract / install / 'WeChatImprove.plist'
    require(VERSION.encode() + b'\0' in library.read_bytes(), f'Plugin version string missing from {scheme} binary')
    actual_archs = set(run(['xcrun', 'lipo', '-archs', library]).split())
    require(actual_archs == ARCHS, f'Unexpected binary architectures: {actual_archs}')
    binary_uuids = uuids(library)
    require(set(binary_uuids) == ARCHS, f'Incomplete UUIDs: {binary_uuids}')
    slices = {}
    dsym = []
    dwarf_files = {}
    for cpu in sorted(ARCHS):
        build_info = run(['xcrun', 'vtool', '-arch', cpu, '-show-build', library])
        require(re.search(r'platform\s+IOS\b', build_info), f'{scheme}/{cpu} is not an iOS binary')
        minos = re.search(r'minos\s+(\S+)', build_info)
        require(minos and tuple(map(int, minos.group(1).split('.'))) in ((15, 0), (15, 0, 0)),
                f'{scheme}/{cpu} minimum deployment target is not iOS 15.0')
        slices[cpu] = {'platform': 'iOS', 'minimum_ios': minos.group(1), 'uuid': binary_uuids[cpu]}
        bundle = WORK / scheme / 'obj' / cpu / 'WeChatImprove.dylib.dSYM'
        dwarf = bundle / 'Contents/Resources/DWARF/WeChatImprove.dylib'
        require(dwarf.is_file(), f'Missing dSYM: {bundle}')
        dwarf_files[cpu] = dwarf
        symbol_uuids = uuids(dwarf)
        require(symbol_uuids == {cpu: binary_uuids[cpu]}, f'dSYM UUID mismatch: {scheme}/{cpu}')
        dsym.append({'architecture': cpu, 'uuid': binary_uuids[cpu], 'matches_binary': True,
                     'source_bundle': str(bundle)})
    diagnostics = verify_removed_diagnostics(library, dwarf_files)
    source_plist = plistlib.loads(run(['plutil', '-convert', 'xml1', '-o', '-', ROOT / 'WeChatImprove.plist'], binary=True))
    require(plistlib.loads(plist.read_bytes()) == source_plist, f'Injection plist differs: {scheme}')
    return {'scheme': scheme, 'package': package.name, 'metadata': metadata,
            'package_sha256': digest(package), 'install_path': '/' + install + library.name,
            'payload_paths': sorted(payload), 'binary_architectures': sorted(actual_archs),
            'binary_sha256': digest(library), 'embedded_version_present': True, 'slices': slices, 'dsym': dsym,
            'injection_plist_matches_source': True, 'removed_input_gesture_diagnostics': diagnostics,
            'extraction_directory': str(extract)}


def checksums():
    files = sorted(p for p in OUT.rglob('*') if p.is_file() and p.name != 'SHA256SUMS')
    (OUT / 'SHA256SUMS').write_text(''.join(f'{digest(p)}  {p.relative_to(OUT)}\n' for p in files))
    return len(files)


def build_and_verify():
    info = preflight()
    OUT.mkdir(parents=True, exist_ok=True)
    for artifact in ('WeChatImprove.dylib', 'symbols.zip',
                     f'com.wechat.improve_{VERSION}_iphoneos-arm.deb',
                     f'com.wechat.improve_{VERSION}_iphoneos-arm64.deb'):
        require(not (OUT / artifact).exists(), f'Refusing to overwrite existing artifact: {artifact}')
    before = source_manifest()
    dump(OUT / 'source-manifest.json', before)
    command_record = {**info, 'started_at': now(), 'builds': []}
    failure = None
    try:
        with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
            command_record['builds'] = list(pool.map(build_one, ('rootful', 'rootless')))
        command_record['completed_at'] = now()
        dump(OUT / 'build-commands.json', command_record)
        require(all(record['exit_code'] == 0 for record in command_record['builds']),
                'Build failed; see build-rootful.log / build-rootless.log')
        reports = [verify_package(scheme) for scheme in ('rootful', 'rootless')]
        library = Path(reports[0]['extraction_directory']) / reports[0]['install_path'].lstrip('/')
        shutil.copy2(library, OUT / 'WeChatImprove.dylib')
        with zipfile.ZipFile(OUT / 'symbols.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
            for report in reports:
                for symbol in report['dsym']:
                    bundle = Path(symbol['source_bundle'])
                    for path in sorted(bundle.rglob('*')):
                        if path.is_file():
                            archive.write(path, f'{report["scheme"]}/{symbol["architecture"]}/{bundle.name}/{path.relative_to(bundle)}')
        require(source_manifest() == before, 'Production source changed during build; artifacts require a fresh build')
        preserved = check_preserved('after-build', allow_external=True)
        dump(OUT / 'environment-preservation.json', preserved)
        dump(OUT / 'build-validation.json', {
            'version': VERSION, 'verified_at': now(), 'source_checkout': str(ROOT), 'build_root': str(WORK),
            'builds': reports, 'dylib_matches_rootful': digest(OUT / 'WeChatImprove.dylib') == reports[0]['binary_sha256'],
            'symbols_bundle_count': 4, 'source_manifest_matches_after_build': True,
            'preserved_environment_files': preserved['file_count'], 'preservation_baseline': str(BASELINE),
            'preserved_environment_since_selected_baseline_unchanged': preserved['unchanged'],
            'allowed_external_concurrent_changes': preserved['allowed_external_concurrent_changes'],
            'initial_environment_difference_report': str(INITIAL_DIFFERENCES) if INITIAL_DIFFERENCES.is_file() else None,
            'environment_differences_before_build': str(PREBUILD_DIFFERENCES) if PREBUILD_DIFFERENCES.is_file() else None,
            'device_validation': 'User confirmed beta03 works on the original device. This 2.9-6 final package receives local regression, compilation and payload checks; no new device installation is performed by this build.'})
        print(json.dumps({'status': 'built-and-verified', 'output': str(OUT), 'checksum_files': checksums()}, ensure_ascii=False))
    except BaseException as error:
        failure = error
        raise
    finally:
        try:
            check_preserved('final', allow_external=True)
        except Exception as preservation_error:
            if failure:
                print(f'Additional preservation failure: {preservation_error}', file=sys.stderr)
            else:
                raise


def main():
    global BASELINE
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', type=Path, default=BASELINE,
                        help='Explicit preserved-environment baseline; original baseline is never replaced')
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument('--build', action='store_true', help='Build both isolated schemes and verify outputs')
    mode.add_argument('--checksums', action='store_true', help='Refresh checksums after package README/evidence is final')
    mode.add_argument('--verify', action='store_true', help='Recheck existing packages and preserved files without building')
    args = parser.parse_args()
    BASELINE = args.baseline.resolve()
    if args.build:
        build_and_verify()
    elif args.checksums:
        require(OUT.is_dir(), 'Package directory does not exist')
        print(json.dumps({'checksum_files': checksums(), 'output': str(OUT)}, ensure_ascii=False))
    elif args.verify:
        reports = [verify_package(scheme) for scheme in ('rootful', 'rootless')]
        preservation = check_preserved('reverify')
        print(json.dumps({'status': 'verified', 'schemes': [r['scheme'] for r in reports],
                          'preserved_files': preservation['file_count']}, ensure_ascii=False))
    else:
        print(json.dumps({'status': 'preflight-only', **preflight()}, ensure_ascii=False))


if __name__ == '__main__':
    main()
