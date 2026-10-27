"""Build the approved AI session changes without replacing existing packages."""
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
WORK = Path(tempfile.mkdtemp(prefix='wechat-ai-session-package-'))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def output(*args):
    return subprocess.check_output(args, cwd=ROOT, text=True).strip()


def save(name, value):
    (HERE / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def uuids(path):
    return {arch: uuid for uuid, arch in re.findall(
        r'UUID: ([\w-]+) \(([^)]+)\)', output('xcrun', 'dwarfdump', '--uuid', str(path)))}


commit = output('git', 'rev-parse', 'HEAD')
delivery = ROOT / 'packages' / f'{VERSION}-ai-session-{commit[:8]}'
assert not delivery.exists(), f'Refusing to overwrite {delivery}'
assert f'Version: {VERSION}\n' in (ROOT / 'control').read_text()
assert f'#define kPluginVersionString @"{VERSION}"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
names = output('git', 'ls-files', '--cached', '--others', '--exclude-standard', '--',
               'Controllers', 'Headers', 'Hooks', 'Makefile', 'control', 'WeChatImprove.plist', 'layout').splitlines()
sources = {name: sha(ROOT / name) for name in names if (ROOT / name).is_file()}
preserved = {str(path.relative_to(ROOT)): sha(path)
             for folder in ['.theos', 'packages']
             for path in sorted((ROOT / folder).rglob('*')) if path.is_file()}
save('source-sha256.json', sources)
save('preservation-before.json', preserved)
environment = {'workspace': str(ROOT), 'buildRoot': str(WORK), 'sourceCommit': commit,
               'branch': output('git', 'branch', '--show-current'), 'version': VERSION,
               'sourceChangesIncluded': output('git', 'diff', '--name-only', '--',
                   'Controllers', 'Headers', 'Hooks', 'Makefile', 'control', 'WeChatImprove.plist', 'layout').splitlines(),
               'deliveryDirectory': str(delivery), 'commands': {}}
checks = {}
for scheme, package_arch, install in [
    ('rootless', 'iphoneos-arm64', 'var/jb/Library/MobileSubstrate/DynamicLibraries'),
    ('rootful', 'iphoneos-arm', 'Library/MobileSubstrate/DynamicLibraries'),
]:
    command = ['make', '-j4', 'package', f'SCHEME={scheme}', f'PACKAGE_VERSION={VERSION}',
               f'_THEOS_LOCAL_DATA_DIR={WORK / scheme}', f'THEOS_BUILD_DIR={WORK / (scheme + "-stage")}',
               f'THEOS_PACKAGE_DIR={WORK / "packages"}', 'COLOR=0']
    environment['commands'][scheme] = command
    save('build-environment.json', environment)
    log_path = HERE / f'build-{scheme}.log'
    print(f'{scheme}: building {commit[:8]} in {WORK}', flush=True)
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
    required = [b'2.1-1', b'CSAIReplyManager', b'CSAIReplyCoordinator', b'CSAIUsagePage',
                b'bailianResponses', b'previous_response_id', b'x-dashscope-session-cache',
                b'replyWithoutMention', b'toggleWithoutMention:', b'hideAIReply', b'hideScheduledTasks']
    for arch, uuid in ids.items():
        symbol = WORK / scheme / 'obj' / arch / 'WeChatImprove.dylib.dSYM/Contents/Resources/DWARF/WeChatImprove.dylib'
        assert uuids(symbol) == {arch: uuid}
        thin = WORK / f'verify-{scheme}-{arch}.dylib'
        subprocess.run(['lipo', str(binary), '-thin', arch, '-output', str(thin)], check=True)
        contents = thin.read_bytes()
        assert all(marker in contents for marker in required), (scheme, arch, 'missing feature marker')
    log_text = re.sub(r'\x1b\[[0-9;]*m', '', log_path.read_text())
    errors = [line for line in log_text.splitlines() if 'error:' in line]
    assert not errors, errors
    checks[scheme] = {'version': VERSION, 'packageArchitecture': package_arch,
                     'installPath': str(binary.relative_to(extracted)), 'matchingSymbolUUIDs': ids,
                     'dylibSHA256': sha(binary), 'newFeaturesPresentInBothArchitectures': True,
                     'buildErrors': errors, 'warningCount': log_text.count('warning:')}
    print(f'{scheme}: package version, architectures, AI features and symbol UUIDs verified', flush=True)

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

assert output('git', 'rev-parse', 'HEAD') == commit
assert all((ROOT / name).is_file() and sha(ROOT / name) == digest for name, digest in sources.items())
assert all((ROOT / name).is_file() and sha(ROOT / name) == digest for name, digest in preserved.items())
checks.update(sourceUnchangedDuringBuild=True, preservedExistingBuildAndPackageFiles=len(preserved),
              oldBuildAndPackagesUnchanged=True, installedOnDevice=False)
outputs = sorted((WORK / 'packages').glob(f'com.wechat.improve_{VERSION}*'))
assert len(outputs) == 3
delivery.mkdir()
manifest = []
for source in outputs:
    destination = delivery / source.name
    with destination.open('xb') as target, source.open('rb') as origin:
        shutil.copyfileobj(origin, target)
    assert sha(source) == sha(destination)
    manifest.append({'path': str(destination.relative_to(ROOT)), 'sha256': sha(destination),
                     'bytes': destination.stat().st_size})
save('packages.json', manifest)
save('delivery-verification.json', checks)
print(json.dumps(manifest, ensure_ascii=False, indent=2), flush=True)
