#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d "${TMPDIR:-/tmp}/wechat-scheduled-backup.XXXXXX")
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSBackupManager.m').read_text()
methods=[]
for selector in ('- (void)preview:', '- (void)prepare:'):
    start=source.index(selector);opening=source.index('{',start);depth=1;end=opening+1
    while depth:
        depth+=(source[end]=='{')-(source[end]=='}');end+=1
    methods.append(source[start:end])
Path(sys.argv[1],'ScheduledBackupManagerBoundary.h').write_text('\n'.join(methods))
store=Path('Controllers/CSScheduledTaskStore.m').resolve()
Path(sys.argv[1],'ScheduledStoreUnderTest.m').write_text('#import <Foundation/Foundation.h>\n#include <unistd.h>\nint CSScheduledBackupFsync(int);\n#define fsync(...) CSScheduledBackupFsync(__VA_ARGS__)\n#include "'+str(store)+'"\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -DCS_SCHEDULED_STORE_TRACK_MUTATIONS=1 -IControllers -I"$work" -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
  Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m \
  Controllers/CSPluginStorage.m Controllers/CSBackupStore.m Controllers/CSManagedImageFile.m \
  Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m "$work/ScheduledStoreUnderTest.m" Controllers/CSAIReplyStore.m Controllers/CSGroupChatStore.m Controllers/CSGroupChatTemplate.m \
  Tests/ScheduledTaskBackupTests.m -o "$work/tests"
"$work/tests" "$work/Library/Preferences/WeChatImprove"
