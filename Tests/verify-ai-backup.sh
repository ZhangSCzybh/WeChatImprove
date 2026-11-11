#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-ai-backup.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
from pathlib import Path
import sys
source=Path('Controllers/CSBackupManager.m').read_text()
methods=[]
for selector in ('- (void)preview:', '- (void)prepare:'):
    start=source.index(selector);opening=source.index('{',start);depth=1;end=opening+1
    while depth:
        depth+=(source[end]=='{')-(source[end]=='}');end+=1
    methods.append(source[start:end])
Path(sys.argv[1],'AIBackupManagerBoundary.h').write_text('\n'.join(methods))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -IControllers -I"$test_dir" -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
  Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m \
  Controllers/CSPluginStorage.m Controllers/CSBackupStore.m Controllers/CSManagedImageFile.m \
  Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m Controllers/CSScheduledTaskStore.m Controllers/CSAIReplyStore.m Controllers/CSGroupChatStore.m Controllers/CSGroupChatTemplate.m \
  Tests/AIReplyBackupTests.m -o "$test_dir/tests"
"$test_dir/tests" "$test_dir/Library/Preferences/WeChatImprove"
