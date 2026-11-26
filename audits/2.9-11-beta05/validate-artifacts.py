from pathlib import Path
import subprocess, json, hashlib, plistlib, zipfile, shutil, re

root = Path(__file__).resolve().parents[2]
audit = root / 'audits/2.9-11-beta05'
out = root / 'packages/2.9-11-beta05'
ctx = json.loads((audit / 'build-context.json').read_text())
build = Path(ctx['build_root'])
results = {}
symbols = build / 'symbols'
symbols.mkdir(exist_ok=True)
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()

def plist_data(path):
    return plistlib.loads(subprocess.check_output(['plutil', '-convert', 'xml1', '-o', '-', str(path)]))

source_before = json.loads((audit / 'source-manifest.json').read_text())
assert all(sha(root / p) == v for p, v in source_before.items()), 'compiled sources changed during build'
for scheme, arch, prefix in [('rootless', 'iphoneos-arm64', 'var/jb'), ('rootful', 'iphoneos-arm', '')]:
    deb = out / f'com.wechat.improve_2.9-11-beta05_{arch}.deb'
    meta = subprocess.check_output(['dpkg-deb', '-f', str(deb)], text=True)
    fields = dict(line.split(': ', 1) for line in meta.splitlines() if ': ' in line)
    assert fields['Package'] == 'com.wechat.improve'
    assert fields['Version'] == '2.9-11-beta05' and fields['Architecture'] == arch
    extraction = build / f'extracted-{scheme}'
    subprocess.run(['dpkg-deb', '-x', str(deb), str(extraction)], check=True)
    rel = Path(prefix) / 'Library/MobileSubstrate/DynamicLibraries'
    dylib = extraction / rel / 'WeChatImprove.dylib'
    assert plist_data(extraction / rel / 'WeChatImprove.plist') == plist_data(root / 'WeChatImprove.plist')
    stage = build / f'build-{scheme}' / '_' / rel / 'WeChatImprove.dylib'
    assert sha(dylib) == sha(stage)
    arches = subprocess.check_output(['xcrun', 'lipo', '-archs', str(dylib)], text=True).strip()
    assert set(arches.split()) == {'arm64', 'arm64e'}
    uuid_text = subprocess.check_output(['xcrun', 'dwarfdump', '--uuid', str(dylib)], text=True)
    uuids = {a: u for u, a in re.findall(r'UUID: (\S+) \((\S+)\)', uuid_text)}
    minos, dsym = {}, {}
    for a in ['arm64', 'arm64e']:
        load = subprocess.check_output(['xcrun', 'vtool', '-arch', a, '-show-build', str(dylib)], text=True)
        match = re.search(r'minos\s+(\S+)', load)
        assert match and match[1] == '15.0'
        minos[a] = match[1]
        src = build / f'build-{scheme}' / 'obj' / a / 'WeChatImprove.dylib.dSYM'
        info = subprocess.check_output(['xcrun', 'dwarfdump', '--uuid', str(src)], text=True)
        assert uuids[a] in info
        names = subprocess.check_output(['xcrun', 'nm', '-j', str(src / 'Contents/Resources/DWARF/WeChatImprove.dylib')], text=True)
        for name in ['_CSMessageMergeNativeAnimationEnded', '_CSMessageMergePerformNativeLayout', '_CSMessageMergeNativeLayoutPassEnded', '_CSTabBarUpdate', '_CSTabBarHitTest']:
            assert name in names, name
        dest = symbols / scheme / a / src.name
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(src, dest, dirs_exist_ok=True)
        dsym[a] = uuids[a]
    contents = subprocess.check_output(['strings', str(dylib)], text=True, errors='replace')
    forbidden = ['CSGroupFirstSwipeDiagnostics', 'CS_GROUP_FIRST_SWIPE_DIAG', 'CSFS_', 'cs_firstSwipeEvent', 'cs_exportFirstSwipe']
    assert not [s for s in forbidden if s in contents]
    for s in ['layoutInternal', 'setIsAnimating:', '2.9-11-beta05', 'CSTabBarPreviewView', 'performFunctionAction', 'com.wechat.enhance.tabbar_style.content_width', 'showQuickStylePicker', 'showTabBarDescription', 'com.wechat.enhance.tabbar_style.structure', 'com.wechat.enhance.tabbar_style.function_action']:
        assert s in contents, s
    log = (audit / 'logs' / f'build-{scheme}.log').read_text(errors='replace')
    warnings = [re.sub(r'\x1b\[[0-9;]*m', '', line) for line in log.splitlines() if 'warning:' in line]
    errors = [line for line in log.splitlines() if 'error:' in line or re.search(r'make(?:\[\d+\])?: \*\*\*', line)]
    assert not errors, errors
    results[scheme] = dict(file=deb.name, bytes=deb.stat().st_size, sha256=sha(deb), architecture=arch,
        dylib_path=str(rel / 'WeChatImprove.dylib'), dylib_sha256=sha(dylib), slices=arches.split(),
        min_os=minos, dSYM_UUIDs=dsym, warnings=len(warnings), warning_lines=warnings, errors=0,
        stage_hash_matches=True, injection_plist_matches=True, diagnostic_markers_absent=True, new_layout_APIs_present=True)
    if scheme == 'rootful':
        shutil.copy2(dylib, out / 'WeChatImprove.dylib')
with zipfile.ZipFile(out / 'symbols.zip', 'w', zipfile.ZIP_DEFLATED, compresslevel=6) as z:
    for p in sorted(symbols.rglob('*')):
        if p.is_file():
            z.write(p, p.relative_to(symbols))
with zipfile.ZipFile(out / 'symbols.zip') as z:
    assert z.testzip() is None
(audit / 'artifact-validation.json').write_text(json.dumps(dict(version='2.9-11-beta05', schemes=results,
    source_manifest_unchanged=True, symbol_zip_crc=True, source_units=ctx['source_units'], installed_on_device=False),
    indent=2, ensure_ascii=False))
for scheme, result in results.items():
    print(scheme, result['file'], result['bytes'], result['slices'], 'warnings=' + str(result['warnings']), 'errors=0')
print('PASS: source, metadata, path, architecture, stage hash, dSYM UUID and ZIP checks')
