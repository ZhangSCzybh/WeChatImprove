#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-message-gesture.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PYEXTRACT'
from pathlib import Path
import sys
root,out=map(Path,sys.argv[1:])
s=(root/'Hooks/MessageGestureHooks.xm').read_text().split('%hook MMContextManager',1)[1].split('%end',1)[0]
s=s.replace('%orig;', '[accountHookOrder addObject:@"native"];')
(out/'GestureAccountHooksUnderTest.h').write_text('@interface MMContextManager : NSObject\n- (void)logout:(id)context;\n- (void)loginByContext:(id)context;\n@end\n@implementation MMContextManager\n'+s+'\n@end\n')
PYEXTRACT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-incomplete-implementation \
 -framework Foundation -framework CoreGraphics -framework CoreFoundation \
 -I"$test_dir" -I"$project_dir/Tests/GestureUIKit" -I"$project_dir/Controllers" \
 "$project_dir/Tests/MessageUIKit/MessageUIKit.m" "$project_dir/Tests/TimeUIKit/TimeUIKit.m" "$project_dir/Tests/GestureUIKit/GestureUIKit.m" \
 "$project_dir/Controllers/CSMessageActionPreferences.m" "$project_dir/Controllers/CSMessageActionContext.m" "$project_dir/Controllers/CSMessageActionPolicy.m" \
 "$project_dir/Controllers/CSMessageGestureAdapter.m" "$project_dir/Controllers/CSMessageCellLifecycle.m" \
 "$project_dir/Tests/ClownLifecycleDouble.m" \
 "$project_dir/Tests/MessageGestureAdapterTests.m" -o "$test_dir/tests"
"$test_dir/tests"
