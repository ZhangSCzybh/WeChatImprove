from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import tempfile
import zipfile

out = Path(__file__).resolve().parent
paths = json.loads((out / 'build-paths.json').read_text())
root, build, packages = (Path(paths[k]) for k in ['checkout', 'build', 'packages'])

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def run(*args):
    return subprocess.check_output(args, text=True).strip()

baseline = json.loads((out / 'baseline-sha256.json').read_text())
manifest = json.loads((out / 'source-manifest.json').read_text())
for name, digest in manifest.items():
    assert sha(root / name) == digest, ('source changed during build', name)
changed = [name for name,digest in baseline.items() if not (root / name).is_file() or sha(root / name) != digest]
allowed = {'Controllers/CSMessageMergeAdapter.m','Tests/MessageMergeAdapterTests.m',
    'Tests/MergeBubbleIntegrationTests.m','Controllers/CSReleaseNotesViewController.m',
    'Headers/CSUserInfoHelper.h','README.md','control'}
assert set(changed) == allowed, changed
prior = {name:digest for name,digest in baseline.items() if name.startswith(('packages/','docs/'))}
for name, digest in prior.items():
    assert sha(root / name) == digest, ('prior artifact changed', name)
adapter=(root/'Controllers/CSBubbleStyleAdapter.m').read_text()
hooks=(root/'Hooks/BubbleStyleHooks.xm').read_text()
assert '- (id)decodeImage' in hooks and '_decodeImageLM' not in adapter and '_decodeImageDM' not in adapter
assert '- (id)newAsyncDisplayTask' in hooks and '- (void)didSetDynamicYYImage' not in hooks
assert not re.search(r'(?:CSMessageNativeObject|objc_msgSend)\([^\n]*@"(?:originImage|decodeImage|image)"',adapter)
regressions=json.loads((out/'regression-results.json').read_text())
assert len(regressions)==32 and all(r['exit_code']==0 for r in regressions)
assert json.loads((out / 'build-result.json').read_text())['exit_code'] == 0
assert '#define kPluginVersionString @"1.8-35"' in (root / 'Headers/CSUserInfoHelper.h').read_text()
assert '@"1.8-35": @[' in (root / 'Controllers/CSReleaseNotesViewController.m').read_text()

package = packages / 'com.wechat.improve_1.8-35_iphoneos-arm64.deb'
metadata = {k: run('/opt/homebrew/bin/dpkg-deb', '-f', str(package), k)
            for k in ['Package', 'Version', 'Architecture', 'Depends']}
assert metadata['Package'] == 'com.wechat.improve'
assert metadata['Version'] == '1.8-35'
assert metadata['Architecture'] == 'iphoneos-arm64'
contents = run('/opt/homebrew/bin/dpkg-deb', '-c', str(package))
(out / 'package-contents.txt').write_text(contents + '\n')
assert '/Tests/' not in contents and '/docs/audits/' not in contents
with tempfile.TemporaryDirectory(prefix='wechat-performance-package-check-') as tmp:
    subprocess.check_call(['/opt/homebrew/bin/dpkg-deb', '-x', str(package), tmp])
    relative = Path('var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
    dylib = Path(tmp) / relative
    archs = run('xcrun', 'lipo', '-archs', str(dylib)).split()
    assert set(archs) == {'arm64', 'arm64e'}
    build_versions=run('xcrun','vtool','-show-build',str(dylib))
    (out/'mach-o-build.txt').write_text(build_versions+'\n')
    assert re.findall(r'minos\s+(\S+)',build_versions)==['15.0','15.0']
    digest = sha(dylib)
    assert digest == sha(build / '_' / relative) == sha(build / 'obj/WeChatImprove.dylib')
    assert b'1.8-35\0' in dylib.read_bytes()
    plist = dylib.with_suffix('.plist')
    # Theos converts the source OpenStep plist to binary; compare the decoded filter.
    assert json.loads(run('/usr/bin/plutil', '-convert', 'json', '-o', '-', str(plist))) == json.loads(
        run('/usr/bin/plutil', '-convert', 'json', '-o', '-', str(root / 'WeChatImprove.plist')))
    uuids = {arch: uuid for uuid, arch in re.findall(r'UUID: ([\w-]+) \((\w+)\)',
             run('xcrun', 'dwarfdump', '--uuid', str(dylib)))}
    syms = {}
    for arch in archs:
        dsym = build / 'obj' / arch / 'WeChatImprove.dylib.dSYM'
        assert uuids[arch] in run('xcrun', 'dwarfdump', '--uuid', str(dsym))
        syms[arch] = dsym
        symbols = run('xcrun', 'nm', '-arch', arch, '-gU', str(dylib))
        for name in ['_OBJC_CLASS_$_CSNavigationImageLoader', '_CSCustomTextMatchesTitle',
                     '_CSCustomTextMatchesFriendsCount', '_CSMessageMergePlanLayout', '_CSBubbleStyleVisibleInsets', '_CSBubbleStyleObserveDisplayTask', '_CSBubbleStyleObserveDecodedImage', '_CSBubbleStyleModelInsets',
                     '_CSBubbleCreateStyledTemplate', '_CSBubbleTextColorsApply', '_CSBubbleTextColorsRestore', '_CSMessageMergeReadAppearance', '_OBJC_CLASS_$_CSBubbleStylePreview']:
            assert name in symbols, (arch, name)
        for name in ['CSBubbleNativePaddingScanCount', 'CSBubbleTestDeferredFactory', 'CSMessageMergeDescriptorBuildCount', 'CSMessageMergeTestProfileVersion', 'CSBubbleStyleTestPublishDecodedImage']:
            assert name not in symbols, (arch, name)

final = root / 'packages' / package.name
if final.exists():
    assert sha(final) == sha(package), 'Refusing to overwrite different existing package'
else:
    with final.open('xb') as stream: stream.write(package.read_bytes())
symbolzip = root / 'packages/WeChatImprove-1.8-35-dSYMs.zip'
if not symbolzip.exists():
    with zipfile.ZipFile(symbolzip, 'x', zipfile.ZIP_DEFLATED) as archive:
        for arch, dsym in syms.items():
            for path in dsym.rglob('*'):
                if path.is_file():
                    archive.write(path, str(Path(arch) / dsym.name / path.relative_to(dsym)))
with zipfile.ZipFile(symbolzip) as archive:
    assert archive.testzip() is None
    for arch, dsym in syms.items():
        for path in dsym.rglob('*'):
            if path.is_file():
                name = str(Path(arch) / dsym.name / path.relative_to(dsym))
                assert archive.read(name) == path.read_bytes(), name
for name, old_digest in prior.items():
    assert sha(root / name) == old_digest, ('prior artifact changed', name)
report = {
    'version': '1.8-35', 'scheme': 'rootless', 'metadata': metadata,
    'architectures': archs, 'dylib_sha256': digest,
    'package_matches_built_and_staged': True, 'dSYM_UUIDs': uuids,
    'artifacts': {str(p.relative_to(root)): {'sha256': sha(p), 'bytes': p.stat().st_size}
                  for p in [final, symbolzip]},
    'prior_artifacts_unchanged': True, 'source_matches_build_manifest': True,
    'changes_limited_to_allowed_files': True,
    'changed_files': changed, 'added_files': sorted(set(manifest)-set(baseline)), 'baseline_files_verified':len(baseline), 'old_artifact_files_verified':len(prior), 'regression_scripts_passed':len(regressions),
    'compact_geometry_and_visible_insets_present_in_both_architectures': True,
    'test_counter_exports_absent': True, 'injection_filter_preserved': True,
    'gap_unit':'pt', 'target_gap':2, 'display_scale_affects_spacing':False,
    'native_decoder_slots_not_read':True,
    'native_decode_return_observer_present':True,
    'bubble_adapter_unchanged':sha(root/'Controllers/CSBubbleStyleAdapter.m')==baseline['Controllers/CSBubbleStyleAdapter.m'],
    'bubble_hooks_unchanged':sha(root/'Hooks/BubbleStyleHooks.xm')==baseline['Hooks/BubbleStyleHooks.xm'],
    'merge_policy_unchanged':sha(root/'Controllers/CSMessageMergePolicy.m')==baseline['Controllers/CSMessageMergePolicy.m'],
    'lazy_decode_getters_still_avoided':True,
    'native_display_completion_hook_present':True,
    'device_installed': False,
}
(out / 'verification.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps(report, ensure_ascii=False, indent=2))
