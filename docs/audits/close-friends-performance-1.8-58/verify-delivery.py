"""Verify the saved 1.8-58 source, Rootless package and established delivery path."""
from pathlib import Path
import hashlib,json,re,subprocess,tempfile
out=Path(__file__).resolve().parent
root=out.parents[2]
original=Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
version='1.8-58'
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def run(*args):return subprocess.check_output(args,text=True).strip()
manifest=json.loads((out/'source-manifest.json').read_text())
for name,digest in manifest.items():assert sha(root/name)==digest,name
for name in ['Controllers/CSCloseFriendMuteAdapter.h','Controllers/CSCloseFriendMuteAdapter.m']:
    assert not (root/name).exists(),name
baseline=json.loads((out/'baseline.json').read_text())
for checkout,state in baseline.items():
    assert run('git','-C',checkout,'branch','--show-current')==state['branch']
    for name,digest in state['packages'].items():assert sha(Path(checkout)/'packages'/name)==digest,name
assert run('git','-C',str(original),'rev-parse','HEAD')==baseline[str(original)]['head']
assert not run('git','-C',str(original),'diff','HEAD','--name-only','--','Controllers','Hooks','Headers','Makefile','control')
assert 'Version: '+version in (root/'control').read_text()
assert '#define kPluginVersionString @"'+version+'"' in (root/'Headers/CSUserInfoHelper.h').read_text()
assert '@"'+version+'": @[' in (root/'Controllers/CSReleaseNotesViewController.m').read_text()
assert '**当前版本：`'+version+'`**' in (root/'README.md').read_text()
package=root/'packages'/('com.wechat.improve_'+version+'_iphoneos-arm64.deb')
delivery=original/'packages'/package.name
assert sha(package)==sha(delivery)
metadata={key:run('dpkg-deb','-f',str(package),key) for key in ['Package','Version','Architecture']}
assert metadata=={'Package':'com.wechat.improve','Version':version,'Architecture':'iphoneos-arm64'}
with tempfile.TemporaryDirectory(prefix='wechat-close-friends-158-') as temp:
    subprocess.run(['dpkg-deb','-x',str(package),temp],check=True)
    relative=Path('var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
    dylib=Path(temp)/relative
    architectures=run('xcrun','lipo','-archs',str(dylib)).split()
    assert set(architectures)=={'arm64','arm64e'}
    assert re.findall(r'minos\s+(\S+)',run('xcrun','vtool','-show-build',str(dylib)))==['15.0','15.0']
    assert sha(dylib)==sha(root/'.theos/_'/relative)==sha(root/'.theos/obj/WeChatImprove.dylib')
    binary=dylib.read_bytes()
    assert (version+'\0').encode() in binary
    for removed in [b'CSCloseFriendMuteAdapter',b'saveMuteRecords:account:epoch:error:']:
        assert removed not in binary,removed
    uuids={arch:uuid for uuid,arch in re.findall(r'UUID: ([\w-]+) \((\w+)\)',run('xcrun','dwarfdump','--uuid',str(dylib)))}
    for arch in architectures:assert uuids[arch] in run('xcrun','dwarfdump','--uuid',str(root/'.theos/obj'/arch/'WeChatImprove.dylib.dSYM'))
    assert run('plutil','-convert','json','-o','-',str(dylib.with_suffix('.plist')))==run('plutil','-convert','json','-o','-',str(root/'WeChatImprove.plist'))
for name in ['build','ios-compile','contacts','runtime']:
    assert json.loads((out/(name+'-result.json')).read_text())['exit_code']==0,name
for test in json.loads((out/'focused-results.json').read_text()):assert test['status']=='passed'
report={'version':version,'sha256':sha(package),'bytes':package.stat().st_size,'delivery':str(delivery),'architectures':architectures,'minimum_ios':'15.0','source_files_verified':len(manifest),'automatic_native_dnd_removed_from_binary':True,'source_versions_build_stage_and_delivery_verified':True,'historical_packages_preserved':True,'dSYM_UUIDs':uuids,'validation':'Focused macOS production-body regressions, strict iOS compilation for both architectures and Rootless package checks. No device installation or live account/configuration writes; real-device performance acceptance pending.'}
(out/'validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(report,ensure_ascii=False,indent=2))
