"""Build and verify a local release without touching existing Theos artifacts."""
import hashlib
import json
import pathlib
import re
import shutil
import subprocess
import tempfile
import zipfile

VERSION = '2.1-5'
root = pathlib.Path(__file__).resolve().parents[3]
audit = pathlib.Path(__file__).resolve().parent
build = pathlib.Path(tempfile.mkdtemp(prefix='wechat-release-' + VERSION + '-'))
delivery = root / 'packages' / VERSION


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def dump(name, value):
    (audit / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def run(args):
    return subprocess.check_output(args, cwd=root, text=True).strip()


def source_hashes():
    paths = [root / name for name in ('Makefile', 'control', 'WeChatImprove.plist')]
    for folder in ('Controllers', 'Headers', 'Hooks'):
        paths.extend(p for p in (root / folder).rglob('*')
                     if p.is_file() and p.suffix in ('.m', '.h', '.xm', '.mm', '.x'))
    return {str(p.relative_to(root)): digest(p) for p in sorted(paths)}


def check_protected():
    changed = [name for name, sha in protected.items()
               if not (root / name).is_file() or digest(root / name) != sha]
    assert not changed, ('Existing artifact changed', changed)
    current = {str(p.relative_to(root)) for folder in ('.theos', 'packages')
               for p in (root / folder).rglob('*') if p.is_file()
               and not p.is_relative_to(delivery)}
    assert current == set(protected), ('Existing artifact paths changed',
                                      sorted(current ^ set(protected)))


def uuid_map(path):
    rows = re.findall(r'UUID: ([A-F0-9-]+) \(([^)]+)\)',
                      run(['xcrun', 'dwarfdump', '--uuid', str(path)]))
    result = {arch: uuid for uuid, arch in rows}
    assert len(result) == len(rows) and result and all(result.values()), str(path)
    return result


assert not delivery.exists(), 'Refusing to overwrite an existing delivery'
protected = json.loads((audit / 'protected-artifacts-before.json').read_text())
check_protected()
assert 'Version: ' + VERSION + '\n' in (root / 'control').read_text()
assert '#define kPluginVersionString @"' + VERSION + '"' in (root / 'Headers/CSUserInfoHelper.h').read_text()
assert '@"' + VERSION + '": @[' in (root / 'Controllers/CSReleaseNotesViewController.m').read_text()
source = source_hashes()
dump('source-sha256.json', source)
commands = {
    scheme: ['make', '-j4', 'package', 'SCHEME=' + scheme, 'PACKAGE_VERSION=' + VERSION,
             '_THEOS_LOCAL_DATA_DIR=' + str(build / scheme),
             'THEOS_BUILD_DIR=' + str(build / (scheme + '-build')),
             'THEOS_PACKAGE_DIR=' + str(build / 'packages'), 'COLOR=0']
    for scheme in ('rootless', 'rootful')
}
dump('build-environment.json', {
    'workspace': str(root), 'buildRoot': str(build),
    'branch': run(['git', 'branch', '--show-current']),
    'baseCommit': run(['git', 'rev-parse', 'HEAD']), 'version': VERSION,
    'sdk': run(['xcrun', '--sdk', 'iphoneos', '--show-sdk-path']),
    'compiler': run(['xcrun', 'clang', '--version']), 'commands': commands,
    'deviceInstalled': False,
})
print('Build root:', build, flush=True)
for scheme, args in commands.items():
    print('Building', scheme, flush=True)
    with (audit / ('build-' + scheme + '.log')).open('w') as log:
        status = subprocess.run(args, cwd=root, stdout=log, stderr=subprocess.STDOUT).returncode
    if status:
        print((audit / ('build-' + scheme + '.log')).read_text()[-8000:], flush=True)
        raise SystemExit(status)
    assert source_hashes() == source, 'Sources changed during build'
    check_protected()
    print('Built', scheme, flush=True)

retained = (
    'CSAIBackgroundSync', 'BackGroundFetchToSync', 'isGettingData', 'backgroundAudioActive',
    'allowUnmentioned', 'CSAIImagePreparer', 'imageEnabled', 'searchMode', 'enable_search',
    'enable_thinking', 'text/event-stream', 'image_url', 'forced_search',
    'CSListCornerSessionRestore', 'CSNativeContactPicker', 'CSBackupEngine', 'CSBackupAudit',
    'CSAIReplyManager', 'WCTimeLineMessageTailText', 'WCTimeLineMessageTailEnabled', VERSION,
)
removed = (
    'CSChatRoomSelectViewController', 'CSTimeLineTailSettingsViewController',
    'openBrandProfileWithContact:fromViewController:', 'openBrandProfileWithBizUtil:',
    'searchOfficialAccount', 'CSAuthorizationStatus', 'CSLastAuthorizationCheckTime',
    'clearAuthorizationCache',
)
records = []
for scheme, arch, prefix in (('rootless', 'iphoneos-arm64', 'var/jb/'),
                             ('rootful', 'iphoneos-arm', '')):
    package = build / 'packages' / ('com.wechat.improve_' + VERSION + '_' + arch + '.deb')
    assert package.is_file(), str(package)
    assert run(['dpkg-deb', '-f', str(package), 'Package']) == 'com.wechat.improve'
    assert run(['dpkg-deb', '-f', str(package), 'Version']) == VERSION
    assert run(['dpkg-deb', '-f', str(package), 'Architecture']) == arch
    extract = build / ('verify-' + scheme)
    extract.mkdir()
    subprocess.run(['dpkg-deb', '-x', str(package), str(extract)], check=True)
    rel = prefix + 'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib'
    library = extract / rel
    archs = run(['xcrun', 'lipo', '-archs', str(library)]).split()
    assert set(archs) == {'arm64', 'arm64e'}
    uuids = uuid_map(library)
    assert set(uuids) == {'arm64', 'arm64e'}
    symbols = []
    minimum_ios = {}
    for cpu in ('arm64', 'arm64e'):
        thin = build / (scheme + '-' + cpu + '.dylib')
        subprocess.run(['xcrun', 'lipo', str(library), '-thin', cpu, '-output', str(thin)], check=True)
        binary = thin.read_bytes()
        assert all(token.encode() in binary for token in retained), (scheme, cpu, 'missing feature')
        assert all(token.encode() not in binary for token in removed), (scheme, cpu, 'removed code present')
        versions = re.findall(r'\bminos\s+([\d.]+)', run(['xcrun', 'otool', '-l', str(thin)]))
        assert versions == ['15.0'], (scheme, cpu, versions)
        minimum_ios[cpu] = versions[0]
        dsym = build / scheme / 'obj' / cpu / 'WeChatImprove.dylib.dSYM'
        symbol_uuids = uuid_map(dsym)
        assert set(symbol_uuids) == {cpu} and symbol_uuids[cpu] == uuids[cpu]
        symbols.append((cpu, dsym))
    records.append({'scheme': scheme, 'version': VERSION, 'architecture': arch,
                    'installPath': rel, 'archs': archs, 'minimumIOS': minimum_ios,
                    'uuids': uuids, 'featureTokensVerified': True,
                    'removedRuntimeNamesAbsent': True, 'package': package, 'symbols': symbols})

# Stage and verify all delivery files externally before adding a distinct release directory.
stage = build / 'delivery'
stage.mkdir()
for row in records:
    shutil.copy2(row['package'], stage / row['package'].name)
zpath = stage / ('com.wechat.improve_' + VERSION + '_symbols.zip')
with zipfile.ZipFile(zpath, 'w', zipfile.ZIP_DEFLATED) as archive:
    for row in records:
        for cpu, dsym in row['symbols']:
            for path in sorted(dsym.rglob('*')):
                if path.is_file():
                    archive.write(path, str(pathlib.Path(row['scheme']) / cpu / dsym.name / path.relative_to(dsym)))
with zipfile.ZipFile(zpath) as archive:
    assert archive.testzip() is None
    assert len(archive.namelist()) == 12
    archive.extractall(build / 'verify-symbols-archive')
for row in records:
    for cpu in ('arm64', 'arm64e'):
        dsym = build / 'verify-symbols-archive' / row['scheme'] / cpu / 'WeChatImprove.dylib.dSYM'
        archived = uuid_map(dsym)
        assert set(archived) == {cpu} and archived[cpu] == row['uuids'][cpu]
checksums = {p.name: digest(p) for p in sorted(stage.iterdir())}
(stage / 'SHA256SUMS').write_text(''.join(sha + '  ' + name + '\n' for name, sha in checksums.items()))
assert source_hashes() == source, 'Sources changed during verification'
check_protected()
assert not delivery.exists()
shutil.copytree(stage, delivery)
assert all(digest(delivery / name) == sha for name, sha in checksums.items())
check_protected()
package_records = [{'path': str(p.relative_to(root)), 'sha256': digest(p), 'bytes': p.stat().st_size}
                   for p in sorted(delivery.iterdir())]
dump('packages.json', package_records)
for row in records:
    row.pop('package')
    row.pop('symbols')
dump('delivery-verification.json', {
    'packages': records, 'symbolsArchiveVerified': True, 'archivedSymbolUUIDsVerified': True,
    'retainedTokens': retained, 'removedTokens': removed,
    'protectedArtifactCount': len(protected), 'changedExistingArtifacts': [],
    'sourceChangesDuringBuild': [], 'deviceInstalled': False,
})
print(json.dumps(package_records, ensure_ascii=False, indent=2), flush=True)
