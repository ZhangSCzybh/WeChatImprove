#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -IControllers -IHeaders -framework Foundation Controllers/CSBackupBootstrap.m Tests/BackupBootstrapTests.m -o "$work/tests"
"$work/tests"
# Logos creates an implicit _logosLocalInit when a file has hooks but no explicit %init,
# even when %ctor exists. Verify every generated feature install is in the barrier block.
python3 - "$work" <<'PY'
import os, pathlib, re, subprocess, sys
root = pathlib.Path.cwd()
theos = pathlib.Path(os.environ.get('THEOS', '/Users/zhangshichao/theos'))
logos = theos / 'bin/logos.pl'
if not logos.is_file():
    raise SystemExit('Logos is required to verify actual hook initialization')
sdk = subprocess.run(['xcrun', '--sdk', 'iphoneos', '--show-sdk-path'], capture_output=True, text=True)
syntax = ['xcrun', '--sdk', 'iphoneos', 'clang++', '-fsyntax-only', '-fobjc-arc', '-fblocks',
          '-target', 'arm64-apple-ios15.0', '-isysroot', sdk.stdout.strip(),
          '-I' + str(root / 'Headers'), '-I' + str(root / 'Hooks'), '-I' + str(root / 'Controllers'),
          '-I' + str(theos / 'vendor/include'), '-F' + str(theos / 'vendor/lib'),
          '-Wno-deprecated-declarations', '-Wno-nullability-completeness']
features = 0
# These use independent encrypted state, outside the configuration backup registry.
# Their native hooks are registered asynchronously, not through the settings-consumer gate.
independent = {'CloseFriendCallHooks.xm', 'CloseFriendCallReplyHooks.xm',
               'CloseFriendContactHooks.xm', 'CloseFriendLifecycleHooks.xm',
               'CloseFriendNotificationHooks.xm', 'CloseFriendProfileHooks.xm',
               'CloseFriendSearchHooks.xm', 'CloseFriendSocialHooks.xm'}
independent_checked = 0
for path in sorted((root / 'Hooks').glob('*.xm')):
    generated = subprocess.check_output([str(logos), str(path)], text=True)
    output = pathlib.Path(sys.argv[1]) / (path.stem + '.mm')
    output.write_text(generated)
    if sdk.returncode == 0:
        compiled = subprocess.run(syntax + [str(output)], capture_output=True, text=True)
        assert compiled.returncode == 0, path.name + ': iOS syntax failed\n' + compiled.stderr
    assert '_logosLocalInit()' not in generated, f'{path.name}: implicit hook constructor bypasses barrier'
    if path.name in ('CustomEntryHooks.xm', 'BackupLifecycleHooks.xm'):
        assert 'CSBackupWhenReady(' not in generated, f'{path.name}: recovery infrastructure must stay available'
        continue
    features += 1
    ctor = generated.index('static __attribute__((constructor))')
    if path.name in independent:
        assert 'dispatch_async(dispatch_get_main_queue(),' in generated[ctor:], f'{path.name}: native registration must be deferred'
        adapter = generated
        if path.name == 'CloseFriendSocialHooks.xm':
            assert 'CSCFSocialInstall();' in generated[ctor:], 'social native adapter must be registered'
            adapter += (root / 'Controllers/CSCloseFriendSocialAdapter.m').read_text()
        assert 'CSCloseFriendInstallHook(' in adapter, f'{path.name}: missing independent native adapter'
        independent_checked += 1
        features -= 1
        continue
    callback = generated.index('CSBackupWhenReady(', ctor)
    assert not re.search(r'\b(?:MSHookMessageEx|MSHookFunction|class_addMethod)\(', generated[ctor:callback]), f'{path.name}: hooks installed before readiness'
    assert 'CSBackupWhenReady(^{ ' in generated[callback:] or 'CSBackupWhenReady(^{\n' in generated[callback:], f'{path.name}: missing guarded init block'
assert independent_checked == len(independent), 'independent native adapters must all be checked'
print(f'Backup bootstrap: Logos generated {features} gated feature files, {independent_checked} independent native adapters and 2 recovery files')
if sdk.returncode == 0:
    compiled = subprocess.run(syntax + ['-x', 'objective-c', str(root / 'Controllers/CSBackupBootstrap.m')], capture_output=True, text=True)
    assert compiled.returncode == 0, 'CSBackupBootstrap.m: iOS syntax failed\n' + compiled.stderr
    print('Backup bootstrap: all generated hooks and bootstrap passed iOS arm64 syntax compilation')
else:
    print('Backup bootstrap: iOS SDK unavailable; target syntax compilation was skipped')
PY
# Objective-C++ hook callers and Objective-C implementation must share C symbol linkage.
cat > "$work/linkage.mm" <<'EOF'
#import "CSBackupBootstrap.h"
NSUInteger CSBackupLinkageCheck(void) { return CSBackupAccountEpoch(); }
EOF
xcrun --sdk macosx clang++ -fobjc-arc -fblocks -IControllers -c "$work/linkage.mm" -o "$work/linkage.o"
nm -u "$work/linkage.o" | rg -q '^_CSBackupAccountEpoch$'
echo 'Backup bootstrap: Objective-C++ C linkage verified'
