#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-transfer-admission.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys,re
root,out=map(Path,sys.argv[1:]);s=(root/'Hooks/ReceiveTransferHooks.xm').read_text()
keys='\n'.join(re.findall(r'static NSString \* const kReceiveTransfer(?:Auto|Private|Group)EnableKey[^;]+;',s))
functions=s[s.index('static BOOL isReceiveTransferEnabled()'):s.index('static NSInteger getDelaySeconds()')]
hooks=s.split('%hook CMessageMgr',1)[1].split('%end',1)[0].replace('%orig;','nativeCalls++;')
(out/'TransferAdmissionUnderTest.h').write_text('static atomic_bool transferAdmissionEnabled;\n'+keys+'\n'+functions+'\n@interface TestMessageMgr : NSObject\n@end\n@implementation TestMessageMgr\n'+hooks+'\n@end\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -framework Foundation -I"$project_dir/Controllers" -I"$test_dir" "$project_dir/Tests/TransferAdmissionTests.m" -o "$test_dir/tests"
"$test_dir/tests"
