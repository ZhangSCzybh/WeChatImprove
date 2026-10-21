"""Read-only verification of the scoped font fix and saved 1.8-57 package."""
from pathlib import Path
import hashlib,json,re,subprocess,tempfile
out=Path(__file__).resolve().parent
root=out.parents[2]
version='1.8-57'
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def run(*args):return subprocess.check_output(args,text=True).strip()
for name,digest in json.loads((out/'source-manifest.json').read_text()).items():
    assert sha(root/name)==digest,name
before=json.loads((out/'source-before.json').read_text())
changed=sorted(name for name,digest in before.items() if sha(root/name)!=digest)
assert changed==sorted(['Controllers/CSSettingTableViewCell.m','Controllers/CSReleaseNotesViewController.m','Headers/CSUserInfoHelper.h']),changed
baseline=json.loads((out/'baseline.json').read_text())
for checkout,state in baseline.items():
    assert run('git','-C',checkout,'branch','--show-current')==state['branch']
    for name,digest in state['packages'].items():assert sha(Path(checkout)/'packages'/name)==digest,name
original=Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
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
with tempfile.TemporaryDirectory(prefix='wechat-settings-font-') as temp:
    subprocess.run(['dpkg-deb','-x',str(package),temp],check=True)
    relative=Path('var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
    dylib=Path(temp)/relative
    architectures=run('xcrun','lipo','-archs',str(dylib)).split()
    assert set(architectures)=={'arm64','arm64e'}
    assert re.findall(r'minos\s+(\S+)',run('xcrun','vtool','-show-build',str(dylib)))==['15.0','15.0']
    assert sha(dylib)==sha(root/'.theos/_'/relative)==sha(root/'.theos/obj/WeChatImprove.dylib')
    assert (version+'\0').encode() in dylib.read_bytes()
    uuids={arch:uuid for uuid,arch in re.findall(r'UUID: ([\w-]+) \((\w+)\)',run('xcrun','dwarfdump','--uuid',str(dylib)))}
    for arch in architectures:assert uuids[arch] in run('xcrun','dwarfdump','--uuid',str(root/'.theos/obj'/arch/'WeChatImprove.dylib.dSYM'))
    assert run('plutil','-convert','json','-o','-',str(dylib.with_suffix('.plist')))==run('plutil','-convert','json','-o','-',str(root/'WeChatImprove.plist'))
assert all(r['exit_code']==0 for r in json.loads((out/'syntax-results.json').read_text()))
assert json.loads((out/'build-result.json').read_text())['exit_code']==0
report={'version':version,'sha256':sha(package),'bytes':package.stat().st_size,'delivery':str(delivery),'architectures':architectures,'minimum_ios':'15.0','production_changes':changed,'reset_handlers_and_hooks_preserved':True,'source_versions_build_stage_and_delivery_verified':True,'historical_packages_preserved':True,'dSYM_UUIDs':uuids,'validation':'Targeted source review, strict shared-cell syntax compilation for both architectures, Rootless build and package verification. No new behavior tests for this font-only change. Real-device visual acceptance pending.'}
(out/'validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(report,ensure_ascii=False,indent=2))
