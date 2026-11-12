#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-automation-native-sync.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
import sys
from pathlib import Path
target=Path(sys.argv[1])
source=Path('Controllers/CSMessageNativeActionAdapter.m').read_text().split('@interface NSObject (CSNativeAppPath)',1)[0]
(target/'NativeDispatchUnderTest.m').write_text(source)
(target/'substrate.h').write_text('#import <objc/runtime.h>\nvoid MSHookMessageEx(Class, SEL, IMP, IMP *);\n')
(target/'NativeSyncManagerAPIs.h').write_text('#import "CSAutomationManager.h"\n@interface CSAutomationManager (NativeSyncFixturePrefix)\n- (void)performNativeSyncForService:(id)service epoch:(NSUInteger)epoch request:(void (^)(id))request;\n@end\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -Wno-incomplete-implementation -IControllers -I"$test_dir" \
 -include "$test_dir/NativeSyncManagerAPIs.h" -framework Foundation \
 "$test_dir/NativeDispatchUnderTest.m" Controllers/CSAutomationNativeSync.m \
 Tests/AutomationNativeSyncTests.m -o "$test_dir/tests"
"$test_dir/tests"
for mode in class-missing setter-result-B setter-argument-I setter-count setter-missing \
 handle-result-B handle-processed-c handle-count handle-missing \
 resume-result-B resume-count resume-missing reset-result-B reset-count reset-missing \
 notify-result-v notify-count notify-missing; do
 "$test_dir/tests" "$mode"
done
for ivar in m_bHasInit m_bNeedSync m_syncEventID m_bSyncOperating \
 m_bIsSyncPause; do
 "$test_dir/tests" "ivar-missing:$ivar"
 "$test_dir/tests" "ivar-type:$ivar"
done
if [[ "${1:-}" == "--ios" ]]; then
 sdk_dir=$(xcrun --sdk iphoneos --show-sdk-path)
 for arch in arm64 arm64e; do
  xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
   -fobjc-arc -fblocks -Wall -Wextra -Werror -IControllers -I"$test_dir" \
   -include "$test_dir/NativeSyncManagerAPIs.h" \
   -c Controllers/CSAutomationNativeSync.m -o "$test_dir/native-sync.$arch.o"
 done
 printf 'Automation native sync iOS: arm64 + arm64e source objects compiled\n'
fi
