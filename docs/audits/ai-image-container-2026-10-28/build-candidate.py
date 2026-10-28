import hashlib, json, pathlib, re, shutil, subprocess, tempfile, zipfile
root=pathlib.Path.cwd()
audit=root/'docs/audits/ai-image-container-2026-10-28'
build=pathlib.Path('/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-image-container-vsha_ktr')
def digest(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()
def dump(name,value): (audit/name).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
def run(args): return subprocess.check_output(args,text=True).strip()
def source_hashes():
    paths=[root/'Makefile',root/'control',root/'WeChatImprove.plist']
    for folder in ('Controllers','Headers','Hooks'):
        paths.extend(p for p in (root/folder).rglob('*') if p.is_file() and p.suffix in ('.m','.h','.xm','.mm','.x'))
    return {str(p.relative_to(root)):digest(p) for p in sorted(paths)}
protected=json.loads((audit/'protected-artifacts-before.json').read_text())
assert all((root/k).is_file() and digest(root/k)==v for k,v in protected.items()), 'Existing artifact changed before build'
assert 'Version: 2.1-4\n' in (root/'control').read_text()
assert '#define kPluginVersionString @"2.1-4"' in (root/'Headers/CSUserInfoHelper.h').read_text()
assert '@"2.1-4": @[' in (root/'Controllers/CSReleaseNotesViewController.m').read_text()
source=source_hashes()
dump('source-sha256.json',source)
# Preserve the original pre-implementation manifest.
commands={}
for scheme in ('rootless','rootful'):
    commands[scheme]=['make','-j4','package','SCHEME='+scheme,'PACKAGE_VERSION=2.1-4','_THEOS_LOCAL_DATA_DIR='+str(build/scheme),'THEOS_BUILD_DIR='+str(build/(scheme+'-build')),'THEOS_PACKAGE_DIR='+str(build/'packages'),'COLOR=0']
dump('build-environment.json',{'workspace':str(root),'buildRoot':str(build),'branch':run(['git','branch','--show-current']),'baseCommit':run(['git','rev-parse','HEAD']),'version':'2.1-4','commands':commands})
print('Build root:',build,flush=True)
for scheme,args in commands.items():
    print('Building',scheme,flush=True)
    with (audit/('build-'+scheme+'.log')).open('w') as log:
        status=subprocess.run(args,stdout=log,stderr=subprocess.STDOUT).returncode
    if status:
        print((audit/('build-'+scheme+'.log')).read_text()[-8000:],flush=True)
        raise SystemExit(status)
    print('Built',scheme,flush=True)
source_after=source_hashes()
changed=[k for k in set(source)|set(source_after) if source.get(k)!=source_after.get(k)]
assert not changed, ('Sources changed during build',changed)
assert all((root/k).is_file() and digest(root/k)==v for k,v in protected.items()), 'Existing artifact changed'
delivery=root/'packages/2.1-4-image-format-fix'
assert not delivery.exists(), 'Delivery directory already exists; refusing to overwrite'
records=[]
for scheme,arch,rel in (('rootless','iphoneos-arm64','var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib'),('rootful','iphoneos-arm','Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')):
    package=build/'packages'/('com.wechat.improve_2.1-4_'+arch+'.deb')
    assert package.is_file(), str(package)
    assert run(['dpkg-deb','-f',str(package),'Version'])=='2.1-4'
    assert run(['dpkg-deb','-f',str(package),'Architecture'])==arch
    extract=build/('verify-'+scheme)
    subprocess.run(['dpkg-deb','-x',str(package),str(extract)],check=True)
    library=extract/rel
    assert library.is_file()
    archs=run(['xcrun','lipo','-archs',str(library)])
    assert set(archs.split())=={'arm64','arm64e'}
    uuids={a:u for u,a in re.findall(r'UUID: ([A-F0-9-]+) \(([^)]+)\)',run(['xcrun','dwarfdump','--uuid',str(library)]))}
    symbols=[]
    for a in ('arm64','arm64e'):
        thin=build/(scheme+'-'+a+'.dylib')
        subprocess.run(['xcrun','lipo',str(library),'-thin',a,'-output',str(thin)],check=True)
        binary=thin.read_bytes()
        for token in (b'CSAIBackgroundSync',b'BackGroundFetchToSync',b'isGettingData',b'backgroundAudioActive',b'allowUnmentioned',b'CSAIImagePreparer',b'imageEnabled',b'searchMode',b'enable_search',b'enable_thinking',b'text/event-stream',b'image_url',b'forced_search',b'CSListCornerSessionRestore',b'2.1-4'):
            assert token in binary, (scheme,a,token)
        matches=list((build/scheme/'obj'/a).rglob('WeChatImprove.dylib.dSYM'))
        assert len(matches)==1, matches
        dsym=matches[0]
        symbol_uuids={aa:u for u,aa in re.findall(r'UUID: ([A-F0-9-]+) \(([^)]+)\)',run(['xcrun','dwarfdump','--uuid',str(dsym)]))}
        assert symbol_uuids.get(a)==uuids.get(a), (scheme,a,symbol_uuids,uuids)
        for removed in (b'CSAuthorizationStatus',b'CSLastAuthorizationCheckTime',b'clearAuthorizationCache'):
            assert removed not in binary, (scheme,a,removed)
        symbols.append((a,dsym))
    records.append({'scheme':scheme,'version':'2.1-4','architecture':arch,'installPath':rel,'archs':archs,'uuids':uuids,'featureTokensVerified':True,'package':package,'symbols':symbols})
# Verify everything before adding a distinct delivery directory; original releases remain intact.
delivery.mkdir()
package_records=[]
for row in records:
    p=delivery/row['package'].name
    shutil.copy2(row['package'],p)
    package_records.append({'path':str(p.relative_to(root)),'sha256':digest(p),'bytes':p.stat().st_size})
zpath=delivery/'com.wechat.improve_2.1-4_symbols.zip'
with zipfile.ZipFile(zpath,'w',zipfile.ZIP_DEFLATED) as archive:
    for row in records:
        for a,dsym in row['symbols']:
            for p in sorted(dsym.rglob('*')):
                if p.is_file(): archive.write(p,str(pathlib.Path(row['scheme'])/a/dsym.name/p.relative_to(dsym)))
with zipfile.ZipFile(zpath) as archive: assert archive.testzip() is None
package_records.append({'path':str(zpath.relative_to(root)),'sha256':digest(zpath),'bytes':zpath.stat().st_size})
assert all((root/k).is_file() and digest(root/k)==v for k,v in protected.items()), 'Existing artifact changed after delivery'
dump('packages.json',package_records)
for row in records:
    row.pop('package'); row.pop('symbols')
dump('delivery-verification.json',{'packages':records,'symbolsArchiveVerified':True,'protectedArtifactCount':len(protected),'changedExistingArtifacts':[],'sourceChangesDuringBuild':changed,'deviceInstalled':False})
(delivery/'SHA256SUMS.txt').write_text(''.join(row['sha256']+'  '+pathlib.Path(row['path']).name+'\n' for row in package_records))
print(json.dumps(package_records,ensure_ascii=False,indent=2),flush=True)
