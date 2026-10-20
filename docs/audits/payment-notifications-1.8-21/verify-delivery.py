from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import tempfile
import zipfile

root = Path(__file__).resolve().parents[3]
out = Path(__file__).resolve().parent
paths = json.loads((out / 'build-paths.json').read_text())
build, packages = Path(paths['build']), Path(paths['packages'])

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def run(*args):
    return subprocess.check_output(args, text=True).strip()

baseline = json.loads((out / 'baseline.json').read_text())
changed = []
for name, digest in baseline.items():
    assert (root / name).is_file(), ('missing baseline file', name)
    if sha(root / name) != digest:
        changed.append(name)
allowed = {
    'Controllers/CSPaymentAutomation.m',
    'Tests/PaymentAutomationTests.m',
    'Controllers/CSReleaseNotesViewController.m',
    'Headers/CSUserInfoHelper.h', 'control', 'README.md',
}
assert set(changed) == allowed, changed

log = (out / 'core-tests.log').read_text()
assert 'Payment core: 2215 checks passed' in log
assert 'Payment automation: 528 checks passed; native callbacks preserved' in log
prior = json.loads((out / 'prior-artifacts.json').read_text())
for name, digest in prior.items():
    assert sha(root / name) == digest, ('prior artifact changed', name)

package = packages / 'com.wechat.improve_1.8-21_iphoneos-arm64.deb'
metadata = {k: run('/opt/homebrew/bin/dpkg-deb', '-f', str(package), k)
            for k in ['Package', 'Version', 'Architecture', 'Depends']}
assert metadata['Version'] == '1.8-21' and metadata['Architecture'] == 'iphoneos-arm64'
with tempfile.TemporaryDirectory(prefix='red-envelope-package-check-') as tmp:
    subprocess.check_call(['/opt/homebrew/bin/dpkg-deb', '-x', str(package), tmp])
    relative = Path('var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
    dylib = Path(tmp) / relative
    archs = run('xcrun', 'lipo', '-archs', str(dylib)).split()
    assert set(archs) == {'arm64', 'arm64e'}
    digest = sha(dylib)
    assert digest == sha(build / '_' / relative) == sha(build / 'obj/WeChatImprove.dylib')
    uuids = {arch: uuid for uuid, arch in re.findall(r'UUID: ([\w-]+) \((\w+)\)',
             run('xcrun', 'dwarfdump', '--uuid', str(dylib)))}
    syms = {}
    inspected = []
    for arch in archs:
        dsym = build / 'obj' / arch / 'WeChatImprove.dylib.dSYM'
        assert uuids[arch] in run('xcrun', 'dwarfdump', '--uuid', str(dsym))
        syms[arch] = dsym
        objects = list((build / 'obj' / arch / 'Controllers').glob('CSPayment*.o'))
        objects += list((build / 'obj' / arch / 'Controllers').glob('CSRedEnvelop*.o'))
        objects += list((build / 'obj' / arch / 'Hooks').glob('RedEnvelopHooks*.o'))
        assert len(objects) == 6, objects
        for obj in objects:
            imports = run('xcrun', 'nm', '-u', str(obj))
            assert not re.search(r'_(NSLog|NSLogv|printf|fprintf|os_log|os_log_debug|os_log_impl)\b', imports), obj
            inspected.append(str(obj.relative_to(build)))
    symbols = run('xcrun', 'nm', '-gU', str(dylib))
    for name in ['CSReceiveRedEnvelopOperation', 'CSRedEnvelopParam',
                 'CSRedEnvelopParamQueue', 'CSRedEnvelopTaskManager']:
        assert '_OBJC_CLASS_$_' + name + '\n' not in symbols
    assert '_OBJC_CLASS_$_CSPaymentTaskStore' in symbols
    contents = run('/opt/homebrew/bin/dpkg-deb', '-c', str(package))
    assert '/Tests/' not in contents and '/docs/audits/' not in contents

final = root / 'packages' / package.name
if final.exists():
    assert sha(final) == sha(package)
else:
    shutil.copy2(package, final)
symbolzip = root / 'packages/WeChatImprove-1.8-21-dSYMs.zip'
if not symbolzip.exists():
    with zipfile.ZipFile(symbolzip, 'w', zipfile.ZIP_DEFLATED) as archive:
        for arch, dsym in syms.items():
            for path in dsym.rglob('*'):
                if path.is_file():
                    archive.write(path, str(Path(arch) / dsym.name / path.relative_to(dsym)))
current = {str(path.relative_to(root)): sha(path)
           for folder in ['Controllers', 'Hooks', 'Headers', 'Tests']
           for path in (root / folder).rglob('*') if path.is_file()}
for name in ['control', 'README.md', 'Makefile']:
    current[name] = sha(root / name)
assert set(current) == set(baseline)
(out / 'source-manifest.json').write_text(json.dumps(current, indent=2) + '\n')
report = {
    'version': '1.8-21', 'metadata': metadata, 'architectures': archs,
    'dylib_sha256': digest, 'package_matches_built_and_staged': True,
    'dSYM_UUIDs': uuids,
    'artifacts': {str(final.relative_to(root)): sha(final), str(symbolzip.relative_to(root)): sha(symbolzip)},
    'preserved_prior_artifacts': len(prior),
    'unchanged_baseline_files': len(baseline) - len(changed),
    'changed_existing_files': changed,
    'ledger_core_hooks_settings_and_grouping_unchanged': True,
    'debug_logging_imports_absent_in_objects': inspected,
    'core_tests': {'foundation_assertions': 2215, 'production_bridge_and_hook_assertions': 528},
    'device_installed': False, 'real_payment_or_messages_sent': False,
}
(out / 'verification.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps(report, ensure_ascii=False, indent=2))
