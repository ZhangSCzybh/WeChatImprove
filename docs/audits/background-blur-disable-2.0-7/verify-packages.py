#!/usr/bin/env python3
"""Verify existing isolated builds, then publish versioned deb/symbol artifacts."""
import hashlib, json, pathlib, re, shutil, subprocess, tempfile, zipfile
repo = pathlib.Path(__file__).resolve().parents[3]
audit = pathlib.Path(__file__).resolve().parent
build = pathlib.Path(json.loads((audit / 'build-environment.json').read_text())['buildRoot'])
version = re.search(r'^Version: (.+)$', (repo / 'control').read_text(), re.M)[1]

def run(*args):
    return subprocess.check_output([str(x) for x in args], text=True)
def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()
def publish(source):
    target = repo / 'packages' / source.name
    if target.exists():
        assert sha(source) == sha(target), f'refuse to overwrite different {target}'
    else:
        shutil.copy2(source, target)
    return {'path':str(target.relative_to(repo)), 'bytes':target.stat().st_size,'sha256':sha(target)}

results=[]
for scheme, package_arch in [('rootless','iphoneos-arm64'),('rootful','iphoneos-arm')]:
    package=build/'packages'/f'com.wechat.improve_{version}_{package_arch}.deb'
    assert run('dpkg-deb','-f',package,'Version').strip()==version
    assert run('dpkg-deb','-f',package,'Architecture').strip()==package_arch
    with tempfile.TemporaryDirectory(prefix='wechat-background-privacy-verify-') as temporary:
        extracted=pathlib.Path(temporary)
        subprocess.run(['dpkg-deb','-x',str(package),str(extracted)],check=True)
        libs=list(extracted.rglob('WeChatImprove.dylib'));assert len(libs)==1
        dylib=libs[0]
        assert set(run('xcrun','lipo','-archs',dylib).split())=={'arm64','arm64e'}
        payload=dylib.read_bytes()
        for required in [b'CSBackgroundBlurManager',b'CSBackgroundBlurOverlay',b'CSCloseFriendManager',b'backgroundPrivacySettingsChanged:',b'com.wechat.tweak.background.blur.enabled',version.encode()]:
            assert required in payload, required
        for removed in [b'CSBackupFileProtection',b'CSBackupInstallFileProtection',b'blocked-native-trash',b'moveFileToTmpTrash:description:',b'moveFolderToTmpTrash:description:',b'CSRestoreTestOpen',b'CSRestoreStoreOpen',b'CSRestoreStoreRename',b'CSRestoreStoreFsync',b'CSFakeLAContext',b'BiometricManager',b'PrivacyManager',b'PrivacyBlurAccess',b'privacy-fixture']:
            assert removed not in payload, removed
        assert '/LocalAuthentication.framework/LocalAuthentication' in run('xcrun','otool','-L',dylib)
        uuids=run('xcrun','dwarfdump','--uuid',dylib)
        constructors=[]
        for arch in ['arm64','arm64e']:
            thin=extracted/(arch+'.dylib')
            subprocess.run(['xcrun','lipo',str(dylib),'-thin',arch,'-output',str(thin)],check=True)
            dsym=build/scheme/'obj'/arch/'WeChatImprove.dylib.dSYM'
            dwarf=dsym/'Contents/Resources/DWARF/WeChatImprove.dylib'
            uuid=re.search(r'UUID: ([A-F0-9-]+)',run('xcrun','dwarfdump','--uuid',dsym))[1]
            assert f'{uuid} ({arch})' in uuids
            nm=run('xcrun','nm','-nm',dwarf)
            assert '-[CSCloseFriendManager backgroundPrivacySettingsChanged:]' in nm
            assert '-[CSBackgroundBlurManager isEnabled]' in nm
            symbol=int(re.search(r'^([0-9a-f]+).* _CSPluginStorageLoad$',nm,re.M)[1],16)
            offsets=run('xcrun','otool','-s','__TEXT','__init_offsets',thin)
            first=int(re.search(r'^[0-9a-f]{16}\s+([0-9a-f]{8})',offsets,re.M)[1],16)
            assert first==symbol, (scheme,arch,hex(first),hex(symbol))
            constructors.append({'arch':arch,'uuid':uuid,'firstInitializer':hex(first),'symbol':'CSPluginStorageLoad'})
        result=publish(package)
        result.update(scheme=scheme,version=version,architecture=package_arch,dylibSHA256=sha(dylib),constructors=constructors,cleanupHooksAbsent=True,testShimsAbsent=True,backgroundPrivacyFixPresent=True)
        results.append(result)
with tempfile.TemporaryDirectory(prefix='wechat-background-privacy-symbols-') as temporary:
    symbols=pathlib.Path(temporary)/f'com.wechat.improve_{version}_symbols.zip'
    with zipfile.ZipFile(symbols,'w',zipfile.ZIP_DEFLATED) as archive:
        for scheme in ['rootless','rootful']:
            for arch in ['arm64','arm64e']:
                root=build/scheme/'obj'/arch
                for item in sorted((root/'WeChatImprove.dylib.dSYM').rglob('*')):
                    if item.is_file():archive.write(item, str(pathlib.Path(scheme)/arch/item.relative_to(root)))
    results.append(publish(symbols))
(audit/'packages.json').write_text(json.dumps(results,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(results,ensure_ascii=False,indent=2))
