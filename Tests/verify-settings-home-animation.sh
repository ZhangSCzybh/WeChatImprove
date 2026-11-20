#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-settings-home-animation.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, output = map(Path, sys.argv[1:])
source = (root / 'Controllers/CSSettingsHomeAnimator.m').read_text()
assert source.count('#import "CSSettingsHomeAnimator.h"') == 1
# Run the production implementation unchanged against observable UIKit doubles.
# Foundation/CoreGraphics provide the real collections, rectangles and transforms.
source = source.replace('#import "CSSettingsHomeAnimator.h"', '')
(output / 'SettingsHomeAnimatorUnderTest.h').write_text(source)
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -I"$test_dir" \
  "$project_dir/Tests/SettingsHomeAnimatorTests.m" -o "$test_dir/tests"
"$test_dir/tests"
