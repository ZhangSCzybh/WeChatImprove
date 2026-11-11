#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-automation-native.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
import sys
from pathlib import Path
target=Path(sys.argv[1])
source=Path('Controllers/CSMessageNativeActionAdapter.m').read_text().split('@interface NSObject (CSNativeAppPath)',1)[0]
(target/'NativeDispatchUnderTest.m').write_text(source)
source=Path('Controllers/CSMessageSendAdapter.m').read_text().split('- (CSMessagePreparedSend *)prepareContext:',1)[0]+'\n@end\n'
(target/'NativeSendUnderTest.m').write_text(source)
source=Path('Hooks/AutomationHooks.xm').read_text().split('%ctor {',1)[0]
source=source.replace('"../Controllers/','"')
(target/'AutomationIngressUnderTest.m').write_text(source+'\nvoid CSAutomationTestInstallIngressHooks(void){CSAutomationInstallIngressHooks();}\nvoid CSAutomationTestBootstrapIngress(void){CSAutomationBootstrapIngress();}\n')
(target/'substrate.h').write_text('#import <objc/runtime.h>\nvoid MSHookMessageEx(Class, SEL, IMP, IMP *);\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -Wno-incomplete-implementation -Wno-unused-function -IControllers -I"$test_dir" -framework Foundation \
 "$test_dir/NativeDispatchUnderTest.m" "$test_dir/NativeSendUnderTest.m" \
 "$test_dir/AutomationIngressUnderTest.m" Controllers/CSAutomationNativeAdapter.m Tests/AutomationNativeTests.m \
 -o "$test_dir/tests"
"$test_dir/tests"
for mode in guide-I result-Q send-I scene-I; do
 "$test_dir/tests" "$mode"
done
if [[ "${1:-}" == "--ios" ]]; then
 sdk_dir=$(xcrun --sdk iphoneos --show-sdk-path)
 for arch in arm64 arm64e; do
  for source in Controllers/CSAutomationNativeAdapter.m "$test_dir/AutomationIngressUnderTest.m" Controllers/CSMessageSendAdapter.m; do
   xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
    -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function -IControllers -I"$test_dir" \
    -c "$source" -o "$test_dir/$(basename "$source").$arch.o"
  done
 done
 printf 'Automation native iOS: arm64 + arm64e source objects compiled\n'
fi
