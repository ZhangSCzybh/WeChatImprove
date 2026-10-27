#!/usr/bin/env python3
"""Check isolated build artifacts before copying versioned deliverables into packages/."""
import hashlib,json,pathlib,re,shutil,subprocess,tempfile,zipfile
repo=pathlib.Path(__file__).resolve().parents[3]
audit=pathlib.Path(__file__).resolve().parent
environment=json.loads((audit/'build-environment.json').read_text())
build=pathlib.Path(environment['buildRoot'])
version=re.search(r'^Version: (.+)$',(repo/'control').read_text(),re.M)[1]
assert version=='2.0-17'
def run(*args):return subprocess.check_output([str(x) for x in args],text=True)
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def publish(path):
    target=repo/'packages'/path.name
    if target.exists():
        assert sha(path)==sha(target),f'refuse to overwrite unrelated {target}'
    else:shutil.copy2(path,target)
    return {'path':str(target.relative_to(repo)),'bytes':target.stat().st_size,'sha256':sha(target)}
for name,digest in environment['previousPackagesSHA256'].items():assert sha(repo/'packages'/name)==digest
for name,digest in json.loads((audit/'preserved-files.json').read_text()).items():assert sha(repo/name)==digest,name
tree=json.loads((audit/'preserved-tree.json').read_text())
names=set(run('git','-C',repo,'ls-files','-co','--exclude-standard','-z').split('\0'))
current={name:sha(repo/name) for name in sorted(names) if name and (repo/name).is_file() and name not in tree['authorizedChanges'] and not any(name.startswith(prefix) for prefix in tree['excludedNewPaths'])}
assert len(current)==tree['count']
assert hashlib.sha256(json.dumps(current,sort_keys=True,separators=(',',':')).encode()).hexdigest()==tree['sha256'],'Preserved checkout changed'

results=[]
for scheme,package_arch,prefix in [('rootful','iphoneos-arm',''),('rootless','iphoneos-arm64','var/jb/')]:
    package=build/'packages'/f'com.wechat.improve_{version}_{package_arch}.deb'
    assert run('dpkg-deb','-f',package,'Version').strip()==version
    assert run('dpkg-deb','-f',package,'Architecture').strip()==package_arch
    with tempfile.TemporaryDirectory(prefix='wechat-chatgroup-picker-package-') as temp:
        extracted=pathlib.Path(temp);subprocess.run(['dpkg-deb','-x',str(package),temp],check=True)
        dylib=extracted/(prefix+'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
        assert dylib.is_file() and len(list(extracted.rglob('WeChatImprove.dylib')))==1
        assert set(run('xcrun','lipo','-archs',dylib).split())=={'arm64','arm64e'}
        payload=dylib.read_bytes()
        for symbol in [b'CSChatGroupSettingsViewController',b'CSNativeSettingsFriendPicker',b'CSNativeSettingsGroupPicker',b'contactSelectionValidatorForTab:',b'contactName:belongsToNativeGroups:',b'contactSelectionPolicyChanged:',b'presentContactSelectWithType:tab:tagName:',b'canPresentTargetPicker',b'finishTargetSheet:groups:',version.encode()]:assert symbol in payload,symbol
        for symbol in [b'GroupPickerDefaults',b'GroupPickerTable',b'TestPickerTransition',b'TestPickerPrivacy']:assert symbol not in payload,symbol
        uuids=run('xcrun','dwarfdump','--uuid',dylib);slices=[]
        for arch in ['arm64','arm64e']:
            dsym=build/scheme/'obj'/arch/'WeChatImprove.dylib.dSYM'
            uuid=re.search(r'UUID: ([A-F0-9-]+)',run('xcrun','dwarfdump','--uuid',dsym))[1]
            assert f'{uuid} ({arch})' in uuids
            nm=run('xcrun','nm','-nm',dsym/'Contents/Resources/DWARF/WeChatImprove.dylib')
            for symbol in ['CSNativeContactPickerPresent','-[CSChatGroupSettingsViewController contactSelectionValidatorForTab:]','-[CSChatGroupSettingsViewController contactName:belongsToNativeGroups:]','-[CSChatGroupSettingsViewController contactSelectionPolicyChanged:]','-[CSChatGroupSettingsViewController presentContactSelectWithType:tab:tagName:]','-[CSScheduledTaskEditor canPresentTargetPicker]','-[CSScheduledTaskEditor finishTargetSheet:groups:]']:assert symbol in nm,symbol
            first_symbol=int(re.search(r'^([0-9a-f]+).* _CSPluginStorageLoad$',nm,re.M)[1],16)
            thin=extracted/(arch+'.dylib');subprocess.run(['xcrun','lipo',str(dylib),'-thin',arch,'-output',str(thin)],check=True)
            offsets=run('xcrun','otool','-s','__TEXT','__init_offsets',thin)
            first=int(re.search(r'^[0-9a-f]{16}\s+([0-9a-f]{8})',offsets,re.M)[1],16)
            assert first==first_symbol
            slices.append({'arch':arch,'uuid':uuid,'firstInitializer':'CSPluginStorageLoad'})
        entry=publish(package);entry.update(scheme=scheme,version=version,architecture=package_arch,dylibSHA256=sha(dylib),slices=slices,newFeaturesPresent=True,testDoublesAbsent=True)
        results.append(entry)
with tempfile.TemporaryDirectory(prefix='wechat-chatgroup-picker-symbols-') as temp:
    symbols=pathlib.Path(temp)/f'com.wechat.improve_{version}_symbols.zip'
    with zipfile.ZipFile(symbols,'w',zipfile.ZIP_DEFLATED) as archive:
        for scheme in ['rootful','rootless']:
            for arch in ['arm64','arm64e']:
                root=build/scheme/'obj'/arch
                for item in sorted((root/'WeChatImprove.dylib.dSYM').rglob('*')):
                    if item.is_file():archive.write(item,str(pathlib.Path(scheme)/arch/item.relative_to(root)))
    results.append(publish(symbols))
source_files=[p for folder in ['Controllers','Headers','Hooks','Tests'] for p in (repo/folder).rglob('*') if p.is_file()]+[repo/'control',repo/'Makefile']
(audit/'source-sha256.json').write_text(json.dumps({str(p.relative_to(repo)):sha(p) for p in sorted(source_files)},ensure_ascii=False,indent=2)+'\n')
(audit/'packages.json').write_text(json.dumps(results,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(results,ensure_ascii=False,indent=2))
