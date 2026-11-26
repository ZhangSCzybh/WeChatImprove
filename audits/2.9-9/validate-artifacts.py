"""Validate only the new 2.9-9 artifacts; never traverse historical packages."""
from pathlib import Path
import io,json,plistlib,re,subprocess,tarfile,zipfile
root=Path(__file__).resolve().parents[2]
task=Path(Path('/tmp/wechat-first-swipe-299-current').read_text().strip())
out=root/'packages/2.9-9'

def run(*args):return subprocess.check_output([str(x) for x in args],text=True)
def uuids(path):return {arch:uuid for uuid,arch in re.findall(r'UUID: ([0-9A-F-]+) \(([^)]+)\)',run('xcrun','dwarfdump','--uuid',path))}
source_plist=plistlib.loads(subprocess.check_output(['plutil','-convert','xml1','-o','-',str(root/'WeChatImprove.plist')]))
report={'version':'2.9-9','diagnostic':True,'macro':'CS_GROUP_FIRST_SWIPE_DIAG=1','schemes':{}}
symbols=[]
for scheme,leaf,architecture,prefix in [('rootful','build-rootful','iphoneos-arm','Library'),('rootless','build-rootless-v2','iphoneos-arm64','var/jb/Library')]:
 deb=out/f'com.wechat.improve_2.9-9_{architecture}.deb'
 fields=dict(line.split(': ',1) for line in run('dpkg-deb','-f',deb).splitlines() if ': ' in line)
 assert fields['Package']=='com.wechat.improve' and fields['Version']=='2.9-9' and fields['Architecture']==architecture
 tarbytes=subprocess.check_output(['dpkg-deb','--fsys-tarfile',str(deb)])
 path=f'{prefix}/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib';plistpath=path[:-6]+'.plist'
 with tarfile.open(fileobj=io.BytesIO(tarbytes),mode='r:*') as tar:
  members={m.name.removeprefix('./'):m for m in tar.getmembers()}
  data=tar.extractfile(members[path]).read();packedplist=tar.extractfile(members[plistpath]).read()
  assert plistlib.loads(packedplist)==source_plist
 binary=task/f'{scheme}-packed.dylib';binary.write_bytes(data)
 ids=uuids(binary);assert set(ids)=={'arm64','arm64e'}
 assert data==(task/leaf/'obj/WeChatImprove.dylib').read_bytes()
 names=run('xcrun','nm','-g',binary)
 assert '_CSFirstSwipeRecord' in names and '_CSFirstSwipeExport' in names
 loads=run('xcrun','otool','-arch','arm64e','-l',binary)
 minimum=re.search(r'cmd LC_BUILD_VERSION\s+cmdsize \d+\s+platform \d+\s+minos ([0-9.]+)',loads)
 assert minimum and minimum.group(1)=='15.0'
 for arch,uuid in ids.items():
  dsym=task/leaf/'obj'/arch/'WeChatImprove.dylib.dSYM';assert uuids(dsym)=={arch:uuid}
  symbols.append((scheme,arch,dsym))
 if scheme=='rootful':(out/'WeChatImprove.dylib').write_bytes(data)
 log=(root/f'audits/2.9-9/logs/build-{scheme}-final.log').read_text()
 plain=re.sub(r'\x1b\[[0-9;]*m','',log)
 final_counts={arch:len(set(re.findall(r'Compiling (\S+) \('+arch+r'\)',plain))) for arch in ['arm64','arm64e']}
 compile_log=plain
 if scheme=='rootful':compile_log+='\n'+re.sub(r'\x1b\[[0-9;]*m','',(root/'audits/2.9-9/logs/build-rootful.log').read_text())
 counts={arch:len(set(re.findall(r'Compiling (\S+) \('+arch+r'\)',compile_log))) for arch in ['arm64','arm64e']}
 assert all(v==298 for v in counts.values()),counts
 report['schemes'][scheme]={'deb':str(deb.relative_to(root)),'architecture':architecture,'install_path':path,'uuids':ids,
  'minimum_ios':minimum.group(1),'dsym_uuids_match':True,'diagnostic_symbols_present':True,'compiled_per_arch_union':counts,'final_recompiled_per_arch':final_counts,
  'warnings':plain.count('warning:'),'errors':plain.count('error:')}
with zipfile.ZipFile(out/'symbols.zip','w',zipfile.ZIP_DEFLATED) as z:
 for scheme,arch,dsym in symbols:
  for file in sorted(dsym.rglob('*')):
   if file.is_file():z.write(file,f'{scheme}/{arch}/{dsym.name}/{file.relative_to(dsym).as_posix()}')
with zipfile.ZipFile(out/'symbols.zip') as z:assert z.testzip() is None
report['symbols_zip_crc_ok']=True
(root/'audits/2.9-9/artifact-validation.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
