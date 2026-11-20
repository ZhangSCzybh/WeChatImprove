#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-settings-home-theme.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
source=(Path(sys.argv[1])/'Controllers/CSSettingsHomeTheme.m').read_text()
(Path(sys.argv[2])/'SettingsHomeThemeUnderTest.h').write_text(source.replace('#import "CSSettingsHomeTheme.h"',''))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -I"$test_dir" \
  "$project_dir/Tests/SettingsHomeThemeTests.m" -o "$test_dir/tests"
"$test_dir/tests"
