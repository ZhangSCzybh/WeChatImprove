#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-manager.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
import sys
from pathlib import Path
source=Path('Controllers/CSMessageNativeActionAdapter.m').read_text().split('@interface NSObject (CSNativeAppPath)',1)[0]
Path(sys.argv[1],'AINativeDispatchUnderTest.m').write_text(source)
Path(sys.argv[1],'AIPreparedSendUnderTest.m').write_text(Path('Controllers/CSMessageSendAdapter.m').read_text().split('@interface CSMessageSendAdapter ()',1)[0])
hooks=Path('Hooks/AIReplyHooks.xm').read_text().replace('../Controllers/','').replace('%ctor {','static void CSAITestInstallHooks(void) {')
Path(sys.argv[1],'AIHooksUnderTest.m').write_text(hooks)
Path(sys.argv[1],'substrate.h').write_text('#import <objc/runtime.h>\nvoid MSHookMessageEx(Class, SEL, IMP, IMP *);\n')
store='#import <Foundation/Foundation.h>\n#include <unistd.h>\nint CSAITestFsync(int);\n#define fsync(...) CSAITestFsync(__VA_ARGS__)\n#include "'+str(Path('Controllers/CSAIReplyStore.m').resolve())+'"\n'
Path(sys.argv[1],'AIStoreUnderTest.m').write_text(store)

PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -Wno-incomplete-implementation \
 -ITests/AIDetailUIKit -IControllers -I"$test_dir" -framework Foundation -framework ImageIO -framework CoreGraphics \
 "$test_dir/AIStoreUnderTest.m" Controllers/CSAIClient.m Controllers/CSAIReplyCoordinator.m Controllers/CSAIMessageAdapter.m Controllers/CSAIBackgroundSync.m \
 Controllers/CSAIImagePreparer.m Controllers/CSAIReplyManager.m Controllers/CSBackupMutation.m Controllers/CSCloseFriendPolicy.m \
 Controllers/CSCloseFriendAutomationProjection.m Tests/AIReplyManagerTests.m -o "$test_dir/tests"
"$test_dir/tests" "$test_dir/state.plist"
