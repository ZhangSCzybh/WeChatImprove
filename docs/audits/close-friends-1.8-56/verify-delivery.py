"""Verify the saved 1.8-56 artifact and source snapshot; never builds or installs."""
from pathlib import Path
import hashlib
import json
import re
import subprocess
import tempfile

out = Path(__file__).resolve().parent
root = out.parents[2]
version = '1.8-56'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(*args):
    return subprocess.check_output(args, text=True).strip()


for name, expected in json.loads((out / 'source-manifest.json').read_text()).items():
    assert sha(root / name) == expected, ('source changed', name)
scope = json.loads((out / 'scope.json').read_text())
paths = ['Controllers', 'Hooks', 'Headers', 'Makefile', 'control']
changed = set(run('git', '-C', str(root), 'diff', '--name-only', scope['code_baseline'], '--', *paths).splitlines())
changed.update(run('git', '-C', str(root), 'ls-files', '--others', '--exclude-standard', '--', *paths).splitlines())
assert sorted(changed) == sorted(scope['allowed_production_changes']), sorted(changed)
for name, expected in scope['preserved_adapters'].items():
    assert sha(root / name) == expected, name
prior = json.loads((out / 'prior-packages.json').read_text())
for checkout, files in prior.items():
    for name, expected in files.items():
        p = Path(checkout) / name
        assert sha(p) == expected['sha256'] and p.stat().st_size == expected['bytes'], ('prior artifact changed', str(p))
assert 'Version: ' + version in (root / 'control').read_text()
assert '#define kPluginVersionString @"' + version + '"' in (root / 'Headers/CSUserInfoHelper.h').read_text()
assert '@"' + version + '": @[' in (root / 'Controllers/CSReleaseNotesViewController.m').read_text()
assert '**当前版本：`' + version + '`**' in (root / 'README.md').read_text()
assert 'minimumPressDuration=1.0;' in (root / 'Controllers/CSCloseFriendManager.m').read_text()
assert '顶部导航栏 1 秒' in (root / 'Controllers/CSCloseFriendSettingsViewController.m').read_text()
package = root / 'packages' / ('com.wechat.improve_' + version + '_iphoneos-arm64.deb')
metadata = {key: run('dpkg-deb', '-f', str(package), key) for key in ['Package', 'Version', 'Architecture', 'Depends']}
assert metadata['Version'] == version and metadata['Architecture'] == 'iphoneos-arm64'
assert metadata['Package'] == 'com.wechat.improve'
contents = run('dpkg-deb', '-c', str(package))
assert '/Tests/' not in contents and '/docs/' not in contents
(out / 'package-contents.txt').write_text(contents + '\n')
with tempfile.TemporaryDirectory(prefix='wechat-close-friends-package-') as temp:
    subprocess.check_call(['dpkg-deb', '-x', str(package), temp])
    relative = Path('var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
    dylib = Path(temp) / relative
    architectures = run('xcrun', 'lipo', '-archs', str(dylib)).split()
    assert set(architectures) == {'arm64', 'arm64e'}
    build = run('xcrun', 'vtool', '-show-build', str(dylib))
    assert re.findall(r'minos\s+(\S+)', build) == ['15.0', '15.0']
    digest = sha(dylib)
    assert digest == sha(root / '.theos/_' / relative) == sha(root / '.theos/obj/WeChatImprove.dylib')
    assert (version + '\0').encode() in dylib.read_bytes()
    assert b'layoutTableFooterView\0' not in dylib.read_bytes(), '1.8-49 forced layout unexpectedly retained'
    assert b'reloadDataWrap\0' in dylib.read_bytes(), 'native refresh entry absent'
    uuids = dict((arch, uuid) for uuid, arch in re.findall(r'UUID: ([\w-]+) \((\w+)\)', run('xcrun', 'dwarfdump', '--uuid', str(dylib))))
    for arch in architectures:
        assert uuids[arch] in run('xcrun', 'dwarfdump', '--uuid', str(root / '.theos/obj' / arch / 'WeChatImprove.dylib.dSYM'))
        symbols = run('xcrun', 'nm', '-arch', arch, '-gU', str(dylib))
        assert '_OBJC_CLASS_$_CSCloseFriendShakeMonitor' in symbols
        assert '_CSNativeContactPickerPresent' in symbols
        assert '_OBJC_CLASS_$_CSCFGroupListData' in symbols
        assert '_CSCFReturnProtectedChatToList' in symbols
        assert '_CSCFSearchRedactsGroupMatch' in symbols
        assert '_OBJC_CLASS_$_CSCFGroupResultCover' not in symbols
        assert 'CoreMotion.framework/CoreMotion' in run('xcrun', 'otool', '-arch', arch, '-L', str(dylib))
    assert json.loads(run('plutil', '-convert', 'json', '-o', '-', str(dylib.with_suffix('.plist')))) == json.loads(run('plutil', '-convert', 'json', '-o', '-', str(root / 'WeChatImprove.plist')))

build_result = json.loads((out / 'build-result.json').read_text())
assert build_result['exit_code'] == 0
assert build_result['command'] == ['make', 'package', '-j4', 'SCHEME=rootless', 'PACKAGE_VERSION=' + version]
host = json.loads((out / 'host-results.json').read_text())
assert len(host) == 6 and all(result['exit_code'] == 0 for result in host)
delivery = Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages') / package.name
assert delivery.read_bytes() == package.read_bytes()
assert run('git', '-C', str(root), 'branch', '--show-current') == 'codex/close-friends-148'
original = delivery.parents[1]
assert run('git', '-C', str(original), 'branch', '--show-current') == 'main'
assert run('git', '-C', str(original), 'rev-parse', 'HEAD') == scope['original_checkout_head']
assert not run('git', '-C', str(original), 'diff', 'HEAD', '--name-only', '--', *paths)
report = {
    'version': version, 'scheme': 'rootless', 'checkout': str(root),
    'branch': 'codex/close-friends-148', 'base_commit': scope['code_baseline'],
    'source_identity': 'source-manifest.json', 'metadata': metadata,
    'architectures': architectures, 'minimum_ios': '15.0',
    'artifact': {'path': str(package.relative_to(root)), 'sha256': sha(package), 'bytes': package.stat().st_size},
    'dylib_sha256': digest, 'dSYM_UUIDs': uuids,
    'source_matches_manifest': True, 'production_scope_verified': True,
    'forced_footer_layout_selector_absent': True,
    'core_motion_linked_both_architectures': True,
    'package_matches_build_and_stage': True, 'version_agreement': True,
    'injection_filter_unchanged': True, 'prior_artifacts_unchanged': True,
    'host_results': host, 'build_exit_code': build_result['exit_code'],
    'delivery_path': str(delivery), 'delivery_matches_build': True,
    'original_checkout_head': scope['original_checkout_head'],
    'device_validation': 'Pending real-device appearance acceptance. Isolated host fixtures passed 38 group-list/navigation/search-cell checks, 72 native-picker checks, 18 shake checks, and existing contact/search/social regressions. Strict surface compilation and the final package passed for arm64 and arm64e. No device installation or live account writes performed.'
}
(out / 'validation.json').write_text(json.dumps(report, indent=2, ensure_ascii=False) + '\n')
print(json.dumps({'version': version, 'artifact': report['artifact'], 'architectures': architectures, 'verified': True}, ensure_ascii=False))
