"""Read-only verification of the existing Task7 package; never rebuilds or installs."""
from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import tempfile

out = Path(__file__).resolve().parent
root = out.parents[2]
version = '1.8-42'
commands = []

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def run(*args):
    commands.append(list(args))
    return subprocess.check_output(args, text=True).strip()

manifest = json.loads((out / 'source-manifest.json').read_text())
for name, digest in manifest.items():
    assert sha(root / name) == digest, ('source changed since captured final build manifest', name)
prior = json.loads((out / 'prior-packages.json').read_text())['files']
for name, expected in prior.items():
    p = root / name
    assert sha(p) == expected['sha256'] and p.stat().st_size == expected['bytes'], ('prior artifact changed', name)

assert 'Version: ' + version in (root / 'control').read_text()
assert '#define kPluginVersionString @"' + version + '"' in (root / 'Headers/CSUserInfoHelper.h').read_text()
assert '@"' + version + '": @[' in (root / 'Controllers/CSReleaseNotesViewController.m').read_text()
assert '**当前版本：`' + version + '`**' in (root / 'README.md').read_text()
package = root / 'packages' / ('com.wechat.improve_' + version + '_iphoneos-arm64.deb')
dpkg = shutil.which('dpkg-deb')
assert dpkg
metadata = {key: run(dpkg, '-f', str(package), key) for key in ['Package', 'Version', 'Architecture', 'Depends']}
assert metadata['Package'] == 'com.wechat.improve'
assert metadata['Version'] == version and metadata['Architecture'] == 'iphoneos-arm64'
contents = run(dpkg, '-c', str(package))
(out / 'package-contents.txt').write_text(contents + '\n')
assert '/Tests/' not in contents and '/docs/' not in contents
exports = ['_CSCloseFriendCurrentSnapshot', '_CSCloseFriendAccountEpoch', '_CSCloseFriendShouldSilence',
           '_CSCloseFriendShouldRejectCall', '_CSCloseFriendInstallHook', '_CSCloseFriendMethodMatches',
           '_OBJC_CLASS_$_CSCloseFriendSnapshot', '_OBJC_CLASS_$_CSCloseFriendStore',
           '_OBJC_CLASS_$_CSCloseFriendRuntime', '_OBJC_CLASS_$_CSCloseFriendManager',
           '_OBJC_CLASS_$_CSCloseFriendSettingsViewController', '_CSCFVisible',
           '_CSCFSearchPrepare', '_CSCFProfileBind',
           '_CSCFTimelineInstall', '_CSCFInteractionInstall',
           '_CSCFStatusInstall', '_CSCFAudienceInstall',
           '_OBJC_CLASS_$_CSCloseFriendMuteAdapter', '_OBJC_CLASS_$_CSCloseFriendCallAdapter',
           '_OBJC_CLASS_$_CSGroupProjection', '_OBJC_CLASS_$_CSGroupListAdapter']
with tempfile.TemporaryDirectory(prefix='wechat-close-friends-package-') as temporary:
    subprocess.check_call([dpkg, '-x', str(package), temporary])
    relative = Path('var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
    dylib = Path(temporary) / relative
    archs = run('xcrun', 'lipo', '-archs', str(dylib)).split()
    assert set(archs) == {'arm64', 'arm64e'}
    build = run('xcrun', 'vtool', '-show-build', str(dylib))
    (out / 'mach-o-build.txt').write_text(build + '\n')
    assert re.findall(r'minos\s+(\S+)', build) == ['15.0', '15.0']
    digest = sha(dylib)
    assert digest == sha(root / '.theos/_' / relative) == sha(root / '.theos/obj/WeChatImprove.dylib')
    assert (version + '\0').encode() in dylib.read_bytes()
    uuids = dict((arch, uuid) for uuid, arch in re.findall(r'UUID: ([\w-]+) \((\w+)\)', run('xcrun', 'dwarfdump', '--uuid', str(dylib))))
    for arch in archs:
        dsym = root / '.theos/obj' / arch / 'WeChatImprove.dylib.dSYM'
        assert uuids[arch] in run('xcrun', 'dwarfdump', '--uuid', str(dsym))
        symbols = run('xcrun', 'nm', '-arch', arch, '-gU', str(dylib))
        for symbol in exports:
            assert re.search(r'\b' + re.escape(symbol) + r'$', symbols, re.M), (arch, symbol)
    filter_value = json.loads(run('/usr/bin/plutil', '-convert', 'json', '-o', '-', str(dylib.with_suffix('.plist'))))
    assert filter_value == json.loads(run('/usr/bin/plutil', '-convert', 'json', '-o', '-', str(root / 'WeChatImprove.plist')))

host = json.loads((out / 'host-results.json').read_text())
packaging = json.loads((out / 'build-result.json').read_text())
post_review = json.loads((out / 'final-fix-results.json').read_text()) if (out / 'final-fix-results.json').exists() else []
assert all(result['exit_code'] == 0 for result in host + post_review) and packaging['exit_code'] == 0
report = {
    'version': version, 'scheme': 'rootless', 'checkout': str(root), 'branch': run('git', '-C', str(root), 'branch', '--show-current'),
    'integration_base': 'b0a811357c8af96b7c599c570d99f41011040f31',
    'production_source_commit': run('git', '-C', str(root), 'rev-parse', 'HEAD'),
    'source_identity': 'source-manifest.json captures final production/test bytes before the final build; targeted post-review fixture ran on these same bytes. Original integration source/results are retained separately.',
    'metadata': metadata, 'architectures': archs, 'minimum_ios': '15.0', 'dylib_sha256': digest, 'dSYM_UUIDs': uuids,
    'artifact': {'path': str(package.relative_to(root)), 'sha256': sha(package), 'bytes': package.stat().st_size},
    'checks': {'source_matches_pretest_build_manifest': True, 'package_matches_built_and_staged_dylib': True,
               'version_agreement': True, 'required_exports_in_both_architectures': exports,
               'injection_filter_unchanged': filter_value, 'prior_artifacts_unchanged': list(prior)},
    'host_results': host, 'post_review_results': post_review, 'build': packaging,
    'integration_evidence': {'validation': 'validation-integration.json', 'source_manifest': 'source-manifest-integration.json', 'scope': 'Original integrated runs retained. Only the affected alerts fixture and final package were rerun after I1; unchanged suite results reused.'},
    'build_warnings': ['UILocalNotification deprecation (legacy adapter, both architectures)', 'statusBarFrame deprecation (existing RedEnvelopHooks, both architectures)', 'obsolete -multiply_defined linker flag (both architectures)'],
    'reused_validation': {'group_mapping': 'Task3 reviewed results, task-reports/task-3-report.md; projection/index/mapping algorithms unchanged since 3cf088f2. Task6 added source epoch checks and badge accessor covered by integrated alerts/session fixtures.'},
    'build_cache': 'Existing .theos preserved and updated by make; tracked/untracked build outputs deliberately not committed or reverted. No clean.',
    'scope': {'device_installed': False, 'device_acceptance': 'pending', 'device_matrix': 'device-acceptance.md', 'native_reference_version': 'WeChat 8.0.78', 'native_dnd_write_version': '8.0.78', 'host_results_are_device_proof': False},
    'limitations': ['DND restoration ownership is process-bound; after WeChat restart old automatic DND can remain and require manual restoration.', 'Main ilink without exact cached subcall and some unified group broadcast rejection unsupported.', 'Process-terminated APNs, notification extensions, CallKit system first frames and unbound asynchronous outputs not claimed covered.', 'Message/advanced search sections, protected personal/detail/status routes and publishing visibility editing are gated until reveal.', 'Unknown/stale badges and discovery Moments cues can be neutral, including ordinary activity.'],
    'verification_commands': commands,
}
(out / 'validation.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps({'artifact': report['artifact'], 'architectures': archs, 'minimum_ios': '15.0', 'prior_artifacts_preserved': len(prior), 'source_files_verified': len(manifest), 'exports_per_architecture': len(exports)}, indent=2))
