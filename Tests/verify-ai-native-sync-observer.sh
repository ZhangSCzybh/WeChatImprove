#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-native-sync-observer.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
import sys
from pathlib import Path
target=Path(sys.argv[1])
source=Path('Controllers/CSMessageNativeActionAdapter.m').read_text().split('@interface NSObject (CSNativeAppPath)',1)[0]
(target/'AINativeDispatchUnderTest.m').write_text(source)
(target/'substrate.h').write_text('#import <objc/runtime.h>\nvoid MSHookMessageEx(Class, SEL, IMP, IMP *);\n')
# The manager integration may be edited concurrently; this fixture supplies only
# the two observer-facing declarations and stubs their implementation itself.
(target/'ObserverManagerAPIs.h').write_text('#import "CSAIReplyManager.h"\n@interface CSAIReplyManager (ObserverFixturePrefix)\n- (id _Nullable)captureBackgroundSyncContextForEpoch:(NSUInteger)epoch;\n- (void)nativeFullSyncCompletedWithContext:(id _Nonnull)context;\n@end\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
 -Wno-incomplete-implementation -IControllers -I"$test_dir" \
 -include "$test_dir/ObserverManagerAPIs.h" -framework Foundation \
 "$test_dir/AINativeDispatchUnderTest.m" Controllers/CSAINativeSyncObserver.m Controllers/CSBackgroundSyncBudget.m Tests/AINativeSyncObserverTests.m \
 -o "$test_dir/tests"
"$test_dir/tests"
for mode in create-return-c create-argument-Q create-argument-count return-result-B return-event-Q handle-result-B handle-processed-c; do
 "$test_dir/tests" "$mode"
done
if [[ "${1:-}" == "--ios" ]]; then
 sdk_dir=$(xcrun --sdk iphoneos --show-sdk-path)
 for arch in arm64 arm64e; do
  xcrun --sdk iphoneos clang -target "$arch-apple-ios15.0" -isysroot "$sdk_dir" \
   -fobjc-arc -fblocks -Wall -Wextra -Werror -IControllers -I"$test_dir" \
   -include "$test_dir/ObserverManagerAPIs.h" -c Controllers/CSAINativeSyncObserver.m -o "$test_dir/observer.$arch.o"
 done
 printf 'AI native sync observer iOS: arm64 + arm64e source objects compiled\n'
fi
