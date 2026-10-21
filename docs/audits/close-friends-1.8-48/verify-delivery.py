"""Verify the saved 1.8-48 artifact and source snapshot; never builds or installs."""
from pathlib import Path
import hashlib
import json
import re
import subprocess
import tempfile

out = Path(__file__).resolve().parent
root = out.parents[2]
version = '1.8-48'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(*args):
    return subprocess.check_output(args, text=True).strip()


for name, expected in json.loads((out / 'source-manifest.json').read_text()).items():
    assert sha(root / name) == expected, ('source changed', name)
prior = json.loads((out / 'prior-packages.json').read_text())
for checkout, files in prior.items():
    for name, expected in files.items():
        p = Path(checkout) / name
        assert sha(p) == expected['sha256'] and p.stat().st_size == expected['bytes'], ('prior artifact changed', str(p))
assert 'Version: ' + version in (root / 'control').read_text()
assert '#define kPluginVersionString @"' + version + '"' in (root / 'Headers/CSUserInfoHelper.h').read_text()
assert '@"' + version + '": @[' in (root / 'Controllers/CSReleaseNotesViewController.m').read_text()
assert '**当前版本：`' + version + '`**' in (root / 'README.md').read_text()
package = root / 'packages' / ('com.wechat.improve_' + version + '_iphoneos-arm64.deb')
metadata = {key: run('dpkg-deb', '-f', str(package), key) for key in ['Package', 'Version', 'Architecture', 'Depends']}
assert metadata['Version'] == version and metadata['Architecture'] == 'iphoneos-arm64'
assert metadata['Package'] == 'com.wechat.improve'
contents = run('dpkg-deb', '-c', str(package))
assert '/Tests/' not in contents and '/docs/' not in contents
(out / 'package-contents.txt').write_text(contents + '\n')
exports = ['_CSCFAlbumInstall', '_CSCFDetailInstall', '_CSCFInteractionInstall', '_CSCFSocialProtectRoute', '_CSCFSocialGate', '_CSCFTimelineInstall', '_CSCFIncomingCallToken', '_CSCFHandleIncomingCall', '_CSCFCallDidReject', '_CSCFCallReplyMessageDidChange', '_CSCFSearchSubmit', '_CSCFSearchDispatchInput', '_CSCFSearchDispatchQuery', '_CSCFSearchSuppressLoading', '_CSCFSearchModel', '_CSCFSearchVisibleRows', '_CSCFSearchConsumePassword',
           '_CSCFProfileWithNativePresentation', '_CSCFProfileUsesNativeStranger', '_CSCFAudienceInstall']
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
    uuids = dict((arch, uuid) for uuid, arch in re.findall(r'UUID: ([\w-]+) \((\w+)\)', run('xcrun', 'dwarfdump', '--uuid', str(dylib))))
    for arch in architectures:
        assert uuids[arch] in run('xcrun', 'dwarfdump', '--uuid', str(root / '.theos/obj' / arch / 'WeChatImprove.dylib.dSYM'))
        symbols = run('xcrun', 'nm', '-arch', arch, '-gU', str(dylib))
        assert '_CSCFCallReplyConfigureTesting' not in symbols
        assert '_CSCFSearchUnlockCell' not in symbols
        assert '_CSCFSearchUnlock' not in symbols
        for symbol in exports:
            assert re.search(r'\b' + re.escape(symbol) + r'$', symbols, re.M), (arch, symbol)
    assert json.loads(run('plutil', '-convert', 'json', '-o', '-', str(dylib.with_suffix('.plist')))) == json.loads(run('plutil', '-convert', 'json', '-o', '-', str(root / 'WeChatImprove.plist')))

build_result = json.loads((out / 'build-result.json').read_text())
assert build_result['exit_code'] == 0
assert build_result['command'] == ['make', 'package', '-j4', 'SCHEME=rootless', 'PACKAGE_VERSION=' + version]
host = json.loads((out / 'host-results.json').read_text())
assert all(result['exit_code'] == 0 for result in host)
report = {
    'version': version, 'scheme': 'rootless', 'checkout': str(root),
    'branch': run('git', '-C', str(root), 'branch', '--show-current'),
    'base_commit': '2953a2ad4eb2f7193dfca48d7c87c454d242b6d8', 'source_identity': 'source-manifest.json',
    'metadata': metadata, 'architectures': architectures, 'minimum_ios': '15.0',
    'artifact': {'path': str(package.relative_to(root)), 'sha256': sha(package), 'bytes': package.stat().st_size},
    'dylib_sha256': digest, 'dSYM_UUIDs': uuids,
    'source_matches_manifest': True, 'package_matches_build_and_stage': True,
    'version_agreement': True, 'injection_filter_unchanged': True,
    'prior_artifacts_unchanged': {checkout:list(files) for checkout,files in prior.items()}, 'exports_in_both_architectures': exports,
    'host_results': host, 'build_exit_code': build_result['exit_code'],
    'build_command': 'make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-48',
    'device_validation': 'Pending physical-device validation of the four reported group search/Moments workflows; host fixtures and native static evidence passed.'
}
delivery = Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages') / package.name
assert delivery.read_bytes() == package.read_bytes()
assert run('git','-C',str(root),'branch','--show-current') == 'codex/close-friends-148'
report['delivery_path'] = str(delivery)
report['delivery_matches_build'] = True
report['original_checkout_branch_at_verification'] = run('git','-C',str(delivery.parents[1]),'branch','--show-current')
(out / 'validation.json').write_text(json.dumps(report, indent=2, ensure_ascii=False) + '\n')
print(json.dumps({'version': version, 'artifact': report['artifact'], 'architectures': architectures,
                  'verified': True}, ensure_ascii=False))
