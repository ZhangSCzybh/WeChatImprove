#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-attachment-layout.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root,out=map(Path,sys.argv[1:]);source=(root/'Hooks/CSChatAttachmentLayout.xm').read_text()
constants=source.split('// 保存设置的键',1)[1].split('// 导入微信',1)[0]
snapshot=source.split('// BEGIN Attachment layout snapshot',1)[1].split('// END Attachment layout snapshot',1)[0]
(out/'AttachmentLayoutSnapshot.inc').write_text(constants+snapshot)
hook=source.split('%hook SelectAttachmentView',1)[1].split('%end',1)[0]
hook=hook.replace('%orig(arg1,arg2)','CSNativeFrame(self,arg1,arg2)').replace('%orig;', 'CSNativeFrame(self,arg1,arg2);')
# layoutSubviews has a different native selector; preserve its independent side effect.
hook=hook.replace('CSNativeFrame(self,arg1,arg2);', 'CSNativeLayout(self);',1)
(out/'AttachmentLayoutMethods.inc').write_text(hook)
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
 -framework Foundation -framework CoreGraphics -I"$test_dir" \
 "$project_dir/Tests/AttachmentLayoutTests.m" -o "$test_dir/tests"
"$test_dir/tests"
