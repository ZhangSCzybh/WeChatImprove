#!/usr/bin/env python3
"""Build and verify the 2.4-7 release from a frozen copy of this checkout."""

from concurrent.futures import ThreadPoolExecutor
import hashlib
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import tempfile
import zipfile

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
VERSION = '2.4-7'
DELIVERY = ROOT / 'packages/2.4-7-group-chat-background-opportunity'
SCHEMES = {'rootful': 'iphoneos-arm', 'rootless': 'iphoneos-arm64'}
CPUS = {'arm64', 'arm64e'}
DYLIB = 'WeChatImprove.dylib'
# HeadersFile is the reference dump and is not used by Makefile or production imports.
INPUT_DIRS = ('Controllers', 'Headers', 'Hooks')
INPUT_FILES = ('Makefile', 'WeChatImprove.plist', 'control')
ROOTLESS_RPATHS = {'/var/jb/Library/Frameworks', '/var/jb/usr/lib',
                   '@loader_path/.jbroot/Library/Frameworks', '@loader_path/.jbroot/usr/lib'}


def sha(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def inputs(root):
    paths = [root / name for name in INPUT_FILES]
    paths += [p for name in INPUT_DIRS for p in (root / name).rglob('*')
              if p.is_file() and p.name != '.DS_Store']
    return {p.relative_to(root): sha(p) for p in sorted(paths)}


def output(*args):
    return subprocess.check_output(args, text=True).strip()


def uuids(path):
    return {arch: uuid for uuid, arch in re.findall(
        r'^UUID: ([0-9A-F-]+) \((arm64e?)\)', output('xcrun', 'dwarfdump', '--uuid', path), re.M)}


def main():
    if DELIVERY.exists() or (AUDIT / 'package-verification.txt').exists():
        raise SystemExit('Preserve existing release and verification files.')
    assert re.search(rf'^Version: {re.escape(VERSION)}$', (ROOT / 'control').read_text(), re.M)
    assert f'#define kPluginVersionString @"{VERSION}"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
    assert f'@"{VERSION}": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text()
    expected = inputs(ROOT)
    scratch = Path(tempfile.mkdtemp(prefix='wechatimprove-247-', dir='/private/tmp'))
    snapshot, staging = scratch / 'source', scratch / 'release'
    staging.mkdir()
    for path in expected:
        destination = snapshot / path
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(ROOT / path, destination)
    assert inputs(snapshot) == expected, 'Frozen build inputs changed while being copied'
    manifest = AUDIT / 'package-build-inputs.sha256'
    manifest.write_text(''.join(f'{digest}  {path}\n' for path, digest in expected.items()))

    def build(scheme):
        target = scratch / scheme
        command = ['/usr/bin/make', 'package', '-j4', f'SCHEME={scheme}',
                   f'_THEOS_LOCAL_DATA_DIR={target / "theos"}', f'THEOS_BUILD_DIR={target}',
                   f'THEOS_PACKAGE_DIR={target / "deb"}']
        with (AUDIT / f'build-{scheme}.log').open('w') as log:
            print(f'Working directory: {snapshot}\n{shlex.join(command)}', file=log, flush=True)
            return subprocess.run(command, cwd=snapshot, stdout=log, stderr=subprocess.STDOUT).returncode

    print(f'Building two schemes from {snapshot}', flush=True)
    with ThreadPoolExecutor(max_workers=2) as pool:
        statuses = dict(zip(SCHEMES, pool.map(build, SCHEMES)))
    assert set(statuses.values()) == {0}, statuses
    assert inputs(snapshot) == inputs(ROOT) == expected, 'Production input changed during build'

    lines = [f'Checkout: {ROOT}', f'Frozen source: {snapshot}',
             f'Build inputs: {len(expected)} files; manifest SHA-256 {sha(manifest)}',
             f'Build exit codes: {statuses}']
    expected_symbols = {}
    archive = staging / 'symbols.zip'
    with zipfile.ZipFile(archive, 'w', compression=zipfile.ZIP_DEFLATED) as symbols:
        for scheme, arch in SCHEMES.items():
            target = scratch / scheme
            name = f'com.wechat.improve_{VERSION}_{arch}.deb'
            package = target / 'deb' / name
            for key, value in [('Package', 'com.wechat.improve'), ('Version', VERSION), ('Architecture', arch)]:
                assert output('dpkg-deb', '-f', package, key) == value, (scheme, key, value)
            unpacked = target / 'verified'
            subprocess.run(['dpkg-deb', '-x', package, unpacked], check=True)
            path = Path('var/jb' if scheme == 'rootless' else '') / 'Library/MobileSubstrate/DynamicLibraries'
            dylib = unpacked / path / DYLIB
            assert (unpacked / path / 'WeChatImprove.plist').is_file(), (scheme, 'Missing tweak filter')
            assert set(output('xcrun', 'lipo', '-archs', dylib).split()) == CPUS
            package_uuids = uuids(dylib)
            assert set(package_uuids) == CPUS, package_uuids
            lines += [f'{scheme}: {name}', f'  Package: com.wechat.improve; Version: {VERSION}; Architecture: {arch}',
                      f'  Payload: /{path}/{DYLIB}; architectures: arm64 arm64e']
            for cpu in sorted(CPUS):
                minimum = output('xcrun', 'vtool', '-show-build', '-arch', cpu, dylib)
                assert re.search(r'^\s*platform IOS$', minimum, re.M), minimum
                assert re.search(r'^\s*minos 15\.0$', minimum, re.M), minimum
                load_commands = output('xcrun', 'otool', '-l', '-arch', cpu, dylib)
                rpaths = set(re.findall(r'cmd LC_RPATH\n\s*cmdsize \d+\n\s*path (.+) \(offset', load_commands))
                assert rpaths == (ROOTLESS_RPATHS if scheme == 'rootless' else set()), (scheme, cpu, rpaths)
                dsym = target / 'theos/obj' / cpu / f'{DYLIB}.dSYM'
                for source in sorted(dsym.rglob('*')):
                    if source.is_file():
                        symbols.write(source, Path(scheme) / cpu / dsym.name / source.relative_to(dsym))
                dwarf = Path(scheme) / cpu / dsym.name / 'Contents/Resources/DWARF' / DYLIB
                expected_symbols[dwarf] = {cpu: package_uuids[cpu]}
                lines.append(f'  {cpu}: iOS 15.0; UUID {package_uuids[cpu]}; RPATHs: {", ".join(sorted(rpaths)) or "absent"}')
            shutil.copy2(package, staging / name)
            if scheme == 'rootful':
                shutil.copy2(dylib, staging / DYLIB)
                assert sha(dylib) == sha(staging / DYLIB)
                lines.append('  Standalone dylib is byte-identical to rootful payload.')

    with zipfile.ZipFile(archive) as symbols:
        assert symbols.testzip() is None, 'Archive CRC mismatch'
        for dwarf, expected_uuid in expected_symbols.items():
            assert uuids(Path(symbols.extract(str(dwarf), scratch / 'verified-symbols'))) == expected_uuid, dwarf
    lines.append('symbols.zip: CRC passed; all four archived DWARF UUIDs match their package slice.')
    filenames = sorted(path.name for path in staging.iterdir())
    (staging / 'SHA256SUMS').write_text(''.join(f'{sha(staging / name)}  {name}\n' for name in filenames))
    DELIVERY.mkdir()
    for name in [*filenames, 'SHA256SUMS']:
        shutil.copy2(staging / name, DELIVERY / name)
    lines.append(subprocess.check_output(['shasum', '-a', '256', '-c', 'SHA256SUMS'], cwd=DELIVERY, text=True).strip())
    lines.append((DELIVERY / 'SHA256SUMS').read_text().strip())
    (AUDIT / 'package-verification.txt').write_text('\n'.join(lines) + '\n')
    print(f'Verified and published {DELIVERY}')


if __name__ == '__main__':
    main()
