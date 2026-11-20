#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-plugin-header-avatar.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import re, sys
source = (Path(sys.argv[1]) / 'Controllers/CSCustomViewController.m').read_text()
match = re.search(r'^- \(void\)loadHeaderAvatarForAccount:', source, re.M)
if not match:
    raise SystemExit('The production avatar method is missing')
opening = source.index('{', match.start())
depth, end = 1, opening + 1
while depth:
    depth += (source[end] == '{') - (source[end] == '}')
    end += 1
(Path(sys.argv[2]) / 'HeaderAvatarUnderTest.h').write_text(source[match.start():end])
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$test_dir" "$project_dir/Tests/PluginHeaderAvatarTests.m" -o "$test_dir/tests"
"$test_dir/tests"
