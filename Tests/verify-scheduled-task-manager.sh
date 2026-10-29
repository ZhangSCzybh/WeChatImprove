#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-scheduled-manager.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
import sys
from pathlib import Path
out=Path(sys.argv[1])
source=Path('Controllers/CSMessageNativeActionAdapter.m').read_text().split('@interface NSObject (CSNativeAppPath)',1)[0]
(out/'ScheduledNativeDispatchUnderTest.m').write_text(source)
# Compile the real scheduled-send factory and prepared route, omitting unrelated media routes.
source=Path('Controllers/CSMessageSendAdapter.m').read_text().split('- (CSMessagePreparedSend *)prepareContext:',1)[0]
(out/'ScheduledSendUnderTest.m').write_text(source+'\n@end\n')
(out/'ScheduledStoreUnderTest.m').write_text('#import <Foundation/Foundation.h>\n#include <unistd.h>\nint CSScheduledTestFsync(int);\n#define fsync(...) CSScheduledTestFsync(__VA_ARGS__)\n#include "'+str(Path('Controllers/CSScheduledTaskStore.m').resolve())+'"\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-incomplete-implementation -Wno-unused-function \
  -DCS_SCHEDULED_STORE_TRACK_MUTATIONS=1 -ITests/AIDetailUIKit -IControllers -I"$test_dir" -framework Foundation \
  "$test_dir/ScheduledStoreUnderTest.m" Controllers/CSBackupMutation.m Controllers/CSScheduledTaskManager.m Controllers/CSCloseFriendPolicy.m \
  Controllers/CSCloseFriendAutomationProjection.m Tests/ScheduledTaskManagerTests.m -o "$test_dir/tests"
"$test_dir/tests" "$test_dir/data"
