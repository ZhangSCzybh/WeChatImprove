from pathlib import Path
import subprocess, tempfile, hashlib, json, shutil, re
root=Path('/Users/zhangshichao/.codex/worktrees/list-corners-refactor/WeChatImprove')
version='1.7-19'
assert subprocess.check_output(['git','branch','--show-current'],cwd=root,text=True).strip()=='codex/list-corners-refactor-1.7-17'
assert ('Version: '+version) in (root/'control').read_text()
build=Path(tempfile.mkdtemp(prefix='wechat-list-corners-1.7-19-'))
Path('/tmp/list-corners-release-build-path.txt').write_text(str(build))
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
files=[root/'Makefile',root/'control',root/'WeChatImprove.plist',*sorted((root/'Controllers').glob('*.[mh]')),*sorted((root/'Headers').glob('*.h')),*sorted((root/'Hooks').glob('*.xm'))]
sources={str(p.relative_to(root)):sha(p) for p in files if p.exists()}
commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip()
(build/'source-sha256.json').write_text(json.dumps(sources,indent=2))
args=['make','package','-j4','THEOS=/Users/zhangshichao/theos','SCHEME=rootless','_THEOS_LOCAL_DATA_DIR='+str(build/'data'),'THEOS_BUILD_DIR='+str(build/'build'),'THEOS_PACKAGE_DIR='+str(build/'packages'),'THEOS_STAGING_DIR='+str(build/'staging')]
print('Fresh Release build:',build,flush=True)
with (build/'build.log').open('w') as log:
 result=subprocess.run(args,cwd=root,stdout=log,stderr=subprocess.STDOUT)
if result.returncode:
 print('\n'.join((build/'build.log').read_text().splitlines()[-70:]),flush=True);raise SystemExit(result.returncode)
for name,h in sources.items():assert sha(root/name)==h,'Source changed during build: '+name
packages=list((build/'packages').glob('*.deb'));assert len(packages)==1,packages
package=packages[0]
control=subprocess.check_output(['dpkg-deb','-f',str(package)],text=True)
assert ('Version: '+version) in control and 'Architecture: iphoneos-arm64' in control
subprocess.run(['dpkg-deb','-x',str(package),str(build/'extract')],check=True)
dylib=build/'extract/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib'
assert dylib.is_file()
arch=subprocess.check_output(['xcrun','lipo','-archs',str(dylib)],text=True).strip();assert set(arch.split())=={'arm64','arm64e'}
symbols=subprocess.check_output(['xcrun','nm','-gU',str(dylib)],text=True)
for name in ['CSListCornerHeaderHeight','CSListCornerFooterHeight','CSListCornerSessionDecorate','CSListCornerContactsDecorate','CSListCornerDiscoverDecorate','CSListCornerMoreDecorate','CSListApplyCardBackground']:
 assert name in symbols,'Missing new production symbol '+name
for name in ['_CSListHeaderHeight','_OBJC_CLASS_$_CSListCornerPreferences','_OBJC_CLASS_$_CSListCornerAdapter']:
 assert name not in symbols,'Retired failed-refactor symbol '+name
assert sha(dylib)==sha(build/'data/obj/WeChatImprove.dylib')
deps=subprocess.check_output(['xcrun','otool','-L',str(dylib)],text=True)
(build/'dependencies.txt').write_text(deps)
newwarnings=[line for line in (build/'build.log').read_text().splitlines() if re.search(r'(CSListCorner|ListCornerRadiusHooks).*\b(warning|error):',line)]
assert not newwarnings,newwarnings
out=root/'packages'/package.name
assert not out.exists(),'Will not overwrite existing package '+str(out)
shutil.copy2(package,out)
report={'version':version,'base':'2aa7bcb8','source_commit':commit,'branch':'codex/list-corners-refactor-1.7-17','package':str(out),'sha256':sha(out),'bytes':out.stat().st_size,'architecture':arch,'control':control,'install_path':'/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib','payload_matches_build':True,'new_symbols_verified':True,'retired_failed_refactor_symbols_absent':True,'changed_source_warnings':newwarnings,'build_directory':str(build),'command':args,'device_verified':False,'source_sha256':sources}
evidence=root/'docs/audits/list-corners-refactor-1.7-19';evidence.mkdir(parents=True,exist_ok=True)
(evidence/'build-validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
shutil.copy2(build/'dependencies.txt',evidence/'dependencies.txt')
print(json.dumps({k:v for k,v in report.items() if k!='source_sha256'},ensure_ascii=False,indent=2),flush=True)
