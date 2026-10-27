#!/usr/bin/env python3
"""Check isolated build artifacts before copying versioned deliverables into packages/."""
import hashlib,json,pathlib,re,shutil,subprocess,tempfile,zipfile
repo=pathlib.Path(__file__).resolve().parents[3]
audit=pathlib.Path(__file__).resolve().parent
environment=json.loads((audit/'build-environment.json').read_text())
build=pathlib.Path(environment['buildRoot'])
version=re.search(r'^Version: (.+)$',(repo/'control').read_text(),re.M)[1]
assert version=='2.0-20'
def run(*args):return subprocess.check_output([str(x) for x in args],text=True)
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def publish(path):
    target=repo/'packages'/path.name
    if target.exists():
        assert sha(path)==sha(target),f'refuse to overwrite unrelated {target}'
    else:shutil.copy2(path,target)
    return {'path':str(target.relative_to(repo)),'bytes':target.stat().st_size,'sha256':sha(target)}
for name,digest in environment['previousPackagesSHA256'].items():assert sha(repo/'packages'/name)==digest
authorized={
    'Controllers/CSCloseFriendSessionPresentation.m',
    'Controllers/CSGroupListAdapter.h', 'Controllers/CSGroupListAdapter.m',
    'Controllers/CSListCornerPageContext.h', 'Controllers/CSListCornerPageContext.m',
    'Controllers/CSListCornerSessionAdapter.h', 'Controllers/CSListCornerSessionAdapter.m',
    'Hooks/ListCornerRadiusHooks.xm',
    'Tests/CloseFriendSessionPresentationTests.m', 'Tests/FoldedCardIntegrationTests.h',
    'Tests/ListCornerSemanticsTests.m', 'Tests/extract-list-corners.py', 'Tests/verify-list-corners.sh',
    'Tests/ListCornerUIKit/ListCornerUIKit.m', 'Tests/ListCornerUIKit/UIKit/UIKit.h',
    'Controllers/CSReleaseNotesViewController.m', 'Headers/CSUserInfoHelper.h',
    'README.md', 'control', 'docs/session-groups.md'
}
baseline=json.loads(pathlib.Path(environment['baseline']).read_text())
changed=[]
for name,digest in baseline.items():
    assert (repo/name).is_file(), f'preexisting file removed: {name}'
    if sha(repo/name)!=digest:
        assert name in authorized,f'unrelated preexisting file changed: {name}'
        changed.append(name)
names=set(run('git','-C',repo,'ls-files','-co','--exclude-standard','-z').split('\0'))
new=[name for name in names if name and name not in baseline and (repo/name).is_file()]
# These feedback files appeared outside this change after the baseline was taken.
# Preserve them byte-for-byte; they are not implementation instructions for this build.
concurrent_feedback={
    'docs/feedbacks/2026-10-27-revert-scope-supplement.txt':'85eb44b451178e2cadf0c932a5ec1500a3e8d32cb51a404f1efbd4aa0a1fd1dc',
    'docs/feedbacks/2026-10-27-revert-to-2.0-18-request.txt':'738edb61d43f3b3b9ea5a20fb92654c0a711c24813d58ecb077d911659228e9a'
}
for name,digest in concurrent_feedback.items():assert sha(repo/name)==digest
for name in new:
    assert name in authorized or name in concurrent_feedback or name.startswith('docs/audits/folded-card-style-2.0-20/') or name in {
        'packages/com.wechat.improve_2.0-20_iphoneos-arm.deb','packages/com.wechat.improve_2.0-20_iphoneos-arm64.deb','packages/com.wechat.improve_2.0-20_symbols.zip'
    },f'unexpected new file: {name}'
(audit/'preservation.json').write_text(json.dumps({'baselineFiles':len(baseline),'baselineSHA256':sha(pathlib.Path(environment['baseline'])),
    'changedAuthorizedFiles':sorted(changed),'allOtherPreexistingFilesUnchanged':True,'deletedPreexistingFiles':[],
    'concurrentFeedbackPreservedSHA256':concurrent_feedback},ensure_ascii=False,indent=2)+'\n')

results=[]
for scheme,package_arch,prefix in [('rootful','iphoneos-arm',''),('rootless','iphoneos-arm64','var/jb/')]:
    package=build/'packages'/f'com.wechat.improve_{version}_{package_arch}.deb'
    assert run('dpkg-deb','-f',package,'Version').strip()==version
    assert run('dpkg-deb','-f',package,'Architecture').strip()==package_arch
    with tempfile.TemporaryDirectory(prefix='wechat-folded-card-style-package-') as temp:
        extracted=pathlib.Path(temp);subprocess.run(['dpkg-deb','-x',str(package),temp],check=True)
        dylib=extracted/(prefix+'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
        assert dylib.is_file() and len(list(extracted.rglob('WeChatImprove.dylib')))==1
        assert set(run('xcrun','lipo','-archs',dylib).split())=={'arm64','arm64e'}
        payload=dylib.read_bytes()
        for symbol in [b'CSCloseFriendSessionCover',b'summaryLabel',b'foldedEntryScoped',b'foldedEntryCount',b'm_frameHeadView',b'm_messageLabel',b'backgroundForStyle:',b'renderFirst:last:separated:',b'CSListCornerSessionState',version.encode()]:assert symbol in payload,symbol
        for symbol in [b'FoldedCardIntegrationTests',b'HookSessionRowHeight',b'CardProjection',b'NativeFoldedLayoutTests',b'SessionViewportTests',b'HookMainFrameItemLayout',b'GroupPickerDefaults',b'TestPickerTransition',b'TestFoldedSource']:assert symbol not in payload,symbol
        uuids=run('xcrun','dwarfdump','--uuid',dylib);slices=[]
        for arch in ['arm64','arm64e']:
            dsym=build/scheme/'obj'/arch/'WeChatImprove.dylib.dSYM'
            uuid=re.search(r'UUID: ([A-F0-9-]+)',run('xcrun','dwarfdump','--uuid',dsym))[1]
            assert f'{uuid} ({arch})' in uuids
            nm=run('xcrun','nm','-nm',dsym/'Contents/Resources/DWARF/WeChatImprove.dylib')
            for symbol in ['CSListCornerRemoveSessionAppearance','CSListCornerSessionRowHeight','CSGroupCardPosition','renderFirst:last:separated:','NewMainFrameCell$prepareForReuse','CSCloseFriendUpdateSessionCover','CSCloseFriendRefreshSessionCover','CSListCornerPrepareTable','MainFrameItemView$layoutSubviews','NewMainFrameViewController$viewDidLayoutSubviews']:assert symbol in nm,symbol
            first_symbol=int(re.search(r'^([0-9a-f]+).* _CSPluginStorageLoad$',nm,re.M)[1],16)
            thin=extracted/(arch+'.dylib');subprocess.run(['xcrun','lipo',str(dylib),'-thin',arch,'-output',str(thin)],check=True)
            offsets=run('xcrun','otool','-s','__TEXT','__init_offsets',thin)
            first=int(re.search(r'^[0-9a-f]{16}\s+([0-9a-f]{8})',offsets,re.M)[1],16)
            assert first==first_symbol
            slices.append({'arch':arch,'uuid':uuid,'firstInitializer':'CSPluginStorageLoad'})
        entry=publish(package);entry.update(scheme=scheme,version=version,architecture=package_arch,dylibSHA256=sha(dylib),slices=slices,newFeaturesPresent=True,testDoublesAbsent=True)
        results.append(entry)
with tempfile.TemporaryDirectory(prefix='wechat-folded-card-style-symbols-') as temp:
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
