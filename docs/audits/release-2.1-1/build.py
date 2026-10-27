"""Package 2.1-1 in isolated Theos directories and verify before delivery."""
from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
VERSION = '2.1-1'
WORK = Path(tempfile.mkdtemp(prefix='wechat-release-2.1-1-'))

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def output(*args):
    return subprocess.check_output(args, text=True).strip()

def uuids(path):
    return {arch: uuid for uuid, arch in re.findall(r'UUID: ([\w-]+) \(([^)]+)\)', output('xcrun', 'dwarfdump', '--uuid', str(path)))}

assert f'Version: {VERSION}\n' in (ROOT / 'control').read_text()
assert f'#define kPluginVersionString @"{VERSION}"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
assert f'@"{VERSION}": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text()
assert not list((ROOT / 'packages').glob(f'com.wechat.improve_{VERSION}*'))
names = output('git', '-C', str(ROOT), 'ls-files', '--', 'Controllers', 'Headers', 'Hooks', 'Makefile', 'control', 'WeChatImprove.plist', 'layout').splitlines()
sources = {name: sha(ROOT / name) for name in names if (ROOT / name).is_file()}
(HERE / 'source-sha256.json').write_text(json.dumps(sources, indent=2) + '\n')
environment = {'workspace': str(ROOT), 'buildRoot': str(WORK), 'baseCommit': output('git', '-C', str(ROOT), 'rev-parse', 'HEAD'), 'commands': {}}
checks = {}
for scheme, package_arch, install in [
    ('rootless', 'iphoneos-arm64', 'var/jb/Library/MobileSubstrate/DynamicLibraries'),
    ('rootful', 'iphoneos-arm', 'Library/MobileSubstrate/DynamicLibraries'),
]:
    command = ['make', '-j4', 'package', f'SCHEME={scheme}', f'PACKAGE_VERSION={VERSION}',
               f'_THEOS_LOCAL_DATA_DIR={WORK / scheme}', f'THEOS_BUILD_DIR={WORK}',
               f'THEOS_PACKAGE_DIR={WORK / "packages"}', 'COLOR=0']
    environment['commands'][scheme] = command
    (HERE / 'build-environment.json').write_text(json.dumps(environment, indent=2) + '\n')
    log_path = HERE / f'build-{scheme}.log'
    with log_path.open('w') as log:
        result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    print(f'{scheme}: build exit {result.returncode}', flush=True)
    if result.returncode:
        raise SystemExit(result.returncode)
    package = WORK / 'packages' / f'com.wechat.improve_{VERSION}_{package_arch}.deb'
    assert output('dpkg-deb', '-f', str(package), 'Version') == VERSION
    assert output('dpkg-deb', '-f', str(package), 'Architecture') == package_arch
    extracted = WORK / f'verify-{scheme}'
    subprocess.run(['dpkg-deb', '-x', str(package), str(extracted)], check=True)
    binary = extracted / install / 'WeChatImprove.dylib'
    assert (extracted / install / 'WeChatImprove.plist').is_file()
    assert set(output('lipo', '-archs', str(binary)).split()) == {'arm64', 'arm64e'}
    ids = uuids(binary)
    assert set(ids) == {'arm64', 'arm64e'}
    for arch, uuid in ids.items():
        symbol = WORK / scheme / 'obj' / arch / 'WeChatImprove.dylib.dSYM/Contents/Resources/DWARF/WeChatImprove.dylib'
        assert uuids(symbol) == {arch: uuid}
    contents = binary.read_bytes()
    required = [b'2.1-1', b'CSAIReplyManager', b'CSAIReplyCoordinator', b'CSAIReplySettingsViewController',
                b'CSAIChatDetailState', b'CSScheduledTaskManager', b'hideAIReply', b'hideScheduledTasks']
    assert all(marker in contents for marker in required)
    log_text = re.sub(r'\x1b\[[0-9;]*m', '', log_path.read_text())
    errors = [line for line in log_text.splitlines() if 'error:' in line]
    assert not errors, errors
    checks[scheme] = {'version': VERSION, 'packageArchitecture': package_arch,
                     'installPath': str(binary.relative_to(extracted)), 'matchingSymbolUUIDs': ids,
                     'dylibSHA256': sha(binary), 'requiredFeatureMarkersPresent': True,
                     'buildErrors': errors, 'warningCount': log_text.count('warning:')}
    print(f'{scheme}: package version, arm64/arm64e, AI markers and symbol UUIDs verified', flush=True)

symbols = WORK / 'packages' / f'com.wechat.improve_{VERSION}_symbols.zip'
with zipfile.ZipFile(symbols, 'w', compression=zipfile.ZIP_DEFLATED) as archive:
    for scheme in checks:
        for path in sorted((WORK / scheme / 'obj').rglob('*')):
            if path.is_file() and '.dSYM/' in str(path):
                archive.write(path, str(Path(scheme) / path.relative_to(WORK / scheme / 'obj')))
with zipfile.ZipFile(symbols) as archive:
    assert archive.testzip() is None
    checks['symbolFileCount'] = len(archive.namelist())
    for scheme in ['rootless', 'rootful']:
        for arch in ['arm64', 'arm64e']:
            assert f'{scheme}/{arch}/WeChatImprove.dylib.dSYM/Contents/Resources/DWARF/WeChatImprove.dylib' in archive.namelist()

assert all((ROOT / name).is_file() and sha(ROOT / name) == digest for name, digest in sources.items())
preserved = json.loads((HERE / 'preservation-before.json').read_text())
assert all((ROOT / name).is_file() and sha(ROOT / name) == digest for name, digest in preserved.items())
checks['sourceUnchangedDuringBuild'] = True
checks['preservedExistingBuildAndPackageFiles'] = len(preserved)
checks['oldBuildAndPackagesUnchanged'] = True
checks['installedOnDevice'] = False

outputs = sorted((WORK / 'packages').glob(f'com.wechat.improve_{VERSION}*'))
assert len(outputs) == 3
manifest = []
for source in outputs:
    destination = ROOT / 'packages' / source.name
    assert not destination.exists(), f'Refusing to overwrite {destination}'
    shutil.copy2(source, destination)
    assert sha(source) == sha(destination)
    manifest.append({'path': str(destination.relative_to(ROOT)), 'sha256': sha(destination), 'bytes': destination.stat().st_size})
(HERE / 'packages.json').write_text(json.dumps(manifest, indent=2) + '\n')
(HERE / 'delivery-verification.json').write_text(json.dumps(checks, indent=2) + '\n')
print(json.dumps(manifest, indent=2), flush=True)
