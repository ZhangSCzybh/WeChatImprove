#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-header-verse-entry.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import re, sys
source = (Path(sys.argv[1]) / 'Controllers/CSCustomViewController.m').read_text()
methods = []
for name in ['viewWillAppear:', 'refreshHeaderVerse', 'settingsDidChange:', 'refreshHeaderFromNotification:']:
    match = re.search(r'^- \([^)]+\)' + re.escape(name) + r'(?=[ (:{])', source, re.M)
    if not match:
        raise SystemExit('Missing real controller method: ' + name)
    opening = source.index('{', match.start())
    depth, end = 1, opening + 1
    while depth:
        depth += (source[end] == '{') - (source[end] == '}')
        end += 1
    methods.append(source[match.start():end])
(Path(sys.argv[2]) / 'HeaderVerseEntryUnderTest.h').write_text('\n'.join(methods))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -framework Foundation \
  -I"$project_dir/Controllers" -I"$test_dir" \
  "$project_dir/Tests/PluginHeaderVerseEntryTests.m" -o "$test_dir/tests"
"$test_dir/tests"
