#!/usr/bin/env python3
"""Verify isolated builds, then add uniquely named delivery files; never overwrite history."""
from pathlib import Path
import collections,difflib,hashlib,json,re,subprocess,tempfile,zipfile
repo=Path(__file__).resolve().parents[3];audit=Path(__file__).parent
build=Path(json.loads((audit/'build-environment.json').read_text())['buildRoot'])
version='2.1-3'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(*args):return subprocess.check_output([str(x) for x in args],text=True)
def write(n,v):(audit/n).write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
protected=json.loads((audit/'protected-before.json').read_text())
assert all((repo/p).is_file() and sha(repo/p)==h for p,h in protected.items()),'historical artifact changed'
inputs=json.loads((audit/'source-sha256.json').read_text())
assert all(sha(repo/p)==h for p,h in inputs.items()),'compiled input changed after build'
assert 'Version: '+version+'\n' in (repo/'control').read_text()
assert 'kPluginVersionString @"'+version+'"' in (repo/'Headers/CSUserInfoHelper.h').read_text()
assert '@"'+version+'": @[' in (repo/'Controllers/CSReleaseNotesViewController.m').read_text()
allowed={'Controllers/CSListCornerPageContext.h','Controllers/CSListCornerPageContext.m','Controllers/CSListCornerSessionRestore.h','Controllers/CSListCornerSessionRestore.m','Hooks/ListCornerRadiusHooks.xm','Tests/ListCornerSemanticsTests.m','Tests/ListRestoreTests.h','Tests/ListCornerUIKit/UIKit/UIKit.h','Tests/ListCornerUIKit/ListCornerUIKit.m','Tests/extract-list-corners.py','Tests/verify-list-corners.sh','Controllers/CSReleaseNotesViewController.m','Headers/CSUserInfoHelper.h','control','README.md','docs/list-corners.md'}
source_before=json.loads((audit/'source-before-sha256.json').read_text())
changed=[p for p,h in source_before.items() if sha(repo/p)!=h]
assert set(changed)<=allowed,changed
added=[str(p.relative_to(repo)) for folder in ['Controllers','Headers','Hooks','Tests'] for p in (repo/folder).rglob('*') if p.is_file() and str(p.relative_to(repo)) not in source_before]
assert set(added)<=allowed,added
with zipfile.ZipFile(audit/'source-before.zip') as z:
 diff=[]
 for p in changed:
  diff.extend(difflib.unified_diff(z.read(p).decode().splitlines(True),(repo/p).read_text().splitlines(True),fromfile='2.1-2-muted-background/'+p,tofile=version+'/'+p))
 for p in added:diff.extend(difflib.unified_diff([], (repo/p).read_text().splitlines(True),fromfile='/dev/null',tofile=version+'/'+p))
(audit/'changes.diff').write_text(''.join(diff));write('changes.json',{'changed':changed,'added':added})
def warnings(path):
 text=re.sub(r'\x1b\[[0-9;]*m','',path.read_text())
 assert not re.search(r'\berror:',text),path
 values=re.findall(r'warning:\s*([^\n]+)',text)
 assert len(values)==text.count('warning:'),(path,values)
 return values
checks=[]
for scheme in ['rootful','rootless']:
 base=warnings(repo/'docs/audits/ai-muted-background-2.1-2'/('build-'+scheme+'.log'))
 full=warnings(audit/('build-'+scheme+'.log'));final=warnings(audit/('build-'+scheme+'-final.log'))
 assert not (collections.Counter(full)-collections.Counter(base)),full
 assert not (collections.Counter(final)-collections.Counter(base)),final
 checks.append({'scheme':scheme,'initialFullBuildWarnings':len(full),'finalIncrementalWarnings':len(final),'baselineWarnings':len(base),'newWarnings':[],'errors':0,'fullWarnings':full,'finalWarnings':final})
write('build-verification.json',checks)
log=(audit/'green-list-corners.log').read_text();assert '1357 checks, 0 failures' in log
reasons=re.findall(r'\[WeChatImprove\]\[ListRestore\] (stage=\w+ reason=\w+)',log)
assert len(reasons)==len(set(reasons)) and len(reasons)<=48,reasons
assert all(any('reason='+r in s for s in reasons) for r in ['restore_trigger_missing','native_overwrite','geometry_not_ready'])
write('regression.json',{'script':'Tests/verify-list-corners.sh','oldCodeChecks':1349,'oldCodeFailures':167,'displayInvalidationChecks':1357,'displayInvalidationFailures':3,'finalChecks':1357,'finalFailures':0,'newChecks':341,'diagnosticLines':len(reasons),'diagnosticsDeduplicated':True,'deviceExecution':False})
packages=[];deliveries=[]
for scheme,arch,prefix in [('rootful','iphoneos-arm',''),('rootless','iphoneos-arm64','var/jb/')]:
 package=build/'packages'/f'com.wechat.improve_{version}_{arch}.deb'
 assert run('dpkg-deb','-f',package,'Version').strip()==version
 assert run('dpkg-deb','-f',package,'Architecture').strip()==arch
 with tempfile.TemporaryDirectory(prefix='wechat-list-restore-verify-') as tmp:
  extracted=Path(tmp);subprocess.run(['dpkg-deb','-x',str(package),tmp],check=True)
  dylib=extracted/(prefix+'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
  assert dylib.is_file() and len(list(extracted.rglob('WeChatImprove.dylib')))==1
  assert set(run('xcrun','lipo','-archs',dylib).split())=={'arm64','arm64e'}
  payload=dylib.read_bytes()
  for symbol in [b'CSListCornerSessionRestore',b'CSListCornerSessionGap',b'[WeChatImprove][ListRestore]',b'geometry_not_ready',b'restore_trigger_missing',b'native_overwrite',b'com.wechat.improve.listRestoreDiagnostics',version.encode()]:assert symbol in payload,symbol
  for symbol in [b'RestoreHookedTable',b'SessionLifecycleRestoreTests',b'FixtureConfiguration',b'ListRestoreTests',b'SessionRestorePaintTests']:assert symbol not in payload,symbol
  uuids=run('xcrun','dwarfdump','--uuid',dylib);slices=[]
  for cpu in ['arm64','arm64e']:
   dsym=build/scheme/'obj'/cpu/'WeChatImprove.dylib.dSYM'
   uuid=re.search(r'UUID: ([A-F0-9-]+)',run('xcrun','dwarfdump','--uuid',dsym))[1]
   assert f'{uuid} ({cpu})' in uuids
   nm=run('xcrun','nm','-nm',dsym/'Contents/Resources/DWARF/WeChatImprove.dylib')
   for symbol in ['CSListCornerRestoreSessionTable','CSListCornerTrackSessionTable','MainFrameTableView$layoutSubviews','MainFrameTableView$setBackgroundView$','MainFrameTableView$setBackgroundColor$','CSListCornerRefreshSessionGeometry','CSGroupCardPosition']:assert symbol in nm,symbol
   assert 'ListCornerRadiusHooks_xm$_ungrouped$MMTableView$' not in nm
   first_symbol=int(re.search(r'^([0-9a-f]+).* _CSPluginStorageLoad$',nm,re.M)[1],16)
   thin=extracted/(cpu+'.dylib');subprocess.run(['xcrun','lipo',str(dylib),'-thin',cpu,'-output',str(thin)],check=True)
   first=int(re.search(r'^[0-9a-f]{16}\s+([0-9a-f]{8})',run('xcrun','otool','-s','__TEXT','__init_offsets',thin),re.M)[1],16)
   assert first==first_symbol
   slices.append({'arch':cpu,'uuid':uuid,'firstInitializer':'CSPluginStorageLoad'})
  packages.append({'path':'packages/'+package.name,'scheme':scheme,'architecture':arch,'version':version,'bytes':package.stat().st_size,'sha256':sha(package),'dylibSHA256':sha(dylib),'slices':slices,'testDoublesAbsent':True})
 deliveries.append(package)
symbols=build/'packages'/f'com.wechat.improve_{version}_symbols.zip'
assert not symbols.exists()
with zipfile.ZipFile(symbols,'x',zipfile.ZIP_DEFLATED) as archive:
 for scheme in ['rootful','rootless']:
  for cpu in ['arm64','arm64e']:
   base=build/scheme/'obj'/cpu
   for p in sorted((base/'WeChatImprove.dylib.dSYM').rglob('*')):
    if p.is_file():archive.write(p,str(Path(scheme)/cpu/p.relative_to(base)))
packages.append({'path':'packages/'+symbols.name,'bytes':symbols.stat().st_size,'sha256':sha(symbols),'slices':4});deliveries.append(symbols)
for p in deliveries:assert not (repo/'packages'/p.name).exists()
for p in deliveries:
 with (repo/'packages'/p.name).open('xb') as target:target.write(p.read_bytes())
assert all(sha(repo/p)==h for p,h in protected.items())
assert all(sha(repo/p)==h for p,h in inputs.items())
assert all(sha(repo/x['path'])==x['sha256'] for x in packages)
write('packages.json',packages)
write('preservation.json',{'protectedFilesUnchanged':len(protected),'historicalPackagesUnchanged':sum(p.startswith('packages/') for p in protected),'historicalAuditFilesUnchanged':sum(p.startswith('docs/audits/') for p in protected),'workspaceTheosFilesUnchanged':sum(p.startswith('.theos/') for p in protected),'compiledInputsVerified':len(inputs),'changedAuthorizedFiles':changed,'addedAuthorizedFiles':added,'onlyAddedPackages':[x['path'] for x in packages],'deviceInstalled':False})
print(json.dumps({'packages':packages,'preserved':len(protected),'regressionChecks':1357,'newWarnings':0},ensure_ascii=False,indent=2))
