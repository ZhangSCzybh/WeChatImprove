#!/usr/bin/env python3
"""Verify isolated 2.0-24 builds and preserve every preexisting delivery/audit."""
import collections,difflib,hashlib,json,os,pathlib,re,subprocess,tempfile,zipfile
repo=pathlib.Path(__file__).resolve().parents[3]
audit=pathlib.Path(__file__).resolve().parent
env=json.loads((audit/'build-environment.json').read_text())
build=pathlib.Path(env['buildRoot'])
baseline=json.loads((audit/'workspace-before-sha256.json').read_text())
restore_zip=audit/'source-before-2.0-24.zip'
version='2.0-24'
# This feedback file appeared independently after the starting inventory. It is
# preserved verbatim and is not production source or an instruction for 23b.
external_additions={}
def run(*args):return subprocess.check_output([str(x) for x in args],text=True)
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def write(name,value):(audit/name).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
def inventory():
    result={}
    for base,dirs,files in os.walk(repo):
        dirs[:]=[d for d in dirs if d!='.git' and pathlib.Path(base,d)!=audit]
        for name in files:
            p=pathlib.Path(base,name)
            if p.is_file():result[str(p.relative_to(repo))]=sha(p)
    return result
assert f'Version: {version}\n' in (repo/'control').read_text()
assert f'kPluginVersionString @"{version}"' in (repo/'Headers/CSUserInfoHelper.h').read_text()
assert f'@"{version}": @[' in (repo/'Controllers/CSReleaseNotesViewController.m').read_text()
with zipfile.ZipFile(restore_zip) as z:
    authorized={
        'Controllers/CSGroupNativeBridge.m','Controllers/CSCloseFriendSessionPresentation.m',
        'Controllers/CSGroupProjection.h','Controllers/CSGroupProjection.m','Controllers/CSGroupListAdapter.m',
        'Controllers/CSReleaseNotesViewController.m','Headers/CSUserInfoHelper.h','control','README.md','docs/session-groups.md',
        'Tests/CloseFriendSessionTests.m','Tests/FoldedSummaryTests.h','Tests/FoldedEntryVisualTests.h','Tests/CloseFriendSessionPresentationTests.m','Tests/ListCornerSemanticsTests.m','Tests/FoldedCardIntegrationTests.h','Tests/FoldedSummaryFixtures.h','Tests/FoldedNativeRendererFixture.h'}
    diffs=[];changes=[]
    for name in z.namelist():
        before=z.read(name);after=(repo/name).read_bytes()
        if before!=after:
            changes.append({'path':name,'baseline23bSHA256':hashlib.sha256(before).hexdigest(),'release24SHA256':hashlib.sha256(after).hexdigest()})
            diffs.extend(difflib.unified_diff(before.decode().splitlines(True),after.decode().splitlines(True),fromfile='2.0-23b/'+name,tofile='2.0-24/'+name))
(audit/'changes-from-2.0-23b.diff').write_text(''.join(diffs))
write('changes-from-2.0-23b.json',changes)
current=inventory()
changed=[n for n,h in baseline.items() if current.get(n)!=h]
assert all(n in authorized for n in changed),[n for n in changed if n not in authorized]
assert all(n in current for n in baseline),'preexisting file deleted'
new=[n for n in current if n not in baseline]
assert all(current.get(n)==h for n,h in external_additions.items()),external_additions
assert all(n in authorized or n in external_additions for n in new),new
# The input package set and all historical audits/build artifacts must remain byte-identical.
for prefix in ['packages/','docs/audits/','.theos/']:
    assert all(current[n]==h for n,h in baseline.items() if n.startswith(prefix)),prefix
warnings=[];warning_log_repairs=[]
for scheme in ['rootful','rootless']:
    def read_warnings(path):
        text=re.sub(r'\x1b\[[0-9;]*m','',path.read_text())
        assert not re.search(r'\berror:',text),path
        # Exact observed stdout interleaving: "sharedApplication" was split by
        # the other architecture's diagnostic. Keep the raw log unchanged and
        # normalize only this proven source-text fragment, not arbitrary warnings.
        interleaved="warning: tion'openURL:' is deprecated: first deprecated in iOS 10.0 [-Wdeprecated-declarations]"
        if interleaved in text:
            assert path==audit/'logs'/'build-rootless.log' and text.count(interleaved)==1
            assert 'sharedApplicaControllers/CSAuthorizationManager.m:243:48: '+interleaved in text
            warning_log_repairs.append({'path':str(path.relative_to(repo)),'raw':interleaved,'removedInterleavedSourceFragment':'tion','occurrences':1})
            text=text.replace(interleaved,interleaved.replace('warning: tion','warning: '))
        # Parallel clang output can interleave duplicate prefixes and filenames.
        # Match the complete diagnostic through its warning category, preserve
        # the number of warning prefixes, and account for every occurrence.
        values=[]
        for m in re.finditer(r'((?:warning:\s*)+)([^\n]*?\[-W[^\]]+\]|[^\n]+)',text):
            values += ['warning: '+m[2].strip()] * m[1].count('warning:')
        assert len(values)==text.count('warning:'),(path,values)
        return values
    actual=read_warnings(audit/'logs'/f'build-{scheme}.log')
    previous=next(v['warnings'] for v in json.loads((repo/'docs/audits/folded-digest-no-time-gate-2.0-23b/build-verification.json').read_text()) if v['scheme']==scheme)
    added=list((collections.Counter(actual)-collections.Counter(previous)).elements())
    assert not added,added
    warnings.append({'scheme':scheme,'warningCount':len(actual),'historicalWarningCount':len(previous),'newWarnings':added,'warnings':actual})
write('build-verification.json',warnings)
write('warning-log-normalization.json',warning_log_repairs)
results=[];deliveries=[]
for scheme,architecture,prefix in [('rootful','iphoneos-arm',''),('rootless','iphoneos-arm64','var/jb/')]:
    package=build/'packages'/f'com.wechat.improve_{version}_{architecture}.deb'
    assert run('dpkg-deb','-f',package,'Version').strip()==version
    assert run('dpkg-deb','-f',package,'Architecture').strip()==architecture
    with tempfile.TemporaryDirectory(prefix='wechat-summary23b-package-') as temp:
        extracted=pathlib.Path(temp);subprocess.run(['dpkg-deb','-x',str(package),temp],check=True)
        dylib=extracted/(prefix+'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
        assert dylib.is_file() and len(list(extracted.rglob('WeChatImprove.dylib')))==1
        assert set(run('xcrun','lipo','-archs',dylib).split())=={'arm64','arm64e'}
        payload=dylib.read_bytes()
        for symbol in [b'CSCloseFriendSessionCover',b'summaryLabel',b'foldedEntryCount',b'foldedEntrySummary',b'foldedEntrySummaryUserName',b'nativeSummary',b'nativeSortTime',b'getCellDataByUsrName:',b'digestForMsg:withSender:',b'm_prefixTextForQuoteMessage',b'makeTextForQuoteMessage',b'quoteMessageLable:prefixText:',b'foldedEntryPrefix',b'nativeSummarySource',b'source=%@',b'CSFoldedDigestSessionInfo',b'nativeSummaryReason',b'[WeChatImprove][FoldedDigest]',b'setLineBreakMode:',b'renderFirst:last:',b'CSListCornerSessionState',version.encode()]:assert symbol in payload,symbol
        for symbol in [b'no_sort_time',b'FoldedNativeRendererFixture',b'fixtureDisplayName',b'fixtureChatName',b'fixtureSessionTime',b'missingAuxSortGetters',b'fixtureDigest',b'lastFormattedMessage',b'WrongCellDataGetter',b'renderFirst:last:separated:',b'RunFoldedSummaryTests',b'SummaryFixtureRow',b'FoldedCardIntegrationTests',b'FoldedContinuousSectionTests',b'HookSessionRowHeight',b'CardProjection',b'NativeFoldedLayoutTests',b'SessionViewportTests',b'HookMainFrameItemLayout',b'GroupPickerDefaults',b'TestPickerTransition',b'TestFoldedSource']:assert symbol not in payload,symbol
        uuids=run('xcrun','dwarfdump','--uuid',dylib);slices=[]
        for arch in ['arm64','arm64e']:
            dsym=build/scheme/'obj'/arch/'WeChatImprove.dylib.dSYM'
            uuid=re.search(r'UUID: ([A-F0-9-]+)',run('xcrun','dwarfdump','--uuid',dsym))[1]
            assert f'{uuid} ({arch})' in uuids
            nm=run('xcrun','nm','-nm',dsym/'Contents/Resources/DWARF/WeChatImprove.dylib')
            for symbol in ['CSListCornerRemoveSessionAppearance','CSGroupCardPosition','renderFirst:last:','NewMainFrameCell$prepareForReuse','CSCloseFriendUpdateSessionCover','CSCloseFriendRefreshSessionCover','MainFrameItemView$layoutSubviews','NewMainFrameViewController$viewDidLayoutSubviews']:assert symbol in nm,symbol
            for symbol in ['CSListCornerSessionRowHeight','renderFirst:last:separated:','ListCornerRadiusHooks_xm$_ungrouped$NewMainFrameViewController$tableView$heightForRowAtIndexPath$']:assert symbol not in nm,symbol
            first_symbol=int(re.search(r'^([0-9a-f]+).* _CSPluginStorageLoad$',nm,re.M)[1],16)
            thin=extracted/(arch+'.dylib');subprocess.run(['xcrun','lipo',str(dylib),'-thin',arch,'-output',str(thin)],check=True)
            offsets=run('xcrun','otool','-s','__TEXT','__init_offsets',thin)
            first=int(re.search(r'^[0-9a-f]{16}\s+([0-9a-f]{8})',offsets,re.M)[1],16)
            assert first==first_symbol
            slices.append({'arch':arch,'uuid':uuid,'firstInitializer':'CSPluginStorageLoad'})
        results.append({'path':'packages/'+package.name,'bytes':package.stat().st_size,'sha256':sha(package),'scheme':scheme,'version':version,'architecture':architecture,'dylibSHA256':sha(dylib),'slices':slices,'removedSpacingHookAbsent':True,'testDoublesAbsent':True})
        deliveries.append(package)
symbols=build/'packages'/f'com.wechat.improve_{version}_symbols.zip'
assert not symbols.exists(),symbols
with zipfile.ZipFile(symbols,'w',zipfile.ZIP_DEFLATED) as archive:
    for scheme in ['rootful','rootless']:
        for arch in ['arm64','arm64e']:
            root=build/scheme/'obj'/arch
            for item in sorted((root/'WeChatImprove.dylib.dSYM').rglob('*')):
                if item.is_file():archive.write(item,str(pathlib.Path(scheme)/arch/item.relative_to(root)))
results.append({'path':'packages/'+symbols.name,'bytes':symbols.stat().st_size,'sha256':sha(symbols)})
deliveries.append(symbols)
# Publication is additive. Never replace even an identically named historical file.
for source in deliveries:assert not (repo/'packages'/source.name).exists()
for source in deliveries:
    with (repo/'packages'/source.name).open('xb') as out:out.write(source.read_bytes())
for item in results:assert sha(repo/item['path'])==item['sha256']
final=inventory()
assert all(final[n]==h for n,h in current.items())
assert set(final)-set(current)=={i['path'] for i in results}
write('preservation.json',{'preexistingFiles':len(baseline),'changedAuthorizedFiles':changed,'addedSourceFiles':[n for n in new if n not in external_additions],'independentlyAddedFeedbackPreserved':external_additions,'deletedPreexistingFiles':[],'packagesPreserved':sum(n.startswith('packages/') for n in baseline),'historicalAuditFilesPreserved':sum(n.startswith('docs/audits/') for n in baseline),'workspaceTheosFilesPreserved':sum(n.startswith('.theos/') for n in baseline),'allOtherPreexistingFilesUnchanged':True,'onlyAddedPackages':[i['path'] for i in results]})
write('packages.json',results)
source_files=[p for folder in ['Controllers','Headers','Hooks','Tests'] for p in (repo/folder).rglob('*') if p.is_file()]+[repo/'control',repo/'Makefile']
write('source-sha256.json',{str(p.relative_to(repo)):sha(p) for p in sorted(source_files)})
print(json.dumps({'packages':results,'warnings':warnings,'changedSince23b':len(changes),'preservedOldPackages':sum(n.startswith('packages/') for n in baseline)},ensure_ascii=False,indent=2))
