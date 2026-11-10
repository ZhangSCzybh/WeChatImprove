#!/usr/bin/env python3
"""Build the current checkout in a temporary snapshot; preserve previous packages."""
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
VERSION = '2.3-7'
DELIVERY = ROOT / 'packages/2.3-7-merge-nickname-scroll'


def sha(path):
    return hashlib.file_digest(path.open('rb'), 'sha256').hexdigest()


def manifest(root):
    files = [root / p for p in ('Makefile', 'control', 'WeChatImprove.plist')]
    files += [p for folder in ('Controllers', 'Hooks', 'Headers')
              for p in (root / folder).rglob('*') if p.is_file() and p.name != '.DS_Store']
    return {str(p.relative_to(root)): sha(p) for p in sorted(files)}


def output(*command):
    return subprocess.check_output(command, text=True, stderr=subprocess.STDOUT).strip()


def main():
    assert not DELIVERY.exists(), 'Preserve existing delivery; do not overwrite.'
    assert f'Version: {VERSION}\n' in (ROOT / 'control').read_text()
    assert f'kPluginVersionString @"{VERSION}"' in (ROOT / 'Headers/CSUserInfoHelper.h').read_text()
    assert f'@"{VERSION}": @[' in (ROOT / 'Controllers/CSReleaseNotesViewController.m').read_text()
    before = manifest(ROOT)
    history = {str(p.relative_to(ROOT)): sha(p) for p in (ROOT / 'packages').rglob('*')
               if p.is_file() and p.name != '.DS_Store'}
    work = Path(tempfile.mkdtemp(prefix='wechat-237-merge-nickname-scroll-build-'))
    source = work / 'source'
    source.mkdir()
    for folder in ('Controllers', 'Hooks', 'Headers'):
        shutil.copytree(ROOT / folder, source / folder)
    for name in ('Makefile', 'control', 'WeChatImprove.plist'):
        shutil.copy2(ROOT / name, source / name)
    assert manifest(source) == before
    (AUDIT / 'production-inputs.json').write_text(json.dumps(before, indent=2) + '\n')

    def build(scheme):
        target = work / scheme
        target.mkdir()
        command = ['make', 'package', '-j4', 'SCHEME=' + scheme, 'PACKAGE_VERSION=' + VERSION,
                   '_THEOS_LOCAL_DATA_DIR=' + str(target / '.theos'),
                   # Theos appends the recursive architecture to this isolated object root.
                   # A single absolute THEOS_OBJ_DIR would flatten arm64/arm64e outputs.
                   'THEOS_OBJ_DIR_NAME=obj',
                   'THEOS_STAGING_DIR=' + str(target / 'staging'),
                   'THEOS_BUILD_DIR=' + str(target), 'THEOS_PACKAGE_DIR=' + str(target / 'packages')]
        start = time.monotonic()
        with (AUDIT / (scheme + '-build.log')).open('w') as log:
            result = subprocess.run(command, cwd=source, stdout=log, stderr=subprocess.STDOUT)
        return {'scheme': scheme, 'command': command,
                'object_root': str(target / '.theos/obj'),
                'staging_dir': str(target / 'staging'),
                'package_dir': str(target / 'packages'),
                'exit_code': result.returncode,
                'seconds': round(time.monotonic() - start, 2)}

    with ThreadPoolExecutor(max_workers=2) as pool:
        builds = list(pool.map(build, ('rootless', 'rootful')))
    (AUDIT / 'build-commands.json').write_text(json.dumps(builds, indent=2) + '\n')
    assert all(b['exit_code'] == 0 for b in builds), 'Inspect build logs.'
    assert manifest(ROOT) == before, 'Source changed during build.'
    packages, symbols, verified = [], [], []
    rootful_dylib = None
    for scheme, architecture in (('rootless', 'iphoneos-arm64'), ('rootful', 'iphoneos-arm')):
        target = work / scheme
        deb = target / 'packages' / f'com.wechat.improve_{VERSION}_{architecture}.deb'
        info = {field: output('dpkg-deb', '-f', str(deb), field)
                for field in ('Package', 'Version', 'Architecture')}
        assert info == {'Package': 'com.wechat.improve', 'Version': VERSION, 'Architecture': architecture}
        extracted = target / 'verified'
        subprocess.run(['dpkg-deb', '-x', str(deb), str(extracted)], check=True)
        prefix = 'var/jb/' if scheme == 'rootless' else ''
        dylib = extracted / (prefix + 'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
        assert set(output('xcrun', 'lipo', '-archs', str(dylib)).split()) == {'arm64', 'arm64e'}
        exported = output('xcrun', 'nm', '-g', str(dylib))
        for marker in ('_CSMessageMergePrepare', '_CSMessageMergeRowHeight',
                       '_CSMessageMergeLayoutSettled', '_CSMessageMergeRender',
                       '_CSBubbleStyleApply', '_CSClownCaptureEdit', '_CSClownCaptureAmountEdit', '_CSClownPageDidDisappear', '_CSClownRenderCell', '_CSClownRowHeight', '_CSClownTimeDisplayModeDidChange'):
            assert marker in exported, (scheme, marker)
        assert 'PhotosUI.framework' in output('xcrun', 'otool', '-L', str(dylib))
        uuids = {}
        for cpu in ('arm64', 'arm64e'):
            thin = target / (cpu + '.dylib')
            subprocess.run(['xcrun', 'lipo', str(dylib), '-thin', cpu, '-output', str(thin)], check=True)
            dsym = target / '.theos/obj' / cpu / 'WeChatImprove.dylib.dSYM'
            uuid = re.search(r'UUID: ([A-Fa-f0-9-]+)', output('xcrun', 'dwarfdump', '--uuid', str(thin))).group(1)
            assert uuid in output('xcrun', 'dwarfdump', '--uuid', str(dsym))
            uuids[cpu] = uuid
            symbols.append((scheme, cpu, dsym))
        packages.append(deb)
        verified.append({**info, 'scheme': scheme, 'architectures': ['arm64', 'arm64e'],
                         'dylib_sha256': sha(dylib), 'dsym_uuids': uuids})
        if scheme == 'rootful':
            rootful_dylib = dylib
    assert manifest(ROOT) == before
    assert all((ROOT / p).is_file() and sha(ROOT / p) == digest for p, digest in history.items())
    DELIVERY.mkdir()
    for package in packages:
        shutil.copy2(package, DELIVERY / package.name)
    shutil.copy2(rootful_dylib, DELIVERY / 'WeChatImprove.dylib')
    with zipfile.ZipFile(DELIVERY / f'com.wechat.improve_{VERSION}_symbols.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
        for scheme, cpu, dsym in symbols:
            for path in sorted(dsym.rglob('*')):
                if path.is_file():
                    archive.write(path, str(Path(scheme) / cpu / dsym.name / path.relative_to(dsym)))
    artifacts = {p.name: sha(p) for p in sorted(DELIVERY.iterdir())}
    (DELIVERY / 'SHA256SUMS').write_text(''.join(f'{digest}  {name}\n' for name, digest in artifacts.items()))
    report = {'version': VERSION, 'checkout': str(ROOT), 'snapshot': str(source), 'builds': builds,
              'packages': verified, 'artifacts': artifacts, 'sources_unchanged_during_build': True,
              'previous_packages_preserved': True, 'device_installed': False,
              'build_environment': {'theos': '/Users/zhangshichao/theos',
                                    'clang': output('xcrun', '--find', 'clang'),
                                    'sdk': output('xcrun', '--show-sdk-path', '--sdk', 'iphoneos')}}
    (AUDIT / 'build-result.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
