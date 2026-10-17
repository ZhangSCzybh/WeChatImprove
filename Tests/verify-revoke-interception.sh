#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-revoke-interception.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'EXTRACT'
from pathlib import Path
import sys
root,out=map(Path,sys.argv[1:])
source=(root/'Hooks/RevokeHooks.xm').read_text()
s=source.split('%hook CMessageMgr',1)[0]
s='\n'.join(l for l in s.splitlines() if not l.startswith('#import'))
def route(section, method, name):
 start=source.index(method,source.index(section));begin=source.index('{',start);depth=0
 for i in range(begin,len(source)):
  if source[i]=='{':depth+=1
  elif source[i]=='}':
   depth-=1
   if not depth:
    body=source[begin+1:i].replace('%orig;', 'return NO;').replace('return;', 'return YES;')
    return 'static BOOL '+name+'(id arg1) {'+body+'}\n'
 raise ValueError(method)
for section,method,name in [('%hook CMessageMgr','- (void)onRevokeMsg:', 'testPrimary'),
 ('%hook MessageRevokeMgr','- (void)onRevokeMsg:', 'testSecondary'),
 ('%hook MessageRevokeMgr','- (void)replaceRevokedMsg:', 'testReplace'),
 ('%hook MessageRevokeMgr','- (void)deleteLocalProcessRevokeMsgWithToast:', 'testDelete')]:
 s+='\n'+route(section,method,name)
(out/'RevokeUnderTest.h').write_text(s)
EXTRACT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-function -Wno-unused-parameter \
 -framework Foundation -I"$project_dir/Controllers" -I"$test_dir" \
 "$project_dir/Controllers/CSRevokeReference.m" \
 "$project_dir/Tests/RevokeInterceptionTests.m" -o "$test_dir/revoke-tests"
"$test_dir/revoke-tests"
