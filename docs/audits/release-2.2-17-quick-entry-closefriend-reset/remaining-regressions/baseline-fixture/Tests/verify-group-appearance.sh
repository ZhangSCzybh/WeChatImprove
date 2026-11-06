#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-appearance.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
text=(Path(sys.argv[1])/'Controllers/WESessionTabContainerView.m').read_text()
for name,marker in [('Badge','- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot {'),('Container','- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot forTabIndex:')]:
 start=text.index(marker);brace=text.index('{',start);depth=0
 for end in range(brace,len(text)):
  if text[end]=='{':depth+=1
  elif text[end]=='}':
   depth-=1
   if not depth:break
 (Path(sys.argv[2])/(name+'Body.h')).write_text(text[start:end+1])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation -I"$test_dir" "$project_dir/Tests/GroupAppearanceTests.m" -o "$test_dir/tests"
"$test_dir/tests"
