#!/usr/bin/env python3
"""Verify this audit's isolated packages and collect matching per-arch dSYMs."""
from pathlib import Path
import hashlib
import json
import plistlib
import re
import shutil
import subprocess
import zipfile

root = Path(__file__).resolve().parents[3]
audit = Path(__file__).resolve().parent
state = json.loads((audit / 'build-state.json').read_text())
output = Path(state['output'])
build = Path(state['build'])
symbol_stage = build / 'symbols'
symbol_stage.mkdir(exist_ok=True)
results = {}

def run(args):
    return subprocess.check_output(args, text=True).strip()

for scheme, architecture, prefix in (
    ('rootless', 'iphoneos-arm64', 'var/jb/'),
    ('rootful', 'iphoneos-arm', ''),
):
    package = output / f'com.wechat.improve_2.1-7_{architecture}.deb'
    metadata = run(['/opt/homebrew/bin/dpkg-deb', '-f', str(package)])
    assert 'Version: 2.1-7' in metadata
    assert f'Architecture: {architecture}' in metadata
    extracted = build / (scheme + '-extracted')
    subprocess.run(['/opt/homebrew/bin/dpkg-deb', '-x', str(package), str(extracted)], check=True)
    libraries = list(extracted.rglob('WeChatImprove.dylib'))
    assert len(libraries) == 1
    library = libraries[0]
    library_path = str(library.relative_to(extracted))
    assert library_path == prefix + 'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib'
    architectures = run(['xcrun', 'lipo', '-archs', str(library)]).split()
    assert sorted(architectures) == ['arm64', 'arm64e']
    load_commands = run(['xcrun', 'otool', '-arch', 'all', '-l', str(library)])
    (audit / 'logs' / ('load-commands-' + scheme + '.log')).write_text(load_commands + '\n')
    minimum_ios = re.findall(r'\bminos\s+(\S+)', load_commands)
    assert minimum_ios == ['15.0', '15.0']
    dylib_uuids = run(['xcrun', 'dwarfdump', '--uuid', str(library)])
    uuids = {arch: uuid for uuid, arch in re.findall(r'UUID: ([A-F0-9-]+) \(([^)]+)\)', dylib_uuids)}
    symbols = {}
    for arch in architectures:
        dsym = build / scheme / '.theos' / 'obj' / arch / 'WeChatImprove.dylib.dSYM'
        symbol_uuid = run(['xcrun', 'dwarfdump', '--uuid', str(dsym)])
        assert re.findall(r'UUID: ([A-F0-9-]+) \(([^)]+)\)', symbol_uuid) == [(uuids[arch], arch)]
        target = symbol_stage / scheme / arch / dsym.name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(dsym, target, dirs_exist_ok=True)
        symbols[arch] = {'uuid': uuids[arch], 'path': str(target.relative_to(symbol_stage))}
    data = library.read_bytes()
    retained = [
        'isAuthorized', 'requestAuthorizationWithPresentingViewController:completion:',
        'openOfficialAccountFromViewController:', 'openBrandProfileDirectly',
        'tryAlternativeURLScheme', 'returnFromUnauthorizedSettings', 'relayoutIconAndBadge', 'layoutIcon', 'layoutBadgeView',
        'canDiscoverCloseFriendEntry', 'CSAIReplyManager', 'CSScheduledTaskManager', '2.1-7',
    ]
    presence = {name: name.encode() + b'\0' in data for name in retained}
    assert all(presence.values()), presence
    assert b'checkAuthorization\0' not in data
    injection_filter = plistlib.loads(library.with_suffix('.plist').read_bytes())
    source_filter = subprocess.check_output(['plutil', '-convert', 'xml1', '-o', '-', str(root / 'WeChatImprove.plist')])
    assert injection_filter == plistlib.loads(source_filter)
    results[scheme] = {
        'package': str(package.relative_to(root)), 'metadata': metadata,
        'size': package.stat().st_size, 'sha256': hashlib.sha256(package.read_bytes()).hexdigest(),
        'library_path': '/' + library_path, 'library_sha256': hashlib.sha256(data).hexdigest(),
        'architectures': architectures, 'symbols': symbols,
        'minimum_ios_per_arch': minimum_ios,
        'warnings': json.loads((audit / 'warnings.json').read_text())[scheme]['count'],
        'retained_selectors_and_version': presence,
        'removed_selector_checkAuthorization_absent': True, 'filter': injection_filter,
    }

symbols_zip = output / 'com.wechat.improve_2.1-7_symbols.zip'
with zipfile.ZipFile(symbols_zip, 'w', zipfile.ZIP_DEFLATED) as archive:
    for path in sorted(symbol_stage.rglob('*')):
        if path.is_file():
            archive.write(path, path.relative_to(symbol_stage))
with zipfile.ZipFile(symbols_zip) as archive:
    assert archive.testzip() is None
    zip_check = {
        'file_count': len(archive.infolist()), 'crc': 'passed',
        'size': symbols_zip.stat().st_size,
        'sha256': hashlib.sha256(symbols_zip.read_bytes()).hexdigest(),
    }
checksums = {
    path.name: hashlib.sha256(path.read_bytes()).hexdigest()
    for path in sorted(output.iterdir()) if path.suffix in ('.deb', '.zip')
}
(output / 'SHA256SUMS').write_text(''.join(f'{digest}  {name}\n' for name, digest in checksums.items()))
checksum_check = subprocess.run(['shasum', '-a', '256', '-c', 'SHA256SUMS'], cwd=output,
                                capture_output=True, text=True, check=True)
(audit / 'logs' / 'checksums.log').write_text(checksum_check.stdout + checksum_check.stderr)
verification = {'version': '2.1-7', 'builds': results, 'symbols_zip': zip_check, 'sha256': checksums}
(audit / 'package-verification.json').write_text(json.dumps(verification, indent=2, ensure_ascii=False) + '\n')
print(json.dumps(verification, indent=2, ensure_ascii=False))
