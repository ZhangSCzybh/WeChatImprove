#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-incremental.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
text=(Path(sys.argv[1])/'Controllers/CSGroupListAdapter.m').read_text()
start=text.index('- (void)publishProjection:'); brace=text.index('{',start); depth=0
for end in range(brace,len(text)):
 if text[end]=='{': depth+=1
 elif text[end]=='}':
  depth-=1
  if depth==0: break
(Path(sys.argv[2])/'GroupPublicationBody.h').write_text(text[start:end+1])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSGroupProjection.m" "$project_dir/Controllers/WESessionTabItem.m" \
  "$project_dir/Tests/GroupIncrementalTests.m" -o "$test_dir/tests"
"$test_dir/tests"
